Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762FB349EDF
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 02:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhCZBlx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 21:41:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23918 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230226AbhCZBld (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Mar 2021 21:41:33 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12Q1c3Rm006205;
        Thu, 25 Mar 2021 18:41:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=facebook; bh=5wmLkCiY0URd5zJ56huBzu5JuySB6Te+gxrX8mWXLIo=;
 b=Z3bWDG0ONiTUf1BFJNpW+0h7NsajUUCSAjaKnD5UJR6VoCUR1xvyQ0N3jfHpuV7LKURr
 4NNGQr/QghPy1vCNDaNhIi6mNIcaPJhLNqFqtHvbdDdTRj7gbTAP1o5Hrtvpf+W3qxfv
 0XKMntWLJ7RN/w6pBZAdEIPH4DPnGtJlYEY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37h15thggd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Mar 2021 18:41:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 25 Mar 2021 18:41:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDrls3+qg7d/ut0F0b5xHgCidrXdTAB+fhNns5C402VwiHIVfu7yaZsJtCC+7M/juWUaZ80gvoRwSZyvWagdxe8ZUD54p+/7cPG7xJZDQ49WpWGcJifShqi6s0FGtCJA3+XUS1z082ya9jTJB/1pi1VoXU8RU9ZfvsBJ8eqvGc3FAwuJTqw22UifS3QhocEZq39AGAKbcgKonNkh7vfmr1uvqWQdvqCV+G0XeL0Op7fKHpTRIsbFThsr0bs60pIXKLfgk0uWzAVv0r42duhdpJo+EmDTM4t/z7ah4DroKu0uBs2Va+kcY6loX9Mge+W5MwcT1ZcMLUsAsByuPVvO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqbGYZ8SZo7nLSN56fQIWxu6zY5QNgo4ZF93Djat+0o=;
 b=j24VnzEjbn+c4O/j1ZXtxijGwTG8+pbac23aY+NmPMVxxQIZe2gPLXZ1NX2Qb4LQnFyn74lZDqx4jgStiDxjbBuj1wmqedvupCA/YyXxy2x8mLxon2tb8Wi7hvG27bFUTv7GYmqh6FR3YzDotUvBL1YYEduqyh9MH9efEuw7sLrqlj7BpqLCpx2YpIJj06wQVCl+BvW5pmM2evaDEFuWOcrHGzy99SpxqleyN5bWM4hmKx3AmjU9iZXkqNSjbmZTTTSCjY6xV1F7Y/5sDTlR2YrE9rP57wSieu991WB8rc2TwvKXSAMXkoU0Ycpy5hg5lX9Nq18J4IEhX2qifcKs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4016.namprd15.prod.outlook.com (2603:10b6:806:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Fri, 26 Mar
 2021 01:41:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 01:41:28 +0000
Subject: Re: [PATCH dwarves 0/3] add option to merge more dwarf cu's into
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20210325065316.3121287-1-yhs@fb.com>
 <YFyLyfYCD131ZM5k@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2b2143ef-c788-f558-2787-01e03d6af498@fb.com>
Date:   Thu, 25 Mar 2021 18:41:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <YFyLyfYCD131ZM5k@kernel.org>
Content-Type: multipart/mixed;
        boundary="------------884B5A2B0FD82D75CE7BA27D"
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:eeac]
X-ClientProxiedBy: MWHPR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:300:16::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1337] (2620:10d:c090:400::5:eeac) by MWHPR13CA0004.namprd13.prod.outlook.com (2603:10b6:300:16::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.15 via Frontend Transport; Fri, 26 Mar 2021 01:41:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f217efc-a1e7-40d1-a3d2-08d8eff84601
X-MS-TrafficTypeDiagnostic: SA0PR15MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB4016E7B81F90CCFDE042B4EBD3619@SA0PR15MB4016.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcCWAJs5iBltp0GPDULScQtg09kG3b+kW+s0MGSLBO3WzRtVfotkbquO4dwCa2hC7zx4J13qKtaX+36adsGx7TZYT7BzVb4J5Ef7Ol81ZlN/d9OOm/XvlkElC/F87AFVClh2XK2LwziUpW8RPyD2XIAXpuskJ/fHE49HT29+SQ+LaIRvafs+3kNDXSmii7cVxAq2ifaapN8GIvIDSPn8IIjis+/o2yKanMNBU/SSyCkqmkOyc8NEYXfIj0sYqRfoyGpnvfzEb3fmH7rFYBy00sFr9OdJxKMUllftfS3VFwN1+IBQy3I8EswEGrHr1E+LTIZTFtB+xXMbZai8o6ZHffv3FPo/U6osl0vUSkhrxBm+W7XGuwXKgJOJ1FhpK67tn+bo10zmS1GHbAiC+2M9vTeyq0KkpIFBkPy63wKD3aEhumVRGU85SNcI/306qbnz+O2QajLpUZ2Jz7d+F8Ni6SEe8hcBQ31iFPURqRrc/z+lfqjJfNVPtFf46787FguBcg+FmCJ79WeHkLzY3ugFc+KdwsIYNaHlt33y4sMDl8I8vNTFmvB0UEclc/lDd7yObufi9Sp6yWd72lhNgUS7zNF4wkxkKbDoseZm9Yvf276EGJZ2lJo3tduoTHOTM3YdGq0OnRmNnrIgbhAvoUmTTJ4sCIHu9fekB1od0qvjAkaWXdE6tqGTu+W2QmSu6Hn7AtSgC4J8OT/VXXZfpvjmnpA/6JwEzN7HnaPIUQnJT7kFEvkvUcRRc95T16Kjr6em13ngJCh7eU+NRckT+zuusQmi7SVaw7NtInPNd+WQ3JI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(54906003)(966005)(33964004)(478600001)(2616005)(8676002)(8936002)(316002)(31696002)(36756003)(31686004)(86362001)(53546011)(38100700001)(52116002)(4326008)(66616009)(16526019)(6486002)(6916009)(235185007)(5660300002)(83380400001)(66946007)(2906002)(6666004)(66556008)(66476007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VnNvWmZoc1dVSTVMMHFHcnIrNjhVU2Zwb2EraGUzQ1pOSnVHVlRDdEgwY1Ux?=
 =?utf-8?B?V3ZZbGcyTTVFVElSbFBhMXBMWDU3UDdtQis5MUhhdmMvWlA1dlJGTTJvN0gy?=
 =?utf-8?B?YWxKMnVycmdQemlKZnNIc29XaWQ3cmFpTVdPQm9XUkEzYWVGR1dVUzhmTzd2?=
 =?utf-8?B?SkE2b2tzbmdDY0pzT0xoakc3Rkh2YzhoQUFlelNMVkYvTC9taVpUSXVSeFV3?=
 =?utf-8?B?ZWEzRUdjWEdiSVY1aW5XeDVBSVRSVDY5Q3NRQUxpYy8zZHlOYlRQRG12ZzRl?=
 =?utf-8?B?aWJTbnlFblhYbFdEK3FYckU1MStFcU14U1hleWNiYlNaZ05EUys3d2t1OTFi?=
 =?utf-8?B?alQyNHB2Skx4a2tJcnpyeGxGam9TUGxnRUNyV0k4M3QvYUhmdUwySlJYMWY0?=
 =?utf-8?B?NUwrcmRUZXhnY3FHQysxTE1JZUhXNzJhblVqTElhVDBsenc3TWNGd0VteDcw?=
 =?utf-8?B?eDkzNWttY3JJVGRsL3hoKzNYZEp5OGdJaFRObkszUXZjUmRHMUtSMWpnV3lw?=
 =?utf-8?B?Z201UU83alcvbjhSa1ZJVFlvOVdOTCtWRFhvMmRNMGpmZ1ZVQ0g4dm1jc3Vq?=
 =?utf-8?B?eE84UG4wUGdRdkhvemk5Wkh3Z295enNvSk1pYjkyeTNydkZVeVRaRXRRU2lr?=
 =?utf-8?B?QUJGWWJQU1ZuWDNFWGcyODB4aEVPSFRLc29RdUY3RGtqZGRaTmFsN3VzWmd4?=
 =?utf-8?B?TitPK0JJOVdxTlhwZy9vU3dtRUxzc1FKSElXZHcrVkZGRWhodnZzOFdma0xP?=
 =?utf-8?B?SHhIbzM2WUZFVlp6N2FKN0VXWXlwb0RXWkJLZWlHNytUQmlVcUY0djRLa2dY?=
 =?utf-8?B?MlFmamRJNnZ1T0hrMmc2UnZaNEQzMXUxWWgybFlsUk1BNXg2b0hET01wblph?=
 =?utf-8?B?NWdISlVNeERVSHRNTGE4ckljdlAzbEFRdnVBY3lndzdRSFlxQ2xWcDRxOXlR?=
 =?utf-8?B?RnBFQ29SUzR3MWZrMlBzQ3YyT01hME9Nd1kyeXBnRkd1cUloTWRhbGtMM3o2?=
 =?utf-8?B?M1Y1ak10bDdQaU1ta3A0WnowVWRLWlBwWXRvcTMyUkl2VU9rQ2NHMjl0eG92?=
 =?utf-8?B?eGorTk9DUENFSmVVclEzWVp2M3lDWFV3N2tUTkFwMFZpMGhaU1NndVJuQ3Ni?=
 =?utf-8?B?OGxaUFdESVdMdzFJNXJDaVJNV21YQytocjkwTmhaT3dPekJWb0VCSE5taWNy?=
 =?utf-8?B?M1ZyNVk2Mit4UzNaeUQ0a3B4eDNDc0xPNEFRV1FsNEFwS281R0JxaUo0S3Ay?=
 =?utf-8?B?VkFNZ08yU0wyakRCR0xHL2pGa2ZnZUg1OEpDckdwcWFyVU1JajByb2swdGxa?=
 =?utf-8?B?YWFmdnJJbHJHZ3U5S3RucTJmVTBCZThjT2o0a3g0MXdqcDVnQWVtenpLeEYz?=
 =?utf-8?B?NEVmSmJYTUtIL2taMUhGTjhmKzQxdEk4OU11c0s1T1g4UWtROG1ONnpUOXFz?=
 =?utf-8?B?aWVnbEtJcmVRano5VzFSVEFrMjQ3c24wRVZXa3ZiUTZESkE4aEZ5TlRGa3Bs?=
 =?utf-8?B?MzA2Yksxa2pEYy9lK1VTd3BDbHB3b3dsVy83aTVld3hzTXBGYzRLR01GbEEy?=
 =?utf-8?B?ZmREcXRHb2hEUGtRL1pobSt3cGQwbWlxR0VaaW5hRVY0Q1JGUFQ5ZndvV0la?=
 =?utf-8?B?bzlNVDNkclZjY0d1U09EcXl3ZUV2LytnV0JjZEdWdm9iTGpmSi9YdlRwcVN5?=
 =?utf-8?B?dGNuVW9DNHZITnV5QTIvaXJLOFZzWk1aNVZKZVg4L1FWK0c0cFVCNGNDVTdL?=
 =?utf-8?B?djZwdkdPZ3dZZlZyQkZROUdSUDMxZVN0UUlNMTlYMUlUVGFwRVQyTWZ1U1JK?=
 =?utf-8?B?OWtMUFJvbGdNTkFzaThrZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f217efc-a1e7-40d1-a3d2-08d8eff84601
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 01:41:28.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7wVz6Q0Pa7IP3UjFrUcJfWRHavEcFIee8/8rwxh6rHMs9QpZdzWkcjXLY+N9HzF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4016
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 5fluCrx_Ku5nJyj5xbu-UfDHn5WVtjg2
X-Proofpoint-GUID: 5fluCrx_Ku5nJyj5xbu-UfDHn5WVtjg2
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_10:2021-03-25,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103260008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--------------884B5A2B0FD82D75CE7BA27D
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 3/25/21 6:10 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 24, 2021 at 11:53:16PM -0700, Yonghong Song escreveu:
>> For vmlinux built with clang thin-lto or lto for latest bpf-next,
>> there exist cross cu debuginfo type references. For example,
>>        compile unit 1:
>>           tag 10:  type A
>>        compile unit 2:
>>           ...
>>             refer to type A (tag 10 in compile unit 1)
>> I only checked a few but have seen type A may be a simple type
>> like "unsigned char" or a complex type like an array of base types.
>> I am using latest llvm trunk and bpf-next. I suspect llvm12 or
>> linus tree >= 5.12 rc2 should be able to exhibit the issue as well.
>> Both thin-lto and lto have the same issues.
>>
>> Current pahole cannot handle this. It will report types cannot
>> be found error. Bill Wendling has attempted to fix the issue
>> with [1] by permitting all tags/types are hashed to the same
>> hash table and then process cu's one by one. This does not
>> really work. The reason is that each cu resolves types locally
>> so for the above example we may have
>>    compile unit 1:
>>      type A : type_id = 10
>>    compile unit 2:
>>      refer to type A : type A will be resolved as type id = 10
>> But id 10 refers to compile unit 1, we will get either out
>> of bound type id or incorrect one.
>>
>> This patch set is a continuation of Bill's work. We still
>> increase the hashtable size and traverse all cu's before
>> recoding and finalization. But instead of creating one-to-one
>> mapping between debuginfo cu and pahole cu, we just create
>> one pahole cu, which should solve the above incorrect type
>> id issue.
>>
>> Patches #1 and #2 are refactoring the existing code
>> and Patch #3 added an option "merge_cus" to permit
>> merging all debuginfo cu's into one pahole cu.
>> For vmlinux built, it can be detected that if LTO or Thin-LTO
>> is enabled, "merge_cus" can be added into pahole
>> command line.
>>
>>    [1] https://www.spinics.net/lists/dwarves/msg00999.html
> 
> Thanks for working on this, I'll look at it today.

Thanks! In case that you want to test with the kernel, I attached a 
patch on top of bpf-next to use --merge_cus when building kernel and 
modules.

> 
> - Arnaldo
> 

--------------884B5A2B0FD82D75CE7BA27D
Content-Type: text/plain; charset="UTF-8"; x-mac-type=0; x-mac-creator=0;
	name="0001-scripts-bpf-add-pahole-merge_cus-support.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-scripts-bpf-add-pahole-merge_cus-support.patch"

RnJvbSAwZGZiNTYxYTE0YTllYjFjNWJkMDc3ZmI5YjQ3Mjk0NTVkYmI1ZWM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPgpEYXRlOiBUaHUs
IDI1IE1hciAyMDIxIDE4OjE1OjM4IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gc2NyaXB0czogYnBm
OiBhZGQgcGFob2xlIC0tbWVyZ2VfY3VzIHN1cHBvcnQKClRoZSBmb2xsb3dpbmcgaXMgdGhlIGNv
bW1hbmQgbGluZSBJIHVzZWQgdG8gYnVpbGQgdGhlIGtlcm5lbDoKICBtYWtlIExMVk09MSBMTFZN
X0lBUz0xIC1qMjAgJiYgbWFrZSBMTFZNPTEgTExWTV9JQVM9MSAtajYwIHZtbGludXgKTWFrZSBz
dXJlIHlvdXIgY29uZmlnIGhhcyBDT05GSUdfTFRPX0NMQU5HX1RISU4gb24uCllvdSBtYXkgYWxz
byB0cnkgQ09ORklHX0xUT19DTEFOR19GVUxMLCBidXQgaW4gbXkgYm94LCBpdCB0YWtlcwpxdWl0
ZSBzb21lIHRpbWUgYW5kIHRoZSBsbHZtIGxpbmtlciAobGQubGxkKSB0YWtlcyBtb3JlIHRoYW4K
MTMgbWludXRlcy4KClRoZSBmb2xsb3dpbmcgaXMgdGhlIGNvbW1hbmQgbGluZSB0byBidWlsZCB0
aGUgYnBmIHNlbGZ0ZXN0czoKICBtYWtlIC1DIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZiAt
ajYwIExMVk09MQoKU2lnbmVkLW9mZi1ieTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4KLS0t
CiBzY3JpcHRzL01ha2VmaWxlLm1vZGZpbmFsIHwgOSArKysrKysrKy0KIHNjcmlwdHMvbGluay12
bWxpbnV4LnNoICAgfCA3ICsrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zY3JpcHRzL01ha2VmaWxlLm1vZGZpbmFs
IGIvc2NyaXB0cy9NYWtlZmlsZS5tb2RmaW5hbAppbmRleCA3MzVlMTFlOTA0MWIuLjVmYzlkOTFj
Njk3NiAxMDA2NDQKLS0tIGEvc2NyaXB0cy9NYWtlZmlsZS5tb2RmaW5hbAorKysgYi9zY3JpcHRz
L01ha2VmaWxlLm1vZGZpbmFsCkBAIC00Nyw2ICs0NywxMyBAQCBjbWRfbGRfa29fbyArPQkJCQkJ
CQkJXAogZW5kaWYgIyBTS0lQX1NUQUNLX1ZBTElEQVRJT04KIGVuZGlmICMgQ09ORklHX1NUQUNL
X1ZBTElEQVRJT04KIAoraWZkZWYgQ09ORklHX0xUT19DTEFOR19USElOCittZXJnZV9jdXMgPSAi
LS1tZXJnZV9jdXMiCitlbmRpZgoraWZkZWYgQ09ORklHX0xUT19DTEFOR19GVUxMCittZXJnZV9j
dXMgPSAiLS1tZXJnZV9jdXMiCitlbmRpZgorCiBlbmRpZiAjIENPTkZJR19MVE9fQ0xBTkcKIAog
cXVpZXRfY21kX2xkX2tvX28gPSBMRCBbTV0gICRACkBAIC01OSw3ICs2Niw3IEBAIHF1aWV0X2Nt
ZF9sZF9rb19vID0gTEQgW01dICAkQAogcXVpZXRfY21kX2J0Zl9rbyA9IEJURiBbTV0gJEAKICAg
ICAgIGNtZF9idGZfa28gPSAJCQkJCQkJXAogCWlmIFsgLWYgdm1saW51eCBdOyB0aGVuCQkJCQkJ
XAotCQlMTFZNX09CSkNPUFk9JChPQkpDT1BZKSAkKFBBSE9MRSkgLUogLS1idGZfYmFzZSB2bWxp
bnV4ICRAOyBcCisJCUxMVk1fT0JKQ09QWT0kKE9CSkNPUFkpICQoUEFIT0xFKSAtSiAtLWJ0Zl9i
YXNlIHZtbGludXggJChtZXJnZV9jdXMpICRAOyBcCiAJZWxzZQkJCQkJCQkJXAogCQlwcmludGYg
IlNraXBwaW5nIEJURiBnZW5lcmF0aW9uIGZvciAlcyBkdWUgdG8gdW5hdmFpbGFiaWxpdHkgb2Yg
dm1saW51eFxuIiAkQCAxPiYyOyBcCiAJZmk7CmRpZmYgLS1naXQgYS9zY3JpcHRzL2xpbmstdm1s
aW51eC5zaCBiL3NjcmlwdHMvbGluay12bWxpbnV4LnNoCmluZGV4IDNiMjYxYjBmNzRmMC4uNmI1
MmM4NmFjZGFkIDEwMDc1NQotLS0gYS9zY3JpcHRzL2xpbmstdm1saW51eC5zaAorKysgYi9zY3Jp
cHRzL2xpbmstdm1saW51eC5zaApAQCAtMjI3LDggKzIyNywxMyBAQCBnZW5fYnRmKCkKIAogCXZt
bGludXhfbGluayAkezF9CiAKKwltZXJnZV9jdXM9CisJaWYgWyAtbiAiJHtDT05GSUdfTFRPX0NM
QU5HX1RISU59IiAtbyAtbiAiJHtDT05GSUdfTFRPX0NMQU5HX0ZVTEx9IiBdOyB0aGVuCisJCW1l
cmdlX2N1cz0iLS1tZXJnZV9jdXMiCisJZmkKKwogCWluZm8gIkJURiIgJHsyfQotCUxMVk1fT0JK
Q09QWT0ke09CSkNPUFl9ICR7UEFIT0xFfSAtSiAkezF9CisJTExWTV9PQkpDT1BZPSR7T0JKQ09Q
WX0gJHtQQUhPTEV9IC1KICR7MX0gJHttZXJnZV9jdXN9CiAKIAkjIENyZWF0ZSAkezJ9IHdoaWNo
IGNvbnRhaW5zIGp1c3QgLkJURiBzZWN0aW9uIGJ1dCBubyBzeW1ib2xzLiBBZGQKIAkjIFNIRl9B
TExPQyBiZWNhdXNlIC5CVEYgd2lsbCBiZSBwYXJ0IG9mIHRoZSB2bWxpbnV4IGltYWdlLiAtLXN0
cmlwLWFsbAotLSAKMi4zMC4yCgo=

--------------884B5A2B0FD82D75CE7BA27D--
