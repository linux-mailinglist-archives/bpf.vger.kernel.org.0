Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417C15AA031
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 21:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiIATip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 15:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiIATic (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 15:38:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3AE9A9E1
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 12:38:30 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281I5nL0010369;
        Thu, 1 Sep 2022 12:37:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=XqWfiop713FtCVp6o7M4ILEVTNF8ZK4n9CpwRIvvGHk=;
 b=KjBJx3tOjhR3cUFj9fXVBKX7fE/V4CAk99YGxyCr1gu4RXF/5Ioh2fqtb3qSCfK7SXR8
 82q/9XVqH37rk2IjlQlad+Vl42NrJFMhYMaH1Z7L9C2qGjiY2n/LVu+M1JxsU7EpKBZo
 /QUPxItt33+PkcObieNBz5RMpOYWReXac/c= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jam56nfx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 12:37:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzNPC/R2BTdGV8mCxXf1FrnYGHk+4tpLtYEpU2oYM8l3jnaBaDj5Lrot0BQXRXw0teMQyVSbwZlxCz8vZPoSvMElgSbDSOwhd69G4pXV4v20nH5PFMCOlgRg/sBgiJfQU1WBzuCi9RuclAr4wfMIu0MMCEr556w024zeQAFvGGtwRqa68he57BM2LO8W4aypqqY7X8geQnVjfvHu2BKuM26jDJOzYW7YDdC/xvedhnkFgcTZIBkGDqYoTjdK5Kfhw2zDrtS0OMkj+7e1lj0erNiUrogUJ38JcFh/qc7lt18zVDbySEx2E97w23yxgm65uuspZoCuFglaQFEVWUaPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqWfiop713FtCVp6o7M4ILEVTNF8ZK4n9CpwRIvvGHk=;
 b=UyaQZPLzlAXWDY2qEyDAc+whlP4Z7tmJy7iWnKzetimd7U9JnXpXepWH6nIm3ojsv/7NO5duHVSOT1GjcQpRHT4NJzhPF0t/LCkfZIL6utzug53rX7Fai0fNjVSwiHTF6jWV379IIaTVrDH9T54o5IoloIeavjsNliD9wgz6jQTHhvmX+1LmWa793Zo8QXZ1Xv1JbocxB9O4tapEioN60GAug//06ioGi/jynkLI1RdL2uFWbum7nCB2R8MBq5dN6gvOoLwYmojZ5BYZwNjVCQdNcRYD2twpBQY8jFIhME3oMM6NR3YOAZr7EbziOjxsKE5beqpTQ0XqYh68i0sVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by CY4PR15MB1304.namprd15.prod.outlook.com (2603:10b6:903:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 1 Sep
 2022 19:37:47 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 19:37:47 +0000
Date:   Thu, 1 Sep 2022 12:37:45 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Test concurrent updates
  on bpf_task_storage_busy
Message-ID: <20220901193745.haylrp5omm7p2yiq@kafai-mbp.dhcp.thefacebook.com>
References: <20220901061938.3789460-1-houtao@huaweicloud.com>
 <20220901061938.3789460-5-houtao@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901061938.3789460-5-houtao@huaweicloud.com>
X-ClientProxiedBy: SJ0PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:a03:338::30) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d4e07a1-1cbe-437c-cd95-08da8c5172e4
X-MS-TrafficTypeDiagnostic: CY4PR15MB1304:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6GyFgK0u2Ftf5aooCXEtvbVQ/5mZRw4dJ9PBQBv0nIk11GB9ixhd5DPUw3q9Z3zAoxZ+vX+ZChHCALL/MplXmVN8oOHElv6vOfXUeEdQocSj+XdwOp0jKb7qjnBij4ygHGJV8giww8hXpd7aZ9jms8EZb2H/6/SQ/vGVGkmPjSHTuzKHuJNS0CvYM6Y8nHxtfod2houC3eQqTpwiMJYPc+DVM0LO+7HWhZuOSG2dvukM7FnrsT5E3IvH/S+IW+8DqQr/0kXUc5+Bbhn2GsX1NulNJ8DL0K9YChEsADi/tJkq5YIViiUigQs6lFe22X2yra2ZDys/l8SsmiQDgl9wYKgHsbUHbQUW2ZGCZeB5/qtduK5pusR2QR2JYa/lXsZrrVJ4OHOTSTN4gXMNOBkah+HmWxx7UreOnLx/sCvEu4jnrvUAk3uKA7T97WC/olnOnZLDcq4JlrzrBfN0rVfmYuduM+fPLmguA2+lVQub93aB89SzC6JF4pO3iaTabsv0MZ/seRKrQwoZw5MvJ8yQJWmr2i8ShQdjRiW0EXAreE/LU6NEzFjrBBdqhKgaSWLPylnineJyPFzlMuwU4qgZxDUOjBwi0Rad2gjvA0j6tig2/kvsIj0yHoEWz27EIhrAjGn3HWQICWbHT76a9UWqobREjNEZ23F6nHwu7ibuc0pChUlqgsLdAxvQYWQ63/zXXRWiS8XUhHuWqObHn0Z+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(8676002)(66476007)(66556008)(66946007)(6916009)(4326008)(8936002)(5660300002)(7416002)(54906003)(316002)(6486002)(2906002)(478600001)(6506007)(41300700001)(52116002)(6512007)(9686003)(86362001)(186003)(1076003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zdX0OMXD+JsOpBzN4El9poKZd2Hl1Itv41Z4fQxa+Ooho0VTDIaIWaSsz3kP?=
 =?us-ascii?Q?L6PwrnBk9edCcfXEhMGQVfOeQtOUIkmwLPBrsaB3pUgQVgeU0vvs1aBQZreD?=
 =?us-ascii?Q?jD8H6KFGLQiTlav9JtHobz/KSpTENN4j1ixIW+Jvyq5G8kjLJhgP8PaxSqK/?=
 =?us-ascii?Q?3L02p9UhEyU756UQMGPcwkr6FzKf0XflBVqs3keeV1AC0DvuCS+ydp6u9tTe?=
 =?us-ascii?Q?ykJB68ENijOEplEDN9DJ7j21eDpHz57BMiE6ue0sopFAgs4LIWw+zBkTo73L?=
 =?us-ascii?Q?z+yGFnRV69MWZux8LH9e490hRDCAcx5Cm66ZBDGGPJI+hCcdqz9j7KhWYt18?=
 =?us-ascii?Q?zG1k9zU4f2q6RJnGgCWs9yvZxRdQI4D4j87GfCvW1HsuKQTMejgBAoGPyMDE?=
 =?us-ascii?Q?JTQUIVal2Ejxb7FrjQ1LgJ9wM/PaBqg8EXNp6KMcp5nCTychLqhwaIBI0xv/?=
 =?us-ascii?Q?YbWQgYb2C9MLrVOrt4tTPBMLJOdYnANLptNh4NX9GCkld7AQ8A+/8CZPX+Xs?=
 =?us-ascii?Q?D1Jgs5uqFVm3zigEyM3IOVwMzr2869QRFIK80H7UJHYt3JDOj9YDHrnrIB2/?=
 =?us-ascii?Q?u1q6fmKbaZ0fbaUJJFQg2VZjntoBgqbOq5y9A7GyxTQjw7krsU3GxzwLOaln?=
 =?us-ascii?Q?hm42cDka+JG9gSuGoKguDk24rE+NdhTZk6f48XDobH7f4ju4FtpPNLBq7LWB?=
 =?us-ascii?Q?LbeDk/wKEkVk3DCVyJLbJBBEQw01fvhuFZQpTHRFPw2PWqyGdhzpRvG5UvR+?=
 =?us-ascii?Q?W3Bx5AqtpaHJysctC4hBoIbHIx+qgn3g8TmKfOjf30alKCdcsq17qL4pAQK4?=
 =?us-ascii?Q?GVm2dVMM3xWcfwY/BNf/nL2Iz/27lQQWhf9urZJpR148meNWxQ0VUxYHEU5K?=
 =?us-ascii?Q?UvkR4iofHcXpl469ul0j3SqWEjjVQRh2FOc1I9q1C56vyfrMzLtov5QNxz2m?=
 =?us-ascii?Q?NtZbXX0gE25+dmtAlGSik9r5ZaMl3YBx8/i0p03nWK+MOotoNc5AAFwbB8lq?=
 =?us-ascii?Q?e43VCSMPjlrkQlyHolVH26LbWnvuEI96MUMejH4HzVUX4DloIIFLPa7OfebH?=
 =?us-ascii?Q?bGcFxoVbM6kkK05pc7Pb4OYU27MulIYEq95W+cxYW9wCjeHIqZGR39awTifL?=
 =?us-ascii?Q?6m20TthIjkVA7B7oFdQTruYP92dcXYfblbWvBcCGXmQ6oQ87DDJG5iwk12Sm?=
 =?us-ascii?Q?KZ34DTotomSe30rJvdeuGTEKml1aWlkAkCza8QbKTjLBEI6ZGFSa3dsXR2r4?=
 =?us-ascii?Q?2ycUxgEc/tuQKVbWFsvr+k0tpD8tIOg8TlKc89myWy11cbsqXWzWvFnqQhpc?=
 =?us-ascii?Q?SBRqnQJ3mVmPtj2ypgBwLMS7xUUW6NT52w7QtRH6C5KrpmRctt4EFLIvZctE?=
 =?us-ascii?Q?RCpM/wtMVV0c2B8nhdhtVAunBc0nq4JmbbA9p2rFz/DK0PcJnOxbsw2OkkVf?=
 =?us-ascii?Q?i56cOeGyYhPyRM9qsuWUtoJh2hXAWkpvik3atNKlb4ITRNxfmfcDiNFKUMF9?=
 =?us-ascii?Q?HRyYb26tkYTnQBtfCEuyIS3fYRpwRvODFrC5ht4/GKRkzJ3PzGYnEoX81zZr?=
 =?us-ascii?Q?A/EZCGgIcM9YiDRS5imeXkYsmXE+1rNAfUk3xkGaaukusEXUsDhyAHAYUW4d?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4e07a1-1cbe-437c-cd95-08da8c5172e4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 19:37:47.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKszYcUvq6qUVjnbcoIwellizbPM24V27sGM9vBsRSHnwo64/GOY58XTbxgwhNX5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1304
X-Proofpoint-ORIG-GUID: duQTyfZySG-0Yq3XIjjaonH_GKLtqHXI
X-Proofpoint-GUID: duQTyfZySG-0Yq3XIjjaonH_GKLtqHXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 01, 2022 at 02:19:38PM +0800, Hou Tao wrote:
> +void test_task_storage_map_stress_lookup(void)
> +{
> +#define MAX_NR_THREAD 4096
> +	unsigned int i, nr = 256, loop = 8192, cpu = 0;
> +	struct read_bpf_task_storage_busy *skel;
> +	pthread_t tids[MAX_NR_THREAD];
> +	struct lookup_ctx ctx;
> +	cpu_set_t old, new;
> +	const char *cfg;
> +	int err;
> +
> +	cfg = getenv("TASK_STORAGE_MAP_NR_THREAD");
> +	if (cfg) {
> +		nr = atoi(cfg);
> +		if (nr > MAX_NR_THREAD)
> +			nr = MAX_NR_THREAD;
> +	}
> +	cfg = getenv("TASK_STORAGE_MAP_NR_LOOP");
> +	if (cfg)
> +		loop = atoi(cfg);
> +	cfg = getenv("TASK_STORAGE_MAP_PIN_CPU");
> +	if (cfg)
> +		cpu = atoi(cfg);
> +
> +	skel = read_bpf_task_storage_busy__open_and_load();
> +	err = libbpf_get_error(skel);
> +	CHECK(err, "open_and_load", "error %d\n", err);
> +
> +	/* Only for a fully preemptible kernel */
> +	if (!skel->kconfig->CONFIG_PREEMPT)
> +		return;
> +
> +	/* Save the old affinity setting */
> +	sched_getaffinity(getpid(), sizeof(old), &old);
> +
> +	/* Pinned on a specific CPU */
> +	CPU_ZERO(&new);
> +	CPU_SET(cpu, &new);
> +	sched_setaffinity(getpid(), sizeof(new), &new);
> +
> +	ctx.start = false;
> +	ctx.stop = false;
> +	ctx.pid_fd = sys_pidfd_open(getpid(), 0);
> +	ctx.map_fd = bpf_map__fd(skel->maps.task);
> +	ctx.loop = loop;
> +	for (i = 0; i < nr; i++) {
> +		err = pthread_create(&tids[i], NULL, lookup_fn, &ctx);
> +		if (err) {
> +			abort_lookup(&ctx, tids, i);
> +			CHECK(err, "pthread_create", "error %d\n", err);
> +			goto out;
> +		}
> +	}
> +
> +	ctx.start = true;
> +	for (i = 0; i < nr; i++)
> +		pthread_join(tids[i], NULL);
> +
> +	skel->bss->pid = getpid();
> +	err = read_bpf_task_storage_busy__attach(skel);
> +	CHECK(err, "attach", "error %d\n", err);
> +
> +	/* Trigger program */
> +	syscall(SYS_gettid);
> +	skel->bss->pid = 0;
> +
> +	CHECK(skel->bss->busy != 0, "bad bpf_task_storage_busy", "got %d\n", skel->bss->busy);
Applied.  One nit.
Please follow up with a test PASS or SKIP printf.
There is a 'skips' counter in test_maps.c that
is good to bump also.
