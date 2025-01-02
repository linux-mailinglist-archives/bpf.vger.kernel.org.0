Return-Path: <bpf+bounces-47749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 377749FFCBA
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 18:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225001881DC0
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06717C208;
	Thu,  2 Jan 2025 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZK3yWca"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016CE14884D
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839010; cv=none; b=GBGMUcup1CvKPikI0t2ckCcFDXIvWFeR5KfBEYN+nQ/bqCZ9xid8ogMqtg5lh6zQWOMtFeeKdCMlooYYUGrhETrHJTuQXcRq8+vioyAV69eifh0sSU4GfLFUkZDzPaWhAVwqjuA0DcVppoSbS7Xd/7rIad/W7/PZdgzx18mEqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839010; c=relaxed/simple;
	bh=8Kk7GOSkPrPKgNii7L1d4PmZHlCtZviKtEnzyEuMiMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bbwJvQQallDJfF/BZMCE8Y18X2sC4fILcYPyoTQCeGj0zvbv5smTG4sdg9vTXUvn5Zo2qO6JJT5lDjUv4sHphDtFsHLNCBOpM3U7Oag5VsxhpdxShrKlJBKF9bPRTFMfRCpmNsstyN9WaKFzKNGI7i0vr5m/XZdgxcIssulmKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZK3yWca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735839005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TF/q1lydKCxtj0HCWn8Jgrh/jkO6xBpGH3h2IRX+HOs=;
	b=KZK3yWcaLHES+grubAwBm4L/7Hdw8Nqk+Ed+Nt3qxOK0Vc4ERxAW6QB7o0zdU+KtX+CQzF
	mwp4gUf07witG4h5aSc33co4gqYGrEH3rGd6hk54/f/JedRXD2AFpIXiGlqyHU/em0ussn
	JBS/KpY3oeEjobiWhOW1surb2YYKqdA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-mEn0SErXO6utXyOmJ0UOmQ-1; Thu, 02 Jan 2025 12:30:04 -0500
X-MC-Unique: mEn0SErXO6utXyOmJ0UOmQ-1
X-Mimecast-MFC-AGG-ID: mEn0SErXO6utXyOmJ0UOmQ
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3022a57a4fdso48454581fa.1
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 09:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735839003; x=1736443803;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF/q1lydKCxtj0HCWn8Jgrh/jkO6xBpGH3h2IRX+HOs=;
        b=QTFpgDW8OPF7iYz0VMOQlsZBlmCgAMFc2lIjQVJG0jkQEbb0I+vS/kbgfAlXEcCp+u
         VLv9uM8wFYyPgTSoJD55CM9YF7bm9ew+N/3khreF30NJ4IqACehW6qMq99DURRKoxmla
         JDJj9UXz0EcMPr6V+FvYxyBRuuQyCJfEin1SNrmCIm5AgVDAR4C68CIOL22voui19cvR
         A7XeOri/EAZn/4BHZW+CV5XEQpSYXNdLzderkIlfHunGKoC0ywWY9HN8b3qhf8Do0DN5
         hNbbJtz67K/aUMZq6R62nImCg1NvFq7CVTz6b78vPEhxrHr7ngVLWbD6GtImpvKc2J6A
         BGGw==
X-Gm-Message-State: AOJu0YxgZs4JWe4GBsKxR33+soggrnv8t7FGgYINGqpmWxNdOtjnvH5l
	gxr0N06wWIcu6sLsUa+NUligNqQvdiBta9lEZtZzuwgDnKVtx/frhLtGqg5CbdwB2VHX91WRSmI
	yH0u6+PrQOItQoh/laJGMqyttTX7y7fT1cOoOBwCX4HaoW53vpg==
X-Gm-Gg: ASbGncuoZzSjkzZBKMdu2WL0NUhrWcoMJtieLU0nuvBqwOzHuJPB6aPfpZ2xSWd0I3F
	sjF1Xfjf50lE0N6FDk6ZM2W8ZNl4ADI4LAL3RZMrWeptlxQoP0ZZLFcYrpmeLQ52ZTkGou8i6H4
	DZUUBVBX2mzwpX/FMAGdHsXeDK0ABS8d3YW83PdGK6G7Eoy6Pkzy2Pn9kfnyBGtanNxg3m4dYe4
	FdA0LIcXjyK+dgA6MI2NFYoBVjAUbJsz+V0npGG91JvCSrElZWb/Q==
X-Received: by 2002:a05:651c:60d:b0:302:4115:acc with SMTP id 38308e7fff4ca-30468609a8bmr122376091fa.26.1735839002753;
        Thu, 02 Jan 2025 09:30:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq6WTs29dVX+Tc687FHw2WskAzVNvZbLuCxEb5RkRgNHTQ+JdkFHd7PoArSLLGQ+24RDTr/g==
X-Received: by 2002:a05:651c:60d:b0:302:4115:acc with SMTP id 38308e7fff4ca-30468609a8bmr122375981fa.26.1735839002307;
        Thu, 02 Jan 2025 09:30:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6cae6sm43916441fa.23.2025.01.02.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 09:30:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DCA51177D8E2; Thu, 02 Jan 2025 18:29:57 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com,
 jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, ameryhung@gmail.com,
 amery.hung@bytedance.com
Subject: Re: [PATCH bpf-next v2 00/14] bpf qdisc
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 02 Jan 2025 18:29:57 +0100
Message-ID: <874j2h86p6.fsf@toke.dk>
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
> directly and 2) classful qdisc are deferred to future patchsets.
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

This is very cool, and I'm thrilled to see this work getting closer to
being merged! :)

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
> We tested several bpf qdiscs included in the selftests and their in-tree
> counterparts to give you a sense of the performance of qdisc implemented
> in bpf.
>
> The implementation of bpf_fq is fairly complex and slightly different from
> fq so later we only compare the two fifo qdiscs. bpf_fq implements the
> same fair queueing algorithm in fq, but without flow hash collision
> avoidance and garbage collection of inactive flows. bpf_fifo uses a single
> bpf_list as a queue instead of three queues for different priorities in
> pfifo_fast. The time complexity of fifo however should be similar since t=
he
> queue selection time is negligible.
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

This looks pretty decent!

> * Clean up skb in bpf qdisc during reset *
>
> The current implementation relies on bpf qdisc implementors to correctly
> release skbs in queues (bpf graphs or maps) in .reset, which might not be
> a safe thing to do. The solution as Martin has suggested would be
> supporting private data in struct_ops. This can also help simplifying
> implementation of qdisc that works with mq. For examples, qdiscs in the
> selftest mostly use global data. Therefore, even if user add multiple
> qdisc instances under mq, they would still share the same queue.

So is the plan to fix this before merging this series? Seems like a bit
of a footgun, otherwise?

-Toke


