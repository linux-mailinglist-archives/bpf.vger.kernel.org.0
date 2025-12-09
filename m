Return-Path: <bpf+bounces-76323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94884CAE828
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 01:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 559EC3091CEE
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 00:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA627E045;
	Tue,  9 Dec 2025 00:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/gNLRbl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0427A442;
	Tue,  9 Dec 2025 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239459; cv=none; b=K9IOQZjo1Tg1NsEBv4XoAnPCz77WF8aaNYvmCS6J0pL2V6wZzJTHUR1NTi91eJPCDBfGeUudpvIF5cdVAAgJ+nD86aV0k9r+CF8h9l1QSoUoXrboYZ+qBCD2qxAm6dr8GvXHI2S5zBn5WxnJdGb42fl8HmEeLZHBeMFOvSNS7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239459; c=relaxed/simple;
	bh=v3OkS3q1l6uqmIpy47zLwVGi9HE8EN+dH7fJhgzl8H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHplONAjOz7zvySeZwUPoLBy0lXLBFQlcq0aujUKc66S9yrFpOZMnLVwBGCgFtLE23NISqwV++WC5zMnDOd1kR57I9vgQQwAGTcPGDW0tX1GgMDlmziBMJegAqWpQW6elwMnY5eN1GdFj3Gb0BYUCsa5LhAOb1aqPczIjmhivkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/gNLRbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A31DC113D0;
	Tue,  9 Dec 2025 00:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239459;
	bh=v3OkS3q1l6uqmIpy47zLwVGi9HE8EN+dH7fJhgzl8H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/gNLRblWBMSgdVzG4tuP+tUsp0otuqSRssbXmQ+NMcxJqUHrqYF73BrEfdcC3KKf
	 w9CYDARtGzN0wNdWGhRJ9DbRFwZoZXAgG7qsYNs540aum978AbMUIQSMoB+DgxJJ8u
	 Iotz6XDqf6t5bzHM0JpmRGMV7LJo9isz+j27+MpMxcpJ3rvoV7vfI6NUmTBMi1xsMZ
	 jyjLX/nEMT2A/50CIoY7AjDrVAvbj4Q8BqUyA3byiAIVIkb0Mt+zhcA9ScMQUpwSIm
	 l0KCYDPQRxZm7IEMZKo+IkXsKHMSz1KaeIKmz97nMT+kv040cJR72mum2NufbG15qi
	 U+BwXsU453Ktw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kees@kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] cxgb4: Rename sched_class to avoid type clash
Date: Mon,  8 Dec 2025 19:15:20 -0500
Message-ID: <20251209001610.611575-28-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209001610.611575-1-sashal@kernel.org>
References: <20251209001610.611575-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alan Maguire <alan.maguire@oracle.com>

[ Upstream commit 380d19db6e6c089c7d2902e02a85fd2bde3e519b ]

drivers/net/ethernet/chelsio/cxgb4/sched.h declares a sched_class
struct which has a type name clash with struct sched_class
in kernel/sched/sched.h (a type used in a field in task_struct).

When cxgb4 is a builtin we end up with both sched_class types,
and as a result of this we wind up with DWARF (and derived from
that BTF) with a duplicate incorrect task_struct representation.
When cxgb4 is built-in this type clash can cause kernel builds to
fail as resolve_btfids will fail when confused which task_struct
to use. See [1] for more details.

As such, renaming sched_class to ch_sched_class (in line with
other structs like ch_sched_flowc) makes sense.

[1] https://lore.kernel.org/bpf/2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org/

Reported-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Potnuri Bharat Teja <bharat@chelsio.com>
Link: https://patch.msgid.link/20251121181231.64337-1-alan.maguire@oracle.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Commit Analysis: cxgb4 sched_class rename

### 1. COMMIT MESSAGE ANALYSIS

The commit addresses a **type name clash** between:
- `struct sched_class` in `drivers/net/ethernet/chelsio/cxgb4/sched.h`
  (cxgb4 driver's scheduling class)
- `struct sched_class` in `kernel/sched/sched.h` (core scheduler's
  scheduling class used in task_struct)

**Problem:** When cxgb4 is built-in (CONFIG_CHELSIO_T4=y), both types
exist in the same compilation unit. This causes:
1. Duplicate DWARF/BTF type representations
2. **Build failures** because `resolve_btfids` tool cannot determine
   which `task_struct` to use

**Signals:**
- **Reported-by:** Bart Van Assche (real user hit this issue)
- **Reviewed-by/Acked-by:** Present from both reporter and driver
  maintainer
- **Link:** References actual bug report on lore.kernel.org
- **No Cc: stable** tag
- **No Fixes:** tag

### 2. CODE CHANGE ANALYSIS

The fix is purely mechanical - a simple rename:
- `struct sched_class` → `struct ch_sched_class` (following existing
  naming convention like `ch_sched_flowc`)

Changes across 5 files are all straightforward variable type name
replacements. The diff shows ~20 locations where the type name is
changed, with absolutely no logic modifications.

### 3. CLASSIFICATION

This is a **BUILD FIX** - one of the explicitly allowed categories for
stable backporting. The build fails when:
- cxgb4 driver is built-in
- BTF debugging is enabled (CONFIG_DEBUG_INFO_BTF=y)

The `resolve_btfids` tool fails, preventing successful kernel
compilation.

### 4. SCOPE AND RISK ASSESSMENT

| Metric | Assessment |
|--------|------------|
| Lines changed | ~40 (all renames) |
| Files touched | 5 (all within cxgb4 driver) |
| Logic changes | **ZERO** |
| External API changes | **NONE** |
| Runtime risk | **NONE** - purely compile-time symbol naming |

**Risk Level: EXTREMELY LOW** - This cannot cause any runtime regression
as it's purely a symbol rename with no behavioral changes whatsoever.

### 5. USER IMPACT

**Affected users:**
- Those building kernels with cxgb4 built-in AND BTF enabled
- This is a realistic configuration for users doing BPF/tracing work
  with Chelsio network hardware

**Severity:** BUILD FAILURE - Complete inability to compile the kernel
for affected configurations.

### 6. STABILITY INDICATORS

- Has Reviewed-by and Acked-by tags
- Change is mechanical and obviously correct
- Merged through proper netdev maintainer path
- The naming follows existing driver conventions (`ch_sched_*`)

### 7. DEPENDENCY CHECK

The change is self-contained within the cxgb4 driver. No external
dependencies. The cxgb4 scheduler code has existed in stable trees for
years, so this fix should apply cleanly.

### Decision Analysis

**FOR backporting:**
1. **Build fix** - explicitly allowed in stable rules
2. **Zero runtime risk** - purely a type rename, no logic changes
3. **Fixes real bug** - reported by actual user, blocks compilation
4. **Small and contained** - all changes within one driver
5. **Obviously correct** - mechanical rename following existing
   conventions

**AGAINST backporting:**
1. No `Cc: stable` tag from maintainer
2. Affected configuration (built-in cxgb4 + BTF) is somewhat niche
3. Issue may only manifest with newer toolchains

### Conclusion

While the maintainer didn't add `Cc: stable`, this is a **legitimate
build fix** that prevents kernel compilation for users with specific
(but valid) configurations. Build fixes are explicitly listed as
acceptable stable material in the kernel's stable rules. The change is
mechanical, trivial, and carries effectively zero risk of any
regression. Users who update their build toolchain on stable kernels
could encounter this failure.

The risk/benefit ratio strongly favors backporting: **zero risk** vs
**fixing build failures**.

**YES**

 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
 .../chelsio/cxgb4/cxgb4_tc_matchall.c         |  4 +-
 .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c  |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/sched.c    | 44 +++++++++----------
 drivers/net/ethernet/chelsio/cxgb4/sched.h    | 12 ++---
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 392723ef14e51..ac0c7fe5743bd 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3485,7 +3485,7 @@ static int cxgb_set_tx_maxrate(struct net_device *dev, int index, u32 rate)
 	struct adapter *adap = pi->adapter;
 	struct ch_sched_queue qe = { 0 };
 	struct ch_sched_params p = { 0 };
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	u32 req_rate;
 	int err = 0;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
index 1672d3afe5bef..f8dcf0b4abcdc 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
@@ -56,7 +56,7 @@ static int cxgb4_matchall_egress_validate(struct net_device *dev,
 	struct port_info *pi = netdev2pinfo(dev);
 	struct flow_action_entry *entry;
 	struct ch_sched_queue qe;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	u64 max_link_rate;
 	u32 i, speed;
 	int ret;
@@ -180,7 +180,7 @@ static int cxgb4_matchall_alloc_tc(struct net_device *dev,
 	struct port_info *pi = netdev2pinfo(dev);
 	struct adapter *adap = netdev2adap(dev);
 	struct flow_action_entry *entry;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int ret;
 	u32 i;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
index 338b04f339b3d..a2dcd2e242631 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
@@ -330,7 +330,7 @@ static int cxgb4_mqprio_alloc_tc(struct net_device *dev,
 	struct cxgb4_tc_port_mqprio *tc_port_mqprio;
 	struct port_info *pi = netdev2pinfo(dev);
 	struct adapter *adap = netdev2adap(dev);
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int ret;
 	u8 i;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sched.c b/drivers/net/ethernet/chelsio/cxgb4/sched.c
index a1b14468d1fff..38a30aeee1220 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sched.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sched.c
@@ -44,7 +44,7 @@ static int t4_sched_class_fw_cmd(struct port_info *pi,
 {
 	struct adapter *adap = pi->adapter;
 	struct sched_table *s = pi->sched_tbl;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int err = 0;
 
 	e = &s->tab[p->u.params.class];
@@ -122,7 +122,7 @@ static void *t4_sched_entry_lookup(struct port_info *pi,
 				   const u32 val)
 {
 	struct sched_table *s = pi->sched_tbl;
-	struct sched_class *e, *end;
+	struct ch_sched_class *e, *end;
 	void *found = NULL;
 
 	/* Look for an entry with matching @val */
@@ -166,8 +166,8 @@ static void *t4_sched_entry_lookup(struct port_info *pi,
 	return found;
 }
 
-struct sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
-					     struct ch_sched_queue *p)
+struct ch_sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
+						struct ch_sched_queue *p)
 {
 	struct port_info *pi = netdev2pinfo(dev);
 	struct sched_queue_entry *qe = NULL;
@@ -187,7 +187,7 @@ static int t4_sched_queue_unbind(struct port_info *pi, struct ch_sched_queue *p)
 	struct sched_queue_entry *qe = NULL;
 	struct adapter *adap = pi->adapter;
 	struct sge_eth_txq *txq;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int err = 0;
 
 	if (p->queue < 0 || p->queue >= pi->nqsets)
@@ -218,7 +218,7 @@ static int t4_sched_queue_bind(struct port_info *pi, struct ch_sched_queue *p)
 	struct sched_queue_entry *qe = NULL;
 	struct adapter *adap = pi->adapter;
 	struct sge_eth_txq *txq;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	unsigned int qid;
 	int err = 0;
 
@@ -260,7 +260,7 @@ static int t4_sched_flowc_unbind(struct port_info *pi, struct ch_sched_flowc *p)
 {
 	struct sched_flowc_entry *fe = NULL;
 	struct adapter *adap = pi->adapter;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int err = 0;
 
 	if (p->tid < 0 || p->tid >= adap->tids.neotids)
@@ -288,7 +288,7 @@ static int t4_sched_flowc_bind(struct port_info *pi, struct ch_sched_flowc *p)
 	struct sched_table *s = pi->sched_tbl;
 	struct sched_flowc_entry *fe = NULL;
 	struct adapter *adap = pi->adapter;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int err = 0;
 
 	if (p->tid < 0 || p->tid >= adap->tids.neotids)
@@ -322,7 +322,7 @@ static int t4_sched_flowc_bind(struct port_info *pi, struct ch_sched_flowc *p)
 }
 
 static void t4_sched_class_unbind_all(struct port_info *pi,
-				      struct sched_class *e,
+				      struct ch_sched_class *e,
 				      enum sched_bind_type type)
 {
 	if (!e)
@@ -476,12 +476,12 @@ int cxgb4_sched_class_unbind(struct net_device *dev, void *arg,
 }
 
 /* If @p is NULL, fetch any available unused class */
-static struct sched_class *t4_sched_class_lookup(struct port_info *pi,
-						const struct ch_sched_params *p)
+static struct ch_sched_class *t4_sched_class_lookup(struct port_info *pi,
+						    const struct ch_sched_params *p)
 {
 	struct sched_table *s = pi->sched_tbl;
-	struct sched_class *found = NULL;
-	struct sched_class *e, *end;
+	struct ch_sched_class *found = NULL;
+	struct ch_sched_class *e, *end;
 
 	if (!p) {
 		/* Get any available unused class */
@@ -522,10 +522,10 @@ static struct sched_class *t4_sched_class_lookup(struct port_info *pi,
 	return found;
 }
 
-static struct sched_class *t4_sched_class_alloc(struct port_info *pi,
-						struct ch_sched_params *p)
+static struct ch_sched_class *t4_sched_class_alloc(struct port_info *pi,
+						   struct ch_sched_params *p)
 {
-	struct sched_class *e = NULL;
+	struct ch_sched_class *e = NULL;
 	u8 class_id;
 	int err;
 
@@ -579,8 +579,8 @@ static struct sched_class *t4_sched_class_alloc(struct port_info *pi,
  * scheduling class with matching @p is found, then the matching class is
  * returned.
  */
-struct sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
-					    struct ch_sched_params *p)
+struct ch_sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
+					       struct ch_sched_params *p)
 {
 	struct port_info *pi = netdev2pinfo(dev);
 	u8 class_id;
@@ -607,7 +607,7 @@ void cxgb4_sched_class_free(struct net_device *dev, u8 classid)
 	struct port_info *pi = netdev2pinfo(dev);
 	struct sched_table *s = pi->sched_tbl;
 	struct ch_sched_params p;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	u32 speed;
 	int ret;
 
@@ -640,7 +640,7 @@ void cxgb4_sched_class_free(struct net_device *dev, u8 classid)
 	}
 }
 
-static void t4_sched_class_free(struct net_device *dev, struct sched_class *e)
+static void t4_sched_class_free(struct net_device *dev, struct ch_sched_class *e)
 {
 	struct port_info *pi = netdev2pinfo(dev);
 
@@ -660,7 +660,7 @@ struct sched_table *t4_init_sched(unsigned int sched_size)
 	s->sched_size = sched_size;
 
 	for (i = 0; i < s->sched_size; i++) {
-		memset(&s->tab[i], 0, sizeof(struct sched_class));
+		memset(&s->tab[i], 0, sizeof(struct ch_sched_class));
 		s->tab[i].idx = i;
 		s->tab[i].state = SCHED_STATE_UNUSED;
 		INIT_LIST_HEAD(&s->tab[i].entry_list);
@@ -682,7 +682,7 @@ void t4_cleanup_sched(struct adapter *adap)
 			continue;
 
 		for (i = 0; i < s->sched_size; i++) {
-			struct sched_class *e;
+			struct ch_sched_class *e;
 
 			e = &s->tab[i];
 			if (e->state == SCHED_STATE_ACTIVE)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sched.h b/drivers/net/ethernet/chelsio/cxgb4/sched.h
index 6b3c778815f09..4d3b5a7575366 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sched.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/sched.h
@@ -71,7 +71,7 @@ struct sched_flowc_entry {
 	struct ch_sched_flowc param;
 };
 
-struct sched_class {
+struct ch_sched_class {
 	u8 state;
 	u8 idx;
 	struct ch_sched_params info;
@@ -82,7 +82,7 @@ struct sched_class {
 
 struct sched_table {      /* per port scheduling table */
 	u8 sched_size;
-	struct sched_class tab[] __counted_by(sched_size);
+	struct ch_sched_class tab[] __counted_by(sched_size);
 };
 
 static inline bool can_sched(struct net_device *dev)
@@ -103,15 +103,15 @@ static inline bool valid_class_id(struct net_device *dev, u8 class_id)
 	return true;
 }
 
-struct sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
-					     struct ch_sched_queue *p);
+struct ch_sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
+						struct ch_sched_queue *p);
 int cxgb4_sched_class_bind(struct net_device *dev, void *arg,
 			   enum sched_bind_type type);
 int cxgb4_sched_class_unbind(struct net_device *dev, void *arg,
 			     enum sched_bind_type type);
 
-struct sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
-					    struct ch_sched_params *p);
+struct ch_sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
+					       struct ch_sched_params *p);
 void cxgb4_sched_class_free(struct net_device *dev, u8 classid);
 
 struct sched_table *t4_init_sched(unsigned int size);
-- 
2.51.0


