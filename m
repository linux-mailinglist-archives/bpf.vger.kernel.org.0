Return-Path: <bpf+bounces-28678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35858BD008
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E5E1F213C8
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0C613D632;
	Mon,  6 May 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aW7sflxo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ygSMeET+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5423813D60B
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005197; cv=fail; b=d0UU9dUTzfp8m7F8iWWBFro9dgs+CVRD7xH7SAD1pmOOJadxQBd851AZfeEQJLaQ6kPdnUk2jUQikcjZCpiSfFv8gl/OceDex2fOBdc2CoQxzPMi/tIEzNx+Qd+GHa9uRPYXVihZEE1q4TuxU4+KF9XrbV9qz2dlxMvybQLq/2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005197; c=relaxed/simple;
	bh=G4T0Tq1x82AedsTtU+M91VqIPFUUhR8AKtkPB8QDvOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HTztwPXxiz78R0ojTa5gXlZGY0Z827MBQKA+uuH/ZkbBrvnnoMI4Ixh/CAYW/iN87xXrLlIFYT51j3gDqlvfMYE0Zo8ynFSB6msTqukQmLxIOIE8bxVJXHrz8bkvFVoI5o+qUuSLZA3vCfiBWnmVN3T99h0RZNP7bDexbU6x8gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aW7sflxo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ygSMeET+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446ApKql003270;
	Mon, 6 May 2024 14:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=I4L5nhkZOTYqOB0+F6HrZHK6EkgCCKf1Yjm9r5Q/VWY=;
 b=aW7sflxouZTtOlvejmI/g/oVqmN8PyszHQW1eFLYVwDMenQsKG1g7OWKHyRGpyjpfrJa
 iObmrIGzDoAZpQ+5aNRx6uvn6fAznhNCYaou8o77hBh4D0ABxqtLZWsJwqpPCKJqxZq7
 VvRXLUr4FC0Cxxi79FRTw2gmHNO1U2qVaA5+20VDbYPNc5Yjhxk/LQud+ShFqFXVPLGv
 FqI2217aEnV7Zz4XfgBtBKuite3EF3sjsCaIYCL0NUOhpibK2nXFcyGZ389rUjJ4jBS/
 eIjfz5cYd60oClPQCqiFj1mIs8SCyGiFFcd4OYdTn8ECVOCstuF605mhOYGD8+255/4H gA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwdjutngk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446CeXfm027671;
	Mon, 6 May 2024 14:19:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfcxa49-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXvssO3AX27wRbT8NsCBTFP7lM5uIAzZ9H/LAKc0jzLuvGX1jhoh3HPScGGzJcEespcqpagFpV/z4cV4ytCcdkKr70r6eZ+uxAM6lnBVnsPcM4bgHTMPY6tF+8VGVPoBi6VniBDTyzgAlhudKJRboyO2LLzALP2PJM3zZqAJ/grWiI6Cep4aVeKNM2odExb/01bKrMNJsJSH/5EMmJIQ3FzoG44M9gz5/FXBwJm/jfM5hzaEu2H3bFTVYhXC2aS3HZFFtR7A/2omQcdGLphCAjDMRDQdP6LCi3/bjBA8CRTr72Wxnc9j2zmrliUVHh+2K2znEWAvLpns7zbL6ypwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4L5nhkZOTYqOB0+F6HrZHK6EkgCCKf1Yjm9r5Q/VWY=;
 b=DUmIznnDSyEK3KC4+HpIBlqYD/2ohBMM5sDxkQsYP1zvEawrf44tXb28dDru5qsg5oiHKPGmpwxRzDLAhmDuux3SHowoPyf3DY5JOZyMxmSxVUTG8KjqZXC8+NSbWp3xl4FLGfduqihETK1vbcx67bxF7WR2A1S2I/P8be/BTSfxYh1/89gnXP3Vc0KZrLzaidMaZyt9DTPsQ/kskUCG9AVXhun87zt2iw46gP8ifEJL7n0dnctcNU42fjdu4Urt0UCGP4/p5vY+Tjhe4e48KxRHYzxJE48Z10Pc0JagxJv5biq2kzYnuZ/Uo/X1EO+sUNSdifQNQy9r/zKnblaERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4L5nhkZOTYqOB0+F6HrZHK6EkgCCKf1Yjm9r5Q/VWY=;
 b=ygSMeET+1JzRSlz4SW3qMt15wOhVdoMKV3n41K7NqScBzSVuO4oWznWQ6GtESilZUvovJslfBzEaXLl3Eplg0EmDqgV3slUzZqlTSQ6Giu/5ywV5RCLH9YKS7jHPl9ImQN1lXoplUWNSb1XuJGM7dyif4Woiy8mwMN/T03j4os0=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:19:42 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 14:19:42 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v5 3/6] bpf/verifier: improve XOR and OR range computation
Date: Mon,  6 May 2024 15:18:46 +0100
Message-Id: <20240506141849.185293-4-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506141849.185293-1-cupertino.miranda@oracle.com>
References: <20240506141849.185293-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::35) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS0PR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d97d6bc-cb7f-4b83-b8d0-08dc6dd7925a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+XinQioeRRXnJb3W3Shf3hAWSeRyByj3JqwL+UEtRZPaZYrLe4I1/4bwGzim?=
 =?us-ascii?Q?It3ddicLD5dZOpRWFMnKIOeFiu+lXENhRkiZH0Ea1x3Ol/0YsF3yJNPJHkDt?=
 =?us-ascii?Q?RUhcH31bylOwCTOrvKDVQLLcsTN/YC5gtHuEX6ctaFVAaR24aRCtSVvywUfL?=
 =?us-ascii?Q?L6/6wEGika3p5I+U0rMkle+0U+n5qt+LB3sFspSla6LmZFeMPEXqA2o47nGU?=
 =?us-ascii?Q?TqlrkDcmTlBtlCQYn3KV9w1g76WpFnaSp//VxzZWt/VdIjCGVVGAysc7C4j1?=
 =?us-ascii?Q?hGoPqZDYV8d47aHoswbmIRz3p8FSngNqGzsQehMlk+PrpIEAelpU+mNiA7Zq?=
 =?us-ascii?Q?ZK55a8Q42FoU4H+r6e0nvhHnirapUW9ZcoBZMpYnORFOoPvdrAh13fg9alDK?=
 =?us-ascii?Q?r08yozNCiXIVLt4s03wr7t/HchspDKkOQUrG+iJtMTbwiNzMAofPGeP952WO?=
 =?us-ascii?Q?lA/FTvjUzE76G1qLCxNob3pWMjObpSAspsaZ4c3m2yRHUUK6Ho4PjibBMJLe?=
 =?us-ascii?Q?aoFYG33xrIzwGsvC55WCIevgFI+WquGjsLlStTz/hRZSuqn42vUg25fApM5F?=
 =?us-ascii?Q?wpust1pwfHvihIBU88CkXchj2RLiN6/5sAvTjUu+5/ABX2sEPSGXZMjVORBf?=
 =?us-ascii?Q?F/W5v2hu3HiIMLr6PSAdBy41H1nx7EcJjib9IBsMsC9Cx80yKWG+gQxTGtTM?=
 =?us-ascii?Q?40htYtVaeFHjFtIOE7tZIdVoukKPcR1FC2ig/DZq1XDaJMdCLEWDGSjF5FAa?=
 =?us-ascii?Q?a6z2Op3O3Y2WQYpB+ImqcrPyUHigjRuNyeYBrreApxnB/F7g1yqfdDlM1397?=
 =?us-ascii?Q?4x6aLqjepDNxgNDe0x0dAugmiZ+pYE/QtfFYAaSst/iy6sCMWnqnKe6fvIC/?=
 =?us-ascii?Q?oEQBUzYuW9TBwaCUY7M/sz5vtWLHukq+i+2VwQRPdAUVniUiqEKr0zMVF8RY?=
 =?us-ascii?Q?5tpYkz/EPUboc533inXIJ1ezX9Ej7K8tcdcUwj9EdmtHxkmAtg5BA01GA9+s?=
 =?us-ascii?Q?lc7BIuEKFA35jRcQVfZbfXo4qHWoXUkFQjgpiotciHjDVFVYlXi7mtNDk7Dl?=
 =?us-ascii?Q?dW24FcWLY5ALPdIJFvbU9kKM9ocNyt39R+8t4sZlfpo5JhYVa8qyo7/uEjtv?=
 =?us-ascii?Q?ok/5caSprTkjhjflFBhNMvArcj51+EsQmAZO235JB/MDQxHtVnz5aDwfLhnt?=
 =?us-ascii?Q?+mitwRV6AOFXYyXS2z6zHRhcizm4JqO4WsKoga8eyyYnc1pw4RTzjg0KgSXY?=
 =?us-ascii?Q?m9G5bsLzCLtw9aD/CmVj4aHC5TkncEBhQEe1CGNa8Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ijXywxGa1oM+Sf2o3YtiMY9/xVDc4S8R1Hz4I2mn40a+ORo0y0tffFfhYlYU?=
 =?us-ascii?Q?ujhM9l9lANVrUVMhBf0fyQZRkC9sToSMku0l07wWXpZPK8pYMso2wfOz4Auf?=
 =?us-ascii?Q?vcWxPLLXazZ5fqn9ie2fIdk/w1cVHVeKTlSzLG8nP9v1OSs2GvwK3hdJlDWo?=
 =?us-ascii?Q?2+Y3w2No1pRs9NzbK4yfmJJGdGtFWzTbJtQGfYMHbpNKNvN3NoTxgTk+w10l?=
 =?us-ascii?Q?BtZSiCKeXpmJEn+1JP5aid7CJg08gXmIOxO7Y9yeLnajYvmUhCyyaYKrLSMp?=
 =?us-ascii?Q?BfCQ8KiKsixy1UY1vgJ6C0qaycGDIFdXil5OU6EYjboo83jq4Uhjg8fA0KLY?=
 =?us-ascii?Q?4cJOKK9rCbwsLrqysfJ2QNJ0nMxe/QG5uW8TcSnUXldmuQbf/y1CeIBfwfaa?=
 =?us-ascii?Q?dl2IZvfUqRHH0ciskL9uK6IuVO/JVBPzgHNDZRylvTJGG17vVNVs2T0PiCCw?=
 =?us-ascii?Q?UWH81rKGHrbPc33v1oScPHFw5EHuZbAeNuemvlhA4W/Twri93yqw3aGM1uIz?=
 =?us-ascii?Q?xLe0SN/NpeOBxoF+rmdRsa9xABDbNGxtllWt1xY7S9F87JELnyYAqeI6pgYm?=
 =?us-ascii?Q?ZykpfzsfptDxwtn5UqfbYygzM4ZA34swuCnoSyx+m6nhmUAGlr60alIkrv/2?=
 =?us-ascii?Q?V70mKW7kCwGHgJWutpAFD3GCCWG3araT+83DSRTwmACX/x6+0t2ohAlBaXnG?=
 =?us-ascii?Q?enN5B0sko4zK/OFQWvtPl/nNdnvvt1bhBL9o01CvQK0fbpsQ7Gb+o4dxvUXh?=
 =?us-ascii?Q?NdOKa0Qm+rOtbF5Dfh3ssCl3HLHGiodmBO/aW8FGPZtEVOv9pYQPKvopkEVk?=
 =?us-ascii?Q?wve3kkwLtO0nSs1H7X4JH3ev/XRJ+7ipRiH2hE0R5hdwjyqBqoEFYV4f03KE?=
 =?us-ascii?Q?oYytyCxSaRB/jf5Fz/DPBobLhCUR5jK1wRNTIYeAQdhJh0XB/GG4k9TMvE7m?=
 =?us-ascii?Q?8rSgrc3UCsGS+PLjOy2RJsVOyrDTL/9LxCa3oJ1CbGAgPjCnF1hZNX/7+//J?=
 =?us-ascii?Q?yT4n9Yf3SMzEmxqNcVkfKxeE8cbY82ztrxvViE2Posa2tfucv59LlJJ98cHe?=
 =?us-ascii?Q?xAU3OzGWP/SHe2nI0pBd0crbTnQitoTHCOKtwi2ULvb/e578KDePkudHxW0x?=
 =?us-ascii?Q?LXQ+Wga4HurZRLqRvgEMLFvE4FPhaxKknd+GURUiEFeWiniu+ZSREubpLznd?=
 =?us-ascii?Q?qIn9smVbXGaqyi7AARMBr1fhOEPxtSRfFYTS+vHMQ5rR5nTF35ANSyfvaBSW?=
 =?us-ascii?Q?pnvfhr2b0MF+eTVeRClBDNaeOGsEmCGSJG8SSpgO3BFmONEt5regQ+PghIN0?=
 =?us-ascii?Q?Wu7nfCWqE8OQXOBQy8frwTkHKKZBlxwcSMQsTVr73GQOSC3AAVQia9+6hfKW?=
 =?us-ascii?Q?Dyz/WDoTuI3s8spOzIgPmdKfAu7F/LL63GErIXbDkGpQbL7A/Tzrc7R7Hwdg?=
 =?us-ascii?Q?QPgMkaI2EdK3C9vUbWi5MVy4wc7hx56Oz3NhTB5v9ir05Xd5psjgcyHbdGkl?=
 =?us-ascii?Q?eoPq3SAbdo7Ggex8B2YYvFtLO35S/OKX0IYev6CnhjGxlZRI4DUh72FyCS39?=
 =?us-ascii?Q?kvEfJ2ZGlP6YcnkAs/ML11N5yllOsGkuHKlP5Z9Y9OCsUlW5cut2elUbXx+a?=
 =?us-ascii?Q?d72VQ5q3asDDEq1ZBknrnWA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pWg/QEzzhMAx/3wS+o4MGOs2c69F9TTgVyam2XRYuRWwj7bVJ9ho07fUoOXnAbj6JvKHqH0fc7sS7ISn69zbsse2SDXR12kP8SdU7oDWkft6ZlxQzdu0mRYnrPNnRe8yZxEdxTY7FzX0KM4yJQ1YmRku1smPvQQ3TxYQ6LS6Z9EYoRSKeb9Ag4y3SHAwjPDRdQrCExuv0Kp2GbSaUpO76pON++wTsoGE1mpI21g1Pd3j7u2o6HEGAS3Q1XZR2cjrVjn3S+K3faftfOCp2G+Hc9W8GzF8/jCsPYvkYjDJibIcj9DeVdtrc8Um5X+2Rb8dT+KyxBm1oz3/UTmpkMxE3p6lyKEu1Slgz353pgC1p2/ZdUdbitdOAjJcBQa+Zg0L5ckEy48sandyUkOME8m445SVrUM/ipV3FvotS4sFYHKZC21/hcvmsCP1iHhozJVc+ME8Zuhjkzg1XhsqvLqLENqaBjOxX86yVpt+3x/IT1gCAHfqSHANRNRub88ZdTu6kfnl9I1bzcp7D1MPJowp17QNyBVsNuAVbIAeWQnt4CdIZthUcKH0KCNsjhN7j+WcgkWSoH9TtvaWppqOjhBE+lTHvSJnIdw/I9yXPzyjLRg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d97d6bc-cb7f-4b83-b8d0-08dc6dd7925a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:19:42.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnMBxbTCf50mHZvND/8pGUNJqAqIMfeKq1eLmgXAKIqJ4JM/bCU5FRDYUVWeKNG/NZF+iAmg3zyd9j+ohFbmSMPR2WIvad8W8piyaM8OA68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060099
X-Proofpoint-ORIG-GUID: 7BNvRwMDN8AVvc2lAyXkxC-e-SJNhwA0
X-Proofpoint-GUID: 7BNvRwMDN8AVvc2lAyXkxC-e-SJNhwA0

Range for XOR and OR operators would not be attempted unless src_reg
would resolve to a single value, i.e. a known constant value.
This condition is unnecessary, and the following XOR/OR operator
handling could compute a possible better range.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bdaf0413bf06..1f6deb3e44c5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13900,12 +13900,12 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_ADD:
 	case BPF_SUB:
 	case BPF_AND:
+	case BPF_XOR:
+	case BPF_OR:
 		return true;
 
 	/* Compute range for the following only if the src_reg is const.
 	 */
-	case BPF_XOR:
-	case BPF_OR:
 	case BPF_MUL:
 		return src_is_const;
 
-- 
2.39.2


