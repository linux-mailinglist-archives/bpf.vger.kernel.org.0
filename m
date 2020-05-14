Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD54D1D33C9
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgENO7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 10:59:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27758 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgENO7R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 10:59:17 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EEnB2A017173;
        Thu, 14 May 2020 07:59:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UhopGLcAg5McBza74+ThhyGVsfRVCn6hp1GfAgSLPHw=;
 b=bDepHB6LTg+s0uNgD0ZFSaNjPqi7jkdnOava70IPi8zqTwxMuuDGX0uTVFKvzjK3Pm4v
 vM6zi8IiJ1/mx5zbT24AcAelhDE6wO+P+/kXsyhIPvecVxnEWGWSEkkFsfgwwHAjays/
 WUumkaI1d6zGuQlEWU3l2Cqvewwy4TNgyAo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3111r0hys7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 07:59:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 07:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCdGVVZSTPHBd/PP7kuBHuWZ5iRe/gClQijvqg4NZzf858FBEfQKjZViiMX+k9GQdhHZ6DLngKpbHmjFxTqRc8TT4i4PfD39ty+MlxLbQXtBiBu7iLi8JNoqb0DHRNqbO3czuYh6zKjNVquPSq71Vj1Cc0HHZQVxdvm4h3H5z8EiNRoi/aSGG9J23qD2x96N2WfrmndleL0CZlm4pdgrWXIxP/mKqioZgUO/l/HII0aAae4M1qeVUTlpuZUFqkjMWXy7DykkO+1Kk9bNJmSH0eaxZQmm+J+la4mX3uQCA3a24uT8AP0fkz84+f4Q1KqlV2zv2JsivrsfEFrWgxJRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhopGLcAg5McBza74+ThhyGVsfRVCn6hp1GfAgSLPHw=;
 b=iDmWnBHN0jEpqqTfEaRF0TWiFGyvH8ti73qrBFNbh8UXCv/oew2X8JX7+fz3NPJiK4JyVfAvUXdOLXih5WMY8F22sxe8KBLfYc1qDIHDqmtlUxILBopXzRSNESpWKQ0+/LvaaX+FD5JofM+4PO6ehl2MBbAOrFxagB3JkF91y6yztXFvJYAL4LGbJkt9VFYHixpQsQ7cVLRtaY7CO7gPq0cB+5evoPh6gsaNCDVqRNTnQ5Rfc9S6/n/BCa0EUsiMCSvF8qE4rD0IQpvEMmqLGORz8sx2o9K3/3wRZ9wxu+yV2rr6IORrVwu5AK0FHJM84TK1JzRULM814d2Bub6iOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhopGLcAg5McBza74+ThhyGVsfRVCn6hp1GfAgSLPHw=;
 b=Lzc9gTFZaJ4fYBGwE3hJnJfL1OD9AB0yFqyZQADqA1ebgAGcQIM4ORa0xbowuHFGMKKXVXePzLacqewxJWQsvwyJxLNGccKIZ3m9dbnF8sVCRdah9ODcMZIZ4ecnwj2nEsExdXqrPX5vlQvWL0VVlmNt0PqYYL0FaH3OcvY3WhI=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2629.namprd15.prod.outlook.com (2603:10b6:a03:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 14:59:02 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 14:59:02 +0000
Subject: Re: [PATCH bpf v2 1/2] bpf: enforce returning 0 for fentry/fexit
 progs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20200514053205.1298315-1-yhs@fb.com>
 <20200514053206.1298415-1-yhs@fb.com>
 <CAEf4Bzbks=ti1OuXg3d_Nc0Vm5cvv-ceLB+Dq8OZgHdBT+SA1Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f2fcdf89-41d6-04c0-cb6c-1702aff48ad8@fb.com>
Date:   Thu, 14 May 2020 07:58:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <CAEf4Bzbks=ti1OuXg3d_Nc0Vm5cvv-ceLB+Dq8OZgHdBT+SA1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:3bff) by BY5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:180::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend Transport; Thu, 14 May 2020 14:59:01 +0000
X-Originating-IP: [2620:10d:c090:400::5:3bff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77df4bbf-e20b-43db-a0fe-08d7f81756c9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2629:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2629515B2E93C16652DFD62CD3BC0@BYAPR15MB2629.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Xvu9NJv70y/cLhwMgANoDaVfBlqpSlo4HMM9gVjtbD/ZRawvtqokpiDUtgJK0xUSzTIeHmonS/rRgNwQRHlKk9NOOn266jsrvjvvYxpRFsH4BRgnK80j+Szi1OkJsu7QCbRq8JUfu7p4qaqUB6BRcrU/HyrUlwUhlQTsf0OaaJX/I8eCudvi//27kytwHLThlIpDSuqKuWdq00N86ngsX3FXIMHsuErDAYHNQcrXjUM+Bo6Bvhe2EtUnS1Py9pCu5gEvsd325LfrTwUQO3u3YQ6D0LQPMEfwBGr43Zao3oh0cpMk9NkBxK2d18TE2PKgJat4bI7z0NDynGNbf9AwwhO4eidoWtjJU8ofypmL4vqCVgZDrvaK79Sbi4ybjEsnZoePoFyvVbhyRsaNPCiivHtHn1gLhxidoX2dt0FZdGHUbalCBkscVUaakd4G8mGdUWxgYeEWHp7MgWUUs85yrneSyE0Z/i4rHix/N0x0cBoEHRulXiSONz0c+fj9bnj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(39860400002)(136003)(396003)(86362001)(186003)(52116002)(31696002)(53546011)(31686004)(6506007)(8936002)(8676002)(2616005)(316002)(36756003)(5660300002)(2906002)(54906003)(478600001)(6486002)(66946007)(6916009)(4326008)(66556008)(16526019)(6512007)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: qPiNRBqc2mIOnsGLHqdSnYqmxuwzEoBVmPRkTpzCxdvg2aTf2YYbkh0u8XwwkgRw7Qqfh5YqIzAkALgq/YOVQndN7w8EUZVJfDTru/QX8OF+dVDhEyAKKhoTY6aCuVQbEjFj1OOEO1DtMX/IKVGd3ZfiQLx03I9h24tr7NRaZlgXxDkpSQXa14ftb747fiFhprZE+OURg1nVd1MXp/SLilkap/cGVITK6rZWSQyPAcwGHFer9SK0Q1JyKJ+s8eN0MCWN7U44+9trjZN8CWGhr9pw6bSwcDVID1dld938vwSHu8Uo9cAD6HZvViRVYbYPOEpJ6RnXx38dzGHQ7E/hkrIOuITtEg5uXrvWSMrkfRNElp8NDZ6S6MH2a+iqtsaBFkiQOxdbPE9dkF9SXjC+xEwvf4xkeQNDhSclhylUKZ4xcbVUoD7qGKqzzXIb5CzbzJWhsZImzpoO6o6WVv+HB4RTvhu9SWTY2bNcAxTr+R7FNyXwgwOuk9qS5C7xvVk6O9KX1BudBuXB7JbJ2OOqSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 77df4bbf-e20b-43db-a0fe-08d7f81756c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 14:59:02.2513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDukfqxNUlb7oNg+tzwVUJGhE0y+gm/6VUkQnJi95Q2argxj34K3YpqYSo4RpXwj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2629
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 cotscore=-2147483648
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140132
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/20 11:14 PM, Andrii Nakryiko wrote:
> On Wed, May 13, 2020 at 10:32 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Currently, tracing/fentry and tracing/fexit prog
>> return values are not enforced. In trampoline codes,
>> the fentry/fexit prog return values are ignored.
>> Let us enforce it to be 0 to avoid confusion and
>> allows potential future extension.
>>
>> This patch also explicitly added return value
>> checking for tracing/raw_tp, tracing/fmod_ret,
>> and freplace programs such that these program
>> return values can be anything. The purpose are
>> two folds:
>>   1. to make it explicit about return value expectations
>>      for these programs in verifier.
>>   2. for tracing prog_type, if a future attach type
>>      is added, the default is -ENOTSUPP which will
>>      enforce to specify return value ranges explicitly.
>>
>> Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> Looks good, except a nit below.
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> [...]
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index fa1d8245b925..2d80cce0a28a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -7059,6 +7059,24 @@ static int check_return_code(struct bpf_verifier_env *env)
>>                          return 0;
>>                  range = tnum_const(0);
>>                  break;
>> +       case BPF_PROG_TYPE_TRACING:
>> +               switch ((env->prog->expected_attach_type)) {
> 
> nit: extra pair of ()?

Sorry about this. Not sure whether it is worthwhile to send another 
revision. Please let me know if another revision is needed.

> 
> 
>> +               case BPF_TRACE_FENTRY:
>> +               case BPF_TRACE_FEXIT:
>> +                       range = tnum_const(0);
>> +                       break;
>> +               case BPF_TRACE_RAW_TP:
>> +               case BPF_MODIFY_RETURN:
>> +                       return 0;
>> +               default:
>> +                       return -ENOTSUPP;
>> +               }
>> +
>> +               break;
>> +       case BPF_PROG_TYPE_EXT:
>> +               /* freplace program can return anything as its return value
>> +                * depends on the to-be-replaced kernel func or bpf program.
>> +                */
>>          default:
>>                  return 0;
>>          }
>> --
>> 2.24.1
>>
