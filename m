Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A936F3BBA
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 03:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjEBBMu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 21:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEBBMt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 21:12:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1473A8D
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 18:12:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24df758db1cso1283981a91.2
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 18:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682989965; x=1685581965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47MTC43+cqs0cncIRVUMCVwlp631DYCAqlKsiStJTh4=;
        b=27wJElmW7Qf2QnbHUpeOj5uvR8x9QZPbhuU4EN//QC4lhvOx9HUVgfX7TnrnLX4a74
         QujhUvNJTBK8c9MrL7GvI/8Qk7uug59q0oddpzfP8ekJOuaxhtwjx0mU+0qx7afaf6EX
         ehQx4NriLqW1Vzz3XLieSX8ZU7EEt+XzvZwZfCxesgtTgw/3tfK672G/EDuE3fcIYoWf
         pUO1bqyAlJ2wj71hLlMhUSY9SBOv2ymOo8r1m++3CZbQLWdXYaQUK/6UdB34/kdtUZKZ
         aJq/22k5TzAH/Fq+Z5z+0+x/HyjVzZ991SuKo1R6R4gL6T7f7g2YIKdZsQHSfUdbxLy9
         z2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989965; x=1685581965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47MTC43+cqs0cncIRVUMCVwlp631DYCAqlKsiStJTh4=;
        b=HuTZ7c91zD8GL/TDgfDMnahosUI1tsx38Pdazm9xRdViZBUuc+r0zdD5u/DdxR5k4H
         Mvj9FtUrAsPGYrw88vKwztrhyndf5avEgVEXqLu4sDGY7wRwc6taML7z+3ViVLePfrVS
         y/8oeLf6WIyLAVtAD3EL2KxOSmtLsWZAqFiOywtTXlGHpNy39pRV8kWMppkTmcsIq5Jf
         zbuttXxjAheyEAay/z/il7rNzg2DfzhqyIVNAB6RWFL7B9Llu6FVDEEm7yjnQQBqSonD
         Oi5JjHZfhVSb3WOwNujp8JtvB1gGiSANXz/6rTpKAYSHDOIKb+Bg0k7cdT40o63+qJZ6
         fSug==
X-Gm-Message-State: AC+VfDwghY9CIZM5leNEfuJzSbUyBYpIVyhUathtb7gMN6ivs60RUgGu
        2tdLIIlEYYXTCA0QP3H156TUVG0NtvomdAODSdG8QQ==
X-Google-Smtp-Source: ACHHUZ63MmDcXlqUQU8eyZkTFnid5k643yum7VrgBeVELwK3cTeXsBskvkNr3yGhBKfryeEiik6nw4+nw8x42CwZtMo=
X-Received: by 2002:a17:90b:4acf:b0:22c:59c3:8694 with SMTP id
 mh15-20020a17090b4acf00b0022c59c38694mr15946312pjb.44.1682989964612; Mon, 01
 May 2023 18:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <20230406004018.1439952-2-drosen@google.com>
 <CAEf4BzbyX3i6k5eL6D-5enU+u58nVn_fK28zNBJ4w_Vm-+RiMQ@mail.gmail.com> <CAADnVQ+jQG95kVqkajr=zz2-vs24XedEXcBgSx29oAjqUsFn2g@mail.gmail.com>
In-Reply-To: <CAADnVQ+jQG95kVqkajr=zz2-vs24XedEXcBgSx29oAjqUsFn2g@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Mon, 1 May 2023 18:12:33 -0700
Message-ID: <CA+PiJmST4WUH061KaxJ4kRL=fqy3X6+Wgb2E2rrLT5OYjUzxfQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: verifier: Accept dynptr mem as mem in helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 6, 2023 at 3:13=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> +1
> All of the DYNPTR_TYPE_FLAG_MASK flags cannot appear in type =3D=3D reg->=
type
> here.
> They are either dynamic flags inside bpf_dynptr_kern->size
> or in arg_type.
> Like in bpf_dynptr_from_mem_proto.

Looking at this a bit more, I believe this is to enforce packet
restrictions for DYNPTR_TYPE_SKB and DYNPTR_TYPE_XDP. When a helper
function alters a packet, dynptr slices of it are invalidated. If I
remove that annotation entirely, then the invalid_data_slice family of
tests fail. bpf_dynptr_from_mem_proto is fine since that's just local
dynptrs, which don't have any extra limitations.
