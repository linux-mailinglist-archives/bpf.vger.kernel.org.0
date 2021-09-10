Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D11407180
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 20:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhIJSxH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 14:53:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhIJSxH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 14:53:07 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AIikOF025169;
        Fri, 10 Sep 2021 11:51:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=Ys6BfrzZPq6GLQriOUQIxado5/WxsvJQFfFXWi/5dcE=;
 b=PSFfSJgdLeSVt4I5dM+sIxJUBvxQ35vr0iBCHzbeD7QuUkOC9GiQMGEJFAKWACilF0g3
 JqAKbgqG+NLGMPApU1KrnKG1NbSJj/f7L048R7Fu6GgO8U9ynadPsIyXdthrZCE2SmEt
 Ux0QJarSK19gg7ERdI7kk5+iMvsbd5aHqiQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytgk6u6a-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 11:51:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 11:51:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmCzcoGEMbqQ8mtHk9J5Uhc/fUlj/9NsouHcSerLoN5xXH0ptEqrkC+eoAH18Pd91lfR7oaTwGQT+aNLtXs+NFQi10KoQDnjc6jzjJbrxx48HLrTQjXQlwsDXJHu5lz3KPohoK1wRVKNkS2H9YuMDFv9HzClkfAEknfl7O7I120LZ8McOJSZ9k+6DWqgqc2yVQI/2BWZRJOiLxjH2kpvOpu3tBRawLROXe+iPmK4h1XgQb/eVc/hGS/uZSBLkqCr7d10auRf39Nyr6WzYNhEvBRfsWO40O3Ou3pe7spAjBwHe2vVrtX42+huHVy5GRdODP9D8LOvZA9YCAegaqJGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ys6BfrzZPq6GLQriOUQIxado5/WxsvJQFfFXWi/5dcE=;
 b=SEcXJcMsDFzIR+bmDPHONVLkbPIAQzxDN/bL87uS9WREA1sx5p9VeVCwp9rr7TPsb+IXwJAjtfwlZLHF+WO/jO3ZWtMo6+aVFpyu3ynplb5j5WoHLJJ3YLzPBf0XMjKB8T5aLQZCwhpBduK+u3tMag9srtl4i+RsZT4v8Dv56Q6QU05NPE+nYFwQ/liBB7g94PDYIZE5jgliRklvkG73eGsEqN2vGNlLG9NrUx4VqESqabRFogYIu6rCO2MZzRa7vAzvCSd/YVDuRuQfWlEmL4HTHUjoT8C6R+GOds6dJYJjvgooiJOwpjGhnvecdtXEPPiMtHaS93y5St8kRV0sgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5112.namprd15.prod.outlook.com (2603:10b6:806:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 18:51:37 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4500.018; Fri, 10 Sep 2021
 18:51:37 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Andrii Nakryiko" <andrii@kernel.org>
Subject: Re: [PATCH v6 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH v6 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXpCby8uzfjDX52kWXwjwsop4wLqudGFYAgAA1/ICAAExtgIAAA5iAgAADHgA=
Date:   Fri, 10 Sep 2021 18:51:37 +0000
Message-ID: <BFA439C7-31F8-42DE-901B-E64E93F29238@fb.com>
References: <20210907202802.3675104-1-songliubraving@fb.com>
 <20210907202802.3675104-2-songliubraving@fb.com>
 <YTs2MpaI7iofckJI@hirez.programming.kicks-ass.net>
 <YTtjeyfJXXiDielu@hirez.programming.kicks-ass.net>
 <96445733-055E-41E3-986B-5E1DC04ADEFA@fb.com>
 <20210910184027.GQ4323@worktop.programming.kicks-ass.net>
In-Reply-To: <20210910184027.GQ4323@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7eed072-fe0e-4e4a-3d72-08d9748c0505
x-ms-traffictypediagnostic: SA1PR15MB5112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5112CC0F8849A5BFE4DC4FE1B3D69@SA1PR15MB5112.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gWb+f4ZYvM0AWVX/201b2wTMbvS3ad4H4iXE6vckCCr3CY4Tb1ZpclfptGbGdtLjOfTEko/7Z8eybmlerEo6W8BRTilY9SlpoLOY1PfobYUyeU7gtt2cim3V/fYYrhQj9KgGBTVLk5nXnmdcezGTP5d3gLNHJoItW6CvT/Mgnee6DePCBS1jt4AzEJkzAiV5QHpr4wuwXIs1jzZ9mct9ZMaZxuRIOtXdmKOg8Z1+vFpDVC+O/pevfkE2JOSL2mm8NliOMoO7VBr+S8zHdtJw4bTssnnd56XSf4qKF+yAmBZ5wjYanm6u2CPH8aotsNKfGuy6e6yUAcMUPNT1rz5iQMsYgscCl1p2cSKfc1nwmih008iN2oRg1W962Lhknb/KJm09rYLEU+viLELVKfl5nupYrdTzA2Ydt3Msc2CEuPNTLkRBtjQpY0urnmdh7JFvRocTSfwppozJRmPB1H//AiKkvdAIlrZjPugTYi5MsWbTLbjRrIj22YDsOVxPu/wYfAe1rBaOmBASW07x5wTaDxSJppKyOtrCxS28z+1LkcyndVmD1fsF75R5+wPiWhz9bmx1ykd4KWLKcnRfL0qBspuw13YWgk7a6HJnbEG4cIKNbbadTB/tK/jrv1jFn3bOyhKlQdsar2zYJxSEW9/ZPieGTk6MUsopEon+8HtnQCb1Mm2mHU2Fns7+Z5d0esf1xdawPrT8X4PBcwANA4yAo3HRXZJg0p9I0oUAsMH6kUh6TAwKFbNjZYUKK4qppQZc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(4326008)(83380400001)(54906003)(86362001)(2906002)(122000001)(6486002)(38070700005)(316002)(5660300002)(36756003)(53546011)(66946007)(38100700002)(6506007)(2616005)(6916009)(186003)(508600001)(71200400001)(33656002)(8936002)(64756008)(66556008)(66476007)(66446008)(91956017)(76116006)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?syPVEppBW6Ltr4K+Kmtkj4TMIE250f+EO+KIDR4qDw8eTsMGcHdieFhDcBFM?=
 =?us-ascii?Q?XPV9+vaYaXGS1MtifUuCswQYBXnafN4FayT/7yk45RfhFfGvuZzgSl4EDG45?=
 =?us-ascii?Q?vFhN+BSGFO1ivJQllTtaXQK3s2D0h/LxHB5lNfXtuAooKaTkSajuc7XqYYWg?=
 =?us-ascii?Q?H04MXEqQs7DdG9NYIwJnyEcNh1B1qZX85sC5Sq7YI6bpp/5z5wPSVNO/2xh6?=
 =?us-ascii?Q?tXpWliCt5SV8j7cdwLEaP1VedGhxyZrXioez4siT5Oxjq3eiWsKiDkyYJghj?=
 =?us-ascii?Q?fvr8QGYPCv3y6CAdrAx9WXa3vQgETbuakscHh8f6nvFcjOWLIwNOmYfXoLth?=
 =?us-ascii?Q?07MSCvGayoxxgWoVYQBKseRUE22H1XsCSTO57NvckYgYhaGNVG9UMlTaCaxK?=
 =?us-ascii?Q?xnQMJKjO6coraAnvKPOhspVZRAkMfSl7UzVJDyerJrecYwZihHn9hGapUcp2?=
 =?us-ascii?Q?UjO9vRapJo3vM0clwa99wO63GPeUP9zw5evf9jMgtuGDRrK9bFup6hw2lhWs?=
 =?us-ascii?Q?PZKW+BWqV0fVw1Wpf53LeNsoJb55GNVymQAyyQvRnmysCRMnj/JSgNDt9U/6?=
 =?us-ascii?Q?Qkun6oVNPswh1dPpukE4MGGxq4ceCOsCryCO5uSO1xtHmQggTYvv0irc/DoU?=
 =?us-ascii?Q?KfPWjvn3CfGedrUGaKRLqM7uoXZx8dnWQ9wt6/cGtj35DYnVbImll0+bWfAD?=
 =?us-ascii?Q?F4LdOVkM6vLcMjpbPI+0UskWnZsqOrWpXawN+fHckXjxzYfbvnMrNxOdXLMp?=
 =?us-ascii?Q?VdnikakV29Fvj56oHZyZlvDR9wERQH7OZ+6hYfGUUN/ssAredpdl5Hd90oGv?=
 =?us-ascii?Q?GUfunTxThETlzUvkRhQ/qcy8U+IL6RMtTexsRkRJpNt3+lxMUkkvyjizRT6P?=
 =?us-ascii?Q?zxPmxdipJfoqa7Iqn2Pv55qQcTRPjiPMCPeLNFHDZ+4dQUypcEp9MWoBH7wL?=
 =?us-ascii?Q?jKolYLK9Kw2N6vNfmt/CklCYG9LPgt+t40CAwF/7kd0pbbugX6atnWHJqdjg?=
 =?us-ascii?Q?xq1CLYk5zjYr+evrpLabroyBBLsBLzFQFoJqCH+wMEJhYk30P9S0r7u35qpd?=
 =?us-ascii?Q?jyeB9mex8i1nSLcNkp2BQ8C9oyUmHxIkgBGAI/PbNCe+9Lj1SzPjMQ88iU6N?=
 =?us-ascii?Q?0DlevhrJcBv+DEgtY+k+31pjJfOSsOrGANilCACFdS7u6ZJcOl3xKG6E2U1B?=
 =?us-ascii?Q?CVDA1iEUsIfH0Zg5+RJpCBOYTUm1f3CI98jlbZnakeR9YGSe4Oc9Cap25Mzg?=
 =?us-ascii?Q?/dTMas8uYwAKWT0MqZDitEOomFOLAusnbUnQfMsbI8X5FOkdJAR+zSmgBXIr?=
 =?us-ascii?Q?6hz8OZNRB6f7MLvX3eve0ICRnxl9x90MbITnNaaucPGGxjdf+slgn4u4seRV?=
 =?us-ascii?Q?izZxugk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36B7A32472DF1A47965F7122ACCF2655@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7eed072-fe0e-4e4a-3d72-08d9748c0505
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 18:51:37.6296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ujlly3+s+6D67jcSGXDqSWhNE6DI9PAdk24WhTYi6kQ4Y5Rne41wxj12oPnsFC1TMmgT5Ea0iK66OloLJoft5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5112
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: jZ-5Z4YEjxmg3N3McESa23y_vExIsbI3
X-Proofpoint-GUID: jZ-5Z4YEjxmg3N3McESa23y_vExIsbI3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 mlxlogscore=691 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 10, 2021, at 11:40 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Fri, Sep 10, 2021 at 06:27:36PM +0000, Song Liu wrote:
> 
>> This works great and saves 3 entries! We have the following now:
> 
> Yay!
> 
>> ID: 0 from bpf_get_branch_snapshot+18 to intel_pmu_snapshot_branch_stack+0
> 
> is unavoidable, we need to end up in intel_pmu_snapshot_branch_stack()
> eventually.
> 
>> ID: 1 from __brk_limit+477143934 to bpf_get_branch_snapshot+0
> 
> could be elided by having the JIT emit the call to
> intel_pmu_snapshot_branch_stack directly, instead of laundering it
> through that helper I suppose.

Yep, some JIT magic could save one entry here. 

> 
>> ID: 2 from __brk_limit+477192263 to __brk_limit+477143880  # trampoline 
>> ID: 3 from __bpf_prog_enter+34 to __brk_limit+477192251
> 
> -ENOCLUE
> 
>> ID: 4 from migrate_disable+60 to __bpf_prog_enter+9
>> ID: 5 from __bpf_prog_enter+4 to migrate_disable+0
> 
> I suppose we can reduce that to a single branch if we inline
> migrate_disable() here, that thing unfortunately needs one branch
> itself.

To inline migrate_disable, we may need expose this_rq() in include/, or 
use some other alternatives. I am planning to optimize that after this
set gets in.

Thanks,
Song

> 
>> ID: 6 from bpf_testmod_loop_test+20 to __bpf_prog_enter+0
> 
> And this is the first branch out of the test program, giving 7 entries
> now, of which we can remove at least 2 more with a bit of elbow greace,
> right?
> 
>> ID: 7 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
>> ID: 8 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
>> 
>> I will fold this in and send v7. 
> 
> Excellent.

