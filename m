Return-Path: <bpf+bounces-67770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1286AB497C9
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 20:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EEDF7B58FD
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFC8314B8A;
	Mon,  8 Sep 2025 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SahPiPFA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18671314B60
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354427; cv=none; b=juWsBWzjdd/qHUfORCECMMVexLBc1zmsHSU9pjdl/rMugUrjKgeITOA2sei5ld7kp69Ji0jGLCsLAZLXybkwa2WBNbO6HPa+FuUUxW4a+b7f1/bEQsqUoMQt39YOJdTNK7TyjiMCSJ4InKcX8tzkuJxRd8zXXjnUF/rNUYt6S14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354427; c=relaxed/simple;
	bh=ArDTteNm9MOJDVPm0MPQ+3NkywvOOEVcIiDftLs6Ycs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CSakXx/m5qfOsLvDZ447WN1iYFwnYBt32ZLf4akvXXGFKbOWnm+pZNvFyzcO6FX+z+4f8t72bcD4ggbJ31ouZgr0e2fhnH6XaXzP1C6NMxMQJuFAQdn7t6/g6NECKC+lTF05buxCJDlDCL53tPT2r8UvxQ6EvXhalUrD3lJHS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SahPiPFA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso4054508b3a.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757354425; x=1757959225; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ArDTteNm9MOJDVPm0MPQ+3NkywvOOEVcIiDftLs6Ycs=;
        b=SahPiPFAJGkpOqK+uAVHZKofOV4KgdvcjsqN4yHOoqCjscBVtJf5hkWxodOwCfOx7+
         Px5DavYYi9MQpBWPnz/u6/2AR1x1/3zZcbJJP/wpJ31Vqph6H7YNxU26Xrm3prWHSZ/U
         WnUCHS2ZTlu4dvmzrZmIlCsZmYbtd2VWWSwlLpM2W3Kg/0+ZVAyuQhJcu0YGNGbXsxym
         dJZ2dTBm6uN0Zo2dXiD0wHMroQeZmQv7CTaU6BJwA9VLE2G5of6Tuz8vrQihBAU3b8D1
         bIvwvTVdbnCyH1v1RWTUDGnB8T0g8+YUp78iujgeytaKSZFWhpNXL6pd2z3NRQA0Ubmi
         jpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757354425; x=1757959225;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArDTteNm9MOJDVPm0MPQ+3NkywvOOEVcIiDftLs6Ycs=;
        b=SQT6xhCDXm8EvclnbrnIBAQqX/DNYWIt9ezqm7NpyhOSWm/8OfTGjNkTh/Q/fXolO1
         vtJ0hn5odPOClVz7x5+9jC+al8+NkyVEH5TpiuZ9bEZLmELHZKQquj/juWGo8XhO2tMH
         vTdbbQQtCZXSXex1uIOD+dYW27kDnvb6/SgBoZfJqUYdWEDUYcu92wmDyv3+1R59Fm93
         sn+Z/FiblQLXEl08xdks39sxUuSPTN2qdFeHDmPE+y+xxFwaJSe0PAS8MfHAucMEU0ca
         jecAyPOFmLVGlnXg2ftNMm6x+HeGJQrIGEbIY0XNlrSXGiDy8HdlP8LT6ZGir9m3mSWK
         mB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7kgnxAwfmc7I1c0E/NdBTxiqzZoakEnik2wJU/61VnhjxqkZgfFop+LUCic8fWsMkRvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVz4wmcflXDKiXASwUs+WjdFNP0IXEGKAuKvUwAn5uBMoENRqL
	Q7UMv0xEIgDat35LXOT7zMS4HUZkUGdtP0g7sKxT+T+3gjrXa9ChHWQ+
X-Gm-Gg: ASbGnctEMSpEfTO8VDt40CbXaQpYTdt1ZPrPTlElhBeSM3lomIq/7/E51d3mVFIMAQ7
	T3EcP9xoo9kTxUKSCZN73TxXLrd5dV+iTd6Gqbz1UUl5sfE6Cn74lB7fCW25D4VQqb2OX1o8K9V
	XmdUdbmP3Vu7RmTpSCEomLW+GwiwDK/nKYulriccUzBUu8N3cmKZFgQJJEpc9ey+sVyOULYRF5q
	hJW0q+d1xEykcqkQ1yzQRFBoGneccxKn3XDTv6QlF2eYn7+g4heRqbJFM9XUtFsDQCI5FycKlun
	uzQK2SCAMDUF4Vv/Ds4OUy+A+jOQfpErB6cNz/pAZ2wGZ/1h2zmXKvdE+Vjvw6fHmIkvzzj2rNU
	bmaVWOeCtWNv0cg14O+ZyYcbTJoIq1qRrrFkGrexthpgr6XQAenyHFCp+kQ==
X-Google-Smtp-Source: AGHT+IFl3A0tiSOO5sy0VIt1JcTPBYLa2cCFLc7gVDg0bmBFwaXmHwmc7qbYANpGSHd7nm1EalPsYQ==
X-Received: by 2002:a05:6a21:3384:b0:249:765e:d650 with SMTP id adf61e73a8af0-2533fab757fmr12183868637.27.1757354425113;
        Mon, 08 Sep 2025 11:00:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:613:2710:d29c:cd12? ([2620:10d:c090:500::5:c621])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a34fsm29580459b3a.6.2025.09.08.11.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:00:24 -0700 (PDT)
Message-ID: <cf36f407713920055fcee1e30c007d23a117e712.camel@gmail.com>
Subject: Re: [syzbot ci] Re: bpf: Use tnums for JEQ/JNE is_branch_taken logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: syzbot ci <syzbot+ci59254af1cb47328a@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	shung-hsi.yu@suse.com, yonghong.song@linux.dev,
 syzbot@lists.linux.dev, 	syzkaller-bugs@googlegroups.com
Date: Mon, 08 Sep 2025 11:00:22 -0700
In-Reply-To: <aL8XJI_gpHjjvX7o@Tunnel>
References: 
	<ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
	 <689eeec8.050a0220.e29e5.000f.GAE@google.com>
	 <aKWytdZ8mRegBE0H@mail.gmail.com>
	 <6d172613960339eff4b3a9261ef61a2c50f69dae.camel@gmail.com>
	 <aL8XJI_gpHjjvX7o@Tunnel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 19:49 +0200, Paul Chaignon wrote:
> On Wed, Aug 20, 2025 at 12:37:46PM -0700, Eduard Zingerman wrote:
> > On Wed, 2025-08-20 at 13:34 +0200, Paul Chaignon wrote:
> >=20
> > [...]
> >=20
> > > I have a patch to potentially fix this, but I'm still testing it and
> > > would prefer to send it separately as it doesn't really relate to my
> > > current patchset.
> >=20
> > I'd like to bring this point again: this is a cat-and-mouse game.
> > is_scalar_branch_taken() and regs_refine_cond_op() are essentially
> > same operation and should be treated as such: produce register states
> > for both branches and prune those that result in an impossible state.
> > There is nothing wrong with this logically and we haven't got a single
> > real bug from the invariant violations check if I remember correctly.
> >=20
> > Comparing the two functions, it looks like tricky cases are BPF_JE/JNE
> > and BPF_JSET/JSET|BPF_X. However, given that regs_refine_cond_op() is
> > called for a false branch with opcode reversed it looks like there is
> > no issues with these cases.
> >=20
> > I'll give this a try.
>=20
> Hi Eduard,
>=20
> Did you get a chance to look into this? syzkaller came back (finally)
> complaining about the remaining invariant violations:
> https://lore.kernel.org/bpf/68bacb3e.050a0220.192772.018d.GAE@google.com/
> If not, I can have a look at the end of the week.
>=20
> Paul

Hi Paul,

I have an unfinished branch here:
https://github.com/kernel-patches/bpf/commit/ef2e080a58206e23e3a521d2942f9b=
4d58a8627c
Don't like how it looks though. Planned on getting back to it this week.
Please ping me if you'd start working on a fix.

Thanks,
Eduard

