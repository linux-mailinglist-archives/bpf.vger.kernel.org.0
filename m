Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9D2A8655
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 19:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgKESpf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 13:45:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16676 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731854AbgKESpe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 13:45:34 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A5IcXQ2001682;
        Thu, 5 Nov 2020 10:45:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8hd1FQlCfuHQX3jPZvYDADSY9p2pyyFF5qKbCJnCJU0=;
 b=C1saIGv/80cuphGG0XxbmwVtbpKKIEn9Y9QwsvXdAI6Q7dl1GtnWAWOrXC5lJlwU6y11
 mr5AOP4Hu1s8ht5qbcM0Ic3Rm8koVQyRWImqympcvGPsvMIRYDVU33BaL2i8xo++SJft
 lhDBG5AGE/VOwgmSzDFG4/duoY4fK7yFUlU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34mek331dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 10:45:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 10:45:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG9X3SbHZj7JZmjm6DR5zLS7LZx4X4houaSBHxuaIrjwhE6nuTz5VR4Y1z11762mEzXBMvdD+T9cP6R+pCQQiD3wCq4VSEftmNneACpgJoK/at5yl01K+rp90QCyOQ0BAOzGVjdE1X9i39Em2GUApIYbTPTluyAtbCg7ybpnCPdsqwIqsH1SbjQz768sCD2UxaAspuEAJQgBAuGBFbwg08VHaaruXiS/YutdiWTGe9IwKBC/s43OYpRSdNm/mmCM9LR8+oN4BVeVALNcv4s0Ddny4QInT6JWGyob4lyt8Z84bEkOqvD8jkiWW3b3u0VdDk5J3rv4Aa5ZU3MJD7A0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hd1FQlCfuHQX3jPZvYDADSY9p2pyyFF5qKbCJnCJU0=;
 b=BLHqMgrwa/5MQmFNhVACCigZQWFDXTzie4wkPYnzyiv+wvm5SbHY3a5UUc/oMYRGoqa1Do5/xPb+wwwf2GyQX5Yb4OJdU9e1J5oecXF/OMoo57/7aV01OvvHOgV//mARkckqMS6LpOKXcGXxCgTYhgtHx0OA9gmUytyGrxcf2w57K5UPkIe8c/2moM95rN9wtuESr1dMkFX736CgTS1mXL7D6hWDpW7loQTCzge6ytKViYkImhT6AMPhCQ2I0Ux3QeJBCqlnNnLKev1oQW65WB1E1LI2k/XgGwDxjsYLoGZHm6hNV6BtJNd+kldNr/8sKOVZRlc0ZM8Cycken6D7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hd1FQlCfuHQX3jPZvYDADSY9p2pyyFF5qKbCJnCJU0=;
 b=k5AlX4/KDwfSLeKQAwmzOtfFZbn98MFoQHp5QXQbIdboPtdX9V2unU7APFw802W/wFcnToDFqFIgomUH2Rkz2p4yvxNbA2vA9293C0JB5mI5uMn2a7FTxyzjlyGvzk+kfvvPa4B+39aDgbxjxGCr6cCojEOZhLyWwsIUBiH8JY8=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2374.namprd15.prod.outlook.com (2603:10b6:a02:8b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 18:45:15 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Thu, 5 Nov 2020
 18:45:15 +0000
From:   Song Liu <songliubraving@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v4 1/9] bpf: Allow LSM programs to use bpf spin
 locks
Thread-Topic: [PATCH bpf-next v4 1/9] bpf: Allow LSM programs to use bpf spin
 locks
Thread-Index: AQHWs4KvQRXv4p6YTkGVsnueG+A+cKm54JIA
Date:   Thu, 5 Nov 2020 18:45:15 +0000
Message-ID: <F1D417CF-8E33-4C65-9F91-FB391ABA5774@fb.com>
References: <20201105144755.214341-1-kpsingh@chromium.org>
 <20201105144755.214341-2-kpsingh@chromium.org>
In-Reply-To: <20201105144755.214341-2-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6091a312-0712-48e0-ce76-08d881baef66
x-ms-traffictypediagnostic: BYAPR15MB2374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB23747CF5738D910C32DC3E90B3EE0@BYAPR15MB2374.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLZoZG4yXoO1U1TrTHEXvXljG3swYQU1bfiPU8tpiBiHANsTHNW18BQDSJTF34O5fjKFsxSxCGlfUeX3Bi4ybR1YK8Jbxja21w6WnlEcXEVomFGBaVUm9ylcyqaj5DycA6nMcDEWfI2bLSACjfJoO7+E2qSQbiSnEjMIZnHWh5UHmusfitd6MNSwpYnqsKtDktodUNom+HBI+IWC+8Ifxi4ahhB+jhF4uMixxcg1aMu4w3ug8fjBEYo0JLpcRRGv4DE3Q1uJhHgduMH9d8kHJdpWXJbin5NdRFeWQtrTXk3pcgfEBokHuBaQdkqeGHSO4pdVSPf5RQY/DMZrWLk6m/3iY32xKxdLSYQpTYi1myg5gQEAPkBjbrfudF1lSeBbvhELUJmvj/5lc0/UcdoSew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(376002)(366004)(136003)(5660300002)(478600001)(86362001)(2616005)(186003)(53546011)(6506007)(71200400001)(54906003)(8936002)(4744005)(8676002)(966005)(316002)(2906002)(33656002)(66556008)(6486002)(83380400001)(4326008)(64756008)(66476007)(91956017)(66946007)(36756003)(6512007)(76116006)(66446008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FyyYdIwijGs6sypcnXiK/wIyhaS8HsTt++TeVyN8jKEkzcg7X1fJ5ffTXYFzxxgLIVsb8FsaUzd97KrNKLmgtxFojX6kcqLKug0mD0C+hqdJp6hfsi4jqPZn+Mic68bEgWs6TVG9piVo+4ePbR6uyFwka7J40gh6Cu1kUbMIV7f6GEWJ5RsJxi1IuBmP0/nOqF6dBm75nE1lJynGKgbCp4sve6cB9DD/OpboiCO3g5EtYvFJPz/EK7w72purXRwTRYnN/o1YLZpWravyh6ujoHblAkmQ4W1j3XxKUDynfUEB9hNOOb+n1RM/ztXCfIU+rIjuMuNxadQW9DpYcWJyrSrFxluzvli7aMnfOradnViwgXVytugVV422CjwMywFxdkigD/+i+iWpVhQQRDO4fBxKDySuRe3n86pUddpXeSmXH6XEMUa+lCpgQsH8W9+9pVCdXIEge0xOt8NeCOrv2HnQY8ifTU9hTd5kUZx0GkU3Y5G8dVTr9KlWiNZhmg5qfyRIS+8R2qvj3ufjro0IbUjFV4uOmQa2W/zLTGQFzdLgq0aqqhijQy+xprm3ef6sGsflKxAbUeEZQGu1tZhMuUQmT0VmPl19E74rF948pJSU0JR/AWPMoDIonhmngrle31H+T0PvqrVIQx7Ko3bSMV/445yGMPJX6n+N17RR+JySaGd1uoTHdZDRlXQlm0d7
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECE40D940CAA8546B315F62F39945495@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6091a312-0712-48e0-ce76-08d881baef66
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 18:45:15.1858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmz2LjcX9BXWbO6oqxnpY5EyCFj1FKueOc5GuMslrcfTF+PA5xWq2WwxTHa7+52dUz1cfMcitablC/nqLl9u4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2374
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_11:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=842
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011050122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 5, 2020, at 6:47 AM, KP Singh <kpsingh@chromium.org> wrote:
>=20
> From: KP Singh <kpsingh@google.com>
>=20
> Usage of spin locks was not allowed for tracing programs due to
> insufficient preemption checks. The verifier does not currently prevent
> LSM programs from using spin locks, but the helpers are not exposed
> via bpf_lsm_func_proto.
>=20
> Based on the discussion in [1], non-sleepable LSM programs should be
> able to use bpf_spin_{lock, unlock}.
>=20
> Sleepable LSM programs can be preempted which means that allowng spin
> locks will need more work (disabling preemption and the verifier
> ensuring that no sleepable helpers are called when a spin lock is held).
>=20
> [1]: https://lore.kernel.org/bpf/20201103153132.2717326-1-kpsingh@chromiu=
m.org/T/#md601a053229287659071600d3483523f752cd2fb
>=20
> Signed-off-by: KP Singh <kpsingh@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

[...]

