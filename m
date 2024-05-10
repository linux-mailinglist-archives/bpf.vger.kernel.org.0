Return-Path: <bpf+bounces-29494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EDE8C2A01
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 20:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9D5B23728
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 18:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF4738DDC;
	Fri, 10 May 2024 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S3uUiJJb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RzIMonLd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E618044
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366374; cv=fail; b=bIlH/kSl0rmcdzYOljENMLjt6eImI4EBB9ipVJBzjh77EX7KWZaKbVfyAFfmqf1dfg4MqBRTx34L7r8c5gN+gx6XC17obXBeCbIFAE+qYbzc7yetHSrTBNd2w4pQDPbW5W/PgTu51XAizJIYe9MIKiKAryc+QvmtDRMzmzxF0rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366374; c=relaxed/simple;
	bh=8i37Oe0cRWQcZDqWSIUJVhfA4Fkog11iL7HjSpchgOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b970MDy1I0Ku5VRFhKbNVE/WXKVyQwdFBLXhw2L0aConaZFJOjTvZbZOKPsjbksEFf7uCnrNKyctWmC8tNgoTIWGE5F/zKhpoQSwogfjCOND9gZAKAspcztdMg3aZn6sSk3JQBRbyPPt6Z9I0SOjlO1KRj3bCQERj3Z6ztnRLbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S3uUiJJb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RzIMonLd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AGiigG030819;
	Fri, 10 May 2024 18:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ugywM20MFOE7F48lt+3yfud/gQUs8v0rpCBw3FdZ7n0=;
 b=S3uUiJJbmEDASx7ZyDcfJkXw6GGBvxyJCaDE6zk5g5RD/DFtx7hRNnNUbQ78XJ9Y+QsZ
 X24B4CIZHYCxS7kwOKwSySVVRub38nKVQShpwtGgj7Ur/YtSxFAj3G1ge+FyVUyFQhSc
 rFmnHe2tlaKQ9bkhRJ2l5Yppo+UE8bCStvHF9jcrx4UERoDw9MKt5Mwj02tRX4VxUop5
 fzbERatsb8bYfJ2Zkw74JXBeju0zEPyUtsuAtnuflf7buMFxQk3rmHzBCkeM6OlNRKHH
 Xnrvr7qpbAe6Y8+l1LJOZmgUs9KCCgDGHZcyROBYUjbhQvF18yij63n/1WMOFclcT03N 7A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1a0j9sk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 18:39:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44AIIFs4019400;
	Fri, 10 May 2024 18:39:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfrfk1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 18:39:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ9+QHth08zH4gDoHRVeeemeCvQEIYOEj2qlPEnrHHbSmYvt05tNsR0mPqVkft73ym4KFYCiG96+EmuNtoNtR4heKPScCZ/spVYMC7LfqyGTXNh+uTg3+LPMG2utUMrbKuxIqgurSKdKA2ubhO9/j6wUE8rJoh+eyNEdzkkwsdsVndcWou4aWt1/R3620H1stvqL2TUSzI0mBTwekiXdKveO+C1BTxuycJWtdzQ01Ox9WtreSSJ6JcAaQPeqBLeetFD1X7amTFfxc1v5IauvpzMkZSxUHnX1YbMIwmcVcsYLWrZSwZYFDZFaIJqHDSxvjQ+AALqPLwFWRGjV16v9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugywM20MFOE7F48lt+3yfud/gQUs8v0rpCBw3FdZ7n0=;
 b=n/YmtGN1rqppcL8yf8KY9PYdXetI77crr9J7jHUkWiBjPlO1uub4u+V65nXQiRfyihoo7hXBpnsFmNzfHwmxDcmmHV2rJqMtan/ZcPTfmu3fa3GXu2lc0c3cpDU/o2Sx4ux/EUDxpFAGnRZCTtKfNNumXojj6nsOlEkpBwTH9OeUipLRGOtakHyhgfhSaP38kSMk+K3QqTbjhkPVTTcO843aANeDxyjMDKl9cPMx05J8sd2axmd25nrhFzWjAx8ich9Yh38w++Fxjpv+EHbfkI6PWa13zwZ6P2U48VH+ZBxncPk6sKFdDwrRNL1he8lnpM7mYYZmRlsJIzi8lBQQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugywM20MFOE7F48lt+3yfud/gQUs8v0rpCBw3FdZ7n0=;
 b=RzIMonLdrys3ydaykrno9D5whIGeljFF86/iQqNiaUcxj0jUUR8EnQy8CU/Mis6nvUM4toJZV83z5jMI6wg5Q48hjZd6FBnSstAEB9L9RnvHs073K9r7AlyFwWXw6LRa8nb1s8LeQ7wLLtaN1kIHH7kZp1d/AypQ8EwQJgwacD4=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CY5PR10MB6167.namprd10.prod.outlook.com (2603:10b6:930:31::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 18:39:01 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 18:39:01 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v2 1/1] selftests/bpf: Fix a few tests for GCC related warnings.
Date: Fri, 10 May 2024 19:38:50 +0100
Message-Id: <20240510183850.286661-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240510183850.286661-1-cupertino.miranda@oracle.com>
References: <20240510183850.286661-1-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::14) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CY5PR10MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 1896ecd1-91a2-4f74-7e93-08dc71207648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a24zRHZvNnBnbUtqRFdRTWcyMjh1aUhkTTZjYzlEUXhTdmtOSTh1SWt3NVpB?=
 =?utf-8?B?bmxsajVZcHBoTWxKQ1dHei90OHkzVTJOeTNFZmdUdklaKytpOTZ0M2wxcTlp?=
 =?utf-8?B?b0VwZXoyRStpcTFRZGxZSlMzaUVYSTJNYVpUNnl2OTVnMXRETjc0U0FHM2o0?=
 =?utf-8?B?Z3h1RVJ2VEtkakdrM29FaHV5c0xXa3pYT2VXTzNGdHlGRHFoR2IyMlErVHdK?=
 =?utf-8?B?ZnNyTG1Mci9FMGFkOTl0NXpvendjaGloTkc5SlB4YzZWTG0zN2FxeE93L0dt?=
 =?utf-8?B?SnF6TERqNVJtak91bVZRZjF2blkyRkVmdEkzUVdwdkdSSlRWelZvd0JNek83?=
 =?utf-8?B?V3kvakFpTGZ6VWVGUzJuSTFGVjVyNFFxT1E2VzJtbTVxUDZldlpOdUoyUUdU?=
 =?utf-8?B?YnRVbXFUaFVnby9BTWh1MFlvWm9sVEpKMy9HeFNGdm1pdXVmamYvS2xPVCtE?=
 =?utf-8?B?S3VFY3U3dDZOYjE2Um4wcmVBT1VjSFZWV0gwZXZRV1oxTUlldkM1V1k4TWQv?=
 =?utf-8?B?M24rU1F5SVhZeC9YY0JCdGMvc2JYM3hEaWFGeGs4QlBwOTNCeW44N2l0VGpN?=
 =?utf-8?B?V1lBSmUySGQvcTQyb0VaOE8zS1VJaVNLYjJ5d1JzbzdQSUoyZGZXN21zR1or?=
 =?utf-8?B?RW9ORGw5ZHRtKzJxT09SR1RoTGc1VWE3K0F5MlhDQ0JTUGp2T081RXV2cm1n?=
 =?utf-8?B?Qld5U2NZNWhwK3Zhcno1WEphM2tSWHFnK3dZeDY0S2djNFBYa3ZaTnI0ZnE0?=
 =?utf-8?B?T25UVUR1UERkY1lSZEQyc2tEZ0FCNDBFeCtuTXlhZlNRRGRPU1VWWjRUYi8r?=
 =?utf-8?B?T2pQbEt6a2RnbDRLbkVZRDJxdFFxSk5TWFZXOGNQTmcxTmpYQ2dwZXpVdVNp?=
 =?utf-8?B?UlpxaFFxMzZscGg1MWtJc2xScHhaMU12M3ZpZncyNzNaZ2hoNWhES1ovRjZm?=
 =?utf-8?B?cmtPMDluMllIVzRpL3FTbjNYTTJQbXovNUo2M3JNM3VyMitLZU00QmFhdnJa?=
 =?utf-8?B?bFk3a01SYVhGRzZpamFlUTVLVmRjaTdRVkhBbEIvMXo0U0FtS3RyTFJPckts?=
 =?utf-8?B?VHFjQzR2UzJ1a1RFU0E5bzhPQ1BRRThoMEpoZFBvMEwxdDRNZmNUbUFOamR2?=
 =?utf-8?B?QmtsWHZVOXc4dzQxZklBbmJIbVdFQ1NjNFc4a1QwUWZMT29JdzFXd3dhbWEw?=
 =?utf-8?B?MVFTN1RYVVpucmNBZEQ2c0tKSlBiOGhJRkRrd2h3ME5JRXo0ZmJFdTByYUZ2?=
 =?utf-8?B?QWcwak1kbXdYOXJ0c1VKTE5VVmVtT2szRWU0QitLckpuNmRYblRxcDRaV0lY?=
 =?utf-8?B?cG5VYVRiS2xLNFNrWjV3RTN3alVIYzM0YTltUGdlR0hRRGVST1lwQnFCbysy?=
 =?utf-8?B?TGowREdvWHAxTXVHc3J5aWR1MHp4NUlTUm8vekNHOC9OOEJPRGZadDF4a3BS?=
 =?utf-8?B?REQwam5xTHFqUFBKVS9DVVNaMTBZc0U2RlJjcmsvV1VZK2dyMm1zYW1iTnFt?=
 =?utf-8?B?eTJsazREL2szaW1DdSt3d05oTGtJMHhIVFhaanJOSy8xUElaOGFHTTNzSHpL?=
 =?utf-8?B?SXRLMER4RkVqYk1KTUtFcEV5K1l5S2NjNHhVZTlidDByTU9MVjFjdi8xcWlR?=
 =?utf-8?B?NWRiTDJYN2lkc1pDNXRBeG03d3NrSk1NNThMb1NqczArUGxwSysweU1Damph?=
 =?utf-8?B?Mi9WRlBRQmpHRnp0S3RGTVhtMHdOQ0RGUnV0Qm84b1prQ0t5RmdESC9RPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UjRYUU5mK1VpK0dpczZNOEQvdTAyZC9kRElzTGljVkZxWDJadG1NV1pZTDh1?=
 =?utf-8?B?TnZFUlN4dkdETzFtQ3NiVWJ2eWVHcWRlQk0rdGNud1N2Y1BUNC9tS1dpK3c0?=
 =?utf-8?B?NzlHM1hEeWNMbXdZZThHU3dVS3FPaFJ6dDBwY1c4UEJqM2EwaVVUYmpseDha?=
 =?utf-8?B?ejM1eUEwVVFQL3lWSnA3cnlLd1ZTL3ZvTVdFSG1BUkVQTEx5a3plU2JHclpT?=
 =?utf-8?B?NjBRNk82OC9kdERRY3dDdTgxZ0piTHAzOEkwcWJYdVRqem0zRWptODhCam9L?=
 =?utf-8?B?L1VCUVFBb0VzWHVUZkc4RUpRRVVxVzFRREFUN0I4ZFR5dy9ENHk3aElxcFNL?=
 =?utf-8?B?TWxuZWRyMDRWNms0OTBjMjJFSGVhWE4xTzVzbnhvYTQxdk1RUVAySW5VbkpN?=
 =?utf-8?B?UmR3WmQwZityb213eDBaclg5V3ZlVXc1NTJIdE04cXQ3UkFUaE1sR0N0a0s5?=
 =?utf-8?B?NTUweW9mRkFLdE5IREVXbllIYlFkeElQU2JieVltL0gzMTRyVVRTcDg0S0dw?=
 =?utf-8?B?Mk82Z2VtN1pxaFpYSmNRZWw4dTl0Y3h5MitENXBRekVvazRTZG9pd0lRWVRq?=
 =?utf-8?B?NWxCQmlEVlM4YjVXRmNLOURKb1NRSmpKcHBLQmw2RHlQZ1lWcjhMZGtSNytR?=
 =?utf-8?B?RGVBNkNycUF4SUJ6VlRMblk3dXZiNVpUTHFlRndLSmFaTGd5L3lvTXdrL3pR?=
 =?utf-8?B?SXFDME4zN1JkMXZpLytyQXk5c2Zoa215SWlIeGtTRjEyNlNXOGUyUUNYa1k1?=
 =?utf-8?B?emFnb2NPTlNBWmJIZnJRNXJIVmVhZ1AyWjFMNVVuQkd5dENpSmVSR1JZNFBP?=
 =?utf-8?B?ZUZFSHh5RkM5SnpSSHlSUWZSK21NRm9GNmViNVJyVXd1cFFZNVF3ZXpENys3?=
 =?utf-8?B?dXNFSkl2WFQwWnZyZWhTU3k4dXpTNTNUdFQvOERoaWtrL2NkRzRheDNBMUla?=
 =?utf-8?B?dWVXWHhMb0NTNk1JNEhMWUpZd2Nzc0xuZ0JOeEJMVmJIVHp3cGdsV3pJQll5?=
 =?utf-8?B?cVI1YlJTN2trS0ROWTNjdzdFeEp2eklSanVKZ2RYNVcwL0tVMkp4a0MrdFZy?=
 =?utf-8?B?M0Foc2Q5SWxaSzRrOGEyNkliR1plOGswVjFjN2VmL3YzU3VCOUM0UWhCQzla?=
 =?utf-8?B?a3doeHhPdW5mSnZDZGhnQncxQXdwZTk5N3F3VWF4WHNnOXlCeWlKejRaL2or?=
 =?utf-8?B?eVRaR1Urb0xGYkpBUmZPZHpEMHpLOHdCY1Racng5MldDQ0V3aGNLcWZLTU9p?=
 =?utf-8?B?UW5qaVJHVE5BdVVxdGdFdnNqNm91SWFEQTFWcXhLUnliLzJRNkx6MWM2SG8z?=
 =?utf-8?B?L1RCd0xWUXpMZWwrUWsxN3Q3NzNwRlNuZkRwUmRUNlBXRzd5UU5Qcm1LUzls?=
 =?utf-8?B?NXlVeVlGMmdxdXZyMjkvS3grRnFsVXh1bXdqM3E4ZEF3VnVhYWRueGw5ODZB?=
 =?utf-8?B?MndnaCt1U1BnYVVFV1gzSnE3bFJFL0o0bnd4SGl6Y2xFOEZrbStRSlN4cVJ3?=
 =?utf-8?B?b1pZWGxmcHhsc3FzNXo4RkozMUxLcW80UDlTQkZwQXkya2hJUzlFZ3RoYmNI?=
 =?utf-8?B?NnhSK1pTbmZCaGJsL1lPckJnVmNNRnljOVlZZDFPN29VRG9nNzMwcXB4bCt3?=
 =?utf-8?B?TnBFZVFONWxMb25qS0pKN1BpSGJVNUlDVm0yMm55NmlnRE9tUFhoWm9pcUVC?=
 =?utf-8?B?WkE3ODFuY1JGZzJyQjE0M0ZJenNxakl2MWxlMmJSYmEvcGhyMXdzblc2TnYr?=
 =?utf-8?B?ZTFXRjZwNE9TN1hZaEtaZ0NPZi9UM2NqbWNXcGh0aVNhdDVtaDdXQzVGTFVq?=
 =?utf-8?B?bVFSSjJWUEgzSGFhRjlLcEYzYmRSdUNLdVdtdlUxZDNiQUpiQXRjNG5uQ0xx?=
 =?utf-8?B?aEhvYS9RRi9jOVh2RFZUY2tpUXozcWdqNVlqSUh4R0Zhb1ZaTmJ5aEk1TlJZ?=
 =?utf-8?B?NmRucm53UEMrNisrZUJPYUdpMnBSM0hvbEtiR2RDWk8zTTRob1AxUWZFbUI0?=
 =?utf-8?B?N21lY0hKNDRLSmMvZHo2S2FMbFlPM3o3SDhZNC9ZQmV2RllyYzM3S2pmaC9t?=
 =?utf-8?B?YjRzV0ZYckFHWUhST3dKbWQ3aTB4eXRmRVkvdEdkWTBCTThWUkVRZ1BXWm9W?=
 =?utf-8?B?U2hRMW1pWHBrcnVxMFcweHNXcjlFZ0JWTUhYUzdsUXdaUkZndDBBMm80ZWlF?=
 =?utf-8?Q?6X/n4pF6mSnTE/naUVmg1cs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Lsvd0f9WnAKbjMrSDTJWyBzYA1kaGPgDm0nUIv30qbl7kHlwW3PF7hiOwCUEkiihDK0hSZxkKAhvc65RqJmn48glMgaGTPtgxAdzP/eTiXAyDIzzpDV6WW6H/jZoxIflnEs8f5lWbVOe2de6kS97/U62vQZMs+pQnPetH6QVHuY52szMgSkoUY8X8DatbAnCltw+Q6GisnahqsydTX+wjcbgkDNEhV0oXzYwCeRUEZWIdXM5wTpiEHdmcQsd6ZPSVK61wzq59ercLntXTBTAxkdqAh1z7YRMEb1/+C+xXaZl1aD8vSUq3SGANIBiIkpqzbj4c60g6Nry8xTVViTj+R6Q5RTiPaOF/18okk0f29nsiT4R3H20nRJUgoLce9NZ/SPdcldPHqeYBDyrZhjJy9JvC71WN8NKCbZe1YwTdxeMkv1ZWuxQFac+EgGZvGJFdFnhK0/3XOoWrmNG5J7Lz6W7RKhRH8tDesOfRlPMNLvjmjdLINyyK3f8FYCc3U6yixiS2jbxJ+0hgsHuq4UdjljLof9W0GgrER41Vr/hPgbiV4fxviGHs25Vn4x2hjS4B1UVhFJbaUMAhdW0oc1lUfvcmMZP1H/hEB2+xcWklFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1896ecd1-91a2-4f74-7e93-08dc71207648
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 18:39:01.8423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hT62HFqQCw571Ls8zl0L4r1tVjqp9Q+sYby2y23T9xQ+5UFLTRqL34KkTolgmZTdglRC9QtBzhNpwqErU22I16YkH4H+IMLe97dPmeNr4OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_13,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100133
X-Proofpoint-ORIG-GUID: EGtL_cN_3g2kECohqug1yr-AP0DMmKhW
X-Proofpoint-GUID: EGtL_cN_3g2kECohqug1yr-AP0DMmKhW

This patch corrects a few warnings to allow selftests to compile for
GCC.

-- progs/cpumask_failure.c --

progs/bpf_misc.h:136:22: error: ‘cpumask’ is used uninitialized
[-Werror=uninitialized]
  136 | #define __sink(expr) asm volatile("" : "+g"(expr))
      |                      ^~~
progs/cpumask_failure.c:68:9: note: in expansion of macro ‘__sink’
   68 |         __sink(cpumask);

The macro __sink(cpumask) with the '+' contraint modifier forces the
the compiler to expect a read and write from cpumask. GCC detects
that cpumask is never initialized and reports an error.
This patch removes the spurious non required definitions of cpumask.

-- progs/dynptr_fail.c --

progs/dynptr_fail.c:1444:9: error: ‘ptr1’ may be used uninitialized
[-Werror=maybe-uninitialized]
 1444 |         bpf_dynptr_clone(&ptr1, &ptr2);

Many of the tests in the file are related to the detection of
uninitialized pointers by the verifier. GCC is able to detect possible
uninitialized values, and reports this as an error.
The patch initializes all of the previous uninitialized structs.

-- progs/test_tunnel_kern.c --

progs/test_tunnel_kern.c:590:9: error: array subscript 1 is outside
array bounds of ‘struct geneve_opt[1]’ [-Werror=array-bounds=]
  590 |         *(int *) &gopt.opt_data = bpf_htonl(0xdeadbeef);
      |         ^~~~~~~~~~~~~~~~~~~~~~~
progs/test_tunnel_kern.c:575:27: note: at offset 4 into object ‘gopt’ of
size 4
  575 |         struct geneve_opt gopt;

This tests accesses beyond the defined data for the struct geneve_opt
which contains as last field "u8 opt_data[0]" which clearly does not get
reserved space (in stack) in the function header. This pattern is
repeated in ip6geneve_set_tunnel and geneve_set_tunnel functions.
GCC is able to see this and emits a warning.
The patch introduces a local struct that allocates enough space to
safely allow the write to opt_data field.

-- progs/jeq_infer_not_null_fail.c --

progs/jeq_infer_not_null_fail.c:21:40: error: array subscript ‘struct
bpf_map[0]’ is partly outside array bounds of ‘struct <anonymous>[1]’
[-Werror=array-bounds=]
   21 |         struct bpf_map *inner_map = map->inner_map_meta;
      |                                        ^~
progs/jeq_infer_not_null_fail.c:14:3: note: object ‘m_hash’ of size 32
   14 | } m_hash SEC(".maps");

This example defines m_hash in the context of the compilation unit and
casts it to struct bpf_map which is much smaller than the size of struct
bpf_map. It errors out in GCC when it attempts to access an element that
would be defined in struct bpf_map outsize of the defined limits for
m_hash.
This patch disables the warning through a GCC pragma.

This changes were tested in bpf-next master selftests without any
regressions.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 .../selftests/bpf/progs/cpumask_failure.c     |  3 --
 .../testing/selftests/bpf/progs/dynptr_fail.c | 12 ++---
 .../bpf/progs/jeq_infer_not_null_fail.c       |  4 ++
 .../selftests/bpf/progs/test_tunnel_kern.c    | 47 +++++++++++--------
 4 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index a9bf6ea336cf..a988d2823b52 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -61,11 +61,8 @@ SEC("tp_btf/task_newtask")
 __failure __msg("bpf_cpumask_set_cpu args#1 expected pointer to STRUCT bpf_cpumask")
 int BPF_PROG(test_mutate_cpumask, struct task_struct *task, u64 clone_flags)
 {
-	struct bpf_cpumask *cpumask;
-
 	/* Can't set the CPU of a non-struct bpf_cpumask. */
 	bpf_cpumask_set_cpu(0, (struct bpf_cpumask *)task->cpus_ptr);
-	__sink(cpumask);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 7ce7e827d5f0..66a60bfb5867 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -80,7 +80,7 @@ SEC("?raw_tp")
 __failure __msg("Unreleased reference id=2")
 int ringbuf_missing_release1(void *ctx)
 {
-	struct bpf_dynptr ptr;
+	struct bpf_dynptr ptr = {};
 
 	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
 
@@ -1385,7 +1385,7 @@ SEC("?raw_tp")
 __failure __msg("Expected an initialized dynptr as arg #1")
 int dynptr_adjust_invalid(void *ctx)
 {
-	struct bpf_dynptr ptr;
+	struct bpf_dynptr ptr = {};
 
 	/* this should fail */
 	bpf_dynptr_adjust(&ptr, 1, 2);
@@ -1398,7 +1398,7 @@ SEC("?raw_tp")
 __failure __msg("Expected an initialized dynptr as arg #1")
 int dynptr_is_null_invalid(void *ctx)
 {
-	struct bpf_dynptr ptr;
+	struct bpf_dynptr ptr = {};
 
 	/* this should fail */
 	bpf_dynptr_is_null(&ptr);
@@ -1411,7 +1411,7 @@ SEC("?raw_tp")
 __failure __msg("Expected an initialized dynptr as arg #1")
 int dynptr_is_rdonly_invalid(void *ctx)
 {
-	struct bpf_dynptr ptr;
+	struct bpf_dynptr ptr = {};
 
 	/* this should fail */
 	bpf_dynptr_is_rdonly(&ptr);
@@ -1424,7 +1424,7 @@ SEC("?raw_tp")
 __failure __msg("Expected an initialized dynptr as arg #1")
 int dynptr_size_invalid(void *ctx)
 {
-	struct bpf_dynptr ptr;
+	struct bpf_dynptr ptr = {};
 
 	/* this should fail */
 	bpf_dynptr_size(&ptr);
@@ -1437,7 +1437,7 @@ SEC("?raw_tp")
 __failure __msg("Expected an initialized dynptr as arg #1")
 int clone_invalid1(void *ctx)
 {
-	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr1 = {};
 	struct bpf_dynptr ptr2;
 
 	/* this should fail */
diff --git a/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c b/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
index f46965053acb..4d619bea9c75 100644
--- a/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
+++ b/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
@@ -4,6 +4,10 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Warray-bounds"
+#endif
+
 char _license[] SEC("license") = "GPL";
 
 struct {
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3e436e6f7312..3f5abcf3ff13 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -567,12 +567,18 @@ int ip6vxlan_get_tunnel_src(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
+struct local_geneve_opt {
+	struct geneve_opt gopt;
+	int data;
+};
+
 SEC("tc")
 int geneve_set_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
-	struct geneve_opt gopt;
+	struct local_geneve_opt local_gopt;
+	struct geneve_opt *gopt = (struct geneve_opt *) &local_gopt;
 
 	__builtin_memset(&key, 0x0, sizeof(key));
 	key.remote_ipv4 = 0xac100164; /* 172.16.1.100 */
@@ -580,14 +586,14 @@ int geneve_set_tunnel(struct __sk_buff *skb)
 	key.tunnel_tos = 0;
 	key.tunnel_ttl = 64;
 
-	__builtin_memset(&gopt, 0x0, sizeof(gopt));
-	gopt.opt_class = bpf_htons(0x102); /* Open Virtual Networking (OVN) */
-	gopt.type = 0x08;
-	gopt.r1 = 0;
-	gopt.r2 = 0;
-	gopt.r3 = 0;
-	gopt.length = 2; /* 4-byte multiple */
-	*(int *) &gopt.opt_data = bpf_htonl(0xdeadbeef);
+	__builtin_memset(gopt, 0x0, sizeof(local_gopt));
+	gopt->opt_class = bpf_htons(0x102); /* Open Virtual Networking (OVN) */
+	gopt->type = 0x08;
+	gopt->r1 = 0;
+	gopt->r2 = 0;
+	gopt->r3 = 0;
+	gopt->length = 2; /* 4-byte multiple */
+	*(int *) &gopt->opt_data = bpf_htonl(0xdeadbeef);
 
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_ZERO_CSUM_TX);
@@ -596,7 +602,7 @@ int geneve_set_tunnel(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 	}
 
-	ret = bpf_skb_set_tunnel_opt(skb, &gopt, sizeof(gopt));
+	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(local_gopt));
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
@@ -631,7 +637,8 @@ SEC("tc")
 int ip6geneve_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key;
-	struct geneve_opt gopt;
+	struct local_geneve_opt local_gopt;
+	struct geneve_opt *gopt = (struct geneve_opt *) &local_gopt;
 	int ret;
 
 	__builtin_memset(&key, 0x0, sizeof(key));
@@ -647,16 +654,16 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 	}
 
-	__builtin_memset(&gopt, 0x0, sizeof(gopt));
-	gopt.opt_class = bpf_htons(0x102); /* Open Virtual Networking (OVN) */
-	gopt.type = 0x08;
-	gopt.r1 = 0;
-	gopt.r2 = 0;
-	gopt.r3 = 0;
-	gopt.length = 2; /* 4-byte multiple */
-	*(int *) &gopt.opt_data = bpf_htonl(0xfeedbeef);
+	__builtin_memset(gopt, 0x0, sizeof(local_gopt));
+	gopt->opt_class = bpf_htons(0x102); /* Open Virtual Networking (OVN) */
+	gopt->type = 0x08;
+	gopt->r1 = 0;
+	gopt->r2 = 0;
+	gopt->r3 = 0;
+	gopt->length = 2; /* 4-byte multiple */
+	*(int *) &gopt->opt_data = bpf_htonl(0xfeedbeef);
 
-	ret = bpf_skb_set_tunnel_opt(skb, &gopt, sizeof(gopt));
+	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(gopt));
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
-- 
2.39.2


