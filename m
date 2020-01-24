Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADBAA149015
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 22:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgAXVZl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 16:25:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47342 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbgAXVZl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jan 2020 16:25:41 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00OLNBaf012113;
        Fri, 24 Jan 2020 13:25:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8bPwUIldTl2etCaVErCjnL+rAZoQ9/rn4rwb4xfARMU=;
 b=jMJrYhj7tn7AxuryUehaH3BWwyZPryTFSBCdi5JT9jISSlu7uQb/FVm75slsKuR3x5Wq
 POtPyJJvRS+DQl84XhfAiyP8kIJHtm9d63zy5XeLDTx4CbA8NIePmkDtE73KnbCqOs2S
 5rFbtoe0u740m80FT2svpB6NHI5I5ny+NyA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2xr63a8pem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Jan 2020 13:25:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Jan 2020 13:25:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4BSTaOBQM8PyKfl3mzlQ637+8iYPLeuyQMZF7HnJ1UAJtltu8NU/s1aB/N1P/FlPLLvkKpRYqKKKQkO++R1HF2nXCMY5fY+hzV4FRoiOdTtv+pDs2NDQXMfz3CPFTk0JLOTyagaES5F/or9CkNkZrToyrZnRHgfFwL0lR832PqaWsVL79x41yh2xHDYU5nQdGQiEg6KlyQvrFlameNDM+oTPyQnI7fF4NK3j8vKd5iWpLbWRfnx9mXSmz1zwQ4bJvpDBsT7dS389DtQt83m6tSLY3XJedgMoe8TMr18haQlF+YEjmgA4YsNRGtbxl4GItBPbL0NTQ5x0KBTnbE+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bPwUIldTl2etCaVErCjnL+rAZoQ9/rn4rwb4xfARMU=;
 b=H5qAxf0xncT3g9vgRRhlS1LeEeRo0b1noHnUjsNeb8A+DNxsnpPhnz7d/e05rjSixHEOYZijtju+pJcNB+akS5IW8KTr0qb9LhFZWDDfTQdVaijseM2zbYgSRcLlfiot3NuaT/y9QUBld8VTc3ryOWOXsLV32HomQZ1idehncjfYNk9oGThthHPP7wjDwewXHCWlCO4U7t0hcBQ0cTvD25MNwC8v8b0NTZlP4xZvJ3KbGV52joGeOFxsKty2oH9aF5/8mJYPYMGukym8MuUqrUiLQSVVDVDc6sN2lkplyKPE/eRWgApshkJdE0mYCO8SursPKqMLT7F9Cliz9wizSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bPwUIldTl2etCaVErCjnL+rAZoQ9/rn4rwb4xfARMU=;
 b=PK6B5X1fPLqNjz12rT82ay3Sy48/BPpoc8u4UrZvLG0zjrcA0BNomEnHds0us7zxKj3myYhVche2QDxmyVmTB6A7yX3lErYE048DaLLToJCzAVeBLRhFeLH1Wqhq9HrXYfyQdYGZJG1zYg4U5nDZhkhl+81xFlZtF5gGnejln2s=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB3303.namprd15.prod.outlook.com (20.179.59.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21; Fri, 24 Jan 2020 21:25:22 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 21:25:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] ls+cat based debugging for BPF 
Thread-Topic: [LSF/MM/BPF TOPIC] ls+cat based debugging for BPF 
Thread-Index: AQHV0vzJAHvUmDTCaE+/nrClRclyqQ==
Date:   Fri, 24 Jan 2020 21:25:22 +0000
Message-ID: <A8AB5F56-7233-40AD-9C49-2348B708557B@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::3:f503]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc0a86f9-f832-4bb5-5b24-08d7a113eb94
x-ms-traffictypediagnostic: BYAPR15MB3303:
x-microsoft-antispam-prvs: <BYAPR15MB330382BAC61DAC31B785BCA8B30E0@BYAPR15MB3303.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(4743002)(110136005)(8936002)(4326008)(8676002)(81156014)(316002)(81166006)(36756003)(33656002)(6512007)(6506007)(86362001)(478600001)(2616005)(186003)(6486002)(66556008)(4744005)(2906002)(5660300002)(66476007)(66446008)(64756008)(71200400001)(76116006)(91956017)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3303;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q43wA1csceVzZshCJZXShxwZyH2Z4ph/L5VASHNtPRVa98jIHSOX5ouZXMD3o2Qy5Q0LzquwnpJKZqe0xaRMUw5HlOlOt3fINPhEy40l7bC/JuUrv0rVIh54PlV1wtxxemROtIvu1GOdC51ZYupEBmrbAMDZLaTNAImN7ZHQbWa0pv39rXLhClZ4TwOjRX5g3fuxdw+rukuuJXiuPCygCn1xu/u7Ao3wsXpEt+TC9gMCkoYgEU3pUpBOc2PaB4IoNQaWhuu+G9prEN4l7samOFkczGrTvJ9Uh1PQdWUYmrk/hUVz6alS7y3Vd4p7hsITlM3tiO5K8bxNjs64sAyKsw/iznoldR1UgT6du6sWIDlF0/9w7fmAIFYaTOgcUp4VXiSfa9E0OBtngrhrMZIQLcnjF84DRGlz8J0IQvnr/i3cfc2vFkf8GSITIOVKbKlw
x-ms-exchange-antispam-messagedata: uys5K7tt48SLYBdSL1OQ7XUHCBVhZSdevb3snTgwbXmBcSASfN+iz8Y4hWv4q2pREh6du8d13/WRg7Tzu6RWQooJ1sKLnMGy1UwCgsuahSRKeIhJzdk4BYtg9PxTNaJcYna93zw6lq0D4oUHoPG3lDAIWVeY1O+oUSIz4PkVskLu1UxPwZ5utS5xZtnBd33g
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E8E382F1A6B704CAA77760EF1906D79@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0a86f9-f832-4bb5-5b24-08d7a113eb94
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 21:25:22.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LN5pqBXBO430Usb4RSkvaVzanZWD15KkohSLZbBDXWNsr1Mx6xSN1HOsg6Ul/zcJV3CoiAFrDxbFGRvcZo2AgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3303
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_07:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 spamscore=0 mlxlogscore=588
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001240175
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ls+cat based debugging for BPF
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Currently, users monitor/debug BPF programs and maps via sys_bpf(). This
approach is different to the habit of some system admins, who do these
works via ls+cat in sysfs. In this LSF/MM/BPF, we would like to discuss
whether/how to enable similar debugging interface for BPF programs and=20
maps. Specifically, we can discuss:

  1) What inforamtions to show in sysfs/bpffs;
  2) Granularity to enable/disable these information;
  3) Will there be any overhead? If so, how much overhead is acceptable.

These discussions should save us a lot of time over emails.=20

I will share a prototype of this before LSF/MM/BPF.

Thanks,
Song
