Return-Path: <bpf+bounces-70708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A23BCB31F
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 01:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651C719E6FA8
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C8D288512;
	Thu,  9 Oct 2025 23:29:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CD32882C9
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052544; cv=none; b=sf942dWg8JIJ2u1mXRxzWQGvlvAX3VFs1qklgxuQDLDyhuce3yCBCJwdOpMZu4OsfawLUQWBR5LohKc742qsy9BnaftTcyKLmK4JyBJ70gTEa4v1k6Tw4FIqSVhoUqdD0cXNTPpeHatfd0NfpPtrO7HmMwQB5SpbEexkwwokfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052544; c=relaxed/simple;
	bh=MR3mDLO8psciWX7aEFIWGIcpwIll6YdhBIvr6LmW3fk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bkXzmWIJmNRWnhKBvS2ldknRYFMIdmWl+kLN5PmxF846g0SP7P3pxq13aomj6Dex0nnDmAQtCT0ylnMpKDp7sDf0y+RtEiTLbGiMI3dNpqFAPrhTQQ66+9m37QvOOVfheAHxmAvKbGG2soDWa0NinLmi/HwgbUPIM2w2ggLyUJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9143e8a4c5eso647362139f.3
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 16:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760052542; x=1760657342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hS+rszJgaizocP5WWuliZ9dJ4ZavwuTgx73YaLzfsos=;
        b=Drw/vTfbHIxXW/gL4noG/IIlJ47d43yIdQQIsUf0D55jDeATRFuRLNa8pw54kSPKFr
         gOKFCbG6FKw0+q2zWfqQ+veqRPeKJC9oB/XVL4UjKtzmn069jVNVNSg3+x8pSlg+b7gm
         A28/LmFJ5DNacupmYdcOIRCwYgAsRAFsjDO6rxNA26TK3+yS/VRxHfCEo4v8qYO/5jUI
         lpbwkAwTZliR5JSManRQJTj7OLBUdf/gBL+aK6owQpzaeGtQ/ZtijNmFv3dosu2qTuKT
         m+a7XFGYrr96KNS+iufPxhIhc6K/d7IhjEqG4FpN0G5jBnvrkMt9Tf0htU0HoXFBJ+FV
         E64w==
X-Forwarded-Encrypted: i=1; AJvYcCUNYAcqMhTYF+NyBP6+/tHwpQav0WQLRLthDntWV2Cxx3kNN9vBICDPLV1CgVM4rOb/JZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWxuCzmrh8fa9Mu0Ig2Tp33/rDR8i/tTQww4XoZ7c4wDWdLweI
	jBQki0OGGrtw69MPvy4aAWlsaz0KRADS1JiHS2tIfcgAbEVylz93aFGLr8Rafp6CdKvspJuKakl
	fMZDUImq+ZPAnRfqnc88MsJf+ktJBMw8CtPyCd+yZXWYI2+GQzDbXh8tTK6s=
X-Google-Smtp-Source: AGHT+IEQ+Vn2+E2g5j5qm1lu78xJUMAaWaxx4GoM0B+s9KwrDea9URSH2Lq8DiunLGRzb3uPqilmwyJygHxa4YEPRpLf0ZbtCDZY
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6406:b0:93e:259b:9412 with SMTP id
 ca18e2360f4ac-93e259b9561mr246304039f.19.1760052542595; Thu, 09 Oct 2025
 16:29:02 -0700 (PDT)
Date: Thu, 09 Oct 2025 16:29:02 -0700
In-Reply-To: <20251009222836.1433789-1-listout@listout.xyz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8453e.050a0220.91a22.000f.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: sleeping function called from invalid
 context in sock_map_delete_elem
From: syzbot <syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com>
To: ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	listout@listout.xyz, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com

Tested on:

commit:         5472d60c Merge tag 'trace-v6.18-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159b91e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b842a78bbee09b1
dashboard link: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f50dcd980000

Note: testing is done by a robot and is best-effort only.

