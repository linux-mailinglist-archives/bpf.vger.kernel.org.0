Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5225D5A5662
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 23:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiH2Vpb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 17:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH2Vpa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 17:45:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11577CB63
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 14:45:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z2so11843210edc.1
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sTw+/z7x03je7/hIMvP8+HPPhki5YAz4a5KqEHAejI0=;
        b=MCjxUJlazQF3n57DDygoL969ALwymntJYUumQoMMHF8SAJVx/AZS3qfuvFgZ39C61x
         VuMtxaedr886o3IrTekm8ko/cvwCu79DM16oQmkmuwu28G0LojltBclQvpaIGOeLbvB8
         5arHjv5kCJYugx4E6JD4YpmHI0MxqnrrOZwGKpYCPnt3NkNN6kYx+cvbkmJbK9oq8+le
         RHQuR1Gc24vr4+0sA6B1oJS3WHjmzIYptW2f3fCeFo6WueUPKKSOk1yUaHMPIcv/4Ec+
         LznJqg6f2Q7xc6+4BpF6QQbOIMK2d9Ko+UFW/8LPQTLMPNz/SveNyeZlQK1mptKAkR8V
         2NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sTw+/z7x03je7/hIMvP8+HPPhki5YAz4a5KqEHAejI0=;
        b=A2BbpTMDb2fe7KbvqDeHadn8SjRXzA5mtOPB9NEUt4uxIG3R2vlqSozrJTtr4RTWCB
         YlWD93V8FpfAELgEBRRbYEkrCaCA507dBLFG3O3YvANgBrriqBPZR7jSeivBQdbVRQ1U
         /xVpnIZgn7UFUNIpTJyDqQo01p2LqYOaU/R/X29ELDJf2qfx/wS+Kz4HtN6NQAasys2/
         EhQ9q7So0ppyk9n9YE67glhOtzm2x+zpGh+G6SZI9PzezH5QQJokL+pxu832Fs69Yyn9
         23tnv5ynvQcKwrB+UWc2bWU0rHNoSYLMsVId9FOP/7+J6Z3r6186tfso1Q/S4eqdDWII
         l9mA==
X-Gm-Message-State: ACgBeo3Con4zXjaYzuViR/jrDMfHwaMwj/iUd1jrv18QcNIN8Wyl2vzD
        E9L7P3k8+FmTKZG7yIdgoyC0JcvkeqT3teEvG00=
X-Google-Smtp-Source: AA6agR4iT/8MDNTPI7OIBNJTRlyFMl9mm1PWCshoa168F9VZ2enZ8xhe4feW+V2fcw4i8eixNFHHHJivHE/qYcKkLcs=
X-Received: by 2002:a05:6402:270d:b0:43a:67b9:6eea with SMTP id
 y13-20020a056402270d00b0043a67b96eeamr17914142edd.94.1661809525449; Mon, 29
 Aug 2022 14:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-2-alexei.starovoitov@gmail.com> <74acd56b-21bb-8ea8-092f-d1b4fcfc0790@iogearbox.net>
In-Reply-To: <74acd56b-21bb-8ea8-092f-d1b4fcfc0790@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Aug 2022 14:45:14 -0700
Message-ID: <CAADnVQ+j6dipYGvegVD4umB0rD2nM1p+YGR8ug0XdPqUE8mxLg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/15] bpf: Introduce any context BPF specific
 memory allocator.
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Delyan Kratunov <delyank@fb.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, Aug 29, 2022 at 2:30 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 8/26/22 4:44 AM, Alexei Starovoitov wrote:
> [...]
> > +
> > +/* Called from BPF program or from sys_bpf syscall.
> > + * In both cases migration is disabled.
> > + */
> > +void notrace *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size)
> > +{
> > +     int idx;
> > +     void *ret;
> > +
> > +     if (!size)
> > +             return ZERO_SIZE_PTR;
> > +
> > +     idx = bpf_mem_cache_idx(size + LLIST_NODE_SZ);
> > +     if (idx < 0)
> > +             return NULL;
> > +
> > +     ret = unit_alloc(this_cpu_ptr(ma->caches)->cache + idx);
> > +     return !ret ? NULL : ret + LLIST_NODE_SZ;
> > +}
> > +
> > +void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
> > +{
> > +     int idx;
> > +
> > +     if (!ptr)
> > +             return;
> > +
> > +     idx = bpf_mem_cache_idx(__ksize(ptr - LLIST_NODE_SZ));
> > +     if (idx < 0)
> > +             return;
> > +
> > +     unit_free(this_cpu_ptr(ma->caches)->cache + idx, ptr);
> > +}
> > +
> > +void notrace *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma)
> > +{
> > +     void *ret;
> > +
> > +     ret = unit_alloc(this_cpu_ptr(ma->cache));
> > +     return !ret ? NULL : ret + LLIST_NODE_SZ;
> > +}
> > +
> > +void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
> > +{
> > +     if (!ptr)
> > +             return;
> > +
> > +     unit_free(this_cpu_ptr(ma->cache), ptr);
> > +}
>
> Looks like smp_processor_id() needs to be made aware that preemption might
> be ok just not migration to a different CPU?

ahh. migration is not disabled when map is freed from worker.
this_cpu_ptr above and local_irq_save shortly after need to happen
on the same cpu, so I'm thinking to add migrate_disable
to htab free path.
