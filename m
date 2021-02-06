Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620CF311FE0
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 21:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBFUOP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 15:14:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55838 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhBFUOH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 6 Feb 2021 15:14:07 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 116KAJDD014606;
        Sat, 6 Feb 2021 12:13:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mXHZ0opeSphuojsrrfZ4H38CIwgF229rXn7vVx+lBdk=;
 b=cYUiYUibchBLUsPnzL8dvQYLAQDxFG6oWv//3Vcos+AoOCUqsLh7XpSxx9nqSsCTDZfJ
 Q+6TozPQq+L6ZYxl40x/4fE2/neZhRcbAXjqXjjNEKKfjCe9q1Y3fGeok7Q2ajrfB8Vi
 8an7X1iVn00AnaYW2I1ddLcRti+7p4NlNFE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36hua193mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Feb 2021 12:13:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 6 Feb 2021 12:13:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al1u7tErVabt0uO2nChHDGkXNOyDI4CLK/unFNYpi0td+3enxb5CSf/Hj8GhFiHnhQLpc2WeukS0CBwcynRqn6RKr4BmOGpXfQf93ZXAD8VQsHbox5v8PgTlJ6cCgtXCrV8wi8NPvKrUAN9djcURLUa6psBKpbPC11bQU3VGTvbBLIvQxc50FR2HFOo2Mo3BmcAn/zpgT4tDIE1vKPNO0c1chsjdtQ8azebfNzRSWdaHFYQQtJTA2hp52tGI9l4UpP9KkKmzTjIGyXR3YiwzTglOT0EM/5BTm2HmDgSnbYltypEJI3AXBHKX/Z6awKThOdPAgoXpqu/x8jJBT5+EvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqY7yf8zcubKNL4hwG3Rt6XuvSanl798Qov4rB507Z0=;
 b=YbXSR8QzxGoF/oG9SlDNPUE0skFQnw2BEpIetA+faSbXGwSt0Dp8okR18mKi37ROvMY4Y7WSn6CnfOECVdrnp4tBHW7T3Grs/B3qsIX+PHIfVt+Eue2fhPVyEwsh2/6oDaZCYvHPTtjkoKRa/FdimY+3l9ME4ihQn6q0qMTi4KE2FdUbcIIj3qy8E4qA9HktSxHx8tQGBYMIf2m58KDIADogE5jDv+KXMCExbVY/KrtbZbZKZpF3KHJW3oAcKR01jI4SUGq+Pt1IOz3I1Ml+RIFwqmKn25PmRibfe5fO7+t7CbZfx+kLXRnozGd3UEq84L6YXXUjOCmKFGfuQv5ctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqY7yf8zcubKNL4hwG3Rt6XuvSanl798Qov4rB507Z0=;
 b=V3xcsbANt6Js4v+w0v3sA09046llQ1UwiVTIZzE3P9KFqcuyyrNdes6nrwrI4/LqDSihStx8czc/R0TrYUQOrxHYEstegkAWB3Uhi7Da69Ss/uc7EXLkjNaOt1G3r0w+aF5Ods2AZgv1Qo+7Okd0izoHYYXj0YsY50ZF4/7Xn/w=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4233.namprd15.prod.outlook.com (2603:10b6:a03:2ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Sat, 6 Feb
 2021 20:13:00 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Sat, 6 Feb 2021
 20:13:00 +0000
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     <sedat.dilek@gmail.com>
CC:     Mark Wieelard <mark@klomp.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
References: <20210205192446.GH920417@kernel.org>
 <d59c2a53-976c-c304-f208-67110bdd728a@fb.com>
 <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
 <CA+icZUWFx47jWJsV6tyoS5f18joPLyE8TOeeyVgsk65k9sP2WQ@mail.gmail.com>
 <CA+icZUUj1P_PAj=E8iF=C4m6gYm9zqb+WWbOdoTqemTeGnZbww@mail.gmail.com>
 <CA+icZUWY0zkOb36gxMOuT5-m=vC5_e815gkSEyM45sO+jgcCZg@mail.gmail.com>
 <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com>
 <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com>
 <20210206162419.GC2851@wildebeest.org>
 <3f5a00ef-1c71-d0da-e9fd-c7f707760f5c@fb.com>
 <CA+icZUVfTH=yONintyJ+T8kvTrR4Q0gumJYNUCs6Ybraff5Kpg@mail.gmail.com>
 <64206fbc-656a-5ffd-6e9d-739c8c6f7410@fb.com>
 <CA+icZUUZVYN97wKiR9-LOwhQmxMSxggvm4MS4z9nLCvZOB8FLQ@mail.gmail.com>
 <CA+icZUV=-NmFtF9RQTRnbwBUiaPnroiSwyv-9RxA-3-nrgQ_rQ@mail.gmail.com>
 <89f15151-6843-b260-c8f4-88deefd7d569@fb.com>
 <CA+icZUVHtbOuXWh=9XMqVr6=Lo_YMPLhZa6XRN3pLTt=btRmpg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8b8e31bc-3deb-dcc4-8c51-4bd820855af6@fb.com>
Date:   Sat, 6 Feb 2021 12:12:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CA+icZUVHtbOuXWh=9XMqVr6=Lo_YMPLhZa6XRN3pLTt=btRmpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:e118]
X-ClientProxiedBy: MWHPR10CA0009.namprd10.prod.outlook.com (2603:10b6:301::19)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::103e] (2620:10d:c090:400::5:e118) by MWHPR10CA0009.namprd10.prod.outlook.com (2603:10b6:301::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Sat, 6 Feb 2021 20:12:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac2131a3-6d4d-4dbd-f291-08d8cadb99c8
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4233:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR15MB42332F98C4BE090720001D0CD3B19@SJ0PR15MB4233.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xR9yrCyD+nSwAdG8rb0u3CUmxC7Zf9LtrPhmBGHRXFqoFP5Ed/QOkQfqTqcRNAfdy7uH9zVKmVB783REocQJQQag3+7vpkIYxWjz1nz22F2DqDTEC03PRCiio2tqREEReNUJsa6wIln7dw2zFaQKB2hRORsXflK0e9do/bBsWmP7bs2dLexd+3SHTxRkE3jp4yttKzscnuJUeDM1M3EVa1jlrEJcn53JImxgjqiYgrDCXbRiyUKWX3g+VXwdkkLvivw32csYSIUXS5ihrtxMW8SC/p1+6E0fJpY103KzlhisKTiqvYn09v5e24HxVAvIfxEaFhWWSMxrWE1+UuFTzJf26GpepKirOj0lbqaK0EW8Agl1wH3gqp4Rp8qd5qyOKDVHuZU/eSawIl3Vd+t0DhM5j9KQGe+wdSlup8KIBYqcETVyrDxE1TKQjsUXMFbluadfSUDy9ro9bAOX1M2BDdAzoO5mZxxzlXPEPRk2AC5DPyVxqSw8UT2toYdXT8hB/b9J95MTE1OUp0mEC1B2srUPZi5OYmpEgkx6VFoRZXzZAqpzNP3VKVgE8FEel1mJCC6V4bn9aklQ5FR8H2BIZc5GlAFLS3myAIie615Prt2s6jmG9rsUmjP8L4SvPUyi/xeILWYCHa491Oiv7TX4MlVOd7E30zZlwqbuNOK7Y/VzekFq7LyX6rKCHZTV1XjD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39860400002)(366004)(376002)(6916009)(7416002)(6486002)(36756003)(31686004)(86362001)(8676002)(31696002)(2906002)(66946007)(52116002)(83380400001)(53546011)(186003)(16526019)(966005)(2616005)(4326008)(8936002)(478600001)(6666004)(66556008)(66476007)(54906003)(316002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bm0rek91Nm9VYUhoVDg2SVl4UElERER2bGNTS0duUm5zSEQ1Y3IyQzFLQnJy?=
 =?utf-8?B?NmJ1OVhEQ2VXN1psdTZZVjRhK3h0a0llemFZZy83UlhwM3QrRnN6YXlOOW9m?=
 =?utf-8?B?UDAwaDdGVzBnaHpNUjdldXMrT1RSdGQrckJsaTRwcUphazgzVGQ1aGh3WUVI?=
 =?utf-8?B?bXIvZEphYk1iVjVyQnllcG56WTRiMWRKdktoSGF2THdjNGNXZS9QM2tOWHFG?=
 =?utf-8?B?blUzbHVzSVZuUHgxRDByenFCOG1hN2FyVGtIQ1c4cjFNS1V1NjVMRFhMRXI5?=
 =?utf-8?B?OUNuYmU3K1pDbFpFOTFyWDg4L0pxblhvajFOODJiUjhXYm1GaXVMeVdhQlRI?=
 =?utf-8?B?dy9SeEx1QlhMK2Z3YmpEM0FkL2hvTFNNbDlWTmJKWWtZMEw5blhoSjcvVkNO?=
 =?utf-8?B?VzFaN0RCSU12bXpRZU1NVExHMXdHOG1CRUtaeDFzVFdWbHJ4aTY1Sm05UmRL?=
 =?utf-8?B?RUJ1UTNwMkQ5eVNlUFA1bFhqTkVvMHBmWVNpOUNNNjJzQkNsK0dGRzAwaktE?=
 =?utf-8?B?czdXUlZrbDRvbTNBS1hrM0cvODJWUUR4Tnp0OTR3R21FUHlqTUZzeGhWUzlR?=
 =?utf-8?B?RjFFeVZtYUNRRklEaENxMkJzTVNOODlZYmNDTlQwR256Q1ZFTlFlL0FhOGJs?=
 =?utf-8?B?YzNXNmtQN1QzbVRPWWlJMS83Y0NuZlBKSCtKK2tJak5DTUdleVZXL290YUtS?=
 =?utf-8?B?YnJweC9UUXVIUlVJUW5TdStyQW5uTXhLbXRJdGVpK045ZlRHNENFbmlweVY0?=
 =?utf-8?B?cmxXdm1DRUJtR01oWStOdmJxK0FiS3I3WmVoODl2WGZBNTlnb2U0ZEVoNTlT?=
 =?utf-8?B?K0R5SllaZGZ5K1BOcnd1NEc0d0dUYXZQcGJrYzQycmppam5TcDRlWnZPOFh3?=
 =?utf-8?B?NWVkMWdHd0hBQXdhWU1wVXUyNkcyYmJXR1dlc3Z3cy83cGZQNlJuWGd3K0kw?=
 =?utf-8?B?eEFrd091bnFRM1hQenZUY3ZxUXhDakRRN0NFV2x5Y3RTaE9uY2JoZGtnQkw4?=
 =?utf-8?B?eWZHdnE5QVdPTURTVnZKK0NiTnVmWXppRFdya0VlZDBBZnRIaVNlcXIwNzlS?=
 =?utf-8?B?dW1KZlFiVDFNeFZ0alIrSHBJTE9KU1g0aWNLVTJCeU9OYlFxVHYreHBoZWUz?=
 =?utf-8?B?VmM5dkp2MlRyMG9jSXlZVFZ6cXV0NXpGc1BzdW5jZVlzbVVSb0pVWkpEMnA5?=
 =?utf-8?B?b0FkeFhUWTdmcmFtRWhaUytOVkJOTFRtb2w0Y3dkKzBDQjMxbnU1YXNHa1Fp?=
 =?utf-8?B?Q0kxZzdxd1c0QWVhTkVHT1VCMVlIQkhQL2o4ck81aUFDR0RScFRMa3p0ZmdC?=
 =?utf-8?B?T0kwb1g2L1o4cGsrNm85RmVROGZPdmhmMjgwTGs4b0tsa2Y5T3Y2d2ZsVDRy?=
 =?utf-8?B?N2Z4Vng1NnpJSm1uMEo5K0FCaWNOOUFWZGN5MWRGRDlNdytiemxjSnV2dVZS?=
 =?utf-8?B?RGYxQXpXa2xhamFQeHJpZFBMRHRETndYOUR0WlRyR096bEdyNUpOZjRER01C?=
 =?utf-8?B?amQrc3lZZFJZSEFodGoyWm5LWnM1RnlMRWlXUUE1OExVeVVVS1QyQzdqRlZn?=
 =?utf-8?B?enZidjdrTktXUExVT2RUUEM1bmJSL1BZcU1DVzR3dVZjKy9HcG1nNG1yWllw?=
 =?utf-8?B?Q0s3SkxyQWFlc25SbHpxU2RMM2ovdUV4VjdCcWVQOElKY0dBdW5xbzNRVm9w?=
 =?utf-8?B?UUY3SEwxUU9uZnB3SkI4WmlIeDBOQ0o1MERsQXdLbkhIZFlUdkt4ak5wUTFy?=
 =?utf-8?B?M1JKOFlHbjN1cDZsRDlpR1hJWUpVQmhvZURzZHMwMUtxZmw0SzhEUUsrc0lk?=
 =?utf-8?Q?VtAYeeHvKUXM6JDXOxTnekOQnd1wWow8OKcZQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2131a3-6d4d-4dbd-f291-08d8cadb99c8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2021 20:13:00.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwTMh+V8fH9UISD3wtLjagcn9vi4I71T44GtKZwO2tlELiumlEYjcXorEXt8hf+z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4233
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-06_07:2021-02-05,2021-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102060145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/6/21 11:44 AM, Sedat Dilek wrote:
> On Sat, Feb 6, 2021 at 8:33 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/6/21 11:28 AM, Sedat Dilek wrote:
>>> On Sat, Feb 6, 2021 at 8:22 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>
>>>> On Sat, Feb 6, 2021 at 8:17 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2/6/21 10:10 AM, Sedat Dilek wrote:
>>>>>> On Sat, Feb 6, 2021 at 6:53 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2/6/21 8:24 AM, Mark Wieelard wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On Sat, Feb 06, 2021 at 12:26:44AM -0800, Yonghong Song wrote:
>>>>>>>>> With the above vmlinux, the issue appears to be handling
>>>>>>>>> DW_ATE_signed_1, DW_ATE_unsigned_{1,24,40}.
>>>>>>>>>
>>>>>>>>> The following patch should fix the issue:
>>>>>>>>
>>>>>>>> That doesn't really make sense to me. Why is the compiler emitting a
>>>>>>>> DW_TAG_base_type that needs to be interpreted according to the
>>>>>>>> DW_AT_name attribute?
>>>>>>>>
>>>>>>>> If the issue is that the size of the base type cannot be expressed in
>>>>>>>> bytes then the DWARF spec provides the following option:
>>>>>>>>
>>>>>>>>         If the value of an object of the given type does not fully occupy
>>>>>>>>         the storage described by a byte size attribute, the base type
>>>>>>>>         entry may also have a DW_AT_bit_size and a DW_AT_data_bit_offset
>>>>>>>>         attribute, both of whose values are integer constant values (see
>>>>>>>>         Section 2.19 on page 55). The bit size attribute describes the
>>>>>>>>         actual size in bits used to represent values of the given
>>>>>>>>         type. The data bit offset attribute is the offset in bits from the
>>>>>>>>         beginning of the containing storage to the beginning of the
>>>>>>>>         value. Bits that are part of the offset are padding.  If this
>>>>>>>>         attribute is omitted a default data bit offset of zero is assumed.
>>>>>>>>
>>>>>>>> Would it be possible to use that encoding of those special types?  If
>>>>>>>
>>>>>>> I agree with you. I do not like comparing me as well. Unfortunately,
>>>>>>> there is no enough information in dwarf to find out actual information.
>>>>>>> The following is the dwarf dump with vmlinux (Sedat provided) for
>>>>>>> DW_ATE_unsigned_1.
>>>>>>>
>>>>>>> 0x000e97e9:   DW_TAG_base_type
>>>>>>>                     DW_AT_name      ("DW_ATE_unsigned_1")
>>>>>>>                     DW_AT_encoding  (DW_ATE_unsigned)
>>>>>>>                     DW_AT_byte_size (0x00)
>>>>>>>
>>>>>>> There is no DW_AT_bit_size and DW_AT_bit_offset for base type.
>>>>>>> AFAIK, these two attributes typically appear in struct/union members
>>>>>>> together with DW_AT_byte_size.
>>>>>>>
>>>>>>> Maybe compilers (clang in this case) can emit DW_AT_bit_size = 1
>>>>>>> and DW_AT_bit_offset = 0/7 (depending on big/little endian) and
>>>>>>> this case, we just test and get DW_AT_bit_size and it should work.
>>>>>>>
>>>>>>> But I think BTF does not need this (DW_ATE_unsigned_1) for now.
>>>>>>> I checked dwarf dump and it is mostly used for some arith operation
>>>>>>> encoded in dump (in this case, e.g., shift by 1 bit)
>>>>>>>
>>>>>>> 0x000015cf:   DW_TAG_base_type
>>>>>>>                     DW_AT_name      ("DW_ATE_unsigned_1")
>>>>>>>                     DW_AT_encoding  (DW_ATE_unsigned)
>>>>>>>                     DW_AT_byte_size (0x00)
>>>>>>>
>>>>>>> 0x00010ed9:         DW_TAG_formal_parameter
>>>>>>>                           DW_AT_location    (DW_OP_lit0, DW_OP_not,
>>>>>>> DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1", DW_OP_convert
>>>>>>> (0x000015d4) "DW_ATE_unsigned_8", DW_OP_stack_value)
>>>>>>>                           DW_AT_abstract_origin     (0x00013984 "branch")
>>>>>>>
>>>>>>> Look at clang frontend, only the following types are encoded with
>>>>>>> unsigned dwarf type.
>>>>>>>
>>>>>>>       case BuiltinType::UShort:
>>>>>>>       case BuiltinType::UInt:
>>>>>>>       case BuiltinType::UInt128:
>>>>>>>       case BuiltinType::ULong:
>>>>>>>       case BuiltinType::WChar_U:
>>>>>>>       case BuiltinType::ULongLong:
>>>>>>>         Encoding = llvm::dwarf::DW_ATE_unsigned;
>>>>>>>         break;
>>>>>>>
>>>>>>>
>>>>>>>> not, can we try to come up with some extension that doesn't require
>>>>>>>> consumers to match magic names?
>>>>>>>>
>>>>>>
>>>>>> You want me to upload mlx5_core.ko?
>>>>>
>>>>> I just sent out a patch. You are cc'ed. I also attached in this email.
>>>>> Yes, it would be great if you can upload mlx5_core.ko so I can
>>>>> double check with this DW_ATE_unsigned_160 which is really usual.
>>>>>
>>>>
>>>> Yupp, just built a new pahole :-).
>>>> Re-building linux-kernel...
>>>>
>>>> Will upload mlx5_core.ko - need zstd-ed it before.
>>>>
>>>
>>> Hmm, I guess you want a mlx5_core.ko with your patch applied-to-pahole-1.20 :-)?
>>
>> this should work too. I want to check dwarf data. My patch won't impact
>> dwarf generation.
>>
> 
> Usual Dropbox-Link:
> 
> https://www.dropbox.com/sh/kvyh8ps7na0r1h5/AABfyNfDZ2bESse_bo4h05fFa?dl=0
> 
> See "for-yhs" directory:
> 
> 1. mlx5-module_yhs-v1 ("[PATCH dwarves] btf_encoder: sanitize
> non-regular int base type")
> 2. mlx5-module_yhs-dileks-v4 (with the last diff-v4 I tried successfully)

Thanks, with llvm-dwarfdump, I can see

0x00d65616:   DW_TAG_base_type
                 DW_AT_name      ("DW_ATE_unsigned_160")
                 DW_AT_encoding  (DW_ATE_unsigned)
                 DW_AT_byte_size (0x14)

0x00d88e81:         DW_TAG_variable
                       DW_AT_location    (indexed (0xad) loclist = 
0x0005df42:
                          [0x0000000000088c8e, 0x0000000000088c97): 
DW_OP_breg9 R9+0, DW_OP_convert (0x00d65616) "DW_ATE_unsigned_160", 
DW_OP_convert (0x00d65607) "DW_ATE_unsigned_32", DW_OP_stack_value, 
DW_OP_piece 0x4)
                       DW_AT_abstract_origin     (0x00d88d37 "_v")


0x00d88d37:       DW_TAG_variable
                     DW_AT_name  ("_v")
                     DW_AT_decl_file 
("/home/dileks/src/linux-kernel/git/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c")
                     DW_AT_decl_line     (1198)
                     DW_AT_type  (0x00d68835 "u32")

The source code at line 1198.
1198         DR_STE_SET_MASK_V(eth_l3_ipv4_5_tuple, bit_mask,
1199                           source_port, mask, udp_sport);

This is for struct mlx5dr_match_spec.

struct mlx5dr_match_spec {
         u32 smac_47_16;         /* Source MAC address of incoming packet */
         /* Incoming packet Ethertype - this is the Ethertype
          * following the last VLAN tag of the packet
          */
         u32 ethertype:16;
         u32 smac_15_0:16;
...
         u32 tcp_dport:16;
         /* TCP source port.;tcp and udp sport/dport are mutually 
exclusive */
         u32 tcp_sport:16;
         u32 ttl_hoplimit:8;
         u32 reserved:24;
         /* UDP destination port.;tcp and udp sport/dport are mutually 
exclusive */
         u32 udp_dport:16;
         /* UDP source port.;tcp and udp sport/dport are mutually 
exclusive */
         u32 udp_sport:16;
         /* IPv6 source address of incoming packets
          * For IPv4 address use bits 31:0 (rest of the bits are reserved)
          * This field should be qualified by an appropriate ethertype
          */
         u32 src_ip_127_96;
...
}

which includes a bunch of bit fields and non-bit fields.

I have no idea why clang will generate
    DW_OP_convert (0x00d65616) "DW_ATE_unsigned_160"
and possibly try to capture more semantic information?
But BTF should be able to safely ignore this as described
in my patch.

Thanks.

> 
> - Sedat -
> 
>>>
>>>> - Sedat -
>>>>
>>>>>>
>>>>>> When looking with llvm-dwarf for DW_ATE_unsigned_160:
>>>>>>
>>>>>> 0x00d65616:   DW_TAG_base_type
>>>>>>                   DW_AT_name      ("DW_ATE_unsigned_160")
>>>>>>                   DW_AT_encoding  (DW_ATE_unsigned)
>>>>>>                   DW_AT_byte_size (0x14)
>>>>>>
>>>>>> If you need further information, please let me know.
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>> - Sedat -
>>>>>>
