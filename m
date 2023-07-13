Return-Path: <bpf+bounces-4890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F8F7515C5
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 03:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7D91C21028
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 01:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C9632;
	Thu, 13 Jul 2023 01:22:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC58F7C;
	Thu, 13 Jul 2023 01:22:40 +0000 (UTC)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C19BB7;
	Wed, 12 Jul 2023 18:22:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id C46AE5801BD;
	Wed, 12 Jul 2023 21:22:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 12 Jul 2023 21:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1689211355; x=1689218555; bh=IGJeeCyYK/qeZ9ru5DjzljIOM8dFRHaIFRq
	Bi7pUwPA=; b=30k0PyMHklFBe2NGjFDR53g3Yw0SLprh1N1FA8jFawDs3aAdBk2
	pmPM1Vu4IPK6yE+H11Rhe+YlP+GH7WyzkqnQAvP1zBYPdFZ8Kno2KbI9uoid5cR7
	z6rHt4PnMfFrBqQUttBfJy6gLAQicxij9CzS8dddcGqykhgy697MbKSRHQYZAXRc
	frw+Pj1E1/aFGuS0NYSZ0B0fYPHoF3tqvMYnLX7ZQNxkwVlrfe/lbyOS1h3Ow/Qv
	e8lonp9VzGm0LymiGrAgcCAmqDhlUdAzK3KaHrQvt4h8Js2QXdw2ssYjg0xyoV2W
	i+Eb6R0+0//6ozwbL6F13o6QkJgfFVtD8Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1689211355; x=1689218555; bh=IGJeeCyYK/qeZ9ru5DjzljIOM8dFRHaIFRq
	Bi7pUwPA=; b=NbsxFBBeaqQSTmaD1m6OsyQ+8OSGVmjMST3ManWnNHhsQ3Dmdws
	5l5Vz9FYUJJ9XvF5ZJDsiFnvtPjnhM/FVrtzBpdUo23oJB4AeY3dta27/Uv5UpR8
	vKdrzqZWOIEqj0HHRNNXNhFMvMjulHUCTY5nX8no60kkLW3CP26dxUJCHSe88FME
	SeqnQL6bHs01snHkZjZUvufmpLMTuRMVZOShYYFlSjgIQxOFOaCzlrS6BkpqdPX9
	iyFEj7NW4YvZ+1lPoeh87oniJ87jkqCSavL+3COWYoLwv/VHsyANL+jiwFSbvpM+
	x5c8CzOoKJZTtELpTbd3H4i7ZANqnN7Uy7w==
X-ME-Sender: <xms:21GvZF3EcQGrCLqS8LkOjV8a5TjW1ODrBIdJXYtPZNYWoeHQzJJUjg>
    <xme:21GvZMFFjseW6c24gUqPi6Nv0y5bjmGGd3815b5EIZL6c_iUgI6koFbgrm65q7b55
    67SRDHY-JOp__gXDg>
X-ME-Received: <xmr:21GvZF5xi23FruCpK8lJBQLQa-fgqANZFMWE7iGBViG0hGIwhXe9Ukx1CPBW_Y83316z4aMi_kH2X1QsjDKXMnXlhRnhhm7ed00V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeefgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepieektdefhffhjeejgeejhfekkeejgfegvdeuhfeitdeiueeh
    hffgvedthedviefgnecuffhomhgrihhnpehqvghmuhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:21GvZC0lxTf7LOJMsr1zizKgFYUdsaon5V66vdlwfqi4C1aiV74Akg>
    <xmx:21GvZIEGF2YIwkf9MV2_E4oUTqb-xlTUE21zqRPqAXe-BTwXqd5MJA>
    <xmx:21GvZD9HeIW9Vc_WsP2hmPh_r_lWJz8oZlEty_wZw_5UXF7xQVUMKg>
    <xmx:21GvZDkqlo7dP2vXl3W_IrI45kqG_B1wyodWGhG51O-AQ-6nvhGhkA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 21:22:33 -0400 (EDT)
Date: Wed, 12 Jul 2023 19:22:32 -0600
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
Message-ID: <kwiwaeaijj6sxwz5fhtxyoquhz2kpujbsbeajysufgmdjgyx5c@f6lqrd23xr5f>
References: <cover.1689203090.git.dxu@dxuuu.xyz>
 <d3b0ff95c58356192ea3b50824f8cdbf02c354e3.1689203090.git.dxu@dxuuu.xyz>
 <CAADnVQKKfEtZYZxihxvG3aQ34E1m95qTZ=jTD7yd0qvOASpAjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKKfEtZYZxihxvG3aQ34E1m95qTZ=jTD7yd0qvOASpAjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alexei,

On Wed, Jul 12, 2023 at 05:43:49PM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 12, 2023 at 4:44 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
> > +       case NFPROTO_IPV6:
> > +               rcu_read_lock();
> > +               v6_hook = rcu_dereference(nf_defrag_v6_hook);
> > +               if (!v6_hook) {
> > +                       rcu_read_unlock();
> > +                       err = request_module("nf_defrag_ipv6");
> > +                       if (err)
> > +                               return err < 0 ? err : -EINVAL;
> > +
> > +                       rcu_read_lock();
> > +                       v6_hook = rcu_dereference(nf_defrag_v6_hook);
> > +                       if (!v6_hook) {
> > +                               WARN_ONCE(1, "nf_defrag_ipv6_hooks bad registration");
> > +                               err = -ENOENT;
> > +                               goto out_v6;
> > +                       }
> > +               }
> > +
> > +               err = v6_hook->enable(link->net);
> 
> I was about to apply, but luckily caught this issue in my local test:
> 
> [   18.462448] BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:283
> [   18.463238] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
> 2042, name: test_progs
> [   18.463927] preempt_count: 0, expected: 0
> [   18.464249] RCU nest depth: 1, expected: 0
> [   18.464631] CPU: 15 PID: 2042 Comm: test_progs Tainted: G
> O       6.4.0-04319-g6f6ec4fa00dc #4896
> [   18.465480] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   18.466531] Call Trace:
> [   18.466767]  <TASK>
> [   18.466975]  dump_stack_lvl+0x32/0x40
> [   18.467325]  __might_resched+0x129/0x180
> [   18.467691]  mutex_lock+0x1a/0x40
> [   18.468057]  nf_defrag_ipv4_enable+0x16/0x70
> [   18.468467]  bpf_nf_link_attach+0x141/0x300
> [   18.468856]  __sys_bpf+0x133e/0x26d0
> 
> You cannot call mutex under rcu_read_lock.

Whoops, my bad. I think this patch should fix it:

```
From 7e8927c44452db07ddd7cf0e30bb49215fc044ed Mon Sep 17 00:00:00 2001
Message-ID: <7e8927c44452db07ddd7cf0e30bb49215fc044ed.1689211250.git.dxu@dxuuu.xyz>
From: Daniel Xu <dxu@dxuuu.xyz>
Date: Wed, 12 Jul 2023 19:17:35 -0600
Subject: [PATCH] netfilter: bpf: Don't hold rcu_read_lock during
 enable/disable

->enable()/->disable() takes a mutex which can sleep. You can't sleep
during RCU read side critical section.

Our refcnt on the module will protect us from ->enable()/->disable()
from going away while we call it.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/netfilter/nf_bpf_link.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 77ffbf26ba3d..79704cc596aa 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -60,9 +60,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
                        goto out_v4;
                }

+               rcu_read_unlock();
                err = v4_hook->enable(link->net);
                if (err)
                        module_put(v4_hook->owner);
+
+               return err;
 out_v4:
                rcu_read_unlock();
                return err;
@@ -92,9 +95,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
                        goto out_v6;
                }

+               rcu_read_unlock();
                err = v6_hook->enable(link->net);
                if (err)
                        module_put(v6_hook->owner);
+
+               return err;
 out_v6:
                rcu_read_unlock();
                return err;
@@ -114,11 +120,11 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
        case NFPROTO_IPV4:
                rcu_read_lock();
                v4_hook = rcu_dereference(nf_defrag_v4_hook);
+               rcu_read_unlock();
                if (v4_hook) {
                        v4_hook->disable(link->net);
                        module_put(v4_hook->owner);
                }
-               rcu_read_unlock();

                break;
 #endif
@@ -126,11 +132,11 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
        case NFPROTO_IPV6:
                rcu_read_lock();
                v6_hook = rcu_dereference(nf_defrag_v6_hook);
+               rcu_read_unlock();
                if (v6_hook) {
                        v6_hook->disable(link->net);
                        module_put(v6_hook->owner);
                }
-               rcu_read_unlock();

                break;
        }
--
2.41.0
```

I'll send out a v5 tomorrow morning unless you feel like applying the
series + this patch today.

> 
> Please make sure you have all kernel debug flags on in your testing.
> 

Ack. Will make sure lockdep is on.


Thanks,
Daniel

