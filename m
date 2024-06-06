Return-Path: <bpf+bounces-31499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4038FE7D3
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 15:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70971F2545E
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D2719642D;
	Thu,  6 Jun 2024 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TyLUNY75";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LSVOZAzd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215F193080
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680663; cv=fail; b=lqzxJ/2Ya02NlsNn97ych/pSISFjuLRvodiEdUrT3Ej1dwfKJlDasoHZLZ4gocz9qbevEAWawr6yN+dy9OlXVLx0BUGZSGdAfeva+T2IcW9cj9ppBbWoewxElG/odb84D9NurZ6QIZry/FzS1orH8JvOCB4sPdYm9aRXroeqi2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680663; c=relaxed/simple;
	bh=oMbV2i1vN7UY8zHfulCqS3W5HzCJtDqjBgDZ8dl4U9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=If5is/C+4OO+IojZydvq/dEmdz51XtvU8eXmKDdcSL/BlvWVkJ8vxCPWDZR7W3/yPYiBDKDcAuPRIzuK7w7PJ0RbBB2j1QFFJ35QAih5XfeX8DZ9nyKKvStsxCesyPFpiWi3sNI6wuByFC31wZsr/VnncVhOGL7LwvAD40Bwmx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TyLUNY75; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LSVOZAzd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568i15f032518;
	Thu, 6 Jun 2024 13:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=jpeju0AdgpjcXC49fsm6rjrOTqBHolaDEaVPJENyFcc=;
 b=TyLUNY75Suhj1XrXAyf4zjeVkFwdhNu2yLXWvi34KFObeDdws0K76P0tlST53ITnFxK0
 tPBYlK4Sr+ON97DnHQ+YugkUR55pL/XH4PSpY6EROO9jCYOjOMAIgiL7ZQ6dTPm+8thm
 Jl0TI7/l5IHmcATssqFRBus8/OqsjeeZ7fL1SP5siiee7dkv/aDsezfjG5z4PXsJIj6A
 1pbySwogIhFT8YrwMJwu8w1IAX044YXHbRaT7ZGMNF8882eSLNzyotR22AYCabsi1kfo
 aHfHYhsD3jVlNbaTV5K7DRdD6uuckKIiMRB4iTOqyATvjDu+flYyWgEVZP4awCLM6ob6 kQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbusuj2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 13:30:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456D4flp025144;
	Thu, 6 Jun 2024 13:30:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtbk8su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 13:30:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY3IaCJNKoWP2L4Lf4egVSWZHAyChYyZja/81VTF1uO6nZRFYaHkt0aKcHbO4aA+SfjJhjlDi7t4ptdBIUXre4M7xBNbTC9XDLls9WdxfDLRBx4+VPqqpvt6jVoLYOPHHqAVk8Gvd0wJM4LDEQ0dSN5WrzWobC1TTcBwtUzYHe5SbOgZYS3FwyebFpjOSr1bxWD6jaI+hRzlNm+36eq4nUE7Wes/cfri6RHRJ41+gCJH6V5SBxx/K9apOjjpawYR6+TMXFoCMq2JLA8gBIgEJ9hkDopmikLrkwD0OjsbUUGu0u0RUows0xp1dOgDHlKHGHdMTcrH/+92hFwvKtvXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpeju0AdgpjcXC49fsm6rjrOTqBHolaDEaVPJENyFcc=;
 b=I427A3COXrmKoyW7Pol+yuT9DXtLwTbKr2eI0GiCuDdPSBXz7HUnlFU8OE4FXmPySymcNxvb6iS3XKLz8vzagfePAbfeRqC9UEgkIjHTxnIiJGyrw97/nJhjB/NrkOt6pZPtpHC++uYyawgJzj2g5+eYnKj+YPvnmqd23rJ3hIkndk2UPzhLUaoKX0ef5dyT58Xfqu6JyD2BsI9KlYyi9g4qP2/AEge3vEKfAHCLHb1TE41BIE9kSt1qtLF2p6aV24/X/HBFDfaXtN5m7yuQsMSN9YrfGQxtBi0CywKFdGdlNab1s6xC6J4smtjYOA6bcULG0+jTdGBMfkU1v4Y0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpeju0AdgpjcXC49fsm6rjrOTqBHolaDEaVPJENyFcc=;
 b=LSVOZAzdGakvFMCDj/0ae4W/5LPM+m5j8k5vPMqjN/2lhZJRquIlN0e6XEk45luaCPlPvKuNLFz6qnaIVrr2VbOfEkJy4Z2rj/UhlkYZgNtXf62XB8MtA17XBhBpISMRhWOs6Awnu2WH3A3YJpIRbST0DI9ZjCeL/mkl2+fFJYw=
Received: from BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 13:30:55 +0000
Received: from BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c]) by BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 13:30:55 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Match tests against regular expres
Date: Thu,  6 Jun 2024 14:30:32 +0100
Message-Id: <20240606133032.265403-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240606133032.265403-1-cupertino.miranda@oracle.com>
References: <20240606133032.265403-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:208:14::16) To BY5PR10MB4371.namprd10.prod.outlook.com
 (2603:10b6:a03:210::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4371:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 198337e5-ae30-4860-ac40-08dc862ce488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Y/TsT5UE/1DlCI4LKype1pzBxEX0UmJPiEgUOZdIrxmuN1L0TV1y3pveKN17?=
 =?us-ascii?Q?zpcA0QEEgGgDHKviM15e0tOcyq4rsJENAa1ANT3bMGCfeTnDm3WUVhooK/7w?=
 =?us-ascii?Q?W8jjGDBCHCduyDCD98FesiX69iDugaLe7EvH1iRsoq7jqvEyN8ZeAie1VG1O?=
 =?us-ascii?Q?R90AcMNsFsg0sEVlI48coFFyF8ykHcm294OZuboaycIDwyB/9cXj2xNcZXLy?=
 =?us-ascii?Q?osYChgsPAUEwlY4gUPSMpNnSbjCvrk1QjfKCgPLvcpZC7enjK4YkhZORwy5d?=
 =?us-ascii?Q?WrG3mW4EWpzJlitn9MZ+wUNs3K+sYLvjZoss8tK7C/8R3BnFdw78QhlMTmEP?=
 =?us-ascii?Q?LySCdCQzTMmeP/WVZbSB3CS2iV103hrxYODdOYg0y7bKnZrtPVLZp/IX7dcM?=
 =?us-ascii?Q?AbYjnzIPgtWU7qcxKWrIPpD8caSmkHYBJxDspyW+gHDJ2Klb5Wvngig2GBZp?=
 =?us-ascii?Q?OEdoVR5vDakGybDK3NuttVI5DvoPuZT16/0G4YT5gbXMUMfjiu8xHcNfX+oY?=
 =?us-ascii?Q?FtQlMkp/u6HQ1Q+R3g4JoOszRap2TBCxZ5hAkp2eDevutkwDYykDnmNLnXsR?=
 =?us-ascii?Q?bNZSFbLcZt1NKQw8XojYhBO9LEnDMAcJpQSROIQj225xt0eVyJTtlnYkcTsr?=
 =?us-ascii?Q?pZZQxwNaXisGzx+1WCl/4AouQntwQPzFzoBa+C30SEYzrYAn0GrXCD+p5cAL?=
 =?us-ascii?Q?9zTR0kVEBVnJk09l05YsaAeCeu/djmZV044wOz7weOOVFcHc6VoU3eBghNtc?=
 =?us-ascii?Q?bvkClQFg/Nce9ORAuY4B0DVhYgJWmAY2Q2dm7Gkmyj9NMkMY94Pkxa2hfwqv?=
 =?us-ascii?Q?ZascLAghOvamZurZ0XvGFbDRq1VD3Entso3m6PgM4W8Sz8X3Uq8Xai4FvyZO?=
 =?us-ascii?Q?cPm9PFbGAK6DEFgJ7ENNUfcMv+lDRPET1g4JHtPjRU24yIZ8isR8nx9FyQZ+?=
 =?us-ascii?Q?BLJFdTQA1mJatNfC3ztU5YmG5LCFrqrH5zuWbxSnggBxm3W/E6AVMywNnBIT?=
 =?us-ascii?Q?J2PcCWcRRndYJBrwJuK8kWsK7IynMqR5GgJDQ7xhHBBRc4ApeHugJJsAugrh?=
 =?us-ascii?Q?iwevWrF0nBFszVxLpB1FKI8T+c41Dm59l3gGlTfMU1ztkF4QEIpy7ZC4zn+1?=
 =?us-ascii?Q?THWlvmXSn088ipesb3Q+AYi0/U7p1z8O62Zszi4YFBACaPaKL9LYRaRdrFZB?=
 =?us-ascii?Q?U8cKksDXKIeTJFu7RXodo8F1RS9VE99Jk63UdDn4lIhCaej4YR9GIKS6+E0b?=
 =?us-ascii?Q?IIMwvjwErk3EKQC5+U+LPys8UbKADAkAnaZMm2Gxnb42qOrSVYdq2Vh3uR9i?=
 =?us-ascii?Q?IxnheVzqiudAEOhPmsxYLqCK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4371.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uuZ0WjNqURjeaQkKH30q4e4ofgNm63yyElP+YU/sUKdWLmxP58XupsbFG669?=
 =?us-ascii?Q?GiNGsoWuzxsnF9Q/etO1JBgNdpm391mJWgy02wl6ovjKVkwLn8E/5fVNiOQP?=
 =?us-ascii?Q?tUmUuJopMTtdI4Tnl8kLfHlIkDdNSEVYvywMYPOZ1L7bydTfRzPAHWaNyRPo?=
 =?us-ascii?Q?pGtNo8TMHRJAuqPDl1wHUuRG+BgmKhlYc6CMm9+UqOINRyPrgE6wv5iK+YZT?=
 =?us-ascii?Q?zZf55GZ5YS1DJJC/pyhdCu2QV73VTsB3lNZ6CaNJjJyckfNualAHS0CVvYqh?=
 =?us-ascii?Q?byIn98dVghUCFhdtuS2CLdZr3DEeErEJTdWXED+bE48L2EyCdPFSkaQuWs8w?=
 =?us-ascii?Q?EbFomf9ls5Q4HBvgIFecmgmoEQRryDvsycw0OkSwlqphhYas7hpS/FloIL9e?=
 =?us-ascii?Q?PA0UO1t9dXGaTDLf3YeDzUDR136BUZkUR0m4g4pX7gT8rlkAgiy+YRBxz0wk?=
 =?us-ascii?Q?BWOM924ur8uWbBVIMCZfdpuOlWAMLGy0Onf/rXCdhJNIBUzHWqkRYOdO0ik+?=
 =?us-ascii?Q?33dbZJA04I5F3Gyd+gH3wPXraxL4Y09fd8gE++/uy1kSP624oQ+wbpza+Cdn?=
 =?us-ascii?Q?dOwc1sLigbf6O7uiR3Rm+fl30v77ej6u8Byzbl1WbMYIE8R7m8mqjLklo3MI?=
 =?us-ascii?Q?YTXQT9IfKHPoKrVjhXZ093MY/LZpiqiXvWDIFKrg9K8odUrSzssCOnbmavTk?=
 =?us-ascii?Q?FiQHSW+daTujN9xVgmXvrLqbinPVKvCLLkfJZoo4193E+U8igE26lunwjRKL?=
 =?us-ascii?Q?SqmNByfUjIcLgYw5f8iiRcQoOq5HJtEdw5w2HAflOgaxk3GJoGIRTBCiLxy6?=
 =?us-ascii?Q?4pFik5wy9aHhfoSniq+TkZcV1CM9kzYhQEwbzDbyjaiCH61WeJzFz78NEcaM?=
 =?us-ascii?Q?J+N0QVn/JNRm3HUXMhGXD+Pq31hCD+BSflWXedIeQOqEkD+/Fbz6jDqXcXxL?=
 =?us-ascii?Q?h6ZthGMsvpQbxujh7HKkZvIgxlfX7f6vfKSG5VcJpNTlebauMXZd2U4WETSx?=
 =?us-ascii?Q?RoaFGcbFJoA3EEYT552KfXLPs6+QiM9t5qIMX+51AaVtOK3flRi0BuAOGXz/?=
 =?us-ascii?Q?ym1kyT18RMMKh9db7MI2a48Q9embVobMs+3EUktp170GllUMXJLbqK90Kgph?=
 =?us-ascii?Q?PSyRLWO2i/ZEMbpNV4oTuTggQcjWk8BXsiQDGP0aPwzKb+dQhOTd0df7kU+M?=
 =?us-ascii?Q?WhgceJaySj5lBM0g6+aR/ImtvZhfRzeF6EVJ2AKJmM24+3m96hGqHvXwrAob?=
 =?us-ascii?Q?3I7CdmM/+fwlVHm5xrBvJOHLwKAYIn/vGI5h6bSHPd3qBtfW8iSm25UY0SHe?=
 =?us-ascii?Q?n+jU2IVWB81jtgD3tsCE18IjwDjaRdJmEsvbkhnQ5tqZEhq2WCFN0IUh80xc?=
 =?us-ascii?Q?ARzbIy4PhDvLPT40uDyTVGP6YDRBjNPjxT4Sz1EI5uWEWzWwmm0H3b7+NDO9?=
 =?us-ascii?Q?bymceEQdQJQVkS3S4NFh3bH+XI68E431gU5lBfG/wX7klY7C4oePOovGjPg0?=
 =?us-ascii?Q?q7Utb6eP7U7cruK0igNssQhZHdPUSQa83CNhATcWBoTXuk14qPwhkq5n3o64?=
 =?us-ascii?Q?HnxDq8huyMueFD8n/E+5gHlbFJIQ4xo2gJTCu0H+1hGnbwAHgyrdVx5VPswz?=
 =?us-ascii?Q?BLJwlCH77gjLDoLqnK17n/Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pb8AiWQGJsszqlr3g17t68ecUq3us8r5e3a9U4Cf6MpKk+QlPactuikuHy9gqNdloH+xe+/vqoBLY0DbWkGCh+mwD6ZNlUkwqa/iE/T4FYTXdVtd6N+Cep7euUNJqaELxZmLL3ehBUt/A9sHJwdv/Kge95FU7ig7JtTeRFR87EoFgEJvno6EjQ0ibhJHjTcbMrmdnJfqDSUyqVoswHUPY88QhD6fTibuGJTw3ldQSQkpYgsF1Mat3vP371BjBmAqbOyvWCwZ5bFuzR0aBT8UctEDNqC32MznPCcI+hWWIK8R9ddPKAYzg2TS9pHq2ghXJllKFj2XSt6rMRYHMxoWTr6y5R4s+XeAshSrW6VmLFeQTR/WayVicJW+bMOpuMKINs9PMaAspqQgzwwRYAoPnypP/eRVGGBkXc6L9OUkTfRSMS3aqAM2KOkTwVqgPABilq0UhBpqZqnaIzX498deT64SXkPKvl0sOG6FZtK3by3QI1ei9HgVAh90/TlOr/8sGVL8LsuzwgS4Dfm8xTpuIfZ66MHOtkkHLfDsmZmIptAU+9DQBKbplSLPZ/jK2ArTCmdOq3YNfH8PAmf7C2XqLNWtOg5RhQqShsVipvVfIsA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198337e5-ae30-4860-ac40-08dc862ce488
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4371.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 13:30:55.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmkB0+CTYQOh+zqSqn02rHeOs81hLdTEYYeLeRdRhUm4QxaoM+dsznS2rIlWoe8Q6cApKnfM1C7fTe1Jl+g4MW8M8+oVp6qdVa0uZWzVSoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060097
X-Proofpoint-ORIG-GUID: RxbzC6qQ_u9bETsgoAvKjorc2Zreuzy3
X-Proofpoint-GUID: RxbzC6qQ_u9bETsgoAvKjorc2Zreuzy3

This patch changes a few tests to make use of reg
would otherwise fail when compiled with GCC.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/progs/dynptr_fail.c          | 6 +++---
 tools/testing/selftests/bpf/progs/rbtree_fail.c          | 8 ++++----
 tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c | 4 ++--
 tools/testing/selftests/bpf/progs/verifier_sock.c        | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 66a60bfb5867..64cc9d936a13 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -964,7 +964,7 @@ int dynptr_invalidate_slice_reinit(void *ctx)
  * mem_or_null pointers.
  */
 SEC("?raw_tp")
-__failure __msg("R1 type=scalar expected=percpu_ptr_")
+__failure __regex("R[0-9]+ type=scalar expected=percpu_ptr_")
 int dynptr_invalidate_slice_or_null(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -982,7 +982,7 @@ int dynptr_invalidate_slice_or_null(void *ctx)
 
 /* Destruction of dynptr should also any slices obtained from it */
 SEC("?raw_tp")
-__failure __msg("R7 invalid mem access 'scalar'")
+__failure __regex("R[0-9]+ invalid mem access 'scalar'")
 int dynptr_invalidate_slice_failure(void *ctx)
 {
 	struct bpf_dynptr ptr1;
@@ -1069,7 +1069,7 @@ int dynptr_read_into_slot(void *ctx)
 
 /* bpf_dynptr_slice()s are read-only and cannot be written to */
 SEC("?tc")
-__failure __msg("R0 cannot write into rdonly_mem")
+__failure __regex("R[0-9]+ cannot write into rdonly_mem")
 int skb_invalid_slice_write(struct __sk_buff *skb)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index 3fecf1c6dfe5..8399304eca72 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -29,7 +29,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 }
 
 SEC("?tc")
-__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
+__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
 long rbtree_api_nolock_add(void *ctx)
 {
 	struct node_data *n;
@@ -43,7 +43,7 @@ long rbtree_api_nolock_add(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
+__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
 long rbtree_api_nolock_remove(void *ctx)
 {
 	struct node_data *n;
@@ -61,7 +61,7 @@ long rbtree_api_nolock_remove(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
+__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
 long rbtree_api_nolock_first(void *ctx)
 {
 	bpf_rbtree_first(&groot);
@@ -105,7 +105,7 @@ long rbtree_api_remove_unadded_node(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=3 alloc_insn=10")
+__failure __regex("Unreleased reference id=3 alloc_insn=[0-9]+")
 long rbtree_api_remove_no_drop(void *ctx)
 {
 	struct bpf_rb_node *res;
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 1553b9c16aa7..f8d4b7cfcd68 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -32,7 +32,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=4 alloc_insn=21")
+__failure __regex("Unreleased reference id=4 alloc_insn=[0-9]+")
 long rbtree_refcounted_node_ref_escapes(void *ctx)
 {
 	struct node_acquire *n, *m;
@@ -73,7 +73,7 @@ long refcount_acquire_maybe_null(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=3 alloc_insn=9")
+__failure __regex("Unreleased reference id=3 alloc_insn=[0-9]+")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
 {
 	struct node_acquire *n, *m;
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index ee76b51005ab..450b57933c79 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -799,7 +799,7 @@ l0_%=:	r0 = *(u32*)(r0 + %[bpf_xdp_sock_queue_id]);	\
 
 SEC("sk_skb")
 __description("bpf_map_lookup_elem(sockmap, &key)")
-__failure __msg("Unreleased reference id=2 alloc_insn=6")
+__failure __regex("Unreleased reference id=2 alloc_insn=[0-9]+")
 __naked void map_lookup_elem_sockmap_key(void)
 {
 	asm volatile ("					\
@@ -819,7 +819,7 @@ __naked void map_lookup_elem_sockmap_key(void)
 
 SEC("sk_skb")
 __description("bpf_map_lookup_elem(sockhash, &key)")
-__failure __msg("Unreleased reference id=2 alloc_insn=6")
+__failure __regex("Unreleased reference id=2 alloc_insn=[0-9]+")
 __naked void map_lookup_elem_sockhash_key(void)
 {
 	asm volatile ("					\
-- 
2.39.2


