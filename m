Return-Path: <bpf+bounces-70109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05607BB10C1
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 17:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB31189054E
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A84274FDF;
	Wed,  1 Oct 2025 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBXsiR/F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5618DB01
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332182; cv=none; b=QgsWnJ8sJq4JVe/Gj3hKiMjxo1kAcJX8nTv5itgcMK952M1GSJgKxdzcvwZ1P3nwDGCBGz0M6POmPL7u+p7fLmFWd6SOlfWPc5awMtThN0GxeoB5bh5wpJNKLLU3o/zbiZu5eNCOuANfQhlyYfOubKY1aQImTlDH1rq3+I8Cd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332182; c=relaxed/simple;
	bh=4i/ZHfY0OuqQaRnlloO+bz2QXJuNBx3tcq0vR2Bb8tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljKMuHLw9NQfiwlr8p30agwCnhX9AtVBAO0afvH2bTARCPkmE7jQZ87iOsRC6gZANw0+o7snD30vMRfB4a5EpPmNH4geNZMnCQklYGfQ5y9UPcapnyUKoc+YpSmy/T59U8W/9nEJ96Yc4rgQ1tKFf5j6vn9xlGz+V03/Ars9XNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBXsiR/F; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso4161744f8f.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759332179; x=1759936979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wffe33p+NClD91cA87mFK8NWRr2v+E0eg06RfzieN64=;
        b=GBXsiR/FNysLouXLN906o1Ip2RZYMg4u8zfSibWRemIorb0pG/yaH8sV/lmr7BK4Or
         gLK1pXgP8iEsmtLHXwIq7M20mJHohimz+lIG5kA8pbDeXAg/GPCrMRHk7Pquz61iLtfv
         AmY0GnlmwIK8FPquhtQFhkSLrSXECIRZM1O6jksg95oaY9bM+xkqVOTuer2NLzgUgALa
         8NPmxnOFsm2zpaC6fXEDC01wGhBVZrm1opKCEWlgKA/kHhmAxqYdvxLUa7R+mF7ojFNY
         8ErDbKWHfTeyLP9IyCrvyNnn6sj7bc9sLWZVC783QjWaxkCJLlBsxN5d+1mZ+o6I4HmR
         9eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759332179; x=1759936979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wffe33p+NClD91cA87mFK8NWRr2v+E0eg06RfzieN64=;
        b=fDoyUFSSEBEnlGoxCpLEUjo3MHbiw8UXTMuYdPwbSifgyH1Ah2RGIXVcGSEbVcacAi
         v8gWy+FhPb5uwyi1OnTdI8QVNXNz9YDIcVD0CdTHGjipYTBb9zmzL7WAV9uSt7sOlPhs
         0IEoUGeizENQ0h54KX8WMaWIEGFlx/GdudoG4qrIc05ApxR45qd+kxL3/fd9Qn/XFVqu
         k1vcDw8WmTWfDwjOuvJmzx/4WWgVVmPc9/B/D/QogVTpkySBjIuWJJoneYO/Cr5dV9DZ
         2zbYCkAHhaX3xEA+hl99k1eoskk/ZsNyNI0MI+5TUNva75HmiLodNrENXlCGUFSpR+AJ
         NlQw==
X-Gm-Message-State: AOJu0YxhKUvlOl7fyjj9DrNZeBFqKKHViHDvS8O/ZL9HU8vYzBTcLO9D
	XKBVnEYpemR/3DEn/6S1yWCIqvfp4jLNp9hu2xE0JVks0BqZ4r4lqufQTzNvcQ7WY+lF+6l9smv
	7bupvqgT33rJaF6JKOALr+brAyLAZLug=
X-Gm-Gg: ASbGncvuE3rzQqIefS9S6BRcO7cxU64DYCPdalP4ClZm19OTkDKX2Emq6Vs3+ZPDMSc
	Ag9hURwBGHOu9FcIQLgD0kJYMnLG8EdHNhfiZ6Co2Ia12E0pFW2NSo4YGt4bpdtWp9fxTtQup14
	uUDcWJ6booe2UA1SjxzCAntxRB8i6pjFx9DPRmBOWbMY3CnQE5wbopr3ZQv00xM1tKYnT3AO/Dx
	xZt4awxYjJNu7R0VDKaG3vNgYAevsjK5qkNi3oYbMqpqgUnquPbL3Bk+UEhFiqty4y11i0=
X-Google-Smtp-Source: AGHT+IHJUYzRCbseEAyQLGnTgx0dsCtMLLeX9njXQudWiwuAkcims/7N5buukJ8AQLzUbcG9A8F83/aXO589yH2HnFA=
X-Received: by 2002:a05:6000:26c3:b0:3ee:15c6:9a6b with SMTP id
 ffacd0b85a97d-4255781aa57mr2793840f8f.48.1759332179115; Wed, 01 Oct 2025
 08:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com>
In-Reply-To: <tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 08:22:47 -0700
X-Gm-Features: AS18NWDqEtkpA562jANIuChGT7I76yUYGFMKTEl8-v78sGsnbi1vR1KST2m_T9I
Message-ID: <CAADnVQ+9EeM-baW1BiGELt2HwuLHK=OOF14WXUXirskuWwpP8g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Correctly reject negative offsets for ALU ops
To: yazhoutang@foxmail.com, Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yazhou Tang <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>, 
	Tianci Cao <ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:06=E2=80=AFAM <yazhoutang@foxmail.com> wrote:
>
> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> When verifying BPF programs, the check_alu_op() function validates
> instructions with ALU operations. The 'offset' field in these
> instructions is a signed 16-bit integer.
>
> The existing check 'insn->off > 1' was intended to ensure the offset is
> either 0, or 1 for BPF_MOD/BPF_DIV. However, because 'insn->off' is
> signed, this check incorrectly accepts all negative values (e.g., -1).
>
> This commit tightens the validation by changing the condition to
> '(insn->off !=3D 0 && insn->off !=3D 1)'. This ensures that any value
> other than the explicitly permitted 0 and 1 is rejected, hardening the
> verifier against malformed BPF programs.
>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---
>  kernel/bpf/verifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9fb1f957a093..8979a84f9253 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15739,7 +15739,7 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>         } else {        /* all other ALU ops: and, sub, xor, add, ... */
>
>                 if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> -                       if (insn->imm !=3D 0 || insn->off > 1 ||
> +                       if (insn->imm !=3D 0 || (insn->off !=3D 0 && insn=
->off !=3D 1) ||

lgtm.
Should probably be:
Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")

Yonghong,
please take a look.

