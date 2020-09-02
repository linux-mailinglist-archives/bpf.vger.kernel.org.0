Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE6425A2F6
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 04:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIBCSV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 22:18:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22194 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBCSU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Sep 2020 22:18:20 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0822G1MG009964;
        Tue, 1 Sep 2020 19:18:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=gO3LM2738Tjzigb0VtLiBj4VoGae9OX616QKntIoAq4=;
 b=N3YAfVpA8lLX3ncWdQnmswkYYP2sG6f09m7hcO4qxzIS+2HjkBgm4eR3rwmFGMHBfiIT
 ZUkWVD3Y3JQ8FzaLZxpb8k2/3EueSvZ3KEq7mQU4G2NOMy7g+P3zqAVZdVrGArg7TJYO
 efNqz0DNFIWUEHuCwrNQnMsadoy6fjRxMa8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 338gqnd2h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Sep 2020 19:18:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Sep 2020 19:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EML6zaG1BAEh1ZFmDg8W7+yLtZywt7QZWcXqbr9HgPL9lh4VtqVnKwSoDBkDcMirMwLncWIBswvCuYXXdlv7KNptL3ctNDw5k7SG/JXx9wfp7nQGT/sU/bVIv2mnwBQafEp1BvP65VxYiEOVOToCDZhxaPW1Aaicu300afoSh/9SwRxndzop6nOxSH7+wRHB2n3m1aj034+oBncPv0xNXH/RVHRPhXWI7mm/nH7dDxULi06Jb+O3qSK/4Ay1tPDDuazN0AvAVNHtOUAPVlvKWzOhpT7gsf25HWuuw/2i3LI/9GHgKH4xKarfbqspkV4hzgpLjtw386HqzTu+jVwWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO3LM2738Tjzigb0VtLiBj4VoGae9OX616QKntIoAq4=;
 b=SS2Ls7ikoF7GiOs0NwC4trB0FpwvG951XyN5DUgicYiu8X99BBxQUFY3cWI70Kdzb6295zzeq2irqmVjzabZmrQ2Ejvk9OoILwkZIXfsHQWaYIUHvaf15dJyijt47F5UA1fcNCLVDahPg6f/1EcKmwG8eKSCs2mfe5R1CMKcKzqzmELTgiwtlUwCID05UrauBHIGDqsStlIU3AGe3iRG93dFCoxVU8F6Tgejgi9r2wE8R1MRAivQjLuXdV0vip/wJBkTBxNxzMA6etttk+lvQJ8ZJ9TkCfOtoMrOF8UImUBqciDBimUT8FxUF9gm0dGCdPPCa4WtrHgW7bs/npRk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO3LM2738Tjzigb0VtLiBj4VoGae9OX616QKntIoAq4=;
 b=DlIVsYjSTtp6nQXfHIwRGhIfEEBi+92rlhyKtLPCxXoo01o6P0PuMfFxosjydoUzur4DKEdzkdJ5zJ2GWeKu3pSvp3V07mEMKnvdww0WF1y7twB3kMRytt8nfktgUesBTGDzB4sVPdtTwtNdgq9TY8NH2c2+0LyAjsJpVjFju9o=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4120.namprd15.prod.outlook.com (2603:10b6:a02:c4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Wed, 2 Sep
 2020 02:17:59 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 02:17:59 +0000
Subject: Re: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
References: <20200825064608.2017878-1-yhs@fb.com>
 <20200825064608.2017937-1-yhs@fb.com>
 <CAEf4Bzb89dz_Sjy14LjQSDWrQ=TpSHAfgf=_Sa=bWUKGqJHCgQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <465da51a-793e-5ea0-85dc-56ab4f36ae34@fb.com>
Date:   Tue, 1 Sep 2020 19:17:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <CAEf4Bzb89dz_Sjy14LjQSDWrQ=TpSHAfgf=_Sa=bWUKGqJHCgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::15) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR06CA0002.namprd06.prod.outlook.com (2603:10b6:a03:d4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 02:17:58 +0000
X-Originating-IP: [2620:10d:c090:400::5:365a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 625ba1f7-1bf9-45d4-c50e-08d84ee66914
X-MS-TrafficTypeDiagnostic: BYAPR15MB4120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB41205FBDC54D6E1C9BCC4DD3D32F0@BYAPR15MB4120.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PyJacGVnlByI+ybz3t3uv908el6YJXTZ1J6YUkEebdN+8UYBYvu6m5JzFiKVxTLv5KEGgjPluPbRPzbnbcnFCHytET7eiIyohUZgOERgvV2+bF8aa5oPrwt/WIn7P6vfHzp4Is9cXwniWd2gbuuUreFubz7xI3++cPWrj6Eu40qYvqW6bWPsy11eexiC0S7NbhTEP6l8AuW3WDHYnIk4oHgve3h4C7qa5kfu4xlYF+1yBD4hWG53UzpXl2NqVl9hxkdN10btpk8MGe3mc2x2DZzCdegkuBARcm47ahoWJehc3P2XjE1SLHYoPdF5NI4ZSl64ZVZSAzL1Z+k9avrLZiqHH/remvPL1wwbEsLwDSFLMP/SFucPvVXR5cNoUDXb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(39860400002)(346002)(86362001)(956004)(4326008)(2616005)(36756003)(66556008)(478600001)(6486002)(66476007)(31686004)(5660300002)(16576012)(2906002)(83380400001)(8936002)(53546011)(66946007)(31696002)(52116002)(6916009)(54906003)(186003)(8676002)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QlyFn8Ati8y6RZ9eiqtAqFnt2XA2Sf5DL4OYyJaoG5fP+1xORVgpyvMsO2CAdSbxsenuZxlA6UQwmrifNY/Ua9x/qvaIcNyxrHvih0eRTOzv0akfYVVhQhZGomZpMm9v1+zIf6kPeBgPhX8op2m/tk5pmrp8TWgD9DvDcGvfz2VWcbCUnbqS89x10mkopwKDE8tHJ6LG//N65spxG+z78dW4iuC70/hOoqa/4OyshcQBU+4R+eZe5c/eG0SerLqvmvY7pmaLChUB0JjnydBpQRpy1ZOJ8unmNBD8hxTbhzN44mfKdJcK2vDrkUXDs9ZKZqZmtJvFAWYBu38PHpdQA8MjZGUhD6D0OavFX3gzlrZxtTsWHm5lRtEpiXHjQhHIoB9WFRoZOiEVBxiaR75s1W1l/dVE3aFl/bxvxMx65TjWsA6JYAUM8Vqret6lVMUKpUBJqH8a26cx3PvTl+sNLPUjXvg64WRKdltZxhw47hTptD5bUFt/yK41erTktn6W4ZgpFQ7uq0hdTwF9w5RyIqCsSnECG5xFVNOF34IGj0wC1Tm8K+WK7HMlqenFgvLNQLp21WjpM4tDykyM55d81TZ7fPG5DRcbBoxL4Yrwdd1crvAADqs0Hri1IEotl15FPhkOBVYnILcrDIt0VFnREVodr7ljf8NjZaA2txiT5ks=
X-MS-Exchange-CrossTenant-Network-Message-Id: 625ba1f7-1bf9-45d4-c50e-08d84ee66914
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 02:17:58.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJk9jQn9UDNkYVEpfJ7LRQmzRRciTjpFXgRpKV2oWyVRNSYDa7Hi0DSwWlCqiwGn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4120
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_02:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=952 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020019
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/1/20 1:07 PM, Andrii Nakryiko wrote:
> On Mon, Aug 24, 2020 at 11:47 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> bpf selftest test_progs/test_sk_assign failed with llvm 11 and llvm 12.
>> Compared to llvm 10, llvm 11 and 12 generates xor instruction which
> 
> Does this mean that some perfectly working BPF programs will now fail
> to verify on older kernels, if compiled with llvm 11 or llvm 12? If

Right.

> yes, is there something that one can do to prevent Clang from using
> xor in such situations?

The xor is generated by the combination of llvm simplifyCFG and 
instrCombine phase.

The following is a hack to prevent compiler from generating xor's.

diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c 
b/tools/testing/selftests/bpf/progs/test_sk_assi
gn.c
index 1ecd987005d2..b10ce8e9437e 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
@@ -97,15 +97,28 @@ handle_udp(struct __sk_buff *skb, struct 
bpf_sock_tuple *tuple, bool ipv4)
         __be16 dport;
         int ret;

-       tuple_len = ipv4 ? sizeof(tuple->ipv4) : sizeof(tuple->ipv6);
-       if ((void *)tuple + tuple_len > (void *)(long)skb->data_end)
-               return TC_ACT_SHOT;
+       if (ipv4) {
+               tuple_len = sizeof(tuple->ipv4);
+               if ((void *)tuple + tuple_len > (void *)(long)skb->data_end)
+                       return TC_ACT_SHOT;
+
+               sk = bpf_sk_lookup_udp(skb, tuple, tuple_len, 
BPF_F_CURRENT_NETNS, 0);
+               if (sk)
+                       goto assign;

-       sk = bpf_sk_lookup_udp(skb, tuple, tuple_len, 
BPF_F_CURRENT_NETNS, 0);
-       if (sk)
-               goto assign;
+               dport = tuple->ipv4.dport;
+       } else {
+               tuple_len = sizeof(tuple->ipv6);
+               if ((void *)tuple + tuple_len > (void *)(long)skb->data_end)
+                       return TC_ACT_SHOT;
+
+               sk = bpf_sk_lookup_udp(skb, tuple, tuple_len, 
BPF_F_CURRENT_NETNS, 0);
+               if (sk)
+                       goto assign;
+
+               dport = tuple->ipv6.dport;
+       }

-       dport = ipv4 ? tuple->ipv4.dport : tuple->ipv6.dport;
         if (dport != bpf_htons(4321))
                 return TC_ACT_OK;

@@ -129,18 +142,34 @@ handle_tcp(struct __sk_buff *skb, struct 
bpf_sock_tuple *tuple, bool ipv4)
         __be16 dport;
         int ret;

-       tuple_len = ipv4 ? sizeof(tuple->ipv4) : sizeof(tuple->ipv6);
-       if ((void *)tuple + tuple_len > (void *)(long)skb->data_end)
-               return TC_ACT_SHOT;
+       if (ipv4) {
+               tuple_len = sizeof(tuple->ipv4);
+               if ((void *)tuple + tuple_len > (void *)(long)skb->data_end)
+                       return TC_ACT_SHOT;

-       sk = bpf_skc_lookup_tcp(skb, tuple, tuple_len, 
BPF_F_CURRENT_NETNS, 0);
-       if (sk) {
-               if (sk->state != BPF_TCP_LISTEN)
-                       goto assign;
-               bpf_sk_release(sk);
+               sk = bpf_skc_lookup_tcp(skb, tuple, tuple_len, 
BPF_F_CURRENT_NETNS, 0);
+               if (sk) {
+                       if (sk->state != BPF_TCP_LISTEN)
+                               goto assign;
+                       bpf_sk_release(sk);
+               }
+
+               dport = tuple->ipv4.dport;
+       } else {
+               tuple_len = sizeof(tuple->ipv6);
+               if ((void *)tuple + tuple_len > (void *)(long)skb->data_end)
+                       return TC_ACT_SHOT;
+
+               sk = bpf_skc_lookup_tcp(skb, tuple, tuple_len, 
BPF_F_CURRENT_NETNS, 0);
+               if (sk) {
+                       if (sk->state != BPF_TCP_LISTEN)
+                               goto assign;
+                       bpf_sk_release(sk);
+               }
+
+               dport = tuple->ipv6.dport;
         }

-       dport = ipv4 ? tuple->ipv4.dport : tuple->ipv6.dport;
         if (dport != bpf_htons(4321))
                 return TC_ACT_OK;


The fundamental idea is the following. If you have code like
     if (cond) { BLOCK1; } else { BLOCK2; }
     BLOCK3;
     if (cond) { BLOCK4; } else { BLOCK5; }
change the source code to
     if (cond) { BLOCK1; BLOCK3; BLOCK4; }
     else { BLOCK2; BLOCK3; BLOCK4; }

If the condition is used in two different places, the compiler
might do some transformation for control flow and later on
instr simplification decides to use xor in certain cases.

The new code has some code duplication. Not sure whether
we should refactor the code or just add some note to selftests
README.rst to describe this particular failure.

> 
>> is not handled properly in verifier. The following illustrates the
>> problem:
>>
>>    16: (b4) w5 = 0
>>    17: ... R5_w=inv0 ...
>>    ...
>>    132: (a4) w5 ^= 1
>>    133: ... R5_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>>    ...
>>    37: (bc) w8 = w5
>>    38: ... R5=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>>            R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>>    ...
>>    41: (bc) w3 = w8
>>    42: ... R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>>    45: (56) if w3 != 0x0 goto pc+1
>>     ... R3_w=inv0 ...
>>    46: (b7) r1 = 34
>>    47: R1_w=inv34 R7=pkt(id=0,off=26,r=38,imm=0)
>>    47: (0f) r7 += r1
>>    48: R1_w=invP34 R3_w=inv0 R7_w=pkt(id=0,off=60,r=38,imm=0)
>>    48: (b4) w9 = 0
>>    49: R1_w=invP34 R3_w=inv0 R7_w=pkt(id=0,off=60,r=38,imm=0)
>>    49: (69) r1 = *(u16 *)(r7 +0)
>>    invalid access to packet, off=60 size=2, R7(id=0,off=60,r=38)
>>    R7 offset is outside of the packet
>>
>> At above insn 132, w5 = 0, but after w5 ^= 1, we give a really conservative
>> value of w5. At insn 45, in reality the condition should be always false.
>> But due to conservative value for w3, the verifier evaluates it could be
>> true and this later leads to verifier failure complaining potential
>> packet out-of-bound access.
>>
>> This patch implemented proper XOR support in verifier.
>> In the above example, we have:
>>    132: R5=invP0
>>    132: (a4) w5 ^= 1
>>    133: R5_w=invP1
>>    ...
>>    37: (bc) w8 = w5
>>    ...
>>    41: (bc) w3 = w8
>>    42: R3_w=invP1
>>    ...
>>    45: (56) if w3 != 0x0 goto pc+1
>>    47: R3_w=invP1
>>    ...
>>    processed 353 insns ...
>> and the verifier can verify the program successfully.
>>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>
> 
> [...]
> 
