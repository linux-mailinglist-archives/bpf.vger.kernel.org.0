Return-Path: <bpf+bounces-10161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C37A248E
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C67E282181
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BDD15E95;
	Fri, 15 Sep 2023 17:22:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3B15E8C
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:22:10 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30410272D;
	Fri, 15 Sep 2023 10:22:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-502e6d632b6so3480965e87.0;
        Fri, 15 Sep 2023 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694798520; x=1695403320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwqMPyk1AnxpjwxRb2+p36Q5q6u/BphSF/nccRVsaQw=;
        b=Sy1stqEIuNlpAj20ugkHzO5umd5iOCAqQ4jGa1iE2H6df5epGhHk2ATWrtdNIN0gsE
         cfV9IhHSFnBD7KF526M6TOUN3EJ5y1Sa7rPEiRsfw+/jcf6DuoVDnl2xCFSngqYVGCfh
         mAusWgx39QOab96mDwoNQt1GVknSx9/8R1v+8hUCoySen9+MaQ+ZSlzLA9tUar99cOzS
         akJtN1w8yW5pxJJwgPaYvgLjXWG2LSxX3P8so5dOtx1K+Na7lFG81/PSgaIG9ySMCla5
         /mJu2myDL8a2U6WJcGsETj0uaP8horBF9Gm9j2p7b2RbTs4vOvvFOlkYal+WTtmPsqMq
         KRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798520; x=1695403320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwqMPyk1AnxpjwxRb2+p36Q5q6u/BphSF/nccRVsaQw=;
        b=oyofJXWkPhZfqYkVcKx41hjHobBLCKGukaOj3djqSbkGWprp5fF38h3Id4oUw9R0SG
         g/Q8IbTk/0Ls0YGJ7ZIvZInQtO06VQQ4yNHEwpGo/66vOaeOC4de3dN1ESEJEysfqmd7
         tg/b0RCSGydT2z7fSZ+PPTyMZ82LffjWgt62Lnb44bDjf6mMOs85qiF1bWaE1WKEA1uC
         POIPwum/UZ6B2gdKpgBy1WqSCNO8rx5jKM+8D5HDiYX+QjzwyRkS/Pp3fPRZaSWs8c6G
         nUuGE6dil8VcuPkXkVKcYRBdS9yQvn0jI1uK0HFviYgd63ku53rDOLgzJpgfQFAxq3cb
         qh+Q==
X-Gm-Message-State: AOJu0YwnUhhOIwPnCQ9pyv9XFb3dXFJGwAV/BRme3xgsFVgpYVGfa49x
	Sx93OHK4x75wfaVDzfCnjgbXiGgEeg9TfsHgOTQIGIp7
X-Google-Smtp-Source: AGHT+IEFU0H+UxH+0Ujr+mm0Oef8nG89b0jB+ZJij1UsOsw6TqtVH4QpoYmOlFD4Hp81Nk+nRwRKXDlPFobcVzceP/c=
X-Received: by 2002:ac2:4c85:0:b0:500:adbd:43e9 with SMTP id
 d5-20020ac24c85000000b00500adbd43e9mr1720618lfl.15.1694798520011; Fri, 15 Sep
 2023 10:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915-bpf_collision-v2-1-027670d38bdf@google.com> <20230915171814.GA1721473@dev-arch.thelio-3990X>
In-Reply-To: <20230915171814.GA1721473@dev-arch.thelio-3990X>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Sep 2023 10:21:48 -0700
Message-ID: <CAADnVQJVL7yo5ZrBZ99xO-MWHHg8L-SuSJrCTf-eUd-k5UO75g@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Fix BTF_ID symbol generation collision
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, stable <stable@vger.kernel.org>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Marcus Seyfarth <m.seyfarth@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 10:18=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Fri, Sep 15, 2023 at 09:42:20AM -0700, Nick Desaulniers wrote:
> > Marcus and Satya reported an issue where BTF_ID macro generates same
> > symbol in separate objects and that breaks final vmlinux link.
> >
> >   ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
> >   '__BTF_ID__struct__cgroup__624' is already defined
> >
> > This can be triggered under specific configs when __COUNTER__ happens t=
o
> > be the same for the same symbol in two different translation units,
> > which is already quite unlikely to happen.
> >
> > Add __LINE__ number suffix to make BTF_ID symbol more unique, which is
> > not a complete fix, but it would help for now and meanwhile we can work
> > on better solution as suggested by Andrii.
> >
> > Cc: stable@vger.kernel.org
> > Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
> > Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1913
> > Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> > Debugged-by: Nathan Chancellor <nathan@kernel.org>
> > Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> > Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQ=
OfQKaOd0nQ51tw@mail.gmail.com/
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  tools/include/linux/btf_ids.h | 2 +-
>
> Shouldn't this diff be in include/linux/btf_ids.h as well? Otherwise, I
> don't think it will be used by the kernel build.

argh.
Let's do this patch as-is and another patch to update everything
in tools/../btf_ids.h, since it got out of sync quite a bit.

