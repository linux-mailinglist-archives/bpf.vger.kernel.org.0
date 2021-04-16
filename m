Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739D7362728
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 19:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbhDPRsR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 13:48:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31324 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235563AbhDPRsQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 13:48:16 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GHk003001864;
        Fri, 16 Apr 2021 10:47:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AYzrZshJJTx2vamTr4NkNXDFEJTrE7xRD7LR4sFSXls=;
 b=OzSTOcmT1qhCK1ichkju0ea2USTjQmqPWrWtjnK9pwDC9NB3FeIRZjXiV40amrStZpaK
 Thz4w6HtYQvPtdJDVEDROi72yGWUjbQbsvijxywGWoWu0jJ0Qghp4Jm+a6vXPYi1QYCm
 snhUooxsNHChyFietsWs5jvWm0hz3KXLRdE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37wv9qqfjs-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 10:47:38 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 10:47:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nz/JuzW3V/3gur99i9EP2l1lajRjS7vB8zWOeC+LtJM+H9+VHeHFtqoTE6HRKzRyT5a3d1I7euf72PBBgy/lo6SHuOeH5085klTh37HirX4UrXZewV33JNuIJP37XF+uodZzC2xD9FtvCxFmFrEne0NhMEjZJqzzHfN4Kd6pCyxmp1mXy5KpuyEyeyVl14hhCm2rBghkdqLSzWjDZf+eMWcSA+KxJBVRFIVeQR6P6A4dPgQWrCLC5UfqZOggaxHd6Tjv0raFOuNt20jOFBpWrAkMxmcVHxFjjRluht5vU/F7/MgkCIiSdp2KPNrjt9lOdOwV/FPQ3Gvmg5/eS6gE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYzrZshJJTx2vamTr4NkNXDFEJTrE7xRD7LR4sFSXls=;
 b=Q7pNM5KAdpfAdp44HsQrAihOW0xyMEmVniW7+9pPNJ8ReuhsP65SDqo3/o67xD808buuFO8MYiT0EtuVw6EXWIGCkhQdQTLNKWNi/AIf3qyueyad0pBBwQAZrVH8hAkMpiJwyWxExHGZmMGEmKJmvy9tbIwpDs7tK7yd9KAkU3Zcz49X/G1b7Og3qtENzeI72692nSvBuRv/s6PBpkO2n1TzBoE+tz5Tukw5G61Saw2nm/Ett4ApU1p0hrmQ2ozbLR1L/fS9xy1y3AXNivH918CorQr1zMbDEkQRVrf/NObJRst6oB9cU7Ys6y2ctjfyvgNRRyUpHRbA6osftRBdVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2031.namprd15.prod.outlook.com (2603:10b6:805:8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 17:47:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.038; Fri, 16 Apr 2021
 17:47:31 +0000
Subject: Re: [PATCH bpf] samples/bpf: Fix broken tracex1 due to kprobe
 argument change
To:     Yaqi Chen <chendotjs@gmail.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andrii@kernel.org>,
        <songliubraving@fb.com>
CC:     <bpf@vger.kernel.org>
References: <20210416154803.37157-1-chendotjs@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1c747f1f-5140-ed94-51d6-7320659f9fad@fb.com>
Date:   Fri, 16 Apr 2021 10:47:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <20210416154803.37157-1-chendotjs@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:7e08]
X-ClientProxiedBy: MWHPR12CA0035.namprd12.prod.outlook.com
 (2603:10b6:301:2::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::112e] (2620:10d:c090:400::5:7e08) by MWHPR12CA0035.namprd12.prod.outlook.com (2603:10b6:301:2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 17:47:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f5aa985-b4bd-409d-89c3-08d900ffb555
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2031CF2CE6AB345D2638B847D34C9@SN6PR1501MB2031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRerroGOESshuarVmeWWVs51A9AWTHxlYEVX/FzeP17ZlB01DzuAvRfXJd2iigVQC++LYzTwnuGpDoomYwmPSvABBpAtRuBwEtVOOTqLjhnQ2tAbU5n5ARxj/JwGyUhYIr5PoijG3nZaiSO4pTI4cgFPsK4Z79UjEzggg1Z4EZcqiZMmwict00veijOd5XmS+TexyriUaVqE+/KaZ72ofaHpcx7w1o9H0rHkTLBfTpRAAo4EmYC0EdiENPf8EiNAWSvcRueIkmJx61d8NAZWUzj0l+yL2P0ar96pBx6bdPoxVMo/NYV/mMxklRih0q1U07JtVuVlH+oqSn94NTSUO4Oa1eAVAbgn2gV65MgZBaTJyLD5kjSqqb/qrntHZ5XKwrdQpjyJKma236Vzl9A30nEUFyEWTtYlUkzk5qf/+omnVsk5OpXx9IDuVAz2Dvf31NRky6/Y6YeFb/uo4a+O2Mh3q5t/YQyP60m8x9z5pl01b2+LyG0bV4TSJsJRJLOWKSZM/nLqDcjM5eM4Rm9M1zMxW7KF16VvTYp5FQKFntcFmNasxahUetq+o5TRDGuBTMbf7TkDWKxIOBexwuzv+RlaTtm7+N9v2TXyCxQiR/Lo4/jlEIOL64a9b8I6stnvKXCGXdL1JlP8nJxf+MfEP/xZLQgfRf01C01hk3eherr55xERvMsyplQQ2ylnGBur
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(366004)(376002)(396003)(2906002)(316002)(4326008)(31686004)(66476007)(36756003)(2616005)(31696002)(86362001)(66946007)(4744005)(52116002)(53546011)(6486002)(478600001)(6636002)(38100700002)(16526019)(8936002)(66556008)(8676002)(186003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z1o5UVV2NmNOYjZXSlZYRWZ1eENGOXRxd1UveHFiUlpjV1htekJHMjJqZGxx?=
 =?utf-8?B?K1NuVmU3ckprc2lZZG1YSW0ycXJZTC83UnljWHJhWkN5b0dlcHhEamJVeWM4?=
 =?utf-8?B?ckwwaTMwN0dYTHBtYlZKNFNmdFQ3WmVnb3ZjZ0tha0xLVWhYZTRlZDg0d3VX?=
 =?utf-8?B?L1doYWlwSmRWOHJKeSt2S2h3VGtaZ2liRkFWc01uRWx3YUoxWUd3Mm9TZFUx?=
 =?utf-8?B?ZStZTENENmMxMkNwejgyUzRoWDM1ZTFMbGhwL1pVZ1RwUTJyK0lNT1FTVmxO?=
 =?utf-8?B?ajJEOFM1VDVaODNNR0xldTcvdlBNSmwxMkF4S2NPUjBaRFhyNWVVMXBEUkVX?=
 =?utf-8?B?c0hwc2RQMlRvQlkwSXJBdmk0RWo5ZzJIZC9TY3RWNU13eWJDRmNQUkF4amJU?=
 =?utf-8?B?TnhUcDBVZUN6WWVqT0hoUkRZVWcvSDFLQkU3aWc2VHBCam9SM1puNEl0SEs1?=
 =?utf-8?B?ajJGTzZSakx6R05RTmpjcHBpSGtYTGlETjdSb2thSFlxQ05PazA0TkMxTksv?=
 =?utf-8?B?eXN4NlllNk9MTWppWGFqSTIzdUg5NUJCRlRQSXB0NFowd2dENE5DNWlRcVlT?=
 =?utf-8?B?T0ZYQ05wbGRtVEZGc2ZsaXVwOStQZVBCL2pYTGdCYlNVN3I0UGoxbUR2NVMx?=
 =?utf-8?B?Z2xqUU1xRzFsSFRXcSt2SHVUenR3Sy9HTHdnOWRBQm4zT2RodGtpb29EQkxu?=
 =?utf-8?B?dHBOeWc1V2Q4S0xoSEhXSFB4Qlh3TUcyNmgySzAxOFRYKzI1d3IwSWFXc0lK?=
 =?utf-8?B?V0U1QUFzc0R6blpvMmE4S04rOE9LL1QwV3ZUMHdlNlJNeWZHWkl1VlZneUUx?=
 =?utf-8?B?MFdrWkt4Wk82Wm43VmoxaTdnSzl2dUlmSVp4RUJ4cHV4VmdNemZ3YWdLbVgw?=
 =?utf-8?B?RzNNTFBjRFQvcXp0TkZXZkpWa3dzWUwxRGxsbmtkMlJkQ1VWTDRCM0s4bjM3?=
 =?utf-8?B?OW12SGw5MW1FVk5kTEV6bWdWYXpGVlFxeVNPVWFYYTZUN3gzY3A1UmdEV0dH?=
 =?utf-8?B?WG50anV1VWFVWGxoUUxaTGdTZTNveU5kd1Q1OXJ2OGNjUVg4dWxIVnY3M2Jn?=
 =?utf-8?B?ZnFmdU93d01WVE5WTkREamtVNHdhM2VkNTVBNEJwekdZdGRlNU1YcnZ4Z2Jr?=
 =?utf-8?B?cExIWFVVUTVZeW1xVmhld1NLS01PK3hjRk5RSS9kU1BtQ05WTjlRem9MQkdv?=
 =?utf-8?B?SmtVY0ppbTlBWHZ6THdxaDhZYmR1K09yVFFsajliYWRNSlhZa1VIeFFwVzBZ?=
 =?utf-8?B?cmpLY2oxeVByYTdUSThnL1lRdndkcERjdVd1WDRwd2tuRFFqK3MrOXc5SlJS?=
 =?utf-8?B?RHFHS3BNa3BrYXljbTZRLzhUYUJuOUp0TzVoRW5jVkpocFpJK1hQdENwQ0xl?=
 =?utf-8?B?QVRXalFqTFhXb3IxbU5ISG16UCtJVk5rc0xGTWZyNFQ4bVVST0pVN3lHVUZT?=
 =?utf-8?B?Y3VlWlZuK1JxMm40UlpCbldPaXdHODV4WWVHdHZ6dzkxaWQ5NTR4RWJtVCt4?=
 =?utf-8?B?dWJxQmg3cXU3MEhSTDdmemtZL2ovb3JPWkJMWWg4RmVTQklqL2lJaytOVHkz?=
 =?utf-8?B?Q0FFdWxvWHJ0VEl2T0dRaHJUWEhtSmFGR255SUhsVk4yQUpJcDNuMUd6d1Nj?=
 =?utf-8?B?S0VJZXR6UW16MkoyL0RIK0tIWHhvdTkxUitrUmd3T3BjYzY4Wm1VTkF5L3Z5?=
 =?utf-8?B?Mmw2OUpnV3RUVHlPZ1RYb2U4TG1iSW1TUzRWSFZQSG1qaUN4TDVOeG92OU43?=
 =?utf-8?B?bUkyTWVqdnhROUxWVkxHVVl0UHAvUXNCVWJhMTd1THowMlIxVTA0VEw5NWMv?=
 =?utf-8?Q?wrCo6rr4s1gDLQZrqLYhn2hN8BZkrjUIB9k50=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5aa985-b4bd-409d-89c3-08d900ffb555
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 17:47:30.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXFLKICl2+8dYAOuEJs1ora6KBg/kSFSG3D8VOFPOM6nEhRHTGRWFfB2Xzw1CAfl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2031
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: IPVCYFTv4AywtmpL4zG2EOTV-wXNqA-S
X-Proofpoint-ORIG-GUID: IPVCYFTv4AywtmpL4zG2EOTV-wXNqA-S
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 clxscore=1011 adultscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104160126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/16/21 8:48 AM, Yaqi Chen wrote:
>  From commit c0bbbdc32feb ("__netif_receive_skb_core: pass skb by
> reference"), the first argument passed into __netif_receive_skb_core
> has changed to reference of a skb pointer.
> 
> This commit fixes by using bpf_probe_read_kernel.
> 
> Signed-off-by: Yaqi Chen <chendotjs@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
