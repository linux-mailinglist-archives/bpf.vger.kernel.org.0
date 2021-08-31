Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61223FCB3F
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbhHaQNl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 12:13:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19418 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233018AbhHaQNk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 12:13:40 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VG91fL013059;
        Tue, 31 Aug 2021 09:12:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=vmv3ZcOAxR+piX8FLlTSbIZ/NiaYfEKXxPbnWH1U8f4=;
 b=e8wyk65Aa9YBOhDTZcLX/gcx7SPzyU39+0zfRNiQu+kEfooZVMlXw28HFGGj5dbTyuM4
 7cHU16g37IWvEunCtRa+2B9yPQcwH0erbEf4bz6ghDPOb8MogOWs8/d5CH6iWBOkIO/W
 uxrpSjjqGNv8LG8ocV0VzJ4oa/P88pv+MYY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3arykq0tkq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 31 Aug 2021 09:12:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 09:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMzAb3/gFAXp8GW6efeRvJclokLUyVqjwAHKIhDKug39JsjZn3r13rS3L5iS5rsjoizA4kAObK2cbm8dt0VjuDY8dDR5Bpso2VdjdTzRzqoeTi3N2ihdyvkovQ6AKpVr42CCBUzH9+qGLXbz5BYeCdsYkjgQt5fBPXyCojPJ/nNryMJbdHJJ4Ez5X/NNy2f2LhjhBayvo4+R43fqfg7jHDZuhxW63+26WJpcwxFnmNg47QUGVnv7UhiAxrmPyCAzCEuOAYxrotYn0QuOWQ8ww3j2g6V3UElhsF3y5+Sf4E23bqd1HoGGWtcJSiQEFZkpsH5xylHZ6d/g3+6ABn5f2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmv3ZcOAxR+piX8FLlTSbIZ/NiaYfEKXxPbnWH1U8f4=;
 b=aGOSwL0isoPAm2PO6/3DoPKEgEws83SN/iCdL2dbBe6+fjur/LKnbZhI0gRahgUjWxc6UoyhnBjwhww++4dOyJ7zDRxIJGVWXfmJItr/q41zbNykfJoFRpYIZhj2nWYCybXgfBtjQBzJvvN+3r6w9rQ5ovW3xxEUy0xs+Y2vd3DFi6srl2oxeLvkxpFq6hQYgXSYSt8kD7YiDPAI+FALKveAQGeJmca0XZBJJMb5KCHPeR/4ho92KE+XCRDvvptQJtwXuo/LjC1xX+9z8Y2SFkYCAnOYqXSdHFeLwfw1KZmhmnc7rhRBKouCsRYWR8UAMHx59MkZ0M6rwtGIw6zhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5062.namprd15.prod.outlook.com (2603:10b6:806:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 16:12:42 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%7]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 16:12:42 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH v3 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXnefK6Dg/bsQBhE+Mc9IkeTmV3KuNvMEAgAANe4A=
Date:   Tue, 31 Aug 2021 16:12:42 +0000
Message-ID: <D4CBDC8C-ADBF-4EF9-9CE8-169D0052A3F7@fb.com>
References: <20210830214106.4142056-1-songliubraving@fb.com>
 <20210830214106.4142056-2-songliubraving@fb.com>
 <YS5Jqr60qHZ14+2g@hirez.programming.kicks-ass.net>
In-Reply-To: <YS5Jqr60qHZ14+2g@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ade87916-df26-479d-3c8d-08d96c9a294a
x-ms-traffictypediagnostic: SA1PR15MB5062:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB506277CC973F7CD462107CB4B3CC9@SA1PR15MB5062.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHsSis/7sPMYuNfFkZ5jH8zC/8X+hzBiIHsEoJDJ4yw5K3xz0TQLP7HUFujPHC2n18/LNh+umf2RpWbiwu0RiS4wJ2HuzGuekXNaQWiNao1t4IlpfyGyCrFV0ysaQUT1fDpPzXSy3qu+BaZK+tfDSIStyloYN2XJJeHrWqhaAeLN+qfcCiRyIdYneDpvCx/3ZH1/CF+yIs+zBmWmpBY2XPITwOAZRdPEboY+gYnWxIOFqU4bJbJdL6g/85loMaOYRnsH79T3usn8XFqj3K6zHKZE5E6UFNKn2RKugjcTjAn8VogEI0JjI4YUrFs9ySDAxLcYv4qDpVVRZYmkWuB/3Jk0o7E7xcxi0/712Z5s0asIoeTt0EGYCsABQTIR0FpKHZBfMc3gfvnWA+rR2y5EAUKDTE+yMzAyaZDPGgvsgxYtkshl4JEYyfrm+Ci9k8NdIIYzckcxIsicAG3htTet79SL1M7Y/Se2uKDgVaJ1Yrs229mxBvhN6gDNb8Yf3opO9UJ4eJrkcdBSXuqW23D8GgPu/sqHqobB9mrCnLvJiR9CKVsfTkQpF2XkdjF1HJ8Q5JCOSNbn/UDo0iZo7vq/9+Gzfz5DcRjSxE1JSk8aNgRsB3oaFxTNjww5ef+2HC8ak/I6Ok1Q1/DE3JUVvoCY9ugW1RhOrYpmG9i7m/lNcCwoQUAyvyUCOXW7enpHLdTuGXvG+I6CeHoAIdsKXLLTh8d7tnB99ON5Fgd7/YtZDL5TDKcHC+Qp+i7q7qGWFFRb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(6506007)(33656002)(316002)(4744005)(76116006)(91956017)(6486002)(53546011)(38070700005)(66946007)(66476007)(38100700002)(66446008)(64756008)(66556008)(8936002)(54906003)(122000001)(186003)(5660300002)(4326008)(8676002)(6916009)(71200400001)(2906002)(6512007)(36756003)(83380400001)(86362001)(478600001)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jHDtmA/1ax/IPciLSyZkUtR8ErXLF0gMv9/oESC2DECP7GhqVN8xH5jkqxT2?=
 =?us-ascii?Q?wc8s3Ob7ZktqBIfk5RVFZ380z6rkfYmaY+aowyqU4RhMSfK86sg25fmQns7k?=
 =?us-ascii?Q?+OSqDVXXdGTNtl5mSN1wU5sZ86RWr4/gZRJn66IY1JA1LE7cr37l13H5YdlD?=
 =?us-ascii?Q?ucRDoacICWP/FqBNf0PtxZLyQSUlPWw/52GzPxwgkAIZys2sr1FQdRwG8+0x?=
 =?us-ascii?Q?cYBsqHaM4uvcSKvmwesi6VNa8YR0krKw3LGEftJngEKQYVy6XuyS9i1cl1+a?=
 =?us-ascii?Q?mWXFlQj9sf5V1/xuH4+gKBWAUz1b+VbODy9cvFDUUK4CBA1tlrg4/ywKM6FX?=
 =?us-ascii?Q?iHJR6eoQIuL4zhdVLB8H1IDLtzif7aRuDJP2c0OvtQnIdiicubVh6ZImOrp8?=
 =?us-ascii?Q?DHmM6Y4/5o33sWXUGbdmqmZytfoNp2VLzbDcYdobAliMNKFjWDCb1s19dgPc?=
 =?us-ascii?Q?UbjL1NGKGkGJPNE4i2wGDfwUY9AQeqd5r1N0KqOsr8Ik2ORe0xxr8F/wWx2x?=
 =?us-ascii?Q?hdGgzsXEAcXJHrLKsQIJSTv+QC2QA/EIgDe3GoAp9wvq7gYtYJyKsmhAsl1o?=
 =?us-ascii?Q?Yu5AmRPzl0VhLNyn0akaxQf/1CRgcWxzPzj9KfcVzbcPUeO5rgNgH4l4hsjv?=
 =?us-ascii?Q?DTCh+IRwh/Ch5NJUya4XFtwnfMppRREsCEIClHGo2mMakEut80UbPoHnyKgZ?=
 =?us-ascii?Q?MqalMqYjuh0zMae/dLNO9GEuyrME9VpnE+m+i4l6fI/fdDLuOW6S/hGt7Dif?=
 =?us-ascii?Q?c2cO1ZHuyNm6LhPPWrCQVw9BHwTq5ne0xD2F7ud2TtYYhs0WcmeSZ4Dlx+3A?=
 =?us-ascii?Q?4GzEbFkbQLtlt5kLox4q70tBnT7yqWuxFcxV8FTKIasEAs+pvmkYyCfQhg3T?=
 =?us-ascii?Q?EwImYwUEqa6AoqdGwY+gWL46aMVDCIjFUCxE/E2tdv6ydx3aJlMpu8TKP+Ws?=
 =?us-ascii?Q?GCYEW8u8hPyeZSoxbDC54E2Ky69hLc5fe49roGU9ezZSToDNN9ZPjVlFOXV5?=
 =?us-ascii?Q?GQ2fVvi4gv2fQMsavmGKIeRLtSHEULnK6CXH3Q804v++vjBRrq7toLdw3Bji?=
 =?us-ascii?Q?/9jmadDmASBGQGZx9TtYUD3mqOPBSb2qwom9hCX4GYENmV/1CCDazx/HOTnp?=
 =?us-ascii?Q?WZpBM4+H99BZtsr1RkphA0ZGmSrR5i6Z3jsdtwQDm97yAFWYdqwCIdoYV3+I?=
 =?us-ascii?Q?/YDkF1YcLyDaVMDR/ZTaMQdvoji4JVNL+3ulj3Svmo5Dfy+3iz1A600hH1F7?=
 =?us-ascii?Q?ljvDd7UzW+BPsn0yzLOv82yW/3e1z56+bjAWzIGdgltjEK2/wMLyDDipenI3?=
 =?us-ascii?Q?hC7DjNAbFuIcpqisYYKgZAhhK/x7ejJu4O4InJr+Lc1Gfyuw+hqfV8fkV5Um?=
 =?us-ascii?Q?UNczofE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <194A943B25F4DF4590B11A185CD54BA5@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade87916-df26-479d-3c8d-08d96c9a294a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 16:12:42.2473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4Z1ULrBxJFwn5ZHrJ+czaeU6Voqg9X02W5XqxOmaFxqokooQ+KY40PUIQN8k4JJdQ2Y814otbiJvrTMnznz7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5062
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: GAXMt0YErCmIaSCDGc8BJJhpHynqaCou
X-Proofpoint-ORIG-GUID: GAXMt0YErCmIaSCDGc8BJJhpHynqaCou
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_07:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108310087
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 31, 2021, at 8:24 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Mon, Aug 30, 2021 at 02:41:04PM -0700, Song Liu wrote:
> 
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index ac6fd2dabf6a2..d28d0e12c112c 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2155,9 +2155,9 @@ static void __intel_pmu_disable_all(void)
>> 
>> static void intel_pmu_disable_all(void)
>> {
>> +	intel_pmu_lbr_disable_all();
>> 	__intel_pmu_disable_all();
>> 	intel_pmu_pebs_disable_all();
>> -	intel_pmu_lbr_disable_all();
>> }
> 
> Hurmph... I'm not sure about that, I'd rather you sprinkle a few
> __always_inline to ensure no actual function is called while you disable
> things in the correct order.
> 
> You now still have a hole vs PMI.

Hmm... I will move this back and try some inlining. It may require moving
some functions from ds.c/lbr.c to arch/x86/events/perf_event.h. But I guess
that is OK, as there are similar functions in the header. 

Thanks,
Song


