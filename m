Return-Path: <bpf+bounces-10647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10AD7AB53D
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 17:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id DFD571C20A5F
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D574174F;
	Fri, 22 Sep 2023 15:50:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4A41AAB
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 15:50:53 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE81A3
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 08:50:51 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1727981a12.3
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695397851; x=1696002651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCt9r9r6pcwQ01zw7eTpBXFaLocd8WZkRBmpguNZjpw=;
        b=Cj5ODQZ/tWB/NEAdGYKcW0UfAGaITK6r+OZ9NsIbxHKSKqJHA92gSoCiFepmnyBirg
         RBNL1EqdG4FRwtYRKAmOWwIDoRQzrmfBLEtmCwnfJxKDZM2959FzKmE7zQ+vhOVdi92q
         /+iSrZU4J2MsC0/HWmVl/TTqKag2lY2TNATZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695397851; x=1696002651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCt9r9r6pcwQ01zw7eTpBXFaLocd8WZkRBmpguNZjpw=;
        b=VlkAfnvO9MzyPRGZz/ARVzRT1YMPUxbfvTIbwEy+/PN2zmJW/fh+Td2jsNNTAtRP37
         F9d6BiReiPHl/BG3u4PmRpgxwahiCbvvQz9Cm5Bx8/wXQpZaX5DNquZ9xXCVLe6/hk73
         JJ+TgiqXd4NlA7ZMdvoXs6t7P2TPfBZIwtpoXPNO8ebCfFzQaZwZC65ApKrJ63vSn4d2
         hW+5GZCjEzUNvORjcN+gOHgbTyw28/VAIJu/Cil49t5M73zzf+9+paQB/KsFVXwlO47Z
         DoxfhSkV8qGO/UouXr4pW4nJxzxn2IqXTLE44cd+bd3f5OV/WRut7//SZpbwMsdTimQI
         gJBQ==
X-Gm-Message-State: AOJu0Yxxa20XY4zzORw24XJGQVy70a7b2nyl1iCAOTenCT3O2uUaryzm
	CT6WwUmeXeCp40z3FYP3aNanYmwZn1yFwuiN98Y=
X-Google-Smtp-Source: AGHT+IFIZUJW8EvIXtaqBAUAN/5h1sgrri6MO1ZH4F/4vvitQe+RxprVzaGqaaM4oqel58v0tuLLhA==
X-Received: by 2002:a17:902:ce81:b0:1c5:f0fd:51b5 with SMTP id f1-20020a170902ce8100b001c5f0fd51b5mr874407plg.40.1695397851168;
        Fri, 22 Sep 2023 08:50:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d90300b001bbfa86ca3bsm3640333plz.78.2023.09.22.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 08:50:50 -0700 (PDT)
Date: Fri, 22 Sep 2023 08:50:50 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v4 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202309220850.E62D1EA217@keescook>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
 <20230922145505.4044003-6-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922145505.4044003-6-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 04:55:05PM +0200, KP Singh wrote:
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
> [...]
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Looks great!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

