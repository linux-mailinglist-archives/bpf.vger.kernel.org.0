Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31462A5AF4
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 01:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgKDAQs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 19:16:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62792 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729189AbgKDAQ3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Nov 2020 19:16:29 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A409mUI021715;
        Tue, 3 Nov 2020 16:16:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=veT8MI+8efOCwQlqNFrfqzeu7yq8IKP4YK+lQDCiqK0=;
 b=Q1lQXRu40+xX5LOO0uadpoPfDWG5/wsaJ62e2rzcBO9KacuFrYVFSjvZjJb+13duW/F0
 XmNmMM+Kqi8rju9FPqIJ+RlQWNH5G1cSm4Qrlljo2Vuc7FO0ZH65tVtbWFlZ+a23IltX
 9FGPEEgDqydtmSszKFuHvCUie4GNvB0fU3I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 34k9k3b92w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Nov 2020 16:16:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 16:16:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHuQYZ+t5PKrdzVLa3lcanwwpDTn5OKWPjRkypcX3K6IkoOLc8mV/klFaRrOKZL+WtjnLd/YIA+sH6UqCZBAHtIXi32zEsFybDIEnrdi6lcfHM8VFz/CVclztQ80iPlq6cCNJ7TvI+pme54HEWFMtoCyemIL0uZVFbRQeUSyEmsjy9DOC2z3ilGMW9OIu+CKBVBN6aPdeF6Jwgy7htTXs/d9fRdinDhRDvUcVdxcpgBoQZTD2exuJbBv3p68UC6jyEFTv4qLcT3jswtknAoPnANULpkHdT+PHQwl/5UbPQ1xYNBi87RUD6XIHKnsblUFu0hjY00drTcEFSYdZ/G2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veT8MI+8efOCwQlqNFrfqzeu7yq8IKP4YK+lQDCiqK0=;
 b=NINKb+1EtaBMFId6tF67HanIs21NZe8UvgN0mghXYqlfezo5OuZPnF9LU6WpAzisy6aQzPmjUfYfMXFgX1cwsPNSJlBJmSU4A8Ge7une4X12SXdob8QLNPXFPfAmR+DZm7eFiNMnEhr7eAHs4LhCrf7sYKkzBFQKcFBkDXDUb0OsjTiPKplFfMHEh5JRANiXjW0eJTS5pgNYc5dhz25zLt4TKhYGU1kp+jYyUSJPtmRaPiXuSlooUTiOhrduC/4yp6E5YoqbG2MN8bqvWxFBvJrcdoCh/tBLfl06QhRBH4WfJWlsTlWXWCG5f0T4oyueUDegnvF5PTvWOsMdA49hbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veT8MI+8efOCwQlqNFrfqzeu7yq8IKP4YK+lQDCiqK0=;
 b=UseAhyvHHMrXTmUH3gjklSFZPAgw1zAyCZLGIoVu1Zb3jsRZ3CQVK8BqEgam/KgkW+E3UU0oIkDpuvTNiU8sURvcPPkhh30iViAIHVXoQn79/TtwWS9pv6w5VQ5EAXB4eVPjJGng8rgWfxxqcyedRLJdp7NTASD7BemfLqNsXFk=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3668.namprd15.prod.outlook.com (2603:10b6:a03:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 00:16:09 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Wed, 4 Nov 2020
 00:16:09 +0000
From:   Song Liu <songliubraving@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v2 5/8] bpf: Fix tests for local_storage
Thread-Topic: [PATCH bpf-next v2 5/8] bpf: Fix tests for local_storage
Thread-Index: AQHWsfZ082vaN8mf0ECvThQ8GY66Gqm3G3UA
Date:   Wed, 4 Nov 2020 00:16:09 +0000
Message-ID: <565276E0-C7AB-4C8B-B82B-DF2720B8B350@fb.com>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-6-kpsingh@chromium.org>
In-Reply-To: <20201103153132.2717326-6-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8f62376-f8a5-4784-9c53-08d88056d4c8
x-ms-traffictypediagnostic: BY5PR15MB3668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB36688C530D73250F92A8438EB3EF0@BY5PR15MB3668.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Owz8O+yJGEGR4BYFhS8jPVMycD6u8Fwaz0+ztprGrysf+LHo/gN4R8ByAYA2nT28HdWz435yQp2zXjxYf7Jm+PMK5Wyow08p8coxZ1X7itAYHbngSNjZHLjNrcfrMiHnKE/QzyjZ4u39wEiIjEZU3wXgbwKnkkNkCXv8Z7IR3/njon9uo8aIp6LKjnH96H7vZAWFj4Zgs7WHKQcnIm5DJQbqrfQTbTMURDgz4AA+Reh0msehV/sSTEPNsv/rDdI6P+aQiTm2+CQ9m41M/bDe/LFtRS+9xfNzuXe607cbnFcavmuXdjqjl1tboadAYEitsw3iaI4mREENRNlbIKRQZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39850400004)(396003)(366004)(136003)(86362001)(4326008)(83380400001)(8676002)(316002)(8936002)(5660300002)(76116006)(2906002)(478600001)(91956017)(71200400001)(4744005)(54906003)(53546011)(6512007)(33656002)(6486002)(186003)(66476007)(66946007)(66446008)(64756008)(66556008)(2616005)(36756003)(6506007)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 58o+NhZ160TxO/+998lD+Pe3MkWa7XUAxh1covMJEawFrVaVbrFZQ4mdBRtzXNa6BPVSKShc6eTyIX9h+r1WOwLJeMxZZqNxPLaUHaKkHjYXjnFy/SIFJQSxEUkYGe9Ph4VPr1uh1uhHjweZ0ntAYZDsVYXVCQ1q7OWlHTlpSU1TXlTjkwhlxE0N6aZtH3OXkqT9BpUyOEoWHaf1tDZ0ItUmvqGxthKNLX+qwi7L9RHBaiW/dSCfvxbjbIYlItPL/q3FZh6zSs/lB3omxha8LeXb+mMahyraXLre/B4v5kVfEFcwOVCHQJaw3ou1ZLspyyywcaE8dThhRoB9BjEITp8g75WoLMK1iN/GTsZ9S0bJCj8hQhyNX1DpRKLmmbx6OTr2b5jkJVyvnfudkfyad6OtkajX7/y14GY7XCA5UcKJXoqb69R+EZkSv520PjwkwRTAwyK63Pp17Xz26W2F3jFqVhqGuEoWws6WAEMaNiokYWOnmNlbJAPotUMEByIhrxhLLRg7mZySVb7E8VmP8+7LiEnbZ6oEcXL3ZotM31rBKCLE9XF31KI/y2epicAAa/h24KqdLSrJMxbBvuGtVVaHBnDv3Ixyl+9c7rdlE2sA9XNpgA3e2BYQ01HCsU0tVAJ2Mzlm7Hj+wBUx4/0cEVXjVeR9h0ghpJL0/wltmtru+FBhJy/MzFKoFzuHFGti
Content-Type: text/plain; charset="us-ascii"
Content-ID: <195B982E3CFC254396E577217AC1C3D4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f62376-f8a5-4784-9c53-08d88056d4c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 00:16:09.7435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vlx5k3ezbMTQJzI3/yREADYNeg1BIl1xqa9+yqab096i4b9L0jvJTSK3gG5P0r22j3NtpBJrwNExl0mtvzTcbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3668
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_17:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=809 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 3, 2020, at 7:31 AM, KP Singh <kpsingh@chromium.org> wrote:
>=20
> From: KP Singh <kpsingh@google.com>
>=20
> The {inode,sk}_storage_result checking if the correct value was retrieved
> was being clobbered unconditionally by the return value of the
> bpf_{inode,sk}_storage_delete call.
>=20
> Also, consistently use the newly added BPF_LOCAL_STORAGE_GET_F_CREATE
> flag.
>=20
> Fixes: cd324d7abb3d ("bpf: Add selftests for local_storage")
> Signed-off-by: KP Singh <kpsingh@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

[...]

