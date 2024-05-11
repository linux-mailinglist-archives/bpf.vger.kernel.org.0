Return-Path: <bpf+bounces-29600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573928C33D6
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 23:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54F71F212B5
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 21:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829EF224F6;
	Sat, 11 May 2024 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LLm5c6D4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LQbX+Kpe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468D1CD11
	for <bpf@vger.kernel.org>; Sat, 11 May 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715462647; cv=fail; b=oi7gha0PfF8NoUl5edCY1YUk+ZwQ2MaLoz7I+XhXKInsdifOgTE5RynewTihVclukKELbmfDMzKoGkZe/LaSj/byTP6iJ1WU0vP05Nvk2SK1d3YVkoo0oNO6hAsRop3CTFb4vIvRXcTAPE1ddf+95bxTh1LY29HfnYrG2I/UTvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715462647; c=relaxed/simple;
	bh=6v243wbtbWtpW0H70JT+epDsW5FyA768vclE+sXgCcs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=M8V5GQhyWZ2BF2UW0nAMdhMKDyDgOVBiu7uTaRTAadMhuU6b+mQ5HAgcAWtZ4Oam46YBicTD+VYnyotQT3qb7y7SPf5mNm6xF++315WUIq5wX0D2vzUSEeV6CTQwUtlHoz5nJUSvlFB8BlAECO8IcLRM9qDq/tdhUm4ceNBNWhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LLm5c6D4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LQbX+Kpe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44BL8hJc003715;
	Sat, 11 May 2024 21:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=CyBErrA2bUGDOEKaYPELwNzA1LwtRmJC1oQRbGG1H9M=;
 b=LLm5c6D4wUIC8NOwF0X+y8ehnohVayIUppftOv5hkOciQfYH5ZdZHp1NUsRLzpxc8yur
 i4+aYn3c6zjNYl7a75KMSgr2pqqeDr1T3qGm09XHZvG7X1JgDbkoRN0OXiA6P8gCJztA
 5XFVYitS039IAPSBqC/8T1iZR2bok0BV1/MlaPEs0uJB3hPE8+gWQrYmDJMVTGRF2Ltv
 jptOIlPnC347/xTo1ZGe+jA+MRvtDApCQ6FYasNuwdo0181KVLKlRbTJ6S+VDVC9BPUI
 K4HGaFxJ/AzcPdGnP8EEiecJ6QkzNCrsCEwefxvwLd8hgjcfpbPc7FkDyqu+f9UegXjJ Yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y2gav0059-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 May 2024 21:24:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44BGaPih038861;
	Sat, 11 May 2024 21:23:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4arkdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 May 2024 21:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQco6gbyMk2I+QcPoDPijYEaPKY+EaHU0F3sCFF/heQSS9uyAtAk7uoVkmgyGCHFdC08dagHd/dSEqp4c2AqYaY6L3nzGZ5WPCeJmrei4ZrM4DzYsaDU54pcZp5syK7pkx4J5aRKqf1IwAm7rNRJn/EbdwVegLFBNQzbdavkqPaoZnX3mYoPR5CXKaXLeDnwxCvr6hWUUDjHTFFyMIIZ7HS7tvd55hjvM6DDoraRjw1ul6/2xe1O4beiBBpZEIFp7meuhDlJsQ1L63Hiu9ddrKozD5xCjqdkEoUZbfRFurYIB9ZwwFqp4FlpfHBzx3GGgJ2j+c1KV1kMLZ+ODbelIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyBErrA2bUGDOEKaYPELwNzA1LwtRmJC1oQRbGG1H9M=;
 b=mckZqjP/sPAUXc/tdtzJHeYdQW4+pkM7vYNwEEQhqBWdrpVL3vcfJe6kYvufndiIbsIrAKyeFAA+vSz/yTA8tHZRwsaeDb0iBTOwdIieKJMB+o/xjpZrjsVJyAgXHxIPlnwr35ZUwS2B/iO94Z1cmkbLMlYbJbQSYRSq68h8YzFjJme+fH+H1x0jFCaio/7f9rQ4ykHGCae2lXcVS8IoAhtsKjRgdQJvvhil352u097IbuTUDvDgfaiHcH5CCHooEbRdwuYKGtt0Q9UOOe4pzxaZyzyRmQV0XtWzjEliDRlPrm1k4kjKZxj9WgtqhDlv8lDqJlyz4kbX9VZUxMrgOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyBErrA2bUGDOEKaYPELwNzA1LwtRmJC1oQRbGG1H9M=;
 b=LQbX+Kpe69FDw6XJv/ls17XedLJzu+7THxVcw+2o54y7E9Hzw2cRNMX3D7/WEoFyWgjxGcZxK6tKfP6y3P6gB4imWbdCDPjnlhY49qClx1vaZT7T3qVefZlZnvs1vLz2XKx5dIbbXeuxgoGhRfnjJEbrNz21U2bOQPkqjKC88fU=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH0PR10MB6958.namprd10.prod.outlook.com (2603:10b6:510:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sat, 11 May
 2024 21:23:53 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.049; Sat, 11 May 2024
 21:23:53 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] bpf: ignore expected GCC warning in test_global_func10.c
Date: Sat, 11 May 2024 23:23:49 +0200
Message-Id: <20240511212349.23549-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::27) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH0PR10MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: f7242a52-35a0-43b6-530d-08dc7200a85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BSJVCrgPuYkaGNZ88TkzH/YC4zDO6GP0qyrAYT/5sFCK51TatkO5POgBHseX?=
 =?us-ascii?Q?1wnpp1MngwvUL4330c1E2xxB0IcLsGCxhXKAFY8sNvzpT2Q91NvTjHmswyCm?=
 =?us-ascii?Q?KedkY43XEf6YJM2wj3SiQFb9pYYKlAzaD1hs3j2nxF+8vP2GSHF5qyXr2hNk?=
 =?us-ascii?Q?+frraPzJhklkl+ZlxzcP5cFdprjlQWtRG1D8anpB6gQj8eyBBUIiCyzcsZOD?=
 =?us-ascii?Q?2FiBYcEHl/qmk5cuiCC/sD08pM0Z16cmt9WVZYNt53zFt9UTwbXlqkRGHNqN?=
 =?us-ascii?Q?A/qK7WyRYPPHd3k3aQmruYKu7TDiKopXR3Y1CPb6F7J2fuoHdXzqCRziS+0w?=
 =?us-ascii?Q?kMS1X2mix4u4ibMKiPXTUnL9SHaz6x8djj4tjIA7WMRvj8ndjeHHPlYrmki+?=
 =?us-ascii?Q?lV+Hi6JIIGn+1jznlCYPxaBGaQclzmU2Hbmeto+JYfR2plxc5n+4MhASft13?=
 =?us-ascii?Q?VSQICIDUiqFlfrRvbdNmpsza5vRXo1W7SGWx7yyV6wBgW00Pl8KbmtDNKWeD?=
 =?us-ascii?Q?OLe8Ti7oaCjbLwhqkjq7lDLvY9QyhhXWvVfN457pe+mpCqMECBjYtMtezyXB?=
 =?us-ascii?Q?+qt8t9CcJLiThE2/xcIWALNLtXxG0/j4ZPaW2VJBmHigxWyn/AwOtEBKPVQo?=
 =?us-ascii?Q?KRHMkXlVVYAiJatCeGFdulZzgh/lZTIee89F4ZvPf5VvBK+tkl7qr/lDcwSD?=
 =?us-ascii?Q?NIY9mvURZRixrhQBjI6Hfq1nDgajYmRzd7WS+JCjveSLAHoTFS45rf5Zjfx1?=
 =?us-ascii?Q?+4NehmQlR4n4/EUh7wXfecVtxd0h0G0CQJSWeOwJlF160fi8/S1F7R1Yz8PG?=
 =?us-ascii?Q?yGl6eLwLgcjFpUs39JK+33KQc+q6fvA5lWPJ2VSFiZx9RuKQIGNFdYzkXlNx?=
 =?us-ascii?Q?13JI6nry7oHxloJV2pqYQLPlWIA3jd7g+W9NEgn2jEvC60Toq3ikGv7YnJrw?=
 =?us-ascii?Q?+Y+/PRD7qXwWKXOAZVj0a6X2HF3A3YMYKnIWHJs+8kFzDa7xoFqs0w/7paq3?=
 =?us-ascii?Q?6GS3dMWmW0B+R7+rnk+usdT37Lgzlo8LQ8pmq+SSrqy9+r4/KfbfkpaTa79D?=
 =?us-ascii?Q?1THhS+FdqMMcNr9OfStEFDxIp0b/nWuvc2eTc/n3kaey8euI3RYiWxaV/ZbF?=
 =?us-ascii?Q?vJ3RMytIm4ilwpFEs3KqsBImJf4l2MS00kySih+pphAKFWo2MPlA0oCXtVBZ?=
 =?us-ascii?Q?gE7ee+aSql5GlZ8+51A5yEuO0NfxewQwnhDxAJt6jxeOojPs0pod2Q7qSiBz?=
 =?us-ascii?Q?ByOvqLiaZIfAQ8bV/vURn3vpm3rtLRCCJhGfdYxg+g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0OWtgRCouVSU8d75suozFClr6YxN7oolypiojZ+RqcnpZQws9C9FUbGgfZ7B?=
 =?us-ascii?Q?g2rXUmI853AYZm1rwZ8g/D1vGmpa9diZ5B9jyv0fDFeHftqh1lmzObWn2xL4?=
 =?us-ascii?Q?m4ibkpuY6NpAOqzzxZ50GSiPUN1rlgolhRLrqY3qPZlDQ1sY9OYw1wdgL3Uq?=
 =?us-ascii?Q?Npt2w7ikdcf1ipXw49m/aHac2pS1lvush7l1zo+W7OwONG1XLRpWzNoRedjA?=
 =?us-ascii?Q?yncRG0grY0tNCwmodYG6nV3vV26yV5isFk3UbjwkUwR4tud9nN6TN9gOOukW?=
 =?us-ascii?Q?1lxdvcVePFVIkfxqRim3YNwia5m3oVg6feMc2DwPM2vtKu7F0jCfkUbp6st+?=
 =?us-ascii?Q?OUlgQkHGsWot4JMqtDwenbtfWZTcqBE0e6oYR9/DLdjhK/JusrxS4PcS39Gf?=
 =?us-ascii?Q?YoWnhojsGWbPFXSmXEdBqNtNV2mEGV7BSJe2VEj73/NipvjIU53vAv6vA0FL?=
 =?us-ascii?Q?gXdjuba8E7Ja/EFlVHe5WsljtAOr2Yeop5V04tKGrznHiuFK6uL8Izt2Dh7f?=
 =?us-ascii?Q?+E1GqgVfKyqWkROoDIvxnUEjQ6MjiSu4qJ0b6xHFo26yWMCBHLSau8seC79S?=
 =?us-ascii?Q?JVBV/Ay0LVhcrOM6bSLoaTtonGT5ZwDzcBvKh3FT9kly7CvLvifWBhb1/iIj?=
 =?us-ascii?Q?oDMZ8DkeuJTHDCK1V5UAnc79Eg7u3WqAqeBpxydtpclgo/a3+jk5g0LWRUrB?=
 =?us-ascii?Q?L9n/m7Q57ucsFHk+opuSYSVgMg+mwcrAvvpyFBCczLcqNlTIt1F4aLtMEeU1?=
 =?us-ascii?Q?W49iG2pxTAiQIzktJc6XvRON+F4CWAOuixxISI2p5jgPU5UXW5xj1wwsGYrQ?=
 =?us-ascii?Q?FLbU5S+PXRNDp5i6Dzzp3opFhvLTyJ8RnUX9xDd+qGWr4shAp6r9Y9ejHXyF?=
 =?us-ascii?Q?PWUUhDkQY4qXPSp/+mGXSNQa7pUGGz/Q6IewtSBPlOh0KjX7iAJoHzCiRAky?=
 =?us-ascii?Q?7Evlu25CkGeC/XXBbNtPTgCH+Z35oCjyFx4AJeUDDxzeKagIrXZNDtJ5A6MO?=
 =?us-ascii?Q?o8CU3fsN5qcKD1RBA8ReaLXAuWo/ef/OMUnAYwhNkZvlPTabOKNfNho7MHS0?=
 =?us-ascii?Q?6e9qshpVy2SA1Wbc8Q3ZLzc0T6BSdTwpBQygTtBN+L/K0/PJZmGIV1houJ8/?=
 =?us-ascii?Q?4QhenIX6b+6AunMaUPcViVQRpERf658I/JI8DIuilrjviS3zZE3O0JMOOkSB?=
 =?us-ascii?Q?YOiesr5CChsW9AJ2lG7846hq6lmW313YeHFogMa9bfzLwO3RI6BIVdXXtVsH?=
 =?us-ascii?Q?BT5qFR8vso0lAw+p4u/5zxIWy483IPP46D9dtG4pSDwp3UXK3N3YzcbaeZUH?=
 =?us-ascii?Q?FWMOVfwmWqVSIDKb5uvr0DLXaN9c4zAz4YkgiWeia/YAD6h4jz61le8vKLBS?=
 =?us-ascii?Q?gLbJH6Akp8bAaCvtxIbPbQWNuc/ihRIT7SuaQwtYkOEnVlX1yO5Ht28/iHzz?=
 =?us-ascii?Q?E27VqE1699OmMqap+XV3LDyg2KtYM8ZtpOV4IJeZ3DNMlKhv2kOka0DYFtcp?=
 =?us-ascii?Q?KT/yoANpRew6Gqa/zXouK31XQd+GDch4cQKJtHffPBKIa/OOXUyubfSkBrIo?=
 =?us-ascii?Q?mUtnZ4Xc1uMKyKHzJgSrAUqg8H9Ho8RY5bhqgf50mLYIhxB+ssCKArhBorDk?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	01XnrrUd+jktaTB82S4HUQvuw1sqavi/GrfsGGJ6BPQoipFW7GWKKsy6dzPutPE6St0ACT6o5jy1h9skXkpn+BFNOc/4jP+QsYTqJR00rwedG8Wr3c0wyATCdb6lNos9e3NKQY6fyTRWGi2lhuMCH/jdQqJEFW4e0pFklgGV3yr/eE2ie/IqY0esvhoh2slBw+ynxrM2MDB/1n6GkwPYLaOFWu+0PkWx+5M3v+Dekn37AsDTmroRnIhe/Z3i34/tJ3+VARjfRPTd0c7mNJb5HhLKpP6MSFyYMYjFtXdtUBR0dlyv0WMJtM5gKQwaCAJIVy5xqoJuLA1cYQnEsTYWUBBm67dfXQgS1iSEkyiN4/UQMQNSCMxWTSSZZxRvLluEZTgK5wHSul+6jCHy6c0to25ttIp+RTCiu6OyA27fVoq3cK+dvqcsBd5Jn6Numw0yjvoNXM+ZU8R/tjmp5Wls5IS6JkSFnNR+S2pOV+UaRZgetlJ4+Xte1ci2zLb18S7zPaJ1N9U1K4BPBpRsspCpqeEHvh9Z85zEFr3NfpJpm4atfaqoud5fQ3jR76BqbZ4UFQ7YubKopEjAeZDLF6O8v7kH+ssQ2miTWuPt3nJ327E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7242a52-35a0-43b6-530d-08dc7200a85f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 21:23:53.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 012HL1/613rRuBClFJvwNbN1hN4DO0hVK+4yT19X/hkxLHZL1xrB9JyOQKDyZfadKMtJuCjfYv6/HX2/14akCK29Xp9I2VaZi16VOvdsC/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-11_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405110161
X-Proofpoint-GUID: -9YfNMyL95NXyqTYAYnDHx6Oay0FVdpA
X-Proofpoint-ORIG-GUID: -9YfNMyL95NXyqTYAYnDHx6Oay0FVdpA

The BPF selftest global_func10 in progs/test_global_func10.c contains:

  struct Small {
  	long x;
  };

  struct Big {
  	long x;
  	long y;
  };

  [...]

  __noinline int foo(const struct Big *big)
  {
	if (!big)
		return 0;

	return bpf_get_prandom_u32() < big->y;
  }

  [...]

  SEC("cgroup_skb/ingress")
  __failure __msg("invalid indirect access to stack")
  int global_func10(struct __sk_buff *skb)
  {
	const struct Small small = {.x = skb->len };

	return foo((struct Big *)&small) ? 1 : 0;
  }

GCC emits a "maybe uninitialized" warning for the code above, because
it knows `foo' accesses `big->y'.

Since the purpose of this selftest is to check that the verifier will
fail on this sort of invalid memory access, this patch just silences
the compiler warning.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/test_global_func10.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
index 8fba3f3649e2..5da001ca57a5 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func10.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
@@ -4,6 +4,10 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
+#if !defined(__clang__)
+#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
+#endif
+
 struct Small {
 	long x;
 };
-- 
2.30.2


