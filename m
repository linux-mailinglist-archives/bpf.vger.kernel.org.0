Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4816D9F2C
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 19:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjDFRt0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 13:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDFRtZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 13:49:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5D4359D
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 10:49:24 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EjU4o014316;
        Thu, 6 Apr 2023 10:49:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=kmeJ7QM+/rLBwAhOO0MINpUP0hepCkHsLLi6u8gehgM=;
 b=WtDDQKZXLBU0/a6knBNLi+ZapEK8JKaMXP5C9/vm+x4QqEn+OEf0HezsmkwQ0sGg3Ymo
 QtnZbMJ+XLOTD8UrlWiGCcVTYkTE5X+IPcvhZbdMlOSPfFTPgqCwcVPUpx5E2njX2VxJ
 RxYADfI3Rs8/ISQBnO9KTBNy8B20ORSknT8l5l7QFCKPLFjZo3JqkMUjSrZFGUhPNx1g
 SUs0/BQi9YmVkGwkYDgYELAWOXRzrVh6QaosC3QQFzzUQGbJAkRRvr4k6SZ9v3Pwy87U
 0VZsRr5ZK4lj1evarcroGdkk0Bk6r4GAPwplawsG/vmtL9Yg85Hm/wLQA5KOnydC9OUp wQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pt04ahbqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 10:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dhg8BjHPYkQW2KMUFYJL4+0tIJhvsPQQxt/+TpHUrHdwgKyeep3xkEsEAMPgU+vU5vg4T9SGCBGd5OneoewapMQy1ho7Nl4ndY5zBuGlMChpLLI1PRq2Cq38B/8QSa+tnjRoEX6Dy0IZMyLblEAU7B8L7soG6m5RHOm9KgEkNNClBgQMQHQYsPbHdTfz7w8pBadP79yyYmItL7J0P1uS4wt7CyaqOQcQHPbshv3NcXSFTmNES4LxT9wnK5/F0ELgqxiTY4bbf7TJwE6P/ifIdDB16oPj1EBRRkRqL8x56GtxpnB+3PwQ4CWezxI3+dGOv3+TkVx3u+8DYA2GJMyibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmeJ7QM+/rLBwAhOO0MINpUP0hepCkHsLLi6u8gehgM=;
 b=aYFTrLDkmtsE12uCHieVuXQdxOaHJnuNAhdI1sHN246rYDSpclISRVd0nAiI6xSBoP7XhzOIWXpkaFtHJFW9NwN13OOLqfIrHVzWWPt8IUZYO+amNa4res4FYmcDZ8eJ3FnStBh6IcEsA+6OxCqXp2AaB5UbTbkWCrOBciXOyyyLNbn4zVhljNerZHJ+uQYcJiYrEtWUIp/ybmgWKyjj1xD284Oy5blWApJN8yTuMbxUX+/LbU8T8giZGTWErIG4ppKebxW5wRu5WAHVBVUfogKVmclkIWC37cvpxRsA7VVWCL+j5J3/fuqsZ8nVvD7/ITYnzSzjYIR+iA6dvT18mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by DM4PR15MB5544.namprd15.prod.outlook.com (2603:10b6:8:10f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Thu, 6 Apr
 2023 17:49:07 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b173:3262:a66e:b7e2]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b173:3262:a66e:b7e2%8]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 17:49:07 +0000
Message-ID: <bcdb8bde-6aa2-5f01-f03d-53498330f623@meta.com>
Date:   Thu, 6 Apr 2023 13:49:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Improve verifier JEQ/JNE insn branch
 taken checking
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230406164450.1044952-1-yhs@fb.com>
 <20230406164455.1045294-1-yhs@fb.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230406164455.1045294-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:36e::9) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|DM4PR15MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: a0192014-2efc-402a-f1cb-08db36c73864
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOKbpY59jONkKQ73vsw4ZJdwaGYPdNhZJ+AOrTf4U3OD6iSTmY+RCejUoltLVaAGPmX0eJE5p8YyucSI6fYqbfQjYWb7bZayuN0It7nRRM9g9YQ69kuGu7Yq/WOik8vSl5BRPWTdsKLEKXhAeorSWtOdciRn7Hu4RYoNWFb4TJOvs0Ai5bC8SMivPlLbCCZOf7ls191rR+mdD+eT9QZfE+SFsH7Yb+Gr+LrO2jsHy/J4Zv1CE/uSgSe3MMo60JdwCXL5uoTiNSyp3e1zAnDAhOd1Tx8e7Vi8pwQ+HvJhVdanThXEhixa2b7SfpexIEcP20bZommIu/MU0WXfpc7VlVedNFREKutYL92kGSsfpls9qX/zQMiECsfKLptUjG2vxVe0+R2gOq3x9Twi0mJMhRNuuk5qTut81VY2KdgKDQMrswFJYJjs9+9aQEcDJgk5cAzWuBT98aN/rVGRXQ12J+2mXBR6ypR3ogd3Fh2RTme8ZwGSDQdpMzRslzA1t55MZVJ4pRgK61Ksuws/MTj8WbSR1Tp0PkxhKePNpmPypECHLXvztuMRKnIWp2DrWKZW/iX2LMfprn6wbgTbkCMtJdBHBQfW6w8osDTb1FMGAIXNPQLKCXiW/qb3/ozBzVU2Jk2U4/MMc53VSDWZ12mMSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(66556008)(38100700002)(36756003)(2616005)(6512007)(86362001)(186003)(53546011)(83380400001)(8936002)(8676002)(2906002)(5660300002)(31696002)(478600001)(6486002)(41300700001)(66946007)(4326008)(54906003)(316002)(6506007)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNMYnZpUVVqWGJEdzh5OGZtQmM1bEpxNEFZZ1BkRXdqYU1DTFZET1JhSllP?=
 =?utf-8?B?WlB1T2FXeXRPbFNGeCtyL25XamZ3eTc0R1NYRzV1SEkwMzc2bVdjZWtRcDJI?=
 =?utf-8?B?aW1UalFKbXNXVkpydzN6eEp5WGxzd1k1OEw4bC9OSTBBQTVuemMwWUI4ZTNX?=
 =?utf-8?B?QmlkM2xidHk5bVNRbmFLU3FNZStiTVJqRHF3ZnVMNnlwTVJOU21OUmVKMnAv?=
 =?utf-8?B?RldKUjAwOFl2bE5aS2xRVE13NzJOUkJKbmdKa2tiVGZLY2M2R0RSUG9uY1Zn?=
 =?utf-8?B?UDkxRnJaM3g4ZGdCNnlMWG82NkhHeHdzU1dDN2kxbU1pVnFkdHdka2xGZW43?=
 =?utf-8?B?RWFsZldjUDJqdDRzVGJHWGV1WmFHc0UyZGdya3hWeStXVzhZdlIzWEtPZ3lR?=
 =?utf-8?B?NlNlY0c5L3RoMEZmR3hCOEJkcElKNGdYTDcvU3MxSmF6d2p3NFI0WCtaNTNm?=
 =?utf-8?B?MUR2bW4rOExxb21KN3VjSjZkR3RCS2lOUEdwNjRiL3R5SGdpa3hJNkdNKzVx?=
 =?utf-8?B?TnNadzFNeWc4WEIxM1FVc3BWeVMvZ256Q25iZzJ0aHMyUFBNd2VkZi93NzJn?=
 =?utf-8?B?SlJhMWx2Ky9pQlNWY2s3K25wRlFCTEY0MmllbUlMeG80RnZIQll5OXAxNWdy?=
 =?utf-8?B?VnBjVUZvNjBIbTdvVkd5Q2RzckF3WmhwWWtNUlVzQzlaSDcxQndRSlg4bmFa?=
 =?utf-8?B?TEZRdXFyZWgxNjJyMGxOQ2EyZUNiZ0dncUplTjBSazFKMzVLbnFYcGpDallU?=
 =?utf-8?B?ZE0wUmo3YkNaWDU3ZnVXT3EvTCtrc2ZYaTNqWkJzeTRqMFVMZEdlRHp6SHBF?=
 =?utf-8?B?Z1oyQ1BQUzZrVDdZajRQTHVVWkZJZUxETmVLbDdqUGRPaFZveFBFSUYwNjY5?=
 =?utf-8?B?SmNkUVdIRmRTUnBTTDdxNzFGenNzV0hDdDA2c2dpblJCZ3J6VTVhOXhiMDE3?=
 =?utf-8?B?SFhWOVYvM0J0Z0lXMXB0MDdYYjhGb2tqRDhpQ0c1M2o1aVRQQWlvLzR3L0FF?=
 =?utf-8?B?OXZXbUtwR2NqUFNQem5vOEFUUStCNHE0SENXRzljZTlyejhUOGUyMGFxeFVy?=
 =?utf-8?B?RGswMkVNc1VIU2xpVmR0ZXZkT3huVFJldmFpcng3akUzckVYL0lkYi9YbGdR?=
 =?utf-8?B?VldBZkdUZWxGWERUdGxScUI0L21iWEJDaU9FUXBabGhJVm4zZGloOUUxY2do?=
 =?utf-8?B?YnBTbzRldlFTUXMxdkhlaUw5cXJJbjdiU2MzSXE3WksybklUeTkyak5RZTNm?=
 =?utf-8?B?cXZOYTFFQ3F0RzViRzB1VmNiMjVhRU1KTFlHZEE3S1VGZkx2WW82Yys1SlJH?=
 =?utf-8?B?eXZsSGp6RXZvamZVZzZUazdrcHZVdC82aVZZNGJOckw3WG5IeGRodWFibVdB?=
 =?utf-8?B?QThqNWxRdFJpZURBeEh1aCt3NEg0SmQwQzJnQWpsTzF5b0pMdmZJbkJ6MlZB?=
 =?utf-8?B?bXJoaEptdWlPNkcrMzlRL3RpQjZ3eHVQbjEvVHR3N3plK0RiQnVpcHBwM3o5?=
 =?utf-8?B?WXh5NitOYWJlejFxV2QwcW4vNHE2UU9meENVWXErcmlKbGFIdHdLeHA0b3BK?=
 =?utf-8?B?ZkxJczFmUTVPZTJYakVJUGxmWWpLQ3lJSzZqdjI3RW5mcFpOdzFubVB2MmFk?=
 =?utf-8?B?Uy9iUUNEZFYvRDIxSXJ3NTRoYWEwdmZQNnNxdGcxMCsyLzZQbGRzN3RkWXlJ?=
 =?utf-8?B?UkZ6VWgrL1FwZFM5eTJtYTR5cklYUE1BUEUwQmgxNW9qbVY5THZsVXY5YUtY?=
 =?utf-8?B?R3hjcExWdU5BeWNOd3lBUWdIUEY5R0xPL1h3Tmp5aWRmNU1hNlN2WlF6clpX?=
 =?utf-8?B?OHlBUTZYOGM4cEg5alEvREhCUnRsWVdMQjRoNEltVXk2TTNkcXNERGFCdlpP?=
 =?utf-8?B?ajFCd1N6UkRYV0JlTjByZlgveFFIbWN0YVlkVEc1NmdOYzg2eGdvM1hJc2hm?=
 =?utf-8?B?MEp5dU1ETU9rczJJSjNWNXg5SHFjYkJIeWJxRWw1MTlvdjRHcE56Q0l5RDN1?=
 =?utf-8?B?d3lVaXd3U1BUSmRWMU40NzBnR2hMeUhVTHRyZDFuMmVBZTlPY2pRcTJ5QjJC?=
 =?utf-8?B?Y3hKNTdhN0ZyTnlVS3QwZGZSKzZXVFlnMDZZazd5aVRpM1lIZzIzRmpKbWQv?=
 =?utf-8?B?Q2NaNnFvWEVqVlY2bk1US05RVUVjeUdkSkxoTEJUZlBzc2hKMTlCVENsanRW?=
 =?utf-8?Q?95xecjUwVp5/jjnxL6TnXno=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0192014-2efc-402a-f1cb-08db36c73864
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:49:07.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RY3KbK7PHQeNwGjh0cdDHuoBBV0qMa/ZtwhpsrPi6Kw8C404bx0EDztgrJk7c7e+dkj2JIbHoccDcqH4KG0KoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5544
X-Proofpoint-GUID: A6Q3B1pji8hw2LyIiA-OzXFA0ayZR09w
X-Proofpoint-ORIG-GUID: A6Q3B1pji8hw2LyIiA-OzXFA0ayZR09w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/6/23 12:44 PM, Yonghong Song wrote:
> Currently, for BPF_JEQ/BPF_JNE insn, verifier determines
> whether the branch is taken or not only if both operands
> are constants. Therefore, for the following code snippet,
>   0: (85) call bpf_ktime_get_ns#5       ; R0_w=scalar()
>   1: (a5) if r0 < 0x3 goto pc+2         ; R0_w=scalar(umin=3)
>   2: (b7) r2 = 2                        ; R2_w=2
>   3: (1d) if r0 == r2 goto pc+2 6
> 
> At insn 3, since r0 is not a constant, verifier assumes both branch
> can be taken which may lead inproper verification failure.
> 
> Add comparing umin/umax value and the constant. If the umin value
> is greater than the constant, or umax value is smaller than the constant,
> for JEQ the branch must be not-taken, and for JNE the branch must be taken.
> The jmp32 mode JEQ/JNE branch taken checking is also handled similarly.
> 
> The following lists the veristat result w.r.t. changed number
> of processes insns during verification:
> 
> File                                                   Program                                               Insns (A)  Insns (B)  Insns    (DIFF)
> -----------------------------------------------------  ----------------------------------------------------  ---------  ---------  ---------------
> test_cls_redirect.bpf.linked3.o                        cls_redirect                                              64980      73472  +8492 (+13.07%)
> test_seg6_loop.bpf.linked3.o                           __add_egr_x                                               12425      12423      -2 (-0.02%)
> test_tcp_hdr_options.bpf.linked3.o                     estab                                                      2634       2558     -76 (-2.89%)
> test_parse_tcp_hdr_opt.bpf.linked3.o                   xdp_ingress_v6                                             1421       1420      -1 (-0.07%)
> test_parse_tcp_hdr_opt_dynptr.bpf.linked3.o            xdp_ingress_v6                                             1238       1237      -1 (-0.08%)
> test_tc_dtime.bpf.linked3.o                            egress_fwdns_prio100                                        414        411      -3 (-0.72%)
> 
> Mostly a small improvement but test_cls_redirect.bpf.linked3.o has a 13% regression.
> I checked with verifier log and found it this is due to pruning.
> For some JEQ/JNE branches impacted by this patch,
> one branch is explored and the other has state equivalence and
> pruned.

Can you elaborate a bit on this insn increase caused by pruning?

My naive reading of this: there was some state exploration that was
previously pruned due to is_branch_taken returning indeterminate
value (-1), and now that it can concretely say branch is/isn't taken,
states which would've been considered equivalent no longer are.
Is that accurate?

> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Regardless,

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
