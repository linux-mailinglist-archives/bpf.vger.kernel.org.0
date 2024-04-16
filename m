Return-Path: <bpf+bounces-27013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA528A788C
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 01:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB7D1F22875
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 23:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DDA13A869;
	Tue, 16 Apr 2024 23:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="uPe5Cl0z"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ABE2375B;
	Tue, 16 Apr 2024 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309931; cv=fail; b=dkESBOPyXl667ht2Nus0mdk35i/dCaF7c/djtbwFXfaEoqTS5SONu8mf/EiFTxLFMr/VD8Xn32KG33qWhGltS0UWDxuumf/1iGcyOgTauM++mmWD3U8rHw1F/JvQqGcuKThk0FuB5meW48/H5Uf9qiNlgv68PRRIaRnq6pgIV4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309931; c=relaxed/simple;
	bh=gFPrnkqx3NVi3+GzPo/GRI8nFPhTPu+XwXn1NQokQBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CI91m5xUjd2HG/POUdbP0KXfDyOnemdy58LrJ+3tYKuCZTdNEdSnd6of6WFAutVuFRf69XgG4KQ9Mx7C5e1etfauoEG8kdHFXCLW7AOEMnDkR2RT/kxTy0nRirGg/4SFuXmIdRvi3EKFzsDNXdQssvs3yz+6Wxm8oeH/xEW1Ifg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=uPe5Cl0z; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G6EnC5026553;
	Tue, 16 Apr 2024 06:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=a9JEITAo9hQd9VDZ7WauxvzVY5CuSzIrt4eEuEag+bM=;
 b=uPe5Cl0z7FHbwwZsj26V8Q9UPSAxDsAE18fxJWU/8xVIHfRcHYl1lKONL1ZOdxJYxTUx
 PXEEJ4bcZDIA96LwU94pilTp1G178s6zuzuYOKX42gbk48g2aVcXEFiYE/21P9vEXO2Q
 4+2gs/Zb32MILh7D/toLvlOalqqY2kadxnjzBghzvMMM3IwGpRkTSHISe0eaRXlOXeag
 BUiTrwytZIkLP+xTIjsbP48slAhYer6YDXUXHunUQxcL0DjzKnUFglV/rgHKVqIvvrKu
 ZZJiH6LqVL7jnvypkJgQC62jg3igdXFP1Q6y/63jVz9EKRHXIEBp7Jffjd5KbUr7fyDM 4w== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3xfmm8v2eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 06:36:29 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G8vNxw021463;
	Tue, 16 Apr 2024 06:36:29 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3xhnvgsp9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 06:36:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7pZVufW6Ag8noKl3GNzgv+jAhEhJkjSQW3gRfia/X9zOTvKskD/4i9UvhPHl0IiK8sgfWmQGGXJcNNdC+2W7l7d7xSIukm2UadT05c6AU7HEn6bTNo7xjn+kUgB8cacZ7QjEcg9i8vqZYMBhAa6m6W3wXT0ZyPoLiMOt+jBNzGlDldoyK7sepiCIvFKEZ1oseswdm9Yli+dA8GEUpIXzSvclEgPt29Id8vf0e6GbZI/TtVYOf600RoUuAqLWXg5d+pGpsZTCKgeZnt/uh5SjKhrCpHczgvVX6eddQMhAYrLIX3cGWRpwJQ96eoK0GXG3ECnQCtFavgw7I2FJFl+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9JEITAo9hQd9VDZ7WauxvzVY5CuSzIrt4eEuEag+bM=;
 b=nESuLKU6Z36zTWeN5V+fZM9KBKmecyEONZPu72DFY+wvlg6TfS1EniZgxLxO++MU7/B0dtEqF131X1MC+WrNsARNCr2ucpSNPNL9hqaGaj0LnN6B+3cu+lEnWPwNTx4XbFKxnLDCrz+kTbkv8qSufEV8acH9vzLl/wMMnFZDVsXxb7beHO97eDjFMO09M9R9xU6ntAug+6G32hFLRMvFqDvply3k8lpVBJ0vomkRojAYgAGfydU/MSpIM775OjvFuA3PwexiDJTweuU4YIYMOY2wN5KnvaPakCIcnXYiDzRBPfBWJ9pCbnyg6I6pF1OYCMBCcrFtzfVRyN+L5pUl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from IA1PR19MB6545.namprd19.prod.outlook.com (2603:10b6:208:3aa::12)
 by SA1PR19MB6918.namprd19.prod.outlook.com (2603:10b6:806:29f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 10:36:24 +0000
Received: from IA1PR19MB6545.namprd19.prod.outlook.com
 ([fe80::40b9:81ae:9b9b:8c66]) by IA1PR19MB6545.namprd19.prod.outlook.com
 ([fe80::40b9:81ae:9b9b:8c66%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:36:23 +0000
From: "Li, James Zheng" <James.Z.Li@Dell.com>
To: Eric Dumazet <edumazet@google.com>, Zheng Li <lizheng043@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH] neighbour: guarantee the localhost connections be
 established successfully even the ARP table is full
Thread-Topic: [PATCH] neighbour: guarantee the localhost connections be
 established successfully even the ARP table is full
Thread-Index: AQHaj+QRjYt3y/dXhUSCVOE2zaWf8rFqqowAgAAITeA=
Date: Tue, 16 Apr 2024 10:36:23 +0000
Message-ID: 
 <IA1PR19MB6545F5F1940C0B326058987ABB082@IA1PR19MB6545.namprd19.prod.outlook.com>
References: <20240416095343.540-1-lizheng043@gmail.com>
 <CANn89i+TKbGbmy0JJbyhUxQ9Zc_jj=EHv=bYXT5dUvQY7hw12g@mail.gmail.com>
In-Reply-To: 
 <CANn89i+TKbGbmy0JJbyhUxQ9Zc_jj=EHv=bYXT5dUvQY7hw12g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=e2bb6b5a-99a7-4a30-b44f-fc77fd5ca991;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-04-16T10:32:00Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR19MB6545:EE_|SA1PR19MB6918:EE_
x-ms-office365-filtering-correlation-id: 68b55b42-f750-428b-901d-08dc5e01101d
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-7?B?bzgvSzB4eFN0eHJiMnRJa1hQL2JGODNtQ2VmMDFlM1pEUTROc0taVnl6UXB3?=
 =?utf-7?B?VGpBUkZYSHJZaDZGeUpLQ2hORTFKb29yVVJmTmtxdmxidWdMSWRuYUc4R05n?=
 =?utf-7?B?RkJVUFlHUnFTYXM4dHp4emtaTWNRa20wZUxkaFJFMUxkVGg5TVJWUm1CaDZ5?=
 =?utf-7?B?cWU5dGtVSHhCNThlKy00bC9TU3Z0bloyL3FTSTNJRjR2STRWbVRIVkxGd0Z2?=
 =?utf-7?B?bDJVc0RXeXBNRnkrLWYwTUZMc3U4b05TTEFmUXJVNForLXFaUVU1VzFBa3FT?=
 =?utf-7?B?TExTVy9uUmlub0pOM2hlNWVlVXZxM0tiL083QkhYQklxZFlwYk1WTm5ERVhN?=
 =?utf-7?B?NSstNlAvL2Q3SlZQYjZjZDg0UkJKN0xpNFFGRjR6b1F6MW81elROa2JWUS9J?=
 =?utf-7?B?c1UzZm1jdEZ2TUE1anRBZTB4RnhWNmc3R2MvRGo4OEJtb2lka2kxZTNGakdk?=
 =?utf-7?B?TGQ2dUpOU0Y0b1VubEJtVGlTTHBZWXU4R1E0TjlaRThQT1lKSGhJUGc2eXhZ?=
 =?utf-7?B?dkNSUkpQVWorLXRYV1F1OTN6ZTZlWmRGd09PUDBjMG90a0hadkdBNmh6UGhT?=
 =?utf-7?B?OU55TW9hcnJ1WGFDbEE1eDQ3eCstYlZiaHZ2UXJRTVRKME90a3FaVHZ5c0J3?=
 =?utf-7?B?a2J2alhDYUNLY1U4ek9EamJIUkUybjZKZUVyMVM1WkpMVHpzVWNOdS9ENFM1?=
 =?utf-7?B?WXp2ZjR2UzBUOVZTcXhwMmlrOFdVSlROOGhUVml3azV5Q1dJVnMzU2tvWWtm?=
 =?utf-7?B?Y3IxV2dNL3AwS1k5R0hEdWludU4vMFUrLU1wNDFyeTVWQnBpWHJleXhXNSst?=
 =?utf-7?B?b1EwNHhCd1BPQzdnR0llclpXdUV3VUszUXlKRFMwQXptS0E1YWxiaHErLUlp?=
 =?utf-7?B?V0VyN2lyalNTRWYwVVIrLWVvZm8yWTRqb3N2S1lBaTcrLXFEN2FmMTJoM0tG?=
 =?utf-7?B?cnpsMUJyYkNyY1RUbENmOHhvc09oUE9tUTJqOUN0aHhMMnBnSWs1aWdHcEk4?=
 =?utf-7?B?SUU4c2lkd3lMQ0kwTDNTR3ZHNjQ3WFFRZkRYeHRWQzNFeUljSmQ0RjQyUlQ3?=
 =?utf-7?B?QXMrLVBnZEVLeW1kOGFKMUhCdFJIRzJvTXUyN0tEZDJTbW9EMjNPOGFVN3VG?=
 =?utf-7?B?Rkw5L2hPVzczZlZKTFU0NU52SWduQkRrMHBFcll4SDdvZEl3aHc5MnJEcC9D?=
 =?utf-7?B?UmxtekpIdnh4NklQTCstR1JCZVJ2WnkvZUd0RW9qblozdUdpM2Q1bnVHSjMw?=
 =?utf-7?B?V3M3SG5pRU1iYTNnNzlwd2duY253UEswdHg4eGVRY0VNeHJxelVQQnA1MnB2?=
 =?utf-7?B?WmRPMkhZMTRKdGgwek0wNUh2c3NwTUlHZXd1NkUwdDhnNEhBakRDS090SWFC?=
 =?utf-7?B?bDJFVHFiU0xTKy1XMGV2VzhaTUt2RE9tcXFjWG1XT0FIVEtxTTNmd2cwY09W?=
 =?utf-7?B?NjFydDFYdGQrLWd4SFQySDNxWm14V1hkWDhsV2lJTEx2cHVzUDM4V3dxWGdI?=
 =?utf-7?B?U29CRWUyNmVSS0d1WjRrdE8rLXBBMUcrLTRYUWpsMFdySnBCYllaVksrLTFU?=
 =?utf-7?B?TnpzZnhUVHVBbUpHdFBObW1WVlpYVGZqcmpZOVduOWRIVzZqckRxV0ZQVCst?=
 =?utf-7?B?TVc4NFJFUENKQjJxRkJSVy9yVTZhM0xHSmViWlAvWUM5c3F3aHd4Mk5Gcjhh?=
 =?utf-7?B?ckMxZElmUG05V2xnVy9odmYrLUxUUTJtcU10dmRJNnJ3dFQwOG5tZnkrLTh1?=
 =?utf-7?B?MXhwNDFBcUNCdlgyT3p4cXBYWlU3UXdPd2hTS2FibnMrLVEvcDl0aUV5aktC?=
 =?utf-7?B?SlFiVklMUnpLejRRTTNNdmpka0k5c2NkQkxpM0FLYTJoTFNFWEErQUQwLQ==?=
 =?utf-7?B?K0FEMC0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR19MB6545.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?ZG5mYk1QLzBQSEFHeistQU5EVzhxRDBONXl4WUR5bkkvdjEzUGowL3FmdXRk?=
 =?utf-7?B?TFBQaWdpVTJYWmRTYmxCMVZiKy0vNUt0R0daZ0VIb3R2THJLUjBoU2lJQXZ3?=
 =?utf-7?B?R0pFWVVJL2VsM3g5U2RMV0tmaFNZeXp6TW1BTC9oKy1ObFNweFQycXV5L1U1?=
 =?utf-7?B?OTZWOHY0Y09PTDlldUZWaTU5NFpMUWs1cSsteistQ2dJSDk3WHNPeDRzR1U=?=
 =?utf-7?B?Ky1zMGxBQkFkTEUrLXVTeWhrcWRNZm1mNmUyMUtCVkt6YnpXQmJ0SzhPSGdG?=
 =?utf-7?B?V3Q5a3VwbHM3NnI2SnVGblZBS1B4M1dxdnhvQjVZUVp1c0oxanU5RzZUY0I4?=
 =?utf-7?B?UC9ka0NFeE5tL0M5c0svNzhyYTNnQWlOYnhxSm1LaWVaWi9hdEc0c2NWZGE0?=
 =?utf-7?B?OEV1dmR4bGU2NGtON2U5TVljSXc1ZUpqMmNoNkxsVkUyaDZSNTlCc0puSDFI?=
 =?utf-7?B?TmlxLzFuVnZUellobklxSWxCTzV1ZUdQNVFmR1NjbnE2d0FxcjBMTGU4WW9Q?=
 =?utf-7?B?ZHZWaEFiQnZPRG1ydkZNKy1yMmR5TFVmZ1lFT1N4dGo4WGc2MkttbUFyd05F?=
 =?utf-7?B?YlZ1aE4rLTA3U2VXRC9hR0tBY0wrLThMNm1mUkFzN2kzbUF5RHQrLXBOeURj?=
 =?utf-7?B?UG9INkFtcXd3YXFoRWtFWWtncHVrYThlOEo5bDFrY0VzWnVLMmxCeDlzZTJO?=
 =?utf-7?B?TU5YVEVUbkowb2JrR3RkTy9FNVhPMmNoM1VGTFp6a09rdWJPR1plcUhXckIw?=
 =?utf-7?B?cy9sdFNPbzlUc0V4WDhqM2R6ZmxTUHJSaDdKKy1QTkpGM1Q1UVRGNE1zb2o2?=
 =?utf-7?B?UnN3OGY0dDk2VnhWMHczVjdsU1VydSstOUx6NThEbEY4WjBQeXBFRkRDdEsw?=
 =?utf-7?B?QnZ3bFI0NWtwV1YyWnhLNDZvNlQ5dWJubkZ1clNNOWJWa3Y4Mm5yVXZaZi9x?=
 =?utf-7?B?MGRlS0VRb1ZzNkRqM2RicmRHMmdsM1VaMEdiekFFWmdGV25YWGdFMlUyRHRz?=
 =?utf-7?B?ZWk3c05yNDkvZzd1UFplZHlrUmdsQ05vTThNRXpzRGZzaXJmTFlaVXd2MzJp?=
 =?utf-7?B?V29YYnJVejlub3o3cUF0UlMxWFFzMXVPRDloeistc2w1MFJEcGpRRnV1TVNC?=
 =?utf-7?B?T2kzR09rL0lrZ1RxZjFna2ZuOVh1Y2VWWjdCTXI3S3RuWUdlVEpOeWFkOGtL?=
 =?utf-7?B?SEpNR2hoL2ovQlh1YkZWYWx2MlV1cjVCeG9NWVI1S2dPS1ozUk1nTUEwTjdz?=
 =?utf-7?B?VzVjTWR1d1ZneC9oaG81a1NMSWJmNDdob0pZWTFFNU9WcmtHSGJNSm5SRVY3?=
 =?utf-7?B?enBNaFFaRFNGVDhWYWpnSVpyLzljM1d6QVZHdWFLRkp5MEthVXZ4WlJxT0Fz?=
 =?utf-7?B?MTVSSllVR1hONkNYeldaME1MU2pZQ3pCQUtOd2JEeVFENTBpZjdrTU1rLzVY?=
 =?utf-7?B?WFd2eFhkV2FEZUpaek9Ballidk93dystM1ZOWkZDVlFjZ0U5OEltc0YrLUtE?=
 =?utf-7?B?VHNTdEV5YUtQbXRZUzVMNktEeWo1R1JibVdNVGlrMlZyWHROMVRtSnkxVmFE?=
 =?utf-7?B?ZUpxOVdIcXBDMy9oVTdScjJ4MENyOTI1TXo0NVVwc00wS3FxR0lhd2lFeFFj?=
 =?utf-7?B?aWhZWnZoWTU5NTZrdVFHaFhhTmFBc0k0V0w1Y3RieXduL0M5c2tydFowTTFH?=
 =?utf-7?B?ZXZTTlhzUUpxS2ZGMistRE1NVnNoMElvdmhDbWdRd0t5ZmtaaW0vbVg1R3M1?=
 =?utf-7?B?clhCanNSLzdPQVpJcGpEMistUU15YUVzZHIrLUxIallCcmhpdEJjaHBSRzNH?=
 =?utf-7?B?eG9OWjJUZmdnR0UySG81cEExMlJoSVhjM0dSV2NkYXFzTmlYMXI5VFVicmw4?=
 =?utf-7?B?Qy9PT3BJbE1CKy1qVnVWc1NMU2ovTmpKbW91ZVFHcmJIL2hJS2I0MjZrNUk5?=
 =?utf-7?B?Z2RNVW95aEc0c2FUbzkyWUJ0QTc5QU1aR25nU0xEOFR3ZTRiTlcvYVlCR0g=?=
 =?utf-7?B?Ky1RUWp0YlhKYzlTTXJvVk0wbGdwVlR4U2ZwRDdBSVowYVRTUmF4OHhnNUlp?=
 =?utf-7?B?WXd2NzlNOVIwY2ZIME9jalE0SzJvZDZBMExtKy1wTlR6UmJWWE9tRm5wazM4?=
 =?utf-7?B?OEU1WllHai9VVFlZWktPZlJRU1RpWVZlRW4wR25UWnQ5RXpWL0w5THdtZ3ZD?=
 =?utf-7?B?eVRRSQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR19MB6545.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b55b42-f750-428b-901d-08dc5e01101d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 10:36:23.7520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YC1TP+hZTXCozGcfztWTHJ1ZlfCHTjQQTBbR9r+iqE2CxHOP9r3WJoOmBEbP12pvdMduLfNVzZ1U9lKGKZWaMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB6918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_07,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160064
X-Proofpoint-GUID: 9yS71TqFA7l-Wk7ARBFwHb0jZ9Y1Pw7w
X-Proofpoint-ORIG-GUID: 9yS71TqFA7l-Wk7ARBFwHb0jZ9Y1Pw7w
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160064




Internal Use - Confidential
-----Original Message-----
From: Eric Dumazet +ADw-edumazet+AEA-google.com+AD4-
Sent: Tuesday, April 16, 2024 6:02 PM
To: Zheng Li +ADw-lizheng043+AEA-gmail.com+AD4-
Cc: netdev+AEA-vger.kernel.org+ADs- bpf+AEA-vger.kernel.org+ADs- davem+AEA-=
davemloft.net+ADs- jmorris+AEA-namei.org+ADs- pabeni+AEA-redhat.com+ADs- ku=
ba+AEA-kernel.org+ADs- Li, James Zheng +ADw-James.Z.Li+AEA-Dell.com+AD4-
Subject: Re: +AFs-PATCH+AF0- neighbour: guarantee the localhost connections=
 be established successfully even the ARP table is full


+AFs-EXTERNAL EMAIL+AF0-

On Tue, Apr 16, 2024 at 11:54+IC8-AM Zheng Li +ADw-lizheng043+AEA-gmail.com=
+AD4- wrote:
+AD4-
+AD4- From: Zheng Li +ADw-James.Z.Li+AEA-Dell.com+AD4-
+AD4-
+AD4- Inter-process communication on localhost should be established
+AD4- successfully even the ARP table is full, many processes on server
+AD4- machine use the localhost to communicate such as command-line
+AD4- interface (CLI), servers hope all CLI commands can be executed
+AD4- successfully even the arp table is full. Right now CLI commands got
+AD4- timeout when the arp table is full. Set the parameter of
+AD4- exempt+AF8-from+AF8-gc to be true for LOOPBACK net device to keep loc=
alhost neigh in arp table, not removed by gc.
+AD4-
+AD4- the steps of reproduced:
+AD4- server with +ACI-gc+AF8-thresh3 +AD0- 1024+ACI- setting, ping server =
from more than
+AD4- 1024 same netmask Lan IPv4 addresses, run +ACI-ssh localhost+ACI- on =
console
+AD4- interface, then the command will get timeout.
+AD4-
+AD4- Signed-off-by: Zheng Li +ADw-James.Z.Li+AEA-Dell.com+AD4-
+AD4- ---
+AD4-  net/core/neighbour.c +AHw- 4 +-+-+--
+AD4-  1 file changed, 3 insertions(+-), 1 deletion(-)
+AD4-
+AD4- diff --git a/net/core/neighbour.c b/net/core/neighbour.c index
+AD4- 552719c3bbc3..47d07b122f7a 100644
+AD4- --- a/net/core/neighbour.c
+AD4- +-+-+- b/net/core/neighbour.c
+AD4- +AEAAQA- -734,7 +-734,9 +AEAAQA- +AF8AXwBf-neigh+AF8-create(struct ne=
igh+AF8-table +ACo-tbl, const
+AD4- void +ACo-pkey,  struct neighbour +ACoAXwBf-neigh+AF8-create(struct n=
eigh+AF8-table +ACo-tbl, const void +ACo-pkey,
+AD4-                                  struct net+AF8-device +ACo-dev, bool
+AD4- want+AF8-ref)  +AHs-
+AD4- -       return +AF8AXwBf-neigh+AF8-create(tbl, pkey, dev, 0, false, w=
ant+AF8-ref)+ADs-
+AD4- +-       bool exempt+AF8-from+AF8-gc +AD0- +ACEAIQ-(dev-+AD4-flags +A=
CY- IFF+AF8-LOOPBACK)+ADs-
+AD4- +-
+AD4- +-       return +AF8AXwBf-neigh+AF8-create(tbl, pkey, dev, 0, exempt+=
AF8-from+AF8-gc,
+AD4- +- want+AF8-ref)+ADs-
+AD4-  +AH0-
+AD4-  EXPORT+AF8-SYMBOL(+AF8AXw-neigh+AF8-create)+ADs-
+AD4-

+AD4- Hmmm...

+AD4- Loopback IPv4 can hold 2+AF4-24 different addresses, that is 16384 +A=
Co- 1024

There is only one Loopback neigh +ACI-0.0.0.0 dev lo lladdr 00:00:00:00:00:=
00 NOARP+ACI- existing even you have configured 2+AF4-24 different addresse=
s on the loopback device.




