Return-Path: <bpf+bounces-5566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A611E75BBA9
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 02:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04291C2158F
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 00:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CE238F;
	Fri, 21 Jul 2023 00:53:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A555062E;
	Fri, 21 Jul 2023 00:53:34 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0533812F;
	Thu, 20 Jul 2023 17:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BD2W8Y2agjpRpPZrce6cxuYdaWScA3QklSu6LaAl/3o=; b=D5RXmzWOprDt+Gy+G8y0x29uqj
	108WzMJPp9LK1CWBxFOYMyseBFGUlM/yWOLaff/IvmYEumZ4HCV6em505BeXehhXgcwDRSKFePuiI
	bH3VTbcAp0ok1XjrX2WJK+XmdiE9bz9Nd/IcHl+eKFjdyRJa9Mc0BVY/p8FJIi8ij7b0atF3E6ik2
	nDuJyRcCbqiQsBYxHVAOcInSCWSsfGabRwulZ3RY1QqBuxdo7zkyprY/EufwmHTTe1uBg6N2e0zEH
	mjz+2SefPFZCR8G9W8U0Qvr0UwWA89QbDERLKHxzqfvR411Ub6B0oCWFdWIi+l8+NwcWfEOgCrcMF
	wpOJwOBA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qMeOg-000GDT-Bm; Fri, 21 Jul 2023 02:53:30 +0200
Received: from [123.243.13.99] (helo=192-168-1-114.tpgi.com.au)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qMeOf-000S0D-It; Fri, 21 Jul 2023 02:53:29 +0200
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in ingress_destroy
To: syzbot <syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com>,
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
References: <0000000000004386940600eca80d@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ee358056-266a-426d-5dc9-de6df2542752@iogearbox.net>
Date: Fri, 21 Jul 2023 02:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0000000000004386940600eca80d@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26975/Thu Jul 20 09:29:20 2023)
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/20/23 5:18 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    03b123debcbc tcp: tcp_enter_quickack_mode() should be static
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=168e1baaa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
> dashboard link: https://syzkaller.appspot.com/bug?extid=bdcf141f362ef83335cf
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bf2bf4a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12741e9aa80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/348462fb61fa/disk-03b123de.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/33375730f77f/vmlinux-03b123de.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b6882fbac041/bzImage-03b123de.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com

Same here, will take a look. Thanks!

