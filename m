Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317A42A3D9E
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 08:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgKCH0o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 02:26:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:60322 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgKCH0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 02:26:42 -0500
IronPort-SDR: K3hgx4TlnhCMpTh4e9wgG12OoTSM6YiC9Tpfff5kKTFP1lKx/pRpRXUbZixQ6dIbmCsXgE9WIG
 NF3hx/2S9smw==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="169143427"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="169143427"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 23:26:41 -0800
IronPort-SDR: m5wQRxRIl3mfIxkFDNX/D7HkGTgFZIN+tJsbZXcfdjSp6gSCX6GzCK4Ho4xzRe7ld9HtESfKU4
 PwX2P+O+BFcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="470689304"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2020 23:26:41 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Nov 2020 23:26:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Nov 2020 23:26:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Nov 2020 23:26:40 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 2 Nov 2020 23:26:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kgmee0U4yfD8SC/0jh3MiWg+J6AXyVThL/tjYYNiUPfskEKG/yi7xK03jjEQRR+eowRO4ypIUkgiHbvBdSpti2l/7zdJC4nSmomq0WpTiSfd1sQLf+uvp9bBz+4ilrZP4ic3r6FFpM4z8qi5+b8QFnSvFTHJ8F+tsJhwJxc58bl3RyFaGYMpZgPkMw7Es/lMNIpl7u/OgLuUDLxGubacxE54LhgnqReeFOpfO4ZlezZtjDWuMoouOpcXrupD6M2Z5HPJuFmFhb2uOXiGdhudpH5tTdoEeWRQpSJprao/4CvLESd1rrIBKadHUF0+xJJPcyqjwTUbUI+J/a/n9og20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwePT54+Kn0x27DJkEHSeoJ1tFAyrG9QN86fl8MmioA=;
 b=dPlF8yuaqNQg1EPJSq+EswOONbO9MdwpGxD9AqHJYiDJYtUkFTsmarsf8TpB7j9jkCG3kOYRtGmVYXtYAliz/KJqgpfUECVteX/APxNxsjc+D4InUqORZz45aNepkx2mWnvUgd2C5OIVAq1u5/MXbKr2gXTjIREFfvxybFsiCAGQqQGmtx3FTk/mm6GUSKynZKmQxxy4Wo0YL/3T2iBHxzeB6qXfgyVsemnOx5Q2F8BNJA4KqdYuFIx0S2zimvJl0XmyOuIVk0aFOi3DBLj/3G11sYK3hU+13vekQbZ4qYoQ+sWF6T3eNbu1u0oBos6R0T2+ac0H6JsPE27jCeHpsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwePT54+Kn0x27DJkEHSeoJ1tFAyrG9QN86fl8MmioA=;
 b=AfQRXJ/bSm7OdjbxIV6fQDCxWxIjBPVhl31nC1wyHMAGeS5ZZyHbybYN9TaN+qgNqitklfyoYufPzSI1iM/zDMx5MzIqP7IFuFqLL9YBq9KZQ09vIznXMHMwC7IibIQ+WHtmE66ZXnPSaaU3Z6WSlAatzG7olSwDFvoxfQcyml0=
Received: from MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19)
 by MWHPR11MB2032.namprd11.prod.outlook.com (2603:10b6:300:2b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 07:26:29 +0000
Received: from MW3PR11MB4602.namprd11.prod.outlook.com
 ([fe80::bdcb:d6f1:1f39:9448]) by MW3PR11MB4602.namprd11.prod.outlook.com
 ([fe80::bdcb:d6f1:1f39:9448%8]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 07:26:29 +0000
From:   "Karlsson, Magnus" <magnus.karlsson@intel.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
CC:     bpf <bpf@vger.kernel.org>
Subject: RE: potential NULL deref in xsk_socket__delete
Thread-Topic: potential NULL deref in xsk_socket__delete
Thread-Index: AQHWsX2D9flKHWLwc062gw5MD0yM6am2Ae+w
Date:   Tue, 3 Nov 2020 07:26:29 +0000
Message-ID: <MW3PR11MB46026E28B751169349B3F4E1F7110@MW3PR11MB4602.namprd11.prod.outlook.com>
References: <CAEf4Bzb3OThNBAMHfk6KGEgoiknLNZay1wRHWWo=5Pb2CY6dYA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb3OThNBAMHfk6KGEgoiknLNZay1wRHWWo=5Pb2CY6dYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTUwZDc2OTgtY2IxZC00ODUwLWJiNWItYTAyYjQyN2MwY2Q2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidTAxUXc3REJmOEgzUjhVbElPVXlndmtmaCtTVXdlTGk1cmVtUnNjY0dWUGIyN21vb3ZPb3ZUeTBpcFliTUVKeiJ9
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-ctpclassification: CTP_NT
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [46.59.47.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24d2ef1a-6920-455e-a55f-08d87fc9c84d
x-ms-traffictypediagnostic: MWHPR11MB2032:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB203228250A2F0472B7485200F7110@MWHPR11MB2032.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TRqSUIMgrLVeVCCMDpQ2hcu0RuaqqRYYFynV9yzVkRt4v/j4D+FDMnqrBLoWmkDOlJNT9c3ZYUTblKALc/Pu25eOUleid60jShHs8e4fT58BoxsS6Qp8n8WTf39Dsi+9klwjVFSKE+vBpvG93E5OdjQaMdQfPCDTZN1aYkV8oNsxhivMirMtl1KaqVKjsV0J1RYaV27l9QOgeqaF6T61yUUujWefKUMaR9eK3+7b6KmIZseV+bPg5Hcwu1ptFv3KMub2mZAbq9jFyD987IJIxIhuKyuKooLg5tACp5GVRxgwmxnm9pi0nBRj3GfMw92YWzF08/wZWvAbFm2o3AZFxNCy4weHOV0wggjwPth277qf+nwJ79pe9P7c/y5d6MnZ+eKFhZSIV+mqC0XpSem+3/kzrfHAW7fdwf98eGq2Iq03tRS7oxCFrSJ3y9/a3i6rx9t3+NEPcOmMwTOsssV1vQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(186003)(53546011)(2906002)(55016002)(26005)(52536014)(83380400001)(9686003)(71200400001)(7696005)(6506007)(478600001)(66476007)(66556008)(66446008)(64756008)(5660300002)(6636002)(86362001)(66946007)(8676002)(33656002)(966005)(4744005)(316002)(76116006)(110136005)(8936002)(4326008)(101420200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MgDhxCF6kt2fgyXJr6MTpG/ixsLT6P89BHK0x6Pk20qdmA7ZiViOREfIOwcuF1XHz96z9gQ1paa4+jfD160y9mG38LlBoCOiahkRE9zdTnDj88gz5LEA+QlgGbp1Mp+kXyMWERxCKsa/rGCXl4I+Hg66JhrvwCPn3p7haQyP09KrjchjHcwmnhB1zOmEIzqLHp00HgBIVTu9JPMqm1YT6A2P23jklmA3ti+F+zceXpMujpJufrEzPxt1ME+8t4ZXBAbxu6G0dQeO+rl/06FtA0jKd0eAOewk83WlyRzjr8mJb5KJNIFjG2vg4UL539yzbblrfjpV9boZNBhDA0oFFX6DeC4SbGZo0U3n4YNBd1kbUFtt22FX6719+mCBZJEGJcpo19rxqTpEBfx2ICrTTPKO4HRjB8oiJaGLCnwXPwX4JgrAKNIJ+gtfrPAW+UQLHSaEvL4LII/7uL/XoaDMpsxZNnqubWnE9FEW/rEJFW7VyUrAwC/0nhPHhJg4okQ29xh3fVnixp5l86f59aELcbLLftEaCTHz/u+pb0W0NVHHAnm3XMEezvI3p8dkzITF+T/U358PjvJGapVfJR5TLca+ED0k+vnL5Na2da7qoqFVgp3XQqoX33+b0zBR8WfMfOBmn6klyO1P+BKedCXjfA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d2ef1a-6920-455e-a55f-08d87fc9c84d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 07:26:29.7047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: od+ll8dv8Zmcl3NxW0Bln/tQ/nFL3WJKGh2f03ghH2tJD8yifyOADrZ7kXISSD/ZBNHLCht/AwbgVP8xdZp6QAm9uTbXowGoXrEyg32VHdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2032
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyaWkgTmFrcnlpa28gPGFu
ZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDMsIDIw
MjAgMjowNiBBTQ0KPiBUbzogVG9wZWwsIEJqb3JuIDxiam9ybi50b3BlbEBpbnRlbC5jb20+OyBL
YXJsc3NvbiwgTWFnbnVzDQo+IDxtYWdudXMua2FybHNzb25AaW50ZWwuY29tPg0KPiBDYzogYnBm
IDxicGZAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBwb3RlbnRpYWwgTlVMTCBkZXJlZiBp
biB4c2tfc29ja2V0X19kZWxldGUNCj4gDQo+IEhleSBNYWdudXMsIEJqb3JuLA0KPiANCj4gQ292
ZXJpdHkgZm91bmQgKFswXSkgYSBwb3RlbnRpYWwgaXNzdWUgd2l0aCBOVUxMIGRlcmVmIGluIHhz
a19zb2NrZXRfX2RlbGV0ZS4NCj4gQ291bGQgeW91IGd1eXMgY2hlY2sgYW5kIHNlbmQgYSBmaXg/
IFRoYW5rcyENCg0KVGhhbmtzIEFuZHJpaS4gSSB3aWxsIHRha2UgYSBsb29rIGF0IGl0Lg0KDQov
TWFnbnVzDQoNCj4gICBbMF0NCj4gaHR0cHM6Ly9zY2FuMy5jb3Zlcml0eS5jb20vcmVwb3J0cy5o
dG0jdjQwNTQ3L3AxMTkwMy9maWxlSW5zdGFuY2VJZD00MzA3DQo+IDgxOTImZGVmZWN0SW5zdGFu
Y2VJZD0xMDM2NzgyMSZtZXJnZWREZWZlY3RJZD0yOTg4MDANCj4gDQo+IC0tIEFuZHJpaQ0K
