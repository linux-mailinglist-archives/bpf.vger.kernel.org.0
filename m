Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C054D46B6
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 13:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbiCJMWM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 07:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiCJMWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 07:22:11 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2094.outbound.protection.outlook.com [40.107.220.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0918713D559
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 04:21:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8/o6c+MKfyNHc5RymNF9JjZZfp89OgVTpGvWLAAdVl1ICO4hbE9TNvzFaeEOZ+tePqPAi3hy+POzA+6bkpgHmAYhXSnrWpSEPHevkP+o+pKMA/1KlQXh/CH7VbAi2w0EEZNaa947+RK6I79G5gc0caz4a1rzP+KL/fRJNyXF7d9GaHGo7Le3CID+xeXLuRWY/Tv33HY07yi49W9jj63Viw+Za6AyfbPuv+BUe+oixid0StXDieUryvfepZKSx4VBZ3QqouQBfsMvD3U2Miz2Lyl0z8RR9srWgTdGQpBvFouoa+W5mGBLO1O9fY/y0WLQGRkuAKgcqAQK5jws3W0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3iisiB5G20JicYS45NDCI4OAbfnT0LX3pHqhfXFIww=;
 b=SzQ622Jih1YVQGo9uGzQCu/KCsC2cCGX7TdLkwosU0usucLgPgscB7XjxvoULWQQrZ1g5Y5goerc9sHinu+/xRckn915NyaeQk8raZGMQzQhEuc4JN/5QYWmZC6CTYwGx9hjApn6+2HGCG/xov8FfsZtoryDWhPa9la622kzCz0qN11Krqhdi2Bvctpl2bDPw/il6FAWuR3F/9GVZptsW2Vvqz1R0KVus3s8OLxKuchAKSBCzmzo4Rbf4rOgdW+v6dwUZPEUedNNfLd1NOapf0WCSsI8MEOrWPMm3LN4WgAMImZtKHJSXBSaiuvOQiI+zqw4/OQpSmSXhtlzmkEKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3iisiB5G20JicYS45NDCI4OAbfnT0LX3pHqhfXFIww=;
 b=L+bnHer61xi/BqeSBAXAhRJoQI1vXA+kd++yeOfP5pfptkLwI3KEqNDerIAAGlZ++zLk05UIGO4W72PAMn4whgrB/4sF2W1SQ2Aa1gvQodot0HvXTNRSQTFFRNUpv35vxIB+LcCTtzy1QNzXc6kS22S6V2/jfJRkz5/4pwJyPCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by MWHPR13MB1344.namprd13.prod.outlook.com (2603:10b6:300:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.11; Thu, 10 Mar
 2022 12:21:05 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6%5]) with mapi id 15.20.5061.020; Thu, 10 Mar 2022
 12:21:05 +0000
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
To:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Simon Horman <simon.horman@corigine.com>, oss-drivers@corigine.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Subject: [v3,bpf-next] bpftool: Restore support for BPF offload-enabled feature probing
Date:   Thu, 10 Mar 2022 13:18:46 +0100
Message-Id: <20220310121846.921256-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM7PR02CA0023.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::33) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de2d32e7-dc92-4ded-5a15-08da029072d2
X-MS-TrafficTypeDiagnostic: MWHPR13MB1344:EE_
X-Microsoft-Antispam-PRVS: <MWHPR13MB134483214E6E90BD0FAD523CE70B9@MWHPR13MB1344.namprd13.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDWCz945o/JHsbrCkuLpw+z98cy5hTgfrz57ffkBczDy7El0e96HNSCaO5cXSeM+5YmFLmrTmILV3Q926PMusmOl84tgDrxhQsA7Ac4Q4Kdn8biye8eEo2sjBRaFKP+VGZKG/SnNCA9uLnq3LiqHybV1qc8BHimaejIw69d2WZTRk9tKDNLIu785UQqxUXqdigBT0GJq1AQfX9fpXp7VQLkTS12WX8yyJVy7wUIGAO7kKoqEAi9dSqgefjIcq7yC+1NGmXQWU55QYpjbIwZusmvQ8SgV+/OfiL/fy6StARmS4oVKSlUHzF1hQI6gY+LIjbllY/iegI1nQnLFAt48sexGNCD1FQCCa0pD4mtu5XWk2y/x37zdUyDGpATgaFBOxqYxUhApPPxi3OGj8N3IIEt9MYKYUiKjJxT9ISvfdH/xA9oSorOlzNU/2NxdvFE+9021L6H9XYQw4BNTYyQ/NZRwOmzmYv1JnFiSAcPlYtt4TH0KoYzGDzvT5oSXmsZ4qh6r8rkXsEc4mjne4POnoNtSDyk3BguDoRCjgIP1u/7uTJQ95s8vXU+93yuDitXUGE8CdQ6LbE+zUAxVwtvHIgm8r5DzGM2jvljlMhN6LhJGSxsz8z8/4h/uG428dkYOIRpPfp03Ns1lavvoO2BWsNvAel70ukvtGem6oICudbScX1a+W+TsnLeOygf8tMjSk9Q706OuIs86cBS2w3Nziii+eX4vhvVX6UnCKz512YY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(346002)(376002)(136003)(366004)(396003)(2906002)(2616005)(5660300002)(508600001)(38100700002)(66574015)(1076003)(83380400001)(26005)(8936002)(8676002)(6666004)(6486002)(66556008)(186003)(86362001)(107886003)(66476007)(4326008)(66946007)(316002)(6512007)(6506007)(52116002)(54906003)(110136005)(36756003)(38350700002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXlvY1U3OEl0MmJVVEFGVTc3aDFpWGlxRytKMzF3My9GallxN1VXOHZ5ZTI5?=
 =?utf-8?B?bXV1OWRoUVhFWkxMZ241bzRsM1ZLZFpvRDVWcEttWTRvM0FQY1hTZ3hsbTVx?=
 =?utf-8?B?SVl4b200S043QytzSmJNeUVZZ0ZDelhXbHNVWnRXejI2aW0ySWtaeVo3QUEx?=
 =?utf-8?B?ZXJKdXR2dXIzM2k4TGozNGl1YVJPQnBORk5jYncwN3pseldIWi9WWmdTWmVH?=
 =?utf-8?B?aHZHaFJnamhGbEhybUgySUlEdnhDRjRQOVVvdy9PNkhwMDEzRWtocFF0NHpU?=
 =?utf-8?B?bFpBM29IcFl4Q0dmMEtFNDVLNHV1WDNZOTFkOG5PSXk5dEREcjVPcEZxUGxW?=
 =?utf-8?B?bWU2eituWndhWEJZTXhTdzlDeElGaVA0WWZ4cHJ6dzBhUkRuMm8yREFNTi85?=
 =?utf-8?B?bjRYMVJySm5Zc3VTcU5oSWtVTWcrb3A0b1Zid2o0dE1xditnRHE3Q053aDdr?=
 =?utf-8?B?NTNhZVpzK1NhRURmcWFxdGNEWVRJVjAvZ1M2a3ZBYWtNNVhwMGhvK2N1dCtl?=
 =?utf-8?B?UXZiSWl2a0xIWWtMTkRNWmoraEZUR29UejFjT1JjeGNJaCtmOFVwSVB3TGZj?=
 =?utf-8?B?czhqTVhXcG4ydmMwanY3T1BSdWxxNCt5QXg0RDFZTlFvZEM2OGpTQU5mdVBw?=
 =?utf-8?B?WVQySis1Y2YvODVGR3NJUUpRSTJ0cUVoM1FWSnRlcGgrRnJpRnlab1NKNjZ4?=
 =?utf-8?B?WCtUTUFYeTRvbDVRNU9od3JKd3kwcGtWclp4WXkvcC9HbnRwMWtZQWVNYksv?=
 =?utf-8?B?L1BYNkxGcFU3SnY0czBkdG9tcnJyTlo2ZTE2RndJVlJlR0xNRmNWOGt0NUNj?=
 =?utf-8?B?alBpV3ZkbnZPbyt6N0dlYVZjSlUvNVZRNm0wQ2ZsYVFVN2hKdjI4cEtOY2ZE?=
 =?utf-8?B?TTJMQzZFQ1VRL3RkcWdNNnBjck1UVThLVEI0Z0t1TTVPQWs1VHVkdEZqZFQv?=
 =?utf-8?B?WWdDYWEwUmtTeVJqQWpESXg1NHRha3MwWUNxVkYxbWgvM3R5eHpjdjdNdlRh?=
 =?utf-8?B?Z3RsVjROZndQYWRIbEJEMFZoakxWK1NWWUxHNUJYR3Y5K1k2dEhYSjcyRVJU?=
 =?utf-8?B?elU2eGM4aUlZQi93bUpXSmRxMUg2cGdWbisrMmpkUVdhMm1WekxXTlBtZnVY?=
 =?utf-8?B?S1RyNjFwd2lNODBNNC9VTXpyWXAwU3o4eVYxV3puYXd6UFptL1pnQVN3Z3NV?=
 =?utf-8?B?TDRlb2F6Zjd2amIzaENPNnN0KzFJb09CdFNObzcxYXBVMEgrajJOb1laWUgx?=
 =?utf-8?B?aXp3RGhGMVU0Y2hsRExvNEovOUtsK28vNUdaOFA5NjhTZXA2eDRPTWxncnlI?=
 =?utf-8?B?WGxMVjRDcEdrZWd6U3lza3l2cHA4RG4vaFkvRmQ5SWlzUUZ6aEpSMVZlZjJI?=
 =?utf-8?B?UGxsaE14OTQvOXI5aDhmODZWdDBXWXBGT0xtVytMdmZTYjZKcXNrZ2F4Tm1E?=
 =?utf-8?B?TTVPVVpMRHd3andTYmlWSmlCWktFMG1ZK0tZQmZJd0c2WnJlSEpOb1NOQjZY?=
 =?utf-8?B?QWdWOFhLemYvMXlwMkRCTk0xcDdMaHp2NFR5NHZMUUJnd2FRdE5rd0l6dU5P?=
 =?utf-8?B?dE1JaVFsWWh5Qms2SXdWQnFZaDR1K1p4MTVLWS9ZekE1QWhMSFNUdnJ5TkZr?=
 =?utf-8?B?SnQzNlBSeGdEeDhQT0hJTnkwZytRWDZ2S043bklueU1vS1NkeHgzZnNMamM0?=
 =?utf-8?B?QmJDOWZtbFhsTlU2aFBJUnFWVFhEOXZ4V0FWbVcrMFdCM2I5SXdlK0JoMzVp?=
 =?utf-8?B?emJUT1RVS29NOUVBeVNGU2ZWaDA2ZUdvL1M5d09KT0dPOGhLekVrUVdqSkJ0?=
 =?utf-8?B?NDQrQzE5Q0Rodk1ZUzNIdnFheXlQSFloVFBJN1FpWTJEa3g3WDFvSkJpblR3?=
 =?utf-8?B?dmpHRUI2S2VBam1hMjQzcmhFQUhmeE12WldlaVJ0ZFZSTi9RVlhadUM3TWxW?=
 =?utf-8?B?VTMxdkZoUTR6R1NFRWlUUVpqdXhtYkFxbUREYnY2N3N2aVVYNkN0dEgvVHpz?=
 =?utf-8?B?enlZa3dLcUZBPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2d32e7-dc92-4ded-5a15-08da029072d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 12:21:05.2530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEELlhEqcFdj2oT3aRMjNVxqRLTl+aO2b/sjkAcl7QGbPGuxv1QHgGPTj8uyGPuDnT/k4CixNNFCWeVO1H7i1pX7HKmax+IOLEYquo6fYM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1344
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

* Changes since v2
- Always probe programs with XDP_PASS instead of XDP_ABORTED.
- Only probe supported map types (BPF_MAP_TYPE_HASH and
  BPF_MAP_TYPE_ARRAY).
- Small cosmetic whitespace change.
---
 tools/bpf/bpftool/feature.c | 152 +++++++++++++++++++++++++++++++++---
 1 file changed, 139 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 9c894b1447de8cf0..c2f43a5d38e01b92 100644
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
@@ -478,6 +510,40 @@ static bool probe_bpf_syscall(const char *define_prefix)
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
+	/* nfp returns -EINVAL on exit(0) with TC offload */
+	struct bpf_insn insns[2] = {
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN()
+	};
+
+	return probe_prog_load_ifindex(prog_type, insns, ARRAY_SIZE(insns),
+				       NULL, 0, ifindex);
+}
+
 static void
 probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
 		const char *define_prefix, __u32 ifindex)
@@ -488,11 +554,19 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
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
@@ -521,6 +595,26 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
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
+	key_size = sizeof(__u32);
+	value_size = sizeof(__u32);
+	max_entries = 1;
+
+	fd = bpf_map_create(map_type, NULL, key_size, value_size, max_entries,
+			    &opts);
+	if (fd >= 0)
+		close(fd);
+
+	return fd >= 0;
+}
+
 static void
 probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
 	       __u32 ifindex)
@@ -531,11 +625,18 @@ probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
 	bool res;
 
 	if (ifindex) {
-		p_info("BPF offload feature probing is not supported");
-		return;
-	}
+		switch (map_type) {
+		case BPF_MAP_TYPE_HASH:
+		case BPF_MAP_TYPE_ARRAY:
+			break;
+		default:
+			return;
+		}
 
-	res = libbpf_probe_bpf_map_type(map_type, NULL);
+		res = probe_map_type_ifindex(map_type, ifindex);
+	} else {
+		res = libbpf_probe_bpf_map_type(map_type, NULL);
+	}
 
 	/* Probe result depends on the success of map creation, no additional
 	 * check required for unprivileged users
@@ -559,6 +660,33 @@ probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
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
@@ -567,12 +695,10 @@ probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
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

