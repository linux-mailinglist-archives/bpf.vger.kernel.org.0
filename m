Return-Path: <bpf+bounces-57520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6111AAC721
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 15:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53711BA409F
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E1281357;
	Tue,  6 May 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx94n/Jv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29327AC40;
	Tue,  6 May 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539883; cv=none; b=XGME9SmTk9RISHpZmNAAsZ9gK853bXPhea2Xi5EusgGzDEbvHVGIdFapj+J2votoFNpIWUvqc2l4FQzfU7SoikGbOxIaDKkIMT1WG4QE/UrSpzCOrMe01OJStbrSvlcP+PztZnXAxXW0JHrowNtkfmPkBXzh8BT1nh4o+8zy3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539883; c=relaxed/simple;
	bh=UNTo3iZVOa4t/XvFANiR11s1+SpIejyKh5B9uerKwmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Et71iUSPmiVL089JhWaIFH7CVEil1Fec7hlr9a5oU3LeqUWjmXKq2GSdVmGBWdpXLy28IWvzBBkhEtm4SWy5qW8pshZhMwGz8P6f95IJxPWuxOvS26CX8AvYNGKTkLjyTAKhYxS5CBtzg2D7wsM/QGZKxnQplRBIOA1PF0CSE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx94n/Jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06922C4CEE4;
	Tue,  6 May 2025 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746539883;
	bh=UNTo3iZVOa4t/XvFANiR11s1+SpIejyKh5B9uerKwmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cx94n/Jv5UVPHDOs9BS1kOT2U/NYbO1Re3f0AAOMcKEs2bsq10SU7DOYrZfdJT7Dl
	 TeR9dQmf3/oQ6FBC7NIGoZvQ5DPwS3A0VZqNhDiz0D8Yf9FRNyRLZAOqCP1B3xd2cr
	 fcjRoKk8nXHK6bkvW2cKCtDWKCI+OOVrktsOMclaHt8UTKdiyZ748huOK24L7zD/Bg
	 IQGhlUoGIuk8TvqJ9zkcyYtmyR+J1g25xrhgpIUzNXOj7iTEJp6alQwxAHpSAu9VjM
	 N33dFCqiSipY6gc8Lj1bbEeEW7IgzBmKNxZvsY1oPS6llaTNAczFhILPWNWCEnQ2+4
	 7RBQ+G/jhzGSg==
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
Subject: [PATCH bpf-next 3/3] bpftool: Display ref_ctr_offset for uprobe link info
Date: Tue,  6 May 2025 15:57:27 +0200
Message-ID: <20250506135727.3977467-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506135727.3977467-1-jolsa@kernel.org>
References: <20250506135727.3977467-1-jolsa@kernel.org>
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
          uprobe /proc/self/exe+0x102f13  cookie 3735928559  ref_ctr_offset 50500538
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
index 52fd2c9fac56..b09aae3a191e 100644
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
+		printf("ref_ctr_offset %llu  ", info->perf_event.uprobe.ref_ctr_offset);
 }
 
 static void show_perf_event_tracepoint_plain(struct bpf_link_info *info)
-- 
2.49.0


