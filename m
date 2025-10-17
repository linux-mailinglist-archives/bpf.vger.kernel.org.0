Return-Path: <bpf+bounces-71252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C0CBEB5CE
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4B7435FAC8
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DC33321C5;
	Fri, 17 Oct 2025 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nks380I3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588D2F25F1
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728191; cv=none; b=m6VKV3OI252N/68ST9rY7bQE8knxO3edr9OLNFfVRHPGpcfubdFS4hjv3vzNjvNcTae1l0GwEl8GYvZn+obtqcmZ7QzKSHdbordFuuhE9a887sr+xHGKmJQKH6tI0mwd3NNOBUj47hDglkiS2WLc1TmazWwkQ/7R9Gs9tUJXz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728191; c=relaxed/simple;
	bh=KCABD4w0t8gLv0HiozyHA+Bi8jVP9HHsVSmtvGiRiJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJT/fZNXiKgulD/C2+Xd8/NveGem3avLgWmcjFdQlvptPZf/qH5lawE//hGhmCZvCUjT+SnLUNFE+AHH6wSTbmBZomayvql+eAG18ucESmCL2PJAfpGLxIIl6HFNldYsIKWKsYTZ7I6cHy5bh6dwsXBtEe2VuM0HwVt0HbW+b28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nks380I3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so3538265a12.1
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760728179; x=1761332979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w6xcg5ZfwkKJtV2cDgGZi8TpZWQKLXnlMjLfJHAv+8=;
        b=nks380I3wFOa0a0BaknfNt3gEGzqkEkN2Biz9pHDXtgRyfeM/bMNv7thKhwh5jjfSq
         A5TjTBQ5kHnzraswYPN611hegzheBpw+jW9XEaCf7onFaOvJs4X4EtO3LMfdrquCQVQ+
         fQwHSQbBDuEf1Yk+ozQTYo3wg3D7z4GvgGxV3K7N8WFU7RTFPg6OOAaU7TWn8i2BT8Z2
         EqWNMQb8aAaLt8+vaDaUO8u+zl7OnxAJazDroK7fZ8QwQhbZyTSMMpqXI0tn8JvdOJ4W
         gdm5Sn5IvNoV0rhPJ7Kx64QJ48KaHKnE9CMaF61ux0NmVu8w2IYcrEwA0aheXM/FXyhd
         a/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728179; x=1761332979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w6xcg5ZfwkKJtV2cDgGZi8TpZWQKLXnlMjLfJHAv+8=;
        b=Tv62ekMSOGn2HJV6Z0btKoPCUCnV169quY4UG5oX/5Glye77fCyA5DF+iL7XYRxlMs
         aBm04wAszgWFsKYBeF2vXYrT8UzcbigfqML/nz+kSpXh3CttGNbMc8lhQ5uAi9IVGwNM
         6TcrUAIgmqHlbX0OL2aPoLbXOuELE5ZpTVXSO+xbZol5Md9Vj8Z9r8oHNE93lvPQid1S
         LmkR9oOgpsB1ggeruJRqJHx5OkTMm/9f8KbD0yQqy33MiwjYtDrTEwGWsoTUh4oN0cOU
         eoSw5en0/ne8tSEDNuY2jYivXlv81MmdVAvABr0FiVQLlXKmLgyUrB8uCW7zfGUIW88E
         CiuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0lSrxHDVRMtXQAuKHMm+n3+GcbpY/0GuPoJaihykNQPeKwOsBLQcPtLcNAUEgs7ZVfX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26Do4zrm8iAK1p4/V1QVv++q3tDmgia2LPomTaod8obpHDGyc
	SF1n5PTPZCNIbQKgV9Wnb4d4V0MM1yZr7W088ORoTaLQ+agPknGYOuy/MM8FbYNdzu3/uqMSvsQ
	r4Y9x8PmmB+xDurPKgNAHGkGcJHaPsBA=
X-Gm-Gg: ASbGnctCfrGAtI1+YUCfo0vTx3LL9u2CqviWsdstTnkAV0rLoyXZwSmCR5l3Qs1C+3C
	b1TbqAAC/0CIxaC8iflhyCVlfli4x9JwJRMLpSzZaiaSwYB8j8eF7S2bj96s9jF6qs2NhMW9mQH
	d/xPnwmJryCDMWY73F/7zld5OsLlBc7pFO2Z3jA0kVgpehoJUfdWRhcKb29p7Y09oSS0R9XeFMg
	7WqL5mnJ936lpw8ASE6xFydxuS5wmz+xzGO+1uPkWgGQw3QKxhj2Wb4Q+vUATouB9uG6H7RzJcw
	TdAxQwOAHcn+roMaXlSCknXS4kU=
X-Google-Smtp-Source: AGHT+IG4B+/zdm/HHyMQrO/ifQAdI3NSMbkqVtNhxu1kJxNyIc3KjVolSGyYz/fZiA4PzMN7+QApYFKW0jdOi4DgNTw=
X-Received: by 2002:a05:6402:2706:b0:63c:3efe:d98a with SMTP id
 4fb4d7f45d1cf-63c3efeee48mr1766442a12.32.1760728178864; Fri, 17 Oct 2025
 12:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141727.51355-1-puranjay@kernel.org> <42bc3b8552fa2dec468747fc3e81a6b011222b84.camel@gmail.com>
In-Reply-To: <42bc3b8552fa2dec468747fc3e81a6b011222b84.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 17 Oct 2025 21:09:27 +0200
X-Gm-Features: AS18NWCPJA3N4clGGz18dKY2h6DAkaz8L0j9RSIEo-pJZ1nXDOeD5XkqTdm_6bw
Message-ID: <CANk7y0jgRC3W6hQzJjfX0NX1PrttcDxSZLcXdB1jo_qxTFTVZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix list_del() in arena list
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 8:35=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-10-17 at 14:17 +0000, Puranjay Mohan wrote:
> > The __list_del fuction doesn't set the previous node's next pointer to
> > the next node of the node to be deleted. It just updates the local vari=
able
> > and not the actual pointer in the previous node.
> >
> > The test was passing up till now because the bpf code is doing bpf_free=
()
> > after list_del and therfore reading head->first from the userspace will
> > read all zeroes. But after arena_list_del() is finished, head->first sh=
ould
> > point to NULL;
> >
> > If you remove the bpf_free() call in arena_list_del(), the test will st=
art
> > crashing because now the userpsace will read 0x100 (LIST_POISON1) in
> > head->first and segfault.
>
> I tried commenting out bpf_free() in arena_list_del() but the test
> passes for me even w/o this patch.  Is there a way to modify the test
> case, so that logic of the list_del() is checked more thoroughly?
>

For me after commenting bpf_free() in arena_list_del() I get:

[root@localhost bpf]# ./test_progs -a arena_list
#5       arena_list:FAIL
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x1c)[0x956fd4]
linux-vdso.so.1(__kernel_rt_sigreturn+0x0)[0xffff885b7820]
./test_progs[0x559f00]
./test_progs[0x55a728]
./test_progs(test_arena_list+0x28)[0x55aa7c]
./test_progs[0x957624]
./test_progs(main+0x6a0)[0x959298]
/lib64/libc.so.6(+0x30558)[0xffff87e62558]
/lib64/libc.so.6(__libc_start_main+0x9c)[0xffff87e6263c]
./test_progs(_start+0x30)[0x5522f0]

I pushed it to the CI so you can see it fail:
https://github.com/kernel-patches/bpf/actions/runs/18602175717/job/53043507=
792

Another thing you can do in addition to commenting bpf_free() is to also co=
mment

//n->next =3D LIST_POISON1;
//n->pprev =3D LIST_POISON2;

and now the test will not crash but fail like:

test_arena_list_add_del:FAIL:sum of list elems after del unexpected
sum of list elems after del: actual 499500 !=3D expected 0


This is because __list_del is a no-op, and after the poisoning logic
is commented list_del() becomes a no-op.
The list stays intact after arena_list_del() finishes.

Thanks,
Puranjay

