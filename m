Return-Path: <bpf+bounces-28836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227BF8BE524
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E72D1F22309
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1220715F32E;
	Tue,  7 May 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nx246alG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gwLpQ2R3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC1156C7A
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090755; cv=fail; b=RaRJ9s37r2dTxpeWcBMhHlpWegD5wyj9OjgtdkegcVKMqyy1Ls30gRIG1PWXmIKkj9Hs++BDR4SLv65KZTdqIuY5UZ3ebFEv8/8W4ENEQ8Cn4AV7sqoFeHdG0BuruRCceqxw8HmYi7NtE9rOQhmwa5/Fydd4klqlJnv4zXdEIOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090755; c=relaxed/simple;
	bh=0XBy+PTDzo7t/c1wVNashr0J4lEH0WRBhKov4pvADIs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tSz+EKs5E+W8I3N61S0IokhsgN+J3FpwBu4Mhw4eyVosridZapKAKrvE2acr65+cw/qUktQcBd/5LS2LcRt/xJzpgRWtMWN3n3uVgRK6VVLOn6/NU0HUoTH7IgO8Z9U2UI6nZSiLU0NAEwJ4CRZ7ASm2n1fF1F9OqFWLU4w47s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nx246alG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gwLpQ2R3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447944hC008198;
	Tue, 7 May 2024 14:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=FNwbtXWxcwHR8P7JLg5mp9BfHcC7fYaNcqkifAMfnGE=;
 b=Nx246alGkRtByKIb7CrVv82ASUr4ms19C0oZXVSGQUyXh3eSwtdehvpQs4n5LfoRPk9+
 1aOc5oM9xYaPVrLqcdsxxfVur9ZdLEUNHU7QnsV7bmESXNsWykOtX2iseqASByMWhouo
 b3XusYWV8+HEMLvPsbSnH0ZN9cbs8TmdPHIF8Kn0H7RsD25ZaI00+qgCQOh2XY7uuiV4
 6QFGuAoFHJm/OfaTCluqDdzeFUdRLLtUPahn+qVKwsmLZJspg+WSCX4gIu0tsvDYWwPN
 B+1mqRISRIHRneMK7WQ8WrPHlvCh9Z/eU19BprE/aGr742JaknjRHXuSzPYghUDdUeQv WQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbeew0vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 14:05:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447D4K9R027588;
	Tue, 7 May 2024 14:05:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfeabvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 14:05:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCbd2xfNHtUhF3KR3p5Lm6VtUfzb3p6K0Bwkq2uwynzdEGjXi2hIjjyeViiEiEaiozFGteB80NXHo3t3ngKQPnMfvXSpGfSHBc1Y3F58GcJ1u6ee+aY6zY6rHWS4OiJg2a7SStZfFzRwprLfkSHkuvDjPpleSeb4gNzpb/d05/JE0fJkhDPCUdTGhG8OGMkA+Bjk6znOHz4g1Tw7TnfON+9Y9ZwaQcQjcDv5kCUg5vUJljV5rsyuLYJ503AHCBDHMdAXpkgwhy5HfjcwW9OxI4e2DZ7BPsdSHe+0Hc22kb0cCWD8DRuzyTrKBG3is9HUq1xD/7vo/hrumCrAZIDbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNwbtXWxcwHR8P7JLg5mp9BfHcC7fYaNcqkifAMfnGE=;
 b=bh420q14YtcUD7Qbmogrrpry8Yz98N+yKxzb5PIWYoxSwYvGSFRCkSWG7vFinzLYXIPD2UJqsmI8+8H3+U+vlsmsBEyuPCgQyWicpjyLrUsg051puxJAPZJbOTem+iPPMrmqy/U4DZCWb+b82A/iYItPCWFO0xGqRA6gOcRCsE1oRe+H9pFITaXi4Y8QF1rkZHDoN+RmGf2UWO5a55cnk2GjooBP0UWSyz94r8fWBWh10vvBTjnyMUB927GbBRxFnkHBBu6978+UukkcRkse5uNsvyRnGIcPn48NPX6/dmMcBNfLQerK4N3hjuce3J2KU5CAzuKgXkZf+64iflrCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNwbtXWxcwHR8P7JLg5mp9BfHcC7fYaNcqkifAMfnGE=;
 b=gwLpQ2R3GnziBJrIi57kCgr+Bi2jhczO21Kbdvam5J4tr/2P5nRMs4cSd2T+3531GiXDdXuSj4EKeIDQXzSXD2N02LFuu+9+xbHnTm9zeO0pV53MBNotY1rvJdZO066K2gXeXhXzyHf+Po6PfX+JAlKmofVPIJEBq4b/O7JR0o0=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SJ1PR10MB5954.namprd10.prod.outlook.com (2603:10b6:a03:48b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 14:05:46 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 14:05:46 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] bpf: avoid uninitialized warnings in verifier_global_subprogs.c
Date: Tue,  7 May 2024 16:05:40 +0200
Message-Id: <20240507140540.3972-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SJ1PR10MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5b963f-b0f3-475d-db23-08dc6e9eca48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OjYmdb81JqeNnfAWzwqtNyEqET0Vrtzojkm9V/84ds7v1nfI2kvTuyzNMlZb?=
 =?us-ascii?Q?OIVqATZgh6zP4zvNijcL+mpPA5d5rqzWFq3REEjSteHif0w8LFpGOGherBmr?=
 =?us-ascii?Q?sTdK+LCKVvIgEkreXOPWqjImqs4TCuraCekcim4+6IPY02WOuIluVW/l9eMy?=
 =?us-ascii?Q?XHhUT1krEjgCjQl6XOIpR4IDbC+BuZuPfTdeuB5XpxDPtn2Q5qiS9KoHjDxN?=
 =?us-ascii?Q?J6HHk225j3cEx1szT7s/Nfu3HCasz0dF0YpvC6XoYerbU25xA2zfoVKIT4SV?=
 =?us-ascii?Q?9Lmix982BSI0b1vkqpDmD6mAt/qmUuWKjKlOiUMyn1yxG5na3Z90cJ87GT2L?=
 =?us-ascii?Q?vczxrN3rVrvgiXNlQz0+dUvT835s7jEDBGY92ucqkNUF+vM+MwR6uU6aJYcI?=
 =?us-ascii?Q?hXS0pDMoWReRfOc+AqxBVzOu4KgufJPYNXrFDa0moVueU2+os8fXiGVjP2Al?=
 =?us-ascii?Q?4a60gr0HG6Qyq5zW1l7vtU5H+DHi3+5cNrLj6VGX2/l0+C/6YxG4yST6AYiw?=
 =?us-ascii?Q?l6nXnjQlqcU3yaofNU/xHVGIQYrlk6z4iVQzs1XbdSchiSyFLtoqF9SyQN86?=
 =?us-ascii?Q?bvOzdV1spduKk8S5BAemkDHXXC7sVIQOLPfVgimMMJF0F6tqerVt638omIxH?=
 =?us-ascii?Q?MQk7I2C2il0K6a1GBgM0ojfukBJjU0wFCgQ8GU7Fc3ubcXZP/zbMh819beD5?=
 =?us-ascii?Q?79/8ggtcBF0JLHwDlZi70o+gTSoKihP62QJ6LhQuRiea7NApuTzkf4rtjtGD?=
 =?us-ascii?Q?nIpoEgUik+4gJCDzvfOGh2TeKE75p5yBJLH0AUe+K3pkuqNwUgRWsgy8LAK0?=
 =?us-ascii?Q?swS9UF4gFkCUaFkqhGlIYGFrh9kbGr9SFy89j18weIWaqIVKK9st3NPeTu93?=
 =?us-ascii?Q?r5z0f+KR/hk2JSQ2acDJxYnDh/xUlSHpZW95a8u7GzSQnJCTNom378vvlZ+J?=
 =?us-ascii?Q?6IZcbRlqa3b2iJGx76D7cuDE0VMn1o3Hy7mVjt/V87W1UYHWDBw/GGvkd6M6?=
 =?us-ascii?Q?t4vcYVRBTMWc6gOFUVK0r+WuoArb2DQSi5h+oTVpIhjHtaGT4ziY8Xcp1qfh?=
 =?us-ascii?Q?qFeuEkX4jsxz4z0XplBkstdzdrt/jUxogQlh/mbiUQ3HafaQSCXxGB07ObQW?=
 =?us-ascii?Q?q3dYVMmZt7yECRQOkrz5sI9960Xt306b9nWoQs3e075HiTT4XyQabkcrFuKl?=
 =?us-ascii?Q?wxlNZB+/dB/rxSYtJZO4p/MUyMry9DMiNvrOZKilDJCNTpQWl7aRS6cEXosJ?=
 =?us-ascii?Q?rgNZIl0qQzgr75a1iDG//O5XFcDNzrIX0pX42QpN6w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+6fduQ04TlQDZ6AJEfmHt9IBW6xVD33qi6wuPEf9ST3xYRKgnqSsTLggRZBH?=
 =?us-ascii?Q?ZZW8lsfMndYt/R4FIJcDnJ5ftnjH+DbZKmpy6WqYPfUjsCiPd9/mpIL52mxg?=
 =?us-ascii?Q?kyxMX2eF9z9KED3F7SBXT7XNVR3pUNE9H+FSgWYOkM9TYUWGPcojp7GE60XD?=
 =?us-ascii?Q?VbADpTev+ixksN3Uizyyr61VCEH1TUMtyjr50Pc1YXWliuQyaTZTJyfvdKnx?=
 =?us-ascii?Q?I2cTbhWVE/pIOiehd+iBeKMn5dzDFZTEfCaWOnqusW6JixITauampUVoouqi?=
 =?us-ascii?Q?gsuUj5lxszUVhklo/3V1sGReHoFuMWLP+S0FGMJtT08E0t+fDcCw4+dDBU+0?=
 =?us-ascii?Q?3ZX4418DJZdYf+BtPDO1WHZkHMLcfQ2MLihR9jx9M/bGxWrkWLPDuqtrSSdE?=
 =?us-ascii?Q?zdIMaz+QS5P+1FyNieeEPJZzaSXIFkC3yPQayqYc1wQxfAdRXhJxsuIpuBch?=
 =?us-ascii?Q?p/zMU0+kWxP2wN5xZ15TEOXE2LYz2JXsmBONiyespMGneHHgoWBWvc4HmNDe?=
 =?us-ascii?Q?9KiRXTnOHFmLgVCZF/v18CfLAdRd6LZwflqmF2ocgr5kEOR0OoFIsf1+0dUO?=
 =?us-ascii?Q?z6THzgte+0dzY7SCf/Ts0Vm61Jhe4ZqVMLxU1vizOuYbJle1gUIKuoqrNYfM?=
 =?us-ascii?Q?JTU2+RofyowJpEwM0CwhJ8RJko7F8H1RYASXunhmM7qO6iDA13Eotf6KuRnO?=
 =?us-ascii?Q?zSQ9ZTr18PNygkI4w0EkQsywPbuFuclMBeOn/Sj+/LbgDV7VCFwMojP+GS5R?=
 =?us-ascii?Q?+Fn8aJFmga6Qe3ooccTrb7bw1suz0vQ6iJI6GE8BJ5FjxSFNS1WS4BQanbXs?=
 =?us-ascii?Q?zZxTprBviiEI1tyzp8npwW2Ay/IH2/zNHQdjOfm2eJ192m+ZpnD69HW/dHa8?=
 =?us-ascii?Q?0/vrV0Uilrx6OZuF9EweDC81MGzsoZkndroycwWYZbpbzNuAmA4lK8SsXz5M?=
 =?us-ascii?Q?JOb9OMGnNnjfpV4ruiS+pfw0OodS9dQvF0veHIkUFoQ88QmXTuasI3BQjsWw?=
 =?us-ascii?Q?LinhvaIgr3Dx32vzrpvtx/IQn11OdASx/y5jihvESb2lRs9Omb6EryDSQKA9?=
 =?us-ascii?Q?Tn2V7sbArannhNgrm4g7QS4QGPNxd6kkjF96tBsJO+FfPmgzVTx4sGc1cgRL?=
 =?us-ascii?Q?9oIeWkkuQPQQwXi2yQssmjoVEcT5K8eckFInXeoLzgq+vHTu1WwFJoK0lTHw?=
 =?us-ascii?Q?evBAtIIYjGzaQYtBQRYv4bR7uvTBdUarWa1j6dTfURXaBjmz2eVdezEJXPns?=
 =?us-ascii?Q?jaHj8U8Rd+s/eVtGa32QJMISjtQvDaBNYUiYXfnVnMJfNOzZGVnNBSxcrMGw?=
 =?us-ascii?Q?0qQdIgnPlhdnKpBKP2sSDULfR8BO4n2ETXqkkuE0TbuntVorBbfLqmUVjAC1?=
 =?us-ascii?Q?yYQOMUx/NVkKrutXfs4wnzhFXdPhMdTaa3WGd3UiNhmnXed2AhG7/X3c6Nnm?=
 =?us-ascii?Q?O128RUh2J7xGFK5vCDQLxtbMtFqIdmlzt2RJsZrxUHkbmbBbF4+XgBevRzFp?=
 =?us-ascii?Q?xf0GDYz+ZUj49FVgxeG4arYrrmsHjXIEOLrLWOO3kpPwq28FRC2cFDMh7dWb?=
 =?us-ascii?Q?LB7Lzy+Ezv7gznIRrDT31r1hYu+7i6jqqgep1wp5qGdrNWGyhC1EG3iKUZJ2?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mTfhC7zo+uIvgFQWcu3SDcbaR264CdWeiA8sp3HS6JtgAIumDfyLWNggRR9qKn9UC/NkKoGSCpwfrfCM+uRgqGMJDbCwaZhHPpnC/NPNvXt5t6PxVppHENcjHfC5IYS4k6/CQhOpwehjIqo9K0d0HCateivXL6j5QQgenbUPC3dZfY7/PAxoyCHIXqgaC+h5tQowm0QCHN8EOdNrR0T/irVJ2bRqIYtzqvil0soyWuizWhWS94r08afnTx//g2WWhiMyJReDo+E8n96+HgV7Vy6fF8Be+FjjuCamUvjtq+RbKKZIWgfh2HfTZGeI8WOKfKXxbrTXG0qwRiF3CjYiHQ+IYLA8oJI1B+vHnS9VNyisLf0pqthoYSfu5Q8DQ6ILAXoqhRoppYTzw2uHuXlpzncN+hywC/Yo/SoYRdSORLkTY7XBU0/SBam/1m0nK1heMHn5a2oYbzUmnAf87WDFZOBeiQcVQP+dp69FpN1cO2uHHOseHiRgu62UrA+8hy/j2FkgaosvR8PkcQvBP78wx5mWIuGVxIKv6XiN9nUUeu23asjMyWvPe4ysUrL5Hjsv5XRYvP+vDmZFgHUBO1t8pmcpXB4WPiy/qfgY/GUCHys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5b963f-b0f3-475d-db23-08dc6e9eca48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 14:05:45.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZ0sKKO5AGahMxcxOETTRp7kBeqmMLoy3s6ZeuAUSstzQXXwCebzF40YutC/JizOmcy6W5VkWWxGplN24Q9asfDY0PkXnP3UkkyBJN3kNm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_07,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405070097
X-Proofpoint-GUID: zQeTCf7soxRecazZi7INkWNnys-77iUT
X-Proofpoint-ORIG-GUID: zQeTCf7soxRecazZi7INkWNnys-77iUT

The BPF selftest verifier_global_subprogs.c contains code that
purposedly performs out of bounds access to memory, to check whether
the kernel verifier is able to catch them.  For example:

  __noinline int global_unsupp(const int *mem)
  {
	if (!mem)
		return 0;
	return mem[100]; /* BOOM */
  }

With -O1 and higher and no inlining, GCC notices this fact and emits a
"maybe uninitialized" warning.  This is by design.  Note that the
emission of these warnings is highly dependent on the precise
optimizations that are performed.

This patch adds a compiler pragma to verifier_global_subprogs.c to
ignore these warnings.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_global_subprogs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index baff5ffe9405..d05dc218b7e9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -8,6 +8,11 @@
 #include "xdp_metadata.h"
 #include "bpf_kfuncs.h"
 
+/* The compiler may be able to detect the access to uninitialized
+   memory in the routines performing out of bound memory accesses and
+   emit warnings about it.  This is the case of GCC. */
+#pragma GCC diagnostic ignored "-Wuninitialized"
+
 int arr[1];
 int unkn_idx;
 const volatile bool call_dead_subprog = false;
-- 
2.30.2


