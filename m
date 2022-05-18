Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C60B52BC6A
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 16:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiERNe5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbiERNez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 09:34:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9468615E600
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 06:34:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IBn1Bk011872;
        Wed, 18 May 2022 13:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HsIE4VoHEmHhJ8h/FcH6/fQLpk/GcJAoUWDTtYkfjI0=;
 b=P+miHpbYxUaxZXfZLv1g9Our70+rNb7dQgCakIh7LqNmgwLELpbWIC4E0KrbNGadcGGb
 hxhD0E64SM6MOeMIsH2h7W15wLJjy1RXytI1d1eGtEe1mOG7o/gxpzA4oabjfzKzMa2Y
 tUgZzkn5j3S4bNeQV3boSRYks7fDoQoDiXjQ5qt2D1tMLHB5NCMDf6YGQbpYLawG6wKf
 ShM9Y06GDjqhkxvjYSLEKZNfIkyUNSfEClKf3GeWvPHtgDs7+D1PHVPRUY4kfTm+axF1
 z69bcL/JsChEP4wF202gi+X4m9ww9iNBF0/fL8UNsj3229CrH5UROzwyp6hrlqVRIf+P fA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310sb0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 13:34:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24IDVnHU008066;
        Wed, 18 May 2022 13:34:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v4d5r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 13:34:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C22AenDVlVocjmZwIxTD4d85msgRbQWmA6QFrQ9Iow4oFTyv1F/pJ9luRSvGDr36Mq8cn2egzl5oU6625efX3s76zUcTn4Yg2jF534nMDi74AtHnMikoQyTHJKtzVoP1oGurdNIdwMymq2E0VP9EcMoOI2e8kJW6S20ri6khRIveGpAzkW7F/28muKnljSvknSKy5dUpB2GlLrj52wjud0jRY7dkpHwwv9hIe/cOROTxsgAALJSfJmQDIQixUUgk+rBHI4UHGnBd99seJb1TQ/GEAXfX8/cP3MiIIVgRxp+2jlLVnYQG74HkzH+KndfK/zJ7BGlprcfSJAhnmOq8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsIE4VoHEmHhJ8h/FcH6/fQLpk/GcJAoUWDTtYkfjI0=;
 b=QS9nAQI5P9+OupuGNGg4ZuiZLb5Vdz+1zdcnjnhwfVX0wYUeQiVvhCLxgu7x1GZCYRtcwhOu6kLI9nSEtMejb20vnSlPa6e0fpxu8Gkt0B05lIEBnV2fJIbl1rS0PvN7A3CuUWeVePjTpakVs76htoNz6vEBctra7O1X/k435WAT57siZZTrmhtzWamf16Pu+IsAaPL2CubGauKugIYmfsvlg0bGYYyvHlMEn7umAHvqgS/bEU0AVayr0uaYPFWm3ESIONaTpHfsO9nRK/Han29WCHkwAhqB0GSBAqANbodM/x3R/cKUJNF7+kap2Jdw5wEUNY1mXs+z30kO1TJZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsIE4VoHEmHhJ8h/FcH6/fQLpk/GcJAoUWDTtYkfjI0=;
 b=C7aDpRd+XhGkGE/IWZoJkxeXP/hFEvMcWSLCkjgXOztnQIyIE8HfNhBAa1HlpXOnDtytWDPI7K41ygjibHwfCTAm+S7i5lVt+qXkw6VmzcYi0V/6QfWDUU8qvPrOKvydV7Hm/7xFsTs4h5haQa650Yfpqz6PZsXbaG56v65Ve2E=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5836.namprd10.prod.outlook.com (2603:10b6:a03:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 18 May
 2022 13:34:27 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 13:34:27 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: [PATCH v3 bpf-next 1/2] bpf: refine kernel.unpriviliged_bpf_disabled behaviour
Date:   Wed, 18 May 2022 14:34:20 +0100
Message-Id: <1652880861-27373-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1652880861-27373-1-git-send-email-alan.maguire@oracle.com>
References: <1652880861-27373-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0078.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d696b4d9-57c8-46bb-3697-08da38d32133
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5836:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5836761ED04592696846972EEFD19@SJ0PR10MB5836.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Doz+1qwaXhxngKuFCEdYjyBJEWPWx1+47Pka2BelamJLGjkQ9FVYgTSH2CdFD/WjhW9Wy8PMFRNu4K2noacDl/J8PtIZs3CMtdCtf+PmuneOLp7BL1PPYIUj576uJDA+j80CBaPk3qCj0+yLAP/5WFAc62ro0CZjSSm/29ZnPvBq+mhENJe3MJPFAUA5H1We2xjf1tTdZjjIEs7JGsCAhhRn8/9GLjm1ZbdwQvqLU9XuF0mSI33A0P7vaLTKjDtumDPZRjLW1+KDAMS7Prq/wX07maEPDHJWwyiTth6Cete+eSEEbtHriYjvnaD5urovlGtHm6de5DkdVdH6WTzQg8YdWzzNXwrFQLhtoJz1z4y+ThtBnHdaJWPqhpWvmfscr9eHB50LiUiO3A9pG8hNMt7v/jOPvU9gWGs6eMRf85bjwp57C23Gml+miTCjumb0zxy4I8csmu05ooTlUVs7wLenlEwGdXlNCT+Am/wTTscCpGV0l+uITMqUvAIYAZg7nVPj/MwMopBdKncJk2yY8KzsGsusfg0ksMnasACvbW56SyPM4E2Blyng2wvrWWZEGJn9X3jMkL9TMoR60PUjwP4gOapznr8OopU4YQXjUKbIs4zUk+qnrmYUZYFfT7d8/w8qH2h6uzXT4ZqHRxYKZ1Gvwk6ZYg9OWnc+6DBIEsU4kgUV70nV6IX5HcTerE6EE7XNvEcd8/i65+uF232BWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(316002)(36756003)(66476007)(6666004)(4326008)(66946007)(186003)(7416002)(38350700002)(2906002)(6486002)(508600001)(8676002)(6506007)(83380400001)(38100700002)(66556008)(2616005)(8936002)(44832011)(5660300002)(26005)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+el0+2PwQtCdVdeCZf1KM7tlgC/hSchVPJaIJqH8nkcaodBtZufpVrMCRO4v?=
 =?us-ascii?Q?e9o9yiEgfR58/qK4tkbT8YMLFOjXaI8K89cGAE9z+KIetNNa6taI2oDnHBqE?=
 =?us-ascii?Q?/SrpqNsHWz/9fWE6n3UAH88r9Ko7/6drN1W8EaNSYq9sbEvmu+EtDitYSsx7?=
 =?us-ascii?Q?sAoQgwAOwGNhxu0ws/wcfuxUj3GoUj/dLxCYh4JdwLBaRHYLw/KOMjs4XeMP?=
 =?us-ascii?Q?q5lQqclqcZZ0N3yMjPkZwxKe+1b6I2O0/RwE6Ft6OodXYy9NFpVl4Yr6b43y?=
 =?us-ascii?Q?MLaL3P8IjNaStAK2JpZpPYIJ6heYS2A3ymhmfYNpGA75a2sd4LDnU5u46clz?=
 =?us-ascii?Q?N+3xqufT/f/dqY9w+5OGSAGizAI8XOQ22w0mAV4itcv7UlWRinsELthMpZ85?=
 =?us-ascii?Q?jxj8F4rkj/P4gZh4rpL+d71sFt8XJXwlSVzI6dz0jMZqWqyRlcaDM5YR9adN?=
 =?us-ascii?Q?etpbHymZSehVv9q+anHbZ4J8s+nBIgvgvo1pH6TXq0TZQWHtdx9+1N4s4zeX?=
 =?us-ascii?Q?38IFD7NN3A4NN04YQdDjkN7PsX4wKD/kP4dm9F1iUbxYzzQf90e3r6BuIT8U?=
 =?us-ascii?Q?hiFs2Xx0kk35jXhKg4EjtCYcZ7aklSlftAIuQAtK/AZ7jB8pL3qt+ygAPN0T?=
 =?us-ascii?Q?Dl7Pd/ZllNm7SY2cF3iK12EV2myvgpCI186DRQW7oBhBk5+lupO9zXM829lc?=
 =?us-ascii?Q?8JESS1xkaim/eyYvrghBFbabElPxTpBVGNpvQrPkitWxKz5ZZMOCiIQt0H1n?=
 =?us-ascii?Q?fcHN8YGgugacqhjD3Ag0QOnSznTPuffcNeELnOMl29rVyVc1BlsNmSZ+VwLe?=
 =?us-ascii?Q?456NCp4qpnaKNfYWL2voSbCXli9roXjE+TnLyNTJrU3zuCWJKF/0Yb4eRpub?=
 =?us-ascii?Q?pcV33ORc0fWzbAnU6toR72wtfNcqUfM0s5ngdZI6ffTR5V0tEDqoWKjbz5X3?=
 =?us-ascii?Q?1ZdOaKcO/itDS+Pc8hC5WxULwcWluDrgKAc02aWIJ9qFnkS/An6+pENnJ+aN?=
 =?us-ascii?Q?8BQwimzOP7FqgchMvsO2NmVw4tsT+HJoCTlO5Uh5YBjh1pB07U6m0RI2PW99?=
 =?us-ascii?Q?HkG1GT+XXF1E3MDtp1h3lSQH5HsXvw4Q13O8l/hpstyCV/ulpnnMviidKEoz?=
 =?us-ascii?Q?o+jTEE3WmElYLZHrQUSsWfToQDtYE/sJ0GzqtzzWxuUcmnyJiCOtB40fdMG1?=
 =?us-ascii?Q?U5yWhFXyq0f9YwbJ5B0JhPXlrHtcUYAU73m0WeZOyf3NZaeKDJGjNT78J336?=
 =?us-ascii?Q?zPc3D9roRJMaKRz6KmZZq4/uCEGgyMrqHoDRkv2MYOmLfHla+7dPLa3ggaXn?=
 =?us-ascii?Q?myRv93ZWCqXiyOF234xxlI6wGNdnmWUimVemgDItXJ6vnDt2OHUgjlSPqDRb?=
 =?us-ascii?Q?VQYjpWAG7PU2hrL02Xp8S6Ve+oORmjSHfYPkI8PG0qnFa5bN3FqsMQTylgwm?=
 =?us-ascii?Q?GkRD48KZRa8Q/I/EefBARfkhmUbEQWWsJ6Sj+ZPbeud8OzmbEDSrT/JHL7mn?=
 =?us-ascii?Q?BpJHu4fSnbsiu7tGMI29zLdJHEx3R2QeOrfUNcb/ioxEYyPM5iNpQwGF9/f7?=
 =?us-ascii?Q?S1yippQsco7NlWnodkxBlWKc6iDHUwVqVKPrqAlbMd695rwsoWEIfmWBLtPn?=
 =?us-ascii?Q?SydUcdPrXDj1pKLHhkAkhLp11t+TlqdpBQGiCEhDpx16kS+F32PsgiXxaphm?=
 =?us-ascii?Q?WerprZH9dqBJGhuGhIOdBOVEmy+d9O5Mw4qmw1eKoAsNMNcGFosUfgACy9V5?=
 =?us-ascii?Q?y0Bcwdplxa2PW3mEEOBFNp9HVfYz10A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d696b4d9-57c8-46bb-3697-08da38d32133
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 13:34:27.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxuQBX9UW2di3UPIZJAQfJwv+FBHTL48g6oGYx3IqC5N69qrbek9qbS56jWoqCk1KEzHXSDHVlrufWEvEV2L+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5836
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_04:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180079
X-Proofpoint-ORIG-GUID: H7xsahR_6UM0yHlhn71VEUJ-hZeCkcdk
X-Proofpoint-GUID: H7xsahR_6UM0yHlhn71VEUJ-hZeCkcdk
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

