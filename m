Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CC2571182
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 06:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiGLEjZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 00:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiGLEjU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 00:39:20 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C898CC96
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 21:39:18 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e132so6548838pgc.5
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 21:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RbuQvW5P2B327xH9DYaPbGliNJwj/rxxYgllk0AY4L8=;
        b=TngVdD1sMavZB1GSqPOcX/p1sPgmX0VOBXVJbKQlap5VWxF3Sr11hw6Bkl0+8QyBSX
         +vJheTHD/QdqNpuBZr+H8dUag2zTPNq4WjZqe+jfFxQDTUKoIUJzNk744rd0DUm8aRBo
         hgKgI7KKecymL1k/6Iy0tocXBinPMx7p3gSmK6NmFf7Sq2NIKlgRuUkdf6/y3k6b/x03
         ZxVSEWc2R1Dgyif4u4Dfz3NeHoSlBlIn9W2L4NZH82gop4/mpmj+4ddnsyco+j19dSZt
         UiLKEuLTwfXmhhIn3p2xIi+EwbUJHWZ5ADvgwyGcaw7KAPQzrp7qZAbtbKwOBvr9xVK2
         iqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RbuQvW5P2B327xH9DYaPbGliNJwj/rxxYgllk0AY4L8=;
        b=HiMwyadF/2oj/Sq+JAua+vgMZLvdgbH2TD0YDckgapmVvGu+TkSHv4ebfv24sdtLpn
         3y4dtL9I3fuI3V4hIr33Lk6mc0RzczCitwg6Gd1DUutPvxgyddGRO7EDkP0MEXHysupL
         66He6+OK6pih8DhEgKg6cCzKHALJRJhKYQTZm9jlQklNV6xk1zXcKxhm0Egj1kizx5hE
         ro7O4QJgZePKCFctSStVnM78EUdwShPtVnXE9nyKCqqp6npBo89yENIa5GNui0EMBitI
         xytYJ07Y48On+0g61wk02auRXISkhwkdSEjVjVn8Tog2coeFM4ON9U+dZvDPXvC1Dd7Z
         DLPw==
X-Gm-Message-State: AJIora+QPFt1DPwsqqhiadkOpR/02aAnNV6+F1iyhbvntfrrQzGMoGVm
        cKDJUCnXxBhevNNWqISgRsc=
X-Google-Smtp-Source: AGRyM1uAKIH8QJ3s/qucXxt5/RCQQkwQSGuJJjPC8NBl5t1rOE+Q7rXnoM2QRWxZ/G5ba86Lw0jS9g==
X-Received: by 2002:a63:2205:0:b0:417:61fd:cd35 with SMTP id i5-20020a632205000000b0041761fdcd35mr2910008pgi.544.1657600758266;
        Mon, 11 Jul 2022 21:39:18 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:c47b])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b0016bf2a4598asm5589182plk.229.2022.07.11.21.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 21:39:17 -0700 (PDT)
Date:   Mon, 11 Jul 2022 21:39:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
References: <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz>
 <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com>
 <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
 <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 11, 2022 at 02:15:07PM +0200, Michal Hocko wrote:
> On Sun 10-07-22 07:32:13, Shakeel Butt wrote:
> > On Sat, Jul 09, 2022 at 10:26:23PM -0700, Alexei Starovoitov wrote:
> > > On Fri, Jul 8, 2022 at 2:55 PM Shakeel Butt <shakeelb@google.com> wrote:
> > [...]
> > > >
> > > > Most probably Michal's comment was on free objects sitting in the caches
> > > > (also pointed out by Yosry). Should we drain them on memory pressure /
> > > > OOM or should we ignore them as the amount of memory is not significant?
> > > 
> > > Are you suggesting to design a shrinker for 0.01% of the memory
> > > consumed by bpf?
> > 
> > No, just claim that the memory sitting on such caches is insignificant.
> 
> yes, that is not really clear from the patch description. Earlier you
> have said that the memory consumed might go into GBs. If that is a
> memory that is actively used and not really reclaimable then bad luck.
> There are other users like that in the kernel and this is not a new
> problem. I think it would really help to add a counter to describe both
> the overall memory claimed by the bpf allocator and actively used
> portion of it. If you use our standard vmstat infrastructure then we can
> easily show that information in the OOM report.

OOM report can potentially be extended with info about bpf consumed
memory, but it's not clear whether it will help OOM analysis.
bpftool map show
prints all map data already.
Some devs use bpf to inspect bpf maps for finer details in run-time.
drgn scripts pull that data from crash dumps.
There is no need for new counters.
The idea of bpf specific counters/limits was rejected by memcg folks.

> OK, thanks for the clarification. There is still one thing that is not
> really clear to me. Without a proper ownership bound to any process why
> is it desired/helpful to account the memory to a memcg?

The first step is to have a limit. memcg provides it.

> We have discussed something similar in a different email thread and I
> still didn't manage to find time to put all the parts together. But if
> the initiator (or however you call the process which loads the program)
> exits then this might be the last process in the specific cgroup and so
> it can be offlined and mostly invisible to an admin.

Roman already sent reparenting fix:
https://patchwork.kernel.org/project/netdevbpf/patch/20220711162827.184743-1-roman.gushchin@linux.dev/

> As you have explained there is nothing really actionable on this memory
> by the OOM killer either. So does it actually buy us much to account?

It will be actionable. One step at a time.
In the other thread we've discussed an idea to make memcg selectable when
bpf objects are created. The user might create a special memcg and use it for
all things bpf. This might be the way to provide bpf specific accounting
and limits.
