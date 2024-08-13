Return-Path: <bpf+bounces-37084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0090A950D3F
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C1C1F22D8F
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 19:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571BD1A0B1F;
	Tue, 13 Aug 2024 19:39:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2D44C97;
	Tue, 13 Aug 2024 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577949; cv=none; b=RT7X8K02mFE3ogV8kHknp9P2dY8IgWk6SnIgL0DVT3XyIXR6cyynqnKMSIvi7QK/7vmITQ7m3qQbuGtETzYgs+R0CziaspSKGGIgKdGhl1EhTP0R/cvFp3POe/T5yAwVlYFgf1dES6JArYO2hbbLkZA8sFowB05on5NV0IELqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577949; c=relaxed/simple;
	bh=lG7IomfuKHNuswLSyUl7mClGTN9Q43IhaBK4tL2STGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mAe8FKASHu+nwxKJl5oBbW/kduQcxwQDEgq31uvzZA20TcmgLpn+Y/z53zPo/qG4aE0x678lr1POnKlqcZS74uObn/NYxjdhoV7mbv0lbxPx/BYgansw/+oJgXlmExjzNI//Kr4h34JZ5esY4XnfUzAidwXYQ4fLOTj2EKZPueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,  Andrii Nakryiko
 <andrii@kernel.org>,  Eduard Zingerman <eddyz87@gmail.com>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  "Jose E . Marchesi" <jose.marchesi@oracle.com>,
  Andrew Pinski <quic_apinski@quicinc.com>,  Kacper =?utf-8?B?U8WCb21pxYRz?=
 =?utf-8?B?a2k=?=
 <kacper.slominski72@gmail.com>,  Arsen =?utf-8?Q?Arsenovi=C4=87?=
 <arsen@gentoo.org>,
  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] libbpf: workaround -Wmaybe-uninitialized false positive
In-Reply-To: <CAEf4Bza3RH6p=KJu8cm2jb4QwKCHc5ZUskE9cvWTBXyXFUKHuA@mail.gmail.com>
	(Andrii Nakryiko's message of "Mon, 12 Aug 2024 14:02:51 -0700")
Organization: Gentoo
References: <12cec1262be71de5f1d9eae121b637041a5ae247.1723459079.git.sam@gentoo.org>
	<61cf5568-7a01-4231-8189-006bde4ec0ad@oracle.com>
	<CAEf4Bza3RH6p=KJu8cm2jb4QwKCHc5ZUskE9cvWTBXyXFUKHuA@mail.gmail.com>
Date: Tue, 13 Aug 2024 20:38:59 +0100
Message-ID: <878qx0gqlo.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Aug 12, 2024 at 6:57=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
>>
>> On 12/08/2024 11:37, Sam James wrote:
>> > In `elf_close`, we get this with GCC 15 -O3 (at least):
>> > ```
>> > In function =E2=80=98elf_close=E2=80=99,
>> >     inlined from =E2=80=98elf_close=E2=80=99 at elf.c:53:6,
>> >     inlined from =E2=80=98elf_find_func_offset_from_file=E2=80=99 at e=
lf.c:384:2:
>> > elf.c:57:9: warning: =E2=80=98elf_fd.elf=E2=80=99 may be used uninitia=
lized [-Wmaybe-uninitialized]
>> >    57 |         elf_end(elf_fd->elf);
>> >       |         ^~~~~~~~~~~~~~~~~~~~
>> > elf.c: In function =E2=80=98elf_find_func_offset_from_file=E2=80=99:
>> > elf.c:377:23: note: =E2=80=98elf_fd.elf=E2=80=99 was declared here
>> >   377 |         struct elf_fd elf_fd;
>> >       |                       ^~~~~~
>> > In function =E2=80=98elf_close=E2=80=99,
>> >     inlined from =E2=80=98elf_close=E2=80=99 at elf.c:53:6,
>> >     inlined from =E2=80=98elf_find_func_offset_from_file=E2=80=99 at e=
lf.c:384:2:
>> > elf.c:58:9: warning: =E2=80=98elf_fd.fd=E2=80=99 may be used uninitial=
ized [-Wmaybe-uninitialized]
>> >    58 |         close(elf_fd->fd);
>> >       |         ^~~~~~~~~~~~~~~~~
>> > elf.c: In function =E2=80=98elf_find_func_offset_from_file=E2=80=99:
>> > elf.c:377:23: note: =E2=80=98elf_fd.fd=E2=80=99 was declared here
>> >   377 |         struct elf_fd elf_fd;
>> >       |                       ^~~~~~
>> > ```
>> >
>> > In reality, our use is fine, it's just that GCC doesn't model errno
>> > here (see linked GCC bug). Suppress -Wmaybe-uninitialized accordingly
>> > by initializing elf_fd.elf to -1.
>> >
>> > I've done this in two other functions as well given it could easily
>> > occur there too (same access/use pattern).
>> >
>>
>> hmm, looking at this again - given that there are multiple consumers -
>
> yes, I don't like that each caller has to remember to initialize the
> struct that is clearly initialized by elf_open() itself, so see below.
>
> pw-bot: cr
>
>> I suppose another option would perhaps be to
>>
>> - have elf_open() to init int fd =3D -1, Elf *elf =3D NULL.
>
> I'd do just
>
> elf_fd->elf =3D NULL;
> elf_fd->fd =3D -1;
>
> and do nothing else. This should be enough for compiler to not trigger th=
is.

OK.

>
>> - have error paths in elf_open() "goto out"; at out: we set elf_fd->fd,
>> elf_fd->elf to fd, elf
>> - have elf_close() exit it elf_fd < 0 (since 0 is a valid fd), as it
>> will for the error cases
>>
>
> Let's not touch anything else, this should be enough.
>
>
>> Might all be bit excessive, and might not even fix the false positive
>> issue here, so
>>
>> > Link: https://gcc.gnu.org/PR114952
>> > Signed-off-by: Sam James <sam@gentoo.org>
>>
>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>>
>> > ---
>> > v3: Initialize to -1 instead of using a pragma.
>> >
>> > Range-diff against v2:
>> > 1:  8f5c3b173e4cb < -:  ------------- libbpf: workaround -Wmaybe-unini=
tialized false positive
>> > -:  ------------- > 1:  12cec1262be71 libbpf: workaround -Wmaybe-unini=
tialized false positive
>> >
>> >  tools/lib/bpf/elf.c | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
>> > index c92e02394159e..00ea3f867bbc8 100644
>> > --- a/tools/lib/bpf/elf.c
>> > +++ b/tools/lib/bpf/elf.c
>> > @@ -374,7 +374,7 @@ long elf_find_func_offset(Elf *elf, const char *bi=
nary_path, const char *name)
>> >   */
>> >  long elf_find_func_offset_from_file(const char *binary_path, const ch=
ar *name)
>> >  {
>> > -     struct elf_fd elf_fd;
>> > +     struct elf_fd elf_fd =3D { .fd =3D -1 };
>> >       long ret =3D -ENOENT;
>> >
>> >       ret =3D elf_open(binary_path, &elf_fd);
>> > @@ -412,7 +412,7 @@ int elf_resolve_syms_offsets(const char *binary_pa=
th, int cnt,
>> >       int err =3D 0, i, cnt_done =3D 0;
>> >       unsigned long *offsets;
>> >       struct symbol *symbols;
>> > -     struct elf_fd elf_fd;
>> > +     struct elf_fd elf_fd =3D { .fd =3D -1 };
>> >
>> >       err =3D elf_open(binary_path, &elf_fd);
>> >       if (err)
>> > @@ -507,7 +507,7 @@ int elf_resolve_pattern_offsets(const char *binary=
_path, const char *pattern,
>> >       int sh_types[2] =3D { SHT_SYMTAB, SHT_DYNSYM };
>> >       unsigned long *offsets =3D NULL;
>> >       size_t cap =3D 0, cnt =3D 0;
>> > -     struct elf_fd elf_fd;
>> > +     struct elf_fd elf_fd =3D { .fd =3D -1 };
>> >       int err =3D 0, i;
>> >
>> >       err =3D elf_open(binary_path, &elf_fd);

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOUEARYKAI0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCZru2U18UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MA8cc2FtQGdlbnRv
by5vcmcACgkQc4QJ9SDfkZAPMgEA7XDQpwzpI8shOtCDuwhKkZNSTdguPclyA/4x
ZT9DnXQBAO+PzWg3TsYOzxO7d5hS1yDNaZqJ3iI34t4XW93rY9gN
=vKNv
-----END PGP SIGNATURE-----
--=-=-=--

