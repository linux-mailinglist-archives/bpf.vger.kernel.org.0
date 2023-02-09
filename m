Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC376914BF
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 00:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjBIXi7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 18:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjBIXid (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 18:38:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF9370945
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 15:37:58 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319N4BQD004398;
        Thu, 9 Feb 2023 23:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=W/oaEwMRFDWTPJM+F84sI17WWkXQDZ0lkGTp2+M77Mo=;
 b=ag2dnvRl6SaDtdw66b6culkbQmMPCAodRuL1a4SmX8/y1yPO98tY8awQGKxlqqQKFhEv
 yzSxToMCCU4mTY9QLalQdnj8sRbKriAWfLtpONmIuJX4SLKpqXKzcTTzD9dDqMICKcHN
 e+MDFdXYTfi57ay9ZOynHsxVe2z0m1cBUKiqfghaqebMwQNz7OkoGaRYxKr2rILMbQKo
 EaSiMU188KS8HpT/BpIotaGQWomKKjFwA+CgP3t9+3KC0xZSZmgcLMPwiQCwwGkMB7nR
 x4ikai0VxqrOW6Siq2bk8PH9YZIofsSQARt0ruoob3DFMrbTnILBuWxZNvmzuHHJUQch Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheyu478a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 23:36:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 319NYGFT002675;
        Thu, 9 Feb 2023 23:36:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtg4fn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 23:36:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeOLKM3KUsiPRlonyQP7FG6dvdrQxsa8QLasfrYmSl6AGFTDgWSZ8UNqGu2BBqccAFkk57JQgO03vCoqWS3OPHxoeUrDMujQFwf6TN7km3mo9aOlnBWmPsVqDt8/WlDLswePuuElvB82yX0zqhc4365QygQrCwlEOCaXeSCDigpTu4hxWTMfXfe+MDgojKogKpzbf2QYqeQDtz6bhzov2vsYoSkrZ6+n53ChX9bgkMClkpYJVksWcE9J/hdwUs1oo9x8OPQngl9vV1aDXRH/Kx7obs26G1HQDysjc+BzXLrRn0+kksnr/fVqWm2krTI4XWHfoP8wH7yss/aisZ2AiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/oaEwMRFDWTPJM+F84sI17WWkXQDZ0lkGTp2+M77Mo=;
 b=QTIv/ZTRiQ/UBwUfZ5sxMvNzXf7RSvbhEGvf58rMM8MDRapV49UzkLYqr7l9IERK3V9rFfL99ruk7hLC9o84R5k+HpPedOyxZb6wU1Svdq1n+kNXCyWQs/NUu96BBfDBVkWWIrHWM9DVZqgXOv9R6Tzg7SbvyfNyw9ALEmt0mnwUXIjJ1/Zvyp+S7FG+2dZ3WQo+JA/O1Tr1jck3mxGa5oZ8rjcmP3bjyOgt86j3iKAimz2ojjsC8HrcFv5oR9dRpWl5eMkXf4qmrjdaa6ocS9g6bhTIipDbjQKT2ro+ABhH7pIRBZD7Lq/5qpUVCFSJ7w9tH1v+yaPFpvGms7HjBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/oaEwMRFDWTPJM+F84sI17WWkXQDZ0lkGTp2+M77Mo=;
 b=c9Ve5ZNuwviYERuSAA2YN4jFE+4moNW4cKmQijTgGPKINRPut3jT1fltOYS9hvnDjenZzvwfXAdpcsAWuyQR7txgMP5hB22dIVC1jPVjZlstSrYs0VJpvEkPu5Y55qA9lCSVbtt19z7JrYwfq+WDSpkb/R0NJbCZQZs6E7mL4XI=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 23:36:30 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%7]) with mapi id 15.20.6086.011; Thu, 9 Feb 2023
 23:36:30 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: bpf: Propose some new instructions for -mcpu=v4
In-Reply-To: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com> (Yonghong Song's
        message of "Thu, 9 Feb 2023 14:54:52 -0800")
References: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com>
Date:   Fri, 10 Feb 2023 00:36:24 +0100
Message-ID: <87fsbe8l8n.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::16) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|BY5PR10MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebd64a5-18b0-4321-b7a6-08db0af67864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+JBd1iCTO9vHtACcVp89f7KkkOuUEZP+k5BJJfa4GvI0nQh+9a9RHark7jTnUy7bswSZpkJNBf2w2IV8LeQoNyOWfcQ8jJ2cadIlr/1Njx6mbXUjiNw/7zaq5QuFiFXWVpXU0KOjZLMvS48dTLC8bHZVrmZM0JGH2RltX7GuJfFs0jjzXQ7o7UhDvh1f6GCcv+AaK1flJE80RmCj5QRVk5MREWTdEl1HdtR5axnCER5eYzaLFnS5pClikTdXBTWXHFxoNIFqq0/BjvQvvSugCtok4DvwfFbeOagUrrsFsmPnupN679x/TBnXSWAlytu5yKBJm3QRPc8IL0UkGfO70vcHAXzHQZSmebIsu3/1ERcxYvVQA4quFlQ7bbXe3LNQQT3uBtQn99N/0zbjzo6it/RQV6xBbWW8okayPtnCQTmlsBT/Wnopuh5xGu32hTtZpujoNoGFbC+K7YYM1yp5uqEgZEtqOOLRq43SVghfJM6u5wqKAEdKiQGbn5Ge6NxdmvhiwpF7YKDb+F8ybqfRhuPsYyCMnMcmWZNoZORophChPkKalXYTRrbgIatMQxjRHeSaTWmHvOlOvrne6IyEpZf5OthGG4sQHyKQ3iVmS7ig4GTzl+YYRmTX5TWeqCbNFPxz+heZANFyO1oKIqRgfnrifSDSC/n4AqWxW4sg4yEBEt8CZ1c++NsKfqrFrK+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199018)(38100700002)(8936002)(6512007)(186003)(26005)(5660300002)(6486002)(4326008)(2616005)(36756003)(478600001)(6506007)(6666004)(66556008)(316002)(66946007)(6916009)(8676002)(66476007)(86362001)(54906003)(2906002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z/DLRw06KD3eMPgz4K/ChZv+C8lNOPJd1gUBjRLy2w7bmhNPJuWmnkzLx0vb?=
 =?us-ascii?Q?8MFkcJ/v+Ebp3UxqU7HwHmNAZ+Dx9EdpKZ3Uli0CCEj5HJaIM8cFNJ0cUYXG?=
 =?us-ascii?Q?GXsqxfVxHoJhWkiP0lPuInwlbFLo1oQHV5IDY7exshyfCPJssNYmDr0oM6wn?=
 =?us-ascii?Q?kFA9Sv3RNMm9jZOq70/qX3XRZs5h4hGyZbgXVfD+0iVHLSLyOqrsGBpwtPS+?=
 =?us-ascii?Q?WTR7Afup+g/mhzw03tmmv3hizL3rETdpeajur/8GqsWrlOvdKrGj/OhzPT6D?=
 =?us-ascii?Q?fWBACVqOhUOzfTWMoXVnV7i9UZUCQScPoTljINBh5LNawA2WwMBGRx2a08qX?=
 =?us-ascii?Q?OM3ycvWpd/3gw469YCLzxXRO+otAfNPypnwV2ItwMMH6H8SU5nLIZ3oRvRAA?=
 =?us-ascii?Q?alkcOJ8apYdmFrchQhMQqqmj1KbAU0qe5ZQ6pgXfZYtgNyujj3i88Gnxu00p?=
 =?us-ascii?Q?zRISmtL1BpGWTvP+/ANFkrTCiOpJI+YWAMcRfV9jew/TyXPCKX9MVwi26pYj?=
 =?us-ascii?Q?lFKC4W8R+pYdSt9u4z7+BmpMn6lyosInyokyYA8T35Pw7yZNiwzLW2n7Y+vd?=
 =?us-ascii?Q?MqRu4HQEmNZlSUvWMpLZrVsl/1v0Zsk0iM0dUoxW1rXAQPLgYIDA/kZ1Yq3A?=
 =?us-ascii?Q?A2x9vpFc/3veoq+bThOhFcyawPIQQ0eoCEzuLd48A0kT/EKuM3XM6wp5P/ZT?=
 =?us-ascii?Q?F1Eb0RGPcS0y14zMQogJbSdf0m7wGr8JnFWT1eZDyiBjfSm1b5A7ZIlefIB8?=
 =?us-ascii?Q?ENSzpry+yEOY2bVTRQJIqWiyIS/AXTPf4Z9ntVThqUQilMjbmDA3VrA2bwS/?=
 =?us-ascii?Q?++C/kkt/RSaG4JUjptKG9XgyAtyn0ZtewtnNIKSx0ib8aZ/ya1jTU1k0qI/7?=
 =?us-ascii?Q?xXpeDKoVmNbgInovn71AIgEk0lzU96LsmxAkXuOyRkuS9bu3MhnXcfuj+pxR?=
 =?us-ascii?Q?nTrjf3ZDk8vRAi6rQ6Qatgout7PAJAt69sotZO2t8CoIETwtOJ9Gxj6rcpNN?=
 =?us-ascii?Q?lxraTRyZpFFQYUNYQyH5q7pTxvNnnSOVLY+iHQ9uK9fsf/JArqzJgnWwSJw1?=
 =?us-ascii?Q?l9sdctrr59rfXh5/5snsFSVDzJr0+UacfDxxntIUuicw7/uFRz8qOjXo9Zrm?=
 =?us-ascii?Q?7q+jyZmS0ptKGRKP3yiC1ulcNZTRI2o938p0psZErslknNnAL9zqFXtTgkkQ?=
 =?us-ascii?Q?4SawnzfHt4RX0QnkHqhom4hkCeaovfa/lKp37cyqKcY3n0WQX29ZcYLzjtjR?=
 =?us-ascii?Q?A0tqOqPoPEJ4sfS8paVcxM3nPWglIaXinNo//2+l4yM1SaowR0jCp+MaZMbD?=
 =?us-ascii?Q?Lw6HoTv6U1Bt+Ggyn6A9XWr8OHnz5drlXUiLfwpcA6MLhKKIxEb5y3bBiA58?=
 =?us-ascii?Q?Rp3W081lVWXKbAGi5Ih6FN2QPEAYpE7qVD9Cr5ja8t9yxjVPPhaaMPjtL2t/?=
 =?us-ascii?Q?nKWWDkUV+CTW4PIY0ujVtWaMFq+GuLW+BZg7s7sPBU3w+z6gonMqL97ClcPS?=
 =?us-ascii?Q?OThaRKBf8yuWL3bCoEhMH399u24bEA0vSvS1owI2Q+gNtN9HlU6VK8LGZcU8?=
 =?us-ascii?Q?RxTZiQAbO7JkVXptrS6/Gu48mc+Mc3lvDclhW4zUNSf+7ZTn5pDTERVXN+1W?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EaqTT1JU/6LSIaAsLrIK5gJ8jh5H8kCddDmUyuS8OcgL3ZfsdkRgchc3xgQg/G2Amwo4rSe7d+rtxvGYPFh0fn/lz/ZjnmM584v3Kd6mh20YeEUB5fuvJ+fHAeGcJrJyc/RzrALPS+p7w0qM7WCbI9ZNTMSAgMPdYAxY7oQ9HG+mhxYDfFmccq88jxzuF+XVq+3SUXvZ06l6r3GmBNvTK5oaNd9ipBy9DzMmjdGu1C/zt40EvSlRrVXvCTCiHlSZtpmNr9LmWAlaJiy/vxxaeVXEsjxR8i5ofjg46d+8sbq6iHwydtURDDjMwvTnd/kJFFAAy7wKCKtdRzrBe/BzMPN90Z9LNXrEIANDEn0qIAd/6wswlFHuyP8Nxt83u2PJt5Q7oVPk1A1DpC6GE5ofcnbG8ywg9FNZ5msT11tjnTfpxXhGVDn3mu53OJeiE4rjo2upAJEsmMa+nVkADzK1MG0eazEmXDN59CqGvGfT8adV/dHfV2a+95Gowudx7VBJhvyma/Jm1EbJWK7cuYNkpeIL0PkS3mVURHQcyypSpmtburrALn+LnGT6C7Xr0/NKzyKDCmv1svZkTb+vLByX3HLNcHW/bvH0LETa80XrQ72q9vnIoSjhPGfqa83aqg1YXuvi/qcUMJHXGHAB5DZx+3gwHEOSZ7aJKgvXZYX9EmX63ovr3J8kX41AMlCAzGJsmElZWtGDth3cHaz10drpJcMcIDL2xmYIlovQh5NUVyI+9FKx34YK9+8dkW2iLWK6p1IozqQwkUALouDikHrHEkS9160zKx6TYZZ0EsPegisVufe02128M7KKk0aLcqomxDpcjaRpwFUYhG5UKW3JaIv55Kap1Z3kGwyywRtSouooirqEBW6ENkqfEF65iChsup45Ulp8eZltleE400UlhA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebd64a5-18b0-4321-b7a6-08db0af67864
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 23:36:30.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOwp8f7UYJZgixM/y8om378SXUDaOZfFUI/gxlcVT/k7y9r5qy8N64HjsPQxVSo48ozWCSOfiJI8TE9IWjYzwR0dCnsXOtsMapCP2vjuNP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=590 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090212
X-Proofpoint-GUID: n8GvaAZIEIe7DsH8MYvL1ELj-lloK07l
X-Proofpoint-ORIG-GUID: n8GvaAZIEIe7DsH8MYvL1ELj-lloK07l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Yonghong.
Thanks for the proposal!

> SDIV/SMOD (signed div and mod)
> ==============================
>
> bpf already has unsigned DIV and MOD. They are encoded as
>
>   insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
>   off(16 bits)
>   DIV     0x3              0/1               BPF_ALU/BPF_ALU64          0
>   MOD     0x9              0/1               BPF_ALU/BPF_ALU64          0
>
> The current 'code' field only has two value left, 0xe and 0xf.
> gcc used these two values (0xe and 0xf) for SDIV and SMOD.
> But using these two values takes up all 'code' space and makes
> future extension hard.
>
> Here, I propose to encode SDIV/SMOD like below:
>
>   insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
>   off(16 bits)
>   DIV     0x3              0/1               BPF_ALU/BPF_ALU64          1
>   MOD     0x9              0/1               BPF_ALU/BPF_ALU64          1
>
> Basically, we reuse the same 'code' value but changing 'off' from 0 to 1
> to indicate signed div/mod.

I have a general concern about using instruction operands to encode
opcodes (in this case, 'off').

At the moment we have two BPF instruction formats:

 - The 64-bit instructions:

    code:8 regs:8 offset:16 imm:32

 - The 128-bit instructions:

    code:8 regs:8 offset:16 imm:32 unused:32 imm:32 

Of these, `code', `regs' and `unused' are what is commonly known as
instruction fields.  These are typically used for register numbers,
flags, and opcodes.

On the other hand, offset, imm32 and imm:32:::imm:32 are instruction
operands (the later is non-contiguous and conforms the 64-bit operand in
the 128-bit instruction).

The main difference between these is that the bytes conforming
instruction operands are themselves impacted by endianness, on top on
the endianness effect on the whole instruction.  (The weird endian-flip
in the two nibbles of `regs' is unfortunate, but I guess there is
nothing we can do about it at this point and I count them as
non-operands.)

If you use an instruction operand (such as `offset') in order to act as
an opcode, you incur in two inconveniences:

1) In effect you have "moving" opcodes that depend on the endianness.
   The opcode for signed-operation will be 0x1 in big-endian BPF, but
   0x8000 in little-endian bpf.

2) You lose the ability of easily adding more complementary opcodes in
   these 16 bits in the future, in case you ever need them.

As far as I have seen in other architectures, the usual way of doing
this is to add an additional instruction format, in this case for the
class of arithmetic instructions, where the bits dedicated to the unused
operand (offset) becomes a new opcodes field:

  - 32-bit arithmetic instructions:

    code:8 regs:8 code2:16 imm:32

Where code2 is now an additional field (not an operand) that provides
extra additional opcode space for this particular class of instructions.
This can be divided in a 1-bit field to signify "signed" and the rest
reserved for future use:

   opcode2 ::= unused(15) signed(1)

Thoughts?
