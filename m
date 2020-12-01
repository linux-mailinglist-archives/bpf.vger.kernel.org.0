Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DED2C9581
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 04:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgLADDg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 22:03:36 -0500
Received: from mail-eopbgr1320074.outbound.protection.outlook.com ([40.107.132.74]:2784
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbgLADDg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Nov 2020 22:03:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCZCYb1jBpv/KY7TKAckDX0YT9jNdlsSnZHwSK96t6dUCKgqgtyRHaJ5/WrYjVqDe1NOm3O0sdS7c98US/DxwsVkK7z6FBAerZbTbLys8yGscH7cz872FHgsGofnoQ9xLFkhiTH4UJ8vx6W3ykjMYc/I1MFZZFkdNr3ggsPVwCRk+YZaUmk2VMUMUqwvoE/SDt5qGHTlbVNjboiOxK36v7i3BmqxX67EMb0dQkSnYBMtq7r98WJynUl7bMWyl/mQsccBxv9FaO5Opiz7WhjZLWPzDTpzn+DWBQ+kCPG53Ml3Tkny9whP6SswKPRTg8PIyklZxmtpVURCnr4xZkQAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl+iErc3fVgwWPp0a06KrO5RipMwUjAJ5vx5lXd9o8U=;
 b=TXDPKk/PHlfYkygokU7bFztk07kIWKaAx2EXbqChdGswaRnypZsWWVG1zz7aO7eoc54XItwIyFRmgBA/jTV2d5Ic9rXRJdsaDhIwdfrqqRyYnNJbFgFlY8HWBgSUntDw0uIlAmF9Z96CVgFQt9NQCq+fRQOdBw/wLGI6lcbQSo7+S40IPue7PqGIrsmxAt85/n8DabLPzUMkfHlkAd4eLyIzFx4bl7ocPTcg9KjZD6RC4rprzaGbGPcTOWMekxH/xUm4yH98WnnbO1Mhq1tOfC+uahmCDnl8V6pApTJCuysZY3E+fHHUKlVtwxksOoCawJ1b0GIZXSMFOg2qTurQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl+iErc3fVgwWPp0a06KrO5RipMwUjAJ5vx5lXd9o8U=;
 b=I0oWajdNEYM/wVA9F8y6Dg6UuwY06ivPNkga0m1ttpi/Ji/q/BaNLTo8jo5NKHAzx/6ycCc0R17a6pAbN0FWuDI/ZumIGgsWi9o89d71aq+UHR3cr5AmfP0p0PlqU0GwpI4VtD9X5c+UBki8kATAFXyjPNksgrlaZxQh9MrqJBA=
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HK0PR02MB2435.apcprd02.prod.outlook.com (2603:1096:203:1d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 03:02:02 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::b9b8:aaf4:2afd:218b]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::b9b8:aaf4:2afd:218b%3]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 03:02:02 +0000
From:   =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
To:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
Subject: [PATCH] tools/bpf: Return the appropriate error value
Thread-Topic: [PATCH] tools/bpf: Return the appropriate error value
Thread-Index: AdbHjjE+0VhjdcMtSGSpXeObkYLiYQ==
Date:   Tue, 1 Dec 2020 03:02:01 +0000
Message-ID: <HKAPR02MB429180E153A7547C20F17915E0F40@HKAPR02MB4291.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
x-originating-ip: [58.252.5.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3083d4ed-9339-4640-10ee-08d895a579f7
x-ms-traffictypediagnostic: HK0PR02MB2435:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR02MB243534957D3314BB36024FCBE0F40@HK0PR02MB2435.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rJMAWqQEV1M/wAM7/vFzB32lIjkc9PCVUpiP778OUpDw1AbwalRgHkzee+qXVMyGxMQ0hZGcKQnTtqK5JRDgUdPc9UoVy+PZkFZWVg5utDzs9XlDGKmllH0pbw9hQzPpgSRbuu/j6g8LI/acYWcSBI8jYDOuQfTsGFpWhBRiwMTzDlWsm7RTC8V7sWrNi+IC/oCYVUQzWJENGUokbogkDw6htYTduycfVkEiKbNhRvxlcYTP0yOatqdtBBbBthy2LL32V07ogO6/2tQjL06+IBS/HXVkHVwseOEasu5jwIKFT1XMaT0DdlHvuYoeDcb8i9T/rYPOT+vljw/x3OULEHhXcmfe1hlFxmH2ttSNQH4OcAMPlRpCEtkKTh/Neyxb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(8936002)(110136005)(52536014)(107886003)(4326008)(54906003)(33656002)(9686003)(55016002)(4744005)(316002)(71200400001)(478600001)(6506007)(2906002)(86362001)(85182001)(186003)(26005)(8676002)(66556008)(5660300002)(64756008)(66446008)(66476007)(7696005)(83380400001)(76116006)(66946007)(11606006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UHZzY0hMZ2lmRHNZUFp3Y2lrcG9aZ0orOTBTR2ZSSHQ1aEx1eFM1LzlmREVS?=
 =?utf-8?B?ZEo5Nk43Y01pL2pXVWFHMnhtSzRnZ3RJVSttZjRqL2Y3ckhUNCtOU2NKNnla?=
 =?utf-8?B?bklWbXNuNDdFclVqeVVZaHRlOHd1V29lUVIvOVVGdlQ5SVhNQUl3eTRvZnpN?=
 =?utf-8?B?VmMzZEROYk14SUV2YnJETy9ZUVBWOHNhZzh0bEF1LzdTTEc3RVNxVUI3cmla?=
 =?utf-8?B?K3M1QjFmOVBCZVFHeVZ2S2E2dk1oeHQ5ajVqSVhEdXVWSkRZR0NBd0ZwM3Ru?=
 =?utf-8?B?aEZ4VSt6WXEzOWh5aXFFUGdqektLNnkzNFRRbS9DUTRwb29HM3luOGduNGRO?=
 =?utf-8?B?YWFiaUxpU000TU9LZXdHSDdlRkk2TjdualVnYS9KTWRlcXZtSnIrVkRnQWo3?=
 =?utf-8?B?cndIbnMyWmtJdUxnaFk4VHVqK3dVYjZOZk5XTnlrUmxaSXAxTFVzaFpnNTVW?=
 =?utf-8?B?aUc5ZyszVWNXYXF0RTFDcmNKYzNSVnVCZ3VaejlHdXl2RFo3dTNXaVBmOUM3?=
 =?utf-8?B?YUxkY3ZIbU9iRHVHVGtRK0FyVitYM1pjVUlzVnJJaWFXRVh6KzYwelBpUk9i?=
 =?utf-8?B?cjNlODRycTJvWVZLb1BmTmhwN2RBazV6MXhJRS9WRnJqV3lzYWpFYlk2SnpR?=
 =?utf-8?B?bmxBV1ZnejdXR0gzZ240Q2ZONVI4RHEzWnVHMjZmSCswZUxCU0RxRGJrcXlo?=
 =?utf-8?B?NDdERUFPVzJWUWRySW5iYjdyNmNDdGw5Z0hIb3llYXIxdkhFTDVld2ZVd2RR?=
 =?utf-8?B?MHZwekgzejlCamR1YUgwWWVmMGIxQ1NmQ1dsOG1EVUFpWTRKOCtmWC91cU0r?=
 =?utf-8?B?Z0hTRzZtNXNZcURKWnZiQ3Qxd3hNeXo1Ym1RdlZUbzJUSEpLYlE1M29rNW1N?=
 =?utf-8?B?Y3d3QWNsVHdKaDBla1k3RC9ZS283V2lvNmcyNmYvMUZ5WTNrc2NZVUxZQUI5?=
 =?utf-8?B?NTNGazZvSzhYcEw4ZHJEQ08rMEJsK28zeDFpTGZSdGpYSXhHZE9RVVYxTVQ2?=
 =?utf-8?B?YjR0dTlham9hTWF6NzErbjJUdmxuR1h2eG40TEtWTE4wRTVVdEdYcjJxNlQr?=
 =?utf-8?B?SHk2NXpuOEhGSXpVQUx0ZUNsOVV3Q0ZBbmo0eDhxWHhLWHpXb050SVdIN3N2?=
 =?utf-8?B?Z0lDUHFKcnpqS1dtd0RCSjMrWS9LQnkvUlE4UWZMcWkrclAwY3pqR3dIbHNE?=
 =?utf-8?B?WHNDNWFWaUhxakl6Vmgxb1Q2a2JCWVhoVlRQMkM2bnRIM2xXdnF3Q2lWNnNm?=
 =?utf-8?B?TlhzQ2Y0ak5VV2wxc0lYSFRZb3o5TG51NmhHTVM3bmV3dk53eGdZUko3RUYw?=
 =?utf-8?Q?DFK/EKhNReuDA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4291.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3083d4ed-9339-4640-10ee-08d895a579f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 03:02:02.0446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUgFueCsMzNxRxaFzM59iZl6wz+KS+ftzUsMrJY5siL3fYTRDLnLqHwzfRskg4JFYAMzPxzAJmpC+klzHfw9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB2435
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Q29tcGlsZSB0aW1lcyBlcnJvcjoNCiJFcnJvcjogZmFpbGVkIHRvIGxvYWQgQlRGIGZyb20gL21u
dC9saW51eC92bWxpbnV4OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5Ii4NClRoaXMgZmlsZSAi
L21udC9saW51eC92bWxpbnV4IiBhY3R1YWxseSBleGlzdHMsIGJ1dCBvbmx5IGJlY2F1c2UgQ09O
RklHX0RFQlVHX0lORk9fQlRGDQppcyBub3QgY29uZmlndXJlZCB3aXRoIHRoaXMgZXJyb3IuDQoN
ClNpZ25lZC1vZmYtYnk6IFBlbmcgSGFvIDxyaWNoYXJkLnBlbmdAb3Bwby5jb20+DQotLS0NCiB0
b29scy9saWIvYnBmL2J0Zi5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9idGYuYyBiL3Rv
b2xzL2xpYi9icGYvYnRmLmMNCmluZGV4IDIzMWIwNzIwM2UzZC4uMjI4ZjUwOGZiZDA0IDEwMDY0
NA0KLS0tIGEvdG9vbHMvbGliL2JwZi9idGYuYw0KKysrIGIvdG9vbHMvbGliL2JwZi9idGYuYw0K
QEAgLTg2NSw3ICs4NjUsNyBAQCBzdHJ1Y3QgYnRmICpidGZfX3BhcnNlX2VsZihjb25zdCBjaGFy
ICpwYXRoLCBzdHJ1Y3QgYnRmX2V4dCAqKmJ0Zl9leHQpDQogICAgICAgIGVyciA9IDA7DQoNCiAg
ICAgICAgaWYgKCFidGZfZGF0YSkgew0KLSAgICAgICAgICAgICAgIGVyciA9IC1FTk9FTlQ7DQor
ICAgICAgICAgICAgICAgZXJyID0gLUVQUk9UTzsNCiAgICAgICAgICAgICAgICBnb3RvIGRvbmU7
DQogICAgICAgIH0NCiAgICAgICAgYnRmID0gYnRmX19uZXcoYnRmX2RhdGEtPmRfYnVmLCBidGZf
ZGF0YS0+ZF9zaXplKTsNCi0tDQoyLjE4LjQNCg==
