Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4B357E487
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiGVQhu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 12:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGVQht (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 12:37:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8FD9B1BD
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C22DB82939
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 16:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAB9C341C6;
        Fri, 22 Jul 2022 16:37:44 +0000 (UTC)
Date:   Fri, 22 Jul 2022 12:37:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
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
Message-ID: <20220722123743.4060f40e@gandalf.local.home>
In-Reply-To: <YtrPocs1X7fKitfE@krava>
References: <20220722110811.124515-1-jolsa@kernel.org>
        <20220722072608.17ef543f@rorschach.local.home>
        <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
        <20220722120854.3cc6ec4b@gandalf.local.home>
        <YtrPocs1X7fKitfE@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 22 Jul 2022 18:26:09 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> > So, why not mark it as notrace? That will prevent ftrace from looking at it.  
> 
> there's still needs to be the instrument jump generated
> in order to use bpf_arch_text_poke on that

Can you explain the background on this. Why is bpf doing text_poke on
function entries? What was the direct use case for?

-- Steve
