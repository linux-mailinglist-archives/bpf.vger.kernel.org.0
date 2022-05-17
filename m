Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B8A52A0F9
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 14:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbiEQMAl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 08:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345749AbiEQMAd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 08:00:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79254CD57
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 05:00:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HAmagF024638;
        Tue, 17 May 2022 11:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=kx7yr4TDpwxIJTwBqkttYR7t9Hts7LN8UkvrbCfnotg=;
 b=XQ0SmOyDQAupTv1SyqXioHgKqrbFw2tfUVmsU7jZoTv0+A1zJoLJGwvdQe9nqdNEzNwe
 b7zM0HKVtZq/VW1CEEsXa/czNyQME9/H1PkCO6BMl+LUs+CzZCAV3BMV8/TfIFFyYtqB
 5+xfco/OHeLNdBAJllt/hbdsjP8DWN3kDEAC5hFxr1ATv0xKJPr8qYbFyBP79FaR38Cm
 pjDiVOhQUglKdLAEB8VPQ4eTL56Th/WMD9lOGmz1WbZEZTCw4j1zAuJrc/KGYj1/q7Ql
 uxzrtQ1yUA5a7nnUEUXVCWjTdBEE7uOSRqVkjdMHTDEPd1kJMCmcVU8J9tbEpTk0N/ur GQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytp0rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 11:59:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HBtv2e009481;
        Tue, 17 May 2022 11:59:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v8jg6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 11:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDTZkimljMfBuz4Ip5kmHDaxNIDCGAVq4/wvCKJ2F6mTTiewyclYDaEDb83baDKvQtmfSZGcmueI3qQjILeXNsB/I6E8vfU/NcEyAzY3AS2cLLI/6wnqYxmpNX4vy14ipQpZUQUFptPl+0D479hR4ugY9rTFFVMEaHkuIKoWflRfPAvTSG+jHr56R6mx6QXML6R5kHC2MKNVMQjXsnt0Z4/BWZ99nNXtM5b9g+50A87cmCceo+gAHsHemmPVP4jC6JDN0QsPvBLGhxKyjVVYFZmrORLfFgsvvcZOXRJYyh1/bCOFnoQ54QwVit1rt+8s0gp8ExgOUln0hkBARTn3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx7yr4TDpwxIJTwBqkttYR7t9Hts7LN8UkvrbCfnotg=;
 b=c8k+jBzvmLfJ8d7OF9nNqfYJe5/KlJmi6SY2C/Pms77oGlHxlxGaUccXBqs9NIifj8JHKonhs9WjHkwxA32ZC8Msld6nsk3KtCd0nj9kclOhIhIh0cUJwWZurDoQaeeiuCprVy2XoyBTssfSLBe2JBExOZGF+pWIWHGd8jSkbAZ+Xk8ExI7J+MZspPJvwVN3gWZDsZwAK+TthXTgsTuJzBb7j/KkaCEfZwY5obKdvoIir2c8XUJ6U9Wu2OYAoVL8fT7l0rCMv5v/2+3ndaGBK4tONOh/xjS8QPiPbs82Usb7qXUx/7q72bKIGhclB0zNeCRaeCuR9szLrDTpcW7k5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx7yr4TDpwxIJTwBqkttYR7t9Hts7LN8UkvrbCfnotg=;
 b=XS+CXJ8Vt75TPn00vowTutEI5mWpjF001gTWijvTlpHS8V+kPyoHbd6UEF6Eqj1wMy7rvsb6kFC2Wl4Arz/hy1LcOeVcJvbO32RrAR2KwSOj1dhsPQjeXph92KaSOjaNRd9mY6E+PnkiJF/IsoehQ2Mqmwtw6VCNS5GfzjLh+MA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM5PR10MB1305.namprd10.prod.outlook.com (2603:10b6:3:7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.17; Tue, 17 May 2022 11:59:47 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 11:59:47 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: [PATCH v2 bpf-next 1/2] bpf: refine kernel.unpriviliged_bpf_disabled behaviour
Date:   Tue, 17 May 2022 12:59:39 +0100
Message-Id: <1652788780-25520-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1652788780-25520-1-git-send-email-alan.maguire@oracle.com>
References: <1652788780-25520-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 532f2684-30eb-4f08-187a-08da37fcbd3e
X-MS-TrafficTypeDiagnostic: DM5PR10MB1305:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB130511CE899B39A92BE9AC2FEFCE9@DM5PR10MB1305.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifIV7tPFjQbvKPBdPIW0Z5nTaVze8PnGkd+/K0jCz831JEx6u2P78+sgwtyIRDjoTojQdyXM+9BsI5WSd9fItotMOtSRJEpqRB2Dd/GXok7lYIZOvmZ+p2mWuHH0iUTPw5IYCcCCL7pZ8RWLKS1nFsqXEhrXu0eHoL9M3qyRfpmBm8sHMmyo8emUtxAfvoLS9faXhs4EkyZHBp7nygWl4rO5XHe+enNo767PrsRCaIIatJ9HW75uqCi+gbHwCuBtp2daHikFC4qHt2fSsDimC4PwIvwdzPlj0mebJcyW32IcPiOtFF1xK8/8qK1VXG6dKPIeFEjm1WDOKkVF107ELz4UQxzovOQN40pQBZFtbV+DS8F7hPA09sL6luhqKP3J+XKTxH4LnPvZ6XuQerI5dbxDfJ0Gr8We21M79X5jcGnd9O56rh167zxy4ZLA/8iXKbZVSgwGZTZmjxRuznrD7VOQq8NxtOahZMW0L+1KKi9BfGAMUufaVHQ60yazdlhwCOrJDdrDfBkJZ4P9QQXOq80KFO0oaWnrtZPij14XI+maBVgu5Qod6N+0e/mG3FvrXAb9Zjb6wmqRucf/xu6BsX+VBjolwcQ+g4howyibY8iv7XpPTENqXdNV3RqFlXhaD/Xp3fjWtz6J3IMnkdWubMP5cgnxlf04ckpOWsAAz0X5bVVT2gngoRQO2yMp7bfCl2z9lZm8eAymcgy8xAZdCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6512007)(83380400001)(2906002)(38350700002)(38100700002)(66476007)(8676002)(66946007)(4326008)(66556008)(6666004)(52116002)(44832011)(6486002)(186003)(86362001)(7416002)(5660300002)(8936002)(36756003)(2616005)(508600001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nt6ctXuHvyOkdJhqtu6TmJe5/BDHpNsB5HQJFGfpVb1XAvsnMGTerhQCfT4C?=
 =?us-ascii?Q?PMroUgLEpbMC/a9UupNXMAwXEahqHk7pH9bzPyErHzZ8JToO9nwabTSOzFz8?=
 =?us-ascii?Q?1a7zKdxFNzvZa710Bdgc8fQV5O7YUpw6BsZptZ4N4Innb1O2wmL8wPIRBo9l?=
 =?us-ascii?Q?apuNw9jgk5Snkc+PplC38ztBSXA8Iwn6/0CJiI7C7ii46BGejtxw71Uqc3p7?=
 =?us-ascii?Q?EmaHTGvnvw7TyapSSpeDItU3/CzSmk1W1xb1XRdxFbP8wFkroVSUG6E2dxDo?=
 =?us-ascii?Q?ztcLd1xAHF8CK6ZOKE1+gpOul8GqD+jpHb1jVZJvYT8MafCZk6StCjj4HoEr?=
 =?us-ascii?Q?xocARgBZLJ0U7rDK9Tb8eligOTh1/AtFgVPSUxWgfcCAfs9brUH6YUZO7IJf?=
 =?us-ascii?Q?XFqa9T+hjab5i48hp5GBakP6f8LGevwKkeMnyfslNtLo3UHAEVaW8w2PCap0?=
 =?us-ascii?Q?0Ty5Uo+WuA7AwPdBfGG+LtO4sK6CXSW/cHFh0yPsGShuYAbJCtLpenRvAlDZ?=
 =?us-ascii?Q?YvXctNL52GJAtK/uDGnCTWq9UHrVxBI0MepxME8LDY13zMOc3iJm1wrqJspZ?=
 =?us-ascii?Q?wSZ3uMRwEyztI5vTu6w4AiEJ5pcIyn4wj648VTUayuVn9LTR2ckAp+dImS06?=
 =?us-ascii?Q?9RXi4dXhYt3MhC6xfrNq0BgH+zU3MXmNxDGUx7WkAo6CQJ9VvlsfsY1paEN/?=
 =?us-ascii?Q?PdwHJUUJNWieMMdgfqLisO7mpG11asOE/P5e0q0w1vgcAH6f++60/zp2eBBf?=
 =?us-ascii?Q?oLDurWMvo1L/dWckYPvxODpLEVp6whWu6cfkVL6yUfmbsVIU3PNjEN+U71we?=
 =?us-ascii?Q?8mnvlmyuXAYSE8orbG/U09ugksFAIn6MBGGtTN1c2Y840ycJHGjFK0CnChA8?=
 =?us-ascii?Q?/v0D8xyhx46i9KzqwEwcs6LpfMDSdHK4m3w/8n9U+AfoHFepjCzP6v4SmnAy?=
 =?us-ascii?Q?ffeCAWQn8h89m4ZrcWKYDKmrpwUfFIsC6yEerZoRyvW5eVGETiUasBIvHDYv?=
 =?us-ascii?Q?kYLAamtCj42R3cshQpIBKYd6KvussJPoHuTlwFyoFGCoCDIqMils95Tz6hwi?=
 =?us-ascii?Q?ZEk0GwX/N5Xk7xuJap/lJ+xFUQBiQWkjfXt5SB9QEdy+jmL07J/MIuAaz+tt?=
 =?us-ascii?Q?bCoHybOW94gFSgQGZsMieuPTqUzqkgfnOV6q8FXxfGQI+BXSUjYtdiRDhrWJ?=
 =?us-ascii?Q?SueDX0UXwRKRjZnu9XB+HgJBOf5D3Ps5fDcDFAz88bd5BsRWgdr7Wia/MQgt?=
 =?us-ascii?Q?UUDYvWSwimpy+jhju44br4qSR2b4Pig+QKLE31AbQJrlY3o6FUJ3+XyNpw22?=
 =?us-ascii?Q?L5fE/Sn1YDRjsAmaIKaXyqUgJ4WrpYNcQWLI1yERGYkjjjZMfus8lwvp7CCk?=
 =?us-ascii?Q?5SztttbZ0HX12I9tyvGzg2Q0nUkwbgAKCfU5WyjiJ2eqhXYKnebMW89RI+Fv?=
 =?us-ascii?Q?LIICz9GZn2YWjCteUY0hYhtwqwJX4rXHgO8EhGdO7XI3yW3FwkBklo/duvNZ?=
 =?us-ascii?Q?IXJXf93Ju9ez4cBcRxVIdX4HGVOPJVOznRoTieyzA1YXO2no34N2uEN1OwqE?=
 =?us-ascii?Q?ldSlc7k+APagltuxII5GeYtn357hkEeIa3D6ughgvNNqzOpYAfA/ZbKlkGZr?=
 =?us-ascii?Q?J+758hsDI6pnj6hAIFDBPFQzx7d08B2plPrG5ul5XpHK9Zk5g1YX0B79IVtl?=
 =?us-ascii?Q?m1N1lumncSty6tG0TTCuaeAT+gSIdhJjFnZuQ+D6OIjWCuzXRJzlRZdwfGmO?=
 =?us-ascii?Q?O1Y7Ayxa4P2V96NetXGrAdObas5bJeo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532f2684-30eb-4f08-187a-08da37fcbd3e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 11:59:47.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIy1ZOtoNPQ1BlmdrWRyRZ7ZOnJ7rKEoF4eBf/CubacKqY9m7goak6WmJypJGG99Ldj+DsbYeUKG4V0ZJSJcyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1305
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_02:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170072
X-Proofpoint-GUID: XfbhbMLyefabVDFZ-f1mXoBcCkA5SwnO
X-Proofpoint-ORIG-GUID: XfbhbMLyefabVDFZ-f1mXoBcCkA5SwnO
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

Fixes: 1be7f75d1668 ("bpf: enable non-root eBPF programs")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
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

