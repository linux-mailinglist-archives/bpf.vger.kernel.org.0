Return-Path: <bpf+bounces-5048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B222475451F
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 00:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26C51C2163F
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 22:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F4024196;
	Fri, 14 Jul 2023 22:47:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265332C80
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 22:47:55 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7C235BB
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 15:47:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6686708c986so2400802b3a.0
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 15:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689374873; x=1691966873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tihl5RahKQS2sbqq9hnuz1FJOgpQZsgLVwdEVrTDxvc=;
        b=XbfQtS4+GtEGxjEa/UTYIWulirfogItX+B656tu6nTJZ9GYOli8/7Q8kLAI2jOMWJz
         Iv+eGepKXlt4+UPCgmDU8bgntOFy/O4cCo2BQyt1dcf8v28vMw4GoXA5tn/zyXbb8j8w
         5bQcqq5NtLmG9LEb2CnYllGX0I5WUt7qxONhvS9jMJETKUS3Zy+d7YZBwO8mkbV+uFSs
         zyOgjICWOOTTzKTWsCQF6CENwroNuMun6m341fmqvYxPuftCBO3ttGVM8zhBYSsl9Tk2
         7qtXtZHfUwaj5t0YrvmmuX1uqixB9hIcBNpxPyZs1NfN6aKRrlq89VNZnLoHrxY9DGuS
         bgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689374873; x=1691966873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tihl5RahKQS2sbqq9hnuz1FJOgpQZsgLVwdEVrTDxvc=;
        b=kKuCFHozbd+X57f5k2Z2s1gcsSemVj40RwRH0hlBmTLVoqNfc2w938/LynBqoYWQq3
         CzK9LkUi339s0sxEY925jcMUTBomUwNpGs96W//19RNugKHgB3TgBuLMWk61LTDkEqin
         6LeoLYPdjRDfHYbDsGublmxDqJoowLT2tXyNHqFxf6KQbmDyOOGMQNgnAPVbu54Us9sB
         O+cLbUEz0/JRHwQaTOKDt79L7Q6OHJ6PEnCkuXBdsq/XW2qOgxLJbARJDANKxzpiqdH0
         BLyPr+gkydh5kDwYLmBQfYmFt/RRJf1N0hAUAakDw1nMMoFlH0wy07tuuoF26lq2oW48
         Ws8g==
X-Gm-Message-State: ABy/qLZQWClO6t73cS2bPa42J8LMUZ7K7hDAYGuwN+uoTvvH9HmAaRRF
	4sUTjwz1CttykNRQ6y34XuY=
X-Google-Smtp-Source: APBJJlGrqaEmIhyFyy9iUJ5k1ooqjrB4jLb4ju8BFcvYs0zrPdpf1aGkINNnhOY/BqcGWVK4lCPqVg==
X-Received: by 2002:a05:6a00:1941:b0:682:713e:e510 with SMTP id s1-20020a056a00194100b00682713ee510mr6067660pfk.27.1689374872783;
        Fri, 14 Jul 2023 15:47:52 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2ff4])
        by smtp.gmail.com with ESMTPSA id i13-20020aa787cd000000b00674364577dasm7620431pfo.203.2023.07.14.15.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 15:47:52 -0700 (PDT)
Date: Fri, 14 Jul 2023 15:47:50 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Introduce
 bpf_set_exception_callback
Message-ID: <20230714224750.27ufbap5guvkqayk@MacBook-Pro-8.local>
References: <20230713023232.1411523-1-memxor@gmail.com>
 <20230713023232.1411523-9-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713023232.1411523-9-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 08:02:30AM +0530, Kumar Kartikeya Dwivedi wrote:
> By default, the subprog generated by the verifier to handle a thrown
> exception hardcodes a return value of 0. To allow user-defined logic
> and modification of the return value when an exception is thrown,
> introduce the bpf_set_exception_callback kfunc, which installs a
> callback as the default exception handler for the program.
> 
> Compared to runtime kfuncs, this kfunc acts a built-in, i.e. it only
> takes semantic effect during verification, and is erased from the
> program at runtime.
> 
> This kfunc can only be called once within a program, and always sets the
> global exception handler, regardless of whether it was invoked in all
> paths of the program or not. The kfunc is idempotent, and the default
> exception callback cannot be modified at runtime.
> 
> Allowing modification of the callback for the current program execution
> at runtime leads to issues when the programs begin to nest, as any
> per-CPU state maintaing this information will have to be saved and
> restored. We don't want it to stay in bpf_prog_aux as this takes a
> global effect for all programs. An alternative solution is spilling
> the callback pointer at a known location on the program stack on entry,
> and then passing this location to bpf_throw as a parameter.
> 
> However, since exceptions are geared more towards a use case where they
> are ideally never invoked, optimizing for this use case and adding to
> the complexity has diminishing returns.

Right. No run-time changes pls.

Instead of bpf_set_exception_callback() how about adding a
btf_tag("exception_handler") or better name
and check that such global func is a single func in a program and
it's argument is a single u64.

> In the future, a variant of bpf_throw which allows supplying a callback
> can also be introduced, to modify the callback for a certain throw
> statement. For now, bpf_set_exception_callback is meant to serve as a
> way to set statically set a subprog as the exception handler of a BPF
> program.
> 
> TODO: Should we change default behavior to just return whatever cookie
> value was passed to bpf_throw? That might allow people to avoid
> installing a callback in case they just want to manipulate the return
> value.

and the verifier would check that u64 matches allowed return values?
ex: call check_return_code() on argument of bpf_throw?
I guess that makes sense.

