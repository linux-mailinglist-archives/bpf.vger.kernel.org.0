Return-Path: <bpf+bounces-33406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68D891CB74
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 08:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EA428480B
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 06:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B7129429;
	Sat, 29 Jun 2024 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="KjoyMqWa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Asc4HS8i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SWeUjO74"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A0E1EA8F
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=50.223.129.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719643467; cv=fail; b=Cy55x06lVLcrQTNV2rYEg1IArh8ebxbziIwOtBJnq8eGjnnn2S33aAJ7o5Gzrbg3IAYB0krMTjwECTOb4xmtTiH4VPrTJEY/a7q1425OgL7mBR8EzI534caKzAOLSQMdXlRP2uYAddeEqqxoiVdLyECAa2lGq2oa1/pnc5rMIJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719643467; c=relaxed/simple;
	bh=19IMu/KyCW4u25DA6DIB2XAMHOS0/14h2Mf9UTe3Noo=;
	h=To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:CC:Subject:From; b=Eetq4rGmsQ5f0/3u0/d6scxqmHZbwDmh2av0sco2h34F6AVqJK8kS3DoX+zSDxpifmYfMZhRdG4Hw9neLI/kAotb/bOLfg08jPfPFthOZjekZhN1qnlPJB7qXC2BzjIvruGY3yZDbqQGcwUOwbTFptNEyNkgJ4pKpQ0g1i8iXfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=KjoyMqWa; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Asc4HS8i reason="signature verification failed"; dkim=fail (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SWeUjO74 reason="signature verification failed"; arc=fail smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 204B8C1E0D95
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 23:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1719643465; bh=19IMu/KyCW4u25DA6DIB2XAMHOS0/14h2Mf9UTe3Noo=;
	h=To:Date:References:In-Reply-To:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=KjoyMqWaWrdoQQ8S1fOcXFhNJRnWfLvUTVdn7gVLRQFW8uHKfYL8v6gQWz7ETiDyA
	 DiEM+uGLTr13dBPzwAAENETggIKymFjH8NJjgtiY5XLBZhpm9GxeTvb6DVJoMqYvKe
	 18h35ouLJp6hVIap59JmMSVv1MNtfXTEE5ZT+28A=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0667FC180B6B
 for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 23:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1719643465; bh=19IMu/KyCW4u25DA6DIB2XAMHOS0/14h2Mf9UTe3Noo=;
 h=From:To:Date:References:In-Reply-To:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=Asc4HS8iXg7xL5Lvhx8B5gzI3DmwAN1Yh1hBMX4yOxA+/yLMvPavhqKHlenlwtXSf
 u9rPIJ/at27A0oDVn6uHXZ31VUmNowl9s4oSR9FlZTWNzNj0IprzOlH73e/xptAKEP
 094AVqp+EjC9z9oWF0g1K6x18jJQE5FjHh66EuhA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id F3EB3C169430
 for <bpf@ietfa.amsl.com>; Fri, 28 Jun 2024 23:44:21 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.254
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZCdPafZlugZT for <bpf@ietfa.amsl.com>;
 Fri, 28 Jun 2024 23:44:18 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2110.outbound.protection.outlook.com [40.107.92.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D1B6FC169425
 for <bpf@ietf.org>; Fri, 28 Jun 2024 23:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxemX+pFoRDHWsd3xQGq+qDFbxFMokDhWvAboO4Ts/pmQGbnR8dyJX+H5JYlfuAuLHETeqQTaFnl+dxSU9zZ0anhwGeFqao/ND/3Z5CJfa9OuWf22zpDv/X54wo+5CriPL4+hqZtwEKtlM77NJLoObYmOrCjKf6EVG+Jd1reFng93S8nNc7DnGvNe2mxZowqKTFKhB6nxJPMEpVuGld0kSMPr9vLECX41upYcXM/mDgL9hmCEvW33zb0Y92BxMGBzcRniuRzf23X4/4xwBg0KyUUf+l59zgVOvKJFkUozGwrlOIuiexv2i0dL7fpINuIBhEb1QYleXuU1PbpgL/NMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F77bjnLwEEYITDOL9fLmn23WmVlaqc9Hg/HEOMIsDYk=;
 b=JrSETTpJBNBhDoDmn3kbtIVHwMcc0agWJS9Jae7U8HbGgfIXfJOvsxy47AYXG541/MIUo2yl1xwOHWe8lzoiOiR0thZOVMMJx9QMEJUfC6fWP+cANPbydqKEb6H5iMHaZpI94BHhtdk5QCW9z1hDoxoBBrYIwcIir/gMuwrYSEsrPqdJKkrbIhAdFXEdSrPKvYDeFFYZ54esfApbwnERRyMRFfeaHjcuCQouxbCKNxselqLJrxAYVOtQ2oA/pSxEnL+CAV7Kj4Y/BbfKs+tIBCaVJMMR0ulA2CfGgJR+m0dXHMMKIJVxG1CXsnN2tpVCZQuEpYTKftVHhlTOIfFa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F77bjnLwEEYITDOL9fLmn23WmVlaqc9Hg/HEOMIsDYk=;
 b=SWeUjO743GwBmKl39g7Tx4kpupszppYl4ucE7GvHxvTixhGoXMJLVx14Kjw1r3Er+ePaJsYlVtlmH0787xe0v3jtUK+4VPgj9o2y9Q2g0StfQGi4N4qGZ6lgUGLfmiQAeVO6zAYBk1FQ0IwXylGaJEvJC6dH08feBOrt8UNmK9c=
Received: from PH0PR21MB1910.namprd21.prod.outlook.com (2603:10b6:510:1b::13)
 by BY5PR21MB1411.namprd21.prod.outlook.com (2603:10b6:a03:238::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.0; Sat, 29 Jun
 2024 06:44:03 +0000
Received: from PH0PR21MB1910.namprd21.prod.outlook.com
 ([fe80::1cfb:f0b3:be9e:b5ff]) by PH0PR21MB1910.namprd21.prod.outlook.com
 ([fe80::1cfb:f0b3:be9e:b5ff%4]) with mapi id 15.20.7741.011; Sat, 29 Jun 2024
 06:44:03 +0000
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Thread-Topic: [Bpf] Re: [EXTERNAL] RE: Re: Writing into a ring buffer map from
 user space
Thread-Index: AQHaw6coyfDfX8tLsEO6suBt0kfxibHX2k+AgAAB4lqAAuHggIADldQQ
Date: Sat, 29 Jun 2024 06:44:01 +0000
Deferred-Delivery: Sat, 29 Jun 2024 06:44:00 +0000
Message-ID: <PH0PR21MB191080B6BA61E887EE47B9DC98D12@PH0PR21MB1910.namprd21.prod.outlook.com>
References: <PH0PR21MB19101A296E6A180AD99EDD3898F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <PH0PR21MB191058745A71A705F199B19A98F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <CAEf4BzZf=7Sb9Zf7Bt_oJh=Pq6b=03wspmr8iJSY-KRyJVZ3nw@mail.gmail.com>
 <0c4801dab126$7a502fc0$6ef08f40$@gmail.com>
 <PH0PR21MB191000EA2B7A038CE99C5B5398FA2@PH0PR21MB1910.namprd21.prod.outlook.com>
 <PH0PR21MB19108A5EF85F75C9F273D14798C92@PH0PR21MB1910.namprd21.prod.outlook.com>
 <CAEf4BzaJbjVY-qnjS0=8U_TEwpQTigvbGnBpou+mA6P8DOiuzA@mail.gmail.com>
 <PH0PR21MB19108C4E51658567D704114898D52@PH0PR21MB1910.namprd21.prod.outlook.com>
 <CAEf4BzZjiqarLN9w=9AzQrEvSS+EYF-SAXwajaotsFuJ7PAp8A@mail.gmail.com>
In-Reply-To: <CAEf4BzZjiqarLN9w=9AzQrEvSS+EYF-SAXwajaotsFuJ7PAp8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c436dd72-62a6-44fe-b039-2953f0048180;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-29T06:28:48Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR21MB1910:EE_|BY5PR21MB1411:EE_
x-ms-office365-filtering-correlation-id: 396d16e8-1707-4aaa-d40a-08dc9806dd87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UkMrcnNEeUlrcDdTdnBQdThYeEFPaVhXd2huSnY2eml2L3piTHRVNURYeHVx?=
 =?utf-8?B?SkxnZ0hGZXgzKzRoNXlEUWlFU0h0NjM1MDhvU2g5aGZKREMzYWRnRkFCYW00?=
 =?utf-8?B?SGZJbnRDRCtFUVdrcnUxTjF3akxFZHlqaXJ6NjcxcStIWDNja1YzUVV3WGp4?=
 =?utf-8?B?RUY5bFZxY29VN2xDd3Y2QUVSRXo2ZFBqdkplNGxYeDdVbzVBUllkZXFsZ0tQ?=
 =?utf-8?B?VjNMYUljWkIrQ3pWNFBubTYzVTF5ay9zdnptb0hTY1NMZHVzZWJoMXF2aUQ1?=
 =?utf-8?B?M09TaG8wUDJBT3hocGRGZVNPNVpQRVBhY1EwZXhPSDdXZzVrb0dFNmgwUko5?=
 =?utf-8?B?NFJadDVxcmE5MlZ3SlBZR3Y4Ync5VTZVT2lnejZ2ZWVpcUNtb2JtZmhON1Jr?=
 =?utf-8?B?S2pLTEoraEZxQ1FZakt3SzhLY3FEN2diOWlsV0lyZkxuK21lR3phVE1vbW9m?=
 =?utf-8?B?T05nMWVQMS9iY3BZRWNRQVJuSnR3MzBaNTRFWFp6VjlQYUFvYVVTQ2E0Uytv?=
 =?utf-8?B?TW5vL0Q3YkRSTmFaYmN5RUFvNTh1RFRXVmpWRVZhSEM5RkxmLzFUTGdIUlpj?=
 =?utf-8?B?SzBiNlpRRXpaL3Zhd3dZd0llUlVYcFVkRVF1cXFuYXhnVFF2TGZZN3RzVVIx?=
 =?utf-8?B?am5NRWl1Z3ZCNGtCc0UrWWxtckZycDBqYzdzUFFWVkJ4VlRFUXNwYzY2WFVD?=
 =?utf-8?B?WWtVd295K3V3eC9VWVpqNENFL0daODllNlBXVXpENk1CYURqT0JrODdkZEVo?=
 =?utf-8?B?VmhBeW44SFZBVStWVHZ6NEMwM0VzM3MxMERiNWV4VlQ4RzBSL1JEaHVFbU56?=
 =?utf-8?B?M09tVnVpbGNUdjM0b29JVXZ1QUFRbk54SForOHp0VG0wY3dwRCtvTE5CMWxC?=
 =?utf-8?B?Rm9KVTFrbnBuT29CQlU3QXowOFQxTmdhblJNYXFSb3dYRTVLRDJXbmU2NTBm?=
 =?utf-8?B?U2pvQWZuK1lFVE9mRHVhZWtGdHhzS2ZCSVFQRlgwTGtmam5sMGdqSWhuOGRV?=
 =?utf-8?B?VUp6cENvaUFwTTJ1ZmFxZUsyRXBlR3hYRERNTGQzYzVmOENSams4c0EzRzBz?=
 =?utf-8?B?a1QxV0pjc2lqWXhsUnJZNzV2d2NSbVdYY0dOSFZvSnhtemk1SHZCN3NiME56?=
 =?utf-8?B?aTBmb3o5STJQcHdpdXpiSk5yd1hKWFVsNllhNkZDRjNRVlo1emNsQnc0Mlpr?=
 =?utf-8?B?Mlc2OHkwWHROMWl3a2NyRURBNWJZNW1rSkJaN1hBUjhkZlpFRlA1WFY3TzV5?=
 =?utf-8?B?clhYL3AxQUVmblRqbWwxTDJkWExtR2wwY1VtL2VvNC9URHlKeHZxV2xIVkhM?=
 =?utf-8?B?djgzZjZLbGlpS1BteUoxaUtpSTJBdVhGbVEwUVRYWmxkOUVMTHJiMTVkM3NS?=
 =?utf-8?B?VEdHNFhYcElyWU54OEpUZGpDVmpmRkFYZ2t5MFpXWnFxVFUzWHAreGdTZFF2?=
 =?utf-8?B?Zm1HM3BnNHd2QWtHZFhESEsrWDNxVWhCek56U0E1bEdGWndFVmtTcGFEUG1Y?=
 =?utf-8?B?T3ZES3laRXRacUFmcnFudHF5S2daNTNQdVhmeTBmaEhjc3AvTy9xRWVQb0Vp?=
 =?utf-8?B?ODZ0NmFDSkJEQ24rMVdrZ25tT0hweXBTTUkya1Ezc21pVWM5VGhrWklKNEZF?=
 =?utf-8?B?OGhuY0h6ditXbTNFWXBtaEJzajhCZ2hYYTNWR0xmWUVSTDNYaVpLWmNpRlBW?=
 =?utf-8?B?RTAwMXE1WlV2QXNGZWNZcXIxYUlxaFNCNGpBYXhpNE5VTzNPUkxoZi9iREha?=
 =?utf-8?B?aGpRSzJYMDJ4ZmVBTmZ4LzVaUmpHL2tXNHlPeHJUZS80SEpOekI3V2NuZUw1?=
 =?utf-8?Q?/T+dBnPUjROxWz50PgQL6igyZHaDXhHS/aUsU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR21MB1910.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHVBQjBLZjhjTUlkRElJNXlqNnFxbFBhclFNc0FSL3l3N1lIMnZjZngzRUQx?=
 =?utf-8?B?dlJkTTVtcnZHVVJDay9LbkRubjBrdnJlTHFkVGJkYjR6U1ZTWGRGbkZXbFM3?=
 =?utf-8?B?UU5Od3RraytZRlFtMmtWaUY1Y3EzeEhGYUFReThXYnNrZWliY3k5VlA2ZnBI?=
 =?utf-8?B?RisvbTdSNWtRSjhyOCtCVE9YaEFPczZ6R2xXck5QQzdiRWVQQ25vN3d3TFMv?=
 =?utf-8?B?emRhbk15dHpiYy9tTStVSlYwOGNqK2lQSkc5OVgvcU96RHJiWW5CZG1GbDht?=
 =?utf-8?B?dnlkOFJGTTJTclhYc0RPZTVUUzRGcHRuVXNMNy8xSFcxNTVwdWdzTHNCWmdR?=
 =?utf-8?B?YmhHUkg0QWVCY0NENnNzYmh2bGFJdHlNNjJ0ZHRpUERaeW4ybGFyYzQxbFlE?=
 =?utf-8?B?RFRqQUJoQWQydXFqRFJsNlhCTUxFRlBUbmtOSHlSLzBWZUJsRDhKMkVDM3py?=
 =?utf-8?B?ZFFlSmo3MG5MZVluRDhFQVFBeTVSdUV6aEJIOE5PMnVzVkswUkhrWGxsRWNI?=
 =?utf-8?B?T2FqVFFTMGhXVEdWRklJRGRVdXdwWW5iN1J3WWh4dytwbThwUGI5dk4xRzNV?=
 =?utf-8?B?eXFOdzR0cVkxZU44OHVwSXFuL0dZb2RvVkpsRmllK3h6dDM4ZW56cXhRU1Q5?=
 =?utf-8?B?MzJ2MU55VjdKWHhYSDZ6ekFSVmlyOHZma3YrdXFWR1Y5a3Y2M2Rka1NqQ2lZ?=
 =?utf-8?B?WXdEL0piYmFPYzFJZFBHemFFS1Avd0ZYM1hibUNqb1dwWE1mYjFaNElzaldl?=
 =?utf-8?B?MHhMcytFZlFGRU5lbVVZcC91WjhBaE91dEJpbjNaR21iK3BEN3dFYlJJbkZh?=
 =?utf-8?B?TjRvUmkybXRPbnFDQ1o1R1lRWXI4L0NuVFZCUGZzR1NnZDVTZER4aDFmMFg0?=
 =?utf-8?B?YXFKRC8wYkpQdFFkTzRsSWRnaC8wcmExcEVaZ1htellQeUlPdDJmamF4dlp3?=
 =?utf-8?B?REtMeGZEYXg0RnpXdDJlcE9KdmsxbGd1c3p0OFJWei9VREdwallXeUVZaVRB?=
 =?utf-8?B?Qmg5SjdiakJCbUx3QmpTdDZlM0N3UVBDN0h6cU12U2FSbU9INlJoMTBGSFdU?=
 =?utf-8?B?blNNZ21oMUNrcVhLektxeHEyVlNiRHBlWWtyWWlsMGJBeWUwZlc1eEVFYnN4?=
 =?utf-8?B?YmROSm9EVTl5V284c3QrUXhJb2p5UnphNThkRklxZXgxK0xvb25JejNhME1D?=
 =?utf-8?B?Zmt5eERtNk1NQi9TZVFlaSsvVDFHd2xPamR5WU9Qajk4NUJEd01aaHBmNm1Z?=
 =?utf-8?B?VkZVSGVLSkRnVW4yYW45SWdMTldGaWc0emFobitVUUpRdjN2MGN4c2dNeEpZ?=
 =?utf-8?B?S3JqUlRhKzBnMmpJeHdoTWN6bFo1c2hVOG5LRjRIUWQzNHhGRzRwbU1MOEc0?=
 =?utf-8?B?ekZ2cWtwRWw2VndsMXd6d2IzSWo4akhyRHlRT1ZlVi9QZ2ovaEJDbEExVXgv?=
 =?utf-8?B?WVVPeUpkdFBQNUxSMTFBNkRoOFprcHEwbjJJV0ZQK3NkWXl3aklwMHNFMXA5?=
 =?utf-8?B?UlBKMGRtNWh1SnNYWW94azIvRGZSN3hUeVN4MU0yVVlFaW1MT3VSK29vTGVh?=
 =?utf-8?B?SlJqM0VDTmhucFc1T0V0clBKaERHZWFjdC93QjU1K2pNdER6MEErakRTTnVu?=
 =?utf-8?B?RThYWmlORXBrQ0pLS2c2em9HeGJFS09iTVBUMjVoTXdJcXk1ZUZjZE1heThj?=
 =?utf-8?B?a2t1cXVYSjlSRkEzRWl1WEVYQzZETGorODMrakw5dks3YWhUKzkweHd6T0ND?=
 =?utf-8?B?cWJiTms1K000RDRaY3JOajdxWTllVjlNNXlHL1JjOUpRRUNJdXY2by9RV2NU?=
 =?utf-8?B?bFBMWm1lUEtlZ01zMkJVUy9zSjQzb1plcGk2R29jdzdwL0FydzV6REVFVm5B?=
 =?utf-8?B?TCtWclpjVTZKc0RMRmxieU1na2xETnJPUC9oSDJrMW8rL09nR1F3cTBrM2JK?=
 =?utf-8?B?TVZSNCswSnQwWERsWTV5WFdPRS9rdy9zejdyTUY4NGkwQVZuSjdQWVNSTVEr?=
 =?utf-8?B?T2FrSVZDQWhtR0dlK245Z2NkS0RKejFOdVNJSXFEbEQ4bFV3UmJCa0NZRVZV?=
 =?utf-8?B?SXpBcW5QN3V0OHcvR3lySGFMd3E1SzNsd2lDTDFuVXVpM2lTelhVZ2twV3dL?=
 =?utf-8?Q?ncFA=3D?=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB1910.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396d16e8-1707-4aaa-d40a-08dc9806dd87
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2024 06:44:03.3342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwhUaHVu4iJjQRwKdm+qm+bh1B1eWUT+AemeYrXIs4v8aNuxb220TaEdP2gy1fRws0Q6+/3jtcCCKv/ENp5Fg1ohMaW2L7SkiAZgoWXWDsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1411
Message-ID-Hash: BAMUCDB3SOWCY2XT5Q6AMVYMUBLQXTRH
X-Message-ID-Hash: BAMUCDB3SOWCY2XT5Q6AMVYMUBLQXTRH
X-MailFrom: Shankar.Seal@microsoft.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Shankar Seal <Shankar.Seal=40microsoft.com@dmarc.ietf.org>,
 "dthaler1968=40googlemail.com@dmarc.ietf.org"
 <dthaler1968=40googlemail.com@dmarc.ietf.org>, "bpf@ietf.org" <bpf@ietf.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BEXTERNAL=5D_RE=3A_Re=3A_Writing_into_a_ring_buf?=
 =?utf-8?q?fer_map_from_user_space?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/0iZQ5sj6OkB8clxauplExGtSpnE>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Transfer-Encoding: base64
X-Original-From: Shankar Seal <Shankar.Seal@microsoft.com>
From: Shankar Seal <Shankar.Seal=40microsoft.com@dmarc.ietf.org>

VGhhbmtzIEFuZHJpaS4NCg0KSSBhbSBjaGFuZ2luZyB0aGUgZW1haWwgZm9ybWF0IHRvIHBsYWlu
IHRleHQuIEhvcGVmdWxseSB0aGlzIHdpbGwgd29yayB3aXRoIHRoZSB2Z2VyIG1haWxpbmcgbGlz
dC4NCg0KPj4gSSBkb24ndCB0aGluayB0aGUgTGludXggc2lkZSBjYW4vc2hvdWxkIHdvcmsgbGlr
ZSB0aGF0Lg0KDQpOb3RlIHRoYXQgdGhlIHByb3Bvc2FsIEkgbWFkZSBmb3IgV2luZG93cyBpbiBw
cmV2aW91cyBlbWFpbCBpcyAqZWZmZWN0aXZlbHkqIHRoZSBzYW1lIGFzIHRoZSBmb2xsb3dpbmc6
DQoxLiBMb2FkIGEgYnBmIHByb2dyYW0gdGhhdCByZWFkcyBkYXRhIGZyb20gYSB1c2VyIHN1cHBs
aWVkIG1hcCBhbmQgdGhlbiB3cml0ZXMgdGhlIGRhdGEgaW50byBhIHJpbmcgYnVmZmVyLg0KMi4g
VXNlciBzcGFjZSBhcHAgcG9wdWxhdGVzIHRoZSBkYXRhIG1hcCBhbmQgdGhlbiBpbnZva2UgdGhl
IHByb2dyYW0gdXNpbmcgYnBmX3Byb2dfdGVzdC4NCg0KQXNzdW1pbmcgdGhpcyBhcHByb2FjaCB3
b3VsZCBiZSBjb25zaWRlcmVkIGEgdmFsaWQgdXNlIG9mIGVCUEYsIEkgdGhpbmsgd2UgY2FuIGlt
cGxlbWVudCB0aGUgQVBJIG9uIFdpbmRvd3MgYXMgcHJvcG9zZWQgYmVsb3cuIEkgd2lsbCBiZSBo
YXBweSB0byB3b3JrIHdpdGggeW91IHRvIGJ1aWxkIGEgc29sdXRpb24gb24gTGludXggdGhhdCBp
cyBhY2NlcHRhYmxlIHRvIHlvdS4NCg0KVGhhbmtzLA0KU2hhbmthcg0K4Ka24KaC4KaV4KawIOCm
tuCngOCmsg0KDQpGcm9tOiBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5j
b20+DQpTZW50OiBXZWRuZXNkYXksIEp1bmUgMjYsIDIwMjQgNDo0NCBQTQ0KVG86IFNoYW5rYXIg
U2VhbCA8U2hhbmthci5TZWFsQG1pY3Jvc29mdC5jb20+DQpDYzogU2hhbmthciBTZWFsIDxTaGFu
a2FyLlNlYWw9NDBtaWNyb3NvZnQuY29tQGRtYXJjLmlldGYub3JnPjsgZHRoYWxlcjE5Njg9NDBn
b29nbGVtYWlsLmNvbUBkbWFyYy5pZXRmLm9yZzsgYnBmQGlldGYub3JnOyBicGZAdmdlci5rZXJu
ZWwub3JnDQpTdWJqZWN0OiBSZTogW0JwZl0gUmU6IFtFWFRFUk5BTF0gUkU6IFJlOiBXcml0aW5n
IGludG8gYSByaW5nIGJ1ZmZlciBtYXAgZnJvbSB1c2VyIHNwYWNlDQoNCg0KPj4gT24gTW9uLCBK
dW4gMjQsIDIwMjQgYXQgODo1MOKAr1BNIFNoYW5rYXIgU2VhbCA8bWFpbHRvOlNoYW5rYXIuU2Vh
bEBtaWNyb3NvZnQuY29tPiB3cm90ZToNCg0KPj4gSGVyZSBpcyBhIGJyaWVmIG92ZXJ2aWV3IG9m
IHdoYXQgd2UgaW50ZW5kIHRvIGRvIGluIHRoZSBlQlBGIGZvciBXaW5kb3dzIGNvZGU6DQoNCj4+
ICBUaGUgdXNlciBzcGFjZSBhcHAgd2lsbCBub3QgZGlyZWN0bHkgd3JpdGUgaW50byB0aGUgdW5k
ZXJseWluZyByaW5nIGJ1ZmZlciBvZiB0aGUgZUJQRiBtYXAuIEluc3RlYWQsIHRoZSB1c2VyIGFw
cCAodmlhIHRoZSBsaWJicGYgQVBJKSB3aWxsIHNlbmQgdGhlIGRhdGEgdmlhIGFuIElPQ1RMWzFd
IHRvIHRoZSBlQlBGIGNvcmUgKGEgV2luZG93cyBLZXJuZWwgIERyaXZlclsyXSkgIHRoYXQgbWFu
YWdlcyB0aGUgcmluZyBidWZmZXIgbWFwLiBUaGUgZHJpdmVyIHdpbGwgaW50ZXJuYWxseSBpbnZv
a2UgdGhlIHNhbWUgY29kZSB0aGF0IGltcGxlbWVudHMgdGhlIGJwZl9yaW5nYnVmX291dHB1dCBo
ZWxwZXIgZnVuY3Rpb24gdG8gd3JpdGUgdGhlIHVzZXIgcHJvdmlkZWQgZGF0YSBidWZmZXIgaW50
byB0aGUgcmluZyBidWZmZXIgbWFwLg0KDQo+PkkgYW0gbm90IGF3YXJlIG9mIGhvdyB0aGUgcmlu
ZyBidWZmZXIgbWFwIGlzIGltcGxlbWVudGVkIGluIHRoZSBMaW51eCBrZXJuZWwuIEJ1dCBwcmVz
dW1hYmx5IGEgc2ltaWxhciBhcHByb2FjaCBjb3VsZCBiZSB0YWtlbiBpbiBMaW51eCBhcyB3ZWxs
Pw0KDQo+PiBbMV0gaHR0cHM6Ly9sZWFybi5taWNyb3NvZnQuY29tL2VuLXVzL3dpbmRvd3Mvd2lu
MzIvZGV2aW8vZGV2aWNlLWlucHV0LWFuZC1vdXRwdXQtY29udHJvbC1pb2N0bC0NCg0KPj4gWzJd
IGh0dHBzOi8vbGVhcm4ubWljcm9zb2Z0LmNvbS9lbi11cy93aW5kb3dzL3dpbjMyL2RldmlvL2Rl
dmljZS1pbnB1dC1hbmQtb3V0cHV0LWNvbnRyb2wtaW9jdGwtDQoNCkkgZG9uJ3QgdGhpbmsgdGhl
IExpbnV4IHNpZGUgY2FuL3Nob3VsZCB3b3JrIGxpa2UgdGhhdC4NCg0KQWxzbywga2VlcCBpbiBt
aW5kIHRoYXQgeW91ciBIVE1MLWJhc2VkIG1lc3NhZ2VzIGFyZSBub3QgcmVhY2hpbmcgbWFpbHRv
OmJwZkB2Z2VyLmtlcm5lbC5vcmcuIFNvIHBsZWFzZSBmaXggeW91ciBIVE1MIHNldCB1cCBhbmQg
Y29udGludWUgY29udmVyc2F0aW9uIG92ZXIgbWFpbHRvOmJwZkB2Z2VyLmtlcm5lbC5vcmcuDQoN
ClRoYW5rcywNClNoYW5rYXINCuCmtuCmguCmleCmsCDgprbgp4DgprINCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogQW5kcmlpIE5ha3J5aWtvIDxtYWls
dG86YW5kcmlpLm5ha3J5aWtvQGdtYWlsLmNvbT4NClNlbnQ6IE1vbmRheSwgSnVuZSAyNCwgMjAy
NCA4OjM2IFBNDQpUbzogU2hhbmthciBTZWFsIDxtYWlsdG86U2hhbmthci5TZWFsQG1pY3Jvc29m
dC5jb20+DQpDYzogU2hhbmthciBTZWFsIDxTaGFua2FyLlNlYWw9bWFpbHRvOjQwbWljcm9zb2Z0
LmNvbUBkbWFyYy5pZXRmLm9yZz47IGR0aGFsZXIxOTY4PW1haWx0bzo0MGdvb2dsZW1haWwuY29t
QGRtYXJjLmlldGYub3JnIDxkdGhhbGVyMTk2OD1tYWlsdG86NDBnb29nbGVtYWlsLmNvbUBkbWFy
Yy5pZXRmLm9yZz47IG1haWx0bzpicGZAaWV0Zi5vcmcgPG1haWx0bzpicGZAaWV0Zi5vcmc+OyBt
YWlsdG86YnBmQHZnZXIua2VybmVsLm9yZyA8bWFpbHRvOmJwZkB2Z2VyLmtlcm5lbC5vcmc+DQpT
dWJqZWN0OiBSZTogW0JwZl0gUmU6IFtFWFRFUk5BTF0gUkU6IFJlOiBXcml0aW5nIGludG8gYSBy
aW5nIGJ1ZmZlciBtYXAgZnJvbSB1c2VyIHNwYWNlDQoNCg0KDQpPbiBUaHUsIEp1biAyMCwgMjAy
NCBhdCAxMTo0OeKAr1BNIFNoYW5rYXIgU2VhbCA8bWFpbHRvOlNoYW5rYXIuU2VhbEBtaWNyb3Nv
ZnQuY29tPiB3cm90ZToNClNpbmNlIEkgaGF2ZSBub3QgaGVhcmQgYmFjayBvbiB0aGlzIHRvcGlj
LCBJIGFtIGFzc3VtaW5nIHRoYXQgdGhlcmUgYXJlIG5vIHN0cm9uZyBvcHBvc2l0aW9ucyB0byB0
aGlzIGlkZWEuDQoNClNvIEkgYW0gc2hhcmluZyB0aGUgc2lnbmF0dXJlIG9mIHRoZSBwcm9wb3Nl
ZCB1c2VyIEFQSS4NCg0KICAgICAvKioNCiAgICAqIEBicmllZiBXcml0ZSBkYXRhIGludG8gdGhl
IHJpbmcgYnVmZmVyIG1hcCBmcm9tIHVzZXIgc3BhY2UuDQogICAgKg0KICAgICogQHBhcmFtIHJp
bmdfYnVmZmVyX21hcF9mZCByaW5nIGJ1ZmZlciBtYXAgZmlsZSBkZXNjcmlwdG9yLg0KICAgICog
QHBhcmFtIGRhdGEgUG9pbnRlciB0byBkYXRhIHRvIGJlIHdyaXR0ZW4uDQogICAgKiBAcGFyYW0g
ZGF0YV9sZW5ndGggTGVuZ3RoIG9mIGRhdGEgdG8gYmUgd3JpdHRlbi4NCiAgKiBAcmV0dmFsIDAg
VGhlIG9wZXJhdGlvbiB3YXMgc3VjY2Vzc2Z1bC4NCiAgKiBAcmV0dmFsIDwwIEFuIGVycm9yIG9j
Y3VyZWQsIGFuZCBlcnJubyB3YXMgc2V0Lg0KICAgICovDQogICBpbnQNCiAgIHJpbmdfYnVmZmVy
X3VzZXJfX3dyaXRlKA0KICAgICAgIGZkX3QgcmluZ19idWZmZXJfbWFwX2ZkLCBjb25zdCB2b2lk
KiBkYXRhLCBzaXplX3QgZGF0YV9sZW5ndGgpOw0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91
IGhhdmUgYW55IHF1ZXN0aW9ucyBhYm91dCB0aGlzIEFQSS4NCg0KSSB0aGluayB0aGUgZGV2aWwg
d2lsbCBiZSBpbiB0aGUgZGV0YWlscy4gQVBJIGl0c2VsZiBtYWtlcyBzZW5zZSAoeW91IGNhbid0
IHNpbXBsaWZ5IGl0IGZ1cnRoZXIgb3IgbWFrZSBpdCBtdWNoIGRpZmZlcmVudCksIGluIHRoZSBl
bmQsIHlvdSBhcmUganVzdCBzZW5kaW5nIGFuIGFycmF5IG9mIGJ5dGVzIGludG8gcmluZ2J1Zi4N
Cg0KQnV0IHRoZSBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzIGFyZSB3aGF0IG1hdHRlcnMuIEhvdyB0
aGUgbm90aWZpY2F0aW9uIHdvcmtzLiBIb3cgdXNlciBzcGFjZSB3b24ndCBicmVhayBrZXJuZWwg
ZXZlbiBpZiBpbnRlbnRpb25hbGx5IHRyeWluZywgZXRjLiBJdCdzIG5vdCBjbGVhciB3aGVyZSB5
b3UgaW50ZW5kIHRvIGltcGxlbWVudCB0aGlzLCBldGMuDQoNCg0KVGhhbmtzLA0KU2hhbmthcg0K
4Ka24KaC4KaV4KawIOCmtuCngOCmsg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCkZyb206IFNoYW5rYXIgU2VhbCA8U2hhbmthci5TZWFsPW1haWx0bzo0MG1p
Y3Jvc29mdC5jb21AZG1hcmMuaWV0Zi5vcmc+DQpTZW50OiBXZWRuZXNkYXksIEp1bmUgNSwgMjAy
NCAxMDowMSBQTQ0KVG86IGR0aGFsZXIxOTY4PW1haWx0bzo0MGdvb2dsZW1haWwuY29tQGRtYXJj
LmlldGYub3JnIDxkdGhhbGVyMTk2OD1tYWlsdG86NDBnb29nbGVtYWlsLmNvbUBkbWFyYy5pZXRm
Lm9yZz47ICdBbmRyaWkgTmFrcnlpa28nIDxtYWlsdG86YW5kcmlpLm5ha3J5aWtvQGdtYWlsLmNv
bT4NCkNjOiBtYWlsdG86YnBmQGlldGYub3JnIDxtYWlsdG86YnBmQGlldGYub3JnPjsgbWFpbHRv
OmJwZkB2Z2VyLmtlcm5lbC5vcmcgPG1haWx0bzpicGZAdmdlci5rZXJuZWwub3JnPg0KU3ViamVj
dDogW0JwZl0gUmU6IFtFWFRFUk5BTF0gUkU6IFJlOiBXcml0aW5nIGludG8gYSByaW5nIGJ1ZmZl
ciBtYXAgZnJvbSB1c2VyIHNwYWNlDQoNCg0KWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9t
IHNoYW5rYXIuc2VhbD1tYWlsdG86NDBtaWNyb3NvZnQuY29tQGRtYXJjLmlldGYub3JnLiBodHRw
czovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24NCg0KVGhhbmtzIERhdmUg
YW5kIEFuZHJpaS4NClBlciBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvOTA3MDU2LywgdGhlIEFQ
SSB0aGF0IHlvdSBtZW50aW9uZWQNCiJwcm92aWRlcyBzaW5nbGUtdXNlci1zcGFjZS1wcm9kdWNl
ciAvIHNpbmdsZS1rZXJuZWwtY29uc3VtZXIgc2VtYW50aWNzIG92ZXIgYSByaW5nIGJ1ZmZlci4i
DQoNCkJ1dCB0aGlzIGlzIG5vdCB0aGUgZGVzaXJlZCBiZWhhdmlvciBmb3Igb3VyIGNhc2UuIFdl
IHdhbnQgYm90aCBicGYgcHJvZ3JhbXMgaW4ga2VybmVsIG1vZGUgYW5kIHVzZXIgYXBwbGljYXRp
b24gdG8gYmUgYWJsZSB0byB3cml0ZSB0byB0aGUgc2FtZSByaW5nIGJ1ZmZlciwgd2hpY2ggY2Fu
IGJlIGNvbnN1bWVkIGJ5IGEgKHBvdGVudGlhbGx5IGRpZmZlcmVudCkgdXNlciBhcHBsaWNhdGlv
bi4NCkFzc3VtaW5nIG5vIHN1Y2ggQVBJIGV4aXN0cywgZG8geW91IHNlZSBhbnkgc3Ryb25nIHJl
YXNvbiBhZ2FpbnN0IHdyaXRpbmcgc3VjaCBhbiBBUEk/IElmIG5vdCwgd2Ugd291bGQgbGlrZSB0
byBpbXBsZW1lbnQgb25lIGluIGh0dHBzOi8vZ2l0aHViLmNvbS9taWNyb3NvZnQvZWJwZi1mb3It
d2luZG93cyBhbmQgZXZlbnR1YWxseSBwcm92aWRlIGEgTGludXggaW1wbGVtZW50YXRpb24gYXMg
d2VsbC4NCg0KVGhhbmtzLA0KU2hhbmthcg0K4Ka24KaC4KaV4KawIOCmtuCngOCmsg0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBkdGhhbGVyMTk2OD1t
YWlsdG86NDBnb29nbGVtYWlsLmNvbUBkbWFyYy5pZXRmLm9yZyA8ZHRoYWxlcjE5Njg9bWFpbHRv
OjQwZ29vZ2xlbWFpbC5jb21AZG1hcmMuaWV0Zi5vcmc+DQpTZW50OiBUdWVzZGF5LCBNYXkgMjgs
IDIwMjQgMTA6NDIgQU0NClRvOiAnQW5kcmlpIE5ha3J5aWtvJyA8bWFpbHRvOmFuZHJpaS5uYWty
eWlrb0BnbWFpbC5jb20+OyBTaGFua2FyIFNlYWwgPG1haWx0bzpTaGFua2FyLlNlYWxAbWljcm9z
b2Z0LmNvbT4NCkNjOiBtYWlsdG86YnBmQGlldGYub3JnIDxtYWlsdG86YnBmQGlldGYub3JnPjsg
bWFpbHRvOmJwZkB2Z2VyLmtlcm5lbC5vcmcgPG1haWx0bzpicGZAdmdlci5rZXJuZWwub3JnPg0K
U3ViamVjdDogW0VYVEVSTkFMXSBSRTogW0JwZl0gUmU6IFdyaXRpbmcgaW50byBhIHJpbmcgYnVm
ZmVyIG1hcCBmcm9tIHVzZXIgc3BhY2UNCg0KW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJv
bSBkdGhhbGVyMTk2OD1tYWlsdG86NDBnb29nbGVtYWlsLmNvbUBkbWFyYy5pZXRmLm9yZy4gTGVh
cm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5k
ZXJJZGVudGlmaWNhdGlvbiBdDQoNCkFuZHJpaSBOYWtyeWlrbyA8bWFpbHRvOmFuZHJpaS5uYWty
eWlrb0BnbWFpbC5jb20+IHdyb3RlOg0KDQo+IE9uIFR1ZSwgTWF5IDI4LCAyMDI0IGF0IDk6MzLi
gK9BTSBTaGFua2FyIFNlYWwNCj4gPFNoYW5rYXIuU2VhbD1tYWlsdG86NDBtaWNyb3NvZnQuY29t
QGRtYXJjLmlldGYub3JnPiB3cm90ZToNCj4gPg0KPiA+IEFkZGluZyBtYWlsdG86YnBmQHZnZXIu
a2VybmVsLm9yZw0KPiA+DQo+ID4gQSBjb21tb24gdXNlIGNhc2Ugb2YgYW4gQlBGIHJpbmcgYnVm
ZmVyIG1hcCB0byB1c2UgYXMgYSBxdWV1ZSBvZg0KPiA+IGV2ZW50cyBnZW5lcmF0ZWQgYnkgQlBG
IHByb2dyYW1zIHRoYXQgY2FuIGJlIHJlYWQgaW4tb3JkZXIgYnkgdXNlcg0KPiA+IHNwYWNlIGFw
cGxpY2F0aW9ucy4gSSBoYXZlIGEgc2NlbmFyaW8gcmVxdWlyZW1lbnQgZm9yIGEgdXNlciBzcGFj
ZQ0KPiA+IGFwcGxpY2F0aW9uIHRvIHdyaXRlIGludG8gYSByaW5nIGJ1ZmZlciAob3Igc2ltaWxh
cikgbWFwLCBzdWNoIHRoYXQNCj4gPiBldmVudHMgYnkgQlBGIHByb2dyYW1zIGluIGtlcm5lbCBh
bmQgdXNlciBzcGFjZSBhcHBsaWNhdGlvbnMgYXJlDQo+ID4gaW50ZXJsZWF2ZWQgaW4gdGhlIG9y
ZGVyIHRoZXkgd2VyZSBnZW5lcmF0ZWQsIHRoYXQgY2FuIGJlIGNvbnN1bWVkIGJ5DQo+ID4gYW5v
dGhlciB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uDQo+ID4NCj4gPiBJIHdvdWxkIGxpa2UgdG8gaW1w
bGVtZW50IHRoaXMgbmV3IGZlYXR1cmUgaW4gdGhlDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9taWNy
b3NvZnQvZWJwZi1mb3Itd2luZG93cyBwcm9qZWN0LiBCdXQgYmVmb3JlIEkgZ28gYWhlYWQgd2l0
aA0KPiB0aGUgaW1wbGVtZW50YXRpb24sIEkgd2FudGVkIHRvIGNoZWNrIGlmIHRoZXJlIGlzIGFu
eSB3YXkgdG8gYWNjb21wbGlzaCB0aGlzIGluDQo+IExpbnV4IHRvZGF5PyBJZiBub3QsIGlzIHRo
ZXJlIGFueSByZWFzb24gd2h5IHRoaXMgc2hvdWxkIG5vdCBiZSBkb25lPw0KPg0KPiBZZXMsIHRo
ZXJlIGlzLiBTZWUgdXNlcl9yaW5nX2J1ZmZlciAoWzBdLCBbMV0pLg0KPg0KPiAgIFswXQ0KPiBo
dHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvDQo+IHVzZXJfcmluZ2J1Zi5jDQo+ICAgWzFdDQo+
IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdXNlcl8NCj4gcmluZ2J1Zl9zdWNjZXNzLmMNCg0KQm90
aCBvZiB0aG9zZSBsaW5rcyBnbyB0byBHUEwgY29kZSBzbyBJIHN1c3BlY3QgU2hhbmthciBjYW5u
b3QgdXNlIHRob3NlIGxpbmtzLg0KSSB0aGluayB0aGUgYW5zd2VyIGlzIHRoYXQgQlBGX01BUF9U
WVBFX1VTRVJfUklOR0JVRiBpcyBkZWZpbmVkIGZvciB0aGlzDQpwdXJwb3NlIGFuZCBTaGFua2Fy
IGNhbiByZWFkIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy85MDcwNTYvDQoNClRoYW5rcywNCkRh
dmUNCg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcKVG8gdW5zdWJzY3Jp
YmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

