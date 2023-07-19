Return-Path: <bpf+bounces-5235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD70758B4D
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 04:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4931A281850
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683D617FF;
	Wed, 19 Jul 2023 02:28:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BF17D0
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:28:44 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB11BC6
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 19:28:42 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IIwAXL016262;
	Tue, 18 Jul 2023 19:28:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=lOw6sxTXuA93B4RxTJj0Z7nhHuh5UktcGFWYbd/afsk=;
 b=WKJ1R8f7hjqDLlMZRTTj3xuVmZiSZBIrldnq0KbpdgFzd8RWaMSbtYtzJRn+uB2Y6p6+
 zqykoU3p0bU48OxmNZ/2hzK08P6qgtUlzv90hi0ZSFCvJmgiMuSABqYZU9b5VTUOU6+A
 mvtANbYbj92o04P2UU/BKP1HXmUP6V6dFnrygQFuqLOpnkIQEnVUeom+31LITNhmy11r
 tARMzrJCosbn8OoyctVpZR/oPTM6Ye9g/2g86owGzyko6DeQ7wDFJnLvYsio0R8haTfd
 XkRuGn+Nfm30r955NVl7peUKZNw5UHLTXgDZDkW6lhdhJKyntNQCXrbZVdRQAk8NlGuH pg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rwgun2776-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jul 2023 19:28:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCh1ua5CMmbLKkDVWppryxeIZ/K9AKKc02H18DUPWWYGcOs5wCuhrshGbVk9V25q2HHJ1kgizQ2PAiNnjUEyEtQhqVx/Jy11NyvoisatS48Pis8J0KUAAlF4edqmUPk2kdiPy13Olh50McX5Lr/bKRFggX2T0NjfRys46uXuNeB4npUSXCzNxfi+6XTHyezv/gvyMBFzB9xOUVui4i4dsN+ZUtK6VZoGwneTE4xFUVCh0jLjmmx/JtB6tt0F5CvmoKESjqWWCT4h5CbaPwq9fne5kiLp2m3jGdd+v5vXmelYqKbo6aHmoE1FpHJYxsZMAvJEnjNcZNzxDjw5kTuprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOw6sxTXuA93B4RxTJj0Z7nhHuh5UktcGFWYbd/afsk=;
 b=YXzVAxcE5TvY0Q/M2ZzWbINo0eYyegR1YOpVJG+WQ+pJBAEx1nt0Okq805Z4SQg8m2salxKeO+tjL9ZeGMbyFePeAq4ANu9TH2M871nTDrokQZ0VDXM+ViMjYfRW7NG8mKdOGI+BUzMBaYymVaIo7HN9nC6w+x6nyohQ33slXvQMploIL4AAw3IAa+o1MGnTndJ2Y3ECGFU6RCI8JYEp4haXfifEB0GKGXNNIGqh18FGUDHL87o5Xqe5i7Gz511tGCObPvphtRTsI34IJ0eoZx2VOhaXAgv/Vz/QnhYalB/wGEpBUyhgnPf1lFsBYh/IVjJgLSnbkURtax4SQWtdIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3878.namprd15.prod.outlook.com (2603:10b6:5:2b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 02:28:22 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 02:28:22 +0000
Message-ID: <87389159-041e-30f3-de52-37bdcac93996@meta.com>
Date: Tue, 18 Jul 2023 19:28:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 01/15] bpf: Support new sign-extension load
 insns
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060724.389084-1-yhs@fb.com>
 <3dc1a59f45b1f7353548b9682cb6ee18832dc017.camel@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <3dc1a59f45b1f7353548b9682cb6ee18832dc017.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::7) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3878:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e387ed3-8055-4b88-3f16-08db87ffd231
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Yzwui4EcfhWmK/5EPCaeUnte7QwzKP6+S7Gnu5/clOXYnRblIQMY5n2ithECgQBOCW1ykiFYQtrdFBwy5nFoE5G59+KK1DDLMx5M+OxonHXJXvqK/Tll+PkOQzEq2W7p4cTCTeFh/BD0i/mDry3HBCVTwJ09mtLRqByUR5sYFNoHKpKwbTRj5DOuw7huHmEPTGqqs5kMn2N3IylVYsxEWTXAQRBrvn1yGjwHLHYDfyxLyog6/T3WuqPt9fgh4KifOoXsXKoRa/hq3/S0k143qwHVGUyZ2sTg80nsk++rg168VI31FRje5bR9SoMgewJsFN5AUCx8hSyp84VBCk8P+ye1uCCxC03gO/X7FwN4XIq8WvXyKqq3OBdS7/jhWr2Ru9Q2pR+2zQI31+RACITD+j1hAXsOoL8+gkbTDSGdsInqiwl7bV4ssDjRhb9Qsl4S94PmYNYk2XsGKFpwtUn+MeVxsqGwt/PDY8q3SMCQs4iLgwQyEAE6rZFWXeQ6Cyey9bqd31rXMcMYudCh8DIhEbBWr2LRZyLaYhCm/X2iIAxUtnFGS/mlIdFKQ9CSnNp/1gxlx5Gr3htt2XG5MOMbHensxNowcoLvgZhpDymC1B3pqGndEkaUM/95t1Wns1UnbtjS/MLxSD8coGxZ6AEkBQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(66476007)(66556008)(54906003)(110136005)(86362001)(186003)(66946007)(4326008)(478600001)(41300700001)(316002)(6512007)(31686004)(6486002)(6666004)(8676002)(8936002)(6506007)(5660300002)(36756003)(2906002)(31696002)(53546011)(83380400001)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SWphS29wT1RLbjNLUHBXLy9xWjZOenNkV2hBcVpMb1RNN3BmSmIwMmZSTHpr?=
 =?utf-8?B?aGU3Mk96YUpEL0RzcFE0ZU96WHN2NUhEMDVQVG9vUVVDd2dUSmVqMzZiTGZB?=
 =?utf-8?B?c0RGaDRMYVBNTDlRVlNWWGM1M1hQaUYyUWQ0TFN0QlJWbmhIanFFWWh4a0tu?=
 =?utf-8?B?R0RtUGRBNzR5dnV4d1RHKzNTRy92RUJYU2MyS1I5VXlTT2lDNTBlMElMeDgw?=
 =?utf-8?B?MlZGdnVjdUxLTzF2cFFXZjJRNitvcWUrc3RLWllnV3Flam1nN1g1NHMrYmZu?=
 =?utf-8?B?VGxUZHFYSTdRRkU3OGNUcHdrKy9Wd04wbytwR3BRYWNMUE0wdmRPOG5Zei9G?=
 =?utf-8?B?eGwyY05HTGdPRVNReE4ra0RQd09NbVJqcFBsa25peDdrTUZleHE4aHJTVE1q?=
 =?utf-8?B?YXRGaWVOcWhqYnpuRlZZd01qaTdUK1dmdGdKSXlwY0RIdy9kM3o5MlBnL1Z1?=
 =?utf-8?B?N28xTFpuWFRiTjNNeVB4Q1BNY294aTZsaHJKeElXY3daMzk3SDg0czBoNVI4?=
 =?utf-8?B?WXNxK0xsQTFVTzhnUW54a1R0aWZKbHhRN25tTVNxZG5WK29yMG42eDhMTisz?=
 =?utf-8?B?OXh5YVdjb0t3dHVwZEROMk9TNStOdGc5VUZBcW83eDVhSHhXYjFsUURPRTZG?=
 =?utf-8?B?dkRDMDM0VHk2YlRKWXlWSDdEM2RDTzEvSStYVWd0cVR1OU5XMGQrcE9lRmlW?=
 =?utf-8?B?VEZrNStMTlBhdm1uVkhFeDVPWTRmWVI5RUJNckhjbWdMcUZXUzhxZlMyQWFa?=
 =?utf-8?B?WUkvYVhCWkJkTXlPbFM4MXlLeUhGZ3VWSTRvUFFjK25rWmQ3dzVZdG95UTFM?=
 =?utf-8?B?RFdoV3VhRGNwUCtNdW16TzJyekw2Y2UwcHJUUG1wbjY0aU90KzZiVkFqNHVl?=
 =?utf-8?B?dmJib05ueVdyODh3di9YYURSU0toSlZsZlh3NUZ3TCtFcUtoQ3VQaTROaG5S?=
 =?utf-8?B?QlpHNCs2TjVXTEptbkJGZUhhUmt3emlFV1Q1cWhYMGg2bUZDMUVnanFZVFBm?=
 =?utf-8?B?NHNkZUE4Yy9BNkc0K01iNE9jSTJsR1h1c2FvRmpoVFhLU1h1Nkg0VUMvVlVJ?=
 =?utf-8?B?RGhtcHQrQ01XMW5qSkRzT2cvRndBeGE2SUxyYXo5bDQxMFBLUGFobjBXUzZJ?=
 =?utf-8?B?aFYvMXVOZkpmbmNLTUFPOTZVNlR1VVRaSVBqMk8zY1dnM3YraTlQSm9yZStq?=
 =?utf-8?B?b0JLQWR1VEh4d09zUll5bzJvcWFuMnFMYUdNcVlSNysrY3VWWFZMSEozSnVV?=
 =?utf-8?B?Z2hMNytFR3Y5ZHovOGRiZXZBMkEzSzFmR0hHNjMxZEFYZ09QRms4S0tqY0hj?=
 =?utf-8?B?OVhUY01oUXRRSUpzcklxVVpWblFyT0VCSHhrSGZKcTdOZFJ5ZEEwelhXcWNV?=
 =?utf-8?B?TVdiNGplVVBrVlBLVDM3SFRvZXNpMExlei9aRTlNaDN3aW53M2JlcUtpUnJU?=
 =?utf-8?B?aG1qMmk1bzlubVRrQ3BtTktZVFFkSkdrbVZxZXdZRDgzSVVnSHEzRjl5VFlu?=
 =?utf-8?B?UFBmZFdkc3V5Q2VLbmlraFRMU1pVbFVRV29ZNnFDSzlLVWJQYy9OWjZkeG9Q?=
 =?utf-8?B?bER1VHd1aXIyd3FBcTJna3cwb2IrbkpBOGRONFdsOEhLSEJ3dVpyRnhzVE5R?=
 =?utf-8?B?bkhnREVxaWVFditzY1lLcmx3Ly9ZVmRuK2tUS2czZytFTy9lZTlFSC9qOUpv?=
 =?utf-8?B?b1Q5UjdId2R2OUlaSi9SbXlsU2U0bmZrMGo5N0ZhdGFTODZNWFUxdU9OOCs1?=
 =?utf-8?B?aGVTcFpSZGZFaDRrTXVldHVxSlhyb0pMTCthMDcrSWpvTytjRm1uSUZlMWpn?=
 =?utf-8?B?bEJ2U052eTJvVW5xeDNxSWJhVm1DSzd4bkxjMHJNWWdvbnBMQVU4clpUMWMx?=
 =?utf-8?B?Yk5ZUUJrQkx1bGM3enJqTExmdE1seTYvY3hjNXkwc3B1VEw4a1NCZ1dud2J1?=
 =?utf-8?B?OTk0aW4vbHFtRVE3VXJoNmVETFZqZ2lWVVJRU040SGE0bUdOZjBIemdMWDJv?=
 =?utf-8?B?QkxraHRkWkcyS0xCditVYVNVVCtqZEFjeXd6VXlKTHVRNURmdWJKdjY3RytL?=
 =?utf-8?B?ZUJ0VWk2K3dTRkNBcDFERnNtNDdYNHV0cFhYeXBJSmtvM0JzL2EvS0FybnZJ?=
 =?utf-8?B?empyVXlEcmoyMFJSQ24wR2VPNDVLTEpncWNOZnhHbGpDVTh1ZlhBUkpYWXU1?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e387ed3-8055-4b88-3f16-08db87ffd231
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 02:28:21.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HTRG/8BdfLhNuetI6QLHeamq/0Z4NGSiiMje5iL4RguMy9x4Krmg9MVoH06bqse
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3878
X-Proofpoint-GUID: 3qjcHoZJUVofz5KXMEqWEBXisLDixv3K
X-Proofpoint-ORIG-GUID: 3qjcHoZJUVofz5KXMEqWEBXisLDixv3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_19,2023-07-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/18/23 5:15 PM, Eduard Zingerman wrote:
> On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
>> Add interpreter/jit support for new sign-extension load insns
>> which adds a new mode (BPF_MEMSX).
>> Also add verifier support to recognize these insns and to
>> do proper verification with new insns. In verifier, besides
>> to deduce proper bounds for the dst_reg, probed memory access
>> is handled by remembering insn mode in insn->imm field so later
>> on proper jit insns can be emitted.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   arch/x86/net/bpf_jit_comp.c    |  32 ++++++++-
>>   include/uapi/linux/bpf.h       |   1 +
>>   kernel/bpf/core.c              |  13 ++++
>>   kernel/bpf/verifier.c          | 125 +++++++++++++++++++++++++++------
>>   tools/include/uapi/linux/bpf.h |   1 +
>>   5 files changed, 151 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 438adb695daa..addeea95f397 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -779,6 +779,29 @@ static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
>>   	*pprog = prog;
>>   }
>>   
>> +/* LDX: dst_reg = *(s8*)(src_reg + off) */
>> +static void emit_ldsx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
>> +{
>> +	u8 *prog = *pprog;
>> +
>> +	switch (size) {
>> +	case BPF_B:
>> +		/* Emit 'movsx rax, byte ptr [rax + off]' */
>> +		EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xBE);
>> +		break;
>> +	case BPF_H:
>> +		/* Emit 'movsx rax, word ptr [rax + off]' */
>> +		EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xBF);
>> +		break;
>> +	case BPF_W:
>> +		/* Emit 'movsx rax, dword ptr [rax+0x14]' */
>> +		EMIT2(add_2mod(0x48, src_reg, dst_reg), 0x63);
>> +		break;
>> +	}
>> +	emit_insn_suffix(&prog, src_reg, dst_reg, off);
>> +	*pprog = prog;
>> +}
>> +
>>   /* STX: *(u8*)(dst_reg + off) = src_reg */
>>   static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
>>   {
>> @@ -1370,6 +1393,9 @@ st:			if (is_imm8(insn->off))
>>   		case BPF_LDX | BPF_PROBE_MEM | BPF_W:
>>   		case BPF_LDX | BPF_MEM | BPF_DW:
>>   		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
>> +		case BPF_LDX | BPF_MEMSX | BPF_B:
>> +		case BPF_LDX | BPF_MEMSX | BPF_H:
>> +		case BPF_LDX | BPF_MEMSX | BPF_W:
>>   			insn_off = insn->off;
>>   
>>   			if (BPF_MODE(insn->code) == BPF_PROBE_MEM) {
>> @@ -1415,7 +1441,11 @@ st:			if (is_imm8(insn->off))
>>   				start_of_ldx = prog;
>>   				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
>>   			}
>> -			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>> +			if ((BPF_MODE(insn->code) == BPF_PROBE_MEM && insn->imm == BPF_MEMSX) ||
>> +			    BPF_MODE(insn->code) == BPF_MEMSX)
>> +				emit_ldsx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>> +			else
>> +				emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>>   			if (BPF_MODE(insn->code) == BPF_PROBE_MEM) {
>>   				struct exception_table_entry *ex;
>>   				u8 *_insn = image + proglen + (start_of_ldx - temp);
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 600d0caebbd8..c7196302d1eb 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -19,6 +19,7 @@
>>   
>>   /* ld/ldx fields */
>>   #define BPF_DW		0x18	/* double word (64-bit) */
>> +#define BPF_MEMSX	0x80	/* load with sign extension */
>>   #define BPF_ATOMIC	0xc0	/* atomic memory ops - op type in immediate */
>>   #define BPF_XADD	0xc0	/* exclusive add - legacy name */
>>   
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index dc85240a0134..8a1cc658789e 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -1610,6 +1610,9 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
>>   	INSN_3(LDX, MEM, H),			\
>>   	INSN_3(LDX, MEM, W),			\
>>   	INSN_3(LDX, MEM, DW),			\
>> +	INSN_3(LDX, MEMSX, B),			\
>> +	INSN_3(LDX, MEMSX, H),			\
>> +	INSN_3(LDX, MEMSX, W),			\
>>   	/*   Immediate based. */		\
>>   	INSN_3(LD, IMM, DW)
>>   
>> @@ -1942,6 +1945,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>>   	LDST(DW, u64)
>>   #undef LDST
>>   
>> +#define LDS(SIZEOP, SIZE)						\
>> +	LDX_MEMSX_##SIZEOP:						\
>> +		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
>> +		CONT;
>> +
>> +	LDS(B,   s8)
>> +	LDS(H,  s16)
>> +	LDS(W,  s32)
>> +#undef LDS
>> +
>>   #define ATOMIC_ALU_OP(BOP, KOP)						\
>>   		case BOP:						\
>>   			if (BPF_SIZE(insn->code) == BPF_W)		\
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 81a93eeac7a0..fbe4ca72d4c1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5795,6 +5795,77 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
>>   	__reg_combine_64_into_32(reg);
>>   }
>>   
>> +static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
>> +{
>> +	if (size == 1) {
>> +		reg->smin_value = reg->s32_min_value = S8_MIN;
>> +		reg->smax_value = reg->s32_max_value = S8_MAX;
>> +	} else if (size == 2) {
>> +		reg->smin_value = reg->s32_min_value = S16_MIN;
>> +		reg->smax_value = reg->s32_max_value = S16_MAX;
>> +	} else {
>> +		/* size == 4 */
>> +		reg->smin_value = reg->s32_min_value = S32_MIN;
>> +		reg->smax_value = reg->s32_max_value = S32_MAX;
>> +	}
>> +	reg->umin_value = reg->u32_min_value = 0;
>> +	reg->umax_value = U64_MAX;
>> +	reg->u32_max_value = U32_MAX;
>> +	reg->var_off = tnum_unknown;
>> +}
>> +
>> +static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>> +{
>> +	u64 top_smax_value, top_smin_value;
>> +	s64 init_s64_max, init_s64_min, s64_max, s64_min;
>> +	u64 num_bits = size * 8;
>> +
>> +	top_smax_value = ((u64)reg->smax_value >> num_bits) << num_bits;
>> +	top_smin_value = ((u64)reg->smin_value >> num_bits) << num_bits;
>> +
>> +	if (top_smax_value != top_smin_value)
>> +		goto out;
>> +
>> +	/* find the s64_min and s64_min after sign extension */
>> +	if (size == 1) {
>> +		init_s64_max = (s8)reg->smax_value;
>> +		init_s64_min = (s8)reg->smin_value;
>> +	} else if (size == 2) {
>> +		init_s64_max = (s16)reg->smax_value;
>> +		init_s64_min = (s16)reg->smin_value;
>> +	} else {
>> +		/* size == 4 */
>> +		init_s64_max = (s32)reg->smax_value;
>> +		init_s64_min = (s32)reg->smin_value;
>> +	}
>> +
>> +	s64_max = max(init_s64_max, init_s64_min);
>> +	s64_min = min(init_s64_max, init_s64_min);
>> +
>> +	if (s64_max >= 0 && s64_min >= 0) {
>> +		reg->smin_value = reg->s32_min_value = s64_min;
>> +		reg->smax_value = reg->s32_max_value = s64_max;
>> +		reg->umin_value = reg->u32_min_value = s64_min;
>> +		reg->umax_value = reg->u32_max_value = s64_max;
>> +		reg->var_off = tnum_range(s64_min, s64_max);
>> +		return;
>> +	}
>> +
>> +	if (s64_min < 0 && s64_max < 0) {
>> +		reg->smin_value = reg->s32_min_value = s64_min;
>> +		reg->smax_value = reg->s32_max_value = s64_max;
>> +		reg->umin_value = (u64)s64_max;
>> +		reg->umax_value = (u64)s64_min;
> 
> I think the last two assignments are not correct for the following example:
> 
> {
> 	"testtesttest",
> 	.insns = {
> 		BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
> 		BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 0xff80, 2),
> 		BPF_JMP_IMM(BPF_JGT, BPF_REG_0, 0xffff, 1),
> 		{
> 			.code  = BPF_ALU64 | BPF_MOV | BPF_X,
> 			.dst_reg = BPF_REG_0,
> 			.src_reg = BPF_REG_0,
> 			.off   = 8,
> 			.imm   = 0,
> 		},
> 		BPF_EXIT_INSN(),
> 	},
> 	.result = ACCEPT,
> 	.retval = 0,
> },
> 
> Here is execution log:
> 
> 0: R1=ctx(off=0,imm=0) R10=fp0
> 0: (85) call bpf_get_prandom_u32#7 ; R0_w=Pscalar()
> 1: (a5) if r0 < 0xff80 goto pc+2   ; R0_w=Pscalar(umin=65408)
> 2: (25) if r0 > 0xffff goto pc+1   ; R0_w=Pscalar(umin=65408,umax=65535,var_off=(0xff80; 0x7f))
> 3: (bf) r0 = r0                    ; R0_w=Pscalar
>                                        (smin=-128,smax=-1,
>                                         umin=18'446'744'073'709'551'615,
>                                         umax=18'446'744'073'709'551'488,
>                                         var_off=(0xffffffffffffff80; 0x7f),
>                                         u32_min=-1,u32_max=-128)
> 4: (95) exit
> 
> Note that umax < umin, which should not happen.
> In this case the assignments in question are:
> 
>      reg->umin_value = (u64)s64_max; // == -1   == 0xffffffffffffffff
>      reg->umax_value = (u64)s64_min; // == -128 == 0xffffffffffffff80

Thanks for pointing out. Yes, the assignment is incorrect and they are
mismatched. Will fix the issue and add a test for this.

> 
> 
>> +		reg->u32_min_value = (u32)s64_max;
>> +		reg->u32_max_value = (u32)s64_min;
>> +		reg->var_off = tnum_range((u64)s64_max, (u64)s64_min);
>> +		return;
>> +	}
>> +
>> +out:
>> +	set_sext64_default_val(reg, size);
>> +}
>> +
>[...]

