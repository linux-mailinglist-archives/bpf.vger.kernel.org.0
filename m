Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CC867A9A7
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 05:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjAYEgI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 23:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjAYEgH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 23:36:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2EB4F379;
        Tue, 24 Jan 2023 20:36:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y3-20020a17090a390300b00229add7bb36so813997pjb.4;
        Tue, 24 Jan 2023 20:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ht1VyGPklGWNBu4BAGZKzUy3fL5Jww4xRrV0KjNk22I=;
        b=VA0ZLsOiosXzjPO78eb9Uxd11KxyAcu8YAZGrBvnLFMePUZ8GASGYZJmI5/ejNC9bc
         1pKTckEoEaXgB484AvX5AtRxZ9RdeRSCjbth6cdbYBxQ8IVp3zmpuLeVgwZuxd+77h/i
         DxVttIvxXOxYRTyqaDHSkTxAfE5iNRcS6KSVaKSueEqI9C0pbIMuRVO3DUABAEXP0JyQ
         pRERy6ExatlKE3GdW2WfgTzom5wkXW2yrvdkzC4nFWQ4rhqeJGISMBZYjXea09XF7x1k
         DjIn9um3WaSJyxEtIwHJuC+/Jvaw/QM2kaMnXNBxQrLQUTcyXD5XbFpfN2WW5XjdUEp0
         hA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht1VyGPklGWNBu4BAGZKzUy3fL5Jww4xRrV0KjNk22I=;
        b=CxvAs9QPUf+mJd9LWRqgawgD8pqc8GZ9dL/thz1h3JXQ3nhbY2P9wSGC9jx3SR8DPu
         +DDciAXgaGw05Edb8JxhlybXunMDkrOGjiotDs0F9ceQKkYRAxOla7/GWjLCWaG9TO6d
         Dz/VTpzDWmffBllBSkXCjrF7aBbjHgx0IEU4Tsf+GOc4JmVZ+VLeKxf27BXumD+XNHkT
         pdGAYPa05LO+JDzcqSOX5SpbVl5yrKny6FPHTdETDhfxmv7QCmVCmgYlJOwn+vOpw30y
         xlW3uufegyx3RtFBPmZFulNEEGuGwe1YvU38FoxBb3sCaXrF+wzjdhTuZ+XGiIKC5bdL
         WUVg==
X-Gm-Message-State: AFqh2krglpuMKHdCc0De8lDbM7xiJf27hiSLxG/CZCWeAkSDA2f4VtD6
        YiuaR+55RLJ77gUTFbGjoQw=
X-Google-Smtp-Source: AMrXdXvOMENA8F0izTjp2Vw3g+eH32BnypNG61VAq+AzzTbjv6ROCElH6Q7phTpJVllnz17uhLBV5Q==
X-Received: by 2002:a05:6a20:3d11:b0:b9:6932:7d71 with SMTP id y17-20020a056a203d1100b000b969327d71mr25535939pzi.26.1674621365656;
        Tue, 24 Jan 2023 20:36:05 -0800 (PST)
Received: from iphone-mikan.dhcp.thefacebook.com ([2620:10d:c090:500::4:2d96])
        by smtp.gmail.com with ESMTPSA id j10-20020a63b60a000000b0048f8efc53a6sm2245183pgf.80.2023.01.24.20.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:36:05 -0800 (PST)
Date:   Tue, 24 Jan 2023 20:36:02 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
        memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Enable cpumasks to be queried and
 used as kptrs
Message-ID: <20230125043602.gmpi54ixerelmzzx@iphone-mikan.dhcp.thefacebook.com>
References: <20230120192523.3650503-1-void@manifault.com>
 <20230120192523.3650503-5-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120192523.3650503-5-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 01:25:18PM -0600, David Vernet wrote:
> +
> +/**
> + * struct bpf_cpumask - refcounted BPF cpumask wrapper structure
> + * @cpumask:	The actual cpumask embedded in the struct.
> + * @usage:	Object reference counter. When the refcount goes to 0, the
> + *		memory is released back to the BPF allocator, which provides
> + *		RCU safety.
> + *
> + * Note that we explicitly embed a cpumask_t rather than a cpumask_var_t.  This
> + * is done to avoid confusing the verifier due to the typedef of cpumask_var_t
> + * changing depending on whether CONFIG_CPUMASK_OFFSTACK is defined or not. See
> + * the details in <linux/cpumask.h>. The consequence is that this structure is
> + * likely a bit larger than it needs to be when CONFIG_CPUMASK_OFFSTACK is
> + * defined due to embedding the whole NR_CPUS-size bitmap, but the extra memory
> + * overhead is minimal. For the more typical case of CONFIG_CPUMASK_OFFSTACK
> + * not being defined, the structure is the same size regardless.
> + */
> +struct bpf_cpumask {
> +	cpumask_t cpumask;
> +	refcount_t usage;
> +};
> +
> +static struct bpf_mem_alloc bpf_cpumask_ma;
> +
> +static bool cpu_valid(u32 cpu)
> +{
> +	return cpu < nr_cpu_ids;
> +}
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global kfuncs as their definitions will be in BTF");
> +
> +struct bpf_cpumask *bpf_cpumask_create(void)
> +{
> +	struct bpf_cpumask *cpumask;
> +
> +	cpumask = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*cpumask));
> +	if (!cpumask)
> +		return NULL;
> +
> +	memset(cpumask, 0, sizeof(*cpumask));
> +	refcount_set(&cpumask->usage, 1);
> +
> +	return cpumask;
> +}

Applied patches 1 and 2. Patch 3 doesn't apply anymore. Pls rebase.

I'm fine with existing bpf_cpumask proposal, but can we do better?
This is so close to be a bitmap template.

Can we generalize it as
struct bpf_bitmap {
	refcount_t refcnt;
        int num_bits;
        u64 bits[];
};

struct bpf_bitmap *bpf_bitmap_create(int bits)
{
  bitmap = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*bitmap) + BITS_TO_LONGS(bits) * sizeof(u64));
  bitmap->num_bits = bits;
}

and special case few custom kfuncs in the verifier that allow
type cast from bpf_bitmap with to 'struct cpumask *' ? Like
struct cpumask *bpf_bitmap_cast_to_cpumask(struct bpf_bitmap *bitmap)
{
  if (bitmap->num_bits == nr_cpu_ids)
     return bitmap->bits;
  return NULL;
}
BTF_ID_FLAGS(func, bpf_bitmap_cast_to_cpumask, KF_TRUSTED_ARGS | KF_RET_NULL)

The UX will be a bit worse, since bpf prog would need to do !=NULL check
but with future bpf_assert() we may get rid of !=NULL check.

We can keep direct cpumask accessors as kfuncs:

u32 bpf_cpumask_first(const struct cpumask *cpumask);
u32 bpf_cpumask_first_zero(const struct cpumask *cpumask);

and add bpf_find_first_bit() and the rest of bit manipulations.

Since all of the bpf_cpumask do run-time cpu_valid() check we're not
sacrificing performance.

Feels more generic with wider applicability at the expense of little bit worse UX.
I haven't thought about acq/rel consequences.

wdyt?
