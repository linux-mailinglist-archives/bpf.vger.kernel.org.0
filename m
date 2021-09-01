Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F753FDE87
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 17:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhIAPYr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343529AbhIAPYr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 11:24:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D736C061575;
        Wed,  1 Sep 2021 08:23:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mj9-20020a17090b368900b001965618d019so4932943pjb.4;
        Wed, 01 Sep 2021 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCo/VRvHMS1zTaFOxFXtxLf0t9XlKJUHJed6zyqi3lA=;
        b=qWyCkzdrxD55KVxyDpszPn7AOmMoi/jjKXCSfmyt8hXTeq2DNXBujFGPf6g3L3KtCC
         Nqb6wKwmwqJmA278Td9CKVT4c5kKGTsntEai9oml/hShA0ipkPfuBcs0TmqYGBJa5sYa
         ZP7OEwYT3z3tkgHv5ofqlUMSy4tQTKRapDYxbx1y2xyR7kZwyMqaf20AIaRQPqsfLO2s
         HnQ41msMay+1Xd6YdRZLtrLhXJGlPhNh2nVOysgTnh/xTxVfGQQKl/bsB95Z9eqvFgFj
         HP1Zi/5KXeG/59RiUl5LgYU6+NqMu8Z6Ldgi5Tsw/ZhHL2CcSPz+NMwoe7SJyIMxp+4R
         mX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCo/VRvHMS1zTaFOxFXtxLf0t9XlKJUHJed6zyqi3lA=;
        b=tAc293lKH0wvqa4GvkmTOOm8+TD3aAJ/ES4tKvlvyu4k8BzdxiMHZwlZV5mGNIP5O2
         QSdBwlsBMivaz9ZhGsHUiDMds9W2NytQDBq00cs0D51/5CKIwna+fSBOzqyoFyig5jMi
         lxGte0MNwlmZmYu54M1FTmwopfNH8OYoRxHh1h3oaO+GJq4BlL1aKzP8aXMZj8U9ykkj
         yMfYPR2fVXNmLbVT+Kuu0M0mZJef6GqGMv1HQqtRiKmfqTEmFs9wggEv5vKnJt/2ow06
         A584ykiHNV+aVV4Gtfi6lyN0xauWx1krNWnQEJHxq74cV2nTgmlDfwLrlQgON0/ekDgt
         950g==
X-Gm-Message-State: AOAM530jsWBi6m3tF8UfeqNpIE0FK4vLJAhHvBoi8lnziyKIuF4606ko
        MQBEno8v+g+A4ICjrEt22L5V15ZjdwPAeBvsy3fGGC97
X-Google-Smtp-Source: ABdhPJy8uZ/BReE3hbQL7biCQJ/f7gyyQ1ox4UhwaHJffkVRrjhPLozuQxTYOPnkYXTFv4RFszktGhE8M6JCYu2zM0s=
X-Received: by 2002:a17:90a:6ac2:: with SMTP id b2mr12628821pjm.36.1630509829909;
 Wed, 01 Sep 2021 08:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210831095017.412311-1-jolsa@kernel.org>
In-Reply-To: <20210831095017.412311-1-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Sep 2021 08:23:38 -0700
Message-ID: <CAADnVQK6kLef54iCufsJay0SnsTLk1Ta-RmnhZnGk7TqJCWUJQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] x86/ftrace: Add direct batch interface
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 2:50 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> hi,
> adding interface to maintain multiple direct functions
> within single calls. It's a base for follow up bpf batch
> attach functionality.
>
> New interface:
>
>   int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>   int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
>   int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>
> that allows to register/unregister/modify direct function 'addr'
> with struct ftrace_ops object. The ops filter can be updated
> before with ftrace_set_filter_ip calls
>
>   1) patches (1-4) that fix the ftrace graph tracing over the function
>      with direct trampolines attached
>   2) patches (5-8) that add batch interface for ftrace direct function
>      register/unregister/modify
>
> Also available at (based on Steven's ftrace/core branch):
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   ftrace/direct

Steven,

Could you review and merge this set for this merge window,
so we can process related bpf bits for the next cycle?
