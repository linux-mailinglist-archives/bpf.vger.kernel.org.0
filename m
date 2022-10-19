Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD793604FCF
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJSSk2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 14:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJSSk1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 14:40:27 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2100.outbound.protection.outlook.com [40.107.212.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467F317C54B
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E76tZuAQgi1lNPQYrJcilOZdrWUOZgf/kybMphss4sPvR3KSzjX5SgZ0KaJn4mVldDjo3xVJE1oFSkyxWrjm0dBJG7zXaauvnMYXYLXgzFB0UMtXgcvIaZFMmUT2Of9+I26RXMMIgxc98gcO2c57UBb6+ui+gHUmJAVZ+c9e5Kk29DrAMD7Bjl69Z3YA7+ET8RC8824qqThAP5H4qXGG/U2/zvePjt6omQ5QHEFbbCzdYVFIEe7IUY+Z4tNlvV1kyhKxjfJHSTEiGzHzEULrXEVaJJN1IMH4RxyMcypavY10+lhr7E5DzZmYl0xLV/6w27PYkhdcDkVHfiPweXHGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHhSlz1mEQlk9yhFpcmg2OFkCvVTU2/eWNHHTTr9wCw=;
 b=L3s2Ny+BJ7aRTXL01GqW/Kn3F6iiBOtleXg/rKHQCLv/OVV98Qbs4NlfWSRqa4WgHa/7xWLQRVNfLDNRcBJUA5sxT+w6+rVRgihR2GmnjebNhUDI6JqIV6bEx337iKXpMoEJstwZjKK1vZRrJp8MwKnX0HH0xMpKXs3ExDUVfwVA9WGzHRniEJo/fQSBjuqWNHXXuqbovuU62bQt3D+t6utsFNXeoL90MnmlWic0M+XGtItYsNQL8ROdy2TKuah2hFh6j2mGKl0bXrHuSPORnbNKlpPHtef+kTiAVoKCjpcUw6bsTtCKSM18ATZzSZp3kM/xCJdJlp0KM2L9HMTiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHhSlz1mEQlk9yhFpcmg2OFkCvVTU2/eWNHHTTr9wCw=;
 b=esJ5/rRFqQlHwVHu4vyW7Yvx/dTELJLuSE6gbjphjV+Vz7jU8qMjhqB7WudpXNSg5F0FDV/ROWf94HxebOYhUc2+VeDr1TxlCeKQo3AIb5/iz0bu9zHnbsU3AY9df7UZP/ya43mhxN656eelm5rs1IUmqYzvvkAqlme9cySY0tU=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 MN2PR21MB1408.namprd21.prod.outlook.com (2603:10b6:208:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.15; Wed, 19 Oct
 2022 18:40:24 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2%2]) with mapi id 15.20.5746.006; Wed, 19 Oct 2022
 18:40:23 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
Subject: RE: [PATCH 1/9] bpf, docs: Add note about type convention
Thread-Topic: [PATCH 1/9] bpf, docs: Add note about type convention
Thread-Index: AQHY2ENV7HAf/RJQsUmx4FEyPcI2aK4TIJkQgAARMACAABpQgIAAB+mAgALPoVA=
Date:   Wed, 19 Oct 2022 18:40:23 +0000
Message-ID: <DM4PR21MB3440302D7B1D8587E8C5E360A32B9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20221004224745.1430-1-dthaler1968@googlemail.com>
 <DM4PR21MB3440B73030D09B1F09082807A3299@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20221017214104.rtle5zdwnipqhwvb@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440DA99F6621F50845E0A07A3299@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQK7ofN_8CJuiRY4RFjmawiTEUbzs5m0orgiN1NeUi_Mnw@mail.gmail.com>
In-Reply-To: <CAADnVQK7ofN_8CJuiRY4RFjmawiTEUbzs5m0orgiN1NeUi_Mnw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7d2fcacc-5fdb-4395-b8d4-2611a82e8de6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-19T18:39:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|MN2PR21MB1408:EE_
x-ms-office365-filtering-correlation-id: 8d1521c4-969e-43da-92da-08dab20161bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eih3iDx+4CHB2kLtwTjx64hZyKBVhkdTVOZTTOA5nhm61VNbk3NW46oOlsQL5W80p+mj9fzM06gvtg+4UXG1NVBRN1+EWOg3KdQScNJpdxOUoTbrdmqZQjBEx8OdsXMBAcvBw+us00IHmsdMdq59u/jlbddetr+xdzymWIqz87tJanzYtSEnzeVvGBlH/jcOwRAgdypJkRuAGrRiYh768SmPaApaaA5TxfLN/z4u0j9iAzHq5UnBmhp7rPZwBN1MqKBb0m6gHVI8wKPTvN/lVEQBEq9A9/XkB/h/I4//iSqwlsvqd4PkdFSnNZZDCtEHJAckZa2lZ9c2lvm9phH+wAgffo869BDnY7DsTa2FDygKUfShQ+627kTm6zL7EmlXGvPDs7WxJBmhn+AkE6QokTYa2vERIRZ5IU1SVt+Y6VOpUVzhoYyi0S/oKgPlAwZsypHKRahOyPFyUVsthMLV1dlUY4pMAtLjr4wqzOmyoQ5pC5XbEysTHYLGUBdHVGsPvVYJmu3UIIl5TWD+qinNBIEvt5oYDgdQ5XayMuFKe4asmaUklwYGPdxQW+ZQQJS3+WMIWYJbUG7z8RlvSG/GiByXcmAOi9oSABi3CE+NaSrv1fBv5wLFw490YFzzasNIOm0gu4HJFxRXKJgaoIJMGpZOw1IW47s6q4BPrzG6dLJfusBEHsAPI9DdT75qbDgZCO5AHXL6rIuIxl8n2vWOPSV2Xqkbj49/cRY3v7yX9xdO6EWI3GBnNK5W/xN2KU6nh1ox1/vDWvt0f6ovaik2dDWuBL5oiW1CLk5xz+eQOHUTvAOx9+ViX9axLYAtJIim
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(54906003)(5660300002)(8936002)(41300700001)(8990500004)(2906002)(52536014)(86362001)(4326008)(64756008)(66446008)(76116006)(66946007)(8676002)(6506007)(122000001)(71200400001)(478600001)(10290500003)(33656002)(9686003)(6916009)(7696005)(558084003)(66556008)(38070700005)(316002)(66476007)(55016003)(38100700002)(26005)(186003)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eml0dThKc3lRSmVDdksrZFUydnR6WTl3T1h6RkE1RFU0bFlrSTc1b25WWTRO?=
 =?utf-8?B?RzFmNE9pVDM3MVVKRGgxeDdUaU9pUlRiQ1htellCMWpncTBlcStqd1BCa0Y1?=
 =?utf-8?B?akVPckd2a2lxdjdSbTVFczc5bmlQM2pHeURlNXJsLytKR1lFdWFKNElNZW1S?=
 =?utf-8?B?ZmNyclIwY2M0RzZoN3lGN2hYVCt6TnZTQWNzMVFLV1JQMEExZ0Z0WldKdDZs?=
 =?utf-8?B?eVZwdERVYXpBRUltWk5jYkg3ZmRkOWoyWXhHK2prMkszZHpDZUZlRXd5dzRz?=
 =?utf-8?B?eExmSmRlMWpzTjVCV21jbnUvY2Z6aFlzRWVBejc5eStkU3pENWd6WVY1SGNF?=
 =?utf-8?B?aEN3MC9Bakg5OEpvM3ZPTHBZaS85VVgwZXZhT1NiL1RSOFRUWUNvbk1sdDhq?=
 =?utf-8?B?NExSVEJXcEJQREU3VUc3L0ROTXhLU09UV1EybURvQ3l4QTdMOHFRc1d4N2py?=
 =?utf-8?B?eEhpcndHMmxqbjNWZ1VmVXNGd1FiY1ExVlRxS3NLdTlGd2FUK2tYejIzSWJk?=
 =?utf-8?B?TzhzWWhSZ2IwbGV0ODc3YW9VV3hORThtMGRRb1hCSlJGbHdQaUNFTmNrZUR1?=
 =?utf-8?B?cXNLdG5lNUlHeXVEeW5JOTM0L2pMNjRLZGtmR08rZGxGWGJwdWZwS1J3R1Va?=
 =?utf-8?B?Y3VxU0hKbVF1eEVUQWd2VldNQXVuU2VyUlF4MXBpblRNSW1jMHR6Q2ZNYjNF?=
 =?utf-8?B?a3JZZkpsaENRaHNPZHEzWDJlWis3VE4zOGZIQVFyTEVzS05oOGdEeEFYcTRv?=
 =?utf-8?B?Qm9tK0FtbGxpQmVteVM5K1d6VUVlSU1ncE5TaWp3dGcrMXpta3BhUlBJRkhK?=
 =?utf-8?B?MW5DVlROVXF6MFkrbWxpbW5GdmNiZzdFdFFiOXRMWkZ6WEExVlJoZWh5UEls?=
 =?utf-8?B?WEVzQ1BKNHNhaGlISUU2SU4yVk5KVzRUcW91aTkxaXV5Y29henVaK1VIM3NN?=
 =?utf-8?B?NTRSTGdObGxLT3pabWlIWFNNNEcwenRyT2xFOTgydVZaL21LMGpMaGlmaHZU?=
 =?utf-8?B?RGs2MWxjblNEemc1aHNHWE5JUi9aYzNSVW5Ob21BMkVxeXFvKzNvR2JNVG9G?=
 =?utf-8?B?ZVg4M2hXQkJWeVRqSU8xdm05dGZTOFZZN3g3cGJ1K2FkckEwVFlLRnNjQXYz?=
 =?utf-8?B?ZEJyZ05qNm5meWxNRlRPOFM4OWhxcVEyRUVGU3pVUmJBTmhsV2FxR2l0bjF2?=
 =?utf-8?B?RmVQMExicW04dW5FOUZmcjFjTDhMcisyVlBBM2xGTFJlcTF3aG9zWkF2YVVt?=
 =?utf-8?B?VjYxbm9md2N5SXNYd1doQUtqRm94UVdxM2RhVUVpTUhlYjdLTG1WR2haa2lZ?=
 =?utf-8?B?Nmk5cHRRSjExQ29hUU90RS9BK0FqKzFHMTkrUjNoSVMzQTJUNkxzM0JBV0NU?=
 =?utf-8?B?a0ZMUU9yRG9uNWRnK2FaempIanQ2cTYvTVNNeUZjTXJDZGhFOTFONExZTkFE?=
 =?utf-8?B?Z1JHOTBDRlcveU9tZDBvQzY4TnFnOUlLVERZcGY2Sko3NTVtYS9zaXlteHRt?=
 =?utf-8?B?T3hjWDlBamcvaFA4dEIwSmMwTkxmK3hWQ1E4Z0ltUUsweUoyMlRpa2JKc0l0?=
 =?utf-8?B?Qnp6d21XUmNQbEFMdUxCQ2g5eVF2cDA5QjU3bVFnNXJ5ak5QN3AvUVNkbTYx?=
 =?utf-8?B?MXVUN0NpcDNXZ1ZGNTJ3WHY2YXhsdWxvSjBRRkFxWGZtWGVXa3NKOW1FRGht?=
 =?utf-8?B?Z3NhVmpVRVNldWJURVRkenBGK0haVzFNaC9qZTByN0NCWWpJek1GRzRsMWIw?=
 =?utf-8?B?NFlOWWU3MUJhZlZaRGlDTFBHVWlvNDl0MnBuL0FMZUhON3hNMHlFTFNKR01a?=
 =?utf-8?B?enh6UldmYzJCRDIyakRIcUxjenRySWg3WVNmS0xpdVBEeXBwU215c3VXOG1l?=
 =?utf-8?B?b1dPVHk5ZXZlWjlCbTFIT0drWm5keFpNdnpYNXRNbnBzemcxS0gyQXNabjB1?=
 =?utf-8?B?OWtiT2lSWlk2eHRIdTZFYXhyUXc4RzFoc3E0QkpWSzQ0WFZoQklxKzVlbFFn?=
 =?utf-8?B?NzBGVGZvZTNucXBWaWxZb3IzamxROHIxUFl0S2hYc2F5K2Nua3F1NFhETlBy?=
 =?utf-8?B?bGwwYkhRL3JuazhUTnBFd3lJK3dNQmtnYXR6RmJkYWdDUDlxSjM5TG1iWjRx?=
 =?utf-8?B?NDFQZ2U4TEwraStkRHY5N0U2SHZYS2E2SWlRUmdtL0p1WjFCeFRuTjU4eXg2?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1521c4-969e-43da-92da-08dab20161bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 18:40:23.0559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrVZIpl6fBvH1NIBdT2iTGTF6nTGGqF7WXpIGBdyRsK7jNeAOe796lFxm1wBttksU3J5Z5Fpm3xWXX+oyKoMLgnaVMHodbbWb7i7fLqBRYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1408
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToN
ClsuLi5dDQo+ID4gQW55IGNvbW1lbnRzIG9uIHBhdGNoZXMgMS00IG9yIGFyZSB0aGV5IGFsbCBn
b29kIG5vdz8NCj4gDQo+IERvbid0IGtub3cuIFNpbmNlIHRoZXkncmUgbm90IGluIHBhdGNod29y
ayBhbnltb3JlIG5vIG9uZSBpcyBsb29raW5nIGF0DQo+IHRoZW0uIEp1c3QgcmVzZW5kLg0KDQpS
ZXNlbnQgcGF0Y2hlcyAxLTQuDQoNCkRhdmUNCg==
