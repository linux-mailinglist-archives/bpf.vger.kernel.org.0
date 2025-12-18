Return-Path: <bpf+bounces-77005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB698CCD076
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2A8B301A9BF
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5692DC79A;
	Thu, 18 Dec 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTEqC2Bj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE922C21FC
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080411; cv=none; b=KRFTft0PR64rQiwX5WD6odMgxpkLwPQKOwOBf0h4TbJ6zx71NEoH/ozYijcpQKZfNFrxhcLiBcdLCGwL57vm7DqQ2wfzRMzpaVd98P4Zro2ym7XeYzFW87mGq9ObagiMT1KGOjgN/qew8CwfbAyWvE2VlX2yzTZAV5DmRjnYTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080411; c=relaxed/simple;
	bh=IdJ+EQH2wqH7h1SfY1RLMDhuiM7Gs5C4pRm4gddZMP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfX0f3HFu9XaG/SR9rOtQG0ALRLGrGr6OkxBM3jWyTD/KL8x4y6qE+EPXpMIZ7r+eoX++olVkfTKVHzIQsfkdSvJZ1wS5wtj50isNhX19ocRmnqV41fpqcwC8cYkmWLhBEW6b5NyEBMHygsE+qh/EKMowuUEggCgochvxXLEsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTEqC2Bj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so737706f8f.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080408; x=1766685208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WNlJ92LZq2r69K8djqkrzdHIPvFecU1NXYCmz8bcMg=;
        b=VTEqC2BjCexs2qrnaLc/pg8jDPJQlgEAi80KFWiuKK8ADyC02TOQPP2yUDVyBePBK7
         gh5BH+RWM7GrOo5NRhD36svroyoVQ7mrDdTjh7UAonwk+kGw/gMz9OHVX9yZ98m/pzS9
         I6Ka+8+r5O+MYF6Ie0xxIMUgyEtSVNRGPMjCPnJrfV9ccFv/PUrdElKoVIj2p/eXEi54
         MVcvBKB/90Nw626qjUAvZ/Q1KzBsOueQY97V30qXEGwPnsue5dRuZJF1CKsoS5OrYmfm
         Zup7oxyyBo5xgJuNSJiHwbFVy3twi+reNYEBRuViTfYLj/GOlSxDNhohn/noBPS5lQUs
         SFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080408; x=1766685208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1WNlJ92LZq2r69K8djqkrzdHIPvFecU1NXYCmz8bcMg=;
        b=pgvBz2ZpqGltVupCuBCUbV4vK/09nwqca/GK6JQ4SyUbhmvvVd2583hxRtm/cTLP7K
         J2BXF6ihI0vZfNvbZeIQmPK/7qDrHOKLjkB2LPP1XcxCBEtY9UZkUF/QLq0WzY7TkThh
         5xnp7BUrILD6BJeOOTH1upMFMyhOyR3XpbTx9Yw6+PVPdAvDAuviIrl6STgmLB9Q50Wl
         Za9s8PBdVlfGHNHpN41nz/5HqDfB02/t+MG3RelQmxptNtFZVbJEmxHIvJ5nhCHa5BFK
         6GE0/Lnapk22bf05Z2bvgi7QuPxFKbFUhUflpti6rq3d8JKrfdVPe9MxUClI0lcCwUcv
         cr7w==
X-Forwarded-Encrypted: i=1; AJvYcCURYw5GtMzCSDuaktH+slv5B8HMhVmMqKNmkxapQON4GCEuplfMKkuf79GnaZwng3wmcF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOcvqpVfwbtrfVSkhFe/sn0rrvOo4wJXBRh9VxHQN5mdmvogQ
	+awyRnLC3KEbP/VqsXI7GKbNkmCWP8atw1hVbxH5Xugmu3rym5bMZGzrEshjNqbAGEqFSEkQ/dI
	BbQSDg8YzoN7QU9u8frl9jaRJs16hrbI=
X-Gm-Gg: AY/fxX4F0/AmbKw4rUKz9l0Y4xySwJ/9o1nL0GLI6oB6+OftfwATunKiBFdDywl78b7
	lDN3s7+jFNteAm+X7xNXIK7M+TJ35NK7HnxMjVMPTeqNQKqclyUigfrubpDsLv4u5XKedk/fzNk
	QPEF38f9ddOfCb/BwAqtGkBCFzAmjd0NRNZXXj0S/ouMxuaMcbuIKNPKESHJwp436UrwRXQWGtg
	u/01f+iqTt2XvzY9iJUVhZyh2Ink2xE/7EHitzNrDrzbw5wlJF5mBt+SsExONQqfD4auvsjkLjn
	UzEOQ5ZD4GgjwtyzbE/yhLb9W7IB
X-Google-Smtp-Source: AGHT+IHIQG3KPrL89BQj4BmPCTpBgWQXIV5FxERANZjtm6o3ZifVUbfQgAxyb/wpz7YSEq3h2aIfbGrBx9nICgoZpuw=
X-Received: by 2002:a05:6000:22c8:b0:42f:f627:3a90 with SMTP id
 ffacd0b85a97d-4324e4fd938mr344929f8f.32.1766080407798; Thu, 18 Dec 2025
 09:53:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218130629.365398-1-liujing40@xiaomi.com> <20251218130629.365398-3-liujing40@xiaomi.com>
In-Reply-To: <20251218130629.365398-3-liujing40@xiaomi.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Dec 2025 09:53:16 -0800
X-Gm-Features: AQt7F2oSqG7x_vqvuybNtyAKy7w5rBZ7eTtVpgQJA4bUa29xSg3uRmIhaZ5DSXM
Message-ID: <CAADnVQKC312JbOhjQZmMN-Me2V0GQ9qxoHeQkF+=PbYk0zc9KA@mail.gmail.com>
Subject: Re: [PATCH 2/2] bpf: Implement kretprobe fallback for kprobe multi link
To: liujing40 <liujing.root@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, liujing40@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 5:07=E2=80=AFAM liujing40 <liujing.root@gmail.com> =
wrote:
>
> When fprobe is not available, provide a fallback implementation of
> kprobe_multi using the traditional kretprobe API.
>
> Uses kretprobe's entry_handler and handler callbacks to simulate fprobe's
> entry/exit functionality.
>
> Signed-off-by: Jing Liu <liujing40@xiaomi.com>
> ---
>  kernel/trace/bpf_trace.c | 307 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 295 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 1fd07c10378f..426a1c627508 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2274,12 +2274,44 @@ struct bpf_session_run_ctx {
>         void *data;
>  };
>
> -#ifdef CONFIG_FPROBE
> +#if defined(CONFIG_FPROBE) || defined(CONFIG_KRETPROBES)
> +#ifndef CONFIG_FPROBE
> +struct bpf_kprobe {
> +       struct bpf_kprobe_multi_link *link;
> +       u64 cookie;
> +       struct kretprobe rp;
> +};
> +
> +static void bpf_kprobe_unregister(struct bpf_kprobe *kps, u32 cnt)
> +{
> +       for (int i =3D 0; i < cnt; i++)
> +               unregister_kretprobe(&kps[i].rp);
> +}

Nack.
This is not a good idea.
unregister_kretprobe() calls synchronize_rcu().
So the above loop will cause soft lockups for sure.

pw-bot: cr

