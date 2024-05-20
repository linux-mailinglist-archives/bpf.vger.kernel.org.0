Return-Path: <bpf+bounces-30027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3588C9C4E
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 13:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7571C21E9E
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 11:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE14854677;
	Mon, 20 May 2024 11:44:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63E5381D;
	Mon, 20 May 2024 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205481; cv=none; b=seqpKNDtS8HxQ3yOw+xaqvzyiDz+PA8A7vCtXZ/u8gi5D5EuKWaYY5WHrpLZ5/gGto/4B2GQ5qSkqErVxm1axU3aCRLa9GOg8bae1KjcVNWFbvAPmaxvIR6PfHQ5/m8Sw3EOpgDqUhfmlF2UeAjumMlWvTf1V8ODEPUU68zeLic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205481; c=relaxed/simple;
	bh=grRLKSxy5wPv87OejPxy7I2fUauVo0L3p0GNWG3P0Jo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QQlD4/OpRyBVapNI/JGrTaXr6xTtbgpRxVgkjDwXByyspAGIAIIcJ3pGpBCB02FfnYJbuwYjvcDOvQ9KgpmWz15V7zp/DrxmyM6QGF1syxgOGzcZAldLTkAKmqqaO1NnVf8ZAm5UwM9IGbBkvAUVqgS01C1kAJoUF7ZVyfhP+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VjbMF37HHz4f3lfn;
	Mon, 20 May 2024 19:44:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CF7BF1A0199;
	Mon, 20 May 2024 19:44:35 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgC3w5ufN0tmJ0vzMw--.3035S2;
	Mon, 20 May 2024 19:44:34 +0800 (CST)
Subject: Re: [syzbot] [bpf?] possible deadlock in get_page_from_freelist
To: Pengfei Xu <pengfei.xu@intel.com>,
 syzbot <syzbot+a7f061d2d16154538c58@syzkaller.appspotmail.com>,
 ytcoode@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev,
 akpm@linux-foundation.org
References: <000000000000c051d80616195f15@google.com>
 <ZkcD9H0P8O7Me5Do@xpf.sh.intel.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <554af7a5-4309-cfec-8182-93e61aadc918@huaweicloud.com>
Date: Mon, 20 May 2024 19:44:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZkcD9H0P8O7Me5Do@xpf.sh.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgC3w5ufN0tmJ0vzMw--.3035S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr15KFW8ZFWUuryxWry5XFb_yoW8tF1Dpa
	y8KF13Krs5trWjyFW8KF1jgw1jgrs3Gay7GF4vgry0van5Zr1ktr1Iyay8ZrW2vFykAF9x
	ZF15uwn5tw4vvF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUo0eHDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi

On 5/17/2024 3:15 PM, Pengfei Xu wrote:
> Hi Yuntao,
>
> Greeting!
>
> On 2024-04-14 at 19:28:16 -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    7efd0a74039f Merge tag 'ata-6.9-rc4' of git://git.kernel.o..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1358aeed180000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a7f061d2d16154538c58
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
> I used syzkaller and could reproduce the similar issue "WARNING in
> get_page_from_freelist" in v6.9 mainline kernel.

The warning report is different with the dead-lock syzbot report. The
warning is "WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1))" in
rmqueue() and it is caused by "kzalloc(sizeof(struct xfs_mount),
GFP_KERNEL | __GFP_NOFAIL)" in xfs_init_fs_context().
>
> Bisected and found first bad commit:
> "
> 816d334afa85 kexec: modify the meaning of the end parameter in kimage_is_destination_range()
> "
> Revert above commit on top of v6.9 kernel this issue was gone.
>
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240517_085953_get_page_from_freelist
> mount_*.gz are in above link.
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/rep.c
> Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/repro.prog
> Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/repro.report

I think it is a false positive, because without KASAN enabled, the size
of xfs_mount is about 2496 bytes and it is impossible to trigger the
WARN_ON_ONCE(). However with KASAN enabled, the size of xfs_mount will
be greater than 4096, so the warning will be triggered accordingly when
the 8KB-slab needs to refill its slabs.


