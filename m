Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07F6F0D00
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 22:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbjD0UVc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 16:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbjD0UVZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 16:21:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354E468E
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:21:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24b9e5a9a68so3920447a91.3
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682626878; x=1685218878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukMDklDWBuGuAbWmJHubtBZ/fye7JmvHk4OOsFIKxzk=;
        b=wOJHKLOfQMkbKcihLcsc/nXsiMUX44U3M0Cz13oTtzOV+4XJFpqi+BGB22BVSf82SE
         dpHi0Sach2KSoVqdmZ+nYxvLYfJZpaq0iq6+PeC8oUHzWvAHgkq7jcdPim8pCKICqiZb
         gZFcqKYA3Ly/Bw2/B/RtxOpsXr49y/5SkEtLL+mrzeR2OpvZlK6dQqHCsPvjtCR2JTH7
         pXFaSZ6w2xGdH+bBZFYJ+8A//f1YQ2l5dYxfZjLd49LfNJm5XtyGMLPgM1tqdiBCs2W1
         3qNInzKI3wMW1FYVI/fMXzAHFSvQQD/nRkG+BZI3kuRDkVSRyimeLfn4pr0jsEXy+m+U
         Gy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682626878; x=1685218878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukMDklDWBuGuAbWmJHubtBZ/fye7JmvHk4OOsFIKxzk=;
        b=UfJMEvj9aop4g+mnY/xLBAH3OsIOJ2ytVOxXvc2CxLpwRLF3nfXxlo0PHuK5tDbrLx
         QYdfFmoObzaV9v+gqQ+HyBLFLJAWZNTF/NBvvbjNMTtFQr/vOSXmU83pyJYdTlM3drRF
         gStXlWodlQnprUtZk3TZYfWQ5znp7ydMUG7RXBtuCrc6IIwDoT94u/L9XYRr5uByD3D1
         bvTNTJzHNDZXneqaExiqHRpJKhgU35s1yUVQCSkKgWWY+cvthOHMFcQcizjRSX3Dj63l
         gYlN2UuIW8ydPu4LmdEh29+zMuy5IwxnkTXQuZiJVVc6NabiaLk9rhhmj4UEnUNV/JBl
         hO9g==
X-Gm-Message-State: AC+VfDx9iTSfOaeACPwmkQSf+/0eOITjc2pY9GgsaS9wkjOvZJKBMD5e
        mFPluSjAl+fFtef8Oaipij5kQZRRjG1IITBz4cfF9g==
X-Google-Smtp-Source: ACHHUZ4sZXSuMQdhPHDmkhCRL/0icr9ZYUEDz5TRaEl1YZf7V1VawWCPx07v3pyF9frjE3L746f3ZldwiJJPqhtJ4go=
X-Received: by 2002:a17:90a:65c3:b0:23b:3422:e78a with SMTP id
 i3-20020a17090a65c300b0023b3422e78amr3071364pjs.6.1682626877907; Thu, 27 Apr
 2023 13:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230426155357.4158846-1-sdf@google.com> <CAEf4BzatobESuMtP=ndHuf+imtX1ovM-4+cnV9c=UdsC=teZBQ@mail.gmail.com>
 <CAKH8qBt4xqBUpXefqPk5AyU1Rr0-h-vCJzS_0Bu-987gL4wi4A@mail.gmail.com> <CAADnVQ+HMtb75JtPSV1oHXoPgxpZuOu0tE6RCZwxtXVKYduYqw@mail.gmail.com>
In-Reply-To: <CAADnVQ+HMtb75JtPSV1oHXoPgxpZuOu0tE6RCZwxtXVKYduYqw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 27 Apr 2023 13:21:06 -0700
Message-ID: <CAKH8qBtGkgVYjPbPktY7Kf34yEqQmHHPyTMPKDtZApoTN=6ruQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Make bpf_helper_defs.h c++ friendly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Peng Wei <pengweiprc@google.com>,
        Yonghong Song <yhs@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 1:15=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 27, 2023 at 9:59=E2=80=AFAM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > RE unsupported C++: we are not really subscribing to support it here, r=
ight?
> > Just making it easier for the folks who want to experiment with it to
> > try it out.
>
> I think short term experiments should be out of tree.
> The experiments that lead to a long term goal can certainly be in tree.
> In that sense if your team is really going to invest into making
> c++ a supported front-end for bpf than this is a good first step.
> Such c++ flavor will have restrictions (like no virtual calls and
> exceptions) and it's ok. The basic things like CO-RE has to work though.
> In other words if there is a draft patch for llvm to enable
> existing attrs for c++ then this patch would be fine.
> This patch alone with no effort made on llvm side should stay out of tree=
.

SG, thanks! I'll relay the message internally.
