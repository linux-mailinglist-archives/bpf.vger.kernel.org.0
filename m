Return-Path: <bpf+bounces-28040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A0A8B4B80
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 13:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167D81C20A69
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74BA56B71;
	Sun, 28 Apr 2024 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eGGagL1M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hY5F4F68"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893442042
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714303580; cv=fail; b=mqWM0+5IRAwRXLAUpptsmiYOlBzcbt2VcB+LTk57RP06M0iPI/m+UwW0YsamUM2QxcuSizZdSfviFK3u5zMvjCgxAE8BvoB8JTS1Pu5A8KcCQ9v0/E+yG6lqn1CpeopvH64gyIu5k1vPzd43h59vLZLKpgzjQLzAXIyYVsz3fH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714303580; c=relaxed/simple;
	bh=dwmvRSsDEd9D6E1npheR6ZKqLuMn+EcKHwV6NgZwVwI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T3dm+qf3Hn0AvUfSOJ/JS3+kbtDW9T2roFjueHUHwHAcef/0Sy/DloWBt5Ny172c5yGZbg/KetjeMfMiGt65MyU808cq4UgSpVDXpbLyKP7JtGF90ekCkz7tmYbAZaJAvKJFBGiKg/WjMPsi2gqsh1c+reMzfFKMBZQHxslPcCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eGGagL1M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hY5F4F68; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43S3xeH0017348;
	Sun, 28 Apr 2024 11:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=spwgjF99fgrbb2Wtx6c2OhwR/u/rTnOpCRu7gILCEp8=;
 b=eGGagL1MpMvYd0Q3BkAL7a1ImnWCWXEj0kXYeo8MQUF3XUfNcEeDj/K+eDs59yGQMzb+
 JhN+WLEIJGPnXDyWa2xBVT+A8PRXIafUCqomN0VNkXHUkIYP/jQt9+ywfe6RJMk98Ovd
 T9YBtLeiilrI7na3NVZPziMVGJwfFVwfjAmazxR061jTqnEeYxIJez2p9x4LM8dY8WgX
 laHXLZiM2A4zjVDifdSON5uKz+jmETSKu86H5IIZ72NUQySwX3yOinxNPy7K6l7YfdMk
 muugOGeM9lMbjhONinWyAXhbq/Gq6K9QVpf6cV+bJ3qCIwflAJ+Bn9vSZ/1e9EA7jxOM cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvh50f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Apr 2024 11:26:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43SACT2I011501;
	Sun, 28 Apr 2024 11:26:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt57drr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Apr 2024 11:26:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z63N+xWVg9aSldWHmkhC8HnoTNnQhkRdY3OBJKfqqRMJfDXqrMdhF0R0JwoDRrYGd6qugOfRTptaYHY8Kn5NUONiLW78Tsi5LBuPE5F4ua4kv1VfUfole9ogYuXtvwPETysGJQZPV5SIpiCtrOqTobXuTfOszDo5mqLoEivToXNsOUC/mRqg1DOxMhm/UsyIumRaooQunBsIlG2PY+4NxswgoqbaOHPoBU2M28o69vOoIIkPNKCYmFojhuOgWrbkoStyXAkWW35f57FcQ1yXciJWAyoyOOkA/VNM/k7/voh/6Saq5gunsCG9YAOdFgehrj7BmVdB9NY/tbP0eQTudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spwgjF99fgrbb2Wtx6c2OhwR/u/rTnOpCRu7gILCEp8=;
 b=GAVHmqH/+PHso4W/+UiPDhyS/8iHHqBD4VdVWcLAXFNbo5AQbU9GwtUbq+uVgT32H5Rtd6TqshCPmICpPMLaKftULuSLTOas+ObQEV9JuimUsCTeLxHb8DZAdlsRaXs/yLNr2S6/crES04Df+yO3nWQZQFfWYjQQHCGiz26zpXY3Otvd/5VxC2NvfSGm9xHXGLhI+qT1ZOJnRz4FTwBHqByI7ibW5Yz0vkwgk1ZX/HBJmHmEplWS/PjrtdDk9kK7HNAvW9P2pvJepx3BFubiES7vkJTwIegOXltBJ6XzspbSdQvcUvZShfhaDWHMnoC1Y9W5C6mw12pS481hNeRn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spwgjF99fgrbb2Wtx6c2OhwR/u/rTnOpCRu7gILCEp8=;
 b=hY5F4F68CEwxrXcxkBac3laFfBoTHKmEIzDZkalxuRCMLAaq9uwq0k5YgeJJy/uM/AUNIWZEWBfpHuUCxE6YOOyApFv/mODc15PzdJr3MkVU4z+UQAhv3S92I2kuFxr+BvY+RyYgNC69Xqy/hUu+hB87BCYmlKUWdCUA/23lIpQ=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by IA1PR10MB6783.namprd10.prod.outlook.com (2603:10b6:208:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 11:26:06 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 11:26:05 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: [PATCH bpf-next] bpf: fix bpf_ksym_exists in GCC
Date: Sun, 28 Apr 2024 13:25:59 +0200
Message-Id: <20240428112559.10518-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|IA1PR10MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 5199b237-f8f6-460b-5098-08dc6775fe52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mzu863FwIlK2l417DWqlnVKG/55bS9fb2Q8pDGZtqg1EPcHEZqLyaBzg/0SI?=
 =?us-ascii?Q?KZfiRIB6OVdcBEfmmgFOXkxLDsTuA1Irim+Uz2xznrdQeDTxscYd1D7m5FRK?=
 =?us-ascii?Q?rCuDaSkrzDLiXvNDZ14slgj4b4PlaZMZUenFNXlESoIKt5kssEP8SFN6PZBU?=
 =?us-ascii?Q?NiSXdlFDGcLnAdQn7UQ1DRrYQg7Xx4VndBn9qlyBuk7THUzVZZwd3s/NQjqI?=
 =?us-ascii?Q?C0GHcRlEqoObNjv2OCZLTGw/FrTKpiFdwhOzRojGzl2WPNVTHLlPANUjjl0q?=
 =?us-ascii?Q?aFP8D67zR1vZtVjdOxiQ/3HrJBrMbejHaKHPS5DSBpxZXFQQxHQ6C2g923XZ?=
 =?us-ascii?Q?BoI5L1bGvDCvnwvBxkI3sZoZOWMHkQEWnIapocXIqI2VCiAPmuOKIFk+xSWX?=
 =?us-ascii?Q?CgcVzi61uRHObBXk/EAYJIDVuBTBCvrcn1YSE5V3w94mJOm3SjwqRvTCKqhb?=
 =?us-ascii?Q?aqTbkekHNGaUWTjjtit4ZFf4ST7YaOl5PverCNJEab3HN/tT5rT+RP5YPMzm?=
 =?us-ascii?Q?i/DqLl1OJLyCPEuUpCarC1i0S2nCwLF0WLTsIbij5IbGH3B0NAa7Nd5BNiRQ?=
 =?us-ascii?Q?wCa6r9U8kZuPAbFFCM8x8EzGgTqZ4rDWLE6eptcHLyF3HBJnaP7n1cyp+ulE?=
 =?us-ascii?Q?MllpiWlbAAvR4SNx0hTKGO1OizVJXpvnJf9L6MAvrsvDuPh6oi9rGZpVhZOf?=
 =?us-ascii?Q?sNNNjPHct9teZt4SmH9w29HcRhbdrfaCValjHCkjPEA/vfMrLbT4yIsu5FIO?=
 =?us-ascii?Q?IfxSxyHtIqCcg481jdeSheTr/8TrmOexsImVSQlJjYZ85R6Ok1artVh7Qzq2?=
 =?us-ascii?Q?gPjdKG84F9acH7bj7KbCLXESJi9W0wmXKTt1q13kzrR1SoBsDuLIyj+6JFFu?=
 =?us-ascii?Q?lMVAXrsNphBbPZ2GlsKS5T6Chdk3huD1UwOvglv6Oi6u2N7QdFfczvBTu26m?=
 =?us-ascii?Q?019Q4fNwsjubX/qgwx99cda7BusLuL+XiFaVtmtXvnbx/qR36HnKL3lCHiNc?=
 =?us-ascii?Q?9VcrIVD5bjJcYKld3bCsyqQ7DBIgfJL4kxV7EYKnjm2815/tgeSZnabR+JMW?=
 =?us-ascii?Q?jQnkZkC0wSW5+SuHo0SLNlfBNCI3VRqQtvd7PBkh0jrkyHZi37K23O8pMa3h?=
 =?us-ascii?Q?XDw3sbwqZ5yhiXfuKR3NzZwZBR/cGwAi8qCudDmqhMDM4qAMhiuMMv3vxCn5?=
 =?us-ascii?Q?Y28Zg7C1kK2mo8Ls6D7F0SVZ+SGcfgxy+YyR2FMgNON62pfszkAS+kCgnGyQ?=
 =?us-ascii?Q?INO/2RgIv0xrtI2idLlWczAsp8L2bmA2+J8vuEC6Jg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CfXEWlkeV/+r+o7oBubIDXJxcfgEbrmgNjfQeE6hWjrNOyA9/ppkLsFpSfXx?=
 =?us-ascii?Q?MlZJEcQdWMkbigIdaAFS+R7eQQhHdgJeltC2C9Bk94ysB+pS8mvaHByw1+Mg?=
 =?us-ascii?Q?2RKWEX5ooIbttVLXlblhhZX1Mv0QYW1Xx3+bj2ax34SEKcWyFqMgqAQiJatX?=
 =?us-ascii?Q?wrDJB8mP39oa7iKzg+TOJyrQ0nTGSz5DZsknCQXl0n+zenUzKGK006x9oOlo?=
 =?us-ascii?Q?UNZ4bOrkusdCtDMLwj2jDlsKfAuUK1YBqPlS0rJZCoAhvE2qGr6znTp8oXSC?=
 =?us-ascii?Q?I1/9OVLAYOJl2BapWL0+EHgj1nhxjWDUcO0282HPpEraEVwOEZrxWyA/5/K6?=
 =?us-ascii?Q?nePBo0CZNucp6MxrsrRJY5BU4eiZlTpQqgaybveCjRmz1if5wfKo572BfIxL?=
 =?us-ascii?Q?WEh+XKjj1ftto1qnc7iIwa+fW5Wr748MPpvSTmpwOWtxA+ebxjraDZrB0rfp?=
 =?us-ascii?Q?5jovpx8yG1zHGtcT3pMIrt19jStadXd4Cei/lhkrRSdOl+jBB7e/MbBGQ0fD?=
 =?us-ascii?Q?8LbvFNYewVwODkkNp5vZppBZKmzyZACi0jXQfT8lf0rTWWWHFJtoQE8m426D?=
 =?us-ascii?Q?UwdZCDxsw/NlI+nQ0YbTeqeeL+ntRnY8j9Iow0DvGEKQ+q817ik8Nkx+GIgu?=
 =?us-ascii?Q?vcc0p3cmzxLddo2R+96eSsT3CCZNAPCwAc2SNnwX4IonZl9/BKRw8w7KHKMZ?=
 =?us-ascii?Q?dzI9Yr6j2ZUqwsZTQLkoPRKdAh9LzLxfsOPDDz85i0GqE0LnRioZ2NyZLmF+?=
 =?us-ascii?Q?S3d63jp3+c7QuWtha/CJEal7Kx8tyMaJtRIpplE/3LQhIqgwYscYdkY6e+Fz?=
 =?us-ascii?Q?4/r4wnwBGsYWJUXs4BE2bYunlC3c59u0sKCukCqds2VW7I893Jap4ECqZ5Uy?=
 =?us-ascii?Q?j17CC5QJBqoyfwniIxBRh6vPtscuVIEbCmOv0EKB85yCkDXYsP4iEGiauaCD?=
 =?us-ascii?Q?8HbNbELGyXObqJ5I2bNT6oiYUKeLrYjIu6ue7gRyoyUTrL5KkBRzJzwsgvQD?=
 =?us-ascii?Q?aWUC6uk5TLql9OQcH7S4Q5rno2zpLdcMbywZGPvp8CX9cTRFrVPvf2dIWu54?=
 =?us-ascii?Q?SjxPs7fDcEkXeswqO0Ezsl1J3CufaNvC3YgsyCJHz30BSO8ZmDKKK31RcSoA?=
 =?us-ascii?Q?atHGmrYVQxxPq5dDLvlo8IeLDgtbCEkZ4J9+kZBk8jUwFCNqPAORY6H7Nb0S?=
 =?us-ascii?Q?1fr4zOlyO3bHVTnIyO+dyWJNkdJOI8GwzhauxMVlo3QnGaHA6LdUKEYcxhNQ?=
 =?us-ascii?Q?uQ9UKOCqujOE0gxUBYakJL0Rocpn0ZgCvQkQIPGL3nxFck7b0YFWOa7cCCnF?=
 =?us-ascii?Q?W76uMqU9WmDOvCcm37+PFqG34ziJqIoS5pvkoWui1egfpglWP9QiK/Or62fl?=
 =?us-ascii?Q?7/fmW2l6YHFB5QYhWa4YrjT1VaiLJZUnVj9SODA54M5yrwyerlvpPnNDm8+0?=
 =?us-ascii?Q?RIFnR8F3P7d+0WMQhDNNVG3SBFwU9RtoxmklEzGC9/0jgCzaMffz3b0ov48T?=
 =?us-ascii?Q?h+3uGbGx9+xvwACqtrUeLzYLB6h0yw/Ops9RoMZPMb9h6JnajVZ6FdAMD23v?=
 =?us-ascii?Q?SCl3cMWGVFCRJdArQNJhSQZRXqx693/FULHYYBEJjfAjxKApkh0fYZiIjwSY?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uhl6dljKyhekquf+x1mkrDlanLq94YJVEak6RfHdbiAUgZQUXHagRRAhY2T0F/Zho1Zq0snqMSQNJqNjxX1ycNYtYH9a4d/eKyjvqrnyX/N0fyKM8zw8sv08hd6irIdxnxw1OQOI+FG41nLwN7D8Nld2m4FzYPStaI7XBapo9xB72mEjgUdwMx8Z78zzus3G8UMtfnn0gIWFuhkfPBkJ6okeouP3bWa9qp9Dcoqdt0zw1qtWUynBGVk2idtYDK/TypGT/wIld9nPl/ey0q9MpfaxONfjQ+DJ4n2/DKZ7XEU8RjvBj8kCSlZjjKLMP9nfGChxUA4IM4p1R8R/PoEj6eBNIJYDCzG6nAJmonb5FIAs0lz8C7uyJUdzdffWoPigI6NsBWCmBc+/FjvntDS52+4MMk26hCN/V/LOC6avE9Cuh3l9smWoT+jdifwzw0h/fMXQDlV0IrLJ8q2A8EWQmyi1/53KZm8elt5T1iGR5aqCX12LbqitRR/kKP/j23dYVUq3opnA/dynWPilK1sJmTYLiAZcZ6aPVltxGCXC51Wt6VkTG3E2TPN0ODrvDUhwPSCqrT5A263DoVK1u2JsDarqxhOHsQDTlBIvsn/1UJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5199b237-f8f6-460b-5098-08dc6775fe52
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 11:26:05.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVjPt6GFYMpJcrLvJa19SGoxG99jiUMnOMYilcd8QY/v6DZgwV/fuZJ8A3h8S4VaeeKSuo6QFnr00aVFFXRGnycU2KD0iP31oi83kWI0pEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-28_08,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404280079
X-Proofpoint-GUID: uPMu6HnxPw4Fbm0GM-oXnDM1ha6cHuiL
X-Proofpoint-ORIG-GUID: uPMu6HnxPw4Fbm0GM-oXnDM1ha6cHuiL

The macro bpf_ksym_exists is defined in bpf_helpers.h as:

  #define bpf_ksym_exists(sym) ({								\
  	_Static_assert(!__builtin_constant_p(!!sym), #sym " should be marked as __weak");	\
  	!!sym;											\
  })

The purpose of the macro is to determine whether a given symbol has
been defined, given the address of the object associated with the
symbol.  It also has a compile-time check to make sure the object
whose address is passed to the macro has been declared as weak, which
makes the check on `sym' meaningful.

As it happens, the check for weak doesn't work in GCC in all cases,
because __builtin_constant_p not always folds at parse time when
optimizing.  This is because optimizations that happen later in the
compilation process, like inlining, may make a previously non-constant
expression a constant.  This results in errors like the following when
building the selftests with GCC:

  bpf_helpers.h:190:24: error: expression in static assertion is not constant
  190 |         _Static_assert(!__builtin_constant_p(!!sym), #sym " should be marked as __weak");       \
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fortunately recent versions of GCC support a __builtin_has_attribute
that can be used to directly check for the __weak__ attribute.  This
patch changes bpf_helpers.h to use that builtin when building with a
recent enough GCC, and to omit the check if GCC is too old to support
the builtin.

The macro used for GCC becomes:

  #define bpf_ksym_exists(sym) ({									\
	_Static_assert(__builtin_has_attribute (*sym, __weak__), #sym " should be marked as __weak");	\
	!!sym;												\
  })

Note that since bpf_ksym_exists is designed to get the address of the
object associated with symbol SYM, we pass *sym to
__builtin_has_attribute instead of sym.  When an expression is passed
to __builtin_has_attribute then it is the type of the passed
expression that is checked for the specified attribute.  The
expression itself is not evaluated.  This accommodates well with the
existing usages of the macro:

- For function objects:

  struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __weak;
  [...]
  bpf_ksym_exists(bpf_task_acquire)

- For variable objects:

  extern const struct rq runqueues __ksym __weak; /* typed */
  [...]
  bpf_ksym_exists(&runqueues)

Note also that BPF support was added in GCC 10 and support for
__builtin_has_attribute in GCC 9.

Locally tested in bpf-next master branch.
No regressions.

Signed-of-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/lib/bpf/bpf_helpers.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 62e1c0cc4a59..a720636a87d9 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -186,10 +186,19 @@ enum libbpf_tristate {
 #define __kptr __attribute__((btf_type_tag("kptr")))
 #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
 
+#if defined (__clang__)
 #define bpf_ksym_exists(sym) ({									\
 	_Static_assert(!__builtin_constant_p(!!sym), #sym " should be marked as __weak");	\
 	!!sym;											\
 })
+#elif __GNUC__ > 8
+#define bpf_ksym_exists(sym) ({									\
+	_Static_assert(__builtin_has_attribute (*sym, __weak__), #sym " should be marked as __weak");	\
+	!!sym;												\
+})
+#else
+#define bpf_ksym_exists(sym) !!sym
+#endif
 
 #define __arg_ctx __attribute__((btf_decl_tag("arg:ctx")))
 #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
-- 
2.30.2


