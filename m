Return-Path: <bpf+bounces-40146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F134097D9DC
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 21:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B521F2362E
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D43918453F;
	Fri, 20 Sep 2024 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQwlWKNM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30257183CDC
	for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726861054; cv=none; b=aHlAOiYq6rlU1DWLys/SssWCl2a6yNVwBzWsU+wtH0El+bT1D1zx5ClUM6xHYibZaKzCDNs3/KTHUGgaiDXIkBeEI6CCy98UHUPFRSujPJqgFT7C7RVEs3WZsZExFzumLAcol3+8T1R+tCyt1e9lFNJDhPGPSB8NUx1JfjuvBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726861054; c=relaxed/simple;
	bh=KKpR6TQAtMqQFHVkpqLTBzPw9tA8aIdIeS3DeolCA8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVeT69u2hbj4kwM3YLmfbNtHXDvtGyL6U1kgjIX3oiIEe6aquEYFU5QeOzZ9WXMWjs/F4OM2x1qHuV4KWtTY/f9OYMJ9d9C0kgLGgje8LzHOqt01gLmO9yokejOBMHr9F/Fq12CecQ6XMU61Lqtlbh/nBuDrkkAhnHzaEoR4tkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQwlWKNM; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a08555642cso10405475ab.1
        for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726861051; x=1727465851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm+q2TXJTzPGQ26XwIEpZAOEZBdXyJb7YnisbTfeHB8=;
        b=KQwlWKNMG200gdcJPyCkIv333pBjpZxMG8MMwTLFj015rHG4EncEXXny6A02JS04UZ
         W6qAzE9tbRQse+TedU/xoqv0etw+QviZylVMPwAPCxSVaGB9wsrRKleg5XdixEAMswZG
         Vg8Y1Nr2Mn7gQvgrD53+76bQlFRG0n0QxV/mr56uI5/WhxCC5GNHAaSVuHq7WzZolsxh
         4pQOqBhof+V+upWjtOXaakBgkUhSOmF5ZEWsONLACNHg2lAzI16mhbxCLRWzUizx0ibf
         2Ou/2zljDoMCkZ/1J81YI+JEFxuyMWc6I4Suw+ImKmDZSRLVAgHWX+zPgHClXvNN1bHZ
         GXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726861051; x=1727465851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hm+q2TXJTzPGQ26XwIEpZAOEZBdXyJb7YnisbTfeHB8=;
        b=hdU8JaKV9TkxxqRXirzOvykoDhtntwJwm9YeVi+xP25cyYORZwGKlPOuIBnhIEkdY+
         7u5WHC9vWr7GUztuYNmS/EgnvXz1itBQTHrAJlUTa8L0clD7t9JR5dT6uWq9PnzVLTXj
         dU9kDf7eyz7sjE2OD0svBXlS5zBHuNYWBJV0ld9TvZBKnTRADhpBfnM5cr189veQ+hnR
         6rKCpGezP4z+U/xvd3R7WBfnQerGp0AbNhcM4Z8nF5MGD9woQsfv019VngLXC+1L4TcJ
         dSJFVvxLzhjZWma4QfOHlIJe1jhqZUprJTfG88rbp3fGTxsL3QuT+17kMEmnVOXKBw8r
         k7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWQn4V2tXbEtN6a5iBwxb3DSnNgGmHNxrsTwD5GD8NhiJfivSoTxkVHH3ErT0wNg6o+C1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxmp5URVlfp5mjhT47qNmeqBdMVhgMDr1Dbc0h6YUb2JNE9IR
	YEkxTiP4VmA2phKP1QJdcGK5mPQkv80JEbw3hDG8rmfmYuRwHhqkcBVvOsuHB99cLz9D7sY2h/3
	3wpQOqKt0+oyJw9okvQauo5avBXA=
X-Google-Smtp-Source: AGHT+IFJ0d/LQ4eBoNTyfITzaFuFS+Yz2ifPJ/n6oXp81CXV7Tb5no3BWBdbbeSLZeJlkMtmk9WeZiyKN7RXrDeBrTQ=
X-Received: by 2002:a05:6e02:1d0e:b0:3a0:ab71:ed27 with SMTP id
 e9e14a558f8ab-3a0c8cbfebemr51719365ab.14.1726861051236; Fri, 20 Sep 2024
 12:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919195454.73358-1-kerneljasonxing@gmail.com> <CAADnVQJUd_1y-Ecgw3pgd6z2jw6=ZEm5wnxQqwUnhCobw752fQ@mail.gmail.com>
In-Reply-To: <CAADnVQJUd_1y-Ecgw3pgd6z2jw6=ZEm5wnxQqwUnhCobw752fQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 20 Sep 2024 21:36:54 +0200
Message-ID: <CAL+tcoDEpGq3NfYgavc=wwgsMch=L7mh9-0J8tWv2Sv1MWCH+w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: syscall_nrs: fix no previous prototype for "syscall_defines"
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 11:17=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 19, 2024 at 9:55=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In some environments (gcc treated as error in W=3D1, which is default),=
 if we
> > make -C samples/bpf/, it will be stopped because of
> > "no previous prototype" error like this:
> >
> >   ../samples/bpf/syscall_nrs.c:7:6:
> >   error: no previous prototype for =E2=80=98syscall_defines=E2=80=99 [-=
Werror=3Dmissing-prototypes]
> >    void syscall_defines(void)
> >         ^~~~~~~~~~~~~~~
>
> samples/bpf/ doesn't accept patches any more.
> If this samples/test is useful, refactor it to the test_progs framework.
> Otherwise delete it.
>
> pw-bot: cr

After reconsidering what Alexei said, I still feel we could take this
patch? It is because:
1) the patch itself  is more of a fix instead of optimization,
2)as long as samples/bpf exists in the kernel, we cannot easily let
it(issues) go and ignore it.

Applying such a patch won't cause any further confusion, right? As we
can see, it's like a fix which does not introduce anything new here.

What do you bpf maintainers think?

Thanks,
Jason

