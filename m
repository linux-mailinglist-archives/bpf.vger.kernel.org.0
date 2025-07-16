Return-Path: <bpf+bounces-63439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BDB07694
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 15:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4AE3A6593
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3D2F2C40;
	Wed, 16 Jul 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="suI7SbnF"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D7291C09
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671193; cv=none; b=lSLxzCp7LHyq+tytGQOXeZtZEn98oSOECopsw6kLD1k4ncfDT491/zUthuHgTInFkWKgAi36aiEzH7tETwgIs7fwqfs9tUWSS1/l/dyXKyNoaoujQmZtIFmQ4aWVI7HyBcGHWVxYBX5GvepQ7EYm8t8W0Wyh7H3EDkp7u6cAxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671193; c=relaxed/simple;
	bh=FFprpTDgpxVkV1oUIt6mRMcDCCvCi3FWjUtBxN0SDFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHuFN+JGWPl9Pxh90sdgOjpEL6tMhITNbPi7IL0KCXGusqa6h/5vIDdyScc+2WaUHq2O8AzLEpSPWlYQWHQmRLmnuREhnnwjFqZ7PzkNAdfDSVvZ1yHWH/89YDQKDY+oOOd8gzfiO9a8dFPvF75ztLFs5yqfsvbzuJYmNANZ/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=suI7SbnF; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752671187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FFprpTDgpxVkV1oUIt6mRMcDCCvCi3FWjUtBxN0SDFE=;
	b=suI7SbnFGXn4ne1XyK2dgLnzSV11B5f2wH263FrVDwxEbxe5Pj5PU30YUCWCMEj3ZJ6h7q
	xnOWyQ9IpOaeFnzTG5ZNeQr5gyU7a/GvW4HxIGLZMp9W/5Lynd3zekMWiZT7jW1xKuhbo3
	qpZCsP/J75bEKlRrRTYq9Fx9Nm4xlck=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next v2 02/18] x86,bpf: add bpf_global_caller for global
 trampoline
Date: Wed, 16 Jul 2025 21:05:25 +0800
Message-ID: <4737114.cEBGB3zze1@7940hx>
In-Reply-To:
 <CAADnVQ+7NhegoZGHkiRyNO8ywks3ssPzQd6ipQzumZsWUHJALg@mail.gmail.com>
References:
 <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev>
 <CAADnVQ+7NhegoZGHkiRyNO8ywks3ssPzQd6ipQzumZsWUHJALg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5145802.0VBMTVartN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart5145802.0VBMTVartN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Jul 2025 21:05:25 +0800
Message-ID: <4737114.cEBGB3zze1@7940hx>
MIME-Version: 1.0

On Wednesday, July 16, 2025 12:35 AM Alexei Starovoitov <alexei.starovoitov=
@gmail.com> write:
> On Tue, Jul 15, 2025 at 1:37=E2=80=AFAM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> >
> > On 7/15/25 10:25, Alexei Starovoitov wrote:
[......]
> >
> > According to my benchmark, it has ~5% overhead to save/restore
> > *5* variants when compared with *0* variant. The save/restore of regs
> > is fast, but it still need 12 insn, which can produce ~6% overhead.
>=20
> I think it's an ok trade off, because with one global trampoline
> we do not need to call rhashtable lookup before entering bpf prog.
> bpf prog will do it on demand if/when it needs to access arguments.
> This will compensate for a bit of lost performance due to extra save/rest=
ore.

I don't understand here :/

The rhashtable lookup is done at the beginning of the global trampoline,
which is called before we enter bpf prog. The bpf progs is stored in the
kfunc_md, and we need get them from the hash table.

If this is the only change, it is still OK. But according to my previous, t=
he
rhashtable can cause ~7% addition overhead. So if we change both
them, the performance of tracing-multi is a little far from tracing, which
means ~25% performance gap for the functions that have no arguments.
About the rhashtable part, I'll do more research on it and feedback late.

>=20
> PS
> pls don't add your chinatelecom.cn email in cc.
> gmail just cannot deliver there and it's annoying to keep deleting
> it manually in every reply.

Sorry about that. I filtered out such message in my gmail, and
didn't notice it. I'll remove it from the CC in the feature :)

Thanks!
Menglong Dong


--nextPart5145802.0VBMTVartN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEEfXselyBLFGBR0Mm8PZ2NQ5E0lkFAmh3o5UACgkQ8PZ2NQ5E
0lkkCwgAlk78qwKwT1vJIddz1SFQrEqPUaTnQ74dM5yRwlhy3vYb3dLRi2Pc8B3F
OvgsL+oL1BjI2eS64jkfZhs/hyYlbFujf6m59rmQnUsYCbiqEdyxAJC4XsF6Q+fg
bC2nUyOPt52XUr2sOm460YOVGbKve3W8SdJaruHezBvJgVUzNwhVsiPBD0RWwQaJ
vSeBzA7isIgXs7hycBwvDU3zRO64EbgpKzEz/pSK5emHyK5V1fvBI9fx6qIP1jnr
mSZKNOHlh7LaR2S7kx2vA6y8+hfn0b8fYzI49D65jasLqZw84qbrwg6/FTAK2Bvq
ALZIMhtglEtinMZlz+1n33G3pfAepw==
=X08I
-----END PGP SIGNATURE-----

--nextPart5145802.0VBMTVartN--




