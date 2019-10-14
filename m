Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C12D679F
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2019 18:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbfJNQqo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Oct 2019 12:46:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28914 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387474AbfJNQqo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 14 Oct 2019 12:46:44 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9EGj0qn012491;
        Mon, 14 Oct 2019 09:46:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rJ0z69vH+tCOk0MXMsrjVS8bBSxr0cMtf3JttGc/08Y=;
 b=PvqOrGnqifvuVRE8ZCFBgaCj4+Z6GRKdRS1X6jch5jUeEdDClhO/YHu/dER/jKQKdrGY
 eG85IIHWz/cTTPu+cZiAuzhugpppgPIpaqo2Gy5O/FETV5+POKJKuLkr+vJoXm9m8l5W
 vw4u0mu/QBSZ93Y+zZ2vMgoEfXbVg4eHtyU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vkxhc58d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 09:46:28 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 14 Oct 2019 09:46:27 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 14 Oct 2019 09:46:27 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 14 Oct 2019 09:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHhIei4pp1C9wt4NkRKQFcBugBDbRJX4Q/F1IsMh4CJRcrgQhhQOBQM0ae+zk4X5+nfr2xF3/SltmBfWXoRowuytlxBKUctwqPZlSh775OUTEfqeZhwtEhIzeT9Bk8gclQ8BcqRhvXheaGVvXa/YBzPepNFU3k8UDhol/upNe+92h69RjFlQ5XPDHrk3K4EtjEXOUDmfq7Tmpc0qfgYQMsXMxb/ZS+hEVWVZbuNigeCADuyJGOcDRE6ste2X7acgzXNm1H3pQ3n/f0qjOHddynRFMMANiseHUPp50AkNhZC4kvlB27nCibKfy5xZDyqa1LQ6Nxh8OHfCOLhLqlr+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ0z69vH+tCOk0MXMsrjVS8bBSxr0cMtf3JttGc/08Y=;
 b=imw3LxINwD2MD8BE3GFgKNvgVOQ2X11BLmBk/PBXEcSThQfQbFsWenEsTGeo1aX2GWscXRzNNwlz/yh860o9rtxTWUOhz5rbCKogyufry5gJFrZ3aRh/kU3VY2DHoxsHamW8lXrc0oB6Pwxk5hzGnEm7560hFglXWmPF+K/asUpKfvAwqwsMHmBML2xxe6W7hp85OizayJYsJ3QAgC9MWS8So1QBKtdm2zu8mzvL2inkXyxptDPhzh+XzBweaqYYyVfIUzWx5pgA2weu3QYryrRdjbDt+cE90GfkweA80YaYOjf2wbjTZPu0Uk68YhJKkfposIaxB3pNjY0RNgL0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ0z69vH+tCOk0MXMsrjVS8bBSxr0cMtf3JttGc/08Y=;
 b=YkfYOAUDHqxaBtMb70Cud3JPiBZb9DUYelZC8FJksMQDfRajruH9hqHnMyl9uMIKb37DM3nHGqyTyGbuH7UgyIauLZ9aH7cXIqP8yAHk3M8FLC96nl6W9BfKMd2Hyb+JEDQuoxNb2Lr5XyMo+DP4D3k/mLldBKDiqWsExiFLNsQ=
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (20.179.21.76) by
 MN2PR15MB2557.namprd15.prod.outlook.com (20.179.144.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 14 Oct 2019 16:46:26 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::d5a4:a2a6:a805:6647]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::d5a4:a2a6:a805:6647%7]) with mapi id 15.20.2347.023; Mon, 14 Oct 2019
 16:46:26 +0000
From:   Martin Lau <kafai@fb.com>
To:     John Fastabend <john.fastabend@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] bpf, sockmap: convert to generic sk_msg interface
Thread-Topic: [bug report] bpf, sockmap: convert to generic sk_msg interface
Thread-Index: AQHVgojn2x4DpjTSjkerpvL4HMH5e6daWMGA
Date:   Mon, 14 Oct 2019 16:46:26 +0000
Message-ID: <20191014164623.wp4dpi5nghji25ot@kafai-mbp.dhcp.thefacebook.com>
References: <20191014121330.GA14089@mwanda>
In-Reply-To: <20191014121330.GA14089@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:104:7::28) To MN2PR15MB3213.namprd15.prod.outlook.com
 (2603:10b6:208:3d::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:6574]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d4442df-73c3-4794-fca0-08d750c60da7
x-ms-traffictypediagnostic: MN2PR15MB2557:
x-microsoft-antispam-prvs: <MN2PR15MB2557EA5E68ABE00AE2F135DDD5900@MN2PR15MB2557.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(71200400001)(6246003)(71190400001)(6512007)(6116002)(6436002)(7736002)(6486002)(5660300002)(1076003)(476003)(86362001)(446003)(229853002)(11346002)(9686003)(486006)(4744005)(305945005)(66446008)(102836004)(4326008)(64756008)(66556008)(66476007)(386003)(6506007)(316002)(186003)(66946007)(25786009)(8676002)(76176011)(52116002)(256004)(99286004)(2906002)(81166006)(81156014)(46003)(478600001)(14454004)(8936002)(54906003)(14444005)(6916009)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR15MB2557;H:MN2PR15MB3213.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YxB86Pqy88/XjgENRxU3d4sAZW3NP/cY6q/G0QHUE/0rTM8aRDqdljFQth2c9kMwVL/IBtaHvoyr3CDXZ1uM6kvf/88JmDU+d2Zcqm8nPmoT0EYhAkGLQ6T9Ssu/5+j6OizzljwFIsn+gkEUerjqGyediSQRgSSyFsAXxoi/K04bbopGJiCqE4L1SlLmMTA0xwKB+cgq/QVqj4GW7am0lSFzdMLAYRr9QuKwBw9Fw4iAOVePYvgLFm0g4h5ZgkF3vOEZQhFBpnHLaF5ysY6AEkADvgi90jnNCq2aoIIzh43azvIDdySm7LQJCG0mgebXYfLCvkKulWbpete0+qeMGy5QjX73UQrbz5zb8CDCNAsBisFOx4fbae90bvMUPnIRp8wgtDqZMnY2e3D8qLLwDrycv5gjFnwDb5lKW3xPmM8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C55F9F081BAB641911F6C1466E6C535@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4442df-73c3-4794-fca0-08d750c60da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 16:46:26.0813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXgJ0Hdj2zDxUAnoIbIwP9jDO2fVk7Eobx+5xvSb1pSEk1L26Fnu4VSDjnbx0cGh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2557
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_08:2019-10-11,2019-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=450 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910140143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 14, 2019 at 03:13:30PM +0300, Dan Carpenter wrote:
> Hello Daniel Borkmann,
>=20
> This is a semi-automatic email about new static checker warnings.
>=20
> The patch 604326b41a6f: "bpf, sockmap: convert to generic sk_msg
> interface" from Oct 13, 2018, leads to the following Smatch complaint:
>=20
>     net/core/skmsg.c:792 sk_psock_write_space()
>     error: we previously assumed 'psock' could be null (see line 790)
>=20
> net/core/skmsg.c
>    789		psock =3D sk_psock(sk);
>    790		if (likely(psock && sk_psock_test_state(psock, SK_PSOCK_TX_ENABLE=
D)))
>                            ^^^^^
> Check for NULL
>=20
>    791			schedule_work(&psock->work);
>    792		write_space =3D psock->saved_write_space;
>                               ^^^^^^^^^^^^^^^^^^^^^^^^
>=20
>    793		rcu_read_unlock();
>    794		write_space(sk);
>                 ^^^^^^^^^^^^^^
> The warning is on the wrong line.  The dereference is really here.
>=20
> regards,
> dan carpenter
John, can you also take a look?
