Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771174D9E53
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 16:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiCOPGV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiCOPGV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 11:06:21 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7114832F
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 08:05:09 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FEgU7C011199;
        Tue, 15 Mar 2022 08:05:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=svEj4RMtbw1pkGvAvZoH2dT6ewsSwiAdjxw5mXXynro=;
 b=gfkXda/SvWLqXf04OpfuglhA+eUSP3Npq1Q3FreWwNr8gvpbgRHoQZnlF3ZVt2McQlSL
 aG1nSuCZbLR02LHj/GqzQ/jj7Dk6u9AOIeZqEyuHIMEj7lt+KtinPdhjbnLIUcKevi5t
 Sh+mJhLCwvKi+HfFrzKslS4j4RK4WCbSIMI= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3et8vr7x3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 08:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmtErZY6VaNGJ92Br/kre5IcXi0V6VUMGy2tjy06bPe+78O6PrtmJVWPGXyqk1r97yvFh13keoYImCqdRi5k7lr2LczLgsJ7UjIHgt8d2mBJWElBBBQsDkJPVEJMFKN5w/5bIg0UzkzymPfzXwirr57r3bxXitYp7wNUd2cS1OzK4fXGLPCKEoqmRUA+/SN1N/+DoQZmtRG1aa01uvykBKX14svzeN3vuqQoxIhgCS24c8iM/dLvM7hxiTUPRzbSlANwYuC0BAuZWhBivQBcqF5P7vXD4WR6V/zNFxQnlS2HwQEeKj1r8i7jmdcUZn0MwrZxc0vFkHTPPF0A1k2hlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svEj4RMtbw1pkGvAvZoH2dT6ewsSwiAdjxw5mXXynro=;
 b=MafFudiOb2kf3H95hBVbe9FDj+kaTTm3ULgqvOjB5budZMwGZv5fO9X21sM+iXpzIlsPNgy9+6fgnDrBGImR4YwxKoQKQclpcNwMQlp1V0cYyE+4swePXZoREynXr3q30/ec1FkbBFfWYBwWaeLFpXOmpvCXbwguwrp3m8D8uy6GfA80vvnxmCN39BNv09MJNI6MzLBUpIZXn+ERO4cIASlLjHbXw6JD/UnfWvsFrahP7U9C+ud02si0dKoYeLNJ9zRzPbOp27Eu7+hgV3s4uTVdTlpab8bRLZhtyj0CDCaBk6lVxJTHa0A3n/eWnoTgMLI0t9VZRvrTEKXP6RHmqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by PH0PR15MB4717.namprd15.prod.outlook.com (2603:10b6:510:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.29; Tue, 15 Mar
 2022 15:05:02 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::df:de9c:3b7c:7903]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::df:de9c:3b7c:7903%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 15:05:02 +0000
Message-ID: <9c62401d-4076-9a45-3632-abb5f4ca4a47@fb.com>
Date:   Tue, 15 Mar 2022 08:04:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: direct packet access from SOCKET_FILTER program
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, bpf@vger.kernel.org
References: <4d91422a-3c2e-4d8d-407b-f4367e9ff966@suse.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <4d91422a-3c2e-4d8d-407b-f4367e9ff966@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b0bf96b-8091-4a71-c845-08da06952e5c
X-MS-TrafficTypeDiagnostic: PH0PR15MB4717:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB4717C51FCE1FB672A67A71B7D3109@PH0PR15MB4717.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voJ/LPGfkH2lhY5kuLC4vJWpUpz/qWk81N0hdePzvmYV/ju69UG81tbgb3DFNuoEc3aAnuoqqsnC+lN2ouZC4JSOHa6FAV37ST3W4zvBhVDqaPQu9P0O00vTUSWVHSHDMiodqVSlmXKPM9d/ShqykevFGJ05ItX86J3rf6UyGBWAVOIxfS/sozA3warQFShmNzelijn+ka4aKve8F62M0mVKzoeErBTzYe6P5nS8rkdWwZevoZa31XLlkO81nlNuYPxan288AlY6arkefYepHsq7dKvjwnwKogFpPdR0ETX8AOTcEU4of/ytB5b7uYrjt77k6EtxjjqVoiXcaRh3HRJAhFcuuM98NELgrQn87C3mpGQiKNzoQhB+aqI9txoUttBDkjwNkAF+hzHtEwlFH9yi3MyP5+9B8wqNHmN5swyTUdN255nTEc5+M0bDUKZVR0OqFH9GMIwibmzOE1pmUK2gmcMZY6AHh2FGeQpKp5xGnT64gg20tS3QDuODbW0EMG1fFwUc2+PsTmCOzv2ltFA56+7S02b63CXiQI63PBLHYOMDPLBSWOPGt7LeL0kSkvMuaFTT+O3HSBjs6dwlz0Gclks5nQBYV1cN4q2Tn2TMtrq3iwA9tHDZclGMuVIkhHcJWBGrtslMvoEXrArPuOQt+u3+CmwPtLhUTm8MKksWwjFfU4QT1Ap5/2nsycEtn4j4wFKSvO/4vjfP2zOtHcQfxCe3OBpYflcguV6fClo9NWm9IHp7dC8kAxXEMhzk26PfqynJxxP8g9gKJlRUnfDJUakuHLx0jqpP4/ecesRti0Zt5xOkz2Gdog1g/2JS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6506007)(6512007)(508600001)(966005)(6666004)(86362001)(8676002)(31696002)(66946007)(66556008)(66476007)(316002)(2616005)(83380400001)(52116002)(53546011)(38100700002)(186003)(5660300002)(4744005)(31686004)(8936002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blMxQ0Z4akxyOHB3OFllYjMycWJGNlNaQktidUcyTW04bU1VWTQvalB6ZkZ4?=
 =?utf-8?B?ZDJTZ202QWxFblJmSjNsWjlMTHVnbDZMMmxieGRDWnRieVZpWElIMGovQ3Nn?=
 =?utf-8?B?M2R2VjBwTmZBY0JBOXNvVEZyOTJUMjloeFR0TGJNZ2pyK1dsWWpSMW1LMEhm?=
 =?utf-8?B?RkY3ZGtCem5EaGQ2ZzdIUUtNb05uQkV5Y1F5NkFaZC82aEJsa05lZngxUFBa?=
 =?utf-8?B?N3RWMnZJejhzZFc5RmNqRUVCYlNjRWlYTHFWOUxRUkVrcXQzdHhId2VQVkx5?=
 =?utf-8?B?SU9XQXNDdGsrYVVua3k2YjZ4S0tXK1BwYlZHOFo4L0hPL2taTDhVMW1XTWFH?=
 =?utf-8?B?SENnOVJTdm9LcjlqZW1ZMFhzaksyQzZhUjBzUUhKWGUyOGVnc3U0YUdUNEV1?=
 =?utf-8?B?eWpiWUZTME1iZ2pXOGI2Q0VFVE0ycGxiL0h2QjNUa3VMZHYrZEpyVzBVTkJH?=
 =?utf-8?B?MVBsYWIrMFZwMEM4UTh1dEsva2cyTFRyS1QrS3c4OU9JUEZTdmxhZGZ1WEgx?=
 =?utf-8?B?VnBDZmdTQzg3cTJoUEVkeDhiUGtjeHVJbTlVb3Y3NFFFQUg4TFRNZjZuNDMw?=
 =?utf-8?B?VE94bUlCRkxuaGp2RnpsQjBsM1g3a09FTnk5Yk5uK1ozVGNoZ0VnU1A1MHNk?=
 =?utf-8?B?bDdaQ25IYmlUQ1BmU1FoMjZVTVpDNkRacVJ0NWNjdUk0MllDMmhMZXJtaGVD?=
 =?utf-8?B?dXBhMVRtTzNtdlNvRVQxcWxIUXZrN0ljdUhiNkYyeStQNnZ6QktXamFHVjJW?=
 =?utf-8?B?akFDTjhNRTU5SitMVm9vSGpNQ3Mydm1kQ244UnVURUZmWEI5ZVA4T0hkRVcx?=
 =?utf-8?B?UlZzZWJGUFE5bFZmR0tROGwxQTFEVGNwTVdzSWZHUmc5ZVlpSVdvQklHMWd4?=
 =?utf-8?B?S3MyRUNnSDhPR3BUQWYvYUFqM0ZJVmN1WDNGR1VSdGlxS3psU21pSFFIemk4?=
 =?utf-8?B?T3VSQldIUlJwZWN2RjFHcHZKTlNBYU5MSzI3VEhXWTJtTkRiT2dBZ2c3SGR3?=
 =?utf-8?B?M3NJTGJDaHFYTWgzL1gyTVQ3UXVIVnJXUXhCeU5vSmdHSmVmbkovN2hzeGpF?=
 =?utf-8?B?NVh4Zk5hcDEzcWY2QVpHVnRNaEU2WGUxVXR3d0p5dTJFSzZHdzJDS3hhVXhX?=
 =?utf-8?B?Y2tMSzZvaVlkb1NjVlJidmMwQlNoRXcyYzBmRzl0eXlzZEpQcWlKd2dvVEM5?=
 =?utf-8?B?bmVBU2dpSVo2NU56b3ZxTTJqQnZVNGhxd1htQnFwQlpLamJNMGhMcFBLY2I2?=
 =?utf-8?B?cSt5UkdaNTJVazhiRnBFWUZSOHJhUmgzM0NaNmlFbWhhR1QxYjRGVVVacmpB?=
 =?utf-8?B?ZFZpN3F5MmFOMzZwbUVmNFY1N3UwYkxyQ2RBQUxLaENuR09ETWYvUVBLZFZN?=
 =?utf-8?B?dERSdGgyNUVxM2s1dUY4Ly83bmhySUdjbGVRMnJpRTc2bWQxRUViMUQ4eFY4?=
 =?utf-8?B?ZFR2ZmhXd0ppc0RqZWUrQllwUjhYRllMTVBpckJiR1hkUEFCS2VFKzRtUlFM?=
 =?utf-8?B?YnBYZFdrMjZoZ2p2YlRUWWhCU2k2MHdhTUQ4c0J1Ym9wZXUxNGQ4TTNUNmd6?=
 =?utf-8?B?am0yc0IrLzNQV1JiUVNOUXZNRE5LVFkraHNyREVVWCtEWlg4REJzQzNldDJC?=
 =?utf-8?B?ckIramY1NkpNWS9pK3doKy9Ob3Jjdm9INlRVZUthQUxSTVVxdTYycXlFaFVB?=
 =?utf-8?B?dlJ4UUFCV2tkUmJ0bU5vVTFjK2VuWDMrdGVZT0FBNC9aVWVNbzJvQWdhM2xh?=
 =?utf-8?B?eXhRYWtoRzB4empyZDVPV2FsTUtsd21HcklWNTZZalE0djB6K0g4UitDOXgw?=
 =?utf-8?B?dnNZMEMxVEJuU0pGWDlRWHBBb3UzYUpnRFh0N0QvQ2VnMzgyd01kcm05Q0tt?=
 =?utf-8?B?YVlEeC85d3BQTXk3MkJ6SVFwdHpxQkxUc3AzK2puWEduREZYWEYvRnVKMnVt?=
 =?utf-8?B?VUp2bngrRXlBa2J4WEl2OHlzNng0b3NoNGNsRkF1VTRxVXR6cFVjbUQ1WTlK?=
 =?utf-8?B?SkpxRmFWTldnPT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0bf96b-8091-4a71-c845-08da06952e5c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:05:02.6103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uswYQMKhYMWsu9IY9x1EPucpUTw6V97tow7g4N9BA7DsVx2cDDrTE6Z1XvCjhDU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4717
X-Proofpoint-ORIG-GUID: z72gSCqVHtg9RUllqHhkT_h_NLAPmgCQ
X-Proofpoint-GUID: z72gSCqVHtg9RUllqHhkT_h_NLAPmgCQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/15/22 4:09 AM, Nikolay Borisov wrote:
> Hello,
> 
> It would seem direct packet access is forbidden from SOCKET_FILTER 
> programs, is this intentional ?
> 
> I.e I'm getting:
> 
> libbpf: prog 'socket_filter': BPF program load failed: Permission denied
> libbpf: prog 'socket_filter': -- BEGIN PROG LOAD LOG --
> 0: R1=ctx(id=0,off=0,imm=0) R10=fp0
> ; int socket_filter(struct __sk_buff *skb)
> 0: (bf) r6 = r1                       ; R1=ctx(id=0,off=0,imm=0) 
> R6_w=ctx(id=0,off=0,imm=0)
> 1: (b7) r0 = 0                        ; R0_w=inv0
> ; uint8_t *tail = (uint8_t *)(long)skb->data_end;
> 2: (61) r2 = *(u32 *)(r6 +80)
> invalid bpf_context access off=80 size=4
> processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 
> peak_states 0 mark_read 0

Yes, this is intentional. SOCKET_FILTER programs cannot access skb->data
and skb->data_end among other fields. See:
https://github.com/torvalds/linux/blob/master/net/core/filter.c#L7864-L7879

> 
> 
> Regards
