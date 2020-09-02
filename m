Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C9325A522
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 07:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBFn1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 01:43:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46632 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBFnZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Sep 2020 01:43:25 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0825eDlf019167;
        Tue, 1 Sep 2020 22:43:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mv9/5zP90n3982T1gsbcCbw+FKmZu8ntnNHCmt0RcdM=;
 b=oV3iHxFnLjjKmo7d8XtZDqBotG/5JZE+QYzd4QR5YYGXumJG9JuTiQhVRCVuMfTglcTG
 msoXE8PLsdeRSf5AD9f+asdN3ZzmxAYdJHCQmqhOgMZhloxf4BK6oj8izM00R4zlAf5V
 BqvJ54+duLoDQNplvk4/5npvSnJNbhN+LEU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 339ws4a49v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Sep 2020 22:43:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Sep 2020 22:43:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bb60+m/LsFZopwu3OypYJnQf8q05A0RoQL/DXMfaZjfj2iOuYqiKDeq4q401CRjPcqr/1QDVAZWciAtlM/yXOwP8DMysfR2jr0uYZEz/xk8oN5UhMmlw3lC1b2n0Tyvbrzlg+5G2BYdYvfSn+7WQJ52IX/9R7BfV72t8YpFSQIPFPYPPJZ3vVTnGqRleKnQudPk2+TEzGmoG6nRX5F2UmQLN/wqU4klB5GA6US+EqJRl3AVEZ5i0NRy30zZTDiY7zAqnhBq+RGrbKQgKKkrHpE5VB0VWtPfRsB0sCsPzcVGZs0vRbdvPiLm+HQVpYZPqDpa8TOufh9HDeBMmI7Qjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv9/5zP90n3982T1gsbcCbw+FKmZu8ntnNHCmt0RcdM=;
 b=CykURy5ynuNVUIDQy3r5Ayi6ssU1/qv/1i/3ed/yAsxdfzO9qU2s+CBH/eDinFqJVMpmr4bVFpsVCwL8Q/6mDOEqoBos8c0/UUx+RGjnmsRlVNcjVjHs97B4gAIN7SBrK994Oow82UrQXQLMY7orwaxonqDGN5UwR6xiwkg/7D3hcIDZl3qCUaUv/ypAd8ip4y2g6tUdJ5ea4FbRYMtOoX2bYpQYNM5sUK46wE0Zg2D9RfMUpKp7UqfPFSmKDMzUxWcaXvX0tQ26h5zmZgp+rrX5jE0GDaWMUTHf1Kc3kn1CWAjcUS4dUd/UxCUJ4e0hevqMPHdO/GuPMUX3bWY4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv9/5zP90n3982T1gsbcCbw+FKmZu8ntnNHCmt0RcdM=;
 b=dIxKQlLc/wbxacuHOC8w24fquUn/b8gCnZMaOqE5/8lvXz0QB9QTpL4S8DgkEntUyQ3silpAHIJFikQK/jRsuvLUczKg/AX0R8Cadnoy2HF+gO1n8gjHRODfkpgoHJDFl6wOLjhsT1VjmyUB6GVIB3IjHG28Hz8MRQrd9TRNpKQ=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3510.namprd15.prod.outlook.com (2603:10b6:a03:112::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 05:43:04 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 05:43:04 +0000
Subject: Re: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
To:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20200825064608.2017878-1-yhs@fb.com>
 <20200825064608.2017937-1-yhs@fb.com>
 <CAEf4Bzb89dz_Sjy14LjQSDWrQ=TpSHAfgf=_Sa=bWUKGqJHCgQ@mail.gmail.com>
 <465da51a-793e-5ea0-85dc-56ab4f36ae34@fb.com>
 <5f4f2d24485ac_5f398208c@john-XPS-13-9370.notmuch>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c26f372b-748e-2141-33bc-00d40c5e4205@fb.com>
Date:   Tue, 1 Sep 2020 22:43:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <5f4f2d24485ac_5f398208c@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::26) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR11CA0085.namprd11.prod.outlook.com (2603:10b6:a03:f4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 05:43:03 +0000
X-Originating-IP: [2620:10d:c090:400::5:b90d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c08981a5-8818-4870-646f-08d84f030fc0
X-MS-TrafficTypeDiagnostic: BYAPR15MB3510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB35101A5D804ACB2C1DB662CDD32F0@BYAPR15MB3510.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFOolxA6oQHDCYFIhDQmhkHG2Zc4GbW71JRVaVsd+MOMlcZBtC/l/6tsWUaN86l75KgSc8xNuUC+oOslvzr3eDsg4cvXd+Jpoze/wQsSDKQHqSTas7SI4vlTy1xQEJDpPRlQkBB4GwiSQ37le6Wv+GisLksBC63mpNh9EqqiRlb3Tw/SBqRBQt10KnVNMbxVuPqBMU1mpv20TLw0e53NEiulYs6IFvxms5K2WQwWmIrdwpzeFp4SJFTMYpIcs6P77Eg9AAyM9vbw7JIOxuU/R5QzG5W9qJ4WmsQpq32ah2WvkJbGuk5WJuvrhtxQvcg8SWAId0Q7eT5NYLfmDzxQL0KMPuDrzWgZ9osWgmqZ7M4APhT0FDl0XNs0lVNpUHUz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(136003)(396003)(376002)(31696002)(53546011)(8936002)(36756003)(54906003)(52116002)(110136005)(5660300002)(83380400001)(16576012)(2906002)(478600001)(66476007)(2616005)(6486002)(31686004)(66946007)(4326008)(66556008)(86362001)(956004)(186003)(316002)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hL6EKHqVcsKYYcfBkmMf0hHWU6Kyb4lzo5IGow3mvZPNF2RdbZELkaYfWjXI72+zvY5X4BfF2MtgbXx3Xl0Kklkf1rxRZ6IzFoO0MOFpLaobPKvisoVomzsyFzGet8vfM9uN3gVYPASK+zw+d/HxVrDb8lNDoDSbEJYspLBTxrFQKJ0QoOpgVOID5FkKtMz7Q/AW/P4z6aAZUzWifQXOgGV13ceNBtGU00zGygNNlPfnUird+M52zePtpuUaV9JY/2KXRtweYZMq4ZC5W1nWsDls0h95gV8J6l/GqSEy5QeHKLeNCwKysMxxYALbWtOfmqVUQhcdZC92yg4OiYsILI8WL8xF0ry1bLaJJ+oTrLNaOOYgsDyyCR+hCZ7XSGCvolHEAouUnBTkBVO0+wBJpyP4kLT1CY4riyZGOFn3dg8dBW1jxv09VHNX05LB3IZtL9gsjY+o1vSUvLv7e8VODxz4Dl3TaNdXM4rDhQZoOPcetIQjIZAgpOYsLLxVjb0/XDuiuH/haXBO+UmjqE1tZBD4lRCDUHHRd5ZWaZ7vvWw3TqNSLcVkcvJomdq1TeB/vvLd/YPbgbSd2faITXfeRGGlI/7nMJNrYzBMhbTB2qxuDF2yjnn0L7BvWuITTnxk4Lf+qa9VTeNJJ4ShYiXLUOcEQ77AFClDCr3M3UQ60vI=
X-MS-Exchange-CrossTenant-Network-Message-Id: c08981a5-8818-4870-646f-08d84f030fc0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 05:43:04.2267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUbpBuv3nhlXuLxmBaGKg5x7VRFxT4iARTxm2LUEotGX9WjiLQl16cmVFz/+nNF9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3510
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020053
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/1/20 10:27 PM, John Fastabend wrote:
> Yonghong Song wrote:
>>
>>
>> On 9/1/20 1:07 PM, Andrii Nakryiko wrote:
>>> On Mon, Aug 24, 2020 at 11:47 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> bpf selftest test_progs/test_sk_assign failed with llvm 11 and llvm 12.
>>>> Compared to llvm 10, llvm 11 and 12 generates xor instruction which
>>>
>>> Does this mean that some perfectly working BPF programs will now fail
>>> to verify on older kernels, if compiled with llvm 11 or llvm 12? If
>>
>> Right.
>>
>>> yes, is there something that one can do to prevent Clang from using
>>> xor in such situations?
>>
>> The xor is generated by the combination of llvm simplifyCFG and
>> instrCombine phase.
> 
> Another option would be to move it out of the isAsCheapAsAMove on the

John, do you mean the following change?

diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td 
b/llvm/lib/Target/BPF/BPFInstrInfo.td
index 4298e2eaec04..7448a2499d40 100644
--- a/llvm/lib/Target/BPF/BPFInstrInfo.td
+++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
@@ -293,9 +293,9 @@ let isAsCheapAsAMove = 1 in {
    defm AND : ALU<BPF_AND, "&=", and>;
    defm SLL : ALU<BPF_LSH, "<<=", shl>;
    defm SRL : ALU<BPF_RSH, ">>=", srl>;
-  defm XOR : ALU<BPF_XOR, "^=", xor>;
    defm SRA : ALU<BPF_ARSH, "s>>=", sra>;
  }
+  defm XOR : ALU<BPF_XOR, "^=", xor>;
    defm MUL : ALU<BPF_MUL, "*=", mul>;
    defm DIV : ALU<BPF_DIV, "/=", udiv>;
  }

Tried the above change with latest trunk. xor still generated :-(
I did not trace down to exact llvm optimization location for this
particular optimization instance.

> llvm side. But, probably better to force the workaround until kernels
> get support. Even with it being more expensive it wouldn't mean we never
> get it so likely not a great idea. Just thought it might be worth
> mentioning. If you have your own llvm and don't have these kernels yet
> it looks like a win.
> 
>>
>> The following is a hack to prevent compiler from generating xor's.
