Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53104B2BD3
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 18:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiBKRdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 12:33:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352192AbiBKRc5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 12:32:57 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1302390
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:32:55 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BEloXX007809;
        Fri, 11 Feb 2022 09:32:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=PVGeWRXgDqwQ4taJVvJqDa8X3hhtIxsnBuB93Vz+NBY=;
 b=SPZRUapUrjc+GTMnoEEAcyUlB3OrOzk/MQ/enMX+69gmt0bndM8LE8e/M5VPkh1jwe+H
 9BMm3TUUrHES1+v+1+lFc6Nxc0CBvenCKV3Bd3qzqO3WCLmfQJkVK8Ge4ghMeXoxDfKN
 gXxeQ8zyQ+l38AG/aZksLf/PY0xeFyHOvT0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e5853ff7m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 09:32:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 09:32:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU0fse0FKqQ3HH/gRohN8qQK7f3AuFPaQn5u+Q231wdNx48TCrWgrs6GrOEARbqXYh46sS9cbU8syfQ8/T5Yos5hbC1xPoBGQKf4vMOBJUSijbIQC/TrXw3nQpxPrBIBTgiqEUjjRpPnciRvT7MpbVFg77ZrEYZ13IhzvEW84vSHnR20tpXNvyHHugjkRHpYakwESNVnNIxWEfyrYTbpOKysu7wQ4RM/qr3Y3j3wQjFC9FZzgCz8J3FU1XCR3A2nGVLvHezV0dSD8+EfYjhd0T8c4lWYmcfWrrmEpArBRi0hO1B9+CcsS9MML82pBB1s9ZX/cSHsuKJ76B86vuRrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVGeWRXgDqwQ4taJVvJqDa8X3hhtIxsnBuB93Vz+NBY=;
 b=dJh3vN2cZp+poIPoPQN7e8KP4XambFc+thFlYcv+GCrOLDAmkv0KFy+mB4zOPF3+3CSbAfXErmy1/AqWoDl31N1xHyI/b6kzT73H1p+rogqUQ1VjRnIqP+bRf/LZlRfH/F74a1cWYy0DdD48awsnu78KFk7vYQZngSBv112zitFHpLu2pW7PJNFw2PAC5emlvMEs03lvDRLEd6J1yQQiy4GFKBrGBBRtRWtbHp7hQo9Umsj2lfbUCLBBOPegLwPlhECai6qag+CBtxRxdG8BvGzN1Uef5wOWHx4FYKyj1UmaVysUc1i7ODQskz05psCvpaLzXZXgth7fpsNWr4Tk9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BN6PR15MB1860.namprd15.prod.outlook.com (2603:10b6:405:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 17:32:39 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b%6]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 17:32:39 +0000
Message-ID: <f5f68d5a-91eb-84e4-d4fd-fc4aaa34207c@fb.com>
Date:   Fri, 11 Feb 2022 09:32:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH bpf v2 1/2] bpf: fix a bpf_timer initialization issue
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20220211152054.1584283-1-yhs@fb.com>
 <20220211152059.1584701-1-yhs@fb.com>
 <CAADnVQJAMf0u=7gcpuNVgx7DQ8Zayvg4KGHYnQ7eNPjbVmc=cw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQJAMf0u=7gcpuNVgx7DQ8Zayvg4KGHYnQ7eNPjbVmc=cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: CO2PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:102:2::43) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b09b7b5-8432-408e-a51c-08d9ed848048
X-MS-TrafficTypeDiagnostic: BN6PR15MB1860:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB18606E9B97CAA2D18827179ED3309@BN6PR15MB1860.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NcLu9x7bWtQde8BOIetC3m4cY4HLs3l5osZf3k+CaGICjdA672iPuK8nJGohjHbBSzD040HEJ3zF6UafkM5vbCBo5qAY0aUhYQAOEfqHzLolEoKAQTRcWdOgUZAAKeiEI3Ce3oqYinaVbwKA0EN0ciY9hCN6YdWvHfmggYsPbiuSt8SUh4gH3yAytMAzzNqRkND5gOeWiZxkjA6Er2akiYdku8p0nHsW4IsI6ery0hVy6Pe1FPe6e+O1Uzm2M962nFXuIXVGGj19H74aN76hzeqJItLlPcfWodUiCXBf9ZeBWxczM15bZUxCpBC7Sj+owTg91xssm9WcHwzLYJ4iRE4Xks59TkoNPVoFk7tsSHx01GaerxBDFweiGcI/9FxIOVoPe/MA++3SkwvqBzD5PRKQkCC9BCrcEG8fy/y5+yQe+uyfoMrhamur5WrFNWtyB1GfT9bFYNvB5+fVz/ELHFnblEKpQRrT/oSadJMla1DNbs+ZafVuUo2U50SW+69luiqzpun27ccs/69xpnkaAqp9eQ7hl+6sDypHQ0zpNAD3AB1AQRgrz5D5aL635DAQ9uKeGCy4T4QXXjt5ydKl58Q4DPs9FhO619/EpibkJfcbtz/TZV1PGea1wNTp5gTTtWZkAU5Tz60AWxqeiHTmFhpfKKNqVOSj607toOZU2CpFv/b7+8+kjYewO/gxV9uFNbeoq8oeMmfWLFxiTGXD04buE9CEg/gVHG+3wnVK305mTKYxsAB4BWugHufjler+w4yDQjs/YWggF69uLX45dL7hOUnNA3/H89b0Njw7IpjWPG90GukaLmVg8XcnkhZV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6916009)(38100700002)(54906003)(66556008)(8936002)(316002)(5660300002)(31696002)(4326008)(2906002)(8676002)(66946007)(66476007)(86362001)(6512007)(83380400001)(66574015)(2616005)(6486002)(508600001)(966005)(52116002)(36756003)(6666004)(6506007)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGxlOXNBWWRhWXhYa2EycE1xbkZSK1QwcUd4MElpS3ZuWEN0SlpRbWx5RC9P?=
 =?utf-8?B?ck5IVjB1R1hRU3A1MWRkZkt3YlVvT2p4Zkp3SlV6aVpSZk5UellOWHc4SnJ5?=
 =?utf-8?B?YUJYVkowUmI5ODJ4TUtQWlkrODd1aHVYckR4L1VCK3dBWEo0OGJqS1BNVjhp?=
 =?utf-8?B?R1NEelU3clk0N0pVNFpReFdQaXY4VmdvNGFXTDcvOE50R1ZLWTFCSStDM0F5?=
 =?utf-8?B?dU0wdFB2ODZ1NWlPMUFRMzBkaTFNSEo2U3JmeSt6UDM1L21FSnJZek9yNXJH?=
 =?utf-8?B?UUtpNHVmVlY1ei9aSXJxZGN1czAwOWxQVGdsTXMvK3B6WWtpeE00Tkx4MGVZ?=
 =?utf-8?B?TEVHSUdTWnQ3TXl2WUF3ZndOTG45QXZrRVNVRExmcEhadWg4YTc2MmJmVUVa?=
 =?utf-8?B?YTRPbHlOeUNsVldvTVJFNk9XazhMb3J3eUEzZ01Gdk5rMWNqRG5UQzVSaXA0?=
 =?utf-8?B?Y1JSOUJGRThLNkZrL05rT1hyQkVUeE00TmtrMUZobkZXTnVlRmFqdm5KU28z?=
 =?utf-8?B?Y3FqTzJJWW1LTkF0YVdJRGlKN3dJMzhna3lOc3pIYWtVY2ZPZi85QWtud0tL?=
 =?utf-8?B?OElVYVFrOXhLZ2kxVDh5VG9DcWhzczNTMEJsMVBTN2JXUVdoV1gzOXlxNWo3?=
 =?utf-8?B?d3MwamxlcVNiRENWSXpyNVczSVprK2ZmT3NJb3RyVVZFVDVsRnlJSnVuTjFk?=
 =?utf-8?B?VmEveURyN2tVTEh1S0NTODMzZDc4NXhSbTJ0YjZuWHRPTU1SR09zc1dyYXdH?=
 =?utf-8?B?SUVrcEttRVFLTlRZcGgyZVVOdVFma1A0N3Y0NHRtRGFZcURjU1d6emNnQ0hO?=
 =?utf-8?B?TWJDcWlHdU1YejRhTUo4QjAxVFRLRW1xOUx5WkhDYSs1U29hcHA3UnFZV0NS?=
 =?utf-8?B?a2pyekFmUkJmU1hSbFJIaklvNlltdXkxRmVXQ0d5UXd2RW45QlBNZm93ZE1h?=
 =?utf-8?B?blcwWnF4YnB5NWg4ZTlVLzZrVlh6L0RtS28rVCtZWjB5ZGxuQzRuMW1uWHJk?=
 =?utf-8?B?REhQb3k5OE5nUXZSK3E2K1dhcFlVUDVmWm9sZVRGdDZ4VVY2UDU0Z05vVTlt?=
 =?utf-8?B?aHhFKzNkS0xSQzBtZHYzcG9EOG9mb2ZnNWRsSThGa1hBSWVTOE5PMWJtcGpk?=
 =?utf-8?B?d3FxUE9CY0QxZ1I5RFZmVzVhTkdEVE5OR2dZWjVWRjdQRFh0K2VJRm5FN2V4?=
 =?utf-8?B?d2RlVXBOK0dXZkdsMENRRTVkQWY5VXJjN2VZdGdkWHp6aWY5Q1djc1ArdUYy?=
 =?utf-8?B?eUhXRU9UOGhFcGMyT2FWREtTY3E5NGhjNHpkNUhLWDJqMHB4Nk9xYUdScGlJ?=
 =?utf-8?B?a0FmMVRpZ3VUL3NCSEg1cE10ZXE0d3pRY1pRMDgyRzBtY2pSTDl5UEtaT1Uz?=
 =?utf-8?B?Y1hXc2FKTCt2cEZNR1ZmTDNXVDVmekZJMkdrMWxjbWpsb3dEVFNTaWF3YVhv?=
 =?utf-8?B?Q2FoT0N2eERKTTNoVmN1TzhZN3dpNmZkS1QxeEMrV3ROV3ArdDhHNWU0Z1NO?=
 =?utf-8?B?VEh1QWJ3TVZqaUU1RldlQ0ZUUmdtanVKTDBVZkZPRHZLMnorWFk4TWlqUEpy?=
 =?utf-8?B?QzFWcmdGbEVTWGRMVkRZYndFQUpRR0ZJSHp0ZkE3aEhDWXRwWGJvUXlWQnlV?=
 =?utf-8?B?Y0RUNThubEpyQWhieXhsWkJxRmQrejVkdjBVeE5PQ3Q4WGZvd1RMWDBoR0xL?=
 =?utf-8?B?aWN2MitoMUJoRkllTkJXanZkSG1ncWNMdFdabmg4WjNEYzh3b2t5RFl5Y0pj?=
 =?utf-8?B?dzQ3Y0dlOStyU09SNVBBS1QyVTI2bEhMTHRjTUFMRzRKYmM0VUZteVJhTDhp?=
 =?utf-8?B?VUE4R0Q3NEsrWmdKVTdRNmplemlxLzJoeVhPRlYzVytsRnJpYzk4TUM3dmNT?=
 =?utf-8?B?UVBLNzVhcmNVbTFxMm5STWdJRWMxa2h0bmtDSVNIbVZMN1dIcjAxK2FlZ0lM?=
 =?utf-8?B?SkJJSUxKUzNVQkxOYkVFTWJwd3Uxb3BkaFJVTmhqb0x5VkFDOHdFZ3cvYkRU?=
 =?utf-8?B?L1JUVGIveFVDZGFtR0VubzJHV2cwMysxQW41UUNlcU5NVlh6N0U3RytzS3VH?=
 =?utf-8?B?YmhQRmxmbXRUVjd4bmNKNURYd01mMFo3RlAwOFYzYnJiWUcvOE5Vc2FJbXRa?=
 =?utf-8?B?d040ODRtSVVxcGJFeHpkU1o0NDFoYS81VXBIaW02ekdpTnlNUG9IRmZiU1Zw?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b09b7b5-8432-408e-a51c-08d9ed848048
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 17:32:39.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZ20auSwLEQlXCg4Dqdv64QZeHzrKXZeYrPEUS+bS+vvl1qOGLOtPBajDkT8kCeJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1860
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Ids5zibpICFYfwddjADlxS-CQpkUzB_-
X-Proofpoint-ORIG-GUID: Ids5zibpICFYfwddjADlxS-CQpkUzB_-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 mlxlogscore=894 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110094
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



On 2/11/22 8:47 AM, Alexei Starovoitov wrote:
> On Fri, Feb 11, 2022 at 7:21 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>    struct bpf_spin_lock {
>>          __u32   val;
>>    };
>>    struct bpf_timer {
>>          __u64 :64;
>>          __u64 :64;
>>    } __attribute__((aligned(8)));
>>
>> The initialization code:
>>    *(struct bpf_spin_lock *)(dst + map->spin_lock_off) =
>>        (struct bpf_spin_lock){};
>>    *(struct bpf_timer *)(dst + map->timer_off) =
>>        (struct bpf_timer){};
>> It appears the compiler has no obligation to initialize anonymous fields.
>> For example, let us use clang with bpf target as below:
>>    $ cat t.c
>>    struct bpf_timer {
>>          unsigned long long :64;
>>    };
>>    struct bpf_timer2 {
>>          unsigned long long a;
>>    };
>>
>>    void test(struct bpf_timer *t) {
>>      *t = (struct bpf_timer){};
>>    }
>>    void test2(struct bpf_timer2 *t) {
>>      *t = (struct bpf_timer2){};
>>    }
>>    $ clang -target bpf -O2 -c -g t.c
>>    $ llvm-objdump -d t.o
>>     ...
>>     0000000000000000 <test>:
>>         0:       95 00 00 00 00 00 00 00 exit
>>     0000000000000008 <test2>:
>>         1:       b7 02 00 00 00 00 00 00 r2 = 0
>>         2:       7b 21 00 00 00 00 00 00 *(u64 *)(r1 + 0) = r2
>>         3:       95 00 00 00 00 00 00 00 exit
> 
> wow!
> Is this a clang only behavior or gcc does the same "smart" optimization?
> 
> We've seen this issue with padding, but I could have never guessed
> that compiler will do so for explicit anon fields.
> I wonder what standard says and what other kernel code is broken
> by this "optimization".

Searched the internet, not sure whether this helps or not.

INTERNATIONAL STANDARD ©ISO/IEC ISO/IEC 9899:201x
Programming languages — C

http://www.open-std.org/Jtc1/sc22/wg14/www/docs/n1547.pdf
page 157:

Except where explicitly stated otherwise, for the purposes of this 
subclause unnamed
members of objects of structure and union type do not participate in 
initialization.
Unnamed members of structure objects have indeterminate value even after 
initialization.


