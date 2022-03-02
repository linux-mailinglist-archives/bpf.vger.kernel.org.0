Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D33F4CB113
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 22:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbiCBVP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 16:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245288AbiCBVPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 16:15:15 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C1CA996C
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 13:13:17 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 222JMoKr020385
        for <bpf@vger.kernel.org>; Wed, 2 Mar 2022 13:12:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=EdPrFAPZCUst1MWOKeWgLneR6HsoH7n2draIv/3bA1w=;
 b=Tcq3OKNGYk3ZbS+eIWy0HM+PhSigtQs8aX3wsGaKYS5MW7IJDFD67mOELXPvJKxnb7pO
 YAlgzDQs8OlxF0rtR7bVK9t8k5IcpoVaiPidLE3m2pS5PKctzNDYqg1yqIcl0PzVaUTY
 k6Ol7PlbthKNwpm+u56JO8YCq5xePExGCSA= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by m0089730.ppops.net (PPS) with ESMTPS id 3eja5su6cv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 13:12:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXx6Gb0n+gNPL+vW7QpyGsw5sVmL8yA1O84gPkK4MvrTaHfCpGF/ubaH0gM0wNhpGeJ8bza4JpHRKRNqcH5d/ZKcJ3FhzWMFctHPBKhWXQ+7TjxLlO94PNHT0swWOtc3/qlIUq32WhaMB5jNQ4hRbfxTp8wsZdNCj+PFY0FJgzztjQMQQye+JhvYKag7uFRqSmoJ0trLpVYJGxAXtAVVPafE6Nrq3zu2Him9NGAV61pZShs/Zrj7+ExSx62rlngu3MTLLiSrhtUqXRu7YzwimnARcF3ysaSBiAKB0IuBb9F81dKTZAZaLg20kiNbt1AOmnmNl9YQYkoDyCCZZOscUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdPrFAPZCUst1MWOKeWgLneR6HsoH7n2draIv/3bA1w=;
 b=kXe7pdaMK05eMDWoW3PHhL9DDxH5OemrUM/FmRv6CtEsWffYg/96LB6fIjELFfVz6OOOtIUqn6M8DymM49ntPqnb3nRtCWC+7DHkS96mZEw9q6H2l1/iQ2uasCJXyAHjMdqKiTT6hGUORuYPVisT4OUcmmMgILkfz8fgjHyQ3XBDs5175CSuCeJF/1hXW9ftobOn9oG+gCKFKQh+8CE6qxxP+AKpLDLu2w6rSTmc7o7tF5wjDpJfmF30MpnxWURLsGadbZsDotSMMvGVDW1nOo/zxAESdja1vgjoa16dSYD7DETJUvjrYYJ5zxUEQjIc+bQiaGt8HvI60baMjo/A6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by DM5PR15MB1737.namprd15.prod.outlook.com (2603:10b6:4:51::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 21:12:52 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def%4]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 21:12:52 +0000
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
Thread-Index: AQHYLR4RBLwtGeD2UUGO+Hs99fhZfayrkScAgAEGpACAAAKGAA==
Date:   Wed, 2 Mar 2022 21:12:52 +0000
Message-ID: <02CF0AF0-4582-493B-8488-CA043E071486@fb.com>
References: <20220301033907.902728-1-mykolal@fb.com>
 <145b59c3-27d4-fc4c-82aa-e7294ace896c@fb.com>
 <8AD6BCF4-22EE-49C0-A459-24A805AFF0B5@fb.com>
In-Reply-To: <8AD6BCF4-22EE-49C0-A459-24A805AFF0B5@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d835400c-dcf8-4d20-a47c-08d9fc9169f8
x-ms-traffictypediagnostic: DM5PR15MB1737:EE_
x-microsoft-antispam-prvs: <DM5PR15MB173752F75411FC62E69678F1C0039@DM5PR15MB1737.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S+/FXHQyRAxKCyLWw0eaOQIn6fCcoFILlfRddyuSM8+oTpw67+RUz0GKfeLeCtCadSoe0bZwNHzGiVKEkPhgztdPKnraZ0tCQi5BwyqvohRL/Glfys174xSPLkjjx3R47UasUrXn6/qTrSEo92SpK67RLclpcKeZa6NLEw4+jrGCUliGzpstRS29ux2eVKeJz2k46S3NZza7xw0YkrN6x0F3t0wmqsGRKeZhdkjWoxzIu9n4dswzlXzfe0x88Ks+zT8BqeoUryW11RTWN22QhSQDsRhcUPvlk2mcPahr34SnevoLYJ2RBZATICi7UPTg6bSanL+XY0t8/UtMUAv3+rVjHuGa05ws0ABwKlx6gj+PmgaI01PVJAx3BaZnJjxMW4mRiWmUzoiCg4+Q+pJ9FHSffQf8zgP0thm39PvusemG588EOY5nvFwjjgYsT0XxDjfI3tDxDbC4BoaupLReqkEIv30+d4cU6tysUpU3Yalgc2U8CvwDQ3Fc9kGJ7s6hAHfTKuEPutrNwJKC8Ze+sTa04u+TNkbM9+ptmPOuscIz882r+F3bRk8Hz0NEEinW3MCs8OKDy4nklaHQhjO63UGLa66C8Va/MhLJX5uNI1Avp+t+pJ5ueSSF5E4ppV/JWJ7wTY/gyGcseYeKZJgpxOojn1oL6rV1J8h+/O7Dx3MHMD/pOoWUQ8FfJmKh/36W6+8Ncc3h6I9lA7Y0JSlvUMBvyLoDDv7L0Xjj/NySPul9ygaKpWVJIW+Nk1V3Ne+W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(38070700005)(66556008)(38100700002)(2616005)(186003)(54906003)(316002)(36756003)(6636002)(71200400001)(37006003)(83380400001)(6512007)(86362001)(53546011)(508600001)(6506007)(122000001)(6862004)(5660300002)(8936002)(76116006)(4326008)(8676002)(6486002)(2906002)(66446008)(66946007)(64756008)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wU7nqGyihLXkk3oiLpOKTCjgfw9JxjoPYTZaCRbU6wLN2yohq++bl34HlRf7?=
 =?us-ascii?Q?2M4+o28vHJMLJEbwLvJ0cTqFs2CM9pS3r8Dy5wHjZn6SEt35v40d/sVeKPtW?=
 =?us-ascii?Q?DE16KdqtjYujNsKFznOQwzO2NXTGDsX1zg4EUl3fc07/Egi5OaSEvm6UA+wr?=
 =?us-ascii?Q?B5Bz/A81bijbFUMS0noxRaJxkSrwYARvjpmMQ1on+gix6umXbPbX5ENjNJec?=
 =?us-ascii?Q?Q0t7kxuFW6R4MrO2spv6hU43A2qeIk5XNWFR3OGDw32ispyVePvU5y7MJEX3?=
 =?us-ascii?Q?SRUGzS/Hznl9e92yFkks8jfWqI44kg3aonC5AeudCxo/FfIkKGgSn2awqnLM?=
 =?us-ascii?Q?PN1nkcSbVV3g1x+uZJggviIIys7L17CoSor8uFDkF0peirzay/0Uz7Ln5Yi3?=
 =?us-ascii?Q?prZJSvxbopBj6h3M9FF8TOq6KqayjbQXODWnIpVAIWii/JlHUFq+LnF47n/5?=
 =?us-ascii?Q?UgOZktxj4jdLkqmm3uzHE2NkT6aH1H55wJ6e408a43fnr2jry8S7ySF1xclH?=
 =?us-ascii?Q?hB+94vxjv4xPs3RkBByHnpzwtfOJxYVT3ad4lj7CEwYxIn3Kgs+3mvQSUQqH?=
 =?us-ascii?Q?Zl/EGQzxAEZJNwEmTg8QcQXjs6mrpmSBqJf101UgyPGXgxFcPv+IVjsnMVTm?=
 =?us-ascii?Q?zoIzTWHthpGHGHREUTL6TtfMAFG8zW5T1gYXkEDucNThmeDCOY3VaErsE8Tz?=
 =?us-ascii?Q?3SFWz/Z7z0tIpbr1qerqOPWVJHXZTTUgKEAmUH+79QZEIe7C8Dj1pA3NwLzN?=
 =?us-ascii?Q?ScQTHDajDm9fa0Ra3uH4y1DlMwi8RsQxexhEK5Gndgq7oMSTVYSrXHb0sZox?=
 =?us-ascii?Q?YpJIsIbMK6Hye1jnJ7gcAF/ROMcBnU5GdF4zfzISJTEdiiFxZga9Wx5dv3mj?=
 =?us-ascii?Q?zP9Uj7R9W6f82CkU8TUnq+yN6HwfVHloB61DTvYDPWGvlmQAgmNH8z1mY5/s?=
 =?us-ascii?Q?uexTgt7X0dSabqUu2Oc3SMO8Mfd9+xUX8iWu4W17kOO9BOj/EDN3hCaPvY8/?=
 =?us-ascii?Q?5+HyqKlVoQ5JsX03GdPDpBbsHfVWP5jv0lixzSu7SCi9FWbwpBMAqvGDZakr?=
 =?us-ascii?Q?o9icZlIpIbBAL2ZbhQBIIlMYk8wTil7O8qQe8gLdUhT+963dtMBFt1SxoHyl?=
 =?us-ascii?Q?s32EO8/0jhgGueNOCv1J273SikVApz5ly6iOCqyBhBIoS7mtpxoudj7xghhh?=
 =?us-ascii?Q?MUGOYWwSfjBV6fQeerpH0jKzZMeCazI8wg4jYDVS/UTUaO5nbmY0B14qzP2k?=
 =?us-ascii?Q?KZEcrEthGcn8yU2yICWpkw8ItYi7c+ORZloNs6TOdmqyiJyQoT/blxwAXZ+c?=
 =?us-ascii?Q?8GJGyv4kI68Slit1d7625OpU1ovi3DesLJz2sqnd6IRXCevtS8LU2Mxtdr1i?=
 =?us-ascii?Q?n9IWIBBYqe7oDjyNQe4Sb9CAFeNjA5QIRw+U7ZLyjkhIYbT9eyblC9y6ig+L?=
 =?us-ascii?Q?YiTFYmI2Mx0dcKHbaiEthbFlRXm3r1DroWXNIlKLdHgxUiIBoX6+oCcNQOEk?=
 =?us-ascii?Q?DXbS06xZrF3uuQGTVlSoYFHYci457I5nV2eJ275MCZzamsh0fS+zf6ycYiAY?=
 =?us-ascii?Q?1UPmlc5uMeKgU7p9eTEAtX+OFZBmmefWUN4J6kTVBEoGFf2nMZLPDTZSEuNx?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D91C1E6959DFE489A960BAFF130752B@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d835400c-dcf8-4d20-a47c-08d9fc9169f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 21:12:52.6902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPs45ucIhxbJ1JBHldc5MD0AS3jJRL8IGKPxyVF6dvBq3asU5MxrLHzcznpfTlnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1737
X-Proofpoint-ORIG-GUID: vJKkf9cyY5vbHf5S8YHYWn1on0ewiN4h
X-Proofpoint-GUID: vJKkf9cyY5vbHf5S8YHYWn1on0ewiN4h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2203020088
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



> On Mar 2, 2022, at 1:03 PM, Mykola Lysenko <mykolal@fb.com> wrote:
> 
> 
> 
>> On Mar 1, 2022, at 9:23 PM, Yonghong Song <yhs@fb.com> wrote:
>> 
>> 
>> 
>> On 2/28/22 7:39 PM, Mykola Lysenko wrote:
>>> In send_signal, replace sleep with dummy cpu intensive computation
>>> to increase probability of child process being scheduled. Add few
>>> more asserts.
>>> In find_vma, reduce sample_freq as higher values may be rejected in
>>> some qemu setups, remove usleep and increase length of cpu intensive
>>> computation.
>>> In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
>>> higher values may be rejected in some qemu setups
>>> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
>> 
>> LGTM with a few nits below.
>> 
>> Acked-by: Yonghong Song <yhs@fb.com>
> 
> Thanks for the review!
> 
>> 
>>> ---
>>> .../selftests/bpf/prog_tests/bpf_cookie.c       |  2 +-
>>> .../testing/selftests/bpf/prog_tests/find_vma.c | 13 ++++++++++---
>>> .../selftests/bpf/prog_tests/perf_branches.c    |  4 ++--
>>> .../selftests/bpf/prog_tests/perf_link.c        |  2 +-
>>> .../selftests/bpf/prog_tests/send_signal.c      | 17 ++++++++++-------
>>> .../selftests/bpf/progs/test_send_signal_kern.c |  2 +-
>>> 6 files changed, 25 insertions(+), 15 deletions(-)
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>> index cd10df6cd0fc..0612e79a9281 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>> @@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>>> 	attr.type = PERF_TYPE_SOFTWARE;
>>> 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>>> 	attr.freq = 1;
>>> -	attr.sample_freq = 4000;
>>> +	attr.sample_freq = 1000;
>>> 	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>> 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
>>> 		goto cleanup;
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>> index b74b3c0c555a..a0b68381cd79 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>> @@ -30,12 +30,20 @@ static int open_pe(void)
>>> 	attr.type = PERF_TYPE_HARDWARE;
>>> 	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>> 	attr.freq = 1;
>>> -	attr.sample_freq = 4000;
>>> +	attr.sample_freq = 1000;
>>> 	pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
>>>   	return pfd >= 0 ? pfd : -errno;
>>> }
>>> +static bool find_vma_pe_condition(struct find_vma *skel)
>>> +{
>>> +	return skel->bss->found_vm_exec != 1 ||
>> 
>> In test_and_reset_skel(), we have following codes for reset/default values:
>>       skel->bss->found_vm_exec = 0;
>>       skel->data->find_addr_ret = -1;
>>       skel->data->find_zero_ret = -1;
>>       skel->bss->d_iname[0] = 0;
>> 
>> I think we should stick to them, so it would be good
>> to change
>> 	skel->bss->found_vm_exec != 1
>> to
>> 	skel->bss->found_vm_exec == 0
>> 
>>> +		skel->data->find_addr_ret == -1 ||
>>> +		skel->data->find_zero_ret != 0 ||
>> 
>> Change
>> 	skel->data->find_zero_ret != 0
>> to
>> 	skel->data->find_zero_ret == -1
>> 
>> The bpf program may set skel->data->find_zero_ret to
>> -ENOENT (-2)  or -EBUSY (-16) in which case we should
>> stop the iteration.
> 
> Debugged this test a bit more, and it seems we should continue iterating when -16 is returned, as it converges to 0 eventually and test passes.
> 
> Will you be ok to add check that find_zero_ret == -1 or == -16?

Correction, I read your comment incorrectly. Will do the change as you asked.

> 
>> 
>>> +		skel->bss->d_iname[0] == 0;
>>> +}
>>> +
>>> static void test_find_vma_pe(struct find_vma *skel)
>>> {
>>> 	struct bpf_link *link = NULL;
>>> @@ -57,7 +65,7 @@ static void test_find_vma_pe(struct find_vma *skel)
>>> 	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>>> 		goto cleanup;
>>> -	for (i = 0; i < 1000000; ++i)
>>> +	for (i = 0; i < 1000000000 && find_vma_pe_condition(skel); ++i)
>>> 		++j;
>>>   	test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */);
>>> @@ -108,7 +116,6 @@ void serial_test_find_vma(void)
>>> 	skel->bss->addr = (__u64)(uintptr_t)test_find_vma_pe;
>>>   	test_find_vma_pe(skel);
>>> -	usleep(100000); /* allow the irq_work to finish */
>>> 	test_find_vma_kprobe(skel);
>>>   	find_vma__destroy(skel);
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
>>> index 12c4f45cee1a..bc24f83339d6 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
>>> @@ -110,7 +110,7 @@ static void test_perf_branches_hw(void)
>>> 	attr.type = PERF_TYPE_HARDWARE;
>>> 	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>> 	attr.freq = 1;
>>> -	attr.sample_freq = 4000;
>>> +	attr.sample_freq = 1000;
>>> 	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
>>> 	attr.branch_sample_type = PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_ANY;
>>> 	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>> @@ -151,7 +151,7 @@ static void test_perf_branches_no_hw(void)
>>> 	attr.type = PERF_TYPE_SOFTWARE;
>>> 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>>> 	attr.freq = 1;
>>> -	attr.sample_freq = 4000;
>>> +	attr.sample_freq = 1000;
>>> 	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>> 	if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
>>> 		return;
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
>>> index ede07344f264..224eba6fef2e 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
>>> @@ -39,7 +39,7 @@ void serial_test_perf_link(void)
>>> 	attr.type = PERF_TYPE_SOFTWARE;
>>> 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>>> 	attr.freq = 1;
>>> -	attr.sample_freq = 4000;
>>> +	attr.sample_freq = 1000;
>>> 	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>> 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
>>> 		goto cleanup;
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>> index 776916b61c40..b1b574c7016a 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>> @@ -4,11 +4,11 @@
>>> #include <sys/resource.h>
>>> #include "test_send_signal_kern.skel.h"
>>> -int sigusr1_received = 0;
>>> +static int sigusr1_received;
>>>   static void sigusr1_handler(int signum)
>>> {
>>> -	sigusr1_received++;
>>> +	sigusr1_received = 1;
>>> }
>>>   static void test_send_signal_common(struct perf_event_attr *attr,
>>> @@ -40,9 +40,10 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>>   	if (pid == 0) {
>>> 		int old_prio;
>>> +		volatile int volatile_variable = 0;
>> 
>> I think it is okay to use variable 'j' to be consistent with other
>> similar codes in selftests.
> 
> Sounds good
> 
>> 
>>>   		/* install signal handler and notify parent */
>>> -		signal(SIGUSR1, sigusr1_handler);
>>> +		ASSERT_NEQ(signal(SIGUSR1, sigusr1_handler), SIG_ERR, "signal");
>>>   		close(pipe_c2p[0]); /* close read */
>>> 		close(pipe_p2c[1]); /* close write */
>>> @@ -63,9 +64,11 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>> 		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>>>   		/* wait a little for signal handler */
>>> -		sleep(1);
>>> +		for (int i = 0; i < 100000000 && !sigusr1_received; i++)
>>> +			volatile_variable /= i + 1;
>>>   		buf[0] = sigusr1_received ? '2' : '0';
>>> +		ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
>>> 		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
>>>   		/* wait for parent notification and exit */
>> [...]

