Return-Path: <bpf+bounces-51190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B071A3191F
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 23:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF124168A28
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 22:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EB8267B18;
	Tue, 11 Feb 2025 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMITmpTo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648CC27293D
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314653; cv=none; b=B9O348pdJ9v5tFepnz2d8ftXnZac8Md7C1FanymthLxCBM1Ce39cTLNPOA+eYapMLhl5hwzYiRF4kWgBnXduWyVaam70UTYYb7K6Tb2GkNPMcEPKQS/wzfajOr7JlNXHa/J8TVkXcIURMc4LbXZaf+E5hZep3VvlnZgZBGNhM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314653; c=relaxed/simple;
	bh=UA4UDBVb8SDTUJPw9sXClwLJKNgTByZPbhaf0r/2Rok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxMjlgaOMk9+HQr8WM8gSJQjJfSHOqqRS17ifwHC9/x7kWPDimnhGb4JnTfpsAg0X5cbkwZlE1PeU2zde8z2iDxnKQvPupgpaXrkXoH1+B4A+fPWEJjQ3bFjnACuSWAp+kX4t3mwHgkScD6NWniC/VzKPCPG/6EcBQRXSaG+tUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMITmpTo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21fa56e1583so41879995ad.3
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 14:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739314651; x=1739919451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2AYmFnblu3KhpfV3tOM8o64IuwmyIF4iPW60QdFeuw=;
        b=iMITmpTolUTHhq4zYRmpMKjnerrBcHYX+6mPKA4wYuwe8xbo3u9Dy3yMzMXdJSQyjb
         qdraOass4oe8UD/oqSKXF19pJ24g0NaDFts/pSBndRo3EZGev+RuCRrPb9RxI380JrJw
         CTPRjL0ayqyhchkKMuaoD4CZV3gJg37qw48Fc/QVfu3iGZ8IFde/WAq7F9fanClvb2y/
         3PD1O7glLoHYgt4Xs4IjeGO2jTDspjGbGtiCZ/1f+g83IWEPPlEc86ehS+mp4/ZMy27o
         aCQ/Ys6wJ0KupgoNlZsrTTZewJQj5fn5YqPHXqPY/g1vH+SlDXbjB1jm7KWq2h5+ADQO
         5Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739314651; x=1739919451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2AYmFnblu3KhpfV3tOM8o64IuwmyIF4iPW60QdFeuw=;
        b=usTsKaO1IMjOWhbbdLDElFS6ocAlHu5+k0evMF/KE+mMnNbg424vibkSp58f7nT/Ci
         anctORUd5IKdIHz4GF8+V1bgnezTPjRum7HotmDUSmPcIgQIekPH/XCX0YToAFrJH4U1
         RKQYCc48vRX4zG4ifUtRYdMh36Iz8m1imCtkZ6CPcgeluMPGX4RviKZdGWMJZ2GjcFko
         KDnCvpPRtUxxcoBrCncJIyJ9zDfTe4Wc8KSogJd8+BUNt5Bucwhv6eC/93QpynARzU06
         mut8WlY7R6IA4i7wjVQ28MjHInpL6LgJYDa1N3vI+Xe5n7xC5qpUW4Wa6B5RYeJgPInS
         hmxA==
X-Gm-Message-State: AOJu0Yyo6fuFWt501qm3RNuNunoRifjuhGZ2L7o2sdyqJj+mnL93VajH
	GFqbJtngZPcOlZNirE/t5uM6cAccQbC1Qq9brwSOjhD8BlmWSkGteHa6/5rqmMelPexbGViATbk
	LAQdIJY4SciCkJfEj1LyBmqSFYXzNXg==
X-Gm-Gg: ASbGncuPtMeeLxR3eHowUmilOGpXZ7CAwzX99wgJOMKA4xxYCVuu9baSNNVkG6GfMg5
	s0eEvAMWMaCSER/qVtoz5vM6T60P8WFwSOI3WaRxVta6d5julL5TeXQSdpDCH2VeG8fqYAVl98m
	McQEm3875Ga9+r
X-Google-Smtp-Source: AGHT+IH36r8rvmW8aHb/lmEshOg1846KgwbwcmIs994c4iQT5g+bGMgm3k7S77MOQBjhrB+0U7PAnoMJHp4muOKEIAs=
X-Received: by 2002:a05:6a21:78a9:b0:1ed:a4ae:3b80 with SMTP id
 adf61e73a8af0-1ee5c72e401mr1513103637.6.1739314651525; Tue, 11 Feb 2025
 14:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206225956.3740809-1-yonghong.song@linux.dev>
In-Reply-To: <20250206225956.3740809-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Feb 2025 14:57:18 -0800
X-Gm-Features: AWEUYZla8N2rSigYgTTVxBOccqyJ-ttpgFz2zOozx3Z_hQ0BtEvUjVklJAoupQE
Message-ID: <CAEf4BzY2F33FT2pDO8Zy1_zuQJVbwSS4OoMbBsEcyBVDTaKSeg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow top down cgroup prog ordering
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 3:00=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Currently for bpf progs in a cgroup hierarchy, the effective prog array
> is computed from bottom cgroup to upper cgroups. For example, the followi=
ng
> cgroup hierarchy
>     root cgroup: p1, p2
>         subcgroup: p3, p4
> have BPF_F_ALLOW_MULTI for both cgroup levels.
> The effective cgroup array ordering looks like
>     p3 p4 p1 p2
> and at run time, the progs will execute based on that order.
>
> But in some cases, it is desirable to have root prog executes earlier tha=
n
> children progs. For example,
>   - prog p1 intends to collect original pkt dest addresses.
>   - prog p3 will modify original pkt dest addresses to a proxy address fo=
r
>     security reason.
> The end result is that prog p1 gets proxy address which is not what it
> wants. Also, putting p1 to every child cgroup is not desirable either as =
it
> will duplicate itself in many child cgroups. And this is exactly a use ca=
se
> we are encountering in Meta.
>
> To fix this issue, let us introduce a flag BPF_F_PRIO_TOPDOWN. If the fla=
g
> is specified at attachment time, the prog has higher priority and the
> ordering with that flag will be from top to bottom. For example, in the
> above example,
>     root cgroup: p1, p2
>         subcgroup: p3, p4
> Let us say p1, p2 and p4 are marked with BPF_F_PRIO_TOPDOWN. The final

I'm not a big fan of PRIO_TOPDOWN naming, and this example just
provides further argument for why. Between p3 and p4 programs in
subcgroup, there is no notion of TOPDOWN, they are at the same level
of the hierarchy.

In graphs, for DFS, PRIO_TOPDOWN semantics corresponds to pre-order vs
(current and default) post-order. So why not something like
BPF_F_PREORDER or some variation on that?

Also, for your example if would be nicer if p1 and p3 were the default
post-order attachment, while p2 and p4 were pre-order. Then you'd have
p2, p4, p3, p1, where everything is swapped relative to original
ordering ;)

> effective array ordering will be
>     p1 p2 p4 p3
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf-cgroup.h     |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/cgroup.c            | 37 +++++++++++++++++++++++++++++++---
>  kernel/bpf/syscall.c           |  3 ++-
>  tools/include/uapi/linux/bpf.h |  1 +
>  5 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 7fc69083e745..3d4f221df9ef 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -111,6 +111,7 @@ struct bpf_prog_list {
>         struct bpf_prog *prog;
>         struct bpf_cgroup_link *link;
>         struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
> +       bool is_prio_topdown;

let's go with `int flags`, we increase the size of struct
bpf_prog_list by 8 bytes anyways, so let's make this a bit more
generic?

>  };
>
>  int cgroup_bpf_inherit(struct cgroup *cgrp);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index fff6cdb8d11a..7ae8e8751e78 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1207,6 +1207,7 @@ enum bpf_perf_event_type {
>  #define BPF_F_BEFORE           (1U << 3)
>  #define BPF_F_AFTER            (1U << 4)
>  #define BPF_F_ID               (1U << 5)
> +#define BPF_F_PRIO_TOPDOWN     (1U << 6)
>  #define BPF_F_LINK             BPF_F_LINK /* 1 << 13 */
>
>  /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 46e5db65dbc8..f31250c6025b 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -382,6 +382,21 @@ static u32 prog_list_length(struct hlist_head *head)
>         return cnt;
>  }
>
> +static u32 prog_list_length_with_topdown_cnt(struct hlist_head *head, in=
t *topdown_cnt)

instead of duplicating prog_list_length(), let's add this `int
*topdown_cnt` counter as an optional argument, which prog_list_length
will fill out only if it's provided, i.e., you'll just have:

if (topdown_cnt && pl->is_prio_topdown)
   (*topdown_cnt) +=3D 1;

as one extra condition inside the loop?

> +{
> +       struct bpf_prog_list *pl;
> +       u32 cnt =3D 0;
> +
> +       hlist_for_each_entry(pl, head, node) {
> +               if (!prog_list_prog(pl))
> +                       continue;
> +               cnt++;
> +               if (pl->is_prio_topdown)
> +                       (*topdown_cnt) +=3D 1;
> +       }
> +       return cnt;
> +}
> +

