Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D2C6528FD
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 23:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiLTWVY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 17:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiLTWVD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 17:21:03 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD339FD0C
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 14:21:00 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id nb2-20020a17090b35c200b00221433a393dso5810841pjb.5
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 14:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/zYVK3w8gZZTHQB/nLhb/Pojc2PCw1BBaC3QtGAel4=;
        b=HFYfKm55Yqhkk5M0JcHec7+xPyP5MRv7vvJqPAdrEm9W//kdiSMWgUFOzynri2TNIz
         1oJfB96VONPCgWNw5DmSdj8xG6HxrkQvPzvCEsxP2MuTYpDnEvXHn3xN4HddvIh3QKgZ
         kKXErq3cyXJDk2/19Rc4fPdXJQpl8IZ451n9zfsDSJ8hgQcXMRUaaMnt0rcNz4ItfWkr
         pyvQux+jQIlkjs7GojHhDIt6D8w7qb/0G3Z75ZBNrBiQNDccaXsp4RBcu0VARdYigl4p
         w/c+XVUyEgVC0cMuiHNdj6l0T56Daw2R4F+Q+HGE+t0T47UIGFyVvB4nxUeHxabz75gJ
         0wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q/zYVK3w8gZZTHQB/nLhb/Pojc2PCw1BBaC3QtGAel4=;
        b=UbxSggFozUmyJUjUqN09frEg7jBh5AmkhpcBaiG2ZkC2TdCIG5ITiuzRlKoVIosumk
         cl8zrHz9T5UMglWRfbEh/7hgA9PaMUfn+J1tlVeCahIvdF8AHgtM9eayWboeh+FmJsjY
         xJ3bTPE4WzHveVaYlLfn9vRGkbs5OqULav8X67PqSqC9bCvlqrwlwKcUHud5pnAIfF2h
         6kDukKSqfMvKCCx5ewYFhjX2rm+wil2giZmQC/aBGZAJdu+JsqsXP3OljVXLb/UrRX7X
         qZ+4I4560QePUAiryDHCc2mNE+pntxPifXUlU5Af1PCiIZmkDwPwji/GWdIsnZziZpzf
         Wy2g==
X-Gm-Message-State: ANoB5pmGIb3lghEQd9zEUX3IjS3XKVU7x65U86pv1cS3zylsAFna4AJF
        ufSVmC2F94Ta2HqyfUgfmIpt6ab9AKME7GtAldpO1RvhH5PfFIc1Z1XiuBtwZ/J8QhV7P7JCkdR
        g3Lyp9ZRSeh0TOOGeVhwZvOWQtbMnLpmmwquzjgBbdMDmSNV75g==
X-Google-Smtp-Source: AA0mqf63j/b6b+G4A8oa11wgdZdQZx6rV1mROvfZY1AgpzdlGcF/SQ430IWLPSAkvd02Bcxu6kkuT2I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:10cd:b0:567:546c:718b with SMTP id
 d13-20020a056a0010cd00b00567546c718bmr80528639pfu.17.1671574860068; Tue, 20
 Dec 2022 14:21:00 -0800 (PST)
Date:   Tue, 20 Dec 2022 14:20:34 -0800
In-Reply-To: <20221220222043.3348718-1-sdf@google.com>
Mime-Version: 1.0
References: <20221220222043.3348718-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220222043.3348718-9-sdf@google.com>
Subject: [PATCH bpf-next v5 08/17] bpf: Support consuming XDP HW metadata from
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
 kernel/bpf/offload.c  | 107 ++++++++++++++++++++++++++++++++----------
 kernel/bpf/syscall.c  |  12 +++++
 kernel/bpf/verifier.c |   5 --
 4 files changed, 109 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 969f53691dd4..f1bacd8ee402 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2482,6 +2482,7 @@ void unpriv_ebpf_notify(int new_state);
 #if defined(CONFIG_NET) && defined(CONFIG_BPF_SYSCALL)
 void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id);
 int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr);
+int bpf_prog_dev_bound_inherit(struct bpf_prog *new_prog, struct bpf_prog =
*old_prog);
 void bpf_dev_bound_netdev_unregister(struct net_device *dev);
=20
 static inline bool bpf_prog_is_dev_bound(const struct bpf_prog_aux *aux)
@@ -2494,6 +2495,8 @@ static inline bool bpf_prog_is_offloaded(const struct=
 bpf_prog_aux *aux)
 	return aux->offload_requested;
 }
=20
+bool bpf_prog_dev_bound_match(struct bpf_prog *lhs, struct bpf_prog *rhs);
+
 static inline bool bpf_map_is_offloaded(struct bpf_map *map)
 {
 	return unlikely(map->ops =3D=3D &bpf_map_offload_ops);
@@ -2527,6 +2530,12 @@ static inline int bpf_prog_dev_bound_init(struct bpf=
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
@@ -2541,6 +2550,11 @@ static inline bool bpf_prog_is_offloaded(struct bpf_=
prog_aux *aux)
 	return false;
 }
=20
+static inline bool bpf_prog_dev_bound_match(struct bpf_prog *lhs, struct b=
pf_prog *rhs)
+{
+	return false;
+}
+
 static inline bool bpf_map_is_offloaded(struct bpf_map *map)
 {
 	return false;
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0e3fc743e0a8..60978a1f9baa 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -187,17 +187,13 @@ static void __bpf_offload_dev_netdev_unregister(struc=
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
+	if (!netdev)
 		return -EINVAL;
=20
 	offload =3D kzalloc(sizeof(*offload), GFP_USER);
@@ -205,21 +201,13 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, un=
ion bpf_attr *attr)
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
@@ -227,25 +215,80 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, un=
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
+	netdev =3D dev_get_by_index(current->nsproxy->net_ns, attr->prog_ifindex)=
;
+	if (!netdev)
+		return -EINVAL;
+
+	down_write(&bpf_devs_lock);
+	err =3D bpf_dev_offload_check(netdev);
+	if (err)
+		goto out;
+
+	prog->aux->offload_requested =3D !(attr->prog_flags & BPF_F_XDP_DEV_BOUND=
_ONLY);
+
+	err =3D __bpf_prog_dev_bound_init(prog, netdev);
+	if (err)
+		goto out;
+
+out:
+	dev_put(netdev);
+	up_write(&bpf_devs_lock);
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
+	down_write(&bpf_devs_lock);
+	if (!old_prog->aux->offload) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	new_prog->aux->dev_bound =3D old_prog->aux->dev_bound;
+	new_prog->aux->offload_requested =3D old_prog->aux->offload_requested;
+
+	err =3D __bpf_prog_dev_bound_init(new_prog, old_prog->aux->offload->netde=
v);
+	if (err)
+		goto out;
+
+out:
+	up_write(&bpf_devs_lock);
+	return err;
+}
+
 int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
 {
 	struct bpf_prog_offload *offload;
@@ -687,6 +730,22 @@ bool bpf_offload_dev_match(struct bpf_prog *prog, stru=
ct net_device *netdev)
 }
 EXPORT_SYMBOL_GPL(bpf_offload_dev_match);
=20
+bool bpf_prog_dev_bound_match(struct bpf_prog *lhs, struct bpf_prog *rhs)
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
index 11c558be4992..64a68e8fb072 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2605,6 +2605,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfpt=
r_t uattr)
 			goto free_prog_sec;
 	}
=20
+	if (type =3D=3D BPF_PROG_TYPE_EXT && dst_prog) {
+		err =3D bpf_prog_dev_bound_inherit(prog, dst_prog);
+		if (err)
+			goto free_prog_sec;
+	}
+
 	/* find program type: socket_filter vs tracing_filter */
 	err =3D find_prog_type(type, prog);
 	if (err < 0)
@@ -3021,6 +3027,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *=
prog,
 			goto out_put_prog;
 		}
=20
+		if (bpf_prog_is_dev_bound(prog->aux) &&
+		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
+			err =3D -EINVAL;
+			goto out_put_prog;
+		}
+
 		key =3D bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
 	}
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 320451a0be3e..64f4d2b5824f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16537,11 +16537,6 @@ int bpf_check_attach_target(struct bpf_verifier_lo=
g *log,
 	if (tgt_prog) {
 		struct bpf_prog_aux *aux =3D tgt_prog->aux;
=20
-		if (bpf_prog_is_dev_bound(tgt_prog->aux)) {
-			bpf_log(log, "Replacing device-bound programs not supported\n");
-			return -EINVAL;
-		}
-
 		for (i =3D 0; i < aux->func_info_cnt; i++)
 			if (aux->func_info[i].type_id =3D=3D btf_id) {
 				subprog =3D i;
--=20
2.39.0.314.g84b9a713c41-goog

