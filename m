Return-Path: <bpf+bounces-13596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE73E7DB7CA
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 11:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F09281455
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1722C1118D;
	Mon, 30 Oct 2023 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Na32S4o6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491E379
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 10:19:15 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC44384F
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 03:19:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40853c639abso33694505e9.0
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1698661140; x=1699265940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21TAXtHOUB4zGMWyhZU8/6XzvDu+QbrS3oHhoGDKwz0=;
        b=Na32S4o62nhlwoRPm4m09FbdeDrp9OJFns/R8bXsfCQSa642pTMU6gHDTBcICEQPGL
         mKGKTG/ePxnn8JCxA2mjNER1v503OUgu6VPorJKM4Vd0aHNqeCHXin1Jug3xach1Jod1
         tk2gLaUmMawLtHi/gF1XsgkkpqrZjwoPvVBMpFqM2R0cGdBJdLys2hK47IfGdW+fJf/N
         X5jsv+y7CzvYU7Gp21RmEdbXg0FD68MQtL+iAr6Lr6UpWpbQ5ZEKR1Ui8sv5wFpEUbDZ
         hP/Lp6o83/mMrXjWFVMijgoMsZ5Ip+u9E96fcoXWogLZ87XQ0NLi0zuR254HJ1ni2Vm0
         APWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698661140; x=1699265940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21TAXtHOUB4zGMWyhZU8/6XzvDu+QbrS3oHhoGDKwz0=;
        b=ZHACgUpQva6JY4R+oJG5VCkif2mbjZ8nVCHZbCK6HjdQCsCO1AEZhjTef7c7XLs0Ty
         Tb+sVULmN47VjaLdt16HXumanys8meGvM9awKYvOuO72RrrDxkSZZLS2MLmjNaYgai5C
         tiKRhNGqXG7afWxLL+bUNEPjV878bJ+IT6Y+T3bRKN3MAjCUvN7mvh8GS/QYWXPx96Zy
         xBp0pJ0FefLSsx39XBVZYeE2n00hi7WHW7ulALdG7hp1Ngk5Uns3CwDTSf8DmX8Kp5Eb
         VZPBv7TgTiyGmmzRH5HZ7s68T9Q8fFZniU3R7JrDgA6UqXewPX4rvHOWfdptTkO3XcSS
         eoVw==
X-Gm-Message-State: AOJu0Yytht6J7ioaSalOFXiIYHGsHdpA6woW8cX/X24pzsNfbLTBVRGJ
	l5fqt8jahRN0b5129imEUbDRkw==
X-Google-Smtp-Source: AGHT+IHctPm/1ggazkelVB966AXJcXs1oT1GCAMHP54jhoRXv+57B+59i486H0/PjxhuSI3tv5w1oQ==
X-Received: by 2002:a05:600c:1c15:b0:406:f832:6513 with SMTP id j21-20020a05600c1c1500b00406f8326513mr7612392wms.3.1698661140314;
        Mon, 30 Oct 2023 03:19:00 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:415:ab66:142e:d74b? ([2a02:8011:e80c:0:415:ab66:142e:d74b])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b003fee53feab5sm8771232wmb.10.2023.10.30.03.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 03:19:00 -0700 (PDT)
Message-ID: <72a9c3e0-f73a-4a63-8602-712d44d7cee7@isovalent.com>
Date: Mon, 30 Oct 2023 10:18:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi
 link
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20231025202420.390702-1-jolsa@kernel.org>
 <20231025202420.390702-4-jolsa@kernel.org>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231025202420.390702-4-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


2023-10-25 21:24 UTC+0100 ~ Jiri Olsa
> Adding support to get uprobe_link details through bpf_link_info
> interface.
> 
> Adding new struct uprobe_multi to struct bpf_link_info to carry
> the uprobe_multi link details.
> 
> The uprobe_multi.count is passed from user space to denote size
> of array fields (offsets/ref_ctr_offsets/cookies). The actual
> array size is stored back to uprobe_multi.count (allowing user
> to find out the actual array size) and array fields are populated
> up to the user passed size.
> 
> All the non-array fields (path/count/flags/pid) are always set.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       | 10 +++++
>  kernel/trace/bpf_trace.c       | 68 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 10 +++++
>  3 files changed, 88 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0f6cdf52b1da..960cf2914d63 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6556,6 +6556,16 @@ struct bpf_link_info {
>  			__u32 flags;
>  			__u64 missed;
>  		} kprobe_multi;
> +		struct {
> +			__aligned_u64 path;
> +			__aligned_u64 offsets;
> +			__aligned_u64 ref_ctr_offsets;
> +			__aligned_u64 cookies;
> +			__u32 path_max; /* in/out: uprobe_multi path size */

Just a nit on the naming here: I don't really understand why this is
"path_max", should it be "path_size" instead?

Quentin

