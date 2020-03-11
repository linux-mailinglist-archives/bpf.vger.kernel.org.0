Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BAF181D0C
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgCKP4A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 11:56:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19012 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729841AbgCKP4A (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Mar 2020 11:56:00 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BFtNEj015980;
        Wed, 11 Mar 2020 08:55:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8q1WGkNgMR7rH3HqNGPPvxsqUPmO/HgAbR8KLJLx3z4=;
 b=LGzfTU4CYKdDALvI7ToArVOP9BaCPNYyv3DE52vkKIgy18QTlopJDAUC8+mR3Q2KCCIv
 HcIRnuYIqPlxiXpTfJP6JBFIXoU+yWyjWZVYxKwBidH8M0ssV6HZTkXd8cpMOfMpEOKb
 r7cOqPTmVYvOtUOEo3oLevnNUsDxEoSLsXc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yp7t2qn6e-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Mar 2020 08:55:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 11 Mar 2020 08:55:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZFkP7fqUs0ZDlJF/PFav5dc4JhHLhCtRRvJ9LbMGQfpMmXJA/DrPC98Z8nApyGbLx96OYKgkAEf3WguWMJZgiasXoF6tdoTOfWhYKrjRT//U1xZgD09Po5etxO9IawtT5PT4eu/w6AgHFxaMWkF14X8GfM6e2cJKAl/VB6Zl7Q3D5iD0jLI3pM3GcI9ZkmSsT86GxTW6uHQOwmi3htdhK96nX2Npa7nP3Oxn2WjPydd3tuh6pDtSQSoHi58Oq5A7fbA5itxbGYHcLE2cxpMgDgYq90qmvErrpvJ1q50Aqa6DCIzpRQJi58RWTxvxhV0CMKIs9dtJI72xTdhNtBGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q1WGkNgMR7rH3HqNGPPvxsqUPmO/HgAbR8KLJLx3z4=;
 b=Cl9sH1bbwQsTypQqrL868gdsbc61l6VMFwsdqPTaXGwv8JA+DbwmgWGL9GY6djAYK48i0ORs433hXk8LKWIbu/Zv1mTVlggTNnjGfmeIjBSK/F36gGngFkKM2h+ELtULk67aSyjR34HKvU1BApsCRcYDQhLg1uUzN4/cBSpLYI8oqkvi8pD+ECxALpMoT+9htm4RitVuTJp05rL216SkdsErxxh9jXqkiw97w4YnXya0+euS1Xa/B5JaJS6/bwsI1APLXLRVfqFqIZGRWGSUuDwLU8Up061zLF1JPqHr4VvPf/g83yRuQON9ZVjtvc8bXNH/ZznjOrRTYmW+AufVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q1WGkNgMR7rH3HqNGPPvxsqUPmO/HgAbR8KLJLx3z4=;
 b=G/xdHHWcET4Xo59poyYOtYIk3uxkkJBybTC9hpg9YYc8z7XWFB4EKqTYJOiv3XCzvf3PL566/OkMrJa4VsZnfK0n+LJ5io5CVGZeJ5Jku7ADfZDerzOxve/pEdN2D8QB597ZYJuqaZfY80JGgXYrYjNJIB/BiQKqsS6pyoup0Sg=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3820.namprd15.prod.outlook.com (2603:10b6:303:4c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 15:55:38 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 15:55:38 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Tobias Klauser <tklauser@distanz.ch>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "Yonghong Song" <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpftool: fix iprofiler build on systems without
 /usr/include/asm symlink
Thread-Topic: [PATCH] bpftool: fix iprofiler build on systems without
 /usr/include/asm symlink
Thread-Index: AQHV96F+kIrYsrBv60+x9uyT9neeNahDi8EA
Date:   Wed, 11 Mar 2020 15:55:38 +0000
Message-ID: <D8E0C5BC-E724-4788-86DA-EF8110237B6E@fb.com>
References: <20200311123421.3634-1-tklauser@distanz.ch>
In-Reply-To: <20200311123421.3634-1-tklauser@distanz.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:71d3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97a3f734-fca9-427f-836a-08d7c5d4a4e8
x-ms-traffictypediagnostic: MW3PR15MB3820:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR15MB3820F57CA9B7E0BCD2D9184FB3FC0@MW3PR15MB3820.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(6916009)(6486002)(6512007)(33656002)(4326008)(6506007)(53546011)(71200400001)(2906002)(186003)(2616005)(54906003)(316002)(76116006)(5660300002)(478600001)(66446008)(64756008)(66476007)(66556008)(66946007)(8676002)(36756003)(81156014)(81166006)(86362001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3820;H:MW3PR15MB3882.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1zIsijKDDI/vskp5RyR/6YGHPlrkqtuFLA/salTbB3rpYgOtZDMGEEzcgSe4RAR1qPrh8HnSTnrsJqAomxxFZvnnH1+b3OQBypLx8MOotOlPl/zL0T8tGUHCpLCeSKPjLicXGM6iIFfyCYtDVj/hEcU0CVEEhO1SjUfHhRt1A+GgDI4/3/ZsRcTCe2n+5KcYdbj3cFWwgzyvgr88C5SjutL32laukKrU/+GaftK1IiMm9jiuZRvLX2fju9hGGHFLBWu8xA5ePwl721k6FDx6L03+5LV/g8W32Zp+gnsdEPI6CsXWbxZ36JYPryoB1oRrCxq6b6ABqaUSy1s6jBegZc096Lc5dK0Yfg63BCXG+YxYCe25ZsXwMzcdmjECEQ1FX0xofsImIsJQ2whfVbSHEmSeePz1mAUi4GPmouLQjCXEF/zb04+WxPbbimdDFSij
x-ms-exchange-antispam-messagedata: YaezKMgAO4zEs/iVnsWnI5kgWO3Dgjupe4KKSnB0SHlLClHeX75E9W5MfFTg8Bmz9hG6hHUbc9zBJPJqlici3YLwjLJ4Vh9eJbKny+jzN5QHC1i+vh85uJ8QZWvAAP8L2su685XLH9/TC/+XtACiKbaH2xGF83H9dGC9tXMXebCNgJfFfAWY5lAqo9Abfuux
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5DB509CC7F53B4EBB66814F364ABB97@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a3f734-fca9-427f-836a-08d7c5d4a4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 15:55:38.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ir2BtHMf7e31DmBvLNNPUbqmWUNvGM6cz3Y3Hp+LWekqBZvFS+ywrIH0GhIDKlYwNypQtVNyWxL74Y9Fio9TCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3820
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_06:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110098
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 11, 2020, at 5:34 AM, Tobias Klauser <tklauser@distanz.ch> wrote:
>=20
> When compiling bpftool on a system where the /usr/include/asm symlink
> doesn't exist (e.g. on an Ubuntu system without gcc-multilib installed),
> the build fails with:
>=20
>    CLANG    skeleton/profiler.bpf.o
>  In file included from skeleton/profiler.bpf.c:4:
>  In file included from /usr/include/linux/bpf.h:11:
>  /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not fou=
nd
>  #include <asm/types.h>
>           ^~~~~~~~~~~~~
>  1 error generated.
>  make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1
>=20
> To fix this, add /usr/include/$(uname -m)-linux-gnu to the clang search
> path so <asm/types.h> can be found.
>=20
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Looks good, with a nit below.=20

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> tools/bpf/bpftool/Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 20a90d8450f8..3cc0644fd91e 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -120,7 +120,7 @@ $(OUTPUT)_bpftool: $(_OBJS) $(LIBBPF)
> 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(_OBJS) $(LIBS)
>=20
> skeleton/profiler.bpf.o: skeleton/profiler.bpf.c
> -	$(QUIET_CLANG)$(CLANG) -I$(srctree)/tools/lib -g -O2 -target bpf -c $< =
-o $@
> +	$(QUIET_CLANG)$(CLANG) -I/usr/include/$(shell uname -m)-linux-gnu -I$(s=
rctree)/tools/lib -g -O2 -target bpf -c $< -o $@

Nit: this line is too long. It is better to break it into two lines.=20

>=20
> profiler.skel.h: $(OUTPUT)_bpftool skeleton/profiler.bpf.o
> 	$(QUIET_GEN)$(OUTPUT)./_bpftool gen skeleton skeleton/profiler.bpf.o > $=
@
> --=20
> 2.25.1
>=20

