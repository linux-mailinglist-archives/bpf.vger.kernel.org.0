Return-Path: <bpf+bounces-6698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DF076CC41
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC13281D50
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2F66FDB;
	Wed,  2 Aug 2023 12:05:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DEC6FC9
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 12:05:35 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4956A1723
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 05:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3CFBdHJqXnt9+X3N2L2f451d0bj2ydO0CnRauSNGXW07I6LFEE6MGxd0TmcfJWUi1Z7VWIPCGgGHj30E28wUPPxpUxKAmjLZVpyO8Ditc16lOwp+GHetlUvJO3AMQS71HXiVd27LEFeRrWCLdlAPopBJpE2u/VLLlu0drSCVdAFBuglVCAle1SNzcBU9qEiywa2+b3T//0QdtJYjwFBDmJr8S9J3FzDQV7w1UQtx1KU6CpDQE5g8AR0Xs4nXuZXu4U3dkTYJHFWXnTLVZxFjC/Eo/hGguyk/P4iAGvkj1j0oNfBapPJ5zsJV/ddWfyinzY/gJ4S1guUBCo3WQ3fBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4w9n16jIszvKlFleDntuRHiBOxVQzU+XgOGz1jBnhM=;
 b=QQzKELLjI9CoT9SwTQNH+F24DVqEUqhPNPMLxP1U/fx7H5RsNzILVWqKhSiq5MZ9ly5PHwhTYj0S9jC4klOMEWUgtTho0tLM9AMhEQUcdyqTAa9KbTRqgtFN52n30+Yv133EgGK8+Gjdvo3lJ93uelnF4/I2MjgtgT87kzk0qE7lkIRdJ+6AL1JjF6AeNIgGJQW75Wu1jqZQBRMMkiteLkeFQLjWTprz7EU7ElvFZflFpB6KATqEA+3aa55BjhIlKtgh1QCS7hRnHuZxiGoNy4v8gMikYCEqn8VlyqtURbhbXe92PcBU0wr6WRZMaatd6aQz4TmdwElJmSK1JZtBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4w9n16jIszvKlFleDntuRHiBOxVQzU+XgOGz1jBnhM=;
 b=RLIG/WrZKQqwfL9kRVtpldSNJ2zmIU4DfPbZUTODEQwTGBuHvomnpT41ZJu6FoFGjxBUYRNnSIY4QdPrjNmm6pzAB46SPtk+229dqXD+aLL0Txt5VhgU/QRYD8iiAvjX97+wGhevcZ8QAE5NNFS4AT3VO6e1puuC58GRm6ByT50=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MW4PR21MB1922.namprd21.prod.outlook.com (2603:10b6:303:73::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.6; Wed, 2 Aug
 2023 12:05:30 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b%3]) with mapi id 15.20.6652.002; Wed, 2 Aug 2023
 12:05:29 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Will Hawkins <hawkinsw@obs.cr>, Watson Ladd <watsonbladd@gmail.com>,
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Subject: RE: [Bpf] Review of draft-thaler-bpf-isa-01
Thread-Topic: [Bpf] Review of draft-thaler-bpf-isa-01
Thread-Index:
 AQHZvrWW9Z2mpBtp0E2+6M55X5/AaK/Kg57wgAAlYwCAACeEAIABnVIAgAH0AgCAAXhcAIAACQCAgAAD5YCAAASEgIAAAyOAgAABqACAAARZAIAAF4WAgAALs4CAABuJAIAGE7vAgAANsYCAAJYucA==
Date: Wed, 2 Aug 2023 12:05:29 +0000
Message-ID:
 <PH7PR21MB387874D32202CBA7F0C9E8DFA30BA@PH7PR21MB3878.namprd21.prod.outlook.com>
References:
 <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
 <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
 <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
 <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
 <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
 <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
 <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
 <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
 <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
 <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com>
 <CADx9qWj4xuYoyz83FphVWU0ZVxy_7Y+SvTWjvChvkMdV290giA@mail.gmail.com>
 <CAADnVQLWKnGbG6XTVEKSto0kEiqHwFaDTp+UkCYipKpov_btRA@mail.gmail.com>
 <PH7PR21MB38789504BF4250E37467C484A30BA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQLt7S9uwMxB3JaLMYACs5xTVwZ+en9pLYUguZ3gOf=33g@mail.gmail.com>
In-Reply-To:
 <CAADnVQLt7S9uwMxB3JaLMYACs5xTVwZ+en9pLYUguZ3gOf=33g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=47093801-2e17-4671-aeff-9a517ad050ff;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T11:27:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MW4PR21MB1922:EE_
x-ms-office365-filtering-correlation-id: 38fb757b-1f26-45cd-07a5-08db9350c3ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qOTX6iGvEOOZndJDOZFUzGEfugUhIOvnT4V06/bvbeyRq5zmxUMN2NZZo5oeQtGtUyEMWuLpw1KkiEsUbeJ7kZHFzGX1wfV7OiC7hhCYkBGVDIvdade36wnXYV+tNFcNKZh0vswg9pPp5hinADRcaXtNaaDD+c/7ubuQVytZIk4YfUBvR4WHGE1E5y1tXCzfeVCG5Zu7+LhE+ioJNZB1Ijc5cv8dBhwVSS2tsaqYtb4h3hym+AhDYRclWIAn4kTZFpFzJh5I8bh02NXGH+2TeDVoGzfIBVC7GmAiOOFKldDWGl+4yeV/Wolp7C2k73Y75A0JbbQolOBermH0h1cS5jKM9w68kKg9zNnMsvugmcQsbOmA/zETkeQIEe3ebwVvHy7c4WkBUHPg+dmINx5qzATulJQmGfgneBf8SdOCI3u0WQnfuikAw7SzsgFs+d9wThJEikceruXCcgc2c+TntcjK5QFUlLth7e59fUUlCvcBpZLSdGnL1JuXjTvHPzZmw08aCS9x8lL8CcDHcyWQMjbSCl9Fofhi+XGDt6ViVoo8oJPEz3ZpAhUhJGlKOHsRThUKqc5b5ZnoSyhc/kqewpikL2PT/+UREJDlLyQcFprjZ+fZ0mEoqunIfRwQbeFFKXGQypv54Op8ehvy/5PfnA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(53546011)(52536014)(8676002)(8936002)(41300700001)(5660300002)(186003)(6506007)(26005)(122000001)(33656002)(86362001)(38070700005)(82950400001)(82960400001)(38100700002)(83380400001)(966005)(10290500003)(9686003)(54906003)(7696005)(478600001)(66476007)(64756008)(66946007)(66556008)(786003)(66446008)(76116006)(6916009)(4326008)(316002)(71200400001)(55016003)(2906002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1VLMU5kZmtQOVVjYnN2OEhSVGpqa3NRaFZHazdEYVQ2UGJTdFZ0bzhGZEEw?=
 =?utf-8?B?Mm13TUFtSGdLc1hFa0g1eHhubXY0UmsvZ1hPRXIzdEVOcHZZMDM3N2NiVXF0?=
 =?utf-8?B?a1hIVzFDcnhyTUhlMk9Zb2pKM0c2N0tTTlIrMUZQVlgxSzlhSFo1T2RFTkhp?=
 =?utf-8?B?cUZqb3hPZ1BhMTFlMEloQk1Za2c1dnBxTUJjSmRyVCt2bEM0V1FOZFVzZGg3?=
 =?utf-8?B?SWJoQ3lUUE83TGlqZVRHdmdocEZhSGxZaSs0YjVPN1NDMVMzQ3NIWjh1RGl3?=
 =?utf-8?B?TWF1SmZtakpIbW1nTG1QNjl1L0g1eEg1cndiYUhnNEtLR0ZJWlgxTC9QeVgv?=
 =?utf-8?B?MWwzY1VGSGVHclpsYWdLckZjcWhoNzhWRkdJYlRGWmJtc0pJU3Jiemx5T24v?=
 =?utf-8?B?d2ppWjZkT3UyUjFjM3B2ejRyYWlIT3BuWkFXb3ZGeUkrTjB6QmFrRGFGZlV3?=
 =?utf-8?B?eWRid0FaZGEvYkQ3dkU3eWtBK1NyRVFNd1JFNUc2a3p4SHNQOHVraklUTndz?=
 =?utf-8?B?Z1BCRS9DWUNsMnpOWVJzNmRLNFY5cm1uS09HTEZXSXBiSFZxbzVMdkI3ZE9r?=
 =?utf-8?B?SU5EUXhnMlplUzBkTk9SZmtkbzRmM0JaRWlxMGZZT3pxNDZYc2JtczNmaFY5?=
 =?utf-8?B?d1FneTFUL0ZqMlVRR0kzYlVpdktWdUdXd1VMb0NVN0JHblppR3RUYmk1Rjlq?=
 =?utf-8?B?TE5uc2lHSnByS2ErbWV5K2toaXBKOUdPMDEyaHo1cXJLSkt1VmVJcGZONHNa?=
 =?utf-8?B?MEd0VGRrWnc3eE1VYjltaGFTbkVCbk1NVGV2ZlZSYVhtVUNjOEhDcEpaUTNT?=
 =?utf-8?B?SFYwbUVZQmZRKzBha2tSY1ZSNkNUaE9jajltOUc2QlhOMUxzdEdvTFAzTTdj?=
 =?utf-8?B?WDJ1Qm9vNDJzNmxlNUlNeEkyVWRjRi9rOTMwczNsaWRXNzhyZmw0anBNbFlQ?=
 =?utf-8?B?eFFNRktOWlMyTi82WW5TZ2lTb3h4UnAyS0Jqb1ZEYzFrTXNaZHJRTEQzK2dJ?=
 =?utf-8?B?RTQxbEJYb00rWFplajNmNHFhU21Ob2tJTkdMem1MUllsVDB1eE1jVDhwQklv?=
 =?utf-8?B?Sm9Tc29IcWZOMFRyNThZMUdzb0IyWnF3UmdhaDVrMmF1emFiVkJ6WUY0dEVW?=
 =?utf-8?B?Y2JFT0ZWQ01JOUZCdFRZc3lTWUFza0lhQWhUUXYzcWtyWENNUHlxOFFTakF1?=
 =?utf-8?B?MXZGd3lYS3NkdFlzWEVHVmRQcjR2eStCdWFEcUl6REJGOG5DdWtqdVVJN003?=
 =?utf-8?B?YlVZd0RLdnRnN01BOFR2eWZSWFBzME5qWVlXZ3JHWnAwaXgyYnl1bXhITFVZ?=
 =?utf-8?B?NlFjaWowVFJ4MENHcnB5aXpPaFlxSi9YamZyNWlpZEU0T3RxZTJzQ1l6Wm41?=
 =?utf-8?B?YTUzRythbkt6SDZ3cDhLbGZoZTBCek9Cd1piNllnVTVYdGVobVlqZVg5OVAz?=
 =?utf-8?B?MDRZaTZrREVvT0xvT3drUC9DSysvZURHZU1oR1RpZlRxcWQwVzVveHdZejc2?=
 =?utf-8?B?TUpCNGxCZmlldXExbHJKV1d1MEtTemc2VGd5Y25kaWIwTG9QSTVHbGNhQ2Jt?=
 =?utf-8?B?TVpjakxVTmN1dkJxMWlTcGphQXF2S0YrL2syN3czNklhczNuNVY3NWwvL0Vj?=
 =?utf-8?B?M2VVUGlQYjdlSGY0S0x6ZHIzNnFHZ1dkWEttWmdOMThmWEVzWlU3M1pVbHRD?=
 =?utf-8?B?S1YyaTFzY0xGWklvQlZGeis4bjZsWVZHWE9MVzFsUlpHOXNRdFpqU3lWWThK?=
 =?utf-8?B?b3BXWWoySEViTlFDY0pBZklIT1VHYUJTVUZZbm1sVVlyUDJvU3JabG02QThD?=
 =?utf-8?B?UkcxbXRjcFJ2N3lyZ3FpOEZPOWZ1dVNQWGE3TVFZVkNiV0hrSXlndzduYjkv?=
 =?utf-8?B?VnY0ZDkya3FFczc5QVJhSk1WWTErMnJGUDRJK0VvZUVxMkNLMXlnTzk1L1hj?=
 =?utf-8?B?a0h6UCtxTVByZmVCNjF3a1RnNGFlUFVvZXBya1JnNEZ4bGhWTU1vZFQxNzR1?=
 =?utf-8?B?Sk1oTzRIVUE1byt2YWYyS3hKT2JIU2xPYmw3WmFKbmJWbnNjZG9HZ0xhNHhs?=
 =?utf-8?B?M0w5azJybytCb1RzUFdIWndtSStra0hhWFF0dGJnZzhLaDB3OXRFSy92UGRG?=
 =?utf-8?B?Q09OWlAvSzFWbnR2Wi9ZQ2lFRmlXVCtPbjdRMW5hNVgrMHpvcVl4Nk1GRTJp?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fb757b-1f26-45cd-07a5-08db9350c3ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 12:05:29.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xDx6drjx1VWqSnNcRwvaqX607ltO19+/hGCVc8oQXSnr2rlkb4ixNiUfhCx80II2giiWjzspNdhIKWGBhzTIleJaUNLfT3KTH3gXxazoegY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZTog
DQo+IE9uIFR1ZSwgQXVnIDEsIDIwMjMgYXQgNjo1NeKAr1BNIERhdmUgVGhhbGVyIDxkdGhhbGVy
QG1pY3Jvc29mdC5jb20+DQo+IHdyb3RlOg0KWy4uLl0NCj4gIEkgaW50ZXJwcmV0ZWQgdGhpcyBh
cyBzYXlpbmcgbm8gb25lIGNhcmVkIGFib3V0IGhhdmluZyB0aGUgSUFOQQ0KPiBjb25zaWRlcmF0
aW9ucyBzZWN0aW9uIGluIGEgc2VwYXJhdGUgZmlsZSB0aGVyZS4gIEJ1dCB3ZSBjb25maXJtIGNv
bnNlbnN1cyBvbg0KPiB0aGUgbGlzdCwgc28gaXQncyBmaW5lIHRvIHJldmlzaXQgbm93IGlmIHRo
ZXJlIGFyZSBnb29kIHJlYXNvbnMgdG8gZG8gc28uDQo+IA0KPiBJIHRoaW5rIElBTkEgY29uc2lk
ZXJhdGlvbiBzZWN0aW9uIGlzIG9ydGhvZ29uYWwgdG8gZ2lhbnQgb3Bjb2RlIHRhYmxlLg0KDQpJ
dCdzIG5vdCBvcnRob2dvbmFsLCBzdWNoIGEgdGFibGUgaXMgYSByZXF1aXJlZCBwYXJ0IG9mIHRo
ZSBJQU5BIENvbnNpZGVyYXRpb25zDQpzZWN0aW9uLiAgU2VlIGh0dHBzOi8vd3d3LnJmYy1lZGl0
b3Iub3JnL3JmYy9yZmM4MTI2I3NlY3Rpb24tMi4yDQooc3BlY2lmaWNhbGx5IHRoZSAiSW5pdGlh
bCBhc3NpZ25tZW50cyBhbmQgcmVzZXJ2YXRpb25zIikuDQoNCj4gVGhleSdyZSByZWxhdGVkLCBi
dXQgZG9uJ3QgaGF2ZSB0byBiZSB0b2dldGhlciBpbiBvbmUgLnJzdCBmaWxlLg0KDQpUcnVlLg0K
DQo+IEkgdGhpbmsgaXQncyBjbGVhbmVyIHRvIGhhdmUgc2VwYXJhdGUgaW5zdHJ1Y3Rpb24tc2V0
LW9wY29kZS5yc3QNCg0KU3VyZS4NCg0KPiBXZSBhbHNvIHdlbnQgYmFjayBhbmQgZm9ydGggZHVy
aW5nIHRoZSBtZWV0aW5nIHdoZXRoZXIgaGllcmFyY2h5IG9mIHRhYmxlcw0KPiBpcyBwcmVmZXJl
ZCBvciBvbmUgdGFibGUuDQoNCkR1cmluZyB0aGUgbWVldGluZywgbm8gb25lIGFyZ3VlZCBmb3Ig
b25lIHRhYmxlIChvdGhlciB0aGFuIG1lIHNheWluZyANCmlmIG5vIG9uZSBoYXMgYSBwcmVmZXJl
bmNlLCBJJ2xsIGxlYXZlIGl0IHRoZSB3YXkgaXQgaXMpLCBhbmQgc2V2ZXJhbCBwZW9wbGUNCmFy
Z3VlZCBmb3IgbXVsdGlwbGUgdGFibGVzIHNvIEkgdG9vayB0aGF0IGFzIHBvdGVudGlhbCBjb25z
ZW5zdXMgZm9yIG11bHRpcGxlDQp0YWJsZXMuICBCdXQgYWdhaW4sIHdlIGNvbmZpcm0gY29uc2Vu
c3VzIG9uIHRoZSBsaXN0IHNvIGlmIGFueW9uZSBoZXJlIGhhcyBhDQpyZWFzb24gd2h5IG9uZSB0
YWJsZSBvciBtdWx0aXBsZSB0YWJsZXMgYXJlIHRlY2huaWNhbGx5IGJldHRlciwgcGxlYXNlIHNw
ZWFrIHVwLg0KDQo+IEN1cnJlbnRseSB5b3UgaGF2ZSBvbmUgdGFibGUgYW5kIGl0IGFjdHVhbGx5
IGxvb2tzDQo+IHZlcnkgcmVhZGFibGUuIE15IHByZWZlcmVuY2Ugd291bGQgYmUgdG8ga2VlcCBp
dCB0aGlzIHdheSBhbmQgY2Fycnkgb3ZlciB0bw0KPiBJQU5BIGV2ZW50dWFsbHkgYXMgb25lIHRh
YmxlLg0KDQpQZXJzb25hbGx5LCBJIGFncmVlIHRoYXQgSSBmaW5kIG9uZSB0YWJsZSBtb3JlIHJl
YWRhYmxlLiAgQnV0IGl0IHNvdW5kZWQgbGlrZQ0Kb3RoZXJzIGluIHRoZSBtZWV0aW5nIGZvdW5k
IG11bHRpcGxlIHRhYmxlcyBtb3JlIHJlYWRhYmxlLg0KDQpDb21wYXJpbmcgc2xpZGVzIDggYW5k
IDkgZnJvbSB0aGUgbWVldGluZywgYXQgaHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9tZWV0
aW5nLzExNy9tYXRlcmlhbHMvc2xpZGVzLTExNy1icGYtaXNhLWV4dGVuc2lvbi1wb2xpY3ktMDMN
CmZvbGtzIHdpbGwgbm90aWNlIHRoYXQgb24gc2xpZGUgOSBpbiB0aGUgbXVsdGlwbGUgdGFibGVz
IGV4YW1wbGUsIEkgb21pdHRlZCBjb2x1bW5zIGZyb20gdGhlIG9wY29kZSB0YWJsZSBvdGhlciB0
aGFuIHRoZSBzaW5nbGUga2V5IGZpZWxkIChvcGNvZGUsIHNyYywgb3Igd2hhdGV2ZXIgZGVwZW5k
aW5nIG9uIHRoZQ0KdGFibGUpIGFuZCB0aGUgZGVzY3JpcHRpb24uICBUaHVzIGZvciBzYXkgb3Bj
b2RlIDB4MTcgKGRzdCAtPSBpbW0pIHRoZSBvbmUgdGFibGUNCnZlcnNpb24gc2hvd3Mgc3JjIDB4
MCBhbmQgaW1tIGFueSwgd2hlcmVhcyB0aGUgbXVsdGlwbGUgdGFibGVzIG9uZSBkb2Vzbid0Lg0K
UGVyaGFwcyBpdCBjb3VsZCwgYnV0IG9uZSB0aGluZyBJIGxpa2UgYWJvdXQgdGhlIHNpbmdsZSB0
YWJsZSB2ZXJzaW9uIGlzIHRoYXQgYXMgY3VycmVudGx5DQpkZXBpY3RlZCwgb3Bjb2RlIDB4MTcg
d2l0aCBzcmMgIT0gMHgwIGlzIGN1cnJlbnRseSB1bmRlZmluZWQgKGkuZS4sIGF2YWlsYWJsZSBm
b3IgbGF0ZXIgdXNlKSwNCndoZXJlYXMgdGhlIG11bHRpcGxlIHRhYmxlIHZlcnNpb24gd2l0aCBh
IHNpbmdsZSBrZXkgZmllbGQgZGVwaWN0cyBpdCBhcyBkZWZpbmVkIGFzICJkc3QgLT0gaW1tIiB3
aXRoIEVuZ2xpc2ggdGV4dCBpbiB0aGUgYm9keSBvZiB0aGUgZG9jIHRoYXQgc2F5cyBzcmMgbXVz
dCBiZSB6ZXJvLg0KDQpUaHVzIHRoZSBzaW5nbGUgdGFibGUgdmVyc2lvbiB0aGF0IHByZXNlbnRz
IHNyYyBhcyBhIGtleSBmaWVsZCB1bmxlc3MgaXQgY29udGFpbnMgImFueSINCm1lYW5zIHRoZXJl
J3MgcGxlbnR5IG9mIGluc3RydWN0aW9uIHNwYWNlIGxlZnQgdW5hbGxvY2F0ZWQuICBBbnlvbmUg
d2hvIGFjdHVhbGx5IHdhbnRzDQp0byBkaXNhbGxvdyBhbnkgZnV0dXJlIGluc3RydWN0aW9ucyBm
cm9tIGV2ZXIgdXNpbmcgb3Bjb2RlIDB4MTcgd2l0aCBzcmMgIT0gMHgwIG1pZ2h0DQpwcmVmZXIg
dGhlIG11bHRpcGxlIHRhYmxlcyAoaS5lLiwgd2l0aG91dCBzcmMgYXMgYSBrZXkgZmllbGQpLiAg
QnV0IHRvIG1lLCB0aGlzIGNvdWxkDQpwb3RlbnRpYWxseSBiZSBhIHRlY2huaWNhbCBhcmd1bWVu
dCBmb3Iga2VlcGluZyBvbmUgdGFibGUuDQoNCkRhdmUNCg==

