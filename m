Return-Path: <bpf+bounces-58628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F43ABE811
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 01:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4343AE93D
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 23:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C521D5AF;
	Tue, 20 May 2025 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIahTFCa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF31BA36
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747783959; cv=none; b=r2hXvHfhnz/AcY3u+VucI+zYc2mUUuaD0L3Q1Vgds8a0rRTtZ4UaRNcaGDoBjKlv7mqiih0SOSNzH/4hCUA/FIfeNBIKZBUpgB4oOqRgBIqPAh5l7G2QUun0flSPzPiPT3IiAMOieYbbu2EaHNHmHFs1zfBbCW+SdBc9iDQ2Xfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747783959; c=relaxed/simple;
	bh=52mcWiyc+Xq9t3iZ9WWSVOQYD60EZCYu49LNweKynKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebsofa7arwyrVKhxCnA4zKpdry8lolcBwb2qZaqyHnseJkDjVL/taRBUarI/17262gWpsxGMwCabjBhxB66UNikauAPqVvakrGoC8/RWDizSnbW+rvvWa5mqj7FmetUKrHbQ91FOK4sllA5TNYItUTh3ripEJl61k0kfXSm1ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIahTFCa; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30e9b0f374fso4770087a91.3
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747783957; x=1748388757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btSbgWZQEQxAvW8UqKA0bLcDfhKnAe/VIvlamnBbDZs=;
        b=kIahTFCaQDdAlHLxC28P0zhKc+Tgxc6haRVn6S9I7yal1JwA7arbfM/VZT9evbLgKm
         Zev9JCnkEoXP9wlGGO57DlLIWo03OmcnhMMziCLYZ94cAfHRJeFKpmrEc29mKRt3Vr4/
         1EVT2EHSJaahqnq0XST0R8GH0xHtrz8GgoiUGtJzbL2OseHQWRv2xcmi4z5RwMJ5V7RN
         JbWQ+59SU6UlxVN04IgelJ4rIoFL9+o0XQBdNniqX3foJ7ZFGgGdFM57W2u0efocaApx
         ztcBq0OrHOmUhfWgK7IMBvAMHzbAiaWPruPLW0Dtvzlo/pHwt7ks3vR4IMVaLfpoRkP1
         jqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747783957; x=1748388757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btSbgWZQEQxAvW8UqKA0bLcDfhKnAe/VIvlamnBbDZs=;
        b=hzyIcMZC4XRNSZKE8KPwziUhhAT5Oq+sChKtCxJyf8e/JlYmsknvNOv2FxpJGcaFWg
         eTDIanA519/9H9FVbZdPvkrhdpiKOphGDuxyqxs1VJfEm6ivjvYPLH9V8nBPboskeDoR
         l7WX56XY3Ca3Ph/w/2biEG00rE4ZFVfd1BLtKxdrDnddNKpRZT3bKbulAY+k9T83SXGw
         gHbkZrSeWyGSIDJw7c5OfctP9XG63bxjzIzlwuWptu8Kpovu7ZC0QTwCF9fRqWCwabgr
         Wjny0VqtMZzTFTbv+wFjasRqEeVPOmwtzyLOtsRYDLahpKs+vUuJxe99HQl2a+HDR/so
         CLvg==
X-Forwarded-Encrypted: i=1; AJvYcCVLgg1cGjAp76KyBXcjIU66L0+ykjg0OhGXRNGtvFiHZcnNpt58kxf8cZTt8ce1CyV2rQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDRLWRzCSrMF6HulrufCHRn03SqEJ9GU3IqrKbVGjYvC2Zkc05
	8qTmaDsaXgW9DY6cj8M45tEmox/zn3ePZTCKfQOHnxgyefFfS5QCwkAqM3a6aFtiospByT/5aGL
	pv42KCc79RZ8rdT3vMt0eAaX4PDbHcyw=
X-Gm-Gg: ASbGncsnj9PE9wO8BSJiIDMLxEVLDKy31oYAXhBxrTjo2Ge5uL5GoXCwB1v21PvghPv
	QJBKIHHYiJwvMEGgj94GkRZgJJFKc7nmsyZd6cdcqsIl41DhoCngefeG1213R6zkNY4d/3dTRjU
	S0ZYMMSEWePN41bS+eDqCIAADOTfPS/Ft2/98I50o16k/FnE+Da+/7R4hM9rs=
X-Google-Smtp-Source: AGHT+IHCHSkY4+oYnt9LNhIX4Na6slRaBPDssT+/pu3BfEjEThTmfyyyV8EoIQf2QB8ifbPtIr+bFxV0og9MmakT3z0=
X-Received: by 2002:a17:90b:4c47:b0:30e:391e:ac00 with SMTP id
 98e67ed59e1d1-30e7d5564f2mr33847458a91.18.1747783956877; Tue, 20 May 2025
 16:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <20250520060504.20251-5-laoar.shao@gmail.com>
In-Reply-To: <20250520060504.20251-5-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 May 2025 16:32:24 -0700
X-Gm-Features: AX0GCFsqSuLMxdRF1OOKdGhrul1QiEzKLm6-PSF1Ax2BBApTh3q9xUkEnLQYkpo
Message-ID: <CAEf4BzZ0nYsSU3+7cNrC9P0WyfTCj1CY-nK_C3-1Qh3aZqd34w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] bpf: Add get_current_comm to bpf_base_func_proto
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 11:06=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> While testing the BPF based THP adjustment feature, I noticed
> bpf_get_current_comm() isn't available in bpf_base_func_proto. As this is=
 a
> commonly used helper, we should add it to bpf_base_func_proto.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/cgroup.c  | 2 --
>  kernel/bpf/helpers.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

please rebase, there were changes in this area and
bpf_get_current_comm is already in bpf_base_func_proto (and
cgroup_current_func_proto is gone)

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 84f58f3d028a..22cd4f54d023 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2609,8 +2609,6 @@ cgroup_current_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
>         switch (func_id) {
>         case BPF_FUNC_get_current_uid_gid:
>                 return &bpf_get_current_uid_gid_proto;
> -       case BPF_FUNC_get_current_comm:
> -               return &bpf_get_current_comm_proto;
>  #ifdef CONFIG_CGROUP_NET_CLASSID
>         case BPF_FUNC_get_cgroup_classid:
>                 return &bpf_get_cgroup_classid_curr_proto;
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e3a2662f4e33..2a60522cd66f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1965,6 +1965,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const=
 struct bpf_prog *prog)
>                 return &bpf_get_current_pid_tgid_proto;
>         case BPF_FUNC_get_ns_current_pid_tgid:
>                 return &bpf_get_ns_current_pid_tgid_proto;
> +       case BPF_FUNC_get_current_comm:
> +               return &bpf_get_current_comm_proto;
>         default:
>                 break;
>         }
> --
> 2.43.5
>

