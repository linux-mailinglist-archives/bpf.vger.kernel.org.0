Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69632CF0B8
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 16:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgLDP3P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 10:29:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63188 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730378AbgLDP3O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 10:29:14 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4FF7uQ013704;
        Fri, 4 Dec 2020 07:28:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7cyNBZkpdrb8KUbDmfyi79423XWy/zoR3cAOSU1bKPw=;
 b=bqPlrEHEB6Z7G2NW3dkYQS922zn+xNwhxDwSQPsUkRUXg5pEccQzs4bhMDBJSdBw5JD0
 /U7bCx/s7UlVX1HMy85Uvbfp81iKmvmQDMBhaFgVfCq5ZIFxQkIl4r8/c2hwPBpwpntV
 xQqtUwxWNi+TclcqG13A4qBvPUSWe8SOjIQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35615fvpuv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Dec 2020 07:28:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Dec 2020 07:28:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3hJLtYi3/XTnWLwR3YCYP6wmjCa3oFMyyU7gHDKY4hRg1YPiXWFZKrZ7BLJtpK1hiqY4+KHeR4ir3n4+TWVpbl08837FUJwUZMGijyniuWF85kEpEVS8TVpkVjkGNiGQgBXxtMyihfqgBFo980GEbT4KBemL5+3OlE9gqo8iLr1oH8vD2QywNDKURymI085ww0044ZTcN1s66SMYklwGRpYQ16WOZjAp3EqoFOfmJ4KhLXjTBa7vaidHLfqrwCISNj3pGhnM+1c6udQO036Wz/jVOzV5Shmaatum/FRxpxHUNuEUXeRZbCycui57Zk46FKgFfB//0EZG1fRwUfl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cyNBZkpdrb8KUbDmfyi79423XWy/zoR3cAOSU1bKPw=;
 b=DWUPR3Ze0FKBCnabJ3Bb6KahcSgDSWJwYhiwarI99jLYSO4YRVi/vnH/ebgcz+QEYe0wokLHk/EF/HA3YQnBBsl+j0cv7dBo20lhLCmH8JNQRD3SGE/r99PeWjI/agqzoOzRFhmh+CUdPd3F/ZVNYX8ZVfvhOHdtTzTrqFRjK1EV+4+qogfpTjA5mS8hbooEWiB5hp22zyGF1qFuhRudvU9aIw5N7x6bm+gjoLMvqTR3D6Dn3azZUf9Mu/Y+hOz9D4chGfpi8CUCNFPCm44nvGUH4vvCyR224zTo4dx4i0yXlEAohOEtNQOd8hYw1WcyrSDBmbNL6i67UcImNTp+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cyNBZkpdrb8KUbDmfyi79423XWy/zoR3cAOSU1bKPw=;
 b=Qfp8VSuQITg6ng9onAzUShewnKoJH8DZAn7SO30rs14qT/pytap48erEI8ofmtf++FSz7ygOlkx6RQEbGshlxGp3NFLZZqeUfe/1mJoQOc7IBfXjE2q/rAMkU3maDLJVmuILCLkQI5ZnyaD5qihgHh4xjjEIggNL1JqeUfg6n3w=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2200.namprd15.prod.outlook.com (2603:10b6:a02:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 15:28:14 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 15:28:14 +0000
Subject: Re: [PATCH bpf-next v3 13/14] bpf: Add tests for new BPF atomic
 operations
To:     Brendan Jackman <jackmanb@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-14-jackmanb@google.com>
 <b629793c-fb9c-6ef5-e2d6-7acaf1d2fc7f@fb.com> <X8oFJW/mMFHVxngY@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <6f008322-0b8f-223a-9148-ce9fee0810dc@fb.com>
Date:   Fri, 4 Dec 2020 07:28:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <X8oFJW/mMFHVxngY@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:fab1]
X-ClientProxiedBy: SJ0PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::20) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:fab1) by SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend Transport; Fri, 4 Dec 2020 15:28:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 008baa23-fb47-4281-a5a8-08d89869372d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2200:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2200FC3917A93B345CB71BB2D3F10@BYAPR15MB2200.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYLOIVemeuR9frAKxNHYAie7WmQscG6xnZT8QZ2SDJZCwWHPwbyM0hfbwCCy9uPsuFsmP9JzMK7UbN1Tuo/bk0mehNWgcmNVD6oUjl5zr8w6cU3qAKa7WKoaXR4bwMqJD+vz7H7i+vJ6rcD6DsjS9/uXS+0S6V/VFhGit4SBjoMjhRKwPb+6cX4lgGwpm3WF3937dujeSz+WuSu9w/Io8RPGtJHEQMGHlNsMik3uKLFwMdnMF7hPOwY73IeHvBn/xXwIhRlK7QMEWYHNckP9WUgGG4vCkWONf0NVWe69+0I37KXEon/KMsCjtLElaq2xJyWi6N1VYv4G6ncNzgvBQAy/3VFW352kNUzhNSQQLpyQ0Mf9oN98haPppyzGUcza/0eP/SCrzZRoorA/Qiz0YcX5LcBELekdl4j3dG4g7z8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39860400002)(366004)(346002)(8676002)(2906002)(52116002)(54906003)(83380400001)(36756003)(6916009)(316002)(2616005)(6486002)(86362001)(4326008)(8936002)(5660300002)(66556008)(31686004)(53546011)(66476007)(186003)(66946007)(31696002)(478600001)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ek9UaWxzQlBScnRVVldXaklqY2lrbFRkRHpyVlZpWUtqUmFLZFMwYTZaZFV3?=
 =?utf-8?B?M2ZWdmVhSTcwSVdnSW1IS1I1WWx1M1M1Ynd2NmRValJsd01pUmQ5eW9uanh1?=
 =?utf-8?B?M21jendXNm9kcXZqeDkyZVFva1IxWnpGYktKaTRGd1NHZkV1Y1lPRG9xa3JD?=
 =?utf-8?B?RExwc1crVWR4MW5XUThVYldLdUxPVnNTeFVEMUoxMTRRalB6MkFycE0yRVFL?=
 =?utf-8?B?ZDNxWnZNc0F1ZmozK0lrM2NIaXhoUTAzSk9keFcwcjNtNkY1L0FxdGlVOUNl?=
 =?utf-8?B?ZmNXaU1DVnV3OW1vK0hzR0hWZHhHbHdUenhQT2RwT01pY3U3ZnFBRXF0SjFB?=
 =?utf-8?B?cjRzeUxIcmhiQXVocGtxU3k0eGoyaFdjZkRmWXNGMitVWjBlRTgvVkFjY2FL?=
 =?utf-8?B?MkZGcklWMnRMWDl0TW9hL2xpQ1ZOMzFwemxpQko2LzZxbGhwbkdma2M1d09Y?=
 =?utf-8?B?NG5VZGxzUzA1U1ZReHdWUnJ4RVJOaytYRHNPVVlNSks2cGhvejl3Z3pTUFlV?=
 =?utf-8?B?TnVCK01TcWlJTnpnTVNZekMwamttV0xTcHdEcnV2U0plK3JnRGZBNU5Lamky?=
 =?utf-8?B?UUxVc0lnOExmVlRMeFBMSkx2ZmFGbGVKNkxZTUM1eFhRNzFzd2pmblJ0UTc2?=
 =?utf-8?B?eDZ2eG1TcUE4OHlEek80SEowUndRM1g2UEJjNnZRSUhiYlA2V1hOQnVvdVlM?=
 =?utf-8?B?NzBLMlc0K1RnZng1bG5zSWlYaVh3am5RVXptUi9neU1obXFBYmt5dEk4dGFn?=
 =?utf-8?B?d08vVVloamJ0OHBkcGp2NTBSK3hNcENlcnVYUW5jam13ejVObk4wNmM5SEVG?=
 =?utf-8?B?Myt0b1FqeG1lMzd5K2tKWkc3enJxWit1eXlxeDRlWWJreW5ML3Ywend1cGsx?=
 =?utf-8?B?eUVwZzllUUI1OGowUXFubCsrRmdTSFArcDRTM1UrK3MvQ25rcjAyL0tiaVJ0?=
 =?utf-8?B?aENuZzVmOGlBazdibjlQc0R4K0hUTFRRYVhlYmdFZFR6bFNiS0ZBWS9Pekxl?=
 =?utf-8?B?RGFYR1pzOGo5ZzNJN1NEaFV5ZkN3SVZOZ1plY2x5TUFmelR5OWdzRmU1OC92?=
 =?utf-8?B?dThVTk1xTkpZbUN1NE5ZbXRPak1GWWFOZGRCdzZ3NDZYbXhvNDJxVWNPU05B?=
 =?utf-8?B?bmtiTGJQcFN0VVErTFk5bmlFWnRtYmZSajMzRU5tb1dQUEZFa3I3NEtRdllr?=
 =?utf-8?B?a25jeUFtZkNvZmJjbXM0bkVSY254aDhiN0U4Nnl5SDZuOFR6MnA5MmxQTGxm?=
 =?utf-8?B?ZXVtNE1oYXF2N2ZjcmduNjNPTkt6MzhiVnlkV2ttVHFpSVBOcGdpeWlIWDI5?=
 =?utf-8?B?WnNuZTVqZ1NZMEZMRjBzSGdLKzJqeExwMUVmcEszQllLUmJ6Wlgzamsybmk1?=
 =?utf-8?B?OWM2NW93QlNydmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 008baa23-fb47-4281-a5a8-08d89869372d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 15:28:13.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAZQgGwvCb6l9cl9U1b8f793EfsU3zsPQ0hDJ7nM/gWn5S46qquvSTtTfc2G0NgG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2200
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_05:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012040089
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/4/20 1:45 AM, Brendan Jackman wrote:
> On Thu, Dec 03, 2020 at 11:06:31PM -0800, Yonghong Song wrote:
>> On 12/3/20 8:02 AM, Brendan Jackman wrote:
> [...]
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
>>> new file mode 100644
>>> index 000000000000..66f0ccf4f4ec
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
>>> @@ -0,0 +1,262 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <test_progs.h>
>>> +
>>> +
>>> +#include "atomics_test.skel.h"
>>> +
>>> +static struct atomics_test *setup(void)
>>> +{
>>> +	struct atomics_test *atomics_skel;
>>> +	__u32 duration = 0, err;
>>> +
>>> +	atomics_skel = atomics_test__open_and_load();
>>> +	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
>>> +		return NULL;
>>> +
>>> +	if (atomics_skel->data->skip_tests) {
>>> +		printf("%s:SKIP:no ENABLE_ATOMICS_TEST (missing Clang BPF atomics support)",
>>> +		       __func__);
>>> +		test__skip();
>>> +		goto err;
>>> +	}
>>> +
>>> +	err = atomics_test__attach(atomics_skel);
>>> +	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
>>> +		goto err;
>>> +
>>> +	return atomics_skel;
>>> +
>>> +err:
>>> +	atomics_test__destroy(atomics_skel);
>>> +	return NULL;
>>> +}
>>> +
>>> +static void test_add(void)
>>> +{
>>> +	struct atomics_test *atomics_skel;
>>> +	int err, prog_fd;
>>> +	__u32 duration = 0, retval;
>>> +
>>> +	atomics_skel = setup();
>>
>> When running the test, I observed a noticeable delay between skel load and
>> skel attach. The reason is the bpf program object file contains
>> multiple programs and the above setup() tries to do attachment
>> for ALL programs but actually below only "add" program is tested.
>> This will unnecessarily increase test_progs running time.
>>
>> The best is for setup() here only load and attach program "add".
>> The libbpf API bpf_program__set_autoload() can set a particular
>> program not autoload. You can call attach function explicitly
>> for one specific program. This should be able to reduce test
>> running time.
> 
> Interesting, thanks a lot - I'll try this out next week. Maybe we can
> actually load all the progs once at the beginning (i.e. in

If you have subtest, people expects subtest can be individual runable.
This will complicate your logic.

> test_atomics_test) then attach/detch each prog individually as needed...
> Sorry, I haven't got much of a grip on libbpf yet.

One alternative is not to do subtests. There is nothing run to have
just one bpf program instead of many. This way, you load all and attach
once, then do all the test verification.
