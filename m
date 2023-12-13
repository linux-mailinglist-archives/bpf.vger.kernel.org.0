Return-Path: <bpf+bounces-17647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E586F810900
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 05:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A8FB2100B
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 04:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A9C126;
	Wed, 13 Dec 2023 04:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/fo8Nnl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28039CE
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 20:12:17 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d9e0f0cba9so4089128a34.1
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 20:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702440736; x=1703045536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIttPkcjxa8xLZMmDa8T9A37Ovf4cyufByHNTsMLhCw=;
        b=C/fo8NnlPtZAWTGPXVo9syMRUxR+OSh56VR0XNqmwz20VjrV/e+K+1DzGlcIDeehVb
         VQFphUNMFGXytnca1Y1B5o6pHLnJRkRy+h2Y6+vJLfGDOnzObDw/o55FJ2w5o6HC2QhD
         oETrrwyXiQBVxWapk6nIkDQuoOnz88KoG2WcGP0jQGv0w3wTzXqgdk/7P2iy7wiwQgXO
         9jhnqyawvVPma55PG6d4w9nWg5/BA8W7RID5Fw7/VwbNq6A4RHKyp7JdpLZ8Pt6VgXhW
         2GLV07N+CjRMgh2TGlFLmxLSTQJMuJGPx3/SG26bzQNvDXPiYklPcyIVXdJJHNKIOP0Y
         rDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702440736; x=1703045536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIttPkcjxa8xLZMmDa8T9A37Ovf4cyufByHNTsMLhCw=;
        b=AwCnNJr6URRPtv25F4s+HLy+h6MSND8bhODkwyzba6djUguLAfw5pW4YOTM+qIytca
         fo/Rs3eT35pYrFepBf510e1LreWneIan78v7l1mU3iah+lMeBAFh55NNxx+GLJtBjaEj
         WnRSntw+wEooKHK67pa5iHJgTtgTPoDNTlYTX2Kaat0x2cXsZbEbCXDLn5qmynK9GX2u
         9/DwyAh+g8yd/7sUB9VSK/IDzJF9zFeZio346PNGdWcLZrralUUhryQzhOWoY/muEn7A
         txg0uYvz+wVH/QSbW6nrlLP+a5fz3Lr4/OKonHP5qpOXJHbBW4qjGhxm++AcqstPxAv3
         dv0g==
X-Gm-Message-State: AOJu0YyBEvaNEkQ00RPpBHd7OgdMpX6E1t8hKuTnJm95aT/m9Fmjyu51
	/W4WCwwu8lTTu7MJF3CTatn/CNxhSwA=
X-Google-Smtp-Source: AGHT+IFOHZQKfxZp4Mv5Ug2LUQZSjH/p4JWxBNOrac9uQqI9lkaQRRo7oHeDxdKYgce6H8c4gFUUjQ==
X-Received: by 2002:a05:6808:1928:b0:3b9:e2f4:e41 with SMTP id bf40-20020a056808192800b003b9e2f40e41mr8488747oib.26.1702440736281;
        Tue, 12 Dec 2023 20:12:16 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:fd0f])
        by smtp.gmail.com with ESMTPSA id y20-20020a056a00191400b00688435a9915sm8902459pfi.189.2023.12.12.20.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 20:12:15 -0800 (PST)
Date: Tue, 12 Dec 2023 20:12:13 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 6/8] libbpf: wire up BPF token support at BPF
 object level
Message-ID: <btj4ywppyvxwmcrvadvbowxug4nktyxjjwnuq2iumrhuyoubn2@z65goyjwwcg2>
References: <20231212182547.1873811-1-andrii@kernel.org>
 <20231212182547.1873811-7-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212182547.1873811-7-andrii@kernel.org>

On Tue, Dec 12, 2023 at 10:25:45AM -0800, Andrii Nakryiko wrote:
> Add BPF token support to BPF object-level functionality.
> 
> BPF token is supported by BPF object logic either as an explicitly
> provided BPF token from outside (through BPF FS path or explicit BPF
> token FD), or implicitly (unless prevented through
> bpf_object_open_opts).
> 
> Implicit mode is assumed to be the most common one for user namespaced
> unprivileged workloads. The assumption is that privileged container
> manager sets up default BPF FS mount point at /sys/fs/bpf with BPF token
> delegation options (delegate_{cmds,maps,progs,attachs} mount options).
> BPF object during loading will attempt to create BPF token from
> /sys/fs/bpf location, and pass it for all relevant operations
> (currently, map creation, BTF load, and program load).
> 
> In this implicit mode, if BPF token creation fails due to whatever
> reason (BPF FS is not mounted, or kernel doesn't support BPF token,
> etc), this is not considered an error. BPF object loading sequence will
> proceed with no BPF token.
> 
> In explicit BPF token mode, user provides explicitly either custom BPF
> FS mount point path or creates BPF token on their own and just passes
> token FD directly. In such case, BPF object will either dup() token FD
> (to not require caller to hold onto it for entire duration of BPF object
> lifetime) or will attempt to create BPF token from provided BPF FS
> location. If BPF token creation fails, that is considered a critical
> error and BPF object load fails with an error.
> 
> Libbpf provides a way to disable implicit BPF token creation, if it
> causes any troubles (BPF token is designed to be completely optional and
> shouldn't cause any problems even if provided, but in the world of BPF
> LSM, custom security logic can be installed that might change outcome
> dependin on the presence of BPF token). To disable libbpf's default BPF
> token creation behavior user should provide either invalid BPF token FD
> (negative), or empty bpf_token_path option.

Have you considered an external (to the application) way to provide bpffs path
and enable/disable implicit mode?
Since libbpf is trying to provide the seamless use of token (just recompiling
with new libbpf and admin setup) it seems the admin should be able to pick
the location as well. envvar would be one way.

