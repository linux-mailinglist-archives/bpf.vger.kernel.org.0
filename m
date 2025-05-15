Return-Path: <bpf+bounces-58313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC883AB873D
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 15:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5131188B8B8
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730FF299AB2;
	Thu, 15 May 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YQ0YEZrS"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598029712C
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314021; cv=none; b=lRVEQlBQakwc4AKN7gPUxYt814KMkb/jF4oKofFTijNbL1oD4ouiv+ubr/1VJq65tuAcLbCadcbONVaBB7ivrzYEgcjcZlgGxG4vhpUUWuBGY8dH655GPGbXLVyZc3KsvMq65l9YtBYfZIPTi1nkVtdS4cO6Uu4UCAR+0EMnMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314021; c=relaxed/simple;
	bh=069WWNaBNOdGxapm5+teX/2X7XGRTzvIlToc1CqrwN0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Al1IgEy3xx8kdb41Eq+2bjpE2EVCw0+7LbjtVwM+H8XJRhI+2bvyVizu9MWdZVOkRCuI5VEyMczzydzCeWBbgWjwheb/0ASTaso4jDfasdKByFQL9NGd3TraNFHy/V8TZzJifsjLgZkVbK4lELMPliwsRnr9/2p8xuHQRDDhOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YQ0YEZrS; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747314013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdiS0ZXJtT9OI5f7vo+jFOFjHxyJbWuYbPxzzpD0umM=;
	b=YQ0YEZrSUMFiSnJJCYJFIPNGVsN9kQ0ZJ3iWRmm5ROi+oe0Z9KWLeyiKksBoTOP+W3W35c
	KT60cUqHELFpF+dC5y82hMj3vvMgoUn0cFLAT/P7jSPImvaaQ5+N5nyd9JTn0ujdMRvDE5
	UfmSsFQ69m7WgaME8eOHTbS/V/rGXgE=
Date: Thu, 15 May 2025 13:00:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <6a0524f8edd81f3bfafe8e139951b7ac78dd1fc0@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v2] bpftool: Add support for custom BTF path in
 prog load/loadall
To: "Quentin Monnet" <qmo@kernel.org>, bpf@vger.kernel.org
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Daniel
 Xu" <dxu@dxuuu.xyz>, "Mykyta Yatsenko" <yatsenko@meta.com>, "Tao Chen"
 <chen.dylane@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <d4e30634-b64e-47c7-9089-a37d20e29d2f@kernel.org>
References: <20250515065018.240188-1-jiayuan.chen@linux.dev>
 <d4e30634-b64e-47c7-9089-a37d20e29d2f@kernel.org>
X-Migadu-Flow: FLOW_OUT

May 15, 2025 at 17:17, "Quentin Monnet" <qmo@kernel.org> wrote:

>=20
>=202025-05-15 14:50 UTC+0800 ~ Jiayuan Chen <jiayuan.chen@linux.dev>
>=20
>=20>=20
>=20> This patch exposes the btf_custom_path feature to bpftool, allowing=
 users
> >=20
>=20>  to specify a custom BTF file when loading BPF programs using prog =
load or
> >=20
>=20>  prog loadall commands.
> >=20
>=20>=20=20
>=20>=20
>=20>  The argument 'btf_custom_path' in libbpf is used for those kernes =
that
> >=20
>=20
> Typo: "kernes"
>=20
>=20>=20
>=20> don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform =
CO-RE
> >=20
>=20>  relocations.
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  tools/bpf/bpftool/Documentation/bpftool-prog.rst | 7 ++++++-
> >=20
>=20>  tools/bpf/bpftool/bash-completion/bpftool | 2 +-
> >=20
>=20>  tools/bpf/bpftool/prog.c | 12 +++++++++++-
> >=20
>=20>  3 files changed, 18 insertions(+), 3 deletions(-)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/to=
ols/bpf/bpftool/Documentation/bpftool-prog.rst
> >=20
>=20>  index d6304e01afe0..e60a829ab8d0 100644
> >=20
>=20>  --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> >=20
>=20>  +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> >=20
>=20>  @@ -127,7 +127,7 @@ bpftool prog pin *PROG* *FILE*
> >=20
>=20>  Note: *FILE* must be located in *bpffs* mount. It must not contain=
 a dot
> >=20
>=20>  character ('.'), which is reserved for future extensions of *bpffs=
*.
> >=20
>=20>=20=20
>=20>=20
>=20>  -bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map {=
 idx *IDX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] =
[pinmaps *MAP_DIR*] [autoattach]
> >=20
>=20>  +bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map {=
 idx *IDX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] =
[pinmaps *MAP_DIR*] [autoattach] [kernel_btf *BTF_DIR*]
> >=20
>=20>  Load bpf program(s) from binary *OBJ* and pin as *PATH*. **bpftool=
 prog
> >=20
>=20>  load** pins only the first program from the *OBJ* as *PATH*. **bpf=
tool prog
> >=20
>=20>  loadall** pins all programs from the *OBJ* under *PATH* directory.=
 **type**
> >=20
>=20>  @@ -153,6 +153,11 @@ bpftool prog { load | loadall } *OBJ* *PATH* =
[type *TYPE*] [map { idx *IDX* | na
> >=20
>=20>  program does not support autoattach, bpftool falls back to regular=
 pinning
> >=20
>=20>  for that program instead.
> >=20
>=20>=20=20
>=20>=20
>=20>  + The **kernel_btf** option allows specifying an external BTF file=
 to replace
> >=20
>=20>  + the system's own vmlinux BTF file for CO-RE relocations. NOTE th=
at any
> >=20
>=20>  + other feature (e.g., fentry/fexit programs, struct_ops, etc) wil=
l require
> >=20
>=20
> Nit: No need for both "e.g." and "etc", they're redundant.
>=20
>=20>=20
>=20> + actual kernel BTF like /sys/kernel/btf/vmlinux.
> >=20
>=20>  +
> >=20
>=20
> Can we rephrase the second part of the paragraph a little bit please?
>=20
>=20=E2=80=9CAny other feature=E2=80=9D could be clearer, how about:
>=20
>=20 Note that any other feature relying on BTF (such as fentry/fexit
>=20
>=20 programs, struct_ops) requires the BTF file for the actual
>=20
>=20 kernel running on the host, often exposed at
>=20
>=20 /sys/kernel/btf/vmlinux.
>=20
>=20>=20
>=20> Note: *PATH* must be located in *bpffs* mount. It must not contain =
a dot
> >=20
>=20>  character ('.'), which is reserved for future extensions of *bpffs=
*.
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf=
/bpftool/bash-completion/bpftool
> >=20
>=20>  index 1ce409a6cbd9..609938c287b7 100644
> >=20
>=20>  --- a/tools/bpf/bpftool/bash-completion/bpftool
> >=20
>=20>  +++ b/tools/bpf/bpftool/bash-completion/bpftool
> >=20
>=20>  @@ -511,7 +511,7 @@ _bpftool()
> >=20
>=20>  ;;
> >=20
>=20>  *)
> >=20
>=20>  COMPREPLY=3D( $( compgen -W "map" -- "$cur" ) )
> >=20
>=20>  - _bpftool_once_attr 'type pinmaps autoattach'
> >=20
>=20>  + _bpftool_once_attr 'type pinmaps autoattach kernel_btf'
> >=20
>=20>  _bpftool_one_of_list 'offload_dev xdpmeta_dev'
> >=20
>=20>  return 0
> >=20
>=20>  ;;
> >=20
>=20
> Correct, but right before this could you also add the following, please=
:
>=20
>=20 @@ -505,13 +505,13 @@ _bpftool()
>=20
>=20 _bpftool_get_map_names
>=20
>=20 return 0
>=20
>=20 ;;
>=20
>=20 - pinned|pinmaps)
>=20
>=20 + pinned|pinmaps|kernel_btf)
>=20
>=20 _filedir
>=20
>=20 return 0
>=20
>=20 ;;
>=20
>=20 *)
>=20
>=20This will make the completion offer file names after the user has typ=
ed
>=20
>=20"kernel_btf".
>=20
>=20>=20
>=20> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> >=20
>=20>  index f010295350be..3b6a361dd0f8 100644
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
>=20>  + } else if (is_prefix(*argv, "kernel_btf")) {
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
>=20>  } else {
> >=20
>=20>  - p_err("expected no more arguments, 'type', 'map' or 'dev', got: =
'%s'?",
> >=20
>=20>  + p_err("expected no more arguments, "
> >=20
>=20>  + "'type', 'map', 'dev', 'offload_dev', 'xdpmeta_dev', 'pinmaps', =
"
> >=20
>=20>  + "'autoattach', or 'kernel_btf', got: '%s'?",
> >=20
>=20
> Some of them were missing, thanks for this! Can you remove "dev" from
>=20
>=20the list, please? It's been deprecated in favour of "offload_dev", to
>=20
>=20avoid confusion with "xdpmeta_dev".
>=20
>=20pw-bot: cr
>=20
>=20>=20
>=20> *argv);
> >=20
>=20>  goto err_free_reuse_maps;
> >=20
>=20>  }
> >=20
>=20>  @@ -2474,6 +2483,7 @@ static int do_help(int argc, char **argv)
> >=20
>=20>  " [map { idx IDX | name NAME } MAP]\\\n"
> >=20
>=20>  " [pinmaps MAP_DIR]\n"
> >=20
>=20>  " [autoattach]\n"
> >=20
>=20>  + " [kernel_btf BTF_DIR]\n"
> >=20
>=20>  " %1$s %2$s attach PROG ATTACH_TYPE [MAP]\n"
> >=20
>=20>  " %1$s %2$s detach PROG ATTACH_TYPE [MAP]\n"
> >=20
>=20>  " %1$s %2$s run PROG \\\n"
> >=20
>=20
> Thanks,
>=20
>=20Quentin
>

Thank you, Quentin. Your suggestions are all very valuable; I will make t=
he updates.

