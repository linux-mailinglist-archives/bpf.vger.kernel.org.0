Return-Path: <bpf+bounces-8914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20E478C4AF
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 15:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0F51C20A3B
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20548156F2;
	Tue, 29 Aug 2023 13:00:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0614AB3;
	Tue, 29 Aug 2023 13:00:57 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CD21BF;
	Tue, 29 Aug 2023 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KmsH/y0KKKeGtfjvpfiybrYqKA7hlrOCgNAx4Wb8uU4=; b=ntelXC6Kc6UhUJ+d/rCv44Ud5J
	UtfQSGaJHed4NiKHMm+I3y9LRBVGX+g4mE2FoP0aXvPgWAxDb8cKh1GlxE1c/qCAV7hADMb3ekhRY
	0XpxL5A/4O9Q3euBf8KG+e6mRQQ42W67T1pz5dc1X8MNZFzu/Fb9TXjMueLb8lLgq1MUYS3bDag6S
	e+y/qQuhPSvvdwIRzdebQd3XERJ2g9t2TAOeVb8K97UC85QiaC8SGruV9CBxT6MWX8A0IDgNg0Reg
	HnayNMDa+n/lrjCKIk/gAfp11cxdtEdcqxL4Q7gpLjoAli3IuFh8wGnhsT2rSteNTO3O8J2E5KOP2
	bwmZii2w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qayKK-000HEt-MO; Tue, 29 Aug 2023 15:00:13 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qayKJ-000Uuo-R5; Tue, 29 Aug 2023 15:00:11 +0200
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in
 xsk_diag_dump
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: syzbot <syzbot+822d1359297e2694f873@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jonathan.lemon@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <000000000000af3ba506040b7d0c@google.com>
 <3d8fa470-8ca9-561c-8381-0687f9e69d10@iogearbox.net>
 <CAJ8uoz2rCtznp6yq8YxNNcmZXxkkBFfAudv=3KbLKdho9_0z9Q@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <320d5331-698d-e82f-c022-4a5774f87e46@iogearbox.net>
Date: Tue, 29 Aug 2023 15:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJ8uoz2rCtznp6yq8YxNNcmZXxkkBFfAudv=3KbLKdho9_0z9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27015/Tue Aug 29 09:39:45 2023)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/29/23 2:58 PM, Magnus Karlsson wrote:
> On Tue, 29 Aug 2023 at 14:56, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 8/29/23 10:20 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    5c905279a1b7 Merge branch 'pds_core-error-handling-fixes'
>>> git tree:       net
>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16080070680000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4a882f77ed77bd
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=822d1359297e2694f873
>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ec63a7a80000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109926eba80000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/98add120b6e5/disk-5c905279.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/c9e9009eadbd/vmlinux-5c905279.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/b840142cc0c1/bzImage-5c905279.xz
>>>
>>> The issue was bisected to:
>>>
>>> commit 18b1ab7aa76bde181bdb1ab19a87fa9523c32f21
>>> Author: Magnus Karlsson <magnus.karlsson@intel.com>
>>> Date:   Mon Feb 28 09:45:52 2022 +0000
>>>
>>>       xsk: Fix race at socket teardown
>>
>> please take a look when you get a chance.
>>
>> Thanks a lot,
>> Daniel
> 
> Already looking at it :-).

Awesome, thanks! :)

