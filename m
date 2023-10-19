Return-Path: <bpf+bounces-12692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FC97CF6F7
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 13:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E921C20D46
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156FA199A5;
	Thu, 19 Oct 2023 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="cigXNhqo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F919479
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 11:36:26 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 04:36:25 PDT
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2318FBE
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1718; q=dns/txt; s=iport;
  t=1697715385; x=1698924985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CCpbmH4qlS2EVf4NRXQnXDETc2kOkcmGhPff8ni1BHI=;
  b=cigXNhqogkdJ5UwdrQoaijPEMHVnLEEe611Q7Esoak/0QMYhbZfnFju7
   RWRdNC2HVl2HVxXl0MoK++ODhuUzDpaQ55vx9eQNqUw7aahK9dJRZU8fC
   9fios0QvuQkqBaOo77yHq9ib+dvaWAAk7G4yaeR01rIeFZluM5QDMhQEX
   o=;
X-CSE-ConnectionGUID: VTbsvqIGS4GzUpguepzZ2A==
X-CSE-MsgGUID: YKnn+OxpTUSNvt6+tF0AGQ==
X-IPAS-Result: =?us-ascii?q?A0AjAQBIEzFlmJxdJa1agliECEBItC+BJQNWDwEBAQ0BA?=
 =?us-ascii?q?UQEAQGFBocXAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQIBAQUBAQECAQcEFAEBA?=
 =?us-ascii?q?QEBAQEBHhkFDhAnhXWHBQFGgQ0yEoJ+gl8Dsl6CLIEBsyeBaIFIjD+BHYQ1J?=
 =?us-ascii?q?xuBSUSCUYIthRCFdgSDcoU7BzKCIoNYixyBAkdaFhsDBwNZKhArBwQyIgYJF?=
 =?us-ascii?q?i0lBlEEFxYkCRMSPgSDOAqBBj8PDhGCQ2E2GUuCWwkVQQRJdhAqBBQXgRFuH?=
 =?us-ascii?q?xUeNxESBRINAwh2HQIRIzwDBQMENAoVDQshBRRDA0cGSgsDAhwFAwMEgTYFD?=
 =?us-ascii?q?R4CEC4pAwMZTQIQFAM7AwMGAwsxAzBXRwxZA28fGhwJPBwDCQMHBUlAAwsYD?=
 =?us-ascii?q?UgRLDUGDhsGP3MHnQSCZwGBDpYikRWgRYQWoQgaM6lpAS6YDiCjVYQxAgQGB?=
 =?us-ascii?q?QIWgWM6gVszGggbFYMiUhkPjjmTG10kMjsCBwsBAQMJi0oBAQ?=
IronPort-Data: A9a23:v9u7j6La0Xt68ZopFE+Rg5IlxSXFcZb7ZxGr2PjKsXjdYENS3j0Bn
 GpLXTvVO/6CZWT2LtFwOYS/pEgE756DmII2Swsd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcYZsCCea/0/xWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVvW0
 T/Oi5eHYgT8g2clajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKmWDNrfnL
 wpr5OjRElLxp3/BOPv8+lrIWhFirorpAOS7oiE+t55OLfR1jndaPq4TbJLwYKrM4tmDt4gZJ
 N5l7fRcReq1V0HBsLx1bvVWL81xFZN68qTZOFmQipC83XDefGbh2+dcVmhjaOX0+s4vaY1P3
 eYTJDZIZReZiqfrhrm6UeJrwM8kKaEHPqtG5Somlm6fXK1gGM2dK0nJzYcwMDMYitJHEvHEe
 ssxYjt0ZxOGaBpKUrsSIMtkwr323yOgKlW0rnqkhqwxoE/D1DBM657zLISWZvLSbOpsyxPwS
 mXupjSlXU5y2Mak4TCd/FqyieLV2yD2QoQfEPu/7PECqFia3HASDlsSXEaTpfi/l174V99BQ
 2QP/Swhhas/7kqmSp/6RRLQiH2cpR8aVNp4EOAg7gyJjK3O7G6xBG8AVTdpa9E8ssIyAzsw2
 Tehlsj1LT9iqruYTTSa7Lj8hTq0NTIULEcBaDUCQA9D5MPsyKk/hxTOQ9JLEam6g9TvEzbgh
 TaHsEAWnLkdpcEM0Kq/8BbMhDfEjpjASQoo4S3YWWWq6g4/b4mgD6Sq7ljdq/hJN5qQRFSHs
 FALnsGf6KYFCpTlvD2NW80DFvei4PPtDdHHqURkE59k/DO39jv+O4tR+zp5YkxuN67oZAMFf
 mfthQlK+oZyE0D2Qr1Ke42sBtw4//LJQIGNuu/vUvJCZZ14dQmi9S5oZFKN022FrKTKufxvU
 Xt8WZvzZUv2GZiL3xLtGLhAie5DKjQWgDKMFcqinnxLxJLHPCbNIYrpJmdieQzQ0U9piB/e/
 9AaPMyQxlACFub/eSLQt4UUKDjmzETX57io8qS7lcbacmKK/V3N7deKn9vNnKQ+wMxoeh/gp
 C3VZ6Oh4AOXaYf7AQuLcGt/T7jkQIxyq3k2VQR1Ywf3hSV4Mdr1tf9DH3fSQVXB3LI7pRKTZ
 6ddE/hs/twUItg6021HNMKk/NAKmOqD3FvXbkJJnwTTj7Y5F1CWpbcIjyPk9TIFCWKspNAir
 ri7vj43srJdLzmO+P3+Mar1p3vo5CB1sLsrAyPgfIIJEG2yq9cCFsAEpqJtSy36AU+dlmLyO
 sf/KUpwmNQhVKdkqYSW2f/e8N7B/ikXNhMyIlQ3JI2ebUHylldPC6cZOApUVVgxjF/JxZg=
IronPort-HdrOrdr: A9a23:Nl0rNqpHzJsk1Rwzdi0Iol0aV5ogeYIsimQD101hICG9vPb2qy
 nIpoV/6faaslcssR0b9OxoW5PwI080i6QU3WB5B97LN2PbUQCTQr2Kg7GP/9SZIVycygaYvp
 0QFJSXz7bLfDxHsfo=
X-Talos-CUID: =?us-ascii?q?9a23=3AcMh4LGkH4fCgpxOT9b9fWUWjBXDXOUPhxmzOOm6?=
 =?us-ascii?q?XMjpGWoCNRkKd4LFWyeM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AWFflQAxr004G7XKIkvKsJu0+hLOaqJWNDkZOtoU?=
 =?us-ascii?q?eh/S/EzJsZXSBomyebbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,237,1694736000"; 
   d="scan'208";a="126261271"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 11:35:22 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
	by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 39JBZLFT002273
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Oct 2023 11:35:22 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
	id 937FACC1293; Thu, 19 Oct 2023 04:35:21 -0700 (PDT)
From: Denys Zagorui <dzagorui@cisco.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH] samples: bpf: fix syscall_tp openat argument
Date: Thu, 19 Oct 2023 04:35:21 -0700
Message-Id: <20231019113521.4103825-1-dzagorui@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com

This modification doesn't change behaviour of the syscall_tp
But such code is often used as a reference so it should be
correct anyway

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 samples/bpf/syscall_tp_kern.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/syscall_tp_kern.c b/samples/bpf/syscall_tp_kern.c
index 090fecfe641a..58fef969a60e 100644
--- a/samples/bpf/syscall_tp_kern.c
+++ b/samples/bpf/syscall_tp_kern.c
@@ -4,6 +4,7 @@
 #include <uapi/linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
+#if !defined(__aarch64__)
 struct syscalls_enter_open_args {
 	unsigned long long unused;
 	long syscall_nr;
@@ -11,6 +12,7 @@ struct syscalls_enter_open_args {
 	long flags;
 	long mode;
 };
+#endif
 
 struct syscalls_exit_open_args {
 	unsigned long long unused;
@@ -18,6 +20,15 @@ struct syscalls_exit_open_args {
 	long ret;
 };
 
+struct syscalls_enter_open_at_args {
+	unsigned long long unused;
+	long syscall_nr;
+	long long dfd;
+	long filename_ptr;
+	long flags;
+	long mode;
+};
+
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
 	__type(key, u32);
@@ -54,14 +65,14 @@ int trace_enter_open(struct syscalls_enter_open_args *ctx)
 #endif
 
 SEC("tracepoint/syscalls/sys_enter_openat")
-int trace_enter_open_at(struct syscalls_enter_open_args *ctx)
+int trace_enter_open_at(struct syscalls_enter_open_at_args *ctx)
 {
 	count(&enter_open_map);
 	return 0;
 }
 
 SEC("tracepoint/syscalls/sys_enter_openat2")
-int trace_enter_open_at2(struct syscalls_enter_open_args *ctx)
+int trace_enter_open_at2(struct syscalls_enter_open_at_args *ctx)
 {
 	count(&enter_open_map);
 	return 0;
-- 
2.25.1


