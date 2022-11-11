Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D3625475
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 08:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKKHeN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 02:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiKKHeM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 02:34:12 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C197C79D12
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 23:34:11 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AALjJJx016466;
        Thu, 10 Nov 2022 23:34:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Ghj4iFzKN58WlXeTX99EYqOp8GZAUgX3Evepck9UbdM=;
 b=CcPifZRY7ixDQtMP0+n13E3Bu1NizrBBPtnnizl99IcRXdDfx6SWWZcbHXsjuXe0cmmQ
 gk/G6AQS9pwXQWiwALvh9UPRgPbltgpcOJiU99YYin+WfY501PPs3hcIRQzbiEk7sYG8
 M/yiN+GNmDH+/ysc7LM7nylbZGyuAnrlnEuQOzVeUEEVsQg6oIDIvGrQrGcy55agK1ke
 oOsKKaUX3skvhxeW1cYUo7PoTGE136aOatkI4dBEYh+2Cr1XvRqQ6miVRCM0Is3CV43z
 +1z3qENbmkV+1gGtT+ZgUSSc7ACjisFtjEh/vPnCm8VG4dVuY24NaCbgJrOfzBVP9qju wA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ks8pn3p6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 23:34:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0D6nZBrM/kIiLl7tQnItMpyQHnfzRqUEulM5DokhvonjiujoVxDyiypIAKUksTZZhfh4oCWnF+AB659KjMUzfUDwoyDmhZKLlakeYJo52+am5OMI6wuvyaSD33+1cRJwCIl1xrH27RFgqV8KiTxpBUQ6DHxleTM9lEUXIp1vM3eyJkk3tgpbsn+kh6SHaI7hQP09L2pmV5dzUyEZjibj+wFRz+onlETEoLJHBksc+uxzeWq01YYKjLI6JNnn2xyuXB8ttAvH6vfkUX1LQ4+o1ObzGw6mMIpb8jX27nXBdPE4HRBUp3owNzgvlbFC25BkCC6WuC0ISeJbvC5MaymEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ghj4iFzKN58WlXeTX99EYqOp8GZAUgX3Evepck9UbdM=;
 b=cf0Js6G7iT5u7pP/rMLbcG02P0bS3us7OV+4m7sY7EsxdObMHNZkTZxBs5W8OUSg6Tb1MMvT6Cfu+cWrxpuxA4h4zwT3e+iFvVQONUQhoUbB2oDk7lPtDYLENs1IGcysQcglYnXzL+rRl5i83ydFLzQUftohWklr4WQ1OiJY8xQ0HbE6SN4AWXqL7338bkxAuN7F5H7IcUw4shZQU/mJ11igU609Ys6gXs4wNdak/tvNRNBnvLQJ9fYv1qEyBF63gQA5H/i33/ANCkCa9MGYfluxnSVWEAAmDPwJoerZwuw3uFobwgzWr/7Omd2CMfz5CLp0IfUFL8M8jDgngPu4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MN2PR15MB4800.namprd15.prod.outlook.com (2603:10b6:208:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 11 Nov
 2022 07:34:08 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fc34:c193:75d9:101c]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fc34:c193:75d9:101c%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 07:34:08 +0000
Message-ID: <91787040-3612-e847-b512-a38a3dae199e@meta.com>
Date:   Fri, 11 Nov 2022 02:34:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: Best way to share maps between multiple files/objects?
To:     Grant Seltzer Richman <grantseltzer@gmail.com>,
        bpf <bpf@vger.kernel.org>
References: <CAO658oUrud+RaV4dAWQ+JYkDttgW00xyDmsoa8-vCeknQNjVtg@mail.gmail.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <CAO658oUrud+RaV4dAWQ+JYkDttgW00xyDmsoa8-vCeknQNjVtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:208:239::7) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|MN2PR15MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: bd43a26c-4b57-4f19-a337-08dac3b71e0e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cD/jNf89BOnXiqRNupzQcNFpM2bneGgfhoLsixO1B7xbXBEdpiZtofsR+trpPHVY2VMCrhLQaP0CZtAcrUpXPSp9sLtMbT9tUZivO0TP0+LnGszFbvvmMWDKp0iutQRpeDWn5JV1NdhQgp20zQGSeQk4R6vhYHHwxbB+sgo/8TAIx4E2+Cny6QZuYFdZdnhK/TlhZXkdm6Jhl1O99Y6YsTsqvZ/LIEzvorT8mqT4h2HfBqoTjNspFz/7ohIT6B4hZfVLcRhMbnK2mL9b2ubLg+oAP5vhEhw5hGRIrgsdE8SrbU4QOl80syd+OS1gZSekhvZ4IvuCp3yPUNgJIjeCxYxyKHu4HtpeHbd6C11GNcELai3D5wZ7pHjNODdGZEylyBS1j75vAzOCU5JVQ2ve3bE3u+LjE5jItoCpabJnTysoSjNK+PDfuGYQHfInLpIJUd7KJBoIPIzeCXqLwH1wjdP5fDooBw3BKDZuuFhtFhy3U4NnUhhzYmNhBLAMQGYjdPbQ33JLHojBAphRagxiSLCIq1te+Jp1zm35goY8/4zbj1SOW8YtyVBq7FIG0iYgwcZWs59RAiXorzKZgs4WzhTpBKkkFxLycl2R4Xk2KVimsBqcM48mqBzS4k8sKjfUwzhbfNih47ZKeSx4BI4XJHAInbTP4CHHd3Lw8zvU852nxMmIDp66XTAJB4GGx2y3BW7kEcMNnOmF2jW0964xwTka97M5UL9tc1/gMCCPm/sM2xavRlpwP9nJ1nKiMfy3gcxbUyhsB1oXaIf5B66KlbWDFQjIkxIYo8nH7sR3c2rJRbYAicrGARvELKdlfi3A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(86362001)(316002)(31696002)(41300700001)(8676002)(8936002)(186003)(110136005)(2906002)(5660300002)(2616005)(38100700002)(83380400001)(66556008)(66476007)(66946007)(6506007)(53546011)(6512007)(6486002)(31686004)(478600001)(36756003)(43043002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGFZUW9Nc2I3S0g1WTZsYTFubFZkVm1TQUx2TkY3T01kNUpIYWJTQ2lRZDhy?=
 =?utf-8?B?NXlsbzYybHEvZ1JtbTVlWG5ma25yQWVnYnJvUk44VXYzMzBuMks2bVV6czh5?=
 =?utf-8?B?dDJGQ2tlM1ZRZldGU2p0ekhFRlBuOGpNVnN5R0hoZEhNUkIwdWkwQ2JGQlZk?=
 =?utf-8?B?Zk1BaDc0SGVRTWJWTUhuckhiVlJsNHZ6M1Z0akQ2M3RNdG1tM09RQ2ltUURV?=
 =?utf-8?B?RUtiRzFCRlZJc2xGY1M5eTAxTzFwSjZaS2xxTENmWEM1SklkOFBXMnRnU2Zy?=
 =?utf-8?B?QUl6emh4UjVnL0lRTmMzM3ZMWVN0S3dRUGdZV0pvZzFJbDFsQVBBN2lHNk5l?=
 =?utf-8?B?Vm50Y1dXS2EwQkYwcTVacGlIOXBxeU9GZ2p4UXF4R2hobXFFaFFrVmVDUmdo?=
 =?utf-8?B?eTRPb2tkaWFqdmV2OWdHUWE3YitBUlA4RnFCQTRnWStHeFNZOFc2WXRQZklm?=
 =?utf-8?B?aW1paEJFS1lmYW5FVlRzci9LS1hobGRuMXRmQXFacXpKenhGbmVWam9UVksw?=
 =?utf-8?B?eWhFL09JLzg0cEE4SXBZS3k0eEh1MzZNRlhabGNxUFV6Z290Qmx3djRabUNF?=
 =?utf-8?B?cU9FR0Jqa3QzbWRKMFVOcGRwc3Q2S1BrUEc0QnFnNU40MHJ3aDhBb2FTUG4y?=
 =?utf-8?B?ditDbGMrZDJFKzhtbzV1SGtwZzhKTVVMazlZQko5S3NLaDRrd1ZHbGtZejBR?=
 =?utf-8?B?VHhUT3ZOQW16dmoyblZDSnU2N3NhYll5Z3ExZkt2djA3NEd1K2ZEUy9xWEla?=
 =?utf-8?B?SmNqQVcxc29IeWJ4UmlPcEZGbUloVFNEZE1XTkxid2RpNzBMOEhEbUplMnM1?=
 =?utf-8?B?Q2FqMnlDZWc1TXlMZTlGeVlhTDJVdENsQWNTOUlrRlIxTzNKWW5HYjRROStZ?=
 =?utf-8?B?eTVmZkt1MUNySkZuODdOSWxIZHJTcUNKSThwcjUwK3cwemxyeXVqS3dqM2JM?=
 =?utf-8?B?cXFHTWliaSs0bjFzcm9QblhNblJ3RW1Ca2doT01JNENxOHlFOG1jbkIwNm1U?=
 =?utf-8?B?emo1TUxlQkVxZ2UrZ0dzbEZJaktmQlMxK1FsS1VIeFQ4M2I2eHY4UVlhK0tZ?=
 =?utf-8?B?WDNxclBBdGRoREh6NFNwOG5PMm1ScytjRFU5TFV1Y1FYNDVDKzZCOHhIMXA1?=
 =?utf-8?B?T1grL2FQSFZvdW1JbW5SQjN1azBpQXR4dTJSbDhVVnlzTDdZYktnSEFXaXJw?=
 =?utf-8?B?ZEdXSHNFRzR6Snc5bWJ0KzR6RGRiYkx5QXJFaUVxOUJVY2g3dExmNUhIcVVu?=
 =?utf-8?B?cG05SnRnNE5yeHVLNlNmZHZxSkd5ZUVwUXE2Y003NFhBTUsrS2ViUGlTMUNV?=
 =?utf-8?B?VUJ6bnhPVXZodjBRWElNUzlsWlg5Q2JOdDZrNnhQMHRhalRnL21NTTh2RXRi?=
 =?utf-8?B?NG5pS3VWMHdxOUE1VFpuc0pRUndqSkNWVTZXS1pHa2NXVGRKQnVtVlFwNG0w?=
 =?utf-8?B?ejJkVUNqditmQnNpV1oySFZ3Mm8zVzZaclVxVnRWUkZ1elNEblVrZVlqK051?=
 =?utf-8?B?dW5IQmtPN0FSVDNzd3Fod1BRaU0xeC84L295UWIzV1hCTkR2dE1YRHBKemM2?=
 =?utf-8?B?dTJOOHJjSDl4WHlpT2NQTVZQN0dJNUxFVkR2SGxySVVrMW9KeWdaTm1hVjBQ?=
 =?utf-8?B?UFBNT2poQ2hqaGJQM1NqeUlPK1VWeWdIalNHWFZMd0lxZGY1UnJhcUNReUIx?=
 =?utf-8?B?aTYwRDIrdXZ0MTJFblhkcGhsRTd5ZEt0Z09LTFE5SndWOGlaR1RvV2NmZTBZ?=
 =?utf-8?B?QjZFdlhMcjF5UnF5MEFIS0NwK1VZcjVHeVJVY2RraFB1UnMvUVNLQU1zbXB3?=
 =?utf-8?B?TUhuYmxrMjhZRjhCL3hwUmRvaDdseCtITlBUL3c4Sy9DRzhLMG1KMEdkZUYw?=
 =?utf-8?B?clpKS2lNckNxKzZsd3lMclpidzg1ejJSSVhNQTNUNHVYakdCZVUxWUV5Z2lC?=
 =?utf-8?B?UVdRcHY2bzcxUUF4WkNpNDFrYWNUVVVHanFNRlpWcDZMc3ZRalVNc0NlK2t3?=
 =?utf-8?B?d0lBRU1IK08rV1RXdVFLZ1RoaVhWclV1bkdlLzhRN2JFR216UUFMUnB3bk13?=
 =?utf-8?B?UXlEUkJLTUlyVU9ORkh3bFQrTCtCQ2dMelgzczVoRnNDYWxUVHBHNUVzV2g2?=
 =?utf-8?B?alk2Y0tOOGVWSjBhSzVkZ0dGTE1aTFZWdWFReGF6TmwrWW5KUWtFYkFpQkNh?=
 =?utf-8?Q?49mNcIMiHheZbwNwXFRG9bk=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd43a26c-4b57-4f19-a337-08dac3b71e0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:34:07.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ax9JoqytJUvXOsCoXHJDS0Gfn2CryaOZGrdKNQKhHi00oGzWKL1ECDHcrWOx70PAnS+1sF9Br3woR4B9qdgnNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4800
X-Proofpoint-GUID: itXS0R-fcwiXOmKA9LttvajWzkUSTgR8
X-Proofpoint-ORIG-GUID: itXS0R-fcwiXOmKA9LttvajWzkUSTgR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_04,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/10/22 7:32 PM, Grant Seltzer Richman wrote:
> Hi folks,
> 
> I want to organize my BPF programs so that I can load them
> individually. I want this so that if loading one fails (because of
> lack of kernel support for BPF features), I can load a fall-back
> replacement program. To do so, I've organized the BPF programs into
> their own source code files and compiled them individually. Each BPF
> program references what is supposed to be the same ringbuffer. Using
> libbpf I open them and attempt to load each in order.
> 
> My question is, how am I supposed to share maps such as ringbuffers
> between them? If I have identical map definitions in each, they have
> their own file descriptors. Is the best way to call
> `bpf_map__reuse_fd()` on each handle of the maps in each BPF object?

Sounds like each of the source files have the exact same map definitions,
including name? And each is compiled into a separate BPF object?

If so, adding __uint(pinning, LIBBPF_PIN_BY_NAME); to
each definition will probably be the easiest way to get the map reuse
behavior you want. The first bpf object in the set that successfully loads
will pin its maps by name in /sys/fs/bpf and future objects which load same
maps will reuse them instead of creating new maps.

selftests/bpf/progs/test_pinning.c demonstrates this behavior.

I'm curious, though: is this a single BPF program with various fallbacks,
with goal of running only one? Or a set of N programs working together using
same maps, each of which might have fallbacks, with goal of running some
version of all N programs?

> I'd also take advice on how to better achieve my overall goal of being
> able to load programs individually!

You can group each program together with its fallbacks in the same
source file / BPF object by disabling autoload for all variants of the
program via SEC("?foobar") syntax. Then in userspace you could turn
autoload on for the first version you'd like to try after opening
the BPF object, try loading the object, try with 2nd variant if that
fails, etc.

selftests/bpf/progs/dynptr_fail.c + verify_fail function in
selftests/bpf/prog_tests/dynptr.c is an example of this pattern.

> Thanks so much for your help,
> Grant Seltzer
