Return-Path: <bpf+bounces-41196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0449942EF
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6849328795E
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C541791ED;
	Tue,  8 Oct 2024 08:43:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4051CAA4
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376985; cv=none; b=P5nWMmlJb1Ld8v4vj+XqMa1aSBo/eypd18/RSxr1zH6LuiAnWqvp1eu2YBjLFvxpl5xufgnKuXg2A1fTk9xIVm4SLfs4i6b8iAZB4cnhDG8dzYb/NrW0BnJER3dlUWvWowGOgGfILwr2cH89wjpU3b9B5uFgrNfR+GGXEvHTzc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376985; c=relaxed/simple;
	bh=WlKEQjsIZXvP+MqHhNtD7QBSr9iZ9S5Dnqi5AAZN05I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y/yizlu33AdOqq4KU23RHyUTH2W0v7/K8YSSMYnrNgZ7lD0Lbrn6VhWENMazbx9jIxlP98qKX+ZtjH/kCCfpCPmCsdCMNQmFBSmZXC6z6DgpK904oSizUyI3Hgt7yWD8j9pBwqi1jGLr2B/N1PzIbULcb+cM4Kfe8k6JYIYR8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a19665ed40so39835415ab.1
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 01:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728376983; x=1728981783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVS7fVKH71Pe8fCQ0Gmt8UDN3roCi4HGtPl5gMiYBCw=;
        b=cggRvrQFmZAy1iBUCrFvDBZCTPmoIUcKSWJmBEBkb3penojvPhuLTGXx6Wlu5xAxN9
         N/GmQ9Fw9WVi6vHTyrs4xAQtYO627zcbZb1awUgHwU857Ll1iZ+TYoCG5XpYP4mOn2Ez
         o9cGzwxUhSyBCga6LhVAFoBRhIkWts45e4N0ZOJ1GXopmOkTOpUTX8eaZ4DPaJWBsJ8M
         XGSFdfEkTGskQi2Qu7m4YiuChb8S+6VRwGUIY71vbq6rFBedqd0HLGNEegb0ewfLHvKz
         P01pyY+0NH9jHfhAuYE8LsusG+k6RFKRby6kyco+2hWbD75R0pwiT7aSayx/RK1ytOoO
         VFpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq0nyEYbC96Kp+raCsl+ISm1s9Y7HMpq0sJFl/F42aAQmcjda2dKF/wHegjeup7sR+zyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2G0aYg0kHjsS8ojrnKCPKdP1hAm+vLeEPMz3DI+LZ7oVg0sA
	EI3dlO7WSJw9LUPNkRsFErQ13b4bAeWNU8SfVtff1kZjNnstcIukOMtd8sw1MMJ7hy1omd9ALlW
	AtgdSPbBNw30k0ywQa2UERAsMDl+bS6/fbHSaN9lti6QvlRVP9pDreH0=
X-Google-Smtp-Source: AGHT+IESTZbom871uQ+CoDIEKTNpyDbqRog3FH6w1KkzIBYyio92XHoOeJntYRpQKOQLJq+XZRNOtpp4hxIcrguae0Kq4CtaquDu
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:870a:0:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a38ae3fa4amr17042185ab.0.1728376983353; Tue, 08 Oct 2024
 01:43:03 -0700 (PDT)
Date: Tue, 08 Oct 2024 01:43:03 -0700
In-Reply-To: <670429f6.050a0220.49194.0517.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6704f097.050a0220.1e4d62.0087.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in push_jmp_history
From: syzbot <syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com>
To: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, cl@linux.com, daniel@iogearbox.net, 
	eddyz87@gmail.com, feng.tang@intel.com, haoluo@google.com, 
	iamjoonsoo.kim@lge.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	martin.lau@linux.dev, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d0a38fad51cc70ab3dd3c59b54d8079ac19220b9
Author: Feng Tang <feng.tang@intel.com>
Date:   Wed Sep 11 06:45:34 2024 +0000

    mm/slub: Improve redzone check and zeroing for krealloc()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11ddbb80580000
start commit:   c02d24a5af66 Add linux-next specific files for 20241003
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13ddbb80580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15ddbb80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
dashboard link: https://syzkaller.appspot.com/bug?extid=7e46cdef14bf496a3ab4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b82707980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f4c327980000

Reported-by: syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com
Fixes: d0a38fad51cc ("mm/slub: Improve redzone check and zeroing for krealloc()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

