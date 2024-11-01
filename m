Return-Path: <bpf+bounces-43772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789C89B98B8
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E101281569
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F2F1CFEA4;
	Fri,  1 Nov 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE5GU/jV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA421C7601
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489699; cv=none; b=Rlq5LQv5KdyHI7Cr3lcSVNYHkQFTzaKpf0vTba99WYopGVG7mm2sXsBR4wGjFym3rzbV8xruFvop4/Io+stRritppa7dm45L3Dc1Kr/ZiCF2LbQg2DBZnCJFgsLbej3LZgJ8DIjEcrZNlnAOVa5mB1eqkFAQitl75vVl5znBMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489699; c=relaxed/simple;
	bh=49FoM2b6OeQRN9jZ1H+Z1nwQ8daIN9GFOypyz4+icds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTkLUVxaPLXzG+yxgEnBt0zmlWQ4E6t3Gnexk4zvj98XQ2HE6KbroDHBDU9G+wJkdk/CM9ChXtx0lhzFOOiEr6AbsPlXHO7lTJC79T6FEfFfHqjOea9jIQRHidy10vOFFxG6XtMuJk/e2tIQ9AU34QlHhmR27dCyD7k5RTd/cD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE5GU/jV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso1638238a12.1
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730489697; x=1731094497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orAqKSd/FUmSdkuJlYjeD16QyluiIDwxYJbmaUp9+9Y=;
        b=gE5GU/jVj+ZzzFIRuKk+8ZhaJF8j6bESkFFkxRQah49z/qYU+9dNNhQMoEs9glSqIr
         u/jyctN+tw3RTZjKGb2tiu+9OYq5pk4s3TumnVXbv+ZcHnKIQwx/aSsD/yFAKtJS/rno
         aUVdENdIj/l77wPfsYE4cxFOzBmBkLI5Mj/CfHQSB4QRbnO1NyLt8qA5bnYgxjQ9kVrF
         QGTg3SEybpLrvCd0WyxbmO+hfmOcTv92nuVvFiL9hdUe8yiVreXl9Y2UoumaBNY2xqyH
         FWwX/1jxmtHGI3tLCiNL3HZQd+rslPSUa9i3fDieSZamQ7yGna+2ln9gSY4j2SlaEA29
         tPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489697; x=1731094497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orAqKSd/FUmSdkuJlYjeD16QyluiIDwxYJbmaUp9+9Y=;
        b=gL9x/yxDoGDh9CaqqxaIJEf8OQmF1xIKi4LPhVl3zFovotnVIYcDw0h3SVhFHsNlD0
         wLcIweRLlRoO03ZwuObf1KMQBPG6WJu4tMCP7PBzh3f3TktHMVhj1TKdPs4Y7Yl3HkTs
         lj7E4sCxutHfm8AOx4cLbdrxCUXEHQRzzrwaN4/Q/0veAoenWOFLo3cn+usWm9+pHOxP
         KsHp3tlqioBlNUQfMclmpOh60i6z4gWf1lH1i0ROgH4PzcvdTnrbwUiP7apztHMYNsKy
         65FtXuS1saQIley0BlsYUZlWJvwbt08iBh6uaKUzr62/17RpzbELgPngifmpD8RD6+L1
         Cs1A==
X-Gm-Message-State: AOJu0Yxl9/h7XayGxLZf1EexJuy90WBFjaOZBCBkf7I26CM72vNkoP37
	9hUrHHK03e3X9X10UX4sQNblSgprKA6KMjCJhkK7Av3EmAsL9z7Xs1hOFTUvfxi1boUiS/p0Gzj
	sFvpdsqOAWVlqNEI9+w8p+VWPbrs=
X-Google-Smtp-Source: AGHT+IFA0GOgp+iCFrHIIJ+zhyCxNtOdgLTf3/Jsz8MISLgdX7SKY4ISwNOLJDkm5ufpoQj+My1DTUXNeZ8cVoCOANA=
X-Received: by 2002:a17:90b:2e42:b0:2e0:7580:6853 with SMTP id
 98e67ed59e1d1-2e93e0fab5amr10859482a91.17.1730489697378; Fri, 01 Nov 2024
 12:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730449390.git.vmalik@redhat.com> <6cb7d34d0ff257deaf5bb818ac4bce3c95994d29.1730449390.git.vmalik@redhat.com>
In-Reply-To: <6cb7d34d0ff257deaf5bb818ac4bce3c95994d29.1730449390.git.vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:34:45 -0700
Message-ID: <CAEf4BzZ_kB3YaeA5c2cB7dyiaJna4nGBtww9n0fS_b1d-ZtMGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] selftests/bpf: Allow building with extra flags
To: Viktor Malik <vmalik@redhat.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:29=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wro=
te:
>
> In order to specify extra compilation or linking flags to BPF selftests,
> it is possible to set EXTRA_CFLAGS and EXTRA_LDFLAGS from the command
> line. The problem is that they are not propagated to sub-make calls
> (runqslower, bpftool, libbpf) and in the better case are not applied, in
> the worse case cause the entire build fail.
>
> Propagate EXTRA_CFLAGS and EXTRA_LDFLAGS to the sub-makes.
>
> This, for instance, allows to build selftests as PIE with
>
>     $ make EXTRA_CFLAGS=3D'-fPIE' EXTRA_LDFLAGS=3D'-pie'
>
> Without this change, the command would fail because libbpf.a would not
> be built with -fPIE and other PIE binaries would not link against it.
>
> The only problem is that we have to explicitly provide empty
> EXTRA_CFLAGS=3D'' and EXTRA_LDFLAGS=3D'' to the builds of kernel modules =
as
> we don't want to build modules with flags used for userspace (the above
> example would fail as kernel doesn't support PIE).
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 34 +++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>

Ok, so this will conflict with Toke's [0]. Who should go first? :)

And given you guys touch these more obscure parts of BPF selftests
Makefile, I'd really appreciate it if you can help reviewing them for
each other :)


  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20241031-bpf-sel=
ftests-mod-compile-v1-1-1a63af2385f1@redhat.com/

[...]

