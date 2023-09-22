Return-Path: <bpf+bounces-10648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D807AB547
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 17:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BF623282121
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC81D4174F;
	Fri, 22 Sep 2023 15:51:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72364174A
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 15:51:53 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E2136
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 08:51:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690d8c05784so1826633b3a.2
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695397912; x=1696002712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqnxkpKJKlEpllzMkrnHGTt/nqwg6fkqhahwNJHv70Q=;
        b=NmaglbzKlKRvdnWDNaum8H2mBBo1sqAjoevN9c27gzcrsK1B+GAOIXUI0PcS+WsLRK
         H+pjeOj9ThtQFuZZnH7PJwYS046jhsau9cycS9oDqvuXXZ+wIunzsVLSqUcYAe6uexsk
         nzXY3q8mY2qbinYoyeYxn0N4r8qlCKD9ffh5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695397912; x=1696002712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqnxkpKJKlEpllzMkrnHGTt/nqwg6fkqhahwNJHv70Q=;
        b=BA2Uu10sVmxGke4vuAxywKprMnl9siXVK7FU2z8IY0DWc6ePMaZJ4EzLhGW3Yw/ri6
         e84YIKcVq29Eco46Wfg1QFgdiq6q0uxpFTQ+UwFkLrh3pZCRjzf6A3yKC0tj6vBe3gB0
         vl5J0Kmvhempx+6cnK85ujZxBh/aKtV9CnwPmjuEOVYMbSmt/pm3Vgy4PgUTHte/Sl7s
         gU0Jb5GdARrDrOP2hG+JNTbb7omoloEEw/sFMiQpShWBZDX+8kFiPWf4zHzgFCGRNC1j
         BLZYUAwL3/I2ptQ11X6WwzNE8/S0uEEHYcvgPNP1vr1eGSkzvU8hr92KK1d64QQlKCc1
         ZCfQ==
X-Gm-Message-State: AOJu0Yx6g8wRirakzFfA2rVlPaGoXGkP6yQr6t2D2hTNXfQOAlDEv9Zu
	WcKE17w0xkSr11hQi49xOerA1g==
X-Google-Smtp-Source: AGHT+IHJtMIyEo+IzowjMv7TJVJ01I7kILriFOj/Xf+GG6zskp/zORQGguwTAtk0gU3QPWRAWIy5jw==
X-Received: by 2002:a05:6a20:3ca7:b0:140:6979:295d with SMTP id b39-20020a056a203ca700b001406979295dmr10070985pzj.2.1695397912103;
        Fri, 22 Sep 2023 08:51:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709029f9000b001bf095dfb79sm3624126plq.235.2023.09.22.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 08:51:51 -0700 (PDT)
Date: Fri, 22 Sep 2023 08:51:51 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v4 0/5] Reduce overhead of LSMs with static calls
Message-ID: <202309220851.620EFFCC7C@keescook>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922145505.4044003-1-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 04:55:00PM +0200, KP Singh wrote:
> # Performance improvement
> 
> With this patch-set some syscalls with lots of LSM hooks in their path
> benefitted at an average of ~3% and I/O and Pipe based system calls benefitting
> the most.
> 
> Here are the results of the relevant Unixbench system benchmarks with BPF LSM
> and SELinux enabled with default policies enabled with and without these
> patches.
> 
> Benchmark                                               Delta(%): (+ is better)
> ===============================================================================
> Execl Throughput                                             +1.9356
> File Write 1024 bufsize 2000 maxblocks                       +6.5953
> Pipe Throughput                                              +9.5499
> Pipe-based Context Switching                                 +3.0209
> Process Creation                                             +2.3246
> Shell Scripts (1 concurrent)                                 +1.4975
> System Call Overhead                                         +2.7815
> System Benchmarks Index Score (Partial Only):                +3.4859
> 
> In the best case, some syscalls like eventfd_create benefitted to about ~10%.
> The full analysis can be viewed at https://kpsingh.ch/lsm-perf

Ship it! ;)

Thanks for continuing to work on this; this is a classic case for
static_call.

-Kees

-- 
Kees Cook

