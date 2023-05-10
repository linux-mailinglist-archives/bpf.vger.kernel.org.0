Return-Path: <bpf+bounces-303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BC26FE31F
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 19:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55482813AB
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DE314A81;
	Wed, 10 May 2023 17:15:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85E1642C
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 17:15:37 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CAC59DC
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 10:15:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aae5c2423dso72960215ad.3
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683738923; x=1686330923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYOXJLDk4oO5B5DqTnmd/XXQFJ3wMOXEkgNVujRw7SA=;
        b=BOfJPDuBqb8LfCw74gdO3fViG/N6ZX/TC6i2ttArpoTMPRxTTTea3CYwnKf6ShWb11
         fRBJ9ziHDrKhsgQ+DpJ/L3sbqz9h4SMTYmOAqORcICeKtHLLxZ5yDWGEeESkWAT03qjj
         padgEso2TfOzQrqUuqrBEW8TWhIVI1bIQ1xuFyJDXFMrEgiSDKXyynTw5kHg9dL+74bl
         Zw5WEBvPuLQmt1tmyglzlgT7s3xc+JgjigAY4ioKnt/BUCtWN2UoUpMbGa6r7oqcaCoe
         9hjJMJcUPw/p8hNEtwUMD7trHk4jY/8bvYSyNckF890TA6HvOSiiUA0qfAtaujAtd3mB
         9YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683738923; x=1686330923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYOXJLDk4oO5B5DqTnmd/XXQFJ3wMOXEkgNVujRw7SA=;
        b=N9pxjqipE8icw/Al6Gt0j05wxopJ6lmCHaGCJapW0E+abp3/88r2INiSX9v4y1QAQS
         8kLsyE3MyoUcsaqoB6ZrgdncvPf1DPLZTDK3gYS6v9lIuxdi4rWR0lKKBf2wuyVtbA6B
         LpOTlhdYeAXJUZbpb/4lBSTb54UUi9eonw/Aq0+pNPrlgBdd1tWVF+Oc5CyVkHQAur9U
         Rwg0WUdzngxznZpc9mu4mzgxKk0oxOHQqpABzuUZFM2LmMd/OuY7LYwZ8fOW4mBhCoQ4
         ziqdePgQVTaPwT1aWUTg7mc3qCcfpErIOHaMxs4m/3uDwaJQ7YxKzOOTZJzGcY2OVZJy
         G3AQ==
X-Gm-Message-State: AC+VfDxA1U5Qpi+Nw3hnnaGPBb/8sX8w65PdyI7z7hGiNWuzx8VTSbSJ
	Dus17P6/LORHbTGhgVE4IGk=
X-Google-Smtp-Source: ACHHUZ43+gQZ0U5rJWrYwv95BPpQdmUQ1ACjWyNWhrQRBn4ThhX0bsfO6BEpwzA8sC/WJxLXFnL5YA==
X-Received: by 2002:a17:902:e842:b0:1ab:17dc:d495 with SMTP id t2-20020a170902e84200b001ab17dcd495mr24270719plg.27.1683738922710;
        Wed, 10 May 2023 10:15:22 -0700 (PDT)
Received: from krava ([2001:4958:15a0:30:84fc:2d48:aeac:9034])
        by smtp.gmail.com with ESMTPSA id o23-20020a170902779700b001ac706dd98bsm4068521pll.35.2023.05.10.10.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 10:15:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 May 2023 10:15:20 -0700
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	acme@kernel.org, laoar.shao@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Add
 --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags
 for v1.25
Message-ID: <ZFvRKHn7I6FVRJXn@krava>
References: <20230510130241.1696561-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510130241.1696561-1-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 02:02:41PM +0100, Alan Maguire wrote:
> v1.25 of pahole supports filtering out functions with multiple inconsistent
> function prototypes or optimized-out parameters from the BTF representation.
> These present problems because there is no additional info in BTF saying which
> inconsistent prototype matches which function instance to help guide attachment,
> and functions with optimized-out parameters can lead to incorrect assumptions
> about register contents.
> 
> So for now, filter out such functions while adding BTF representations for
> functions that have "."-suffixes (foo.isra.0) but not optimized-out parameters.
> This patch assumes that below linked changes land in pahole for v1.25.
> 
> Issues with pahole filtering being too aggressive in removing functions
> appear to be resolved now, but CI and further testing will confirm.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  scripts/pahole-flags.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 1f1f1d397c39..728d55190d97 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>  	# see PAHOLE_HAS_LANG_EXCLUDE
>  	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>  fi
> +if [ "${pahole_ver}" -ge "125" ]; then
> +	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> +fi
>  
>  echo ${extra_paholeopt}
> -- 
> 2.31.1
> 

