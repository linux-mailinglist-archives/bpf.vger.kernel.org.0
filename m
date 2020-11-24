Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2650A2C2C40
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 17:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389784AbgKXQEz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 11:04:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47648 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728249AbgKXQEz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 11:04:55 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AOG4bCa023059;
        Tue, 24 Nov 2020 08:04:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QItkE125Yu6MNGdw5hGB3vLd1u4rcmaSi8/9JIntbng=;
 b=L7Ipf0WLuunJfewGQP/DF0fMyv9leonKBBkvC2uHccyBsPBdHAZFEzea5Z6HzY2FlNKd
 rObmPNssbVVp+f7hR8N1wK6wD2po2fkHoOLH3K1Q54zP6UBWiOrUYx8TdisNVxRKOwcK
 lrpEmGec4Z/ehPHzsaXYfrwUBClpX/R6Av0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34ywv0rprc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 08:04:38 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 08:04:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNXnSBLMNQiX1ty7YKVrwu4IGXxPd+fXCtS0wunP6sq2M7n1LjZC34JVyIBpasulSHwmALPu2HUerG5lhXetnpqooSooFe1eu/txDZ0uoA901rvJnYvDg2hKYdtmTWaU53RszzM2j4qpltQyuJcbx6imnqp/Hs37EHX1whisb7KnfCkwrX9TrY02+/0Qkwdn958ooaxc3luD/8cJCw29G8UrbB5B6J9NImT0FUE5+FsINW+tyier6+VD0eqT1eyMKNrHG+JdBurdY27OTXMx8R5ITlxaRgRWg47o/j6PuJAxzQ6hiFm1jiO9PXoFFcrz7w3CjQS3DNZqraSu1InwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QItkE125Yu6MNGdw5hGB3vLd1u4rcmaSi8/9JIntbng=;
 b=esdaDES4p4x7JIpujl/ToMJuT0ySE8tPfL+HlnDnCqOlWFKbCRlSiA2pXpx5xCtGjtv4oNv1ahoCE4XUXXLAG/pOjdKo6ra5TyujdgANud1M03ovS8by6+83vUxkEXRUCPTLLwR7KBBoXmaXecP0J7NpKkgcVF7eOqOqCzgluDGiErrrQz43RFdeSGeBzeZAgg7zRVSYIFdhMp/5FV4lzFjaNi72d/bjh6DFd0Y2od3cVjiAiOsbsvPcEzzJ0dSJaP9P2TRY8kRbJjoILsnToz8R6gvggAfc2fxUg9iFpFj9bgPFePcd86MchTTzIf9CD4SCxwmfwraYSLc5Icy1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QItkE125Yu6MNGdw5hGB3vLd1u4rcmaSi8/9JIntbng=;
 b=E7lTbjM/QK6s0My+IZuh+Xq858GtNNVasRZWZw9O6Hljx43FzfDtj9BP0W6UeIBS54O9l9HKd+/SAI74PXaHLwuUjiclspjLh3LH7h/Xchg2gJhRfTi5nikzlm5BnMaprBmeD/oeTa98ynhh1YBS9pLzyCxn5HDvq4xK0FIyJ7g=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3207.namprd15.prod.outlook.com (2603:10b6:a03:101::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Tue, 24 Nov
 2020 16:04:03 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Tue, 24 Nov 2020
 16:04:03 +0000
Subject: Re: [PATCH 3/7] bpf: Rename BPF_XADD and prepare to encode other
 atomics in .imm
To:     Brendan Jackman <jackmanb@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-4-jackmanb@google.com>
 <e7d336ab-524f-9d60-e9ec-8c8426cae0d7@fb.com>
 <20201124110209.GC1883487@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <35e581bd-dd61-7448-1843-d59c41bd122e@fb.com>
Date:   Tue, 24 Nov 2020 08:04:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201124110209.GC1883487@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4987]
X-ClientProxiedBy: MW4PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:303:8f::35) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::10b2] (2620:10d:c090:400::5:4987) by MW4PR03CA0030.namprd03.prod.outlook.com (2603:10b6:303:8f::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 16:04:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec50a4e4-cc19-4d4d-6710-08d890929049
X-MS-TrafficTypeDiagnostic: BYAPR15MB3207:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32074F61B1BA47E88F78399AD3FB0@BYAPR15MB3207.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4c02/7VibtBvkgzW1EFWePeDoOMOMvkfF2NgneCcm5SXyJFS+ymMIzfUnmA1fPxIkTNjnrLDy3h4wCaWCuGdkGBl3I5NJdQNKS97KIhdGQoUT8GjQgwfS0kXXosMcOk97yRpwTtm9Lk3+ne0mv5gIcnLVmRZC7JF8NvDwCi/D7xtuuaOdITpMP597IUmWqcSWEXlWrHQl9Avapg9WV3a+phmES9An3/zFo8uj30xGBKB9BBUI0bDEr3XXnLaf8JZo62LuYS2Y6R29KMuNMCZo3bFROwxJkl7kOGMogbo8TyL3J1/JlpasOR4shDhFsovwv5I6eDDX4KxMUD9cPaWNvN6VewstWE6jdS1oWkLOxkJahCfKKvfzc1W8E5Ix6gmi5oiqUydbHoDRzyL9OEadQD1hHz0mz9eSux0R7TQZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(66476007)(316002)(2616005)(8936002)(2906002)(66946007)(86362001)(83380400001)(6486002)(31686004)(66556008)(52116002)(6916009)(16526019)(31696002)(36756003)(186003)(4326008)(478600001)(53546011)(54906003)(8676002)(5660300002)(142923001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Mzl4TVRuQXhwWXFTY3RkNE9ENnM0Wm94ZGF2NFd6M3NaQjhrTWl1ZzIxN0lW?=
 =?utf-8?B?WUw2V0tobmp4aVdOTDI2NisvR3U5SUhXeVlMWHdzWWEyeFVVbkMvMzg5VWpa?=
 =?utf-8?B?ZnlCUS94ckdISWdJdm14aXZUMlBXMVRBSzlJc3I2NkVzbmZOVU5Tcm9sOXA4?=
 =?utf-8?B?c2VBT2ZNNzl3QmRiNVpvbDFXM0hpSHFnVFdjVC9HTXZNYjlYQWJ2R011RDZO?=
 =?utf-8?B?eW9qS1U2MFpvZ1o5UUZxTVIyWDlJR3Q2em1JeHhmbWxuYlVtbjhoR2V0dHRw?=
 =?utf-8?B?Y25LWm5kdXNESmZNNnh1c2wvaHQvcERnU1YvczEySXB0ZTU1Q09aUTdqVU1R?=
 =?utf-8?B?ZFdhTU9scnRtMXpGSzcwa0YxRkgzb3hUdXh1QlhOem1SUzdjZFR0VG9NcnhJ?=
 =?utf-8?B?Z1ExamVWYkFIMm5KcWdqS2pBbUw0V2h6MUdEQXo2NUFTeFBPTVVUQkhKam9j?=
 =?utf-8?B?TEI3b01HbFNPZG5jQUl3eDV3RlZmeWd4bXY3RGhvQzRrSmowdXlGdVU4UEtw?=
 =?utf-8?B?R2E3bzNOc1JsdVpLZ0ZKWGdoY3dLSVVnUEVGd3loYXRkajRJTlJXSy9TZEYz?=
 =?utf-8?B?QkJTZHpDZXJpcjRUVThhVFpGRmhZOElBUUlhQVc4b1d0T2pXVFhHaERPVWRI?=
 =?utf-8?B?Nk9FZ2l2WkxlZHBzaktNR1J6bGJTZmkvY3N4a1VweGNCWHZLTFg0bEUzL0pw?=
 =?utf-8?B?R2gzTDdhOXU4Rnc5TEdFTElmUVNQOGl1eVViZmN1ZU5yZm15VVZkOVVWbkcx?=
 =?utf-8?B?MG5LNFBrcTlFa3NQTGVieWg0RGZGMytjWFpaVU45dngvL0haZWtnTzVYUXYw?=
 =?utf-8?B?OGtBTERRV29XT1B2TW5IcElNVjZ2NzEyalk4WEhQc25ORVFnc1h4VVlwenZY?=
 =?utf-8?B?ZENwQlRsdTNIMm9ZUHdUVmE5a1I3eUZZSGQvdVY2Zmlxb013MytyYlJSZStV?=
 =?utf-8?B?a24rcURxbkhuK1FxeC9saG5pdW80T2JNZTZpUFdLK2dtQ0o5YklqTXBMcUMz?=
 =?utf-8?B?RnU3QUprRlpkaVZKZmM3cWw4RnZjYWo1Nmoyb0VUK0IzUktRYnptb2dDUGtP?=
 =?utf-8?B?U0lnS2dCYVlXdWt4U0lySDJiZ2ZEK1Q5cHVxU0NKMjUyNWwrSnlNTUIvd3I5?=
 =?utf-8?B?VmJISWFpOEJkRmM0dmVrQnF1ay9EOGpOaWZXa2RXZ25Sem9uVFR4OHZJK3hC?=
 =?utf-8?B?em1IanYxTll2Nk5obHNMbFNGUHVPNk9peTdBMmpuT0wvSlBzS2tHS2hwL1cy?=
 =?utf-8?B?dW52MHd4RFNmdi9IQVk4NWgwVlN3aGk4MllUN1hHb0ozRVdJd1l3L1E0SS85?=
 =?utf-8?B?ZDdCN1lvS2xOd0NGUWovbFhmQk1DTWdMbFgzQTlJNkxSdzRjdEV6S0k5VEVO?=
 =?utf-8?B?SXQvYnRINmhhSnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec50a4e4-cc19-4d4d-6710-08d890929049
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 16:04:03.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JW5KdweGNtrPP9+SVdKK6hvh6lnpSRh01wRp4A07wy3PizINENtdyH0SnA2RjL7D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3207
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/24/20 3:02 AM, Brendan Jackman wrote:
> On Mon, Nov 23, 2020 at 03:54:38PM -0800, Yonghong Song wrote:
>>
>>
>> On 11/23/20 9:31 AM, Brendan Jackman wrote:
> ...
>>> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
>>> index 0207b6ea6e8a..897634d0a67c 100644
>>> --- a/arch/arm/net/bpf_jit_32.c
>>> +++ b/arch/arm/net/bpf_jit_32.c
>>> @@ -1620,10 +1620,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
>>>    		}
>>>    		emit_str_r(dst_lo, tmp2, off, ctx, BPF_SIZE(code));
>>>    		break;
>>> -	/* STX XADD: lock *(u32 *)(dst + off) += src */
>>> -	case BPF_STX | BPF_XADD | BPF_W:
>>> -	/* STX XADD: lock *(u64 *)(dst + off) += src */
>>> -	case BPF_STX | BPF_XADD | BPF_DW:
>>> +	/* Atomic ops */
>>> +	case BPF_STX | BPF_ATOMIC | BPF_W:
>>> +	case BPF_STX | BPF_ATOMIC | BPF_DW:
>>>    		goto notyet;
>>>    	/* STX: *(size *)(dst + off) = src */
>>>    	case BPF_STX | BPF_MEM | BPF_W:
>>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>>> index ef9f1d5e989d..f7b194878a99 100644
>>> --- a/arch/arm64/net/bpf_jit_comp.c
>>> +++ b/arch/arm64/net/bpf_jit_comp.c
>>> @@ -875,10 +875,18 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>>>    		}
>>>    		break;
>>> -	/* STX XADD: lock *(u32 *)(dst + off) += src */
>>> -	case BPF_STX | BPF_XADD | BPF_W:
>>> -	/* STX XADD: lock *(u64 *)(dst + off) += src */
>>> -	case BPF_STX | BPF_XADD | BPF_DW:
>>> +	case BPF_STX | BPF_ATOMIC | BPF_W:
>>> +	case BPF_STX | BPF_ATOMIC | BPF_DW:
>>> +		if (insn->imm != BPF_ADD) {
>>
>> Currently BPF_ADD (although it is 0) is encoded at bit 4-7 of imm.
>> Do you think we should encode it in 0-3 to make such a comparision
>> and subsequent insn->imm = BPF_ADD making more sense?
> 
> Sorry not quite sure what you mean by this... I think encoding in 4-7 is
> nice because it lets us use BPF_OP. In this patchset wherever we have
> (insn->imm == BPF_ADD) meaning "this is a traditional XADD without
> fetch" and (BPF_OP(insn->imm) == BPF_ADD) meaning "this is an atomic
> add, either with or without a fetch".
> 
> Does that answer the question...?

Yes, thanks for explanation. It is a little bit odd but certainly 
acceptable.

> 
>>> diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
>>> index 0a721f6e8676..0767d7b579e9 100644
>>> --- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
>>> +++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
>>> @@ -3109,13 +3109,19 @@ mem_xadd(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta, bool is64)
>>>    	return 0;
>>>    }
>>> -static int mem_xadd4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
>>> +static int mem_atm4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
>>>    {
>>> +	if (meta->insn.off != BPF_ADD)
>>> +		return -EOPNOTSUPP;
>>
>> meta->insn.imm?
>>
>>> +
>>>    	return mem_xadd(nfp_prog, meta, false);
>>>    }
>>> -static int mem_xadd8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
>>> +static int mem_atm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
>>>    {
>>> +	if (meta->insn.off != BPF_ADD)
>>
>> meta->insn.imm?
> 
> Yikes, thanks for spotting these! Apparently I wasn't even compiling
> this code.
> 
