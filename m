Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04F2315457
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 17:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhBIQuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 11:50:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232898AbhBIQs0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 11:48:26 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119GXN7B001042;
        Tue, 9 Feb 2021 08:47:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=miDT6Z7nMImlOJzcvLcJbEYxvCqwAh0gV2LOJo3HZAg=;
 b=Xc2rXK0NTA/B6A+uAL4BuRbL5EpDA26Kzb/nvzhSggLJ4IdyTN2uw28Y/U3Q4TD09Q1j
 KDH+VDpT22XSF8H6UI5xGgsFWElGUW9bKPMUfWNlYnDYPDliLACy1WaBvS3fnIB8EKIr
 RRkqSnFxw5vtWw7tFuEhuY7l++yMT0YyAcs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jy96s5bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 08:47:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 08:47:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAnrSakPOImMaldX7FJs3isz7StHDHF8ekYa+CkyH2BODDwesDR1tQ4kbMKdFAGUzsFLQ10HBQbbiNQYxE1zI0w+TZHdI+hPnzWKNT45gsmqDBbRQ35BD83+zYKvGhlxIszsrgb4NRMoJNjt4AZXPdKhC6MxQ3F0n8sO6dOdL/NCucfEcPCHFdDQHvIRElc6dTxnA33jjj3r0HpwftROCnot4JLtkC1Os23GfBNLAzzmqtlzk4ZhwvQgupmbl4LSjAqMwoUE/ZhXzWzG+20hOkWscYR8d8ODkFkeS2p/kIjFlZe7ZQdaADwjvEeTnPCwAndYQLp/FNZvR3P/LR5k0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miDT6Z7nMImlOJzcvLcJbEYxvCqwAh0gV2LOJo3HZAg=;
 b=GOwX46aH7vE4g3xwKvdLteNMxScIe7tek13Sze0GSy7Y+Z6k2PBRLSdPg5vdCxnOmkOMDtQ+q7sz1/OJFnXgVdDqGWlx7llceyaLjCMjw8b87Q5StmBTxfzIL+JE8HuG9bFAOj8vn02P/vf1yXeYQ4xX/EgcNBvoLbh9vu/v5fMgJ0ZWDXSrVjUrUaHarsnCJi3oRK6GEdTxLamzcdgD17X/GigiKm7mYYyfaTFcbqBS+A5ZWj2q+3MFcKdK7XerqcX0UNKPBXfD/lnrhYPpKC6CUs7LF5ZawbI9J2oVuGWuy75p2Dvj0cTHbW/Yn5NHgv3+QBfbSuXxKGPUDLNtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miDT6Z7nMImlOJzcvLcJbEYxvCqwAh0gV2LOJo3HZAg=;
 b=gM+8C9t6tVZ/4qdrqmpx6HV9WzpjRsH7X6RxdSFa+WK6nmabfCuSgMpCOYHYyO3L6VA6PSIteWtceLp7OFNbeLHlTy3XL78CGD3g9wdZET9PRgEkxB5uFt5k4SiqVUjXxv3aF3rnOK0w785DdDDjpGHe25dJL1V1ujxSyHKHXeI=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2327.namprd15.prod.outlook.com (2603:10b6:a02:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Tue, 9 Feb
 2021 16:47:39 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0%7]) with mapi id 15.20.3763.019; Tue, 9 Feb 2021
 16:47:39 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Joe Perches <joe@perches.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH] checkpatch: do not apply "initialise globals to 0" check
 to BPF progs
Thread-Topic: [PATCH] checkpatch: do not apply "initialise globals to 0" check
 to BPF progs
Thread-Index: AQHW/nPGy4icMgAVSk6JfHOFnzEOp6pPXQgAgACsnAA=
Date:   Tue, 9 Feb 2021 16:47:38 +0000
Message-ID: <A8E7D663-AD18-49CE-BC3A-E0D7AC9049FD@fb.com>
References: <20210208234002.3294265-1-songliubraving@fb.com>
 <87ec5ac2e1a41000da9a7158491a22f83295c1a6.camel@perches.com>
In-Reply-To: <87ec5ac2e1a41000da9a7158491a22f83295c1a6.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:3a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf4f1e5b-9142-4579-09f1-08d8cd1a693d
x-ms-traffictypediagnostic: BYAPR15MB2327:
x-microsoft-antispam-prvs: <BYAPR15MB2327BFFFA4EA0D4AF00EDEFDB38E9@BYAPR15MB2327.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tot3Sh6FeeJA5NY2bSaQVj26zL1Zt/uhUAgsMIn20BC0WiET6jXmNsP2YRi2DOSl7RaY8hdzr+TfEqDWzKbh7t+oAcJKheGJ3f4jTt05yOoqjdjWujpJ23pi2879uZAMjRiH2KgSgwhhvtWpz4/kc27w3biZcCumffy7ZpCZSgBmGorlKiA5IpcTbtXBlCRXcXglUj/g/2lEtbI2LmMroIZXFJL8r6DwXu9kdfJGKeg3Zy4EE34xajBZeEhj5KmncXoapQOXxTpKGd/LXmuQn+CRgAEwxU2k6vEyT/WscewYaC/07tSjbvbHLnmEbPQiLqJQ9PbL/EY6+tn8Bc4GOWLci3pWUPzIVBDx2RlglN8XfYfY68iGke4dfXI6XbjTBzjQN+8IXax9sk3dcorKhNL6eoaQw+Gi2NWn4P/vHVj3X20QrhRJyE9iMjHLiJZGpOVb2mIOW/J7Us1MAVcOYmmrN0DM0JOTGuAnzkrkHFOEzg89ted4PTuktGU/CQw8NKVk1w9qJ82IxtXDsQdbfcPNkNDg2UI+S9TCwRur9qRg4pRw7cYSIIe6DFI7vTQTVNUBEY5YWuoU+y47V3/81w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(83380400001)(6506007)(53546011)(186003)(91956017)(66476007)(66556008)(64756008)(76116006)(66946007)(6916009)(54906003)(2616005)(6486002)(66446008)(6512007)(2906002)(478600001)(36756003)(8936002)(4326008)(86362001)(71200400001)(33656002)(8676002)(5660300002)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ICuUFdqYpz1594+OsXaPsp1z6euf1JXRRSksDFdY1kS5ZojrX6O1A/As/6oY?=
 =?us-ascii?Q?sYIDnjINPpWIZcssFhZyiPlsi3ga5xENp1IqchR/L19j6R8WksAZZ5LLE6xx?=
 =?us-ascii?Q?MjO7fhowI9sDLfEEs0/Ty3Z2th2hs2eZHXYgrLYNeUjj++clNI403ajkwpHq?=
 =?us-ascii?Q?TU8TscU2Iu00oaRWAswyJ48dOsfjYkLxKyMoURAei+n/zLAqB3n4AUTuSZkv?=
 =?us-ascii?Q?5N/iDKtwpsNblbxlfCGUJ5ZDudibRgaLSuDDGxBXULn7WBDSPaYjL/oE401g?=
 =?us-ascii?Q?IG2TmkjhRxfx6TtAZerBj9x8oSNUeI13YlVe1o4KsaWk0RyvntnFFMko2iaI?=
 =?us-ascii?Q?FVgq/3pvBViAR7zqafAYABCuOEJ72cx8p+7/hz5pVDA3QnkuMsKVnm+NC2OH?=
 =?us-ascii?Q?JmOSfwemZr7p3zcHhk05uYaIs0U2ttvyFHEaNZi4qcz2SsyWs4lri/nQWoTB?=
 =?us-ascii?Q?MAfaovWKqQUpehKSmP1Z4G62mDc/O4yM1MrN8SBfxQDOehBrFtjm8qvZYLet?=
 =?us-ascii?Q?SpWoK+PDJXHAkmrWc6RoV7FBCIjRBHh0AomTq/gHlGURT9LeH9o28drRmbJ7?=
 =?us-ascii?Q?JMKfMWbJuMblJB1D6Az3mtjdGOpphpPbahhQ3wpVKzzpM9bGSFpROSf7PYKd?=
 =?us-ascii?Q?GVhUKuf4syZWqGwVFsdjlg/fXakQtayx/e35CWuN4C4mEXTMSf2gn+xk8lcb?=
 =?us-ascii?Q?RQe4vOX9SnBoZUD8ASQ/RoER2nci7biRhwCbTMrrNvyzV2LhEeJtJVm0ZNEM?=
 =?us-ascii?Q?hgUMkmNt3wfee4wMVhqeT4zBkeQ8vF/CWV3T2eDYmAvDMkCPFO639xbikMte?=
 =?us-ascii?Q?unKr++CXIM7Q2j0XMaK8qghgLoQbFb/baFfzkfq8Bewdt+1onSj+gVBOzLN1?=
 =?us-ascii?Q?JMh2bU6dGeOBG7UhSWN+7LjjJXRgxMbR72uvbGW9Qhk9NgmXKyVCQSi6QcjN?=
 =?us-ascii?Q?xoaj7JKP/qKSgVu9hxCRIo9BGDABQ53y2IF2hqIRxoWAJbVWZ08bFAY/r9Ji?=
 =?us-ascii?Q?+q5AyufViUFkg2SuWM5O7/6zxhCKRXROQxeqlNyeBJdy5SyzI6HngofRvdnN?=
 =?us-ascii?Q?TsG1SFZh/F+GfHwaMOcip2Ig2uZ5TxlQSF6UUnXQA5O9qA5/cMgZ8SASqL9Q?=
 =?us-ascii?Q?hc8omUwfJPUdgvC6fL/2QIEKeivHfBF/ZL9IHG43wU0CUgLN5U7hNmdbHQAu?=
 =?us-ascii?Q?85fEtrhoDdtMiZd41QcwGwejN0Yw86vg8+GeH4Xutl7ChiQyx3SUtvJJ3wRl?=
 =?us-ascii?Q?SJO7HAQfbBLFA70/Y+kNPmVfv5hp46QKIJo3qetaZJGKbXfuJw95qp226Mde?=
 =?us-ascii?Q?spoa8c3Ijd74oXfKRH7lpt2ZgRsgF5cIxVlCMhuK3ANvPoT3qwmnidFTboKO?=
 =?us-ascii?Q?A/SPwcQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B333D02D89FCC345BC7AD1B8D38F1CA5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4f1e5b-9142-4579-09f1-08d8cd1a693d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 16:47:38.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76YVnxlKWTMlABuLRnOyF5fI8LKl+0nUN5yGCG1/V3tQ5lftj10zdPqawBcNaMqOapnadiw5h/f16pwrNwi0vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2327
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_05:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090082
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 8, 2021, at 10:29 PM, Joe Perches <joe@perches.com> wrote:
>=20
> On Mon, 2021-02-08 at 15:40 -0800, Song Liu wrote:
>> BPF programs explicitly initialise global variables to 0 to make sure
>> clang (v10 or older) do not put the variables in the common section.
>> Skip "initialise globals to 0" check for BPF programs to elimiate error
>> messages like:
>>=20
>>     ERROR: do not initialise globals to 0
>>     #19: FILE: samples/bpf/tracex1_kern.c:21:
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -4323,7 +4323,11 @@ sub process {
>>  		}
>> =20
>>=20
>>  # check for global initialisers.
>> -		if ($line =3D~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=3D\s*($zero_ini=
tializer)\s*;/) {
>> +# Do not apply to BPF programs (tools/testing/selftests/bpf/progs/*.c, =
samples/bpf/*_kern.c, *.bpf.c).
>> +		if ($line =3D~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=3D\s*($zero_ini=
tializer)\s*;/ &&
>> +		    $realfile !~ /^tools\/testing\/selftests\/bpf\/progs\/.*\.c/ &&
>> +		    $realfile !~ /^samples\/bpf\/.*_kern.c/ &&
>> +		    $realfile !~ /.bpf.c$/) {
>=20
> probably better to make this a function so when additional files are
> added it'd be easier to update this and it will not look as complex.
>=20
> 		if ($line =3D~ /.../ &&
> 		    !exclude_global_initialisers($realfile))

Good point! I will make this a function in v2.=20

--ignore is not ideal, because it is common for a BPF test/sample patch
to have both BPF code and user space code. Adding --ignore will skip the
check for user space code.=20

Thanks,
Song


