Return-Path: <bpf+bounces-10455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356417A88DE
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 17:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E8F1C209A2
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442663C69F;
	Wed, 20 Sep 2023 15:48:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2138DEB
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 15:48:15 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FD4A9
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:48:13 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-565e395e7a6so4112894a12.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695224892; x=1695829692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JG6AMx69HAwK3LvGawCCvsiysMo16gJkJBfu4krPdX4=;
        b=L6cQHymBGBbw4mCcBEECSQ1ouVljdF71w1E83JxX+tX0t4RKg2Dx0h9lKTLEQKeMwK
         xoyJXaZ9Ac3MrjuKyjF1j6gnEHDDyTU9sArG4I2ZY7ZgnO01OCdvCBXBrWwBRTXW3mWV
         Qht773L/wU/Bc41ikWoMHTA/CB539WL0JO310=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224892; x=1695829692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JG6AMx69HAwK3LvGawCCvsiysMo16gJkJBfu4krPdX4=;
        b=CTpYaZGPgcx+UNNjztbBDD1v0z2WdnFswE/icY5eZbbijHkiLrVh3trcgqgIBzM7mR
         KnVDH/DP5jEP9p3ypcnLi+n8uwYYyw13SmLr2hkJIXMvh66FFXTltdA/jkTCkv91h5gx
         JRv5A1T5dk47aBuz+6kHWPCJfrlYu35hPA7zOVZEPFVaZaNxo/Xuvr25XrlEK1NZtsPT
         MirAoofftf8INFUCfI8dAoT/f2hXoUfM0R1sXs8G/MaWxLgF191MMtHPSabF+NIciQ34
         uEB3g4v6xuLzBg6eFl/lUWv+iihY21t7/QtJqsA7n5sLLWAptJS32s28hU1ynv1+MFKg
         6QVg==
X-Gm-Message-State: AOJu0YxnI/8PZh+P30GcALioq3oNVHfmMq+2QAQsunXBQyuLFBLaVofK
	2dkZJdaUFx1bmDJVVocL5X9Eow==
X-Google-Smtp-Source: AGHT+IF3jUYC3V9O4e6ev1/IQ/oataOazO91sNIhbn8jC3dux8A4pM5zLj/0IGha9pWLZSSePT1FLA==
X-Received: by 2002:a17:90b:60f:b0:271:9237:a07f with SMTP id gb15-20020a17090b060f00b002719237a07fmr3157518pjb.32.1695224892075;
        Wed, 20 Sep 2023 08:48:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bb18-20020a17090b009200b0026fb228fafasm1489400pjb.18.2023.09.20.08.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:48:11 -0700 (PDT)
Date: Wed, 20 Sep 2023 08:48:11 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org,
	Kui-Feng Lee <sinquersw@gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
Message-ID: <202309200847.975DE8B704@keescook>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918212459.1937798-3-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 11:24:56PM +0200, KP Singh wrote:
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
> 
> Without this one would need to generate static calls for (number of
> possible LSMs * number of LSM hooks) which ends up being quite wasteful
> especially when some LSMs are not compiled into the kernel.
> 
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org
> Signed-off-by: KP Singh <kpsingh@kernel.org>

I may extract this into a separate header in the future -- I have plans
to make strscpy() take a variable number of arguments. ;) Regardless,
for the LSM usage:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

