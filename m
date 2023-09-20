Return-Path: <bpf+bounces-10485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E2A7A8CB8
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 21:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB3A1C209C8
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6373714F;
	Wed, 20 Sep 2023 19:24:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF423CD0E
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 19:24:30 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49E99F
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 12:24:28 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-578aca5a6bbso76388a12.1
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 12:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695237868; x=1695842668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbkk6hz3XsIl+HyZho/PKECXy7y/OprsUmNHvfxO5Ic=;
        b=PuyaXsLW8bmQg9pl9NLPku49J91+nxRDXvRxSDP1C/o5ZSWSW3Iyv1PXnpHLtSizL7
         zeeZg/JcK94oZCWBimd4GvXDvNPqFmpmZtFEK18GQkQcUWAf1RMi8xo5H2q9Idfq/WeU
         o5HW6yWOXooVH3Sc6plnKtoFrrI7rwWZlLqy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237868; x=1695842668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbkk6hz3XsIl+HyZho/PKECXy7y/OprsUmNHvfxO5Ic=;
        b=LzmshvpbSmKysBUx+hzh9Fb8DV/HAfL6xQinLwAa2H2Vq8twzHbzB4N9LkvbbMW73E
         pSS4Mo8RrLzbGQfzvlRzBXf1vMR2Wr93yu4uvaP9bueaS92uVXlUhR1Rg3b2j/t33Q4J
         rqCzCt5XmdNSX64suNYjUtg0Sn5wIafQFcwo9KdagGEC3ViaFE+LepBTM9Bjg+VEqA2J
         nZn2iR62tpIxKw/xp35DZUSBQ4u8D9m6t3FHCeUUs2JYWVwfO/4x+vbvXo//c6gYxECB
         7WxSuDj8UeLv9jZ21vo2Fegyj0AxmWVtUfz1LoWOC566c2cxSG1WjLNBbmLkQaybpHP8
         02TQ==
X-Gm-Message-State: AOJu0YzHgKPoLWIyymZn7Dy/QHED1/ype2PXgdXs8mpoS2ETNqxsaY31
	ocyynB6HDumKSi0g1FFhr8+B2NibZM3SkhZXSHM=
X-Google-Smtp-Source: AGHT+IHRSye8QE+aWI++EX2U6GXV5VK/MwMR/Sxvbydxbkc0t16NEDXtfQUuSkg2yfOlJI1h0KfKsg==
X-Received: by 2002:a05:6a20:5485:b0:153:8754:8a7f with SMTP id i5-20020a056a20548500b0015387548a7fmr3943631pzk.4.1695237868064;
        Wed, 20 Sep 2023 12:24:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id dh2-20020a056a00478200b00690bd3c0723sm3366388pfb.99.2023.09.20.12.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:24:27 -0700 (PDT)
Date: Wed, 20 Sep 2023 12:24:26 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, song@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, Kui-Feng Lee <sinquersw@gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
Message-ID: <202309201221.205BA18@keescook>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
 <98b02c73-295d-baad-5c77-0c8b74826ca9@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98b02c73-295d-baad-5c77-0c8b74826ca9@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/2023 2:24 PM, KP Singh wrote:
> [...]
> +#define __COUNT_COMMAS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
> +#define COUNT_COMMAS(a, X...) __COUNT_COMMAS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> +#define ___COUNT_COMMAS(args...) COUNT_COMMAS(args)

Oh! Oops, I missed that this _DOES_ already exist in Linux:

cf14f27f82af ("macro: introduce COUNT_ARGS() macro")

now in include/linux/args.h as COUNT_ARGS():

#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)

I think this can be refactored to use that?

-Kees

-- 
Kees Cook

