Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DD46036A5
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 01:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJRXZG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 19:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRXZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 19:25:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6834F5141A
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 16:25:02 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IKLOYI013032
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 16:25:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=y2rUjwoLTTZCf6/ARjBLktJNsqr7FHQbp16oxWvDtnE=;
 b=efhczROiA8uUSMXTmIA9ipIeXshJXI+mqyXtBEl+KKFYZtIOz2ZhNuvuT0pj3NlPW0mU
 T1lwDsI6ZcZ8lyO/kjQf+kLntNNPZKGBufsIrCE/lCMTGHbbGafmXni6RHmULyZSRzOT
 kIh6Hrwtsv/gPVBGmLf3ES6lP3JSbRfL702bJ2Dyk+Fd2lW9wGIHZ/bX0he75C74khm6
 p7tPSIPfr9dsVMRvlou+iktOhbo0knxkmZ+9DzGv9ObEWNM6zhzOcpJyqW9+I+c0qj+k
 AWtMB0mecro1J4Td38hvdN6awWgMuPNDddDnffM8GBgtRdGzc/cArQRYkxYDK3wdTXj0 bA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k99av9xek-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 16:25:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9Xh5fCMCya8dzciBrlyzzNagSU4DRGF0rxk/YhSxS57nMRISSioRaldc/P/4lF+9MMIU8+5P7CpQH+LzhYzKIzHqa/zLs5GJEVx8Z6NTcmvPaEuRnyX0sESTKws/rWqzClGJB9ia9Z8kaTk4eqF5fbdgk3j4tjG9g5BWrgSmpyO9DkBio2kZAaw+J6Ds5xV0QXFPlAknOpyyty8Gbl5DRqtTqU/pdueVAx6jt8wsPi6bFJtzo/WBUKbgfZWwf/3AbUGr81Nyo9cVDQhv5dqp/GlCvZiWTYDSmUJsvYzrRn/wbv63wUjwkqlzUInYQEw1m7DQwJs0SUogRBdYny+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2rUjwoLTTZCf6/ARjBLktJNsqr7FHQbp16oxWvDtnE=;
 b=HJFP5IUxgSlMBex82T+Nu6mhRXqh+xuD7YR7XECXQ0/hz/+09chAiy80EX5cXT72tzbHvJtECquDjlpMts70xuuEXi4jngyiExVg2M7U3uGP6zk9gw3LQY10kLnkRzh2Yt8wYNMi/R+XbBx2pwVZWQ/i1rDiH/DpQwxW+XrmHFfEaQx9obIfy6E2b2gXqjDvtDmJ3ktwlwDSKu+h9Izd/M0uMXCC2IbTwqGOTlzOAvLvc0I8lcJ8gn1w7yaulWfcjFhOi/fh/ZCYkhLHzuoAwC14rVb/sNUY3B1/Fz/GrUGn0VYHdoZoDggEXthLt0URKELBrhb3aidx2rpd8TKEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by PH0PR15MB4606.namprd15.prod.outlook.com (2603:10b6:510:8a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 23:24:59 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::dc6e:8db4:b01e:4e0a]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::dc6e:8db4:b01e:4e0a%8]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 23:24:59 +0000
From:   Delyan Kratunov <delyank@meta.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@meta.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: fix task_local_storage/exit_creds rcu
 usage
Thread-Topic: [PATCH bpf-next] selftests/bpf: fix
 task_local_storage/exit_creds rcu usage
Thread-Index: AQHY40jWdVenM4OYGECE7aDifqYrSA==
Date:   Tue, 18 Oct 2022 23:24:59 +0000
Message-ID: <f7ee957a031f746400b97b6fc7730fda21bdb742.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5154:EE_|PH0PR15MB4606:EE_
x-ms-office365-filtering-correlation-id: ac9d407c-5fcf-43dd-0ca1-08dab15ff98e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eTOr4ATQF5f5l45ezK42M66bIE0P0AQlxufWvsSNpS6f8UXTby/0yrH6bQ4DCIyi/pW9P/vSo7IbWYMUBvBzKwACggtSQ2f+98bl+KgY5KdFvDJc6zObfMK9ZT/Ykm7eVRC8ESvY/XZbTVzaUOuD3Pq4xkpu2nHeAU9v812Dgas5+j5NjYC3ny2Ih/EK5TJp9TwVN/1nwY69Vr9I+Y5ueA51cI5HOXPGuFLKqM9kDZaCQIYaUnbBaflr8cZsQAqOGmsSEtJt+VsSuB0W7UNevisLvnlG1fxcdkXetOLKxusbB5hKYi0izh18ih3bmMNJwOgfiaJ+uU8zbmTJYKVkALETIOMQiq6F0yAb4S8+QXW5vyX2UisNnHFaaCv52Ug48t8jk1SZft/r0IxUrHQpjHOgHQXko9jkkEvSDgVO9zrQ6rWjP+keuAmQZ81WWGdheY0+D559+vgfTVYdAYa9Xxpt/qzowg3qlsx6P/llWwwekD8NRScOlklFzkzNFRdnjFqq3xJMx6R3fpmtcye/83EHgFUQy63adtHFV5ca6RsY8ZfN3Tj3Ia9vOZNeP5Nz41qQcDhb0StUJ2JNbpNq8eu4uhxJWOxtPC1Uv/H8lyQCpJhxSfqiRpJ/TWnWd76XOovRBTK3dtL1kftyWHT2Fk1T2jwN+hprY3QWuirYX+YbodoLMxGo8MMyRD9s1bGGi5keX4KiR2Lkws2uJ7ISzw61WlGWaPOoZZ7VLVMiwkpWi7FrTW+aTU+02FLq6xk6cZpldOilAdfDAp8w7oJOCmrQU/3Or/Xx29IBlJY1tfQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(8936002)(6506007)(5660300002)(122000001)(41300700001)(6512007)(38070700005)(186003)(38100700002)(2906002)(9686003)(36756003)(66476007)(66946007)(86362001)(83380400001)(66556008)(966005)(6486002)(71200400001)(478600001)(76116006)(26005)(66446008)(316002)(110136005)(64756008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?95XcBVGVmrEqxA6II2iJDnBwAbOjYj5kYAw4iCVrTdT5ah3qJpTttYYVfa?=
 =?iso-8859-1?Q?ltXBTYNzBkTXqbTVLorSuHSPGB1qfzXurmWiZutXsVi6DP448jMS+uXsDx?=
 =?iso-8859-1?Q?lYp3/FdUrc3WoEGNYARuNmHR6ZgvmV87XV1t5iE//6CPdiVEfSvNmGGeUo?=
 =?iso-8859-1?Q?4WSTD70ZznvICjzrSvr/8g5Psq7EaA4/swXC4P0B44t3jPfucm3qVILQFo?=
 =?iso-8859-1?Q?PjJTSZFsxuZcq26AWCClHiUTQPaO4aRU7X2VnprHvELWQOM+cgXUG4hgSC?=
 =?iso-8859-1?Q?rZ9ukF6+IlSi86pU49l2g2UUf9U1vXDA0n4/VTRs+mVOaurV/cvhOZTFiJ?=
 =?iso-8859-1?Q?Nxll0m+QZAVqGP+QImAcOuvg5m2TqnfhhC1Xg1wCBfMD3PgKxL2IUue4Oy?=
 =?iso-8859-1?Q?OmGjgGBGvakeqPhuewMIJFlbrvHLV5fQBfrpeZ6w6F5jE31ZMkCH6z8uuK?=
 =?iso-8859-1?Q?H74pNXuoBsmHWscjGrRosmHPlxNXIsmDYU5PzkKsRqiNDOm+lVXCODKBqZ?=
 =?iso-8859-1?Q?proTh4zdPXGZIiAVkWDfT0K2KkAQGdBKaQnMMeMyA6J8tw2zDgePWlS1kY?=
 =?iso-8859-1?Q?wseX4J5C4KC8jiEsaPj2HU/B9fZGMdp1388rBesvRPyL/4aCfJ+T80Gzw5?=
 =?iso-8859-1?Q?kJl89H9fXMw56E0unCjsEBqAAdFL90ky38vtIj14FxjjVI0EXJGlZkAO9B?=
 =?iso-8859-1?Q?oDTuyKqKZXYUGLCoxOPjl2Fvrom91Zn5WRaLzXbrYvrjuLVHCANXPkVr+f?=
 =?iso-8859-1?Q?+MiR1bYTEzn3K5uZjSw7Q7eFUEN920416tOmF07S3LwDp/mIuSQ/8/ymuR?=
 =?iso-8859-1?Q?2llBQf+SQ8bkwvtEdLaUza/zw8nEFyoRZqssrWzRW5PdbK48OFqupKA9Fe?=
 =?iso-8859-1?Q?l+fflDDsY0eIZXaBqzonPzJaEVG3MRelPXSpEI/5Tu77PhCIDJtCFbKupt?=
 =?iso-8859-1?Q?HEa/gMZ/kpvyf04e0K/MQ2Bvim671JKaw/s/jHGsRia+co8JXuuc+itbpv?=
 =?iso-8859-1?Q?PFtpud5qDCPn6aEWu8gq22FXkXSJraXZ7rvytNXg7qeiSAahfkJia6s1Ip?=
 =?iso-8859-1?Q?GohhjfYW+JlJYSpGmBeeU0p4NInyYW7Ac8+4MmiqxE4MJhK233Xw7fOtap?=
 =?iso-8859-1?Q?CAB5K9Y47oxjMvGYHD0xUaKqYKowO9fyqzQ9Ii16MYmhcnCRUIkV+gRKfR?=
 =?iso-8859-1?Q?ElMFIItUk9twbK+29eH7rMSkxS8K8n+QM6i2HisNbf/1Ki3Z9vhhOXPd5d?=
 =?iso-8859-1?Q?GuDJSJzWM+IK+C/upmChXcrYuCfWspko7rKVucU4X568IUCbSDqJamSqxl?=
 =?iso-8859-1?Q?TxzGHNuc9Xn1pT6BghAY3PlrpCih2KWu3sP7b2Eqbt0d43X7qjmxTEYIEM?=
 =?iso-8859-1?Q?8xOf+1EDIBCv8D+Ap5VViu7kk3yqAxh0/O38iFrM1d5c/sq5jFlQ/5UUO5?=
 =?iso-8859-1?Q?KBb5FwPWwpxkzP1VuXIAG/gBOkRKJNCxnkdk4ZVOwoTf46nx52eVfRL2JY?=
 =?iso-8859-1?Q?mwFD4UH7CWyUN2uFICcoVJSlaoZPgdP3mBrnuJi77a+7pcSlZr2VGNv+Ig?=
 =?iso-8859-1?Q?DHsgH/F4xLdx7+QhhOpe0eGw5dTg1BtniAycCjwhUxFzcQ/hYvNCQ62tyJ?=
 =?iso-8859-1?Q?6ZEcFbRPk4E6JOb7alTZmzSjhMms+TIY7q?=
Content-Type: text/plain; charset="iso-8859-1"
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9d407c-5fcf-43dd-0ca1-08dab15ff98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 23:24:59.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSozBtTQP+TZXHC4rqXVVbh49tKtgg7mzpsdj7Lx1YVfNL0r5pb0y/tnqL4iTRTL+mG64qhocD3CxLXXbcVEkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4606
X-Proofpoint-GUID: kUHPiQwnM62jEcwdKF-Z_QsneplpOyom
X-Proofpoint-ORIG-GUID: kUHPiQwnM62jEcwdKF-Z_QsneplpOyom
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF CI has revealed flakiness in the task_local_storage/exit_creds test.
The failure point in CI [1] is that null_ptr_count is equal to 0,
which indicates that the program hasn't run yet. This points to the
kern_sync_rcu (sys_membarrier -> synchronize_rcu underneath) not
waiting sufficiently.

Indeed, synchronize_rcu only waits for read-side sections that started
before the call. If the program execution starts *during* the
synchronize_rcu invocation (due to, say, preemption), the test won't
wait long enough.

As a speculative fix, make the synchornize_rcu calls in a loop until
an explicit run counter has gone up.

  [1]: https://github.com/kernel-patches/bpf/actions/runs/3268263235/jobs/5=
374940791

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 .../selftests/bpf/prog_tests/task_local_storage.c     | 11 +++++++++--
 .../bpf/progs/task_local_storage_exit_creds.c         |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/=
tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 035c263aab1b..4e2e3293c914 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -53,8 +53,15 @@ static void test_exit_creds(void)
 	if (CHECK_FAIL(system("ls > /dev/null")))
 		goto out;
=20
-	/* sync rcu to make sure exit_creds() is called for "ls" */
-	kern_sync_rcu();
+	/* kern_sync_rcu is not enough on its own as the read section we want
+	 * to wait for may start after we enter synchronize_rcu, so our call
+	 * won't wait for the section to finish. Loop on the run counter
+	 * as well to ensure the program has run.
+	 */
+	do {
+		kern_sync_rcu();
+	} while (__atomic_load_n(&skel->bss->run_count, __ATOMIC_SEQ_CST) =3D=3D =
0);
+
 	ASSERT_EQ(skel->bss->valid_ptr_count, 0, "valid_ptr_count");
 	ASSERT_NEQ(skel->bss->null_ptr_count, 0, "null_ptr_count");
 out:
diff --git a/tools/testing/selftests/bpf/progs/task_local_storage_exit_cred=
s.c b/tools/testing/selftests/bpf/progs/task_local_storage_exit_creds.c
index 81758c0aef99..41d88ed222ff 100644
--- a/tools/testing/selftests/bpf/progs/task_local_storage_exit_creds.c
+++ b/tools/testing/selftests/bpf/progs/task_local_storage_exit_creds.c
@@ -14,6 +14,7 @@ struct {
 	__type(value, __u64);
 } task_storage SEC(".maps");
=20
+int run_count =3D 0;
 int valid_ptr_count =3D 0;
 int null_ptr_count =3D 0;
=20
@@ -28,5 +29,7 @@ int BPF_PROG(trace_exit_creds, struct task_struct *task)
 		__sync_fetch_and_add(&valid_ptr_count, 1);
 	else
 		__sync_fetch_and_add(&null_ptr_count, 1);
+
+	__sync_fetch_and_add(&run_count, 1);
 	return 0;
 }
--=20
2.37.3
