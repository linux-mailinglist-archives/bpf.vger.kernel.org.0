Return-Path: <bpf+bounces-28172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD548B6488
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2771F21CDB
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ACA1836F0;
	Mon, 29 Apr 2024 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nz7KRttw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B/6BmsAr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4411836DD
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425840; cv=fail; b=EaiadupCHb3JrYZMqLREYcrMo15xsGAEf1mVFUtnvEQH3jFCpmw3R0nr87s3kWMHuhLmI96pCx8HwP5GtATH0GyjWykMPUBaI4iXE3GSJM/ET2NuOP318zsmyXqas3hbTm/8VWE6Rt88RE9lPtiOQQZBwOHkAu4fd5lqe3Qu8Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425840; c=relaxed/simple;
	bh=ISPL6Lg1ynMpnrXxgtitBcGsWJTgMwcCFb6xuQRBFvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dxk68dZ+07nd6E1KcgSXGCYw4n4nKvfmlnqO387+Zp6vwcKORHqB0nyKOfl3UH+jzbEsHphLvhY/4Yl6T5Z1ejfSvIv+UDxm29Fh6Aac2glTnVnNXNxY4RbyqXoCtllMgYKbpNxblUTQzQ9ssW/1jx9GqOOFJN1+m/P5tkrdh1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nz7KRttw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B/6BmsAr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TKFdeb013366;
	Mon, 29 Apr 2024 21:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=N1piF/u0s7OMc18qEZmRMNgXZ493eeKge3rzu1Dejxs=;
 b=nz7KRttwanCloYJuG4EN0Mr4wqw2nQE16ipk1GK5BdZwmJpm5aiuKvhEBJlmdzr4DEPx
 9p9ZpzBL61jxgQOFotS45Jc2aCL5VyRTndmJfieQRZrPOCiCs2eUcNSd4VdFx4H4AME4
 CB2Wl5zKOmmELU0rByRMAfzIjZ2Z30aTo0TK+K/2mmw7aji8TBgasQnX75bXFV0udGZc
 gKavmFxpG7Nxk+cTVcFVnKGrmknBR0IsHkmuzEfnL/8p4lbEeGyRCjL1i2tvAm2he4ty
 4Xu12a9qebW7Uas1APH6w2ImkDGjzkDj87FNjubUH/lZIpIHfsOKIszj1zHK5zDgOzwE dQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy2urks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TK3Uv1033171;
	Mon, 29 Apr 2024 21:23:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6qyk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS/KJrkuqs3p4TkVlsDBJr6txmiyWfsjJdH07dshXiSfF5hjRdcRB5gKq59QBtjG1gUSMiOTezV9T/8uJxO5rITERmsQ9Yq84bv4xsEsTfeyhEmOcbT2XEIjfMm9kHsq3d0AKaDXJrxoI9uIcfJ5I2u/lLQghHJKL5/6Os0y+qkHbDPUF2WsnXF3JQFiOJeOWmzqD6lYdOoOc3pDnSO8h1ly12floj6qke6T/yJRtUvFF5TTys9LOsKNNpjAPcIcgWa3N5zMa3oI4taeY1dbLSA3cEy188jImPK7znA0hwGWaFsHmirSiv6d7+OMlu8qlUFi1wj1dD7Bc1vFKSblsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1piF/u0s7OMc18qEZmRMNgXZ493eeKge3rzu1Dejxs=;
 b=fAFfQETEwjq5zKfNSr/TrHcOYIYHZz9qpwALK3vqlrhV7yj9T5jbuNYm1qX7wXMln12w7rtRHSpMF5dIOin6AmHIt5YZrQo9LRjpc1+Bsb4FqqlLT476/TIp1CKOqJHrq2nmgC83cYXbGEUn86Rkvm66EqWQp8KMu5UX9hhFyiCpT0NHSjpYgNjbF+Lc2+o+lE3jz2HY8zkG+6fkhOoYdTOR0TjokFzH/cLlTY9627p3eoqepk7lYFDHrK8MstZ3M0YfWpxYNzfl/KsltQ6HTr4D74kcs5e3JrxlLLpk3qYZWO/HMIxOB+YB7Bz+r/da33t1AQfQ19O6f4877Oyu+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1piF/u0s7OMc18qEZmRMNgXZ493eeKge3rzu1Dejxs=;
 b=B/6BmsArFJQPWxxPKTQwDNsiVfm8uRf4VPoxqXMgTIgjHV1/C0+KduBKEwpNgOS53nZ+o5/5pNnaT23hI/UhCywx3Xa7fNLGN5DVh9zJt/9V8ckZPJrvVcXQ7xi5XhUO4q2V5jZwGtG/vuh/zVuFETGnahAKPf7xaF1seoW0el8=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by IA0PR10MB7232.namprd10.prod.outlook.com (2603:10b6:208:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 21:23:51 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.030; Mon, 29 Apr 2024
 21:23:51 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v4 6/7] selftests/bpf: MUL range computation tests.
Date: Mon, 29 Apr 2024 22:22:49 +0100
Message-Id: <20240429212250.78420-7-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240429212250.78420-1-cupertino.miranda@oracle.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0050.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::26) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|IA0PR10MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: f09fe679-030d-44d3-92eb-08dc6892aa4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jZUbgwi+UZDXWNPXz6lrWcbtjjGbxJqJ+vhbR5HFQALaBnb3260d9jQ8O9Wl?=
 =?us-ascii?Q?JXTQ38KUB64gZmFxuhUqG5sN0NUx0OxR/mI3Y1zOfb8aeByfjF2pPuyFEVSB?=
 =?us-ascii?Q?TjhKhA8MJnPSD6xVyyWgu3O+RA14onkplkYx282yNGiI9FhbeoLQ9xNMCHUT?=
 =?us-ascii?Q?NAoMdMmGidvxMg7E2obzCMcyDKmKACPKchBo6VBNJy27FWQy5WIMT08Cpcz1?=
 =?us-ascii?Q?wlL8tH9iuVzCEb1hxp6pqHgrmxgYFj+/CyppVBVtdoR/4QsOYdfxFpcVZASm?=
 =?us-ascii?Q?AzWgikD00pGDXOKr99MpRNBy+ONYOQpCeyW5xItm3Ej6buhTD5tjSDAO+FpR?=
 =?us-ascii?Q?rKZP8VNjG6HYNcFrGeOuktGqXt13qJdq6+Km0+5i+93/oIkZ98yGIfHI4062?=
 =?us-ascii?Q?eX67Q0W5/aR5QL/CuBchYJkADDUMv55Lcwsfm98IyVn0JP5cJ7LCW/Gk4sXX?=
 =?us-ascii?Q?ACSyOLQebcXv1MzxwRR1cWoC71hK00nz5n9e+bRIEEAndXxDzbngmQXDaqr1?=
 =?us-ascii?Q?zqxq3dK+xkoRZkonyGk1YfXl2YXV1TAMpnAYq8eny3O5GQ+uohc2gOMcxJrP?=
 =?us-ascii?Q?bnPe8BUJrnpjcSoCCVObA53jT7nBL9BGhK97Egc7eBZunWI8nt3mVMt23/9y?=
 =?us-ascii?Q?v3cf773iDKnek5GPNWQ9cYzC4blntp4mIhG5ylMbDX/Ik/isD6VImMoq3gCv?=
 =?us-ascii?Q?cocRPORtuV/+SJEL3L43Dr9L6BsFVmB19nUeiWvV8v+6NVRQe1tZYLfyvwws?=
 =?us-ascii?Q?HYTjtfdgqJutAeER2xOtSXFIleAC1/89W5XWErN7jkx0iKUJ8nj0DBkOcGrE?=
 =?us-ascii?Q?80yNqvEMyFZCki7JbCfBrykqdhEjdAcWyr0A46xvZogKuXRDpchcDG4QU/Ma?=
 =?us-ascii?Q?UzBTx9VjQaTUfJ+k8dXWAXZ1H/jPUjabef+wSmNTJ7aG7QL8Vhhz6qd5FC3e?=
 =?us-ascii?Q?ot120qcSeydcQQ9R0iOYiIG+DXqBt/msmE0APSsXJrQjF36KdnWzPnnKQd6G?=
 =?us-ascii?Q?4v9vage2LpswGWCtyPW6WOjwM0Ytx1LPmu0y9EKIYeuzFy3IHIBBQXaaQUB1?=
 =?us-ascii?Q?/sR2BOU5Z0A3UL6MYSfpJaxmDUJIEumQfTeQuDfOLugyJLfZmCMFCpiZbHiq?=
 =?us-ascii?Q?0xdI5zUH+6/aJPIr+/lcdceD8J2G8YChVsk2dA76ClohshTu0Lp4qw1gGJCA?=
 =?us-ascii?Q?lZOxv/0Y3lCfpQy1JZakMWxc95SslnAVqeM95il3f0IVRl+6SjIvqa6Dv6LJ?=
 =?us-ascii?Q?Oo8KN7ABP5o7rUisRf3TeBAIhXuvHPleuGZ9NdQhMw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?A3HOgPtVKED4Unze0wrWsh6MW/MAPhgBtD6bLsGYGhZf8g1prP8su2aIqgaX?=
 =?us-ascii?Q?N1WSYv3fhif436cdYR/3I1godFi3zCSrsw8qsPF/B3lViLWig6wielUaEQpc?=
 =?us-ascii?Q?dXU2+x1ityQVL/brvQS/8ZUe7XBawJRTS+hkj4CDm1y5pYbl2Ble013m9j9i?=
 =?us-ascii?Q?l+s29MSE8gz0zb5OR2AdfHAZTyuYMT4l4JMJjh5z/vMDYw3+zufHjD1198wu?=
 =?us-ascii?Q?t5lYZats/HGGiv0hJk283hKM+8dIeSY8Eeg2G/Cvir464mUCH/ZSJPRp8WsY?=
 =?us-ascii?Q?EuzwOWjO+IHUaH+1ZMjzPvwnzopmcqV/aiM/p1+LlZUKPi6uxFi8FWtO8W/C?=
 =?us-ascii?Q?+0MCmgEHNIojGOGzO81YETrsQQklHRDp0tIrxocVLCV7ArcwI6Jy1MDCtKdc?=
 =?us-ascii?Q?mYzLNUDwV2ARmGETXSft6+0/cFhBJrCxfy5FiYfZUxFKTMMhBhzf/sofDyYB?=
 =?us-ascii?Q?aJIAJrHY7BNjvkzeLKSUCMWxnn+n/qNqUcIPT9ipC0g9Gfg4r9pwDrbY1jOX?=
 =?us-ascii?Q?91uwQy8fiBooSdKkJ+RGXiO54JrHzvORHQVgoe25LRmJNMioCSNxLOZctdiS?=
 =?us-ascii?Q?bIm49jElePNYFNGySLVXk6zkOqkBZ5/0bqLn0wSK0S1/M6S+IBs2VpGRiAa+?=
 =?us-ascii?Q?NKDAp9sL+PRaLpr/M4+JokmjR6nnyBwai9pX4VmVeQy1qy9s0/TqZsTkdLIH?=
 =?us-ascii?Q?152aS5MuaGI2VL8sbJxpqD0j+bi1eoQUBO1I1VpmzTJMaF1z+6ON45I/oYSD?=
 =?us-ascii?Q?Y1WMc7VPnYB6O4g/VRFQFoihf8N8sEtjXoOBRAQQAqCR75wRARsFlInqDJSz?=
 =?us-ascii?Q?mlcdflMXawC5fCbOSpM0lOVIq1nel2+3/CZrt1iNoRW4cKAYacllvpXGQbWi?=
 =?us-ascii?Q?uQyic8PGUsaZqWcuwYFhHw5lHgUw+WEOhgC6PWMOrV2vI+Iy+Vzdx8SK9FDU?=
 =?us-ascii?Q?f34aMZjLCJ/ccekrIcOtR43mPkq+MPHmF6pmVRzZG5DdUaFlEzBE+QfLHUfU?=
 =?us-ascii?Q?otj54R2bOAp1FNQEKdYfWGt4spewLWNtFWtuWtizr7hi0Z/3MKkG6sgjb0aI?=
 =?us-ascii?Q?TY71UavsYuKYsgynI6D/X+ZwCpSNVF8d6uWkqWBwrWvpw/J7dHJmfd7DRreK?=
 =?us-ascii?Q?Sf97WUxiQlypy0RE9HGOuOIGSDVFTh8uj0gTgdShilh2vZPF7JFle6uQl+/s?=
 =?us-ascii?Q?enZ/PCFWz1DOc4qo8uH0qWZyk+CkLS+VTPGHt803/FddvHV18isofr2KNyFw?=
 =?us-ascii?Q?zByoBlJ93bBLRa4ZMH1NKKTViRFkgGNKHFg4G7o0C5QYDm9NjjnkxZvdJL3s?=
 =?us-ascii?Q?HUWSKid9qFWleiIHC6yxMjf84JOlKCmefmByT0fLF3fx8/scrIKJMM9uf0st?=
 =?us-ascii?Q?9R1QQubgc8UHPqMJKFr8jDWtY8fEl31XAy2wZ1Utc6B8VCj9V2CCOOi2lZEu?=
 =?us-ascii?Q?2US7+Oz+Dk5rkyDiLlbcfvFqMexoJx9TJ/G5mMtR02UsC4jJ4DETxXboSCbh?=
 =?us-ascii?Q?kzIfPG1Q4zcAvL7nGQK8h4hXYP8mD2WC13laxC5+T03AmOEd2gUd4hDv4S43?=
 =?us-ascii?Q?kXgp4vz/12II2mjocIAE7qEDeWJNKyxt/hKIdDttEKCvy3zRenQFYNq3pTQO?=
 =?us-ascii?Q?GREX5zleejuXhaitLFmoFNk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Aa6fP2G/bPRTL2Am85s3czL/aZMNKVL5gwpw+XlMa2Ch0gBVmPqH5W0ArldDYzVoxneF6MwDXl2U6LjuVhN7bros4CDBYkSEcAMq92BT8lWUsZ9etC5mItFFOCjKeCVtqGKMQwWcS/r1ub16jsoWG40Nol0ru/0aHvc3znzksfd+ihNo+zamk/2OrIvFj70ixS3jOTK9rh+uLlYvdi9Dg68oB/BwQLYx2pHCp4Dji2uLEjKrIPuMne+eNOx5/iT4g14ZCPLbRRZc1bA7J+Cemn0ZX/4p2k3rB7Cmzs4FQnfzFqQV8iDavOMg1LgGG/1050qSSFlBjjOKI1PDhtGWemUjRue93s6+CuaHEOg4Bdbzaa9IpZJwQ910TvWWbsX3EojrvYkt/YvthWupiKvXaplWbS7C9ZXUodnh9TwP/+7tLNno3jzfBbGhyEDTobNN7ZqIJhP1TahFGRiDSSjyakSztSUFWPIeDLUcPouMcVlhq2x5oheK0LcDHby7ehsx1EknPo/tlvJqWUKbYZ4H7bSpviETNnqrVIt3mMEh2QmcGoqZaJ2dDgAbjrem6K3iZbZjfwDFWmWpi199suCoN7b1SRyz9YqE9NvjWycrSE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09fe679-030d-44d3-92eb-08dc6892aa4b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:23:51.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OK7/7iLVpcRyNPMQ8GBQWczPB9TLVwn9j5pvgb2+xR0musgcrw99cnoXMdrIPzeX6KjoVhBDkpXS13hHXCdoGxWzP5C/zu8SE9UldHEe5s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_18,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290141
X-Proofpoint-ORIG-GUID: LAt9vYmWaNkUyIcGADmgMOxMW7WsDtii
X-Proofpoint-GUID: LAt9vYmWaNkUyIcGADmgMOxMW7WsDtii

Added a test for bound computation in MUL when non constant
values are used and both registers have bounded ranges.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>

Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 7d570acf23ee..a0bb7fb40ea5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -927,6 +927,27 @@ __naked void non_const_or_src_dst(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds check for non const mul regs")
+__success __log_level(2)
+__msg("5: (2f) r0 *= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=3825,var_off=(0x0; 0xfff))")
+__naked void non_const_mul_regs(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 &= 0xff;					\
+	r0 &= 0x0f;					\
+	r0 *= r6;					\
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


