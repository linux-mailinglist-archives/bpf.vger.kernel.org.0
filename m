Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28114E3458
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 00:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiCUXaz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 19:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiCUXat (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 19:30:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8355F284E58
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:29:22 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22LKLZ2e003900
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:29:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=r0jhrFjdktlKz/bPY17H5tOncw++MgD94FvqPdBUfWw=;
 b=dxZbX+yk9hZstZIcB/YlBgJz2/ydD66m8csM307Mhd5F3ifMsrzbDYiRapvOumPHULSB
 FvfmYmrFmdUC+A+cJu36VbgMcIiHZwjue5xbqgg81JJ3ZU2jwvpcL6Jn6Wi3jJqGZEHC
 YfCzkqrOOtnV4sHXoHv1w88P8TVSl0V9IlM= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eweg2dhce-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:29:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxhGy/LwHDYshxMs6jPenfZX7hUDAwt9JH8rqiqw1KaqnKV6p88KuuhAa5Mi5cE7n2yVb/v+dCKxj2jo9vYQMOUe3RoDqDta4N3u2jy3jAUJmddOGrb95ZRvh/qS8KUWfo5w0CDa0rdX/btzMUMLM4VpKca050LwuCSESVLQ8aqNNOhPvXY89QKulnxcHXiUTg6YpYEy61UHrsPYLvg4wgF3GDY7+2zYvRJrloV4PUSepZY5XkOgd1zwtofzVi1a9VI1kvlj/Lg1MzUueNfO9+xYsVZa4GiNb01ZGAdvsBJUxnKc/VDvEq/BaDUKCy9RsQIP+52agyp9Ox4f64bfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0jhrFjdktlKz/bPY17H5tOncw++MgD94FvqPdBUfWw=;
 b=Om2sTOwpsXHWEXekJaLTCo9R3SuhpHdEVlbw3/LNgIwzFNDCrRe8sAlhj3lua38MqGSDqG4reQVZDounJJWPuTqPfSiGpx+KuIY0muGqILy6aL0NnYtIuNbIne/kuwkjlRjkOQCmHzePT2NINfDZkyWT8LjmILusNon7XbieQI0zFLPlCEo2b+hSd0MrustjH4J48pQJZYSshFEFKWreC6sbUGBxaaTxXHT6ReDss1IbrsJEGjYtQNALH23/eh8h2fjIjDOCslTuARbenu1Ub8boBclEMW6/pH1pITbMqa5tDpyXtuGX5SbWeTRfU15xOWUrJUqWlcZEww/alNeeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by CH2PR15MB3655.namprd15.prod.outlook.com (2603:10b6:610:9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Mon, 21 Mar
 2022 23:29:18 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 23:29:18 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next] bpftool: explicit errno handling in skeletons
Thread-Topic: [PATCH bpf-next] bpftool: explicit errno handling in skeletons
Thread-Index: AQHYPXt8Hkyzw7LMtUaPSITYjIxEhg==
Date:   Mon, 21 Mar 2022 23:29:18 +0000
Message-ID: <3b6bfbb770c79ae64d8de26c1c1bd9d53a4b85f8.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e0a244c-c18f-4ef0-0853-08da0b929ef5
x-ms-traffictypediagnostic: CH2PR15MB3655:EE_
x-microsoft-antispam-prvs: <CH2PR15MB365544BC89A579CE453B2085C1169@CH2PR15MB3655.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LC6PPGf8iVah/vhJtyDRAAcZOP3+zh9L5J8v1g7TlA8jJ4RXxPAZD10tp+ggzkhjni6B5cYpdFqwbOFcrAP/Q7Rd7qVAYJYEc7WmBcmrPnWoIxchYvEvRjeQe/JbWZRz2x2QrI/ZUE4b4gYKj3ErCdHoz0pl58xlAYzQnl7qxrjBoZ/JN65qaHbkIU7PTrKxwVw5xvYdpPt/rOpwPiIiGMQiq9ZewocDj+35pUuN5RBfP0v8qpH7F295s1P7wDEHqSOau9iCfyU/CC4ZmpJ3YEYbbZ8V99STd47x9m42MVC/NXMW4+XsxEm+bg/aa0UaaKL20FS70TfLnvhWRmHLb26zUs0guO3lC6Cb3mMOT7pOA5+CMRgQsci9x/7HcL/UEES0asyUfzkCC95DJKjtHA9X+KkpFsaPxsZUVVLSPOWCcHhKnBtAZNp6zduCULrv1HJXV8iO7rkN7WUX6pt6unRSU7581nbVasaMsGd66A8yMqij0HNeHCEA6Z6C8jJs/CglNTbzkf54rQjyqD7SqOLuxZ0A7XMqMZ7S/ZiWvHEWqyYkrRQo6XdB4JBIbBPycFhA2LvqNj62ON45cPhMnLMVvP59QyT64c/J4IRLAkz+bkcMziTMqKAGypfDMxVB5eT5nqUu+BnIbaPAO8dBF/lIx2cwdROvc82vfmPBWwEjIZtSorCWKqiq42Q7YSr+N6xOOeU8Mb2dBYJsewYI/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38070700005)(71200400001)(6486002)(110136005)(2616005)(186003)(86362001)(83380400001)(508600001)(4326008)(6512007)(6506007)(8936002)(36756003)(8676002)(5660300002)(122000001)(38100700002)(2906002)(66476007)(66946007)(76116006)(91956017)(66556008)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9IlA5r8+vMJRbFnqhPv/PAB+9Nb638ipOQWKOAtWCpQCunWX2/0bBdkDMP?=
 =?iso-8859-1?Q?eVEVE/qKEzLKj0e9pjyEClhFVDxP8y/aOi1hem6CNR9jL1xdwmFO+Rbiil?=
 =?iso-8859-1?Q?NwELnWBHQ8zXfIyu2mYRJXxm+O0j3Phj1/Cgwv9ASyA4eqnWgkcUbM6Jhd?=
 =?iso-8859-1?Q?0PVYKxc4MgyNr4FR1MOH/uQfe7xp30g+jH+xBNp5/F050A0970vKgc/cCR?=
 =?iso-8859-1?Q?NlCfiWOcr252yvRxe9sojUH2NbUpOTgJBqQzMueBeEOqFmZoqep8w0KMy9?=
 =?iso-8859-1?Q?dxJ2ILr0FZLbmQiQJL8wdkaIYd1deoosgt7Imia1VtZhuAxllShspC8pi0?=
 =?iso-8859-1?Q?rxQFg4+QIKJtzRWlOyDERZe6s86pVUV/+9uYRaDIZpPQavYwQH5DVqhVUA?=
 =?iso-8859-1?Q?eMqcw6Om3vgy6Lg531YI7+3sJmLPmLbicaXASDdMtBTW/jryR6TuT8zp4v?=
 =?iso-8859-1?Q?0363B+zKW7ixI0oUCqGvxKDwbdLC1nhK+80GHV4nx/Uq3szSLtIxSO8d2j?=
 =?iso-8859-1?Q?z0F9D+xtwdKMGXcy4YnwrPsXmKRJ6x+RfHoIzXmgf1RixFeYsK6XOkn4Gw?=
 =?iso-8859-1?Q?/GYHMiGWnQE+ItCdqZ3DIr9/VD2OFJYLblSLk1vBjpq8yUONvFm7G2ht+7?=
 =?iso-8859-1?Q?Ooq0PqBVKWEUAfwagHfZCryqXkJ61qcLrng0NLZTSx8wzbN9qSYA61a3Y5?=
 =?iso-8859-1?Q?RZ75sEai7/ev7dYcQ0qm26e1idu1hf3JxsZ28aliVz9EgdHzf87vpouDj8?=
 =?iso-8859-1?Q?5h0yysPD5joZW2BwSipwQ8Xnm+0gLUCkOxC9RBNpuQBCEePKIgIbjJjmBf?=
 =?iso-8859-1?Q?DnE5oDCKsqibyF9dmo7H8NT84KfDZej+mlTy85p6MVuDJl8MAITAJIBXrM?=
 =?iso-8859-1?Q?+QNDaaWxvmNKsBFBkJ2LcavPLSqM8hk2rZFTTj0z+cryE3zgP1j+aXbteY?=
 =?iso-8859-1?Q?gcYFjrGiwpC7jM/7G6bsac7GPCYGkxUK1drGrgmIl4hQkpoCxBTGZvDeBg?=
 =?iso-8859-1?Q?E1Kfw/R2UYTw842+R++t+a/W0qqKSo0THknMcNFCiqR4LpMWQidIhGAA1a?=
 =?iso-8859-1?Q?4kXPagKSNSNxR+RPAFFKiVmm2wF41xC0HyIAdgu6C25vaDRDRWY4K42+gJ?=
 =?iso-8859-1?Q?YwhafG0S8D3HR0xERGxUhANGVupxFEo9AWjBiF2atf5coPqFmoiWlzi920?=
 =?iso-8859-1?Q?d2OLWMY6SnRRZjVsCGm/UBYShuzGhy2YlcUphBm3wIrAXGzeVHThl3NhMV?=
 =?iso-8859-1?Q?GNVLkQpGMiMiDzTRCbzgeshlm05hhxvPPVqfYENiiwLKT2fXj+1OWEU+bN?=
 =?iso-8859-1?Q?HOIVOHQYZxZmdZE+jbh7rPbz3SvNbSxP0+a4yYVe2RK1a2EhCrI/+SISnv?=
 =?iso-8859-1?Q?Dvi6Re0e2mCJQ0vXGFC8TglM1NdWWysZi3HjBrlE0++q2RfVOOLs8g92UU?=
 =?iso-8859-1?Q?+/s8rEV7YNmqtW50UAPFcp4iPCHDNq1J7s/w6i3s5XqLh/LLZhzEyKyDCt?=
 =?iso-8859-1?Q?QKR/BxLN3VKlRDjQelMpq0JhDex3df5EBAD9PjSqyB41lipgRyT/4U3/VN?=
 =?iso-8859-1?Q?DNw/CGY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0a244c-c18f-4ef0-0853-08da0b929ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 23:29:18.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LviWva65v2DmkBOR7W4xyLKXwluWUaM5ddCxyxYjHryEl7b2pZMnvFRwKfU4NwcO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3655
X-Proofpoint-GUID: QeWmOrt8e5s7Gtc083henxPTldoL7nOk
X-Proofpoint-ORIG-GUID: QeWmOrt8e5s7Gtc083henxPTldoL7nOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_10,2022-03-21_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii noticed that since f97b8b9bd630 (bpftool: Fix a bug in subskeleton c=
ode generation)
the subskeleton code allows bpf_object__destroy_subskeleton to overwrite
the errno that subskeleton__open would return with. While this is not
currently an issue, let's make it future-proof.

This patch explicitly tracks err in subskeleton__open and skeleton__create
(i.e. calloc failure is explicitly ENOMEM) and ensures that errno
is -err on the error return path. The skeleton code had to be changed
since maps and progs codegen is shared with subskeletons.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/bpf/bpftool/gen.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 7ba7ff55d2ea..e30f7bd48a2b 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -828,8 +828,10 @@ codegen_maps_skeleton(struct bpf_object *obj, size_t m=
ap_cnt, bool mmaped)
 			s->map_cnt =3D %zu;			    \n\
 			s->map_skel_sz =3D sizeof(*s->maps);	    \n\
 			s->maps =3D (struct bpf_map_skeleton *)calloc(s->map_cnt, s->map_skel_s=
z);\n\
-			if (!s->maps)				    \n\
+			if (!s->maps) {				    \n\
+				err =3D -ENOMEM;			    \n\
 				goto err;			    \n\
+			}					    \n\
 		",
 		map_cnt
 	);
@@ -870,8 +872,10 @@ codegen_progs_skeleton(struct bpf_object *obj, size_t =
prog_cnt, bool populate_li
 			s->prog_cnt =3D %zu;			    \n\
 			s->prog_skel_sz =3D sizeof(*s->progs);	    \n\
 			s->progs =3D (struct bpf_prog_skeleton *)calloc(s->prog_cnt, s->prog_sk=
el_sz);\n\
-			if (!s->progs)				    \n\
+			if (!s->progs) {			    \n\
+				err =3D -ENOMEM;			    \n\
 				goto err;			    \n\
+			}					    \n\
 		",
 		prog_cnt
 	);
@@ -1182,10 +1186,13 @@ static int do_skeleton(int argc, char **argv)
 		%1$s__create_skeleton(struct %1$s *obj)			    \n\
 		{							    \n\
 			struct bpf_object_skeleton *s;			    \n\
+			int err;					    \n\
 									    \n\
 			s =3D (struct bpf_object_skeleton *)calloc(1, sizeof(*s));\n\
-			if (!s)						    \n\
+			if (!s)	 {					    \n\
+				err =3D -ENOMEM;				    \n\
 				goto err;				    \n\
+			}						    \n\
 									    \n\
 			s->sz =3D sizeof(*s);				    \n\
 			s->name =3D \"%1$s\";				    \n\
@@ -1206,7 +1213,7 @@ static int do_skeleton(int argc, char **argv)
 			return 0;					    \n\
 		err:							    \n\
 			bpf_object__destroy_skeleton(s);		    \n\
-			return -ENOMEM;					    \n\
+			return err;					    \n\
 		}							    \n\
 									    \n\
 		static inline const void *%2$s__elf_bytes(size_t *sz)	    \n\
@@ -1466,12 +1473,12 @@ static int do_subskeleton(int argc, char **argv)
 									    \n\
 			obj =3D (struct %1$s *)calloc(1, sizeof(*obj));	    \n\
 			if (!obj) {					    \n\
-				errno =3D ENOMEM;				    \n\
+				err =3D -ENOMEM;				    \n\
 				goto err;				    \n\
 			}						    \n\
 			s =3D (struct bpf_object_subskeleton *)calloc(1, sizeof(*s));\n\
 			if (!s) {					    \n\
-				errno =3D ENOMEM;				    \n\
+				err =3D -ENOMEM;				    \n\
 				goto err;				    \n\
 			}						    \n\
 			s->sz =3D sizeof(*s);				    \n\
@@ -1483,7 +1490,7 @@ static int do_subskeleton(int argc, char **argv)
 			s->var_cnt =3D %2$d;				    \n\
 			s->vars =3D (struct bpf_var_skeleton *)calloc(%2$d, sizeof(*s->vars));\=
n\
 			if (!s->vars) {					    \n\
-				errno =3D ENOMEM;				    \n\
+				err =3D -ENOMEM;				    \n\
 				goto err;				    \n\
 			}						    \n\
 		",
@@ -1538,6 +1545,7 @@ static int do_subskeleton(int argc, char **argv)
 			return obj;					    \n\
 		err:							    \n\
 			%1$s__destroy(obj);				    \n\
+			errno =3D -err;					    \n\
 			return NULL;					    \n\
 		}							    \n\
 									    \n\
--=20
2.34.1
