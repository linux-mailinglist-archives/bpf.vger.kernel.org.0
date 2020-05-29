Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9891E86DB
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgE2Slg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 14:41:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26344 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgE2Slf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 May 2020 14:41:35 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TIfLvk024654;
        Fri, 29 May 2020 11:41:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RVIgJwR6HnG4jLcAUuuLzZGpJhpUF+kW33NCEcUW8ak=;
 b=JqSZsn/o4SD+1L4iptooFS+ylgf2Zqu/lUrbR9qs9LBCnapQsJ0tNTmTB4Vbf00OTg/X
 0dfnYi/JBGf49ieX0Ys+iCAHK3pWFVIJA5AWk532mKPfEMwxSrQsfWLq/Oy1MTgygyET
 QeIzURo4gwsExKtSLkURvnkf7z4N6FxuQjI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31a552jcf7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 11:41:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 29 May 2020 11:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fV9mB1aV/lt+8CjuNXR2EmhCSAWmNQP562NZ6yFwFpMLUfbJRZw2o93mObbbRStNHIjrnhjn4VaJtjuWz2pRFUv3VEHCDNPS8TzPYdvIgZ1mVzqVTvPu6ho6e6yjUCD38fPE0HcmRAaO+h9nuprmF5Wk4dJOPZI8xEdsMPkQDM3r7sCif8/x2aoiVw+IuHuq2XNsVrljdeGtionOUflWCCv41ls5ycSDsGlS28XocVhSHiB6dDAj40zgkziy3zlmfYxnJxVuSCzWcCojIhX3xSEcJgYX2Jl7pYVtYQz7AbUnx19HS4xgkVPxobtYn5j565Y7teeG90O4WANdS42CjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVIgJwR6HnG4jLcAUuuLzZGpJhpUF+kW33NCEcUW8ak=;
 b=S8ilSeYNRPVACFpUp2Z6fR1DorJ9J6P2o+VWpppim3V90zMZwSvCsMuVjmER6nCCcc8KP31a72dfZJ8yrzjwYs4tIQi3oVbRGeXEHXfgMLq3C6sNseR4NAN3UQ5ljuv8xbYYSjlA/FCoE9yQPrUgfkRcaYSBcK12sNnK3a9AIrJL6LtzUTBGmOJue4aY4O/DdLwrlLRbtPttLgxunSpuJdyzkAX3OprzA+/WiOIjArKmNeoD6/oGNevWV2Ut3Wg8sGnUzN37/haYfTmqVqvm4aGKLooripr2wyAe3xmwyTDI1E/7h0fMi1UWwPybrXrLnJUviK0sK8iwGM45e7L0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVIgJwR6HnG4jLcAUuuLzZGpJhpUF+kW33NCEcUW8ak=;
 b=N3AtqEbjVzick8+6p5krrf7IldosM1Lo+lllEVvh7SHhjhw/mFrZSj+qFGsUw/qhJStpQxtNTHJS24BigEKaZOpdlNa0V6kxwvY83JHSNQJnc/V9jDhxWUJq+0McomAgxGGRx7cDpG4ZOjY0rQa0pJKX51dQNXQouRPAMFMOM7E=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2327.namprd15.prod.outlook.com (2603:10b6:a02:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 18:41:18 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 18:41:18 +0000
Subject: Re: [bpf PATCH 2/3] bpf, selftests: verifier bounds tests need to be
 updated
To:     John Fastabend <john.fastabend@gmail.com>,
        <alexei.starovoitov@gmail.com>, <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>
References: <159077324869.6014.6516130782021506562.stgit@john-Precision-5820-Tower>
 <159077333942.6014.14004320043595756079.stgit@john-Precision-5820-Tower>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ec4438b6-4dc0-9310-b14f-f288078fec85@fb.com>
Date:   Fri, 29 May 2020 11:41:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
In-Reply-To: <159077333942.6014.14004320043595756079.stgit@john-Precision-5820-Tower>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::38) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1387] (2620:10d:c090:400::5:c583) by BYAPR11CA0097.namprd11.prod.outlook.com (2603:10b6:a03:f4::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Fri, 29 May 2020 18:41:17 +0000
X-Originating-IP: [2620:10d:c090:400::5:c583]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc757de5-19c5-43e9-57c3-08d803ffdfc6
X-MS-TrafficTypeDiagnostic: BYAPR15MB2327:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB23272B29AC203F9F54E2C697D38F0@BYAPR15MB2327.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qU2WgBhvQcl8ymDnkoySFSF8Y2rsMjN/coCwwX+rysAIF2du6WiGpGVmanUf0nJ9gVqRcITx4gA+p53YmZ7NjM6+m1r7PM8DVCGZ7UT033gsti+rCakm00OVnfPJpsV+vYaP8JDsbBlcV3XPwd3yoWRLbc7ER4XQCHmKXqsSNcn5H+9qZhUE5onIuSvDLXZH68klmeMKX/BKwrj3fQA4+Dan0l4/TULjK4/zFZeb07/IMV3wVFQqfOk3W2riC2pFE/6n+xt05YOEYjNzE5KMAl7W0/awdwG6L4MC+u/FlN141ZhtYhmIcaD18Fv4ySaEVWPepYirt5PnNzHp/CllTi6PT9pkUktDnD70kRGgj6cu0mpK91YJDWzt7tjdheOL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(396003)(366004)(346002)(136003)(2616005)(5660300002)(8676002)(8936002)(186003)(52116002)(83380400001)(6486002)(53546011)(16526019)(66556008)(86362001)(31696002)(2906002)(478600001)(36756003)(66946007)(316002)(4326008)(66476007)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tfe5sYNPjko8PO9Gt3hfRZTZcVkeInyXGcGTwYevxLyFCHQbNxQo1/T3HG+j0p36oeKBLd4krC6IVs5NSfEKTi4fIyoLg46H98Ada8SEgTa6g0oXUz3JnNtqMfxwaWhwTKqVLwrxCyzSaZAkct5s1kNUzS+68S7rr2fSbzltboLqw663DNTv8l+SjiqRRcZh7pN0aJbRDVHGFv2iDYM6piybOIy4GOEmBBFf1hTI88IU9H9gcz0ZQDfHzPUl/vuRobqkhvnIwzW24HNRDJoSvgicvPH9XQkHh0XEB1j5vImLV/yGHsIMgLGDsGdnF3qyzptk89F81NgmlCb1qrnHUgDUuUA0vsoqo65KXx2cvvEbFOona7VpbAYIPd4V0kTRMOtpAP8lUbqQtmSGDEWgxKoYhcFdyCGo8FdoHPgY5hSR2hES7t5sR/tVOsvir3Z/dNYalkUGFLuiwVMiRgYSiEUmfzIVU+wUQ3Jw/Nz0XSeqj3JQrC74O0yUbLRDkYFBkX8IbbNwaDrUXKibK1blGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: dc757de5-19c5-43e9-57c3-08d803ffdfc6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 18:41:18.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhCzB53MWCzyJlFLE0+swm1MvURBbaKJVQBqASL0HqyvgTTTutDZPTiDawCOl55S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2327
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_10:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 cotscore=-2147483648 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290140
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/29/20 10:28 AM, John Fastabend wrote:
> After previous fix for zero extension test_verifier tests #65 and #66 now
> fail. Before the fix we can see the alu32 mov op at insn 10
> 
> 10: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
>      R1_w=invP(id=0,
>                smin_value=4294967168,smax_value=4294967423,
>                umin_value=4294967168,umax_value=4294967423,
>                var_off=(0x0; 0x1ffffffff),
>                s32_min_value=-2147483648,s32_max_value=2147483647,
>                u32_min_value=0,u32_max_value=-1)
>      R10=fp0 fp-8_w=mmmmmmmm
> 10: (bc) w1 = w1
> 11: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
>      R1_w=invP(id=0,
>                smin_value=0,smax_value=2147483647,
>                umin_value=0,umax_value=4294967295,
>                var_off=(0x0; 0xffffffff),
>                s32_min_value=-2147483648,s32_max_value=2147483647,
>                u32_min_value=0,u32_max_value=-1)
>      R10=fp0 fp-8_w=mmmmmmmm
> 
> After the fix at insn 10 because we have 's32_min_value < 0' the following
> step 11 now has 'smax_value=U32_MAX' where before we pulled the s32_max_value
> bound into the smax_value as seen above in 11 with smax_value=2147483647.
> 
> 10: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
>      R1_w=inv(id=0,
>               smin_value=4294967168,smax_value=4294967423,
>               umin_value=4294967168,umax_value=4294967423,
>               var_off=(0x0; 0x1ffffffff),
>               s32_min_value=-2147483648, s32_max_value=2147483647,
>               u32_min_value=0,u32_max_value=-1)
>      R10=fp0 fp-8_w=mmmmmmmm
> 10: (bc) w1 = w1
> 11: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
>      R1_w=inv(id=0,
>               smin_value=0,smax_value=4294967295,
>               umin_value=0,umax_value=4294967295,
>               var_off=(0x0; 0xffffffff),
>               s32_min_value=-2147483648, s32_max_value=2147483647,
>               u32_min_value=0, u32_max_value=-1)
>      R10=fp0 fp-8_w=mmmmmmmm
> 
> The fall out of this is by the time we get to the failing instruction at
> step 14 where previously we had the following:
> 
> 14: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
>      R1_w=inv(id=0,
>               smin_value=72057594021150720,smax_value=72057594029539328,
>               umin_value=72057594021150720,umax_value=72057594029539328,
>               var_off=(0xffffffff000000; 0xffffff),
>               s32_min_value=-16777216,s32_max_value=-1,
>               u32_min_value=-16777216,u32_max_value=-1)
>      R10=fp0 fp-8_w=mmmmmmmm
> 14: (0f) r0 += r1
> 
> We now have,
> 
> 14: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
>      R1_w=inv(id=0,
>               smin_value=0,smax_value=72057594037927935,
>               umin_value=0,umax_value=72057594037927935,
>               var_off=(0x0; 0xffffffffffffff),
>               s32_min_value=-2147483648,s32_max_value=2147483647,
>               u32_min_value=0,u32_max_value=-1)
>      R10=fp0 fp-8_w=mmmmmmmm
> 14: (0f) r0 += r1
> 
> In the original step 14 'smin_value=72057594021150720' this trips the logic
> in the verifier function check_reg_sane_offset(),
> 
>   if (smin >= BPF_MAX_VAR_OFF || smin <= -BPF_MAX_VAR_OFF) {
> 	verbose(env, "value %lld makes %s pointer be out of bounds\n",
> 		smin, reg_type_str[type]);
> 	return false;
>   }
> 
> Specifically, the 'smin <= -BPF_MAX_VAR_OFF' check. But with the fix
> at step 14 we have bounds 'smin_value=0' so the above check is not tripped
> because BPF_MAX_VAR_OFF=1<<29.
> 
> We have a smin_value=0 here because at step 10 the smaller smin_value=0 means
> the subtractions at steps 11 and 12 bring the smin_value negative.
> 
> 11: (17) r1 -= 2147483584
> 12: (17) r1 -= 2147483584
> 13: (77) r1 >>= 8
> 
> Then the shift clears the top bit and smin_value is set to 0. Note we still
> have the smax_value in the fixed code so any reads will fail. An alternative
> would be to have reg_sane_check() do both smin and smax value tests.
> 
> To fix the test we can omit the 'r1 >>=8' at line 13. This will change the
> err string, but keeps the intention of the test as suggseted by the title,
> "check after truncation of boundary-crossing range". If the verifier logic
> changes a different value is likely to be thrown in the error or the error
> will no longer be thrown forcing this test to be examined. With this change
> we see the new state at step 13.
> 
> 13: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
>      R1_w=invP(id=0,
>                smin_value=-4294967168,smax_value=127,
>                umin_value=0,umax_value=18446744073709551615,
>                s32_min_value=-2147483648,s32_max_value=2147483647,
>                u32_min_value=0,u32_max_value=-1)
>      R10=fp0 fp-8_w=mmmmmmmm
> 
> Giving the expected out of bounds error, "value -4294967168 makes map_value
> pointer be out of bounds" However, for unpriv case we see a different error
> now because of the mixed signed bounds pointer arithmatic. This seems OK so
> I've only added the unpriv_errstr for this. Another optino may have been to
> do addition on r1 instead of subtraction but I favor the approach above
> slightly.
> 
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>   tools/testing/selftests/bpf/verifier/bounds.c |   24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)

Acked-by: Yonghong Song <yhs@fb.com>
