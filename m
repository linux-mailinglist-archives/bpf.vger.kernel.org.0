Return-Path: <bpf+bounces-54884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA96A753D6
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 02:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B089517558F
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 01:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E9E8F4A;
	Sat, 29 Mar 2025 01:24:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B915A8
	for <bpf@vger.kernel.org>; Sat, 29 Mar 2025 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743211461; cv=none; b=BPrpM9Vg3Ovx5pKcbme9e2nNWMlo+74jcTqSf8Uxa85jSVaCu2P9WCkl9V2kNYqsMJewMBaCWZnZ9NmcyTS5h0nkYloTFItoXR6YQVYOr7JrGuPcy1NPh/1ZozqYQdb6KJztyWn6zZRWl897PjbYBraTJbCB8mopS0OQii/EC2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743211461; c=relaxed/simple;
	bh=xggSNdesiIsRD7iMVFlPFMwiWQ48xBfEJTWPmaI4Sxc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X2AJpnh7Re5ojwi1LV8QeOOLVDPw0jHfMyOPatufdC6s2GUBMgVKlUu1Kc4SM3NYgEDJIfADb6psPKp1Ii80xP5hFTK9dsfXV0Tk33omnjfQioUxSEqPDB10jjdLgfFbI+ixFtFS3+372jcCcFQjmtAF1FIyTujjYcRR+gz13/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZPfmk1lyXz4f3m7L
	for <bpf@vger.kernel.org>; Sat, 29 Mar 2025 09:23:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C1F2D1A0B7B
	for <bpf@vger.kernel.org>; Sat, 29 Mar 2025 09:24:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBHmcO5S+dnQhUIHw--.38750S2;
	Sat, 29 Mar 2025 09:24:13 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 0/6] bpf: Support atomic update for htab of
 maps
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 Zvi Effron <zeffron@riotgames.com>, Cody Haas <chaas@riotgames.com>
References: <20250308135110.953269-1-houtao@huaweicloud.com>
 <04a2b00d-970f-7357-81e3-509a543550e9@huaweicloud.com>
 <CAADnVQJeFmNjjshdXUAm0jnOofWSA-O3YJCfvtP82ZbYO40rBQ@mail.gmail.com>
 <CAEf4BzY91syLTet6S=NWH=hnuV3Ye0dSWy_nYbqND3g1FNrcoQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <60ffe544-9c7d-24c3-fa10-dc560db6f728@huaweicloud.com>
Date: Sat, 29 Mar 2025 09:24:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzY91syLTet6S=NWH=hnuV3Ye0dSWy_nYbqND3g1FNrcoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBHmcO5S+dnQhUIHw--.38750S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1kZr1kCF4DWry8tr1fWFg_yoWrWryUpa
	yF9F4akrWkJFnFqw1Sqw42gF4Fyrn3Kr15Zwnrtr4UCFsYkFn7tr1xKF4F9FZ5CryFgrya
	qryjqrsxu34xAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 3/29/2025 6:05 AM, Andrii Nakryiko wrote:
> On Mon, Mar 24, 2025 at 6:29 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Mon, Mar 24, 2025 at 7:36 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>> ping ?
>> Sorry for the delay. Still thinking about it.
>> The mix of cleanups and features make it difficult to evaluate.
>> Most bpf folks attend lsfmmbpf this week, so expect more delays.
> I looked at the patches and didn't find anything obviously wrong with them.
>
> I'm a bit worried how we implicitly assume that if it's not per-cpu,
> then htab_map_update_elem_in_place() will be working with FD hashtable
> and map->ops->map_fd_put_ptr() will be defined. Seems a bit error
> prone. But overall everything looks correct, and some of the
> refactorings (e.g. patch #1) are a nice clean up.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for looking at the patch set and acking it. Since bpf CI had
dropped the patch set, I will resend it next week.
>
> BTW, while I was reading all that code, I got a question. Why is it
> specifically per-CPU maps that allow in-place updates for arbitrary
> values? What makes it special? The assumption that we only have one
> BPF program using value on the current CPU or something?

I think part of the reason is that the update procedure will disable
interruption on current CPU, therefore, there will be not concurrent
lookup procedure on this CPU.
>
> If yes, what do we say about bpf_map_lookup_percpu_elem() executed
> from another CPU? Weird. Hopefully I'm missing something and it's not
> really just broken.

Er, considering that bpf_map_lookup_percpu_elem() can be used to lookup
element from any CPU, there may be concurrent update on CPU A and
lookup_percpu on CPU B, therefore, the lookup_percpu procedure may read
a partial updated value. It seem there is no better way to handle it. We
could do out-of-place update by allocation a new per-cpu pointer,
however due to the immediate reuse, the lookup_percpu procedure may read
a reused value in the per-cpu pointer.
>
>
>>> On 3/8/2025 9:51 PM, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Hi,
>>>>
>>>> The motivation for the patch set comes from the question raised by Cody
>>>> Haas [1]. When trying to concurrently lookup and update an existing
>>>> element in a htab of maps, the lookup procedure may return -ENOENT
>>>> unexpectedly. The first revision of the patch set tried to resolve the
>>>> problem by making the insertion of the new element and the deletion of
>>>> the old element being atomic from the perspective of the lookup process.
>>>> While the solution would benefit all hash maps, it does not fully
>>>> resolved the problem due to the immediate reuse issue. Therefore, in v2
>>>> of the patch set, it only fixes the problem for fd htab.
>>>>
>>>> Please see individual patches for details. Comments are always welcome.
>>>>
>>>> v2:
>>>>   * only support atomic update for fd htab
>>>>
>>>> v1: https://lore.kernel.org/bpf/20250204082848.13471-1-hotforest@gmail.com
>>>>
>>>> [1]: https://lore.kernel.org/xdp-newbies/CAH7f-ULFTwKdoH_t2SFc5rWCVYLEg-14d1fBYWH2eekudsnTRg@mail.gmail.com/
>>>>
>>>> Hou Tao (6):
>>>>   bpf: Factor out htab_elem_value helper()
>>>>   bpf: Rename __htab_percpu_map_update_elem to
>>>>     htab_map_update_elem_in_place
>>>>   bpf: Support atomic update for htab of maps
>>>>   bpf: Add is_fd_htab() helper
>>>>   bpf: Don't allocate per-cpu extra_elems for fd htab
>>>>   selftests/bpf: Add test case for atomic update of fd htab
>>>>
>>>>  kernel/bpf/hashtab.c                          | 148 +++++++-------
>>>>  .../selftests/bpf/prog_tests/fd_htab_lookup.c | 192 ++++++++++++++++++
>>>>  .../selftests/bpf/progs/fd_htab_lookup.c      |  25 +++
>>>>  3 files changed, 289 insertions(+), 76 deletions(-)
>>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_htab_lookup.c
>>>>  create mode 100644 tools/testing/selftests/bpf/progs/fd_htab_lookup.c
>>>>


