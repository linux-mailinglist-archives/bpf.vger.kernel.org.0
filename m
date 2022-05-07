Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F0F51E3B4
	for <lists+bpf@lfdr.de>; Sat,  7 May 2022 04:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445395AbiEGDBs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 23:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbiEGDBr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 23:01:47 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFC56FA21
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 19:58:01 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id o190so9959710iof.10
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 19:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyW6x+TLGan9cWTPad5eiCnnwRkRWdun3qP/okl12/Q=;
        b=jNEvhuNa/yDUtkqTDnPlBt2xO8Yj72vj9pVBUhrwBOcMZpc6N7zyPgu/oACDbNtFvI
         iZe33GNKJgu95trV6pQcNonUXdBf7r/f1sZBZfDOcxv4wqhF3Jxc8yWPy8k20g4G4Aqj
         oblsHPUijJ0eazb27A23+vqF5P7LcKKgxq0qyFQVoDhzLi5+aKV28FQy/9QGBJI3c6w8
         wDq+riJpyQBS8ddaZgbFLnq7h0h2GKdb3pZPQF5IQxmKNv8Zr126lbc5lFKt+nexn2yq
         bH30bziJQaZhMCzOfM92gLEH7lwR5SYox89/1SOIiu0bfXe5jd9Ofv57TP2Bj2Kl42VV
         gOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyW6x+TLGan9cWTPad5eiCnnwRkRWdun3qP/okl12/Q=;
        b=304bmjn1sh7Imtf1qhYesebDnIYFoDqF/aiDwMgbp5eEBymsbp8TeKBRE587fRRuns
         oVyX0vViU5nbRpdsTL8Z7gSMchfPXIoLUJrwpDCdMH8OjA5JK1UbFw4COviTa2EEDwMW
         /8JL7eT0O9Jm8eGsQNk7lTIN786ftGEOvvqU/axperkA1ajs9TVUkbsgl/EpZgeNqFof
         P0C+HY4A7qetQlUfTS5OLh3QYD+3DwPrzrsxwRxRFSXb0yVUTFKEtdX77TjlU/38PaMT
         5QURhmqA4qYstDL3HAoIzoc3gs2nnYbRHoJpWRcMTP0X6aQnOeqVtnF2DQdrBQ82dv7G
         IAsg==
X-Gm-Message-State: AOAM532M6NagNsmoIJ+n5pe+mbj9LIWGzs7VRx8LZhPFpHBrQnJ0Bg6q
        PU6cLVNn3XExCCyargZ0rLqaEHsYF3jErS6dr+s=
X-Google-Smtp-Source: ABdhPJyutlcxOBx9AQpWsKxBQ9W1KSMo72h/szS+jqIVYZQ5rRGYaIbuwfgXg5DSQQHDXXBqpXRwb6YdCBih34IMA8w=
X-Received: by 2002:a05:6638:533:b0:32a:d418:b77b with SMTP id
 j19-20020a056638053300b0032ad418b77bmr2743389jar.237.1651892280409; Fri, 06
 May 2022 19:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAK1LxokYotMWJfbHz6AN881Q+Z5n4TuOR66OTxbM=YYLWAy6Tg@mail.gmail.com>
In-Reply-To: <CAK1LxokYotMWJfbHz6AN881Q+Z5n4TuOR66OTxbM=YYLWAy6Tg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 May 2022 19:57:49 -0700
Message-ID: <CAEf4BzZe77CU9--+Y4WOwP1LmxNAATw0ZABk6c_sVKuYv9ON1Q@mail.gmail.com>
Subject: Re: Need help: a function symbol can't be found in bpf object file
 when generating skeleton
To:     Yifei Ma <yifeima@bytedance.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        "roman.gushchin" <roman.gushchin@linux.dev>,
        Wenhui Zhang <wenhui.zhang@bytedance.com>,
        Hao Xiang <hao.xiang@bytedance.com>
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

On Fri, May 6, 2022 at 4:27 PM Yifei Ma <yifeima@bytedance.com> wrote:
>
> Hi all,
>
> I hit an issue when a function symbol can't be found in bpf object file when generating skeleton. if anyone can kindly give me some suggestions on it, that would be a big help.
> Here is what I am doing:
> - I am playing with the patch from Roman "bpf: sched: basic infrastructure for scheduler bpf"
> - It adds three hooks in CFS scheduler, and three BPF helper functions.
> - I patched his work on the kerenl and libbpf and bpftool (v5.16)
> - When I compiled this example BPF code (https://github.com/rgushchin/atc), BPF skeleton generator can't find the BTF for the helper function.
> -----------------------------------------------
> More information about my environment:
> - on linux 5.16 with the patch
> - enabled "CONFIG_DEBUG_INFO_BTF=y CONFIG_PAHOLE_HAS_SPLIT_BTF=y CONFIG_DEBUG_INFO_BTF_MODULES=y"
> - rebuilt lib/bpf and bpftool
> - generated vmlinux.h using the bpftool
> - grep bpf_sched_entity_belongs_to_cgrp vmlinux.h ==> Found it
> - clang -g -O2 -target bpf -D__TARGET_ARCH_x86 -I$LINUX/tools/include/uapi -I$LINUX/tools/lib/ -I$LINUX/tools/bpf/bpftool/ -I. -o atc.bpf.o -c atc.bpf.c
> - clang --version ==> Ubuntu clang version 12.0.0-3ubuntu1~20.04.5
> - llvm-strip -g atc.bpf.o
> - bpftool gen skeleton atc.bpf.o > atc.skel.h
> - "libbpf: failed to find BTF for extern 'bpf_sched_entity_belongs_to_cgrp': -2"
> - backtrace where 'bpf_sched_entity_belongs_to_cgrp' can't be found in BTF
> #0 find_extern_btf_id (ext_name= "bpf_sched_entity_belongs_to_cgrp",) at libbpf.c:3589
> #1 bpf_object__collect_externs at libbpf.c:3589
> #2 __bpf_object__open () at libbpf.c:6808
> #3 __bpf_object__open () at libbpf.c:6750
> #4 bpf_object__open_mem () at libbpf.c:6872
> #5 bpf_object__open_mem () at libbpf.c:6866
> #6 in do_skeleton () at libbpf.c:728
> #7 main () at libbpf.c:728
> ------------------------------------
>
>
> Do you have any idea or suggestion on it? Thank you

I think you have to either re-generate bpf_helper_defs.h ([0]) or just
add your own definitions for those new helpers. See [0] for how libbpf
does it for current helpers and just do the same (but with correct
helper ID, of course).

  [0] https://github.com/libbpf/libbpf/blob/master/src/bpf_helper_defs.h#L287

>
> Yifei
>
