Return-Path: <bpf+bounces-635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A502704DD6
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 14:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5B81C20E44
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0972C19BD1;
	Tue, 16 May 2023 12:32:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E42770B
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 12:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05BBC433D2;
	Tue, 16 May 2023 12:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684240328;
	bh=5maVUb07MOPzI7fH1YK4LLKkRTaKZEtXvS/UR5ZRwW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HhA2I+MV7c9Xe/O2JFZUptT3YXLa8o9q4RdunpnRAa8afSK40C2Oa/iCDVe7KRxkm
	 GeVk/2TWh8PCaX67QOToFkCyS97BkvA8/WvqUW6U7WX1SlK4yGi9PDjWBVNTs0avZ+
	 Nra1iN6P+21PN3mrhEK6cxoBgExJQ4ZW0E7cv69O4FlbyZLMwkKSSgJonuQ76SMkhY
	 hZ1IGNarwECDzxojSWmQefcABDLmkHLzvYJd9O8cO2L1mK1z6nOrI7HYVw5QfOzUBC
	 dV52zlm7FS4D0pCwQp0J4DqBpQd8VB0utIWdUlc5TSjtPiDVBFSnrhdQQRQoK+IOaf
	 3ACa5RMq/hD7Q==
Date: Tue, 16 May 2023 14:32:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+c84b326736ee471158dc@syzkaller.appspotmail.com>,
	syzbot <syzbot+729f1325904c82acd601@syzkaller.appspotmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] Internal error in should_fail_ex
Message-ID: <20230516-saftig-einbog-ef2981f0dec2@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000bff72505fbcd1f74@google.com>
 <000000000000bc152005fbcd1fa2@google.com>

On Tue, May 16, 2023 at 03:35:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    457391b03803 Linux 6.3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15671fa2280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=385e197a58ca4afe
> dashboard link: https://syzkaller.appspot.com/bug?extid=c84b326736ee471158dc
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-457391b0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2a1bf3bafeb6/vmlinux-457391b0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/21f1e3b4a5a9/zImage-457391b0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c84b326736ee471158dc@syzkaller.appspotmail.com

On Tue, May 16, 2023 at 03:35:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    457391b03803 Linux 6.3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=134e0b01280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=385e197a58ca4afe
> dashboard link: https://syzkaller.appspot.com/bug?extid=729f1325904c82acd601
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118f964e280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f6e776280000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-457391b0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2a1bf3bafeb6/vmlinux-457391b0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/21f1e3b4a5a9/zImage-457391b0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+729f1325904c82acd601@syzkaller.appspotmail.com

Not complaining but why am I blessed with an explicit Cc on this?

