Return-Path: <bpf+bounces-11090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A50E7B29CB
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 02:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CD63C2826C4
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 00:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39715A3;
	Fri, 29 Sep 2023 00:41:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E58646
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 00:41:04 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A0194
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 17:41:03 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3ae1916ba69so7206968b6e.2
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 17:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695948062; x=1696552862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XwfbFz7AC9k7AWBKDX0z2oZGXpJwVkw+x4UEe/Bp1hE=;
        b=XvTt8bAU4kO9540SuOhAJrnaQE8l8KyzNCkenBxMjk/XNXqospAG+TGmfUo+pWqx41
         9P1afxOfApN7hInDYvMF7bWdthHvc677sHidiq8RG7ziscsLglisfjsHm5L/bYGGzEjq
         uxYTW19bh+rj23G63iIsgDVRtn2BWc+IESN0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948062; x=1696552862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwfbFz7AC9k7AWBKDX0z2oZGXpJwVkw+x4UEe/Bp1hE=;
        b=OnTc9c2jKNDGsAvhaWoDipfUjt7ClnfkANaBMDJZPRFQ+0Y1U3u6gfpBiLdpxT/FyP
         8/XiR44Q36SHHrl4NSemauVaYetHC61OK2RWv9SGUD/FaAQM/3+xTt7mpJVmJN1Lr0Ft
         KjC2UcmV27TAPhyT+/Y+9QN/+pecVp3RKy18ukvy0nMp0haRdIwcYVAfK2hjkI275e97
         6gfeSS5i+tqs3Pl4QobubpljPLhjdiyrJiBJBPe8RZErnTpTz+b/ODsW0uL4Hy+YS2yl
         co19P/p5RdHlxsDgbboKpw1GFD3OpFnR80CfiMU9bGB1ApqVsEL/tNMWikz93N2aSesc
         GDcQ==
X-Gm-Message-State: AOJu0YwS2LMqQgwSjcOsAu58GOVN7AUgtSKKHrIiRhvzw1phdJfEAHLI
	t7eOrX58ZQm7U4zgjOc7dzKE/w==
X-Google-Smtp-Source: AGHT+IGStMPCGiqWjdMWha4VKtzOWCbr0+OekdeT6elVf8RwYnXoPEb+KM1RB+dk/XjWJH2hc3gpbA==
X-Received: by 2002:a05:6808:148:b0:3a7:7988:9916 with SMTP id h8-20020a056808014800b003a779889916mr2649682oie.59.1695948062337;
        Thu, 28 Sep 2023 17:41:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a63e444000000b0056428865aadsm13512890pgk.82.2023.09.28.17.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:41:01 -0700 (PDT)
Date: Thu, 28 Sep 2023 17:41:01 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>, paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	casey@schaufler-ca.com, song@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v5 0/5] Reduce overhead of LSMs with static calls
Message-ID: <202309281739.7C2963BC7@keescook>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928202410.3765062-1-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 10:24:05PM +0200, KP Singh wrote:
> # Performance improvement
> 
> With this patch-set some syscalls with lots of LSM hooks in their path
> benefitted at an average of ~3% and I/O and Pipe based system calls benefitting
> the most.

Paul, FWIW, I think this series is ready to land in -next. I'd like it
to get some bake time there just to see if anything unexpected shows up.
It's quite happy in all my local testing, though.

-Kees

-- 
Kees Cook

