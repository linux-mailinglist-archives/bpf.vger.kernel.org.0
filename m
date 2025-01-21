Return-Path: <bpf+bounces-49333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A949BA1768E
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 05:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4231888411
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 04:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF81AAA02;
	Tue, 21 Jan 2025 04:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="VNzQwPI4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7UykF9W"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20491A4F0A;
	Tue, 21 Jan 2025 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737434135; cv=none; b=d9Q9Elp+u5WIt8e93Ij7LT2+c/EO1kcCxz8amAG6QQ6mrae8D4ctWHTT1ABegGZJpgG1GLW45BvQdH/US40DlyUOVu6WnOyuhMxF9xgrg4awXvvPoWSUvADlRA10C7d+Wkj/7f+96HgPLG/EZCijIZXrtxq71fMXx4D9gIp4iB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737434135; c=relaxed/simple;
	bh=AWT6UplJsuwd3Z1amd6LIjTyP84SpScj+bGO3VyIbJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvxhxZijFylQR8z44evSJjwSWzA7t6MseWdvBjt32AbPBCLQKCcQZB2FoB4dMhhlOAbI73rXna3UMt/qEPkgWUMdkziLH1XOGO4MBiSJGJCVihvwIms7l18Mv0EsjKoVN6fXcJpcdYWy/8d2k9Ur5ZotnE6Ev8wafqszPHsPT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=VNzQwPI4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d7UykF9W; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id A0055201296;
	Mon, 20 Jan 2025 23:35:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 20 Jan 2025 23:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737434132; x=
	1737441332; bh=EuqqOj/JE/BXRgo4FV0CYOWoLTXMMcc6C+q/QgacqSc=; b=V
	NzQwPI45itkIfm7FMr02QLiNF/FIxeRPwv5cYz9vW/qL+QM/TV8kU59EWUv8HR0T
	J0wNWyN4WfHvgwNtgo+tlWkkbMdZrcxk8M18sP+YHWtJNtaFrSBnoSRvosP4VW9L
	wVGHOhupBlHleo9RJDcinFj9HzP5/yijn/tpGzX/uts15zDiT2PZOVsNZWM5hrAm
	8SCDVpldyE/865f4IrJR/QuvOJ9qGkSEBO8nPo6/Qytz/+IsD0sn55GiIM+rOB03
	7llPQ03q6J/Iv2KovM6nGBXTl7WJL4y4CDW0jZgIYs9cpxHOdQI4ac5i3dlAhyiS
	rGdCDPu5PapGGSbpuISKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1737434132; x=1737441332; bh=E
	uqqOj/JE/BXRgo4FV0CYOWoLTXMMcc6C+q/QgacqSc=; b=d7UykF9WoPjVYzhEs
	nzNHGB0EtNBA1jNgsdmLIKcNu/famaq+oR6eIdh098hlLTCsYHI/QYQB51J3aV8e
	s0MNUrduJchkPJBEMDY7TB+hESi/+fZrDXN+N09livksHCbQ73cGsBBxyzFMuH+w
	liEqCEsAUQkstRQjWcIwNj1tScqjMTE8rUB5bCndkXlIH2AdRdoBLYsXzXUhDWFF
	9uchp1ZkjtgJl2RCnB6ACbf0HXRFLN6IQHSSM8+VJ89PXXK4MzzAtNW2P/DI4mij
	2M+hiU9tlTfuqO53RbPRMzyFCyi3bEHF5TwMSqx6mVb5ihiq+HY2e7UPraH7kIXc
	o7rLw==
X-ME-Sender: <xms:FCSPZ2TE5CUTbLnxa_btmsaPvjgfbcYYMwQFncGS8TGQGkUQ8q3v0Q>
    <xme:FCSPZ7yS_7Y2642QL5IKWWgr3yG9YjmTAYocUq1fO7HWboXE8P1gCV2momTxX8Jqe
    5L3n2NunulUB8EMMw>
X-ME-Received: <xmr:FCSPZz26Vs0T9kIElZcqKzC6bzPWIHeFD2wFAhFW6YqJYKjyBPqIQDQQnDh3lk0drR9jGj4WVyUatBh1ABA6F2h9azust5jxjMUhk4CHgE72QbDyaskY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejtddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepvdehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhusg
    grsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhgrtghivghjrdhfihhjrghlkhhofihskhhisehinhhtvghlrdgtoh
    hmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhm
    rgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrg
    hrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
    pdhrtghpthhtohepsghjohhrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FCSPZyCGXzRaCAQPFr8kJjCrzsi8cJ3WF7eN5OdxAMaOgJoOBTu5yA>
    <xmx:FCSPZ_if8MDFAo4dTJwKIrkDXjZnrW3xP--GoV9hJzAbVVsq69T70g>
    <xmx:FCSPZ-qIs1-XUFz0H09gID2Kh_YMH89Jxvdi0p0e37XkPruJyTRpEg>
    <xmx:FCSPZygZyaK7zhY3kp27-DmSoEHBhjhJfJRXa6YBC9xaGHgAu8ev2Q>
    <xmx:FCSPZ6TgJzwM4B4TodBRPNjXCXTzTdN1mDtonM7hYCpieuuHiHREJe09>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 23:35:29 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: pabeni@redhat.com,
	kuba@kernel.org,
	hawk@kernel.org,
	maciej.fijalkowski@intel.com,
	ast@kernel.org,
	edumazet@google.com,
	daniel@iogearbox.net,
	davem@davemloft.net,
	bjorn@kernel.org,
	john.fastabend@gmail.com,
	magnus.karlsson@intel.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jonathan.lemon@gmail.com,
	horms@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 2/3] bpf: map: Thread null elision metadata to map_gen_lookup
Date: Mon, 20 Jan 2025 21:35:11 -0700
Message-ID: <2050196010b1bf1efa357cfddebd15a152582bb4.1737433945.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737433945.git.dxu@dxuuu.xyz>
References: <cover.1737433945.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an extra parameter to map_gen_lookup callback so that if the lookup
is known to be inbounds, the bounds check can be omitted.

The next commit will take advantage of this new information.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf.h   |  2 +-
 kernel/bpf/arraymap.c | 11 ++++++++---
 kernel/bpf/hashtab.c  | 14 ++++++++++----
 kernel/bpf/verifier.c |  2 +-
 net/xdp/xskmap.c      |  4 +++-
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index feda0ce90f5a..da8b420095c9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -117,7 +117,7 @@ struct bpf_map_ops {
 	 * may manipulate it, exists.
 	 */
 	void (*map_fd_put_ptr)(struct bpf_map *map, void *ptr, bool need_defer);
-	int (*map_gen_lookup)(struct bpf_map *map, struct bpf_insn *insn_buf);
+	int (*map_gen_lookup)(struct bpf_map *map, struct bpf_insn *insn_buf, bool inbounds);
 	u32 (*map_fd_sys_lookup_elem)(void *ptr);
 	void (*map_seq_show_elem)(struct bpf_map *map, void *key,
 				  struct seq_file *m);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index eb28c0f219ee..8dbdceeead95 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -205,7 +205,9 @@ static int array_map_direct_value_meta(const struct bpf_map *map, u64 imm,
 }
 
 /* emit BPF instructions equivalent to C code of array_map_lookup_elem() */
-static int array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+static int array_map_gen_lookup(struct bpf_map *map,
+				struct bpf_insn *insn_buf,
+				bool inbounds)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	struct bpf_insn *insn = insn_buf;
@@ -250,7 +252,9 @@ static void *percpu_array_map_lookup_elem(struct bpf_map *map, void *key)
 }
 
 /* emit BPF instructions equivalent to C code of percpu_array_map_lookup_elem() */
-static int percpu_array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+static int percpu_array_map_gen_lookup(struct bpf_map *map,
+				       struct bpf_insn *insn_buf,
+				       bool inbounds)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	struct bpf_insn *insn = insn_buf;
@@ -1392,7 +1396,8 @@ static void *array_of_map_lookup_elem(struct bpf_map *map, void *key)
 }
 
 static int array_of_map_gen_lookup(struct bpf_map *map,
-				   struct bpf_insn *insn_buf)
+				   struct bpf_insn *insn_buf,
+				   bool inbounds)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 elem_size = array->elem_size;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4a9eeb7aef85..103cdab85977 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -720,7 +720,9 @@ static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
  * bpf_prog
  *   __htab_map_lookup_elem
  */
-static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+static int htab_map_gen_lookup(struct bpf_map *map,
+			       struct bpf_insn *insn_buf,
+			       bool inbounds)
 {
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
@@ -760,7 +762,8 @@ static void *htab_lru_map_lookup_elem_sys(struct bpf_map *map, void *key)
 }
 
 static int htab_lru_map_gen_lookup(struct bpf_map *map,
-				   struct bpf_insn *insn_buf)
+				   struct bpf_insn *insn_buf,
+				   bool inbounds)
 {
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
@@ -2342,7 +2345,9 @@ static void *htab_percpu_map_lookup_elem(struct bpf_map *map, void *key)
 }
 
 /* inline bpf_map_lookup_elem() call for per-CPU hashmap */
-static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+static int htab_percpu_map_gen_lookup(struct bpf_map *map,
+				      struct bpf_insn *insn_buf,
+				      bool inbounds)
 {
 	struct bpf_insn *insn = insn_buf;
 
@@ -2626,7 +2631,8 @@ static void *htab_of_map_lookup_elem(struct bpf_map *map, void *key)
 }
 
 static int htab_of_map_gen_lookup(struct bpf_map *map,
-				  struct bpf_insn *insn_buf)
+				  struct bpf_insn *insn_buf,
+				  bool inbounds)
 {
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e83145c2260d..2ed2fd3c42f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21582,7 +21582,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			ops = map_ptr->ops;
 			if (insn->imm == BPF_FUNC_map_lookup_elem &&
 			    ops->map_gen_lookup) {
-				cnt = ops->map_gen_lookup(map_ptr, insn_buf);
+				cnt = ops->map_gen_lookup(map_ptr, insn_buf, aux->map_ptr_state.inbounds);
 				if (cnt == -EOPNOTSUPP)
 					goto patch_map_ops_generic;
 				if (cnt <= 0 || cnt >= INSN_BUF_SIZE) {
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index afa457506274..78579583b0a1 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -118,7 +118,9 @@ static int xsk_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	return 0;
 }
 
-static int xsk_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+static int xsk_map_gen_lookup(struct bpf_map *map,
+			      struct bpf_insn *insn_buf,
+			      bool inbounds)
 {
 	const int ret = BPF_REG_0, mp = BPF_REG_1, index = BPF_REG_2;
 	struct bpf_insn *insn = insn_buf;
-- 
2.47.1


