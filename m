Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D94201EBC
	for <lists+bpf@lfdr.de>; Sat, 20 Jun 2020 01:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgFSXqH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 19:46:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2520 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728606AbgFSXqG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 19:46:06 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JNehq0003056;
        Fri, 19 Jun 2020 16:45:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Bq9tqiVWnRasmZSWNi2vTXpVYIBefGkKN2UxqbcadDE=;
 b=P9hs3bg3QqhzFs5VEmPOj4hythI9IRHgIqeA87oTpj9IFM6+Q6f9XRG5wfaNbfQNerkS
 iw+LeA2nCS8Dlo1eV0bUq7Fowo+rNI8g757KcTHgJP3iQtooGDLyl/5lOWcHbQBB337w
 zRP3JJXDrVzxowBXDYSk18oK8QYnrbzoBWs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31rqwqxv07-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Jun 2020 16:45:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 16:45:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCqQDcRyJpxIzDzLwcyeQb4PcE7tq5+ehVOO1QyVgPBMpe6P28uaxg8SWDeTfNKpqn8QEFiQXmPpqYENj+7WDWjdcOyD92pOfn/vAvQaqVSl+ZNwVW2F2mq6DxPuwAe42rMp9GiYy3EiExFZYAW1+XQP19pHx8yLtKIt3/8FAT39CIDrBWLZHYDL2ZxrCzz4r+EjZyvx+SJewSjDCzoYCl6jkgVoHULSVIJHg+5uppJLw6clhyjeNlv80Sl2+RswGjfOFdq4sJlWRZ0m9g2QBoZFQo9FkooTiDyYofeFg/3Gqq2vb4ZPlvW98kg2NjFNHCmL2grbRlBhbcEeU5xikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq9tqiVWnRasmZSWNi2vTXpVYIBefGkKN2UxqbcadDE=;
 b=KsnovDTa575t3p4DzXMAxddljXmw5iaghYJ96OEsDLEKgEUtyhTv8DwIArPqjXf5D5G+u58D32xPbdf9foOaQXntOCqCZK3nTUJ1hMYK1q/Knd79UBqhV3lw1KY2uHydFa1OoieEeQ5t+fHpm4zjmFtURGy9m5LETR3uEP7+6PbxpraxO6gQfKrPE7JOiKzKH/KU2OvT7fEUgqG/n+EQmEThXGa61qoLeY58ubSbkiYln0AwXTGQ/b6x45wUtSyYSK+oDnQgylHxbxjR3/uyLm2YgVdyFWFystmfoSISVH6gEVWK4x3HS0aIBs/wOcWtogVw9nDYGjxMf5OKdudpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq9tqiVWnRasmZSWNi2vTXpVYIBefGkKN2UxqbcadDE=;
 b=Ym8wH0xkaKLOOLIBr8artbgUCSnBXAbcF6/d9GSGiRdMzZp/K7yuWE03mHmTAn9z3HpE3KC9WE1ZtR0Bg4tyea5Y93P5RW/Sawvcd88j4kCsvKDG7w7fGXvdJ7hWbqFbiyJBrZamJhn89+jx3UW1gH7JolLhlC2S+O0YeD/R2K8=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3510.namprd15.prod.outlook.com (2603:10b6:a03:112::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 23:45:28 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 23:45:28 +0000
Subject: Re: [PATCH bpf-next 1/2] bpf: avoid verifier failure for 32bit
 pointer arithmetic
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>, <kernel-team@fb.com>
References: <20200618234631.3321026-1-yhs@fb.com>
 <20200618234631.3321118-1-yhs@fb.com>
 <93091308-0865-6bad-aa1f-3b46cbc71895@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <71c7db8e-d88c-971c-7be3-46dcd5e05a8b@fb.com>
Date:   Fri, 19 Jun 2020 16:45:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <93091308-0865-6bad-aa1f-3b46cbc71895@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1477] (2620:10d:c090:400::5:a1ad) by BY5PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:1e0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 23:45:27 +0000
X-Originating-IP: [2620:10d:c090:400::5:a1ad]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 272742fa-a2d1-4d2b-7136-08d814aad846
X-MS-TrafficTypeDiagnostic: BYAPR15MB3510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3510770DE7951EE7FB9FD0B5D3980@BYAPR15MB3510.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9itEPvgdv5jMARS41ExbcMP95utS0vkWPXJCb3Wy9UBwXtfsKpMyFs3rlurF9oB8TByQtnaCPnli9PClc4/6JMortftRKn8GarD8YI99CydEuGiF3a15rW3EqK3ZO/T2KKJGV9uMM3NsxRfiFEvKpVaDJTwz18iaF+6jJSek/pKRON1i2r7LB0hokEZUGzNdvILCGG+TYgBR5MWpphHUOVg2gDmOapfvYSJiwolRPN/o6WFHnOHagup1aivyCochS8phvjN4OXQiMPxqDejYjdJfL37H0sAOg7xbk18LtmimU8n3Nnoa+ksqQCbWgoGiIoyT6lQSWoSu1HUGHyZLcpd6AKUuN8Zz96CRJvOFR9BCyOh4ohdGBfkkLv/gFJk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(376002)(396003)(346002)(366004)(186003)(8936002)(5660300002)(86362001)(2906002)(4326008)(31696002)(53546011)(8676002)(52116002)(31686004)(16526019)(478600001)(316002)(2616005)(66946007)(66476007)(66556008)(36756003)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hpd5l1uBNN3X2Ph3+sZwPkwSoAsdfK2/rNijlvJGqAAfMCXUMjwyGMdb19TRcuqUDAgv3KlaoqllyY1V2w7QYW9Ioeqx+pG7/TWb9q8vEkvAhzNpMOc1xprOyhZeHaXk3MisD7ETIXOqDrEfl/F8ITodopzhYFCcqD6hC3oX4jD1dXPbv3eAZS4gKHmUtJ7s5hclspUW8kf6uxZAUvpkbbI+bKaafBAuwRXGk23drh0tp2Bo7vX9YMyIBUdfu/XE/Of2IW/ZvPm/RGgPDqFObcxakBL56yqsbU953ViWlKWipxwjTZGLxaPBIJsIxkRADoHKSoAt8s066AFpgD94M3knEFzdAi8bJLdbh7lEnTGAfPyVm30NK5q5xK/B4rlUMFuA20Kdj/Hew2a6sz26lFJT/v4jqSe56i8zuTijUzyL+OhqkISzFuVcuoifCaE+cX4iPwiXDoHAIrBXgqYxQQkweRg4hbT/yGIYnoKLV7uqVKsENvBdxKjKENo3On0jjMdhCyGPX6ren9o154L6yw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 272742fa-a2d1-4d2b-7136-08d814aad846
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 23:45:28.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HE4coCUIp9Tl6nepzMFM0xR0kSQoZHixWZdSYFU1AIcUEkVUswtVsBCAG2gqQKs7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3510
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxlogscore=999
 cotscore=-2147483648 spamscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190167
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/19/20 2:49 PM, Daniel Borkmann wrote:
> On 6/19/20 1:46 AM, Yonghong Song wrote:
>> When do experiments with llvm (disabling instcombine and
>> simplifyCFG), I hit the following error with test_seg6_loop.o.
>>
>>    ; R1=pkt(id=0,off=0,r=48,imm=0), R7=pkt(id=0,off=40,r=48,imm=0)
>>    w2 = w7
>>    ; R2_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>>    w2 -= w1
>>    R2 32-bit pointer arithmetic prohibited
>>
>> The corresponding source code is:
>>    uint32_t srh_off
>>    // srh and skb->data are all packet pointers
>>    srh_off = (char *)srh - (char *)(long)skb->data;
>>
>> The verifier does not support 32-bit pointer/scalar arithmetic.
>>
>> Without my llvm change, the code looks like
>>
>>    ; R3=pkt(id=0,off=40,r=48,imm=0), R8=pkt(id=0,off=0,r=48,imm=0)
>>    w3 -= w8
>>    ; R3_w=inv(id=0)
>>
>> This is explicitly allowed in verifier if both registers are
>> pointers and the opcode is BPF_SUB.
>>
>> To fix this problem, I changed the verifier to allow
>> 32-bit pointer/scaler BPF_SUB operations.
>>
>> At the source level, the issue could be workarounded with
>> inline asm or changing "uint32_t srh_off" to "uint64_t srh_off".
>> But I feel that verifier change might be the right thing to do.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> Looks good, both applied, thanks!
> 
>> ---
>>   kernel/bpf/verifier.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 22d90d47befa..bbf6d655d6ad 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5052,6 +5052,11 @@ static int adjust_ptr_min_max_vals(struct 
>> bpf_verifier_env *env,
>>       if (BPF_CLASS(insn->code) != BPF_ALU64) {
>>           /* 32-bit ALU ops on pointers produce (meaningless) scalars */
>> +        if (opcode == BPF_SUB && env->allow_ptr_leaks) {
>> +            __mark_reg_unknown(env, dst_reg);
>> +            return 0;
>> +        }
>> +
> 
> We could have also allowed ADD case while at it, but ok either way. Wrt 
> pointer
> sanitation, nothing additional seems to be needed here as we 'destroy' 
> the reg
> to fully unknown.

Right. This may happen for use case like `(w1 + off) - w2` where w1 and 
w2 are packet pointers and off is a register to encode a scalar. I will 
do a followup on this.

> 
>>           verbose(env,
>>               "R%d 32-bit pointer arithmetic prohibited\n",
>>               dst);
>>
> 
