Return-Path: <bpf+bounces-4920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105BB751783
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1CF281BAD
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE9ECB;
	Thu, 13 Jul 2023 04:33:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F66629;
	Thu, 13 Jul 2023 04:33:25 +0000 (UTC)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A70912F;
	Wed, 12 Jul 2023 21:33:24 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id A651158014A;
	Thu, 13 Jul 2023 00:33:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 13 Jul 2023 00:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1689222800; x=1689230000; bh=v+lGBq+GJvpo2kNvySw6OJjRn6Dau/dhBqQ
	PgKVw2CQ=; b=Ydxif1r282/SQPhrzrY2GmsMajEwfmQ8a79fOmJp2JCCyCO1H5e
	EPewr9Zx+Us62Lyk0Uq67G9wzmJ4CGJldD2IU4Y0QlAki+1RznNT1RUL4ppEW468
	a4zFolkEu8Jd+YOYrLHwzkIX3geDGNQvTaKCRGh3jtv20ZK8sgbzN8UOr4rxTadu
	xpKwmfmDF8Rhkna2/u7+B5pkOrg7Nh5f1iStoZGT9S/2h12q5BrjLd9FmMvW/mou
	4FexsgaHFbDOupyzvCR3NCa7Ko/8w00K+IcUVjWgCxtNX1klziRCDEQQP3SQFY8i
	IvTl24b4Y5X4GDzULEUY/sRyWvZSs7ufpqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1689222800; x=1689230000; bh=v+lGBq+GJvpo2kNvySw6OJjRn6Dau/dhBqQ
	PgKVw2CQ=; b=fgeaCodm8HH0aE7shD+BHhQYqHpMXe9BsL9VSsSN/WJWSEeBrEC
	BTk7kBvJrQLLHaQYyNb7zrDFBKLB2THEbzyMh9+9L/Yc5KOv49G46KVti8zYVa46
	GaKpMMFfWXSmNTraqwyzR7FRS2Ag7G0BGX+XD8Ha1hSJZOWrZglRWBqqOeIqH6bh
	i5OT0a9PzcDvxVqOExTrfgqW57QvhX2IBLR+7ev+zBf2j2igL9FeujM/Dx+oFQ7I
	JFNLhQgUonkgeRqvJn2i7UcpcQ2EPY/AST+v8wW7TF5kFYE9Jhv8JTFWVBDbdcsO
	U7Omy3Fhtv1h8GcVR2+hgUWu/89F4Vvj70g==
X-ME-Sender: <xms:kH6vZCNvEuQFvMAjH-eqZdA5Z6iqj2kWh2GCbX9JTLDgB7G3kYd1Qg>
    <xme:kH6vZA_g7MGZi1EGlBsUW_9alzrF2TWPmqvsL7cbHI9yDxizyAG8NSxyI1fEVuCZ1
    JsQQo6UlHzfyoaMkQ>
X-ME-Received: <xmr:kH6vZJQ4Xep3pgUvzJa2NYPw0HCQ9lUnWNACwK_oCo_a1lE7gnxhrjgF3gfhrdd5hy0Z3T3GHqZLRuraZbih0MxWyS3FRCH_I-Bt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeefgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepieektdefhffhjeejgeejhfekkeejgfegvdeuhfeitdeiueeh
    hffgvedthedviefgnecuffhomhgrihhnpehqvghmuhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:kH6vZCt72U-FBVX6tLrqaPeaPoUfUH9z-P6Nj1hqnigQJ_pjsvGDmA>
    <xmx:kH6vZKfXKXYQo42k5IQHOLv_7RzDdWkSNJgYftSK6yp142O-PgxGzQ>
    <xmx:kH6vZG14awhZMY8fhJ3e837cipMAXfutZEyzNfuLpCfYkYs8asLuqg>
    <xmx:kH6vZIcDhoL_pWLsJEg5zCMGqqwT0nqZgobChfCa9hCQiPXfbh_9sA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 00:33:18 -0400 (EDT)
Date: Wed, 12 Jul 2023 22:33:17 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Florian Westphal <fw@strlen.de>, 
	"David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org, 
	Network Development <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH bpf-next v4 2/6] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <wltfmammaf5g4gumsbna4kmwo6dtd24g472o7kgkug42dhwcy2@32fmd7q6kvg4>
References: <cover.1689203090.git.dxu@dxuuu.xyz>
 <d3b0ff95c58356192ea3b50824f8cdbf02c354e3.1689203090.git.dxu@dxuuu.xyz>
 <CAADnVQKKfEtZYZxihxvG3aQ34E1m95qTZ=jTD7yd0qvOASpAjQ@mail.gmail.com>
 <kwiwaeaijj6sxwz5fhtxyoquhz2kpujbsbeajysufgmdjgyx5c@f6lqrd23xr5f>
 <CAADnVQLcAoN5z+HD_44UKgJJc6t5TPW8+Ai9We0qJpau4NtEzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLcAoN5z+HD_44UKgJJc6t5TPW8+Ai9We0qJpau4NtEzA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 06:26:13PM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 12, 2023 at 6:22 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Hi Alexei,
> >
> > On Wed, Jul 12, 2023 at 05:43:49PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Jul 12, 2023 at 4:44 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
> > > > +       case NFPROTO_IPV6:
> > > > +               rcu_read_lock();
> > > > +               v6_hook = rcu_dereference(nf_defrag_v6_hook);
> > > > +               if (!v6_hook) {
> > > > +                       rcu_read_unlock();
> > > > +                       err = request_module("nf_defrag_ipv6");
> > > > +                       if (err)
> > > > +                               return err < 0 ? err : -EINVAL;
> > > > +
> > > > +                       rcu_read_lock();
> > > > +                       v6_hook = rcu_dereference(nf_defrag_v6_hook);
> > > > +                       if (!v6_hook) {
> > > > +                               WARN_ONCE(1, "nf_defrag_ipv6_hooks bad registration");
> > > > +                               err = -ENOENT;
> > > > +                               goto out_v6;
> > > > +                       }
> > > > +               }
> > > > +
> > > > +               err = v6_hook->enable(link->net);
> > >
> > > I was about to apply, but luckily caught this issue in my local test:
> > >
> > > [   18.462448] BUG: sleeping function called from invalid context at
> > > kernel/locking/mutex.c:283
> > > [   18.463238] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
> > > 2042, name: test_progs
> > > [   18.463927] preempt_count: 0, expected: 0
> > > [   18.464249] RCU nest depth: 1, expected: 0
> > > [   18.464631] CPU: 15 PID: 2042 Comm: test_progs Tainted: G
> > > O       6.4.0-04319-g6f6ec4fa00dc #4896
> > > [   18.465480] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > > [   18.466531] Call Trace:
> > > [   18.466767]  <TASK>
> > > [   18.466975]  dump_stack_lvl+0x32/0x40
> > > [   18.467325]  __might_resched+0x129/0x180
> > > [   18.467691]  mutex_lock+0x1a/0x40
> > > [   18.468057]  nf_defrag_ipv4_enable+0x16/0x70
> > > [   18.468467]  bpf_nf_link_attach+0x141/0x300
> > > [   18.468856]  __sys_bpf+0x133e/0x26d0
> > >
> > > You cannot call mutex under rcu_read_lock.
> >
> > Whoops, my bad. I think this patch should fix it:
> >
> > ```
> > From 7e8927c44452db07ddd7cf0e30bb49215fc044ed Mon Sep 17 00:00:00 2001
> > Message-ID: <7e8927c44452db07ddd7cf0e30bb49215fc044ed.1689211250.git.dxu@dxuuu.xyz>
> > From: Daniel Xu <dxu@dxuuu.xyz>
> > Date: Wed, 12 Jul 2023 19:17:35 -0600
> > Subject: [PATCH] netfilter: bpf: Don't hold rcu_read_lock during
> >  enable/disable
> >
> > ->enable()/->disable() takes a mutex which can sleep. You can't sleep
> > during RCU read side critical section.
> >
> > Our refcnt on the module will protect us from ->enable()/->disable()
> > from going away while we call it.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  net/netfilter/nf_bpf_link.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> > index 77ffbf26ba3d..79704cc596aa 100644
> > --- a/net/netfilter/nf_bpf_link.c
> > +++ b/net/netfilter/nf_bpf_link.c
> > @@ -60,9 +60,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
> >                         goto out_v4;
> >                 }
> >
> > +               rcu_read_unlock();
> >                 err = v4_hook->enable(link->net);
> >                 if (err)
> >                         module_put(v4_hook->owner);
> > +
> > +               return err;
> >  out_v4:
> >                 rcu_read_unlock();
> >                 return err;
> > @@ -92,9 +95,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
> >                         goto out_v6;
> >                 }
> >
> > +               rcu_read_unlock();
> >                 err = v6_hook->enable(link->net);
> >                 if (err)
> >                         module_put(v6_hook->owner);
> > +
> > +               return err;
> >  out_v6:
> >                 rcu_read_unlock();
> >                 return err;
> > @@ -114,11 +120,11 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
> >         case NFPROTO_IPV4:
> >                 rcu_read_lock();
> >                 v4_hook = rcu_dereference(nf_defrag_v4_hook);
> > +               rcu_read_unlock();
> >                 if (v4_hook) {
> >                         v4_hook->disable(link->net);
> >                         module_put(v4_hook->owner);
> >                 }
> > -               rcu_read_unlock();
> >
> >                 break;
> >  #endif
> > @@ -126,11 +132,11 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
> >         case NFPROTO_IPV6:
> >                 rcu_read_lock();
> >                 v6_hook = rcu_dereference(nf_defrag_v6_hook);
> > +               rcu_read_unlock();
> 
> No. v6_hook is gone as soon as you unlock it.

I think we're protected here by the try_module_get() on the enable path.
And we only disable defrag if enabling succeeds. The module shouldn't
be able to deregister its hooks until we call the module_put() later.

I think READ_ONCE() would've been more appropriate but I wasn't sure if
that was ok given nf_defrag_v(4|6)_hook is written to by
rcu_assign_pointer() and I was assuming symmetry is necessary.

Does that sound right?

Thanks,
Daniel

