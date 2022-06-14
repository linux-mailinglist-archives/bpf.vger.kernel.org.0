Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A722E54BE2A
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 01:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiFNXKx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 19:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiFNXKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 19:10:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1D150B2D
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:50 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EMcqs2006248
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dYXhyYNUU6QlU3s2VrtJhEeZ8UHskZN6vKNhpBYMOFE=;
 b=R7WphPP7gUD5rg6q+fGSGattTk3fbommk+Af5gyhVYLb/MahHNa/6QeW6qr8JmP80+m+
 ljAlPFRnt+IhxHID0KIDH4fjJdUv2B/JIXl75fGEFDXZL8031rkKMHyghpXNTG/ePL3k
 5LAnT8vjXfaZ7DcuwBtNg1kBJJK4TurKdIA= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gpht16dws-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIYZTK5MzGxrr5ry2dMiLLbTJ9AoxRVEswQ4WOW8+bqkrv3PWQOAnyyWuCrQnW5EvZwB/JrxXjEXjpoywA3jc2I+oX4AGCO5mSme5tKojFb9gi1Uv59Cf7FfsUxNpnpmtFpqJTFRuOIK3+AVcA3+Avm5anMpuHQYL21+hB9+oA4x3zZZgfYkVptyv1eIfaSmN70/W1+Ry5hP0utdpgMSLxXLReXjbD0sVVbFKVKe+Y4d2wvqnND+xb98c3R0Syzry040FG/azM9FL4GSC6HcrHqY2VfuY+/QAL2v5jYXU4flmkUEzqseEsD7OazMtcjmZHAVaobjvfSg/u1n8VwdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYXhyYNUU6QlU3s2VrtJhEeZ8UHskZN6vKNhpBYMOFE=;
 b=g3wpWIgrxMZkwUahp7qr1vynvCR7d7jx4Ta603JbrRBWdWDulxhQoVh5dfQJDc+3bqqfSssH3W51vByWGlBl82T3GEdcvZCHDdcdvGrBProJnuvKOLDDpUGO5eGB/yFzUrn82EV1mjpNknf1Pg6JvzHpwaur9McICe5u7W46m8OLsHzxSD9rj4gjkO5q1PZYBT5dyLJlqEUTfBrMgXZJeFFCc/QcKpoSS76sHxPX6cTx3TS9BfvdGQWwdunNNqylUBv8A7rSfWofOorXlJsn1KOJWAHNcN7UdzLeuDVW7VoDzdQDKnbswltfI/1MV9jSWYDFF60+cPMKYNETKa63MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM6PR15MB2665.namprd15.prod.outlook.com (2603:10b6:5:1a7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 23:10:47 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b%9]) with mapi id 15.20.5332.016; Tue, 14 Jun 2022
 23:10:46 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4 2/5] bpf: implement sleepable uprobes by chaining
 gps
Thread-Topic: [PATCH bpf-next v4 2/5] bpf: implement sleepable uprobes by
 chaining gps
Thread-Index: AQHYgEP6z21FSZhSH0KwohIX05SbaA==
Date:   Tue, 14 Jun 2022 23:10:46 +0000
Message-ID: <ce844d62a2fd0443b08c5ab02e95bc7149f9aeb1.1655248076.git.delyank@fb.com>
References: <cover.1655248075.git.delyank@fb.com>
In-Reply-To: <cover.1655248075.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a4e2f9b-2760-4f4e-4923-08da4e5b1d57
x-ms-traffictypediagnostic: DM6PR15MB2665:EE_
x-microsoft-antispam-prvs: <DM6PR15MB2665A402DD238EE79CA7B231C1AA9@DM6PR15MB2665.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJvR99Z0lqED7/rnmf00/UTbAdPYLH4n2RRurfdTw6uGXbQ9MEkirIpZW3FzX373OqSzh/6sgSOs4GI0fwLbqJ2SflRLXO0m/ALYA3+vRdn6OgNkQJ/G1LIVjRQ5GgBtgTACoFfPLsByRxYzdzQQkIAcrnb1Fw5Hw3HW4dv+Luk3othWzk5LC6BZdBSm8P37MoZaT+O9sp9RLjazTZVmd4inhxjuoOgYTDUcJdKMI9kP23w0BRGY4KdfaafjB2pYfKjk/iRoJQQkUEeyAq0HQ8RsyaJe6GZEYN7kqlQ0NMTZf9Pc72RAKICfaMPm5xKA5DzjQ15PJ3TXjmU9jVr4lXuKeBKv4zHL1HCeZPKEsvzJuJsJQ3Yqtr6QgOhmHLxzHMPDVABqZdV5lbs2zQEnMz9k44nxM1ifitCwaNu96OvIt0WAYUfk0xKfbgtUuLLKhH9jBZnejazmE8gGLogOCqbiIKKboi2iLOqLGBReilAl5FRDKFZK3c8yj1QbS5UiLflMgUU800TihCj+lk0632RRa5p2a0YGB4zNFI1SVrpMnhl5XqLB0TsAh+szkJNo1lWG2QfA4+IpU34/H40J929PqQxBQ6xdrs79FPWKsqRFz+THDrRgtye5Bk+OioCVo0a6C0qufvP9MSyL+HoTAZ0pKGPl6CYQ5Xu0QAcJ7Q6aQu7ahI6KgLspG/J0bcTEwLXow+eEr0DoPLF8ErxeRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8936002)(5660300002)(508600001)(71200400001)(6486002)(36756003)(38100700002)(6506007)(110136005)(76116006)(86362001)(66946007)(38070700005)(64756008)(66476007)(66556008)(91956017)(122000001)(2906002)(8676002)(316002)(2616005)(6512007)(66446008)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gcLr1VTJI3jpzRok/dAF2Vb4O+SWA6c4o+t+F7Kqv24zR9V7dZI8DQ+Xbf?=
 =?iso-8859-1?Q?2wVuA3X+CSS6jmqXnVvWEFpZ6nD5apORccbCslAgYAryiR+FhPIJzEixqY?=
 =?iso-8859-1?Q?HKekLV8gJPJI+f+HaHmZjOTb8PdZm0s+cqffIwcaVeu8n+ww56sCeIVl0F?=
 =?iso-8859-1?Q?DnB/0g+5ULe7xelDKOQTjZnIrAJpf2NI7KAWje1Sb3TsYVfQs7St93hIxb?=
 =?iso-8859-1?Q?wL67LRJo4UiWDoq1CFSD/XN4BfhXLs5/NSi/eQ++R+0LxKM363pkj1CV7D?=
 =?iso-8859-1?Q?q+9QvMkvHKpDl9fAEZ9SLclRfo11edtv1bjTqEJvHnw9YDDRREgeh0wEIS?=
 =?iso-8859-1?Q?X66pvr8jF9AriwdzZggsKWwl1tiSXmZcq6xq0uG8MMDA85UvKy7gTbVB2i?=
 =?iso-8859-1?Q?Elo3Ry6ZHUnmOJU3uVepGf/FHQaKDqkTDosV0zVuYK9HddEJkX2pbp/Ymg?=
 =?iso-8859-1?Q?zsvQssfq7soKt7S+zRxFz/kxdv3pwvE+xZUp0VsEcspgCl/q/wApJNSc8S?=
 =?iso-8859-1?Q?XFFDbs/QgqiefAJD9IURhw6KEjOVLYQN5WIllw/AiJnvDBmu6YbQqItSZH?=
 =?iso-8859-1?Q?skLxbeC9vDFJY0SP77EfTmil1N6IMNiP5hAllLS0o1fod3d1QhsMCk+d/k?=
 =?iso-8859-1?Q?iMrtHOysxPnJXsOyEEhX61aXN94HajjL+L9iP1bkeu6qrAOV3EUxusMrrM?=
 =?iso-8859-1?Q?Cyagh8ftkCwNvFEd0lEhhi/8rYEgXZ8tuMlnURXdxR/bSpaYFYfr32xncA?=
 =?iso-8859-1?Q?J98RbeJWKcHiu90fJNWj3wvx5mk9mcpJJXEw7kZmquPU4Io7cI/emT8blp?=
 =?iso-8859-1?Q?SWhq3vGmNKtwxYpznn4SENHRJo0uLt99ZRX82493BTqcecPzlGpn5BwK7O?=
 =?iso-8859-1?Q?gHFdwqExkWBLGzdt4kkJcKgoAqbB2U6AFN9kbtszGXFLf0hQIfg+I+vMxm?=
 =?iso-8859-1?Q?l5caVrRsdIlV6WU601rJcEhJXMaarTJOSAYp2aiCIv3sYPuIcrOBfEkk1S?=
 =?iso-8859-1?Q?opMsnCk0uxrfzhYAAb0DaWmkclL2oCrlvxYhMSKiyWB0elmV+JrG4p0bTJ?=
 =?iso-8859-1?Q?5HtGOqzEFUlowBgRQjPrwPKslF9XwhECTdvktBD8faaCxTeiHFEeERAAMK?=
 =?iso-8859-1?Q?VeAklq5Q879SktcPGK9EYZoAp3pVsReG1H/gWFaVmk2e9cHPNkMKe5aezg?=
 =?iso-8859-1?Q?Xrm7z4jXFuwYeBfu9KElekcufg+BMklHa/AimWwv1gt9wRa3XLPxwq++++?=
 =?iso-8859-1?Q?EEccUSnrwwGV2dhkr1DoosH5xnzEOAlzslh5OZoGMHbBXh23inMwZC8gn4?=
 =?iso-8859-1?Q?tFf9ZVLgX3kZlx0Ifc220DjW4IZaGP16XO1C4inkifYoULBLGXg7Zh+BoC?=
 =?iso-8859-1?Q?OtvmFzvlkOAhD0wuH935Ka5rMJIqtCUYVberRxfr1W1vRYWYuKQ69ophRM?=
 =?iso-8859-1?Q?h8XWJyEBx3JpwPyUBnwOzMWIEQjmHb9r1zgDSTRbDC6LePSRoGGUGjM800?=
 =?iso-8859-1?Q?2Cnik2B90I73rME2a/ZOQVxQZ0hefMZq/QHUdBH1b42bNorSetNoO16i3i?=
 =?iso-8859-1?Q?bPIWuVbCnXZtsySfLt859q6LeIA35AUOD6GCPcArqLw9Qoo3q1jOgYGufG?=
 =?iso-8859-1?Q?rX0KFcTaepjeFujrfJt1pX3bqcdQN9Tq0Wrb+ANMsxbyB/rGiALV+L9QR/?=
 =?iso-8859-1?Q?95WUYd46L6FBKxajEbRCR36qgHNITl3I9nEbE9yFgLtMskPdb7WlIr4LcW?=
 =?iso-8859-1?Q?8PfDsUcMm8KfGlOI8FafpBg41J9xYgTZRdSHZsn9H0/05Ck9go+tBCATkx?=
 =?iso-8859-1?Q?rWum2PPDfkPh7/4XHsGF7TYm0FUVVVjIneODOFaCydSmVo1cCOC3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4e2f9b-2760-4f4e-4923-08da4e5b1d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 23:10:46.6971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rDcu9J3uyKdKtCHuDoUQpMh03G5zdYCw7LL9NGJOBxh4nZCXF057SwcI8Qh8nq2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2665
X-Proofpoint-GUID: IjXujJGMF8I_MDIxvnc9-hY-ugjS5Fwq
X-Proofpoint-ORIG-GUID: IjXujJGMF8I_MDIxvnc9-hY-ugjS5Fwq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_10,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

uprobes work by raising a trap, setting a task flag from within the
interrupt handler, and processing the actual work for the uprobe on the
way back to userspace. As a result, uprobe handlers already execute in a
might_fault/_sleep context. The primary obstacle to sleepable bpf uprobe
programs is therefore on the bpf side.

Namely, the bpf_prog_array attached to the uprobe is protected by normal
rcu. In order for uprobe bpf programs to become sleepable, it has to be
protected by the tasks_trace rcu flavor instead (and kfree() called after
a corresponding grace period).

Therefore, the free path for bpf_prog_array now chains a tasks_trace and
normal grace periods one after the other.

Users who iterate under tasks_trace read section would
be safe, as would users who iterate under normal read sections (from
non-sleepable locations).

The downside is that the tasks_trace latency affects all perf_event-attache=
d
bpf programs (and not just uprobe ones). This is deemed safe given the
possible attach rates for kprobe/uprobe/tp programs.

Separately, non-sleepable programs need access to dynamically sized
rcu-protected maps, so bpf_run_prog_array_sleepables now conditionally take=
s
an rcu read section, in addition to the overarching tasks_trace section.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 include/linux/bpf.h         | 52 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c           | 15 +++++++++++
 kernel/trace/bpf_trace.c    |  4 +--
 kernel/trace/trace_uprobe.c |  5 ++--
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 69106ae46464..f3e88afdaffe 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -26,6 +26,7 @@
 #include <linux/stddef.h>
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
+#include <linux/rcupdate_trace.h>
=20
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -1372,6 +1373,8 @@ extern struct bpf_empty_prog_array bpf_empty_prog_arr=
ay;
=20
 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
 void bpf_prog_array_free(struct bpf_prog_array *progs);
+/* Use when traversal over the bpf_prog_array uses tasks_trace rcu */
+void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs);
 int bpf_prog_array_length(struct bpf_prog_array *progs);
 bool bpf_prog_array_is_empty(struct bpf_prog_array *array);
 int bpf_prog_array_copy_to_user(struct bpf_prog_array *progs,
@@ -1463,6 +1466,55 @@ bpf_prog_run_array(const struct bpf_prog_array *arra=
y,
 	return ret;
 }
=20
+/* Notes on RCU design for bpf_prog_arrays containing sleepable programs:
+ *
+ * We use the tasks_trace rcu flavor read section to protect the bpf_prog_=
array
+ * overall. As a result, we must use the bpf_prog_array_free_sleepable
+ * in order to use the tasks_trace rcu grace period.
+ *
+ * When a non-sleepable program is inside the array, we take the rcu read
+ * section and disable preemption for that program alone, so it can access
+ * rcu-protected dynamically sized maps.
+ */
+static __always_inline u32
+bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
+			     const void *ctx, bpf_prog_run_fn run_prog)
+{
+	const struct bpf_prog_array_item *item;
+	const struct bpf_prog *prog;
+	const struct bpf_prog_array *array;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_trace_run_ctx run_ctx;
+	u32 ret =3D 1;
+
+	might_fault();
+
+	rcu_read_lock_trace();
+	migrate_disable();
+
+	array =3D rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
+	if (unlikely(!array))
+		goto out;
+	old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
+	item =3D &array->items[0];
+	while ((prog =3D READ_ONCE(item->prog))) {
+		if (!prog->aux->sleepable)
+			rcu_read_lock();
+
+		run_ctx.bpf_cookie =3D item->bpf_cookie;
+		ret &=3D run_prog(prog, ctx);
+		item++;
+
+		if (!prog->aux->sleepable)
+			rcu_read_unlock();
+	}
+	bpf_reset_run_ctx(old_run_ctx);
+out:
+	migrate_enable();
+	rcu_read_unlock_trace();
+	return ret;
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e78cc5eea4a5..b5ffebcce6cc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2279,6 +2279,21 @@ void bpf_prog_array_free(struct bpf_prog_array *prog=
s)
 	kfree_rcu(progs, rcu);
 }
=20
+static void __bpf_prog_array_free_sleepable_cb(struct rcu_head *rcu)
+{
+	struct bpf_prog_array *progs;
+
+	progs =3D container_of(rcu, struct bpf_prog_array, rcu);
+	kfree_rcu(progs, rcu);
+}
+
+void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
+{
+	if (!progs || progs =3D=3D &bpf_empty_prog_array.hdr)
+		return;
+	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
+}
+
 int bpf_prog_array_length(struct bpf_prog_array *array)
 {
 	struct bpf_prog_array_item *item;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 10b157a6d73e..d1c22594dbf9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1936,7 +1936,7 @@ int perf_event_attach_bpf_prog(struct perf_event *eve=
nt,
 	event->prog =3D prog;
 	event->bpf_cookie =3D bpf_cookie;
 	rcu_assign_pointer(event->tp_event->prog_array, new_array);
-	bpf_prog_array_free(old_array);
+	bpf_prog_array_free_sleepable(old_array);
=20
 unlock:
 	mutex_unlock(&bpf_event_mutex);
@@ -1962,7 +1962,7 @@ void perf_event_detach_bpf_prog(struct perf_event *ev=
ent)
 		bpf_prog_array_delete_safe(old_array, event->prog);
 	} else {
 		rcu_assign_pointer(event->tp_event->prog_array, new_array);
-		bpf_prog_array_free(old_array);
+		bpf_prog_array_free_sleepable(old_array);
 	}
=20
 	bpf_prog_put(event->prog);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9711589273cd..0282c119b1b2 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -16,6 +16,7 @@
 #include <linux/namei.h>
 #include <linux/string.h>
 #include <linux/rculist.h>
+#include <linux/filter.h>
=20
 #include "trace_dynevent.h"
 #include "trace_probe.h"
@@ -1346,9 +1347,7 @@ static void __uprobe_perf_func(struct trace_uprobe *t=
u,
 	if (bpf_prog_array_valid(call)) {
 		u32 ret;
=20
-		preempt_disable();
-		ret =3D trace_call_bpf(call, regs);
-		preempt_enable();
+		ret =3D bpf_prog_run_array_sleepable(call->prog_array, regs, bpf_prog_ru=
n);
 		if (!ret)
 			return;
 	}
--=20
2.36.1
