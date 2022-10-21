Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1326E606D2A
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 03:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJUBsO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 21:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJUBsN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 21:48:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F7EE09B
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 18:48:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso4088451pjq.1
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 18:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hzevcuLXzTXCT7UXEELLCht+dXtxadN3s17XMthFybo=;
        b=A3gM98fRa3LlyVyadT6Mq5sFX8shNkFcZGX/LMLBikqiDLO9VGQ6PBQCaSjnQz0qKF
         Z01mKFrcVFnMUN0Pq85ymWcCamq1x5tMsjtFTvFFPDyKz6jOgjnwncvdZ3ZwN/QHdSWo
         wJRsHCQRbCr9n+u1lz2AQeqQcm14rCxXdL3+ztf9qRjBlizqbB3Zb7k2fnwjgQhKKd6V
         2W0zQP3llDmCvlEhnlpn/4EeS+0XOfZx82XOTJOOoQt5e03w8HJgSY39JDX0cq3RLAYo
         QA1wHAZSC8+4WZMtUIeb9vcRLXl4Glt8I2/Qo1qMC9LwTEASpdNNx9Jpwe3beNy9S7G7
         1csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzevcuLXzTXCT7UXEELLCht+dXtxadN3s17XMthFybo=;
        b=RYqiBfmgGnCuw15Ojs+fCd8bfcYB+Rd5wUZswvHOtjn4J7RzVymimPtJSM9oRNOJXw
         P88ySQ0kPxDqiDHwkU7gMC+T51zwjeOmfEKs0bMT+WfthjfN8QzFoK1YUvvUoHQqbGR9
         GVKLT+/8YTpmfNa3chRBPTrY8qwQQexAtso8LfB0xO8g5nq73PEv0cqvf1nUXukI7GJc
         2b109N5jZXEsUaAwMVSzG99Y7ZR8wCyqAMAUl2yi/vAfpTgrgJ2G7B2KQKjvAGmukTQb
         S8Ud8LoddIUAYITWmG3GhJ2GYl2XQI/AojMKZjcO8p21/psWkSWQ3Ck7kD+I968dC5aP
         0aJA==
X-Gm-Message-State: ACrzQf10ruEdWo/oSpjynoL9z/8kpD3P73uutMdf0img2KG7/guZ5ecu
        zgpNKwwzUKXaJ0V4B8c0/Wo=
X-Google-Smtp-Source: AMsMyM6M4m+6wrq3HpeSFneP5dVvheoabz7TxpmCwJ89XTEexnM8D3dYy5d9GfUw87unWhn0N2IK4w==
X-Received: by 2002:a17:902:f78c:b0:185:3d6a:7576 with SMTP id q12-20020a170902f78c00b001853d6a7576mr16604805pln.86.1666316891554;
        Thu, 20 Oct 2022 18:48:11 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:2848])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709026ac700b00172fad607b3sm13382230plt.207.2022.10.20.18.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 18:48:10 -0700 (PDT)
Date:   Thu, 20 Oct 2022 18:48:07 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf] bpf: Support for setting numa node in bpf memory
 allocator
Message-ID: <20221021014807.pvjppg433lucybui@macbook-pro-4.dhcp.thefacebook.com>
References: <20221020142247.1682009-1-houtao@huaweicloud.com>
 <CA+khW7jE_inL9-66Cb_WAPey6YkY+yf1H+q2uASTQujNXbRF=Q@mail.gmail.com>
 <212fbd46-7371-c3f9-e900-3a49d9fafab8@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <212fbd46-7371-c3f9-e900-3a49d9fafab8@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 09:43:08AM +0800, Hou Tao wrote:
> Hi,
> 
> On 10/21/2022 2:01 AM, Hao Luo wrote:
> > On Thu, Oct 20, 2022 at 6:57 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Since commit fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc."),
> >> numa node setting for non-preallocated hash table is ignored. The reason
> >> is that bpf memory allocator only supports NUMA_NO_NODE, but it seems it
> >> is trivial to support numa node setting for bpf memory allocator.
> >>
> >> So adding support for setting numa node in bpf memory allocator and
> >> updating hash map accordingly.
> >>
> >> Fixes: fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc.")
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> > Looks good to me with a few nits.
> >
> > <...>
> >> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >> index fc116cf47d24..44c531ba9534 100644
> >> --- a/kernel/bpf/memalloc.c
> >> +++ b/kernel/bpf/memalloc.c
> > <...>
> >> +static inline bool is_valid_numa_node(int numa_node, bool percpu)
> >> +{
> >> +       return numa_node == NUMA_NO_NODE ||
> >> +              (!percpu && (unsigned int)numa_node < nr_node_ids);
> > Maybe also check node_online? There is a similar helper function in
> > kernel/bpf/syscall.c.
> Will factor out as a helper function and use it in bpf memory allocator in v2.
> >
> > It may help debugging if we could log the reason here, for example,
> > PERCPU map but with numa_node specified.
> Not sure about it, because the validity check must have been done in map related
> code.
> 
> >
> >> +}
> >> +
> >> +/* The initial prefill is running in the context of map creation process, so
> >> + * if the preferred numa node is NUMA_NO_NODE, needs to use numa node of the
> >> + * specific cpu instead.
> >> + */
> >> +static inline int get_prefill_numa_node(int numa_node, int cpu)
> >> +{
> >> +       int prefill_numa_node;
> >> +
> >> +       if (numa_node == NUMA_NO_NODE)
> >> +               prefill_numa_node = cpu_to_node(cpu);
> >> +       else
> >> +               prefill_numa_node = numa_node;
> >> +       return prefill_numa_node;
> >>  }
> > nit: an alternative implementation is
> >
> >  return numa_node == NUMA_NO_NODE ? cpu_to_node(cpu) : numa_node;
> It is shorter and better. Will do it in v2.
> >
> >>  /* When size != 0 bpf_mem_cache for each cpu.
> >> @@ -359,13 +383,17 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
> >>   * kmalloc/kfree. Max allocation size is 4096 in this case.
> >>   * This is bpf_dynptr and bpf_kptr use case.
> >>   */
> > We added a parameter to this function, I think it is worth mentioning
> > the 'numa_node' argument's behavior under different values of
> > 'percpu'.
> How about the following comments ?
> 
>  * For per-cpu allocator (percpu=true), the only valid value of numa_node is
>  * NUMA_NO_NODE. For non-per-cpu allocator, if numa_node is NUMA_NO_NODE, the
>  * preferred memory allocation node is the numa node where the allocating CPU
>  * is located, else the preferred node is the specified numa_node.

No. This patch doesn't make sense to me.
As far as I can see it can only make things worse.
Why would you want a cpu to use non local memory?

The commit log:
" is that bpf memory allocator only supports NUMA_NO_NODE, but it seems it
  is trivial to support numa node setting for bpf memory allocator."
got it wrong.

See the existing comment:
                /* irq_work runs on this cpu and kmalloc will allocate
                 * from the current numa node which is what we want here.
                 */
                alloc_bulk(c, c->batch, NUMA_NO_NODE);

