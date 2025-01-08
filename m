Return-Path: <bpf+bounces-48261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02875A06253
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E4C188A26F
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 16:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3E202F95;
	Wed,  8 Jan 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y4suVt03";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TT1kb2nV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AD1FF1DB
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354432; cv=fail; b=NkIikBoDH1vthzZOhO98KmaO/gkSzmcb310PZA4ZggUuMy6j9EjZrV9vwvlAKZN6hdV/FRPZ9YtVJ+zJhe87MdKCrhIeEBt76/J/bOkvLsn7DVhyY4eZIAfYHao2DIJUiGWDJD+TCn/JpSPbdQbLJ+aJJPt06B1BRZCB2g9LKtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354432; c=relaxed/simple;
	bh=HICMB2zJLVC+Ao8+rem5aZpaYP2P3lQpIhI7i09vl9o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YsY7/X+FNP4v2iexGOvC5QMBa47SizkEsCe0AntbVgA2Z6KZH8plEGpnEW45PB4YaKxxBCOzS/R1+oL73MW+vvKVXL9gio9qDUJ+xcRJjaP03cnyAfXLzkDUysOUd8s3a9IvpB8irrvRQ1AzljyKG2h0lSFGr6pOM812bZGDmjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y4suVt03; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TT1kb2nV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508FMirF029001;
	Wed, 8 Jan 2025 16:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2023-11-20; bh=VF7tdliRHjx/wJfg9I7EHN776dlPUnReuSk+hYBngUE=; b=
	Y4suVt03GRQy1Dfuf9vlbbh8EuI7N0B9W1Jii/tnmz5rmy03ZOHITHV7XsuL0Nqg
	MvJ6VwVF5oX/im4II7bttVB56nLHyv8CcN8VwAw75bektbejlBPQg4hE3f6tWKQB
	89Dr2jo5tHmDLFZcm2oaEVCda4nzh97l6dpykcUowUoCJeSfR0hAVDn5EH/YLtVu
	sabIYHpjvgieUHcFcszLKMZv18XCF6d/LaYf1J2vwsIwn1SVmb7RWobHCLWM4qtZ
	14WqsYonKFHcqd4oS/bnDZ0d4ckIqoBYtEfS4tffASQVMuV3hE9DnbXMZWxxwLyp
	Yxf2e0ekpRtD+ABRKBKhgw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xvv96w4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 16:40:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508GK1vE022820;
	Wed, 8 Jan 2025 16:40:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9ysd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 16:40:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boB+V4uCDUkdE+uhB15AYQgnZ+vr4V//pc9Yr4iEwpr0K3bt3tYUUtNvbVDRJVN/vkuEdof3ggQ7x/zpWcuGOh6rDijSOdAIR1F58KYpvlaZyVwVCmk5Z7UwWusVcvEZcOoPty6C6AFoQ1OSOw+dsgY5YIVNhi0NpoUj6p8hUGEjwZ9IXaSqJev6UgCluUQaYa5zE+a2H1YXQe/VdRRmGdlrgd2p8jJwkQy4XsIjTcUyFabJCOXBmgcrnVuhXXl2YZPjDwx8Ic+KcqAJdtXcJD3DVc85z5HO8nVrmPHEG2PTi0Joe3uuBB3KkYMf0CHQgKb+JoHKb8kUMOlTZQqb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF7tdliRHjx/wJfg9I7EHN776dlPUnReuSk+hYBngUE=;
 b=Th6e0qSg7errx2NqFc4ww/Qot7aEgL6SxYyGEcr0oApx0Nzqi0xVoxSF6bZaBqG6J49TWwYhekhy6vF0NRAaGorKjx4Eq6cMFHXcmyZ0SHf4orMvipKP3vL0QibqaXwVFmeWwV9gLE3EzogtoVe5MZedjUxMs9wrrMtiCqzAQkg+qAZT5dr9q3Sr5PVx2b9Qy9DIStnSAgLq5EMs0mNPc4X5PZxp/EUx6bmDk8julQZwoNqh/KMOtkubAvpTiZjuniyS/A2qTKQXB7bj1f7HIeBKOZzMPV+SP2c9osVSKR3T9VlvmMG0vl6aS3MtGsT/ZRckxibd48ugTX9Gsj2gtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF7tdliRHjx/wJfg9I7EHN776dlPUnReuSk+hYBngUE=;
 b=TT1kb2nVVDO0yTw/NGGxTY3djFQZjuJaHRamxXp2GtfIcEI0AsFixP49kyAxwsSIANAMZHasqbm1HLGKxRcjZbxZ/PeVEbFp1eLQ/FXmMptT6INMxiX678vHcNbi1Z4a+KK2zQMV7GiE9kXvQeZhxsN1CtujGO9RjJUPQEoVVN0=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by IA1PR10MB6685.namprd10.prod.outlook.com (2603:10b6:208:41b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 16:40:18 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 16:40:17 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, elena.zannoni@oracle.com
Subject: Compiler support for BPF at LSFMMBPF 2025 - Is there interest?
Date: Wed, 08 Jan 2025 17:40:14 +0100
Message-ID: <87ikqpmf81.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::16) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|IA1PR10MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: df6a84e7-ce88-4eb7-38b2-08dd30032266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ml9c662LAj56ZUw9S2sfc/GwTkCPiRfZSL9Febge3QSsV1UQy8xeU6oicafk?=
 =?us-ascii?Q?NiwPCPQeC5w5vOhVAf4jBJk/JnfAE8bJB1u2lhmkc9jffRz41MGDGyhvuJGV?=
 =?us-ascii?Q?NZj3o2MvchxWS1byl3FLIFwKJxlS6tEQh7s555ElXYjY1+UUGxHX+0g7+dTk?=
 =?us-ascii?Q?9iB9FnmG98PiCIOcfU/7ukv6cFWw+SGTrnZ/xJB14xWBk6YEr/H9eLT90itf?=
 =?us-ascii?Q?l0lCD23dkXDodQ009VzA411K6fKqh90sA9B5R7huMcCb9H+1a/t8pEEqchXg?=
 =?us-ascii?Q?irtB6o37tocP4HHY3pT6VTq75Qp5KjqvXAzmW1NryKaFGbaJQP5n098vdNnm?=
 =?us-ascii?Q?pl64TVVYbN1raGFUpNsV94s75cP91+LYSKROuuymmmQYIsJ4wxa0NBMJfUFL?=
 =?us-ascii?Q?iyImeqpiNHQil/y5MN89o9Rl/qqviUvOZqd5oKr+SQjWxGd8EaFqcY7kfM24?=
 =?us-ascii?Q?pSLFkQtMP8H6hi1Oc9mhh88vOAdJuHE6dEKjo/aspi1Oj3LubPBCPTGSLUJp?=
 =?us-ascii?Q?tpIT3SNCso5cf8YTAt+mjp0rv6j/jtGPp/9QyKXC/cEv51UfGCOOZm0OgSRu?=
 =?us-ascii?Q?T8P2URMUU5+YzMG5PiXwq5vajE1rNR0gG8tK8dSERJX6vOIbsZpqto7rzTGj?=
 =?us-ascii?Q?FE/ptC3tqRNP+K9kZ3eJAxCAM5M+UXts/0PdIQ6T8CyIRFligseGiJ/v3mpe?=
 =?us-ascii?Q?hZ4cA9IL7D2yASZo3J5Wv4W8WtJdvCjH/T6cEANAtE2jrzq+DQUKYNNm3xKp?=
 =?us-ascii?Q?6nyTB9df9slJbHfrBRh4utIT/Q2orUtw7JqmH3A2t7ieMVtRBYDRmIfyKY4d?=
 =?us-ascii?Q?59qpVlhuKe/XwQuOgrkRL14EyXlw+F3D/I6GUTblFrerYgt91s9A1J9zjcYL?=
 =?us-ascii?Q?lGY38z5vQVYsDd6RHQLhGSWg+fT7Q3ZM8KJx38yaP4ebAYRNozmlvn+gRDFO?=
 =?us-ascii?Q?q5pDRJ51zkIyNkTs1jkkfbVWVmcGXFQu253G3J38xheOqv5rCHcVeT0Kj+jo?=
 =?us-ascii?Q?oTvzItCK2n9XZRysLKEfuHxNotvYUFUAU5SqYS/CKXzG22ip/A1k3wS9/Iiu?=
 =?us-ascii?Q?YQipNXWfTp5LRFj8ebLntNA97jQwtjWb4DCHiMXYpExRMhk2FSlGk+QydST9?=
 =?us-ascii?Q?hKEj9rSenyS9x0h06wW2oKdtMtN0fvm/prjGb53XQc31LefSpt8Goj1Es/W+?=
 =?us-ascii?Q?c4F8e8TmZthogoOJ6iA+BoVcGkGIvYuwmicBwvvu0j1IFzeSjr3YlrXwFVOH?=
 =?us-ascii?Q?JgNtoZmj6SCRqlwLHLBqQqeIfPT1zVbdz9KggDdjCnOogvw22eU+gnBpniUQ?=
 =?us-ascii?Q?/KHQ6HMuA7dZvM0w7o7rASWKZeL+ff/6+vuucfAFSi/1ZDKjSOJGYbmCN/99?=
 =?us-ascii?Q?mT4k9kBmkrH18CJsEP9Enf7qCLzP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BdUM5AGsm0js7bpGyNzQHEGvdJ/cwBuZGs7tulUFwKrO7z+iIEM9bSIcgIFb?=
 =?us-ascii?Q?sRfQyShSdPAb+/VjPUiyCggZjnm9X1YsND+qKj2jgBQD+pEWKvKM9MnOib8w?=
 =?us-ascii?Q?mvakUXdxQ1MOPp4K+3KYtd6Ln4ZHNGZ4xpR0sx/+nzKVtVM/+TYRSWdJUQbO?=
 =?us-ascii?Q?8JZJwqW6n2mWBHGKRcex9S0UT2IAxqtaZnXZhSOg48g9pRIa5gL8cVM573CV?=
 =?us-ascii?Q?dch4qPbaIQRoCtcjlmwKrvlKbDROcOd0tTXZ6MpZhGaEOfp63tW+iLVmIcUf?=
 =?us-ascii?Q?7hj5z3O7Rku0WGSMZ+dBUHsA0ct6q675Ux1oedGHgGC8o6QNyXFXDRVPfbN0?=
 =?us-ascii?Q?eTC62w6Dv6HtgmqpiDyvi4sprzl1fV+JehXEcEt6R0lBWTyw4OCnhzmW28tU?=
 =?us-ascii?Q?onIjWV3Ytx3xtkeKEPJHlYtmRuIR3R/HcTYUBc2X8ckZ1P1brUlSPTiXn6+b?=
 =?us-ascii?Q?DTyGiFqWriNWEKKnM9GNgJ2hA1/jG9X1ZwvEA2+el8/qdPINY44QSQbk2Kjm?=
 =?us-ascii?Q?HG729ZlEkhKGPH19NikuLu6v3eG4PiM1+7ki7z9eDQzyCyOaDG0YmDdxk8Vu?=
 =?us-ascii?Q?i+z8Ew0TE5QKGIWtFiIfPX1UvdpPOaPhXnhSTmmcrMubFqE6mC30sB/o0p/V?=
 =?us-ascii?Q?MmC5HTMaRVOmC9DUFBMi8AzMPXXO2LwFs1nO1T+XiIEzmy1VpEDNSx1V8bky?=
 =?us-ascii?Q?36wYOzIWRg+NaQS9YyjMKaVDZzbhpNrMDPU+ptLwp1P7nqHcxKQ+RFPOuN7Y?=
 =?us-ascii?Q?RMozMSo5TXUvmmlzEC3CSuWotDoVeffIRRW0Lni1gRU7NrnrZCtQ7UYKEcDz?=
 =?us-ascii?Q?H/RtSvK3FJfiGUQfL2aZJrw744Xx8bl4Cp+0rdMlxaW2aASCpQSyNcUm77pv?=
 =?us-ascii?Q?FuxH6YpdiiYiMBK6H1E1XoDkpGsIE1UNslQAlhSoyPOG/99I87KjeYaFkLkW?=
 =?us-ascii?Q?5AVVKkoj5h/iDIIN+TM1PXZDBhu3w1XQLSDtV4jzOU6dhNJXDm0Xr/xCIx1w?=
 =?us-ascii?Q?QoYOsakuY/am+vL9ws/v2jEIkZP5LuayG0qyt3LQbYjXPFYwVStWRd+jvQrY?=
 =?us-ascii?Q?jAgKFlD/b+PpRfxfkpXuedmHQsII7Mvqm2fyvJwaIth8BBc3W3fihBn6od8i?=
 =?us-ascii?Q?CpmWRKcqbvvJJnDkOM4mMhGa5mdmMi6Zj8uNqtsQZh/kCleN9G/YVCEWUDJG?=
 =?us-ascii?Q?ocZX3Ugu/eKZewHNotgkLnBJXX85bVok17imceirh1RMy0mTK1tZLrv0b7CL?=
 =?us-ascii?Q?gPKOH2lN9juEvkVeQ4EqZYGz3FbfUvTzU+30c0csWwB1Bf+bOmwf+DkkGbTF?=
 =?us-ascii?Q?XqavoAO6qM2ir4G5TDapZUNI0BcCPDq4qd+/YBIdezQU5wljIkDuLhCORCnG?=
 =?us-ascii?Q?YA1mGOTjiD8if6LC3gRPWqv79lA1eNMjFWJBsYhoyq6OIo/x7IOXyQJsr0O4?=
 =?us-ascii?Q?39RSh8eUdwXk7mquDhzCojbg/A8J9PeppNOpOOIjMmHJl+axbcFoFI1SZO5B?=
 =?us-ascii?Q?pypYtS+pW6RFnaiVT3dPFmegkcNSkqnt3nr8LRWsPIPpuVzDZTM20lyCu7mf?=
 =?us-ascii?Q?aJ2KGoFjJSdxwKW5Dy0DNPiXrL0o+bv0wcs6L976ZpI3pZ2SXn3GSTMko3Nb?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yDK5Oq59ZqXbqscS8u734asK+RX6mVAjWPbLtiRKSf42EkfG2iRYD5hCXYW1ka3prqz/g2oShtVnEk7HzqrsCGfLofF9H5pqP7ELId7VXDY5kcONSiP1zWMsmecGqMoDH7IPEXlOOI9j3VKQgIfGASuaBJVzxARPpBzIx0rCStCIR+HZYxi09nrg1oBfywd2ZmCPHb0dgB+Lxs50xCJMOV1v7MUU9CRIodqk1V6dJOpKeQ0OQb9n3sHodoZUvAJKYhSr56UQE+bpFo+4QlN+pS2MhTdt1DXApoT4+h0GnP8JDnqaF/VKZ2/Xhldpz4R8ixupiwK5taRJyMO2ojWAH05BqFShv/l4M1knVSZPNRSYpWZtdAPwT9sQ+vZWblcVLmTQvopJ1YXH0d19y3Ol9L5w8UbrDOqXsIWwNLx0cVI/yUBTHzfPk3l0GRCt4knNnF0CBzqhtLgCRxezLWF5PW/wbxZSchhPdkVzQOLg32vwfwwheJOkLfATDlqeVM+CV9zOaX6Hq7XbztBKceOEgtQ578l+BjSHqP2/NDwsLqX/FsSpWhUCoaSCoD+fzdtuHBlKBQuibtVGluk0VGUFLQTkFN3XrLjs4qNsCrD7gdk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6a84e7-ce88-4eb7-38b2-08dd30032266
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 16:40:17.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnhX1ME/0U+o+s6yABzF/ER5NfR6gpwbZgrAMs2KYRe66S7FZ8fsjUY7xw/17ikH2F/9dYvvYa0E8bWGma9FqkfEDUkFfhHcDonrjHDY0mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_04,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=737 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080138
X-Proofpoint-GUID: 81C3SEspxXtB4pyBF3A4YwlVJQaY9fip
X-Proofpoint-ORIG-GUID: 81C3SEspxXtB4pyBF3A4YwlVJQaY9fip


Hello people.

The deadline is approaching and we were wondering, should we prepare a
proposal for a discussion around BPF support in both GCC and clang for
LSFMMBPF?  Like in previous years, we could do a recap of the on-going
work and where we stand, and discuss and clarify particular issues.

