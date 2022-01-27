Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A77A49E9B8
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 19:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244782AbiA0SJG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 13:09:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10296 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244838AbiA0SJE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 13:09:04 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RHIxEW009960;
        Thu, 27 Jan 2022 10:09:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Sx0O2Jzzb5ezBcyoi0DxOq7YM7jlyWZ8G6KrCTjsruE=;
 b=RAusLOwnI8H/7p2SDClZ1P3LQBPpFlas3UBmAYPnmnS2AV6RAQM740tFQeP8YbnXGdyL
 FW87sxpOqm/sexuU0mKtuCB8MjD0dlrH4oVrfZG58UaI3rOm4OuNvCIqc2zc5R9PhULK
 rVYIgWaLcRaFj1iznl9spq4Pn3CV+13lncY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ducnv6gxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Jan 2022 10:08:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 10:08:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhF2sJV63UzZHva/xq5auettgRW2327eNCAw15HJAdowmCQ2tqDVqvypHkKs3P+xBMy2W2EOX8YzW602nLLfJScM0Lc9+apWyz04Fp3OHOMA2W3PqH+p+XI51aZGsZZ96Iabgy2Rwy5ehI36fSfrTM+z/NtuWij1vadMSUkbJFeIXUK2Lx5bJC5URXPUKDsqGbc5FCa4q7gk3BRf/arqmI703aUOgMbyZSMgDRiDqjMsfMD56t3TAVDeN2BZFQDC4aZ3nrwZFJ/GrqbhW3qy88zDohrgB8mD7kIiwq7J9JLFj2+synsEgb/i2dBTem6ns6tATDYlNDbPAhEAv+sMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx0O2Jzzb5ezBcyoi0DxOq7YM7jlyWZ8G6KrCTjsruE=;
 b=T8N9GxScCcgQar9beIlMC/fe+jbXR4CUMajE/71b7kmB+L99SANmGcQoVVM3D2XhaqXjKuJw2vu4WdljdboROLqTm/r7C+ngalvLPo5qWnaJ3FmuIqHgaOxZx0I/FzL5j2yeIXco3LnezrWxu+rokSOdrGG5PvOStQLZqbSTb+9wHcpxNTXZ4+ftWUUqEelcD7x/PSl9IR0H8CjfhT9BLdi8gaiGtf4rkkTovggP/XJIA38vhluchs4NzxXD0d1zfXvir7VOyFJALYBqN/zFDkbne6H2b4oCkBrNxfwBpQtzwLbAtH2ixBHRfj5nOFhtogzoKLf0zkB0V1yvtfTDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BN8PR15MB2611.namprd15.prod.outlook.com (2603:10b6:408:d0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 18:08:57 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 18:08:57 +0000
Date:   Thu, 27 Jan 2022 10:08:54 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next v6] cgroup/bpf: fast path skb BPF filtering
Message-ID: <20220127180854.i6snxqt4r3eq4huv@kafai-mbp.dhcp.thefacebook.com>
References: <d8c58857113185a764927a46f4b5a058d36d3ec3.1643292455.git.asml.silence@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d8c58857113185a764927a46f4b5a058d36d3ec3.1643292455.git.asml.silence@gmail.com>
X-ClientProxiedBy: MW4PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:303:b4::6) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b02c6a1e-2d2b-44ae-0078-08d9e1c01664
X-MS-TrafficTypeDiagnostic: BN8PR15MB2611:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB261117E303A193C7334B0D9FD5219@BN8PR15MB2611.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEDMy0d+G3/TVwJ+93RGuKg4R+vqHsMLl+3OBST73f1j90WZBcod2RHcWn1Dnm/aPRECh2sMBm2F2t7zBCbzyHfulTV8j2LPVHmt6E5fsAm5himhQruYdM7Z0lOHIe6ILWI3FJ/B8rQac7tVYU5EMkGxnRI65j12j7PmpC9Hj8Fota5N7IMigHmyME+D9vRMD84hJc/0ueA+Tz8rkvvAdb+HPE5LQAGj7q3yvTzGgWgZ72uR/Q0QI8tl7iH18HcNkHBOslYEQTnXNx7qYqV8gukQZgfSB9sxV90Zfr6N4XWUXbpcNYnjaxgPnoMYRnlPOXnONLFLR1tnztVcGeKpBqhtsk+0CuAvCgiR486a9FjKu5Z+kyqLWzO7r+GrU08Ds9sUFe/diQYZelQ6xASBJMIHGDIAUHTDYn6C0MPEP+QsvF11p6uakwiDxDh50Wl3buUTRly0GnWmDGgK6R4j9XTGir+N04rTcs8uyBZY1t3fz1TNsMcdMtWetqvB8UR/+BNNm1+gXkGbsKQ+tVvgiGrYQlQKMA1XvY9wyMNcksMRPXBMYklBRPJPSRtm9oxLZ2VpOl03E+421k232uXq168BhPueg60kaIsRnD+qXkXsI1/fFOxH5SCc7LUc2Q6OqspbdlgXb/cFE2zV4Emd+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(1076003)(54906003)(6916009)(316002)(66946007)(66476007)(4326008)(38100700002)(8676002)(66556008)(8936002)(52116002)(2906002)(5660300002)(86362001)(9686003)(508600001)(6512007)(6666004)(6506007)(4744005)(6486002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Elu0lEDSPHqFidvZpZ2BokHh9+nV0839lL1egTZL/b3LzQQQ3ZWUIcen2/h?=
 =?us-ascii?Q?zQgMCPU48O+CsKnbbjqTu2j4hWArwwrKCUlljL6tllW/0KtYvWFiGZ8Y8ewD?=
 =?us-ascii?Q?P4gjLpeK+xIC8dUiOxusNx6qFp0C+Yj/m0ww5UyH9ZW/3G+vbECWABezlQTs?=
 =?us-ascii?Q?QOJ/ocCQydZkSFM3SZ6I+/O78XfaXQFgXj1BXNBu8M8tVj14ypTp4cicMGQq?=
 =?us-ascii?Q?r1agDsPQ+m9Y/PbxNvD2NgJS6Pyc7qtGIJQobS1C1mq0YZDdA574uiSKRjqE?=
 =?us-ascii?Q?JigaOSfb09Kssn1i8//CEd1CtQbbfcxZAVMBwFqnzUPO5765unxUpjfPexXf?=
 =?us-ascii?Q?XVYc4kaZKERmq0qV7+9KyflS+vMe8jKrZC+3fxgSuayLxjPIGAoMYsjWri6p?=
 =?us-ascii?Q?+bjfb2U4f5XLKVJsRGuMAYg75qJc8rvfSbrGxx0R0Q1TxVqHHylmlMP4V65N?=
 =?us-ascii?Q?kfZ3khfVzLFWbz6v3FtL99qN64vYQb8IesTzY+zeKFm78KfaIMs60nFXLPzy?=
 =?us-ascii?Q?zkaviO3Gn9K07OxHI36jQ3Z5PMZcvFCk/upMZPLhvipTJIq6lt1/eLEM9mPR?=
 =?us-ascii?Q?hkr4JZ2DRrgWgYk1JObiuqWlbjI06zH1FhtO31o5kvQpqlr4MZ7061B9PE5L?=
 =?us-ascii?Q?CbbmjPzMZoZ9Gu/tuFN29p5WZ99KiIK3q7o1FSkRDXzv6wI3XqomQKHugGgg?=
 =?us-ascii?Q?LS1O/Hs+ward04s12pQeC7BNk5WT7yvGL5d9XweqGNfChBjAz+PNCpk7ftXD?=
 =?us-ascii?Q?3vYrwXw2+XMmfz12KkDIos4m4DGn7BmD6iwG7koWdrABFZGDzN8ei1utHV3G?=
 =?us-ascii?Q?tlcSwbuMCS+z3E7K4X4yf0RAAPG8cmpV5z1VHukElVMMlb9EXHUf95by/HGQ?=
 =?us-ascii?Q?vtUZ8IMK90Ty+JAiUU17XwAQkDJ1/esRCcb/plY0NWdnqkqdHGDMhUJo1PTu?=
 =?us-ascii?Q?jkR8k35/9sXMCVcu02Jk/EEhF/jIItSZPzc16URB2Xeij/hUhKSYakkSFLi7?=
 =?us-ascii?Q?X7Wc+BmntRvcYvQUIxmac8h3/EL4NW0ui+GEG+AmXZ/vyGD9OqAxfYCWfanF?=
 =?us-ascii?Q?BJWYuc4rctr9kxwAzAoT4Y21PvYGZQsTGcjpsLJ07YpXfAtXK+KysGP8wqEi?=
 =?us-ascii?Q?8uIXg9KwmbHM7nMObxebT6kBQO6oFi3+jJWv5nb6wkL4j73Tr5HyCFJJ4cKe?=
 =?us-ascii?Q?Hvh0YyuQY0/Q5FVB3KIiiC9BCzDASgHwYftmFTn9btvUeIcxdMMQT+HOdcl+?=
 =?us-ascii?Q?N/9+KyF0RdpOoITHe24Mx9+BrxFChACMx4XqZjn+aRjWkDno+ydQetYSFt2M?=
 =?us-ascii?Q?7O+4zD2w7PlTKF69MfhMG1qrMUIqleWOTEHlTBLH6rJ8+zU+zUSQu64p6Id7?=
 =?us-ascii?Q?QoCMz2wzsaUQG7hjp6WakmPg+4CIzQDov9ynNzg8nuymZymL+jQsGfhou3Qd?=
 =?us-ascii?Q?pCW2bCgpLWhAfwLrGrk0Phq+MahPhqclK5uTJmMfnng6AzedaN7VHG7q+ARE?=
 =?us-ascii?Q?jsXaPw9Tyoe05ZT4BEX0h/8RWloIFRrIWqa9qvqWKDFiA576V3JHxATLXU7W?=
 =?us-ascii?Q?Ib5MrbzkAOWvrRBkTc/VK7hAu7K5RMiIg0Yodp3d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b02c6a1e-2d2b-44ae-0078-08d9e1c01664
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 18:08:57.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dhUFdTeoK2kOWnelUMQcxqbPqUHzVGfy3Mxa9tc2VOcj/ieLvjfSWTR0kz9GbZ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2611
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: uAJKB_3eNGRK8zwU8RJug-iClOvGmJUc
X-Proofpoint-GUID: uAJKB_3eNGRK8zwU8RJug-iClOvGmJUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=576 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 27, 2022 at 02:09:13PM +0000, Pavel Begunkov wrote:
> Even though there is a static key protecting from overhead from
> cgroup-bpf skb filtering when there is nothing attached, in many cases
> it's not enough as registering a filter for one type will ruin the fast
> path for all others. It's observed in production servers I've looked
> at but also in laptops, where registration is done during init by
> systemd or something else.
> 
> Add a per-socket fast path check guarding from such overhead. This
> affects both receive and transmit paths of TCP, UDP and other
> protocols. It showed ~1% tx/s improvement in small payload UDP
> send benchmarks using a real NIC and in a server environment and the
> number jumps to 2-3% for preemtible kernels.
Acked-by: Martin KaFai Lau <kafai@fb.com>
