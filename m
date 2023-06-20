Return-Path: <bpf+bounces-2953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FF5737652
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 22:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979AD2813BA
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 20:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8EA1775B;
	Tue, 20 Jun 2023 20:59:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA02AB2F
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 20:59:00 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28591727
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 13:58:58 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-394c7ba4cb5so3413158b6e.1
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687294738; x=1689886738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RyHaRq0HBfQqVo5s8buEN7LujzAfgb9I0SYf36k6c18=;
        b=gjpIAjNi0q26w85xbhx99EmvN7R5nLOdLbIyyNpHc/kPJZF1GdVg5ao/8mmRQk4KP2
         kbt+Q1mqU0Wp90KhCHzRb2hp9TadaSkyoankHAdYn2YpmNQDHJwP04B8+x7Dad2xF+wZ
         AmZQDdEcLYZ/ugQLWaaRrD7spqzmS05ZYSZ0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687294738; x=1689886738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyHaRq0HBfQqVo5s8buEN7LujzAfgb9I0SYf36k6c18=;
        b=i/SczBBHX9iZlhHH0IrznYWq3s5Z0x27RoeVoM8SH5McXuoEb5WDpK9/XzKW4zplsL
         zHaShzg8FjdxWeO9ZzsSfYDSp+q6JuSo5yKmKAQHfoy1jbVI26J0BUdFAV51e97zNg8c
         AbFXYcSWZzqd1YRqRtVF0zZO/3bnKrzqzahgO/Hmz5Fo1bCF8kIWTDi+NJbLG21QX6Lq
         Vnr77kEstJrZKwl3Q4fUntyKut+FkYIBtSY20WVOEtDeQcovRjPu1ZgnuxSkTGDPtJwf
         iigzTnIAUanB0FEBhyJAi+oBxf47MavxcpW80PdapE8RfK3mCyc05b9rGqFAktiIpva4
         8ssw==
X-Gm-Message-State: AC+VfDzrjlT123JOlLWI8SIqqU7exBSuNPW8It7sZK4bVmcK1dsNWqTa
	uNGDnFKzm2c2bimOmvzem7Oh50unBxCSQAvPk5k=
X-Google-Smtp-Source: ACHHUZ7IrFPQw4q1ooChD8KSBhUJhW14oI0ZPD00EolniJ7S6GpF+9CBIyAM2unv/zFTrCh0/X8bwA==
X-Received: by 2002:a05:6808:1143:b0:3a0:333e:1f4a with SMTP id u3-20020a056808114300b003a0333e1f4amr6239433oiu.15.1687294738245;
        Tue, 20 Jun 2023 13:58:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q136-20020a632a8e000000b00553dcfc2179sm1806811pgq.52.2023.06.20.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:58:57 -0700 (PDT)
Date: Tue, 20 Jun 2023 13:58:56 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, jannh@google.com
Subject: Re: [PATCH v2 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202306201356.CF454506@keescook>
References: <20230616000441.3677441-1-kpsingh@kernel.org>
 <20230616000441.3677441-6-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616000441.3677441-6-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 02:04:41AM +0200, KP Singh wrote:
> [...]
> @@ -110,6 +110,9 @@ static __initdata struct lsm_info *exclusive;
>  #undef LSM_HOOK
>  #undef DEFINE_LSM_STATIC_CALL
>  
> +#define security_hook_active(n, h) \
> +	static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY, &SECURITY_HOOK_ACTIVE_KEY(h, n))
> +
>  /*
>   * Initialise a table of static calls for each LSM hook.
>   * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CALL_KEY)
> @@ -816,7 +819,7 @@ static int lsm_superblock_alloc(struct super_block *sb)
>   */
>  #define __CALL_STATIC_VOID(NUM, HOOK, ...)				     \
>  do {									     \
> -	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {    \
> +	if (security_hook_active(NUM, HOOK)) {    			     \
>  		static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);	     \
>  	}								     \
>  } while (0);
> @@ -828,7 +831,7 @@ do {									     \
>  
>  #define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)			     \
>  do {									     \
> -	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
> +	if (security_hook_active(NUM, HOOK)) {    \
>  		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
>  		if (R != 0)						     \
>  			goto LABEL;					     \

I actually think I'd prefer there be no macro wrapping
static_branch_maybe(), just for reading it more easily. i.e. people
reading this code are going to expect the static_branch/static_call code
patterns, and seeing "security_hook_active" only slows them down in
understanding it. I don't think it's _that_ ugly to have it all typed
out. e.g.:

	if (static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY,		     \
				&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)) {	     \
  		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
  		if (R != 0)						     \
  			goto LABEL;					     \



-- 
Kees Cook

