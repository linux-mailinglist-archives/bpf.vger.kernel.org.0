Return-Path: <bpf+bounces-62572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD011AFBEAD
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E98560C07
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 23:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B59E28DF3E;
	Mon,  7 Jul 2025 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAqEMyjP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5123505E;
	Mon,  7 Jul 2025 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751931376; cv=none; b=khjMcLuBH1DIQhx7jJATCN7LUgHlRp5RbMgIAWJLrfUEhI0D37gsThr5Ihk8WdxWgym5oKsmZCpgZwya8zzNkhXEMe1e21IQWO9AnM3MqLFjZ8bO5BD+N3xqJbTFG8H1U+W+vDCU28qpXGVVeiBpQEEXAbJzSJrayvZY5ci1xWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751931376; c=relaxed/simple;
	bh=Pr3sALqF+N5aZ2sdsYGVJSxhPgZ5e9unSJK0ZIOajjw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DLuTPINuFUHsDD4UOL51hUWRR1WEQLm5KGACMVHTWxPAdV814OQ4xN/Jh1xlWl+ogN5RgxcN+tK9LSW9kr9XhqpvFuOJuRLhD4xjZCUYnx4cC0DcREEDYIs9ZENsRerfGQ01Z2ufZc7V8Jzg6SeI7a7jDF/LdmFqypFcfRyUm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAqEMyjP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso3087184a12.2;
        Mon, 07 Jul 2025 16:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751931374; x=1752536174; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zTRXpQFCBuVvy0UuWiZ+iB36926nB5IuVGmBeZ3do+I=;
        b=nAqEMyjPJafQ6UwLdmdamvjj9c9JWX1uJsnYsCV5UFrgsuisqqhOHPLp2EnJ54xXSd
         4nINR2J0OzlFia8Mc5FO6brocTdoQtEzqyAC25pzePKmIZ2V0BtR8bRsBkFOizXboW0g
         ZxfOPcnSKBGq0LLG8lBUwj/2Y0eMYv6km/IaHsfCUOUPXQWdZwBojgEZ9NT6Pu7uyVTc
         pciPxbxRlNv++zLeLD3rVy1P+mMHmluX/s9eg+VmTx+b/3rBWUaqJqwvk5yIEtflNe9a
         I3W7JqC0pgS20B1cUY8PrxSLPJmVcnjqgPU6FUvxTsqCFBHa3qxe2xuzG3fRNNMk8/g+
         Agvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751931374; x=1752536174;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zTRXpQFCBuVvy0UuWiZ+iB36926nB5IuVGmBeZ3do+I=;
        b=MYTvIPgKjx11dZ3Tn6Mf5Z/A0pyCPwjAm8bSdF0Hl/9gtbvdQ7VucjkZdPjjaB6hPb
         K/mU9b3vhgd4boMmqWjjZ2aSCIYbvxZUnYD4NFgVnsv2w+zQDiVj/oRAycZ6Yh4oZ3VZ
         SzMoDgytlc7SLzFMkToI9jZFz9A051O8xKw7P1Lg4otTZAKe1FmM4YsGLpPHDLCs9KC/
         al+rPMTvQws+U5Y+imx1XLTlck4aSRYhv909Jbdp2rtIxR0xQHEy+R1d3q6WS3bIqFik
         BXeL8u458qIuOGAM2ly68nioxzhn72eGLrNOKg5kWwIY0DA96j6onVjvjqH8wer4tDcz
         bT1w==
X-Forwarded-Encrypted: i=1; AJvYcCUOTwoenCQx2Zp/M7h3+dGXL64j9MWrl4h2QP5K89tFk9qGuxfa9BSda2qMfrikY9S7MzyUb5VtLe2NNl46@vger.kernel.org, AJvYcCVtIBo7j733aG0RLlVSARldeO+9me8+XWj2PSwywp881WeH9p2TxKAKt+6xVGo1RVpiL00=@vger.kernel.org, AJvYcCWUVXK7XSg6RJ8UfxVqbKtfTS6Ae7mZO/Hz9mM/4VvjygSbhj07Wf34qzYFZlEG+gplwbj8jPDr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uXm9b6hHud/RNjvGrgICawl6GXoYQU9eONGPOxLZGKMJebZm
	2eMOAaMa5RdiOM7YngRoewvP1jT7V9YcbK8doafkR93PCHoC1G2PXStJdc71euAsTPI=
X-Gm-Gg: ASbGncs4pc/C+rXNUcOv7Ndl6nXBNWLhE7NMFIEjXus5WRL+z5+yllvG8y7okzATU8O
	mGbWibrOyPaktsgMWomfvTW3JIuMhM7TyoLhWuhfNcvsGQ4mXyfjbEueII0H2N8GSpcDdINbWn0
	mc5bPcGk7G2A84XK2ypEj/YBvDDLjPJltDgzR48cSfsbMz/imZTWzH3Ap8qn87G72/Q+h+OAx3d
	c8Ltmu6dvLp2ZzTviE4iz2QN5MzF3mZca4mQPVr5HPuyBIrLNKFOA1obIADbHpJqMiy8LKO3wN8
	Pr19OEhsIlPWi2fA892Ae9WQQ2RdPBzR/cVPN3eJKfCE+OcAyzTzO/QuQipBHTL5c90=
X-Google-Smtp-Source: AGHT+IGe4r893RPo+gSzaNrS8d38CyVFf73Yz3sz5+lyrWbCm2Pk60sAswkCLGUoxBcrxxss0JD8iQ==
X-Received: by 2002:a17:90b:4f4a:b0:313:15fe:4c13 with SMTP id 98e67ed59e1d1-31aac4dfe46mr20039017a91.27.1751931374416;
        Mon, 07 Jul 2025 16:36:14 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:6ad])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21e75e6dsm467430a91.32.2025.07.07.16.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:36:13 -0700 (PDT)
Message-ID: <7cc3cb3de4335b8da8396f08bdc6a7148bfcbbbb.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, 	sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, 	yonghong.song@linux.dev
Date: Mon, 07 Jul 2025 16:36:12 -0700
In-Reply-To: <aGxC2aVjAm4m7oTU@mail.gmail.com>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
	 <aGa3iOI1IgGuPDYV@Tunnel>
	 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
	 <aGgL_g3wA2w3yRrG@mail.gmail.com>
	 <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
	 <aGxC2aVjAm4m7oTU@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 23:57 +0200, Paul Chaignon wrote:
> On Fri, Jul 04, 2025 at 10:26:14AM -0700, Eduard Zingerman wrote:
> > On Fri, 2025-07-04 at 19:14 +0200, Paul Chaignon wrote:
> > > On Thu, Jul 03, 2025 at 11:54:27AM -0700, Eduard Zingerman wrote:
> > > > On Thu, 2025-07-03 at 19:02 +0200, Paul Chaignon wrote:
> > > > > The number of times syzkaller is currently hitting this (180 in 1=
.5
> > > > > days) suggests there are many different ways to reproduce.
> > > >=20
> > > > It is a bit inconvenient to read syzbot BPF reports at the moment,
> > > > because it us hard to figure out how the program looks like.
> > > > Do you happen to know how complicated would it be to modify syzbot
> > > > output to:
> > > > - produce a comment with BPF program
> > > > - generating reproducer with a flag, allowing to print level 2
> > > >   verifier log
> > > > ?
> > >=20
> > > I have the same thought sometimes. Right now, I add verifier logs to =
a
> > > syz or C reproducer to see the program. Producing the BPF program in =
a
> > > comment would likely be tricky as we'd need to maintain a disassemble=
r
> > > in syzkaller.
> >=20
> > So, it operates on raw bytes, not on logical instructions?
>=20
> Both I would say. The syzkaller descriptions for BPF are structured
> around instructions [1], though they may not always match 1:1 with
> upstream instructions. Syzkaller then mutates raw bytes, taking some
> information from the descriptions into account (ex. known flag values).
>=20
> 1 - https://github.com/google/syzkaller/blob/master/sys/linux/bpf_prog.tx=
t

I actually took a brief look at syzkaller over the weekend but got
lost tbh.  BPF disassembler is small (~400Loc in kernel/bpf/disasm.c).
I can teach myself some golang and make a copy of it in syzkaller,
but having some guidance on where to put/call this code would be of
much help. (I think that having program code in the report would be
of great help in triaging).

