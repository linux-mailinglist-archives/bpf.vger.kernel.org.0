Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70363B307
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 21:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiK1UZX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 15:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiK1UZV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 15:25:21 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585132A708
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 12:25:20 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n20so28875764ejh.0
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 12:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6JgCBbmVQED94QkggINgfKVFlLmfgr8GMlU1I22D1Ow=;
        b=gbwpGWuzO84IsqbkbtWFg8aZYwjiMvyMa9cmyvFd8f00dL5LtHTy9YwI2Qy0cpUFRP
         4erJvuNfDdGISnsj+Oes4oE/iyvjGTpkFkVTR8Agm14l/DIwD+Wykh8ceBy63xOMNAUH
         fHap2r4AN7QpcpSv1CBL5AhdDWDOEfRBtTJ15ky3K8AGNw2ebOccJktkGCfXL/nu7CxJ
         O1fym8Y6jW++Aj/RLhTTgpGS5THodweEbDL9C/LkMtr2yQJxnOfHWzxi8RmrhLmepHJ3
         5qjn4dBNHQPZi4yY6EU0/LXDQgJle+yWlhF4MzaDwY8GTPSkUdLCmXdRxDaP/TchNk4j
         drSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JgCBbmVQED94QkggINgfKVFlLmfgr8GMlU1I22D1Ow=;
        b=WtDq4VVZEWiybVPRh9+/2cMpXZCJSIe4LvdH9FL0w1l+gTFLdGCK1m///i/l0cZ8mk
         eROIoTJIjZ3qiSN/RKzTvcadCx/Z8ap1SGJJ+M3d6hX+O84LxqDhgigkiP910Zje5Mky
         4XB7SbSWtSNRkU893LldDbPgMg3Yofk1zj2OgcAthSvWUYVkjknp1yOXNs04PA5pQHt5
         gDFk+Xju5xLZucjaPzHABaVUN+WLTMtihSQD/7G3JUombtCgZ4GawO3vSHfCCCLuSd6G
         zBJ0Y7gkVppXLdb51aRxZ3jJSG+l1TcbH7SgwyW++L1Na2V9L5LhdgzrAoer4deSoA5/
         rc+w==
X-Gm-Message-State: ANoB5pltaZ0Dh8tsVjJgLiM/1q2yYQtQ87nj5OdtBLGSBfU/vsqIb5j6
        KF4eaaYPiThOhmsvj6tYQIHNkLEAAhik+h7EIgA=
X-Google-Smtp-Source: AA0mqf6zwmgz9OH19DpsVIlPuh7X80CYXXoct53QoB/5C8uRXHptnxJTSSUy0rWxXS2ryVW4sk/BvTzD7C/BdFd1tUo=
X-Received: by 2002:a17:906:2ac3:b0:7ad:f2f9:2b49 with SMTP id
 m3-20020a1709062ac300b007adf2f92b49mr32525478eje.94.1669667118732; Mon, 28
 Nov 2022 12:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20221128132915.141211-1-jolsa@kernel.org> <20221128132915.141211-2-jolsa@kernel.org>
 <CAADnVQKED=Ue_s88Ru25s1UQ+xe2eWXTq_02v_h=qiuxXTck=g@mail.gmail.com> <f4b16d4c-9ab9-ad3c-c518-294b564a6348@meta.com>
In-Reply-To: <f4b16d4c-9ab9-ad3c-c518-294b564a6348@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 28 Nov 2022 12:25:07 -0800
Message-ID: <CAADnVQLkkm7vQNiJqww26dKLaYddVWv6qO_mxg5RHmqNGiggtg@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 1/4] bpf: Mark vma objects as trusted for
 task_vma iter and find_vma callback
To:     Yonghong Song <yhs@meta.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 11:04 AM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 11/28/22 10:43 AM, Alexei Starovoitov wrote:
> > On Mon, Nov 28, 2022 at 5:29 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >>
> >> Marking following vma objects as trusted so they can be used
> >> as arguments for kfunc function added in following changes:
> >>
> >>    - vma object argument in find_vma callback function
> >>    - vma object in context of task_vma iterator program
> >>
> >> Both places lock vma object so it can't go away while running
> >> the bpf program.
> >>
> >> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >> ---
> >>   kernel/bpf/task_iter.c | 2 +-
> >>   kernel/bpf/verifier.c  | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >> index c2a2182ce570..cd67b3cadd91 100644
> >> --- a/kernel/bpf/task_iter.c
> >> +++ b/kernel/bpf/task_iter.c
> >> @@ -755,7 +755,7 @@ static struct bpf_iter_reg task_vma_reg_info = {
> >>                  { offsetof(struct bpf_iter__task_vma, task),
> >>                    PTR_TO_BTF_ID_OR_NULL },
> >>                  { offsetof(struct bpf_iter__task_vma, vma),
> >> -                 PTR_TO_BTF_ID_OR_NULL },
> >> +                 PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
> >
> > Yonghong, Song,
> >
> > Do you remember when task or vma is NULL here?
> > Maybe we can do: if (!task || !vma) skip prog run
> > in __task_vma_seq_show()
> > and make both pointers as PTR_TO_BTF_ID | PTR_TRUSTED?
>
> The 'NULL' is to indicate the last bpf prog run before iteration
> ends. It is to provide an opportunity for bpf program to know
> all regular iterations are done and the bpf program can do
> end aggregation or print a footer if the prog link is cat'able.

Ahh. Right. Now I remember :)
I think we're fine with PTR_TRUSTED here.
The pointer still has to be checked for != NULL before
being dereferenced or passed into kfunc.
