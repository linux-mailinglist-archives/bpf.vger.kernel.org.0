Return-Path: <bpf+bounces-22-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D8F6F76E7
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE281C21471
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109BF79F6;
	Thu,  4 May 2023 20:07:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515C156C9
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 20:07:06 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8D4AD09
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 13:06:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aafa41116fso6601405ad.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683230747; x=1685822747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=umDQ2ESo7O8j4U57CGmUv05OdgErIksx0biN/DIj3/I=;
        b=i+dAwtAa3TmX8iDMoamjSOLbqdm6cqoLRX/X38qk+oqAswY9P7AZVkBgUvBHVh+u9J
         KoyKVfq2GHilK55Ulbm9qlLN0Xmhv8SfKeJfyLKT1HSAVA9pTUpPn6c37x/6PePm+4lm
         qe8yh2KMcDa/5L6NOt5cAz2LSJcmIKg+awPoQnbpEkSp5H4fOTiDRMsG4bbUStlJPSKj
         wBC93slxDgvAG2/Bdrk9xyAUlgqApa/i+fZO6PULQqKdtZuz8anRNSRHHjAdfPKWPwDY
         5cftCnNNSW/P4uap+QSEj+98GuuMe4wtII27dmXf7zrSR2loRc2f7V2rkfuOH07ejZbp
         jJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683230747; x=1685822747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umDQ2ESo7O8j4U57CGmUv05OdgErIksx0biN/DIj3/I=;
        b=CX9V+54S6r0HfPaXGg9SKDLjzka2TOBFTxOJWJTjnFT2WGF8RiMlKxuJ5MFyNmYZIw
         Fnj6CGbiCyxSUXhTFthpvwePu4nPm5N9M3G7yvKVmOoIVrwjN45ovRDYUGje1WlVFJCZ
         8qtdHk9Bysb9NMHYQseZHvZ8kcWWOH1sspkpNkTHg+plZBu+KA1bIzJr17p91hGkM9oV
         QqVfrEM16rduYfpbmYvCof3GI3Mw9Xint84IXbIjZmEAwGwET5sWXqMhXMVzGR82syYj
         H2v3rIdndo+rG5eomg+5TnpYu7TaBKT84rPBGsAfIY+wO2ki4ibQYZFlCxVfNz67I97y
         SCjg==
X-Gm-Message-State: AC+VfDyD5M4CfsBxPzttOBCZzvNBIPd8kmj60kwFYzqEdL2FmaQ93p2W
	B0SF4RX+f96M3M9ytlXT5Vg=
X-Google-Smtp-Source: ACHHUZ5C0rJRf885B8g2WxlxwupwEfar742ymNnKhCo5pL9zTFRetB4unc5voSKETWdAOAh9QdRt7g==
X-Received: by 2002:a17:903:48c:b0:19d:1bc1:ce22 with SMTP id jj12-20020a170903048c00b0019d1bc1ce22mr4647373plb.5.1683230747228;
        Thu, 04 May 2023 13:05:47 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::6:168f])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090322cb00b001a6d08eb054sm5688873plg.78.2023.05.04.13.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 13:05:46 -0700 (PDT)
Date: Thu, 4 May 2023 13:05:44 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 04/10] bpf: remember if bpf_map was unprivileged
 and use that consistently
Message-ID: <20230504200544.mikkqyc7h7ftxal3@MacBook-Pro-6.local>
References: <20230502230619.2592406-1-andrii@kernel.org>
 <20230502230619.2592406-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502230619.2592406-5-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 02, 2023 at 04:06:13PM -0700, Andrii Nakryiko wrote:
>  }
>  
> -static struct bpf_map *array_map_alloc(union bpf_attr *attr)
> +static u32 array_index_mask(u32 max_entries)
>  {
> -	bool percpu = attr->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
> -	int numa_node = bpf_map_attr_numa_node(attr);
> -	u32 elem_size, index_mask, max_entries;
> -	bool bypass_spec_v1 = bpf_bypass_spec_v1();

static inline bool bpf_bypass_spec_v1(void)
{
        return perfmon_capable();
}

> +		/* unprivileged is OK, but we still record if we had CAP_BPF */
> +		unpriv = !bpf_capable();

map->unpriv flag makes sense as !CAP_BPF,
but it's not equivalent to bpf_bypass_spec_v1.

>  		break;
>  	default:
>  		WARN(1, "unsupported map type %d", map_type);
>  		return -EPERM;
>  	}
>  
> +	/* ARRAY-like maps have special sizing provisions for mitigating Spectre v1 */
> +	if (unpriv) {
> +		switch (map_type) {
> +		case BPF_MAP_TYPE_ARRAY:
> +		case BPF_MAP_TYPE_PERCPU_ARRAY:
> +		case BPF_MAP_TYPE_PROG_ARRAY:
> +		case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
> +		case BPF_MAP_TYPE_CGROUP_ARRAY:
> +		case BPF_MAP_TYPE_ARRAY_OF_MAPS:
> +			err = bpf_array_adjust_for_spec_v1(attr);
> +			if (err)
> +				return err;
> +			break;
> +		}
> +	}
> +
>  	map = ops->map_alloc(attr);
>  	if (IS_ERR(map))
>  		return PTR_ERR(map);
>  	map->ops = ops;
>  	map->map_type = map_type;
> +	map->unpriv = unpriv;
>  
>  	err = bpf_obj_name_cpy(map->name, attr->map_name,
>  			       sizeof(attr->map_name));
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ff4a8ab99f08..481aaf189183 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8731,11 +8731,9 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  	}
>  
>  	if (!BPF_MAP_PTR(aux->map_ptr_state))
> -		bpf_map_ptr_store(aux, meta->map_ptr,
> -				  !meta->map_ptr->bypass_spec_v1);
> +		bpf_map_ptr_store(aux, meta->map_ptr, meta->map_ptr->unpriv);
>  	else if (BPF_MAP_PTR(aux->map_ptr_state) != meta->map_ptr)
> -		bpf_map_ptr_store(aux, BPF_MAP_PTR_POISON,
> -				  !meta->map_ptr->bypass_spec_v1);
> +		bpf_map_ptr_store(aux, BPF_MAP_PTR_POISON, meta->map_ptr->unpriv);
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

