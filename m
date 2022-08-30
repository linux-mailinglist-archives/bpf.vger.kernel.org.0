Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1F55A69DC
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiH3RX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiH3RWr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:22:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48647BC93
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:20:57 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UG2NDD010140;
        Tue, 30 Aug 2022 10:20:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ziz5czXMUqkYxf5Ke716HItukvWUC4MHB8ebnw9Sqeg=;
 b=mgZm1DZGSw/klfLuQdDHtRmcea+t5oOnLbHX9k863/0UNVFraVCPyNqjeWoKMM6sAX9y
 gb6eZlhLrG89JJIUNoquK/bbewlsP9XKiMtS9iRw5S9zoajfRxIU2ejG3qwk6nQ8KiX/
 s5J7kaMeI45sjcWySURm8nRy0vueMRmJKYw= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j94gydyu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 10:20:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjzBLzEEROW1cdoPJNvNoCdhNkmUPWtiha45cIT16hQtCyXO2JqIdsczvf31vtTwOv8i51KuKGjJHzH/TAq1XBta22plh9F+os4SRvHPyCwOHCoC82jJnyxxLMMYAgrNO9ouWzW94NzIhwDFSutKYvXR1EF4VeLDH1QDI167Ud0M3ial9hTMc+fGqo5be1Een+u8b+3x9ZMLaMwdMVb8310V5nPanaKgxQvLcv4niwXSdy8QpyW+Q8opfJrZGDjdG7ejb3ueCCb6CnyRfnk5HOPKVhWy2yBvPTWC15Lahd/id0CdquBY+E/L5QYkOj0/qjlnxNd9r6F2Tl9GmjwvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziz5czXMUqkYxf5Ke716HItukvWUC4MHB8ebnw9Sqeg=;
 b=lW14awD6e6V0xBldk7v8sz4QUdp25FZf16QTmQlNpXrCmecWy72LT0fz622KosZUXAXoDpXowVRxaMEvyWYsSJQ/rV0geNQoO+TAoIQMHjgC9gBSi6shwHWgT6k3wl5HWBG4RhWWGe6TNr04O96A+GubKFxNs8W0EPwy7ccO8i2Akn+o8jnj4P0z6ufFMVPQY0J9EQtar4JbEoAfEOOri2ONNecYKm5cZ88OpRODkv5ODRtQZ9aEukrOg80DpRh2t0oxrGqOZFbBpAcPgFPH+gP2mom8UJTjhxgkyyJy065UG2DKLhjM1gVSxfKz6SXR6uNh420tJlQg/AHzeRLSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL1PR15MB5364.namprd15.prod.outlook.com (2603:10b6:208:393::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 17:20:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 17:20:40 +0000
Message-ID: <e43784ab-ead6-c59e-1521-5e1d16450ff8@fb.com>
Date:   Tue, 30 Aug 2022 10:20:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v3 6/7] selftests/bpf: Add struct argument tests
 with fentry/fexit programs.
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com
References: <20220828025438.142798-1-yhs@fb.com>
 <20220828025509.145209-1-yhs@fb.com>
 <7cf3de93-ae20-3d76-20d9-67242a65408b@iogearbox.net> <Yw3+ZfsbBdqo6R41@krava>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <Yw3+ZfsbBdqo6R41@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:303:84::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c476c9b1-1984-4100-46a0-08da8aabf680
X-MS-TrafficTypeDiagnostic: BL1PR15MB5364:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZlk9gfZqomXCQnx8Lc4yXyUfxMPl5PGis3PbkadJrGrk0kL76Fc8MJ2g8N4AYwVqZY3M/mFXHe7D4AkOP71VWCYVZdyeUxpeDQaNYjnDBn2INcLuMmaRvE8o4+zr+0Qgs7UOjPjsTCcMqna/OOewrP9buj7nb64x+4H9M9vFLecpxD7L+ddIs7qtkEPr6eDOoe1QHinoxzGfDIP9NtlSu+MSol4jBX7fjSh8FFF/M+on1bPrDyBp3zUPyQcasxo7IEgWR4FTgIFTrbECGfUYWr5P9ClNz71hrIBcCpjveB+s652vAWCAk8B/xFOzMQ5KHSoTPS/WRl444MYIDGEsVbP9VHAgANTb0lb1LnqNaEdRGdEBiZrEdg4HCLQlrZHD4XcpN9MEZPDKFoLf4DGZiO/C7WRCnShrHR2Mq62/Hv4eoQslJSpGRt7g+vMuhIsSknL1HarNonjum//vM7u+tAGGl70VOTi96Ynlks6eOA3I7+HdR4YNZ94DD3Ie1M03YRsfa1zA5y9O2kLMtXCF/+eUHfMZGr0omkWhgLPW+G8La09bikTe3zY+I3zC+7e3nj5Aw8VMtO9vMBi5MBsSeQjnCkkNoitz9y7SDR9S/GP3xmP5WqBu98qIOD54akHtQbUpfdO2PnSgq2/2KN6cWsHo6B/0IkMFrwHP5PJwM3QdmtFft5o8QNdC22A+bWzxL3O8WIA1g0raR/qDA60SZmT45nw4Ct9A68Zko8187IeOQ4NAx/4JntT6XhutvSNBpkbXJKW+3YDWUI6q9EFnSfhuhIUmj6i/DygqZMe/Nw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(2906002)(6666004)(6512007)(6506007)(53546011)(2616005)(186003)(38100700002)(66556008)(110136005)(54906003)(66476007)(66946007)(31686004)(31696002)(4326008)(6486002)(8676002)(86362001)(316002)(41300700001)(36756003)(8936002)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEI4NnRrR1RLaUZxNEYxMURubThGaFgyNUgxWmNIVExvQVJlV1NVTXgySEZ0?=
 =?utf-8?B?RjhLWWFzdjJ0RGlhb2lZb1lvdkh0S2VZSkJERHd1UTdhNHM1NGVjSzJJUHNT?=
 =?utf-8?B?YnNJQlNJcEFMT3RCK2t3dHFPbjVINHNiVk9HVVE2dUExczYvTE82Q3Rkcllq?=
 =?utf-8?B?d3RycFlGbHNEYWdhZ2Rncmg2SEhxeWtlVFAwaFR5RlBYeHZxdjdjUXVRTE1n?=
 =?utf-8?B?RTJ2bUJSQjdVbEJhNjdIL0x0RmJ0aUpsRTkvOW5iTDl1aE9FeEFCSVRkeUZw?=
 =?utf-8?B?ZjhLNHNxWnp1NzJyV29lL3V4ZktBNHRlaWZEMUZNNkJwYUpSbHZPWFNBZ3FS?=
 =?utf-8?B?d202cUdERzljcUVZamwzREV1UzEyTFJPb0xURUNHYTVBbVc4VXFOTE5ORnow?=
 =?utf-8?B?MEpDWGVFRjZwdXBFUXdobCtaaStlVEVKZGUvU1Zac0pkaEZtSlJ1QVM5VHhL?=
 =?utf-8?B?dTNpcVNLZStyQUlIRGJLT1NGOU0vKzJORU9TazlEKzNyKzIyMkM1dE1JaGs4?=
 =?utf-8?B?a0ZpYlNVZHNQMlhWSGdhMCtyMjZRZ2R1KzFQWitlMENTbEg1Y0NvbnFCaFIx?=
 =?utf-8?B?aER2NFZCWDdjcm80eFpCZVNXZm1qZFE0Y1NqNlBEbnlHaGsrS0RQRTRtcG5P?=
 =?utf-8?B?TTJmR3hLbHZ2YmFuK1JMY1AzVG00VzBEcjVubUxUdGNqdFdQK2FUd1VjWE1o?=
 =?utf-8?B?VHlXYTQ4NkRRNzNyc2IyT05qNTJrN2dYTUxMUmlEc0haTEIxR0xhQXNCTnZG?=
 =?utf-8?B?eTlVbnFVRlhMd0VOeFFwNHVLRG9jcmxDeG91QWdac05TNmN6L2xFM3pBbUVV?=
 =?utf-8?B?cDlFN1dKRnZOREJxc2UwajNqendpWmk5REFqNk1TdzVyODRySWRLMlVOS1Qv?=
 =?utf-8?B?bHpOejFzUld0dDMycytSK3BGTWV6QTJvbXpvVGRGOExGeWt4Y3grWFcxVVBE?=
 =?utf-8?B?d1Uya0tMdVI1cytoRDMwaW9PZW5QcklGT1phcjZKZlplQzRJMVdsbFFYM05J?=
 =?utf-8?B?aWpLNTY5ZTZYM1JPNmxsNWw2dno0dU0yRmZtV3RYSEE5d3g0MWdjK0YwS3hi?=
 =?utf-8?B?bTZuUkVscmgvYXNldy9tYzUyR2lRa2JRNDRDSjFId0Z3T3lIZUdLWlJZOXJL?=
 =?utf-8?B?T2FUZCtYZzMybVRNK0tMY1hWSjJGeldVMlRsSW1IaTB6WC8xcVVSOXhWby8y?=
 =?utf-8?B?SHp2UHVOLzh2QmtnTTdBSklKZXBTL3ViZ1RGM1R1QzBpb1NGdXgrcXlwTzZN?=
 =?utf-8?B?UzkrMGJjSnZ5Y3RCeGs4OG5OVGRCdVpWa0Ireld1Vm4yVEJyQ3UvWVBRV0JG?=
 =?utf-8?B?VFdYRlE0czZWOHRDMDQ3Q0xsUE52NVhjM09JR1Y3a0lraXpkY2srSStzOW5X?=
 =?utf-8?B?RG5od0pLTG04dnNSMEV6aWtHMExYa3ozMURaOVlWbVdSdjdWL0hWYnNLNEc2?=
 =?utf-8?B?SlFnbTd0N0I0WHJmRUdMQ3FEY3VKMkxhVFBKQzdHMnMwS2VCYWk5bXQyWStn?=
 =?utf-8?B?b3ZyN2hEMDk4bi81Q1NKNFl4TC91emJMV0Y1d010NkZNRWZrRkpKMjQ3T29P?=
 =?utf-8?B?NCtXeWVvTVNteGZkWGtyc1VXRUVvYmtiRVZXWVFBVFk1dG41MEt4WWEyRjIr?=
 =?utf-8?B?cHNvNXVZdkNhZmlEUldkbm9JU1l6anEvajVOczJKQTg0eGExMm91SlVUWFpO?=
 =?utf-8?B?ajdIWkRtbTdpWktIdlVDbGo4MFBiZmx1OWpqWFFIeDJidDRvN3JNUm1kcU9x?=
 =?utf-8?B?SmZlUnhGN01wWUJuQmh4MDBZcjRLQXZtRkxUK0ovR0xUR1JjajYyZ2tkN2FF?=
 =?utf-8?B?MFI3dmlYTjZlVFNYQm1kZDBFSXl4VGVJZFNXWEhlaDM4TXFrUk5UdGtTVWU3?=
 =?utf-8?B?N3pUNkVIV09LbkdaTVJKMmFwYnY5T2cxazFnS2FXRXdITUxBdEVuN212RTA5?=
 =?utf-8?B?M2tnSUw0b0xHSDh4TnBMakJIdW1JK09PeTMyVU4ySnVMQURNRWcrdkN6UWNY?=
 =?utf-8?B?bktWZjllK2FDRXY1bWp1eFNYT0Q2OU5wMC9hazJBVzZMWG9WS2pBMW9lcDhv?=
 =?utf-8?B?WTJUTkE3RU5aM3ZmWlNtNUtCR2FHajc4U094WWRDaExNTDVIYzBKcjUvWEgr?=
 =?utf-8?B?MlM4M0FIQ20yK2tyTzRkOEJHL0J5clhBZmFla1k2TjlzMWpGNklncHNPdmMx?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c476c9b1-1984-4100-46a0-08da8aabf680
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 17:20:40.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvSMjR1w85QwMUGiG3+A1IEv6605KPrIrlwCr1Bj0PcD5qByz/Zb/l0o/gzonpf0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR15MB5364
X-Proofpoint-ORIG-GUID: 3-x8G1QZ14utUC1GPwB9D2u_1gwY0hVz
X-Proofpoint-GUID: 3-x8G1QZ14utUC1GPwB9D2u_1gwY0hVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/30/22 5:11 AM, Jiri Olsa wrote:
> On Tue, Aug 30, 2022 at 12:12:08AM +0200, Daniel Borkmann wrote:
>> On 8/28/22 4:55 AM, Yonghong Song wrote:
>>> Add various struct argument tests with fentry/fexit programs.
>>> Also add one test with a kernel func which does not have any
>>> argument to test BPF_PROG2 macro in such situation.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>    .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  48 ++++++++
>>>    .../selftests/bpf/prog_tests/tracing_struct.c |  63 ++++++++++
>>>    .../selftests/bpf/progs/tracing_struct.c      | 114 ++++++++++++++++++
>>>    3 files changed, 225 insertions(+)
>>>    create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_struct.c
>>>    create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct.c
>>>
>>
>> For s390x these tests need to be deny-listed due to missing trampoline support..
>>
>>    All error logs:
>>    test_fentry:PASS:tracing_struct__open_and_load 0 nsec
>>    libbpf: prog 'test_struct_arg_1': failed to attach: ERROR: strerror_r(-524)=22
>>    libbpf: prog 'test_struct_arg_1': failed to auto-attach: -524
>>    test_fentry:FAIL:tracing_struct__attach unexpected error: -524 (errno 524)
>>    #209     tracing_struct:FAIL
>>    Summary: 189/972 PASSED, 27 SKIPPED, 1 FAILED
>>
>> However, looks like the no_alu32 ones on x86 fail:
>>
>>    [...]
>>    #207     trace_printk:OK
>>    #208     trace_vprintk:OK
>>    test_fentry:PASS:tracing_struct__open_and_load 0 nsec
>>    test_fentry:PASS:tracing_struct__attach 0 nsec
>>    trigger_module_test_read:PASS:testmod_file_open 0 nsec
>>    test_fentry:PASS:trigger_read 0 nsec
>>    test_fentry:PASS:t1:a.a 0 nsec
>>    test_fentry:PASS:t1:a.b 0 nsec
>>    test_fentry:PASS:t1:b 0 nsec
>>    test_fentry:PASS:t1:c 0 nsec
>>    test_fentry:PASS:t1 nregs 0 nsec
>>    test_fentry:PASS:t1 reg0 0 nsec
>>    test_fentry:PASS:t1 reg1 0 nsec
>>    test_fentry:FAIL:t1 reg2 unexpected t1 reg2: actual 7327499336969879553 != expected 1
> 
> I'm getting the same, I think it's because the argument is int (4 bytes)
> while the register is 8, we need to cast to int before we check for the
> argument value

Good point! Indeed bpf_get_func_arg() gets a 64bit value and
I need to cast it to 32bit.


> 
> jirka
> 
>>    test_fentry:PASS:t1 reg3 0 nsec
>>    test_fentry:PASS:t1 ret 0 nsec
>>    test_fentry:PASS:t2:a 0 nsec
>>    test_fentry:PASS:t2:b.a 0 nsec
>>    test_fentry:PASS:t2:b.b 0 nsec
>>    test_fentry:PASS:t2:c 0 nsec
>>    test_fentry:PASS:t2 ret 0 nsec
>>    test_fentry:PASS:t3:a 0 nsec
>>    test_fentry:PASS:t3:b 0 nsec
>>    test_fentry:PASS:t3:c.a 0 nsec
>>    test_fentry:PASS:t3:c.b 0 nsec
>>    test_fentry:PASS:t3 ret 0 nsec
>>    test_fentry:PASS:t4:a.a 0 nsec
>>    test_fentry:PASS:t4:b 0 nsec
>>    test_fentry:PASS:t4:c 0 nsec
>>    test_fentry:PASS:t4:d 0 nsec
>>    test_fentry:PASS:t4:e.a 0 nsec
>>    test_fentry:PASS:t4:e.b 0 nsec
>>    test_fentry:PASS:t4 ret 0 nsec
>>    test_fentry:PASS:t5 ret 0 nsec
>>    #209     tracing_struct:FAIL
>>    #210     trampoline_count:OK
>>    [...]
