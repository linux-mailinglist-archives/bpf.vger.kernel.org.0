Return-Path: <bpf+bounces-17577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB780F73D
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 20:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF2D1C20DC9
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0245452745;
	Tue, 12 Dec 2023 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="IL928oPD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uJVvU2Hl"
X-Original-To: bpf@vger.kernel.org
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E656D9A;
	Tue, 12 Dec 2023 11:52:51 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id 3F6FA2B001D4;
	Tue, 12 Dec 2023 14:52:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 12 Dec 2023 14:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1702410766;
	 x=1702417966; bh=PWR2ya5pGiPVyjegzqtZ+4qYDOLJjkmxivRf/6mGesQ=; b=
	IL928oPDrSAYbSUNTSiE9NxEDVeMdmmFFMcofmugw5LAZUgWMFm3dzW2ENQhf29G
	jrhQw7rWZZf+ASWbGPieceLvbgc27OJvgf6p/z6AKhKWX82M0LO4acU1r4nAkRnT
	CBEFAV6K+FGEIRexMY2tHVMWPu+9aupieB5BZm/u1NGByyvS4Vjyn9klcu5qmALj
	opAEBGmgzldrObROMNGUWfAba0bACO/hum6K4LP51zr92oNAYMgrDbyhncH5u1+6
	rlDBLZk00rCqvBKK4BxnDxfOSckRADRG1VQaBf0Jv1Dt4H+EFhItKkgnsDmC6FLn
	iEJ4jCw++suOu6A67x7Dcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702410766; x=
	1702417966; bh=PWR2ya5pGiPVyjegzqtZ+4qYDOLJjkmxivRf/6mGesQ=; b=u
	JVvU2Hl07to+U2Yuz+OO8LScs/KD86ueEmDYkMdklLweASdRwUySivIZPppV8Fmj
	AznjbmV4vo6cAtdRezplsIqFygb43n3lCVWyQVrVysMt9IS5XGBj2T0v3emaRTWc
	nrKo9rXBn1vIPKi6sHfbH+OkKcoyMLa/5aVm5qEhBPjznuGqsOWkyzZXb1m57DOz
	+G7uEAgWDYTw3W/jXvTH7eIBNeRP8Ugvr8AoRlso0CJZOyPZoHRt5yl1bT1bhQAp
	DPmiqZ5BrZXb/E+wSmfZL5VOjR7Rsap/28CLN1CQJgQuDyBbJ9TjTitpcRnecLwR
	+eJjGRvka7P5YvRC/QJ9Q==
X-ME-Sender: <xms:Drp4ZcxAeV7xwT7DcKPrAGSjhrDI9h-k7TtdcgQwoxYlxzL_HlrgNQ>
    <xme:Drp4ZQT73RXm7dCD7qdUWT1zlf_HqjtZunCvWHaRtq7FW3ixUuWS5481NqTuGswW-
    ALKVcb3JMUDPnIZfg>
X-ME-Received: <xmr:Drp4ZeXQGZbIoF7cZ9mHvPqYVGeSui__57TcUsq19Yltojzj3fhS_DGhm7eoO3_iwnlpOna7_xBJTCLmZwEThrbU-wzflkuAVvPa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Drp4Zagbq4jmav-kGsN7OxrOoavejutk39dkGmBVnzQ3whTU4NtIBg>
    <xmx:Drp4ZeB611bMkmZcsRqdBEgTkqLgdtmVcHz_SmUabUjrRoOygdxfhQ>
    <xmx:Drp4ZbIti5nu9uwcrxFlYK-I7cC1Bpq8Vg0CKMWeIwh4TU4v2ZiZqA>
    <xmx:Drp4ZZaVSZXwP31ZtFowTJoC1shUbjnmn_mw4g_1H3JM_uWGA6AdbeEpLwg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 14:52:44 -0500 (EST)
Date: Tue, 12 Dec 2023 12:52:43 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: daniel@iogearbox.net, davem@davemloft.net, shuah@kernel.org, 
	ast@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, andrii@kernel.org, 
	hawk@kernel.org, steffen.klassert@secunet.com, antony.antony@secunet.com, 
	alexei.starovoitov@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com, mykolal@fb.com, 
	martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	devel@linux-ipsec.org, memxor@gmail.com
Subject: Re: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for
 bpf_xdp_get_xfrm_state()
Message-ID: <fecc7tpmbnqxuxqqolm44ggyeomcr3piabsjkv3pgyzlhyonq6@iiaxf34erjzq>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
 <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
 <CAHsH6GsdqBN638uqUm+8QkP1_45coucSTL7o=D2wFW-gYjPaBw@mail.gmail.com>
 <7yjkfhrwdphtcljq3odv4jc6lucd32wcg277hfsf4ve2jbo7hp@vuqzwbq5nxjw>
 <CAHsH6Gs1vUQnhR_a4qFnAF37Vx=68Do28sfVfFxQ9pVj9jSzjw@mail.gmail.com>
 <qiv464c4y43mo5rih5k6lgzkbpnj6wsrl52hrhgbxeqj45atun@szmqlmnccm52>
 <CAHsH6Gujycb9RBuRk7QHorLe0Q=Np_tb3uboQfp9KmJnegVXvw@mail.gmail.com>
 <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp>

cc Kumar

On Tue, Dec 12, 2023 at 09:17:02AM -0700, Daniel Xu wrote:
> On Mon, Dec 11, 2023 at 04:25:06PM -0800, Eyal Birger wrote:
> > On Mon, Dec 11, 2023 at 3:49 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > On Mon, Dec 11, 2023 at 03:13:07PM -0800, Eyal Birger wrote:
> > > > On Mon, Dec 11, 2023 at 2:31 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > >
> > > > > On Mon, Dec 11, 2023 at 01:39:25PM -0800, Eyal Birger wrote:
> > > > > > Hi Daniel,
> > > > > >
> > > > > > Tiny nits below in case you respin this for other reasons:
> > > > > >
> > > > > > On Mon, Dec 11, 2023 at 12:20 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > > > >
> > > > > > > This commit extends test_tunnel selftest to test the new XDP xfrm state
> > > > > > > lookup kfunc.
> > > > > > >
> > > > > > > Co-developed-by: Antony Antony <antony.antony@secunet.com>
> > > > > > > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > > > > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > > > > ---
> > > > > > >  .../selftests/bpf/prog_tests/test_tunnel.c    | 20 ++++++--
> > > > > > >  .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++++
> > > > > > >  2 files changed, 67 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > > > index 2d7f8fa82ebd..fc804095d578 100644
> > > > > > > --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > > > +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > > > > @@ -278,7 +278,7 @@ static int add_xfrm_tunnel(void)
> > > > > > >         SYS(fail,
> > > > > > >             "ip netns exec at_ns0 "
> > > > > > >                 "ip xfrm state add src %s dst %s proto esp "
> > > > > > > -                       "spi %d reqid 1 mode tunnel "
> > > > > > > +                       "spi %d reqid 1 mode tunnel replay-window 42 "
> > > > > > >                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
> > > > > > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
> > > > > > >         SYS(fail,
> > > > > > > @@ -292,7 +292,7 @@ static int add_xfrm_tunnel(void)
> > > > > > >         SYS(fail,
> > > > > > >             "ip netns exec at_ns0 "
> > > > > > >                 "ip xfrm state add src %s dst %s proto esp "
> > > > > > > -                       "spi %d reqid 2 mode tunnel "
> > > > > > > +                       "spi %d reqid 2 mode tunnel replay-window 42 "
> > > > > >
> > > > > > nit: why do you need to set the replay-window in both directions?
> > > > >
> > > > > No reason - probably just careless here.
> > > > >
> > > > > >
> > > > > > >                         "auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
> > > > > > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
> > > > > > >         SYS(fail,
> > > > > > > @@ -313,7 +313,7 @@ static int add_xfrm_tunnel(void)
> > > > > > >          */
> > > > > > >         SYS(fail,
> > > > > > >             "ip xfrm state add src %s dst %s proto esp "
> > > > > > > -                   "spi %d reqid 1 mode tunnel "
> > > > > > > +                   "spi %d reqid 1 mode tunnel replay-window 42 "
> > > > > > >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
> > > > > > >             IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
> > > > > > >         SYS(fail,
> > > > > > > @@ -325,7 +325,7 @@ static int add_xfrm_tunnel(void)
> > > > > > >         /* root -> at_ns0 */
> > > > > > >         SYS(fail,
> > > > > > >             "ip xfrm state add src %s dst %s proto esp "
> > > > > > > -                   "spi %d reqid 2 mode tunnel "
> > > > > > > +                   "spi %d reqid 2 mode tunnel replay-window 42 "
> > > > > > >                     "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
> > > > > > >             IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
> > > > > > >         SYS(fail,
> > > > > > > @@ -628,8 +628,10 @@ static void test_xfrm_tunnel(void)
> > > > > > >  {
> > > > > > >         DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> > > > > > >                             .attach_point = BPF_TC_INGRESS);
> > > > > > > +       LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
> > > > > > >         struct test_tunnel_kern *skel = NULL;
> > > > > > >         struct nstoken *nstoken;
> > > > > > > +       int xdp_prog_fd;
> > > > > > >         int tc_prog_fd;
> > > > > > >         int ifindex;
> > > > > > >         int err;
> > > > > > > @@ -654,6 +656,14 @@ static void test_xfrm_tunnel(void)
> > > > > > >         if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
> > > > > > >                 goto done;
> > > > > > >
> > > > > > > +       /* attach xdp prog to tunnel dev */
> > > > > > > +       xdp_prog_fd = bpf_program__fd(skel->progs.xfrm_get_state_xdp);
> > > > > > > +       if (!ASSERT_GE(xdp_prog_fd, 0, "bpf_program__fd"))
> > > > > > > +               goto done;
> > > > > > > +       err = bpf_xdp_attach(ifindex, xdp_prog_fd, XDP_FLAGS_REPLACE, &opts);
> > > > > > > +       if (!ASSERT_OK(err, "bpf_xdp_attach"))
> > > > > > > +               goto done;
> > > > > > > +
> > > > > > >         /* ping from at_ns0 namespace test */
> > > > > > >         nstoken = open_netns("at_ns0");
> > > > > > >         err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
> > > > > > > @@ -667,6 +677,8 @@ static void test_xfrm_tunnel(void)
> > > > > > >                 goto done;
> > > > > > >         if (!ASSERT_EQ(skel->bss->xfrm_remote_ip, 0xac100164, "remote_ip"))
> > > > > > >                 goto done;
> > > > > > > +       if (!ASSERT_EQ(skel->bss->xfrm_replay_window, 42, "replay_window"))
> > > > > > > +               goto done;
> > > > > > >
> > > > > > >  done:
> > > > > > >         delete_xfrm_tunnel();
> > > > > > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > index 3a59eb9c34de..c0dd38616562 100644
> > > > > > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > @@ -30,6 +30,10 @@ int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
> > > > > > >                           struct bpf_fou_encap *encap, int type) __ksym;
> > > > > > >  int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> > > > > > >                           struct bpf_fou_encap *encap) __ksym;
> > > > > > > +struct xfrm_state *
> > > > > > > +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts,
> > > > > > > +                      u32 opts__sz) __ksym;
> > > > > > > +void bpf_xdp_xfrm_state_release(struct xfrm_state *x) __ksym;
> > > > > > >
> > > > > > >  struct {
> > > > > > >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > > > > @@ -950,4 +954,51 @@ int xfrm_get_state(struct __sk_buff *skb)
> > > > > > >         return TC_ACT_OK;
> > > > > > >  }
> > > > > > >
> > > > > > > +volatile int xfrm_replay_window = 0;
> > > > > > > +
> > > > > > > +SEC("xdp")
> > > > > > > +int xfrm_get_state_xdp(struct xdp_md *xdp)
> > > > > > > +{
> > > > > > > +       struct bpf_xfrm_state_opts opts = {};
> > > > > > > +       struct xfrm_state *x = NULL;
> > > > > > > +       struct ip_esp_hdr *esph;
> > > > > > > +       struct bpf_dynptr ptr;
> > > > > > > +       u8 esph_buf[8] = {};
> > > > > > > +       u8 iph_buf[20] = {};
> > > > > > > +       struct iphdr *iph;
> > > > > > > +       u32 off;
> > > > > > > +
> > > > > > > +       if (bpf_dynptr_from_xdp(xdp, 0, &ptr))
> > > > > > > +               goto out;
> > > > > > > +
> > > > > > > +       off = sizeof(struct ethhdr);
> > > > > > > +       iph = bpf_dynptr_slice(&ptr, off, iph_buf, sizeof(iph_buf));
> > > > > > > +       if (!iph || iph->protocol != IPPROTO_ESP)
> > > > > > > +               goto out;
> > > > > > > +
> > > > > > > +       off += sizeof(struct iphdr);
> > > > > > > +       esph = bpf_dynptr_slice(&ptr, off, esph_buf, sizeof(esph_buf));
> > > > > > > +       if (!esph)
> > > > > > > +               goto out;
> > > > > > > +
> > > > > > > +       opts.netns_id = BPF_F_CURRENT_NETNS;
> > > > > > > +       opts.daddr.a4 = iph->daddr;
> > > > > > > +       opts.spi = esph->spi;
> > > > > > > +       opts.proto = IPPROTO_ESP;
> > > > > > > +       opts.family = AF_INET;
> > > > > > > +
> > > > > > > +       x = bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> > > > > > > +       if (!x || opts.error)
> > > > > >
> > > > > > nit: how can opts.error be non zero if x == NULL?
> > > > >
> > > > > Ignoring the new -ENOENT case, it can't. Which is why I'm testing that
> > > > > behavior here.
> > > >
> > > > I'm sorry, I don't understand.
> > > >
> > > > AFAICT, regardless of the -ENOENT change, I don't see
> > > > how (!x) is false and (opt.error) is true, and so
> > > > "if (!x || opts.error)" is always equivalent to "if (!x)".
> > > >
> > > > What am I missing?
> > > > Eyal.
> > >
> > > The selftests are tests so my intention was to check edge cases here.
> > > In normal operation it shouldn't be possible that
> > > bpf_xdp_get_xfrm_state() returns non-NULL and also an error. Maybe
> > > another way of writing this would be:
> > >
> > >         if (!x)
> > >                 goto out;
> > >         assert(opts.error == 0);
> > 
> > I think this would convey the "edge case testing" notion better.
> > 
> > >
> > > If I'm trying to be too clever (or maybe just wrong) or it's pointless,
> > > I can remove the `opts.error` condition.
> > 
> > At least for me the tests also serve as references as to how the
> > API is expected to be used, so I think it'd be clearer without
> > signaling that opts.error could potentially be nonzero on success.
> > 
> > An assertion would indeed make that clear.
> 
> Sure, sounds good. I will check on the new bpf assert infra.

Couldn't quite get bpf_assert() working. The following diff:

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index c0dd38616562..f00dba85ac5d 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -8,8 +8,9 @@
  */
 #include "vmlinux.h"
 #include <bpf/bpf_core_read.h>
-#include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
 #include "bpf_kfuncs.h"
 #include "bpf_tracing_net.h"

@@ -988,8 +989,9 @@ int xfrm_get_state_xdp(struct xdp_md *xdp)
        opts.family = AF_INET;

        x = bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
-       if (!x || opts.error)
+       if (!x)
                goto out;
+       bpf_assert_with(opts.error == 0, XDP_PASS);

        if (!x->replay_esn)
                goto out;

results in:

57: (b7) r1 = 2                       ; R1_w=2 refs=5
58: (85) call bpf_throw#115436
calling kernel function bpf_throw is not allowed

It looks like the above error comes from verifier.c:fetch_kfunc_meta,
but I can run the exceptions selftests just fine with the same bzImage.
So I'm thinking it's not a kfunc registration or BTF issue.

Maybe it's cuz I'm holding onto KFUNC_ACQUIRE'd `x`? Not sure.

So for now I think I'll drop checking opts.error.

[...]

