Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E040FD94
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbhIQQLc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 12:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242657AbhIQQLb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 12:11:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393EBC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 09:10:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n2so3890965plk.12
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcnzGazGSZzLmzdloUvkWwTMv7VR3Sjghoge1JYAIdM=;
        b=FyLQDVClsZvjq2OxZJFDgb9XkrliSM/wX2o7OlHnI8O/1hsqPWUdfhD2thcwsI/L1K
         mJsjw7QzQ1rWOk4GU7F7xbVjmIpi8ASYjDpBY4GKrFQ2cs4RwzfrA4AdXCZNaoBPSpDZ
         +3AaWkf5vP8Tmwy0fa2rGqCHhbt3SIAakhM5D9hKeam9oK2Vv51ekQ0lME+JesKoizlL
         lFJzdDDuuE/L5zoqUxUVM3SwUFjyEVlqzJWH2s/3FyfjsXgWqKZvINJpVa7EhuH3w2FP
         RuPH0DLgyZ+G4w6aXU0TDkIu4L8BMxGEPuFsarBSv7U8Xs7TUynw37FDxA9mxA2jVdBC
         jWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcnzGazGSZzLmzdloUvkWwTMv7VR3Sjghoge1JYAIdM=;
        b=SQFQHbV2sWK29cuJYJS2Lk/WTQHGNAweFT9XP8vYtxKNnYSS7YZUDKsjH5rLzhbNPq
         pGyHp00+8b+vqyZWYf3l/dGL4G17AqSwlpBVM8ywlD/4QB/3FGNEShi3xApSrI+MdKjl
         IijwjJCXq6e9FFVtia21hGxx2Xb2mj6bkOcAcMY5qwTrMmsYk5yLqichXWjkXx7f9hKm
         NG4Zz15GvU9Q1m+OtJuqADra4Tp5yy4E97uuKmtuxenspKwKVg6U2erkJ368zlOCHXjI
         P7XFgjyO+BZGRMfUAL3/nCOteRdDWrQbtVa0ZyIiFoUA1531s32ovgNr+SY/IxZpcV2r
         3pTA==
X-Gm-Message-State: AOAM530w9NPMYHCRv+QkHja/MDFqR8YomXeE3gaCevWjvEc7ObbCNjpQ
        HU9dsFmsc2c1YoWrA7nLYkfqluI90t+GF/Bfb1c=
X-Google-Smtp-Source: ABdhPJxWuqIG3akyLaccaxAiJHr2IGqkFdxv14OKDPI76lbfPJXGzbm4KCufgZldtLXvIR3SaEYijPMiDKwE0k+YiZg=
X-Received: by 2002:a17:902:7246:b0:138:a6ed:66cc with SMTP id
 c6-20020a170902724600b00138a6ed66ccmr10444111pll.22.1631895008705; Fri, 17
 Sep 2021 09:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210916015836.1248906-1-andrii@kernel.org> <20210916015836.1248906-5-andrii@kernel.org>
 <1334565d-4810-1ded-504b-180a7b124473@fb.com>
In-Reply-To: <1334565d-4810-1ded-504b-180a7b124473@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 17 Sep 2021 09:09:57 -0700
Message-ID: <CAADnVQK8hdbEQ0iO7X0pr_xAet-=nC0DhwkE2Kid9FrG72hD2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: allow skipping attach_func_name in bpf_program__set_attach_target()
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 15, 2021 at 9:17 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/15/21 6:58 PM, Andrii Nakryiko wrote:
> > Allow to use bpf_program__set_attach_target to only set target attach
> > program FD, while letting libbpf to use target attach function name from
> > SEC() definition. This might be useful for some scenarios where
> > bpf_object contains multiple related freplace BPF programs intended to
> > replace different sub-programs in target BPF program. In such case all
> > programs will have the same attach_prog_fd, but different
> > attach_func_name. It's conveninent to specify such target function names
>
> typo: conveninent => convenient
>
> > declaratively in SEC() definitions, but attach_prog_fd is a dynamic
> > runtime setting.
> >
> > To simplify such scenario, allow bpf_program__set_attach_target() to
> > delay BTF ID resolution till the BPF program load time by providing NULL
> > attach_func_name. In that case the behavior will be similar to using
> > bpf_object_open_opts.attach_prog_fd (which is marked deprecated since
> > v0.7), but has the benefit of allowing more control by user in what is
> > attached to what. Such setup allows having BPF programs attached to
> > different target attach_prog_fd with target funtions still declaratively

Applied with "conveninent" and "funtions" typos fixed.
