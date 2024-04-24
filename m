Return-Path: <bpf+bounces-27654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C8C8B0496
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 10:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D97B233D2
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEF3157A58;
	Wed, 24 Apr 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WPpY7ri1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iys8ziW2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE51D52B
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948126; cv=fail; b=N7yxn/HdcDziHfbeFnv7y4kUU/jjESUTHypQwGPEBfyiqRpuh5gUsArkUhGuKKLI7lzbqqofdRLHVWgvyeaSfhXgF6pBb7m0k6JxtkISkWYoSmoBRlHaHBT8jQloTNJQQP6/kpmcCgc35mI9+xO3h36EEnksFgKU8X/N2YRhh44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948126; c=relaxed/simple;
	bh=4IwFQpsHeqyYaMgSoXTFp0rprRB2k50RXBg4rjakUbU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NIWENBaqLGJcnJgM1zqWeJcmmFXQI3z62oz6ibmX4F6p1eovUS+DeLFZ+Z0IwFO5W0lGe+HG2bexYOLGRToRlm09HtzYshAlwJ2Ry4ZwPZvMFPtkxyvXuJhXMpBxRKABnfPUEv/6kVXd9NI509k/geNVvk9SD8i4S44iQFLs6lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WPpY7ri1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iys8ziW2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43O7TwaG018870;
	Wed, 24 Apr 2024 08:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=9bZPz99nBNeYfLBUx5vEPOP72HhjIlAjlehUHVhRneQ=;
 b=WPpY7ri1PUe9MpdXZk5RLLB1Sp9C8Zf72SdQdQ3QGCu+ds+ZtIPsG7YNUVRLB6RERjhr
 gDS5FlBDMglQZTKzATlHqstp99nwnMNWWULk0MCUAW/9O8DOYlGnayOMDa5Y1OxQZlIk
 GmaZQWrCUbeaiTa0YdYmTlW38ToNesF9MA57xG93LEsPCNlyGetiPEp+i9ogPmyD1xNR
 ZuBtoIr/gMjutBjhZ4q6YdIfpELhIb0cCCgeneNAj4McP74IVjYYDw90C6yJm4eUQiXh
 vpfLu7S7IHMYTSGKwFnIIWcitAA/UHRWdhP71JP0qmPLU8BkPOvwgBlktaopM70caoy+ 7A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5rdyjr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 08:41:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43O76Yle019323;
	Wed, 24 Apr 2024 08:41:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf4fj8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 08:41:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBp+5w/x0+LEY1MSA0J3N4WIk16u2PhLeKoAtCD4PRIH1JfaCVObrCm5Elf/4jvMpu9+w/ihlFP+I92FKeyOnmgygInk3HRrfcbddpINUYnReq1hgEoiObXtG5ZU2WkhQx5IOAhEMv/7jG8jt5MNdpj2Qip86SOIF4/b2S111BIFKj1HkVZQ/5FlucvNGZrIcFMGUOoo3KfB2w6L2qdbeGQ2YAG4b8ZtaaBORIgY1O0TEyHt8AJOmYpINWSqk85fcokWterCT65Ek3WDDMI2V3K22vmU1hPrkMSlzQ9zCEC6EMkq9idAPvSydCfaKoNvraJHPWeA9BRLWJD9XapLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bZPz99nBNeYfLBUx5vEPOP72HhjIlAjlehUHVhRneQ=;
 b=lWAhMUHDtMBGPB2c/KjXNtVLObAfdDO47lGr1wa90KVH1UxMzActlirxutJRFOy9hS/pgcUWhgviSwzgXzvIIf9A2fFBiqMUJJtH08cQRTwoD20B3Qrg9KniZRiAjhobs979lLY70/gDw5Bl1g4Zu15KxoNx0Ek8xo3uuZKr5AcjGcGStYYusVqrZmyds90d5UxM4x9F1P1WQzEpt0VungpAFjCmda5KR3o209bS9qsMAA50o1U/xhLOKNt7qJLocJRBeZvttVwiCrqfai0LzUOgyw9K5DeIrYGHNkslEeSnGYszKKwqQ5K5RwrgMAbxi/s9ysKTaGI1DjjnH4LSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bZPz99nBNeYfLBUx5vEPOP72HhjIlAjlehUHVhRneQ=;
 b=iys8ziW2DGcPuiUmoLI1k1GEkCvLUaCKUAOawU+iyCmAYSbbMfPzFtRzJMNrGZzu8bGyHhBeAkK0vCKQ1ryLkbVg1kg5jJCqub1YybPGafEHHq2rhE6yCEiAvf67oQpyNyBhCtObnJvMKsALv0hQxZpQUeRUz6yRVUMckuQXwps=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by DM4PR10MB6839.namprd10.prod.outlook.com (2603:10b6:8:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 08:41:49 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 08:41:48 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in selftests/bpf/Makefile
Date: Wed, 24 Apr 2024 10:41:41 +0200
Message-Id: <20240424084141.31298-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0512.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::19) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|DM4PR10MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e1dfd6-c216-4574-bc9d-08dc643a615f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?CJm/I3MaAFgtka+WJzysa83TJH1RoP+91uRI4TFQc8IfaFdQBAtsfZS5ydzD?=
 =?us-ascii?Q?C8aRIReHr205XDL+R1N3r1AQ5j2MF8FeEYzyprgnzutOScK1r/SHA0EedFd3?=
 =?us-ascii?Q?5alv9qXktPIw0HpOT7jWJlf83IbyE4LMieO/FgOddG8tKo4aG/Llv3Qb+hDu?=
 =?us-ascii?Q?OqF+4RnEqkUkbkL6EegiomB2c0RhgaxvWPsCYEzxEzIeoKE7X/GOVrYyXrox?=
 =?us-ascii?Q?CgUrPrwSw8RpjVvH+tByBzjEM4kxv8rsMOlkKYZoXKtIuIqrEtVrMMSh0MPN?=
 =?us-ascii?Q?2sN9i6nK1trtVXSmORwVBjRjWZWrfrJZbu0ky38CYSHrIqxXdtoPbPwUqrsv?=
 =?us-ascii?Q?CTMrDes0JsgnK1TEDuH3Qgu7yzBWDc0mWYxSqvdEhX8dOPLFhYfCpAqRJdpn?=
 =?us-ascii?Q?wJR/XJTATVKowwzyML1IjRMRbFNgCh1hquNyKrxG/D7pVeAWR69wh7InSqCb?=
 =?us-ascii?Q?8FwXV7M+2p32aJ8PgTuXU4c5EtjIyOVE603YyZMWDfZogXf+d7JtlZhmDRO4?=
 =?us-ascii?Q?FMjl8qddUYDcrLh2ywhTH63PigmFpk4soV2Wju8gHVEwrWRkMiFzFYi4jsAc?=
 =?us-ascii?Q?9AVtJJ71BwuOFEQGkekyxYDTwjchT5GLmNuG2EMkB+xBLPnscU3SmE3T+SH5?=
 =?us-ascii?Q?81yfDSQnLtmzt6KEWY9X/1iYqqbHqQxsErFk/iF9YPHQrztcw/+tRHrtWqgB?=
 =?us-ascii?Q?vC/nmMZ8FMzU18gno2t0TnfaYV1ZF+ciByv6HOM2uK+Bzkz1Jewk58Y3vz8d?=
 =?us-ascii?Q?rW2t6H+XBodybZWdE5STk2W/2t9oSt1E/X4z4oLjHd2Xk8FhJfvCgrv01sF2?=
 =?us-ascii?Q?/iah/jdwYnU5+2EQi9C7Mm0WnW8CQpUhFhDOLMBDMRaGWPzZj1Zi+i2pd7/V?=
 =?us-ascii?Q?r0tmp4Yl27PZUAZuCoXID9A2QNhMz17NBYAHiMISOlyt3Mw/k2hq6oGrNrQJ?=
 =?us-ascii?Q?VfyxAuMeDR7Of3sQi5l3X/3VzEY9Rv6iLPLcTVUaJ4husbUh0G4gMZMNretL?=
 =?us-ascii?Q?IP3wXT2+ehZbOjuRx2Xu8g8lWXmW2H94+LPAZmiPgRmNxb6Kt4i3G6vF8Tff?=
 =?us-ascii?Q?cVEFvrHCyzC+3eYxl4nzs7Mns5ERmRZ20VJaWWZXfIAGGLZBYWXlxE7o6pfH?=
 =?us-ascii?Q?TiqwZPx4cNrgSFaZCl/Fqc1I1sZChbsm6DmrCCaQuIk/i6swE3AhQ76IG2oe?=
 =?us-ascii?Q?aimxUsH9hr6Sl/FOeQV2xAD9sa8bKpWLx4c27E8FbAT7RqZ0Gt1dvvSwMxw0?=
 =?us-ascii?Q?tH95O9xJSFkDv+UFpC54qjlz3xxmAqAbAf9V8XZHQw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lD8Dp4wYmuc/CqZF1rl4vawN1DYDxhYMgDAeXkVN0P+q+dMGKWjkxP3mtorO?=
 =?us-ascii?Q?ThvpaECnLQtD5A/nnDU8I2982le4+0BQVXF7hs+ZHy5ZRu9/kjIhxVeiDCGg?=
 =?us-ascii?Q?wnVJajXUIz+EPcvlvq3O4ezgFJGbMJSMcckB91DGfaw6kdeExAUaSUjQF5gP?=
 =?us-ascii?Q?+gnq1GZ0CbYmcfp/iJ0fDkSyzisopWNV9uNzA5AaTvvGe9tIoLWIlK+J6KTf?=
 =?us-ascii?Q?JmFlVUvSXB0RYBdqQKggW6dWrZySFTk+D+zdmLGdulnKOSRNHL3CUQx79Cit?=
 =?us-ascii?Q?zVOu8m2ut7SAwpcuPVWUzX/9z+c88tBXBTyGeCHmNxK8R2Js41uj2J+O+ZOl?=
 =?us-ascii?Q?Ytkmw5KVOlZFvdfTozwae3OxSzpRBJ2/3yjIuMK3lA50mt6l+lzY/Uqb3DwC?=
 =?us-ascii?Q?Gnkxe5bDX8fLDGDYkowYMc7lBhyT4N6KVfd5KeO7od4r1fJ1glsLJfOJMnBF?=
 =?us-ascii?Q?6yHjs8p1wkpR6jUlO4hFI0343mm1dcNGPCr3gqbQC65O/PqEXn/Q5JIVzrzv?=
 =?us-ascii?Q?rGd7Jc58gdiErh50mulGl17hxYA18ReGi4fQOLAU+NQYd1qDW+JiTwgQ6hVT?=
 =?us-ascii?Q?HpwQkDQhvruFnW+LPKTWjegVen+XMn/KUQHXSXfgX6dpukKnzDh1sYvpRxgV?=
 =?us-ascii?Q?Pv18nmhhy65GAF4rjemoL0wqgoszAmD7LFPPVkwGbLqL8EVud71k/pfGwpa8?=
 =?us-ascii?Q?316tiJZAGL/AAdVz5ynla6nx6KJ6G/ed/+1W9B7bFA2DOoadYXcRYme194ii?=
 =?us-ascii?Q?3RmX8NK1ipIhzKluvUT1dedcv5Gg/Q3gKAS8QXyJVyHUInZ3ZxWVYSAIwQo3?=
 =?us-ascii?Q?WFP33gWKqJsHQlX1Ij3YtEvH/+TmDV+D0gMfHdUasjQEOxM6BLBkDZCQ7KIi?=
 =?us-ascii?Q?cFGsWbynWUA1hC4KlSkLGsFuc4OsoHdC0rcC1yflRwSHpejI8p64PT8+RG6v?=
 =?us-ascii?Q?iL2oIt3Irng2xuX20AV/WlYalTf0mClf+2WkaHBtQK7nmn/NxUa1HGpLkoBt?=
 =?us-ascii?Q?wOZIZMQuMNQFV91EyrH/nrf+JbVzqxkdVmh7y0VwxI837AXrIEWMHssvHCql?=
 =?us-ascii?Q?4hn78oxNDeSUZ6NuXLyhKr/i/wnRGSAi3BL77gYA2YiKqI6YHtA+PPTYOXov?=
 =?us-ascii?Q?CuXbMteqyihL5Z5gKKM2E6+616INwoajj9qhSJATl6kE6BXG86QJJes6fk2J?=
 =?us-ascii?Q?xzC5MoYdoy1lZ53lQTqunp2aKiLeBK9X0zwYXwEk+ws/UMyd/AoPlgr7ixjK?=
 =?us-ascii?Q?LC6N/dEgU962HQ/wmgNxzHGC6wsAD+GJVcO63KEuEs4Tq58G7rA/h8Mq22OB?=
 =?us-ascii?Q?VAGGk4fr2Rt1r3vum/5UGN1eIq8hGiYWUa8+FsKDC+xox6H2+4nb1DAq5CYE?=
 =?us-ascii?Q?AP14HiNYuAFZprG3TlU/VNpXzf7YNt/W9GzCB7LsfIbMzUsxLf9ZQ6Rwl4C+?=
 =?us-ascii?Q?2+zjL6MPofi2IHFX+ndbZmCXYrdf7+UNlj697e9Nu6JjYhFIwandm7KE9b5e?=
 =?us-ascii?Q?JDa5MNdQfWoSHD33ZI7FmzFjtZuTfK+q/Nbb+/zbffzUYDJOs/IlvzTN3CnY?=
 =?us-ascii?Q?MCCCd132x8dhy35xq6Ri+K0nMoin0fgBD5NHvhpvvyKkrBJLkNBMBYBGtESt?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	T93y9ZJaUNGQSe9X6vn20XHWLmtftaGqN0zbAMCePUPzz37k3CS/41lFRpJvniQ1CG+94LSbfhUoB3/WfLEwVcInxDAXd1AaCDuaue0Q53Jp4RzJtJXy/2ZJZ6A8mP1Crm7PVj6kWQAryu5Z+WO6MbeQ4KE6aaBmwsyJx7j6WA94+7i6tFfUvEJSQ0SxYkpsU/kq4qKABw4qONhQ87etFnU49QYD429qxNucJQpMfzuvTQ4CRxARBfBfxzmc1Ov2IdVnZQR9BSLAv6M3jtfMHZu1WfNv4lN0hQcJZPTAqbKte8piqEolQ4U/X2N4vblhDq7yyu4Ed9wmCeldqaXXwc7ajjIoQKVNV2icu9BTVpuen0xp5R/Ab4F7pN1S+Oy20UgqqZHvFVvVCcwJYgnTZFcsgMpnszpo/IXUGlv9cuJFyk24VHoqZ3oVzd+BrCtObKifNN/q6gsWYi7UnXmwEKk8SObam1q/eirExGCWeparOyvutN2z2cColL4kvpKzgAeLeXxsMFinLDyXMk+CD/Xli1pH0anTPw4X3rDSjJIfDD0O8tWcixiQV4K4y8PQwfACTk9g92p8TxMuDoy3KLMHW9totHGQi/gFZ985ac0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e1dfd6-c216-4574-bc9d-08dc643a615f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:41:48.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgMFeztMcR2GOzpc7qVsGn++qo4kOeree187eiaJM1wKgygzPzw35AhoYbDyMRQrocWgGmxBtyZ60X+Z1K/XceQkUbx+bTMCSMkI26qd7A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_06,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240037
X-Proofpoint-ORIG-GUID: 6NSkR3ngNFz6H6FmTew_g8In-75cJ8hy
X-Proofpoint-GUID: 6NSkR3ngNFz6H6FmTew_g8In-75cJ8hy

This little patch modifies selftests/bpf/Makefile so it passes the
following extra options when invoking gcc-bpf:

 -gbtf
   This makes GCC to emit BTF debug info in .BTF and .BTF.ext.

 -mco-re
   This tells GCC to generate CO-RE relocations in .BTF.ext.

 -masm=pseudoc
   This tells GCC to emit BPF assembler using the pseudo-c syntax.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edc73f8f5aef..702428021132 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -442,7 +442,7 @@ endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
 	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
+	$(Q)$(BPF_GCC) $3 -O2 -gbtf -mco-re -masm=pseudoc -c $1 -o $2
 endef
 
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
-- 
2.30.2


