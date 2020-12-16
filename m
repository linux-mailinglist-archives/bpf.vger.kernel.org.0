Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493872DC313
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 16:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgLPP1D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 10:27:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44424 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726471AbgLPP1D (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Dec 2020 10:27:03 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BGFLmc2015812;
        Wed, 16 Dec 2020 07:26:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=pS7pVrELQqzBsqXA5GBuJ/szDCjaLr7j1rvrAi8B3uY=;
 b=HQ8yprt2neh0PG25ty8LMVd7T9aN58lmLEsWt1sDj2rr7yhQQK84Hd08WYDsjDwhYkfp
 g9akkrUvdM1WgZjAxYsP0MTCg5t9MY1/b8PhEXG2tA3nl11M+jKdX0lEejPtDN8+F1bU
 x9k/r8IBU6d27HO1YgcyxLd+j/OdwnGz+EY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35f9ykam2m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Dec 2020 07:26:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 07:26:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddt8jE8WMru5kon9Qu3XBS+Hh1tYqOxegf+RMEwuCUV42L4NJMC4VDJo7FJx/mKM7fSufxBY13yrQOZtlLTLwQxYkEYSE1IEYk3VXCLNwm5qLZbAHy9uaepgpsKUwGXhpDoeK5KrJ0Yca6Jc5S6p3bRFo15VeCCDycGgbCD8GUcDht55dXKWhTX8OubiA3/pO8t3/z/7ey6tUjAD8oFwLjRfU+PZaUjxWjCklCCpRUjN9EsBxynKkindurVJ0GCEAqhLthv1G64RLxvGwizhli9/hxgnO0tAyH27hpn/OEb7Fgq9YspSn7Dhli7AGo6DyAXcXLEiczIaJRfe9XCCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS7pVrELQqzBsqXA5GBuJ/szDCjaLr7j1rvrAi8B3uY=;
 b=anwEIAtyp7jGDtyTUfzxwgJWsbKV5wRHREAy3K7jIjEf2qZhit5x/ZPB7hDGCPTtGo9mfTklXTKA3WJ5czFriCX4fO0sceneEsXNZ0TTcTMQ1cNcCasvYtnz8B3Zzq+carP6a1eX1gjpGpB4nnHIohcpimVMBFw3lflsjiaGfTq8NYOOSo8D0960uW5uOkA5SyBQypAFuthEEWTT0H+tNPQLFWADcQLtod+ZTq083ZsSV8IPIRtBlCXZq/AMZegsHZCP+Rs9740d+6Pe+CDlUraHUypxPv7yfCSva7RU1PuijdtoTr5riFHxXwpLQjHOPIehKeed4ZnEw4s59K2bFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS7pVrELQqzBsqXA5GBuJ/szDCjaLr7j1rvrAi8B3uY=;
 b=OAGLCSg3AMdK4b85J/B2OW17NOPAfRpxE46vrTURnIr2FYd/4y8+aRblXuiDWDhC17bpR2zNAN5oxJajDaueh23wKlPQ8rTUsTZCP/UOHiG4Hwod2TW4QsDbzrJ4G4vOYrcuKQUTrZIQY3GuBNClG1y5A4CKKn+L4aSlJeSj3sA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2246.namprd15.prod.outlook.com (2603:10b6:a02:8d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Wed, 16 Dec
 2020 15:26:01 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 15:26:01 +0000
Subject: Re: [PATCH bpf-next v5 11/11] bpf: Document new atomic instructions
To:     Brendan Jackman <jackmanb@google.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20201215121816.1048557-1-jackmanb@google.com>
 <20201215121816.1048557-13-jackmanb@google.com>
 <fcb9335c-000c-0097-7a70-983de271a3b7@fb.com>
 <CA+i-1C2ddNES0DXoO1L_nrqpK5EtA9xKE1yRGrqSVv0dECZozQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c8496a00-65d9-5231-d806-5b402c7fb3cf@fb.com>
Date:   Wed, 16 Dec 2020 07:25:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <CA+i-1C2ddNES0DXoO1L_nrqpK5EtA9xKE1yRGrqSVv0dECZozQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4fea]
X-ClientProxiedBy: MW4PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:303:8c::21) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::12e6] (2620:10d:c090:400::5:4fea) by MW4PR03CA0136.namprd03.prod.outlook.com (2603:10b6:303:8c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 16 Dec 2020 15:26:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a4c04b6-fff1-488e-46ef-08d8a1d6e58a
X-MS-TrafficTypeDiagnostic: BYAPR15MB2246:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22460BEA0BF419EB9B174313D3C50@BYAPR15MB2246.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBo36Rp77fw2rJ0kUbC6ApPxyaXfc7upsHzS01vQk512o8aeUfl6I4749fsnPlDlSSHI63Cz/r6qLcGPFYy7AfxyZLd+smPTFkN0e92Jr4w5tfwHsFZes4x88CklO+0knEBmjwbMQW1Lw+DQW3xeQW5f3eaxIIwZEQEnzZwPZur0jZBkGHrFPtxybq5uMdAGkxyUUy+yAFrujFMI15J7LXhJ1xR7fd5TN7zJiAlQMMRTCg5wxFU7xIBE0JXrJRXA47Ec94+WEni1dB3DDco40x9T2AqtA3/s9YbE/LkKqhezEh6+83OqWUZ0+g4JNEMk4F11cjM8Furon3mr+MYpBXXXxyDP8+u+zvYUjmzXeP4rGITqD/wgLnYRgTZcfQv+YnlROabyGOHPDhy3YvjEEstlZ3XBx53vSW5XX6llYsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39860400002)(396003)(366004)(316002)(5660300002)(54906003)(186003)(478600001)(36756003)(83380400001)(31686004)(6916009)(52116002)(86362001)(2616005)(66946007)(8676002)(2906002)(66476007)(4326008)(6486002)(66556008)(8936002)(53546011)(16526019)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: r4Wr97y0CDFW+TPH0aoZfCKA+/8WC2qkj/uEHcA7y3GqNMZsQuGwwKINnxXmN+51v1qUAYXrQ102UvhgGZNfqYbqFeCJbALW/cSqugLa/MaaR2cJKHnmjqMx0yaDT13vF/jOttbli2fXJoAN87Z0fFkPRQ0RnzqhkK03B5Rz4Qolobd3HQfmJFYhNYiEDkkJ+OAG7dITE0wP15FVvw4jnNrdRWw4bNN3chhz3SPKMCaINJHOjg84diOGtSkhZCSkCvvg+XUPNLiqSXv7pPIjKNB0r1ECTClW8ip74py5RWlf1ap9nIlNqTP/i7+klMlISOy6B+/xq4wReZqLuCFvbGzh86vYUrIPLaNPFdsW2K3EmWQ1OaRfIG60Hj5zMQLucBYuSVuCi6tH68hUEC+VsictlL/P0PhUoBn3BShIYLmnRxtjb7AXRhP4SguQ8ol3KHV/G4CLoV9teKmjZNX8IJndJ+8r3wPx2C1f1AMxaOVeKWO4DTq1Rjvco69gcy9AI5sgveNIa4zsearEig7EJj78IyjKxXwkrn0C6I7eX86iGxMAwKJUE5JF0OsgTDgWEBZ9hRb47L1cMkli00mpaobBeOyp7RB6jt0shgmRjzHM7A6lz+a1YNHcCfHPPdVcpU97yVNthi12tLNqczcw1QJknhUNIaSLHcm2xXSEydaFodvgMNqqdFD+oq34BUWpxBglhKqCnQzlT84HCK0WjnO57+DaRj5WcE8hosJDU0MNO/cPkWmkbo+F7aUxNVYTBOxCL4lNg1bQrBNkDi58pwJ2MQb2Itca82yaPjYmYx8=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 15:26:01.7603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4c04b6-fff1-488e-46ef-08d8a1d6e58a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWUqcQIfBoyGIn+djES6idvdvrq/oiGzts/6zEqAW8T84nIoMt6wBI24GhyVwdDP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2246
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_06:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/16/20 3:44 AM, Brendan Jackman wrote:
> On Wed, 16 Dec 2020 at 08:08, Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 12/15/20 4:18 AM, Brendan Jackman wrote:
>>> Document new atomic instructions.
>>>
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>
>> Ack with minor comments below.
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
>>
>>> ---
>>>    Documentation/networking/filter.rst | 26 ++++++++++++++++++++++++++
>>>    1 file changed, 26 insertions(+)
>>>
>>> diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
>>> index 1583d59d806d..26d508a5e038 100644
>>> --- a/Documentation/networking/filter.rst
>>> +++ b/Documentation/networking/filter.rst
>>> @@ -1053,6 +1053,32 @@ encoding.
>>>       .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
>>>       .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
>>>
>>> +The basic atomic operations supported (from architecture v4 onwards) are:
>>
>> Remove "(from architecture v4 onwards)".
> 
> Oops, thanks.
> 
>>> +
>>> +    BPF_ADD
>>> +    BPF_AND
>>> +    BPF_OR
>>> +    BPF_XOR
>>> +
>>> +Each having equivalent semantics with the ``BPF_ADD`` example, that is: the
>>> +memory location addresed by ``dst_reg + off`` is atomically modified, with
>>> +``src_reg`` as the other operand. If the ``BPF_FETCH`` flag is set in the
>>> +immediate, then these operations also overwrite ``src_reg`` with the
>>> +value that was in memory before it was modified.
>>> +
>>> +The more special operations are:
>>> +
>>> +    BPF_XCHG
>>> +
>>> +This atomically exchanges ``src_reg`` with the value addressed by ``dst_reg +
>>> +off``.
>>> +
>>> +    BPF_CMPXCHG
>>> +
>>> +This atomically compares the value addressed by ``dst_reg + off`` with
>>> +``R0``. If they match it is replaced with ``src_reg``, The value that was there
>>> +before is loaded back to ``R0``.
>>> +
>>>    Note that 1 and 2 byte atomic operations are not supported.
>>
>> Adding something like below.
>>
>> Except xadd for legacy reason, all other 4 byte atomic operations
>> require alu32 mode.
>> The alu32 mode can be enabled with clang flags "-Xclang -target-feature
>> -Xclang +alu32" or "-mcpu=v3". The cpu version 3 has alu32 mode on by
>> default.
> 
> Thanks, I've written it as:
> 
> Except ``BPF_ADD`` _without_ ``BPF_FETCH`` (for legacy reasons), all 4
> byte atomic operations require alu32 mode. Clang enables this mode by
> default in architecture v3 (``-mcpu=v3``). For older versions it can
> be enabled with ``-Xclang -target-feature -Xclang +alu32``.

Sounds good. thanks!

> 
>>>
>>>    You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
>>>
