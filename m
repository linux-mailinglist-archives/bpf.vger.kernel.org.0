Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D865011D520
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 19:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfLLSSQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 13:18:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65422 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730034AbfLLSSP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Dec 2019 13:18:15 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCID5rD012739;
        Thu, 12 Dec 2019 10:18:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=P/x5K+hEwYjcvqTwJS7gQTdDD0aXLm6GV6jwhxRFpWw=;
 b=hZJckWjybUQBU3tS5IUJ520+cV9cs+ClXwOnQ0r9ADC7sUGhG/FxRbr54JvPPm0T8LWF
 gaij5DcB/LNbNX/FTaxb8kunMujQouLx9e0x7oUa5XDf5HSMiT6YLHzB3OvxBVrxJySf
 VSA6Hz32+UsFsSW8gDip/TeCfjftNrRyC00= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wusrmravd-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Dec 2019 10:18:02 -0800
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 10:18:01 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 10:18:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRCE8i2Q2lOPyxpksJQMC/nRHctpq9LB/mvbsouFApD0nKhf2BiQLZmGha2stbYGEYbCZGXsWYpoPa4AHSu+HlYfXZFkX+awGEiizq+ovLizuw7LGe+RLeM6P232E7hX5MUqEPaHT3NDPoC0xnn5oyDkmcoc5jhnxclcN/X9KmBrx2C7EMin5ZPWNfBE3tCa+wVIjUxqTUUp93T2r0gyUvGbXJ9j0C25qrimwuC/EAe6dg8HdHeRfrKmYZhXMixxC68vrEufk1hIIXv/qiajLcvECSe4xCC1Jp+dUnIp4yMfhCZHQK5MNiCcpDTMXkYoRSw1joHnhDGSC7wyS8I72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/x5K+hEwYjcvqTwJS7gQTdDD0aXLm6GV6jwhxRFpWw=;
 b=Zut0wWKOkiyvk4arNGGD8tvgEI8d6jqhUHNYpVMTZeLt++BUVxtrHdD57Ikp3i60XTMVW+N6DSeZUhFwkoJA0b8QSoN8e3FltrCHTrNTa9bq2oSM0GWHYgULAhMXsOhZ6+Kh1fq0di0sygGihUX3a6QqbsWsARewVv4eo+4MlBFwGtcx/ryaHImfAuGviMr43GLJSu6pmpbsXa1vobll0YGy+6Gooj8iuixmJj6ZafmItatXWCm2En+biZnqL+vf2tXnixBCbF8k8qo13XaZ8Wu9JBs2FMLyGjJujkV64i97QB81gVWW36Pkb7CllEoWINvOzzXNXo+N+HytH5A2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/x5K+hEwYjcvqTwJS7gQTdDD0aXLm6GV6jwhxRFpWw=;
 b=lMqn8OBsEW5QgivOlaaVtEb1m8a993+twBxEjeHbcI4dpjevqX8EEuhPhWhWySUhH/fAcxhzhhzgFGyFmsDtP2q5c/4sGCRmOq7SZqBAl6Ftr2uvQlJDlmpo3KPE8ao6fjIobQn0W+x/QKGXf3jcvGwwVLgp1hr9jA1ZZEgUGDs=
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (20.179.21.76) by
 MN2PR15MB2622.namprd15.prod.outlook.com (20.179.144.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 18:18:00 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f%4]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 18:18:00 +0000
From:   Martin Lau <kafai@fb.com>
To:     Andrey Ignatov <rdna@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [Potential Spoof] [PATCH bpf-next 3/5] bpf: Support replacing
 cgroup-bpf program in MULTI mode
Thread-Topic: [Potential Spoof] [PATCH bpf-next 3/5] bpf: Support replacing
 cgroup-bpf program in MULTI mode
Thread-Index: AQHVr8uJSL+9WVL/wUGn0AGzggbnuqe20VwA
Date:   Thu, 12 Dec 2019 18:18:00 +0000
Message-ID: <20191212181756.ny22ca756bmzrlmm@kafai-mbp>
References: <cover.1576031228.git.rdna@fb.com>
 <7f7cd0c4fe9fc57e0819fbfc9922188b8c1c6aa2.1576031228.git.rdna@fb.com>
In-Reply-To: <7f7cd0c4fe9fc57e0819fbfc9922188b8c1c6aa2.1576031228.git.rdna@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0049.namprd10.prod.outlook.com
 (2603:10b6:300:2c::11) To MN2PR15MB3213.namprd15.prod.outlook.com
 (2603:10b6:208:3d::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::97ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc688ce0-cfaa-4d94-a278-08d77f2f9e9e
x-ms-traffictypediagnostic: MN2PR15MB2622:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB262270A3F433ED36FB229923D5550@MN2PR15MB2622.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(51914003)(316002)(71200400001)(6862004)(64756008)(66446008)(4326008)(6512007)(66556008)(66946007)(66476007)(86362001)(54906003)(33716001)(6636002)(9686003)(5660300002)(81156014)(8676002)(8936002)(81166006)(478600001)(52116002)(186003)(1076003)(2906002)(6486002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR15MB2622;H:MN2PR15MB3213.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztXT1Nap946OsQ3GlAOVpMc+kH8181Ia4NGvmljnYje86XS7fNeSV2U/jZN5e8rRrApWQn7eln9r2F1JdRSrsneK4tsSWJo+cC+d32hJipFDGmf7BPXKj/vpZEWXmlts9BJh381qtWnnwnWJkPyGckjfMIagNxvh6Hap8O9gtM3UipqYp4WNBCQVUG9FYecNEeZJY4FWessHUNNv3dR2NJYWLPqsz6J0b4E2dQMXBf0EjQQUOIF91G4wjTQ227UtwJedcChR225uxGyti9uAP67/6QwkCiaOSOKXxftsu8zK5J+saOAqtgkaTkSlSyS6VGrj+yVtaHPNKGaqvIZgULIZVXKGRhdUkXOEjZIOFpDIZTCxQew1iRIZ7D+nUjXbdvBeTK0ZSL2axQlFOB2Id62hztY+IoyQlSlFu7OgL9hXub4jvu/xEWMDWd0w3rlcrtu3YGU7YPddNihY6PwETXn7nMdORJatktrk2qTvgI3bjJMjI1PM5VlThbJDlxsF
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB0B18C21573ED4187B1EA2C41D863A3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cc688ce0-cfaa-4d94-a278-08d77f2f9e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 18:18:00.0339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PcDBDNGZ9hR+LKIfvZHSNAjkCjO1cJihtJp6CmhpaKXRSz+4AsYcJRZjjW5InkB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2622
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_05:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912120140
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 10, 2019 at 06:33:29PM -0800, Andrey Ignatov wrote:
> The common use-case in production is to have multiple cgroup-bpf
> programs per attach type that cover multiple use-cases. Such programs
> are attached with BPF_F_ALLOW_MULTI and can be maintained by different
> people.
>=20
> Order of programs usually matters, for example imagine two egress
> programs: the first one drops packets and the second one counts packets.
> If they're swapped the result of counting program will be different.
>=20
> It brings operational challenges with updating cgroup-bpf program(s)
> attached with BPF_F_ALLOW_MULTI since there is no way to replace a
> program:
>=20
> * One way to update is to detach all programs first and then attach the
>   new version(s) again in the right order. This introduces an
>   interruption in the work a program is doing and may not be acceptable
>   (e.g. if it's egress firewall);
>=20
> * Another way is attach the new version of a program first and only then
>   detach the old version. This introduces the time interval when two
>   versions of same program are working, what may not be acceptable if a
>   program is not idempotent. It also imposes additional burden on
>   program developers to make sure that two versions of their program can
>   co-exist.
>=20
> Solve the problem by introducing a "replace" mode in BPF_PROG_ATTACH
> command for cgroup-bpf programs being attached with BPF_F_ALLOW_MULTI
> flag. This mode is enabled by newly introduced BPF_F_REPLACE attach flag
> and bpf_attr.replace_bpf_fd attribute to pass fd of the old program to
> replace
>=20
> That way user can replace any program among those attached with
> BPF_F_ALLOW_MULTI flag without the problems described above.
>=20
> Details of the new API:
>=20
> * If BPF_F_REPLACE is set but replace_bpf_fd doesn't have valid
>   descriptor of BPF program, BPF_PROG_ATTACH will return corresponding
>   error (EINVAL or EBADF).
>=20
> * If replace_bpf_fd has valid descriptor of BPF program but such a
>   program is not attached to specified cgroup, BPF_PROG_ATTACH will
>   return ENOENT.
>=20
> BPF_F_REPLACE is introduced to make the user intend clear, since
> replace_bpf_fd alone can't be used for this (its default value, 0, is a
> valid fd). BPF_F_REPLACE also makes it possible to extend the API in the
> future (e.g. add BPF_F_BEFORE and BPF_F_AFTER if needed).
Thanks for the details explanation.

[ ... ]

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 283efe3ce052..45346c79613a 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -282,14 +282,17 @@ static int update_effective_progs(struct cgroup *cg=
rp,
>   *                         propagate the change to descendants
>   * @cgrp: The cgroup which descendants to traverse
>   * @prog: A program to attach
> + * @replace_prog: Previously attached program to replace if BPF_F_REPLAC=
E is set
>   * @type: Type of attach operation
>   * @flags: Option flags
>   *
>   * Must be called with cgroup_mutex held.
>   */
>  int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
> +			struct bpf_prog *replace_prog,
>  			enum bpf_attach_type type, u32 flags)
>  {
> +	u32 saved_flags =3D (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI)=
);
>  	struct list_head *progs =3D &cgrp->bpf.progs[type];
>  	struct bpf_prog *old_prog =3D NULL;
>  	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE],
> @@ -298,14 +301,15 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct=
 bpf_prog *prog,
>  	enum bpf_cgroup_storage_type stype;
>  	int err;
> =20
> -	if ((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI))
> +	if (((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI)) ||
> +	    ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI)))
>  		/* invalid combination */
>  		return -EINVAL;
> =20
>  	if (!hierarchy_allows_attach(cgrp, type))
>  		return -EPERM;
> =20
> -	if (!list_empty(progs) && cgrp->bpf.flags[type] !=3D flags)
> +	if (!list_empty(progs) && cgrp->bpf.flags[type] !=3D saved_flags)
>  		/* Disallow attaching non-overridable on top
>  		 * of existing overridable in this cgroup.
>  		 * Disallow attaching multi-prog if overridable or none
> @@ -320,7 +324,12 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct =
bpf_prog *prog,
>  			if (pl->prog =3D=3D prog)
>  				/* disallow attaching the same prog twice */
>  				return -EINVAL;
> +			if (pl->prog =3D=3D replace_prog)
> +				replace_pl =3D pl;
>  		}
> +		if ((flags & BPF_F_REPLACE) && !replace_pl)
> +			/* prog to replace not found for cgroup */
> +			return -ENOENT;
>  	} else if (!list_empty(progs)) {
>  		replace_pl =3D list_first_entry(progs, typeof(*pl), node);
>  	}
> @@ -356,7 +365,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct b=
pf_prog *prog,
>  	for_each_cgroup_storage_type(stype)
>  		pl->storage[stype] =3D storage[stype];
> =20
> -	cgrp->bpf.flags[type] =3D flags;
> +	cgrp->bpf.flags[type] =3D saved_flags;
> =20
>  	err =3D update_effective_progs(cgrp, type);
>  	if (err)
> @@ -522,6 +531,7 @@ int __cgroup_bpf_query(struct cgroup *cgrp, const uni=
on bpf_attr *attr,
>  int cgroup_bpf_prog_attach(const union bpf_attr *attr,
>  			   enum bpf_prog_type ptype, struct bpf_prog *prog)
>  {
> +	struct bpf_prog *replace_prog =3D NULL;
>  	struct cgroup *cgrp;
>  	int ret;
> =20
> @@ -529,8 +539,20 @@ int cgroup_bpf_prog_attach(const union bpf_attr *att=
r,
>  	if (IS_ERR(cgrp))
>  		return PTR_ERR(cgrp);
> =20
> -	ret =3D cgroup_bpf_attach(cgrp, prog, attr->attach_type,
> +	if ((attr->attach_flags & BPF_F_ALLOW_MULTI) &&
> +	    (attr->attach_flags & BPF_F_REPLACE)) {
The patch looks good.  One optional nit for consideration,

Since it is testing BPF_F_REPLACE here already,
how about moving the
"((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI))"
test from __cgroup_bpf_attach() to this function here?
Clear the BPF_F_REPLACE bit before passing to cgroup_bpf_attach().

Then the "saved_flags" logic in cgroup_bpf_attach() can go away.
cgroup_bpf_attach() can work on the "replace_prog" alone.

Acked-by: Martin KaFai Lau <kafai@fb.com>

> +		replace_prog =3D bpf_prog_get_type(attr->replace_bpf_fd, ptype);
> +		if (IS_ERR(replace_prog)) {
> +			cgroup_put(cgrp);
> +			return PTR_ERR(replace_prog);
> +		}
> +	}
> +
> +	ret =3D cgroup_bpf_attach(cgrp, prog, replace_prog, attr->attach_type,
>  				attr->attach_flags);
> +
> +	if (replace_prog)
> +		bpf_prog_put(replace_prog);
>  	cgroup_put(cgrp);
>  	return ret;
>  }
