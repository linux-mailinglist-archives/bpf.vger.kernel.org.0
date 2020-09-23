Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B460E275F8C
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIWSRQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 14:17:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44038 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbgIWSRQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Sep 2020 14:17:16 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08NIAubq023870;
        Wed, 23 Sep 2020 11:17:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Umxf5TulBUwA9mY2by2uKxRLeA8sG0eEuT4YtYKBBzk=;
 b=do8ZmBd8HUmwapjaYmm9PhktC4Vtfbwg87CGkDXunUdO2hRKJF51lmO/1V28LYbyNnyz
 jtgBAYKQUJ9x46cjNj/ik/A6RaH3xBvKjkl44Q7I9209djM8IeqZUSSGluczZpgoAhMD
 a2ILEl0gS+ISCJqsXnEDOxaGYbma+qNhHSg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 33qsp4w6h2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 23 Sep 2020 11:17:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 23 Sep 2020 11:16:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRQNzQh1FphnO8TegaEkqhBSQLmVH67m2kQIUE7oxIUhKk3ACq/Ub05gh2moJiySvW8R/M+fR7dN/m11vDjQp7aHq+83jBqaoaLr0PFCMGGw0hG8lKi11bpyIq0jEL2TjZSW6snM6tB4LNDgtVUwE5itwiVZxj/w7IeH7irXU6onZe9/sTT5fldBi9lP2qzusgDvwlsIINRyN2p4JO+gVYGjz6rsj4MnS7hj68yn084k20BfHBpBt3qUCksH8ND+e/5TWUNVfOMvrX0ixWehV4knm7L2McfPQsVJIRNHfmtM2MtDAQxGUsPyoyclQoiAB3JyzV2xOELzxrC/3jTjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umxf5TulBUwA9mY2by2uKxRLeA8sG0eEuT4YtYKBBzk=;
 b=UNEeytahqOO8/S5UfyEAv9CknwTbXRM9vZmxNrnFGS7USLE+Ojs/cxhjRE0CjEtlpZMCBa6w4H/qDxyTa31vaRkzzxN1p11l82M7/6rNo9ILOSsptgknjcF5As10S5hAAUqOq2HXMM4mUiG1aUHvBVwcB1aq4mm4+gmHn8ND4g7j+8/vXcXK98/3DCcZTV/aZBCbhY5dbJirWp8rFaVdc+d3UQMOhaWR8M5YaLIWcTEYz66EtE3bxAvFBC+O7WymnVo92eIm12e4IG6+2Q1e4/NSesE13k9IqnD8B4XuhxV6ZKIlvI7E9/SjwqeK+7tl0nc499bUG7gaXOiP0MOakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umxf5TulBUwA9mY2by2uKxRLeA8sG0eEuT4YtYKBBzk=;
 b=QhnRyVVb6T/JOO9ssfiA2HaDqvDSqHmZ1YDL6+u98AbuM/NWBQA/i7KHyEU74ohRHcU4GZ38IZXQbjtySoTGnOJy/+QbrpxhPva3LTWwQkFYZfF3oa3ZYQkxNC6u0It7qZM9DzR9OrYgzB8BKh95kCcECqm7D0CGfw+k3qD/G4Y=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2648.namprd15.prod.outlook.com (2603:10b6:a03:150::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 23 Sep
 2020 18:16:57 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 18:16:57 +0000
Subject: Re: Help testing llvm patch to generate verifier friendly code
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
References: <80d19887-5b77-a442-5207-a2685cdd1f83@fb.com>
 <CACAyw9-zry08xTRGUHCh8VSp0eF9cFQjGiur0jDnA-YMaZ=Niw@mail.gmail.com>
 <CAEf4BzYteTG41ST2dJ+kVdroB8ACQbYf1avBRjZHt+Qzt=o8Zw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3ef2ad81-15af-0668-c934-31a49f9215e7@fb.com>
Date:   Wed, 23 Sep 2020 11:16:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <CAEf4BzYteTG41ST2dJ+kVdroB8ACQbYf1avBRjZHt+Qzt=o8Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:1c16]
X-ClientProxiedBy: CO1PR15CA0090.namprd15.prod.outlook.com
 (2603:10b6:101:20::34) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::11fc] (2620:10d:c090:400::5:1c16) by CO1PR15CA0090.namprd15.prod.outlook.com (2603:10b6:101:20::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Wed, 23 Sep 2020 18:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6a4a8a5-4bd7-44c9-a952-08d85fecdb8b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2648:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2648504E4F24C18BA5C25CB5D3380@BYAPR15MB2648.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AR3CeF3lZ0gRrlICp6NVlEJ7wu6KY/NoOCzxFGQQEbK/1eVG03aw05ynpvwG/YXTZGKj+PXG2yp960AErpq8K6TX1yk20auMAgq/Fx3yrlwaZCWGomJ5jd0W0xNs5o/cjscQY3vCvGcx48tIjoealzUw7RtSbwRW/qwFMudxQmat++azZkdBBHgJpHatkmSvzf5v33fliEzzrBtUsknGzfeFt9cpPeKpSwRW/hdsrEpRdQ2rc86hywPRYk9EPrPI/WgYuIzVfZw3p4X9klX+NSbUcnM79nKI6XSzbEegY8NiOfbwx3H1lmjQZgP+QNm3e2ILEbjyWJjDc5S6OyFL1Mal/NtY0aACDoipkYHT54K+JxR4BD3iM3GTTK8A+7hOxRi8r5NqjhPUQMRc4Hjcsco7ohuByyRCJLAiuO1rnJhMFXHM0iOn85et+7iV6nvqWNpSkitn35QUwHrlWcKD4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(376002)(136003)(396003)(16526019)(86362001)(8676002)(5660300002)(83380400001)(2906002)(66476007)(8936002)(66946007)(31696002)(66556008)(36756003)(53546011)(966005)(31686004)(6486002)(4326008)(52116002)(54906003)(316002)(2616005)(110136005)(186003)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: A7xGSOdoHh0eY3p87hrgdg1ExaaiRcTCeOCP6z74n9rom5WujKN/SPw4x4IQk0sRFglHwwboS10WOw5UrKC6ogCbpUpccI4+Aoc4/ChpMggr+S0vS8gSbla4Mfdv8sgKhP4f6ELn40Z88XuVXLrRtuuG3BgZskfRXSuTpb/yuKDbiUos4eMQKPcqOsfQ444QLrmiyjlc8PTv0DB7i1ZFt2f5JBOebdbDevLZRZjW5oZ0DL9g+MyaO0h7mDkhWWRQ8kya57R7mjN2bCsGG99CHNeZSBy17lOyBiW3i0xjLFZWvqri+M+ZLd5TRnYDGns8c7OFUmWFpYtQ/OnRT99EEZGKQmsIzMgE9p+REvYPadE/AqyVEvF3PAu26ynQzozb9Njl+3QR6kF4MJORpM6WDyB/+CI4x1EtEp3HBQgxnCCzVwG68HOqXxnC2a5pPt/0VqVWU01uhcvgW9M5YQLfxhFpY3sHH3IJpnpx8k9h249LTM389TprO39pvebzBjEWED8nxtnRd7rWgq97vpi4W1tjMbtDz6rN8mwg7O5A0wNst2KCLb51ZwRnityuNrD9cnWIipPSdngdw9mlXp4COo8AtQEIQ31kReltoc0h7MHV39kHulzWylSBgsAdnLUjsqTShiCpyf38OxUUHW9za67AWbjXdjfcdDqJbVXxY30=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a4a8a5-4bd7-44c9-a952-08d85fecdb8b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 18:16:57.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zt6Tzfrq3dRpW6kwhgNN1CkTzTy7vFz/GtHdIragIytVtc2aTZu80QnnaD4fa4YU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2648
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_13:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009230138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/23/20 9:21 AM, Andrii Nakryiko wrote:
> On Wed, Sep 23, 2020 at 9:15 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>>
>> On Wed, 23 Sep 2020 at 08:17, Yonghong Song <yhs@fb.com> wrote:
>>>
>>> Hi,
>>>
>>> I have spent some time to add additional logic in llvm BPF backend
>>> in order to generate verifier friendly code.
>>>
>>> The first patch is:
>>>     https://urldefense.proofpoint.com/v2/url?u=https-3A__reviews.llvm.org_D87153&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=-_pOOUYXONnvN0eDqgPfyjzi3pU0ZJV-eT7LViel2u0&s=1lUhNqSXg_nXYENMizJLX-GtAxNqKETBdD50CC4wB-U&e=
>>> which moves CORE relocation builtin handling from in late IR
>>> optimization (after inlining and major optimizations)
>>> to in early IR optimization (before inlining and any optimizations).
>>> The reason is to prevent harmful CSEs.
>>>
>>> But this change may change how compiler do optimizations.
>>> The patch can pass bpf selftests in latest bpf-next.
>>> Andrii helped it can also pass bcc/libbpf-tools.
>>>
>>> If your code uses COREs, esp. having a lot of subroutines
>>> and/or loops, it would be good to give a try with new patch
>>> to see whether there are any issues or not. In my case,
>>> for one of our internal applications with lots of subroutines
>>> and loops, inlining all subroutines and unrolling all loops
>>> will cause register spills which cannot be handled by
>>> the verifier, while existing llvm won't have issue.
>>
>> Hi Yonghong,
>>
>> We currently don't use CORE (outside of bcc, etc.), so there isn't
>> much I can test I guess? Please let me know if there is something I
>> can do for your follow up patches.
>>
> 
> It would still be good if you could test all three Clang/LLVM patches
> Yonghong referenced. The latter two are not CO-RE-specific. Thanks!

Right, the first patch (I described here) in 3-patch series
     Patch 1: https://reviews.llvm.org/D87153
is related to CORE and will be a noop for program without CORE.

The second and the third patches:
     Patch 2: https://reviews.llvm.org/D85570
     Patch 3: https://reviews.llvm.org/D87428
is not related to CORE and intends to solve some verifier
failures related to value range. Please see commit message for
the above two patches.

Agree that it would be still be good to test all of them, esp,
if you have asm/source workaround, it will be curious to see how many
those can be removed.

Thanks!

> 
> And pedantic nit: BCC doesn't use CO-RE, it just does runtime
> compilation using local kernel headers with exact memory layout of
> kernel structs.
> 
>> Best
>> Lorenz
>>
>> --
>> Lorenz Bauer  |  Systems Engineer
>> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>>
>> https://urldefense.proofpoint.com/v2/url?u=http-3A__www.cloudflare.com&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=-_pOOUYXONnvN0eDqgPfyjzi3pU0ZJV-eT7LViel2u0&s=5gNN1mRte8LrjgHn6sz7v6goGzL2lWt4-EaghCAagq0&e=
