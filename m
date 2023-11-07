Return-Path: <bpf+bounces-14344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141587E32DD
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 03:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65C3280E3F
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 02:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2FB20F2;
	Tue,  7 Nov 2023 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ELGOfmvM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7161873
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 02:23:32 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E9210A
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 18:23:30 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bd0631f630so3805486a12.0
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 18:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699323810; x=1699928610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqtbzYxfBdQiKwvSi8BnHojSILRSBVpP3BhLZFB9Z9U=;
        b=ELGOfmvMA56MBJmYUm6YJ7rOg8g10RfXR2mAYzYfX1k9dY7r6FkKXyD8Exw6mZmLJq
         2mvNKUJjRq9sC7X0i3wSEuQernim83cm9l4+IIsXCI13cQLxaWPPWZt5jH1PkhxV92ZZ
         5ziDNfzn73VVn8VQz8neE3v5LVOo4Q0PWmPEGmsNctLf3z6vdTZhYsCwRyHbFQhY0Dzm
         k5cXhsiuI+qPPvbYC9iw3WkZ65BF+jNVOxjb5xtISUnggRZu4F00PNDynuuljKbuX3Ba
         IWb5kpbFg/q8eDlOz2JyaqFMbxJcBvx6tblbM9H8PVvCQ1m+L+bAPtoI7ekOdre28uDU
         z47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699323810; x=1699928610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yqtbzYxfBdQiKwvSi8BnHojSILRSBVpP3BhLZFB9Z9U=;
        b=lHtlU3S2MZ1R23B0q+O7b/NOtSZvo50Fb4Piw0sB+TGQP/m7zL5ztDfNVPR9WNNTfG
         CffKHF6GNtgHulErZFt2tQcHl5zGYGUAYyouAo8POSVnunmaEx0uzHwpAGLzH8tX818o
         vKuD9XvpxboL2+WPvt5XwjA+j7t1FKX1tyWQwbKDPB/8UCI/OQc9qOd7fYoVE+qxcHTH
         InFy3Z5B3IqVBYDNiy0G698OkRIkofof/qoOBqA3b+O3lyAu5+DEs5DhCYYy35u7FwU3
         nyNc/vZWLkBeYMKoK66W+n4AphF9cm2lMtLtODikh/guwWquN/JKTvY+sS/qcDsLIEZQ
         Xh4Q==
X-Gm-Message-State: AOJu0Yzo+FEE0erC4t82QRxesQCH63RVBg1KK4J5eB6/W8H54PgjH21T
	SKeOjmCDzwpeoBSK7QkTR7ICqw==
X-Google-Smtp-Source: AGHT+IFK+wJAa45w/KXYQfawu6QNCngKEu1s0d03anByWd9hMbw0KNeAZDbEi2hr5dqZWEuFwpkvNA==
X-Received: by 2002:a17:90b:1bd2:b0:280:a002:be85 with SMTP id oa18-20020a17090b1bd200b00280a002be85mr1862483pjb.20.1699323810059;
        Mon, 06 Nov 2023 18:23:30 -0800 (PST)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id t16-20020a17090a5d9000b0027722832498sm6060958pji.52.2023.11.06.18.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 18:23:29 -0800 (PST)
Message-ID: <53f72a69-010a-4f60-b961-201e7fd8911d@bytedance.com>
Date: Tue, 7 Nov 2023 10:23:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: Let verifier consider {task,cgroup} is
 trusted in bpf_iter_reg
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org
References: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
 <20231105133458.1315620-2-zhouchuyi@bytedance.com>
 <b7f188bd-d131-4e52-a5fd-edbc58a3c529@linux.dev>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <b7f188bd-d131-4e52-a5fd-edbc58a3c529@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2023/11/7 02:26, Yonghong Song 写道:
> 
> On 11/5/23 5:34 AM, Chuyi Zhou wrote:
>> BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task) in verifier.c wanted to
>> teach BPF verifier that bpf_iter__task -> task is a trusted ptr. But it
>> doesn't work well.
>>
>> The reason is, bpf_iter__task -> task would go through btf_ctx_access()
>> which enforces the reg_type of 'task' is ctx_arg_info->reg_type, and in
>> task_iter.c, we actually explicitly declare that the
>> ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL.
>>
>> This patch sets ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL |
>> PTR_TRUSTED in task_reg_info.
> 
> Actually we have a previous case like this. See
> 
>   https://lore.kernel.org/all/20230706133932.45883-3-aspsk@isovalent.com/
> 
> where PTR_TRUSTED is added to the arg flag for map_iter.
> 
> You could mention this case in your commit message.
> 

Thanks, will do it in next version.


