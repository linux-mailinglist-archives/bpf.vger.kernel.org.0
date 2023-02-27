Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35F66A4CBD
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjB0VGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0VGI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:06:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA76274BF
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:06:04 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RIiNE7027075;
        Mon, 27 Feb 2023 21:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=1A+mW7Yv64ELhAQ3Wx096hyd20WN6c2Avdhh92IG7rs=;
 b=QOsdPL111gYcUqL8w3OBLnytRrD3AtnPYJ+I0ewtjWCt7B3RrP47/a956NaZTkfOnc7W
 IsOkP4M4+oU500nDsd1Sd0jzLS8ovCn3J/X71vo88V01v/NpcMgrXDhj3mrZiUl1gCdw
 pMGIFDczQvITCpeHYfxO1eAYaN9DRzvsgRLf07C/9SAvb6IQ2wqPHNqa5HibtGhDwLXq
 bZk5XKNxtag3JUpQDouab2msUIfon8rs/wNnbyqVsK1m4pgywnLW9ppYzTweidla1wpu
 I3tZYJ9w4opAd5wm/OKkcix3rzFzmQuQZyDSVi6TBBlUYnD9m/AZY57T2e4rdsC+TK1X lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9acnhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 21:06:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RKoIXh031525;
        Mon, 27 Feb 2023 21:06:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8scmfms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 21:06:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLsa4E6MFX3rjRoDtreAyPaoRamlbSJ/ed5ldkcvTjkkXdcSjhe7BuvydeJQ2G3aog5xlwhMy39HuZIO9HrgV3pCFCbqO8jmFbx2SwwnfauNsnUhCb9qIsew8V99KGbfjOs78dVJD1L6Qoet9CYwDf7sR1gkYD+DUQv3fyJA4eTtL+bMeuZQ+Mg5ml9n1TByIRDOG1sqxxaFBkUl1YV1aMC/HwEO5BJTtry4tkAEP7fkZ7PLwCX4TATNctXGou1P1O/PuEk/KAYKgJQ+OD/xLqmuItH06rAczIZomGaLfGRbBPbUUwp8pUmUZFcnRHyzs9aD6Ekh+rgxoRsrxSPjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1A+mW7Yv64ELhAQ3Wx096hyd20WN6c2Avdhh92IG7rs=;
 b=l+dLNIRWR7Q2j4ccmi97kFttQyy9ZDYybXsuuMSTtbto4FLCYSgJtC/WfNF/GXWePSBYO/QhOUnUnaUhxaY74sEhF3TOZ0qONWnDOEgTOYv+UlL/50wy5hCtA3f5EXdAnvGHzFWCKKVbwW/H145xkJs9Znz1Sfz/uacrNE/8EK//EvE4rCFcx8CtQ4z2x7fbtXgjrAbZAtggESZVyOklfX5OiUPYuAUpVabdiu1pY8gbuce31AUaxXH7Ysg1z5zNwfvQdea43OTVNvn41CUPI2PP9GyzfTAXkFUla6LaqK9AxGV1WxmEtH/mYNs/lFGu8G5duHv2uMSPVuWOaq0OTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A+mW7Yv64ELhAQ3Wx096hyd20WN6c2Avdhh92IG7rs=;
 b=D2kCb50jcbPn/UzhTHdUiBSZxe2so79RoNPKsoQ25RWV9SxupWAfnr9CuJDd/+rxNC6RjVCBzkBocfxDDmWwOW3imutnQdnJfE+NagIG8/NZFcTFXezxZU532xCG+3E/QqZc+IY4EmbOZMldDOcXYAun1FGTjkdbnOM+KTulGJY=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Mon, 27 Feb
 2023 21:05:58 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2%3]) with mapi id 15.20.6156.010; Mon, 27 Feb 2023
 21:05:58 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org,
        David Vernet <void@manifault.com>
Subject: [PATCH V3] bpf, docs: Document BPF insn encoding in term of stored
 bytes
Date:   Mon, 27 Feb 2023 22:05:51 +0100
Message-ID: <877cw295u8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0493.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::12) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: f09c474b-6a54-4436-715f-08db19066c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xt2WhGGFnvWkJqjY9fKUGtLBFi2fi7PjP+s5vD4pawGwtLGcoRdsQaSr9NcgRmPffhObuk+T4RZKAZkyzDrBHJFtdbpQaAAAeVa4wQce6zssQFUF8tbdwn3OzYy1bMO0VfwcbZ/nTJWHhqK99Q3K6/Se85pvBA3qKsT1WK880CwTj8afZsZ7aJzza+JSnEhotPgRYDBh02rAbnJsvBJwsBpLrS3ytNuYU2nmoWb/pxShDyGJJsWhI1QCjeRgQGhGQnFuZfWTvn7IvIJzjdUWchyZMNOyZFxfq09+ZOweCXUeEp/vEcuAK7PDgLfj0wfDDpiUHSTxlV5ne0KF+yvS7iBW34dSEPod8MbnOBNdupv+uujgYY781IAevrJIvJt98VDw1lKbNyX0ZpUro4LfXZx3+ZHKrUF1L6J1Cd4DBF1gBXE8k4kRGlQhLKuzRMhfiLzJ4UVqfkcB6wDHY84k3QZZk5AylnqoY76t2l6KDC65okMOfyNKpySDO352uhskBak3UvT0Bcs7egCBjrdvQtSAXvBr83HDiBiPQykX7xhABViiayXoYh9BKmZ0ohIjRmthq9m7UvCO8Wv8Vig64/gST8q8H4UZSqnfDlIwNPf+uc7YEnPDTh0M/CxTEpXjPuUyodLFYZ7fD2KYqANYiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(36756003)(83380400001)(316002)(54906003)(4326008)(66476007)(8676002)(6916009)(38100700002)(6512007)(6506007)(2616005)(478600001)(186003)(26005)(6666004)(6486002)(5660300002)(66946007)(66556008)(2906002)(8936002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d6Ia4Au45HjaiTZ6CJGk6h+HNr6WS+7Ly89EtkDBzzt/GrhEf14UfqaWXv2l?=
 =?us-ascii?Q?wclP4x0N5Fm25TV5d/02jmNMz/aZc3I/JJgh/C1YwbxhYs39P830p68OCaPw?=
 =?us-ascii?Q?U67ULL4pikqI86QFSYHnIRznzgCZSEmKZzw5sKjhYUHLuuHqZVHwvOPQBQWW?=
 =?us-ascii?Q?YGrIEcPJY/5gcAZL7dye+zSBIwa6okb9c2C6NLA3NP2SFCAT7M67CiHIQxej?=
 =?us-ascii?Q?aScR2dSmumCavvtPQF6mBoGkTE33HuLOnhgURPcbYThVyZtnnxZ/iECxDbEZ?=
 =?us-ascii?Q?3Jvw9uTQ+1FpMBSOshT19QKIDf/u1sl4IsbbhupXmIWd/gI32HfijDfKRLsj?=
 =?us-ascii?Q?SQR+De5CWAHYHBlGlQPHvozCicuoBV1U+x0UPaqzSEcH3k4G/KdZkYhY8Xbh?=
 =?us-ascii?Q?QOfbDk95fL87HSqFV0BHhJHExk5tYSgleGAtTwg0soRYd4AEYfpXVM+jra+J?=
 =?us-ascii?Q?MkpRrRNR0sD8GuSFTHXdIr1IzHF93j9FTJEBE4FuKKxfrB7kXBE993Lav9w+?=
 =?us-ascii?Q?sgBhxfc9+ksmEh2VOiD4Llb6r6UO4XGqjRr0i89DDa4zE1+nilTYbgyJWHBT?=
 =?us-ascii?Q?7Daa96iwKriJ03mpdZmk8rRGAYXfmEBXRp12FGjhIQxyINVwh1OkN9jh9diu?=
 =?us-ascii?Q?E8CY91BBok5fwEPv09tFMxzqezIbtYatsrZDv6rRYsUthP48kh7n6CEe2LJW?=
 =?us-ascii?Q?rJ70hQ9GHQw/Iha4VoBc4+dOK0I457NmnbuRpOJQiwKcJNB8TeLLvLZx1bK3?=
 =?us-ascii?Q?I/S6tGFWRrD6cWy2oslLJ5f0khRoitPVy8Kg/hDx02NPEdoUe4QQpDl+n+is?=
 =?us-ascii?Q?szdW++EykHWCLmKTVhLf2J7LaP9TIQiQ1CL98pO7tAYFeCLlyGnFIde1dwDV?=
 =?us-ascii?Q?oDmQrshZDi5sXiAhPQ66vlmO9pYGZ3K3pEQTcsmf+X8v9HVxDrGQpCgbKqpR?=
 =?us-ascii?Q?EgJY8nsmFeMun4W5cUijkyElyJ3UKi3IYm45LZVjS6z8frznokDi+0CkXxkS?=
 =?us-ascii?Q?YhoBX4cfr2rMv+GAAuqgUmOrC7lOSFAV2LTnpIaN1MiRMhSNRX5x+QcxrEsT?=
 =?us-ascii?Q?ANxwUxh+kh5mA5cOivHibnGUOyiQ4P06dpY9ZTCs44+S3JYywKl0lMrZE9Tw?=
 =?us-ascii?Q?W09UUG3arjWxf8k7sptJz3JyQ0UybUaGcDCg6CFTIpv4ueUV1akZ2JxEOZFv?=
 =?us-ascii?Q?qKFwZMKf00aYHfyBgHr2SEIpPkdaXJXAbjl1BXt+dX8gJO2ZL9rJlwV4VqTu?=
 =?us-ascii?Q?UzKJ+69Yp5OKLgt3iuOZhtU9BwhlKafzRVHMzDIisgmupg8bQOyTfwuX66d1?=
 =?us-ascii?Q?E8LkrI3FjnxM0Wz91tKpclj+ZyfNEpg62bMqf0cCvGhYnum6gnNBa76Wt9ra?=
 =?us-ascii?Q?Jubh3vbQ6PVgGA3YYBx3tFqdse1o7lumiF4QeLmSKTFvddh2uX7/lUO2pVRT?=
 =?us-ascii?Q?tscWTKikBSq/xpurNG+A2yfdtILqDp+mPw+P5oQPSMb6hRcuacFnq6RQj+ae?=
 =?us-ascii?Q?eYoUbOH3/eS+ZVLVsINUIIY2q9CyhYRaqadbk3vsd6oKU0jn+a0n3bFkaYqY?=
 =?us-ascii?Q?8/HoHLCkSu57xdrsigcbkbFA7nk1qw1f5jDNVSR7JypBUx9SBC4PCL6QMORs?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4a1nH7/4eeNWaqTn6du2gbS9OpC4TxmPyyCMbFvXlDPWaQ6b944sTD25nlXNO5bBkCdbN12QJR7gUO64xxUR+p5IDbARDY2Xg17t9y2kbqiECmJeCXoXWezhLb1vkrlqiog6gY8/VZI/h402FW8rt2V9RyeLB+vRjjKhU3/yP6RC7Zq3LPCLjCa28700TOnXmw9Sr3acndqxJHk7J+GbsmcoGKKwjQ2XM/fBoD1mB759s9F8w99KqrzLyVN499xdUOzs6UKM5LEXdqFZ/FWNla0UD0ijdJPFOKyeNiq161+KKRcw0mr0DAOBd4PJHKt86OggVhY70U96CVisdWXhOsNiM1yTbATYE5IQNku3cvoP7jsEKCF4PfFQ9VJxKbmKrSrEKYqhw42alOdBzDF+XfdOqJ+whz3xFgJ42Bhq1wzxXJD5yONzi74CuQeKV3RVm1hnH2oDCsGwzWD73tP5G9pnUB5SBVyGwusI7dgs604U6zu1AiCv9c/ebzINCEDWX/ij9WdKg7Y79cwzipDeGnfLmytMY8w6N1/cvSSK4xACfZSpwNAcdsBG1G5oixwGS0O6pC8l/drF7l/oWMp1UA+13OB6RwLCjhmaqdanWK/Maie3yVo5fNSJfPXW6LoB1d9v6Lq2nfRqpbpDClm/WrOIInWkd2wM/tR60r+3sjQ38XsivQPwvIKFtdqV/wEMKd5+VTSWCh2larnTeuw9+WXVf41PoJNu3mGKz7dCDOL3pxNY6NqHiD7q9CHKm4RkF4UfpVw0vhll8zJpCMMqlF+7i21dhH2WzMo02j1/nsyTfUHSYdZF1Ff8xiLCt9NMKwTB6p9NcgfulgeAOUNzbkdbwUkbgF6504YCMbRmL8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09c474b-6a54-4436-715f-08db19066c15
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 21:05:58.0649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBYtizMMYr508pzvadaLGAA6cnYm3VNmVjzP1N02PSsQLx4jcLGpFhMUWrU+EDV1t419RYT5N54fgGVthHTuOSww4L1kKBreU618+6P/Wso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_17,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270168
X-Proofpoint-GUID: 7JVAjaHB6Mx2Bq44mMj7uonebVyfjRp2
X-Proofpoint-ORIG-GUID: 7JVAjaHB6Mx2Bq44mMj7uonebVyfjRp2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


[Changes from V2:
- Use src and dst consistently in the document.
- Use a more graphical depiction of the 128-bit instruction.
- Remove `Where:' fragment.
- Clarify that unused bits are reserved and shall be zeroed.]

This patch modifies instruction-set.rst so it documents the encoding
of BPF instructions in terms of how the bytes are stored (be it in an
ELF file or as bytes in a memory buffer to be loaded into the kernel
or some other BPF consumer) as opposed to how the instruction looks
like once loaded.

This is hopefully easier to understand by implementors looking to
generate and/or consume bytes conforming BPF instructions.

The patch also clarifies that the unused bytes in a pseudo-instruction
shall be cleared with zeros.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
---
 Documentation/bpf/instruction-set.rst | 63 ++++++++++++++-------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 01802ed9b29b..fae2e48d6a0b 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -38,15 +38,11 @@ eBPF has two instruction encodings:
 * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
   constant) value after the basic instruction for a total of 128 bits.
 
-The basic instruction encoding looks as follows for a little-endian processor,
-where MSB and LSB mean the most significant bits and least significant bits,
-respectively:
+The fields conforming an encoded basic instruction are stored in the
+following order::
 
-=============  =======  =======  =======  ============
-32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
-=============  =======  =======  =======  ============
-imm            offset   src_reg  dst_reg  opcode
-=============  =======  =======  =======  ============
+  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
+  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.
 
 **imm**
   signed integer immediate value
@@ -54,48 +50,55 @@ imm            offset   src_reg  dst_reg  opcode
 **offset**
   signed integer offset used with pointer arithmetic
 
-**src_reg**
+**src**
   the source register number (0-10), except where otherwise specified
   (`64-bit immediate instructions`_ reuse this field for other purposes)
 
-**dst_reg**
+**dst**
   destination register number (0-10)
 
 **opcode**
   operation to perform
 
-and as follows for a big-endian processor:
+Note that the contents of multi-byte fields ('imm' and 'offset') are
+stored using big-endian byte ordering in big-endian BPF and
+little-endian byte ordering in little-endian BPF.
 
-=============  =======  =======  =======  ============
-32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
-=============  =======  =======  =======  ============
-imm            offset   dst_reg  src_reg  opcode
-=============  =======  =======  =======  ============
+For example::
 
-Multi-byte fields ('imm' and 'offset') are similarly stored in
-the byte order of the processor.
+  opcode         offset imm          assembly
+         src dst
+  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
+         dst src
+  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
 
 Note that most instructions do not use all of the fields.
 Unused fields shall be cleared to zero.
 
-As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
-instruction uses a 64-bit immediate value that is constructed as follows.
-The 64 bits following the basic instruction contain a pseudo instruction
-using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
-and imm containing the high 32 bits of the immediate value.
+As discussed below in `64-bit immediate instructions`_, a 64-bit
+immediate instruction uses a 64-bit immediate value that is
+constructed as follows.  The 64 bits following the basic instruction
+contain a pseudo instruction using the same format but with opcode,
+dst, src, and offset all set to zero, and imm containing the high 32
+bits of the immediate value.
 
-=================  ==================
-64 bits (MSB)      64 bits (LSB)
-=================  ==================
-basic instruction  pseudo instruction
-=================  ==================
+This is depicted in the following figure::
+
+        basic_instruction
+  .-----------------------------.
+  |                             |
+  code:8 regs:16 offset:16 imm:32 unused:32 imm:32
+                                  |              |
+                                  '--------------'
+                                 pseudo instruction
 
 Thus the 64-bit immediate value is constructed as follows:
 
   imm64 = (next_imm << 32) | imm
 
 where 'next_imm' refers to the imm value of the pseudo instruction
-following the basic instruction.
+following the basic instruction.  The unused bytes in the pseudo
+instruction are reserved and shall be cleared to zero.
 
 Instruction classes
 -------------------
@@ -137,7 +140,7 @@ code            source  instruction class
   source  value  description
   ======  =====  ==============================================
   BPF_K   0x00   use 32-bit 'imm' value as source operand
-  BPF_X   0x08   use 'src_reg' register value as source operand
+  BPF_X   0x08   use 'src' register value as source operand
   ======  =====  ==============================================
 
 **instruction class**
-- 
2.30.2

