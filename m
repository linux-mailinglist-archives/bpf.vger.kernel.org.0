Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE4E1D2385
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 02:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbgENASF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 20:18:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4876 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732847AbgENASF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 20:18:05 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E0FIQe023265;
        Wed, 13 May 2020 17:17:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=F6mJlrCPz6rUUOH0r1Ml/OeKvEqcBvaoJ3P3BDrJbOw=;
 b=CUmNN4ituO58se+Xmb0GR9oij3zhPEnRA7ZqUVUaLDJjsTXzSh8w82jHV9+COuOdQE4T
 RQyTNpmU85qkcBF/0I5M8qfhFR1xzm3mRmbBTFPKi1Ty3J8/TuL3X80bf7f5oQLDI3NI
 szizCEPtiGQie/bHOw7LcwTgkOW+h5yMv7c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x60ak1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 May 2020 17:17:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 17:17:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNDNA8Q+PNwCF7mGVHwn7IuszIU42Y5OSILA3iHmNWnZI84XKGE1UCQv27kQ0WMnca1k/xd9VTo5V6RsqbWu07DZroZaGS+LecEODwULD8Dih3x0cChTgF7WLJuS2cGbj3BvNbbYRUHrw7lyVviYTivDA7JJ/sEaR6TAn/vul83hXpOnhCU1L3fk4+ZS+uQkEttY8scLKGw+aV2iSAnp/JnsZGE8of0M4TYCg5gwAIl4oJEDjzxRQ72zn4H0b3TgxfhwvI14Ku+qqdDTMTz7Eq2UqHCHblpSyIToDCrUGVjLYSJL3ruyTVVXwX0ydBW5wXYBICbgEd2ZWEaGI7GebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6mJlrCPz6rUUOH0r1Ml/OeKvEqcBvaoJ3P3BDrJbOw=;
 b=CD5oN2zVV5kcPRMLhCrBHjDLVBWsT2ZjbpqdiZKyb0NVLOYqhS8M3VecRsVhFqcmHDUXR1tjjwHjglAnE1Pqz1rAZOeGQM1Dwvd+cNX167gBperYC1L+8m79SNPFh1ZaYFGOS/TnBB+LJaeh3+EKGmEuPNfnbYwNqYfgtxGqbCM/H26VdN2i+K/uaU2arTjwhiu2xOMapPshf516rNklS68DSOpecm/wvn2JuaFrNycULgppAtg1wFSaAJz/Ct2kEYQs8GTyFj+yvpMU/NXxak/SWK3C9ZZFn971B7YIY+7kWijPgRqWTuQH1flGVRdMHANGdiC414m1JxgPJgJSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6mJlrCPz6rUUOH0r1Ml/OeKvEqcBvaoJ3P3BDrJbOw=;
 b=HqN32i/55h8cpu4wbXJdc0n9HHKmpnfJyGk7c+1X/ICUMXkreE7CJEZr24R4Zpgq4EGw1emw8J/5zcvY8OMoSSpc9hyMrMi1XiCuDmWsd6/dLovPP4CuA3z/8qwNg2ueJxrDkvu8uQ5L1JXUYVQ8RD/qL4KHfjqYQgoP41Zq1Z4=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2966.namprd15.prod.outlook.com (2603:10b6:a03:f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 14 May
 2020 00:17:48 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 00:17:48 +0000
Subject: Re: [PATCH bpf 1/2] bpf: enforce returning 0 for fentry/fexit progs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20200513164525.2500605-1-yhs@fb.com>
 <20200513164525.2500681-1-yhs@fb.com>
 <CAEf4BzaCbPqrC67PmAVkPjW2MxR1H=Md47w5nC1NkdEfWY6q4Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d3d2148f-2f4f-94fe-1574-6072cf471858@fb.com>
Date:   Wed, 13 May 2020 17:17:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <CAEf4BzaCbPqrC67PmAVkPjW2MxR1H=Md47w5nC1NkdEfWY6q4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:400::5:d8fa) by BYAPR07CA0062.namprd07.prod.outlook.com (2603:10b6:a03:60::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 00:17:47 +0000
X-Originating-IP: [2620:10d:c090:400::5:d8fa]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cf2ef54-1b26-4f29-d4cc-08d7f79c3b8c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB29666F5B13DACC92FA36FF5BD3BC0@BYAPR15MB2966.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+1D4IuJQdwblC8CS3It0hPN2zYZj9eXKZSwxmCQvbVZkxMamA07TwYJVck9U0Ia1wavIMZEIXYRa2Tt4+HcD8ucCRf/cvwkGbkzHRdAkIkOFy5511fb9J6D8sigiJdhMv5ihFcChkUK4DVsbNyiTcxyEXtKxS0uFr3oX1JYEeevJwD+ozfdGdwhmja3Q/TJ8v3bh0c0QuY3aQ2w+f5cFkFgT3qBE/jDoKgSRhIcAiZ1lBF2epaSlphupqWySrCBMBS9adEMiOhuscCKbb6zPyQdCVernzMiPva+FStBYH0z7k7f/Gc9Vwuq041V013Z5YM4himLjs7U1a/a8EfLRjiSXb/+uHg9zTVC9GFXxMMlcOgh3MKVekHoqhAOMyyZFpiAXf5ZE8FbyQVQjgsRETWQwY03wTvfyXJnyvJ9G/gHS5cEFJTwyXVtg8zXf63jPwQx0hRY24IP25D3NToMUmPJDDCCcotUQOOZPXeO6E/Bd96YqiO+y4QhwqPpzL+Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(53546011)(4326008)(8936002)(5660300002)(6512007)(52116002)(8676002)(316002)(6506007)(478600001)(186003)(16526019)(54906003)(66946007)(2616005)(31686004)(36756003)(66476007)(6916009)(66556008)(2906002)(6486002)(86362001)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: CnqiCgF4GwSV9H7GCvsS0NtvGnq5chpYJBWCyTy/Fotc7PqZHRYRplAItltth1ir0maTTuNtwULWLkB7dYuyRuj+iJP72pUkL2plSAbyhoE+p7i5esRg+gllZ+V9bRIyy3YdHi4X/PzLpywP8p9xYtAiRv7RQSqjuuYeOOEq4jyTWcHSirRS1fWNanqsrasjc5T+wZ8LmVFAVYBY6/FvM5TjP6LPnL/4tLblIM4kM96ZjBXlQSY8je0cDhu0YaRuCEX+RKyVpc9DxYkqssWRCYTGe3lumfNzjOlHgNOLlZ2GNoeKMtY6o1hU/Lsc0gP2/zgfIj9jSYCgNM9SLBjTsRq4amaHDvUr4aG3hRnRO5Ssf93nPhhAMoEBl//qrdZSjDCCEEqNtz+Qg+KNR7CwFCm8cjzWRiYHp7a5LL9nK3DRsQ6lTwVT2C71MVkqREDaDLzriDhvrinz2Ff/jYomoDctP6VlrrTiN/zrd4JF1IPuvYYsVhXPGyVceIHoelI0Wmh1pM1aBO/C3yZ751dmTw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf2ef54-1b26-4f29-d4cc-08d7f79c3b8c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 00:17:48.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBO0bEhrcFYOnAi3aEcZn64QWTc9mUeOHj6uBkT9G5C22dWiNBNGPP78g7UQBNCx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2966
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 cotscore=-2147483648
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140000
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/20 11:28 AM, Andrii Nakryiko wrote:
> On Wed, May 13, 2020 at 9:46 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Currently, tracing/fentry and tracing/fexit prog
>> return values are not enforced. In trampoline codes,
>> the fentry/fexit prog return values are ignored.
>> Let us enforce it to be 0 to avoid confusion and
>> allows potential future extension.
>>
>> Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/verifier.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index fa1d8245b925..17b8448babfe 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -7059,6 +7059,13 @@ static int check_return_code(struct bpf_verifier_env *env)
>>                          return 0;
>>                  range = tnum_const(0);
>>                  break;
>> +       case BPF_PROG_TYPE_TRACING:
>> +               if (env->prog->expected_attach_type == BPF_TRACE_FENTRY ||
>> +                   env->prog->expected_attach_type == BPF_TRACE_FEXIT) {
>> +                       range = tnum_const(0);
>> +                       break;
>> +               }
>> +               return 0;
> 
> 
> I find such if conditions without explicitly handling "else" case very
> error-prone and easy to miss when adding new functionality. Having an
> explicit switch with all known cases handled and default failing seems
> best. WDYT?

Make sense. Will send v2.

> 
> E.g., in this case
> 
> case BPF_PROG_TYPE_TRACING:
>      switch (env->prog->expected_attach_type) {
>          case BPF_TRACE_FENTRY:
>          case BPF_TRACE_FEXIT:
>              range = tnum_const(0);
>              break;
>          case BPF_MODIFY_RETURN:
>              break;
>          default:
>              return -ENOTSUPP;
>      }
> 
> This way if someone adds new tracing sub-type, they will need to
> explicitly decide what to do with exit codes.
> 
>>          default:
>>                  return 0;
>>          }
>> --
>> 2.24.1
>>
