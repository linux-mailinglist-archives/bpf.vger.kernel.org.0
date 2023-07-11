Return-Path: <bpf+bounces-4753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B1474ECA2
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 13:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA1C1C20D2A
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F2F18B02;
	Tue, 11 Jul 2023 11:27:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212718AF8
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 11:27:34 +0000 (UTC)
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 04:27:31 PDT
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189C410E7
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1689074848;
	bh=CIo+pyUDR3XhnEvp8A3FZTnxNPcQHlDMhrpSmNz+R64=;
	h=From:To:Cc:Subject:Date;
	b=J4VYIfTcV5NKNBnLISXXT+fWNxCRay60jFNOInFQmINmPMpXWcQKotL7JAZ588WKn
	 mQI1MoF+camoKHqDO4btEbqYXKVdnNAtTXzznkU7hACcBHgqJN7UZ29sUS3kXTqIcz
	 eb59SjPpSEY6KI2TA7MQuaOhLyq7U+B82ainUy5s=
Received: from localhost.localdomain ([39.156.73.12])
	by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
	id 3C1976B3; Tue, 11 Jul 2023 19:15:01 +0800
X-QQ-mid: xmsmtpt1689074101t3lfnbjqd
Message-ID: <tencent_C6AD4AD72BEFE813228FC188905F96C6A506@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNoOqo3bURn4hkkJ4pSi2y6IOl6LhsaQpH6LiMMzjmCRA0V9Oj8iG
	 qvNeiut2h5FRriHaK3g3NOmEFMI5qSqVGuAA1GpqlgPBiM+6OcY9tcvarwG2e8k8T2BLM82nhIqt
	 htpb+3yDaAHX95XoYo7cgiASSA4IdwMUK3NNxNu3jBQXXDTsm1Ta8QPRzmZn2yu73qoGnG5Q7/xd
	 m7OA+Cl8ieGlK/Pue5vypA3QEIegJXRZhYOYxNth4Q3UoDepQnUaSVcTVoloV+VailWI/6rSV3QE
	 syMT/TuglJ4lPthe2BYEoedZezGfQtgHVYrx6nyTm1/W53uOj7s6rBGjEk0YZuM0y+AnNk2SM5rP
	 bai1Utphewop7/tfhVuB9PoqL5uN6aNohdJ010XNsQ3a6VAWrXlDeojo73DSXpRVkvr6VS85ikWt
	 R5Dl9COp3Dd8+hr0orGfDPlJ5LrqYq9MX2e5MuP07fWbg1k7Q+VvzwNqI5tep5l2QNZCoJPTi6sp
	 Wt8WlCkBbSTdn8J1deDW//mdt6QY98oa23uITkcrbUzJAVdJuilnXzBReBkNWor+FKE+HsODv0vi
	 WXT2hP6qqrAGhdMnaxRRwbD3efI1dmW++R4lx/QtgpdfZqKFyf220zJTuLXBBv1jgruRTanLE3Qp
	 R/tglA/ik6ZJg/BS3k3QC8BRHLLyPNkAz5yizJdtPklt7XCuUNLRNzywQ8QGV8TB/1/9sFV2kjxG
	 LLOpz04cIfzqyoJSf3NyRSNvH6Im6v9OrQn5SqwsCy9mc2eXABhSnrT0NT70xPIJOPDzsoHa1a2l
	 VVWuHNzIAHCFl04peWnW9q6lratZucfvdnj0HcKJR7mWpbvv77K3pVWlKkiOCNSlKQzVhBX+UplY
	 PZLlM4ZlkE6mVJ/x8yg0gpBcSq/Bq1EnxZVbiZs563dZFuobgrXFlXb1DsF0I8M3USXzDSKBc/iK
	 7Rr90+1GPfiGiI91fFeMyCq6mN20e28/bP8zA5KWkVBHRTobr2vw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Rong Tao <rtoax@foxmail.com>
To: ast@kernel.org
Cc: rongtao@cestc.cn,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] samples/bpf: syscall_tp: aarch64 no open syscall
Date: Tue, 11 Jul 2023 19:14:59 +0800
X-OQ-MSGID: <20230711111500.30517-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rong Tao <rongtao@cestc.cn>

__NR_open never exist on AArch64.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/syscall_tp_kern.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/samples/bpf/syscall_tp_kern.c b/samples/bpf/syscall_tp_kern.c
index e7121dd1ee37..090fecfe641a 100644
--- a/samples/bpf/syscall_tp_kern.c
+++ b/samples/bpf/syscall_tp_kern.c
@@ -44,12 +44,14 @@ static __always_inline void count(void *map)
 		bpf_map_update_elem(map, &key, &init_val, BPF_NOEXIST);
 }
 
+#if !defined(__aarch64__)
 SEC("tracepoint/syscalls/sys_enter_open")
 int trace_enter_open(struct syscalls_enter_open_args *ctx)
 {
 	count(&enter_open_map);
 	return 0;
 }
+#endif
 
 SEC("tracepoint/syscalls/sys_enter_openat")
 int trace_enter_open_at(struct syscalls_enter_open_args *ctx)
@@ -65,12 +67,14 @@ int trace_enter_open_at2(struct syscalls_enter_open_args *ctx)
 	return 0;
 }
 
+#if !defined(__aarch64__)
 SEC("tracepoint/syscalls/sys_exit_open")
 int trace_enter_exit(struct syscalls_exit_open_args *ctx)
 {
 	count(&exit_open_map);
 	return 0;
 }
+#endif
 
 SEC("tracepoint/syscalls/sys_exit_openat")
 int trace_enter_exit_at(struct syscalls_exit_open_args *ctx)
-- 
2.41.0


