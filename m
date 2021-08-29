Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD963FA97D
	for <lists+bpf@lfdr.de>; Sun, 29 Aug 2021 08:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhH2GcE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Aug 2021 02:32:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55586 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhH2GcD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 29 Aug 2021 02:32:03 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17T6FTJV009542;
        Sat, 28 Aug 2021 23:31:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GraXoGylh3OFYedaJ/7m4RI34kzxEkCoulU/0DTKIEI=;
 b=J7u3X0Mbtap/PNs+EBWoddvchRvf48wqAsaCY2TszQ3IZJWP63m3QACn/0K3emk0RiIW
 //1kZ+GZuB3CS5Lxvw38yxNJ9WuRM9gmhSJiITwhF7emXoiLvg+lXtCMC588ZlpwYmH/
 ppCKkoDizOfXr/dHRWdtLaKYQa4PgcZoj4w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aqj8ykuew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 28 Aug 2021 23:31:09 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 28 Aug 2021 23:31:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJL2SK0p0O7aUFcjb8lPLiJJe10ssObgyqSylPm8k8x4CcspO107m+c4BVpqB81egHt8M9lJIqlKW4Cs7bfhWn2PBlQ2MZdfp22X2J4uGr/vT5jcLY6YpL3ageSd4E6m4K4o9AIsprlwwWdo/0S6q5xXfChuVLYQuJI0Oc3nQSgnZhe/OEsPxbNh9lDRI1mmpiZR0lDWZdfKGj9BLtXbOW7fD1e2xD+cao/KKWGnKzl/mf/p9hx9+t8WalWPfbN2OLjqrdPH+v5x+QbFKM0eH4/TN+MXRpb/Z1esEW5KUD/AdplHxYS7/N/Cj05ooncakDzkFLYXIuz7tHcdgNoGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GraXoGylh3OFYedaJ/7m4RI34kzxEkCoulU/0DTKIEI=;
 b=Gx1J5Pzkl+WocPAB4N65ax0SwwuSNVk4259DHi8wlHJx0O261u5N2GN+kHyZuStkz2PjGwBvGcA7oCq7X6w94jkPrK9KxblDoXpzpPSShsxBKQOBFMwWWQzb50c+VWeUhfGxbxxLjHU9YsenufbfgNEsbJ04+60dZUbKCQA3uHGGSNB92zRIhUDg83elx7kw4hC9/L0OiEqksHrnTzdTcv7nX+ug+EmEVMzyZbkD0oq+X/aIFs3mL6je1Z8/osVodBIaXJb3fNSvVIgFcFU2QnYOCB4uxyY+A2HqzDKKvpdIeEMKoakpn4xzALFO08u1BqapOnw7SCT8+OhPeDsZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4339.namprd15.prod.outlook.com (2603:10b6:806:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Sun, 29 Aug
 2021 06:31:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4457.024; Sun, 29 Aug 2021
 06:31:06 +0000
Subject: Re: cannot pass ebpf verify bound check due to compiler optimization
To:     rainkin <rainkin1993@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAHb-xaufru2zfr0hzOe-dkXDNhZXb1hpNkWK5z3uu5jYQuNeKA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <71f62863-6931-e395-c197-679ef2af0e7c@fb.com>
Date:   Sat, 28 Aug 2021 23:31:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <CAHb-xaufru2zfr0hzOe-dkXDNhZXb1hpNkWK5z3uu5jYQuNeKA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1701CA0007.namprd17.prod.outlook.com
 (2603:10b6:301:14::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::11ab] (2620:10d:c090:400::5:3718) by MWHPR1701CA0007.namprd17.prod.outlook.com (2603:10b6:301:14::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Sun, 29 Aug 2021 06:31:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b9d157-92d6-463b-53d0-08d96ab69482
X-MS-TrafficTypeDiagnostic: SA1PR15MB4339:
X-Microsoft-Antispam-PRVS: <SA1PR15MB43394406A264B532FC2F6BB3D3CA9@SA1PR15MB4339.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfcI7G+OUy8/AR8AhaAK+x9wEiBvve583VN+6I0bKHwT03obDmMzV2ojOuMaSmVKPsNw5fS3qqs3eCNP2yJfU4kfXy0XzeCruiXQT0/QCUN6S+LffZoDAH4TFZT9AY9B9HY9jiN9sEFmO2Fi83bA74aA2GchcrUxa9Yxc2Unkf6LC4uSJ/vk1ebj2EonVx+ZWorymUnACsuX8MiHPoOuzjk38UKqKymt+h3g+BP8Un87/NHUdFyYURyL+LKOFWhg05rCMTDY525lVnua/XwjwWEzbV1FewsulSy2DDjzMu/n35yukwVKkznnMbINEDCmhuGYhMskdQW2nyzW7yPZ+MBdhz4M1j6xinArRnSfI5n4uIqa4Nyhu859l9v+uBfYI2ki6bh6ACNbJhWB6Ty6ordECdt611cG/+ere7SCtTNdWe+hlDzxQH1m0J7GS+l3ZOECC8/yh+h2uQfusviT5RXZP0FG5kRfFlkvOUpt9LTqocfk6khp+zWSAAhTLM69eIWikf9zfsXSyFcIpaTD574H14PHm5eMYdSFHPchHuTL9qoJCxfqo4V0yPBM6RI187E14D4pbyZrEKdPSbQw32quIw7BXAqncRrihlbX5C82HN1qImmM3X9n8R1jDppyF/V7PSFnMSoJA19+P/q4/9aQI2lGUYA9gaH6V3j8IO+rt/MW2jZB4jLj8RRBpLxe7n0dZNuRXrJmG4hYPnTGiFk8cCpOhqjYiuivuhrbJMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(2906002)(316002)(31686004)(36756003)(5660300002)(66556008)(2616005)(66946007)(86362001)(15650500001)(83380400001)(66476007)(8936002)(53546011)(38100700002)(52116002)(478600001)(8676002)(31696002)(110136005)(186003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkdKUlN2YVJvc0ZGSitybE92ZGpuM1g5d0pnRkdpbVNHRDVSSXllR3R5dnlq?=
 =?utf-8?B?c1lzYWZRb2xMU1hQKzVxN3VtR3pTdFNpSmFBTmErSHAzUCsySmJ5QVNxU3gr?=
 =?utf-8?B?QkR5QjYrNmJuK2pvenlxTUZQQTZGdmg2S3NpRVRGNDgxK2JrekYwMnY2SmJV?=
 =?utf-8?B?SlBsa0hIOHEvQXR0WnNqcjhVazNvMGN1eFN5RmpyMytHNWJYdzBIY0xMWk9S?=
 =?utf-8?B?aGhVY3ljQjZCNmhjek5qSFJxNktzQ1I1aHo0L3RJMHdrSWF6RHdWdnRqSS81?=
 =?utf-8?B?ZWl4all0UE1XNDdkREVSaHdyRkdZUVlseXFVU1Y2RFozRHlGUzhBM0IwSW1U?=
 =?utf-8?B?TGdWMlRyTGlWV1NZNS9iWllyWm1jeXA5cFJOajUyV2dkK2ljMThYZWxicnha?=
 =?utf-8?B?QW41a3BudEdKU0lJR2MvbzRwYVNUc3o1aUZDamxWYkhJenNMR1J5KzdQUUYw?=
 =?utf-8?B?YjdCNU1PN2VoMER4NzF6UWdLeEdaTjhnblZ3Z1ovWVU2ejZiRHNKR1d5Nksy?=
 =?utf-8?B?bE83Zm5rdUVtN250SXNKL1VneHNtMTZPOWdYd3Z2RjJlanc3L3pub0VRVzg2?=
 =?utf-8?B?RHBBNEFMN20yWHQrSTdTMjlweDk5VjFORzIrd2YydVpoTzZuUnZUR1VTWTZq?=
 =?utf-8?B?OG5rcjJKUmovSWN6OHRZeWs2Q3ZDS216UlMxL1ZNSnFvSzNveWdPK0gxeHA3?=
 =?utf-8?B?QXdGcUMvNEhtcS9NSmREZWpOWVRLVU9mRGlGM2NwVzN4MzNwNGJNQ281NU1j?=
 =?utf-8?B?OXVoczVOYXRZeXBvSGh1WGN0STVhWDAvSWlqTEg4aTFWV29MUVpsSHhqS1hj?=
 =?utf-8?B?LzZ6VndkVml4VkVRU2o4U2xqbGRsek1lV3NCZWJ3dWFqRTAxZUdqQkcveWJj?=
 =?utf-8?B?dUVENUFDdmFsak9XYkovbjFNVTYySnBmZ3RLYTFUcFlWMUEyNHpsWTR3VUlt?=
 =?utf-8?B?WGpJZzJjeGhYWmJjdHpJdVZZU1AyVzUzcjY5czFHdHBibldiSkRGdWZ2L1U3?=
 =?utf-8?B?dSsxMmYrLzNFM0xtdks3c1ZkbGRadEtpMm5nOTJmSnBtR2xWZ1YvZnROL0dh?=
 =?utf-8?B?RldKQ0M2a2FCTTBub0JmSFdoWjZCUHlZQVpCZ3NMamJnaTJSSlZpbm4zVVl5?=
 =?utf-8?B?YUFnVlFnZU1QTlYyUzJZUlZ5NFF2MktQN3JpMU83dnkwZ09lQ1VVQlh2VmQ0?=
 =?utf-8?B?VWJrM08wUFdERkRsaTFnNWQyL0xHK3I2Z2NNbWRuQlAveG56RmEvbE1TeEs1?=
 =?utf-8?B?OWJoLzlJOCtadVU4bWVLbTJnSzI2T0luUmlhbGo1WW1mVU9lMllTWk5GODRT?=
 =?utf-8?B?bVJlTG9HMnRUZTdxVzBUTHV1TlpSZnBnckgrY0ZUSEhHYlZXckZJSFdZcHdm?=
 =?utf-8?B?aEFxalF4Ym1RY0dudGgvMHkxSTlTSGxMYmZyZ0JURXBLL0ZCblZxdGFIN2Nt?=
 =?utf-8?B?VzhnbjFvb0JUNGJYWjE2UTF0bHROSTR4STlhTE14NXlzNS9XQkVUcEpoUUMr?=
 =?utf-8?B?dFIvQ0dKYnowQlhkdzNBZkZjeFJ2QjhhWFoxYTZPYktnNjVpMUdOWU83M0x5?=
 =?utf-8?B?R3c3cDQ2UXBlaEw4ekc5clNZTjBUNjNnenI5VUF1MUVRdHlZL0wrc1lOcjZU?=
 =?utf-8?B?VHlIa0NMQ1d3NkNqbzIyNGs2QTFlcUsxT2NIdWx2NjRxREFvU2c1UWFVNnY4?=
 =?utf-8?B?bzhKZThGc3htTXgxTmNLcVE1a0J5ZVdYSUt4QnhMdHhQamdwd2cvc2hsWEx1?=
 =?utf-8?B?UE84dUZQbTRKWWJNdWtSdTkvWEVWb0FlMjhDd2YrNE0zN0hYdUF1UVdiQkFQ?=
 =?utf-8?B?LytFS3IrcndybDNXT1QwZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b9d157-92d6-463b-53d0-08d96ab69482
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2021 06:31:05.9965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnT8RlZS3hCIexDfScWcTL52N417bsOvWeH/TCirBxoAjsZzGM9D2FV2SColtf3j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4339
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Zb4y1Z9MJxxg2UMt_AxBriTEeTvntql2
X-Proofpoint-GUID: Zb4y1Z9MJxxg2UMt_AxBriTEeTvntql2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-29_02:2021-08-27,2021-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108290037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/28/21 8:25 PM, rainkin wrote:
> Hi,
> 
> My kernel version is 4.19.
> 
> I have an eBPFprogram that accesses Map memory, and I check the bound
> of the Map value pointer offset when I use offset to access the Map.
> 
> However, I find a very strange situation: Although I have checked the
> bound in the source code, eBPF verify still reports an error saying
> that the bound is not checked and cannot pass the verification. But
> when I just a bpf_printk into the program, the program works well and
> passes the verification...
> 
> After investigating the disassembly code for several days, I finally
> figure out the root cause: eBPF verify logic is not compatible with
> LLVM compiler optimization.
> Specifically, there are two cases:
> 1. registers reloaded from the stack lose the state.
> The Map value pointer offset stored in a register is checked and eBPF
> verify successfully updates the bound state of the register. When
> registers are not enough, LLVM stores the register value in the stack
> and uses the register to perform other tasks. When the MAP needed to
> be accessed, the offset value is reloaded from the stack. However, the
> bound state of the offset is lost, which causing the verify error.
> 
> Intuitive solution: track the state of the stack value. In my
> understanding, the stack size is limited (512 bytes), it should be
> fine to track the whole stack and do not cause performance issues?
> 
> 2.  LLVM uses two registers to represent the same MAP pointer offset.
> When performing bound checking, register R1 is used and the bound
> check state is saved in R1.
> However, when accessing the MAP, register R2 is used which does not
> have bound checks, which causing the verify error...
> 
> Solution: It seems this issue cannot be solved easily by eBPF verify
> because the relationship between R1 and R2 is lost during LLVM
> compiler optimization.
> 
> These issues make me crazy... Do you guys have any workarounds to
> solve the above two issues before eBPF/LLVM is patched?

The above two issues are all due to register pressure in llvm 
optimization. Since there are not enough register, so spilling
happens for (1) above, and register allocator utilizes (2) above
to reduce spilling.

Recent kernel should have fix for both above cases.

In your case, adding a bpf_printk() and everything works fine.
llvm register allocator has its own heuristic. It is totally
possible that some code change might impact register allocation
quite dramatically w.r.t. kernel verification. It is hard to
give a good advice how to change your source code to have less
spills. But since you are using a old kernel, 4.19 should have
tail call support, maybe you want to break one program into
two to reduce potential register spills hence generate verifier
friendly code?

> 
> Thanks,
> rainkin
> 
