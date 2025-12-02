Return-Path: <bpf+bounces-75907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7EDC9C8B0
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 19:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5B93ACF98
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7542D062A;
	Tue,  2 Dec 2025 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aJBiQs46";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lkl94x77"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42102C11F3
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698556; cv=fail; b=FdCI9i+GkkA+iRC93+ZAXpSyJEyueySuKP3cjfUisXDt+vtDgviGWuZpOsH+K+TtN+yJlArHLJMfgWYdLUi7v56n+jOdnoS8RbbKn1T7uLMCykMZRAHSXOl3xF3dVnzyaCe5RNMsc240kdjuWV4C98ecm+GvCEDEsHhe9xIdXDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698556; c=relaxed/simple;
	bh=QsHfzW1kIhJrjUwzYdsvrW2w0ENiGwH0K9guuqB1vyI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=omfLggDsj6pk9iS8Te+qt9mQDOxdTLjLkprd8BBEoVFgv4dUaqKUE33PRlFXPRxIgK4CxC7mzBRwMCwCGK4ae+egEq5l3KP8YmrQQwqwyRmEl5KN8d/HuciADG6zRrEQn/jZHOtyFlWW/cR3/TOku/ZTYd95ZbkgM157RIQmfDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aJBiQs46; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lkl94x77; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2HtuW4805841;
	Tue, 2 Dec 2025 18:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=1CANC+tyeqwWVSbe
	FNSkziFTpKLUQSxNgKbpobZ+PDw=; b=aJBiQs46JMMg0TPkLtwgRKEOq3MiHRwv
	1EVaExbLDUabmVo0YhqHnhwVCKb7J8wk11qs8Uuan4n7hXN/KYx45QlxyvmhsGrN
	T7Qr4f3HIt6RFwG5h7DwRv9L5DnvZH9JdzRyHaJhSiXWp2MdnkF+QKws4ZUtmV3B
	OGUTdutaPUZcnkgVKqbcD3mRzbbybf1YihcOBh3i0Lyx25nRphdyViFTH3dOIZv0
	CMWX1EztjHmHYpDMQ3GWeO0NMuKhDC1j6yaOD6fD6AfaKPOd8zrAeO5rk01RR8ay
	ggePbxfnBa8nkUqrmJwXBU0yDKnV6m/RGF6AOJr/Ol+QYJThHl4IAA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as845ufr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 18:02:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2GUDpQ023446;
	Tue, 2 Dec 2025 18:02:31 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9d71he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 18:02:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxUqdKmL4NqbGXVgzhfocBoNB/xkyygfW8q8hK8O0DN7SHDGrfxdP4Ebmt/lW4u3LOOXHaxaj83qwwEVXxeODw2Lb0JKOv2gHP3aehYBraoMLV6PewkwyVULRjGIy7mDLoSlJDI+agsmIc72jeZN2/M/FSrqeZPWDaPOaEUU8mdYIqm8pzt581CrqdRLUEdVdE8susNQ8iseHM9ChDGNK6gMzrSB4CuqqUYYX+uvDvkhhZnN1aIvLayfh3D5U2XpRWj0erUI/02Xtz+w3MAugTbtYB9Pr6Vu+Q6CRnIwEOWMV4bUkS/ZhZkTmjwglEehsSw/s0fusB/3gl2rIRRSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CANC+tyeqwWVSbeFNSkziFTpKLUQSxNgKbpobZ+PDw=;
 b=HImnzZUGVDKWEX87ZM0gZntlRW0gJ26kFqpQ3J+VCkfYPEoA1uA3eEcziXipHX0LifRqNrCA7+KM6MYcI1hyLiP6uql5oIOLbjHrCgEqJwqOqQk47ShYAZ6+1zIaYMW8WgfPq0ViSDr6SUBC9d12LOL6vz8e5cIjLk20bXUiADpIYyMcYeQjHISLHJPdHyTMk001sLZI3fFrk5tP0JtjZ+oKurhXkaS2mEmo30GENFrcy0LKyr1e6nf/BO4mSJsLJfR0HHmiIp4j8C1yvxtFPcjfRflOBTE06fZkNJpcEERpPh1CmSZ9mQe7u5z0Jm7JhIASe7W3B73gL0Fz5w8ehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CANC+tyeqwWVSbeFNSkziFTpKLUQSxNgKbpobZ+PDw=;
 b=Lkl94x776kG/x0WNpOcFESCVd1gc6DIv7UWRg/qLwIzzjZ121/JKLyXT8YUvub/tMg5ALBkX4xe4cXUWRasNfB3FUhvFI1Kyl7VU0NBTgQ0YV5x1Ls+QagubQuVZpjd/M11M4GuCYn1IFFCAvp1DG5xxzyvIF+vMi8zFks61f3E=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH0PR10MB4680.namprd10.prod.outlook.com (2603:10b6:510:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 18:02:28 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 18:02:28 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH v3 0/2] bpf: verifier improvement in 32bit shift sign extension pattern
Date: Tue,  2 Dec 2025 18:02:18 +0000
Message-Id: <20251202180220.11128-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::26) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH0PR10MB4680:EE_
X-MS-Office365-Filtering-Correlation-Id: 547458a8-0daa-4e58-7c0c-08de31ccf490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N3IzaSlxJos5/cREAKFDwtHexVtXH9PKWDSkOrJiYdxlGA1ivTCiWtcvWs1G?=
 =?us-ascii?Q?X2DBoM4nJRhUGUY6FvHjotcto26Ij88PPj2faB3ZFEj74NaM/CiHJyCaqq5a?=
 =?us-ascii?Q?cZ4ZwsLTPCZs4Pbk034RvhP+rH8MFjBHnDN3NPc1Ou5Itii7k5sHthXiH/hD?=
 =?us-ascii?Q?iAAZYNhccebXX163N7E4JLKmuw+wcx8QT2tXsvDcamtdfonyL/F/nnYcGt8Z?=
 =?us-ascii?Q?0zhsydHUZAiRvJCbE7hGyTSJWzMuaXMOl7Os/gthXo2xKMPt5iNfo0RIgh4T?=
 =?us-ascii?Q?Url3bdKTH2ROZ9fOY8xXcBwocRY47xx7+0YdUyekQpk412SB9GVMZLaqtf9S?=
 =?us-ascii?Q?k9rxRNqaZMDji2gY8D4BoPw3zbkWQFJpo8oRpn5SeKnmZvreLlDAwLBy9NR8?=
 =?us-ascii?Q?wJHmy/Fg2skYi8X7OXkESrENVZmRkk+gHHOHcgInfgg772sB3/gusjXgmWGM?=
 =?us-ascii?Q?TGcYKjOy3cBIYG91okyV59A4/Y9PGtq0IO4Qg2/5evQedZ7EEBOIeGnYHOoI?=
 =?us-ascii?Q?BEVrDPIqky7PPXvcORznWLIPT+WmT/Rj3JH82tVSysM/6/Nr6rXeytQ2S9+K?=
 =?us-ascii?Q?+U/kBrfluzV7aQm7jMcHuTx4VeFqOOBq/8KvSCHHjmyTAaMPs4pWYlvMJ2ys?=
 =?us-ascii?Q?Hiq3QoR/RzcTIdR2AY6D3xssz5dqAMxzyavXnWkPq/SM91GfxoScj9teG7O0?=
 =?us-ascii?Q?ZfQ8GIlE7UXmkYJr33vt63RyhtEvof94paYpLtF/eHSvMaIKB5q4hXVKhviR?=
 =?us-ascii?Q?Oxdbn7D7658pBAnKcN4+MG3410mWfR9NgVKgskv7qARsZyfcb4Lb/LD55sDa?=
 =?us-ascii?Q?bM5CkVA0oLKhU6an0rF9kxUCxAmkE74MwX8hec7trZ1aXn71KibzvQy25CVK?=
 =?us-ascii?Q?sAoeWBKsZTSzbNPMUSA/Jr3ELq984f36hqLRp2JN0wp/znwilyxcspVS+AEr?=
 =?us-ascii?Q?moMEq8XdUjcY1z43UHchvsnPdVRHagN4nhsjglR0Q14FYp794qUV1cv40HcK?=
 =?us-ascii?Q?spSmH5QpXsWOiR9luoV2Q+TpJGnPXNMKikQ1Q/IwEzi/IHDyEFCFYHkAmmU4?=
 =?us-ascii?Q?8/skKanIOU3S38Zs3d0jmgcv0Ql6Co2LWFKkhx46bQHovCxO8H1nubgb1yv+?=
 =?us-ascii?Q?3W5j1+vSXGPtmndl/O8FvBoaQhIiVu3uYtvJMqJKrpNxXCAkivj1yickFTZ8?=
 =?us-ascii?Q?C7AblUyYEhmxd08NhK0lNyFxB6aDWcF3VXMxCEspML+GejOi54YaToIJJecq?=
 =?us-ascii?Q?rmqpz9fwAFXo06G+9iFIzWE/pM8ZHy5JE5SHJLd182Lug1tX5VyNw6opArG5?=
 =?us-ascii?Q?lDquOE0REaks6wySJwRtLPt7DbbAIPGQPadBeAPk/Ka27wdnYe9XstgjsPOE?=
 =?us-ascii?Q?WIgO94WjfZJvnrvxuAayaj68BAiCDQDHEjL2YDfo9EB8bsQ6H6qET6mphE3f?=
 =?us-ascii?Q?aPeRoHJc9wyyc8xvjoBlmLtN4ExU3+v5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PanBD1G2ugORoc+YAzTq7OXAGWOD6t+VYaPsbZw8qIrjhGAWFi+y4gV1zigs?=
 =?us-ascii?Q?HY6KACj1FnzPet932MynZWfQbRcGTPIi8s5FeneJ60AMKTfFlT9uLKb8P6en?=
 =?us-ascii?Q?Qr6ssgu/nSrLvFBSeEknCk1or6ieiKjOI+9QOMwkrgyNBMm7a15uAB0tGztZ?=
 =?us-ascii?Q?vsDSm1JkC89wK+okcT4ekirVLM39jD/91E2Wv27+1itvPs4rCEOfJ0Y6o0k7?=
 =?us-ascii?Q?F73Nsia9kjDBNfETJ5UGV2796Zyq6CQlPfaFg4QCNNXZWsJgCKj/BJCfW9lg?=
 =?us-ascii?Q?oELQilHBR6cA6HqSCbcrDsFgHjs2pEl/Pf+Cw4E5ntgYJ9UFOxSCoCtspABM?=
 =?us-ascii?Q?jcRT7kd/vu/tFwYJpXHsZtq7M1fHqQ98nHdrl+ML8TUfaMU7+5Z6tk1KLJAt?=
 =?us-ascii?Q?0jf42AfeDeDBmHNeKt8vL/lB588rDhQfjnOaODK0+Y3Ht6nNlPaFt9gQF7NQ?=
 =?us-ascii?Q?m1SO0Z8V/XdIvp1d+3T0Z4fq43R7y6xW12HbIqK8K9FN5pcHwVmm7k5yBb1s?=
 =?us-ascii?Q?I0x5BYjmL3pyl9UwXeOe9e8qa6EjGI/cRsdYsJwJH4u2qTVwCiHwK6T0rOc2?=
 =?us-ascii?Q?z805eAzQMorHU2cnY99U3sQqpQTF4he/CQ7XVBCFOOwnq0g2pytf7Qz0kuGX?=
 =?us-ascii?Q?plsxvUkV8lK3vFw3li3dyHXG5mc6970BerZEB8M3vw891nXT3hDnzQ6nPkEV?=
 =?us-ascii?Q?cqRhUxLE4XU7omQa4spH125zKnTWtG2YrPtwfHzWbw64gu3OdqUaXC3nWgYt?=
 =?us-ascii?Q?RVW0sUPnubdpypDa1UQlB2r4gfH+eMSOaw4JaO+kMfxhv6RxsQqcH5/MreSc?=
 =?us-ascii?Q?Z6WDgGLGTduTvWoa48Igai6FLQX6K2OWZ3JUfWh7E9QyrouRwuNaHCnfi+/E?=
 =?us-ascii?Q?Jx5q2SVmbVjVU6YaKW5jDHtdHcOGOn7L3Hg96BPXD8zQF+64Fh0pLBAgSC+x?=
 =?us-ascii?Q?s5EophPFI/DaKIxRRuE5V9g8yJCFHuuuCLqiwD6I6tSHizrw+VLdZ70GcA6l?=
 =?us-ascii?Q?wP5JxcANI/2m+AIZIkZux3G8JLyU+UjlDDUjahVklpx6QHcby8lmIDYikZXu?=
 =?us-ascii?Q?eNQTZEMT8nlJdp8Ap765B+ri05MLNqdpJsKWLQw/oVwXN0T/1WHi0VEsvTOu?=
 =?us-ascii?Q?ExzvDnu2HnviB8c7DndjFFbXeMMv56sMMDStJPHAvazxAlqdadyCBWvHs4z2?=
 =?us-ascii?Q?Rf7VHjPwZL/xJ2TjP3/sMYOFMeDaGj8WMJzTNfsSe45ryscgvwkaCK7C71jR?=
 =?us-ascii?Q?wvkYFW2zlXYL8Zbsx+P91p53tikIQ95amHvTFuozpPRD9gDkuMJiMCPIRLBf?=
 =?us-ascii?Q?40vugbZevTFyOFe+xMUDIE0APt4a+Str/aIiY9QDWPwnAwAjoIqJ+N4Khydd?=
 =?us-ascii?Q?Jv1VNpABl3e5PgkFc5o/NdXRXjpRK+Q/rLB99xakxR4ulCdqy9K6IzManrex?=
 =?us-ascii?Q?JBencfEAtTIkBEwxGTd2988KCHm6t0Ek0/2QcW5eB8CqW7Lhj0esZ70HIXTU?=
 =?us-ascii?Q?WTKK+jMnmymIMNOClLy19Brx9MWlSoApvSfK1DamHEXHeqmbzVSFcl6LwgAe?=
 =?us-ascii?Q?CwGx/DOczJKh/FPQHdqVWVKGJJM4qLXNl1pRdK7a0NXRfeBybJxzPe46a0HM?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	454sjSATNEZ5KUdQbvCtY6jGYt46jtfyGJ1ZED1naBo1ZpWcX/7PyB41ux3+ON6slfcro3Nq3d6GkSR95lmyDa3yysxGkCh1VQywFRPF2mgMgJV4+ANzjOo8Y7u2eC2Wrfpr4hjNERUxjdHJlKF4WEW3nPrXqbLWzgDcyuB8JNNUBzVdLb4WCE3fLxABt7ubm6rfbj/0kRIK47Zfr4ud+zbFQB7seBpzmRcpqWhrj4QU7lCyGPVukoOel2cBKVinwUNY6HQlaLX3uv6dN3Wp5QmeoB6b6X1YFxWDoEpX/YnYsmW+EHMuZfwkv6gY8/1mBiK1QcNWnjMLjgbtorP4QVn939mLZh9qluYcV/CtQs4zgLjU95QT0RGyJ9DFhHc8xK1G9aZCcNaKG5UakScMwSxsGNMBoTBLxxd2jLfAeyCuC1Srf33mg8xIj5YXg/B4435vRK6VpW5YQ6L2upcSf0TQKIoeKIU0E/Ob1mS7DfX+v1pL1z5zs79Vvla/dk1uR/UKeghzlotFEBlGWcjSHZoALx8pz69pd34rcCCvuLKlvjOic7Y5xjPJ0//BKQpIw9h6KEYblWoDyOssWooR/Bh6AgsGrGpYXB2L/6qH2wQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547458a8-0daa-4e58-7c0c-08de31ccf490
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 18:02:28.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdXK1QZtGwfhIykByatzNSglrKzfYFWYVowBJNtMTlKT8E9vloSL3wHho7uOCsN4oFHr8wTisgtIMX7UYK/B08vhCZ6EirMpJ8OqNiZfAaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512020143
X-Proofpoint-ORIG-GUID: pDFy0X1-IPrCncHxSncT2ail2d5wt9A5
X-Proofpoint-GUID: pDFy0X1-IPrCncHxSncT2ail2d5wt9A5
X-Authority-Analysis: v=2.4 cv=W8w1lBWk c=1 sm=1 tr=0 ts=692f29b7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=POqBaNpvHyaTb5kjwjMA:9 cc=ntf awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE0MyBTYWx0ZWRfX+QUkDPFMYYzG
 xqs7P+IVflQ5HbQKazga6L3vWoRr8Ee21OosDP8zhxTNOIbuUsVu24SRybGlSGttvkPbjUep/fW
 0Mmuda327+H8VBeMQbu8OuYzNZxgAqsLkkPM/1F24vakGyuaWr3i5wJfBtEUcGapMyXNJuhZy/B
 tacWSCRCn8fwnRzMIYv/+dkO73uZVHfEdMDfcmsWQp7mLCD9zi4UWAQKlvSHgZwovszjluUOSE0
 FgR+VNH21rqtlxMJGa/WFkuDpxQuCHvVbJBv0BH1DQ9wIddom8bsNCjw7Oad1fpaAOH/lCEKYPN
 Bpcp474lst0eFBv+RF1K8qu0dN0HwWT4Y9O0bP01U/vS7Z3ScAVMIHLfIo+O79Ah1PtigakKaWG
 acFJv7t1zfRaNuD0KpZWW4CzM3JW2ALcFK2YjiQu+Bsg4J2wgLo=

Hi everyone

Looking forward to your review.

Cheers,
Cupertino

Changed from v2:
 - Removed newline nit.
 - Corrected mistake in the test functions definitions.
Changed from v1:
 - Split initial patch in 2 patches. The verifier changes and seftests.
 - Improve comment near the verifier change.
 - Improved code for the added selftests.

Signed-off-by: Cupertino Miranda  <cupertino.miranda@oracle.com>
Signed-off-by: Andrew Pinski  <andrew.pinski@oss.qualcomm.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>

Cupertino Miranda (2):
  bpf: verifier improvement in 32bit shift sign extension pattern
  selftests/bpf: add verifier sign extension bound computation tests.

 kernel/bpf/verifier.c                         | 18 ++---
 .../selftests/bpf/progs/verifier_subreg.c     | 68 +++++++++++++++++++
 2 files changed, 75 insertions(+), 11 deletions(-)

-- 
2.39.5


