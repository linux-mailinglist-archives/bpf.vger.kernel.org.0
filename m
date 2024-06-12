Return-Path: <bpf+bounces-31917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00532905079
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 12:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AE528265F
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957237BB19;
	Wed, 12 Jun 2024 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TxFhOulg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FA7R2VEu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7016DEB3
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188533; cv=fail; b=XfUHwlDGAQzxMtsRsh+9r2GgheUrV3va8ho/E7Cs3u9RpdOfh5DCNivbA6vTdxJqkpm4FLZQ1pU0gQr19+xWH0KtFluruPulduqB38ml7VF2DRO5I84hF5DCjnO9HPMerqmpysnLnO2gOpiDKOm6dw0Zi/gIDz+mLGicIfoNSGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188533; c=relaxed/simple;
	bh=vcF0wdolsOU2g7Dk/0RonCYGgUglmwKAgOjJ7D+KhNo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Gn5FAOtV5A+T5wPF+/+yYZBSiwh6+wlHf3gpkvV5zLju4zMa+heVfEfIXPs1K2L/pQ157tFjbcrsqhQ9RVhInDGs0005IPvKrurVdpYTzIWOYfHhnQN096Ngs8uzl320yhEZoys0a7TH0ElR1nZ6sSR5LHGK8KBUURt5NEySC/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TxFhOulg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FA7R2VEu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C7Bbx5032204;
	Wed, 12 Jun 2024 10:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=nB4qvD1/M5Be6f
	Wi/1X7ywrDy9yTpyMO17zn6W2YYOA=; b=TxFhOulgSAKMoYugEG7vzjo+84NPin
	H3qwsI+8Zr6SsPdSu/OhVtmDP1YBr4UlgFXla6wTa4iaZ+5XbJpbY+Ywk3mftAD2
	bUgBUfP/KPDKYRZL7BqfraM2DMTuIUqI8yeLoBRbmY/Mgb3ogQJjBcPwR7VB6sJt
	Ppf6S5ionWBM4OrriFQuy4jIkakWBtzmNB9E3R5AjqTedlorMTnvKYjPPn4tT8Ab
	FfSHuZmADeHtda2JLmOEW+wW2FgcLzmtOIfKj8+/Q4aTxAh/jJoUXe5bqKmHbDvJ
	ntfCLISSuqNGJvZS9PlV5SKj23/YqtIyg71aVa+CcB8Ha2892ngLkiag==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj6wba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 10:35:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45C9oG2V012526;
	Wed, 12 Jun 2024 10:35:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9y7yjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 10:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n82qavEPKHG+/swlg4d4nb58tvKekHflThcXrllvpqjZkZlXClXacF4J585H5LzCoqMH7t8xVfXZoytPO99JLtwUHqWKi2gT3J/gnj02iHno6W4tSrI9w+6+iSLcRi28C5LVmHCLkGCxLzCXuqpOqeOOsyb4THTNp4gt1Kn0mXEio7dj255QB8PLKq7yAxh7ONfXhDrYYVx0X14sHum2DxDkurslArcnju0uhBSg4w5WHrueV8Krvbpb1/sj/FjwDp5phQRGokNe0WDsJFv+J5DxeHKHJx4xElUBf8eGfSQ8PcT5etPqV/YMn3W/W55hURpYgrFcrF0NVxON/Gubaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nB4qvD1/M5Be6fWi/1X7ywrDy9yTpyMO17zn6W2YYOA=;
 b=TGLkRS/f/NcKZGkygvzrLcCtcCz7B+PtyMfZspp6iTbNMS/efsB/bHYGeMQmsiwT8iDoK19LDo/ywQP1lt+ZqpsG6uXr3Q8Pkb3SiFB55gfR8u5HJbjQJns54ieSd251KgvrUp0t92RnRvZBIBOLChCQf26dTStvHeNr288RZncv9Gm4NjTQ4nNjctlLAxss3RItaB7EWyB3CzclUdkm0kCOPSYUWhKaihKEJ9tvsG0+5I9Rt7Sv50xKMMGWAHgeV/UZLZB7RxMhNwok5qIT/DbUGb23PL4ZanPaFEpo/PgP2zVxtH+vUFlMp6Ha040qwAC+pmPkg9nKSU63uXIUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB4qvD1/M5Be6fWi/1X7ywrDy9yTpyMO17zn6W2YYOA=;
 b=FA7R2VEuxbqe/L3WI0qrf2UDcM2ZfT/ONsKNJPo7ov/hK4ELBcaz1DVgaFIfLz/P/c4RPHSGnqHWY9Lj94aGHFy8t7ORmqntqES2mIprFyl4eLEFoppKmPiGsRj6W8AzS3gDOkZjvP6FrakDBjjnKjeg5I5PvTiJAw1yD+KGeE0=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CH3PR10MB7833.namprd10.prod.outlook.com (2603:10b6:610:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 10:35:17 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 10:35:17 +0000
References: <20240611174056.349620-1-cupertino.miranda@oracle.com>
 <20240611174056.349620-3-cupertino.miranda@oracle.com>
 <b22c50a1f73bdb88b728a1e5c1e3af143e8c92d5.camel@gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com,
        Yonghong Song <yonghong.song@linux.dev>,
        Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Match tests against
 regular expres
In-reply-to: <b22c50a1f73bdb88b728a1e5c1e3af143e8c92d5.camel@gmail.com>
Date: Wed, 12 Jun 2024 11:35:09 +0100
Message-ID: <87y17a5u02.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CH3PR10MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: ffed7bcd-3e97-4778-be8f-08dc8acb59db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Hotv5EVWvC3zPcuWZn0NmcMKiiyBtCLuSoKoCnQ3qselEmcuCt6+sUBt8oA1?=
 =?us-ascii?Q?abCi1dVc1VCuD2hs1w1cm+7BXJKNHeeOuEQJ6bZy6U+JA4bZr6cf0SZMq2V6?=
 =?us-ascii?Q?XCIBSD+PyYUTQg6SetuGTdExAi5PhmSAWzATa1I3pE5R7KkGneJ2AN9NH8SW?=
 =?us-ascii?Q?hA3HPi7IbKBftLQo4LPb09UqCn6NxfmGVD/yW9X8PVwg2Ywxv6N/Cly6Mj8Y?=
 =?us-ascii?Q?kmB2E4ksiOxyq0+2SQ7WNBHpk/irGuORx19WM9lOtfzOHQBYm1rBk1LA00S8?=
 =?us-ascii?Q?Qh/MmTedopSwtbdi7nxIvcm9/Z27vtaFiqcsQSlAV+w4H7SU+ZgYKEF1lJ0V?=
 =?us-ascii?Q?hD+9t8E6im/O84skf9YsrNLUijCIQ3STU16FZeBo9TkDNOveNWzR1Y17esRv?=
 =?us-ascii?Q?MVHsrVm+Y1KgQ/kSk9APbOq/YKdUzR0JDVKY80LZNiCxJ9uc7GpKZTMbq4wt?=
 =?us-ascii?Q?WNyk0oGp4Vn6v2neDKAJq+DphyNOLSbKi1HA5dipcpnOBG+rpBmLSF3JvEFH?=
 =?us-ascii?Q?nX/4uTyZxXymaMDGxAhO+R5FQSjBUsuz0Zq2XOD5ryAcrdBAi8/4QmVJWwgz?=
 =?us-ascii?Q?4w8/JuKpN40EAqX86n3hQ3MFZCA9ZQ+srEywvy2/sB/VMvW8GStnJ5Dmq3H0?=
 =?us-ascii?Q?99UE08IX+Bwmj6VUkAE7skoVkAJrMvVzTb63Nsu2+7syyfdD5uIoSuCzXah8?=
 =?us-ascii?Q?z19fZEcZXsqxbOK1xjNZzlhhYOfIfUviJwajPAEUUJ4SeGgAaOB1TPtywuKA?=
 =?us-ascii?Q?K5JCxcWesW6Mym5xvzzY9I4tfR6hksKBl6s4G8btxqw5x1tWe4oPdZqOQZuX?=
 =?us-ascii?Q?7zYcpqwAvAm0jklIqCPVpZRM9yetpX5DC76ZZDwrnEecT/c+70icetpSmaXv?=
 =?us-ascii?Q?ckg0+bX5vDlcP75XXIJ4qGnHV9GfXYxN94ScieiwBI+gVKmvqOLIGd1Xjf4b?=
 =?us-ascii?Q?hzgm2qcgT5AOQsB3ClYuHNapbUYYTMzDNwHY6bZSGvJF4ccAeVqauUATXyhq?=
 =?us-ascii?Q?eWRSycLrw3B6AQQB34Bqgb8OCwRjEKplcfP+ytPw70wJlawoUpFoOAtm17KK?=
 =?us-ascii?Q?BNJIZ48xsm7QTeB8vp1SVks0HMFtJbD8Iq+5DiMzSsnCdsWjWdsmbVEadCJt?=
 =?us-ascii?Q?zqQ4fgs34mGQ6PUwz1ltDz9Sla84ntiVvcRYtQGTlSVOmhhoGWRnV+2Xm1J3?=
 =?us-ascii?Q?V/3o0Y+XyFHCXRBiN9KmPy5N0qFsMrMvmQnLB/Li++DpWxOHAUnDAR2eOG35?=
 =?us-ascii?Q?7LWK1s3zo/VuVuMI2fp6WgWBU3FBdr83NUBFTzH9vRlQdqaEPp/6zq0uI/IO?=
 =?us-ascii?Q?dhpIgPZR4LyFu7oP7LAieoCw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cO2ej++CJbRySDVJkyDaduZGP5oU1brQ5KpD8LDOYMvhJEO5Ubv0UBsd0gbZ?=
 =?us-ascii?Q?J4Cr39zRclzfXdpntNsgbTG+2twOitEnCOAuTFsM9tZJKdKMGNDiHZgnAB4K?=
 =?us-ascii?Q?4vvo/zuGxRpRhKxuLlvTe+fs71u/fPkyi11ifxe4QWx7iLyLXO4mdAhN8Now?=
 =?us-ascii?Q?jhYJUltvxn+q7rUQc7iDEp55bBkCBv02gDgetjmURca7SSzmt8n7gyHd+E47?=
 =?us-ascii?Q?qnKKQmu8IdQ5iVyUVlYumgfPFjKzWMzRJkbDLe4UmcZ0dBCf7r0zYIbi7stR?=
 =?us-ascii?Q?okR4xbBemM8oOW9HPpTg32pldI8wXlD4b4FyxXegMiOr8G2ELGmrS8P8nruo?=
 =?us-ascii?Q?Ix+RHWuC45DGE5LenqttayRzZ/t0lZTvcps289+Ha3W1CKWtc7a2f0ngbn0L?=
 =?us-ascii?Q?NHyrXsj8sCGFAtboctl+RNWWV6TDeyE22Cqde4VgF7RU0jpgGUq8ZAFFsPuv?=
 =?us-ascii?Q?GdALA6n3+1gVIw5h+BLPPn5tv9JpRbUmBr/wz2oLNbXmozy1GXCO+bH9S0ev?=
 =?us-ascii?Q?wLQKs3GJ2qfUQiXoPEkoBO6So/Xk9nunBZI+ck7LfSiw2Duacz/yPxTVfd14?=
 =?us-ascii?Q?QZONzUnscpAVOjaBE8F/vExHBU4Zx6Y8icMxMyMxzPcy+bUJ3eFdUInZcA06?=
 =?us-ascii?Q?9uH51T/wqN7Qo9WonlKZQEDWUEq8x9cAx+ouSnEFvuBnJ1KhnrAxnqZYn7jV?=
 =?us-ascii?Q?bU7qrcoLMaIIg36XCk+eUEGz8vQp0JZBE7I+c7fcPKWcCweNW80Dt4zshJJB?=
 =?us-ascii?Q?3PflXYI3Un9MldB5BP+m+zFVGIwRsmBDUPkhZDIfmsUTWomCS0/1fCW/+CJK?=
 =?us-ascii?Q?cBsseLeoJ5bFNYRffVu4otVxEM79a6xkGOSPwQf2VXb+NKdIXoYfYSDpQIhQ?=
 =?us-ascii?Q?u77PTJhPNXluWKNVt1fOssvsRootv3Pt0cg85R9JPO3PknYzRVme126UzThr?=
 =?us-ascii?Q?2SGv5jrxRL1WbcmTAYdSczaT9GZeJKktuXAGhOkWOiFcbnJKFU/2ecDvbgUO?=
 =?us-ascii?Q?4ceVg0J1svzrqDq7pQZojMWv+AbvVChmWigedv4ZqOrH9JZN1j+X6rM4ZQdX?=
 =?us-ascii?Q?QzYLvDajCHWGkIZVWx+p6HmaAFsr3AhlO/FaFZvIrr8oWRIG8OeeTaWnfpX8?=
 =?us-ascii?Q?xx73k+m7qcI37hSD6uJ/6Nau7OC++0lNWPSA8yOvV2ZOnTa7eBDZzTT3q47B?=
 =?us-ascii?Q?CHh3STMsjM/p4veQvmYq6AdvLJl+p1aZhuxFl+fi3Tk0Zi8PH4/9hd+Xz7KM?=
 =?us-ascii?Q?QGHy+6Pn6w+sIULmoi+UXWkC5+GpAkO6Bbv1Vn0v0t7ESXkbPikMoEVXBK94?=
 =?us-ascii?Q?Y1tJzQHD4e1PT7wZ+bFwIEl965axV2Gq2Ppa3b4HUY46h9CxeUUByNgGhb5z?=
 =?us-ascii?Q?ReefgdbCPi/v7vHVB4/9p0mJNXy0n6RIWAd7UZjFh7OGLyA/XP39JzjWpYG+?=
 =?us-ascii?Q?1+Yw5KsVtr7bOalaOfIsKwMMGy8Tw2X0WEdoG0+53O3bOJ6QlLUrCBUrf3sB?=
 =?us-ascii?Q?tauopBR0xuvqFP8SIO088XswdFF7fNbsvBMDlAboD/bZmssgR6RjubczBV85?=
 =?us-ascii?Q?2Mw6zEIm6evjiKi76HJrzkMEv/Zq0f9pEZr5cTfik9+8IgnvxtJd7w8v/BbT?=
 =?us-ascii?Q?ZEAiubT38Mp2cm3OA1wGNME=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NVGsdyc9GkaiKRpegPtKHWx+KnAbicCfczjrYxXW0aDkMOA4WOd9+hVX6UqlRO7tEc9B/VuYBtZMZwOEX40S4hYTVRoJy85f6nOWxyUrC67vfmojkfAIuel5Lrn0DpyhDv5oA9xvDsKyX+nVrdOWC/2jkJl+btpuyAwC47JbX3Dg1/EK6+Qgr/4YXR0pVkCKFnARuzGy1nkeGalSSork0QhdWPissQrGx3ojrkCUDL1CLSjVkU7KtN9R9NrFjWtEf94gPoauBunm6F/BS4+5PBQo7B7KZdKwnwRcSdOsQzGxUzmrKEME3VkBbqoqAc7T4Kdg6vteEtROViPXVcHgXAoUh+x0vNP31WbN8IL7X1qScTx44cZnpIlgN3HO7zuXrw4DdLKaIUDt8J110fH82T+FDjKukGE6cauf3cVmq8zSSWybqN8Tz6Cbv7xqazjvhhB+uk1xSHxToaFcdqHPYRXC6VUGN+CnUv3zkcrxM3VFrawEIBcbCg8MuibZVgzBiw8BRyyC56Bl0FMWmZ9lkJPOMeVz4/aGDYsdFz1IDd8P4MBll5LqleiyM/osG4i3xpRz1CpaWfWpQC8gfRzPz6BtACuiCoDf6l4tOY3/iBs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffed7bcd-3e97-4778-be8f-08dc8acb59db
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 10:35:17.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRbgDx+khgtKtetRrIEfFZTxdc/dHj6yDvvLm+UshZTQ2v1+0dXPh3F7mN9DtLk+zZy6OIm+KjT+3pxsTXnRDnvmBidfF1KJE6kH/Pww0gQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406120077
X-Proofpoint-GUID: 4otVCLykKqzLfMT3b5U62JqqkkSlVcdr
X-Proofpoint-ORIG-GUID: 4otVCLykKqzLfMT3b5U62JqqkkSlVcdr


Eduard Zingerman writes:

> On Tue, 2024-06-11 at 18:40 +0100, Cupertino Miranda wrote:
>> This patch changes a few tests to make use of reg
>> would otherwise fail when compiled with GCC.
>>
>> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
>> Cc: jose.marchesi@oracle.com
>> Cc: david.faust@oracle.com
>> Cc: Yonghong Song <yonghong.song@linux.dev>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> ---
>
> Looks good, but I think that changes for 'off' for three cases below
> are not necessary.
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> index 3fecf1c6dfe5..8399304eca72 100644
>> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> @@ -29,7 +29,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
>>  }
>>
>>  SEC("?tc")
>> -__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
>> +__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
>
> This error message is reported in a single place in
> verifier.c:__process_kf_arg_ptr_to_graph_root():
>
> 	if (check_reg_allocation_locked(env, reg)) {
> 		verbose(env, "bpf_spin_lock at off=%d must be held for %s\n",
> 			rec->spin_lock_off, head_type_name);
> 		return -EINVAL;
> 	}
>
> Where `rec` is a description of the BTF type, `off` is an offset
> inside the structure, why do you need to change it to regex?
>
In GCC the off value would print something else.
Judging by the message I deduced that off was refering to an instruction
location and so, tight to the compiler.
Now I see the value is rather tight to BTF content.

I will remove the offset patching from the series and later on evaluate
what is happening in GCC for the result difference.

>
>>  long rbtree_api_nolock_add(void *ctx)
>>  {
>>  	struct node_data *n;
>> @@ -43,7 +43,7 @@ long rbtree_api_nolock_add(void *ctx)
>>  }
>>
>>  SEC("?tc")
>> -__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
>> +__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
>>  long rbtree_api_nolock_remove(void *ctx)
>>  {
>>  	struct node_data *n;
>> @@ -61,7 +61,7 @@ long rbtree_api_nolock_remove(void *ctx)
>>  }
>>
>>  SEC("?tc")
>> -__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
>> +__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
>>  long rbtree_api_nolock_first(void *ctx)
>>  {
>>  	bpf_rbtree_first(&groot);
>
> [...]

