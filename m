Return-Path: <bpf+bounces-12691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5E57CF6A7
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 13:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6E11C20E78
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7192D199A5;
	Thu, 19 Oct 2023 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PoXQePg9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D4719442
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 11:25:03 +0000 (UTC)
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 04:25:02 PDT
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6FC115
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1357; q=dns/txt; s=iport;
  t=1697714702; x=1698924302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S3ozFU65jwiP1pMfB7knjEIFsdeFbOwa/bbF4FMXt+k=;
  b=PoXQePg9ihXIn2Pk2cbuUTOfU9V1U2WoOH9lMyDAo0Vb55bHX4gTwrim
   T2OCj4ikNtqLTFXU6tVku7J+W7vqYra407DTVoHMZGwhqrl/fwmHLr4CP
   b4D36qFUG2vxdtjOczHN4Dm3XvDfZZTrCflbDI1lSAxhki3frT6xVXXDO
   Q=;
X-CSE-ConnectionGUID: 08+95Na0TMOOsAYle4i5pA==
X-CSE-MsgGUID: PD5YTb2XQlOshMWSdyglQw==
X-IPAS-Result: =?us-ascii?q?A0AjAQBhEDFlmJBdJa1agliECEBItC+BJQNWDwEBAQ0BA?=
 =?us-ascii?q?UQEAQGFBocXAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQIBAQUBAQECAQcEFAEBA?=
 =?us-ascii?q?QEBAQEBHhkFDhAnhXWHBQFGgQ0yEoJ+gl8Dsl+CLIEBsyeBaIFIjD+BHYQ1J?=
 =?us-ascii?q?xuBSUSCUYIthRCFdgSDcoU7BzKCIoNYixyBAkdaFhsDBwNZKhArBwQyIgYJF?=
 =?us-ascii?q?i0lBlEEFxYkCRMSPgSDOAqBBj8PDhGCQ2E2GUuCWwkVQQRJdhAqBBQXgRFuH?=
 =?us-ascii?q?xUeNxESBRINAwh2HQIRIzwDBQMENAoVDQshBRRDA0cGSgsDAhwFAwMEgTYFD?=
 =?us-ascii?q?R4CEC4pAwMZTQIQFAM7AwMGAwsxAzBXRwxZA28fGhwJPBwDCQMHBUlAAwsYD?=
 =?us-ascii?q?UgRLDUGDhsGP3MHnQSCZwGBDpYikRWgRYQWoQgaM6lpAS6YDiCjVYQxAgQGB?=
 =?us-ascii?q?QIWgWM6gVszGggbFYMiUhkPjjmTG10kMjsCBwsBAQMJi0oBAQ?=
IronPort-Data: A9a23:y/3dR6i5E03kPHRTZmhINfSxX161MhcKZh0ujC45NGQN5FlHY01je
 htvXD2BO/qKajTxKNkkYNi1pkxT6MKEzoJjTgBqrHo2Qy9jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+1H1dOCn9CEgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZWEULOZ82QsaDlNs/vS8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 woU5Ojklo9x105F5uKNyt4XQGVTKlLhFVTmZk5tZkSXqkMqShrefUoMHKF0hU9/011llj3qo
 TlHncTYpQwBZsUglAmBOvVVO3kWAEFIxFPICSDv8p3O6USeT17L5O5HPUU7YYxF4s8iVAmi9
 dRAQNwMRgqIi+Tzy7WhR6w8wM8iN8LseogYvxmMzxmAUq1gGs+FEv6MvIMEtNszrpgm8fL2a
 9gQZj11cRXoaBxUMVBRA5U79AutriCgLmID8AzN+MLb5UDr4FFA7LK3AOPRXceKYPpukleXo
 lvZqjGR7hYybYzDlmXtHmiXruXXkwvlV48IUr617PhnhBuU3GN7IBgfT0e6p7+9g1OWX9NZN
 lxS9icwxYAp80qkZtrwRRu1pDiDpBF0c9lICOw85wGlyafO5QudQG8eQVZpatsir8YeRjEw0
 FKN2dTzClRHuaaJYXGQ7LGZqXW1Iyd9BWYEaTUFTCMG7sPlrYV1iQjAJv5vGai0g9ndGDb/z
 jmQpi8uwbMekaYjzKm11V/AhD2oq97CSQtdzgXeWWa46St2Y4mqY4Hu4l/ehd5CK4afCFeIp
 2QNkcWY4MgBCJiMkGqGR+BlNKCp/N6LOnvXhlsHInU63y6m93jmdodK7XQuYkxoKc0DPzTuZ
 Sc/pD+9+rcLbDj7MIl+O76ULOMx5JnkGIjkC+j9O48mjodKSCeL+yRnZEi11m/rkVQxnaxXB
 Xt9WZv8ZZr9Ifk4pAdaV9vxwpdwmX9jnTK7qYTTikX4geDHNRZ5XJ9caAPWBt3V+p9ot+k8z
 jqyH9GBxxMaW+rkb2yHt4USNlsNa3M8APgaSvC7lMbde2KK+0l4W5c9JI/NnaQ+wMy5cc+Tr
 hmAtrdwkgaXuJE+AVzihopfQL3uR41jinkwIDYhO12ls1B6P9fwsvpEJ8dtJOF7nACG8RKSZ
 6ddEylnKqoXIgkrBxxGBXUAhNU4LU/y1V7m09SNOWFmLvaMuDAlCve9Llewq0Hi/wK8tNA1p
 PW7xxjHTJ8YLzmO/+6IAM9DO2iZ5CBH8MorBhOgCoAKJC3ErtMwQwSv1aBfHi35AUiZrtds/
 1zIUU5wSCiki9JdzeQlcojV9tr2T7QkQRMy8quyxe/eCBQ2N1GLmedoONtktxiEPI8o0M1Ov
 dlo8sw=
IronPort-HdrOrdr: A9a23:PMVfXaCsRO5IzrDlHemn55DYdb4zR+YMi2TDGXofdfUzSL38qy
 nAppUmPHPP5Qr5O0tQ++xoRpPhfZq0z/cciuMs1NyZMjUO1lHFEGgb1/qA/9UlcBeOkdK0Es
 xbAsxDNOE=
X-Talos-CUID: 9a23:7R31gW/qB9VWSSMLxWKVvxZEWZF4VHSF8FL3BFSROGJkFLzIUXbFrQ==
X-Talos-MUID: 9a23:LZCgiAuNejOE8/wLh82nvB0/BftiuZSXDGcWkbA5gMWVOihJJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,237,1694736000"; 
   d="scan'208";a="175730605"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by alln-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 11:24:00 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
	by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 39JBO0oC013855
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Oct 2023 11:24:00 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
	id D153CCC1293; Thu, 19 Oct 2023 04:23:59 -0700 (PDT)
From: Denys Zagorui <dzagorui@cisco.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH] samples: bpf: fix syscall_tp openat argument
Date: Thu, 19 Oct 2023 04:23:59 -0700
Message-Id: <20231019112359.4100114-1-dzagorui@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: rcdn-core-8.cisco.com

This modification doesn't change behaviour of the syscall_tp
But such code is often used as a reference so it should be
correct anyway

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 samples/bpf/syscall_tp_kern.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/syscall_tp_kern.c b/samples/bpf/syscall_tp_kern.c
index 090fecfe641a..152ed6ecfc42 100644
--- a/samples/bpf/syscall_tp_kern.c
+++ b/samples/bpf/syscall_tp_kern.c
@@ -18,6 +18,15 @@ struct syscalls_exit_open_args {
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
@@ -54,14 +63,14 @@ int trace_enter_open(struct syscalls_enter_open_args *ctx)
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


