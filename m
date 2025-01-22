Return-Path: <bpf+bounces-49529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F65A1995A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 20:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C102188B940
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 19:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096C143723;
	Wed, 22 Jan 2025 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I7WEZpBg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C6SMGNLg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DB9215768
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737575288; cv=fail; b=O2LbYl/DAvhnS9BuuFKElKlYmKG9jpovhryRNyhRm4ayBD5kttzXT08w3EnsuWtn2BblbKSDgMCTyAOwOj04g8vL8DwnCT0O/R8TDQ/xN10YYsZJ1ADhCU8XoQ5VqrVQk5VC/r9+LwpEwrPGRO570ypsWyvZ8aM7FJ6HOvK7ehg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737575288; c=relaxed/simple;
	bh=GwhY5ZRlgl0MIvqUPl8ejeXhd37T3XNj0wI7ATbFjFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=LN2LcLbruUGzp0ANP2OwzcMtWmlb7eTz7vsLjx7QzNFtX3rgzk1EBmAeRV1S/6ZGk8ZHc9KoHJzhP3JqH445m4Kknym0aT5oCnnSaFoZBvLpX5p0rcefK9wWNE7myFqEfcurnk2WT3MGrs55mBBltnMezfXJlm30tIowBzW+V4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I7WEZpBg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C6SMGNLg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MJYaIl013813;
	Wed, 22 Jan 2025 19:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=UoefoC4Dntw910TQ1F
	Z3YN6iDjtW9XPEU+1UXs9V6rk=; b=I7WEZpBgvJ10oaMqS9atNplwwS/quLz78+
	DcaKtRSUIecB86YRR2y9RKNZK5TxEy+mu+CAbepWEln8PIM0FDEZb+gFzYoVlJ4U
	OdLSS22X9iH47EUsMRXbKFS/TVhXKimYp/PbPpy9h71e6RB6Aym6PMMrIPFXy5/e
	qPEEoFakfp4tuK7go5sGgT3dLwLRGHKwtv28IjNLsDfQAQiNJPj7Lz/6j55FY85F
	rT9HyBFJr8zhDSLjDTxbDB+7WAkSL2GO3RMEyQVIpeBNYrdCQcYMNwdCztq+HpOC
	82VXclGBc+V16+d0KZgAovWCTtz0eVKZ7Xs0QobgHElL3LUpTU/A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qm0g4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 19:47:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MJlF2o004793;
	Wed, 22 Jan 2025 19:47:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491962cus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 19:47:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KheZksd6XCyJU3HpLvjfCCjUtX3YwezQQAnDVr7RttenAxi2B0wJAWt/e81Uo5Cs/GvNBZHZTrbNka7r2CoLqx7y3yGpzfpoIjBvYNLHXRiU+kMwFSEh1gSO1okigsrVHOOqpD6AUlsohkUSa1nNocLR2eN79bieRe8htzTpbo5gtsJHMVP20MTZK69lfTcKR4MhZP+GNybbmKOvnDoYO+QVJEWKgq1eXdsVDN4Z8EuzsYk40ySwKoEPbTgTitUGS81gBMzffqJ6WweA1S+XvSCeb+V4IeB+2jOSclDFkSiY3k6urjPXbKsvjSf7RoVt9mwwYTNxONj89NBjjOqybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoefoC4Dntw910TQ1FZ3YN6iDjtW9XPEU+1UXs9V6rk=;
 b=L2YIHvweA1XtueOnu80ZEM0cAOu6hfR+kzYWazo/V6JMt1U7HCc+zFYFY6UHLUogyAhQPyDUevo1l3MF7EoWFjgKeyfrHFR2lkxw/9IzGtODALWuSreWKuIq4cniPGWQcUYnrqquYbNvt51w6EJsj7NeSWI1HY2VBPlTS8wkgWXKLPbkkShBNTd1ajq6P4lllWFcMsrjx0XZ/yDprol9kkneNthzlJzDoIGIazwxuWU3C9ijkV88oVnNdXKJQj+/lYw1BycZmVYm/LeeStKDmB15Ei/G/GzKKYQiL7D9g6RLciK45kIEi7ubTg8o8JgeC/THlxQgvTMNMaozkrMKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoefoC4Dntw910TQ1FZ3YN6iDjtW9XPEU+1UXs9V6rk=;
 b=C6SMGNLg95CzkZZQZaxdJq2wTSluerOKofoMeUuceQ49dl80v6YUImOQvfsjWNwGw4AQIN0sOdItKzjjhgaW+3LrOcxyC2cZoyNAkPcWl5nI00jI/Pl2fAJ3sndIEKmHy5vObOBWtL45K6ul/P4HaRSU4uzq/CrWH7KmLWWtVW4=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by SJ2PR10MB7057.namprd10.prod.outlook.com (2603:10b6:a03:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 19:47:31 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 19:47:31 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: Re: [PATCH bpf-next 0/5] BTF: arbitrary __attribute__ encoding
In-Reply-To: <EQX_MzPyzXAlkEpU09L1fHjlBN6I0iRFkNw2X7n4pW2r7ML4hoJ-XMX3oUsUkbCm1UZ0EBpkM7n_3ORDwiL0O1aQSaD6rJfFzBfnAwUJ34U=@pm.me>
	(Ihor Solodrai's message of "Wed, 22 Jan 2025 18:06:42 +0000")
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
	<87msfjhy3v.fsf@oracle.com>
	<EQX_MzPyzXAlkEpU09L1fHjlBN6I0iRFkNw2X7n4pW2r7ML4hoJ-XMX3oUsUkbCm1UZ0EBpkM7n_3ORDwiL0O1aQSaD6rJfFzBfnAwUJ34U=@pm.me>
Date: Wed, 22 Jan 2025 20:47:28 +0100
Message-ID: <87h65qwrzj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|SJ2PR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: b89e62a4-2ab7-4714-96d8-08dd3b1d9bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/VWCu90G3PUtsigC9uEXkdvRrQ3c4NXJAbkjzTuYfKkLVNE3v0/mEL08Gfxc?=
 =?us-ascii?Q?MV0kvy0xrF0x/4TTJInr048z2t8iVKHrMMeTRlKCi3r14LxEDzGGpsQWM3nS?=
 =?us-ascii?Q?n7K41Ap6eWtE35GFg3+5x1M7ptI5RmfiZDBsCAB+G6CGxWO6Xo9qGTLd+o6A?=
 =?us-ascii?Q?v6uYwYGWDiYjDu10whm3XGGPTVKNh7EEfRT8y9dlUiSmliJyi9dbTOCxnop9?=
 =?us-ascii?Q?mVR5EEfnW5RpfRLlKyl/3k7VzHnxE/Yqk38yrqLjeOXXbB3XnvmPdlGbbk5n?=
 =?us-ascii?Q?tWrNOriKdoPb3yqe+td6+haXw6Q68fSfkX6xiPqM98L+Y1ftPoQLx7+W5cDE?=
 =?us-ascii?Q?fEWZEk6iDSUPkGx7S3oV1hncWjbEpThfMXfgkB+VuAb23d+gixEWC+qz9gAB?=
 =?us-ascii?Q?IK4wndK3l0v/hlkFV/BiNmCmedJ687lE14wax7w7uK3e+nJuXtS97qwyIU+g?=
 =?us-ascii?Q?eX2cmUHZRjWmGZV21ogIsdYg1PcYq/+PWrKVuGFjF6uMVlLG+as6/nsvriod?=
 =?us-ascii?Q?7H0lhB8qyKK2Gx7eD9ICecw3rw56TwVcIgFAIcL5o59/0ECSCUwjX3m1n0jE?=
 =?us-ascii?Q?DRnIgF/r4lRkMXrKsFMVcSpbptO4dx5xn9VtkEJjpuUN/KDZLj4EDyklO5rJ?=
 =?us-ascii?Q?EfcmeFZxOZvToKpWnfQg2Ki4/US77dJTOX1pp/N7ugTLlRCLVivMig+FbV9G?=
 =?us-ascii?Q?ssuY9SdMNgOHOGUsmF4Ki14QOhvAnz3X73ilfoVUitxoNvDxDZuL9H8fEcpb?=
 =?us-ascii?Q?t5St2Rci2oet8xdFKDyMICKuht4pSo8gE4qKF4ey2ajkuguCSJu0GVCnmTII?=
 =?us-ascii?Q?VijjQ37GQRi0PsNrgd32EU/QE3d9LQ8lDjq+hwpnOeUosWXJJdVQy5HaT+Fd?=
 =?us-ascii?Q?jppEvk0SXuMLQfJ8uCVRakeQIYe3nkAPICJABUkFzpLsIuT/OAY7zZJVGcCb?=
 =?us-ascii?Q?6nv20wKoz8oMOF/eiakMPTC5oRpXUW4U+F+Gv0/r8gnXIyMtSQ9hDhEpgOft?=
 =?us-ascii?Q?7iGZm1ZtFEWNtHVmgLNvhIFWMPvCyMgdTZbkTGU1JBv+eiSBn6DMj3VBBjPW?=
 =?us-ascii?Q?2/Gx4TSkzSUkXFSaslL3u0FoFLIGMhXfOSvf3oEURhCySzG+EGKat6UeBpz+?=
 =?us-ascii?Q?6OhXZCuzX15Mjxe9LEI4YndTPnTiqR6CB1I6jrc1ZlQWvU8jv66wK7FfOBBq?=
 =?us-ascii?Q?XuftSmLb1GV89GcEqArmp5pV6EtFN4J/RlWe5yjo2boCQ6aC3ivQE6vsY/JX?=
 =?us-ascii?Q?wR/7qVZ4F82pGp+UOPeg6XB9s8D2JthwAC7kJQOyvQ6UFEiqNjPcs2xM8wp5?=
 =?us-ascii?Q?W5lfUdptZImMJ9QXmpn3qvLY6e5kRyuX2LAVweKRXPZ84Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4jRZREo6oFACHRYNFrE6EYFgkYDUa0642ZxHOr/PfFzG0bf/R7fNodvFPd1f?=
 =?us-ascii?Q?hAD2TJVoB6BZlvOzZD6egQsZuFDRRXOb/zSqEaoRXhOG21gtq4suqmSg8foj?=
 =?us-ascii?Q?VhR9qzyko25tOqIZzK9QmqJpl+b3VKgHP62KXcyA15888getEHrcdC8cNmzg?=
 =?us-ascii?Q?oG7mx1T6qr79k27EYxfx+5zjT4pCyFxhSVS8ah+2nP7P69699iLMaG+rfSlL?=
 =?us-ascii?Q?uCqNMRbNg3TpiawoMWJ0w8LlriLEObh2f0lkXZtUMNTakc2seIitx/t7e8m8?=
 =?us-ascii?Q?UATQktiXfqfcIFrxcHly/KOBCAgQrcmRpp3hxLypb82nAr8zynodUBz00PDH?=
 =?us-ascii?Q?jgAekCchoCtZ8xCYimtW9GZjeuo7PwmznHHpbVGi0Od48P+SC+7f/urSAg5D?=
 =?us-ascii?Q?GaLToxMPvkYQ1cE50nJ/ezu+AG4DlrhnQM3EKnZv+Fb67B3NvW9CfHwJ+EBE?=
 =?us-ascii?Q?3O2h9UEOj+miEcL0iEK4164i+Bs3VUqBSJnoaN5ToR+mx637Vmn+D6BmDsBv?=
 =?us-ascii?Q?Th0sOWQOWGPVawHiu9sm/GYcfNHKvnvLgPwiDKvoqiFylTNZkBsYv/199tzF?=
 =?us-ascii?Q?vW9ym/gsGA5h6/IahSyuRSSsQC2QJA4mVCv0Q+2EBFs1v+w02gsVxGPeGSgd?=
 =?us-ascii?Q?j1eCnG18XoznuJ/l2vd7pXrwi7/RJ1Vnst7MV3pg2ucP65iT/QlJ4h1LsNCl?=
 =?us-ascii?Q?UCZS88Ui9GJnPArWaCYKkrm2HukLOvll2NWlhgVWk+X/UIFys6OLswbK4ezl?=
 =?us-ascii?Q?39aieBF8k3TPzNQoR748pnCh9hcMXDsIh0uWQfHuvgF/xaahjVDLan98Zr20?=
 =?us-ascii?Q?QaivNrSTUQjph9oATv+23dHXbKOSVp8Xrar7lMMn2MxKuSTRWR1X8NuhHU8b?=
 =?us-ascii?Q?1aDgJGRVkKRanmh5HgQ1qjQ22WKsCoaTgflBAf/OtkhFS/9QaLGJPdhecj6W?=
 =?us-ascii?Q?V/KwObn7qimua5PSU/kqloSZsMcM1nUygtRNB+NZhUHt09y+v1Zto+8BmGsm?=
 =?us-ascii?Q?U9K1rItR+wNT5HTDd85IsakXwWEYmwCmaHgFhUIoOlQ55rpp8dShF7w8fDiI?=
 =?us-ascii?Q?3GjwriIzn0sO3oDxFXbcrfF69w4j5m1rQqxtMkG4iOWiWw/cQ2NLfrmoq027?=
 =?us-ascii?Q?GKxJftXkeMMnHJlkfNgUd+xe/zMV9KULbJkZlXffCYE8GE5UU578wVokUZ/o?=
 =?us-ascii?Q?TuAFrxJTrDcO5C7/MY4tbNVW9r0R8XZXtKBCu73/rubYw4H/pkWX0U4I7+6N?=
 =?us-ascii?Q?DnjxYCKYIJtwo3vumXiKP9CucKRO4h8zcq0JWl6/Fxb16qeElmqBbKgab5XI?=
 =?us-ascii?Q?+or3Bix5oBKqxuyzbeoEyqug1khxnQQHSFUtYnQ6E6B2zZk3ncJDS0nTSQKm?=
 =?us-ascii?Q?b2nsMJcGPaLz3jdHkd2CNNWcmMqginaoCXV7vTpXOOGIglWj2zhJJ72DVooY?=
 =?us-ascii?Q?vwc8g7Vd2p/S7mAXs2qxBYZY/w8FYdrjeI6cD4vsn0BmpEOanp7EwSHvXbQs?=
 =?us-ascii?Q?lDEchecGRE1GoQ8bWGrzhuALjEVc1KBMMPRNWgQYPDLp8UUqK4NKiOOwElln?=
 =?us-ascii?Q?TAkEUVWgKK3MpoAmqjQc37UHMXlUsjaoSA/lbck2KDFDrltc8FFLumbUlIth?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0uoTpcqUNeCPvJIE/KqRf/yKiahEdBAoJytxfTIxAaz+ybQIHMXfDfsDyF8T7Dls4X5q3LnRDJLsX1x8oQbMaZ0OOHEmzPX9jO891xj2wfzOYFwDLqU5BR+721llQCZHZ2yt0YVnwVYgA6gcraNldqhAJKGHvti2vVPbGr8CHqjL3++3o+IyVzjIFKdjgCmuPpiIkpBgNk6Rx9/fSxtRHpOlzXF0GOkK3Lu8O3MiXqsfDL/EKuBTBLFxHgMk1Yu9UYPEHZCF/cHy72kdJhkUIy+uDFGwalDTK8h8V0AtkbK41W1ZskJ5FzD+dTXeiW05T5g05HwxDku98NDtMxPIkFM/MSMw0YzJWm1bfiomprcqTwNYSxbRfppikNcSEtG6rvH9qOHhivLTGHWyREILskHE5j95TOAI00iyXWvfQQiAVe4Vzj45FaiarXhlwwiI61XDDb5HIEkTRc+W/1N38qdSxElnkvADlLv98AMP/Vnc9VYFoMjHE8EPI2rGhm7hniqrWmKkM6eLIoNVlMLEEhixVr+X5QHIp0X6+WOMUcwZ86g9lurclVd6kfphhkRBykSgEnlIKnw0X199hywUiYsLsYkIuggKqSNX7QfWWnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89e62a4-2ab7-4714-96d8-08dd3b1d9bf8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 19:47:31.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPlDlTWFnqAHZg4JWElFLcLRMDqRXtfPkdAqEjo5gSRU3IxpaRVOKBz3R7FF/YGeWRv8HWb7QwDJbCjsXkQenAhGCRyDRNhnsTs+Hfw/pSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220143
X-Proofpoint-GUID: z6SQBIpVqSLEpYsgGoFM-ubUZk77Ffxl
X-Proofpoint-ORIG-GUID: z6SQBIpVqSLEpYsgGoFM-ubUZk77Ffxl


> On Wednesday, January 22nd, 2025 at 3:44 AM, Jose E. Marchesi <jose.marchesi@oracle.com> wrote:
>
>> 
>> 
>> > This patch series extends BPF Type Format (BTF) to support arbitrary
>> > attribute encoding.
>> > 
>> > Setting the kind_flag to 1 in BTF type tags and decl tags now changes
>> > the meaning for the encoded tag, in particular with respect to
>> > btf_dump in libbpf.
>> > 
>> > If the kflag is set, then the string encoded by the tag represents the
>> > full attribute-list of an attribute specifier [1].
>> 
>> 
>> Why is extending BTF necessary for this? Type and declaration tags
>> contain arbitrary strings, and AFAIK you can have more than one type tag
>> associated with a single type or declaration. Why coupling the
>> interpretation of the contents of the string with the transport format?
>> 
>> Something like "cattribute:always_inline".
>
> Hi Jose. Good questions.
>
> You are correct that the tags can contain arbitrary strings already,
> and that multiple tags can be associated with the same type or
> declaration.
>
> A specific problem I'm trying to solve is how to direct btf_dump in
> interpreting tags as attributes, and do it in a generic way, as it's a
> part of libbpf.
>
> I discussed with Andrii, Eduard and Alexei a couple of approaches, and
> tried some of them.
>
> For example, a set of dump options could be introduced to handle
> specific use-cases, similar to what you suggested in a
> ATTR_PRESERVE_ACCESS_INDEX patch [1]. This is a valid approach,
> however it is not very generic. An option will have to be introduced
> and implemented for every new use-case.
>
> A more generic approach is adding a set of callbacks to btf_dump. This
> is a big design task, which I think should be avoided unless
> absolutely necessary.
>
> The benefit of this change - defining flagged tags as attributes - is
> that it enables BTF to natively encode attributes as part of a type,
> which is not possible currently. And it's a simple change.
>
> Using the contents of the tag to indicate it's meaning (such as
> "cattrubite:always_inline") will work too. However I don't think it's
> desirable to have to parse the tag strings within libbpf, even more so
> in BPF verifier.

I expect the verifier will in any case have to distinguish the different
strings it gets in the tags, for other purposes, right, so this wouldn't
be introducing anything different?

Also FWIW DWARF doesn't have a kind_flag.

>
> In a discussion with Andrii we briefly entertained an idea of allowing
> btf_dump to print the tag string directly (without requiring it to be
> a tag or attribute), which would allow all kinds of hacks. Tempting,
> but probably very bug-prone.
>
> [1] https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
>
>> 
>> > This feature will allow extending tools such as pahole and bpftool to
>> > capture and use more granular type information, and make it easier to
>> > manage compatibility between clang and gcc BPF compilers.
>> > 
>> > [1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Attribute-Syntax.html
>> > 
>> > Ihor Solodrai (5):
>> > libbpf: introduce kflag for type_tags and decl_tags in BTF
>> > libbpf: check the kflag of type tags in btf_dump
>> > selftests/bpf: add a btf_dump test for type_tags
>> > bpf: allow kind_flag for BTF type and decl tags
>> > selftests/bpf: add a BTF verification test for kflagged type_tag
>> > 
>> > Documentation/bpf/btf.rst | 27 +++-
>> > kernel/bpf/btf.c | 7 +-
>> > tools/include/uapi/linux/btf.h | 3 +-
>> > tools/lib/bpf/btf.c | 87 +++++++---
>> > tools/lib/bpf/btf.h | 3 +
>> > tools/lib/bpf/btf_dump.c | 5 +-
>> > tools/lib/bpf/libbpf.map | 2 +
>> > tools/testing/selftests/bpf/prog_tests/btf.c | 23 ++-
>> > .../selftests/bpf/prog_tests/btf_dump.c | 148 +++++++++++++-----
>> > tools/testing/selftests/bpf/test_btf.h | 6 +
>> > 10 files changed, 234 insertions(+), 77 deletions(-)

