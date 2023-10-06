Return-Path: <bpf+bounces-11588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1BD7BC22B
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 00:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D751C20A18
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696F845F44;
	Fri,  6 Oct 2023 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ON2TIh5+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA53450DF
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 22:19:57 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF01BE
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 15:19:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5827f6d60aaso1791328a12.3
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696630794; x=1697235594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec5NVHbOagI42dAvgiLFB5L5PsJa40bcRKKQnaC9gmQ=;
        b=ON2TIh5+R6axoaeHGclGeaglqFrSBEMyFQZceJ2K+Tsp9S+fTRZpJKp12KGEYKJ+La
         QObSxdHSXGUVxyNjMpDDCZB3BO+HCPsWsP3WAmSMr44CRYP7P2zD2azSfVkyRTjP5+rz
         hiPPx8mnG/x/qCH9xmdCm3IXW6AoYUzHW/W0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630794; x=1697235594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec5NVHbOagI42dAvgiLFB5L5PsJa40bcRKKQnaC9gmQ=;
        b=RroPHVieRpEsRMwA1Vl4GyAPArPBfXfjZeyysOrTcMhBR7u/jHflKWJEXOcYL+QXsV
         i2jbiv+bw4n+qZZJHPYV1XW8oJvxQZYtKgn2TKRQ2cGv/pIP3oQgLULOf3dNsK90BPZa
         NwLYB3dROFhwsUrk5Ro6/fzSHL925dgNP9TCUXX3j+azyRKgub8HugJ81SDuViUt6wzG
         MSdS1U4R3HF9YQPEQGpr0B2gqLloY3CD+WJ75cO9qZDsPh2dEd84JrCc44SigELqaOU6
         Dlj5wSy3nnxLQCsltyDPeAyCgl5eh/LNirusgqxYu9ov0zU0fXVSC9ahYi4lmQpvlTKr
         8oEg==
X-Gm-Message-State: AOJu0YzLMg6d9mH5z5jGC490Zzjvb0cQ9+7YhievrIAQTUmxrJTx6U6N
	xX2+6UxBEQyqEh0hD8LDGZVxEA==
X-Google-Smtp-Source: AGHT+IEey6lOaoGA9MCcQYpZbetqjfB4y53xgl/tiG/jQHm6b7ng4VEgrIdMet51CFBr3t9yqWxMRQ==
X-Received: by 2002:a17:90b:4f46:b0:267:f9c4:c0a8 with SMTP id pj6-20020a17090b4f4600b00267f9c4c0a8mr9120373pjb.4.1696630794515;
        Fri, 06 Oct 2023 15:19:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lj4-20020a17090b344400b0026cecddfc58sm6048065pjb.42.2023.10.06.15.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:19:53 -0700 (PDT)
Date: Fri, 6 Oct 2023 15:19:50 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
	pabeni@redhat.com, Kui-Feng Lee <sinquersw@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v6 2/5] security: Count the LSMs enabled at compile time
Message-ID: <202310061519.7A41CF216C@keescook>
References: <20231006204701.549230-1-kpsingh@kernel.org>
 <20231006204701.549230-3-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006204701.549230-3-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 10:46:58PM +0200, KP Singh wrote:
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
> 
> Without this one would need to generate static calls for the total
> number of LSMs in the kernel (even if they are not compiled) times the
> number of LSM hooks which ends up being quite wasteful.
> 
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

