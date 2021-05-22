Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978AF38D683
	for <lists+bpf@lfdr.de>; Sat, 22 May 2021 18:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhEVQqO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 May 2021 12:46:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231279AbhEVQqN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 22 May 2021 12:46:13 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 14MGg5YN019799;
        Sat, 22 May 2021 09:44:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=1TOzWxflbdC+6sZGtfdVj5ResIJ7KhFwhWzao7UrD+U=;
 b=lVvUATIi1huKuJtOc6318oDrHnzwQ/U7tHpCH6KXIm/sGZaPQ+c9O1q+miybW5+aWgxP
 bmj73fygFk2b/JuRqxl5wfAu9X09/8juH+DpslN4608qYkAZl8w+Ku26Y3din/Hs/p/Q
 bJDYvssBhCinbWFRBJTSGnLrHB8+f101+oc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 38pwfbsenh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 22 May 2021 09:44:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 09:44:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+8W3qZJliXLCnq7UKKFdrtxH8AeKq1rNZpG7UJjcTYNTXlyqTaZZOPe6UeRJdHgcaA6u9myoEM3G4JdbZXK6db3zAf6I6vptWv//1RODHcgnHdBSaN4DvR94rq1Fa1RQVqSVnhUsz8SgRzpl8qrddJvj6s9Ply//5IaKI8L1EBtInOe8n3nsx4OoSNzkEUxqjah1brRW517im0rM532K8TnlcIw4/9A7SW0n+cknidH/+XWkQ+Ld4Vp8ZBd1wV9FIZ3yHtk8rZrxZ+2cg6ZVvrm+5ivIiXq8VXwEGiT6SENbBCPLUjRneFR5EBsgFtCeTPDrJzYqKNMP+Imnj2TqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TOzWxflbdC+6sZGtfdVj5ResIJ7KhFwhWzao7UrD+U=;
 b=ntX2GDlowTBUqRd4IRG2vqgLVMDwTWOliGAMbgRJyLlmpi1AzjNja47fSc8Si7/TgtPQIutv9THbbQQMelBEGe4Gb01hGBdX8W9gxwP1ZrMewW2bBZNMXHPbrG+8o5tcLmiYJXKay+Z0fqJEBLI/wb5pxSTqXkz3VfF7GGWQz2WRLVqeiSx6sLmbTTg2zbW/wl+hS9S1OuM3ogotoCQmK2UljDCawkJk3AWjxvQkXRH1Sk/TQP3FbtQ2Sbx1miRjSTH2wRvYnOqWWe/D3j8D9nRX9KLHhACiunkz2LbwTmv0pKF93AwC8gFBeOB6LXBFupVsHuSVvUaOZtg09C+7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (52.132.118.155) by
 SN6PR15MB2206.namprd15.prod.outlook.com (52.135.64.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.31; Sat, 22 May 2021 16:44:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4150.026; Sat, 22 May 2021
 16:44:28 +0000
Subject: Re: [PATCH bpf-next] docs/bpf: add llvm_reloc.rst to explain llvm bpf
 relocations
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
References: <20210522163925.3757287-1-yhs@fb.com>
Message-ID: <aae741ff-d609-5796-d860-d234884f5ea2@fb.com>
Date:   Sat, 22 May 2021 09:44:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <20210522163925.3757287-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:f9bb]
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::19ef] (2620:10d:c090:400::5:f9bb) by MW4PR04CA0133.namprd04.prod.outlook.com (2603:10b6:303:84::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Sat, 22 May 2021 16:44:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d48cbfb-3e3b-45c0-b177-08d91d40dd6c
X-MS-TrafficTypeDiagnostic: SN6PR15MB2206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB22065787684B74BF30F2D5E6D3289@SN6PR15MB2206.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tODiholfG/dZK5mK13eLmbgCPU1dAGM70bRrYsJtCH2P8wD0ypPsFxCLCgC45oTcdhJMF83DZM6GcFQy9Z7UYK/4K2YVo39l6U95wE4INfFG7H3zYVmRs2k0q9uzhnx8OBVYX05LuUEXw1RUbGoT2ft8eipj6/PRGSW0C72tUWfKLQ3mv5lBFc1uDkW0oIh5tr+Z1EL5fGa4tO1PJU0sHZ5Pyqsak192XYOFfnjz18oLPsnd8X4pjsbx2YzzTnkXvMgvcIYQvcBXrer6E7JIa4l0NitBdCNHP34CanLcd5ww1DNO5wxld9iBJupPaKirNtDNL8W0pp8cdmmVE5HyUS1RvCe2PTDnUBEdz6SBsPkOtxkizQZciX6tsQ6iVvE/wFK7b9Y6Bq/7/iOTSBXCx0lSyWFlINgVNCHaqfWWhTQrV/cf1fepfcQAukmio69Wk8hXd3o9Mv4aoCNEZDmW7bIDCiC26Q3LbU6BoA93/llIwenFeeMZKA6Kw/O0E8z/qWSrt+aQjmxAapFAnO/mECmqPdE6cW2qKqJc1PYXeREGiUFzmIQmCU6rBpkjWNiL/KrUf8jyQpzNR9p13c4XORsBkKJ/uVPPF1kioIC7wodWWomVEZ7Oq4jEQsiAdbD0IEFY2rfp2GedXw9PE/OdS4dL8Logw1wDV379RgQ73g2xRFF1ufi19zz8/N+9rpwGH9TV2p3WFCpy1LPbCdZ5ITXBGhTUL2wr/WE5Xk7DE0RwXhg5wCvOSFV55kuTYqBRIB+TsvRjc+HJEepTUujCM6rLXS9kJ3qqTfn5C4Ffgfv7+JGR2l81tsIyn/aaBIuo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(8676002)(8936002)(5660300002)(31696002)(54906003)(86362001)(66556008)(6916009)(316002)(38100700002)(478600001)(66476007)(6486002)(2906002)(66946007)(966005)(2616005)(16526019)(186003)(36756003)(31686004)(52116002)(53546011)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QlZyNWRmdmFsaTBlVFFmaS9XMElMVGxZTFlCa0dkNVcwblVEVUdhcGRzdFp2?=
 =?utf-8?B?RVdNQks2SEg2UnhYc0tGdFVJdVpnTU5tRzlMMXpXRlQzTHdkVlZSNitFNEE5?=
 =?utf-8?B?YStsZmJOZ3pTd0hNREQ1bzBQdlFqTW1BRnc4aVg0N0c1OWJlZGlsOWFiZU4r?=
 =?utf-8?B?WGh6Vms5UnpFWmE2TktaczA0V2JTbE1LdGhkVGsyS0VBUkhPY1plUWxNQUVo?=
 =?utf-8?B?QVF1dVNrQ0x3TS9oV2ZLenZwZXB3TUZjSnBQVVRFajZJZElXRVA2RnlEVDRG?=
 =?utf-8?B?TUplb2xrTVNVUEpvQ1RMemRTWHBtTHBHdTBaZUcxeTdHaUZvYUFIYkhtOEtJ?=
 =?utf-8?B?UXpMYnhsdmhIajkwTTk5eWZka0prVGk5TVdrVjFvMFpVL1FhRnF0SXFyb0Vl?=
 =?utf-8?B?dEcwUEJlMFNNS1NuQ2NVWUZQeWpwVEcrY201YTBuRm00KzZLNUZqMnB2NFFx?=
 =?utf-8?B?N1pINHhFR245NzVRVnc1cjV3dXhCZUtoN2xKUzBzKzFhemJhR0t0cWN2cmQw?=
 =?utf-8?B?UEZqR2I4WkVUQlJLYnNKY1hlL1dYQzNZME02djA3bTZxd2VTSlNnYnQ0L242?=
 =?utf-8?B?NjFLQk16TklQMzR5N2RkVnRrQzRiaXNwTFpUMlNDRDRESEJrT01aaS80bm5u?=
 =?utf-8?B?WXlGM0ZSbTRHVmx6cGgxR3NhZjNoZVJyK3BTOUNoaG5ZNitpekhrZHJDLzNl?=
 =?utf-8?B?SHNXZTA4eWNQdjVHMDRiYmhzMjlyYVZpVXZkZTRDSVk3ekVTcFV0Q1g5NVBq?=
 =?utf-8?B?Y2lvZzUwajFrcjIzS3dua1ptcERDMHo3SzIxS1k5RWVTVCs3TkVKL1o2MXA0?=
 =?utf-8?B?cDA2ZWFhcms3TnhJcTgzZzZCY1Q3Q0xVbDlpUG82ODR3bmg0TFQxRnJaY2hz?=
 =?utf-8?B?Z0ZOb0huUzloTThyREZMbURNRFh5ZjZadUgzSXhxQmVOMEFtTVNJb29SSkVt?=
 =?utf-8?B?MTQ5SVdCQjZuMzFtZXRkRTV5SVJkelFueUVPNHRYazMvZzNnWU9rRWcxZith?=
 =?utf-8?B?T2hieWlxSG14TS8rNndmZElxNU9aUGd2b3hvdUUyVk9yeUJCOXVFekpFY1VB?=
 =?utf-8?B?VkE1Ujk0ZXVlKytuTWJ1NUhMa1lRRjJVTkx3S1BtZVM1aWdRVWtZbVh3Nnhy?=
 =?utf-8?B?L0Q2c0VqbERoWVNlcUdWWVFZNzNoRi9ENzhSVzBSQ0QvSE9iMWt0MGVldHpw?=
 =?utf-8?B?QlVlaitHVjFwV2RueUpTTERybm10b2dwTmczWUJ5akdEQ3ZZWEtBcDlyTFdP?=
 =?utf-8?B?M3M0VXhwcEJEdmpPSllZclVva0tUNTFIM0NzbFF0ZS93bS9rNnZoSk5GY253?=
 =?utf-8?B?WndVc1ozUUpseHVnd21aNytvakRXNHpqZTh6ZnhQWDJ6NjRpSjhRTFpjTlc5?=
 =?utf-8?B?ak43dGQ5RU9GTmpsNWNBQ2xnczVZQURIYUM4ZVRjeWhJL0lmWVI1MVNNL1VH?=
 =?utf-8?B?S1E2bTVKSVV5Y1YrLzVYT0orYytKNjZ6amdCOVZXdEhaMnRqbUU1bWhlUklX?=
 =?utf-8?B?eWQ0SGRPckhFN015WSthaFVzeFA0VG5CUCttK2Z2SDN1b2RuZngzaVNadWcw?=
 =?utf-8?B?Y29QQjFtcmoyWGRra2w2aWYzN3kvMCs4S21kUGxYTDZtUC9mU3VDaC92d1ZG?=
 =?utf-8?B?WGRZT25nSmxLcTdyYkZWRVJwdWt4ZkdHVkhId2ZQcVVEczEvcWNpcjJuYkxP?=
 =?utf-8?B?NFN4V1BYL0NMSWlPYmZnSmlsbW0wZTI3RXhMSld4bU43c0M5d2ptbWhsU0hk?=
 =?utf-8?B?SmNMU1JPa1RpRllHeUhCM1pmZTlxRWdyVU80c0J0MG9JU1FOSkZRMGRSK0k1?=
 =?utf-8?B?M0xaWXpBWWNkeVV2UmpnZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d48cbfb-3e3b-45c0-b177-08d91d40dd6c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2021 16:44:28.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2k5mlD0HjPBEqiC3jIkMC1T9vVKmA5FkmPcUTu1RVbt59pAHw8EHPMAJXn7MEOU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2206
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: TKWC583TROSCfD7Axc8e9c9MtnJMOzRB
X-Proofpoint-ORIG-GUID: TKWC583TROSCfD7Axc8e9c9MtnJMOzRB
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-22_08:2021-05-20,2021-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105220122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/22/21 9:39 AM, Yonghong Song wrote:
> LLVM upstream commit https://reviews.llvm.org/D102712
> made some changes to bpf relocations to make them
> llvm linker lld friendly. The scope of
> existing relocations R_BPF_64_{64,32} is narrowed
> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
> are introduced.

Daniel, John and Lorenz,

Could you help check how the new relocation scheme
may impact you? libbpf has a similar issue and is fixed by
   https://lore.kernel.org/bpf/20210522162341.3687617-1-yhs@fb.com/
In most cases, you should just change relocation enum number,
no relocation resolution is changed.

Please let me know. Thanks!

> 
> Let us add some documentation about llvm bpf
> relocations so people can understand how to resolve
> them properly in their respective tools.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   Documentation/bpf/index.rst      |   1 +
>   Documentation/bpf/llvm_reloc.rst | 168 +++++++++++++++++++++++++++++++
>   2 files changed, 169 insertions(+)
>   create mode 100644 Documentation/bpf/llvm_reloc.rst
> 
[..]
