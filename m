Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB77E2A81F9
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 16:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgKEPQU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 10:16:20 -0500
Received: from mail-am6eur05on2118.outbound.protection.outlook.com ([40.107.22.118]:6721
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731006AbgKEPQU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 10:16:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rn7XAMo2iDzZt/yvoumCKepCBWPCRrXv3MKueFKn1V6+8nL+W5tTFLIGECqyHs0fFJfVpRGjwV0w43C9eoErQt/l9zPErl1xmnsAarwvE3qCWA1NTj9oGn3mFd3YcGM9bIMCD1T7COLki0Hv+nC1s0r31L0Hs/CTKa4dKz/ofZ3zP8n2Y/3wkRR3jprE98ZHqE5Y4fH6UoxWH3V9giUiJyyC8I+wfkT3cS7yfy1Rm2RKXmaoRYnJ8dACMEpX1wOswwFSVHukzM92T4kSEh+YDnftoSbAHkCw16YtXyfg+rqCXX/0gSUg4rSTKrkhoLRFAaL392oLFFLax53uEDW/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YWXtu9PezsWseYib3pUNYLAafskvGJhdL60NLRMd80=;
 b=P+c3+jnKTEKrvVuyWS1iJ7i2GAUzPo8GpOZHbmR8IsafG3xXd+o0dVlhDvTifTOjDoV7kDtmh/deRfa4F+Pgded23b5Nz6PNSPQmGTtKToSCzzn+NpxlG0dHVrAfakC/DReVO+P9uI/EcG2EyzoXKbRihI+lFza+sauAWI8NeJ16iS6SvJON5Cb3FYf0yp3WdDqYdv6Cet7py4beNVGo+IsR96n5Sc/OHrYt+WFd/YzgzzZKDIYVRkUKlPp1zyZJ1aRV+bqimxVvdbei5cUWBBjHC3SNGcOHZpnWKXARMKTNJi8ioxM5ui1rVGqo+whwa8yE389hXAfKK6b71Rb5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YWXtu9PezsWseYib3pUNYLAafskvGJhdL60NLRMd80=;
 b=hpmrm9VuNi5Ya0JMn+cnkLfd0SU2zq7GlwJIdxCq5Xht7s0DulQj56fOyKbdkX2dDFYfIMUg0wTSq9NV6wgF/5JeebKUsuPz/wXlUtSB816VCUJiCFyei6lSqxf+hdXYKr/sw8OIMkAMNdf2EG8CEbeA9c5aR+rPKxUEz/PIIDE=
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com
 (2603:10a6:820:1b::23) by VI1PR83MB0301.EURPRD83.prod.outlook.com
 (2603:10a6:802:7e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Thu, 5 Nov
 2020 15:16:15 +0000
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::c857:1a78:d155:fc99]) by VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::c857:1a78:d155:fc99%10]) with mapi id 15.20.3564.010; Thu, 5 Nov 2020
 15:16:15 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@google.com>
Subject: [PATCH bpf-next v2] Update perf ring buffer to prevent corruption 
Thread-Topic: [PATCH bpf-next v2] Update perf ring buffer to prevent
 corruption 
Thread-Index: AdazhoRkdBnwMDAdQOy79mWG/v7W4w==
Date:   Thu, 5 Nov 2020 15:16:14 +0000
Message-ID: <VI1PR8303MB00802FE5D289E0D7BA95B7DDFBEE0@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-05T15:13:59Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=04477c66-b915-4ad7-b0b5-4b3e1660a977;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [149.12.0.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96f2421c-24b8-4b70-6e73-08d8819dbcee
x-ms-traffictypediagnostic: VI1PR83MB0301:
x-microsoft-antispam-prvs: <VI1PR83MB0301DB05C9F65DA44D8E6A30FBEE0@VI1PR83MB0301.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E5hQFxwjRytwIkfpEN3joCcK+oWiaLcNSDp6rNd6EMY97HlzH5x4ICifu1MNaYLBbyvS2Jd/WcQOWJD7FY6fX1FjxGmRKxbka3vBIsbY7tRzbXu8JyMd8y3w/e1GNyIdGBL45+47b3+a6JlDvzG8Cbbafx9SjCVxp5iPo3gSfG9zpNV1YZxzlEipCi/YHlr95uEfcLgzrhIMaaq9xcGTciU/FJxnAqHIbWHubJwWYGuPPfFfOeMWxagPnjDpfcPcfhiEI8WI8CoCduC70iMWV6g06wvu6/9VoxFv/I8+w2ed672S/+iKngDS19J3YxID2cdKKDVE1NeOZswvlwDIhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR8303MB0080.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(6506007)(6916009)(478600001)(64756008)(2906002)(66556008)(83380400001)(4743002)(186003)(10290500003)(71200400001)(9686003)(66476007)(86362001)(55016002)(7696005)(66946007)(8676002)(66446008)(76116006)(54906003)(15650500001)(5660300002)(82960400001)(33656002)(316002)(52536014)(26005)(82950400001)(8990500004)(53546011)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eA23KXmfcTPB/v+dlqvuXl1sUaBww9hgRJJTK2hU8jzKf1ZJmF5ZuD4OZ3D3/ye/JM2Pr2cuTXku4Dqup/1HY1aJZ0b/N57G/WcBYHDB8IwplvOZozEq5+Z5epFMMp0qKn+0c/44c0Hv8eLCDxL1bXWpl2iYVTIT+H7HEEg5mrfEWc30+WwEpiUmh17u7cPVyVYfIvABVoeFRT8jJhkHs86zyzY2b/MOdGNUZZ8Bw0eb9W5eLGtP8UQv/RFAHW4l+f/3j99jX9Rw8h6LrHsFR87nTOjVkD9dpB0zkVk7mDWwUbqwpBt6m2D4QRVcUaz0pM0Pl3OQXtxiA+5u2maK+m9Q1kcx/2a6n4jePuhftRRZA+HEOXo/kFzYCwqfHmulqzlULUAIZevUP6a/h2dZDAi7Xu7ju52kxi/tGwwpc3b+StocshK3Yd2XJOM9zhyPzN3kGc1w4gpkdRAX5V56T4lF6Aegy9+vSLuf8vaSAjLZLIfiD751mqG6Kh9yQBCBKG1YkJ80fsKXHv0V56Tt4R3V3SVnbzc/r2bBvynB/Lfhyi7TKAT5TH45SkRSn93R3YUDHU2ll3iype3zQwJ2NR26wp2jYJYwn6DsUNrwv1EHUYk0ZJnx1GlK37xKJrrjQlagxiR1FhJT7YF06TCzMoTUMYfJKGRz3Vvu4K8g4avVu/IpwnrqjKtKjq+k/NSyt1EiQh2M1dOjguzaFXBboYHbD27rzQHGFpeOSbc1/7clsdn3djp893ynprdVyVxtwA/0ZHoOTP6JztX15sPw5xCmCWO8u2Jy52cRKSM8+jmo3+7pVVMZjhA9duIYfu2aisoDw3Pn+vEfMjrwdxVLeBeioRqoBLgc3ohBmGK0zAdhHBOPtwA35PDWSsU0BCUeqFt5+FbnSZcChnZoCAyyCw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR8303MB0080.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f2421c-24b8-4b70-6e73-08d8819dbcee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 15:16:14.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBJsXV9+NrzTPbqMUP2ocZVbTddT4s86OJG0Ku7bAk+XB86j0xF5vzDmCYSYknW2nOhXTx2oHVyb+pyUMTqkYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR83MB0301
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Resent due to some failure at my end.  Apologies if it arrives twice.

From 63e34d4106b4dd767f9bfce951f8a35f14b52072 Mon Sep 17 00:00:00 2001
From: Kevin Sheldrake <kevin.sheldrake@microsoft.com>
Date: Thu, 5 Nov 2020 12:18:53 +0000
Subject: [PATCH] Update perf ring buffer to prevent corruption from
 bpf_perf_output_event()

The bpf_perf_output_event() helper takes a sample size parameter of u64, bu=
t
the underlying perf ring buffer uses a u16 internally. This 64KB maximum si=
ze
has to also accommodate a variable sized header. Failure to observe this
restriction can result in corruption of the perf ring buffer as samples
overlap.

Track the sample size and return -E2BIG if too big to fit into the u16
size parameter.

Signed-off-by: Kevin Sheldrake <kevin.sheldrake@microsoft.com>
---
 include/linux/perf_event.h |  2 +-
 kernel/events/core.c       | 40 ++++++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0c19d27..b9802e5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1060,7 +1060,7 @@ extern void perf_output_sample(struct perf_output_han=
dle *handle,
 			       struct perf_event_header *header,
 			       struct perf_sample_data *data,
 			       struct perf_event *event);
-extern void perf_prepare_sample(struct perf_event_header *header,
+extern int perf_prepare_sample(struct perf_event_header *header,
 				struct perf_sample_data *data,
 				struct perf_event *event,
 				struct pt_regs *regs);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index da467e1..c6c4a3c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7016,15 +7016,17 @@ perf_callchain(struct perf_event *event, struct pt_=
regs *regs)
 	return callchain ?: &__empty_callchain;
 }
=20
-void perf_prepare_sample(struct perf_event_header *header,
+int perf_prepare_sample(struct perf_event_header *header,
 			 struct perf_sample_data *data,
 			 struct perf_event *event,
 			 struct pt_regs *regs)
 {
 	u64 sample_type =3D event->attr.sample_type;
+	u32 header_size =3D header->size;
+
=20
 	header->type =3D PERF_RECORD_SAMPLE;
-	header->size =3D sizeof(*header) + event->header_size;
+	header_size =3D sizeof(*header) + event->header_size;
=20
 	header->misc =3D 0;
 	header->misc |=3D perf_misc_flags(regs);
@@ -7042,7 +7044,7 @@ void perf_prepare_sample(struct perf_event_header *he=
ader,
=20
 		size +=3D data->callchain->nr;
=20
-		header->size +=3D size * sizeof(u64);
+		header_size +=3D size * sizeof(u64);
 	}
=20
 	if (sample_type & PERF_SAMPLE_RAW) {
@@ -7067,7 +7069,7 @@ void perf_prepare_sample(struct perf_event_header *he=
ader,
 			size =3D sizeof(u64);
 		}
=20
-		header->size +=3D size;
+		header_size +=3D size;
 	}
=20
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -7079,7 +7081,7 @@ void perf_prepare_sample(struct perf_event_header *he=
ader,
 			size +=3D data->br_stack->nr
 			      * sizeof(struct perf_branch_entry);
 		}
-		header->size +=3D size;
+		header_size +=3D size;
 	}
=20
 	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
@@ -7095,7 +7097,7 @@ void perf_prepare_sample(struct perf_event_header *he=
ader,
 			size +=3D hweight64(mask) * sizeof(u64);
 		}
=20
-		header->size +=3D size;
+		header_size +=3D size;
 	}
=20
 	if (sample_type & PERF_SAMPLE_STACK_USER) {
@@ -7108,7 +7110,7 @@ void perf_prepare_sample(struct perf_event_header *he=
ader,
 		u16 stack_size =3D event->attr.sample_stack_user;
 		u16 size =3D sizeof(u64);
=20
-		stack_size =3D perf_sample_ustack_size(stack_size, header->size,
+		stack_size =3D perf_sample_ustack_size(stack_size, header_size,
 						     data->regs_user.regs);
=20
 		/*
@@ -7120,7 +7122,7 @@ void perf_prepare_sample(struct perf_event_header *he=
ader,
 			size +=3D sizeof(u64) + stack_size;
=20
 		data->stack_user_size =3D stack_size;
-		header->size +=3D size;
+		header_size +=3D size;
 	}
=20
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
@@ -7135,7 +7137,7 @@ void perf_prepare_sample(struct perf_event_header *he=
ader,
 			size +=3D hweight64(mask) * sizeof(u64);
 		}
=20
-		header->size +=3D size;
+		header_size +=3D size;
 	}
=20
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
@@ -7154,7 +7156,7 @@ void perf_prepare_sample(struct perf_event_header *he=
ader,
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
=20
-		header->size +=3D sizeof(u64); /* size */
+		header_size +=3D sizeof(u64); /* size */
=20
 		/*
 		 * Given the 16bit nature of header::size, an AUX sample can
@@ -7162,14 +7164,20 @@ void perf_prepare_sample(struct perf_event_header *=
header,
 		 * Make sure this doesn't happen by using up to U16_MAX bytes
 		 * per sample in total (rounded down to 8 byte boundary).
 		 */
-		size =3D min_t(size_t, U16_MAX - header->size,
+		size =3D min_t(size_t, U16_MAX - header_size,
 			     event->attr.aux_sample_size);
 		size =3D rounddown(size, 8);
 		size =3D perf_prepare_sample_aux(event, data, size);
=20
-		WARN_ON_ONCE(size + header->size > U16_MAX);
-		header->size +=3D size;
+		WARN_ON_ONCE(size + header_size > U16_MAX);
+		header_size +=3D size;
 	}
+
+	if (header_size > U16_MAX)
+		return -E2BIG;
+
+	header->size =3D header_size;
+
 	/*
 	 * If you're adding more sample types here, you likely need to do
 	 * something about the overflowing header::size, like repurpose the
@@ -7179,6 +7187,8 @@ void perf_prepare_sample(struct perf_event_header *he=
ader,
 	 * do here next.
 	 */
 	WARN_ON_ONCE(header->size & 7);
+
+	return 0;
 }
=20
 static __always_inline int
@@ -7196,7 +7206,9 @@ __perf_event_output(struct perf_event *event,
 	/* protect the callchain buffers */
 	rcu_read_lock();
=20
-	perf_prepare_sample(&header, data, event, regs);
+	err =3D perf_prepare_sample(&header, data, event, regs);
+	if (err)
+		goto exit;
=20
 	err =3D output_begin(&handle, event, header.size);
 	if (err)
--=20
2.7.4

