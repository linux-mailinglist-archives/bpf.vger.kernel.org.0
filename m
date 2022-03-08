Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6604D1655
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 12:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbiCHLel (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 06:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiCHLel (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 06:34:41 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2106.outbound.protection.outlook.com [40.107.236.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503CB3BA53
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 03:33:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3Db2hlJ5Po3C+VeZ5Ak5bcoicfuPMSNNz/Iafi2OrClA6XIh1YBsUuUUPGh93iErqU9uUdeFRBFIlJe7CuwWRJ3qgdV78OHJ11J6s5iUqbAsAz/rnwXiPrOBtMKt1vwbAWRDHj1czOiKtDx1uXd3LiJMyfRDTFnn3mC+sK8ZVt3wqUm0ix1Zy5wcMCbVWLQjR43asmGlEjiv9yPjH7+3QJgZg8QlV2q3HjQ0gyBV1iG9iPoZrzPeE7sg6Y21GvExGlY4qm1kgdLx5lR8nha7mO4ZIVv0u4ToTFIi+6LPA6LhAvUnYPrft9ypeGhnq/p5fA6jc1J1So7Ss91IxSerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwZIYS+R4tf8nAIWWzPCBX4bR4F2v85uf7JeFg4RVG4=;
 b=Ywxi/xDbKqmgI3wPNk9oySsito2Rn5zAu7dA9T5ccsXvJM2amWEkZD+eHQbrhnZBrwmJmVLWW1lAQY9V7jlsy6ikhVVHyURPHULrEtel6Zic3OI74SYxfPOlA49JjN7+C7h0MD/UgjBSDJCtCE+iiWayQTHfwvc3dcccdXAs7o9qraEpCsXmP8Ft8bhxbcRe+MLtCWVpWzlJzSFT2OmgV9bw+XI4x5Y/nNH2TVm0YmYzWuKXfu9LuxTC+On5piLAOGWUN+k9ayk30lsctVTXfw9uwlOueBruLPiagO9mzE+am8WcZ84YmwW6XCY0EnphSW4bPPVfEZUrogVX3yfKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwZIYS+R4tf8nAIWWzPCBX4bR4F2v85uf7JeFg4RVG4=;
 b=p4I/9e1qlI1HHeDnUQ9N6mqegMMN0nicih5sJdI9TGiK6rkhLwBwaB/qrNa4HApFRKjzvspTDJwytignCzEsno5MOEgXJt94gdjI7ADcK+CJk73AMjchTWE/JeszjeIPgswqveAWdgpKKpXujlQmiv4hVQ3uB1dVXX64uTypWnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by MN2PR13MB3646.namprd13.prod.outlook.com (2603:10b6:208:1e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.6; Tue, 8 Mar
 2022 11:33:42 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6%5]) with mapi id 15.20.5061.018; Tue, 8 Mar 2022
 11:33:42 +0000
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
To:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Simon Horman <simon.horman@corigine.com>, oss-drivers@corigine.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Subject: [PATCH bpf-next] bpftool: Restore support for BPF offload-enabled feature probing
Date:   Tue,  8 Mar 2022 12:30:56 +0100
Message-Id: <20220308113056.3779069-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0076.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::29) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67de1bdc-add5-473f-50cb-08da00f77f67
X-MS-TrafficTypeDiagnostic: MN2PR13MB3646:EE_
X-Microsoft-Antispam-PRVS: <MN2PR13MB36469C99F12ACF2F8499DC2EE7099@MN2PR13MB3646.namprd13.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyYo/0koCquFYQPzyI4vil04tB33HGTRkJPbHG/KrZQhvJAzN3kjKvW4notRpNPSug6mIGHjgS8lxta2v0kshXxBt/N5YRlb3+zhhS1BXvH5edbdvbKiyX7k3SiumV3Kt+WgGRp0UpxKVo+UdjFb2LFVjypOACK0hsgMpgmGQwZIdNraoDaMt6uSz+v/9IhBcarAuX7d9zEEAKs1csHpMy3NjAnGtORfOC2DFZssuTyPJvq1Z5Uoqa8scIfqkd6ZiOKn0r5ru6Qstc4SdaDpuaHldPid/7AZHmruqz3LQqLYTllC8b4iwDIjcZEk7c19k4kCIOizdoUNmMD6rXqmzmze0LWGx3CZ6YoSR0DCVJbo7o3gr2J7+BN8Kew/t87Gw1WyiGOLkm/T8m1X4HLKtWKC8ihqAtPj7Jqm5zn9uHSiPBp4zDx32rN7LLgmZLiR1Qi4XcpcBaNA+6S5tFPun24S5+8ZLiF59PYa9dEXHvVJsZXJwoWAAJp7QSum38ngunrv+dqVcdqlfUte3XdJWrdVdTU1iEUo8slc7+g/+/G6mj43BnFvLNwozC5rskW3abqgPqdxK7j7LO893KggCTiWzy5Dyo+2QSqjWwGItSzlv+PuETjY/zMRczLwOsqGC4y9PIG04et3hAmBUKdCIjP1szOOuKjxDJmDfdbUDfcEUlEFLZFdlDJWKH1ohbGTcxTPFIQZPk/T+1j0v0v5iq6U4822KA60z9WV2gZrdvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(136003)(396003)(346002)(366004)(39840400004)(6486002)(8676002)(107886003)(508600001)(2906002)(38100700002)(38350700002)(6512007)(6666004)(52116002)(8936002)(6506007)(66574015)(54906003)(110136005)(86362001)(316002)(1076003)(2616005)(186003)(36756003)(83380400001)(26005)(4326008)(66946007)(66476007)(5660300002)(66556008)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFlaWUYvMVd4SFN1UlI3ZEh5b0xBNGxhSUNqWGcvRVZ6a1FHS2tBbXI2RWk1?=
 =?utf-8?B?TDVmZGxua3o4bVEyYkVGaDdXUHhvZWxtYURWVVhITVI4R0ExZHpZSzVLZHdY?=
 =?utf-8?B?c1VINGEyQ0EzVVBKM3VnVHBqcVAyOU5uR05nUVJuVE5zY3I1aUpoZ3NBRm96?=
 =?utf-8?B?MWtZa2ZiTnlkTW9uaHVCb0RSZEFyNjJZT1JDeklKRi9ZcWpqZHJFTmhzNDdQ?=
 =?utf-8?B?d0lUdjFWaFJKaEVVZXVDVWsyTlg3L2dKc1R0ZWRZejZ4SnB2RXhCNUhhSEh5?=
 =?utf-8?B?ZTM1Nk41OXpPZWwvVERyYmFmakp6ZWJJaTJ0T2F3TDJVcnZwYUJoM0xWaUpZ?=
 =?utf-8?B?bGNQL05SN2ZRZW5zR1NOb3JoV2t1UjkxQkF0R1hYT0FTTEVKdEs1c1NYZ3lI?=
 =?utf-8?B?UWt3OUVlSVJkVk05RUhzVjMyTmJDWVpkNmNaZHZUdE4xUHRFczJBN2diczk5?=
 =?utf-8?B?TVR6V2FSUzJLM0VEVzU2RjdOTjZTVUlGOEJ2WFNTR0ZMdk1LTU5jbzY3V0Ji?=
 =?utf-8?B?cURLSjNSbTNCN3BreVhpbzV2MlUrUVoyOGlsWHlGZlp1TFRwZjl2cU9UQUwy?=
 =?utf-8?B?TUZvdlNtNjArQmtxK3pWSlowbjFubUFiNCtBOThSbUw4NDZzcFAyZld3OUts?=
 =?utf-8?B?Ym1XdHdtaVBDUnU2elNBOUVUOGErOU9kNnNlWlVRTXRHTkpzWjlhREx4MFVn?=
 =?utf-8?B?WHhsbWdXazJGc09sRE9yQXpFaHRPeUJzdHBEYVU4eHhlTU5jWUxCTWg1L2h3?=
 =?utf-8?B?WHNWRG9SYXNJNktuTCtXd1NLbjY2Mm5JWmZjVXFuVy9Md1Jvbzd2TFd6b3lr?=
 =?utf-8?B?cXQveHloU1o1TUY2RGQrNlM1NlA2NTdqTGM1c1dMeHlwcE0ya2FIWlJ6SlRM?=
 =?utf-8?B?N2hZN1c5WVNhc3RaZzFDaUZsa1RXUWJxVDhzYmVwK0poYTJIb3EzVS9PQlpB?=
 =?utf-8?B?YS94VW50MUNOSjVVMi9OZ3FNRlFlWmtqUTBabWNGVUE0TklmNTJOR05ySXNt?=
 =?utf-8?B?RWM0S25JUS9GM1lmYjZJMmZCQUxFZHIwdXF0MjZXTFdTaVJocmdPVzFTblFC?=
 =?utf-8?B?bnUwNnZSRW94MVdiOXdwcWN6bEhoZjJUOGRlRHhwMFRSYW5GL3QvM20rVXMy?=
 =?utf-8?B?UjJqSTNaNld0aWh3UkRFZTFNQU0xMXB3VWlTZDdpSVRXWVRCeG0yQS9kTjdS?=
 =?utf-8?B?aEpNVkJaNkhHZkMxMjR3MlRxS3A4V1lwZTVxTzUrakhQU3A1RXRKMmJXZ05w?=
 =?utf-8?B?bWt4aFU4TTBpZmUxTDY1OXV2VlB4SEZtTExwU2ZGNllTZjUwZkJ0ZkU1dzlw?=
 =?utf-8?B?Yy8ySzAwQUNSYzlSdkNrd2dBYUF2djdOUUFFUEptNDJIWmR6NjhnbkVxazR4?=
 =?utf-8?B?NnIxUVROeTNyTFZSR3ZEUVZ1WXpxbUdWNlhKQ2F6d2NEYmNvUnh1WkljbHg0?=
 =?utf-8?B?cEpNQzBDTGdLd0twMGgra2RqWEJmdFI3eXhLbURQbnpMbHBYK0lnc3piSjBu?=
 =?utf-8?B?UE1EazlZdU8vaTBva1J2Vm1oY2ZBWENyTjY4anhEVm42RjBQd04zLzl1VzB4?=
 =?utf-8?B?aTVJMFdjM3dlU09qMGFNQVIrNG0yVzdGaTEwZEsxeEJacFdUbkNZdlZ3Y2Jh?=
 =?utf-8?B?UXR0S1BQWkdDTWp4cVJmQlJZVWt4L0piTVZPdDhwbmNta0FpdFV6UGJGMzc1?=
 =?utf-8?B?SGI1cUpnSzJTOTFaZ0xpTUdNM21GVTZVc2RKZTZzNXhxTjJCUGpJTTEzdS9q?=
 =?utf-8?B?Y3ZPVVJLWUJCL0R5U212ZUMyRkF3SDVmV1MxdERZbXpqWHFCOXFKVGwxTnR6?=
 =?utf-8?B?Ui9IVUdpOWFmY2dIODROYk10MFBuZ1FMcmlkY2dOTXNhOVVCZ3l6cUFxQ3Yw?=
 =?utf-8?B?Wkx6ZjlsZVNYOWtMRDh3dkJsREFHeTNLUTB5eFNURmlvbVBSUEcxNGl5ZHNm?=
 =?utf-8?B?ekVYY252VStscW5mcmRmRUE0T2hnYmlCcW1PR3JUY2dqWm5DaitmT0ZFeDJF?=
 =?utf-8?B?VlMxa2tqNytnPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67de1bdc-add5-473f-50cb-08da00f77f67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 11:33:42.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lh0dqAGy2taIUMTZjOaqnmicu+he9a2pSNh0z8ERDScNSe1p7XTVtJlrt6lYunzm2skO9Qhpj243Hgs/Hdvt/ycDtjBW0CdZWnLAMkhkx+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3646
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 1a56c18e6c2e4e74 ("bpftool: Stop supporting BPF offload-enabled
feature probing") removed the support to probe for BPF offload features.
This is still something that is useful for NFP NIC that can support
offloading of BPF programs.

The reason for the dropped support was that libbpf starting with v1.0
would drop support for passing the ifindex to the BPF prog/map/helper
feature probing APIs. In order to keep this useful feature for NFP
restore the functionality by moving it directly into bpftool.

The code restored is a simplified version of the code that existed in
libbpf which supposed passing the ifindex. The simplification is that it
only targets the cases where ifindex is given and call into libbpf for
the cases where it's not.

Before restoring support for probing offload features:

  # bpftool feature probe dev ens4np0
  Scanning system call availability...
  bpf() syscall is available

  Scanning eBPF program types...

  Scanning eBPF map types...

  Scanning eBPF helper functions...
  eBPF helpers supported for program type sched_cls:
  eBPF helpers supported for program type xdp:

  Scanning miscellaneous eBPF features...
  Large program size limit is NOT available
  Bounded loop support is NOT available
  ISA extension v2 is NOT available
  ISA extension v3 is NOT available

With support for probing offload features restored:

  # bpftool feature probe dev ens4np0
  Scanning system call availability...
  bpf() syscall is available

  Scanning eBPF program types...
  eBPF program_type sched_cls is available
  eBPF program_type xdp is available

  Scanning eBPF map types...
  eBPF map_type hash is available
  eBPF map_type array is available
  eBPF map_type prog_array is NOT available
  eBPF map_type perf_event_array is NOT available
  eBPF map_type percpu_hash is NOT available
  eBPF map_type percpu_array is NOT available
  eBPF map_type stack_trace is NOT available
  eBPF map_type cgroup_array is NOT available
  eBPF map_type lru_hash is NOT available
  eBPF map_type lru_percpu_hash is NOT available
  eBPF map_type lpm_trie is NOT available
  eBPF map_type array_of_maps is NOT available
  eBPF map_type hash_of_maps is NOT available
  eBPF map_type devmap is NOT available
  eBPF map_type sockmap is NOT available
  eBPF map_type cpumap is NOT available
  eBPF map_type xskmap is NOT available
  eBPF map_type sockhash is NOT available
  eBPF map_type cgroup_storage is NOT available
  eBPF map_type reuseport_sockarray is NOT available
  eBPF map_type percpu_cgroup_storage is NOT available
  eBPF map_type queue is NOT available
  eBPF map_type stack is NOT available
  eBPF map_type sk_storage is NOT available
  eBPF map_type devmap_hash is NOT available
  eBPF map_type struct_ops is NOT available
  eBPF map_type ringbuf is NOT available
  eBPF map_type inode_storage is NOT available
  eBPF map_type task_storage is NOT available
  eBPF map_type bloom_filter is NOT available

  Scanning eBPF helper functions...
  eBPF helpers supported for program type sched_cls:
  	- bpf_map_lookup_elem
  	- bpf_get_prandom_u32
  	- bpf_perf_event_output
  eBPF helpers supported for program type xdp:
  	- bpf_map_lookup_elem
  	- bpf_get_prandom_u32
  	- bpf_perf_event_output
  	- bpf_xdp_adjust_head
  	- bpf_xdp_adjust_tail

  Scanning miscellaneous eBPF features...
  Large program size limit is NOT available
  Bounded loop support is NOT available
  ISA extension v2 is NOT available
  ISA extension v3 is NOT available

Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Signed-off-by: Simon Horman <simon.horman@corigine.com>
---
 tools/bpf/bpftool/feature.c | 185 +++++++++++++++++++++++++++++++++---
 1 file changed, 170 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 9c894b1447de8cf0..4943beb1823111c8 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -3,6 +3,7 @@
 
 #include <ctype.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <string.h>
 #include <unistd.h>
 #include <net/if.h>
@@ -45,6 +46,11 @@ static bool run_as_unprivileged;
 
 /* Miscellaneous utility functions */
 
+static bool grep(const char *buffer, const char *pattern)
+{
+	return !!strstr(buffer, pattern);
+}
+
 static bool check_procfs(void)
 {
 	struct statfs st_fs;
@@ -135,6 +141,32 @@ static void print_end_section(void)
 
 /* Probing functions */
 
+static int get_vendor_id(int ifindex)
+{
+	char ifname[IF_NAMESIZE], path[64], buf[8];
+	ssize_t len;
+	int fd;
+
+	if (!if_indextoname(ifindex, ifname))
+		return -1;
+
+	snprintf(path, sizeof(path), "/sys/class/net/%s/device/vendor", ifname);
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+
+	len = read(fd, buf, sizeof(buf));
+	close(fd);
+	if (len < 0)
+		return -1;
+	if (len >= (ssize_t)sizeof(buf))
+		return -1;
+	buf[len] = '\0';
+
+	return strtol(buf, NULL, 0);
+}
+
 static int read_procfs(const char *path)
 {
 	char *endptr, *line = NULL;
@@ -478,6 +510,69 @@ static bool probe_bpf_syscall(const char *define_prefix)
 	return res;
 }
 
+static int
+probe_prog_load_ifindex(enum bpf_prog_type prog_type,
+			const struct bpf_insn *insns, size_t insns_cnt,
+			char *log_buf, size_t log_buf_sz,
+			__u32 ifindex)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		    .log_buf = log_buf,
+		    .log_size = log_buf_sz,
+		    .log_level = log_buf ? 1 : 0,
+		    .prog_ifindex = ifindex,
+		   );
+	const char *exp_msg = NULL;
+	int fd, err, exp_err = 0;
+	char buf[4096];
+
+	switch (prog_type) {
+	case BPF_PROG_TYPE_SCHED_CLS:
+	case BPF_PROG_TYPE_XDP:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insns_cnt, &opts);
+	err = -errno;
+	if (fd >= 0)
+		close(fd);
+	if (exp_err) {
+		if (fd >= 0 || err != exp_err)
+			return 0;
+		if (exp_msg && !strstr(buf, exp_msg))
+			return 0;
+		return 1;
+	}
+	return fd >= 0 ? 1 : 0;
+}
+
+static bool probe_prog_type_ifindex(enum bpf_prog_type prog_type, __u32 ifindex)
+{
+	struct bpf_insn insns[2] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN()
+	};
+
+	switch (prog_type) {
+	case BPF_PROG_TYPE_SCHED_CLS:
+		/* nfp returns -EINVAL on exit(0) with TC offload */
+		insns[0].imm = 2;
+		break;
+	case BPF_PROG_TYPE_XDP:
+		break;
+	default:
+		return false;
+	}
+
+	errno = 0;
+	probe_prog_load_ifindex(prog_type, insns, ARRAY_SIZE(insns), NULL, 0,
+				ifindex);
+
+	return errno != EINVAL && errno != EOPNOTSUPP;
+}
+
 static void
 probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
 		const char *define_prefix, __u32 ifindex)
@@ -488,11 +583,19 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
 	bool res;
 
 	if (ifindex) {
-		p_info("BPF offload feature probing is not supported");
-		return;
+		switch (prog_type) {
+		case BPF_PROG_TYPE_SCHED_CLS:
+		case BPF_PROG_TYPE_XDP:
+			break;
+		default:
+			return;
+		}
+
+		res = probe_prog_type_ifindex(prog_type, ifindex);
+	} else {
+		res = libbpf_probe_bpf_prog_type(prog_type, NULL);
 	}
 
-	res = libbpf_probe_bpf_prog_type(prog_type, NULL);
 #ifdef USE_LIBCAP
 	/* Probe may succeed even if program load fails, for unprivileged users
 	 * check that we did not fail because of insufficient permissions
@@ -521,6 +624,35 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
 			   define_prefix);
 }
 
+static bool probe_map_type_ifindex(enum bpf_map_type map_type, __u32 ifindex)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	int key_size, value_size, max_entries;
+	int fd;
+
+	opts.map_ifindex = ifindex;
+
+	key_size	= sizeof(__u32);
+	value_size	= sizeof(__u32);
+	max_entries	= 1;
+
+	switch (map_type) {
+	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_ARRAY:
+		break;
+	default:
+		return false;
+	}
+
+	fd = bpf_map_create(map_type, NULL, key_size, value_size, max_entries,
+			    &opts);
+
+	if (fd >= 0)
+		close(fd);
+
+	return fd >= 0;
+}
+
 static void
 probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
 	       __u32 ifindex)
@@ -530,12 +662,10 @@ probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
 	size_t maxlen;
 	bool res;
 
-	if (ifindex) {
-		p_info("BPF offload feature probing is not supported");
-		return;
-	}
-
-	res = libbpf_probe_bpf_map_type(map_type, NULL);
+	if (ifindex)
+		res = probe_map_type_ifindex(map_type, ifindex);
+	else
+		res = libbpf_probe_bpf_map_type(map_type, NULL);
 
 	/* Probe result depends on the success of map creation, no additional
 	 * check required for unprivileged users
@@ -559,6 +689,33 @@ probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
 			   define_prefix);
 }
 
+static bool
+probe_helper_ifindex(enum bpf_func_id id, enum bpf_prog_type prog_type,
+		     __u32 ifindex)
+{
+	struct bpf_insn insns[2] = {
+		BPF_EMIT_CALL(id),
+		BPF_EXIT_INSN()
+	};
+	char buf[4096] = {};
+	bool res;
+
+	probe_prog_load_ifindex(prog_type, insns, ARRAY_SIZE(insns), buf,
+				sizeof(buf), ifindex);
+	res = !grep(buf, "invalid func ") && !grep(buf, "unknown func ");
+
+	switch (get_vendor_id(ifindex)) {
+	case 0x19ee: /* Netronome specific */
+		res = res && !grep(buf, "not supported by FW") &&
+			!grep(buf, "unsupported function id");
+		break;
+	default:
+		break;
+	}
+
+	return res;
+}
+
 static void
 probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 			  const char *define_prefix, unsigned int id,
@@ -567,12 +724,10 @@ probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 	bool res = false;
 
 	if (supported_type) {
-		if (ifindex) {
-			p_info("BPF offload feature probing is not supported");
-			return;
-		}
-
-		res = libbpf_probe_bpf_helper(prog_type, id, NULL);
+		if (ifindex)
+			res = probe_helper_ifindex(id, prog_type, ifindex);
+		else
+			res = libbpf_probe_bpf_helper(prog_type, id, NULL);
 #ifdef USE_LIBCAP
 		/* Probe may succeed even if program load fails, for
 		 * unprivileged users check that we did not fail because of
-- 
2.35.1

