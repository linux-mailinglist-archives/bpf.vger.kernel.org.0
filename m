Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E7C2A5AF0
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 01:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgKDASb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 19:18:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729641AbgKDARJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Nov 2020 19:17:09 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A40BjIO010067;
        Tue, 3 Nov 2020 16:16:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SbW5NRB8p5xQJMcEjcTCsAtLX1zRDoYfDhihsDSOU+w=;
 b=DVp9otiYrXbf2eTHj5EYA+TcQqO1MagUowdsdDdDo17Dh2AmAD7FrUlXB/b2ibMLzMUt
 hwnFbteasRMN0uCSNYE+5iKx3JQSIMVA7M0W/r7Xjjgg3CYKE73od/h1Pm5fOP9U2VQ8
 fu1s7tDne3nCmpCCURiivEzHnx/MCBebkyE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34jy1c60y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Nov 2020 16:16:52 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 16:16:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma5jXDCTIoHzgKGkTWbca/Cet3EnI0X+jTPyZ2INmlRaM2Hj948u0pzYBfSIH6pPgE0CeSHkW+Uy+OnLuxUQ6ulFMH9VRJIGqtkPjWRvRAN0zemsZ1HLhfWWZ6f5/UoUOJMc6J5xIkZUH98Kb1tw92vnd9wERp3hGliY5MXx6JdYsbQSHN6ETrFxjxI+6F6PZNrbaLaSHWojz/42xEHBiHLNVfh2unr1s+wqIwptRtjG0DA2Lxx2IgUM900HtaLGaRmf9Ek+4bOCGKUr4ojlC/2+Ju3S1GjX4Cwg30fx1X0NVAxyD2Xwd+xFFf/GuFep8tCHFg8mx6hOHLE+AbvBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbW5NRB8p5xQJMcEjcTCsAtLX1zRDoYfDhihsDSOU+w=;
 b=CJUkggYx45g0SxcyhFFbkgn/H6v74ZvrJWVedRE5Hm4eWdpDl4X1eOGqbFSatsn2LZJvNlG2vPCUuNW/i4sDZysMvmhHwSGKCCTuhdD5eRTddk1Ai0fMZU4ho9+CWI8NZEUPHgxi6aswScqwLzIk9BeCQDBvZPTRMpN+5ePPdxX42o4ISWplOndeNVs/YZbl6L6bX9YnOjV0Jro5uAlVD4hh2EQK5lGJSsHnSoMAt+5wRoVUWUN9Qa/VFHyyfuLuqzw989P1Z/GVnbdHJHyeqZVz0GFei72Qna0Ium8B4wo+LP1TEc41kYsDbq6F9e5XEK5W/wJHnTJ80MIrr7wGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbW5NRB8p5xQJMcEjcTCsAtLX1zRDoYfDhihsDSOU+w=;
 b=hGgUAvvAGrttmQrPDK+gS/Sj/sWLMIUsbKEFIm1IHOUq975izVpYT4tjNt6tXWvfz2ZKVS/Zm2hGR6/dkTJunNF79HglRvVS9Htjfs58BiQUY/0uvoChJvY83C43gAQqHZwocPQ2zF6UhsnUcPioTzTDtcwNZIQmkW79bPW1Mvo=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3668.namprd15.prod.outlook.com (2603:10b6:a03:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 00:16:51 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Wed, 4 Nov 2020
 00:16:51 +0000
From:   Song Liu <songliubraving@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v2 6/8] bpf: Update selftests for local_storage
 to use vmlinux.h
Thread-Topic: [PATCH bpf-next v2 6/8] bpf: Update selftests for local_storage
 to use vmlinux.h
Thread-Index: AQHWsfZx/khkesOmHUSghppiSS1jLKm3G6cA
Date:   Wed, 4 Nov 2020 00:16:50 +0000
Message-ID: <BB9CFBA8-8339-4C49-9D8E-6D01B8DBA0FC@fb.com>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-7-kpsingh@chromium.org>
In-Reply-To: <20201103153132.2717326-7-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bac42f73-bfaf-4809-1264-08d88056ed52
x-ms-traffictypediagnostic: BY5PR15MB3668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB36680D6888BEF6BFABB1AEAAB3EF0@BY5PR15MB3668.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBucgY+tdG7Bs57ber+BTCwZzZW25L4Jcy97GBfg6ORe4gTsLLRpLrFMw63gMnBAxzfnJNXykv6Im+1wPZlDHEj0gKrel3FLUHUgqZVK7EFVliL4ijCq/WPRMJiJtkpM/wlK/vvwak8aOLfP05uEiHER8C1lxO1cpdJ/u6rjUT42zd9tPRCkukQiXnnyrpdFSgayUSUyI49m3lQu3WsCzO5fn85Z8/hw/+3sPhyled5xV+D7CUyQ4rAi4GwYh1fp69cj4aVAxbagP6bhMGFa5wrB83sY2w7+rTOU7HeoWiRi6/9NdOLLLnhgwnRXNzbJUZKYtHsdeD42SvBzuGxX3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39850400004)(396003)(366004)(136003)(86362001)(4326008)(83380400001)(8676002)(316002)(8936002)(5660300002)(76116006)(2906002)(478600001)(91956017)(71200400001)(54906003)(53546011)(6512007)(33656002)(6486002)(186003)(66476007)(66946007)(66446008)(64756008)(66556008)(2616005)(36756003)(6506007)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +UGxf7pPzcKmpxc/XXlb572HJ4WJj/ukay1yIjp2OL1hNkeQ1HV3m1K6f+s6AjqJSWDNynymexi1yZtk0wg6jw7JG5B5xAsXJch8I2ainh/96rJH7JXfOAiupHuTJN7ftAAsomTEBeJt6yrSKg9L0ZkIaB36suwdOg1JLkpoWBAviC/aFL44J6qhjGu6BAu+HFleHlygQGKRRfSo/Jn/PL7Y7jAMMrcg67HIu6OOZNPNhrhcbVfdXhf4K6RNmX/SmVmJ5/fNO3r5/lFj7wHDI0mKQid4pq7fPBBk0/UM+3cNRlP6griYJLIQsKQFVO2+60u4/fHc+PKq2vjkOOHk0U7o9gFePgWY1SHL1QDdP1thhk9hVdGyc4vq8i2ZUg8oDvD2yBV5t5x9LsJdePYPPUX++WNMnDAYLmoQMgMO9O07v0Kl4zTdan+GL5WpjKMNI36RBike08UZ8bscJe17X1GBkGdZ28VbyNA3e1Y95oE+O5fBRiFkabTHuk2D28FCcsLnDv04pUoNEeXS0mXrt+gaM98M88RvbVDf8JuQ1GHjtRvEcMYllJpev62FLIAQZl0lm5sivGkNG9IWMJ5KEyBmU7gUEey6fzRlyKtq4sBrRd3Wq9yCxi6s8R7ZeXgS7jeQhFWzBmLr3OtngCYby/wbOWCcU5x8Qt6TJAqky0827gUpy1fCXkFoLRcz9Ocl
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4108002DD3CD014CA182E8A8A837A79E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac42f73-bfaf-4809-1264-08d88056ed52
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 00:16:50.9237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFass9TNHaREgJp9wfnyBM9hiq24CHtrQe89RcI8RMM2sPrMPGi8dXgWtibcFE4tzujEKlO456FWNFhYfNPxMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3668
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_17:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 3, 2020, at 7:31 AM, KP Singh <kpsingh@chromium.org> wrote:
>=20
> From: KP Singh <kpsingh@google.com>
>=20
> With the fixing of BTF pruning of embedded types being fixed, the test
> can be simplified to use vmlinux.h
>=20
> Signed-off-by: KP Singh <kpsingh@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> .../selftests/bpf/progs/local_storage.c       | 20 +------------------
> 1 file changed, 1 insertion(+), 19 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/te=
sting/selftests/bpf/progs/local_storage.c
> index 09529e33be98..ef3822bc7542 100644
> --- a/tools/testing/selftests/bpf/progs/local_storage.c
> +++ b/tools/testing/selftests/bpf/progs/local_storage.c
> @@ -4,9 +4,8 @@
>  * Copyright 2020 Google LLC.
>  */
>=20
> +#include "vmlinux.h"
> #include <errno.h>
> -#include <linux/bpf.h>
> -#include <stdbool.h>
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
>=20
> @@ -36,23 +35,6 @@ struct {
> 	__type(value, struct dummy_storage);
> } sk_storage_map SEC(".maps");
>=20
> -/* TODO Use vmlinux.h once BTF pruning for embedded types is fixed.
> - */
> -struct sock {} __attribute__((preserve_access_index));
> -struct sockaddr {} __attribute__((preserve_access_index));
> -struct socket {
> -	struct sock *sk;
> -} __attribute__((preserve_access_index));
> -
> -struct inode {} __attribute__((preserve_access_index));
> -struct dentry {
> -	struct inode *d_inode;
> -} __attribute__((preserve_access_index));
> -struct file {
> -	struct inode *f_inode;
> -} __attribute__((preserve_access_index));
> -
> -
> SEC("lsm/inode_unlink")
> int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
> {
> --=20
> 2.29.1.341.ge80a0c044ae-goog
>=20

