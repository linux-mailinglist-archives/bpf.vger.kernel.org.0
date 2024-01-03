Return-Path: <bpf+bounces-18835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE7C8225CC
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 01:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71BF1F23351
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC61A15B0;
	Wed,  3 Jan 2024 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpWhzciC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C41365;
	Wed,  3 Jan 2024 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1409499a12.2;
        Tue, 02 Jan 2024 16:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704240323; x=1704845123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfypSPvjNhxTnZ7wlUlr3Z5yrEkBmU5hZHDUkJw2Ur0=;
        b=kpWhzciC+pPphoPinLJBd1UT4/ozxn4KxNCERF5O7tfgiH3AD5QvVIylKgwJHs12uV
         h+mTr90GYeOZsvXMfVc4XTYYAVTEdE2goCpQOQNdb7Nua38zS4dv/jj28Vj2aUGEfQSs
         oZoawuSTMXATk6LkH0zUV55N7ytPohn4xsa0Mp7o8h8EiN8AvaPPFsQ9TzR8xUACnPsG
         BqCO3Ot4dRXYFGlI8x4/QiAieUetkjF7bX3aJG9e5+1kT6tQ7T+P2iEqIt3L7EU5xGnM
         B9Ai7l8HTRDb6bkrNFFjHu7MsTHvYmJ+K4WIkPNOTpnW/rlkMJvqJPlp5kc1T4Cxaf4n
         3EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704240323; x=1704845123;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lfypSPvjNhxTnZ7wlUlr3Z5yrEkBmU5hZHDUkJw2Ur0=;
        b=dba4kRJRD1ptVDf2zMY8kuxV6hJGEwsL+mBdf52NBqFumOiaEbZEXaLZ7qjvypIk5M
         1Eo7vJs/RoDMPIfEQEkZIu/Xk1gre1CpBfaHtNvLGfdZz3gHT8EpcDY0sTK9uY4UZbqy
         w8R92d7oPESyGOgdieYfCEakXccn4T+Rbf+tS3wGiS96PEcsMWeNaVapOPkc54WQeJx4
         ZXE+VvYSFQvAA5rZiUmiVgpKXlJ2b+R4yaLj+Y139ZSgskzAzkQTWVEq2Z45PyFzjK2k
         wQhO/lIJTUSR3OvD0y78VWa6Y+qqywajHwRU5afXhicF5bVFsIe80BItgO8LROFtRZWA
         GxGQ==
X-Gm-Message-State: AOJu0Yw1lnoEQtvsI+oA2Bjfssp3L+32UOfksqedQm0xzj95tzhu871x
	42dzKDgFfJPC08lcUNdufOM=
X-Google-Smtp-Source: AGHT+IFe2ywiFmbmbcFjh3jLzjiQCeNchhx4OX6wd0DOTRr51fX/m/SPTQ75oWi+9L7VOATwnXf9cw==
X-Received: by 2002:a05:6a20:1615:b0:197:735a:8917 with SMTP id l21-20020a056a20161500b00197735a8917mr63745pzj.92.1704240323077;
        Tue, 02 Jan 2024 16:05:23 -0800 (PST)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id h32-20020a63f920000000b005b9083b81f0sm21129658pgi.36.2024.01.02.16.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:05:22 -0800 (PST)
Date: Tue, 02 Jan 2024 16:05:21 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6594a4c15a677_11e86208cd@john.notmuch>
In-Reply-To: <1179fcf4e4feaf5d9161eb0ec8fb41e4f08511a4.camel@gmail.com>
References: <20231225091830.6094-1-yangtiezhu@loongson.cn>
 <1179fcf4e4feaf5d9161eb0ec8fb41e4f08511a4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Return -ENOTSUPP if callbacks are not
 allowed in non-JITed programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eduard Zingerman wrote:
> On Mon, 2023-12-25 at 17:18 +0800, Tiezhu Yang wrote:
> > If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
> > exist 6 failed tests.
> > 
> >   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
> >   [root@linux bpf]# ./test_verifier | grep FAIL
> >   #107/p inline simple bpf_loop call FAIL
> >   #108/p don't inline bpf_loop call, flags non-zero FAIL
> >   #109/p don't inline bpf_loop call, callback non-constant FAIL
> >   #110/p bpf_loop_inline and a dead func FAIL
> >   #111/p bpf_loop_inline stack locations for loop vars FAIL
> >   #112/p inline bpf_loop call in a big program FAIL
> >   Summary: 505 PASSED, 266 SKIPPED, 6 FAILED
> > 
> > The test log shows that callbacks are not allowed in non-JITed programs,
> > interpreter doesn't support them yet, thus these tests should be skipped
> > if jit is disabled, just return -ENOTSUPP instead of -EINVAL for pseudo
> > calls in fixup_call_args().
> > 
> > With this patch:
> > 
> >   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
> >   [root@linux bpf]# ./test_verifier | grep FAIL
> >   Summary: 505 PASSED, 272 SKIPPED, 0 FAILED
> > 
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  kernel/bpf/verifier.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a376eb609c41..1c780a893284 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -19069,7 +19069,7 @@ static int fixup_call_args(struct bpf_verifier_env *env)
> >  			 * have to be rejected, since interpreter doesn't support them yet.
> >  			 */
> >  			verbose(env, "callbacks are not allowed in non-JITed programs\n");
> > -			return -EINVAL;
> > +			return -ENOTSUPP;
> >  		}
> >  
> >  		if (!bpf_pseudo_call(insn))
> 
> I agree with this change, however I think that it should be consistent.
> Quick and non-exhaustive grepping shows that there are 4 places where
> "non-JITed" is used in error messages: in check_map_func_compatibility()
> and in fixup_call_args().
> All these places currently use -EINVAL and should be updated to -ENOTSUPP,
> if this change gets a green light.

My preference is to just leave them as is unless its a serious
problem. In this case any userspace has likely already figured
out how to handle these errors so I don't think there is much
value in changing things.

> 
> If the goal is to merely make test_verifier pass when JIT is disabled
> there is a different way:
> - test_progs has a global variable 'env.jit_enabled' which is used by
>   several tests to decide whether to skip or not;
> - loop inlining tests could use similar feature, but unfortunately
>   test_verifier does not provide similar functionality;
> - test_verifier is sort-of in legacy mode, so instead of porting the
>   jit_enabled to test_verifier, I think that loop inlining tests
>   should be migrated to test_progs. I can do that some time after [1]
>   would be landed.
>   
> [1] https://lore.kernel.org/bpf/20231223104042.1432300-3-houtao@huaweicloud.com/
> 



