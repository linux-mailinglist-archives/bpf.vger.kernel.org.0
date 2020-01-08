Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D59A134802
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgAHQcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 11:32:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55254 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726922AbgAHQcH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Jan 2020 11:32:07 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 008GRnxd032336;
        Wed, 8 Jan 2020 08:31:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=slkMj87y2NDx7gVqSRyK68P49rr09+hrk5USFMqLyG0=;
 b=VZ5RLoWnt2yueZzApbXP0WjL1oUCUl1pv9hfvLoWa7gyU+PSie/rv1vffnOoH70n86gq
 9LzunMK2jC3oh0T4kDYp0hpA3uIL1benlh/uaFtNGIlqd0iTGYxyOy21kDOrZ6oHqTxN
 igjP5ujtuE7j7DXb6EWee4MKxGNTk6DysV8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 2xd2264r1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Jan 2020 08:31:54 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 8 Jan 2020 08:31:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcpU2psit7OWWUHjQb3XIHmQ97VubI3/fx+O8S7LkYJF4VBJbUK4t/VkO2JZMjKb4SgyO5ALT29bn/CQJ1SnPV87hopC5Vg3PB4AL5LLbmxdfO/GMQwUgduLhDmyWhUtZlpcrW+uBo5bgCdtNAzjmyugTCNpKIDR+ux+h1KPtr/98YmHaE1whB/jL3HZp1M0zwqExpuzKOn+ekfzr0cwJcDRUPEZ/lGpfr7r0yqd5jojtw9Dm0/gfs2L6IXR18vrnUjDLFg9xte4UcaFvzDsv5ah880BTSk/8FBTYPnYZ0vZclJauusmlnre3iJ3PYPR2538lV0KeVAWolQtKaEjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slkMj87y2NDx7gVqSRyK68P49rr09+hrk5USFMqLyG0=;
 b=i05/Dx7T7TLeA+XS0R+Baf3J4qHMCqhjHlUvcbC1EGmtSndTnESykGLXen6PsMPbaRJjm5fytO28zbmkdFVL7YVALbYa9pTryfFLkt+PH5G7JcbpcRyZGnysyPzFTP22LMb/Y/nHmh65IDLO2mpFwgejmY9TYcST5TgeEH+wWH8HmlGbeguapmwIM0az8qcscabt7y09SVXZfajPwy/P1e4s77xrG5IHGL9jRFXz71B+fZ87j5d8oG4GOem0J17poiKkeyp7SjlGB9GqxY8epPBSld0CyY0GOyU/2+Z7yD/b32vGQlaK3Eg4FqgyRBQl8qv8L+jhdK+OsGrz2INb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slkMj87y2NDx7gVqSRyK68P49rr09+hrk5USFMqLyG0=;
 b=WYAew1Q3ZgXQ6HcR7LiRrLwe0tJqcWFty2n2/n1GoHN79jJQ4o1m6xvcBgVwvp+s7NeqxomtTkcAGBAaLvn3yAqHygrAA2UwIoqpBZtBuauMiRfQJV7N8cGzFVAeCFtXi95Gqr6TX9cWa+TT4XAAHy/VTGB4WvtGVu0zOmjisGM=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB2358.namprd15.prod.outlook.com (52.135.198.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 8 Jan 2020 16:31:38 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 16:31:37 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrey Ignatov <rdna@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Document BPF_F_QUERY_EFFECTIVE flag
Thread-Topic: [PATCH bpf-next] bpf: Document BPF_F_QUERY_EFFECTIVE flag
Thread-Index: AQHVxcSdqfUsYq59i0+CXBFjYohrP6fg9p0A
Date:   Wed, 8 Jan 2020 16:31:37 +0000
Message-ID: <67C42A60-A9C3-4B3D-9F27-C38827EDA73B@fb.com>
References: <20200108014006.938363-1-rdna@fb.com>
In-Reply-To: <20200108014006.938363-1-rdna@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:180::c159]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6db4a0b0-86c9-4805-d0b8-08d794583bde
x-ms-traffictypediagnostic: BYAPR15MB2358:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB23584EECC70A5BDD6A50C877B33E0@BYAPR15MB2358.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(2616005)(478600001)(66946007)(33656002)(6636002)(76116006)(5660300002)(8676002)(36756003)(316002)(6486002)(66476007)(6862004)(86362001)(6506007)(37006003)(186003)(2906002)(8936002)(71200400001)(66556008)(66446008)(54906003)(6512007)(64756008)(81156014)(53546011)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2358;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5AJgGT6X3hDTFtsozZymnxXz1bj9osar5A3SGxBh3K9ZrFtL+nQruT3lL1bXmUE3g5oqltiHyUcKL3zNAU4HZSjgrw5/NP6cjs6GXopg/S00WBPgQGIF13cqnGHvN3s+XEWCR1EpkfbG4mWAfbmD2twcBTaCfMjV8+Eg2hvak9XSPzKY9MmLrEWQHQj2CWt4vp75uCcG80GOGi5gn7qfSxLQUSW6XAqHcso899okhsqiwYNI7cATr1xCILV9W7jPdFQFih+vN2/lFxcAxJTNSEicwcwfj6t2Ai06AIGIkRFRLRc/TDyz13qR4zz1LRSNUT4PHRWfk6ajVs8Tej8Hhcc0wZ7blZWac5QeU2tFM3iseiK+5TkJ1JN4XcxT6BkGCXzTyKJXR0ZRqPhc2Ny4FZtftanxsNa/YcCJgsMD8owh6nnmwSDasb/yvJe6rWrM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E776C7EB2C551147B210F30735EEE12E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db4a0b0-86c9-4805-d0b8-08d794583bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 16:31:37.6316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27KEkcYN8wpkL9R96PRZeDf4fNos/A+yp3aVsHILLwPI8IxYExqxAi8XYM/99+/AgGnpVEGXMzIIkClLpeDITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2358
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_04:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=651 suspectscore=0 bulkscore=0 clxscore=1011
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080135
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jan 7, 2020, at 5:40 PM, Andrey Ignatov <rdna@fb.com> wrote:
>=20
> Document BPF_F_QUERY_EFFECTIVE flag, mostly to clarify how it affects
> attach_flags what may not be obvious and what may lead to confision.
>=20
> Specifically attach_flags is returned only for target_fd but if programs
> are inherited from an ancestor cgroup then returned attach_flags for
> current cgroup may be confusing. For example, two effective programs of
> same attach_type can be returned but w/o BPF_F_ALLOW_MULTI in
> attach_flags.
>=20
> Simple repro:
>  # bpftool c s /sys/fs/cgroup/path/to/task
>  ID       AttachType      AttachFlags     Name
>  # bpftool c s /sys/fs/cgroup/path/to/task effective
>  ID       AttachType      AttachFlags     Name
>  95043    ingress                         tw_ipt_ingress
>  95048    ingress                         tw_ingress
>=20
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

With some nit below.=20

> ---
> include/uapi/linux/bpf.h       | 7 ++++++-
> tools/include/uapi/linux/bpf.h | 7 ++++++-
> 2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 7df436da542d..dc4b8a2d2a86 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -357,7 +357,12 @@ enum bpf_attach_type {
> /* Enable memory-mapping BPF map */
> #define BPF_F_MMAPABLE		(1U << 10)
>=20
> -/* flags for BPF_PROG_QUERY */
> +/* Flags for BPF_PROG_QUERY. */
> +
> +/* Query effective (directly attached + inherited from ancestor cgroups)
> + * programs that will be executed for events within a cgroup.
> + * attach_flags with this flag are returned only for directly attached p=
rograms.

This line is more than 75 byte long, I guess ./scripts/checkpatch.pl would
complain about it?

Thanks,
Song=
