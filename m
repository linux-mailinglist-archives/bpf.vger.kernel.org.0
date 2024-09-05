Return-Path: <bpf+bounces-38943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECA096CB88
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 02:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BE31F2060F
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 00:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11851103;
	Thu,  5 Sep 2024 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb6P3U53"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA281FA4;
	Thu,  5 Sep 2024 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494621; cv=none; b=TkFXjoGcB32geUHm7sWpG5DWr/EucLB2CHdKYMHKBjcLWIvgnKp4LeDDt++CrMU3KskHw91pjuiqe0QfYO74hIfRbGS3e7oS7NfuOT1BHrbWuO3YUovwBPXuaCjdusGRJ+WKK4OqoCexpLq4qgcxjn/n+IvU2ZvjrN8hUl/2Zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494621; c=relaxed/simple;
	bh=13b2C7ucUsrKz7sct3xMe1xJ211tTB0P6x594ncA9NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beX+xR0KWnZl8GPiVdYi0YRSf+Fb1356P+cvvmXvmCy6mkD6GBoBg4s2XwE3sOOiSftV0uRXth7mCC4lVwxDKfCY3HJvaJdzBRKN0hwzny61D9dR7OyvvIEn7mXFz1FMOP44f3bCm0dHFdzQL51hSqXfqCPaidQm7kQB/WtKWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb6P3U53; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d88edf1340so108695a91.1;
        Wed, 04 Sep 2024 17:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725494619; x=1726099419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Pp5XlYCZbKVyNu+taRdigNsqhXnKoDENO/bwZGJUkU=;
        b=Nb6P3U53vdhHptIWv4KGZmP/kmKtf1ekdJSqyDrQ1oa65hrpL9GR29iI+AHJJ+ZIYv
         hHxeJeB5bE8GwUX0/mCu1EwUFBa5xqA4KhLZSSlm+hVMYZE8aO2whSpLxgOfddSVZ7iD
         OI1FX4Nc6bKPjZnOx5sIwygQzjgUkOgK+PCUQcyrXgjXhGxW0gs2FADrdFlF+OaNFNun
         vOx+rAz4AWNBbrFfX3vyqxwq6JnXtlkdjNzUenklIP+VRSRIloA6tZrX7nYj2NoHJikt
         wV4mQ7atYT5y152OERqcRsAekZFxxMvQVD5v/X3pFNxTTNqq3D6wOh4feyjkb1Nm5kmy
         Re4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725494619; x=1726099419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Pp5XlYCZbKVyNu+taRdigNsqhXnKoDENO/bwZGJUkU=;
        b=rNgLPs9B99vQTo91fKpj3uGedYml5VOkMKO4SHziYtbOSh+Dx8u9AnyTrqSstzWWZt
         1FwUbIzhktbOExTr6sdnEmujui6xHiZRunmxdMYQeve/DCqjK35DkJO6K1Nl6meY3GFO
         8Im5gwKlbmddR+kMV3Ofgvyovp7ckkbSqOASD7uzGLH9noqWBkfhqdEsMLWbpBJDUEKm
         iVXNdWD+SyS5YE9AYo/H6gDHHo09hyn1XCPnQVLacVJZEYCG90SRFEVvA2jFSvmyRc4g
         7RoihxhQHUGqdxuQ+4HKU5BFHKMMeCtgTqaypn3YPOvuluyPb212G/+jWG+ZXwF8ml6l
         +snQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUm8a99MDAuWegrLNX+PxBAeNSZ1Z7vqx2X07F0t337n0nFp53GXQHesi2oGAMNI3lul3I8uNu@vger.kernel.org, AJvYcCXq+4jTK7CHkoLcI4ijweOyYPtvfuI/XNRHJWw0bw+JBRjekFxamCHFoXVWjNhs7ZFHQus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdNZ/VfCaMY5LI+qWpfymsBubmP0OcAOZw5Nug2hJpg9J3oIE4
	uWTYOvsZj5C12AUK4rgDO9jUgU7L82HMLiH/b2uVpezwKbrXvulElM+6CjtOc31l4KzGsYi0piU
	5KkoYwsVtjAZmt8TLm/SB9AziPZc=
X-Google-Smtp-Source: AGHT+IFBpYTti429OSnNnQQ+QN6FQO6CvlS7tcnhLxLRhP/UPmJKgFeYjE++SyoFnDaw1HzAKVP4OrSpsTvrVJ1N8JM=
X-Received: by 2002:a17:90a:e2c3:b0:2d8:9a0c:36c0 with SMTP id
 98e67ed59e1d1-2da55924370mr8617709a91.8.1725494619043; Wed, 04 Sep 2024
 17:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831041934.1629216-1-pulehui@huaweicloud.com>
 <172548183128.1158691.9881712792582282151.git-patchwork-notify@kernel.org> <CAEf4BzayV1ihbfSg4fv0AqSazVycXqCJp4dTq1pwRt5hmx7X4g@mail.gmail.com>
In-Reply-To: <CAEf4BzayV1ihbfSg4fv0AqSazVycXqCJp4dTq1pwRt5hmx7X4g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 17:03:26 -0700
Message-ID: <CAEf4Bza5i+MFqeOs8w+Zhw4e6vt7KMgVwjNaEOTz33P8T6Ldsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] Fix accessing first syscall argument on RV64
To: patchwork-bot+netdevbpf@kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, Networking <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, john fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:44=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
>
> On Wed, Sep 4, 2024 at 1:30=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.or=
g> wrote:
> >
> > Hello:
> >
> > This series was applied to bpf/bpf-next.git (master)
> > by Andrii Nakryiko <andrii@kernel.org>:
> >
> > On Sat, 31 Aug 2024 04:19:30 +0000 you wrote:
> > > On RV64, as Ilya mentioned before [0], the first syscall parameter sh=
ould be
> > > accessed through orig_a0 (see arch/riscv64/include/asm/syscall.h),
> > > otherwise it will cause selftests like bpf_syscall_macro, vmlinux,
> > > test_lsm, etc. to fail on RV64.
> > >
> > > Link: https://lore.kernel.org/bpf/20220209021745.2215452-1-iii@linux.=
ibm.com [0]
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [bpf-next,v3,1/4] libbpf: Access first syscall argument with CO-RE =
direct read on s390
> >     https://git.kernel.org/bpf/bpf-next/c/65ee11d9c822
> >   - [bpf-next,v3,2/4] libbpf: Access first syscall argument with CO-RE =
direct read on arm64
> >     https://git.kernel.org/bpf/bpf-next/c/ebd8ad474888
> >   - [bpf-next,v3,3/4] selftests/bpf: Enable test_bpf_syscall_macro:sysc=
all_arg1 on s390 and arm64
> >     https://git.kernel.org/bpf/bpf-next/c/3a913c4d62e1
> >   - [bpf-next,v3,4/4] libbpf: Fix accessing first syscall argument on R=
V64
> >     https://git.kernel.org/bpf/bpf-next/c/13143c5816bc
> >
>
> Ok, I had to "unapply" these patches, as s390x selftest (bpf_syscall_macr=
o) started failing (arm64 is fine, so I think it's probably due to patch #3=
 that changes selftests itself).
>
> Pu, can you please take a look at that (e.g., see [0])? It's a bit strang=
e, as originally no error was reported, so not sure what changed. Please al=
so see the things I was fixing up while applying, so I don't have to do it =
again :)
>
>   [0] https://github.com/kernel-patches/bpf/actions/runs/10709024755/job/=
29693056550#step:5:8746

Oh, I figured it out! That tmp is there for a reason! We
bpf_probe_read_kernel() 8 bytes, but syscall's 1st argument itself is
4 byte long, so we need to cast u64 to u32. And s390x being the big
endian architecture detected this problem, while for arm64 we were
lucky.

So never mind, I'll apply your patches with fix ups in the
bpf_tracing.h header, but I won't touch patch #3.

>
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> >

