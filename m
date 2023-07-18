Return-Path: <bpf+bounces-5194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA39A7588DD
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956B9281765
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 23:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608017AB9;
	Tue, 18 Jul 2023 23:06:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808915AC4
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 23:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680D9C433C8;
	Tue, 18 Jul 2023 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689721574;
	bh=FRBVwYwMTH6DRU2yrJWUYe8eJeOEgS3bml4SVg7PNv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iXOJgUVurChgFDetfjkgCXYdQd4Ql0w1h3kC+ujYEntHyJs5s179RrLIz2Cq0PguO
	 2CmYdNomq/OQ/IXK/IzTrWWIpu3uvoWIBnCbjn92elYM6UPygsk6nRRyypBDXwq5Zw
	 ovtjZoq0XnD2Agg+fywfoE2rj++jUuRuVfS7H5sPXkUjDH78IHM+z5fS5VJYNG39bR
	 zq15evNi+lGQsKIk0OYwl/YYHm1nn9Npx+tOoMd2R23YGCsdsBJQtL80jQVA4nl7Mf
	 pWMRuQtPcfmMAjYfggWpjAsxuaZo7H8UnfMueznFvpfpMYxC7iNoGfPYdSGdw9jLV/
	 YZBccR8Vl3FJw==
Date: Tue, 18 Jul 2023 16:06:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, LKML <linux-kernel@vger.kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
Message-ID: <20230718160612.71f09752@kernel.org>
In-Reply-To: <CAADnVQLJBiB7pWDTDNgQW_an+YoB61xkNEsa5g8p6zTy-mAG7Q@mail.gmail.com>
References: <20230502005218.3627530-1-drosen@google.com>
	<20230718082615.08448806@kernel.org>
	<CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
	<20230718090632.4590bae3@kernel.org>
	<CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
	<20230718101841.146efae0@kernel.org>
	<CAADnVQ+jAo4V-Pa9_LhJEwG0QquL-Ld5S99v3LNUtgkiiYwfzw@mail.gmail.com>
	<20230718111101.57b1d411@kernel.org>
	<CAADnVQLJBiB7pWDTDNgQW_an+YoB61xkNEsa5g8p6zTy-mAG7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jul 2023 13:34:06 -0700 Alexei Starovoitov wrote:
> > Direct packet access via skb->data is there for those who want high
> > speed =F0=9F=A4=B7=EF=B8=8F =20
>=20
> skb->data/data_end approach unfortunately doesn't work that well.
> Too much verifier fighting. That's why dynptr was introduced.

I wish Daniel told us more about the use case.

> > My worry is that people will think that whether the buffer is needed or
> > not depends on _their program_, rather than on the underlying platform.
> > So if it works in testing without the buffer - the buffer must not be
> > required for their use case. =20
>=20
> Are you concerned about bpf progs breaking this way?

Both, BPF progs breaking and netdev code doing things which don't make
sense. But I won't argue too hard about the former, i.e. the BPF API.

> I thought you're worried about the driver misusing
> skb_header_pointer() with buffer=3D=3DNULL.
>=20
> We can remove !buffer check as in the attached patch,
> but I don't quite see how it would improve driver quality.

The drivers may not be pretty but they aren't buggy AFAICT.

> [0001-bpf-net-Introduce-skb_pointer_if_linear.patch  application/octet-st=
ream (2873 bytes)]=20

Or we can simply pretend we don't have the skb:

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 91ed66952580..217447f01d56 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4023,7 +4023,7 @@ __skb_header_pointer(const struct sk_buff *skb, int o=
ffset, int len,
 	if (likely(hlen - offset >=3D len))
 		return (void *)data + offset;
=20
-	if (!skb || !buffer || unlikely(skb_copy_bits(skb, offset, buffer, len) <=
 0))
+	if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
 		return NULL;
=20
 	return buffer;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9e80efa59a5d..8bc4622cc1df 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2239,7 +2239,13 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_=
dynptr_kern *ptr, u32 offset
 	case BPF_DYNPTR_TYPE_RINGBUF:
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
-		return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__=
opt);
+	{
+		const struct sk_buff *skb =3D ptr->data;
+
+		return __skb_header_pointer(NULL, ptr->offset + offset, len,
+					    skb->data, skb_headlen(skb),
+					    buffer__opt);
+	}
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr =3D bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);

