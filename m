Return-Path: <bpf+bounces-57735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C07AAF476
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 09:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6359C68B5
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 07:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1E21E096;
	Thu,  8 May 2025 07:13:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB5A21D3C7
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746688385; cv=none; b=Bv1UqPvZD2ll+Lz9lTmLssAu+8PT6LiDvG6e5+0pvl04e3qlUft9B1yydiO/ZkG4UApTgkjlc30dF6ULX62fiuPsgjyRlUBimONVaFodcMtlGzFlgn9+IdRS0huUd84s05s+Z6d+gQ9RyvGOj5qHX4563B3RmQhK9YOV3W+0TNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746688385; c=relaxed/simple;
	bh=wzd2oN78a5f/c5RFfKUvSeNBcAm+s56MJoEcP0uJOJ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qxuQpx5wwURqk3C8tX7ERahiltXxbztb5BphzOThZS7R16F95srw+uBNdu6Iro+J51qtl7YIPbt7US6K9WbUL4jxLP8/dvCUKMkD/eJ6cjGtEqNJJIThGf5P0xbQabN/h89sRx9NkAHtPnuu0Q8tlveIezudsN+tILYw9dA05ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d6e10f8747so7134675ab.3
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 00:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746688383; x=1747293183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aG8nEEjrmEeVt+FMIpArijkqqoSXM+l5mTr89aXDaco=;
        b=FrHYV1KbN4CCdV55riTsE5vKQRZTbycGc9kX8o8qjk8VAyol4plqmArjyuqkTI005B
         jnlwga1m9unKY1ez/R9WD7FyuaY3RVZhMHyJvTOQAP5ZNptldkw7gkYK8ssGrOcutLHc
         EKiFOCxKvnpk5xplGR6hsItaO+hN/mxPyBsiDbQ9Qa8nZXjWrnCEhLFgNjWysAZU4POF
         MM9juDXcYqoYMPqQdjnrj+b8efxoABoXqvDsAe2u4IFnovVj/AQFgj/d78Unq69EASmD
         Gdkn6rKD2H91cKUzWJqqYX/00CEdcjMeKLVuxDldmJNcddf7keFpsD9lQu8m9WEMmXhx
         8aeA==
X-Forwarded-Encrypted: i=1; AJvYcCWAaJi7SbFl6nzan6I0BVZxI2Ed0laXQGnZMc/ovgkR4vsphGxQs+8l5tHK+gP+P3wRDTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXOqzlNont19Cx4UEhugmJ8G1dNGLXOiTYWrBnfAeL8QOIdqsc
	6GHYlCz1TOjOu9euT3r8tQg1kFSbLrL3l+/7QlkAj975mTcartE4HLUeEcbM/C1uFuSKPp09R+S
	+ntxufDSHatuL7PWJXB2/16WEnuutsnbQU1FTRdtfXn11RLvRPPZMY7I=
X-Google-Smtp-Source: AGHT+IGwtuBYqtqyXs7WRh4r9OmvUUEzOExCVcEqx0h1T1Y13Uv2G2YCBtq+f/KGXA4sXFhBQN7tN/Kda77poO16j+d/OJj+D8XX
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:3d9:36a8:3da0 with SMTP id
 e9e14a558f8ab-3da7854d64emr31349925ab.2.1746688383016; Thu, 08 May 2025
 00:13:03 -0700 (PDT)
Date: Thu, 08 May 2025 00:13:03 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681c597f.050a0220.a19a9.00bd.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, elic@nvidia.com, haoluo@google.com, 
	hdanton@sina.com, jasowang@redhat.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	lkp@intel.com, llvm@lists.linux.dev, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, memxor@gmail.com, mhiramat@kernel.org, 
	michal.kukowski@infogain.com, michal.switala@infogain.com, mst@redhat.com, 
	netdev@vger.kernel.org, norbert.kaminski@igglobal.com, 
	norbert.kaminski@infogain.com, norkam41@gmail.com, 
	oe-kbuild-all@lists.linux.dev, parav@nvidia.com, rostedt@goodmis.org, 
	sdf@fomichev.me, sdf@google.com, song@kernel.org, songliubraving@fb.com, 
	syzkaller-bugs@googlegroups.com, wojciech.gladysz@infogain.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 47979314c0fe245ed54306e2f91b3f819c7c0f9f
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sun Mar 16 04:05:37 2025 +0000

    bpf: Convert lpm_trie.c to rqspinlock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140598f4580000
start commit:   c2933b2befe2 Merge tag 'net-6.14-rc1' of git://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108e1724580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177035f8580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Convert lpm_trie.c to rqspinlock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

