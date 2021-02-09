Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4A831491B
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 07:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhBIGv0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 01:51:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52970 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229464AbhBIGvZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 01:51:25 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1196hiGd008917;
        Mon, 8 Feb 2021 22:50:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cM1btXFFJPV25pCpFaq+HTAGyU3qseMY1xRXwGMSi54=;
 b=exfiavebUfVGgq9GzSXs4IGVzyAWkruYDR4YDAz7A36+a7k1G1Ag71y+5dLRfLqBFiH1
 F5Ft2QyfI16Cc0+XmCWLsPuqsqy9YN8cTpu7Iq64BOIfcLbtRvcgWY2N2c8eIqe+ZGBK
 OKyK2ZoZCNVggQDv/hZe4Kl00hW6Q4c9a5c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 36hqntcdkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 22:50:31 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 22:50:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8TEAPr+YrICNEDwcumIhdsMMGtvux1d1ZzgeVK/e7M3i6mB/KiYe2j4HV5cOw+IiF1tJ26bmwhh/hsvWuZpehecd4fQa+J2EvZ60MvKh3twIRAeYYEDWtGBZQm86EqHazqh6FpMZEHiOf/nnH7cnC+r2O2GQWMKazlF6lsSUpcx++tkf3CGN5rfQ5cLYvULfv4iiEzX0mqflpkXU62Jw2ORRanzwhu93YfBJO9MJ6DpLlZNkXIJYrkHG0wXydCPzXPcfIcpPJk0fmZZ2jCBXpFdbk5nuprs1fbJ1QZilVyHGLd2vXN4gBgj5h6DlAEPE4juGpTlrk6+Uv68xfPcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM1btXFFJPV25pCpFaq+HTAGyU3qseMY1xRXwGMSi54=;
 b=Xgrb5vZjk2+v4LqgZJ/C9Q5bOwl23iiyXk53/ciGhDLwRNNuPRO3saUf5exR8M7/WRzokb3pelOhzLFSaiEY4/b5AGuAknM1SnSd6s24TaGVx1UdzahtcL8E0RQEHoCJfs3QQYbHZtjoIYTbt/hV6BMOOnRtyKOnTv+vW0SSTnLso3UnZKp7lB3UIajnbTrMAGGdlNtR66xcLN1H6c2ey3I+W0BSiiyZ4rpzuz8m/qIKg62ibNLQPCHa2/wVKPT4J1F5rQPfz+lqwDZaJmoMGxye+hr02XyU/LTSzY/aMrzf+g8tnNt+sBiB9bTaTn/f/0/pYFPFlHxOg4Uq/2S3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM1btXFFJPV25pCpFaq+HTAGyU3qseMY1xRXwGMSi54=;
 b=Usghz2e7srlQPNtM5R24y0QoF73L/sfI+YHRukVGbg0M3ffyJXwTGSCIviPkmzlbcR97sPyQC8QU7SI0Hu07f79InK4hkwu/Hu4HzTmjSqFBJcWbq8+re+KDmtSUHHc9K7k8woeLdiXJOuJDAiy/mjXG7ceBMtYZWuVvXjBodr8=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2696.namprd15.prod.outlook.com (2603:10b6:a03:156::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 06:50:28 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 06:50:28 +0000
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: add arraymap test for
 bpf_for_each_map_elem() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
 <20210204234836.1629791-1-yhs@fb.com>
 <CAEf4BzZoLT1vtS--mfZ4XJQ-HRwhbY3pxzN-2xci9FUkPqRwqg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b2c9f636-c2c2-52fe-1e4c-127dd32084eb@fb.com>
Date:   Mon, 8 Feb 2021 22:50:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4BzZoLT1vtS--mfZ4XJQ-HRwhbY3pxzN-2xci9FUkPqRwqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:e222]
X-ClientProxiedBy: MWHPR21CA0061.namprd21.prod.outlook.com
 (2603:10b6:300:db::23) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1610] (2620:10d:c090:400::5:e222) by MWHPR21CA0061.namprd21.prod.outlook.com (2603:10b6:300:db::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.0 via Frontend Transport; Tue, 9 Feb 2021 06:50:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c32299c2-6312-4c83-84ac-08d8ccc6fc59
X-MS-TrafficTypeDiagnostic: BYAPR15MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2696C5A783F7A5029AADC850D38E9@BYAPR15MB2696.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:144;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okUYPmZsdc0f3kIO4Pq59acePbD0JTh448nG2dAwzbxGLR71obdpOaCkSRdzu6NutIXRSUS4BJ++75HPzgGDCrMBgN6koAhBlBzhGahFuFJg8fuOPTbEXy8v9E+lnLHhN24cThQsuniwoGKp4twtifuWsIcDkiKXoWmegyPZgASQJPY5RbkvoavCym4G/oFhKPtMoSFDlcfjPD5Ja5pUsc4enTGFMcHheQ5NfxRyFTokJS4il+Qw64aGaDvD1l8gwwzbicJioqJMt+iQAO0dI6k1vvf+ZKASLt9+AhS7MjdCZJhCtFZp5AenXKyJqJ97NzpOnvq4R+WAiKcgshqTGef/w2nY+rbEHVt5KfrKwEOIxjIoCieWLEWH/qrhguVAhRHr+YrCqn8G4eUzuIXA2iPV/Nn7saExfNDdH6hyG4L/GOsLlrNl/FPHmQeE3CqYJbidgh9eXFB9bL+KOGMiFWBKGupEdF78ddmgQGBzgwwe3opsS46Oo1opTx4wk5HSL9/k5ygd8WkKSDS5ojkWvXFOJw2Gfs+D0aRsl1+izzOcBMNlUxMbbw2/KtiyBukFmnxUD27hsNk14eQ4LwefGjOCDWdODV2YSew+FZ4sPZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(366004)(346002)(6916009)(5660300002)(4326008)(2906002)(86362001)(16526019)(186003)(478600001)(8936002)(31696002)(36756003)(83380400001)(6486002)(316002)(54906003)(2616005)(53546011)(66556008)(52116002)(66476007)(66946007)(31686004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MGNxdC8zWFkxVWtQK3F6dWdDWlFiT3ZNeiszYnlPMDRaNnRTQ0EwYXY5T0lF?=
 =?utf-8?B?K0tXK2lSbUpGa0o5LytBOVM0QTFSdW5nSTREdWlHNHpjUTVuVE9vTUtnY3Bz?=
 =?utf-8?B?T1FMQ3pHak41V3V5WW9DWEc3MG9UYyszZFNhamVqdkhubHVoZXVFSU04RUtV?=
 =?utf-8?B?cjhPaStMeHByNDhMNjhNWit4b2tHRm1rZDV5eklRLzA2VFNOVUlGL3E0c1o0?=
 =?utf-8?B?c1NQQ0F4VUZ4TXZJbGdFSDhXeHhMQWkvR0NIM2IrZHgvZzdpa0RHakp3dkgx?=
 =?utf-8?B?bmQyV2pidlJiN3JOV1NyRTFUZkVnYllJWWpDdEZ2enFOeW9zRW9MWko0WnNo?=
 =?utf-8?B?eTl1YzJsbkdSc1dGLzNYdHdrdUE1ajJmOTNQcjV1QzJGK1I3UzF4NkdVQW9F?=
 =?utf-8?B?N1B2eE5Sa3U2TGFTb3VaUk8rbjdVaWtuQ0xYQmFvS3o3RTM0WW1rZGMzd3dK?=
 =?utf-8?B?aDVTTllwUUhTR1o1SGtlQUdOMS82TXJSWWJhVEV5Y2RSWGVzN0JLQk5TM2Fs?=
 =?utf-8?B?b0lPaHRldGc2bGlxcWtrK3IxbTZaYjFsWHpHQk5xNTN3ZEd4RytRemxMSDE4?=
 =?utf-8?B?SE5vV0lXQktudDExMmx0M3ZYTVA1TUNjZkp2SGNNYUZSTStCNVRJRXUvaFpY?=
 =?utf-8?B?WGQxdU42RWVJZ2hRVUpWY1A5MHVUeEZVNVdrWi9RRTJMZUFsSzdHdmdwd01p?=
 =?utf-8?B?YjhTRkRGd1dYbFpKUG0zRzhxakNKZHNDbkZHSWwweE40MXhPZ1QwQ2sxUmdU?=
 =?utf-8?B?a0lzdVRuWXRrWk9CdC83YUNUOEJCSDY1ZHZOZTFiSWVaME12L1gzQlRaSGFM?=
 =?utf-8?B?eEFUUkM1a0VvdzhqbzdJT0JxZ1RrRzRneE1PWUZPL0lZL3BmUUZCNGZoUEd2?=
 =?utf-8?B?ZFNxWmFqWGJjN0Zhd1JzSmEzWmdycTlmUTVjZUNjRlNhSFZvSVRIZkRwMTUv?=
 =?utf-8?B?dEdZb2w3enFUOHFycE1mL1dja0pZcUVETzdxUjNnY2loV2tmaWduQnM1cElU?=
 =?utf-8?B?WlFzcGk5VG5xNXlqaXpFRnRubzE1WVJFbXNlSzdJZGN6ajZ1LzZiN1hEOWRn?=
 =?utf-8?B?WkMrZmszWkZuMzh5a051QUt2VVlPVDYya3hWdm5rNEI3cXNxODdzWjdibnFN?=
 =?utf-8?B?NzlUVnBLRG9IWXVUVnE1SXdUYndKWXRBS2NNV1lSRzJ3Z0ZCVGwyWklPaXJm?=
 =?utf-8?B?SHNZS1ppY0xUZVE5cElYdTVhMm40dzBXejhrYU1Bb3dqWjAvaUVMWnhOVEpI?=
 =?utf-8?B?UC9CZDFrZzNuTy9ndTJjdkM1RWpNZGVCZTZSamhwSG9xcnJhMS91QkFyTkxR?=
 =?utf-8?B?bzRYczEyWUhKZ011ZUlFZnhXYW5PelRsdGs0Uzl0djJSbnJqSXRsbVo0OU1Z?=
 =?utf-8?B?TGVlU0EzSm1JZnJmajV4ZGExSEdhRDdkbmhTOWFGL3JhTS9USWhXMzBSSXRK?=
 =?utf-8?B?ZVRmRWdWQURoakhwZzhYaUJXaFFjdmJ4OHZSeXFuZ3A2TEpOWEdUdG1RdVdM?=
 =?utf-8?B?YmZ0YzhEa2s1Y2RiVGV6UEFST2V5TFVtNlhSV3laWUtqK1pzSW82MUh0T0dl?=
 =?utf-8?B?NklmeVRLKytvT083a1FzNkl4UFlYdnJ0S0QxRGxtbXc5UzRJd3IwTUphcWxr?=
 =?utf-8?B?TzVoaFROS2lYelNVRWg2SEpMcUN3cVNVMWdJMFdqWmtaQmlIVk1QTnMwNW1Z?=
 =?utf-8?B?SW9mUFpIdGhpRXA4NUFjVUxZcVc5TTRORXZHR3ppQkgrZkVFc3Vacm1GQXJk?=
 =?utf-8?B?ZDMwN0YzTHNwbzBKTnJuYWZub25YQ2trdVlNWmJOSTlUMnRLS2NaRnp0YWIy?=
 =?utf-8?Q?VTjywftltQmSenfxqUNJ7v1+tb3bCC1R6kB3M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c32299c2-6312-4c83-84ac-08d8ccc6fc59
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 06:50:28.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAgXGco+eOh13I74P4BlNYYYWPAwX0mNlUWnkpGmfQXuaS+Tq8JcEU7Q0o7zU3AS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2696
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_02:2021-02-08,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/21 10:35 AM, Andrii Nakryiko wrote:
> On Thu, Feb 4, 2021 at 5:53 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> A test is added for arraymap and percpu arraymap. The test also
>> exercises the early return for the helper which does not
>> traverse all elements.
>>      $ ./test_progs -n 44
>>      #44/1 hash_map:OK
>>      #44/2 array_map:OK
>>      #44 for_each:OK
>>      Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../selftests/bpf/prog_tests/for_each.c       | 54 ++++++++++++++
>>   .../bpf/progs/for_each_array_map_elem.c       | 71 +++++++++++++++++++
>>   2 files changed, 125 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/for_each_array_map_elem.c
>>
> 
> [...]
> 
>> +
>> +       arraymap_fd = bpf_map__fd(skel->maps.arraymap);
>> +       expected_total = 0;
>> +       max_entries = bpf_map__max_entries(skel->maps.arraymap);
>> +       for (i = 0; i < max_entries; i++) {
>> +               key = i;
>> +               val = i + 1;
>> +               /* skip the last iteration for expected total */
>> +               if (i != max_entries - 1)
>> +                       expected_total += val;
>> +               err = bpf_map_update_elem(arraymap_fd, &key, &val, BPF_ANY);
>> +               if (CHECK(err, "map_update", "map_update failed\n"))
>> +                       goto out;
>> +       }
>> +
>> +       num_cpus = bpf_num_possible_cpus();
>> +        percpu_map_fd = bpf_map__fd(skel->maps.percpu_map);
> 
> formatting is off, please check with checkfile.pl

Sure. will do.

> 
> 
>> +        percpu_valbuf = malloc(sizeof(__u64) * num_cpus);
>> +        if (CHECK_FAIL(!percpu_valbuf))
> 
> please don't use CHECK_FAIL, ASSERT_PTR_OK would work nicely here

Okay.

> 
>> +                goto out;
>> +
>> +       key = 0;
>> +        for (i = 0; i < num_cpus; i++)
>> +                percpu_valbuf[i] = i + 1;
>> +       err = bpf_map_update_elem(percpu_map_fd, &key, percpu_valbuf, BPF_ANY);
>> +       if (CHECK(err, "percpu_map_update", "map_update failed\n"))
>> +               goto out;
>> +
>> +       do_dummy_read(skel->progs.dump_task);
> 
> see previous patch, iter/tasks seems like an overkill for these tests

Yes, will use bpf_prog_test_run() in v2.

> 
>> +
>> +       ASSERT_EQ(skel->bss->called, 1, "called");
>> +       ASSERT_EQ(skel->bss->arraymap_output, expected_total, "array_output");
>> +       ASSERT_EQ(skel->bss->cpu + 1, skel->bss->percpu_val, "percpu_val");
>> +
>> +out:
>> +       free(percpu_valbuf);
>> +       for_each_array_map_elem__destroy(skel);
>> +}
>> +
> 
> [...]
> 
>> +SEC("iter/task")
>> +int dump_task(struct bpf_iter__task *ctx)
>> +{
>> +       struct seq_file *seq =  ctx->meta->seq;
>> +       struct task_struct *task = ctx->task;
>> +       struct callback_ctx data;
>> +
>> +       /* only call once */
>> +       if (called > 0)
>> +               return 0;
>> +
>> +       called++;
>> +
>> +       data.output = 0;
>> +       bpf_for_each_map_elem(&arraymap, check_array_elem, &data, 0);
>> +       arraymap_output = data.output;
>> +
>> +       bpf_for_each_map_elem(&percpu_map, check_percpu_elem, 0, 0);
> 
> nit: NULL, 0 ?

We do not NULL defined in vmlinux.h or bpf_helpers.h. Hence I am using
0, I should at least use (void *)0 here, I think.

> 
>> +
>> +       return 0;
>> +}
>> --
>> 2.24.1
>>
