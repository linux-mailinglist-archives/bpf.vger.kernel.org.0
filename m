Return-Path: <bpf+bounces-10453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989537A88B8
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 17:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EB628147F
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB23D3C698;
	Wed, 20 Sep 2023 15:44:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B43C684
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 15:44:56 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07119B4
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:44:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c328b53aeaso62725285ad.2
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695224694; x=1695829494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQNo/7m+9++c/N59rrtD7EFgYIcDr9yhzLesZUcLlbI=;
        b=D7KSFNsgMgUF9jumnNwcCdCpkQtizbxnfZJUCkWtLEzsQkxe2zqNNvCiKKTDhwk2Ua
         DWNXbS5CUC68TG1vSgVtxqU2zC321cw3vRotW2zLlQC+jgXxRR3W3b1QZ/vfxqJ/Bnn+
         xgraNgUif/bLx1zNaka762rjME3UCz4PUPFw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224694; x=1695829494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQNo/7m+9++c/N59rrtD7EFgYIcDr9yhzLesZUcLlbI=;
        b=v9t/HA9Xy7d6ymuNpnJhlTpUQoyU95zpXQumszGkRkJqtxe52TT3wv9Pzfg6RKv4zn
         UuX1C5c9PvsBP7W3dcUmuVmTBHUNS/b2R8LDhlSTqPw2s/e3lqA/LDBg3pltPaGlgTc4
         1hb+vTcZaSYdtCZ9Cue3PcAPzU+fyosaSMDWDf5rOg45A7WUlxpkfn2I0ULPiVsmT4wE
         v9TJdU3XEJz09QKq+7T7p/7TFCrNs1LcClRTZFgFhwVqmAaz2cAEm9phPad/LpvfEmXG
         mf+6cNz2Gp8/5Wv+xQ0B/8OfIwlWJDKd27w/LTsVtimrD7if8hDzjRcktFYxgLKrvqyc
         JNZg==
X-Gm-Message-State: AOJu0YxqRBwnYL/fLTXwz7DQA3PUs/v99KA6bPkLMjX9Ke7MgcZRTFBy
	Ql41hUsdv7tS+dpFLJ7faae7lUCT1FzS9PKIIjg=
X-Google-Smtp-Source: AGHT+IHRAS+gnucMNkh5YLNn4zi1V35FmEsgOxnUBXnohSRpWJbdgtifaPuh8zXnvg0GrB8kYDJShA==
X-Received: by 2002:a17:902:d88e:b0:1c5:ae89:e1bc with SMTP id b14-20020a170902d88e00b001c5ae89e1bcmr2398804plz.65.1695224694423;
        Wed, 20 Sep 2023 08:44:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001b694140d96sm12044869plf.170.2023.09.20.08.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:44:53 -0700 (PDT)
Date: Wed, 20 Sep 2023 08:44:53 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH v3 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202309200840.722352CCB@keescook>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-6-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918212459.1937798-6-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 11:24:59PM +0200, KP Singh wrote:
> This config influences the nature of the static key that guards the
> static call for LSM hooks.
> 
> When enabled, it indicates that an LSM static call slot is more likely
> to be initialized. When disabled, it optimizes for the case when static
> call slot is more likely to be not initialized.
> 
> When a major LSM like (SELinux, AppArmor, Smack etc) is active on a
> system the system would benefit from enabling the config. However there
> are other cases which would benefit from the config being disabled
> (e.g. a system with a BPF LSM with no hooks enabled by default, or an
> LSM like loadpin / yama). Ultimately, there is no one-size fits all
> solution.
> 
> with CONFIG_SECURITY_HOOK_LIKELY enabled, the inactive /
> uninitialized case is penalized with a direct jmp (still better than
> an indirect jmp):
> [...]
> index 52c9af08ad35..bd2a0dff991a 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -32,6 +32,17 @@ config SECURITY
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> +config SECURITY_HOOK_LIKELY
> +	bool "LSM hooks are likely to be initialized"
> +	depends on SECURITY
> +	default y
> +	help
> +	  This controls the behaviour of the static keys that guard LSM hooks.
> +	  If LSM hooks are likely to be initialized by LSMs, then one gets
> +	  better performance by enabling this option. However, if the system is
> +	  using an LSM where hooks are much likely to be disabled, one gets
> +	  better performance by disabling this config.

Since you described the situations where it's a net benefit, this could
be captured in the Kconfig too. How about this, which tracks the "major"
LSMs as in the DEFAULT_SECURITY choice:

	depends on SECURITY && EXPERT
	default BPF_LSM || SECURITY_SELINUX || SECURITY_SMACK || SECURITY_TOMOYO || SECURITY_APPARMOR


-- 
Kees Cook

