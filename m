Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED7595575
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 10:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiHPIla (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 04:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiHPIk4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 04:40:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E9113697E
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 00:06:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f22so12299631edc.7
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=I+tPeKnW2Z0tD8ujR2/JpVS2JA1hQ8y18BKpgZ7zBqs=;
        b=baN3YammN8XSMJn3rPIMsNLVwaZwN3zoiXd8AKPTNlnhQj8hEJ9Q6Eln1zn9+iL4BK
         NGiKCA2SgCd4rI3rWwDepb2zj9t7vnc62LJc2xA0V/U9JZ4kMsxr2K/vwId1RbFgA5Jt
         Vrss5mP79gUNmp7D79VGLmTIDMTRcvkhrkI80u92I05FOUt3ZCAJ4OmXn7mXI5lXFU6x
         j2b+bDfptBUdKx8tI364XBVLDnhoqJc6NbhWnOihMA7ph/i63hUA+I/CQJQlEQ8bb5dl
         htxmroV7779AYn2q4iitn5Z+1V+JnecSVwqQIQZ7STTjLXIRaVxUUB6TyxjYeIyQOEiC
         D2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=I+tPeKnW2Z0tD8ujR2/JpVS2JA1hQ8y18BKpgZ7zBqs=;
        b=pVAwZk49w7524I62VxB1isOpz5MuiAgclzA0HdImk+V0P5YSiiBc7cNIEKZUAnsuqS
         C9Fg1/36pQSqbUJ24Wcg0JYuoi12lEEy7ZS6OiefIaT8R53YXq0TFooO/1iFqafob90z
         oIiWQDfC6OfvNSHZEowiBJpS9bRt1Zzk+DunjxEOrDY3zschGMT/M5V2ElSx9ztuGeaQ
         sarMhljtMbtLzaBincvzVrasJN6JM3xC//cuLoqllINWTkIADIExsY1ezh4aoVtfLrv7
         5TUY0A8126VHg1CjUW5wnGmCxc4PLYNpHWtSFgPGig5x3/j+l71TKkxY2r3Fmpd5BLVe
         0oyA==
X-Gm-Message-State: ACgBeo0cI1TWn81LKdpOtAZW76W7HS0EMTzruLyzFfgyShXAkhLeKek0
        SIohYHJhowJu8RNwf5rYbYU=
X-Google-Smtp-Source: AA6agR5vcZZlLrTcMzaL5DgPsMCjxaWPR23d8TYdJ/TmxKTOTO48cVRXhR817/WBq66/vFzii+UQ9g==
X-Received: by 2002:a05:6402:428c:b0:440:8259:7a2b with SMTP id g12-20020a056402428c00b0044082597a2bmr17192079edc.329.1660633563231;
        Tue, 16 Aug 2022 00:06:03 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id l13-20020a1709066b8d00b007262b9f7120sm4907584ejr.167.2022.08.16.00.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 00:06:02 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 16 Aug 2022 09:06:00 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCHv2 bpf-next 2/6] ftrace: Keep the resolved addr in
 kallsyms_callback
Message-ID: <YvtB2OrqmzRGzyPr@krava>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-3-jolsa@kernel.org>
 <YvocUzp5PobPKv5R@worktop.programming.kicks-ass.net>
 <YvogVuh278uRdbq2@krava>
 <YvpAAitklP35uCZo@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvpAAitklP35uCZo@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 02:45:54PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 15, 2022 at 12:30:46PM +0200, Jiri Olsa wrote:
> > On Mon, Aug 15, 2022 at 12:13:39PM +0200, Peter Zijlstra wrote:
> > > On Thu, Aug 11, 2022 at 11:15:22AM +0200, Jiri Olsa wrote:
> > > > Keeping the resolved 'addr' in kallsyms_callback, instead of taking
> > > > ftrace_location value, because we depend on symbol address in the
> > > > cookie related code.
> > > > 
> > > > With CONFIG_X86_KERNEL_IBT option the ftrace_location value differs
> > > > from symbol address, which screwes the symbol address cookies matching.
> > > > 
> > > > There are 2 users of this function:
> > > > - bpf_kprobe_multi_link_attach
> > > >     for which this fix is for
> > > 
> > > Except you fail to explain what the problem is and how this helps
> > > anything.
> > 
> > we search this array of resolved addresses later in cookie code
> > (bpf_kprobe_multi_cookie) for address returned by fprobe, which
> > is not 'ftrace_location' address
> 
> What is fprobe?

https://lore.kernel.org/bpf/164800288611.1716332.7053663723617614668.stgit@devnote2/

> 
> > so we want ftrace_lookup_symbols to return 'only' resolved address
> > at this point, not 'ftrace_location' address
> 
> In general; I'm completely confused what any of this code is doing.
> Mostly I don't speak BPF *at*all*. And have very little clue as to what
> things are supposed to do, please help me along.
> 
> But the thing is, we're likely going to change all this (function call
> abi) again in the very near future; it would be very nice if all this
> code could grow some what/why comments, because I've gotten lost
> multiple times in all this.

is there any outline of the change? is this the change in your x86/fineibt
branch that you brought up in the other thread? 

jirka
