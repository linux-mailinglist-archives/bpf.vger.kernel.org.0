Return-Path: <bpf+bounces-68456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EB2B58859
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 01:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890632A25A3
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 23:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700362DA769;
	Mon, 15 Sep 2025 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOIrvey/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947732D7DC3
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979622; cv=none; b=MwC82eYeOWGcQFECOILlyKhwEuTSNGKIh9tDj33HPE8WqQAbnJhgXY1bvdui8/dfDWRyMhs/Mzc1s+lGJjuXo1kMRnfph5qhiHGQVt9FcRtSmFGYlmtbTyAW+v6pmsi9IZACO6XPX/+yPiOEmfGO5UXF71wZ4n7xoZWRoKsCO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979622; c=relaxed/simple;
	bh=0OcssUkImO3SE1HHfnrP/IX7TMqj8GUkVeISdnI1urQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lq41o5Y+bh8rdniZXVxvBSSNERzSjvBnvPIZutcM+N+k1Nxsb4m/sctvL/1mt32LMNphW7Jtiu2Oh23cU8Tj7X7qvc/CyA9ZmeX0reoFUqCnBFCDox3im8TJvYu+jfWPn1AB2Q5aAm3tXN9zpO+3c/BAFGXnjeCbRgb2c6LJfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOIrvey/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-772301f8ae2so4501887b3a.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 16:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757979620; x=1758584420; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJSMheGsHe6BVL8P/ZodqLFYVtMcU4bhndx0+FT0+d8=;
        b=BOIrvey/fc+9CwbpEfkrfrES5ocb04nWAA0Y61HQpekWVvMEwYtQ6m87MLQoekED7f
         i2jvVHNAf99DOS2pB+v+Pi+2g5UhvZ+hjOCFNrL3l8w75CPZ5KrkmgxWrXNotQnEvqQn
         G7xbKZAhBbS0/eYO4kfGcj41rQF2NFlVSYKeezcV7z8IVi650+vkq4YKoXJx7RbBGnnW
         qljtulD0pwex7Qm2usGIlyUVsty6WYovdBUwpNeLLRlNKZj87NFKo2dM4kgno5zAO4HQ
         6mSXYDoZmMV2oYlSB6Wpd6YffK/DCpvLoOqFcnSsuSzocw1Nld6BirQ6Qn3uukENSjwD
         O41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757979620; x=1758584420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJSMheGsHe6BVL8P/ZodqLFYVtMcU4bhndx0+FT0+d8=;
        b=MajMoQ81iVov62xTPk9LyaKOVyLCFzuWq09J2nt2TIPgRLE0ttpBrkNURfUj8/Mvv0
         KduzjmsV2r6OvSKWyTUAy2jd/hWaTe1v14gvZRf/x1GWUj0K1rL76PusdHXQBit9oVQS
         dbtRGBp8KHdz5+FZ1avRh0fdHsreK9IV07G2cvF9s07i+DoeVkOHYyZOyuJh6vTMTy5K
         54Lp1XzZW0/GEW6elHZBcxegeOTR+Gi9S+4ezgJBecOzhLj7BEKUMtbydCGXLw/l30cv
         NsvqG1H8ivwcvwQTjJWNGK146KdoknzosOEShvbmjQ37NWZ8CfhcAr76VqfuQu2tIdlt
         9Ezw==
X-Forwarded-Encrypted: i=1; AJvYcCVMVcHduiOXMyR3fQA5URgLl9u3TEIbFz13dM51IOr20+MxYHpmQOv/oi3vuTTs/LwzpMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfb9Clml+mwy+gXOTCozDzXXmah1sEWsbJk1qTFR7RXBRsJUMX
	CfW9OqOmvJ32KJBXpXcySeS4Md0KLtkeBLRihq1YtEv2xUKPx4lU53sj
X-Gm-Gg: ASbGncuNe6IjsOKAEDm4IJ0aX7eV2tS+zz7bbvOO8DdXIcsOP5KH6a/66DU9Bi1khCZ
	a/jRqV6uNLU0yi/u9f+a6c8sePEvrBOyJLFFTGYuvQYdw5zQUFWgSGq9F4/ZgAR70Cgo3qCsH4p
	In3X0ojRgdL9ja7T3nww242c0tjLPWwmRJmYWBFTfyQO9aWqC3inMJLXsiXJiSm7Orb0CNY6lf/
	lyQS+bfZL+XtPSDs6O2wYehNB55iU5pKWvD2tPoF6sU+/g9GnI+M/tTNH6gH8h5BNFWckWAc1AB
	ux7yiQ6Nh096R93kZfZdan383fAiRLeYAIWcQ1VoCgWol7XCEUAbVDNhZOiW8e51OZy2BNplYNZ
	G4IrhhqzXEupQ2yn787kh3tpwH3WUqAxL4PulSXgaENeNl5JU
X-Google-Smtp-Source: AGHT+IGnt46crtLT5a+xjBfk4DXNhqvw6MM+OfwjuMK5SV74rlSJI5wYJ4cGD9gfrEGJ6UmbOVxeXg==
X-Received: by 2002:a05:6a00:3c92:b0:775:fab1:18c8 with SMTP id d2e1a72fcca58-77612060f6emr14543524b3a.3.1757979619680;
        Mon, 15 Sep 2025 16:40:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1da5:13e3:3878:69c5? ([2620:10d:c090:500::4:283f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-777d3ca57e2sm5193931b3a.33.2025.09.15.16.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 16:40:19 -0700 (PDT)
Message-ID: <b1717a5b75475b8e14afaee4825a40a3808bd0cb.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in maybe_exit_scc
From: Eduard Zingerman <eddyz87@gmail.com>
To: syzbot <syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Date: Mon, 15 Sep 2025 16:40:17 -0700
In-Reply-To: <81bb1cf72e9c5f56c92ab43636a0626a1046d748.camel@gmail.com>
References: <68c85acd.050a0220.2ff435.03a4.GAE@google.com>
	 <81bb1cf72e9c5f56c92ab43636a0626a1046d748.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 15:34 -0700, Eduard Zingerman wrote:

[...]

> > verifier bug: scc exit: no visit info for call chain (1)(1)
> > WARNING: CPU: 1 PID: 6013 at kernel/bpf/verifier.c:1949 maybe_exit_scc+=
0x768/0x8d0 kernel/bpf/verifier.c:1949
>
> Both this and [1] are reported for very similar programs:
>
> <this>                                      <[1]>
> -------------------------------------------------------------------------=
-------------------
> (b7) r0 =3D -1023213567                       (b7) r0 =3D -1023213567
> (bf) r3 =3D r10				    (bf) r3 =3D r10
> (07) r3 +=3D -512				    (07) r3 +=3D -504
> (72) *(u8 *)(r10 -16) =3D -8		    (72) *(u8 *)(r10 -16) =3D -8
> (71) r4 =3D *(u8 *)(r10 -16)		    (71) r4 =3D *(u8 *)(r10 -16)
> (65) if r4 s> 0xff000000 goto pc+2	    (65) if r4 s> 0xff000000 goto pc+2
> (2d) if r0 > r4 goto pc+5		    (2d) if r0 > r4 goto pc+5
> (20) r0 =3D *(u32 *)skb[60673]		    (20) r0 =3D *(u32 *)skb[60673]
> (7b) *(u64 *)(r3 +0) =3D r0		    (7b) *(u64 *)(r3 +0) =3D r0
> (1d) if r4 =3D=3D r4 goto pc+0		    (1d) if r4 =3D=3D r4 goto pc+0
> (7a) *(u64 *)(r10 -512) =3D -256		    (7a) *(u64 *)(r10 -512) =3D -256
> (db) lock *(u64 *)(r3 +0) |=3D r0		    (db) r0 =3D atomic64_fetch_and((u6=
4 *)(r3 +0), r0)
> (b5) if r0 <=3D 0x0 goto pc-2		    (b5) if r0 <=3D 0x0 goto pc-2
> (95) exit				    (95) exit
>
> So, I assume it's the same issue. Looking into it.
>
> [1] https://lore.kernel.org/bpf/68c85b0d.050a0220.2ff435.03a5.GAE@google.=
com/T/#u

Minimal reproducer:

  SEC("socket")
  __caps_unpriv(CAP_BPF)
  __naked void syzbot_bug(void)
  {
        asm volatile (
        "r0 =3D 100;"
  "1:"
        "*(u64 *)(r10 - 512) =3D r0;"
        "if r0 <=3D 0x0 goto 1b;"
        "exit;"
        ::: __clobber_all);
  }

And corresponding verifier log:

  Live regs before insn:
        0: .......... (b7) r0 =3D 100
    1   1: 0......... (7b) *(u64 *)(r10 -512) =3D r0
    1   2: 0......... (b5) if r0 <=3D 0x0 goto pc-2
        3: 0......... (95) exit
  Global function syzbot_bug() doesn't return scalar. Only those are suppor=
ted.
  0: R1=3Dctx() R10=3Dfp0
  ; asm volatile ( @ verifier_and.c:118
  0: (b7) r0 =3D 100                      ; R0_w=3D100
  1: (7b) *(u64 *)(r10 -512) =3D r0       ; R0_w=3D100 R10=3Dfp0 fp-512_w=
=3D100
  2: (b5) if r0 <=3D 0x0 goto pc-2
  mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=3Dr0 stack=3D before 1: (7b) *(u64 *)(r10 -512=
) =3D r0
  mark_precise: frame0: regs=3Dr0 stack=3D before 0: (b7) r0 =3D 100
  2: R0_w=3D100
  3: (95) exit

  from 2 to 1 (speculative execution): R0_w=3Dscalar() R1=3Dctx() R10=3Dfp0=
 fp-512_w=3D100
  1: R0_w=3Dscalar() R1=3Dctx() R10=3Dfp0 fp-512_w=3D100
  1: (7b) *(u64 *)(r10 -512) =3D r0
  verifier bug: scc exit: no visit info for call chain (1)
  processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0

[...]

