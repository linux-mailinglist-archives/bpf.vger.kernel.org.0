Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4EE362610
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbhDPQye (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 12:54:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38756 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236427AbhDPQye (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 12:54:34 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13GGqENN005868;
        Fri, 16 Apr 2021 09:53:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=p66zOUkaboUbrtBAo0Zj1vHiewbE+6VciXeje4duF4M=;
 b=UQDt/k6LpAdanEDJxJHoYly/rhuXbbSQlt4i+Yq7h0eKlVFAoOIQAmFyMbmxgsxsr339
 ttRvHBj2UnF3mR+NpNUWIXX1zhal/Hdtwx2ov3T/zwngL5Z/nh93q72fY1nFSqJqR0PM
 0TcaITlrgms76kc79TSdAd8pjCN1l2jwtYE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37wvnyf5nf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 09:53:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 09:53:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODfAvm3YJg32GpaNvIEv4rcUBuQdq064dqucFA13nNe3OIEp8Pzft2nAFGX8x+ZV9ej/zAS1Dj6MEytUQpamo2oCMYSQh/xThYSU2QYGt2ltrZzRCIIeTFeICQb3lazcS0ndImRieYSX9AZu1IpkkxG9s+HhLLsshuVYPhVxwAZZLAGo0aKeMsKQI5E1Bvhega3tHofOmrxcZHoKGF0ZkiODiF3BDC0o5tzVpHac62bP3aYzeBjAEYnqcJJu0EYKqESTgLLOAIfx9IHeO/FHNuiBoIq1jrWU7y/J9YWCFmHUKByc5mFY+R8GgfF8eY8X7EjfpUngL5p0t4HKopCmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p66zOUkaboUbrtBAo0Zj1vHiewbE+6VciXeje4duF4M=;
 b=dPmncoFCY3CzS6+X+e3Y5QggIYr0osal3dvAjopqQcNgP674aFvNMZ47dnxXuvVMI648GBaMBONXxtx6+ihv3gEveNfsVW2v/GAkVADaGTYI0vz5NszSv6R9Z3/EkbufHIagZGkDD/ppL0Fa8PH2x4dBDxmBablvZePDpNKYNHaWX7bk92LHn4NNNMj/62i4bj2OFul/9ShMYiiiX0Ae40q1OT4YB1iPJqUSRCswiUAH+cfxg9Y+x9F6wsklzjrnPJdJvJGb4rcdzc/AWKApT2WS+zc+02z+YK2lMNOM5BSK4EmrWqo9ncM7f2xVtMNiEn27dKFdcLyYENH3ECkCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3189.namprd15.prod.outlook.com (2603:10b6:a03:103::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 16:53:53 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.040; Fri, 16 Apr 2021
 16:53:53 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: refine retval for bpf_get_task_stack
 helper
Thread-Topic: [PATCH bpf-next 1/3] bpf: refine retval for bpf_get_task_stack
 helper
Thread-Index: AQHXMmwUAtjnkhet7kS+x9qUpCFMbqq3XU+A
Date:   Fri, 16 Apr 2021 16:53:53 +0000
Message-ID: <EDB79C86-794D-4293-B372-3FE5A4E19B61@fb.com>
References: <20210416025537.2352753-1-davemarchevsky@fb.com>
 <20210416025537.2352753-2-davemarchevsky@fb.com>
In-Reply-To: <20210416025537.2352753-2-davemarchevsky@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
x-originating-ip: [2620:10d:c090:400::5:8797]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb899024-95d2-4873-1bfd-08d900f8378d
x-ms-traffictypediagnostic: BYAPR15MB3189:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB31896FC5EAE662E87E5B6154B34C9@BYAPR15MB3189.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yta10YJYYrFgMABfFK1dK4AfisIxr7xo1G8sKDuhHqPjJUaQEO8g+4G2StPvMyeLnK7ZTUNaTBrwe/2Rv7agzeLT+qw0/KAClE6ZOmSqbC6TCwsayHWBPnxZt6pd8bzVMyXDo2jG64LuwB7kPqHdOlw+AoScIuvx0+nN0xH7lG5pu8OnyM/TqQ5ZYv3UJhkJAwWdCtpsJS9H1ZJdOtomHUjlu+LdrznoLHvPRF9KBoSV0r36K9XKYe97SO/fITskBXl322via2T6ZS3wFGYyM0og7z37I18XE9RwtJU9OY674P+zMt4qGsmK5LD/7dhRibCK4ksjPkw0fvZ6Ii2eItHhuxLY1A3H5MVjz/Fy/uMkLdZtBrYoy4frrYIQL+ljCsIm/NmoyoHzR1WKwRpx4z2LIgJ+sruwaYV3EJoxsXeUHAn9f78Po67H4Uf2g7BknUWWzgF9IeOdDIlwAP9M0rRZV3JbHm/+bBoo8MQh10nmqq0zFzyRZ5Yo26OPF3aYyn+6MCsYuq88Iq1STCc3LNU3GAb9V7ZJnYizpTSvXM1y9ppoSAqCVVxLEPnJ1uq2Gs/OfiguD8BBOTmJkswNO9UJxTr/2G9uzUfQgN7Ub8dWvAQPw5piXLykNStc3EhCirNi12d84Hqz5BSypFuMceheumBJv1UkVm4fYXbVSrk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(366004)(122000001)(38100700002)(53546011)(91956017)(66446008)(6636002)(33656002)(86362001)(478600001)(186003)(6512007)(71200400001)(64756008)(4326008)(5660300002)(66556008)(8676002)(66476007)(2616005)(36756003)(66946007)(6506007)(76116006)(2906002)(8936002)(316002)(37006003)(6862004)(4744005)(54906003)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?km+bSxFqtRbmnTeeU6LZWfpZkwMO6HvhtZ/g7HzUmIXIb2wltZpUxHNnucN3?=
 =?us-ascii?Q?YFTDnlmcgGweVbLPnGRmNxm0WbiTk3afi3aYCYX4bS2uPMXxQlH8xx6BXbCv?=
 =?us-ascii?Q?eCcecaka0sLB5BWwPUUpP4Sf944XPED2BdYayhE1OhOs84hLsFdKwp66Z7bC?=
 =?us-ascii?Q?T3JzVMgI287FAvZ2+TRYRSNFpDt8/IjZjRbXzE26uuT/pOe8fb6ejJlfaUeX?=
 =?us-ascii?Q?kA23p5alQA8RGq58i+qCR3hyD8SuGFQLPnsoX+tCgcGc9Q/J3l+v/2RdLBa9?=
 =?us-ascii?Q?j7+pRU1KqDQmlbD5idmKXQETlQW70JTh+TXUU91oYmNGcFtKYHdVBcea2ywn?=
 =?us-ascii?Q?VVia5/lxuiiyBu86PGdlaDvtfpedmhp4Tbr3GK69MPm5YWdZU5JK7sSOVLIh?=
 =?us-ascii?Q?LWoXse3zFQs9GTXGkLWjd89NGvz7buZu+yRZipKPt6t0JdbNd2vXZOHD1PM4?=
 =?us-ascii?Q?yNjqQeH95LxgDy1voQITpUAAYI+6x1HBspJzRES/XhIdR1ckEUlYFlIkLs/n?=
 =?us-ascii?Q?/WzXT8ymKsGm1HjzXpCiLjDFGKwtZnd8TiYRiSNnRTMDhqCdzmITnr72Q1DX?=
 =?us-ascii?Q?CX0eLNKkMMfQVJKlq4pAaiuw5V5VrcyYOlCVp2l3N10XmQNXg1T1aXVea5WS?=
 =?us-ascii?Q?3woSFdkMEwSZGJOUlR+hd356ZjuWhj7Skw6BQj0WNmfUlTB6ZPSVWpoFgm+Y?=
 =?us-ascii?Q?vL5/YUx5BCjJiN5EPIe1N06tNuF64Kgk0R2H+7Qda7D/ROjzT5QNDSZp3/eS?=
 =?us-ascii?Q?94fXh2KFFMIqgl3UB1gfpxRH29L2/DfJfm0DSrK3D2J9EjvjQO6wPqlRBvhm?=
 =?us-ascii?Q?JA6Nlnb2tFi+H8tD5EDgTAAAiEg80kF53hD47075HT+kvEUUltSnP53zlU2w?=
 =?us-ascii?Q?GW0Mzxys0slhq6CSO9B1vvfrolI/7XdBj96xxUh/f7yjJG+N5wQHfKr4iE7E?=
 =?us-ascii?Q?/+c5uxcuux8LYz4bUivXYKYHJyfV4gQKbNu+wdlxEJxnRL1N567r6gjVjCSf?=
 =?us-ascii?Q?ZiRUjH1k0QV/moE0N6k+d8SHxOg0nBP17L5nF/Z2zO7l/D/TK04ctGM+yj3l?=
 =?us-ascii?Q?FpLInfo3hk0y8RqwaPIIUHqNNArSVM+TCNxlZIMqwCEdvO6lXlfH74XKLXDa?=
 =?us-ascii?Q?5khK7k/rehIKcsFsNMBZ3RA5XZKpBzTHHTGbBxrP7AxhEIpFpsmMpwoSyw1H?=
 =?us-ascii?Q?sklnAGEnyWhDWiJl9FkGtjsmstBUgmFzdZycmWA7Kg7Ss4sUP+y9MBQub9MQ?=
 =?us-ascii?Q?Ro7GMJz6RVIzTxHWzS6skRtpCSLu5mxIiLTEOTw+yeoAVjevUyl4rBmiriDg?=
 =?us-ascii?Q?Anyy/QX6dsD61BjlinQi8U//XPYmLxwKBWr5WKMjTr9uVgzlqgECV4Ejt5n+?=
 =?us-ascii?Q?baNtbEg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1DA4416993D0C34C8AC298C60C6404FF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb899024-95d2-4873-1bfd-08d900f8378d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 16:53:53.2200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZrpyB+9NG1vUejlfeNzNUm7KGxfuXS/TbK9e6nisns/Ol1xkFmFx40dXKnmXzXnmjd84MDxo0/3zReS8xxiUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3189
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 4k69OKbhJZ1sUfd6vD9-qYW6-IwSBEAW
X-Proofpoint-GUID: 4k69OKbhJZ1sUfd6vD9-qYW6-IwSBEAW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_08:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 15, 2021, at 7:55 PM, Dave Marchevsky <davemarchevsky@fb.com> wrot=
e:
>=20
> Verifier can constrain the min/max bounds of bpf_get_task_stack's return
> value more tightly than the default tnum_unknown. Like bpf_get_stack,
> return value is num bytes written into a caller-supplied buf, or error,
> so do_refine_retval_range will work.
>=20
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> kernel/bpf/verifier.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 852541a435ef..348e97f77003 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5767,6 +5767,7 @@ static void do_refine_retval_range(struct bpf_reg_s=
tate *regs, int ret_type,
>=20
> 	if (ret_type !=3D RET_INTEGER ||
> 	    (func_id !=3D BPF_FUNC_get_stack &&
> +	     func_id !=3D BPF_FUNC_get_task_stack &&
> 	     func_id !=3D BPF_FUNC_probe_read_str &&
> 	     func_id !=3D BPF_FUNC_probe_read_kernel_str &&
> 	     func_id !=3D BPF_FUNC_probe_read_user_str))
> --=20
> 2.30.2
>=20

