Return-Path: <bpf+bounces-55157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC6AA78EC7
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903A47A3DC2
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B871237717;
	Wed,  2 Apr 2025 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnUyKcAI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B41E89C
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597717; cv=none; b=et1fbPmT99r/TaYmCO8o2Rdre5ueLBsgvxBmFVBfNVOxoYO5c+fVa6bmXinxaAHNxMVVJ40bNbNaWe1kQC0P08ZpFupIwEE3wSgJa77kgC/jGcL2gXklRuI8zbZSGlbQatY9ykRso1c8+Klbva7ngK00Bfi1AIChriSzCuvCZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597717; c=relaxed/simple;
	bh=RAbwJyfiU9jXK/iH5cd8A3THRrZL6+0VaHUFUtdaOJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r9/TvxJJbjq4A/Gabxoba4FI3E7TPU9OT/yicWTpV7+qGw+UoBkur++KQ4Wdl2OFH9KX2YwpW/AfIeNpg1U08zVH5683NmEz14aXIcLR3J3UBnUS9VN4E2984inY2Ykyebj0SSroloRvw+YOsILJt3ETKYA+BnWsCPuQ3zzH7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnUyKcAI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac339f53df9so1166999466b.1
        for <bpf@vger.kernel.org>; Wed, 02 Apr 2025 05:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743597714; x=1744202514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yFsP3rGperpYjGB3K2x7jZwFZ4R0foZ2ePBz4/40EI8=;
        b=NnUyKcAIKJRZFwmkftxAsKi8+dCdt/XnP6Bc8hLJh89RJbgqoRsJQWSCslSBsMK4hz
         cgAoit0nv2EEzr7FKLlrxc0b+/2PsBvSswUd5zSgdi3ud2+mG5b/hZrhd0A4MZ+inWzM
         QET3eIS0IQlPzZyypsJBLA45mG2PZuvvFvHFEi0r6VOlpKfBZwGgEJlmE2N91oEoH0xH
         ESGfO6GX5ZKUYscn+lpysN7reZ0UmAS55PcFEdbcWSZGhQU4/eYFv1rAMOtmbRNayQ6m
         k2RUtpXBR9kyXhDXj2YAM2xVwdI8lcV1AhECokNRWtLVwokKIqvHTAVIBoeNZXVDy2gt
         jAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743597714; x=1744202514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFsP3rGperpYjGB3K2x7jZwFZ4R0foZ2ePBz4/40EI8=;
        b=IyCaW9ONgGU1ELThAaP7bwGl0G0NewyZH52E18toLC+soQuOOdQj9FfibzGJBTmbxe
         hWZ/GTCXveU1uEOYftplwVmEfunAeTB/zJvSxTl+BcHwDYpGkKOjF0ofzKOMk5NDDkKY
         Dpnu9tvq70CBSxMAHIbA30U7DUZig+hqK3k531UHUixkFvqkK30XI+13DLsxGqlJv2PP
         MLowwFz/YluWC9IXP1vLO1yCTmTiRkqc8Vm9Xhvu3KFop88RLQM7j/3yduremmixsYx3
         9vccMJiMGCpiMI9a4ADqxp9g9HennkSOXPEnA3w/zea6IvZ1HHh93Ij5Q2i3G6X/iyIw
         34LA==
X-Forwarded-Encrypted: i=1; AJvYcCXOAJoUBZAZi8ecP8IaIqZMHwVHMbrTalYG3oLUt03bkU1LmFajhgxfTbmLxTObLTlx1mA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7GtB1MveLNI+JuSe8YGFSmeI80qG/J2Q87asNkTd8PDOBx2Oy
	Y+wOInsdXkbU8rkoUwy+Ntiv61yirhRZovkj/qn7jwKGQZf3M+F6
X-Gm-Gg: ASbGncsrJ43L24LXnDze8s/g5dK99d1EzmAU/8qHgM0GvYeaIZr8KRAOQwNnde++PHW
	fLEmlJ8Na4LDjYU268l0vc7SacPh+dyt0i4gCbdP1OxLMYtluCoOzJB7MURfAWDHEvA8XSJl1l6
	+X/ZXtzA7TzY7q2yBClCnaC+V4uJI5mKx4r63LGSCAb7mT0T1Aix7MC2qLBwtQedL2HJx1Emupb
	iJ9WzN5VQ4AKZ9VFJ3dTiNDzeS86/dPtNdNl3U/b5LOEt8d1AobUd65PUM9FEqNDIXSW/2Jrlbx
	1yH453K/hOgsU7BG0hRMjM/EUDzw6cWHz/35KurTOSzG2dY1dwuC65uXPTQOoQBCS+9UTTZc2X5
	1nfZCkg==
X-Google-Smtp-Source: AGHT+IEjMQIhIVHqQvXvvG7x1xV94xRTyG7wVK6s2wdTpkb8brtvswIg005TGFgGFXYl2yubbjJ2pA==
X-Received: by 2002:a17:907:2ce4:b0:ac3:afb1:df32 with SMTP id a640c23a62f3a-ac7389762bdmr1321154266b.6.1743597714005;
        Wed, 02 Apr 2025 05:41:54 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:49da:1478:ce38:b9b4? ([2620:10d:c092:500::4:cdbc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b238sm903924466b.48.2025.04.02.05.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 05:41:53 -0700 (PDT)
Message-ID: <635cc3eb-a7db-4647-accf-86a03436eeb9@gmail.com>
Date: Wed, 2 Apr 2025 13:41:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] libbpf: add proto_func param name generation on
 sanitazing it to enum type
To: Timur Chernykh <tim.cherry.co@gmail.com>, bpf@vger.kernel.org
References: <20250331201016.345704-1-tim.cherry.co@gmail.com>
 <20250331201016.345704-2-tim.cherry.co@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250331201016.345704-2-tim.cherry.co@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2025 21:09, Timur Chernykh wrote:
> Signed-off-by: Timur Chernykh <tim.cherry.co@gmail.com>
Thanks for submitting this patchset, do you mind adding a proper commit 
message for each commit in the set.
> ---
>   tools/lib/bpf/libbpf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6b85060f07b3..8e1edba443dd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3128,6 +3128,8 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>   	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
>   	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>   	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
> +
> +	char name_gen_buff[32] = {0};
>   	int enum64_placeholder_id = 0;
>   	struct btf_type *t;
>   	int i, j, vlen;
> @@ -3178,10 +3180,50 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>   			if (name[0] == '?')
>   				name[0] = '_';
>   		} else if (!has_func && btf_is_func_proto(t)) {
> +			struct btf_param* params;
`struct btf_param *params` here and in other places, put asterisk closer 
to var name, not type.
> +			int new_param_name_off;
Maybe just `new_name_off`, prefer shorter names, when possible.
> +
>   			/* replace FUNC_PROTO with ENUM */
>   			vlen = btf_vlen(t);
>   			t->info = BTF_INFO_ENC(BTF_KIND_ENUM, 0, vlen);
>   			t->size = sizeof(__u32); /* kernel enforced */
> +
> +			/* since the btf_enum and btf_param has the same binary layout it's ok to use btf_param */
> +			params = btf_params(t);
> +
> +			for (j = 0; j < vlen; ++j) {
> +				struct btf_param* param = &params[j];
> +				const char* param_name = btf__str_by_offset(btf, param->name_off);
> +
> +				/*
> +				 * kernel disallow any unnamed enum members which can be generated for,
> +				 * as example, struct members like
> +				 * struct quota_format_ops {
> +				 *     ...
> +				 *     int (*get_next_id)(struct super_block *, struct kqid *);
> +				 *     ...
> +				 * }
> +				 */
> +				if (param_name && param_name[0]) {
> +					/* definitely has a name, valid it or no should decide kernel verifier */
> +					continue;
> +				}
> +
> +				/*
> +				 * generate an uniq name for each func_proto
> +				 */
> +				snprintf(name_gen_buff, sizeof(name_gen_buff), "__parm_proto_%d_%d", i, j);
> +				new_param_name_off = btf__add_str(btf, name_gen_buff);
> +
> +				if (new_param_name_off < 0) {
> +					pr_warn("Error creating the name for func_proto param");
append \n to the error message.
> +					return new_param_name_off;
> +				}
> +
> +				/* give a valid name to func_proto param as it now an enum member */
> +				param->name_off = new_param_name_off;
> +			}
> +
>   		} else if (!has_func && btf_is_func(t)) {
>   			/* replace FUNC with TYPEDEF */
>   			t->info = BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0);



