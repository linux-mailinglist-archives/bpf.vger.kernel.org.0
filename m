Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED422862D5
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgJGP6m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 11:58:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33844 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728268AbgJGP6k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Oct 2020 11:58:40 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097Fruf5009565;
        Wed, 7 Oct 2020 08:58:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=zo6DVEcgyKZhooPObaCg7uc4QuEocYHG5RSEl2MwZzQ=;
 b=pimTUDnVKQCXLZaHFcBCaHAEUyRV56PvL9D3+3FGI2lluaNj5f4umtbmxf3v8fupxcG0
 Q4hxHBPXHpUm4DKj9RMP8lUqgn0x54Yrc9kDZAeWNz5Z0WFQhcefCQBscRrLWY1tHYnd
 AEuGD2+1/a/fzDExyXAlnnsA61PE4wTEdVg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3418t9j803-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Oct 2020 08:58:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 7 Oct 2020 08:58:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loOlPl1Y+jIqIGdY7b8x7wnlGrs9/HCEYILNYidqT2oOXQw5gcxG7OGNuAIuo9jp7MHdwoDMcCTa9NGMxAOzSNJAwVCY/swKP4BZ3gMzseXuclj03UXWvV4pGOg8yP8WvlosFQ5tsvUsvNpJQD8iW+QcUviMEYN1/Ve1qOgR3F2l0VyApOlYrisnJwb+2WDFwbIbipwvk/ZQ2uqNWBkHjzpdQMrrCNI4q6WXAyABmEGDF2OECFkkyOCzN1xg/HvKkZBXE4GYppsHjWKY4Qpg3S7nYO2M2sPzeBZzID0kKdikJsOZ1hfg8kmAMb/bDA+L8rW1b9Ga1b4uyTMIPkUb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo6DVEcgyKZhooPObaCg7uc4QuEocYHG5RSEl2MwZzQ=;
 b=haVXzFF8vSC4UJRPUDT71HnOmXp/Rfx4dJAG7O8umK/LLI7+pu4m4IbZwEihA7W4H3nNb9qCwFzoVAQ2tnm+FHkLtFFlPpW6nIhOMrx9rkaFs3Ac/4MOizwnCsRPjTP9kKjmeLKr4Bu3qHa7WFYXKbOsioIgEblgLWLbqMbIJnaU3fBno89qoEfNOF3z53bRu8Pq0V425WuxSmVCJ5BH8caKGIskS5lkR2GThXph8XCklthiKcBXJ+qMvmgzTehYBG9CDOvrlqjcY9eIYGvAnooH3j9aGEryushJ3ePYRObRPUfeGfnI41ccjD736nrF9pVSdweYxJXuPMXYR0uFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo6DVEcgyKZhooPObaCg7uc4QuEocYHG5RSEl2MwZzQ=;
 b=b36dKYt4pGG+Wz7x1gpekO1IWGurf+1Qdeg17jyPb0Us1grtxmdgbOJnLJ/y6OHcwzFecFqCjNn6V5JDsozU3fzYZCcanf1ajYW138AuEFTM+VBbhmzFhO851fH670MgwNgWSfYYeh00/2ZRyee/HOVF8u/REE2IVA2ZN9DTe7o=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2407.namprd15.prod.outlook.com (2603:10b6:a02:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Wed, 7 Oct
 2020 15:58:20 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3455.023; Wed, 7 Oct 2020
 15:58:20 +0000
Subject: Re: libbpf/bpftool inconsistent handling og .data and .bss ?
To:     Luigi Rizzo <rizzo@iet.unipi.it>, <bpf@vger.kernel.org>,
        <ppenkov@google.com>, Luigi Rizzo <lrizzo@google.com>,
        <andriin@fb.com>, <sdf@google.com>
References: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0b04c2f6-c9fe-0a2a-810b-bacd9b2f8478@fb.com>
Date:   Wed, 7 Oct 2020 08:58:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:d6f3]
X-ClientProxiedBy: MWHPR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:300:93::27) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1224] (2620:10d:c090:400::5:d6f3) by MWHPR17CA0065.namprd17.prod.outlook.com (2603:10b6:300:93::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Wed, 7 Oct 2020 15:58:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19a5629a-d081-4e21-ada5-08d86ad9d020
X-MS-TrafficTypeDiagnostic: BYAPR15MB2407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB24074DEDC7AACC17E0776579D30A0@BYAPR15MB2407.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eM/imvHguPnOl0sgxgsRSED2oM4UkMe1N1TDedKKCcjCUCNHoBOLUlA1UQmi9rg/SK68hOXa3ARJvZhjIZ7+OhACi/sfh2wClZ7e7IkX0CQ7qnmiYvmu5NRobUEA37bSzJT9TWjIaiFptmCjmuBQ7EI1LEZHe613uTutz1G6H3XVkfrQy0wmblaGDfTBnAQCIUrR3U388vBstrc26uzTZ7RdTzR/tLXJ3ztidSxsGP62iMXKp236DAZ1HXTSagArIPtZqfwc1wKI1GARuS/1nkoK2+miECsOJE/CcSjJ1x39R6mRX0uNU752LCG40fjhhZpni07W9F2tXUyNSPRxV5rw5Ci2k4jK6VktkuZuPm3R4BhvjkaFGmEGteUruMVsx5RlmrE6yGvPO9S84wk91Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(376002)(366004)(2616005)(16526019)(186003)(316002)(8936002)(36756003)(8676002)(110136005)(31686004)(52116002)(53546011)(6486002)(478600001)(66946007)(2906002)(66476007)(66556008)(83380400001)(5660300002)(86362001)(31696002)(142923001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7asgPAeT/7E3eoMwI+1xXjA3wx3ZbOVfIRXcLNskDK3GrAta3/N/ZdvgDVhmiANgpppR3z96eFha5Z/uk8ysRCm9ifYbOLtG1MJMGcGMy+Ix9HlxHXRJM8UyFLw/V0+vp0NvuZ1PWirNWrRNh0bSLRzQD4lQVCi0q6zRXcnxlNi6TCgaCIwvFljFsaJK2N4vP18MtBkpCi5OU4QSPTpIbnZcS5k6Z0KIFbkeB/IZ9fBgH/a88NDGo/tWtATAsPkGneIqTw2ZC4r8k38jaayjapHpo5wb082hOtDTwh0L6Jfx5oZcHT0oeYh149dq92CMhPH2VSItEPvE+z2rfO+nCTy35vA4egx+bjFuPz7xX7URRaKksBqdM550SH/+7le6rxHSa4nOJ6HFGDJCnRLuXL1thyPolO9SeE0nsCG1hmNLOczItUZzATiP3bBRk6tlcTAnGSmCJA6YPyzWSdDMDdKWjAYnjqmSjMFOd5F3miPDj4AuUf2tn6XJIllL0nVJ3z2ivZagevAG3uve5yCpOFRt9A3XUwQ/dzxeMl896J0R281GKmUBAQ22jJLTIIz8dSYJo6kpemu28XRbJvoksCpjPuSj8lJzkCwnqeTgFiVfgU3YJeid2Uu9C1XUwpD+1eDC3rQon063c8rcTuIQyDycRobXszGx6r8Ty3T6rozg0unPT6VeQ9xTMQweRJBs
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a5629a-d081-4e21-ada5-08d86ad9d020
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 15:58:20.7443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qpXtR0XnReS4uNpYLnGFqmBwqj57QgHG2dkwQVYPOKsBlTVcBHtNMcrH/QOS/2D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2407
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_10:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 clxscore=1011 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/7/20 7:01 AM, Luigi Rizzo wrote:
> I am experiencing some weirdness in global variables handling
> in bpftool and libbpf, as described below.
> 
> This happens happen with code in foo_bpf.c compiled with
>     clang-10 -O2 -Wall -Werror -target bpf ...
> and subsequently exported with
>     bpftool gen skeleton ...
> (i have tried bpftool 5.8.7 and 5.9.0-rc6)
> 
> 1. uninitialized globals are not recognised
>     The following code in the bpf program
> 
>       int x;
>       SEC("fentry/bar")
>       int BPF_PROG(bar) { return 0;}
> 
>     compiles ok but bpftool then complains
> 
>        libbpf: prog 'bar': invalid relo against 'x' in special section
> 0xfff2; forgot to initialize global var?..
> 
>     The error disappears if I initialize x=0 or x=1
>     (in the skeleton, x=0 ends up in .bss, x=1 ends up in .data)

Yes, this is a particular issue with llvm10 which without "=0", put
into "common" section which we do not support. The issue is correct
in llvm11 if I remember correctly. But please just use "x = 0" it works
for all versions of compilers.

> 
> 2. .bss overrides from userspace are not seen in bpf at runtime
> 
>      In foo_bpf.c I have "int x = 0;"
>      In the userspace program, before foo_bpf__load(), I do
>         obj->bss->x = 1
>      but after attach, the bpf code does not see the change, ie
>          "if (x == 0) { .. } else { .. }"
>      always takes the first branch.
> 
>      If I initialize "int x = 2" and then do
>         obj->data->x = 1
>      the update is seen correctly ie
>            "if (x == 2) { .. } else { .. }"
>       takes one or the other depending on whether userspace overrides
>       the value before foo_bpf__load()
> 
> 3. .data overrides do not seem to work for non-scalar types
>      In foo_bpf.c I have
>            struct one { int a; }; // type also visible to userspace
>            struct one x { .a = 2 }; // avoid bugs #1 and #2
>      If in userspace I do
>            obj->data->x.a = 1
>      the update is not seen in the kernel, ie
>              "if (x.a == 2) { .. } else { .. }"
>       always takes the first branch
> 
> Are these known issues ?
> 
> thanks
> luigi
> 
