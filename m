Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831E84DBB26
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 00:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbiCPXim (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 19:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbiCPXim (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 19:38:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C61F15A3B
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:27 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GHCfHr029189
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Pqu/MEAH1ixxtIzLUti8c4mcK/i+RDDkPIVgurjQb9E=;
 b=m53HU7tuGI8kkUG0qwJwu+x8awbCvonKg/I7c3LlJ1sA/cHQ/DIc/aiYlb2qAGRjwiwv
 Hu2k7uEC9zXymhQB+0ofh6q6k5EAJjX/02y3p5FsLPzTF9wCKWg2gyD1cOCWtKQm2At2
 FTHZeJfQ0horRRy0PRWKQz7310+QSEX7xt8= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3et9d0m35c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWpgO4VepgUCV4XGryYomHtD3+PaqulDilsSascli0iYvPPFquGHmASYwGt624XZqOB58QVBS8QGPaF/kNFF9P72C2bqVyXilpWFcpruR14F8DufD4OWrLgB9qZ4N/3mmQvi0c+vbsJct2bPBuC7nPPDlc9cDBu5gOdpXQLNnzRiAarXQtSwalagBgteftOsKf71vkQXHLOius3CVPlMIy6eJQQxdNATiHArfKpD0cRJVHJBVmY/UL8iZyqQXtt+nj9NwSRH/R+aQJlDJ0E8sKgeNHqI7Tvj4sdJkihuHB5EA1hJJANOPasCc2gkZnjPbJBXosE+rYIKaHWEqpdhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pqu/MEAH1ixxtIzLUti8c4mcK/i+RDDkPIVgurjQb9E=;
 b=hpRrJFSR1cWLF+81fz+sONZ8zV7x/0Aq1bAk6uYhCds0jkLmCPLqvi/3syjxWps1NQYEbNk9GWOGDEfQe4lJKjzFV+kLjWsKxgOiGezbbjrTdrR0jO36JOPMpnKmPTehdJWQJa7bN6oZSgi3k1wESM9zmfD1reOP72tIB7wNYuhE7Vk5KAWIhVQLzfS7w9h4hFl1SgxzfJGLTguaNHCh+7zhxa/vA0xz903bqI0zL0vKK63+kJswdGhsjUnLPhn9CpnUigX6mCoq6FEYIiiADfMMd+CsMNK7K73TfLYJztKPDuYDeLu9mI3Vx8WQ2ZXE6XL3NDCdUbtAFzLkuptE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR1501MB2182.namprd15.prod.outlook.com (2603:10b6:4:a4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 23:37:24 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 23:37:24 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4 1/5] libbpf: .text routines are subprograms in
 strict mode
Thread-Topic: [PATCH bpf-next v4 1/5] libbpf: .text routines are subprograms
 in strict mode
Thread-Index: AQHYOY7JGutuEwujg0eGCtq27xBI8Q==
Date:   Wed, 16 Mar 2022 23:37:24 +0000
Message-ID: <018de8d0d67c04bf436055270d35d394ba393505.1647473511.git.delyank@fb.com>
References: <cover.1647473511.git.delyank@fb.com>
In-Reply-To: <cover.1647473511.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b842a929-f05c-4924-8085-08da07a5ec7f
x-ms-traffictypediagnostic: DM5PR1501MB2182:EE_
x-microsoft-antispam-prvs: <DM5PR1501MB218279264FCF2556F1A2CD75C1119@DM5PR1501MB2182.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VgRF73t9BKNaxtxJ24K+WRoPlNYZoBdK1Q5uGhaWQQDxHQQiCV+JNCJj8IXq4vgov11MWarLDJlPHz83nlXjK8JCBCS2LfWesder5XKHRlcEvNLUab1AVXl+F3rsr3bQycRTMzP5uH8/f9cvmduZQlIUighbIqifICoCTCUkSjiQ5LU/wpr1cfvRDZLyXji0lu7TRmo1HG6HNUqLo7/tsvgQ/TUuHV/oTAljwJbfjkma29KYQ0S3FXeDQ02wJIbkpkQOeD41EKqt5Id0yYSDIsV0hqz3wB/X7IlZ6K5IgBOaN1VPN7tidw71HI29nLTnKjqpA9zbra0ahMBPiRlgp7FcalqaFiiaxdKOZSg8rairBHi4NShgYkum/EZpTyEvJal2IdH6QDXqSnkP4ztAw1bH9wtii12HbCMwV/EKVplsGSM1qrWfWut3zLf/HvnD/G79WPxzyuRwBmo7HJGA9T/M4eBUmX941+ZpUlqxekOj+8evJ5d+tHcjm9sTkNG6bNesChJ9ZxvqZuhlwNFZSYdCumhIOdttDaoZv8WHTOnjGxsXOc+9bGRJksnEdqKSE0eDtjL6dy/vcba/NXJ1oiRbbylPFJgdrnpBEzTXBWxDaDqZUXJ6QYFS2MqmA8XAfvrAfUSa6C+8VIwOSJNLJ1tfa0Nzs8Vo9sh45P8gZxluGxBxUxw3U82rvX5OQ4omaRlJBc0YrsxpBw3YfQoZVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2616005)(5660300002)(110136005)(316002)(38070700005)(6486002)(71200400001)(508600001)(64756008)(8676002)(6512007)(122000001)(6506007)(66476007)(66446008)(86362001)(76116006)(66946007)(66556008)(91956017)(38100700002)(36756003)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JfLgIeTuP6J0BoF4KVlnXp61CzAwLU6OfMkZ0GSlcOIREjWroGOHwXClVz?=
 =?iso-8859-1?Q?L7LPW33OOonM+1FBXfjqLpwxPechUQ43Vx4LOcHWAC3zTt/pWeECY6XuF/?=
 =?iso-8859-1?Q?unFaprrvpMcPwqkVh7GDL0tOYhryqjs9vQrC2LZ4LOXOEZ286uoqQrpuBX?=
 =?iso-8859-1?Q?W0/XXJzu0lgP/wijGrhMqWr+tqm29c7BJn0iawkbeBqOMUms/WKgeDjFv9?=
 =?iso-8859-1?Q?wJ9NcUyRGhebhKuxxrly2vjrgGRLbzOENl69CAC4JnLHyYyNFMnJtPOlDk?=
 =?iso-8859-1?Q?9UbWFW49HLMILjJ0o1ZWYy10cg5FrAgt4A3Zc49W1AUABdxclQ9itYBDep?=
 =?iso-8859-1?Q?7UTxcdkNx3kNWa02y62CqBOeLEd3J+tjFzJl6iu9yeKj4RRNGQWqOoQlfX?=
 =?iso-8859-1?Q?Ygflna0dfeRV/TA3WIhRlT5EIT8GM+ahqU/ExV7sxr7XBlyk8tcpQtBJw1?=
 =?iso-8859-1?Q?ZE0SRRER4oUQZKLPnYcHO55QAg8yGswWHawBoW7b0r5WLS4mHgTndHj/Wp?=
 =?iso-8859-1?Q?HiVYStU8yIiDzOB+JBOT0Qxk695nKttj6qrEpxpc4mSDoRTsxB/dc2+nGG?=
 =?iso-8859-1?Q?o26XXTvBAuZ0iOZsR4WGrp4WahXZhQKbeUE3W38qj8/Iw9telNBdC+Y/H5?=
 =?iso-8859-1?Q?IuO1cLeldoKeSqZrpVdYnQ/PxF9LKCUD4+kSmPnEwzCS2RDD1pYqG9RJJU?=
 =?iso-8859-1?Q?NEfCKSXSD7a6PY2To1AJFG9Ri+8QfFpMpFAg+pLjYmT0CtpyZJZ8Q+43jj?=
 =?iso-8859-1?Q?juKaEhzRBCaeihHBCO5cYwcZtLdGTW/Xm8qtUy656k+v4qdL0rN8cm/rMk?=
 =?iso-8859-1?Q?aRwoxOprBmgBHn9aZXkTG7zYVuW975qqrooAJgdSYsKZ237ZQNkiWHNUq7?=
 =?iso-8859-1?Q?BCwFk4g+4xct4lq70isweisSMoFBUpoc7cD89iO5xRadRYXvdIaQcy6gGS?=
 =?iso-8859-1?Q?qU5qe9J9Hoq7i2URFp3ArfynMZIjTDR+Aj9AwXUvjmOlP0JZJ1kU+SF7aJ?=
 =?iso-8859-1?Q?mI0ep+gX1yN8DMUewRDPSKA5Mf6I+394VTKODXXNOSRT0Ww/hbP/IpBqr0?=
 =?iso-8859-1?Q?iYY9vB5xrgtaiXv5K+6ChyrFuk4RnnE0z7duR/YCW/pByrE7RZoDoGmlf2?=
 =?iso-8859-1?Q?xL0koZkS69/ULvZ5dUEdiKz27+i/hDCYNdloqT2NbMI2SupdbIy/E7rpCi?=
 =?iso-8859-1?Q?3yp1NB5nN4Oc2/ukUiAO8l/SiQe8spTfv7IXZtZnSCbjzizC1xzM8ihtJH?=
 =?iso-8859-1?Q?rFCACXvUCUn1zRtJTpB/9Du+0ecc039RwlIdEKRew7TRJIS7vglOAodS7F?=
 =?iso-8859-1?Q?R1bxhQ52tujMoE00leQfZ16WrJXfeg6XogIUkrf9DR2KbysIpwCM7nIkQ/?=
 =?iso-8859-1?Q?7L4m6a5LQE9AXP7pe2sRg4UA34NlRa40JW+imVa9xx4FJiTbASfDUxiK9p?=
 =?iso-8859-1?Q?ef7b6wOjr3bmK1IcUuXDTqXU3pNo5ZWPjFweWcIRM5HA2XtUh0HnQ820I6?=
 =?iso-8859-1?Q?k+d1gw1LC0CynxchBINzUmT5lrw+pXjvE229fiUL1aQw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b842a929-f05c-4924-8085-08da07a5ec7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 23:37:24.4185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WO2BxUmG5LL3DI6hGDW3iU/cg5+ZOBmNxEvs7nb+3/YnobNVyXKoWawx5vii3weN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2182
X-Proofpoint-ORIG-GUID: Q5_5jMSK-Gwr595lIBX_wB9UtptoKEsY
X-Proofpoint-GUID: Q5_5jMSK-Gwr595lIBX_wB9UtptoKEsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_09,2022-03-15_01,2022-02-23_01
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
 tools/lib/bpf/libbpf_legacy.h | 4 ++++
 2 files changed, 11 insertions(+)

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
index a283cf031665..d7bcbd01f66f 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -54,6 +54,10 @@ enum libbpf_strict_mode {
 	 *
 	 * Note, in this mode the program pin path will be based on the
 	 * function name instead of section name.
+	 *
+	 * Additionally, routines in the .text section are always considered
+	 * sub-programs. Legacy behavior allows for a single routine in .text
+	 * to be a program.
 	 */
 	LIBBPF_STRICT_SEC_NAME =3D 0x04,
 	/*
--=20
2.34.1
