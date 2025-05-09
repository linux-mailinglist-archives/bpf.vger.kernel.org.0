Return-Path: <bpf+bounces-57862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA7AB18E3
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2CC3A5381
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209A822FDFA;
	Fri,  9 May 2025 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ehumb4Ge"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9FD22CBE9;
	Fri,  9 May 2025 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804988; cv=none; b=XAEh60MiIvzMxs030ZuDC1kV7mzFZ1Aw6yVvWYH49x9x2k/Cbxk9W+P3+2d8K++BzeTjN91ijNLfljPAbKet1ips0ts+2wzGP89rXzTrteErwYu2PPNMWZK+ZcL0CX9KsrDsfT4HHP4ibtzWzIwhhS5m1FlpEu+cxf+gb3ppnts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804988; c=relaxed/simple;
	bh=JhUNKQ6QMQHMlhTbc+jHODr6xLarzt5atYANdmmOfng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAHl/MRC/kWKim2hsw4+zHddk1HKZc4Siv06K4n83gDQHTxYpKy9M5oHIdlr1VfXormsS91bCch957Hw/+TpAtENNOrc4VZvpfZ5O9/e/2bvyelmhNhWQvWzEdpPlIMlrBybkKYZJDWW3iBdxi2VO9Bi+eWRiJIjqhP96erDOjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ehumb4Ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78ECEC4CEE4;
	Fri,  9 May 2025 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746804988;
	bh=JhUNKQ6QMQHMlhTbc+jHODr6xLarzt5atYANdmmOfng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ehumb4GeiqmzVzmKyhXR14vRImwXqaWYFPbFLNzSq0I2jPfC4mjdeby8gjIzFw/rD
	 ClApZ+lCSAz3+s8+8Kl4WQABwdU8mcAN9mK92NAP6bcLC3QFGoxYEaJMsgEgDZYIlu
	 eIO5im3k5gdqMWCCH5Lv6rO+3R/NUj4gc5FDOU3Qx+PPpXlJLGoWb3QwPg9LZ/6OiY
	 sKxbsG7a/NLJmb+j9aRRXu749JHlsfqYx0xndbKn6GPg60qfLpq4uVQ9aXkDuVj0Sa
	 gqOMtriDwDFaPQIukf3RGYx1RAF+sTXT75ZD7X08Obx1LanS2sopsPhGnf2FdnRCSV
	 wNXTrzpwEGspw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCHv2 bpf-next 3/3] bpftool: Display ref_ctr_offset for uprobe link info
Date: Fri,  9 May 2025 17:35:39 +0200
Message-ID: <20250509153539.779599-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509153539.779599-1-jolsa@kernel.org>
References: <20250509153539.779599-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to display ref_ctr_offset in link output, like:

  # bpftool link
  ...
  42: perf_event  prog 174
          uprobe /proc/self/exe+0x102f13  cookie 3735928559  ref_ctr_offset 0x303a3fa
          bpf_cookie 3735928559
          pids test_progs(1820)

  # bpftool link -j | jq
  [
    ...
    {
      "id": 42,
       ...
      "ref_ctr_offset": 50500538,
    }
  ]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 52fd2c9fac56..3535afc80a49 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -380,6 +380,7 @@ show_perf_event_uprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
 			   u64_to_ptr(info->perf_event.uprobe.file_name));
 	jsonw_uint_field(wtr, "offset", info->perf_event.uprobe.offset);
 	jsonw_uint_field(wtr, "cookie", info->perf_event.uprobe.cookie);
+	jsonw_uint_field(wtr, "ref_ctr_offset", info->perf_event.uprobe.ref_ctr_offset);
 }
 
 static void
@@ -823,6 +824,8 @@ static void show_perf_event_uprobe_plain(struct bpf_link_info *info)
 	printf("%s+%#x  ", buf, info->perf_event.uprobe.offset);
 	if (info->perf_event.uprobe.cookie)
 		printf("cookie %llu  ", info->perf_event.uprobe.cookie);
+	if (info->perf_event.uprobe.ref_ctr_offset)
+		printf("ref_ctr_offset 0x%llx  ", info->perf_event.uprobe.ref_ctr_offset);
 }
 
 static void show_perf_event_tracepoint_plain(struct bpf_link_info *info)
-- 
2.49.0


