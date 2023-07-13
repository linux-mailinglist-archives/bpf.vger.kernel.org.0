Return-Path: <bpf+bounces-4979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD2752E0A
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 01:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23644281F7F
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 23:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278506AAD;
	Thu, 13 Jul 2023 23:42:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694463D6;
	Thu, 13 Jul 2023 23:42:41 +0000 (UTC)
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDCA2707;
	Thu, 13 Jul 2023 16:42:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.west.internal (Postfix) with ESMTP id DA1652B0005E;
	Thu, 13 Jul 2023 19:42:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jul 2023 19:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1689291756; x=1689298956; bh=EzNZ4lSIA6Q11ERKP9wL6gbe1PTUeztr8yy
	uoNBS6xI=; b=lwlN9tGh2djU92nCaw14L8DOqRSFUea9bxC8PzEXViIRwkgKWqx
	0PRLwA5GyEoUkqZgV1OG38xgf06awiPK/inuCCPe/Kfj5rUfl9H/R2CtkCeGrb0d
	rzPplFlSpf95be0DK5IsgGZU+gJBUFXJmUGFUAybOXr71Jq8mPd6ceJzUfY3f255
	qNVnrFmzEbSFVFAuWB3oBe3On59NB36ZAFBmvTyEG5shK9v0ghBSIbefS1mCoJ9N
	MsAp6xN4ks/32ErGWlJTufHJm4PysC0mQsXSpRzFZHI5whQEU7V8oztTJ5Kwj8ka
	gz0t/2WkL15AZj1t7l+lvC93oN+Dga/jTOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1689291756; x=1689298956; bh=EzNZ4lSIA6Q11ERKP9wL6gbe1PTUeztr8yy
	uoNBS6xI=; b=eZJGBYtpogIteZ9RY7DGwiLXsVU/AqBs/HcGcGkMDp/pYEUXq6z
	SZPjvwdwZEzt+zwUC2De3idEBM0U0osNYUkUyWq1asZoSFByDWQ2AVlXu8WO+XEh
	ysyyF5jDChkqvWYUVpU16spKxznJVtdM4jWqTvtzFkbmSy8gDfJLpfdGa/kkib7u
	tB/RuBEFy8P6Qhr49mYQJHzDLxr4CF6k6dtByzMPPBROjTM/UK8qgwdUUFybN45k
	CwNhklHrGUHl7ePHvMXTUNfxlc72ckZYkBTj1v+GzHPog/FypI6Tb0F5mGeGQBMN
	YSSV8+Jo00+juInO/9wZi6newj/p6znX/sw==
X-ME-Sender: <xms:64uwZNVacJ5NUMpvwo4iBGdlz67l-Saew17mLJ9DGWISMv1STsy4sg>
    <xme:64uwZNkmxCGIcKVXB_023ZUf6kZtqfnCDLP7xp3cTx1MVvgvGPD2vbvRHbMLx-MgZ
    SINkvuIcruTIlQ9Hw>
X-ME-Received: <xmr:64uwZJbY15BAcpgo3svwKSXkanT3Gwo0NVAcVat7o2_lZg4kgigM3fv6qA9fljl7IL_pvhGsOV-iD0fuMdvI3nZNc8p4UA6N_osh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeehgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepieektdefhffhjeejgeejhfekkeejgfegvdeuhfeitdeiueeh
    hffgvedthedviefgnecuffhomhgrihhnpehqvghmuhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:64uwZAVoqZuK6x0Zc470yxBCCCwJDEP4Qn6U_z-4FamVbPQsKNVyww>
    <xmx:64uwZHmMdfE20ZbIMwCnk2Tv5iOsFcfU8e0MFy4Q1SLaJ3Hnd0YUpQ>
    <xmx:64uwZNchtFnRTMKgfQWpij797GJxGPhaHZ5HAvm4cuVvy_7wdmjnzw>
    <xmx:7IuwZFF3iowhMRQ7rNsPyJKSznXv9vLz1UWVUst5UFCrNPSvFcu3j8iw4Lo>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 19:42:34 -0400 (EDT)
Date: Thu, 13 Jul 2023 17:42:32 -0600
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
Message-ID: <t6wypww537golmoosbikfuombrqq555fh5mbycwl4whto6joo4@hcqlospkgqyr>
References: <cover.1689203090.git.dxu@dxuuu.xyz>
 <d3b0ff95c58356192ea3b50824f8cdbf02c354e3.1689203090.git.dxu@dxuuu.xyz>
 <CAADnVQKKfEtZYZxihxvG3aQ34E1m95qTZ=jTD7yd0qvOASpAjQ@mail.gmail.com>
 <kwiwaeaijj6sxwz5fhtxyoquhz2kpujbsbeajysufgmdjgyx5c@f6lqrd23xr5f>
 <CAADnVQLcAoN5z+HD_44UKgJJc6t5TPW8+Ai9We0qJpau4NtEzA@mail.gmail.com>
 <wltfmammaf5g4gumsbna4kmwo6dtd24g472o7kgkug42dhwcy2@32fmd7q6kvg4>
 <CAADnVQJQZ2jQSWByVvi3N2ZOoL0XDSJzx5biSVvq=inS7OSW7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJQZ2jQSWByVvi3N2ZOoL0XDSJzx5biSVvq=inS7OSW7A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 04:10:03PM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 12, 2023 at 9:33 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > On Wed, Jul 12, 2023 at 06:26:13PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Jul 12, 2023 at 6:22 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > >
> > > > Hi Alexei,
> > > >
> > > > On Wed, Jul 12, 2023 at 05:43:49PM -0700, Alexei Starovoitov wrote:
> > > > > On Wed, Jul 12, 2023 at 4:44 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > > > +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
> > > > > > +       case NFPROTO_IPV6:
> > > > > > +               rcu_read_lock();
> > > > > > +               v6_hook = rcu_dereference(nf_defrag_v6_hook);
> > > > > > +               if (!v6_hook) {
> > > > > > +                       rcu_read_unlock();
> > > > > > +                       err = request_module("nf_defrag_ipv6");
> > > > > > +                       if (err)
> > > > > > +                               return err < 0 ? err : -EINVAL;
> > > > > > +
> > > > > > +                       rcu_read_lock();
> > > > > > +                       v6_hook = rcu_dereference(nf_defrag_v6_hook);
> > > > > > +                       if (!v6_hook) {
> > > > > > +                               WARN_ONCE(1, "nf_defrag_ipv6_hooks bad registration");
> > > > > > +                               err = -ENOENT;
> > > > > > +                               goto out_v6;
> > > > > > +                       }
> > > > > > +               }
> > > > > > +
> > > > > > +               err = v6_hook->enable(link->net);
> > > > >
> > > > > I was about to apply, but luckily caught this issue in my local test:
> > > > >
> > > > > [   18.462448] BUG: sleeping function called from invalid context at
> > > > > kernel/locking/mutex.c:283
> > > > > [   18.463238] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
> > > > > 2042, name: test_progs
> > > > > [   18.463927] preempt_count: 0, expected: 0
> > > > > [   18.464249] RCU nest depth: 1, expected: 0
> > > > > [   18.464631] CPU: 15 PID: 2042 Comm: test_progs Tainted: G
> > > > > O       6.4.0-04319-g6f6ec4fa00dc #4896
> > > > > [   18.465480] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > > > BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > > > > [   18.466531] Call Trace:
> > > > > [   18.466767]  <TASK>
> > > > > [   18.466975]  dump_stack_lvl+0x32/0x40
> > > > > [   18.467325]  __might_resched+0x129/0x180
> > > > > [   18.467691]  mutex_lock+0x1a/0x40
> > > > > [   18.468057]  nf_defrag_ipv4_enable+0x16/0x70
> > > > > [   18.468467]  bpf_nf_link_attach+0x141/0x300
> > > > > [   18.468856]  __sys_bpf+0x133e/0x26d0
> > > > >
> > > > > You cannot call mutex under rcu_read_lock.
> > > >
> > > > Whoops, my bad. I think this patch should fix it:
> > > >
> > > > ```
> > > > From 7e8927c44452db07ddd7cf0e30bb49215fc044ed Mon Sep 17 00:00:00 2001
> > > > Message-ID: <7e8927c44452db07ddd7cf0e30bb49215fc044ed.1689211250.git.dxu@dxuuu.xyz>
> > > > From: Daniel Xu <dxu@dxuuu.xyz>
> > > > Date: Wed, 12 Jul 2023 19:17:35 -0600
> > > > Subject: [PATCH] netfilter: bpf: Don't hold rcu_read_lock during
> > > >  enable/disable
> > > >
> > > > ->enable()/->disable() takes a mutex which can sleep. You can't sleep
> > > > during RCU read side critical section.
> > > >
> > > > Our refcnt on the module will protect us from ->enable()/->disable()
> > > > from going away while we call it.
> > > >
> > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > ---
> > > >  net/netfilter/nf_bpf_link.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> > > > index 77ffbf26ba3d..79704cc596aa 100644
> > > > --- a/net/netfilter/nf_bpf_link.c
> > > > +++ b/net/netfilter/nf_bpf_link.c
> > > > @@ -60,9 +60,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
> > > >                         goto out_v4;
> > > >                 }
> > > >
> > > > +               rcu_read_unlock();
> > > >                 err = v4_hook->enable(link->net);
> > > >                 if (err)
> > > >                         module_put(v4_hook->owner);
> > > > +
> > > > +               return err;
> > > >  out_v4:
> > > >                 rcu_read_unlock();
> > > >                 return err;
> > > > @@ -92,9 +95,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
> > > >                         goto out_v6;
> > > >                 }
> > > >
> > > > +               rcu_read_unlock();
> > > >                 err = v6_hook->enable(link->net);
> > > >                 if (err)
> > > >                         module_put(v6_hook->owner);
> > > > +
> > > > +               return err;
> > > >  out_v6:
> > > >                 rcu_read_unlock();
> > > >                 return err;
> > > > @@ -114,11 +120,11 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
> > > >         case NFPROTO_IPV4:
> > > >                 rcu_read_lock();
> > > >                 v4_hook = rcu_dereference(nf_defrag_v4_hook);
> > > > +               rcu_read_unlock();
> > > >                 if (v4_hook) {
> > > >                         v4_hook->disable(link->net);
> > > >                         module_put(v4_hook->owner);
> > > >                 }
> > > > -               rcu_read_unlock();
> > > >
> > > >                 break;
> > > >  #endif
> > > > @@ -126,11 +132,11 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
> > > >         case NFPROTO_IPV6:
> > > >                 rcu_read_lock();
> > > >                 v6_hook = rcu_dereference(nf_defrag_v6_hook);
> > > > +               rcu_read_unlock();
> > >
> > > No. v6_hook is gone as soon as you unlock it.
> >
> > I think we're protected here by the try_module_get() on the enable path.
> > And we only disable defrag if enabling succeeds. The module shouldn't
> > be able to deregister its hooks until we call the module_put() later.
> >
> > I think READ_ONCE() would've been more appropriate but I wasn't sure if
> > that was ok given nf_defrag_v(4|6)_hook is written to by
> > rcu_assign_pointer() and I was assuming symmetry is necessary.
> 
> Why is rcu_assign_pointer() used?
> If it's not RCU protected, what is the point of rcu_*() accessors
> and rcu_read_lock() ?
> 
> In general, the pattern:
> rcu_read_lock();
> ptr = rcu_dereference(...);
> rcu_read_unlock();
> ptr->..
> is a bug. 100%.
> 

The reason I left it like this is b/c otherwise I think there is a race
with module unload and taking a refcnt. For example:

ptr = READ_ONCE(global_var)
                                             <module unload on other cpu>
// ptr invalid
try_module_get(ptr->owner) 

I think the the synchronize_rcu() call in
kernel/module/main.c:free_module() protects against that race based on
my reading.

Maybe the ->enable() path can store a copy of the hook ptr in
struct bpf_nf_link to get rid of the odd rcu_dereference()?

Open to other ideas too -- would appreciate any hints.

Thanks,
Daniel

