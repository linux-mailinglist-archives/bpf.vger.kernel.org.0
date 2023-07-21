Return-Path: <bpf+bounces-5601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C60C75C4BD
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 12:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDC8282237
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349014F87;
	Fri, 21 Jul 2023 10:34:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC63D78
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 10:34:48 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2078.outbound.protection.outlook.com [40.107.215.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748F9E68;
	Fri, 21 Jul 2023 03:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWScbyITTdwK5oyZspVKxRGPwfc9uejOZ7/ubeLuelETk5rFjLNwSJonCOMllqdPi5hRbpoqyKELnQ8mgMyHZEooflVLQxGk1TzOkEP4oMZuqnjKTVRB5bb6Xt9qRZDgvZAOdoKr/tfMCDK+n8Lu6LNZWTchLayIw+7/zxmj97XlkvndI+IMn0RUudztXiuc+QX9G8RULozjcHHcXWDu9dhQTfafPFgATt5brYJTcDxt37u/Ip0xkeG9+hRMHv3a4dVezNVZ3JZSBCLh1MByMgYGdp++HhRdWL9wAcgmEZqr2iNF5UOo9hbCjOuG11IUc9ceLkPNcyZMJU8KtcvVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgfy1Wrgq5+9oXXfX3RlJDfIHlxXnKo2bk6BTwTTACg=;
 b=f3KOoD6ESYRFaW88ihO1ldhZayBFXFOp5V+3uhtCuuFFArGFvkHHa/seTKPhvxY5+X9GPoN+zOrowO10EG0lTGXwmEY+Yu5EuqT0yG6Kwf8aCwv+z+dejho4muWnfxVz3OoGC3PhPH9PcVpJF9TFehhiHTDW8NI3S9oR/Pn79DVnFFTMFRLsXZDSZXYSIH1buy5Yo+t1L+f+K1mhnOUFBT6wiqDDHqVHhO20+9FwnVksK56qhoy50WBo4bekfUYbCl9mglJAqOxFuHSd8DcTF2/kFlJOv3t+VYLcXo+8jmY/7hLji51glMDffnTXwTDiaA8uncD47uojpt04NzxM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgfy1Wrgq5+9oXXfX3RlJDfIHlxXnKo2bk6BTwTTACg=;
 b=NMZamdgSQgemdui84vBJi5jUObXTwB7nfW0ay1uY4IUKPumAPOVO4HHtEUBOga8sWv7BKINWj3MFyup7OtzF38fr+5BGJ2V7dqF5DkUyDlZna46DlavicHxQmcaFnYZ1DlQaDNnAzAIjyVbpfBCbgUlWHVY0uHmnRa6YWYaofRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4378.apcprd02.prod.outlook.com (2603:1096:0:12::13) by
 SI2PR02MB4650.apcprd02.prod.outlook.com (2603:1096:4:100::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Fri, 21 Jul 2023 10:34:25 +0000
Received: from SG2PR02MB4378.apcprd02.prod.outlook.com
 ([fe80::6bb:cf40:e543:68b8]) by SG2PR02MB4378.apcprd02.prod.outlook.com
 ([fe80::6bb:cf40:e543:68b8%7]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 10:34:25 +0000
From: Eric Yan <eric.yan@oppo.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	sdf@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	trix@redhat.com,
	keescook@chromium.org,
	samitolvanen@google.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eric.yan@oppo.com
Subject: [PATCH] CFI: fix panic in kernel bpf map traversal
Date: Fri, 21 Jul 2023 18:34:11 +0800
Message-Id: <20230721103411.19535-1-eric.yan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To SG2PR02MB4378.apcprd02.prod.outlook.com
 (2603:1096:0:12::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR02MB4378:EE_|SI2PR02MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fe2a79-eb7a-421e-86f1-08db89d60dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e6P+mK7kYszKi3U4XMmT9Uv0efd0E5uIFYDUJHXhvGPPqreSnLUihKKK7/gSbaPnxrW/+HtoMZDdU71ziMs8KOfdh7mwPMRXLMoQXMQ8Cj8BtDTAGlotX7bzhwReHfcmlPRWxbVzj0/UHKQKdIvgt0xHEHHiozMmojbc7QU+QawVDa5kWRTRnLaRetCEfvCPxya5Eki9ePPBHj+fBaHHDBsycZEON4jVaJbbC/UvdMGkSfFZ1v13eVbjqTV7M0caNdq1BZzWmEB9Iag09X8MVvTjd2a3pluYy0hTyrbLn/gffLvNIrqWOGg4WtuMqcTWarNOehYn2Tl2ojQ0SafvBbOEQ3d/29unI3jFGWq4mv4+t+4Eeg2ClHcGeELjZRxrnRahZoXnTSd3FUA8zsbsmvd6IKWWgaGE+VvsextQDaIjSrTQydk/D8A/L/qahvvKeKsG42zz4S1O2jmosc1I+IKwFZRkBZAw6T19NJ+f8UxIHBoUeqQClERU3jceBcU3HYG1XkckbDze6Q6X5YCQmYSSwkWzWr4A09IPlpluo2OtGqxFBIntXAozWRiAR+YzDEJ4S0Xj+U7jN3LqwWJJhkdyigp33GKsW4zsUeuTzTjPqro4sJ88QW9IMCihD2zo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4378.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(38350700002)(66556008)(66946007)(66476007)(38100700002)(2906002)(2616005)(921005)(86362001)(186003)(6666004)(52116002)(6486002)(1076003)(6512007)(6506007)(26005)(478600001)(36756003)(8676002)(8936002)(41300700001)(7416002)(44832011)(5660300002)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RbJfTBdNlatGbXiqvNjCK8qhcjPgxqeZX/VbUVF+Ji88rtfM7YUiRcgHw3dC?=
 =?us-ascii?Q?iaH07n3UkPc+LfM5hMT/ktCYCf1WNPxl4iuzPA/IduWoXK+vhTP86JqAvyYa?=
 =?us-ascii?Q?pch1buHhi5pOQ40WLhObfipGZOBc1eU47M2T1SwzKKCPh6wgi/6ylODo+qe3?=
 =?us-ascii?Q?8kVf7YSiIhz5l8CPDf5XpNByaDsVwYNPAfIT6PfzX6sfIV97oA7ab4Vl4zzo?=
 =?us-ascii?Q?KMpij50yoDVN7YnHtIEC13rKjVQ9V85kn14wuq0/+/xfIajxa9/EcPuRrJtz?=
 =?us-ascii?Q?tjyI9DJqcD2wV08Sfy7o4+vF0KoCDrfqsNkcDTV4dY3CpipXU92j8SKZQh86?=
 =?us-ascii?Q?m4M/wOofYFbJkgssMmhWMbpwu/cq6M/uvX2vEz2Ax7C95kqoWrg3OtAtIXvm?=
 =?us-ascii?Q?BrA/fD/u32lPMXA3xIkeFyIjbXjGHYj3CJnzOWek7vKQTaJu+iVXIw2nUjwZ?=
 =?us-ascii?Q?+XCzb1KZSR+UdoRwfYkRD4CvojybS8s/7X5oJWAF5laakiCwtVRtVDb4qfHR?=
 =?us-ascii?Q?xgWI3S0vSYutnJBh5Zu/MFAolcPZLVVNUuGTcPfDB4Ae9IW8SBUN8Jtu7oI4?=
 =?us-ascii?Q?CEXA6WFVj87xyRhpVeNUHAPipUZ/PIhRw1h2brbchfrA/yOJafb+XCmNVT63?=
 =?us-ascii?Q?LH1GnqurPWogJfvxHNxkOP6PBdAv1PDzxd0SZCchd0/8AiVcPsmzI70Izm4R?=
 =?us-ascii?Q?QGHMEmgOUYLwA8c4o7H4YDiAahn6z6kVKCZzzwYYQurxj+0/bcxnFvhMcN6/?=
 =?us-ascii?Q?Gj30E7sexqOedfWwRUfI94iBzBqb3DRVy2QZzuMGkKSptGcceKYMDS9vHx0K?=
 =?us-ascii?Q?jGWYKXDFhaPv6DgS6IpB5kQDtV5qy7Zt8Geo67J3aWmT7W/HVYRWmbLWwf0g?=
 =?us-ascii?Q?7jO8JeXbXm8HfIUoc079ePA3v2t4UriLF6L7qgO/OvwS4nrmC4cCUOTIumZV?=
 =?us-ascii?Q?+pJuS8FsxfNuIJYNli5BnW0QRxQH+z4X9BF7/ZPWompIV43cYi++YtiTuB1v?=
 =?us-ascii?Q?TQfxyF+r987s+0knNsQWuZduM3buJGnBP/8K0Sa6DPPLbuj3C12h9EpoVoGr?=
 =?us-ascii?Q?gHLYEeMZM+/qD+CJICM2zQL6S8aCTQ/dB6CCXxIy1wbQ3q7XHWz5NjJEqRQn?=
 =?us-ascii?Q?kCMwDzYZwwrG0rJX5EedqASgzhAH+LnV0eVc+SCL3aGGo2R3D+wQqtV9LaQV?=
 =?us-ascii?Q?b0Ts8Q28nHP7+oHrRizk9NGRDYw+WUioTbUnMPOxSMzMUtNCDZEZybqA11Li?=
 =?us-ascii?Q?EnFRTXaZPMjTRbzKhZgk1fffrRAc7FHAhplLf88TkeCplV+02RLFe2GUOxAS?=
 =?us-ascii?Q?8aANrCPaj8/+96rxaz90787FVEiSuKhXHfaKMt3BWp9RvwrAGhic+SeUtaMk?=
 =?us-ascii?Q?BJmgEbpqpOMpJ4dLrC1JMyRIuwZpHK/1+EegdaYLmj9/qwVNVgCVSegJPEWU?=
 =?us-ascii?Q?1tfTBIu1mFuwwAVpEhfrjQHj7nJkjT66ntvr8czHMPAffhQYM8adYaeCsN+A?=
 =?us-ascii?Q?Q8DPn972BG/GTLluE6NFqba/ob6ylJ21lJ9QifDmkYiZoZWbqlYePbZgq9WQ?=
 =?us-ascii?Q?YsIof1GSrIvw2/XlFyFg0gKNGE/VigAddYJsi6HH?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fe2a79-eb7a-421e-86f1-08db89d60dc8
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4378.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 10:34:25.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljkaYO/R27GsH+fjLlo3Wnl+m+piWIqZ2iD+us1JrT49omqn4/GrIFUcdZ/ln/LaLS/WBNM95zZ+tOYtKr5nnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB4650
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

During BPF map iterator test, 'bpf_for_each_map_elem' call failed on
Android common kernel kernel5.15/6.1 with clang CFI enabled.
It has been found that the "callback_fn" parameter received by
bpf_for_each_map_elem is the address of the jitted BPF program code,
which is not in the kernel text section, leads to kernel panic in
__cfi_slowpath_diag check. so, just disable CFI for bpf map iterator.

same crash message on a typical arm64 debian kernel is as follows:
Kernel panic - not syncing: CFI failure (target: bpf_prog_xx+0x0/0x560)
CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted 5.15.0+ #1
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace.cfi_jt+0x0/0x4
 show_stack+0x30/0x3c
 __dump_stack+0x28/0x34
 dump_stack_lvl+0x74/0xc0
 dump_stack+0x14/0x1c
 panic+0x2b8/0x588
 __cfi_slowpath_diag+0x0/0x78
 __cfi_slowpath_diag+0x6c/0x78
 bpf_for_each_hash_elem+0x228/0x304
 bpf_for_each_map_elem+0xac/0xc0
 bpf_prog_8aad3428fbe59598_F+0x184/0x6c4
 bpf_dispatcher_nop_func.17066+0xc/0x14
 bpf_trace_run1+0x1d4/0x208
 __bpf_trace_sched_wakeup_template+0x4c/0x74
 __traceiter_sched_wakeup+0x13c/0x170
 trace_sched_wakeup+0xf4/0x108
 ttwu_do_wakeup+0x58/0x17c

sample bpf testing code:
(based on ahttps://github.com/iovisor/bcc/blob/master/libbpf-tools/wakeupti=
me.bpf.c#L54)

static long chk_item(struct bpf_map *map, const void *key, void *value, voi=
d *cttx) {
        bpf_printk("key: %llx\n", key);
        return 0;
}
static int wakeup(void *ctx, struct task_struct *p) {
        ...
        if (delta > 1000000)
                bpf_for_each_map_elem(&counts, chk_item, NULL, 0);
}

Signed-off-by: Eric Yan <eric.yan@oppo.com>
---
 kernel/bpf/arraymap.c | 2 +-
 kernel/bpf/hashtab.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89b5ddd..4cd400082236 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -686,7 +686,7 @@ static const struct bpf_iter_seq_info iter_seq_info =3D=
 {
        .seq_priv_size          =3D sizeof(struct bpf_iter_seq_array_map_in=
fo),
 };

-static long bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t ca=
llback_fn,
+static long __nocfi bpf_for_each_array_elem(struct bpf_map *map, bpf_callb=
ack_t callback_fn,
                                    void *callback_ctx, u64 flags)
 {
        u32 i, key, num_elems =3D 0;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 56d3da7d0bc6..59e337f446d0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2132,7 +2132,7 @@ static const struct bpf_iter_seq_info iter_seq_info =
=3D {
        .seq_priv_size          =3D sizeof(struct bpf_iter_seq_hash_map_inf=
o),
 };

-static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t cal=
lback_fn,
+static long __nocfi bpf_for_each_hash_elem(struct bpf_map *map, bpf_callba=
ck_t callback_fn,
                                   void *callback_ctx, u64 flags)
 {
        struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
--
2.25.1

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=88=E5=8C=85=E5=90=
=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=E4=BD=BF=E7=94=A8=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E5=
=88=87=E5=8B=BF=E4=BC=A0=E6=92=AD=E3=80=81=E5=88=86=E5=8F=91=E3=80=81=E5=A4=
=8D=E5=88=B6=E3=80=81=E5=8D=B0=E5=88=B7=E6=88=96=E4=BD=BF=E7=94=A8=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E9=83=A8=E5=88=86=E6=88=96=E5=
=85=B6=E6=89=80=E8=BD=BD=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=
=8C=E5=B9=B6=E8=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=
=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=
=82
=E7=BD=91=E7=BB=9C=E9=80=9A=E8=AE=AF=E5=9B=BA=E6=9C=89=E7=BC=BA=E9=99=B7=E5=
=8F=AF=E8=83=BD=E5=AF=BC=E8=87=B4=E9=82=AE=E4=BB=B6=E8=A2=AB=E6=88=AA=E7=95=
=99=E3=80=81=E4=BF=AE=E6=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E3=80=81=E7=A0=B4=
=E5=9D=8F=E6=88=96=E5=8C=85=E5=90=AB=E8=AE=A1=E7=AE=97=E6=9C=BA=E7=97=85=E6=
=AF=92=E7=AD=89=E4=B8=8D=E5=AE=89=E5=85=A8=E6=83=85=E5=86=B5=EF=BC=8COPPO=
=E5=AF=B9=E6=AD=A4=E7=B1=BB=E9=94=99=E8=AF=AF=E6=88=96=E9=81=97=E6=BC=8F=E8=
=80=8C=E5=BC=95=E8=87=B4=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=8D=9F=E5=A4=B1=E6=A6=
=82=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E5=B9=B6=E4=BF=9D=E7=95=99=
=E4=B8=8E=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9B=B8=E5=85=B3=E4=B9=8B=E4=B8=80=E5=
=88=87=E6=9D=83=E5=88=A9=E3=80=82
=E9=99=A4=E9=9D=9E=E6=98=8E=E7=A1=AE=E8=AF=B4=E6=98=8E=EF=BC=8C=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E6=97=A0=E6=84=8F=E4=BD=
=9C=E4=B8=BA=E5=9C=A8=E4=BB=BB=E4=BD=95=E5=9B=BD=E5=AE=B6=E6=88=96=E5=9C=B0=
=E5=8C=BA=E4=B9=8B=E8=A6=81=E7=BA=A6=E3=80=81=E6=8B=9B=E6=8F=BD=E6=88=96=E6=
=89=BF=E8=AF=BA=EF=BC=8C=E4=BA=A6=E6=97=A0=E6=84=8F=E4=BD=9C=E4=B8=BA=E4=BB=
=BB=E4=BD=95=E4=BA=A4=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=
=E5=BC=8F=E7=A1=AE=E8=AE=A4=E3=80=82 =E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=81=
=E5=85=B6=E6=89=80=E5=B1=9E=E6=9C=BA=E6=9E=84=E6=88=96=E6=89=80=E5=B1=9E=E6=
=9C=BA=E6=9E=84=E4=B9=8B=E5=85=B3=E8=81=94=E6=9C=BA=E6=9E=84=E6=88=96=E4=BB=
=BB=E4=BD=95=E4=B8=8A=E8=BF=B0=E6=9C=BA=E6=9E=84=E4=B9=8B=E8=82=A1=E4=B8=9C=
=E3=80=81=E8=91=A3=E4=BA=8B=E3=80=81=E9=AB=98=E7=BA=A7=E7=AE=A1=E7=90=86=E4=
=BA=BA=E5=91=98=E3=80=81=E5=91=98=E5=B7=A5=E6=88=96=E5=85=B6=E4=BB=96=E4=BB=
=BB=E4=BD=95=E4=BA=BA=EF=BC=88=E4=BB=A5=E4=B8=8B=E7=A7=B0=E2=80=9C=E5=8F=91=
=E4=BB=B6=E4=BA=BA=E2=80=9D=E6=88=96=E2=80=9COPPO=E2=80=9D=EF=BC=89=E4=B8=
=8D=E5=9B=A0=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B9=8B=E8=AF=AF=E9=80=81=E8=80=8C=
=E6=94=BE=E5=BC=83=E5=85=B6=E6=89=80=E4=BA=AB=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=
=9D=83=E5=88=A9=EF=BC=8C=E4=BA=A6=E4=B8=8D=E5=AF=B9=E5=9B=A0=E6=95=85=E6=84=
=8F=E6=88=96=E8=BF=87=E5=A4=B1=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=BF=A1=
=E6=81=AF=E8=80=8C=E5=BC=95=E5=8F=91=E6=88=96=E5=8F=AF=E8=83=BD=E5=BC=95=E5=
=8F=91=E7=9A=84=E6=8D=9F=E5=A4=B1=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=B4=
=A3=E4=BB=BB=E3=80=82
=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E6=8A=AB=E9=9C=B2=EF=BC=9A=E5=9B=A0=E5=
=85=A8=E7=90=83=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=EF=BC=
=8C=E5=8D=95=E7=BA=AF=E4=BB=A5YES\OK=E6=88=96=E5=85=B6=E4=BB=96=E7=AE=80=E5=
=8D=95=E8=AF=8D=E6=B1=87=E7=9A=84=E5=9B=9E=E5=A4=8D=E5=B9=B6=E4=B8=8D=E6=9E=
=84=E6=88=90=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E4=BA=A4=
=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=E5=BC=8F=E7=A1=AE=E8=
=AE=A4=E6=88=96=E6=8E=A5=E5=8F=97=EF=BC=8C=E8=AF=B7=E4=B8=8E=E5=8F=91=E4=BB=
=B6=E4=BA=BA=E5=86=8D=E6=AC=A1=E7=A1=AE=E8=AE=A4=E4=BB=A5=E8=8E=B7=E5=BE=97=
=E6=98=8E=E7=A1=AE=E4=B9=A6=E9=9D=A2=E6=84=8F=E8=A7=81=E3=80=82=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E4=B8=8D=E5=AF=B9=E4=BB=BB=E4=BD=95=E5=8F=97=E6=96=87=E5=8C=
=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=E8=80=8C=E5=AF=BC=E8=87=B4=E6=95=85=
=E6=84=8F=E6=88=96=E9=94=99=E8=AF=AF=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=
=BF=A1=E6=81=AF=E6=89=80=E9=80=A0=E6=88=90=E7=9A=84=E4=BB=BB=E4=BD=95=E7=9B=
=B4=E6=8E=A5=E6=88=96=E9=97=B4=E6=8E=A5=E6=8D=9F=E5=AE=B3=E6=89=BF=E6=8B=85=
=E8=B4=A3=E4=BB=BB=E3=80=82
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you ar=
e not the intended recipient, please do not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that arise or may arise from such matter and=
 reserves all rights in connection with the email.
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract. The sender, together with its affiliates or any shareholder, dire=
ctor, officer, employee or any other person of any such institution (herein=
after referred to as "sender" or "OPPO") does not waive any rights and shal=
l not be liable for any damages that arise or may arise from the intentiona=
l or negligent use of such information.
Cultural Differences Disclosure: Due to global cultural differences, any re=
ply with only YES\OK or other simple words does not constitute any confirma=
tion or acceptance of any transaction or contract, please confirm with the =
sender again to ensure clear opinion in written form. The sender shall not =
be responsible for any direct or indirect damages resulting from the intent=
ional or misuse of such information.

