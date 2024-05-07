Return-Path: <bpf+bounces-28767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DFE8BDC92
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 09:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709231F2216A
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 07:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C408513C808;
	Tue,  7 May 2024 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ELNOJilt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lr4PbARQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170913B7B3
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067770; cv=fail; b=gCPF85nA8rSw6ViRtATXympgO++GWGTh+yNuNViF2uWNFXZDcopXml4LKtBiRCpm6R+VTrw3sWYrD0dVASWBmdAb5IXlY17SAovlr/HTZ5ZN7EV1pteIuU+/mqEe1K2+ahZl7qKxiRhNcqUJH3oNk/gGIsu+S3yVcXc9OjkAd2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067770; c=relaxed/simple;
	bh=HlBrZ6d12I/8TjeoisvR/kSIajs8ZhFcNjk72hTFWSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d5BGoxfeyJXVeNSKj+d6LI3OeEZ29Q3Gx91ROXKg9m9QNifV0hZOzwEJGJ9j1LHHDIGAwDpaQL2zRUIXY966bf3sMAtEErtABQbIELct7SA6uRXDPFVdRl6EA60wQS0TtG04/s1PygutSJOKWr9sL/XkECDEUaprP4cdE8aWQcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ELNOJilt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lr4PbARQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4476SkkY029081;
	Tue, 7 May 2024 07:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Qs8Ez8xrO64YSRAs7qYYx+aPl3t+GDegmxxloUf1HKY=;
 b=ELNOJiltaywLq6lHPdvl9JyPDag578/6E3B09X0i/WoCmEhgjulRRg677BVRHXXTPVOl
 UehHGxYLaJQevpVJO6MA1S1KtzANE6gBpPVSR1CqksoexIT6mb6HurbUZwQHWD344NpH
 UiS1bWNW8xIWhyrk0PMvg6xtxwcUvYxxT1QhYnWMOZxoGFKB0yYdDt4NseJASlsxEqik
 JRqT/aIWRxts7OwvPtbtx0BvbJq4+dy5Mkfb1m4lqxc33rJQWuJT2mJU7fF5U76PKq2C
 SHH7cR6fgWMALQHNN46POzYkaKCoveJXh7iERHjDrRuPhEotgaUwoz0kXHDKOLBeFXBh MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwd2dv9k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 07:42:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44770umF027588;
	Tue, 7 May 2024 07:42:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfdvrr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 07:42:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Whm32awwEuapS4XbEtag0xOHGrvdotn7K0sXf1j1TsaGPUtq4cJWeqDq5E0f0IbQ2yUN4p2Sydcqu1EdGjov9Bt1i/m1F041Cnki+BIH1ArxBk+Jha0Y0s7s1JujiBz83fgVhCBV1I9jIdeWiJVF8xCywTXT4/9LoRiVAItiKDJQQFrSYH+aMSHRRcI5dUSnzhfbuXZt/GwEPATnsDj2a+mKZQPTO1PlmRZr/reLWPZw/YqdJ4KudVgMTIBZzcwJA9gh3ALaWtnAJiMi7oSOpRXHC7sKYMp7xffOxBsxPh5nwh/QiQ6jc+yaVydZo6XlJHZn3W5CEB0VQVJ3UeYomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs8Ez8xrO64YSRAs7qYYx+aPl3t+GDegmxxloUf1HKY=;
 b=C/YlUqr3yh7wzv+GPfXp5HzsRPitpmAnDUKNOMQWXk34JV+CZhxuRQiQ6ZLGJJUeMzRp8DyxhYKQuKRmXY2SgQyWxJxH5qli+ciXl0oXmu6gzEqmD0jI7834YkcBCKoSrYe8LK7vqwPyjf+kV78/6fVkT+poTDvjgoNaUk6CMxkbiq/1CLIQ2eH5qO6uIZ6mCVv+xLRTjM4uHvfMHlBtR0o4se8jIUXixpBlDhK9IKTitFYpdT0dKPNzbzxCps825tnc/aHnznUum6luwpdQDKRO7GIHjHu1Pz2LNnuZdw288nMbTqS8E2k+ZmAVeCqUTXwRLr+oGeYu6g7MLlPnZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs8Ez8xrO64YSRAs7qYYx+aPl3t+GDegmxxloUf1HKY=;
 b=lr4PbARQ7R4KQKOrS1ezocEhKHJRJDqd93M1d7NKjUJXP1BMfk8VOHSy5/gFs4L1ZEbSkm3rv9ByFxXXJxGTBGwDhgnn3hyYZZxFc9hjRpIVqmzq+fR8dp9l8Q2H7jih02aaIvZzW7nVOD9r4wt3p7whC2TdJd4Ax99BKoHA0xs=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by LV3PR10MB7747.namprd10.prod.outlook.com (2603:10b6:408:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 07:42:43 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 07:42:43 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next V2 1/2] bpf: avoid __hidden__ attribute in static object
Date: Tue,  7 May 2024 09:42:26 +0200
Message-Id: <20240507074227.4523-2-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240507074227.4523-1-jose.marchesi@oracle.com>
References: <20240507074227.4523-1-jose.marchesi@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0325.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::25) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|LV3PR10MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab1fbda-5f8c-4ec8-44bb-08dc6e6947ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Y1gLl9PjQMcFpwYM7vPUKE3SP48tbeP/kA0xoNLZBRSNb5gJnWd96ci5uUrm?=
 =?us-ascii?Q?cplWU4u/MgJ+NWmuxQRO4d2FtdTBq4CdNOWD9GwRmACRCC76GJyILMPc36W4?=
 =?us-ascii?Q?0tQ1KaZprVSjoHIcbYzaXSQ0wS5kdOaaTDS7NMbSvm4nOZ76mFe0dhgaurq0?=
 =?us-ascii?Q?mwc12CQkLfdrpO7E9qvpk9U3xO6UeMwc9Nk0emRaap3mLBs0RooKcMBd/vk2?=
 =?us-ascii?Q?rGgfjYVqKO6ppzur80YzK5ptSnj1Yb9evwBfd2xrdDOaXQ74wwzfhXlNPB3o?=
 =?us-ascii?Q?2TeB6mXTFF6XmhZmQ+PgARIW7EB6TeCK6zumjGW9HRE67AGd6t0c0MZ1okao?=
 =?us-ascii?Q?AIoapMqLWyoPEtsXydn+wcuomS0oXA5EPprYMx4gS+zdy5CQ1xIpAaNvnZfF?=
 =?us-ascii?Q?vBzoWg0SfCjPtjxJOxJ5cGsxfzOWOggRy6E5vL9p3oKwDvwg+KoFm5+FVXxh?=
 =?us-ascii?Q?9Vc3Cba+PkW2e+LLj0PUAvxKPj+kzZnKyabXFCRHwr1j7fTIsP0AqWwi/FB5?=
 =?us-ascii?Q?Sxb9U5GHC5xKVt+j8335CWt4T07GEfo87hxaQbS4E8Hiw4LejL22RxMZdD+A?=
 =?us-ascii?Q?f54Kd3ZgSyT3Qr3w3wwMFuwCUbrG6ZF8SRWnLHnkkPgPFXFg1C2gcFgezt/I?=
 =?us-ascii?Q?sFUrMGMq4ag1ckrKE5pKjQCJIerOBppjKBDb41WxJeanT1A2FMdTmxDxHYWg?=
 =?us-ascii?Q?kRhgu2Z7BA7I8IeLvhyDyMGskus+Vf991cIW7x1B0CjxS+T3/JyTFQM1rBbm?=
 =?us-ascii?Q?sTjC0oQI1w9+Kw5y3YXmeBTUstWkDaVa7XOXwAW+ap2LkoObv1/Zrf0fLvY1?=
 =?us-ascii?Q?YBsnsZs/ZRAKKrLNXp3L+4fIT8jxrc/GCWaVnzqc49a5cBqK3cV74ee8IHEx?=
 =?us-ascii?Q?JuIlLuZv2VTQ4ND479ta4Xa3JDLUHXwGNanu/ptgSW1gcqwjSI9FOAj9ywFa?=
 =?us-ascii?Q?aVzu2nz1a8j1VZBth1r9eQIxOeBoNVJfRHrP7c+kYaJYynpArLwHIfj7ZNS1?=
 =?us-ascii?Q?7Q5AS6PLxXTSoQKyyfJMh8wQfzjuPULhSWL8nOXgoOa0e9/3YUb0ylvSNXPn?=
 =?us-ascii?Q?ol4Iqop/DrOpfnRwAIIsX78c4ElVTJaIPBmayZ8fmGElrKM2ZL1NIPEcHjOl?=
 =?us-ascii?Q?JF/g8QKYi/ZpBEK4paY2qreaWcX08PAwKTdJvT3uLxjlSFxUW2YW50tgO8vp?=
 =?us-ascii?Q?d/AlN8mCD/PETrWC2OZehqwZr1E4DHRryNVF2xYFmUrumDsVxK7DCbJX/NNR?=
 =?us-ascii?Q?efWg8tDDQF2LpuY6h2kFWYigN829Cj3GpdQXtqmROw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lPGhDOD8LUUGEauLelmdlBLN8HJZ7TrM3AiNTEIFLn66Q+Q1+mOG6g3QmKNR?=
 =?us-ascii?Q?ed1nTijgxqzqDLzyXDg5VHP+JoDRHtnfp/6OHZhZewvepgNm3Rvrp27Ww4np?=
 =?us-ascii?Q?FNRojnO7CHEq0Nn3yMd2pTXGM975eI78YVa5KiIWFcRO0Uh6v2gPKs2iU7aW?=
 =?us-ascii?Q?28buDlXuXrJf15P/DMT2NHB3yIXaQd+IOa1XokOHNY/SokZWDr4W3G9kbEup?=
 =?us-ascii?Q?ym+hkXsMX0UD3im++FcSXLOhGl+qHxLSPLwpt1V9K/BL4x6gyu/eWl0mtXSK?=
 =?us-ascii?Q?jW+hTlfY/7tRIpfRDA5SwXTln+9A33eBBwlzqGlxJOneYlc/P1dLrUvgDZz8?=
 =?us-ascii?Q?QDhOH3xVrrn96lPEp9E2YZaLbvBoip9juAFV/k3Q6PaPHSLArUGMJb1OflDW?=
 =?us-ascii?Q?Hyh1A7f21Thwlm66p4k9Aczft2kFGI9/UTOkssaQWAH3bTFGeO7JDT7wAh7q?=
 =?us-ascii?Q?ac1Ad0oFJzWj/u1uJpJ8NvVQTGlHQcJ5+Y+FJq8e0zi2gXFVxbpuOy+MV2cC?=
 =?us-ascii?Q?mntLVm0biwZSR+xiQrVKQeg731YbUZfGYE33g5/vmZ3j4CCFrFeaRSgPTnIf?=
 =?us-ascii?Q?zP4fnCEbzMng+H0CUAFmtGAprGqJDaZF0MyhaJ4mhzlOol0oztCoPbFVu/HL?=
 =?us-ascii?Q?UQvm+UC80rWmMKrfLwPKHx3SAi+wc6uCyQWu6ypFMrqR6sxjvBQa/hBElmTM?=
 =?us-ascii?Q?yps3USHSg9ZBRskuSFibV3VPfb6BhgGZKsDYCCEhjxbYE2aBZrqLQnL+AKhM?=
 =?us-ascii?Q?C4BncWmtUqAAZPNzbm/KLyUpaxVk/HllKSnju3NWQ3d+0VmuKiytF8hNt2pp?=
 =?us-ascii?Q?/eDX/kBjWhWsz4atf+nYY0xJRArfeP4tMrUzPWwoOScEeC9IyWmUnxEg3zt+?=
 =?us-ascii?Q?VDvA2KGDLrohyJHQw/kPu9pKbuP7CvnHpDYpI2rx0PnLAnzX/qHQ2mOke9KJ?=
 =?us-ascii?Q?gjFUskss3wYeRujM1KK5P6ybeHVMfkBoWlIa0uSywAK9Oyo2RgeEsqi5dtiR?=
 =?us-ascii?Q?e9oSRcz/qT68i3OxW4neurkT1bU8yOkopGezBFsdUdLQOssPIvCqiSkf1NXc?=
 =?us-ascii?Q?LihdIn4g2q6PYOvSDPlWjVHiNuPmG8rMEgE+sFLG8Nx0VIlYMI7nVqVk+mF4?=
 =?us-ascii?Q?mwyI9gTTjP+UET9ooqRagqH4Ka6+mUP1+aFMCFGmJkipeU4fal/+OfvLQ24Q?=
 =?us-ascii?Q?jNbb83vOnpaB/11wuWOYMDCLF346Q2L6eWqQLuRsXmfeYArxDTl5QBWCjV5X?=
 =?us-ascii?Q?M/IjiCBfUWWdqNhe4gsD8kFq7d/M/8Abft+33p/sM40HOD5FWgQh8W6lSKNe?=
 =?us-ascii?Q?hyG7Tc4XbCOc3P1IDhoRJ19yHx0/1flTDgoRMUKSZFl0H6cJ156bL2KBKAgH?=
 =?us-ascii?Q?CbXfpTywH1RlBsFN25k0FCQgRqUrgJGrozN9+CJQD1rTessJwY5BNw3ANR89?=
 =?us-ascii?Q?xxd+DSM9eA/8qAHm0yuAE3D9xHBYhFT7bjiGyLI5BB5ZataucAwpARh0V/L1?=
 =?us-ascii?Q?uDqhTPGjKxZEm2vDjTH8AN0tJ1Uge6O5Wx57ub6rPvXdhisGF1aydSDreH9Y?=
 =?us-ascii?Q?qbvao0r4UlVthpjOJB6i6w/ASkE0+EB/QPdnYwbmmJxg9d1nyYK1y8OkjUDi?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mLIShTaf1/9oWBT6aXuYNlY+2avQ511R6kQsetke1n6CeH2JcXaiN+xZ+xRUI3UFIfUDERrbc88DY+TmFEXSmnQ1HL9ujUk6yqqoJXYvUzpscOPKuB6DCW2olk7JrWcRtMjHgcdE01cXD/AAMMxrULbt1ICUcU6PHzA7ONb4S7Oi3o/gSVEy1yDvT3ywTA2opTDA9J5Qhz1Flhi8XY2v1acAEwMvKqwlwhZ50FQpt7eaO6TqyNgBO0iHCxKPj783howywvslS3P0JCSGqtWdMxqGCfq+03pX8nrkxCW/25/kDQk6mGxPHj6qOx5ICfQgNbspvfmwKGDwHXwM0E92pjQI3KCndGaHQ1gUH2Zv7/Xb4DJ5WMUIpNch9uT+79HWqZJhNXz8qLFHIukx9TFElah+2cRxJTHIo10kOskPDbqUyAHcWCkE26p5zPelwFcVGohJXDUFcxg0rWlCkmYZJAAP8fR2/1p4sfRPOvbyJ0/p2Ww4PLkXhgmAPlXgg7XLA/DKhdkM3mj2MDc/kdsd5kOh3xsCfhNMnUJZ2t/EXLMeHnFOE9l8CO+hWMs1weyyJfY/D0E3YKBzawLPT/GGa911P7pqOCgM64bVsckv1zA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab1fbda-5f8c-4ec8-44bb-08dc6e6947ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:42:43.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXJHYaaN+dz0uUISCmBj/Y2QOCu0NurlthC2a1evMaS4TY2Pu6FAkSGQilir3YEhv5EiYsxqY2ELYDUU66j0+n+XbwbppwxxggeMHKm/whQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405070051
X-Proofpoint-GUID: REEtBDKAgsfb9hNayjR7kwCOwPc0ezTO
X-Proofpoint-ORIG-GUID: REEtBDKAgsfb9hNayjR7kwCOwPc0ezTO

An object defined as `static' defaults to hidden visibility.  If
additionally the visibility(__weak__) compiler attribute is applied to
the declaration of the object, GCC warns that the attribute gets
ignored.

This patch removes the only instance of this problem among the BPF
selftests.

Tested in bpf-next master.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/cpumask_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index c705d8112a35..b979e91f55f0 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -9,7 +9,7 @@
 
 int err;
 
-#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+#define private(name) SEC(".bss." #name) __attribute__((aligned(8)))
 private(MASK) static struct bpf_cpumask __kptr * global_mask;
 
 struct __cpumask_map_value {
-- 
2.30.2


