Return-Path: <bpf+bounces-1711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D63672073B
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 18:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8F31C211DC
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 16:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB81C763;
	Fri,  2 Jun 2023 16:17:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D111C758
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 16:17:24 +0000 (UTC)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B04B4
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 09:17:18 -0700 (PDT)
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-653c16b3093so194067b3a.3
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722337; x=1688314337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftaj+c92Xn+0VrlPMhENnH3kgEcuY1Ij1rlG3ylIX94=;
        b=SbHV/raSAqNb/ugGPvUx1HpfrpuTKrN34pcklzYzOiTL0F5uRwrctM9lJlVjcPhTyu
         3glByiMyzb2lNZVG7N3TkU67YWRAom6qiFJ3HwpdBGdq+7o0UzRsgDLA+mvenPfvIPZU
         +QjHcXFhlVKh81QqwlE54getp85UJALQXIroL6pIGM8IMdHFdfILNYGYn3IxK+BiCVKT
         J1nbKJkFdB3LsYb3eQGfdAfC/Vdn6HNCrTzp2mSOFIfAp3LSqXx0vC71IAjEICLagiaZ
         pDCoVvLs1fR5RlRMMP4ZPnjXRMiaurNZTh3CEuEA5xdhWHVToQCFKeIZ1O5CnFtxN2iM
         Sl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722337; x=1688314337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftaj+c92Xn+0VrlPMhENnH3kgEcuY1Ij1rlG3ylIX94=;
        b=k7KS18d896OqxI8Nsx1eurXNSDSKXtoEXG6ByvD9V5t039edxpKlq6OmnXZgavaNSk
         4OyIRoZizL39XUC240Pka1IZ5Zp5iw0bkrXT8trBG5f0mekRSU7bAk6FMtIJyDnglsJ1
         IABXeyz+5e9la6mcmGgvsx5+cWzY7/NNbVBAdtuueYmbG1S0hT8yUi7LYZl6xujhTdX9
         BrNTV+UCDXkAVj+jMY5DVP4xnUnqGhgbD0FyWuVxOkko9alMbf6jM7FiYNBNyhkhrQOi
         FcSuDep2TGBHQe1D4yWD6/jZwxsf+VIh41QKicxCdRSzOqwkn+pFCoKvlfc2u/R3hxMy
         iq/Q==
X-Gm-Message-State: AC+VfDxx+IJQF8ybUBF6yhpLKtKUKSFYP8/sMgyj+GqQVBsPyGwLna8/
	jdJNpKusv4HysOsQyhm4qUu2Lpw=
X-Google-Smtp-Source: ACHHUZ7COymU82+/Vl32ll+Pu3rSqvalAVsy0BKHkj4J5EjAZEh22ie0WU8LSeyg/SXeoXTYWZoTS8w=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:234f:b0:643:92c0:5dd6 with SMTP id
 j15-20020a056a00234f00b0064392c05dd6mr4703194pfj.6.1685722337597; Fri, 02 Jun
 2023 09:12:17 -0700 (PDT)
Date: Fri, 2 Jun 2023 09:12:16 -0700
In-Reply-To: <20230602030842.279262-1-gongruiqi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230602030842.279262-1-gongruiqi@huaweicloud.com>
Message-ID: <ZHoUyDMJ8xq7ENnX@google.com>
Subject: Re: [PATCH] bpf: cleanup unused function declaration
From: Stanislav Fomichev <sdf@google.com>
To: gongruiqi@huaweicloud.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wang Weiyang <wangweiyang2@huawei.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/02, GONG, Ruiqi wrote:
> All usage and the definition of `bpf_prog_free_linfo()` has been removed
> in commit e16301fbe183 ("bpf: Simplify freeing logic in linfo and
> jited_linfo"). Clean up its declaration in the header file.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  include/linux/filter.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index bbce89937fde..f69114083ec7 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -874,7 +874,6 @@ void bpf_prog_free(struct bpf_prog *fp);
>  
>  bool bpf_opcode_in_insntable(u8 code);
>  
> -void bpf_prog_free_linfo(struct bpf_prog *prog);
>  void bpf_prog_fill_jited_linfo(struct bpf_prog *prog,
>  			       const u32 *insn_to_jit_off);
>  int bpf_prog_alloc_jited_linfo(struct bpf_prog *prog);
> -- 
> 2.25.1
> 

