Return-Path: <bpf+bounces-8222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7298783920
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 07:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88931280E2B
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 05:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31BE1FD1;
	Tue, 22 Aug 2023 05:13:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865C1FA1
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:13:01 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B53818B
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:13:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a1af910e0so1655246b3a.2
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692681180; x=1693285980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zs8+nUjl6nXnjJYUBHGmGAyt/XBgJatj1HgRvpGu5fM=;
        b=LDku5InQXXNeEtXnmUOBE0OsM0t0j3mB+ytpnBfA9RcaWedbTXZ732Ip74KE8KTeTi
         FoDBw8mPcbunEySZxJV+np3roT3ZFIy+zYnXDTXNhC9yn66zIRFrCyaLmziCfAd1ny+5
         9eB6glioPaO1o00E92cuciTKf1zMZW76WZjm8kZVtuMRjzWUslZXjw1hO8drhgn0UTZH
         IG7VHgWO/hv0y2Zy3U42xZ21QNI36xiRh9EPn7BVzVDQhct/67ciSeYeuDnBonZUHMnO
         crOZgbnicUFroqbgKupnzyd6Q3BXTsGZC7ATixJKUk6h8C/T/IaUn0AN66drVEda2gdo
         zQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692681180; x=1693285980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs8+nUjl6nXnjJYUBHGmGAyt/XBgJatj1HgRvpGu5fM=;
        b=dchPWHMY630P46P0BBlXn7ACX/AhZnrs17LhiMvIt/Z4M0QbmcfIF6Fee55yT2VtpB
         CxNwMsX/X9Wv2GTuoBYY5YMiJNqbq0o9kQ9fjBoQ9+LDSnMxLJs9j8g3rOQMx8W42SLo
         sbLDRm92Fw/OIJb3QaiiXx13mZAvDvin16oUhGq3zlDXz3974qZ7rxnS3naJ5ZhCMo8z
         3gGcYGCuw0k6jkwCD9HHCZK32BDAGSWl0VOTezJ/WkGJ0+I2YGey0gt6Zr70cEnVHc9Y
         ypGxBmZ3QMtXA5wNvqw0/h3DyvospkPd7WPzYiCJPaZ9FEtKYLJrAXbeskOcfSVvMWri
         L5NA==
X-Gm-Message-State: AOJu0Yx6fAnACTOt6kpwDYZgU7vbCNqrpzyCYMEs2XD+y6tH9GUni5eu
	WyoPDOEPQB+qDpNG57iK+KI=
X-Google-Smtp-Source: AGHT+IGXt8ksEWaUgNcPEyEvSFqpCN2WTy/P2aAguFYdANYcjPBLShbBGeoSOcs1h7RT3yLkhZyd2w==
X-Received: by 2002:a05:6a20:1456:b0:147:5ab9:8496 with SMTP id a22-20020a056a20145600b001475ab98496mr7130714pzi.55.1692681179672;
        Mon, 21 Aug 2023 22:12:59 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:400::5:863c])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902bd4b00b001bdcc3a09c3sm7954787plx.256.2023.08.21.22.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 22:12:59 -0700 (PDT)
Date: Mon, 21 Aug 2023 22:12:56 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v2 03/14] bpf: Implement BPF exceptions
Message-ID: <20230822051256.zzdmff3iilmankpg@macbook-pro-8.dhcp.thefacebook.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
 <20230809114116.3216687-4-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809114116.3216687-4-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 05:11:05PM +0530, Kumar Kartikeya Dwivedi wrote:
> +
> +static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
> +{
> +	struct bpf_throw_ctx *ctx = cookie;
> +	struct bpf_prog *prog;
> +
> +	if (!is_bpf_text_address(ip))
> +		return !ctx->cnt;
> +	prog = bpf_prog_ksym_find(ip);
> +	ctx->cnt++;
> +	if (!prog->aux->id)
> +		return true;
> +	ctx->aux = prog->aux;
> +	ctx->sp = sp;
> +	ctx->bp = bp;
> +	return false;
> +}

Took me some time to understand what !prog->aux->id is doing.
Let's add a helper: is_subprog() and check:
prog->aux->func_idx != 0
since that's what arm64, x64, s390 JITs are using.

