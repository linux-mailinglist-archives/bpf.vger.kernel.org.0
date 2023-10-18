Return-Path: <bpf+bounces-12534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8497CD841
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 11:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27232B211C9
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85E18045;
	Wed, 18 Oct 2023 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw3BBQSI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEF918038
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 09:35:29 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ECCF7;
	Wed, 18 Oct 2023 02:35:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c8a1541232so57257295ad.0;
        Wed, 18 Oct 2023 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697621728; x=1698226528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psAbZY+RKpKnuz5/JIWWeE0XC1sus4pMagqwUPmeN2E=;
        b=Gw3BBQSIjI0j3LnnO8TS2PGWDLAzMq8MJlOAm+DhBRBP/PDtLYMyVYvod5ymv2Aytr
         HGc4cxfvAyhgEDvmtV4wK22tmViSjtCl52RRMZ+2FWSsEFxSp+fIRt0wjA1+S1y37XHi
         0aFhFpJ7doMm+Kh7JdUsy0DfA914XuijFFkenbzRlT+2dUguE6GglDeOIR19FQByR31w
         ciOaXfCP3QaS5j4M8HyPc/jckV+w65TjVWRVL/1ihPNGsxqiilo22m0O2xeIpxIgls6A
         bvUZIRk9l3nILGJ4W8NcFMZ1jjwKn3QAQ0o+V2CUemHINT5FkVA5GU17EF4FWrMF7jlh
         2t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621728; x=1698226528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psAbZY+RKpKnuz5/JIWWeE0XC1sus4pMagqwUPmeN2E=;
        b=isSCtDpAE8wnBBhlkBDtPRaseTTwWSZnFIVqlR0DedRUiVpLYo4NmH8WrhD8gocFZh
         X0llAxC0SL70ArLMqluMdRqQf29GracU5Kj01gYarPzOhL4EedNWIVPq0hjCDdsaC+oE
         4nTgR2x1aErvyGwa931MGIFnydOmbXPbvdscduRdCKyUjbpcgn3ZMQ0Soa3p/qk0XW9u
         lh2u7jJ0CpNFjmoM/zOWLun2/wIJ9G+wc0A2GDTAhO7LLTMQJxXpDOOmZpHtbtNCjRw8
         tkQUEfW553VHShAMc27x5tVNPJCsNzCPqpeEsJRdOvUxJFQV2+7gJH4AF9EJ0YyWfNi6
         xO1w==
X-Gm-Message-State: AOJu0Yygo9TdgyksWABIgF9XQ11kHvnDFJlVyMvWhzY2jt1BRIjQexNs
	053TRgQ94aJRF3rjDsmlZeKx0wklZB3Bmg==
X-Google-Smtp-Source: AGHT+IGnz698gk8G5P3tfjcfQSu+6RdXhcejf0IlwNxYpxiHaAIhNCPfel926XOHOBCBzkVFgZfv9w==
X-Received: by 2002:a17:903:41cd:b0:1ca:9507:52 with SMTP id u13-20020a17090341cd00b001ca95070052mr5431903ple.67.1697621727580;
        Wed, 18 Oct 2023 02:35:27 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709027e8f00b001c726147a45sm3126886pla.190.2023.10.18.02.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:35:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 17 Oct 2023 23:35:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the
 cgroup root_list RCU safe
Message-ID: <ZS-m3t-_daPzEsJL@slm.duckdns.org>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
 <20231017124546.24608-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017124546.24608-2-laoar.shao@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 12:45:38PM +0000, Yafang Shao wrote:
>  #define for_each_root(root)						\
> -	list_for_each_entry((root), &cgroup_roots, root_list)
> +	list_for_each_entry_rcu((root), &cgroup_roots, root_list,	\
> +				!lockdep_is_held(&cgroup_mutex))

Shouldn't that be lockdep_is_held() without the leading negation?

> @@ -1386,13 +1386,15 @@ static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
>  		}
>  	}
>  
> -	BUG_ON(!res_cgroup);
> +	WARN_ON_ONCE(!res_cgroup && lockdep_is_held(&cgroup_mutex));

This doesn't work. lockdep_is_held() is always true if !PROVE_LOCKING.

>  	return res_cgroup;
>  }
>  
>  /*
>   * look up cgroup associated with current task's cgroup namespace on the
> - * specified hierarchy
> + * specified hierarchy. Umount synchronization is ensured via VFS layer,
> + * so we don't have to hold cgroup_mutex to prevent the root from being
> + * destroyed.
>   */

Yeah, as Michal said, let's not do it this way.

Thanks.

-- 
tejun

