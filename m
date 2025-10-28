Return-Path: <bpf+bounces-72509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC7EC13D9D
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 10:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C26BA54032D
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 09:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B502EA493;
	Tue, 28 Oct 2025 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZzIvj5Rf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cr8znN+W"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DE27FD74
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643915; cv=fail; b=Ted0V3HsImp7xMhwjrT7B08zp+5yH/NWSN8rCycq00iPoS33XJn5+OaUfJ5jq4QeYtrZ3DAKlE9bqGTXDAJVO5sRifN3DJjddWo/u+LokDtGyp5KgHG92u+PfjCSQECquxaqkEYZcHZu+R/wMo7MUu1oFgevnsohCA6UoL2+g54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643915; c=relaxed/simple;
	bh=Z4Bf8SibRfSC1/k5FwKxKthbcHbcdeXOASDTDG2VNws=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=DEqnpmI+XhpokFtEffKRIt1SlxX0FdwuFLB+vdhKfmLoQPlxkkyHBo68znzZGeYwlYuVASoVysfg/Cfnqlyw00Qyd2yTzwpZObJAM9CIr1ns8hPnkVjAw8LFKqD8zE1CPHjCXi6sHr9T0aueWb1QVSvVH8Gu36oyC/3w0mYPbg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZzIvj5Rf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cr8znN+W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NJNS022583;
	Tue, 28 Oct 2025 09:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=0n+AZ9J45uy5FJrJ
	4Ja8HtdqB2igZ0oVfRiYIMkYoV4=; b=ZzIvj5RfQhvm2NR2dXJ7ANyw0Eqzt2Zc
	rSYNmAdXagCOxSsvEjwmqXp0W+Eb9R4p9cdC0kiF7rtkXc0kYHAhdWAb0rZek3pT
	zbCHmraEUNkRO+QIiGa7VEUeQDaue4UdPjHAOBNuXesp7W69YS1oFEHKIcE5MKik
	czMQ/48ws1qZ5D23xfDbBoxe1fIFimvN8izzzDxVtzxO9gacUOpnt1CfrcsBviFk
	cQqgnHiZg21JK/vkZhJJbxjAq/k0s2eoVcoubGBDYmT1Yt4MwFAxWaqql35+0zzs
	ycxRPHZNhijtHWmAUgIb18YbAFlgqce91CUI8ODTfEA1REMSPP+S0A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4ynq21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 09:31:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S8kGLS038136;
	Tue, 28 Oct 2025 09:31:51 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011041.outbound.protection.outlook.com [40.93.194.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n07xud7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 09:31:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7fcg02GYa5yXMlEI+cVVw6CyWCXd8/eEmnYUGpKhyDFbDc0+zRild5dOpi145VCMp1ZeNz7caFfFAyma3dvStwqGJqH/n2OuLBnn6CuqYvJVmzPv5HpzdOWZ4fzmVi4GKVwTbQj5n5LkjfXoGCywmkUPhDWaRYC6UyGTYQdd6SKyDMBTkpN1w9hn5zDOW1mfAr0QduaNDkGP8ac/rSB23aMmX7XmxvirGPOy+l1pJ0Po0OBcDzPHsfGhpMPzDGCuXsFEaBR6sS5mNa2PugF08scJtoOH6SmYu2TY7GMv8OGYkJY5ZBlpTkATCW8o6lwGcXE6fTfTr5MESEaenaPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n+AZ9J45uy5FJrJ4Ja8HtdqB2igZ0oVfRiYIMkYoV4=;
 b=emZmdYA4A7COSQIzMDM/hyOnr78nV/4IuxeKBuk+CCdMzZ2XIzxas8P/NEIB7VzTLEKLb4T1vSAH2ex3bQR8u2emdwzCLXyr0cxxo59S8T13t3WlHNnTMJjJQEFXjqOGpXdCTr2Z4x5g3DBBaomgLYqXFuhnEJWQnqGfauN7lx+OW75xSxvMaqgx86g4EGJ/jnrvmps7J60MR3bSusLBVBiN/PqpvGyippJQq39cWNENMB6uvOGauntoHmZtodeG+iUSxpbkQgUlDLWHWHC7CMfyYk2STO83GuCYfT1qkprUPu5YVeF8zyOSKx/CC9x0vMthbVjg+tBu+n7peabEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0n+AZ9J45uy5FJrJ4Ja8HtdqB2igZ0oVfRiYIMkYoV4=;
 b=cr8znN+WnsOPEpOJ1yuMq+58EIVCS0ofi66o5WQWn0Zhh+1NAkPyAXhAmpVbHXbRpF8d8H9H1kF49nFySdN8EbnF1Wx7sVdvzeBm9oIm/xJ7yMZF1VBXjKASig8OJojmKjmqDpk7gcQMaauSJ8+USBEsy6JIzor2q4RT1ufCgHM=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by DS4PPF6D651AD93.namprd10.prod.outlook.com (2603:10b6:f:fc00::d27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 09:31:49 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 09:31:48 +0000
Message-ID: <e9a3bfc2-2e9b-4ace-8443-52a951a4707b@oracle.com>
Date: Tue, 28 Oct 2025 15:01:44 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bpf@vger.kernel.org, kpsingh@kernel.org
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [bug-report] Build error in tools/testing/selftests/bpf/
Cc: Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::6) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|DS4PPF6D651AD93:EE_
X-MS-Office365-Filtering-Correlation-Id: d4afcb9e-860f-4ac8-93d3-08de1604d1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1ZRaEJFS0tRTTNvMVF1M1pZcEs5aDRyS3NZR1hPaFNIQVFQWUxaQXlEWmNk?=
 =?utf-8?B?SWdFN2Myc3dXYlRCMC84WGVaczZFMnFPbkdraXNGWXQrZjhRYUdXSDlaYk50?=
 =?utf-8?B?RFU1MkRYR2JJKzM5RHBxK0todFcxYkswT096b1R0RGxScUlZN0pRaWw4bmJm?=
 =?utf-8?B?SkViZytJK0taSGpUeXkyRTdZQzF2ZVVVcUx1TVhzd0gzT3ZlRzJQTDhsVTBP?=
 =?utf-8?B?blVUVjZLN29yWDNUeGw1cTlvajBibkNrbXhNRDdiN1RLZmJRU000dlR1b3VT?=
 =?utf-8?B?MXR4TTNSelA3YWtoeUJpM2JBbWtFTWxGS2kwMGowK01jOUtsZjh2SFpRRHRN?=
 =?utf-8?B?cDFqdTRxOTlad1duT0R4aTR1TlJzaGFieFFBVGJ3OHF3WS9VbSthV3liYkV5?=
 =?utf-8?B?WWFwSEN3MnFDU1hQOUFYMlo3V3pSZVZqd0hlc0loRGZPdFZJZnpRQWdzNXBP?=
 =?utf-8?B?WGRENkhjR0tCNzFRVWRVdEpWYUVlQjFPSjFSNytZaE9LdUtXS0JuNzJJdTZH?=
 =?utf-8?B?R1VkZGp3MzBjTTI2TWNZdUlJb3VJUUI5MjRmMjNiaDB6RVEzK0REKzVKNVVD?=
 =?utf-8?B?WnRLNTYwMEp5a3N1ZmFvMGlEVk5SUlZlM0l5VXR6aDI0L1Y1OWU3L0NjaFBC?=
 =?utf-8?B?aXhwOHRXVUliMG56R0hiL2dCS0FVYU1xOGpscW5Eako3NzdIVjFDbGRVOUw3?=
 =?utf-8?B?eXpJZDAxZmt4UG83cUlZVVNnZ1JuQnUwbXZFNVZielFQMW42WW9aRDdMNXZ0?=
 =?utf-8?B?alNuQkpYSTR4YUxudHhYbkJuZVh5aWNxdzJzWWZaUlBCSVNaVVhIdTVPRks0?=
 =?utf-8?B?MmRWbmVrRS9pTEZleHpTVUMxVlMwcDFvbkliNUlDdm5tQkZnNzlJREw0dnAw?=
 =?utf-8?B?eXZXc2d4bGdVWCt6VitQOCt4NmZCaXFRWFJZazBKajI4MTVmaXFRSUdqdWtk?=
 =?utf-8?B?TXlsemQ2NGd0b0c5cWJ1ZSttOGVaVk5JMGwrM2ZhaFR2dXhDREpLYmdySW9i?=
 =?utf-8?B?N0MvQVd0cUtQdGFCM0JZdEhla1NtUjZmcHVraURmcG5JaWZRQm5YY2VxUzV5?=
 =?utf-8?B?V2U3SWxlZTNWandPTWtNcnh1T3NqKzRFaXREd3pBakFmZjVScVVvM2JOTU1o?=
 =?utf-8?B?NDYvajRIWW5uMHdVWW52akNLbDlwMDhwaUgrMTBYM21rYlFHaG1FNUJGZWpk?=
 =?utf-8?B?Q2FQdXUra2tWR20xakNXQTRlYTRMOXphc1JuU2xmRkZxa3B6cmdSYzZxbkdG?=
 =?utf-8?B?dkJpU2FYbmVaZUluaTlCMEJhRCtZaDBlbVJVdEJ3MUZ1cHpPcEZORnN5cHNG?=
 =?utf-8?B?UDBHWEMvaHZZVSswQ1Frbkx4d3NrWE9SeWVOR0cwa2dYb1h2S0FJa3VTVXlz?=
 =?utf-8?B?ZmgwWE1GaTZjOGYvRSt5d1R5LzRwTE1DVHp1VGpaOHJYY0lXeDJiRDFranhQ?=
 =?utf-8?B?Z1BlUEgwNE1GMmFtR01FVGtJL1NNMnBkYWhjSVBtcXMyeitzdlMvL1o3d01F?=
 =?utf-8?B?Y3lvcXgwZjVQcDdDcXlvRjRZb2tNdkRWWEVMalhEdnkwYmhjR2FXbitKZFR2?=
 =?utf-8?B?V2ZUVmZrTUpZMWJKZWRTR2FtN2RLNzVndkl6V01RVmJDK3Z5M2t2bXRXZWNP?=
 =?utf-8?B?b1FFeHdzSTlYaDdNU1J3SytlMDBwZjBuS0RBUDZ1N2JyNUdvTzdOY1pVdlM2?=
 =?utf-8?B?V1VIYml0NlBIZGd1aEozWmFGWEhPOFFvMnoyRnkwVEpCMC9XVHFRYVpsQzVW?=
 =?utf-8?B?djl3UzI4V1VyNEFMV1dwVG5CTlUxSGRkRWJwbVNYRmRsQklIZ3VRUlNVQnB5?=
 =?utf-8?B?QWZJUy9tcWhYZkVZaCtJMFRJVmxwRXdlR0dGN3NjUU5seU0zcUg2Tm5LL0RN?=
 =?utf-8?B?SWpDczZhV3pZRzZ0WUt4Ukk4YTFRTFRYamRTQkxzbnNKOGVNUFNYTHJnUWZO?=
 =?utf-8?Q?J7veKX0ASKNhLuGBGREKpFBpTrNVJscm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzlMenNoeklrZVNnZnJUQmhHV2dPcFRId25na1RMemo0YjhDRWtWWk5sdjUw?=
 =?utf-8?B?MTBHb1BCVG55Tm8xblJXUE4vdi8zb3Z6bjhEY3NKMzVVK2JvcEJnUEJ3YjVO?=
 =?utf-8?B?L3BzR1FBM1E3R3I0eTlQbDNBeXc5VWR4cTZjNlR3bHV6QUdZUmxFRTdqeFQz?=
 =?utf-8?B?N0QwSEJKNjViR0pMK0o5VlZMejA1TmZOUGc4WEVaUkFFeVo3MmhMZllOM1lx?=
 =?utf-8?B?N0lzUnBURnAyZnNCUEhtZWJJYlhqdnVCUXFkVGt0N0RraVg0OE5mWW1wRkto?=
 =?utf-8?B?NU0xajJwMTJwYmQrYW5TNGFlNTU3V1FseFpGbzN4UHpNRVV1bHpJK0x6MXpu?=
 =?utf-8?B?aFdQMzhBN2R2eGlqck5QSFc5NEhQRVVZcHhrLzZVNGpyYkNGd21xU0Q1aDlt?=
 =?utf-8?B?MUJHMi9qWHFod2Z1MlEzdWR5RStWYlhhcHlCbExESHh0WU9JKzlxbFduVzNz?=
 =?utf-8?B?bUNDcUkyU1FLL09zeG4rWTRmR2VsNDUzaVBvbXEzaWp3dW1tdUZJM2pWbmU3?=
 =?utf-8?B?VnJ6QlRTMEtya3dqUkFRWEtWWmdHZ05OdTlSb0UxQWhxTTVmTXlPdzNHdFVv?=
 =?utf-8?B?RG5mNytRb3lkQU9iMTlHeVMya1l0UE5GaFZNRG1nQnBUM3BJT0NLeTc0QmpY?=
 =?utf-8?B?T0RKeGU5NjlUUW1kaFQ5TWtJanovZ0FOeDRJZnJFa2ZBMXBwemR1cTR6N2JR?=
 =?utf-8?B?Q1lUVGZVVzYyUVNIajRWQ3hBbGRJcTI3cy9YWjY3elJyWm5mcTJMcVU2T2t4?=
 =?utf-8?B?bXEyMUFYRDRlYTdWU1M5d2ppMkJ1V0ZHLzcwVE5jQ3NFQ2liU1VOWGVEdFBi?=
 =?utf-8?B?M1VSWldDdGMvMHRJKzVpeXRZcWRVbmwzb0NuTUY2ZGx5Q2NLa0h4ZkNUaFAx?=
 =?utf-8?B?R2JFUndXNXlkaGh3N3NDOEpobFk1MUQwZ1p4UFgxR1BneTRVaEZkSDROQWd3?=
 =?utf-8?B?b2FNMTJJOHVZSGFaTVhJM1ExUzlJZkd4Q1FDT2tsZjEvaU56MkU3K0RDSmF4?=
 =?utf-8?B?OXEwRzB5aGxUUElDM3JrWTdzdTR4QUM2RUt4bVVzc3NEMHRGbXgzaDQ5VG40?=
 =?utf-8?B?TTBSUmFBME96MTR3VGkrRHFsZTI3d3dzMGZPcHJrTmhkMEN3U3RMeXdqNlpT?=
 =?utf-8?B?aWxnNExmUTVoaVZNcVQvUWZXUlU0ckNzK2dFYWtyR1p0RUtGL2F1SmlCeUhi?=
 =?utf-8?B?ejRHSDMzUzhBRkVOTThaaFJmQm9mbXZ2MVZnR2NWVFhGMHZNY1dvVExyejhr?=
 =?utf-8?B?eE0rVFE2dytaM0hpaGJZVXdHZEJMRGJoSHNTK2l1NHIyRk5HV25hRkx1VEhY?=
 =?utf-8?B?b2YzS1lZN2dnUXREUnA1QVhldE1KOEJoTGtCclBhcThzU1locVlUaklpMGFv?=
 =?utf-8?B?M2tUcEt3MDJOVkhMSUpQLzhUQ2dOLzViNUVNNFk1NTJneG50OFJ3TjRPalhr?=
 =?utf-8?B?TkJJQk0rejVrZ3QySjhVenc2QUQ2RVVUZ0tTWEtZaHdjRUxRUVY1cnhTRVY5?=
 =?utf-8?B?Uy9iOXdaQi9HMGJicnI4cVhRY0F4QVArYng2M015Tng3bGVobWhYamtLNEU2?=
 =?utf-8?B?ZGNjQUpiVDRvaFR2SE5GK0ZTYTRSUnR3VkJKZnJHSExxWG1naFN3UFV6WnA4?=
 =?utf-8?B?aEVKdEdjbmlKVDYvTXF4ekVIQTVsZmIrUXpsMFZMSVA3SVZ0RkVFcTFObmh3?=
 =?utf-8?B?ek9rWXBQOVFkdzdPTFhuMEp6cmtaUUZCREVVTk0rSDhKQ0tWZUpqVUJLc0x4?=
 =?utf-8?B?OUIzYWkvYnpXWnVjVFIrMlVUMWFTYnFIWHJpQkRyS1dFRGpGUVNFaWRTSWxS?=
 =?utf-8?B?bVFCVkNUczZiMUpXLzc0L2U2cVpqUktleERJa1NtN3RkYW5iM21tOW9ZS1lh?=
 =?utf-8?B?eVdJTWFVQWFRNFpnQ0FDdUtFejN3clVaOTRvMDZ0Y1J2QjlhOHNKVHpXS3Ju?=
 =?utf-8?B?dmxDN2EwaUNYUnAyV25KamM5VThaMkU1aW1tRUlwK01kUjBMN20rY1g0L2JB?=
 =?utf-8?B?eGlSZ0tvK1NwV1dLY09MSWd4ZktDamM3WERRYUM5MHovdUhHdzFhRlc5M1Jx?=
 =?utf-8?B?K29NNHdjQ29iOFczTTZtM1p2bWE2MHVwWEI0U0VPR25Ob3pDdnRlQkRkaC9a?=
 =?utf-8?B?cXA4NjdWT0VXd0h0ODg3WDl5eG5sZkM1NlRWQjRvVjI4dG5UMStVclNjRFhm?=
 =?utf-8?Q?wpb4QvdK321G2mBieS2FTG8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qko9sx7PrEy50rJsoN76rI67108tYTqe80ukfZRpcsck4zKHmOMappzgqExOqjQwTZSwNkWVpYP0KIH13fwl7a2opleFVmOSH4SvvKmmMDbgsdIzuPniJh9aeCFabsxH+O2cL26zyV9eTrba0QcrYAAV6EOM0voEkj5T9RHsiixWAVX3/x2m3TfBKXAQqBWnDKXaPr6ZTq+wXn9bBhMBWK1oEPrLzn8KJwFpcsUMOqqZ+ylTwmG/Q4pe6Jt8e5qQPT1ef9yQGwQvMSb7kOJvx8ME0nXLofS3IgovA7d42pXjJVJhuuKU6ckhmfczTLeutqMYRs6ZYwStQ9Wp1KyIs2lbFKxU1P7fzWtlXYREAnJ8OwX/mJPTEKSlDCkKuPjHPt5JTohBknUkNhwNp5D9lh4jTPs+NlJP79mffPr3XSCwgDTj5R85o5XHKT8Ik3HeZhjFaOXVOHidymCnTWyfphi1jDpjx6CBkjC7tVynaMmSB/PQhGf0lbDpllFPswTajUj9xSrqOjfQnS8GsxQLTY27145fTFoNLfoGCOf3DHs3fD28eGTL8j2h8CEO7ORMlVbxFZ+OygcT862DNju5ZuEU7OUtwnO5PRyzXbtYp4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4afcb9e-860f-4ac8-93d3-08de1604d1b8
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:31:48.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKYzG+ZEGH9OFfPLpwAvqmfEhRLIoZtuc7O3FUo7kv7REgzgNG33iNIJYBAOQp/OjInuTyBJ44m4XldC5RvBiSSyt7YZAuUM175zSsZTDHufkswEbQ7ZV4etHSDV8sXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6D651AD93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfXyo+9tzuWORkP
 l8XWcZgvOlIdnaRTQau1CcXZNCaCvJl+JCmKqul3ApSuSGCv0+RWYQCT3mGqd/jHu0sxD84oe3T
 nMcJxpv/kUHZGj3dfLmCAexO4cW+Vre9TNxt6Rdfp62oz3f4iSJYbjYmd2NFjxOsTjPBN1z0swc
 cjvIeErIQg40zMQj+CnsDvtG7i4Nfi5d9EdvVTcZFtgedaXntpP/roTt4m13zYXQ9jIBWrBfNQD
 nqM58co5Y+1RtgRTYo/O/lGzJ/DJAuAaj6Lq2TR+Z1WeTUkoaKMeF16XvaQ4Vaf2LzHMfE6NgiZ
 ZSeufdPBF+1rFNspdae3FFmB6a3ExTcFzXUcmYXLOWCI8n2JoCe5L9gDYSbpZp2yVWbyBXgqL6R
 OzB6BHT2KNCXnx2qcoT8GITAF0K/hw==
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=69008d87 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hEgSYZlk5xyi-5ZPhZwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NtcISaKajocxhvDqulsUvdjgkxHKui_n
X-Proofpoint-GUID: NtcISaKajocxhvDqulsUvdjgkxHKui_n

Hi all,

I am seeing a build failure with latest bpf-next:


[root@hamogala-Kbuild bpf-next]# git describe
bpf-next-6.16-44604-gf9db3a38224e
[root@hamogala-Kbuild bpf-next]# make -j$(nproc) -C 
tools/testing/selftests/bpf/
make: Entering directory '/home/opc/bpf-next/tools/testing/selftests/bpf'

Usage:
        xxd [options] [infile [outfile]]
     or
        xxd -r [-s [-]offset] [-c cols] [-ps] [infile [outfile]]
Options:
     -a          toggle autoskip: A single '*' replaces nul-lines. 
Default off.
     -b          binary digit dump (incompatible with -ps,-i,-r). 
Default hex.
     -C          capitalize variable names in C include file style (-i).
     -c cols     format <cols> octets per line. Default 16 (-i: 12, -ps: 
30).
     -E          show characters in EBCDIC. Default ASCII.
     -e          little-endian dump (incompatible with -ps,-i,-r).
     -g          number of octets per group in normal output. Default 2 
(-e: 4).
     -h          print this summary.
     -i          output in C include file style.
     -l len      stop after <len> octets.
     -o off      add <off> to the displayed file position.
     -ps         output in postscript plain hexdump style.
     -r          reverse operation: convert (or patch) hexdump into binary.
     -r -s off   revert with <off> added to file positions found in hexdump.
     -d          show offset in decimal instead of hex.
     -s [+][-]seek  start at <seek> bytes abs. (or +: rel.) infile offset.
     -u          use upper case hex letters.
     -v          show version: "xxd V1.10 27oct98 by Juergen Weigert".
make: *** [Makefile:726: verification_cert.h] Error 1
make: *** Deleting file 'verification_cert.h'
make: Leaving directory '/home/opc/bpf-next/tools/testing/selftests/bpf'

This looks related to: commit: b720903e2b14 ("selftests/bpf: Enable 
signature verification for some lskel tests")



Thanks,
Harshit



