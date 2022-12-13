Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA164ADB3
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 03:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiLMCgy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 21:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiLMCgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 21:36:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C21DDF3
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 18:36:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r7-20020a25c107000000b006ff55ac0ee7so15099064ybf.15
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 18:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHrbQKzCmMkP479Z1RRO0/pYKwPfq1SR7Hgtp7/VwOs=;
        b=iSFgiSo/fvsyyLVOyUFMSwI6mkJf5wRVolbeG55XCn1EGMIMSfLaCO65nyrY6mccV5
         k+8NeKzWmdvwr80mBhm9HBcFnHLAKSHgJd7KcRWjPiT1F6e8JTUryriDHwgEURb7BULO
         tLh8rG+znedhLY5sBaqQRmcLFL5/Wieh4Q8szEWd3lohTgZtnj9ave2k0own4WA73QE9
         lRn7joKrJ88Z2rPHpeb6vDMhYVmrGoWXKMT/003qNMyWT9W5TP2A1R/GL/FhjNDjs2Ja
         56ARUHpdm3hA6J6pVM30A8hG1PrV6467Dms6xVXj1Cmbf+F4z6ML1iOPZV2YL+gDBVzj
         aSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hHrbQKzCmMkP479Z1RRO0/pYKwPfq1SR7Hgtp7/VwOs=;
        b=NhBva/Zdc9il/WelmI0ri7pxIIJS3QxUww8Z4n5hMf00T7B4yRmLwIZVaCeZbWekHi
         yhJAklhGluzhLZ1aiCbYxpxUPx+9wIV9NNO/25M7NiyFISwXt4QfxPR5IuF7c/arL86f
         FiNul1n51HlQFsoTFwemXjyUMR6Fd+CvOzHsQTxnShPYA2DU32/e12U7yM5UWB6QX/5f
         xg/0hAttnkNqElhQopVMRnW+ZZn0lZCHxf5EyyrOkrv992ZVDn28afSVmFYA1B3w+I42
         EmoY6d7Rg+LF2VYi9uD7see6AXO4JA2rzAGUC721V86A+tDOZhdWMgzP1td4kBWSLQBu
         rEXA==
X-Gm-Message-State: ANoB5pkUEmFB/2ISVXtmxgnFxC3vNVgxgJ7M/DkDC4l4SkQbbkUEFXTV
        jkq2aVX+mXLV6rpo7pX+l8RWxwIRkEhGJIKeYbNZTd5BzgvY7fya+ID+RbLBdLR1bg6+32z8hKl
        DsdPs0ihrF68/O8QuZGgb77TTaI9/Y+vMXjTnP6NkptD0qFbrBQ==
X-Google-Smtp-Source: AA0mqf6E5S4pD2N0gkQvq2JrCPEjvGxNLzC1eAspPRyHTxmJwXIRG6Z4Wm3by1o5O/YVA3JuPAqfBgE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:b741:0:b0:703:6335:5f5d with SMTP id
 e1-20020a25b741000000b0070363355f5dmr12419814ybm.592.1670898977090; Mon, 12
 Dec 2022 18:36:17 -0800 (PST)
Date:   Mon, 12 Dec 2022 18:35:56 -0800
In-Reply-To: <20221213023605.737383-1-sdf@google.com>
Mime-Version: 1.0
References: <20221213023605.737383-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213023605.737383-7-sdf@google.com>
Subject: [PATCH bpf-next v4 06/15] bpf: Support consuming XDP HW metadata from
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
ifindex, it these will just be propagated from the target by the verifier.
We need to create a separate offload object for the extension program,
though, since it can be reattached to a different program later (which
means we can't just inhering the offload information from the target).

An additional check is added on attach that the new target is compatible
with the offload information in the extension prog.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h   |  7 ++++++
 kernel/bpf/offload.c  | 52 ++++++++++++++++++++++++++++---------------
 kernel/bpf/syscall.c  |  8 +++++++
 kernel/bpf/verifier.c | 19 +++++++++++-----
 4 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index de6279725f41..ed288d18bf8d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2482,6 +2482,7 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *pr=
og, u32 func_id);
 void unpriv_ebpf_notify(int new_state);
=20
 #if defined(CONFIG_NET) && defined(CONFIG_BPF_SYSCALL)
+int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *ne=
tdev);
 int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr);
 void bpf_dev_bound_netdev_unregister(struct net_device *dev);
=20
@@ -2516,6 +2517,12 @@ void sock_map_unhash(struct sock *sk);
 void sock_map_destroy(struct sock *sk);
 void sock_map_close(struct sock *sk, long timeout);
 #else
+static inline int __bpf_prog_dev_bound_init(struct bpf_prog *prog,
+					    struct net_device *netdev)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int bpf_prog_dev_bound_init(struct bpf_prog *prog,
 					union bpf_attr *attr)
 {
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 3b6c9023f24d..0646dea1b0e1 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -188,17 +188,13 @@ static void __bpf_offload_dev_netdev_unregister(struc=
t bpf_offload_dev *offdev,
 	kfree(ondev);
 }
=20
-int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
+int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *ne=
tdev)
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
@@ -206,14 +202,7 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, uni=
on bpf_attr *attr)
 		return -ENOMEM;
=20
 	offload->prog =3D prog;
-
-	offload->netdev =3D dev_get_by_index(current->nsproxy->net_ns,
-					   attr->prog_ifindex);
-	err =3D bpf_dev_offload_check(offload->netdev);
-	if (err)
-		goto err_maybe_put;
-
-	prog->aux->offload_requested =3D !(attr->prog_flags & BPF_F_XDP_DEV_BOUND=
_ONLY);
+	offload->netdev =3D netdev;
=20
 	down_write(&bpf_devs_lock);
 	ondev =3D bpf_offload_find_netdev(offload->netdev);
@@ -236,19 +225,46 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, un=
ion bpf_attr *attr)
 	offload->offdev =3D ondev->offdev;
 	prog->aux->offload =3D offload;
 	list_add_tail(&offload->offloads, &ondev->progs);
-	dev_put(offload->netdev);
 	up_write(&bpf_devs_lock);
=20
 	return 0;
 err_unlock:
 	up_write(&bpf_devs_lock);
-err_maybe_put:
-	if (offload->netdev)
-		dev_put(offload->netdev);
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
+	return err;
+}
+
 int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
 {
 	struct bpf_prog_offload *offload;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 11c558be4992..8686475f0dbe 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3021,6 +3021,14 @@ static int bpf_tracing_prog_attach(struct bpf_prog *=
prog,
 			goto out_put_prog;
 		}
=20
+		if (bpf_prog_is_dev_bound(prog->aux) &&
+		    (bpf_prog_is_offloaded(tgt_prog->aux) ||
+		     !bpf_prog_is_dev_bound(tgt_prog->aux) ||
+		     !bpf_offload_dev_match(prog, tgt_prog->aux->offload->netdev))) {
+			err =3D -EINVAL;
+			goto out_put_prog;
+		}
+
 		key =3D bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
 	}
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e61fe0472b9b..5c6d6d61e57a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16524,11 +16524,6 @@ int bpf_check_attach_target(struct bpf_verifier_lo=
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
@@ -16789,10 +16784,22 @@ static int check_attach_btf_id(struct bpf_verifie=
r_env *env)
 	if (tgt_prog && prog->type =3D=3D BPF_PROG_TYPE_EXT) {
 		/* to make freplace equivalent to their targets, they need to
 		 * inherit env->ops and expected_attach_type for the rest of the
-		 * verification
+		 * verification; we also need to propagate the prog offload data
+		 * for resolving kfuncs.
 		 */
 		env->ops =3D bpf_verifier_ops[tgt_prog->type];
 		prog->expected_attach_type =3D tgt_prog->expected_attach_type;
+
+		if (bpf_prog_is_dev_bound(tgt_prog->aux)) {
+			if (bpf_prog_is_offloaded(tgt_prog->aux))
+				return -EINVAL;
+
+			prog->aux->dev_bound =3D true;
+			ret =3D __bpf_prog_dev_bound_init(prog,
+							tgt_prog->aux->offload->netdev);
+			if (ret)
+				return ret;
+		}
 	}
=20
 	/* store info about the attachment target that will be used later */
--=20
2.39.0.rc1.256.g54fd8350bd-goog

