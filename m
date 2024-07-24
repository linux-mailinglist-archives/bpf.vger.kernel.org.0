Return-Path: <bpf+bounces-35538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449B393B588
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 19:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F781F22E40
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C87315EFBF;
	Wed, 24 Jul 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AuK3G70j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KgL7eedO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16563282FA;
	Wed, 24 Jul 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840754; cv=fail; b=iZdWwI4H+KkaaVvhSWSBDBuBHTNj0eL/o3e3EXqrK+7JctSMgxI+Y11MunTNUqulfiKhk0H5bItUsOP7dZOlF43kObCNms9hM4k7kUV/HJ5WPNQGsrf+BW4/BGv2iJKPIyXTY39RvcXMcjilUTwQogRXMwOZ3dz2XqOpVJDSnx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840754; c=relaxed/simple;
	bh=RNIRqxVK+7XC77/VkimeLHt0DUZ/fWvs6sq2xE6tkfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CBQWQOO4BTmnRyLo4tX6awsjPq2IaqBwMrE3LNgnLm+qdd9ED66eCDziTtB2MQNI9y6YOzfKisEQ96S4cYJ21jfiZ2WUIC22XBdFAcvjnwFg+KOTM1z93cArqwhuSk1D2VmhizCo5XSicgaUAl7Gt813G0Ow1gstSsjn1olqI8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AuK3G70j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KgL7eedO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFXV1A027342;
	Wed, 24 Jul 2024 17:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=/GbdMVor8kMD5pX5I6KHIoNIsTIGZAAYkMsKachs3MQ=; b=
	AuK3G70jEteElht2P5lNknQQdmkMEc/FVWTnn2C0D86t1heTjimhSMtQYz4ImhtP
	/sgl+qL74lJoARSbqma65spPRHvjWfi1NZdZHCfnYKYOUdjwnNldJERJQFMZc0Hi
	D6yqCme4fDCGUgJyodYtalfFhORkE37w8qu3/6rmFi7bER+zBQTthyrIs7ZkodcY
	lFHvm+DpnRcI2WlQDuHxHcfH1BsZqoZ5aTb/X5/H/ks3HTLnvMonwShz2+ATAFNg
	U1tT6/ksUAxGs13z5Y8l8CowBYlBdI7rw/QsRTUUVtFvgeMs5O6tF8yUC/pW/hoU
	u5hMThubJEMiv5NmolTmqw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkr1bg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 17:05:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OH2v9M034367;
	Wed, 24 Jul 2024 17:05:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27pc3vp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 17:05:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lm0/zZ6ICAD/6EXIL5CPFT3USE2hrkVytPavHEloA4UGfkYwBYGi2yV4Pu58Bc2NdwxoeStMvlH9RSavMxxgfGeNh5gm+8ZyoxucDxD8c1c6zlPyt7WE0KqfH0meWZGnNy4uxW6F/4onuBbH8+WwZebDRdVmhvCBZfE2TuJbCAjNeFE2zSqNUxlk3+x3WpuoYOfxFHWpOzFaOrPTH3+sK3giwLEGQtiYfamn4QpNXCrpTVV66QtQt4kdPThn8hbvIFjT6+lXPKqotl3ge6x+msGDEbwebzX5R4lZpQSL7J0plW2S5WHsrg0FKvVhlH1cKc1Q7UNog4AGk9Uxy48mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GbdMVor8kMD5pX5I6KHIoNIsTIGZAAYkMsKachs3MQ=;
 b=IUbku6iePqFyiqje2qQa6WMnk7ITQv8czC28wdYiGpBTdiXkPSij+1qFWMynv7+leRnpY6BYRTohU8G/tWAk5TlVMatNnKf+KkCMi5Lr9foDQdaUqbmDmABRpYM0jrTIANlXQUqiQUHSwt3mxTcjbauIGr3Af1mIh8nhLSMegBh97lAs2AvaxIWBu700uO3UTUEate+wLfThNzceI07HLui1PIFkpLNLvBifXoDu+Ok+FVd67T4xS+f0DiO6pGOPUgVhPsIMbXPkB2Ong8z5s/62qN2W+PS0xnPKipfOivtyz1dSJNmT/kZP9p4SD8PqRVjvGSsG82TA42nAu2uh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GbdMVor8kMD5pX5I6KHIoNIsTIGZAAYkMsKachs3MQ=;
 b=KgL7eedOQbDf+5812y+Qg3FCwfvmI97r4/3U/CYyc5NrokGdw0r/SpyREwMNtGER+OBWputm0amO89ZfNyzcoue8vlNOlTP7CeEt0DZQmajJWM21P5mj0hLQRlJhNajvni0GZVjeY/RhcDQtkhJrXgiy4/OM73vjogx49hz3uso=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by IA1PR10MB7237.namprd10.prod.outlook.com (2603:10b6:208:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 17:05:29 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1%3]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 17:05:29 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, si-wei.liu@oracle.com
Subject: [PATCH net 1/2] tap: add missing verification for short frame
Date: Wed, 24 Jul 2024 10:04:51 -0700
Message-Id: <20240724170452.16837-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724170452.16837-1-dongli.zhang@oracle.com>
References: <20240724170452.16837-1-dongli.zhang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::13) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|IA1PR10MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 71eca7c0-98c2-4331-7722-08dcac02d1bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+4Hum15SQ7PSuQNRd6QhP9vtcRPBv0qj9KLhey7r9rUaEhq3YjE2hkKzRlat?=
 =?us-ascii?Q?yySJtjjOSxrTupz+XDROw3rUVOyO7QgbRRm/qum0JwcHw68xBB4KDtTRSJqu?=
 =?us-ascii?Q?ZLjr82QzYsIShhoUWrRCb+iGQTtYJqEa1x/muKSXJ+3cBzZBwZenVdhpCsd/?=
 =?us-ascii?Q?2E0nJCIGeArHFQXkXBt6X46uEfKHJ564iNuqQcEhmsxchMLM2toT4CZr+bjK?=
 =?us-ascii?Q?3BUBZL5TuSdGYLtuUjGy3U54U+TfFhMkWZfFZL2kXIBSURaA+FHMKpGaBqot?=
 =?us-ascii?Q?dSuiG9wiPgnUbfFzO1puswLhnKvwv97bDdVqmAlKO8LMg5YGlb9lxCQ4D2B9?=
 =?us-ascii?Q?nus7/+PlqM8mwSQXkt+6Ysr7ZLaZ8uV+a6hYG7LobKFbpE/UK0iqbVb+61CN?=
 =?us-ascii?Q?Cli6SeC88bPeD3xw//xr7Om2ekWeQBqoDiqILlVNOq1xhEgeNvj0Z/u3Ds1O?=
 =?us-ascii?Q?Bv9VjmFZmdQrZLSbFFRYut9ilTKYGpHOLTCZiysxDRFFGVna+xo3LfdeFJHo?=
 =?us-ascii?Q?TeNQkwBO9Xh5g9x3iWhEdyH3RFNimAYjfsSfTKweWOlc/4lFQkZlcwlxEdxG?=
 =?us-ascii?Q?MXY3tvyTu2RvS0E4Ke87Zgsv3m/vvKj4iY3lNECNaxibIkgUhDim2x8UkTEQ?=
 =?us-ascii?Q?OKce8FwiAFMkDz53TMrzoCH+2uGVWOAlhf0DJIcZGTgsgzr4bokrDQq1jSl+?=
 =?us-ascii?Q?X8YCHRPcDePZgP6wzZgQFMV5LCukBqsIFqEc7SnGzfmMwW3tPx0cMUzWUuP9?=
 =?us-ascii?Q?SJH7xFfBW78auxN+SY2lNrStmYB5WDI25reVaUg8Wq+YDgpnW7sZ3Gkvp4g9?=
 =?us-ascii?Q?9UgoZ8sO3UCTclBaFTtuICoc9xHyx+0gAkUYo7GJybxg7BiaxD2F1ySs6Ri0?=
 =?us-ascii?Q?zNywbUybcfln37lOiXgGOF7HOo+sFTLhiIw+l5K5P0Jk47g4gpbeLAb93ikM?=
 =?us-ascii?Q?vTfHRZ/1XS7j1bmPNBO2YYqiBpFyoItVuojoqPGCfIgX4miVZoaAWbE8tuqG?=
 =?us-ascii?Q?chNN8HxRb6kX19vxWY1+ho5+FjPtfkr9i4yEHUIVo3Js46RCZuogADBMEfrM?=
 =?us-ascii?Q?7K2y4Qaa8scMGmOcWKGXPxL2lDxVDPf1FvTf3Ds52lmbmKuOYbaLd+JnSTUA?=
 =?us-ascii?Q?im+dcHbTcyu8Sxj2MV8ZFgx7bzFrSu/PX8XCqxREZmh4Its8lgTp/cPHLdZo?=
 =?us-ascii?Q?dE8GJ+CH7WFsCJy8bQ1oOygLJomO01CijvncqUfhnXAtUEpBR6yeNpG8+9kg?=
 =?us-ascii?Q?swJ1jMOCtgmLsWgH++eIYSwlnEm5GrbJ/PhLvP8z+pItcFF57HL4gfnh7CQ/?=
 =?us-ascii?Q?s9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FPBAHflCdBSI+ewA5/f0g3Emq3pqWP1X0q9IsrsdBSeuUMIG8aHdoB/woiR7?=
 =?us-ascii?Q?Hej5f89JVwfhod5esAv8XjuC4h2eeVxox+JiVsDqTz5FMOU9s7S+3/iCQini?=
 =?us-ascii?Q?ycotbXgp8K+t1hcRoevNf4cjcLbl+HHOJPhslssbA39+3EdDTaBVQihc2cEH?=
 =?us-ascii?Q?jt4uDieU1nCuL+Z9Knxm7EbqoUwprjKqjqDy2w9zA95rX9G69AdrA6xLdg1H?=
 =?us-ascii?Q?qv3T2Cd7LTPbGLLNIxC52vFqE4oQgFEtcaO4zmpLHD/C8Q44Sgi66ELFdIRk?=
 =?us-ascii?Q?8KCxIB9jHEesMZiRh5MfSt574ByC24EtYgcqzhVeujMqixByvsZipLU6KBgZ?=
 =?us-ascii?Q?OwUHdAPnA9cNChtoVsXXNZIQ0I+2LgVfZDgTBndpYZd9jw+BXz4A2CPDUgXD?=
 =?us-ascii?Q?RvIX4Dkk2Xdc0Pm2t4ljhUH8gpXq9+tT6UpAh2ovv+xkGCdmL/J5DjFGl4za?=
 =?us-ascii?Q?CaYshhO10rxsttdbvTUkRYlfXGEYe+Imaadtbr8tTVpvTi/y6425GtLZhbZb?=
 =?us-ascii?Q?2kZZG/tQJTmT1RN6jxT9R1S6Vrheya13dyzdx2NkVFuqat3PjtUJkOMD4kN8?=
 =?us-ascii?Q?o1/m4e7ufEurWmVOklhWyawV7WQbKYz+kcyD0hhoD8KZmgUK//T1jf0bdFTE?=
 =?us-ascii?Q?gtWm2J2QnDkbc1lavvqbdg/oEsO8h9OTpYICk8zgyAOUoQVg3Y5JLga4BKE4?=
 =?us-ascii?Q?PTei19RK8jzUABGcRtyS9epW9R7S7VwCViTL8I3kDUwA3IboelaFI3ayDMVm?=
 =?us-ascii?Q?fmtvCH+VtcZSCKgTKoI8AKbpNFv3avFWsTQfbxA7S/Hvy5b8ygM//r8bO3xw?=
 =?us-ascii?Q?FaO8Sr1/R4mT5QElNYiuyCkL0whGByMIqjxaQMFDctw5UAPBUdCleJMF11dr?=
 =?us-ascii?Q?P+NSIxMn0FtRC2YT1i6gp5/o3+O6VzRh9bKQ4vT95CpizDeuepEP4xKnKi1F?=
 =?us-ascii?Q?RV7bFTotcOXnCp4gkwon4QRYI/2SN8HpwdVdMHdCj4yX2X76mveTb+yknEig?=
 =?us-ascii?Q?N+d3hMOxFlTCaQ+4m1tzQOyAoqK8ah3YbFMLiodtOjjhPe2k8XTgno/b6agp?=
 =?us-ascii?Q?3ckNsTlSVYzc2Glitq8qO9bXEj6BvYsJ6gXXTphJBzwCrdcdPpGv/n0h2xoI?=
 =?us-ascii?Q?GQ+4XfKM+JgABvwhVNNzS0AIceufocMPcs5Wvhn9qSXnJWMj8E9rPKYdPxLU?=
 =?us-ascii?Q?OEVNe1kxjsdBM+OGZg5sp+VdJjcdO6OX9FnnvUAVPlZskjjfHe55/Jy51RxP?=
 =?us-ascii?Q?342rkr3KWI677prNzkV4N3ITrcLy6q2Sy5mWlaG+r9/pV4XRVbHczRI8ZLfA?=
 =?us-ascii?Q?tNnRSKagAVEgC0aKqSaEtQqXA0BYhReKh8OBDg8o/BBCIPKsUx+Jk1849Lqy?=
 =?us-ascii?Q?fAhNS7FOfvN/4JiEsE88wfLzmLVWkN8pgyCBGIv5eGVjs1JMOekZx1L1qYNc?=
 =?us-ascii?Q?qDwSZ4cEwMKNJjKWCO65icwAmb6NnPsEYSNeS5xUxW+HHFysdKWb5HIzgfPb?=
 =?us-ascii?Q?mEi2PiLVB9/RETellmwNFaS3wli3U2YzQUnIuFVP4O1kOk6ostK4lV26tDuh?=
 =?us-ascii?Q?DzTMfT9mXfvRKeUv4dLzW9CdsLEAp9TLXX+Etc/uwBUBCOkjA5tKFIPEG6nz?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gQNwrbXUspWQw1p4a2w/aoAkxQZyXWqVWF55dyR6LW1Biv3AYKR1C3pmIFFFYq0i/+0pcsgsvONdj++ttXa7lsHBEua/rp9IfCVMVDlOgUM9b2vu1UTM+eyOOu4c5rw9JLqmGEW725Q73g61wRQAfBLhj9LlMvEkK93KaaeUU+sQIkMAzCkwl9OvtMco+/sj8b5JYiSJ7UKsSWigToSNkY44cFBM1Q0qZy1WdYnOOYTwwtV4y1AdKtUujImgaJZBS0Mbx8777IDU3saZUsH7FEoUl1cPIsIvf+ekqiWwqEWf1jjYAEX+hIb45sA+xufJRuJK+yx74ON7agX7ie9g9fpiG2ryxM8MX1mZnlo+x+etJJh6fksilhvxbwAqNLbp421mGtp+RoWrqz99bpAHrLuStwfuHHTF+c7FlQbsX3cYnBWhw642Um7qYL0JWMoTn2gsQajm4GrDJZuM9rx/fkWNncX4KxLSsrdEWX9ZVrO+nUKXeMz1Fvd3ByiGOecIrnoGf/PAOzu7QSejor9j7+mPiuO5FKEIVM0iwduIbHfHDOCO+WFiNs3PAK32E5F++w1jdRJ7QssboheMTMsbeawOm7CcvSkxzsnhnmoSbCk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eca7c0-98c2-4331-7722-08dcac02d1bf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 17:05:28.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tr4neazZBf90EXvz98vnvFK98ZzVH1D6yyTVIqzCDdZCma6Fgyl9HY9XLIlQcKtFlarMVFulNnS4Wtw2EAUYpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_18,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240123
X-Proofpoint-ORIG-GUID: Eg2grRmKENnhHFGB-f9w6oZjpeQu7XjR
X-Proofpoint-GUID: Eg2grRmKENnhHFGB-f9w6oZjpeQu7XjR

From: Si-Wei Liu <si-wei.liu@oracle.com>

The cited commit missed to check against the validity of the frame length
in the tap_get_user_xdp() path, which could cause a corrupted skb to be
sent downstack. Even before the skb is transmitted, the
tap_get_user_xdp()-->skb_set_network_header() may assume the size is more
than ETH_HLEN. Once transmitted, this could either cause out-of-bound
access beyond the actual length, or confuse the underlayer with incorrect
or inconsistent header length in the skb metadata.

In the alternative path, tap_get_user() already prohibits short frame which
has the length less than Ethernet header size from being transmitted.

This is to drop any frame shorter than the Ethernet header size just like
how tap_get_user() does.

CVE: CVE-2024-41090
Link: https://lore.kernel.org/netdev/1717026141-25716-1-git-send-email-si-wei.liu@oracle.com/
Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()")
Cc: stable@vger.kernel.org
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index bfdd3875fe86..77574f7a3bd4 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1177,6 +1177,11 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	struct sk_buff *skb;
 	int err, depth;
 
+	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
+		err = -EINVAL;
+		goto err;
+	}
+
 	if (q->flags & IFF_VNET_HDR)
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
-- 
2.34.1


