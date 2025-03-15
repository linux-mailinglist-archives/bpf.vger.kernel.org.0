Return-Path: <bpf+bounces-54095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA20BA6274F
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 07:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DFA16F1F6
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E2919F42C;
	Sat, 15 Mar 2025 06:27:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8A19F117
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742020025; cv=none; b=NYmYYITUVfHz9jK2A2ON7B8Dmw9XFFDQyYuG4uRCY0Rz0599hDAovO+ZX7fz7a+gxFthul8X8TDDYGhWelGQX6dOIceltyOxxXd6vh1c4Bs6iQ/RPR7LvIHsj5H1aeS/asHqu3HcgUnkPckTz5EKjVAETQvJJ+sZ3S0xWZmGPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742020025; c=relaxed/simple;
	bh=8c8BP0ZMGpck2i/dkvXUZ8GUM3AehfiBO2W2XuuOlrs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=obZCGXP7vnO4vtYwF4J4MRdGqpIZ4Gw6+nbkAfkrm56JtdjwNHU+C4287SLhkmnjeYWynbRufEBriRfMLgxmH1Wri9Co91tKV6aTMLwtwVqqjAYOOh3r6Oufhv3PxOug1LL7qUvlrmy94B0G886aiheKA/XPEpKKZikCXtUvDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d44dc8a9b4so33188355ab.3
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 23:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742020023; x=1742624823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVtpvCBBSFNWY2hi10N0rrWtsxl0Zv5MnCY1nXMRHOg=;
        b=Mtob/YYdl0K+3xAUdr2VxcUGIN3Jrk8SHMLU91UU6WcucvRJ6kRTII03UffkLzkVMi
         g0SrO+E1u8CZTyOAs9bgqfyh5DVsZAiVh0dAjdHRpDfpkqu2h+YLfMwK2Cn8/3qNsT0F
         TuZdBHmlqBd4mfzJJ9NadoSLuxP2+/UmrdlhiwhLkd6sRjGukcpczcbl0VpSnAdIVSRR
         UUVyqXhPYu+Ozv28KxRtIsUrW+xh9zyM2+4GapVFzwccXB5od23RbnytCh/OkluuT95U
         jpK23w39E4Ca+n7Ee/jpcJY3KbAnN50Va9MSF3hbVDU2KxA6/yEhW/KWI65PCydHz5m5
         Y7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkdenQKIqsYu34Vhpyu7/wz9/XD+Ck4byUncM/kTcN0yriQMKahM8I09I5tdhhNag3LY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/BrR+1a/quaFRgSTjBfyp4NpSg8dxwzkrdHSGXE2vKP1QNnSN
	/DbflLnltsiQoElhSenMZSzBNOdz2Qg8sVifIU02RyWN8pI9jNeFkpa+ukKQRwzTdfd7/TIz2RC
	SsdqAhh65D28xGEAwlDFCi/73Sy5XY+BfA+iAV2vu9oG7IZ6dTuIBTRA=
X-Google-Smtp-Source: AGHT+IHc/Hlt9d/2Xcr2kHdqr9oeeMai8KZOoyvDaGLKjBOLJUUUPVjAKnMWCJKX9sd5n0l/KK74b5/g18o59nKXQM7eSaHz3zM5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d06:b0:3d3:fcff:edae with SMTP id
 e9e14a558f8ab-3d4839f5d33mr41770635ab.3.1742020023054; Fri, 14 Mar 2025
 23:27:03 -0700 (PDT)
Date: Fri, 14 Mar 2025 23:27:03 -0700
In-Reply-To: <20250315055941.10487-2-enjuk@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d51db7.050a0220.1dc86f.0002.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
From: syzbot <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, enjuk@amazon.com, haoluo@google.com, 
	iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yepeilin@google.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Tested-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com

Tested on:

commit:         2d7597d6 selftests/bpf: Fix sockopt selftest failure o..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1397704c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1188ae54580000

Note: testing is done by a robot and is best-effort only.

