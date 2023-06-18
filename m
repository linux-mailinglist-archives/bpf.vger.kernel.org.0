Return-Path: <bpf+bounces-2820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBF673493B
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 01:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBEC280FC9
	for <lists+bpf@lfdr.de>; Sun, 18 Jun 2023 23:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1096DBE4D;
	Sun, 18 Jun 2023 23:11:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF6AD54
	for <bpf@vger.kernel.org>; Sun, 18 Jun 2023 23:11:48 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92430E42;
	Sun, 18 Jun 2023 16:11:46 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35IKcEU6011213;
	Sun, 18 Jun 2023 16:11:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=2x7P7bDJZ2ybWkNbRTqpdJUZy6NgeCOlCsn1buI/qkk=;
 b=jEpQpY5rCRM82A2yp0Bq8c1PhgONHCcitYCcug6NFyt8FAo67NXTc5B8DgpzPOtcGnT1
 m18rYmbCz65quJ9c7Qz1wX0YsmLSfXUok8uv+gL/rtUst+3h2gh+qeRS/362rQh/sqwb
 CXhwkDFosgV1QRQ4YcpnyEqdtx96jcnV6fx2V3Bkq4CV1Y6155ZyqOiJJM/7a365Xu/D
 jbeHN+jqz/EExLT1mzqvpTGcXSlxTmDkH2FnKliT5HY/T9XCfo8B/3oNSZmQt/2414iO
 58a0n9v9Q73748P3YfYEenG7nLQX2uNkPtH2TB2qDbfiPBv4H3Xx8XKOK9QnolfB1TXj Ug== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r9ac3053d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jun 2023 16:11:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5LoZI68eBvLac/BJiTmPi+Ghx+y5pGSzsWKEivOzFRsEmfRHJS6wTiIv0mHxIdhlNxtllVnWSafxpdeyFW8LyAgZRen4RAnC6b26yCGM9qjDvcXx/q3Ac7JdEKmKUd3eSBwvzIQDW1AtFBVp+j2U+r7tx5G+7fS0sbCn5DGm9cuJHirRChHtmkJSXqwf/Bg0INnE0Mb7It9CbORHdZAWwccMz2MI5+L0FbLY+oR1dOGyYB0kAETGwNZOwK2qoXfk3RAkNJ5nj1ZCNEq//Fr2upIYHt9lwEWY8Bm31t9HUsvUOJw2evrE1kzhFeYUZqXvcIDoe3BzF6DkyRX2ha4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x7P7bDJZ2ybWkNbRTqpdJUZy6NgeCOlCsn1buI/qkk=;
 b=QNTrW5dadgOhWdy7aIoLsI7DR7FExjkrRDuvshJoZzh0X15GZaPnu8L480tM/u2BhnuPxFLj7JZlQ0s9gsjYOIG+ZklFsy7zgglOlNcGpzA3HRRYyrnJ1el74FMqbtfIuEasJZGN/kNCkCLDWJRk3/OGl769FgnWec8ZNwhK2Pvha4LQ5OmzPB+ZuFEsPyucthAdpqQs0Zm5WA/9Qihhcimi7gLXmhWINrkzZHD/q5RKlR5OPxYLR5zGqywNFn7m3xETb9Fh/YyAonpf3NpJYBY9pMjjuxupWR69QVnTmDTRLsSkh4ZKY/4pEXMk6Ia8xP+Mz++mQJ9w35uCYpHt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB5394.namprd15.prod.outlook.com (2603:10b6:208:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Sun, 18 Jun
 2023 23:11:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 23:11:01 +0000
Message-ID: <ca490974-0c5c-cfe9-0c6f-3ead163e7a7b@meta.com>
Date: Sun, 18 Jun 2023 16:10:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v5 2/3] bpf, x86: allow function arguments up to
 12 for TRACING
Content-Language: en-US
To: menglong8.dong@gmail.com, alexei.starovoitov@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
References: <20230613025226.3167956-1-imagedong@tencent.com>
 <20230613025226.3167956-3-imagedong@tencent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230613025226.3167956-3-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: a242321a-c4f3-4eb8-1881-08db70514842
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	g0+oE6+2rLpyurKCOT/q6dstqXjf8xMT0keo7+y/R8VA8PhobbEX2gD301yH2QMrpj6S1v2ontUO0gIcWa/TEDJkbZkQ9DdhOSGFRW68V4+HUx3NfMe+Jb0j53ej0+/emba/rBkyIJTx/2kGEsrbeMiQ/A0D3xXvgvRxDn+DSNuxmFdmPEiSCbk5WqCZpsiP8/SC2PId2u552it6I6kWjfwUE5Nb9E9MXIyCGo4aEa5hq2dqzVQLxUvHrTHPnfJ9ykQydB8GWZUPD2JCTYCckIJ01H+5kLv3o9oppLohNF7pPsqbZaRAfRljTDcR3dUBFcSD8iikWf5jAxf5SUFMBtsLdmrzXBgowZ3/mqGNF6YwqR6IW1FhTzmSJhtj8KbApai0z1fQLriZQB8UiXj3i4OB6wygNLNhFIaD6Ea4T+MzvvqHtByrnt90VZLm5kgEK8XPSCFRFdFFRWP50pXLzKYAZpgOM1nuUbixyKYXCNQbDuJ2JVyqK5qIqJ74NY4nexi0O0ZPPmXLL83E5guHvpMQ/fuwiDSZt8Uf5/dpm67Xn2YYsWvGXLAUO/byUXPBk/Ws2KuiypFq+EmWleqqwIozNZzKmZbuUVF/Q9FSdyqjzuPIk3hf8gfFhjCNFOgBLsNdE/ZLtilgugPPSpAGz0RDLpJRFquC/plumHLVuy4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(38100700002)(36756003)(31696002)(86362001)(6666004)(6486002)(186003)(53546011)(6512007)(6506007)(8936002)(8676002)(5660300002)(7416002)(478600001)(31686004)(316002)(41300700001)(4326008)(66946007)(66476007)(2906002)(66556008)(2616005)(83380400001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nk5neEFqeVBhcnFvdWp1RUhKZHViWkxMdXZ6dXlvRDZGNk14SDVNUy9vbUg4?=
 =?utf-8?B?TnB2QWxmY2QvZDVaNThZUjNxS3U0RlFDRW1YVkZIRU5EVVJDMmFPY2YzTzZ5?=
 =?utf-8?B?Y2F5YXFUczYveW9NbFhmZHB3R3VVYXA1WTRUdFN4YnhRbDk0d24rS0daRDh0?=
 =?utf-8?B?S0JoMXVDS2hnY2hra1dVR3dHY1p5VDBQSExIemtnTHVvcmFHM1hTOHhXQW9y?=
 =?utf-8?B?RlVvcm9NYnE4eElvSEI5bEpMeFZObWtXdmpLYnZlKzdPM0ZFNVlXWDVXUXFZ?=
 =?utf-8?B?MzRZbWMxbjIvLzZnRS9qOVNZcVErQ1NXOGFlMVNKY0Z3QUtxc2t1NmE1ZGx6?=
 =?utf-8?B?c2Jyakk0WHFVOUt0MzJkWDNDSkVsZ3hYd3pZWldHbWgzUi9HMjNISzkwZTg4?=
 =?utf-8?B?Wkg1bmZhSnE4aHZZWTJqa0FFSFRjODhnVGw1T21GOFhjTTJab0lXNHhrU1VI?=
 =?utf-8?B?Y0JWVkFqaSs1cmIrTzFpaDJqQnp4b2hyZjFRMWQwaEV3NC9hY2ppVzFCVkdM?=
 =?utf-8?B?TjNoNTlOdFhNY21qUmpUenhWRnBqREhKSDZXLytXRHhueHhsUzlJRmR5VW1v?=
 =?utf-8?B?TDBqNW9IQWttazNqaVM0WCtqWkh0dFRUR3ErRmZUNUVWWXpvZVBSVHJKUkdv?=
 =?utf-8?B?ZW9ESFJ5UkRRYk9MVUtoN3plZlc3Ly9jaFdEMnpVMDFXdWkweW9wSHlrWWhZ?=
 =?utf-8?B?d3czQzllY0pyVEhoamkwaVF5UGVvVmRLczdUVkpsQk5TR2hCRG5tNlBTNEd4?=
 =?utf-8?B?eWVWNUlEL3Z2aTZoMnVYcEZrRjl1QUx2Q2RpNVV6dElibC9wckkzSkx6YUFv?=
 =?utf-8?B?M3RQWVA0REMxa3hkeEZTVG53QmxiWlBmQkRCUTdoaTZZajlFaVJ6aGUySmVr?=
 =?utf-8?B?c2s0VWgxd0VwTnNWZzJMWG1vOU9lU0FSY3U3bzMwT29SenZTZVNpMWhjQXZW?=
 =?utf-8?B?L0I1LzhNaXhNZFBLdHZTTkdKU0hWTU84Tkg5aEN0YmtaZXh0UzQweEoyR0Nj?=
 =?utf-8?B?N09Db0tnOWcwYWlSL1ZqcXNjRGlRKzVyWVdVcnZ1dlN2c3hKMGNRTGhxNk8r?=
 =?utf-8?B?WHlFWFhDN2IxZkdUb0NTRFA4ZXRtTCszTnc3UHhhMHBQT1lmWFBBa3cwRml3?=
 =?utf-8?B?REUrUENYeDFTT0ZLc2NDSE5Dd0gzMDhKdDJmQ2piSEpTeUhDMzBUZFZ6QWlr?=
 =?utf-8?B?d0FjUUN6ZjZlT0JmVDA5cmpyYVBET1NGUU9YNitZZXF0N043Z2oyVzRob2Iv?=
 =?utf-8?B?T2JkR1FyUFdjRmpDS3M5Vi9tYVhwZTYvUElSN3Z1ZW5NOWk1V2NKYUl0cmFF?=
 =?utf-8?B?a0pHZ2k3OW9RRG5oayt1T282bDF1bmQvM09oYkVwOGIxejlLT3BWWnFZMlRH?=
 =?utf-8?B?VERGN3AveUNOTmdhVlVoa3NqQXhPejVFdUpLUzlzTi9rUk1Jbm55K1ZxeE5X?=
 =?utf-8?B?YjFHaWViYXdreVpYMDBwc3VnTGFvRjd2S3l2cGZ4eDNYMVRMa2dFN0FIb1dC?=
 =?utf-8?B?ZHZGY2dPSjFzNXhYckxQYlhaakxjN0RVWjNoSG5OdGI5L0YxSk1XVHppcHRB?=
 =?utf-8?B?UVoyRUk1NFJ6aWg4ditsT0xBS3RCeGNNbEk0M08rZ0cyekxzd2RiM2I3L3RG?=
 =?utf-8?B?b3FpeHdYVDN0d2Y3L08wdWtUK1RWMjJJQVV1TVlKSm1say9scldQY2QrbDZu?=
 =?utf-8?B?SW5QVHZJZytLY1NZTjZuOENjT0xjRThaRUdhc2xxNkxHMWY5Sm9mOWl4Ykhr?=
 =?utf-8?B?Z3FVWXNwMW1uQyt3T0pqOXIxcS94Tko3N2NjY2JGaVVDcURtYzU1d0ZqM2NQ?=
 =?utf-8?B?L2llSHNjNnQyZTkrK1k3RFlxdnVzSjZxdURzMjdPbWEyS1cwamFPalg3M3hO?=
 =?utf-8?B?VUtNSCtPTE9DQm5pdmFlVW1CSzlXU3hONjgrenpwQmNJb0lvV0NKMHl5UEpJ?=
 =?utf-8?B?ZWIzK2p2YWdLYXJHVEgyQVZoc0ZHS2pRZEt6WndLdTlDT2pjNnlLVTZPVENP?=
 =?utf-8?B?dnQ1enNvTVBKVjU5cGRHaWN5VDUrN1ZNK3Q0eHVKeTI4YzM4Qm04UmQyQ1c0?=
 =?utf-8?B?TmJxWWRodmZQa2ZpL1VKK0F1ZDBOZy9oQTRvb1YrUCttMDd2K3JDbUxTR2dt?=
 =?utf-8?B?dFBpZEtKZWFvQzJ2RHZZanQrRnkwUnRKRVVjRkFMZFVxS2NQUFlUcVZ0YTFv?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a242321a-c4f3-4eb8-1881-08db70514842
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 23:11:01.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDELczqGImgp/Sf6RVKXRDF9NVvrHu0uHhJH7k4T5b8qmLJfZiMdXPqLLXNso2tM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5394
X-Proofpoint-ORIG-GUID: e-PoyuIKaT9IjMRiR0c7A1Mv3oJgZLRa
X-Proofpoint-GUID: e-PoyuIKaT9IjMRiR0c7A1Mv3oJgZLRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-18_16,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/12/23 7:52 PM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
> on the kernel functions whose arguments count less than 6. This is not
> friendly at all, as too many functions have arguments count more than 6.
> 
> According to the current kernel version, below is a statistics of the
> function arguments count:
> 
> argument count | function count
> 7              | 704
> 8              | 270
> 9              | 84
> 10             | 47
> 11             | 47
> 12             | 27
> 13             | 22
> 14             | 5
> 15             | 0
> 16             | 1
> 
> Therefore, let's enhance it by increasing the function arguments count
> allowed in arch_prepare_bpf_trampoline(), for now, only x86_64.
> 
> For the case that we don't need to call origin function, which means
> without BPF_TRAMP_F_CALL_ORIG, we need only copy the function arguments
> that stored in the frame of the caller to current frame. The arguments
> of arg6-argN are stored in "$rbp + 0x18", we need copy them to
> "$rbp - regs_off + (6 * 8)".
> 
> For the case with BPF_TRAMP_F_CALL_ORIG, we need prepare the arguments
> in stack before call origin function, which means we need alloc extra
> "8 * (arg_count - 6)" memory in the top of the stack. Note, there should
> not be any data be pushed to the stack before call the origin function.
> Then, we have to store rbx with 'mov' instead of 'push'.

Please also mention special case related to 16-byte struct argument
in the comments of save_args().

> 
> We use EMIT3_off32() or EMIT4() for "lea" and "sub". The range of the
> imm in "lea" and "sub" is [-128, 127] if EMIT4() is used. Therefore,
> we use EMIT3_off32() instead if the imm out of the range.
> 
> It works well for the FENTRY/FEXIT/MODIFY_RETURN.
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v5:
> - consider the case of the struct in arguments can't be hold by regs
> v4:
> - make the stack 16-byte aligned if passing args on-stack is needed
> - add the function arguments statistics to the commit log
> v3:
> - use EMIT3_off32() for "lea" and "sub" only on necessary
> - make 12 as the maximum arguments count
> v2:
> - instead EMIT4 with EMIT3_off32 for "lea" to prevent overflow
> - make MAX_BPF_FUNC_ARGS as the maximum argument count
> ---
>   arch/x86/net/bpf_jit_comp.c | 221 +++++++++++++++++++++++++++++++-----
>   1 file changed, 195 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a407fbbffecd..47c699594dd8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1857,37 +1857,165 @@ st:			if (is_imm8(insn->off))
>   	return proglen;
>   }
>   
> -static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
> -		      int stack_size)
> +static inline void clean_stack_garbage(const struct btf_func_model *m,
> +				       u8 **pprog, int nr_args_on_stack,

nr_args_on_stack is actually nr_stack_slots, right? Maybe rename to
nr_stack_slots?

> +				       int stack_size)
>   {
> -	int i;
> +	int arg_size, off;
> +	u8 *prog;
> +
> +	if (nr_args_on_stack != 1)
> +		return;
> +
> +	/* the size of the last argument */
> +	arg_size = m->arg_size[m->nr_args - 1];
> +
> +	/* Generally speaking, the compiler will pass the arguments
> +	 * on-stack with "push" instruction, which will take 8-byte
> +	 * on the stack. On this case, there won't be garbage values

On this case -> In this case. The same for below another case.

> +	 * while we copy the arguments from origin stack frame to current
> +	 * in BPF_DW.
> +	 *
> +	 * However, sometimes the compiler will only allocate 4-byte on
> +	 * the stack for the arguments. For now, this case will only
> +	 * happen if there is only one argument on-stack and its size
> +	 * not more than 4 byte. On this case, there will be garbage
> +	 * values on the upper 4-byte where we store the argument on
> +	 * current stack frame.
> +	 *
> +	 * arguments on origin stack:
> +	 *
> +	 * stack_arg_1(4-byte) xxx(4-byte)
> +	 *
> +	 * what we copy:
> +	 *
> +	 * stack_arg_1(8-byte): stack_arg_1(origin) xxx
> +	 *
> +	 * and the xxx is the garbage values which we should clean here.
> +	 */

let us put the above comments before
 > +	if (nr_args_on_stack != 1)
 > +		return;


> +	if (arg_size <= 4) {
> +		off = -(stack_size - 4);
> +		prog = *pprog;
> +		/* mov DWORD PTR [rbp + off], 0 */
> +		if (!is_imm8(off))
> +			EMIT2_off32(0xC7, 0x85, off);
> +		else
> +			EMIT3(0xC7, 0x45, off);
> +		EMIT(0, 4);
> +		*pprog = prog;
> +	}
> +}
> +
> +static void save_args(const struct btf_func_model *m, u8 **prog,
> +		      int stack_size, bool on_stack)

Rename 'on_stack' to 'for_call_origin'? This should be more
clear about the use case.

> +{
> +	int arg_regs, first_off, nr_regs = 0, nr_stack = 0;
nr_stack -> nr_stack_slots?
> +	int i, j;
>   
>   	/* Store function arguments to stack.
>   	 * For a function that accepts two pointers the sequence will be:
>   	 * mov QWORD PTR [rbp-0x10],rdi
>   	 * mov QWORD PTR [rbp-0x8],rsi
>   	 */
> -	for (i = 0; i < min(nr_regs, 6); i++)
> -		emit_stx(prog, BPF_DW, BPF_REG_FP,
> -			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
> -			 -(stack_size - i * 8));
> +	for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
> +		arg_regs = (m->arg_size[i] + 7) / 8;
> +
> +		/* According to the research of Yonghong, struct members
> +		 * should be all in register or all on the stack.
> +		 * Meanwhile, the compiler will pass the argument on regs
> +		 * if the remained regs can hold the argument.
remained -> remaining
> +		 *
> +		 * Disorder of the args can happen. For example:
> +		 *
> +		 * struct foo_struct {
> +		 *     long a;
> +		 *     int b;
> +		 * };
> +		 * int foo(char, char, char, char, char, struct foo_struct,
> +		 *         char);
> +		 *
> +		 * the arg1-5,arg7 will be passed by regs, and arg6 will
> +		 * by stack.
> +		 *
> +		 * Therefore, we should keep the same logic as here when
> +		 * we restore the regs in restore_regs.
> +		 */
> +		if (nr_regs + arg_regs > 6) {
> +			/* copy function arguments from origin stack frame
> +			 * into current stack frame.
> +			 *
> +			 * The starting address of the arguments on-stack
> +			 * is:
> +			 *   rbp + 8(push rbp) +
> +			 *   8(return addr of origin call) +
> +			 *   8(return addr of the caller)
> +			 * which means: rbp + 24
> +			 */
> +			for (j = 0; j < arg_regs; j++) {
> +				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
> +					 nr_stack * 8 + 0x18);
> +				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
> +					 -stack_size);
> +
> +				if (!nr_stack)
> +					first_off = stack_size;
> +				stack_size -= 8;
> +				nr_stack++;
> +			}
> +		} else {
> +			/* Only copy the arguments on-stack to current
> +			 * 'stack_size' and ignore the regs, used to
> +			 * prepare the arguments on-stack for orign call.
> +			 */
> +			if (on_stack) {
> +				nr_regs += arg_regs;
> +				continue;
> +			}
> +
> +			/* copy the arguments from regs into stack */
> +			for (j = 0; j < arg_regs; j++) {
> +				emit_stx(prog, BPF_DW, BPF_REG_FP,
> +					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + i,
> +					 -stack_size);
> +				stack_size -= 8;
> +				nr_regs++;
> +			}
> +		}
> +	}
> +
> +	clean_stack_garbage(m, prog, nr_stack, first_off);
>   }
>   
[...]
>   	/* Generated trampoline stack layout:
> @@ -2147,7 +2286,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   	 *
>   	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
>   	 *
> +	 * RBP - rbx_off   [ rbx value       ]  always
> +	 *
>   	 * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
> +	 *
> +	 *                     [ stack_argN ]  BPF_TRAMP_F_CALL_ORIG
> +	 *                     [ ...        ]
> +	 *                     [ stack_arg2 ]
> +	 * RBP - arg_stack_off [ stack_arg1 ]
>   	 */
>   
>   	/* room for return value of orig_call or fentry prog */
> @@ -2167,9 +2313,25 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   
>   	ip_off = stack_size;
>   
> +	stack_size += 8;
> +	rbx_off = stack_size;
> +
>   	stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
>   	run_ctx_off = stack_size;
>   
> +	if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
> +		stack_size += (nr_regs - 6) * 8;

Please double check. Is this okay for the case below?
   foo(int, int, int, int, int, 16_byte_struct)
here, nr_regs is 7, yes, to-be-increased stack size should be 2.


> +		/* make sure the stack pointer is 16-byte aligned if we
> +		 * need pass arguments on stack, which means
> +		 *  [stack_size + 8(rbp) + 8(rip) + 8(origin rip)]
> +		 * should be 16-byte aligned. Following code depend on
> +		 * that stack_size is already 8-byte aligned.
> +		 */
> +		stack_size += (stack_size % 16) ? 0 : 8;
> +	}
> +
> +	arg_stack_off = stack_size;
> +
[...]

