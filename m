Return-Path: <bpf+bounces-49890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A6A2005A
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CF23A44F1
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 22:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF63D1DC184;
	Mon, 27 Jan 2025 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJnAPA9q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801D1DB15F;
	Mon, 27 Jan 2025 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016172; cv=none; b=YqJaaM7291HD930TExZlj6Ds5fRX4OhHFlZ56HQpmDFxH4UT2ONE4e839ozoJZOdvoI+zZyZQr/3iGGxo7ZFPxkSKJMDFZx6VMQ4E3mVTtwmrbmIID7o9PtweV8jFC3DIKO/mkKPt4F6GUTxV2sLEY46hfSJkFTkcAEHcGsuB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016172; c=relaxed/simple;
	bh=bcMf/BMAhL0+dHWHyyOtnRBVVapFIqiZ/rdai4KvpQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TX8/lgHbXfizNrWel4hqeBbDnFk3J8VbfKdKqFnLBJ21657llM0i+Zoqz5Lchect84vaY5KTqOZXwWgcMn99P1f/OAJQX6KIs6gfhWo1euyGlelcxXROzbjNc7mc6puXs1X8pFTsKvCEBHD+nAkwYys73s+9RF3g068sSaZ/9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJnAPA9q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so51215885e9.3;
        Mon, 27 Jan 2025 14:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738016168; x=1738620968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvruYK1VJmrIiqq8wh+CKCSO4dGMWWNZU7SBswWzJPE=;
        b=gJnAPA9q3rCdCgzSkjWx0ox8+cy+QwK+aUL/1SfYMWd8wuO4+aZJLKjP96ecT/U2QH
         yLH6WIzJNGOWDIReSgrqE73sN2BXllbJyG9Wacobt2LuKZiN0RLBv38Dv6Im/+26Z+SV
         5C3gNsd4cnnWbNO7x6+4/HJswuR383CXpEZfJCmnNxIxTtqcoe9w93jp5ZJs6plvOM6o
         AvtUgPrZ1nYItg9org5ncZgLxXK2u/1/DqrISEcNR/YG5d7p/D9h/GtzMc572fMXsrLy
         MsWINeWUh7Bppfvkbqut3d46p+8pRzzp04WLwF9Wp3Yznbd7TRbIY6JVQxuw95gVMRWx
         LK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738016168; x=1738620968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvruYK1VJmrIiqq8wh+CKCSO4dGMWWNZU7SBswWzJPE=;
        b=wAahS5+SN7F1aR3+gcQFNRfBNu7Y4YOmu+iqe1vop216fbXECxpt6NqW9N7pD0ZhhG
         Qd6D8tEIi/7HTMfF/UVzjMZ9Vy2ZdAHbgNYWVvOW8mC3vb2GisUag7NTaTRMiZgSacXb
         QW3HfETRdfbRwpVU5fU5jDjrRBEHX0x2f++GpSbqbuqTCCCojYsyl4LIl4avjVzwBuMq
         9oKwETyMF+uldD4BMZ1i6hO2Lc+bpmvqO3y9/WkeQoPiW8wnNRwfJmlYfph6Uj70c4RP
         UcQ8zOfhPWPrH4BPU8DHVX4/JwMya2pxrZ3jOUiV4itVUv/3GIvs/fLB6xtDPpqK0sHv
         TI/A==
X-Forwarded-Encrypted: i=1; AJvYcCWEXY3p8aeMPshJd8HyxFDArG0jQbUK5BbRJk0BjBNtBHdoVzFbkvGdpxUvPirH2YLS8Zs=@vger.kernel.org, AJvYcCWoiN0Ai/ltDhlGBisdVoOTQ2gavWFFtmSzOVBH78NNP+qDs9VdCyeshiX8Bcpb6Rm+PVempAW0pFOYS2Q4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+4DuV5K/bwYZ4VNwbNnN0AR7D/juh443yG03ZKqmhCGkfsoCv
	UVCNcqp2olc6n65N6VFcJm26utxU2dwJYmxyhJmXsWfdaQQOCZfIxkKhHweKuS1CG6dw7O+jYa+
	AFypW4tSFokKnxp+E4ktOZ4ILotE=
X-Gm-Gg: ASbGncvSlrYYH4ixdv2pNI72iRozEdQwd6DxPPi04Pjdu0cPW08kL62YIr9A0l+T33c
	oHNSIfSfIi2V98+xX57ZAX5I+zVKuaLLDCJLXYC0JPZ9qgz1Vkpm8lBq7aMMbQlI/peT0OvuDP3
	vFzT70q8vtYPEq/gHgmg==
X-Google-Smtp-Source: AGHT+IFLP4vkLMGI1zreOq8nBJEkXFExvKGYJbkVR9sRC3nWaQ/qgGHmcHBd8y3azea6W6anNevVPAD3MNJs6e580WU=
X-Received: by 2002:a05:6000:4e5:b0:38a:8906:6b66 with SMTP id
 ffacd0b85a97d-38bf58e80bemr36243893f8f.38.1738016167796; Mon, 27 Jan 2025
 14:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221061018.37717-1-wuyun.abel@bytedance.com>
 <02c69185-1477-485c-af4f-a46f7aadadab@linux.dev> <7139ed64-55be-4b70-a03f-8b2414fc93d3@bytedance.com>
In-Reply-To: <7139ed64-55be-4b70-a03f-8b2414fc93d3@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Jan 2025 14:15:56 -0800
X-Gm-Features: AWEUYZk_-sJBuoesXMQRdOyEpWnZoTOGnfsUIYt7jqJSmAOIQaNQvRsQyaZ4KRo
Message-ID: <CAADnVQ+ws4c=G02HjR7Oww_cSuoVFfkWMjP0BbnUrrDgo6tywQ@mail.gmail.com>
Subject: Re: Re: [PATCH bpf v2] bpf: Fix deadlock when freeing cgroup storage
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, 
	"open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 1:31=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> On 1/25/25 4:20 AM, Martin KaFai Lau Wrote:
> > On 12/20/24 10:10 PM, Abel Wu wrote:
> >> The following commit
> >> bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[=
get|delete]")
> >> first introduced deadlock prevention for fentry/fexit programs attachi=
ng
> >> on bpf_task_storage helpers. That commit also employed the logic in ma=
p
> >> free path in its v6 version.
> >>
> >> Later bpf_cgrp_storage was first introduced in
> >> c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-a=
ttached bpf progs")
> >> which faces the same issue as bpf_task_storage, instead of its busy
> >> counter, NULL was passed to bpf_local_storage_map_free() which opened
> >> a window to cause deadlock:
> >>
> >>     <TASK>
> >>         (acquiring local_storage->lock)
> >>     _raw_spin_lock_irqsave+0x3d/0x50
> >>     bpf_local_storage_update+0xd1/0x460
> >>     bpf_cgrp_storage_get+0x109/0x130
> >>     bpf_prog_a4d4a370ba857314_cgrp_ptr+0x139/0x170
> >>     ? __bpf_prog_enter_recur+0x16/0x80
> >>     bpf_trampoline_6442485186+0x43/0xa4
> >>     cgroup_storage_ptr+0x9/0x20
> >>         (holding local_storage->lock)
> >>     bpf_selem_unlink_storage_nolock.constprop.0+0x135/0x160
> >>     bpf_selem_unlink_storage+0x6f/0x110
> >>     bpf_local_storage_map_free+0xa2/0x110
> >>     bpf_map_free_deferred+0x5b/0x90
> >>     process_one_work+0x17c/0x390
> >>     worker_thread+0x251/0x360
> >>     kthread+0xd2/0x100
> >>     ret_from_fork+0x34/0x50
> >>     ret_from_fork_asm+0x1a/0x30
> >>     </TASK>
> >>
> >> Progs:
> >>   - A: SEC("fentry/cgroup_storage_ptr")
> >
> > The v1 thread has suggested using notrace in a few functions. I didn't =
see any counterarguments that wouldn't be sufficient.
> >
> > imo, that should be a better option instead of having more unnecessary =
failures in all other normal use cases which will not be interested in trac=
ing cgroup_storage_ptr().

Martin,

task_storage_map_free() is doing this busy inc/dec already,
in that sense doing the same in cgroup_storage_map_free() fits.

fentry/cgroup_storage_ptr use case is certainly convoluted.

I don't buy that adding notrace or doing CFALGS_REMOVE_
will hurt observability,
but this patch seems ok.

wdyt?

