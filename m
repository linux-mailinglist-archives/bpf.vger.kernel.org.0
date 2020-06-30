Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3980F20FD7B
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgF3UNl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 16:13:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgF3UNk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 16:13:40 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UK6VOL013510;
        Tue, 30 Jun 2020 13:13:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fn/bIP3WaMJOiWQrsZuljBWDPJCwSAMCEheqyHgnxLI=;
 b=TZ6P1UTuI5VpKSfHjEB1wIFbZvISUFzN07x5NHeSEGYi/x5MoP1aTGCbADDtcjxwtjQ7
 1dd77k/u7R7o700hpwrxzJqU4q1pA2MB+wB4+YF3FbSLq+MAvk/XBVXX4/Ox69c0n+LK
 2jOZYH55eq3gmW/rWil3P5of2hJfeMwHi9M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 320bcdr86k-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jun 2020 13:13:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 13:13:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjuJXcBAAoSc9F3Hxf6vuHdsedYKRYjGwY27VKbbGCw9W18jAPZPDWMryBojrUucSh7c4kirP/iddMNHNc7Z02T59kriXMfhz6BmJwDTB1ZRMOtTDzNR2S3HAUg2N6ybsKynIUb1+sweAfZuw6sBrzdgAs0KhUNZFWEhvqURgoe4ZkxkBRA4lViJlvOTxFQz+9Ds00xq5iXK2W9XJ1tIxP4IF/xqio42GofspX914WUClNOrVJLBARMc6UonAbkSdOFxpwai7n1lO+VH8KhJ3hQc84hI/xhMuSakoZ4QzBXgn5Ah0EqxkbNfgxfdqHpdcbOG3FdGzd1/1rwwvPWjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn/bIP3WaMJOiWQrsZuljBWDPJCwSAMCEheqyHgnxLI=;
 b=eVG9t2aRqNg4D4Kk/QRHYJoHsNcDQ8kqMoNCxncteXaQL2caOcf5Z3RjVtDf6dsE1+IUscS6xSymTrHxGaqTHavq1vHH4ki/OeF1jNYIppUUPxjQSQw91A0xWbRdMwVhU3r6yeXGxJzHs2RJZsWQkt2ZR06+Gaw074gdXpf9+VBnK/Le5zc9GXVFrqPJb0TxfQEzfOKYJhERAeQmlLwUdmlSZZPymjNcgtZ6D2dlRCtERYtf6kN1bhxmV2wDMsAobDg+GlYqhN24YjMIyCk9r6YsROeK2zfmfG2wQ4eTqya/9T6mfX1+KaS0GKP4k+Qs+lM/6lcJjPVu3buIo53RlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn/bIP3WaMJOiWQrsZuljBWDPJCwSAMCEheqyHgnxLI=;
 b=jKIPXE19S3YcVQHDblTFVaJHF4qh48qValjM9QSHBRht+mesBnOlXYA5G3MUMYi1ivEqoYX5XOAqnLzk5W/hLdgO4YjHP2u5xVyZKJrQhB/1L0iYsdwCAJ0x5/30LFPGPuKEJEbA08vARhmKoNAoeIk6QXCYTo3BNiU5YAgYOeU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2822.namprd15.prod.outlook.com (2603:10b6:a03:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 30 Jun
 2020 20:13:08 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 20:13:08 +0000
Subject: Re: [PATCH bpf 2/2] bpf: add tests for PTR_TO_BTF_ID vs. null
 comparison
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>
References: <20200630171240.2523628-1-yhs@fb.com>
 <20200630171241.2523875-1-yhs@fb.com>
 <CAEf4BzbfKWaJH3i3+L1kc79zytO1xAhFCiF-4bPd6dqBPA+SSQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e82ee7e3-3ee8-dc0a-b33c-fb3250898459@fb.com>
Date:   Tue, 30 Jun 2020 13:13:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <CAEf4BzbfKWaJH3i3+L1kc79zytO1xAhFCiF-4bPd6dqBPA+SSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::15c2] (2620:10d:c090:400::5:d269) by BYAPR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:40::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Tue, 30 Jun 2020 20:13:07 +0000
X-Originating-IP: [2620:10d:c090:400::5:d269]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b894881-2f18-4956-9fe7-08d81d320166
X-MS-TrafficTypeDiagnostic: BYAPR15MB2822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2822AA4F80C54CD40FAEEB7ED36F0@BYAPR15MB2822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wo+1dIZrJu5tZMhcPFGmG3nQVAlPf0GblZCUxfbisOs6bHl+Qklq7lUazvOm7Zy7/IIbo+jxYTaGnPj0hhiAuAnQbZ21kns2li0QuHUv56DaEH2u1+fddML/shn1EdnNWUecyUYBrcVSuY/Bd6U9BKgxG8Aq5+3zcrxRSlWEJMC4OJm9BcnXLO6fOTYSWjE4AFxtmS6Q+Cjyjt5GjaXol4YF5EvE3g3tgT2gxxtA8/0jevJrqA1VmH2UpbXU1c5czwojGjMZvTHNVtA4CbESI3TEZrzld4hCas62mx+iCwHJouyktsy6v2i5EgC6T7IVTyaCMBTYmab8QZTaelJXCq9Asekt7wkaFH4mjtNTcv87Tbb3MDnOKjb4leK4icxj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(136003)(396003)(376002)(346002)(4326008)(53546011)(36756003)(31686004)(2616005)(478600001)(8936002)(52116002)(6916009)(66556008)(66476007)(66946007)(54906003)(2906002)(186003)(8676002)(31696002)(6486002)(83380400001)(316002)(16526019)(86362001)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: O5bwaFnnISyMfisqvFtTsR2eFQO8jlJdKMxaHi5GWPNVrjypOxKVU6oEjTwkA4I2xMnLzg3lp2LFfj41oysGzOX8tvVXrsZRE449ENUiIuyrg3D3YdKW6q5+M8jKEeuR/QIRmBVHxLiYp+F8X5PMOkdwDfU91dV+L5Djy+Mxnnxbn9+hWo25FX1oSdMJulWXLROQIpO45fG+2kF8wASrdPQ1UYAsZ9fEidNZNo6GcPY5UsdBIpuS/EXVE9VS19vWfIP06EuyyX6QgkzZeNQxSjyKNSKGIpLGEjQEmxIdWrgSA0JwKtC5+F8Dkq0dUz5QjxEz8ORvL98VjnPcaRZSF1VosSi6kL4baXPpJzMbWHTnETqk1jx7OAPExOHBr5K7MZuJbRHSm4D2ivD1vzRNXCRo0lZ4h0HabtoHMVNO5vlsT9V1q3KWEJB/+LBGFHN0Z43ZDBJDJrWLlrzpWVo6Quh7XUaBzOuayjZsF9Lw4ZnEqZJ2iIqTyJriYU46ye5Gv1we/aaj/Ou7F7fNauahsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b894881-2f18-4956-9fe7-08d81d320166
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 20:13:08.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHaHnKLKoM1PC2u6sfSMTetybKc7LaoYnM/+fq/Kl4eVOWCQFk8BEO4EjCQzqDmc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 cotscore=-2147483648 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300137
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/30/20 12:23 PM, Andrii Nakryiko wrote:
> On Tue, Jun 30, 2020 at 11:46 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add two tests for PTR_TO_BTF_ID vs. null ptr comparison,
>> one for PTR_TO_BTF_ID in the ctx structure and the
>> other for PTR_TO_BTF_ID after one level pointer chasing.
>> In both cases, the test ensures condition is not
>> removed.
>>
>> For example, for this test
>>   struct bpf_fentry_test_t {
>>       struct bpf_fentry_test_t *a;
>>   };
>>   int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>>   {
>>       if (arg == 0)
>>           test7_result = 1;
>>       return 0;
>>   }
>> Before the previous verifier change, we have xlated codes:
>>    int test7(long long unsigned int * ctx):
>>    ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>>       0: (79) r1 = *(u64 *)(r1 +0)
>>    ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>>       1: (b4) w0 = 0
>>       2: (95) exit
>> After the previous verifier change, we have:
>>    int test7(long long unsigned int * ctx):
>>    ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>>       0: (79) r1 = *(u64 *)(r1 +0)
>>    ; if (arg == 0)
>>       1: (55) if r1 != 0x0 goto pc+4
>>    ; test7_result = 1;
>>       2: (18) r1 = map[id:6][0]+48
>>       4: (b7) r2 = 1
>>       5: (7b) *(u64 *)(r1 +0) = r2
>>    ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>>       6: (b4) w0 = 0
>>       7: (95) exit
>>
>> Cc: Andrii Nakryiko <andriin@fb.com>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Cc: Wenbo Zhang <ethercflow@gmail.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> LGTM, two nits below.
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
>>   net/bpf/test_run.c                            | 19 +++++++++++++++-
>>   .../selftests/bpf/prog_tests/fentry_fexit.c   |  2 +-
>>   .../testing/selftests/bpf/progs/fentry_test.c | 22 +++++++++++++++++++
>>   .../testing/selftests/bpf/progs/fexit_test.c  | 22 +++++++++++++++++++
>>   4 files changed, 63 insertions(+), 2 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/progs/fentry_test.c b/tools/testing/selftests/bpf/progs/fentry_test.c
>> index 9365b686f84b..5f645fdaba6f 100644
>> --- a/tools/testing/selftests/bpf/progs/fentry_test.c
>> +++ b/tools/testing/selftests/bpf/progs/fentry_test.c
>> @@ -55,3 +55,25 @@ int BPF_PROG(test6, __u64 a, void *b, short c, int d, void * e, __u64 f)
>>                  e == (void *)20 && f == 21;
>>          return 0;
>>   }
>> +
>> +struct bpf_fentry_test_t {
>> +       struct bpf_fentry_test_t *a;
>> +};
> 
> nit: __attribute__((preserve_access_index)) ?

Yes. Why not. Will send a followup once the patch circulates back to 
bpf-next.

> 
>> +
>> +__u64 test7_result = 0;
>> +SEC("fentry/bpf_fentry_test7")
>> +int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>> +{
>> +       if (arg == 0)
>> +               test7_result = 1;
>> +       return 0;
>> +}
>> +
[...]
