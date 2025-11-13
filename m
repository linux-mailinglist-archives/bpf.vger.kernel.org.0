Return-Path: <bpf+bounces-74338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A68AC5535D
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 02:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CABBF4EAC07
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 01:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCB41A9F94;
	Thu, 13 Nov 2025 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5piQNsc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A5128816
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995662; cv=none; b=EGHjyTvwbwoKO2a72rdPKqV+NZfnseybqODmrskdTxXh9+SCRrXH+gSw8NgZhY0Kce1vH7FSWbBh0FtrTRbQvFmniY17648F//raLTzADKZpJrqWRoFzDdH0vhx8IIpUwnBuoHKU0lDYmReQdc13Iz91WI9iod7qKkoQwC/hpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995662; c=relaxed/simple;
	bh=/nIg0wei2g7O/QWLtDenj+p/Aw9wBkkLlBKEe3xKC68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uoq2bp/olyoCnId+1YsjXey/Tn/Y7ig7ZA35GkkjGW79v/5XZNN0z5am3SzbAegmvdcVT+E5v9bqnIjCtAEL4O+MzHN01jZmLTQRnT8G9CJgtFDLRcdd+QUcQXfIUu3sGs9VGvtNg88YPyQLZlyg78eHb2L6moJ/9xQqCCF9ekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5piQNsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F323C19425
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 01:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762995662;
	bh=/nIg0wei2g7O/QWLtDenj+p/Aw9wBkkLlBKEe3xKC68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d5piQNscmDok7YNBvFowQhkKhFrfMwLDWtH8ZAYBxryG+Mh2fDKnGnXkuvLu7KnIS
	 Qmiak2q+SDgSHl4u13PUcmYxhHKb4N3rzZPKNtwf42jrR9Ab8lJiIFKlnzpf7xm3qv
	 rSiI4yaTY1Vd7iGVimY3T7geWgD9NrQStLhZRPhaoBnlsOH+3L4+1jsuCyOJ404dSC
	 BTJuqS5fYpuiaWsRr2Z51d7jgxp7sU6ug7Hm3meHYZG8bZgQ4SmWysCkDuGO7d69mP
	 AEvLQrdL8QXbISFF7kL87rS9VVcOKIdjarpQ8s5L28ImZ2m2wFUR48BgrXh0BZkmS7
	 P8ma2YA39ASSQ==
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-948614ceac0so13626939f.0
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 17:01:02 -0800 (PST)
X-Gm-Message-State: AOJu0Yw6tnSR/oBUuZkHb6d5U2aJUxUd0ljjJpOkh0781cb0R7UaDUQK
	1cyu9QXo3wLGA4nYMyT1+GLq4B2P9iFGoIrGxTl+Jj4mLrMADiflt71pss2qNaH0dmnEEG3UIVZ
	3bMf22WhnVfAFOEWoUWzMjJa0RXqMuWc=
X-Google-Smtp-Source: AGHT+IEnCWLUQHH5qjQwYBsg6spaBQF1y5IC8NDcIuW/yPfXcguHbUZ6wo7WV0mfl1eiMcQrWpOfYl864olA66Yjud0=
X-Received: by 2002:a05:6e02:11:b0:433:74c1:2edb with SMTP id
 e9e14a558f8ab-43473d4e71cmr82626275ab.14.1762995661169; Wed, 12 Nov 2025
 17:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112083153.3125631-1-mattbobrowski@google.com>
In-Reply-To: <20251112083153.3125631-1-mattbobrowski@google.com>
From: Song Liu <song@kernel.org>
Date: Wed, 12 Nov 2025 17:00:50 -0800
X-Gmail-Original-Message-ID: <CAHzjS_s=+qgkt0RRFqvVORhWBt8jsFS8RDy4Kq1Vwr8fPRzfag@mail.gmail.com>
X-Gm-Features: AWmQ_bntiQyP229yc4GvdnzLVfANQrHtknjBqD3qgST9Ic7NsODEXeSkvxeAHt0
Message-ID: <CAHzjS_s=+qgkt0RRFqvVORhWBt8jsFS8RDy4Kq1Vwr8fPRzfag@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: retry bpf_map_update_elem() when
 E2BIG is returned
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 12:32=E2=80=AFAM Matt Bobrowski
<mattbobrowski@google.com> wrote:
>
> Executing the test_maps binary on platforms with extremely high core
> counts may cause intermittent assertion failures in
> test_update_delete() (called via test_map_parallel()). This can occur
> because bpf_map_update_elem() under some circumstances (specifically
> in this case while performing bpf_map_update_elem() with BPF_NOEXIST
> on a BPF_MAP_TYPE_HASH with its map_flags set to BPF_F_NO_PREALLOC)
> can return an E2BIG error code i.e.
>
> error -7 7
> tools/testing/selftests/bpf/test_maps.c:#: void test_update_delete(unsign=
ed int, void *): Assertion `err =3D=3D 0' failed.
> tools/testing/selftests/bpf/test_maps.c:#: void
> __run_parallel(unsigned int, void (*)(unsigned int, void *), void *): Ass=
ertion `status =3D=3D 0' failed.
>
> As it turns out, is_map_full() which is called from alloc_htab_elem()
> can take on a conservative approach when htab->use_percpu_counter is
> true (which is the case here because the percpu_counter is used when a
> BPF_MAP_TYPE_HASH is created with its map_flags set to
> BPF_F_NO_PREALLOC). This conservative approach approach prioritizes

s/approach approach/approach

AFAICT checkpatch.pl also warns double "approach", as well as line exceed
75 character above.

> preventing over-allocation and potential issues that could arise from
> possibly exceeding htab->map.max_entries in highly concurrent
> environments, even if it means slightly under-utilizing the htab map's
> capacity.
>
> Given that bpf_map_update_elem() from test_update_delete() can return
> E2BIG, update can_retry() such that it also accounts for the E2BIG
> error code (specifically only when running with map_flags being set to
> BPF_F_NO_PREALLOC). The retry loop will allow the global count
> belonging to the percpu_counter to become synchronized and better
> reflect the current htab map's capacity.
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Other than the nitpick above, this looks good to me.

Acked-by: Song Liu <song@kernel.org>


> ---
>  tools/testing/selftests/bpf/test_maps.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/self=
tests/bpf/test_maps.c
> index 3fae9ce46ca9..ccc5acd55ff9 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -1399,7 +1399,8 @@ static void test_map_stress(void)
>  static bool can_retry(int err)
>  {
>         return (err =3D=3D EAGAIN || err =3D=3D EBUSY ||
> -               (err =3D=3D ENOMEM && map_opts.map_flags =3D=3D BPF_F_NO_=
PREALLOC));
> +               ((err =3D=3D ENOMEM || err =3D=3D E2BIG) &&
> +                map_opts.map_flags =3D=3D BPF_F_NO_PREALLOC));
>  }
>
>  int map_update_retriable(int map_fd, const void *key, const void *value,=
 int flags, int attempts,
> --
> 2.51.2.1041.gc1ab5b90ca-goog
>

