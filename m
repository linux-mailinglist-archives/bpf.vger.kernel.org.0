Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCA4403F3C
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 20:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350255AbhIHSuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 14:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350227AbhIHSuW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 14:50:22 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DEBC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 11:49:14 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 22so3686734qkg.2
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KSBZRtg9Bcpkgg4PoziWLThJ+DJeO3iDuOxiwW9BokU=;
        b=juImOLa/36D5Lg6LBSkkMpB56jN+7+q09mME8uHPvBi0r4VnIrP4bH2DKCl+ckzNRt
         S/cBG68Zl8omNbnVJ1Pbk8+aCaG9Oe8dkfRbt6LKPgLJUvnmzwMRlnAuwD/5fUTy24NO
         YmAOgrZ1ypzY5lMAsWna827aXmHNx6CMbVZu3XBYRDXR4/HdjUe0InHotTyL+QaLScuS
         XmtR8KwGOCYLEqA95+j8fo46ahWuaZDtyqfNWiVFa/dpmLjTz5u6M2ZQa+NVV9aFedpb
         lBj5g5A5C7Gm6i+1brCdY0GDrq58HozLkbXtJ/uF0CXbghSUoolPYtwUMgzZJZMKGNV2
         HCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KSBZRtg9Bcpkgg4PoziWLThJ+DJeO3iDuOxiwW9BokU=;
        b=rrrpc+PkSKBpNXjqWpqpJFmfqYKSJ8X86UWpzjXP6IRoXqqLh1QDSavYnyMFOI8IAB
         NZkA7t3jXs98LvGAufz7Z+g9G/UHrUWnOg4CWZ2PsPpvO5j2gY/obeOqdTQXzFNaYysa
         K716xS/jiTiXddWS/5h+eLq1Bzy5jzCwkaacRas8wvLa33AEQ9N1LiIHR4ydlD2IXwgC
         s9u1QyEg/nZIKr09GUTchY4GLMxy5qaXN5QzPtjB13hhW4Ioxmc8ojsrJbHnHaMlPyZP
         phSCwK0CH/HTpXuwOT4pQlO4rZG4f+sm6GV7DUNocVPAPmW9YOVecNUApuQskWYsoOds
         E6zw==
X-Gm-Message-State: AOAM530tT1qn0m0Jf44ujuuwkKDULNCGdjshTGnn+VTbjVc7kpl7Ptdn
        WCSmwxqjkBD9v5Pl7uwDcPs1ZtHDGDGv+g==
X-Google-Smtp-Source: ABdhPJzRt0fH/Tshaz22KvgbXOEAr/QFzEhHaOUETc6M8zX/lckBm4xgH/+v2qtpTM42WGQ8MQG0nA==
X-Received: by 2002:a05:620a:1009:: with SMTP id z9mr4940627qkj.483.1631126953175;
        Wed, 08 Sep 2021 11:49:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w6sm2298945qkw.91.2021.09.08.11.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 11:49:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mO2dE-00EnH5-0Y; Wed, 08 Sep 2021 15:49:12 -0300
Date:   Wed, 8 Sep 2021 15:49:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Rizzo <lrizzo@google.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "walken@fb.com" <walken@fb.com>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Message-ID: <20210908184912.GA1200268@ziepe.ca>
References: <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver>
 <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
 <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
 <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
 <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
 <20210908111527.9a611426e257d55ccbbf46eb@linux-foundation.org>
 <CAADnVQ+5m0+X1Xvgu-wYii2nWvAtEfk2ffM6mQTaiq2SPM1Z=A@mail.gmail.com>
 <20210908183032.zoh6dj5xh455z47f@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908183032.zoh6dj5xh455z47f@revolver>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 06:30:52PM +0000, Liam Howlett wrote:

>  /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> -struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> +struct vm_area_struct *find_vma_non_owner(struct mm_struct *mm,
> +					 unsigned long addr)
>  {
>  	struct rb_node *rb_node;
>  	struct vm_area_struct *vma;
>  
> -	mmap_assert_locked(mm);
> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>  	/* Check the cache first. */
>  	vma = vmacache_find(mm, addr);
>  	if (likely(vma))
> @@ -2325,6 +2326,11 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  	return vma;
>  }
>  
> +struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> +{
> +	lockdep_assert_held(&mm->mmap_lock);
> +	return find_vma_non_owner(mm, addr);
> +}
>  EXPORT_SYMBOL(find_vma);
>  
>  /*
> 
> 
> Although this leaks more into the mm API and was referred to as ugly
> previously, it does provide a working solution and still maintains the
> same level of checking.

I think it is no better than before.

The solution must be to not break lockdep in the BPF side. If Peter's
reworked algorithm is not OK then BPF should drop/acquire the lockdep
when it punts the unlock to the WQ.

'non-owner' is just a nice way of saying 'the caller is messing with
lockdep', it is not a sane way to design APIs

Jason
