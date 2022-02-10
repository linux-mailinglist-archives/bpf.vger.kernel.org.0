Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8AA4B02F7
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 03:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiBJCCq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 21:02:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiBJCAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 21:00:17 -0500
X-Greylist: delayed 1854 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 17:57:53 PST
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705B61121
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 17:57:53 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219NYMNT000469
        for <bpf@vger.kernel.org>; Wed, 9 Feb 2022 16:36:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mQaiR1N/vY9DqHIWA9TgCZG6ThMzPYpvSPSbS1Zx1BM=;
 b=SDRtnIlrCyN4b09TCuvSDrmoPelp7SEG+B3c9AJQcvL9C/HyeRkXiEivYMrAZ4dSgNoV
 1wlZRWwUvh4CBOULcP1dRrt+9sQpsvtgXWH3z9MsIKSdWvk7KeVuvsIH6+0cJ7eotYWi
 8RpVHW+srUUo6CT0pnGAoAw2xRpeu4fw4Ec= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3y3s9ke3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 16:36:56 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 16:36:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8zf3gek4KRwX5QJrHFGJGlNE5gI4e7bVLmSWt5/3Ntm3eukcvscV0b+3mSq9yql3HwmfVYA5usfdua98tCxdTjawPbcXgK1Lw3PHXlt5wTmRm12zifFG55g32MlV2Ee1ODzJl5q3vGwJxkMgt10G+uu1Z7oYXyjCwzNImdPDp02V9dUiGLXOru3tsJ1tmyZj9CcbRTT19ANKfQSqZSb96H8Y+tDiNO1XeS1g+wgYBehxJnc+7PpdReXf3O40NyRozXGMheKZrPDiWd7iBRAWn8Mxda4qo0luwLyQCEEC8e6rD6/Qw67snz3OIXnALligx017DcmoY1b6vVcAhuHzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQaiR1N/vY9DqHIWA9TgCZG6ThMzPYpvSPSbS1Zx1BM=;
 b=JtpBxuTPlXXNwc3OuoVrUfB543/Z7nUU3n5bUCOJV1BIY4WTey5qDNBaZUTeyBzUgbkJRG22MwKmNZqxVLRCkAaAynqEr/E/A78Ed9/Wu7yXFon9Xs6bTQZa9nNVWCssp3Htkje4O2YzMCJzrTjdS2VI7ZC9DqC03lmn9nhO26CXkSb5LJP3z9jbmE7glLXa1NBhnCjW0MjR7Kei9BLsa1OE6bcXZoHOscnLgLSmbhC6q0WEzhjomsAzSN/LjBbotUs+uvmXMC7iU0Nnc+YmvMrXb1z7v6UYnzGhGZZD6fxltiAfT86XV/OBBU5B+Mk+T8is8cbXRq4hp175jQG56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by CY4PR15MB1590.namprd15.prod.outlook.com (2603:10b6:903:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 00:36:53 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098%6]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 00:36:53 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: add test case for userspace
 and bpf type size mismatch
Thread-Topic: [PATCH bpf-next v1 3/3] selftests/bpf: add test case for
 userspace and bpf type size mismatch
Thread-Index: AQHYHhZMs1nTeF9OrEOrzXLcBPCJjQ==
Date:   Thu, 10 Feb 2022 00:36:53 +0000
Message-ID: <dcb8cfcd9946a937b8d4a93b9c42eaf3aad54038.1644453291.git.delyank@fb.com>
References: <cover.1644453291.git.delyank@fb.com>
In-Reply-To: <cover.1644453291.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 874bc4d2-1754-42b2-e377-08d9ec2d6f3b
x-ms-traffictypediagnostic: CY4PR15MB1590:EE_
x-microsoft-antispam-prvs: <CY4PR15MB159099C9C31E2F0F4EC0FF51C12F9@CY4PR15MB1590.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDKqjDxlHlKAKwLLvp9HtjtchOnqK3jRWba+NJWA7iwIxj4a2KZ/+Z1SgGv4Lwtxbm3hR2/tlcQHSwh1JDETQ++6NJXqA+4PDOOYf+sBxFCRZHqy9JSAisFHm0fJO3zzQAkGqpfcVt4yXbNGGWrFMLBg0LpVwFsftAAwIGySeVV+63QoocJzRkIDZKdSjUSDnUSkCjPcFn8DS7dpHtyASA1a432WWA6xj3T8g9KJ29UDlsIi4hz2DdtMaLoMmY8pl8zHJS9vwclR1ZbGZ1BPXnvAXTTj9LcMO57+GOujGRimTCtLx7jiB93GseXHWwblsKreNn3Z2ZUD0gE+HDJhU4+I25TPH49AgOrsyIKTeD7mYf2F+LRl8lAQWrBD7mdT/C/aoCNbu0rPbXIiWFn7u1r5dD/h+EbJR3XCkKFYA402oJtrZIwerL76NzSZsrgW6XyiQBHan02yOiTJ7uXPNMj4D3YNvu7WWGW+IdN2S9R0xahFfsDzKFZdqsUGLHqDzP62zigcR0FfksVEbjGi2qA6Ip8TWycNlXiDe+FEz7C2L9tPmHvXX6V/PPC5GpSy2NP7HWDqQbGQwMxtoeTZhD2pEOAfmzAjEm3fbd5rjG9oTYv83hIZ8U11/FwzO+cHptXO0VvAjLFwZu3NP+18P3T1uROcCsgBHPz7axW/XoNGkaDUDWV04yMY+K3FYJxnyXcXZRw2sDATsZ4Mma0EpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(316002)(8936002)(5660300002)(110136005)(2906002)(6512007)(6506007)(122000001)(508600001)(26005)(2616005)(186003)(6486002)(86362001)(76116006)(64756008)(66556008)(66476007)(66446008)(66946007)(71200400001)(8676002)(36756003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?imZMw/GJgDCC8XeM7zshQJwXzVQGrdKr/np9kzvM7BZNZBRwAKvZzkF7Y4?=
 =?iso-8859-1?Q?4iypweOskL1MjbzlHqxbbr7GM3tAJdAdD3ti1q8/jnQEj3wfcgERdJeKwd?=
 =?iso-8859-1?Q?khWzFG7zWPXhIknKk4WhNJvWmluMJG8gXcKFpP2MleJ1KVm3igvarK8UjR?=
 =?iso-8859-1?Q?Ov4xwiMYHgu34DPWmvTp9rbNZYbdmoO4AsjcsQCcdjP2YuarP5S1sqbfUe?=
 =?iso-8859-1?Q?j7Uvjx98nBL3kfFt9cqOyo6pNDsrLc8blHuUtfRuzjNHgKeQHkBaElr/Ne?=
 =?iso-8859-1?Q?Owgvv+PusADdj4SPJemKj1daVcFqqeVJTmx2KYkjI/rZYkMdJmToAfZbp1?=
 =?iso-8859-1?Q?uH0BRkCiFCWVaIykYoUbKfsDMhkMhjyNxopYBcKfEuB+s/zcjSjjo7solU?=
 =?iso-8859-1?Q?IG344cQDZ3DCqerqgEiatwqWaDFeXUaDkbHS8OI8XG7hfnOVRZi49nwRKK?=
 =?iso-8859-1?Q?xyjuyj+ATEFZgAF56u/XyotSy+b0brHB0C3Csx+oUSK4dmoXliqZeMG/nm?=
 =?iso-8859-1?Q?FOtvu2Lv08G0Lo+aytXCQvayrSXup6/pIkmdQhfubumyr1u8NjDl2KYoqN?=
 =?iso-8859-1?Q?PNbKkivvhnZ9XJMzzfL6D+4tcOeia6ZpICX+E0R3IDDqq3nwt0JMGgdUUZ?=
 =?iso-8859-1?Q?zUKEs4YSQGD96hRdQQMWOLQdtsBGDwTlUyMmiaZ4e5a+Jweh88rD5YG0Um?=
 =?iso-8859-1?Q?JmPt6OBdi2xpCztcwgMjqWrnxP0Zl+0ENpFFXgMsVdE6TgprIUTeRaLqbG?=
 =?iso-8859-1?Q?PUNwwPYC6CqZrW2r6Ayk5K36mjqtP/9APISyuRKsyULdKiBqwe9lDWZYgT?=
 =?iso-8859-1?Q?hruIksIksFxaR36kCrF7ZgqM9xjxAEEv364cMJTCeOY1LnjM82S4UGIXNd?=
 =?iso-8859-1?Q?E433Fip57BMBcXVU2ufKeD8cbdTUNUqJ8YBEIZNxY59kq+V4CSyKqFVmI8?=
 =?iso-8859-1?Q?a+6XODKJh/LumsQMXO7hLwbWOf1cLTEcgUsWSgDuppgP01diPBo9byhiko?=
 =?iso-8859-1?Q?tX45IRwljF9sJl3V002TDClvZ4qLnAqKna7A2TIBWiEnH8H6ZkyByermsS?=
 =?iso-8859-1?Q?IYB2xnG1SrmM91j39m4/pmkPpThvGQPlCKcnSSo7IrbQzBgCwhECuvLmgu?=
 =?iso-8859-1?Q?YtRHvNAxaPtfNjlBlZP7AkN0/8OpYt8VWYKAoNWi8F1QppLxAxr2GTdNKB?=
 =?iso-8859-1?Q?Q0G2Gmy2oZqV9xwWDszIiOAlyMAlv7C2r5tbj8+Wut2pdMWo8FX8GdNMwj?=
 =?iso-8859-1?Q?VLtp4VvhmgMWWXTnDImGTgcsWdYDURG9d3c6op3TFF9HvGYuoGNzYRV/AD?=
 =?iso-8859-1?Q?WqA2xzx8FDHUglPmZU/Rd370q6okhATAnimy7H/9jbpiVqhPrheQLODdPm?=
 =?iso-8859-1?Q?gDnM6H/0kRDIVouYi1wiRVfMhhSdR2RnPqJpbCj6mh6ycxERg1fhcISgIy?=
 =?iso-8859-1?Q?n+8QJkKyQflkWx9EawFubhclKA2T/qwq1LMrOSv+L9gJdCNQ9KoXMforeH?=
 =?iso-8859-1?Q?kZQbObgd21uXmY2OwYlclyqz4Zo6Nzk7rnMfoRbY1xDlktcHXga8sSWJ+P?=
 =?iso-8859-1?Q?x1ituoGj5MZ/pCjSpMAEeOwuC9D4vIN7/OrF9e6AoK985p6Yo8XX+RI3Xl?=
 =?iso-8859-1?Q?RzH06FmeyZG8A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874bc4d2-1754-42b2-e377-08d9ec2d6f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 00:36:53.2734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cTu8en1yD+0peicL2CzqjieAXydXVgsZ12K3EhOZlYPF+sWhO07B3kyAPLMTuucs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1590
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 3U-7BTlxSYufFHuSjKXlhFWoMmL3rBVp
X-Proofpoint-ORIG-GUID: 3U-7BTlxSYufFHuSjKXlhFWoMmL3rBVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_12,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100001
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Multiple test cases already fail if you add a type whose size is
different between userspace and bpf. That said, let's also add an
explicit test that ensures mis-sized reads/writes do not actually
happen. This test case fails before this patch series and passes after:

test_skeleton:FAIL:writes and reads match size unexpected writes
and reads match size: actual 3735928559 !=3D expected 8030895855
test_skeleton:FAIL:skeleton uses underlying type unexpected
skeleton uses underlying type: actual 8 !=3D expected 4

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/skeleton.c | 6 ++++++
 tools/testing/selftests/bpf/progs/test_skeleton.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c b/tools/test=
ing/selftests/bpf/prog_tests/skeleton.c
index 9894e1b39211..bc07da929566 100644
--- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
+++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
@@ -97,6 +97,9 @@ void test_skeleton(void)

 	skel->data_read_mostly->read_mostly_var =3D 123;

+	/* validate apparent 64-bit value is actually 32-bit */
+	skel->data->intest64 =3D (typeof(skel->data->intest64)) 0xdeadbeefdeadbee=
fULL;
+
 	err =3D test_skeleton__attach(skel);
 	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
 		goto cleanup;
@@ -126,6 +129,9 @@ void test_skeleton(void)
 	ASSERT_OK_PTR(elf_bytes, "elf_bytes");
 	ASSERT_GE(elf_bytes_sz, 0, "elf_bytes_sz");

+	ASSERT_EQ(skel->data->outtest64, skel->data->intest64, "writes and reads =
match size");
+	ASSERT_EQ(sizeof(skel->data->intest64), sizeof(u32), "skeleton uses under=
lying type");
+
 cleanup:
 	test_skeleton__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c b/tools/test=
ing/selftests/bpf/progs/test_skeleton.c
index 1b1187d2967b..fd1f4910cf42 100644
--- a/tools/testing/selftests/bpf/progs/test_skeleton.c
+++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
@@ -16,6 +16,13 @@ struct s {
 int in1 =3D -1;
 long long in2 =3D -1;

+/* declare the int64_t type to actually be 32-bit to ensure the skeleton
+ * uses actual sizes and doesn't just copy the type name
+ */
+typedef __s32 int64_t;
+int64_t intest64 =3D -1;
+int64_t outtest64 =3D -1;
+
 /* .bss section */
 char in3 =3D '\0';
 long long in4 __attribute__((aligned(64))) =3D 0;
@@ -62,6 +69,7 @@ int handler(const void *ctx)
 	out4 =3D in4;
 	out5 =3D in5;
 	out6 =3D in.in6;
+	outtest64 =3D intest64;

 	bpf_syscall =3D CONFIG_BPF_SYSCALL;
 	kern_ver =3D LINUX_KERNEL_VERSION;
--
2.34.1=
