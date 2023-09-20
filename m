Return-Path: <bpf+bounces-10460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759547A8920
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA301C209D4
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17E3C6B5;
	Wed, 20 Sep 2023 16:00:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3F3C6AA
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:00:12 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA4CC2
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:11 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c454a5f3c7so9807a34.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695225611; x=1695830411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GARuZLjax5ZehW3tqP+adtXUOBpLk790EcyUIQ2WXt8=;
        b=eqYAJPTGONkRqh84dgtBN/q1aMrTpM20SENuFj1qmntW+R+40utMbeKL+9Y7VxRR9k
         zEjJBgTbSbW8DXWxk9xsPy5YFvLTreWkyITxocrGu9avn+hUGBjs7JoEMOP1busYz+na
         a4jjE+R0D01BMEWiJn270M94MwdyIf6JRF6D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225611; x=1695830411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GARuZLjax5ZehW3tqP+adtXUOBpLk790EcyUIQ2WXt8=;
        b=FmPSOy2BfTmD7jcGVWRwL1bpLcGHD97TT0ztbSBFI76b8516uasxhYDFp5WNRI7lGz
         4AGpz+U0fXdgNUPWlT12PZ+7aC4joPPedd1i6L9aODVPFTjG8eA7IN4obIX5WEtxD8wD
         QF+8U7PYWfa+RpliuGrYOgdBMISvUuBVeAj4ph+AjKI03Oc9BcQoai3ASBBTju7kCPVC
         shCFohJFUzpjiDZH2I4zpNxsRt9Wktzas/2KArqZQPSjR+BNkthaCuePRqlflBPhg+Ly
         dYA5FB6VPQMIt7AvGgTi9WH7DgyU82o5/5sCFWCnJBWAI4w23PPau1rQ/klpRcXdGHfv
         OuMg==
X-Gm-Message-State: AOJu0YwiulVeOUz8X5CgolRrWfdmasD1CKjq1Y2stgavDFn4ekA4Ieco
	I7k1GlAf9m50E4fBW97OtuNFhxqUdQz/JQRaNe0=
X-Google-Smtp-Source: AGHT+IG+VqDNgI7sB2xdy/PCcSuPtd/kb07w3J4N/Vw2FSOKK2lG5rBkUWZUgWkl2Y2PTEjT0/xe5g==
X-Received: by 2002:a05:6358:50cc:b0:133:a55:7e26 with SMTP id m12-20020a05635850cc00b001330a557e26mr4173746rwm.7.1695225610811;
        Wed, 20 Sep 2023 09:00:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e9-20020a63ae49000000b00578f1a71a91sm546785pgp.79.2023.09.20.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:00:10 -0700 (PDT)
Date: Wed, 20 Sep 2023 09:00:09 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH v3 4/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
Message-ID: <202309200859.D8E31893F4@keescook>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-5-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918212459.1937798-5-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 11:24:58PM +0200, KP Singh wrote:
> [...]
> +void bpf_lsm_toggle_hook(void *addr, bool value)
> +{
> +	struct lsm_static_call *scalls;
> +	struct security_hook_list *h;
> +	int i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(bpf_lsm_hooks); i++) {
> +		h = &bpf_lsm_hooks[i];
> +		scalls = h->scalls;
> +		if (h->hook.lsm_callback == addr)
> +			continue;
> +
> +		for (j = 0; j < MAX_LSM_COUNT; j++) {
> +			if (scalls[j].hl != h)
> +				continue;
> +			if (value)
> +				static_branch_enable(scalls[j].active);
> +			else
> +				static_branch_disable(scalls[j].active);
> +		}
> +	}
> +}

And this happily works with everything being read-only? I double-checked
these structures, and it seems like the answer is "yes". :)

So, to that end:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

