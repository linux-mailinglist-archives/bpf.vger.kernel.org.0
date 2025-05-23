Return-Path: <bpf+bounces-58837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC1DAC2609
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 17:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E18B7AE03A
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A8296711;
	Fri, 23 May 2025 15:08:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504D35D8F0
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012889; cv=none; b=JJANHWzuR64KdadIvOx6KBiou0X68FMLkiKAC+exciKtjTHtgGiqoAj/kk1zqMUV6DonwNDtURR3lg/D+VUUXLD1iM8ZY8V/kKpiiALfIkC4WbNrJwBvE7YVagkzpS8Mzmn42LckDiBDpqcAYbDIpxUxRAviK+b5eQjTGgo8AVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012889; c=relaxed/simple;
	bh=i+iXLNvGMTATkR4803QYEOC16erbRJNZXIzx8Xw0HYc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A8OHF/uPk6+wRh4EI+3/nWEdnViIG3lqsia+IyORkavQYB8rjO9xoI2eQBKHyhfMAsvgKY8nYyi9XF66g0gNaqdHtcJgbb1BdvOYdqKpF96ZCBagy134d9NaZCutSe8VSxqsOqQ4rEQTBa1H2blrB4ZjkgRXllYxRxs9zOil6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3dc62c92d5cso67485465ab.0
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 08:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748012887; x=1748617687;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmr5S6Im8u0H817gwM37MBHCKU+4Gc2sIDVkqkOIiuA=;
        b=EkxDHobi30WYqJ9VU3FsKrfTkNMT3hOPs74EnQYYFHJQKAvQ/OSUxSGC3/wN21mqqU
         z9Ku6nqEbUIyD5Tx52BBwb3Lmi1vxn0eEzvANb7WjfeemsvuUJuDEgv37MKno2Er2Yk0
         IxhEs3DZ1gegmao5gguD6Qxh9j0+JAq9z02YZcTKdVBOyKzRqdNUIMn50sy6xz3wvtry
         0Zw55vajedpbZSANJr+6PtmAIO/HpwIzzG6Z6u+brdqllhUi6A3qn9OetNy02onYXI0P
         b+LGZ2LMpXkQdcVS9ku05V3KQQFdHqsjtEFxctrgPKolwJdbDxYnjJz9/7R/gJlz3VZN
         z6ow==
X-Forwarded-Encrypted: i=1; AJvYcCVMWAitpHl4nFlgsGbv+yZnXOyDOwi4y2tgWGMoKUX6Ztb3iKbvBivT1r0z/VCa4okwxYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjiNG71zNwMylqxwx7cLYKKeNQlXPGAkCh0YHD896G5MJ1I5XY
	yyqDXNVJD8WELN8rlt4gEr0nqbZ5g3AKCnfVoYgcbIGb9rTRvZmRjON94ldvodtA8tFocCgFFiY
	a68c35Xr5pjAN95B52IcUxrrogbtDOn8WzNx9J74S8hjfj5XTOooXp/Soz4s=
X-Google-Smtp-Source: AGHT+IHDobLa4xYg9FQCxm1cqLMjYS7GvPxRMFT4ju4YhG6UZLPg2I2+dWkd/7/iXpAed8cH5xLnYDh3fovvkw25t3CkFf3ZLAmr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3d5:d6ad:286a with SMTP id
 e9e14a558f8ab-3db84313973mr258182195ab.13.1748012887430; Fri, 23 May 2025
 08:08:07 -0700 (PDT)
Date: Fri, 23 May 2025 08:08:07 -0700
In-Reply-To: <634e5312cbaa01a31fe8781167dfb2dc8e932f2a.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68308f57.a70a0220.1765ec.014f.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in __bpf_prog_ret0_warn
From: syzbot <syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, mannkafai@gmail.com, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com
Tested-by: syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com

Tested on:

commit:         94305e83 Merge tag 'pmdomain-v6.15-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113f45f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a6bdf3bbc4e852
dashboard link: https://syzkaller.appspot.com/bug?extid=0903f6d7f285e41cdf10
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174f45f4580000

Note: testing is done by a robot and is best-effort only.

