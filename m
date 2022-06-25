Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E018755AAE5
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiFYOSn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jun 2022 10:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiFYOSm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jun 2022 10:18:42 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270B6D11A
        for <bpf@vger.kernel.org>; Sat, 25 Jun 2022 07:18:41 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 8so2475350vkg.10
        for <bpf@vger.kernel.org>; Sat, 25 Jun 2022 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYhSLaohKIEssxf/fNlbOqQk67cnyoEd3iS2K5d+Hmc=;
        b=auaHFR3raXiYXDOhV9N2vsSHiwKKL2v+60qnrKBAYiOHiwWhkbUr1xbjbVYHP1W2i2
         auoTzPOPs5BHYfkxtp3fRcuaEQ6reswO8lkzMfrtHF2uZWbPjpQLghqKEfifd1J9kVYB
         7cLqgqB+A6nvTlkxfQxaip5vv3B002R2EEkmfGmTg6j/88LF5LegSnH/4dcbXqsaKLBt
         u1c8xL7Tc7lVWdgOopCxm2c60FGUz4ZDkYLdW0Fb0dCzMeLpOl1tqUC5X1hrfNltpyty
         E1Nbf9RK1AQtF3Wa7+1D/wXwsk71eIL1kTNLwYUAKKK80LIPKIWzvVuK1c6JbT5hNT2K
         aZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYhSLaohKIEssxf/fNlbOqQk67cnyoEd3iS2K5d+Hmc=;
        b=6KSe7EA7BfsBqU9oWY8gM77X6JEjR/tKdKcxFyd7EAPjct9nJQMdnR6fVNCyknuQTg
         ByEdrCVMVmgT4jQbYfSFtYw/9m0CKRt/a2Qv8FrHfYemxAc6kBe7NccOpUl2e3qVe52k
         8tK30LXbbCv9uGjCRjPDz+GwwXFAjXQo+Rd3crXpLEj8Arbz5Nm4gacneJUAshT26Vjk
         ASNHh0Gspi4x/Jd6rnYwf5q1bEt51TUqfOfzMJZeaysQznNWNMmqaiFIK3SVNi5MhfQh
         A7cD/t8UWJA6drX/A5oo+dko6iuj1c7aGEb1ftEUQL2pppwQgu/K1h0F1GcVw1aIK8eI
         qotg==
X-Gm-Message-State: AJIora8hJ5YIdBeFcu3AfHiWkeNyDpuPROl8nYaPIiwpW7lmVmptA3hJ
        Bs8PaxiZAVKzNKeGHLj2zLuRouIODVpVYaX2R3w=
X-Google-Smtp-Source: AGRyM1vqa1yJcSonJArtV5Ue+/fmev6sr/82ERc5TmUzBxC1iqjt39GDfSbmzPfLqIA506Z4yVVAHuY8MDfkxhQKYbU=
X-Received: by 2002:a05:6122:c63:b0:36c:95ef:f6ce with SMTP id
 i35-20020a0561220c6300b0036c95eff6cemr1421691vkr.5.1656166720236; Sat, 25 Jun
 2022 07:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220619155032.32515-1-laoar.shao@gmail.com> <20220619155032.32515-8-laoar.shao@gmail.com>
 <YrP5S64OsUD6Hmgo@fedora>
In-Reply-To: <YrP5S64OsUD6Hmgo@fedora>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 25 Jun 2022 22:18:03 +0800
Message-ID: <CALOAHbAvC+2z4XftejPY21CsPOcQFGHOFSU3CzFyA6kYUSbDiA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 07/10] mm: Add helper to recharge percpu address
To:     Dennis Zhou <dennisszhou@gmail.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, songmuchun@bytedance.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 23, 2022 at 1:25 PM Dennis Zhou <dennisszhou@gmail.com> wrote:
>
> Hello,
>
> On Sun, Jun 19, 2022 at 03:50:29PM +0000, Yafang Shao wrote:
> > This patch introduces a helper to recharge the corresponding pages of
> > a given percpu address. It is similar with how to recharge a kmalloc'ed
> > address.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/percpu.h |  1 +
> >  mm/percpu.c            | 98 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 99 insertions(+)
> >
> > diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> > index f1ec5ad1351c..e88429410179 100644
> > --- a/include/linux/percpu.h
> > +++ b/include/linux/percpu.h
> > @@ -128,6 +128,7 @@ extern void __init setup_per_cpu_areas(void);
> >  extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
> >  extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
> >  extern void free_percpu(void __percpu *__pdata);
> > +bool recharge_percpu(void __percpu *__pdata, int step);
>
> Nit: can you add extern to keep the file consistent.
>

Sure, I will do it.

> >  extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
> >
> >  #define alloc_percpu_gfp(type, gfp)                                  \
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 3633eeefaa0d..fd81f4d79f2f 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -2310,6 +2310,104 @@ void free_percpu(void __percpu *ptr)
> >  }
> >  EXPORT_SYMBOL_GPL(free_percpu);
> >
> > +#ifdef CONFIG_MEMCG_KMEM
> > +bool recharge_percpu(void __percpu *ptr, int step)
> > +{
> > +     int bit_off, off, bits, size, end;
> > +     struct obj_cgroup *objcg_old;
> > +     struct obj_cgroup *objcg_new;
> > +     struct pcpu_chunk *chunk;
> > +     unsigned long flags;
> > +     void *addr;
> > +
> > +     WARN_ON(!in_task());
> > +
> > +     if (!ptr)
> > +             return true;
> > +
> > +     addr = __pcpu_ptr_to_addr(ptr);
> > +     spin_lock_irqsave(&pcpu_lock, flags);
> > +     chunk = pcpu_chunk_addr_search(addr);
> > +     off = addr - chunk->base_addr;
> > +     objcg_old = chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT];
> > +     if (!objcg_old && step != MEMCG_KMEM_POST_CHARGE) {
> > +             spin_unlock_irqrestore(&pcpu_lock, flags);
> > +             return true;
> > +     }
> > +
> > +     bit_off = off / PCPU_MIN_ALLOC_SIZE;
> > +     /* find end index */
> > +     end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk),
> > +                     bit_off + 1);
> > +     bits = end - bit_off;
> > +     size = bits * PCPU_MIN_ALLOC_SIZE;
> > +
> > +     switch (step) {
> > +     case MEMCG_KMEM_PRE_CHARGE:
> > +             objcg_new = get_obj_cgroup_from_current();
> > +             WARN_ON(!objcg_new);
> > +             if (obj_cgroup_charge(objcg_new, GFP_KERNEL,
> > +                                   size * num_possible_cpus())) {
> > +                     obj_cgroup_put(objcg_new);
> > +                     spin_unlock_irqrestore(&pcpu_lock, flags);
> > +                     return false;
> > +             }
> > +             break;
> > +     case MEMCG_KMEM_UNCHARGE:
> > +             obj_cgroup_uncharge(objcg_old, size * num_possible_cpus());
> > +             rcu_read_lock();
> > +             mod_memcg_state(obj_cgroup_memcg(objcg_old), MEMCG_PERCPU_B,
> > +                     -(size * num_possible_cpus()));
> > +             rcu_read_unlock();
> > +             chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = NULL;
> > +             obj_cgroup_put(objcg_old);
> > +             break;
> > +     case MEMCG_KMEM_POST_CHARGE:
> > +             rcu_read_lock();
> > +             chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = obj_cgroup_from_current();
> > +             mod_memcg_state(mem_cgroup_from_task(current), MEMCG_PERCPU_B,
> > +                     (size * num_possible_cpus()));
> > +             rcu_read_unlock();
> > +             break;
> > +     case MEMCG_KMEM_CHARGE_ERR:
> > +             /*
> > +              * In case fail to charge to the new one in the pre charge state,
> > +              * for example, we have pre-charged one memcg successfully but fail
> > +              * to pre-charge the second memcg, then we should uncharge the first
> > +              * memcg.
> > +              */
> > +             objcg_new = obj_cgroup_from_current();
> > +             obj_cgroup_uncharge(objcg_new, size * num_possible_cpus());
> > +             obj_cgroup_put(objcg_new);
> > +             rcu_read_lock();
> > +             mod_memcg_state(obj_cgroup_memcg(objcg_new), MEMCG_PERCPU_B,
> > +                     -(size * num_possible_cpus()));
> > +             rcu_read_unlock();
> > +
> > +             break;
> > +     }
>
> I'm not really the biggest fan of this step stuff. I see why you're
> doing it because you want to do all or nothing recharging the percpu bpf
> maps. Is there a way to have percpu own this logic and attempt to do all
> or nothing instead? I realize bpf is likely the largest percpu user, but
> the recharge_percpu() api seems to be more generic than forcing
> potential other users in the future to open code it.
>

Agree with you that the recharge api may be used by other users. It
should be a more generic helper.
Maybe we can make percpu own this logic by introducing a new value for
the parameter step, for example,
    recharge_percpu(ptr, -1); // -1 means the user doesn't need to
care about the multiple steps.

> > +
> > +     spin_unlock_irqrestore(&pcpu_lock, flags);
> > +
> > +     return true;
> > +}
> > +EXPORT_SYMBOL(recharge_percpu);
> > +
> > +#else /* CONFIG_MEMCG_KMEM */
> > +
> > +bool charge_percpu(void __percpu *ptr, bool charge)
> > +{
> > +     return true;
> > +}
> > +EXPORT_SYMBOL(charge_percpu);
> > +
> > +void uncharge_percpu(void __percpu *ptr)
> > +{
> > +}
>
> I'm guessing this is supposed to be recharge_percpu() not
> (un)charge_percpu().

Thanks for pointing out this bug.  The lkp robot also reported this bug to me.
I will change it.

-- 
Regards
Yafang
