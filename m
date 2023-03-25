Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129676C8A94
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 04:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCYDGG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 23:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYDGF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 23:06:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDE99EE8
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 20:06:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-540e3b152a3so35924617b3.2
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679713559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqkzmrDaooxkmyBq4dgaGvj/i7B9LiZsiFYrF/wxk40=;
        b=jPddl17hlo0HYyG0viEndAYsBc1cgeZPe6CRujtS3zIvn7j6TK18coul1D8Q2lG2Vs
         NGeaQCeyZ4aBrrJRuAH/Vnj4tPB4cwVoKBZfBIqC7piauAl+v8jWyt3qDQgeRa1Jn8v4
         JCdASlOkt26J5WECa212f3UiD/3rPQktygsTjcKvtvvygQ92vsEaHSuhywua7sKn9+D0
         tNeN7X65y6/LBq25OtkaqOXkaLR1rMKJpYRiz5OT9XvF8oRAZHBjoeiBWpce9rIUwkHy
         RNMoRj5EgYEwzGq5wgDmRsp/2c14Lv29+7vOuu88DFXeyjN4IugeGJ2aO0fGEi0jZFyB
         rl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqkzmrDaooxkmyBq4dgaGvj/i7B9LiZsiFYrF/wxk40=;
        b=JaZu+j199XDsS6SWUHpVXlorLN/roJR9k3ddktx+lVmpnpNxl0CuSwIDskRCapZv7x
         h+u0sO6YCtPLPls5ESliiwd6AexYS94ySyeMJmN8XbDlD0oounuk9ybMjtM7Q/h/GpLv
         uCFGVs40C6TijSqaT+jlHvy6KyoaUbtIWNBcXJruUBtVe87gaJ96kDmzxYQMjEHk9Yl/
         245Tg8yOXxOZdD0YqPZNVrGPhobqRh/xRgaecpV/1AHIfyoTZJICysTYAkyeURDLgzlY
         WQKtXTFSYz5MSO2/ynmdLSPumo4YOJbtyY3M9jM6YzuUKflsSEpRrfT/dlCXc5ErpTG4
         d6kg==
X-Gm-Message-State: AAQBX9fZ3j4lU5Yd9VdxK+cWZc+Vy1fasseaiE/2VVtwsc2884LesTXi
        3FmrtaJRBksj9RaeHFBFjJtcssc=
X-Google-Smtp-Source: AKy350ag/o1Os4AOu8ISWPOv4y2I8hsJOmTWW8YKAt1M1ei7h8E8iRh6ODg+yvVs7Mk5aNAcVHfswIc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:bc52:0:b0:541:69bc:8626 with SMTP id
 b18-20020a81bc52000000b0054169bc8626mr2029981ywl.10.1679713559513; Fri, 24
 Mar 2023 20:05:59 -0700 (PDT)
Date:   Fri, 24 Mar 2023 20:05:57 -0700
In-Reply-To: <20230324230209.161008-1-quentin@isovalent.com>
Mime-Version: 1.0
References: <20230324230209.161008-1-quentin@isovalent.com>
Message-ID: <ZB5lFSETgO+HfML+@google.com>
Subject: Re: [PATCH bpf-next 0/5] bpftool: Add inline annotations when dumping
 program CFGs
From:   Stanislav Fomichev <sdf@google.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/24, Quentin Monnet wrote:
> This set contains some improvements for bpftool's "visual" program dump
> option, which produces the control flow graph in a DOT format. The main
> objective is to add support for inline annotations on such graphs, so that
> we can have the C source code for the program showing up alongside the
> instructions, when available. The last commits also make it possible to
> display the line numbers or the bare opcodes in the graph, as supported by
> regular program dumps.

> Quentin Monnet (5):
>    bpftool: Fix documentation about line info display for prog dumps
>    bpftool: Fix bug for long instructions in program CFG dumps
>    bpftool: Support inline annotations when dumping the CFG of a program
>    bpftool: Support "opcodes", "linum", "visual" simultaneously
>    bpftool: Support printing opcodes and source file references in CFG

Acked-by: Stanislav Fomichev <sdf@google.com>

Left two small nits. Up to you on whether it's worth to respin or not.

>   .../bpftool/Documentation/bpftool-prog.rst    | 18 ++---
>   tools/bpf/bpftool/bash-completion/bpftool     | 18 +++--
>   tools/bpf/bpftool/btf_dumper.c                | 51 ++++++++++++
>   tools/bpf/bpftool/cfg.c                       | 29 +++----
>   tools/bpf/bpftool/cfg.h                       |  5 +-
>   tools/bpf/bpftool/main.h                      |  2 +
>   tools/bpf/bpftool/prog.c                      | 78 ++++++++++---------
>   tools/bpf/bpftool/xlated_dumper.c             | 52 ++++++++++++-
>   tools/bpf/bpftool/xlated_dumper.h             |  3 +-
>   9 files changed, 184 insertions(+), 72 deletions(-)

> --
> 2.34.1

