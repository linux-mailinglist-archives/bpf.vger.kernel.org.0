Return-Path: <bpf+bounces-10131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C70EB7A1410
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 04:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF831C20C66
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6FC1FA4;
	Fri, 15 Sep 2023 02:55:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A1EA3
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 02:54:58 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC68E2701
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 19:54:57 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1d637f9c587so691802fac.1
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 19:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694746497; x=1695351297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXHuhIzDe/bz+j385T2N3ck82lc0SQui6VrsSZllf/U=;
        b=SFr/eLsIpyotKeXTrSrrzl5FZsta04lsDjBd1dFdsGC5ege7RCxH8oWEd4SA111WvC
         fEpLyzqGPacFjiyx7PztPBaqno5Ve9lQ4EWov57Rq/nal1seHLXcIQteaFYydHcyp45l
         5mVFrYJdF70T5RPA0zfU+M+LGAss8Y2K17gkbbTdUXyWDF5lWFa/Ilv2aBaahibL8Tcv
         SD2XOuFOzWHbLfQTro8uIdzRA9ksm0CvR2747DXOrSAk+MPtt7xrhunVLqRiMRW43XcG
         biVt3IhOmNttuDBPiw+8tLXDjt9gGW1iaGVjOZIHti1HTaUUgESbjIghnIMTgk+Clfkg
         R8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694746497; x=1695351297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXHuhIzDe/bz+j385T2N3ck82lc0SQui6VrsSZllf/U=;
        b=NE435S2RrhiVYhARWVbAjyrV0IaVuy4qLTUDyZeDq+eD/s/UIB3zDmFroK/qKZcVok
         d8JrfWPuXrx+7kbJ85lHXQ7WyBV9RhGeAIb+ltokyyGJx9L3h/7SKopMbGMJl0JT3TQJ
         rwpxTmR43HABlDKSv3h2xAfem2nDHg3XTmgb/E6TDpZtDdilPYpURE++alQUjb0KyCXt
         SyulLCcsrrxuIikbN/tZvIeMfr5NtbFOfFAV16Q2X+14vaV+Zj7GW7PbAu373xvWpQ8H
         bZgYaSDN4RGJIBwbvZFZzTwbRXtUFfM//beFbjqOOdZwlPNzYSoRRb7CH0xj1M0sntHJ
         OCzQ==
X-Gm-Message-State: AOJu0YzsZjNwAgNkLEDVdm5Fu1O64pgqLGuYuPTbpn9hTMXYz9OS23/4
	/qsMs+BOOp7D+UxzbAs8bvapRcCp5Li4jEGCGcY=
X-Google-Smtp-Source: AGHT+IEHcA5AJUWtENYmVw6QDQ0IfzJXz2t1wkPzOf2pVpYjCqHVoofHg2PF9orkC42UFWFq7uIor+zyrkjg38IC1vE=
X-Received: by 2002:a05:6870:c155:b0:1b4:4c6d:765c with SMTP id
 g21-20020a056870c15500b001b44c6d765cmr2623943oad.26.1694746497053; Thu, 14
 Sep 2023 19:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914145126.40202-1-hffilwlqm@gmail.com> <CAEyhmHRAvR=Ch-DjMpmpB0zeUsbQYcTXkMqyTSL9iwmZukcTgw@mail.gmail.com>
 <8148921c-cc06-bad7-787f-d190cba0bce1@gmail.com>
In-Reply-To: <8148921c-cc06-bad7-787f-d190cba0bce1@gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 15 Sep 2023 10:54:45 +0800
Message-ID: <CAEyhmHR9g+B67Fy_wmdTwHzMFhmdw86ak6dPFpMjui16ecTUjw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix tr dereferencing
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, toke@redhat.com, sdf@google.com, lkp@intel.com, 
	dan.carpenter@linaro.org, maciej.fijalkowski@intel.com, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 10:18=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> w=
rote:
>
>
>
> On 15/9/23 10:13, Hengqi Chen wrote:
> > On Thu, Sep 14, 2023 at 10:51=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.co=
m> wrote:
> >>
> >> Fix 'tr' dereferencing bug when CONFIG_BPF_JIT is turned off.
> >>
> >> Like 'bpf_trampoline_get_progs()', return 'ERR_PTR()' and then check b=
y
> >> 'IS_ERR()'. As a result, when CONFIG_BPF_JIT is turned off, it's able =
to
> >> handle the case that 'bpf_trampoline_get()' returns
> >> 'ERR_PTR(-EOPNOTSUPP)'.
> >>
> >> Fixes: 4a1e7c0c63e0 ("bpf: Support attaching freplace programs to mult=
iple attach points")
> >> Fixes: f7b12b6fea00 ("bpf: verifier: refactor check_attach_btf_id()")
> >> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> Closes: https://lore.kernel.org/r/202309131936.5Nc8eUD0-lkp@intel.com/
> >> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> >> ---
> >>  kernel/bpf/syscall.c    | 4 ++--
> >>  kernel/bpf/trampoline.c | 6 +++---
> >>  kernel/bpf/verifier.c   | 4 ++--
> >>  3 files changed, 7 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 6a692f3bea150..5748d01c99854 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -3211,8 +3211,8 @@ static int bpf_tracing_prog_attach(struct bpf_pr=
og *prog,
> >>                 }
> >>
> >>                 tr =3D bpf_trampoline_get(key, &tgt_info);
> >> -               if (!tr) {
> >> -                       err =3D -ENOMEM;
> >> +               if (IS_ERR(tr)) {
> >> +                       err =3D PTR_ERR(tr);
> >>                         goto out_unlock;
> >
> > IS_ERR does not check the null case, so this should be IS_ERR_OR_NULL i=
nstead.
>
> Actually, bpf_trampoline_get() would not return NULL. It returns ERR_PTR(=
-ENOMEM)
> or a valid ptr.
>

OK, I missed the change in bpf_trampoline_get(). Anyway,

Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>

> Thanks,
> Leon
>
> >
> >>                 }
> >>         } else {
> >> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> >> index e97aeda3a86b5..1952614778433 100644
> >> --- a/kernel/bpf/trampoline.c
> >> +++ b/kernel/bpf/trampoline.c
> >> @@ -697,8 +697,8 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_pro=
g *prog,
> >>
> >>         bpf_lsm_find_cgroup_shim(prog, &bpf_func);
> >>         tr =3D bpf_trampoline_get(key, &tgt_info);
> >> -       if (!tr)
> >> -               return  -ENOMEM;
> >> +       if (IS_ERR(tr))
> >> +               return PTR_ERR(tr);
> >>
> >>         mutex_lock(&tr->mutex);
> >>
> >> @@ -775,7 +775,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
> >>
> >>         tr =3D bpf_trampoline_lookup(key);
> >>         if (!tr)
> >> -               return NULL;
> >> +               return ERR_PTR(-ENOMEM);
> >>
> >>         mutex_lock(&tr->mutex);
> >>         if (tr->func.addr)
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 18e673c0ac159..054063ead0e54 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -19771,8 +19771,8 @@ static int check_attach_btf_id(struct bpf_veri=
fier_env *env)
> >>
> >>         key =3D bpf_trampoline_compute_key(tgt_prog, prog->aux->attach=
_btf, btf_id);
> >>         tr =3D bpf_trampoline_get(key, &tgt_info);
> >> -       if (!tr)
> >> -               return -ENOMEM;
> >> +       if (IS_ERR(tr))
> >> +               return PTR_ERR(tr);
> >>
> >>         if (tgt_prog && tgt_prog->aux->tail_call_reachable)
> >>                 tr->flags =3D BPF_TRAMP_F_TAIL_CALL_CTX;
> >>
> >> base-commit: cbb1dbcd99b0ae74c45c4c83c6d213c12c31785c
> >> --
> >> 2.41.0
> >>

