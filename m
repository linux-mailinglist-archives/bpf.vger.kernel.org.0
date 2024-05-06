Return-Path: <bpf+bounces-28677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9738BD007
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8142E287D4A
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6B813D606;
	Mon,  6 May 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MTrJKFu3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J0Bl+fT+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BDC13D27A
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005197; cv=fail; b=uLE1qmAW8CiMASngwU4j4ikyGzO+kRQu/Nx7YKsvZdM/pm4YfJox2u7bfsZaDb5ZDtGSdiN7VKwZHufEW3yHzjJ0Xdu71Q4GGORwqEPr+Ckcoeei9r5p4LLT/GTA/3KAKUOH5sNMdLBDiSZoITvllx8mLG9suvA61qCXpHRcASU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005197; c=relaxed/simple;
	bh=DmzynKk2F0OgXOpF7EV78lZUH/49paHxl1JzQK6ua6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCBRDVQA6jlto2Jdm6itp8SiRaEVs+D8/0rO70xOirVeFDXIed1RNwPdyb457narrwf6Jk1Wmvq3JKoU0kO+r9QOuX/s0L7UY5aiuzLotSV1wnbEaQ6ktUL+hsuZfVGBULkkzCLmUAfMJN1S6v9OHU82gTcYj0TCf/DRXquxd1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MTrJKFu3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J0Bl+fT+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446ApMtD010297;
	Mon, 6 May 2024 14:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=QqjyogT8MYYUmhVSyaQvkXeZGoTbapDwI8LTq+OM3WI=;
 b=MTrJKFu3D4+UFBJSX2sb13qgEXczwbTrNSARPRttYKXuYbNNiTWallV/xW+IaOso5WZK
 oCUlvRPpigv1IxTQfTmNMl8mpreN9BZOXsAZt/BCC/hE0sCDj3I59upJRKpofuxfPXkF
 QElE6xjqIDVBvToQd5Xs7a2SVU671p7XUTqtqbrhrHpwwmzCB9pP8sXltJoIKJ+pwVrR
 qrpq/cFbqmorXUYaaQMiVmWoUMxarJjBPXprprdgbIa5Px/l0bn9i4IlsYyom7WJEN7e
 N4FxsH0AUzTmLY+aXl/LejL0lqZakl28wu1DzLHzFIlEP3B6OIREZyff+jhODbdp0DNO GQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbxctqrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446CeXff027671;
	Mon, 6 May 2024 14:19:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfcxa49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knaVoXbZgF4BSddmil+rNPI24ku/eNKhozl9fIiReHm7OuPmxhZ3x5Ardlk0idJ0mdr0kuYhtgIP6afTp3b996NJJuQS2r+xt7cib/kRUL0WFo/U7z6/4D28PgvDfuxrAt9RaGNS0vhsl3vTgEq6hFMzYmOBi4DFfhC8LZoBabMN5QUuRxtkSsR4tU9fkzl1LgBL5RCZ71mS++BJXwb6GrYsin1s8cHECKeovOjwQm5HWDvZv7aTFCw50DUY2Sy4A5sXQFDiT7w34DeIxTFTnCNRTwR8MHbbsO9I+yOMRPd9dV1STiDhxKLafTCzDMLgDsvVI8sHa9JT7G0FeB0Nqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqjyogT8MYYUmhVSyaQvkXeZGoTbapDwI8LTq+OM3WI=;
 b=C72WWNAzbpltXZE8tq8CTI2c+zQ+RNRtTKqIOIYctUtWEaG/kNgXNXXniO2xLy3zN0wJ0tNNVPkzf3rlAjoP6kTZkJhtkqrh/h54RVptsB8OV66FlAR/KVh5vPDa8qI6+iwfu5gU0tEvFSCcrmTKNyG008q6h+JwIjg21bmsspINEA6LchoLGT8a4yDISC1XR/Fhz+GDOQ55lBsCmNQ9RKdrRSFSTd79QT6boHrl4eL7BILnPgjJljMjCLqQITiy6dkTgRdv5AOUtAHCaL+C6dBKgTuVa07e2/Wc4gXd1AU58+5D9Tj0CorH1iD8959yRB4ySj47n3BsLMa471YUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqjyogT8MYYUmhVSyaQvkXeZGoTbapDwI8LTq+OM3WI=;
 b=J0Bl+fT+YrkR9HULF5F/w5T5wcC0/fq3lN/KSuj2wHGYbNXHFqx573po0R8ExyYaL+ZpDE5WIkT5fstn6mG8soVw8pqY8r7DrbPdCiRCUv6k6cPAB2tA6I3LF3oqCCh/oBENlH9b9LUdn3Ph+f7etrHGMqLK+BIsoRmlltQFGd0=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:19:37 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 14:19:37 +0000
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
Subject: [PATCH bpf-next v5 2/6] bpf/verifier: refactor checks for range computation
Date: Mon,  6 May 2024 15:18:45 +0100
Message-Id: <20240506141849.185293-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506141849.185293-1-cupertino.miranda@oracle.com>
References: <20240506141849.185293-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0593.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::8) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS0PR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ac3af9-bbe6-49ae-73df-08dc6dd78f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xLxac+/Pmc8XPMjCtu+Jz6RXhTRgUA16zb0jGDWsuhvVqQqHFLx8HG9Ak8HN?=
 =?us-ascii?Q?f10EnAqblEQUMtwcBSSSYQEa70qJTtX5273uOjmys1usaJ+wpRfXtDiJCBSS?=
 =?us-ascii?Q?ImfhX81lNd/CBI1lPns++LW9oc1rr3LW1kaUitJckxi0vcFdwcj5sevdjWeh?=
 =?us-ascii?Q?Kbg1BpwqgKENe6flWDPOqI3RnlBayOo/1NLvQwUXOEstFevPIGFedY07pfuQ?=
 =?us-ascii?Q?1KwEuxumC3VDkQLlCD4zWIL3S/h6Wp4cwuCoabJoNDWJF//zu2p2vOvHNfnJ?=
 =?us-ascii?Q?NgX2vClgLq1LhEh3uhfm+3Z4pqsEK9VmMUs0qp0OqwiQampQK4egvoSN2z3s?=
 =?us-ascii?Q?5tQBFZWe6u0saVk9nrgH8KQHWhL8uEWwg+Gm96zcKA7LmT/K+kStR0ajBN4Y?=
 =?us-ascii?Q?S8YUyRtACmTqqjw3XHFdYEvYMkxRkla5083/FcNIzGxmg5NP+PfDqDl58ev4?=
 =?us-ascii?Q?YR5vGAvBQ8HKJvN+gl9L+2B2J4zyeKIi7+1vgL09Co+J0BmhnZQLV3lNotHD?=
 =?us-ascii?Q?6O3IwKCAbF0LHi7RklybyfYwzS9pQZDH59w6+j9IU7INwI5TGAzpZTL3e8lg?=
 =?us-ascii?Q?Tf3I5TSO6vS3u7COqHrnJzxT/BChV8tzLVbSrUYjJQTwgUXRdogWLk7x/N5y?=
 =?us-ascii?Q?zXEZHN9qX/wAjpVCDo5mOAeBhm6L1zR2ugO6shHk5onXFUh154t+nnpEMSdX?=
 =?us-ascii?Q?9fatrOQpX6ZDYdPJMhwl6DelM01S3XZEAXYyispROFzFCJHWhiF7A8jnWEXH?=
 =?us-ascii?Q?F2om5BpYgOxGTqZ5oeIqB3nmzEAR1a87rGFOouW9HwwfHumMcvLU/Z7QWUcV?=
 =?us-ascii?Q?SGinCpBvlzRvm40fvfRbtAFaS9EjJBUOjzlUdBpuTgCSYIAhY5xFhpEV8w/o?=
 =?us-ascii?Q?Sz9+h71dg5JY8zsM4sZ2KAwmZv/DFhL1QwPpsmLBenRMixWWxSV76Wf1jOxt?=
 =?us-ascii?Q?MXhIYRLIgXOuDprcXJrugFPK3Uf9t4eiEJtXky7a5AiYXWJemqFCFB5HTtmm?=
 =?us-ascii?Q?vVnuyWlKBUnbxqAkVS+waRmk8HcfRp2bFRqz1s/SzfUH0sm7Oj2eiRFXGWzO?=
 =?us-ascii?Q?TBGPd2tAnZI/ROYcPg8ap5CNna0x/bW6lRWVcxW5ry3dPLTMwqXzN2mVuz/z?=
 =?us-ascii?Q?qsGYSN95k5CDUcAOQftcGTrh+yfN6TLfUGSNlwOe4BStMEkDdQd8523GGl7t?=
 =?us-ascii?Q?5jShZGD7C2y5eutv4/FgjHw13uGmnA3Yhl8rBUzgi7OQPtLb8S1+PGwR+A2P?=
 =?us-ascii?Q?uwZMTXChqUj8JRnVF0U5GNfLCUbP9O5jl7LYmB4RjA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zL766TwfLcr73ahaE1rCWF4cOcJaJl2xthoNm9YGPgOHxtaJ9E8NCkQjUKK+?=
 =?us-ascii?Q?T+fK9KnzObeyy9ocQUwH15bct3++M//JKcl3PyA5OOl6eqVbT7zCi+CRuUNr?=
 =?us-ascii?Q?cymDWjWkhYKaDk2AtY12B3fpLRUgT5wQz2sCzke3Va1oEWbtAT6GmSvlB5lB?=
 =?us-ascii?Q?DobZGeWEp/9ivMt1ZhGBdFVGkJ/lUFDTyjBHio2/4pv/tydGAc+t70WoM0ag?=
 =?us-ascii?Q?dMUy0k6AEdWsX4jRXzS7uxHfK4yMPdyy139wS+MqiM6ZHLyJTxOzxsLULYfN?=
 =?us-ascii?Q?GbQHKxoktwr+JMqdDoKJSeY2Hp4pWG1v0oDP2d9g14Q81BBohToBt8gqebuo?=
 =?us-ascii?Q?Ct4bKnjuFZzSAukyskwMcBFe61eRZ2P7rGvRhkRfnFytyMCJieCSjxXyv9lF?=
 =?us-ascii?Q?3GSBXpNw/G8Z9ZQVbA1QaYkg5XcAJODFMIDA/Ndp9/XOO11lwZTlbOiELx5O?=
 =?us-ascii?Q?7ZOKKg4REP5kdz8IzuC914YG+Rqqtn4RsK+gAkX7fjFIQIWnpOXC+PVn6OCG?=
 =?us-ascii?Q?ZYulHeXFK/DJM3dTeZCMOH2jMyK4YyFG9mjVd8W0i5TTYEAm6nrX7YjPTISe?=
 =?us-ascii?Q?0m791YPdZyarKjWmGexw//gn70MIDjNkJxosx138cNHzElwPGDWpXnVH9Q+N?=
 =?us-ascii?Q?S15KKUOVy//FdlppE4MoSOAa4KC/iCDlE/QGmcXbqu3HqXjEXLV//M5/1mxA?=
 =?us-ascii?Q?WR/IPO8wPYjTcR4dAgP3a8ADRFT2f26JTa0vN8nPtdD7znaTe47gacm3fLl1?=
 =?us-ascii?Q?Vs5ADqzqn+OieRexxLPxXGOhXJpO0WBtSFG5bDfBc3WYCbNffkBivJRCXG/F?=
 =?us-ascii?Q?BXPuU0anvDcPMx4uX8lQ+8Ysrvcv1VulKlJHNDO6BfJDkfn9JjxNubbYApvQ?=
 =?us-ascii?Q?nuUp4wHO56hSiRaRlZFFg0SBUmWzWriEfNI49qo1LP5fvSQTqeSWHEtPDXD+?=
 =?us-ascii?Q?/Ko9+5ohmLgOewkzY/VlAskOyXeqRQMeFgQ+fjeOU6u3Bk3aAe6Rnrmce2B+?=
 =?us-ascii?Q?NZtpOdLYdAe0nSBgrJq+L+v5ttU99Jq+JBJaoGugLe8SWnw2OoNoxabaf79T?=
 =?us-ascii?Q?1qtvtQe+E4LywSf44lv8Prg0gUAUlAVPQU4CD+RhnRGr3zK1RfScUKE09kiN?=
 =?us-ascii?Q?3KRTrwKHurq4b9vmUBg+hdunMH7Z6EsSGhc6fkPoEmPye2pu4IeGmYYsdERH?=
 =?us-ascii?Q?SIZ/kAVwrWj8DCTSh2RbW/FHZzef4CyTWurC8DzoZX3jNHNIm4lB6bEKJ42C?=
 =?us-ascii?Q?RT2R9iVxj03jCtGtieKwG2p8z/hK6Al+gMR1uA5DAh2enn+JKdQCdbljJK+y?=
 =?us-ascii?Q?h+tNM3QbdjkaQI+duN3oopi7RQ7N4Wmah8009wCwlIqdpScumrJeIA0dLidl?=
 =?us-ascii?Q?ozV8mR8pHgZHw6TzJ4Jf4v5qRkqfXnAsf2lvgmo1cl1hgrYnVPkIeZ4xIYiH?=
 =?us-ascii?Q?FSCf/U1JNJFB03p4Iy3Mf9vzbabLtfL2THWpOLtSl3dncCg12V6py5Raqf2W?=
 =?us-ascii?Q?pTSNtYNj+0JfCoyDsy4Xe4sbYrsuJTtvewxAlTa6fZ1H2ckkiHvgbyr5fDrr?=
 =?us-ascii?Q?fYHP8eliGi/Glpj74gT5avnOivc64SwgbY4EHmthyEq+FQXVEmGXXmHkMwWq?=
 =?us-ascii?Q?zQFxzvRVuB3j8dnEeFYSnw0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Jvmb2WRgO6fSEvWO/GzTNP92QwcZLcZn+8mAIRcJ189YZFmKe0TtnJLG5JKYxT8GX7xrpyvlvytg7IR24K4J+5egVufzoey546/zPtHaMiPhwy/MebaAULlsYx5wsdKuJ5LL2sawOOh8qHVaougjBo6v7VSKzenixg3Tz5ZBZHRsAaY0tXhpE1FIkbtsYs5xBfvF052G3xXX76YFcCu8aNQVHmSDzCzwxL0N1Ri4UHZe2N/MkDX9aeIWIcbdUz1+bsgysoUv0xDr4i79kRrMnVRVJMXCT7+NBWohO/PJa7t0DYIG62ayD+9w2/CjQEX+kQoJ6+H2vgdZf0ZruqiSUbo8dUs6BBiJVkM5RmL/RXZbKllraLmPO7jgZpc1BRd/QASs7UHtWp7e5KF3Dav89B66DbP9aSiXlrwayBy6ucL7TdhriwmdGzA8ynsCz0aMhwCo0pHpkWj9pMDtXvSkAqtQwm+D/xbjgwI5kxPe4sRknhkpZL5fz6svCZDCfgisLoxt3mUsliuI7oNwtBtH/6iMLr9BxoxJX1mUIaN7tKlAkWxahVsiDgHHYJ08wu/3HRFlaSrlsUAjUD4+wj0aCbQiSPc4MSXhyHhRtI0vbp0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ac3af9-bbe6-49ae-73df-08dc6dd78f56
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:19:37.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dbuq42Fhp2Oy3C0krZA6I9ug2fspn0pxwvYDxR/IsqNb4Vjb2cuaLu/HsMklfXYUK5eiD69aqsh9dtGP9uzRVZanTb+GT9KMCFuGWt9ueQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060099
X-Proofpoint-GUID: HBjfWRSgapsbdr1VA4N53GWrn07Oa1dT
X-Proofpoint-ORIG-GUID: HBjfWRSgapsbdr1VA4N53GWrn07Oa1dT

Split range computation checks in its own function, isolating pessimitic
range set for dst_reg and failing return to a single point.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>

bpf/verifier: improve code after range computation recent changes.
---
 kernel/bpf/verifier.c | 109 +++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 64 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 41c66cc6db80..bdaf0413bf06 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13878,6 +13878,50 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
 	__update_reg_bounds(dst_reg);
 }
 
+static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
+					     const struct bpf_reg_state *src_reg)
+{
+	bool src_is_const = false;
+	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
+
+	if (insn_bitness == 32) {
+		if (tnum_subreg_is_const(src_reg->var_off)
+		    && src_reg->s32_min_value == src_reg->s32_max_value
+		    && src_reg->u32_min_value == src_reg->u32_max_value)
+			src_is_const = true;
+	} else {
+		if (tnum_is_const(src_reg->var_off)
+		    && src_reg->smin_value == src_reg->smax_value
+		    && src_reg->umin_value == src_reg->umax_value)
+			src_is_const = true;
+	}
+
+	switch (BPF_OP(insn->code)) {
+	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_AND:
+		return true;
+
+	/* Compute range for the following only if the src_reg is const.
+	 */
+	case BPF_XOR:
+	case BPF_OR:
+	case BPF_MUL:
+		return src_is_const;
+
+	/* Shift operators range is only computable if shift dimension operand
+	 * is a constant. Shifts greater than 31 or 63 are undefined. This
+	 * includes shifts by a negative number.
+	 */
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH:
+		return (src_is_const && src_reg->umax_value < insn_bitness);
+	default:
+		return false;
+	}
+}
+
 /* WARNING: This function does calculations on 64-bit values, but the actual
  * execution may occur on 32-bit values. Therefore, things like bitshifts
  * need extra checks in the 32-bit case.
@@ -13888,51 +13932,10 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				      struct bpf_reg_state src_reg)
 {
 	u8 opcode = BPF_OP(insn->code);
-	bool src_known;
-	s64 smin_val, smax_val;
-	u64 umin_val, umax_val;
-	s32 s32_min_val, s32_max_val;
-	u32 u32_min_val, u32_max_val;
-	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret;
 
-	smin_val = src_reg.smin_value;
-	smax_val = src_reg.smax_value;
-	umin_val = src_reg.umin_value;
-	umax_val = src_reg.umax_value;
-
-	s32_min_val = src_reg.s32_min_value;
-	s32_max_val = src_reg.s32_max_value;
-	u32_min_val = src_reg.u32_min_value;
-	u32_max_val = src_reg.u32_max_value;
-
-	if (alu32) {
-		src_known = tnum_subreg_is_const(src_reg.var_off);
-		if ((src_known &&
-		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
-		    s32_min_val > s32_max_val || u32_min_val > u32_max_val) {
-			/* Taint dst register if offset had invalid bounds
-			 * derived from e.g. dead branches.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			return 0;
-		}
-	} else {
-		src_known = tnum_is_const(src_reg.var_off);
-		if ((src_known &&
-		     (smin_val != smax_val || umin_val != umax_val)) ||
-		    smin_val > smax_val || umin_val > umax_val) {
-			/* Taint dst register if offset had invalid bounds
-			 * derived from e.g. dead branches.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			return 0;
-		}
-	}
-
-	if (!src_known &&
-	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
+	if (!is_safe_to_compute_dst_reg_range(insn, &src_reg)) {
 		__mark_reg_unknown(env, dst_reg);
 		return 0;
 	}
@@ -13989,46 +13992,24 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar_min_max_xor(dst_reg, &src_reg);
 		break;
 	case BPF_LSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_lsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_lsh(dst_reg, &src_reg);
 		break;
 	case BPF_RSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_rsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_rsh(dst_reg, &src_reg);
 		break;
 	case BPF_ARSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_arsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_arsh(dst_reg, &src_reg);
 		break;
 	default:
-		__mark_reg_unknown(env, dst_reg);
 		break;
 	}
 
-- 
2.39.2


