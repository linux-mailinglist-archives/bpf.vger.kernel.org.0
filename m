Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE11592D92
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiHOK5p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 06:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiHOK5o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 06:57:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34601759A
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 03:57:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x21so9108713edd.3
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=DCxKre2PH1yNlL8gyZexaadTwZ1BjPNLXfT/N5uksE4=;
        b=GNO8lU40n7f739GoRAJJyw0LtP+70N+9cytU1qRltl3nRLeUzaZ7kYGcONwlrlbJV/
         i2Kv/aLYH6dTVKQnj30fvyUnAZyWi94lsb+f9Vwl2BeSPYQMIfrS1sJzNVf+Z3nPos45
         DsTkkCn92NWCB5wWj9Jx2HGtytKJURGD4U495+nhaTwXVZ7hzBYwKcOlboM7iovHuanx
         AiLOUdbD4pmX3XqGgcbJ1ICExT1l5dfLiUZb59+ryRjNPWgxx8KExrPb/PBfdOoUbKS7
         LphDurmXjesIcTgPa4ptY80nsPJHPTOhONsVBo8+FhDqxblE2QFdXvrnyzQv5ngxtm7M
         ChfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=DCxKre2PH1yNlL8gyZexaadTwZ1BjPNLXfT/N5uksE4=;
        b=hIq8zMgyPkedhcEIAnaXu96nmbCi20A1RbO69sdRVahPq+O3MlSg1QK/fI4rXjB0dT
         wW8g6lUkNis61bv2NheLIsZUMFqC9/oxXz5PHGbuIY7is9erPO+fKBtGsTPItEuNpxEQ
         hXWP1m+JCh2O2IH6W2bztn7N44+9AkcPv/WFw4NkTru3gRWHxm6FviDd6T0e3uGRCJU4
         Z1TiOrHdKbHwV1A6Q7C/vP7BEOdIJtVoCfwBYVm8Ne59mEveDQ/bPLRAEnamX+r/GyWB
         fPbf0MVSTWrTKW65DoybNen5mODgBsCz0BUtKJ1dZp2VjwPHcWxZ/AZpmyVQbDv5ngCe
         H+MA==
X-Gm-Message-State: ACgBeo2Vx8+JXoyVMe6Gv5b5dOZYGKCkFTWukvSUZsdQrS7IoZi6kutL
        TsozV+2r5xT9yVdyLxAdDBM=
X-Google-Smtp-Source: AA6agR4jPdLK0+AQrKbGnFGb4R4+QxUu/aIIoS5TiPvreZuQS9xjf1YayE3IA9y/Yb6IZ3/iYWNt2g==
X-Received: by 2002:a05:6402:2706:b0:43e:5df1:2e04 with SMTP id y6-20020a056402270600b0043e5df12e04mr13790615edd.315.1660561062133;
        Mon, 15 Aug 2022 03:57:42 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id t7-20020a170906948700b0072b32de7794sm3938926ejx.70.2022.08.15.03.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:57:41 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 15 Aug 2022 12:57:39 +0200
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
Subject: Re: [PATCHv2 bpf-next 3/6] bpf: Use given function address for
 trampoline ip arg
Message-ID: <YvomoyS/3Op8FAMa@krava>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-4-jolsa@kernel.org>
 <Yvodfh6OJhSIq8X9@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvodfh6OJhSIq8X9@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 12:18:38PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 11, 2022 at 11:15:23AM +0200, Jiri Olsa wrote:
> > Using function address given at the generation time as the trampoline
> > ip argument. This way we get directly the function address that we
> > need, so we don't need to:
> >   - read the ip from the stack
> >   - subtract X86_PATCH_SIZE
> >   - subtract ENDBR_INSN_SIZE if CONFIG_X86_KERNEL_IBT is enabled
> >     which is not even implemented yet ;-)
> 
> Can you please tell me what all this does and why?
> 

arch_prepare_bpf_trampoline prepares bpf trampoline for given function
specified by 'func_addr' argument

the changed code is storing/preparing caller's 'ip' address on the
trampoline's stack so the get_func_ip helper can use it

currently the trampoline code gets the caller's ip address by reading
caller's return address from stack and subtracting X86_PATCH_SIZE from
it

the change uses 'func_addr' as caller's 'ip' address when trampoline is
generated .. this way we don't need to retrieve the return address from
stack and care about endbr instruction if IBT is enabled

jirka
