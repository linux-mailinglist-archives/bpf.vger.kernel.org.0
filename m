Return-Path: <bpf+bounces-53999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A42DA6019E
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A941421DB9
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024001F3FD3;
	Thu, 13 Mar 2025 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMHZEq3m"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E961F37C5
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895581; cv=none; b=PhxKUXha84nDGHRDK9cmIcbfKKLD+VOpoqYEeaqURM8KCRBtJJjHmuVA9kjxXtHp8kBKQpz/ADfkOaOu5kxLpEeruaGtmb0uupeF616CSjSqJsJF88fmfa9bOOdpuuiLEaboyE5vxE4l6FjgilpJmD7searfqLS30+cszuOD3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895581; c=relaxed/simple;
	bh=ssrY+rvJTsOIek9mChfxY5TLNOw4wZX11HmnNeMPqsw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N+/jlWM16Zeao7hKgwK3AWTHvYp5DUOGGbEjZU8PnErqoPvn+iw9tHdAA1DQE042S/DMPp2+yBcoo88Ki/WHw4GkFQgcE2jfcKCY+ZhqVvCPHK+QVEkTjBJ49v2kW2aKQfMeru/PFQpETlrGe69u2l6e4GD4YV9+8Ua281XWpXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMHZEq3m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741895578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5Rwgf9qGOGXudkqHlAtuBTuQYQzfN70qYMcLMsFPhA=;
	b=dMHZEq3mSz9/v6XNkF0OJJ7iKzYhaQUbXiCLeMwc+DHgDLUcLq95GIJory+9EtJfPMF+LT
	vv3eWgcPaz6lDhLKgrHWiNkf2VOWuyMcC4oY1+thLTux1mZgciS+6SCrpP55kr9UZOF48Y
	rLsJLRRMfTQjA11ceU+t05EhJYAJd6Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-fVCiQ8h1NviA7Wil6HoYqQ-1; Thu, 13 Mar 2025 15:52:57 -0400
X-MC-Unique: fVCiQ8h1NviA7Wil6HoYqQ-1
X-Mimecast-MFC-AGG-ID: fVCiQ8h1NviA7Wil6HoYqQ_1741895576
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5498d2a8b88so708160e87.1
        for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 12:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741895576; x=1742500376;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5Rwgf9qGOGXudkqHlAtuBTuQYQzfN70qYMcLMsFPhA=;
        b=Ehlcih/O9op+zYO+7o6O9Or2YswigleU3Ng9X2ik/nvrTpZOoqwVraO0MolBLiKT75
         lsNipC32jCOW0mitCC9tfp3tHcBym9Y73sAAGmWelH1a/vF7uv2hz9Jxjyf3nvYVhmoc
         sbAsIVhYUXu3GhU+XGNcFAD+4ZUDuEnYUi9/9ZidExfgIUbLFQoXFEVaTVWZpNSxaeXL
         Ff1XShQx3B7b9FWd5Hduvtmnjj/BiHNgqNtlsrpjcqp2XZyXiJUhB/sfo6nSIKOBkYuC
         Ur/+g6o8qFqJRp8bfcdJypIMa/I0esLrsyL+/2QBsrKKy7zZXbduQov9Ydt9JG6c7pio
         uU1A==
X-Gm-Message-State: AOJu0Yw6+vsLpI0jpohHZ6c99FxBzKPha1QPsHvFKNFi/PVQp04eadpg
	RYBY7mg7BetXvqAV9JQhfsqWLXE+oOPtTVSmKpPTTcFtdNAA3LEuyTDmcJQEnbryKe4TIuTHUoV
	Mj68ovm5KTAb8wto3y2U+0Je7WfRuFDHQfancLvwEjJ/iJVSfZg==
X-Gm-Gg: ASbGncs+tkBhnb3fJKzDbRVttPFmQH7MI0sijxtMdIqqpmvTHxi+CMTMCadow+3KbiS
	W4lHSDGbjgwbZMD2O1U+kCj4L3IWeDy13U2dXAQVXapp2uvPckb5oEUwGxXnZV5e12xSlyCCpf+
	rATsVaIC1JJxr9R2xfT4iIzWVbWngJzZ1POL6JIUdrYLTQ4ZyMeOvmdfg7VMZggyNgl5xy9ISW6
	ktI2Y8kfc5kxdtPUc4ng+Unx1s69iMoS5fJWqoVcuHunhSzTI+6O68Sqt2sbDkw/BXqIuvOiyWP
	k/0FaZqHbAnp
X-Received: by 2002:a05:6512:3d0b:b0:549:7354:e4d1 with SMTP id 2adb3069b0e04-549c0a69cc9mr347165e87.38.1741895575592;
        Thu, 13 Mar 2025 12:52:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgazDuCvmszGomPJv4QwZuDgkCkfCLmqsdzf5Js6CYZfrk531WhEOt+lFCcA3MgDrafjMpgQ==
X-Received: by 2002:a05:6512:3d0b:b0:549:7354:e4d1 with SMTP id 2adb3069b0e04-549c0a69cc9mr347149e87.38.1741895575138;
        Thu, 13 Mar 2025 12:52:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a79a9sm302680e87.221.2025.03.13.12.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:52:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 43E5618FA899; Thu, 13 Mar 2025 20:52:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, kuba@kernel.org,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 sinquersw@gmail.com, jiri@resnulli.us, stfomichev@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 yepeilin.cs@gmail.com, ameryhung@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v5 00/13] bpf qdisc
In-Reply-To: <20250313190309.2545711-1-ameryhung@gmail.com>
References: <20250313190309.2545711-1-ameryhung@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 13 Mar 2025 20:52:50 +0100
Message-ID: <87bju4u2r1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amery Hung <ameryhung@gmail.com> writes:

> Hi all,
>
> This patchset aims to support implementing qdisc using bpf struct_ops.
> This version takes a step back and only implements the minimum support
> for bpf qdisc. 1) support of adding skb to bpf_list and bpf_rbtree
> directly and 2) classful qdisc are deferred to future patchsets. In
> addition, we only allow attaching bpf qdisc to root or mq for now.
> This is to prevent accidentally breaking exisiting classful qdiscs
> that rely on data in a child qdisc. This limit may be lifted in the
> future after careful inspection.
>
> * Overview *
>
> This series supports implementing qdisc using bpf struct_ops. bpf qdisc
> aims to be a flexible and easy-to-use infrastructure that allows users to
> quickly experiment with different scheduling algorithms/policies. It only
> requires users to implement core qdisc logic using bpf and implements the
> mundane part for them. In addition, the ability to easily communicate
> between qdisc and other components will also bring new opportunities for
> new applications and optimizations.
>
> * struct_ops changes *
>
> To make struct_ops works better with bpf qdisc, two new changes are
> introduced to bpf specifically for struct_ops programs. Frist, we
> introduce "__ref" postfix for arguments in stub functions in patch 1-2.
> It allows Qdisc_ops->enqueue to acquire an unique referenced kptr to the
> skb argument. Through the reference object tracking mechanism in
> the verifier, we can make sure that the acquired skb will be either
> enqueued or dropped. Besides, no duplicate references can be acquired.
> Then, we allow a referenced kptr to be returned from struct_ops programs
> so that we can return an skb naturally. This is done and tested in patch 3
> and 4.
>
> * Performance of bpf qdisc *
>
> This patchset includes two qdisc examples, bpf_fifo and bpf_fq, for
> __testing__ purposes. For performance test, we compare selftests and their
> kernel counterparts to give you a sense of the performance of qdisc
> implemented in bpf.
>
> The implementation of bpf_fq is fairly complex and slightly different from
> fq so later we only compare the two fifo qdiscs. bpf_fq implements a=20
> scheduling algorithm similar to fq before commit 29f834aa326e ("net_sched:
> sch_fq: add 3 bands and WRR scheduling") was introduced. bpf_fifo uses a
> single bpf_list as a queue instead of three queues for different
> priorities in pfifo_fast. The time complexity of fifo however should be
> similar since the queue selection time is negligible.
>
> Test setup:
>
>     client -> qdisc ------------->  server
>     ~~~~~~~~~~~~~~~                 ~~~~~~
>     nested VM1 @ DC1               VM2 @ DC2
>
> Throghput: iperf3 -t 600, 5 times
>
>       Qdisc        Average (GBits/sec)
>     ----------     -------------------
>     pfifo_fast       12.52 =C2=B1 0.26
>     bpf_fifo         11.72 =C2=B1 0.32=20
>     fq               10.24 =C2=B1 0.13
>     bpf_fq           11.92 =C2=B1 0.64=20
>
> Latency: sockperf pp --tcp -t 600, 5 times
>
>       Qdisc        Average (usec)
>     ----------     --------------
>     pfifo_fast      244.58 =C2=B1 7.93
>     bpf_fifo        244.92 =C2=B1 15.22
>     fq              234.30 =C2=B1 19.25
>     bpf_fq          221.34 =C2=B1 10.76
>
> Looking at the two fifo qdiscs, the 6.4% drop in throughput in the bpf
> implementatioin is consistent with previous observation (v8 throughput
> test on a loopback device). This should be able to be mitigated by
> supporting adding skb to bpf_list or bpf_rbtree directly in the future.
>
> * Clean up skb in bpf qdisc during reset *
>
> The current implementation relies on bpf qdisc implementors to correctly
> release skbs in queues (bpf graphs or maps) in .reset, which might not be
> a safe thing to do. The solution as Martin has suggested would be
> supporting private data in struct_ops. This can also help simplifying
> implementation of qdisc that works with mq. For examples, qdiscs in the
> selftest mostly use global data. Therefore, even if user add multiple
> qdisc instances under mq, they would still share the same queue.=20

Very cool to see this progress!

Are you aware that the series has a mix of commit author email addresses
(mixing your bytedance.com and gmail addresses)?

Otherwise, for the series:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


