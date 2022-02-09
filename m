Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987B54AE637
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 01:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiBIApC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 19:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiBIApA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 19:45:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32E1C061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 16:44:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v4so711454pjh.2
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 16:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VAeEte2xzCQsoQiFoHeHH1i7niGH30ckZsTXC9qY5vc=;
        b=SUFlHkwuON9PhsyAzkLl5JkafBr8ZJmHbx0KqN3Y1f6QIRuFX6poDHuspTlX0ctwUc
         9eThKGwW19LoUteY7lhy6EQj0lzU13FH6fjEgjy8FCl8POPqaetq7gaHyAVG3FT6EMS7
         7s8ArcWEdixordKl+N3KLGwf+AY/GLJyE5qXv2XgrbyFCXmkX4ryV20G/5yOlRQGMOXZ
         c6+mFceTTPKgfgh1eodNT13Kri5v9l7qxZ8uA4yp1vPhuBoP/Yu+vx8wsd0y1NPimKQv
         gnG6oG50TrGxkNRiw7H4vwv5YsWxhTj9t+wMbRGEQufp5rJrpkb7vuF/k1dILpzZRJUg
         o0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VAeEte2xzCQsoQiFoHeHH1i7niGH30ckZsTXC9qY5vc=;
        b=gNpBqhLzSj2M99ezIstWIcJd4kuU4/6WTMlRa74n7i3IJMWsDvhKZJJYnh1GM3i/Gg
         TyOJ65IJK6q1+GVl7P0ruyB9MzQDiMmU4+Pypdfrcr73/W8Wl0I1npjMYYMefzTw/tPW
         UsYNd67wOSEpjt0uaB9iOvvR6Qg5EdEHRBaZnoor8aC81lSPmFLqn02vpaTDdqGvdVNe
         NqNFyB4hOxBgmTzliPwJyzW75M3RS619C5OvkFpu5W0bwrFaon6CuuSzlXhaa1+7sYNh
         CSeLplJGwt/Mke1im1EI/rp9O7wcOFwx2JIOXwX8WTlfGDQFyxnzb2/OaTny7NGCP5pk
         MrTQ==
X-Gm-Message-State: AOAM530fjgVrInJ/oPKHhhfy6CFAIMTraXnTRGPskttm4EAlVKRJMHbH
        iWgXPAzq12ilGNrQP8ACloM=
X-Google-Smtp-Source: ABdhPJyD0chp96d6kfUPZJCGXPpyMNBhYhkTrcn7G4zcEqO/N0MH74EeGhPNMV9RE5CQA6nhmB/BXA==
X-Received: by 2002:a17:90b:1e05:: with SMTP id pg5mr616228pjb.127.1644367498936;
        Tue, 08 Feb 2022 16:44:58 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:cbf])
        by smtp.gmail.com with ESMTPSA id ls13sm3941076pjb.54.2022.02.08.16.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:44:58 -0800 (PST)
Date:   Tue, 8 Feb 2022 16:44:56 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 2/5] libbpf: Prepare light skeleton for the
 kernel.
Message-ID: <20220209004456.axst5cynliegcnjl@ast-mbp.dhcp.thefacebook.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
 <20220208191306.6136-3-alexei.starovoitov@gmail.com>
 <e90685a5-dad0-4a4b-aa8b-275eaef79e60@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e90685a5-dad0-4a4b-aa8b-275eaef79e60@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 08, 2022 at 04:13:01PM -0800, Yonghong Song wrote:
> 
> 
> On 2/8/22 11:13 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
> > Prepare light skeleton to be used in the kernel module and in the user space.
> > The look and feel of lskel.h is mostly the same with the difference that for
> > user space the skel->rodata is the same pointer before and after skel_load
> > operation, while in the kernel the skel->rodata after skel_open and the
> > skel->rodata after skel_load are different pointers.
> > Typical usage of skeleton remains the same for kernel and user space:
> > skel = my_bpf__open();
> > skel->rodata->my_global_var = init_val;
> > err = my_bpf__load(skel);
> > err = my_bpf__attach(skel);
> > // access skel->rodata->my_global_var;
> > // access skel->bss->another_var;
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >   tools/lib/bpf/skel_internal.h | 193 +++++++++++++++++++++++++++++++---
> >   1 file changed, 176 insertions(+), 17 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> > index dcd3336512d4..d16544666341 100644
> > --- a/tools/lib/bpf/skel_internal.h
> > +++ b/tools/lib/bpf/skel_internal.h
> > @@ -3,9 +3,19 @@
> >   #ifndef __SKEL_INTERNAL_H
> >   #define __SKEL_INTERNAL_H
> > +#ifdef __KERNEL__
> > +#include <linux/fdtable.h>
> > +#include <linux/mm.h>
> > +#include <linux/mman.h>
> > +#include <linux/slab.h>
> > +#include <linux/bpf.h>
> > +#else
> >   #include <unistd.h>
> >   #include <sys/syscall.h>
> >   #include <sys/mman.h>
> > +#include <stdlib.h>
> > +#include "bpf.h"
> > +#endif
> >   #ifndef __NR_bpf
> >   # if defined(__mips__) && defined(_ABIO32)
> > @@ -25,17 +35,11 @@
> >    * requested during loader program generation.
> >    */
> >   struct bpf_map_desc {
> > -	union {
> > -		/* input for the loader prog */
> > -		struct {
> > -			__aligned_u64 initial_value;
> > -			__u32 max_entries;
> > -		};
> > -		/* output of the loader prog */
> > -		struct {
> > -			int map_fd;
> > -		};
> > -	};
> > +	/* output of the loader prog */
> > +	int map_fd;
> > +	/* input for the loader prog */
> > +	__u32 max_entries;
> > +	__aligned_u64 initial_value;
> >   };
> >   struct bpf_prog_desc {
> >   	int prog_fd;
> > @@ -57,12 +61,159 @@ struct bpf_load_and_run_opts {
> >   	const char *errstr;
> >   };
> > +long bpf_sys_bpf(__u32 cmd, void *attr, __u32 attr_size);
> > +
> >   static inline int skel_sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
> >   			  unsigned int size)
> >   {
> > +#ifdef __KERNEL__
> > +	return bpf_sys_bpf(cmd, attr, size);
> > +#else
> >   	return syscall(__NR_bpf, cmd, attr, size);
> > +#endif
> > +}
> > +
> > +#ifdef __KERNEL__
> > +static inline int close(int fd)
> > +{
> > +	return close_fd(fd);
> > +}
> > +
> > +static inline void *skel_alloc(size_t size)
> > +{
> > +	return kcalloc(1, size, GFP_KERNEL);
> > +}
> > +
> > +static inline void skel_free(const void *p)
> > +{
> > +	kfree(p);
> > +}
> > +
> > +/* skel->bss/rodata maps are populated in three steps.
> > + *
> > + * For kernel use:
> > + * skel_prep_map_data() allocates kernel memory that kernel module can directly access.
> > + * skel_prep_init_value() allocates a region in user space process and copies
> > + * potentially modified initial map value into it.
> > + * The loader program will perform copy_from_user() from maps.rodata.initial_value.
> > + * skel_finalize_map_data() sets skel->rodata to point to actual value in a bpf map and
> > + * does maps.rodata.initial_value = ~0ULL to signal skel_free_map_data() that kvfree
> > + * is not nessary.
> > + *
> > + * For user space:
> > + * skel_prep_map_data() mmaps anon memory into skel->rodata that can be accessed directly.
> > + * skel_prep_init_value() copies rodata pointer into map.rodata.initial_value.
> > + * The loader program will perform copy_from_user() from maps.rodata.initial_value.
> > + * skel_finalize_map_data() remaps bpf array map value from the kernel memory into
> > + * skel->rodata address.
> > + *
> > + * The "bpftool gen skeleton -L" command generates lskel.h that is suitable for
> > + * both kernel and user space. The generated loader program does
> > + * copy_from_user() from intial_value. Therefore the vm_mmap+copy_to_user step
> > + * is need when lskel is used from the kernel module.
> > + */
> > +static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
> > +{
> > +	if (addr && addr != ~0ULL)
> > +		vm_munmap(addr, sz);
> > +	if (addr != ~0ULL)
> > +		kvfree(p);
> > +	/* When addr == ~0ULL the 'p' points to
> > +	 * ((struct bpf_array *)map)->value. See skel_finalize_map_data.
> > +	 */
> > +}
> > +
> > +static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
> > +{
> > +	void *addr;
> > +
> > +	addr = kvmalloc(val_sz, GFP_KERNEL);
> > +	if (!addr)
> > +		return NULL;
> > +	memcpy(addr, val, val_sz);
> > +	return addr;
> > +}
> > +
> > +static inline __u64 skel_prep_init_value(void **addr, size_t mmap_sz, size_t val_sz)
> > +{
> > +	__u64 ret = 0;
> > +	void *uaddr;
> > +
> > +	uaddr = (void *) vm_mmap(NULL, 0, mmap_sz, PROT_READ | PROT_WRITE,
> > +				 MAP_SHARED | MAP_ANONYMOUS, 0);
> > +	if (IS_ERR(uaddr))
> > +		goto out;
> > +	if (copy_to_user(uaddr, *addr, val_sz)) {
> > +		vm_munmap((long) uaddr, mmap_sz);
> > +		goto out;
> > +	}
> > +	ret = (__u64) (long) uaddr;
> > +out:
> > +	kvfree(*addr);
> > +	*addr = NULL;
> > +	return ret;
> >   }
> > +static inline void *skel_finalize_map_data(__u64 *addr, size_t mmap_sz, int flags, int fd)
> > +{
> > +	struct bpf_map *map;
> > +	void *ptr = NULL;
> > +
> > +	vm_munmap(*addr, mmap_sz);
> > +	*addr = ~0ULL;
> > +
> > +	map = bpf_map_get(fd);
> > +	if (IS_ERR(map))
> > +		return NULL;
> > +	if (map->map_type != BPF_MAP_TYPE_ARRAY)
> > +		goto out;
> 
> Should we do more map validation here, e.g., max_entries = 1
> and also checking value_size?

The map_type check is a sanity check.
It should be valid by construction of loader prog.
The map is also mmap-able and when signed progs will come to life it will be
frozen and signature checked.
rodata map should be readonly too, but ((struct bpf_array *)map)->value
direct access assumes that the kernel module won't mess with the values.
imo map_type check is enough. More checks feels like overkill.
