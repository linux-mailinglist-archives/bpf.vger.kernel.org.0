Return-Path: <bpf+bounces-3995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142B5747870
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 20:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A911C20A56
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 18:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147F17488;
	Tue,  4 Jul 2023 18:48:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A36AD6;
	Tue,  4 Jul 2023 18:48:11 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2104.outbound.protection.outlook.com [40.107.21.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5E6E64;
	Tue,  4 Jul 2023 11:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOz1KOYGE6fCrgaaIuqvtzTg21x+nuhMi1iHqLSlYq641H/X0pi2WIHHl3kQJCY0HnfRDGFMaQ+/tWn5+o7dmQp7UEPhEfW8SzW4Uns47weZtVmTdOF+tS4n9ki6mslNQHkPoqngpn5M33EX3RR1oFG2KbCC+QJ5jFQmieTmAmmw6J0E6QL6a3B9pWEtXAgpV7Ve1kyxJG9/IWvAh4a2fiUN7NnLdXdhDmpqaajDbnmbo/WXTifqO3/xB+XGVKSqPEtRJA3H+R8Otgn2lAzVh3xWOZFJjnqGdpciyzpLJwp+iqIm1H66A+/jSZrFdp8h5lGk7Dc3aBbRpEYIHq1l8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsDMbOfd2kZo6y8uTEtsaVZ9TWXr7ncwonJ9R/8a7Yk=;
 b=FItqXijz5qprSi+2brI5YPAAgmpIfFCphUX/bv8lKdY7AchgXpi1X08vBvD2XkVK9gw5SfuMKgKAun94tk7NybF6mgZlxWdJwYzwMdlzMU8rJabnELlSnHipb6ty/bxFvtHt7me9q/1laYbEjPmiYu6RygRn+p13vjgmCEZTx5USmVv9Lnavjodge860zqRV5Mt4zpzt1Dj7a7eIYsHz5pznumBf3zuPvl9jmIRMQbgVX/5BZ+5Ip5IHafO+V9gu1kDxNjOiEnaZDRywxN5n3T9e0gl3gNJD4oF7f4JLhVIBCRZl0pvjPW0sP7dFKI8f5y7cNbIz4AiwTJOkYN9vuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsDMbOfd2kZo6y8uTEtsaVZ9TWXr7ncwonJ9R/8a7Yk=;
 b=hiFk0VBav1GNJmefWSSaNmowXWPdaby793XqjhIKSadUaoR7EF5NOQw171R/tJd5Ea481SkOFeEBGNb0yc572Z/QCwMc/uhf8PDkXlpuEKwgXFB7/iF5/4FWqKpHH3nIN2SL0LonFFA5UyV/XunNjb9vnfeHgCTf+uMIQ2cnvRY=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS8P189MB2269.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:572::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 18:48:07 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 18:48:06 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH 0/4] igb: Add support for AF_XDP zero-copy
Thread-Topic: [PATCH 0/4] igb: Add support for AF_XDP zero-copy
Thread-Index: AQHZrl7iO+E1gxxktkmbyg3qani+jq+pvguAgAAvLvA=
Date: Tue, 4 Jul 2023 18:48:06 +0000
Message-ID:
 <DBBP189MB14338551FD48E1F8B401DB6C952EA@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230704095915.9750-1-sriram.yagnaraman@est.tech>
 <ZKQ8pXhU/7CRseIi@boxer>
In-Reply-To: <ZKQ8pXhU/7CRseIi@boxer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|AS8P189MB2269:EE_
x-ms-office365-filtering-correlation-id: e0c495c0-86d2-4e03-0a6b-08db7cbf34bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LiJjiJfShRRBND4q2/NTpCtg6McZlBLD+VKycmDo2lCce4p4YqK37nousAUQDH+Kg6zHQ2IDoQu2QAjrXwqwffcBIMNz03EzE8ZXuC68LsGmSIWagxkWLpaTvVBKv5P4Grpm3h8H+5KdJF/xQrEGYAbUuod0OQjW8jcV7tMrNWT9NVFk6TLfMRLdQXqXujLlurn+02Jj29NisRKBwZEROAOlaVW8gk0pBAI28/qT2vlaZpr/SDdXpi30ksmFnipxy+CFF9V0lWS7GSHZ0WEZGlrjwZLuXhfN72i1e4s0e9DmCr/S0vhjCFy0KSyRAjEwgUCq9FTiUeTO7FrrbK/Fals0IDXntSImJNx+SK9rGFIFMavKrW1FBMlOLXy+tPYb9c747B8kbSYq4tnwpJX25XmKbn7ECfJ87qfG/jQ1Y/cKQVAPBIQkxnEffnFt4DMb3HF7/xavyNUHvRRD9HVV8F/I1s0gCHljdqhTKJnDuGSdrRMwopBYP5x3P1JoVb1PyEVoqNrhjN5m604N9kQUOIuUn4NBuQlElS7JH4c7Aekl4OTknwS+PBiQXE/w7+cIVXLNESoBI72x+mkEXTtv8BAeVcE7k7psVWDXbxkOhPiGtJXFlNV3dLCdvxKtLHnj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39840400004)(396003)(376002)(366004)(451199021)(7416002)(44832011)(38070700005)(33656002)(83380400001)(86362001)(122000001)(38100700002)(53546011)(186003)(9686003)(26005)(6506007)(7696005)(55016003)(71200400001)(478600001)(41300700001)(8676002)(54906003)(66946007)(66446008)(64756008)(66476007)(6916009)(66556008)(316002)(4326008)(76116006)(8936002)(5660300002)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmZsZ2NYeXJYbGJiaEM1Rmx5Q3NVMkFIQXZEekdTNHl5R2VDOURsQU80N2Rl?=
 =?utf-8?B?NUtYdS9PMTZROUhNN0NSR1FqZlhwSlE4ZnpKMWVNT25MSFBNYVQvT0Q3MTRz?=
 =?utf-8?B?WGpmbkxXZkVLSUtDdTZ3SDNMMUZpN1dGVGVtM1N2QTVFUnRyZ0pJZlFLb2NM?=
 =?utf-8?B?OWtRU1FlZy9UOVRIOU90UUVCUFZYVWVVeGh0d2tHQWNKMy94Uysvd3o0QkE1?=
 =?utf-8?B?MUhtcjRpbmRtbjlib1orWEJQM2RtY2NOenA5UnNvV0ZON1h6MlhmSmlocWlN?=
 =?utf-8?B?alBNSndKSmZPVFI3YXBUVlUvOGYrV3ZMOVJzYndTTFNRK2JtN3ZkV25iOE0x?=
 =?utf-8?B?OC9sWTNodHJxY05pOGdST2x5N25ZWmFCRHFNendWUS92eTBYWlR6dHR3OHhP?=
 =?utf-8?B?K00vbjhSeUFvY08rTFlZWWR5MnhGcDh1U3RZVm9iODVZeTVBSS9CU2phRVR2?=
 =?utf-8?B?all0ejNCallrT0oya0dmMzZSTFNQVDhsaHZQR01KSmVRU2RqU3E4YzJ4cDA0?=
 =?utf-8?B?Vmxzemhad3F4VkJoS2FtMVVJWi83SWVBY3pnSmdFTHJ4aDBJbFBQS1Jyck1I?=
 =?utf-8?B?c3hZcU5hSlptMTVFcUZhVUEydUd1VDJhYmk5UVlsQ2JobGNZaitNSlhWQkxs?=
 =?utf-8?B?S28xQk5pS2c0UHlJazRISVZkM1RibkdxTHdTcWE3TVRJdVl5ZXI4WFV5NW9C?=
 =?utf-8?B?eUNmdENldHhXNmRkTHpIc2g4QzNCOXZtY1NMODZ2MVlNbGtIcVdwUHJrZTY0?=
 =?utf-8?B?TTlCV1l0QkFkVWFnL0x1ajZMdDJXL0ppdWYvZ1RVc2Q0QU1CVitZTkpLaTkv?=
 =?utf-8?B?WVBidVdjVTBza0tXblgyRzlteGdnTDZoNXl3dnBvanlUNXkybERnZXF1UVpn?=
 =?utf-8?B?bmVYVFNJVW9KeUY2azRoR2swelIrODlSemxabzBvMytUcEI0OCtmcit6azZj?=
 =?utf-8?B?OVhoSHgrZWtRZzcyU3dENEhBRkhTV3Y0QXVDa2xVNUR0SWtZSGhyYzJIMkdL?=
 =?utf-8?B?YWhDMmJYNE05S3h4L201QWRJU1REdXcreEw2czF2M0xvbVNOdC80NmVDRTFT?=
 =?utf-8?B?Sy91RVZJZW56YzJFZWxEVXdBeFhRTTVtSlB5d0VRRkw0ZmorWlBDRHM1QlhD?=
 =?utf-8?B?R3VjNE5rZzcxVUpCUWoyVnNWZXhiRVlic3YrdGc2bENPa0hXcll5a21KQS9r?=
 =?utf-8?B?NERra051RFBoU2dBWFl2NWJhdVhNT2JGOW1odmx2RE1HeEd5eVlEZHIvQWNv?=
 =?utf-8?B?Wm5oNVU5Y0ZWWXF6djJCYko2Wkd5dXlKZGhaSlJkM2hEOXd4UmpyLys2QjM0?=
 =?utf-8?B?UFFvQ3lvVGpwSHA3cWlDbGxabnlkeUFnd05NZ0xDdnVPbGx1REh2aVZ1NVZy?=
 =?utf-8?B?NkpFVmwvbXd2VStJZTBHV3RBNzNqOW5CUUZOZ3NKb2ZiZTJrc1U1SGVCOGtO?=
 =?utf-8?B?a1NRSFZqdG9kY2VQWklMczJhM3llTDNQYkh0cjIyTWprdXozMWpOL2dveEZD?=
 =?utf-8?B?VUpwYXpTZkhkVkRwN01wa2VPbzgranNHRGtoMjI0Q2hXTGtWbkYvaEpJbDFR?=
 =?utf-8?B?cC9jTGExeVJNUUdhYUhBSTl0SCtXRHVVdWxkUzA0aEh4R1J4VSs4TXQvWTlr?=
 =?utf-8?B?c01GaFhXTE1pdjhtdVlueXY5MVlHVWZLUGlYL21wc2tEYy9Wc25QTWFSWWtU?=
 =?utf-8?B?UFd5S2VlYU1OQmIrZFBCTVdTZThBS21pbFRGVDBiWkExdm03L2dXb3JuYjZ0?=
 =?utf-8?B?dndLU2J1WVdmbWF2aE5IbDArYlRaQlNLd21jY3NON2lJUXpKeUF4dVVuUkJR?=
 =?utf-8?B?bVRqMC9yQUhzRmxqQkhHelhDSDJWSUdTeEQydG95N1ZkaExoUmhrVFh3aFZI?=
 =?utf-8?B?dXBqTjJQWnlabUJzdDFVNnJaVktVS2J0eFpHOTFacENVRUNJNHQ4eGxhc253?=
 =?utf-8?B?aHNCVFNsZ29PQzR5YWlBNEsxcUtOY3B4TFVNVXlNUXAwSHFwQzVKVlBqem5z?=
 =?utf-8?B?RW5FS3BtSFNtdEFsZUpZbmxGTFg3SUNRVk16aUFXU1VPL0NnUGdQbmFOM05Y?=
 =?utf-8?B?bFZLYmxnem5nZ21QWW1acUxQcmJ4Qit1OTRXcGRDalVLMHl4ODBldk1WQVFV?=
 =?utf-8?Q?/NBna8fCogd/BQPZh0t1aZYpu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c495c0-86d2-4e03-0a6b-08db7cbf34bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 18:48:06.8132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfuCdhJWaqloZzkV6PrCsnrhgINJUyfXj6qnWyZWzGBznGwt+XWpqKcGZALmhoUzs3uQYGIxUvQkvfpJIJnsRMJyhSBJYAsxmpisqbOYOUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2269
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYWNpZWogRmlqYWxrb3dza2kg
PG1hY2llai5maWphbGtvd3NraUBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDQgSnVseSAy
MDIzIDE3OjM3DQo+IFRvOiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5AZXN0
LnRlY2g+DQo+IENjOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgYnBmQHZnZXIu
a2VybmVsLm9yZzsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgSmVzc2UgQnJhbmRlYnVyZyA8
amVzc2UuYnJhbmRlYnVyZ0BpbnRlbC5jb20+Ow0KPiBUb255IE5ndXllbiA8YW50aG9ueS5sLm5n
dXllbkBpbnRlbC5jb20+OyBEYXZpZCBTIC4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0
PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWINCj4gS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IEFsZXhl
aQ0KPiBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+OyBEYW5pZWwgQm9ya21hbm4gPGRhbmll
bEBpb2dlYXJib3gubmV0PjsNCj4gSmVzcGVyIERhbmdhYXJkIEJyb3VlciA8aGF3a0BrZXJuZWwu
b3JnPjsgSm9obiBGYXN0YWJlbmQNCj4gPGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAwLzRdIGlnYjogQWRkIHN1cHBvcnQgZm9yIEFGX1hEUCB6ZXJvLWNv
cHkNCj4gDQo+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDExOjU5OjExQU0gKzAyMDAsIFNyaXJh
bSBZYWduYXJhbWFuIHdyb3RlOg0KPiANCj4gSGkgU3JpcmFtLA0KPiANCj4gPiBEaXNjbGFpbWVy
OiBNeSBmaXJzdCBwYXRjaGVzIHRvIEludGVsIGRyaXZlcnMsIGltcGxlbWVudGVkIEFGX1hEUA0K
PiA+IHplcm8tY29weSBmZWF0dXJlIHdoaWNoIHNlZW1lZCB0byBiZSBtaXNzaW5nIGZvciBpZ2Iu
IE5vdCBzdXJlIGlmIGl0DQo+ID4gd2FzIGEgY29uc2Npb3VzIGNob2ljZSB0byBub3Qgc3BlbmQg
dGltZSBpbXBsZW1lbnRpbmcgdGhpcyBmb3Igb2xkZXINCj4gPiBkZXZpY2VzLCBuZXZlcnRoZWxl
c3MgSSBzZW5kIHRoZW0gdG8gdGhlIGxpc3QgZm9yIHJldmlldy4NCj4gPg0KPiA+IFRoZSBmaXJz
dCBjb3VwbGUgb2YgcGF0Y2hlcyBhZGRzIGhlbHBlciBmdW5jY3Rpb25zIHRvIHByZXBhcmUgZm9y
DQo+ID4gQUZfWERQIHplcm8tY29weSBzdXBwb3J0IHdoaWNoIGNvbWVzIGluIHRoZSBsYXN0IGNv
dXBsZSBvZiBwYXRjaGVzLA0KPiA+IG9uZSBlYWNoIGZvciBSeCBhbmQgVFggcGF0aHMuDQo+IA0K
PiBwbGVhc2UgaW5jbHVkZSBwZXJmIG51bWJlcnMgaW4gY292ZXIgbGV0dGVyLCBDQyBBRl9YRFAg
bWFpbnRhaW5lcnMgYW5kIHVzZQ0KPiBiYXRjaCBYU0sgQVBJczogeHNrX2J1ZmZfYWxsb2NfYmF0
Y2goKSwgeHNrX3R4X3BlZWtfcmVsZWFzZV9kZXNjX2JhdGNoKCkuDQo+IA0KPiBUaGFua3MhDQo+
IA0KDQpUaGFuayB5b3Ugc28gbXVjaCBmb3IgdGhlIHF1aWNrIHJlcGx5LiBJIHdpbGwgcmVzcGlu
IGFkZHJlc3NpbmcgeW91ciBjb21tZW50cy4NCg0KRm9yIHRoZSBwZXJmIG51bWJlcnMsIEkgbXVz
dCBjb25mZXNzLCBJIG9ubHkgdXNlZCB0aGUgbmV3bHkgZGVsaXZlcmVkIElHQiBkZXZpY2UgZW11
bGF0aW9uIGluIHFlbXUuIEkgZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8gYSByZWFsIE5JQyB0byBwcm92
aWRlIHJlYWxpc3RpYyBudW1iZXJzLiBCdXQgb2YgY291cnNlLCBJIGNhbiBwcm92aWRlIGEgY29t
cGFyaXNvbiBiZXR3ZWVuIFhTS19DT1BZIGFuZCBYU0tfWkVST0NPUFkgdXNpbmcgdGhlIGVtdWxh
dG9yLg0KCQ0KPiA+DQo+ID4gU3JpcmFtIFlhZ25hcmFtYW4gKDQpOg0KPiA+ICAgaWdiOiBwcmVw
YXJlIGZvciBBRl9YRFAgemVyby1jb3B5IHN1cHBvcnQNCj4gPiAgIGlnYjogSW50cm9kdWNlIHR4
cnggcmluZyBlbmFibGUvZGlzYWJsZSBmdW5jdGlvbnMNCj4gPiAgIGlnYjogYWRkIEFGX1hEUCB6
ZXJvLWNvcHkgUnggc3VwcG9ydA0KPiA+ICAgaWdiOiBhZGQgQUZfWERQIHplcm8tY29weSBUeCBz
dXBwb3J0DQo+ID4NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL01ha2VmaWxl
ICAgfCAgIDIgKy0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYi5oICAg
ICAgfCAgNTIgKystDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFp
bi5jIHwgMTc4ICsrKysrKystLQ0KPiA+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9p
Z2JfeHNrLmMgIHwgNDM0ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgNCBmaWxlcyBjaGFu
Z2VkLCA2MzMgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+
IDEwMDY0NCBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX3hzay5jDQo+ID4NCj4g
PiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+ID4NCg==

