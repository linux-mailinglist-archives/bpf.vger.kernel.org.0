Return-Path: <bpf+bounces-28826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2F58BE45A
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 15:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2D31F2797C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F2316C85F;
	Tue,  7 May 2024 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZOA8N7MY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OpxlVOMW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3D16C84E
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088732; cv=fail; b=u4x4w2EQznjk+QWRpf59puQMdwAFE+y3dHFDaj6HM0FK7rMMCA2kCTzGhTxCpo3mNmsSQf68fH2GD5c3kts0E/lQkCoAPK/f5jm24oWbBnO9C9bzL8MvEG9pFM6YcSoF0JgTFuLJMsoeUZCCxcmkL7Fp8TYF1N16R6hLCPMdYHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088732; c=relaxed/simple;
	bh=HNAPzV4OJWFowQpEESptZDqWxW7ZvIKnDIF0JTpaCzM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T0xFQWbTKXxgu0+Nmi60W6l2nkd8KbQ0khDsFfpvWvA6rnBqK+TNWOUkUblVkSuRdFolbLMT+cR0nA151scXxOAV61FQgL9pxrlEXW/gcV+SgYsjNtLkZeFbARpwEhSRQ5b51jBSbpotWn2RbR5507dfQ2ftjoje4TyXx1X5qPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZOA8N7MY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OpxlVOMW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44794O3P021749;
	Tue, 7 May 2024 13:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1wg3eN7KOU7gzqpHP5Xyc/R3/mC12SoJQEwmQo6HrKs=;
 b=ZOA8N7MY9+PjJxbx40AacrNW8Hwlvy7jRbUXeVuZYAKwKpfvVS3tUycDqQMW+3QwJGNY
 RuJAJzGWY4JjGAWrLrN8y2uDcdsEU0RXY3Bz2Cvu/HRE9k5WxI5LHWUMePMaEjlCSZTP
 r/bL4mNUXt0vU9AoULbGi+XhA0tthqouCaYn5JiJFI1PYsXDrCJutnM+D5MOv0XUp3ja
 +ilzBsRZcQAH9ucAnjmy1msmdClPPa1TjB5ZtTvX9fvzHQXamLCi4JGMcmxNabu3hxT0
 JTLG9JQa9WdozYK4IcorCcWEfvz+kaVT4KHxFra8wOiMs5KzF6LKGdq9gCZy3JeJ1x/i Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbm5n1c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 13:32:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447DGNMI029401;
	Tue, 7 May 2024 13:32:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfd8bsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 13:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXpiw1WislAjWZErneWfFrSq4V3akR7ghtgNd4oZADH9Nh9dgi3SZSCfue/eKVbNm2xGnCQ1/jZt7uCbzqAtm615L+6yQTEpLwsHv+9UAnLTAWb0G4LS4V2Gt56FwVyqAHFd9woGuWMB9DP5RO+2MCOSpYXksuxjGvIqoDMaMIQPKik5BbwNj94P3iJPQKclhJ6ReZrUFl00GiOutgTLKohvbr9iMSNu9W5LqGsPOyF0Sv8uoJK7iB17WR0y+fb2Z4pJo4NB6fymSsVvwyEytIQy7r6V/6PGD019K2m7KsW+lGFHQCye3gKIkVMtofmRQsnfhh8DMHnGxfuKvhbDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wg3eN7KOU7gzqpHP5Xyc/R3/mC12SoJQEwmQo6HrKs=;
 b=AbzJsQscg0u+Ijv19mMkjqnxe5EvjCe1dgxZ4moasePwkGLKlj0Wid2Q5i1X+CX0hX4iFkGcysozfaul13B6LWQ7VxpNu0ltJWfTJLZlfueIzpz0YtmkSw0s/lDYwGLZX357Mhc9dtDhSnCeuZxO0XMVbKdQt3AtOZNHDGHFVqhzlt1LObcOOPvFpGmXw4kf3+lRGbQRc4gxVo7CQ4y0otWQnAiiDMoZ6kN3p6nHkUQ3egDgn0Uu4ocLI/uBrBAqvQM68r9qlvrHVvd/o5RFvHiMFajggnzuTAFAfC+56KSimcsGrzDw+8KvDVHM9lUmGuXQW1ZqdE8ROqXvZBkbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wg3eN7KOU7gzqpHP5Xyc/R3/mC12SoJQEwmQo6HrKs=;
 b=OpxlVOMWCUPMOyn4PGUnKqVWQrGj1mHrrODKeY5cTJq5IX+FKQbs4LXB3AGEdj/WN4KBtSwOL/GRWgzdMYHirgctUvq2EG2g/vt1r8oPyZ88xHKBuL6XfNxqw/nvImusv2hCfS/RyZyp7s4/nmZH49Ulpzft/vm+vOxvXa0nJ0s=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by DS0PR10MB6775.namprd10.prod.outlook.com (2603:10b6:8:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 13:31:58 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 13:31:57 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next V2] bpf: avoid UB in usages of the __imm_insn macro
Date: Tue,  7 May 2024 15:31:47 +0200
Message-Id: <20240507133147.24380-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0033.eurprd03.prod.outlook.com
 (2603:10a6:205:2::46) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|DS0PR10MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: cef12a95-9f62-4dc5-3f0a-08dc6e9a110d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?P/kXOEC3FA/IAigAaIPEQz89znecWnqxXWWANHJXpX5K9f5ygsX++WaTAxXZ?=
 =?us-ascii?Q?m6tI1O8k8+g/SSSvOwAPRNlVGnTw6qtYiGFSeyco6iSzCdQyj3s++YjGSetD?=
 =?us-ascii?Q?L4CrrjqfLq1JGBvtXGKkUtcfLP6z8Nvm5ienFEh5VPP+K5pGJdNu/huOUcqW?=
 =?us-ascii?Q?Gw5oDu0IBabvrLk8sDxKtlnwZ8C08D6+akkKuevtI+IRCjj2wLtUV97sYljv?=
 =?us-ascii?Q?V7POQlxHJSWIhBi8AS8T3n/NOo6nb4JGKN9CRzHJpn2rC7Jb+8WICPqJfnhh?=
 =?us-ascii?Q?k+1QpR/iDaG1oMdBH53NvpayO3Wc4scNCfOZtmp30m2iXZX8JC6Y0/BN0d3O?=
 =?us-ascii?Q?5OHdUrkBNsOhisHByqzrJpY11xIs7mxgUTVFXWKTmIbfwYpEDlVXQjvMLev/?=
 =?us-ascii?Q?cKm6B3r9vldfR7N1qG9Ot/DsQtfdTxqcHgZ7OCjNYfCjft389WY1nVkTcr4R?=
 =?us-ascii?Q?Mktcd0P5b+8kY2HO9WSojU6STtBw9PLQnpmE9oAJe+pRkD7rEuim1y60VJhd?=
 =?us-ascii?Q?MUxMWLmQZucEo7nnVrso0JAQQrqh3FUW3jTKfHSmHQKnO9bxOz0POSs7BNn/?=
 =?us-ascii?Q?tRgBhlW0InmVmZVJXZhf4d6/EktVqioKqc/Dc5BtPXk4OdI5JmxlorertwIS?=
 =?us-ascii?Q?gNsht2DoOZsR8klKsOAXm3+waEJdM3uVme2CkzAmhxeBqiBBn3C8pWLwblOO?=
 =?us-ascii?Q?4ojgvX4sZuGSChY835d4oYJk3EKU8IpLeJJmY4vEbOsiVMFxAK3GGuQN3UWd?=
 =?us-ascii?Q?vmggCK0ByHFMhTDwvohhnjRL2B+zRU6AA7E0u4G8WI22vsXt0SLvQzkLawHJ?=
 =?us-ascii?Q?KYGIWphxNUr8h2yZjPcXyMg1HIlboDpEPqHRXytyvYTPtl67nFYWL0siv1z+?=
 =?us-ascii?Q?gKgbf7Z945NNDd15QAs7Bslkz5PSZ3shnbrVVGv/BHpHwGWxAD1icdnP0oNO?=
 =?us-ascii?Q?hx7fHjiYoeTlrBleFOIUfn0IUJEAvRm7jBryQoSuSttUNjwf4WqmkRbye8E+?=
 =?us-ascii?Q?D5ZsNqf5TkBOGsN6HYfTJtwLv11tNqRqSjgbnm5wCUYFOEfQ9RW4iw+FQNgW?=
 =?us-ascii?Q?031Yn2wuB11Y+HcpuurZ2kgNkyQxDL7WGJPrJMuzFiHr8zDpDXUEU3Xvl2bI?=
 =?us-ascii?Q?iYH0sAyJMljbVkgu9FjMhAzhKPhpK+wn+dNucym/+oWwGx0+at28MjIrY9a9?=
 =?us-ascii?Q?z5jTO0i4cKlpvZMLpjiVWwY/grNIIiE89Ab3A2lTUiQdFOpfE44lnZKmuTH+?=
 =?us-ascii?Q?O4HTyDEg/GkdV0bdoBWbYEjqbEskAGV3ZdHk5TFTaA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sXA2Wom2q6PNGVGERz/PvXno1/e+2HTuHX9lA5A/IHUnBxxBxbT3NmWP4JJR?=
 =?us-ascii?Q?0RyAxmQhONNnBjF/ieOv4W1DOtrOE8zXWTmYyBgvp3to8tiiCYemxQFwyk9E?=
 =?us-ascii?Q?Eof3qR3FbJYzpvJYztQwfkIbJDHcVJ+bNlqUkbq8j60A0g8KABLt1eUmyZZ9?=
 =?us-ascii?Q?hbdgjjwHz6eMhUHUV/AbVUjTanAyKd7YiUZfphyUqJAlU5/T2KogGQHmrqjE?=
 =?us-ascii?Q?Gge8R9GDLzbAe7aXDR8hQPktHQhijyRekj0HUx2N08m3HauQEdkv8jifATZH?=
 =?us-ascii?Q?MtbvIgVCwxK11zirv1/xpFgtjwL7alD2QKxbElowjXj5Q4PICmkVOAR0Ie52?=
 =?us-ascii?Q?CR1VQISa4EVjHOqz7m+S7oZA7thNDNbnkI/ZW0fph4WvPRk5HVazLSSdIu55?=
 =?us-ascii?Q?T00JExZvpefEABCyFwDNguPbkXSGEZMZ+f3Kct9GfOmtzso0SEH1ICAjjZIE?=
 =?us-ascii?Q?q0gE50ESjP0CO5sI1gLTJ/VBXLDDhP65SeZ8qtnYLK46UC8jrCnRU7T9y3sg?=
 =?us-ascii?Q?LbZG8Qu5dEL5r8NxeL9RPS3/QVXJBguEcFTIs/J+u8Gk6BFzv2zmXHZ5pey+?=
 =?us-ascii?Q?G3C3FMwFyEW9xwJJpQ81sjUAbE+gHJrbu+8MNdmngTibGv/xWZPAbnoquTKM?=
 =?us-ascii?Q?MLM/WRBwakRQcI6zcMQXD/rXvNHCXk3XJb7EnBeIrtj00K4gvZTOwn2wLcGc?=
 =?us-ascii?Q?PUGwmYJDQvJVLTK0KupRdlSE/1uWqN/BwPZs4EGGeHQOr3gRbJAiNN702H+/?=
 =?us-ascii?Q?V/gJ/Ze3+jz8k6r+OyuFQr/QeiQiM3tct8a6p9ZVlWE1K9t/oUz74svg8cs+?=
 =?us-ascii?Q?gwH+cNjkLVXpR/fJ8rfg3B2Ru0HMtufOXqR0vlYaFun3l51NhZCiv+NV5YV4?=
 =?us-ascii?Q?DJKWF2hAKH0Q8oeECyFIMjPUfpk2Cc5heYHbGrqYn2MA533WRnnw1l5sqObv?=
 =?us-ascii?Q?7z6DmgxW5JBocs6oy8x42CIl2kF37heMU5kL4f43cB+Tq6skDwtrqALVR7gR?=
 =?us-ascii?Q?xglbilM39e9tX6znF0dtae1ICq7X6pqULbPTq+5QOZmWkuUuMf3ieqoN7Xs5?=
 =?us-ascii?Q?22zhf5opxEkHr9MLkxs8rZY9eSt+gQFOarGBaCYgvMcy4RaGQif0rLje4bPl?=
 =?us-ascii?Q?l6IRP89Vh0EX2CoSFQEHTgE0lSUiQ5vySi1j2eQcrbQAN9dORuiAmrCGRMIV?=
 =?us-ascii?Q?4NyiC9TeCAt0zhcYWkoLLzJuZgbK/5qTdpVV+0+sxJBfuFZU3E5JQVTsRRA0?=
 =?us-ascii?Q?3E7WAVfsYUn+QKhwpmhfXYAVfwmW42OkBtub6WtG7jXXQ31g6geRwvktVj3n?=
 =?us-ascii?Q?F0MXcr0d3Pt7KucUEFPf1Yv0ADsIrNefxT6juWCSFHX7n24PNlH3b2jA2ayX?=
 =?us-ascii?Q?H/5BGN4vLtT4/4Fz3O0b3rN58nb0Yprf0Rw+9DrNAMpZtHAD7xnVVpxmsmXC?=
 =?us-ascii?Q?bNZcf08sNPc0ZK0H/M4tJxmwMKxhy5guaAXW8cc3rN/vfZW0vwNhTjbcxl2y?=
 =?us-ascii?Q?gHM7RgprVWLG6EOCRjq+iYNg8li/jHOvXTLXTp3gztTW0w6tTYzKXCbR5EJS?=
 =?us-ascii?Q?3jNdPO/P0aUSVDzey8kTOCpSUXG9ZkNbWsQ8ezC23B0P6IL+zodGBDcHqzpj?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	m8/VbBistXuAKj3KR16DVy+sXHr2fV0fT5K4vfb4qT/5ajRjiQB4KgIzNl0VBSE69KDjscWJSExKvYYKCEoWxLQIZuIlRUqdGG8vALor74rf6S0S5vukLp45eAyfHTT3Pghkf7LsEPkhOr72RyASG9LbRHnW4OI57RCsPNOfz1WhskkEeCsb4aEyZolg/nbww+3U2nJTki0tHzcHm/OQNTnkV9WiK5Oz2vzjWTHh9yDw0XJZrHWNvkOE5oL9IX2NRnzAQyPxutnxjwyL1R23hjpD8N1pdJ0oHHngN48JILlKeD4s4NpTRjyh/KsrnpCRr8oo8OfKVt/yCwneFD7cMIT4r2j1FPKllibFlE+GtoZtfKj3EGxmS89wokPe/FG5zazBeB4kcZuV28hPPMDO3/1TJNNIvZIG+ueS86hoafnSVNrbLl/VXT0AkHWW/u31KHzXJ2GXoOg2DdJsni+Z3XqFtwOScpNsFzXakbxA6VVh1VW5ISPzq/m8RXjhNWjzOJNrp5dm5FWpuuc4kPYFfgiZFGbH18TmCumIg7KAEGsPWmEu4IGYDhZgDcNfpF/INth0i4RBaV5egUBgIDSU6gUliFmIcwVM8FLp5ZmWYkw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef12a95-9f62-4dc5-3f0a-08dc6e9a110d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 13:31:57.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5bCkFes4Yx6kj5Yli6l05zDRl9FhSNzwcOH/N20XXSC/JHX8RpDT7vPsNhUIOic93MkCLapEI+l6/0a+am7B6qgbTx4g8QWKVSzrX0Ef+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_07,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070093
X-Proofpoint-GUID: AQa_AGZiljdCwBD3B78InImUKnt69sho
X-Proofpoint-ORIG-GUID: AQa_AGZiljdCwBD3B78InImUKnt69sho

[Differences with V1:
- Typo fixed in patch: progs/verifier_ref_tracking.c
  was missing -CFLAGS.]

The __imm_insn macro is defined in bpf_misc.h as:

  #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))

This may lead to type-punning and strict aliasing rules violations in
it's typical usage where the address of a struct bpf_insn is passed as
expr, like in:

  __imm_insn(st_mem,
             BPF_ST_MEM(BPF_W, BPF_REG_1, offsetof(struct __sk_buff, mark), 42))

Where:

  #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
	((struct bpf_insn) {					\
		.code  = BPF_ST | BPF_SIZE(SIZE) | BPF_MEM,	\
		.dst_reg = DST,					\
		.src_reg = 0,					\
		.off   = OFF,					\
		.imm   = IMM })

GCC detects this problem (indirectly) by issuing a warning stating
that a temporary <Uxxxxxx> is used uninitialized, where the temporary
corresponds to the memory read by *(long *).

This patch adds -fno-strict-aliasing to the compilation flags of the
particular selftests that do type punning via __imm_insn.  This
silences the warning and, most importantly, avoids potential
optimization problems due to breaking anti-aliasing rules.

Tested in master bpf-next.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f0c429cf4424..c7507f420d9e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -53,6 +53,21 @@ progs/syscall.c-CFLAGS := -fno-strict-aliasing
 progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
 progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
 progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
+# In the following tests the strict aliasing rules are broken by the
+# __imm_insn macro, that do type-punning from `struct bpf_insn' to
+# long and then uses the value.  This triggers an "is used
+# uninitialized" warning in GCC.  This in theory may also lead to
+# broken programs, so it is better to disable strict aliasing than
+# inhibiting the warning.
+progs/verifier_ref_tracking.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_unpriv.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_cgroup_storage.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_ld_ind.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_map_ret_val.c-CFLAGS := -fno-strict-aliasing
+progs/cpumask_failure.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_spill_fill.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_subprog_precision.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_uninit.c-CFLAGS := -fno-strict-aliasing
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
-- 
2.30.2


