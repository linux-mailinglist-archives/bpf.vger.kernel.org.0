Return-Path: <bpf+bounces-60831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1ADADDAA8
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 19:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03F01891DB5
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840D285050;
	Tue, 17 Jun 2025 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bie/GOkc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794A1AAA1B
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181109; cv=none; b=oHUvoL/SGn6JWJqrdqW/cJxaQ2XaIa0+tmcqcxJ47qRNxkoFx5F6QKq/ul/xAvGlgL19yosYXEU8bEeUyKtkFtTCCZb1N090VeKcHbhE0H1qwesG36pV/ovfQZwFRikqXSqMd2sKuTA0+lsXDXPNpqeurzsxUC7bf2/2EJkA5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181109; c=relaxed/simple;
	bh=RArx4V7WSIrrH3OG3Ehv5TXxGDY9taw9BItBO82bT8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAlae+JF335B0BVBbQqmnT+y4XbAzi8HF3kwVuSRGyxtBpgEj6p98DxeeB2OIFdbKbZYpLcjuWmsy9b5QpDsGmU35Hz/ZkGuonvs3BkxbStINCcQfPv6MRRsH4SZdV20th0U/LwzvQMer1G/HvThu3NoZ3VFuhZZiWxP7gtYHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bie/GOkc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45300c82c1cso20054395e9.3
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750181106; x=1750785906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8aW6vJkmnE2PdvsYw4MhUR1fdDgkOQWfCj3JasNBBo=;
        b=bie/GOkcO/8ok5m80/OLdhp4VfWf0m9kIM9unMz2bLVd0z/SUbnoAJfTiFUkrNdyxX
         fjs3nFlKfaNcypbs3S0cCVgv+E8x4FSyi06tTOo7+LNu2yoKXVZVDrxQjHnATYJW4Sd8
         QoJtwsEX6iPqpAz2c+cJD/r1pkVmXW9laSo+r4UePHyEJ0CZpd1lNykTzYkl2M+Ggefg
         H7AT83q8IvSpscTcE0D9ZtMz8P0y/DDP9cUK4suRawP6PY+NIDN7uSidQ1jAz9F6Nv0j
         gTvVzqrQdwZ3Y5CIHGZYt+XOvMZD9D0l7Zxk1nalVxIB+NIIDdKCzxS7N2MU8aOuU3tJ
         e2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750181106; x=1750785906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8aW6vJkmnE2PdvsYw4MhUR1fdDgkOQWfCj3JasNBBo=;
        b=Rwt9jaq+JffpjYV/4dyXtkzRPsHVQ7IALIe1koU6PXpFwSQnhdpHMiMbbXvlmKsfYw
         Y4ucfnf3gIInJ+uu0uCimRdTkpsZkJTrrQ7AHhu1fd85ImFglwUjunMyuMKZYaUH9tMr
         3EkT6tanSZ31/akI5qNwffB3iChDEs14iMmshtPpRuBBGJwWByCQPj0TGkwhQlazP0sq
         J4yp/RDINmI0TyXaFbUAHfNgnxicJXYQyP82KuonJjY6bcyyvrq/lDp1xg2qBddhsHD7
         V012ndecFH7S6hjq5735LdIdfn+gZ/vtAMF/JgXn2lDQj03Fu912Dw+XinnOZh5lJHie
         8qHQ==
X-Gm-Message-State: AOJu0YwuZVUF1UZ7LXlFlh2K1jFS8ABaMoaT/pZN34YZXV0YFxu59oDC
	aK8ggSRpWsBcVsdZ8/ZFDk7C3fPsiEvUOTSjyvo0BVJyoqJdSR+OXbBjSANNfDAgPddHYvUuPpt
	zBNng/cmOMkcSOE8LUA5CWcbQ4r3WIQt24Fcj
X-Gm-Gg: ASbGncvoia0OS2VCA6pwdJSy55uQXnAK3UEGWj03AgnDpgFCe+Nu6eKAcq9a6c7oGky
	c9iwlzFNcbYPcEtPOOEJ1xT54ZbFzY6ynsAcvq8onf0gYez833rS7YQG07EJtLAteqQz5OPMfJX
	c7Z0buCod/HxrtTZLcP6/6BJI3nfBfzf+qAyQh99yvbF5cvlfRB49knXqhet0=
X-Google-Smtp-Source: AGHT+IG8E9Z6AbRpqfpHRThZH5uWRREeo4qevbGs/JEIbhH/icnhY7B6gHQWwwHNRFkOnfXGH663iDxDOfxzNFB5X5Q=
X-Received: by 2002:a05:6000:2503:b0:3a5:14e1:d9ec with SMTP id
 ffacd0b85a97d-3a572e998ebmr12103516f8f.51.1750181105550; Tue, 17 Jun 2025
 10:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617044956.2686668-1-yonghong.song@linux.dev>
In-Reply-To: <20250617044956.2686668-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Jun 2025 10:24:54 -0700
X-Gm-Features: Ac12FXyEIodNH-6jkt16Tg7MOuTz4GktsrohmqsNCP1gkpfms9QZO-wWp0Msl8g
Message-ID: <CAADnVQKiTOst_qaN2azvg9JXqQPJ8SqE7LMPTWve6Omo=ZhLNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix RELEASE build failure with gcc14
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 9:50=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> With gcc14, when building with RELEASE=3D1, I hit four below compilation
> failure:
>
> Error 1:
>   In file included from test_loader.c:6:
>   test_loader.c: In function =E2=80=98run_subtest=E2=80=99: test_progs.h:=
194:17:
>       error: =E2=80=98retval=E2=80=99 may be used uninitialized in this f=
unction
>    [-Werror=3Dmaybe-uninitialized]
>     194 |                 fprintf(stdout, ##format);           \
>         |                 ^~~~~~~
>   test_loader.c:958:13: note: =E2=80=98retval=E2=80=99 was declared here
>     958 |         int retval, err, i;
>         |             ^~~~~~
>
>   The uninitialized var 'retval' actaully could cause incorrect result.

actually

> Error 2:
>   In function =E2=80=98test_fd_array_cnt=E2=80=99:
>   prog_tests/fd_array.c:71:14: error: =E2=80=98btf_id=E2=80=99 may be use=
d uninitialized in this
>       function [-Werror=3Dmaybe-uninitialized]
>      71 |         fd =3D bpf_btf_get_fd_by_id(id);
>         |              ^~~~~~~~~~~~~~~~~~~~~~~~
>   prog_tests/fd_array.c:302:15: note: =E2=80=98btf_id=E2=80=99 was declar=
ed here
>     302 |         __u32 btf_id;
>         |               ^~~~~~
>
>   Changing ASSERT_GE to ASSERT_EQ can fix the compilation error. Otherwis=
e,
>   there is no functionality change.
>
> Error 3:
>   prog_tests/tailcalls.c: In function =E2=80=98test_tailcall_hierarchy_co=
unt=E2=80=99:
>   prog_tests/tailcalls.c:1402:23: error: =E2=80=98fentry_data_fd=E2=80=99=
 may be used uninitialized
>       in this function [-Werror=3Dmaybe-uninitialized]
>      1402 |                 err =3D bpf_map_lookup_elem(fentry_data_fd, &=
i, &val);
>           |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>
>   The code is correct. The change intends to slient gcc errors.

to silence.

Fixed the typos while applying.
Pls use spell check.

