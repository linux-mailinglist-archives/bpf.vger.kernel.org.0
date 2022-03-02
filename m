Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F224C9B64
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 03:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiCBCtj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 21:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiCBCti (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 21:49:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E76AA022
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 18:48:56 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2221cmCf017818
        for <bpf@vger.kernel.org>; Tue, 1 Mar 2022 18:48:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Aramq/23cv9gBb4zXtXh8pwhRm2yRj8KGGRSyFVOfeg=;
 b=o2xgO6T5AqEwifCxlwiXQ2uSMfxFeO7eRj0sy68Ur/RQ0UqPOmGcaeiJF9zPx0CKHTBq
 kUWKe2h8Q/npQm6wV+tsOJrarkpYKEB3Ovt77e2ml22/KAxMHk6g3V7wIxzs5aeChbdF
 DdaCZ3+dZJubYjgAnv7RwBcSTZ60v83yFow= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ehn5wmt5a-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Mar 2022 18:48:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/9lGDEtr4QoT+NLaCbSaSwe9xU5MMJBYv4ApRjsfW6UhrocwS1L/zWaYGYvNC9OB0VGPnE9czHSIpA/Bh2QdZp1W4f/FsbnjftxJ3TYARtRq8YKwHuHte/UFWK9EBYLtNZ2HXsDim/AXPBxMqKKo/Vwn4rYycVk7S9EjxcI9qmcWGZPaRqX2jM0cjtrizUQ8liMhB5BBrse/JViRK7yOm/qiggUdfJ99VqQ1kxkZtUDwk7E799n1Ar202ssKCAmTGI/qd1hU5UrzyYeSSiLcfwdLuVTVHlYdj6ux7fMHWxkmloMSlfw5q2pL8+jHE18lvT/lBOkchz9C+PDsEfaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aramq/23cv9gBb4zXtXh8pwhRm2yRj8KGGRSyFVOfeg=;
 b=fXFmaQ6rX2WpndCMvnR2BdgmMS/0AvxLd0M6vZxvQeL7czi5fzLwXELML8FFVrzcOoDT882fc9lGhmdpug2GdJEHH4Hr9AA4OREQePzM7bc0hAw6Ux9FqV2owhJ3N5HtpF2KrGc8UgGgua8w+QbHdha/Pae40E8rCel4U2KrVTGggG5SNEyzz5f6dj8Bq/DU81bmikWy7qQu/eKD1OBjG2+M/7Hnm2guA810Rn+sXrSZOAodugsvDm7UrTuz9IGHmzZvGa9Ti+UX+tlvt1rSsYmBasZHdFtImAqhX3eU+WJ6mg7a5hd+o9QTCWVpYOxqNI9IxkpJTlomAUbWiVA6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MW4PR15MB4441.namprd15.prod.outlook.com (2603:10b6:303:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 02:48:50 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 02:48:50 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next 0/4] Subskeleton support for BPF libraries
Thread-Topic: [PATCH bpf-next 0/4] Subskeleton support for BPF libraries
Thread-Index: AQHYLeALXEbvktBNF0S1HbrihHCfaw==
Date:   Wed, 2 Mar 2022 02:48:50 +0000
Message-ID: <cover.1646188795.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06eeedda-6b43-48ab-8328-08d9fbf72e64
x-ms-traffictypediagnostic: MW4PR15MB4441:EE_
x-microsoft-antispam-prvs: <MW4PR15MB444156E96B3F19BF61FFCB89C1039@MW4PR15MB4441.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E73vbPx3inOSk6Jce5btPli57Y9tlMw93c1dnm0skX9aXcu50V1uQDuajhzJMycdOG7C3md+awRHA7m+Ic4TITsZuG2omLojUFkxa39S+9m20U+wYNrRW60zDKgKOpzW+AkMRWVss/QEpkjsWhCtBmI4FAj9nfWCHHV3IWXjhXEUDZh60shbrn69v6uJkzL214JcXkP9g1hd8p8mlEJteKNu+g3DrhnfU6sEXLOk4q0NJ0Y4+MnmrV/QCqKFBDszfpS4NeOtQJ5iXbo4LWwZl1Sq8YTWF2TG7OKuhfSi/WAxWGVBli5TAw5gLDDX8u+cPfD3KMIWcIDARKZaFpBYTWxgLTcmX2f4z7r4tT3UlQ0Ut4Nij+GTmhCCcm8NruYqxlhgDdhl3FEcc12/NWoCj+3DTwc4JE73CTMJrrbCDIt1rKx3zxbioxc7h42s652esqXLVlzhtghFP8WBSQQhJeEoRv/OW8bQxpEk5o54g4BDoAdjVTeWHVQuFftibuH46dqPGB9KYCjUyetpMpgLeL2PeMiQgsJOxRZ7qUEjeiv4NLs/QvaWGCjo0RKpL5/8FxeFomv1bu9n+HeQXeOp+Ph/tKwaApt1thRfKBt1d5usmu0iPMkbrEwxXM3j6NaVkZe2gloYhPb14GJaxCdpaWRX8uuK+C/bbsUSQceIlaRJxuxUlcwUIQmrSKO32UDq2WRc6asvcWdfiJ8YyzOCfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(83380400001)(110136005)(122000001)(86362001)(6512007)(6506007)(66476007)(186003)(38070700005)(91956017)(36756003)(2616005)(66946007)(76116006)(66446008)(66556008)(64756008)(2906002)(8936002)(5660300002)(71200400001)(508600001)(8676002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yNg/HF2bA5pg4zF+tyTXEmm2Dzfjk8ChKEuuaSTXKjFJkTXtz+928ai7lt?=
 =?iso-8859-1?Q?0nO6HQ8r1wBhAssP3aInjKzm0BnfWCXNetGhCSS8NjMjp4eEFeEgJh2VQm?=
 =?iso-8859-1?Q?jEbdz+n4g8OrdjYU3vtvu7CLjv6unK+AYz83KgGGkxpO8WjiLAGJyQBbVd?=
 =?iso-8859-1?Q?0Sin/iHipAGHL/xSF5svO1JCe2pKtB2Oh6TP8bDF4kvjDYtEbLTtKzOfIh?=
 =?iso-8859-1?Q?285Pc2uxSP1fM8yKRaxpmS5LbjlWuRvwqTdO96ViFTKKuVKnQdprSVaVKz?=
 =?iso-8859-1?Q?1Pl87c5rV08pCL17BCoQtlEQvXhj0ZdBe6zTlzh3cdtDKuYY7nVifJqErT?=
 =?iso-8859-1?Q?/73ZlAzASzEB4Cxpa0Kw+ZttvtGYUTFB7+nmKxwpPiUxZNuRcD4niW7P4a?=
 =?iso-8859-1?Q?fYdRJ86iIKHll9tECR0marZvMSiMXjR7PVmylWg/3GMs6rCoIEwJeH9J1+?=
 =?iso-8859-1?Q?1kmcYQs3q8/nvmEiz2tT5AgoFeWddgQUWp9QojuXLTXEy1t5H1DaXAgEXF?=
 =?iso-8859-1?Q?v7KYxiaFN6dWCB5+VjZBxnyiQ8odsowooAvJWgf4C5pBF+MKExLWR1I5qo?=
 =?iso-8859-1?Q?jAcF/+xwa7rP1G+QKETxrBgk/twURiom/qbzYb+5BXG0k4B6p/l0zdp+Fb?=
 =?iso-8859-1?Q?hCfDA9wSt6u/1rtwf1tDXgb7AdBhOH9iYDNt8Uzwzs/DWvEYCGUf9TT4kh?=
 =?iso-8859-1?Q?oIhpUEP6aSGzRKe4nNvFd1qL6sgxH/vLD7bNg5DKViY5Of+ic6LRdfgvna?=
 =?iso-8859-1?Q?IJ07pSKZEwpYXmKLI8E43gpMvfyjVZK1VjvyOe+ug0NQ6Tmgg1O9pYQ9nb?=
 =?iso-8859-1?Q?96IkIsdiCKKYD+wpJFJcdwnaLmBogK7TbN5yPCik5cK1E6R7KWU4on0+a9?=
 =?iso-8859-1?Q?jGvaCDAHFsajtJPi3nXOMmfc9J/VUpTX6mck/QccELXg4ewLOtbzRvhlQy?=
 =?iso-8859-1?Q?413cvY8RKYFavArvQCo8FdFIgDJKbZZkjQNJpwuPVB2Sneh0F8gPWvPgQE?=
 =?iso-8859-1?Q?d9sOURUDt5pb/jev7wZmT89iQRnFqqBMiCiW8+3uzfkjIEqmKPm1bdhb3S?=
 =?iso-8859-1?Q?YM7l4DiLfWLKLuj+SOfmSzA4ACYK5C6bZIQqP/niZDorlMJw65ZAN2L37F?=
 =?iso-8859-1?Q?o1vdU3NYQ6FsKvVOLC+Mo8UTAFEupaUCiFY7g8PHGE/78l5jnzQwAZfOXx?=
 =?iso-8859-1?Q?9ZMOp07X6iCrIXvjqA1QjsqfeLWk20rYCPPh4MKWUoxK2sDOmeBbwXhizv?=
 =?iso-8859-1?Q?JmOkyqmr9F9QeKigpDSrIrTX1ISdQXdaLQicedl/yIm3Ie67nJU4iQkgjG?=
 =?iso-8859-1?Q?DRPECTOZsFxGBUdQz/uLxTZzZeKyjniFVRuIvXG31Y7LATjLhcpPNwL0Tw?=
 =?iso-8859-1?Q?0ln8ut//b5xb2Qi3rCPwxMTKOiXktS107k9biOvirD4BkjDlF/LdZOdRGc?=
 =?iso-8859-1?Q?89OgCVYMEpfMTJDAQmiJYtmlgA7bH4EgsvPZ0WN7hye3/dUcI9dwznSxTk?=
 =?iso-8859-1?Q?ew4wDwtaOH6myERKMuXNqaKiQiFIYJ2plRgq3Q6vjZm9CYZBb7+UIcaggW?=
 =?iso-8859-1?Q?0htOkMbf+Q5Lu7A/RMhtUfDfbl2mGCAkeidMYngN9tgM6OFpiTYRUgW1Jx?=
 =?iso-8859-1?Q?fvb6NeMXeXS3QlveeGiE81P5Y5WMQEEE4L896Sf35sMMzhxNYNKTVZzA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06eeedda-6b43-48ab-8328-08d9fbf72e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 02:48:50.2687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8fLZVKCOJIqo0plFqCNeb+hstSsR7OzCR4jBSqdvMAVl0SosGpzSZFTGVdCbbZG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4441
X-Proofpoint-GUID: wZIFfGrcVLliphkimDSGJUrmjdV1u6fj
X-Proofpoint-ORIG-GUID: wZIFfGrcVLliphkimDSGJUrmjdV1u6fj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020010
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the quest for ever more modularity, a new need has arisen - the ability =
to
access data associated with a BPF library from a corresponding userspace li=
brary.
The catch is that we don't want the userspace library to know about the str=
ucture of the
final BPF object that the BPF library is linked into.

In pursuit of this modularity, this patch series introduces *subskeletons.*
Subskeletons are similar in use and design to skeletons with a couple of di=
fferences:

1. The generated storage types do not rely on contiguous storage for the li=
brary's
variables because they may be interspersed randomly throughout the final BP=
F object's sections.

2. Subskeletons do not own objects and instead require a loaded bpf_object*=
 to
be passed at runtime in order to be initialized. By extension, symbols are =
resolved at
runtime by parsing the final object's BTF. This has the interesting effect =
that the same
userspace code can interoperate with the library BPF code *linked into diff=
erent final objects.*

3. Currently, only globals are supported though the codegen can be extended=
 to support
non-owning pointers to maps, progs, links, etc.

Areas that are RFC/TODO:
* AFAICT, the ELF section names are the only way to find the correct maps i=
n the final
linked object. As a result, I've added bpf_map__section_name so bpftool can=
 use the section
names in the codegen. Do let me know if there's a better design I'm missing=
.

* The bpf_object__{open,destroy}_subskeleton approach mirrors the correspon=
ding skeleton
support functionality. Do let me know if there's anything that needs to exi=
st in it to ensure
forward compatibility. (Unfortunately, I don't see any way for subskeletons=
 to work with older
libbpf versions, so I'd rather introduce all the new APIs they may need in =
a single version.)


Delyan Kratunov (4):
  libbpf: expose map elf section name
  bpftool: add support for subskeletons
  libbpf: add subskeleton scaffolding
  selftests/bpf: test subskeleton functionality

 tools/bpf/bpftool/gen.c                       | 322 +++++++++++++++++-
 tools/lib/bpf/libbpf.c                        |  84 +++++
 tools/lib/bpf/libbpf.h                        |  23 ++
 tools/lib/bpf/libbpf.map                      |   7 +
 tools/lib/bpf/libbpf_version.h                |   2 +-
 tools/testing/selftests/bpf/Makefile          |  18 +-
 .../selftests/bpf/prog_tests/subskeleton.c    |  38 +++
 .../bpf/prog_tests/subskeleton_lib.c          |  29 ++
 .../selftests/bpf/progs/test_subskeleton.c    |  20 ++
 .../bpf/progs/test_subskeleton_lib.c          |  22 ++
 10 files changed, 553 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton_lib.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.=
c

--
2.34.1=
