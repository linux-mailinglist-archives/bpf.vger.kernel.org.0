Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7329036BBE
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 07:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFFFkN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 01:40:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59806 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbfFFFkM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jun 2019 01:40:12 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x565dfH2011484;
        Wed, 5 Jun 2019 22:39:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=sO391QFJCa2eLcwUNnbTRhXYXFuO1wkzd78zVKnzFJk=;
 b=X1Ll1lbnfbBwOc2nDToZ3FbdemPGc1ByimUvHnwnTXSm3sJjDgf74JK69BLPougm+XSV
 mpNSXhVItROwTNS951QZTPZ+UlS8ulSHiwRBYlkHbS1QsPbgrGl8FsGpq7XuED28rxgb
 nJ/P+6MCbgwdexOEh2YQXv2Tk1lMeKtFy6Q= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sxqppgua5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Jun 2019 22:39:48 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 5 Jun 2019 22:39:47 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 5 Jun 2019 22:39:47 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Jun 2019 22:39:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO391QFJCa2eLcwUNnbTRhXYXFuO1wkzd78zVKnzFJk=;
 b=YFnvSw1/0u9FUH+iwySTV5KATmwFqIWthzbSHu3SfJWethoshl3lBYjiqtsHy5d5CWeSP+KdSFMhJG5U+NB/CxcaqLdEQR6kKipAiXkdDtG4rNAD+whMYs62iv3TivemEi9uigJKaRiHT8SqVgOouGbUGcr1DkqmdAwtvF9cc+0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1727.namprd15.prod.outlook.com (10.174.96.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 05:39:33 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 05:39:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Hechao Li <hechaol@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/2] bpf: Add a new API libbpf_num_possible_cpus()
Thread-Topic: [PATCH 0/2] bpf: Add a new API libbpf_num_possible_cpus()
Thread-Index: AQHVG/Scq94tv95ggEKQQT8yveWl9KaOHIUA
Date:   Thu, 6 Jun 2019 05:39:32 +0000
Message-ID: <3E5DB8E5-35D2-49DF-BB0A-B69154A4764F@fb.com>
References: <20190605231506.2983988-1-hechaol@fb.com>
In-Reply-To: <20190605231506.2983988-1-hechaol@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:efa5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82d6eec4-f18d-489e-0bec-08d6ea415a60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1727;
x-ms-traffictypediagnostic: MWHPR15MB1727:
x-microsoft-antispam-prvs: <MWHPR15MB1727652E186CE9085E1E962EB3170@MWHPR15MB1727.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39840400004)(366004)(376002)(346002)(199004)(189003)(50226002)(36756003)(6436002)(66446008)(66476007)(186003)(25786009)(6506007)(64756008)(53546011)(66946007)(57306001)(66556008)(6512007)(4744005)(76116006)(99286004)(82746002)(76176011)(102836004)(5660300002)(229853002)(53936002)(86362001)(73956011)(37006003)(81166006)(6116002)(6486002)(256004)(7736002)(71200400001)(8936002)(316002)(71190400001)(305945005)(6246003)(83716004)(6862004)(8676002)(486006)(54906003)(46003)(14454004)(6636002)(446003)(476003)(2616005)(478600001)(68736007)(11346002)(4326008)(81156014)(33656002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1727;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F7TxcvpJOBmRjwKKnQ84DgDS8CdG4zdU3ZDp77Xrckqu2/kqHyVj9VjgU4nL4BeikJXWqaRwaqf/oWvCQGQRwc18hutfSF+E5G67kFWjoTR69HFazJG5dPo+1YTqSToXVz/kvf6ZxtafUWEozh+HhVMRdlH6OSBbGeg5rwswM2w2IUaqAn3U5V1F6SAsmjpSBo7kEmx9R036wzRDviw0jrxKgjDQZZJOvw0hkAfuCXwI0jT0eMDGMNkXkFb4ilCox+8HCT5E13+PKmBwDZ5CDrBSno/DFDT8yMd3I4rUDbjN63x5wX+zZeeGL4oZnsmreAchh7iFpDIGMQH/GnT4QyDWnmVsx6YTTkuU4qJ3qNtAy5e3T3E29zoqAhBsAdVayJ2Dv4hG2ApwC5oLu0mWPos1CUm/noqI5YMMx3cdPig=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <757A347574E0924DAADF4D975ED4CF87@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d6eec4-f18d-489e-0bec-08d6ea415a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 05:39:32.7760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1727
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060042
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jun 5, 2019, at 4:15 PM, Hechao Li <hechaol@fb.com> wrote:
>=20
> Getting number of possible CPUs is commonly used for per-CPU BPF maps
> and perf_event_maps. Add a new API libbpf_num_possible_cpus() that
> helps user with per-CPU related operations and remove duplicate
> implementations in bpftool and selftests.
>=20
> Hechao Li (2):
>  bpf: add a new API libbpf_num_possible_cpus()
>  bpf: use libbpf_num_possible_cpus in bpftool and selftests
>=20
> tools/bpf/bpftool/common.c             | 53 +++-----------------------
> tools/lib/bpf/libbpf.c                 | 49 ++++++++++++++++++++++++
> tools/lib/bpf/libbpf.h                 | 16 ++++++++
> tools/lib/bpf/libbpf.map               |  1 +
> tools/testing/selftests/bpf/bpf_util.h | 37 +++---------------
> 5 files changed, 76 insertions(+), 80 deletions(-)
>=20
> --=20
> 2.17.1
>=20

Please specify which tree the patch is based on (bpf-next for=20
this one), and version of patch (v2) in the subject with

    git format-patch --subject-prefix=3D"PATCH v2 bpf-next"

Thanks,
Song


