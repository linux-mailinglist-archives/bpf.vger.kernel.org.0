Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77F42F6CD9
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 22:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbhANVGl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 16:06:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48976 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727481AbhANVGl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Jan 2021 16:06:41 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10EKxqCb017515;
        Thu, 14 Jan 2021 13:05:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Hf2w7YPy5++XBPuy7oLknyPezcCHVjqji5LiHXDzIh4=;
 b=DzAxoGj4p2uMczg5OEVThuHzl4ZKtGXpeTRC3Wx6XDs8/gF7dA1RmGAic3MoNQbl1h5E
 1WYQvUg6Y8PkQJUNzQWJW6nOONcLzeeNT1qaVS7rrAHl66Ug7eBKidw4b8Ugiq0UIxVs
 ePYv7KDtVEH9OlAVSWz5PgOo+uNiIXRej24= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 361fpbn5mj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Jan 2021 13:05:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 13:05:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uluqft8n0qyoo/Ep51nQuKX0l6vPX6i1S/doUwZg1+3QcI0JKJMKR/OflYxwgSlBhH6H4trWL83NlQJ8xhZEpvbGeogXlYyNYd7PYv1vRhsfbu8wqgKzkOxF5wWGNnHHjMBt0SkZoXPGhwDo9IvwD4u3pfyum975KAWwkAoaAia9GLOZyCbsvj+YHsyiMXuDl3EOjonSrfUEDUQV1WYU9Fw2mPqaDdR5m/XiMB7bgeLhj2TzRb8ve/bfHpPN2v/CYtqlmHVdu4wvlebpD6Iqr6wj3H4opTHBG702V6sbHNlkR5Qg2FcSBdB4xwkaO0/9RnQpX8zoUiaA15XZNHOFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf2w7YPy5++XBPuy7oLknyPezcCHVjqji5LiHXDzIh4=;
 b=CjgZNiKP/t7Y1kw6iRcLmSq4iMZT8VNQGsOUgb2s+3JGweEXln5u0SSaZmIpl4QZ1IPFArBkuU+2LpkTymfZW1u2olb4mv/uaTQn2ugwQPYEPoDMMFNreMKWllwB29ryk0YVAkaZU8prwmuuEVpTHl0f0MLY8zHy9ijZtyqzBLdV0RsGRLr5ofSBEiTNf1xQbRGG5nlwv1HzYXYjIKrLQXp1dT0DhQmMCnZBa3zxDRbF2/zG6ITj1bAS7T04P4s9mpMKSGSoU+y/yV0kaTsSCR+sCdFcNS7yqIFfKfwW7d6Tr14Z46X7GKnbjQW9kd1lAuUiQsOVCS65o66ncyv/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf2w7YPy5++XBPuy7oLknyPezcCHVjqji5LiHXDzIh4=;
 b=MGJshXpXa6UGFTeoNx3nS2ohIvMIO6zJlzc5PdtZ+2Wj4kE32n6somJGUv6TeGQ1KSDVvQ9ivmVL3MzJQUtQjHrbcGwYriqHFzIpMNvOnYm7I305gLAH1EuyylK4faQSbQUMjpVzorA3qUtGQeLCMddaokPD2B3zRPwyWyUWC08=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2325.namprd15.prod.outlook.com (2603:10b6:a02:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Thu, 14 Jan
 2021 21:05:36 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 21:05:36 +0000
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
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d90fd73f-b9a6-c436-f8ae-0833ce3926ef@fb.com>
Date:   Thu, 14 Jan 2021 13:05:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210114200120.GF1416940@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ab59]
X-ClientProxiedBy: MWHPR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:300:94::30) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::13f6] (2620:10d:c090:400::5:ab59) by MWHPR19CA0068.namprd19.prod.outlook.com (2603:10b6:300:94::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Thu, 14 Jan 2021 21:05:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44efada8-5a3e-42f2-511b-08d8b8d023e4
X-MS-TrafficTypeDiagnostic: BYAPR15MB2325:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB23255A4C853A4326498FA5F6D3A80@BYAPR15MB2325.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RKaTq1nIYQI0IvKJDJt31BRbSM2OQzuS6EtS3y78Yn4SZz6nYZiy0WVgBNx64kUYMmmAlx2iCx4HaAE/lzocOXQH2QL05bHl5Hg62Z68QEJWhhfGKyAEp5fEy+kjyOrcLPxWr8ytJ1w0Ne9oAs+tTmq0+sPBUxrLaGLFUZuhQ14dgqeirCw9uZE0DwqBUQ/4J9sVtZHk5gHMo2EyF40kvH+uT4gN1+ICYfE9vBl/dLJImYKTccywpsRqxUEfD02oMf4B0njAroLaX62ddeof1g1ApXjwQlh7GL8T+2jsKImGdJ/FLQqWePgfrV3Gub0lRV8/z9ALsjLNwrNodHNFIgb9HDfsJZQjuf6sjOvX2QeZHR/nHiDFFtKmnvbTgIlILxjD2sllNrol+YqWs9+yB7pmfpndqZ5RZlMQGEDzHhjGDRrPAbQTYhLbCAncF8R1LJHTEdYBmHrL+71zloMHs2r8T9FH4TNr1NSW8qIyYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(396003)(366004)(136003)(8936002)(2906002)(52116002)(31696002)(86362001)(16526019)(31686004)(478600001)(54906003)(186003)(36756003)(2616005)(66556008)(66946007)(66476007)(5660300002)(6916009)(7416002)(53546011)(6486002)(4326008)(8676002)(83380400001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q1dEVHJNN3JkTlU3aXdRbjI3SURBWW9ZenhENWRsQ2wwTmtvT092ai9pS3I4?=
 =?utf-8?B?bEtpVnFRd09NSjVEYmxhYU5EYjhUVnlVRE9KakZESWZMenRUUEtYelJoanVD?=
 =?utf-8?B?TU1uZ0xaTnMxRWJnMTArN01XbHBtbS90dzdLVTRDK0FYSTNQUGxzMWJoU2Z5?=
 =?utf-8?B?S0JUblF0SGtRZEF4RXV4REFHUHFBY001b0FzM0YwOHRuSTI0cVV3U0RRaTI4?=
 =?utf-8?B?MkJYMnA3NGI0VjRweHEvejRDSzloelNLVlp0OFBjT1RWOUNRSk1YRFhkSEFs?=
 =?utf-8?B?QTdtOEZ4VW1xMGxJVzh1RmJlblJGejBWN0tNdGNsdkdOalZIZ2dsWFloVHRz?=
 =?utf-8?B?cUViZ0FaYVlNMWNpY2dWVEViVi9oMnJNeng2aFd5UmxCT2RFR2JDMXF3b0dJ?=
 =?utf-8?B?NThtc242UG02WUQ3VnpaMHNTWEZFWFA0N2IrbGo5UjJlWmdtM1pQY2lkOElP?=
 =?utf-8?B?VmxKK1ZhaTU1ekVLMlBwbkNqSFViQkJ1ZlIvYmllN2l0d0RaN05Fbm9IOGVD?=
 =?utf-8?B?MnNjK2xvNlFjMThkQ1dtR21lTkhtRnppQmU3cDAxLzdnalZxdzdRNk85UjVC?=
 =?utf-8?B?REV2bWQ0MTJLZGhHTXN3R0hIYmdtb055OE1QUEdoMUdQblFyenpJQ3IvaExL?=
 =?utf-8?B?U0ZVQmFUQ3ExUGlQbUp0MUpLeE5acE5XUkVZMnN4UytWWk8vS2RxRVIweVNZ?=
 =?utf-8?B?WG40emNKa09Nc2k5NlczZGpSY3FsbnFDSWdVV2RYcVhOcnpmQVBwYUxJb0Zx?=
 =?utf-8?B?NC9FMXFJY2o4RjF2aFF1OFBlc1Brc2F3dmxmQmN3ZlJCMWhrQzk1L3IvMlVY?=
 =?utf-8?B?MEh0azY3cVQ2N0hsYzN3N295Y2tVOUMrNmtTeHVvakthWkova0k4d3pzYUtk?=
 =?utf-8?B?K05mUzV6Z2lXQm5EZTZ1R3QxbDc5QTgxZWVWRWc0VlhobWloQUNQeEJGdE13?=
 =?utf-8?B?Um1Da1NtY2VGYklZWHFxOUUzS3NjTUVBVVlqVU5lVHQ3ZU5xSTE4SFZpTEZB?=
 =?utf-8?B?K2JaRHE4ME44emxzWUo5aitjT3g2b09zTnJadm5ZQ1VSVmlKODBVcEp5Ky9r?=
 =?utf-8?B?R0REa2FzT1VxQXN3MWd5MjlKZTM5U1R5b0JvMkM1TEdSbEdEYTJHcE1zWE83?=
 =?utf-8?B?emZITTBhbnFSTmRTcUVmY052QVNmZExnN1Jub29BZE9Sb2Jvck9SQWx4V296?=
 =?utf-8?B?M2JIdVRLYllXWWlPUVlnK250SFVHVlpQWUw5OHRtVVFTalBPRjFVczgzTmli?=
 =?utf-8?B?N1Y1bkkxREZWN3A5eE5WUFVENTJKUmk3VHdMZ0hSTGc3djVLMW02RkdJbThR?=
 =?utf-8?B?aENWTGJnejhuK0RLcml5NnJuNXd2YTR6NnlmbkhKeWQ2Zi9Oa2JFNkJsSnEx?=
 =?utf-8?B?WGNQMFpjcElvbGc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2021 21:05:36.6889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 44efada8-5a3e-42f2-511b-08d8b8d023e4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlL5LoiKofvGM4tdeC7CiByBLOVPfkWNKkXUT0FBocWFmt1LPLfALq0cSjpzU/Nx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2325
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_08:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101140122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/14/21 12:01 PM, Jiri Olsa wrote:
> On Thu, Jan 14, 2021 at 10:56:33AM -0800, Yonghong Song wrote:
>>
>>
>> On 1/14/21 5:40 AM, Jiri Olsa wrote:
>>> It's possible to have other build id types (other than default SHA1).
>>> Currently there's also ld support for MD5 build id.
>>
>> Currently, bpf build_id based stackmap does not returns the size of
>> the build_id. Did you see an issue here? I guess user space can check
>> the length of non-zero bits of the build id to decide what kind of
>> type it is, right?
> 
> you can have zero bytes in the build id hash, so you need to get the size
> 
> I never saw MD5 being used in practise just SHA1, but we added the
> size to be complete and make sure we'll fit with build id, because
> there's only limited space in mmap2 event

I am asking to check whether we should extend uapi struct
bpf_stack_build_id to include build_id_size as well. I guess
we can delay this until a real use case.


> 
> jirka
> 
>>
>>>
>>> Adding size argument to build_id_parse function, that returns (if defined)
>>> size of the parsed build id, so we can recognize the build id type.
>>>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Song Liu <songliubraving@fb.com>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>    include/linux/buildid.h |  3 ++-
>>>    kernel/bpf/stackmap.c   |  2 +-
>>>    lib/buildid.c           | 29 +++++++++++++++++++++--------
>>>    3 files changed, 24 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
>>> index 08028a212589..40232f90db6e 100644
>>> --- a/include/linux/buildid.h
>>> +++ b/include/linux/buildid.h
>>> @@ -6,6 +6,7 @@
>>>    #define BUILD_ID_SIZE_MAX 20
>>> -int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id);
>>> +int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>>> +		   __u32 *size);
>>>    #endif
>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>> index 55d254a59f07..cabaf7db8efc 100644
>>> --- a/kernel/bpf/stackmap.c
>>> +++ b/kernel/bpf/stackmap.c
>>> @@ -189,7 +189,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>>    	for (i = 0; i < trace_nr; i++) {
>>>    		vma = find_vma(current->mm, ips[i]);
>>> -		if (!vma || build_id_parse(vma, id_offs[i].build_id)) {
>>> +		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
>>>    			/* per entry fall back to ips */
>>>    			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>>>    			id_offs[i].ip = ips[i];
>>> diff --git a/lib/buildid.c b/lib/buildid.c
>>> index 4a4f520c0e29..6156997c3895 100644
>>> --- a/lib/buildid.c
>>> +++ b/lib/buildid.c
>>> @@ -12,6 +12,7 @@
>>>     */
>>>    static inline int parse_build_id(void *page_addr,
>>>    				 unsigned char *build_id,
>>> +				 __u32 *size,
>>>    				 void *note_start,
>>>    				 Elf32_Word note_size)
>>>    {
>>> @@ -38,6 +39,8 @@ static inline int parse_build_id(void *page_addr,
>>>    			       nhdr->n_descsz);
>>>    			memset(build_id + nhdr->n_descsz, 0,
>>>    			       BUILD_ID_SIZE_MAX - nhdr->n_descsz);
>>> +			if (size)
>>> +				*size = nhdr->n_descsz;
>>>    			return 0;
>>>    		}
>>>    		new_offs = note_offs + sizeof(Elf32_Nhdr) +
>>> @@ -50,7 +53,8 @@ static inline int parse_build_id(void *page_addr,
>>>    }
>> [...]
>>
> 
