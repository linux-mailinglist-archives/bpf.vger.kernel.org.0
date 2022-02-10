Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B494B07DC
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 09:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbiBJILT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 03:11:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiBJILT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 03:11:19 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79478109D
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 00:11:20 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219NYEst007042;
        Thu, 10 Feb 2022 00:11:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fuVzZrlVbWXE1MJjHMUKBweoY98rGu8Nnm2zLyzhJ8I=;
 b=rC2V5QMZ3X7M4WD8svpO8pBkhmnJp3ZyYpADo+WpzGvYCP4kvBz+dVOMQS+Uhxr5FKdO
 9BX3gpCY0ORSBTjUsDK0OWgY6f8dEynoSLel+Z9u0VvPOwwC9VmmnJTwjyv1Gr2TR3r6
 q0Wb5E0vk26fQNjw5SZsSfCUGcNmmNnLTBw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e4fxawm6n-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 00:11:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 00:11:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG3+arUJief1RBQe1ptyxNFrj5TYsT1p2dVa+QhvXgh7zqa4MnC3p4lnLWPbPukpnjuiA8EHxRiBqF53Wye2f+ymbnAHXfdgG8JMaJDLaxHuSeD33VlWl3aINLIlrVjCAUporI32reJIEqR4vWZ3uI0nEHd8PhWOAIiuqvpYQeVwGfX0wEAASuoFT+JL/D/0F+VIr2CB4PO5IAcBPDxRKnbzMqphu3w3xi2gbSJy080OetqH7H/q0Ln7fGnigpQMJ1+jJPZ0o7wk4PbSLHwQE+6mXwuYeIhDpk88uwYtqCAoo1HZe3Js73sjJEERuBrdwjJkQn16m0RcgNf2lhpBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuVzZrlVbWXE1MJjHMUKBweoY98rGu8Nnm2zLyzhJ8I=;
 b=d/KysYCB2f3kVZJlEwizbbbRpt+XLvnfBOg47ncF6jYnLYREr9TvPwgVKFbJms+Hrdg1PLzKV7kvIut81eS4PnykHJjMPHOl71HXmLjd8sn5s5lQ5vRD9qP1IchosqdUh+R5ztAVNbhxuUDAjG/P8XHVakq64oP3muiZPMvC6qYGDSQYtF2/TMcGFXXbZaXg1fOps9ReJtDAY7Ee/nSMdX/AlLncsydtpeFOIvJfMUspu5AAmv4PcumELz8bZK9fNTuRb/yFkfn+TiO17V2ETAkGTqG108K3cxr4pDa5OzO9bVOMo8KGQAWsdgEW2NEilxWe3Fh9RjTXcxAWY2mQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN7PR15MB2194.namprd15.prod.outlook.com (2603:10b6:406:81::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 08:11:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:11:00 +0000
Message-ID: <e8fc8bd2-a775-6c39-74eb-b33ec6e9ca94@fb.com>
Date:   Thu, 10 Feb 2022 00:10:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test for bpf_timer
 overwriting crash
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20220209070324.1093182-1-memxor@gmail.com>
 <20220209070324.1093182-3-memxor@gmail.com>
 <20220209200325.ipydl7jsrwiugujn@apollo.legion>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220209200325.ipydl7jsrwiugujn@apollo.legion>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:303:8d::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb73c88c-588d-4984-11b1-08d9ec6cdf6d
X-MS-TrafficTypeDiagnostic: BN7PR15MB2194:EE_
X-Microsoft-Antispam-PRVS: <BN7PR15MB2194144AC4869A5C532032CED32F9@BN7PR15MB2194.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZUWGi5+pWxHpkokhsHKnGQ5IOLZtM5nk9KnyTAXW4wcDeEmiR6sJ0zhSJv8m7K8uO0beYSVtaL0OKwGsrAt5MmYW6fMcmJ+7baZEJaT/CrM7tVGeAk1vcUpBEed3ki2e4iT2l3nOKFcZcujAFJ5D4mbuWsBzkTfgUH1gk75wHE0jAPVv8Kj8yOpTq9S46KrheVdXxNbGjBsI7wScN3JnjFuTQ0PrcIEc7HnqYTBTYE7JaGiGEYDhbpYzlnxqkUv4/36NhwmYFG/RryHXKqmODhP1kfpW07KwzbjgE6cY1IBC1DgWEcMNEI7lq+rDmofIulh/RCDhJSSaZL4kbPb0/9CM4wbH5LNrkSrgSOe7P7Gn++pTFULYB5cArGqRF5xLVZtOw0Ka9AvBWiO+pJHuG6O9wNzhkUGhBxo+/c0swJlZIZGkYll/k+rAZ3l/njl7x/jS/uAevN23cjLZOKlffZqEcyV8uvdTQLS1Rn/n9l60NsduqOm9wMbiZo3xeUj93c4ar27GTSXPd5iFAugRLDUBYpwo0STfYx/XKvLcFtIkpGGUrs/r1lGscAmRe74le0jcaD0+qfxg7mdLm1+qcuvVbfyOA1lTh8pN8QuhotMc95PqcIeJ1GjVIgXH12bHn8XAapP3QWEK9U0XNTAT1bIN7UIs61au0vWuURjuYfdoVTc1Su1aI6U2nJiPUmGsPTA7KOno7MWLWv/Yb1xUN+kucOzjJ2PkiKn0ESZ12P4J/8GIkvz/CcOjMPR/dhW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(53546011)(36756003)(38100700002)(6666004)(6506007)(6512007)(2616005)(186003)(83380400001)(5660300002)(6486002)(31686004)(31696002)(66556008)(86362001)(110136005)(66476007)(66946007)(8676002)(8936002)(316002)(508600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0xlNGFIK3MwMUI0M1MyNXBTTWEzVXlBNFpsRmZNOFJBQmVSalN5UDB1ZDN4?=
 =?utf-8?B?K25WT1NuMW9oS3pQVTNXTVMvd3ZheEl1MWhoZ2FoQSs3eUpaZWRlZjMwaTNu?=
 =?utf-8?B?Y1ZZeXQzczluQ0lRdnN6ZVE3Yy9kVDQxWjd1TmtEWUZ1M3E3NUNVY24xaU1z?=
 =?utf-8?B?R1JoTE4wVHRxRnRrV1g2MmJSaTNlc3kvS3d1b0t3eFNONDMvSzZ6S1JxN1Bx?=
 =?utf-8?B?VkRkeU43VzhSNU5CMlhocUluMVVxcnZHT2dNM0UvUE5LbFo3dGgvQ3lwM1hR?=
 =?utf-8?B?Rlk2VWV1OXFMWnV5SVluMDNGZzViVGVySHNkVzN5djNBbE9lb3dwQzZOT2xS?=
 =?utf-8?B?THVIQjhyUkNVMnRWcGhNOTUzV00vN2xJNjdQeWtFV2VmMmpyb2xoK2llWmRp?=
 =?utf-8?B?WUFYU1NMMGNOVEtNanZtMDl3VDRWaHRTTjBoQkt6ZDRMVmM3SlBoa0dheWlj?=
 =?utf-8?B?cERWYkRaQlFFa0R0Ky9RTUJrU1YzMy9DMHlkNk56UXpKaU9aWU05dzZKSEYv?=
 =?utf-8?B?aE44ZzhIUWlyQVlxcFQ3Qk9scVBKNk1Nc1FZWmxwTW1WOGZsL0xsN2JpQWlz?=
 =?utf-8?B?MkUxeFlkZ3UvWjJMcXE0T2hNOTZGN2Y4bmc1N05sSEJmd0xoS3FBTjQxODBS?=
 =?utf-8?B?ZHdyUFpHZXRLa1V5UWRJaDRNd2x5UWVTRFAxRkIzL3V2USt6KzkrNnhsWWJi?=
 =?utf-8?B?eEhvb2liK2dzaDA1WlFLcWZXNEdwUFRwcFpFSGdUUU5nWXBWZHNGbmxZeE8r?=
 =?utf-8?B?Zkp1aENTWFIxWG1CVk5ZUzc1Qk1Xcy9VZldyK1Z3ekE3RDZyWmFxUlk4L3dB?=
 =?utf-8?B?cWVaY3V2THB5ZWpVS3ZCc2xHekZtTnVvVnVEVlVGMW1YT3p3RmZIM1liMzlt?=
 =?utf-8?B?b1luLzA3UVE4QndkR1VVZ1kyOXJVZWZLVnJvRnRKVTljYTVDVU9yeWJETXRt?=
 =?utf-8?B?VWt1bmRnSVhyR3czam9rZXRUajhQSWdiQlkxcGFqUTJzeWxkNjh0Um1HK3I0?=
 =?utf-8?B?ZHZUL0x5OHdiTE1saTQ4amFSZmI2OGpZbUwzdndSdndQOTYyWnVpbFF0M0JW?=
 =?utf-8?B?Qm5LYy9IMGt1QVd1aVhrbmhIUVlVSlpKa2dmZk9NVVlqWFRoRm9xeTJvVkow?=
 =?utf-8?B?Y0NNbXg0QVdMampGQzN0RXVhMytRdFRBVkw0Y1Y0QmlDSUVYM1lIQTV3SjB6?=
 =?utf-8?B?U2k0N1lXVE5sY3FzK1lZRFdTTHN2TzdhK0hwenVEeWJJMzFaVFlTdXRvdzVr?=
 =?utf-8?B?T1JyNXNodm9wblZEaW1IS1diL1VJTlJyc1BVaHUveDd4Q2pjdHR0MytndGFq?=
 =?utf-8?B?citPcERJd3lzNmRURnl6TVF6RUdYWEkyemZuWW5MN2ZjYy9jbnVxa1RRaGpY?=
 =?utf-8?B?bFlKZjZMMENncmFHclRpMjQzR0JHYk9zMk5Na1VrRGlEZUJtK24rS0QrZTRT?=
 =?utf-8?B?by9IUlJNdU11aXdqKzJMNTNFZlJidlNZZFBNb1VJc3JtT1pNM09mZjNGbW1U?=
 =?utf-8?B?OTdmcmRQdWo0ZHQrdmRhUk9MY0c4ZzB2V1hOU0t3dnlReDZjMEZZVElxaFBx?=
 =?utf-8?B?VkFVRlNhU0cyUUUxYVhJY01JS3oyck5pSTJqQjYycEFlMXp1REtNRFYxVnhK?=
 =?utf-8?B?dldyTVdLS0VMUVR6MHdWc0lrNUg5MW42UnFTTFNhOVhnc0NjUTFnNmJzV3pN?=
 =?utf-8?B?eWx1L1VPNGJib0dCdUp5TmZjU0YvSUl5SlVYVllJTUUxQjE5UE0wa2dsYzdj?=
 =?utf-8?B?VDZQcDBiOUVzSW5kM3E1ek51akVad3NVbFgwdDltcXdPb1VwcURHWWp5MW1o?=
 =?utf-8?B?STNrLzFRamR5aHlxL0dHWHFlemZhMW0yZVczcVNGa3E1aEpSVDcyd2pYSTVU?=
 =?utf-8?B?R1BVeFNiMkdJOVhqSkhtc3BXV2NBRFVFTERTUjM2U2IyV2ZkazRhUlNueG5Y?=
 =?utf-8?B?ZGZrQWxMS1FxNW9vdUs0NERSRzNiZUNlbXJzYXVpeThrVU0vTGJiMjRwSjlC?=
 =?utf-8?B?REUvdnVzZkpPYUhoTkxuOXNNMytTYXptSGtGZ1hQY0xnOXNFZGRaS0d2ZTVO?=
 =?utf-8?B?MTQxU0pXSXhXUCtCYXdSUktwL0d2N2pTMXo3VlVSMzVYUktzYVBvK21Ta2l6?=
 =?utf-8?B?N083WHRkSDluSENmMWFzUncrTnpzTFdUL0NWUUlGVmNZdW55dHJOZTFOb09o?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb73c88c-588d-4984-11b1-08d9ec6cdf6d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:11:00.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTJa+H43vaiE7CukNs0Sbb9du0yipTPqGHLbeorya23zjl7NYa2Sg2+zXK8T2BnP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2194
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: FtxOFkg3jQ2XGnExKTqcvaqbn-65-7Ok
X-Proofpoint-GUID: FtxOFkg3jQ2XGnExKTqcvaqbn-65-7Ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_02,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100043
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/9/22 12:03 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, Feb 09, 2022 at 12:33:24PM IST, Kumar Kartikeya Dwivedi wrote:
>> Add a test that validates that timer value is not overwritten when doing
>> a copy_map_value call in the kernel. Without the prior fix, this test
>> triggers a crash.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>   .../selftests/bpf/prog_tests/timer_crash.c    | 32 +++++++++++
>>   .../testing/selftests/bpf/progs/timer_crash.c | 54 +++++++++++++++++++
>>   2 files changed, 86 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_crash.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/timer_crash.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/timer_crash.c b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
>> new file mode 100644
>> index 000000000000..f74b82305da8
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
>> @@ -0,0 +1,32 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include "timer_crash.skel.h"
>> +
>> +enum {
>> +	MODE_ARRAY,
>> +	MODE_HASH,
>> +};
>> +
>> +static void test_timer_crash_mode(int mode)
>> +{
>> +	struct timer_crash *skel;
>> +
>> +	skel = timer_crash__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "timer_crash__open_and_load"))
>> +		return;
>> +	skel->bss->pid = getpid();
>> +	skel->bss->crash_map = mode;
>> +	if (!ASSERT_OK(timer_crash__attach(skel), "timer_crash__attach"))
>> +		goto end;
>> +	usleep(1);
>> +end:
>> +	timer_crash__destroy(skel);
>> +}
>> +
>> +void test_timer_crash(void)
>> +{
>> +	if (test__start_subtest("array"))
>> +		test_timer_crash_mode(MODE_ARRAY);
>> +	if (test__start_subtest("hash"))
>> +		test_timer_crash_mode(MODE_HASH);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/timer_crash.c b/tools/testing/selftests/bpf/progs/timer_crash.c
>> new file mode 100644
>> index 000000000000..f8f7944e70da
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/timer_crash.c
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +struct map_elem {
>> +	struct bpf_timer timer;
>> +	struct bpf_spin_lock lock;
>> +};
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARRAY);
>> +	__uint(max_entries, 1);
>> +	__type(key, int);
>> +	__type(value, struct map_elem);
>> +} amap SEC(".maps");
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_HASH);
>> +	__uint(max_entries, 1);
>> +	__type(key, int);
>> +	__type(value, struct map_elem);
>> +} hmap SEC(".maps");
>> +
>> +int pid = 0;
>> +int crash_map = 0; /* 0 for amap, 1 for hmap */
>> +
>> +SEC("fentry/do_nanosleep")
>> +int sys_enter(void *ctx)
>> +{
>> +	struct map_elem *e, value = {};
>> +	void *map = crash_map ? (void *)&hmap : (void *)&amap;
>> +
>> +	if (bpf_get_current_task_btf()->tgid != pid)
>> +		return 0;
>> +
>> +	*(void **)&value = (void *)0xdeadcaf3;
>> +
>> +	bpf_map_update_elem(map, &(int){0}, &value, 0);
>> +	/* For array map, doing bpf_map_update_elem will do a
>> +	 * check_and_free_timer_in_array, which will trigger the crash if timer
>> +	 * pointer was overwritten, for hmap we need to use bpf_timer_cancel.
>> +	 */
> 
> Also, in this case, there seems to be a difference of behavior. When we do
> bpf_map_update_elem for array map, it seems to invoke
> check_and_free_timer_in_array and free any timers that were part of the value.
> In case of hash/lru_hash, that doesn't seem to happen, hence why the test has
> two 'modes', to then trigger a dereference of the overwritten pointer using
> bpf_timer_cancel.
> 
> So in case of array map it crashes right when doing bpf_map_update_elem, and in
> case of hash it crashes inside bpf_timer_cancel.
> 
> This seems inconsistent to me, is there a specific reason behind doing it for
> array map differently than hash map? If not, is it now too late to change this?

There is no map deletion operation for array map, so the timer is 
canceled and freed when a new update comes in which signals the previous
value is gone.

for hashmap, depending on whether a new element will be allocated or 
not. If it is, the old element (if exists) will have its timer freed.

> 
>> +	if (crash_map == 1) {
>> +		e = bpf_map_lookup_elem(map, &(int){0});
>> +		if (!e)
>> +			return 0;
>> +		bpf_timer_cancel(&e->timer);
>> +	}
>> +	return 0;
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
>> --
>> 2.35.1
>>
> 
> --
> Kartikeya
