Return-Path: <bpf+bounces-59515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84956ACCA75
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015093A5073
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E5D23C8BE;
	Tue,  3 Jun 2025 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sTs1Xz0H"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7F23D280
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965414; cv=none; b=uX6u458uEY16LToiUp8QwkwP8oQyupxN8gOOXCleY5d7t6JjK5JGIWG6rUAgiQ0poqfWCyAnQDbDKR4EAgglvPap4KwcTMi6/cNHGgg6gNFkbjirWL1hxyxqd0FhI1l5nDFv3XHCbWXTltqkmzJyNw4gUZbX4xuygbZPbcvNJL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965414; c=relaxed/simple;
	bh=PZ4XL5eRWZXD26bFVpv2EJoMUERQolnkOLa2DLO2T54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dA7KBU5ml6C33ayoOwyb5fQAtcZP2Lbs55RbIWg97ZNsfg1CqBFPTELZtEng52vxat/9kNG2tX2pxF/0PfASNuP/OTQmhVgePALn4698EfxVVw9YMMp9WUJ54difp//ILc+3+yCH9bORXsPcjKFym0EfFO+b2RAbpOCI76vTY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sTs1Xz0H; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748965410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijbJoJ9Li5MjIp1TVN65GWZtg4IBHYVp0TEzJB7Nk2w=;
	b=sTs1Xz0HOtFRUQyr4PZc2lXWxWT2obzLD9Af4Xr39LGVE+aAdcgQ+ivBoTW/ZMJgaMFlec
	3bPWtxVTtXPIfYeDeIeAe20LAY+m1yJlywwTDFJiAIoud78uY1yyLsrzDYO5rWA2NfCLfq
	Wc0OyRsVLwMtIlbuubbSn6B6mRbvvTY=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	qmo@kernel.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v3 3/3] bpftool: Display cookie for raw_tp link probe
Date: Tue,  3 Jun 2025 23:43:09 +0800
Message-Id: <20250603154309.3063644-3-chen.dylane@linux.dev>
In-Reply-To: <20250603154309.3063644-1-chen.dylane@linux.dev>
References: <20250603154309.3063644-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Display cookie for raw_tp link probe, in plain mode:

 #bpftool link

22: raw_tracepoint  prog 14
        tp 'sys_enter'  cookie 23925373020405760
        pids test_progs(176)

And in json mode:

 #bpftool link -j | jq

[
  {
    "id": 47,
    "type": "raw_tracepoint",
    "prog_id": 79,
    "tp_name": "sys_enter",
    "cookie": 23925373020405760,
    "pids": [
      {
        "pid": 274,
        "comm": "test_progs"
      }
    ]
  }
]

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 52fd2c9fac..0a0ef3a80a 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -484,6 +484,7 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_RAW_TRACEPOINT:
 		jsonw_string_field(json_wtr, "tp_name",
 				   u64_to_ptr(info->raw_tracepoint.tp_name));
+		jsonw_uint_field(json_wtr, "cookie", info->raw_tracepoint.cookie);
 		break;
 	case BPF_LINK_TYPE_TRACING:
 		err = get_prog_info(info->prog_id, &prog_info);
@@ -876,6 +877,8 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_RAW_TRACEPOINT:
 		printf("\n\ttp '%s'  ",
 		       (const char *)u64_to_ptr(info->raw_tracepoint.tp_name));
+		if (info->raw_tracepoint.cookie)
+			printf("cookie %llu  ", info->raw_tracepoint.cookie);
 		break;
 	case BPF_LINK_TYPE_TRACING:
 		err = get_prog_info(info->prog_id, &prog_info);
-- 
2.43.0


