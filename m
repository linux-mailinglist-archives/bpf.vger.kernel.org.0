Return-Path: <bpf+bounces-32537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E6290F8D9
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6472839D3
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5BE15B125;
	Wed, 19 Jun 2024 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LMqK4NqT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE77F7D3
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718835057; cv=none; b=fH3l55rCrvu0pLNngFLTlfH2+2qoJiHNFwb8w5zFhIZvS3HStE5ZUisbsHb02jI+rhNLUXaGWVG9wQzmt49OwppY1ADsAOPDZa05lyHUz3aZnzbigrE2uE+7sgvfsb7GrnqaNNVz3woPTaThIIuoo/fSRGx0cZWaHgPBPhG5QI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718835057; c=relaxed/simple;
	bh=/8duXVmUwY78tqC2oHwML1diQjLonOWr0Eu83ghH19U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lbo97Mf+3InN/iKvwz/yzRB0/alsHPh0Zqago2rzbaLtOIXkBqq4E5mlUMO2C3tiuhrpkO3b5YF727nYLAJ7wJJaXZaY0aWH6wM2irZBSn59auub0ddRVpQo68XxC46Egm8Ko2T8gVxX5k/Q15lOdIPVK1fniEkK8YyTUVYGAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LMqK4NqT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c9034860dso269648e87.2
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718835054; x=1719439854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bAIy7NXQ9HJqRfrqfLw5oJNnDiX02UKX+K0DASgrWxo=;
        b=LMqK4NqT6V5HoegJ8woeeYuGypjEjKXJUDmlGjvO/LTsFwypL/P66sgVWE1Y5xxptf
         AMHZoVdkZN85N2MmkKl8Wq+F/aa6cq3jfywi4TMVSEdN4D75CeiX9L3syF6D9JlPOF16
         eMt3YGUrIHpOwMZZRzDSbyvgGTzUrq0DuBOXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718835054; x=1719439854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAIy7NXQ9HJqRfrqfLw5oJNnDiX02UKX+K0DASgrWxo=;
        b=WDehsd+5R7Cd2Js17jrJLsI3QMTlL6EkeQH2iUDguQ2qjMf7bvSXjbrKyPvIQhmtX3
         1BZPrlOs9x9tBqUtgGj9ygsagL9wT+LYOTdbcPJQcYdB0UHaJJLrkRI06LpS8kjzOwFL
         JA77Xnf4tCV5SWhbj8HxRA/TpKXcr2jbtspO0R/mUlZ95tV4QsxMOM9hQHQPfWlL4X3W
         sr/tQbVVSo9ZS+ilx9gHreJ7E8uEGMMpsr4PULKeY0W9Nano+szyWj1/DXzWnTIUHfpc
         ySiis8cdimT6IYUsG2WqbjTZIAXlFkykiJd4RhTxDbGvS90O2cIdi3MR1x8KxP37OvDo
         av8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcQZhiPZJkboCVUsDiP2kRjJN7re3M19UN9CqStGOPQR1OZwHQlaIk+++Ma+Nnuwj4n7Vi2uso9nRP7cdWhGIk5AzY
X-Gm-Message-State: AOJu0YwSU19U7AFQO+j6sEMQTFtd3eBgIAGV923c4o4fUu9urLRt6xIb
	DJtahx5+IDdnAxTK1/uWtxWkIBG3Z4++8XkE+YA4HyozQBDtUQ/S+H66w8Xn7xknEl5j6fMHavP
	fV0o4HQ==
X-Google-Smtp-Source: AGHT+IFWm67xwYPRSQ4JZ8+G8HVh0MZFXPcJVFMIQUPNFzgR/yFcsO0L16tsAeR3T5LW4Vf0Poh/Lw==
X-Received: by 2002:a05:6512:280e:b0:52c:8b69:e039 with SMTP id 2adb3069b0e04-52ccaa2a937mr3140481e87.4.1718835054210;
        Wed, 19 Jun 2024 15:10:54 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ccdbc84casm172837e87.69.2024.06.19.15.10.53
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 15:10:53 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso224240e87.1
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 15:10:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXC/7bB8faAlIi461BuFZs3qVvFZpPyf/BuPQwZoClt2F3zBVJZuot0e0g8zxuQ4DgWDUajEQpSDOQf2AgJ9L2RDpVM
X-Received: by 2002:a19:8c14:0:b0:52b:fac5:a3e9 with SMTP id
 2adb3069b0e04-52ccaa2abb9mr2687575e87.9.1718835032031; Wed, 19 Jun 2024
 15:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
In-Reply-To: <87ed8sps71.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 15:10:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
Message-ID: <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 13:56, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> So instead of "solving" this brute force and thereby proliferating the
> non-constructive situation, can you please hold off with that plan to
> merge it as is and give us three month to get this onto a collaborative
> and constructive track?

The thing is, I have seen absolutely _nothing_ in the last 9 months or so.

So to me, "three more months" sounds like just delay.

            Linus

