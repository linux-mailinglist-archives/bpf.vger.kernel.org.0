Return-Path: <bpf+bounces-68422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 000C3B585A2
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 21:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E40160E1F
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CBF299957;
	Mon, 15 Sep 2025 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I05tl7Zf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F12882A9
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966076; cv=none; b=WnhH0IsXogKKgghSG6mCZoVQ1p/FdFCo0+NpSvGQ4PQAaMuaP4DufJNR0pBOi6xNrn81oeuoo83CYxtWkMTz4EcuMy+zWQH+mMk6I97Mq9+8QUx+9jf45l5jJlz77XE8TE17bHritg3yLYuweI5CR/1gUwhrVRDwXD39t2oQTuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966076; c=relaxed/simple;
	bh=1t5HGUdbEnqlFM4BN+7spAJCkMUdNy6xmmpKrD3jxGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBGP8qv2oQa6HMQEkWBhKZ0OkuM+MqQfoaTbWQno/aJtcjT/IoOxJ2keXQkNhuFC61a8fpYJE6nN17JV+ynsXDoxdCYtw/afVQkkEX2Kya6RoYKC3aG1JQeQVcEpsAtR2ZfgYQBhDxEqh6FGFJfpqgLAV+Vd7d6BNAXd28ONVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I05tl7Zf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-251fc032d1fso51425805ad.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757966075; x=1758570875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKMoNUFr15hMIs+DA/sQ+YcEe3uvxbWw0rkaGFS6MZk=;
        b=I05tl7Zf8txDlXtRshtYw1C9ax2cMQ3SloWmynucveAWTn8oezeHCt5jLguUz9tzxY
         DnHMn9FugRtz+b6MFp5Lkrv3xWiDS2n5GCwQPRaFyl4+TrD08LcFZFEfm9EVNpePKiM6
         hYR8hwUaT4Qdgi7JG/2CuIlQ2Zz5Rjf/IzoPhorHpKZDINmr/KuRHRXRQq6Mn4gkY+b1
         dKOOLpRUrW9nbU/l/eRdXS4ZBdBWLO9z34zWr1+O+vRkG+SspkmQKD3Su2cSOr8SbCBF
         gGLaumziF7k3225ahhu1Jflvl8b1cn5bF1owOpn1+aKiCksjrpt8uV8LsulW1xyPJ5dg
         RlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966075; x=1758570875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKMoNUFr15hMIs+DA/sQ+YcEe3uvxbWw0rkaGFS6MZk=;
        b=oOkpkOjwVnqF20WxPAhvjlktdedQPWoQrgct+TPdK9IB7DAnl1Zyey2mY6NfgVR6Zq
         iR8uY6F4+OiZgfXMbEzDM+RZa6XzyDbZ0tPyhD7CiWk/9xIAaHb3OEPuxGCNKbB5uB9L
         +53vMlLsGp60PKkbfdEKrzlFdcfT7F3AcHeGauwR7E5YLQZlDQCH/mWCrC5gWj1UkoW6
         8ukM0iPnDpUJezEC0gfQLE+JQG3JeBsNGVV3wag1P7Y/Vat2HrPGzNsL8EP4rCn3Jp0m
         4CZLTjXO5cpKSRA5KhOvZfyESKRZ44U/MX5afQJt7MGTX8LHJBkgJIV8A6LoPSF1nAm6
         cEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0dIwA+yiQO7bq1SeGpAeMXPEei4ZmCd8ghJthL3nH5CKmFGEakCw0AYClDWds39KKwtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpm0nhoZ61hAkjNkrGfDfL1N8snCQ1DpmASunTUOeDvtojISZg
	sjhSIA6ssgK9VCaSaC2Euw7tEQd/nVJ0eCVWBB7l8d4LuXsNYVzzbO4xtJLe8GJ+EfIMXEOHlf3
	ufhqZI1bLWGHOa40sxCDyPAcseksXuUQ=
X-Gm-Gg: ASbGncvo9wO95a89rGalLOCI1F+7LfGpF9RQ3Yw86G+uxsw/npicBw8nNP+bSy1H10K
	1CcqZgxQI5RWx9bopprmTEUF5utkC4SP3csRHpaIIb0elDGF7A2QCqFLZFszaVZ4dl8wm0CUtpQ
	F6AIBm4UYuNmDvJjlPYZhCBdkHMacZcsCG+IbYqy5MX/tgFkZiFg35hchew5a1YR/xLrUI+MJLP
	KLbWdWPm8bJ7XINne/k6iag4WyPty0x8g==
X-Google-Smtp-Source: AGHT+IGhszUX/wIOL5NPxhRl5wThYAaRRneYHXfDR1OkxzwEwEhfmK0x+kYIpjKOZ/xwWV7ll61KtWzqWi210u8AngA=
X-Received: by 2002:a17:902:cec6:b0:266:88ae:be6d with SMTP id
 d9443c01a7336-26688aec242mr56968135ad.6.1757966074538; Mon, 15 Sep 2025
 12:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913222323.894182-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20250913222323.894182-1-kriish.sharma2006@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Sep 2025 12:54:20 -0700
X-Gm-Features: Ac12FXzojP0XfNu0UL3urOwuEQZBsAsNl-Qq1OLXgb7nho1cime033bbY4rUq2g
Message-ID: <CAEf4BzY_f=iNKC2CVz-myfe_OERN9XWHiuNG6vng43-MXUAvSw@mail.gmail.com>
Subject: Re: [PATCH] bpf: verifier: fix WARNING in reg_bounds_sanity_check (2)
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 3:24=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
>
> syzbot reported a "REG INVARIANTS VIOLATION" triggered in reg_bounds_sani=
ty_check()
> due to inconsistent umin/umax and var_off state after min/max updates.
>
> reg_set_min_max() and adjust_reg_min_max_vals() could leave a register st=
ate
> partially updated before syncing the bounds, causing verifier_bug() to fi=
re.
>
> This patch ensures reg_bounds_sync() is called after updates, and additio=
nally
> marks registers unbounded if min/max values are inconsistent, so that umi=
n/umax,
> smin/smax, and var_off remain consistent.
>
> Fixes: d69eb204c255 ("Merge tag 'net-6.17-rc5' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/netdev/net")
> Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc950cc277150935cc0b5
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  kernel/bpf/verifier.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c4f69a9e9af6..8f5f02d39005 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16299,6 +16299,19 @@ static void regs_refine_cond_op(struct bpf_reg_s=
tate *reg1, struct bpf_reg_state
>         }
>  }
>
> +/* Ensure that a register's min/max bounds are sane.
> + * If any of the unsigned/signed bounds are inconsistent, mark the
> + * register as unbounded to prevent verifier invariant violations.
> + */
> +static void __maybe_normalize_reg(struct bpf_reg_state *reg)
> +{
> +       if (reg->umin_value > reg->umax_value ||
> +               reg->smin_value > reg->smax_value ||
> +               reg->u32_min_value > reg->u32_max_value ||
> +               reg->s32_min_value > reg->s32_max_value)
> +                       __mark_reg_unbounded(reg);
> +}
> +
>  /* Adjusts the register min/max values in the case that the dst_reg and
>   * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF=
_K
>   * check, in which case we have a fake SCALAR_VALUE representing insn->i=
mm).
> @@ -16325,11 +16338,15 @@ static int reg_set_min_max(struct bpf_verifier_=
env *env,
>         regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), i=
s_jmp32);
>         reg_bounds_sync(false_reg1);
>         reg_bounds_sync(false_reg2);
> +       __maybe_normalize_reg(false_reg1);
> +       __maybe_normalize_reg(false_reg2);
>
>         /* jump (TRUE) branch */
>         regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
>         reg_bounds_sync(true_reg1);
>         reg_bounds_sync(true_reg2);
> +       __maybe_normalize_reg(true_reg1);
> +       __maybe_normalize_reg(true_reg2);

We are actually taking a different approach to this problem. Eduard is
going to modify verifier logic to use the fact that register' tnum and
range bounds are incompatible to detect branches that cannot be taken,
and process it as dead code. This way we don't lose information (like
with the approach in this patch), but rather take advantage of it to
improve verification performance.

Thanks for your patch, but I think we should go with the more generic
solution I outlined above.

pw-bot: cr


>
>         err =3D reg_bounds_sanity_check(env, true_reg1, "true_reg1");
>         err =3D err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2=
");
> --
> 2.34.1
>

