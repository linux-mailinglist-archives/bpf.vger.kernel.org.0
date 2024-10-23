Return-Path: <bpf+bounces-42858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FC19ABB4A
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 04:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1151284775
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 02:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3E14D8D1;
	Wed, 23 Oct 2024 02:03:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57620322;
	Wed, 23 Oct 2024 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729649034; cv=none; b=ZhJt9k0W9q7GsrbcEKdQURva1QjdxX0oG7k/2Q9+vudKW8B76BfplXapXoZ55wfRMc7piqEmIKRlwiVz2OwRUUDEYY24/d7Pj3oxr8JyW/SMjUIlmFT+4Iai4WT0rkuNValHgTG9MnTst7BbpR8Spia4UFruKdEogoNNEMpySxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729649034; c=relaxed/simple;
	bh=ttepsoM0aZmOx1uJFnaE6H/P6/4mIEhsZglcVNTr/JQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FnLx5GhyA8z4zuxNH5FPua6PHC420aN4uRzTJOUa2ywFJ3VGkcdZZefbg+c3cSwelzhVE0MeWwxOnaYWbMF/gLNv55xkKB1qnTmmSNU6qgGzHYrHkdDNqL3a+2NuBlh68z5e1hRDO7SEaQpaldkP6WCofT35nhCM+YledgHAiZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XYC4y5156z4f3jJD;
	Wed, 23 Oct 2024 10:03:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1FBC31A0568;
	Wed, 23 Oct 2024 10:03:48 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgB3zIiAWRhnKUrSEg--.30741S2;
	Wed, 23 Oct 2024 10:03:48 +0800 (CST)
Subject: Re: [PATCH] bpf: Fix out-of-bounds write in trie_get_next_key()
To: Byeonguk Jeong <jungbu2855@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <26f04a6b-4248-6898-8612-793e02712017@huaweicloud.com>
Date: Wed, 23 Oct 2024 10:03:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgB3zIiAWRhnKUrSEg--.30741S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45WF1UAFyxWFWfAF1DKFg_yoW5tFWkpF
	s8Kas7Cr48tFyDCF4FyFyUWr1kJF4xWw17JFZagry2vFy5Gr9rGr1qgFyUWFy7ury8AF4f
	XF1qqrZIqw10gFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 10/22/2024 9:45 AM, Byeonguk Jeong wrote:
> trie_get_next_key() allocates a node stack with size trie->max_prefixlen,
> while it writes (trie->max_prefixlen + 1) nodes to the stack when it has
> full paths from the root to leaves. For example, consider a trie with
> max_prefixlen is 8, and the nodes with key 0x00/0, 0x00/1, 0x00/2, ...
> 0x00/8 inserted. Subsequent calls to trie_get_next_key with _key with
> .prefixlen = 8 make 9 nodes be written on the node stack with size 8.
>
> Fixes: b471f2f1de8b ("bpf: implement MAP_GET_NEXT_KEY command for LPM_TRIE map")
> Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>
> ---

Tested-by: Hou Tao <houtao1@huawei.com>

Without the fix, there will be KASAN report as show below when dumping
all keys in the lpm-trie through bpf_map_get_next_key().

However, I have a dumb question: does it make sense to reject the
element with prefixlen = 0 ? Because I can't think of a use case where a
zero-length prefix will be useful.


 ==================================================================
 BUG: KASAN: slab-out-of-bounds in trie_get_next_key+0x133/0x530
 Write of size 8 at addr ffff8881076c2fc0 by task test_lpm_trie.b/446

 CPU: 0 UID: 0 PID: 446 Comm: test_lpm_trie.b Not tainted 6.11.0+ #52
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ...
 Call Trace:
  <TASK>
  dump_stack_lvl+0x6e/0xb0
  print_report+0xce/0x610
  ? trie_get_next_key+0x133/0x530
  ? kasan_complete_mode_report_info+0x3c/0x200
  ? trie_get_next_key+0x133/0x530
  kasan_report+0x9c/0xd0
  ? trie_get_next_key+0x133/0x530
  __asan_store8+0x81/0xb0
  trie_get_next_key+0x133/0x530
  __sys_bpf+0x1b03/0x3140
  ? __pfx___sys_bpf+0x10/0x10
  ? __pfx_vfs_write+0x10/0x10
  ? find_held_lock+0x8e/0xb0
  ? ksys_write+0xee/0x180
  ? syscall_exit_to_user_mode+0xb3/0x220
  ? mark_held_locks+0x28/0x90
  ? mark_held_locks+0x28/0x90
  __x64_sys_bpf+0x45/0x60
  x64_sys_call+0x1b2a/0x20d0
  do_syscall_64+0x5d/0x100
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f9c5e9c9c5d
  ......
  </TASK>
 Allocated by task 446:
  kasan_save_stack+0x28/0x50
  kasan_save_track+0x14/0x30
  kasan_save_alloc_info+0x36/0x40
  __kasan_kmalloc+0x84/0xa0
  __kmalloc_noprof+0x214/0x540
  trie_get_next_key+0xa7/0x530
  __sys_bpf+0x1b03/0x3140
  __x64_sys_bpf+0x45/0x60
  x64_sys_call+0x1b2a/0x20d0
  do_syscall_64+0x5d/0x100
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 The buggy address belongs to the object at ffff8881076c2f80
  which belongs to the cache kmalloc-rnd-09-64 of size 64
 The buggy address is located 0 bytes to the right of
  allocated 64-byte region [ffff8881076c2f80, ffff8881076c2fc0)

>  kernel/bpf/lpm_trie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 0218a5132ab5..9b60eda0f727 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -655,7 +655,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
>  	if (!key || key->prefixlen > trie->max_prefixlen)
>  		goto find_leftmost;
>  
> -	node_stack = kmalloc_array(trie->max_prefixlen,
> +	node_stack = kmalloc_array(trie->max_prefixlen + 1,
>  				   sizeof(struct lpm_trie_node *),
>  				   GFP_ATOMIC | __GFP_NOWARN);
>  	if (!node_stack)



