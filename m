Return-Path: <bpf+bounces-79471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F122AD3B06B
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 17:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DE733021694
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9E72DEA67;
	Mon, 19 Jan 2026 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyXfCNQL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4A14EC73
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839592; cv=none; b=YTNw/0AAeQ2YUYlScqtitA8XumpGK5UwUucFzft9aCDeRYfy4gUjn/xm6cUNFb77CadmosJ1Z971b91IdeHO5QIRkSS7ftMQZPk7KAabYlPrPWEKVij+fLB6x99cQF3rz3zSYcpwyL0Yrt1qlKDDGRWacaS1RLoiM15i2HKE90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839592; c=relaxed/simple;
	bh=8d4KBvGi4mqgDhSXVw/x8t8Ybs5Ts2G8TRiYTltr33E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RievHuqzmzY9cEgO4RtV3EHDv1i/yFSohfbDl/aHH1uXYpC6OSA+wdxyZ/aJLXManSbfJCzpmrSTY1r8ghozwPh83gZefXeEVFbmMB3hCdgKKKWGDNTHo+lyhA7dRnvjPqo+vyTVQZQu2Pn75AIpU/sa+BVbnB8nMj43JcGV1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyXfCNQL; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so37181301cf.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 08:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768839588; x=1769444388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHGYVuiqm5BGfNZEy0rG+8KeNo5nPSeV0Hqn9spxebA=;
        b=YyXfCNQLURoYU0VStxVXIjN+AD0LSsgnJPblripflcQBOT23PYTgEAr4v5jGHqaS/j
         tznpbH/UvImK3epy4F3VPAeo0wXvyggcVDG2GgPE6mJXPzxNFYH9NSxEgXHXsyjXx8sw
         +FC+bUEaTygeSOWoXo6ST4qRw5HnRK+3ZNU/U+HkD2dyFv/au6Z44suQw0oc5wkfLJC6
         UQdZprwPX42DchiyulMJvb8AJFdVhdYqzJplsgBi9nOlhknSZbfDqLhN97X5dS85KlHb
         My6J3KcDvqsmi2/nZhazSkADbwuJEwCFwyRq6oJM4RfSb6E8bc76fW2DgSUMg21f7CPp
         zAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768839588; x=1769444388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHGYVuiqm5BGfNZEy0rG+8KeNo5nPSeV0Hqn9spxebA=;
        b=dN1MaIqybfIaGMiZb5gyuQaZdce1z73AadJ27AeY9hhSDxO0ir1kar5L1hje3XHz/q
         eDxLW5qUstt5rmWRHghmk0HmKtMyN8h4DylS/0FNCDz7ngsvJn0G7d68xdGusgArhFsP
         EV6Nxn3sJ01gpK+fLj36u6i3+Ag7zwm1XzBn1EuSosV8GYklNAW73M/CTstw7YGadNe7
         6v44trG/+8G7+CYPmqFJyKAy+IU+gxkDnNApWsbRLuNDwEIbMyYja/M88Ab23nPyK7C7
         xi/MXAoj392aXCCQdpKk8BkctqVrrDEITKceWOzUXhNYPqeS7VNVaH9wxsvy6MPhA082
         T5tw==
X-Gm-Message-State: AOJu0YyA1Rt6t7ZGcMwp138Z1E7HY1jHPuMispdkp0GsyFwxUFkoTvtz
	GGRpW5pHZugad0wVwvwZXPmMPtovRvjk5U32bVCmM4Z9dKobYm+9baO0gzem5JoRfMXSDyQE88v
	GvnrBBrzODs8PmMWgpEJkGKVNMXHPu9w=
X-Gm-Gg: AY/fxX6RFV9trfuFxaLdVvTfZPRXaNUanHiBsEFr8UjWmLW72h3q1Ed00r2lc7JImFI
	qKcpCwD/6arEMtALC5pFaynyayVkU2Br++S1YP6MKg3mnYvpXMV8JCK441BBz9kpMdPyGXFMFn5
	5wnE7OtkKLt4Zs8glwDLgYIWeLy7JKsNsZumEzhhCkeHW0E+GiDTG8eJjqj8xQJnsKtek2Vswss
	huxMSDlKKWBLs600tkyaPl39GKQIaNaUQjgd5VOZlGXCKXvX0tBFTlwFqHLiLVL25teows=
X-Received: by 2002:a05:622a:1191:b0:501:17e3:30bb with SMTP id
 d75a77b69052e-502a1e29576mr153743741cf.25.1768839588516; Mon, 19 Jan 2026
 08:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2yu+XkEMWz6FOHiDEEQw-G_iKG2KHP=F=1CiqLr0mCgNA@mail.gmail.com>
 <d299d7ba-4e9e-5b16-5aa4-898b62330c24@loongson.cn> <CAK3+h2yFJDNVPo=38PcYCMNhmw0cQBouL5h7sX0KmyLu-_5zwQ@mail.gmail.com>
 <c15fd22f-9c36-bf8d-5bd4-02993147d113@loongson.cn>
In-Reply-To: <c15fd22f-9c36-bf8d-5bd4-02993147d113@loongson.cn>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Mon, 19 Jan 2026 08:19:37 -0800
X-Gm-Features: AZwV_Qi56HUO8Vswoqi5cUeeLkQ-FnXejoq6bZuiUoBuJvqsVqq5OYqF9Jdtkoo
Message-ID: <CAK3+h2xDBB023RQwFj9FmYVveR8qdg7RSDqU3xExsnNMY6A3pg@mail.gmail.com>
Subject: Re: [BUG?]: bpf/selftests: ns_bpf_qdisc libbpf: loading object
 'tc_bpf' from buffer
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: bpf <bpf@vger.kernel.org>, loongarch@lists.linux.dev, ast <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Chenghao Duan <duanchenghao@kylinos.cn>, Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:01=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2026/1/16 =E4=B8=8A=E5=8D=884:44, Vincent Li wrote:
> > On Wed, Jan 14, 2026 at 5:13=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
>
> ...
>
> > Do you have proper instructions to compile gcc?
>
> git clone git://gcc.gnu.org/git/gcc.git gcc
> cd gcc && ./contrib/download_prerequisites --no-verify
> cp config.guess gettext/build-aux/config.guess && cp config.sub
> gettext/build-aux/config.sub
> cp config.guess gmp/config.guess && cp config.sub gmp/config.sub
> cp config.guess mpfr/config.guess && cp config.sub mpfr/config.sub
> cp config.guess mpc/build-aux/config.guess && cp config.sub
> mpc/build-aux/config.sub
> cp config.guess isl/config.guess && cp config.sub isl/config.sub
> rm -rf build && mkdir -p build && cd build
> ../configure --prefix=3D/usr/local/gcc --enable-checking=3Drelease
> --enable-languages=3Dc,c++ --disable-multilib
> make -j"$(nproc)"
> sudo rm -rf /usr/local/gcc && sudo make install
> export PATH=3D/usr/local/gcc/bin:$PATH
> export LD_LIBRARY_PATH=3D/usr/local/gcc/lib:$LD_LIBRARY_PATH
>
Thanks for the instruction.
> > I am not sure if it is toolchain related. The thing that really
> > bothered me is why the hell tc_bpf is loaded by libbpf for
> > ns_bpf_qdisc selftests that seems to have nothing to do with the
> > tc_bpf object, I can't think of anything special in my build machine
> > that would trigger this. Anyway, thanks for the help!
>
> I tested it again with lower version tool chains, the test still passed
> on my environment.
>
I suspect it is more of bpf selftests issue or tc related selftests
issue, I noticed for tests that invokes tc command to setup the
environment, I would hit the issue. I guess I am the only one to hit
this jackpot :). I do not know enough about the tc or selftests/libbpf
(loading object from buffer thing), someone with intimate knowledge
about that may have some clue. Thanks for the  gcc instruction again,
I may need it sometime in the future when I need to compile gcc.

> fedora@linux:~$ clang --version | head -1
> clang version 19.1.6 (Fedora 19.1.6-3.fc42)
> fedora@linux:~$ gcc --version | head -1
> gcc (GCC) 14.2.1 20241104 (Red Hat 14.2.1-6)
> fedora@linux:~$ as --version | head -1
> GNU assembler version 2.43.50.20241126
> fedora@linux:~$ pahole --version
> v1.31
> fedora@linux:~$ uname -r
> 6.19.0-rc6
> fedora@linux:~$ uname -m
> loongarch64
>
> Thanks,
> Tiezhu
>

