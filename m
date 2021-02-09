Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FFF315737
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 20:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhBITwC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 14:52:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45732 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233724AbhBITpK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 14:45:10 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119Jebwf031496;
        Tue, 9 Feb 2021 11:44:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Us50Y8TxtyzzOnJI6R0cAFyVayxGI9KTt5t6O/9t1ns=;
 b=kDbMfRJG9360+taq3sWflNsHkd2QqRacKvuEdtIM1YhxvVFATTy7588anrEz736RflF8
 lad/FGnUamFKOqEarK21lCE4etBYxwuxTJJELRipJtxrgEeXK8Km8IKYF91RslQQ9ta5
 S+yVcd4J8NCBEYcAbgwGmRjYp8YDHadFOfE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jbnp565a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 11:44:11 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 11:44:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/eoxn+WXD2Y1HrUaxQhjsCzpthUluYH/D+HZshyyJYK0NOajIfRJsCxLmfX7QkoCHv4R74BzJCilW1BwDvGoRHsegu/NrzbWpyY2nhj+LQ0dnarvoNKDZHh9n7D2iJZDPRLBFtpQmuBHqAr28x3Ws0F6BPfy85cfwaTPrjmv3GbjgEMT7R57AYWV+LNaOpyQ0i66xvHm8NKnVXXTe2ieQxZeLAfqR63W1pbM8GyspdAlo+RqkacD3sTeGldxDqTMj84kvBjAiFRrLd8i9krvY0tpOIxJmMjM1nafiNuNS0sHxN+Imcl1NkdmaUhYBGaDYD6VYUAjy3ju3AuoxxY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us50Y8TxtyzzOnJI6R0cAFyVayxGI9KTt5t6O/9t1ns=;
 b=EGa6pYCDIIQfz6oNKdXrYq2perWeBfw/e5kbJCIP1nUYozMVezqRwLpvm+AUXdUCqcm0bVZ5LxUGven/00K5X7/HCidgKyQl1arGplIN3ZjbydPV8/iTcAZgTKy0+5yd8TM11MyKDYAaliaWV65HTXz4mlXXEJlfMazoGrJJnApljq+nDuPGCGAa64WSMxaUdU5C/cxeizGvX0k5Frs08kjiIm2/z9ByymZ3Mvqlovo4kZAkCvtXZZzBNoJ3EuWu8SKCE/Na2fguqmyAvD+E6eCBrC6k8IZlpxZqFLgLj1W8ho+gco/FvPxsFj50O584NUe12scBRme9FLVoRgM/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us50Y8TxtyzzOnJI6R0cAFyVayxGI9KTt5t6O/9t1ns=;
 b=M9WEUiHSHYGvECvgWU3bRmwYy2kY6LOB0Xt22xsBiyfndE99DysoUdJ5G5yTGVKx+UcLdA6kZrM3P+D/OY6ScYGRB8rwdkjRbYxyboLhhMxaRZHAZQsapJnz/1Lm3MysudinTlVjSrKFK1ZI93513yOilwVhIEFNqpa4tnadR4U=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 9 Feb
 2021 19:44:07 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0%7]) with mapi id 15.20.3763.019; Tue, 9 Feb 2021
 19:44:07 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Joe Perches <joe@perches.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v3] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
Thread-Topic: [PATCH v3] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
Thread-Index: AQHW/xIkjCL+hhYrfku+4kePe6r7yqpQLT8AgAAMdgA=
Date:   Tue, 9 Feb 2021 19:44:07 +0000
Message-ID: <4D649CDF-A738-468E-AD00-8A64DDB11D1D@fb.com>
References: <20210209183343.3929160-1-songliubraving@fb.com>
 <2b41e46fcf909bd67a578524107214fe4b1eeede.camel@perches.com>
In-Reply-To: <2b41e46fcf909bd67a578524107214fe4b1eeede.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:3a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cbb6e7b-a15f-4368-3259-08d8cd33109a
x-ms-traffictypediagnostic: BYAPR15MB2999:
x-microsoft-antispam-prvs: <BYAPR15MB2999B46B1B7790D478696824B38E9@BYAPR15MB2999.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DcA3VdwC8Gm9XeZHe5290WF+Mtk7EtTB6iPLPmATvKb8cKDg2p33QA0bhtqAeZaWtA+d7ot8fF9CU1GD9gBIBtwMoDe7SVcS1EhPahZdBI7huVOBkiv5dWSMQZbauTxPTZ7Wt4OM5cGpbAxMgLS4q2t3qXdj4rngiQCySIfldqzaIcdk4SnH9lNSlHpL70xRUctb1sS95lgqL93viukfwK314LOh/anQ+gslZIIlYSB3P1VMLgk+wC1+qm45IDPqFB9x4E2QsY7x/yIWB9UnZDNXyEVJmPP75QB636N0bKakuWudNy/d15ZEUzLC0hruDRNvErmzj3wzxnsYyoSY7bJDUbZuFLO0Xmy8nOpmI+/RJgEWwhkv3XdqYw2VfKFEfBrHfPcOJ0ykXGKzIlF4DFj+v4CV64MOAphvZQq8FKbcY5+uprDZvvw2CXS+2utelYXA+CO2Y7y2lf34BwKSgHUseRwVYUJvhinfegpaS3ZqQNMEjCipK4qPECOVO693p9p80+tm5vhlMiBm+0+1F2g34O/tnbIhRVlaMeUiKtXEj5sE0b1XTBSkgFRs6eY/6migQPfBBiowV1yBsgroLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(346002)(376002)(136003)(66476007)(2616005)(66946007)(66556008)(64756008)(76116006)(91956017)(186003)(66446008)(6506007)(53546011)(4326008)(71200400001)(6916009)(6486002)(8936002)(8676002)(6512007)(5660300002)(478600001)(316002)(86362001)(33656002)(54906003)(83380400001)(2906002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HDEAZG9P/l/OBSlxxFLX8MNMFZ05U9AVZ9aKx5/rwLth81Rrqz4n0SRiEcQk?=
 =?us-ascii?Q?G9l8SYtsveBOjvHQhYGRm3QGQFXuBcSoS2l+e7tUVxGOW9UZu/5jlPoMiney?=
 =?us-ascii?Q?uXevb68gxv2dGhiyNO5dy626r9GgkPQlC5YmujLatTAPkzvPeQLdb4YD6PUh?=
 =?us-ascii?Q?OaUuFM7geq2v8T7eG4XBiE0zQe9KOx4/TL4pe/DFz6+EzN/Z7b7OOysGeZVp?=
 =?us-ascii?Q?KlSZrSOIpmU8vHgQjY8ALfbap2Srz5yQbkvKis2aJW8mU1lnNRju2nY8htsE?=
 =?us-ascii?Q?ZShOz4k5dfKsYQ00a9wmfKJAQaIjjXaoK7CsibE/qKVklWKirAZLquEmPvNb?=
 =?us-ascii?Q?YePbIu+IKNeWycTydC8L7JXwAvUcCwuWqcrwpMYohgI03IVAeGpiLfNsAJcC?=
 =?us-ascii?Q?XkDyHD6y9a4KYYK8dSolxwYSsAK8lFbf4AihrMGJDFWG0SRTWOGUC9SDnqFn?=
 =?us-ascii?Q?kQxSiinjwICPRoXJJ0d5EUj18qX1dnnjIMVNjkvQmjgi7em5QJmTLEkRdtRq?=
 =?us-ascii?Q?zOt3Ezjp70DFDFEwgCfegLBM4eX0+2O5bijrnCt0ybXFqFmlK7WzNT1Yg8WU?=
 =?us-ascii?Q?FnxiDvEos2iMrcpoERZL/gD5ZOvOVSFsyJKkhNP0MivAZVDe5W4fTAYPZiEp?=
 =?us-ascii?Q?T2QktdtWI/NAE/9HpduG6PuYf2r3eXHFfG1lf3Gx8VpCEA+ZYFGWiGWsZfoN?=
 =?us-ascii?Q?SuUve11O4YGmdXUmvhONeZiN9lsGZq0caPeiMh+L35IWt6rU7CmLVbQfivxw?=
 =?us-ascii?Q?X+Bnmd/iWbwtnAY82Y7b9kxlLvivFT4aAi7qxTqGkvz3+U3Rw18liVSpUbq0?=
 =?us-ascii?Q?ur2RZ4XEWEloQpzK7IMuvo0t5jRB8FWaXIojEbff00cgNDbbjMQaj9FVf7nz?=
 =?us-ascii?Q?kjoYwQMIgdkwauuHhaZqWKim9kY5IHpeK36TuFrHvuI3vFoB6ib3KtSeL7oZ?=
 =?us-ascii?Q?Jr2FHcjUMQ4qWqoRZgQesYVY3v7aPiSKBr8ZDsrREktzIUbh+0zpVrdfkFW4?=
 =?us-ascii?Q?zsFQZ6LFe0afUwbaqTdgMTHgNsRmS/pXvOzbvQzg6rwq62U1M9JR0bIsUrJm?=
 =?us-ascii?Q?621qhReJCTpUr9MawLWaE2WiakHwo4Vz2umLnYmA8OhRa/QrJaxHH26/v1+x?=
 =?us-ascii?Q?wINdd1oifdZ/bj9hRVMUPgjRqtnGv31t2tl98+39yLCnr1YHyx1aHXlujd8U?=
 =?us-ascii?Q?s6V/Ouo5fxYPhQoUij54oRdAj2yOarI287W2zxiew5/BFMQU7UxmUJVsRnc7?=
 =?us-ascii?Q?boQEG7hdXql8KbxfLhrLwkCnIwG6xMCo93Ft0Ic7d85lBLRK/rCHX3pdjgUn?=
 =?us-ascii?Q?06pnSnI4i7TP1H+ssxeoGfwlDR7LMKj7wN4nS2NwGBGZz2pA7o+5PTjW5LSw?=
 =?us-ascii?Q?3Lftds0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <665CA15C19C9A947A26EF12B2F496439@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbb6e7b-a15f-4368-3259-08d8cd33109a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 19:44:07.7382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtgHv4ilCKifkCqSxGyNzwtAuf6H6FxWvSftjVQ2XmHv9nlPVHYUUqDmq1CCXY5eK/cIrYKd9qmFBjgBsOArzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2999
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_06:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 9, 2021, at 10:59 AM, Joe Perches <joe@perches.com> wrote:
>=20
> On Tue, 2021-02-09 at 10:33 -0800, Song Liu wrote:
>> BPF programs explicitly initialise global variables to 0 to make sure
>> clang (v10 or older) do not put the variables in the common section.
>> Skip "initialise globals to 0" check for BPF programs to elimiate error
>> messages like:
>>=20
>>     ERROR: do not initialise globals to 0
>>     #19: FILE: samples/bpf/tracex1_kern.c:21:
>>=20
>> Cc: Andy Whitcroft <apw@canonical.com>
>> Cc: Joe Perches <joe@perches.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>=20
>> ---
>> Changes v2 =3D> v3:
>>   1. Fix regex.
>=20
> Unfortunately, this has broken regexes...
>=20
>> Changes v1 =3D> v2:
>>   1. Add function exclude_global_initialisers() to keep the code clean.
>> ---
>>  scripts/checkpatch.pl | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -2428,6 +2428,15 @@ sub get_raw_comment {
>>  	return $comment;
>>  }
>> =20
>> +sub exclude_global_initialisers {
>> +	my ($realfile) =3D @_;
>> +
>> +	# Do not check for BPF programs (tools/testing/selftests/bpf/progs/*.c=
, samples/bpf/*_kern.c, *.bpf.c).
>> +	return $realfile =3D~ m@/^tools\/testing\/selftests\/bpf\/progs\/.*\.c=
@ ||
>=20
> You don't need to escape the / when using m@@, and this doesn't work
> given the leading / after @, and it should use a trailing $
>=20
> 	return $realfile =3D~ m@^tools/testing/selftests/bpf/progs/.*\.c$@ ||
>=20
>> +		$realfile =3D~ m@^samples\/bpf\/.*_kern.c@ ||
>=20
> This is still missing an escape on the . before c@, and there's no
> trailing $ between c and @
>=20
> 		$realfile =3D~ m@^samples/bpf/.*_kern\.c$@ ||
>=20
>> +		$realfile =3D~ m@/bpf/.*\.bpf\.c$@;
>=20
> I believe I showed the correct regexes in my earlier reply.

Just to be sure I got everything correct, does the follow look right?

        return $realfile =3D~ m@^tools/testing/selftests/bpf/progs/.*\.c$@ =
||
                $realfile =3D~ m@^samples/bpf/.*_kern\.c$@ ||
                $realfile =3D~ m@/bpf/.*\.bpf\.c$@;

Thanks,
Song=
