Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60C24D2217
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 21:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244501AbiCHUBy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 15:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiCHUBx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 15:01:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C939812;
        Tue,  8 Mar 2022 12:00:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so309577pjl.4;
        Tue, 08 Mar 2022 12:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3DrXHfJUJQiuAbxg8KAX894kTH0h17V1hufjnFg1QDI=;
        b=VN+sDijVQqGSDFhwhTtC5smbj+eIxnY/ezsixNZjHygdNQ/oJceOfW03siodezRfbO
         yFHSrg9b1D2APOQN8O0jw177Wwy5xyZL1XrEeyZTjz7rht2jwkVg3+RKPCz/lS0zHbkF
         vk6W34irtH4n9YShvv56AnPmfONpg4DwBakoaECoclcacClzqdKsEk4XlO6+ecArqIja
         5TVDpiz5EQPlJu+jU3EPLBRcqhTCfZr1iA6JRl0C4V3DdsUua1gthqWcPjQ5N7Gq/sl/
         hiQGnMNf/2zJB7as8DKEU0VrHcFTejTH6lj1wH+0WtW7txUbYzv9BFL0gqa+WXtaDtp6
         aJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3DrXHfJUJQiuAbxg8KAX894kTH0h17V1hufjnFg1QDI=;
        b=QZowkWD62V+gHRm/xZ1F27vK+oi6oXfVVWLJk/9WoPjQFEFV5onb526BCdm0IA97Ma
         CqbDM4JalMRVN4XkUwznQbpgzrGkDAKWkv/gpbVvvUo4X4Z4ZVUTEHehSdwWiK+VlTUk
         MfSHXmm9//qpSs7aw9p3QBdG5CV6gvD/nBNJG8qJCIws0qIuFV4MqYvYZrZY04V9duU+
         SLlXvKvXdXg2EpfjTetZqZDxEzOhhSSgkHuyyv/qQwUC0rpJUOR0eRI9mf5qH5hjpzk0
         22oaOIKFeXul2UneYJVRm8inrroQcK6jLLuW7V6o5tFbmSweWXQZ/lsrWWOHwSC/bCpo
         DxsQ==
X-Gm-Message-State: AOAM530dqdlj+boMX10DIhtMAGZVb71vzHNrI6kMV6p0JRq5EY/TW8KK
        rm3WPJSjiN7+7GtUZbxwXAyPAkkaHRg=
X-Google-Smtp-Source: ABdhPJwYiL6rALPCHvlNwDP6UwLMpGvSxVMWNVexoPEOAxh7jbk07rGvVD321YUhkDWJVpRvvBU/5A==
X-Received: by 2002:a17:90b:1b43:b0:1bf:6180:367a with SMTP id nv3-20020a17090b1b4300b001bf6180367amr6583581pjb.172.1646769655974;
        Tue, 08 Mar 2022 12:00:55 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::2:53ea])
        by smtp.gmail.com with ESMTPSA id l188-20020a6225c5000000b004f715e38283sm6439479pfl.63.2022.03.08.12.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:00:55 -0800 (PST)
Date:   Tue, 8 Mar 2022 12:00:52 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
References: <20220308153011.021123062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308153011.021123062@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 08, 2022 at 04:30:11PM +0100, Peter Zijlstra wrote:
> Hopefully last posting...
> 
> Since last time:
> 
>  - updated the ftrace_location() patch (naveen, rostedt)
>  - added a few comments and clarifications (bpetkov)
>  - disable jump-tables (joao)
>  - verified clang-14-rc2 works
>  - fixed a whole bunch of objtool unreachable insn issue
>  - picked up a few more tags
> 
> Patches go on top of tip/master + arm64/for-next/linkage. Also available here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt

I've tried to test it.
Applied the first 23 patches, since patch 24 failed to apply to bpf and bpf-next trees.
selftest/bpf/test_progs
shows that all bpf trampoline tests are failing and
eventually the kernel is crashing:
[   53.040582] RIP: 0010:do_init_module+0x9/0x6f0
[   53.052044] Call Trace:
[   53.052319]  <TASK>
[   53.052559]  bpf_trampoline_6442471381_0+0x32/0x1000
[   53.053117]  do_init_module+0x5/0x6f0
[   53.053550]  load_module+0x77c0/0x9c00

I havne't had time to debug what's going on.
