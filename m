Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BF6697040
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjBNWAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjBNWAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:00:21 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678B483F2
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:00:20 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ml19so43730279ejb.0
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AS/0qup7BcnqbUG2luaOwtrCXv59oK9htcoBV4r8xhk=;
        b=CPFRjqqmsqDcbGjNXJl+hyJ3nJ1+gJwkgqLE/r9Oa0+2b/Pq6ryT+HzxwVrAjSC7tn
         l8DOfFd2ns53htL/HteSdqvDWJSbs4ZqMGhxQQAstX5yomzt9oCirNOl8cckMGt+rOuU
         ZFQnDyKFjjyiG104YyRQMcn+d8ae0PCBpFHFi3J0jcfuLupQLFmHgyyslq3XQ/AfEStI
         DuVMzlDMtJiAdjhk8VMmOf+jhYU/B4I36Ald4qYjp4WRsp3KHniadgLoSMu4ufmXe4A5
         QBBGfmU8YQEyLGp/AYn4jUl80Dja5RHhr5ZJhvoWzPqCaU/TWivqr3eZGCzX7V3zd2nZ
         Q2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AS/0qup7BcnqbUG2luaOwtrCXv59oK9htcoBV4r8xhk=;
        b=d+s6xMG3UcOKzhC256jEQvKmSagHriqqq4C1TF7nyfifQV08RrE5h7hOFe5rbS4Ohv
         XXKRVk1uqqT/gWcrmZH096/bq5tAJs0kPWaJxRC9ubD/ktke5YmhMge3DHI4Ns2zU5jd
         ILj022cJmD4uJGYskKKnnb0Ehpn0UiErQ+MRKFgpylbq+I39C/cAUM5elGT8HQ4nsRnH
         ERSD1o0que3Rf9a1tLQnJIuqHN1tg2zbAz6yA3Rq1+gEDLELQAqpqv4s6jLEwZsl3Nnu
         eCXmtF9nJp/gZt6yU0rhFrX6Bzu3fpa9Cd/HhX3raz0NGTf6vwNjMwIHIsPkohsQPtRb
         UxvA==
X-Gm-Message-State: AO0yUKWpUmISSkOY8iemFDyID3PSBTT/5kv8dZH9lKAYjh6D9x/dz9SC
        z32UoojvEL7kCpApTTJvAi9pxqHcVAKoSF8EwAA2eQO2x4qNDJJoLMA=
X-Google-Smtp-Source: AK7set89M7AOPuCjBIeu+wc2JMUNVAVkDPYq97Ui/xG09ktGeDqyVQiNbMANXkSQy4uXVk9NH1q6GETMwj4pk/vF0GI=
X-Received: by 2002:a17:907:2cd2:b0:895:58be:963 with SMTP id
 hg18-20020a1709072cd200b0089558be0963mr4318ejc.3.1676412018747; Tue, 14 Feb
 2023 14:00:18 -0800 (PST)
MIME-Version: 1.0
References: <20230212092715.1422619-4-davemarchevsky@fb.com>
 <202302121936.t36vlAFG-lkp@intel.com> <d04d33ff-0f8f-2bbd-3a67-9b8b813a799b@meta.com>
 <CAKwvOdketskm5z25aPRY7OsBOZe2kzvXV-i9RDTbwcLpZSAT0A@mail.gmail.com>
 <CAADnVQ+qJMAugDDQXaerRbh0g4QdRygMZ_0UVmXViR2aJ4OLDQ@mail.gmail.com>
 <CABCJKucDXNeGCdD6uT7phYhpm+OgYm19EkfCNMB9AJ66k4NcvQ@mail.gmail.com> <Y+tupCQ/X38AlvY0@hirez.programming.kicks-ass.net>
In-Reply-To: <Y+tupCQ/X38AlvY0@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 14 Feb 2023 13:59:41 -0800
Message-ID: <CABCJKuc1iqHjg9ERVXMHO00rOqaNGM=d7xTvB4f6fTM4J4-nTA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/9] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        kernel test robot <lkp@intel.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>,
        Joao Moreira <joao@overdrivepizza.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 7:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The other case, which you allude to I think, is control transfer to the
> JIT'ed code which is currently __nocfi annotated. I've only briefly
> thought about how to change this, but basically it would entail the JIT
> emitting the correct prefix bytes and setting the entry point at +16.
>
> Given the JIT will only run after we've selected kCFI/FineIBT it knows
> which form to pick from and can emit the right prefix. Then if we remove
> the __nocfi annotation from the call into JIT'ed code, everything should
> work.
>
> None of this should be exceptionally hard, but I've not had time to
> actually do much about it yet.

The dispatcher path shouldn't be terribly hard to fix, but when I
looked into this briefly half a year ago and ran BPF self-tests with
CFI enabled, I found a few more places that indirectly call jitted
code (or trampolines) using a different function pointer type:

https://github.com/ClangBuiltLinux/linux/issues/1727

For some of these, determining the correct type didn't look all that
simple, but then again, I'm not super familiar with BPF internals.

Sami
