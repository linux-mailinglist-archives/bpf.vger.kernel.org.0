Return-Path: <bpf+bounces-17448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A2380DB86
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 21:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE2C1F21C6C
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067D254FAB;
	Mon, 11 Dec 2023 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="aeW1ti57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="088O33oF"
X-Original-To: bpf@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD4EA;
	Mon, 11 Dec 2023 12:20:50 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 32F8A580969;
	Mon, 11 Dec 2023 15:20:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 15:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1702326049; x=
	1702333249; bh=Xy5DWhMcuaQWz9hFzj8IU9Hd0UISUG5+/EyW9nquCao=; b=a
	eW1ti57qzoaxP6yiQ6R8Uzqrl/PgidoKozz4Oi4F0HhFC6v/EYY8CEv6EnN+19tt
	WMDFRVTyeSRIFMTUiDOeDiNKa5bVQ4xMdGqANf35W6qPGQWo1dNtTMpBaG+oR1Mg
	uz+xCU5+YccjVRyzqf9KAZo3C3cZmmx5GZpoDpwzJ+X1CDt+SAPbFyeYuu1Ohbqd
	6U9L5ECSjewM1QqaOLS9J8Ns85jcDi8btJAhwaPLTXXIK2Hm7wsEp+pbVrifkAk3
	A9FBJln3a9zOzgytPqA2C9aa+EyE7lRF99TzFVGkx+fcX8qxH+4E/dmeIrdW6k+c
	r6deCuRVQTwQ743QpxRUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702326049; x=
	1702333249; bh=Xy5DWhMcuaQWz9hFzj8IU9Hd0UISUG5+/EyW9nquCao=; b=0
	88O33oFs9OE2kSeXuCcfbIPuXTF08SvbIK63kJo7adenS35G5cIJ1X8sIgt5ENGs
	RDi5fyMwE5T4IZmUUCiEHSJ1iNRytRRA3/llORpNphsG1AxpLsvyilZb1wbWLzgb
	4vZcFZqo0B8IUT7j2oEXvlI9w5Jy7bdiCxmBdUkHz2ijSVLgrbpfPjSMi+90DC/s
	2U4B61+4CqxluOoHWBIFiRtCxQsF/0QXVF1Bs02xBf8ymzDAnHcdBQiaZFd9GGzs
	rynoEhHPfuLFjv6LrQ6XVRTvOY+wGSh7ngrYn250BAZuOSRc1DJGWSyQBugvkluX
	Vi0SBk94P5EykoLKvlI4Q==
X-ME-Sender: <xms:IG93ZflDiZHZu17F1siOQ3VKnF7SzkZgZn6pYC0TJ-zNI7SjBlGSXA>
    <xme:IG93ZS3DBSofpNMRclotQiNLlfNvnNIkDRz5ibPawVVVuAnXvU99OQalhTxeociOG
    kdSqY7WX06ZYrV2oQ>
X-ME-Received: <xmr:IG93ZVrgqvwHp_WPvd_RsUPkKQP57JPzijk06MAHqHKeAgAbtUrZuH6IZJgCC2bV8hiyeSUcV3qYKAHs94qbuF6EBHRem0HHtYEx_l1xcCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:IW93ZXnOLT6Vwk8S9VkBL1Aufd1VnURaJLkiUqt0XNxEkOlCUU_y_Q>
    <xmx:IW93Zd1j0SJNITU2HkKjR5bQb83dGRcEmmzKB5RfY8fMWPH9KVAcdg>
    <xmx:IW93ZWuvgimhpgg7RijojC_Tfcjuo8WKSxid7fE-Nt5dtDM9joje5A>
    <xmx:IW93ZYH32qoE11hM9hbqa8-cMM6TJzfV5Vz70FHhPfqafmYVjkWR7w>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:47 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	davem@davemloft.net,
	shuah@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	andrii@kernel.org,
	hawk@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	eyal.birger@gmail.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
Date: Mon, 11 Dec 2023 13:20:13 -0700
Message-ID: <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702325874.git.dxu@dxuuu.xyz>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit extends test_tunnel selftest to test the new XDP xfrm state
lookup kfunc.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/test_tunnel.c    | 20 ++++++--
 .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++++
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 2d7f8fa82ebd..fc804095d578 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -278,7 +278,7 @@ static int add_xfrm_tunnel(void)
 	SYS(fail,
 	    "ip netns exec at_ns0 "
 		"ip xfrm state add src %s dst %s proto esp "
-			"spi %d reqid 1 mode tunnel "
+			"spi %d reqid 1 mode tunnel replay-window 42 "
 			"auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
 	    IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
 	SYS(fail,
@@ -292,7 +292,7 @@ static int add_xfrm_tunnel(void)
 	SYS(fail,
 	    "ip netns exec at_ns0 "
 		"ip xfrm state add src %s dst %s proto esp "
-			"spi %d reqid 2 mode tunnel "
+			"spi %d reqid 2 mode tunnel replay-window 42 "
 			"auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
 	    IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
 	SYS(fail,
@@ -313,7 +313,7 @@ static int add_xfrm_tunnel(void)
 	 */
 	SYS(fail,
 	    "ip xfrm state add src %s dst %s proto esp "
-		    "spi %d reqid 1 mode tunnel "
+		    "spi %d reqid 1 mode tunnel replay-window 42 "
 		    "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
 	    IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
 	SYS(fail,
@@ -325,7 +325,7 @@ static int add_xfrm_tunnel(void)
 	/* root -> at_ns0 */
 	SYS(fail,
 	    "ip xfrm state add src %s dst %s proto esp "
-		    "spi %d reqid 2 mode tunnel "
+		    "spi %d reqid 2 mode tunnel replay-window 42 "
 		    "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
 	    IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
 	SYS(fail,
@@ -628,8 +628,10 @@ static void test_xfrm_tunnel(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
 			    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
 	struct test_tunnel_kern *skel = NULL;
 	struct nstoken *nstoken;
+	int xdp_prog_fd;
 	int tc_prog_fd;
 	int ifindex;
 	int err;
@@ -654,6 +656,14 @@ static void test_xfrm_tunnel(void)
 	if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
 		goto done;
 
+	/* attach xdp prog to tunnel dev */
+	xdp_prog_fd = bpf_program__fd(skel->progs.xfrm_get_state_xdp);
+	if (!ASSERT_GE(xdp_prog_fd, 0, "bpf_program__fd"))
+		goto done;
+	err = bpf_xdp_attach(ifindex, xdp_prog_fd, XDP_FLAGS_REPLACE, &opts);
+	if (!ASSERT_OK(err, "bpf_xdp_attach"))
+		goto done;
+
 	/* ping from at_ns0 namespace test */
 	nstoken = open_netns("at_ns0");
 	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
@@ -667,6 +677,8 @@ static void test_xfrm_tunnel(void)
 		goto done;
 	if (!ASSERT_EQ(skel->bss->xfrm_remote_ip, 0xac100164, "remote_ip"))
 		goto done;
+	if (!ASSERT_EQ(skel->bss->xfrm_replay_window, 42, "replay_window"))
+		goto done;
 
 done:
 	delete_xfrm_tunnel();
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3a59eb9c34de..c0dd38616562 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -30,6 +30,10 @@ int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
 			  struct bpf_fou_encap *encap, int type) __ksym;
 int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
 			  struct bpf_fou_encap *encap) __ksym;
+struct xfrm_state *
+bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts,
+		       u32 opts__sz) __ksym;
+void bpf_xdp_xfrm_state_release(struct xfrm_state *x) __ksym;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -950,4 +954,51 @@ int xfrm_get_state(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
+volatile int xfrm_replay_window = 0;
+
+SEC("xdp")
+int xfrm_get_state_xdp(struct xdp_md *xdp)
+{
+	struct bpf_xfrm_state_opts opts = {};
+	struct xfrm_state *x = NULL;
+	struct ip_esp_hdr *esph;
+	struct bpf_dynptr ptr;
+	u8 esph_buf[8] = {};
+	u8 iph_buf[20] = {};
+	struct iphdr *iph;
+	u32 off;
+
+	if (bpf_dynptr_from_xdp(xdp, 0, &ptr))
+		goto out;
+
+	off = sizeof(struct ethhdr);
+	iph = bpf_dynptr_slice(&ptr, off, iph_buf, sizeof(iph_buf));
+	if (!iph || iph->protocol != IPPROTO_ESP)
+		goto out;
+
+	off += sizeof(struct iphdr);
+	esph = bpf_dynptr_slice(&ptr, off, esph_buf, sizeof(esph_buf));
+	if (!esph)
+		goto out;
+
+	opts.netns_id = BPF_F_CURRENT_NETNS;
+	opts.daddr.a4 = iph->daddr;
+	opts.spi = esph->spi;
+	opts.proto = IPPROTO_ESP;
+	opts.family = AF_INET;
+
+	x = bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
+	if (!x || opts.error)
+		goto out;
+
+	if (!x->replay_esn)
+		goto out;
+
+	xfrm_replay_window = x->replay_esn->replay_window;
+out:
+	if (x)
+		bpf_xdp_xfrm_state_release(x);
+	return XDP_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.1


