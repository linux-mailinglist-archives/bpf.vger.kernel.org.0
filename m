Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F55604F2F
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 19:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJSR46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 13:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJSR45 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 13:56:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B046A1C8431
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 10:56:54 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29JGXtFj006003
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 10:56:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=xNMDgTVU+SSuZdnqtFeslnsns5Msx7PD3Q7ZjVVQ5MY=;
 b=Y0f3tcbL/i3w4l3AAr1qoH8t1mHG1e8Amz3FP1QgzQAKqs6j3rXa4GtUnsx68Iq0jVIB
 nH2pqvheX7S0cetUXJXWzUwKlk3LimIV5XS031j2qmKIq6ZJz5UrJViojA5LDTvGOy9p
 6boPXJkSE3+1Pn/oKguZNvNR2XiyU7IWgCQkGfc8fXHOYOCD2DrFJjU2e6kWsYxg+G+X
 Q5F3ob/9S6iwRAaNNh7vLDRNAM20sFM8hZ/cwgM4idKdHWZL41AGslg15XKplJuBFdfU
 aQofLWbikUjXJ/FBuCL3GG63C1hmuwnGylYMrElX3ut5ae8ipgX82tULFHo7moUaT/hZ aQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kagxa3qfv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 10:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsjHsv3hBq+sS+ao65wfE8v5+BPfnwXFRIDa4K1P6k7FQyVT/kyVJHGB4Yn2ocQvhoEVBzwtIsAZ8VMe4HdjxQt2ZjC8rr7VduXlBfp6AXcQ174KIkTpX6sjV+Uv1a/2Iw1jIVEZa9Kpey6pEXm+h/qZTgTDBP4cIjyxdepbnINr70VYylhuTpzgtb1JUJOSkYtXxT+02zBiE78vZxxPguo6XcyBuq45RUGQzP6dwMj2FDjPhEKktihqvgs6pTyoZWlSvcdXZK14yQysQPKf5G1V3BMOHOzOk2uPkDiCmon9Ce2DDO7/aruMwqRhaNa1fcqyCIvwozhCoOT+jHwE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNMDgTVU+SSuZdnqtFeslnsns5Msx7PD3Q7ZjVVQ5MY=;
 b=MBlf3VruYEg2OBzerVABaeSuDcLR5/ULJI/04GTE6agopbYN0ycLq9n+CzP+7r7QfdTfOgjbmRRMw5YyaujtCBN3LPo3oAfNdqu4G1Oigm+oNvzJeGTwctbwCbubBqfTNuW3OxL297LsHP8hawPponVd3gTSGuq8aYDF43jLbOMzPk/w0xVLqjOlNKp05JPaUT7HaZYr/y4Za1BBfjb9Ymu19LkO/bEeiO8r5UEQ0b+Y+g1SYCuVnE9/ab2If/sKKXdmC8+2o0GGiqEvps2H2sGueW91GdrOufo5qqryj+/g3bX73joFagzN70mgRaLHujJ5OzmRYXruIAVH3sB9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM6PR15MB4313.namprd15.prod.outlook.com (2603:10b6:5:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 17:56:48 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::dc6e:8db4:b01e:4e0a]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::dc6e:8db4:b01e:4e0a%8]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 17:56:47 +0000
From:   Delyan Kratunov <delyank@meta.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@meta.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2] selftests/bpf: fix task_local_storage/exit_creds
 rcu usage
Thread-Topic: [PATCH bpf-next v2] selftests/bpf: fix
 task_local_storage/exit_creds rcu usage
Thread-Index: AQHY4+QojlLgRyr2OUGFA67ekA7AnQ==
Date:   Wed, 19 Oct 2022 17:56:47 +0000
Message-ID: <f04cf27b05047cfb2c90db160383e2e9c2c40b93.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5154:EE_|DM6PR15MB4313:EE_
x-ms-office365-filtering-correlation-id: 120a4506-8ab0-477a-6ef5-08dab1fb4aa0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DsgcFBr2uxRzjt6Rgk0MSaYA9JzgMsVqxZj4dxC9L/SSZIOaP2YpiubKCdm0qx7XlPjgYNn4fGZUTdtw/G33iUvbud4hfLNOjo0F1zfDic58OTVWJYyp5WHpCEESpv5a+SnG3pQMV62boeJIv29KOItg2bP5HaE+eDS4VMgDDmtIGM7fLDYA75VmIIrrkkuA3wCEr8H2wLVrfH/P7iOhCi354ymyJ9yO0+lj1tBaIHlA4dGWNMnrMADHArGJjxgSk6jb+CYcbPQVrzl3oq1emG8m+QofSE4ORapQE3GAB2PXIDOSs80PjKtwNRaCo9TlVyKSrL5XXN//r3xbQwIyJzRzaSept6VTlZmUxwFNVPQ6i9f6NW0egjbsInG/x29SDaGKL0QORo5vwSNgEW1urP346zpmP0cTWtj9NYwY8rfxEjpyiQeqb0ud68etJTeW8OLwbNY2tG6Zmc+Yz2KrRhCuPjMQ1j7NQ08pR91fu5z0CXs8AGPITWwYp2WDXejilfYNVupMxd7s4fk+b6VWuksMdnTjna/sNVBsoM2x8Ksd391e9jskcWDosC632IE6d5fNAkl4ZoKPOzrHv9DWTOlWBAbRGzLoRSdHKK7qfZ0k6y+sid/FSvprId9x67QcvqBabcRNfFsux10lBnlDsJ3Jq4327xwHa++02cVDUoErcylpgqPobJRnd7HbQgK6Un3XOwGOFCKS/7aylZf4O7eBDySLmZYuSkYs/BYpIyUaMvGUKQwX9TJI+gSf2r9vYnpac0OwxBLfuncod5xiDorriJ1zVR1dESVzCqKAE+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(71200400001)(478600001)(6506007)(966005)(6486002)(8936002)(110136005)(8676002)(66476007)(76116006)(36756003)(64756008)(122000001)(91956017)(316002)(186003)(66446008)(38100700002)(86362001)(9686003)(26005)(6512007)(38070700005)(83380400001)(2906002)(41300700001)(5660300002)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UZ5ACa6HGjjI/EJ5qv0x8p+cysRLB7XIS+mGB5MyDWPYMcaJTHwtaUva2s?=
 =?iso-8859-1?Q?PDbo8gh7qb9Us0Ig2M6/f5PcyEIx4GB4gNtfw+abvMtTnnK4ravlfCVqTc?=
 =?iso-8859-1?Q?4srVUcK7wW9K/bQ/ys5dAtCrQZpsNnXZvjVtn0Puh8jJVJQxAAKhPl13cf?=
 =?iso-8859-1?Q?xMmV13ZqSM/zE+jiM2zR74SO2s7vlywf/p4FnNaQa17BdbKHwGng5hT4Y5?=
 =?iso-8859-1?Q?b7TcysVA0Q21w59bfNxr27IxvLuKbnYRtU1EWHPQgzJSi6EX/9/mQbtPIx?=
 =?iso-8859-1?Q?+OPW2Co1K+7KxvL1VLhx7wJs77Nzyp2xmSzZUZPdKaI8gBo02ju6fF+BiQ?=
 =?iso-8859-1?Q?AgVrz43gyvi0qssEABgwWv7EclnAsnbH/B2p65B4+0szJs+k/js0e88qTB?=
 =?iso-8859-1?Q?KQFHwUNDAxn3ibGRCChSl5bPAIFpKHYAUYGtnY8VIN9+uU8/kyxpaWidKK?=
 =?iso-8859-1?Q?SNTx1bx2WTLPNDN2JiMWA9PBRSsfj8Y+ThZofm7wC5k2Nl+whT9p5hF1am?=
 =?iso-8859-1?Q?a0pAff809QC+7uywnmT2M8ySfRK8mFO39bn+PCw5Dq7ulsUEqqFUOKxUOb?=
 =?iso-8859-1?Q?iLWS+RN1tlVe9XQX8GomjA9h4BJ0MIFP0h2Z2BpyrFmlDqXsAtm5qezd5z?=
 =?iso-8859-1?Q?+R5wblRyb6IblmAAaDY8RM2/HIsmF9I017pfwvM152JzF0pCNAWi+XOSSb?=
 =?iso-8859-1?Q?lE3f+z0xQRI+vj7y8t1wRrpe7fA1Ywa9aIhxTCxmVBBQUxJzafndQ6dOlw?=
 =?iso-8859-1?Q?JbrnYgtHN8FvNWMnTtEc+UkheurW1Y66JDhPqtqCvAywvit3bcwGbPAnLN?=
 =?iso-8859-1?Q?hXhhXgt05cJXmMEYKaBqOyUAY6bIGgalPf4wduk0PGgzeJ92QUdgUayXaQ?=
 =?iso-8859-1?Q?nQZly+ZGzJUHqE/xaIsYz59kerz1e2ZB5N2HD0DT4+USxquCMq61JnZqSJ?=
 =?iso-8859-1?Q?MlgMl06gjU24EUkDAgNnMsIE49lk09oL7g1PMwaC1Z8mIFyy10tqJ3ALUr?=
 =?iso-8859-1?Q?m1Fdq2cR85BzWB8rHVJh9e8m5PzWD703iKbaB5oIglKR/2lJJyufuRL/Cm?=
 =?iso-8859-1?Q?idrMHEHbALwQJTA4wUezpaQwG+idfjhS0QndkCmLjGnWKDFMPeoAZEAE1g?=
 =?iso-8859-1?Q?J55VSvJH4AYpYijY+Xc5idENrcy6iqijM+0vOCi2F1qHIsVSg+63shipFB?=
 =?iso-8859-1?Q?xpSAQ0Jho0igj61vfGHTM0lQ1zfq7uU5Uga0oFuWnzdKKU35RWgHSpoH5T?=
 =?iso-8859-1?Q?osx88yId+hgnceoW0dhHGknSUAHg48rtkMnYejLgBo1VufHvOx6spnyNGS?=
 =?iso-8859-1?Q?/LMuTDv24Gwzbhw0NTt4JXgRy2neNLIOnAZkYlUojLpv9I+HDnFmNPhcPY?=
 =?iso-8859-1?Q?R2QQlWZ0qphYimZHnFeNVP4q1kbHXfhn53mKfwxMBSFHswMyYbxq3OFXJG?=
 =?iso-8859-1?Q?mHNAdHp7gw6AtyXi8efDi9Oh9gvhwcuF0TzHZN6sVw7rVzZZ4kmK5+5yMm?=
 =?iso-8859-1?Q?z2IdJVGqRP//U78qg4DFjIMa+gNEqzKT80JT2NTBaGXtIuEfJdaviFumJb?=
 =?iso-8859-1?Q?4wXDB0EX7zGt+lziyxhVRWHsDNK0q5q5EIOWhZ3+M7hRI1DV8/FYyYgUBZ?=
 =?iso-8859-1?Q?CDL7+1mjp+5u1CzeBsDvqCHObHqq5sYLrG?=
Content-Type: text/plain; charset="iso-8859-1"
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120a4506-8ab0-477a-6ef5-08dab1fb4aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 17:56:47.2813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +kUO7hLQrXOb1y9V2xxeVfkVlbMA7RjJOUBswQZ5qCWXL2duODP/1M3qeHvuS8/5nY1xve2zKkzMHdQj4nAORg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4313
X-Proofpoint-ORIG-GUID: LmwtjZFv37Biwh-LNko2rzNkX_Dgb1Ea
X-Proofpoint-GUID: LmwtjZFv37Biwh-LNko2rzNkX_Dgb1Ea
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
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
v1 -> v2:
Explicit loop counter and MAX_SYNC_RCU_CALLS guard.

 .../bpf/prog_tests/task_local_storage.c        | 18 +++++++++++++++---
 .../bpf/progs/task_local_storage_exit_creds.c  |  3 +++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/=
tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 035c263aab1b..99a42a2b6e14 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -39,7 +39,8 @@ static void test_sys_enter_exit(void)
 static void test_exit_creds(void)
 {
 	struct task_local_storage_exit_creds *skel;
-	int err;
+	int err, run_count, sync_rcu_calls =3D 0;
+	const int MAX_SYNC_RCU_CALLS =3D 1000;
=20
 	skel =3D task_local_storage_exit_creds__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
@@ -53,8 +54,19 @@ static void test_exit_creds(void)
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
+		run_count =3D __atomic_load_n(&skel->bss->run_count, __ATOMIC_SEQ_CST);
+	} while (run_count =3D=3D 0 && ++sync_rcu_calls < MAX_SYNC_RCU_CALLS);
+
+	ASSERT_NEQ(sync_rcu_calls, MAX_SYNC_RCU_CALLS,
+		   "sync_rcu count too high");
+	ASSERT_NEQ(run_count, 0, "run_count");
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
