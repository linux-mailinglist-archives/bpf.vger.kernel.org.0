Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640CD624B31
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 21:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKJUHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 15:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiKJUHE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 15:07:04 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4B548745
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 12:06:55 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAK3p2Z031053;
        Thu, 10 Nov 2022 12:06:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=OxqGLA31V6Z0kG6zF29Mbnkb0uXL7KjRmZDClrsa5Vw=;
 b=bHSBcs6TRn3b39yWdGJoiwaKKCHfpXXsNEo7vg0KrnV1DKkNIysbhSSKITDFda/negyw
 rdS93g+I/xXsbInJriWVuEsbvgdN0zsiaBV9+7w8ziQMSo74a6OL0ZKs0V83Gyfsj9+G
 5u87o0l5EnUNkELDKlo6bFmSkf+9kmUpK+s6wyAQV8r02oSq8i14D2Td2SuuATfAIiY+
 2FN0toFjmBr+08RXWygluA9tU7NPz1hqexdXw7mdpeGaIwuJ2ZnTTvsLUkqjengpOw1Y
 lMeO/HaqhPdORBzIBGc/lIJy2s340Jf+WvsTiu86xZ0wlBSQq++7Tc/Qrq1zFuwQsUSE 9Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3krnrhftvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 12:06:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfgdYx3VWSx7v2/GJSrlg+OuqKATIQKt7Sn/Bt3B5P1Iv4QSnB62i/rLQnbAfsRUiAB2EGTE4JQ7sYxjGogJqH/2jV7D3FvijhG8my+ON2Kf93hXo5HSftJPvFpV10uucpMhzLQeGa0Pzq4DyrEWaw+pU76+lHVONqgWoOvDUqHoQrXLErKneduDW/K9gsQnjLQqg7E5CrCacX3j+DGTkpjgpDuG+t9ZgiZuHSEef4XEZx71NGbGPmM60eVHWwOWKxQ5Oa21nyrSk/BfDoBxlD+H2os6KiJKUF7hn09rK0iSJ3mX9TVcwO6YMcM8p9aTdy3jtrgMV1EuXPESGAYR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxqGLA31V6Z0kG6zF29Mbnkb0uXL7KjRmZDClrsa5Vw=;
 b=BU8kvczN3e2AzH43Gz+90FWz+oNU7YdiEfcwg12ePdxMStcZMygGU/B4cmz17b4lqQLwV4IWmMGZ1nkDlwYjXJGUy3Fny/1alW/hy379zkGkxgfQNd576RxGFW2tG2MuWRozGMrSP2H/e8OtvrT/hybbDp6mX23pt6dvmq5CiZ29jV69bmVSK1Z9k9cc5uMFl/Nyqp6rx2jCcp04hZHoLtcZtwkb/B6JCHsv3Yg9SlGwnOxHZUKiyvUoMEJ/AgxNg4cDX+Ify582TTuGzV7SDHljObnKUnispzETS6cb3PwJaGNDLp+hM88TE1rGVRCfl19dLCKjmfdgBWPk87HYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4688.namprd15.prod.outlook.com (2603:10b6:510:8d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 20:06:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 20:06:37 +0000
Message-ID: <82608ec5-32a0-3835-2eec-388e94c79902@meta.com>
Date:   Thu, 10 Nov 2022 12:06:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v4 7/7] selftests/bpf: Add rcu_read_lock test to
 s390x deny list
Content-Language: en-US
To:     Manu Bretelle <chantr4@gmail.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221110180124.913882-1-yhs@fb.com>
 <20221110180201.917531-1-yhs@fb.com> <Y21S6+9rfmwA8R8S@surya>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y21S6+9rfmwA8R8S@surya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5b3a21-87c4-4260-8120-08dac35712d7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMITfUx0BuigGKW/Unmu4QylA1uQ6/DHbdi7SCMqjxIn7Pl2VTuHxI8Uywpk7kPSAvKI+Cs+A8dAIOGnWP3bsgVKXvRUzqaFhAPIVUtmrj7+l5xq5fVDqFpmRTCc2wEFkJqugHwahEBPV8gPXCasDM+ranqRKVxIsI1z66blkooqKcWCR064LlA744xn7WNyQgDXIaUp2Z8dW0ZN4SnHx+3VVxca34ceNUuz8uckUxwM4mV38ok/Y7Zw9wJrZcRIiMQpbS2V91rvhiNiBGnJryac8KyVqFBqHaXTT0hvid3kSelpbnb8c6UUQ5eyvhu7+BWAx9NCWZDMf77QqX8asL7rnJ7c9o/hfspccbe879PD6IAuiKuMEcaJ4TjC6b5m48otZX3SZuwj7oFqaT9QGfz79tpyUc39PPVYnC45xa8lfpma8WMYWqYSpFFkPZGjLc8Qy/X/duNQbKuDudz8DAtvXxJta09rQbzpgsahEmmuFK0GQtri9uzvIVRMR3k43HE/NATxI5uNr3jY36Z2aXEV5Mk7wyCWrOoPof6gOIRu6XjvJGfG/KmAufckWI31Qvg1LA3bRmSGRgh9UnaE0As9c8bB06X534vq06aSTo3tQHCUhWmJul+Mzd8CpwYb9hc+ga0UP709eEmnvqHP5OryKWmiGBPH8NTGps6Dpuj1yikX8ngMs+hp3pWf6yK0tTtrnBIuNlcuVkp0OUrFH41yeqSav9BLZf/slx1tEnQv7/c27dxm2Wssu4jY7hf0Kge+3uVAP5yPHx5YG45Wb1p90Jzo//1uMPwZEgUhy0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(38100700002)(66946007)(54906003)(31696002)(2906002)(6506007)(6666004)(4326008)(53546011)(6512007)(2616005)(66476007)(316002)(66556008)(110136005)(8676002)(6486002)(478600001)(186003)(5660300002)(83380400001)(41300700001)(36756003)(8936002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlZEcjMybDBwdDcxd08wOG9OVi9yd2VFS1phOENDbEFSM0pGS1BlVzhUYnpW?=
 =?utf-8?B?WldwZ0E0Z3g1WnBiYXlVbmwzVFZsVDFVSlNUWmxVRHhTZlAvZ2xvU2xIRmwx?=
 =?utf-8?B?SGpySDRTR2Y1bUlHQlhwajFaQ1NPOTFxS1NEK3FxMXNaL3lFU1JwZDZ1VThO?=
 =?utf-8?B?U3dTN04wRlJ4dWZEeFFOWXkwbGp1S2xhN2pFZnd0NHV4MVlaR3lWWm52TVpp?=
 =?utf-8?B?UzBYVmpvWUhOMkJzYnZqYlp3Tk1EOGNHTWczTjhOSUpENnQ1dW13L1grVmRa?=
 =?utf-8?B?RlhHUUVMdmVLMGhVQ2FhVnRZUExNRXd2SW9zMFNTZnNxKzJ3bVV2S21ZajFn?=
 =?utf-8?B?ejZxVjZKZE9lKzBZbEdrZjM3SmpUdVhCNUNYei9jSXZQQ1RuaExIV3NSeDdK?=
 =?utf-8?B?SjlGTCswWVduZ2RPQjRvdGNPZ3ZvdEhjUjZpcmZtMU9teng1akFFQzU4dVJ2?=
 =?utf-8?B?azY4em1LWmhYaTRiZTY4RDFSZnlObzZsNmNoeEJ4ZG44eTBRU3JLaGN1R3d2?=
 =?utf-8?B?NWtPVGwzZ2JBWkdGSWt1TllPdzBxSUlreldEZkxnY1h5azV4MFlVQ1NONmIw?=
 =?utf-8?B?NU16NDZHeWxSeWlqelMvZElLRlBBeWJuUWlpaUV2emk5VkNXZko1elUzRHUy?=
 =?utf-8?B?UCsrRFNUNlp4b01BZHdyUTFQVWUxNEZSM1ljbUgxT3krM0VSQ2VTZjFaU21B?=
 =?utf-8?B?a0hvd3p6NVp1b1c0aUMzK2tua0o3TmtEU3d3c3pMQWRxTzVuV3U4S0xyd216?=
 =?utf-8?B?aGZFR0ZqdGc1eitVVndweFpraSthdWJ0dXpPK3ZUVzlXRXI2MU9JUFpvRFVK?=
 =?utf-8?B?d1U2bktMbTBXa09yVmRiQVpGK25aZ0FTeDVOZkdGT1JWNXIyRGM4Mk5jdmFN?=
 =?utf-8?B?Nys5ODNrL1hEWUw0clkzdnlycmYyZnhXQ1lVSlhJQU5xUW83VWpmRnhMTkNE?=
 =?utf-8?B?OG1YZStwZW9oWFZWK2wzSVFUcUxiVTloVXBoQU1mWkU1UlFPbVU3eGQ2MlV6?=
 =?utf-8?B?aTU4K0RMNXMzNUljUW1uamNMSHRseno0USttejFKZG5vWW83TzFqUjNUdzZS?=
 =?utf-8?B?d1VtWFlDa1d3bVYreEZzUEcwUHQvUk5sTG8vVnIwek5Ha0xrN2w1TytxZmhR?=
 =?utf-8?B?cTdZc040U0wvMXRMbldhL1NIM1owb2tDMWZTNEZIcmdQOUl6VDFrZ3I5b3ZP?=
 =?utf-8?B?OHJ1Y1dROWlGTjcxQ3FiUDVadndialYwaEVkaW9vM045cEJibG5JaXVILzVN?=
 =?utf-8?B?WFJGUE1RSEsrL0ZWM1dFR3JtUSs3cGx1d2pjZWhoSDg4aDRnYWNyajF4YUYy?=
 =?utf-8?B?RE12RXMyZkJlNDJ2SkJyeTZpWSt5dG9PV2RiS2RaV1dldHgvTWVpYnhhZlAw?=
 =?utf-8?B?RmkxVkZVSnJqZksxMmVBcEx6Uzcwb0JBeVJtYlR3WFMvVno2NWoxOFBrUDVM?=
 =?utf-8?B?VEVpTm9temNKMHJ5K2ZESnpwejVDVmVQcTZXOFAwM3p3NDg3NGsxUkdNalZX?=
 =?utf-8?B?SnBZWE9UMHRKL1JncXFOcFZGaHc5TUZYcWxEMVUrR2diem1MZHBlOWVMc1Fu?=
 =?utf-8?B?eURoYkZMSkMvZU1TSUI4Y1Z4NW5halUrNUpIV1kva2diT002OFdaemZ0b3pX?=
 =?utf-8?B?clp0V1M5Nkw2clFxbHJySmlOK2FNY3IzbnV0YzZNYnlnWGhtVmpmOStiWUFo?=
 =?utf-8?B?WEZxL3M5cVVrekFuOVVkdEN1SWcrMGNBUXl5WkRrY0Z2QVJMTVhBYzByekVm?=
 =?utf-8?B?dEpBVlg0TWxqQkJLQ1MvQkNhejZkQ1E2VHZTdDZieFZPVnRNRXZBVDRIZldH?=
 =?utf-8?B?T2NkaWhpNTJwTnpiVER1NXIwdzlvRmRYZ3NSdVRpdXMwZ2p1NFVLbUUvSHRR?=
 =?utf-8?B?bFhnelEzYzUzY1E2WjhwclFTTnZHVC9RdDZrOWNRY09ZVG8zcm8ybnJaS2Vx?=
 =?utf-8?B?Wlg3OGVzaVpsUmJTRzVMTDh5blRhM1kzeGtISXNCSklKeEpmeGxBb01PYnpt?=
 =?utf-8?B?OXFZOUhUbVZpaHFEV3owMHhmTWk3UDFKRkxjWmNrOHpTYUFybVJMVlRJS3VB?=
 =?utf-8?B?N2h2Ykp5SEJXem5tbWpwSElUeEtnMGpzRlkwYzFrTEQ1OUdCNURqT2ZQNXlF?=
 =?utf-8?B?OHM4UGFNT0hMcjRWYzBpSmFCOGgxUjJ6M0lET1JaZlVnT2hNWmRsQTNBSDBi?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5b3a21-87c4-4260-8120-08dac35712d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 20:06:37.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzcm/S8UeNMJYZyPYufoX7eWTEpUBsjkt+57QCJk0ETFFIPj6m5PSispQx9oJ7KP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4688
X-Proofpoint-GUID: MXBWpLtzI3ngAsGupnMfHmnmBkqZKAF0
X-Proofpoint-ORIG-GUID: MXBWpLtzI3ngAsGupnMfHmnmBkqZKAF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/10/22 11:37 AM, Manu Bretelle wrote:
> On Thu, Nov 10, 2022 at 10:02:01AM -0800, Yonghong Song wrote:
>> The new rcu_read_lock test will fail on s390x with the following error message:
>>
>>    ...
>>    test_rcu_read_lock:PASS:join_cgroup /rcu_read_lock 0 nsec
>>    test_local_storage:PASS:skel_open 0 nsec
>>    libbpf: prog 'cgrp_succ': failed to find kernel BTF type ID of '__s390x_sys_getpgid': -3
>>    libbpf: prog 'cgrp_succ': failed to prepare load attributes: -3
>>    libbpf: prog 'cgrp_succ': failed to load: -3
>>    libbpf: failed to load object 'rcu_read_lock'
>>    libbpf: failed to load BPF skeleton 'rcu_read_lock': -3
>>    test_local_storage:FAIL:skel_load unexpected error: -3 (errno 3)
>>    ...
>>
>> So add it to the s390x deny list.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
>> index be4e3d47ea3e..dd5db40b5a09 100644
>> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
>> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
>> @@ -41,6 +41,7 @@ module_attach                            # skel_attach skeleton attach failed: -
>>   mptcp
>>   netcnt                                   # failed to load BPF skeleton 'netcnt_prog': -7                               (?)
>>   probe_user                               # check_kprobe_res wrong kprobe res from probe read                           (?)
>> +rcu_read_lock                            # failed to find kernel BTF type ID of '__x64_sys_getpgid': -3                (?)
> 
> This also seems to fail on aarch64:
> ```
> 2022-11-10T18:39:39.2406543Z test_rcu_read_lock:PASS:join_cgroup /rcu_read_lock 0 nsec
> 2022-11-10T18:39:39.2409781Z test_local_storage:PASS:skel_open 0 nsec
> 2022-11-10T18:39:39.2413002Z test_local_storage:PASS:skel_load 0 nsec
> 2022-11-10T18:39:39.2418758Z libbpf: prog 'cgrp_succ': failed to attach: ERROR: strerror_r(-524)=22
> 2022-11-10T18:39:39.2422765Z libbpf: prog 'cgrp_succ': failed to auto-attach: -524
> 2022-11-10T18:39:39.2428250Z test_local_storage:FAIL:skel_attach unexpected error: -524 (errno 524)
> 2022-11-10T18:39:39.2431555Z #145/1   rcu_read_lock/local_storage:FAIL
> 2022-11-10T18:39:39.2435392Z #145/2   rcu_read_lock/runtime_diff_rcu_tag:OK
> 2022-11-10T18:39:39.2439296Z #145/3   rcu_read_lock/negative_tests_region:OK
> 2022-11-10T18:39:39.2443876Z #145/4   rcu_read_lock/negative_tests_rcuptr_misuse:SKIP
> 2022-11-10T18:39:39.2446212Z #145     rcu_read_lock:FAIL
> ```
> 
> Can you add the test to DENYLIST.aarch64 also?

Thanks. Will add to the next revision.

> 
> 
>>   recursion                                # skel_attach unexpected error: -524                                          (trampoline)
>>   ringbuf                                  # skel_load skeleton load failed                                              (?)
>>   select_reuseport                         # intermittently fails on new s390x setup
>> -- 
>> 2.30.2
>>
