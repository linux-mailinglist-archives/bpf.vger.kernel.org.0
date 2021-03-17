Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8AA33E975
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 06:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCQF6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 01:58:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63498 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhCQF6Y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Mar 2021 01:58:24 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12H5tkqn011636;
        Tue, 16 Mar 2021 22:58:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8R1D+91RQQ0ma3LJ87hYhs+ByREMzbLyxiskbROKieg=;
 b=opsgsjlw66jxu8/l/JilqhiN4QvPniA6XCs2RQ7o5qHXZyTaLLvjyTnTiIM0aVJIeORB
 nhm4WQ3KYjUy0DDEgXev/niw+wdaVc3w8zgaswRxiNLaXMakbzeR3/KjKka4Z1ZmFQLX
 r45NW1jgxYPhVovDl1A9E2dfeidjRJCMaSA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 379dx7rawt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Mar 2021 22:58:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 22:58:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsBBJHkcEkFzoDX6GChyq7n2Eps/CJsPKADBGhpHcCEoHGcvMv0lL8hyWLnCsxruPtpZPQOQLoYJrhlihjoBRLUmb5MWEwS8U/sbysUZQLSYQQtu8WlJavD87DMLmRWM8BlCuGBuLJd8tqIHaLxgoQCf1ppRpFyTZJpAzTIWJz9cLM1ounlEoCTt1tiMhE9E4O9gncHdV0IxOPFmTqluNRnBKaAcKjE2Junu0e+Rr7U7wwbyH8z0f86PDX2i5UkUELqsgTtg7EKeit0PJnaGuH+hmyGCK73XAT3yqSPz7Z8SqHOvClBYD9sFKHR015BhtqsBDzDmYxjow8RAzTp3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R1D+91RQQ0ma3LJ87hYhs+ByREMzbLyxiskbROKieg=;
 b=Pjf1MvMV/1bNQTS706wctffoTOGbcm0VXN5VSt5wixdUqZMeoGOwv13M6Sa2T/oVbWTmlawPIipfF0/B7oX8u7afY6vm+Ty4gLxPxiWHe6MOQaT+NFr9BUaOVil4CSw5XnLtsKQeA1BO7pBnd5cuCUm2chxlNp1ENjen9vVP4sH1YOSZWkTpamL5rHM8NSneULrwk4NnLuqoWRXr1Eflyj6uU3BKm3aGGfh5349DmDAQPGUGi0b8kzSuoJVlb6X44wyEsBGIX6s4ObzNmucaXoaWu+dSijShn9/bvDILlB6uSR2m6FRox3Rd7J13mW2MIXMJpKIuEcbKdcHgf5qhug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3790.namprd15.prod.outlook.com (2603:10b6:806:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 05:58:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 05:58:07 +0000
Subject: Re: [PATCH bpf-next v2] bpf: net: emit anonymous enum with
 BPF_TCP_CLOSE value explicitly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210317042906.1011232-1-yhs@fb.com>
 <CAADnVQLY1ftbZxFqAMSN4amWoYZN0ka3DyVLXAWhgsTO7V9V+Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <58a10cec-180b-d8d5-e1d3-de9b695a8878@fb.com>
Date:   Tue, 16 Mar 2021 22:58:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <CAADnVQLY1ftbZxFqAMSN4amWoYZN0ka3DyVLXAWhgsTO7V9V+Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b44e]
X-ClientProxiedBy: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::19fd] (2620:10d:c090:400::5:b44e) by BYAPR08CA0055.namprd08.prod.outlook.com (2603:10b6:a03:117::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 05:58:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20e5ea4a-a253-419d-2988-08d8e909a261
X-MS-TrafficTypeDiagnostic: SA0PR15MB3790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB379054C3ABAAC56ED3C632F2D36A9@SA0PR15MB3790.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICJLUUDVBrJOgAcqlaaRDmHpUJf10KsEyc+NyiV+NjBHZfzp1NCz4dFHb6NtquYDR65PWZgFsLOCeLVcIUQNI9S8Qp5C31G72IHTUYnuvxA9pfAJi6VKS9VKGKqK+LV8I3PDoAIDYZHcV+m6ZTSSV/CAQXIi3/qliK7Ik8rHAJP6tnPuXqv6OVru8S1OtQL3CnFNLvbced1fEPjR4GMiy1Ofr0hjJW0gkF9aw2sSoyQhzwS50+ts61xb32zOKa7NAKUJH/yZQQlVxs2YBROnCkgO88zicu64+CGKvfd0lVQYRpPVIjD5Hb+4c9vlgyjiUAZ9B/bMWnNZgOddsRB8LrNWPSJemhgbt3P3iI4EVvh83C3HHagiAdPbj8M+1NjQne4L7O30onrKvqWEWlbPZ5cTYRmFEpAjm/TNPKUgUuxoVi/TbC/wDhEfgvhejov5ArPQMRI4308IGT9BEVQw9whI4EiCN7VfGQ9dQEQA1s+Vnjhsf2OzG2imnJq4AMBfac1/GBaxaUk54p5aauHigRuM8FZ5reiMz3AB647jk9gxVCnzh3dIomPDLNi4byFsREAZwsG53fZ1xhgABWcNYO7HmIrs+N8PsY6KsagTjLVf611EMcsE8HvqQSkRh+yeoNAbyvipRnwm6niGLZOScQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39860400002)(376002)(366004)(4326008)(6916009)(8936002)(31686004)(2616005)(36756003)(6486002)(5660300002)(83380400001)(31696002)(86362001)(53546011)(66556008)(66476007)(478600001)(66946007)(8676002)(186003)(16526019)(2906002)(52116002)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RWRjR00yajF6TVI4eDluVmtOWTFlc1BvMVFISUp3WmptRldGakJpRGFqeVdC?=
 =?utf-8?B?eWRvQnhieVN6ek1HOHowSlppcWkycTRXWVVacU9WaG1KNW5XVnBURmtIbU1a?=
 =?utf-8?B?NzQ4S3h1L2FPdlFpZkNaRDFDMUF6VlVuMUU2d1JDRTQwTTFXQ01QK29XUUtO?=
 =?utf-8?B?Y2NhY2dlWksxaVlWODJjUSt2dUhmTUE4UFdoM3JRaTJMNzhJY3pLY0lEVktu?=
 =?utf-8?B?eXJwa2daYnRQNlQ5aUNqNG5nS1Z5T2NVMGVCSlpUVndGM3JrZDVrSmlpRVpr?=
 =?utf-8?B?ODZTSkw5aGx6bCtCL0ZzTXRvVGxrb0xGSk9QU3JyYm9KdmdPQ29tZ1BSdkFk?=
 =?utf-8?B?MHk5eHVkL08xS0k5SkRxRlllejBUTzBMUURhR3p5cDJ5YXJQVWNXSk9XdFdM?=
 =?utf-8?B?YWJaNlM1b2s3Rnl1MDVxZmZEbisrNkhYTk9BdDRhdkVJMzdFeStEb0JCUGFP?=
 =?utf-8?B?Yk5paWlEd1ZMY3NEMFZmeXdGVjVSdi9ZTUpHL2FlT1J5aXhNSDNEUkxENWha?=
 =?utf-8?B?OXgwbVhEUWdzUGRsd1F3cGM5a3ZlcFE1RDAvMS9nTnp4Q0RPcXhVSHBrK2FB?=
 =?utf-8?B?WVJ4eXZ2aTRwWEVFd3lNQzEvZ1B4UHVHd256V1h2bGs2aDRLVXQrUWd6QWJD?=
 =?utf-8?B?UGxZTG14TUJ6WVVWSXFudFRDT2RxQ1BMNlFwdTFOeTRNR0RLZ084VFdjMnpZ?=
 =?utf-8?B?M2NZSUd6bGUwS2pLSXZVQnE5WnNWb2ZSUEVvejJtcmt2bWZWckY0Q3RYQ2hK?=
 =?utf-8?B?VU4xcVQ4anJkcHU3RE1ORG1Lekpwc0IrTjFiaExCdFBpZDU3b2lYZ1dmVzM4?=
 =?utf-8?B?U21nU0RzOTRQclZSTmlzYlNNUWgydUdpd3R1ZllML0tmSjMrejR4NTBKdmFV?=
 =?utf-8?B?WjAzWHhoV3dGSmR3Y2NVTHhhNUY1Z1VJNC80Vit6cktDV1VFVFZvazlubU9R?=
 =?utf-8?B?NlY3K3UzUlpMeXd6OEJuNXpkNW90Vk5CbFZML0w1NUlrd3Y4UjRPZkgrd2xY?=
 =?utf-8?B?MnRCVytvMHUzMFppRHViK2pBNm5tb2VLUVU0R3M4TjRpclV6NE9VckZUUFZi?=
 =?utf-8?B?MHBHRlNhd0xHeE9BaXAyTnQ5RFZuZ0ZXZ24xaGZzN0o0SUo0VlFZdXJ2MVF1?=
 =?utf-8?B?R0ZHeVM4SnRTYlBya0JLaUZRSk14QlJ4S2p2N2tUMTdOS2lPNGFCSXVCdmEr?=
 =?utf-8?B?NDdRYS9ESm83dU5scC8ram5mN1c3MFIxMytmOEtJNHRjV0IyclZBWEdCdFhI?=
 =?utf-8?B?L2hIVGExdjBvOXl4QWxrdUpEcVdjSGVOME5tK1F3c3FVd3JZcXVRbW9SQmcy?=
 =?utf-8?B?QS9yUkRHL0V2YldBRnVEcTVxMnJ4ejNrYk9WT2hpZkpyRVZwc2RzaHo3S0N5?=
 =?utf-8?B?UkhYS2NEd2dBdG10OHQvSzc2RWIrYUxKdFpIa0JUVk1QYTdsZDlsS1VId3pa?=
 =?utf-8?B?QmJJWmVmNHc0OUJ2bVlhcC9oY0ZmbXdWNG05RUdaYjF1QWloUG1aWjd4Sm1I?=
 =?utf-8?B?ZnQ0aHRsTVhBeUU3a1BQNkNZaVkvemZSTVZTNFVRSjRsS211ckVjb250VGM1?=
 =?utf-8?B?d0hZYzhodFBzRUcvTTU1aEJra0NjMUZ6UVJ4MEE4ckFrNjVxcTFkWjc0MzlB?=
 =?utf-8?B?UWhVRlNBQzBWaSswUDcwNWdpc2lxVWVqalNwcHlBZEJSK3RiZFNNcCswOVc4?=
 =?utf-8?B?ZDJ6elY3eDA2b1lVYUFBaEF4VGVBL1M0TUxKc1dyUExGWUI1aWpORlpCZ2Zv?=
 =?utf-8?B?N1RyV0NyUUFmbUw0bVFJR2h4cnJHQnBGMFh5cmdQcUs4aklqbjRhVTJ5RXhT?=
 =?utf-8?B?YzllcEl5Y1hoSWtmb2g3dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e5ea4a-a253-419d-2988-08d8e909a261
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 05:58:07.0673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Um5HLwJocBmgUBhK2s2A1GGZDwSPNjZjCDW2YvZ00xemDsf2QtiUNBQ2NLO5O4nV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3790
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_01:2021-03-17,2021-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103170047
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/16/21 10:44 PM, Alexei Starovoitov wrote:
> On Tue, Mar 16, 2021 at 9:29 PM Yonghong Song <yhs@fb.com> wrote:
>> +       BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
>> +
>> +       return 0;
>> +}
>> +late_initcall(bpf_emit_btf_type);
> 
> I think if we burn a dummy function on this it would be a wrong
> pattern to follow.

Maybe we can pick another initcall to piggyback?

> This is just a nop C statement.
> Typically we add BUILD_BUG_ON near the places that rely on that constraint.
> There is such a function already. It's tcp_set_state() as you pointed out.
> It's not using BTF of course, but I would move above BTF_TYPE_EMIT_ENUM there.
> I'm not sure why you're calling it "pollute net/ipv4/tcp.c".

This is the minor reason. I first coded in that place and feel awkward
where we have macro referenced above and we still emit a BTF_TYPE_EMIT
below although with some comments.

The major reason is I think we may have some uapi type/enum's (e.g., in 
uapi/linux/bpf.h) which will be used in bpf program but not in kernel
itself. So we cannot generate types in vmlinux btf because of this. So I
used this case to find a place to generate these btf types.
BPF_TCP_CLOSE is actually such an example, it happens we have a 
BUILD_BUG_ON in kernel to access it.
Maybe I am too forward looking?

> Consider that BTF_TYPE_EMIT macro is serving similar purpose
> and it's scattered around net/core/filter.c


