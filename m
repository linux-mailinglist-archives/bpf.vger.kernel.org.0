Return-Path: <bpf+bounces-26115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D57F89AFFF
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 11:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2AA1C20956
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B8613AF9;
	Sun,  7 Apr 2024 09:09:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA001C0DC6;
	Sun,  7 Apr 2024 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480979; cv=none; b=aIiyYQpPM5Xng/Gv9Zo9moVFYIa/t9gEmMemN9oFyA6eIXq5TzL8QSc3i0yGGxhvHEG6DOfK0JShs379aff1sABNGm4u1AY9wDi7tWgrEpta7idKqC+WSkbO6BGu/GjLhaI5EIcjdrPbke6YWqEGSxGu/1TLHCnliupjlUs9E0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480979; c=relaxed/simple;
	bh=LLUiJmmHdRzhwxXjxLr55OSMYIeeb4fczRz9zfuRMFU=;
	h=Subject:To:References:From:Cc:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RLm3wC/5CLMqh4cpEs+rLdQI47Ijw36zDsOop2t3vIFSQ8/ykIBQKp3XqZ0CUnU1W+6wAEAk7cQNsnSsyMXc4Tv7YpDMQpiiV6QhyFccXUqhRSxUqsMH22BSZDT9Cg2dkVakYKWqQ98UtwF5ppE6o9aJKw5lCjGsATsBq7h4wgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VC5yK3Fxgz4f3jJ2;
	Sun,  7 Apr 2024 17:09:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C3B0D1A0E11;
	Sun,  7 Apr 2024 17:09:33 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAnNZ3IYhJmSErFJA--.6730S2;
	Sun, 07 Apr 2024 17:09:32 +0800 (CST)
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Read in hash
To: syzbot <syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com>,
 bpf@vger.kernel.org, syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
References: <000000000000b97fba06156dc57b@google.com>
From: Hou Tao <houtao@huaweicloud.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, jolsa@kernel.org, martin.lau@linux.dev, sdf@google.com,
 song@kernel.org, yonghong.song@linux.dev, linux-kernel@vger.kernel.org
Message-ID: <b764fde2-cbf3-6446-d437-45af0964b062@huaweicloud.com>
Date: Sun, 7 Apr 2024 17:09:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <000000000000b97fba06156dc57b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAnNZ3IYhJmSErFJA--.6730S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw45Kr18ZFyUGr4UuFyDZFb_yoW8Jr13pr
	45KFWayF1vyF1UtF1xtF1DW3Wqg395ArW7Gayjqryj9a1vqr95JwsavrW5uFZrAr1qyasa
	vrn8uw1fC3yvvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi,

On 4/6/2024 9:44 PM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
> git tree:       bpf
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=148ad855180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
> dashboard link: https://syzkaller.appspot.com/bug?extid=9459b5d7fab774cf182f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d86795180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143eff76180000

According to the reproducer, it passes a big value_size (0xfffffe00)
when creating bloom filter map. The big value_size bypasses the check in
check_stack_access_within_bounds(). I think a proper fix needs to add
these following two checks:
(1) in check_stack_access_within_bounds()  add check for negative
access_size
(2) in bloom_map_alloc() limit the max value of bloom_map_alloc().

Will post a patch to fix the syzbot report. Will also check whether or
not there are similar problems for other bpf maps.


