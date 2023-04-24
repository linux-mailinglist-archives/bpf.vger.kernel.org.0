Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4396ED6D9
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 23:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjDXVky (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 17:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDXVky (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 17:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8714C02;
        Mon, 24 Apr 2023 14:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9DD062744;
        Mon, 24 Apr 2023 21:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDEBC433D2;
        Mon, 24 Apr 2023 21:40:50 +0000 (UTC)
Date:   Mon, 24 Apr 2023 17:40:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention
 mechanism
Message-ID: <20230424174049.1c9e54dd@rorschach.local.home>
In-Reply-To: <CAADnVQ+FO-+1OALTtgVkcpH3Adc6xS9qjzORyq2vwVtwY2UoxQ@mail.gmail.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
        <20230417154737.12740-6-laoar.shao@gmail.com>
        <20230417201457.c43xfcukjzm4u6vx@dhcp-172-26-102-232.dhcp.thefacebook.com>
        <CALOAHbC4Bz_VX52zmv=sScBf0hzscMAC4+EwMCpnd1BcaSVJSw@mail.gmail.com>
        <CAADnVQJw9BCK2itE5bZWdQYz7D-8KdcH96E885zUakEDAOrC+Q@mail.gmail.com>
        <CALOAHbCtPR26it_Wdk7T_TETMTh2se6rgEbL_KC5XKtzvObjiA@mail.gmail.com>
        <CAADnVQ+FO-+1OALTtgVkcpH3Adc6xS9qjzORyq2vwVtwY2UoxQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 19 Apr 2023 15:46:34 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> No. Just one prog at entry into any of the kernel functions
> and another prog at entry of funcs that 1st bpf prog called indirectly.
> Like one prog is tracing networking events while another
> is focusing on mm. They should not conflict.

You mean that you have:

function start:
  __bpf_prog_enter_recur()
    bpf_program1()
      __bpf_prog_enter_recur()
        bpf_program2();
      __bpf_prog_exit_recur()
  __bpf_prog_exit_recur()

  rest of function

That is, a bpf program can be called within another bpf pogram between
the prog_enter and prog_exit(), that is in the same context (normal,
softirq, irq, etc)?

The protection is on the trampoline where the bpf program is called.
Not sure how ftrace can stop BPF or BPF stop ftrace, unless bpf is
tracing a ftrace callback, or ftrace is tracing a bpf function.

-- Steve
