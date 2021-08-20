Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780BC3F27AC
	for <lists+bpf@lfdr.de>; Fri, 20 Aug 2021 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhHTHeS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 03:34:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6798 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238492AbhHTHeK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Aug 2021 03:34:10 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17K7TeV7017859;
        Fri, 20 Aug 2021 00:33:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=B8S8CzL6wUqx5ANZEx2seVusp50cLCxV0d1zXDOUDRs=;
 b=EMNfKMBdIXXiZifrerP9Tc3XpKsaWjavpZCLoXcmMGa+kjidWOR76jQWx7tupswHXEjS
 y3FgDjaxta9/JC99R//ke+8VEDwJDK6fHUKnWE9ThQKskdj7gzzrMnTbvL35STNIPhe6
 mVfkB8VzbVR3A+IIFlNPTyvr7RoA5iOEizg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ahnqup8p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Aug 2021 00:33:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 20 Aug 2021 00:33:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrPbWMilrynJ3xWl0sOzBGbkHOfMHCKoTQxxOCdjS2SYKoaNdZXHJLNm/ZFpnRtvHC5CyX5aEF0kHVyRTb346LrPfilm+KIEs6sqxyp6tS6jeKyrU85bFBuXsV2ntCwUfhua0rIZr5FI5ASALAAwpqL9gZb1nudwuk52Pyl9ZWKlYM/+sPE9XgZU5QVqbdCj7CcMO89n0SmIPjOZ/C1Q0/MI4g8kiiEzUeYxGOPc2OObpieDBtj8diut7oJk0AJihexQuZRoWwP0VARQo5ZRvGFjQ0RbUKpjn19wbkv3Lu1klEr35Ux2QiND+cWEVjU22ikaRb2hXB9+KkFvnuw/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8S8CzL6wUqx5ANZEx2seVusp50cLCxV0d1zXDOUDRs=;
 b=HzyS0LlMVDA7aSI4plb/CwHjRYjY0nbnXZ7WrjjnRqFmzpLgRsGmlKmkHCyqRlnilPYyyJXjBCClCxkEwFfqx5GxBg/xpA1StdGvMSdqM7Be8w2YTzxi9wUKvLod/mZ3af+Hcg2xvhJp3xGMHdd+mMRpf9hFV4YA2nIW6JurQFheFk70PcRNU9DyMXRi19MuBRbMWSQlzzAeobdWtGfQaxRsOyFMhUyrEYlA30pKfB8MwUAGcmOxaYlTXQE0pPTYtMh2MZr20nNjUvGIcLsdltpm0jBJfdk1PniZMvr8s8T4moHEO0xchHS2Pr0tw1dSdIZnrvB2mF/VVo2cqFzmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5077.namprd15.prod.outlook.com (2603:10b6:806:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 07:33:13 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610%4]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 07:33:13 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        "Kan Liang" <kan.liang@linux.intel.com>
Subject: Re: [RFC] bpf: lbr: enable reading LBR from tracing bpf programs
Thread-Topic: [RFC] bpf: lbr: enable reading LBR from tracing bpf programs
Thread-Index: AQHXk9CX6/TyfH2Y/US67JUy/V0E76t4+50AgAB99ACAAUGPAIAAULcAgAAWb4CAAARTAIAAAXWAgADblIA=
Date:   Fri, 20 Aug 2021 07:33:13 +0000
Message-ID: <D63A163C-4270-4783-81F4-18992EB5E706@fb.com>
References: <20210818012937.2522409-1-songliubraving@fb.com>
 <YRzPwClswwxHXVHe@hirez.programming.kicks-ass.net>
 <962EDD5A-1B35-4C7F-A0A1-3EBC32EE63AB@fb.com>
 <YR5HJkPyaM3TWkkl@hirez.programming.kicks-ass.net>
 <AB509D87-67C6-4B7F-AEFB-2324845C310C@fb.com>
 <YR6dreGQSe4oQFBr@hirez.programming.kicks-ass.net>
 <A5F7CF90-27F9-476C-B87C-CAD2A6BE5DA4@fb.com>
 <YR6ih+pKSm5TVVBc@hirez.programming.kicks-ass.net>
In-Reply-To: <YR6ih+pKSm5TVVBc@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffd6acce-d74b-46c3-97f5-08d963acc4dc
x-ms-traffictypediagnostic: SA1PR15MB5077:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5077988A0308D94565DE540EB3C19@SA1PR15MB5077.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n+QlTtMzoIFehBTswqIFnop3drhhnGwQKGN1bMFSjz/tWreC4sgdNRxaulwe37SKbqtyKtHUuTbJ5j5uu/7HS1AtPsTjTK1TnwBcBKUE/sbDGFF7eqgE4gg3H6dBznFvtVFacQm89cTherPooXRn0GMKHxR1eDkzgavYuEN2n1Dg16bRWXS3UF39OboMfLsaJx4EUeKFqTtHsQAJMc956JDEqpSPO4DrdHrUH+/SHOig1eQFiGGu1k7yicj9OMQi8hQslocGUQg14rZRlIDMW5wKnbMUoH7Cg38BFBginKVaRzI2ct9u5pPgfgVQNf/e+YjhB98ML8nVoSBooo/mtRrXyo0U2D7F8fNaLGyKbvPofuWMBinShuO2mlf/c5RE6d+OjiE/ZRLmzaR0PRHeu+4XtqAwb/X6xmvjJfVZfDtqMM6wxN8Nh/SJXtb2hMz8tmukyeJ6JChWATLafI0md6Qn7xHEFY/lH61HQcXisabdBWYwfMbujyTyW7QiI6w7SksS1QbRnw1j7Zr6HH87n75BYW2KVMh+NEmkFgOZ0oVonrsnoFlxTXl72RoJE0z2uXFW0oR3TV9jdNbNQsBBo43MzMuirvBmMXaYU8Bg6q3ic5FGdxTt4wnC2xEFQ2NlsLYYxibDQ2JdxCo+DNGejE8gyq3LkktvleLOOA2/vAg7JuyAoiOgRjsWzmtOwX87tW+Aw9nouLJtKNqTGLxqne9jFePdAwFXqd3yOn2rwhdr7Pl31nffkf1+J6Pbgfk+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(54906003)(6506007)(4326008)(110136005)(53546011)(5660300002)(64756008)(66556008)(66476007)(186003)(76116006)(66446008)(38070700005)(36756003)(66946007)(508600001)(6486002)(8936002)(8676002)(33656002)(86362001)(2616005)(122000001)(38100700002)(2906002)(6512007)(316002)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OhsynLWrpNuRgsQZxS5NOkOAcL1AW818yAOk2vRbUmwBdNYo5jCQREkCaaYl?=
 =?us-ascii?Q?IqAKXlfgTotH3Ou3NnPOgpcC0/9G8A58hKETH5tRqMfffzLMu+Y5EMwL3HIh?=
 =?us-ascii?Q?fVTe8uRH2Sr6nfY+dqughePkALQi2RmC0dPGCU3RUeOtz5iBZ5B2s7eg4MgO?=
 =?us-ascii?Q?Chj8hW4mJhx+JzVCJkLR9SeeDUBwaYZq0qT0xYxg3SmukyBSFhQqvy+mnyP3?=
 =?us-ascii?Q?cihss0hedPkSA0Lwn2WPJm94KKlxpIVSxepeBAf083Dubx9467yWganOIj7q?=
 =?us-ascii?Q?xJIAifeJKHCDlzGFVI7KdurhXzmdWcvoSoy0hI/dr9URvW6MZAGVwxQ8bp7U?=
 =?us-ascii?Q?lv+M2GSwbjZlMjaCHLeLIm7Y9Q1wIssOOB8d5kn3Wr/qadproOcKRCnXhj+i?=
 =?us-ascii?Q?mylPFA+KR12MoVa598nVbWyTsitAgewaoPZQzKsctmqHn3TsaDmv76a+Cn29?=
 =?us-ascii?Q?ug3aA6d9TV67jp4CQ2BIPg+BKI0VqCmTZAfCAS4ZAlesJdaJtKfg8RFMGG9v?=
 =?us-ascii?Q?tp0O8p0QRghhMwL+zKSxPkTVoLuS+sDUC9GrcBbcsFp9Q6iPY+x6trMk2iWh?=
 =?us-ascii?Q?SFAH6iEjBjBjJIi1AxRHTCcJF8lHKb5jG78KurdqMgErx9LAEGCiMwaO0ckX?=
 =?us-ascii?Q?RjM3Ms4ErdDhz0CLIl3ZUP3spKq8KkRiy/0eeZJQVHiDFCE47aStDkLFskZ4?=
 =?us-ascii?Q?UwPOo/6tOuacZwJkAcwkrTvfm7iBxXAXsMMdN3f13CdAmnrLpwgiFhBO1eQW?=
 =?us-ascii?Q?op0ZxIloVEMSJG7Ooxf9KvMfyW+2GTfanoc6wspeV5LTjw57cALw6ulJuc2h?=
 =?us-ascii?Q?44uP6lQl2qcBjk0urRQ/+U+Kn5E40NBXvteMo1e8uDO/nKlwSnDWTOW6y9jy?=
 =?us-ascii?Q?wss557yYZ0YAYJJ0swiwsg1/aZMOCFOP4Ud9G20my9AW3iqsbHgBGHbkJjyr?=
 =?us-ascii?Q?qDE+YW7kVL580OnwtzDzQYBcErIxCp3rvIVaIVb1uQn/5W1ug6LvKXWf2MWQ?=
 =?us-ascii?Q?WRJDJA4fdjYixHZt1HJec7GjiHiGxEMUPgTtIi0JuH1HylS6p8ni6IyutKB5?=
 =?us-ascii?Q?uekgHGBeIhgvjfzqnlpu9CY5Ztz8S74/xF4ipvrxASc1NHouMgkS6zWKb7aj?=
 =?us-ascii?Q?PyKxRJ0ucY8hdTqqn5QDQneweYnu6O1gLFO+4Rif3WxLdujz83dP91qemJnq?=
 =?us-ascii?Q?5CwNGcFfL4+3Gt3xNm6nhMYX681tK9hvs4bS++I3caARacTbvOVLgrgZH2g2?=
 =?us-ascii?Q?pFyEVDDkAhR7npUENqMV9bjMRhHyByL14+NW43JVnnA0O0K31+ibaS2yYOpp?=
 =?us-ascii?Q?wODDMTYMs3P0+pdUzgT/aTqOL69A4s7vYxrBit6dvV1FaL66fWgVK4ggt0Mp?=
 =?us-ascii?Q?OtbdJw4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4831817F276BD4F9F81CD2424BECADA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd6acce-d74b-46c3-97f5-08d963acc4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:33:13.6926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1gwOhxLILTXKNOB3SKevLKU1HH/dJej4R/jzJu7AWpMtgjmovobkp1dGjU8lBDnR0qYmesExuM34mIj70Vlbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5077
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: GIwyMSYz4OkETE2k3KOTxrXL7QUBBa_o
X-Proofpoint-ORIG-GUID: GIwyMSYz4OkETE2k3KOTxrXL7QUBBa_o
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-20_03:2021-08-20,2021-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 malwarescore=0 spamscore=0 priorityscore=1501 mlxlogscore=818 phishscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter,=20

> On Aug 19, 2021, at 11:27 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Thu, Aug 19, 2021 at 06:22:07PM +0000, Song Liu wrote:
>=20
>>> And if we're going to be adding new pmu::methods then I figure one that
>>> does the whole sample state might be more useful.
>>=20
>> What do you mean by "whole sample state"? To integrate with exiting
>> perf_sample_data, like perf_output_sample()?
>=20
> Yeah, the PMI can/does set more than data->br_stack, but I'm now
> thinking that without an actual PMI, much of that will not be possible.
> br_stack is special here.
>=20
> Oh well, carry on I suppose.

Here is another design choice that I would like to know your opinion on.=20

Say we don't use BPF here. Instead, we use perf_kprobe. On a kretprobe,=20
we can use branch_stack to figure out what branches we took before the=20
return, say what happened when sys_perf_event_open returns -EINVAL?=20

To achieve this, we will need two events from the kernel's perspective,=20
one INTEL_FIXED_VLBR_EVENT attached to hardware pmu, and a kretprobe
event. Let's call them VLBR-event and software-event respectively. When
the software-event triggers, it need to read branch_stack snapshot from=20
the VLBR-event's pmu, which is kind of weird. We will need some connection
between these two events.=20

Also, to keep more useful data in LBR registers, we want minimal number=20
of branches between software-event triggers and=20
perf_pmu_disable(hardware_pmu). I guess the best way is to add a pointer,
branch_stack_pmu, to perf_event, and use it directly when the software-
event triggers. Note that, the pmu will not go away. So event the VLBR-
event get freed by accident, we will not crash the kernel (we may read
garbage data though). Does this make sense to you?

BPF case will be similar to this. We will replace the software-event with
a BPF program, and still need the VLBR-event on each CPU.=20

Another question is, how do we crate the VLBR-event. On way is to create
it in user space, and somehow pass the information to the software-event
or the BPF program. Another approach is to create it in the kernel with
perf_event_create_kernel_counter(). Which of the two do you like better?

Thanks,
Song
