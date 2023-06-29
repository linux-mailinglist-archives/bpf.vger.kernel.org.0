Return-Path: <bpf+bounces-3724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A72742519
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 13:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA75280DD8
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB39C11C96;
	Thu, 29 Jun 2023 11:43:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC50111AA
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 11:43:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B04530F6
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688038986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y15OWebfaiW59FJ+qInNbhfef5kwQoVQI8NNiLBthAo=;
	b=XqwiGpcdjnAeYWnV8SdYo0qsnllstCo28d5JDLXhScMIQybhGQUadv4wig/TmPUAQm8xIw
	dbDs1OQBIJj/mV1jayKP6H6O80h2iIkvHhCSlSEqr6NNymDdoUjjPl2LcINM9i/i68YvFq
	vAF6Mkd2PsmEzA5ozelpi7Rh7rsZcGc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-gFXyt0JTMjKX1ahQncaV2w-1; Thu, 29 Jun 2023 07:43:05 -0400
X-MC-Unique: gFXyt0JTMjKX1ahQncaV2w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31400956ce8so302152f8f.3
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 04:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688038983; x=1690630983;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y15OWebfaiW59FJ+qInNbhfef5kwQoVQI8NNiLBthAo=;
        b=VZ2LUFwggp40jlCXeYUCnvDkSZPJx2vp2OsOA8Lw0U+h6lmc2EPLTRXsQ6vnKdf2we
         acLZ8XziZ/77vv+FH+irXa/pn+g/W927GMF4naurrAYNsGB/y72cr2InevODsw4jyfSq
         wtrvAPTpOYn9rDGJi6DfSh28g38IP75D8K1B4e0Bcf/Afo/eM04sa+xnyOodxVv5tj9h
         V90lP/tydYh7p9dUMNKmiA6BBEr5zON4H+6VHmn9SRd6x/IMsNCI9YuIQG/3jna0fP71
         ExGLNICZRp7PK2AUAdlkdRfS9vQ5LxWuU9Q3clETol4IF/qMHlsPEORQPoFdWfxbUiCG
         q0hw==
X-Gm-Message-State: ABy/qLbPu0onm+SI80PJZ6U8mi495oZH9pUZ73Bc/189J5UotonLtuOU
	i2pq1daMxXyyAjmQoAl4TfrmB29nkCmZ6ZGc5STdTdyiYXcB0dRuFFNLnxUBfSysdAYTLN4L6p5
	x0Da7j7FPUCYdXx8sTYPP
X-Received: by 2002:adf:f9c5:0:b0:314:1648:9d7d with SMTP id w5-20020adff9c5000000b0031416489d7dmr1221857wrr.64.1688038983388;
        Thu, 29 Jun 2023 04:43:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7J8oHmuSA1tYQISlBEGlzDG7d8VpmhOoliF95zZLhSrKIxd5jaunlWPs4R3lBde5sswQ7FQ==
X-Received: by 2002:adf:f9c5:0:b0:314:1648:9d7d with SMTP id w5-20020adff9c5000000b0031416489d7dmr1221834wrr.64.1688038982858;
        Thu, 29 Jun 2023 04:43:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b0030e56a9ff25sm15545151wrt.31.2023.06.29.04.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 04:43:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 811F5BC043D; Thu, 29 Jun 2023 13:43:01 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Donald Hunter <donald.hunter@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Network Development
 <netdev@vger.kernel.org>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
In-Reply-To: <20230628115204.595dea8c@kernel.org>
References: <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
 <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
 <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com> <649637e91a709_7bea820894@john.notmuch>
 <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
 <20230624143834.26c5b5e8@kernel.org> <ZJeUlv/omsyXdO/R@google.com>
 <ZJoExxIaa97JGPqM@google.com>
 <CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
 <CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com>
 <649b581ded8c1_75d8a208c@john.notmuch>
 <20230628115204.595dea8c@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 29 Jun 2023 13:43:01 +0200
Message-ID: <87y1k2fq9m.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 27 Jun 2023 14:43:57 -0700 John Fastabend wrote:
>> What I think would be the most straight-forward thing and most flexible
>> is to create a <drvname>_devtx_submit_skb(<drivname>descriptor, sk_buff)
>> and <drvname>_devtx_submit_xdp(<drvname>descriptor, xdp_frame) and then
>> corresponding calls for <drvname>_devtx_complete_{skb|xdp}() Then you
>> don't spend any cycles building the metadata thing or have to even
>> worry about read kfuncs. The BPF program has read access to any
>> fields they need. And with the skb, xdp pointer we have the context
>> that created the descriptor and generate meaningful metrics.
>
> Sorry but this is not going to happen without my nack. DPDK was a much
> cleaner bifurcation point than trying to write datapath drivers in BPF.
> Users having to learn how to render descriptors for all the NICs
> and queue formats out there is not reasonable. Isovalent hired
> a lot of former driver developers so you may feel like it's a good
> idea, as a middleware provider. But for the rest of us the matrix
> of HW x queue format x people writing BPF is too large. If we can
> write some poor man's DPDK / common BPF driver library to be selected
> at linking time - we can as well provide a generic interface in
> the kernel itself. Again, we never merged explicit DPDK support, 
> your idea is strictly worse.

I agree: we're writing an operating system kernel here. The *whole
point* of an operating system is to provide an abstraction over
different types of hardware and provide a common API so users don't have
to deal with the hardware details.

I feel like there's some tension between "BPF as a dataplane API" and
"BPF as a kernel extension language" here, especially as the BPF
subsystem has grown more features in the latter direction. In my mind,
XDP is still very much a dataplane API; in fact that's one of the main
selling points wrt DPDK: you can get high performance networking but
still take advantage of the kernel drivers and other abstractions that
the kernel provides. If you're going for raw performance and the ability
to twiddle every tiny detail of the hardware, DPDK fills that niche
quite nicely (and also shows us the pains of going that route).

-Toke


