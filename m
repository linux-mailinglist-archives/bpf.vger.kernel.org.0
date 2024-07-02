Return-Path: <bpf+bounces-33592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6950891ECA2
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 03:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A37283E5A
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAE14C8B;
	Tue,  2 Jul 2024 01:23:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DAA4A06
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719883407; cv=none; b=TInqB2PIZ2bkUTgJw33zXFsx2osaa0GY5JVDX3eesSbz1c3SY9RawOE2a6NHGe/FB023lChkNS8Css4iiavPVdWj27yzITG6AE/NjnzmYycvWf3BBaYsROoKuP8vrZjSGPhG7SBTHt1kazbNckPlzA1oSw55d6cnqTdj9NBx5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719883407; c=relaxed/simple;
	bh=Mp1lm6sNFB4G54hLcBuL3VTQLiQxD63ZieamI4xz6IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRAvZQm4riX4hLjeZQWAoOuNRMOfGxzw8vw+SxCbfDYDoA0gsl8AMFt9ircschkwnHnKLQ/iX4//MBYquOUE94jHdQ3s7ZnPH1s8I/Bw+iJTLGZ0IsGVGOwOFwFLCi/vzI6TBPi97/6snutync47ChFhWQB7kZ+1erfnX+gFbtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WClXb5TZCz4f3jM1
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 09:23:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1749F1A0189
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 09:23:19 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgCHjPWDVoNmkmijAw--.62039S2;
	Tue, 02 Jul 2024 09:23:17 +0800 (CST)
Message-ID: <d16b4f29-8966-464f-b530-35e39fda3f46@huaweicloud.com>
Date: Tue, 2 Jul 2024 09:23:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf: Fix null pointer dereference in
 resolve_prog_type() for BPF_PROG_TYPE_EXT
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 hffilwlqm@gmail.com
References: <20240624120533.873789-1-wutengda@huaweicloud.com>
 <3e35e433-4941-1432-6dd9-685b89f3aa15@iogearbox.net>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <3e35e433-4941-1432-6dd9-685b89f3aa15@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHjPWDVoNmkmijAw--.62039S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy5Aw4xuw13CryDtr47Jwb_yoWruFyUpr
	ykKrW3Krs5try8Ary7Jr17tryUJF1UAa4DJrnxK3WrAFW5Zr12gw18XrsFgr1DJr48Ary7
	tr4qgrnFv345JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2024/7/1 23:39, Daniel Borkmann wrote:
> On 6/24/24 2:05 PM, Tengda Wu wrote:
>> When loading a EXT program without specifying `attr->attach_prog_fd`,
>> the `prog->aux->dst_prog` will be null. At this time, calling
>> resolve_prog_type() anywhere will result in a null pointer dereference.
>>
>> Example stack trace:
>>
>> [    8.107863] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
>> [    8.108262] Mem abort info:
>> [    8.108384]   ESR = 0x0000000096000004
>> [    8.108547]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    8.108722]   SET = 0, FnV = 0
>> [    8.108827]   EA = 0, S1PTW = 0
>> [    8.108939]   FSC = 0x04: level 0 translation fault
>> [    8.109102] Data abort info:
>> [    8.109203]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>> [    8.109399]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [    8.109614]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [    8.109836] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101354000
>> [    8.110011] [0000000000000004] pgd=0000000000000000, p4d=0000000000000000
>> [    8.112624] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>> [    8.112783] Modules linked in:
>> [    8.113120] CPU: 0 PID: 99 Comm: may_access_dire Not tainted 6.10.0-rc3-next-20240613-dirty #1
>> [    8.113230] Hardware name: linux,dummy-virt (DT)
>> [    8.113390] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    8.113429] pc : may_access_direct_pkt_data+0x24/0xa0
>> [    8.113746] lr : add_subprog_and_kfunc+0x634/0x8e8
>> [    8.113798] sp : ffff80008283b9f0
>> [    8.113813] x29: ffff80008283b9f0 x28: ffff800082795048 x27: 0000000000000001
>> [    8.113881] x26: ffff0000c0bb2600 x25: 0000000000000000 x24: 0000000000000000
>> [    8.113897] x23: ffff0000c1134000 x22: 000000000001864f x21: ffff0000c1138000
>> [    8.113912] x20: 0000000000000001 x19: ffff0000c12b8000 x18: ffffffffffffffff
>> [    8.113929] x17: 0000000000000000 x16: 0000000000000000 x15: 0720072007200720
>> [    8.113944] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
>> [    8.113958] x11: 0720072007200720 x10: 0000000000f9fca4 x9 : ffff80008021f4e4
>> [    8.113991] x8 : 0101010101010101 x7 : 746f72705f6d656d x6 : 000000001e0e0f5f
>> [    8.114006] x5 : 000000000001864f x4 : ffff0000c12b8000 x3 : 000000000000001c
>> [    8.114020] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
>> [    8.114126] Call trace:
>> [    8.114159]  may_access_direct_pkt_data+0x24/0xa0
>> [    8.114202]  bpf_check+0x3bc/0x28c0
>> [    8.114214]  bpf_prog_load+0x658/0xa58
>> [    8.114227]  __sys_bpf+0xc50/0x2250
>> [    8.114240]  __arm64_sys_bpf+0x28/0x40
>> [    8.114254]  invoke_syscall.constprop.0+0x54/0xf0
>> [    8.114273]  do_el0_svc+0x4c/0xd8
>> [    8.114289]  el0_svc+0x3c/0x140
>> [    8.114305]  el0t_64_sync_handler+0x134/0x150
>> [    8.114331]  el0t_64_sync+0x168/0x170
>> [    8.114477] Code: 7100707f 54000081 f9401c00 f9403800 (b9400403)
>> [    8.118672] ---[ end trace 0000000000000000 ]---
>>
>> Fix this by adding dst_prog non-empty check in BPF_PROG_TYPE_EXT case
>> when calling bpf_prog_load().
>>
>> Note the BPF_PROG_TYPE_EXT type detection in libbpf also needs to be
>> adapted by passing a valid attach_prog_fd, since an empty attach_prog_fd
>> is no longer allowed when loading EXT program.
>>
>> Fixes: 4a9c7bbe2ed4 ("bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> Cc: stable@vger.kernel.org # v5.18+
>> ---
>> v2: Fix libbpf_probe_prog_types test failure reported by CI by adapting
>> libbpf code. (thanks for jirka's reminder)
>>
>> v1: https://lore.kernel.org/all/20240620060701.1465291-1-wutengda@huaweicloud.com/
>>
>>   kernel/bpf/syscall.c          |  5 ++++-
>>   tools/lib/bpf/libbpf_probes.c | 13 ++++++++++++-
>>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> Could you pls make this a 3-patch series against bpf?
> 
> First patch is the kernel-only fix, 2nd patch is the libbpf one, and 3rd patch adds
> a small BPF selftest for the BPF CI.
> 
> Thanks a lot,
> Daniel

Okay, I will resend soon.

Tengda


