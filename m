Return-Path: <bpf+bounces-75432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D807C84212
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 10:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23DFD4E7A88
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E402FE59C;
	Tue, 25 Nov 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UUyOmLP2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UizPWCwh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2421B2FE075;
	Tue, 25 Nov 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061467; cv=fail; b=DBdkXcVy5THi+eHnjBhW5r8w8m/yoKuLsWHeFC+kgWcpXoVcTQGAo1uZYBb8eQLSVEkoAR1Exm7EMkcGXJZ6YF+HroI9mv6fi/Vw5AxvZ30NDSAB66+wu4Oe05X8beckK4JXVlpfUwlC7XS/OhKCpBS/DXT83m1sBHJE+kEHXPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061467; c=relaxed/simple;
	bh=lDfH7XyRK490yPvLwVtGaixFxbmWIbZXFiJeLOohRFE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i3eKedwPlum4vbPGvY1Jjl5/nd6aK2Oi6EeOVnX4HVTPpp65aShYR6lfGkD97U5cQeAPBOrgjC5CvtFA+HY9Vw97q+FrmS0mRkKKzr3a9Tu7QbSpV5XH/ThicFqWnKdnxfaA4gVNbsTfDHV+4MJnmrcUhF0qTEHIjnHaxouM1d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UUyOmLP2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UizPWCwh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1DYCO2394974;
	Tue, 25 Nov 2025 09:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ko2OjRPbSGOlXRqu4aQSSj4xeb2vQecO4cY1yjBPB+A=; b=
	UUyOmLP2cHVrKBvPI1//grn/nM0iCGGBZDI2R1GC70FEKsEJ/MS1PSrgC2vqkNJ0
	YFFP/58B9UOS9Hh/fVXW6E5pjpXR+VWvwSQSKrsiVlo3NI7t/btS3ZMqnox1R7Sh
	VOBbMAqCPVAOOd4elPWoAznQ93fiArmiC32j6FBsuV7jfg/HC0D4/jlnQdf11Cjm
	Ue5Rzo3lUG7y66O/Lkwzk+d5GPRJ8MyY1p2fUaBblO3RSDSqTe8RjCs1Hx0CrxaH
	jM2dOlBWgEg7uw6n8JDS/R7oJLb+pcZZdZXeoSYvqXEDUluM0QhJkCAXwYID168Z
	BhVGmSa/GTbVyR2fDl+Jaw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak811m3v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 09:04:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP7H1Sh022724;
	Tue, 25 Nov 2025 09:04:19 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mk7n91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 09:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6qRCDlBzW0FcJMZkqtNxZM8eMZlzbZCZeQ24NN3qnnxGjSQkP4lZOZ0PB0IlNHB9Sou+GknJ9e9hye8TDTMUkJc8h4NZ5usf0TyoK1XVriYCpiJtVSDl4xB2VNmhjjMuKf5tEyI8eNvQKXuMmG6fZb1/HrI3Iq9kDHDw9eScLRaenodNTdTDcQG0Wzx1OImbmv9nH1OImnZ5FIyk+0c2R5nnm7RLKT+gbQJx1CyaMhMn9iynvO/3vPCkaJ+kQzv7GhYH5PzEkX7nzwwEAVPMbTUDjy9b1F25OWIuKTqYghLYkrM/OwcQ4r2q55qvaeTXd5aEmK6+tew5DJIG15gXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ko2OjRPbSGOlXRqu4aQSSj4xeb2vQecO4cY1yjBPB+A=;
 b=fxo9sjYaLNVaaZduWsSUXfdsvaYLoTaTc7+Vlen9LBAxv6RW3giqJdcAcqjZs50YTy7evLqQHJokPaZSJxZSM1IAZ2kOdbZ+Nu/ZitiH7zpoCZH+GyY4/l+YzaAoTgXwdQtp9S4Go+EZ3Ocsx9YvbSoTKyxGSCAuQsTkOWin4T3fU0wp87zLEv6ZT8wm1oWirui8jrRceOsH4I1mpDz7oevGYbJKXItAPuSzGMTiPHIpHjP24Tfe38K2fEwR7AQ8bZhceKkjFIHLUhlwDnharmeL43rmwk36usZPEMUT0Z5wtlY6u8vVIGLXZxM+3U1wbDLZkWX3D1uVFunHV7POTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko2OjRPbSGOlXRqu4aQSSj4xeb2vQecO4cY1yjBPB+A=;
 b=UizPWCwhXQDPUSvY51d59K5hECu0NuEDSVBu01k1Wd8hjO+USvzZ2RxF2zEoYHzRp3CqyarqAh0KjC8SdhooeaxJlask/p5drQjBzdjwJnJxPg3Cs8/xVbIDV7PWfEq7cIp2zryDNGD2TEyKcDWPQ3DEaDbBFn5vWvQW/ckI7cw=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA3PR10MB8187.namprd10.prod.outlook.com (2603:10b6:208:506::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 09:03:45 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 09:03:44 +0000
Message-ID: <2c94add3-3cb6-41e9-8031-619c996aaf18@oracle.com>
Date: Tue, 25 Nov 2025 09:03:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] bpftool: Build failure due to opensslv.h
To: Namhyung Kim <namhyung@kernel.org>, Quentin Monnet <qmo@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <aP7uq6eVieG8v_v4@google.com>
 <2cb226f8-a67c-4bdb-8c59-507c99a46bab@kernel.org>
 <aP-5fUaroYE5xSnw@google.com>
 <d6a63399-361f-4f1c-845c-b69192bfc822@kernel.org>
 <7c86f05f-2ba3-4f63-8d63-49a3b3370360@oracle.com>
 <aR51ZSicusUssXuU@google.com>
 <fbd98bd0-a89c-4903-af06-fd1f2fb4ae16@kernel.org>
 <aSTDLrUqeZ3xwEhA@google.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aSTDLrUqeZ3xwEhA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::22) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA3PR10MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da782f9-e60d-4b47-ca0e-08de2c018962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekxFSUZ0NUpFSVVZbmUzRTNkaXpFQW80VStCQml2R0kwMWlNTUo4ck1rdE5C?=
 =?utf-8?B?bnJBS3BYeXBtckJNalRVYy9EL3ROd1JFREN3Y3o4eENpU1dqM3hNeFByVXRZ?=
 =?utf-8?B?MVFOWFdhYlNabkJhN2hDQnNCWkVOUDJ6WGNyTlNIY29mK3JCM3QycTVJeGxa?=
 =?utf-8?B?Wkw0WEtEZ1N3NHJoZzRiU1c0bDkrTlJTSHhkUi8vT3ZnQ0pNQytMZ2MxbmNy?=
 =?utf-8?B?bWpGR0phRXYrdWhtZit1VWI0djhwSi9rditVdzgvNjJvd3JHODNqeXBHamxz?=
 =?utf-8?B?VlRWWFpZdmFMUEU4Qy9wZEx4aC8zY1laZ29Wbm5LWE0yQWhLSTFrUmdTK0NG?=
 =?utf-8?B?SHAzYkwwTjJQdVk2MDIrKzY5Yzh1NU1rcTltWERybGpPanorYXpndmNRZjgz?=
 =?utf-8?B?NEd3OHZaWE5wUzBiMkkzelpub2huRi9EZVNOSElXZkxKclFwdkoxZk1Iam80?=
 =?utf-8?B?WTQvR09yL3g5SjdHYWdKVGh6U0ZFamFNS2pXUWFrM25HRTJFanlGelo3UnBF?=
 =?utf-8?B?SndJZnFJZytNa1NuN3RYRDF4cHh5RzVUaVZCMklEWldvWFk1d0xLQnYyOHhH?=
 =?utf-8?B?NjlXYzdkUHQ4S2lndjM1RVBNNGpJMUx6TnlSdU54ZlNqWnJMMzdFL1ArcGda?=
 =?utf-8?B?MXhFZzhsaSs1TVBYck1IWHZWSHVWWWF2d0RnbUJncFZ4WXlBVXJFSDdJRlE4?=
 =?utf-8?B?KzROakR0dEsvYjZtMkMxakxrQ3pNdVNuNWx3RzAyVlFiWHlld1JwQXlXay92?=
 =?utf-8?B?elRlRXJsR2s4YTl4SkpiWmJERW5jd2t0N3VvVkVWZlRHaVh4cW1NTlVDUHhj?=
 =?utf-8?B?dzdTd2YyeGtzYzMwTkE1UjZLUVM4bVFXc3o3RXhZSXJaSFJsQlhDVGtxc1Ba?=
 =?utf-8?B?bVlyUkR0T3UwSUZYdXVGNnhPUnZkM212MkduM05XT1JxM0lVenhEbVFmWkt5?=
 =?utf-8?B?blNYdE9vNlFTSCtXclVzclBBNzJUNS81Y3BQMTd0cUxSaUtpMEI1M1VwOFJR?=
 =?utf-8?B?RHdXa014ZVp5YkN4MlB1cFNTSEh2OFZnNE9WdkNmejg1NThmVE9aMWtuaStE?=
 =?utf-8?B?cVArZlZFM0FQZnl3TU9ITlN5UlBvcWlhanpvMlRra2FxWUNVVTlRc1lRc24x?=
 =?utf-8?B?dFlNM2FGUzZXWEU4UWJ4RnZBKzZGZUlPYkxKWXNWWWFUcERva0hnblVQbENQ?=
 =?utf-8?B?bnV6cytJLzJIRGNpeGZsSHEvblVoMk5vY1hzUUVEbEVXMG5rVmE3ekJQVVZM?=
 =?utf-8?B?SC9nQTgvVitsSnRSVXBrdUtuNk9JVnVIL2ExYzN6Y2l2MGMvUytRSVdUSkZl?=
 =?utf-8?B?bE5HWm1Vei8xVVViekVXb1g5cmZHNVVMVTBSZmhneE5TZmdDamlvY0JLbWtj?=
 =?utf-8?B?WE1kdTVXdGJUWFV1b3hiL3dGd3ZXaGF4QmN0SzJjeEJic0dnVmxDZU54UmtD?=
 =?utf-8?B?K1NnQjRhWDRYNmpHd0kvTW9VN0JLdC9tUXhQQllpR0JGSkxnb1QxMGFtcXIr?=
 =?utf-8?B?dXlvcEJrQ0dnRlZVYUJreXVGMGZxdldydE1iaHBZOU5WRGxqWlZQZnc0eXBk?=
 =?utf-8?B?b015Y09La0hWazRPUVBJWUJ4cVU4Vi9QSFFHaXdsMnp1T0pHb053MHA5NHJ2?=
 =?utf-8?B?T1p0S2drVEplWFVXNGFmYTYyUG5zeWt5dUJkMTcrc1FnaVJKbElzaXFRT2d4?=
 =?utf-8?B?eDhUMWZ2dHppa2tRZS9HRFM3TU1VLzJ5S0E1QmRWNERKSVVNMnJGMWlLN2Fu?=
 =?utf-8?B?empCOVNqa1J0N0o4bTZUQ3NzeGsyQTJSTFhIYlFGaXNRUmtRNURJZHJjbU16?=
 =?utf-8?B?Q1AwL01mdjFNLzFkZS96Y3NlYktSclhVYmJPL1NrVEljak4zODNrSEdkV3hN?=
 =?utf-8?B?TXNpbkNhR1pEQnIvdUJHNTM3WGZKb0JNZFdObm92M2xPOWozWXR3azEzeXpJ?=
 =?utf-8?B?NFhKdkd5UmxVbTdualdPY3ZPbHpJWGpQZzBrTlBQK0RPRXovVitSUzdCQWdY?=
 =?utf-8?B?MmUyMTRQbUh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjQ1UGNzOFo0N2VhYmFoVjFudkl2NjgyUkh1YUdPdU4wcmcrQ0xEZWZGRFNX?=
 =?utf-8?B?aW9DRnppcWxqSzhkQWpPcUE0UVJPOVlEN3JGNDk2ZlE5UnFtNXdPRzVXTnpt?=
 =?utf-8?B?QUloRjZTOEhJck1Nd0loTXB4YzY0cUo3dERCSEdZNmw3NmVsMzN1eERLU3U4?=
 =?utf-8?B?OVdQeWtXaFYveGJObGltVGZadlJCTHdrYXQreGpZTklkSmxpSmNsYTBvc1dK?=
 =?utf-8?B?UU9nR3h2Mk9aaHNCVVh4b3JnWG5ZUjM4d3gvZVNVOEJlY2MySzZocW81Q2V5?=
 =?utf-8?B?OUdMdkxrWTM2MXN0Qk9yazFIcEsrcXlIQzJVUWo2VHYydXk5bG11Um1yeEFW?=
 =?utf-8?B?cUFuSXF5RDhaSjZxVzFNZVR4aTZFRVBlejlWUVA0YnVYbWNXU0VKb1hJbTNR?=
 =?utf-8?B?K3pPc2ZXTytNbjdReHMyK1dmODR3ZWlPbm5KVWkwbDBOL2FhTUdXT2ZRNlQw?=
 =?utf-8?B?eWM5ZnlqVjhBU1FHaDdnQmJ2K3BQWXBZWFZZZ01jb2ZJMjFOV1I4Z3U0Q2tJ?=
 =?utf-8?B?SmErZmxKNUhaWU0rTVNEM0ZjaUZ3REg5QTVWUkthN1ErZXNHWTVFT1c3SEtN?=
 =?utf-8?B?Q1ZGRC82d3ZESmM1NjdBVFRLRC94S0w1dVB6SkxPM2N4TWVvNHdBRk8zWk4v?=
 =?utf-8?B?RktDWUN3emJJUHBFZnRKZ3lFRG96WWN3MUpWYUo0M1I5SDN4YjlHWS9yQnFq?=
 =?utf-8?B?RXB3RVkxem5HNk95TFBJSkR6eWEvbEsyR05abS9YRVVtR1RxdU9zSXdacWs3?=
 =?utf-8?B?M1JpTlEyN1lHMlJRN0pmakVhMlhHcTJqMS9LYkpFQWNla2gzSXlvVjBjaVE1?=
 =?utf-8?B?MC94M1FSa3FTNEY1UjVXSnpiLzRkWFFjZGE2OHNnQ0dkbVJ0V3NlbllrSnoy?=
 =?utf-8?B?R0FsVE0rRnVBVHI1T3E3MWIxbk0zQVZIemMrQVZiSjQzL3VrLzYzbmN1d05J?=
 =?utf-8?B?L1RSano2VllZejBGb3RQaXlmWkRiblVTYW9HaEhCWTlvUnBGMEVrRHMyUHJ0?=
 =?utf-8?B?TTZaa1RNK2ZJR0U1RGZuVEd4dWdvcGhOcDlpZ1A5SFZEYWdFeG54c21EeVNm?=
 =?utf-8?B?bmJmbFZXaTZ3VlRsR2lYNExRSmY1VGVxOXdaMWMxc2tFQkZvSHRyaVF6Y1lx?=
 =?utf-8?B?dUNnVUJTbEE1SHJpRnN5M0VUdkpwOWVBSXBoZTRpa3NxMThiLzduTFk1a2ND?=
 =?utf-8?B?VS9HSDBESXl3TW04Yml4ZnBza1oycXN3Skk2N3ljNWdBZythYUluYzB3U3RL?=
 =?utf-8?B?RW1vNklrOWswdVdNY1lOaWRLVmhDL2tUdkE2aXR1ZmozdktuK2FVRU1PWTJh?=
 =?utf-8?B?TEpuOFkzSVAxUU5JdTVWbTVsTUlGTGp6VnplZTlIN0hQLy85eUFIR1VUN3Uz?=
 =?utf-8?B?ZlRlbmQ0dU5sTTVKMEZtKy9qd05qanQ1bldENjBwOTNQNEZXYUp6M1dYZDRZ?=
 =?utf-8?B?Q2M5SWt6UitPYmZUOW44c2NxZUY4a3Ywb3Bvck1WcWd1bUdQMGgyRlcvbEZX?=
 =?utf-8?B?Sjh3UUd1MXRLb2tmbVlXVENScFR4V2ZRZHVlN25ySmFPOUorQytqaFFSRElN?=
 =?utf-8?B?THBTL3ZILy9SSDgzeDBZY3NCR3BFUTNtTTc4U2R0ckczcEJ4S1JWV1lBTzdr?=
 =?utf-8?B?RTZVZiszVXN4aDdZZFBKT0FJVWx3eG0yM05iUmwwUnMrZUhJcmsyQU9vdnJv?=
 =?utf-8?B?L09SaEd1SlEwTlk2TDNPS0ttV2JsaHMzeFRDaVN4RWxTUVpmZFlacUNDSURn?=
 =?utf-8?B?N0tpNzVpZDJiT1BqemhqSEVnUkpwRThTNVZDc0tOUzRjUHg5TCtZR0V1akUw?=
 =?utf-8?B?dWgrcGZpRWhFSFJmcW1uK2xLMm9MbFRkWFJocit5ZUFZdVYrSjJoVDNrSUdk?=
 =?utf-8?B?dXZwTERoR1ZFeGtlRlA5Tkl0eCtFdjRkTDRzT1NwTXh0ZDMrWU9aV1RlaE1q?=
 =?utf-8?B?Z1k4M3B0TTNhRHgvOHRDUkJFL0R2dWhTNHg1U2YwZS9lOVZvQVdlNXlaWGxE?=
 =?utf-8?B?aUVNY2ZCUDRYQ2Q0aEVyNnpKNHdrYWFDSnZOWHY4eU96R1JhUmpMdXM2RTl6?=
 =?utf-8?B?V2cvemJIeDBJUmxSaTI0MDV6SHFCdFh2RzhWT005eTQ0ZmJYcGxxNjdYTDdk?=
 =?utf-8?B?S2hQbWNiNWFRbUNuRFZVL0xHVWtIQnM2M2NTdnNHVXpFbW9sVVpSN0E4Zlpn?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	29xpUF10GapMeG0RRUMRmsbHBkkH/RiUlWj9sjyclMxp6k2z91ONNAE+AJYgTVnqd2yYzYPVd4pADRReq1u2KyTv4TQrgibdECZUdma3uRK0ZzaiNvE44HvNLr1M29j016i1z0RzoRLFkdFVW5JBpjP5Yy87kmp4ho7LdEyLkXXvHnyEhHRaOqYb6WCcHg8EqRCbz4c98tl/jtkphZYZD8PUar1dMk5zUhpjysTSYKvvPFGDElEO9O5L6eA443Q7qwy3+T5jkuSsebEEp9lFIHr/2HE3klLSaJ3XDmwBiI9CwSy9qmqKUEKwEGudTOzf+N8KaVGi9kIEyXcNde2g/sXNOi/i0+ar7+fxREG1RAYroeEhpB/xBKQSoXnOpf05NCx4M8V+OLgbXIo0oW+/MXQIoc6rAbeBiMKtUpfH2T6elKjfqOFnXjjW9bBGZSu06vJiw0MUp1VgFfgwJ7j+0XixKrzZw0DhDW50czn1bpOT3Ub16C2VUnvEUui9ki+zON8SpEcthO+xsH9SoPWWOA2Aasbri45W8bKHXfPsyBPNAHbBDXfi27erqtr/moH5KQGtQ9+pYyaZEG6vdGb/YV7KZQKEKMEiRHfxplzz8Dw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da782f9-e60d-4b47-ca0e-08de2c018962
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 09:03:44.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctyKzzXO3WwIi8Vz0IMpz8vgjkkajKNmSsCAS81ytY7jc603QizFGAfbGTPREBm+wOT8mfnNEdT46oQUQntICQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA3MiBTYWx0ZWRfX/5GXoQyJWSHJ
 9Je+BM7BFe6+9L1R/rJlyBT7VVR1FG4opqB7id/ZZiIL88qoLcpw7vqIwoyzGfNmlBxrYNZgXr6
 8M9Oj5Rrb6v7R3BQl8Hgu+lFg7B1AWv3zPoHMKldsV4CCdUTwxZDlrjkcXrVWPa13JAXvTHl1vf
 Lo6Ev7IqzfhYuBkmhih5eM3leuuN+bqCK9ZLQ4uJN244De2vjXhzEBMcTgNa1p+apUaIYUwkNZp
 Dh2Pa1cHE47ae0A9PyWa0c51+1GdCUdNbWptzUXvM7z4gmWIwcdZZXTrFJ8UQLZlbX3x408ShiY
 hGa0P8QGoTqISgmGJTIB46ZDvc0y+nSvTnz1nyjkECxX+ZOouGaY8Paxdwp1T15ecT8GmDOw9me
 UYe0fM00IwqgqzOKdOV+jL8AnJE8rKAu5FHSuccbiV0mUrTvX1M=
X-Proofpoint-GUID: Rnd8Z4J-odBfjfLamstduQogbvRJrWU2
X-Proofpoint-ORIG-GUID: Rnd8Z4J-odBfjfLamstduQogbvRJrWU2
X-Authority-Analysis: v=2.4 cv=KKpXzVFo c=1 sm=1 tr=0 ts=69257114 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=iaA2TiwMW4tuG8WlDlUA:9 a=QEXdDO2ut3YA:10
 a=mb2HYd0p4foA:10 cc=ntf awl=host:13642

On 24/11/2025 20:42, Namhyung Kim wrote:
> On Thu, Nov 20, 2025 at 09:24:49AM +0000, Quentin Monnet wrote:
>> 2025-11-19 17:56 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
>>> Hello,
>>>
>>> On Tue, Oct 28, 2025 at 10:20:22AM +0000, Alan Maguire wrote:
>>>> On 28/10/2025 09:05, Quentin Monnet wrote:
>>>>> 2025-10-27 11:27 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
>>>>>> On Mon, Oct 27, 2025 at 11:41:01AM +0000, Quentin Monnet wrote:
>>>>>>> 2025-10-26 21:01 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> I'm seeing a build failure like below in Fedora 40 and others.  I'm not
>>>>>>>> sure if it's reported already but it failed to build perf tools due to
>>>>>>>> errors in the bootstrap bpftool.
>>>>>>>>
>>>>>>>>     CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
>>>>>>>>   sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
>>>>>>>>      16 | #include <openssl/opensslv.h>
>>>>>>>>         |          ^~~~~~~~~~~~~~~~~~~~
>>>>>>>>   compilation terminated.
>>>>>>>>   make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
>>>>>>>>   make[3]: *** Waiting for unfinished jobs....
>>>>>>>>   make[2]: *** [Makefile.perf:1213: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
>>>>>>>>   make[1]: *** [Makefile.perf:289: sub-make] Error 2
>>>>>>>>   make: *** [Makefile:76: all] Error 2
>>>>>>>>
>>>>>>>> I think it's from the recent signing change.  I'm not familiar with
>>>>>>>> openssl but I guess there's a proper feature check for it.  Is this a
>>>>>>>> known issue?
>>>>>>>
>>>>>>>
>>>>>>> Hi Namhyung,
>>>>>>
>>>>>> Hello!
>>>>>>
>>>>>>>
>>>>>>> This looks related to the program signing change indeed, commit
>>>>>>> 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
>>>>>>> introduced a dependency on OpenSSL's development headers for bpftool.
>>>>>>> It's not gated behind a feature check. On Fedora, I think the headers
>>>>>>> come with openssl-devel, do you have this package installed?
>>>>>>
>>>>>> No I don't, but I guess it should be able to build on such systems.  Or
>>>>>> is it required for bpftool?  Anyway I feel like it should have a feature
>>>>>> check and appropriate error messages.
>>>>>>
>>>>>
>>>>> +Cc KP
>>>>>
>>>>> We usually have feature checks when optional features bring in new
>>>>> dependencies for bpftool, but we haven't discussed it this time. My
>>>>> understanding was that program signing is important enough that it
>>>>> should always be present in newer versions of bpftool, making OpenSSL
>>>>> one of the required dependencies going forward.
>>>>>
>>>>> We don't currently have feature checks to tell when required
>>>>> dependencies are missing for bpftool (it's just the build failing, in
>>>>> that case). I know perf does a great job at it, we could look into it
>>>>> for bpftool, too.
>>>>>
>>>>
>>>> One issue here is that some distros package openssl v3 such that the
>>>> #include files are in /usr/include/openssl3 and libraries in
>>>> /usr/lib64/openssl3 so that older versions can co-exist. Maybe we could
>>>> figure out a feature test that handles that too?
>>>
>>> What's the state of this?  Is the fix in the bpf tree now?
>>
>>
>> Hi Namhyung, Alan just submitted a v2 of his patch (targetting
>> bpf-next), see:
>>
>> https://lore.kernel.org/all/20251120084754.640405-2-alan.maguire@oracle.com/
>  
> Hello Quentin,
> 
> I'm afraid it doesn't fix my issue.  It seems to fix another problem
> about the error API.  But I still see the build failure.
>

This header file is delivered by openssl-devel (could be openssl-dev on
some distros). Looking at [1], it seems like that package has been a
requirement to build kernels from 4.3 on. Is it missing on your system,
installed to an unusual path like /usr/include/opensslv3, or is the
package perhaps missing some header files?

Alan

[1] https://docs.kernel.org/process/changes.html

> Thanks,
> Namhyung
> 
> 


