Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938C742A92D
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhJLQRz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhJLQRy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 12:17:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A3C061570
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 09:15:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u84-20020a254757000000b005bbc2bc51fcso12593722yba.3
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jlfiTEUka2/blqQcciOdP3p7gXV+iiMGA7a+lcQ/zbM=;
        b=IANQUCztSu0fD1+kqjILQ95Vw6oZpZ/P1o9fs7kkGN6BJ0XfDwEDavy1ZWWvmoi693
         WmVP4/OWpChEvhl0vdDGQyrXeLSYxL8hHT+Kczo90VOpvZURzPA3nxz9uoNGOnSVxAdO
         1xDN0ziNkW/lueu6N79FvKwds3f8AVOTZdNpwRebmb3YW4Mk68UdpFRen2ym9gjwEfSt
         YP7vKordN6q3/F0Qdu9OgYja6TFfUJY0UoEb8RotlpMTNLZlVOZ/mfWmKdQET2wUc3iL
         zA4lMPI31lalrDwYNjST/XdoHpqKsPcSay9Xk6y71FCu/zrPgrh3M6vI/CDwbzv07vXq
         iDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jlfiTEUka2/blqQcciOdP3p7gXV+iiMGA7a+lcQ/zbM=;
        b=UrjHKK9AD+Zvu39ZK9ggUIfbLZ26F0fkjfeRokkokVnIicKzvNpwKovGRnpyc8aiY8
         8ONjH3eqHgQuPqG6vgagfZgERwJEwSlL6nc+AwNDxzXAMXxkmqaglH01/HXPe+rFlMHW
         tDrTVpH9PxB+dRlUmahaawyWvG6SpT1Bj9TeHbNrjsU2fycOp/eg6JKZV5wNEV02/hoJ
         PrnW1lXrMvp4RycFzfK9E595jmVxG0oGcqmwJhpuRmQloQbwd1DZEeKKruyIMX62Vifr
         bDbLMUm/mDhyfTXC/dNEv7+Lus/1imCVUJ+1jOl0JMsX5JZj98LjLtr0EvbNUJRgqCRH
         65hQ==
X-Gm-Message-State: AOAM532iowjf5OS0BNFqCY5bh+2TCA1g9j9isFA8SyKZh+EM26BG9Aes
        K7PBSUsdRSzqW0ZkAN3UFtUamN8=
X-Google-Smtp-Source: ABdhPJz+kjT7uSEq8SgR2Cvdpyd8woeyUs/fZknba1ewWywixRh3FyHAJ2oUsGXYuY3TlofzwSxAd0s=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:4060:335c:dc47:9fc2])
 (user=sdf job=sendgmr) by 2002:a25:b309:: with SMTP id l9mr28165653ybj.188.1634055351928;
 Tue, 12 Oct 2021 09:15:51 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:15:43 -0700
In-Reply-To: <20211012161544.660286-1-sdf@google.com>
Message-Id: <20211012161544.660286-3-sdf@google.com>
Mime-Version: 1.0
References: <20211012161544.660286-1-sdf@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH bpf-next v2 2/3] bpftool: don't append / to the progtype
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Otherwise, attaching with bpftool doesn't work with strict section names.

Also, switch to libbpf strict mode to use the latest conventions
(note, I don't think we have any cli api guarantees?).

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/main.c |  4 ++++
 tools/bpf/bpftool/prog.c | 15 +--------------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 02eaaf065f65..8223bac1e401 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -409,6 +409,10 @@ int main(int argc, char **argv)
 	block_mount = false;
 	bin_name = argv[0];
 
+	ret = libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+	if (ret)
+		p_err("failed to enable libbpf strict mode: %d", ret);
+
 	hash_init(prog_table.table);
 	hash_init(map_table.table);
 	hash_init(link_table.table);
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 277d51c4c5d9..17505dc1243e 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1396,8 +1396,6 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 
 	while (argc) {
 		if (is_prefix(*argv, "type")) {
-			char *type;
-
 			NEXT_ARG();
 
 			if (common_prog_type != BPF_PROG_TYPE_UNSPEC) {
@@ -1407,19 +1405,8 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 			if (!REQ_ARGS(1))
 				goto err_free_reuse_maps;
 
-			/* Put a '/' at the end of type to appease libbpf */
-			type = malloc(strlen(*argv) + 2);
-			if (!type) {
-				p_err("mem alloc failed");
-				goto err_free_reuse_maps;
-			}
-			*type = 0;
-			strcat(type, *argv);
-			strcat(type, "/");
-
-			err = get_prog_type_by_name(type, &common_prog_type,
+			err = get_prog_type_by_name(*argv, &common_prog_type,
 						    &expected_attach_type);
-			free(type);
 			if (err < 0)
 				goto err_free_reuse_maps;
 
-- 
2.33.0.882.g93a45727a2-goog

