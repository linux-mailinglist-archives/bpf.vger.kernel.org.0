Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55068607DF9
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 19:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJUR4O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 13:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJUR4N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 13:56:13 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11020017.outbound.protection.outlook.com [40.93.198.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C00263F2B
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 10:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CubXaCFfkzm9n/41MVaKSgxJY1Ybaa8bdmZdd6vHWc5eY7Hle0Nsuei0swXj3jK0xzWuFyelE0R5hZP8cEoCMfOOq1XS84XE9ak4YpNOu8Ave4csmq0cZWzmQaF/SYZlxTfRWSnejHyebvnqZNQS+Rczvmuy1FDzgsZlknoI4yjCGyD8xtpkAf6JiEfat1njJtH03Qo+dZXZAGC7Z8CqBmuZvueRyPg9pZRzyXigY8w3jPGzdgT9k0kWbg/UZydg0CJu/iphkVkFnS468wNi+B0RBNCnBl+Xs1U4eL29UYwez+tEAuDqYJvHpYlV5NbY3CyxVvGvyo/SuKcyktNViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suuNh4OCo2CAG9ejpDGYR/F6XLhBF8TLkWOocSc0W6E=;
 b=Xi/YZSBpwyCZEgLle1VPxN97vcAsn/CaQzIYpfDkG9PdTxBE33LeAPFJSOiKKjNDcxQ5TFHK3jBH50TJsPtStfUC3RWy/XlotseFhQKy2y3NvWtmnX+LJy+6J/GGgftJoPe4PXwmx4pXXqiCV072abbVB2nBGwSiyl0b41yI32iYvlzyMH1KfnCB4r3wVcjmkjcJZ+1YHxWpUcCZCmPNstejNREjTU0c2dAdba3bWySmaSpHb8r6sWUPJ7H0CE4coIDOzXpDmAlrPZon02Oq5aP+r6xO7Wy7F2KkaTlssVgUDEq25+LBQ1e42ckkIx8b3EwKK0JFa3gcUSpVjjEG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suuNh4OCo2CAG9ejpDGYR/F6XLhBF8TLkWOocSc0W6E=;
 b=eiou5IjW1Edc3wkQc70wCh+OWbONHoH3ki+oKt4Sh+1AO0kb4EnndlPUhre5hfEy5YpatEK99rUiGfUPl6LhjCiWFTaiE5/4DEQc03WMu9ImOYa4f3O0oaTyqneZKs+XLPGHcUhcP0DS2UWId4Yk65I0umRfHdtLk1/FPo3npKs=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 PH0PR21MB3027.namprd21.prod.outlook.com (2603:10b6:510:d2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.6; Fri, 21 Oct 2022 17:56:08 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2%2]) with mapi id 15.20.5746.006; Fri, 21 Oct 2022
 17:56:08 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
CC:     "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 3/4] bpf, docs: Use consistent names for the same field
Thread-Topic: [PATCH 3/4] bpf, docs: Use consistent names for the same field
Thread-Index: AQHY4+oRxc9QaZzI/0a6dc/gqciqz64WMviAgAABliCAACodgIAAARoAgAK7gVA=
Date:   Fri, 21 Oct 2022 17:56:08 +0000
Message-ID: <DM4PR21MB344040829C9EAD2B159CAF3BA32D9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20221019183845.905-1-dthaler1968@googlemail.com>
 <20221019183845.905-3-dthaler1968@googlemail.com>
 <Y1BkuZKW7nCUrbx/@google.com>
 <DM4PR21MB3440ED1A4A026F13F73358C3A32B9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAKH8qBterhU-FM52t8ZukUUD3WkUhhNLSFq1y2zD7geq4TYO6g@mail.gmail.com>
 <CAADnVQ+8AtZWAOeeWG5REvW2nW7bw20aZpfHxUjERnqMSHGRiw@mail.gmail.com>
In-Reply-To: <CAADnVQ+8AtZWAOeeWG5REvW2nW7bw20aZpfHxUjERnqMSHGRiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e5e05045-03e0-480d-b109-bc6ae117ec25;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-21T17:21:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|PH0PR21MB3027:EE_
x-ms-office365-filtering-correlation-id: e4465af2-b6e0-4286-a98c-08dab38d8887
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ikUUJjjEUYAUJZcwh0/HY6pJlVqxfl9h7HrvRFqUjQFuP83tiPvcxTykHmS3ugD44XrBfQHOB0ROwGJssVKRut8sbUWUOAtkYPKzDq8rjdmG+l0qaBHjuYrGD5V3U9B3m6tN4ypjY2lzqRQcxqdBsz8a1CFGsIxuUpUp+9Mt0nYl+0zFLieCSDBGasZNOXUIMWk31A5XHbI9iCPhsj+bJLfaFqPBggIXOyUgRRzB2L/oCqC7Db/96F/BzoUTWbl0U+S8iOAuUVbdJ4JE5H1X0Ol3lUiRTQHjDSYelrcH4/s1+cd2zEhxgMZQANxdXalXS9XATrIZ6M+qeqo/MNmsFsgGH89cDS3AXbvrG1MRigQrV/oGaIlHc2Ov6hTTmhx8CxllcGxfLI6Xo9lKJenGA4SPwiAa6K7sA23KGVtGR2QqI71MN5IZM+REmsPTKYgLlfowPs75OefgA7ooXbnL8G+v2KU/Ryo6GnisXAtHTdyM3z/jh8XfwsVlEEioeLzOOD4DyMugb2CNjrflfvWNSnOQ5/ulgF2A91HOUWmCdnJycm449Glc9fblBNusOr6VeLow5p2U/D8z9lNd+N8YWJ1h8ZpYE/h6zqdSDsD8XkFrjhHeKclnR8rdEvttXUxn4PXfJJ5oKdI3wdFqBELkOLB+VKnuBv8G6o08eCccucrRJzc3HoBMIQRrDyGDrR8oK69LQfLEEEl+jDWgY31brLgPv+AEDLPku6lX8/JN61Mi+C/A2qcbNzz33PFJn/ZCCpna9fievArmu6KQaAhp6NtJ6nCKau/8+W7veLyrE9dHDsFji+YyPsKNzUyzEhLyJAMzRVPta4Wv9XGXaCRwOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(33656002)(2906002)(38070700005)(82960400001)(122000001)(5660300002)(71200400001)(82950400001)(4326008)(110136005)(186003)(38100700002)(54906003)(8936002)(26005)(6506007)(966005)(9686003)(53546011)(7696005)(316002)(76116006)(66556008)(66446008)(55016003)(478600001)(66476007)(66946007)(86362001)(10290500003)(64756008)(52536014)(8676002)(41300700001)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REdQeTZ5MXk2MXZyTnAzWXA2TDI0QW16V2RLdzBMQTNkTUg4MjBXS3VKWW9E?=
 =?utf-8?B?ZnlGRFNsZXNpL01CRWtsOVhUd2doY1lGak5JZ0pPTVY1K3BqS25wMDRWSDRI?=
 =?utf-8?B?bkN0N3p6UjhVTnVVdndkVTUwRmFiSWM1ajlnSVdVRDVQY1lxbXBkUFZyYlBs?=
 =?utf-8?B?eC8vVFY4YmIzQ0o5bGNuZlZadW1lRGRmSkp5Sk5WQnlkbkpVMzVvVGY2S3F5?=
 =?utf-8?B?KzVBdWxZS29idVpIaTJYd2JMdHJhZ1JUeWF6dVFQM25KaVJwTXNNdSs5WVZG?=
 =?utf-8?B?NnQvbmNuazRERHFmdWZjTjRiZzVpeXAyVFQ1T0lIaEhXT0xRUXZONG00OWhP?=
 =?utf-8?B?ZDZmdy9WeHQrS3FRMjJyWVNaNVlDZjQ2MmVGVlZHQ21YUGpGU0p0QU1kQ2c2?=
 =?utf-8?B?MmtST1RKd1ErZUxCTXJvbEErNW54RnVnSlNpaTNlOEIxcEdDaGdDbjgvdEhU?=
 =?utf-8?B?QWNBTjVnMHlwT2xLQWxOWWVlWjFjSDZTem5CYXBjUy8xSmlST3ZXOHQ3c21t?=
 =?utf-8?B?aGFSVWMxOG5hUktDSWl4dmdPeVJaVFY3UUY4YVVUd3JFTVozMmtLRmdsWDlk?=
 =?utf-8?B?dmYvRnpHU2JqSkpRazM5Q2M1aDhPVmR1ZEhxK1JLc3diaUowZUxEWkc5bjhm?=
 =?utf-8?B?eWYrQjBJTzBTdytsejlDd1FBNGNwTkhtWmZXUnVETS9xS2JsL1hKd2tNWk5H?=
 =?utf-8?B?aU95S0FYaEVCUDl0U2dqV1pBeVQvdWw3WndJUnpKSDlaZnVQV3B4cVZUNk1J?=
 =?utf-8?B?V3puZTM5RzdCVFpncVVwVW1IQ0lLNVAxM1owOEdETkJrZGFwU0FMbldONHBi?=
 =?utf-8?B?OHZsaGx4aFBnY0hRR1dycXBHajBqTVZLSkx2TmJObzdGWmg1N3ZsVXdqVzBZ?=
 =?utf-8?B?MzdYRGJBOGExbGt1Zjd2aHI0MVgxQjFuYjFFdlZFdE1VaDBMRFRHcStUVW5w?=
 =?utf-8?B?bVdCTitVOGtpbGQra1V2eGpPOUtNNEJwSGdQM2hGZnV6M0dWZnIvb1BQajVN?=
 =?utf-8?B?VUdHZDB6NndHeWFHTDhHZk4vT3NMaDlhUSs0UkNoS1pMVUZmQ0NQL0JEUkx3?=
 =?utf-8?B?RXVaT2lBT012SGtqYUZNd2VCTSsxcTBENWFCMmdnT0JUdFFmc2pTL3ZSaHJI?=
 =?utf-8?B?cTNyZGZXelVZWDNOaUJBUy82eGpCS2IrcElSNDYralVnWlh6VkUrVWRPakgx?=
 =?utf-8?B?Q3FQanVqc2oxaFJpSUVmSXRlNzE0Z3N3dGNnMDFiTnJTNDJyRnRHWCsxazBQ?=
 =?utf-8?B?V00vdDU1d2FYZ0JKU1NScGNxbk5EMTR6RTVzcTJDT25SZThHSEpidmxvS0hm?=
 =?utf-8?B?Y1VkSStPVVFhYXQycFlvVmpxVVFNVjA1OW9pdWw0WnNPTzI0RGdheG8xVHBJ?=
 =?utf-8?B?cTh4aUVXNHl1REovUzVmcGUxbU02MTRIakNvMURkcmlISmd0dFVvcUFubkhW?=
 =?utf-8?B?ZUYybm9VRVRqUzNRMkRtSmE3emp3Mmx0dGRVUG4zNWZlMDFQY1ZTTWpWa09J?=
 =?utf-8?B?djR3NzFPTzQrc01KUng2dmtySjg3V2pIdW5kRk5xZ3VURk9mSm9IZHhuMzhK?=
 =?utf-8?B?Zit0YUQvUC9WT3FxS0VRc2dTSTFlUk1PTmczNXFmMXB5VE9UazZ2ZEtJWXJX?=
 =?utf-8?B?QVFBYXl3V2FGakgvRzBXOFFmV2phS3M0SlVQZHE0emM3R2diQzFoOGlFV3M0?=
 =?utf-8?B?Si9lTkkwdFlwYVo3NGN6UFRIZi9CclIvcjNrcjN0SUlyVThpendkOENjMVM0?=
 =?utf-8?B?czg0dGdZRHA4TkFnSVNORVZLWFovT0E4b3gxQ3lFRmdRaGRKL3orVCtkdjYx?=
 =?utf-8?B?RVhyZlcrYW1OVTFKd1VneUxjeENWQWlCWVcxR1Y5dGJMTlhJdkNWdWJMOW5C?=
 =?utf-8?B?SEg1Vlhsb1drdHRxd3BCazR6WFpwVW1ROW5wSjdhMm1WK1B2TC9JejUyZmZq?=
 =?utf-8?B?d05xVzJDMVVLdEErU05sVUJnNzBPbm50STNlcDNSMDdGaXdLSUxOM3RLc002?=
 =?utf-8?B?eHRSZXlVeXBibVZMdUlMSm5qYzYvczk4SVJxanBqWHpEN3RQVDg3ZDFGb01H?=
 =?utf-8?B?TUdoTVArOFI4aWZoMmJydHcxVkk0bmxPcXJTUzRPcU9KOHhCUWdhUUlxMWJz?=
 =?utf-8?B?eFEwc1NmcTFkOHQ5UTZ4OW4vM2JVWGdob0hoU3dVdURqMno3ZzNtdnU1STAx?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4465af2-b6e0-4286-a98c-08dab38d8887
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 17:56:08.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KyjtUlR8vrZ9ZPpxP0xEGGTQK9MIQ57/RILIxAbHz4GO/FPInRJvBBv+Ne5IEgCaeKyOfJtvLwqLk7EKvZQ6tVgxvbqk5WINjzSLd3xYoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB3027
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiBPbiBXZWQsIE9jdCAxOSwgMjAyMiBhdCA0OjM1IFBNIFN0YW5pc2xhdiBGb21pY2hldiA8c2Rm
QGdvb2dsZS5jb20+DQo+IHdyb3RlOg0KPiA+IE9uIFdlZCwgT2N0IDE5LCAyMDIyIGF0IDI6MDYg
UE0gRGF2ZSBUaGFsZXIgPGR0aGFsZXJAbWljcm9zb2Z0LmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0K
PiA+ID4gc2RmQGdvb2dsZS5jb20gd3JvdGU6DQo+ID4gPiA+ID4gICBgYEJQRl9BREQgfCBCUEZf
WCB8IEJQRl9BTFVgYCBtZWFuczo6DQo+ID4gPiA+DQo+ID4gPiA+ID4gLSAgZHN0X3JlZyA9ICh1
MzIpIGRzdF9yZWcgKyAodTMyKSBzcmNfcmVnOw0KPiA+ID4gPiA+ICsgIGRzdCA9ICh1MzIpIChk
c3QgKyBzcmMpDQo+ID4gPiA+DQo+ID4gPiA+IElJVUMsIGJ5IGdvaW5nIGZyb20gKHUzMikgKyAo
dTMyKSB0byAodTMyKSgpLCB3ZSB3YW50IHRvIHNpZ25hbA0KPiA+ID4gPiB0aGF0IHRoZSB2YWx1
ZSB3aWxsIGp1c3Qgd3JhcCBhcm91bmQ/DQo+ID4gPg0KPiA+ID4gUmlnaHQuICBJbiBwYXJ0aWN1
bGFyIHRoZSBvbGQgbGluZSBjb3VsZCBiZSBjb25mdXNpbmcgaWYgb25lDQo+ID4gPiBtaXNpbnRl
cnByZXRlZCBpdCBhcyBzYXlpbmcgdGhhdCB0aGUgYWRkaXRpb24gY291bGQgb3ZlcmZsb3cgaW50
byBhDQo+ID4gPiBoaWdoZXIgYml0LiAgVGhlIG5ldyBsaW5lIGlzIGludGVuZGVkIHRvIGJlIHVu
YW1iaWd1b3VzIHRoYXQgdGhlIHVwcGVyIDMyDQo+IGJpdHMgYXJlIDAuDQo+ID4gPg0KPiA+ID4g
PiBCdXQgaXNuJ3QgaXQgbW9yZSBjb25mdXNpbmcgbm93IGJlY2F1c2UgaXQncyB1bmNsZWFyIHdo
YXQgdGhlIHNpZ24NCj4gPiA+ID4gb2YgdGhlIGRzdC9zcmMgaXMgKHMzMiB2cyB1MzIpPw0KPiA+
ID4NCj4gPiA+IEFzIHN0YXRlZCB0aGUgdXBwZXIgMzIgYml0cyBoYXZlIHRvIGJlIDAsIGp1c3Qg
YXMgYW55IG90aGVyIHUzMiBhc3NpZ25tZW50Lg0KPiA+DQo+ID4gRG8gd2UgbWVudGlvbiBzb21l
d2hlcmUgYWJvdmUvYmVsb3cgdGhhdCB0aGUgb3BlcmFuZHMgYXJlIHVuc2lnbmVkPw0KPiA+IElP
Vywgd2hhdCBwcmV2ZW50cyBtZSBmcm9tIHJlYWRpbmcgdGhpcyBuZXcgZm9ybWF0IGFzIGZvbGxv
d3M/DQo+ID4NCj4gPiBkc3QgPSAodTMyKSAoKHMzMilkc3QgKyAoczMyKXNyYykNCj4gDQo+IFRo
ZSBkb2MgbWVudGlvbnMgaXQsIGJ1dCBJIGNvbXBsZXRlbHkgYWdyZWUgd2l0aCB5b3UuDQo+IFRo
ZSBvcmlnaW5hbCBsaW5lIHdhcyBiZXR0ZXIuDQo+IERhdmUsIHBsZWFzZSB1bmRvIHRoaXMgcGFy
dC4NCg0KTm90aGluZyBwcmV2ZW50cyB5b3UgZnJvbSByZWFkaW5nIHRoZSBuZXcgZm9ybWF0IGFz
DQogICAgZHN0ID0gKHUzMikgKChzMzIpZHN0ICsgKHMzMilzcmMpDQpiZWNhdXNlIHRoYXQgaW1w
bGVtZW50YXRpb24gd291bGRuJ3QgYmUgd3JvbmcuICANCg0KQmVsb3cgaXMgd2h5LCBwbGVhc2Ug
cG9pbnQgb3V0IGFueSBsb2dpYyBlcnJvcnMgaWYgeW91IHNlZSBhbnkuDQoNCk1hdGhlbWF0aWNh
bGx5LCBhbGwgb2YgdGhlIGZvbGxvd2luZyBoYXZlIGlkZW50aWNhbCByZXN1bHRzOg0KICAgIGRz
dCA9ICh1MzIpICgoczMyKWRzdCArIChzMzIpc3JjKQ0KICAgIGRzdCA9ICh1MzIpICgodTMyKWRz
dCArICh1MzIpc3JjKQ0KICAgIGRzdCA9ICh1MzIpICgoczMyKWRzdCArICh1MzIpc3JjKQ0KICAg
IGRzdCA9ICh1MzIpICgodTMyKWRzdCArIChzMzIpc3JjKQ0KDQp1MzIgYW5kIHMzMiwgb25jZSB5
b3UgYWxsb3cgb3ZlcmZsb3cvdW5kZXJmbG93IHRvIHdyYXAgd2l0aGluIDMyIGJpdHMsIGFyZQ0K
bWF0aGVtYXRpY2FsIHJpbmdzIChzZWUgaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvUmlu
Z18obWF0aGVtYXRpY3MpICkNCm1lYW5pbmcgdGhleSdyZSBhIGNpcmN1bGFyIHNwYWNlIHdoZXJl
IFgsIFggKyAyXjMyLCBhbmQgWCAtIDJeMzIgYXJlIGVxdWFsLg0KU28gKHMzMilzcmMgPT0gKHUz
MilzcmMgd2hlbiB0aGUgbW9zdCBzaWduaWZpY2FudCBiaXQgaXMgY2xlYXIsIGFuZA0KKHMzMilz
cmMgPT0gKHUzMilzcmMgLSAyXjMyIHdoZW4gdGhlIG1vc3Qgc2lnbmlmaWNhbnQgYml0IGlzIHNl
dC4NCg0KU28gdGhlIHNpZ24gb2YgdGhlIGFkZGl0aW9uIG9wZXJhbmRzIGRvZXMgbm90IG1hdHRl
ciBoZXJlLg0KV2hhdCBtYXR0ZXJzIGlzIHdoZXRoZXIgeW91IGRvIGFkZGl0aW9uIHdoZXJlIHRo
ZSByZXN1bHQgY2FuIGJlDQptb3JlIHRoYW4gMzIgYml0cyBvciBub3QsIHdoaWNoIGlzIHdoYXQg
dGhlIG5ldyBsaW5lIG1ha2VzIHVuYW1iaWd1b3VzDQphbmQgdGhlIG9sZCBsaW5lIGRpZCBub3Qu
DQoNClNwZWNpZmljYWxseSwgbm90aGluZyBwcmV2ZW50ZWQgbWlzLWludGVycHJldGluZyB0aGUg
b2xkIGxpbmUgYXMNCg0KdTY0IHRlbXAgPSAodTMyKWRzdDsNCnRlbXAgKz0gKHUzMilzcmM7DQpk
c3QgPSB0ZW1wOyANCg0Kd2hpY2ggd291bGQgZ2l2ZSB0aGUgd3JvbmcgYW5zd2VyIHNpbmNlIHRo
ZSB1cHBlciAzMi1iaXRzIG1pZ2h0IGJlIG5vbi16ZXJvLg0KDQp1NjQgdGVtcCA9IChzMzIpZHN0
Ow0KdGVtcCArPSAoczMyKXNyYzsNCmRzdCA9ICh1MzIpdGVtcDsNCg0KV291bGQgaG93ZXZlciBn
aXZlIHRoZSBjb3JyZWN0IGFuc3dlciwgc2FtZSBhcw0KDQp1NjQgdGVtcCA9ICh1MzIpZHN0Ow0K
dGVtcCArPSAodTMyKXNyYzsNCmRzdCA9ICh1MzIpdGVtcDsNCg0KQXMgc3VjaCwgSSBtYWludGFp
biB0aGUgb2xkIGxpbmUgd2FzIGJhZCBhbmQgdGhlIG5ldyBsaW5lIGlzIHN0aWxsIGdvb2QuDQpJ
ZiB5b3UgbGlrZSBJIGNhbiBleHBsaWNpdGx5IHNheQ0KICAgIGRzdCA9ICh1MzIpICgodTMyKWRz
dCArICh1MzIpc3JjKQ0KYnV0IGFzIG5vdGVkIGFib3ZlIHRoZSBvcGVyYW5kIHNpZ24gaXMgaXJy
ZWxldmFudCBvbmNlIHlvdSBjYXN0IHRoZSByZXN1bHQuDQoNCkxldCBtZSBrbm93IGlmIEknbSBt
aXNzaW5nIGFueXRoaW5nLg0KDQpEYXZlDQoNCg0KDQoNCg==
