Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F88158850E
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 02:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiHCAMi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 20:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiHCAMh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 20:12:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6439522517
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 17:12:36 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 272Ni6PT031982;
        Tue, 2 Aug 2022 17:12:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vIvDbTrm+oFWg8UQniLOjWycKYPeUN+teFouEOKZ6SE=;
 b=aifvQSzy4987XCV6V1sEQ5LtNnQ268hEp5PZOqnsrrcVZDIHbCisLawSwmkAYm8bLBcK
 Wrtvbou8KMSJSbc0LaA7kYNNsqh/z+FCRRZkqbIBGry8lNMqe4APTv/hTJEm4NGqIq0b
 7pw5W0CaY5HhQBB9YQhOn2R8JGk1HyMIVOw= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hq51cveqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 17:12:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPPZYKUhT7jg2ea+g3RQgKRUBfm0MSVHdZaRR3Zo1i/CtHpyGuoIk8GdqnL8Q4TdKcbMDKvfRZj6nkGcyda1AKg09P/aAlGmy31k3GloafPls5QZjHSF/At6OCDaIiN7n2u5xvzlVqjlV1Ox0BwOciu07G2vtOOzyrpqiz/Yv8OvY3UNT9bN3gmvcLsHgBG0w/GOwzUsyJY25K2QcbAZKPqyATF3J7Nk/QI8tIzZKM6c/We9D1KJSUxwL3sLaUi0IWtaXRwrzUFsJhTFsn75rJZEWmam9rJwTly/T7SeKSwMTDFKVUAMMsrhii/FjfnF0SCXrW3kffhUbbuRkwWz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoqX8XxNVizz/CcjvGQ9UI1tx0k6NewIogaz+cLXSg8=;
 b=gVf4X4DjXfrsuUHL+/PZ4fZ9n2G2iMKH5BNI2YJ1ns7cHhRhFttCRELEQbxvBO9aBrpL4KBJmdNGrgZ2CqAMnTYEMsnYdlskbGS7SrIm+4Sd2KUwXJKJkzc88i2qidVyCCAgoYX0hSTDRq5AHe+eNgyVU6pq6U8Wl0fTH2aLVCunO90Sunr+/4wJyggV970/I4gDtpMmQXTM3285ShfJg3bgAugiSnhwyOihAZJ9fHJyL5glJoMYOC1yWu12jVOl5tSNljSN5jrM28Yi0LJH2BpNTS1aqLQ8/gQ0wPK3kh/o3JRfM3ctgzbTgf7lUM/+9bbFNVe+KRki/RUvWIEQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BYAPR15MB3013.namprd15.prod.outlook.com (2603:10b6:a03:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Wed, 3 Aug
 2022 00:12:18 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 00:12:17 +0000
Date:   Tue, 2 Aug 2022 17:12:15 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, Song Liu <song@kernel.org>
Subject: Re: [BUG] Possible deadlock in bpf_local_storage_update
Message-ID: <20220803001215.wley3iom4f7rcojc@kafai-mbp.dhcp.thefacebook.com>
References: <20220802222506.h7uekapwj5tioj5a@muellerd-fedora-MJ0AC3F3>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220802222506.h7uekapwj5tioj5a@muellerd-fedora-MJ0AC3F3>
X-ClientProxiedBy: SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::22) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 419e1289-0a92-41b7-700c-08da74e4d383
X-MS-TrafficTypeDiagnostic: BYAPR15MB3013:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzwUMNRNGt32NJOdkA0Y0aF1GSzp5XKI46WqoyDGZt+DeG7WntHB1x3uJljEL5otkwtGoZWp/vI/6EcKJjUEt77RygMeL3e+NdDmq9Yv1/iVzea32ZWuE2HPsO1Or4BzCsiV+PnhjA+RbiqZiXomI0GerGkslE3pwkoJ2Bq48fluEnqjY2smxJGUtujvGLNqasXZ0ChOG4/VV2qwix2EogVoEAnj/dCLYEmNjUsw+Nt8jUzxteSp6cwMhq2XlrWQWyfoTFew+Ra5aWRLUaDr4eyOTQ+T5aIA63suPFDIawKBsarLNfVNlePAisML3d+Dl8LY615X9FGVt2gbPvYnj5tF5OTeZjF8JOvmHNwwbDgIO4MIRMq0uwrR1wl4kcKArmQZgYfeyICeFgnEx/EZb4NHajf4mAsMUxUM0eCF5riclJxn5It0babCl1Wh2i44Aro2uUEl/oj0eZGhL2ws8k2HkmlQ1ZAAmd9fRg2SJbZVnEyuqG8BBuSGTYmKoGHVf9bKZ7mNtRH+nS99uvZaZK0/guEBpd+5ehQplMDTzdRRe13yczr69edC7KlP2a7KgAW2kBW1gvtSS1gU3xYfzoB9jXg46pltMY/9TCpRTQpIEKVg27590qMguJUZDOqfDwY1J0MWOh/XfmDbsJRg9A648IqU5X7+gdvsPuNnnZdge2BdcIQXtwr4nVMuFuVVGrQEp5asndFqzNklkiYqaoVS2qbxnaMTACVzEpJAlTwbGNGu5M9c/3zj7JCaz2L8xLMq3sogQdclxrXvsAmkgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(186003)(478600001)(966005)(6486002)(38100700002)(83380400001)(5660300002)(66946007)(86362001)(8676002)(66574015)(4326008)(66556008)(66476007)(52116002)(6506007)(41300700001)(6916009)(6512007)(316002)(9686003)(2906002)(1076003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZF57CHSBHBP0O2w4UKZ16MbElBe44FHrDWA/LM0VTxwo0V/KC01VM3/Kd9?=
 =?iso-8859-1?Q?ojP93R7BHsI/tDMquOKMoiLjOXsVWE/H2nt4obuVd5W9Ye40L7Bx13eL+5?=
 =?iso-8859-1?Q?c0f78du56eZerFQTUMLzAm6UC6SOTfNcX+tjk/loGubuBN8q4JcO+t3i8a?=
 =?iso-8859-1?Q?6qGENwgylepcMzWz14rJxT1Qvx5FYbc0U8ndneBgzOnmxVmb639kEZ2A6T?=
 =?iso-8859-1?Q?wzLW1+EF3UTI+vo1F2wrrxNLELgdf2G1p0h1gSRGmBdriprI5AhTHDH4G7?=
 =?iso-8859-1?Q?up5rpwzKMSHJVkFPR+3Qo55X3YHKe2t+rCgalph8FR808h6f0PTa6jVO3J?=
 =?iso-8859-1?Q?lVhgbVVTjmIWk7LIMmot3gk64o/Y3Mc7ygUeYI5a8b3LBLuDXUY0JkJE8Q?=
 =?iso-8859-1?Q?ut16EchQnJEdLUzh51dZNboPBNI2ThLGzlz7mS7qQOWpa8cL0k59yALx4R?=
 =?iso-8859-1?Q?9nTi4Q/2kWmqLGvEHSdZ7u/kw2JbVGWbCfSlp2NCUvOl3Zery4a7rzIjv7?=
 =?iso-8859-1?Q?a2B9zSpbONY6LHcr+BhLr8kaYSTvWZUiHLWsMSZiTMEvpZNwz/xCx3LFFU?=
 =?iso-8859-1?Q?jPBuTwcDbYIdsDAruEBL6xdj5NIA2ZAl4UEqJS+6F1qhobbAJhHefI3KW6?=
 =?iso-8859-1?Q?uUu9yU3znr2NFzpXLMDNgIJvmZWkAyNe9EOhvnhOB8qLyqJ1SsjF5/kjao?=
 =?iso-8859-1?Q?TRNh8NxPSl1HdfrxdKzkGy/XrtiiEvYejY64W9tPaeC3QvzYH0ojW0glkr?=
 =?iso-8859-1?Q?aPmWhvL6M0u/ErJ0HJEiE68Cx7xPLSowA7S0LKSF5ctG6MzCxxd92Lp6S1?=
 =?iso-8859-1?Q?kthQgf4kQb1YXTAP+YzHB5Ae0NE8MXqtB+UXVw71MwU18vk1yfXCQFmqcO?=
 =?iso-8859-1?Q?TKKNwdXtHdG+fFAINWYuMS0lb8zEy9YHJhnjXmNfC6h9/qkv6tV8rchCCR?=
 =?iso-8859-1?Q?D9P29DuevzRFhz/Lw9hQplIrLVNunnYqQnVDU7Qv7zuP13CBncbMkHglMq?=
 =?iso-8859-1?Q?wQiuN7pSlEr8MAFZBZ3wJTVFBSPHR+7QeNYYT8JR4FMDFUxL5O88YN6pH5?=
 =?iso-8859-1?Q?E7UAPtd4pFtlK7s9KD3xCjUkhHWBJ6ZWSS58H95ZEnUJn8+i7ietfHoF9Z?=
 =?iso-8859-1?Q?jm87Ifo58tPDlrZhQ8tHiDfMz0bRUmkX4y50YZKSpY4z9Obh+JQshWKNPG?=
 =?iso-8859-1?Q?zHeTxKUGzYnVrTW6ojp/U7FMOPEQwiEVajf0TIiKFLJenN2ON+EtUVJOIT?=
 =?iso-8859-1?Q?3qopYicsHMW0WtkGossxjqQg6JlOEoL93AN6daC6+GqkWwFEepeOlKYHuN?=
 =?iso-8859-1?Q?L1VXadzEzgz3J8jfS0DU9zrsQehbhyDf7fDM5zKVcmthUzWBfAz7S/kakP?=
 =?iso-8859-1?Q?Okklr2wjsluAFDg2rKZ12+UIjFxEmvHmK3JwlXBULR8fXmUWaWW4P8mGWB?=
 =?iso-8859-1?Q?9l87A7cCxdOHXPEiAsnDkZRZdn8D4uEqbWdmNyKLajHI0z0D4Xs9Ql5g+w?=
 =?iso-8859-1?Q?IelLwpp1dzAhHbHB4tpb6V8/qS5UcD0WR1xNjfIX+HeANBmChkIHNakt0l?=
 =?iso-8859-1?Q?1Qhv2dMu4CXFVS62cA906gctxE+VF7Znh5FwKmzVPRECHdP2AM3Py635Li?=
 =?iso-8859-1?Q?w3f4CpADUjeZ5UumiPxL62DE7SfL2e09ngfYevvY2MgjdM44XlDNuCFA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419e1289-0a92-41b7-700c-08da74e4d383
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 00:12:17.8037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMt9Do+QY7CI2IedT5Ynrypraj6aInK6JEBJ+4y9RpR9PbeHbtiPdVlb1eUu5XJQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3013
X-Proofpoint-GUID: hF3Dr1XEbar4r84hRaBCLQJ73Ao1cNnw
X-Proofpoint-ORIG-GUID: hF3Dr1XEbar4r84hRaBCLQJ73Ao1cNnw
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_15,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 02, 2022 at 10:25:06PM +0000, Daniel Müller wrote:
> Hi,
> 
> I've seen the following deadlock warning when running the test_progs selftest:
> 
> [  127.404118] ============================================
> [  127.409306] WARNING: possible recursive locking detected
> [  127.414534] 5.19.0-rc8-02055-g43fe6c051c85 #257 Tainted: G           OE
> [  127.421172] --------------------------------------------
> [  127.426256] test_progs/492 is trying to acquire lock:
> [  127.431356] ffff8ffe0d6c4bb8 (&storage->lock){+.-.}-{2:2}, at: __bpf_selem_unlink_storage+0x3a/0x150
> [  127.440305]
> [  127.440305] but task is already holding lock:
> [  127.445872] ffff8ffe0d6c4ab8 (&storage->lock){+.-.}-{2:2}, at: bpf_local_storage_update+0x31e/0x490
> [  127.454681]
> [  127.454681] other info that might help us debug this:
> [  127.461171]  Possible unsafe locking scenario:
> [  127.461171]
> [  127.467377]        CPU0
> [  127.469971]        ----
> [  127.472497]   lock(&storage->lock);
> [  127.475963]   lock(&storage->lock);
> [  127.479391]
> [  127.479391]  *** DEADLOCK ***
> [  127.479391]
> [  127.485434]  May be due to missing lock nesting notation
> [  127.485434]
> [  127.492118] 3 locks held by test_progs/492:
> [  127.496484]  #0: ffffffffbaf94b60 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x0/0xe0
> [  127.505888]  #1: ffff8ffe0d6c4ab8 (&storage->lock){+.-.}-{2:2}, at: bpf_local_storage_update+0x31e/0x490
> [  127.514981]  #2: ffffffffbaf957e0 (rcu_read_lock){....}-{1:2}, at: __bpf_prog_enter+0x0/0x100
> [  127.523310]
> [  127.523310] stack backtrace:
> [  127.527574] CPU: 7 PID: 492 Comm: test_progs Tainted: G           OE     5.19.0-rc8-02055-g43fe6c051c85 #257
> [  127.536658] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [  127.547462] Call Trace:
> [  127.549977]  <TASK>
> [  127.552175]  dump_stack_lvl+0x44/0x5b
> [  127.555758]  __lock_acquire.cold.74+0x151/0x2aa
> [  127.560217]  lock_acquire+0xc9/0x2f0
> [  127.563686]  ? __bpf_selem_unlink_storage+0x3a/0x150
> [  127.568524]  ? find_held_lock+0x2d/0xa0
> [  127.572378]  _raw_spin_lock_irqsave+0x38/0x60
> [  127.576532]  ? __bpf_selem_unlink_storage+0x3a/0x150
> [  127.581380]  __bpf_selem_unlink_storage+0x3a/0x150
> [  127.586044]  bpf_task_storage_delete+0x53/0xb0
> [  127.590385]  bpf_prog_730e33528dbd2937_on_lookup+0x26/0x3d
> [  127.595673]  bpf_trampoline_6442505865_0+0x47/0x1000
> [  127.600533]  ? bpf_local_storage_update+0x250/0x490
> [  127.605253]  bpf_local_storage_lookup+0x5/0x130
> [  127.609650]  bpf_local_storage_update+0xf1/0x490
> [  127.614175]  bpf_sk_storage_get+0xd3/0x130
> [  127.618126]  bpf_prog_b4aaeb10c7178354_socket_bind+0x18e/0x297
> [  127.623815]  bpf_trampoline_6442474456_1+0x5c/0x1000
> [  127.628591]  bpf_lsm_socket_bind+0x5/0x10
> [  127.632476]  security_socket_bind+0x30/0x50
> [  127.636755]  __sys_bind+0xba/0xf0
> [  127.640113]  ? ktime_get_coarse_real_ts64+0xb9/0xc0
> [  127.644910]  ? lockdep_hardirqs_on+0x79/0x100
> [  127.649438]  ? ktime_get_coarse_real_ts64+0xb9/0xc0
> [  127.654215]  ? syscall_trace_enter.isra.16+0x157/0x200
> [  127.659255]  __x64_sys_bind+0x16/0x20
> [  127.662894]  do_syscall_64+0x3a/0x90
> [  127.666456]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  127.671500] RIP: 0033:0x7fbba4b36ceb
> [  127.674982] Code: c3 48 8b 15 77 31 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb c2 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 31 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 8
> [  127.692457] RSP: 002b:00007fff4e9c9db8 EFLAGS: 00000206 ORIG_RAX: 0000000000000031
> [  127.699666] RAX: ffffffffffffffda RBX: 00007fbba5057000 RCX: 00007fbba4b36ceb
> [  127.706448] RDX: 000000000000001c RSI: 00007fff4e9c9e40 RDI: 0000000000000035
> [  127.713247] RBP: 00007fff4e9c9e00 R08: 0000000000000010 R09: 0000000000000000
> [  127.719938] R10: 0000000000000000 R11: 0000000000000206 R12: 000000000040d3a0
> [  127.726790] R13: 00007fff4e9ce330 R14: 0000000000000000 R15: 0000000000000000
> [  127.733820]  </TASK>
> 
> I am not entirely sure I am reading the call trace correctly (or whether it
> really is all that accurate for that matter), but one way I could see a
> recursive acquisition is if we first acquire the local_storage lock in
> bpf_local_storage_update [0], then we call into bpf_local_storage_lookup in line
> 439 (with the lock still held), and then attempt to acquire it again in line
> 268.
bpf_local_storage_lookup(..., cacheit_lockit = false) is called,
so it won't acquire the lock again at line 268.  Also, from the stack,
it is two different locks.  One is the sk storage lock and another is
the task storage lock, so no dead lock.


It is probably triggered when the "on_lookup" test (using the task storage)
in task_ls_recursion.c is running in parallel with other sk/inode storage tests.
Cc Song if he has insight on how to annotate lockdep in this case.

> 
> The config I used is tools/testing/selftests/bpf/config +
> tools/testing/selftests/bpf/config.x86_64. I am at synced to 71930846b36 ("net:
> marvell: prestera: uninitialized variable bug").
> 
> Thanks,
> Daniel
> 
> [0] https://elixir.bootlin.com/linux/v5.19-rc8/source/kernel/bpf/bpf_local_storage.c#L426
