Return-Path: <bpf+bounces-27754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD218B164C
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2F1C214F9
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD316E86B;
	Wed, 24 Apr 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gSsJbSvR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C34Ec5Ea"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D4416E86E
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998501; cv=fail; b=LMQHGzGYG+Iwa94rZi8k+X2lKHClKKssJ8XkN/gaMUwL9Vr3tBfqAO7BF+Ve7Ic4GSwz/SS6797eR5ncvV3hH1POm+N9Tz7XyIwkWbpPs+zj/wCMRlLMBAiDtCJblSgAj+h00fzqk6h6joIaKpSSo1tq/++KBncKYJtKB4jVDyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998501; c=relaxed/simple;
	bh=9s7O323QzJDfqLZ4aW10OmXhhCjqs85hcdbKk0ZR0NU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XB2lAelromfjomtwRXOBH5R6sLPWyX75LBodRMpOeog2aLgiQE7WHQQBQzF/83zBItPCDeqQ4QeSL9BVat6XojTWID/XVClp5mi3EC4hkZumec8oiA7YomU4NW4VxBvb9pMKXCjwYzqasjuYG+gXFJHaF8x3l8ekkWeGeQJ9Nqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gSsJbSvR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C34Ec5Ea; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OKNLau018981;
	Wed, 24 Apr 2024 22:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=n5aIVRiKhBvS3q7pC7kEAm7ygbmYoSXORWJQJBpLWho=;
 b=gSsJbSvRCXolBXkYw6b1jU435aKanH5B1JdYki8sLa97jbrOu/him9h4f0HTELMSlV3T
 ELZWwnC4YetYwcnlWHT5uTupg2v8HhvZSuOHRk2sTIPBqMoEIPY016J4qWjrQS08gPhz
 R4ktLuIZTrpndtMYt6Ze9uApTsP+52njpbMYqA8B15AkIEEMidd6btn4SbVvPu5s4lHD
 ucoH3VhjZax1KBOoYauxVlmDdq3Iq9h4o+s18Zv0Kt+/pDJzXAipO+yVvSwrzATd9oQ7
 3NdSXcSzg9/Ri7t46iW8NEBnrPj766gJvLj3eqYjfUSS1kc9YikTOn9AHv6vHEQ3XdrD KA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44f17r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OL3Yr0025314;
	Wed, 24 Apr 2024 22:41:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45ft0rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP3tsLuXgTjrJSJYu55wGPaB0XJzFIMS7yEE190Q55JkSyVczaBtfAC3ug/QHKQu8QYTaaOHAaAofQEK+oZqMzQdwW81S5I59xgzRE7qYYy93uSRVtFS0c2uOi6IhIyZ43MJ3LY+usftUteN8rutoRBewe9y1Gzz6xxN8Q5y+//zumbh2J8VjZ2NB5EOEtnNit7zhWkkdhaJ+0cT0fdF197AHpSiEIV7hArgEjsbJBNDcyDX6SX0vAKgC0zg5RA0PKHb8btz905JLgegQofCCckI49YSIcrw0PMH6Tunv80nzEk2hJU5/YkSH20OG3/0U6dFL/Rpe5uk7yF4XXi7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5aIVRiKhBvS3q7pC7kEAm7ygbmYoSXORWJQJBpLWho=;
 b=aHdIX0qth/lDhpRDkYEHKl8lLuAIHt0gzc5Sqvfp5cHAzih8ehohDVpPwMNVtGfGAera7v1FuMRNzA+rM7BAsujzolG49+inKJqt1RKMn13kGmJ8hJayxtoAqdRUMqx92UJq19ibrpAiVgaaKlmVqNLVy+A5NZLM2e6oKtdLRxhfY+wguxsTA5cGBO6PTsUiHGniyMyb7YdXXwFxEIyFY2AnpTCVD4SAxHljxeVyfeKhHxCGsAx/fXREZVr9C+6JQJy72UG88GQ/kNTQanTcqLAwLs5rFi0d7KsKeH47xSXq5vtVoM+dvTyjzXCBBO3VYKJTIF9UUggyc9ex5c+5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5aIVRiKhBvS3q7pC7kEAm7ygbmYoSXORWJQJBpLWho=;
 b=C34Ec5Ean23eXSHEEcZWjYgA3GNbX2l0WDqqAxKqiflrZrlhgWfYShxr4JarMGYUcl/VhCvbYoLFNKs/g0EPMQtsiewNy76Akx6KizzGg/I3bkkPMQrwEJU7dVXuXDqsrgju9Jvaqy555AtN+MaSIN+ylzD7RbZzlsF+MlbP9xA=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6792.namprd10.prod.outlook.com (2603:10b6:8:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 22:41:35 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 22:41:35 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v3 4/6] selftests/bpf: XOR and OR range computation tests.
Date: Wed, 24 Apr 2024 23:40:51 +0100
Message-Id: <20240424224053.471771-5-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240424224053.471771-1-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::16) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: fc482315-1a07-428b-76d2-08dc64afb200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ClL+fdnwKcv6IPqTmE+TJNceD6csv4M5zK2wjhykDJruRQJ756FcGO2/3B26?=
 =?us-ascii?Q?VCk1y3gmPzAf+bDKx5X43AwgwvTEwj/HjVJqk6gkO8kFWMO0GJLBWH2iJef3?=
 =?us-ascii?Q?xMsXaAvOd2iLvEqKim8lEG0303eumhDon966TBC/DOi7GLksGsDDDzCSaxon?=
 =?us-ascii?Q?evgd7QnoZ2TaT8G0SmVqDAQ7IlSOY8Ve0rwjM6X9jtAh/HBAM+qmIIAOLjqx?=
 =?us-ascii?Q?kTvbzB+CtNd8ugJ/1J7iMAFWNextUQnAY3F08cDlGq/GZsZriXPcSf463R87?=
 =?us-ascii?Q?3V/hv7KWYWvgfX3kh9BpGTtK8dZ4inEep7ofT/MZEqxj/x5OIO8PwtQaLF7R?=
 =?us-ascii?Q?ui+CGgmlyStp+uUbyg8UMbV8bH7ExQJWkWbX4h1zo7PvwuV8Gv2cBt7NUokJ?=
 =?us-ascii?Q?2TII/I6QQG2nu4KQeXBItoVggmxWJjhdUkm/K2tnLQRTczbjuSUhR9/ydZP/?=
 =?us-ascii?Q?k4tWALzSGwfSGpAXSoEp0S+umrHoNR7o3fOGti9iVanscXd9X6yqooH6kxk+?=
 =?us-ascii?Q?jd683hryIbSDwIe5xI0/oJgisWCkfUj74DZoShPqmVyEaP8cH0YLGGWSWf8/?=
 =?us-ascii?Q?7noswuTEApoATn0wp7VIfoW3vlPwW1+URoWnW9jk43/traEGHj1bBg/MccDd?=
 =?us-ascii?Q?XVb9IWf7WciyVzarbOz0XSfO2Hs9T+9yxDcWT5nnk3TIgGPpd4KTXMKZ8Hzv?=
 =?us-ascii?Q?5acmv+IhJiPGao7BAUGk8oo4Fo3Hypq2BOSiWLQufb+HJ+8ssYU0DS9J3mZX?=
 =?us-ascii?Q?04pK/Z+aC7L2bmGI4ttc17g650i557DrHa0ZcHXTRMEc6qHmdIvhCR40OWpP?=
 =?us-ascii?Q?/YQjAHTSTBIuV2QGRuqvXXb2Jo2qhNNISbsNkeyysR5AZR0SGhlo0xoBTZyg?=
 =?us-ascii?Q?wHqxxrH4ymEg5BHIJWiZW6uefHPumQQ2P/CRmQmbO8Yn00UsqFoxQ8FWhkjr?=
 =?us-ascii?Q?At+IWIsbW/YzqNSkMveubicQ0/6pJDUPK/qBXZXuk8vLTYkcz4VXHA3LpHmC?=
 =?us-ascii?Q?2oe9hQi72Z1OIDf76s4T3v5tdyE0T7YRFwWFri6nZzgbqA2r95BRuymtGSbc?=
 =?us-ascii?Q?DatUbT2t3PJRSh04yyFEeNjxFVjncUZBg9IZRaVAxJhH6H757ObrBtaPu/zK?=
 =?us-ascii?Q?rR4cQcc0wWrGZC5WHmtmkocgVWH/+tzL+Tpf0gI5iUiWhYY3PdXy2fm3w+XZ?=
 =?us-ascii?Q?XW/q2guDxG6i0D1AOoY12bNA3PLYc2qTT2IL3MMoqAAvScxLZZV50MG8mr0T?=
 =?us-ascii?Q?qHwoB9JK5XWO8cd8Jbu1gqjFPditnDIm6m4ev3+CHQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o9poWvFbIchcoG8jUVShXRcZ3BU1N7E60xy+E271f3rR2cetm9q+kg4pJIz5?=
 =?us-ascii?Q?tpW96YIL/URSErYGg+7RyUS+P3Nn6BFPuE3Zkxswpkv2tGDFrqJxhf5SdcNt?=
 =?us-ascii?Q?VnB5fG5Vf1z4xQKRIOjL+yQw3Tw6WTEU5stnnKuS7k3Z9/zLN8uCH+2RrmOQ?=
 =?us-ascii?Q?VCzEReNRP2kv/hZIYmsyWEz/fW6WKu1X2G3QWiKFqQhY3qEmt+jeWBNjdaEU?=
 =?us-ascii?Q?O6LgKEBlDGQeGyVIzjSaXFRHb8M2fmMUPIRQSynWLbIfsWAqAKkuMuHINGL1?=
 =?us-ascii?Q?IgXsyyUOlpmW8qhQI1kVlUv9NlmZerfD7E0oMh8wYxPa6Ibn1fAezTIti2nL?=
 =?us-ascii?Q?ovMdzXMER3Mr1VhonerWKo5XKuBpgAs2fowsc9Wl3gP8oemndnGnc35Z4OxS?=
 =?us-ascii?Q?cON2ydp6sO3jHC3eHWMkqxXL4Sc7Va9i2DiUh2PUUX7P7E3FT/iRaxiThIKJ?=
 =?us-ascii?Q?L3Lmn1WibhrHAIja1se7RKX1rD7lpC72ykiQ2fnZ9s2aM0ztvw8Q71A90tFm?=
 =?us-ascii?Q?gvFu4FWj9sQCMkF1uc9GChW5I+hRTeqsiZEiG+y/02ogHk970PX9xKtBZqx2?=
 =?us-ascii?Q?DnqQ3WOccQ+O190W7CtjzjUZ6SOnYi/Fx6DNZ1KxJqltPznT0PUDJOznLjPB?=
 =?us-ascii?Q?DMAFQ5CnymsNcLoOJpY5fvh1ZhD6rdB7ay3JUjPveU9eOg0TX95KzAQ9iXMb?=
 =?us-ascii?Q?Amj8HVpguAoyth838zXPnkBbQa3gley1j+jCEuzG2Es7+oPv09hf1LmQnuSk?=
 =?us-ascii?Q?rDT6sRIh9YyFQ44GHSiz033T0EsiOGdYHV6rP5Wk/h8nQFSimQ6VPMYmP0SA?=
 =?us-ascii?Q?S6nfZBDA7u/2ejs48Y3/DZvAMxPmKTuM/rNS2KD1mxDPBKh9QEm6viIYzlEw?=
 =?us-ascii?Q?nGqIBbZkds8szCaGOzqf/KiReyfnVBoPZPX35iyMS3naJO0sjsvWxPwqRVMd?=
 =?us-ascii?Q?oZ8p/6UfoKFOAIOeyg86eW0KQ51I3cNpNr2vXQ6x00Uj6iHZ0rnc18teZNEG?=
 =?us-ascii?Q?MW4EcuyVPBm94+KUIlRKFabjx8kUgBHcfOA54+TUARU1IhnB3z3pWUyMlr5h?=
 =?us-ascii?Q?MEuKRbrKR0+6ehpi+85ps50wvpSItItBc8AKy5KbADgnkiVRYmDfXLwraQkV?=
 =?us-ascii?Q?dUvEyvtGVTLe8OIQRY3sb1y8hURuQAZX3FY7J6NulvIL8c9hDi7/r/daFPSQ?=
 =?us-ascii?Q?TBdOACYrhAojUIp9DbVdSctOr9QsOn88e2oTfwe6qc9tr5ckcJ/i5UDa01K7?=
 =?us-ascii?Q?Tcm2NHKtG6Old0/f9ztAZ+EoCOusn3nCbJCE0Zdyb1Kaa21hbBlPvkcrS2+4?=
 =?us-ascii?Q?yWyILIxilOwpD2zsK9SSblIxP35d8CIDCYtN7rKZJchnhThqrK9nLfh/HpOx?=
 =?us-ascii?Q?2XzmeR2K2WSKFaoinQFCzlu/lzMk2rcWjL7aiobVYEt30YciuMYI5AY3TWuK?=
 =?us-ascii?Q?H/2yvYwRIWYTio5NPY0OlUstMedLzUc+MV184hfroWf1b7fkXt/q7Ef7KfG2?=
 =?us-ascii?Q?f1VRZJ/OYO/g+dHz0B0tzUac7YUjyXKLG8EKQJCjy7mbLQY9xQkQxaHxcAU5?=
 =?us-ascii?Q?1F0WTBMI/wth0p7loWocsFODM7GGOo7+q98PMIE7QoCv863WYqi7/AIRHMhZ?=
 =?us-ascii?Q?IfmUza1YTY5L0L3i6y9F/eo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WwyW10pE10Kg+dnNl0vpYYGw5slHZV1jf5oZ9wJFkMvf+7kfmsjGOQdBpMxjvBFYOztNzKg0F/AaGBsoKrDjvuOSX1km2gRvd1s4B1paB92EHCdUsroMPyfeUSkkTJsJc318LMuS11RSx7lnUqwnlmMaqV60Jxwo2zT7rrcAUr4aQr2N9aTwRmMR3Y/PLe07MMaU+sUYMa+NrtK050tNaPlT3SWfyxT8nzAXqTDS5Iie1wjBNsqhSzizrHxO2eyrbKsFrbfZiLa7jhF6pcL1C9Zxn3ho+JeN1AoEB+5+lKUqSn3SToXfJ/GhokYZXACviRLwUVqB3WMjoRwo8TEdfKBqHaZbVjf4YdJvFGKedFRxquPiAizpdLZCiC6GOFwdvt+rDpkyESBKJNcJ4HZFucBIhzw3yCRcz/NmlfKTfQPJcD6EvJgjEF1sW32zrThgZE69hZBiPtzDo7JbnIy0VK1rjxyzLfj/Z0p7t/gnGGwldrwL0C+vU3cE12FU2c3J6EqD5MBn9xVilnqk1tjbhJvjlJG2GBLnS2ZCB1HvZ+nRwlBcvmj5RfaRoVQcPpNOQ8MzZSDln7QiMBytzqlhYcdxnnBdUEqhrMIvgw/EZMY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc482315-1a07-428b-76d2-08dc64afb200
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 22:41:34.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PE8zAChKNR9EihIiAKzeWG8cwW7thTlVP3fyUwgfk712oq3WFtwyxj63T5wURNha1plAKr4dObImRLjllIClKOarcwJodmD5bR7315FiKww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240117
X-Proofpoint-ORIG-GUID: oS4ca8nCC0YTcO5TPX_uNDBSezD62RUS
X-Proofpoint-GUID: oS4ca8nCC0YTcO5TPX_uNDBSezD62RUS

Added a test for bound computation in XOR and OR when non constant
values are used and both registers have bounded ranges.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 960998f16306..aeb88a9c7a86 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -885,6 +885,48 @@ l1_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds check for non const xor src dst")
+__success __log_level(2)
+__msg("5: (af) r0 ^= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))")
+__naked void non_const_xor_src_dst(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 &= 0xff;					\
+	r0 &= 0x0f;					\
+	r0 ^= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	__imm_addr(map_hash_8b),
+	__imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for non const or src dst")
+__success __log_level(2)
+__msg("5: (4f) r0 |= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))")
+__naked void non_const_or_src_dst(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 &= 0xff;					\
+	r0 &= 0x0f;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	__imm_addr(map_hash_8b),
+	__imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("bounds checks after 32-bit truncation. test 1")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")
-- 
2.39.2


