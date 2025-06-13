Return-Path: <bpf+bounces-60609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B82AD929F
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 18:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4E0189D2E8
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28152204C2F;
	Fri, 13 Jun 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Zz/aeR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DAD1E5206;
	Fri, 13 Jun 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749831053; cv=none; b=PObyLV2a92vBjXhz7w5MefTYBQ21nqYPP/rSlDqjcvzvpoprmtWCn5l4KjMBMFfFADAQr823E67k5kHFs57C+sKI5MDct2hiZ5v/RvSsjCPVMJ+Yb+zBRh6w8eHd5AeCk0s9AA5LwDZPy78Wjsd4w4DSB9C6pAE1KGOM2tGYWIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749831053; c=relaxed/simple;
	bh=z+WePBzk4w5ikJl5l/DmIwsQJR4VLsERLZLA5wpvpHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JF9oxrVcWHBhJxz3WMvS4y1rpwuSPUv7LjwAW5ry06H1iPSIscu9yvdzDRAf/dpUdl01HetBP9uDySOvdgarvRDqLeiLR42A3PmHTByGH9YYK044g9f5MQc6gGaTfML30CemldCDHkPu8fvaXLhdQebtpecepLCqX43SXGPJKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0Zz/aeR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so13021545e9.2;
        Fri, 13 Jun 2025 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749831050; x=1750435850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DILrWX2YuLVPKDXNXPwayp6eHkUI1DUjfPvT2x/52No=;
        b=A0Zz/aeRT5Jo+wSgW0+xG74Wir+VX5uAzyrnsg9bYXipbJhY0EkOlPcK4Ckxj75L2L
         lHuC2ZU33hHL2m4G0XUfT9vxtuXJX+rreBewh71fG/b9mmOwUKthUlVW3oqN+pJlfCAI
         fEKN/6PUUR9tyR4Roae07onCgrLNebLcbSvfBAqL4pjdFfyH5/IDNi6VKEQOw4W87ZHg
         WY9czVbAW6bPcvgOOg39U4zK+DhYnFzsdy7cwtjqGqYZftRAmoKyQerehkoADA+xydAB
         cu9WpdhDwKCtkhNsA33ASiuOfc2M3kSk8G+Km3cg8X0F08GEl8PHx7yD4S5lj+Tagmzn
         hj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749831050; x=1750435850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DILrWX2YuLVPKDXNXPwayp6eHkUI1DUjfPvT2x/52No=;
        b=AaIeaPGv/BgeSRotOt+7bhRrxzUBGG+MLs4sidfXN2Kk7QRYa+N6TvjD8EDHsHmUba
         MVVZPEb8JrAr7WseycayaH1jClnRJbr/fZ2bCxBqPTD85RDkhA4GHPiQ6sByb3DjqvDn
         qElLBODmWHMKk0qQpZpx8M5KpnsUcthLk2ekUVAUkH1lSN7FvXjvwFoifPTzX+L7XPee
         Iok3iYXGxE+DRX246Wgo4LuSxemMwM6I8Nx7YJdkMndB0Nz6L4M60NwzMHyQABKXY5xs
         DoQaMpYK3bd8f8xBbhY7NW7AZuFXLSe5NSYtTKv/LXdRC4c8Qt6P+Qx/ssb9TjCLc/rW
         aKfA==
X-Forwarded-Encrypted: i=1; AJvYcCVe5rFeFNoyncD6vn26fnkmGKYyOBVxlqUpX8NhPOB+0oaeWeDwl3W3AbFDE1qCHfgPOKI=@vger.kernel.org, AJvYcCVgmC1LwvSg4QpPfWFk6uoZdAjXk5E6gOf2n29ZKpn2ihtPcB928IZ/sc3QsnLc/XAoYEIxzZGY@vger.kernel.org, AJvYcCX+eSpip8Q3IJJcbIGI5sECdP2/CkLxi9FYAez6Ft8xhu5ZueAUAXZ5T8KODKGs9u1RFBP2833EhgUGpmBV@vger.kernel.org
X-Gm-Message-State: AOJu0YwHOEI7u7h4KGZydoF257nMoxYg2G4oE3uxDA8+rnhJbjW/i1wQ
	3GSnY9yezNyPH+AFcZQ+qCp7BQgpnTFu1Ul9ig1HgV6DvhZCqWmQAkgZkrxrSuDEhgJ5IsQ41cO
	/pytIGaZY65ydSCwllqX+rAnT7n8s/Tk=
X-Gm-Gg: ASbGncvp1nP1wzNcPr+aUQRlWFJBIyGKa6X/aohXZfFDcfDCdURyfXd4Mn/4t2FJ8Zv
	QXrm3/RDt7TGJIPJ6L2MiwGZJGC7GjNBjz9RIlCYG35J7Gab51pILpJURSXwazX70nEfnj4+Xld
	oY4tZax+f0r6ZcZjDxAhV9+n1gaNii6BYmqyDayzcZABCGKDhytEfpS4huazJB8VNK1xB8BDZ4
X-Google-Smtp-Source: AGHT+IHvQ9887CxdzTMcRoXeEnar7nGslX8aj5s2kzSmDQQlLukEzU6+YCFYK4flojxTe5ApiQs2oZJ0aOQNmI9cr3A=
X-Received: by 2002:a05:600c:1c29:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-4533ca55bc0mr2375445e9.10.1749831049931; Fri, 13 Jun 2025
 09:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <684bcf65.050a0220.be214.029b.GAE@google.com> <3c89e1105e611812ae86fb6aafd346be4445e055.camel@gmail.com>
In-Reply-To: <3c89e1105e611812ae86fb6aafd346be4445e055.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Jun 2025 09:10:38 -0700
X-Gm-Features: AX0GCFtsmhm4IcqZGd5BCX0XnZXe1ySkkEYzz3GResZBxUbVEx99pnvuB5kzGXU
Message-ID: <CAADnVQKRsUcPkWBBA0442jakf-6dr9n9dii9pjSsSyqRS6NcgA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in do_check
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: syzbot <syzbot+a36aac327960ff474804@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 12:56=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2025-06-13 at 00:12 -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    1c66f4a3612c bpf: Fix state use-after-free on push_stac=
k()..
> > git tree:       bpf-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1346ed70580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D73696606574=
e3967
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da36aac327960f=
f474804
> > compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07=
757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1392610c5=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11a9ee0c580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/2ddb1df1c757/d=
isk-1c66f4a3.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6a318fc92af0/vmli=
nux-1c66f4a3.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/76c58dddcb6c=
/bzImage-1c66f4a3.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+a36aac327960ff474804@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
>
> Fwiw, here is a repro converted to selftest.
> I'll take detailed look on Friday:
>
> SEC("socket")
> __naked void syzbot_repro(void)
> {
>         asm volatile (
>         "r8 =3D 0xff80;"
>         "r1 =3D 0xff110001085a0800 ll;"
>         "r2 =3D 20;"
>         "r3 =3D 0;"
>         "call %[bpf_ktime_get_ns];"
> "1:"
>         "w9 =3D w10;"
>         "if r9 >=3D 0xff4ad400 goto 2f;"
>         "may_goto +13;"
>         "r2 =3D 0;"
>         "*(u8 *)(r10 -16) =3D r9;"
> "2:"
>         "if r9 s< 0x1004 goto 3f;"
>         "lock *(u32 *)(r10 -16) +=3D r10;"
>         "r6 =3D r8;"
>         "r8 +=3D -8;"
>         "r4 =3D r10;"
> "3:"
>         "r6 +=3D -16;"
>         "r2 =3D 8;"
>         "r2 =3D 0xff110001085a05d8 ll;"
>         "r5 =3D 8;"
>         "if w8 & 0x76 goto 1b;"

I suspect this might be the fix:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c378074516cf..e76eb0322912 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23950,6 +23950,7 @@ static bool can_jump(struct bpf_insn *insn)
        case BPF_JSLT:
        case BPF_JSLE:
        case BPF_JCOND:
+       case BPF_JSET:
                return true;
        }

