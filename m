Return-Path: <bpf+bounces-778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70207706AC2
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7C92816EF
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147B631125;
	Wed, 17 May 2023 14:15:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86742C75B
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 14:15:04 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A4110EF
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 07:14:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f42711865eso5895795e9.0
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 07:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684332895; x=1686924895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ry7sIernKx6nj98jC7LdSQyV6K4TUF0V5NCxuWK2EOo=;
        b=VU06FwmFAZ4QlJFj05jBarFOxuqiQ6udSZhGg0FggmykVm1uSAdlYWZaYsrIg9PQPm
         ix1C2QiWpFYr0raOlcfi2VN6z8fLaPqyLjq0dpFq1Xu6dPlKfuotw05yG0nRSy+tphEK
         c0333d2bq26fzzxBvStYrx0lQXNry0qEuhW5si0TcorgvjIpu+U62Fy7dv9+Xtqh5PXD
         Nj2TiHDTYG7lSTHptFJ/T+exP2XYcBjG43mmWyZ8T/L4gP+EtqLvr0cSftb8Nn0Otb99
         CXMLSl0qU/VZx3MFiHwalUJJQ4PyiQ4MLgQQAAPH32pYd7DAsYgfUJKHVeBXvrOZcDTg
         8vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684332895; x=1686924895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ry7sIernKx6nj98jC7LdSQyV6K4TUF0V5NCxuWK2EOo=;
        b=G9EIHVqWYeq0xvbTY/l0Gx+gMSp78LXPuJeX5aB5+qa4NE6wTVB2dlOrGghSQNbtaz
         ualiOtWWHsPYNjHhT1vHLvu98F15zbJV0r79HQlqIXIpeONF7GBfLfn5uL+pobPJO1ON
         +UiOHvZYfJPoOonL3r2lo436PMtLF1TR8DQXO5EImdbo4DyqNOGoXA1/Bt+I2ckZ4ECn
         UwMfrrwLkCy9TxZPzb1+D8M6QC+/X/yFe/IcAcLD/YqG2thRBHWZzsZD797KwENK4qey
         0gKuB2aSJsklW64ZRB+3KvtYAjKN3PesJe9zakNxjXVq4hvnIGK25dsCD+5lwfLZt0pK
         rddg==
X-Gm-Message-State: AC+VfDzwd7SvXznCvyeYsXVXml5MBHqbuXZ4RGEDdIhGSIy1WxhZHVQZ
	Sbex4zUC+oX4GxLLfAFqqsR0fQ==
X-Google-Smtp-Source: ACHHUZ60b+mJelzLaFVGuarFyDH3CSCK+ojlEHVeRUFVehylRUYcKPTjIjggzNcj36YHM3JZoTR8Lg==
X-Received: by 2002:a05:600c:2149:b0:3f5:1240:ace4 with SMTP id v9-20020a05600c214900b003f51240ace4mr4686986wml.25.1684332895163;
        Wed, 17 May 2023 07:14:55 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:d197:4e36:5d90:37fe? ([2a02:8011:e80c:0:d197:4e36:5d90:37fe])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d4142000000b0030649242b72sm2978549wrq.113.2023.05.17.07.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:14:54 -0700 (PDT)
Message-ID: <67eaa1f5-2208-1e4d-e31a-b9e71c39915c@isovalent.com>
Date: Wed, 17 May 2023 15:14:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Show target_{obj,btf}_id for tracing
 link
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20230517103126.68372-1-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230517103126.68372-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-17 10:31 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> The target_btf_id can help us understand which kernel function is
> linked by a tracing prog. The target_btf_id and target_obj_id have
> already been exposed to userspace, so we just need to show them.
> 
> For some other link types like perf_event and kprobe_multi, it is not
> easy to find which functions are attached either. We may support
> ->fill_link_info for them in the future.
> 
> v1->v2:
> - Skip showing them in the plain output for the old kernels. (Quentin)
> - Coding improvement. (Andrii)
> 
> Yafang Shao (2):
>   bpf: Show target_{obj,btf}_id in tracing link fdinfo
>   bpftool: Show target_{obj,btf}_id in tracing link info
> 
>  kernel/bpf/syscall.c     | 11 +++++++++--
>  tools/bpf/bpftool/link.c |  6 ++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks!

