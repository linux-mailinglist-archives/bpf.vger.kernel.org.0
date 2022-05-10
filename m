Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8CF52270D
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 00:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiEJWoZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 18:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiEJWoZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 18:44:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752031FD85C
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 15:44:24 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AKCvnO025051;
        Tue, 10 May 2022 15:44:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4NYqCsdQg4q1DvWhigA1NfF5A2X17MnSk4+nOiMAYic=;
 b=iLjbE9mXV5NlNaVs4o8gVPirytFkRebiY3NoYRLbefy+svVK0wl2lCbq0ZaKf5rkPFuY
 EDHNwi/61GOO8IdUxClklXydnftWSD7SNrVETh++O9Kck+ZdgqjYXRy7S6fG0HNXzicO
 /t4JbeFHAx+OlRRZTDQL8ZHhWHc7asO/rg0= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fym645vhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 15:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apl7XoCs5kBWz2oy7DtVyfswGnri7FUEyZru9n4vA4bLyvWWMXfVbrI7q+qGUPFXMctwZazjqzQx/8LjCGtl3yJ3pjN3/dLYfBnWR/gFych0PmIwhAcWUKcC0UQSVrBrCcUcQK32atNQFg/aA7Vk4dI4cGKOIONqcCbei5Zd7M3bpMID/1jvSyzvxK5UIPt1R+GKnYB20f+w2Vqyk7/Oy5majuENEkhmRofkJVIlHYfcXAdRFDQT6TN4yssVdjmzFTvXayBJvwHMIFoNTJIBIS23M3R+fNsLxFwL9Eo4dcRbsTaRXH/Y1L4gp3Xu2xgB8nAeT9ytqAfIVIvdQr+GXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NYqCsdQg4q1DvWhigA1NfF5A2X17MnSk4+nOiMAYic=;
 b=HP4Eh33B6oJ4zM4Rhi0v5MWu3VGM5bSFNpMWw9bwhReqi87gSgwsguBnCXxO1JkKtNYAyQXu24RvWSPM2pCYuNTq12pIRXP5WU/f3Wxr0YYJPL2ckXhY1r7ZdHsAAz1nStoYY2Wa103OvbbsByZMiA8YF2r8gMYYeXWtVtjhcaNbbEmfNJAArH2fgg6KTj2VJy6A4vqbqozBAlJNORuPZog5J1a1Gxg8xDZnOR99VEZAqRlBcu9ScuQ5s5yiVS5iPDPIEe2XfEWGS3J8uz26eiLb6oiv+t+bfAAvjr5Yblpu727ZjYkoyO2KqBrIlxxAK3WElg/vPnksfgaGi7z+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2336.namprd15.prod.outlook.com (2603:10b6:805:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 22:44:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Tue, 10 May 2022
 22:44:06 +0000
Message-ID: <00fc193e-4c8d-b8af-df68-198f90eaf1fe@fb.com>
Date:   Tue, 10 May 2022 15:44:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 06/12] selftests/bpf: Fix selftests failure
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190033.2579182-1-yhs@fb.com>
 <CAEf4BzYdMdx6jsr_2Rsq_AMif1aV+YvmoU21V8KRbRuWQB8v6Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYdMdx6jsr_2Rsq_AMif1aV+YvmoU21V8KRbRuWQB8v6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b673e53-b25b-46e3-5325-08da32d696e7
X-MS-TrafficTypeDiagnostic: SN6PR15MB2336:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB233635739BAF5E7DC27E8E70D3C99@SN6PR15MB2336.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtbMmiykmEMIwDqkzjm3736N6722VpFzlyEpAZ+e/2X3BIim+u+zWZ7nK7J10GEQ5K3zjnUg0m46rN4Srnjr+7U8NoLn8WecnVM8P/bbeAxzWp72KGJPOTdB1CpIXqQLkT/PGQcwUA+Eafxip4o9ZeSQh0Nbh7B+g+HUPKLDSXALM23dVWntlzIMWOSMCMNdh3ipMuMiPS+d4Pd3TPbpO8GKzGRpWjlaQ6sfFj94JBHi155WuVzL4rnQSjdxGriw8c0qWH1wQHNDDiPJ/e3+/Fu/+ljUgJn2lps24+8D9IVYMINVgNVqIyKfxAg1KD7wwL3MjAw/45yqMiF9tsu+pL3m+11VFFGUYZZkcUWPfQMdgCJ2pA8xRnrMJhqbum/aaToKarIrtcpQyezuz3DRxoioe2+ld1WKrFrqQI/pdZ5WmfLRPUpZyETfnE64TXntk8f+3dChd1salMhC/vV6SnntIhndhkFFeVntv+n6a59bCxqzaQItcmT362tsLRQ0Svxy2tJ7ml9HmpZpXwnLZKeT6KZGO999jgzoSaN/6N8Gyu5dqSTy8W7TvxAZJAzQO76/o6tEqFOybHQNmt63FSa+8RyU7+F5WnexpFCr9NAJ25lfTNQyA7E3YXduvcMCaTXWM3o65M3ffbwus86TrT4VBVTqJamo3Ebec0sw/i+c6a5kZtE4cCMrijmMlH1Jpvv345jmwci6dT+SWmz6M4roqiSzGZd/DDc77JD7OV2bt6/SugIerKYQvEpZQQQ6MrxuBgfewUyiRLPzPfgmkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(86362001)(66946007)(66556008)(31696002)(8936002)(66476007)(6916009)(54906003)(2616005)(38100700002)(8676002)(4326008)(6486002)(53546011)(6512007)(6506007)(52116002)(508600001)(2906002)(36756003)(31686004)(83380400001)(186003)(5660300002)(461764006)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDc2YkRjSGR0Yms3cGJjOG1acGVJdnNTMEszazdRdmFoUEREREpFL3ZFNWVP?=
 =?utf-8?B?Yk1qNGhraHdWZ1dWaVI0OFU2U0UwbEthSjlGb292RlpCY0dZYmxNQTVEcjlm?=
 =?utf-8?B?cWZlaE15eFpNYUU2eWZIaDNyWlBFSTBxNUwzMjNadkRqdERBTk53Y3hXb25I?=
 =?utf-8?B?czZUbVEzMlg3elh1NGpuTW1wcmxhVS8wOXhjeGZyNktwV2ZEZHVqZ1VqVzJq?=
 =?utf-8?B?SW0xV1dpeFplbVAycll5UTlkMk5lQUNMNHgzOVV1dlN1em5vVkRYdXVSMktH?=
 =?utf-8?B?eXJNSGJGKzRYV3kwVk1WYy95UjZ5MGxmL055Qmd3ZW9CZGhpUVhBMHFwOUtG?=
 =?utf-8?B?M3NwT2YvNjB6SkNJWEZHdmwweURnUFpjb1oxNlk4SStSR3NncXo5cndSdFdI?=
 =?utf-8?B?alkrb0c0Z3c3Z28xcTZFSi9BS3FDZFRMZjdsSEJOQ3pzWk5EVS9lV2s3bFNX?=
 =?utf-8?B?Tk1DajAyVVkwVk9tWnY0b0EzTWFuVXJWcTZhVHhjZnNHU1VpWlJDZ3cwZlF3?=
 =?utf-8?B?aVRPbkxvZjFEYUFxT3JiR3c2eUxSYXBKek9XeVd5dmVUS1NoNUI5ZUF1MWdL?=
 =?utf-8?B?TUI5a3U4UGZBUHhhaUR1VnYyM1ptbDBTRS9iMGo1UzcxNmZweWQweFp2Q2tl?=
 =?utf-8?B?V3VuOXJoSDZJWGZUTjNZN3haL3NUaUNyZzZnbURHeWFzRUd2MVk5OUZBMm1P?=
 =?utf-8?B?R09nWE8yUWw5ZTBOUTRicW1zVldTcElBdTdMODdzTFQxSmxsSTlLNnpJUFZz?=
 =?utf-8?B?RkhnYjFQczdnWG0wUUhnM1MvQkxXRmQ3TUtkR2pkVURRZHNDMko4ZzdwYkNv?=
 =?utf-8?B?VmFRQkVTNUhETi9JdUNBRmt2NXl3bnZHenptNG00ZHk5aHBDckRVM0Zkcjcw?=
 =?utf-8?B?NkJCL05obzhzV21DRWJ0OTdjR091VHFTenNaakRGelVPeGhMalJHUm9LcFJN?=
 =?utf-8?B?SXhRdW5NbUdvMkVCTXVlQlhVQmRrSHluOGdCeUU4VUwvM3RMZG5WSnlkampt?=
 =?utf-8?B?OUI4aGg1aS9ZL2RCL2FxbmNUWFhTRUtIQzRDMEVNZ0JPVkI2SzcyUkM1dFNv?=
 =?utf-8?B?N1NaTk8wTkJsMjVaUnA2NWdGcklSNmRDU0Z5amNwNTR6Wm5MSFkrVUkvR0cv?=
 =?utf-8?B?Y1hWTHprcm5CV1NaTlJYM1lMNlhqdVB1MmI0UUw4V28wYWd3RTBxYkdXWW1F?=
 =?utf-8?B?cGIyWU1hUE1CVEhIOGVreXNubGFHc0JMTDJFbWN5MDlMcDVqQjVwUHQ5Wktn?=
 =?utf-8?B?VG5jczlBR2l2MnozVVNoNE1UdFlRSVZqNE5PUnY4bEJPcWR1Y0xWc3Z1UlJO?=
 =?utf-8?B?MlR4aXhBSlZhbnFReEhmbmVXR0dPY3hSVVRzV0p4M1JWU1lsb1Zac1ZWL3dS?=
 =?utf-8?B?RmdJWjFMc3MyTGx0cWp1VDJZcGVFYUVjTnJjVnlVMU9FRG9aNFdCWXMrNThL?=
 =?utf-8?B?Lyt4Y0pzbWRoUEVCUTlEZ3JBUFgyTUJBUlZpMXVmQ21ZM0NiUE96ZjFnYUhR?=
 =?utf-8?B?K0NTSDdJQTB1alhheG4yRzlaUkhCWHZZSXpBRXFzK3h4c0REekFFZXF5MkJ4?=
 =?utf-8?B?TVZBMUtkMXVqRzdzUVdMSEpsaFFmWm1RdG44YzhUMzBTcDZLdlNRNVhPNVlF?=
 =?utf-8?B?OStWd1NwVVhXdVM4R1BFeHdHRW9ZZUxUTXN5OE5iOFBndTErVFYvYU9vVmIw?=
 =?utf-8?B?blVCbERYZWtCaC90S1UzNk1PbUtvOXNoZXY0WUNiQVJUb29Ha2NsaUVsSGc1?=
 =?utf-8?B?OWM3Z0h2TlJlMHM3MTk1K1czVHhraVBvMTJVSm9KS3M5V1FVWnpRbVJEQ2cv?=
 =?utf-8?B?eEl4M3dLcytOeHJjZGN6bHBLM1Y0YmtxZ2FOTS9jQ3BuMi8rY1ZKWTdkeURE?=
 =?utf-8?B?NDhSUUk3czA1Mk40SFIrUTB2L0k4VmdFakJzZWdUcGJQRkZ0MTE1MDZMVytU?=
 =?utf-8?B?VGFZUFRkMWVCUE84aS9UZm4rNkJJU2FhU1ZYb3VTdkRGc3o2Zzlra1lnSXNF?=
 =?utf-8?B?YUt4S0c1QldtMnZXMXZwNWMvdnZGOWtMK2dFdjZXa3VjUk1DemZlaG9OcmF2?=
 =?utf-8?B?cW9SVzZNSzBWdlB5NFRjVTBKcnBLdndvSVFWRkw2anM2by9aVnFDcVBRTVBL?=
 =?utf-8?B?T3cvMTZFYndMa2M0Nkd6SnhRWWREeFl1ZWMvWGtwQUtwZ1J3MXFkc0I5Q1E1?=
 =?utf-8?B?dVhJbG5rUTdqenlyT3E2Mm5SWEtua3RxMDZGbUwrNWNvM251WlhyVW5XYk44?=
 =?utf-8?B?SE9TTCtiL1ZMOE91USsxOXF1eG1ibFRycEtVd201OGVOVUJ0T28rNkduWWN6?=
 =?utf-8?B?QlZGN1BuNHlnY2I1cldWcnpZL1JkcXY5QmNEZGNFNW1CeGFsOUpwSzJIUWVl?=
 =?utf-8?Q?QObkGf5w5XWAs3cI=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b673e53-b25b-46e3-5325-08da32d696e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 22:44:06.3885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DYqF7VVMA1ksOZoPVpYkj1m/rxDqbvw0Bk9VsGEI8O04/WxdePV9NL3IByP57Mw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2336
X-Proofpoint-GUID: yGHMvDAvyhlR6P061AaoCFUnlm8vhxaj
X-Proofpoint-ORIG-GUID: yGHMvDAvyhlR6P061AaoCFUnlm8vhxaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/9/22 4:34 PM, Andrii Nakryiko wrote:
> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> The kflag is supported now for BTF_KIND_ENUM.
>> So remove the test which tests verifier failure
>> due to existence of kflag.
>>
>> With enum64 support in kernel and libbpf,
>> selftest btf_dump/btf_dump failed with
>> no-enum64 support llvm for the following
>> enum definition:
>>   enum e2 {
>>          C = 100,
>>          D = 4294967295,
>>          E = 0,
>>   };
>>
>> With the no-enum64 support llvm, the signedness is
>> 'signed' by default, and D (4294967295 = 0xffffffff)
>> will print as -1. With enum64 support llvm, the signedness
>> is 'unsigned' and the value of D will print as 4294967295.
>> To support both old and new compilers, this patch
>> changed the value to 268435455 = 0xfffffff which works
>> with both enum64 or non-enum64 support llvm.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/btf.c  | 20 -------------------
>>   .../bpf/progs/btf_dump_test_case_syntax.c     |  2 +-
>>   2 files changed, 1 insertion(+), 21 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
>> index ba5bde53d418..8e068e06b3e8 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
>> @@ -2896,26 +2896,6 @@ static struct btf_raw_test raw_tests[] = {
>>          .err_str = "Invalid btf_info kind_flag",
>>   },
>>
>> -{
>> -       .descr = "invalid enum kind_flag",
>> -       .raw_types = {
>> -               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),          /* [1] */
>> -               BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_ENUM, 1, 1), 4),  /* [2] */
>> -               BTF_ENUM_ENC(NAME_TBD, 0),
>> -               BTF_END_RAW,
>> -       },
>> -       BTF_STR_SEC("\0A"),
>> -       .map_type = BPF_MAP_TYPE_ARRAY,
>> -       .map_name = "enum_type_check_btf",
>> -       .key_size = sizeof(int),
>> -       .value_size = sizeof(int),
>> -       .key_type_id = 1,
>> -       .value_type_id = 1,
>> -       .max_entries = 4,
>> -       .btf_load_err = true,
>> -       .err_str = "Invalid btf_info kind_flag",
>> -},
>> -
>>   {
>>          .descr = "valid fwd kind_flag",
>>          .raw_types = {
>> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
>> index 1c7105fcae3c..4068cea4be53 100644
>> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
>> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
>> @@ -13,7 +13,7 @@ enum e1 {
>>
>>   enum e2 {
>>          C = 100,
>> -       D = 4294967295,
>> +       D = 268435455,
>>          E = 0,
>>   };
> 
> can you please also add btf_dump tests for >32-bit enums at the same
> time? Both signed and unsigned?

will do.

> 
> 
>>
>> --
>> 2.30.2
>>
