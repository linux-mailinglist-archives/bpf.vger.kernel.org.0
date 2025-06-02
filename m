Return-Path: <bpf+bounces-59461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70985ACBD5B
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 00:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DD53A49E8
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 22:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C4F205AB9;
	Mon,  2 Jun 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khk1dtpR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1CF9EC
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748903593; cv=none; b=PoRgeGlBUVzDDs/AVgpWwRCszpwsniJ3HCN2CrV4+ashhXdPjoV+SKCyTVUrsIjgarVtahjfRG/SuaKDUHIR9hHOQ6u+JVCZOt5O+Z1J8JyRzOT5HYV6lS3Q85F4Uze1inqBDfS97IffcdRDHXo/8aMhJJSXhODZ4y2x3Bt43yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748903593; c=relaxed/simple;
	bh=QvItA01C2d6PTqBiSJvVnXk8PaTTC/zXs5LwGG5O//E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/GNXoiZs9nIU4CPsiJi7Liqt13ZWR9CNHBl5QCHCMCU7UYLC2sRt7pGwXxmoy8hICrKmsX4peI2+dB2eHaUHeeOdM9lTmQS3h2Tzbni6m9+airV1fMS7kx4fJVbZj1WfqKH9m456E2/0Y4mcWsRqp1+hVGgtcCIi2bXhCCEGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khk1dtpR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so57060975e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748903590; x=1749508390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tn4zZezOlNpn18RyYHX4eCFsOaCZlRVvusPPhE1Ixw=;
        b=khk1dtpR72w1iwxmbfV9/PtmI8jfWHuhd9I1xT0RvcvBJFZ78/b9VfjN6kkYv7163h
         f2yrlBtPnBQ92bf+uU25oQp1tsLJwOBXM6orovrhrzffqpb4RjjTW3NoyUeB3E/+XZft
         tWElsAxuFRDOkgMDtF8mU+2kXLTXt9WsToTjFwCGNktW6yTFmBQ64vygf4kBiL3quwrS
         vRFTCru0UFV33BFgvhOMtSaoehPqIQGjyDpnY+yNIx54umYNhVl6VhZ5dE8rhTZcuSTI
         rX8RhdAhM/o1TDqiSW2snPTAaBeY3/Sqko1afnPx/Tp0HifZY0z3yIXKayU4bx7YlCSF
         Y0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748903590; x=1749508390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Tn4zZezOlNpn18RyYHX4eCFsOaCZlRVvusPPhE1Ixw=;
        b=XLDvG8K3tJ1zD30HSdwnG5V1k+A9J/P4O7Ey7ijHIlTTfb09PHzgIkvK7AJFTre1M1
         GO8fsyKjhJPT7L+2dyU91IxhzA29oj3aYn1tbnAdlLR80JsFb89nkV/dWdOoC7p8R+vX
         amwbu5dyixnVPp7c7xr/rQYQrdd4URbXI9XxYrcpw6Ao3Cw9MuI9jFsuqDaXTnjjQHJL
         AsA6dch2AtIJ8ObHxE5VvReNwfFzR6qOaZKvxnPnFlcmYnQINdvjuq/MYoAjzZpooEqb
         AVjupgiMl5r6W/daoFWcteT02Hxf4lTkExXYXXVbuW0wIoZXLoA9dhy7q97XBuGni6OH
         I+bA==
X-Gm-Message-State: AOJu0YxNw3BANxM9IUt6e8KAPp5wfWJwze5P7OtHibKFJuvL1qaUumoh
	3/XzqwmoymwBYkDyBKE58xflILbZS5hg2l0bkpyETssXaoC/eqmt/lPM9a149FawtsMS1qXmO8k
	bwqncmMxOvtQX4N+n6x83BpGdexWmllw=
X-Gm-Gg: ASbGncvRqQxAsct0T3nWBC3pqcKJCfCxqpwvOyfowXNhNEq/EwCNZu4oAROqwrGA9KG
	cx+8DdlcUSnpYty4eGqISz6q/DYaYL/Wdg7C0kLASLeI01KunWEbs5OtxxIQLUDxNAPLsrQ7ZDX
	5Ct90sAdv7ElCOYzawqYUIKYWYTOJA98QVtVTcv7dIVIJCsRXcQDtE3hGuEYj0zA==
X-Google-Smtp-Source: AGHT+IEjYzhQipzFQN7dUC7lQUGXpeNrQDA7lucNBb8VsHGkqVA2uAj+bAAQZ8b7ueURPBnMqMKQTjYXDVTvZ5MMX1Y=
X-Received: by 2002:a05:600c:500b:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-4511ecb9d73mr80548335e9.7.1748903589771; Mon, 02 Jun 2025
 15:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-8-memxor@gmail.com>
In-Reply-To: <20250524011849.681425-8-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Jun 2025 15:32:57 -0700
X-Gm-Features: AX0GCFs9ylLQT6ox7kesqLBrAgv8hitHqpeE51w2OYKi9Nau7K7OFCztfdWtaAs
Message-ID: <CAADnVQLMP3AiuLA7rU2pKbUgatxt+NtrJRUiBm-8tBqYB58=0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/11] bpf: Report rqspinlock
 deadlocks/timeout to BPF stderr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 6:19=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Begin reporting rqspinlock deadlocks and timeout to BPF program's
> stderr.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/rqspinlock.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 338305c8852c..888c8e2f9061 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -666,6 +666,26 @@ EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowpat=
h);
>
>  __bpf_kfunc_start_defs();
>
> +static void bpf_prog_report_rqspinlock_violation(const char *str, void *=
lock, bool irqsave)
> +{
> +       struct rqspinlock_held *rqh =3D this_cpu_ptr(&rqspinlock_held_loc=
ks);
> +       struct bpf_prog *prog;
> +
> +       prog =3D bpf_prog_find_from_stack();
> +       if (!prog)
> +               return;
> +       bpf_stream_stage(prog, BPF_STDERR, ({
> +               bpf_stream_printk("ERROR: %s for bpf_res_spin_lock%s\n", =
str, irqsave ? "_irqsave" : "");
> +               bpf_stream_printk("Attempted lock   =3D 0x%px\n", lock);
> +               bpf_stream_printk("Total held locks =3D %d\n", rqh->cnt);
> +               for (int i =3D 0; i < min(RES_NR_HELD, rqh->cnt); i++)
> +                       bpf_stream_printk("Held lock[%2d] =3D 0x%px\n", i=
, rqh->locks[i]);
> +               bpf_stream_dump_stack();
> +       }));

I agree with Eduard that hiding __ss is kinda meh.
How about the following:

struct bpf_stream_stage ss;

bpf_stream_stage(ss, prog, BPF_STDERR, ({
     bpf_stream_printk(ss, "ERROR: ...);
     ...
     bpf_stream_dump_stack(ss);
}));

