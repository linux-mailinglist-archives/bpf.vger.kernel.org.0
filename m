Return-Path: <bpf+bounces-5035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153B0753F6B
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 18:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9341C211D7
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F94715485;
	Fri, 14 Jul 2023 16:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF340D521;
	Fri, 14 Jul 2023 16:00:24 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016193595;
	Fri, 14 Jul 2023 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+FNaOd6NP6sRs5MR4ZTc3WcaeTlFWfdAKhZ/NS4utD0=; b=I8BdlEDtqlPPXDPV6hu9L/z7ff
	R4wYUXvPQxW1Y90DfUqdwFAeRYhUmhTFS2h9O63lmODo5Zl7qXFQdPiDx3YDxKkvzCrhMDCWFOUir
	JdbGYpaoSkuBuynRbAfZeMX7WAqP44ymUt7x+OHrr/ao+3h5eVBCYVqAK/dTdnVXPo1ze/Xh65AQJ
	3wcg0shsiR1u0j1v1jwfsNkSpeeGSpeNpKHGGowF7mQ8/Qs7J/07sMCa6WQ74x/Tc21tBz/XIiu1f
	TwQyCeB5lh0nswdPI4dyOKVks4SXTV0hvItrfqgHDwYItGr7KrEfAPDf2t4euuU3ERiON1AFMvBak
	wpe/KuAA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qKLDJ-000MGo-Cc; Fri, 14 Jul 2023 18:00:13 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qKLDI-000Nv0-R9; Fri, 14 Jul 2023 18:00:12 +0200
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
 davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230710201218.19460-1-daniel@iogearbox.net>
 <20230710201218.19460-2-daniel@iogearbox.net>
 <CAEf4Bza_X30yLPm0Lhy2c-u1Qw1Ci9AVoy5jo_XXCaT9zz+3jg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <db172178-f030-5f9f-928e-40e9ec2ab4cb@iogearbox.net>
Date: Fri, 14 Jul 2023 18:00:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4Bza_X30yLPm0Lhy2c-u1Qw1Ci9AVoy5jo_XXCaT9zz+3jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26969/Fri Jul 14 09:28:15 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/11/23 8:48 PM, Andrii Nakryiko wrote:
> On Mon, Jul 10, 2023 at 1:12 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
[...]
>> +static inline int bpf_mprog_max(void)
>> +{
>> +       return ARRAY_SIZE(((struct bpf_mprog_entry *)NULL)->fp_items) - 1;
>> +}
> 
> so we can only add BPF_MPROG_MAX - 1 progs, right? I presume the last
> entry is presumed to be always NULL, right?

Correct.

>> +static inline int bpf_mprog_total(struct bpf_mprog_entry *entry)
>> +{
>> +       int total = entry->parent->count;
>> +
>> +       WARN_ON_ONCE(total > bpf_mprog_max());
>> +       return total;
>> +}
>> +
> 
> [...]
> 
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index 1d3892168d32..1bea2eb912cd 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -12,7 +12,7 @@ obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list
>>   obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
>>   obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
>>   obj-${CONFIG_BPF_LSM}    += bpf_inode_storage.o
>> -obj-$(CONFIG_BPF_SYSCALL) += disasm.o
>> +obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
>>   obj-$(CONFIG_BPF_JIT) += trampoline.o
>>   obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
>>   obj-$(CONFIG_BPF_JIT) += dispatcher.o
>> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
>> new file mode 100644
>> index 000000000000..1c4fcde74969
>> --- /dev/null
>> +++ b/kernel/bpf/mprog.c
>> @@ -0,0 +1,427 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Isovalent */
>> +
>> +#include <linux/bpf.h>
>> +#include <linux/bpf_mprog.h>
>> +
>> +static int bpf_mprog_link(struct bpf_tuple *tuple,
>> +                         u32 object, u32 flags,
> 
> so I tried to get used to this "object" notation, but I think it's
> still awkwards and keeps me asking "what is this really" every single
> time I read this. I wonder if something like "fd_or_id" as a name
> would make it more obvious?

Ok, fixed it in the v5.

[...]
>> +       struct bpf_mprog_fp *fp, *fpp;
>> +       struct bpf_mprog_entry *peer;
>> +
>> +       peer = bpf_mprog_peer(entry);
>> +       bpf_mprog_entry_clear(peer);
>> +       if (idx < 0) {
>> +               bpf_mprog_read_fp(peer, j, &fpp);
>> +               bpf_mprog_write_fp(fpp, ntuple);
>> +               bpf_mprog_write_cp(&cpp[j], ntuple);
>> +               j++;
>> +       }
>> +       for (i = 0; i <= total; i++) {
>> +               bpf_mprog_read_fp(peer, j, &fpp);
>> +               if (idx == i && (flags & BPF_F_AFTER)) {
>> +                       bpf_mprog_write(fpp, &cpp[j], ntuple);
>> +                       j++;
>> +                       bpf_mprog_read_fp(peer, j, &fpp);
>> +               }
>> +               if (i < total) {
>> +                       bpf_mprog_read(entry, i, &fp, &cp);
>> +                       bpf_mprog_copy(fpp, &cpp[j], fp, cp);
>> +                       j++;
>> +               }
>> +               if (idx == i && (flags & BPF_F_BEFORE)) {
>> +                       bpf_mprog_read_fp(peer, j, &fpp);
>> +                       bpf_mprog_write(fpp, &cpp[j], ntuple);
>> +                       j++;
>> +               }
>> +       }
> 
> sorry if I miss some subtle point, but I wonder why this is so
> complicated? I think this choice of idx == -1 meaning prepend is
> leading to this complication. It's not also clear why there is this
> BPF_F_AFTER vs BPF_F_BEFORE distinction when we already determined a
> position where new program has to be inserted (so after or before
> should be irrelevant).
> 
> Please let me know why the below doesn't work.
> 
> Let's define that idx is the position where new prog/link tuple has to
> be inserted. It can be in the range [0, N], where N is number of
> programs currently in the mprog_peer. Note that N is inclusive above.
> 
> The algorithm for insertion is simple: everything currently at
> entry->fp_items[idx] and after gets shifted. And we can do it with a
> simple memmove:
> 
> memmove(peer->fp_items + idx + 1, peer->fp_iters + idx,
> (bpf_mprog_total(entry) - idx) * sizeof(struct bpf_mprof_fp));
> /* similar memmove for cp_items/cpp array, of course */
> /* now set new prog at peer->fp_items[idx] */
> 
> The above should replace entire above for loop and that extra if
> before the loop. And it should work for corner cases:
> 
>    - idx == 0 (prepend), will shift everything to the right, and put
> new prog at position 0. Exactly what we wanted.
>    - idx == N (append), will shift nothing (that memmov should be a
> no-op because size is zero, total == idx == N)
> 
> We just need to make sure that the above shift won't overwrite the
> very last NULL. So bpf_mprog_total() should be < BPF_MPROG_MAX - 2
> before all this.
> 
> Seems as simple as that, is there any complication I skimmed over?
[...]

>> +static int bpf_mprog_delete(struct bpf_mprog_entry *entry,
>> +                           struct bpf_tuple *dtuple, int idx)
>> +{
>> +       int i = 0, j, ret, total = bpf_mprog_total(entry);
>> +       struct bpf_mprog_cp *cp, cpp[BPF_MPROG_MAX] = {};
>> +       struct bpf_mprog_fp *fp, *fpp;
>> +       struct bpf_mprog_entry *peer;
>> +
>> +       ret = bpf_mprog_tuple_confirm(entry, dtuple, idx);
>> +       if (ret)
>> +               return ret;
>> +       peer = bpf_mprog_peer(entry);
>> +       bpf_mprog_entry_clear(peer);
>> +       if (idx < 0)
>> +               i++;
>> +       if (idx == total)
>> +               total--;
>> +       for (j = 0; i < total; i++) {
>> +               if (idx == i)
>> +                       continue;
>> +               bpf_mprog_read_fp(peer, j, &fpp);
>> +               bpf_mprog_read(entry, i, &fp, &cp);
>> +               bpf_mprog_copy(fpp, &cpp[j], fp, cp);
>> +               j++;
>> +       }
>> +       bpf_mprog_commit_cp(peer, cpp);
>> +       bpf_mprog_dec(peer);
>> +       bpf_mprog_mark_ref(peer, dtuple);
>> +       return bpf_mprog_total(peer) ?
>> +              BPF_MPROG_SWAP : BPF_MPROG_FREE;
> 
> for delete it's also a bit unclear to me. We are deleting some
> specific spot, so idx should be a valid [0, N) value, no? Then why the
> bpf_mprog_tuple_confirm() has this special <= first and idx >= last
> handling?
> 
> Deletion should be similar to instertion, just the shift is in the
> other direction. And then setting NULLs at N-1 position to ensure
> proper NULL termination of fp array.

Agree, the naming was suboptimal and I adapted this slightly in v5.
It's picking the elements when no deletion fd was selected, but rather
delete from front/back or relative to some element, so it needs to
fetch the prog.

[...]
> 
> and then here just have special casing for -ERANGE, and otherwise
> treat anything else negative as error
> 
> tidx = bpf_mprog_pos_exact(entry, &rtuple);
> /* and adjust +1 for BPF_F_AFTER */
> if (tidx >= 0)
>      tidx += 1;
> if (idx != -ERANGE && tidx != idx) {
>      ret = tidx < 0 ? tidx : -EDOM;
>      goto out;
> }
> idx = tidx;

This looks much less intuitive to me given replace and delete case need
exact position, just not the relative insertion. I reworked this also with
the memmove in v5, but kept the more obvious _exact/before/after ones.

Thanks a lot for the feedback!

>> +       }
>> +       if (idx < -1) {
>> +               if (rtuple.prog || flags) {
>> +                       ret = -EINVAL;
>> +                       goto out;
>> +               }
>> +               idx = bpf_mprog_total(entry);
>> +               flags = BPF_F_AFTER;
>> +       }
>> +       if (idx >= bpf_mprog_max()) {
>> +               ret = -EDOM;
>> +               goto out;
>> +       }
>> +       if (flags & BPF_F_REPLACE)
>> +               ret = bpf_mprog_replace(entry, &ntuple, idx);
>> +       else
>> +               ret = bpf_mprog_insert(entry, &ntuple, idx, flags);
>> +out:
>> +       bpf_mprog_tuple_put(&rtuple);
>> +       return ret;
>> +}
>> +
> 
> [...]
> 


