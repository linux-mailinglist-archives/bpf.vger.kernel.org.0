Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16FB607F1C
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 21:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJUTgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 15:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJUTgo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 15:36:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D8262069
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 12:36:42 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29LJSLb6005486
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 12:36:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=PV3qPWlbwtYzG9YAD8PfhqogXGoFRI0rScJZVK/vC80=;
 b=hSkEN3Oo9881GsEndBjfdvmgD3atIQDU+yuyqlZzMcWQJnwh4sCnyrIaUbW20nPTX3TR
 eGlNtDk6MVZBINkmLt+gV4wnh0D4mf5V9VvoCs3kgwz2/1SUZYSnh7W0lTfrrvTAhyhV
 Y7cGr6IpOSfKVirAH3sGa3CLFCd+Cgk6lYXVbJJUwtXetvVm0H5Ch1TOEtNfras8tbw0
 mtlhz8z7IiIIzq6FcdyQjKGmFrhy0+hAKMVdysXzcqpvyuG+UsPD5wMjfEHNcy3HhDfy
 +9GdWUD/GuPY9L/kqWXs2EmxoRGgKRKToYxPT78t/VFn8EQwqTeWpSCSuQbbXSSDOVka /g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kb2qpsny2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 12:36:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM+HDJPnOqytpiI0jMRGqjLXw73teGQnOWUJgtKjAYgWrgxt7Gg8q/CGKm9C56yP+Fw0Fk+k3laCOg6gQUxvdrFXIxkKULchqrjbXl+ffMrmirYHH9pnT4Rs1mCFWX3mRauttLVpE2QWEIaYJpcAT6fsYiuvZ7wE1rYSlyurqRykeivube7YdmgxLW6P1rSHo1TlhMnsISzo/km0CtRIOmLKzLfKRuOeh4q6L28M+DoVvE80N1z8G6dLVB57syBqsrE/E5HzLPsyAA7pQfG/7eD3kNq3qw/6eVLfmcPFHkCZJ0g59QBcOJoCAUOt3XmvkSctHxBBSEEYWRe41uQO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PV3qPWlbwtYzG9YAD8PfhqogXGoFRI0rScJZVK/vC80=;
 b=l025iLmuvXKgD3ZQUuNyv6RZUbD3HzTaOuf5D2ge0fniTMiePlSE/ejuWP3zxj0Xd0EEHRVh0xowSvFjjuMQZ67UlJp2zsXZuUDVB6l1G0LyMi65hXSg5bB941bb4LfJYApaufo5nOTSVs36ufoX0g00VICwCy4aDA7llyDAblKhRWRTZJpj3J5TY6t5s67TOIIFZPjCwPT+uTGvBreWLwT9mnRFb/yUpwPTVmt75M765HOxFtt8JqCw9Mn+rDHQOo+yHMU0frS7eqm4KSABDCcuXkF95hmHqglQ7uKaIpNignQ2pTqh54QEy6EI9inBUaS+RxkfcUB5jvU5jE4lMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by PH0PR15MB4382.namprd15.prod.outlook.com (2603:10b6:510:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 19:36:39 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::dc6e:8db4:b01e:4e0a]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::dc6e:8db4:b01e:4e0a%8]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 19:36:38 +0000
From:   Delyan Kratunov <delyank@meta.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@meta.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3] selftests/bpf: fix task_local_storage/exit_creds
 rcu usage
Thread-Topic: [PATCH bpf-next v3] selftests/bpf: fix
 task_local_storage/exit_creds rcu usage
Thread-Index: AQHY5YRwT4PgrkqU5Uq+9nL41GYcmA==
Date:   Fri, 21 Oct 2022 19:36:38 +0000
Message-ID: <156d4ef82275a074e8da8f4cffbd01b0c1466493.camel@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5154:EE_|PH0PR15MB4382:EE_
x-ms-office365-filtering-correlation-id: 7c0500b3-98ad-4e65-71cd-08dab39b92ba
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKA0DOTxVVtaigy8AWfqUYY/mcZZka7jQ3UffF1pQrGjZ7/W1MnV9rZ4u5P+P5afP4TD+mm1IvV4qEJbGZR5vlSzstRW/4WuD/LnPU9FhBIG+9D8DB1nrVJJIsxZQWFevgt2mrvurEOGO6RXrgm2BFyhW5c227jw8HsRUZKN+R0er8p/395qkyoOlZzHOEcJP7bYw49gwW+17Y/f1WjZViwcSsI50rnkNVcP+LNx06cYup44fBcMfi4goHaMaRmKxw4b6m3NOER6u1a57el/1eiuZ1BF+u4Ixme3zWB7Je/I7t14h3+V2jAn+g2ZMa7PBwLpttWNK5K9POeAg6Rdn1cjUItzKg30rtf3Hz99GQR+JNhQ/bQPJZZ3DmecREOtVwYSGoe91mmdWabSHQBuXxbhWu9Kkt/62ZTxoYPULIVY74SrhouZYIU0zg/RQBohLeV8APtjMxSlIjutCqJRw7NA2bpZFIZ1YR29nPLDa8Y2rWXjkb1LriYUCDRZ+4JAFXQdgySQjyWhJv22OK8/oFdXEVd499hExbFbYlvG2WUMR32zpUeyeyncdJUuzfEbWAGtfNOJRuGtHQlDzKmjNA3mDEBM0aZDtD1gYtkYk4q7I/ZDBPUwQKuY9YJnA8mfprjNto2GtQBsq7KF6lctLhruI98uOdte0dUm0qMepb69qRR13AIieVtQ3uNWRwnK9a6lA3HjuZBCXyRBEYEgxD8MBPaumu5g46X2XQaaT9d5hr1sxueDLgCAnz9mVTif9dRW4gOke1sxh9MX1Xr2q9LcjcrITvFwe2ndV+1SG8A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(966005)(110136005)(38070700005)(83380400001)(2616005)(86362001)(122000001)(2906002)(38100700002)(186003)(41300700001)(5660300002)(8936002)(6506007)(71200400001)(6512007)(478600001)(8676002)(64756008)(76116006)(66946007)(6486002)(66556008)(66476007)(66446008)(316002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aejylLbLtDYPFlENglTF0/3uq9ga3Wu9AiTEsjBJejdDC95F/0j83UKEYL?=
 =?iso-8859-1?Q?jVcfAhhH5fb8N6sNV5/8WQM0fnggTcUn+9IJOYt6n8dwGKxdOmyQb+l9fD?=
 =?iso-8859-1?Q?HOEPg0HVs3Ifvh8bBn0hQGux54oAfMzN4pUhXg60KKZ6zyiGeagKOZUFRk?=
 =?iso-8859-1?Q?PfHRKnWdo2nhPzfOPmcFvnve7XhJAnTpVuNUAtgo0AGJ7ajFvKgprawgi7?=
 =?iso-8859-1?Q?6/HBnXDSJwgK3Ups+nnf/RljPi4a17MprsaGXdsF1AWTyq9jBxyl45fSkQ?=
 =?iso-8859-1?Q?WYp2PsGUS9g+Zo0sqv70Q262AxBWHJuZJtb/g5CgVbjK5twlxkhOjRESqm?=
 =?iso-8859-1?Q?8CV5xIeRr/jKjc+eu0B5k2szXTj8iflnvo1EKlZ83jqPKL9g83B3+ABGUo?=
 =?iso-8859-1?Q?nzBmDv1bigGsmixBsz8HOgb1tfA8oHIUri9WumJu4IVyg3+oYQIOQUyWSn?=
 =?iso-8859-1?Q?PVCDUAHsfmjofCWGG5TLKH7uThWH53JrGbtHe/CQIFMYTP3kGihBbf9EW3?=
 =?iso-8859-1?Q?rHIbZFE7zmytUjFC4O+OaGDrVcf8XrolM8zL88BlD21DrCP0QTtD5wsNz/?=
 =?iso-8859-1?Q?g76i8rRckNCDd6ZZPMN5M7hIomWYKJ7WjOgQHdaK3ZBYHW04tZr7Xz+ijm?=
 =?iso-8859-1?Q?0fCdP/b/I7ckTiwjiBErkYPbSTwswwitNo4Jo+G8DGJAdyfQlMEY28jzB9?=
 =?iso-8859-1?Q?UG51HfNh0GXyzow6BskMC9+o+6GnTKwzW7p1tNxmSHR1i34OhwGT0aGVrb?=
 =?iso-8859-1?Q?dJ6SS3XDXCSPpfPKEEn4HttzJu4lWkaVJjvtxCffoyOTvEXNid+neiGDBb?=
 =?iso-8859-1?Q?0O91npIO5MA1B4JOCX3o27pFrYMBws9Yr4WCYQqObdjOwQd1j/xKs0PxAh?=
 =?iso-8859-1?Q?NzZ1h5wmLlCo70Cn7XPUXPH1c0j7jSRNYd1vfrGHmRAq6bGWelVz9cx50y?=
 =?iso-8859-1?Q?9Pe877BVGr0AAlA5dk/tHj4kLPOM9ahOjLWswmZp2xHdsUdQ/DK+mSMqtg?=
 =?iso-8859-1?Q?+ssnDXWmZ64bK04M5vMPfcM+3A0rNxown13l+Sdc+lkJJ7vhPSraV3CNyq?=
 =?iso-8859-1?Q?Sh+LnEIXB1VY5oC7n2KHoRrq4KWj0xbcEWiWxB0fcof6IjZkLBruicZDHZ?=
 =?iso-8859-1?Q?V77B11eo99xeRgDMd0wdtkpuCda/0Z4Li8zS+cjvOdKw3Aw2IcqsQCR0B7?=
 =?iso-8859-1?Q?2+8j/BAtEUEXGSN9gqIlM60LJs6kJpKFfCxi/WPJtJvowY5tbHFS9unx48?=
 =?iso-8859-1?Q?Qq2JwRLZGpajjZ3oy5Z9REiVj7INHICh+cyH4x+3g8olFJ/aguvb65ySdK?=
 =?iso-8859-1?Q?khCnhYfAeLBDl8VRrgW0Tfx9PExW5Hw6vEDJUYd41d+qR+jFmqbS6jgmcN?=
 =?iso-8859-1?Q?BZbuiArSlSY0DjuJ3xQ1ttvoxBNXrs/Pr48tFZ0TTATpikrcfyaLB0oD56?=
 =?iso-8859-1?Q?AFPAS0dZ33hkrfs1T0X4lbHiebCIRERlzbtb6mOT9YhbezhNEzrPaQO+nX?=
 =?iso-8859-1?Q?KN7K4rQh/97ObZCR1z7maR0arsicGV4SHZWuBNhzpzwbD45tdc5LgyFr5+?=
 =?iso-8859-1?Q?lP2v5Rwp+vkooQFgnJLr0wdMSDGqnbPCha6SwWk29YGzPiriWBHPdrxsz1?=
 =?iso-8859-1?Q?QAfYVl8TkKRskbGdLsnI7h7utsu0ksCLfrqmEQLaLUJu8tKzxLajftB0JW?=
 =?iso-8859-1?Q?A6XO6GrpXHLXRMIc6uk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0500b3-98ad-4e65-71cd-08dab39b92ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 19:36:38.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPwJFvWhZiBVFhf9l/C7gThmilF8ntMODyUMZaJL/Z976/dNAgxSvnJhjnPZK7LTAAzz8N7oiVSBkCZeu/y7IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4382
X-Proofpoint-GUID: GnR8-loj4pWr6qOAB3UYdjlovWVP0kSL
X-Proofpoint-ORIG-GUID: GnR8-loj4pWr6qOAB3UYdjlovWVP0kSL
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Delyan Kratunov <delyank@meta.com>
---
v2 -> v3:
Fix Signed-off-by line. Love when my email gets silently rewritten.

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
