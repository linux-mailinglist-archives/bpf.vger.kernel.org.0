Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AD6592BBE
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 12:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiHOKay (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 06:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242316AbiHOKav (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 06:30:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B121809
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 03:30:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kb8so12831215ejc.4
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 03:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=k3jnJZwqch8nrr7FXeHT7gELNPCqZVtTKyDB6PLtwZY=;
        b=oWdiHIldIRd6Ep51trexp9B/je9JFyb7fu9TXh+W7zSrLvJ5oGEaG3sCUo040oTSBI
         SgmZoKeX+zRRSIKY0QSpW2c9wQ0ECgS6XotdTLH4MF7WGphGh6iee8tnHXGrvIpESIoB
         j+uKa6mv4olE7Wbe+3BnGqcSFDA58dpa/57L9AqoIllbm/jpXzyifNe98Z/9LTxsIFt1
         L079F7RhJosjXj7JgFqrSr11s+jUHW9xFz2BamdPuSWjYfIM4qb3hq/IBkJPSXOXfs3p
         HLnQeolJERMepyrEITJUNtN9Xv+RIjM1IbMKIh/l0FkRmDd2P/3IUL9J5D4V7QvOAQuH
         SZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=k3jnJZwqch8nrr7FXeHT7gELNPCqZVtTKyDB6PLtwZY=;
        b=EXunhazVoEtLhoQkZ4jXMFRb8fvDBanpPpt8KF2YHm17++k23RYUcx2a+tRQ9PRf5T
         HfLK/4Orm/KIVydpfwTWboziw3Pl+GdPV4knmE6t0KY3vB+IedkStIs6KC2xwSm7LwP8
         tr2vB9hcIc33+L91bh8rcszmIaqQ1JCGh+urVBkgjRJHOT6jd2LmYbGeYfcwjTpQjaxU
         xjzNxw1jzKB8ffbFcAoPlRN9v+nOe/hvgPU70QqtbMA0oF8GkSIj4zSHdS2p2iJI9Zmb
         UM1Nq36XW5ngw49JEWyzw9sSgIWAumuFXzDS7xiEeFBRHq6qOpZra3+M4FECkmGYLsPC
         +JqA==
X-Gm-Message-State: ACgBeo3EleVZvr+apxdFTh/lZ7Ri01l2Y3g6IKs2naGgfBPxCvZNmuI4
        DjDStc7JKsNSpJmMScRbE9c=
X-Google-Smtp-Source: AA6agR5dicrLjdHx/4bgu2NlInr5l54b+fJ3KXT0VC0FsbjNUmMGX3ASssFj9gzmfctsf33jt/iGtA==
X-Received: by 2002:a17:906:847a:b0:730:9a59:3958 with SMTP id hx26-20020a170906847a00b007309a593958mr9991059ejc.62.1660559448794;
        Mon, 15 Aug 2022 03:30:48 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id eq20-20020a056402299400b0043bbcd94ee4sm6316423edb.51.2022.08.15.03.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:30:48 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 15 Aug 2022 12:30:46 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <YvogVuh278uRdbq2@krava>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-3-jolsa@kernel.org>
 <YvocUzp5PobPKv5R@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvocUzp5PobPKv5R@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 12:13:39PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 11, 2022 at 11:15:22AM +0200, Jiri Olsa wrote:
> > Keeping the resolved 'addr' in kallsyms_callback, instead of taking
> > ftrace_location value, because we depend on symbol address in the
> > cookie related code.
> > 
> > With CONFIG_X86_KERNEL_IBT option the ftrace_location value differs
> > from symbol address, which screwes the symbol address cookies matching.
> > 
> > There are 2 users of this function:
> > - bpf_kprobe_multi_link_attach
> >     for which this fix is for
> 
> Except you fail to explain what the problem is and how this helps
> anything.

we search this array of resolved addresses later in cookie code
(bpf_kprobe_multi_cookie) for address returned by fprobe, which
is not 'ftrace_location' address

so we want ftrace_lookup_symbols to return 'only' resolved address
at this point, not 'ftrace_location' address

jirka
