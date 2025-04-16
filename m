Return-Path: <bpf+bounces-56019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21BCA8AD6C
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 03:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C19B3B057F
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 01:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B892063DA;
	Wed, 16 Apr 2025 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixhqu8ie"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515C204C36
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765859; cv=none; b=IEqWKNyzvnDOMc+wIPEQaYUR4ipGU0eYHVgkQ3LpqgPet0ZLKQ4y71fIA/6VfQn7iKGK+qgUNixFwsne6eHNH+jH03wNpR13kEr16XBX9Qj6M3CvCULn/umVpGlkEp5nVrW2aZ5IwbnIlfwzYk81awyLqpMYTDQKbjiRYGiUn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765859; c=relaxed/simple;
	bh=PDALcxKJXPzeoDntncEi1hWk1OSxrLhN9dVIBsoey5o=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=NpKp/w2F0lRPV3QO+T86ZiGbcnPl3uO1ytyTnVcs0kborBIVZTdwn10hROOdCRfYK4n4u5jnNHxPr/v8NhoN8DFHIx8ZJ8GPQZ5tZBdt6el4icjhWwPoyLJ532u6f+z0GpNVUwyNy/OokSEZD5g1kEX5f40q43iXFiu80dYOIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixhqu8ie; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744765844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSgRQqL/0m8ZtEm6XJrXuugzLrHJy50AWjnxLd/indg=;
	b=ixhqu8iedvbNYZZhAX9c91zgXduok+vZJKGlSmGaxJE1uiR3JKuJDFltBAKRo+/9x1Rir1
	tEZ0H2juVM1uAyM3HPeHozFbMIoX756b8pW1BR6mKgEhw4yP5U0s05b1JKwoBPA7Q1iBPz
	cRoc+ywAEk2RI1Kfvg7CfqvOOoYDuIo=
Date: Wed, 16 Apr 2025 01:10:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <cfc371285323e1a3f3b006bfcf74e6cf7ad65258@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf] selftests/bpf: remove sockmap_ktls
 disconnect_after_delete test
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel  Borkmann" <daniel@iogearbox.net>, "Eduard"
 <eddyz87@gmail.com>, "bpf" <bpf@vger.kernel.org>, "Network Development"
 <netdev@vger.kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Mykola Lysenko" <mykolal@fb.com>, "Kernel
 Team" <kernel-team@meta.com>
In-Reply-To: <b787119e15a218cc10a850f2c774fd328d53ef55@linux.dev>
References: <20250415163332.1836826-1-ihor.solodrai@linux.dev>
 <3cb523bc8eb334cb420508a84f3f1d37543f4253@linux.dev>
 <02aa843af95ad3413fb37f898007cb17723dd1aa@linux.dev>
 <CAADnVQ+5_mqEGnEs-RwBwh7+v2aeCotrbxKRC2qrzoo2hz_1Hw@mail.gmail.com>
 <b787119e15a218cc10a850f2c774fd328d53ef55@linux.dev>
X-Migadu-Flow: FLOW_OUT

April 16, 2025 at 01:37, "Ihor Solodrai" <ihor.solodrai@linux.dev> wrote:



>=20
>=20On 4/15/25 10:05 AM, Alexei Starovoitov wrote:
>=20
>=20>=20
>=20> On Tue, Apr 15, 2025 at 10:01 AM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
> >=20
>=20> >=20
>=20> > On 4/15/25 9:53 AM, Jiayuan Chen wrote:
> > >=20
>=20>=20
>=20>  April 16, 2025 at 24:33, "Ihor Solodrai" <ihor.solodrai@linux.dev>=
 wrote:
> >=20
>=20>  "sockmap_ktls disconnect_after_delete" test has been failing on BP=
F CI
> >=20
>=20>  after recent merges from netdev:
> >=20
>=20>  * https://github.com/kernel-patches/bpf/actions/runs/14458537639
> >=20
>=20>  * https://github.com/kernel-patches/bpf/actions/runs/14457178732
> >=20
>=20>  It happens because disconnect has been disabled for TLS [1], and i=
t
> >=20
>=20>  renders the test case invalid. Remove it from the suite.
> >=20
>=20>  [1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@k=
ernel.org/
> >=20
>=20>  Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >=20
>=20>  Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>  The original selftest patch used disconnect to re-produce the endl=
ess
> >  loop caused by tcp_bpf_unhash, which has already been removed.
> >  I hope this doesn't conflict with bpf-next...
> >=20
>=20> >=20
>=20> > I just tried applying to bpf-next, and it does indeed have a
> > >  conflict... Although kdiff3 merged it automatically.
> > >  What's the right way to resolve this? Send for bpf-next?
> > >=20
>=20>  What commit in bpf-next does it conflict with ?
> >  In general, avoiding merge conflicts is preferred.
> >=20
>=20https://web.git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/=
commit/?id=3D05ebde1bcb50a71cd56d8edd3008f53a781146e9
> https://lore.kernel.org/bpf/20250219052015.274405-1-jiayuan.chen@linux.=
dev/
> It adds tests in the same file. The code to delete simply moved.
> I think we can avoid conflict by applying 05ebde1bcb50 to bpf first,
> if that's an option (it might depend on other changes, idk).
> Then the version of the patch for bpf-next would apply to both trees.
> If not, then apply only to bpf-next, and disable the test on CI?
>


I'm not sure whether we can cherry-pick the commit to bpf branch.

I believe it would be more convenient for the maintainer to merge the
patch that only removes 'ASSERT_OK(err, "disconnect");', as this change
will not introduce conflicts with the bpf-next branch.
Once the bpf branch is merged into bpf-next, you can then remove the
entire function in the bpf-next branch.

