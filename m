Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E5A55728E
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 07:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiFWFZM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 01:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFWFZK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 01:25:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68039177
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 22:25:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m14so17208998plg.5
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 22:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BkA3goyCUVCAoZrWCBXBcphDU/vQ/nDzMYEvUN39kDs=;
        b=CxGelxIsH+OWmJwJRJmFJH721XC8kg8fgx8D/848lP1zmr+4NOCpXgJrviyg2rzbNT
         oWcb6JG1BvWTPt5xC9Z9ZWzrPAZDSmjG0QR2F5QoLzjkbCg30GWnMC3m4T28e6KLcZc2
         pVOtGNxBdP0N2n3+PQUWpYEjOt5IyyAH6ZKEab6yL0Jf4cWOQMxyDeiXQ4WghLxsjuhV
         Hxz6XHPHJhAtK8E1dkZ3N8sc7L8XNLogUFQaawb9hwE91iRPXOAM1/uyz3OGfxAojUF4
         RNt71L/6hLIR8FwYs801zYlvjqoi9aqI6/BoSh0PUgt5fqpabHp8BU4PxSsknbbhyKSn
         0O5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BkA3goyCUVCAoZrWCBXBcphDU/vQ/nDzMYEvUN39kDs=;
        b=lkTKRxZmMLHzool2JOcmaMiEsVTG7KutiGJGwxlZv7pv4tc3jzXdlZqEGpTZDPJdok
         yLByQp9r2pbherjNUx4PAv1F0bt1nIdQ78YjkuJYF9fU0Y/siyR7iqm4ANBoSoRVh0ky
         9TmGGvNvf0Q5xsqsaF8z8ltq1JzG6NZ0xBqy6EMkYACVZPfm3oiNIo80mUldnplkkgNk
         JGxVsNyLtVWrz0Th91XPMF6sdoyY9RfwZPd9Pcfls67/KqQCH1pSvtC2ZFdLts7oLtKr
         PIh9/uoUu/z3bjVF5XscpxWZcsL2AhgnQyz5dkwLze5klKgPz+HU1KiYWtVv2WZHW5rs
         gVHw==
X-Gm-Message-State: AJIora8k0QtqGQSIoLSRliBZWQF9a8tumIvO0rXApI5uCcPq3Oe6/1BC
        ROCO6yErdvmMqwHDUzY8TTo=
X-Google-Smtp-Source: AGRyM1tKv7/KhHLB6cxCXOyCj7zNBU33siZHD0cvgCEoAz2jFvmnH5BH3WZliSs/CTpvDrtu9o7LNw==
X-Received: by 2002:a17:902:d50b:b0:16a:2cb3:750d with SMTP id b11-20020a170902d50b00b0016a2cb3750dmr16163171plg.17.1655961909011;
        Wed, 22 Jun 2022 22:25:09 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id p5-20020a17090b010500b001ec7ba41fe7sm772999pjz.48.2022.06.22.22.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 22:25:08 -0700 (PDT)
Date:   Wed, 22 Jun 2022 22:25:31 -0700
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 07/10] mm: Add helper to recharge percpu
 address
Message-ID: <YrP5S64OsUD6Hmgo@fedora>
References: <20220619155032.32515-1-laoar.shao@gmail.com>
 <20220619155032.32515-8-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619155032.32515-8-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Sun, Jun 19, 2022 at 03:50:29PM +0000, Yafang Shao wrote:
> This patch introduces a helper to recharge the corresponding pages of
> a given percpu address. It is similar with how to recharge a kmalloc'ed
> address.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/percpu.h |  1 +
>  mm/percpu.c            | 98 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index f1ec5ad1351c..e88429410179 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -128,6 +128,7 @@ extern void __init setup_per_cpu_areas(void);
>  extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
>  extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
>  extern void free_percpu(void __percpu *__pdata);
> +bool recharge_percpu(void __percpu *__pdata, int step);

Nit: can you add extern to keep the file consistent.

>  extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
>  
>  #define alloc_percpu_gfp(type, gfp)					\
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 3633eeefaa0d..fd81f4d79f2f 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2310,6 +2310,104 @@ void free_percpu(void __percpu *ptr)
>  }
>  EXPORT_SYMBOL_GPL(free_percpu);
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +bool recharge_percpu(void __percpu *ptr, int step)
> +{
> +	int bit_off, off, bits, size, end;
> +	struct obj_cgroup *objcg_old;
> +	struct obj_cgroup *objcg_new;
> +	struct pcpu_chunk *chunk;
> +	unsigned long flags;
> +	void *addr;
> +
> +	WARN_ON(!in_task());
> +
> +	if (!ptr)
> +		return true;
> +
> +	addr = __pcpu_ptr_to_addr(ptr);
> +	spin_lock_irqsave(&pcpu_lock, flags);
> +	chunk = pcpu_chunk_addr_search(addr);
> +	off = addr - chunk->base_addr;
> +	objcg_old = chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT];
> +	if (!objcg_old && step != MEMCG_KMEM_POST_CHARGE) {
> +		spin_unlock_irqrestore(&pcpu_lock, flags);
> +		return true;
> +	}
> +
> +	bit_off = off / PCPU_MIN_ALLOC_SIZE;
> +	/* find end index */
> +	end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk),
> +			bit_off + 1);
> +	bits = end - bit_off;
> +	size = bits * PCPU_MIN_ALLOC_SIZE;
> +
> +	switch (step) {
> +	case MEMCG_KMEM_PRE_CHARGE:
> +		objcg_new = get_obj_cgroup_from_current();
> +		WARN_ON(!objcg_new);
> +		if (obj_cgroup_charge(objcg_new, GFP_KERNEL,
> +				      size * num_possible_cpus())) {
> +			obj_cgroup_put(objcg_new);
> +			spin_unlock_irqrestore(&pcpu_lock, flags);
> +			return false;
> +		}
> +		break;
> +	case MEMCG_KMEM_UNCHARGE:
> +		obj_cgroup_uncharge(objcg_old, size * num_possible_cpus());
> +		rcu_read_lock();
> +		mod_memcg_state(obj_cgroup_memcg(objcg_old), MEMCG_PERCPU_B,
> +			-(size * num_possible_cpus()));
> +		rcu_read_unlock();
> +		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = NULL;
> +		obj_cgroup_put(objcg_old);
> +		break;
> +	case MEMCG_KMEM_POST_CHARGE:
> +		rcu_read_lock();
> +		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = obj_cgroup_from_current();
> +		mod_memcg_state(mem_cgroup_from_task(current), MEMCG_PERCPU_B,
> +			(size * num_possible_cpus()));
> +		rcu_read_unlock();
> +		break;
> +	case MEMCG_KMEM_CHARGE_ERR:
> +		/*
> +		 * In case fail to charge to the new one in the pre charge state,
> +		 * for example, we have pre-charged one memcg successfully but fail
> +		 * to pre-charge the second memcg, then we should uncharge the first
> +		 * memcg.
> +		 */
> +		objcg_new = obj_cgroup_from_current();
> +		obj_cgroup_uncharge(objcg_new, size * num_possible_cpus());
> +		obj_cgroup_put(objcg_new);
> +		rcu_read_lock();
> +		mod_memcg_state(obj_cgroup_memcg(objcg_new), MEMCG_PERCPU_B,
> +			-(size * num_possible_cpus()));
> +		rcu_read_unlock();
> +
> +		break;
> +	}

I'm not really the biggest fan of this step stuff. I see why you're
doing it because you want to do all or nothing recharging the percpu bpf
maps. Is there a way to have percpu own this logic and attempt to do all
or nothing instead? I realize bpf is likely the largest percpu user, but
the recharge_percpu() api seems to be more generic than forcing
potential other users in the future to open code it.

> +
> +	spin_unlock_irqrestore(&pcpu_lock, flags);
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(recharge_percpu);
> +
> +#else /* CONFIG_MEMCG_KMEM */
> +
> +bool charge_percpu(void __percpu *ptr, bool charge)
> +{
> +	return true;
> +}
> +EXPORT_SYMBOL(charge_percpu);
> +
> +void uncharge_percpu(void __percpu *ptr)
> +{
> +}

I'm guessing this is supposed to be recharge_percpu() not
(un)charge_percpu().

> +EXPORT_SYMBOL(uncharge_percpu);
> +
> +#endif /* CONFIG_MEMCG_KMEM */
> +
>  bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr)
>  {
>  #ifdef CONFIG_SMP
> -- 
> 2.17.1
> 
> 

Thanks,
Dennis
