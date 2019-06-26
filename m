Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5613A57232
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 22:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfFZUFR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jun 2019 16:05:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25928 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfFZUFQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jun 2019 16:05:16 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QJsidE008607;
        Wed, 26 Jun 2019 13:04:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YjAICQ856SewSOffESJ1ngSujYiRRNMvvaQ6saR3HnY=;
 b=VsI5wntFyIJD+rZJUkL+kvW5g93PidXLJZdrqseJ7arERayNTr8TU+9PkmWXH3oLDxo7
 azRbsDhKMKCYnqda/4VypiOkPkMu1gEBct0YA/+Kd4GHLu7dJESYF8aB1oWzzidrQcX9
 ibqaNHRZL4sWqwCnI9vRhHkaLsWb2esly7w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tc1f32y0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 26 Jun 2019 13:04:55 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Jun 2019 13:04:54 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Jun 2019 13:04:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjAICQ856SewSOffESJ1ngSujYiRRNMvvaQ6saR3HnY=;
 b=jaiD9gRRAygmMKn9Tx2IoBzDwNB1L81nJ50wXtZQdH6qYA3cRNvk3QA5XpyZ5UqMXScYWn3uqfgRJ6/IbouzMR2XIyvo7jvdZdQtPlArfGMsT28gXMOjwn+rpGX145hp6+/rc0KN4HhhkEkcdeVlXejq0jkXTOpx1HBhTFDdwBo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1952.namprd15.prod.outlook.com (10.175.8.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 20:04:39 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 20:04:39 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Roman Gushchin <guro@fb.com>
CC:     Alexei Starovoitov <ast@kernel.org>, Tejun Heo <tj@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpf: fix cgroup bpf release synchronization
Thread-Topic: [PATCH v2 bpf-next] bpf: fix cgroup bpf release synchronization
Thread-Index: AQHVK55r9AuvaKTWHkKIkzVbE0QYsKauXYcA
Date:   Wed, 26 Jun 2019 20:04:39 +0000
Message-ID: <CFCB43C0-74FB-4E93-9FCA-605A98C4C960@fb.com>
References: <20190625213858.22459-1-guro@fb.com>
In-Reply-To: <20190625213858.22459-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:6898]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83b4fe87-b9db-49f7-6f5c-08d6fa718565
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1952;
x-ms-traffictypediagnostic: MWHPR15MB1952:
x-microsoft-antispam-prvs: <MWHPR15MB1952D89A36A9F9AC4ED0EAF6B3E20@MWHPR15MB1952.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(81166006)(76176011)(229853002)(5660300002)(36756003)(99286004)(33656002)(8936002)(6246003)(50226002)(25786009)(7736002)(53936002)(68736007)(6116002)(6436002)(57306001)(86362001)(6486002)(478600001)(2906002)(305945005)(64756008)(66556008)(46003)(102836004)(6636002)(11346002)(8676002)(6512007)(71190400001)(66946007)(14454004)(66476007)(53546011)(186003)(6506007)(6862004)(71200400001)(446003)(76116006)(73956011)(256004)(2616005)(5024004)(14444005)(4326008)(54906003)(476003)(486006)(316002)(81156014)(37006003)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1952;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G/sK1LK58GnJbSOap+giapOTvxvjLuin76wUzDrZhcSgMGnWtiyd9Ho92OniJHm0hdfi3Cfu7Zg9NNU/mTmHuQRTnVB/3Uc41wpJD52CZmJFHfEhu9qfVPqZAGNMynsGp/tSycc2DPK9ft50LtS4GoDWmBjSoEopPpTQKdOLZrlgOmjDCGmhDKyMQ6ZRlr9JrVM248+VxBchHF9UlVboumM70YczUgSNWJt+j1ek17RCeT/z4uVO46r5Iv9aMpXvRubm/cwW7NsrrHOVEMKK6QSMO1N+wf6tAdek+BCu+fZmxkdDzQ3/dtHSiOHlwSxC6H9rMEbD14tox7viIbVURPUJNb3N0StKBA/3kMYy7TmxDo9dmEtAPSIv2IvPHeK6DfGXYca9/ykWd+Q0jRmZ48WpVILevDbLNiALhqeMoXg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9EF7D873D46084EB925A14A3E4A4073@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b4fe87-b9db-49f7-6f5c-08d6fa718565
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 20:04:39.4238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1952
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=931 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260232
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jun 25, 2019, at 2:38 PM, Roman Gushchin <guro@fb.com> wrote:
>=20
> Since commit 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf
> from cgroup itself"), cgroup_bpf release occurs asynchronously
> (from a worker context), and before the release of the cgroup itself.
>=20
> This introduced a previously non-existing race between the release
> and update paths. E.g. if a leaf's cgroup_bpf is released and a new
> bpf program is attached to the one of ancestor cgroups at the same
> time. The race may result in double-free and other memory corruptions.
>=20
> To fix the problem, let's protect the body of cgroup_bpf_release()
> with cgroup_mutex, as it was effectively previously, when all this
> code was called from the cgroup release path with cgroup mutex held.
>=20
> Also let's skip cgroups, which have no chances to invoke a bpf
> program, on the update path. If the cgroup bpf refcnt reached 0,
> it means that the cgroup is offline (no attached processes), and
> there are no associated sockets left. It means there is no point
> in updating effective progs array! And it can lead to a leak,
> if it happens after the release. So, let's skip such cgroups.
>=20
> Big thanks for Tejun Heo for discovering and debugging of this
> problem!
>=20
> Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from
> cgroup itself")
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>

LGTM.=20

Acked-by: Song Liu <songliubraving@fb.com>


> ---
> kernel/bpf/cgroup.c | 19 ++++++++++++++++++-
> 1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index c225c42e114a..077ed3a19848 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -16,6 +16,8 @@
> #include <linux/bpf-cgroup.h>
> #include <net/sock.h>
>=20
> +#include "../cgroup/cgroup-internal.h"
> +
> DEFINE_STATIC_KEY_FALSE(cgroup_bpf_enabled_key);
> EXPORT_SYMBOL(cgroup_bpf_enabled_key);
>=20
> @@ -38,6 +40,8 @@ static void cgroup_bpf_release(struct work_struct *work=
)
> 	struct bpf_prog_array *old_array;
> 	unsigned int type;
>=20
> +	mutex_lock(&cgroup_mutex);
> +
> 	for (type =3D 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
> 		struct list_head *progs =3D &cgrp->bpf.progs[type];
> 		struct bpf_prog_list *pl, *tmp;
> @@ -54,10 +58,12 @@ static void cgroup_bpf_release(struct work_struct *wo=
rk)
> 		}
> 		old_array =3D rcu_dereference_protected(
> 				cgrp->bpf.effective[type],
> -				percpu_ref_is_dying(&cgrp->bpf.refcnt));
> +				lockdep_is_held(&cgroup_mutex));
> 		bpf_prog_array_free(old_array);
> 	}
>=20
> +	mutex_unlock(&cgroup_mutex);
> +
> 	percpu_ref_exit(&cgrp->bpf.refcnt);
> 	cgroup_put(cgrp);
> }
> @@ -229,6 +235,9 @@ static int update_effective_progs(struct cgroup *cgrp=
,
> 	css_for_each_descendant_pre(css, &cgrp->self) {
> 		struct cgroup *desc =3D container_of(css, struct cgroup, self);
>=20
> +		if (percpu_ref_is_zero(&desc->bpf.refcnt))
> +			continue;
> +
> 		err =3D compute_effective_progs(desc, type, &desc->bpf.inactive);
> 		if (err)
> 			goto cleanup;
> @@ -238,6 +247,14 @@ static int update_effective_progs(struct cgroup *cgr=
p,
> 	css_for_each_descendant_pre(css, &cgrp->self) {
> 		struct cgroup *desc =3D container_of(css, struct cgroup, self);
>=20
> +		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
> +			if (unlikely(desc->bpf.inactive)) {
> +				bpf_prog_array_free(desc->bpf.inactive);
> +				desc->bpf.inactive =3D NULL;
> +			}
> +			continue;
> +		}
> +
> 		activate_effective_progs(desc, type, desc->bpf.inactive);
> 		desc->bpf.inactive =3D NULL;
> 	}
> --=20
> 2.21.0
>=20

