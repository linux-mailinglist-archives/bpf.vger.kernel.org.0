Return-Path: <bpf+bounces-5695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7CA75E9D5
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 04:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327882811F0
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362D1A5F;
	Mon, 24 Jul 2023 02:37:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E25A21
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 02:37:16 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622A2A9
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 19:37:15 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NNka3M005245;
	Sun, 23 Jul 2023 19:37:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=AaGwywjI5lda46kW31e/2X0CWDrW/FSv29dfxJRz3WY=;
 b=SPfN27Qgn+jhgrUYOL0KtzOScA7bm2i6aRxaOLdp80oteH/C68V5Tp2piwHvLHzcJR+U
 ucwdj8CAje98BLoq9VotDQx/SIO+R9hPaCdc4uEw8XI21sON0DIsDY60UnWjibhWqn5N
 8QuXDbZGoG0liecuLgA3LjMnWmylY4jzgHfZI6uggaO6oAPtY7ma6hz4jvCFPbWx7PBD
 WXTvdojNr/9LlACCc4n7Pq7Dplo4dLP03DXjKIx1RqKhv5d/PItH8NzcfexXwRWQ07aK
 Up8MyalN8fxI2gwUVeXI7JlYuMYpZ8oCX4fVvK9x0tdDIAVEFHiYe3T/msaOoTGz5/ai EA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s0ee5s4nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jul 2023 19:37:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLVwNkZG/voOYob4RifX4TyrOn8xo4biOFBFdC1U1LgZKXluhGjw3yaSJL/FE8w+KO7RBo+KYR3PfGNngzS+vk5DulpSIZXM1lp7lKtZaCPku+Wxm1FsFwe1NbFBapBnnnfgW1aKtuKOl8dDOkTDMrvU0A+3IpynQTiSVKd5sqEHGPpCADEKLJ00L0AjM8tzCSSM2UExM+E7AYRDF9cg+EDc3AbQw+lkOM1UhCm/+jIHeQmXHBhjCkgAfj1/774F5wVHs2MFElmr+WpdVoSsD0s0aByq2TclCKSMCsQ7wisFdemicEsSCIr7R5YtpQM/dZNNXkxmsNIYaABD0h1AOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faTxudQ1M1/iWLbmrhh8B3SbwEvX9oF9HBfd7uweTqI=;
 b=Iam54RfLQvdRFboiFyHGhTRYAfY2BLKVyA9FIFhXSPjSiBYEyk/o683B1x42EEMB/Gfm49JxwTyDbTaoa6x/2UNKyZKVBntil0USuvypvtoZS3MJzmhvaD7pH9DKxAARy6UtkXStD/HhO+eHkch9mrozSJ3XPabRrnpCewjjJgpwO0B0shlH58k4JGcg9YjHiLZYII+PKq/ELDgaeD8LaAL7l45NTkZNhYLNCNahmmZjU9pwuxnin5Bmn5Y4FZ+zMj/UEHmIY4U6kMIQE+rxx4qUIK+8N8Fhskr5EeJLyueSoftpCUxluJchq3VG76W98u/Vn/fBRXvYYbVv/S+4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 02:37:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 02:37:10 +0000
Message-ID: <7db1ea63-b093-0d21-4fb2-e6e8b3652ca3@meta.com>
Date: Sun, 23 Jul 2023 19:37:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Encoding of V4 32-bit JA
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org
References: <87a5vp6xvl.fsf@oracle.com>
 <32dc8c48803ff047266ee396fed3ccc9f7f0147e.camel@gmail.com>
 <878rb6qw2h.fsf@oracle.com>
 <ee97e19d73fa460bc37004baf01bd5f9fe6f67b4.camel@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <ee97e19d73fa460bc37004baf01bd5f9fe6f67b4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR08CA0057.namprd08.prod.outlook.com
 (2603:10b6:a03:117::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3889:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b643a44-8ac9-4c05-490b-08db8beee19e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BKmvl8gg2ValccZ4/fzgshl/n8mbLVxnDg2/9FcCgaqWEv1ULzSSXgaq+dJPewHY/72CJg8xnF4CqGH3/tZI4aN/bG2civqts2ccEQH+VWDPF3I0NgR1xL51qyvNdJlrtW3P/0j86xg6qgneD63/TXB5Jo+FrSgG6PqEirTX4hMzhzTH4/lRac97FT+p/F3+EPtz3RrULJHGRjN4RmmT2ymjDW7aH4jo/nR4Jm1o1gaMITzyA6Vcs3/593/Ntfait2vknRJ4ml+oyf3Kdl7aG08TavzgWaKh9oAA9Vx6nv87E6981/mhUAp7py/upW8fnFdvA6E/uG1eKZufBstx5y6gtVUR6ii/eFBVmNeFMDxIuv03J06cxwfDlPC4uQGfCFWilBcm37gv8MfY946ARPHgMpttLue4joVWtuoENALGP4yNLaR+y0+/wAkJqLzdeX7bTBC9b3Y4uWia7KwmtVJEU9heVv4BHtYiJT0fngD9O7Lh26TotS0Z/Lx3kq1677D0092PfOz8sqTx7eH4I+nYMLIkPklTLymSqDGUuJyNKy6mcxnqBPKapoxWQshHtpps974jccS+Iu2itMs/Kc96GHU7QSGjKoudA1dxHTMLcIZrsT6UA5TssYY7Uw2eE9XYP8fcTi3s9Lvk861F5g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(31686004)(8936002)(5660300002)(8676002)(41300700001)(316002)(2906002)(66556008)(66476007)(66946007)(6506007)(53546011)(38100700002)(31696002)(86362001)(6512007)(966005)(110136005)(6486002)(4326008)(478600001)(2616005)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjIwaDBmcnpTbkl3dU1CWGJRMG1IWi9uc2xCaGUxZi90RmNaNkRuS00zTWly?=
 =?utf-8?B?VjFBdEJBVmtzK0pSSWNmVjA4MEpTa1E2WWdDTEdQQmJkcFdXNEZudWtRaG1H?=
 =?utf-8?B?Q0EyQ1Z2SlFvbVVvUWV1REdlU3RFWVluQjhNbktiaDFVWVF3MEprQnNib2hw?=
 =?utf-8?B?NXJQcUNPNFlyenFSeHpMSlhKeG8xNnY5Q2UreVFKNUh3TVhTcks4RGNOQkdm?=
 =?utf-8?B?WnR5NDF4OC9ySVZib2FQY3MrSlhxTFVLOXNWdFRIR3dHNlhYUnpvTDhHTVc1?=
 =?utf-8?B?ZEdya2Y5TVhBUEVHVjBEZ3NldmFZbVRBT21zRURYanNlR016bHhXUXRxdStM?=
 =?utf-8?B?SUoyNHhSSllqUEhEemkyUUJROW1GZnJYV2VQSnJEQUFsQkdNSDVjZHdtNjhr?=
 =?utf-8?B?STk1eWYrUVlMT3p5aDJmYStYUVhaOFBlUCttYXZhSVFTZjdvZkpGaHpQTlJW?=
 =?utf-8?B?NXcvVjBYcTZ6dVJrTG1DMGVCRWdSZmd0RlNJVDhnYnE5QzRYV1EzY2xQM0J1?=
 =?utf-8?B?UkFNV2hIMmkrZDJidldIblV3SXdBRXZyYkZBQW5oaDZTbTh1eStYcnhpRTJY?=
 =?utf-8?B?Sy82U2xxWmRQamlTSlcycVpJZkU1b0cxNkxmc1ArSzQ1YlRsWEh5alNMREpE?=
 =?utf-8?B?UERadUorMGxvQ3ZtNDVETEZ3dDRYWUFZTzh0TEplSGJWSFJ5YStNYUNTSzZq?=
 =?utf-8?B?SFE3TTdRaGtCL0lDR0NBeUVPYlZKVW44S3V1VXI3a0lNTHdpRzh2OTRFdVNG?=
 =?utf-8?B?a2loR2ZSNHhvci9VUVN1YmRLTGdxWWdINXh1ZmJHNTNXRExCNmlWUnJJYlBx?=
 =?utf-8?B?VXBudWlxWjZDZ09hSXJRNWlSRFIzVnFKbEV1TUxxSVNEdm9pdWdUK0pyQ3Qr?=
 =?utf-8?B?MFhFalV4L1NzRDZsU045elBSS1dQSlc1Q0VKTVhDQnpFT041SUZhbFlmQ3A0?=
 =?utf-8?B?NVl4VUJsTW9FTkNaSC8yWEFNM2dMd083TzRjMXBEOGE2b1ptcFlTUVBPY25a?=
 =?utf-8?B?bkJxRjNsMll5VHJ3eDVKcStUNWZISlBxa0txQktjRkxGaVlyZ3hvYlpKWUcx?=
 =?utf-8?B?R0FaMlNJOWxwZVRtdEErTTQzOUxZZTJEUTNyRGJxOTBrRjZaQjM4QTZXTzFK?=
 =?utf-8?B?bTBZd1BPYUp3OXNYQ0E4bEdxSENPUFRrNVRjV3VuZVZDNDdEdzdoenVMNytD?=
 =?utf-8?B?bDcwaG9GYnVTM3NQU2ZnN001bFNVQXVvS1pYNnNsTGh4M1ZZN2VGSnFSZUg3?=
 =?utf-8?B?YjRFZ0dxNWw3cEw3bC9mdURiRFJSc0gyZ21ZbFc2M1g4aHIrZ1pZUnMwSGc5?=
 =?utf-8?B?NDJrdzl3cUd2RWVuWVF1UjBNWEdWZVJxK3FQQjNVNjVBV1BFMStGMVVNZ0pE?=
 =?utf-8?B?SkxPajQ3TVVtWi9FLzMvQ3NkQmg4a2g3aDhkU0VpMThKamROSGViSXcvZ0do?=
 =?utf-8?B?OS94cUw2czd3VityU0JFaW9LR3JsblNlbE5nUHo4N3c2WlhmRUJoSmliRGpU?=
 =?utf-8?B?TWdFOVd3SDZ3TUVPbm44ZWRiZEtRUHViWnpjZnBGcHZ5TXNoS083aFo1ZXpJ?=
 =?utf-8?B?OFR5b3JHZThZZVFqY2p2bGFIUitjamI5KzlLejU2NmovMXpaT0lPVTRvQjlk?=
 =?utf-8?B?Z2MvSWR1UGgzbE1oRDR4dS9XeEhDY1hOWHFENWNFRFA3NllyQmhVajR4ZkE4?=
 =?utf-8?B?R0ppUUxxM1cvbWI2NDArcXI2SFhrWmtrdk16enVWQ2xrVzJ4WjlXTHZtRllL?=
 =?utf-8?B?RlhNZGI0OVBPWnI0WENSTzRVdTQrWExQZjFiS3p6cXd2clN1V0piT1F0bDRK?=
 =?utf-8?B?NTBkcG83WFhxbW9WaGIxT3ArcWUvV25uTzRNR3o3bWJZT1FIRnIzNGRFY1BE?=
 =?utf-8?B?MkIvUG5oVXR5anIxdi9uK1p6cVJLcm1QWS9TZWw1ZHVCeGlpMGwxNFNKS0xT?=
 =?utf-8?B?UFZLd3hOWFlvRk5HR1ZhUnd6ZCtXMDZ4Yjc2eENMVVJHUFMwdXhaS25Ed0VS?=
 =?utf-8?B?RUxtTklUMU85R2NSdFJ2dzBNMFhhYy9tdHJLQXlWSG83UmFKdXd4TUNXNk0x?=
 =?utf-8?B?emhSaCtieVlxNHVnVlkyeU9rbXJOM0tvaVo0WUNkL2RWby82aEZGNVA3RlhK?=
 =?utf-8?B?WUtHaWJZVWs4bGUwblRUZ05CL0szZzhZenpJcWVRRnY1SFlPdGM4TnVJdHQx?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b643a44-8ac9-4c05-490b-08db8beee19e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 02:37:10.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyFXlhyX9KA1VOuYZbCeo8YV/DULDOlr8foG6q37rTKkURlUGzR5ChdtBGe0fi22
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3889
X-Proofpoint-ORIG-GUID: DYxlgdB01-FXBJ95NdVuxM1JmsoAzStJ
X-Proofpoint-GUID: DYxlgdB01-FXBJ95NdVuxM1JmsoAzStJ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_02,2023-07-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/23/23 12:21 PM, Eduard Zingerman wrote:
> On Sun, 2023-07-23 at 21:14 +0200, Jose E. Marchesi wrote:
>>> On Fri, 2023-07-21 at 18:19 +0200, Jose E. Marchesi wrote:
>>>> Hi Yonghong.
>>>>
>>>> This is from the v4 instructions proposal:
>>>>
>>>>      ========  =====  =========================  ============
>>>>      code      value  description                notes
>>>>      ========  =====  =========================  ============
>>>>      BPF_JA    0x00   PC += imm                  BPF_JMP32 only
>>>>
>>>> Is this instruction using source 1 instead of 0?  Otherwise, it would
>>>> have exactly the same encoding than the V3< JA instruction.  Is that
>>>> what is intended?
>>>>
>>>> TIA.
>>>>
>>>
>>> Hi Jose,
>>>
>>> I think that assumption is that `BPF_JMP32 | BPF_JA` is currently free:
>>> - documentation [1] implies that only `BPF_JMP` should be used for `BPF_JA`
>>>    (see "notes" column for the first line)
>>> - BPF verifier rejects `BPF_JMP32 | BPF_JA`
>>> - clang always generates `BPF_JMP | BPF_JA`
>>
>> Makes sense, thanks for the info.
>>
>> Do you know the precise pseudo-c assembly syntax to use for this
>> instruction?
> 
> In [1] Yonghong uses the following form:
> 
>    gotol +0xcd9b
> 
> But it seems to be not specified in the documentation for the patch-set v3.

Thanks Eduard, I will add gotol to the documentation.

> 
> [1] https://reviews.llvm.org/D144829
> 
>>
>>> Thanks,
>>> Eduard
>>>
>>> [1] https://www.kernel.org/doc/html/latest/bpf/instruction-set.html#jump-instructions
> 

