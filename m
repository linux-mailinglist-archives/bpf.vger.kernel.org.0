Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1752B139B
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 02:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgKMBBK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 20:01:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7324 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgKMBBK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 20:01:10 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AD0tTBu006989;
        Thu, 12 Nov 2020 17:01:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2d725ACVCgvyWcoqLG/Jcav9R6tMvylilSzVR3va+bs=;
 b=rRhYh1tD61zwqDEOo0RY5C3HPBuwvNBm0Jj6y2JeB2fa1ApnaW4hmsZdZXYP1oBCwjSW
 yAZUq1iUyOc6VGsxQwEgtph39zsdwaa7yV1b1PXD1XO/q0ccU/O51rQVf/BA5DEZhFQ6
 JLl27t9qUDM3IrS6uVETmQF3PLVEC6q0Hfw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34s7crkb55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 17:01:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 17:01:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoGFYfFdKdHwlv6gQ3qFH5GqiLBiWBVUlqJLReUHMdHixuE0jSgLkpvN8aaHq2rPk2wNv2bNX8gCAjaoDTfv0u0cZeHDDyBFcYTnLlCPpHz6bqvEO1LxOK7FlzFQF7c+1Ag2p1X5xtQVPYQ3cETMVID7yhdV+MkvRHR25cPhBPDH6hXWrQCRvhn+VVe0mKrLXvKo5mEIkhTOex+CUD0oUVw+iCa5BB5sOOjytq/aW9zyl5lay7Qe77SJKNezgwRCbFEc6uZL8LTo3xYGohDtc7cHBw84TzyXpu/iTt7yHwzESqg6AWibfWP0ZdaYxnzzuPMpVdbJbC3Bf9e/JX3xLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d725ACVCgvyWcoqLG/Jcav9R6tMvylilSzVR3va+bs=;
 b=mcqFBkfZE30BqR9U51AXvZVNIs7w1m1eFVy0aB6l8P/07+0uPCLrfgH+GDGmKj9HhM+v/+DHFiQiVcwWxY+B0r97Of7Vj9CWC0UpTi8xKhsQVb8DZSea4hTlwqeUlDA/28OzK2OavVzbkTEM48sVTTFb0+CRTecSMD/3xOO56iA/c9MC4VYKvUAanFmm0hYTmRXwsEyeWVZ3Mzf2Wl/3jXdbgilv/DIaLCrou1FNSMNELiqq3GHWzt3mnp6Tak6/59fWUWUQJxDuPotCoVVZKJSmpzi6svlNhmoCZSmBOG9SoR8gbsjSYx5WeMeG4mjk0vUrLexeOGtAvnP+UDJfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d725ACVCgvyWcoqLG/Jcav9R6tMvylilSzVR3va+bs=;
 b=STub/5POAHiXXtS4dpcE26ipH9dWOQTWVvsWUgkdpWORiBXzPiFchvmeHinabFI+QDWugLpEd3ymelH/eeheqETZ0eyDex4UxZF1GAS8WcY/0mSaF+ks7Iiai0rtSZiQUf+S+45XCGxuFotA2iegQ+jY+RqXgKc152uT6PZDv1Q=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3045.namprd15.prod.outlook.com (2603:10b6:a03:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Fri, 13 Nov
 2020 01:01:02 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 01:01:02 +0000
Subject: Re: [RFC/PATCH 3/3] btf_encoder: Func generation fix
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>
References: <20201112150506.705430-1-jolsa@kernel.org>
 <20201112150506.705430-4-jolsa@kernel.org>
 <CAEf4BzbhojeSdASwt4y4XEtgAF1caYx=-AuwzWJZv7qKgzkroA@mail.gmail.com>
 <20201112211413.GA733055@krava>
 <CAEf4BzbePw8gksT0MH=hwp4Pv1EV1-MOeiwfoFVR64XWFccTHw@mail.gmail.com>
 <CAADnVQKUYFE0vE3XZB0FPNMxw_+BNpOLJ37QJ+CxLbssDPHFdw@mail.gmail.com>
 <CAEf4BzZhRPVf=qVU7vVrtVaJzvBmsWL3hHYySKczMrrO-1Xotw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7834ab75-6e08-9f95-4885-d65298011ad8@fb.com>
Date:   Thu, 12 Nov 2020 17:00:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
In-Reply-To: <CAEf4BzZhRPVf=qVU7vVrtVaJzvBmsWL3hHYySKczMrrO-1Xotw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:3ef]
X-ClientProxiedBy: CO2PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:104:7::13) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::11f6] (2620:10d:c090:400::5:3ef) by CO2PR04CA0111.namprd04.prod.outlook.com (2603:10b6:104:7::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Fri, 13 Nov 2020 01:01:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ac1306-769c-4fc5-8f4a-08d8876f975c
X-MS-TrafficTypeDiagnostic: BYAPR15MB3045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3045E4D575045270D638CE36D3E60@BYAPR15MB3045.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQK5+KKzmSY6IlOxMIBGA7JA2UWZCekCU6WEq/7ngodxoVpIo/Qwsh0BEOEhLcXhHdr74cuEbRsyCg/B5lDzkiTYorthxnXeSs71AHefxQYHs49IRLU1JovKYyZKF9oygDfBw9wSAs0oEd2TL+8OgYiKgnLx4c1vThgm7ZWyG+Dz+JY8sJ2oTn8ScHeTumJTx361pRE+iD5LzqRhEbVjtNrV1oMXedZT6c1ggp8+iJ+NbhfA76AECitS3cvruu40M4ms+h8iQqQhZKTrocTXE3/yC3bhz5u8DtPmyjht4xlS048uafRrSCKQoMCJjbfm0rRKKs2IM8Rt3aq+yOvKIH4A3clG0ShaESvAunuAlIkO+LX2ZXc5XKuGjtjegrAm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(136003)(366004)(31696002)(86362001)(66556008)(66476007)(2616005)(53546011)(186003)(4326008)(66946007)(6486002)(31686004)(8936002)(36756003)(52116002)(2906002)(110136005)(478600001)(54906003)(16526019)(8676002)(316002)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8Z8uspGkgFnuhFFzorckPVdcbn+guBGvWHVlLSKiVjFwwMmSqTVeK5sLd/CC5J49ZESpKC8XXLzoJhFQbZZL60uda6DRCSmsa8yDvS4ZwYi1qetkyiikeIDSRvXvY1os5+mBVB4cvKnBmXuJZgxsKF3UQWc/hqgglOV4/1AR2T0l6tM6WYHiCXsCDCAcTS+E21GfEWKv0O0YqUE0w1rgcOKeW4uLY+Kp1SNOgd5nBhna4gjok4PU/xPNNmp6C75vMZO5+VXX51fUW/jm8n2uMiadbWNS8jrPcEuC1AI/Pr1CRUQuWHyetJMJh424x3HezSzdbdIHwH0J7Ms3l4PY0iQ7SezhQUP18y4sMx6EvkNJb0hfJZsNrSdGMvAOJJQrZGP3OKvHTIYVMwhKIZFZxip1NgYumXqJmE2SJOg5qxQlPRC2uQ12659v2t8RpkL1lQipzqmnDos31Qg48n2zNFg8EkYfQfTVGjubHVYq5T54UITgntM06i+2P9mHAQrqg3mqDUZZYAPmnMmWW8qOsbe+OW9xGBmUwUgNSk4C1pdCoWq34TIZ4kTQs7A9AcYF5z95G+MglDEjm22TTItatO1vX3HfqNv5Je1y0WHCJow3381C5oQaQ5ZV2Lr1hJPjRKMK+c8R8UuaI39X3wBBoZjzHaXdI4itJQ4SbU8GQIBKCcXxLgImgyDcoalyXleX4oGvanBZew/Z3r1vDYMJcL7VOkcs9pUK4u6J2eOugZUqM34An+94dfUzBB0+m33wNRk8ScsR28/u2kI41yyKbHAeNeDPjJPHZdbim7dggjVi+wKfUW5uOCeUI81v3+WEpySrV/JU982Jthv/ts93w3YRc5zVMohhfKBvm1DunwEyQOAWtbs++p8EMshrmaMLm+BfNqa06RbhClT+Z2NRqB83gxHLr0K1AisH2yEWEX0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ac1306-769c-4fc5-8f4a-08d8876f975c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 01:01:02.5249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+jDDuI7A7etRHEISRylbA3JoE9kVSq8qTv2JHZFuAb8lwTKLAgGIzTsqXrAh9jR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3045
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_16:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/12/20 4:30 PM, Andrii Nakryiko wrote:
> On Thu, Nov 12, 2020 at 4:19 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Thu, Nov 12, 2020 at 4:08 PM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>>
>>> So I looked at your vmlinux image. I think we should just keep
>>> everything mostly as it it right now (without changes in this patch),
>>> but add just two simple checks:
>>>
>>> 1. Skip if fn->declaration (ignore correctly marked func declarations)
>>> 2. Skip if DW_AT_inline: 1 (ignore inlined functions).
>>>
>>> I'd keep the named arguments check as is, I think it's helpful. 1)
>>> will skip stuff that's explicitly marked as declaration. 2) inline
>>> check will partially mitigate dropping of fn->external check (and we
>>> can't really attach to inlined functions).
>>
>> I thought DW_AT_inline is an indication that the function was marked "inline"
>> in C code. That doesn't mean that the function was actually inlined.
>> So I don't think pahole should check that bit.
> 
> According to DWARF spec, there are 4 possible values:
> 
> DW_INL_not_inlined = 0            Not declared inline nor inlined by
> the compiler
> DW_INL_inlined = 1                Not declared inline but inlined by
> the compiler
> DW_INL_declared_not_inlined = 2   Declared inline but not inlined by
> the compiler
> DW_INL_declared_inlined = 3       Declared inline and inlined by the compiler
> 
> So DW_INL_inlined is supposed to be added to functions that are not
> marked inline, but were nevertheless inlined. I saw this for one of
> vfs_getattr entries in DWARF, which clearly is not marked inline.

I looked at llvm source code, llvm only tries to assign DW_INL_inlined
and also only at certain conditions. Not sure about gcc. Probably 
similar. So this field is not reliable, esp. without it does not mean it 
is not inlined.

> 
> But also that DWARF entry had proper args with names, so it would work
> fine as well. I don't know, with DWARF it's always some guessing game.
> Let's leave DW_AT_inline alone for now.
> 
> Important part is skipping declarations (when they are marked as
> such), though I'm not claiming it will solve the problem completely...
> :)
> 
