Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6186402E9F
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 20:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbhIGTAy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 15:00:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22296 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237636AbhIGTAx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 15:00:53 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187IwN8b008933;
        Tue, 7 Sep 2021 11:59:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=GQHKdsW8YborBWsZJSKSZJELzHCrZdeOv5zkzPaI9jI=;
 b=evUTh4OYHR2lg8MtWY5vDFPxvXZ96HFbBiKmukV2Kd+BInDR591C3377f1unskj2G6p2
 4DrNIzJddI+RdeJ0L+k408WoS2BdPkd12w6ojU8yYSAoZEgYSvhzgBJTV1zjO6aKxOkb
 JM4w0RRsvU/NnsEeL/f5bvKssMolc28X1n8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcpggjj5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 11:59:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 11:59:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSx+GaW1DbqferIXDY/lBcU7h4QCF7mGb9x0R9MipZYZVzUSmPzi7w4ECQ3CQxHLDGZwlzVBP27cIv1vQLNjvZHm0JC4HhlX/svSBNeeXya0w7asfAiXcjPAnE/KuOiJFo5wylZRxctU+dA7ratIg1IlqybxcIlQipTFlZjnLvu+4FufCTST/O1iKH8C7Jp3f5JpuyRSASiSsE22hC/9u8RjITr3EAyiTBmsgqWEmTVGdf0r1cyhRxaNSmZ+tbSTAmMC5Fgbbu0Ni2Sfr8wLbF8Sgf87vDfaLaDu+/jJKLhM6YCBSM7UWS9GGivZmE/Slp4d4Hly3y4gTr7TGT3s9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GQHKdsW8YborBWsZJSKSZJELzHCrZdeOv5zkzPaI9jI=;
 b=XST5yvum//AgRr0qScI8OCgGdGBGjuUQPGAn8I8cLwrxt8W2w0NAa5n+2i1flmr48dJWeHFHUT+GeUFcF8O7TqMXWt4Yj7bWrzmEz8qts7AzXU8pfU3xGQ1HwanK90Jt1kQXIvneIjWN6eQYHypcw9w8M8BTt5wVzMotKNsextO+B1oDYPCwavWehM87X/Ar9TAgOd6X/wYiXzBQAe8sv2dZ2S6uFPptMA3uFcsv+RNGf9n8reT25qvSNf/7+7NMM8Xe1VYBOYbHFFsq8DOpGrC8c2Rpk6QnecZCYpa5arQvm2CaDq3ZQaBEcchphivYcMeswsRMg0C1Jx+APb6C1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by PH0PR15MB5101.namprd15.prod.outlook.com (2603:10b6:510:a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 18:59:43 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::2918:43fd:5d67:cbcd]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::2918:43fd:5d67:cbcd%8]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 18:59:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH v5 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXoBueIwYxVW5RBEGe48w8ZsQtdKuR8+oAgACTfYCABm1pAA==
Date:   Tue, 7 Sep 2021 18:59:43 +0000
Message-ID: <B3CCDCB4-1D06-4331-A3C7-B1D413A4ABA5@fb.com>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-2-songliubraving@fb.com>
 <YTHWoCcSgvfx24/N@hirez.programming.kicks-ass.net>
 <D501C4AD-3778-431B-A710-3399BFE6EE56@fb.com>
In-Reply-To: <D501C4AD-3778-431B-A710-3399BFE6EE56@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db1d6183-22f9-4b11-9a2a-08d97231a73a
x-ms-traffictypediagnostic: PH0PR15MB5101:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR15MB5101E919CAFA00A67627C9FAB3D39@PH0PR15MB5101.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uoSTsYhhyI8lhrj0Ok0k6D++aQ08jNSj0UhprtYY+V4OoxGoBLwipFbofUAlkRBw5GDuilhuRA1cD5BNnZA5d7hDnAdeumZlQVNrL40IeE4sQ301aTTgfggB06GMqzPGQI1IdC99NNT6GxmT3kstE61VimnIqtpe2x4gBZOgijRNHWch8JkmumUybuUiE6/f2jp4lSYkI6k1MIW7IFF0oTPVN7lAqnkHy8KoIChcgDBlHsWBcMX9U1SHEFxrKLC0tS7zenZcMkVKiMR5HXmgOMhNhnmvjOGLtHdITYVESCH5p5H5u0+tCbjHSgNPAntLf8+niGO1Ig/+8cYpUtQcgz4d2DfyI7Ge7WMGLw9Vm/rRmwhohxiQF3E7yNFEAbpM/wjDec0NUAJ5xanDQ6PYbyB5OWYG3Etp1fIJ5KxZEDf0QzFw6hscw9COjK243ZrFgvkv4JO9uo3j/QeiLWezjIxOu9Ilj10ruu/+zTp0mXzaE9BmPusGZCqdHsWUqq/8HcA5X28OHXN/vysg0StPAYZybAv6e3m9ZANGJFKO+wJdvnaePC6/mruy/lG3SJlTEgBwsvM9j+FlOOCXC+aeH8+ofzDvjJbtJqSaLmR3liG7+ujHsaZwYG+09XcZM7tdc3BRCjdLnr1DPQNVI6eXgjRdGSgwccvOis6l2zDd53q+wMsyOgpVpatNunRX/EqJBOiXCu2782T9GrC6vjmeJ8eNE5aYTbeLSqbjWd3UqEM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(4326008)(38100700002)(478600001)(33656002)(6486002)(8936002)(6512007)(316002)(122000001)(2906002)(6916009)(66556008)(8676002)(54906003)(66476007)(5660300002)(186003)(38070700005)(53546011)(66946007)(76116006)(86362001)(6506007)(36756003)(66446008)(71200400001)(64756008)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aFsofOaR0qLVDrfZjlrvpifnhKsVoWiNj0nBYn2XUXaIX2T0DaJpAUThs5yn?=
 =?us-ascii?Q?E2dkULRQkG4MQdMfNNybnmQq/TRffr09XToWqSJVifTQlrlUBDdFctL5UMNx?=
 =?us-ascii?Q?5QApRYYffLSshdSZXIkpRbmZBZolc20kUnj7ZVD/ei0Vrl8g5taaSkeP/1Pi?=
 =?us-ascii?Q?YNXTv8zL1ljEYAeNxAMHXrgC/C5xn1yiPCpnBRqSmjBZNFOfHrJeO6topxmn?=
 =?us-ascii?Q?ydmz7Wx9obvBt/MmY8UnCms09YMoC9kV0nYjSSAecgruavHDqf08fuTnAYOb?=
 =?us-ascii?Q?ow1V1CdJYWmuEmjDNOJ63pqDA0B/N84eiFXfB6XXp5evvblvJCbE0zLnf/3j?=
 =?us-ascii?Q?uoXDyiu+lEskLD7ewxB6AmwJ/QM4uGFAKRiTHGtoNip1lJRCAC+mkcpoxhDK?=
 =?us-ascii?Q?WuUnES0Ak5mon25U3RC94K1/Zj3yHdb3OCohDxvT3dJBMgvEsFEhzKXv+NaS?=
 =?us-ascii?Q?aIIAW9e67wlxf/xrH78tvm14D8AbLHvakmP5jZLwzlc9cOGadiyQC9TZgDwg?=
 =?us-ascii?Q?z5gQnPr+nbUbyKLZHuDYKdtblraeXRq/SZGwa/Aem4mH4xP87TBkY2o5vrgJ?=
 =?us-ascii?Q?8SgNVPbVwMo6l19INWVN2y5CXPM0Ld8vlUQZL7QHcoigvpL7r7y+buU/PlTT?=
 =?us-ascii?Q?16YyD0La0RGcXQbwEBMl9B2mDZ15rDAPgpK611pBeCYH5giTmCZPZVJzPbGQ?=
 =?us-ascii?Q?p7QCu7NY/9UwQEad6JxaFZsaRqQp/VCFYowI2C0F5ma4aC6SUSL8a4xhJ+XK?=
 =?us-ascii?Q?owb1IoPsbhRz48W15542gxguQNGfuZ3Q2dd7iMiBIBa2+9YVjI+OZqNhjqIs?=
 =?us-ascii?Q?sYRe0eRf5N9wUUdVNFZ5rnLjIdPm1JzVzQZE4woybGcRydnovXcwXY2knJ83?=
 =?us-ascii?Q?t4G80Y+bZah3h2umGgUXLbr04j72lv6Am3HtzYzZTGUHMDcPgCMF1lIyp6Lc?=
 =?us-ascii?Q?8zUCqIKI3Sz+Ooy2hcvkLzcQtc3r2el/eOvIet9vOdqMZb7fYraJwHkcBGZH?=
 =?us-ascii?Q?fV7kWNrYIgnKScenrPutnGAC/+1JrQOZ5QSGzvXcTK3wAqIq9+1zNY9VrCwV?=
 =?us-ascii?Q?1UMFb+MwbKc30XPI9i5SGi7CAMc+2WluxAiSewdvnGfHmytMmlUP7j/of84R?=
 =?us-ascii?Q?P9sKPbaNWyO1Uk1xRHHFIXo3EpaQlMn+A/DVzgubFuFMLWAPPPY+PQNVm060?=
 =?us-ascii?Q?7aF2cStdheUd+oRxtp+DMVJRAc5sjElCGfb1YeH/95NRTCzrO6IB9CrvgcIY?=
 =?us-ascii?Q?BvmesBZAmUIeG1Ao0fAZkuqL+UAc67ccDiPkAuQsbmwRt/QNuDISJ0JSvBxr?=
 =?us-ascii?Q?hIkB0oSDXAVvMmHfaIWopVs3qxU0vkxPJWKjmHUToufezucitF5M3smqXwR9?=
 =?us-ascii?Q?xKfLtAg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CCA720D512B5DF4A86C9932FC3C891A2@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1d6183-22f9-4b11-9a2a-08d97231a73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 18:59:43.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5+wTvQEpFEltI/4aclgKYTnx3oVDj9KhjipZKU4rfn36+xKYtbizku3eFKY2iYV7iItKelrGKN4VlUUdZ+paQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5101
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: aYwcPC57Q-HJzzmCgQ9beF7itJotF_eG
X-Proofpoint-GUID: aYwcPC57Q-HJzzmCgQ9beF7itJotF_eG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_07:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 3, 2021, at 9:50 AM, Song Liu <songliubraving@fb.com> wrote:
> 
> 
> 
>> On Sep 3, 2021, at 1:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> 
>> On Thu, Sep 02, 2021 at 09:57:04AM -0700, Song Liu wrote:
>>> +static int
>>> +intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
>>> +{
>>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>> +
>>> +	intel_pmu_disable_all();
>>> +	intel_pmu_lbr_read();
>>> +	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
>>> +
>>> +	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>>> +	intel_pmu_enable_all(0);
>>> +	return cnt;
>>> +}
>> 
>> Would something like the below help get rid of that memcpy() ?
>> 
>> (compile tested only)
> 
> We can get rid of the memcpy. But we will need an extra "size" or "num_entries" 
> parameter for intel_pmu_lbr_read. I can add this change in the next version. 
> 

This is trickier than I thought. As current lbr_read() function works with 
perf_branch_stack, while the BPF helper side uses array of perf_branch_entry. 
And the array is passed into the helper by the BPF program. Therefore, to 
really get rid of the memcpy, we need to refactor the lbr driver code more. 
How about we keep the memcpy for now, and add the optimization later (if we 
think it is necessary)?

Thanks,
Song

