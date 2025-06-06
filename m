Return-Path: <bpf+bounces-59849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3751FACFEA2
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 11:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13FC176277
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 09:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D3B286430;
	Fri,  6 Jun 2025 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eDXc9HHY"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF532853F8;
	Fri,  6 Jun 2025 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200429; cv=fail; b=lZxlc4ZNq50hI3AiGoE64sxwBPrryydEEk0NxFgRGOXmHSD6N3is2gacyitvGBrx1VEpEIhLP7r5sFKnLRjBj5d6a0gJT78z2nLo+8KiLlm2Tc2HBmqyubloBsjm7+JF5X9h83onBt5JC+0UApaTEvqngNMknORQTpZIZSh6lbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200429; c=relaxed/simple;
	bh=V+K/b2IrXDmFlcbL+ja7aFrZUUtQcX5tmthaHEqGdpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S3aBNyj/MdwtsSA0us+Jpm1cLvAai89hFbFvqjM0r55zmPAaGatJxbcYYmSyOJydqr9PXezlmZgQDFylPJgd3BAVJre8ovH+YiYBIge1nNwEn2b0IV6l2/kFFJNXdtmLSG65nAG8BQW9OYxRBZvUJ8qMR5MiLdExNFJmjNxgw24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eDXc9HHY; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgvzHyNMVUbs3TEQ4BtuouNQJAZENPV8mzWbGSYK00wTREsTP/QUEutnojkA+SmTxCGJtiHmpGwn1k8U1hLtx7Zmru1KlSV2CLvQLxJQmgZQtYmQfRJ3qO5VNmyZu2ogejFImPb/kVDHeWqZhZYuzgQ/rZOdMLQVQGMD9hhGd6fBZSu0PgLvLdhWuVRGhFXviXhXwKWvWgLWTI0B422xOAXZ/37IBXBa4sjX4RhbRLYcJCvj3BqqLvmoPxyu7YsAlZNVhVZjZTZ6aj7rctopRc+iPfS8WOtx77/dU9ywjDb8KzGb5DE+yHdGRlBK+e0szfuQJknSerXpbOuN4ygJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+K/b2IrXDmFlcbL+ja7aFrZUUtQcX5tmthaHEqGdpI=;
 b=C3sFsriMD5wdMmDIVown0Ywb04qvNM61rG5KhzUSrCNBnYQw+Q3ITV3B70XviLNWSw9KwKZImnldWeR1ODVk5RbVc7NSqLyJw0JYqGckd+uLt/0aAGHQten0F2FRO7i93mu8WP20tCzxtRuyUuqdf7x+IAk6y6zZvSH9GaAOvnn2XbkG92AK30rfStnLD1lKodBFXdvUhdhuBUoWNYIqhSw50/6EUzVqqiHb1VPqnrpsZU1ygldF4Nu5YG1u5r8r58OVyujg0iw5JrUyY1QH+gyoG2xvfC39weboDONdmq71XD9y7rk1NSJ0+5ChjcgpLpMYd3iu7kaEleaubtP2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+K/b2IrXDmFlcbL+ja7aFrZUUtQcX5tmthaHEqGdpI=;
 b=eDXc9HHYD/s6QaPCBxWOJHY6BWCBnYIp0zfdwZQTioCBKBrU6MJ8zB924dWrKZEREyG2qVa9BwAvYIHWz/4JsoaQWS3LrlE6U/XZWJg2w28xC8EC5+S1VTMPiKCSARNRfw69iYNZgMF4R+nWtLI/weS4A0BoaNwjGIKjwFl1SV2HYlC4b81tAeDqV0e74uEIo7p67yH+6UTdt/byZ/EwovSnIV8ShywKoziU47vSYHwNgd1oVEfmO4G6iHSyBpyW4oCNA0o9ouOTTPMg87ULxxUwnH6598U9A33+G0BYGyei8n1vw0itgx2VWU3OsNC9qkWZod/2+cuVlg3xzUUYAQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DS7PR12MB6357.namprd12.prod.outlook.com
 (2603:10b6:8:96::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 09:00:24 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8655.033; Fri, 6 Jun 2025
 09:00:23 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "stfomichev@gmail.com"
	<stfomichev@gmail.com>, "almasrymina@google.com" <almasrymina@google.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "hawk@kernel.org"
	<hawk@kernel.org>, "leon@kernel.org" <leon@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, Tariq Toukan
	<tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Moshe
 Shemesh <moshe@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next V2 00/11] net/mlx5e: Add support for devmem and
 io_uring TCP zero-copy
Thread-Topic: [PATCH net-next V2 00/11] net/mlx5e: Add support for devmem and
 io_uring TCP zero-copy
Thread-Index:
 AQHby2JnWbRK2QGPS0ishQmLipVYlrPmq6eAgAEgIwCAAGxkAIAAeYGAgAABOQCAAMs/AIAMbfOA
Date: Fri, 6 Jun 2025 09:00:23 +0000
Message-ID: <b51a92bb8f4b46e9370b93d68a0a994e9c7289d1.camel@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
	 <aDXi3VpAOPHQ576e@mini-arch>
	 <izjshibliwhxfqiidy24xmxsq6q6te4ydmcffucwrhikaokqgg@l5tn6arxiwgo>
	 <aDcvfvLMN2y5xkbo@mini-arch>
	 <CAHS8izMhCm1+UzmWK2Ju+hbA5U-7OYUcHpdd8yEuQEux3QZ74A@mail.gmail.com>
	 <aDeWcntZgm7Je8TZ@mini-arch>
	 <phuigc2himixvyaxydukgupqy2oxpobj6qo4m4hb6vsr5qenfd@7q4ct2c5gjdq>
In-Reply-To: <phuigc2himixvyaxydukgupqy2oxpobj6qo4m4hb6vsr5qenfd@7q4ct2c5gjdq>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DS7PR12MB6357:EE_
x-ms-office365-filtering-correlation-id: 94cab8b6-a694-4485-2d6e-08dda4d892c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0tzQ255Y1V6YVppeno2QW1wVnpvWllwVHRMbTVCRWU3cmdBUnRIejZGM0dM?=
 =?utf-8?B?c2xoTktHSjNtUm1iRUZxWDlkTkpuYTMvZytDbncwTXdlRUphU3gxYU1ERFFF?=
 =?utf-8?B?M29ybUJsSkFPVTh4bG9XbjZaWCtxMFU3akl2WGZTUzh6Y1luQXhhVDlNWllk?=
 =?utf-8?B?UHpZUUF6M2QyajUzZTEzbU9NN0xMT2p0UWFvS1N3cW5qcVBRSmFxL2ZUSFpQ?=
 =?utf-8?B?djVCaXJFeU50SDFKbXh4WVRCRER2dy9zNUxHZVdVTWJseVpJcmhsSS9jOXJQ?=
 =?utf-8?B?MnNmZDdQTGFyOG5YR3d1cWxqNTJhdlFkVjljOFgxTUNiU0oxMEpDeHQxd3A0?=
 =?utf-8?B?RURLUitFc0xJT2RKQmdkaTVhdEdZVnRVeFFZdjdQc0g1UmV0Vkd5NmVSdGdH?=
 =?utf-8?B?NzU3SENtNEtlOTZQaTVNSmhYVnAvSFdRTHdIRHZtQXJpbUUxaDBYcjJxQkQx?=
 =?utf-8?B?MGt3OEVKczlBcVBXcXhzOUlQRmsyOHJ5SlE4UEpYa1k4Mnk1SzNLRy82NnND?=
 =?utf-8?B?cGRsQTRkd1RxcXVVWUljM0ZOempPa2dScjhTbXArSkdLa1Ruck1zMDIxRDll?=
 =?utf-8?B?Y1ROeXlYRk1YYkZ0NStDOUw2SS95czJTbDlHVm5ldFNDdXo0VmxReFU5OGFK?=
 =?utf-8?B?ay9qZllUL3ZXbFJwbnZqbWppTDZMS2R5TjZJaG1ERHQrTlBDNFREYWRsWWxO?=
 =?utf-8?B?M1YxTzVyS0NuQndReVpDWEFyNDd2QXBueElxdUJHc3BjT0dHOXZacktDbTZR?=
 =?utf-8?B?SjZTSlY5T09hbVJPZVZSTURpVFNhOURESURCM3g1VUcrTVpWWE1GRm9McWJY?=
 =?utf-8?B?NzFmQitYN2hjZVFIazQ3L1VRcWxUa0VSQnRTSVJ4QnZxczVsR3c4dlpKdERX?=
 =?utf-8?B?ZmpRekQ2bFFVTHprS0psUmtBRDIrcytNV0Q4WDUyNS8wajlUN0lMZkFNc2lx?=
 =?utf-8?B?eHRRQmNYQjY3eGR0VWJDd3ZaTE9aZVcrc3FKNWEyaU9zMkY3K0dvUmNWUjIw?=
 =?utf-8?B?RzA1UlVzWnZoRGsxRXNxdU5LOGloV3dTbDA4UXBMeFZ6TnFjSWg0WGRFa083?=
 =?utf-8?B?NHlka2Vzb24rYjBROG4rK1c5UlFmM0RuVkk0dkR3b28zcUtDMFB0M21JWnNU?=
 =?utf-8?B?ODNJMHdyK2JVUVM1dlAwdys3OFB1MURWeCt4TUFMOS8xOGdqeXQ5WWZCK3lZ?=
 =?utf-8?B?T084VVVoWm5td01jZUQxZHpFN2xvS1RVckIwaTZjS3l5bjVMbDVMMzNLeHFC?=
 =?utf-8?B?ZDVUeE1lUjlxRWlnamorOE9PVlpaOEFjcERNaWNMT0JBSWZqL1Y4Wmc0cFJD?=
 =?utf-8?B?TlA5M3NZbEtxOEUyOVBheWsxOGMyTndJb3JibVJQb1ZEcW55WWJwMlFDdDVi?=
 =?utf-8?B?dlNITDYra1lPejBWb0x0Qm1PVWxTWmhSa3hyMGp1Q3ViSTJMVUw1c3p5U0dm?=
 =?utf-8?B?akFrcWp5Z2RnTXJJSWZlSDFWTmxZVU1pSFRNYlZHNmh3TFJRZHlCNXBIRktL?=
 =?utf-8?B?VnNIaE5palpKRjBUMy9JaFovK1k1aExWK1dHTitiVlFlUDRINTJNMEFRcHRF?=
 =?utf-8?B?T3BpeDZaOHhWV05EVTFmZmYva3YzbU9xMmlzcnRqNmZHWi9DTUpQeHlCNlcw?=
 =?utf-8?B?OXZqZjVzbm9Xb09LWEYydUJ3eE1OTmlVV0E5VldEOXpDVytFUjNoY0pNMnVR?=
 =?utf-8?B?TVMyRUlEcTNYeU9sTXNZYmphVFl6aU9mNUZic2oxRU1JTm9saGY0UmJjK0RZ?=
 =?utf-8?B?cDBEQ0FsbmwyeGdTSTgxYUZXckJkdUdISjdjZlRvdHIxMXdwTCt2NjdQckpa?=
 =?utf-8?B?YzIxZ0RKN3lBUy9tcXhIUFI5SGRQTHNDMkdiK1VPbnFxeCtGQityR2c1bndv?=
 =?utf-8?B?RjUvTTQrSzU3dWV5SmpKS09FMHJmRlFDcXNCQ2FLbmVMUUI4c3d5aXdpd1dt?=
 =?utf-8?B?Z3hxU0R1bDJSK0I0Qm5OcTBsa1FacnVDZjQxeHB1ekY3S0dScGNsTmpCZmJ2?=
 =?utf-8?B?cllZbFMxYXpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3FzN0dMNlZ6U0NmMmhzcG5iMklBRHRsQ1k2OHZwcDgxU0xGUFJzRUxlTHN2?=
 =?utf-8?B?cFhmZ2xsM29YR05pNmdqL2M4TTdVZ1ZOUDF0T0haekpLcFZaUmJGQUUwN0lX?=
 =?utf-8?B?VnBjVGZmOTZvOVJOa0o2N1RjbytFVVdYN3NmOW9mbU1Oc0pwaDRFMlB1eVVy?=
 =?utf-8?B?d1lydE54RFFteW85UllmQXBFNjFFTXZRZXdJMkNCcVh6dS9JNVYzb1oyY3RH?=
 =?utf-8?B?a0l3K3F2WTdWWVNGZXpSWDl5ZHIrMTVXNmN2a1BKcklrMTFjU2JRSU03amNo?=
 =?utf-8?B?U1lZUHRUMEt4NG1MSDZ3dWVDSzZCUXV3V2g4dWNvcnlFd05KaUNPMVpSaFhM?=
 =?utf-8?B?cXlMelU4Z1dQeEtvMm1KeTBTRHVIVUpyV3paVXRFREFyNWJ0dlpLcUR5VFN1?=
 =?utf-8?B?QkM1V09sakxTTnZseHozYmJaNThHd2dWRU9kTndXcHNvWnROY3FNVEoyODUy?=
 =?utf-8?B?akcxTnlETDRwRGhQTjlvMDVOYmtpY0c5NTdZM0VGVk10ZC9mT1VtMzcwaGZL?=
 =?utf-8?B?QnJPYitWN2NGTmlNb2I1N0xNc0d0clYvMEc0aUtTMGFxdHRRSmNodGlETUhm?=
 =?utf-8?B?Mmx2TTJ3WTM5VlF3QnQ3dllsNFMwWUIyRU5CSmRoMERldEJDbkl0cm9RekZC?=
 =?utf-8?B?NDlkTGNkZ3V4ZG5EOHZMalpHTGFzWHQ4Ty8weUgyK2FlZ2p4WWVlZW4ybWpQ?=
 =?utf-8?B?Wmo0SlVRclViUjdMZUsrSnNwUVdOQW0xb3ZBVEROMGhyNEp6eTl6dTJubVRD?=
 =?utf-8?B?UE9yRHpFcmNzS25ycHlJOWFvZmVyKzYxbG9wa2p1S2Y1RWRSbE5GZXUyelAx?=
 =?utf-8?B?K2EyWEhwTkovbGJZYU1WYVMyMkJncnBCZlJpbkkzRnV1aWxXeWc2RWRBWWN1?=
 =?utf-8?B?YkZXSnhUMEhXUUc3NVNuL2JTLzU5VDU1SEFRRVEzWlRKRGMrdzNBUnlZbExS?=
 =?utf-8?B?bjBmSmpiQjUzdEpuWmhiRUt1YnhzY1E2Sk9lMzkzMUJGc0JxZ2M3cVRHeEJ6?=
 =?utf-8?B?VXVxS0FyREI2WE5RV3BNdnJ2Q2VaenMyb2h2UFVlMHR5NEIrbSs0ZlhrTnFY?=
 =?utf-8?B?Z3NDdTVVSkcrS1RQQStWN0Npc0lLT2dKYi9KVTNNeEsySGpkekQrSXVldity?=
 =?utf-8?B?MkU3VUNicWJWbDBQbEc1TjFXUm5FcEd5Y3UxZTlKSXV3cVJJWjBDM2FSYTRW?=
 =?utf-8?B?ZGJsSHQ0T1NYT3NZbkhYUEV5RjJhKzVHdkZHdStIQUIwN3lzK1FqcVhxS21q?=
 =?utf-8?B?aWdtbFlmZnR0TnNxQ1llQXVMZ1l6SkMzallOYWxWL3AzK0l4RCtEejFjYjFS?=
 =?utf-8?B?SktyamZVaG12dFlmVFY2TitpaUdHdlRoWTRCVGYweFFGdVR1RkIwU1lLRHlW?=
 =?utf-8?B?bW9kTE9tSHVpc3NITHdwVzA5ZXRYdjZyelZQcGRXN2JmNW05dGc2ejNZSFEx?=
 =?utf-8?B?SzdTVDRMek1Yckw2SVpqaFkvdXVySG55Z2M2c2duNXhndjc3UnNDRU94QmlV?=
 =?utf-8?B?R29HbTRBMDh3dnRkdm9lTHUxa0haM3poOWZZT2RJNU8yL29OeFoydjd2QUVn?=
 =?utf-8?B?aEsvdE5KQ0lEV3JKamZiMzl1OUcyMHVmS1ptYTQzUHNCcXcxVnE3TXRpcStS?=
 =?utf-8?B?OWF4NWx4ZHNaUzlpcm13SFgyUnhWOFBwS2ZhdHB5VEFwU1kvaS90NlVaekF1?=
 =?utf-8?B?Y1E0OElmdU96NjBoSDJPd2NZaWpRNkU4MlErV2xwK09mTzBDRFprU1Mzemcr?=
 =?utf-8?B?MFVHWVVxQ2tDTU0vdGM0SnpnTjMydkRaR1RWemVBbjBRV3hKK3ZCMWpXMVFp?=
 =?utf-8?B?ZENCdm8xWUNxZ0VwVnJVSnBadVhNYXArdjVGNzlQdlBGUHRlNzVrWGFwenlH?=
 =?utf-8?B?Zm00b2J1ZFRpc2orNUxDWE14bmpBL1lYVzMxd3VkSUhDSkVPcTF5UFFJWkRo?=
 =?utf-8?B?SHFUSU5TZ1phbnpHRUVCVzArODE0UFphNVpxci9pMVdnaHpOTWkwNFhaOXFv?=
 =?utf-8?B?TWxjemJCZTJsMWtGclljVGczZ2lXakRMU2J3L1ZEaEgvVVMrS2RNNDFkTHIv?=
 =?utf-8?B?dEtSaXZMaWdNVEpvNnlRS29weUg1YnphZzR5Y0NKMWRjRXJUOVZjTE44Uzl0?=
 =?utf-8?Q?7+hUVYtok/pBeSkXOKB8R4Xle?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7057BC76BD5F4043AB30A529DE45AAD3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cab8b6-a694-4485-2d6e-08dda4d892c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 09:00:23.8197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGPSaqCtC6MAD24aduopsxAw40sZN2Ni+KdH0X/GPuT7eRlGWESTE7wRV3Fb5cZNlCioSYS7+edInQyNr4VkhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357

T24gVGh1LCAyMDI1LTA1LTI5IGF0IDExOjExICswMDAwLCBEcmFnb3MgVGF0dWxlYSB3cm90ZToN
Cj4gDQo+IEFGQUlVIGZyb20gQ29zbWluIHRoZSBjb25kaXRpb24gaGFwcGVuZWQgb24gaW5pdGlh
bCBxdWV1ZSBmaWxsIHdoZW4NCj4gdGhlcmUgYXJlIG5vIGJ1ZmZlcnMgdG8gYmUgcmVsZWFzZWQg
Zm9yIHRoZSBjdXJyZW50IFdRRS4NCg0KVGhlIGlzc3VlIGhhcHBlbnMgd2hlbiB0aGVyZSBpc24n
dCBlbm91Z2ggbWVtb3J5IGluIHRoZSBwb29sIHRvDQpjb21wbGV0ZWx5IGZpbGwgdGhlIHJ4IHJp
bmcgd2l0aCBkZXNjcmlwdG9ycywgYW5kIHRoZW4gcnggZXZlbnR1YWxseQ0KZnVsbHkgc3RvcHMg
b25jZSB0aGUgcG9zdGVkIGRlc2NyaXB0b3JzIGdldCBleGhhdXN0ZWQsIGJlY2F1c2UgdGhlIHJp
bmcNCnJlZmlsbCBsb2dpYyB3aWxsIGFjdHVhbGx5IG9ubHkgcmVsZWFzZSByaW5nIG1lbW9yeSBi
YWNrIHRvIHRoZSBwb29sDQpmcm9tIHJpbmdfdGFpbCwgd2hlbiByaW5nX2hlYWQgPT0gcmluZ190
YWlsIChmb3IgY2FjaGUgZWZmaWNpZW5jeSkuDQpUaGlzIG1lYW5zIGlmIHRoZSByaW5nIGNhbm5v
dCBiZSBjb21wbGV0ZWx5IGZpbGxlZCwgbWVtb3J5IG5ldmVyIGdldHMNCnJlbGVhc2VkIGJlY2F1
c2UgcmluZ19oZWFkICE9IHJpbmdfdGFpbC4NCg0KVGhlIGVhc3kgd29ya2Fyb3VuZCBpcyB0byBo
YXZlIGEgcG9vbCB3aXRoIGVub3VnaCBtZW1vcnkgdG8gbGV0IHRoZSByeA0KcmluZyBjb21wbGV0
ZWx5IGZpbGwgdXAuIEkgc3VzcGVjdCBpbiByZWFsIGxpZmUgdGhpcyBpcyBlYXNpbHkgdGhlDQpj
YXNlLCBidXQgaW4gdGhlIGNvbnRyaXZlZCBuY2Rldm1lbSB0ZXN0IHdpdGggdWRtYWJ1ZiBtZW1v
cnkgb2YgMTI4IE1CDQphbmQgYXJ0aWZpY2lhbGx5IGhpZ2ggcmluZyBzaXplICYgTVRVIHRoaXMg
Y29ybmVyIGNhc2Ugd2FzIGhpdC4NCg0KQXMgRHJhZ29zIHNhaWQsIHdlIHdpbGwgbG9vayBpbnRv
IHRoaXMgYWZ0ZXIgdGhlIGNvZGUgaGFzIGJlZW4gcG9zdGVkLg0KDQpDb3NtaW4uDQo=

