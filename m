Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15178694E95
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 19:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjBMSB3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 13:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjBMSB2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 13:01:28 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020026.outbound.protection.outlook.com [52.101.61.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8073116330
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 10:01:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJQgQRjRSy0DiCJ7+yLmIH50/pbSfhavHUQbiw741R20+Gnu4iYcCMbkNkv4rsNk80+Og4ze3/Sq+7pTkpbeamUFDnTPrhUa+EpmnAiU6goZcG6x1NMh6PhYK2LQoRsGV2BiWhLs1X9AouN6jbN7Imi1LfD6f/gUiW9GBp4bk9nOGiBUywLuzchzGDIUAEm5xgVQ2CwyXb9VMdgeGhnhRAb/zAgmS+VTwWS/HP7a4vyXNwWbxj8CqnZCQw92RBwQpenoVp3H9kSD3cTVDzWk1M562lamIF0tDF+Bm7E44gq+VE+lL2q1RGIgdtmhrnQuZLPwnXE+PSkXRzYKAGy3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D8ld2cFseTqMZ5jTe+qBSe39hR57XOlEJdxRehXjeY=;
 b=FfZzANA+cm9U15e5I3MThfH6jx6i3G8w2Ct8WiAF+FYVXj8mBiLhvVtySGWp/uuPcRYdnL/l2pkZUnE1TVIerjOEik1iJA9Fq2ABXougzRNQOBRx26hGDFXe/1hcWFC4Bmzgv6ZhuovUaq6w4A/3vntjFUzvmbwVg7qy/GyTwUzjfr2IlcDrLHA8ntymoTpG3WmBYLkbpTxeYz3vFWIPBr/e2JoxKtTucx7x7/XxUxnRRZZyz5s7z/5HuLyPCaXgFd5/M3VkcCv5rrZIUGGKfloUp0AdmMqPUqKkL7rwg+a5mepdDNKnj+aPnulM3fpo+tnPV0Dr9H0fuOsB6ZpyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D8ld2cFseTqMZ5jTe+qBSe39hR57XOlEJdxRehXjeY=;
 b=elSm2rnpdgTC02d/2hhf5d34DgwpF/wpr/a/QZmsezBOLmEmZdvcryYP/WSGdbdDt6MSvHsqn+D0oHHx4ndkQQPY7Ze1K8JHme2NyktYyPVdQK3PS0IKD+4JzQhZe15b5WGoAiAj0m/g9Zi8dDaDLDBQ8q+3EMj+f+WQXuPjc+I=
Received: from CH2PR21MB1430.namprd21.prod.outlook.com (2603:10b6:610:80::17)
 by PH7PR21MB3311.namprd21.prod.outlook.com (2603:10b6:510:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.1; Mon, 13 Feb
 2023 18:01:24 +0000
Received: from CH2PR21MB1430.namprd21.prod.outlook.com
 ([fe80::e545:f176:7f99:d103]) by CH2PR21MB1430.namprd21.prod.outlook.com
 ([fe80::e545:f176:7f99:d103%6]) with mapi id 15.20.6134.002; Mon, 13 Feb 2023
 18:01:24 +0000
From:   Alan Jowett <Alan.Jowett@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Proposal for patch - Extend bpftool prog run to accept cpu and flags
 options
Thread-Topic: Proposal for patch - Extend bpftool prog run to accept cpu and
 flags options
Thread-Index: Adk/1OCKl1f+Ad+XRFKnlmrR3XpApQ==
Date:   Mon, 13 Feb 2023 18:01:24 +0000
Message-ID: <CH2PR21MB14309C209861239DB568C3C1FADD9@CH2PR21MB1430.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a817af4c-763d-4738-93f0-836a49863d55;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-13T17:43:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR21MB1430:EE_|PH7PR21MB3311:EE_
x-ms-office365-filtering-correlation-id: fbafa771-6fd1-4175-1d93-08db0dec524e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkqahToPCyeXMxPWWv2eT0h3zeQ9VYUSJRWQoUDBjUuaANJLJhu8Qq+RxDgEwUw7vu9seh+dy4WAjDjDEf5cHOeQ0avKtMAHHuIPdGsxBbboxwf9I/xBo/Qo+COdaKs36bsVaHcGbRz7yBM5ud38uH6UgxjVBFMd/deaPfXd7JuhUxF9wlS6iLYzeMdOrjbVc+z6YOHyp/ELsAy/asq85RuwkblYxVxfVYqhqXdA9CmY6AyUefK3bw6HNLdRUGprHcAEsf/O0p5QOZ+HwD1JyAMlA/y/oK+3AndCoPr70aQj0oayAfPtok4RfwAMTeHeaKWxicYxzBmwwE0O0uv00DFvm4e9ByrAAfOmytO4UF/o8fEI4J52Y9dCEH01FigCZ1P95dZsu9zdik8n1fWrqivb+veR+0rJkMpYtEQ19/jc6DKfonZwDm1aOv11V4+cDsu4qs5pfJtoErRmsLGNAdQfIwIe+hGbe8hG2dj9fmXYG6LVP8ieNvm+dSIF20EtNMrIdA+1+LnXhNUi5Q7P3oA03bqN37GKMJKxUAFpFZkAEqMxOSGmc4F0q3DSpT70F8x7NYQVpqwmdz4XMl2A8IvCYVWs+KxwAsMSex8vCC6wBoGaiDU6MOaJi4Hoj2kw9QsozdKBZ8Sr0yMDEH/91gq4yE4+XXQAxbGXZbRL0nwJYG/GMAnL1DTmqVspVGmAokE63PZzI8yXJ0u+HKMkLbDBGc+gvNXAqPVlK27GfkNoZZJ2Q+BmzsjUS9qspD/5ylx1/yA2JvpTrTrbf8FNng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1430.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199018)(82950400001)(82960400001)(122000001)(38070700005)(38100700002)(41300700001)(33656002)(478600001)(2906002)(8990500004)(8936002)(6916009)(52536014)(86362001)(4744005)(5660300002)(64756008)(55016003)(66446008)(66556008)(26005)(6506007)(83380400001)(186003)(316002)(66476007)(76116006)(71200400001)(10290500003)(966005)(7696005)(66946007)(9686003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHNWL2diOE51VkptWEV1cVBpbEdYZzB1THdWcGFtZGw2MUNEM0s1bjU0YWZM?=
 =?utf-8?B?NFo2bUI3MnQ5ZkFLeC96NlFYdjg4bDRUcXN4WklZbWtzcHhUSlc0a1lhaXVM?=
 =?utf-8?B?cTFydkVCcFM4ajdNQ3lkcmpabVA2U081VmlQNEhMNFJnckpFU3dqaHYya0ha?=
 =?utf-8?B?N3BGdFd4N1ZOZ2hTTnh5OFR5WVRaZmRGWEVTdzduWnFjNmNNQXBNdnA2V1E4?=
 =?utf-8?B?Wk82c01oMEpicGtpWTNGc25ZRDN4TjZvZ0JUWnE0UGhPOFdNcStQSXZSdG9l?=
 =?utf-8?B?Yks1eTlmVXZ1dkFlcHdhWUM2UWppbkp5Ui84OWlDbXZoMXo0Ny9aeWZFVDFr?=
 =?utf-8?B?cTJ1TFdqUkkzaEs3T2dPNno2Q0dqaFVhbFhkZHRNdzJDdFo2RnQ3TTZOVUhu?=
 =?utf-8?B?VlhmZXU3MzJya3hlVUNqZzZOZDJhcTQ0WjVneUI4dVB2QVgrTVZDLzh4bm5M?=
 =?utf-8?B?dUtBWXBKSVplZFQva2Z2TVdnN256bUx0bzI4VHNmc0lPY25DRCs5b0pOeXg3?=
 =?utf-8?B?YTRHNkxBQ1pvWFZWREwyMlpuc2lFVHEzVkZOcFlyTlBScERJOHUvbXdjZWlW?=
 =?utf-8?B?RjA2cWpuallZdGQ2K2lWeW5aclRBcUJSdHBlNWJWZHVoanlHUzl4Z25yUUFp?=
 =?utf-8?B?QzRWc3NWR1IwdllUWEVtSXFRdEtOc0NPTjF5YjZsdFFkNEgrRlQzK3NmTklP?=
 =?utf-8?B?VFJkZ2dQZ3Q1QVhmSnJCcHBLbTd5amlRWlBub2NUalRDaDJPYzJIY3dISTBL?=
 =?utf-8?B?a2JvdDB3TmRGWFpKQXJpZE5vNlhydEIrNVNPL1k0UGpuQkpVNVNsMTIrM1ZV?=
 =?utf-8?B?c1BGWGgzVTFJOVR4Wk5SZEg2RFRDSjN0VFZ6cWFkZFdYTDA0Sm5ZYURYeEcr?=
 =?utf-8?B?MC9RUms3eG5zLzVPK3NEcTV0aFZJWUZFNVAySHNMVWNsRURRc2JLUUw2Tmc4?=
 =?utf-8?B?dkwzVGNqbUJRQ1dJQWNJL29jQmdCZVRueGl5V3lFNDhLeFk3czZUUVV3ZUph?=
 =?utf-8?B?ZHo0Um5Kc0VaZEQ0NnBYeElyUFRqYUg2ZFY2WXZDcCtJTDFzekFmcHdwWlMv?=
 =?utf-8?B?Q1FyWmdweUEwRkJqU0VNNU4wS2dTS09IRnJlNE5pYVNOVzk0cU51TlVaS0t4?=
 =?utf-8?B?MURIaWxkSU5CYlNDVURrc1NHd0FTTTRoTnB3Tm5FamwwTDljVG9PT0t1SmtV?=
 =?utf-8?B?NzNLR2lkT3Yvb3MrUzNPc3dEU0tvV2I5ZldXYnd1aFgwKzl1Q3R2MkhrS1J5?=
 =?utf-8?B?cVdXcVUzK0NHc2lCVkNMbUYrNGtaMmpJT0gxYmdjZXRxUkF4Qi9kVWNXak55?=
 =?utf-8?B?ZmJyNWxXaFFqWUEvb1lkRlZwVFJwVitVSE5kY2RrOWF3ZGcwa3lueHFUTlZC?=
 =?utf-8?B?V1ZEUy85WnMrdm91eDB1NklsU2RFajM5VzM3WlhUWktOREZ0b0lSTXBVNUJQ?=
 =?utf-8?B?azNDUXhuVEdXV3QxdklHbEx2dGdtYUdRT0Q5QlB2Mmg4K0NOYlg1RTRrejlq?=
 =?utf-8?B?MXZrWEJTdUxIMlBVemp0b21QYVBJb1FvT1JyeEZWcVkrSlVZOXZMSk5ESVp5?=
 =?utf-8?B?R243VENaQmIvRzZtdTlFSk1HQVN1NnNodTlmQzFtVmdkakZrdmZ6VnFSYno0?=
 =?utf-8?B?MTg1N1ZIQVdNa2tEMTRjNU1rb0xvQ255aUV4SW5ndGdXei9YcEduMzJBR2k2?=
 =?utf-8?B?UXVrRk5EbGNTTjBIMDQ5cWdnVTJ5T2xQUXJUVDhOeXo0RkZoQ0h1N2Y0V1Yv?=
 =?utf-8?B?SlEwWmh0YS84T1Y5TlBKVEtQZnNFOUl6bTZ1QXhJeWRUdjYyUEtzSnNydUFk?=
 =?utf-8?B?NkdBU1RkaC8xYjZtc0crYWpKb2R5bjRqL0tiK3JIU1FjcWZoZlo4SmNGdlhu?=
 =?utf-8?B?MHdvNU9YWHlKUUplRXk2Q2RTUCtHdmRwUHk0OFVhVDBXNTB2Z2NFTmVZQm9z?=
 =?utf-8?B?WkNJV1lxOEF0eGZqUVFwbERWVkdreDR0YVVxVCtWNzg3TlRkRkpSYlV6THBi?=
 =?utf-8?B?ZStuMC8xWGpvZklJNEhWNndiN3Y2amx5U0VOY2w1Smk0NnY3eGQvVUZNWVpY?=
 =?utf-8?B?RnloUzRCR1V6bmZQRzBNSldocnpielppSUw0RzVFVnhGNGJNNjM4d01TaTFS?=
 =?utf-8?Q?3n36Gw7gOXMeen/w+QEa8CPWW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1430.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbafa771-6fd1-4175-1d93-08db0dec524e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 18:01:24.7038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XfCLvyz6Lf4j/Xj+beMs0XwKgJSX/vFtOquc4BSho6S23z8td/mZID4+rHWLxOUQpRFi2PvUQw2NiakSv8nEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3311
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QlBGLA0KDQpUaGUgZXhpc3RpbmcgYnBmX3Rlc3RfcnVuX29wdHMgc3RydWN0dXJlIGV4cG9zZXMg
YWRkaXRpb25hbCBmaWVsZHMgaW5jbHVkaW5nICJmbGFncyIgYW5kICJjcHUiLiBJIHByb3Bvc2Ug
ZXh0ZW5kaW5nIHRoZSBicGZ0b29sIHByb2cgcnVuIHRvIGFjY2VwdCBvcHRpb25zIHNvIHNldCB0
aGVzZSBhZGRpdGlvbmFsIGZpZWxkcy4NCg0KVXNlIGNhc2U6DQpTb21lIEJQRiBwcm9ncmFtcyBh
Y2Nlc3Mgc3RhdGUgdGhhdCBpcyBwb3RlbnRpYWxseSBzaGFyZWQgYmV0d2VlbiBwcm9ncmFtcyBy
dW5uaW5nIG9uIGRpZmZlcmVudCBDUFVzLiBUaGlzIGNhbiBpbXBhY3QgdGhlIHBlcmZvcm1hbmNl
IG9mIGEgQlBGIHByb2dyYW0uIFRvIHBlcm1pdCB1c2VycyB0byBtb3JlIGFjY3VyYXRlbHkgYXNz
ZXNzIGhvdyB0aGVpciBCUEYgcHJvZ3JhbSB3aWxsIHBlcmZvcm0gd2hlbiBiZWluZyBpbnZva2Vk
IG9uIG11bHRpcGxlIENQVXMgaW4gcGFyYWxsZWwgSSBhbSBwcm9wb3NpbmcgYWRkaW5nIHRoZSBh
YmlsaXR5IGZvciBicGZ0b29sIHRvIHNldCB0aGUgY3B1IGZpZWxkIGluICBicGZfdGVzdF9ydW5f
b3B0cyBzdHJ1Y3Qgd2hlbiBjYWxsaW5nIHRoZSBzeXNjYWxsLg0KDQpJZiBubyBvbmUgZWxzZSBp
cyB3b3JraW5nIG9uIHRoaXMgb3IgdGhlcmUgYXJlIG5vIG9iamVjdGlvbnMsIEkgd2lsbCBzdWJt
aXQgYSBwYXRjaCB1c2luZyBicGYtbmV4dCBodHRwczovL2dpdGh1Yi5jb20veGRwLXByb2plY3Qv
YnBmLW5leHQvLg0KDQpSZWdhcmRzLA0KQWxhbiBKb3dldHQNCg==
