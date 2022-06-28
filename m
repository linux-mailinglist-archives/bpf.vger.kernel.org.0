Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8F655EAA2
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiF1RIL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 13:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiF1RIK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 13:08:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328A41C113;
        Tue, 28 Jun 2022 10:08:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SABvGv014887;
        Tue, 28 Jun 2022 10:07:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=r+AWJ7syQBMHqEZDwdQYRn4OCcarm0P/IZyFR1W1G5A=;
 b=ZsVeK2ha0S4ZYR5GBHABBO7Db3lGTHA1DZjsj/YxTJ0ZQQ1/KrePea7cQYZx5ZfpdYHP
 uHRv14ZJSPkYyhKf7uItPFQfB4VaIK7SJBf8S+yVesHS7LJTKY2ixyfePLy2zkLL/wpo
 8NljzjJJAJb2IbEoy55X1Vl2sp3+GrT/Gag= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gyp235f1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 10:07:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdRr6UT7SI8PmckZoelAfaHMjguzF7O7TGdP+twXcIo+qiOS6jjVwZQn22YTvSa1uKnm/XLIbWi91wv+EIggy0JwQ26/+DbF6FM3g7qgWVpRrZbtCjyXO6ECV7pt60NTWyhLKGvT7clQjJJaJhYyQEH9Z7SwqZrjXfKqUYcNrAtuXHm4R1byZQfJutwiC4a33kG0T0OXpUwAz4IMuMAWBdkcA/cY2N9HJnFjR2JvPjL6CuD6HOSYRyuxibosdBSTUernjbhrBlF0wN1MDXJz04EQOF6Hky4QIjmx3d/41VjjBo2TBy2lJSAmSHr3fIHbiNs2+rScZYLUlg1wzDmSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+AWJ7syQBMHqEZDwdQYRn4OCcarm0P/IZyFR1W1G5A=;
 b=npr6gyMiHuUsJVou9WfSkX5H5Eb0ToTMQuVkDc548+rvkuGiWivL5PhYWRoqd6dMI45aYWMiG0BXZ1Ti3C6hjDcVg9u5+jMir4PnWQjMY7+POj+bz7Zy8NcdqfMg2RnsS5w7qJunUHD7tkfPBsgkO+9YTHsQL3n++7TRxsDNOxSmBaGjm9vnQXWTwRxXzeN5Sq09zUR8jAWCwFKz4tdXjAX8OyOZ0RrqvzcCiV456P8I99PsGswE3GlCS3NLVQEYk0SoTWf7OjP2JNsbc6EEdxrEeSKy2IaUi31fhzb/Q+CTBQk6z7CUz23vI7lH9qc6WZzWRa80aCLoFeRlk79XFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MW4PR15MB4562.namprd15.prod.outlook.com (2603:10b6:303:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 17:07:53 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%8]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 17:07:53 +0000
Date:   Tue, 28 Jun 2022 10:07:50 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, rcu@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Add benchmark for
 local_storage RCU Tasks Trace usage
Message-ID: <20220628170750.fmxzmyhr3f6iseby@kafai-mbp.dhcp.thefacebook.com>
References: <20220628141200.8417-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628141200.8417-1-davemarchevsky@fb.com>
X-ClientProxiedBy: BY5PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:a03:167::42) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a95c4ac8-75ef-40b7-889d-08da5928bcc8
X-MS-TrafficTypeDiagnostic: MW4PR15MB4562:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46Qikqtu6K3z6r5fe+GVYK5z+G+2wN10VOxjIDB+/OQEixgXY+O9MHfLhgACkPuHlQWZRyQGC56o6acSXeEVpk4cOERX8QOhj/tvi8rZnpwqg2+4QkuSX9V57MyV9keo/YxZrpGaA4tKezpGDo2DcN8daHwIjUIQgDtzXQBJgwCmdrjfgz00Jp5s1vXrcnoh7gOX3f5EAoujqaqiEFGaWMAHjCLo0rx1t9YKRoK/lvl6N56k3z0mkkmje5HfazJjFKpooPRIIi1++oXqnfu2VgtUbAwMReeEMxeCSikrVOKOoWFNq+6vDwBz8ONTMUQ9dEkFGOo/29RAHvbwRre4bqM+U+3k5vlhk12Zy3p+sXjic66QlJ4klv5W6RyXwqmoWNQxeIeLFBWIfS1r0NzMNqI0HRfSXhRE5LvUAfSeil/LLWwTEBKmcnDoqFVoCa86xjU9hjde5+KA93I+EiR/Kl6D1mjj8U/n36OpHbSi76Cr8Cn01J+RbGsmTa5hJJOyFqcs7bj33rCcqLZwp0SHULuy3ZO5W4wl+PbOjMrBW4qzwUjs/840rpcNOiifQfCufQzxkdFrZ08x97kiicSwg6LX0RNqpVLPaC9J/r1rYNWuOLTkl3JumA3H0JoH7XAbr/Z5nJDn3lP4M/zcXVKn7Pe7oDkRGQ0qHTI9UhhA6UhWrOcgPQC96iAtU0QV12ITZoHd9fVu+7nR22VkEx5r2AnyZ6TIANKZoEE4TITO/Ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(6506007)(186003)(4744005)(6512007)(86362001)(478600001)(9686003)(1076003)(41300700001)(5660300002)(52116002)(8676002)(316002)(54906003)(66556008)(2906002)(6636002)(66946007)(38100700002)(6862004)(4326008)(8936002)(66476007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+iqVfJOO23GVEeq/67T75jsQcxHvva/VSbYh+ZQeyw8AzhOXBKxcntg59Sn1?=
 =?us-ascii?Q?IVIm7nYTguKwxqoo6YDbUev9BczPLPwmDWTeGG8lssXc7AZ5QfHgaVZ8NEf3?=
 =?us-ascii?Q?g+RiI536EpYGtk2FHQS1pp1h4zX/hNaN9K6KOixWLkXISIlQ1JubmuoRS0RQ?=
 =?us-ascii?Q?eMMqgjWy/bcYv9ZXUxkwJwmW2KFrNb5IF1U63VnpLuZOxciVMmn4ediR0bHR?=
 =?us-ascii?Q?V2dT9641E5wtYzZDPOJgWLS5emFF7lVjZcV23lkTfAayHG+o8ouS6r8yDaBt?=
 =?us-ascii?Q?SwlnCVdXjzn3Jwg/KKsl5wQy9qkIrlaSuLGQEAxaipc2eJFWJgtIoA5pNBfC?=
 =?us-ascii?Q?sXoFCTN481LBiM09gXbBkhINGF4/Ds9X0gOfQgRwP2qbubS8Q4A2cx1N8mXL?=
 =?us-ascii?Q?8zKEjwUcV0YxFNG14fgob9Gr/RzyGVOW8J3f7VwcLCh8LpJPXpzbZb49PH4e?=
 =?us-ascii?Q?raWsTqsDaXURxHyzBBk0ZfXNB88kDrKuECkY0ns8hAUpP1PGoakLdVhrzG3A?=
 =?us-ascii?Q?fagc2cSM9u2NJNL4WyUAvDVlNgpP7HZL+Bq+/c6logeHQcDwLe9xqqDVYUOr?=
 =?us-ascii?Q?1BlA7ODv0BX7l+aru5QMgc270lIcsQnWwpST54OJHcFGRmiL9c8kPFfI3oat?=
 =?us-ascii?Q?VWGN7FUIRaaCaR7I1NaTKk/EBz8vdN+j8sSYWpcaq5A6MM/cfRL4TPaoyNIh?=
 =?us-ascii?Q?yUHCl6BQ3vZqyuhJuvPNsl9ypQ0/LdomM/vu/x2xf8gPK0RT5nnVJuJRtzwC?=
 =?us-ascii?Q?oWyDM9LdWWHKhqmOi3jWzy6uFGDUBl3DXnflgjlEEM+76lP9lZJANpuURDut?=
 =?us-ascii?Q?0bIBx6cOo/Oh+PQny3W55VBocnQf0qx9UdGtwtY8noKlRkM9Cz+B9rF8LGpu?=
 =?us-ascii?Q?qDPDYmkvGqxGE1CaTQrVbArxPfnLWLAkqM8oB7E2YLlgSdxFbVAGAsyO+DTK?=
 =?us-ascii?Q?hr8FHsHmqb02clcHLhZ2B70aepIacJ1Q+sgI9dBxpNer0L23B3OEpeXrZN8s?=
 =?us-ascii?Q?cIJwsstr3gfzB4iRFD6sFdkVKm94srAD/pAMpQFSw/zE3Vj9esIYDyYxqMw6?=
 =?us-ascii?Q?+VnTqKc68Ue/DimbV4TZma+mqF6etw1ld6Wrde/Ud58Zc7yZUhgyerZXOGE4?=
 =?us-ascii?Q?mXUz2nUMvoFGM3JU77ayCRiUgCNs00eGRm9bd5aLvEmnDzJCtb6qSH9tKS7I?=
 =?us-ascii?Q?7ZNdcjTEUfu4fJXdnyN3CbcSU3CFYhBqUGklVrug2iHlOrpxS8hpRMK+/cNp?=
 =?us-ascii?Q?oPxWztGXdJE+Z1IqZB/F3wNpFaMYjqT+hKH97T3wU5C+8USWTAtMkxDQWCu1?=
 =?us-ascii?Q?fcausGD7bCCHodQKiApNxF4kGdn/FG+QunwXkY5m/jofFRkwCF8or0/mUU9C?=
 =?us-ascii?Q?j1qa9KUBUs/dvc6DeSmnc8Vr6zdGR4hR5n6AuYp3n6dnTvVzzG4zkvopuaiq?=
 =?us-ascii?Q?rQXXy5jvG7pmspZMq4ISDqUdSCtNLQVSf22W8cNjuOlPQFS68GglATTJAfAI?=
 =?us-ascii?Q?pQcll+iJ2A07EoQxkRoiT/DE0bUsaraaN5hkaoou21nmrdRmfCsmEDCQrIo6?=
 =?us-ascii?Q?S5zowyUbZ92OqDK59c+Z0gCOEmM7S13/sCgV+2DXjLtJMd8xdt7dTPp4BIL7?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95c4ac8-75ef-40b7-889d-08da5928bcc8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 17:07:53.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5YCFexqWfSgTIJYPvZoxy4Zd+aKkuNDu7BP+D0L9SDRfBuUxKp4GgBbMF8Y3mpI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4562
X-Proofpoint-ORIG-GUID: 7dsUXsx2P-dXATthGdbO_jCPdc26zaUi
X-Proofpoint-GUID: 7dsUXsx2P-dXATthGdbO_jCPdc26zaUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_10,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 28, 2022 at 07:12:00AM -0700, Dave Marchevsky wrote:
[ ... ]
> +static void local_storage_tasks_trace_setup(void)
> +{
> +	int i, err, forkret, runner_pid;
> +
> +	runner_pid = getpid();
> +
> +	for (i = 0; i < args.nr_procs; i++) {
> +		forkret = fork();
> +		if (forkret < 0) {
> +			fprintf(stderr, "Error forking sleeper proc %u of %u, exiting\n", i,
> +				args.nr_procs);
> +			goto err_out;
> +		}
> +
> +		if (!forkret) {
> +			err = prctl(PR_SET_PDEATHSIG, SIGKILL);
neat.

> +			if (err < 0) {
> +				fprintf(stderr, "prctl failed with err %d, exiting\n", err);
s/err/errno/

> +				goto err_out;
> +			}
> +
> +			if (getppid() != runner_pid) {
> +				fprintf(stderr, "Runner died while spinning up procs, exiting\n");
> +				goto err_out;
> +			}
> +			sleep_and_loop();
> +		}
> +	}
> +	fprintf(stderr, "Spun up %u procs (our pid %d)\n", args.nr_procs, runner_pid);
nit. shouldn't print to stderr.

Acked-by: Martin KaFai Lau <kafai@fb.com>
