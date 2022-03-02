Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111284CB09E
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 22:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiCBVEk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 16:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiCBVEj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 16:04:39 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5F09FEE
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 13:03:55 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222JMpPP009036
        for <bpf@vger.kernel.org>; Wed, 2 Mar 2022 13:03:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=ZmaxZaPAEweVFP06MUaNTqeyC5Jh6/YfWWIG2PKA9kA=;
 b=gHTxBnsQ7OrRWqy/bMzlwxV6KE41ktxKOKYp/sHTysv9Gw525geS8XZWdxgfyuYH94NZ
 oW4VxK67nXPczCPzhBql38F7HTRM67TX0l6TQE09L/0ibwkiXTvRX1Un+AnAl9XkNH4f
 lkwtslTKn/jYdh48pYTTzfBG8reS4fBT21g= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ej6n05y8r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 13:03:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ml+MnZ3zaYCQMrLG5Ie8icQ+H2Esp/6cCIwn9THtQx/ch1sOXtCcJK8X/m1EEz7f1WadqIQohoMEh7fcMbIwLOd0aoBVh1ekdrMPsU3fOZGzjL+TkWqxNQriyUp2HyZKUONgN4pDKAAwcXEcoUEhJAXsjs8ZqC9Ri/CFn+R0GF8ti/a16tVevA0M/k1enq4yygGWNGw94MeBYdKJahFXyZDA5nq3xTiu+pc9/RwiVHixXCVQMPTu4ZjE9rmzipVv/EPx7vuMAJctRYmQxzniWnrPQq+rmI8eG5dMDntXCQSHEG/byPy4C8UqTsH1P5H9O5gUA+nJ59L1Tzannb+kzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmaxZaPAEweVFP06MUaNTqeyC5Jh6/YfWWIG2PKA9kA=;
 b=PInexB6c79siutEW5+nifcA4nhlSByOh/Wm9qu4ctP84mCPbzotchhjZjYrWYoqp0BA2A4nyI2rBTNmHxg5wlmIJMQFc3O9F2rSgyfHfD4Yvb0xAIJEW93tQ8Mx2/wmMfU2lQKZmnQ35+WppjLupDaTzwy9OAnqDHfsF19PzH1XdOCJV5NcwA/9j4xWQlb05L8iIHLY3Diu8CY9k9NFOUdA7IP7fkRWLgcj7Ln+bfa8pP2iG5QCWqyCydko28OaEgbPCyMWX9OOzoPUGh/z8PDdJpcCRUL1XkoKYbpge2k2NCAk3RjruqtXyxVU3VAQiAHjO4X4CLQ+pV0FVkUzAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by BN8PR15MB2596.namprd15.prod.outlook.com (2603:10b6:408:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 21:03:51 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def%4]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 21:03:51 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Topic: [PATCH v2 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Index: AQHYLR4RBLwtGeD2UUGO+Hs99fhZfayrkScAgAEGpAA=
Date:   Wed, 2 Mar 2022 21:03:51 +0000
Message-ID: <8AD6BCF4-22EE-49C0-A459-24A805AFF0B5@fb.com>
References: <20220301033907.902728-1-mykolal@fb.com>
 <145b59c3-27d4-fc4c-82aa-e7294ace896c@fb.com>
In-Reply-To: <145b59c3-27d4-fc4c-82aa-e7294ace896c@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 733ac1f8-0cd0-4dac-efcc-08d9fc90273b
x-ms-traffictypediagnostic: BN8PR15MB2596:EE_
x-microsoft-antispam-prvs: <BN8PR15MB2596600462CCFC5F99883BB0C0039@BN8PR15MB2596.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hLGxtC0AmG9CEqBA9ZosYiZyJql2Zb1Nx81PPIpWrz5OjDWG7DPlef7Vx50FYS+PZUrFu0H2YFtJf6X7Oo9aOgYpBP2QHv2TmXY71+SCHFW0kYIUvC8Sg7tjBQ7mwFdNKKgEcaZPMJ7OarHKN7jPllE9uhXHSrZLfTyMaOvSRaJqSeRxZcAdCg60LgHRuXmZBXzdp00XL9rqso5SM4ipl6YcAc9qH/BA+Lc7hRpdD5amtLORDxLR3oMFDSmteOqmR4r4O5UOtv9HCVJJ4TI6YF7VADfIL18P/u1I1OsMbrKogf7I8ffqQB90nk6j8TQqCJIp9bvaRd0dNf7jWe8AMi65l4RKyv74esgmZX7sPG+XklQC0+XY/cE28a/AD3WbK7KpRvn3rB0yVBYLJ/oavd9sQ6G+09G12G1LS94Bc+ZzWvIdUDGFxJZbyLFj6Lrm4tOOJNy0/+hsIYJR6tzeOd4lhfir3XZ95dgT3Ihdtr/pbQ+53W8rNWXx9kV31AarP5fHl5JgMRKa5S3mmab4d89E5yna6VzVW/VQPwS+KwW7fCBDBZCExuX3ENwTXIQy0aDPcN2YylObY2rdvtGKAgxKJ77BHUcit2FLNHoQkU3apqwg0IcWGo/gU4WDgoyWrla1sHUCRG2p3MBv5WFunDx2DiMVTLUfo/ilaHbX6GJU2hn+WMSXQOpLiIJK7dOUP6bZixHUr25nEPPWVmsDyu9zDco7+XymMCF+sNmV7Igc2qOSz2vYnWun+C7Diuvp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(6636002)(6486002)(36756003)(71200400001)(53546011)(54906003)(508600001)(33656002)(8676002)(64756008)(66446008)(83380400001)(316002)(37006003)(76116006)(6862004)(66946007)(66476007)(66556008)(4326008)(5660300002)(8936002)(38070700005)(2906002)(122000001)(86362001)(186003)(2616005)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?16PfPaoXcGvKYLWZKRQvuHPhbw/AoBn4qNuO3TGXy+H22hH4P0J/7+8o1A36?=
 =?us-ascii?Q?+8b9Wg5AYX52WFa6nDDgxassD0v8f40Lg3KzHdNXyJMmWCFAMjLCCeyUEhKk?=
 =?us-ascii?Q?2rMXuwSjeTnWljsAaGV1BqH8IWR/BTiPenxDtiBR2+iY1K2AxSo6K7B7o1bz?=
 =?us-ascii?Q?Ln/0XjcqO6O/ssIsKxbxHVA8pNGHXDLZvc15MbIYNNelwxdylannDNookRV+?=
 =?us-ascii?Q?+K2kqFfSmM8u7w+6r46B4isYTyAVIfMLIKhlgIRzk/gw2QH+qk0CO038aahS?=
 =?us-ascii?Q?pIMrr9JxhfgDu3tRXAm35MUR1UV+E0ByUgFzwHXC8r8SipUsB5brz0s9oW8y?=
 =?us-ascii?Q?iXlhXnwV60KUgFMg1u2RD/cmO8sn7o4pp4aqY3Xc+xT6NkEwl2IOr9ZbLztw?=
 =?us-ascii?Q?TogOmOqDu7jIolVuX0roOBLhLSM40JVjxG+gNSPEEgiYH1+Dms6n9cu3aF13?=
 =?us-ascii?Q?SJkKldD1a3J5ZDjgR+IgijcWlzpGjXj6V4TLLJZNLZKNy27YbjCRGsz+t1iG?=
 =?us-ascii?Q?bC8jlBaCNNNx0YXwQHQZz3tFRLPg50OcdUrvvjhvm3wHU2nVcbTGFzEV77EL?=
 =?us-ascii?Q?Dk1liAadjNfb3KUz+wYSmiW6jl4/M7iR8lqZS/cXn4plXOjBZYGCDP+PlwyK?=
 =?us-ascii?Q?v1D5GLhJo643rdb7fz9z1qMre9tuwDjTbhsKxAo8ggL/Xyjt2kI5Q8AdA+GT?=
 =?us-ascii?Q?CGUystHi7cKsYGZDBU0qFjJsyCY0o9JYLjbucEiV7puANnON8U/+PE6c1ra7?=
 =?us-ascii?Q?C8QAuKnYQrUF/KvKTQLqM/edJ3YEVaXVODoKchi6KwDb3jCufe1SJi41W5Us?=
 =?us-ascii?Q?nfCGunx5gf1OwuvaIgj5W6Z5fEYSpn5Y5m/jxHXfqhLZbaSNvIh+Tyn8+Fc5?=
 =?us-ascii?Q?nOONgnS3tj4S7zvDhE5fNzu+pdIoiT01maqHY7+5VQw0i9mRU1Vtw7c5LeFN?=
 =?us-ascii?Q?DirNUB6sf2wzUV/VDOgSlvaEdTtHqntrAt+qjwbaEDJvCXS2SVR0rqvTmKgW?=
 =?us-ascii?Q?8B1MLmO9XcnyDaMrVdt0LJkH+biB/UzWUp1v+AiG4i4C+IsO6+n8S+z9Kima?=
 =?us-ascii?Q?E5DamHnd5ge3KMHCVj6Y7yR79cozgIYaDRUXpOZLAg+QmozJVPlunfmdlp2H?=
 =?us-ascii?Q?KRJUbSXDkc8bOKWxvU50UVWGz47D9uvU68DFixYQIRwhWLmYCJJoSPoyOKQi?=
 =?us-ascii?Q?ZPvo1/M8ab/7RwScmjqGUMHxFY6tN+l5NkStSB8axXMppSOPOlj64wPFq81U?=
 =?us-ascii?Q?6WzxHiLW9zg1UYWVCIckqxrzOs/6JTyZ6QiTc3HmbhwoHPA65IQ3Q3q5k99L?=
 =?us-ascii?Q?9xt4YQ3gL5rBLsJpsUL3vRjriY824sZ9XKFMZK4etBZQu055dic2ltzHo7jN?=
 =?us-ascii?Q?B/EtwipFHkgGq/4qsgswN/UE/3EmWfvLqy3OtNxqHZzo/TKvUl963ctIwQ3R?=
 =?us-ascii?Q?rO83fyYne50EckOs2EzRLRIuJ075lHpRJ06KxHiURxjE6OBDCIw8/mJRifC3?=
 =?us-ascii?Q?p7VWozzccqS9yZdw+xdmb+W+JYveRzifb6jCe+N0YXInOV5WX5CPeaAG7PZz?=
 =?us-ascii?Q?yGxJ56zdtcpiouHsJTwQ9fLhif+SuZKll+FwvnMj3ylKn7g2NJRNGwRsJvqi?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA2E8D1B74FBCA489058E08E6DB6AFB6@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733ac1f8-0cd0-4dac-efcc-08d9fc90273b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 21:03:51.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0+8KYORGsP+fCUX2phI3sxlK/udnBsXMTM9Eu5w5U+UCZLoeaDccKhLriK6cszO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2596
X-Proofpoint-ORIG-GUID: 6-G_-YrzxWsQHSc9ZdPoGi1SRKYzCVuD
X-Proofpoint-GUID: 6-G_-YrzxWsQHSc9ZdPoGi1SRKYzCVuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020087
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 1, 2022, at 9:23 PM, Yonghong Song <yhs@fb.com> wrote:
> 
> 
> 
> On 2/28/22 7:39 PM, Mykola Lysenko wrote:
>> In send_signal, replace sleep with dummy cpu intensive computation
>> to increase probability of child process being scheduled. Add few
>> more asserts.
>> In find_vma, reduce sample_freq as higher values may be rejected in
>> some qemu setups, remove usleep and increase length of cpu intensive
>> computation.
>> In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
>> higher values may be rejected in some qemu setups
>> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> 
> LGTM with a few nits below.
> 
> Acked-by: Yonghong Song <yhs@fb.com>

Thanks for the review!

> 
>> ---
>>  .../selftests/bpf/prog_tests/bpf_cookie.c       |  2 +-
>>  .../testing/selftests/bpf/prog_tests/find_vma.c | 13 ++++++++++---
>>  .../selftests/bpf/prog_tests/perf_branches.c    |  4 ++--
>>  .../selftests/bpf/prog_tests/perf_link.c        |  2 +-
>>  .../selftests/bpf/prog_tests/send_signal.c      | 17 ++++++++++-------
>>  .../selftests/bpf/progs/test_send_signal_kern.c |  2 +-
>>  6 files changed, 25 insertions(+), 15 deletions(-)
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>> index cd10df6cd0fc..0612e79a9281 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>> @@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>>  	attr.type = PERF_TYPE_SOFTWARE;
>>  	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>>  	attr.freq = 1;
>> -	attr.sample_freq = 4000;
>> +	attr.sample_freq = 1000;
>>  	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>  	if (!ASSERT_GE(pfd, 0, "perf_fd"))
>>  		goto cleanup;
>> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>> index b74b3c0c555a..a0b68381cd79 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>> @@ -30,12 +30,20 @@ static int open_pe(void)
>>  	attr.type = PERF_TYPE_HARDWARE;
>>  	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>  	attr.freq = 1;
>> -	attr.sample_freq = 4000;
>> +	attr.sample_freq = 1000;
>>  	pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
>>    	return pfd >= 0 ? pfd : -errno;
>>  }
>>  +static bool find_vma_pe_condition(struct find_vma *skel)
>> +{
>> +	return skel->bss->found_vm_exec != 1 ||
> 
> In test_and_reset_skel(), we have following codes for reset/default values:
>        skel->bss->found_vm_exec = 0;
>        skel->data->find_addr_ret = -1;
>        skel->data->find_zero_ret = -1;
>        skel->bss->d_iname[0] = 0;
> 
> I think we should stick to them, so it would be good
> to change
> 	skel->bss->found_vm_exec != 1
> to
> 	skel->bss->found_vm_exec == 0
> 
>> +		skel->data->find_addr_ret == -1 ||
>> +		skel->data->find_zero_ret != 0 ||
> 
> Change
> 	skel->data->find_zero_ret != 0
> to
> 	skel->data->find_zero_ret == -1
> 
> The bpf program may set skel->data->find_zero_ret to
> -ENOENT (-2)  or -EBUSY (-16) in which case we should
> stop the iteration.

Debugged this test a bit more, and it seems we should continue iterating when -16 is returned, as it converges to 0 eventually and test passes.

Will you be ok to add check that find_zero_ret == -1 or == -16?

> 
>> +		skel->bss->d_iname[0] == 0;
>> +}
>> +
>>  static void test_find_vma_pe(struct find_vma *skel)
>>  {
>>  	struct bpf_link *link = NULL;
>> @@ -57,7 +65,7 @@ static void test_find_vma_pe(struct find_vma *skel)
>>  	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>>  		goto cleanup;
>>  -	for (i = 0; i < 1000000; ++i)
>> +	for (i = 0; i < 1000000000 && find_vma_pe_condition(skel); ++i)
>>  		++j;
>>    	test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */);
>> @@ -108,7 +116,6 @@ void serial_test_find_vma(void)
>>  	skel->bss->addr = (__u64)(uintptr_t)test_find_vma_pe;
>>    	test_find_vma_pe(skel);
>> -	usleep(100000); /* allow the irq_work to finish */
>>  	test_find_vma_kprobe(skel);
>>    	find_vma__destroy(skel);
>> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
>> index 12c4f45cee1a..bc24f83339d6 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
>> @@ -110,7 +110,7 @@ static void test_perf_branches_hw(void)
>>  	attr.type = PERF_TYPE_HARDWARE;
>>  	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>  	attr.freq = 1;
>> -	attr.sample_freq = 4000;
>> +	attr.sample_freq = 1000;
>>  	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
>>  	attr.branch_sample_type = PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_ANY;
>>  	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>> @@ -151,7 +151,7 @@ static void test_perf_branches_no_hw(void)
>>  	attr.type = PERF_TYPE_SOFTWARE;
>>  	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>>  	attr.freq = 1;
>> -	attr.sample_freq = 4000;
>> +	attr.sample_freq = 1000;
>>  	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>  	if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
>>  		return;
>> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
>> index ede07344f264..224eba6fef2e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
>> @@ -39,7 +39,7 @@ void serial_test_perf_link(void)
>>  	attr.type = PERF_TYPE_SOFTWARE;
>>  	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>>  	attr.freq = 1;
>> -	attr.sample_freq = 4000;
>> +	attr.sample_freq = 1000;
>>  	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>  	if (!ASSERT_GE(pfd, 0, "perf_fd"))
>>  		goto cleanup;
>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> index 776916b61c40..b1b574c7016a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> @@ -4,11 +4,11 @@
>>  #include <sys/resource.h>
>>  #include "test_send_signal_kern.skel.h"
>>  -int sigusr1_received = 0;
>> +static int sigusr1_received;
>>    static void sigusr1_handler(int signum)
>>  {
>> -	sigusr1_received++;
>> +	sigusr1_received = 1;
>>  }
>>    static void test_send_signal_common(struct perf_event_attr *attr,
>> @@ -40,9 +40,10 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>    	if (pid == 0) {
>>  		int old_prio;
>> +		volatile int volatile_variable = 0;
> 
> I think it is okay to use variable 'j' to be consistent with other
> similar codes in selftests.

Sounds good

> 
>>    		/* install signal handler and notify parent */
>> -		signal(SIGUSR1, sigusr1_handler);
>> +		ASSERT_NEQ(signal(SIGUSR1, sigusr1_handler), SIG_ERR, "signal");
>>    		close(pipe_c2p[0]); /* close read */
>>  		close(pipe_p2c[1]); /* close write */
>> @@ -63,9 +64,11 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>  		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>>    		/* wait a little for signal handler */
>> -		sleep(1);
>> +		for (int i = 0; i < 100000000 && !sigusr1_received; i++)
>> +			volatile_variable /= i + 1;
>>    		buf[0] = sigusr1_received ? '2' : '0';
>> +		ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
>>  		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
>>    		/* wait for parent notification and exit */
> [...]

