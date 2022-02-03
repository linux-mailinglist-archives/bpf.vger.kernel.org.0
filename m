Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701854A7E51
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 04:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbiBCDY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 22:24:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26846 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231626AbiBCDY3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 22:24:29 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2131reTU027393;
        Wed, 2 Feb 2022 19:24:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HJz2lB3U3EGb8vH+j3h/vjiutUOTgS0v6k4zJrFjez8=;
 b=fJMHhS+BScaEeC/s2Ps1vMwe629pHReTnedobxUHtZyDSLWSgyi24TunEXXugP0yNEcC
 gG3Z1ZEDcN89jxZg0Es8eKQNflRc90+Ugb+n3actIlp+OqBnmSC2yua5SWRTlur0qbjP
 k4hnq3BjLDoSJBFhiPZTYqio7Ds5dxVsjxk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e05sn8btd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Feb 2022 19:24:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 19:24:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWSXkqkZtyWBhP3Txb1m4sA57LRwyhGVJI7SU8YeBwmlp16tnykrnqbE1eMeCJTojcF4C7QCdIeoAKG/MIHG7gfzNizuuxB6L26bbMaV9nHzbYApIki4gAZ263DWZNPBO+g2FSuOrd0zxPv7j5AftnJd9tPbSPF5lDT08+FrXS2Tu/Ann3rtcM1SMuzTJR4KX8NzincQ0FwbaCNI6qixc7HtIP0gOcnwLGYaDr9QxjdIFIOiaeUzcUZWm9l7Hk+SfVpd1oNx+F5rezzNvTLrP2GjAUHmf2dMoU8SKptpH2vhzvvg+VZgVZ9Lkd+jWyXdqGNw8YlRpkF4aDK+QX42zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJz2lB3U3EGb8vH+j3h/vjiutUOTgS0v6k4zJrFjez8=;
 b=A9V4vZvSbcOsWQfk5NIFINb6Nm+GKbZrbqt4IZvNwqH7ddr60mtXdFYXJDRmF8fihrR8/gpg1AEW7TQ9ZkxcLKtCeWPOwnvXemtsAj6HbTgv9LMPgfAh0GiDmKX+4wy5IPwfIy72m63CBgZAjQe4iBVlOBkRka2Ed8xp1YMTPENFBUKVw2JyHSz3Ll2DDfI8VGdnnyOc0+XkIe2VpBq1m4Y6IkmxILz0PK9BuQXITihFFfim5d4E7K63ovh1OydB4Y1i9CwkE/uVZzc8eCM8luSEJpvxNsIZ5TCHKiskwHRI5S52gnh5383+oh5Cp+d7m30+1QKG2uPHGpJVUp3xHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB4251.namprd15.prod.outlook.com (2603:10b6:5:172::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 03:24:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 03:24:24 +0000
Message-ID: <c5a76b4d-abed-51f6-bf16-040eb0baf290@fb.com>
Date:   Wed, 2 Feb 2022 19:24:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: Packet pointers with 32-bit assignments
Content-Language: en-US
To:     Paul Chaignon <paul@isovalent.com>, <bpf@vger.kernel.org>
References: <20220202205921.GA96712@Mem>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220202205921.GA96712@Mem>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: CO2PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:104:6::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58415b52-ca46-4b62-c40a-08d9e6c4acf5
X-MS-TrafficTypeDiagnostic: DM6PR15MB4251:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB4251DD7E541435A9EE95C44BD3289@DM6PR15MB4251.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DhYcys5iW2yUzCpbq87rW3jEtOOq1f7qp2Gc9vQMdFF3t5/TP63796S3AYhQzQZMm9LXkZZQFbvKm28I5Yt3/W2meVbpKtnWKbLBl5DH/g2kYD4Bq3J3481e0oZ84f0k3Wj/dwrM3tPL53zTUbizFNhlL4UMpn3x118sRW86RhvyRlylPDQM46iD4d6zNHLFVSkqEwi8NsJ7i4QC1UFtFyAHOMi+MofjHvindez8kVqjBVNly7E8yzN+FrANJPjEiPuU9b3G5yg6+ZXRGVwTdGv0EI1gDd9R2jbXmCURujtLZmii0Z/3O+A4kVgAzOQelmJoXeno8IiJqwmJU14XqXEgN9RbLhXx29PphbKiyn7U3eDZz7TpX2BpZtPRKyXnVPM3qrhPV+PHTsrRslIJrUGYgjyFvhuo/EaRr5BNuPSkXEDzrqKUBCUGXI7jLrwhm+ZUCUi4HsTdNyKEDQ5qrfK8CpJBkgE94uLLGmPLRBevSdkEB9QywMZd+VUNE4HPrSpWtSW6VclvA3tZ//KfnDJhkmPe0Z/EhJjzVRMc2/M5JkRtfSIevrOyHEPEmkTm8x10nv4csWA1Nmxqqp6sfIxSSONhzfOsD83mBvRDNghMK9/sD5APH+l2iP/EKrz6VhN2eny24KlvVZTWrnOgQ1S7luMRLr+eP4R3H6paZZNJXuZXPr74GJ1I83wc3DH8BKFCkzOTJURdGeOi6OENLH8FPv1tstie6peZWPmo0iqk9lFkVSRXAUUuF4siZSHIR5y2S2bTfjkjldYYMwiTwRTIhKSthHtwWbIq2h3+GLCVfgOnvwLhDbVn0gQp6aU12OP+DZRcqY9hUocB9rhO6WuyTMqFdVHnKLn/4hAvqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(86362001)(66946007)(8676002)(6506007)(8936002)(6512007)(316002)(83380400001)(52116002)(6666004)(53546011)(31696002)(186003)(31686004)(966005)(2906002)(38100700002)(36756003)(5660300002)(2616005)(6486002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnpmemg0dHpYZjBnZ3pWUGJRbzh4U3RaREZaZHFHZCtqa0ZhSDZVUnZJbk9Y?=
 =?utf-8?B?NmYvN01rRGpXU1lUOGY4RDlCUHViUkRRdm1JRnVobml5TlhtY0V0LzRnTVBr?=
 =?utf-8?B?enRvL2Y5MTFYQXRVQ2FGNEtncHhWeXpCV3daQTRROEt6T1dlQTVvTUx5cDh2?=
 =?utf-8?B?VjFhY25xU0hiQjZmQzJXT0NlckxHa3RWSG5FUHR6RTl1OEZqV2QxKzZwUXlp?=
 =?utf-8?B?azAxd2xyeFdqbEFmS1U3blZ1ZzFUWkJXNS82Vk1wb2x4SUZJT1dDeGR4QmlV?=
 =?utf-8?B?MG4raFFQY3dTeWtLdjAwT253eTNHRzFjZ2JXcWFrMFJyRml5bmtBSlk3Vjlj?=
 =?utf-8?B?UzBhNnVBYVRrNEU5L242d0JUSzkyODVQVDFkZFF3aXpTK05TdzdmUWVnaDla?=
 =?utf-8?B?YU5zVFd1elpDbHVONzFTVmlIWHBDVnRvRHQ2MkgyYjJaM2oyeG13Z2F3Tkli?=
 =?utf-8?B?TDJKWUg2U3JIUUlaaGRpZVBiN2hqTW1QME1xaVkydnVaMGlMWkk0ai9Fd00w?=
 =?utf-8?B?TzkrWHVscTVyaGJFZlN4SkM1R05CQ2Z2TWNYbDRCQlFINFhyRmxOalg2dGs1?=
 =?utf-8?B?SkswQ1RwdlYvR0pTTG1QWWVXOHRmcHV6c3ExNW9sMXdJY2tadXhlcjBXcHhI?=
 =?utf-8?B?SHZ2SlRJbGNPN2IxRi8xL2dlTW8wZmI1Y2piaWdyRXVWZGF0UVY1YjJsOXlL?=
 =?utf-8?B?a2FmRXArcXJrV3pqMkdVU09FdmtDUlBtZGRLbGlZYkNvQXJwdkgwRGFBN2Nj?=
 =?utf-8?B?SW5YUlJrK2hQd01pZXRrZE8zc2RDU1BWK0RsUkwyOEJFdG81QkltVE9ESGFE?=
 =?utf-8?B?eStEWGNtS0ovd2cwRDdhYk1Bd2lNb3ZCUGltNnRmc2c2aGlUcngwZm1DSTdl?=
 =?utf-8?B?bHkvUXVPRVkwOU5reHo5TDl3dmE5OHUrOURyM0tEZDFNREY3d1l6SnYrb0l4?=
 =?utf-8?B?UmNvQlp5M3VEcUdGcUttOHdNWWhaWGJ6K2UvMTI5bmpqT0dYQTFyUDhXUDB5?=
 =?utf-8?B?N1hhbjBoS2JGSmVxQStpSUN2SUZVQ0FRU1FrS04yandKcHEwQkloWktIbHFG?=
 =?utf-8?B?RHVTRWx3OXZXUWE2ZCsvZ1hmUEp2T3dRc1JETi81OWs2WHFvbk5lYU96cDZu?=
 =?utf-8?B?UEhXbzZpeTRTS3NnQzJINlFMaFFDa1lMTGxPZFdPeklHbDY4TjM2Q1I2TlRL?=
 =?utf-8?B?Q0NoWE1pQUpFbFlUL3J0UjdsUG44U3c5aHhxK2cvWVFQTGN2eGVsQmtrZnVY?=
 =?utf-8?B?WGxzM3lqV1RWenYveVlwV3B3RnhkUWJzZWJIdmJBRDR1SXRENjFDMEVXM085?=
 =?utf-8?B?REpkQVd4eTRmVEdJbnZrZGJBaUJiVXNFaENPQVBGSWNxOHpkcWJGWWdIZ3Fy?=
 =?utf-8?B?cWgvV08vWC82eXZBeXp6Tm5CWWw2L09tL3dBdjFQYmt4T2NhcUVvQmxEa1Ju?=
 =?utf-8?B?Q2lBNmhoTUVtVDRMWnk0dHVOWlVqM2xldlhHZHh6ZlBXZE1hOWdRWnJoU0c3?=
 =?utf-8?B?RDlnZVdyNzZrdUJ5UWpsTVJHYkJNaTl4QmJqKzdIeUcvejBIaGNtT0RhU3hl?=
 =?utf-8?B?STBmSTBhY2pHNkdXc2Fka3dpNklVYnhGd3Vid1p2am5VaDFMNmRnR0hQUnhs?=
 =?utf-8?B?QjNWeFFCdkNUay9CWGNkU3hCWndLZmY4ZVdIS3QycDRhaU8vMDBPb0RiU2dZ?=
 =?utf-8?B?NGc2R21UajhsYTVqT3Nha3dtemFUMXlKVUZsQkdaMHRCNWYwdFFTQ3RsYVhn?=
 =?utf-8?B?WVltdlhxd1JCaS9LN25xV1h0WUM2NE5PZHRvZnFsWkJSTEZoZ0UrdWRFdUR2?=
 =?utf-8?B?dUxnYmdPd2pOSWoxVFJTU3NZOHJCa0JHWGJqeTZ0bU5FSVBaSk5FeEhiS2xL?=
 =?utf-8?B?NVVWSEd1QkFRYUdBd0hNV3VxTEtJQlZXWXZic2tsS1NOUXJPc0Qra1ZtSWdT?=
 =?utf-8?B?bDZqaWloTWxRZHVTaWhPcEc5YkQ2MGdhdmZJbVd6d2UzSUNMd1BHbGZJRHZ6?=
 =?utf-8?B?S3VpdmtFbHgrRU0zK0xKZ3U1RStCa0N2aUVZUnN5R1huWm9KUTk3czJoY3oy?=
 =?utf-8?B?bDkrTTc5ZlFFUGt0QXhIV0FJZSs2NXZoYjdZUDUvRll3d0ZvaWpreHFPRUhN?=
 =?utf-8?Q?DvITSEst0DKX04MWAMsiTrJRl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58415b52-ca46-4b62-c40a-08d9e6c4acf5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 03:24:24.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Aw5ZszjR2bJmFUFGzxpgT40+u+HFCF7f4VE3056494WHorD6jOs54OYP9gy7aSL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4251
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: yYg4Oevv_BTNsRnPYr122njYJe-PYKhb
X-Proofpoint-GUID: yYg4Oevv_BTNsRnPYr122njYJe-PYKhb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1011
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=740 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030016
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/2/22 12:59 PM, Paul Chaignon wrote:
> Hi,
> 
> We're hitting the following verifier error in Cilium, on bpf-next
> (86c7ecad3bf8) with LLVM 10.0.0 and mcpu=v3.
> 
>      ; return (void *)(unsigned long)ctx->data;
>      2: (61) r9 = *(u32 *)(r7 +76)
>      ; R7_w=ctx(id=0,off=0,imm=0) R9_w=pkt(id=0,off=0,r=0,imm=0)
>      ; return (void *)(unsigned long)ctx->data;
>      3: (bc) w6 = w9
>      ; R6_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R9_w=pkt(id=0,off=0,r=0,imm=0)
>      ; if (data + tot_len > data_end)
>      4: (bf) r2 = r6
>      ; R2_w=inv(id=1,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6_w=inv(id=1,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>      5: (07) r2 += 54
>      ; R2_w=inv(id=0,umin_value=54,umax_value=4294967349,var_off=(0x0; 0x1ffffffff))
>      ; if (data + tot_len > data_end)
>      6: (2d) if r2 > r1 goto pc+466
>      ; R1_w=pkt_end(id=0,off=0,imm=0) R2_w=inv(id=0,umin_value=54,umax_value=4294967349,var_off=(0x0; 0x1ffffffff))
>      ; tmp = a->d1 - b->d1;
>      7: (71) r2 = *(u8 *)(r6 +22)
>      R6 invalid mem access 'inv'
> 
> As seen above, the verifier loses track of the packet pointer at
> instruction 3, which then leads to an invalid memory access. Since
> ctx->data is on 32 bits, LLVM generated a 32-bit assignment at
> instruction 3.
> 
> We're usually able to avoid this by removing all 32-bit comparisons and
> additions with the 64-bit variables for data and data_end. But in this
> case, all variables are already on 64 bits.
> 
> Is there maybe a compiler patch we're missing which prevents such
> assignments? If not, could we teach the verifier to track and convert
> such assignments?

We kind of tackled this problem sometimes back. For example, the
following is a proposed llvm builtin for this purpose:
   https://reviews.llvm.org/D81479
   https://reviews.llvm.org/D81480
the builtin looks like
   void *ptr = __builtin_bpf_load_u32_to_ptr(void *base,
                   int const_offset);

The patches are abandoned since the functionality can be
achieved with bpf asm code. Something likes below
    asm("%0 = *(u32 *)(%1 + %2)" : "=r"(ptr) : "r"(ctx), "i"(76));
We could define the above asm insn as a macro and put it
in bpf_helpers.h.

Could you give a try?

> 
> Regards,
> Paul
