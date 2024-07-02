Return-Path: <bpf+bounces-33696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18033924B6F
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4561C2298B
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CF11B6A71;
	Tue,  2 Jul 2024 22:08:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD331B6A65
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958135; cv=none; b=sjuaJHcqMsOjFUYudOaCDCqURxVjnVlW+eTLJ3DVimeONTgAXdjH1B+zK1df7y4bNd3iSA1o0kv89k+bbpR75UtNp1Hwp2a8KgePtXypsEkKXW/ndpo7/2nGPk37qDnFJlIfVQFnMkiqPctgFFz4xaUJeg+AkamMl0eGFqjrQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958135; c=relaxed/simple;
	bh=DFSD+Dzwv2mh8jBCiuOSVWAEqRjEmTrmWxZhzxgNbxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=A0DYcjTVsm2kFGGCHWH1FD00+FEUQzMmv5djWPj4CMS3mCUupBaAVTnM7nydG/MmMA7+UDU+PNoxd+gl7Ji4kcvyXIgYrqFxAgqiTMtMtBnuFVPATPV1SXZR+9IXyG7IXytLgtrIegYNOdT8hzW87ndhh0QiXi46qq9WcferZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 462M8nSc061721;
	Wed, 3 Jul 2024 07:08:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Wed, 03 Jul 2024 07:08:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 462M8nlt061716
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jul 2024 07:08:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <98dcfbda-6237-4bf6-bc66-6f31cf12f678@I-love.SAKURA.ne.jp>
Date: Wed, 3 Jul 2024 07:08:47 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_released
To: syzbot+16b6ab88e66b34d09014@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Axel Rasmussen <axelrasmussen@google.com>
References: <0000000000002be09b061c483ea1@google.com>
Content-Language: en-US
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000002be09b061c483ea1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The local lock itself will be removed by

mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

but is there possibility that this bpf program forms an infinite
recursion (kernel stack overflow) bug?

On 2024/07/03 3:54, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a12978712d90 selftests/bpf: Move ARRAY_SIZE to bpf_misc.h
> git tree:       bpf-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=130457fa980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=736daf12bd72e034
> dashboard link: https://syzkaller.appspot.com/bug?extid=16b6ab88e66b34d09014
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125718be980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14528876980000


