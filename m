Return-Path: <bpf+bounces-5196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0573A7588E7
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44FA28179A
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 23:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A9017AC3;
	Tue, 18 Jul 2023 23:07:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082C17AAB;
	Tue, 18 Jul 2023 23:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511EBC433C7;
	Tue, 18 Jul 2023 23:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689721658;
	bh=Kbw3H9b8MZrMJc5p9llXiiMmksLCzNjk2HDi2Ugf8VM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dunnjuSw7zeGIdFvf1JEoPdnlGCN3A/Ggtp6BHKwqAL0SJujGJuNg3pS4TVbb6VOB
	 Cu7KHPFhj9jq7oi2nxLa0FcevZUMHKEoHf8mInYRxEbMBp+lI2J/KBjJs2oHw5Zlhg
	 t6DvMA+C+gHervkP17VMhTflzAeJ3K9Hzd1z9l7jOV28ZY54qPYMWMcbv/UUZNXzqv
	 nt0YW98R4BhfDu2820Fj216DxZgspjLKawLs3yMH63RvjVL9DyJomV3q1FgpsW0BHt
	 8dwAVYaBk3s+HeknvGRkOAiOvgEEzz4Bf+5JM9J3F1yuMu9Y1mqAF7ZIPET5QFBor8
	 f3hvaOquPgnUQ==
Date: Tue, 18 Jul 2023 16:07:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: dhowells@redhat.com
Cc: syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
 bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
Message-ID: <20230718160737.52c68c73@kernel.org>
In-Reply-To: <0000000000001416bb06004ebf53@google.com>
References: <000000000000881d0606004541d1@google.com>
	<0000000000001416bb06004ebf53@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 11:54:33 -0700 syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 7ac7c987850c3ec617c778f7bd871804dc1c648d
> Author: David Howells <dhowells@redhat.com>
> Date:   Mon May 22 12:11:22 2023 +0000
> 
>     udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15853bcaa80000
> start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17853bcaa80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13853bcaa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=f527b971b4bdc8e79f9e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a86682a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1520ab6ca80000
> 
> Reported-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com
> Fixes: 7ac7c987850c ("udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Hi David, any ideas about this one? Looks like it triggers on fairly
recent upstream?

