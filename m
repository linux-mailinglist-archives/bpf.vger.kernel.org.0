Return-Path: <bpf+bounces-18815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5568224D9
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDAF1F237B1
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 22:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C99171D7;
	Tue,  2 Jan 2024 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM6zyFEK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA614171CE
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26fa294e56so632843066b.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 14:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704235163; x=1704839963; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R/KGgQZ510Uk0fsKqsBYp6kL5o9GRHUMEK/wtfJVZY4=;
        b=NM6zyFEK3cBYAi4tbRG4G1K2SEtAtmOu95zhvVQBStTCftoIOXH74BR3nYDJQE19km
         IntAZHRK22W/jDMldOju018QLvp6FZCOtrSxihfK1FRN9yepJO2O5F/Y0m7nWnkjAdOm
         bXjDvlkiOs1HNHKECSH1qFnjBvUrJI/yfgrep4DmPvh8ZcX/h20lWcWl740FAv+wqndN
         O9TiZl1+i/bSX7fZYmYgJLvc88+Vj27UDa2sbYOYRWqMZwOh2R4arQ64bO9wNTN2wt/K
         HXR2ls16X08dxZ++2uwMxM5m7KtaxRS76k0yNqneupbGqhPPlmEzVj1CW1pwEZmqo83K
         9Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704235163; x=1704839963;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/KGgQZ510Uk0fsKqsBYp6kL5o9GRHUMEK/wtfJVZY4=;
        b=TnCR6XwrYLb0u8sbuglb27J1hSRGnLZvcr5cDj68qQojFeur4sWfXcHJkwTP6bfA5u
         M26D0pJfcyx0UejWL0uWhhyQKVh6lzJoko88eQrpeM80P11nzzuunHa0zmBf9vlwUPTR
         Bnc5fIyMzpN1BHeqyZO2N0geJGEP6X8II2w6KRM+m5XL9Vl9iehs900neca12/TfIO77
         1TmrnjKealv7k8OZy23GzSxtE9D177/LatbtSaY55LlCnG25DdJpym8+rR+BRn+XzeRb
         z49OToBMAuZNMQblxLqJZarzFqxSI7se7XwnONlDFJO1y5bsbnZ4aPQ++gN/BeM5mJqX
         aa+Q==
X-Gm-Message-State: AOJu0YzHKJLPOg0lUMBRnK9TiSYF9bjlu073vIGpkvezyzKsdbnOfBic
	AXl1zRs/Ycky/XomwhCmFag=
X-Google-Smtp-Source: AGHT+IFkRXMT9sZ4FLeeihnOSHPwwww3EwoUQrFm7EuKRobSJlrVLY0REe67n0BjG3Tu+AXYnMO6NQ==
X-Received: by 2002:a17:907:2813:b0:a22:ebf2:1edc with SMTP id eb19-20020a170907281300b00a22ebf21edcmr7193466ejc.16.1704235162938;
        Tue, 02 Jan 2024 14:39:22 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id gj17-20020a170907741100b00a28116285e0sm1888169ejc.165.2024.01.02.14.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:39:22 -0800 (PST)
Message-ID: <d3ea8754ed4c5f8a33b3fd2cc69eeff7f362ce35.camel@gmail.com>
Subject: Re: test_kmod.sh fails with constant blinding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Bram Schuur
	 <bschuur@stackstate.com>, "ykaliuta@redhat.com" <ykaliuta@redhat.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"johan.almbladh@anyfinetworks.com"
	 <johan.almbladh@anyfinetworks.com>
Date: Wed, 03 Jan 2024 00:39:21 +0200
In-Reply-To: <1b45ec38-3a7f-4745-a063-8b16b040004c@linux.dev>
References: 
	<AM0PR0202MB3412F6D0F59E5EBA0CA74747C461A@AM0PR0202MB3412.eurprd02.prod.outlook.com>
	 <08287f7c-d0aa-4ded-a26d-34023051dd14@linux.dev>
	 <28bcf5ae2df9ed0bd1603ed161e1d4488694c0d9.camel@gmail.com>
	 <1b45ec38-3a7f-4745-a063-8b16b040004c@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-02 at 11:41 -0800, Yonghong Song wrote:
> On 1/2/24 9:47 AM, Eduard Zingerman wrote:
> > On Tue, 2024-01-02 at 08:56 -0800, Yonghong Song wrote:
> > > On 1/2/24 7:11 AM, Bram Schuur wrote:
> > > > Me and my colleague Jan-Gerd Tenberge encountered this issue in pro=
duction on the 5.15, 6.1 and 6.2 kernel versions. We make a small reproduci=
ble case that might help find the root cause:
> > > >=20
> > > > simple_repo.c:
> > > >=20
> > > > #include <linux/bpf.h>
> > > > #include <bpf/bpf_helpers.h>
> > > >=20
> > > > SEC("socket")
> > > > int socket__http_filter(struct __sk_buff* skb) {
> > > >   =C2=A0 volatile __u32 r =3D bpf_get_prandom_u32();
> > > >   =C2=A0 if (r =3D=3D 0) {
> > > >   =C2=A0 =C2=A0 goto done;
> > > >   =C2=A0 }
> > > >=20
> > > >=20
> > > > #pragma clang loop unroll(full)
> > > >   =C2=A0 for (int i =3D 0; i < 12000; i++) {
> > > >   =C2=A0 =C2=A0 r +=3D 1;
> > > >   =C2=A0 }
> > > >=20
> > > > #pragma clang loop unroll(full)
> > > >   =C2=A0 for (int i =3D 0; i < 12000; i++) {
> > > >   =C2=A0 =C2=A0 r +=3D 1;
> > > >   =C2=A0 }
> > > > done:
> > > >   =C2=A0 return r;
> > > > }
> > > >=20
> > > > Looking at kernel/bpf/core.c it seems that during constant blinding=
 every instruction which has an constant operand gets 2 additional instruct=
ions. This increases the amount of instructions between the JMP and target =
of the JMP cause rewrite of the JMP to fail because the offset becomes bigg=
er than S16_MAX.
> > > This is indeed possible as verifier might increase insn account in va=
rious cases.
> > > -mcpu=3Dv4 is designed to solve this problem but it is only available=
 at 6.6 and above.
> > There might be situations when -mcpu=3Dv4 won't help, as currently llvm
> > would generate long jumps only when it knows at compile time that jump
> > is indeed long. However here constant blinding would probably triple
> > the size of the loop body, so for llvm this jump won't be long.
> >=20
> > If we consider this corner case an issue, it might be possible to fix
>=20
> This definitely a corner case. But full unroll is not what we recommended=
 although
> we do try to accommodate it with cpuv4.
>=20
> > it by teaching bpf_jit_blind_constants() to insert 'BPF_JMP32 | BPF_JA'
> > when jump targets cross the 2**16 thresholds.
> > Wdyt?
>=20
> If we indeed hit an issue with cpuv4, I prefer to fix in llvm side.
> Currently, gotol is generated if offset is >=3D S16_MAX/2 or <=3D S16_MIN=
/2.
> We could make range further smaller or all gotol since there are quite
> some architectures supporting gotol now (x86, arm, riscv, ppc, etc.).
>=20

I tried building this program as v3 and as v4 using the following
command line:

  clang -O2 --target=3Dbpf -c t.c -mcpu=3D<v3 or v4> -o t.o

(I copied definitions of SEC and bpf_get_prandom_u32 from bpf_helper_defs.h=
).

With the following results:
- when built as v4 program can be compiled, gotol is generated and
  program can be loaded even when bpf_jit_harded is set:
  "echo 2 > /proc/sys/net/core/bpf_jit_harden"
  (as far as I understand this is sufficient to request constant blinding);
- when built as v3 clang exits with error message (both distro clang-16 and
  my local build for clang-18):
  "fatal error: error in backend: Branch target out of insn range"
  so I'm curious which flags were used by Bram.
- Also, program cannot be compiled when -g is specified:
  on my machine with 32G of RAM clang consumes all available RAM
  (w/o -g "only" 155Mb of RAM are used).

