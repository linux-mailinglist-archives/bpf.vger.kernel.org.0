Return-Path: <bpf+bounces-43990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17019BC358
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 03:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F5E1C21E49
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6640D487AE;
	Tue,  5 Nov 2024 02:50:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F74A0A;
	Tue,  5 Nov 2024 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775000; cv=none; b=YpEhVlPu1ljrqErSeysD9bl9EvCQ6hECr0njY2IZhErPrgikeMFxjiIdmJTlC5NTas/PbZvVBK0issVKtUFMQYon6k2tqTsn9/rFVA9magWZqkWLDKk/yVje2k+5V+UnY1PHGXwlk5eReAkl3zOsHnYMEnE7Q3tiq+eiVoTaqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775000; c=relaxed/simple;
	bh=Zldqxlyz13smoHjP0fcUVwNkG39W/q3OENBvVhi6u5Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m0mPBjY0kImmVOO0EoyfCXDP5DKCwhSssPPoBLUsTFKBqAIcpO6xtbKrAiUXS2bdDpLjM/B+1+WL+cWHus3WtIOjuqe7BPL0tIi3if22xao/Hh8ztoAu5lJSMYlaXRezS5UlwC6D0yhI5fsY95CQBw14p4q2ftqYaofP0vXnA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XjCVB3j7kz4f3jtw;
	Tue,  5 Nov 2024 10:49:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 54B6F1A018D;
	Tue,  5 Nov 2024 10:49:51 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDXAIXIhyln09OKAw--.51032S2;
	Tue, 05 Nov 2024 10:49:48 +0800 (CST)
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in bpf_map_put
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 syzbot <syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, boqun.feng@gmail.com,
 bpf@vger.kernel.org, daniel@iogearbox.net, eadavis@qq.com,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 longman@redhat.com, martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, tglx@linutronix.de
References: <67251dc5.050a0220.529b6.015c.GAE@google.com>
 <67283170.050a0220.3c8d68.0ad6.GAE@google.com>
 <20241104162832.OQvrGDiP@linutronix.de>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <7e8e835d-ef94-80e6-e98e-f8ed4a8fc78c@huaweicloud.com>
Date: Tue, 5 Nov 2024 10:49:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241104162832.OQvrGDiP@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDXAIXIhyln09OKAw--.51032S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWruFy7Zr4fJr1kJFyfCrg_yoW7Jw4UpF
	WrGFZIka1kZr1qk3yrt3Z8KrWjgw4ay3yUC348WFy8C3ZxZrnagw1xKFZ7Kr15ur1kZ3ZY
	vFZFkwn8tw18WFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUxo7KDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/5/2024 12:28 AM, Sebastian Andrzej Siewior wrote:
> On 2024-11-03 18:29:04 [-0800], syzbot wrote:
>> syzbot has bisected this issue to:
>>
>> commit 560af5dc839eef08a273908f390cfefefb82aa04
>> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Date:   Wed Oct 9 15:45:03 2024 +0000
>>
>>     lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122a4740580000
>> start commit:   f9f24ca362a4 Add linux-next specific files for 20241031
>> git tree:       linux-next
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=112a4740580000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=162a4740580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d2adb332fe371b0595e3
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174432a7980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ffe55f980000
>>
>> Reported-by: syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com
>> Fixes: 560af5dc839e ("lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.")
>>
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> This is due to raw_spinlock_t in bucket::lock and the acquired
> spinlock_t underneath. Would it would to move free part outside of the
> locked section?

I think moving free_htab_elem() after htab_unlock_bucket() is OK. But
the fix below is not enough, and there is some corn cases for
pre-allocated element . I had written a patch for the problem a few day
ago because the problem can be easily reproduced by running test_maps. I
am also writing a selftest patch for it.  I could post the patch and the
selftest patch if you are OK with it.
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index b14b87463ee04..1d8d09fdd2da5 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -824,13 +824,14 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
>  	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
>  		if (l == tgt_l) {
>  			hlist_nulls_del_rcu(&l->hash_node);
> -			check_and_free_fields(htab, l);
>  			bpf_map_dec_elem_count(&htab->map);
>  			break;
>  		}
>  
>  	htab_unlock_bucket(htab, b, tgt_l->hash, flags);
>  
> +	if (l == tgt_l)
> +		check_and_free_fields(htab, l);
>  	return l == tgt_l;
>  }
>  
> @@ -1181,14 +1182,18 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>  	 * concurrent search will find it before old elem
>  	 */
>  	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> -	if (l_old) {
> +	if (l_old)
>  		hlist_nulls_del_rcu(&l_old->hash_node);
> +	htab_unlock_bucket(htab, b, hash, flags);
> +
> +	if (l_old) {
>  		if (!htab_is_prealloc(htab))
>  			free_htab_elem(htab, l_old);
>  		else
>  			check_and_free_fields(htab, l_old);
>  	}
> -	ret = 0;
> +	return 0;
> +
>  err:
>  	htab_unlock_bucket(htab, b, hash, flags);
>  	return ret;
> @@ -1433,14 +1438,15 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
>  
>  	l = lookup_elem_raw(head, hash, key, key_size);
>  
> -	if (l) {
> +	if (l)
>  		hlist_nulls_del_rcu(&l->hash_node);
> -		free_htab_elem(htab, l);
> -	} else {
> +	else
>  		ret = -ENOENT;
> -	}
>  
>  	htab_unlock_bucket(htab, b, hash, flags);
> +
> +	if (l)
> +		free_htab_elem(htab, l);
>  	return ret;
>  }
>  
> @@ -1647,14 +1653,16 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
>  		}
>  
>  		hlist_nulls_del_rcu(&l->hash_node);
> -		if (!is_lru_map)
> -			free_htab_elem(htab, l);
>  	}
>  
>  	htab_unlock_bucket(htab, b, hash, bflags);
>  
> -	if (is_lru_map && l)
> -		htab_lru_push_free(htab, l);
> +	if (l) {
> +		if (is_lru_map)
> +			htab_lru_push_free(htab, l);
> +		else
> +			free_htab_elem(htab, l);
> +	}
>  
>  	return ret;
>  }
> @@ -1851,15 +1859,12 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>  
>  			/* bpf_lru_push_free() will acquire lru_lock, which
>  			 * may cause deadlock. See comments in function
> -			 * prealloc_lru_pop(). Let us do bpf_lru_push_free()
> -			 * after releasing the bucket lock.
> +			 * prealloc_lru_pop(). htab_lru_push_free() may allocate
> +			 * sleeping locks. Let us do bpf_lru_push_free() after
> +			 * releasing the bucket lock.
>  			 */
> -			if (is_lru_map) {
> -				l->batch_flink = node_to_free;
> -				node_to_free = l;
> -			} else {
> -				free_htab_elem(htab, l);
> -			}
> +			l->batch_flink = node_to_free;
> +			node_to_free = l;
>  		}
>  		dst_key += key_size;
>  		dst_val += value_size;
> @@ -1871,7 +1876,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>  	while (node_to_free) {
>  		l = node_to_free;
>  		node_to_free = node_to_free->batch_flink;
> -		htab_lru_push_free(htab, l);
> +		if (is_lru_map)
> +			htab_lru_push_free(htab, l);
> +		else
> +			free_htab_elem(htab, l);
>  	}
>  
>  next_batch:
>
> .


