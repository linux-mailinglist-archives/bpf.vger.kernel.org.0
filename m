Return-Path: <bpf+bounces-11088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF3E7B29A0
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 02:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C28E0282770
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 00:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B6E15A3;
	Fri, 29 Sep 2023 00:37:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D06646
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 00:37:05 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886E61A4
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 17:37:04 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af5fd13004so1647245b6e.0
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 17:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695947824; x=1696552624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+nBnzcJJ7xEy+h+rie43j8O0Ss49rlif7Rw69Zqx9E=;
        b=Yew1IOK8SankL2LehubJpai1i7dER+tJuegS1CVW5AyzR84KBrUF3+FM1eewNT6wNY
         l8DNQ7OSUQlZVbeTCn+Klo7p3fifcLFNbqPPQ3s5q1dhXSChM2x74OElGBLyuy1Y6/LO
         ltEReAOOptlhz/lrVkaEYN4POW8qw6Vl4ZDy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695947824; x=1696552624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+nBnzcJJ7xEy+h+rie43j8O0Ss49rlif7Rw69Zqx9E=;
        b=fmG97exmg65VtRusZx0kA4b2mjdWaGo0E8myRYj4pZYUkeUce5xK32qnMWbwUmnpA8
         qf/qtEAMhTPj5l2J+wo9j4S0meav2cocWsqUKb0eFeSbIBrM9OL9Dns65KRiaYtXpq8q
         /Pg8mJIYep6F9wARf3r2vZ6xK/RSKwrSQDB5CEFekZRgMadw33c2VSFU3uGdD3ef5v3X
         ArMcD6brt2CAABOu4OAJLsJvZxxtD4yb1yXmJLIukU3DsuA6sTQg35jM3mg7HtRIzdh3
         YrbtU2TLSN43wHL1+5n5h1/LQXIskOkfGQPqpUALKClWGTYauwj+RKEoA8Fjg9eaktT+
         xlHA==
X-Gm-Message-State: AOJu0Yxa4yhM7j1gM/LBXFeyZw/sFzZZMUWR6tggE5tmtcw1PAE+MfAG
	knBw61SS1ioNGRj9UZBXAUG63Q==
X-Google-Smtp-Source: AGHT+IHqoAYcIt2C+tgcA8ZtaPigw4o8v2oIltMhYNCuA6I66P8BF8ERIzHBkEh5TvogpttCseMOkg==
X-Received: by 2002:a05:6870:9720:b0:1d5:c134:cecb with SMTP id n32-20020a056870972000b001d5c134cecbmr3043273oaq.1.1695947823867;
        Thu, 28 Sep 2023 17:37:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o17-20020a639211000000b00578d0d6e8desm13542196pgd.9.2023.09.28.17.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:37:03 -0700 (PDT)
Date: Thu, 28 Sep 2023 17:37:02 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
	Kui-Feng Lee <sinquersw@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v5 2/5] security: Count the LSMs enabled at compile time
Message-ID: <202309281736.4E7D88678@keescook>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
 <20230928202410.3765062-3-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928202410.3765062-3-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 10:24:07PM +0200, KP Singh wrote:
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

Thanks for doing the refactor with the existing macro!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

