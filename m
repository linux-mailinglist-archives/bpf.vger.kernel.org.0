Return-Path: <bpf+bounces-77382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DF4CDA6F7
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 20:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8DFD301E6C5
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 19:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE61E34C154;
	Tue, 23 Dec 2025 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F/rehiH6"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228E34C141
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766519898; cv=none; b=nQvyrFv2rOiOlICkk56bixdq1EtBAkosau3KS6519mFiVbtWpy7lXKGZwNBgsjjhSLS4Ybt1EnXdJfEhm4it0Y8Cfit8xIfw9f7GnxlpoTnHG1hiHXzJN2mfh2xe2RH9noXeiG29YmC+HJRxnm02LQUXihLZtbazCL+jMuRetdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766519898; c=relaxed/simple;
	bh=jayJDaIW52RZtvsAELDIgDrsE8pmn6tclJ60MrbQt14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rrzuneTZjodld3yrAg675k+qTdHx1SQjWTtAiywJ7XjYzGzn40/xUWLSEtbEyMSik5mXQBHyFIl32nu+RLOX8n1xI9jVeOHECOtJDQQCahJusta++Bi0MxyQof5HAoGHKzD2GsTtyLlLWo9lobDCA0h/3RZss3C+MM0K9DuOU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F/rehiH6; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766519884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypZ04WzUZcjv8chBde4W5E+WNGEjNP6J/99avXKgkYQ=;
	b=F/rehiH61vSusu5N50yrYz2fWEYreVEnoYWl0HxPAq9CqRjLcZRmKlbE5W8REAHNOb2H3P
	JZj/AH9T/SKZl7ECOLFegKmiz/e2XduXJkbr+IhEghYpt4nxLF51Bt7T4190/v1o83Vndq
	pLf0wFHrtWKTJ1B7ZS8E+Rdi/mwQxCE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,  bpf
 <bpf@vger.kernel.org>,  linux-mm <linux-mm@kvack.org>,  LKML
 <linux-kernel@vger.kernel.org>,  JP Kobryn <inwardvessel@gmail.com>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Shakeel Butt <shakeel.butt@linux.dev>,  Michal
 Hocko <mhocko@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v4 0/6] mm: bpf kfuncs to access memcg data
In-Reply-To: <CAADnVQLAFav8czDjCYPyjDK6Bj7X_L70WQ0eSFTwvsxxEXDzCw@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 23 Dec 2025 09:25:35 -1000")
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
	<CAADnVQLAFav8czDjCYPyjDK6Bj7X_L70WQ0eSFTwvsxxEXDzCw@mail.gmail.com>
Date: Tue, 23 Dec 2025 11:57:53 -0800
Message-ID: <875x9xt1ha.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Dec 22, 2025 at 6:42=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
>>
>> Introduce kfuncs to simplify the access to the memcg data.
>> These kfuncs can be used to accelerate monitoring use cases and
>> for implementing custom OOM policies once BPF OOM is landed.
>>
>> This patchset was separated out from the BPF OOM patchset to simplify
>> the logistics and accelerate the landing of the part which is useful
>> by itself. No functional changes since BPF OOM v2.
>>
>> v4:
>>   - refactored memcg vm event and stat item idx checks (by Alexei)
>
> Applied yesterday.

Thank you!

> pw-bot seems to be completely broken. No notifications for the last few d=
ays.

Yep, also there were some infra issues in the ci output... Something
about git being unavailable.

