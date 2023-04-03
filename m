Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9AE6D3C42
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 06:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDCEAM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 00:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDCEAL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 00:00:11 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02B383F7
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 21:00:09 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332EW3Hu023540;
        Sun, 2 Apr 2023 20:59:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=L6N6i9NjNe7lGOMH4q9F/aMXxNCkGWjthQ/gOH6f6Gs=;
 b=FZqhYOrtgAINa5jcSGaZzxcOHBcIRoPjeRK/hwcaj6PPKThJCL6JZbt1yZSteaLvjdza
 2Bq4eaB8zR8+WYl9ym0ILlCSW7cmP3E7vZO89qCJBTgpRaio0iRKIo8tJHeFkviFs8EK
 g1zFteiBurm4cueih8trR6/fqyO34UoQocAfwI3j3tpVaUy6d2v/FODh7Xb46XL9EK55
 W6bfYfEmgAKm5n7f7tIpgK5gtFi7gMTe2CPSUg3eJIDSiBzIPgM9DZVHMPx0ZNhSyKnh
 o8a3j5EHOTN0bTFM3IuRVK9iR19tLCNBn4le2FAdmqH8c5R+h5uebcuIdLLvlzTcPbQK OQ== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ppj52xvj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Apr 2023 20:59:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXgQruCdps/Iqm+acSC1Bu6toSAbqD7Plu0TSZnr6IpZsdM+Q83ygRjq9k5ujlR0bQBVvG/MEXLfPh0EoSghvr9ic5umsAG1Ya1+1rI1kRq+RnYkXBWYsDUHa/25IioVAA95OD0fo/PQnYcYPodE420aJlnASio4mm1EQR/CyRMJ4A7Rx37RJdxx4s1J4CS7LZF62vWft5h3cdyTBJ5Akw1BAci3KhCY0pdj1l1RI/zTBLQhk9lFANCbR1JS2uudYrpylKrxhRERNYiLyt/DXGLuav85hMfwwL+0n1/WBJVuUdZgxmNlaLDEHGEZbvnzh2Xq+p+Eilyi+SGpSYFhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poyCNnDrWiWMTXIiZzt1lRoe+JYf85Mafnm84m8brtk=;
 b=OvTt/mSrXWehzQcrZfjkeYaY2ljstzmGfnEr7Q9OPthuogkDHt2b9zbxhuYD5WVX2s3mfF2tQkSp85hcPVVb6/KHBDw74volADXu/2LsWtm+uFZVM8kHwe/+dwjwwu2hZrHQBptzdKsIuLTsvDy0KyqPK/mRecwAZgsLgL1Ou9p1qeMWQd+QLvC0qU/pgrHXZq56Y+u38kAe1i9lDm1aJycTToyfYOuAua74ZURPyDGwDB/V5UDDaWjHQKrslNvvGwTqf4A1uzKJHuiDhKn1lqurAnAYsmSxjIIqJRMlD5uo9lcD/eIonTA3HJ+d9dEWo0KkzF8pqwd3MvthqmHb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5305.namprd15.prod.outlook.com (2603:10b6:510:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 03:59:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 03:59:50 +0000
Message-ID: <c75513a8-42ae-b202-d360-97a57d3f1025@meta.com>
Date:   Sun, 2 Apr 2023 20:59:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Add a new test based on
 loop6.c
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230330055600.86870-1-yhs@fb.com>
 <20230330055636.93471-1-yhs@fb.com>
 <20230403013941.35yemjpee4bh7yh3@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230403013941.35yemjpee4bh7yh3@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d7d1f0-3d0e-488a-7753-08db33f7dfc4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4Gd2Rowfi0J1wR6GLgOJGGp8WvmXGS4ZIFqEsR9EKXU0v+AiqNLbBOfXzLGWOmJVHKb6RrU+eSNgsfwoGgkLkDdyXBzFZ3mJTovHv1wedD9jHnL1cVSMFt9umllS7GPkIPUV3WtOuv2noODWbvU82+8WusZBbpyW7BXHqQ5SzYus5/1fHLTYiofbb0lgRmL55mu1lJrBtSvn8EloWEf/ZtuwGQJHLtP75EmHfsnVuks4UlJ+jYAZONRXhqaHqbgAYDLQqR4HzgYEicao9KBpK6YKIoZ/tIniB6q7FuGdmgpTF0THOeB4+77sgO1EHv8x8AJlVEcfT+B8gZPwfx1KTu/rIdbgijMls31p0+Me52kVjE6+PjoZUBYErfd8FVM4Ogc7KaIDqRveXFJX/7xAc+E4oQJXZIQNHYTCaFsjvv4fG3dfhWI98Hd6OtiuBGeFOluJsiKx8vGD2KbWCdFIl6SLyB3Z477aOb1lxAIfny2OqOWc2UwzkuLMP+BUzgID6IrjB7+Q9Ou5bQttGYLggUqYvlcJci/mHdcAZTFTy3/FLhq/VH4M5+9bJ/+OQGqXpO41S4nuHW7YG2CuEPK77wQ1q8GoYm/cO99iSXA6cYR+WjpBW51Q2xBPedve/glci9pI3o8aJx1nRnaXT4W9U/8mOTbpRioLxj/Oy0IVMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(31696002)(86362001)(36756003)(2906002)(31686004)(2616005)(966005)(53546011)(83380400001)(186003)(6506007)(6486002)(6666004)(6512007)(8676002)(66946007)(478600001)(66556008)(66476007)(4326008)(41300700001)(5660300002)(38100700002)(316002)(54906003)(110136005)(8936002)(60764002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnVuOG10U2wxb1FhbzNQRFdtRHl3ZFkwSlY3b1BiZm9HMFpYWlloazlGYitY?=
 =?utf-8?B?ZThhWU9VZ28vME4wbldOTEVkaTJXYVplZzA5R1o4SnBjcTdya0g5TElqYlpW?=
 =?utf-8?B?N1FiYzZwYjI2ZzVrSEtxQlFqM2lFRlhUY3c5eVEwMlJzRHIrRW9SSmJRNEda?=
 =?utf-8?B?NUpHbEtVa3RGK3RMcUV2dFhCaVhIeVExeUhIZHFXS0VpTm5rRnM5ZUpyaUxS?=
 =?utf-8?B?S1dzYkJLeEtFRGdBckgvaTBxN29UK3ZYTGFpMXFrcFBwTEsyaTJJYlNtQmNL?=
 =?utf-8?B?czlLM1pPT1FFRmoxQzRFMEZJeGs1ajNnT1BFR21vMU5FNjZTT3V2STd5ZEZl?=
 =?utf-8?B?dmkzUnduL2puTW9lUVNXMXI4OE4yelBLcGRxaXplWTRkRnM1QVh1QkppRG9p?=
 =?utf-8?B?a0hoRlRqSlhteXloRGFJT1dOdGZHVUFCM2dNTFhvM1k4bmhodnZ3OG82YTB1?=
 =?utf-8?B?aTY1N2MvVnhMcTB1cDlmM2tvMG9vS2czMnpRcGRlNUU4Ry9rRTJVVzNJZUpO?=
 =?utf-8?B?ZHlDc1VhalF6Z25FZk01bS9uVVBTWVVkTlFacmtTK3ZNbXh3QXp2QTc4N0Fl?=
 =?utf-8?B?WUZ6cDJmQ2xpNzd4Zm5mcHdmUkd6SENxYUxkODlLTkJ5T3h5UVN2dktqTzVW?=
 =?utf-8?B?RnpISWFBbTRvUldHemRrZXZrc2hVK2NkVkJTWklrQ3owYUJYbExpOGczSnJk?=
 =?utf-8?B?ZFJsWlBzYkJmdC9ocWtZbUlTVFpGaGR4dkM0dGdCbHNLNFBkTHBZZUM1NHQ2?=
 =?utf-8?B?cDVYcDA3ekxEcTVtNVhIWmpraEVjZW9vMlFYZzJCVzNtMlJRY0luUHplN3NQ?=
 =?utf-8?B?SFlIY1F3RmpqRXkxL0o5SVpmQmZncEgrUlMxUWFuT09YVTRwM0ZVeTMyNU5V?=
 =?utf-8?B?cjBENy9MWGgwVWZKRlVmMjZ1QXkzbHowclY4MmFYdTZMVDN3YWxCWGMwS2pI?=
 =?utf-8?B?dE5tam5IZ2U2QjlvQ3JxdXJkd0JIRkM5TlRIZ2krR1ZKL3MwdTJYMXpPTFF1?=
 =?utf-8?B?dGJUb1kwVEM0UDNHNHMvNU1qa0NCMUJ0ZTFvT2xvOEpWWXlRWlhTU3JBOGNH?=
 =?utf-8?B?YzFKSytxa25DTEJpcE9Da1FuMnFxWm84NHlJeTlMeWdqY0NNak9MMjlEbEth?=
 =?utf-8?B?eWdnOGpZeUJZL3BwNnBhQzBpaTVKeEFnWWlwRU9xY1Y0eGttVHBPQklDdTZM?=
 =?utf-8?B?YzNDM1BLQjJLMjdOV3l0VFVUYjRTSzhQMG1NbGZqM1dmYVNJUmlzT0xCQXVw?=
 =?utf-8?B?N251c0lJUVBFMGk0cStoaW5ReTFPSzZkZTVrcUhDWXJLbDlFUEpJOGcweENO?=
 =?utf-8?B?bnUxUm1qOTJpNnUzcVpELzJHeWMyc0NVTGxvaTBlSVcyYUlNMXpxdUZJdWVS?=
 =?utf-8?B?eTV2WHROcTcvR2N1bDh3dmExSjN5ZHhjU3c4dElVTEpIYTF0MHdkcUczTSty?=
 =?utf-8?B?SFdXTGcvTC8xS3B3NTFGWTlTaDhhZXFJK212cmxieU03RlFtUFU5aEdsQUlp?=
 =?utf-8?B?bFpPamROdU5xOHB1enBidDZWKzB3RmRhWDl4a1hvemwvem43Um5ISGY3RjJj?=
 =?utf-8?B?a2VQZWZOUHE4T3h4WEMvYnBwbGY2dlJKT29GUnBzR2lraS90TnZ2QW5BRHdw?=
 =?utf-8?B?bmFzOThDTnJwdmpNNUpGNFlRTER4Tkg4aGloa1V6azk1QlRRWG9iZUNlaTdl?=
 =?utf-8?B?aXMzaitVZmUzbW1aYWpTWTJGZkJ6NXVpS1JRQzlrRHo4dzhQYjBqcUpHSXFF?=
 =?utf-8?B?OXVRV3MxTlJKd1k2NnNaWkpwSFdKRnlJUEVLSFVQdjZ0bXU0bW1mMzdDUTN1?=
 =?utf-8?B?U0VONmZ3TnpFMFAyVEovK2Z1Q2ZocDlZMi9BTS9kSmRac0xUNlZRQWlESXB2?=
 =?utf-8?B?aWUySC9IOFhENEZ3U3lkRXp0eU54TWtnY2tYNWxoeDJwY1JLaElSK3FnMWxT?=
 =?utf-8?B?U20ydG04elczVTRZVW1PZnhLS3I5L3EwTkVqNmdSSjJHRG93dlRUalRlNVVI?=
 =?utf-8?B?R2EvYmVNbERzUXA4NVNKOTZ6R2c4a0g2cXlHSkFxUFFCSkRsaGNmMTlwWHNL?=
 =?utf-8?B?ck5XeDduOU5qRldTS3FFRXBDYys0dzdMcnlSNForQ3YxVE90Q1Rxd1V5NEJP?=
 =?utf-8?B?WW5jdndMb3I5YUk4RGFFTEFPQllpNUErV2pxN0N5QjYrRkRMQkhIQXlDeiti?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d7d1f0-3d0e-488a-7753-08db33f7dfc4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 03:59:50.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbBr7mfUUnp1eH4bMLHtPkHN5PjPZQWsn4qT29bOSdowpL3rCn4gh5vaL1RAtw7W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5305
X-Proofpoint-GUID: 9nlfwzOgmnKgOm6aTVcsysnrQrDFgqFm
X-Proofpoint-ORIG-GUID: 9nlfwzOgmnKgOm6aTVcsysnrQrDFgqFm
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_01,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/2/23 6:39 PM, Alexei Starovoitov wrote:
> On Wed, Mar 29, 2023 at 10:56:36PM -0700, Yonghong Song wrote:
>> With LLVM commit [1], loop6.c will fail verification without Commit 3c2611bac08a
>> ("selftests/bpf: Fix trace_virtqueue_add_sgs test issue with LLVM 17.").
>> Also, there is an effort to fix LLVM since LLVM17 may be used by old kernels
>> for bpf development.
>>
>> A new test is added by manually doing similar transformation in [1]
>> so it can be used to test related verifier changes.
>>
>>    [1] https://reviews.llvm.org/D143726
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../bpf/prog_tests/bpf_verif_scale.c          |   5 +
>>   tools/testing/selftests/bpf/progs/loop7.c     | 102 ++++++++++++++++++
>>   2 files changed, 107 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/loop7.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
>> index 731c343897d8..cb708235e654 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
>> @@ -180,6 +180,11 @@ void test_verif_scale_loop6()
>>   	scale_test("loop6.bpf.o", BPF_PROG_TYPE_KPROBE, false);
>>   }
>>   
>> +void test_verif_scale_loop7()
>> +{
>> +	scale_test("loop7.bpf.o", BPF_PROG_TYPE_KPROBE, false);
>> +}
>> +
>>   void test_verif_scale_strobemeta()
>>   {
>>   	/* partial unroll. 19k insn in a loop.
>> diff --git a/tools/testing/selftests/bpf/progs/loop7.c b/tools/testing/selftests/bpf/progs/loop7.c
>> new file mode 100644
>> index 000000000000..b234ed6f0038
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/loop7.c
>> @@ -0,0 +1,102 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/ptrace.h>
>> +#include <stddef.h>
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "bpf_misc.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +/* typically virtio scsi has max SGs of 6 */
>> +#define VIRTIO_MAX_SGS	6
>> +
>> +/* Verifier will fail with SG_MAX = 128. The failure can be
>> + * workarounded with a smaller SG_MAX, e.g. 10.
>> + */
>> +#define WORKAROUND
>> +#ifdef WORKAROUND
>> +#define SG_MAX		10
>> +#else
>> +/* typically virtio blk has max SEG of 128 */
>> +#define SG_MAX		128
>> +#endif
>> +
>> +#define SG_CHAIN	0x01UL
>> +#define SG_END		0x02UL
>> +
>> +struct scatterlist {
>> +	unsigned long   page_link;
>> +	unsigned int    offset;
>> +	unsigned int    length;
>> +};
>> +
>> +#define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
>> +#define sg_is_last(sg)		((sg)->page_link & SG_END)
>> +#define sg_chain_ptr(sg)	\
>> +	((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_END)))
>> +
>> +static inline struct scatterlist *__sg_next(struct scatterlist *sgp)
>> +{
>> +	struct scatterlist sg;
>> +
>> +	bpf_probe_read_kernel(&sg, sizeof(sg), sgp);
>> +	if (sg_is_last(&sg))
>> +		return NULL;
>> +
>> +	sgp++;
>> +
>> +	bpf_probe_read_kernel(&sg, sizeof(sg), sgp);
>> +	if (sg_is_chain(&sg))
>> +		sgp = sg_chain_ptr(&sg);
>> +
>> +	return sgp;
>> +}
>> +
>> +static inline struct scatterlist *get_sgp(struct scatterlist **sgs, int i)
>> +{
>> +	struct scatterlist *sgp;
>> +
>> +	bpf_probe_read_kernel(&sgp, sizeof(sgp), sgs + i);
>> +	return sgp;
>> +}
>> +
>> +int config = 0;
>> +int result = 0;
>> +
>> +SEC("kprobe/virtqueue_add_sgs")
>> +int BPF_KPROBE(trace_virtqueue_add_sgs, void *unused, struct scatterlist **sgs,
>> +	       unsigned int out_sgs, unsigned int in_sgs)
>> +{
>> +	struct scatterlist *sgp = NULL;
>> +	__u64 length1 = 0, length2 = 0;
>> +	unsigned int i, n, len, upper;
>> +
>> +	if (config != 0)
>> +		return 0;
>> +
>> +	upper = out_sgs < VIRTIO_MAX_SGS ? out_sgs : VIRTIO_MAX_SGS;
>> +	for (i = 0; i < upper; i++) {
> 
> since this test is doing manual hoistMinMax, let's keep __sink() in test 6,
> so we guaranteed to have both flavors regardless of compiler choices?

Sounds good to me. Will drop patch 6.
