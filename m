Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5156051B7
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 23:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJSVG5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 17:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJSVGz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 17:06:55 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11022026.outbound.protection.outlook.com [40.93.200.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC091C711A
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 14:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1JAZI1u751suVsziwnktX/p4ShvXzWKZYWVdNEsjOSs9Ir166zlCZ3XNA0IBEKi/OFjrw+O6pC7jsrhkRV71EH+4yG38gOZXdXrs+pUT6LnQsLM0G5UFylUPlOhXkiHitmKOOfYLA8RPuLuI6rtOeMbo18+9lFNEWvP7PfDzHp5m7VT5pzVQkrsx/m4xsmUXlts4x2ZwEcT3M/kVChREhM8cSAeQ5kkADRZllOk4yt4YHYKLiuyTlgS+nCOQb1YhLN+wHvsf68xT/K4Vxl+BGaMjOboJiGeC02e20n2GrwsWPzgO7WJykg0IvMoCZfyanA2QtMpTBz965d+Bj4zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApyISPRZ6RTSIE+0VnL+uJRV45GmC1l81WrVY/jaJiI=;
 b=bCHaWyRbi7K80I7/IswTKPmj+Z6nOLr2yGFlE/pEH8RysTrsLf1ClAXmrFfVzACa/5lYQr+lZzqWXhoCnuzB8ZFdAQ0iYlxN6nAQDCpSUVMxC8XwvXwujqpfUmdT86Its5gViPKtrRMqy4oLZSjY4pW6q+Kqx6YXkVgOh92Khibq2MnAYWtVbrf+y/UxtHYsRltJ4QayvZchQUd44F1LGeKzT1pTtj/shXQdaNzMG9+An4AQGlGY8B2yX6Z8NUAUxmJu7O7JDmF/DkRVLT5rzzRNiFIakxjE0CzKKkjtybSTrT/aFjj3bagkiwYysik5cV2J2aNRdmfTaaeV3XyC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApyISPRZ6RTSIE+0VnL+uJRV45GmC1l81WrVY/jaJiI=;
 b=aZpO7k583nTznM9D0DUoY8wyRUD5sQvMPve0HgQfqMBVzyKFQB0V0WRjVeQGQyK/ljPfDSdW8eAHFHUFi60VuCbDeyKRwqmFPvgj/a7H7Ys5htEv8bJ/PeRGOqiVCiMUQB+1ZnqChbbRoZ0k1M1GSk0L0HejSSEYlXPCd4BXbGo=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 SA1PR21MB2018.namprd21.prod.outlook.com (2603:10b6:806:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.8; Wed, 19 Oct
 2022 21:06:52 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2%2]) with mapi id 15.20.5746.006; Wed, 19 Oct 2022
 21:06:52 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     "sdf@google.com" <sdf@google.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 3/4] bpf, docs: Use consistent names for the same field
Thread-Topic: [PATCH 3/4] bpf, docs: Use consistent names for the same field
Thread-Index: AQHY4+oRxc9QaZzI/0a6dc/gqciqz64WMviAgAABliA=
Date:   Wed, 19 Oct 2022 21:06:52 +0000
Message-ID: <DM4PR21MB3440ED1A4A026F13F73358C3A32B9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20221019183845.905-1-dthaler1968@googlemail.com>
 <20221019183845.905-3-dthaler1968@googlemail.com>
 <Y1BkuZKW7nCUrbx/@google.com>
In-Reply-To: <Y1BkuZKW7nCUrbx/@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c579541a-30a4-404e-9b73-1b414377b391;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-19T21:03:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|SA1PR21MB2018:EE_
x-ms-office365-filtering-correlation-id: e4016ea1-3256-4143-eda4-08dab215d8c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34KgGGUK5Yf5wLZcRbPWXBg/JSBiiAhQ6NE0KsR8xizb+4U3ncansqqcwf9aQnDzDk/9SsdklmbjC2OpVWnier70pDWmALrMcGnHIiPmme5VuqaxtE4Nv2b5gIq5s1gwR8Lnq4kzc9pu+0MlcKBWTTdAYY4IlWXSCj+1l1Jet8NJ1+P1ia2nxM/O3PYcXRRa2mabDQcdgwLNSesO4RiRp5U3GXueClLBXsetdNAiL1pxR+azopVVPTClQyM92OWdahhPoAAaZWn5EGEzWOZcT3rPPtXgcdng+Q73+Yzud3ZbQr0zO5Dsc/F6S35UfRVSlk2z4jvIfQvUcix2MkSYtxZuqly3m/61qbG32/3Lorel3bhA6hfogVyHnZaVUi52hGU8J+ggvo10+mqhcAudSNeQ9nDQ/fjSMolvtvHxciDBmOhFkbnGOMhX06FRorPnhomXX5C4bAqGRTB3pF2wmZwKiq6l08ikjNu5UZVCoVehumOFhx+aiBDYaFcW/sKwMUjXGJUVe7eTA9lYCCcXR1L90oRNYZPJ+EDkyzMv2wLemadK7uqGYmqfC8kCczLcaRFI57JetYPLOwZazYtAVxYj2zvmfXsehOzOjHeLKI9de/XxTgyM4RXQnk8hIJD2mr2l4OhGlsLZUvk+tcwmQGFzdiHLc6mWo9BOUXH2i0oDrRoI53UwrTRVaL6kVOlvLm3+omCZN5xWGowcypl3K5qV1OoYh6bsn29XoRlFlpQ4Z/UAtzDrzoQXd+ptihjEBmTnJ8WF/TKL9txDL40cafNjIMqRJDUADL/2S2etCiduDHWiAeAdys6EM6VB47wX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(4744005)(6506007)(5660300002)(7696005)(66556008)(38070700005)(8936002)(2906002)(52536014)(41300700001)(26005)(186003)(82950400001)(38100700002)(8990500004)(86362001)(33656002)(82960400001)(122000001)(55016003)(110136005)(316002)(4326008)(66946007)(10290500003)(9686003)(76116006)(64756008)(66476007)(66446008)(71200400001)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm42WHFxcXJtZVJRTnFBeUlBbzF6SzcrSWRrUGh5MThnMDg5QnlzbFpzZGhw?=
 =?utf-8?B?M3RvY0paUlVqVmVrVzJNN2xiRDhZNFhQQWJZYjNKSi9FdHFFZVJiN3g2QmRi?=
 =?utf-8?B?V0VQZ1NSVjljWXhMd0w3ZUtIaWl6V0I2VVRvZjhuaUlIeWgrSVJyTkxuMHds?=
 =?utf-8?B?TWRFVXhWUERXdGQ4c2ozQmJuK2tnQzlMYWdDSUNGRDRvR3NLUTd2LzVnUEhQ?=
 =?utf-8?B?M3o5elNSREhCL0IzRHhDQXVQY1Jsa3RWak5iRDVDYjlpa2VqYXpPdUViSGtP?=
 =?utf-8?B?ZUJHUUxlVnJDak1LZ2xHcytrOTVYWlRubTdnelN3eGtTTWJNc2hBUEljbDhu?=
 =?utf-8?B?YlcvS0lyZGRtYkR1TnpiS0NsRW9BZjJBdTgwSnpOMHUycXBDb3B4b0hoVFFv?=
 =?utf-8?B?RkVrWmt1MWpsdm1CWW03eUhRMzN0Um5iWlozWUZPUTBBVHZWbHc3ZFkrV3Jh?=
 =?utf-8?B?K09yZ2ZQMkdCU1YwekgrZXpuRG1SdElzeVdGR0VFN0FGa2ltd3VsS3JtYkh3?=
 =?utf-8?B?L3JkajlZK3dYbWkrc0JtQmhxU2RQSjdTR3BhSEl1RGdGU1hnZ2lYT3ZESWZm?=
 =?utf-8?B?VUIrbm1jWTgzb0tTTTBmdFdNNWlwQUwrVHJadU8wa1p0YTZmZS9obHBRQW1O?=
 =?utf-8?B?ZTYvZmhNT2UvaWhxK0NEVW5xSmZPaUQyd203N1J0M3lYNWlGdU1aK1RZeGlt?=
 =?utf-8?B?SGVROHdkVTRiVnBIQ2tlZlYybWQzTldhai9hZDg0aVZtUVQ4ODRlblJOWTVm?=
 =?utf-8?B?SkxEWXVRS3JNVDJ5Q1ZING5yRFFWVytQRzhsYzJOQysyWnFCK0ZmQ2x0YytQ?=
 =?utf-8?B?cUNFZFdzUVVBZk5yQkJ1Q2c3ZUVBVXh5Y0NvWE9CdTRMemxMU1RUcklrSSs4?=
 =?utf-8?B?dlJncm5wa3VlTE9kME9HOFRUM2JoQzRwWTNkN0x3aWxndUlJd0F2ZmIybVJF?=
 =?utf-8?B?ZmxlV1RBcmZvZjZheW1wbVNVT1VlS1djNkN1dUNEUThzN0lBWmhwOFIzdnVV?=
 =?utf-8?B?TDNZSjhGUXd3WW56NGtzOWxCMm0vOGJkeks5bVQ3NUw5SndZcE04SDI4cTli?=
 =?utf-8?B?cW5heENTQVhlRTJMQmpWcnhYM0k1WVRGOG9XQkdmZzQ4YU56VmJka0pCNWJO?=
 =?utf-8?B?Rzc4bFoyVURMenhXS1lzblNHVXNjMXdVMXRqSjY0SUN0OEk3OG9kbFdZbGI4?=
 =?utf-8?B?WG4wUTJVTUtJNnM5bk5RTEZRUGw1ajFONDhDdzVlREZTWHcvSGVyRlh5dWhy?=
 =?utf-8?B?NjdTRDlkT0VWenNOcGp1M0RWanBXeTlBdTF2TkN5QjVkWVFDVjNWblByTktO?=
 =?utf-8?B?YnAzc1FmN0RLRmhHMWx6QmNaa2VUQjY4ekxWT1c0YmZYSEdaY3AvanBIcGl0?=
 =?utf-8?B?TldpSWROVjNWWjJZeGJrbTIvb25pOFJtSGxzc0JTWnF4TlNjdlZPenRpZmJE?=
 =?utf-8?B?U1NEbndmOVJ6bXBLMkVZTy8reWJXbmYxb0pBL0RqcXlyOE1zREw4a0l0eWps?=
 =?utf-8?B?RzZoenhmd0ZmTGZvTzBhQnZJRVFhTTROWUx3amtNNVIvZlNsWVhta2NmeFRJ?=
 =?utf-8?B?SE1VR3llZkV3V3dacFJnSGJON2x1ZURRS2FuWEFwbVVuVjIwV0ZxaEdnTVlR?=
 =?utf-8?B?eWlvS1I1OWNKYW9QNU16emVhQ3F2QkVHUWNYUlN0aUx5N0U1VmxMNjZQQlo0?=
 =?utf-8?B?VFpEVWdsaXU2RVc4b25PeXVRWTZrSWx2aWRPTFd2NW9NWVI1SjRHLzhxUnpT?=
 =?utf-8?B?MlNaU1J2QUdZdmV3WC9KdmFsRzQ5STZsY0xUazlPaFNjQlJaY3pxZERSMG9F?=
 =?utf-8?B?TDJCWEJGRDlta2pINTMwSmd3WmZmeUpuanBZN1hXd3I1K3RGNFhOKzVvSUZU?=
 =?utf-8?B?SVgzSy9yay9jZm5TaEZNZ1locU1zZElCVHBrM2lyemlxNVdYajNwS0tGdXpt?=
 =?utf-8?B?eC9UYVNld1Z5TS9NM2lURUpzMWpsWmZRbXpNYUNVb0ZjdEJ6ZHVzRXY3eHU2?=
 =?utf-8?B?bFlTOUxkMGc0QkpYZHRLM21ha2RxajN2VVdQUXl3SURVTE5kSlMxT3k1ZTd2?=
 =?utf-8?B?U1N4Tk5kODdid0R4UnRwSVhNenBLdU14N3ozRDgyR0ZMTkZUdjc2LzRvdjgr?=
 =?utf-8?B?U3B3ak8vOGxYRFp6S1BXSmdZd2RyTmNCVDZpT3ZvZ1ZHUC9qb0UyRnMrNm94?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4016ea1-3256-4143-eda4-08dab215d8c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 21:06:52.6629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0m6Ge8IGEMomk/21VcAmMp7wGBRsHlg1SCJ3SKboNJlDP31yW9nxjHxKwpq74BxRRerMkTiaY2t6V8fSaATfwlR9YwyooSw7tPFY/bllyiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2018
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

c2RmQGdvb2dsZS5jb20gd3JvdGU6IA0KPiA+ICAgYGBCUEZfQUREIHwgQlBGX1ggfCBCUEZfQUxV
YGAgbWVhbnM6Og0KPiANCj4gPiAtICBkc3RfcmVnID0gKHUzMikgZHN0X3JlZyArICh1MzIpIHNy
Y19yZWc7DQo+ID4gKyAgZHN0ID0gKHUzMikgKGRzdCArIHNyYykNCj4gDQo+IElJVUMsIGJ5IGdv
aW5nIGZyb20gKHUzMikgKyAodTMyKSB0byAodTMyKSgpLCB3ZSB3YW50IHRvIHNpZ25hbCB0aGF0
IHRoZSB2YWx1ZQ0KPiB3aWxsIGp1c3Qgd3JhcCBhcm91bmQ/IA0KDQpSaWdodC4gIEluIHBhcnRp
Y3VsYXIgdGhlIG9sZCBsaW5lIGNvdWxkIGJlIGNvbmZ1c2luZyBpZiBvbmUgbWlzaW50ZXJwcmV0
ZWQgaXQgYXMNCnNheWluZyB0aGF0IHRoZSBhZGRpdGlvbiBjb3VsZCBvdmVyZmxvdyBpbnRvIGEg
aGlnaGVyIGJpdC4gIFRoZSBuZXcgbGluZSBpcyBpbnRlbmRlZA0KdG8gYmUgdW5hbWJpZ3VvdXMg
dGhhdCB0aGUgdXBwZXIgMzIgYml0cyBhcmUgMC4NCg0KPiBCdXQgaXNuJ3QgaXQgbW9yZSBjb25m
dXNpbmcgbm93IGJlY2F1c2UgaXQncyB1bmNsZWFyDQo+IHdoYXQgdGhlIHNpZ24gb2YgdGhlIGRz
dC9zcmMgaXMgKHMzMiB2cyB1MzIpPw0KDQpBcyBzdGF0ZWQgdGhlIHVwcGVyIDMyIGJpdHMgaGF2
ZSB0byBiZSAwLCBqdXN0IGFzIGFueSBvdGhlciB1MzIgYXNzaWdubWVudC4NCg0KPiBBbHNvLCB3
ZSBkbyBrZWVwICh1MzIpIF4gKHUzMikgZm9yIEJQRl9YT1IgYmVsb3cuLg0KDQpXZWxsIGZvciBY
T1IgaXQncyBlcXVpdmFsZW50IGVpdGhlciB3YXkgc28gZGlkbid0IG5lZWQgYSBjaGFuZ2UuDQoN
ClRoYW5rcyBmb3IgcmV2aWV3aW5nLA0KRGF2ZQ0KDQo=
