Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D8674622
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjASWd0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjASWcS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:32:18 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7D1AA5FD
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:15:52 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r126-20020a632b84000000b004393806c06eso1634003pgr.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qv3Rj+A8HEtziyB27RLwaATzApkXHtI3AWecUNEQaO8=;
        b=ZbLse2ZJ1Egz8QwoZok+PzsbgXYYdw5DCMslLfil6cWfgzYiUdSx7DYb1Auwea+W8c
         ZMYVb6TqwJmwMil/aq4fVBeZ5kbPZ+j9kweLWi7lqq+e/PnJUbYWqTPV6+cmsCfWX2gQ
         M28uSeBbqefeI1Uv1IecLV15OftJG7R4/z4UQtj7rxChnAHEa5ZIz4ErY2QNYP4r0WiF
         XIS4LpUDzGVCGXK4qgdMka47xP5/DebLzPzrWNRfJqRvzPKf7I4rFeJjVglA/AI4f2CG
         nEptqs6PHG+9FjYYJdGAaja2Ih1nFkAyU0H7BYor+2ogXYtqeQU1Do73CSOV5/tdSB1J
         VcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qv3Rj+A8HEtziyB27RLwaATzApkXHtI3AWecUNEQaO8=;
        b=6CfR/6Eu0tyztc/wu2gc2DhYTpuJAtKMDl0gK1Sl310gqvwYbDedBZDnV79t3TSCup
         1+kcb+hsIsjuuE9ydJ1awzmifibf6It3sashpx79teIWl2fXUVxpZ9amrqPKMtyUyKXk
         p46se37qmv1JTNicPkhaij/SOZL5Q0F//ZW9BGz8aJczV0Bu6kHEnY/iy9vwPxD+mV8C
         agrzzsf0ZW/GadZQsCELOitY0PC0Tjc5p40ntMp/z1/GtSPg57mpmV3x4JQSB3ylUsWq
         mIIbGUwHWjLxn5KoDln6G7jhmhQo7Od+c16REcZpHgGlGczEs+Br13644ODgaPhBE0k5
         LAhQ==
X-Gm-Message-State: AFqh2ko+wYj333+cuFSs00bWxPCR1y/glh9whPha5J/8W0Fc9B7YusX8
        SEOu5GFIi8AzD9z2NWRcFU8psT9/1h6nPu9EcR4r9cdJjx8PT2vWTyIh/5XHMRQdAGKysxd0ad7
        TlBu3Kz+O0PUk41v9pUwU9khv4CfhQHwXdkLiJlxGd6wiGzqYUw==
X-Google-Smtp-Source: AMrXdXvuNDGr96tjgcpsqFCWGT5FbD9ruvC6RPvme9ZnsSJAoJEwVmXNFkf+xLqY4B0YU752KJVXt48=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:e20c:b0:187:2790:9bc2 with SMTP id
 u12-20020a170902e20c00b0018727909bc2mr1129204plb.61.1674166551900; Thu, 19
 Jan 2023 14:15:51 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:15:27 -0800
In-Reply-To: <20230119221536.3349901-1-sdf@google.com>
Mime-Version: 1.0
References: <20230119221536.3349901-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230119221536.3349901-9-sdf@google.com>
Subject: [PATCH bpf-next v8 08/17] bpf: Support consuming XDP HW metadata from
 fext programs
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        "=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Instead of rejecting the attaching of PROG_TYPE_EXT programs to XDP
programs that consume HW metadata, implement support for propagating the
offload information. The extension program doesn't need to set a flag or
ifindex, these will just be propagated from the target by the verifier.
We need to create a separate offload object for the extension program,
though, since it can be reattached to a different program later (which
means we can't just inherit the offload information from the target).

An additional check is added on attach that the new target is compatible
with the offload information in the extension prog.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h   |  14 ++++++
 kernel/bpf/offload.c  | 112 +++++++++++++++++++++++++++++++-----------
 kernel/bpf/syscall.c  |   7 +++
 kernel/bpf/verifier.c |   5 +-
 4 files changed, 106 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bb26c2e18092..ad4bb36d4c10 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2484,6 +2484,7 @@ int bpf_dev_bound_kfunc_check(struct bpf_verifier_log=
 *log,
 			      struct bpf_prog_aux *prog_aux);
 void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id);
 int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr);
+int bpf_prog_dev_bound_inherit(struct bpf_prog *new_prog, struct bpf_prog =
*old_prog);
 void bpf_dev_bound_netdev_unregister(struct net_device *dev);
=20
 static inline bool bpf_prog_is_dev_bound(const struct bpf_prog_aux *aux)
@@ -2496,6 +2497,8 @@ static inline bool bpf_prog_is_offloaded(const struct=
 bpf_prog_aux *aux)
 	return aux->offload_requested;
 }
=20
+bool bpf_prog_dev_bound_match(const struct bpf_prog *lhs, const struct bpf=
_prog *rhs);
+
 static inline bool bpf_map_is_offloaded(struct bpf_map *map)
 {
 	return unlikely(map->ops =3D=3D &bpf_map_offload_ops);
@@ -2535,6 +2538,12 @@ static inline int bpf_prog_dev_bound_init(struct bpf=
_prog *prog,
 	return -EOPNOTSUPP;
 }
=20
+static inline int bpf_prog_dev_bound_inherit(struct bpf_prog *new_prog,
+					     struct bpf_prog *old_prog)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void bpf_dev_bound_netdev_unregister(struct net_device *dev)
 {
 }
@@ -2549,6 +2558,11 @@ static inline bool bpf_prog_is_offloaded(struct bpf_=
prog_aux *aux)
 	return false;
 }
=20
+static inline bool bpf_prog_dev_bound_match(const struct bpf_prog *lhs, co=
nst struct bpf_prog *rhs)
+{
+	return false;
+}
+
 static inline bool bpf_map_is_offloaded(struct bpf_map *map)
 {
 	return false;
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 3e173c694bbb..e87cab2ed710 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -187,43 +187,24 @@ static void __bpf_offload_dev_netdev_unregister(struc=
t bpf_offload_dev *offdev,
 	kfree(ondev);
 }
=20
-int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
+static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_dev=
ice *netdev)
 {
 	struct bpf_offload_netdev *ondev;
 	struct bpf_prog_offload *offload;
 	int err;
=20
-	if (attr->prog_type !=3D BPF_PROG_TYPE_SCHED_CLS &&
-	    attr->prog_type !=3D BPF_PROG_TYPE_XDP)
-		return -EINVAL;
-
-	if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
-		return -EINVAL;
-
-	if (attr->prog_type =3D=3D BPF_PROG_TYPE_SCHED_CLS &&
-	    attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY)
-		return -EINVAL;
-
 	offload =3D kzalloc(sizeof(*offload), GFP_USER);
 	if (!offload)
 		return -ENOMEM;
=20
 	offload->prog =3D prog;
+	offload->netdev =3D netdev;
=20
-	offload->netdev =3D dev_get_by_index(current->nsproxy->net_ns,
-					   attr->prog_ifindex);
-	err =3D bpf_dev_offload_check(offload->netdev);
-	if (err)
-		goto err_maybe_put;
-
-	prog->aux->offload_requested =3D !(attr->prog_flags & BPF_F_XDP_DEV_BOUND=
_ONLY);
-
-	down_write(&bpf_devs_lock);
 	ondev =3D bpf_offload_find_netdev(offload->netdev);
 	if (!ondev) {
 		if (bpf_prog_is_offloaded(prog->aux)) {
 			err =3D -EINVAL;
-			goto err_unlock;
+			goto err_free;
 		}
=20
 		/* When only binding to the device, explicitly
@@ -231,25 +212,80 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, un=
ion bpf_attr *attr)
 		 */
 		err =3D __bpf_offload_dev_netdev_register(NULL, offload->netdev);
 		if (err)
-			goto err_unlock;
+			goto err_free;
 		ondev =3D bpf_offload_find_netdev(offload->netdev);
 	}
 	offload->offdev =3D ondev->offdev;
 	prog->aux->offload =3D offload;
 	list_add_tail(&offload->offloads, &ondev->progs);
-	dev_put(offload->netdev);
-	up_write(&bpf_devs_lock);
=20
 	return 0;
-err_unlock:
-	up_write(&bpf_devs_lock);
-err_maybe_put:
-	if (offload->netdev)
-		dev_put(offload->netdev);
+err_free:
 	kfree(offload);
 	return err;
 }
=20
+int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
+{
+	struct net_device *netdev;
+	int err;
+
+	if (attr->prog_type !=3D BPF_PROG_TYPE_SCHED_CLS &&
+	    attr->prog_type !=3D BPF_PROG_TYPE_XDP)
+		return -EINVAL;
+
+	if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
+		return -EINVAL;
+
+	if (attr->prog_type =3D=3D BPF_PROG_TYPE_SCHED_CLS &&
+	    attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY)
+		return -EINVAL;
+
+	netdev =3D dev_get_by_index(current->nsproxy->net_ns, attr->prog_ifindex)=
;
+	if (!netdev)
+		return -EINVAL;
+
+	err =3D bpf_dev_offload_check(netdev);
+	if (err)
+		goto out;
+
+	prog->aux->offload_requested =3D !(attr->prog_flags & BPF_F_XDP_DEV_BOUND=
_ONLY);
+
+	down_write(&bpf_devs_lock);
+	err =3D __bpf_prog_dev_bound_init(prog, netdev);
+	up_write(&bpf_devs_lock);
+
+out:
+	dev_put(netdev);
+	return err;
+}
+
+int bpf_prog_dev_bound_inherit(struct bpf_prog *new_prog, struct bpf_prog =
*old_prog)
+{
+	int err;
+
+	if (!bpf_prog_is_dev_bound(old_prog->aux))
+		return 0;
+
+	if (bpf_prog_is_offloaded(old_prog->aux))
+		return -EINVAL;
+
+	new_prog->aux->dev_bound =3D old_prog->aux->dev_bound;
+	new_prog->aux->offload_requested =3D old_prog->aux->offload_requested;
+
+	down_write(&bpf_devs_lock);
+	if (!old_prog->aux->offload) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	err =3D __bpf_prog_dev_bound_init(new_prog, old_prog->aux->offload->netde=
v);
+
+out:
+	up_write(&bpf_devs_lock);
+	return err;
+}
+
 int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
 {
 	struct bpf_prog_offload *offload;
@@ -675,6 +711,22 @@ bool bpf_offload_dev_match(struct bpf_prog *prog, stru=
ct net_device *netdev)
 }
 EXPORT_SYMBOL_GPL(bpf_offload_dev_match);
=20
+bool bpf_prog_dev_bound_match(const struct bpf_prog *lhs, const struct bpf=
_prog *rhs)
+{
+	bool ret;
+
+	if (bpf_prog_is_offloaded(lhs->aux) !=3D bpf_prog_is_offloaded(rhs->aux))
+		return false;
+
+	down_read(&bpf_devs_lock);
+	ret =3D lhs->aux->offload && rhs->aux->offload &&
+	      lhs->aux->offload->netdev &&
+	      lhs->aux->offload->netdev =3D=3D rhs->aux->offload->netdev;
+	up_read(&bpf_devs_lock);
+
+	return ret;
+}
+
 bool bpf_offload_prog_map_match(struct bpf_prog *prog, struct bpf_map *map=
)
 {
 	struct bpf_offloaded_map *offmap;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fdf4ff3d5a7f..d5ffa7a01dfb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2605,6 +2605,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfpt=
r_t uattr)
 			goto free_prog_sec;
 	}
=20
+	if (type =3D=3D BPF_PROG_TYPE_EXT && dst_prog &&
+	    bpf_prog_is_dev_bound(dst_prog->aux)) {
+		err =3D bpf_prog_dev_bound_inherit(prog, dst_prog);
+		if (err)
+			goto free_prog_sec;
+	}
+
 	/* find program type: socket_filter vs tracing_filter */
 	err =3D find_prog_type(type, prog);
 	if (err < 0)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4cfba6c340d7..5b9a2a3aba51 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16540,8 +16540,9 @@ int bpf_check_attach_target(struct bpf_verifier_log=
 *log,
 	if (tgt_prog) {
 		struct bpf_prog_aux *aux =3D tgt_prog->aux;
=20
-		if (bpf_prog_is_dev_bound(tgt_prog->aux)) {
-			bpf_log(log, "Replacing device-bound programs not supported\n");
+		if (bpf_prog_is_dev_bound(prog->aux) &&
+		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
+			bpf_log(log, "Target program bound device mismatch");
 			return -EINVAL;
 		}
=20
--=20
2.39.0.246.g2a6d74b583-goog

