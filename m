Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF372A7C0E
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 11:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgKEKlS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 05:41:18 -0500
Received: from mail-eopbgr00123.outbound.protection.outlook.com ([40.107.0.123]:43499
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729662AbgKEKlR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 05:41:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0SkxYZUiRG85CONk9USLMfkV5JDZ6VscP34O4bg0NWtQYtWbLYm0iIVnYL2MhtP1DT29a7ELmmKqyD7hUW7/lh8WvoenIy7KSiKHN8iBTqH16tuXTQeYBFaXHY5KaAWENGq77lMlq+yynDGiSO1UFsoAg2NlXsF48EMjPOCmInPggUoyReHYxrHts/z+J4lh9XJ8xxRViFSAAvkXSvEvVYjAUgl/+TkbXTp7bP6A7Kmx6P3XVNMMBdH+VOCD0U6L75nrUJvYQsgc+98IS8JU6GhUcGrqq3AyiXeuN0JxOhK5IuVU+YkWdvOVv7CQd+rNdLxEJwi1d9FpStAt5rWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9ip4zrIYHOC1/eZroEFQ4xmduz9mRDVXDi6lyCO1/s=;
 b=Dk7qH9Ajh1GE7UkwZEzc+gNUH0gp1drtN5PnqZ1wzZ6CpsZeqlGus+lfX7nVC7FaMsrGx1pOiI5FIGXIeXrscrj3qUUgkCV2dlJgD04XD6Z2qRoi+ubhgBfNzG71661+D0VjoXBiB3oFICHPiXcMsNSll4QQgKrpEKxid/A/uHMS6yczUVpmQql1Flz66/n8/mr9fl2IbZZftc6riDS+k1FVNDwd0Qr3jurpq5wGOZj3zl5PPYTzftzgxoVw2JUR9Clae0vbInUpWRO+HY1t2ijLcu/oE/inVeKqQhcLOTYv9Mj/tEhEyLiTWObKhyWCavg32Wnz2y2w5lElspLO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9ip4zrIYHOC1/eZroEFQ4xmduz9mRDVXDi6lyCO1/s=;
 b=eJVbjtkofSPn7VYcywxRNNJBoJwoeqQVmkQhHrFoer8kxURmz1fcn9eT2UKfKaVaGxxP/nGlFPIvk4wmncerV1uKVN4NB2bmzUPhLfLsFfYixWQlDm5gC9UPj036smXWTYduA/8zQg9qTFpo94zJEGfiyBEZAkxrGg4LyZkzxq0=
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com
 (2603:10a6:820:1b::23) by VI1PR83MB0351.EURPRD83.prod.outlook.com
 (2603:10a6:802:3b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Thu, 5 Nov
 2020 10:41:13 +0000
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::c857:1a78:d155:fc99]) by VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::c857:1a78:d155:fc99%10]) with mapi id 15.20.3564.010; Thu, 5 Nov 2020
 10:41:13 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@google.com>
Subject: [PATCH bpf-next] Update perf ring buffer to prevent corruption 
Thread-Topic: [PATCH bpf-next] Update perf ring buffer to prevent corruption 
Thread-Index: AdazYC1vg+x0B4GYSm+iiVVe+II4yw==
Date:   Thu, 5 Nov 2020 10:41:13 +0000
Message-ID: <VI1PR8303MB00802B04481D53CBBEBCF0DDFBEE0@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-05T10:38:55Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7a341e6a-fd77-4f79-99d0-869cf2339d4d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [149.12.0.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39a565ff-d806-4ec7-093e-08d881775105
x-ms-traffictypediagnostic: VI1PR83MB0351:
x-microsoft-antispam-prvs: <VI1PR83MB0351E26FA6F4A889BBB20C6BFBEE0@VI1PR83MB0351.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCrsg5GVUMYPJ7HBchF9YNhVHDHqkC3XTDeyBpBZGcYzC5epsdUuKnquuGHua4UaPklpxvzOtDWH6DuetlMJqBHHh83Uw3bR4TyfgvVD9xKDDogTf0j7pks6rSgxHNVKHvlPUy1Hv+/YHjk0IPnSxT5th7y1FnPlTln7/FdEzaoNCemNneAPhBTSjFu2fBNZvlGh01F8v63AA/tLyCCddDzSdbBtn0BMQspAaQlauwwLDi2/QrAbGZ/+yxFthinyN9igqigVxMPsf6FhlkUMbg+1oqHbt3P/Zm9kr2wQf2x1UOsrx13hDN3usz6lGGlbKbEI7zE6qJoIcIrsPGaiaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR8303MB0080.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(82960400001)(52536014)(66446008)(66946007)(66556008)(5660300002)(7696005)(64756008)(9686003)(83380400001)(2906002)(76116006)(66476007)(33656002)(86362001)(8936002)(55016002)(82950400001)(186003)(6916009)(8990500004)(53546011)(8676002)(15650500001)(10290500003)(478600001)(54906003)(71200400001)(4326008)(316002)(26005)(6506007)(4743002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VLV0f4i91yXtVVHr3UhYUyNzsDDeW/TSdApJV9vNMxzRua74VaCiJdhFbK2nQBMVbR2h6ZE7IdwPifCGJoGnIaztvC1DuJdzj5ObBLVmi1/V8a7sBzpu81Mn4864uVihMKq3Bk8Q2yfYvJR8wFLIUmAyoVZq7G5/mpLSwGODO73uo5Ngtee0aX+CyVl2gs5Sby1Es/acKmAqnBIaVDztkS2apAcXPOaMgANV8gnO6TpeXOs17DRlthZhw2+t/DTFWlKerti6dtX2hxWW8lyTnJWWeUROqMWX2/1MWzYm/5OqW8AGdeQqYczkjrpyRV6Fyxaz/wb5y5TlqZxVCltAQZzGJRoJBH8FH3VKoaeL5vYTlOK7qzHBwItgrmJjQvuX3ZvmEFgVE0LmGzR7owTj0EqCP7+0i8gb8z/ICNCUwIU8mI1vGNQdXZsYCXCcDiBHd5jAHA0K3gBRzzAbw+DkG0Q5fWPTjOVFxtWr5McC6zGLGAVTC5SKZ+9kWQm3AFMqe/KSRBXvKeZudtQapzpaSopUGNdGpawmIuRCzv4r0rIgJYeJY9PEnosYhxaxZKBZueZ7axRs6pu0UzuZettOS3X5X0YhWAt7qKfVSuwdjJ3hH43pi8m1dtkCNLmIOlyn/+H+J8zHEQ+F4AhpZ/9Ua1kjV4gNVwp7xCUIfQVReHFCzdhtCuEci1TpFE7UT40bhFND5ro40B2MRyxeCSKa6i1akUBgDH/yANdAIMkQY3JRY57pLG14E/LDsQl+mJyDKPT8nvE+8CzNLNzPxz7W4K/ionLYg1dPEBCEsxNDVLyp6zlv/vyJ9V5AJNbESG3bCVSSkm2oS1b+my4CdhcMLSrCZXQre/+yHSKCaj0yLPT/itvyJYUsJln2P/eu0xUvEKPl2TWR8vgdOZVB5Iq9aw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR8303MB0080.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a565ff-d806-4ec7-093e-08d881775105
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 10:41:13.0232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5eHY65yaiOHLqfjGw8inTQscrM/SKqRg1F3qEr3L8c+hBcx59QeW+hvmyOq8N5VgZDFoEcLDgAzVnlq35rOQSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR83MB0351
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From 8425426d0fb256acf7c2e50f0aa642450adc366a Mon Sep 17 00:00:00 2001
From: Kevin Sheldrake <kevin.sheldrake@microsoft.com>
Date: Wed, 4 Nov 2020 15:42:54 +0000
Subject: [PATCH] Update perf ring buffer to prevent corruption from
 bpf_perf_output_event()

The bpf_perf_output_event() helper takes a sample size parameter of u64, bu=
t
the underlying perf ring buffer uses a u16 internally. This 64KB maximum si=
ze
has to also accommodate a variable sized header. Failure to observe this
restriction can result in corruption of the perf ring buffer as samples
overlap.

Truncate the raw sample type used by EBPF so that the total size of the
sample is < U16_MAX. The size parameter of the received sample will match t=
he
size of the truncated sample, so users can be confident about how much data
was received.

Signed-off-by: Kevin Sheldrake <kevin.sheldrake@microsoft.com>
---
 kernel/events/core.c | 83 ++++++++++++++++++++++++++++++++++++------------=
----
 1 file changed, 58 insertions(+), 25 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index da467e1..45684a6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7016,6 +7016,21 @@ perf_callchain(struct perf_event *event, struct pt_r=
egs *regs)
 	return callchain ?: &__empty_callchain;
 }
=20
+bool
+__prep_frag_size(u32 sum, int *frag_size, u16 header_size)
+{
+	u32 size, diff;
+	size =3D round_up(sum + *frag_size + sizeof(u32), sizeof(u64));
+	if (header_size + size < U16_MAX)
+		return false;
+	/* fragment is too big, need to truncate */
+	diff =3D round_up(header_size + size - U16_MAX, sizeof(u64));
+	*frag_size =3D round_up(*frag_size - diff, sizeof(u32));
+	if (*frag_size % 8 =3D=3D 0)
+		*frag_size +=3D sizeof(u32);
+	return true;
+}
+
 void perf_prepare_sample(struct perf_event_header *header,
 			 struct perf_sample_data *data,
 			 struct perf_event *event,
@@ -7045,31 +7060,6 @@ void perf_prepare_sample(struct perf_event_header *h=
eader,
 		header->size +=3D size * sizeof(u64);
 	}
=20
-	if (sample_type & PERF_SAMPLE_RAW) {
-		struct perf_raw_record *raw =3D data->raw;
-		int size;
-
-		if (raw) {
-			struct perf_raw_frag *frag =3D &raw->frag;
-			u32 sum =3D 0;
-
-			do {
-				sum +=3D frag->size;
-				if (perf_raw_frag_last(frag))
-					break;
-				frag =3D frag->next;
-			} while (1);
-
-			size =3D round_up(sum + sizeof(u32), sizeof(u64));
-			raw->size =3D size - sizeof(u32);
-			frag->pad =3D raw->size - sum;
-		} else {
-			size =3D sizeof(u64);
-		}
-
-		header->size +=3D size;
-	}
-
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		int size =3D sizeof(u64); /* nr */
 		if (data->br_stack) {
@@ -7170,6 +7160,49 @@ void perf_prepare_sample(struct perf_event_header *h=
eader,
 		WARN_ON_ONCE(size + header->size > U16_MAX);
 		header->size +=3D size;
 	}
+
+	if (sample_type & PERF_SAMPLE_RAW) {
+		struct perf_raw_record *raw =3D data->raw;
+		int size;
+		bool truncate =3D false;
+
+		/*
+		 * Given the 16bit nature of header::size, a RAW sample can
+		 * easily overflow it. Make sure this doesn't happen by using
+		 * up to U16_MAX bytes per sample in total (rounded down to 8
+		 * byte boundary). This requires modification of the fragment
+		 * sizes, so the first oversized fragment is truncated to
+		 * the maximum safe size, and every subsequent fragment is
+		 * truncated to 0 size.
+		 */
+
+		if (raw) {
+			struct perf_raw_frag *frag =3D &raw->frag;
+			u32 sum =3D 0;
+
+			do {
+				if (truncate) {
+					frag->size =3D 0;
+				} else {
+					truncate =3D __prep_frag_size(sum,
+						&frag->size, header->size);
+				}
+				sum +=3D frag->size;
+				if (perf_raw_frag_last(frag))
+					break;
+				frag =3D frag->next;
+			} while (1);
+
+			size =3D round_up(sum + sizeof(u32), sizeof(u64));
+			raw->size =3D size - sizeof(u32);
+			frag->pad =3D raw->size - sum;
+		} else {
+			size =3D sizeof(u64);
+		}
+
+		header->size +=3D size;
+	}
+
 	/*
 	 * If you're adding more sample types here, you likely need to do
 	 * something about the overflowing header::size, like repurpose the
--=20
2.7.4

