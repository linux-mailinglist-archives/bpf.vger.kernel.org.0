Return-Path: <bpf+bounces-639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DDB704DF2
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B415A2814B6
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F044C261EC;
	Tue, 16 May 2023 12:39:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017734CD9
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 12:39:38 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D82F171C
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 05:39:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso8155944b3a.1
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 05:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684240777; x=1686832777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxLMc8BFmIt3bREtW/6BCCTXLDmCWvk0r3QAm9qlALY=;
        b=MP+KvhBrpBEN12lzwHo2Ip4oBVFv4xiMN2y215LuxnLXjBehQI8Idz/nq3dqucL+Y1
         5M8WI6aIYNo1EvFZ74lgkaT0+0XsMfnsAVbkAGyqrcSWDPzGKfCw+tkaOIhijMkaHonE
         bPkzEYSfcTtbwcDh1iQMtnmu7hOFAA9q6KnLG2wd4uzNvEyOA6hORUMCjeKF7pbLpvqO
         y3tbC8jqBCpJOu3o3OkfFZrXj4LdpgO6v+yvkbhBTxHjVAlLerle+dB+k9yJ+R3EkgCf
         2P4gkUFGipmVHIYxRdvCiSP+ee7rqyhZbSJfSPHmXlRE/TCFcnzfT4+p27IdqcQny6Bg
         qQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684240777; x=1686832777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxLMc8BFmIt3bREtW/6BCCTXLDmCWvk0r3QAm9qlALY=;
        b=fdmO0/c6C3SZa9Uy9d7DbHl63UIzotgP/Me8DECDKBo5jmH4ghqkaMr7v9F6Vb7EXa
         FmgdAbT5KGQTr943UuFiUiROdHNX3YcqO2fdEDDCw+KC146eZHxt3Uyue/k+zR9sx5cv
         GurReeZOBlV5xjbEzUql8gGwohB+vbqTGvVMtkkAR5/nBIaEdq+WUp66kdFXwXRXOx3s
         1WsigyGRBDpovCADZ6IPTp0tirxELh8tfPgPA0EgJ+ctaeaIyWDqauSYsWls7+Cq3sm3
         4LyllcS1pwma18YjT1JuWfj/8jijrkGmAKqlm5oXOA8ZGNmIb78je1v7sxoGLfL9ppZq
         Z74g==
X-Gm-Message-State: AC+VfDwGutf+XsxhyulgvPcJOaffiDqRdNhYVopUWSSeJVgD7ePh9YZn
	MQzqLlytDzlgS02UedS21yE=
X-Google-Smtp-Source: ACHHUZ7NhQceSOWJGArcRdwYUbkDNnq/MVdhVZmF+dQm2Cmp24Xg+AGZ7ZKG85NIfxg0P1wAnIBleQ==
X-Received: by 2002:a05:6a00:ace:b0:63b:89a2:d624 with SMTP id c14-20020a056a000ace00b0063b89a2d624mr47419787pfl.12.1684240776933;
        Tue, 16 May 2023 05:39:36 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:8001:1799:5400:4ff:fe70:6970])
        by smtp.gmail.com with ESMTPSA id c20-20020a62e814000000b0063b8ddf77f7sm13156984pfi.211.2023.05.16.05.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:39:36 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/2] bpftool: Show target_{obj,btf}_id in tracing link info
Date: Tue, 16 May 2023 12:39:26 +0000
Message-Id: <20230516123926.57623-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230516123926.57623-1-laoar.shao@gmail.com>
References: <20230516123926.57623-1-laoar.shao@gmail.com>
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

$ tools/bpf/bpftool/bpftool link show
2: tracing  prog 13
        prog_type tracing  attach_type trace_fentry
        target_obj_id 1  target_btf_id 13964
        pids trace(10673)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":2,"type":"tracing","prog_id":13,"prog_type":"tracing","attach_type":"trace_fentry","target_obj_id":1,"target_btf_id":13964,"pids":[{"pid":10673,"comm":"trace"}]}]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
---
 tools/bpf/bpftool/link.c | 4 ++++
 1 file changed, 4 insertions(+)

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


