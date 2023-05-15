Return-Path: <bpf+bounces-516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D97C702DA1
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2279C1C20AA5
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43837C8F7;
	Mon, 15 May 2023 13:09:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3549C8ED
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:09:23 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7871B271B
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 06:09:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aaed87d8bdso89797795ad.3
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684156143; x=1686748143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZChEe8EJBWWIaKA4QFg5WE9+TdNDvwZFYcQOzDAkC4=;
        b=NU1abb/kLwY/0YDRPFi7q/ZZpXl20ZcOzeliZ/vZ3QBf7hHff6J6bLRxr8SfMzoADr
         zyLHwmhohoLnZK7WDZmyXnv7tOJPheJnqQ9whXCnKeGi1X8Aa3Mo2RxD1DswqKzvxrE+
         ncB0nfBL+/4yaZaMzZ63+waZTWOD2lOKCCkSgynYhv9bTdwVAgIYdfQ/e9a3hAk+hfu1
         8Fv0E9Fo1hVuxO50u9UYXqlyHzP2DDUhk2/cDsoSfxIKgLZ9L2NVt0q1l320j6txQTfA
         NECndyFNM3ELWSkCheae0Fhh3zXLwddq80DpIPcTR9TtQP130KES/WUpKFyw+14OYOGE
         cH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156143; x=1686748143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZChEe8EJBWWIaKA4QFg5WE9+TdNDvwZFYcQOzDAkC4=;
        b=fVpsOBsP6XH8725W5vzFL58Og08V1jaIu2tsP5IYeOQIY3ouCOYR39Btgw//0BpXgP
         IceaZCe5f6/ftrzpEEHVjDGg1b/Lxnn387xLZPhcmoUHrMuiUDd4JajYe87XGOMgaWkE
         AiB7Mdon8/66QBraZ5eRlSe00Wwv3amD6bNPE6nt2r/IK0t6/txiza/O4ZCo+1//Fytc
         iGxp/aomTUBEmnrbTD+KjTh/UdmB8OX5VqiZjFgbHuWMazkK48RSHTKtn0bvTmzr4E2e
         yWVeWIth3IvneV5j1TQ6y3UdVOK1AsjJeIVR8oDmwt3KRv6K9zgerhEN5n22YAfkU5DW
         NbfQ==
X-Gm-Message-State: AC+VfDxjtxCkiXd2LQ2bn9hNhz+EutrXedtkDlGeFllXvWOvZEwwuoiw
	moMi63DBWcnz2s26BPK48xI=
X-Google-Smtp-Source: ACHHUZ7FOp6Z8HKfb81wlVVLkdD6Cv0Q5fg52mj2trBbuC4r2P6Sa28VLeMih12iSx6zCakVjGNn8g==
X-Received: by 2002:a17:903:11cd:b0:1ab:94:1ee4 with SMTP id q13-20020a17090311cd00b001ab00941ee4mr42096430plh.2.1684156143566;
        Mon, 15 May 2023 06:09:03 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:991:5400:4ff:fe70:1e06])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902748500b001ac2a73dbf2sm13458723pll.291.2023.05.15.06.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:09:03 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 3/3] bpf: Show target_{obj,btf}_id in tracing link info
Date: Mon, 15 May 2023 13:08:49 +0000
Message-Id: <20230515130849.57502-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230515130849.57502-1-laoar.shao@gmail.com>
References: <20230515130849.57502-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The target_btf_id can help us understand which kernel function is
linked by a tracing prog. The target_btf_id and target_obj_id have
already been exposed to userspace, so we just need to show them.

The result as follows,

tools/bpf/bpftool/bpftool link show
2: tracing  prog 13
        prog_type tracing  attach_type trace_fentry
        target_obj_id 1  target_btf_id 13964
        pids trace(10673)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":2,"type":"tracing","prog_id":13,"prog_type":"tracing","attach_type":"trace_fentry","target_obj_id":1,"target_btf_id":13964,"pids":[{"pid":10673,"comm":"trace"}]}]

$ cat /proc/10673/fdinfo/10
pos:    0
flags:  02000000
mnt_id: 15
ino:    2094
link_type:      tracing
link_id:        2
prog_tag:       a04f5eef06a7f555
prog_id:        13
attach_type:    24
target_obj_id:  1
target_btf_id:  13964

$ tail /proc/kallsyms
ffffffffc0400fa0 t bpf_prog_a04f5eef06a7f555_fentry_run [bpf]
ffffffffc062f000 t bpf_trampoline_6442464908    [bpf]

$ echo $((6442464908 & 0x7fffffff)) $((6442464908 >> 32))
13964 1

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c     | 12 ++++++++++--
 tools/bpf/bpftool/link.c |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 909c112..870395a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2968,10 +2968,18 @@ static void bpf_tracing_link_show_fdinfo(const struct bpf_link *link,
 {
 	struct bpf_tracing_link *tr_link =
 		container_of(link, struct bpf_tracing_link, link.link);
+	u32 target_btf_id;
+	u32 target_obj_id;
 
+	bpf_trampoline_unpack_key(tr_link->trampoline->key,
+							  &target_obj_id, &target_btf_id);
 	seq_printf(seq,
-		   "attach_type:\t%d\n",
-		   tr_link->attach_type);
+		   "attach_type:\t%d\n"
+		   "target_obj_id:\t%u\n"
+		   "target_btf_id:\t%u\n",
+		   tr_link->attach_type,
+		   target_obj_id,
+		   target_btf_id);
 }
 
 static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 243b74e..cfe896f 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -195,6 +195,8 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 
 		show_link_attach_type_json(info->tracing.attach_type,
 					   json_wtr);
+		jsonw_uint_field(json_wtr, "target_obj_id", info->tracing.target_obj_id);
+		jsonw_uint_field(json_wtr, "target_btf_id", info->tracing.target_btf_id);
 		break;
 	case BPF_LINK_TYPE_CGROUP:
 		jsonw_lluint_field(json_wtr, "cgroup_id",
@@ -375,6 +377,8 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 			printf("\n\tprog_type %u  ", prog_info.type);
 
 		show_link_attach_type_plain(info->tracing.attach_type);
+		printf("\n\ttarget_obj_id %u  target_btf_id %u  ",
+			   info->tracing.target_obj_id, info->tracing.target_btf_id);
 		break;
 	case BPF_LINK_TYPE_CGROUP:
 		printf("\n\tcgroup_id %zu  ", (size_t)info->cgroup.cgroup_id);
-- 
1.8.3.1


