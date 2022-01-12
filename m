Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA848C607
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 15:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354122AbiALO1u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 09:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354148AbiALO1f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 09:27:35 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A23C061245
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 06:27:25 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id r6so3009649qvr.13
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 06:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4IsVb9B9OD9HxbWBjwrwutVLUxC8m+FYRJd9a2MlORE=;
        b=QoSNuZmz52Hkl9O7B34ixhlxJLgwZGYTaDPOTehc/2FzgdhwlvrLXJQjCni1p9ZnY6
         zAzbO9LRP7MU4XjNFfWrV2fGtPag8cKcVxiwHS8HVWra3o+11wSd3dSSZMtQpp8VkXZv
         4WPfJVfrdKLw3Fzf9K6op4/FJCecF1zpmSSh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4IsVb9B9OD9HxbWBjwrwutVLUxC8m+FYRJd9a2MlORE=;
        b=WoHgsKwO6csGzuZb2jbeg06Mng2NNYZ+oXDuMVzxY8nFwn37vDNY+ft4REnggEx4cp
         GGQkbGhyQylyiiLp75KJLPwA+Ln+5FPYOdwc2wsFxE4f8DeJXcz+3wuf0fo9molueTuc
         WqqZGunu/XLpnA2879rGQggsX3vkvTcs3r6QHrWL/eeB6ITB7evElaqJJcbdbgOyoqJ4
         351Oi3RgFleRSbp9HyuCWFs7Z91eBRrNtauqxUnKGxb9IIolElKLo32oSLSjjnwL5DH2
         wQwvCjC6XLHy18p5bMTf3hRaKN0fVbcCpIPfEzO6jKfP91W36lxJXQORHpdjX5FD/Fcg
         PWLA==
X-Gm-Message-State: AOAM531fEPjn6WgEOKXjEq7sb9bHNQwKDLJT7lc7Ku+1MtbrvzGQru0g
        niT1Zc8WWpE8sZqHeFX9hFcrjQ==
X-Google-Smtp-Source: ABdhPJxgVxaxUN+fzXiEYHiS6XJQn0OP4HrG8KaLG5D5JMMfw7DyrySF8l++HZbE7WQkN6aLysuD6w==
X-Received: by 2002:a05:6214:1d27:: with SMTP id f7mr8326545qvd.107.1641997644047;
        Wed, 12 Jan 2022 06:27:24 -0800 (PST)
Received: from localhost.localdomain ([181.136.110.101])
        by smtp.gmail.com with ESMTPSA id h11sm8776690qko.59.2022.01.12.06.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 06:27:23 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Subject: [PATCH bpf-next v4 4/8] bpftool: Implement btf_save_raw()
Date:   Wed, 12 Jan 2022 09:27:05 -0500
Message-Id: <20220112142709.102423-5-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220112142709.102423-1-mauricio@kinvolk.io>
References: <20220112142709.102423-1-mauricio@kinvolk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Helper function to save a BTF object to a file.

Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>
Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
---
 tools/bpf/bpftool/gen.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index cdeb1047d79d..5a74fb68dc84 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1096,6 +1096,36 @@ static int do_help(int argc, char **argv)
 	return 0;
 }
 
+static int btf_save_raw(const struct btf *btf, const char *path)
+{
+	const void *data;
+	FILE *f = NULL;
+	__u32 data_sz;
+	int err = 0;
+
+	data = btf__raw_data(btf, &data_sz);
+	if (!data) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	f = fopen(path, "wb");
+	if (!f) {
+		err = -errno;
+		goto out;
+	}
+
+	if (fwrite(data, 1, data_sz, f) != data_sz) {
+		err = -errno;
+		goto out;
+	}
+
+out:
+	if (f)
+		fclose(f);
+	return err;
+}
+
 /* Create BTF file for a set of BPF objects */
 static int btfgen(const char *src_btf, const char *dst_btf, const char *objspaths[])
 {
-- 
2.25.1

