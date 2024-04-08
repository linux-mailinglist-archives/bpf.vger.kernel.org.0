Return-Path: <bpf+bounces-26215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC89F89CCBE
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A0C284B07
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9AE14659B;
	Mon,  8 Apr 2024 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q0yIk5IG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J/7g0jS7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B71272C4
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606582; cv=fail; b=BLM6lO+7jLN8BKoW4eSqRrmzFpw4ugOO3pXyEGQkuqD9gje0FuqUI/4lCqOFW7z+y47AzqvkHo0ndGpvbz9YBBWfT/AEl/5DhWdBJ6Z7SQAji3WA3C9B0AaNG1B+W9w/HjaeYcucIHZdFlatPU8fjeKOUw1KaOt4Mj2g9oeD6CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606582; c=relaxed/simple;
	bh=j8YsW6j8PI6oof73EuxA7TIAqhS2gIdLSI29aIWvFak=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=dFJD84FkT7DnYsq1dpkj+Ks37BQk1lcrE/0oouMyzbMa0ym2oWgYPQ/eIz4F1Wo2faAgp4sLgBMTJlIOiH11ibYjOYa1T7Dc5G6hW5CF8oMhJkTx0cg7e5tjwfNt2i0hmYLU0ZTrnDnIAiGlAv0BDcMWjQcfgVw17twBILOYZyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q0yIk5IG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J/7g0jS7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438EPVcC019851;
	Mon, 8 Apr 2024 20:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uruGGmbt2MKbQavyHdioCG7n8dhinYAl3tDYClezDyQ=;
 b=Q0yIk5IGWDoIXaUega28/lM9e8GnBUF1hrI+0QMXkC4zo4+zk/H5upPcPlK8+I3KzzGW
 NVEkA5b7wbz+BIzra2qg84bh3o6ocIFr6bRJ/xth2wdkwAwzgtWaJeC0UYeGIgjnpZ1C
 IaUiFQYVyxd0x1Xc21y4byXOo+xXREp+/bpx85iCa/595nYSl9mCrNcpVUCypYlB8lGE
 MeElvmqi9Le+DJw2rRq9gvMw7PW3gFB04lXrrHrsYdFTkXnCtpyy+Q9R5GeqQ5WgMrS2
 3WdK2dQJNYiFC9U5tpk1AQd+HX4rp/yp8NkK6D/e0zToYCzE3BQJCWH6bJJ/J7r0Rwvp vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw023m4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 20:02:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438J0C1u003190;
	Mon, 8 Apr 2024 20:02:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuc76b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 20:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThLLN6kJ+itFGOTuMz6Wb3/jbGQQ1i/+ZdN4lAAmcVwSzskzHlmEC8M9V8+n+ZAykvy89P9ouFXdEAhAoZ1bcobGzt8/bta9EnhzX8vOnwh8djXMXCiyopx12fPeA1R3GQYA6bctfFOFfVt8C7qPUf7sIXVrqaqIiUe7dbLVZ+Qaq5c17oMdRx0x4W6JIQgwgRZN5BIK3BzQIMk1LbCxTarJzeGTbBFhBZqomv8PoC3zh1gVdt9uoiZIY21M0tHbkFT8IiegmfgPWWm/PpHneMjKRC1cpCquuaQ0zhcVtQZhWn+g0vtJnwCMAcDcP+KwVD+PfqBhTaGx4do6OXB7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uruGGmbt2MKbQavyHdioCG7n8dhinYAl3tDYClezDyQ=;
 b=SO//CV/RkNjiCUx5kQ/vnD8dnqUKvF+BIXpSFBFbi3Xfr5X0ROkaytohoiv3xmlzVe5bMo6rlehroCWlaBwWJMlsfJ4n1f4mxWiXCdwL7053VnDoXe59TIUvN6LDKsp8OCPiEO3ueix9Z2iCtWbeY4pL2D7b8Tvor8IRNxJzU7D1nIA5nEMuffVQg9S4pKxUmspNSclpWth7An33gy6m7KM07k8U8IZIORujbF3wX3PIVZHzMsoD9gXq1P2Zl3VtYThd+SttMKzhSpT1nxo1S2rGIobIbn4tl8fhR51ohU+56bRgMe7QrfBXtPWcTIbaI7Ny4T1Uztt5wgncN7PGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uruGGmbt2MKbQavyHdioCG7n8dhinYAl3tDYClezDyQ=;
 b=J/7g0jS7+PjpNljLTf0tNHLrCt3RPrJyVk+4qs5QK5yGfPogfCig5jYXaw4zDuYqgCGuxfngOyuVpUCtEouZYVboNHNbhF5diuozRwdEG/Xv5ONjtd4LPGf3SBQ/d9tSsBQ1bkLfvw3FLgXa1A3KNf+Ky0QrhCYjoAkOR0+FtkM=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by LV3PR10MB7981.namprd10.prod.outlook.com (2603:10b6:408:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 20:02:55 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::a112:9d4b:46a1:879f]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::a112:9d4b:46a1:879f%7]) with mapi id 15.20.7409.046; Mon, 8 Apr 2024
 20:02:55 +0000
References: <20240405220817.100451-1-cupertino.miranda@oracle.com>
 <CAADnVQ+7hMVTu=yQ3XSRkxACaW68wgwLYPQBQH9StDvBsNXN1g@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>, elena.zannoni@oracle.com
Subject: Re: [RFC PATCH bpf-next] verifier: fix computation of range for XOR
In-reply-to: <CAADnVQ+7hMVTu=yQ3XSRkxACaW68wgwLYPQBQH9StDvBsNXN1g@mail.gmail.com>
Date: Mon, 08 Apr 2024 21:02:50 +0100
Message-ID: <87wmp71v2t.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::16) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|LV3PR10MB7981:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QpLTgYmE8KI2WpOB93dioyZnXoAAPyGWp1/qZSBXUtRoZ5mrSTdB/rLZsEOVyQcnRb6pNbpOuw9j+fRPLhI5XMDIAAMNQh5kiZjlM+UNnuR5+I/yoY+aLTN616uvMWnpy7yTWG+T7V5b8dHDQxGn36VLIlFqUHedcLZJYFau7jXiC75xQU4J4LUZNQgzekZr07ZXDFZnZo15c5xlgWm3Wtf/rAi3xQX7UMKetoU1jORZWrJyy38IWzngP7Usl2PTFfMmzpEoKBmn7W/vqCyjkcPHeNkNYDZgjHMtztG9Bg3i7p0l2nngVE/JHw6DXOEN7j3J9AFUFFvZdLb1o+u26OwbQQHTMmXEp7qe5uqcCkH+3zYkk8968qXB4tyQ5SEGCMl3VSBrhScS5fTUt3m2hSilOmXIKuQNlpplu6wlMKMGsMpa76eJV2vTV3lNloEaNWVvVgkGiZVKNpzkiiQpiYkUDbUirk70sffWphfnm//Aq71Fjjq65LZ2CamATmPnctGdJ5HlJNt6fL8casg+qaqVKwrQnZ6ZP30ISmEmxucbsAUcDvlSMWRnMCiP7GizFsuxwA9Q8KztAEpCyp9dVjA6dmy1FSUjW0cIq6Vo84sm9y/v3J/ELwTsQgKFZbzU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0NhRTdjb0UxVTZPNTFmNVU0TTZGWWY5UitPSTBpR2k4cHlhcW4xbkRMeXZY?=
 =?utf-8?B?MWcvSVlMTmE2SlFualRGT1V2NDZJbTBzbG9WVGdJN0R4YnhleUNNdUhQaTgz?=
 =?utf-8?B?ZHJpRUZJY2d2ZVVMWHY1Zms5V2JUQ2JkS2VWc1JZOXhvZ20rRURjbFdNL3lU?=
 =?utf-8?B?Vk40WTAxVWUvUEtoSTBVV2U2QVIyRXd4NVN1Y1A1TG9GcFZRR3k3RjVBUVJ3?=
 =?utf-8?B?QXhUZXpPcnp3RXlxemYyRStjVkkyNzdpV1Q0MEpDNjYrNFRaRnV5QTl0UG5r?=
 =?utf-8?B?UEs1dkRhRUZxSURIUkNydm10SkFXUXhUalpmajROdVkzTXdkV1BwekEzcjBP?=
 =?utf-8?B?ZHlMWG56aGxYY1RLZkhacTZaVzJua2pvN0xzYi9PbzdIb0RUZXAwWnU2Ui8v?=
 =?utf-8?B?Zy9UZW5PdUlEei9sWG9YUnB0TDdoY1NseDlOV2U2aDN5dTlSWEtCaDByWGVI?=
 =?utf-8?B?UFg2c0M0TzVOay84L3NKL1pUSFlQd05ibmFXc2Ftb3lWcHlNaStrcEYvdk9z?=
 =?utf-8?B?dFU3ZFlxbUViOEtLSE1wSTB0L3ZPSUQ3K0tSMXhUcDBiaWx6T3hnM1RvbHV6?=
 =?utf-8?B?enFPN25HU1BOdUpSU29NNzhXMkI5L1M0UEJYOERVVkF5dnR1Ty8zVWx2bGdw?=
 =?utf-8?B?QXU5ZkxneWhuOE9mQmJXWCtmaVBja1dYVm4vRTkxM3c3T216TUtodnNuMFVU?=
 =?utf-8?B?ZUxsVEVRVEt3dWdXWFFXVG12aEl1S0FueWdidE14WHlWSkJqRHAwSlFhbjZM?=
 =?utf-8?B?VkpIbm5JN3dTaDVYbjlMVkw2ODk2N2JFanM4NUx0cm5RZHFvTkF3VWF2VHhZ?=
 =?utf-8?B?OW5YYkJ4ZTRFQkJlMHlYN3ZUcldlazdEeGFma1lpZDRKa3JWdVhkWE5McnJU?=
 =?utf-8?B?UkJPMGJpVlZ4ODY4SkJheTJiT2VYVUxiYnVUV2xOQitiQ3JGYXJLcWg3UEIy?=
 =?utf-8?B?NlZKWUF2OFJkditzVWo0di8ybGN4ZTBWN3VlYXJoMThrZjdDTWdNWmhsdFY1?=
 =?utf-8?B?amRFTTZIU1lCdjd2cUt2QW5rbm4xLzA4MWNrVmp6WmJxbjBWTW1lRkxidXBR?=
 =?utf-8?B?NDFjOXdFVGxVWlBrVnVudDk5bUJhdTZlQzJneUVlWi9CbHAxY01uSDRaWXd2?=
 =?utf-8?B?aS9BQmxpMTRqcE9BVGdFdFFMMndSNUlyVlRXQThYazY3UzB1c1M1aUpmbDRB?=
 =?utf-8?B?MVlhaGlJc21pQmtaa09qL3piVTRqMjhya3lBNGY1ZnE2dVBuUkNUVXRadU8y?=
 =?utf-8?B?ZUJLcnRWQzV3aTdMM01UMWdYaVB4dGZGdzFjTk82dlpFZURWdEFzeFIweUp4?=
 =?utf-8?B?a0NHRjVYaTlnaTJZL1Zrc1NsZ1d2Rm14Zm0vV0RzQ3Y3TFhybTF2b2ZaMXlo?=
 =?utf-8?B?cXRkbUptbi82Y0YwNUhPeXNWUWc3ZG44TENhTUVuKzV3NElkVFNDc0JNS3Ir?=
 =?utf-8?B?aEZmcVptbW5zZ0hrRjk1R0d4OXVGS0ZiSllPdzJFaXZRNkxuQVcvS1NXQ05N?=
 =?utf-8?B?WEVueHRnTEM4VklDK2ZVaXNlODRJOW5VUVFvc25xejFoVTRtZ1Y1TkI3TmF2?=
 =?utf-8?B?SjY4V0YrUlJoa25XSkNkbEZrS05HVTNmVkVkZmVubFp5YTgwakllSXQvQWtx?=
 =?utf-8?B?djFUT1VzdVE4VmRhRktZUXVmd1VJQlYveWliNjR2MGgvYjdLamVqaVpnU3Vu?=
 =?utf-8?B?THh0bVQrMk04TG1pZW5MQ0ZqbnQ5M3c5cnh4RllhWVREakNTRU0rWFBURnlT?=
 =?utf-8?B?ZVlEU2w3YWJCcXk2S1JEL0lEdWFJbzQ3VUluMnZCcUlmTnE1SWFrVVN0MG9Z?=
 =?utf-8?B?YjhmRjNwNlR1MmJIblJhRTRoZThKRVlJeUpQeENSdWxPWTJ5UEwzWkErSVFV?=
 =?utf-8?B?MUtjeWlWV3YrU0QzdnJYd3BYU2NtUitxeFIzNTdpbityYVVrRW9xZG5wVXBP?=
 =?utf-8?B?cWg0R1RLeDN4STE5czc3ZGFlRTVZbi9pNG1SQ1Y5MWVvR1QvN3ljaDF5M3dj?=
 =?utf-8?B?eHh2SXBQR1BOaTZGSGhJa1lLM2U1UHZtZkNLM0lxUFV6b0lDY2xyYThIU2ZM?=
 =?utf-8?B?eXROODYyd2Qza1Nsa2R2ZHpxbE83Z0JvMWtYU1MwN08wZG5Sd1Y2bUV4STdt?=
 =?utf-8?B?MFNDeTRtblczNjhlc1FvZEg3WFpscXhFZ1FnUmRjajNHY2VUdEg5aUo3M1dh?=
 =?utf-8?Q?1jAaS6yoqDoRMkscoOlOJ5A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ePKyqKuz3lI5iVv7Q3Lx9tP/LPuqzuxyKvIdOrPf1QuoRFtqumI1DrSgoqTuurTc28rLGXzjuorA5sTjbGOTX9+VAippM7FB3oZrn2ZxTdYrcKOYdKlJ2h7l8AveDplV93BfGFIUBOzhdfb82rE7rhDRkxGIfAFGu78PKvPtzssrEHA+cSGTa/kyjjy/9aEc3xCSKq0VzMQmbv4dQ60oVwgK+mMThVY3Boveuu25xaPzdMbTuRCd0f0J9uAxcNLbO1afPZV1Z3fr0n80B/8lSfIkFABfMsw3UgQDFY7jfg9K/zvX4rfk7e9UJ6ZR7ornbuA1B2lbvDiBD7OfNub0J8wZO7jHe5QFuR5MYPGQFvD0XeOpLBzVcXqdZL28Pz4cRGekl1tUe3shlDyxBtBC7E0evm0SwhV16AokPCtfaP1wgkvhyBIyq7CZ9HbLJFdcPu+jhLpn1jKQxHzQ/PPOzSRkiZjG3eFNSm5ROokhjEAMcBcWj0ISbuDFaZmrnXgA9wmUbjERRpQ3JSp7lmiZ9Vd5+oifyXavBGELQbfZqoO2Fkp4EGxiZHI7DuvoecXWfJbpbrT0w8hYxHCWBh1TxZ8udmxuI/6+Sm4oylXI6gI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a25efe-9a55-4028-9bb9-08dc5806e0fb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 20:02:54.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 847qHiVw4t3/1CkOGurG0p63yzcz45NrAkqnAibA3zuJ2BOg7nFA1kYk3hgCxRWh7HNBgbwZv1KD6dLd8t9HArRifkXNR6BdtHXaUvu6yaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080154
X-Proofpoint-ORIG-GUID: mPAjZlhLgEatiUiIPRyg0KbBqFWfrpou
X-Proofpoint-GUID: mPAjZlhLgEatiUiIPRyg0KbBqFWfrpou


Alexei Starovoitov writes:

> On Fri, Apr 5, 2024 at 3:08=E2=80=AFPM Cupertino Miranda
> <cupertino.miranda@oracle.com> wrote:
>>
>> Hi everyone,
>>
>> This email is a follow up on the problem identified in
>> https://github.com/systemd/systemd/issues/31888.
>> This problem first shown as a result of a GCC compilation for BPF that e=
nds
>> converting a condition based decision tree, into a logic based one (maki=
ng use
>> of XOR), in order to compute expected return value for the function.
>>
>> This issue was also reported in
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D114523 and contains both
>> the original reproducer pattern and some other that also fails within cl=
ang.
>>
>> I have included a patch that contains a possible fix (I wonder) and a te=
st case
>> that reproduces the issue in attach.
>> The execution of the test without the included fix results in:
>>
>>   VERIFIER LOG:
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Global function reg32_0_reg32_xor_reg_01() doesn't return scalar. Only=
 those are supported.
>>   0: R1=3Dctx() R10=3Dfp0
>>   ; asm volatile ("                                       \ @ verifier_b=
ounds.c:755
>>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
>>   1: (bf) r6 =3D r0                       ; R0_w=3Dscalar(id=3D1) R6_w=
=3Dscalar(id=3D1)
>>   2: (b7) r1 =3D 0                        ; R1_w=3D0
>>   3: (7b) *(u64 *)(r10 -8) =3D r1         ; R1_w=3D0 R10=3Dfp0 fp-8_w=3D=
0
>>   4: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
>>   5: (07) r2 +=3D -8                      ; R2_w=3Dfp-8
>>   6: (18) r1 =3D 0xffff8e8ec3b99000       ; R1_w=3Dmap_ptr(map=3Dmap_has=
h_8b,ks=3D8,vs=3D8)
>>   8: (85) call bpf_map_lookup_elem#1    ; R0=3Dmap_value_or_null(id=3D2,=
map=3Dmap_hash_8b,ks=3D8,vs=3D8)
>>   9: (55) if r0 !=3D 0x0 goto pc+1 11: R0=3Dmap_value(map=3Dmap_hash_8b,=
ks=3D8,vs=3D8) R6=3Dscalar(id=3D1) R10=3Dfp0 fp-8=3Dmmmmmmmm
>>   11: (b4) w1 =3D 0                       ; R1_w=3D0
>>   12: (77) r6 >>=3D 63                    ; R6_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1))
>>   13: (ac) w1 ^=3D w6                     ; R1_w=3Dscalar() R6_w=3Dscala=
r(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1))
>>   14: (16) if w1 =3D=3D 0x0 goto pc+2       ; R1_w=3Dscalar(smin=3D0x800=
0000000000001,umin=3Dumin32=3D1)
>>   15: (16) if w1 =3D=3D 0x1 goto pc+1       ; R1_w=3Dscalar(smin=3D0x800=
0000000000002,umin=3Dumin32=3D2)
>>   16: (79) r0 =3D *(u64 *)(r0 +8)
>>   invalid access to map value, value_size=3D8 off=3D8 size=3D8
>>   R0 min value is outside of the allowed memory range
>>   processed 16 insns (limit 1000000) max_states_per_insn 0 total_states =
1 peak_states 1 mark_read 1
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> The test collects a random number and shifts it right by 63 bits to redu=
ce its
>> range to (0,1), which will then xor to compute the value of w1, checking
>> if the value is either 0 or 1 after.
>> By analysing the code and the ranges computations, one can easily deduce
>> that the result of the XOR is also within the range (0,1), however:
>>
>>   11: (b4) w1 =3D 0                       ; R1_w=3D0
>>   12: (77) r6 >>=3D 63                    ; R6_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1))
>>   13: (ac) w1 ^=3D w6                     ; R1_w=3Dscalar() R6_w=3Dscala=
r(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1))
>>                                             ^
>>                                             |___ No range is computed fo=
r R1
>>
>
> I'm missing why gcc generates insn 11 and 13 ?
> The later checks can compare r6 directly, right?
> The bugzilla links are too long to read.

The code above is just some inline assembly in my patch that reproduces
the specific GCC issue in the verifier.
If you want to see the code GCC produces you can check in the systemd
github issue.

Thanks,
Cupertino

>
>> Is this really a requirement for XOR (and OR) ?
>
> As Yonghong said, no one had the use case to make the verifier smarter,
> so pls send an official patch.

