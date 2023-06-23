Return-Path: <bpf+bounces-3304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7373BE0B
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 19:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FF8281C87
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF15101E1;
	Fri, 23 Jun 2023 17:47:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB08485
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:47:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512E4197
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687542459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUYh1paXEwCS05q3S0gMK0O8xRTiSyH2tXRaJOlktNI=;
	b=b0yItReWsn/wLggQwHSJPIHZAmRUcjh/ox9DLptha7KWLrcHqOMuAj19SRrAmZ7oiLkV1v
	W/xfkGX5Ygn9nnlkXD9bBAzUU++hjP49RyAk90JqhhBfQIVBo+JBY6YYA/0xloKSFO19eX
	JFCFdiqhUEtCrXik0/2tIVBItrQmunE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-TS8gzmifNj-fIamWtzSuMg-1; Fri, 23 Jun 2023 13:47:37 -0400
X-MC-Unique: TS8gzmifNj-fIamWtzSuMg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f81dda24d3so18014655e9.1
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687542456; x=1690134456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUYh1paXEwCS05q3S0gMK0O8xRTiSyH2tXRaJOlktNI=;
        b=SY+3v+fb0tx/JQUBz3yiKjMQfkjaBScPrEmllTYXPRFIixkq/x2ooppC9BR7s/ty52
         ygKlhejGWb2Yz6EGVlCMFDfMTTFSsxcau9YK2a3ueJA1FKoeT+YU2UUfZDpzYW4+MNQ7
         PS6RpYhdbagtNYyh6jPBhm2imXj4vIsHcH5LgCSVSjxmzzgcIsdjn9Bedb2GbYs5bpiv
         K0YCUa97NtP65pE9ejXsa661c0NJ+YJrVZGW79esb1sbSpGynQVtTNSnOACiWABn3PSn
         u8afrrtRv2sfdJXkgTZBh1XaHYEKQAIG5m7x3DCy258toSFw9mDjzA2XwTYubRqr3EYy
         Jq0g==
X-Gm-Message-State: AC+VfDwffVnwpVVYZ1dNIAJ1sNSaho3rEc3tnLxCdKuKWV93UvFMAhq3
	yohZv1YZ3h6iYuE7rRfchU2U8VAsDquDv5O+q0yeWL/0E8QZCyLZDbHLGRJ2NFojFBn5EaboLto
	ZcCnGdIqgOnlp
X-Received: by 2002:a7b:cb93:0:b0:3fa:8268:e1f9 with SMTP id m19-20020a7bcb93000000b003fa8268e1f9mr442950wmi.38.1687542456648;
        Fri, 23 Jun 2023 10:47:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56Zpaj5sY52A68vlXwsIyeOCdgwPfI1aiVSwIWxwoCl6dGXqhIkVpF8BAY+ugvTKUODJgTVg==
X-Received: by 2002:a7b:cb93:0:b0:3fa:8268:e1f9 with SMTP id m19-20020a7bcb93000000b003fa8268e1f9mr442934wmi.38.1687542456292;
        Fri, 23 Jun 2023 10:47:36 -0700 (PDT)
Received: from [192.168.0.12] ([78.18.22.70])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d58ec000000b00309382eb047sm9979389wrd.112.2023.06.23.10.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 10:47:35 -0700 (PDT)
Message-ID: <3190e03c-ea5d-69fb-48e5-6cc45b1ed521@redhat.com>
Date: Fri, 23 Jun 2023 18:47:34 +0100
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
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
 <4c592016-5b5e-9670-2231-b44642091d46@redhat.com>
 <CAADnVQKT06t=-4zrHQobSpL06JpQh90vMfPpcYvXs8881GxMWg@mail.gmail.com>
From: Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <CAADnVQKT06t=-4zrHQobSpL06JpQh90vMfPpcYvXs8881GxMWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/06/2023 17:32, Alexei Starovoitov wrote:
> On Fri, Jun 23, 2023 at 3:16 AM Maryam Tahhan <mtahhan@redhat.com> wrote:
>> On 23/06/2023 03:35, Alexei Starovoitov wrote:
>>> Why do you think so?
>>> Who are those users?
>>> I see your proposal and thumbs up from onlookers.
>>> afaict there are zero users for rx side hw hints too.
>>>
>>>> the specs are
>>>> not public; things can change depending on fw version/etc/etc.
>>>> So the progs that touch raw descriptors are not the primary use-case.
>>>> (that was the tl;dr for rx part, seems like it applies here?)
>>>>
>>>> Let's maybe discuss that mlx5 example? Are you proposing to do
>>>> something along these lines?
>>>>
>>>> void mlx5e_devtx_submit(struct mlx5e_tx_wqe *wqe);
>>>> void mlx5e_devtx_complete(struct mlx5_cqe64 *cqe);
>>>>
>>>> If yes, I'm missing how we define the common kfuncs in this case. The
>>>> kfuncs need to have some common context. We're defining them with:
>>>> bpf_devtx_<kfunc>(const struct devtx_frame *ctx);
>>> I'm looking at xdp_metadata and wondering who's using it.
>>> I haven't seen a single bug report.
>>> No bugs means no one is using it. There is zero chance that we managed
>>> to implement it bug-free on the first try.
>>> So new tx side things look like a feature creep to me.
>>> rx side is far from proven to be useful for anything.
>>> Yet you want to add new things.
>>>
>> Hi folks
>>
>> We in CNDP (https://github.com/CloudNativeDataPlane/cndp) have been
> with TCP stack in user space over af_xdp...
>
>> looking to use xdp_metadata to relay receive side offloads from the NIC
>> to our AF_XDP applications. We see this is a key feature that is
>> essential for the viability of AF_XDP in the real world. We would love
>> to see something adopted for the TX side alongside what's on the RX
>> side. We don't want to waste cycles do everything in software when the
>> NIC HW supports many features that we need.
> Please specify "many features". If that means HW TSO to accelerate
> your TCP in user space, then sorry, but no.

Our TCP "stack" does NOT work without the kernel, it's a "lightweight 
data plane", the kernel is the control plane you may remember my 
presentation

at FOSDEM 23 in Brussels [1].


We need things as simple as TX check summing and I'm not sure about TSO 
yet (maybe in time). The Hybrid Networking Stack goal is not to compete

with the Kernel but rather provide a new approach to high performance 
Cloud Native networking which uses the Kernel + XDP and AF_XDP. We would

like to show how high performance networking use cases can use the in 
kernel fast path to achieve the performance they are looking for.


You can find more details about what we are trying to do here [2]


[1] https://fosdem.org/2023/schedule/event/hybrid_netstack/

[2] https://next.redhat.com/2022/12/07/the-hybrid-networking-stack/




