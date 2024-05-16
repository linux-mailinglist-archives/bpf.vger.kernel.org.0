Return-Path: <bpf+bounces-29827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725D8C700B
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 03:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F261F21EF5
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 01:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA271138C;
	Thu, 16 May 2024 01:36:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE45EBB;
	Thu, 16 May 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715823362; cv=none; b=M5EnKeXzUO7PklJkaqiK6k/dO63NC/sm2RClg10DrmAjDn/Z/A8uMN2xjP9WhdjJQ/9YTm2LBuWOV/xLdTFWQ81q0u/l4iKdQoRA8VDG1JhOxxymJYFpCeTESU8iw+jP8Erig3Fl50pMxz8an2VbsXZ846dFgDIq2O6wZl4rDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715823362; c=relaxed/simple;
	bh=FrGq2YrBThf3E1IoJyu8KCt62cSocVHlIxWXr8AXgIQ=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l12AR5niuOLxnTjNJW8Z68x44EckCd3IwKfkbL66oLATa60bErmJSYGNU0HDCyXzFIs42e8fUp1/ehyGBzI7SJPWDSJ0QLxS6CdsBP2UBThMGf46uo1/lnZU7rnGOhTQr2jF8F6HDWxsy99b1d2QLTaK/jgQf737jcvSkolxjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vft2n6XBpz4f3lfZ;
	Thu, 16 May 2024 09:35:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1FAC21A0B33;
	Thu, 16 May 2024 09:35:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgCnPBD2YkVmYmJfNA--.63684S2;
	Thu, 16 May 2024 09:35:54 +0800 (CST)
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Read in hash
To: syzbot <syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com>,
 bpf@vger.kernel.org
References: <000000000000485a2d06187fc7a7@google.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 joannekoong@fb.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e8b52077-f0f2-bfa7-a170-09202c86dd24@huaweicloud.com>
Date: Thu, 16 May 2024 09:35:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <000000000000485a2d06187fc7a7@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgCnPBD2YkVmYmJfNA--.63684S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Jw4Dtr4UKw4UXw45uF18Grg_yoW8JrW7pr
	WrGrW3KwsYyF1jy3WIgFnrWw1vg395CrW7W34Utry09an7tr1vyws2yFWrWr4UGr1DZF90
	vrn8Cw1rK348uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 5/15/2024 11:29 PM, syzbot wrote:
> syzbot has bisected this issue to:
>
> commit 9330986c03006ab1d33d243b7cfe598a7a3c1baa
> Author: Joanne Koong <joannekoong@fb.com>
> Date:   Wed Oct 27 23:45:00 2021 +0000
>
>     bpf: Add bloom filter map implementation
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1543bd5c980000
> start commit:   443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
> git tree:       bpf
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1743bd5c980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1343bd5c980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
> dashboard link: https://syzkaller.appspot.com/bug?extid=9459b5d7fab774cf182f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d86795180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143eff76180000
>
> Reported-by: syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com
> Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> .

#syz fix: bpf: Check bloom filter map value size


