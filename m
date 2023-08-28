Return-Path: <bpf+bounces-8837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D77278B04A
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 14:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC191C20948
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B5511CB4;
	Mon, 28 Aug 2023 12:31:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82035613F
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 12:31:22 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3340C1A6;
	Mon, 28 Aug 2023 05:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezMAGQsTbBJqmyjNPwyAWJnit2zwxcWM+t6oPur5sEnE+AwEJyuLn4szI/UTLjT7AeuDykH0UZzv6ReywU3+BEXI9N2vBLWZklzlXplLzQFscACwzZnIpzyC1rP92GBwGDJRXZdMhvf8BESNNJuRgJiB3f4Bct9FSBGMbDKuJDNKfzr2FItw4DQUhKWa0PmtDwlKxp6XepaKtfcfe2RnUIcLMMvjhhNcv226XG6e+srGKNCM+GOkCqr7l0RDqKEozlNwQmBXTnwURe3EHC0dMajsvxFB+aDAafbd8/Y3g6LFxHb/sMWmhA+GqEUQW3oRIUyc5F0RibEjgZ9ZPuLEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEhhEN2axcljFGHRflPdsai4nYx+BLAasVqrU7g4eXQ=;
 b=QijWWk7yhvVKRjTN/B0zEBQ34Afq0KDbIMEmoUxWKc7/rt+M/x4LaAQUHtb3gWFSe0znyCILRWx9c5t1aoTFwfuplb5KeqF2EvKMzFGozye0DtmVyPF9tJMlOWK+VBLd7lCWulM8syhs9fnZTHS862dUhUyVKh2A5ZiqF6QyD19QYT4MSRZ7f1zxt0/6aR24YeE+/lNob1nA5cMcc1k8K5s9ClKZ0WWXtA1L45Yt+FQg+U9E5HO3uAHL6zjf5MedB41rwI0wCnIGc/R3UrnQofi9nLn3QuavoK06DZJX3PPxs6EhXUftPEqqVy4kYHsUONPYJqTQHXQGeit/1UkWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gdata.de; dmarc=pass action=none header.from=gdata.de;
 dkim=pass header.d=gdata.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=GDataSoftwareAG.onmicrosoft.com;
 s=selector2-GDataSoftwareAG-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEhhEN2axcljFGHRflPdsai4nYx+BLAasVqrU7g4eXQ=;
 b=ZY5cAtqb+IWtve3xDo6A15s6LSsqdymDWvWE1EbkTKiGlQZTzRXgcZYLlbfKbtcLV2iyWOzbzBHK6ikhYgk4FLXX6LiVLV46BBwHik1jftnace+oLCbnQQiz/BWKrK5mN4f/37hmyeqdJvpgipKzjeQZx3oxUdwNh3HcSOpRjKc=
Received: from AS8PR03MB9626.eurprd03.prod.outlook.com (2603:10a6:20b:5ee::7)
 by PAXPR03MB7548.eurprd03.prod.outlook.com (2603:10a6:102:1db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:30:45 +0000
Received: from AS8PR03MB9626.eurprd03.prod.outlook.com
 ([fe80::f76d:c42c:27b2:e75c]) by AS8PR03MB9626.eurprd03.prod.outlook.com
 ([fe80::f76d:c42c:27b2:e75c%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:30:45 +0000
From: =?utf-8?B?RnLDtmhsaW5nLCBNYXhpbWlsaWFu?= <Maximilian.Froehling@gdata.de>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, "Steven Rostedt (Google)"
	<rostedt@goodmis.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux BPF
	<bpf@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>
Subject: RE: bpf: bpf_probe_read_user_str() returns 0 for empty strings
Thread-Topic: bpf: bpf_probe_read_user_str() returns 0 for empty strings
Thread-Index: AQHZvQhvHQ03FgRWHEyZl1tV/PFVUq//2zyQ
Date: Mon, 28 Aug 2023 12:30:45 +0000
Message-ID:
 <AS8PR03MB9626D86E2025129C178927E2E5E0A@AS8PR03MB9626.eurprd03.prod.outlook.com>
References: <bba66a5f-3605-e36b-2bf3-f25a48307a46@gmail.com>
In-Reply-To: <bba66a5f-3605-e36b-2bf3-f25a48307a46@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gdata.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB9626:EE_|PAXPR03MB7548:EE_
x-ms-office365-filtering-correlation-id: b9969a8d-6474-4401-c5cf-08dba7c29a59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GAXw8Cq7zqDXJ/CnDaSFqgyP52g4TKUUwEfG0dRjGjzYyDauMUX3mRMu0HY23XaFsp+BM8nqFnVwz9JKoIr+xbuPUN+adBoAq4BBg+/ds0EQuOBGx+EXgZRgtp9kaT//hzfepbPXJ0a2HJZbPPyJMESX57sXbUdcWzH8OjQDDouX0SR/B9YObuJ7GiaCWFOHdGL1KAe3O3f3FqWve5SKh8IUY9p1FFEUEwdZj2bTqLjA3V2+pZVtkgm0iIRDcCB+JfUqtKDZtGdL7QjBpVRA0bzEpU0A47toUzkp4getrf+NYHbUMhpWcSZ1mEOesyBW0JOJ6nzinx2xuktrUbo9Gf9FokGZTsIFs7JnJjAzdySCQffX3rgy5Qgyu/YHp+piuvDuSVMQ9LnC1xvID0yxyam6g8FAEDCngIB44IpcpIU2KqhlanC75ZclBdfvqgP7wuUOmreN3ooCjGSU2VIuNSdrWFTnFLen3yJQnjb6BYqLLxEtuGygvCJw5dmsc5xVnJJHoPDIKSBM3PxLCYAjpKa29DlcL1sm210ptoEKinCOUmE/dhIKWkNgatCuTgDS/Wy7qmDM1Gwum+wL/1Fo6DrNAE3jpbVigeZ1CUdJDwSEXMNhHUJ8rfD+/M5OVo9H5D2m4jIh72Uc37/gGE9uPg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9626.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39850400004)(451199024)(1800799009)(186009)(1590799021)(1580799018)(71200400001)(6506007)(7696005)(9686003)(53546011)(966005)(83380400001)(478600001)(66556008)(64756008)(52536014)(316002)(54906003)(66446008)(8676002)(5660300002)(66946007)(76116006)(110136005)(2906002)(66476007)(8936002)(4326008)(85202003)(33656002)(85182001)(86362001)(41300700001)(55016003)(66574015)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXovQ0lTeS9HSzh0OTZDdXRNVlQ4Sk5pVDFoeDl0MnQ1Tk9aeDFnN2o5VEx5?=
 =?utf-8?B?Sk9rT1BPZXhNMVhsT3RyaFMwd01KckY5bmpOL3EwbGV3R1lOemtzb3phSG40?=
 =?utf-8?B?QStrN29FdkswTzE1RXMwWGtWZFQ5bTN4SVF5azZpTGNMaXlvaGRlSWZLRHU1?=
 =?utf-8?B?ZnNySmZaNEFhbkFIZ2ZFeDRvMGFaUGV6K0pGQ1EwZVA5OGdsdVNHeER0MVpF?=
 =?utf-8?B?TnZyUVVnTExpSmF1WEk5WEdBOXNDbk1Nc2hsR3NFbC9hSGdUUVI3T1Y5cy9T?=
 =?utf-8?B?aENDNURaUUpNS2pkZHNtNk5XQTJjaiszR251VFU4V0xFbHdnUGZnaUhZdVlP?=
 =?utf-8?B?NjNpc3hBaHJYcUNja3g1VkkzS2tqTGJMQjIvMW1JZDI0cTJySFNCNVp3YlFV?=
 =?utf-8?B?eThUQ2FBWWtaS1hnK2J0K09hVGRJNUFmRDBWWHhvL3RLbG54cGtJeStUWFhG?=
 =?utf-8?B?bVNVTkpjbDJNeWYvQnRmV2JnQUtkeHVkbzcwZEV3VytqR1JtdXZpY1RTbDY5?=
 =?utf-8?B?RitZR3pFYjhtQkRSRjBabTgxOGM0OUdzTUVaRWROZnZuWElqdWpUOUhITDBM?=
 =?utf-8?B?Z1VlNXVNZ2hETS9CT3FGMk9lQ2c4dktSMmtLMWc0dDVrSUdMc0FoQ1A3a1lK?=
 =?utf-8?B?Z2JrMWY4dVZ4ZS9GV3JEY2FuR1NjUDJ3eTQxd1FPVlBNZEJoMXlzU3NHVGw4?=
 =?utf-8?B?U3VnYjNmZ1hBcU41WFF0ay9BdXd6alZUMlcrVStWQVpEL3NGdmNkSGVqMklZ?=
 =?utf-8?B?NmE2Q2JteW9XczV6S1F0RU1VVEEzcUc5V20xQWUxaHh2RDY0cFBBR3YzdjNS?=
 =?utf-8?B?VWFuWjMraGg5K2ZUVXVraThlVG9zTzFjSEtXTWMvYXdWM3VTU2Z3d0ZzdHoz?=
 =?utf-8?B?U0FMdEJrZzRLQWVTcGZYR3kxWmZ0OE9DWk9HNzd4MVlsbk9MYktqRDE1enpi?=
 =?utf-8?B?Smd2UUNDUTJsZU1SZDlBdUZvdmk4SU5YZzg3TWE0d2VwWUVvb1JhSS9WTEhu?=
 =?utf-8?B?N3o4TUNiYlFhdEwrT2FHbzFPVE5tdmR1c2hvQmI5N0gxU1pwZXJtd3M4NjFI?=
 =?utf-8?B?WThYbk5RSWx0TGxGS0ZWSVhRVEI3cEU3YjR1Vk5vb2s1YjROcllMSmtzcmox?=
 =?utf-8?B?US9BNWdOeFQ1eTNadWkvUnNaRzh1WC9uV2EySTE3dnFhMFJkOWU2N0Zmd21r?=
 =?utf-8?B?YzBrSUpXRXZHR2pET3oyZzRXS0ZsaVZhb09iZGo3T09MNm9VVzZRQ011THJX?=
 =?utf-8?B?S1p4QzBPTGJpaFpEVnJpV2RpaWdhdE0ydDVTWFN5bGUwdUhWRWN1RmlDSWRO?=
 =?utf-8?B?NW1JQzJINHhzSzNkdnFWWkZybkdkV0MyRm9GcGNpNWhldFUxMEpTK3FZZUww?=
 =?utf-8?B?WXZ2UTJLbUtPMkdyb0lNQi92WFl4NFoxZEtqaXNtQnRPQUIzTlMxd2lpUHh1?=
 =?utf-8?B?alRJT2g0NTdPOGxGdVNOWHh2aHBaa2w3WTVzVktpb0srMEt5RlVDL2ZiczJ5?=
 =?utf-8?B?cWd1OXJ2bGxua2ZZTnBITElJcU9aOFhvWUxEQ2Z6Zk5NZk0zZjc5NXVkS0dU?=
 =?utf-8?B?OGpaUXlNMUN4TWQ5cXZQUS9WWDVsd29lZ1cxVk5ZT0ZLN0JvaVdMdjhmRkcv?=
 =?utf-8?B?Z1BjK1pQRUpTQW01STQzVStlOU5WWnhIcHJqYmZEWk4zWHhacjhpSHQvYVEx?=
 =?utf-8?B?MkZIekpnQy80S1lNLzZGM3N0RU1EY3ZDY204dTVCdFNJVlg1TU9nRTBKUEFt?=
 =?utf-8?B?TlpnQU93RXp0MG10K0JVai9YSC91Z1l2czBaTmpGVjV0bTZkUDJ2MkJvU25q?=
 =?utf-8?B?bzEyeFp5R2E1QlZ0eE5FVnQxb240ODJKaXJSam1VSUdBeFVVeWs5Nmo0cy9t?=
 =?utf-8?B?ZGs0L1E5Z25heTNJeGJaY04vWDNzTTd2eVdxdjRxeE1jQ1lLN1dQa01tMlE1?=
 =?utf-8?B?UFdZalNDb3cyNzJZQk5IbjRMR2xVU3N6NFlUTlNtSFB1MzJ5NlNWS2RZeklr?=
 =?utf-8?B?SE1iNys2ME81Q1U2Z203bUlDY205N2VkS24rR0F5OXJuTytCbyswaFZ3dzFh?=
 =?utf-8?B?TytRcU9FZVpCRm1SNHZHU0E0Rkp5cHpYTTR1NjZpYkVmRnV4aWNkcHJqWi9E?=
 =?utf-8?B?NWNlaDZVNVlJaDhVVU9FWTUxL3F1K09PTlRGZnJsTkYzaDVJTVFkMjgxeTlk?=
 =?utf-8?B?eFVjRnE0WkljSWdvRGw0LzVGMkFIbjV6UWpBNXQzbVhSR08wRXZpNjE0WXFh?=
 =?utf-8?B?OUczR2xLeVl5TzhmQndDOTczOVh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: gdata.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9626.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9969a8d-6474-4401-c5cf-08dba7c29a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 12:30:45.7901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 17a28b0e-dea1-4ab6-82fd-ccf73c7d198e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xn3vgrJDkRMVBxiEApdh6pI4UI6M+8vTCWdiXvQAVcCb+qvi6LiRFwODARZ+AwP9wlPNNdWSXXpyjG7rWbR783+IhvJuBMdyfVlp/MIUvzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7548
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

QXMgYSBxdWljayBzdW1tYXJ5LCBqdXN0IGluIGNhc2UgdGhlIG9yaWdpbmFsIGlzc3VlIGdvdCBt
aXN1bmRlcnN0b29kOg0KDQpUaGUgcm9vdCBjYXVzZSBhcHBlYXJzIHRvIGJlIGluIG1tL21hY2Nl
c3MuYzo6c3RybmNweV9mcm9tX3VzZXJfbm9mYXVsdCgpDQoNClRoZSBmdW5jdGlvbiBzYXlzIGl0
IHJldHVybnMgdGhlIGxlbmd0aCBvZiB0aGUgc3RyaW5nICJpbmNsdWRpbmcgdGhlIHRyYWlsaW5n
IE5VTCIuIEl0IGRvZXNuJ3QgZG8gdGhhdCBmb3IgZW1wdHkgc3RyaW5nczogSXQgcmV0dXJucyAw
IGluc3RlYWQuIFRoaXMgaXMgY2F1c2luZyBpc3N1ZXMgZm9yIHRoZSB1cHN0cmVhbSBCUEYgZnVu
Y3Rpb24gdGhhdCBjYWxscyBpdC4gVGhlcmUncyBhIHBvdGVudGlhbCBvZmYtYnktb25lIGVycm9y
IHZpc2libGUgaW4gdGhlIGNvZGUuDQoNCnN0cm5jcHlfZnJvbV9rZXJuZWxfbm9mYXVsdCgpIG9u
IHRoZSBvdGhlciBoYW5kIHdvcmtzIGNvcnJlY3RseTogSXQgcmV0dXJucyAxIGZvciBhbiBlbXB0
eSBzdHJpbmcuDQoNClRoYW5rcywNCk1heA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogQmFnYXMgU2FuamF5YSA8YmFnYXNkb3RtZUBnbWFpbC5jb20+IA0KU2VudDogU3VuZGF5
LCBKdWx5IDIzLCAyMDIzIDM6NTMgQU0NClRvOiBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9y
Zz47IE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0QGtlcm5lbC5vcmc+OyBTdGV2ZW4gUm9zdGVk
dCAoR29vZ2xlKSA8cm9zdGVkdEBnb29kbWlzLm9yZz47IEZyw7ZobGluZywgTWF4aW1pbGlhbiA8
TWF4aW1pbGlhbi5Gcm9laGxpbmdAZ2RhdGEuZGU+DQpDYzogTGludXggS2VybmVsIE1haWxpbmcg
TGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IExpbnV4IEJQRiA8YnBmQHZnZXIu
a2VybmVsLm9yZz47IExpbnV4IE1lbW9yeSBNYW5hZ2VtZW50IExpc3QgPGxpbnV4LW1tQGt2YWNr
Lm9yZz4NClN1YmplY3Q6IEZ3ZDogYnBmOiBicGZfcHJvYmVfcmVhZF91c2VyX3N0cigpIHJldHVy
bnMgMCBmb3IgZW1wdHkgc3RyaW5ncw0KDQpIaSwNCg0KSSBub3RpY2UgYSBidWcgcmVwb3J0IG9u
IEJ1Z3ppbGxhIFsxXS4gUXVvdGluZyBmcm9tIGl0Og0KDQo+IE92ZXJ2aWV3Og0KPiANCj4gRnJv
bSB3aXRoaW4gZUJQRiwgY2FsbGluZyB0aGUgaGVscGVyIGZ1bmN0aW9uIGJwZl9wcm9iZV9yZWFk
X3VzZXJfc3RyKHZvaWQgKmRzdCwgX191MzIgc2l6ZSwgY29uc3Qgdm9pZCAqdW5zYWZlX3B0ciBy
ZXR1cm5zIDAgd2hlbiB0aGUgc291cmNlIHN0cmluZyAodm9pZCAqdW5zYWZlX3B0cikgY29uc2lz
dHMgb2YgYSBzdHJpbmcgY29udGFpbmluZyBvbmx5IGEgc2luZ2xlIG51bGwtYnl0ZS4NCj4gDQo+
IFRoaXMgdmlvbGF0ZXMgdmFyaW91cyBmdW5jdGlvbnMgZG9jdW1lbnRhdGlvbnMgKHRoZSBoZWxw
ZXIgYW5kIHZhcmlvdXMgaW50ZXJuYWwga2VybmVsIGZ1bmN0aW9ucyksIHdoaWNoIGFsbCBzdGF0
ZToNCj4gDQo+PiBPbiBzdWNjZXNzLCB0aGUgc3RyaWN0bHkgcG9zaXRpdmUgbGVuZ3RoIG9mIHRo
ZSBvdXRwdXQgc3RyaW5nLCANCj4+IGluY2x1ZGluZyB0aGUgdHJhaWxpbmcgTlVMIGNoYXJhY3Rl
ci4gT24gZXJyb3IsIGEgbmVnYXRpdmUgdmFsdWUuDQo+IA0KPiBUbyBtZSwgdGhpcyBzdGF0ZXMg
dGhhdCB0aGUgZnVuY3Rpb24gc2hvdWxkIHJldHVybiAxIGZvciBjaGFyIG15U3RyaW5nW10gPSAi
IjsgSG93ZXZlciwgdGhpcyBpcyBub3QgdGhlIGNhc2UuIFRoZSBmdW5jdGlvbiByZXR1cm5zIDAg
aW5zdGVhZC4NCj4gDQo+IEZvciBub24tZW1wdHkgc3RyaW5ncywgaXQgd29ya3MgYXMgZXhwZWN0
ZWQuIEZvciBleGFtcGxlLCBjaGFyIG15U3RyaW5nW10gPSAiYWJjIjsgcmV0dXJucyA0Lg0KPiAN
Cj4gU3RlcHMgdG8gUmVwcm9kdWNlOg0KPiAqIFdyaXRlIGFuIGVCUEYgcHJvZ3JhbSB0aGF0IGNh
bGxzIGJwZl9wcm9iZV9yZWFkX3VzZXJfc3RyKCksIHVzaW5nIGEgdXNlcnNwYWNlIHBvaW50ZXIg
cG9pbnRpbmcgdG8gYW4gZW1wdHkgc3RyaW5nLg0KPiAqIFN0b3JlIHRoZSByZXN1bHQgdmFsdWUg
b2YgdGhhdCBmdW5jdGlvbg0KPiAqIERvIHRoZSBzYW1lIHRoaW5nLCBidXQgdHJ5IG91dCBicGZf
cHJvYmVfcmVhZF9rZXJuZWxfc3RyKCksIGxpa2UgdGhpczoNCj4gY2hhciBlbXB0eVtdID0gIiI7
DQo+IGNoYXIgY29weVs1XTsNCj4gbG9uZyByZXQgPSBicGZfcHJvYmVfcmVhZF9rZXJuZWxfc3Ry
KGNvcHksIDUsIGVtcHR5KTsNCj4gKiBDb21wYXJlIHRoZSByZXR1cm4gdmFsdWUgb2YgYnBmX3By
b2JlX3JlYWRfdXNlcl9zdHIoKSBhbmQgDQo+IGJwZl9wcm9iZV9yZWFkX2tlcm5lbF9zdHIoKQ0K
PiANCj4gRXhwZWN0ZWQgUmVzdWx0Og0KPiANCj4gQm90aCBmdW5jdGlvbnMgcmV0dXJuIDEgKGJl
Y2F1c2Ugb2YgdGhlIHNpbmdsZSBOVUxMIGJ5dGUpLg0KPiANCj4gQWN0dWFsIFJlc3VsdDoNCj4g
DQo+IGJwZl9wcm9iZV9yZWFkX3VzZXJfc3RyKCkgcmV0dXJucyAwLCB3aGlsZSBicGZfcHJvYmVf
cmVhZF9rZXJuZWxfc3RyKCkgcmV0dXJucyAxLg0KPiANCj4gQWRkaXRpb25hbCBJbmZvcm1hdGlv
bjoNCj4gDQo+IEkgYmVsaWV2ZSBJIGNhbiBzZWUgdGhlIGJ1ZyBvbiB0aGUgY3VycmVudCBMaW51
eCBrZXJuZWwgbWFzdGVyIGJyYW5jaC4NCj4gDQo+IEluIHRoZSBmaWxlL2Z1bmN0aW9uIG1tL21h
Y2Nlc3MuYzo6c3RybmNweV9mcm9tX3VzZXJfbm9mYXVsdCgpIHRoZSBoZWxwZXIgaW1wbGVtZW50
YXRpb24gY2FsbHMgc3RybmNweV9mcm9tX3VzZXIoKSwgd2hpY2ggcmV0dXJucyB0aGUgbGVuZ3Ro
IHdpdGhvdXQgdHJhaWxpbmcgMC4gSGVuY2UgdGhpcyBmdW5jdGlvbiByZXR1cm5zIDAgZm9yIGFu
IGVtcHR5IHN0cmluZy4NCj4gDQo+IEhvd2V2ZXIsIGluIGxpbmUgMTkyIChhcyBvZiBjb21taXQg
ZmRmMGVhZjExNDUyZDcyOTQ1YWYzMTgwNGUyYTEwNDhlZTFiNTc0YykgdGhlcmUgaXMgYSBjaGVj
ayB0aGF0IG9ubHkgaW5jcmVtZW50cyByZXQsIGlmIGl0IGlzID4gMC4gVGhpcyBhcHBlYXJzIHRv
IGJlIHRoZSBsb2dpYyB0aGF0IGFkZHMgdGhlIHRyYWlsaW5nIG51bGwgYnl0ZS4gU2luY2UgdGhl
IGNoZWNrIG9ubHkgZG9lcyB0aGlzIGZvciBhIHJldCA+IDAsIGEgcmV0IG9mIDAgcmVtYWlucyBh
dCAwLg0KPiANCj4gVGhpcyBpcyBhIHBvc3NpYmxlIG9mZi1ieS1vbmUgZXJyb3IgdGhhdCBtaWdo
dCBjYXVzZSB0aGUgYmVoYXZpb3IuDQoNClNlZSBCdWd6aWxsYSBmb3IgdGhlIGZ1bGwgdGhyZWFk
Lg0KDQpGWUksIHRoZSBjdWxwcml0IGxpbmUgaXMgaW50cm9kdWNlZCBieSBjb21taXQgM2Q3MDgx
ODIyZjdmOWUgKCJ1YWNjZXNzOiBBZGQgbm9uLXBhZ2VmYXVsdCB1c2VyLXNwYWNlIHJlYWQgZnVu
Y3Rpb25zIikuIEkgQ2M6IGN1bHByaXQgU29CIHNvIHRoYXQgdGhleSBjYW4gbG9vayBpbnRvIHRo
aXMgYnVnLg0KDQpUaGFua3MuDQoNClsxXTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3No
b3dfYnVnLmNnaT9pZD0yMTc2NzkNCg0KLS0NCkFuIG9sZCBtYW4gZG9sbC4uLiBqdXN0IHdoYXQg
SSBhbHdheXMgd2FudGVkISAtIENsYXJhDQo=

