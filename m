Return-Path: <bpf+bounces-5261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8C4759029
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 10:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B151C20DA2
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 08:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C2101E4;
	Wed, 19 Jul 2023 08:22:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4F101DA
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 08:22:37 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73231B9
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 01:22:35 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b8392076c9so85449211fa.1
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689754954; x=1692346954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/BA20oEqFO2hrI98AV40nAy97Jy13HXCNCufHXjQveQ=;
        b=VItNwKqcqUt8S0ooe8KeMh49K2j/sjlxbCi2YviMtGa0eGDGoVTp5+wc9JdDi1mGCN
         0WeRza2eMoXZugGfg5CPOBVIvBRLt+biJfQWyn+yvq2rpe3Cmq2h0IzMKd+BBdfRLczc
         bDwDLz0gM75Ns1Gx1W3tTuteX2nnQo0qP+a3LEwHxP8oF42Iig+RiUIxHDKr06MM51uY
         UwSc8b5suvOb3yORarDoll/00jazYc4RevsXmyUSYPao3ee3tipntaiAyyc54hckHnkl
         KKEZLqoY74K3D+qPs8qayMG/FjVixYp4RCmC6yNqynsKqXqHUmdweTElzmKVC7VCVUKw
         uxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754954; x=1692346954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BA20oEqFO2hrI98AV40nAy97Jy13HXCNCufHXjQveQ=;
        b=bU2cL+dCb0DGBUiB5FqHby3K/k9p8KHsmw5GZjwOeE/euliZ3mf84ceI6ZWyU8Hv4A
         Fgg/5l/YZim1xI2S4GeuNAWP6YGWLlvKCv8bm5kFL74mN13mGKq/MjL6XxUsFbF6Jki2
         qBlKA7srdCMcB+/MLquv6djUzBtYOsgg+L+f2MxsnWHaucDnAYPgknPsb+grHlwKs9+J
         0Sgs9MukYvJJS3j0bugRrN5o4yeDpZHvvFPbAl7/gEym7PbqmKDZx2GJT3A5ENxLfw/Y
         OU15KkVA29UO/AkBnSxwLagpcck7opXQXTIL19dOWt8TDcX++b/OO0zGMnKmlflKu/U1
         pwEg==
X-Gm-Message-State: ABy/qLZaHaL+1jbwFJwYrLRNVE+ZIINv52DsG3TXHXUyuk8QCLZcL/NZ
	hJs16lmapIEd+MpByzSjGDMjfIGZvhC2YJ54lAI=
X-Google-Smtp-Source: APBJJlH8CNHkLZyA6CSVNTw33Ki0rt3/OGpuke/W6bQg4sLtyy8waGOhN55xMZ/VB+c1O9munYdDCQ==
X-Received: by 2002:a2e:8183:0:b0:2b9:3274:dbef with SMTP id e3-20020a2e8183000000b002b93274dbefmr7337375ljg.45.1689754954119;
        Wed, 19 Jul 2023 01:22:34 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t10-20020a1c770a000000b003faef96ee78sm1070669wmi.33.2023.07.19.01.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:22:31 -0700 (PDT)
Date: Wed, 19 Jul 2023 11:22:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: imagedong@tencent.com, bpf@vger.kernel.org
Subject: Re: [bug report] bpf, x86: allow function arguments up to 12 for
 TRACING
Message-ID: <c519c48d-2ce7-4038-83b0-ed0244df4874@kadam.mountain>
References: <09784025-a812-493f-9829-5e26c8691e07@moroto.mountain>
 <61BFA874-6832-40FA-AAB7-A225BE2A7D8C@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61BFA874-6832-40FA-AAB7-A225BE2A7D8C@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 03:58:59PM +0800, Menglong Dong wrote:
> >    1957                         /* copy function arguments from origin stack frame
> >    1958                          * into current stack frame.
> >    1959                          *
> >    1960                          * The starting address of the arguments on-stack
> >    1961                          * is:
> >    1962                          *   rbp + 8(push rbp) +
> >    1963                          *   8(return addr of origin call) +
> >    1964                          *   8(return addr of the caller)
> >    1965                          * which means: rbp + 24
> >    1966                          */
> >    1967                         for (j = 0; j < arg_regs; j++) {
> >    1968                                 emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
> >    1969                                          nr_stack_slots * 8 + 0x18);
> >    1970                                 emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
> >    1971                                          -stack_size);
> >    1972 
> >    1973                                 if (!nr_stack_slots)
> >    1974                                         first_off = stack_size;
> >    1975                                 stack_size -= 8;
> >    1976                                 nr_stack_slots++;
> >    1977                         }
> >    1978                 } else {
> >    1979                         /* Only copy the arguments on-stack to current
> >    1980                          * 'stack_size' and ignore the regs, used to
> >    1981                          * prepare the arguments on-stack for orign call.
> >    1982                          */
> >    1983                         if (for_call_origin) {
> >    1984                                 nr_regs += arg_regs;
> >    1985                                 continue;
> >    1986                         }
> >    1987 
> >    1988                         /* copy the arguments from regs into stack */
> >    1989                         for (j = 0; j < arg_regs; j++) {
> >    1990                                 emit_stx(prog, BPF_DW, BPF_REG_FP,
> >    1991                                          nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
> >    1992                                          -stack_size);
> >    1993                                 stack_size -= 8;
> >    1994                                 nr_regs++;
> >    1995                         }
> >    1996                 }
> >    1997         }
> >    1998 
> > --> 1999         clean_stack_garbage(m, prog, nr_stack_slots, first_off);
> >    2000 }
> 
> Hello,
> 
> Thanks for the reporting. The variable ‘first_off’ that passed to
> clean_stack_garbage() should be ok, as it is only used when
> "nr_stack_slots == 1”, in which case “first_off” should already be
> initialized.
> 
> (Anyway, maybe we should initialize it to avoid passing a
> uninitialized variable to a function?)

There is no downside to initializing it to zero.  Everyone does that
automatically these days.

In a case where the variable is not used, it depends on if the function
is inlined or not.  If it's inlined, then it's not a bug.  If it isn't
inlined then it's still a bug whether the variable is used or not.
It's undefined behavior in C and it can cause runtime warnings with
KMEMsan.

regards,
dan carpenter


