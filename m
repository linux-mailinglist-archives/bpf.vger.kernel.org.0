Return-Path: <bpf+bounces-10845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82C07AE55A
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 07:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D25361C2094B
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538B84C7D;
	Tue, 26 Sep 2023 05:59:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215C441D;
	Tue, 26 Sep 2023 05:59:38 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0CBDE;
	Mon, 25 Sep 2023 22:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oBb5UKfDN/K2n4cnPROjeyvrHqwxMGowe6DxdMT/pLA=; b=Uqi0LnAxZOXfaAon57pvNyGNz9
	ZXJ3dJ9GWwyTmW3WI+6qYnpdfSMES4bsPqCwEJf4hESrCbR9rxoiY3PIRYW6Ycke4SmwmPwHj3ODo
	SwH8nFvjn6sbQF+IIugQbv4PUtW12LduAXxSbX/yJk8eGS8cn79G6mjAJPGrmmaKas+4bBdRUeZNn
	91tWENOeGxsAdMDzyZZzC3Ek9VBcyG1Enfrilk/L4Xle+sA23gid19u1IuG6+njk93ACZVQaiR4T1
	Y7y7aC+Nx5klSuRMOY8Berc0zPfZNNpyzPRg9yS1ftyPeXAoz6qev8XkVBKvz6CzVuqPQqyTZAfK2
	lpnucJfg==;
Received: from mob-194-230-148-205.cgn.sunrise.net ([194.230.148.205] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ql16c-0006n7-8n; Tue, 26 Sep 2023 07:59:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@kernel.org,
	razor@blackwall.org,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 2/8] meta, bpf: Add bpf link support for meta device
Date: Tue, 26 Sep 2023 07:59:07 +0200
Message-Id: <20230926055913.9859-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230926055913.9859-1-daniel@iogearbox.net>
References: <20230926055913.9859-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27042/Mon Sep 25 09:37:53 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This adds BPF link support for meta device (BPF_LINK_TYPE_META). Similar
as with tcx or XDP, the BPF link for meta contains the device.

The bpf_mprog API has been reused for its implementation. For details, see
also commit e420bed0250 ("bpf: Add fd-based tcx multi-prog infra with link
support").

This is now the second user of bpf_mprog after tcx, and in meta case the
implementation is also a bit more straight forward since it does not need
to deal with miniq.

The UAPI extensions for the BPF_LINK_CREATE command are similar as for tcx,
that is, relative_{fd,id} and expected_revision.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/net/meta.c             | 211 ++++++++++++++++++++++++++++++++-
 include/net/meta.h             |   7 ++
 include/uapi/linux/bpf.h       |  11 ++
 kernel/bpf/syscall.c           |   2 +-
 tools/include/uapi/linux/bpf.h |  11 ++
 5 files changed, 240 insertions(+), 2 deletions(-)

diff --git a/drivers/net/meta.c b/drivers/net/meta.c
index e464f547b0a6..8cb39281c455 100644
--- a/drivers/net/meta.c
+++ b/drivers/net/meta.c
@@ -27,6 +27,11 @@ struct meta {
 	u32 headroom;
 };
 
+struct meta_link {
+	struct bpf_link link;
+	struct net_device *dev;
+};
+
 static void meta_scrub_minimum(struct sk_buff *skb)
 {
 	skb->skb_iif = 0;
@@ -576,6 +581,207 @@ int meta_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 	return ret;
 }
 
+static struct meta_link *meta_link(struct bpf_link *link)
+{
+	return container_of(link, struct meta_link, link);
+}
+
+static const struct meta_link *meta_link_const(const struct bpf_link *link)
+{
+	return meta_link((struct bpf_link *)link);
+}
+
+static int meta_link_prog_attach(struct bpf_link *link, u32 flags,
+				 u32 id_or_fd, u64 revision)
+{
+	struct meta_link *meta = meta_link(link);
+	struct bpf_mprog_entry *entry, *entry_new;
+	struct net_device *dev = meta->dev;
+	int ret;
+
+	ASSERT_RTNL();
+	entry = meta_entry_fetch(dev, true);
+	ret = bpf_mprog_attach(entry, &entry_new, link->prog, link, NULL, flags,
+			       id_or_fd, revision);
+	if (!ret) {
+		if (entry != entry_new) {
+			meta_entry_update(dev, entry_new);
+			meta_entry_sync();
+		}
+		bpf_mprog_commit(entry);
+	}
+	return ret;
+}
+
+static void meta_link_release(struct bpf_link *link)
+{
+	struct meta_link *meta = meta_link(link);
+	struct bpf_mprog_entry *entry, *entry_new;
+	struct net_device *dev;
+	int ret = 0;
+
+	rtnl_lock();
+	dev = meta->dev;
+	if (!dev)
+		goto out;
+	entry = meta_entry_fetch(dev, false);
+	if (!entry) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 0, 0);
+	if (!ret) {
+		if (!bpf_mprog_total(entry_new))
+			entry_new = NULL;
+		meta_entry_update(dev, entry_new);
+		meta_entry_sync();
+		bpf_mprog_commit(entry);
+		meta->dev = NULL;
+	}
+out:
+	WARN_ON_ONCE(ret);
+	rtnl_unlock();
+}
+
+static int meta_link_update(struct bpf_link *link, struct bpf_prog *nprog,
+			    struct bpf_prog *oprog)
+{
+	struct meta_link *meta = meta_link(link);
+	struct bpf_mprog_entry *entry, *entry_new;
+	struct net_device *dev;
+	int ret = 0;
+
+	rtnl_lock();
+	dev = meta->dev;
+	if (!dev) {
+		ret = -ENOLINK;
+		goto out;
+	}
+	if (oprog && link->prog != oprog) {
+		ret = -EPERM;
+		goto out;
+	}
+	oprog = link->prog;
+	if (oprog == nprog) {
+		bpf_prog_put(nprog);
+		goto out;
+	}
+	entry = meta_entry_fetch(dev, false);
+	if (!entry) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = bpf_mprog_attach(entry, &entry_new, nprog, link, oprog,
+			       BPF_F_REPLACE | BPF_F_ID,
+			       link->prog->aux->id, 0);
+	if (!ret) {
+		WARN_ON_ONCE(entry != entry_new);
+		oprog = xchg(&link->prog, nprog);
+		bpf_prog_put(oprog);
+		bpf_mprog_commit(entry);
+	}
+out:
+	rtnl_unlock();
+	return ret;
+}
+
+static void meta_link_dealloc(struct bpf_link *link)
+{
+	kfree(meta_link(link));
+}
+
+static void meta_link_fdinfo(const struct bpf_link *link, struct seq_file *seq)
+{
+	const struct meta_link *meta = meta_link_const(link);
+	u32 ifindex = 0;
+
+	rtnl_lock();
+	if (meta->dev)
+		ifindex = meta->dev->ifindex;
+	rtnl_unlock();
+
+	seq_printf(seq, "ifindex:\t%u\n", ifindex);
+}
+
+static int meta_link_fill_info(const struct bpf_link *link,
+			       struct bpf_link_info *info)
+{
+	const struct meta_link *meta = meta_link_const(link);
+	u32 ifindex = 0;
+
+	rtnl_lock();
+	if (meta->dev)
+		ifindex = meta->dev->ifindex;
+	rtnl_unlock();
+
+	info->meta.ifindex = ifindex;
+	return 0;
+}
+
+static int meta_link_detach(struct bpf_link *link)
+{
+	meta_link_release(link);
+	return 0;
+}
+
+static const struct bpf_link_ops meta_link_lops = {
+	.release	= meta_link_release,
+	.detach		= meta_link_detach,
+	.dealloc	= meta_link_dealloc,
+	.update_prog	= meta_link_update,
+	.show_fdinfo	= meta_link_fdinfo,
+	.fill_link_info	= meta_link_fill_info,
+};
+
+static int meta_link_init(struct meta_link *meta,
+			  struct bpf_link_primer *link_primer,
+			  struct net_device *dev, struct bpf_prog *prog)
+{
+	bpf_link_init(&meta->link, BPF_LINK_TYPE_META, &meta_link_lops, prog);
+	meta->dev = dev;
+	return bpf_link_prime(&meta->link, link_primer);
+}
+
+int meta_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct bpf_link_primer link_primer;
+	struct net_device *dev;
+	struct meta_link *meta;
+	int ret;
+
+	rtnl_lock();
+	dev = meta_dev_fetch(current->nsproxy->net_ns,
+			     attr->link_create.target_ifindex,
+			     attr->link_create.attach_type);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		goto out;
+	}
+	meta = kzalloc(sizeof(*meta), GFP_USER);
+	if (!meta) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = meta_link_init(meta, &link_primer, dev, prog);
+	if (ret) {
+		kfree(meta);
+		goto out;
+	}
+	ret = meta_link_prog_attach(&meta->link,
+				    attr->link_create.flags,
+				    attr->link_create.meta.relative_fd,
+				    attr->link_create.meta.expected_revision);
+	if (ret) {
+		meta->dev = NULL;
+		bpf_link_cleanup(&link_primer);
+		goto out;
+	}
+	ret = bpf_link_settle(&link_primer);
+out:
+	rtnl_unlock();
+	return ret;
+}
+
 static void meta_release_all(struct net_device *dev)
 {
 	struct bpf_mprog_entry *entry;
@@ -589,7 +795,10 @@ static void meta_release_all(struct net_device *dev)
 	meta_entry_update(dev, NULL);
 	meta_entry_sync();
 	bpf_mprog_foreach_tuple(entry, fp, cp, tuple) {
-		bpf_prog_put(tuple.prog);
+		if (tuple.link)
+			meta_link(tuple.link)->dev = NULL;
+		else
+			bpf_prog_put(tuple.prog);
 	}
 }
 
diff --git a/include/net/meta.h b/include/net/meta.h
index 20fc61d05970..f1abe1d6d02d 100644
--- a/include/net/meta.h
+++ b/include/net/meta.h
@@ -7,6 +7,7 @@
 
 #ifdef CONFIG_META
 int meta_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int meta_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int meta_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog);
 int meta_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr);
 #else
@@ -16,6 +17,12 @@ static inline int meta_prog_attach(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline int meta_link_attach(const union bpf_attr *attr,
+				   struct bpf_prog *prog)
+{
+	return -EINVAL;
+}
+
 static inline int meta_prog_detach(const union bpf_attr *attr,
 				   struct bpf_prog *prog)
 {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 00a875720e84..fd069f285fbc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1068,6 +1068,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_NETFILTER = 10,
 	BPF_LINK_TYPE_TCX = 11,
 	BPF_LINK_TYPE_UPROBE_MULTI = 12,
+	BPF_LINK_TYPE_META = 12,
 	MAX_BPF_LINK_TYPE,
 };
 
@@ -1653,6 +1654,13 @@ union bpf_attr {
 				__u32		flags;
 				__u32		pid;
 			} uprobe_multi;
+			struct {
+				union {
+					__u32	relative_fd;
+					__u32	relative_id;
+				};
+				__u64		expected_revision;
+			} meta;
 		};
 	} link_create;
 
@@ -6564,6 +6572,9 @@ struct bpf_link_info {
 			__u32 ifindex;
 			__u32 attach_type;
 		} tcx;
+		struct {
+			__u32 ifindex;
+		} meta;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 51baf4355c39..b689da4de280 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4969,7 +4969,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		    attr->link_create.attach_type == BPF_TCX_EGRESS)
 			ret = tcx_link_attach(attr, prog);
 		else
-			ret = -EINVAL;
+			ret = meta_link_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_NETFILTER:
 		ret = bpf_nf_link_attach(attr, prog);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 00a875720e84..fd069f285fbc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1068,6 +1068,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_NETFILTER = 10,
 	BPF_LINK_TYPE_TCX = 11,
 	BPF_LINK_TYPE_UPROBE_MULTI = 12,
+	BPF_LINK_TYPE_META = 12,
 	MAX_BPF_LINK_TYPE,
 };
 
@@ -1653,6 +1654,13 @@ union bpf_attr {
 				__u32		flags;
 				__u32		pid;
 			} uprobe_multi;
+			struct {
+				union {
+					__u32	relative_fd;
+					__u32	relative_id;
+				};
+				__u64		expected_revision;
+			} meta;
 		};
 	} link_create;
 
@@ -6564,6 +6572,9 @@ struct bpf_link_info {
 			__u32 ifindex;
 			__u32 attach_type;
 		} tcx;
+		struct {
+			__u32 ifindex;
+		} meta;
 	};
 } __attribute__((aligned(8)));
 
-- 
2.34.1


