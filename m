Return-Path: <bpf+bounces-33038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0844491614B
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 10:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267E61C22693
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D2149C52;
	Tue, 25 Jun 2024 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSN+LJz1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94F1494D4
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304309; cv=none; b=VJPNjfNmIyYePJ1waDOdtCXEApCPQqJdS0SwmbFEdkWTr/1DkUOdO4FAHlSsUxLGKj9+Tek+5d6LlLcX0OHgeB0Ymu+mA0wuZB7+AfmxekVvs4g51C7pQZb/c9yeXwT4vKVr3OSDtqThUCxnyotfEsRMtH2dMGSF6TcXfnQG0DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304309; c=relaxed/simple;
	bh=pI6yLhOyRtdy8oxe0FK9HXZLboabZH126vMqWOQ4Gvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9JSByD1HRmUFiJM/jb+KPxOaRbQ3NG3oL6pCb/vtqs+oNvl+j26lrwS8+v0fwNyMzklmfBvdtnrmot6PnGFVkw6ypdgMELoNFk6DyawCFYoCJ9BRHAC64T4QS2mvS7tplfAmm2ukeV9orRgpJjy0qzyAKguBqe62x7m892OMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSN+LJz1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so7656a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719304306; x=1719909106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpHWKWgmumoPz4qi4qRw5mSmRbCSXF9APYjL8k1PWDU=;
        b=YSN+LJz16vqI5EyZKB2HgPOkPDcrRPsD8+ktDdZocJXIFZXf/l06HC0NqFKaHuGaed
         79V3ALoY56DKaWoUWNfvBuyBeUT+WaOkvqTbYUTAcilIkkbupQms4arbd9HtiB79Au2z
         1SG2RTihI3XL7Usw9z3DcpCJ5tl+xIJ4+kOGL8l8SH/jWEMV7JWRj8mbN3xmV5rpznw/
         3dVbyeyDHcOSssvtLs1u1yHXeDXkSTnQj6RCn3etAPpEi+Org2DCgFsgAyo6NZe+vZwQ
         KuPchGOzlTmY5RbTM9s3Cnbi1r2l5yCmfQM/EnWGyftF8hI0CRqXjn1XkZMe/5uM5n+e
         wxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304306; x=1719909106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpHWKWgmumoPz4qi4qRw5mSmRbCSXF9APYjL8k1PWDU=;
        b=n2APaMceCMY1xk6Oh1v0TG8fH2NBu7BvMSz0Og5BP4MLhFx8hUxUw9WyGirqksMNy+
         6i9BnlgrHb6t+J4TUCx4czPhJsHX9ecThAYan7c2Sp4uqxtsO2h/wc6nEiFYQ8reLly5
         Fp9AcbsMNzLuPqhHn3hHwGgwY0Mf3NWR5KGncm3GewnEzhwKmG/eGN7H2mjHgAzYZwip
         snKcQV/f2c7trSkH+UzHqtzFlaeqXdV/Ya77Oc6HCrN6VDuQcwulEYKDzqqD03cazj0A
         bYwuARQ7I3ISEAv28NKIY9btWQUcurDdREFLRSB84EdfV3h0o95b0mydY9JT6yLF9Kgc
         NkHA==
X-Forwarded-Encrypted: i=1; AJvYcCUnPxSbssEhuHYTtXJ/u6tFc5uxPB71uEmECGGOwHjOLEgHsJTvD5KtLWAfV/cuo2DFdyq8g9eiHym9x2wnzMhm5wtC
X-Gm-Message-State: AOJu0Yy9mNxeHoHT/fROorx9ZMCYhOxMXnmquJ7gD7wFXzxELLY6YBNB
	UOKTcc9nMruzmOahpPJoIHT+3dteTCU586PSHbAjFbTUq2d5AFGcgS4O+YXaMuLVyTRT/ey3peo
	vemD73Giaj8Ne/t82OQOM9RUclWbU2SRuXSWg
X-Google-Smtp-Source: AGHT+IEegJAJuE8jEL5mXWwu48giZeFhMcPkTmCYjs9Rk7y/5KU3i6hknr5+Rr7xyK8x6Q+ZunjqBKyHbUV2GKAs428=
X-Received: by 2002:a05:6402:2682:b0:57c:d45d:7571 with SMTP id
 4fb4d7f45d1cf-57dcde35b18mr159009a12.6.1719304304642; Tue, 25 Jun 2024
 01:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719302367.git.tanggeliang@kylinos.cn> <ad1ecbd205b357f1f73500522a2d495cb6c0cbe1.1719302367.git.tanggeliang@kylinos.cn>
In-Reply-To: <ad1ecbd205b357f1f73500522a2d495cb6c0cbe1.1719302367.git.tanggeliang@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Jun 2024 10:31:33 +0200
Message-ID: <CANn89i+WKB9E5-r0RK0oWj9HdwB8w1EeZB7F1JhD1R5JtQGcyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] inet: null check for close in inet_release
To: Geliang Tang <geliang@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, Miao Xu <miaxu@meta.com>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:25=E2=80=AFAM Geliang Tang <geliang@kernel.org> =
wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Run the following BPF selftests on Loongarch:
>
> ./test_progs -t sockmap_listen
>
> A Kernel panic occurs:
>
> '''
>  Oops[#1]:
>  CPU: 49 PID: 233429 Comm: new_name Tainted: G           OE      6.10.0-r=
c2+ #20
>  Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK201=
8-V4.0.11
>  pc 0000000000000000 ra 90000000051ea4a0 tp 900030008549c000 sp 900030008=
549fe00
>  a0 9000300152524a00 a1 0000000000000000 a2 900030008549fe38 a3 900030008=
549fe30
>  a4 900030008549fe30 a5 90003000c58c8d80 a6 0000000000000000 a7 000000000=
0000039
>  t0 0000000000000000 t1 90003000c58c8d80 t2 0000000000000001 t3 000000000=
0000000
>  t4 0000000000000001 t5 900000011a1bf580 t6 900000011a3aff60 t7 000000000=
000006b
>  t8 00000fffffffffff u0 0000000000000000 s9 00007fffbbe9e930 s0 900030015=
2524a00
>  s1 90003000c58c8d00 s2 9000000006c81568 s3 0000000000000000 s4 90003000c=
58c8d80
>  s5 00007ffff236a000 s6 00007ffffbc292b0 s7 00007ffffbc29998 s8 00007fffb=
be9f180
>     ra: 90000000051ea4a0 inet_release+0x60/0xc0
>    ERA: 0000000000000000 0x0
>   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
>   PRMD: 0000000c (PPLV0 +PIE +PWE)
>   EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
>   ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
>  ESTAT: 00030000 [PIF] (IS=3D ECode=3D3 EsubCode=3D0)
>   BADV: 0000000000000000
>   PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
>  Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_=
nat_tftp
>  Process new_name (pid: 233429, threadinfo=3D00000000b9196405, task=3D000=
00000c01df45b)
>  Stack : 0000000000000000 90003000c58c8e20 90003000c58c8d00 9000000005059=
60c
>          0000000000000000 9000000101c6ad20 9000300086524540 00000000082e0=
003
>          900030008bf57400 90000000050596bc 900030008bf57400 900000000434a=
cac
>          0000000000000016 00007ffff224e060 00007fffbbe9f180 900030008bf57=
400
>          0000000000000000 9000000004341ce0 00007fffbbe9f180 00007ffff2369=
000
>          900030008549fec0 90000000054476ec 000000000000006b 9000000003f71=
da4
>          000000000000003a 00007ffff22b8a44 00007fffbbe9f8e0 00007fffbbe9e=
680
>          ffffffffffffffda 0000000000000000 0000000000000000 0000000000000=
000
>          00007fffbbe9f288 0000000000000000 0000000000000000 0000000000000=
039
>          84c2431493ceab6e 84c23ceb2827425e 0000000000000007 00007ffff2271=
600
>          ...
>  Call Trace:
>  [<900000000505960c>] __sock_release+0x4c/0xe0
>  [<90000000050596bc>] sock_close+0x1c/0x40
>  [<900000000434acac>] __fput+0xec/0x2e0
>  [<9000000004341ce0>] sys_close+0x40/0xa0
>  [<90000000054476ec>] do_syscall+0x8c/0xc0
>  [<9000000003f71da4>] handle_syscall+0xc4/0x160
>
>  Code: (Bad address in era)
>
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Fatal exception
>  Kernel relocated by 0x3d50000
>   .text @ 0x9000000003f50000
>   .data @ 0x90000000055b0000
>   .bss  @ 0x9000000006ca9400
>  ---[ end Kernel panic - not syncing: Fatal exception ]---
> '''
>
> This is because "sk->sk_prot->close" pointer is NULL in that case. This
> patch adds null check for it in inet_release() to fix this error.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/ipv4/af_inet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index b24d74616637..34a719e98c69 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -434,7 +434,8 @@ int inet_release(struct socket *sock)
>                 if (sock_flag(sk, SOCK_LINGER) &&
>                     !(current->flags & PF_EXITING))
>                         timeout =3D sk->sk_lingertime;
> -               sk->sk_prot->close(sk, timeout);
> +               if (sk->sk_prot->close)
> +                       sk->sk_prot->close(sk, timeout);

Can you tell us which inet protocol does not have a ->close pointer ?

I find it hard to believe a day-0 bug only hit Loongarch arch in 2024.

