Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA064FB98
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 19:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLQSpH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 13:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLQSpG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 13:45:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8577BDF52
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 10:45:05 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BHENEnA029018;
        Sat, 17 Dec 2022 10:44:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZOcQdPkgzIcdSzRBUmh985OQdR4C/Fjh+sQEZVkCWgM=;
 b=YrDWzi6rP2K4oR9Rfg/Tptp92eDENlDEu3wjb9syNBL4xNvbVV8bRsbPyE9EN0dFRhsq
 AxpPmpxhRxuxAP7hMZL4Ux0aALSE81fwBuP3e8vD7FrNTddhqCiW5ahy7+YcJvlfO9rM
 plZHik8tKcQSXbhym7cHcosqjIn+RyKg5A5vVi3jy1BOQWbjm7EF5Ny5DlIQxI7N1sww
 zogWHPnXHkCBxzC+fW9Gj/feLJqrj+WfMUljST8OV66oUnapfmkFA6i/EJroHebi3vDU
 asR3KFWCaHYDJeAKBvsyMLDBmA0+h78e8xQdd9psSrNsgIokwIIGO3q4hCDi4D65XDTk 8g== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mhcbss0r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 10:44:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLNyQ4WhOKr/xAsB1pxyPIriBMSvIokfASUb9xE26Ci0rjpy07jL3OeP/bkD/KbUlhbypEdCRYuJMWdRD564AYvVsdbHJtuGudt5meqhQaNSs8irwIqGAQNnfdKlCaSsZ1c2HvHJFnCnB61nUY98/Hsf+xPfYtlxjWH3pA7OnPc494/fDFiU7QkT6XceuR7sxrF/WWGuOctV+mBIrRsJqnsxhjnJuCvsoZwBRQVYOiuu4TLSZiDhJAlTIgw/qaLbNx9VmdzQ185fEWbHUs7cRL/MgOGVH+NUuTxdO0A2xRl1n6E57/j+eBnCDREC8lhx+8F1azBmXaDhn3bcbRQlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOcQdPkgzIcdSzRBUmh985OQdR4C/Fjh+sQEZVkCWgM=;
 b=jZrUZQAz5hijJlOAjg1nT7itAiXwgFhGzNDS1hS1Hd8ZptVttBO1VgyhMSrNrLejG78Zc4/vSIXJZbhgxSOZ4JzypUBveNuww/rY6HQu2OwQDeYXLTxeQ4WRWZhfgAWSm4ULy/BDKbsj90zGxIvAVwLZO/mJVetuh5xJagEIF2p2+ZI+dGfQupgpgq828G1Mh17tJiZGjbGnelcKKFE0r1xL/XjNxx7WHWGswKLKJ+I8zOvN0Qr0QBSyD62hbIgKpIZjzo4+4PSoajjZFcVxpa1TRQLJO6s/uREs8x5k0lTVAL0M2l15o6zaOVtZ7T9FvMa+uog3L2NLu7d3HrBIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY5PR15MB4274.namprd15.prod.outlook.com (2603:10b6:a03:1b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Sat, 17 Dec
 2022 18:44:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 18:44:47 +0000
Message-ID: <4d855f61-2ec6-145a-b91d-303054b6cc18@meta.com>
Date:   Sat, 17 Dec 2022 10:44:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: support for
 BPF_F_TEST_STATE_FREQ in test_loader
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com
References: <20221217021711.172247-1-eddyz87@gmail.com>
 <20221217021711.172247-2-eddyz87@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221217021711.172247-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY5PR15MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e9847a-25be-4868-fa78-08dae05ec560
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYzhs0rFo6BA7ZIthFt0aMHi0ch1TBHx8d0ARoy4U63GDe4VMPQf5oSgMAVNMCN4GSRAfyRcZNVy93Q5ZsHGOxP8zGm5qrbrnno4GU3jo4iJ4gOvO4wizBO9hqBQU1+RLi+w0xl07ET5qddQfSrRGMhPEAJUfsfUnquC/z0PL9M2OSrpir9eUnOfQO9Bi5pdE5x9FqLPFlATyQvgFvlf6DZiuofMBTbf/QLeTtSO3hvcZbLhCyWdKcBvrvJP4L6dVLpNzX1iNHIVZDsyPc/D+gt6+kiJiXW622wPSRv+EHaQBTdZE97jqGAIk/VhXXVaSGLUusnM+pqKlTHbEvKjoggmVNMkD+kDT4U0THZlP9TXROhP+Qu4RATOHdXSS4oOOEwHW5lbgUQo7/RvDyIs2OCGkeBbsDONoDEgcibk7rTCs5t2mROeynasw03YnVFHCviY6hsvoR4hxuRzMQdNngdR9oyfb175rj88Bl74WCT95r0B+5Nu2ZckKLNR5jexFTJLsVh3iLPJV373mZyCg/NnKsjVQ0w4o0HlAECD6N3tU7qWgXCz2xNbr28Wy2lZpFof3IMBg4JEKFZEtIe3n7Ai5eEfuAmIph5VDMWNy0D2qW2wYLzNSDNabNnTkyXhnXvIvK+Jgqn8oWl9KJ6yChzixrBVVMzttAUTj4g+G9ni/Lfm0BblDMHRy7K9pvIpTlWA5/Uplvylkl0CvngbWZp4y+bHNaMq1RU2CCVDXKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(186003)(31696002)(86362001)(8936002)(66946007)(66476007)(4326008)(53546011)(478600001)(6512007)(2616005)(66556008)(41300700001)(6486002)(6506007)(6666004)(8676002)(38100700002)(316002)(4744005)(2906002)(5660300002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnMyM0RvdVAvOEtQTUhiT2IrTWNCa3dCUXY0UnFYbzlSK00wTDRwemtlOTEr?=
 =?utf-8?B?bWc4ZnZLaDc0SmRxRkl4T3lWT20vMjg0SG9pcXkrbWlCa2gwUzExcHJIc1RO?=
 =?utf-8?B?bk5GeWl3Qm5UVzdZcHk5ZFdsZEx3bk12WVI4OXZGN0dLai8yU3g1SzcvNGdU?=
 =?utf-8?B?Vmx3a2E4K25PMFhNUmpaZ05wTmdIa3cvbmtIWS9NWUFUdTh3ZzM4UDk2NUpH?=
 =?utf-8?B?eUdpbGZpQy9qY1ZSaFdBdmtkaUpwTE1STldjY1NLK0E0UDAzb0RNTkU0cmtW?=
 =?utf-8?B?anV5SlQ2SFVDRUNCMnJodUN5UXZ1TTRTaC9BeUVrUUkrVmdDRTNkdnlMNExH?=
 =?utf-8?B?TEhRek40WWZHM2ZrOWkwb1B5U0JNQVpRM3JpY1N1ODdrdFdhaTZ5RFBlWllT?=
 =?utf-8?B?VDFpUTM0MG40bWpIT1NINW9XaXFqb1VXcEhQeGpPaldtc2gwV0N0TmlVQUxN?=
 =?utf-8?B?MnRlbnlwMmNKNTRNbDZEdXR4TmNObmpEVGZqN3RxeXVzWjY5MnhSSkw3VUdU?=
 =?utf-8?B?SW5IQkNsdFNmSmtiRHYwK1IzaWU0UWlYWTd2TnBoWm44V1ovZHpNZWJtMjVN?=
 =?utf-8?B?d3d6eXZSQXU4OXEzVDZSVXY1bXVvenUwOUl2ZGdLNVFiOHRzaGZmcXhkcEJX?=
 =?utf-8?B?VEtiaFEvTlRFeVlMbzBFeGM2Sy9xMEs1aGFNTUcxdzJiSGUzWnZhbnZUOFRi?=
 =?utf-8?B?TmRyYlY5Wit1YkVRYldlY2dlVUs3U1ErSUtFSU5TRGpsTXFZUHJLRWxNMUoy?=
 =?utf-8?B?UTNMbko0UzFTWGhhcS9iNzdQQlc3TnhqZFNZVVRrNXl1K3VPclovWno0TExR?=
 =?utf-8?B?V1kzcytkdGhDQjMyZ2RFQU5nQ2M3UHd0b0pGN0xBQ0NIZmx2WHM2RFl1YjZ3?=
 =?utf-8?B?SU00OXZmMU1JQkJsS1UxK0N2RXdROUpkZVpzYjdHTVMxQWQ5UFBIMmpNRGU2?=
 =?utf-8?B?Tk5QdE5zcVZVZW1aNXl3Uy9uVWF6Y1ovQnVBMUI4M1BKU0pUelk2ZnAwb3Ay?=
 =?utf-8?B?NDNMWjBLSDRvblVHUzl4WHdUWnBJSDArUzlUNjdDeXBBdVphOXFNSFpuc2t2?=
 =?utf-8?B?R2V1Tm1YbmhNVmo0WStJT3NRU3dXcjNmS2UxRTR2dVlZNnE2NjVlM2kxc3Uw?=
 =?utf-8?B?ZlRPMHhrdXM5MUtiT05hckNzVkRMNmRESW5UY1FmSXZPazVUN2NPVTJCb3l1?=
 =?utf-8?B?ak1YNlJCTmFoUWJaaHk2d2JRekZ6V1JRQTZ0ZW9ORDhPeGRjeHdGK3NwSThU?=
 =?utf-8?B?MkZWaFdJUXpMeEVnUVUyanJVZWc2cSt1OHVVcW9LT2lxeWR4Znl2TDlKNnFo?=
 =?utf-8?B?RUdqbFh0bzJVejRtekx3MWlONTQ1ZUllVzkwQVZ4ZU5UZHJaLy93ZDRIUEZn?=
 =?utf-8?B?Wm5VbDlmRDdWWlRBdVk4K0czOXF6bXhiWm1LWC9maDUrd3VjYUxwNWdLL2pO?=
 =?utf-8?B?NDNiakxaeG5oNnBkNllyZVRtcGhRUlY0bFplQWpaMlBmZ0dhVHFrU1BlaFZu?=
 =?utf-8?B?SzhyenNhbDFpc0JQR2VLQ1RubnFnVnQ4b1hOWjYxaERQeFlTdHg4Rkl4Nlg4?=
 =?utf-8?B?K0NhS0N3bTFGTXR6dFRSSWVKVEhiOXY5MjgwS1oveVZXU3l3K043V2Rybkx5?=
 =?utf-8?B?UmhPYitNZWhJRzc5QnRJalVnK1ZjTy9kekxuQnd2cndoNE94Q3YrbWhvcnFH?=
 =?utf-8?B?dGtXaFZobW9GYVVhTmRlN2NuQ2xSakdzdCtrSnZaMHlmL3VwT1pMUXRZYU1Q?=
 =?utf-8?B?T0owckVIaHNzNzE4SDBMUkFnc2FzSEtjMHRYdGRhTVh6MmxzOWFKVGQ3WkY0?=
 =?utf-8?B?dWZpZ3BVcGVKd0VHU0ZVd0tKbzFhQUJMaE5sWU5XQmFYZ0o1Vzh0WDhYNXBS?=
 =?utf-8?B?U0U1TE1Wb1hWZTRWNW5lRjdlcitYQlhQdDhHOEwxYzJLMGxDVlEyM3FJN01C?=
 =?utf-8?B?UU5qUUd6c2UzeGk0MktXTHIvb29UTEZRRWRETUlTamhsYXhpdE5UYWVua3FG?=
 =?utf-8?B?Y1Y5NGhxUjJJZldBbUY0aTlkUjF1eHJmNUdxc1RzSUJvYUUrc3ZNS3NRRjEr?=
 =?utf-8?B?YnM4M0dlRWZRT3hlbFE2c1RweTgwVW53SzN1OGVwN3BURUduOXFmUXQ2L2tC?=
 =?utf-8?B?OHo3T2NZMVNOSlY4d0FPNjhNNmxySVlBY0FBWmxsSGpaeDJGZXkrbmJPaGhO?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e9847a-25be-4868-fa78-08dae05ec560
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 18:44:47.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJHWHQycFVTm0BSViZGyXyJGenNum4jccct2zhsYsWsWVjxC3foOu7C5mQYSYQL9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4274
X-Proofpoint-ORIG-GUID: 4_3mn3AMeNssg-xMhFDeECl0iTpNdZjz
X-Proofpoint-GUID: 4_3mn3AMeNssg-xMhFDeECl0iTpNdZjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_09,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/16/22 6:17 PM, Eduard Zingerman wrote:
> Adds a macro __test_state_freq, the macro expands as a btf_decl_tag of a
> special form that instructs test_loader that the flag BPF_F_TEST_STATE_FREQ
> has to be passed to BPF verifier when program is loaded.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
