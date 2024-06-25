Return-Path: <bpf+bounces-33039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8F9916167
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 10:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509A2283635
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 08:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCB114A4D0;
	Tue, 25 Jun 2024 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1HhDFya"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFE1487D8
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304438; cv=none; b=klx5QuZOFYRYB/eEtOpMtGUbPt3u2msPSgA0ExnfotM6BzZqpAZ/Ob5hORIrXmle+6RYBWfU2BpdpCh8BYh/G4xzDBR7PqdU3MV07k1+JX7GcLroZX/IfOvhRA4GDA4KTQNKNdEg/IIGkAAEQ2FQkSX9eA/EJPHQRX3eTTwagzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304438; c=relaxed/simple;
	bh=3wSIv4dG+zqD1/sWH1bOTpHCf/y+0gM7r2AidH9sipM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmCx80M6CY/2b/of81iFh7YY9b8NzOYnQmG+endtIb0mDtuTYRu80D4yXxCIkg0ITigZ8RwaUWfNJHoUvxqlqaO3lYHmHTSlUTfqZgQZUy9ykGVWDYKrokIxFi1kVevHMG/ezomvVqLRDCBQEn63CuGrNxt1m0iwkpg0554cOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1HhDFya; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so7707a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719304436; x=1719909236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeUYiJnNAb5D0IWuiFx68WloAZOBvRMUqn5S2VhB/V8=;
        b=d1HhDFyagIuhASe2HZIsghm0J6OVom28sVXAtDjshHd+/uprFR6veKjmNZJNrcEfrC
         e0Y/wB1LD2MiTwhf+zGQQKmcMmMo4c+9Eol6yL1TyDe0QDI6QfSoJZdSGaE7xkTfTQ/5
         xKRYy/mZKIDdvIiCVG9daVOysVpHK4ZMkyi+S96sErevjnQ0gwLjmvhaz7x3+7cJMl+S
         XaLSqayN0eL3DvnuOgBJBK765OAgBUuYexjxs9Nob7FnE+GEFJ7ePVcTgA2FUPq0CPLL
         BCg2eqyc6QS3vJcu6HAf3RMcNlZ67a4qoFbzo9i6on6jjagpjmLz8M/EOLPWL4xHQh4n
         Pdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304436; x=1719909236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeUYiJnNAb5D0IWuiFx68WloAZOBvRMUqn5S2VhB/V8=;
        b=QmwQXbfCWolNtfT5rV22vb9a2aImWzTAHCKOSntNYTrGxPLUYE+xRs/zIvu5XBO5zX
         djKCdULgNGFSTvd49ArkSXtmGOx53yPQlF4P7N7fTvlDD+SvlTKaEraqoUIWQyJoGqhp
         a48K9BcqUPNgoNYP43w1wpCuQmeNJeaPBKX86Ml11plmB0Qe+ZtXJ+x6CEq+r5UKPHVJ
         1IVXqiFW4V3MEl1ypQGRBePPhr1wRIrKOPH2n3DwJI12fyM5SyDD3Sq6QWfGd0NNw/YN
         O4wnzluSMhe3BdZ+bTXcESZpdVBxXO5+G80dvGB4sAf7dI5jFRrmVXLdw6VOWxnJxfA8
         cgYA==
X-Forwarded-Encrypted: i=1; AJvYcCUrGHjMzWrVoTR8R5KCx0TXFX5AX106zH+noK6Xhb9Az9U43vKzcI8c43WT+2liijLl+Z64zquEnFHk4OCpcb5qEFpC
X-Gm-Message-State: AOJu0Yyv+RsQXtofxPs3L+3t24SvJg0izDAffcdg/q3LKirizDRvPPpR
	m75Ejr+31Z/3dvdghiE65gdfRuief5XMDjiVtvHWXvunBzg1aMn2U9HcdjovWrupdP/appwp1Ax
	r8IOXJDqKPrEwBLpiwwm5vqRazSFXoCJOwzL/
X-Google-Smtp-Source: AGHT+IHbazm8B2Z5muQ/cD5z0DMPkbB5xirFSbtDRpOriuTTZtfF0pXe1CteCRp7NvtfoyI08ExXFytZrzrl2bf9o0Y=
X-Received: by 2002:a05:6402:2682:b0:57c:d45d:7571 with SMTP id
 4fb4d7f45d1cf-57dcde35b18mr159588a12.6.1719304433406; Tue, 25 Jun 2024
 01:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719302367.git.tanggeliang@kylinos.cn> <072709ce77b04dc77523d4e8763c1fb47bf0913d.1719302367.git.tanggeliang@kylinos.cn>
In-Reply-To: <072709ce77b04dc77523d4e8763c1fb47bf0913d.1719302367.git.tanggeliang@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Jun 2024 10:33:42 +0200
Message-ID: <CANn89i+ET4U+4viDPq2vZhxeUT90kZz5mdh3XVqQhaAXnbs=rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] skmsg: null check for sg_page in sk_msg_recvmsg
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
> ./test_progs -t sockmap_basic
>
> A Kernel panic occurs:
>
> '''
>  Oops[#1]:
>  CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE      6.10.0-r=
c2+ #18
>  Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK201=
8-V4.0.11
>  pc 9000000004162774 ra 90000000048bf6c0 tp 90001000aa16c000 sp 90001000a=
a16fb90
>  a0 0000000000000000 a1 0000000000000000 a2 0000000000000000 a3 90001000a=
a16fd70
>  a4 0000000000000800 a5 0000000000000000 a6 000055557b63aae8 a7 000000000=
00000cf
>  t0 0000000000000000 t1 0000000000004000 t2 0000000000000048 t3 000000000=
0000000
>  t4 0000000000000001 t5 0000000000000002 t6 0000000000000001 t7 000000000=
0000002
>  t8 0000000000000018 u0 9000000004856150 s9 0000000000000000 s0 000000000=
0000000
>  s1 0000000000000000 s2 90001000aa16fd70 s3 0000000000000000 s4 000000000=
0000000
>  s5 0000000000004000 s6 900010009284dc00 s7 0000000000000001 s8 900010009=
284dc00
>     ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
>    ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
>   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
>   PRMD: 0000000c (PPLV0 +PIE +PWE)
>   EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
>   ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
>  ESTAT: 00010000 [PIL] (IS=3D ECode=3D1 EsubCode=3D0)
>   BADV: 0000000000000040
>   PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
>  Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE xt_conntrac=
k
>  Process test_progs (pid: 2824, threadinfo=3D0000000000863a31, task=3D000=
000001cba0874)
>  Stack : 0000000000000001 fffffffffffffffc 0000000000000000 0000000000000=
000
>          0000000000000018 0000000000000000 0000000000000000 90000000048bf=
6c0
>          90000000052cd638 90001000aa16fd70 900010008bf51580 900010009284f=
000
>          90000000049f2b90 900010009284f188 900010009284f178 90001000861d4=
780
>          9000100084dccd00 0000000000000800 0000000000000007 fffffffffffff=
ff2
>          000000000453e92f 90000000049aae34 90001000aa16fd60 900010009284f=
000
>          0000000000000000 0000000000000000 900010008bf51580 90000000049f2=
b90
>          0000000000000001 0000000000000000 9000100084dc3a10 900010009284f=
1ac
>          90001000aa16fd40 0000555559953278 0000000000000001 0000000000000=
000
>          90001000aa16fdc8 9000000005a5a000 90001000861d4780 0000000000000=
800
>          ...
>  Call Trace:
>  [<9000000004162774>] copy_page_to_iter+0x74/0x1c0
>  [<90000000048bf6c0>] sk_msg_recvmsg+0x120/0x560
>  [<90000000049f2b90>] tcp_bpf_recvmsg_parser+0x170/0x4e0
>  [<90000000049aae34>] inet_recvmsg+0x54/0x100
>  [<900000000481ad5c>] sock_recvmsg+0x7c/0xe0
>  [<900000000481e1a8>] __sys_recvfrom+0x108/0x1c0
>  [<900000000481e27c>] sys_recvfrom+0x1c/0x40
>  [<9000000004c076ec>] do_syscall+0x8c/0xc0
>  [<9000000003731da4>] handle_syscall+0xc4/0x160
>
>  Code: 0010b09b  440125a0  0011df8d <28c10364> 0012b70c  00133305  0013b1=
ac  0010dc84  00151585
>
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Fatal exception
>  Kernel relocated by 0x3510000
>   .text @ 0x9000000003710000
>   .data @ 0x9000000004d70000
>   .bss  @ 0x9000000006469400
>  ---[ end Kernel panic - not syncing: Fatal exception ]---
> '''
>
> This is because "sg_page(sge)" is NULL in that case. This patch adds null
> check for it in sk_msg_recvmsg() to fix this error.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/core/skmsg.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index fd20aae30be2..bafcc1e2eadf 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -432,6 +432,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *=
psock, struct msghdr *msg,
>                         sge =3D sk_msg_elem(msg_rx, i);
>                         copy =3D sge->length;
>                         page =3D sg_page(sge);
> +                       if (!page)
> +                               goto out;
>                         if (copied + copy > len)
>                                 copy =3D len - copied;
>                         copy =3D copy_page_to_iter(page, sge->offset, cop=
y, iter);
> --
> 2.43.0
>

This looks pretty much random to me.

Please find the root cause, instead of desperately trying to fix 'tests'.

