Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F174ED374
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 07:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiCaFuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 01:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiCaFuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 01:50:16 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF49AE
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 22:48:25 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z7so27450197iom.1
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 22:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7CZq1sPbupnQ5BDygOq1DGfvzq20pNwpwSedqZMghEI=;
        b=D7qfH9y9g8aYuxey70G16X/wkCR/KZIt9iJhP1+PJvcBpNN33Vv+gLuBSYrnaoPwXK
         axEI9S13Nc6PBUKCP6HJV+kSYqeFkrZIARedFu4OBQQrWy42uAHMjqxXiaRinqyCslwS
         ebahzCdsI91Zzz18WWSMmypph/YdTGGx0o8coC71zVcJw6X6TT7dctAxvLwyV40vWq2O
         p1EYw1z1SW3OWiozvApF6N8vu3oITsMJkqgcif46FRoVkRvKM0E/m6aIShJRHy5hyOLz
         Cl+cw5T1R6VsmPMcP54No2AaXcudxFw6Rhu7KLoFgLTP5KOqMZQCIyLf0PMIk8xqU/Ou
         seTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CZq1sPbupnQ5BDygOq1DGfvzq20pNwpwSedqZMghEI=;
        b=dpHCb44pk0g61yMMXrnXSnBq176jzDY2aLt0PSD8SOryZPftwyEsKFkpqRmiw7C/+G
         IDEnpsp0M/WsD0HT+l12/2bjBee5SFjZnFRQGDFx52JNnwpsWwtNoaLw/qEELWcz5Oyj
         lgWfyNWtsTwP/wXdHh70zN+GWJiclS20N6Or1DShGK0YFFzMT/B5wlXJazODm3y5Wj1S
         s8DWLMNZRLzgGCcinNuGOG46CfhrfwVZPV8xV96bqTaw8AKpqwHVFHeJLXgfjKlb5dtz
         7iIMYUbn7WU6J7Aoc8vR55FSFRRAszOzD3OrEBHZA2sitRC1asmA4z1xi8ruG5M4YQaI
         EAlQ==
X-Gm-Message-State: AOAM533BIQOTgbd7Bc26YoaosW6Y+rx7dHzYJIuFFVocxxhNTg6EfTwD
        KB1gU99T+uBXqmhwzfAA/bhO5LyaIsahgOPXxLA=
X-Google-Smtp-Source: ABdhPJy03PqH/5QSMmo5TT5o1Y2x6IvfdJWz6VgJouGJfEq0A7kwHgTpsmQ1jMVLMtDdizSAJMhIhxS9uNcCfhDO1SI=
X-Received: by 2002:a6b:7d44:0:b0:64c:ab1b:a8a6 with SMTP id
 d4-20020a6b7d44000000b0064cab1ba8a6mr1865553ioq.63.1648705705019; Wed, 30 Mar
 2022 22:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-2-andrii@kernel.org>
 <176471e1-1221-8eb3-300e-986e3a6eaef8@gmail.com> <605dc1f0-2c66-25f0-ef76-a3c052fcc2d8@gmail.com>
In-Reply-To: <605dc1f0-2c66-25f0-ef76-a3c052fcc2d8@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Mar 2022 22:48:14 -0700
Message-ID: <CAEf4Bza-=c=d-aDz0Ruv2AZrn5fh+5HqL-gvUWa7c9=o+PuWYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] libbpf: add BPF-side of USDT support
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
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

On Wed, Mar 30, 2022 at 8:36 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 2022/3/30 11:10 AM, Hengqi Chen wrote:
> > On 2022/3/25 1:29 PM, Andrii Nakryiko wrote:
> >> Add BPF-side implementation of libbpf-provided USDT support. This
> >> consists of single header library, usdt.bpf.h, which is meant to be used
> >> from user's BPF-side source code. This header is added to the list of
> >> installed libbpf header, along bpf_helpers.h and others.
> >>
> >> BPF-side implementation consists of two BPF maps:
> >>   - spec map, which contains "a USDT spec" which encodes information
> >>     necessary to be able to fetch USDT arguments and other information
> >>     (argument count, user-provided cookie value, etc) at runtime;
> >>   - IP-to-spec-ID map, which is only used on kernels that don't support
> >>     BPF cookie feature. It allows to lookup spec ID based on the place
> >>     in user application that triggers USDT program.
> >>
> >> These maps have default sizes, 256 and 1024, which are chosen
> >> conservatively to not waste a lot of space, but handling a lot of common
> >> cases. But there could be cases when user application needs to either
> >> trace a lot of different USDTs, or USDTs are heavily inlined and their
> >> arguments are located in a lot of differing locations. For such cases it
> >> might be necessary to size those maps up, which libbpf allows to do by
> >> overriding BPF_USDT_MAX_SPEC_CNT and BPF_USDT_MAX_IP_CNT macros.
>
> >> +
> >> +__weak struct {
> >> +    __uint(type, BPF_MAP_TYPE_ARRAY);
> >> +    __uint(max_entries, BPF_USDT_MAX_SPEC_CNT);
> >> +    __type(key, int);
> >> +    __type(value, struct __bpf_usdt_spec);
> >> +} __bpf_usdt_specs SEC(".maps");
> >> +
> >> +__weak struct {
> >> +    __uint(type, BPF_MAP_TYPE_HASH);
> >> +    __uint(max_entries, BPF_USDT_MAX_IP_CNT);
> >> +    __type(key, long);
> >> +    __type(value, struct __bpf_usdt_spec);
> >
> > type should be int.
> >
> >> +} __bpf_usdt_specs_ip_to_id SEC(".maps");
>
> These weak symbols make BPF object open failed:
>
> libbpf: No offset found in symbol table for VAR __bpf_usdt_specs
> libbpf: Error finalizing .BTF: -2.
>
>     bpf_object_open
>         bpf_object__finalize_btf
>             btf_finalize_data
>                 btf_fixup_datasec
>                     find_elf_var_offset
>
> This is because during BTF fixup, we only allow GLOBAL VAR.
>
> Applying the following diff can workaround the issue:
>
> +               unsigned char bind = ELF64_ST_BIND(sym->st_info);
>
> -               if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL ||
> +               if ((bind != STB_GLOBAL && bind != STB_WEAK) ||
>
>

Interesting that selftests don't run into this bug, probably because
BPF linker converts STB_WEAK into STB_GLOBAL? I'll check that, thanks
for catching!

> >> +#endif /* __USDT_BPF_H__ */
