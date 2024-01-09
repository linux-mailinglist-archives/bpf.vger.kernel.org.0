Return-Path: <bpf+bounces-19289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5118290B9
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 00:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EE31F272B1
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 23:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070C33FB1C;
	Tue,  9 Jan 2024 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi96A61L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F443FB08;
	Tue,  9 Jan 2024 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso4027915a12.1;
        Tue, 09 Jan 2024 15:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704841884; x=1705446684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3/O8r8WMCN/mqaSAjimweyaQzbBXKE5blURfyCtW7s=;
        b=Mi96A61Lk9d8duF5L6gvhtbvJlsDNEMZp4EdR+/+waEUy4/tWNSA04nawBHPhtmlEp
         Dr8vfEpzGeZ6EVLijlRJhEwlzqw/3wYk66EVqewuV1Z5rYGclS6uzx1Sdpv1mWUoEeM1
         6MK3v1Q0bPqf1TwNUk+/H6A1fLmVQVPxXH+O4DGxeznc+RfvKfGB6NySWory0akx80aB
         bKcCFc5jMsVIbGl//qiIEDZdHNwhcf3G932RCMXtzPhinWa5sAEsbt/w64kHX6YbmY0W
         9DacEbmmQQDIML12qooTAfIjJTm5h8iBidQp+g7shOHfSPywPonr1ZsGTDz0QjQJdfn/
         Qp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841884; x=1705446684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3/O8r8WMCN/mqaSAjimweyaQzbBXKE5blURfyCtW7s=;
        b=N/r7J2LezwJLnRe/+em3rsDW7Ezt6if6s/Yrpr96FNqUF7P+FI6S4DbjHapvgHL4gc
         1YJrgbAnpviD6vp6uLjmAg/y7ySzpu8HDhIWQlBHi/Cp3CyLWUpHbI09Sco7MfQzYLWc
         qVkNx5fXQryGORcsE886MNaD26ZSHi+xUawPk/fi+LNNI/V0KCbvpi/RxlYGAKnC/jTz
         GTerZknu6pj7zBK4Ts+NnMr9BryvZQgf4HOG7KesKsD6qbTzAVEvTSmit8E9Wo1LtTDX
         NQUepjbjvIh28AwX7gWPN4i0adgk4H/YTsZylSTQ4LXjmelg/Lnb7yBAmyX89xqHdwGc
         yfLg==
X-Gm-Message-State: AOJu0YxBTYC0vmsWsaJaWWo8DhP/JgjzMI8PlYnVylTTYtFgf05lLsRO
	js03nGSW8M/cZSKl9JH9Aegyi6lBTawUzPKmTGY=
X-Google-Smtp-Source: AGHT+IElCGpFGfGcbo9l+q+2Dtf3w5y+2/e+ltxX6hhvNA8Ef06ASRD9eUclIYgqRWLUO4kC2Bq44YyMaNq6jLMcp4M=
X-Received: by 2002:a05:6402:1751:b0:557:2292:8798 with SMTP id
 v17-20020a056402175100b0055722928798mr33426edx.142.1704841884206; Tue, 09 Jan
 2024 15:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzbRzb0B-Wy-fZ05bUHn5UXXoiL5yO2yP_CKyciCFf9yWA@mail.gmail.com>
 <000000000000b0ef46060c2b2e04@google.com>
In-Reply-To: <000000000000b0ef46060c2b2e04@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 15:11:11 -0800
Message-ID: <CAEf4BzYMx_TbBY4yeK_iJqq65XHY5V3yQQ1PzfOh6OMQwyz5cA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in __mark_chain_precision (3)
To: syzbot <syzbot+4d6330e14407721955eb@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 9:31=E2=80=AFAM syzbot
<syzbot+4d6330e14407721955eb@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger a=
ny issue:
>
> Reported-and-tested-by: syzbot+4d6330e14407721955eb@syzkaller.appspotmail=
.com
>
> Tested on:
>
> commit:         482d548d bpf: handle fake register spill to stack with..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-n=
ext.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16064fcae8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df8715b6ede5c4=
b90
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4d6330e14407721=
955eb
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

#syz fix: 482d548d bpf: handle fake register spill to stack with
BPF_ST_MEM instruction

