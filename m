Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5CD2E7C19
	for <lists+bpf@lfdr.de>; Wed, 30 Dec 2020 20:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgL3TPH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Dec 2020 14:15:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726499AbgL3TPG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Dec 2020 14:15:06 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BUJ8ELu031236;
        Wed, 30 Dec 2020 11:14:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6TCAS2SUKHR4qmdEKDt0x2PtJgnwQqlP83Q0uCt6I2c=;
 b=hDRILDv6NPk7HyHYOVjlLp+msTQEwE7ZV+QVOn2Z6jYeKNOt9En/0Iof+3jssNXBHupE
 G1HupIpQs59cL00gW5SSLqfhRhn1aZCzTBCLJ+Kx5VYE5+Bm1uj6X5DCNhEHktbTS8D0
 r5sxC6x2RzTw72gleh6nVtwVdUSszwD5p+Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 35p1qtq9ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Dec 2020 11:14:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Dec 2020 11:14:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kw2DyjRHd2Od5nn3NxODKyZ64ZhFFo8Q5QESMIDJJLiJlyNUANCqjK/XJfIiQAkiIcDgWsknjgyxOTpENZHinmt++c/74jtiuLOrEEDiLR3f0P4WUcvThTCqUSz1Irnc4dx4s3OOxLfxhYLMi6Fftv1QWgYKVklah75TX2Z/vT1ZccBe1wHadUXO+GiJmnR4tWV+h0EEXfGbEwfvcretebmpWYQgOvVFKXpTl1ios3szyJae+t/UTW3zSMtyC5wV9D8nwnUgTHUJhpAFinAwnvwq/QQFiP4t3FmyMzDTOq6Xh3ZA8ZvxuMuUM/RCVTMqczPNT5gV4tV4ePhrQgBAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TCAS2SUKHR4qmdEKDt0x2PtJgnwQqlP83Q0uCt6I2c=;
 b=YKwSo5NKryHtfD43LRw23z/BQQ7dRXGdJcmY1vZ5OnNsnDf/3J9FeGhsvn+hMeH1e2887Gyv6nMNi/4DaKu5QWdq0V0AuAX6KCikHVXhRBxdfOVnYv5xfzvKKOLA59+oAa1YzovRWP3jPQzbTAElzDpzG8s9QJ2p/UohjW0zxCLHATjJQhkQlSphZ3aQPAEI5hsARHMlDrosndI7CKR7L3/4LXOBdWQYfqJwxHQ0+ANPzHKkdgt4PqsWGzOxOcVJQHw4edtzpKcDkhU1PItoRDsSdXWVstWoQl+GdjikTVlKbzWZBaXZEOegVnRmSD6br/oO0p5hMem7sW0jGybxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TCAS2SUKHR4qmdEKDt0x2PtJgnwQqlP83Q0uCt6I2c=;
 b=F5GskeL8UAoxbB6QskRnvGTXJRHXCdki9qWcR3Az49Ec+ZM2rjv5HXGNpmwwgaeLlqN/NRdS9AZUZ8Q9+KBouGxaf8nrq9NvhJrc7Cq6eqTu+EXrfJT/tT45n8S0zI9+SaMaiZjiK4n1urct4NbtBsDWBjINN6wE/V00zREQAK0=
Authentication-Results: thaumogen.net; dkim=none (message not signed)
 header.d=none;thaumogen.net; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2374.namprd15.prod.outlook.com (2603:10b6:a02:8b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Wed, 30 Dec
 2020 19:14:19 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 19:14:19 +0000
Subject: Re: verifier rejects program under O2, works under O3
To:     Andrei Matei <andreimatei1@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Raphael 'Kena' Poss <knz@thaumogen.net>
References: <CABWLseseugQxOXj5PDOsZ+nvadPfY_Uvt6wZaOpqjyBBXA+WRQ@mail.gmail.com>
 <5fe23c6f56a18_838a20825@john-XPS-13-9370.notmuch>
 <CABWLsetVRaCo8GqvwDaTFxpn2DzaxmxYBXtEc2Awk_5myC7Rqg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <581108f4-d541-7f50-ef51-14c397e8fef3@fb.com>
Date:   Wed, 30 Dec 2020 11:14:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
In-Reply-To: <CABWLsetVRaCo8GqvwDaTFxpn2DzaxmxYBXtEc2Awk_5myC7Rqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:c584]
X-ClientProxiedBy: BYAPR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::41) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1231] (2620:10d:c090:400::5:c584) by BYAPR06CA0064.namprd06.prod.outlook.com (2603:10b6:a03:14b::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend Transport; Wed, 30 Dec 2020 19:14:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a55333bf-419d-4685-e763-08d8acf71be9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2374:
X-Microsoft-Antispam-PRVS: <BYAPR15MB237486114C2BBC246AC0F89BD3D70@BYAPR15MB2374.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0Ot/rQ5ZvOVAYTsYPg22XKV5DmDG7wIWdwiXGOUZF4mGAnDWV/pn81V6MUqhT/WE2yHHAdUDTx4XgGA4CtQew0/rd1EWDbKxw7DlvQTsYnBsdETOpgkBy8k6rnY2eaqGWnU0CXqjFBax9DjtNyxFslv9++o9HiI4BPy4dV7aoct88e2803xPCuUMYUOLN60c7B8zYcsUDHbj8NYggOF/m0TqaTHAKTwQBo7jM715f1y5XfxJ7I0DreltYb4u1PXtzH3oPKaJOGPy7j5YhSoNnUQge6hh4gIfDFtykolC190MFDIfkNPe5Tq9ASVTVdsv7stgOOw6JGTm4leYolcwbSy/0dega4H9yRcOLmDwVWjx+ghtHqN5jOQ1NnknAKSH+A45/jq3xHPzppuo3RG1xC8gKhPB9CW1sS2dXI8SAY/W1tOYepQ/vb9Ho3gPckvJBcXe2HCpo2D9xQ3BG1uyKDnyxxWRGNnT6uCt2TeOZN/+z+Q583Y2LoBhrrpROQcNdB+Suu5hLJzCCjhYeH/Ik7ciAE4Qr8cdz7nH3eoA0SIEslCwHEh92FSwuBUek1v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(396003)(366004)(5660300002)(66946007)(8936002)(110136005)(8676002)(966005)(30864003)(53546011)(2906002)(316002)(2616005)(478600001)(52116002)(4326008)(66556008)(186003)(16526019)(6486002)(83380400001)(31686004)(66476007)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?emw4R3FnSWxmTE1obXFWZThQVnlwRVh1R1E3K3hVSEJoalBoNFBHU1ZFaWZO?=
 =?utf-8?B?Q0UrZFNPdEdZL3M4RUFHakk3d2IvWlBMV2JTRTVDdEhQN2FVWUx1amw0YXJl?=
 =?utf-8?B?V2NNWjRaVVJnK1hkR2l4YWZiOVhnSVRqQ3ZMQ3JuMmFvR0F6YzlZeC9sUDZx?=
 =?utf-8?B?OHVkRmdobUs0dzE0UHFWUjlHZ1BkV1hocStrRU1sWUd2S3Q4bGNuZFJEYThD?=
 =?utf-8?B?dG9rUTEra2ZWNjRiUHppVDZlS00zeHpqNVJ2RzBZT2l2ZkVVNERhc3dGdW5Q?=
 =?utf-8?B?VERlbFBWWTh4ZGY2WHY0NlMwTk1HNzhpWUdXQ2ZydTNFd1FOMkJ3cVZIK3Q5?=
 =?utf-8?B?RmZjQTdBSlJhVmZYZ1dRSHhYU3JUemRHNzRUek9OU0Zhc2d0YjQ1QlNqcHN3?=
 =?utf-8?B?bi9HbnFIQW1ya1BoUzBaeFo0QXFuT2VRd0R0VnJZMUVYdFQ1cFhDakpJZFZG?=
 =?utf-8?B?TkpzaWFsSXJneXJWeTBObFBySUVBNkNzaFlBWnNLWTErOFJTdzYrMEVPbmtJ?=
 =?utf-8?B?TVdQNHVkYkVlU3BQZENhYWErVWY4RTRCZzFhUEVhd29lU1V5ZWdRQlZTOVdl?=
 =?utf-8?B?WjZ0SEltdTVUb2EyYTM5UmRxUDc1NXcraTB0aytzeVhjcXJFWGQycnYzTGhJ?=
 =?utf-8?B?S2RQM1dsVGxEdXVkSFdydHJCcjgxaHdnaGg0ZVBnYUlNQk5WSmk3RVFPMmd6?=
 =?utf-8?B?U2xSTGdFak1XeFJwTTZ4cjRzckdjSVpRTEtORS9sbklkQ0d2ckpaeklxZFd4?=
 =?utf-8?B?ZDhtZytzbURxQTBDQ1JYTlIxajVwT1hsaEhqNzVyMDhBWjllb1RYbFBuS2xC?=
 =?utf-8?B?Zllib2wzV3BaSFBJMUdBVEt6R0EycG52WXFPcnR2UUdhN1JUYU8xSWUxYmFq?=
 =?utf-8?B?OG14dy9pRi81VkU0bmprQkxrcG11QU9aaTN6d280eWJrVGRVT25SU2xiWFVw?=
 =?utf-8?B?elJoWXlUNmJ6eFdFcFB0T1dJMy9Wall3QjlIV3ZzcFJndXlma2NoWi9PZzNa?=
 =?utf-8?B?ZlBKdTV2OTZmdEF2Wko0VVB1eFNISy9MdXdOemR0R1RxenNjeE9DcXlIcllj?=
 =?utf-8?B?dTI5NzFZSmlkZE1UZFZ6UmdUZG5CekFhZ0JOZUFXNkhERlZZeHRsSDB6UElJ?=
 =?utf-8?B?dWt0MWI1MWdFakEyRytRS1VXT0t5cWd3cFFkTnNDaFdtZkpKZkxrbXJyOVVI?=
 =?utf-8?B?RzB0S3V5SENYNDVJM2hORVVuK0s1R2s3Zk5lWW8zbVBXeCtHREtaM25HZEp6?=
 =?utf-8?B?TmZOdW9uNTNwRWJldzRVMGZCVmFhVEo1bGN1NHIrcjRwVDV0bVl6ZVNlSmND?=
 =?utf-8?B?N0RJQURtaDFvZXdUOGVscFZhTkhkYmh0T01wRm5lK3IwaktBaVRUbTBJeXZQ?=
 =?utf-8?B?SEwvVDJIRXR0N1E9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2020 19:14:19.6549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: a55333bf-419d-4685-e763-08d8acf71be9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCKI4soHd/vOEEw5+cBrDAHFcwzRwyyQy3qCLjSvcXGwrIIKsf0HGNxOu5jKfJJB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2374
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-30_12:2020-12-30,2020-12-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012300118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/22/20 2:19 PM, Andrei Matei wrote:
> OK, I've stared at the assembly for a while and believe I now
> understand what's going on. I think the issue is that the verifier
> does not "back-propagate" boundaries at the sub-register level, and
> this causes it to miss opportunities to later have proper bounds on
> other registers. I'm making assumptions about what the verifier does
> and doesn't do, but here's what I see. To clarify, I'm not looking for
> suggestions about how to get my code to load (I believe I understand
> how to do that), but I want to see if there's an opportunity to
> improve the verifier.
> 
> First, my abridged code in order to get some sympathy, as it seems
> like it should work.
> 
> const unsigned int ip = p->ip;
> unsigned char* instr = p->instr;
> if (ip >= (PROG_MAX_INSTR - 2)) { return 189; }
> long immediate;
> unsigned char ins = instr[ip];
> ...
> immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.
> 
> The verifier claims that `ip + 1` is unbounded, but it is bounded
> because of the `if (ip >= (PROG_MAX_INSTR - 2)` part. But, alas, there
> are different types at play here. `ip` and `p->ip` are ints (32bit),
> so they don't always occupy full registers.
> Now the relevant -O2 assembly, with my commentary.
> 
> ; CHECK_PROG(prog);
> 124: (61) r2 = *(u32 *)(r6 +0)
>   frame1: R0_w=invP(id=0) R1_w=invP0
> R3_w=map_value(id=0,off=72,ks=4,vs=272,imm=0) R4_w=invP10
> R6_w=map_value(id=0,off=24,ks=4,vs=272,imm=0) R7_w=fp-40 R10=fp0
> fp-8=??????mm fp-16_w=mmmmmmmm fp-24_w=mmmmmmmm fp-32_w=fp
> 
> # ^- r2 starts here as an unbounded value. I'm surprised I don't  see
> it listed in this frame1; is that expected? In any case, we'll see it
> listed later.
> 
> 125: (05) goto pc+46
> ; CHECK_PROG(prog);
> 172: (bf) r0 = r2
> 173: (67) r0 <<= 32
> 174: (77) r0 >>= 32
> ;
> 175: (b7) r9 = 1
> ; CHECK_PROG(prog);
> 176: (25) if r0 > 0x9 goto pc+36
>   frame1: R0_w=invP(id=0,umax_value=9,var_off=(0x0; 0xf)) R1=invP0
> R2=invP(id=3,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> R3=map_value(id=0,off=72,ks=4,vs=272,imm=0) R4=invP10
> R6=map_value(id=0,off=24,ks=4,vs=272,imm=0) R7=fp-40 R9_w=invP1
> R10=fp0 fp-8=??????mm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=fp
> 
> # ^- notice how we copied r0 = r2, zero'ed out r0's high-order bits,
> and then put a bound on r0. And note how R2 is now listed as
> unbounded. An opportunity was seemingly lost here - we have some
> information about R2, which could save me later.
> 
> (omitted some irrelevant assembly)
> 
> 180: (bf) r0 = r2
> 181: (67) r0 <<= 32
> 182: (77) r0 >>= 32
> ; if (ip >= (PROG_MAX_INSTR - 2)) { return 189; }
> 183: (25) if r0 > 0x7 goto pc+29
>   frame1: R0=invP(id=0,umax_value=7,var_off=(0x0; 0x7)) R1=invP0
> R2=invP(id=3,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> R3=map_value(id=0,off=72,ks=4,vs=272,imm=0) R4=invP10
> R5=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> R6=map_value(id=0,off=24,ks=4,vs=272,imm=0) R7=fp-40 R9=invP189
> R10=fp0 fp-8=??????mm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=fp
> ; unsigned char ins = instr[ip];
> 
> # ^- same dance as before; we copy r2 to r0 and put a bound on r0
> 
> (omitted)
> 
> ; immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.
> 194: (bf) r9 = r2
> 195: (07) r9 += 1
> ; immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.
> 196: (67) r9 <<= 32
> 197: (77) r9 >>= 32
> 198: (bf) r8 = r6
> 199: (0f) r8 += r9
> 200: (71) r8 = *(u8 *)(r8 +4)
>   frame1: R0=invP0 R1=invP0
> R2=invP(id=3,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> R3=map_value(id=0,off=72,ks=4,vs=272,imm=0) R4=invP10
> R5=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> R6=map_value(id=0,off=24,ks=4,vs=272,imm=0) R7=fp-40
> R8_w=map_value(id=0,off=24,ks=4,vs=272,umax_value=4294967295,var_off=(0x0;
> 0xffffffff)) R9_w=invP(id=0,umax_value=4294967295,var_off=(0x0;
> 0xffffffff)) R10=fp0 fp-8=??????mm fp-16=mmmmmmmm fp-24=mmmmmmmm
> fp-32=fp
> R8 unbounded memory access, make sure to bounds check any such access
> processed 112 insns (limit 1000000) max_states_per_insn 0 total_states
> 8 peak_states 8 mark_read 2
> 
> # ^- here at the end we copy r2 to r9, do similar zeroing, and then
> use r9 in the failing load: r8 = *(u8 *)(r6 + r9 +4). Since r2 and r9
> are not bound, it doesn't work.
> 
> I'm thinking that, *if* we would have kept a bound on the lower 32
> bits of r2, and *if* we would have propagated that bound to the lower
> bits of r9, *and if* we would have inferred from `r9 >>= 32` that the
> higher bits of r9 are 0, then it would have all gloriously worked out
> for the memory access. Does that seem feasible at all?
> A side question - does the verifier handle simpler cases like:
> r2 = r1
> if r2 > 10 goto ...
> At this point, is there a limit on r1 (besides the limit on r2)?

Latest bpf-next/bpf should have implemented copied register tracking,
see
     75748837b7e5 ("bpf: Propagate scalar ranges through register 
assignments.")
     e688c3db7ca6 ("bpf: Fix register equivalence tracking")

With the above verifier fix, r1 should inherit value range of r2.
> 
> I also have a more general question: are situations like this, where
> something works with some level of optimizations but not others,
> automatically a cause of concern for the verifier? Does the verifier
> aim to be smart enough to be fairly resilient to clang optimizations,
> or is that a lost cause?

verifier tries to improve itself independent of clang optimizations.
clang transformation could be different between different opt levels,
between different releases, etc. So yes, verifier tries to cover
*enough* code patterns generated by different clang releases, different
opt levels.

> 
> Thank you!
> 
> On Tue, Dec 22, 2020 at 1:35 PM John Fastabend <john.fastabend@gmail.com> wrote:
>>
>> Andrei Matei wrote:
>>> Hello friends,
>>>
>>> I've run into an issue on my first BPF program of non-trivial size.
>>> The verifier rejects a program that, I believe, it "should" accept.
>>> Even more interesting than the rejection is the fact that the program
>>> is accepted when compiling with clang -03 instead of the original -02.
>>> Also interesting is that, in the -O2 case, a simple change that should
>>> be equivalent from at the C semantics level also makes it work.
>>
>> [...]
>>
>>> See build instructions at the bottom.
>>>
>>> The tail of its logs below. The full logs are here:
>>> https://gist.github.com/andreimatei/2242c5f6455a12e6c1ff5d76fd577a69
>>>
>>
>> Would help to see a bit more logs here so we know where r2 came
>> from.
>>
>>> ; immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.
>>> 194: (bf) r9 = r2
>>> 195: (07) r9 += 1
>>> ; immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.
>>> 196: (67) r9 <<= 32
>>> 197: (77) r9 >>= 32
>>> 198: (bf) r8 = r6
>>> 199: (0f) r8 += r9
>>> 200: (71) r8 = *(u8 *)(r8 +4)
>>>   frame1: R0=invP0 R1=invP0
>>> R2=invP(id=3,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>>
>> boounds on r2 are effectively any 32bit value here, so shifting
>> bits around after assigning to r9 doesn't do anything.
>>
>>> R3=map_value(id=0,off=72,ks=4,vs=272,imm=0) R4=invP10
>>> R5=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>>> R6=map_value(id=0,off=24,ks=4,vs=272,imm=0) R7=fp-40
>>> R8_w=map_value(id=0,off=24,ks=4,vs=272,umax_value=4294967295,var_off=(0x0;
>>> 0xffffffff)) R9_w=invP(id=0,umax_value=4294967295,var_off=(0x0;
>>> 0xffffffff)) R10=fp0 fp-8=??????mm fp-16=mmmmmmmm fp-24=mmmmmmmm
>>> fp-32=fp
>>> R8 unbounded memory access, make sure to bounds check any such access
>>> processed 112 insns (limit 1000000) max_states_per_insn 0 total_states
>>> 8 peak_states 8 mark_read 2
>>
>> This happens because R9 is bounded only with umax_falue=0xffffFFFF
>> and 'r8 += r9' means r8 is the same. So verifier is right, not a valid
>> access from above snippet.
>>
>> You need to walk back r2 and see why its not bounded. Either its
>> not bounded in your code or verifier lost it somewhere. Its
>> perhaps an interesting case if the verifier lost the bounds so we
>> can track it better.
>>
>> [...]
>>
>>> Again, this works under -O3. It also works if I change the line
>>> immediate = instr[ip+1];
>>
>> Posting relevant block of code inline the email that is passing with
>> -O3 would perhaps be helpful. I guess its just chance moving of
>> registers around and unlikely that useful though.
>>
>>> to
>>> immediate = *(instr + ip + 1);
>>>
>>> So, if I do the pointer arithmetic by hand, it works.
>>>
>>> I've analyzed the assembly being produced in a couple of cases, and
>>> have a (likely random) observation. In both of the cases that work
>>> (i.e. -O3 and manual pointer arithmetic), the line in question ends up
>>> compiling to a load that uses register as the source address, and a
>>> *different* register as the destination. In the case that doesn't
>>> work, the same register is used. This is a long shot, but - is it
>>> possible that the verifier gets confused when a register is
>>> overwritten like this?
>>> The assembly output (clang -S) can be found here:
>>> https://github.com/andreimatei/bpfdwarf/tree/verifier-O2-O3/assembly
>>> 1) the original program (accessing instr as an array), compiled with -O2 (fails)
>>> 2) the original program (accessing instr as an array), compiled with
>>> -O3 (succeeds)
>>> 3) the modified program, accessing instr as a pointer, compiled with
>>> -O2 (succeeds)
>>
>> Best to just inline the relevant blocks. Sorry don't really have time
>> to dig through that asm to find relevant snippets for 03/02 etc.
>>
>> [...]
>>
>>> I also have another random observation: in all the versions of the
>>> assembly listed above, there's a pattern for clearing the high-order
>>> bits of a word, happening around the variable used to index into the
>>> offset:
>>> r9 <<= 32
>>> r9 >>= 32
>>> These instructions are there, I believe, in order to get the right
>>> addition overflow behavior in the 32bit domain. I'm thinking there's a
>>> chance that this has something to do with the verifier sometimes
>>> losing track of some register bounds (although, again, the pattern
>>> appears even when the program loads fine). I say this because another
>>> way I've gotten my program to work is by changing the index variable
>>> to be a 64bit type.
>>
>> Its zero'ing upper bits because its an int in C code. Try compiling
>> with alu32 enabled and a lot of that will go away. Likely your
>> program will not hit the above verifier warning either is my guess.
>>
>> Add --mcpu=v3 to your LLC_FLAGS.
>>
>> Alternatively you can change some of those ints to 64bit types so
>> compiler doesn't believe it needs to zero upper bits.
>>
>> .John
