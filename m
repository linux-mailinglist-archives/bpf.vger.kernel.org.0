Return-Path: <bpf+bounces-10172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEFF7A24FD
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EAF281331
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FDB15EB5;
	Fri, 15 Sep 2023 17:39:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24615EA0
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:39:38 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862802119
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:38:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-502e6d632b6so3505161e87.0
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694799531; x=1695404331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj1YplooMzQIeendO/ZR6T9qTdnlAkNv7fz8wUiQeSM=;
        b=IlfDqOwHuHIAV1//Nm765IJRcyvbATTM5lL1x9k/atlFf0H+jVD32MnsFDIVjRfVWb
         UGU4AyMhK1Fulfzsqh6/gtsqaMvylFHfGTb6oNrL668a7JmynjY4Fa8RbFxTzEt0T9AJ
         XWJi69LUAdUIRbTeqc+riiKWsB5+8zXMfpEOOBCaCkmXZi7r7GSUiwDSzApZ0MzAvsGh
         xb7SdHY22OO6UEJQClFE8fZb8rF8ry66L2VGxxsC5KuvyM0xCmsB7XzDbQhe7usnOvFM
         3+9x/ILPCHG7G3p0oNgUyWR5CUuynd73qJalEiInR4Haziny/fUIU2AhbvLZHq6Nzl94
         xPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799531; x=1695404331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj1YplooMzQIeendO/ZR6T9qTdnlAkNv7fz8wUiQeSM=;
        b=es5AaV/iXOIJM2xtKab5h99ORuO+kpT4d2zEYij8F+UyEgDGpUF3xWJcixYmBXm2Om
         oQKd08+aiQycewqCZAyk1fbl4REvvxlrLhjKl0XlUy0YTj4BUcMYrjgB41niBAK2SsXe
         ePy+GYs31Z+uUQsZsDxrPHHrAh0Xh+H1nG44o/XAro91sQyT+OjEbMM2n8ADL0sMZ4lB
         tkhot7t2jRX1YZal9cy0vH3g8nyQN/hUWHf0sbWGsNLwdtB03CN0KoBVrgNnzIvaP2g7
         AWanZWkX7rMURcXrO345/XsQ6Qz1PBDoy+dqunZOLygu3emPpVJDQB9biIjLGQ7Gcb/C
         6Wyg==
X-Gm-Message-State: AOJu0YwE9WDmaHZAYrzstgJPY9+kpNUCSqOvMvLdG5l17Qz3k8xlAVIq
	qktzrwl49vtG5bHivSIlLNWOVcog3YZ65pHTWYI=
X-Google-Smtp-Source: AGHT+IEtYAnCuAobupNeMYOrJBTtzijb4Bjw1/ZMPCLU2PQeuM+74w8w2jYT7q7Qda+YMBNPH7xs3jkTkYbqKnTrwY8=
X-Received: by 2002:ac2:52ab:0:b0:4fb:8f79:631 with SMTP id
 r11-20020ac252ab000000b004fb8f790631mr1994108lfm.46.1694799530441; Fri, 15
 Sep 2023 10:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914145126.40202-1-hffilwlqm@gmail.com> <CAEyhmHRAvR=Ch-DjMpmpB0zeUsbQYcTXkMqyTSL9iwmZukcTgw@mail.gmail.com>
 <8148921c-cc06-bad7-787f-d190cba0bce1@gmail.com> <CAEyhmHR9g+B67Fy_wmdTwHzMFhmdw86ak6dPFpMjui16ecTUjw@mail.gmail.com>
In-Reply-To: <CAEyhmHR9g+B67Fy_wmdTwHzMFhmdw86ak6dPFpMjui16ecTUjw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Sep 2023 10:38:39 -0700
Message-ID: <CAADnVQ+FLBbvE=TPuNHs2ir3s+6kVOpZGQ4U_X3SuAaAAcdL-w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix tr dereferencing
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Stanislav Fomichev <sdf@google.com>, kbuild test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 7:54=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> On Fri, Sep 15, 2023 at 10:18=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com>=
 wrote:
> >
> >
> >
> > On 15/9/23 10:13, Hengqi Chen wrote:
> > > On Thu, Sep 14, 2023 at 10:51=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.=
com> wrote:
> > >>
> > >> Fix 'tr' dereferencing bug when CONFIG_BPF_JIT is turned off.
> > >>
> > >> Like 'bpf_trampoline_get_progs()', return 'ERR_PTR()' and then check=
 by
> > >> 'IS_ERR()'. As a result, when CONFIG_BPF_JIT is turned off, it's abl=
e to
> > >> handle the case that 'bpf_trampoline_get()' returns
> > >> 'ERR_PTR(-EOPNOTSUPP)'.
> > >>
> > >> Fixes: 4a1e7c0c63e0 ("bpf: Support attaching freplace programs to mu=
ltiple attach points")
> > >> Fixes: f7b12b6fea00 ("bpf: verifier: refactor check_attach_btf_id()"=
)
> > >> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> > >> Reported-by: kernel test robot <lkp@intel.com>
> > >> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > >> Closes: https://lore.kernel.org/r/202309131936.5Nc8eUD0-lkp@intel.co=
m/
> > >> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> > >> ---
> > >>  kernel/bpf/syscall.c    | 4 ++--
> > >>  kernel/bpf/trampoline.c | 6 +++---
> > >>  kernel/bpf/verifier.c   | 4 ++--
> > >>  3 files changed, 7 insertions(+), 7 deletions(-)
> > >>
> > >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > >> index 6a692f3bea150..5748d01c99854 100644
> > >> --- a/kernel/bpf/syscall.c
> > >> +++ b/kernel/bpf/syscall.c
> > >> @@ -3211,8 +3211,8 @@ static int bpf_tracing_prog_attach(struct bpf_=
prog *prog,
> > >>                 }
> > >>
> > >>                 tr =3D bpf_trampoline_get(key, &tgt_info);
> > >> -               if (!tr) {
> > >> -                       err =3D -ENOMEM;
> > >> +               if (IS_ERR(tr)) {
> > >> +                       err =3D PTR_ERR(tr);
> > >>                         goto out_unlock;
> > >
> > > IS_ERR does not check the null case, so this should be IS_ERR_OR_NULL=
 instead.
> >
> > Actually, bpf_trampoline_get() would not return NULL. It returns ERR_PT=
R(-ENOMEM)
> > or a valid ptr.
> >
>
> OK, I missed the change in bpf_trampoline_get(). Anyway,
>
> Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>

That's too much churn to address !JIT config.
Just make it return NULL in that case,
instead of hacking things all over the place.

