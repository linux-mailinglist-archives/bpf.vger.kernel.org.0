Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C23FDEE0
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbhIAPmu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 11:42:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244935AbhIAPmu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Sep 2021 11:42:50 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 181FXVJN001263;
        Wed, 1 Sep 2021 08:41:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=MWHdAMf8ohFBxrc1s26Lqb37DR3Z3gNXqRyJ9Vjs/7s=;
 b=mWwiFc5eWxCbPMLrdssMuJ5SfSx/fI1IiOSmz/JVZ4IQJVCRYgvc8dX0JZ0HlUPS32Fl
 wUMndcIuimZivAOPI5AKKl8GHDSVjT47jSsYP21cVPK3J124d3N8ALSXDrx0ccJDtKKv
 1aMjqkILw19KTjCU16OVQcKl6ZEBF4i+zqo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3assekae8b-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Sep 2021 08:41:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 1 Sep 2021 08:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGjY8fyCParjKH+ImkGtpZrGGqZI3k7IJ/39DXtE8b8I91loCUXM39yJFVnK4zfamJaUi72v3l+Ewv5qphaxoFCD8N+h0PET4Zqi+b47AVNl8ccFrCpGoP3xhmkzW/+qah3H0izw0RtHvgD6eGeRNAHxYat/PQ7UTxtCEY6b9zpEsuf31pjNeGPZbZ8VObEFZjq0ZXgFM/zY8iu1AyOfwvBxQ5ABQ+6v94hsIhm24x55tblf1jXKsYuUsfe6ZGwgQGgjWoMdC6zW4iAQ5EgxFYje8CSZYm6u2jX9uRWqoQj/WPssxlBYJV2yVGcnCqsX56XtUFkdilUaN9ubOfMb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MWHdAMf8ohFBxrc1s26Lqb37DR3Z3gNXqRyJ9Vjs/7s=;
 b=ISIy+PzFC+ZEKRhV4vnZDPUtfUZfFQV9ir3fpEHwMM6E2GYsyCCnwmPd2Roi5K+uuB/gwExnvk3QRHXn7X+jYlMvhDxaC0SOtSXOhYLSIOORBTb/aKHE4LtaRrMoVxZdqw7PyIegImWMc64vs/8dQtfbq91mpEioQ5nkmRP8sJqNulls6ctUrkBIOz+h8x3GwLHIPZUuo/8d1ncoDczsbfM1NhUQuqYoGkG06qZB7bFTbclDViGSyd57k8ijp4YL/Am7hFZ/2gWD/q3eWOLmsu0XRzkKx8Qvx70ACNt800tKAQ2pHkEByEnspZUBzPxNhTGhAaRBckwVuibct5Wwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5111.namprd15.prod.outlook.com (2603:10b6:806:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 15:41:48 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%7]) with mapi id 15.20.4478.017; Wed, 1 Sep 2021
 15:41:48 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Thread-Topic: [PATCH v4 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Thread-Index: AQHXnslLqg0okkw0sUSYXhRhs4rqnKuOjtaAgADDVoA=
Date:   Wed, 1 Sep 2021 15:41:48 +0000
Message-ID: <0B76C4B1-F113-41F4-A141-163A2A71F4B8@fb.com>
References: <20210901003517.3953145-1-songliubraving@fb.com>
 <20210901003517.3953145-3-songliubraving@fb.com>
 <CAEf4BzaPuPJKnVJ+Bi4aNs57A2x0jRnM3V-ud37U6V=wThHAYQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaPuPJKnVJ+Bi4aNs57A2x0jRnM3V-ud37U6V=wThHAYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01f867bb-577f-4c6f-0cf3-08d96d5f02da
x-ms-traffictypediagnostic: SA1PR15MB5111:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB511160884D0CFD6D83D71842B3CD9@SA1PR15MB5111.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8Duhjdy5+aNU9e4i8nE1j4CgPxyR57aonTelbsn+cvU+H7CahCbVrvD57Nnhxhs+fRaA+6pO5u/LuDGduGhUkwL6MYAFvEMl7+ZMkDPR8qs23l+CVTEQEWP/OkvFeJ6db5YrM7YglCrtzWIS/ME8nGAmrDuqalfmq1m8+dhnXqv/4Ebs6URDLont5053Kr5ZBoQYGDt6V3lbFHk9xm/JKfXH4ktGVceWNgLPU61bmcK31GXlrn9d7z3t8xIfm/4ONOW3gWfOv31So1ZiCpB2EuBpiUJa7vCDq2QGfKhlni2+IL2YHFa0/vGOf8gWZXxifXyyL63kjcgUwWh03/LlBDpzByDHHq+wbf9is0IhG3E8+DovHKlK/Y3Rc1Oft7hemiujiD/D+6+4pQoMs6l9zMdunElXOMFqeHf2lzIo8L+wpwzAq+tEOYGzRwB2LMkQB0vgvSmi/J+FAN6l826DOqigIXnGuRpE9AVIx5zQQSvo2mhUcnogPAGoiRgTcgX3bdQkEg/9TO3mgEjtM5Mg9bDtjGho6PTxvJWMjSEhFSNQf3V1+/w4JlP9guGZVVVnpTGsBLStqEAus7W84zWJyheFYosYxuonFDXphw58ZQlpv9kQZ/VT5Y7JjJAYtPiUuUTljrshzkoBvnrHq8vkP+f1r0SusYITPYvjq4+3tF9EfFoCFQIszc33BAhBGobQVJUhxe6S9KBo6FNUl3H4PM/t+rZBbSw3hX8U5Aq0HpZdmEE6pEkrfO6UssbMHCt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(64756008)(66556008)(66946007)(4326008)(66476007)(71200400001)(6506007)(6916009)(91956017)(478600001)(66446008)(76116006)(53546011)(33656002)(2616005)(6512007)(186003)(83380400001)(5660300002)(86362001)(54906003)(8936002)(36756003)(2906002)(8676002)(122000001)(38100700002)(6486002)(316002)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nUEfZF8HNpGmGiLW2HXmL+IpsC95PZ594bmKjxJKLe+BmM5sWjTJqbCPWgDt?=
 =?us-ascii?Q?8XzYtPzqHw7c0jLih8ad+8ixUI7ZYU3aE2T0qEEEncrVZHWRJoE+Qkr3eExd?=
 =?us-ascii?Q?uaGGHR4byfqLh4043mv678UXM3+QdeyUsGjNPKrrjJpVdgBF6dcxUckLq6r4?=
 =?us-ascii?Q?pvox4RY3gmqaJ+ctHF6oz0qdLfIpzN+lhsZ33IQVlOYiT4rIblqzoRBMQGgC?=
 =?us-ascii?Q?u14Ph9/vgfwsA/DwaacJSzzSP3FE75paKmP2XNyQp6CasZtKB0Y6CZbqkzmE?=
 =?us-ascii?Q?OUauOzXpAGjZGcrPjd0JkZOHR9gmON76deIWGBqJAP/NyaLexzImVQlkYyok?=
 =?us-ascii?Q?NJB86bwKW19UXxltRVmJMzAcVRGZTNqinRnizEVvocsR2d/A15lbsKPTGv6q?=
 =?us-ascii?Q?uYO9NhMm7MlhHtpVN0ns1kQ2iT3wSt7gyy/bMsbMQ4zB+r4roiehJ5Pj/LrC?=
 =?us-ascii?Q?SGsCv6BiZ4cWHhsKuouPA8f2qSBFFnofVagYjbkWZvfC+/fnmmB931OOCa8+?=
 =?us-ascii?Q?YdkcYGkL3sP1zpgY8+iSH0J8yuCHlib2KE9ztwvSx5Z8+3nOEAvxiueVYRaS?=
 =?us-ascii?Q?gZvtgWk4ZhPsk28YLJJmbkBe4/O0hDsJ0qPkKvurfW+C1ZZS3EzWO9V4ArdF?=
 =?us-ascii?Q?n6obOXnmgzrQUTrzBLtWU+VVpRf4ne64egYYekTili00w4OFmqiCTZPCIfTk?=
 =?us-ascii?Q?g5Z+QYJme+fH4TuRI1r9k5GlYpS3vEb5p7aiDTwRyYQUhZ1+H1QvdXvfjStA?=
 =?us-ascii?Q?161Vk9cUGQq8oXvbIiQ3iiT4XlteqjnFp1DYzPgem+aVM+LuCKXgPqK4+xGj?=
 =?us-ascii?Q?Be6e6UQb5bnvaRobEJumoRcNHMxWQhLoyot/j8fLSxfUSv9wlx+EA+9pWO5h?=
 =?us-ascii?Q?zsreiuRo7qftj78sIJRLSg7j14dyk+vNTItbcP3OlGnwWwIm2yqpiJbhoZgN?=
 =?us-ascii?Q?SGwHnbA2+zPYeMwd0jQ2oZcifyCZbWJQ11bfAW7TySt2tsxyrmQc17CRVlXj?=
 =?us-ascii?Q?6uHW8EwL3cZDS1lj1f8zjiysH3CV4b2KGuUH1O6XHYGbVWSOezvjj3QfAR/q?=
 =?us-ascii?Q?tcOlyJ6LEHGKBFosEyEXIIAH1Dj2um2h62XW3ZdTdBTuUfb+B+OPKOpcktGs?=
 =?us-ascii?Q?eL/Yny4JYJDXB9pogofxmpwrfSzgaqy8LC6PtsW/5IYsw1kZ7h5OCUhpikhl?=
 =?us-ascii?Q?LTWrLCSxdPyq1/21GForghs/HY3xuiX1froeaCVou8yf7XlKlOQMTz1HS5uM?=
 =?us-ascii?Q?tqGdI8ttfBKDotWTp9m7UFarSHETjLSZ5TJK16bXEH10/ucOGemW+Xit7bR0?=
 =?us-ascii?Q?fGC0fF9EfCIaY+74wrLQ1gC3Bog9ul3DylxdCx6jeXgt7CzlTyuilULfNrtU?=
 =?us-ascii?Q?9usPd7s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B358B7C882A62D4A87B0E5122EEAD176@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f867bb-577f-4c6f-0cf3-08d96d5f02da
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 15:41:48.6422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SmiyMdTNyLIfz5yL7/zlsRYLGXElqleX7Y1C/K8VqUh8d48568RNcw1rP5XNqmTNjKfW/QABygIirQzXdZfPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5111
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: gNNGnY2VL7i1nJV53iVrTwYWGX6T02sZ
X-Proofpoint-GUID: gNNGnY2VL7i1nJV53iVrTwYWGX6T02sZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_05:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 31, 2021, at 9:02 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> On Tue, Aug 31, 2021 at 7:01 PM Song Liu <songliubraving@fb.com> wrote:
>> 
>> Introduce bpf_get_branch_snapshot(), which allows tracing pogram to get
>> branch trace from hardware (e.g. Intel LBR). To use the feature, the
>> user need to create perf_event with proper branch_record filtering
>> on each cpu, and then calls bpf_get_branch_snapshot in the bpf function.
>> On Intel CPUs, VLBR event (raw event 0x1b00) can be use for this.
>> 
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> include/uapi/linux/bpf.h       | 22 +++++++++++++++++++
>> kernel/bpf/trampoline.c        |  3 ++-
>> kernel/trace/bpf_trace.c       | 40 ++++++++++++++++++++++++++++++++++
>> tools/include/uapi/linux/bpf.h | 22 +++++++++++++++++++
>> 4 files changed, 86 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 791f31dd0abee..c986e6fad5bc0 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -4877,6 +4877,27 @@ union bpf_attr {
>>  *             Get the struct pt_regs associated with **task**.
>>  *     Return
>>  *             A pointer to struct pt_regs.
>> + *
>> + * long bpf_get_branch_snapshot(void *entries, u32 size, u64 flags)
>> + *     Description
>> + *             Get branch trace from hardware engines like Intel LBR. The
>> + *             branch trace is taken soon after the trigger point of the
>> + *             BPF program, so it may contain some entries after the
>> + *             trigger point. The user need to filter these entries
>> + *             accordingly.
>> + *
>> + *             The data is stored as struct perf_branch_entry into output
>> + *             buffer *entries*. *size* is the size of *entries* in bytes.
>> + *             *flags* is reserved for now and must be zero.
>> + *
>> + *     Return
>> + *             On success, number of bytes written to *buf*. On error, a
>> + *             negative value.
>> + *
>> + *             **-EINVAL** if arguments invalid or **size** not a multiple
>> + *             of **sizeof**\ (**struct perf_branch_entry**\ ).
>> + *
>> + *             **-ENOENT** if architecture does not support branch records.
>>  */
>> #define __BPF_FUNC_MAPPER(FN)          \
>>        FN(unspec),                     \
>> @@ -5055,6 +5076,7 @@ union bpf_attr {
>>        FN(get_func_ip),                \
>>        FN(get_attach_cookie),          \
>>        FN(task_pt_regs),               \
>> +       FN(get_branch_snapshot),        \
>>        /* */
>> 
>> /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> index fe1e857324e66..39eaaff81953d 100644
>> --- a/kernel/bpf/trampoline.c
>> +++ b/kernel/bpf/trampoline.c
>> @@ -10,6 +10,7 @@
>> #include <linux/rcupdate_trace.h>
>> #include <linux/rcupdate_wait.h>
>> #include <linux/module.h>
>> +#include <linux/static_call.h>
>> 
>> /* dummy _ops. The verifier will operate on target program's ops. */
>> const struct bpf_verifier_ops bpf_extension_verifier_ops = {
>> @@ -526,7 +527,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
>> }
>> 
>> #define NO_START_TIME 1
>> -static u64 notrace bpf_prog_start_time(void)
>> +static __always_inline u64 notrace bpf_prog_start_time(void)
>> {
>>        u64 start = NO_START_TIME;
>> 
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 8e2eb950aa829..a8ec3634a3329 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -1017,6 +1017,44 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_pe = {
>>        .arg1_type      = ARG_PTR_TO_CTX,
>> };
>> 
>> +static DEFINE_PER_CPU(struct perf_branch_snapshot, bpf_perf_branch_snapshot);
>> +
>> +BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
>> +{
>> +#ifndef CONFIG_X86
>> +       return -ENOENT;
> 
> nit: -EOPNOTSUPP probably makes more sense for this?

I had -EOPNOTSUPP in earlier version. But bpf_read_branch_records uses
-ENOENT, so I updated here in v4. I guess -ENOENT also makes sense? I 
won't insist if you think -EOPNOTSUPP is better.  

> 
>> +#else
>> +       static const u32 br_entry_size = sizeof(struct perf_branch_entry);
>> +       u32 to_copy;
>> +
>> +       if (unlikely(flags))
>> +               return -EINVAL;
>> +
>> +       if (!buf || (size % br_entry_size != 0))
>> +               return -EINVAL;
>> +
>> +       static_call(perf_snapshot_branch_stack)(this_cpu_ptr(&bpf_perf_branch_snapshot));
> 
> First, you have four this_cpu_ptr(&bpf_perf_branch_snapshot)
> invocations in this function, probably cleaner to store the pointer in
> local variable?
> 
> But second, this still has the reentrancy problem, right? And further,
> we copy the same LBR data twice (to per-cpu buffer and into
> user-provided destination).
> 
> What if we change perf_snapshot_branch_stack signature to this:
> 
> int perf_snapshot_branch_stack(struct perf_branch_entry *entries, int
> max_nr_entries);
> 
> with the semantics that it will copy only min(max_nr_entreis,
> PERF_MAX_BRANCH_RECORDS) * sizeof(struct perf_branch_entry) bytes.
> That way we can copy directly into a user-provided buffer with no
> per-cpu storage. Of course, perf_snapshot_branch_stack will return
> number of entries copied, either as return result, or if static calls
> don't support that, as another int *nr_entries output argument.

I like this idea. Once we get feedback from Peter, I will change this 
in v5. 

Thanks,
Song

