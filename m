Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27B857E454
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 18:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiGVQ0S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiGVQ0R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 12:26:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112618C74A
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:26:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sz17so9434058ejc.9
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=Vt8Z2CWM8odgwO2/rrniNAVZF+Wwdyt794FZNOc9ikg=;
        b=hCFZEShRgx0QG8eFiNTa5zv/5QsnsHz8yofpG78IhzlC3X4xIMcSZiQrS5eQGQl2V3
         LxUH3hRPiIkkPkdGXcHkswPxN8xcfwJgc8RJfyTphfFDMfssCOu/jVtKcP9r13AImuyv
         /Y//5/SK2MiTJGNdNV4TzJndMm64H++niS051yxe/Cgui0aBlnSM5iqHH1yu2dqNl4lT
         IQB3SrEhj70ySA73uWVrgGRdKp91+tEK9qaYw7OBhGgK2Jk6fnoLXLJIPzxWFlkKpdtU
         HQQxupEBKNzXK+i3Zmn8BjD4MVlpwVIXdRD127WWFejw0WAsxALYuvOtdgPKc2xfnFGr
         LFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=Vt8Z2CWM8odgwO2/rrniNAVZF+Wwdyt794FZNOc9ikg=;
        b=qC60iZ7FSLyO6nX14znAfJJT5WgaX3vMJlSuUaVvaBX8HWPExOpFutof5942v9qtv1
         v6WC0K3hgu4FF7qq1In94h/rtfbmdOM3RNmZdex3louxLVsPYIQbDQ4wfsRO6OMKwIbu
         4Py/mz3CZulE7JC/kPHrjQClB18Mq6Y2T3sbjIK3eU8N7UIDTfKIBZ49gArLPCSTBZVZ
         XxVUS6FRs0tkK2/+R8z+TxLiWcTwN8x1LAuQLCDeTywz7F9mzWcyJbeELufqaV6m/7Vi
         DyrC6o1+VV7fVsfZLwWhbJkaWQkfBqhXZmOp6UVn16dzBlt/4kvv6I/8/u/2wXEZskVL
         m68Q==
X-Gm-Message-State: AJIora/XF4D9MmzwCBMAaewYi3/KBy2TmjEiTftRUWXyJPcwNOq5IP1V
        jDxUtgnaw/bqertLFXv8mD3bVg63jbfIog==
X-Google-Smtp-Source: AGRyM1uNNPPfdLCKXgAniBm50ekdk287Io5wUKlyC0PHyi9Ll0MaSS7w9yg6sMzwtUGZMXJ69b0yWg==
X-Received: by 2002:a17:907:9493:b0:72f:40ca:fe79 with SMTP id dm19-20020a170907949300b0072f40cafe79mr519261ejc.511.1658507174388;
        Fri, 22 Jul 2022 09:26:14 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id fw9-20020a170907500900b0072aebed5937sm2119021ejc.221.2022.07.22.09.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:26:13 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 22 Jul 2022 18:26:09 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <YtrPocs1X7fKitfE@krava>
References: <20220722110811.124515-1-jolsa@kernel.org>
 <20220722072608.17ef543f@rorschach.local.home>
 <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722120854.3cc6ec4b@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 12:08:54PM -0400, Steven Rostedt wrote:
> On Fri, 22 Jul 2022 09:04:29 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > ftrace must not peek into bpf specific functions.
> > Currently ftrace is causing the kernel to crash.
> > What Jiri is proposing is to fix ftrace bug.
> > And you're saying nack? let ftrace be broken ?
> > 
> > If you don't like Jiri's approach please propose something else.
> 
> So, why not mark it as notrace? That will prevent ftrace from looking at it.

there's still needs to be the instrument jump generated
in order to use bpf_arch_text_poke on that

jirka
