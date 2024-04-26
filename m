Return-Path: <bpf+bounces-27996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88578B4298
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 01:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F25D2830D4
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5128F3FB1D;
	Fri, 26 Apr 2024 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZ3mggu0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA13F9C6
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173391; cv=none; b=GS8MiiFGSNk2LEOkWzmOTVlmicMhs6VoStGtlo7EbDEwMyeLoWoJi5yT23CE+by1XvZclSahkvZ4XCx4lMurxRJiE7oPblayeSIIcKF4x8jXOs4dEUznH/7ET4CKnD8KQXfTcZZaLQrkh29jCuiQ5hn08bcqZPN6rkuiQbw9fDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173391; c=relaxed/simple;
	bh=gbVkTwn5jRcuW/hi/B9qThg2hX7UX8ihWjogq9Gimt0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A1ePlMhSOgyuH/tIZTFdwIpiKQfDaR79jwt1wo2GcGxqoLfPPfqXvgQzcgeV2eHb6RlcaJdBcIFZY6hF/MOqFQ5Qf1buWlSXt6TkC40rZDHPX6thJ3GYkuCVptYIqPNW1LT5+5S6WL1oDxBy+qcsVSrLmtFIAwKZ7w6W4BmIVBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZ3mggu0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5fff61c9444so2783937a12.2
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714173390; x=1714778190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0znMKtvFHOoEh2zdPfHh4MTKThh8+XiKRoSkT+54dk=;
        b=xZ3mggu0rs104wHN8cnlazbEomq4R7qD3Ah2lYk7/lEndY+2ZDyYiuiqin+itPg6N+
         2Pv0maxyV+qGhUFy6wya3aB2iPw/1JoNpywzGNOCOHtdArc2FT7JTCS2WvGeFWviT6mR
         /PjhOBrH5Z0By55sNKDHiB22Qiiti/QzQ1ZtERofM1+/MPpun8nzfzz0hIeQKB23tSCa
         39Wpo9B9+z78KV0me/+DAyNHKaJRWRnQPWNwIqxL67ZyPmHGuwYzq5rkCrIIR+BnxNhs
         idlzXq7KP+Nsa/rbfSGkvW9izIahdF0opYXNp/WRljwXymWKwgsJwo7jo94zKrV1qoOq
         Z5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714173390; x=1714778190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0znMKtvFHOoEh2zdPfHh4MTKThh8+XiKRoSkT+54dk=;
        b=tjLOc20/zbrgf9z9RrxMWPzzw9eUJe1D3DD16r0FO2s52QosdxahS6nES+VfivI0Yd
         BH0SP8gl+2qICfVeQ5nbVGpjNF033JjegXzS+9qdcBqrqACXKfinWnxi5HDnch754eAM
         WZUVlJ9ap5AN3dQ3ad8PnrXd6hfXvs7A8a2eHp8vLhTxmgCSSrINmDJjmlX4rtxKAfQW
         9h6/zZMXOJAd+MvmmjVFUBa7jplZSsfqHujlMY2nb4sSmZTaD97WND5Da7vfyVAXpjP7
         3FSLx8wEoENNFxUn0GEU9v0dtyAwH3YPvxEDVF/Ps47cY9qvehPmSRMtSABqq07wq4Lh
         iAoA==
X-Gm-Message-State: AOJu0YwDeXqLQuPrQ5KjBGt3imZuWoTkYRdTQWJhmpEfhO6WMgL3jOog
	Ln/YM/rE9SvYnspcoYzPInUA53dKUAU6BJ1tq1Chhkc+3ogIxtHRRBzTU/0DlbrZRIPaZRoqzUj
	fk1UbjBBuzZ+U+hIIIScqACzTixLb7OLTQNcbCAw9EQf9IvEJhutMRFMAK1/wptVHtZm3QiWj1J
	E7rS9ppg3zIVoB
X-Google-Smtp-Source: AGHT+IFp8nJcKa916nGLL8Ip6wnd9kCOFZHKVgoll8BaXGN4HxQAm/1mACo7Vc8f1M/NvJfv6cBDUyo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:86c7:0:b0:5dc:19d0:dccc with SMTP id
 x190-20020a6386c7000000b005dc19d0dcccmr12786pgd.3.1714173388374; Fri, 26 Apr
 2024 16:16:28 -0700 (PDT)
Date: Fri, 26 Apr 2024 16:16:20 -0700
In-Reply-To: <20240426231621.2716876-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240426231621.2716876-1-sdf@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426231621.2716876-4-sdf@google.com>
Subject: [PATCH bpf 3/3] selftests/bpf: Add sockopt case to verify prog_type
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

Make sure only sockopt programs can be attached to the setsockopt
and getsockopt hooks.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/sockopt.c        | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index dea340996e97..eaac83a7f388 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -24,6 +24,7 @@ enum sockopt_test_error {
 static struct sockopt_test {
 	const char			*descr;
 	const struct bpf_insn		insns[64];
+	enum bpf_prog_type		prog_type;
 	enum bpf_attach_type		attach_type;
 	enum bpf_attach_type		expected_attach_type;
 
@@ -928,9 +929,40 @@ static struct sockopt_test {
 
 		.error = EPERM_SETSOCKOPT,
 	},
+
+	/* ==================== prog_type ====================  */
+
+	{
+		.descr = "can attach only BPF_CGROUP_SETSOCKOP",
+		.insns = {
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+
+		},
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+		.attach_type = BPF_CGROUP_SETSOCKOPT,
+		.expected_attach_type = 0,
+		.error = DENY_ATTACH,
+	},
+
+	{
+		.descr = "can attach only BPF_CGROUP_GETSOCKOP",
+		.insns = {
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+
+		},
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+		.attach_type = BPF_CGROUP_GETSOCKOPT,
+		.expected_attach_type = 0,
+		.error = DENY_ATTACH,
+	},
 };
 
 static int load_prog(const struct bpf_insn *insns,
+		     enum bpf_prog_type prog_type,
 		     enum bpf_attach_type expected_attach_type)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
@@ -947,7 +979,7 @@ static int load_prog(const struct bpf_insn *insns,
 	}
 	insns_cnt++;
 
-	fd = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCKOPT, NULL, "GPL", insns, insns_cnt, &opts);
+	fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insns_cnt, &opts);
 	if (verbose && fd < 0)
 		fprintf(stderr, "%s\n", bpf_log_buf);
 
@@ -1039,11 +1071,15 @@ static int call_getsockopt(bool use_io_uring, int fd, int level, int optname,
 static int run_test(int cgroup_fd, struct sockopt_test *test, bool use_io_uring,
 		    bool use_link)
 {
+	int prog_type = BPF_PROG_TYPE_CGROUP_SOCKOPT;
 	int sock_fd, err, prog_fd, link_fd = -1;
 	void *optval = NULL;
 	int ret = 0;
 
-	prog_fd = load_prog(test->insns, test->expected_attach_type);
+	if (test->prog_type)
+		prog_type = test->prog_type;
+
+	prog_fd = load_prog(test->insns, prog_type, test->expected_attach_type);
 	if (prog_fd < 0) {
 		if (test->error == DENY_LOAD)
 			return 0;
-- 
2.44.0.769.g3c40516874-goog


