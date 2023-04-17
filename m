Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55AD6E517B
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 22:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjDQUPF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 16:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDQUPE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 16:15:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBAA199A;
        Mon, 17 Apr 2023 13:15:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id la15so3905115plb.11;
        Mon, 17 Apr 2023 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681762501; x=1684354501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Avbj4awFk6rrKm+MFrJ3zdjtROI8yyonU4xCuAnVHM=;
        b=BStUB1/YFIObgGQyJ/e3G2fizdV8FeW6VKILet4qATiRlnM1CTjHevbYZcTx7+r90R
         HRVRbxII8iXNTXkZhb8MZsvevsLZ8G/iI+quaV61+I0+o1zv5G4WpVVi2dRoUSkdWU0p
         zL1RGrTmdWz1435gn3UffJKYmaKaPS8XPOSMkJ9n7iWy1ElA6/3lI7QzjDZG3RRtq2mt
         +w6fvC/qU4SbQUTJrrqq0aCRj1DlXafJWDcQ3o87Ns0cn25d2RdMBOMCnZSa60lYYYR5
         iwk9OIZf5tKkjsL131vH6h1iqMLzYHM8u0d2Qm5VrAZ152uU2Gl6VExmSyqEoRw0I0g6
         y8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681762501; x=1684354501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Avbj4awFk6rrKm+MFrJ3zdjtROI8yyonU4xCuAnVHM=;
        b=fhOF24vPVF+PycmrkHOPY/u41Dl8j8SoTQc/9MHXmVoGQmAprTAOYdsTcNBddCukNG
         23H9nFPjv4faRnlXq5M2ICjGDFqIgJnzTthyUofhyjsrDl+s7ju/vE6l/fFoVW8LCFUp
         jhe2dCuM100+WmXOsDiqYD73g0p6k9/qakvg5PvoD8RNJbJ1h5UR0Aqj8rkgWvX/l2Gp
         L+bxhI4SY0nNdd/GkkTqGnf2XJLD3gNxLUT3kiNSWeTmZ11Z8y/puNu/X48OeJ//o33L
         BuhTN9vqFZpV8hOVd/0vGdrvR2ZwJWRlbE63PqKUzULqRQ6zZWwG+q/8EyESDcW/nRfN
         WN5Q==
X-Gm-Message-State: AAQBX9dvzZLT51wenOB1RAy8uzYsobmjZ/s/Bk9DQbB47Tko9C11XR5I
        3ODb8rIXos1HPDvPoG6uII8=
X-Google-Smtp-Source: AKy350bIofsgtB6f9sx6ZPim4cB4pDB0rkv6pyJ8mxL6/W/LsBYmRcoGYiB+hnludGpFq0K30Od/LQ==
X-Received: by 2002:a05:6a20:a89d:b0:d8:d061:96ec with SMTP id ca29-20020a056a20a89d00b000d8d06196ecmr16995919pzb.27.1681762500944;
        Mon, 17 Apr 2023 13:15:00 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:9cf7])
        by smtp.gmail.com with ESMTPSA id u1-20020a655c01000000b0051322a5aa64sm7525822pgr.3.2023.04.17.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:15:00 -0700 (PDT)
Date:   Mon, 17 Apr 2023 13:14:57 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention
 mechanism
Message-ID: <20230417201457.c43xfcukjzm4u6vx@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
 <20230417154737.12740-6-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417154737.12740-6-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 17, 2023 at 03:47:36PM +0000, Yafang Shao wrote:
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index f61d513..3df39a5 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -842,15 +842,21 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
>  static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
>  	__acquires(RCU)
>  {
> -	rcu_read_lock();
> -	migrate_disable();
> -
> -	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> +	int bit;
>  
> -	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
> +	rcu_read_lock();
> +	bit = test_recursion_try_acquire(_THIS_IP_, _RET_IP_);

and bpf will prevent ftrace to run and vice versa.
Not a good idea.

One bpf prog will prevent different bpf prog to run since they share current task.
Not a good idea either.
