Return-Path: <bpf+bounces-27755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD348B164E
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786021F2198A
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6901516DEDE;
	Wed, 24 Apr 2024 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fMkrZf5/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b6bEspCB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825316DED7
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998506; cv=fail; b=TFJZ+1L0UZEAlePSdya1wjX96MmjSS2TiT1fjFb1EgrfdW9UX+N5IfyHyMhWMtX4mQdHCW0ZDHCn75h/XmzHIkk+r0wV7msF9wuAA4JtxGsw7oTaRmYMfyXpg59OlmsFKQ9jfcTAHsxKUR+eO2fcAQRUBMK7H3yop6RA4Mh4J2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998506; c=relaxed/simple;
	bh=IXT7EllYrY19ImvhoKtc4LV57CTCFN4xxGH5Y30iiDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m+8oshO03HbHhgAfXaoLRO4LaQBneB+lcN6LTc84lYNZambxLpKvcLOimb2yE69H+Y9zcpNb5fQbqudmm5Qdou9xnNrK7Dhfju+AvBHh0EmDctD+fu6Z7GIBfxiOmLO+bdVRDkERNZZg4roPDW9iQAco5F1t03lG7V/gEwKKA5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fMkrZf5/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b6bEspCB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OG6pGx023261;
	Wed, 24 Apr 2024 22:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=G9V5KwhNiENMrf3ro8hqs3Aao5yYGS1Dmu5pPZ9XpXE=;
 b=fMkrZf5/XrNdRoxoXrQouwbN64IfUPispkiR8TH02inc2RI6ONKhytIOfUafZbwFDaDz
 KrapLKUbi4auWmehlOV5rxBeyRIUUQgvkbza4TSIFIfud+M2EeotBp3g5RzbDCwx1FJN
 iRyVAhV9l2+ZRxCuOGMGjnums0hfuQ4X1+27TnbVYDggwK7zAjpcELB9nOKy8UVeAc8+
 tFXIeqfAcDQdYz2foBSw2Nnt2aGqTRDUT7Qc56BbOj+NIPSN7MqLkcNYyBDiDU5AImGx
 D37cu5Yq1s0EwGrEAtoq5hBvRU1oPDKseuhzmE3dOie4CC6W2FvnVHfD6c8rVnq+W6Qg Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5ausas4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OLeOfu019693;
	Wed, 24 Apr 2024 22:41:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf5gg6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYhVa3ZJei91wSn9bKcQl0lu73xp9VRl4DnWJiG8hD4F+zmED67fZ+rpGPWwUfcy8AcVatennfcjn8ha2GCHSs/BfRZLwW+C8NbiT/x7fHR5jrIieRoP2LactKC3sjPsGNTPpOxdUq/ppzMHYBcnhiWoezDeNqTNgPkKg4ZjD+CLNNzvFTy6SacmomBf9DyuWjd6QFrQFA3NiDNcB3RnLboc1/IyFbOOciUGEKtBd/6YbckMa75Jvg0Hp4cBh7LTXqhDQkDsjkQICX9jkEquSFgld2qgvyixVkIXKsjhUFtdM8br2qFlkkIi7j9Nx9eCT4hOeEbHryhMjupWLG2iSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9V5KwhNiENMrf3ro8hqs3Aao5yYGS1Dmu5pPZ9XpXE=;
 b=Gi8djO/VH+qLbUa+DFZ2dOs5g9Ww3yUPY/e1a7PuYxMzhxFyrROd9H4OAEd5Uh+3Arc4uOH0xnW9MPdEDRVlvFd5xitSru90gW2HUyYQsudVWoOVzyhyLMe3jinQTaH2f6goy7AGKd9or9hIwJyuLXJQts+B/kD4SqaETUYZsyYPl/onJMcUUEYxJeDXbCIcf+Ldodd76c1Ndf263H1JSgpqXqCM6G45aCRljEoFMn7POgH6fwr6zUKS/vam6SBfq3medFjXgARMx8kPG63a9XyL16eDG1ENqNXvLalqIAQPrANDbf8D/AyAL5EGn5NtO8Qc5CmJ735DgWJGJQ+rVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9V5KwhNiENMrf3ro8hqs3Aao5yYGS1Dmu5pPZ9XpXE=;
 b=b6bEspCB7mwJU81a+VYoJiHoLyw8TiCQ2D/pZ+GeYhu5Wmoeujz8hyVHaV9yLxrTu3KYdPBPolrKSo34MVL3li0qDhDf0SarhqSQlZKQlwyhrLKaKB9WZkcNuKjl6DHdljoJYzMa/0HSUA3ENI7cupWj/86JsCFd6HoktAXYqQs=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6792.namprd10.prod.outlook.com (2603:10b6:8:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 22:41:39 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 22:41:39 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v3 5/6] bpf/verifier: relax MUL range computation check
Date: Wed, 24 Apr 2024 23:40:52 +0100
Message-Id: <20240424224053.471771-6-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240424224053.471771-1-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::18) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6e1c1d-182f-4b0a-01f1-08dc64afb4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RAsrG3Swtz7KgWW40iaVmiY+lx5IRESXthS275nwbumr78v+bv8eNIOEEgd5?=
 =?us-ascii?Q?Mzd7f8oqSNdhz+3035jx/edgso5855yl531Cl+HPBkIVAlHQ8V97bTqZMHg/?=
 =?us-ascii?Q?uV43JOOySpYRbTkxXAbcslw37k5cvvw6RfUJJi+A1GX3n8QWXZfNGt1P+a4o?=
 =?us-ascii?Q?hw5FejNmxoT6bcO0P0rynBUr3n7LifVKxrmHoo0vyph7axlstRkE5gNr3X72?=
 =?us-ascii?Q?8C8zTLdmhd+p9T8+HUtbgkiUoi4QWl+W/3vbf5RbDdqgKEfEiP5Tjqtjpy0H?=
 =?us-ascii?Q?74yyxdh6cSITpp186RdNXCFGJ6p8bqZVOYVaGIE1JKmWHFTsVWiZYpM6ZDLO?=
 =?us-ascii?Q?vD0xzpdWDAo858M28JlhgygERzaeUFu0iB0DWEaWQ7FtE5owDB8NrUS0MrrF?=
 =?us-ascii?Q?pdUkyQtQu9IHFdTm2XteV9fbc+fMm3YtFyzODwtHhvAveRYfDWMTkWGGs66h?=
 =?us-ascii?Q?4V3FEIVWrb6XksE5VWzD559br40KdUSYkMvO/FMWWLyaKYhiujamZzITRMyw?=
 =?us-ascii?Q?iN87n+Iy9bnWYcG9PaF8jVxOFSa+zPpgwVctxCYaOCV+gdJtVMaVFv0htSMg?=
 =?us-ascii?Q?Vwgl9osBtVLmv1v/6eqKquN+OflL0k8v0JLglPlaFmthgfeny0qUU8MkRcv+?=
 =?us-ascii?Q?us24a7FjkO2hhFiTEThjrPUcyXD8R+o/OPXDnJtYXfM5pEf+YqI9vt4UNIXG?=
 =?us-ascii?Q?TUyo3OShSQXS/Br4Y/0oh5YVYiYmw2TeAoQbHwyiiEmNP4Wcka0NunMVbhza?=
 =?us-ascii?Q?/owB9VtYrPExek4hrbk5EayFWGaYFl4nWJW/3zRMEG6ot6MGQtj04YFfU7lq?=
 =?us-ascii?Q?WccaxuZEZdqzQceYC8pnjevu4fIPRZ06fdstwlcQNk5JDmz3ow9xiHqL69uW?=
 =?us-ascii?Q?YG318fvONn++5aT7MIMyHpGQIUhiRPcn3mFjQCQxj04DNnOkxPA0BYetl/TH?=
 =?us-ascii?Q?QLcBn5jT34mw3TOvCglH7RuoHyja3GEvoDg6XCqa5A++vs9+9oSrfkK5ETbN?=
 =?us-ascii?Q?awuinpIX795yJQY+GFINvS4Snx539pWAVjBvxczVGPJX7aMv+kJv0yWH41N+?=
 =?us-ascii?Q?ydUhN06kpPeGENCaSSIlLW73+ZZM9mYoKndROuX4lvuFQLG4D6JwqHpMmg1U?=
 =?us-ascii?Q?4yLKmS3AmqiedV+pjh5IAC+K8uRB/PNzF5oTQXedYbP9dnkeQlNEWAtr0ZQy?=
 =?us-ascii?Q?oHMFGP5h/OiXv8ZteIsburuZKNizafE2xv3pUsVwrJD5+Ad2+pO/0w6iEnW9?=
 =?us-ascii?Q?2Izix4rXEDsSdMYtw6dqOQS+fxoLmoMl66GCgpt0QA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WAY19+AvL58RP72cncXAI3pVQO6tOJmrOWzuAL+YEC5M2gCt31jkJsBznMjZ?=
 =?us-ascii?Q?YRK9gd1KLCb5a0549v8KStQtTgd9M2VNRj+nd+yvy19p/i5HsTJvsgRKD88u?=
 =?us-ascii?Q?zpgNDO9itEAY7AXZvR7LtmrdURReVIBAfGRzZ/OIVK0nAmlRShxCGSp8DFDQ?=
 =?us-ascii?Q?AGFvNu1kRShV35BtV9OSN/NQC8lg3VT80s3lIXpHtXhWo5IkeM3bgsr8oNlQ?=
 =?us-ascii?Q?46Tc4QRdg5F4DOXR+9GJr3Bx9U9lyXXdW19puiIju8RD8wLaIAvOVhH/A82m?=
 =?us-ascii?Q?XhEyO/AYVvS4/JUAhfsDtjO7RkBCp2sHP15jlfjZVTz7UUB2WWVAVDdduIfZ?=
 =?us-ascii?Q?m92GIsCm2FDmhcvMsLldn3UkdEJUlLr+B0TabPEtWjK4aZR710L6z2+INt84?=
 =?us-ascii?Q?zABU0zVflMFA8CK3rPlBRV8PWe40PYoYdNzM7zkwTZuL1pa/O9DXiAIF1QZ+?=
 =?us-ascii?Q?3BbeQrsyqGYUBR8eBZpwFqkMikXu/+W4vhaqdILvI2bPQReUlfmjMnCRvzD/?=
 =?us-ascii?Q?WMBkMfvfmFIwjyQHG2Z90gMLy9vqDpgIx2Eq2uuTzgs5oheM6UknAnK0wRgx?=
 =?us-ascii?Q?Qc4b9ph32sa2ToF2m31NaXGUOYYcoHdBToKxjODMz4+/KFboezOSVZZKbm1z?=
 =?us-ascii?Q?RO669z8P8ZP1fKyzzDdXAL5jkWlDDqM59urdab+/1UuNqS/CdCgXZFF0LNeq?=
 =?us-ascii?Q?J74gkd26ppOMfasG6KMS7nry8FdYXCZh0MSHTL7Wf+ULjqDjto1K3zYbXqgy?=
 =?us-ascii?Q?aTz0nA8n8SqGfxQbb2JAseY2LBFG87TgBK2BYavj3Rff2rABO2LnBgtwiKDm?=
 =?us-ascii?Q?cBLPIG0eD70fHRngsO8eLsSWP3062ARz8nux6ErQMQqRIxK0aH5h29E55Zwi?=
 =?us-ascii?Q?p+YQYzWTNFSEAA3n6CKqiEM3VpOjfsXmKv0go7fj6zLE2btRMZfzTk3o0OBg?=
 =?us-ascii?Q?v1b/gNiCL88paUpVlepSJ1lj0WecOkFGcmczL3WWcMQdT3wKZGQCdEg6BITt?=
 =?us-ascii?Q?+Gu3xoGWyBQiWGd2LFHmNbc7FrNQ9BqLqlYN4LxiwQ6uyA28G4VUja2x+u2D?=
 =?us-ascii?Q?Yg5aB85MzdNgz7u03Bcoek1PRNyHzootqO4atBUHaKkINYTWtPQ5La/l1G8s?=
 =?us-ascii?Q?b3c6vuKHKNx9bIUOOGDhoyoD632J6d9GQ0n8tjcqY+/z9f5855L0yioJCujN?=
 =?us-ascii?Q?wR2h/HfyQhZ+rHRCuR7pzT24VYsIqCF1DaYPGwTlSHN9tQ6kknLYGTLHvmmN?=
 =?us-ascii?Q?TNRgQwNdmSotpQVx8GCSgNMkf3ID7WAc6TBomLjputAVXm2ZS29g+S91aYgn?=
 =?us-ascii?Q?odSQIo4sEFunK4nZILT8qD4f2aR1dp6g3v+WPMqYAaJG0BYSXZfm+vseVYkj?=
 =?us-ascii?Q?N+aYYxvudScJqxaQ2f5Nx5CdiZZucNLzxMrFibgZeEYpVvZuct2R/BufNKD+?=
 =?us-ascii?Q?h8AKKeaQm7vV68QUZGgwhnoV3NpFcy3MzMiiYmTFrXgYqF1Sdnw/c+kxOar6?=
 =?us-ascii?Q?TbJFcR133E2CMwUfz1uaiDrqoFn4Lak/rgbRbGosreDoMyR+awY/WXuBoxfq?=
 =?us-ascii?Q?XoomxbW19mnY96tgJwG+PNkIGvB3cxK9sj4nTQ6oo8KUsQsnRhvmMgIQnZXA?=
 =?us-ascii?Q?KsDfS5lpjpaYkvneZ8QUJJ4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HGSVp/oDHY3tXnd/izF55kOctSPYTyKdfTYASQl9X2iTpaO1y+cvUK/qKNEGH3lfuRHur6Qi5GtBCXRea9GYkH+XduLJRfg3OEP2j+QTIDLJeSEgZcyt8YjJoswkWDD7rQkrrvdgykUpSV3CQscwziIawe4Ys6mQrM5LSLqgC5asK6TNU6YfVknoohy/vi3eM7G4UcgwijCJo/ykFgeqISxZPWkJocJr8UwZkjjSWLsfhYWCVm+gmK7+hif1P5AN19xN7LTXKLmrHJ5Aqh9kn/tI5qksxWF9HtZxe1v3eqV2FX24+Bh4bFWeKeP1UXwqF2YEQU6+V1O5/+xejCvCcpapu3VbefcoOzT3mnB16sqnMcLo+kXv8CcIHfBi3hbm8hAgEGtniK2L7iyPit9YAGhqnODWrORsnNakcVIo9Vk+C9z28Nf2OKs9mwVPnEOCt0HdTzMwrH0fed+J/6UT1BpG02sTVXxn/sdGJfb4YKM1e2y8ValxiLvomV+02UaNC3lvCP5JhQkR3erV/VHxPg+Wi/Gm7YF9CeNnRNexLNuztZNeS9FAOtInuq5h2FRgZD5hpLUH1qy54n1Ql7NW0zhA+K6BQqJi+DIwCBlS6y4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6e1c1d-182f-4b0a-01f1-08dc64afb4c8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 22:41:39.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZGtTP7V0zdBaAqVXyGolrlTSJQkrSY4mHAgNBWulwsKOPg4cQ37XnBP8eovZohToEJguiAc8jMBh9pWXy/2paHf9pLX2SPauD0JZeE/5xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240117
X-Proofpoint-ORIG-GUID: cQymOPPccldDP_VOYWG-r8i9gonro-YA
X-Proofpoint-GUID: cQymOPPccldDP_VOYWG-r8i9gonro-YA

MUL instruction required that src_reg would be a known value (i.e.
src_reg would be a const value). The condition in this case can be
relaxed, since the range computation algorithm used in current code
already supports a proper range computation for any valid range value on
its operands.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f956c0936d0..760193dac85e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13749,12 +13749,8 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_AND:
 	case BPF_XOR:
 	case BPF_OR:
-		return true;
-
-	/* Compute range for the following only if the src_reg is known.
-	 */
 	case BPF_MUL:
-		return src_known;
+		return true;
 
 	/* Shift operators range is only computable if shift dimension operand
 	 * is known. Also, shifts greater than 31 or 63 are undefined. This
-- 
2.39.2


