Return-Path: <bpf+bounces-13587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9549D7DB214
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 03:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14AF1C2098A
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 02:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FEDEA3;
	Mon, 30 Oct 2023 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OSxlK/6/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69694A3C
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 02:32:15 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB69C0
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 19:32:13 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b512dd7d5bso2940840b6e.1
        for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 19:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698633133; x=1699237933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtRtbmMq9KJMTw6sTU1zuBGrB/yDjOuWLWJULnTmnP8=;
        b=OSxlK/6/kQHnhGXzzT8l9DYrnIGcn6P0r0oWptVdY5pjS66KvcOgOymnITpXg2cIsr
         FNEHiCdmFs2FlE26gEL2fNt3fTE9pWZ9ZqQ4k8rvdyTy0VeJcifWZ4iTyCQhzBYSw1yV
         S0I6yGaQr9nNgWYEct/oxbmrwnIsr6YOqpP5eDR5MdmVIcheKHwagbQfDYNqrU2MJszt
         i9DGa4Im7x1sZxkcfZbd77JDmcSTzFTSaZG2h9FZdPf++Sn1qRttltWwCAn2isdUAtOw
         ZUyj+NRmrOck7wSY07zbQ8rqOqWgvNTGfhcAsM6T3lwcOFrJtGmopykaxAeMeKgmN9HO
         x0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698633133; x=1699237933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BtRtbmMq9KJMTw6sTU1zuBGrB/yDjOuWLWJULnTmnP8=;
        b=udTYdXtyx6zW54FzMTmyIkd/JXZ8dFu69RrJl/RDsQEJR9T4N9zFKDAsenCw/jwPD2
         +VJ52Yp/heA6FKLGowx06fb2sDlKRyHGgQTUIUJYxOaVnUfhDjv5h/g/GfZk7q42B2t2
         4/bcsC2DGkANOCMydsryWVdDpDkqLYCmg3wOK4cDVcJYEagk4qpO6DcJIar2h0dkwcHH
         zSdW6ev5IJ95zLk2RSaVZEXLz90a0o0HHQEcWxBPRwCbCjo78Dg4NK3S2/VaGxqLLBCU
         3YyzHcgEdB8zKP2VBcqmmcEN8GDiwx8TXNz+6dxdCTUFrG2r2J3RTQPpOsO+Yku0tHSp
         cWjA==
X-Gm-Message-State: AOJu0Yx8CpZrIn2iC8+BtcCVTUlLkZc8AA+iQrdL/OkbUWbwPAmd7K7z
	ZidgKgYRXLMZQM6aOxn4pKj4LQ==
X-Google-Smtp-Source: AGHT+IETHd7sJFZEOIbrX1KTZbiUrA3SPw0allcn/4MpQFozC278d5wO2CVTLqFJboUPxykO1MphSw==
X-Received: by 2002:a05:6358:7e47:b0:168:d21d:f56f with SMTP id p7-20020a0563587e4700b00168d21df56fmr11153503rwm.20.1698633133166;
        Sun, 29 Oct 2023 19:32:13 -0700 (PDT)
Received: from [10.4.36.6] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id d4-20020a633604000000b005b929dc2d25sm3894803pga.10.2023.10.29.19.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 19:32:12 -0700 (PDT)
Message-ID: <5cf3d2a8-563e-4fe5-a1a2-7af417bd8043@bytedance.com>
Date: Mon, 30 Oct 2023 10:32:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH bpf-next v6 2/8] bpf: Introduce css_task open-coded
 iterator kfuncs
To: Guenter Roeck <linux@roeck-us.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
 linux-kernel@vger.kernel.org
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
 <20231018061746.111364-3-zhouchuyi@bytedance.com>
 <bf2add1f-a9e4-46ac-b1ac-5b6ad9f0ed86@roeck-us.net>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <bf2add1f-a9e4-46ac-b1ac-5b6ad9f0ed86@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2023/10/30 01:09, Guenter Roeck 写道:
> On Wed, Oct 18, 2023 at 02:17:40PM +0800, Chuyi Zhou wrote:
>> This patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_css_task in open-coded
>> iterator style. These kfuncs actually wrapps css_task_iter_{start,next,
>> end}. BPF programs can use these kfuncs through bpf_for_each macro for
>> iteration of all tasks under a css.
>>
>> css_task_iter_*() would try to get the global spin-lock *css_set_lock*, so
>> the bpf side has to be careful in where it allows to use this iter.
>> Currently we only allow it in bpf_lsm and bpf iter-s.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> Acked-by: Tejun Heo <tj@kernel.org>
> 
> With this patch in linux-next:
> 
> Building m68k:defconfig ... failed
> --------------
> Error log:
> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
> kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
>    917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>        |              ^~~~~~~~~~~~~~~~~~~
> kernel/bpf/task_iter.c:917:14: note: each undeclared identifier is reported only once for each function it appears in
> kernel/bpf/task_iter.c:917:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
>    917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> 
> My apologies for the noise if this has already been reported and/or fixed.
> 
> Guenter

Here is the previous discussion link:
https://lore.kernel.org/lkml/20231020132749.1398012-1-arnd@kernel.org/

We can talk this issue on that maillist.

thanks.

