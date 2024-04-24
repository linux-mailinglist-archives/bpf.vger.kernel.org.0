Return-Path: <bpf+bounces-27750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88728B1649
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A5B1C21FD8
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED32A16DECA;
	Wed, 24 Apr 2024 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xkx91byv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dNtUppL+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81F23BE
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998481; cv=fail; b=BvMMWpVkBNVfmbxDT1Nds8B2BA8tyIot20xIyzItfs6ficWpZRpkxkYHnaxBZJdQybtwQc0u3a6HLMjPon5fbrjpLvbw/ujLxQvdqokCsfxDPC1Vq4anGsY8OOzgzG7DyuM92TR/7Qz2tWtqccN2LThT5KeN1RkE3RDoiIbgmWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998481; c=relaxed/simple;
	bh=ER7aZEPLjaFkRya9nqvIMRQrY5JEhm8Tltsc0j6taJc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tSnwq0IVQc+vPP+ufAqjgJWSvDDVkDGHYkKJPyeDHRozhSIssCGpetVofVZdKfIf9uQDLTc2UqzdPLIcgm43cO3YHxJcSnJNIhimAbG2aq1jb32K4BmSLIKMwejotPOLqlVSYESCMPDJV+CyyVEhIWkOXfF/Ae5Qy5iZJcPKEbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xkx91byv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dNtUppL+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFuJcv018860
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=utzPJajzMAN2HuFED4Jg5oZJSXpGIg/itORN85w0C+A=;
 b=Xkx91byv7Bn+IwVxF3CGjv2eFWUyBkNbdMu3a91J6zEO+FgMshpTzNiGIxIXkyiKERKm
 5nNwL7TdVBeCiV0gcmMCJKlJbbCxIAhRRihEVJbKT//5+8r2QDbbqpQiCk1IJnlQ/SXM
 TmBJ5PRbPUfJym4w0rADV9zbtaWJzc+h8LPWDuceKFZ9Xhw0Q3/ONZtVpxL+TVgpQQd1
 NTl8fpg6KV1DKdhiPiQXHkHUblLuV/MKDzlUjxK20qEZ7xYQ268O38Yv8rRouVoioy2V
 pIjhDkJ2HK6HRcLEEfEOc0QVvHTZcn01AtOR0sutSrIj2oTgdMTfS4103chYkpbauni5 qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5re1d4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:41:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OLC1NL030968
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:41:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm459h211-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCxvOyUKKTfbfd+Ugc+u8Qtvu8iZwlZPW7hCoN530wWyjj7qkPQSGPUEdr4zf2F9pYf995ZJkFObu1Vq7ZWepGgbhqhfiOeVA72IIoYApy5lXkyaSC10vsfFkTxAcoD1uUAkvEfJ6oKbj04gPr3l8gd5W6Dy3fHK/NMNYaceCDNx9MWuVJd1Yyyk+X/7CF635Ha1YUUhAx9lZLg/lSmo4tswZoBVr8HXK5dz0OzI21t4jH/ubCltlXfxDi9q7U6qdxxdJDIPctQ4WnaVCTCGvwbnVSko9gJQF67PT0L9vXV334ekb3qgCHO8qhArQveNFCFZqkljv8kKLJr6mPf0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utzPJajzMAN2HuFED4Jg5oZJSXpGIg/itORN85w0C+A=;
 b=dFNK6/KUR8hb2AkHHupl8hDWJQ5LbiaaDTL6YxtmPzjTfZnNBL1Y9BT2NFlWeLsEiPoYEF7Ga+vRYoeYpl9k/e49NTUAKS0HpO6SUQJgyl7R8Fznx2I1OFMHqZ53MDKq2iHqK20Gt7XHsMGHnm9eAK+ap+J2LG6fphwGLi12dXE7Sc1CZQlikAWn8frL5E//vYVzGxQv0/8QG2Alk/BBdeUJb2PXyf413nbVmQUXIB8HzHlrGwnaA535yrMNo+F+XNF9eMrtvx/s27Q67kWC3JvN2+GWCkuLXB/Zw+YNJwXr4jWKIU0857kR6fVFCPIW/HKnbr4WLrtM+F9zmuN2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utzPJajzMAN2HuFED4Jg5oZJSXpGIg/itORN85w0C+A=;
 b=dNtUppL+iTw1dmli1VHsVTiWuuq+pC8aXcf9Z573lGNtvEc1RrUNBDC6J91NBT6XoGlh9ax2361QVRCjzAHdti9C5xy9HYuMRHxdGP3gC4mbFzyIivTSAyP0XnWipWnfAAvWmN71imeFbYMIGS9d9XHuoUf9k56uxnBi4TSp58A=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6792.namprd10.prod.outlook.com (2603:10b6:8:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 22:41:15 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 22:41:15 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next v3 0/6] bpf/verifier: range computation improvements
Date: Wed, 24 Apr 2024 23:40:47 +0100
Message-Id: <20240424224053.471771-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::20) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: cc92a552-86f9-491c-6285-08dc64afa610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IfCGeFss671B5YuytSwNfHPL8FW5MxMAJ9aAXVt2AR0lLRI+DfICHconnIHX?=
 =?us-ascii?Q?zc6ptBNmVMqMAnI/jPnNs6LFHz8Ik2NiVbIe7CTUcAi3nOaYgse/jLhkZ/3r?=
 =?us-ascii?Q?7YQ9pqaK3r7h40mafqr6lmqBpU00cYfr00BwIva7k/9gC0kkZFtGKLhHfG3D?=
 =?us-ascii?Q?1xqB/SME4Vayq4VQH9I1zkTtYCRYGWn8zFGdknPmdZy2K2v16ezgxolLTj/n?=
 =?us-ascii?Q?YjHSKvGq9ejc9oTOd9gXCm6JOzxyfXH7UFKuG1ozoTCmZD8I7cDmaBltUG08?=
 =?us-ascii?Q?qMbFsWWx/G049LnpN4oDZd+CWFMai3CjFcSHOfGTaN0FOqCSiBoo0NG84Sld?=
 =?us-ascii?Q?gUlqPU11R9ejYiJQ+hxYT2UN4/+nhMtyRkkOPDc0a2VrVKmuAtqFcp2PCZ88?=
 =?us-ascii?Q?OBR8hq1WxPmjufrDcRQZ8Cnwdjq6e3n2yoblVO0mynPvVO1oizZNSwbo2jZZ?=
 =?us-ascii?Q?7eTYAwDqzzxM3lY1fpYunLNXmgpvhmgSDKmBLGcMBAtxDALOmDg1f7Cqlxuy?=
 =?us-ascii?Q?OPQCP8gy3sY96NFM3yfDXjgWEkP//ViwLeaIQMuSw8+nZkTSAddLKfaC9xyg?=
 =?us-ascii?Q?QjV0NoqOgj8+4v2l0hh5RC/io+gVTyE1cKRIvalINZ16IWjHwUiQPs5Jy2N0?=
 =?us-ascii?Q?+IQ2+gpby9F5tsyEUzk+IRjeFjO1mS5Fo8Xge1ZkWJAO7I6AY2RaQGZ4MPS8?=
 =?us-ascii?Q?lf60iCccnMgFWUz9gGc3jkbTugtg1p/aeOTZgsAXeFcPuQC+DFZeL+JY8UMO?=
 =?us-ascii?Q?qDF7w4leoO2Gmwkt1WCiwXVBAcamWosEkXBeFWlPjpk2BoCKC8XNm7n9PStJ?=
 =?us-ascii?Q?rj7Fd8Mj6fR472B1/dtriMgbYitV7cUAoJnDRns20KmMSNOa16sMMwW8RBbR?=
 =?us-ascii?Q?mjVLfqCMsouw6Rnx2FrpQ3Ukj6kB0nRzBOLq5LWnOM7W0FFpTjs6XyB5H98F?=
 =?us-ascii?Q?FkNeQ+GSJHceMLl2EFwHqXbH4ZmsfTRAQmK9kOi6IiYYyTizXP42HW7rhEYM?=
 =?us-ascii?Q?dNNIbAaW5N+H5LlB93iL8z8E27xiHwRDETM6/WZvkaR6PMPjtQ9Ms5NITFVO?=
 =?us-ascii?Q?InJxjA7rdFwUXrlHytml+S1EP4rjLo5QpzTKneN8+1iu/k7V3Q1p/uZSwlDM?=
 =?us-ascii?Q?BFeSY0V+CUqJDNyVpyBP4DonEy2TFYgrPQTETrmKAmhwbEftjV5F56rXFKyQ?=
 =?us-ascii?Q?HIT6LaqtharTRR6qY7SJ6vW0pauQUmsP08J4cZLGzlEgCw4PRKoGtAh1ti+s?=
 =?us-ascii?Q?5ytwSZ4jPhd9s/RrdISSpNoXo9Q7wnJXynnGPj2gMw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mcgX9vWDEaQFFLlP0iVQDjV02zNJD67xFsvYkQsbOQWxAeTEHeT2StKlIHxe?=
 =?us-ascii?Q?DALY36Xb2DDKCWSbHrdDx+oSZ6/Ohe7l3E0vj8uZpZUYivH7FsQ2PL4e/0dr?=
 =?us-ascii?Q?EoVUpLJmJEyx6GEghx2UY8gvu7881/nFCflQ5bkWpHPGXuvtyGQZ/aNqd8FU?=
 =?us-ascii?Q?XvNzoQIM4NWw4EnFt2UNYPokI9tChPUkHVcJ6x6L0vmpxp551RJqeb1KxFP3?=
 =?us-ascii?Q?W+5d79JcPheXOdkfRNx+eYP5e4hmYqO+vu+ojeOAxIf6sa6W0fxzbxJYcO4d?=
 =?us-ascii?Q?BU79w438F5NtTw7FCyUv+YzOODqf/7GoH8k/8pWyL7NzxQabqlWm/heQdUTS?=
 =?us-ascii?Q?j6zB9yoNsGudaxfw8e5dHFGkMSN9qNxj+XbeApcKZpoq7FELweju+uR4yW9n?=
 =?us-ascii?Q?9D7p43aZ09FwJabmILvv1xd2Ac45SXyBXOWANRNGBs6sBdjmgyfJ7CHcefyI?=
 =?us-ascii?Q?7J2Zi3GC3dbv5TNd+0TQyVd95m0jO/gwyVSxhV6iVVseml4lK4dq38esjyb1?=
 =?us-ascii?Q?1uFS00oJSmbCsanFB/YJvx9nsL4ugolL33zVHy15rrWBoFDEDfBw4iECFFQU?=
 =?us-ascii?Q?acjMwZEoXhyqzjgkLTJ88T/9JHWfyHw2EwLZmBHHBasGVkKmeAKEotKJZkxc?=
 =?us-ascii?Q?hv5iM9GRLE4JS6NWX82wxfgmErhjazGifyIDJDqxaBgDDIMjT2RlzddUZy7C?=
 =?us-ascii?Q?3UOTruU4ocn4bPgtAJAADdMNB7zKXTGauxpY8Phg2MaglTTGcrN7D2mGC3yw?=
 =?us-ascii?Q?mRM4ztPikdXqd0tZQyFy4te9ZXkkQIiOJGLm/bagkMaZ2IH1AO1Okbzt63Ho?=
 =?us-ascii?Q?2fR45WP0kJrMGrXJH+iG7gr9Zn3PC71cOwk7O5bXVoGNz2R9FnwDPG1MIosu?=
 =?us-ascii?Q?y0+5EGfkkBB11aF40i8hTavjPkf8MHFbMp+ZavZ3zo4XVWwBN4HSvQ1JqVjC?=
 =?us-ascii?Q?+/o0EOAENW1kF/VDUTnpvD1KAOY7DX7H/YYHZGFKSqyVoSMI/5y1In3YyBlN?=
 =?us-ascii?Q?KkYicSsBWgFXs3mgETWuO8868IDRFmeoHXF/N7f4SAu0NB8cxVBQoeHX/6K9?=
 =?us-ascii?Q?sVnuwg+a+oft6mavN29ttqPGPY4sk1hkQk1fRnXTdJ6KYU1h0Bw/LRS0/1co?=
 =?us-ascii?Q?S81e9bYc2/B1c1GYQ8zkjr9Ta90P9sTG0aw5CcEGixMmwHFLy4YvrZJithFb?=
 =?us-ascii?Q?gPK38kl2yJjqhv/sPCOttkJXMOyQCX9fKfGB8WyL5LKelogjyQjtR0XRdgve?=
 =?us-ascii?Q?xU86/Ecl84LzGxSILOhc/PUQqt1jq4wovLv4oL7cj7TctBMBSRuhAp2/daxN?=
 =?us-ascii?Q?0No/xrv+59I1M/cQXXjwoitUE0zSLT90FRkjhepmzuuDrSKLcPFpz4gitrZP?=
 =?us-ascii?Q?1PajcAR3cyV4Wuq/rz30wtvMjBmuGT6Z9tOc2HQ0ijtc2lsfTONlcncGIoru?=
 =?us-ascii?Q?t2XRLcFrD1AuvUK1kAlp1uvgIP7iv7SYuroBE6j6F3l/U0I0qrtn5auOw0zx?=
 =?us-ascii?Q?Jj7jVi/oRKEYj8RxxZPfzUuqYZGFEZF5Ct83miqI7kINTqvNwi8xno1KfDI8?=
 =?us-ascii?Q?jmTYuXL2Tj59TycVz9Q26MvGdYvoZrzB6kzDLjiWsI/J8ndWXS0RwymSfw34?=
 =?us-ascii?Q?P356TYCESf5196D5wlgeP9Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	48QP5pe9zFdNzKeiVOWTBLJwGgraYXOgNZbUZ9sJgzyfNYYuHzDAI3aTN5VgA3uiV18NXhreWHIhUDaR5P4LnEAwT6GxgpCL3P9l4KNM39U+5R1cUhmk3svCAViEKdZs+WyayCJqP0FO5aSOCZ37NS0zRe0nxwSvzZoBd+uYRyKGYrCoiR4NxDdFTkKrKeywOcDxfdB52jgczneBabgVhTDHswz98UkKDb4NHsayR5oE85JtvsIbjMCGFEmCdSeptE0Ng8FRVhzr4nJ6sW+cjWfoCvzppiYtpHcpSY6Ji90UksDSdteFveGTfkCNUUNZFeoWd20YFuJygxmXxjfLbLWfpATpiC1MxwNueKlzogXI5Uy/hFogdH5e+RZmOHnK2hjuQ3hoa2tpUeB3cWDsgA2n8lzchN3I7tOQ1TveD1I+XJ67H7yIoAGS5dnpILK8HDRC9+LjBZ9IZthjXmXIY/xO9xQuOyGU3kMxsRRfPC0jw9KLe2DoTheaNLamTAuXK0esKRQMubcKGi+V9bneIPp4FT5F6sphfJiZaIQ+MwUBoe3QamPc1w9FFTUXIlftsHwYpAOpnHTY8jXpYX7tq1oHmdIZ6s4tt3HT/iJDwQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc92a552-86f9-491c-6285-08dc64afa610
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 22:41:15.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7vnkI58n4xas7xdl01tE15+9xrtrXQXL6ZYT4iNTlGQAIPAAtSChyxXvxo0QjVfqLrf0T/z+xmxKG0oIsTyrtV1/19OeNbjEXBViR61bjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240117
X-Proofpoint-ORIG-GUID: LOJmi4Cax2VijO4JoEnlygehDC4Fxof7
X-Proofpoint-GUID: LOJmi4Cax2VijO4JoEnlygehDC4Fxof7

Hi everyone,

This is the third series of these patches.
Thank you Eduard and Yonghong for your reviews.

Regards,
Cupertino

Changes from v1:
 - Reordered patches in the series.
 - Fix refactor to be acurate with original code.
 - Fixed other mentioned small problems.

Changes from v2:
 - Added a patch to replace mark_reg_unknowon for __mark_reg_unknown in
   the context of range computation.
 - Reverted implementation of refactor to v1 which used a simpler
   boolean return value in check function.
 - Further relaxed MUL to allow it to still compute a range when neither
   of its registers is a known value.
 - Simplified tests based on Eduards example.
 - Added messages in selftest commits.

Cupertino Miranda (6):
  bpf/verifier: replace calls to mark_reg_unknown.
  bpf/verifier: refactor checks for range computation
  bpf/verifier: improve XOR and OR range computation
  selftests/bpf: XOR and OR range computation tests.
  bpf/verifier: relax MUL range computation check
  selftests/bpf: MUL range computation tests.

 kernel/bpf/verifier.c                         | 139 ++++++++++--------
 .../selftests/bpf/progs/verifier_bounds.c     |  63 ++++++++
 2 files changed, 137 insertions(+), 65 deletions(-)

-- 
2.39.2


