Return-Path: <bpf+bounces-19826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A99831EC6
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 18:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF5F1F2353E
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 17:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D942D60B;
	Thu, 18 Jan 2024 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XbvQKEa4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5DB2D054
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600276; cv=none; b=IBptNMXNiBNZGDoVxoANawhhwvZLFXYrK6iJ3WnuZDgtxsRh0qHr/9WS8h+uaamjKL5Ai4tMIzO59Bi2JlY4FK6x3jhS1p/eTDQaVSj188E1m8+iQowGhKrf15uxy+cnxbvxLb5NUevLtaCLre+mEyzpsiWfL3b6emc9+5FhQUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600276; c=relaxed/simple;
	bh=jTNwM3C8tPLpjMeFt8K96QaLPoN5LbCYxbO05S6OB5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2CUdkTNwy5tV2U+VVSapzVUo/BDmpLeWYFFlS9PB+B8bXzWVFaLlqk6IsHAem1KGCGrIUFYjQk5OXql7SnhtrGsjZ1eN7LdAtLs0BZ6rhYDrFnS+hRhBcxO2V3Ma3yt/FDxjlcG0Ab3YaOiOR/q+5Y7HAPOpZc13fY+bbYa8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=XbvQKEa4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e88bb6d2bso6488795e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705600273; x=1706205073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIUVSCKHVk6xPrHJaff7owQBTRhShNJUaV9ktmDrdKw=;
        b=XbvQKEa4mRS7OE2x7EXjYmqoGNH56SuKQnG68CXJZYyw2df0v+yTz7Q2fOrDKGCy6v
         Sj/2DLH8gCh+Sg62ClHPO0+TYVKTOFtZNC8IMspY1KJY4cgkfLTJ4Eii4siVvxYOtFII
         7Zlrosntms1+Pe/IYprl3t+x9OO1j5P97Zabl6gQCJ5Zwo3NCEl1DF98svjNaOQotjqq
         kWgCF1z143Og5Dm23AM++AGTB+cmu97d22w3rqPr+ZPzMYY/Ir1CZT0xoftpJ9DqLreN
         4RABOcxSQSycwMyTJET5Nd540BG++mhF2invovBh741kbMEK8Wm1Zb+Dhy2AV17gPsKR
         AEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600273; x=1706205073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIUVSCKHVk6xPrHJaff7owQBTRhShNJUaV9ktmDrdKw=;
        b=IqfqMkePa9oN6ELiFgc0Gfd4nronou9/zVSU5gMlG69IqhRt63n7KinD5cXBijaUWj
         oU6HMcB9a4ATEjXEv+/3xERRsQQjnYYUjfWrARkhnyCEF+DZsMuMLQXO6r847+issJY+
         acCNP4giO0h3DEczs4gi9HeHjOL1c6G3G4lnSbm6Z+lHbvCaYlaZ5P7wjWac7qX6WcmH
         fIG15XR89BlWEvC6QRklf7MB9dLtZlpSlTiouD8XQTHwGsJNJWLUhGKaTSCJNKVuO9WV
         QvuDWBmPwxH3RA8Fh9/5zh1HtStE30gA7rH2r9O4MwvI4Ch5sny/8Z/2FQ5hHw7QIxJa
         eSTg==
X-Gm-Message-State: AOJu0YwuHz26+O8/YwcALjz/SniKIcgglJqvd/+FJXCLmIW3Ot4hn+Ut
	BdFLvVKDG9CWEzU89oqQgFYKlKx7dsdUy4t94WiQdmeOkoK+W0FqME7tWMcnBdw=
X-Google-Smtp-Source: AGHT+IF4DcDJVS+BUs0ynmPN3ADS6ESKWPbXkklGOinc6kO7IrtR2mgeid10abAvmcHg+p+yAKnA2Q==
X-Received: by 2002:a05:600c:5106:b0:40e:937f:16d8 with SMTP id o6-20020a05600c510600b0040e937f16d8mr795918wms.50.1705600268156;
        Thu, 18 Jan 2024 09:51:08 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:3e3f:a818:b0d3:50b7? ([2a02:8011:e80c:0:3e3f:a818:b0d3:50b7])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b0040e39cbf2a4sm30805293wmo.42.2024.01.18.09.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:51:07 -0800 (PST)
Message-ID: <c129ca19-e7bd-4029-bf51-af15bfc57aee@isovalent.com>
Date: Thu, 18 Jan 2024 17:51:06 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/8] bpftool: Fix wrong free call in do_show_link
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
References: <20240118095416.989152-1-jolsa@kernel.org>
 <20240118095416.989152-4-jolsa@kernel.org>
 <CALOAHbAOJX01vb87FdRFC3Km7UDBVkJmDb9x1s-Yhb3hiWqfOQ@mail.gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CALOAHbAOJX01vb87FdRFC3Km7UDBVkJmDb9x1s-Yhb3hiWqfOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-01-18 12:30 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> On Thu, Jan 18, 2024 at 5:55 PM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> The error path frees wrong array, it should be ref_ctr_offsets.
>>
>> Fixes: a7795698f8b6 ("bpftool: Add support to display uprobe_multi links")
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>


