Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3537A52D5F5
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 16:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiESO0G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239582AbiESO0E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 10:26:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275C32BB1E
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 07:26:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JCoDCx005135;
        Thu, 19 May 2022 14:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=gysr1DhrD1NaFzre2kbi0OD8gj5wTQDz5DnOs4z1u2E=;
 b=PcyHQVlRXtutNwG8h2htKecXFcANeZHrFs5AsL6J6tYDnX/aU40ECNpwx3Zi0QGp8MBh
 arVunvspmQnP3jR0rj9o6H9i4EZnGXkEM3cAMn8AI8xXTEZ3ufPhdu6K+7qksNx1R2HI
 3aiWKPxPRQpqj3G8E5FF83MwC945IJXSFiC20CTo/FQG3BieuTsUa6u69YKd+yFXjQEU
 PqZq9acLvYHRw9s863+o3E6dEmNRe/AxmQk9paDvrfrGLbNP3Rl3gNoTJIpGavWJcJMc
 DnHdQZAdzFB/daXPsgUFEbndNBPuuFUz2jihDNyHLHK6K/x3OT9abev24CNpgzEO5BBh ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytve8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 14:25:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JEKCeN007297;
        Thu, 19 May 2022 14:25:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22vavjwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 14:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exYbjAT5fo744/MwoUWgvhWh9K3usQScdUYxbXimk636ebymv4ZzCKJ2ZDiCL8pNN4uSiTi3rxUT3ZiP9wh2tz9UOL03Gu+GAMK1C7e38k4hr/aX6bIveFllN6JFAUx9iz+nsO9JnH24KIPOBy6Tay8ismcmJnrajYFiGlVVJ6IrxCed9BsERfvmMYDX+BT5aEMuEGxGivj6agwHfYcfg0AiqwKyuCDjG+750VRa3322e3xD6Q261O3nRyH+NWkOxmeXhmSCC9SzHUg4raI36yUkZ1RJ46ObbDJkywc0ljQXRA+sDiCIsJTetV5QS/kKE7kRgFAaxHPvZ4BZmwWzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gysr1DhrD1NaFzre2kbi0OD8gj5wTQDz5DnOs4z1u2E=;
 b=lu+r28edOxXGgm8katK0fSJPW+REgz4zvqr17jxojkUQw8GsadpmXtpwRWmXAMMUa75AykbYDkontyFjKMjC3nrqQ0EsIvm1mwf/hOXht3gMSI8x3Y+mr0yTm+Yh73GO8iyFDRdmOaQan2/DeQ8E+lOvQXjNXzr/I4X9mGWtOKdXz1lnCs8MtfYBLef7V+SG5zDQpRFKgRvMBh23t3lzMCpuiKQFHHkA8tzOM7pJEHLn2E0NVuSG/99GF+A0dfpz0YhwfT7pkkZwERN9UKbqUei3v2z+yDXETSi7xfKhWfmetWzbuXIwBnVgizuNEvrikJRoRTRUTtqIZLIHUIknBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gysr1DhrD1NaFzre2kbi0OD8gj5wTQDz5DnOs4z1u2E=;
 b=ggXQrgH4YtBp3BT4k/ZqCesQUY74w6Ia/RSofrVJInYpxvef4z2Q1fM2l1ztx+tf0FUHCXogFDLFIjNcvgxn+3AFURldmdI6ssmlhYK2sJuH3xN3ra0KF/EBVWBjImIiIRNs/sdbTFa8XAfEfZgtNTlj7JlC9yl5/Y2tMKFYuQE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN8PR10MB3588.namprd10.prod.outlook.com (2603:10b6:408:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 14:25:41 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 14:25:41 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 1/2] bpf: refine kernel.unprivileged_bpf_disabled behaviour
Date:   Thu, 19 May 2022 15:25:33 +0100
Message-Id: <1652970334-30510-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1652970334-30510-1-git-send-email-alan.maguire@oracle.com>
References: <1652970334-30510-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7bb70ad-910e-4c6f-bd8b-08da39a373c4
X-MS-TrafficTypeDiagnostic: BN8PR10MB3588:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3588F713A7B6C80249A91539EFD09@BN8PR10MB3588.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fETLpvDzjzn+8tP6rixwVnkFWPqZPArGMxcC2/p5OLj4ZwhNdBJzUfMAGHYbh3TUWSzNl1luRz3J5+lqxC9fz1PrLXh0rWpzHNFCfvDnwxammcPKDrMx3eQXXfrw4As7xRzQLRBWulEZm7CszdOYGehXyH9+ao23WjsgGHxUA1zSdgMh75Z0Sp96tX9ONNEYDe6w1x3BEV7tE3PEcEGNpn1mlfb5v8o+izaSlMDnV4UMbVzWjGd3EF9JC1aJLCf8g1+nzfvrqsDGe8vBHbNXG1nRzRNwMGHqql8B9yJ0Exd92l+8g3VpGG3tRIRBSPDLYmcuxImPmqH38mw+5MSyJ7N5L9eyyYPv4tfzhC9Lv5IVCDjLdj+vuOnVPzzoH7BjX0fZJs5Vw7YDrPdPbe4UlZDUAt6idDX1WKcL5IiVt7or+UUI1klYwzEh5XymlA57v1pKqU9xHksKy2fk3sv4FiAwsu++3YhiyCKMgmXRcB16w68T+ppRA73AwuGiW+v5nyFKq076RRDi3sSeh8Y1xv2HKZq/3JXJkh+59+O5VN8KlcMx8RYZJNtYZJCsfKP6B+gT1aNOe4B+S717vR0rEFQoTHRku10/mKH342r0nIYLVKtYMNHrRPOr1g2x3J4ii6x9ledXW9k1h8GvwwFl6BCiYls10ZfxfPE2k5BMZz+I4fXPpgiO1IIYvqSN2NKrn7nIjEXjP/2OrXy+FOAbyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(66946007)(66476007)(36756003)(8936002)(66556008)(2616005)(6506007)(107886003)(7416002)(83380400001)(44832011)(26005)(38350700002)(6512007)(186003)(38100700002)(4326008)(8676002)(316002)(508600001)(52116002)(6486002)(2906002)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BVzzcCRM0Sz/VxWWkKWrB1LxQTwIPiQSB08tdJul2sTUWMOPvgBrMDaoGXIK?=
 =?us-ascii?Q?2+aOZneTL5CUvnX2eIJT7eCgvfKOJTX57qP4drMbA74suODgDb6jFhesbPsM?=
 =?us-ascii?Q?hNnDLgxgnAB6G3Cmw6NZRxKBuC1/IqWn7+fIEf/a6e1LdJLzNwm8rCdhiZvZ?=
 =?us-ascii?Q?eINr1I+ju0U//5bE87BIpn2fJHuuw1P9xuyO70X+kfuXzHKoep/gJfaN/N0j?=
 =?us-ascii?Q?4bXcLiUoz97wOVFjTkXRsx+Q7PhYczXbUuTDntDdt6iA2xTKnt4RU0moC7sO?=
 =?us-ascii?Q?lLvZFyv70YJ5Y6RUHEEKmTHj0UQLbBNu4NRLradt3LtDYbxK7SfvfrTdbXlQ?=
 =?us-ascii?Q?lf55eKGFKjwmcXSrm62/hgYa3REhhFSFjT/i1ezSbcRvWB918yI3KF9xX/6I?=
 =?us-ascii?Q?cCm/5KG4aqZMrfRiC5Wa/RLYaEC7ekrQLesTgMguCVxtNMKqcfJbvZMrkPpG?=
 =?us-ascii?Q?2bs3Py6aNwLybiGO77YwklWz4yclOhiK7owbDfxoqP4/YVzawc7GAKgVRcFM?=
 =?us-ascii?Q?ixfb7yaZItkpxmMu/iJtyz3C7s+ugn0LY/Od9TJbaa80uCVhrAEYupG5Qm9B?=
 =?us-ascii?Q?SC3IPGbRkP2poRKpO1geB9EY7PIlvvIePfnNlfhfNa6YddQTeeQleXH/2Oyx?=
 =?us-ascii?Q?nxL+2qc8U8+IYGw4CQ+BYxccvTeMxcqukilcRxBRl/RIfnKmbhVp9PKme3Mv?=
 =?us-ascii?Q?INpn/y8WG7Q7uzyisyTLb2X3b+TGJXar1VAZ0PqYNYHVq11btRb5VVwZOxws?=
 =?us-ascii?Q?vNastwiT+4d4EfU+5cnqg3733VdAQUbGsDYbey6WKHGUi0R3xJSBKOtmKyHs?=
 =?us-ascii?Q?t/HNJE68dVdF7ToOcd49+k63dHvp4WURyabG57FiGCNbp8yBJ0Lr2AWDgZn4?=
 =?us-ascii?Q?R2H39w2qoKkEt2ZYqN7HOMXdFGvWqihFP2r6MXw39HU4s7pT1zT45GaMtTCs?=
 =?us-ascii?Q?wUywhFG1qTYn4lra3TVz4bFlMNQ+rL2Z7RimsikXe9b3wxz7P/rRmrt1+WdF?=
 =?us-ascii?Q?7oSI6JdWwjjakH2VRuCRj+FOvEyX7xfsdBBxgBK5XSoUWG7JPC0Tn4Q+Mg44?=
 =?us-ascii?Q?jNa4qSEJBj721UTo8vbfkNBY76awPlF19voFeFuidsbZ3A4tvRSxqPsXLE3O?=
 =?us-ascii?Q?4Uu4CdCv4n7zELhwGSh0fUNdj36d+ttICfy//77YSD5hL4x43FlLIKycWE+b?=
 =?us-ascii?Q?fiXdOlLxzgdR+bVUyD1znaZVwh1WYeLZXJUw6Ni1UHDeR7yiCTAdZr8WY8uX?=
 =?us-ascii?Q?JOvPAYt/TtZahSOsuNmqWIHVsCy2fv9GRFD/m4ZKDzyvLJslvPHBIaPDLdZe?=
 =?us-ascii?Q?5pFrZLEtS0mi8M2FdFnAwq1WhjuZYlVYKSstWo8wPjZFCHS2EJieuaguArMn?=
 =?us-ascii?Q?BsnyCPIGWT0i+Kd5dLiF5vWqD8vvKzClIQtUPYejDYuSi3674d/MuyQYnyLE?=
 =?us-ascii?Q?CmamQQtztrfaDcizOvdKo9ZM4CAG2R+gkKGdIT5SbzES/VHI9iL8ezY9a1AO?=
 =?us-ascii?Q?BXJfRYPpGIDeOjJnWMdYwJv55yosyPJJJM6jJFXLcMQuyX5GLdx7xkRUFsRa?=
 =?us-ascii?Q?55YYbmGL1FJ4Zz8upqtcS+SDwKIIt0znSUFt09GOL9WFI60eSXKk5MD5LPBe?=
 =?us-ascii?Q?nYTNOsWIM7Pz3R8BZibdYQUeFFQLMmdf0Bi7EgXOyq+M01mEGfF7YOn0dLhk?=
 =?us-ascii?Q?YAgxFqVbEiGG0vavH2AKv1s79Oibn513iZjzc+TjaF734JVR03+ynVKh4lqe?=
 =?us-ascii?Q?I2inR3aKxg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bb70ad-910e-4c6f-bd8b-08da39a373c4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 14:25:41.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vElOJjBQfBh4ZHTIyxyzqwOJyEtvAn/oGkEm4hgPWP1misJ8mi4JRn2flwphZR8an5tt5tQWEZoI67ymZru8VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3588
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_04:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190084
X-Proofpoint-GUID: m9eOwwlTZYhh0gqiDDBZk-z5lb1EaZJq
X-Proofpoint-ORIG-GUID: m9eOwwlTZYhh0gqiDDBZk-z5lb1EaZJq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With unprivileged BPF disabled, all cmds associated with the BPF syscall
are blocked to users without CAP_BPF/CAP_SYS_ADMIN.  However there are
use cases where we may wish to allow interactions with BPF programs
without being able to load and attach them.  So for example, a process
with required capabilities loads/attaches a BPF program, and a process
with less capabilities interacts with it; retrieving perf/ring buffer
events, modifying map-specified config etc.  With all BPF syscall
commands blocked as a result of unprivileged BPF being disabled,
this mode of interaction becomes impossible for processes without
CAP_BPF.

As Alexei notes

"The bpf ACL model is the same as traditional file's ACL.
The creds and ACLs are checked at open().  Then during file's write/read
additional checks might be performed. BPF has such functionality already.
Different map_creates have capability checks while map_lookup has:
map_get_sys_perms(map, f) & FMODE_CAN_READ.
In other words it's enough to gate FD-receiving parts of bpf
with unprivileged_bpf_disabled sysctl.
The rest is handled by availability of FD and access to files in bpffs."

So key fd creation syscall commands BPF_PROG_LOAD and BPF_MAP_CREATE
are blocked with unprivileged BPF disabled and no CAP_BPF.

And as Alexei notes, map creation with unprivileged BPF disabled off
blocks creation of maps aside from array, hash and ringbuf maps.

Programs responsible for loading and attaching the BPF program
can still control access to its pinned representation by restricting
permissions on the pin path, as with normal files.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/syscall.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 72e53489165d..2b69306d3c6e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4863,9 +4863,21 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
+	bool capable;
 	int err;
 
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
+	capable = bpf_capable() || !sysctl_unprivileged_bpf_disabled;
+
+	/* Intent here is for unprivileged_bpf_disabled to block key object
+	 * creation commands for unprivileged users; other actions depend
+	 * of fd availability and access to bpffs, so are dependent on
+	 * object creation success.  Capabilities are later verified for
+	 * operations such as load and map create, so even with unprivileged
+	 * BPF disabled, capability checks are still carried out for these
+	 * and other operations.
+	 */
+	if (!capable &&
+	    (cmd == BPF_MAP_CREATE || cmd == BPF_PROG_LOAD))
 		return -EPERM;
 
 	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
-- 
2.27.0

