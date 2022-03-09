Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B364D2B06
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 09:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiCII4h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 03:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiCII4g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 03:56:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D752013D933
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 00:55:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSQ7+9QFIPeJ8sqOShIZzkkvPorPk8DKRrS1YR1mT0M83EFyhaijTLwZD7I2PJ71orX6NaVqHUtOEkIhdufVRDMw4w9oYeT/I11QyYgWdVRq6by3y7qC0gY3Pn8/A8/Js9MUmEhIV+AslzyspKiJsygmWb4GHhSygFbUgw0X+EF/bZZJk2Qg4YyplMwaCOG7BgV8SqSgREGpmREa2wU7RLVs3/7TLcRpGCDp02hvrBJw+/WpkB/AUlqEUZCvKJK9MxiKKi0tO0ixNT4n5S+9sAacKFtIy1N9mlRBJ9YNDE3ax1+PCQFOE4n0p7OfNjzRdN8/GYXiwIYq0CJoXfkrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJBvCHpsUrI8bDn+T1mVVMoPMefCTetN6jacivydco8=;
 b=jL37Cv2t9j4nVQZL2AnfXMWkGluQyoR9EF5emq4Zz9VK7s1POk+CioQwxXULLBNRgq5J2/IWcBA8kKSxLKiBTUs+GcCSZWCiGcWUL++QLMNWjwno5j3BckYwWXUG9QkvMA4M0aW5ON/s/PPC8fD6vOp6rroiNTBrZ0C5OvxtTdkAnYuNBVanspCISqB0XQWe+j9Y9IA91m4yRtICGHnKrehCf7IzE6AS0x7cpMdEfzhMcfeq0/oHzWPVTgzZjy9srB6r8H934eAO5ZhlcNSxf47aPMi1UnYgJt2yZ/AWSAr8Web/XF1U+o3EyHQuyvHl+Zdq5ZgpQheLFSZVo9k+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJBvCHpsUrI8bDn+T1mVVMoPMefCTetN6jacivydco8=;
 b=FonGiIN6IGZ2Vfekmx2gpDBf7ESdG/uvJ3LwlwSaZKtAREsx4n+K8Kz/MFaCBxEB+f3DkxKewMxiMoj1tLtvL/AoeS6457cxUTftlUWunmSc3wdSq9jErHUzDkpW3+axa6BX2W01anmdvNyrIt5r+hINYSuDeZ+dP+zvZGjBrT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by MW5PR13MB5416.namprd13.prod.outlook.com (2603:10b6:303:191::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.15; Wed, 9 Mar
 2022 08:55:35 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6%5]) with mapi id 15.20.5061.020; Wed, 9 Mar 2022
 08:55:34 +0000
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
To:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Simon Horman <simon.horman@corigine.com>, oss-drivers@corigine.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Subject: [v2,bpf-next] bpftool: Restore support for BPF offload-enabled feature probing
Date:   Wed,  9 Mar 2022 09:54:52 +0100
Message-Id: <20220309085452.298278-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0060.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::37) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed1f5d64-54e4-4289-f6c5-08da01aa92cd
X-MS-TrafficTypeDiagnostic: MW5PR13MB5416:EE_
X-Microsoft-Antispam-PRVS: <MW5PR13MB5416A99FAC65B1B98BC0FE09E70A9@MW5PR13MB5416.namprd13.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jr1v4+EqmxR5YYXTvdlyNaI5HKM+scY0KqTasN04hKtU/FIMq559zQzAE5ku7gOcj3DX4z+CvTfH6gOUVkU/rxOAim1Jo+uDLpavIme8ydcood6/oOkaGmVy86xflArH8x89tA0YjLZfrSdO+n3kmBy7QTnylBzbOsNDKCQcuc2S3v9G22f1vD3sQ/nGPRU4xEkYr/N0HQdMq5w4QkZSnWHr1MUTeUdAKekNZXnfgbQalqxB3D3spb9xk1jVIe8WOiSSYEmW9gWtc0vyEUm4/J/BqLP+MMIDClU3kEDJwkwGaPnek+kxBFvMQfiTkvJRWSJrrR0dCZBHnnQy3Gd6czbrUaeaKKE02kJ78ASdbAAidOfToQjPryZCaUlyZTNX6dwS4Iqdf2/xKZ+29WgwUSfCuX+tssvI1dheCNBz8xEj3Dv/kRbGicPIHkrtd4vNzj9G1eUcgVpvqzOdXQ2r0MmA63Ec7M2PmGONFucylbgK1ai1SLhCR3iK7ZM9ofrMQv7RLQxDkZidY3XR0AjlCqDKjvZuxf1Qu4qmMiG/71vssh1GxlibbCPdeLz3/1qV8kqkoYFKS3kB0fD2rV/uPsKQCTJOrA66fONS8QhrSinpF1ypWKfF4+ClvPs1gakzBsuHZt3Mk0ycwfVWT4WVgGBAdD8JyoUkM5NPvDFq+Hpd1TiNdchpXWfwAIJbn6/PHaOcqCCtCNlOwjO4lQ8a24+/Hq1L7ixXWrdVKMZejlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(39840400004)(396003)(136003)(366004)(6486002)(66556008)(1076003)(8676002)(4326008)(66946007)(54906003)(110136005)(316002)(83380400001)(508600001)(36756003)(6512007)(5660300002)(66574015)(66476007)(2906002)(186003)(2616005)(107886003)(26005)(6666004)(8936002)(52116002)(6506007)(38100700002)(38350700002)(86362001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1Z1MDM0aTRpS0JIaFJqZXRpRkhkNUtKVEFQOW5NUm1sNCs4ZUYwcjJlc3Fr?=
 =?utf-8?B?RUZXK2U5T0dZU0VEN282MTcyOUNyT0VOb05LVkJrbnpUeUVoQnRXZjNyMmtC?=
 =?utf-8?B?c0x3VkxjWWRNbEVuNlUrV0c5K0YxREZCTXdtdnNhTUpzNWhhMy96b1NIeC81?=
 =?utf-8?B?RWVPQmcrVGFoWERnK21aRlpLL0FZNTRRODBCUnowNEVOZ1hIZGZWN3JVWklB?=
 =?utf-8?B?TzBTdEFFTDN6WERVdEZKZDhWbzlSWGJ5aDQyc3BDRjNsUzJPRnhMZUZxNjNH?=
 =?utf-8?B?RGpIZ3JscGNrQUJHK2kzTktEVFVEb21nekhSVTZ3NEthQXN3Yk5wdXJHbkRI?=
 =?utf-8?B?amI2LzlvVWRPUGVGRmdEQzFWMUVacUpYeW5ac2xRRXczeHRyTVpJNzZxSTlp?=
 =?utf-8?B?YW80dlhkT2Vqd0xFOTZFaWNTdlZPL2ZmbFhKc3JYc0Vad1JyODVkNkVtaHhh?=
 =?utf-8?B?NmM1OGhMbEkrbDF0M2g1a2htUDdmUEpibFdWaXdMNVY2dlcwem9nbXRkUEpm?=
 =?utf-8?B?Q2Z0R2Fxb21QM1pJbFJ4VTBFczdFeEdyazFBQUFNbkc4U0VkcXJHWStsZkMr?=
 =?utf-8?B?dWxNa2p6eE9RWnZ6MTY3SHQydmVpdCtLc0R5VWlSZXE2dXRBV05iajlFL3FQ?=
 =?utf-8?B?cUJuQm1QcFBLMlI5ZnZkZ3BFWk9qdjNFaVR6V3E5MFFtZjMwTFBURlAreWk4?=
 =?utf-8?B?LzRRcjdLaS96NjIwQ1YvSEZVLzV4T0pPQ09tSTkyNVZGRy8zSXBFQUtjRXlH?=
 =?utf-8?B?dEJ2OUQwdUdEcVVKTml6STZsNlJQYU5wQUZvTTBxcU1QYjg3a0QraUJEVlcr?=
 =?utf-8?B?T3Z2UG45Y3JKSVZhc3NwM0pSUEEyYW1QQkR5NUc4N1IzUmNIT1hzS3libWJV?=
 =?utf-8?B?SnN1K3puaWdnRms4YlJIaythbDhEVUZTZjhqOXM1aCthWmFvVS9xOW1xV3lj?=
 =?utf-8?B?TGhuVkpnUTNpaFg0a0pzdkREc1FXclpDQVlzdGZoMDFxb2hjQjAzOXZ2b0NM?=
 =?utf-8?B?dkJFTGtQK3RVMWtYRWN1OXUwT2dyYjZEeW1tcmcxaFlJNHg4STM1WllPR1ZI?=
 =?utf-8?B?b0cyNTlQbjhvOUZ6c1R5VHN4bmk4ek1jb3JYcjk1N3FONjN5eWQvMVFlNStw?=
 =?utf-8?B?dmlPK1FESkJyb25aZzJYSDFXckN5S09ObVB5TU5oWVJoOGdyZEduOVJxWUE1?=
 =?utf-8?B?ZUtBYm1Ed1RPRDBpc0dnMlA2d0poM09ZSWJCRDdXbDk4Zm52eTdvZzdvY2Ew?=
 =?utf-8?B?RjNORExScnB2RnBLRGxPeEZIYjhuWGVsNDU4UGhtRHU3MnlzT2FnN0hWZEpW?=
 =?utf-8?B?aTlDMk5MUnRBZ3ZDWkErUnJtdytkYXJpZk9rbk50aldjZmtTU1BhRXE5RU5C?=
 =?utf-8?B?bmxDcjFScVIyNUY1SWdXOUYxdGVCY2VmMlkrZEpMUDduYkc0S05CREZRamJL?=
 =?utf-8?B?RGIrZjhVRklVdTdOa2cwSVhpVU96WWh1ZVBSbW11ZmR1SDBDYlhZcDFsaGpU?=
 =?utf-8?B?YUVkRHJWOGYvK2hJaGNDR1JUU05ITWMrQlAvOWo2LzEwTjJQVFpQeEo5a2NQ?=
 =?utf-8?B?U0RobW5GZFlTTG96WFpCbmlkQU5RbFJFbmNDQXlLYzNLeVk0SklldWZnNHdO?=
 =?utf-8?B?bE5YNVBJVytEaWd0OG9zMmRxMHpKRWdTdlJUREZYQjZJTTFCa2lhbFIxSGhl?=
 =?utf-8?B?cnNMUEtkYXlwdWRvc1NhYmtNbWpPSFFmN2Z0SWJLN2c5SkcwS1BxS2NZQjdh?=
 =?utf-8?B?M3NGMjI5L0FUeWJpWVFER0g0UVY0SVFMYzVvT3UzVzZoVzhWUzVQc0kwVitu?=
 =?utf-8?B?bGw5SE1VVGs2VEo5K2JRd0kxY3R1dGdnd3hsOWd1dEVkZ1FKVEJBb1J3SDJk?=
 =?utf-8?B?MzZhazJ6b085SmxoVjRCUTl4ZHFlMzJHVVJ2NTdhOW4zY1BIMk0yY1hoR2hB?=
 =?utf-8?B?SnVpeVFXaXZyTXhoR2RNRXU1Sm9YWCs1dGVVdHR6ZVBXYW9IaTlJdlZEQlhM?=
 =?utf-8?B?VnlDV0VJOFNBPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1f5d64-54e4-4289-f6c5-08da01aa92cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 08:55:34.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hADcsLDXahShlNyjD15sXmsDppSWg5oL2KvoQ1BezCXzZZ3Br0N51erIVjdWG6nBpHd4X4Vk4618RBbX+F1b1OBqyyiIzAGarT1w4tcRQBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5416
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
* Changes since v1
- Drop unneeded logic in probe_prog_load_ifindex() that was kept for
  incorrect reasons while resurrecting the functionality from the more
  generic use-case in libbpf.
- Change the return type of probe_prog_load_ifindex() from int to bool
  and perform all error checks directly.
---
 tools/bpf/bpftool/feature.c | 166 ++++++++++++++++++++++++++++++++----
 1 file changed, 151 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 9c894b1447de8cf0..85696339e2500dbe 100644
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
@@ -478,6 +510,50 @@ static bool probe_bpf_syscall(const char *define_prefix)
 	return res;
 }
 
+static bool
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
+	int fd;
+
+	errno = 0;
+	fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insns_cnt, &opts);
+	if (fd >= 0)
+		close(fd);
+
+	return fd >= 0 && errno != EINVAL && errno != EOPNOTSUPP;
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
+	return probe_prog_load_ifindex(prog_type, insns, ARRAY_SIZE(insns),
+				       NULL, 0, ifindex);
+}
+
 static void
 probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
 		const char *define_prefix, __u32 ifindex)
@@ -488,11 +564,19 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
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
@@ -521,6 +605,35 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
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
@@ -530,12 +643,10 @@ probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
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
@@ -559,6 +670,33 @@ probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
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
@@ -567,12 +705,10 @@ probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
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

