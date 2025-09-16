Return-Path: <bpf+bounces-68565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16FAB7E1E2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6147A326285
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FB228315D;
	Tue, 16 Sep 2025 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvlKFYK2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28327713
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062051; cv=none; b=BEhZFQ1PzZzdYCdm0mPHeNQRMOdPfW9v02TCwXHIOuoudcYun3sxeGQTbKOaJB79+Fx08r1nQyrXBuYFTCT/BXE3Fnrj1OZyMlS36/gOI/8ex04wrm39iRdBqaQLtQx+8Hc7FGenbMkzLSg6Sf2pc0+nGERUzc6/SDHmKW1o2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062051; c=relaxed/simple;
	bh=AZDn9JRlstN2zRfzJ49KVLs+4QqpcFAowDMCHXbZQXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIYTq7O2p0ueMCx8+KXt7Kd8h3i37QyZKllviVSs1yeE6qV4SuHCPLSEhc9SAp7xEWen+0nZdM7yzWA/LNGS/XlFUKnwE4QGaujgCsJU91L11p4RBEDfOrFQmkTpvReojDZlD0v2pB0JV48R2RYBV57UrqrCkuLsFSKPwDdmfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvlKFYK2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54c707374fso2061548a12.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758062049; x=1758666849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPj3viw/ebtEFZmMin4unftmNLl5BtYpClPjEsQnolE=;
        b=AvlKFYK2295qD1nznJM5Xhb1iFdU9ZPtiMrxbokVXxdv1PlWvBMZconDWba4TuAx6h
         5idhxYc6ZP9N1zLiP5Sn9pCMSCPOS3v75hT4euA73fqBvRwq6VZLGSQjWW6RCiPb28JB
         u1EXtgpjMSM8lnfH5FQssbocMoj4Em4HYz1Zc9H/kVj8BeyNC4JB1H7vsGWPqcqSkLgb
         Nu0mViWpNYmpyYfR7dqXWxVVcRE81eUfvs+gM18HyRI89E3xI/vCbrleuCGaBkUovaJ5
         euGyDP7xjo7DRI/6ecMtTkaDOurZ5zQvPffWvlgVbpTRa9bQ4WXwTh8HcIPNKE3y5gLe
         XezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758062049; x=1758666849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPj3viw/ebtEFZmMin4unftmNLl5BtYpClPjEsQnolE=;
        b=oq+6zp1K8p8egvWFNstMRwrdsPZ1VGjFnWO06/VqF34kSPijbE4W/Nar8ccKaz8qBY
         CZJJ/qb4K9JJ8wVBeA/sbiolnfQwcQ/Ym6pA2XRG98TbOXrFRqBhh+JvcakfnDP/N7HJ
         xS7DI08M91yH9TtXsf+bzV1iYAa0pBNsGJQBz2Vi2iHVBt93FtnvVHQMOYK1TuVuB996
         m2Wd0I/chen2Il/tmnipBxvKBzQet/i1349uWwdEJio6ryxL6mNMhSvLv2GU95uOVWam
         rrnpET+/JJShyyK5JpbuHFZPEQb0wTALakvSSalbL09XSWoibxuAUJXz1sRABJ0Wj3eD
         IwlA==
X-Gm-Message-State: AOJu0YxiEZ9FYvltFDGsXWLeeHCaCkiM0KZFBce+rgQSyTJUP14YqFbx
	Xo3lZ97/oTrVqe8sXHGnjQJC47luHq51nYYsMfB2GTtEgtopAA8PuI9yisJoT7tSu3q4nKX6s6Q
	r+Z4QF0NvL8RWbaw4hhBKHJAol/x8rBo=
X-Gm-Gg: ASbGncu7iOvD4mebMIF2CY7lFK1hasJZRJlrQQ6yCYAhHR2jXRhBJD0Cg5iqZlPZiuz
	6fZWjgs8SMJujYPlv8ACxMnvXRwu+29Ev9wqPoiARhj+JFbAbAq9cKQo7ghaTAVztJs61aWQCVA
	crOAFH8FF2CCFpaJPYxowePwCuE1GYQkr3AqrVALtByfEneewRgzhr/nANRyD4kMFmz7g4feAnB
	ex7nk0xYBiG6lmrsYuCXQM=
X-Google-Smtp-Source: AGHT+IGndSWHAk4YUGnLya1KcR+FEe39Pw5pUYyUU82DPq6Ig9PobfsfLeIKlCNRz6PyhGUBosLJ8nA+TiIRGNJ+iAk=
X-Received: by 2002:a17:90b:5788:b0:32e:59ef:f403 with SMTP id
 98e67ed59e1d1-32ee3f202bamr12857a91.17.1758062049382; Tue, 16 Sep 2025
 15:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916212251.3490455-1-eddyz87@gmail.com>
In-Reply-To: <20250916212251.3490455-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 15:33:54 -0700
X-Gm-Features: AS18NWCn1-QNFZRiO6F2Yt6U94Fq3WaqaIB3k4GYkDzbBBdxzcljzZN1wivPllk
Message-ID: <CAEf4BzYJW+O6CD5+V1wP3uF0=BBVNLrUwM+co7Pps8HF13p3Ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: dont report verifier bug for missing
 bpf_scc_visit on speculative path
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, 
	syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Syzbot generated a program that triggers a verifier_bug() call in
> maybe_exit_scc(). maybe_exit_scc() assumes that, when called for a
> state with insn_idx in some SCC, there should be an instance of struct
> bpf_scc_visit allocated for that SCC. Turns out the assumption does
> not hold for speculative execution paths. See example in the next
> patch.
>
> maybe_scc_exit() is called from update_branch_counts() for states that
> reach branch count of zero, meaning that path exploration for a
> particular path is finished. Path exploration can finish in one of
> three ways:
> a. Verification error is found. In this case, update_branch_counts()
>    is called only for non-speculative paths.
> b. Top level BPF_EXIT is reached. Such instructions are never a part of
>    an SCC, so compute_scc_callchain() in maybe_scc_exit() will return
>    false, and maybe_scc_exit() will return early.
> c. A checkpoint is reached and matched. Checkpoints are created by
>    is_state_visited(), which calls maybe_enter_scc(), which allocates
>    bpf_scc_visit instances for checkpoints within SCCs.
>
> Hence, for non-speculative symbolic execution paths, the assumption
> still holds: if maybe_scc_exit() is called for a state within an SCC,
> bpf_scc_visit instance must exist.
>
> This patch removes the verifier_bug() call for speculative paths.
>
> Fixes: c9e31900b54c ("bpf: propagate read/precision marks over state grap=
h backedges")
> Reported-by: syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/68c85acd.050a0220.2ff435.03a4.GAE@goo=
gle.com/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1029380f84db..beaa391e02fb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1950,9 +1950,24 @@ static int maybe_exit_scc(struct bpf_verifier_env =
*env, struct bpf_verifier_stat
>                 return 0;
>         visit =3D scc_visit_lookup(env, callchain);
>         if (!visit) {
> -               verifier_bug(env, "scc exit: no visit info for call chain=
 %s",
> -                            format_callchain(env, callchain));
> -               return -EFAULT;
> +               /*
> +                * If path traversal stops inside an SCC, corresponding b=
pf_scc_visit
> +                * must exist for non-speculative paths. For non-speculat=
ive paths
> +                * traversal stops when:
> +                * a. Verification error is found, maybe_exit_scc() is no=
t called.
> +                * b. Top level BPF_EXIT is reached. Top level BPF_EXIT i=
s not a member
> +                *    of any SCC.
> +                * c. A checkpoint is reached and matched. Checkpoints ar=
e created by
> +                *    is_state_visited(), which calls maybe_enter_scc(), =
which allocates
> +                *    bpf_scc_visit instances for checkpoints within SCCs=
.
> +                * (c) is the only case that can reach this point.
> +                */
> +               if (!st->speculative) {

grumpy nit:

if (st->speculative)
    return 0;

... leave the rest untouched ...

?

> +                       verifier_bug(env, "scc exit: no visit info for ca=
ll chain %s",
> +                                    format_callchain(env, callchain));
> +                       return -EFAULT;
> +               }
> +               return 0;
>         }
>         if (visit->entry_state !=3D st)
>                 return 0;
> --
> 2.51.0
>

