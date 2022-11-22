Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5881D6332F5
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 03:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiKVCRB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 21:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiKVCQe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 21:16:34 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D361BE634E
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:16:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-393fc59d09fso106735017b3.18
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0kBTpGRrZ4fbYeP7Bh1hsOct+NKdkC7fVmp/4th4/s=;
        b=PTyyzqK8VIpYcc3Jnv1HwKlTZVtN825+P2qskFJugJ/DNoyLCfdNJgvvb4WK//Litx
         9PSdHS+fDIZijxFoVEzf+iNQufz0lxZloF1cOdSlQxtrE3mGt+L7NNZ7cAq+QY79+G+5
         qDhW62Uexhw5NGJYa+8of89/EQtHfE3nO8G2fOeaWQ4CRwdC6fVqUCyjN41ZDHRvzP0e
         1D4semdRyxKDsXvvOZn8BhhTnael1tURdERVZKJGOgEYACViGTrodjUlJBmnKctQGZd1
         WHhMCxTizWOZtXg3xr0jXG4k/8eB3tTqtQsiIsWRi9nQDHQUvHOz09sNxIWD/ti3qwf2
         kzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0kBTpGRrZ4fbYeP7Bh1hsOct+NKdkC7fVmp/4th4/s=;
        b=iq7sfasaK78rBwaD2AnQiT+nNi9rIDq9NYvCXIDF36RNfxmLXE/WwllTrOwhuEeiZ8
         qqQF/SGcKnG81vM3Gxoif7m3xPLSvmHG9kBQi9m1LEq3Fcho7foNRbtoj/t1YG9xb/iD
         l53aL8K4QO/WPvuY57U8Go5Ncn4aCs4nnoTVAdE9dsJtkZibdpD6/sPHPxtYXI+wrMPT
         0/MkwekTi+sTWQTdoEGdmQ4RpzRESu0cNJJ7BL2xnyjocC7p5RPrKwrbjEuhgV/Jt2PY
         GsmW1tcnwfUgUNrSmRh37ibxwsnvPJBrwAxOdVZfmzzAexmexFa4H+uIwkiy+ojMzq6G
         is9A==
X-Gm-Message-State: ANoB5pnG6ldDp/jiZLu25ma1B62OLWWy57/P8pCKSlYMXhaAsBdQ+Msb
        BZFLgh+BVBQI/OUwnLShdaxOJUtOnmI=
X-Google-Smtp-Source: AA0mqf73Jt7+46OfL52Xg14iE61SnVE1xuS16R+nTJ/NK6q+VyFTx2GjobIGL8pHS0TY+qa/ra9LsUFEknk=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a05:6902:118e:b0:6e7:f54:b3d6 with SMTP id
 m14-20020a056902118e00b006e70f54b3d6mr4166933ybu.577.1669083368110; Mon, 21
 Nov 2022 18:16:08 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:21 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-7-drosen@google.com>
Subject: [RFC PATCH v2 06/21] fuse-bpf: Don't support export_operations
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the future, we may choose to support these, but it poses some
challenges. In order to create a disconnected dentry/inode, we'll need
to encode the mountpoint and bpf into the file_handle, which means we'd
need a stable representation of them. This also won't hold up to cases
where the bpf is not stateless. One possibility is registering bpf
programs and mounts in a specific order, so they can be assigned
consistent ids we can use in the file_handle. We can defer to the lower
filesystem for the lower inode's representation in the file_handle.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 224d7dfe754d..bafb2832627d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1100,6 +1100,14 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	nodeid = get_fuse_inode(inode)->nodeid;
 	generation = inode->i_generation;
 
+#ifdef CONFIG_FUSE_BPF
+	/* TODO: Does it make sense to support this in some cases? */
+	if (!nodeid && get_fuse_inode(inode)->backing_inode) {
+		*max_len = 0;
+		return FILEID_INVALID;
+	}
+#endif
+
 	fh[0] = (u32)(nodeid >> 32);
 	fh[1] = (u32)(nodeid & 0xffffffff);
 	fh[2] = generation;
-- 
2.38.1.584.g0f3c55d4c2-goog

