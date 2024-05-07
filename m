Return-Path: <bpf+bounces-28807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB118BE114
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E572FB232D9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3FC15252D;
	Tue,  7 May 2024 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lXA9RkqM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JJIh2Lvk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BC91509A2
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081898; cv=fail; b=f80s88atDV/3f92b9iAAbyd5cQfxu5YA+rKf+u4zMpNO13HlkqU9ep6zzNw0LIKy0Lpri6p4xjW8RI68APZJBWTY4WNHXoZ76QXF4P+TJPmrE+XYpW8cWI0FHfjKjAH8jT7FnIAABPt1YD4BtGWz+e/MSaD6Gy1RneSyoSD3hqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081898; c=relaxed/simple;
	bh=fbrowX9FLDBXTp9vVtNvx0pCckBU+uBwcY03fTyYvF0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=moSqzRYtv/t4iXdbDgNBfnGy/JkcuE7469K4XUsR8yL7B7Pi7wzVD6mBv67cZho9eaEq8F+ZPij8yVOQlsSiDOrmywwohe7bfNg13zZ9mKRjYnZ7/RigZooKh/YGWVg5Ynwahk+4fKQW34Vz13AMIBke5w6e5lKWlZ4Ebd5h7Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lXA9RkqM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JJIh2Lvk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44794U59004034;
	Tue, 7 May 2024 11:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=+rXEWkpCocI0AFOnmJ2DGRsuUHy213CtymJ/2WzUvPQ=;
 b=lXA9RkqMIf1kV5f6fqLMa4xJZdTWia1GS8CBNwUCoiabh6SAtTH4QDhzxv0Q9L0QPKTv
 qDG8NZmJ+8aPC39tztCKe4LAm6p2aS446keGF2/PJisvouS3frUrj37XXNnDwPFUeJXx
 0nZCKd3IksnK3lpjizusEl/eZmFnmxYt88dg4chg4oVQ1L2ik0BffTCJ+CiPqOqrZyAY
 wohcMZWNLqHT4Ye/UCoDgpzjGt5YraocfHObYjYgiNcDI7FNl/io/z4ZtNwqOper6vYF
 P/jQrZSTNJBTdld5Gonjw3l9ZvKkVmBMy5v5z/DI+FepAUlnGkgDUhFvFzEuubw8iGyC Aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcwbvqyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 11:38:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447AFgei014055;
	Tue, 7 May 2024 11:38:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf7ajng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 11:38:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKuxTDxWEOAta5hc1kowgFXuzNVTsRbI+ACLBNDDfmTUGegyfvrlAu7hkmpuj4WcnJLN2LZqI9iqLIfWpGULpag900/ZU5k2LYLZNrSuN5D92H4U/MWDaNyNORdZQifwiUU+mjKY8Mh0MC74aJPJ4n6DzawJwm8UbyYawJHrm6bcDSLNAXfMexM85JFAfmod/CrUJewlx8rooXyHLotGUy56LjK0TBa3z58MJT629kDKIo7rj3bE6wfnPfi7/131w6VvwiqNxAd0hMcbeCnEecsVWx+4eHax5f+vJJJTTlVa8Hn/sAknj7TQ4GRvVqKK7vUXMOLJAJKG1FvmTLr37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rXEWkpCocI0AFOnmJ2DGRsuUHy213CtymJ/2WzUvPQ=;
 b=FuPrsybt4Sn75sTZ0Ttgbbb29aBLwPOvDkWUaEOSCbgOWa1qSmsHVMJjMrNmoYfJWyz5hZX24+HOfCMqNPXspH09T6btXUproYXXK/jAzQqh61h6wjWaqZwev8S/YUC/WEEOmETuBQZJ9IR4r/ivt/QRypPb7HuWc9W24wM6aBrSUh5oOICBOBDzHoSwVRjdQv1rFwrsVnMSylHRVUbY50bwqPOvNE7UAspt7ieijNHecOXBxXctQ7veEU8ki/RLf5DtYhbEfaIW6ohL+a0GViFrbfFJ5nPmW0emp/uz3X7oXUhzQFFcCtWTunBTiAQinJB1rgxr/q1Xi/r/MgFpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rXEWkpCocI0AFOnmJ2DGRsuUHy213CtymJ/2WzUvPQ=;
 b=JJIh2LvksLfONs0wWJJ+52k9NPG9uC2lbpvwdRImpUE4qtupD297NMXRO3NyCYYdxQiKPn/i13shdhlvUR6XavUEAAEWKtd7xz/dPNRNbEunYgk9ALLxAkKu3/mv3sukn6YnyC7oVnWIar2/o/hSA+2Y6WHG1mDJtlwqDEiRtrk=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CY5PR10MB6009.namprd10.prod.outlook.com (2603:10b6:930:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 11:38:03 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 11:38:03 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] bpf: avoid UB in usages of the __imm_insn macro
Date: Tue,  7 May 2024 13:37:55 +0200
Message-Id: <20240507113755.28118-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0566.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::16) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CY5PR10MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: caecda35-d47f-473d-0c20-08dc6e8a27a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6Bw7+HnzBURYjg4aj8BcpphaVsHs7Tl9WNX8RDBJpt9NyxixNh60nPCFxMKg?=
 =?us-ascii?Q?uH8STcXIa5rWQhDW4Owwpj8/+uQm8XFwK3NdChvI7owY7snFKkib8cUJx2ZA?=
 =?us-ascii?Q?iSAAtfQFM5nj+xU2GmaN3DroLLmSgW2V2l7FxFcWgFI78qpQjn/iJ0idQoNU?=
 =?us-ascii?Q?7b35i2pu0MixBRnlqv6UgVr3q2SpSnmyzi27pJkU8fSJ1+GCtQjB3SaJFoba?=
 =?us-ascii?Q?0Byz+dM9H/1NEdSqH1PY38neuMnXI0+TlfIWLD6F/i+zlbVkDIH0cWc7a5FP?=
 =?us-ascii?Q?+squD8eXjSYxH/cNC4gMJdutSffTtWaD7our3s4/kiZr//XK3+UQ6qLalVhF?=
 =?us-ascii?Q?+Xi1lCawjAU/9uhQiT/0Hp1mwYI7mV/TtNQ6fKKUwXirX7vjwozENSRy69n6?=
 =?us-ascii?Q?cK/gddVtVK144VodmtQ08N0BacAYn+VPuIFxcKRm3vGpcTSgNjptL3wTYQ5N?=
 =?us-ascii?Q?Ct5mebzSxbriw7CbTJ1CsoHzOX8t7mKgNqTulkyD+AOtDwOZIaN7RG46UyyO?=
 =?us-ascii?Q?QYNNb33HPceWDe3WFAwIVH267uMtZ14HhWyGzaXRQNSFQEiY/qH0b4m9DHKd?=
 =?us-ascii?Q?2QRADnzQ5xIxj+RyBb7vr6t1g3JHqPywM9AW8tmx+eGnkMMfypteUwTAF0jr?=
 =?us-ascii?Q?pvjfau1WKqnlRfK/kLbuJVgvnOZeDGsBP+JxEy1/pXScEl5Fwed2rsEzQuRV?=
 =?us-ascii?Q?7+o5lwwPp4YdVp9v469wJdW59G6K1bM3lk850L70y++z63eMXJn8N86simKh?=
 =?us-ascii?Q?HZuNoU19C0nP3Rnru6UqyFEgT6eTTyrB8c1P3+0cFH0v+SpNXFiskA8i5TJC?=
 =?us-ascii?Q?1gryx1ezxraGwNbxgoccN34/unm1fZNsaffhT/bG7koCaliCz3a7QiYpeRjl?=
 =?us-ascii?Q?BxF8G6QpGV0BSPifZndig7OjnWaDuCvR6cxJPw9d6FEWPc1BwvCWBSkZDas1?=
 =?us-ascii?Q?3yi1agOkikjLVcF606ilPGH1mEo/lZlkPaGRCQFNOIiWSAzSb1dhSqLDTY1q?=
 =?us-ascii?Q?ZpDf8U4eJGrtjIP+Er1ja1/gjLRnIxpTu8Vf2KjjpFJ6m4YiSEXVwmuaxEuj?=
 =?us-ascii?Q?UVxtVPkErQC68r3Xu5m32zZRLenNypFHgdLxWnMeWRUw0zNlUi/8kr6FZWf8?=
 =?us-ascii?Q?CJoSz+NMQ1qN2q6ql98pBNUdhdFVUUOQXwcr0JcfDHJZOiiA8ZyfJlGnDPlK?=
 =?us-ascii?Q?GbhHqvh1uHHv7HzavKh7//+tRQgqeFYzAswG7ps3b5GRAL1C7TGdr48dIejs?=
 =?us-ascii?Q?w18MY3frN2/5ThFwPelPeg0qahVhWN4AXwHJoNbZ1A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nnvWlo3uxKxpsHQ9cJdFYySCmmDUin88f0JUtCgWaTOb3Vcl2kPkt6jmmpMn?=
 =?us-ascii?Q?pAVO6CyClsrO6d3gAZLA2Tx4RwnVR7oXOz0I36pFXVhd54F2U67aJzyO48B4?=
 =?us-ascii?Q?dZPxaTenr/3EVHowFlpT0ygQSpKGCdDGaaAZaWXwkHsZMOi0/DL2VUUlBboX?=
 =?us-ascii?Q?+pdq5jLKOr3zPxMWzx6i/OnwUR3CYw5QlYiHydbfdZiqO1aCXAk3ZnRz+kj8?=
 =?us-ascii?Q?O9RoW+lVSNv7mOdQZE6675s2m92RxMoRZCGK8Sm7ZcAkoDuQ9fTFUdaIu6ZZ?=
 =?us-ascii?Q?OeCOQD/tii153HUp2yG/ltqlpvNPMxUh7LmtUl2/jJe2Vcz/uQkoyRNW5nC/?=
 =?us-ascii?Q?DswI8sZmYejk6bzvKjl1uYjax2wVhnf4cnEitiJ1VJuyH9BcPvYjd+Pvr/78?=
 =?us-ascii?Q?bSuIdRdVQyigx3LRvwuLtAsfej/k8WVwGytZGjEdaRydhZy7GZsLsDefkDyS?=
 =?us-ascii?Q?hE5Q/hDY/l5jxom9In+teNVR48v2hKeS5p4L7ViW2G/bmhxITgj0iWux0FRw?=
 =?us-ascii?Q?mHRPbz5FsSwzmqLAT9z0SC9+Jb4BbmhnAbuJVR/LnWng/vanLsnIV5wGGl5k?=
 =?us-ascii?Q?s8FdCC98GS4KhLbNASLZonvJlsUHG8aYXEU0/j1J/h1RVEfu0AwzBLmMgayQ?=
 =?us-ascii?Q?zLTO+hH7BxQJxTk4vkGkHfhAZqRCg1tzgAmJUdZMmTUmdegEcwFwcR8o04pT?=
 =?us-ascii?Q?I9MMvwkZQwl38agnbuVvI8iEXbGPuVaTekkbqNNLis5idJIMwYv9d+A4EVmK?=
 =?us-ascii?Q?STTJZ7eXr3LRVxai6yp4UjaEsNSA7G7W5hHO34YDDgpQvtw48x3AR0qCtP3O?=
 =?us-ascii?Q?Sn7dktaHPTcEgsaw71ogoEWPemWa9G+MEKV+cCPua+9aASt02Ovaf4DmW0Ym?=
 =?us-ascii?Q?cZ/r0rgYZn4iE4Q/cS9QTI//NsIhfmLsCeyipeLmyfr2KBDQ0Mrijcw/vgib?=
 =?us-ascii?Q?SIOcYMne8RpZ5RlDEsKoBN6XNMQyab6nTF3kc7Nqj+piD1QyNQ7fqRChUaT8?=
 =?us-ascii?Q?XY3XsDU5d4iWhOTTJ1nmRQ/NyyqpGBN6W/wpy8n48XFflcxwR2X7PzvK0HBM?=
 =?us-ascii?Q?fe1IdEaOQbReebYs0NBF7NS7+zsgRm1ywh8DrOza4Fi/mHBuD4WPhxIuXxOK?=
 =?us-ascii?Q?pr8W6JZHbFWTkrwSUaojmCPr+ytpsBM8mSI3hYgO6VaJApYoLu/CjLfYIvlH?=
 =?us-ascii?Q?dbn89bx9rRIfF4aQ4ddXTv9BWFlM0+D9qz1aN5vPb0GBTDTBx0NAOGJvSfS9?=
 =?us-ascii?Q?A5SXps+J/iGV6puI8VE9xAjDd51EIT05bATgBFtJErxtB4/gxV/rbxAF8t/3?=
 =?us-ascii?Q?rEdi0sVt7MrJNebBmv/VfUB6gLylJVD6JswB1GLzovU4OVrE4Lr8reWufFfF?=
 =?us-ascii?Q?cJTnGgNDlg2jfOgrSU6lPeopmf45eRG15aaOxaiov7N92GB0JZL3lrIahYJ9?=
 =?us-ascii?Q?9ua8p9ScnmsrY1MecglLfNcj8qDd0L8AoPIq3xm8RLu+1ZN7+1i82yg9Ju98?=
 =?us-ascii?Q?xZ9oosvDVeZzT9VAsQ/8kYNXiOmsxpoOGIk7vtXA3cDF1CyVFL1v6kybYCam?=
 =?us-ascii?Q?ebkoO/Ic3QhFX4GD0k5PucEtwSv4l+1cBBx6Zqv3Oq6PQ+pBTmDNqFnrJ2/R?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9MJqDCnJ3JSSAW99a5ecM8VwN1GxP9opAaRMxZidAnEqkyIf6dNUMo7aue4sUCUxi3Qn2eu53pbql3p9kBfOKvibLcm/h7HQMgyPpPhgLymIXNT4BLt/sGDqVI4g8yWGESeJiXnks8iRWSKrWUdJIV7cWfrLY4M617yYGqY4MdNJ23PhC+Kvve302RqoLU0JyHHFahexCe2u6UCJWMlgi3bYuungW+XE7S0CfItDv3aP64hEekeIWuInFgKDgWKj8YLsC3GbaCpxuoGXd9b3NuBb5amyo/ZftLaVSXj9A+IIAwKNH3yXmJTH19kL/2rRGet/TSkXAiD+WyKh6/w1avwzpla2Sh0+tmakn2HMApt5/tpIVzfN6QJOf8JtV5VSI+37jBrRZ+/5VMNgfaTz25FkZFF5Dcw9UJSVlITNXyXtoVMQXqiyUYzrgmsak6MSqZrtPO6cpSRsmrMIa4DCqEgqmrEyvAMNqaVG83luvmMmSbhxuWkHJvybxwrtY4XXMGewzQbzgL3lGItdHpCMBfIeBwZXY9FAEuZ+hqgFik9Zzh/nd0QyOV3JmSRSxFeMUgRvRAftWSmyYOrFzFbYFGT+EZJWvG7eoEcvj4LZJUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caecda35-d47f-473d-0c20-08dc6e8a27a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 11:38:03.1575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDUv0ML04pAiPxcvwHlp9MG7Mz5dN8riC15fpm/zDGjQyvBreysK3DKDkD+Q1bVyHcGe85cNng9SWOAfKtsa1effJC8tOhnFUpkN29M61Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_05,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070080
X-Proofpoint-GUID: ZlIx9DKDJbtwEoyptVTSyfclvHtm1e5v
X-Proofpoint-ORIG-GUID: ZlIx9DKDJbtwEoyptVTSyfclvHtm1e5v

The __imm_insn macro is defined in bpf_misc.h as:

  #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))

This may lead to type-punning and strict aliasing rules violations in
it's typical usage where the address of a struct bpf_insn is passed as
expr, like in:

  __imm_insn(st_mem,
             BPF_ST_MEM(BPF_W, BPF_REG_1, offsetof(struct __sk_buff, mark), 42))

Where:

  #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
	((struct bpf_insn) {					\
		.code  = BPF_ST | BPF_SIZE(SIZE) | BPF_MEM,	\
		.dst_reg = DST,					\
		.src_reg = 0,					\
		.off   = OFF,					\
		.imm   = IMM })

GCC detects this problem (indirectly) by issuing a warning stating
that a temporary <Uxxxxxx> is used uninitialized, where the temporary
corresponds to the memory read by *(long *).

This patch adds -fno-strict-aliasing to the compilation flags of the
particular selftests that do type punning via __imm_insn.  This
silences the warning and, most importantly, avoids potential
optimization problems due to breaking anti-aliasing rules.

Tested in master bpf-next.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f0c429cf4424..b0c696933d15 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -53,6 +53,21 @@ progs/syscall.c-CFLAGS := -fno-strict-aliasing
 progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
 progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
 progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
+# In the following tests the strict aliasing rules are broken by the
+# __imm_insn macro, that do type-punning from `struct bpf_insn' to
+# long and then uses the value.  This triggers an "is used
+# uninitialized" warning in GCC.  This in theory may also lead to
+# broken programs, so it is better to disable strict aliasing than
+# inhibiting the warning.
+progs/verifier_ref_tracking.c := -fno-strict-aliasing
+progs/verifier_unpriv.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_cgroup_storage.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_ld_ind.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_map_ret_val.c-CFLAGS := -fno-strict-aliasing
+progs/cpumask_failure.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_spill_fill.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_subprog_precision.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_uninit.c-CFLAGS := -fno-strict-aliasing
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
-- 
2.30.2


