Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F10592D2D
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 12:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiHOKTE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 06:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242580AbiHOKSz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 06:18:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D5127E
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wn6fDSUza1QUfWjhW5wgfTW5R7HCQuMH4cgSKXR2wVo=; b=NEsfiiV65ERBqA80kwfea7kqn+
        IFiLZEnqH1Psqu2ZWQV9NxLMcuaBcHk1iV3/KuobvI1S+wPi+9K5fov/GIPjUmyPCE1luD5tgahLx
        yNOrvBdfuI5Lzr7I5sdHoR5LcZknnB1GYNVp9DRjbNETyQz5lSG9lkLpZkqLoxsSQoqTl4N7mPdKL
        xgqtccaMRElDZOjUpntPCgox36+gyYD+cJTjpk8JCDrpHgmjhLHjDH4vNeKoOXo/5GVbU2Hp94gK/
        taK9dRS+I2XhqXl1srPe9jhZ5vOLxf20NPurxTVbsGe1WsCyH6PuDOgNg5TR7s6DZShw6YjJrn/1g
        30xBApMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNXB9-002dzd-MV; Mon, 15 Aug 2022 10:18:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B59BD980153; Mon, 15 Aug 2022 12:18:38 +0200 (CEST)
Date:   Mon, 15 Aug 2022 12:18:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
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
Message-ID: <Yvodfh6OJhSIq8X9@worktop.programming.kicks-ass.net>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811091526.172610-4-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 11, 2022 at 11:15:23AM +0200, Jiri Olsa wrote:
> Using function address given at the generation time as the trampoline
> ip argument. This way we get directly the function address that we
> need, so we don't need to:
>   - read the ip from the stack
>   - subtract X86_PATCH_SIZE
>   - subtract ENDBR_INSN_SIZE if CONFIG_X86_KERNEL_IBT is enabled
>     which is not even implemented yet ;-)

Can you please tell me what all this does and why?

