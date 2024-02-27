Return-Path: <bpf+bounces-22768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FEA869425
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 14:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5A61F21969
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D4145FEC;
	Tue, 27 Feb 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnX+BKWo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD8F1420DF;
	Tue, 27 Feb 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041813; cv=none; b=tPBDj3Lgeu7dShPz7F/HsjFe2tzv2z0Ojxa4n/KuZFdvp2aG7Y1lV06m8iNDfTDLvryQOgDghnYPcKoQOS6v6FFlIKYJtr2US2Z6lnwTbus1wabV+KeNkjYhbGEy51lgOwU2lRsm7z12fAzb6dPykbh97luuvIw6rb1Wp8wgbZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041813; c=relaxed/simple;
	bh=cmuHHl9CIeYfuV4aIWfaqsYJoNLPszhG15STpDSPOGs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QpywRHKotR82XKhAf6WTooakkOx2Q0Cr58B9Ajnby7ivKL2sJViZqtqxUZ/MP+E/QaQ2eRrmxvkPsw8dCCXGnhsPq/GTF0EcNVyOpEXfKshsPNFFO+iWuABuHYSUyy/VnJmrZjXsxn22Vpjb0RDF/8xznJVjVD76PabwsAHeb5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnX+BKWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F41C43390;
	Tue, 27 Feb 2024 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709041813;
	bh=cmuHHl9CIeYfuV4aIWfaqsYJoNLPszhG15STpDSPOGs=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=VnX+BKWoPCfr+iBK1MyyV/mn28GcnQ5OFoqBa1D01Q87V64pKtBWiVJunSEHYKrTH
	 CX5PlXKK/ZozMZyUL0E3kwy3/GmpDGCiS2FAbC2275XWYR0P91ishov9M9UE9rXa3p
	 M/bpPEZmEJYQcVW28UmaSSercXZAxNzGyL9qBZboPWujw5kYkYNAMn1U6pGuxPvETU
	 1HcM5azXYUKafvySNdsVPyBAAIf4oNpGpBMrm7b5YSSZEpidGyr0VWxsV/s57X1ndU
	 1t/fLCj7Pb8lqehmdv1/Z+X/ftNbCZK1FaBi6UNghqcXP69u48QKdtppv1F4PiJ9l7
	 r0zV//MIhaNPQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D1515112E511; Tue, 27 Feb 2024 14:50:10 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>, syzbot
 <syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
 hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL
 pointer dereference in dev_map_hash_update_elem
In-Reply-To: <65dd075bc6cbd_20e0a20892@john.notmuch>
References: <000000000000ed666a0611af6818@google.com>
 <0000000000001d1939061240cbd7@google.com>
 <65dd075bc6cbd_20e0a20892@john.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 27 Feb 2024 14:50:10 +0100
Message-ID: <87msrmdnjh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

John Fastabend <john.fastabend@gmail.com> writes:

> syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    70ff1fe626a1 Merge tag 'docs-6.8-fixes3' of git://git.lwn...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1762045c180000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4cf52b43f46d820d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=8cd36f6b65f3cafd400a
>> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: arm
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110cf122180000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142f6d8c180000
>> 
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-70ff1fe6.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/bc398db9fd8c/vmlinux-70ff1fe6.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/6d3f8b72a671/zImage-70ff1fe6.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com
>> 
>
> I'll take a look this week if no one beats me to it. Looks like there is
> a reproducer so should be able to sort it out.

Took a look at the reproducer. Looks like it's creating the map with
max_entries=0x80000202, which means the rounding up of the number of
hash buckets overflows, and somehow the overflow check (for 0) is not
working on a 32-bit machine? I guess because the roundup_power_of_two()
ends up doing a (1UL << 32), which is undefined behaviour when an
unsigned long is four bytes.

I'll send a patch to check the value before the rounding up instead of
after.

-Toke

