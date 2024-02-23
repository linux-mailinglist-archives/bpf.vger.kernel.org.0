Return-Path: <bpf+bounces-22622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E503F861F6F
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 23:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF652875EC
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 22:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBD914CAA3;
	Fri, 23 Feb 2024 22:14:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3641448D8
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726446; cv=none; b=Ud/icEjma+oz84zcvvnrHGjha7Agd252AUY5A8UX+8Xy6H+nGzGvNkXH5Ez+H2P4A9S8uPwzA1C3qESg1J6b9cQTgXgyJfGR5iZM9+km4dv55bDl1b4iAukLA4xyMjroYs2vnk0IFV5B4nASWWP8/TGp+3NYLI2/cgM2VYs2DTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726446; c=relaxed/simple;
	bh=+Ctr0KrDwCeMkU+RQ454ERPkbKZTfFHQEeCdfQoA6YY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QFwVCxHnYcHSurh+GmBLqk6+JJfqopgtAsz/hs2m9EVPlx1c+7zttGXUACCQ0aGGXH4lf0tpRoTwTSmJV9AsyBCLJXou+uvC1AVy2RnWregsmRVPYwr6BW5PcN0DRbvkWnW5xJAjK3oto7CVhuaQrNTsjCNcOYT8ihBPsyWapQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36576ec006aso12931675ab.1
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 14:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726444; x=1709331244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yKIsiHPc5N6utt+zlCMndtWwFz/JR5HuS2RY9FPzik=;
        b=iSiEMmzCOwk2RReHTjMBDqGs7TZwEXa4RyyC9q/KXhqUx3i+NzSbSzhWrDosZS/db6
         wuYPYkrBlkE3R8etm7dI0jDP4nOTeFDPKRVLgN+HFc3LDIS6/wtfgZHZQ5QnX4xrhPiw
         7NET6cNxMAqb8pNZw1JCwq2gZ1+jyihwHkcC85dyKhlUCNk8ewPCajWlKJhuXq5qIk4p
         ZzeoyqAawtBnZq2myQmRy/nE7tazxWTAY69TcV4IyvQJSXOhDabaWfhsPYXbqEn21acq
         iUBg28/K46YEe7wwyLmJHnLOIjhda8hz5pwSznltpErOyg6HGLf8h7Fo8xYa5LZc5XzZ
         GDHA==
X-Forwarded-Encrypted: i=1; AJvYcCUVAjCxXVuPd+/SX0tBSuYQyT4y9lXgPp8MZKpykm3bl5Dgs2eOf07OUBr4/MBU96JCfz56z6t4v88XBMi+5zAQlOL6
X-Gm-Message-State: AOJu0YwxLZoL+ttA1nGky3LAwcqB2LnYe5DQA8LnNbDDF5Ry3i3TecFG
	6s9W2AfcegonYV76PAUfBTW0Uqu/jWw2LxudJ0HUSgStPsgacV2WWFDQJXBoT6TCIdmCbzmPqPX
	5Zz1kBJKT6Xc+QsCa1hqQDHuC51vUHoXqVvj18cG3m2jE1PcXqZ6GcIk=
X-Google-Smtp-Source: AGHT+IH9hsxeN8JWcRHnUAnRF2nUKmQ8AUA2BXRL7xlSUOURky4FyCkAe+nisCjnW4nN3TEdoItNoQFcFlvbBrsaaY6y7PJ7QRDd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:365:1c10:9cfa with SMTP id
 q14-20020a056e0220ee00b003651c109cfamr50005ilv.5.1708726444282; Fri, 23 Feb
 2024 14:14:04 -0800 (PST)
Date: Fri, 23 Feb 2024 14:14:04 -0800
In-Reply-To: <00000000000091ce6f06013df598@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000badb45061213e0c0@google.com>
Subject: Re: [syzbot] [kernfs?] [net?] [mm?] stack segment fault in __stack_depot_save
From: syzbot <syzbot+1f564413055af2023f17@syzkaller.appspotmail.com>
To: axboe@kernel.dk, bpf@vger.kernel.org, brauner@kernel.org, 
	davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org, 
	jack@suse.cz, kuba@kernel.org, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	reiserfs-devel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a58254180000
start commit:   815fb87b7530 Merge tag 'pm-6.7-rc4' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1101277e240af3b9
dashboard link: https://syzkaller.appspot.com/bug?extid=1f564413055af2023f17
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166bcf64e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111a00d2e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

