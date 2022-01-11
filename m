Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3048A93D
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 09:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348845AbiAKIVV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 03:21:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16914 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348854AbiAKIVU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 11 Jan 2022 03:21:20 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TJGa022679;
        Tue, 11 Jan 2022 08:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=hejeudH4d8GdM9Jm91BSVcPD7jlvSVW106bqYc5MrEg=;
 b=h0s6kG2dMlNRpjXWn8K3+FOKaZEQxn7oeHOwTJpQaYWXq24Ljy5LgkRmW6SvHoegfcjC
 48piZ+9UrUbt0wlAuftAFAZMRooiQnMyOYZpslOvn1vTLLwm5X0AIPXwuCJoS364vWfb
 cbnUhATTE4dPeVgBjXg8CdlFKZrFsdfp6kEQ9ImlNG4oUSFWeJ+VkgUvHS5NP8cC3jwY
 oNavn6vAdcJGmEZ+cott/eizYi3BGjOm/HAJ3uUPddQ5yvU2aKLM++pR1B/gpXVjboZ5
 KNrBqT/h2E5BrRUZa3clYyzflpTtKZOVkXA6Zko0NJXZ/DZxz6QEUb8iFKIWXA5p2Wq/ Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbtra1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 08:21:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B8GRmL042949;
        Tue, 11 Jan 2022 08:21:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3030.oracle.com with ESMTP id 3df0ndqqu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 08:21:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF357CcLUw7RFs7tEmFPxO17KdBHwOADTDvVeoWmtR700p+PZm+93nCTYkNA++MhowmXW/Nl3EAqj/uU2KsEk+x4Q7gurHC1gWDLKDDsiSGY/Gi6j3v5EZgk07WnQCWK8VJUC9YOONhJmOAsc6thasfqJfZ9MYbfljKlIrUhD5oBcwQAvZh8uFdcc8sUTZxSfnswi8FpKs/oCgMzXYMazj4tZABHc+b3/WoMDgBK/kfQTRZnILtlsV2JdRqDDxbuPwB56eCU1D8W/IfnOeGUrJjZHHBLbA2LI3WQGZDDBxtHErlh5W2/sR0r2kCl0kmqf5WAWB9Nobg9HhRxi3S8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hejeudH4d8GdM9Jm91BSVcPD7jlvSVW106bqYc5MrEg=;
 b=Hw5B9MMVJPhng2PBROJvtuN6EXGE4k2l+n/zkCx5vZX44FfHw7JKh5q4qW3yq6Cb4z3QULa7pjvhtpk87BTPEvCzgPQPw9L90eRVJtzZShLgXteqOX5CE4Q+RYtWRX2Z6BaY8KQEova+E/Q9r/6jysM9/lNpJldq5XUebHnZPAjCJNUb5iTyXlWhkoVG06pfy/9G9Xw7+8W2erVeqqg+6kf9BEKos5MTxEkSZ5j/C1o7VaWqzjlPwQSj3sKsH/zfq5XlKZu3WgSi7toFDyIX+kasfkY5usJLw/xvnbIIkWDwlVdJIm9ms1RkQnIe6RK7FmJFp6tahY8ansQAESXKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hejeudH4d8GdM9Jm91BSVcPD7jlvSVW106bqYc5MrEg=;
 b=uvipfyx+f81A2N2j8O7yDQwmdna9ZhTxuZuWxjigzYpDn1M8lZ9AK154IIoYi45mS7apAbbWS273SLL3bwAdp5JKyCJfx9ygyXMGDtzsqwQC7tmv9V3VDFpBEt0cO3cQGUqc9S05Syjr++84ugQvbn9F5ElXXwUt9dz9HW9I+QI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1950.namprd10.prod.outlook.com
 (2603:10b6:300:10d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 08:21:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 08:21:05 +0000
Date:   Tue, 11 Jan 2022 11:20:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     daniel@iogearbox.net
Cc:     bpf@vger.kernel.org
Subject: [bug report] bpf: Make 32->64 bounds propagation slightly more robust
Message-ID: <20220111082054.GA20305@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0172.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98239aa1-3cdc-443d-8ee3-08d9d4db4f88
X-MS-TrafficTypeDiagnostic: MWHPR10MB1950:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB19504BC2A9873AF3A058999B8E519@MWHPR10MB1950.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKnvv0gY5mVkd0v4wPG6BAJc/FkgPTE+RYC+5iT85JQvzVBb3z0T8dfCOCqzwTcutb462FXLDqALFbwBVz+NflXCpzMsFrDPrHkdUDHLlPR+3b5QD6JSG2qjgDg7i1/xFMdOot1Bk20lIV//5+Y9e9rUoT6F7EN5czMHu6SQQS9otliwVQa//WFKkttH18qysdDYitSly3Za4w9a8R1zjmKFXaCrmdexxm2w7jJirxNLxiLDtQKNuvvZemChgXXMjhIGISYpFJSLn/ajH8KDZTh1h0vtM6B8ENcnUccm9SEzMz8lUtiEH43yhPx6pYYmHtZojjEGwegWupN9jdto9wtX7DDe0xCBClJ8iF44ndnjyknTfGOKi4fb0P6sAA4eGogoJdSfccQ+PlpQuUx145V7bAH/PgzmAikdN/3NSXzmdKiJHjQ+ELb+S4a0Wykn7h0PFkojK+XftWNCfZbGXo4Irrh3iFlkNwBfxG4fehZybng0dhD7xHMCsbXy/9Bwh7G4cX/tuzBJW8D73/R++cB7pknymCAa7wNyH57Rf5wmZzQbBrThvfxcoSERuASupmtpGDhUGtJP7v135CxEILl0TgpSsRiXDo5BLhzCA2YupfTZDKK7adeuYd4IDLXGTzPXL3knmzXPlzGu9xUroDHqZnaHFk/CfcYNT+kGSbRTKZW4pysbjrN01J6DsgQn0/NQqYZMxYEbPpOjlkvNaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(33716001)(38100700002)(8676002)(8936002)(38350700002)(316002)(5660300002)(186003)(44832011)(6916009)(66556008)(1076003)(52116002)(66946007)(66476007)(26005)(6506007)(4326008)(508600001)(6666004)(6486002)(6512007)(9686003)(86362001)(2906002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9G+nt/s0ZoAMVFmgAZh9YYat698ry0ahFSKamzfz7CmG7hXKjO76kCqiq+E/?=
 =?us-ascii?Q?fMFnYPPWqQ7K9oewr5g0N1E0TggtJTVNmC6IKUOTyGaMKVylImt91zX3G1bN?=
 =?us-ascii?Q?cWOJeZCiSpF4ArMGfwZRYS/m4P9s9aZzW1GVUf4Ch4RBIlgEXcpwWspf3O5T?=
 =?us-ascii?Q?yoLsH3aSJbw2uQYSrdkjgAiKrAdkBMjaW9TZqjOVWFYt0wMckJPEVzr/9SHg?=
 =?us-ascii?Q?mjxHUW96XgtO1kfzeS7LrK711h8/bsy51SAXOlAjwDZbQb8L6lTVfQKXNeRK?=
 =?us-ascii?Q?V4faaNe7fK62Vz5EjeJLlIRhpXdb4DTtXAOOiMCyHqm8ZmzMOb8KwCekjVeE?=
 =?us-ascii?Q?e1BBmXDSsr3i5hkCWy7AtycsyLfUxZ2a5hsvHnvWj7JyfdXDlwQJz5jNbtsN?=
 =?us-ascii?Q?vjYtD9IPtiRHqDdyUhx3+HSkUDEhyrtzn8Onf9k/ZFn1NbGMVlGekFEv12O0?=
 =?us-ascii?Q?PFMrIStt3TRMgcV8+7R3lyf2ELBSg1moMsoGQB6n6oSWYfNkKnBAGtu73EHa?=
 =?us-ascii?Q?W6J8J5wVxrJv/cb3OohCCGmIKnO9wuI1gYcK9zWAB82lmyLOLTQudQlYvOvz?=
 =?us-ascii?Q?kdk6oC7F5zqsVFuHz3f1CexmXE2fcFm/aNK3i4slVM3kpLGRBxqzG/ZPMU+i?=
 =?us-ascii?Q?uJmUw/zlFTGUr4Vtrg/Ngy1/Nw969j7cAhjaRcOsVjkYQo11fdvKBemZ9aZD?=
 =?us-ascii?Q?roXK4Oks/KlT8vcksdupT8menKqfa7GcCO7it/AlA44ss8PB0HX41M65U/13?=
 =?us-ascii?Q?0ddwxs0IGgeqCyTPkkNyuE7IhFl908WySJCTlWamjzStvxN0N67nOoI4oV+C?=
 =?us-ascii?Q?h1uIn7or8s6JDqnRkxad9lhk7TN3WACWvomPP6LDHD/u/1smEU/R+6aSPDfb?=
 =?us-ascii?Q?3XBFQydZ1Lu7CrIEYbRj2G+l5BB6kUJ3mpEZOg0wMXc6XACitEZQUHjXWuVZ?=
 =?us-ascii?Q?MRNFvb+PfGarjm0VLEXinepY5XpPO+Pz/48arNTbnTiUKVRezk8kcvDgyOBE?=
 =?us-ascii?Q?vDgqpRc2Qmzk2Vz+bikgXJEO7J279tMS0gepscNV1j4/w75ZdHjm1y978n78?=
 =?us-ascii?Q?P8GdLp5yU0XQ9uow9vQUaqdCaX8FJH7hYBz4Fw4yT0FPIxPViuGW6egj4PWS?=
 =?us-ascii?Q?Vor97PkOuvkPgY9nEZq3A0x4fe6B80NLe39plIup5GNqqbW0EGK+jv6pAb9v?=
 =?us-ascii?Q?WaKQSQ3mPWPG0XDkJZXSdMbKfo10y2QlL4AVGqL7j61jOwdJD6OJrFLt8Dd9?=
 =?us-ascii?Q?hZp+X+GXCTcPk9cdceqp5sQefhSKYWte8djL2T6CNe3uLSI9Heu+KZ2Lvsz7?=
 =?us-ascii?Q?x2rDIB2VOFYye+HnGRnGfvtxbmPt1X7RqzNpOZoDCJtNc5YvmLCL9cn0W6ap?=
 =?us-ascii?Q?DyeDkaYGOdnxVJfybkOSH0mRMjGwNdCq/2irXWf0smmjUkwgYvHMaN22604a?=
 =?us-ascii?Q?YSqXVz2W1csd+Y8p2Ee25BaCRUiNIljr1GYNlhrZ7CLv8kMt0C1T4AXhoUJK?=
 =?us-ascii?Q?d/VaXcC+56i+tU86Pykr99cqmcIvdWqGYoSSO8Dw2j9xZzwRo0PSvnnEHr2G?=
 =?us-ascii?Q?bzNKTOKE8cVlmv6pcgt5zHFV7OkVsgddd6x4X6BM5fSMvHETyTMdWW3m/keJ?=
 =?us-ascii?Q?Zk9sF4u8ij3a/K73MH5EerPbSGDyW38l3A4D9N6Cfa5luEZlfYoobpiK0RhM?=
 =?us-ascii?Q?GjnoFOzHTEHmY/J0NQQEGsewwGQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98239aa1-3cdc-443d-8ee3-08d9d4db4f88
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 08:21:05.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6we+f0VMWcbDg9dQe1RDlYYT+EhU+03TqZkYoymyJIyxzxCJN0h8vAmRVmQNaOZsu32bLTkjvzDVBmmLwldYJy+Z+Xp46BcL4xFoQRApU50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1950
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110046
X-Proofpoint-GUID: pfsdilDjcyeE5FQQ5W28P4CpmTPNvdr3
X-Proofpoint-ORIG-GUID: pfsdilDjcyeE5FQQ5W28P4CpmTPNvdr3
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Daniel Borkmann,

The patch e572ff80f05c: "bpf: Make 32->64 bounds propagation slightly
more robust" from Dec 15, 2021, leads to the following Smatch static
checker warning:

	kernel/bpf/verifier.c:1412 __reg32_bound_s64()
	warn: always true condition '(a <= (((~0) >> 1))) => (s32min-s32max <= s32max)'

kernel/bpf/verifier.c
  1410        static bool __reg32_bound_s64(s32 a)
  1411        {
  1412                return a >= 0 && a <= S32_MAX;

Obviously an s32 is going to be <= S32_MAX

  1413        }
  1414
  1415        static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
  1416        {
  1417                reg->umin_value = reg->u32_min_value;
  1418                reg->umax_value = reg->u32_max_value;
  1419
  1420                /* Attempt to pull 32-bit signed bounds into 64-bit bounds but must
  1421                 * be positive otherwise set to worse case bounds and refine later
  1422                 * from tnum.
  1423                 */
  1424                if (__reg32_bound_s64(reg->s32_min_value) &&
  1425                    __reg32_bound_s64(reg->s32_max_value)) {
  1426                        reg->smin_value = reg->s32_min_value;
  1427                        reg->smax_value = reg->s32_max_value;
  1428                } else {
  1429                        reg->smin_value = 0;
  1430                        reg->smax_value = U32_MAX;

Should this be S32_MAX instead of U32_MAX?

  1431                }
  1432        }

regards,
dan carpenter
