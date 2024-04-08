Return-Path: <bpf+bounces-26128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD4289B522
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 03:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EB8281484
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 01:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F60515C9;
	Mon,  8 Apr 2024 01:12:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15F15C3;
	Mon,  8 Apr 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538719; cv=none; b=rRh9sQI+3fRI7lPL2oMaLBRK85QIr5GIhloYkCs5CMQO6vO7rRVTQheWJlxeeo0UxgJJsl0drSxlF8lq5NooVuEo8fGj98gDtTUeRwcZj2juV/nIFh9wFb5v9PCzrzH7HJKY+JpufdhCkL6nEcToY7slOFQWH9iHj4FWwtyJscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538719; c=relaxed/simple;
	bh=4EVxEq7n2NTrxGnlfm5xidYmy7Zs5Hgok4o5LcFBMIU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GHrUzWc/NR1/REjXhNju/aPNFlREtbuOju+Eo7WfvZ2GTSSj0RbRoeC7O266AbaOgzYvlkz2cR+gJjir99gjfY5EnXiil1E34kmpoi2nezUWe3w8gaVPjoI05E7WXr8QmLrJ8aNIWjMdTCcdlXwpvLu4DfkVGXkEjt6exyIFRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VCWJd6VZHz4f3jYS;
	Mon,  8 Apr 2024 09:11:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9D9A91A0DBC;
	Mon,  8 Apr 2024 09:11:52 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAnTA9URBNmH29iJg--.3919S2;
	Mon, 08 Apr 2024 09:11:50 +0800 (CST)
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Read in hash
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com>,
 bpf <bpf@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Network Development <netdev@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>,
 Hao Luo <haoluo@google.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev
 <sdf@google.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, LKML <linux-kernel@vger.kernel.org>
References: <000000000000b97fba06156dc57b@google.com>
 <b764fde2-cbf3-6446-d437-45af0964b062@huaweicloud.com>
 <CAADnVQJ4BRO_85By7T7bJkxgN8tmzJkS3TvP2JMiFU3WwRT7yA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <eed9387e-2856-3e83-8934-17211a2b018a@huaweicloud.com>
Date: Mon, 8 Apr 2024 09:11:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ4BRO_85By7T7bJkxgN8tmzJkS3TvP2JMiFU3WwRT7yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAnTA9URBNmH29iJg--.3919S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrykKw18Jw45Cr1fKr4kWFg_yoW8Wry7pF
	4rGFWagF1qyr1Ut3Z7tF1DW3WjvrZ8A347Ga1jqry09a1qqr98Jr4Ig3y5uFWUCr1kAa4S
	yrn8u3WfA3y0v3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 4/7/2024 10:24 PM, Alexei Starovoitov wrote:
> On Sun, Apr 7, 2024 at 2:09 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 4/6/2024 9:44 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
>>> git tree:       bpf
>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=148ad855180000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=9459b5d7fab774cf182f
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d86795180000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143eff76180000
>> According to the reproducer, it passes a big value_size (0xfffffe00)
>> when creating bloom filter map. The big value_size bypasses the check in
>> check_stack_access_within_bounds(). I think a proper fix needs to add
>> these following two checks:
>> (1) in check_stack_access_within_bounds()  add check for negative
>> access_size
>> (2) in bloom_map_alloc() limit the max value of bloom_map_alloc().
>>
>> Will post a patch to fix the syzbot report. Will also check whether or
>> not there are similar problems for other bpf maps.
> Isn't it fixed by
> https://lore.kernel.org/all/20240327024245.318299-2-andreimatei1@gmail.com/

Yes. Totally missed the patch set. The patch set will fix the syzbot
reported problem.


