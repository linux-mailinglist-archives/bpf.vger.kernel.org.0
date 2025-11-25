Return-Path: <bpf+bounces-75494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8417C86C6F
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 20:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F80E3AD0D4
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE4A336EDF;
	Tue, 25 Nov 2025 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="xlIXi99/";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="sYKvL19u"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5D335087;
	Tue, 25 Nov 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098340; cv=fail; b=tH2cJwS9PEIpZumhdSoISfKeSwkpV48edugAseN0/i3TUE1rV/rwTwbSscE7wzONfJ+BFO5L4JjR5m/BWq8t299koz0V0DZvJLMagovnNeI7/Is8SISTGirABSogjWsSXVhwcYN+s2dKmzlt1JIXN8qdvNIFK8R9qnUYY1hQP2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098340; c=relaxed/simple;
	bh=bxjZIi2Rl5++BW7b0iJG8QJWCiPkosMbEErgm41e3Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ebohbuhaTEtFlRzz0NhcR5bJrb4PtaudiXJDe7/cN5/iLfVCrOY2QivKBQQCiDIe/35YnQufE7CQV9h487m2/MeVjhv6CLxuxhWJajZlCth3VTnPw4vSPIyiQDWtjYq57kwulm9sXC/qfQ715/Mo0BL9FCmgXnTsuqxxiP48eT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=xlIXi99/; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=sYKvL19u; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APGKZKB2183761;
	Tue, 25 Nov 2025 11:18:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=LoSN1RGn6icoz1IZUzvEpUzYyl+1vFucYZgC7qVg6
	Zg=; b=xlIXi99/aSEwb1ssOZZBJbPi8TaFUz6VVLtt8O+Chf4ehEWSoZTPpA451
	1V1cpGOR69CTrYwv5UzvnYCoUGHqhtTBmu5EhndP8aCqlrItLvhESPMIEV0jW1Xu
	XuE/YGwvFcL9P7Wvlkj+Afcygxt9VH8lOpVvpKlx7GYjqfx7+770EEXS1YUKeaZQ
	WTqZ2gOD9RQW0MOw8OvW4ROzZlCby3Fg5MEUGeCxt992GTMQZ76b4MaogMxiqUl+
	/5Hg5QD4PyyNXVMXOnzw5/PGa8ZE6t6cG480UlYVQALc09XR4lAV6R9OAHaDF7JJ
	Jtdp7qXApgnOgApuk7t5pIDWs74NQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022075.outbound.protection.outlook.com [40.107.200.75])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4anfw40cv3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:18:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NegzowzI5f3oN+xMZ9LOKTVQDD4eiSm9aVOpP1g0vPU42v51mhEoW8B40qh7gqcP24O3lxIAFaN/MjyrP/hSZDSys7Gtu6hqjqMUevRWLJI12DDd5PDK1O+yCG2JqjRKEV+sTTnsiAx8Z/N+7WsFSyTN+fa5u8j0fzJ316IcYpTZlo1Wea57PU255dl3e4OWaX8k/lcObT+e1aDFZE0uulYrbf4ThAXVy32WG+TX2eudcb8TCfZS6HhzL5fp0+3BsHB8WVCLAkNKzr8RIuo+xxFTMeIEckLcyR1OBeA3rrSesiJMgfrY1IWlTKpTFfPCsfVGefLf19X3ng0/M8bBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoSN1RGn6icoz1IZUzvEpUzYyl+1vFucYZgC7qVg6Zg=;
 b=xbZsoc+McW7PW8d0NsbSaxJhrm9EWGhTBlK8EsnWEZXlt0DbeFymlzH+f+gtsIAzK8tBqtAx0rJtMHCKXEDZb/0pHK6x+y/czqoktNkBc1anDLckrXvhLiLxXbJ+21A3De9aZgWEuOx/ApoR3J07VFYLGFTmqvtfOmXodWi8iru2spvUOr3hfgH1Qx2lgzz+BBo9Zf57LVHbDZa0pWT4xAbvgsxqji+r8mO68psTMJboFVIgjNGQPSq85LQyyLO0/OFDKRIobDWCWHXIszMgIKH68t2EI/wtKVrvht78qeFg1VYZ1XAePlJui0wqdmIxIGKHbYLx9l9GSiIEZZfc7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoSN1RGn6icoz1IZUzvEpUzYyl+1vFucYZgC7qVg6Zg=;
 b=sYKvL19uXEUc0DujQR1JAM/NpeRITB6sJXxubuzmYbbRmqYVqlKArEZdzyTKufWbuaK7SMyuwP+G3pk3Pau9hmjhz1JwjE20MhTGjlFhPABqWPwG+ZRh9gYrRCJA5Ea4mdbE/hn4IfNoGkyZRJ8WKVWJ1dFeicXuxPX0dDGqH8OREMxPEAS0t89YKxQZAOUaPXcfO9t33wz0s9Xme4vff+N8PKWY0FI8G69XFw1u6IPtAMG1/8Xli0NoyQg3bkGzoTOCYQGTQtkrB8rcA4ewaIAPJAIAwzZ7WnkbTH3wCD76VEbLIeQ5uT+J0qiCQ6J6/Ek4agYdKytAoX1jy7wYqQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 19:18:32 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:18:32 +0000
From: Jon Kohler <jon@nutanix.com>
To: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in tun_xdp_one
Date: Tue, 25 Nov 2025 13:00:32 -0700
Message-ID: <20251125200041.1565663-6-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125200041.1565663-1-jon@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::15) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 03937c58-c176-4de6-0581-08de2c576c14
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PLsorwpX8csDS9R7vwww51vwhotfDcAy7XXMDnlMqboqSV9btWftTGb43TLR?=
 =?us-ascii?Q?fAHUMomPv7uJTAM3m/5sfSvtO5rhLf1hhD19TQpaBVOaPrSfQuOZGGV409om?=
 =?us-ascii?Q?I3N9s8e9dwo75sRHycvd7w2KYFr/ccWpbPa9HkGW/TnCjyUSrPLY04AzeeeA?=
 =?us-ascii?Q?SLCyLBXYaky0CRuIvKOLCUn4FNDssXGWvkM0VZnX/NjJjUXwuspgtMwPB3Fw?=
 =?us-ascii?Q?gZIM+LZ9beFMQjhIkYEAfSIoGR0B+XdhMPAEKm2mWkGyrfBMbYEKn8PCb38A?=
 =?us-ascii?Q?h090zUAJyZzi0PwxIEsKsv8mSX23ar2CqFrFCDwgk8QCHs1T5VVI4+Umrfld?=
 =?us-ascii?Q?xLU0txnUF5o0fiQIt444X5473U9fd7GGphbhYXIzaM/qzX99tjDmmtA2JQ7P?=
 =?us-ascii?Q?7CJyXauxO7XKF+H36WI9uBCsLdT6h4x8mBbe5xsxfb401SDVxKP6ttSzOyqv?=
 =?us-ascii?Q?EQU+bnL/g1LdKhXbp7F0YAEP3YyTYj+RtIbMcDU/JyK5+M3KFL7ii3jFuVhv?=
 =?us-ascii?Q?HIasSS02KYj3G7syzodnQuDwBSopgu6AIhn1hqKzcAJUryPtMonpkvxhjnbw?=
 =?us-ascii?Q?YRgaMjJE+/uZe4NSD4AUejmMURkCNH0PfjLPJqhG2Fw8W0O7nVEc1yEwUOvV?=
 =?us-ascii?Q?ov3FtRN64ivz2JO/wh6lVxh9ddX+jEiZ1OLsBnjXTIjJ7fj2Gkz1uCWf0zEY?=
 =?us-ascii?Q?8f7RIv0MKs8Py4EeZmktY7PrI1I7sKGPwCKevQSKYAanNH7R0yGQ0RUasqZ/?=
 =?us-ascii?Q?tpfqu6Wk1pZ34MIxyD+lHrQ5lV8eVevI28wI5puwyRtfrEyolPki/uBBaw8E?=
 =?us-ascii?Q?RBI3oXmWdcZSRwU3b0wj6Kyn8WVBDErC74/pnNQrgvf+ZdFkf7quEfIDZ5zH?=
 =?us-ascii?Q?xYA9e1MrboWOzjxrZZ+Y/8jxnFj4u5zMJoTc9bG5qKKFdqP4ejh2jp0h7p3c?=
 =?us-ascii?Q?CTCenWhqCh4J7fGuigtowssHzVESQysbwvxE2Ztvi2IOK4AKVBqnBbOnDQK2?=
 =?us-ascii?Q?/Y9792YIkWa/SIBbhtGmSQBxKZ5Exx3wWNSHQQPeAdthTRYeCos99uxGjiXb?=
 =?us-ascii?Q?ugxjIykMIdGqgfPtMuq6oP9inK19LnSfMG7IYczn1u2zk08/m9b37t37YCXx?=
 =?us-ascii?Q?vNjqtujSWsYIc0aoNPV15X1risAutv47nGeaWVs6YmZqc8GPcgZ7MxsMB+AB?=
 =?us-ascii?Q?Pk7aUFZAiEENfeKWxtAMGwW4YQBWMI9f5jCAjxJjpH4tYJmRCRwArzipbHRI?=
 =?us-ascii?Q?TYCLNcwUAe7dHF08YtpyGw2sT8Ms92Jd0guDPbdsB39XsV2VBcBuj90CARIy?=
 =?us-ascii?Q?pXstmO1DChPV+6phzDE4ihLNJZ5RSqbmpS1QbmTTCmWpUDNDqmj/MHlDKNEW?=
 =?us-ascii?Q?8/cfkEFJ98q1tJaRXv3FOQJlOrOp8PTxdubzaPD9Jntnoqf9RTGzZa1n7RnD?=
 =?us-ascii?Q?6Xsl12OrWYeUEYixHAX3JHCJzNymkWMSFtCfmrM5adSHnEivDpLKmPoeHFM0?=
 =?us-ascii?Q?EMdxmMIGTASVfReGTqYZKktHoMXGo7yymwq4aQr+xWM8v7LSuSW8gRbiKg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UuGSVEn5739e9ct8jG+bTiyJktRczg9nWunBjSO+tOxbW9q6yK9pXTDn1N8Y?=
 =?us-ascii?Q?6mS2T3Fw0F4yk3uFlZHIp7zuLfY4IQiVDlNTNQ/VWAL0BcYAOMUEdHVbqqDO?=
 =?us-ascii?Q?+kmBOjQ/C3vrg+oxB5H7agqhO/0R96dacor9TgMmJMhFYMvqF45sS0K303XB?=
 =?us-ascii?Q?00zJ+QESfPl/jSL3XOwQWoM87XucbF3SkRX8SMtd2IgZzVM67UilFvaczUYa?=
 =?us-ascii?Q?2PqjCXV390lMIOXyVzza3Lil6wmUbph2Yd1bJG4zBEzTh87TXku7i6pIsWET?=
 =?us-ascii?Q?dXLiQWU44PryUIJ/WXhJcodz18KSPJSRstpidRmnQB4b6oYsr1RvdCJvV1k/?=
 =?us-ascii?Q?zCVCgjQ8Bf53gUu54Urj2H9O4uHGouysPhpARLPGtR3pSBBzf5Xrgxdr7UlN?=
 =?us-ascii?Q?B4qz0gf5Fok+ZUx5O3WZEsWY+tjF9hGFeFs6u50GAo5dy54to1IgWLjrR1jk?=
 =?us-ascii?Q?kJWcml43KGOdr59VJcik1sdmJ+dlKzJkv0qMTZyqTtBaBAFM2Xgb4e0ZVwMs?=
 =?us-ascii?Q?Bjhzu/dZB9ED45tm2Ck9TGI0rFqbGhYaa9QRt3Qxoacouagikv+iy6VZqErl?=
 =?us-ascii?Q?DTFEAVeMusgv1NIo3KU0ZaYGXxx5sjL5sZgTjV3GWhjk/6268P9ojzQ4+0+6?=
 =?us-ascii?Q?dYyE/SvH0bQbqrfbGJbeASGLrDfdyLmiy+FzWICORvVbL1KEVryWb30GDao6?=
 =?us-ascii?Q?KTtYtc76TRi5rjh1s3201wqSfLKzCOK5r2F/ONBl+1iH0iyjCuDxtfw5kTEE?=
 =?us-ascii?Q?hSznfp46VV+5IYopoxGc+6J4MQrJdXe/Ujcx71Rv3UryHJz0ElrV7K8by55R?=
 =?us-ascii?Q?GGDmWkQeDht+tgVnP/3Dyxyz0wKnYxe8endMv8/eLDTE1ZbOvEjZGxieHmBG?=
 =?us-ascii?Q?cZepoVyxW38ibgjaOgQq8L7FYnGIfCj0rOqnvRhCwc+/hYTle3XtrzPeLIw/?=
 =?us-ascii?Q?YTAw7PHZlElxnoNY2+/JdrypuPc/TzrcJQDX55kCc/I5TAZXPmKpEJ9qtnU8?=
 =?us-ascii?Q?ry79/7vvzvcI77kHugH1D40gsxaaOXp3pgAkOZq7K/XfjnMIOGasmyljdrNN?=
 =?us-ascii?Q?QtNB1YojNIyQo+lTQU2iARmcWT44seTn8Mq6aW5rxWLFLSGe7SME/9TdE7FM?=
 =?us-ascii?Q?Yd5K3bMPWNliQ2fXqw6QKZa3alsV12xUiRDY5VLGHyiy4+FAwoz/WJ3XDvTJ?=
 =?us-ascii?Q?PJCHhb/D5zKBLi7mBDCL7aaZjjtQkTRUUWZ9IeNC7brLjFfZ2zBzPduCzhlz?=
 =?us-ascii?Q?g9POXNQUzB1iTZ2y4ZEaOGksdTA3mynUsD7hom6RwHGLMqJRmRBiGP+oRdYv?=
 =?us-ascii?Q?ZkxZI3Y230NHZaBgtC+3oMTvMZWZjpG1Shg0bxpMe734HQ3VRIP13dJuiD+J?=
 =?us-ascii?Q?yrJSp72JElQZSrRx95Jpra6YtwKaqIW5045iFHtX73PVq4QmcpJH/DCt/xMO?=
 =?us-ascii?Q?Js2X5fIJ4TZIvHGgIWLo84gZNr99tKGrv+biPfGCrIkvppr5XzLHDp7+uAP/?=
 =?us-ascii?Q?ig8qlZ3h1IKi3Ufv3qk/S98O/R5HcrgGMauhXTNg9faH+fd0VJMROM8WYlbI?=
 =?us-ascii?Q?/PdmBNnLKSW2Nfib2lDQMLlDC1wifc4lSDEU5R+Cfk2YA+hxM+X0SoRYypJD?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03937c58-c176-4de6-0581-08de2c576c14
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:18:32.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkM0l7tSYin1a9jjqXdqrVPd3RD+gxPhAzkTBMT0Jnkt4aCrYCuoYpswqtH6y1rvW0OevErNME1epfUYXnIXUd/M9t6YfziKPOZ926SOlpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-GUID: KOD75cy1ERAHCnWDzRoUpIiaSAVn4Bcj
X-Authority-Analysis: v=2.4 cv=NfzrFmD4 c=1 sm=1 tr=0 ts=6926010a cx=c_pps
 a=5czeKszRpWsvzRcawb/TzA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=ge4JF1-_ivHthD95DSwA:9
X-Proofpoint-ORIG-GUID: KOD75cy1ERAHCnWDzRoUpIiaSAVn4Bcj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MSBTYWx0ZWRfX9Ox3mpUYlD1J
 rjXgQxNkutFzgPvowD+h8jyobtoRgt24B9TXQNHNv9F6s78s10dG7f1YBt42P1bJCm0l0h727hX
 QeRqBcXxIXv0JHJt1R5ilGxGMdWPtDgaYyxvJBFcYMWq0Yvu6IlMe3+tXTN0QxXghfayUg7T4VC
 T2MvBAsHk6lwJNOQ0lW1co+FTCJX+8L9aGCKE/aimQML52n+XDQzPqM3JVyr366FSaLAqsiVyk3
 9ISF0xHNNhm3smamUYRcMN22+CqJ16L5f8Htkk47BJLcLVg1ovSDoOcWjdgut4WzhKQUpJ8i8sS
 n9WujfJ+KbX6hAiJWD9tyiphPEQ/VDl1GT6TGwe31k7P43zX6pFGAY48z7vyf5erDouI0dsmTAT
 mu0tb6L28V1H2GOjPzK9WYayFiDzfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Optimize TUN_MSG_PTR batch processing by allocating sk_buff structures
in bulk from the per-CPU NAPI cache using napi_skb_cache_get_bulk.
This reduces allocation overhead and improves efficiency, especially
when IFF_NAPI is enabled and GRO is feeding entries back to the cache.

If bulk allocation cannot fully satisfy the batch, gracefully drop only
the uncovered portion, allowing the rest of the batch to proceed, which
is what already happens in the previous case where build_skb() would
fail and return -ENOMEM.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 97f130bc5fed..64f944cce517 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2420,13 +2420,13 @@ static void tun_put_page(struct tun_page *tpage)
 static int tun_xdp_one(struct tun_struct *tun,
 		       struct tun_file *tfile,
 		       struct xdp_buff *xdp, int *flush,
-		       struct tun_page *tpage)
+		       struct tun_page *tpage,
+		       struct sk_buff *skb)
 {
 	unsigned int datasize = xdp->data_end - xdp->data;
 	struct virtio_net_hdr *gso = xdp->data_hard_start;
 	struct virtio_net_hdr_v1_hash_tunnel *tnl_hdr;
 	struct bpf_prog *xdp_prog;
-	struct sk_buff *skb = NULL;
 	struct sk_buff_head *queue;
 	netdev_features_t features;
 	u32 rxhash = 0, act;
@@ -2437,6 +2437,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	struct page *page;
 
 	if (unlikely(datasize < ETH_HLEN)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_SMALL);
 		dev_core_stats_rx_dropped_inc(tun->dev);
 		return -EINVAL;
 	}
@@ -2454,6 +2455,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 		ret = tun_xdp_act(tun, xdp_prog, xdp, act);
 		if (ret < 0) {
 			/* tun_xdp_act already handles drop statistics */
+			kfree_skb_reason(skb, SKB_DROP_REASON_XDP);
 			put_page(virt_to_head_page(xdp->data));
 			return ret;
 		}
@@ -2463,6 +2465,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 			*flush = true;
 			fallthrough;
 		case XDP_TX:
+			napi_consume_skb(skb, 1);
 			return 0;
 		case XDP_PASS:
 			break;
@@ -2475,13 +2478,15 @@ static int tun_xdp_one(struct tun_struct *tun,
 				tpage->page = page;
 				tpage->count = 1;
 			}
+			napi_consume_skb(skb, 1);
 			return 0;
 		}
 	}
 
 build:
-	skb = build_skb(xdp->data_hard_start, buflen);
+	skb = build_skb_around(skb, xdp->data_hard_start, buflen);
 	if (!skb) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
 		dev_core_stats_rx_dropped_inc(tun->dev);
 		return -ENOMEM;
 	}
@@ -2566,9 +2571,11 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 	if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
 	    ctl && ctl->type == TUN_MSG_PTR) {
 		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+		int flush = 0, queued = 0, num_skbs = 0;
 		struct tun_page tpage;
 		int n = ctl->num;
-		int flush = 0, queued = 0;
+		/* Max size of VHOST_NET_BATCH */
+		void *skbs[64];
 
 		memset(&tpage, 0, sizeof(tpage));
 
@@ -2576,13 +2583,24 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		rcu_read_lock();
 		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
-		for (i = 0; i < n; i++) {
+		num_skbs = napi_skb_cache_get_bulk(skbs, n);
+
+		for (i = 0; i < num_skbs; i++) {
+			struct sk_buff *skb = skbs[i];
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
-			ret = tun_xdp_one(tun, tfile, xdp, &flush, &tpage);
+			ret = tun_xdp_one(tun, tfile, xdp, &flush, &tpage,
+					  skb);
 			if (ret > 0)
 				queued += ret;
 		}
 
+		/* Handle remaining xdp_buff entries if num_skbs < ctl->num */
+		for (i = num_skbs; i < ctl->num; i++) {
+			xdp = &((struct xdp_buff *)ctl->ptr)[i];
+			dev_core_stats_rx_dropped_inc(tun->dev);
+			put_page(virt_to_head_page(xdp->data));
+		}
+
 		if (flush)
 			xdp_do_flush();
 
-- 
2.43.0


