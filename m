Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437DB19C698
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389697AbgDBP5H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 11:57:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39943 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389694AbgDBP5G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 11:57:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id c20so1942821pfi.7
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xsXwdZUL7oQ6jD+AW8Um4HqR8pj68u8qA3c+1uIY9t4=;
        b=Lh+8BH57mTykRPz4is9tEYm8p1c7vEUb5Nn5DT0ahBIMBf4rOuFFJJEO+W18JeW3l+
         l1amtZtNVXTFO7c/5MTazfaTF8RTQdrs3xK5IokwGRSVG7XzKD5xCkYwXxg55sTtPSVr
         QBxSErDW2aGeq/i4wpKc165k0d3mjH8V7+D0GJdVHN9V3qyv++4Erd/rcvsNcG4FrVzu
         atNSV+45lh5yLohXbbwWEBatU3nlBT/NzUzG/ZhXPOjvFS5OizgGrXqe914mT4/aJ8Np
         P8LZDjkA+HsyH5Uf2GcetSrYkmX95T9dD5WsdwM7o02qqECAEzua/1WPy4Kt/laoreTx
         VxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xsXwdZUL7oQ6jD+AW8Um4HqR8pj68u8qA3c+1uIY9t4=;
        b=jwsdNcGd0AmOP8r4yMkCfDl4vIA5Vl/f49H51edU4tdorb2qdJfHY8YB6NyLmM2ar6
         ovHaQI0BuMcKKdjBzu09EwwSHX+VtMbscozq3wVKE3Dv9g8WCNj50uaaqi+pZdr0gI7u
         Cl6otTAj2sCwo51QMQ2DvRh9wQNHrqbqgSeuX5yPMjQ9URGRCoga+kKPAU/ee5G7lk1c
         V4Vf4shGJJ+lt3QxmgOLGTLsQ2Xw+/Q+iNZQ6xEkMmAFwXeA06/q/Vvd0dEyQikiPC9q
         IUmkbLWRE8eCyB9E19gKyPcv1HvGhEsCZJDscD8a5fJJcT7skAX2LXyP1KAskSjmCoe2
         PeUw==
X-Gm-Message-State: AGi0PuayGg2JRVHDYichPC/G9heC3Yv/WRPiaA5d8KK7o648/wrTYcgv
        c8IF3wMv9CFDRq8zzV97lNs=
X-Google-Smtp-Source: APiQypLJHr84tB2YSZM46T+uX2DDErMDR1wktuwOpncI3XxwZ2/PeD+2rtx4slb+wBi5vn3Rg53/3w==
X-Received: by 2002:a63:1517:: with SMTP id v23mr3810237pgl.89.1585843024852;
        Thu, 02 Apr 2020 08:57:04 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:b3a4])
        by smtp.gmail.com with ESMTPSA id q185sm4012494pfb.154.2020.04.02.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:57:03 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:57:01 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Jann Horn <jannh@google.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v9 7/8] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
Message-ID: <20200402155701.6vi73wai2pmkxted@ast-mbp>
References: <20200329004356.27286-1-kpsingh@chromium.org>
 <20200329004356.27286-8-kpsingh@chromium.org>
 <CAADnVQKP3mOTUkkzjWM6Qii+v-dCDwV9Ms_-4ptsbdwyDW1MCA@mail.gmail.com>
 <20200402040357.GA217889@google.com>
 <20200402043037.ltgyptxsf7jaaudu@ast-mbp>
 <CAG48ez3SdOVbzJQgo-p=rhKhPdJxjUdraEE6WK5GP3GdenWAAQ@mail.gmail.com>
 <20200402115306.GA100892@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402115306.GA100892@google.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 02, 2020 at 01:53:06PM +0200, KP Singh wrote:
>  
> -int heap_mprotect(void)
> +#define PAGE_SIZE 4096
> +#define GET_PAGE_ADDR(ADDR)                                    \
> +       (char *)(((unsigned long) ADDR) & ~(PAGE_SIZE-1))
> +
> +int stack_mprotect(void)
>  {
> +
>         void *buf;
>         long sz;
>         int ret;
> @@ -25,12 +30,9 @@ int heap_mprotect(void)
>         if (sz < 0)
>                 return sz;
>  
> -       buf = memalign(sz, 2 * sz);
> -       if (buf == NULL)
> -               return -ENOMEM;
> -
> -       ret = mprotect(buf, sz, PROT_READ | PROT_WRITE | PROT_EXEC);
> -       free(buf);
> +       buf = alloca(PAGE_SIZE * 3);
> +       ret = mprotect(GET_PAGE_ADDR(buf + PAGE_SIZE), PAGE_SIZE,
> +                      PROT_READ | PROT_WRITE | PROT_EXEC);

Great. Something like this should work.
Please use sysconf(_SC_PAGE_SIZE); like prog_tests/mmap.c does.
selftests/bpf are run not only on x86
