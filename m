Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1400835D476
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 02:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbhDMAbn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 20:31:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1976 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239870AbhDMAbn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Apr 2021 20:31:43 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13D0SFDp011454;
        Mon, 12 Apr 2021 17:31:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6oyG6Q2KsFeGQ37wO3NL6q9irA1NI6/anRiPpYkGP1Q=;
 b=ZD52hhL4PX/HComsjDJHsr0fJYa58indciZeW4rUt35r2BgTv1V8VZj+PJUH7VurARwm
 eH2ngLGU80+i9aQhptySV3qcLKzUxqtPX/iHV/DD/6IKuBoRVqwE6nmpTXireXrjXLdl
 rNRYAeGDhcEAqGu2lNzF4N0TAeomo90+6zA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37vs1cjt1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 17:31:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 17:31:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaZ5RR9K2RVrfzZ2c7kGD8AmPLFC77ixHKw5qwHS71/VXBNEidr10jFWj7GGsO5f76W2yF/Ik5kuBhUMbxmulynYJNUms8yIN1ssQXrWE3Gq9Bnf6/QwxsAt0UQxhVV04Viltb1K087OdEp66jyKNQZ3+iZGUkd1GyI98rLQCqywGP+mWlyOKcWDHJQHy3ylN8Yz9e72vTyBJeJqhCOBw6lPrVen6v5/cw8uRHW65fuNbGJmqWzhVyreMY30/YSNdXpL2ujgynfb0+2UvgCCMXs+eioDm2gug3flv23yL5o4CRB0lurnCNcUrRUzZWVkirW3tLBxKP/YUWvB9f07+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oyG6Q2KsFeGQ37wO3NL6q9irA1NI6/anRiPpYkGP1Q=;
 b=h9oMP+4Hm7XugSNIgVSR3gg75dV0AF7nK57dAMJI+V2faRvBhUJxXZAObF3h25gN7kEkFfcfVseoKE1OY4R4TbBeXwqsv/y+kcpMLAr5R4KQDFayo59HcAhMdH7pO+/6fN00ExEOOMjswNtbvplFfWghqRcwXkQVxs0aqqTmV/YF1ilN7onRXKiqzVr0qRciAchC23zOOadTitSddO9Fow5bbOCoFebxvexXwZ3yttZIzDlYwz/43ry+DjVilw/UZTnXNJEzTMx0Jvo4eKu8DUob8y+NA7/7NYNnEOj2RekuJP0yU+wkpmo9UD8L7oKwxb9Cq/qZOZ08qmQYH7a7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2157.namprd15.prod.outlook.com (2603:10b6:805:8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 00:31:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Tue, 13 Apr 2021
 00:31:18 +0000
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Sedat Dilek <sedat.dilek@gmail.com>
References: <20210412142905.266942-1-yhs@fb.com>
 <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
 <CAKwvOdkFWe76ggKrLeckS+mzmyQeq6eJBnkQM1bKgEGQBCspSA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e5f5f6b3-64e6-7068-ca72-9f06f3ffda54@fb.com>
Date:   Mon, 12 Apr 2021 17:31:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CAKwvOdkFWe76ggKrLeckS+mzmyQeq6eJBnkQM1bKgEGQBCspSA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:2d37]
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1a0e] (2620:10d:c090:400::5:2d37) by MW4PR03CA0117.namprd03.prod.outlook.com (2603:10b6:303:b7::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend Transport; Tue, 13 Apr 2021 00:31:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41d9b51c-c0de-481e-a27f-08d8fe13740e
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB21576DDEE422FA59DD79BA3CD34F9@SN6PR1501MB2157.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76hVsbnyTBZMdx0i9quRb4YcxdLMqPUFbVzvz+AY1twZTBnxdt92j/O35a1mkTiXH0qphya/+8bw+jKaYZcOx+neiJSu27Kra1eU6Eh2ZZfiI2/Q8QRIZ8dEi45Cd4Xaxbczk61P7tbK8fjOnIx6xPBz94IxRtTRgd8kscZ7KZnRjEuGFIqKm9SbbFDzNdBPhq3Ypiq+welg2Hmh1QDBCx8/jqc8tYvwQEBv9GNFkHmALEt/YJId0crxzI02RpCHQw7/lyU1cSskmshL+D31vrtwJwWNdL1tCdp/muov97cP3nuZI+Ty7yAcX82UPHwofQdDYXSm6JiPzIdt+2OXmfj49kSbVD4R/SkpOWXpdCn614gl79guc5cRCTxNU3y8gc+MA/MFBsv53KNjuGz9z1RuzyNk62o9AAy1qid7ev/wrxFfcZ1HppJuPYSkMSd20YHD47CGUb5ClUlri9IlCDRGDuQFXbNToiAlcV+zcXhzt7DlWWQV2XdYI6CfTn5ZkSq8MgvV8+h8diRI1vKrEKPfgwf9Wjo9CNxv+NFATgKl+8B2i7JVDkRYbe7YuKLwnQwGwEupuLCJJwkQgCcZLvBksKQ08tFrl9uH3PkOvxG+j1/DY1UpmARdORAIxQgrfMBVobbfScOGXu4j/MJzHwSVXzttI8Mj+VxHyeU3kE1qZmczpus06eq39Ld8AnLBoei0bENVFOybJ9ZUwKyVxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(136003)(346002)(86362001)(8676002)(5660300002)(478600001)(54906003)(316002)(6916009)(53546011)(8936002)(4326008)(31686004)(83380400001)(38100700002)(66476007)(6486002)(66556008)(2616005)(66946007)(31696002)(186003)(36756003)(16526019)(52116002)(2906002)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L05rbXpDWDNFK08rRzZ4MDcxTzJpWTZwZkRHNDVtZ2hDcVRCc253NVNxVDVB?=
 =?utf-8?B?WmpOUHBBRFNuaXpsU29uTXhxc0sxbC8rblpSM0FXU3RMWk8vNHR2dWNwalBS?=
 =?utf-8?B?SmVSOGxZcUtTbXJjTUYwekVRclJJUWFwcWtGTWN2RnZ1VlM3bnREdzVSNjFp?=
 =?utf-8?B?bnh0L0o4MTExUnczRU1XcC83VUhaQmFlVFRwY0lRSUNnSy9hMzYxR3AwTnJH?=
 =?utf-8?B?eWRKUFBaVDBubFhOOWdXVFY4MFR2eHNrczJJMnhHZ21WTHJ4ci9KMWdLVUZ1?=
 =?utf-8?B?OTIzNnl2c3pFYWpFZlNRS3d6ek4veDErNmg2bmloKzI3S2hVZFNCUCthc28r?=
 =?utf-8?B?TkxnS0R1dFNaaExtU0hoai91ZFRXQWVoeGo0UUJmS21PZVErTHJIWWg4VEo4?=
 =?utf-8?B?Q1VyTkVMTng2VjA4WWdHMUlDRThmYWZtb2dObUtNcm5aMTFsY1FGaUJYMG1N?=
 =?utf-8?B?Zjl1bThBc3FUbmFYWUQvMDZGbXErK2xaOUFuNmNkZVZyV0dJOVpvVjRkN1li?=
 =?utf-8?B?SUgwSDZTdUh1ZVp3WTlBbXNSYWJLSjJINkdVR0l1dUtDVG12cXFuT2NvWVdT?=
 =?utf-8?B?MzZ5T1RiaWltL3NwUjAyMWJzZWJxU29GSVI0OW1yTjM0bXZaanE4SUpmN2JB?=
 =?utf-8?B?U01rMkZBaUl1WVNvRmQ2TWFHZkVmcHR3M05iTlppYnNqVlZ6WjdnTDlUL1Vl?=
 =?utf-8?B?TkdQb3FxTzYrTVc2dnFvUzVPdTk3alNZM0J4OHF1Unc2YW0xbStWUDFyUGJ1?=
 =?utf-8?B?SkpOeXg5cGhwSjgrRWFnTlRuTVowS25GSThma1B6MG5KZ2dSQW1NbGt5UENu?=
 =?utf-8?B?dE1QanEwaFhzbE0wZFpDZGtUekhmeUs1WktuOThYQUN5R0tzQkJqeGVwWDlR?=
 =?utf-8?B?dFZKSGh2ZVVXL25YS2RkZXlZMWEyMmYwa25zd090eWlGaGNxaUh6OFJLeEFU?=
 =?utf-8?B?RzNhY1BFNi9aL2RCdi80anF2ZlBvUjlNSDRjSnp4RkJzZnpvQkVBbUsxWmVR?=
 =?utf-8?B?TjVJbStpVGpnYlBQaUFZVTRkSjZiYjNSUVpob2ZVUVRlTkdUVmZKRUEwQ25v?=
 =?utf-8?B?SEV5V1k0aFZ0dllZNkdETnFsd1NSMklWWktpS01JUHc3a2RnUnhraTBGY2ZP?=
 =?utf-8?B?dTZjS01LK2NrS0szTmkzdlVkbGF4TllmTnRjWVBINDE0OVdDbG9mWnRab3Rz?=
 =?utf-8?B?bTNwQk40WEw3M05ubkNnRnZnaDNZK09RZGZTSllxNjB0bC8rNm1UTngyNUM2?=
 =?utf-8?B?WSsxdVJNY1c0Y3c5QXFvSm9rWDlYbk9IMnl6Y1Z2ejFOT2JJZVJRMGZPVW9p?=
 =?utf-8?B?NmIrWk80U0pDOXd5RDZMOUI3NXFWNEV0UWF2aHVnLys3Q0dNa0lNV0RCUEhO?=
 =?utf-8?B?aGxYNDBqMy9TejN4RHpDNjRIdjE3emRoWDdtcnJ6SlNCcGRheUdyL05NQ25J?=
 =?utf-8?B?UzJGU0RpUEJjb3RWR3RlUUVZeFJxSVNBSjlYNGdDQjhFVzg2TTVoU0M3SEpj?=
 =?utf-8?B?ZHdyQkF4TGFYUkxjekY3ek5zSk1PdXI2bCtWNXVha3ltbGdTd0wreCtZbE1N?=
 =?utf-8?B?eHZMWk01RTNlVkRHZ3dlSEhtNFZEV0pGRDVMandOdkNYSnpkVWhSWFVCR015?=
 =?utf-8?B?U2w4dFhyTXd5dnBldkRGcHlHVWZBem03c1JKU0orUzhoR21LSnhNU3JvaFZR?=
 =?utf-8?B?cldCOU1Qam90RkpvSTlCZ3E3VjNyV3E1UldJajFzMHlRU1QxdmpRQ2k5L3pm?=
 =?utf-8?B?b3huSVV6bkFWNGt3Rmp4cmFSRlJ0TGt2Rk1QMkVsV2xrV0VDazl2SFBoVDhE?=
 =?utf-8?Q?a7lj0e9zEPq8Vno1J+SOj/Tz9wBVFqS6T0QbQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d9b51c-c0de-481e-a27f-08d8fe13740e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 00:31:17.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+Mr8IIhi1U4QNMoBdzLqgiZXmg8cTBzCcy47NXgOcSgyZw5YpcZlqZ72hC6WaiF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2157
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: jUyTu9Ke8JuokKpMO0bcPkOhkiUeSJli
X-Proofpoint-GUID: jUyTu9Ke8JuokKpMO0bcPkOhkiUeSJli
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/12/21 5:02 PM, Nick Desaulniers wrote:
> On Mon, Apr 12, 2021 at 4:58 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> On Mon, Apr 12, 2021 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> To build kernel with clang, people typically use
>>>    make -j60 LLVM=1 LLVM_IAS=1
>>> LLVM_IAS=1 is not required for non-LTO build but
>>> is required for LTO build. In my environment,
>>> I am always having LLVM_IAS=1 regardless of
>>> whether LTO is enabled or not.
>>>
>>> After kernel is build with clang, the following command
>>> can be used to build selftests with clang:
>>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>>
>> Thank you for the series Yonghong.  When I test the above command with
>> your series applied, I observe:
>> tools/include/tools/libc_compat.h:11:21: error: static declaration of
>> 'reallocarray' follows non-static declaration
>> static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
>>                      ^
>> /usr/include/stdlib.h:559:14: note: previous declaration is here
>> extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __size)
>>               ^
>> so perhaps the detection of
>> COMPAT_NEED_REALLOCARRAY/feature-reallocarray is incorrect?
> 
> Is this related to _DEFAULT_SOURCE vs _GNU_SOURCE.  via man 3 reallocarray:
>         reallocarray():
>             Since glibc 2.29:
>                 _DEFAULT_SOURCE
>             Glibc 2.28 and earlier:
>                 _GNU_SOURCE
> 

You can try the following patch to see whether it works or not.

diff --git a/tools/build/feature/test-reallocarray.c 
b/tools/build/feature/test-reallocarray.c
index 8f6743e31da7..500cdeca07a7 100644
--- a/tools/build/feature/test-reallocarray.c
+++ b/tools/build/feature/test-reallocarray.c
@@ -1,5 +1,5 @@
  // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
+#define _DEFAULT_SOURCE
  #include <stdlib.h>

  int main(void)
@@ -7,4 +7,4 @@ int main(void)
         return !!reallocarray(NULL, 1, 1);
  }

-#undef _GNU_SOURCE
+#undef _DEFAULT_SOURCE
[yhs@devbig003.ftw2 ~/work/bpf-next/tools/build]$

> $ cd tools/testing/selftests/bpf
> $ grep -rn _DEFAULT_SOURCE | wc -l
> 0
> $ grep -rn _GNU_SOURCE | wc -l
> 37
> $ ldd --version | head -n1
> ldd (Debian GLIBC 2.31-9+build1) 2.31
> 
