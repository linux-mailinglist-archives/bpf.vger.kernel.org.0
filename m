Return-Path: <bpf+bounces-32538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292B90F8ED
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40661F235D4
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC4315B0EE;
	Wed, 19 Jun 2024 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EmOWQYDw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ufGS/fHL"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C528F7C6EB;
	Wed, 19 Jun 2024 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718836041; cv=none; b=JvjqRDkpaPYW2dSR+/AGKfbZEblIvO67QaKU+UENmEdW1wo3iazb5Wb5rZsM7BreWDJ+osaH2+fnwjrpwSSTVoJ6oNuZ+ZP23iJ7ALlnKfz7YjZmokSvhnb696ZUqlL2b0VPzN1u1scZZHRZTfaIKAEZKtJ+pLHtkP9Yxqc6/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718836041; c=relaxed/simple;
	bh=LcjFPAmv3ZgcopZ3asT6Wbl3AYdzxqSF8MieOtxMDoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E+INiYqNGUNpPUnKZN4qTtOK+VRnumn/KuT5yZBkNbsjkltSARfkqWa15VYYbkTiybNykktWJ64HEs8Pb4sQMFWaNzkFWzvZPm1x+Pktt8L7QTYUIyHQZRrgrzdOdnYB7VtZTnmiDD2Ww/EveWfN+mUFLhHNwI7UPG54nWduNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EmOWQYDw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ufGS/fHL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718836037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Np4GRDxBROgfQOBaAEEl5F0XDhVrQ/pacI5wmlASWvg=;
	b=EmOWQYDwz1Oc6mYYBtiGixRa9Wj+njMg0v/RvyAyCCCQL4dz3ZB5soAKfcvAUbHP2uBU9/
	i+cjm8ZK9QtLZaAnVy5R3LutdhYzEUq4x7AQE6IVKAIH0YdOO8N0ZMhljzOkAl6pvfC2PK
	D7zcOkJcII5tbBg+QsVdwxrYo+9Ll5a5Ed0smbWUKZzaUIO8Vtb/WEl8yUTMrLU+x9D4h/
	kTDld0ptPKYvifKNkBUqaW6bnQerBxIUeCSi22WIauLOzrB9IKFeOv51z6e842h5kevlDn
	6rWOBv75+xmMgpAs4aXq0eDbEBoxE7BGYUi46M/SMxI1bTSguhXi1Sba62RmcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718836037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Np4GRDxBROgfQOBaAEEl5F0XDhVrQ/pacI5wmlASWvg=;
	b=ufGS/fHLtO3APwyHEFUa0lk7dNe923RdycRqiWibJ3tyUfEnesa9RA4oVPTHg0zZu05Fs7
	7fGLvtxQ0IA0AUDQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 joshdon@google.com, brho@google.com, pjt@google.com, derkling@google.com,
 haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
 dskarlat@cs.cmu.edu, riel@surriel.com, changwoo@igalia.com,
 himadrics@inria.fr, memxor@gmail.com, andrea.righi@canonical.com,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
In-Reply-To: <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
Date: Thu, 20 Jun 2024 00:27:16 +0200
Message-ID: <87bk3wpnzv.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus!

On Wed, Jun 19 2024 at 15:10, Linus Torvalds wrote:
> On Wed, 19 Jun 2024 at 13:56, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> So instead of "solving" this brute force and thereby proliferating the
>> non-constructive situation, can you please hold off with that plan to
>> merge it as is and give us three month to get this onto a collaborative
>> and constructive track?
>
> The thing is, I have seen absolutely _nothing_ in the last 9 months or
> so.

Right, but that applies to both sides, no?

> So to me, "three more months" sounds like just delay.

Three months delay are well worth to give it try, but that's your
decision.

Thanks,

        Thomas

