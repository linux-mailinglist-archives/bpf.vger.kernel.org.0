Return-Path: <bpf+bounces-58268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A02AB7AE0
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 03:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7394C7E5A
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 01:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C6924C68D;
	Thu, 15 May 2025 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qOPexvw7"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80F1F428F
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747271537; cv=none; b=D8aR/ZdZaBdCjNgAHILUDTavE0pHkfSoP0yg01ORmRr0By3lBb07rvisEcum5ZUIXJkCRhRC5dvKOxady15CYpK0vdtCTp1wTdjqfXeF0W2DQaJburmygVqH48YumtYlNu9ocsWaHAirYwhV5G/YL8eWyFA2t1exFwL0SxbGoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747271537; c=relaxed/simple;
	bh=D1rx01yZKWZ6BsWNczdwodQ1O/T7byxtmJUNHsXsGHM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=iV5IXG3h2nMeqWmxcwaaxSxs+CdSQBSh9d6S3WGcadth3vvvdlUZhHH/UnmILYf166ruUfRCKrvuP/rDHR39dBRLI5+HBN8SxFUNvZSiAAc1YEdAtm6FVqY19HddG6Q85Ge7l1WoeRGR42gn+NleqI5cCN31Jzt1jHzAhR/5tv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qOPexvw7; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747271523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lMzi0iMSCHBJmo12eN9sG015kcqrrRkSl3P+z3U2WA=;
	b=qOPexvw76qTa8KiqLZQYBDMvMQLcI0Cnq8jrkM3k9Mq6JqgOByhUmxRWBl8r/eu7MkYNZ2
	KGZe/Qf4OpmrE2DrnXcv/eA8NXwcaczxE3Z8jFmmCEEgNFnLEzajttroFDxXKCyZ4PwtdV
	gYImluiQsqHZSZcYVnngFevVvLLqfG0=
Date: Thu, 15 May 2025 01:11:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <52f83eb9cf83f9b09da785d77457db8a930d21ca@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for custom BTF path in
 prog load/loadall
To: "Quentin Monnet" <qmo@kernel.org>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "bpf"
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>
In-Reply-To: <988679f5-12ac-4288-87a9-bc0259bd0280@kernel.org>
References: <20250513035853.75820-1-jiayuan.chen@linux.dev>
 <CAADnVQJJ7pLsm0UTzPOj1H+rdaaY7Lv0As0Te-b+7zieQbntkw@mail.gmail.com>
 <4741dfb9fa4cf32cef28d9f2b7e7c2e788430800@linux.dev>
 <CAEf4BzZdAft9HUc2MOoQqC_SwkiBQgRTPZHB8MJmwVTY8N=sWQ@mail.gmail.com>
 <988679f5-12ac-4288-87a9-bc0259bd0280@kernel.org>
X-Migadu-Flow: FLOW_OUT

2025/5/15 24:52, "Quentin Monnet" <qmo@kernel.org> wrote:

>=20
>=202025-05-14 09:39 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.co=
m>
>=20
>=20>=20
>=20> On Tue, May 13, 2025 at 6:51 PM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
> >=20
>=20> >=20
>=20> > 2025/5/14 05:19, "Alexei Starovoitov" <alexei.starovoitov@gmail.c=
om> wrote:
> > >=20
>=20>=20
>=20>  On Mon, May 12, 2025 at 8:59 PM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
> >=20
>=20>  This patch exposes the btf_custom_path feature to bpftool, allowin=
g users
> >=20
>=20>  to specify a custom BTF file when loading BPF programs using prog =
load or
> >=20
>=20>  prog loadall commands. This feature is already supported by libbpf=
, and
> >=20
>=20>  this patch makes it accessible through the bpftool command-line in=
terface.
> >=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  tools/bpf/bpftool/prog.c | 11 ++++++++++-
> >=20
>=20>  1 file changed, 10 insertions(+), 1 deletion(-)
> >=20
>=20>  diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> >=20
>=20>  index f010295350be..63f84e765b34 100644
> >=20
>=20>  --- a/tools/bpf/bpftool/prog.c
> >=20
>=20>  +++ b/tools/bpf/bpftool/prog.c
> >=20
>=20>  @@ -1681,8 +1681,17 @@ static int load_with_options(int argc, char=
 **argv, bool first_prog_only)
> >=20
>=20>  } else if (is_prefix(*argv, "autoattach")) {
> >=20
>=20>  auto_attach =3D true;
> >=20
>=20>  NEXT_ARG();
> >=20
>=20>  + } else if (is_prefix(*argv, "custom_btf")) {
> >=20
>=20>  + NEXT_ARG();
> >=20
>=20>  +
> >=20
>=20>  + if (!REQ_ARGS(1))
> >=20
>=20>  + goto err_free_reuse_maps;
> >=20
>=20>  +
> >=20
>=20>  + open_opts.btf_custom_path =3D GET_ARG();
> >=20
>=20>  I don't see a use case yet.
> >=20
>=20>  What exactly is the scenario where it's useful ?
> >=20
>=20> >=20
>=20> > This patch just exposes the btf_custom_path feature of libbpf to =
bpftool.
> > >=20
>=20> >  The argument 'btf_custom_path' in libbpf is used for those kerne=
s that
> > >=20
>=20> >  don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perfo=
rm CO-RE
> > >=20
>=20> >  relocations. Specifically for older kernels, separate BTF files =
are already
> > >=20
>=20> >  provided: https://github.com/aquasecurity/btfhub-archive/.
> > >=20
>=20> >  If we want load prog using bpftool on those systems, we have to =
hack
> > >=20
>=20> >  btf__load_vmlinux_btf() before or write custom loader with libbp=
f and specify
> > >=20
>=20> >  'btf_custom_path'.
> > >=20
>=20> >  I also found a the similar topic:
> > >=20
>=20> >  https://lore.kernel.org/bpf/20220215225856.671072-1-mauricio@kin=
volk.io/
> > >=20
>=20> >  Additionally, pwru supports "--kernel-btf" which serves the same=
 purpose as
> > >=20
>=20> >  this patch.
> > >=20
>=20> >  Therefore, using an external BTF file is a common practice.
> > >=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  I think it's fine to expose this to bpftool. But maybe call the op=
tion
> >=20
>=20>  "kernel_btf" to make it more obvious that this is BTF representing
> >=20
>=20>  kernel types, as opposed to program BTF itself.
> >=20
>=20

"kernel_btf" is better, thanks.

> Hi Jiayuan, we'll also need to update the documentation (the man page,
>=20
>=20in the summary at the top and in the subcommand description), the
>=20
>=20interactive help message at the bottom of bpftool's prog.c, and the b=
ash
>=20
>=20completion (I can help with it if necessary), please.
>=20
>=20Thanks,
>=20
>=20Quentin
>

Thank you for pointing that out. I did miss those parts, and I also
noticed that others had overlooked similar issues. I will address all
the subcommands of "load prog" in this update.

