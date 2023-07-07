Return-Path: <bpf+bounces-4491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC674B791
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 22:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C705280A72
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 20:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAF11772C;
	Fri,  7 Jul 2023 20:01:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152A23C7
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 20:01:56 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D641FE
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 13:01:54 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 67618C1524B2
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688760114; bh=yFGaayOyeEo1tNBBBj6L752OOqmmEADe/RAu7+2OF0g=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=muwH2TCxG1UX3nKIOse/gWAT87rzOB8pk3wjQxeKoZkyynjQbrlVM6Xd+i2UtWl4d
	 mbfoNh7nmDIMEf+1fo1Tz7mpNO6gZwytIpcw59eAELxhljO3149TJhC7dyDqMrSDHz
	 0ubzMUyIhIV7T6UkBnXkDgxLQz7M+i++OlCgr/kk=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3DEAEC14CE52;
 Fri,  7 Jul 2023 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1688760114; bh=yFGaayOyeEo1tNBBBj6L752OOqmmEADe/RAu7+2OF0g=;
 h=From:To:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=XbMrb0zzRwRmS/oZ3ldvR7JFQ/Ke3UPmI0/nL01qeGsMmdS97/X5SnJSYvVd25uM7
 84GH2JtLMWdt9FQr9I+Hb/djWrA0aMmvmsAE/hXHU/GAP3HA363ov3yCgBft6J+Ie9
 YOstY6m+pBNEzB/N8kvqlYDrJQYsETGiiDMpBKIA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id ED1E2C15107F
 for <bpf@ietfa.amsl.com>; Fri,  7 Jul 2023 13:01:52 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.101
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jB2dGkhkHWaN for <bpf@ietfa.amsl.com>;
 Fri,  7 Jul 2023 13:01:50 -0700 (PDT)
Received: from DM5PR00CU002.outbound.protection.outlook.com
 (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B68FEC14CE52
 for <bpf@ietf.org>; Fri,  7 Jul 2023 13:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltYyOv54eW9MFgsZnGclFKuUICw67vzizlX9oGbPs3gCULnuRLwG3zvP3CtKnlXs6Riw3wWTLekwo1TDW3CnXH58rdLHu/vRGjwDU5qu0eKFxBKn5Ny1LChwyYnYrjLakneZ687d5C12h6eB7NkJufhe7JMeRn+XkAf68ocLytixYyaIC558RJyIa54JNSv6oXK8+wADetlX31x3cuVWRWnPe8tSDYcA87JIwpHkvUMoCJiLNKyOx6f6mxsVlcllDWDnk+Ytb+obrCBMuoG48aeFSS4vK1PerrwtVJwx3oJKM6d/XfmQ6EvC4hhD3LFsQ0o5hLC/+HhwmgKDJBzsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBt/OlW+f6a7hc0xK8dtqTcr3zm51pYUuGa8qQ0G9rQ=;
 b=dTl7OUmzm/GeiuOKkq4FODB+bdEcqWl9N79pY/3eDR4JhFIRK7ncKaXAJspTDoGDwxCuenqOLkWfVJjGB++2uc5owBDPh9b+N3kWEMVXGum4DeXk+dZpj5Tj1j1Ivic3F1QKBZqs59UsAyuXqxZAy9QYc8uCnHVCZcKCehj/vx/mMndPEvqEvkLFD4/+FbLGvoc8VgGarbn0HJWaz1boVz4nCnoAZAqCv5/xGVF7YYS5xoZxB5XTNOwlTT3Hv8KsX81fQeZpyJ2YXKOKIUZiLOcmXjDbTfMh6/AJPBs0cv4qmfJs+4lhZzMbvsorWaKCmAgZC+DNWGNowQYf3SqD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBt/OlW+f6a7hc0xK8dtqTcr3zm51pYUuGa8qQ0G9rQ=;
 b=X6BdVSjvWToy3s2WOBfEvx16IVYJj5p9Bv7xbG9yz4ROPH+HpHtqn9YyqK2jeRC79vtkx4NIMpyce2JTJ7Y8E8cELuE2/MsdnkKDM1sRQBmgIb1KLGsdICBn2Mjgj1q/HELwzHKtK5881Kjcj1OmVO1cZnXCfndqDeoBr9bJXsw=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MN0PR21MB3484.namprd21.prod.outlook.com (2603:10b6:208:3d3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.5; Fri, 7 Jul
 2023 20:01:47 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5%4]) with mapi id 15.20.6544.010; Fri, 7 Jul 2023
 20:01:47 +0000
To: Michael Richardson <mcr+ietf@sandelman.ca>, "bpf@ietf.org" <bpf@ietf.org>, 
 bpf <bpf@vger.kernel.org>
Thread-Topic: [Bpf] Instruction set extension policy
Thread-Index: AdmwKdCg+G2TzllJT+2ICM2r0nWi5AA0o6YAAAQp+2A=
Date: Fri, 7 Jul 2023 20:01:47 +0000
Message-ID: <PH7PR21MB3878059A1DDC86C7DC50F324A32DA@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <23460.1688752596@localhost>
In-Reply-To: <23460.1688752596@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c2c5336e-2c45-42c0-a633-f6800a41e29f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-07T19:55:49Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MN0PR21MB3484:EE_
x-ms-office365-filtering-correlation-id: 8b8b86d9-e984-42d8-4953-08db7f24fed8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39E3ffjtoiTXswQ0xmEOVp/xQHgFN2Ar5UcawYN623whV8CICuw2mTXDb54ujthfFDT3k8xE7NtosFT2xZ1D5WfUDmqatRnfTbodTzkUHgOwp4VHckbaMtMSV+xxYn+izXP6+22t56ydgxIFL7jHhw66+ICN+VpKW1wDglYzRhYySt4cOjH6gtlspH/7hi6zi4v3LtJ+YXZAAl7JuunwhDQ1VgTzvZOQe9v7LMKDE6rs2KECEtbI3kr3CTZQQj/cIhI7yvzkN0OLS1oLlqvGRgSykUdQgxU8Ufx+v5+R+s8ZHBBEd/jpfhhajVftje5c/1wra3ymLaRKomCLfSzH+q9hin9MO+dXhYH91iH1Q2y+oYpitHBTQ9Iatqdny96JEHCiaO1uLxqije9ngSg/P5vt4nmqBDqkRsvFy+rDDimsA7LIA6DwK+r0e4tuCDE5tMnOOE7x/Wvb6WPDps0edzB/hdVqOEhH9eaVic2KJKcKb2Gj2q9+umbpEoOtcs9Ts8x4zHbc5C1iwBgaI3dNxNvIoRfQVm0cZ8lMfC+W4UG4J7HUUErS0F05lP+ShHxDX8bK7oiJPu33PwW0ZlPX7zYwyAiS8xUBfKn0+b8GfCdGYF5Ss65CRgXijIoyZ/1QOJhySm78B/ALp1l6yJfGd4u6h7cp9fcLvZuK8+6kVbE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(33656002)(10290500003)(86362001)(7696005)(76116006)(316002)(110136005)(64756008)(66476007)(66556008)(66446008)(66946007)(478600001)(71200400001)(55016003)(5660300002)(2906002)(6506007)(122000001)(8676002)(8936002)(82950400001)(38100700002)(38070700005)(52536014)(82960400001)(41300700001)(8990500004)(9686003)(53546011)(186003)(26005)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkJWNlZFVDdmL054c0gxZFFjcjRRRVRLbGthbEN2SXZlVUFrL2F0YzBBblNa?=
 =?utf-8?B?STh3VzcxNTVyYzVqWDdLRDRxaFlRVERWZEVUTCtyMk54eE53OENEYU5hNEJK?=
 =?utf-8?B?SFNtODdmazNEc01GK0VKTDNQK0RGZkNuMUY3R1hGdndFc3RUVUNrTmVvSGtI?=
 =?utf-8?B?R0xnTU1RVG5TSzAxWjhWYkt0S2dYQ1VHa2hpbys3QzRUc1hSQnk3MUxCMi9S?=
 =?utf-8?B?eC8vendVYW9vSTd1Q2VnWjA5QWJZVGFEVFBCOVpGSitlQmVFdlBOZnpGSGJs?=
 =?utf-8?B?SGxjOFFEdjJUZmppWkxLNkxIQ2lIeG1RMXZFeW5obnRXK09Yc2VBL1NmUFNK?=
 =?utf-8?B?Q1lPcXVPeGQ5Wi9jUWlZVkVqT001WXFZYTBGcE5wQlNvdno1RFVtWHNSRVJz?=
 =?utf-8?B?bUU2dERPeitUSWFTY256TklOSEg5QktiM2J6aUs4cHBtcis0Qll6bFdOOTZ0?=
 =?utf-8?B?VWZ3Z2pIQzk0LzE3SzROOTQxUmgyUmxIeVROYklPWUlYWmtySHhkNVpaZ1Va?=
 =?utf-8?B?YWFoOEs1REVOQ3lySElrdDJrUFEzWmFsRnRwM0QvWjJoeU41YUxxb2VyYUVx?=
 =?utf-8?B?a1hNT2pQbXdyaDBPZGN2N1pFZFBpdkVqOFBOOEoydllKRmE1dWNHTnhpbzc5?=
 =?utf-8?B?YndQTzFvSFBmb2c5VDcyaXgyUXhwRVZIb2ZhRjcxSFhkZzF6a3ZSUXZkdmkr?=
 =?utf-8?B?dFZCMFlSazBhLzM3aEpKOEhFdUNYMC9jdlFCTyszZVdVL0V6N0lzN2hYNjBZ?=
 =?utf-8?B?M1lrdis4NXRXV3R2QXMxbis1YWl0SjAzNjA5RWtiZlhlRzkrMEVCalQyM2ll?=
 =?utf-8?B?TnZvS0tnVlJPaFFsSEJXQWJYdzlMeVh1QjZKWkZsRXR5REl6d3Y3QmRGU3Rs?=
 =?utf-8?B?aElqbFRhNEhLWGxPUm5idkRsWDduVnNCVnpGRGFUeFVXZDVaRzZRRkNYZlZn?=
 =?utf-8?B?bUJ0UjFCM0pEc1g1S1BTTFJKaGZnN3RHYVFNYkx2aHViWWM3SUZHSHhoTEor?=
 =?utf-8?B?VzNvc1RtcWtQdGhnbUlyRkRhYjZWN1QwWVYyS3lmR3hXR1NKVmtudmhxZnZi?=
 =?utf-8?B?bVVmaXo4N2dzUThxZ2k3V2JFSXR2OG9GTFQ0c2FjVkJJVk5lMnFCTDc4MmdG?=
 =?utf-8?B?YkRqM25PTnArWGJDOUJWTGFMdnAyZW1QMENad2JSWmJ4M3N0ZFJCUVF1clhG?=
 =?utf-8?B?QmRmYU9PUDBNNFRCSVBDWEtkNDJibFMwT2Y0V3JEcmh6Wlp2SkVrZm1zbk0z?=
 =?utf-8?B?djk3ZytaaTRrZE85eC9DUEtLU0pRTkJ0Ry9ocm10aGhROWRhV2V1bHNEdDF0?=
 =?utf-8?B?VlZ1dm5RdnJhZlE5Z0xXdXZaeGRrZVlDKzVjU0NFVlFqYnYwRGtTajBuU3NW?=
 =?utf-8?B?Y0ErQWEvTUVaYU1kZlg4eEE0M2xjMHl4UU5RcU9iR1EzT3p0c0FacHh6ZFVL?=
 =?utf-8?B?WlArZ1RNQVFOeEpyTFB5WE5qQXNKQWhYTzlDeWJzUklyaVJuWGdoUFhzckFn?=
 =?utf-8?B?Y3JqeWNaMjZtRm5Tb1FEa2JLTm5YM1ZTUFQySFlhRlIzRWpmNFloZ2JjSkZ4?=
 =?utf-8?B?bzlaZXdSU2RrcHgrSTc0YllSejc4VmFOcHM0RWdJR3RnS3Aza1E3WHBvVjhY?=
 =?utf-8?B?T3hIK2lnNm1NQ2dlWWxKQ1hncFpSM2dSL2RaVGFiSVUwYUJDdVczUCtlay9B?=
 =?utf-8?B?ckVhS01lTVNlWTd4Wkd1RUpKNDUxdTZXYWcramJmbUJBdlpDRFk5UldXeHVG?=
 =?utf-8?B?dG1XYVIvd0dIUGZzNkR2Z2RLaDJ6SnJXd1A1ZHpFN3FLM0FMWlRENGFoZVJ2?=
 =?utf-8?B?VUpjWWRmQzREVnFLeDRKb0FxUTFudndycG81OVZYdUJORGdpMjk5aWlRRXFx?=
 =?utf-8?B?cnVkQkJFREppUTVaaENqOTExTjFUblhtc0hvb2lHNEY0TTFtdGhEeWM0cEQ0?=
 =?utf-8?B?dlkzU0R0MHNzNmFkL1FVNlF5b29WYmpHTnJWS2hOOUNabjlnbE1BQzZ1V3A0?=
 =?utf-8?B?QlJHRnNWWjNnUzZjd3IvZ0djUWwzME5sNEVGTktXK0hyT041OWJFSGlxN2Ny?=
 =?utf-8?B?dXYwc1UralpsNHo5T21nT2VadExPTjdHTUNpQTlFT2pHU0VFQlF2ZmVVekpS?=
 =?utf-8?B?cWJVSTZDR3JzMmVTdDNBT1pUcTV4ekxRY3gyWWNRci9wNDVIVk5pbER1TFJR?=
 =?utf-8?B?dXc9PQ==?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8b86d9-e984-42d8-4953-08db7f24fed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 20:01:47.3591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QoZHbbBy1M/fr8Z8gQtl8VawMl/o+ZcRD4D9Y6nGBytuLpC/HYpIgQNBnIIppd7mXaVnF329u8IpfTcqogu9Mkn2V7LCvKbrKoei32i9mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3484
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/xOEN6zKMSxceEEXZ91SW6IkMy7E>
Subject: Re: [Bpf] Instruction set extension policy
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler@microsoft.com>
From: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Michael Richardson <mcr+ietf@sandelman.ca>
> Sent: Friday, July 7, 2023 10:57 AM
> To: Dave Thaler <dthaler@microsoft.com>; bpf@ietf.org; bpf
> <bpf@vger.kernel.org>
> Subject: Re: [Bpf] Instruction set extension policy
> 
> Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org> wrote:
>     > Once the BPF ISA is published in an RFC, we expect more instructions
>     > may be added over time.  It seems undesirable to delay use such
>     > additions until another RFC can be published, although having them
>     > appear in an RFC would be a good thing in my view.
> 
> agreed.
> 
>     > Personally, I envision such additions to appear in an RFC per extension
>     > (i.e., set of additions) rather than obsoleting the original ISA RFC.
>     > So I would propose the ability to reference another document (e.g., one
>     > in the Linux kernel tree) in the meantime.
> 
> That seems like a really good plan.
> They won't have to be long documents either.
> It would be nice if there could be sufficient template so that they don't need
> a lot of cross-area review to publish.
> 
> There is also a thought that there is simply a "yearly" wrap up of all
> allocations.
> 
>     > Similarly, I would propose as a strawman using an IANA registry (as
>     > most IETF standards do) that requires say an IETF Standards Track RFC
>     > for "Permanent" status, and "Specification required" (a public
>     > specification reviewed by a designated expert) for "Provisional"
>     > registrations.  So updating a document in say the Linux kernel tree
>     > would be sufficient for Provisional registration, and the status of an
>     > instruction would change to Permanent once it appears in an RFC.
> 
>     > Thoughts?
> 
> I think it important to distinguish for the group between
> experimental/private-use space and provisional.

Yes.  Right now I don't see a need to have experimental/private-use space.
If anyone else does, please speak up.

> I don't think you want to renumber an instruction when it goes to Permanent
> status.

Agree.  As with the URI scheme registry, the assigned values need not change
when something goes from Provisional to Permanent, only the status label
changes.  There is no numbering space division for Provisional.

> I also think that you want to run this as Early Allocations, so that they
> have a sunset clause, and the process for sunsetting such an allocation should
> be clear.

That's a fine discussion to have.  Provisional URI schemes have no such
sunset clause.  I might argue that subset clauses are only useful when space
is scarce.  Right now, that's not the case when you consider opcode+src+imm
as the space available.

> You may also need to written policy (in the Linux kernel Documentation)
> about back-patching of Provisional numbers into vendor branches and/or LTS
> branches.
> 
> Can there be subtle semantic changes to Provisional allocations?
> (Such as what happens when invalid data occurs?  The divide-by-zero
> equivalent)

I'd expect the answer to be the same as for Permanent allocations.
Offhand, I would say "yes", though of course one needs a plan for
backwards compatibility if so.

Dave
-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

