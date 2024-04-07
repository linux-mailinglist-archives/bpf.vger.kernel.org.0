Return-Path: <bpf+bounces-26123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C6D89B275
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 16:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5171F21745
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B838DEC;
	Sun,  7 Apr 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNx4sn9d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627737703;
	Sun,  7 Apr 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712499880; cv=none; b=sKCzdpfTg9Fm7AZ1gsjb9/MzCSPapNPjYz/Qb1UQWyko742wyuy2VhiaTE915CEGf/JJNL5HlvBl+a3vpOUX6nNoD/pApLxgBWSpytoZby5oXb97xNlUj2M/BMpF5QC+iaKvPn3Fr2TqH8p5CWEKqtPVPgrI7KxfVMY76pP2jDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712499880; c=relaxed/simple;
	bh=057EjmkWBMVcK9xKGnWCFqyiyABAvqqe5E02u7dyYAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUx72VSBWx/O3yqeQyqLjIpyBVx+cNwNfgnoeVhsICVZSjNzIwW8JUyZB8gu5Zml5wuDmt4faiXHbXBAneMVPCfkFnV41iewUp+0vBhG8iExggr1Hxmsjgmb1aBm70tZJ5b4zHRojnwbekxe2k/TF3PZTs2Z9tB5vHQ1lA0qDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNx4sn9d; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4156c4fe401so23403795e9.1;
        Sun, 07 Apr 2024 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712499877; x=1713104677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJYGJMn0SoZv7X1gCRhWkduuUEvK/yiFWdRu8bhp/fI=;
        b=BNx4sn9dBzxsu9zaOZGT88a9vflbpVGiWMSHAkCZAMMWf9JjsgqYxqDrd9c/TP0rdC
         9Wf2o+wWcNk5Qz9MCuQjYYxQWNK2FAgengeJDRfJwuwffM9W6K8VYY0mHHpFwHQj+jdT
         tMFjYnmt+tvSvvMj/Ks9M539ST48zTExvyidlu7Ukrgoaj2x3SOzZYzzRFppSU2zKFIn
         OTflMTzD9unSukT2MLH+9rsrKmLbynS4HrTzKLnW6XdSY3AYvretlDgdGeulMcjI66mr
         gkZS1kKyWYf2JwbLdeirxpOTtcRgK1kn2NrfeGGFd3rrobPpbp7q/LnvZ7R00ecgLGmK
         c2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712499877; x=1713104677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJYGJMn0SoZv7X1gCRhWkduuUEvK/yiFWdRu8bhp/fI=;
        b=xAAWtVaWtW1B2Osp4Z0TtUbQbEnJvOIdfeLGRBJF1jpBBeNZS5DSLnxxM5wM0RbRLO
         Y5CSCgRj34ExUzwpVsWYNWjT6Mr5WYqCMTAMMfLrV5y/Ldi5SEaxyiey1Pg9dIv8I3RJ
         cc867balHjR7YaRqffFm6ZT6TFq82O/aisk7jOxnZQUF59J3vQADxrTTTwhs1uLSgxqc
         f/q4KesOTZ5+m7wigkh/5Xq14CW9f9s8TIUM/ZG1yWggxSeuHewotXa6gyrWBIsLCZCX
         sf3q3MWUSoYfJ6fErVqoaw9OnNH7oz8R6mnd1LJ0osuonPCA5ToJS3BawGrKGDb/ykix
         os6A==
X-Forwarded-Encrypted: i=1; AJvYcCVS4Q093Y1HRhs7QXuxxihklz467xkSffKd8TaHmIqxUiM1hBmbkom15UtG3hXbhDZCereFf3EcpPXyDzaUKD/11PorNUFKEmseK7KD9wl8iIRsSgVWpiAoNDTtbIYM+S27q8W4IhCeK9Ouh2VzMFvGRz3q/r+A2T2d
X-Gm-Message-State: AOJu0Yyj937tc/45ct0UKzVikI/0yC1Hd4D3zjxHceKFkaBaTw2nM0rA
	vp1obCcIhh0t59dkTnC4yEUiSZy7/xYAF1p+Vgd1cOrV69nW3N8jElTU5FlxMhIziSzbA7zT0BO
	V7cxW2eKlUXu73Zp7XLRIpR3dA3U=
X-Google-Smtp-Source: AGHT+IGc8WCDaSVuw98k/nsa9KO1MD8OoUYVDAuzf2YYUvHO5mTm6E79lqePVBMzaAMumy0KDIe2R4KMCw3ArQe9s08=
X-Received: by 2002:a05:600c:34cb:b0:416:5192:a30 with SMTP id
 d11-20020a05600c34cb00b0041651920a30mr1649236wmq.3.1712499877213; Sun, 07 Apr
 2024 07:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b97fba06156dc57b@google.com> <b764fde2-cbf3-6446-d437-45af0964b062@huaweicloud.com>
In-Reply-To: <b764fde2-cbf3-6446-d437-45af0964b062@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 7 Apr 2024 07:24:25 -0700
Message-ID: <CAADnVQJ4BRO_85By7T7bJkxgN8tmzJkS3TvP2JMiFU3WwRT7yA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Read in hash
To: Hou Tao <houtao@huaweicloud.com>
Cc: syzbot <syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com>, 
	bpf <bpf@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 2:09=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 4/6/2024 9:44 PM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompati=
bil..
> > git tree:       bpf
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D148ad855180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fb1be60a19=
3d440
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9459b5d7fab77=
4cf182f
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13d867951=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D143eff76180=
000
>
> According to the reproducer, it passes a big value_size (0xfffffe00)
> when creating bloom filter map. The big value_size bypasses the check in
> check_stack_access_within_bounds(). I think a proper fix needs to add
> these following two checks:
> (1) in check_stack_access_within_bounds()  add check for negative
> access_size
> (2) in bloom_map_alloc() limit the max value of bloom_map_alloc().
>
> Will post a patch to fix the syzbot report. Will also check whether or
> not there are similar problems for other bpf maps.

Isn't it fixed by
https://lore.kernel.org/all/20240327024245.318299-2-andreimatei1@gmail.com/

