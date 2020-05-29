Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C642B1E86D9
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 20:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgE2Skz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 14:40:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58462 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbgE2Sky (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 May 2020 14:40:54 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TIdOxG011782;
        Fri, 29 May 2020 11:40:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3fyZXxsogdYYB2jJ/O4fJF3Cz6L7XX2q8+3FboXc06k=;
 b=ArBgPaEGjCi/I1uSE814WhVmVh0ABmXrxnxBM/RP3YIZ+3fwFfbPycaspu8kWn1UaXdW
 s0EQoYuq4KUeiWmyiXXfebUAqTt5cTUKcaPrPpoJYNDQtlUyPoIiawhl/65rEzgVD9E7
 UADMwr515a6b/3hajgvP8HU8qY/oEoqVf+k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31a4ndtt4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 11:40:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 29 May 2020 11:40:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYtgQnOA4Obpa6QRc21JbHzWI2Nld7o36CRetQH35xylxAQWlPT/X7zs58pL+2hELy+M/0uQXWczgR34cffyqyGpZqDXBulDBwy2akycgwEhtFfXC45TjEwfx9gU7oiHgEjc4RLtuaf5Z2QRMBtLA5LnoH8ci2N3EHZG/5MfOs3sQuDRziaG2TnPBhxQ3m1YO9YMhWVgTrxb88cpkpezlvpjfMu5FNrhLkC6MoSV5KSGgpW/rE8oD1ukTyyfHhuukUKuUow81r7VOgLnU8vcf9PzbJk5dCM4aCIAuOVnWzsBiHYmasr+GPKBWZFT0mtjGEga+Ws1Gelcv2k7dHzpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fyZXxsogdYYB2jJ/O4fJF3Cz6L7XX2q8+3FboXc06k=;
 b=IZpn3OiaRk8GzZSuAx5zTACLugvYge2v60yJBoFeTK4TamyeeW0BiVSLrc12MOrkvYgou7MnliN5wyER2jDncafFPlLyTxYMlS+Tn8fQqa7DQCU988ni6lV/bZP8/hY7T0fXIMEWgzar+cQ0+E7Kvi++S7zCvr4SVXoGeKRjv2dKhwyDG8SFJqujI9bp1//d7z/871mL0DpgutG2OA4RKm31msPyccWcDIqQt6rAo/yYVoIMO7X2t/GdDNpsVQySIXZMxFWYcuc4IQaBPm4U4X5VUd3I+Lkuq1mfYvsTUSDzmfRQzdc2uUMxdQf0IJjNFvJl9uMEuBl02QQLqmjNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fyZXxsogdYYB2jJ/O4fJF3Cz6L7XX2q8+3FboXc06k=;
 b=lNOWoxfqXFG6fL1HD96lMaeg9i1mWsls7fEKFccfn6sPjdSGDw6YFD3RPXyoPndIAzNrIck512qLZCHVybsxSi2ZvijjaJGTZvvaqrcwA19eG0nmfZah4kE+BVUWs8OkJ49EQg7V57MjOcKhQoNe7qhs+2LQDwcER9VGg4w6ufA=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2327.namprd15.prod.outlook.com (2603:10b6:a02:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 18:40:38 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 18:40:37 +0000
Subject: Re: [bpf PATCH 1/3] bpf: fix a verifier issue when assigning 32bit
 reg states to 64bit ones
To:     John Fastabend <john.fastabend@gmail.com>,
        <alexei.starovoitov@gmail.com>, <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>
References: <159077324869.6014.6516130782021506562.stgit@john-Precision-5820-Tower>
 <159077331983.6014.5758956193749002737.stgit@john-Precision-5820-Tower>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a5a68612-f023-3dc3-7fa9-a8b46d7b8f12@fb.com>
Date:   Fri, 29 May 2020 11:40:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
In-Reply-To: <159077331983.6014.5758956193749002737.stgit@john-Precision-5820-Tower>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::43) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1387] (2620:10d:c090:400::5:c583) by BYAPR11CA0102.namprd11.prod.outlook.com (2603:10b6:a03:f4::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 18:40:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:c583]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 937f2a9b-de90-4e2d-b9a0-08d803ffc7bf
X-MS-TrafficTypeDiagnostic: BYAPR15MB2327:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2327987929A026470C1C0A43D38F0@BYAPR15MB2327.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAug9uvga8CbsRNArTNfhW+rZEZ+E0tRm8CI6fq1jedJiwsGHPJ+MDF6RbS0+CLvqeY7aMWeV/p8BBueLyK1tyxq5T6qhkE3wWHASpzqubNfAuWhmAWAyCIhvP84A36gWtJFGduOavkWCUxmUWceXhV7wzH56junPI4uBU5qkGtNCWT6T0mO3Lu/+ia8BScOAsQ5RP2WIv/fk/7LvrcmhMFHWq80gMD1FBzoFx6iVqDoCgVmIog/OXoAOwdA+qlMRCWvdXCI34fmFWYuHSAoK/6x7kDNOIiUjkbaTyYUFsijECDC7h3owi2Jyv2ih7SI6pelQwB/IKvI0wl54Vgwhb/+XDycvKrs52IhkTelBTVGdfKknnCLkBiX7LiV9wAB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(396003)(366004)(346002)(136003)(2616005)(5660300002)(8676002)(8936002)(186003)(52116002)(83380400001)(6486002)(53546011)(16526019)(66556008)(86362001)(31696002)(2906002)(478600001)(36756003)(66946007)(316002)(4326008)(66476007)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: U20LauWsDfVr7hNyr2xlZhbdIa+qScUuoSm9ka6gU+leGS7Vncsd3bGGzRmjlzOxsoyR44Vt11enq1YvXE0pGZqJojHt7DNFmiVHMaKjICF3RnnuWQMe0iylL/iMM4WnxYwmuMgXg5AyzHHlkVY1IB5Ae/wwJ6YP3T3J1ADzOzFi5zRGIldkuNyapx+GmI16nxWRoIkdIGGX99gmTs2208/XL1uJNAVxCdmymslCvsoIz6JQiIB7LMYEeMCZNODaC8MB1PXVJ7jhJQovr5KDkxsvQKHaRGPh7XjGnPaUZ9jFafgk6Pvj2Ji9oUkp6RFvHiUMTgIZSB0EHsaaRyRdBdvk3M0uSFzzRNa5DIxZvfhBcT0uQVmZgSCpJht3ZSUDpeaZsEo6Ntyd6gwKFEanz38RAaDduJR1HZt7cNqjzEugymvCrzGCuniyDMvXEJAJULmGVnJI7DlAzLmpaEyn9/w1JiTuwxTYKkkBUfgFWMPmh0nS+bIBlOV8P7/SxD5z4ySxvUdwxrgUusRQzpo7JQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 937f2a9b-de90-4e2d-b9a0-08d803ffc7bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 18:40:37.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNUclGGhrDFYU75ULmUaXqzumbPCbWA+vgF6VpBid+qvCxD4FInnfjsjoR9aKekJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2327
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_10:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 cotscore=-2147483648 mlxlogscore=912 spamscore=0 malwarescore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290140
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/29/20 10:28 AM, John Fastabend wrote:
> With the latest trunk llvm (llvm 11), I hit a verifier issue for
> test_prog subtest test_verif_scale1.
> 
> The following simplified example illustrate the issue:
>      w9 = 0  /* R9_w=inv0 */
>      r8 = *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
>      r7 = *(u32 *)(r1 + 76)  /* __sk_buff->data */
>      ......
>      w2 = w9 /* R2_w=inv0 */
>      r6 = r7 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>      r6 += r2 /* R6_w=inv(id=0) */
>      r3 = r6 /* R3_w=inv(id=0) */
>      r3 += 14 /* R3_w=inv(id=0) */
>      if r3 > r8 goto end
>      r5 = *(u32 *)(r6 + 0) /* R6_w=inv(id=0) */
>         <== error here: R6 invalid mem access 'inv'
>      ...
>    end:
> 
> In real test_verif_scale1 code, "w9 = 0" and "w2 = w9" are in
> different basic blocks.
> 
> In the above, after "r6 += r2", r6 becomes a scalar, which eventually
> caused the memory access error. The correct register state should be
> a pkt pointer.
> 
> The inprecise register state starts at "w2 = w9".
> The 32bit register w9 is 0, in __reg_assign_32_into_64(),
> the 64bit reg->smax_value is assigned to be U32_MAX.
> The 64bit reg->smin_value is 0 and the 64bit register
> itself remains constant based on reg->var_off.
> 
> In adjust_ptr_min_max_vals(), the verifier checks for a known constant,
> smin_val must be equal to smax_val. Since they are not equal,
> the verifier decides r6 is a unknown scalar, which caused later failure.
> 
> The llvm10 does not have this issue as it generates different code:
>      w9 = 0  /* R9_w=inv0 */
>      r8 = *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
>      r7 = *(u32 *)(r1 + 76)  /* __sk_buff->data */
>      ......
>      r6 = r7 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>      r6 += r9 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>      r3 = r6 /* R3_w=pkt(id=0,off=0,r=0,imm=0) */
>      r3 += 14 /* R3_w=pkt(id=0,off=14,r=0,imm=0) */
>      if r3 > r8 goto end
>      ...
> 
> To fix the above issue, we can include zero in the test condition for
> assigning the s32_max_value and s32_min_value to their 64-bit equivalents
> smax_value and smin_value.
> 
> Further, fix the condition to avoid doing zero extension bounds checks
> when s32_min_value <= 0. This could allow for the case where bounds
> 32-bit bounds (-1,1) get incorrectly translated to (0,1) 64-bit bounds.
> When in-fact the -1 min value needs to force U32_MAX bound.
> 
> Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>   kernel/bpf/verifier.c |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Thanks for the fix. LGTM.
Acked-by: Yonghong Song <yhs@fb.com>
