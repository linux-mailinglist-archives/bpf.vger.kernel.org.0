Return-Path: <bpf+bounces-78797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF4D1BEBF
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75FB3304D491
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1334A29B8D9;
	Wed, 14 Jan 2026 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYNfHb72"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213329CE1
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353829; cv=none; b=MgRSw6cH90jdGqdsu68AUbtFUh33sVqcVl+eqoEpSZF4e4fzZC5dixY7X1r6O2SMeUNEkLzPpj2FlpYC5fQqzyn1DawMYkpl1nhnL91LWhPwQXWU9m0cV/YjHNPa9O+myXBmXR3W2Bf+Zr5Yw6UllUpIYH1GMoSMWr/XTEQC4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353829; c=relaxed/simple;
	bh=aAEZWQ1KfSMzAPYtpG3tL2ijb088UuNcClfkzLAsxDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMI1P3LiMwItlddT8zV+IwPyUFiYPMVmPwwMq5ZanxFuf8HI24vc1srJdCTelRZ3VDHha9rBdvSoI2bpKtgnQr1f7uLpM+bckmm6mEfhBx5QYVyLqUhZTSX717Vx1nLcZa9CxsZrrfpZUmEGs+0TNxkh6u438lpdA4lAgxjTSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYNfHb72; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b870732cce2so457556866b.3
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353826; x=1768958626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUDSeyaDRV+JlrvmR3S5XBVgtWA/bfNivxnd3t19/tE=;
        b=YYNfHb727U5AkuiOCLV38nzaK+3g/Ch51suGrcMwaWJWuLaszChE/4N+CHzaZGTbqG
         SeRCme/PhOpio8OLQmzf57JjfgM5rw6mY2+OW9nLZYkpBpIyQNJ7RReqsO7xlRCpBcbe
         7LCfJLZf0VAbKW0vwdLJkTwcf15m9Ed5xDFcK87aXjL5cuDpzi7nHYQwvZDbILbt6T9B
         mBHjlJ349CijIWUX0M0VDUEbz4dOH8f22TqKw1wsSbvgpn0d07bsCIYxCZ4YNE0h8RfI
         zIIZUr0VenzGXbS9QxuaVjtZXB0csSQUe+jQDqJJa+I5bkrAJm3IZfbJ36/2PY7taxkS
         75oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353826; x=1768958626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUDSeyaDRV+JlrvmR3S5XBVgtWA/bfNivxnd3t19/tE=;
        b=rUztBpNL461Dcf1/rNat1/dBUT7FS1TQZAxWlLygYx+egMI2Pghv+8hW9ocAQfjKWV
         9L+PTU8wJY4TCiOMpCvUC/2+4W672R0wHoVLIy8wL5Se++o/ST4LfJXuqm/vEMqGhNgW
         6XaTCsrjlj+oOr4LXc7YS1Mqm5T7/0AYYuT3nOB4l8twoNnXR1o7k4+DRvIFiLmfAHRB
         bRjxya106n1Cp79dnsUr53jKbkk9oqUNuAy6asvgw2kNOwxGKfpiZeuzKNkPXPaBNFcf
         jxUeR9bP8b7VhmdNEL/9zk7+k8oikvxxzjUgjdDhv5d2hfAKnH+Gbfg6/cV6EMJydw8v
         5m7w==
X-Forwarded-Encrypted: i=1; AJvYcCVwBflO3vOxZbYCYbVu79EhJERoJD6onllwgaAAPlRG102ss49zg1I/qZmvBQLzbX7GKI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1faiEcbLSZAU898fzU4fryW+6Z5vACBMA9JxJHlj4cTTnP5kR
	UZtn/MehucqTvhWG3HLaOdRsrOaLHyBdfGtwRoO8pdoJvOp+/fODaCoz7Qn4Ywg3Ihz0prJKgn/
	4k2FjUafrSRN5gHzZ0ByZ5b1oqSE0FY4=
X-Gm-Gg: AY/fxX4oXLVn2x5YjdicdLPTrR2l0reGM0Dbs+YO9RfrVbMGv33IPu0nPM9+kzZ1Kmw
	+1AN03va8YX1DTDFCB9P+hJyyUpWDjzyrhDII84J+k3mtPACAPqbWzYIq4DIlZihEMXHnzFzpW4
	oyv/wEGnBiThsW0ljENQHFVe1PUJo5U/foKhcmRCS8SOzb373elwh+8baCHMX4pgTDB0+oXg7Rg
	ye4iDpietvSDvTMzP1CwYnTP1j+xo6ZboKkWRE3slr6+/vtOBRXy3T5U663JbAvaIpb1Uo9dqYB
	thTFiJpVAq0=
X-Received: by 2002:a17:907:7757:b0:b87:65c5:602f with SMTP id
 a640c23a62f3a-b8765c56175mr16705366b.34.1768353826138; Tue, 13 Jan 2026
 17:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-3-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-3-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:22:44 -0800
X-Gm-Features: AZwV_Qhh4nrVKAaE708iS3vZTpxbmrywNIqG8up4OBkJsswM78KS0HeB58v781U
Message-ID: <CAEf4BzZKn8B_8T+ET7+cK90AfE_p918zwOKhi+iQOo5RkV8dNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 02/11] bpf: use last 8-bits for the nr_args in trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> For now, ctx[-1] is used to store the nr_args in the trampoline. However,
> 1-byte is enough to store such information. Therefore, we use only the
> last byte of ctx[-1] to store the nr_args, and reserve the rest for other

Looking at the assembly below I think you are extracting the least
significant byte, right? I'd definitely not call it "last" byte...
Let's be precise and unambiguous here.

> usages.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v8:
> - fix the missed get_func_arg_cnt
> ---
>  kernel/bpf/verifier.c    | 35 +++++++++++++++++++----------------
>  kernel/trace/bpf_trace.c |  6 +++---
>  2 files changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 774c9b0aafa3..bfff3f84fd91 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23277,15 +23277,16 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>                     insn->imm =3D=3D BPF_FUNC_get_func_arg) {
>                         /* Load nr_args from ctx - 8 */
>                         insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_1, -8);
> -                       insn_buf[1] =3D BPF_JMP32_REG(BPF_JGE, BPF_REG_2,=
 BPF_REG_0, 6);
> -                       insn_buf[2] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_2,=
 3);
> -                       insn_buf[3] =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_2,=
 BPF_REG_1);
> -                       insn_buf[4] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_2, 0);
> -                       insn_buf[5] =3D BPF_STX_MEM(BPF_DW, BPF_REG_3, BP=
F_REG_0, 0);
> -                       insn_buf[6] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> -                       insn_buf[7] =3D BPF_JMP_A(1);
> -                       insn_buf[8] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVAL)=
;
> -                       cnt =3D 9;
> +                       insn_buf[1] =3D BPF_ALU64_IMM(BPF_AND, BPF_REG_0,=
 0xFF);
> +                       insn_buf[2] =3D BPF_JMP32_REG(BPF_JGE, BPF_REG_2,=
 BPF_REG_0, 6);
> +                       insn_buf[3] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_2,=
 3);
> +                       insn_buf[4] =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_2,=
 BPF_REG_1);
> +                       insn_buf[5] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_2, 0);
> +                       insn_buf[6] =3D BPF_STX_MEM(BPF_DW, BPF_REG_3, BP=
F_REG_0, 0);
> +                       insn_buf[7] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> +                       insn_buf[8] =3D BPF_JMP_A(1);
> +                       insn_buf[9] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVAL)=
;
> +                       cnt =3D 10;
>

[...]

