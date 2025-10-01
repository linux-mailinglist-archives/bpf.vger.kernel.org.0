Return-Path: <bpf+bounces-70133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78741BB189B
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 20:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825087A4643
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 18:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E49D2D6E48;
	Wed,  1 Oct 2025 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngJSxP5+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49F25A640
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344845; cv=none; b=n4GCF2GT6CFxgHT5+pWykxtBcYaY8c7URepKEJNAlrqXLqA5RzcHSWvpQ2VnF8qfjIX/8ngoDlcDAErtbBJQHFux067cBVveWcrv900JLHtytUaM5Ls7r2HjIdpQ9kX9duUqf6Y/bg0XRjgnccMTyDpp+zYbjlEkSPz/wUIthRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344845; c=relaxed/simple;
	bh=XNg9xjJ3/UwspigWAaGjhYXO4J9lKANanZxaLbJm7u8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m5HmJez2uf0AHfwKuwLqX2N0H38htXlei1F9EVkPhFkaBjwwa/eJK0MOz9u0uzSjBePQmFQ4y8jLdPPHkT+5ICLBvu6lhWLY93mvseaDR187msKp7YZMMz4G0tWTb/02NhyItd6cEqoTF/hB1Cak/KbtQ4lXHhxclPaZsnLZA9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngJSxP5+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-269af38418aso1501385ad.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759344843; x=1759949643; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eX/firA/xiO7qDk1Fjec32UpAU9zzdAdtIubnbzrcJE=;
        b=ngJSxP5+Y5/DFrIKb5aGINL54Y1krIxKtf6MRv4AjLiAaal25GYSahevmfRd2NvMpk
         csWz1VWWyaoF7Hv2q9443U1Oy29IUutcFk5CvpE1o239qZrp2WaZ8GmeamY8XIJV9Tv0
         wMVh3XglOJLvL5zp7bFhRvqSpKrbRw6SBXZ6oa7RwcGCv+E3an934dBofZReuVcIZ0Tz
         naLgTTWp5sW5Xk43roZZV3fnAalKc3dj6dutmHSZJHKOtO65drFIewdSHlYX16R2ibfI
         6A8OQWPZyr06CJUOO4u4hDHTvUEreuSoD+OY8mPDY2x/d9oG6Hpgx2E796x1d7kUwimi
         63Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759344843; x=1759949643;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eX/firA/xiO7qDk1Fjec32UpAU9zzdAdtIubnbzrcJE=;
        b=h3SSqCkYaeTa7wP2jM6zrgNHDHLYODHifnbYyLKWpcikM5QtNUfWHlcCQm56jy0hjF
         TTVe4Rq68NqWS0/khUruEhJGaScLr+B/z9UnCKYkG+aDmA00ki/IMRdpQodV/P/b2OpE
         BhQlVPf5FvH0yZYgrlrjdsjykj7dnZLsPZ+Lm5ndzsXMUga5o7ooQmxfwCLgPu558vJd
         P2Rq0NVngI3lQm66hLvpU2nYneeK4GKPF68jaPcL2VeMM+sM50P97R3jmxr6fLA8e7y1
         MUEGOGFAh60s4pAHnNSiLw3xbid+xBo/EVXdVim4K/dA07t6PBg9SvU2IjYZUx6zTEMm
         44aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh7wyTvL9/fHSEOdFK/0HClN1DxQtQw0/Wju1IrYEEv37KIKMC0x7toGokzBpULlirkXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HdDX+UqKWYyudxfls7hjjfHqx8IkoEH/D0MZdmeRq8LpeEie
	peWRccgB2NrU2cF/sKy647YvhIlpZEdClOcBhPuEJSdK6SYsiKgcBz75
X-Gm-Gg: ASbGncvRmT7He9fr+JooVURKDJM05BAXUK/nVQk/YxnMbTD3fpDzk0GrQVORL+ZUQMa
	DInzRO0EuBXVsl9XzFVf/VulGaZ3bKdKJF/zukYzW+KYFFuOtXjM4LreID86zLrboO5R9LM9MTg
	s2+BhXEGP/1A2zPTOMF3ScUSFo+bcOElPhMCarejPi1C4hwFpCUkVePSvkbXe9Pe0T+3nNasXA4
	LNz7lzwNv1/8RKM+wnCj44eDGFIECfYfwXOf2yf4qBACUuolcwpeu3oLF4PrTDkeKJQhiYtY6eP
	N6zHPjlcj1mPka0rSZ3pC02xGgk21RSVXob9pu2R505RnevN0r5sTHXdVT2CqbVxLLG1QTE+j8F
	X2v/m4Xjc/ixwAgRCBX3wu/ro2ssTa9JhK6opMB53CSgt1+x2inFFNEDi/ClB/fcEFdbZbdc=
X-Google-Smtp-Source: AGHT+IGjwr/BLVhgI6N3+8rc531F3qJG+8YZmu6vKODZ0amBPkqinY8F2D3nh175ChO7UG9UWBoSlQ==
X-Received: by 2002:a17:902:e94e:b0:24c:e6fa:2a38 with SMTP id d9443c01a7336-28e7f298119mr60479185ad.25.1759344843577;
        Wed, 01 Oct 2025 11:54:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d582asm3048445ad.113.2025.10.01.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:54:03 -0700 (PDT)
Message-ID: <3b9a4aae9265fd8cc9a7c9576b8b1c54cd2933d1.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: Skip scalar adjustment for BPF_NEG if dst
 is a pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com,
 andrii@kernel.org, 	ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, haoluo@google.com, 	john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	kafai.wan@linux.dev
Date: Wed, 01 Oct 2025 11:54:01 -0700
In-Reply-To: <zq2pmlsmmduelzniwez7hnwygx5vl2byrvtvjfabpjtvrwjcxl@eej2larvujkk>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
	 <20251001095613.267475-1-listout@listout.xyz>
	 <20251001095613.267475-2-listout@listout.xyz>
	 <0a2232a7faa9077ba7a837e066bd99bab812e4a6.camel@gmail.com>
	 <zq2pmlsmmduelzniwez7hnwygx5vl2byrvtvjfabpjtvrwjcxl@eej2larvujkk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 00:19 +0530, Brahmajit Das wrote:
> On 01.10.2025 11:29, Eduard Zingerman wrote:
> > On Wed, 2025-10-01 at 15:26 +0530, Brahmajit Das wrote:
> > > In check_alu_op(), the verifier currently calls check_reg_arg() and
> > > adjust_scalar_min_max_vals() unconditionally for BPF_NEG operations.
> > > However, if the destination register holds a pointer, these scalar
> > > adjustments are unnecessary and potentially incorrect.
> > >=20
> > > This patch adds a check to skip the adjustment logic when the destina=
tion
> > > register contains a pointer.
> > >=20
> > > Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Dd36d5ae81e1b0a53ef5=
8
> > > Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")
> > > Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> > > Signed-off-by: Brahmajit Das <listout@listout.xyz>
> > > ---
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> Thanks
> >=20
> > Nit: I'd made this a bit simpler: `regs[insn->dst_reg].type =3D=3D SCAL=
AR_VALUE`,
> >      instead of __is_pointer_value() call.
> >=20
> > >  			err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
> > >  			err =3D err ?: adjust_scalar_min_max_vals(env, insn,
> > >  							 &regs[insn->dst_reg],
> Do I need to send a v4?

As you see fit.
If you agree with my suggestion, please send v4,
leaving it as-is also fine by me.

