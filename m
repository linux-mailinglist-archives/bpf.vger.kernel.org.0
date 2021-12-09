Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D0746E0BF
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 03:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhLICOk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 21:14:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6890 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229835AbhLICOk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 21:14:40 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8Mn8MC026931;
        Wed, 8 Dec 2021 18:10:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=WMvbBGEx+PKfRPbu2q1NgXWWJCPIs1xuBjzPqycayAE=;
 b=pWsiWc7gZQxnrQHT+3kUoGPBZKQ3vJEBi4q83pHktbLFIg0ZC/eolw93yX/8cnzsmsmE
 zcpmgBUWH6o+kNkzexWd/yVRwdVVPMrl51YMMqD7c0Vgp7aiymfSEPmz8O2//d0fQdZA
 bv3VMqZ5b01nD4Dy+hzcOmPHoX3SyDfPo78= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cu5u5rxn0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Dec 2021 18:10:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 18:10:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWKlosq5xA9CjDyt2C80brDpEYMvdjeUxRUkJRWOWeIXwC0DOZvKm0Q87dMzCnlt7zxdNQtYMQimweWP6Ejd6V2CD1zv4aWXBf9H118Qr5x4FONifa/W1fyON51OkvltYuzM2gfL0ci7B70sU4WaXmNZseWNhqo+DMqO27Cd6+QRPUpJRYQ1zOt7Ljn4kOmZ+/R7yP4ONDLP8rHpa1hDS+39JQIRUDQh/NHzhg5Me8JAj4FNfNW49ikcfnApzmZAdY+goHeL+C5gw6bnJartQl/BVFf6wE+JHhVl8+m4tP3MIGrJXxM95CnJzutgGxiHvTS70kZHbPVbk2OwGSSxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMvbBGEx+PKfRPbu2q1NgXWWJCPIs1xuBjzPqycayAE=;
 b=X1qbiowzMAwxmkGb0vTM1g70v8wbwmoFI3Nvav1aOlVTwLm6p4oh0AOuV/oMsqvcSf7MKLnS8TF8eFyLF/R557Mr++cawj5Z9FNy5HCHKinnpG4E69curBRxrNn4YxIwN14QxfnxqZu9Y6sfoWC128KxDcs+OC9aiFJecnGTgsIAlpBcIvdJfwjD9D+tmMMHO/y+6eLLeo6xEvUV+XuGQuHYLzKGWHslf0tDdC5ldXB8ndbaMfCX7STaYxn1w3OYSRCHBn1LWMqoeouyQQNsoOAVMVP2UnjA1dRPCPQ4GFo8Ou8OzoBGeMYAVEsIF4Q2c+i/fIJnpzl0vwNxynTUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR1501MB4144.namprd15.prod.outlook.com (2603:10b6:805:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 02:10:41 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010%7]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 02:10:41 +0000
Date:   Wed, 8 Dec 2021 18:10:38 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 bpf-next 2/2] bpf/selftests: Update local storage
 selftest for sleepable programs
Message-ID: <20211209021038.rx3vruznt5jyv45n@kafai-mbp.dhcp.thefacebook.com>
References: <20211206151909.951258-1-kpsingh@kernel.org>
 <20211206151909.951258-3-kpsingh@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211206151909.951258-3-kpsingh@kernel.org>
X-ClientProxiedBy: MWHPR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:300:6c::25) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:9be9) by MWHPR04CA0063.namprd04.prod.outlook.com (2603:10b6:300:6c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend Transport; Thu, 9 Dec 2021 02:10:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2afbad19-6792-4ea0-0fe1-08d9bab919ac
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4144:EE_
X-Microsoft-Antispam-PRVS: <SN6PR1501MB4144C2D3D4FC2439FE244A8AD5709@SN6PR1501MB4144.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1I6zQsNPOrTNgUMyqUnIfaN2c1wq3JaRuTqEAIti2gsXSV+UKkoy/Q/l8j1P6gqjmZp77/nBNwa5Q+sWDx61918Msllm+tOb0zD96+N4tlNmqEGfScIye11fLlUEFNT2rg/sVEqR3M0KCDIu0d0ThHZT9XGoBoqZcgrZYG8jmVa3zSOchaJCgSPw9MuBMqZNlHpBMfEheP/o7/ytlInE7n26sETuHrBjw2lxDTTNE/YAS2RL5juvBRsyq8rLXq8F2ff+A2QfrPrnQBzUE4rbWbjGpeKkfxKsXnvllpyVVArWjtccb19Q4XYh50v6PQoznoXBSOfgxfM4JJzwBnouCwH+Nmgyj4gIEZCutgSI3VCD+mPElGVpxUaTFNoBkd8Qm+RSFCshenA7OpaVDawY34kfQAJveuVPqKa6r3GIMiA/lWltFPaEHoqd4E4xkmo71TCI5cSm/AEMsELa58UNfg24BjV/jydOPle/xiWhUl+dHLPp1B3ugsvZa7hZxUUhGwG8ezs5c7aHvyNqOOWn/qKxfU4Fb2ffGkxbQz5uPIiZz6QtDQa/ETUwiPSaYkJz9+/rdT+m/HoTDSC7lFQYXDN0eDh2aHu9bSnSwDBXB7bV9mGe0yWzySyK8jp1TmvWg8D9yJecKiq0hS1RHB2pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(38100700002)(5660300002)(4744005)(1076003)(52116002)(9686003)(66556008)(66476007)(15650500001)(6916009)(8676002)(55016003)(2906002)(8936002)(508600001)(4326008)(54906003)(7696005)(83380400001)(316002)(6506007)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2r502pMwWkFrjSUo5xsiSGj5kLRm2rf6yUij9F6fbkCESPWq9L99wV9B/nMs?=
 =?us-ascii?Q?L+E+f/+Cn3CN/wfXDGU9BG85TZN86hM2Mzl+M3lLga+UgTGgpRw01uFGNLsS?=
 =?us-ascii?Q?54+jqrGpuZU/gfmAWi60rPxgd4O7u446VMFB3FDlQbePjTC7iha59Q3wnOv9?=
 =?us-ascii?Q?S6KZbH27+jWpmI1mXjWVUF5VfIrlyO3VO9RNPwOXmVNqTpsJ+6rkVZhWFTdJ?=
 =?us-ascii?Q?JMPbNgpbrVk4y5pHzC08q38Hurd1K7yplRkGDzBzli5J+PcB2bJCdj3efKs3?=
 =?us-ascii?Q?op7GRT6DAmP02xOwnbcHWW+F26eo5KlD9T/qukuYAeud/mERyxMsZzo2L7El?=
 =?us-ascii?Q?kKPiGaarR+p51g3/LXnxjZ5lhO9o7n+/w6rV3CVOXKk5jlQWcw+FPiAQeC8j?=
 =?us-ascii?Q?gW+J4ep1VrAYblFA7i+4ItQKqc5zmkAaoNxQEKmB6WlVOsLSc2k2OWyWphG6?=
 =?us-ascii?Q?fbL1K00k/zx0pgpgmWmXVjq3/l6TW+fIuoSm1CoW3HF+ND9ZeOnnuzzbfqnw?=
 =?us-ascii?Q?WT6h6Nfh3dlK+Djb1ibPUjlTe4SBSXsal/jBv3C38uRHFqFcPIVk9nBJQDDV?=
 =?us-ascii?Q?vVyWAhbxrRgac+q35mjaxEU3gFJU/0FYpJCsWPvWGKP39I2ROVxODNT8gaYd?=
 =?us-ascii?Q?zdOhpPoTEygOGaLrxwy3CH0kkZoqzGtHmuSe/oZpebwXk5o9tFuYyA5YsdCn?=
 =?us-ascii?Q?/9EDCWlYK1e5PYMfLK1Xb84C4H7lNeeVd8EXRLv9RwYhPatUhhccQjqkugwr?=
 =?us-ascii?Q?oqPEFslo12E0SrbtM7k2ZFDHseGBia9jZ7ZWP6rOkkEghLVdWi6s6R4KNoAq?=
 =?us-ascii?Q?QJI06LNl+/SwyHUs+NkDkMrMqkVU0ina2dp3Dw4BFHJIFnibO0ffw9DTxYKy?=
 =?us-ascii?Q?TtsUu7mB33NsRV24l5RydE1XM16AcwPb1yObPA9Z8nLjS3nvW5uYGlSx/ucT?=
 =?us-ascii?Q?9mV6DHljcXr+UANicIVZFy6+F7JTRi+dGA2I60BBhrZqm6BW5NZB9lblrWEh?=
 =?us-ascii?Q?bQQ8gH298/c0zoZbF/MYCtHvwseFalsFKohP1fXvRtzt2oRSlF/XMuq1Y9TL?=
 =?us-ascii?Q?4PWN097y8ZXelm1uhxmMxdjhjg2MH35riRDFJMY936UlRakzXWjeXFZH2rmm?=
 =?us-ascii?Q?SgxX02tA8hMDx/NgxL+ltN829CtpO+xbO0pD4rxqsmzo5xOv+U1U5PZnW64c?=
 =?us-ascii?Q?ujJUPuJdMs8nl/5XI92h4kOT8ZJDquCdxiowKIoWe2N2vfuYC1v5fsECGG3h?=
 =?us-ascii?Q?i35PB1UGXqI80E5FNHYhHt/eMx6A7BwUZBHG+pXWedJ6st1MkkSB9OZXKnJM?=
 =?us-ascii?Q?O69vxMsZYV89dF3aQOAm4fXh22v/t5nsBZxh5OMoxHxFWw+xtT8n5eMCWfz6?=
 =?us-ascii?Q?Ef/bqJS0p4rLF6X1WKyrqa7iiZQdjKuL6d+jzyrm+/6urLVoVHFof1Z2dMaK?=
 =?us-ascii?Q?L8mWeZRMEhkR8P0MrVJDMjwXwneYbTvGvuWGjd0X7R74WXFVP2nAlPIsF59R?=
 =?us-ascii?Q?HgUf5nwJMSrBevCLhgMZhq7XxzfxzJZ08ANzed22VFnSechUz+ba0DGYc25u?=
 =?us-ascii?Q?5qzGBTX5tT0Bd6gUnFZhY6Eq5pF9Myl4z4ecKWx4LrTp98fViaLYLlaH+7JV?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afbad19-6792-4ea0-0fe1-08d9bab919ac
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 02:10:41.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2eQE5auF3hHekcoqumODgC0iAjLtIglB2Y/cf1zvL2Anw2GmonpIhsHWOaVdXCP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4144
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 7ZBzjSarnnKkECXuUBIZUFmUlfAfdJBO
X-Proofpoint-ORIG-GUID: 7ZBzjSarnnKkECXuUBIZUFmUlfAfdJBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_01,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=447 bulkscore=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 06, 2021 at 03:19:09PM +0000, KP Singh wrote:
> Remove the spin lock logic and update the selftests to use sleepable
> programs to use a mix of sleepable and non-sleepable programs. It's more
> useful to test the sleepable programs since the tests don't really need
> spinlocks.
Acked-by: Martin KaFai Lau <kafai@fb.com>
