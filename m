Return-Path: <bpf+bounces-36927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2255494F6BF
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 20:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29881F2190A
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B4819047C;
	Mon, 12 Aug 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0LJgXlg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F5D178381
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487427; cv=none; b=SJ/l4hFwLhZ4s92M6JpQxxFtfTbO2cJmY7VLNUVisHzr+AfTSnmMVDzuuQssbbVWpcH/9a4DtF3tGKxLo25+UG56y9R7/WNNv3YkFfFm/fFrPeQbhGkirTSNZszWVxCnawizNfANQBXAy+HhB6Ge3P7NH1NFDPN7E/gN11xADFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487427; c=relaxed/simple;
	bh=tNTab/CYh/1/1F7xVhB3MbJbY/RecdKQP/TtSAQCZZY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJKkERE6p104E7nwobjvgl2dzOlLGzIexo+YyUhtcIgbAIuLztrURIVqOEc6c44SkakCakDsu6kv1EIJATRd96LB+DxVzjyXlMcWMKhgTAiQv5kYRHuT9B0k5Jbz9A/UwMfeEZhLt1i3K8kXKq6BZViaxHmBwqMpBXcAxBUhZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0LJgXlg; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a10b293432so3300974a12.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723487425; x=1724092225; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tNTab/CYh/1/1F7xVhB3MbJbY/RecdKQP/TtSAQCZZY=;
        b=V0LJgXlgM8UzPyVPR2Zyx17Gc8RCksFivmw2HmlnOpSNEssZc09M0V+EqYVEFuX0+2
         ERPy5uXfL2u5xKGgd7+PLLeVjtxRiE/odQrrxmJqx1L60K2Hv4hpVtVdpqkQogaX4qNN
         13RsQP0alqG4UC1yb7DiYpjY/+p/s4enWyZqDpiXpsfvN9KvGdsx1WlADSQYf6lX0brc
         xphxsRB8r4V0qRLgK+sq0Iqqd8uPDVKEfEyjp3thBJgLHLBdLssBhC+tEpFyWerQeFDb
         DTTKkE6Tl/9qfENEzpC2MmXsktFYiFsJCGXUjfzrExYdTx0q22NdkFzle1/tOnqqtj2/
         TLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723487425; x=1724092225;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNTab/CYh/1/1F7xVhB3MbJbY/RecdKQP/TtSAQCZZY=;
        b=m3f7Hr6uoE7Ok9/CPMM1B5ee5f3LZ2nn8ggbEBDu49wlJqijy0V6GbCF+wGL+Srj9S
         m7GELGKPTDjaeOQSIFfzD30e1oD6XfLn9shse1eoGn1TWOfcdCXgBvFBGiSk7LEVFoMN
         lKIlmUFk2sM3ZlnQV6BbMjVk/fzEUPJScT6ZXObNIpyiBx8JYZzEJHPlQq2XdEFiwta3
         gf9tnkdozTFxLCWrwu2RHvTsSCmi43NxbvU/F1sPBaER71v/CvvrM8Ir6clPXoLnXHYG
         R+jxifFGZam08mDokPvDU8ZnpLc/hHPzkdOE19ngXdAjebAcrHs66C6LW3RM4BdDmeHP
         YIcw==
X-Gm-Message-State: AOJu0YxkFgNu7EnfLf/mMFCY+6Yd0MgN6bxSM5ERpWuJ0oo4GIVb0UTM
	wexOyzmKBi8GfWl03vqT8bc+Fl5fZiUkmWrRXPKkPIdqajm4FVt8
X-Google-Smtp-Source: AGHT+IGWhJGZ6+sEinNmVtaYhcAEt33nDmL9mD30+mbozJxyStKdQ4gvlL5T+kRO5k+hBraY85fg1Q==
X-Received: by 2002:a17:90b:4f42:b0:2cb:4b08:1bbe with SMTP id 98e67ed59e1d1-2d3926340b3mr1218749a91.30.1723487425113;
        Mon, 12 Aug 2024 11:30:25 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c5e053sm8838414a91.2.2024.08.12.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:30:24 -0700 (PDT)
Message-ID: <0b305ca5045a1adceec313b20f912f9666c1705c.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>,  Martin KaFai Lau
 <martin.lau@kernel.org>, Daniel Hodges <hodgesd@meta.com>
Date: Mon, 12 Aug 2024 11:30:19 -0700
In-Reply-To: <a4af06f9-5ea7-4541-90fd-1241043d5659@linux.dev>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
	 <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
	 <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
	 <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
	 <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com>
	 <a4af06f9-5ea7-4541-90fd-1241043d5659@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-12 at 11:26 -0700, Yonghong Song wrote:

[...]

>=20
> We could do the following to avoid double comparison: diff --git=20
> a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c index=20
> df3be12096cf..1906798f1a3d 100644 --- a/kernel/bpf/verifier.c +++=20
> b/kernel/bpf/verifier.c @@ -17338,10 +17338,13 @@ static bool=20
> stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old, */=
=20
> for (i =3D 0; i < old->allocated_stack; i++) { struct bpf_reg_state=20
> *old_reg, *cur_reg; + bool cur_exceed_bound; spi =3D i / BPF_REG_SIZE; -=
=20
> if (exact !=3D NOT_EXACT && + cur_exceed_bound =3D i >=3D=20
> cur->allocated_stack; + + if (exact !=3D NOT_EXACT && !cur_exceed_bound &=
&=20
> old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D=20
> cur->stack[spi].slot_type[i % BPF_REG_SIZE]) return false; @@ -17363,7=
=20
> +17366,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct=
=20
> bpf_func_state *old, /* explored stack has more populated slots than=20
> current stack * and these slots were used */ - if (i >=3D=20
> cur->allocated_stack) + if (cur_exceed_bound) return false; /* 64-bit=20
> scalar spill vs all slots MISC and vice versa. WDYT?
>=20

Yonghong, something went wrong with formatting of the above email,
could you please resend?

