Return-Path: <bpf+bounces-10278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FCE7A49E2
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 14:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D4B281C8D
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E9B1CF88;
	Mon, 18 Sep 2023 12:41:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071551C285;
	Mon, 18 Sep 2023 12:41:28 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1EBA;
	Mon, 18 Sep 2023 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xh40g7onQJNZ9MEsk7XfawwcORdpcbcgjNtD+Y0h5Fk=; b=SPRUd/HAHZz9PTcv+s6BbJOT23
	7lIZF+3OCTvJnVUeOFsircb4rpwG2I7umMNaulDTTiIFTiZXCrC6aKNCV+Bp6o3+W6lWh8CLUwXOn
	soVPGGE/x5OULLiV7mihLpNMprKI9WGxkXHN+9i+jth74dRqojZllrQ+f/+cI7FQb9QkMUv8h/wPN
	l5+hgqGKbChhgqC0+jT4N7xaMn2l6uxJsZy9HokGXXbE0IB2n1TFssU01I4CdeT2ch/Lja4O9nzXv
	d41gdvl1117ZtEQYASAg2jjjN10WkzmnrlOochRMQU4y9fg6WP7m0fbxC5lhoDo34bSzfZhnm7HgI
	WxZbY4GQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qiDZ3-000Lm8-Fy; Mon, 18 Sep 2023 14:41:21 +0200
Received: from [81.6.34.132] (helo=localhost.localdomain)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qiDZ2-000AOR-Vk; Mon, 18 Sep 2023 14:41:21 +0200
Subject: Re: [syzbot] [bpf?] WARNING in bpf_mprog_pos_after
To: syzbot <syzbot+2558ca3567a77b7af4e3@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev
References: <000000000000bf4d0c06059b3c95@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d3ecc822-00aa-7d66-c8c0-44ac7bff919e@iogearbox.net>
Date: Mon, 18 Sep 2023 14:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <000000000000bf4d0c06059b3c95@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27035/Mon Sep 18 09:40:43 2023)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/23 7:15 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ca5ab9638e92 Merge branch 'selftests-classid'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=110ef2c2680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
> dashboard link: https://syzkaller.appspot.com/bug?extid=2558ca3567a77b7af4e3
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Will take a look, thx.

