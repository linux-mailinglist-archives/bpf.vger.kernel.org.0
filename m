Return-Path: <bpf+bounces-56868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB1A9FA89
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 22:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F46188F93D
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2D91FE468;
	Mon, 28 Apr 2025 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/c9qRos"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A11CBEB9
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871957; cv=none; b=BruLl4755IA9AQZGhDWlndriU9/vZng75vSuXaxgdjPEEU8I3vCzzv0re0S9/t4vjPMM5TR589C3gWHiORMVOEErk9GeJajdUUoqS7dHSPuj2pNnGAzzxop/oPumO7NDRgtuB2CQFKET2Ezwwfql4CcVZxWXDMoPnaa/Xw6DwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871957; c=relaxed/simple;
	bh=8oA7iqCSzJ+oUsyevqov4ZAjEx0YJZOXYTTILrUZmrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VW9XlszY5FFB59pSt3ju02+TnlMLMsBp71Yg+Nc8f/epqlcnX1KV3KNDYENK1Qd08AXIl8V9yUrII32muAJ0t03EEOtQTPqDHW1MXJH+MPDNFtm5Myt3OJvcd00DadYHnxSeyo/oLwQpJ0WgskFYhZ/Ofwe0MJ6p/INDa0b0+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/c9qRos; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a064a3e143so2655697f8f.3
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745871954; x=1746476754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G/KgcXsRTltNePWSKk5BHKRBg2Y6saZ02hTzniH3z8=;
        b=c/c9qRosyBBMmBU9MpSXg///Zw2LAjGqs7Z/yoI10aAGONZANytyemiOdHFTSW5Fv3
         WfIEsML9t4ONXYvik0s4wAWnrh01Pat51UPjMiuvJ2KfPEnK6RDsrCZEFshrEMuUbJae
         K0PVshSkliewvWt9AgDfzkdIy83LE9Gy4knaRjM/4dYCwxIlQbq6SceaIBaI7PuJuIya
         U7WNJZtKioZbgyD37z0gYEv8IuaHgi7wxETGbunm1lUSe7SJ+8Bftxz2xeeNTyJvYgNt
         Pizo7VQMW4wqwL4NNjmcgJSrRvkiyGI3NBK3cSQvTZPG2lHE/386O7k8g4YSxlnC3PUX
         zDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871954; x=1746476754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G/KgcXsRTltNePWSKk5BHKRBg2Y6saZ02hTzniH3z8=;
        b=El9wsw1+tVfrJ37kmD54kG0H1KBKKZE2Yvmztfxs5Ash1gvDKDCfQ8Zpe5RDvRwW+T
         IUFdnf2gaQ5WVjEGOuiP4joXHphvbSzu2K1JEXBPPiheE9iFXnJc91HF0OFnxoa/nRAv
         7eNUo+AfYmp4AE1DAjwdRwBHJ8oKfQMhShkLHZyFFPw7ayutYRjBB+4vCirEiVciuA7O
         xmCRuPL+li4LHqXRN8+is1Uyvqu8mTvPEiTE/JX9mXqAXVlgk0OS6seuqkAqv/2zP00X
         ulCuhHNzpPXOyXHHRm62+lcGyU6TitVNxMkTsdghM9s2uxip3HoVHIIKD6xcP55MoEqm
         raEQ==
X-Gm-Message-State: AOJu0YzuESLzKpBv8Qhx1u6FfeXQbBrvyt9MsksmX6RbsKKciN/n8gmV
	imeJaVOh18sM4utA9O2uVtW55CG6hUinOZIhC51bb7skYbsoUrSCIMgSZ8a7ZNtY/+fgq6RaVVJ
	oCbiCP53E5SPiZb6/Uv2QYQ6hPzQBXXDl
X-Gm-Gg: ASbGncts4oAvi1oM2Uzl1b7yJ5kCZjlnW1Dktf2ft8w8CetX3yIjVYT6W52GYWXqZaS
	1LPPvhAP9ytn7zmHPK8HT90XIJSmm+GJsxOPglV6Sr51LLYS95+EjunlYajsPPXDJQ3b27KDPma
	rzPcIuMsG6Yi2Tpv2BQFTHpOGlWHED8+q8uxZ1LQ==
X-Google-Smtp-Source: AGHT+IFebDO77uSKVTATHIo/Ts0kJ178O6wALZbkNAMiyZ28VqB8gloPDr58ysyrfKIGWd4/AW3Q3OArrG+q4TXJ2m0=
X-Received: by 2002:a5d:5850:0:b0:39c:2665:2bfc with SMTP id
 ffacd0b85a97d-3a0894a3949mr1057950f8f.52.1745871953726; Mon, 28 Apr 2025
 13:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426104634.744077-1-eddyz87@gmail.com> <20250426104634.744077-4-eddyz87@gmail.com>
 <CAADnVQK1tP1_of=pn7HdeZNqmPu=4AqpRETeOVeQMjDfSt0NOw@mail.gmail.com> <m2plgwjdem.fsf@gmail.com>
In-Reply-To: <m2plgwjdem.fsf@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Apr 2025 13:25:42 -0700
X-Gm-Features: ATxdqUFAwxGKuOnubLK8qi-Oi2xrzp52K5iZNuqGUVOeJSqurcTOZP90fl1SUOo
Message-ID: <CAADnVQLEeFYR2B6DEWxCZ2T8oaNLSg7EyBTcx-8ox4Swb8WOCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: use SCC info instead of loop_entry
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:26=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
>
> It is simmetrical in a way.

is it possible to make them the same?

> Operations on bpf_verifier_state->branches:
> - do_check_common() initializes env->cur_state->branches =3D=3D 1
>   (and this is maintained as invariant);
> - push_stack() does env->cur_state->parent->branches++;
> - update_branch_counts() does env->cur_state->parent->branches--
>   (and continues recursively).
>
> Operations on bpf_scc_info->branches:
> - is_state_visited() does insn_scc(env->cur_state->parent->insn_idx)->bra=
nches++

But this is not the same as =3D 1 at init time.
do_check_common() does it for current state,
while this extra parent_scc_enter() in is_state_visited()
after a new state is created is doing it for the parent.
Which is not the same at all.
After new state is created st->branches =3D 1,
but scc(cur_idx)->branches =3D 0 while scc(parent->insn_idx) got incremente=
d
and now may be 1 or higher.

> - push_stack() does insn_scc(env->cur_state->parent->insn_idx)->branches+=
+;

this one is equivalent indeed.

> - update_branch_counts() does
>   insn_scc(env->cur_state->parent->insn_idx)->branches--
>   (and continues recursively);

But this one is not.
It's doing scc(parent)->branches-- only after st->branches reaches zero.
It's not touching scc(cur_idx)->branches at all.

> The main difference is that bpf_verifier_state->branches is initialized t=
o 1,
> while bpf_scc_info->branches is initialized to 0.
> Hence a call to parent_scc_enter() in is_state_visited().

Hmm, extra scc_enter doesn't look equivalent to init to 1.
Maybe scc branches need this different counting logic,
but being different from st->branches makes everything harder
to understand.
Maybe st->branches should be converted to this new counting?
Logically they are supposed to count the same thing.
Both are counting the number of branches being explored.
And push_stack() doing it exactly the same way for both is
a sign that they should be the same in decrements too.
But they're not.

