Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D1A2F6F15
	for <lists+bpf@lfdr.de>; Fri, 15 Jan 2021 00:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbhANXpN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 18:45:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36718 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731034AbhANXpN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Jan 2021 18:45:13 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10ENdAw7002291;
        Thu, 14 Jan 2021 15:44:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AG36Xtz65fGvSYNwA/6nPTEk20jd7myYd9AQXOCPueA=;
 b=jQukexYfhZqWxyvNz65n35IlvcsCHTfzscAu4BQ9VBa8edJ4lcHqRGUh/pweJGeb0bFO
 ZwFSaw1xeTlAlGLr9cfXSxF0gVou7b24zsL2V5gEmnRJmBbxlxUoo8RuF8gDInsitOL0
 Hzn9yyl00DehQplpH0blE1jgN9NAeVDiZTc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 361fp35yeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Jan 2021 15:44:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 15:44:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J09u0Mi3rUxWq12J8qFt7tfleQfKum+UJLQomDzMONC8PpjJyKEWh6tbziWDSSqmkxWlQ2LXYJYIjwA+WdXPR8XWMKNj5p/LKDgs7bKwuqrpirGSlogR5v54wiQBLfXUCO1GB4AaGgdkspt3/2GlS1YeU4rnm2Yeao7D4Y1iY0yAd1eCbXdwFT6jELnjj+hSl1IYvnfixD2ioU02iArzo4WUeKupjpZ9P0ecG848z7JhqzI4chbjcx6jeCU9gV8XB0LiZOxswRVfnNw0CyVLT4FaYrzHthpz4QQQSLmdoQvygTV++s3jtczf36NIm3KY6RvvidROIBybarfy+7F//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG36Xtz65fGvSYNwA/6nPTEk20jd7myYd9AQXOCPueA=;
 b=lln1dEffkCkfmSasuxJlI2oP6WA1hKzmNpS1m2efEbd1R7C0FeABN99vcK8lU48FL+8pbApkhKiAS64dW+GAnCQy1HcgS9x+4NP7nPwYubdbxchSVkci7zxHIHBtXDgdq8m6T8YSYQ61p7y/vRTzqbDsnqJyGMsA6brtNLOswXzK0Vu09ADOqPc/8ZghUh+deNqbpN9z/Jlz2aoEgh+uC+fpFeTHq3tWnbckv826BaM3WZpdHEYZTfv1xicA5VMOaTTEBHko+56TRkFyYpJLQFpOXf3/igMTg4xGvaXjA6AFlQPsPtYNCamFVFM+CajjmJ9DRxCdSAivjHQbm6SIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG36Xtz65fGvSYNwA/6nPTEk20jd7myYd9AQXOCPueA=;
 b=U7BtPiaiXHJ9MtnJFNMhO3rAJu4/dPT49WcfLcgaZXm9+HRi/+OF/bMg0z6wkRLBSCSw8Jf+zGCsUjI6VeqVjF1pcyrfEvtRooZd/1G1STX3Cdq6xa+s5OZy4dqoy7QiiynMaaNEtc7W2z81tticmGf23EKROuUOJYUBCQacYzo=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3510.namprd15.prod.outlook.com (2603:10b6:a03:112::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 14 Jan
 2021 23:44:00 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 23:44:00 +0000
Subject: Re: [PATCH bpf-next 2/3] bpf: Add size arg to build_id_parse function
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210114134044.1418404-1-jolsa@kernel.org>
 <20210114134044.1418404-3-jolsa@kernel.org>
 <19f16729-96d6-cc8e-5bd5-c3f5940365d4@fb.com>
 <20210114200120.GF1416940@krava>
 <d90fd73f-b9a6-c436-f8ae-0833ce3926ef@fb.com>
 <20210114220234.GA1456269@krava>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <5043cef5-eda7-4373-dcb5-546f6192e1a9@fb.com>
Date:   Thu, 14 Jan 2021 15:43:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210114220234.GA1456269@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ab59]
X-ClientProxiedBy: MWHPR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:301:15::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::13f6] (2620:10d:c090:400::5:ab59) by MWHPR2001CA0022.namprd20.prod.outlook.com (2603:10b6:301:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Thu, 14 Jan 2021 23:43:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 279cab2c-fb2c-47af-bbf6-08d8b8e64441
X-MS-TrafficTypeDiagnostic: BYAPR15MB3510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3510132C3712F4FB598BDB20D3A80@BYAPR15MB3510.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uM2qCBBCAiDW2TT+i7QkMPJnZEG+YWJuoEGYbJwfNsZKEmSgCozHIBFq+43Vqbgcu0hQ4CLZ21ESrwuXFB89zmtVM0QFtR9ABXMB4duebcekhmT4JZh4yCUtj1LrahKYmh/sZ5btT5wc9TzRTBuArBzDfCHlclzqkp64BVGCB+SDHNGzJpYs2b06dYpQTaEDckUmZj3l7jyrpsE1QHPyMETslcVq3vQxV8Tta7bY96ACPnKTZNfDmk4hu1VLXqAC4sfVtHDLc0HXPWb6C1L4SaeMQ1pe/z8sOLjCuNcY/voAVkLKX7bbVtOQq7iuGGvtg33mxTLGFbeDck8lbMglNXj7ri7qaNhCINZPYVrnmC/kky0BZzmeo9+n5lxPr2kFEd35REZUgrEbQN01GxMDpq9PdnQ5ArNmZwqDWd0Ragw89Hqhmq8oiVril4PiTbUr6B/GyVFcM/1+Pk+xdhkUvNLhbEn5MIH9vGoD+4sWdZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(66946007)(2616005)(478600001)(16526019)(31686004)(66556008)(8936002)(2906002)(66476007)(31696002)(316002)(5660300002)(52116002)(54906003)(53546011)(7416002)(186003)(8676002)(83380400001)(36756003)(4326008)(6916009)(6486002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZGsxdVpJSFB6SVgxM2I1R3dyUllFQ0MvZUl2RGZZWVNqY1E5Q0t1Vkp1WHdk?=
 =?utf-8?B?dEJHK0pFZ1UvMzNRTEFMWTF3eXRtMGlwdVREV1psZDVSa1I3dXIrN0N3Zys4?=
 =?utf-8?B?MnY0dW1GNDdWWUJ0ZDAyNXl1MnlQOERGZS9HQVpSSURqWHhrMXZvTFR5b3M0?=
 =?utf-8?B?c1JWZHhXWFF5MDIzb2RET0IzT1hLS1k3UzdNOEhtc1VZSnY2VE9PbTNvVGhw?=
 =?utf-8?B?WFVjUzBEbFRadmZtTnJBclNTSXBidkZRS2hLbHpacElZWEhsQlp4cndvMVIv?=
 =?utf-8?B?ekk1TWZUTXY5aHV3QVNnM0RKWVVtQVNhZVZrekZUUitYeFFEaUxhNFpFMjF1?=
 =?utf-8?B?Y2I5dGFhaWhTY1M3QVhVQWMvVjR6UXhUb3o0THpqYVhtdGVkSCtFSnJyalY5?=
 =?utf-8?B?SzVJVUU2VVBUSWppUytOaVMrQWc0S2s0dXFLTTByN3dQNWtraFZoOXJoaVU5?=
 =?utf-8?B?aXNqVm4zOHNxNlp0VGloTkoxV0l2aFhiWjIwRnB4ajYvYVJRRWJGTHVHNWhR?=
 =?utf-8?B?SmxlY2ltR2tuY3VZbWRDR0N2aU03amZUQjkzaDlHcDBLakFhNmE4N0Nkempw?=
 =?utf-8?B?eC84ZTBsNnNrNWxRT2pKRHZ2cUJIQWpqMndIbnFqcXNTSjdqUlVGelc5VTlS?=
 =?utf-8?B?ckdZRnZoajVacktIUy9xaG1oZ05zU21qL2ZCNlpFT3VaRmdSckEvaUFTcXJO?=
 =?utf-8?B?UnpQNm1ySXhGUVdLRG9kUzR3SmdwTS9mN2RiZGloUEdPU3EyRXNRckJ4L1lu?=
 =?utf-8?B?VDJSQzQzQnFTb2VTaHQ4dXRJMG5HQ2pkZkVMNGVOUGVVbm5td1BsdnpsSnQz?=
 =?utf-8?B?MkROUWd3V1hVUXZZTlpxTDUzcmI2QmMrS2tWaVB4WUNGT1E4bWhXdXBSa0Q4?=
 =?utf-8?B?bVVYNTg3ZjNKemgzWXlzbjR5QWlaSFNiRURia1AveldmQjVCOWFPdE12NkpZ?=
 =?utf-8?B?M01EUDJzbWNkalNTanlNUWlCNVZyVTgyZmlYcjNJQlJlZkt3N24rQ0I0bHRy?=
 =?utf-8?B?TWE4Tm5DcXBLdVc1OUV2TTNVZzlIUVprbnBOc1RBeGJiMk9VYkZBd0cxbkZH?=
 =?utf-8?B?MnZTYWtnVlJ1ZVNKYk9FYmt4eDNZM2dwSEp3M21ETExmWllHbnZYYlYrbXpS?=
 =?utf-8?B?R1E4bnBEelNOQTlzSkJkYjhhdFFUSHFhWENldURXVDZ1MGY5amRBczFQbFQ1?=
 =?utf-8?B?TVhveVYwY0FEa1ZWeTB2OEVjRmlrVjZzRk1PNFE5aHoydnFEaGtRZUtGN0J0?=
 =?utf-8?B?QnZrdGdmZWlqcUkwSG94aWZKVVJZQWR5MmNZQi8zbjF3UXAwb2JqakJDV0Zz?=
 =?utf-8?B?YWxGSGhQWDA2Y0duSVZqeFI3WmE4V0l6eUlydHNXU1IrQWlvMXJRZXoySmQx?=
 =?utf-8?B?aEtibWZKbml5WHc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2021 23:43:59.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 279cab2c-fb2c-47af-bbf6-08d8b8e64441
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpaSts/adiK2PNU8K5JluVOlMS0msQ6Xv14sapDi7/T8UlANjX8puI+cETnnG7hS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3510
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_10:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/14/21 2:02 PM, Jiri Olsa wrote:
> On Thu, Jan 14, 2021 at 01:05:33PM -0800, Yonghong Song wrote:
>>
>>
>> On 1/14/21 12:01 PM, Jiri Olsa wrote:
>>> On Thu, Jan 14, 2021 at 10:56:33AM -0800, Yonghong Song wrote:
>>>>
>>>>
>>>> On 1/14/21 5:40 AM, Jiri Olsa wrote:
>>>>> It's possible to have other build id types (other than default SHA1).
>>>>> Currently there's also ld support for MD5 build id.
>>>>
>>>> Currently, bpf build_id based stackmap does not returns the size of
>>>> the build_id. Did you see an issue here? I guess user space can check
>>>> the length of non-zero bits of the build id to decide what kind of
>>>> type it is, right?
>>>
>>> you can have zero bytes in the build id hash, so you need to get the size
>>>
>>> I never saw MD5 being used in practise just SHA1, but we added the
>>> size to be complete and make sure we'll fit with build id, because
>>> there's only limited space in mmap2 event
>>
>> I am asking to check whether we should extend uapi struct
>> bpf_stack_build_id to include build_id_size as well. I guess
>> we can delay this until a real use case.
> 
> right, we can try make some MD5 build id binaries and check if it
> explodes with some bcc tools, but I don't expect that.. I'll try
> to find some time for that

Thanks. We may have issues on bcc side. For build_id collected in 
kernel, bcc always generates a length-20 string. But for user
binaries, the build_id string length is equal to actual size of
the build_id. They may not match (MD5 length is 16).
The fix is probably to append '0's (up to length 20) for user
binary build_id's.

I guess MD5 is very seldom used. I will wait if you can reproduce
the issue and then we might fix it.

> 
> perf tool uses build ids in .debug cache as file links, and we had
> few isues there
> 
> jirka
> 
