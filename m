Return-Path: <bpf+bounces-5050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB86754556
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 01:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81449282311
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 23:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5122AB2E;
	Fri, 14 Jul 2023 23:22:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4692C80
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 23:22:39 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7272C198A
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 16:22:37 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EHIl4A030269;
	Fri, 14 Jul 2023 16:22:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Bv8fV92D1cBATSArIJYJ0NQa8gk/L60RiDKJHCf6dps=;
 b=iYpPAHJmKXQ8bo27U5iJYNfb9ZLciSBATTUbe4Hi20eeuW8epTF3VJpU7/Ul5bcirX+s
 HVnejf79pcqdH/chzk1xocU43Z8dt8N24ZXXN8cfLsdUaez1dTAm/am3KKlOtpFhV8Lk
 u20u0NfIeuAbK4A4AgN+Izzw0/FazEKr9ekNjSN7vawdCexXQoN4IdqixeZgFcmIppty
 QqUlnqZKkrOGHvTBm10vXcjeUVGt2bGmTKMLMmThPZs/HYwWC5eXiKx8yOO61QJzgxac
 9z0PuAnDC87I6RFs+e/BVuBbpkL1/Qwso/DZ4tJGHuRIEy5WlbKNswiy5yrJBDdvk75I EQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rtpusvdeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jul 2023 16:22:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSSZbCsrEHC/YGzo5pTv8FozgXTX6ojG9TlEit407WLMhuxy3EJL/aShAUynthpgSTVX/LmI2eeFHLNOy9kKIn1LmCCCHO18mJzt6iLyjagEwwHWq45uzgSMm6TMrJDrZN1zWXi3KcK5k5wRlf3T8sn6Qwat/1vyrkQX6m/hSaOmMjWNgWQkYVA6/evmeR31k2rc4s/zm64qdoJJGayzpBXpSR2k7bPUIJ9q/rRWi3eRymxYFrZuiAxe//TXas0W4EbCSYUBkKHgfaE4lFUClEYBDeaXE+Qbe2y3haFYkmXtKSpZtNEi551ng8M++Ttquq+YVMYGunRXCH+DB5V5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv8fV92D1cBATSArIJYJ0NQa8gk/L60RiDKJHCf6dps=;
 b=K9MInGdFfcaY41f9iiacGGw7yr6jsl/kowjW1Dp4Hq0aTY6ij9QJpm9cpVjlYW5wQHjd4G0ldD5EO21OfQ/tr9/9/3NylZn1f4RJ+F+nkOrQCRkxwRB9r/R6mnNViHpt5L6zzGl7eskA31IO9Oh8WH5Vt6q2jmloMHDN94b+Zlann5ikseiGzLspux6yyFhGJlq1nmr1x7n4hhc/D8PV8KRs50C8UD3GkRLSkqz0H7sNGza9VACOn9G3OrL7arEbHe3fCLr7C/jM+mxQH0xYIhfnlVMz/4nfA81/TWAyXYfLC8MxzCiQMdV9UhlWCJHPZqMnYcq3jxnpfuxFrylntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4888.namprd15.prod.outlook.com (2603:10b6:806:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 14 Jul
 2023 23:22:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1757:f075:376:8ff1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1757:f075:376:8ff1%4]) with mapi id 15.20.6588.028; Fri, 14 Jul 2023
 23:22:19 +0000
Message-ID: <3c21ccc5-567b-8a12-8b82-a4fb63be5451@meta.com>
Date: Fri, 14 Jul 2023 16:22:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 01/15] bpf: Support new sign-extension load
 insns
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060724.389084-1-yhs@fb.com>
 <20230714181333.lrxledwyh6f4mqri@MacBook-Pro-8.local>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230714181333.lrxledwyh6f4mqri@MacBook-Pro-8.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c57367-d7d9-4bd8-8e92-08db84c12b44
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EcrMt2CM8E8+uOWaV1s3l1A5W5rmgTrryyMs8Mvq0NN8PvEpDlvnQK+2hb3BJMFyGV+yOibIrrum+h/NLIOnCTqVmqtG2E8+aUKFOCpirbE2tc40Oug0Rs2tVrQt99BVnKSm7cl+n+et5hM3YxmF28ZVK4eOeWzm2OQXLrY6EPC1harniP50ZrzqhSnMDUhWOUkdlptPgO5VzUo/hJ/PCu05r7gVPDCNsngc+/j/OVvguGWU57UCF5JM4m3Y5TVCIJngweLlikT11pKC5Wx4q8UdHshS7dJsNmDSvLZj7LwBbd9Za0fh4ODSB9K7y0UVqikHQ0HXORsuHLwwMKdRXnlcabibL5csufG1kB4WFtyl6P9PAo+mv8a/kwUnNI60tufab5D3XbabaRAWYFniuUFgIg14G8G3S1NULYunxS4gRCkVCJJa/RQZ5EKB3o/k+ORtPTCbFpgUTlnf1s7dthEdWFel95TYqF5EL+Q1ektGKhh7N+JQyJ2ZMs0lAUilOtuq2CNjheyYGy2/fCtMZb2g93sLGY7/JjNxcchZJ4+m8+YHw4ijN8FzPQCFDQZc4ooXtZIabg8fe//Hm9nvCeQ7Ufj6W7ou3wakZlkajVGj4tiDq/61Tj6RCNpSb+uIoRHH+CdNEEW2N+XK1PbgDw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(31686004)(53546011)(6506007)(38100700002)(31696002)(478600001)(110136005)(54906003)(5660300002)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(6512007)(86362001)(41300700001)(316002)(6486002)(6666004)(2616005)(186003)(36756003)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWQ2dzF2SEd5KzNqSlMxN2M4R3RWTklhWVBweXVoUjVCNVFvVklYcHd4bDBB?=
 =?utf-8?B?a3JPQnlpNjZNQkxsVzNSSzM0YlREOWhzZHJvTko3T1JmTTV2c0pnTllMTi9l?=
 =?utf-8?B?YkNkYTVVa1Jack5tTGNLWVZBaXN3ay9RYlVPcWlxaUhtc2RreWZNNnRZWXB2?=
 =?utf-8?B?T2pYdkJCclZXMU40bVVqMzh1U3A1TFI0WTdha0V5cU94V004WXlFTFRyRUw3?=
 =?utf-8?B?bDM3SVJkaHdFMHcrbnhNd2pmNXZMcnd0M1JmYXlLZkZtY0hHMUN1THdGeUpw?=
 =?utf-8?B?cERoT1lqZlZ3QjNBR0gxTWpIYTgvNzRJajR1VnlBUDdCc1ZmSkxab0crS2p4?=
 =?utf-8?B?NFQxU1NEMHYvWms3eGFBaWtTbC9SNmF0RDdiZmpOTjR3bXRyRitDNFRzaHQx?=
 =?utf-8?B?S0Nac2h0TG5IUWROQkUxamJFZDd1L01wU3Z0Mmk2SzJNbEVjNklLemx5dFE1?=
 =?utf-8?B?VEhYd2Z6TVNSSVV4U1MvemUzSVhGb0kvdzFJVjNsZVAyTFR2UFhHMTZ4aDh3?=
 =?utf-8?B?T0lqbWRLRy9ZVHdjZEI3elVuYyt3dGwrUkNDZ2x1c0ozSXNPNDZ5eEMySWFh?=
 =?utf-8?B?U1VpZzhkU1ltOWRycDFsOThYZXhDa1pkVmc2YkhEMDhEWlpkZElmSi9FMFQ4?=
 =?utf-8?B?N08rVjEraFZaN3VMNHZKTzA1QzN3dHZ2WHNMSWIyOHJzRjBHZFNOellDbTBx?=
 =?utf-8?B?S29DTkU4WitOU3RES2ZLbEJDTlBTdEMralFuWC8zUnk0T25WS0ovV283bUY3?=
 =?utf-8?B?dUlNWXVoeHJ6RDR0U1FPckUxWkVzcTU4QW1RT0pRalRvQWRuSHY1NnczUmJE?=
 =?utf-8?B?Si94VzdXZmtia1dPeXZHcnZadHNZSlBOZlhTdUFzMHZhRkFmbzlhR29NQnU3?=
 =?utf-8?B?WWQrWW9RYmZ5RElyZTRQME9aKy9SclFCSnRaUUFLN2V5Q1ovYWcyRXoyVXI2?=
 =?utf-8?B?by9wWUd4SWt4Qmh2aTRhcnZ4dVFNS09jbHJ1dHhBV3RXbjdBQVd2RGttUWx2?=
 =?utf-8?B?SmdqSjZ4UjI4WUozazRCQndpTkUwaXAyeXpFRWlBVWc0dHl2dnFmV0ZaRExX?=
 =?utf-8?B?YjdJMElxRjV6aFBpZzZuNnBSOHZBdVZYTGhPVTBzUFgwYnBPaEszaHJXRERN?=
 =?utf-8?B?K1pYelprZmFTTlRrZklrZS92bFBmTUZROGZkVWxoNjc0TXFTclQzOFpGaTcz?=
 =?utf-8?B?ZzlyUUNXUG1PVGJUcGY0K1hvN2srTmhUS00zNHJBUW5sWGhZQjhzTk5JVElp?=
 =?utf-8?B?b0xwN3cvZjdDV3hrTjl0VjNRS3c2STZ6Q2UrMkFwcHkreUtNaG5NcUp5ckVY?=
 =?utf-8?B?VFpUbzV3TGIrMUtBNkRGVzBwYVN6TEVCbGZFTUZ3MG1ybmdTR3FTUDBpSUZM?=
 =?utf-8?B?YjVYM3ZTM1F2V1RLZEJrWnpDNHduWXdYSE1ZUlBTSWlSbzZ4QWlVREoweURR?=
 =?utf-8?B?TDNxcUZvdUl0TmlmVFF0MWw2TEl2b3FrUVZnRUpVdEFpcnZ1WVBQSHZzY0J6?=
 =?utf-8?B?N3AzdTI1ZmhVYmdEU2RGbklvbEFwTWN0U3lCN1FEUEdORzZZWTZCRlJRczdW?=
 =?utf-8?B?MU53LzlJUCt2OHQvMEpiNGU0Nk5iWHRtZy9sd2UwRnRPVVZ6Z0RMeXFnUnMr?=
 =?utf-8?B?enR2bHJSOU80U3pKcXgxUW81M1hSRWp1UkhPMThRNDJqL3JvOHM4eE9QdlpK?=
 =?utf-8?B?cFFJa1pya1Z5SlhPLzBkK1pqQnZqUllDblpqbDBKRHdHcHBlYmRDL2hRVk1P?=
 =?utf-8?B?V0w0L0V0dDdaQ2toNzRjNEhBajhGRnVZMlVIakFPTElyNEpabzVGUHV6YkMr?=
 =?utf-8?B?UkJWNmJUYVpUZzFIcForTDBrbS9lSFhBUGFkcW1IdTAxUFA5d2JLYUZwczl3?=
 =?utf-8?B?c241NEE4MnpiQUEycy81eEtNcEIwSGxzb0hBZkg0M2p1K1BMQTFnMElKMm5h?=
 =?utf-8?B?UkdmNTJBSERXN2pWUklpVENFdmtEamRtaWFVTWRaZHN4L0lENnBpckRqSHJh?=
 =?utf-8?B?ZzdTdUg4aTMwSXRPb2tyRTZmSGxleGY4Q0NZanRQZFd1K25iTmpvTU4ra0w2?=
 =?utf-8?B?VTVtOXV5dnRRcTloMlN5VGRVTUVwK0Z1Y1RvWm9RQ04zSTcra0JPaXRnTUlM?=
 =?utf-8?B?M0VMRjhVQVhiY3BHV2VvUk5VTk80TWNpdkpvRm1YYWUyZjcrWnZWc2JxTTAy?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c57367-d7d9-4bd8-8e92-08db84c12b44
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 23:22:19.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHci6ggnzDbak9didYAAE6RhEG7TKL4Gig07T+ehDGOC0tfU2e4CObtbPk6lyk2S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4888
X-Proofpoint-GUID: qIEO8SmjcqFGnhwUjJCM-HSwlk2aoaPO
X-Proofpoint-ORIG-GUID: qIEO8SmjcqFGnhwUjJCM-HSwlk2aoaPO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_11,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/14/23 11:13 AM, Alexei Starovoitov wrote:
> On Wed, Jul 12, 2023 at 11:07:24PM -0700, Yonghong Song wrote:
>>   
>> @@ -1942,6 +1945,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>>   	LDST(DW, u64)
>>   #undef LDST
>>   
>> +#define LDS(SIZEOP, SIZE)						\
> 
> LDSX ?

Ack.

> 
>> +	LDX_MEMSX_##SIZEOP:						\
>> +		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
>> +		CONT;
>> +
>> +	LDS(B,   s8)
>> +	LDS(H,  s16)
>> +	LDS(W,  s32)
>> +#undef LDS
> 
> ...
> 
>> @@ -17503,7 +17580,10 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>>   		if (insn->code == (BPF_LDX | BPF_MEM | BPF_B) ||
>>   		    insn->code == (BPF_LDX | BPF_MEM | BPF_H) ||
>>   		    insn->code == (BPF_LDX | BPF_MEM | BPF_W) ||
>> -		    insn->code == (BPF_LDX | BPF_MEM | BPF_DW)) {
>> +		    insn->code == (BPF_LDX | BPF_MEM | BPF_DW) ||
>> +		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_B) ||
>> +		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_H) ||
>> +		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_W)) {
>>   			type = BPF_READ;
>>   		} else if (insn->code == (BPF_STX | BPF_MEM | BPF_B) ||
>>   			   insn->code == (BPF_STX | BPF_MEM | BPF_H) ||
>> @@ -17562,6 +17642,11 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>>   		 */
>>   		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
>>   			if (type == BPF_READ) {
>> +				/* it is hard to differentiate that the
>> +				 * BPF_PROBE_MEM is for BPF_MEM or BPF_MEMSX,
>> +				 * let us use insn->imm to remember it.
>> +				 */
>> +				insn->imm = BPF_MODE(insn->code);
> 
> That's a fragile approach.
> And the evidence is in this patch.
> This part of interpreter:
>          LDX_PROBE_MEM_##SIZEOP:                                         \
>                  bpf_probe_read_kernel(&DST, sizeof(SIZE),               \
>                                        (const void *)(long) (SRC + insn->off));  \
>                  DST = *((SIZE *)&DST);                                  \
> 
> wasn't updated to handle sign extension.

Thanks for catching this!
> 
> How about
> #define BPF_PROBE_MEMSX 0x40 /* same as BPF_IND */
> 
> and handle it in JITs and interpreter.

Good idea. Will do.

> We need a selftest for BTF style access to signed fields to make sure both
> interpreter and JIT handling of BPF_PROBE_MEMSX is tested.

Will do.




