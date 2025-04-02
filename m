Return-Path: <bpf+bounces-55158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1776A78F71
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 15:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA8F3B5AB9
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 13:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C10238D52;
	Wed,  2 Apr 2025 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz3no03S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8645BAF0
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743599135; cv=none; b=e1MxoQakUmzdoErhaGoduOcnLaEn03CyMEluyovxhnT5+b18E2lTaxYEN66vVHQVM9LByYaD85P2k27hsctJL6aIXgxyPVkC9RBwi64+sowfAonHbjiuY3hWuK2g/3cI/8BSn85rkbY4CMKQJiZNAMsHhA/7e65bjRTi0kNxlfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743599135; c=relaxed/simple;
	bh=BbqWlkmLsqdJ/yeJFZPUInM5+KEu39laBQDKA0DRNok=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j+cUv1wvfmdBi6UiTxFzWnZvVfHkL8SaPAGfVx7bpLzEYmq4Jz8SqkBA+IQN0KdjG/mskUmespO6o2Y+9+h5SMikuKra+MCZDjkTxQDLtizabQaiBPTng8YeYvKyDjshTXvhubXfPZOU0UDTZh6fP4AetwnuwrPUBJDAVQRaw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz3no03S; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac29af3382dso1060784766b.2
        for <bpf@vger.kernel.org>; Wed, 02 Apr 2025 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743599132; x=1744203932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3Pd0RN/a4hJCSR0Cx0/juOU//VFopZAX9NtjDcT/Mo=;
        b=bz3no03SZH6rut/vV4l/SjgD12XbAW3JfHlf4L8nb3X5YH+uWZXQydHg95TOXvpBqZ
         eznb5bhgEe46r95slvPMdwfH6xQM0m9W2N5GnKBZNYvfX8nrIAxMd2uOUIcMqAqVAzgq
         1HZuaTrRQSB9or2SDAedhJW5mBNtUrrF6U8T/gf9JhRLuUFWP19ThkPwnXhf60X4ZBJf
         tjBToJiip/kEyepQj0Crcf0D6EDbVmtjO2awP5Ipbq5Dhi39qFaDwA/qDiR7Jz280FF2
         MJ9lPw4daiLCXXBbRfLQTpNOekxLwWU8iJBCpGXCPiuPC4hfYffLq3LYEtTrpxARjBhg
         o23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743599132; x=1744203932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3Pd0RN/a4hJCSR0Cx0/juOU//VFopZAX9NtjDcT/Mo=;
        b=QMKZ4iaKh3n4CqjAX3yyHPQyYDsH+tNC/9WfClcs7se21WAygL14M/VoruUrE+Yc5e
         SqLCQBu/F5ypTn7mM2aUNLPlXfjdePE+CPb12Wpt1tOJo02bEQxDsEoHHwsKMHcdFS3v
         XsAvxvp5Raq3BknuIWgzEtYHZpNVUHuZstFDm9FagT16l8J0jucm71/uPEShEuTlqy4L
         774vv7cS4qAN3gek0n8AtDY0RNFVcjf8UT5A2tqDNNZ5UoT0jK8a/cw/Scef4XnP3BRE
         3MkmbK0kNlBQBaUPVzrj4WLcL+/Pj2ipo4sSC8+3jUJHTyMgaPkF7yMJLybeT6P5rAQm
         rP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCpps7BdR15FwV34SRXClmj7vcfsjbkBKCsTADEw5cvcM9fPZfhfXl9F2F7tjykRFIkjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWFGGTlDE67BcvVlsg8iTANodqech+Rb9Zcai7/oTNXyNJBY5W
	o7pvgYjUmiJE1bvmg1YiC2jeeo1ojTTVTxBZJaU+2GUTKT1BUQaEZxZo2w==
X-Gm-Gg: ASbGncsAaC5XOhVB2CAS8RFyO34E3S4HZc/CO21qO23BTkwFJ483T979q5w32QAA3yB
	6zofJA+itv7IywitaekfhXbeM0Ah4mMf75aTNuRzhx87h7mBVdOgM0c10kaZ7WMerYMcEnY+qAo
	Z9FUny4d6F5cnwrP5kGFRIcxCqAlNpIeTPa2sWQMO7Qz7uiFA4ZueanbD/KxLbJj18YyXlDP4SD
	ls6tB0m36e15jSGv8o7zEFvD4w+6OLDt79vFTk1CYftkzNRrBH8TGDWlnAYsoJ81qLfAV2Ed8bF
	5EtjjhN9Ns3SSjaxDQAa5pySETZCirH91D0u9ivdi4+XP4J5aGqnUonygsVNmrTMzBlRUao2Uqh
	VrGoTig==
X-Google-Smtp-Source: AGHT+IFRBfeEy+P1FdbeTdBU9HUZW6s4ki0WgL2Z1eFTQPuMOeHO8vKzyd56rY8REiLLWJIfyEUuyw==
X-Received: by 2002:a17:907:868a:b0:ac3:bd68:24eb with SMTP id a640c23a62f3a-ac7389e793cmr1739898366b.1.1743599129374;
        Wed, 02 Apr 2025 06:05:29 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:49da:1478:ce38:b9b4? ([2620:10d:c092:500::4:cdbc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d5f15sm8391646a12.31.2025.04.02.06.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 06:05:28 -0700 (PDT)
Message-ID: <07b775ab-9c14-4ea1-aff2-0554bbcff1c6@gmail.com>
Date: Wed, 2 Apr 2025 14:05:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] libbpf: add check if kernel supports kind flag and
 fix the bitfield members in union and structs if not
To: Timur Chernykh <tim.cherry.co@gmail.com>, bpf@vger.kernel.org
References: <20250331201016.345704-1-tim.cherry.co@gmail.com>
 <20250331201016.345704-3-tim.cherry.co@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250331201016.345704-3-tim.cherry.co@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2025 21:09, Timur Chernykh wrote:
> Signed-off-by: Timur Chernykh <tim.cherry.co@gmail.com>
> ---
>   tools/lib/bpf/features.c        | 30 ++++++++++++++++
>   tools/lib/bpf/libbpf.c          | 62 ++++++++++++++++++++++++++++++++-
>   tools/lib/bpf/libbpf_internal.h |  2 ++
>   3 files changed, 93 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 760657f5224c..dfab65f30f0c 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -507,6 +507,33 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>   	return probe_fd(prog_fd);
>   }
>   
> +static int probe_kern_btf_type_kind_flag(int token_fd)
> +{
> +	const char strs[] = "\0bpf_spin_lock\0val\0cnt\0l";
> +	/* struct bpf_spin_lock {
> +	 *   int val;
> +	 * };
> +	 * struct val {
> +	 *   int cnt;
> +	 *   struct bpf_spin_lock l;
> +	 * };
> +	 */
> +	__u32 types[] = {
> +		/* int */
> +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +		/* struct bpf_spin_lock */                      /* [2] */
> +		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_STRUCT, 1 /* kind bit */, 1), 4),
> +		BTF_MEMBER_ENC(15, 1, 0), /* int val; */
> +		/* struct val */                                /* [3] */
> +		BTF_TYPE_ENC(15, BTF_INFO_ENC(BTF_KIND_STRUCT, 1 /* kind bit */, 2), 8),
> +		BTF_MEMBER_ENC(19, 1, 0), /* int cnt; */
> +		BTF_MEMBER_ENC(23, 2, 32),/* struct bpf_spin_lock l; */
> +	    };
> +
> +	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
> +			     strs, sizeof(strs), token_fd));
> +}
> +
>   typedef int (*feature_probe_fn)(int /* token_fd */);
>   
>   static struct kern_feature_cache feature_cache;
> @@ -582,6 +609,9 @@ static struct kern_feature_desc {
>   	[FEAT_BTF_QMARK_DATASEC] = {
>   		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
>   	},
> +	[FEAT_BTF_TYPE_KIND_FLAG] = {
> +		"BTF btf_type can have the kind flags set", probe_kern_btf_type_kind_flag,
> +	},
>   };
>   
>   bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8e1edba443dd..392779c10a73 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3113,9 +3113,10 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
>   	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
>   	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>   	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
> +    bool has_kind_bit_support = kernel_supports(obj, FEAT_BTF_TYPE_KIND_FLAG);
>   
>   	return !has_func || !has_datasec || !has_func_global || !has_float ||
> -	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec;
> +	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec || has_kind_bit_support;
>   }
>   
>   static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
> @@ -3128,6 +3129,7 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>   	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
>   	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>   	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
> +	bool has_kind_bit_support = kernel_supports(obj, FEAT_BTF_TYPE_KIND_FLAG);
>   
>   	char name_gen_buff[32] = {0};
>   	int enum64_placeholder_id = 0;
> @@ -3263,6 +3265,64 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>   				m->type = enum64_placeholder_id;
>   				m->offset = 0;
>   			}
> +		} else if (!has_kind_bit_support && (btf_is_struct(t) || btf_is_union(t) || btf_is_fwd(t) || btf_is_enum(t) || btf_is_enum64(t))) {
> +			const uint16_t members_cnt = btf_vlen(t);
> +
> +			/* type encoded with a kind flag */
padding seem to be broken here a little bit, I can see some spaces here.
> +		    if (t->info != BTF_INFO_ENC(btf_kind(t), 1, members_cnt)) {
> +		        continue;
> +		    }
> +
> +		    /* unset kind flag anyway */
> +		    t->info = BTF_INFO_ENC(btf_kind(t), 0, btf_vlen(t));
> +
> +		    /* structs an unions has a different bitfield processing behaviour is kind flag is set */
"if kind flag is set" ?
> +		    if (btf_is_struct(t) || btf_is_union(t)) {
btf_is_composite()
> +		        struct btf_member* members = btf_members(t);
> +				struct btf_type* new_int_type = NULL;
> +				int new_int_type_id;
> +				__u32* new_int_type_data;
I'd go with simpler var names:
new_type, new_tid, new_type_data
> +				int encoding = 0;
> +		        int nmember;
padding again. Did you run checkpatch.pl script on this patchset by any 
chance? It should point out these type of style issues?
> +
> +		        for (nmember = 0; nmember < members_cnt; nmember++) {
perhaps i, j or k instead of nmember will do better here.
> +		            struct btf_member* member = &members[nmember];
> +		            const struct btf_type* member_type = btf_type_by_id(btf, member->type);
> +
> +		            while (btf_is_typedef(member_type)) { /* unwrap typedefs */
It looks like you should use `btf__resolve_type` here, as there are not 
only typedefs, but also volatile, const types that you may need to walk
through.
Don't add {} for one line loop or if expression.
> +		                member_type = btf_type_by_id(btf, member_type->type);
> +		            }
> +
> +		            /* bitfields can be only int or enum values */
> +		            if (!(btf_is_int(member_type) || btf_is_enum(member_type))) {
> +		                continue;
> +		            }
> +
> +		            encoding = btf_int_encoding(member_type);
> +		            if (btf_is_enum(member_type) && member_type->info & 0x80000000 /* kind flag */) {
there is `btf_kflag` helper function.
> +		                /* enum value encodes integer signed/unsigned info in the kind flag */
> +		                encoding = BTF_INT_SIGNED;
> +		            }
> +
> +		            /* create new integral type with the same info */
> +		            snprintf(name_gen_buff, sizeof(name_gen_buff), "__int_%d_%d", i, nmember);
> +		            new_int_type_id = btf__add_int(btf, name_gen_buff, member_type->size, encoding);
> +
> +		            if (new_int_type_id < 0) {
> +		                pr_warn("Error adding integer type for a bitfield %d of [%d]", nmember, i);
> +		                return new_int_type_id;
> +		            }
> +
> +		            new_int_type = btf_type_by_id(btf, new_int_type_id);
> +
> +		            /* encode int in legacy way, keep offset 0 and specify bit size as set in the member */
> +		            new_int_type_data = (__u32*)(new_int_type + 1);
> +		            *new_int_type_data = BTF_INT_ENC(encoding, 0, BTF_MEMBER_BITFIELD_SIZE(member->offset));
> +
> +		            member->type = new_int_type_id;
> +		            member->offset = BTF_MEMBER_BIT_OFFSET(member->offset) /* old kernels looks only on offset */;
> +		        }
> +		    }
>   		}
>   	}
>   
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 76669c73dcd1..6369c5520fce 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -380,6 +380,8 @@ enum kern_feature_id {
>   	FEAT_ARG_CTX_TAG,
>   	/* Kernel supports '?' at the front of datasec names */
>   	FEAT_BTF_QMARK_DATASEC,
> +	/* Kernel supports kind flag */
> +	FEAT_BTF_TYPE_KIND_FLAG,
>   	__FEAT_CNT,
>   };
>   



