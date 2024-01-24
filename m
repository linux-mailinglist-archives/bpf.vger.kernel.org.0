Return-Path: <bpf+bounces-20201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6552083A417
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FA028324F
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D25217566;
	Wed, 24 Jan 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GLgRFOke";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qhwdVKtH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D71754C
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084719; cv=fail; b=dKLcGC98r7bGaPktIDmx3SDQiAhcma/SnZsyUr73FCD1bRO3M8Ez6PkbcudX0fnbkLgZi7el4K+sOQFbo5c3jb88vg5MP/VJH6XbLGc/cNwURDHLHldwMLHuKRFahA9ecjXgEy72G0iC+7rUZLDtl6sLy4TMt+5uabAspwVzkUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084719; c=relaxed/simple;
	bh=EKelM1F+A4/y0nl0JhTIPLgr9esv1Cg7JFuj/iumyFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=gtS99N/mnwYvia4clHnAz1WLblQ5s3V6EllVlt8+mDJQJBiXOrnP7JBIm/xaA5IGUwstmMVGMGxKXnUbjSzvIJi9HmD6+dhq3e9KVMmLsc8jp+Vg8ttIbqyQXLsxppfpYEf1/oUKYpXISrIK545RWrhnbM9h818+SwpU2GaoYhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GLgRFOke; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qhwdVKtH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O30I8u029444;
	Wed, 24 Jan 2024 08:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=p7JaR+PLITl2l3XSKkTv6kZMOjCSt88VqB1Z2A62waM=;
 b=GLgRFOkeJ45YurqWxprvBkMhT6Qkln1GgElvgCWxvFdTJzs3VuCfl41TXaJIrpm79TOR
 HPk5vIOtL1VwbNU04DJaPnq7Lc97tkOsTkZRmZ2LZAqfxjmiFAoHcGMT6Q6lbSZ9raP4
 8xOU7X8xGa/w5wz5utwsUzbq6Qv1E9mTAgN+hM13Ro/Z0XeQZYKn4tUW8aUP22mWiYwh
 S8/KoZJbxfuIfzm29dikkz9vk6Xdga54WqiK1bqsR/vv8BWbYlMZ9dS6RZ/5gsGA2gOh
 8fazkHuNBuva9ilHE2w+gWySIdY0GNq7QuZGw6hyrMke5xpD6QnWiWj/5DmE0xNCHMpr nQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy093b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 08:25:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O8GgWR001272;
	Wed, 24 Jan 2024 08:25:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs323k3u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 08:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLwd5xZcrVnUUzJG6yDWD8NPp8ZxG33armmEwq8lxzggGVxbTFRpLX6E2HO774UjiiUDVC7N2sOX4mdhHkrtpVMP10o+2eJF6hRxHHdvEsLNiFtt5OIpa6PFfcaUL3YEbvB11e10UbY6BOM5O+yvP4qz10Nbd+tDREdzR1sxS2hPpE1GgX/xA0JNHaekJraboIv/z8C5tVhGSs2JfZqzPsMVeobWEwvlx1spTE+h6Re8N6rKJVT2l4cN8TP5FndxGxyloZuDltmHVdEWZsG5KjplcPrUBAqtSg6C6v5Yk57Zq/zJpuKWBZlOEwxCMgxwsguaeUWpz8miAXwkcxqtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7JaR+PLITl2l3XSKkTv6kZMOjCSt88VqB1Z2A62waM=;
 b=b1Y8Far7XK9YalmIZP+KNEdwyXjICbh8d9kX+3vZz6v9n3bRj/tu95pyH5eQQ7tpzpeIeMERRJ0NXM4j6PwKFhzWzbG8fEH012PRsG1aPgQoBILpoZvNT3jDA5djWMI8ClOsv/veSWZqsQlgXTUg/WNorNiKKA1u2hXtGQnvNawiia64cWkyxkRyrEHN3pfbKL5Cx99kcJ6/K0xsG5A3x9ItYVsE3JMFZcRSYmYpIAz8XwmgI4KF6VJuPjUK2wt8IyDGEcbu5GTP64k2MZ+xG4PwsKhaMleRQaL0wuU9+DscxPSo0ptr3td8OT1tUitCzdZW289g5BLl8kxFupyAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7JaR+PLITl2l3XSKkTv6kZMOjCSt88VqB1Z2A62waM=;
 b=qhwdVKtHqD5SVkgkrSLFT35FX1xj6NM6H7Bfrmqbb+TF9Bdwn+QGUhR8mU253NZR07oSEcbBEyAC/VN/RXS9l7YHsOIrqrOeLyOozXbkGvgKeM82D+0PajBvCrZYtUTjv3GuWMk9am1hwdMmhymSK130LyhIbV2fE/6VOxkV1oI=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH0PR10MB5780.namprd10.prod.outlook.com (2603:10b6:510:149::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 08:25:02 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 08:25:02 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com
Subject: Re: [PATCH] bpf_helpers.h: define bpf_tail_call_static when
 building with GCC
In-Reply-To: <bb8b375a-fdc7-40db-9ebf-ebc89a12f5c7@linux.dev> (Yonghong Song's
	message of "Tue, 23 Jan 2024 13:19:41 -0800")
References: <20240123185945.16005-1-jose.marchesi@oracle.com>
	<bb8b375a-fdc7-40db-9ebf-ebc89a12f5c7@linux.dev>
Date: Wed, 24 Jan 2024 09:24:57 +0100
Message-ID: <87cytr2l5y.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::16) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH0PR10MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b0d92e-4f73-48f7-daca-08dc1cb5f629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5kGXx++6oUpzit4hDVAk5v4VD7wYpBbUnFi/ums+CBkALGMS0K16cgn0yJs9HISq8u1MH6/ZxK1/Iy8KQbvObGaPe+ZyI1Jh6Y+qgr5Wpy2EFI2ijvbGUuob6vt86/6JY0cbNOtFWLmG6qHshTuYROnAE82EUYcudzESaXuokNpm82eVBacPt2Cpwi/hqwDlvAiSgFFv/6KhM3z44tk1W8zM9U2B/wwmsP9Wi6RGol79hXU5KsAp9SLLntiEZc8VHUjcuT+r+8+gT9lC0LzEp10x2rWL2Er83dlr50H1t85fOyLx1XHEvC9R27wvYI0ZsA1EdwCk7MV+NwPxRdesGkqhkE1KRx3usyk/+rZ9JkWzfa79CSizUsOrm8D77pn/tBlF4XKuLKcxetb0pC+orPpMIPYtqAJ7Tr+MrFO3WuUp4jdf/tc8eay6F2pIK2up3Ak6S86qrqa4FCoutpv2cZpiiXFEpZLQslLNa5JL7KwnpokUI/SoIN6nu73QnGMqWC+QM8yFwYHSZFU8/86Ex2kRY1ALdAQTaeS3nYll+F+EdURA3rEavucwIQ/LypYh
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38100700002)(478600001)(86362001)(53546011)(36756003)(41300700001)(6506007)(6486002)(6666004)(8936002)(4326008)(8676002)(26005)(2616005)(316002)(6916009)(66946007)(66556008)(66476007)(54906003)(107886003)(5660300002)(2906002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8vVSBCkRef6jYBwYftnqRE425nbQzcZ3Y6kDtwun5bn1TAKqSOCibKjRhSbb?=
 =?us-ascii?Q?PiVshaL/Ojq2CwRxQhhd0F5kTFyPNOgkPCTA+a0ljNG2scyIy5F9f/RjDxQc?=
 =?us-ascii?Q?7JM/AjqO/EFjrbEICASF9GqMbK7oe8xpydxoDGs2VIUY2j4s8Xhuu5AsG8x9?=
 =?us-ascii?Q?Hf9Ii/yzIGTxFY8NiuBEKVY6nYc/Y5Trw7S5riypVgQS1VGFrbnM+m+NW50h?=
 =?us-ascii?Q?qiIQl93nOFk0/BFWcbkLZilBYNAYTSq8xDpr/iv0mjOUPB0fNPYhnL1TTnc+?=
 =?us-ascii?Q?CjhXrCKj1UwWvgkq9XqbXUqrYxitKnsyo9z/mq/A1is0lWF/bvLVi2AYBvMN?=
 =?us-ascii?Q?gSAcRyalwjxNBnFfiY3RBK+RRZdPY3kNWKb1Mz4rLHmwE28ZDVjaUwiuUZb7?=
 =?us-ascii?Q?b3j4Vehb9EM3UmNVDJiO6GsShTtkxCJl0cg5Y5+xtP0eRMcjyphyPllc149O?=
 =?us-ascii?Q?lukQ/8zNEXdYnRejx8k5B3fF1LHjG6qSZ/zp8ecu6S974WBWBDuDoi/WjsI6?=
 =?us-ascii?Q?uLua34zi2i6d6SNvT8J1b0zTEHBjMONBhrLh3AjFour2rwDFx/Ue6jDW2wne?=
 =?us-ascii?Q?zwNXcB4Bedr4PwQbelTEJwK5wbx+6KAoxImXBLkYSHwFXHifzv6LWFUN6E9q?=
 =?us-ascii?Q?+09DCVe7fT481NRhNdaV0hs3APCYE9QzMcT7ud0LEbt8n0Tw5brFFa+3dQqv?=
 =?us-ascii?Q?4GXBHj8PlCCIUE8BuifHjH+nDM7vS/sUZetPISjRiVIX/iftc5kbB7Hff/qO?=
 =?us-ascii?Q?71ViTzI1DyJuny77pHEAJ7Jw6PulTjwwbxusVaez8DphVVNTERgTZxf8OoX4?=
 =?us-ascii?Q?YajdCiaI67z4uOi/tfSIjIcIPdnJo0KReCV3pIfUB7VswsDJmYYrUKiKrLXa?=
 =?us-ascii?Q?S5Rc0s7o4CDVlSJEVkw1FMmlM+mvaNiXGx216WHYWsgxUBgoFXtrVaJPxAxx?=
 =?us-ascii?Q?Rx008pHvj+bvKEzx72DJ06+6h3FOa+s9VXLSidWSxIVv0c4vnsfJRlx3bQn9?=
 =?us-ascii?Q?h3B53RDfFLC/0dsH3LQxhbQXlHu/AHRK9Q1L1pYMbR/kSQRhyMvG+xXTcia+?=
 =?us-ascii?Q?I9wbBxplNG8/FKP6D6R0BAh8GrF0nk/25TjJilf4L5p9NgWqMZeiUBNRgGm1?=
 =?us-ascii?Q?umDGJo7f+lzouOMscspgjnmYlJl85oA9OXpIPulWAs6icYUFHTbgmy/KTQSY?=
 =?us-ascii?Q?lxM8iQLgho40eG0CTdmIwjN/HqWqXSyZIFqtaw1Kt+zn8k9U08f35R+uDRR5?=
 =?us-ascii?Q?uAHsBqvVcU5rS+ndgvKk8JU6vL4Ev+cuvUp4p2OHnGtOBeM34P7kA1VCNiNa?=
 =?us-ascii?Q?4gikTKyAe6APkUf6MgKL1SRpA0uE/gbKVBCl+zhxoR6t8A2tV+NuCQV7b1Mz?=
 =?us-ascii?Q?Y9BhPQXKeY1ZQSw8lYTVLqnfWS2JtoQeokwEPmGvVKGr0/xNnEiiCDePAZ0J?=
 =?us-ascii?Q?B/PdgNzIEhfacaXTCG+q2si9Rm+5DelEgSRY6DqRCmojTDYmcQs/AI+hgAhu?=
 =?us-ascii?Q?uIgeHDd789amVMtzDu+8N+5lgnVc8DCuoEKs30esF2FSMwBtqzBGPjqNYH5c?=
 =?us-ascii?Q?rGMNa7w643vRP+h66cziCH2pjAeJHsGvWdub0VMRRS2/mTXWb57G8Vk2fWpJ?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kLFgJcg10H+N3uY4sb+AYyt7c0DOU+A2H54p6XgskoR4LIr9ZF6tDOKNBJ+93KiX2QBtrkSagi0MreFXp4ERL1RcDfdFoONQChOd/9Ad5Ygn3AkkrKGT620tqEx8XdJEir+1CScUFTxZCY79J+B+WCCDEo7y2mENAWTnfJvUci32+V+PGtNhgMaKan9oW8qWlFHm69PkBPRZSinKc//piD0ZN+qI/NyeciBRKX3/fKLzCrQzIS+1u13eujANTLhLDgzjO5QX9FnRO9+s8YZhWgDqRMIYM0itZF+zd8QZSZvpiX6HowBznKw+cY412bUyQhYlOqW3/inyNUwvl2IU6JyP/FKYsmtSlvu9putQVweOt61zH/W3DgSDSNtSLsTFr1l85tZCvekvYbuBZ/PCY3CSluRBjIvT5Zn68GlIXPkAlZwKdemuaYnCt11mrU/CJS0gF31XSoILRCRX2OOAQY9r11E3jC60rulnRWyxJMWL28Sn57ht2PUt0f71TKMApODKAT+avmsuJO15aphRrkyHwsMLJzf/qPV4ZlzGTBm1b7zjNIVB2r1WyoGasRgDX0R84eRkq1JONFM6W/fLH2qAV8Zy9LUHAVU5vLiI+Qo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b0d92e-4f73-48f7-daca-08dc1cb5f629
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:25:02.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwfD0K/j2G+eCPNMxCLa1cqLE3caNc/GKdX8WcNpIjrs1reKTBE/GI918Z7nTIRTy0lH1m7q3dLCB4CFwU7Adw+5z4hCb36NgodGYC0b+1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_04,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240058
X-Proofpoint-ORIG-GUID: xiLKfekqsF55nbuO8D8muQX5yGBlLr22
X-Proofpoint-GUID: xiLKfekqsF55nbuO8D8muQX5yGBlLr22


> On 1/23/24 10:59 AM, Jose E. Marchesi wrote:
>> The definition of bpf_tail_call_static in tools/lib/bpf/bpf_helpers.h
>> is guarded by a preprocessor check to assure that clang is recent
>> enough to support it.  This patch updates the guard so the function is
>> compiled when using GCC as well.
>>
>> Tested in bpf-next master.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: Yonghong Song <yhs@meta.com>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> ---
>>   tools/lib/bpf/bpf_helpers.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> index 2324cc42b017..3306f50c5081 100644
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -136,7 +136,7 @@
>>   /*
>>    * Helper function to perform a tail call with a constant/immediate map slot.
>>    */
>> -#if __clang_major__ >= 8 && defined(__bpf__)
>> +#if (!defined(__clang__) || __clang_major__ >= 8) && defined(__bpf__)
>
> Do you want to guard with a gcc version as well here or you assume any gcc which supports bpf
> should be okay here?

The second, because GCC versions that do not support
bpf_tail_call_static are not capable of building the selftests for many
other reasons, so there is little point to support them.

>
>>   static __always_inline void
>>   bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>>   {

