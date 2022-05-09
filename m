Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD096520865
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 01:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiEIXf4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 19:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiEIXf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 19:35:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F30B207916
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 16:32:00 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z18so16978552iob.5
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTbM4b4Z7wf2v/cB9/9Ubp3VKfbSylPPjTFqm/2/qPo=;
        b=m8g0TEII4Xt0vt3UrJTTwtblINx2OcTdZGdX2QBP6cFuiOE21KcmikD+xnJQv/sMwh
         uXRMseT6mE8Xfv4rC1Y7inEZ9UdFyS9XvkMWnPcOUJDYn+1DADGLlartDcthLdQVxPP5
         rWUTSk6+fcmiJfU/n1QYz2u9+CDaW8XfyJMw4Jez8kf6MMnxCsI3NbWgZNXLSTsWQbnO
         DhrbNy63puzx+hqEudFIzwdejCKL2XRc6k6prALc1DbnKTLwmE+9ZOlfaY7dI1kcHcda
         qMsenTAmruFSHAnICF9/G/MHTNlCo6EHFtjTsd0KUG1D6qb4iIuuDi8JMtFs//p2sFyp
         bRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTbM4b4Z7wf2v/cB9/9Ubp3VKfbSylPPjTFqm/2/qPo=;
        b=tWcti9L2egGhwiZreMaZ5A/rWHfDBVKI8ZaPAIKb/NoRqoGOOHq9652VGD+H+dwKo8
         4bFzwaHhTV62yjhsPQX2Z4JVvMxGXo2sui7waXDWDzSo01PICwbJafXHlb3+QfY41pr/
         B3sJYPE+RL5974x/dDCRBFiSjdzh5Th73R2f25lAZkDEILcix8w/23WHEITwubu0YY3D
         30Sqa+0bbgaInlnH1tCPXUc2a7J+coC4xwu3rXU8AJEX8DLyp5g+Oa5ELmWiUXJB4iuF
         U4YeSgd/VznCb3qO975CMkyZDR0M7JFFwSO6BRYxeSGRoy/cq4RfhdOfF2FoRprl68Ey
         2stA==
X-Gm-Message-State: AOAM530wy5uMjLzDfIShRvRlc6AQLgMgXIRkEm1ufcHcVnevrZRgwyS/
        /Zk4qak50vbBsYbYH8A1UK4Iw/PpuKzkksWl0gg=
X-Google-Smtp-Source: ABdhPJxtHNjHVxjwqDZB+ztXfGnnW+/l/U5CBtO0Lsf5wCPYGoFO/kMVIEU+T+3/TTJyQuvMkeMEmzbM3f/kHJfqCbc=
X-Received: by 2002:a02:5d47:0:b0:32b:4387:51c8 with SMTP id
 w68-20020a025d47000000b0032b438751c8mr8564964jaa.103.1652139119501; Mon, 09
 May 2022 16:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220501190002.2576452-1-yhs@fb.com> <20220501190028.2579037-1-yhs@fb.com>
In-Reply-To: <20220501190028.2579037-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 16:31:48 -0700
Message-ID: <CAEf4BzY51u6GW7Sj8vNBsvcu7Gt1h13v8bWz=qb2p6vsGcaqEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/12] bpftool: Add btf enum64 support
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

On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add BTF_KIND_ENUM64 support.
> For example, the following enum is defined in uapi bpf.h.
>   $ cat core.c
>   enum A {
>         BPF_F_INDEX_MASK                = 0xffffffffULL,
>         BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>         BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>   } g;
> Compiled with
>   clang -target bpf -O2 -g -c core.c
> Using bpftool to dump types and generate format C file:
>   $ bpftool btf dump file core.o
>   ...
>   [1] ENUM64 'A' size=8 vlen=3
>         'BPF_F_INDEX_MASK' val=4294967295ULL
>         'BPF_F_CURRENT_CPU' val=4294967295ULL
>         'BPF_F_CTXLEN_MASK' val=4503595332403200ULL
>   $ bpftool btf dump file core.o format c
>   ...
>   enum A {
>         BPF_F_INDEX_MASK = 4294967295ULL,
>         BPF_F_CURRENT_CPU = 4294967295ULL,
>         BPF_F_CTXLEN_MASK = 4503595332403200ULL,

maybe we should have some heuristic that if the value is "big enough"
(e.g., larger than 1-128 millions) and is unsigned we should emit it
as hex?

>   };
>   ...
>
> The 64bit value is represented properly in BTF and C dump.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

just minor nits, LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/bpf/bpftool/btf.c        | 47 ++++++++++++++++++++++++++++++++--
>  tools/bpf/bpftool/btf_dumper.c | 32 +++++++++++++++++++++++
>  tools/bpf/bpftool/gen.c        |  1 +
>  3 files changed, 78 insertions(+), 2 deletions(-)
>

[...]
> +       case BTF_KIND_ENUM64: {
> +               const struct btf_enum64 *v = (const void *)(t + 1);

can use btf_enum64() helper from libbpf?

> +               __u16 vlen = BTF_INFO_VLEN(t->info);

btf_vlen(t)

> +               int i;
> +
> +               if (json_output) {
> +                       jsonw_uint_field(w, "size", t->size);
> +                       jsonw_uint_field(w, "vlen", vlen);
> +                       jsonw_name(w, "values");
> +                       jsonw_start_array(w);
> +               } else {
> +                       printf(" size=%u vlen=%u", t->size, vlen);
> +               }
> +               for (i = 0; i < vlen; i++, v++) {
> +                       const char *name = btf_str(btf, v->name_off);
> +                       __u64 val = (__u64)v->hi32 << 32 | v->lo32;

() ?

> +
> +                       if (json_output) {
> +                               jsonw_start_object(w);
> +                               jsonw_string_field(w, "name", name);
> +                               if (btf_kflag(t))
> +                                       jsonw_uint_field(w, "val", val);
> +                               else
> +                                       jsonw_int_field(w, "val", val);
> +                               jsonw_end_object(w);
> +                       } else {
> +                               if (btf_kflag(t))
> +                                       printf("\n\t'%s' val=%lluULL", name, val);
> +                               else
> +                                       printf("\n\t'%s' val=%lldLL", name, val);
>                         }
>                 }
>                 if (json_output)
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index f5dddf8ef404..f9f38384b9a6 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -182,6 +182,35 @@ static int btf_dumper_enum(const struct btf_dumper *d,
>         return 0;
>  }
>
> +static int btf_dumper_enum64(const struct btf_dumper *d,
> +                            const struct btf_type *t,
> +                            const void *data)
> +{
> +       const struct btf_enum64 *enums = btf_enum64(t);
> +       __u32 hi32, lo32;
> +       __u64 value;
> +       __u16 i;
> +
> +       if (t->size != 8)
> +               return -EINVAL;

no need

> +
> +       value = *(__u64 *)data;
> +       hi32 = value >> 32;
> +       lo32 = (__u32)value;
> +

[...]
