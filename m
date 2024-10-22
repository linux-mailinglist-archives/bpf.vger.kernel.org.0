Return-Path: <bpf+bounces-42844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583FF9AB9C3
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 00:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB71F1F24263
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2E01547E9;
	Tue, 22 Oct 2024 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrfpexLR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D12A14A08E
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637956; cv=none; b=RmFDTKevFPY70ayg5YTMcWuFZP9tQZ2DBU+bCm4LXUVTMsIYK46ZOzLbVfiFd6xsiyeQxNH4suLzmkThBI+QzkfZIiTbHVxw3gp3wNDvvHt9gp4b0wEpqY5LFTQxfVuJ8E2gIPF9rZAI8nEXaK6KMC6XFXu/J8FdqbvYhlciTiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637956; c=relaxed/simple;
	bh=LtjQStD3W2cerL2wODY01qXlcmaj79v4iEjbmRHslZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7OFS9QnDNeKSoZ7IIygN9GCm3x39NBzUjZ75Kz0TZGtUHeYp+AXnZ5w/FKm9/JZ/k8hhI1fASmuRHa70mHvZI0d08GEqss7Qy0bxUAmjcpU0jou+VviZmkR0TTooNHZuO7dqy9dXeZHe/ilTspH+fV3oNpBEvpX/3IYCZXQX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrfpexLR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so2668941f8f.2
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729637953; x=1730242753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejPyTkA5XeqEI0utAbsS8z7+TQaIYx9z7mjhL5egdCg=;
        b=JrfpexLRLlXDSQfq/iMUU7LGZd9kIi1h6iruZLuwQyL15AlYiLlNLHZKeQ5Qiuy6MF
         UJvY5XF0APXxdEhjnYNCal54duM20QlQ56awKNP+x4BpQ/ggIqsVLtmANW7/o/nOQ2Ev
         3z1hEABHOH2hvxKiSi4CTB15TXBrC92nRaufWBrxRCAy/hi0gEVosrakjUjc6vl9Z0z2
         rt43UmCp6G/o3ntAUKqsjDr5rnkzsvO0r5OI5Xq/p9u53rvrr7zuKJwCG7b9hqjnGtGf
         HTkKkyrm6eHZY7oSO4TPdUQ5k/EP442VQUIu78+DOOUPUzEM7WPt3HSjgYRq5QGW3Nw1
         CCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729637953; x=1730242753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejPyTkA5XeqEI0utAbsS8z7+TQaIYx9z7mjhL5egdCg=;
        b=ILcsVRoZov0npH4Cb2Q3ulF2TRWvFmHtEUtJzwBhf/cDKMU0e1CGQ/H0ebHrDoUA5A
         Ny69Ytvwd/evuGistFxhlnm8Jf8kHpQm4Xe/IkszzMcTrXov5yewrdxX5PvgHOYuVn5u
         G3HcfKIFSK25a/3LeRtMyKMrQDMY959v3fwgFjPPUW1lZIpfrGQLWa8hMbgTjeI04VZv
         lN5u6F8TuK0oyCUisnq5dpd4uBUPqNjFHMfNQO4jMVNicqHLtnJAG7PpKPNNcUCgMKdd
         KAr5WErlUCzJNw7CKPJ57Ol2wQHeJrNDsahvyzjBZFHQirqDgUWoXO2HQlX/TYwSVXSz
         1YBA==
X-Gm-Message-State: AOJu0YzNz0FL47ThdPI3Vb76YsZ3kwD8iWVxzMUlH6Q6CgjMY8s3nh7X
	86LcG0R/q6mA3aY0/fBJ2slrvX7MoZpCDwLMDxgbeS8vRijfkv7YoMMqad1gVapr4WaY8vY4m93
	zq0JAF82UGDkTcsJJpGLgh4ZPsIw=
X-Google-Smtp-Source: AGHT+IFFLp5+JD3nhwvlmzz3FmNoJrd45SIW8hLEjZe61zH+EADVgnzFMyLtuPpjIK9PndyykqiT8T+tiL9DEI1+PqY=
X-Received: by 2002:a5d:6a47:0:b0:37d:4afe:8c98 with SMTP id
 ffacd0b85a97d-37efcf1a540mr295688f8f.26.1729637953306; Tue, 22 Oct 2024
 15:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191347.2105090-1-yonghong.song@linux.dev> <CAADnVQ+ZXMh_QKy0nd-n7my1SETroockPjpVVJOAWsE3tB_5sg@mail.gmail.com>
 <c6e5040b-9558-481f-b1fc-f77dc9ce90c1@linux.dev> <CAADnVQJCfiNEgrvf6GuaUadz6rDSNU6QB3grpOfk2-jQP6is4Q@mail.gmail.com>
 <179d5f87-4c70-438b-9809-cc05dffc13de@linux.dev> <CAADnVQL3+o7xV2LQcO-AArBmSEV=CQ7TQsuzBfTUnc_g+MhoMw@mail.gmail.com>
 <489b0524-49bc-4df4-8744-1badd40824be@linux.dev> <CAADnVQJJxyoLvFY88OEGzy0MUnL5O8KCMdedDdAvqYcWDJsDXw@mail.gmail.com>
 <8f572c9d-00c2-48b7-b57f-bd6445c5d514@linux.dev>
In-Reply-To: <8f572c9d-00c2-48b7-b57f-bd6445c5d514@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Oct 2024 15:59:02 -0700
Message-ID: <CAADnVQ+hCW+BqFMuUQsiTNqd7jz=Lupo-h0N=f2tdeUS0vcB1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Allow each subprog having stack size
 of 512 bytes
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 3:41=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 10/22/24 2:57 PM, Alexei Starovoitov wrote:
> > On Tue, Oct 22, 2024 at 2:43=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> To handle a subprog may be used in more than one
> >> subtree (subprog 0 tree or async tree), I need to
> >> add a 'visited' field to bpf_subprog_info.
> >> I think this should work.
> > This is getting quite complicated.
> >
> > But looks like we have even bigger problem:
> >
> > SEC("lsm/...")
> > int BPF_PROG(...)
> > {
> >    volatile char buf[..];
> >    buf[..] =3D
> > }
>
> If I understand correctly, lsm/... corresponds to BPF_PROG_TYPE_LSM prog =
type.
> The current implementation only supports the following plus struct_ops pr=
ograms.
>
> +       switch (env->prog->type) {
> +       case BPF_PROG_TYPE_KPROBE:
> +       case BPF_PROG_TYPE_TRACEPOINT:
> +       case BPF_PROG_TYPE_PERF_EVENT:
> +       case BPF_PROG_TYPE_RAW_TRACEPOINT:
> +               return true;
> +       case BPF_PROG_TYPE_TRACING:
> +               if (env->prog->expected_attach_type !=3D BPF_TRACE_ITER)
> +                       return true;
> +               fallthrough;
> +       default:
> +               return false;
> +       }
>
> I do agree that lsm programs will have issues if using private stack
> since preemptible is possible and we don't have recursion check for
> them (which is right in order to provide correct functionality).

static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
{
        switch (resolve_prog_type(prog)) {
        case BPF_PROG_TYPE_TRACING:
                return prog->expected_attach_type !=3D BPF_TRACE_ITER;
        case BPF_PROG_TYPE_STRUCT_OPS:
        case BPF_PROG_TYPE_LSM:
                return false;
        default:
                return true;
        }
}

LSM prog is an example. The same issue is with struct_ops progs.
But struct_ops sched-ext progs is main motivation for adding
priv stack.

sched-ext will signal to bpf that it needs priv stack and
we would have to add "recursion no more than 1" check
and there is a chance (like above LSM prog demonstrates)
that struct_ops will be hitting this recursion check
and the prog will not be run.
The miss count will increment, of course, but the whole
priv stack feature for struct_ops becomes unreliable.
Hence the patches become questionable.
Why add a feature when the main user will struggle to use it.

