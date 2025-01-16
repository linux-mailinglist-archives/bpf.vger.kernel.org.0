Return-Path: <bpf+bounces-49093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF73A1429B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 404597A074B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A48522FACD;
	Thu, 16 Jan 2025 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2xJGdmu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19C14AD2B
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056952; cv=none; b=u2QrUuFhx/WajlXm57O3MNzKa5E3BbmDLxjmRguch2VNZeDaT60WbIRxhUVxnhORvcUzEAkl8HjO6Uu3NYzT2iCbVuYoVIwg4CNNOsq3m+watsrGChGIBUitMgoHl3vyVeYW2xwsZ1jkEyZSL+dIqexY7x07AVHbln7BhYlwJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056952; c=relaxed/simple;
	bh=HC0mlnMsSM6jmMoXTt+rAZpN5SF/phNq23qVnxhJsm0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DGDNnJPTK/SmgQFi4B+xyPeDWK3nVzIs8nWL3jWIe9c1qgfdSqYjzWcneR4J2+Y1anGeR/1LkoReD4cKdyTAVavnEN3cn2zMdXXQ2+I6OBTF4/f8M46qTjldmAeUyrCugLuYj/PAL9YTWO+M0sCvRCh9xBEAy1v7A+RJnKUz1KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2xJGdmu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163dc5155fso24879765ad.0
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737056951; x=1737661751; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fOwIpG2f5VIfKGQSZBhxrQ8K8RjRVvuzlLKKesBMejI=;
        b=G2xJGdmu1gUchG5sZngA4iHvQve02icD40rIZHHNKcnF2ViSe1YSy+p7iRWQmNw9Uv
         z/Zaevymmjt269pTa6snZs2MVqzNhZlwy3Sg8ioH2tLGMrORsLsdMkUeC7ME5ymfyUdT
         4/tozjiy2VMP+kcMcAVuDVuX7eAAU5I8hcatoTJ9Qs1ERC+toOp1ZXyl4h1Smo4MvWoh
         1VqS+0J8i1BaSedz1LZP4wtETFQU+RPcqJZzeCFcSrJOC1c44gvypqjxE91SHEHUg0P5
         k8XCqt653brsuXtp2KXM2Y1kCl/Kv/V8+a2BoxdTibj/f3PeCy23r2+ZirbCmf41eutH
         H9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737056951; x=1737661751;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOwIpG2f5VIfKGQSZBhxrQ8K8RjRVvuzlLKKesBMejI=;
        b=gzFcpKgBNgzEWXK4hJfCf86ANGd2tTlq6aUWMXrWTFJ3doz9lJKr6uciEWAkpTU5Zl
         UJ8OkohxOOQ2xpwAGahBJtEJ3vnTKnH8f1AG8QyvhNc4/oC8rUW3VARryGWnQSN5sakM
         DSSyGWQHhPZOb1AGREM21MCRBkijHIjrXrvYS3YPhbxEm8o4iiWmkX34LNzOxGli6iZi
         jVaa+otH89ngDHoxMagrLDIxtXWv2MaR0I8tYrbGFPNRH+wl9g11QaO+26TGdGlWdmPC
         9m2ZCd/HvUOLEmu553GLlmoWJhgcdNP0ZOKNiJ7TZdecPfiIge5ZZmYv57FnCoAquTsb
         YPzg==
X-Forwarded-Encrypted: i=1; AJvYcCXfRozPiPkGVP23LP9PTfEojktEsSc0dxbqJgIXO5ojnn6TucJtOfUpuHiGVEt3j9bVp+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVylrAaNKYgjmANL9mCAeQehdnNwhffR/ls49HOtSZ50916Av+
	1mXvID5YRbnybP6stRDwRSQMImT/Tn7gf9JX5iy9ihHLMzNbu8Sx
X-Gm-Gg: ASbGncumsa+XhuDrEjppACxoJtq1E0uMk7n0g27d2kWnfMPL6LP2ADvJUSgjLJyYYw3
	caHSOx7C3FtIZQ/MwTpo++vqQrKyi4CzG2xswsO9+XdBM/ZG45tepxsPlxjzVzpqsrlpqLMGIJe
	rx83HfpBWOyRM3evtwL0fjHcAndAGgkf7DPRyvxSLesXTS20wd2qIJgx9NSOlPbL14yYTHXM9bU
	l+NMgzxWt8LkdDWe2wZQLjyLdbhj/tMflXq1nn138rwgkRs9RjjtA==
X-Google-Smtp-Source: AGHT+IHNh++5WMsjGtHHZIDbr6x1LVhdsbut1CqKLNIxzcApdtb2c9grYzMZAPP0je7PRDRyMlDa2Q==
X-Received: by 2002:a17:902:d583:b0:215:4d90:4caf with SMTP id d9443c01a7336-21c353e700fmr83145ad.14.1737056950678;
        Thu, 16 Jan 2025 11:49:10 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceb772esm3841225ad.80.2025.01.16.11.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:49:09 -0800 (PST)
Message-ID: <ef0761e2c9fb451a292a7c59cc7a7d5b02dce790.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add some tests related to
 'may_goto 0' insns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Thu, 16 Jan 2025 11:49:04 -0800
In-Reply-To: <20250116055139.605195-1-yonghong.song@linux.dev>
References: <20250116055123.603790-1-yonghong.song@linux.dev>
	 <20250116055139.605195-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-15 at 21:51 -0800, Yonghong Song wrote:
> Add both asm-based and C-based tests which have 'may_goto 0' insns.
>=20
> For the following code in C-based test,
>    int i, tmp[3];
>    for (i =3D 0; i < 3 && can_loop; i++)
>        tmp[i] =3D 0;
>=20
> The clang compiler (clang 19 and 20) generates
>    may_goto 2
>    may_goto 1
>    may_goto 0
>    r1 =3D 0
>    r2 =3D 0
>    r3 =3D 0
>=20
> The above asm codes are due to llvm pass SROAPass. This ensures the
> successful verification since tmp[0-2] are initialized.  Otherwise,
> the code without SROAPass like
>    may_goto 5
>    r1 =3D 0
>    may_goto 3
>    r2 =3D 0
>    may_goto 1
>    r3 =3D 0
> will have verification failure.
>=20
> Although from the source code C-based test should have verification
> failure, clang compiler optimization generates code with successful
> verification. If gcc generates different asm codes than clang, the
> following code can be used for gcc:
>    int i, tmp[3];
>    for (i =3D 0; i < 3; i++)
>        tmp[i] =3D 0;
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +SEC("raw_tp")
> +__description("may_goto batch with offsets 2/1/0")
> +__arch_x86_64
> +__xlated("0: r0 =3D 1")
> +__xlated("1: exit")
> +__success
> +__naked void may_goto_batch_1(void)
> +{
> +	asm volatile (
> +	".8byte %[may_goto1];"
> +	".8byte %[may_goto2];"
> +	".8byte %[may_goto3];"
> +	"r0 =3D 1;"
> +	".8byte %[may_goto1];"
> +	".8byte %[may_goto2];"
> +	".8byte %[may_goto3];"
> +	"exit;"
> +	:
> +	: __imm_insn(may_goto1, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2 /* of=
fset */, 0)),
> +	  __imm_insn(may_goto2, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1 /* of=
fset */, 0)),
> +	  __imm_insn(may_goto3, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0 /* of=
fset */, 0))

Rant: may_goto3 that does +0 jump is a bit confusing :)

> +	: __clobber_all);
> +}

[...]


