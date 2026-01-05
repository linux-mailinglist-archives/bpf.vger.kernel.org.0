Return-Path: <bpf+bounces-77864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9BCF52C8
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 19:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 682D9310D751
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 18:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3404F336EC2;
	Mon,  5 Jan 2026 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPJRUbmL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071142F0C5B
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636271; cv=none; b=raGjZsQ+R29Q5fECA4N9JybEw7aF7Bhg+a2hSxiW7HXRW+86IVilUMQzFNTtNMbpFlj5hQYHvEO+M2JMhSQQkII5i97j6XDvXJzSmpnRoc5IQUrrbjw/JASEKVdj6CuhP+nI9uyVrR29VIY1twShBWhdsu0+EPIhCbsR3sVmzXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636271; c=relaxed/simple;
	bh=AhaYTyxOuYDk5hXdYvveTxiwI216+Eiw+AvkEGOQl30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dB+1/Y+lOaxn75cVuCOPqrWVMQIiWCsTHjVTln6KX8ekkEfhYE/lLK9+3bQ8wpqR3/b3NqZI0r/JZRMoIH1/oJD8DEF+Lm894wOEbvomLsb3Aj39kuSFG55/92vqy24lWaR/cU9/K421r8HucsPmZaCaBjZGvmtvCLQoL8k2kqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPJRUbmL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbc305914so124019f8f.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 10:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767636268; x=1768241068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI8RtePXfwzwS7mkc1eRnRQkzUnZ4Oh1bnvBATGXTE4=;
        b=lPJRUbmLcSzgP28JjlflghLIYMpOAI7wNKvEOcoR1Jov93QuUQclnqA6Zw9iUQ/RjJ
         SUG6Doh9VFRyXpXv7lwfvk1S3ttZmtIQyhRMfLwknEJcUyKKo3ri8YRAFUuPBHdn/oW6
         Xcfq81WLzeYZ6RDKwTIZtJW8uuGWMaksunQS7/+Sx+FfnaGN9z4L3+nUDlMBJ+aNdjVG
         Tyf7IgJFkrmIVq9Lb8u1zleEeiPDLvCWyRWeonpLD4VGT+u4WiOteqhOxdxLqW6ppF76
         SoEUBjdfqXrKlMZ+H8pmxZk20OeQ2wALKhE78dquhusPqs03YSpccSpmMTtRnxrguwdl
         /R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636268; x=1768241068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gI8RtePXfwzwS7mkc1eRnRQkzUnZ4Oh1bnvBATGXTE4=;
        b=v7RxSpFopX222i47HoFu3Kv8PniLTcocrw5HoPV2asUZCySsPb3qAM5YcQ+RwtVtHu
         TOzzTroMj+v0p2rTEhwYrWgTK3luH6Vm/iGjd4UG9/8S4/8t4Ov6akH+p8kPv6Yn67Gi
         Yqcjj4dMbgU8Ao2MbHsH3Xmun8ClOP82v5t3hvsrm4mSanPYr747rI+qJ7men7HYOoDH
         tWuAqB/pLrhTiYWWB40Zovaw0vXyoQuP3k6Ic70tcPI4CXZUiBeMqrvbXtIMu+RRAHYT
         YxMefuBnCF576Llkgp+lXxa5PaOqeC3Qj7Okve5WqVZ8VQ2uU1PanjdLQIG0w1lx/ANN
         NVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5TFaqNFYN/8PUeim0vg6vD4ja5VZHGjZgBbNbfyKQ0Y2YqXCW8GIwPAWPoicC6/rK4wM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3kyM3wxFVTPQpdJRP7VTiDKI7X53TwMC6cjRw7QWj+yUmgfu/
	xSUqdKQFArdcMZda6kD8fPQCU/5YhzZ6a71LsAVcyqaIDylfLQmKSYnEAsI5NWuSVzWh12CpnKU
	0x06vjKopiVVXnRcyvr5J5OI3rP4p9AI=
X-Gm-Gg: AY/fxX7m5Tfd4S9u9lhB/H+XniV0E5e/ESrd1g8ggiL9LietwRtXrM/vrvqFEAyntFG
	mrHiU+PvV3BP9DIHyjQCJPKwlDsv4CDhpbWH8I+WcVx1P5DncK+IPt9/kkCfW8f2hFcDu2eEtqT
	lFy18jr9XQtlg00hOxknjHccT7MSd67QAmEpNX9i2+wwe4gWns94uSb7be7i08dV5z6cBkmYeXS
	QM/l7uCtjm9huPmdEYkSBTMkKRDv2jQqAkWpONj2tjNMi1Wvq0mhmu/Dz/XUj0IHikeUUJH4rkD
	hJahtHoTdL3LXjYqHldqfw+aoX6KeRR3XwOip1U=
X-Google-Smtp-Source: AGHT+IHrsQw1QKbYe8LdWMiqz+dVSN/+stHeZIas7daFWJK2uatS06DRNRaNhywafyS372Az0OhKFHrHUW7o3CaRCaI=
X-Received: by 2002:a05:6000:1ace:b0:42b:3ad7:fdd3 with SMTP id
 ffacd0b85a97d-432bc9d0eeamr873537f8f.18.1767636268130; Mon, 05 Jan 2026
 10:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104131635.27621-1-dongml2@chinatelecom.cn> <20260104131635.27621-2-dongml2@chinatelecom.cn>
In-Reply-To: <20260104131635.27621-2-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 10:04:16 -0800
X-Gm-Features: AQt7F2pauKhkLdGPfB35b4jRX1IBNZgd2lxSAmUpRQteTUoNsbefnAXbM8EY6BY
Message-ID: <CAADnVQLrV+0RB8REtcN9x+ub_S-DCrRqTj4s+QtX_ROrA=OwBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 5:17=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance. The instruction we use here is:
>
>   65 48 8B 04 25 [offset] // mov rax, gs:[offset]
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - check the variable type in emit_ldx_percpu_r0 with __verify_pcpu_ptr
> - remove the usage of const_current_task
> ---
>  arch/x86/net/bpf_jit_comp.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e3b1c4b1d550..f5ff7c77aad7 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1300,6 +1300,25 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 =
dst_reg, int off, int imm)
>         emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
>  }
>
> +static void __emit_ldx_percpu_r0(u8 **pprog, __force unsigned long ptr)
> +{
> +       u8 *prog =3D *pprog;
> +
> +       /* mov rax, gs:[ptr] */
> +       EMIT2(0x65, 0x48);
> +       EMIT2(0x8B, 0x04);
> +       EMIT1(0x25);
> +       EMIT((u32)ptr, 4);
> +
> +       *pprog =3D prog;
> +}

Why asm?
Let's use BPF_MOV64_PERCPU_REG() similar to the way
BPF_FUNC_get_smp_processor_id inlining is handled.

pw-bot: cr

