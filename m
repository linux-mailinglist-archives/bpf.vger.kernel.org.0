Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB133FDEE9
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbhIAPo7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 11:44:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31864 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244434AbhIAPo6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Sep 2021 11:44:58 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 181Fek9j020519;
        Wed, 1 Sep 2021 08:44:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=VoYz3Oy0nvjxL24Xka9WQ8ch1TspLHWJikmdyB1Z3hM=;
 b=VPJiLvtdxGmhwl6WRCDlVwOvqx8Bl0Euyq5UJlGXkgNlNQSM4YZoI3xxGnX+IaEpcp+R
 p4LqLJQTZUsz5N3rSfR3SGXKr6Ovf65zaBxHcjpj5MTLznC3iE962tpbOmeqBSfU+oPp
 MlpRzDSE09sf7wAzsuvTJZEQPzaPorTQjh4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3asuxupr1v-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Sep 2021 08:44:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 1 Sep 2021 08:44:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/xMEH1n6by+9EMqP9U8nxoaYBhZagvujY8BRIAXzU5dUAXAH/S0pESq5gYiTdbxWHzh37mpm/Ix1zKUSaQsVtL07Bp8LY/hIpVVE4t98xzWswE2o8LFygG9A6YaStBJgd14scrujOwdT8vMHIY0whAXfWiHfuWFB61+FIvPWntFu1INPHavFaWwF8Nd+ESlei+wwktFVXS65vT5rqjjQbB5ojFH3Axp+qUpN25vUihYmo8jSujE5Q1XObQl/MydKLVOLtW9gnlgJ4BKeacewpRq2wCp+FdBzMZfrvV6jAcG9DS97s4CfB6XdPUapsMrKqFmT4bqnEK+IqPtbQ72Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VoYz3Oy0nvjxL24Xka9WQ8ch1TspLHWJikmdyB1Z3hM=;
 b=cxtWIvhem6X+BUcyLB4ElycfhrDYaAzZWum6HlgustoIgELqz5RvLLY8Sy75Eb869Aw/4lyepgopD/8DpjKsAKz3asVdvzY7h4XPskVCXjwhAVoyrSwqy1ZtBiFnkOV8EYfdhkORCyuJtUQek+iezEqPZletg9LEkYRTGJFINVQsGRn8AtIX2SOqw4voNW+FsV9EW3+pOl8RYjOWH0KTgjBRSAQocdRhYWv3fZxfCV6eK3WKsXi1+yDIIq0h6VPGUu0sNpIokrOwSd55DuU1xDy6W3w/IHC9bZdDb7boU2+V1DYIPs5KQDc4pbogonozFBljMRHL213nNw/spnNoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5096.namprd15.prod.outlook.com (2603:10b6:806:1df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 15:43:59 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%7]) with mapi id 15.20.4478.017; Wed, 1 Sep 2021
 15:43:59 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: add test for
 bpf_get_branch_snapshot
Thread-Topic: [PATCH v4 bpf-next 3/3] selftests/bpf: add test for
 bpf_get_branch_snapshot
Thread-Index: AQHXnslOGJvfh6WSokmD54fWNMz0G6uOkIyAgADCPYA=
Date:   Wed, 1 Sep 2021 15:43:59 +0000
Message-ID: <44C43497-13EC-4F05-B15B-40531D5C3852@fb.com>
References: <20210901003517.3953145-1-songliubraving@fb.com>
 <20210901003517.3953145-4-songliubraving@fb.com>
 <CAEf4BzZrEcZFNSH=YDi_NmT2oqaOhmgQvPv0THXKy4haEzBFvQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZrEcZFNSH=YDi_NmT2oqaOhmgQvPv0THXKy4haEzBFvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef6fe033-1c2e-4271-0027-08d96d5f50e5
x-ms-traffictypediagnostic: SA1PR15MB5096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB509648863CFADC89F8635F16B3CD9@SA1PR15MB5096.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZ73f7c/HWJiw6YFCUZF9yuicMdtgc/rXGXzP230r4QN4hUAYuTxE3TA+N2qeLvjAeh1dA6Y1Habvqspv5suioXuQVVukNNcha+mDMdbhOcv/K6r4OEUsVxxQysZcH8ghvDatsSD7zyMoi7dtp+qGoD1TqS5zX8L4p2U6qH+oGU2XbtTE4QeZNiypR54wkmmUHLESkbJS7VQxh862X074au1Kyk/uwH6haYEua3HJma8/emoCnLGDCt31ibt7szq1nce2NYX5dEvavyQaWAGhp69r1xZEIp7Xs2YlnFyAcddwVVf1Zq8fsJOn1XseaO8AH5aZV0yIV+FDfcwuA1ge0nSV5udko/s5VGprTd+a0y5rewFXS/uiThfFdXaOPWk/YfSySoFQm3Wi3OBUp/e6OWGDzeLIskV/I/i3TnoOf5fVoEvgGlBSN8+M5WD4pMkQ64CdPr4gDUPhNW9jameJGyzZBae8Vkwdq3q+qK0ytUNBHPn+d1G1zBq7Rl1z2uWzTQeNpR4ycD8s8za64vsoEFdU5kNxq96oIJPnx+FaT3roNo7fp7/d1greFRjrX4XvgF6O/lP101Fe/tmy6GYQcz5PQkvHwRZRXTEkl9vYL3UzEvedPO9Xvw5D9VApshBSAZRDc8JMX3NLNLYU1vIK41PxIkcOgEhwJwD8gOu3mwy+Fak6b6DbABIGhbfRPH8mHjek4/05AdQnYoDRb5Mp/X+2hDeYFh65FJtNcBS4ehY8d8PrNce0l8M9xP/pHXx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(66446008)(66556008)(6506007)(186003)(64756008)(66476007)(91956017)(66946007)(83380400001)(122000001)(76116006)(53546011)(8936002)(6916009)(2616005)(8676002)(36756003)(2906002)(38100700002)(6512007)(33656002)(316002)(71200400001)(54906003)(478600001)(5660300002)(4326008)(38070700005)(86362001)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0njHRCyVZUFYz9WW4bUXfgnHcB/ANcejYAj0Wa0Fe5zotMGQglz9WdRalPSt?=
 =?us-ascii?Q?cMRUrfGZVmpCIk1ZYiXlWCZItF+yrXwm6ZIA0hxtyIIiYDX+MOjtGdfiWSmz?=
 =?us-ascii?Q?EyySrRX9JFqtpTxHtEMzzR/26eYZXlyuOXVPWipOEYDNpk60vydxPxRq7Zqr?=
 =?us-ascii?Q?j6mMBF7g6k3CRez0XaqUrGTQO3Mu6/ZvRS/Ikphk+i3s/7+Eawhl1ih3hSCX?=
 =?us-ascii?Q?ODkTn1EJYepp6Y/qrgIVQAaWi0jPNZ11jrj4QpKdKXBIFl7b38LUv10zBir4?=
 =?us-ascii?Q?55pPNFRrZKiu0aPSV7ZpGFngm3pqfT9pbKxXu2SahNOIYWVNypM01kffK17q?=
 =?us-ascii?Q?dlPF0H2cNqMpjTSd24tOtkfxQHYr1KZKpfsbK8wNWAeZ50EPsg+RWsWvriJU?=
 =?us-ascii?Q?aOmC13O6Ie3xArVQkIxTrJIh6++RgmreykYUksVV/9gRhkMeJZVSN5KS4cMJ?=
 =?us-ascii?Q?YCvtMAbylfHl9qa8Dt0uxG78vnzuCQVbnqytfoa0nMF8uxusVflBx18rCDzq?=
 =?us-ascii?Q?PHqac1JdDLrFEaiQRxB7nKxwnAprWsLYYLLqvBI0xrWFmV7/dUSnTsr5kkrV?=
 =?us-ascii?Q?5Qw/UZTh76CWs+Wyb1tRa0kMiHO5OjYWVwKWqsanx7fLjNYUbcq+qaWjXXbq?=
 =?us-ascii?Q?1mbzJWu3xGMCCeuVFPmTFpwkvNNa25Mn4wBeuJy+sBHIPzyyU71kO2HmPg5T?=
 =?us-ascii?Q?F2rxZs4BIVgU8sQE1FGvxUkSIOM2+J651g36BQgdEuZED+SKsPR1pK99VbRn?=
 =?us-ascii?Q?xFGd3xDLLCW05f1cUeD7HiwKD9mgrl2BGkhPqrMtiZeBFNyA3eR3S7RNX9uT?=
 =?us-ascii?Q?znBtetjxRIgHrbE1Wz8MwM5opFja36CVZiVfm3VK7XGVMHp8OT0rdWV5Ab+A?=
 =?us-ascii?Q?3GfcsRldrPzfNOTYB7J0Tb82eXdO7dsB9zzuP7n/c8oJzd+tbbikW5ux6Avv?=
 =?us-ascii?Q?9Og+2VwalhdtFAQl6i1qpbKbKmUI0ucfbtfa1odcawpLHhfGX9J3cuO9c4Xz?=
 =?us-ascii?Q?AMkfEN3JEvNhibyFVTK12Vpwq/e5jvzFjJhuXkzgyQvK1znz+9vgh6p8Hs04?=
 =?us-ascii?Q?1d0CprZgsT6OtyRn9nws0IXA6hwktvKfOwdGOWunLdqzY76WEheAVqp8Xsdq?=
 =?us-ascii?Q?QJ4ZU3Ujl3R2Lf/RvEcXoZXkgBAWfARNcWXLg6judPAl5SA42jbH7u1Q3D9s?=
 =?us-ascii?Q?h8XG/bPBenDqRyXUoLlAvSd9NfEBzPeUS0AMAX1N3ytMkmDeQQUTSjJxBUxt?=
 =?us-ascii?Q?+98O4eEU2oyfn4Six+qSrLmgVydQUpLcqzwajyElC7wjlJQXZQ4SEyc3UVUr?=
 =?us-ascii?Q?Ic0yDRZjpLm1ej2SJ6fzAHGZ0jzDeJyNRu++VYqzhn2S+EgXqNXcHIheTdw0?=
 =?us-ascii?Q?yF6wyv4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1874CC15773AED48B866AF32E20050B2@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6fe033-1c2e-4271-0027-08d96d5f50e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 15:43:59.5793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSAC9o1dUSnGXrm5xIZx1QPKOPjqa8GlNd8ij4QyWHpR4ymEaBQXfG3zHi5fkNYlvxWjzOv15rpTkoYQDgzKag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5096
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CYBYAiuQDncSEjPR9cr4o8krO_qQOV-5
X-Proofpoint-ORIG-GUID: CYBYAiuQDncSEjPR9cr4o8krO_qQOV-5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_05:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2109010091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 31, 2021, at 9:08 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> On Tue, Aug 31, 2021 at 7:01 PM Song Liu <songliubraving@fb.com> wrote:
>> 
>> This test uses bpf_get_branch_snapshot from a fexit program. The test uses
>> a target function (bpf_testmod_loop_test) and compares the record against
>> kallsyms. If there isn't enough record matching kallsyms, the test fails.
>> 
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
> 
> LGTM, few minor nits below
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>> .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  14 ++-
>> .../bpf/prog_tests/get_branch_snapshot.c      | 101 ++++++++++++++++++
>> .../selftests/bpf/progs/get_branch_snapshot.c |  44 ++++++++
>> tools/testing/selftests/bpf/trace_helpers.c   |  37 +++++++
>> tools/testing/selftests/bpf/trace_helpers.h   |   5 +
>> 5 files changed, 200 insertions(+), 1 deletion(-)
>> create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
>> create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c
>> 
> 
> [...]
> 
>> +
>> +void test_get_branch_snapshot(void)
>> +{
>> +       struct get_branch_snapshot *skel = NULL;
>> +       int err;
>> +
>> +       if (create_perf_events()) {
>> +               test__skip();  /* system doesn't support LBR */
>> +               goto cleanup;
>> +       }
>> +
>> +       skel = get_branch_snapshot__open_and_load();
>> +       if (!ASSERT_OK_PTR(skel, "get_branch_snapshot__open_and_load"))
>> +               goto cleanup;
>> +
>> +       err = kallsyms_find("bpf_testmod_loop_test", &skel->bss->address_low);
>> +       if (!ASSERT_OK(err, "kallsyms_find"))
>> +               goto cleanup;
>> +
>> +       err = kallsyms_find_next("bpf_testmod_loop_test", &skel->bss->address_high);
>> +       if (!ASSERT_OK(err, "kallsyms_find_next"))
>> +               goto cleanup;
>> +
>> +       err = get_branch_snapshot__attach(skel);
>> +       if (!ASSERT_OK(err, "get_branch_snapshot__attach"))
>> +               goto cleanup;
>> +
>> +       /* trigger the program */
>> +       system("cat /sys/kernel/bpf_testmod > /dev/null 2>& 1");
> 
> ugh :( see prog_tests/module_attach.c, we can extract and reuse
> trigger_module_test_read() and trigger_module_test_write()

Will fix. 
> 
>> +
>> +       if (skel->bss->total_entries < 16) {
>> +               /* too few entries for the hit/waste test */
>> +               test__skip();
>> +               goto cleanup;
>> +       }
>> +
> 
> [...]
> 
>> +SEC("fexit/bpf_testmod_loop_test")
>> +int BPF_PROG(test1, int n, int ret)
>> +{
>> +       long i;
>> +
>> +       total_entries = bpf_get_branch_snapshot(entries, sizeof(entries), 0);
>> +       total_entries /= sizeof(struct perf_branch_entry);
>> +
>> +       bpf_printk("total_entries %lu\n", total_entries);
>> +
>> +       for (i = 0; i < PERF_MAX_BRANCH_SNAPSHOT; i++) {
>> +               if (i >= total_entries)
>> +                       break;
>> +               if (in_range(entries[i].from) && in_range(entries[i].to))
>> +                       test1_hits++;
>> +               else if (!test1_hits)
>> +                       wasted_entries++;
>> +               bpf_printk("i %d from %llx to %llx", i, entries[i].from,
>> +                          entries[i].to);
> 
> debug leftovers? this will be polluting trace_pipe unnecessarily; same
> for above total_entries bpf_printk()

Oops.. I added/removed it for every version, but forgot this time. Will fix 
in v5. 

Thanks,
Song

