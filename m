Return-Path: <bpf+bounces-29166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2808C0CC9
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 10:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BD2B213BF
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ADB14A081;
	Thu,  9 May 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QlKT3KBI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gcqv6Q3h"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1F13C8F2
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244430; cv=fail; b=SJpUaAGIQ7b896bXW5m9PZDsJeOLdjCI/D0hJBbILlRtBwKrIGIe/3DpoAJyrs+GswbpCvrywSdH0UUKFpj2OEEOsr1Lu6x5iQcFmK7lI7RjOgcAd97rxRx2J7i2ORuKVCNqVXOP5bLVDzb0kuyoEIDF3iONPsWebaDuualQIjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244430; c=relaxed/simple;
	bh=5cuI7Ijl9/1IzkPR3aI2ECZxkZAflJdDfKXYRgggllU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E8UFEffJGST2y5N9oIsxXdXsNxuskxfWUtPg5QwAgja+kZUe0DyvxhDaiS0Gv1quf8KSZefEQfqJ3y5zovmcaUr5yg+iIEmbvE5CHgxiXCmZIx8xAj1nw1nV7sIUinnBHsZVI4erJbQn8CfE6zIadZOIfngNVnpW76YL6GcgYp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QlKT3KBI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gcqv6Q3h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4496o5B6015289;
	Thu, 9 May 2024 08:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=wjKsEH6isoYN5iJhmH6pg0ZyAT/AVZOsQkx4LZHP0pc=;
 b=QlKT3KBIgwE6EUgs3pryp6R+QzEM5fsYIpSjwH6ZrVs7HmTiZ4XmrCWehNjaO9NqMFFH
 /+HTif/cmV6u5vHUHWgI0jQNdlauml3R8hQMB9/+INEbNxgPYCpFZ4B5148lxSPGT/7R
 R9NXJCvxs7wFMU5TqJ7RWqDSQ5+/wmLXhXig3O7VCKGx/u0PYmVBHxONlIZWx+Meescb
 Mnpzo/uCvFj3MuixStsFD/4Bl4LjcHBpIayR++45tqZs8iuxyh2nWANVaZ2oOHZpNN8+
 VwMpBh8snmBn2vBdiGko/dd2+r2EXVcEpeaz6GFq1TSCkat/vGGxF3TfXoObmVZqfsH1 XA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y0r248dt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 08:47:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44987KqC024207;
	Thu, 9 May 2024 08:47:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpfx1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 08:47:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5ymUpaaByMbqqsoMLVi8YQbbPY4Vm4imxEYI7QIjjQS8Y3XIYeCBHmroDFbZpLs0dUQmxRHbdScQnOk6WH+1NCURGn+xXr5px0WA0qm7iHDigAnPhQOEd0yOLFZjrvGdWNR/cVxq0sCNTBVPB6g41ZCroQ4zHZFIOQHS6nHEUAPPu8kXoU/entR84mi2+rNK47Bxk9hfk4rwNFxZZqAbsR8IuPWWSPplPSQsKS9qqwu/no/HXdV3inXK2k/gnrR28wrJ4fVQ9Sl0yGL3VcForiBU/W4pMm6ovzlswM/rYLUd5sZrq/HTDRPwGwvP7xrteh5IPuD4RNFLQs665SYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjKsEH6isoYN5iJhmH6pg0ZyAT/AVZOsQkx4LZHP0pc=;
 b=QdDRRHT4Wejia4Hds+z0ou9WYMz/StfpB+MY531UV/6c9DOOWxSgE9ONEpleXY3xr5OBr3tb3rrVZDtpIkvDByqtrxI5KDG3/eOL+tAQPXDhwBkOSodC8aeNzw0POPQcjIWhbtqc5HyqjOssGUADjPAOkGWM1Lkn0+GrSBkdBlRiJIDPTITwlPFd/OKRyrQewxQZKBfvDm9Bgrb1AIkMPL8SNyrGaql0AWSZ6Lc9LxYwP6Oa9IJTyd85YJA4qpLJJu1uMuVffcxSQLHGxPLNs30jPMMJmEfMB4nV/AdIQ1jnDQ2nJN2AAcwGLsnUI5uNDuMHwi5MGxKGhb+/9RAyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjKsEH6isoYN5iJhmH6pg0ZyAT/AVZOsQkx4LZHP0pc=;
 b=gcqv6Q3hOE98uD/Puhg5XSxmREhsZKjQ37bBisnd/9HLrI4NoRFZf+koYoGbkDPs+sXFfLvE13ANHFjbhkQNt+BkpYIRULvSTImJ32+8r/zH4w/tdXE8SNe0ai4fHyTKFo2TAgGcwPBko5hBch9Q/zGwxXus6wdYvxYsNNUaO3g=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 08:47:00 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 08:47:00 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next] bpf: make list_for_each_entry portable
Date: Thu,  9 May 2024 10:46:50 +0200
Message-Id: <20240509084650.17546-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|DS0PR10MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f04a80-2f1a-44fe-7c2a-08dc70049790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2UdTcE9zcWTzGb9mF8PBvjEjokr2AGkLtyggw9nAU75w3exx7jpqoZInQ0d1?=
 =?us-ascii?Q?abc9kfTAMvAHtjVkvZW+HrkmICli+8ya3QIm8nwKoynoJo6q/HI89w1Kl5OQ?=
 =?us-ascii?Q?/2Ui4LUmA93MFf/yXuYebq+GrD3O+AjdChHATkFwie3E3PxdsepSTeDpuBuI?=
 =?us-ascii?Q?90FVz3l8QfA48aarmmiWqOFIbmSlQmj8PRQltuCM3L8QNk0fWNdb/FmUI3kZ?=
 =?us-ascii?Q?H3IrLi9kIF8JCY7xqLPbmJWPdW+aTS2bGCRCeZldQ7r2dDl7JnXwt8ETWkgy?=
 =?us-ascii?Q?XmRQJakk4mpDSvue1+8xajJAtzpAatx22795xBpndTF4mf6HhT3RfkklPqZ9?=
 =?us-ascii?Q?CdAWwOv93pnGuAABXUvFCfesRUnSakd9875ZdS4uSZFKp0/hWZhaUrQudUXH?=
 =?us-ascii?Q?dsrtSoxTJRePWQ+7ihFrxZQgTe4hchi6KeeaYNNJMB4vCBOBFAwS0GdNjYWj?=
 =?us-ascii?Q?+EPj+nDtfaKQoQ8BZR2HZqe8Vd2IBSToTW6BaX1Z39KLRvZHlGC3/LUQztb5?=
 =?us-ascii?Q?x7KTI0tJ5KZpbsdyDj0wEj3UTZWDuvTwSsQ2RQRb5QYf6qb3mUfdhcC4EgGv?=
 =?us-ascii?Q?0G+cl8r17odX4qsj1JG5XsOwmcI7IhwA0v+0gP5/uWg4J8JwErSsGWRQ/OZj?=
 =?us-ascii?Q?sOslVyu8F84/ax05wXie6omyS9JfySOsxvkf7ntzzqLM7fkQncFU8MhST7LU?=
 =?us-ascii?Q?7jprGzflz8Ocg4QKZ7gr+TfgD9eSFwtMb0JYaehegfVa+C8ZrQkuzsOFxHks?=
 =?us-ascii?Q?JJWoRm7nCtz4BRPejFOT1B0N2l4llwACvQ7vyIZUlcu6Oz2WTH+4RY8HQhcb?=
 =?us-ascii?Q?XTCpxzUTDxPL4uEX3RrLWdck6ZWF/tK3tezca/VU3VEPFhaJmazF3PG5dePl?=
 =?us-ascii?Q?2iveZ9KjFn2Wms9w0PEZypg0hBQd7YCjWL89npazDl7bUBsidy94XDkfwFBh?=
 =?us-ascii?Q?huwNI9XC/ozge1VskQkj8djsZiyia/hgagiTdIloCwgwLP5XZol/KLKkb2OO?=
 =?us-ascii?Q?iCtInN73CtGOILHh4hpFM6QsEo2VA8Jlpwtf3dD4VqcZ0iHO8D7Ann77lo3v?=
 =?us-ascii?Q?SICMzN5B8J9v4o4zouelmB6ispeetPjCirLWDEGFLzl4h7tHvfykMtmjzdYH?=
 =?us-ascii?Q?ACHKxMbw5HHQKW03TDpNBV4fK3aYVXUo+M1pTrVptUEgp8NQOJqJE8vzx45e?=
 =?us-ascii?Q?EIowWeQ7jLayKugom07EEuP7sh4k0IVy/KDEfCFsEn4RhBp3yKDW3xsHE3cH?=
 =?us-ascii?Q?OZYjHCljPU1sytwux/XtvNRJHYbN2srN+41n8Hgf/w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cXIcyv2dZkU//RoOQYbdOHldxDWsv/RNmy0VvECU4PqAkj84rl2KvBo/DZIN?=
 =?us-ascii?Q?IOV0TNWYwudTbXDxgWv+uMnrrNFmcGC0NlirehoqfYUGiHu+pIJVi034zch5?=
 =?us-ascii?Q?+ZZl8N1TG4aMpLe4BxXN0z3vS9OdjZPYCCDJMwyjVbY8d5DbTH8f9fqoMDBO?=
 =?us-ascii?Q?JWVxbRAHnZk9QjZsXq4g83dKCbPH5eAQKXtv/TcijssTttjtZH0HXsbIVV+H?=
 =?us-ascii?Q?aFDcfbvpLSHkEFsveYLlrqKALCCIA+V6Js1fckvU8dLCpt0r7TWYh5vkxo2f?=
 =?us-ascii?Q?KDd7n8OG7DhX1WzdOYziXuEo1+JWpFUFtwgevtws3GgocZeu71QRyw3oJkIc?=
 =?us-ascii?Q?EFLDzzWekBsG5DFsRduzOuDdObKGDVP80V9nSIOUEMhdYffpMvIv2EVGIPAr?=
 =?us-ascii?Q?Wlrdeijrb+4IqvQHi4CAWP/v5qMywZwmsyhhk9xqF6vfzfYoJBKKu9sD7egM?=
 =?us-ascii?Q?8nyTRegfmW1ZNcpvHXPxz7tP3jG3SXwAhHhe8C0rDk3Ahgj48y2JYcNsq86C?=
 =?us-ascii?Q?F5i6xEQjArEryBuGDI1Hazb4CgsNVUiqRWUbkY79KT39Uy8FnaBMAHYn32zg?=
 =?us-ascii?Q?Af04YlzEN3ZAGy7KL1b3mMQqs8GScflvChWlS0BdECLDrlCQAeJIsUpe3NAM?=
 =?us-ascii?Q?ag6urWdjxcICGuJLMjUJhP9bqkakDt9C1cRQsUJp5Utqajx6A2LavHBdHigh?=
 =?us-ascii?Q?2DQ2VxgHJDUjKbjmfu3Em/0lN2Sg6MKlY4KkDhV09lw26a6WyeXtKb9NzQ9l?=
 =?us-ascii?Q?PutPkzfyvDzjCAwYiAsxc+XNhg/BGhaddGpIxt9zGEzN76TsqaaP9tFSlyga?=
 =?us-ascii?Q?EJnzKAeYCe6cCGZ+bqscFLncNmA6o/4q7DOyX+FGlDs04zUTu66vd1IfFaTm?=
 =?us-ascii?Q?JHYHJZSVZaf3Z/ibP5eJ6W11iHSNtpaidHKSJsVRgsPGUGuOAIwC6/wFcFQG?=
 =?us-ascii?Q?RFjzyyjfi1OZqkMuWASMo4wJdGPIFDZsG5k2d1kFO+hlPDxXXrNjgpF0GB6L?=
 =?us-ascii?Q?TYl2JhbL3IC+xwpQa9b2jDCAwUVRrq/RpwL93eqwn2ksQWoSu9QR8J3edog7?=
 =?us-ascii?Q?5D2cl1cDgFeYaM8xUfGNXHVx3sfp9kx7pcZQrBTTKKUIIU1k8TAzCKsrPEcm?=
 =?us-ascii?Q?gdo6j+Fy92Xzru9EagepPGQplgo7mgfXetV80FyLIp7CEMlaL5BJ1u4sszr8?=
 =?us-ascii?Q?P7fzoRsJ/4W6vv+VFLEdtryDDRJtEdQzlylgRtnntZTiW9Rto9D2bDeDNoyF?=
 =?us-ascii?Q?QivhJsb7y59unixTBQD8CtOruFXQrsT6fNww322bNd6NQsVBJVWm7ZAgXQng?=
 =?us-ascii?Q?22V7EzI/+ZS3rshyT4mxpJikXc9HWTK+okghlmSNhz+f0GcWJgAJAqfUxdaP?=
 =?us-ascii?Q?8Dpgxgw7A06MZxTLBwpg2Ahk89ieYonrwDvZoh7deSHy3UBKwt7LizgPt/y8?=
 =?us-ascii?Q?9lOTPqK5pltanQg5tLkc6NcNWz9AKeLU6x2AkTFRA5dT0rSdvCvhKk5gpFoP?=
 =?us-ascii?Q?UZSxSEF+gSg2Yhh5Vl0hflf5XhfI2/2Guogk0AO0nGA3UZo4YHOIDD9MejuQ?=
 =?us-ascii?Q?WGW0HYSdWx9uZ2nnb1XlBUXYdPr9fv2hFetAgWsRSg45dOC/y6d+pATIdQOj?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Mpj1kbVPIpa0Hbi2qFYWkWxojYo3hIqCxKoRb27GNSrreTNfZWdy3//sb8WEkuiCSP7dYE70E28jTflXmoNtvny3jQJrh/fB6nTaNr16bDiEbjlsuso2ibcXD/oF7HkHTRF3aqZPsAauKR50mvQqRrfW+OFHD0aUVIclQoKO8LLVPI7/NoNehoPoKcIzQ8Z0hUSlIBFJj3MUpb81GTIjCh4bfOgsF1Xj7x/0l3kQCtf+kNnGf0B6JAZFVaLbQMo8qBSe4fkS79YcwYlMtJ+VNKFMsg9Vkmma97IYPDm+Ap6yw3d7oZ5lJmzdE62uVy887BiIvmKMRjqKnf24UjWUINBuYUuoKiK0A+ImXX/fk7ED4FezTtvCQbhiRTy2lHQtexBr3F8ARD7N1YU/Ug73fgJ52B+RBcKNTHDANnhqmXpaLj+vGgZEYs3MYmZwlF6j+Ghs8eeJPhIfBfc0zIXK7yRPU6yPiPhZzjRRRpSGu2SqJquME5N7GJYx3aLb+6dls1Uj85olNRXP567m6oyJOwKHD2lXQ3qVISL+rDjGs+nl4RvNuxmzjDofgYEuFFk3MQMO3MG1wDrG7CjjUX2BNISuVzvyKiUcRB80fa6Dhf0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f04a80-2f1a-44fe-7c2a-08dc70049790
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 08:47:00.6689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Gk3MHPxJDkrIWOc5zut7Ap7eOz81jydt08dnhOcOT8Ops+cdN3cRoqmhiIDRrUcUDUAxcyRUnQb0vBAUodLHW2oTSIJq5gUxb6/7jQD3ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_04,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405090056
X-Proofpoint-GUID: K5lidQ91gbgjTebNFq6PAJM14ZrxvFW1
X-Proofpoint-ORIG-GUID: K5lidQ91gbgjTebNFq6PAJM14ZrxvFW1

The macro list_for_each_entry is defined in bpf_arena_list.h as
follows:

  #define list_for_each_entry(pos, head, member)				\
	for (void * ___tmp = (pos = list_entry_safe((head)->first,		\
						    typeof(*(pos)), member),	\
			      (void *)0);					\
	     pos && ({ ___tmp = (void *)pos->member.next; 1; });		\
	     cond_break,							\
	     pos = list_entry_safe((void __arena *)___tmp, typeof(*(pos)), member))

The macro cond_break, in turn, expands to a statement expression that
contains a `break' statement.  Compound statement expressions, and the
subsequent ability of placing statements in the header of a `for'
loop, are GNU extensions.

Unfortunately, clang implements this GNU extension differently than
GCC:

- In GCC the `break' statement is bound to the containing "breakable"
  context in which the defining `for' appears.  If there is no such
  context, GCC emits a warning: break statement without enclosing `for'
  o `switch' statement.

- In clang the `break' statement is bound to the defining `for'.  If
  the defining `for' is itself inside some breakable construct, then
  clang emits a -Wgcc-compat warning.

This patch makes it possible to use the cond_break macro with GCC by
adding an outer breakable context __compat_break that expands to a
one-iteration `for' loop when compiling with GCC, and to nothing when
compiling with clang.  It is important to note that the __compat_break
one-iteration loop gets optimized away by GCC with -O1 and higher.

The list_for_each_entry macro is adapted to use __compat_break, as are
the pertinent loops in the few tests that use cond_break directly.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
---
 tools/testing/selftests/bpf/bpf_arena_list.h          |  2 ++
 tools/testing/selftests/bpf/bpf_experimental.h        | 11 +++++++++++
 tools/testing/selftests/bpf/progs/arena_list.c        |  1 +
 .../bpf/progs/verifier_iterating_callbacks.c          |  3 +++
 4 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testing/selftests/bpf/bpf_arena_list.h
index b99b9f408eff..5659c715a8a0 100644
--- a/tools/testing/selftests/bpf/bpf_arena_list.h
+++ b/tools/testing/selftests/bpf/bpf_arena_list.h
@@ -29,10 +29,12 @@ static inline void *bpf_iter_num_new(struct bpf_iter_num *it, int i, int j) { re
 static inline void bpf_iter_num_destroy(struct bpf_iter_num *it) {}
 static inline bool bpf_iter_num_next(struct bpf_iter_num *it) { return true; }
 #define cond_break ({})
+#define __compat_break
 #endif
 
 /* Safely walk link list elements. Deletion of elements is allowed. */
 #define list_for_each_entry(pos, head, member)					\
+	__compat_break								\
 	for (void * ___tmp = (pos = list_entry_safe((head)->first,		\
 						    typeof(*(pos)), member),	\
 			      (void *)0);					\
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 8b9cc87be4c4..7f03570638a6 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -326,6 +326,17 @@ l_true:												\
        })
 #endif
 
+/* A `break' executed in the head of a `for' loop statement is bound
+   to the current loop in clang, but it is bound to the enclosing loop
+   in GCC.  Note both compilers optimize the outer loop out with -O1
+   and higher.  This macro shall be used to annotate any loop that
+   uses cond_break within its header.  */
+#ifdef __clang__
+#define __compat_break
+#else
+#define __compat_break for (int __control = 1; __control; --__control)
+#endif
+
 #ifdef __BPF_FEATURE_MAY_GOTO
 #define cond_break					\
 	({ __label__ l_break, l_continue;		\
diff --git a/tools/testing/selftests/bpf/progs/arena_list.c b/tools/testing/selftests/bpf/progs/arena_list.c
index c0422c58cee2..570c1e043257 100644
--- a/tools/testing/selftests/bpf/progs/arena_list.c
+++ b/tools/testing/selftests/bpf/progs/arena_list.c
@@ -49,6 +49,7 @@ int arena_list_add(void *ctx)
 
 	list_head = &global_head;
 
+	__compat_break
 	for (i = zero; i < cnt; cond_break, i++) {
 		struct elem __arena *n = bpf_alloc(sizeof(*n));
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 99e561f18f9b..e0437609af21 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -318,6 +318,7 @@ int cond_break1(const void *ctx)
 	unsigned long i;
 	unsigned int sum = 0;
 
+	__compat_break
 	for (i = zero; i < ARR_SZ; cond_break, i++)
 		sum += i;
 	for (i = zero; i < ARR_SZ; i++) {
@@ -336,6 +337,7 @@ int cond_break2(const void *ctx)
 	int i, j;
 	int sum = 0;
 
+	__compat_break
 	for (i = zero; i < 1000; cond_break, i++)
 		for (j = zero; j < 1000; j++) {
 			sum += i + j;
@@ -349,6 +351,7 @@ static __noinline int loop(void)
 {
 	int i, sum = 0;
 
+	__compat_break
 	for (i = zero; i <= 1000000; i++, cond_break)
 		sum += i;
 
-- 
2.30.2


