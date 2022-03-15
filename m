Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF424DA518
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 23:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbiCOWQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 18:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345807AbiCOWQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 18:16:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626925574F
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:26 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FLgP1O014360
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ytBv8VCeqcCMyIjRtdCdZbRvZm+1dAj4mlFhYms3YrQ=;
 b=kLQVNxOHCtGuoPAEcN6Q0QPPgiO8PjE2r/2QbP76R15ZiW1+kMEkXBtF/oAkQ/pykzRg
 IdIfJWu/vD9squklZsWfe9s6jz+eLGspx/P97xw94vz7Ep8xG4oj92X103UKRZ2Lti6F
 8DbfajksQZ5II5m1O4D5LKQ7b/ZeILCaTUo= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3et8vrbcbq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeEiCGxbpYbE5vhld74iDpVgmFAxW+5ij523L5wqSk7tj6zrPGhIYjUeh7gOTcnpxpoWDsuGcwcUWW5N+22j7Jyopizk83iKj6j7NRh7ABh3C1UOA+vz7VULUCZMl90aJMKgyV0xYn6ti4d4ybZQ7BSc19fRFtzJUjBrp+Rtuk0DEAByqMRtCdIJlbrwO8ZJg5/oT5OPJiZcGLSiRQyRuJPsT/xijzuR7RoXya0SRFgBwOGfQSr2yQuf3m7qSa49bZAr+jr6y1t02lYWkwfCDcuyJhMGaanpaMO6MZL0kR9lm3QzVrOeZF7jZtDxSo9ldt2bY622v6LUMLy5dY6eqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytBv8VCeqcCMyIjRtdCdZbRvZm+1dAj4mlFhYms3YrQ=;
 b=PH/tN80j8RWwx+O3An32LbncQ1N22k4m53wIVa/KcazrC+zB3Mrgr0LvCmlF1bt00PsLbNQDvmr7XMWkWyi/FybBKGCAXwBvzExxqUhONdv3D+0xPFy4vJMSqOjys8xqFKZvgPLDe79z+ZsKhTzr2fsb0mLXtNmmqn77Sfu179M3XAAW0XRddzex9ZjB5S869Djl6N1vvucPBG800seUU53qPUfItyUr7AEUYzaT13wjaG1qhpii4d98P2XzWJPEySa76grPfLOcdD3k6+Do6TfrMHrdjcnEag51VXpIq54wxYl40Hg5IIduF20CUqrJM0PGeBsInHa0IaGBlmGx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM6PR15MB4313.namprd15.prod.outlook.com (2603:10b6:5:1fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Tue, 15 Mar
 2022 22:15:21 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 22:15:21 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 1/5] libbpf: .text routines are subprograms in
 strict mode
Thread-Topic: [PATCH bpf-next v3 1/5] libbpf: .text routines are subprograms
 in strict mode
Thread-Index: AQHYOLoopc2X8fRgPEWiZpLDx/LByA==
Date:   Tue, 15 Mar 2022 22:15:20 +0000
Message-ID: <b239588581c1a1367b3ae901a9e3058bbb7a9eb7.1647382072.git.delyank@fb.com>
References: <cover.1647382072.git.delyank@fb.com>
In-Reply-To: <cover.1647382072.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89dda0a2-69ef-4536-4c15-08da06d14ba5
x-ms-traffictypediagnostic: DM6PR15MB4313:EE_
x-microsoft-antispam-prvs: <DM6PR15MB4313BFC7EBCA17C5B2CCF521C1109@DM6PR15MB4313.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qTsce+b7G8wOsmu0PAedgErNDy6D7zYi5aGd8y1pPfeByMKnMFOykLhmUujfKrq9s9fMULzfTdBLUCwroCkKyiGmujnAOUZk8q11wFNX+Vn6fZ0lose7/XTs40SFUqyMIVtN85t4zpzgQhMXQjv40iFgSzL95DhHOGuKzqKOhwYpQjtHok2uHhSh+MpKdg2ydlM2xVkfYBtBeuLkP8tceuvDdRy9TreNGJak+/+ULaBZ2i66deu/U8ohKlah82XKxFQXOf8UEMjIkOMsklT6nbIGn9lnIoEkXzOqZAjF+1A3QE7zZkHOmnTJuGNmazL2VIB9zkhKUQB+bH5rLuH27cY2Xi2bqcyioszNznzDi3yFa5ZaylUEAAknbCuPQMxc89QNtqErznlEmm+T2cY1jHbaI18OT1Sd3Vp8wjkLcG1HUyAx7xjA3m5AwqF6MK60zHPSaCoH7uiIQTXXDXwbDhx7Wr46brLQnSFN0SZFLLd5efsUgu9RaAeuf3FIj9q3Aa7Ms5gqqeYYWs2xVViyhTUshVi8aBKn1k9oyvfJwx7w+9gidx1wht1YKECs+0Mwewq3N2SebalkVXbqbA7p4Ow0qpsEh+fFEGrcDo7Sy+bKQMWxTUkU6qouOAd/w/85XrjaNoIYsBOo6U7MlgZ4oQRfX7+zfMex+/337rLCyS3OQpJr6Et1gsZ+uVt/vrEjK17wOM4lBNN8M7lw72ImTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(6506007)(6512007)(6486002)(83380400001)(110136005)(86362001)(122000001)(508600001)(8936002)(36756003)(38070700005)(38100700002)(5660300002)(316002)(76116006)(186003)(66556008)(71200400001)(66946007)(66476007)(66446008)(64756008)(8676002)(2906002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nz0+63bhsvHCTyMEmjfWt2jrvEFKLa1APbBgQDqxGD24hlW84NbTo80qa5?=
 =?iso-8859-1?Q?En8RAxCL40S9ZWEa1rPnHwgceqL+X6/vgorUe1p+yynFviL/uL43pDBm3P?=
 =?iso-8859-1?Q?ebnYWlb8Hhxk8KdWmQV7rBQu8YnzBGnOdOgFmsFAVo3mFvCYf2swZL7f97?=
 =?iso-8859-1?Q?LXq81b0vF30a+XXn9jzqJW/l3jVWm3caXofDDO5iCFqgIQcppZSOZjGwHp?=
 =?iso-8859-1?Q?hs3Y+6Ow/o/dwCnf7fy2gbpDSWkBzwwSv/sGEde6fgz5tbNObzeMii5fb4?=
 =?iso-8859-1?Q?kEQB2/2I60f9UAImJUnWYIzUJOCzkXXoNQHXtZWXplHoi+zNBMfRgpfnVd?=
 =?iso-8859-1?Q?3ZqN8VmmATXtgmpW6WvmScKiQLmD+o6aFW7T7ellzz/zCKNrKE40zFo5EB?=
 =?iso-8859-1?Q?TnuEutY23zpmzlZcSew3ETDDDf54UGsndmfWRuv7cdwqNbZkbMnP7lzQ1P?=
 =?iso-8859-1?Q?5WO5PgdPk6Ct8vqWTVagj4NsnzMhs6kfqqjXjWu8RLFjo+xGZeYz+3Y9pj?=
 =?iso-8859-1?Q?5+3bPitP72UU497sGc2/QS5eDISF5A0BqEXSNh7E+yEgYtNvgacvfhQrzM?=
 =?iso-8859-1?Q?NiS9piPg1+E97WJ6NPRvyLXmrKEq2HDLu33mJ4b66HlsuhN98Xb+CjDc3a?=
 =?iso-8859-1?Q?k8T3K4kk1VWpJM1vdVhhoO0Uoco+t+j9DtEiif4bzW/vHNbkqkYTuc3sY0?=
 =?iso-8859-1?Q?lkN1dxPqsSlISVEnaPgm4XAqqf6GqZrET52Uu7UJ0fyrhoY0G3vqM7UuUP?=
 =?iso-8859-1?Q?wrS23RfU2tfWlhCjaI0OQPPhURLVlgk+BESWU/sAUW4gzp/VGdNvBrCb4H?=
 =?iso-8859-1?Q?4gTtZjJbWNy5Xs5J/MxBTcznLx3ubY9el/zchEmxOuxpFUjqK8lyggQbSl?=
 =?iso-8859-1?Q?H8Pmv5o4+hd+gpi4YLsdWWT4A9LA3jS8QKfXn8dqokj4/kUopa5fLRoMkm?=
 =?iso-8859-1?Q?iFTKSn8eKPuQs0JRQAwZpmOX+jcUpCxQje3I74+iR9Io8PvyHan6jFeEgq?=
 =?iso-8859-1?Q?0AsbVe/YsWygtd3kFcVZQuSnTj6in63bLHNEav2WOQBP8egrT6y5CM6C3p?=
 =?iso-8859-1?Q?zl7fkXgoFEbU1yDH224EzGlssAjnKI8CmpZRK6lGS0g/uEHbBIwNwAr8K5?=
 =?iso-8859-1?Q?fP6Hff9VyY+HoN6GUbee8e2Y2pJBYM8IbWt5GsCit+eMwu0TUIt/c2B9o7?=
 =?iso-8859-1?Q?nfDLpNP7XwRnDY+wgBW62Uxz2inRbh8kBcMKHeJRykdN4dL8Ti4/m9ugYl?=
 =?iso-8859-1?Q?QFg3gq4/H4GF1CV+iO0SqCpzw8RkyzPxfxBAYfdkhcciQPXEzuRk3shcNm?=
 =?iso-8859-1?Q?/3WQ9QxdGUkmmmy5+iaLPgl7O8Y/9wixdr5ccdIiEAD8RJ6IHkgS8PMFBc?=
 =?iso-8859-1?Q?gqZgvszEirBqH0kyIEbSdB8roKt5JK+m6ZUIPjNiteuqt+upDZ0lw2oWHW?=
 =?iso-8859-1?Q?InyOH95NMybROqWY+WR2QsXO9Q326iqxekoN8fUaRNfByGc1KXYE8mNUo9?=
 =?iso-8859-1?Q?Ji/gOxDjj7ekybx3klheY1m1r/wSe4FnQiB+tQ/ZE9Ac/i4SGbyXsDOY4N?=
 =?iso-8859-1?Q?UspbR5bb20n5PvVajNORDRTgF7ajrRN4PJkVjnubZmsjfvrEWSUNVYyFgt?=
 =?iso-8859-1?Q?XXbENzhnNNEXK+klFejzwogjzRc4ZAc+1GS0GiT8jMbMZmrs70ERKvCw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dda0a2-69ef-4536-4c15-08da06d14ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 22:15:20.0296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0tj5l25Kb5ukvp/oTPK0WkycmUc01NOYA7FGGqRYxjDdySb6tGhmTEWKGMqrP9Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4313
X-Proofpoint-ORIG-GUID: JjBuUf9tqZ71POiMs_P2X2uo6RA7nIAd
X-Proofpoint-GUID: JjBuUf9tqZ71POiMs_P2X2uo6RA7nIAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_11,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, libbpf considers a single routine in .text to be a program. This
is particularly confusing when it comes to library objects - a single routi=
ne
meant to be used as an extern will instead be considered a bpf_program.

This patch hides this compatibility behavior behind the pre-existing
SEC_NAME strict mode flag.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c        | 7 +++++++
 tools/lib/bpf/libbpf_legacy.h | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 43161fdd44bb..aa26163e4ca1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3832,7 +3832,14 @@ static bool prog_is_subprog(const struct bpf_object =
*obj,
 	 * .text programs are subprograms (even if they are not called from
 	 * other programs), because libbpf never explicitly supported mixing
 	 * SEC()-designated BPF programs and .text entry-point BPF programs.
+	 *
+	 * In libbpf 1.0 strict mode, we always consider .text
+	 * programs to be subprograms.
 	 */
+
+	if (libbpf_mode & LIBBPF_STRICT_SEC_NAME)
+		return prog->sec_idx =3D=3D obj->efile.text_shndx;
+
 	return prog->sec_idx =3D=3D obj->efile.text_shndx && obj->nr_programs > 1=
;
 }
=20
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index a283cf031665..8d2e632aec79 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -53,7 +53,9 @@ enum libbpf_strict_mode {
 	 * SEC("xdp") and SEC("perf_event").
 	 *
 	 * Note, in this mode the program pin path will be based on the
-	 * function name instead of section name.
+	 * function name instead of section name. Additionally, routines in the
+	 * .text section are always considered sub-programs. (Legacy behavior
+	 * allows for a single routine in .text to be a program.)
 	 */
 	LIBBPF_STRICT_SEC_NAME =3D 0x04,
 	/*
--=20
2.34.1
