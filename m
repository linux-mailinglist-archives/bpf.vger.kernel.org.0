Return-Path: <bpf+bounces-2713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E5A732F5D
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 13:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0BD1C2037E
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2362107A1;
	Fri, 16 Jun 2023 11:03:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4322E0F6
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 11:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B03CC433C8;
	Fri, 16 Jun 2023 11:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686913404;
	bh=K3lFwyOnVKe+TMdTvX27i4bzBi+CYkU0SDSmg004bso=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=dQayLtCOyPqzP2H1hF4KitPWW/+uNGDZJ1aD7SYu4gFeE3ZHAtwwiBdB/B87hZrKG
	 YDZ5KkNAP8/lXLyFDd5YkbSyhVqw+JqmEPc+7ZvoKlpZLca9X+eYIkbIFLirZqvAnt
	 KIa/Mu/ZJh+wh34K+cvjlQ0CvGvGSF+R5MApYS8ZcnTmFLc7vRwEwRxNB+1BXmv3xN
	 YjxGPq/P8G+rnYxYNiZaE1bcyh+8nrsPxLXcRZXufcNwF5SxX3AiQ+RwOetQvww38G
	 K+AOoh0b115OU+XpyuX6Ozj2Z3fMb1zxTOUq9nQWKcGvA3jxKD89QNj7f+eh8Uj+jE
	 yMEYM5KMxRqUw==
Date: Fri, 16 Jun 2023 16:28:53 +0530
From: Naveen N Rao <naveen@kernel.org>
Subject: Re: ppc64le vmlinuz is huge when building with BTF
To: Alan Maguire <alan.maguire@oracle.com>, Dominique Martinet
	<asmadeus@codewreck.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
References: <ZIqGSJDaZObKjLnN@codewreck.org> <ZIrONqGJeATpbg3Y@krava>
	<ZIr7aaVpOaP8HjbZ@codewreck.org>
	<6b26dfef-016c-43df-07f5-c2f88157d1dc@oracle.com>
	<ZIt11crcIjfyeygA@codewreck.org>
In-Reply-To: <ZIt11crcIjfyeygA@codewreck.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: astroid/0.16.0 (https://github.com/astroidmail/astroid)
Message-Id: <1686912543.c6zqyw5s4x.naveen@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

[Cc linuxppc-dev]

Dominique Martinet wrote:
>=20
> Alan Maguire wrote on Thu, Jun 15, 2023 at 03:31:49PM +0100:
>> However the problem I suspect is this:
>>=20
>>  51 .debug_info   0a488b55  0000000000000000  0000000000000000  026f8d20
>>  2**0
>>                   CONTENTS, READONLY, DEBUGGING
>> [...]
>>=20
>> The debug info hasn't been stripped, so I suspect the packaging spec
>> file or equivalent - in perhaps trying to preserve the .BTF section -
>> is preserving debug info too. DWARF needs to be there at BTF
>> generation time in vmlinux but is usually stripped for non-debug
>> packages.
>=20
> Thanks Alan and Eduard!
> I guess I should have checked that first, it helps.
>=20
> We're not stripping anything in vmlinuz for other archs -- the linker
> script already should be including only the bare minimum to decompress
> itself (+compressed useful bits), so I guess it's a Kbuild issue for the
> arch.

For a related discussion, see:
http://lore.kernel.org/CAK18DXZKs2PNmLndeGYqkPxmrrBR=3D6ca3bhyYCj=3DGhyA7dH=
fAQ@mail.gmail.com

> We can add a strip but I unfortunately have no way of testing ppc build,
> I'll ask around the build linux-kbuild and linuxppc-dev lists if that's
> expected; it shouldn't be that bad now that's figured out.

Stripping vmlinux would indeed be the way to go. As mentioned in the=20
above link, fedora also packages a strip'ed vmlinux for ppc64le:
https://src.fedoraproject.org/rpms/kernel/blob/4af17bffde7a1eca9ab164e5de0e=
391c277998a4/f/kernel.spec#_1797


- Naveen


