Return-Path: <bpf+bounces-48260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E9A0623B
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9BB166D6E
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8179420012B;
	Wed,  8 Jan 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="P4nNUTwN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4A1FF619;
	Wed,  8 Jan 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354336; cv=none; b=eOCMoGZ5hi+uxbsSu5hm2ucWi93DFUHy6zFQKb//gebNW28rqwmTeBHuzKavVFlOydvQ3j8o3mdxblVvt3veKAFuCDPu+wGvoAqek7342GnKRTteVosHo6nUG7QblOhp5mN0QFVw3DRWRne2bUD0EN2X89p4TIXkptbS1+aEbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354336; c=relaxed/simple;
	bh=7JoPoy2le9vMdrCVcetgjVVFUE63+ZPwPVlXYBcb8H0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV0LqvFsWrGtJLg/JfOkMb37SA/TFGcunIoI/n78CLAfxZA9Yq+bkRFXlBGwI639NpZaUb+O1TvCfIjupZHT8WkGEqcyAw8/fSVymIkmIoVl4I4A9iokDYhHjQ+0ckztWjXn1jRPHx0Jxnz0R+V/XRQ+Ak6i1eADxNhF2LhJRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=P4nNUTwN; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736354332; x=1736613532;
	bh=7JoPoy2le9vMdrCVcetgjVVFUE63+ZPwPVlXYBcb8H0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=P4nNUTwN11D1f+VQMqevkRTdj2xokfYNP9iVcVTDptklBxJ8EEdG5sx/deiW+1Lbm
	 Z9L0NdAIyaOhkaSKEy5poSJ0moZjHPi2OsrtPrQAD30EE5/A8G3hAVtmyA1V94hEyE
	 92WIiUq0zqXqsb3AGSIYJbMyGFKXxCXUs9vYbGjQenXZd9ps4TBUOmkaADQWcNUxAP
	 6ypVsMnlsaK5VPguzEbt1G47kc5oPe3ljcQl7d0ZqXee2xZqx7uEJ6H5QUdwc3h0TK
	 DP3TvX13OZlUdZIXqIDFus9UwbIy7HoWwkxgBHCXy6Xk2HG7N00bESeLGoygtu+bLK
	 9J+Vn3v7kAOgQ==
Date: Wed, 08 Jan 2025 16:38:46 +0000
To: Alan Maguire <alan.maguire@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] dwarves: set cu->obstack chunk size to 128Kb
Message-ID: <Xfd2PxigaipLv392tfxKUdgwxRMdn9bMsaq4GCJxbX7DooxvxfZAtJceZkZVk14GHODh0twQw598iFTBaYkZ8mJxTCfEhi7S9WgB54C0zN4=@pm.me>
In-Reply-To: <92a6a095-3a49-4204-af49-643f2db1e3a9@oracle.com>
References: <20241221030445.33907-1-ihor.solodrai@pm.me> <92a6a095-3a49-4204-af49-643f2db1e3a9@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: ba50336d0b86dc8d56abe27ea83b9d57226f1ca5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, January 8th, 2025 at 5:55 AM, Alan Maguire <alan.maguire@orac=
le.com> wrote:

>=20
>=20
> On 21/12/2024 03:04, Ihor Solodrai wrote:
>=20
> > In dwarf_loader with growing nr_jobs the wall-clock time of BTF
> > encoding starts worsening after a certain point [1].
> >=20
> > While some overhead of additional threads is expected, it's not
> > supposed to be noticeable unless nr_jobs is set to an unreasonably big
> > value.
> >=20
> > It turns out when there are "too many" threads decoding DWARF, they
> > start competing for memory allocation: significant number of cycles is
> > spent in osq_lock - in the depth of malloc called within
> > cu__zalloc. Which suggests that many threads are trying to allocate
> > memory at the same time.
> >=20
> > See an example on a perf flamegraph for run with -j240 [2]. This is
> > 12-core machine, so the effect is small. On machines with more cores
> > this problem is worse.
> >=20
> > Increasing the chunk size of obstacks associated with CUs helps to
> > reduce the performance penalty caused by this race condition.
>=20
>=20
> Is this because starting with a larger obstack size means we don't have
> to keep reallocating as the obstack grows?

Yes. Bigger obstack size leads to lower number of malloc calls. The
mallocs tend to happen at the same time between threads in the case of
DWARF decoding.

Curiously, setting a higher obstack chunk size (like 1Mb), does not
improve the overall wall-clock time, and can even make it worse.
This happens because the kernel takes a different code path to allocate
bigger chunks of memory. And also most CUs are not big (at least in case
of vmlinux), so a bigger chunk size probably increases wasted memory.

128Kb seems to be close to a sweet spot for the vmlinux.
The default is 4Kb.

>=20
> Thanks!
>=20
> Alan
>=20
> > [1] https://lore.kernel.org/dwarves/C82bYTvJaV4bfT15o25EsBiUvFsj5eTlm17=
933Hvva76CXjIcu3gvpaOCWPgeZ8g3cZ-RMa8Vp0y1o_QMR2LhPB-LEUYfZCGuCfR_HvkIP8=3D=
@pm.me/
> > [2] https://gist.github.com/theihor/926af22417a78605fec8d85e1338920e
> >=20
> > Signed-off-by: Ihor Solodrai ihor.solodrai@pm.me
> > ---
> > dwarves.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/dwarves.c b/dwarves.c
> > index 7c3e878..105f81a 100644
> > --- a/dwarves.c
> > +++ b/dwarves.c
> > @@ -722,6 +722,8 @@ int cu__fprintf_ptr_table_stats_csv(struct cu *cu, =
FILE *fp)
> > return printed;
> > }
> >=20
> > +#define OBSTACK_CHUNK_SIZE (128*1024)
> > +
> > struct cu *cu__new(const char *name, uint8_t addr_size,
> > const unsigned char *build_id, int build_id_len,
> > const char *filename, bool use_obstack)
> > @@ -733,7 +735,7 @@ struct cu *cu__new(const char *name, uint8_t addr_s=
ize,
> >=20
> > cu->use_obstack =3D use_obstack;
> > if (cu->use_obstack)
> > - obstack_init(&cu->obstack);
> > + obstack_begin(&cu->obstack, OBSTACK_CHUNK_SIZE);
> >=20
> > if (name =3D=3D NULL || filename =3D=3D NULL)
> > goto out_free;

