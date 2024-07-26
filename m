Return-Path: <bpf+bounces-35739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531CE93D692
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 18:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C878D1F24E6D
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64A617C7B5;
	Fri, 26 Jul 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvBK9bsY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D95588B
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010014; cv=none; b=hiDjKQH6AK990p1/JwQXYfkRCcjHl9mmOki/srlZv1yxS15ipaftZipWzCQrCnj1GDE3i7oaR/VGTdry/4Xxk9kYC3wu+00e0Cv9AIFbDqocqkzxnzfBPuQYPcTN1eno6cuirP7ajzdxDbhHxnpcDwTRX0rTpxUvbtf0890/IuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010014; c=relaxed/simple;
	bh=9Yrpv47TygCUXw+vetxWqq82CLDlPoIuZNPpiubuzYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcDJe1gjKKoz9XRw7t9nqtZId/05LHh7O0Eup0NI2VqswyPlr0ZH5qoiD3uTaL1vZIA5msykofSf67im3g0ACklVPBD9kU0tc9ZOzsM+2A855nQx/YRv0k+0sBSxCA6+Crn6Y3jaVn7GWjBr6ioj5Y7CXjH0rA0c77wgRLXxqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvBK9bsY; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-66ca536621cso24528077b3.3
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722010012; x=1722614812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSbwCsMz3+yPbWJpj9X61XJljt8uNXDUrIcNi/rgFDs=;
        b=DvBK9bsYvlStPMRpWsujmK7E+Rut2ty+KDVnV+iUqL8rQ3LKrBILx8ZCn1CNlS9Ru+
         foGyDa1MYAXgjFE0j9wPq2Bf6e70wb6snTVIUzbToE1Uj90vbmxVCrT118QYO1I2j7eN
         gCd3aDvNH93kaXMNzHcUDFRUsf2UNrzN2bTfr+5PEeZtBWaUX0+K/nWz7jld4ODyMXLG
         u09i5gAGbK8NbW4bKDwORFuGirBdEWIzAdj6DkLFtofysP+2Fu3iLyVzGvgq9AoWqvkO
         0bXnkbLU0XKNeRilAO5r1zu4wgg36hlxOI3Xqrr33sZB5xkEVjKCl7g1SNQuh5jecV+N
         n1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722010012; x=1722614812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSbwCsMz3+yPbWJpj9X61XJljt8uNXDUrIcNi/rgFDs=;
        b=eiIdgJ8NMJgcq8SwcG7PJUk8pRmUmLz1t2A91VQf/NVPz9+aOMrPg8W5OhZ6Aub1jr
         9mw1tyE1qZkXfzvD04hdSubIhrqzJoV5VLtj9JIh6IZuNWJBhOi5vvwx+dP6cr4ydkQH
         N2yZHN0DUNhzo48W2SD3VC/WZ89D/JL9TkS7pb0q/dpOZ2I8z/cGxCMmm23dwQFP5B3o
         0XN65ZDPifjMzGgVh/BfX5L8kOvr1JE2Wpjt4bFOpe4A5Tq0l1CnvWftCocXF6GtJf+F
         goIXSi7VKRjjJi5wWFKHASVMwaUTGq8+0cqqHVQi3M4ZJ59BW28mt5LRXXKVMVlq+KLd
         u4xw==
X-Forwarded-Encrypted: i=1; AJvYcCXIZ2OWZNOhzxTlVmZuBdSGyMf//9hOinu4zk3tvcA/cZGlpPxz4IQ3J1eyO5MR9DnFQs1YjzAWCTF9gIgPLLKUL8hF
X-Gm-Message-State: AOJu0YyKX4gjnWRak2/nyIB8l14YvLBkUjEdmdeQHVC6JStFXskCh5yt
	oBraQ0a5HZvSOmi4vTIESGujHHEwhBAxedy7iJ/wnW3SPJFSb/bc
X-Google-Smtp-Source: AGHT+IErAksKHzrKEonkWyS5wQuJACINch9Ck0yMFlUzBgfVceaGdbJwF3awOP1qarQuxu2mxTfS+A==
X-Received: by 2002:a0d:f706:0:b0:61b:3364:d193 with SMTP id 00721157ae682-67a09d5e51dmr2660367b3.40.1722010011758;
        Fri, 26 Jul 2024 09:06:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:d785:ba42:22fc:942e? ([2600:1700:6cf8:1240:d785:ba42:22fc:942e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67568113009sm9177627b3.67.2024.07.26.09.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:06:51 -0700 (PDT)
Message-ID: <a45f8260-43d1-4c40-87ba-d4edc49b6bf5@gmail.com>
Date: Fri, 26 Jul 2024 09:06:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 bpf-next] bpf: export btf_find_by_name_kind and
 bpf_base_func_proto
To: Ming Lei <ming.lei@redhat.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, andrii@kernel.org, drosen@google.com,
 kuifeng@meta.com
Cc: thinker.li@gmail.com, Yonghong Song <yonghong.song@linux.dev>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
References: <20240726125958.2853508-1-ming.lei@redhat.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240726125958.2853508-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/26/24 05:59, Ming Lei wrote:
> Almost all existed struct_ops users(hid, sched_ext, ...) need the two APIs.
> 
> In-tree hid-bpf code(drivers/hid/bpf/hid_bpf_struct_ops.c) can't be built
> as module because the two APIs aren't exported.
> 
> Export btf_find_by_name_kind and bpf_base_func_proto, so that any kernel
> module can use them given bpf community is supporting to register
> struct_ops in module, see the patchset "Registrating struct_ops types from
> modules"[1], which is merged to v6.9.
> 
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- add more details in commit log (Yonghong)
> 	- add 'bpf-next' in patch title (Yonghong)
> 
>   kernel/bpf/btf.c     | 1 +
>   kernel/bpf/helpers.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 520f49f422fe..519c6e5a57d5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -567,6 +567,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
>   
>   	return -ENOENT;
>   }
> +EXPORT_SYMBOL_GPL(btf_find_by_name_kind);
>   
>   s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
>   {
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5f0adae8293..18d1a76f96d2 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2033,6 +2033,7 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return NULL;
>   	}
>   }
> +EXPORT_SYMBOL_GPL(bpf_base_func_proto);
>   
>   void bpf_list_head_free(const struct btf_field *field, void *list_head,
>   			struct bpf_spin_lock *spin_lock)

Acked-by: Kui-Feng Lee <thinker.li@gmail.com>

