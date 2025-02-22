Return-Path: <bpf+bounces-52241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B42A40542
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 04:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885ED19E01BE
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 03:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFA51FF1D8;
	Sat, 22 Feb 2025 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebfUbpyT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550A2C182;
	Sat, 22 Feb 2025 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740193906; cv=none; b=MbiddbISsJk6LL2UUyIvbyQQxbr2u2PsezoPkdUhYGnoH2Cl+RiUYwMZmY8O6yvYF7QLmYjGOo4zvBTEjIL6ngKA0lE2uLH3sdubJH0YBb8jY6gMZNQOXUwzVnt7hLtJH3uynHMZbAX8/Wjly695VJyx9VwVGFnenimhXizpKlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740193906; c=relaxed/simple;
	bh=KH25QPo6a/QgEaHyS8kxRvjT9HJEzZrDsb3ku2utXMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6N4nkmwxb1E4uDXTMQLObp71mdqkm3ale4kPjnjC7WffAEzI9r+Dt6YlzN/gOBCf86OvNo8RicqNo1HxHEviyxImk8Rzdwu9/Vn6TNcMdWpBypWdEcBiRonu0bo400LnDu1y8ZcDXOA2xYdJk0ROFFv3hakc4dHTedLaXpf8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebfUbpyT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so17102735e9.1;
        Fri, 21 Feb 2025 19:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740193903; x=1740798703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWeCVs/LUULbQLdaOp27Hroq5hpYWQynHTMF6/hHolU=;
        b=ebfUbpyTrBTkYEPG9zk9AZU/A4bjMEADN+VhDn4fk7c2MpuJXfBoii9JA0dCBVb3gI
         wlY5r61YAjkiOnd05WZhqcJnQDnPJ8Zwmk1xqAJO5a1Q+Xp4q4Vgt5rSSFTOgf7Bah18
         TfawXA3PLfykwEO86S3L3ttAfaUzds7zt+7tfa2lYuD12753CSvRYrxAG4z+u0wWx5fO
         bBeRY8vgF1A2qnKhJP7WmWx4tdnH2zYelAq7v22a9j7TLF81+xLpN++CFc9wlrBLPxkD
         82hHJQxlqtE702eIFH0jYxfwRQHyGDAPO5rAHSahpC4xhra/eqyFQ+X04Frjgh1gcuNK
         m2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740193903; x=1740798703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWeCVs/LUULbQLdaOp27Hroq5hpYWQynHTMF6/hHolU=;
        b=gVlgtGREwzRnv+hp77T0PhTB8XzH+/OG4OHbSA3lddIvItw/qtBlSMZ50zTr+k1DpQ
         vUiXyv36oHgeUPCVptv7Bs9UkpUW+8q/zEzN6LLDqbuXqpDxCkdUmzD8DthY6oZEQFm6
         7vfwAmZ7dTpRmN0rsz5fGq1zFpWH/CgZW2RwsLJR6WAQIsoKh7x/n5Z+lj08VeyXDCZQ
         HPwLLO/gpBudD4oaXAWE7xM+6bEVNSSaotCVX6ogqe9Ffm/kJGIKun8JkDFK1htfeqp1
         LNNg6/3M0ALxhsx48r0iiExtJKpWQRI7PH/2vkdBol0C/uepAx/QQIg+lHO8Xz/XwHHa
         Ar+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvBIJODktbiCxE4Aknbu170trGyWjbC5vK2o2J1HbCQts8Sq+kGgCGizMddJXGvusuTxdpndZX7s1IuSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0y25HaAJNBhpfORCZwMofcyaHGxeMs8GLYajU76PDNONRlpxC
	hP//eEch7qyBGBv+ZpZ5WNaCakwRhv4Rvh2WHM7mvq4ApifOTEJF1MhHq4tV+uVw1zJTfyGKYLk
	sGsIo99pUvrjchISPWJnt4N1kBFU=
X-Gm-Gg: ASbGnctqbnwYsZTx9f4UWlq0YXarXE8G6zf+2gXlhMjj2psIZ+Grm5Enjc5iDn5KaHy
	VS4CiQuAricccZyaSYiWKqWiE8Sjy/QuCobR0SOHRNWvWdvL1ONf0QMQnEIAyVImK+w1B3IUSGT
	BFDMoocjI7oenKdxmHEpztoTs=
X-Google-Smtp-Source: AGHT+IFHd4FjvQqCrCtKgqnPKpghXHhZlzz58QS00WpJ2p2XRTL9M2RMPB6SCT69PYsT5XfrlmC6wGcJGaq0WN+opd4=
X-Received: by 2002:a5d:5350:0:b0:38f:2a84:7542 with SMTP id
 ffacd0b85a97d-38f6e97af1emr3987132f8f.28.1740193903162; Fri, 21 Feb 2025
 19:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740009184.git.yepeilin@google.com> <e2eb5c6912f292ed229aa4fb14e42d7f4c2f8571.1740009184.git.yepeilin@google.com>
In-Reply-To: <e2eb5c6912f292ed229aa4fb14e42d7f4c2f8571.1740009184.git.yepeilin@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Feb 2025 19:11:32 -0800
X-Gm-Features: AWEUYZlZHAk5-Pi4bkDG584UOJ60mu8CwbUKbEyBXUnO5vXzR3fB-Zakai_-2X0
Message-ID: <CAADnVQ+bJwwYKCU-HRWdgdfpc4pETxsVFtBOKAvfzLrR0Xvs4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/9] arm64: insn: Add load-acquire and
 store-release instructions
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
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 5:21=E2=80=AFPM Peilin Ye <yepeilin@google.com> wro=
te:
>
> Add load-acquire ("load_acq", LDAR{,B,H}) and store-release
> ("store_rel", STLR{,B,H}) instructions.  Breakdown of encoding:
>
>                                 size        L   (Rs)  o0 (Rt2) Rn    Rt
>              mask (0x3fdffc00): 00 111111 1 1 0 11111 1  11111 00000 0000=
0
>   value, load_acq (0x08dffc00): 00 001000 1 1 0 11111 1  11111 00000 0000=
0
>  value, store_rel (0x089ffc00): 00 001000 1 0 0 11111 1  11111 00000 0000=
0
>
> As suggested by Xu [1], include all Should-Be-One (SBO) bits ("Rs" and
> "Rt2" fields) in the "mask" and "value" numbers.
>
> It is worth noting that we are adding the "no offset" variant of STLR
> instead of the "pre-index" variant, which has a different encoding.
>
> Reference: Arm Architecture Reference Manual (ARM DDI 0487K.a,
>            ID032224),
>
>   * C6.2.161 LDAR
>   * C6.2.353 STLR
>
> [1] https://lore.kernel.org/bpf/4e6641ce-3f1e-4251-8daf-4dd4b77d08c4@huaw=
eicloud.com/
>
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>  arch/arm64/include/asm/insn.h |  8 ++++++++
>  arch/arm64/lib/insn.c         | 29 +++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.=
h
> index 2d8316b3abaf..39577f1d079a 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -188,8 +188,10 @@ enum aarch64_insn_ldst_type {
>         AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
>         AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
>         AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX,
> +       AARCH64_INSN_LDST_LOAD_ACQ,
>         AARCH64_INSN_LDST_LOAD_EX,
>         AARCH64_INSN_LDST_LOAD_ACQ_EX,
> +       AARCH64_INSN_LDST_STORE_REL,
>         AARCH64_INSN_LDST_STORE_EX,
>         AARCH64_INSN_LDST_STORE_REL_EX,
>         AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET,

Xu, Puranjay, other arm experts,

Please help review these patches.

Thanks!

