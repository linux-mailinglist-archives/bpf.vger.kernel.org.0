Return-Path: <bpf+bounces-26411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AAD89F253
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7F61F22722
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651BA158A0E;
	Wed, 10 Apr 2024 12:34:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5282BAEC;
	Wed, 10 Apr 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752474; cv=none; b=c8R+1VhBramvTNPMizesk5DNwQC49kZkOCfX0lGgOzcKiFqMyT6N9n78cmaVb5fQ9slmhebnHGB3TAjemsMu/PktbnZR5VD4Iwp7AFI76RTTw+/u77Uuuh3pwyyNkSXLvWQUUlo8MM5rsJfivIYx5VoZOQbGj+5zqIajl3qX/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752474; c=relaxed/simple;
	bh=1fRLYc+qyUC59QMhhF13RPBzq0DG7wFbcAZFwFBG7CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPq0DILDSCZbPMv5jw3ECitiGyHeONur7ydUOD/yONiyEDSpCUKh0SWPOyyuN61RUB5MRvRh/LUzURHJrS+c/BbZMi2GzzfIMJMWGKy/uvPGh89+ghui0fMJWq20pfGE5Dl/K9HPTPALVllh+Lb+weMnWTyqyvjMU2merZXMxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF2MH0441z4f3m76;
	Wed, 10 Apr 2024 20:34:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A32D31A058D;
	Wed, 10 Apr 2024 20:34:27 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCH2GpRhxZmaHAjJw--.24979S2;
	Wed, 10 Apr 2024 20:34:25 +0800 (CST)
Message-ID: <a7bffa07-4743-4cc5-a763-3dd062f886d4@huaweicloud.com>
Date: Wed, 10 Apr 2024 20:34:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/7] Add check for bpf lsm return value
Content-Language: en-US
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Florent Revest <revest@chromium.org>,
 Brendan Jackman <jackmanb@chromium.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20240325095653.1720123-1-xukuohai@huaweicloud.com>
 <CACYkzJ6fZ0mc+A2hJfD4+6EkasrOwy_Ygw=CMg0KZYdm8Fao7A@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CACYkzJ6fZ0mc+A2hJfD4+6EkasrOwy_Ygw=CMg0KZYdm8Fao7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH2GpRhxZmaHAjJw--.24979S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWry5Ar1ktry7uF15ZrW5KFg_yoW7Jw13pF
	45tFy8Kr4Iqr1UJF18KF45Jry7tFW7AF1UXr92qr95AF13ur1DJw18Jr429wnxJr4UZry7
	tFWqqa18tF15WaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/9/2024 5:45 AM, KP Singh wrote:
> On Mon, Mar 25, 2024 at 10:53 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> A bpf prog returning positive number attached to file_alloc_security hook
>> will make kernel panic.
>>
>> Here is a panic log:
>>
>> [  441.235774] BUG: kernel NULL pointer dereference, address: 00000000000009
>> [  441.236748] #PF: supervisor write access in kernel mode
>> [  441.237429] #PF: error_code(0x0002) - not-present page
>> [  441.238119] PGD 800000000b02f067 P4D 800000000b02f067 PUD b031067 PMD 0
>> [  441.238990] Oops: 0002 [#1] PREEMPT SMP PTI
>> [  441.239546] CPU: 0 PID: 347 Comm: loader Not tainted 6.8.0-rc6-gafe0cbf23373 #22
>> [  441.240496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b4
>> [  441.241933] RIP: 0010:alloc_file+0x4b/0x190
>> [  441.242485] Code: 8b 04 25 c0 3c 1f 00 48 8b b0 30 0c 00 00 e8 9c fe ff ff 48 3d 00 f0 ff fb
>> [  441.244820] RSP: 0018:ffffc90000c67c40 EFLAGS: 00010203
>> [  441.245484] RAX: ffff888006a891a0 RBX: ffffffff8223bd00 RCX: 0000000035b08000
>> [  441.246391] RDX: ffff88800b95f7b0 RSI: 00000000001fc110 RDI: f089cd0b8088ffff
>> [  441.247294] RBP: ffffc90000c67c58 R08: 0000000000000001 R09: 0000000000000001
>> [  441.248209] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
>> [  441.249108] R13: ffffc90000c67c78 R14: ffffffff8223bd00 R15: fffffffffffffff4
>> [  441.250007] FS:  00000000005f3300(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
>> [  441.251053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  441.251788] CR2: 00000000000001a9 CR3: 000000000bdc4003 CR4: 0000000000170ef0
>> [  441.252688] Call Trace:
>> [  441.253011]  <TASK>
>> [  441.253296]  ? __die+0x24/0x70
>> [  441.253702]  ? page_fault_oops+0x15b/0x480
>> [  441.254236]  ? fixup_exception+0x26/0x330
>> [  441.254750]  ? exc_page_fault+0x6d/0x1c0
>> [  441.255257]  ? asm_exc_page_fault+0x26/0x30
>> [  441.255792]  ? alloc_file+0x4b/0x190
>> [  441.256257]  alloc_file_pseudo+0x9f/0xf0
>> [  441.256760]  __anon_inode_getfile+0x87/0x190
>> [  441.257311]  ? lock_release+0x14e/0x3f0
>> [  441.257808]  bpf_link_prime+0xe8/0x1d0
>> [  441.258315]  bpf_tracing_prog_attach+0x311/0x570
>> [  441.258916]  ? __pfx_bpf_lsm_file_alloc_security+0x10/0x10
>> [  441.259605]  __sys_bpf+0x1bb7/0x2dc0
>> [  441.260070]  __x64_sys_bpf+0x20/0x30
>> [  441.260533]  do_syscall_64+0x72/0x140
>> [  441.261004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>> [  441.261643] RIP: 0033:0x4b0349
>> [  441.262045] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 88
>> [  441.264355] RSP: 002b:00007fff74daee38 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>> [  441.265293] RAX: ffffffffffffffda RBX: 00007fff74daef30 RCX: 00000000004b0349
>> [  441.266187] RDX: 0000000000000040 RSI: 00007fff74daee50 RDI: 000000000000001c
>> [  441.267114] RBP: 000000000000001b R08: 00000000005ef820 R09: 0000000000000000
>> [  441.268018] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
>> [  441.268907] R13: 0000000000000004 R14: 00000000005ef018 R15: 00000000004004e8
>>
>> The reason is that the positive number returned by bpf prog is not a
>> valid errno, and could not be filtered out with IS_ERR which is used by
>> the file system to check errors. As a result, the filesystem mistakenly
>> uses this random positive number as file pointer, causing panic.
>>
>> To fix this issue, there are two schemes:
>>
>> 1. Modify the calling sites of file_alloc_security to take positive
>>     return values as zero.
>>
>> 2. Make the bpf verifier to ensure no unpredicted value returned by
>>     lsm bpf prog.
>>
>> Considering that hook file_alloc_security never returned positive number
>> before bpf lsm was introduced, and other lsm hooks may have the same
>> problem, scheme 2 is more reasonable.
>>
>> So this patch set adds lsm return value check in verifier to fix it.
>>
>> v2:
>> fix bpf ci failure
>>
>> v1:
>> https://lore.kernel.org/bpf/20240316122359.1073787-1-xukuohai@huaweicloud.com/
>>
>> Xu Kuohai (7):
>>    bpf, lsm: Annotate lsm hook return integer with new macro LSM_RET_INT
>>    bpf, lsm: Add return value range description for lsm hook
>>    bpf, lsm: Add function to read lsm hook return value range
>>    bpf, lsm: Check bpf lsm hook return values in verifier
>>    bpf: Fix compare error in function retval_range_within
>>    selftests/bpf: Avoid load failure for token_lsm.c
>>    selftests/bpf: Add return value checks and corrections for failed
>>      progs
> 
> This series does not apply cleanly on any of the following branches:
> 
> bpf-next
> bpf
> linux
> linux-next
> or Paul's lsm branches
> 
> There are just too many merge conflicts in the lsm_hook_defs.h file.
>

Oh, the series is a bit out of date, will rebase to the latest bpf-next branch.

> - KP


