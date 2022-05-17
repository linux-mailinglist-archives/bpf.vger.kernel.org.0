Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398785295CC
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 02:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiEQAGf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 20:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiEQAGe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 20:06:34 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8C563C3
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:06:32 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e4so2379328ils.12
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXwMQmoJ7+GoJy1gN8grQXdX6HbLD5nwT8YnVY+EFxQ=;
        b=So9AVJBXToiSCvuA6IpVdqBTHnUWNQclFFNDxaEgdLQLY3Kp7Ng4LlCJhuaCiPtwl/
         G7YqXLf5REwOkVOj9CGAifISBKe2WyikP+Lo1gz4iwVUZdM5NQCRQLIX4CtcxFjSRb3V
         g8X94pvha2vo3XOLFB7tt9pqr6PKTq0M+SFr40EFVEal7wvEstG+b2XgbcPOh/5lTsRC
         fgCfLD+AUcAxLVekLeDcGAAaqoe7b20lRWfPgiqbh/27DhKpfwuSWLzXFMfDuCSy6lMr
         HUT9W8E2o13PWSHq95DwzZFPZIDB2W9MreKtggW9y8dnIbi5zjk1VwgED4WxXzvNW3SC
         ChTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXwMQmoJ7+GoJy1gN8grQXdX6HbLD5nwT8YnVY+EFxQ=;
        b=mQSFfcI0YVsKqu8TiZbAzWgF2D7xuQlNUAj/17KyadGcRMqut6ORe0TPlwSsdI6Al0
         3bJt28VobkaWX0abgbosKawodurxkJP48WkaAYNFpviNyPW5EevW7g9gIUXhrrLu1sPb
         ubD9tXMRaAIxVMZ/Yvqd5bQxn0Wii6bJyqTPl2y86wCYQoo0k18Esdnt7fVOxRb08wad
         QVwSvQqBbfYaI6XsyX9VAH+erZ4OB5FgclIhjFyT7bgpDYCj7Npi70SIzgCmPIDK0oAd
         ZuCP5ZJEQ7lAFpwL6UYss2Ed6yQe/q6lsbTYNjWO7iubIAWsGvbE+JnusRmKze6ELwe1
         I+jA==
X-Gm-Message-State: AOAM533gJsmJdQWZgivGin1ACB6DfJsOeqETvmONBp9s7x7WkaO5bPXe
        DMW8rUA8EVExWqd6+nr6LQ7+pjGdplR9TkLlpkfAPr3RkIE=
X-Google-Smtp-Source: ABdhPJxTnJGCfZMKXWEkVq9eAcW798s4jXFwA/H4UCcAaxw+1E4Q1CM6hv5P8ZU05yyJ+gi2/CB3EXwzfEXkdx+UIYE=
X-Received: by 2002:a05:6e02:1d85:b0:2d1:39cf:380c with SMTP id
 h5-20020a056e021d8500b002d139cf380cmr333271ila.239.1652745992077; Mon, 16 May
 2022 17:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031226.3240983-1-yhs@fb.com>
In-Reply-To: <20220514031226.3240983-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 17:06:21 -0700
Message-ID: <CAEf4BzbO+ghVtgeW99NZ4xUm8LsqPYBkdW5h+7t6bicZSyePWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/18] bpf: Add btf enum64 support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 8:12 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, BTF only supports upto 32bit enum value with BTF_KIND_ENUM.
> But in kernel, some enum indeed has 64bit values, e.g.,
> in uapi bpf.h, we have
>   enum {
>         BPF_F_INDEX_MASK                = 0xffffffffULL,
>         BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>         BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>   };
> In this case, BTF_KIND_ENUM will encode the value of BPF_F_CTXLEN_MASK
> as 0, which certainly is incorrect.
>
> This patch added a new btf kind, BTF_KIND_ENUM64, which permits
> 64bit value to cover the above use case. The BTF_KIND_ENUM64 has
> the following three fields followed by the common type:
>   struct bpf_enum64 {
>     __u32 nume_off;
>     __u32 val_lo32;
>     __u32 val_hi32;
>   };
> Currently, btf type section has an alignment of 4 as all element types
> are u32. Representing the value with __u64 will introduce a pad
> for bpf_enum64 and may also introduce misalignment for the 64bit value.
> Hence, two members of val_hi32 and val_lo32 are chosen to avoid these issues.
>
> The kflag is also introduced for BTF_KIND_ENUM and BTF_KIND_ENUM64
> to indicate whether the value is signed or unsigned. The kflag intends
> to provide consistent output of BTF C fortmat with the original
> source code. For example, the original BTF_KIND_ENUM bit value is 0xffffffff.
> The format C has two choices, printing out 0xffffffff or -1 and current libbpf
> prints out as unsigned value. But if the signedness is preserved in btf,
> the value can be printed the same as the original source code.
> The kflag value 0 means unsigned values, which is consistent to the default
> by libbpf and should also cover most cases as well.
>
> The new BTF_KIND_ENUM64 is intended to support the enum value represented as
> 64bit value. But it can represent all BTF_KIND_ENUM values as well.
> The compiler ([1]) and pahole will generate BTF_KIND_ENUM64 only if the value has
> to be represented with 64 bits.
>
> In addition, a static inline function btf_kind_core_compat() is introduced which
> will be used later when libbpf relo_core.c changed. Here the kernel shares the
> same relo_core.c with libbpf.
>
>   [1] https://reviews.llvm.org/D124641
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/btf.h            |  28 +++++++
>  include/uapi/linux/btf.h       |  17 +++-
>  kernel/bpf/btf.c               | 142 +++++++++++++++++++++++++++++----
>  kernel/bpf/verifier.c          |   2 +-
>  tools/include/uapi/linux/btf.h |  17 +++-
>  5 files changed, 185 insertions(+), 21 deletions(-)
>

[...]
