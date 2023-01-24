Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30DA6797F7
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 13:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjAXM0d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 07:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjAXM02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 07:26:28 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B9016307;
        Tue, 24 Jan 2023 04:26:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ss4so38432438ejb.11;
        Tue, 24 Jan 2023 04:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kBCb6FABb798F2fYwZmWkerpE+dldb2qRVHlJp6gWNE=;
        b=EvxZy+eU9NS/dEm9tDwdZIn2B0cH3S3GtoX47kc6GPVeiy070A95pQ672lNpnUvnnP
         WB3dy4pyq3DUQZOwC5Lh8An6GVN+fPDeR0gLLOeEdsOrtoPYb1BAnClOOs6iRmwXUCsG
         q/9YUu+Tslph4iZereJO0SuzOYZXaOmMxPWuckrsvd//sqf4ruXZAthDvh0Vz9QnoS5R
         2wY/euBcXhUtcby3sfua9IMppKnlQYOuKVV1F4zsYo6zeDR3jwomDILwZNeQuf04N9Vf
         /I0nxrf0zQEMbo9iBRvO9FLkZFyJt++agBRV9yuWfW+cM08NuHeZAHRSkK5s4U6x54Ee
         0Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBCb6FABb798F2fYwZmWkerpE+dldb2qRVHlJp6gWNE=;
        b=fYvCSpvoJPFulyHKgCHu6evmzOo5ppvG2thrzGEM7Ik/wJN+HdHalkJxc5ysfNcAAY
         B/rmWTVsz/Ol2gWyYyxLTS1a7CH2nXsNTQQCO+k3eL1Zwd7X7atabuz9A6RInshfQtI4
         A+22hL/ViLaIJtq08BfaT1cyMYeaypP0X/soBBPK5dIJPsUOgk0DHo21mBIDJTKwTVvM
         NhaTR84/OuOxsGmjQJ/CBiY1P/p8m/BqkCA04vewONgpeJappKXh9+ZbSNmxPz1mT9f2
         GnY4am+sGMDIr6ZhFngsWFwJlZIndfRVBY1RHc67aSEVqGVyGXS62omKqOSVR1uSghHC
         pzCA==
X-Gm-Message-State: AFqh2koabVHSUBslO1DAKRRmtnKkf9C3/GgC+mLwG7z+hqFTG7YpBUNF
        hevk+5NhntPeaJk7DTznNY+BwS/Ys2zmnPF29po=
X-Google-Smtp-Source: AMrXdXubYNHE6aWzi5fOZn0gmbDMuq2oZQRscWdgAtwJgDVjNVpBghl1PAEzZ+Vw/ccusv18DOSEGN4AvKZeio76ARA=
X-Received: by 2002:a17:906:c0c1:b0:86f:ef27:3f81 with SMTP id
 bn1-20020a170906c0c100b0086fef273f81mr3496156ejb.56.1674563157598; Tue, 24
 Jan 2023 04:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com> <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
 <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com> <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
 <CAADnVQJRntdqa4uCHtTrQNAsgGS13DtNV-ue2wTdHQxiuLo_Yg@mail.gmail.com>
 <03e16727-7a0a-0e1e-e9b9-c947a64becb9@meta.com> <eaf64a4b-85ab-bb5a-5c33-d7cd80b034e7@meta.com>
 <7bfb49fb-99c1-163a-fb86-3e72369adbf6@oracle.com> <ac273c04-3066-dd63-934c-f62650c41f8f@meta.com>
 <22f18176-8771-41a6-4677-7cc805a07350@oracle.com> <50c0ac5d-1507-5b9e-6670-8ec654c40559@meta.com>
In-Reply-To: <50c0ac5d-1507-5b9e-6670-8ec654c40559@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 24 Jan 2023 04:25:46 -0800
Message-ID: <CAADnVQKZ8ipS97bw3wDegnw_rpNRG55vEnsGjW+tkCyQ-MYjcg@mail.gmail.com>
Subject: Re: BTF, pahole and static functions (was Re: [PATCH] libbpf: resolve
 kernel function name optimization for kprobe)
To:     Yonghong Song <yhs@meta.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Menglong Dong <menglong8.dong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
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

On Mon, Jan 23, 2023 at 11:18 PM Yonghong Song <yhs@meta.com> wrote:
site.
> >>> So perhaps the best approach is to eliminate such inconsistent static
> >>> function descriptions? The actual amount is small, ~100 functions.
> >>
> >> Removing these inconsistent static functions could be a simpler
> >> approach.
> >
> > I took that approach with
> >
> > https://github.com/acmel/dwarves/commit/80eaecdb00b3d79becc2133b854593277093b115
> >
> > Static functions with inconsistent prototypes are left out of
> > BTF encoding. Given that the numbers here are pretty low (around
> > 100 or so, not including .isra functions which have inconsistent
> > prototypes due to optimizations), that seems to be the simplest
> > solution for now.
>
> Yes, I am okay with this approach. This will prevent user mistaking
> kprobe a wrong function and this is what we want for now.

Let's proceed with the fix first and then discuss improvements on top.
