Return-Path: <bpf+bounces-72172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD5C085BC
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 01:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 581EA4E5663
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 23:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9EE30F532;
	Fri, 24 Oct 2025 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoVhBWG+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3330E83A
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761350253; cv=none; b=F9gzuTRqadBCX+pe0Zqb24IoIs/6dR8NRyqAB4jbhupR0G16iaAh+jxziz+rqTkHCBB2mng0UWmL3i8fbxHqlPAP5XJnriPyRs+WYsqtX67zddwJVap1dNHKrctk/rncYSzNpCVC8IhwH32ZG2+NvePXqUX30K3wC35HnLk9p4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761350253; c=relaxed/simple;
	bh=dNKLlMrwd1/HZexcmyJUATq+vFaKLMO+fNIoDoZR3Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFx7DfcEGC1c8ga9Y/O4IlZObgNsvAdDFz94exujdVm4msX+VipqP7aKR1/WLIs0QZLv1N4PFwU1bAGeeW92X81FDD4vbh1mWyKlElu98/LHYixTT4bh0wVZr+8qml1G/52qIopRN8xse46d6vgCkJFHApvY5Q70443TG07Iiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoVhBWG+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42421b1514fso1746340f8f.2
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 16:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761350250; x=1761955050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNKLlMrwd1/HZexcmyJUATq+vFaKLMO+fNIoDoZR3Os=;
        b=HoVhBWG+RL22HhNsNbkwL1itfboESzkPwb+wNLo5TTZKyF4cMd2WBZGBokGp34aiSI
         pWbDx325z8KfQ5S44WBp2ZW3ab4dF9cTTSHwwg5Dayb3jbIv0tPoB7YAccMnG+wRJ79e
         PZiP0vQ//ronUNsxz1jsfpCn7GrWnsGZh7ba0GDuL+f7qgJnH17/vGLbI5sE9jwxgmPW
         BBCerzau29H0vZAbfdWn9HVyWtl8ExNAC5KJMuLEZD78+cfjeH5xhufMDOSPaA1OVPwG
         y6QQ9UXkCpP3gThKSPDzmv+M7BKKc2qG1Q2k+ZMdqJeqqm1H64R/GLXD1WUA6vEJadQ3
         mt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761350250; x=1761955050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNKLlMrwd1/HZexcmyJUATq+vFaKLMO+fNIoDoZR3Os=;
        b=YqKV2lxM7GAYVjB14cIS9TqoXZ7uv2wgPxLBGN3rjB8IQpvRc3u9qQtju5MtGRbwap
         dUnPQeuETbMSxduvBs7y6ZfM3NG85GLjLi2ODNhHRCYHsdKr84AAjxVOBqg8Snnjn2/2
         JHniBK970KJ3JMqH/wmr9X804NJAaAbkDxlvCrKYAKvh6iTICL9bpuAAmj5dsfxBU+Mm
         /jrohyOVYEDl7S6Jtan6LcV9maQoZ/7GNv8v1j8JOmdwYS3GxxepjyX3ob1HQONObOS/
         ydoTLLYU0SjPBh2RE+BOylcpcTgweP5Ve56eMuVQxNpAUQseZo50Df49yAjeeLWp76vT
         Th9w==
X-Forwarded-Encrypted: i=1; AJvYcCU5QB+QIX8+/7UR0AMg41MlcLVtL1iPOw3JHzNSauaivrAoU//XPK2ifhdJgtmPWN1qltY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKxV2D3GOgK4o1ut5WBcBsS2F7F8oSkHB4rITRGggTPR9IlJn
	jq2nU/ErolFzbzOTaTbqnt7IrHyqBYckJwCyS9kJ0jI0uVl7pSRcCWY5+Z00doMPmSGaVL+3lg4
	srxAlD+0cOJ2WojN5/culu4nbZY/yaks=
X-Gm-Gg: ASbGncuuD6OxyfOXC0Y3xCh8jaTi+4E78UbKcRxIngTd3cQXxtQTSPpPlu53aWztQtt
	0kgLGJ0xVP/xv9mdp3Hnc15SDB3ACgEf1pSxakfPtLA/j33kkISlbgjPzFJarRq32md1x5C1nWS
	xH0kiM4xgXrOUCtNe5XQTVksrq8tiA5bm1nAlcs6cqrzOHP8vSP8SgH79+WbY/8NAc5F63YX3/P
	TR+/9XlLNN0U21yPO5nc7Snof4J0aE0jZb8VyH7yf3a61G3hGlVU0Zw97JNEoJIERiWw/Bsc5jh
	ZCwQJXjVnsS1y4fVxLupsU+g+4FK
X-Google-Smtp-Source: AGHT+IF8HoLxCsbxFn0Q05QHNEFaH5LN/KgcQUuwi/NFCX+hm+nzFT1ZjELINl1AgyfVOFTyiPf1ZTpt2LmAPKbOJ38=
X-Received: by 2002:a5d:5f55:0:b0:427:5ed:296d with SMTP id
 ffacd0b85a97d-42990712615mr3163617f8f.28.1761350249591; Fri, 24 Oct 2025
 16:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 16:57:18 -0700
X-Gm-Features: AWmQ_bltQWl9Zt65mlT3O0wfqqWroGd-22lI3adDJdCXk0hQ4ymeHmC7hV8Eb1Q
Message-ID: <CAADnVQKYDgwgAQ+geFrY=xDxNoe2YuEYVQU+d3V3nMhkMBg1zw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/19] slab: replace cpu (partial) slabs with sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Percpu sheaves caching was introduced as opt-in but the goal was to
> eventually move all caches to them. This is the next step, enabling
> sheaves for all caches (except the two bootstrap ones) and then removing
> the per cpu (partial) slabs and lots of associated code.
>
> Besides (hopefully) improved performance, this removes the rather
> complicated code related to the lockless fastpaths (using
> this_cpu_try_cmpxchg128/64) and its complications with PREEMPT_RT or
> kmalloc_nolock().
>
> The lockless slab freelist+counters update operation using
> try_cmpxchg128/64 remains and is crucial for freeing remote NUMA objects
> without repeating the "alien" array flushing of SLUB, and to allow
> flushing objects from sheaves to slabs mostly without the node
> list_lock.
>
> This is the first RFC to get feedback. Biggest TODOs are:
>
> - cleanup of stat counters to fit the new scheme
> - integration of rcu sheaves handling with kfree_rcu batching

The whole thing looks good, and imo these two are lower priority.

> - performance evaluation

The performance results will be the key.
What kind of benchmarks do you have in mind?

