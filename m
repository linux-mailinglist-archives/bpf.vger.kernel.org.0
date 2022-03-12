Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8030F4D6B7C
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 01:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiCLAlQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 19:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiCLAlQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 19:41:16 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E42C241B78
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 16:40:11 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22BHtnim020730;
        Fri, 11 Mar 2022 16:39:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rj0f4iEztEZKwJtBx1bCphPJPoICVvLWoCE5N1fDjyE=;
 b=UM50fAhk7SJUUxYM/T3YQcRAQgClrEMJNKlka3kA/SPstL0qiAtArJkzI5tKEmvlALLd
 U/lvEMY/9CraqkKW9yEQ05z3M5nth94rnFqunWS5d5Svs7/xAZj68bpEzTECoCMRwoPv
 YFawQPyrDeQEcxOK8I2bP4QJkqY8u71n2Xc= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqkuec1rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 16:39:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMXYtOjL/AF0oOrIu/6t4Gq3YcgzU1DgNEI+2DELckg1tBSYxBUOqAmAqzJafIwAmnSeVIeOuYGGB8UiQJVd8U/uyCSx7JlLsm9LKpMv3xOUyeoe5qKXgCxZmDV9CrG8LQlBeXDelczOyq1CWl+8tEsLJ4yLr+Qq1nCTCgsIV6IkP2V03nv0QpiF7kbKkXI9KM5D+JucimSEwzb+YYSFJwF1eZKu4XqDyznbpWE/2xHqJYc0ci3BeRWBi7M5kJuMIVjFWgRAfR1SBneBNz2ATSmnKud7bNZEd7CfetJHOGcaFLz6FmizAzodDUsp+LHp5WSN8rUw/a5+XI6AgnNCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj0f4iEztEZKwJtBx1bCphPJPoICVvLWoCE5N1fDjyE=;
 b=iVmmzcJCua3uCcUeP49UJ/DKXhTmGa6x4Jbsy4lLi9DAbji5YZkjRcoli0dN+2bL3YC8/a4+cHBou4Ijxf9/bvuWyqpv1Kl9APonwbnegcGqaqmRG6ESXzK9yoLWdJiT+gTqplBqCVmyg2hx+/8OpIvLoG4vx8E6y3hyGz4of+5+bRjMfKS129EJQ8JtAwsQ6J0N7UTOdvx+2FQnzwZ5u8Z4DfMoIsseHK1SnjidPpCk3FXJxsOcwPKY4Ba3vnMYqrSA9OkvNHvswp+aBH9Pm5JDGOzdX5JbpZwk9WYgvsYxw1x6iV7i3c54K7+1DGVUK/ryQWXj9k3/VvAo7tAJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1473.namprd15.prod.outlook.com (2603:10b6:404:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Sat, 12 Mar
 2022 00:39:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c5c7:1f39:edaf:9d48]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c5c7:1f39:edaf:9d48%4]) with mapi id 15.20.5061.024; Sat, 12 Mar 2022
 00:39:55 +0000
Message-ID: <e5a052b0-eb53-196b-c911-f904e5fd40a5@fb.com>
Date:   Fri, 11 Mar 2022 16:39:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH bpf-next v2 0/5] Subskeleton support for BPF libraries
Content-Language: en-US
To:     Delyan Kratunov <delyank@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <cover.1646957399.git.delyank@fb.com>
 <9f4b3d01-d47f-bb3c-0ced-b83978c15dde@fb.com>
 <35a4dc621d45df496dab781b22d710e2dabaa1d3.camel@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <35a4dc621d45df496dab781b22d710e2dabaa1d3.camel@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:303:6a::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34720676-aa7f-4bcb-aa87-08da03c0d42d
X-MS-TrafficTypeDiagnostic: BN6PR15MB1473:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB1473A3C4368303B0CA820EAAD30D9@BN6PR15MB1473.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16ICSnJfsxn+uVDPMKa/tWlZXK+9uDTzWdSuUV7L/DKdTrH0SL58LeBq1zt0qx5G0ZPgSnQ9aySmVvFPm3SwVA16n1fE2lDRVK/n9jMdhiR65OvikaYIvhBXYm9R9aspL1CVoTrk8F1ldbZoGFLPwQQ/p5qfPpUf+qBC2KiT3kvXNYZ0q+vZGEBzoL/RgrkcJj0gLsIb/tC6Q3WwrMUXjyhXZPQdt3xIxh9n+hndAfbkWcbSceHK6h7IIFF00+4qyAjYFrpYdXv0UK2a23iuakp+RU7Ic0F4EV6baka4M+3TzPa2sowiREvbFVqrJe5n3IW+9//2U9PXE9TTHbXmdfu2wCQN57KnwGpfzSf0cyknbSRKX6si1U3L+uK0NnQBArxmzFhqkQ+kNtR58DMcFlTTni8y4Ig3bX0K1ZKL8CQvtx2kNt/onA26tQG7NnoVqsZ3StHfcOKP+lVweLF/2KzO3ge/B3AYyLfxz4m9NbTmT98k1MdxWqTFOTwe4eKR4ksoRsXyo6Izl6JOD/4J0Yz3ip3OWOmE596lgcKyzOMVilO9IXIp9ZrV1msXPBRBm5o7tfPjpkJ3yq2A8s7aMUlzn6cUSAOPa8zUuon6MiSvMsJMIPzMh1d9GsE9kByboaTyADY7QmX4eLlOHwK4Zf6bW4cteIzc/bszAzrs/7Hx5r4SxbpViILN8152fR32DrafnhKDo9eh7LNDRoxBUd3wDIoPML0d8KW1ZLUltT1ExE2ImkcB5QRCQw81NGOa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(31696002)(186003)(2616005)(86362001)(8936002)(36756003)(6512007)(2906002)(52116002)(53546011)(38100700002)(5660300002)(6506007)(6486002)(6666004)(66946007)(66476007)(66556008)(8676002)(508600001)(316002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUpMdXVMR2NBZDhlOUhjOTNDSEFWdjUycVFYd2JEcFR5UzNMUUZpaCtIYzRQ?=
 =?utf-8?B?VFY5UlNHUTJWMlNsS2NWcUFZa0dRVCtFN1ZnYnBYbUdBYmwvNy9jSGZYaDB6?=
 =?utf-8?B?c2xvdjhvNEFtL25RbDB0clk2T2xQL1NoYXJnbFpBRXkraE1qbGFYTFJWd0w5?=
 =?utf-8?B?NEpEbUZQeGN4eWFTRlFwcFhYc3FrY1k0YzMxcTZqajl4b0dsbGV3OXAwU0tG?=
 =?utf-8?B?ZTUwcC9FWW9aRzZvUlNwSUJoYkkxUlQxdVNCMlgxcnlDVys4L1paNU9yL0Za?=
 =?utf-8?B?N3JVTHpVNkhFcitmdm5VNGFNWFNFa3FmeUdZSlo1REtiNnN4RWFmRUhiYnU5?=
 =?utf-8?B?UEhCR1FiU1g1L0VROGkzR28wWWN1dHVvekw2dXNscmV2aFdoTkZpRDUzY2w3?=
 =?utf-8?B?YlVybGM2aEtSbGpmTHRlYTRpbVJaWWlydXQ5SEZEZHBmRFkraTNycHZ4ZlEx?=
 =?utf-8?B?dVEwck1NMWZaSlZPMkUzUGNPbEhhby9iczQ0eTBZR2hZelJ5bTRJL3ErYTNY?=
 =?utf-8?B?cFQ1MVZITTJnT1QzNU45YW5EaWNWcC9sOWk0eG51Z2xEMkhFNXBqd0M3SFF6?=
 =?utf-8?B?aVFGN3prR2VEV09DcXM1Nmc4bTk2SEo5andEek5WbHNOZGRFVDZKUzYzMnBI?=
 =?utf-8?B?T2pkdEZUVFczN3JGL3NrZXNqeWg3TGtQUnBlTGNaTmFCbnB6S0JmYmxWM2Mv?=
 =?utf-8?B?VEp2Wkw3L1ZOWHAxNWw1dkRHTktWTi85azEvOGpGRC8xWGRLejZwWUJxUjNo?=
 =?utf-8?B?b3pOVVFnQ1RmQzlSNGk3K2hidXlRTWplVHpXRGVSYk9tS00veDBRZGwxVEJW?=
 =?utf-8?B?M1VXOWdoalBVbkQySHdWZFNDNTFTVzJrdTdvUHVTZU9ZTERRQ1d4UGQrdURu?=
 =?utf-8?B?M0tNT1orbHo0VHp2eC8xYU94WmEzS3hJb2hWVm5JWWVZaU5aTEJFM3JIUTRS?=
 =?utf-8?B?MG5WdTI2U1JNODhVaWxaUVpaV2xKelhhNElJREdQbm9XWGhkam5UbzBxbG1P?=
 =?utf-8?B?T1A3VldLaHFLTGM4U2phbDVQQmxDV0dtSkJWQ2JlZmFJL014cmZZa05HSUVl?=
 =?utf-8?B?eENDSUR2ZytTdWJZbzEzL2M3K2JqUzU3dVNYUWxUUEVZakdNeXNxY3o1R0pD?=
 =?utf-8?B?NWVVUFFtd0tRa3VSTHNVa0t4K1luVjNOL3IyQXlEWjI2eUE1NEp4ejErWjBT?=
 =?utf-8?B?OGV6L0ptcE1WVm9Mb2FndnRzNCtHY085MjkvQks5dXNzQ1U0QzlTemVmenAz?=
 =?utf-8?B?R2E4Qi9Gck84bEc0aGxmRDMxZ1R0akd5N21ja2YwbW04N1dKZ2h3eEtDYysv?=
 =?utf-8?B?eWsyKy80eUZVYy9HRUVnNnFtUUVpT0I5MFBOTkZ6d3dWV3piVjRhbFo2VnhP?=
 =?utf-8?B?SDdJYUg4L204WWdPbVR6TFhWNzNucXJWNlE0NzJtMWM0MU1rNTdONWROK2R4?=
 =?utf-8?B?cjlyT3FkLzZ0aGwybXVDM2NxVmFnV1RnTTRXYlVYSWVyMVo2MjdvN1VIVzdN?=
 =?utf-8?B?eUdXbVBON2ZockY3d2dnMzJhWlRHVld4QzBZU2Z2VXlGTHBOQ01abkFVZlQx?=
 =?utf-8?B?R0xsOFhwTWxoWE8zSVdoV2liUHVlL1E2ZjUwVVdxOVl3azFoTGpjc003NEtM?=
 =?utf-8?B?VFcvbW9hZkx0eGgwMXRGcm1ENUtOc2FZdmpvUVN2dld3Q1JjMm11OWptc2s4?=
 =?utf-8?B?YjB5VjZFR2k4aXY1SXEyc2FjeWxNR20yU3FjMjhZQnlHS3RrbDFKK01BZFBX?=
 =?utf-8?B?SGZSU3g2ZTVGT3dXYjdkM21QZVJUelZkcURYSHBaci84M0tvc3Q1dWlBK25G?=
 =?utf-8?B?Q0VBdUNxZnFsMHkrYVBjSWhmTnhUdkhqenB3VzhzOGlYU2xScnFCeHlKTnVz?=
 =?utf-8?B?Rlp0WVBNcStKb252UWhKRjNoWnkrT0FWRjhUQXJPU3FEM09nUkZUYWoyd2Jh?=
 =?utf-8?B?MnZ4VThudENYYnNwUVk2UFBMSTRDcGlybUZ2TnBGZGVoZDZmclVxQThUZ2VD?=
 =?utf-8?B?Q01sTTcxbmJ3PT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34720676-aa7f-4bcb-aa87-08da03c0d42d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2022 00:39:55.6275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgZuyBhSGO5x5HSzpAu6e8Owz793FTI8rqM6PgNRJcZNtHtvyoyJV6X/cnwl1Iqw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1473
X-Proofpoint-GUID: X0W8bIS9jsExbxU9gg2vtPUmHqHjnSM8
X-Proofpoint-ORIG-GUID: X0W8bIS9jsExbxU9gg2vtPUmHqHjnSM8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_10,2022-03-11_02,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/11/22 10:18 AM, Delyan Kratunov wrote:
> On Thu, 2022-03-10 at 21:10 -0800, Yonghong Song wrote:
>>
>> On 3/10/22 4:11 PM, Delyan Kratunov wrote:
> [..]
>>
>> When I tried to build the patch set with parallel mode (-j),
>>      make -C tools/testing/selftests/bpf -j
>> I hit the following errors:
>>
>> /bin/sh: line 1: 3484984 Bus error               (core dumped)
>> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/sbin/bpftool
>> gen skeleton
>> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_ksyms_weak.linked3.o
>> name test_ksyms_weak >
>> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_ksyms_weak.skel.h
>> make: *** [Makefile:496:
>> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_ksyms_weak.skel.h]
>> Error 135
>> make: *** Deleting file
>> '/home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_ksyms_weak.skel.h'
>> make: *** Waiting for unfinished jobs....
>> make: Leaving directory
>> '/home/yhs/work/bpf-next/tools/testing/selftests/bpf'
>>
>> Probably some make file related issues.
>> I didn't hit this issue before without this patch set.
> 
> Hm, that's interesting, can you reproduce it? I build everything with -j and
> have not seen any bpftool issues. I also use ASAN for bpftool and that's not
> complaining about anything either.

I can reproduce it in 50% of tries with command line:
   make -C tools/testing/selftests/bpf -j

> 
> SIGBUS suggests a memory mapped file was not there. I'll try and come up with
> ways that can happen, especially given that it's a `gen skeleton` invocation,
> which I haven't changed at all.
> 
> --Delyan
