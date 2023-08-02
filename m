Return-Path: <bpf+bounces-6652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88F76C283
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 03:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AF8281BF2
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 01:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B18A35;
	Wed,  2 Aug 2023 01:55:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718237E
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 01:55:17 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B2F2116
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 18:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc1coSLgP2Yo9oLxsPe4LLXhDmBcoaaeK4Fy2DJ393cf8kA5rM8vq+dFA8nqFXY4YcuABpDIExv/KG6EZLs708PiyGDRlf5YiTB8zDwQZiAVlHpFr4t8FrWlP0xdRq4Zvnbn++TzsFwcZW6kXTofSSyrqRf0zxbJhJbO0J1RF+SzYH7avc7djNlAea7V3iNYNIujLJHwtByNwY/TtD2qJG5clFo5JodxXn0jJkMrk8HKA9NurOrgc9yPStXCmG4/NGC69cujuMbDGAkz9P0r7ERLyM+XXLH9r9+6+NDCSRGk/FJ8Qrthcbht0FASzEHyGQ3etoK1sWhvP2J2LJSqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ngoYHMS3E+GCQhAkhCckdjKd+FJIgkA0jPxHedS5Sc=;
 b=dHPnZkF8XAWz4xFgiP5zZwzen+Rys9qNK+gjwOqiqyd1rpWnbMC553NRiCZi1ed3SRlRrAV1r5PzS7Cjly1+I1uDyKT26j2HMok5QuZYcHss5vXFrtguhnWDHvC+g4+7pn9z4YwA4OIUrfs0PNmVSzbozisrsf8t3Sm3oEFX3IzZowLc9zMu214FXF+vdoModwy8c7wyvdzVWgBH3n0j5K+iMVtrp+TKXe/TBqvdrKsVJdJi20artoZf1IG3G4FCs2/rsmaLRm2BEgqY4lp75gsfv1mUR9qutjC2zbVWpTD4B2FDhIhPdC7wBZ/4FIj19wzivzvwv+phG1VGkYwqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ngoYHMS3E+GCQhAkhCckdjKd+FJIgkA0jPxHedS5Sc=;
 b=Rg5H1zzLGP1UVjcj6FsAUm4WwagvMudjgcfPeOU2cy/3xj4c6svkGZQ/dUXYboUYA/H+iH4b4h0nupc7Z9mbQutOiU7YhZ7ii5xRSx3W3aWDgeNOA9icuijASDqjclg5trJIF9qaM39rAUNhkugry8PYmIw8jXmnvdTZWvlYxy0=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by CY5PR21MB3662.namprd21.prod.outlook.com (2603:10b6:930:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Wed, 2 Aug
 2023 01:55:12 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b%3]) with mapi id 15.20.6652.002; Wed, 2 Aug 2023
 01:55:12 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: Will Hawkins <hawkinsw@obs.cr>
CC: Watson Ladd <watsonbladd@gmail.com>, "bpf@ietf.org" <bpf@ietf.org>, bpf
	<bpf@vger.kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: RE: [Bpf] Review of draft-thaler-bpf-isa-01
Thread-Topic: [Bpf] Review of draft-thaler-bpf-isa-01
Thread-Index:
 AQHZvrWW9Z2mpBtp0E2+6M55X5/AaK/Kg57wgAAlYwCAACeEAIABnVIAgAH0AgCAAXhcAIAACQCAgAAD5YCAAASEgIAAAyOAgAABqACAAARZAIAAF4WAgAALs4CAABuJAIAGE7vA
Date: Wed, 2 Aug 2023 01:55:11 +0000
Message-ID:
 <PH7PR21MB38789504BF4250E37467C484A30BA@PH7PR21MB3878.namprd21.prod.outlook.com>
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
In-Reply-To:
 <CAADnVQLWKnGbG6XTVEKSto0kEiqHwFaDTp+UkCYipKpov_btRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0cc52a76-40d9-4288-9aff-3d4f45bfd63c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T01:40:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|CY5PR21MB3662:EE_
x-ms-office365-filtering-correlation-id: 9bd4b5ce-7f7a-486a-1b09-08db92fb8221
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Rf9hLfBz/uCarNP/VrWfwkFD6EsF2gXu0G9IPtZ0aK7q43Wob3zt4wdPueaR1tol49hx4mUzU/OcStwW0s6zvbwYeUU2P7GJvFotL7RdtuxCne0X3sFumoXZJiZ8QjI/39mFwYUJB65DwSbUqBXIvRa29cZ38bXvKW8DkRPuqQaI1aG4vd3t2rX5ZarGTX8MR3dlGzjoFY5JFqVsk3W/O8fZO/NafCwkGyQhMOBpXBecFSsqNSgRAe3QMZSTXCQD/6fV0Okcss3g8WbSDOLOoak7+rHdruj7QJqLLWSulcZIxeKzzc8gZeakaGsCETMXyM8YeNindZuRXaGZ9ijD5k5FtJKb2PrhMuKk/+f55RrwW8zCzvBz2Ditof5V2JvOkdeRv+MDJlUA01qFuJxNFDEEJmj4WansnSb9B8VDg5IIBHd5td3K/ox0fuUVO4D2uQeXDOzskePnVXuak/GUc+dMT/NHLpINQZIZWSwftKEV/lCtsO/SlRN6ZZWT9BjEyb7nYo+7Ewp1gqIlmxLyf9cEKnjM84xqdgMH3yvdA8xuLtgVBEPs/VNYB+PeN0j0InzGwRxwRUIz1T2jfUGa+6jyuyvjxHlrlTCZ7NBZZhJLMmHSjrBpsoDmq+Dpf+tYqVi5ASgQeeTqQr2PfmqcPw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(966005)(186003)(10290500003)(83380400001)(26005)(8676002)(53546011)(6506007)(5660300002)(66476007)(8936002)(2906002)(41300700001)(66574015)(66946007)(6916009)(66556008)(786003)(52536014)(66446008)(54906003)(76116006)(7696005)(4326008)(8990500004)(71200400001)(33656002)(55016003)(478600001)(64756008)(9686003)(316002)(38070700005)(86362001)(122000001)(38100700002)(82950400001)(66899021)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U280T3VNdFo4YlBxSHNsQ1drelNreGVEcWtjeldRL2F3NGROYkRLNThIS1ZH?=
 =?utf-8?B?UWR1QWszaFpkWTdzVXFKMGF3VXRYaklNOWFiT3doT0diTkJza3d0SSt6MmFa?=
 =?utf-8?B?ZlNyWWJUMDNYbHBxbi9XZkZDN1JHSzZjMXFad1JxNEFiSnBKUnNIa0g1Zmo5?=
 =?utf-8?B?cytkTCttaGpQeE9mK1NYNTlVaUJWMHNKVStKeFN2dmpOS0JkR0UwUmFVaFNw?=
 =?utf-8?B?RG81dkJnUjdVY1dZR3VQYXpIcC9wditnVnhTeTMrTGQ0bjdsVFM2ZGozWENV?=
 =?utf-8?B?Rk1qTG5uWlEzQ1FqeXNFdWtPVkVra3JPYlc4V2dmSnRmUnFVbkRJUE80TTg3?=
 =?utf-8?B?SnpHREY0anVCVDU0dEE4Y2hXS1BYTlE3VXEvZU9hODN1TDlLWnBBeEpnZzBt?=
 =?utf-8?B?dnVrUmxDVlVOMFcwdGhYeFEvR2lPNmYvR2ttV2ZZYUh6VElVNjI2MDNValY2?=
 =?utf-8?B?NmNQRjczSDdoN1o2Y1dCU2FuVnl4cGZXNjA4TUVYajZ6UG85Z1lDcnNseExx?=
 =?utf-8?B?M29wUXVkRy9pWFVSK3NXU1o3TnhJSWlhRUtSRzc2SGM4Ujh0bmZNRTV0NTJq?=
 =?utf-8?B?OEdleW1hdlpRQThOOCtOZm9LejJqb1EyaEY3VGtWQ1liakdKbG0vVEhIWVVR?=
 =?utf-8?B?SENwOWVNK3lNSmhCWE1GVVREZGxxVElpalNnOTVaU1dlZkNhYVBLTzVWMHo3?=
 =?utf-8?B?Zit1RTBMbFE3VCtwYWI0MUNRVy83TytBSks0U3ZCSGNnRllmcGNzNVcyYkIy?=
 =?utf-8?B?NHZrcUNjYzQzK1FraXJXWFpCbjV3YzRwaVhEUHNxOGM3N0svMCs1ZGtVRlBQ?=
 =?utf-8?B?YmNaREczb2poUG9XMlI2Rk9QMFBHQ2lDY3UvMklVNjV5d3V6ZHlLbnl4cmd2?=
 =?utf-8?B?S2FJQzMvRmFYOUQ3ZWVOOG41NXRJVUxzL0FkcWhUZDdvRkk4MkNvdUJacU9x?=
 =?utf-8?B?NmcwcndKc3BTaFF1QUJVbDFrUEd6MmVyNFlKZEgvTmE3eHpwSU9FclF4WDBi?=
 =?utf-8?B?em1INTE4Y0kwMzZ1eW02eVFGbFNBMHQydFhuNUVRZVNUa01BZkxoZXViNk0z?=
 =?utf-8?B?OG0xK0xzMUNWMWxWYkRMNWdpeUc5YnhpMjY3RUF4RFVoNmUyZmg2WnFwaDFy?=
 =?utf-8?B?aUNyWWZEUVNBeFZiSG5tQWFTSnhYNnFiWHN5TStXVkhmK0pCQWM4RHJKRmxW?=
 =?utf-8?B?aEQwZ1FYcU5WbWFOUnhOL0Ywb2Y2R09HS3pvWDZ5QUY2SDd2WU80TzZibytR?=
 =?utf-8?B?bWhmbmptMXA3VHJQTVZTUndMakFDaXY4cVpuUlNtcjhPR0ZJNXAxNDUvQ29i?=
 =?utf-8?B?dEVMditlZUZ3ajlrZWdTRi9HVWtVcnJjeEN2UHhrcW1SZGVSN09neVArUzQx?=
 =?utf-8?B?VWJuNG93RGZ6TFdZeWxpOVlzem1yb0FJTEJrcW1UaFVkenVSNjg1anJPOFU0?=
 =?utf-8?B?WGhWV3k1eFpBNzZRVWNPOEs5dG02UU5VRlc2NnJwQ1U0REV1SXhhVytvSUww?=
 =?utf-8?B?V2Y2NW5iTXVmZWpEZGk0VFoyS3kycWxUeld5dmVESXBIK3YwNzVscW1wRnJU?=
 =?utf-8?B?WmtmbzVPTU52M0czY0IwV1Y4ZGRvMDV5cE5US2tFMVJvbnd5MGZuNzhoN01m?=
 =?utf-8?B?RHpvS1NXM2J0NXA5MHc0Q3BLdXdaeGh1SHExUm5HWkk2a01DYzd2MmRPQ1o4?=
 =?utf-8?B?TWhibEhRTWNBQ0pGNTFCbE9jN2MydmhuVFVSTmM4bmxTUExqK2tFM3hBamtN?=
 =?utf-8?B?WC9FSytXdVVDN3NvNW5ud1FZS1EzMkVXQTU2WWdMSGtpVUxObXNRMFVwd2Jw?=
 =?utf-8?B?QStobUFiSlJKWkx4NVNxUHZ2QW9GQ3IrUXRBZmNHQnp5ajVEejJPK1RCeUI3?=
 =?utf-8?B?WnRpbDcyYi9LZjlkekQyenpOSENGWExhZkVBamJtOE93bWxwNGpYeXM1RHBT?=
 =?utf-8?B?ZGpMMGUxSXJidlZUTnRIOFBMdTFYU0pJaitRaFZiNE9Yazk0NHJockt2V0M5?=
 =?utf-8?B?d05tNXN1aHk2VnVYYzJxUXY3RlRqQWIyVmNqREdza2VaTS9GNkJDc0lCNmtp?=
 =?utf-8?B?b0pRbG5DVjArdEMzMmY1K29jdE5DbXJTVE5KUWdJaWQ3RnF2NUg3bFY0bE1R?=
 =?utf-8?B?UHIzS2dHb29UckQydmVGL1lXWUg1U1J0aDRhNjI2ZTZOZ3dHdllGUXppbXhF?=
 =?utf-8?B?a0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd4b5ce-7f7a-486a-1b09-08db92fb8221
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 01:55:12.0145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I0DWWdb1cjyQpQi5ZeMJnKZuYOJvU5Bg3skflTs8aMql7FGGtK+Vfu1D6usNEnA9Lk7cPkG6X+NUSqLlBrE+8Q9t+x2vXMk00bUpURu35Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3662
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3Yg
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAyOCwg
MjAyMyA5OjUyIFBNDQo+IFRvOiBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4NCj4gQ2M6
IFdhdHNvbiBMYWRkIDx3YXRzb25ibGFkZEBnbWFpbC5jb20+OyBEYXZlIFRoYWxlcg0KPiA8ZHRo
YWxlckBtaWNyb3NvZnQuY29tPjsgYnBmQGlldGYub3JnOyBicGYgPGJwZkB2Z2VyLmtlcm5lbC5v
cmc+DQo+IFN1YmplY3Q6IFJlOiBbQnBmXSBSZXZpZXcgb2YgZHJhZnQtdGhhbGVyLWJwZi1pc2Et
MDENCj4gDQo+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0IDg6MTTigK9QTSBXaWxsIEhhd2tpbnMg
PGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgQXBwZW5kaXggKHRoZSBvcGNv
ZGUgdGFibGUpIGlzIG5vdCBpbiB0aGUga2VybmVsIHJlcG8gbm93IGFuZA0KPiA+IHN0aWxsIGhh
cyB0aGUgaXNzdWVzIHRoYXQgSSBvdXRsaW5lZCBhYm92ZS4NCg0KU3VnZ2VzdGlvbnMgKGVzcGVj
aWFsbHkgY29uY3JldGUgY2hhbmdlcykgd2VsY29tZSA6KQ0KDQo+IFdpbGwgdGhhdCBtYWtlIGl0
IGluIHRvDQo+ID4gdGhlIGtlcm5lbD8NClsuLi5dDQo+IEkgdGhvdWdodCBpdCdzIGF1dG8gZ2Vu
ZXJhdGVkLCBzbyBpdCBzaG91bGQgYmUgZWFzeSB0byB1cGRhdGUuDQoNCkl0J3Mgbm90IHlldCBh
dXRvIGdlbmVyYXRlZCwgYW5kIHNvbWUgcGFydHMgYXJlIGhhcmQgdG8gYXV0by1nZW5lcmF0ZWQN
CmJlY2F1c2UgdGhlIGNvbWJpbmF0aW9ucyBhcmUganVzdCBpbiBFbmdsaXNoIHRleHQuDQoNCj4g
SWYgbm90LCBsZXQncyBjZXJ0YWlubHkgYnJpbmcgaXQgaW4uDQoNCkF0IHRoZSBJRVRGIEJQRiBX
RyBtZWV0aW5nLCBmb2xrcyBzZWVtZWQgYWdub3N0aWMgYXMgdG8gd2hldGhlciBpdA0Kd2FzIGJy
b3VnaHQgaW50byB0aGUgTGludXggcmVwbyBvciBub3QuICBTZWUgcmVjb3JkaW5nIGF0DQpodHRw
czovL3d3dy55b3V0dWJlLmNvbS93YXRjaD92PWpUdFBiSnFmWXdJIGF0IDE6MTU6MzAgLSAxOjE3
OjMwLA0KYW5kIENocmlzdG9waCB3YXMgdGhlIG9ubHkgb25lIHdobyBzcG9rZSB1cCwgcHJlZmVy
cmluZyB0byBqdXN0IGtlZXANCmEgc3RhdGljIGNvcHkgb2YgdGhlIEludGVybmV0IERyYWZ0IGlu
IHRoZSBrZXJuZWwgcmVwb3NpdG9yeS4gIEkgaW50ZXJwcmV0ZWQNCnRoaXMgYXMgc2F5aW5nIG5v
IG9uZSBjYXJlZCBhYm91dCBoYXZpbmcgdGhlIElBTkEgY29uc2lkZXJhdGlvbnMgc2VjdGlvbg0K
aW4gYSBzZXBhcmF0ZSBmaWxlIHRoZXJlLiAgQnV0IHdlIGNvbmZpcm0gY29uc2Vuc3VzIG9uIHRo
ZSBsaXN0LCBzbyBpdCdzIGZpbmUNCnRvIHJldmlzaXQgbm93IGlmIHRoZXJlIGFyZSBnb29kIHJl
YXNvbnMgdG8gZG8gc28uDQoNCj4gSSBzdXNwZWN0IGl0IHdpbGwgYmUgdGhlIHNlZWQgZm9yIElB
TkEuDQo+IERhdmUsIHRob3VnaHRzPw0KDQpUaGF0J3MgdGhlIGludGVudCwgeWVzLiAgUGVyIFJG
QyA4MTI2LCB0aGUgSW50ZXJuZXQgRHJhZnQgaGFzIHRoZSAiaW5pdGlhbCINCmNvbnRlbnRzIG9m
IHRoZSByZWdpc3RyeSBhdCB0aW1lIG9mIHB1YmxpY2F0aW9uLCBhZnRlciB3aGljaCBJQU5BIGJl
Y29tZXMNCnRoZSBhdXRob3JpdGF0aXZlIHBsYWNlIGdvaW5nIGZvcndhcmQgc2luY2Ugb25lIGNh
bm5vdCBjaGFuZ2UgdGhlIFJGQyBpdHNlbGYuDQoNCkRhdmUNCg==

