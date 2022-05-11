Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CAD524019
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 00:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348684AbiEKWLU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 18:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbiEKWKz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 18:10:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F6013D78
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 15:10:52 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24BJg68Y009582;
        Wed, 11 May 2022 15:10:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=MIQrVisolR9Q116+feuAMLPphIw08fsIDqoc7EjD79w=;
 b=PY+8DoCsaisXIez47DiHvhErJbpa6r9T0m4zSjsKp4zwO6G/jvQsfYhNx3nBrixpjpaY
 B7LROmCvxiK0jUmzIuAS+iw/3X5xfDoGDuJwhdUjBI0rqOAWfybPSxhWI+Nwl1Cn4wG5
 ZnxnBW5lJfSkpyQYNyXFpPYRAzDbN3Dr/5M= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fyx1h92xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 15:10:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAG4vffaOGzWTPQxGf3EqFmbNTY1Bmh6hbUcl1JptAhKnagHo5jtp7b1ocX70XFr/3DRBvikmSRrrgY69HMcyRo535+mZNOypTyDQXEorFmZpBq6scfSxEXCq0pgrE1LsINRCpC1YGssOAKt9AjUHyj51+Ou5zVwfONEsOZk9DKeJHo38oAqeB4Xl5mdrkmaCR0L8MGiDA8J8HhMcbADxpJmu5mI3VOHqMqmng5kFqL2H7H6qSpGy26FVwA7gdMBvESpQlX4zFdlo5WtOvcHjN6jsLEV0VPV3h61frg8HSjuqitCro40zqjSC+p9eGtUzAd02kX6lQYfL6ZE1hfE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIQrVisolR9Q116+feuAMLPphIw08fsIDqoc7EjD79w=;
 b=W0oSNVOUpu64JeCAMMguoI39bSeZIdL8zHbrdYiRj+kg9gOdOFHbNLoqt3IYPyS0grn3IRCvE1P+t7toKr9sbhURJmXfqE5l3W5TZwhpmX50a3Xp7h2SEwMotEOHunVkrGJWktZ67RfwG0QXNybvvVbub1EW+so4/vWcgcdgGVA9iU4YcP9z10NCZt/n2UJZCbE3vjr6OE1NfYYW5OxqZv2yj5DMDxWdTf0GxMP0Q2F5Zp+WY1R9/GpzXpHI7qXpuUkzxvCxU3zyZI0NcZXWCgQzk3aRh7xI1HWoMWdf3bJsjYMyNMfartgxLCdXMRBUo5j9lSouMGM7yNFmr5GFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by SA1PR15MB5094.namprd15.prod.outlook.com (2603:10b6:806:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 22:10:34 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::29c5:e5e5:39e5:7df6]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::29c5:e5e5:39e5:7df6%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 22:10:34 +0000
Message-ID: <a5f32630-85e3-f9c6-3afc-e6e862b9a820@fb.com>
Date:   Wed, 11 May 2022 15:10:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a few clang compilation
 errors
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220511184735.3670214-1-yhs@fb.com>
 <20220511190841.4oxswcsebp7teaa3@dev0025.ash9.facebook.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220511190841.4oxswcsebp7teaa3@dev0025.ash9.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::16) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7184cc91-2b36-499d-2388-08da339b122e
X-MS-TrafficTypeDiagnostic: SA1PR15MB5094:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB5094350E956B6211745147ADD3C89@SA1PR15MB5094.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eP27x9+zg8MFsl8eg3L8AS+HeegNrzL6fbY1MOc/vsNxEVdLhXW5QFPw9Km267e6lOR7zKsmQgcnWe5puUy9CxTYKjlG4DcjPBuQc3ODpHPGZPt1SI6hetjVo2a4WpjNLmjtjhNoSnsE3i6y9gJtGy0I2jd4/dmwfEmWV63q7FYtc4YEi/4toW2Hyy1QwxG+YZzkFVYn+Q2sMsSzC+BFsA/89Ttk/WcG9ekShkbiH5sXKG2PQewMtt18iFL60lmQjZcI1v4qCR8HcKF8h7y3AFbzaC5v6jizbv/CLU+00mA4FReXV6ekoF0oX5dlaMWPMfXQ+QRi3ugT6B8qKnNlvSzBPL1WpkzHncI5E8N9Z3FkYjEc9EDFklST0YXd1VDBnmsFRWbYDw6Ye/o97vpnpY4onAVJ8xsMakAair19tHmj/brtwkZIQ9y30NNertUpX/cb8Q9X80QzF8H7AVUhJE+OmYoibiIhPdvkaaTWrcCamJRgjPwKJz+6QZx7vjHFCoBeW2b/sAgeHuIT/b/weEpsSD1IINXn15omjDrNJX9w1zUJkIg04rVZrHWB0uYep/iJHgb11fvX+hO2Juf0Wet2EktweRu8W4JJ2GJs731wZr+uvCeZ33ugmo+pecvC5JAw6pC4b6QXv7ks3UWpZy3tT+HHLMjN7EstfbYIU8k/wXQ0QmQ3/2YqCHQwht4Cz27SnQDFOaGLRUFGI4J4vZ3Uc0RSzMUSKNVAIfsHKjCObZVDqCr1OjbTnNGyVVNQ3Gv5DZDYspOPl1vpXgBq/S3fqHGAgVlx3rOyV3lkpVP2OWbJeiWwmTR+pnBxq9Cr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(38100700002)(186003)(52116002)(6506007)(54906003)(86362001)(966005)(508600001)(6486002)(66946007)(2616005)(4326008)(8936002)(66556008)(8676002)(66476007)(6512007)(316002)(6916009)(31686004)(36756003)(83380400001)(5660300002)(2906002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0VxeEpLbUFFcG9oQ0xnU0M1V0JzUnB4dzkyT25mTXZlUndQLzVFcXIwUFRD?=
 =?utf-8?B?ZU9XcDJobDlhNDg0NXdOaWtCK1lOdDloU2NKYTQvWTNZRmhTYTdoMnJSUXNz?=
 =?utf-8?B?TmhKNk1RV0dLYVhLUUc3STMwQmlzZUpjek1PNHlJM1V5WEpNVUo1cWt6ajZr?=
 =?utf-8?B?dm5yY1M3OXRsbWpqN1ZqWjJweHVlUWRNS2tqS1VZTTdaR0tyajNDM3NCa0c2?=
 =?utf-8?B?b3oxSkE5U2ZTRnpqc0dYSFlqbFhJc0JiZDdxcXJMVHJ6SzVwbmZlS0c1dmpi?=
 =?utf-8?B?amNrNVZNMUhMVUlyY2xoQ0xRVzdNRnNWa3NUUFJUMVNaZXRydXNsN25qVGFr?=
 =?utf-8?B?STlrTG9SZDZqZStNc2U5a3lJNmRWMUhWT2dLZzJDbHh5elZJMmp1eUN3dTh1?=
 =?utf-8?B?L0VjdE5YQkZOaUtuSVd2YWg0NEJ5bmJoeDA3SlQva3NjWXc5SDZyZGx1ZXI2?=
 =?utf-8?B?K1lsSlF6TzNBMGxWM3gvV3U0SGRrOTB6VEkxOThDSjdSTDM2YmR4cXJhR0g1?=
 =?utf-8?B?VUc3MEZkN29vWEtrWkZNRURTZVRaVENEUFVuRGtUOVdPK3hMR1UwMEJFemJh?=
 =?utf-8?B?R1NsQzR4akNjV3FoQ3h4WGRvOGxMbzNpRmRUbFNZZ1NKWDc2YW4vekREbWYw?=
 =?utf-8?B?VXdXa1NhMjJlTnpqMlBSYm1hVHQzZ0FzdW5CbWFFdnAyNDR2YURXSkdQVTV5?=
 =?utf-8?B?ZHZuVmVCWTZ2UWlmMnkxRzNNMmt5VWV6dWlHbDBpVHBCbTRhaEp5bkFJYTVZ?=
 =?utf-8?B?aU1JYjB1RjF0OE9TbUlnaW9LOXJkWVd1UlJCV2h2RVNLc2JIamdpdCtHY2ww?=
 =?utf-8?B?QkswMFhsNlQ4aDM1akQzamNXT3I4dGVDYzQ3SW9LSmpHeEZoYXppYUx4OFMw?=
 =?utf-8?B?aWw3cUgxMlV3NHpyaDZZbERVN3lxcWhxdmgzTFhlanFSM2V0U2hnNS9nUWhR?=
 =?utf-8?B?ZW94RWt4QVVHQ1BNSnQxMzdoUWdhd0E3WGRQb3Fic1dKNGMyV1VWeU9UTjk3?=
 =?utf-8?B?OWRRT21VbVl2UytLU0JWaDgvSnpYYnhjZ1RwZ0lvbnRDcnNxeVoxTGpZTlhK?=
 =?utf-8?B?UlBRL3RHdlVSeitpcDBlRVBIc3NRaXN6U3p0UVNvcWIwUjlmcncrSjhZMlVG?=
 =?utf-8?B?R2t6dVVaTDM0aldlTTk1OGtrQXJ6cWc1T0ZCbC84Z2ZKMmRBd0ZtWWNXcmtS?=
 =?utf-8?B?TkRKVHEraVJYbXlSK09HbUlVZEJBMEs4bk5ZWk1FdWdFUmNyRXR3VFVvOXdt?=
 =?utf-8?B?R2pnVkhDa1h3dkE4M1dBTllRVWNIRWRpZ3h6YTFhbnc1L1ZnV0h3Uk5tdFFY?=
 =?utf-8?B?VXNyMUF5YjUvOGtHa1R0ZGpLRksyckR1NFZ1d1N4amdIV3hJSXZ4Rm0ycjRh?=
 =?utf-8?B?WXJhZ3dlWk5iT0xnQXJFbHBIUWtsbFExRTdZNGpzSTJmU0NDeVBYRkJack1P?=
 =?utf-8?B?RXRDYjFISG9KNk9NV2Ftdm45WDdPL3FuQjArR0VlRlNERWRwVFNjYmtlcXZq?=
 =?utf-8?B?blVPdkV4NVhJTzJIYkE4Zk14TU5UL2VBVWNuSnd3aHBHdWg2MHhaMDNIamlU?=
 =?utf-8?B?enYrQlAralBSNFlOSG0yVWRRSzhLSXcrYlFIcTNoeW9ZVFBkR3FNWWxyaSsw?=
 =?utf-8?B?bGMzYTAvWFlQYjVFY1RQTFJEb2VINkx4dDA1azMvVjM3SW53aDNrV0w4RVhL?=
 =?utf-8?B?R0duMFJkMHU3aXVNa2dBbHc3YitMQWIzL0t5YUgwckxRNURXRnplODVtY3JR?=
 =?utf-8?B?K3VNWFdoMExtUS9jaGpwSHZCWU1vSytjeHl0anNDTGp2dlVRWllqNzQrajRX?=
 =?utf-8?B?S2hrcnFheVo2dDNHeFpQYS9OclNqT3NjdmRBWmU3bi92YVJ1WVRmdlphSmV4?=
 =?utf-8?B?L0tDSk9VYzVrMVNLS0h2NFFOb1lZbGMvb2Rab0NycDVTbG55bTFKYU94SFpO?=
 =?utf-8?B?akVxckMxTXVsZVFQNUw3eFNuSFNpclExcTJxaXRtWjRpV25vVWNhQ3hPcWlM?=
 =?utf-8?B?ZHpkYmtDNnpPdkI0YTRFUjBRQW8wWm81SzcrSzQ3Tll0QlV6YVlOZFVMNVVK?=
 =?utf-8?B?eUNOckhRNWVqZmwvblpQSWtLcVR1eHFMVmFwVEsvWEVhd0lnaDBZbmJNUGVk?=
 =?utf-8?B?dXNFZEJKNlBjTmRoaGFZc0gwWStKc2c1Y1dCanVkSTNnNGZlb09ha1E2NTEx?=
 =?utf-8?B?bXRDZXdDS2MzZXhwZGJQZGY2SFU4SWNURDhLeUtHWEgvQ2dkNWIyclEvSG9y?=
 =?utf-8?B?V01vUEtnNGVkRDBCMldSTXFKWHVKV2RWZTVDNkt1MlpPajVYYmRqbzdscGRx?=
 =?utf-8?B?U1hUZjRtMEczTktYNGthVHRwdWxJSFRDWjF6S0JPNTZDMlViNmJOVEh4QVVw?=
 =?utf-8?Q?BFMbeFhuR1/Jp5ug=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7184cc91-2b36-499d-2388-08da339b122e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 22:10:34.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sZs7x22gYVZuhoXfjUOri6IRp3ExAGC5GCbdnFx6Dtxig+czyM14pKNad9XFv8v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5094
X-Proofpoint-GUID: R3o4Yr5H-N3PitnFRfUrPklASZlv8dHl
X-Proofpoint-ORIG-GUID: R3o4Yr5H-N3PitnFRfUrPklASZlv8dHl
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/11/22 12:08 PM, David Vernet wrote:
> On Wed, May 11, 2022 at 11:47:35AM -0700, Yonghong Song wrote:
>> With latest clang, I got the following compilation errors:
>>    .../prog_tests/test_tunnel.c:291:6: error: variable 'local_ip_map_fd' is used uninitialized
>>       whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>>         if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
>>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    .../bpf/prog_tests/test_tunnel.c:312:6: note: uninitialized use occurs here
>>          if (local_ip_map_fd >= 0)
>>              ^~~~~~~~~~~~~~~
>>    ...
>>    .../prog_tests/kprobe_multi_test.c:346:6: error: variable 'err' is used uninitialized
>>        whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>>          if (IS_ERR(map))
>>              ^~~~~~~~~~~
>>    .../prog_tests/kprobe_multi_test.c:388:6: note: uninitialized use occurs here
>>          if (err) {
>>              ^~~
>>
>> This patch fixed the above compilation errors.
> 
> I'd argue that these are real bugs that the compiler happens to have
> caught, and that the patch should perhaps be framed as fixing them rather
> than as avoiding compilation failures, but that might be unnecessarily
> nit-picky and I don't feel strongly about it.
> 
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 4 +++-
>>   tools/testing/selftests/bpf/prog_tests/test_tunnel.c       | 4 ++--
>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> index 816eacededd1..586dc52d6fb9 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> @@ -343,8 +343,10 @@ static int get_syms(char ***symsp, size_t *cntp)
>>   		return -EINVAL;
>>   
>>   	map = hashmap__new(symbol_hash, symbol_equal, NULL);
>> -	if (IS_ERR(map))
>> +	if (IS_ERR(map)) {
>> +		err = libbpf_get_error(map);
>>   		goto error;
>> +	}
>>   
>>   	while (fgets(buf, sizeof(buf), f)) {
>>   		/* skip modules */
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
>> index 071c9c91b50f..3bba4a2a0530 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
>> @@ -246,7 +246,7 @@ static void test_vxlan_tunnel(void)
>>   {
>>   	struct test_tunnel_kern *skel = NULL;
>>   	struct nstoken *nstoken;
>> -	int local_ip_map_fd;
>> +	int local_ip_map_fd = -1;
>>   	int set_src_prog_fd, get_src_prog_fd;
>>   	int set_dst_prog_fd;
>>   	int key = 0, ifindex = -1;
>> @@ -319,7 +319,7 @@ static void test_ip6vxlan_tunnel(void)
>>   {
>>   	struct test_tunnel_kern *skel = NULL;
>>   	struct nstoken *nstoken;
>> -	int local_ip_map_fd;
>> +	int local_ip_map_fd = -1;
>>   	int set_src_prog_fd, get_src_prog_fd;
>>   	int set_dst_prog_fd;
>>   	int key = 0, ifindex = -1;
>> -- 
>> 2.30.2
>>
> 
> I'm a bit surprised this ever successfully compiled. What version of clang
> did you have to upgrade to in order to see this error? IIRC I've used
> -Wsometimes-uninitialized on much older versions of clang.

I compiled with latest llvm-project source (llvm15 main branch).
Since latest pahole (built from source) by default will do parallel
dwarf parsing and btf generation when build vmlinux, you might need this 
patch as well for pahole:
   https://lore.kernel.org/bpf/20220511220249.525908-1-yhs@fb.com/

> 
> Anyways, looks good to me.
> 
> Acked-by: David Vernet <void@manifault.com>
