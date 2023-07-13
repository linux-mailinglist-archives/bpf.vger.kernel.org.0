Return-Path: <bpf+bounces-4943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E31E7518C1
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 08:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6AD0281BB8
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F9F568C;
	Thu, 13 Jul 2023 06:25:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A39F5679
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:25:32 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C09A2
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:25:30 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 36CMvQuG028510;
	Wed, 12 Jul 2023 23:25:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=oPOc0LfCo8DM3l1HxfpUdFdslihJR9W8cUNFkQlTLUY=;
 b=V1mqQnD0xFxliFzEczazFhDnvSANrbC8IGgccfPWo3L4bcamQybdhuw2btwWQS1iFcgP
 cJISrnOJyNG7rnrsPrTgebBpFfKbIRrrfpFDmA+IeLr2IO+ZBRihe7L3tuDhoIJcFzUG
 7HNmzjWzcMKBHyUb9wOhpR79XqqmHMKyOSl0TWUxkmCiefZQ8P9l2XAezimO4G9nywn/
 ltHDh1by/km1tXxN4wS5cV6NtI2VN7KSRBnayMr6elg9EA7iyCZzvlHbK7bbJ9mvZGn2
 3eE6TSUotkM3nfd0h8lM4npSXgvdgQUyiqhYBq/5InyLWTATmRpAsAEzCMSygVtZs8yr ng== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by m0089730.ppops.net (PPS) with ESMTPS id 3rsg5dk0ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jul 2023 23:25:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxyFvB895P6cJSPJ3P3uwm3UP9YKYDY7lVddYgVUBoRKzV7FtRbQJiHjMu3HQF59Ftct7LV/yAP2EThWKYYaTSWrzWsajLSTbcxyWuw4xd+jLQnpbDEaN7aHNdyhNSF0SdLBoj8meiL7PxGXmdLGY0UVuCgODNr7/5qlDauXJ9mNONX89C7LUndV7hLdVnjBYHQdeV/Fxs2ZB1ElkrrIcnHYxtR/FPGdTwO7lhuUMH/7qsyFoJlIJ8U2zBckRCZKIaUMuM+AnrmTAi2NFEbx8jyWTesgAJMq1R+vfr5vmihtGKCxCMQbHJA4qhmuB/slygZT6vEU8FE9l+n6DwgMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPOc0LfCo8DM3l1HxfpUdFdslihJR9W8cUNFkQlTLUY=;
 b=G45NZ/MYaWiPnJMOxdIjbjLKA1xr0sj6s/l9mZxc1+XYPGto/UKHZYpclqi65VAobj8q1eRoRp791C3mfC1q15fqsibhJtvieUHP9ADS8CIzNOwTFk5uZrFTW6QSl9s6AZiz2X1nnWpqBPFGoKOWKOuxSx25DJitd1qbZiq1CJf9JATDWZQjHzx9EnEPTXYYuD/xrUKVM/G4WhrAmi1naFSmcEuz8QiY3eZ/2O1NYPPwI4hRwNjksskzY+gxsbN7hSm8tPeNztDyb93y3htXQfVtarzr/nQe0cJOR2/WAso5Q72emHc8MbKIsqjxcyKGNQc7CZNewnfWZ+zzwiL9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB6084.namprd15.prod.outlook.com (2603:10b6:510:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 06:25:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1757:f075:376:8ff1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1757:f075:376:8ff1%4]) with mapi id 15.20.6565.034; Thu, 13 Jul 2023
 06:25:14 +0000
Message-ID: <980c11e0-c601-a8c9-8ea2-8a5ec6067d7a@meta.com>
Date: Wed, 12 Jul 2023 23:25:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 08/15] selftests/bpf: Add a cpuv4 test runner
 for cpu=v4 testing
Content-Language: en-US
To: Fangrui Song <maskray@google.com>, Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060800.392500-1-yhs@fb.com>
 <CAFP8O3L04X_c2wD0pg7Av24K107SFeCUm+-xtCs30EbQag5xOQ@mail.gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CAFP8O3L04X_c2wD0pg7Av24K107SFeCUm+-xtCs30EbQag5xOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: e71ca6fb-6386-4c41-60f6-08db8369ead3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4/3XoPk5qXzybherpbYV+UmDNyh77kj53rfaheoj0ENgIwzL6dk9vgEBjM+w+QAtghw6zPbA9YlOy9SOn1xvfPROCBSJf05S7EvLQ6I3/JhEZNJAzHIw2jdm9UcNX66pQ+7TSneFLkLAdVeLlku8k8zjmkFvPCwJHbSkc7XV1P9uedYTveuqL9FsJH5nnRsWBO5V09txu86uzSv4Awt5dhLm/mmwCmPxwxtinG6F5w5UjPT1IGOBAhOPTbaVIw3/A9d35bs3StLZ0M7nBjzFRvnTqH28815a+EdLzppNXdiEmKRp+DUOX60HlQ2NX2hSXndcLD06CYFcX9480S9j6dK3kPFjUucbgKdMg833b1cVwffVooWfuBHT2fUFbqrM8mEKeIOg04IzbsFEugPgcOfqC0XNWYBn6DetW5LzP1DEIOjNEAThu8iSmttH7AA/KOyGfeJ8kjcW9KD1OzBWyCCXNtoUM5AxPcAPekGDjj6MuscFBaU96udhoZ+3Za79v6DRm8nyFKg0adscTInbpLCC847hx7FJsImgNz095ZrhIwR1kDVnviw5CTjZoNfRCCzGHcP8N1AMA9lzgKLcowrlkQhq1NyVNBhELJcWtGWPOjUu0YlrpM/DTDHJJcFDxDW3c7pgrIhZNqow5Fh+qw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(8936002)(8676002)(38100700002)(41300700001)(2616005)(2906002)(316002)(5660300002)(31686004)(66946007)(4326008)(66476007)(66556008)(6512007)(6486002)(6666004)(83380400001)(36756003)(54906003)(478600001)(110136005)(6506007)(31696002)(53546011)(186003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGJBaDFjaldnM0JDSFF5MHArbm0wTzIxS0RlMmZvMzllallUYjNGMnJXdVZ0?=
 =?utf-8?B?ak1xUzZPK2tSb2NGTXlkVkMrcnhOK2E4ZEdjbUpFWVJTUW1RdVMyZEY3ajAv?=
 =?utf-8?B?cFRqNi82ZFB4NWRTU2wybU5QaUpoKy92NXgxbURBMlBBWnJPWFQzQUZScjVQ?=
 =?utf-8?B?QmVBdWU5UGpkSHRsOHR0bG5tSWkvMGdQclJuNktxMFQ4aE9EeXNOdk9hZXdh?=
 =?utf-8?B?Wi9YS2ZuSlJqWGZZc0pRM3BpV0ZlREErVFNtZ3l2SmVUS0RuNTZUaFdneWFN?=
 =?utf-8?B?UWJEM0t5eGt3ek44bWVBSjdrNG42eWxPeDNpVHZDOG5xUEl5S3dWYWJyTVg4?=
 =?utf-8?B?emlzenA2WGVzQ0l3ejBkMk1qektVYlg2ZmlCT3BQVGNPRDNJU01wb3k4RVhp?=
 =?utf-8?B?UGdhaThCNVlCRDQrbjhBUThqYzhFUUYzNFhmR2NmZDdwa215M093ZDBMcjM4?=
 =?utf-8?B?QmM1anNiRWxwRTI5bVMxL3RBZ2RKTTBwK25Sci9Qeit2WVNlb3MrWS81M2ZB?=
 =?utf-8?B?UXRiVDloRnIvd29peExIT2xPdktKRHZHeWNoNGVKdU1zNmdRSW1DOEJqVlJo?=
 =?utf-8?B?VEJ0M2xMNVNKUWhoUUdTUmpCSnJxanQ3NVVrVzVFdklGWjUzNXNLZ0t5T09s?=
 =?utf-8?B?UCtzb2pLZm5SbXhDc29mb2EyeWdIM2VaK3lqL284cEdtSkJ2U3d0N2Y5ZHYy?=
 =?utf-8?B?Y09aSFUxYmJpZjkyWUVYYjFXVCtNSEFnSzQ3c21rbmlIb3FqTEhLczVDYU4x?=
 =?utf-8?B?Y1g0UGlBMnR2ZFVhYmdlTmRMY0lYdDJYSFFkd04xVUVsa2JSb2g4c0Y1UDFQ?=
 =?utf-8?B?Z1FXVlhjbVJSSDNiNHRpak1ZbXdFdWVNczVtQWdZdUIranBFa3U4ektIQlIv?=
 =?utf-8?B?OXZseXhCd2lhenprVFBHVkR0K1NWWWJ0ZnJZajlUYThGZkZGRHdyczZISkoz?=
 =?utf-8?B?SVVKVzBsZGorTG05Y1dhTnh6YUlML1JYbXpLMGx2WXY1SmV5bktkd1JYQ2xt?=
 =?utf-8?B?WFU0angwbWZEK2QvYVd2SWN1a0pKZFNWMGlyd0EwMlZLVjA3QlhpVWFxSG1K?=
 =?utf-8?B?b3drSWhjUHZvSHhUam5DTzVyZ0piYlNaVWJGemV3WThoaVN5WXg5K0ZHSzVu?=
 =?utf-8?B?ZDRlS0dpQk12NjRORC9NQk9FajJ5Sk1QbHNiZHdaNmNZZ1JMa1RTeEI2YThi?=
 =?utf-8?B?SmJURzhsRmtiOWloU2ZhdTJIeFRxTENsdHlHSlN0NkxzeFU0THFhTUEzdSts?=
 =?utf-8?B?TnhjZkk3eUhJSWJLUkR2WTU2aDkxVldRWlN2K3hnY3dsamZLNDl5ZUIwVFJB?=
 =?utf-8?B?MmpSalFxMlJ4bTJIS1hGS0Z4UjgxdmgyMDRzTUN1anlFOXNkVmtGNGU2cDVZ?=
 =?utf-8?B?ZDBOY2pIdXUyL25FaHlEdGdCZU5EWlAzWSt5amJoRlZvQ0ZhZVAxbW5CQ0gx?=
 =?utf-8?B?MWdtWXZQTUtBcWtOeThGQWFBR3NNbHVuKzBlZGFsbzR4YmpELytCZ285dWtF?=
 =?utf-8?B?MGM5dXY5VzBzTEt4NmF0T3hiMkgwd29FaHpNaEJDKzFtcUVBKzYrcUx4WUt1?=
 =?utf-8?B?T08zSHQ4VU5vQTBBUWhrODBnUkkzYlZteng4M0Vsam44UVBtZ2hsbE1hWHlS?=
 =?utf-8?B?a3c1S3gzN1paS0tVL1BpNExVSEVaVEhpQVgwQjBUaG4xQ2g3SjkreUsweXNk?=
 =?utf-8?B?NVp1eGpMaEZRU2M3UXpnVFo3aFptZ09XMnZneTdoenA4WS9DY1lqUWpOcG9a?=
 =?utf-8?B?ZGJEK21NWmpRcE5TRnFKdzhtcDg3U0g2SkdLTlB2dU5IckFxSk91aHRaLzRP?=
 =?utf-8?B?elB0L3pOKzhrdmZjQzY0eW9ubzEwWFdoNzFmcXJzRk00K0k2ZG50SHFPLzgv?=
 =?utf-8?B?WFc3UGczK2kybWVuaWxidndqS0Q4RUliUjdDRHVCb1VnVWtqOVNQVGZsN1pB?=
 =?utf-8?B?a1E5NnVZdmwzdTk1azRxNjQ3M1Jnb1Zwdm8ya1VLekdLQXFyYmswb2JkVUxi?=
 =?utf-8?B?ZjNlSE9KYVZNVWRma2JkU0FIbGtYdVoreG9MS1JMRkorekJPeWc2KzFoWWh5?=
 =?utf-8?B?a2x4QXB4MDNSOGFTOUpYKy9JRVBhY3FuSytsUXVyQ1BobUN5L0ZmOVRtd2Z6?=
 =?utf-8?B?UTBjUjdrcExqTlUwK2hCWmh2V2hHWHVSdGRLTmMvbGJIZ09vai9UYUxmZFJo?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71ca6fb-6386-4c41-60f6-08db8369ead3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 06:25:13.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h23ULtugGaTJc4jWWUTR4D8wOe9H7LvDjXvvDaqWOnWh80KBPVZB56r9wg+mepGU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6084
X-Proofpoint-GUID: piRF0cbPmmrfPW06JqU5442KvZDYm65X
X-Proofpoint-ORIG-GUID: piRF0cbPmmrfPW06JqU5442KvZDYm65X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_03,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/12/23 11:18 PM, Fangrui Song wrote:
> On Wed, Jul 12, 2023 at 11:11 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Similar to no-alu32 runner, a cpuv4 runner is created to test
>> bpf programs compiled with -mcpu=v4.
>>
>> The following are some num-of-insn statistics for each newer
>> instructions, excluding naked asm (verifier_*) tests:
>>     insn pattern                # of instructions
>>     reg = (s8)reg               4
>>     reg = (s16)reg              2
>>     reg = (s32)reg              26
>>     reg = *(s8 *)(reg + off)    11
>>     reg = *(s16 *)(reg + off)   14
>>     reg = *(s32 *)(reg + off)   15214
>>     reg = bswap16 reg           133
>>     reg = bswap32 reg           38
>>     reg = bswap64 reg           14
>>     reg s/= reg                 0
>>     reg s%= reg                 0
>>     gotol <offset>              58
>>
>> Note that in llvm -mcpu=v4 implementation, the compiler is a little
>> bit conservative about generating 'gotol' insn (32-bit branch offset)
>> as it didn't precise count the number of insns (e.g., some insns are
>> debug insns, etc.). Compared to old 'goto' insn, newer 'gotol' insn
>> should have comparable verification states to 'goto' insn.
>>
>> I did not collect verifier stats now since I have not really
>> started to do proper range bound estimation with these
>> instructions.
>>
>> With current patch set, all selftests passed with -mcpu=v4
>> when running test_progs-cpuv4 binary.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/.gitignore |  2 ++
>>   tools/testing/selftests/bpf/Makefile   | 18 ++++++++++++++----
>>   2 files changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
>> index 116fecf80ca1..110518ba4804 100644
>> --- a/tools/testing/selftests/bpf/.gitignore
>> +++ b/tools/testing/selftests/bpf/.gitignore
>> @@ -13,6 +13,7 @@ test_dev_cgroup
>>   /test_progs
>>   /test_progs-no_alu32
>>   /test_progs-bpf_gcc
>> +/test_progs-cpuv4
>>   test_verifier_log
>>   feature
>>   test_sock
>> @@ -36,6 +37,7 @@ test_cpp
>>   *.lskel.h
>>   /no_alu32
>>   /bpf_gcc
>> +/cpuv4
>>   /host-tools
>>   /tools
>>   /runqslower
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 882be03b179f..4b2cf5d40120 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -44,7 +44,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
>>          test_sock test_sockmap get_cgroup_id_user \
>>          test_cgroup_storage \
>>          test_tcpnotify_user test_sysctl \
>> -       test_progs-no_alu32
>> +       test_progs-no_alu32 test_progs-cpuv4
>>
>>   # Also test bpf-gcc, if present
>>   ifneq ($(BPF_GCC),)
>> @@ -383,6 +383,11 @@ define CLANG_NOALU32_BPF_BUILD_RULE
>>          $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
>>          $(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
>>   endef
>> +# Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
>> +define CLANG_CPUV4_BPF_BUILD_RULE
>> +       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
>> +       $(Q)$(CLANG) $3 -O2 -target bpf -c $1 -mcpu=v4 -o $2
>> +endef
> 
> Use --target= (Clang 3.4 preferred form) for new code :)

Thanks for reminding me this. Will fix in the next revision.
Using '-target bpf' for too long so forgot '--target=bpf'
although just learned it a few weeks ago.

> 
>>   # Build BPF object using GCC
>>   define GCC_BPF_BUILD_RULE
>>          $(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
>> @@ -425,7 +430,7 @@ LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(ske
>>   # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
>>   # Parameters:
>>   # $1 - test runner base binary name (e.g., test_progs)
>> -# $2 - test runner extra "flavor" (e.g., no_alu32, gcc-bpf, etc)
>> +# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, gcc-bpf, etc)
>>   define DEFINE_TEST_RUNNER
[...]

