Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25232A5AC5
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 00:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgKCXuh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 18:50:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57470 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729980AbgKCXuh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Nov 2020 18:50:37 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A3NjPus000307;
        Tue, 3 Nov 2020 15:50:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=o8dtlvx9Uda4O/HWJ5IWsuarcMNdMlOcyoPCxmVO+DM=;
 b=RD/cnoFi9TxJRREkvczK8hUkvodh4OCLSzTjLDc2Ro75B9i5mY49TG5NguPKk3trIKQb
 FQMnaRzOLMBs2wS72GXdMWx5JYb5atns9HW0+4u9O2LhkRcN9V2JLEq3XARGYmBBs6gF
 FqzBFLJfCC+Eyyfh/riXoLZCveipfXkkNU0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 34k9k3b5wf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Nov 2020 15:50:19 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 15:50:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCHNSY8B9q9TcD+kWiFk0xwaw/H702i5JwXcJ2JmETZrdNNq6c0D0T62HnKQNNUU7WevKcpMhbseookQH8rKEnLBSH7DAObVPdN5pcGvk7tu4Jj2ip95ObC5thd3tG4ok74Xqikz8mUeydOh+fza7a0K1LxmJnhw1ExVKczOn0tL76ur1cEv0JjE/OQrZCaCdJlp/QD2Q1IhO8v2O5OkVIEPnO9d2uS5vRXckMiNe2giAF+1RepUMslTp3iEJLuFuUMtFBIsId1XQFfFCs+/hmObfcp5tM7eeuzfFUJFM1H40av6qLeEsiWxYHnn4/B8UfxfaIGe/md1DXyh1wFfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8dtlvx9Uda4O/HWJ5IWsuarcMNdMlOcyoPCxmVO+DM=;
 b=O2cqD9Kn98GI5vjAYjrAtusovHLKzB6Cm3gUJlonSvsJJteB77+D6OGUTnRmrOF/IMnwaBQ0nnxMlzksfu2TJmJYbpL7xNKq0/zKUJLxHmU01KKNTovqLxzJhDK4wlgJnksAYDBP7tRWezxT0+/dMzwRgSYbLqqLivhhPw6dYzHQl4YbCg1pA9gT4W6HEmpDZqD+A8QWJ7itwlE4YYfBS2mnUwreDyeRhPuN9bRgQd2ZCyGzvKMRUCt63EaChjkhsusd8awNQo0/ECBMM+R2QGol0vVwDI6aTEDmQ33u/6rSarnqtgH5HBm3bQi8g9ZQXJcTcSsvyJoHcCrBo6+1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8dtlvx9Uda4O/HWJ5IWsuarcMNdMlOcyoPCxmVO+DM=;
 b=Pl754GIqYe+yakjNkxAfF1shUw0Szar2l6oWMwxKs8VPjRG8edj5RQpYRENGIflrgZv8kA0dnICZ3R6TLEkrVIxCtdR6VUqNC76wR2uVG0ZY1dopL/F/jHyRyB2B9ClpjaIhEtYCZbWHd4CU0000jbGL/KPfX0dEVpklkRYxzFM=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2408.namprd15.prod.outlook.com (2603:10b6:a02:85::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 23:50:17 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 23:50:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v2 3/8] bpftool: Add support for task local
 storage
Thread-Topic: [PATCH bpf-next v2 3/8] bpftool: Add support for task local
 storage
Thread-Index: AQHWsfZ4Nw1Elb1/MES4VzBqzrlwoqm3FDsA
Date:   Tue, 3 Nov 2020 23:50:17 +0000
Message-ID: <583FEE32-93BF-42AB-9EDB-621F5417470C@fb.com>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-4-kpsingh@chromium.org>
In-Reply-To: <20201103153132.2717326-4-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61113745-7e1a-4162-31b0-08d88053375d
x-ms-traffictypediagnostic: BYAPR15MB2408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2408FB18A1CB116EEA58F15AB3110@BYAPR15MB2408.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:103;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JlEWs43VCTWSjMayetVtmUmfB5qgX4ibRBgpz7cNoq6arLPd3w+guWo8iZc9/etRyQv2gi8h61lG7WR8SGPMsBk2jGEuBnSgVhWJ1kij2VwV8Ldrge7jPu85TRtRlDx1j6iNjK04S+1RRPA8TG+F8cW4ZspkVtU2EDRc8YZrDYbYUj7S2oZDUTBtPJ3QJiUZH7daomW1DmQwmK/A/kGRGbZ2PN6HWbuEQUYhG0zj4PAzglMXBXUft1oHA2JTfIBEsfrxbeVwhawcM31p2zS5ZkJWj/bv84ri3LRNx3bbCSx2geFUHnNK6yExzTNej5zP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(396003)(39860400002)(316002)(76116006)(6512007)(36756003)(5660300002)(8676002)(4326008)(71200400001)(54906003)(33656002)(91956017)(6506007)(66556008)(8936002)(64756008)(66946007)(66446008)(6486002)(66476007)(53546011)(478600001)(2906002)(6916009)(83380400001)(86362001)(2616005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FtM8hx+5b3xHirrvdompBKF8hJ4akkMxQz3WgzFwnLCE1+qoNy5XUWgOepLBuRT+MkavHC+QspQItfRYkPZAiAEfp0FIwRbcGoDTBxwFxiOcFjQk0h4WZWMqsH94imVDDTTxHf+qGWaPDPErx3yVQKi8vDIOOlonFoY/PxwPDwv+8IW3jfvZcVCvopwmHSGR54yMS1xYL1B60ovCfR8MPsz/2iALUGmGm/5Tef9Tq6bdnxIirRhsMxGIWaU68IqlO9C0/rxYS91Kd1OtlmXIiuCkNj4MByyDIz/B3kH6V38Bo+yuRLcOoyOeiNrpTPQOXOEdTF63xfLaTg0/WE8YsxAlWx36qwJiWF9/zNCeoRPt+hIVwcQ8kKB1O8qqncBJm5rD612S7Y50a5TU+m1CP5TBwoa5QnMJ1KPErm0anV4M/+Z3RHE9D2dyTXuVG6BqYRI7C+vY0NASIT6WO9y7EW+5Vlm7Pjf4wodn/b9hpoCx6kFEwLGXTMM/JWQleCW+BNCyQ7tVYtRMo3rfmRXR2NL+iarzehB43NC4+oMGTe15OtGvdg+Jy/P5xZXe4hd5F9ZdBHE69ik3HMGJ0U2vOBFohdlXNpXjfYACPD79U4s9o0x/CjO1jBJGmfqEn+K60zdJI5QPjXABMDIS8Z8RKiBlN/isdLh5PhiGwpR/HMPljfYak1yqVIKH8hyUI5p6
Content-Type: text/plain; charset="us-ascii"
Content-ID: <191BFA141698134FA0A5B8603DB4429A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61113745-7e1a-4162-31b0-08d88053375d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 23:50:17.1111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSoXZT4Y84BJsh8wjGvbVUwrL7bg7lQgEB17fMLxaz50RzpA2Qb0e80dn7Ts8ootsW2ZIdH/O/M6ChQvmaCDLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2408
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_17:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030157
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 3, 2020, at 7:31 AM, KP Singh <kpsingh@chromium.org> wrote:
>=20
> From: KP Singh <kpsingh@google.com>
>=20
> Signed-off-by: KP Singh <kpsingh@google.com>

LGTM, except that commit log is missing (also for 2/8).=20

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> tools/bpf/bpftool/Documentation/bpftool-map.rst | 3 ++-
> tools/bpf/bpftool/bash-completion/bpftool       | 2 +-
> tools/bpf/bpftool/map.c                         | 4 +++-
> 3 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/=
bpftool/Documentation/bpftool-map.rst
> index dade10cdf295..3d52256ba75f 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -50,7 +50,8 @@ MAP COMMANDS
> |		| **lru_percpu_hash** | **lpm_trie** | **array_of_maps** | **hash_of_m=
aps**
> |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap**=
 | **sockhash**
> |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_stora=
ge**
> -|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf=
** | **inode_storage** }
> +|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf=
** | **inode_storage**
> +		| **task_storage** }
>=20
> DESCRIPTION
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftoo=
l/bash-completion/bpftool
> index 3f1da30c4da6..fdffbc64c65c 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -705,7 +705,7 @@ _bpftool()
>                                 hash_of_maps devmap devmap_hash sockmap c=
pumap \
>                                 xskmap sockhash cgroup_storage reuseport_=
sockarray \
>                                 percpu_cgroup_storage queue stack sk_stor=
age \
> -                                struct_ops inode_storage' -- \
> +                                struct_ops inode_storage task_storage' -=
- \
>                                                    "$cur" ) )
>                             return 0
>                             ;;
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index a7efbd84fbcc..b400364ee054 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -51,6 +51,7 @@ const char * const map_type_name[] =3D {
> 	[BPF_MAP_TYPE_STRUCT_OPS]		=3D "struct_ops",
> 	[BPF_MAP_TYPE_RINGBUF]			=3D "ringbuf",
> 	[BPF_MAP_TYPE_INODE_STORAGE]		=3D "inode_storage",
> +	[BPF_MAP_TYPE_TASK_STORAGE]		=3D "task_storage",
> };
>=20
> const size_t map_type_name_size =3D ARRAY_SIZE(map_type_name);
> @@ -1464,7 +1465,8 @@ static int do_help(int argc, char **argv)
> 		"                 lru_percpu_hash | lpm_trie | array_of_maps | hash_of_=
maps |\n"
> 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | so=
ckhash |\n"
> 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_=
storage |\n"
> -		"                 queue | stack | sk_storage | struct_ops | ringbuf | =
inode_storage }\n"
> +		"                 queue | stack | sk_storage | struct_ops | ringbuf | =
inode_storage |\n"
> +		"		  task_storage }\n"
> 		"       " HELP_SPEC_OPTIONS "\n"
> 		"",
> 		bin_name, argv[-2]);
> --=20
> 2.29.1.341.ge80a0c044ae-goog
>=20

