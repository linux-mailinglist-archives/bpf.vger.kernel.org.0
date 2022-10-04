Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253155F4702
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 17:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJDP5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJDP46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 11:56:58 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11023017.outbound.protection.outlook.com [52.101.64.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C562716A
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 08:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOCsU7P2Unac3NyDJHsQ5SBDN4VjbvaBibuDjIRevyjSi4BsAoXp2fYLl7TaKFJsWRIPhgs5CdYDSRFETNba0DenOTd8tslCtz/34e8u2xBsDY28Xz+UBTp2pFT+1mp/uTPa1Vk1NZSbxwobAADE9bDpivOzyMFAE9x9WFw1xXdOsapgcUfCE3JkZxZr1RIXOimhKmDzwBWMMNLvs6/fbjpGdjZWCk7etUDEAsKt7wupIIV3c06a4zwXeSsmAshV1ZIPgoZmu9IlfUOenDkebTooWCOJcoUg74P+OFaDSBJ4ZJaekR9cL2Yk/7QT0Jl4/Pf+829W6KiaOuJfXuu1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UByFT1AWEzrFINU7VLtKCdm5KOjiIJhJfgE8iSDAnLE=;
 b=a9jYDk1eUr22jPT0BOqPU8llyAQcBFIZqdwp/c9Q2priBH2qGMuhk8c0ue1BjfZIUayGHdv5ofRzlkCQhket3hHJ/YOZITMv/o71JMp7P3mW2zYJdIW5UqrI4+x7OpYy2GDNp+WTj5hpSc0ui2eVR0io+dBxuyBvUT11tClKOvAxSbHJWRzwyTb4qgGyiY5FLN/E2uR63a7P2HPz6Zr5itXDuQNlRiPEdrUcrUW7D0CXOVasjImQ9XlDWK4Ct1QFwa447VOawGicTfFqV9k0E3rbrIQdza9Y0SOHtvwtA3prTSdtp3nijdqLVd82CxeqEM8WfbU7HFiJNygn66lBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UByFT1AWEzrFINU7VLtKCdm5KOjiIJhJfgE8iSDAnLE=;
 b=e3ZN+3rvN8nDAfWzwcIYzcWxHP0n2q0FIjXRQmIQVDXn2/zpbjk82HbER2nDiF3aN7Skpzx+PRgCwURv4+jKPOMl4v6PXGjls/4S00xiK2XBHxqIpq+8fnHD9lH8EVOG2f3XYoaW438mJgoC2mHnaXwdJW1qUAXLUaxcd4Y3B+U=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 SJ0PR21MB2023.namprd21.prod.outlook.com (2603:10b6:a03:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.9; Tue, 4 Oct
 2022 15:56:54 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5723.008; Tue, 4 Oct 2022
 15:56:54 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 11/15] ebpf-docs: Improve English readability
Thread-Topic: [PATCH 11/15] ebpf-docs: Improve English readability
Thread-Index: AQHY0qNqv++jE8+E60q227lL8nNlGa34j0YAgAXGAWCAABQHAIAABHbQgAAAhPA=
Date:   Tue, 4 Oct 2022 15:56:54 +0000
Message-ID: <DM4PR21MB3440986863D2893E382BDD02A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-11-dthaler1968@googlemail.com>
 <20220930221624.mqjrzmdxc6etkadm@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440664B3010ECDDCF9731D1A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQJQvdN2Dm7pwMno59EhMB6XT35RLMY4+w_xhauJ0sdtAQ@mail.gmail.com>
 <DM4PR21MB3440DF39304851D5F6108039A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB3440DF39304851D5F6108039A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e6f77def-86ea-4754-830f-5f08c7388d6d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-04T15:54:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|SJ0PR21MB2023:EE_
x-ms-office365-filtering-correlation-id: 601aba70-1a1a-4847-3e69-08daa6210f6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gUR+OjeZuhH1W65Yjk18DC4jmFm/mEnS6WP2N48xzCSu+CFVamhi0jUO3+13C0401+ttTZEuSaGTCVfXGjdcNyDMP17eWLDTRShAFSy/WvA/xNlk4nkW0smV8XX+h92AuaHz0iT/rL2BSSQJbhK710l3wedaL6lsvSAUCLzqb1d7Q4LTPVCJCo41+WyxtZludWmBZ2OSUFsIj2ZwHt5JROU9XMI/Eb9MGDRAO/lMGXdlUkD8k5HeWVmSQ/rNwZJQTpyznd+kd1+swvrbCRYWRns5SEnUO0SIYDBhAEcCsFpe0pJ3ej1X1sg7CjuIEZ30m0S9Mc4CFYxlUnnjCoRdjWG30zvh6XqXyedkA38qD5TY+QkWb9UwqYALkr8rzfDvIdkUA/VK+2vsMU0FpkS5fGBp31fdspDhuGx3uspXxbobyKGstoSDSW+BXZI6DXgsyv1kCXFHrGNPLZPVW0uAI7XpLFJcJ5l9F+vGVqz0NZOvj1mJloSNFSCRIlcx3RbCMjM6ijqNQTrnBLjy3n9jE1uSeAW3RjzKnDKAdUCz2tCsN6gCiBH0wsbi42Pr8Y5zQDikQDw/wR1VCkYOnnknyizBFLhZLGpdl5Z/xSneWeDYNZN4A1tlolYO/+U1s1ZB5gK+TI2IE8v+uwJY8qjEO8sP2k3RAS7Cj0MzGVivs2JULs89hqPi2FI8ybzj4U6T0XdPfDh3/HNQu1m68Xt+i4OxTTlg+5nRLhePq4aDnUUhat3fMgiOJMmxW5Wy9BnF2OmLxf/az7vssDt3mFpHDH+261EughPnDZz4NEQUTQ+HWWmOR324HcTy2y/+6cc5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(66476007)(64756008)(66556008)(8990500004)(66446008)(82950400001)(66946007)(38070700005)(4326008)(55016003)(8676002)(82960400001)(76116006)(6916009)(38100700002)(316002)(122000001)(53546011)(26005)(33656002)(9686003)(6506007)(2940100002)(186003)(7696005)(10290500003)(83380400001)(478600001)(86362001)(71200400001)(8936002)(4744005)(52536014)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUVqREVPRG5PSFR0WVMvZytqcVMrNC9GMjR5dElxcjNNR3RGTVdwY1JJcUEr?=
 =?utf-8?B?a2VKd2xhMkl6ckNsL05mYVdlVGh2emhBWmUwai81NVIwQ3ExbnROZmY2SUpp?=
 =?utf-8?B?dVFZYjRnZThiVWlEVDNkeUxrOUtCWS9oWVZOcG1zU1FWQUVLNE9JbWlPWTR2?=
 =?utf-8?B?MERrSUVDN1ZheDY3bzFtNDc1WmhsOHZEdnBUL29rWW00cHZ4SDBFbzZxeCtJ?=
 =?utf-8?B?RTh4Tmgxa2t6UXdQTXNReHJXd2owQ0hMdHErMFQ0UjVzY3ZEa25OcXB6S0x3?=
 =?utf-8?B?RjhFZENDMFdUVkpVMVlrSjUxMVpjdnVEaXdjNEtMQkk0WXhjRFpVc3hwTm4v?=
 =?utf-8?B?SXNPZm5EUDIwcnF1dlJqbXZDb3lxR1BWSmFtVHRVYU4xcVh5ZytZUmZwcVJ1?=
 =?utf-8?B?TXZYYVhhYmVjbzJUeHVQeDY5VytvVDVEK3E3QUEyeENad0pUWkhDN0xWdEpC?=
 =?utf-8?B?UG1CVlZWL1pXTk5jbFVkZHpjZUFBNlEwSDE4bnh0RHlPOWhrU24wbXlZRXFv?=
 =?utf-8?B?TFZZN0c4d0pHZUdKTlkwYlh2eXAwdTY5c3QxSmxzQjRVa25yQ244UkptZWc4?=
 =?utf-8?B?QVFadXg4RDVYZC9kYVdPU1UrSmJPenpGK2diSDhqSWVRUVorMng1dC9aQU5X?=
 =?utf-8?B?SzNqZWxPVDhOZjdPSVZVdkRiMW5aYlMxK1owUFh2NkNDVmVyVUNNL0NsRyt0?=
 =?utf-8?B?dlF4TXZuUFo3cFFwSzY3WjdjQyszelpOS2pHM1ZuQ1ZZUHV1T0RlUCtEK1Bh?=
 =?utf-8?B?dk5ZUVA1b202T3NXU3A0eUFQODFod2h0QlVTcFpQQS9PQS8xcEt4N1dpV0Zi?=
 =?utf-8?B?WU1EbExpZ1hzcU8yQXpaU0U0RHRGcGJMVzNyd3Z4ZmxZNTB4azNUY2JXcWxa?=
 =?utf-8?B?MVp1bXY1aTY0djR5bGJsa3lLM0M5dXdxZ2ZvTWZTaWxUOFlzYnpOclAxYUl2?=
 =?utf-8?B?MkNnOFdhVktvdlZUOVI4Y2ZCTXloZlV2QUg2RzFuSTBxRWRJNTEyZ3pOLzdC?=
 =?utf-8?B?anVYck1IU0dCSkNkdU9ieTBqNk5NNzlyMmE2VDcveVBTMGd5SzJrRG80SDFM?=
 =?utf-8?B?VmNtUkltdlFxSWtVK0RoQ1h6T3VBRmJCaGFteFlQakNwS2src3lQREIybU1p?=
 =?utf-8?B?KzRxcGo5NTM3dU4yWjNZTzlWa2NtaTlZdVZIeThzb3NxMWRtZHZUNjVMVTcy?=
 =?utf-8?B?eXk4eXA5WDU5UlFRMGpNOGxtTjVBa3VwV3NaWWdidjdiUmdEUkx2MlkwZWIr?=
 =?utf-8?B?TVNRdktNRDdCWTdTUEs0L2ZTUXl6VzVRQ0VYL3QxeWZsY3M0VkgvSUtqYStV?=
 =?utf-8?B?aDB4UDdOelFlaUF0QVFEQnVqazBQNm9LZ3p1dnFLN3d6aUlNMW5qUXlBSCt3?=
 =?utf-8?B?Rkp3ZEYyZ0UzSG0zZkFpV1JBeVBOUFZRdm43VzBaTmlRbUJpYS9FeGVqTzN1?=
 =?utf-8?B?MnpnZ3hxNnFwdVFPTHFqKzhvT2t1ZjlGWGNwSFprY21UZ1Y4cml3a2FZSnNY?=
 =?utf-8?B?MFBNazd5TXhzdWkyWDM2angvN0YxYndJNnFMRTJuYlZkdXYvWWJIZnNXTVFK?=
 =?utf-8?B?M1pEUmROY1F0RnIxelpuSjJubWJSR2g2K25ZQWh6U0l6L1AvMVdoN3l0RWw1?=
 =?utf-8?B?cEx4MmNXZGNwZWx4ZG1MR2czMyt0ek9vRHgrSFFSaWdCd3c1dW1BYXFZZGlZ?=
 =?utf-8?B?b2lOM0ZRbXlTdWZVZ3R6M3ZhekI0b2RSMll4VVcvWldrVlF2MzZsQ2RpQWN3?=
 =?utf-8?B?MkdQZVVRWnduZzFudzZMVUU3TDdxMnp2MTcvbGF5K09oUkFVODkvajhxekds?=
 =?utf-8?B?aXNLQi9FQWtRMlJISkw2S2psNTJ6ZXoycGU1M1F1OHh0UDBrbGNPblRkMlRI?=
 =?utf-8?B?anZBSisrYmI1ZEJLMzRxcklOVXdtSEMrdWFTMU51ZWNzWmVHUk50WmxYYUt5?=
 =?utf-8?B?M21MdjFxVkZGMk9CeTd2WWh6d2FZb3ZzQ2pLdjRqa0k2b2FSRTg2ZzhHVVY1?=
 =?utf-8?B?aTlhbGhFMFI0NisrV2pRQXJKallXWnRockVxQkJZN2xRdzZQdGhPelpqS3I5?=
 =?utf-8?B?eU5hQXI3aithQ09vMWsybWFZenUzdDRDLzhiZXU1b2VUQk53T1RvUENTVlJQ?=
 =?utf-8?B?b2xibUpEMW1iaDNmMktSOEFkYWFoWWRqV2wrcllPNS8wNTBGbmdGeW5yWi94?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601aba70-1a1a-4847-3e69-08daa6210f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 15:56:54.8474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYjE4e5ZmOvMdJXohmG5o8PKWrC33uoEXXa1aHAzLAw/r1NElYG/P9M7J0pWCvHgsJdTHCbUweYwOjtGQ+aFlQ6zl64z8ugnTufB/rnvHBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2023
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QWxzbyB3b3J0aCBub3RpbmcgdGhhdCBRdWVudGluIGhhcyBhIHNjcmlwdCB0aGF0IEkgYmVsaWV2
ZSBwYXJzZXMgdGhlIGFwcGVuZGl4DQphbmQgdXNlcyBpdCB0byBnZW5lcmF0ZSBhIHZhbGlkYXRv
ciBmb3IgZWJwZiBwcm9ncmFtcy4gIChXaGljaCBhbHNvDQpoZWxwcyB2YWxpZGF0ZSB0aGUgYXBw
ZW5kaXgpLg0KDQpEYXZlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
RGF2ZSBUaGFsZXINCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciA0LCAyMDIyIDg6NTUgQU0NCj4g
VG86ICdBbGV4ZWkgU3Rhcm92b2l0b3YnIDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPg0K
PiBDYzogYnBmQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDExLzE1XSBl
YnBmLWRvY3M6IEltcHJvdmUgRW5nbGlzaCByZWFkYWJpbGl0eQ0KPiANCj4gPiA+IEkgZm91bmQg
aXQgdmVyeSBoZWxwZnVsIGluIHZlcmlmeWluZyB0aGF0IHRoZSBBcHBlbmRpeCB0YWJsZSB3YXMN
Cj4gPiA+IGNvcnJlY3QsIGFuZCBwcm92aWRpbmcgYSBjb3JyZWxhdGlvbiB0byB0aGUgdGV4dCBo
ZXJlIHRoYXQgc2hvd3MgdGhlDQo+ID4gPiBjb25zdHJ1Y3Rpb24gb2YgdGhlIHZhbHVlLiAgU28g
SSdkIGxpa2UgdG8ga2VlcCB0aGVtLg0KPiA+DQo+ID4gSSB0aGluayB0aGF0IG1lYW5zIHRoYXQg
dGhlIGFwcGVuZGl4IHRhYmxlIHNob3VsZG4ndCBiZSB0aGVyZSBlaXRoZXIuDQo+ID4gSSdkIGxp
a2UgdG8gYXZvaWQgYm90aC4NCj4gDQo+IEkndmUgaGVhcmQgZnJvbSBtdWx0aXBsZSBwZW9wbGUg
d2l0aCBkaWZmZXJlbnQgYWZmaWxpYXRpb25zIHRoYXQgdGhlIGFwcGVuZGl4DQo+IGlzIHRoZSBt
b3N0IHVzZWZ1bCBwYXJ0IG9mIHRoZSBkb2N1bWVudCwgYW5kIHdoYXQgdGhleSB3YW50ZWQgdG8g
c2VlDQo+IGFkZGVkLiAgU28gSSBhZGRlZCBieSBwb3B1bGFyIHJlcXVlc3QuDQo+IA0KPiBEYXZl
DQoNCg==
