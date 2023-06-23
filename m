Return-Path: <bpf+bounces-3248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E2173B4FE
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 12:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A90281AD7
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4803A611F;
	Fri, 23 Jun 2023 10:16:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3D5694
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:16:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6358D3
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 03:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687515374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wbb+i4KWtaqSPWTYfrigxDvU8UMGL/SwUc27+u/CQjI=;
	b=hordSQ/P91W0jOsuY3ja8DCjxnXnXUgiWNC6XVVIgQSUYWIL9Sjx+Z/ufsGIZjZPk0g06s
	DPwB48o9gsTXinrGYOo0jQjL+fJSnTw+YdAEMuofdpGgjdX45H4+vUjqj89fJM376M2fdC
	SWEgpuYITiKal8KwTQX5AhchzdTRYDM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-TGNHqypBPkSmDCDCzT8h5A-1; Fri, 23 Jun 2023 06:16:12 -0400
X-MC-Unique: TGNHqypBPkSmDCDCzT8h5A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f9b8e0896aso3791235e9.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 03:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515371; x=1690107371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wbb+i4KWtaqSPWTYfrigxDvU8UMGL/SwUc27+u/CQjI=;
        b=ZCXcbQVzidGE7tiGsu1+kMD+E7WKGCLp8ahkdcsXfPsYMADQBrNcWB7h84cEXX9Pqv
         uf+lEczozNZn0srlDDXSDM0eysdEciaCmE1tdhRbh3drLxgGJ3h6gbyM3JzRf2M0GlBG
         YXwvGTc5t/XxVsnvTJHk3hBIQydeZ0BStdEysQyYt6h3JaGHmCDg69ZgkMVFVkOFeVP0
         rC+Vwf49rSr3eYBaNsvb8oiORoCVBrWU7tR0XSBOfMSIoCHlq9FF2uMF2l5IGe5pRkus
         xxVbO5MbMFOcudOKpOB4/WXJI4o2vDMwhokhQhh90dOQr/smG4nVFLyuiD8MKWBzNNQF
         ZUrg==
X-Gm-Message-State: AC+VfDxFGVMGQFu9moGefFj672SnxNh+xFcj4MYDEel62YSSZpCZ7e7+
	RXATvSS9+G3xAKrMQqG1vjRYTA9m20NVHShi9pDnfDqID2D7+qNFiXiYNvir6bMHQK380O/uPQo
	rSJU2ryNRB7b+
X-Received: by 2002:a1c:750a:0:b0:3f7:cb42:fa28 with SMTP id o10-20020a1c750a000000b003f7cb42fa28mr16958405wmc.28.1687515371584;
        Fri, 23 Jun 2023 03:16:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fJS9nJI4SwLbDjsqYFbuD3TUHJL0rCF1ImCa1c3AcxPaUTTkGAHJ3URCyVur3mmn7xeUjww==
X-Received: by 2002:a1c:750a:0:b0:3f7:cb42:fa28 with SMTP id o10-20020a1c750a000000b003f7cb42fa28mr16958382wmc.28.1687515371255;
        Fri, 23 Jun 2023 03:16:11 -0700 (PDT)
Received: from [192.168.0.12] ([78.18.22.70])
        by smtp.gmail.com with ESMTPSA id y12-20020a05600c364c00b003f7f249e7dfsm1959206wmq.4.2023.06.23.03.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 03:16:10 -0700 (PDT)
Message-ID: <4c592016-5b5e-9670-2231-b44642091d46@redhat.com>
Date: Fri, 23 Jun 2023 11:16:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Stanislav Fomichev <sdf@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Network Development <netdev@vger.kernel.org>,
 "Wiles, Keith" <keith.wiles@intel.com>, Jesper Brouer <jbrouer@redhat.com>
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-12-sdf@google.com>
 <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
 <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
 <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
From: Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/06/2023 03:35, Alexei Starovoitov wrote:
> Why do you think so?
> Who are those users?
> I see your proposal and thumbs up from onlookers.
> afaict there are zero users for rx side hw hints too.
>
>> the specs are
>> not public; things can change depending on fw version/etc/etc.
>> So the progs that touch raw descriptors are not the primary use-case.
>> (that was the tl;dr for rx part, seems like it applies here?)
>>
>> Let's maybe discuss that mlx5 example? Are you proposing to do
>> something along these lines?
>>
>> void mlx5e_devtx_submit(struct mlx5e_tx_wqe *wqe);
>> void mlx5e_devtx_complete(struct mlx5_cqe64 *cqe);
>>
>> If yes, I'm missing how we define the common kfuncs in this case. The
>> kfuncs need to have some common context. We're defining them with:
>> bpf_devtx_<kfunc>(const struct devtx_frame *ctx);
> I'm looking at xdp_metadata and wondering who's using it.
> I haven't seen a single bug report.
> No bugs means no one is using it. There is zero chance that we managed
> to implement it bug-free on the first try.
> So new tx side things look like a feature creep to me.
> rx side is far from proven to be useful for anything.
> Yet you want to add new things.
>

Hi folks

We in CNDP (https://github.com/CloudNativeDataPlane/cndp) have been 
looking to use xdp_metadata to relay receive side offloads from the NIC 
to our AF_XDP applications. We see this is a key feature that is 
essential for the viability of AF_XDP in the real world. We would love 
to see something adopted for the TX side alongside what's on the RX 
side. We don't want to waste cycles do everything in software when the 
NIC HW supports many features that we need.

Thank you
Maryam


