Return-Path: <bpf+bounces-676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171107059B8
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 23:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67ED281343
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 21:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01F1271FC;
	Tue, 16 May 2023 21:42:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734BA271F2
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:42:40 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D14C5FD2;
	Tue, 16 May 2023 14:42:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so25411a12.2;
        Tue, 16 May 2023 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684273357; x=1686865357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCrwAPuGKXq93TXqe6WXaYC1Q/y0jn1/n3v/MjlEJns=;
        b=JR4x/5gSL9UBOTTLzKqCYxTw+bx1mkq+N2tp0cQoZ0Ey0OJRpdCcBjj6W5Ay2ZLVGs
         EJCBFb1qL76rpzwZC3KVUgqph2VG+pDMZgV2JH8i/qCyi2FFPDZdG7WageP4Jny+zw4B
         VDZkf2r95FYpsV5Wcr405f9S6PDZqXTUPwUy8LmYZm1aqmFu5gw1g6m5vcnLo8WaflDv
         PBr4RbftGq3yyvt/8YtmnaqDs4t26I1ShqQ1O4wqaTfXJNwLpYKR9d19X4JRj9OIR2dx
         XJmjef48zWkGhhTg2pV1cmyTme7GL/9IKf4RJyQTHz3gGE7ucHp0ObCtsVBQulRN1cbp
         DymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684273357; x=1686865357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCrwAPuGKXq93TXqe6WXaYC1Q/y0jn1/n3v/MjlEJns=;
        b=cEyzoMNY8+VZO6IvmFr49NKQWxZuL0AfwjGOkIYPiCV4FIDFYoiytqNwM/nWhI3XVm
         JJ4py9yO+4cFO7gqTtXDkwfmZiMlO4R5Xt9HqO0qmC8mwZ7g1f8TbOd6uvUxgjBu6B2/
         8uQahIMOWBXXRAaoBF0exz4Na5cUg8ccaUV21lwUArKxNWRk4/lPpDCyYWwQWtWocnQr
         65cRc0dGNR1nYEJniNSC0loHLH15+rVngTOlaqqLojma9mGkWlASNeB3+WzUDNms2VQm
         oqm3tVQ3Oz6RS4YAM1D8sp58cNtCtL3PpzMoeSHaKTL9uZEVEvFDBvidzSU2NtSK4GkH
         z56g==
X-Gm-Message-State: AC+VfDzJbhvhQE+VfGBtdBQffhOV8WSgKDOETFOYv/rz6kIOVks1A7q3
	nb79wHnsf5HWghmrTRwUKuc=
X-Google-Smtp-Source: ACHHUZ7d13R/4s3sMrjF0bqn81c2bBX5qIzZ4YPQLulerCv9LdqvYx0QqQG1LEiyAZhhRtZIYeV8ZQ==
X-Received: by 2002:a17:906:c14f:b0:94d:a2c2:9aeb with SMTP id dp15-20020a170906c14f00b0094da2c29aebmr41629990ejc.49.1684273357168;
        Tue, 16 May 2023 14:42:37 -0700 (PDT)
Received: from krava ([83.240.62.62])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0094f5179540fsm11169179ejc.83.2023.05.16.14.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:42:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 May 2023 23:42:34 +0200
To: Ze Gao <zegao2021@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Conor Dooley <conor@kernel.org>,
	Yonghong Song <yhs@fb.com>, Ze Gao <zegao@tencent.com>
Subject: Re: [PATCH v2 0/4] Make fprobe + rethook immune to recursion
Message-ID: <ZGP4ypidaxQGdp7Y@krava>
References: <20230516071830.8190-1-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516071830.8190-1-zegao@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 03:18:26PM +0800, Ze Gao wrote:
> Hi all,
> 
> This is the 2nd version of patch series to fix the ftrace rethook recursion problem.
> 
> v1: https://lore.kernel.org/linux-trace-kernel/cover.1684120990.git.zegao@tencent.com/T/                                 +++#md4c0bae6a6cae28dadf2a2c6105ff140b35fddea
> 
> As Steven suggested, this version removes unnecessary notrace annotations from fprobe
> and rethook functions from v1 [PATCH 2,3,4/4] and replaces with makefile changes to filter
> out compiler flags which ftrace depends upon for rethook related objects.
> 
> Ze Gao (4):
>   rethook: use preempt_{disable, enable}_notrace in
>     rethook_trampoline_handler
>   fprobe: make fprobe_kprobe_handler recursion free
>   fprobe: add recursion detection in fprobe_exit_handler
>   rehook, fprobe: do not trace rethook related functions

hi,
what tree is this based on? I have troubles to apply that

thanks,
jirka

> 
>  arch/riscv/kernel/probes/Makefile |  2 +
>  arch/s390/kernel/Makefile         |  1 +
>  arch/x86/kernel/Makefile          |  1 +
>  kernel/trace/fprobe.c             | 72 ++++++++++++++++++++++++-------
>  kernel/trace/rethook.c            |  4 +-
>  5 files changed, 63 insertions(+), 17 deletions(-)
> 
> -- 
> 2.40.1
> 

