Return-Path: <bpf+bounces-54156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB304A63BEB
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 03:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E408716D4B0
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 02:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707211531F0;
	Mon, 17 Mar 2025 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxmsW7zC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE858F5C
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742179295; cv=none; b=MVhMjj2+VW9sg+CHper2lPAHmkd/xfLJtQL8rOdEZc+Gme6qzGlOKQkViAp7qY/qF73WU468nhDR3AI6Y+astcPyC5qd+zxN0RkKeVDZCrwbkvJqOj3YvTvaUBpfeLZ8DIx0QWJNXBGXeOWZeZKabz/Aoixl02fsjpcMkiCa8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742179295; c=relaxed/simple;
	bh=cqLFEvG1wxgpkBW7YgoWE3nJ16G7LJwwO5DFVPeKK7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoiNfcuRsrihVkc7nFFnaCy986NpTsYSld2pZUHK49sIE2N+fC6UfJUG5PkgBEM1UZZQRCqkWH+6iwoRuHqHMJH6/6e+mkTMMceoW2hPj2+STq9EmJC0N7rJ7jpQh8UseIUW3LEjGlzB5DHgy1QUfGnsUS2HU/+U0OZ4QEJ2GvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxmsW7zC; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47686580529so34360021cf.2
        for <bpf@vger.kernel.org>; Sun, 16 Mar 2025 19:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742179292; x=1742784092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSGyPOqlFrFHPNN20qwckg91kjbzGdcRDUlqTQHsUYE=;
        b=IxmsW7zC4r2AzMQsO8egOZzgi1x3AnpT1DqvED8RzTwXGRR0BkUF5+g3AbVOjcLdnh
         ivUidg7/RBNEZcrs27nkZ4jdyfmDgk+leJ2X2i8UeMj20jL/0rye7aP9sUXaQf9kdUqQ
         JvrNfJoI55p32eFgXrGYg7cmGzYdgOkm6rryukco2NE4ckqrIMq+V/ooz8onhTDpD+ud
         gO09AFGqlMla9b6DkNWJS4xC+Q+CsUnsV30b2dI93jeKN9bSL95r1mbtkyNx+Qwxrtuv
         x6UOfTD2dmEnwffCPMxcetV3gGvFtpuMBYkfKkfzgw+LyqufIJV/hw0g7EYel74DNeRN
         R0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742179292; x=1742784092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSGyPOqlFrFHPNN20qwckg91kjbzGdcRDUlqTQHsUYE=;
        b=gPXvY6GVczcaliGH2MJpECZsO5CWxvFQsusK2RzF9tRA5dKIZR0snVeKh4loTdccE9
         5bMH4pl/XsFJU8Sk56VjPre4WKaRnlm3xEHUuEbT1N2VxhmMPpTOHJMVrA6MxSabeGLB
         K5aSd1lFL+76yzR0hxEKlrSbsZ1HHXpJaE/or8fAKJFdLlH0Jd45lMtvy80B7Zw2fp0b
         XGrYL6gNPi8Jch2m18LVZdVMTq2T5cFPhzdfG9wJf2/BoMSsVx0adBMGFwBXg7qdKRff
         9yIX7ceMOiow1U8zxNN/QySIBnNEYNlgZLZ4Pf2YDYUqrn/kRxPAIIOElHgI+4B1sYxj
         ZYbw==
X-Forwarded-Encrypted: i=1; AJvYcCUUK0cHotns4+zEUkuP1+i4iHGf6n0utWsvwl5OV7EEgvUgqoJO6RXbrNiPrNtk/xR06xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSgULrcyO3S7NxtYkpsH4AsHm6X+poPsYL7d54359wQbIakFD3
	6PwAX4E59NdD4wEwHa6rY5CivQYSj6dZVXDNgIqC1kdNJxqRm68+pwzoIfQrhyj6t3LcAgGOD2G
	ExqiaXicKQRYK3G0NvlQ6L/3YQ1I=
X-Gm-Gg: ASbGncuZuR4P/8ncK78vDYW0VmxUJjhE7puyzNZLgbLRBR9S/MDTUZguuhjJg/pLXaR
	xdjodBvNB5wqpu85fiNbpogj0XC992SfD56HilBqpf9xCR1W8Gbm3M6TavjpeAEu1cOTrp8uOii
	IBBuXaQnxyz95PbrQCJ3goFOCi2TKrY/Bmg3JWikI8y8eFelWiGgDgkKOR6g==
X-Google-Smtp-Source: AGHT+IH6qRJmi+iD5hw+hOKBliR9O//9T7+ZaQPgYEAntzWAc4cne+bz2Dd8PUzK9LVQ+S8twqS8DM/2BqVZ+1uL66I=
X-Received: by 2002:ac8:5716:0:b0:476:ad9d:d4e9 with SMTP id
 d75a77b69052e-476c815c75amr127687121cf.24.1742179292156; Sun, 16 Mar 2025
 19:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317015755.2760716-1-hengqi.chen@gmail.com>
In-Reply-To: <20250317015755.2760716-1-hengqi.chen@gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Sun, 16 Mar 2025 19:41:21 -0700
X-Gm-Features: AQ5f1Jo9X4-WTXdC8K3aaojw_lagAanfpjbuAk62GOopvtFp_Gu1dOjsSj5Tshg
Message-ID: <CAK3+h2z4AGA8ekAcz3q5bALp1S0hXjJEq2roMAdq6MdKdPhtmg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Use move_addr() for BPF_PSEUDO_FUNC
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, chenhuacai@kernel.org, 
	yangtiezhu@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 6:58=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> Vincent reported that running XDP synproxy program on LoongArch
> results in the following error:
>     JIT doesn't support bpf-to-bpf calls
> With dmesg:
>     multi-func JIT bug 1391 !=3D 1390
>
> The root cause is that verifier will refill the imm with the
> correct addresses of bpf_calls for BPF_PSEUDO_FUNC instructions
> and then run the last pass of JIT. So we generate different JIT
> code for the same instruction in two passes (one for placeholder
> and one for real address). Let's use move_addr() instead.
>
> See commit 64f50f657572 ("LoongArch, bpf: Use 4 instructions for
>  function address in JIT") for a similar fix.
>
> Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf and tailcall=
s")
> Reported-by: Vincent Li <vincent.mc.li@gmail.com>
> Closes: https://lore.kernel.org/loongarch/CAK3+h2yfM9FTNiXvEQBkvtuoJrvzmN=
4c_NZsFXqEk4Cj1tsBNA@mail.gmail.com/T/#u
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index ea357a3edc09..b25b0bb43428 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -930,7 +930,10 @@ static int build_insn(const struct bpf_insn *insn, s=
truct jit_ctx *ctx, bool ext
>         {
>                 const u64 imm64 =3D (u64)(insn + 1)->imm << 32 | (u32)ins=
n->imm;
>
> -               move_imm(ctx, dst, imm64, is32);
> +               if (bpf_pseudo_func(insn))
> +                       move_addr(ctx, dst, imm64);
> +               else
> +                       move_imm(ctx, dst, imm64, is32);
>                 return 1;
>         }
>
> --
> 2.43.5
>

Thanks Hengqi for the quick fix! tested and verified working now.

[root@fedora xdp-tools]# uname -a
Linux fedora 6.14.0-rc5 #2 SMP PREEMPT_DYNAMIC Sun Mar 16 17:16:21 PDT
2025 loongarch64 GNU/Linux

[root@fedora xdp-tools]# ./xdp-loader/xdp-loader load  -vvv lo -m skb
-P 80 -p /sys/fs/bpf/xdp-synproxy-tailcall -n synproxy_tailcall
./xdp-synproxy-tailcall/xdp_synproxy_tailcall.bpf.o
Current rlimit 8388608 already >=3D minimum 1048576
Loading 1 files on interface 'lo'.
  libbpf: loading object from
./xdp-synproxy-tailcall/xdp_synproxy_tailcall.bpf.o
...
  libbpf: map 'tail_call_tbl': created successfully, fd=3D4
  libbpf: pinned map '/sys/fs/bpf/xdp-synproxy-tailcall/tail_call_tbl'
  libbpf: found no pinned map to reuse at
'/sys/fs/bpf/xdp-synproxy-tailcall/values'
  libbpf: map 'values': created successfully, fd=3D5
  libbpf: pinned map '/sys/fs/bpf/xdp-synproxy-tailcall/values'
  libbpf: found no pinned map to reuse at
'/sys/fs/bpf/xdp-synproxy-tailcall/allowed_ports'
  libbpf: map 'allowed_ports': created successfully, fd=3D6
  libbpf: pinned map '/sys/fs/bpf/xdp-synproxy-tailcall/allowed_ports'
  libbpf: map 'xdp_synp.rodata': created successfully, fd=3D7
  libbpf: map 'tail_call_tbl': slot [0] set to prog 'syncookie_xdp' fd=3D65
 libxdp: Loaded XDP program synproxy_tailcall, got fd 66
 libxdp: Duplicated fd 66 to 3 for prog synproxy_tailcall
 libxdp: Replacing XDP fd -1 with 3 on ifindex 1

[root@fedora xdp-tools]# bpftool prog
...
55: xdp  name syncookie_xdp  tag 1426f5e6593da050  gpl
loaded_at 2025-03-16T19:38:49-0700  uid 0
xlated 8392B  jited 6412B  memlock 16384B  map_ids 11,10,12
btf_id 75

56: xdp  name synproxy_tailcall  tag 0433e599459b925f  gpl
loaded_at 2025-03-16T19:38:49-0700  uid 0
xlated 192B  jited 328B  memlock 16384B  map_ids 9,12
btf_id 75

