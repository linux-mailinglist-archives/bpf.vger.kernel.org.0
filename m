Return-Path: <bpf+bounces-50084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0F3A2274A
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D256F3A3EE6
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319BC9475;
	Thu, 30 Jan 2025 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2xHQrf/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02112F5B;
	Thu, 30 Jan 2025 00:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197857; cv=none; b=D4l/iptTeNMKXch0Gb/xgLevHxTckHKG/75B/CWe3JXngP6cRNtoz+hf1E9Aub2MPNzX0IK4jX7IuKjQb8tP9Q0BKCf75LOHTRxPtkbyDtHsq6bLGpBn203VyfneB0tmEFTT/fICoGkuLCEJJygsh8PFckD8ug8Pjtotd8Qwe/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197857; c=relaxed/simple;
	bh=R2UcQt9TM1/0XnzK/PGCOE/CMVnuNLX0f5AC7EgIJJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/4bJ3gGiYeemXyTN1cEZQOiHcpdviV7y5u7sSw7Ztc4LWzRptUI90g4txWcOcmY6t/GhxmimY4hvQkrSmXJLXZ2nJfOROGD1W2IM5F7QQa4Y6QtZB+/OKi9xkCTBrw45q9tWumZDLD7IalvckX3kC2QXXwE02JPUffbr8XyvlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2xHQrf/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so111740f8f.2;
        Wed, 29 Jan 2025 16:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738197854; x=1738802654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDdq98Gh7Xfi0KmBSzMAzs+26xmk/ObqN/JvexcpXFY=;
        b=b2xHQrf/eRhtcG2/FrkueSzyG97SEBP5Y9UssmblKYacOtxgSmi0QQGezTItgiB+mm
         n01fPCjP9rx+WeTH0hBczezbNoTwVUAxDdQG0gbVpCmtCIyfly7dkISQANhzJWi2j/vM
         QGoc30eMvdtSeE9Snn70lSDgUJPb+ODfDvHyHEANS6aSDWTWqXsTM7jfbRlKFE52vFps
         KAa9gmvMyUNE4VB32DLPkA/zTYj23J7O3PpwhRm6UWH/errBCgbblB43nDGaTDrtPF9O
         r5kc5UCX1lva4PvEKYm69NPYeL0Dabj4MBPgQ3ktrs80t1n0DukMycIkYRcUWRGO/6Gs
         Ixug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738197854; x=1738802654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDdq98Gh7Xfi0KmBSzMAzs+26xmk/ObqN/JvexcpXFY=;
        b=vR/O1Apeclc1R7hsYbGh7wEHNwn/vVq8mgy+mVpHyAGAuVMVbzZgsGHCo5F8KQ4AdS
         EtEA733h/9HuyoybCz0KdnkXmTQLQSxTHCwTyPEPPEARQQDk3YikwjeuW9y61xI891qi
         Ks9IG6hGBw4CuoMh5QpJoISCNr1he4pp13Tb71pEgZwOlHMHLoijpQclCd9KVE7mf/yR
         C3QEUqH1HA76N0sLxA8BwIz19ySnEik4/GH33xf/qbHjGvoefKtN4/invilT7Z+nI+he
         I4T7JKhVOxXn7lHNLq4IHtNSG3YlyMsTuo50yZeeagHaacv5ESvdDuzlueSyAB5NgYHO
         dGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Hi9LLWIioYsaXIGHpodlCqlEM5YdIdUomMKzlmgvcGXWh9OGKVPGECTdxZKnxkHn4H7rZPMgdPxg4AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJO3f1zYFAfYIzZexMFMxTD/aHhz7YvUGcUUV1SG3WgulmfWS
	AFWkfIcrQ9EvssEdMpYW1bu/mvpP/c2MrDJQaGLo9ARW0VcO5ZAqA5h6amiJrlZS3iDHCEElT9u
	/EQ5XjdqgiVyenDrmyojSAqvnpO0=
X-Gm-Gg: ASbGncue5azf2cyM5a6kce8wRQov5+fhA+3FajXwV6l/1M6zulvZdCD3TSWm+LGEMNF
	Hy4T3xMaOXflowvlP0xjFpzMspBsCCnCnl+ODYdl1Z4jLBe6ys80Vg3HYyNdIBJk9/+9k/zmXbH
	E78tZJmwqA1+rLaYM49ZlgLTekrcFI
X-Google-Smtp-Source: AGHT+IHTLpXG7F4IZvOw/5VhGKAERdVN2MiZZzoHY62PwcyimSgN2x3uMVyYZlnuvhHLYbjSsVpLTrZ8VBD7M5rpjNA=
X-Received: by 2002:adf:fc87:0:b0:386:3dad:8147 with SMTP id
 ffacd0b85a97d-38c51b5dd7emr3335812f8f.32.1738197853781; Wed, 29 Jan 2025
 16:44:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737763916.git.yepeilin@google.com> <e2072e24a6773b346f2a71c80b6a28d5b98e6194.1737763916.git.yepeilin@google.com>
In-Reply-To: <e2072e24a6773b346f2a71c80b6a28d5b98e6194.1737763916.git.yepeilin@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Jan 2025 16:44:02 -0800
X-Gm-Features: AWEUYZkPxVz1ETxSnwPu0PV_MBzXRADsiXTZQunQIcthoa6BSOZy9HLEix9hZko
Message-ID: <CAADnVQ+hi3918DUyA7bs4Va9NdNqXJg-R4A45n_MHGTikYaOSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 8/8] bpf, docs: Update instruction-set.rst for
 load-acquire and store-release instructions
To: Peilin Ye <yepeilin@google.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf@ietf.org, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 6:19=E2=80=AFPM Peilin Ye <yepeilin@google.com> wro=
te:
>
> Update documentation for the new load-acquire and store-release
> instructions.  Rename existing atomic operations as "atomic
> read-modify-write (RMW) operations".
>
> Following RFC 9669, section 7.3. "Adding Instructions", create new
> conformance groups "atomic32v2" and "atomic64v2", where:
>
>   * atomic32v2: includes all instructions in "atomic32", plus the new
>                 8-bit, 16-bit and 32-bit atomic load-acquire and
>                 store-release instructions
>
>   * atomic64v2: includes all instructions in "atomic64" and
>                 "atomic32v2", plus the new 64-bit atomic load-acquire
>                 and store-release instructions
>
> Cc: bpf@ietf.org
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>  .../bpf/standardization/instruction-set.rst   | 114 +++++++++++++++---
>  1 file changed, 98 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index ab820d565052..86917932e9ef 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -139,8 +139,14 @@ This document defines the following conformance grou=
ps:
>    specification unless otherwise noted.
>  * base64: includes base32, plus instructions explicitly noted
>    as being in the base64 conformance group.
> -* atomic32: includes 32-bit atomic operation instructions (see `Atomic o=
perations`_).
> -* atomic64: includes atomic32, plus 64-bit atomic operation instructions=
.
> +* atomic32: includes 32-bit atomic read-modify-write instructions (see
> +  `Atomic operations`_).
> +* atomic32v2: includes atomic32, plus 8-bit, 16-bit and 32-bit atomic
> +  load-acquire and store-release instructions.
> +* atomic64: includes atomic32, plus 64-bit atomic read-modify-write
> +  instructions.
> +* atomic64v2: unifies atomic32v2 and atomic64, plus 64-bit atomic load-a=
cquire
> +  and store-release instructions.
>  * divmul32: includes 32-bit division, multiplication, and modulo instruc=
tions.
>  * divmul64: includes divmul32, plus 64-bit division, multiplication,
>    and modulo instructions.
> @@ -653,20 +659,31 @@ Atomic operations are operations that operate on me=
mory and can not be
>  interrupted or corrupted by other access to the same memory region
>  by other BPF programs or means outside of this specification.
>
> -All atomic operations supported by BPF are encoded as store operations
> -that use the ``ATOMIC`` mode modifier as follows:
> +All atomic operations supported by BPF are encoded as ``STX`` instructio=
ns
> +that use the ``ATOMIC`` mode modifier, with the 'imm' field encoding the
> +actual atomic operation.  These operations are categorized based on the =
second
> +lowest nibble (bits 4-7) of the 'imm' field:
>
> -* ``{ATOMIC, W, STX}`` for 32-bit operations, which are
> +* ``ATOMIC_LOAD`` and ``ATOMIC_STORE`` indicate atomic load and store
> +  operations, respectively (see `Atomic load and store operations`_).
> +* All other defined values indicate an atomic read-modify-write operatio=
n, as
> +  described in the following section.
> +
> +Atomic read-modify-write operations
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The atomic read-modify-write (RMW) operations are encoded as follows:
> +
> +* ``{ATOMIC, W, STX}`` for 32-bit RMW operations, which are
>    part of the "atomic32" conformance group.
> -* ``{ATOMIC, DW, STX}`` for 64-bit operations, which are
> +* ``{ATOMIC, DW, STX}`` for 64-bit RMW operations, which are
>    part of the "atomic64" conformance group.
> -* 8-bit and 16-bit wide atomic operations are not supported.
> +* 8-bit and 16-bit wide atomic RMW operations are not supported.
>
> -The 'imm' field is used to encode the actual atomic operation.
> -Simple atomic operation use a subset of the values defined to encode
> -arithmetic operations in the 'imm' field to encode the atomic operation:
> +Simple atomic RMW operation use a subset of the values defined to encode
> +arithmetic operations in the 'imm' field to encode the atomic RMW operat=
ion:
>
> -.. table:: Simple atomic operations
> +.. table:: Simple atomic read-modify-write operations
>
>    =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>    imm       value  description
> @@ -686,10 +703,10 @@ arithmetic operations in the 'imm' field to encode =
the atomic operation:
>
>    *(u64 *)(dst + offset) +=3D src
>
> -In addition to the simple atomic operations, there also is a modifier an=
d
> -two complex atomic operations:
> +In addition to the simple atomic RMW operations, there also is a modifie=
r and
> +two complex atomic RMW operations:
>
> -.. table:: Complex atomic operations
> +.. table:: Complex atomic read-modify-write operations
>
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>    imm          value             description
> @@ -699,8 +716,8 @@ two complex atomic operations:
>    CMPXCHG      0xf0 | FETCH      atomic compare and exchange
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> -The ``FETCH`` modifier is optional for simple atomic operations, and
> -always set for the complex atomic operations.  If the ``FETCH`` flag
> +The ``FETCH`` modifier is optional for simple atomic RMW operations, and
> +always set for the complex atomic RMW operations.  If the ``FETCH`` flag
>  is set, then the operation also overwrites ``src`` with the value that
>  was in memory before it was modified.
>
> @@ -713,6 +730,71 @@ The ``CMPXCHG`` operation atomically compares the va=
lue addressed by
>  value that was at ``dst + offset`` before the operation is zero-extended
>  and loaded back to ``R0``.
>
> +Atomic load and store operations
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +To encode an atomic load or store operation, the lowest 8 bits of the 'i=
mm'
> +field are divided as follows::
> +
> +  +-+-+-+-+-+-+-+-+
> +  | type  | order |
> +  +-+-+-+-+-+-+-+-+
> +
> +**type**
> +  The operation type is one of:
> +
> +.. table:: Atomic load and store operation types
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +  type          value  description
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +  ATOMIC_LOAD   0x1    atomic load
> +  ATOMIC_STORE  0x2    atomic store
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +**order**
> +  The memory order is one of:
> +
> +.. table:: Memory orders
> +
> +  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  order    value  description
> +  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  RELAXED  0x0    relaxed
> +  ACQUIRE  0x1    acquire
> +  RELEASE  0x2    release
> +  ACQ_REL  0x3    acquire and release
> +  SEQ_CST  0x4    sequentially consistent
> +  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I understand that this is inspired by C,
but what are the chances this will map meaningfully to hw?
What JITs suppose to do with all other combinations ?

> +Currently the following combinations of ``type`` and ``order`` are allow=
ed:
> +
> +.. table:: Atomic load and store operations
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  imm       value  description
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  LOAD_ACQ  0x11   atomic load-acquire
> +  STORE_REL 0x22   atomic store-release
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Should we do LOAD_ACQ=3D1 and STORE_REL=3D2 and
do not add anything else?

