Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67268501F46
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 01:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiDNXoC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 19:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiDNXoB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 19:44:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1449D079
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 16:41:35 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23ENfLa2007444
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 16:41:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=lysy8qKCUd11LC+/iENEYPDBiQgsmiV/F2jUUaNNcf8=;
 b=OFlICDN7v2xDXg+WULHYp/Lc/THflIh3+fIN7CB7kg8+TvQGnl1sMOvkdC2e2Yt0qKt1
 9kOXbTHBFlZV0wR6EGTMFSYKp23DcLoYMD1vmZmunPZKwzfG7BKDegpl0nissEUCESVV
 rM9QmE/x/S6s5aDRASmL7PSP9mXtERcnWOM= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fewgp8053-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 16:41:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSR25fwjw6ETgHyfLmFblOPyQpcYF2WUjHE9+g9AuO+/M4rYh9xIRvrGl/YVqofZ8rr36DQMfOxmD5kfYVE7pu2+sjFbDYlkoNz+VPoBkMfyEkMuhON7xdGDNQkJnqfYY0MQlbXT/ij93yLSFRtGrKQgMMzLakD1IOL/KmlNnxSGey5y84BBV8q3nYAXCsPejTyQtTIEPjNj/xxGkwmV4TxlTeQXwKzyU1thjFz3lZqyRK5cXZa5+6hOUsdk6N248l1kzzMy66Yg7hUEgPaUaQznqZyceP4B7f3Bu1cUkRUWy9xKyuGO8rEsPgCmeHgdsJOG2qZxTjFCLhMj/OCeXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lysy8qKCUd11LC+/iENEYPDBiQgsmiV/F2jUUaNNcf8=;
 b=SCp/u2D+1/zniFUUOKUCTW/N/4s+r8H69OL+ZRhQesVY7QvuuDIbyoZ4dYpkh+ix060Z8xlSSbyplrzNIhR6ePXWcPMCPWwttGKEH72RfWTN5NCfg/j/aFiAjEaDGKshzqRJxZjOz9pqOFbEYXl1WXjLICFZbH+kBMVrMJ7Lp3YAE/unzH49vIxiuTQE2ZwC5SjsCYaFXdoWr9Mc2ZGgcmy5iSV2lpe/kIz9nFlVeYqBJFh+CBAXsrjujRFaiXhV136HxzUP/hD01ptQSs4U6zTJOIS5TqwRy5FCcMN6TiyQbK30dTckmxv2bSuYjCFLOYYuC0o8jeyeN6KTDuIdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by BN6PR15MB1201.namprd15.prod.outlook.com (2603:10b6:404:ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:40:28 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::c4de:9c08:cddc:8c76]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::c4de:9c08:cddc:8c76%3]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 23:40:28 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: consolidate common code in
 run_one_test function
Thread-Topic: [PATCH bpf-next] selftests/bpf: consolidate common code in
 run_one_test function
Thread-Index: AQHYT71ByE//Bqni70Gb2FNOEIRunKzwBFSAgAAOO4A=
Date:   Thu, 14 Apr 2022 23:40:28 +0000
Message-ID: <37451216-3D8A-46C4-B2A8-32D7BD934C50@fb.com>
References: <20220414050509.750209-1-mykolal@fb.com>
 <CAEf4BzYRBtx3Oc8xu=dv15wwD-=y8bWm6KE_MPcH33kWMVnCPA@mail.gmail.com>
In-Reply-To: <CAEf4BzYRBtx3Oc8xu=dv15wwD-=y8bWm6KE_MPcH33kWMVnCPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fe01d1c-ea82-49ee-b4f5-08da1e702804
x-ms-traffictypediagnostic: BN6PR15MB1201:EE_
x-microsoft-antispam-prvs: <BN6PR15MB1201FB057D6B692B7C773A67C0EF9@BN6PR15MB1201.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8AQhKL2sIGYd32yx/kY+8c2YIBcgWLU3VkMjecKj5G2AU2wdj3ug1U5hPFQddGEUaDkfZRu2My/ueoDkXGqBUJnPut0qhQTeV03FErJfsK1Bdk66hG0jkTmW1FmGyFUHIvGOMgmEThiuWOoad8CLug1OMY3fbpyrVF+uuDUaFo7n0UTTEAw0UcYN0bJOFhLaYjMKCw4uGiBjHde2hb9ZJ0CUliCZCA6+S3Zke6QIDi6XyndS4TcyKn7pLGHjFrxqhm8dyZf2fLa0bbt+GzAEz1kwEHyHkStRSyEWWJ7hImjdi+PLBUJRRaQRTOBP50Nz062Duof+fN2aArs49xDuApoJgDZZPYoueygqL00gBSIMEnCkmYgfG0gnjuITaxtIkFMC4qu9gSjuXhcgfWCESCG2g1ir1LTGEHH+NWYlFz1lqusI67eWhmP1Sz+cEzKlbpv9myBZmcstvbMSF2PPj679ym2/l8fG0lzvgLM6/VVawsOCLlsFM0cAHGZpeV3JNWkE+palPdtvNcV04kRcahqV2I4EzDIvuQD32s8aYSaiusLftdNpYvWHSL98CEMwjs3dZzCEuV4l2G1YxNOkZ0HWTE2WPLUyKRjqr54sUDeqp789GEfM+hsDifBg59BWW9tRr80Vh4JVK4YzycEf8yoyANOUA6Mu4lKPuEvt+KNa8nmWtTJ3h7HVAz3MxNYrcw6dGe+OUQUzX3uwW89FBxWbPE+1YFtjNbbBrnWdjRVPmyG7AbztOolPRh65+cYz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38070700005)(36756003)(71200400001)(53546011)(2616005)(6506007)(508600001)(83380400001)(186003)(6512007)(2906002)(38100700002)(33656002)(6916009)(54906003)(316002)(8936002)(66946007)(91956017)(76116006)(86362001)(122000001)(5660300002)(66556008)(4326008)(8676002)(64756008)(66476007)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l/MdmXZ9dw2MBn1XN2GdF0WA7CyRZU40VEn6p6gQdt2Q7u7BuN9Y0z5JY9rW?=
 =?us-ascii?Q?SirC4KEsdUfxc4PbWeB8l1Ihyg0JhxpMJIM7fI15oGf/fSGY8yYE+xGZaeVn?=
 =?us-ascii?Q?WamtRfofyqFKh1zUYZqJd9BAcqESpoexNaXipnwrVRTFfQ+Go1a4oSN4Ss8K?=
 =?us-ascii?Q?cVdmP7Qhl/zvciGs2PGuW+WZtBjhJIXHhetXlwzfCKXxlGYHTb/JcdpdY/hR?=
 =?us-ascii?Q?I9m2ky4WA0CVqEOxFSdYqkIVLC02GkJZJUT9zPDntSBDnIhJEBB4WzbQJp6D?=
 =?us-ascii?Q?a0O4OnY8ejUFT/4iIMtTeQAn8bmotqJaERQxqkDE1UvUFoRaROeBofObkduu?=
 =?us-ascii?Q?cZTuUxCCez1a3eVQ5+ey178F083TjDPHkJjc18uDQ++cZL+Zi5agq4K4j5Od?=
 =?us-ascii?Q?3Hf/+JrU2S0oiBaUKUAURKaEuOkRDdLO403KjF53nVcpbpr9BJW/Z5dy5Pcz?=
 =?us-ascii?Q?6jCT3EYDDY6vjtnWm4LyPTVTPsL1eDpwLXLd8VFc0TXgokaQILRJTQGtutJC?=
 =?us-ascii?Q?9j8/QAVBT2W3Way3C5H8e9jVeCPPfrJeuaU4v3Ox79fgMwxzbusBFSIvVU6T?=
 =?us-ascii?Q?P9A5ex8KtahREk7XALuJBVY6TvjshNUGfkCsmOM+nUFyXxouSASSDPqwoRWN?=
 =?us-ascii?Q?fSc6hGvimacp1n8w4JC0G/3KSmBeOZKjIUBl5ClW8ILO67uDF4iSR2yHGb2V?=
 =?us-ascii?Q?3nn/c1wsJqwDGoPu6hF8/GZo1sMpBdF9lpCN1+rFk7t1VoTmNY1Q7COreDkE?=
 =?us-ascii?Q?Yo06wWp5Q3pZ4NFgP5F856xi2d4xMiNdKLgpFzOb2l3zsqCNNnmd9yEM/pxA?=
 =?us-ascii?Q?YUtC3RrmvHnB9cL1/mJXsL1+dJh0cxex4+uNOlxzwAlZyuVlKqdsk+TEZ+hz?=
 =?us-ascii?Q?yj45NJOLSOjLPQJWNJ8/rmeHGXutrAgPgPMNSGoNUgBanJnpdTsujyjhKcA3?=
 =?us-ascii?Q?kI8WZTGuLfK1g1TVSb2DDcJcG4iWJewIOZkDpa/S0BbGzccpppL/5lamkSIu?=
 =?us-ascii?Q?JFeOuLRLcE3BwwPe1mJGmvE0s/BSY8bXRC72hl/ixDj+q7TgVsZuRZVtJPKn?=
 =?us-ascii?Q?vNuCHVr0NTlPwsn2Yshd5cQgq03NF1/KyXT9u5bklywgkGrbb8ReQYyUbI85?=
 =?us-ascii?Q?LC8FnEoImj+aerWQt2Q2IuOuzmAemzyFfRCllXxZM3uevLZDkQkSQTfGWQi0?=
 =?us-ascii?Q?qF2Ch9JleXPe99MLji6sBYAOzdZuU2jPDgAlKz8xX2YxFmFtDFeS19lmL/iN?=
 =?us-ascii?Q?sUR/ye4mOWvGkcqseKdM6aIS9uOeDv2iHI/svQkGzhCJA3CpNHF/4zhpQJ+X?=
 =?us-ascii?Q?TFcgJHmumKGiT2cfH2QuZRiIYIuJC4899ZxVKSVtnjL70L1AJ52D6Q0I8yAd?=
 =?us-ascii?Q?ZD+5UaIy0gkOKrlDrtj9VEjj/gZH53wZCBdxINk6rVKW6QD+4NbLItfG3uyI?=
 =?us-ascii?Q?e3XfPvYwbZWIhDd5KMfO+z5/ndSEQKzcu4jzbUrYsCZ8V6TzND3ZGd1TZvlp?=
 =?us-ascii?Q?NObiBMWVAgs0TZSNQaV4nl2L6Rrj3FAkB0pXQjaHsF57ZElABvM6fNt9+Sjs?=
 =?us-ascii?Q?qwQzyAM4XqChsbW4eaBtZDN0Erd6AVinyGZjHT0yadjVpJ8mWnJj+ZumrqB9?=
 =?us-ascii?Q?sWbbd4GDZPqQLVS8zjSV2K82Fm7d/jX5b6kSIzPYIvhwlnXXSOqPR0qtVMUp?=
 =?us-ascii?Q?41plt2LeKZSTGZcYgwNC1ORD6aerf70Xv5JtOyJOgKXU/YloNJDGfTr+6AbX?=
 =?us-ascii?Q?TtMcKT1bnG1Q98BToPsBW1yagUzoSY2g6dbRCFX1B2+9vvpQy0FG?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <821E7FE3B5F9CB43A9F9E4FCB07D4268@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe01d1c-ea82-49ee-b4f5-08da1e702804
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 23:40:28.2132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HK1HsXYRSD93JUMLolCWpjnllK+aacqN2KTUEWLM0fovrCBFwDp4UFnzaP/EP3cu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1201
X-Proofpoint-ORIG-GUID: sTuMogfk3VDKSsxeYPk3_GLwX1hyivps
X-Proofpoint-GUID: sTuMogfk3VDKSsxeYPk3_GLwX1hyivps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_07,2022-04-14_02,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 14, 2022, at 3:49 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> On Wed, Apr 13, 2022 at 10:05 PM Mykola Lysenko <mykolal@fb.com> wrote:
>> 
>> This is a pre-req to add separate logging for each subtest.
>> 
>> Move all the mutable test data to the test_result struct.
>> Move per-test init/de-init into the run_one_test function.
>> Consolidate data aggregation and final log output in
>> calculate_and_print_summary function.
>> As a side effect, this patch fixes double counting of errors
>> for subtests and possible duplicate output of subtest log
>> on failures.
>> 
>> Also, add prog_tests_framework.c test to verify some of the
>> counting logic.
>> 
>> As part of verification, confirmed that number of reported
>> tests is the same before and after the change for both parallel
>> and sequential test execution.
>> 
>> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
>> ---
> 
> The consolidation of the per-test logic in one place is great, thanks
> for tackling this! But I tried this locally and understood what you
> were mentioning as completely buffered output. It really sucks and is
> a big step back, I think :(

Thanks Andrii! Your points make sense, in the next revision I will keep
this behavior untouched.

> 
> Running sudo ./test_progs -j I see no output for a long while and only
> then get entire output at the end:
> 
> #239 xdp_noinline:OK
> #240 xdp_perf:OK
> #241 xdpwall:OK
> 
> All error logs:
> 
> #58 fexit_sleep:FAIL
> test_fexit_sleep:PASS:fexit_skel_load 0 nsec
> test_fexit_sleep:PASS:fexit_attach 0 nsec
> test_fexit_sleep:PASS:clone 0 nsec
> test_fexit_sleep:PASS:fexit_cnt 0 nsec
> test_fexit_sleep:PASS:waitpid 0 nsec
> test_fexit_sleep:PASS:exitstatus 0 nsec
> test_fexit_sleep:FAIL:fexit_cnt 2
> Summary: 240/1156 PASSED, 34 SKIPPED, 1 FAILED
> 
> 
> First, just not seeing the progress made me wonder for a good minute
> or more whether something is just stuck and deadlock. Which is anxiety
> inducing and I'd rather avoid this :)
> 
> Second, as you can see, fexit_sleep actually failed (it does sometimes
> in parallel mode). But I saw this only at the very end, while normally
> I'd notice it as soon as it completes. In this case I know fexit_sleep
> can fail and I'd ignore, but if there was some subtest that suddenly
> breaks, I don't wait for all the tests to finish, I ctrl-C and go
> investigate. Now I can't do that.
> 
> How much of a problem is it to preserve old behavior of streaming
> results of tests as they come, but consolidate duplicate logic in one
> place?
> 
>> .../bpf/prog_tests/prog_tests_framework.c | 55 ++++
>> tools/testing/selftests/bpf/test_progs.c | 301 +++++++-----------
>> tools/testing/selftests/bpf/test_progs.h | 32 +-
>> 3 files changed, 195 insertions(+), 193 deletions(-)
>> create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
>> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
>> new file mode 100644
>> index 000000000000..7a5be06653f7
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>> +
>> +#include "test_progs.h"
>> +#include "testing_helpers.h"
>> +
>> +static void clear_test_result(struct test_result *result)
>> +{
>> + result->error_cnt = 0;
>> + result->sub_succ_cnt = 0;
>> + result->skip_cnt = 0;
>> +}
>> +
>> +void test_prog_tests_framework(void)
>> +{
>> + struct test_result *result = env.test_result;
>> +
>> + // in all the ASSERT calls below we need to return on the first
>> + // error due to the fact that we are cleaning the test state after
>> + // each dummy subtest
>> +
>> + // test we properly count skipped tests with subtests
> 
> C++ comments, please use /* */

Will fix.

> 
> 
>> + if (test__start_subtest("test_good_subtest"))
>> + test__end_subtest();
>> + if (!ASSERT_EQ(result->skip_cnt, 0, "skip_cnt_check"))
>> + return;
>> + if (!ASSERT_EQ(result->error_cnt, 0, "error_cnt_check"))
>> + return;
>> + if (!ASSERT_EQ(result->subtest_num, 1, "subtest_num_check"))
>> + return;
>> + clear_test_result(result);
>> +
> 
> [...]

