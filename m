Return-Path: <bpf+bounces-61780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D58DAEC225
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 23:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF57E7A3599
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BA528A1D5;
	Fri, 27 Jun 2025 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U77Me/W8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB63221DA8
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751060321; cv=none; b=L+ox3bkU2/HwoqXJ1ijAoig49PeDAZhJSP7ht5WN/m9h2KjZcoiGYyND1I+Uq76lRbCuXEoK+STeifrUsGte8rOI6IjV2XOWOIdQmxeCl1OrgAj65ywAUQ7zFgxYJVSSXdoxJoYBPvzcR0uzHjmO11ZBNF+cNnl9oQOIZD8whus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751060321; c=relaxed/simple;
	bh=k1qMBhe9RaJlWIjJBBoVi8g9jFF9668NxTeuqrl4XdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krs0/G0Fsnd0WfX2qLmpA06BmAiGekWRoyRa42Ot2GrrKWCTu/nEk77BWodxaYID5zinpByhuNqdRN8uAN6VLGtPdKGfTHpk7kQm+hyak64DX7pfubLrnJkz4TW4Aw7CPuZzBCy63OFOn1zGuc6Bxk5QQlaJxHmhDClFLiAOsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U77Me/W8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4538a2fc7ffso17105075e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 14:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751060316; x=1751665116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNX/G3pAeuNTXcS8Lz2VryNOk8DjuDBHll5YtVkpVbg=;
        b=U77Me/W8A6li+kl24VbhzWEgPUKOU4jWphsN7Bxw6B6FjWXl4dmTFALaQz68ScpESS
         FI5vNz8TzewmT/ukVMQ5mCHQXs9OHVA7Z+JgX5Z9Uk6lImHMjZBHai7mGlDYdVOqwZ0B
         IhTjxV4rSZK8AIYG3PHvLwqRCzmA7roaD1M3oMHGiBlMAy4bRc2PjWdbQyLe87ijJShx
         WDps8hyy0frVyw+OLyKkYuNTrhKy0F2wqt/DeCWNXlLg6++to5P+d6wB8384znuPr9Yx
         UVrHop1YfHTxknoDHyaNk6niKGby6U6pKQDgY2prTmo9ivrhKUTVACFVNZvGMzOZTHmI
         DicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751060316; x=1751665116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNX/G3pAeuNTXcS8Lz2VryNOk8DjuDBHll5YtVkpVbg=;
        b=tXDZAGyCNV9d7r2kgt+3C9Ew37JgShWrYiLYoXkH2abClyRHcCqfAw3XnDZq3vaYKs
         wi1+MsFv9Ucz1BmsJHYGiFrBqQzTxxsnFm/LvaVfhNBz2wOPTN5RJrbPi2qTLX4xgeh1
         xge+b8ZfxHYOUxH5Woavglzz73FN76xYAtAneQ3SEIQVjdZVmge9Z/T6V4svBTx6IIni
         lezInfE4Be5vFo5BCuaZHnRC+s073EAla77bE5maYyS57LXhs6fbGb+J6NQ2/doLYrXm
         bFDj58JwZ+8YNL4+i/anOiyolH1kQ2CbRrJNlg+mEJSEbgCqIhFi3pqLzaJkE6X2GMkJ
         JVYA==
X-Forwarded-Encrypted: i=1; AJvYcCWwf/mtAPD1FbERTUCpcytjK/kJq0K3u7csmZPtxl/L+ohjaiyyS9e+xqLR6DzCB9QWjXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmgmWmBpBY/ttSD0PQ5dutOpNcqtR36RqLpHu409vTWdYcXvy
	gcRNS9qrjn3g0F5wp2Vvvu9QBJqcpVXI2cS64CSLrhe7BdxqiysfJGa8C+mhxYJ5uxQM8U6gdhR
	/nTa8da6piRm4rWJ41IbI2/I93v6pq34=
X-Gm-Gg: ASbGncsOKNMQOdfbZZPLyj+M1D/CwapI7lNCr9b/993byfkzhDx0eYoGeOU2ZSzq4p7
	OgCeKGl5I4JlQ6mnQVsujhKmSh1/hirlr/a2PRFRyKXMG1ZX8+fg89x9Zx9H0NLFwK3pZ89UE4M
	IiIxGuccURIv+kIQ7V3CNNNGufCXtQs2M79CaP4txJKatW1AMYxGqaJoCxQjhlYcz3Q+9o0Tib
X-Google-Smtp-Source: AGHT+IHtO17qalFBaOAOI73T8nS4DhX8NUkNlzI152v/TvOpcVUpdFCOP854mB6IH94J6+zywydrmLWdInwtfsx4yr8=
X-Received: by 2002:a05:6000:2c0d:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3a98bb09d91mr3624024f8f.19.1751060316086; Fri, 27 Jun 2025
 14:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627191221.765921-1-song@kernel.org> <839d4696-fad6-499b-a156-994951ea75c7@linux.dev>
 <CAADnVQL5vQ9e5TMYfUafkzEUU+akgVME=OFtbATeTkL-G8aKLQ@mail.gmail.com> <11bd7899-9ffe-48fc-8d0b-94ed3b9532ab@linux.dev>
In-Reply-To: <11bd7899-9ffe-48fc-8d0b-94ed3b9532ab@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Jun 2025 14:38:24 -0700
X-Gm-Features: Ac12FXxkI6Dj_rMvTiItDuIw7buRZS_vYApqOS5hW6T0aoPVmgpgeGSa7we6xxg
Message-ID: <CAADnVQ++H6qOvU7tYvcxh8NW-kshUPhTCuc=4w4JCZCeu_zcdA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix cgroup_xattr/read_cgroupfs_xattr
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 2:36=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 6/27/25 2:34 PM, Alexei Starovoitov wrote:
> > On Fri, Jun 27, 2025 at 2:19=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> On 6/27/25 12:12 PM, Song Liu wrote:
> >>> cgroup_xattr/read_cgroupfs_xattr has two issues:
> >>>
> >>> 1. cgroup_xattr/read_cgroupfs_xattr messes up lo without creating a n=
etns
> >>>      first. This causes issue with other tests.
> >>>
> >>>      Fix this by using a different hook (lsm.s/file_open) and not mes=
sing
> >>>      with lo.
> >>>
> >>> 2. cgroup_xattr/read_cgroupfs_xattr sets up cgroups without proper
> >>>      mount namespaces.
> >>>
> >>>      Fix this by using the existing cgroup helpers. A new helper
> >>>      set_cgroup_xattr() is added to set xattr on cgroup files.
> >>>
> >>> Fixes: f4fba2d6d282 ("selftests/bpf: Add tests for bpf_cgroup_read_xa=
ttr")
> >>> Reported-by: Alexei Starovoitov <ast@kernel.org>
> >>> Closes: https://lore.kernel.org/bpf/CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWq=
SDe4tzcGAnehFWA9Sw@mail.gmail.com/
> >>> Signed-off-by: Song Liu <song@kernel.org>
> >>>
> >>> ---
> >>> Changes v1 =3D> v2:
> >>> 1. Add the second fix above.
> >>>
> >>> v1: https://lore.kernel.org/bpf/20250627165831.2979022-1-song@kernel.=
org/
> >>> ---
> >>>    tools/testing/selftests/bpf/cgroup_helpers.c  |  21 ++++
> >>>    tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +
> >>>    .../selftests/bpf/prog_tests/cgroup_xattr.c   | 117 ++++----------=
----
> >>>    .../selftests/bpf/progs/read_cgroupfs_xattr.c |   4 +-
> >>>    4 files changed, 49 insertions(+), 97 deletions(-)
> >>
> >> Hi Song.
> >>
> >> I tried this patch on BPF CI, and it appears it fixes the hanging
> >> failure we've been seeing today on bpf-next and netdev.
> >> I am going to add it to ci/diffs.
> >
> > Applied to bpf-next already.
>
> CI patches apply to all base branches. My understanding is, it's needed
> at least for netdev too.

How is that possible?

The offending commit is only in /master and in /for-next branches,
while /for-next is there for linux-next only.

