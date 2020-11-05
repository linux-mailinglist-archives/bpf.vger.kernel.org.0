Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE552A8AC8
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 00:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgKEXcA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 18:32:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27476 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgKEXcA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 18:32:00 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5NU8Wl009926;
        Thu, 5 Nov 2020 15:31:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ugVAzyJCqI/sOxs9O4+p+LQxiIm+RG8kcv27g8c6m7A=;
 b=OvTqSmKefv19Kv9RYTemPkLNd2t4aUjd3d3xVBttWJanbbb3SO7gF4yxLPNl5V8uo4dd
 fZuDXKNBsiNOHLglOZ8a0WMToT2J4elciMACFsOtBq9cAwCzw24mWYsxV3sT+EG6+St1
 V5me3ya14qjDFkMPqkvShbM2sZnhwEsLEus= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34kf5cd5td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 15:31:41 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 15:31:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZymxPNXyAINMxzK8FzprJwEA3LZP1u5Wyn2tXtumS1mbHTyJWxyMgv/BKk53IcxY6i9OoRiTxvJPo5ZeAx70ANI1ZlDbTBPdvGxcSWbHWw578EFWY3+iqI1m3HwkYEdB4BiKwy/w/xghH3d2JwkqhtZ2Zb+RLn2veZP2MacSqcsaD6aCC6Fu1zuZwttNTre97NqLXQ+LtZrrKNhIaFJS4oxDFgHUytZgi3yBVGFmxtm0TzOimgWxq4jkG0fBCqlPgA0xDoz7ttvHInA5iAe5rZpgEoRBGXZIxutsJ8O/R7adICcb+N7xxMxYTNFdjiOGMnWksi6TRYKcpga2GtYuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugVAzyJCqI/sOxs9O4+p+LQxiIm+RG8kcv27g8c6m7A=;
 b=CKJQjNQ1GzQ0XdMS5jOzh1Gnqyr/AK7YBQueTFKX0WxSfH0snbbHJoeLDALjdKlC9PWzDh03PdD6PbbBwiIbV3Ln3dEPjPyeWFnqDwHnxFnN8V9GwbpozPZYXGAl0bkS56DOZShbQ5ONeny0DkCQHpfsl07Y5ODQfEplVdAMuNpswZppPuunRKnE/QFF+AwZ8/pe27ser+GrQ3ntahJ91uXcOle0gokRzOHFMG//EUsXaBBEMuPWjWzDJ/a98PwozfrJNzEFWtESLZnDN6VSlHVj+6uToAYXdI86fKf5ryiT03udqP+U2E6OVQIs+xI7M0b1hLB5oKmRGl0zb8JHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugVAzyJCqI/sOxs9O4+p+LQxiIm+RG8kcv27g8c6m7A=;
 b=RxgZeOOAeJvoQyWg4tUr+PRGOB+xvIC64J2bhTkaPjP8EGCoJgLiv0Qz+jO7HCiwL5zB3irIzpDq8eBZpkS1p9sCDuZ5prPnGDxywBOkjrGlW5/W6EoLRL2G1slE/ESh5m1EDx8+jdRd3hFpn8DC37A/vSMlOUQy7uWZZHEg2vY=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2695.namprd15.prod.outlook.com (2603:10b6:a03:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 5 Nov
 2020 23:31:38 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Thu, 5 Nov 2020
 23:31:38 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf v2 2/2] selftest/bpf: Test bpf_probe_read_user_str()
 strips trailing bytes after NUL
Thread-Topic: [PATCH bpf v2 2/2] selftest/bpf: Test bpf_probe_read_user_str()
 strips trailing bytes after NUL
Thread-Index: AQHWsxsKExRyW1CBMkWOL7EY14SiVKm6ECwAgAAesgCAAAKHgA==
Date:   Thu, 5 Nov 2020 23:31:38 +0000
Message-ID: <32285B9E-976A-4357-8C97-6A394926BDFE@fb.com>
References: <C6VPSZATLVIX.2PK5DDNA9QVDD@maharaja>
In-Reply-To: <C6VPSZATLVIX.2PK5DDNA9QVDD@maharaja>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: dxuuu.xyz; dkim=none (message not signed)
 header.d=none;dxuuu.xyz; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a8600ca-ae60-42bd-9a9c-08d881e2f156
x-ms-traffictypediagnostic: BYAPR15MB2695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2695141BF9A883BE912D5BD4B3EE0@BYAPR15MB2695.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rbpztSLItffFPwNbfKskw9b5MJRM4E/dVeLOh9dUoJR/m1n1KcfY4cFQt8KxHEwErBg9GZ1FZBe7QMWotz/wr2zeSOKTlMNi6RLcpEJGOFJ3DoNzDMwktWFxuTKv46uRRASKzpqXDo2ZSutKG2uEaMXRCeH1TiGqBFwof5cbzi6GaofBCyucWteR8JGLpMQAYs1nXfOYO2ZKW3u1gnzT6NkHRaBjwnEvGQp04P+8NMW7r4iyiLOcDxy6ekS/keaJ5NJeqwA0fFSVm1Lu74s99uNswg+3w3yVtT+cOYYLgGIQ47ZxdJ6pE9C7wG33iAi7kXir2C0SJ2pWgcDfqvKkBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(396003)(39860400002)(66946007)(91956017)(6486002)(6512007)(66556008)(66446008)(316002)(66476007)(76116006)(33656002)(54906003)(186003)(6916009)(2616005)(64756008)(8676002)(36756003)(8936002)(4326008)(71200400001)(5660300002)(2906002)(6506007)(86362001)(53546011)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PZNI6cERDl8UTOfWOKNecY9Us3iRKIfIFUjSugjNhsMA8eP0f2iZGuWJ12/EhIyCbyjJyVLYNi8T9NyaF6Gmr12mEJvcdy5cYJuwXTPNr63eUe1fMaVjAv6P0/lf2m+C7P01WImbqSwZUTuUca8druX+jjUM756ZeaY+q9eQSfw3h6IUBdJ5HvWKRFX27UnbxMDY+Z2LKKDt3QpyooQ1tBaLfmWU73389NzrLwvXcd5cUza61bg0VNiVve2nSnmjZFJhs3xL1idKTsfZxyT+VuzTRaWXK1UdaT+s2Vnt2p14fGcn3jHaSiX3c3rdRrr59sN/8Q8uqzkq7MQRzu2GknDbO0Vhbvyoub5LSEQ8o+MJGD9TDNQYILSg/kSmUWTIuYDUoCLqxUITzsnn6bwjhi21A6X3f97/HAiAvcmIM2sUeR8jeFVEe6bmToi5jCGAtNy24G2GVRVoTO62/fxYXwm+PcPSR8jZ2AMa+k8G/Sh397RrPvDRlHfEp2Lr8Tr0F0LzSKU4DPXZvT1Uzx64poU8cPD2q4NDGu+L2rTrDH8RtbIWAUMDWdv2m3ZpTdJ1qMGj8SJsH6oyi3lK7EYuqsiCJF9z65JW+5t9eVCYGRp1N0wQhxsl3qYGXNe7imkSYrkiAUMbc/V/erEmJiXzUYkS408bDeB3l3hPZFWHjYlnSBmhozuZvlTZzJU503h5
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1338DC8AF5FA0C4C865EF430627C1ADE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8600ca-ae60-42bd-9a9c-08d881e2f156
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 23:31:38.2852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6z+qljmYjf9KzzEGQtypE/eQSqaMoM1na1uGmSX5tRQsiZ5v3Yqu6nIOaNBDQX4e2DJ7oKtcB4m4OXF1fRvjRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2695
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_16:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050153
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 5, 2020, at 3:22 PM, Daniel Xu <dxu@dxuuu.xyz> wrote:
>=20
> On Thu Nov 5, 2020 at 1:32 PM PST, Andrii Nakryiko wrote:
>> On Wed, Nov 4, 2020 at 8:51 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> [...]
>>> diff --git a/tools/testing/selftests/bpf/progs/test_probe_read_user_str=
.c b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
>>> new file mode 100644
>>> index 000000000000..41c3e296566e
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
>>> @@ -0,0 +1,34 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <linux/bpf.h>
>>> +#include <bpf/bpf_helpers.h>
>>> +#include <bpf/bpf_tracing.h>
>>> +
>>> +#include <sys/types.h>
>>> +
>>> +struct sys_enter_write_args {
>>> +       unsigned long long pad;
>>> +       int syscall_nr;
>>> +       int pad1; /* 4 byte hole */
>>=20
>> I have a hunch that this explicit padding might break on big-endian
>> architectures?..
>>=20
>> Can you instead include "vmlinux.h" in this file and use struct
>> trace_event_raw_sys_enter? you'll just need ctx->args[2] to get that
>> buffer pointer.
>>=20
>> Alternatively, and it's probably simpler overall would be to just
>> provide user-space pointer through global variable:
>>=20
>> void *user_ptr;
>>=20
>>=20
>> bpf_probe_read_user_str(buf, ..., user_ptr);
>>=20
>> From user-space:
>>=20
>> skel->bss->user_ptr =3D &my_userspace_buf;
>>=20
>> Full control. You can trigger tracepoint with just an usleep(1), for
>> instance.
>=20
> Yeah, that sounds better. I'll send a v4 with passing a ptr.
>=20
> Thanks,
> Daniel

One more comment, how about we test multiple strings with different=20
lengths? In this way, we can catch other alignment issues.=20

Thanks,
Song

