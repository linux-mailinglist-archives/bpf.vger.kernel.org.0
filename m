Return-Path: <bpf+bounces-18512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AB181B215
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 10:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230A41F25021
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DCF4A9BC;
	Thu, 21 Dec 2023 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX/0ROKW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA348CD1;
	Thu, 21 Dec 2023 09:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F9DC433C8;
	Thu, 21 Dec 2023 09:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703149672;
	bh=cChegn4gdi6K4NkyjhKknzaqPBc8Mp2ozRrVdnNVdA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YX/0ROKW9Ww++OAOkj0ddSNB7q2xQCmpnSvovwwopgsANkMguUpVuwwkkPj7xyAlr
	 V/m6Tot1+jzBOskr/YamQ67ljuisP5QWbIFHkEqtlgMIeoupJWfp7st0bamVY2YNQw
	 DszQ6lTvnwsoNNSjlEYnt48Kp389YdLlnNAtnIaAQrakPiy3pOmHR7MBQHIfADQPQX
	 zpv9iSs5eb7s9H3F9DlaKshKdo7jAzA0TXFYJq5yI6gx7AGaSOZ3l0pKA69K4PIeAf
	 6yr1oSHetC3jKxLRIZmBFthgAxIZ4PUvx37xSz4TgQS+eOgUaqFXNuC7LZFtEtjsNE
	 CqPmwtEuABAww==
Date: Thu, 21 Dec 2023 09:07:45 +0000
From: Lee Jones <lee@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>, stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>, Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCHv4 bpf 1/2] bpf: Fix prog_array_map_poke_run map poke
 update
Message-ID: <20231221090745.GA431072@google.com>
References: <20231206083041.1306660-1-jolsa@kernel.org>
 <20231206083041.1306660-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231206083041.1306660-2-jolsa@kernel.org>

Dear Stable,

> Lee pointed out issue found by syscaller [0] hitting BUG in prog array
> map poke update in prog_array_map_poke_run function due to error value
> returned from bpf_arch_text_poke function.
> 
> There's race window where bpf_arch_text_poke can fail due to missing
> bpf program kallsym symbols, which is accounted for with check for
> -EINVAL in that BUG_ON call.
> 
> The problem is that in such case we won't update the tail call jump
> and cause imbalance for the next tail call update check which will
> fail with -EBUSY in bpf_arch_text_poke.
> 
> I'm hitting following race during the program load:
> 
>   CPU 0                             CPU 1
> 
>   bpf_prog_load
>     bpf_check
>       do_misc_fixups
>         prog_array_map_poke_track
> 
>                                     map_update_elem
>                                       bpf_fd_array_map_update_elem
>                                         prog_array_map_poke_run
> 
>                                           bpf_arch_text_poke returns -EINVAL
> 
>     bpf_prog_kallsyms_add
> 
> After bpf_arch_text_poke (CPU 1) fails to update the tail call jump, the next
> poke update fails on expected jump instruction check in bpf_arch_text_poke
> with -EBUSY and triggers the BUG_ON in prog_array_map_poke_run.
> 
> Similar race exists on the program unload.
> 
> Fixing this by moving the update to bpf_arch_poke_desc_update function which
> makes sure we call __bpf_arch_text_poke that skips the bpf address check.
> 
> Each architecture has slightly different approach wrt looking up bpf address
> in bpf_arch_text_poke, so instead of splitting the function or adding new
> 'checkip' argument in previous version, it seems best to move the whole
> map_poke_run update as arch specific code.
> 
> [0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
> 
> Cc: Lee Jones <lee@kernel.org>
> Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> Reported-by: syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 46 +++++++++++++++++++++++++++++
>  include/linux/bpf.h         |  3 ++
>  kernel/bpf/arraymap.c       | 58 +++++++------------------------------
>  3 files changed, 59 insertions(+), 48 deletions(-)

Please could we have this backported?

Guided by the Fixes: tag.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8c10d9abc239..e89e415aa743 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3025,3 +3025,49 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
>  #endif
>  	WARN(1, "verification of programs using bpf_throw should have failed\n");
>  }
> +
> +void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
> +			       struct bpf_prog *new, struct bpf_prog *old)
> +{
> +	u8 *old_addr, *new_addr, *old_bypass_addr;
> +	int ret;
> +
> +	old_bypass_addr = old ? NULL : poke->bypass_addr;
> +	old_addr = old ? (u8 *)old->bpf_func + poke->adj_off : NULL;
> +	new_addr = new ? (u8 *)new->bpf_func + poke->adj_off : NULL;
> +
> +	/*
> +	 * On program loading or teardown, the program's kallsym entry
> +	 * might not be in place, so we use __bpf_arch_text_poke to skip
> +	 * the kallsyms check.
> +	 */
> +	if (new) {
> +		ret = __bpf_arch_text_poke(poke->tailcall_target,
> +					   BPF_MOD_JUMP,
> +					   old_addr, new_addr);
> +		BUG_ON(ret < 0);
> +		if (!old) {
> +			ret = __bpf_arch_text_poke(poke->tailcall_bypass,
> +						   BPF_MOD_JUMP,
> +						   poke->bypass_addr,
> +						   NULL);
> +			BUG_ON(ret < 0);
> +		}
> +	} else {
> +		ret = __bpf_arch_text_poke(poke->tailcall_bypass,
> +					   BPF_MOD_JUMP,
> +					   old_bypass_addr,
> +					   poke->bypass_addr);
> +		BUG_ON(ret < 0);
> +		/* let other CPUs finish the execution of program
> +		 * so that it will not possible to expose them
> +		 * to invalid nop, stack unwind, nop state
> +		 */
> +		if (!ret)
> +			synchronize_rcu();
> +		ret = __bpf_arch_text_poke(poke->tailcall_target,
> +					   BPF_MOD_JUMP,
> +					   old_addr, NULL);
> +		BUG_ON(ret < 0);
> +	}
> +}
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6762dac3ef76..cff5bb08820e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3175,6 +3175,9 @@ enum bpf_text_poke_type {
>  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
>  		       void *addr1, void *addr2);
>  
> +void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
> +			       struct bpf_prog *new, struct bpf_prog *old);
> +
>  void *bpf_arch_text_copy(void *dst, void *src, size_t len);
>  int bpf_arch_text_invalidate(void *dst, size_t len);
>  
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 2058e89b5ddd..c85ff9162a5c 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -1012,11 +1012,16 @@ static void prog_array_map_poke_untrack(struct bpf_map *map,
>  	mutex_unlock(&aux->poke_mutex);
>  }
>  
> +void __weak bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
> +				      struct bpf_prog *new, struct bpf_prog *old)
> +{
> +	WARN_ON_ONCE(1);
> +}
> +
>  static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
>  				    struct bpf_prog *old,
>  				    struct bpf_prog *new)
>  {
> -	u8 *old_addr, *new_addr, *old_bypass_addr;
>  	struct prog_poke_elem *elem;
>  	struct bpf_array_aux *aux;
>  
> @@ -1025,7 +1030,7 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
>  
>  	list_for_each_entry(elem, &aux->poke_progs, list) {
>  		struct bpf_jit_poke_descriptor *poke;
> -		int i, ret;
> +		int i;
>  
>  		for (i = 0; i < elem->aux->size_poke_tab; i++) {
>  			poke = &elem->aux->poke_tab[i];
> @@ -1044,21 +1049,10 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
>  			 *    activated, so tail call updates can arrive from here
>  			 *    while JIT is still finishing its final fixup for
>  			 *    non-activated poke entries.
> -			 * 3) On program teardown, the program's kallsym entry gets
> -			 *    removed out of RCU callback, but we can only untrack
> -			 *    from sleepable context, therefore bpf_arch_text_poke()
> -			 *    might not see that this is in BPF text section and
> -			 *    bails out with -EINVAL. As these are unreachable since
> -			 *    RCU grace period already passed, we simply skip them.
> -			 * 4) Also programs reaching refcount of zero while patching
> +			 * 3) Also programs reaching refcount of zero while patching
>  			 *    is in progress is okay since we're protected under
>  			 *    poke_mutex and untrack the programs before the JIT
> -			 *    buffer is freed. When we're still in the middle of
> -			 *    patching and suddenly kallsyms entry of the program
> -			 *    gets evicted, we just skip the rest which is fine due
> -			 *    to point 3).
> -			 * 5) Any other error happening below from bpf_arch_text_poke()
> -			 *    is a unexpected bug.
> +			 *    buffer is freed.
>  			 */
>  			if (!READ_ONCE(poke->tailcall_target_stable))
>  				continue;
> @@ -1068,39 +1062,7 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
>  			    poke->tail_call.key != key)
>  				continue;
>  
> -			old_bypass_addr = old ? NULL : poke->bypass_addr;
> -			old_addr = old ? (u8 *)old->bpf_func + poke->adj_off : NULL;
> -			new_addr = new ? (u8 *)new->bpf_func + poke->adj_off : NULL;
> -
> -			if (new) {
> -				ret = bpf_arch_text_poke(poke->tailcall_target,
> -							 BPF_MOD_JUMP,
> -							 old_addr, new_addr);
> -				BUG_ON(ret < 0 && ret != -EINVAL);
> -				if (!old) {
> -					ret = bpf_arch_text_poke(poke->tailcall_bypass,
> -								 BPF_MOD_JUMP,
> -								 poke->bypass_addr,
> -								 NULL);
> -					BUG_ON(ret < 0 && ret != -EINVAL);
> -				}
> -			} else {
> -				ret = bpf_arch_text_poke(poke->tailcall_bypass,
> -							 BPF_MOD_JUMP,
> -							 old_bypass_addr,
> -							 poke->bypass_addr);
> -				BUG_ON(ret < 0 && ret != -EINVAL);
> -				/* let other CPUs finish the execution of program
> -				 * so that it will not possible to expose them
> -				 * to invalid nop, stack unwind, nop state
> -				 */
> -				if (!ret)
> -					synchronize_rcu();
> -				ret = bpf_arch_text_poke(poke->tailcall_target,
> -							 BPF_MOD_JUMP,
> -							 old_addr, NULL);
> -				BUG_ON(ret < 0 && ret != -EINVAL);
> -			}
> +			bpf_arch_poke_desc_update(poke, new, old);
>  		}
>  	}
>  }
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

