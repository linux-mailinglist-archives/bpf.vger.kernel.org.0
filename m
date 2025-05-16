Return-Path: <bpf+bounces-58400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9710DAB9E8F
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 16:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EB31BA423A
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871FB1898FB;
	Fri, 16 May 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cDMw83iV"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B309139579
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405512; cv=none; b=s/4qvCWmqxQypA7u4VQ0Az7Cmr34cFYTc51jBgCoUeMng5ebJqwgCSB7to4mk825VGFKUbIzjIC21ZNF5CwL8fIx0dvU0hj074I9mxkWa20OTqbpjqfg9Nn5E9zi0jVeMXijVzd29ukXhqotvHNjl7JzoXygypkDVHj7pGOYl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405512; c=relaxed/simple;
	bh=hrReH2jGvQHny3ykPDMYACbqAQgW8ptMXM7fL/tLWiY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Zg5TTPIVbfCR02XNH2U8IPUO1Ks6NCx8PFhi50iGN/VapxkLMfffMnacUKczF3eSJeowfWJHB3+4PynR3S7+FYvPwB1Ck89rhs6PHI3w5iTKRrtOGO+PM/2neBX6NM48gvIHC7r3ikLK04QLea6d3sGl3GgZbKyvqpML6VjK/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cDMw83iV; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747405507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKkAVatZ2HHNRWcHYXBGZ0YwjqLGENd5JjCFRO8tD0k=;
	b=cDMw83iVLipwxkdNTEuoHcqbvX4UxYcRhAsgiOIVlZwmymTcIFtUYo+AC+lDW6laYifmhY
	qFQLrGkernjWe4AhrLyO4A3+5VBNclx19CF15jMN0X+0e5r3IINKamSQpv/6SC5saKmLAL
	Ke5KlJn8609CSkB32IS+RAt+LvUVpkk=
Date: Fri, 16 May 2025 14:24:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <34548935cee31721946bf7c1c772f71720e0683c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3] bpftool: Add support for custom BTF path in
 prog load/loadall
To: "Quentin Monnet" <qmo@kernel.org>, bpf@vger.kernel.org
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Mykyta
 Yatsenko" <yatsenko@meta.com>, "Daniel Xu" <dxu@dxuuu.xyz>, "Tao Chen"
 <chen.dylane@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9909038f-a005-440a-82f2-ebe2f2da0767@kernel.org>
References: <20250516032312.275261-1-jiayuan.chen@linux.dev>
 <9909038f-a005-440a-82f2-ebe2f2da0767@kernel.org>
X-Migadu-Flow: FLOW_OUT

May 16, 2025 at 18:18, "Quentin Monnet" <qmo@kernel.org> wrote:

>=20
>=202025-05-16 11:23 UTC+0800 ~ Jiayuan Chen <jiayuan.chen@linux.dev>
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
>=20>  The argument 'btf_custom_path' in libbpf is used for those kernels=
 that
> >=20
>=20>  don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform=
 CO-RE
> >=20
>=20>  relocations.
> >=20
>=20>=20=20
>=20>=20
>=20>  Suggested-by: Quentin Monnet <qmo@kernel.org>
> >=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>=20=20
>=20>=20
>=20>  ---
> >=20
>=20>  V2 -> V3: Optimized document grammar and some prompts
> >=20
>=20>  https://lore.kernel.org/bpf/20250515065018.240188-1-jiayuan.chen@l=
inux.dev/
> >=20
>=20>  V1 -> V2: Added bash completion and documentation
> >=20
>=20>  https://lore.kernel.org/bpf/20250513035853.75820-1-jiayuan.chen@li=
nux.dev/
> >=20
>=20>  ---
> >=20
>=20>  tools/bpf/bpftool/Documentation/bpftool-prog.rst | 8 +++++++-
> >=20
>=20>  tools/bpf/bpftool/bash-completion/bpftool | 4 ++--
> >=20
>=20>  tools/bpf/bpftool/prog.c | 12 +++++++++++-
> >=20
>=20>  3 files changed, 20 insertions(+), 4 deletions(-)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/to=
ols/bpf/bpftool/Documentation/bpftool-prog.rst
> >=20
>=20>  index d6304e01afe0..4dce43e8e8a3 100644
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
[pinmaps *MAP_DIR*] [autoattach] [kernel_btf *BTF_FILE*]
> >=20
>=20
> Woops, I just realised we also need to add kernel_btf to the command
>=20
>=20summary at the top of the document (line 34), sorry for missing it

It was my mistake to miss that part. I'll prepare an updated version soon=
. :)

Thanks.
> during the previous pass. Please add it, and mark v4 as:
>=20
>=20 Reviewed-by: Quentin Monnet <qmo@kernel.org>
>=20
>=20Thanks!
>

