Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF8B517A77
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 01:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiEBXNN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 May 2022 19:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiEBXNM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 May 2022 19:13:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D632ED78
        for <bpf@vger.kernel.org>; Mon,  2 May 2022 16:09:41 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242LsdoG001183
        for <bpf@vger.kernel.org>; Mon, 2 May 2022 16:09:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jVyssEgTJJ9C9I0Q04yH7v/dhvwLDX9rRjAdoj6a63E=;
 b=VMpp9eBi8W5EC5HE8NwerWA4ZT0p1z5PxXSDw2BhuhOkbkcnrJBIcxoITzjCy1HB+UEB
 FXu9mszU8W2Dmau1H2f2EhDLH3/j6s4+ABIX1KgZ1D1nzKM/3l2JmkT23S3eJmYFJNR8
 UqolHcUSwEh7I0xIEq+/pVnOtYmgWflbTEg= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fs2mxchjh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 02 May 2022 16:09:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnLmT9g1Pnpr5++WW4NRwNNaNmRjwY1KMtOambWghXUXUR90nHy8ibV+cyJJ5CG3SVCA7ERM0ZNhtx0/7DYiWnSUp2PxCGh/RTe2Ja9nmbuP/G6es/7FLq8WfdEBKRDwjnX/hfBo6GXtLg5qzriQDZBqiNlATrJMExbqJt7coGe4C9UXhf0wtqBdVtwRyk0S+e6hMMguMNV+hut3MNEPi0Tws4a5PySWEKKdR80T631f8/gCUhd6UCLdjmxG1qWxjJfkmvTiKDJvmx1KphkOdyE889vF3i58+RS8tEoJTDahsh/UdjaQDbUAdlSukujFwesyCZndF+uDaahCCJ6iIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVyssEgTJJ9C9I0Q04yH7v/dhvwLDX9rRjAdoj6a63E=;
 b=czMlqTT2KVjJSa9KDhBn3v5tMiSpepr84+D9cPOIJhmZLZ1rnd2bwUrZZVUZs5wrvgLApy++xjOvgW0UIBFA23b1cgOvFjXsLBJa/r8sCEKI+RaTRrvDbr6qAVhJVlaZHrsd8xi8DH39RcDicCnhZUZg93R2LqE05TfNDrtJkp3RCT+EdiXfM6yE7o7eDBjWcFM7gMwC74ReRUMguu0BYtuX3IaZIcT4Gd9nTbUmUxMg9THVNyoq5BHkXtC4+Gmv8GPcMNJI0wI4lvvQ6id5BIMiAJqarJJaWv+Yk9aZsgf4iul66XjjN2lhrO1V3/gDCbYb3C+aPeYiBGoagLt1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB3141.namprd15.prod.outlook.com (2603:10b6:a03:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 23:09:38 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%5]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 23:09:38 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 4/5] libbpf: add support for sleepable kprobe and
 uprobe programs
Thread-Topic: [PATCH bpf-next v2 4/5] libbpf: add support for sleepable kprobe
 and uprobe programs
Thread-Index: AQHYXnmx21JjhfMhQ0etNT+Dye61yw==
Date:   Mon, 2 May 2022 23:09:37 +0000
Message-ID: <e109e32027ffa592f97ffe12854803101c85376d.1651532419.git.delyank@fb.com>
References: <cover.1651532419.git.delyank@fb.com>
In-Reply-To: <cover.1651532419.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da80a80a-46a9-489f-df26-08da2c90d4b0
x-ms-traffictypediagnostic: BYAPR15MB3141:EE_
x-microsoft-antispam-prvs: <BYAPR15MB3141CEBEAD892D647C306481C1C19@BYAPR15MB3141.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztZ6mUviKm48AEZ4b7rQknWKKU6NaMmXt5/XApJQSWde3L1FdN1tR+ngE6Zfl1xbKp3XMtOepEr9qy6mzxzLWvvLcVslbdO9uXz3egEY3HE7ZrQNkeWImnbnho6w2xxR+o0VZML4L3FgNsnITS+5hEUUu2YaEHHyVbOHz5Hez0kTxYPltBlEbvnXHydCqtRgPduq4rOC8uOZ9ZAtRQq7gGzFsTG2LLT6oH0I/fkUNNEn5IUOoIU8eNsY/mtsuB6rmy17mvx8iQeLUVXe3h+/7KNMXvs91WSRT9xf+lb16nuEP+mIpyLE0i2wVqOVgbVVN2iQb2GwvTQFq6jx22YllEwbZJAAyX4b+xz2eOuccHJVvi1F8Ktdob7ucnq7HZDVs69wSRtkTblXuc12vxPvjPrPdNVrXu73NQ+zV1Wud8o18CHXPRHj6fxfZkYxC06FXXwmaADOyrzD/SBMAv+OL0Y4MqaDcykuXxYj8zUI0rmOy6IA8BJIgX5ncaUtsIGp3VYtQNN1pTDuXgeAe4h0D5R70nWnOOfiQY6bTRWUBXktEGlDKK9OsiloSLu/ibFB30sOw7DvhskfMykW5z2ebuVAb0qMB1ZiLpoYaQIb9swgwvXgJ+Q+ORAdb5OeG68XkFXm2V2oDaVOg7aevWvM8ysZ18Qz4anlo6yEq8wRViGhUdAQe2ZcAozQ2xIhGyCp21T5XehLOX2uND6YDbrgQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(122000001)(186003)(110136005)(38100700002)(6506007)(38070700005)(5660300002)(316002)(64756008)(76116006)(66946007)(83380400001)(8676002)(66476007)(8936002)(66446008)(66556008)(71200400001)(86362001)(508600001)(2906002)(2616005)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yNKbSHhTNhqCwnbzw8sRdytdGC7Es4hDkC5LitngJBu32WPpTtgH5n3K0J?=
 =?iso-8859-1?Q?XlUJK+u518bKf8qupCDa/stt7FXs1w+zuCg8RsJisAP/YQBVsjL4Kxqn2f?=
 =?iso-8859-1?Q?BElIHXkzpAD+CGQ4+OzQ+RUi4+YvGJA9wjgr2UxMlyODLGTR54+5kA8Hnk?=
 =?iso-8859-1?Q?DJak0MAapDZNBSsk3V9j1rH86niBxDpSJYQIAhBrb5JEukjYUNNMYFDgTW?=
 =?iso-8859-1?Q?hM5MQAP75PnLqXssMBV7XltlSfGTBQv9hHaONwHqXRPLeHFp06JakPrXHM?=
 =?iso-8859-1?Q?4BMuEvd/ZwH7D7ppnsy1YDMmR5JiG4CdpNVwOycbpJyc4OV2hF+btzhxR0?=
 =?iso-8859-1?Q?FyRm8Mctf+2TtKDSYmx9biuy7PxHER1ivLsuQR0RQ/7v9kFbOk7HobdQzP?=
 =?iso-8859-1?Q?Is3Ex9PUoTsxssb2Mne4VB9JpTjpKxFehsixpK5Zxmj7m5UGEi6kTp7UR+?=
 =?iso-8859-1?Q?mVU+gEqWKGpt6E8edwBOlfg6c1APDnM3IOoAQRuJQYkno9uDh9D/uWyDVP?=
 =?iso-8859-1?Q?TrCBcEHpR02S2Mei/20iqqS07dZb360URZhf3VT1wxpiWKXesNaPGyciNO?=
 =?iso-8859-1?Q?cWiybKpXeWiBT8gIQn/L3jB5oEDz03ecWsbY9UZ71CO0Wv+Nr76g/eBYTf?=
 =?iso-8859-1?Q?k0pvaohd44cD7Wytyo7TjybhHSaCSdIkusZmVFBikK7pTpthzGBhAGs9J+?=
 =?iso-8859-1?Q?mAsAxYB4URx4NcbC2D8w8kynclZa3UtB/LY+Xn5E3KKiiu5lvV+nIxiv/U?=
 =?iso-8859-1?Q?e79rCWkRATNRrUAlw4Fnj4lMrt61XIy7p3Jwr/EnmxvhMTDz0jH0qoudlf?=
 =?iso-8859-1?Q?yaymwLiyk7nmH6kXFnwNoRDLcWulnQd10zA9kQPzpakQnm/Cs8lcqgWyV0?=
 =?iso-8859-1?Q?FBbl53scBHkGsNdMCtpOyaHcGmyIM9QWN6sZT+vNHkK+fhWBLg6g0CVP7m?=
 =?iso-8859-1?Q?tsRUqpGh0Y7IgAaGAncKF7ohhK1wu41JICJp/XSg1XlwiIIX+21IDIA/jx?=
 =?iso-8859-1?Q?g91NOftSdSi3ZJRTT8sA+zhe0HmKKVBFIrtcsu10cQexKPYu2lEoOdLf1H?=
 =?iso-8859-1?Q?16Zq+eXg7guBlrwy4VDD5k4X7N9GBYkhRQ0Xv1xt6iNedMwZtRLUDZkifn?=
 =?iso-8859-1?Q?GaF7ZHK9UrQAW2FGHKQmSUgV1UCZNQtyxCeCrJ63cYyuaxXehoY8v4P/8z?=
 =?iso-8859-1?Q?6y0KFAyTZfo10oZSv4+4v98vjEcecXJRKGiMNtaOYuDSMBqLr96AShAsjK?=
 =?iso-8859-1?Q?S9oP7FF1WVx5n70d00W2pBAJTOfMA9N2M8Rm3dkMSJY02xCpvEWON3gE+o?=
 =?iso-8859-1?Q?7ObYwJFOy4YHyoO21jSw+x5Z2Ry/SSlFvzs3rbYr0UvkkQaZOanoGX1GbN?=
 =?iso-8859-1?Q?csBNg3hfJC4RJDxGLdOXzEHEPYAZbRZur/XuF+ne0tHU5OnWS2mEsit9RW?=
 =?iso-8859-1?Q?rlsLD2WntaLk8TF33/OTsxhNiGShzoCN9EmiCGaJlsktIZ/+eglXLeR3WR?=
 =?iso-8859-1?Q?BCbMyUDiKpAxOcb69KiS9fUpKWKmMp2MSGRI2VlPBRRM+QYs0LRVYfGPs6?=
 =?iso-8859-1?Q?9OUap8w9R8DwhsU52bJHccYWawejXs/KBXZmUKCsG7nS5j5OSKba+bkF5M?=
 =?iso-8859-1?Q?rQTdWf9tAq4IVJg5a0FU2e5JZ59Ui7AF797fBhOlpCWF+3/t89ORa3quDh?=
 =?iso-8859-1?Q?r7G3Msl+CWTulkeQRAx2g4JhGorWXd5u1NIgHLry6CX/ndGymSpl9Pu/fg?=
 =?iso-8859-1?Q?m+T8j5e3vkHgQAsqmdfSETHiTlpsfmQicCd81P3tRik+V+xU0SgEPsD+PJ?=
 =?iso-8859-1?Q?VM12xr1JtMPYZotD8rPze97L8SZxmAFbOywToB3YAwaMD5o77D7X?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da80a80a-46a9-489f-df26-08da2c90d4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 23:09:37.7558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qo9Wz38p0JSgvy5+SzEoCEVUQLHIqDzA12tsBl3mQ9SGUYkT7XvcfNviL6FNRR+t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3141
X-Proofpoint-GUID: -prmlwM8vQo6TtIeOhqfPWa0yCxbRjKM
X-Proofpoint-ORIG-GUID: -prmlwM8vQo6TtIeOhqfPWa0yCxbRjKM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_08,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add section mappings for uprobe.s and kprobe.s programs. The latter
cannot currently attach but they're still useful to open and load in
order to validate that prohibition.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 63c0f412266c..d89529c9b52d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8945,8 +8945,10 @@ static const struct bpf_sec_def section_defs[] =3D {
 	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTAC=
HABLE | SEC_SLOPPY_PFX),
 	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
+	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
+	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach=
_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, att=
ach_kprobe_multi),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
@@ -10697,6 +10699,7 @@ static int attach_kprobe(const struct bpf_program *=
prog, long cookie, struct bpf
 	else
 		func_name =3D prog->sec_name + sizeof("kprobe/") - 1;
=20
+
 	n =3D sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
 	if (n < 1) {
 		pr_warn("kprobe name is invalid: %s\n", func_name);
@@ -11222,7 +11225,8 @@ static int attach_uprobe(const struct bpf_program *=
prog, long cookie, struct bpf
 		break;
 	case 3:
 	case 4:
-		opts.retprobe =3D strcmp(probe_type, "uretprobe") =3D=3D 0;
+		opts.retprobe =3D strcmp(probe_type, "uretprobe") =3D=3D 0 ||
+				strcmp(probe_type, "uretprobe.s") =3D=3D 0;
 		if (opts.retprobe && offset !=3D 0) {
 			pr_warn("prog '%s': uretprobes do not support offset specification\n",
 				prog->name);
--=20
2.35.1
