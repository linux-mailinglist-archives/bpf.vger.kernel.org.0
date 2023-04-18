Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178656E56B5
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 03:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjDRBma (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 21:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjDRBl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 21:41:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C995FD6
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:41:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-552d922f0faso34404417b3.14
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782075; x=1684374075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Zzn8o1i1Qipa77dzB0ZPLXp5K2/As2sG8h87DoyjGM=;
        b=2+I98OIJuVmlxxZnL112cFQtwT3jCQDjIow9U7tinQ0J7PnT7CW2nk5rnzuaqyfrh7
         t3DlfVAZR6sD5E+Luhvth8wbofyEZeHmBpkUkBocSpBEVttlXwuggShqUO9kj7Yq0/h/
         aX7QFH/O8g9rnwLpOW9lAXc/V85QKHAhuJlpvE7i1s3Gysd2bhwkmvNvqQ40s9IHS+fW
         iwFwXKp/SUQPTFNVB9+Xbi1KWg/VuO0heZfOSN2cvyCPhvHY7TR+CKbNpElBlFthzn2Y
         NCkq3jwcH9x/45VO8uba3X5M5Kc8fLUu98eMXLHD5qQZ70F2CYgsgu/Pb70DPzEmoCIC
         +4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782075; x=1684374075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Zzn8o1i1Qipa77dzB0ZPLXp5K2/As2sG8h87DoyjGM=;
        b=Pg6eKtu/oRRAV4J7nyd2OWORzNtR/Qr2ioZ7tWi3OGrqw8srrvYmg+U4sn6nS6ScES
         Lmpi+7375/6XI1lzJZO4Mh7buOiOg8wxE3bO5ap6J22JeE+5i0/LI/fr4iKALNbM/LPV
         /XkqKBZkRqhpNm/GhnmY/mzBIUQLwc1mMfkmlBD9oP0ukqxUnSm8OGcKsYZKSriRVtqZ
         3cCFQvtm3QCnqy/lsToMIDDjvXarrerY2sw/QHAROT9FZSnW8dPD1vcRVuJoUjod8cNZ
         +rat3yDaO09XJ/+Mj+SKruWtNWpG5KATXoTqDab9J1toOYVjytjZTQCBuCpknzMyM9Rd
         Ub0Q==
X-Gm-Message-State: AAQBX9c/E1rmh5LH/YYlDKt+k48Yan2yM0z1qR0dczQgHXUiDR9TVbNL
        TD9/fKekCINWmssD1FJqSBr9WkGVnPU=
X-Google-Smtp-Source: AKy350a3U2lTLEFmBlzns8CqFoaKv7hHvFxu3WPdR2gkRwnkhckHyeUhIddcfAh3AVrbzcBi92gpNo88opU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:74d0:0:b0:b92:25a0:90d with SMTP id
 p199-20020a2574d0000000b00b9225a0090dmr5872731ybc.0.1681782075783; Mon, 17
 Apr 2023 18:41:15 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:11 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-12-drosen@google.com>
Subject: [RFC PATCH v3 11/37] fuse-bpf: Add support for access
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds backing support for FUSE_ACCESS

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  6 ++++++
 fs/fuse/fuse_i.h  |  6 ++++++
 3 files changed, 59 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 3d895957b5ce..e42622584037 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -417,3 +417,50 @@ int fuse_revalidate_backing(struct dentry *entry, unsigned int flags)
 		return backing_entry->d_op->d_revalidate(backing_entry, flags);
 	return 1;
 }
+
+static int fuse_access_initialize_in(struct bpf_fuse_args *fa, struct fuse_access_in *in,
+				     struct inode *inode, int mask)
+{
+	*in = (struct fuse_access_in) {
+		.mask = mask,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_ACCESS,
+			.nodeid = get_node_id(inode),
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*in),
+		.in_args[0].value = in,
+	};
+
+	return 0;
+}
+
+static int fuse_access_initialize_out(struct bpf_fuse_args *fa, struct fuse_access_in *in,
+				      struct inode *inode, int mask)
+{
+	return 0;
+}
+
+static int fuse_access_backing(struct bpf_fuse_args *fa, int *out, struct inode *inode, int mask)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	const struct fuse_access_in *fai = fa->in_args[0].value;
+
+	*out = inode_permission(&nop_mnt_idmap, fi->backing_inode, fai->mask);
+	return 0;
+}
+
+static int fuse_access_finalize(struct bpf_fuse_args *fa, int *out, struct inode *inode, int mask)
+{
+	return 0;
+}
+
+int fuse_bpf_access(int *out, struct inode *inode, int mask)
+{
+	return bpf_fuse_backing(inode, struct fuse_access_in, out,
+				fuse_access_initialize_in, fuse_access_initialize_out,
+				fuse_access_backing, fuse_access_finalize, inode, mask);
+}
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 73ebe3498fb9..535e6cf9e970 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1439,6 +1439,9 @@ static int fuse_access(struct inode *inode, int mask)
 	struct fuse_access_in inarg;
 	int err;
 
+	if (fuse_bpf_access(&err, inode, mask))
+		return err;
+
 	BUG_ON(mask & MAY_NOT_BLOCK);
 
 	if (fm->fc->no_access)
@@ -1495,6 +1498,9 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	if (fuse_bpf_access(&err, inode, mask))
+		return err;
+
 	/*
 	 * If attributes are needed, refresh them before proceeding
 	 */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 39a9fdf2a752..cb166168f9c2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1406,6 +1406,7 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 #ifdef CONFIG_FUSE_BPF
 
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
+int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
 #else
 
@@ -1414,6 +1415,11 @@ static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct
 	return 0;
 }
 
+static inline int fuse_bpf_access(int *out, struct inode *inode, int mask)
+{
+	return 0;
+}
+
 #endif // CONFIG_FUSE_BPF
 
 int fuse_handle_backing(struct fuse_bpf_entry *feb, struct path *backing_path);
-- 
2.40.0.634.g4ca3ef3211-goog

