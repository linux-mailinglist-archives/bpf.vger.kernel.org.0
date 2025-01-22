Return-Path: <bpf+bounces-49521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA56A19834
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 19:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F17616307C
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374BD2153D6;
	Wed, 22 Jan 2025 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="d6KjX4Ai"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0894215186
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737569210; cv=none; b=SCpkdmGKVDWOBoqCTsagZNuoy2uFblhPiYA1BuvNm+hO1rSdh3tZk7QijiZwJtG/9KEKdriRveAit940wuW3NOjB1t7vzhZc09kw3rB8Ys1I2U9WVVF3gLq6Ra6mKVVkyEOxkVn9U+zRuwKwzUliY/yQvW1Od2+MybkWJfZj+/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737569210; c=relaxed/simple;
	bh=imr1m16tjYb+GGHBLPJM87NZf6BMT1c636p8Pkn1wYI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjMJupLHHpWqOR4vXkA1wfLkHybRv1BDuUs8vgFwI/quHwI39ulw2UBqJ0oZlVhLz5JoA7KjriNKLK5qdnaBTCLJhNIg5+vxJQzzvVrPXI2w6Icr+YaYkiy6HNYAF1eLccSH4VULZgcxcNerrP7Ps3AdzPK4/XBSdRLurfn9hNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=d6KjX4Ai; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737569206; x=1737828406;
	bh=imr1m16tjYb+GGHBLPJM87NZf6BMT1c636p8Pkn1wYI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=d6KjX4AiXRX2RtlK8xL5wiLfAKjspVL6WH9BpLGzryJSxaPU4jp7nGWEN5nljGpW1
	 B9RQ7tZq/JCJWDJkbFu9Z2t9gHg+D21sG4DjIxw+gevUaySigWgY3U7V9mGUPvYXwH
	 lDHDuZQm52gHb3S+GzHtUKczEd58+03FhiSW931lJ2FWRyq2iQsdUIu0wbrFvfoR1r
	 hSeZay6T35C6daHfRVZbiteeI6vp2He/y1XaWf9e2nD9925Y2+L8hShYm/SiZ5A77h
	 Pkty5JlnXXkHEB7KlM67fHxIFP26AG0fuQan41enkCte77/R1x+J8uskT7pvF2vD84
	 XhQreMfFqHLSg==
Date: Wed, 22 Jan 2025 18:06:42 +0000
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: Re: [PATCH bpf-next 0/5] BTF: arbitrary __attribute__ encoding
Message-ID: <EQX_MzPyzXAlkEpU09L1fHjlBN6I0iRFkNw2X7n4pW2r7ML4hoJ-XMX3oUsUkbCm1UZ0EBpkM7n_3ORDwiL0O1aQSaD6rJfFzBfnAwUJ34U=@pm.me>
In-Reply-To: <87msfjhy3v.fsf@oracle.com>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me> <87msfjhy3v.fsf@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: e952fa70d9ccd22bb270e136cb86ea898a911f5a
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, January 22nd, 2025 at 3:44 AM, Jose E. Marchesi <jose.marches=
i@oracle.com> wrote:

>=20
>=20
> > This patch series extends BPF Type Format (BTF) to support arbitrary
> > attribute encoding.
> >=20
> > Setting the kind_flag to 1 in BTF type tags and decl tags now changes
> > the meaning for the encoded tag, in particular with respect to
> > btf_dump in libbpf.
> >=20
> > If the kflag is set, then the string encoded by the tag represents the
> > full attribute-list of an attribute specifier [1].
>=20
>=20
> Why is extending BTF necessary for this? Type and declaration tags
> contain arbitrary strings, and AFAIK you can have more than one type tag
> associated with a single type or declaration. Why coupling the
> interpretation of the contents of the string with the transport format?
>=20
> Something like "cattribute:always_inline".

Hi Jose. Good questions.

You are correct that the tags can contain arbitrary strings already,
and that multiple tags can be associated with the same type or
declaration.

A specific problem I'm trying to solve is how to direct btf_dump in
interpreting tags as attributes, and do it in a generic way, as it's a
part of libbpf.

I discussed with Andrii, Eduard and Alexei a couple of approaches, and
tried some of them.

For example, a set of dump options could be introduced to handle
specific use-cases, similar to what you suggested in a
ATTR_PRESERVE_ACCESS_INDEX patch [1]. This is a valid approach,
however it is not very generic. An option will have to be introduced
and implemented for every new use-case.

A more generic approach is adding a set of callbacks to btf_dump. This
is a big design task, which I think should be avoided unless
absolutely necessary.

The benefit of this change - defining flagged tags as attributes - is
that it enables BTF to natively encode attributes as part of a type,
which is not possible currently. And it's a simple change.

Using the contents of the tag to indicate it's meaning (such as
"cattrubite:always_inline") will work too. However I don't think it's
desirable to have to parse the tag strings within libbpf, even more so
in BPF verifier.

In a discussion with Andrii we briefly entertained an idea of allowing
btf_dump to print the tag string directly (without requiring it to be
a tag or attribute), which would allow all kinds of hacks. Tempting,
but probably very bug-prone.

[1] https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle=
.com/

>=20
> > This feature will allow extending tools such as pahole and bpftool to
> > capture and use more granular type information, and make it easier to
> > manage compatibility between clang and gcc BPF compilers.
> >=20
> > [1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Attribute-Syntax.html
> >=20
> > Ihor Solodrai (5):
> > libbpf: introduce kflag for type_tags and decl_tags in BTF
> > libbpf: check the kflag of type tags in btf_dump
> > selftests/bpf: add a btf_dump test for type_tags
> > bpf: allow kind_flag for BTF type and decl tags
> > selftests/bpf: add a BTF verification test for kflagged type_tag
> >=20
> > Documentation/bpf/btf.rst | 27 +++-
> > kernel/bpf/btf.c | 7 +-
> > tools/include/uapi/linux/btf.h | 3 +-
> > tools/lib/bpf/btf.c | 87 +++++++---
> > tools/lib/bpf/btf.h | 3 +
> > tools/lib/bpf/btf_dump.c | 5 +-
> > tools/lib/bpf/libbpf.map | 2 +
> > tools/testing/selftests/bpf/prog_tests/btf.c | 23 ++-
> > .../selftests/bpf/prog_tests/btf_dump.c | 148 +++++++++++++-----
> > tools/testing/selftests/bpf/test_btf.h | 6 +
> > 10 files changed, 234 insertions(+), 77 deletions(-)


