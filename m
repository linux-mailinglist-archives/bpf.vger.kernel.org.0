Return-Path: <bpf+bounces-65066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 636B4B1B730
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 17:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54AA1899F3F
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27552263F3C;
	Tue,  5 Aug 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kCRKYslq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XVgTjEb1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146A2797AE;
	Tue,  5 Aug 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406575; cv=fail; b=ujteEIRo46EwLNkP9V5QtwoAnH9ILTy/1AC+bnaR9nZRY6XfzN1hj4+25Vcm0UFyvjA2LZrycKbPTtBJJupKcdGKk4xmTYCfCTOo+Wqip4VKx5QY3a2SWVfz2IutFMhb/1a6u1J2nrlu6AE9mbWvytwD7AaCIW2hToiaw/LkDko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406575; c=relaxed/simple;
	bh=24ofIgoi/Sfy3u5Rqp+ZRe1XTjuqHVHyvXdyonazv0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jgk0Oy5e9RmnHU9q8AsckXgPBr7vBa2ewjDtwvgp0+7ardL6lPPBtzpmIoDVo6SqO0lQ/EB30Xm85Jm/4HFkaH8P7Mgpi4C2R3dnmnbn0ytAlhyLRt19UVt/6n1h4e9kIG0efDLAOG8nhCOVj05MoHbt8hw7Nl11UmRfKy5hD3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kCRKYslq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XVgTjEb1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575EpSP0022374;
	Tue, 5 Aug 2025 15:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NaoFPBV3olEFoSrUScj7+XfPSYEVa/5N6klojBPwJnU=; b=
	kCRKYslqUL7q06qY+TD0Pxi1gaooa5FDEG79+szz/Ma7gW19769HBqy5gkHHUvN0
	z8QUKoA3/oT+UDPbvcJKTQ9OoeQfhV/Lexeb8QXNT+NfWXee86VWXAfZ29ivOJg8
	hswrVuJACz9eXByRzV6LwvWh0aowsX4012BU0VgT0EYMfvlAi9KMarK5s2iwmADO
	c2/sxd4Up7ftoMk5rddyoEEvIKh0tfZ1f11ogBv46xIHR3xkeSGqsdRIRxD65/5t
	Bh5XAnlk5xyZzpTuh1OzIM2wvfLU7QPB0LhYYSRQe6Sp6LMiq/AlGdebM+SxNBzF
	347gkOy0ExsQ52UFP3GpIA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vvy28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 15:09:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575EkPUo039860;
	Tue, 5 Aug 2025 15:09:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7jw241p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 15:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt/S2P0ZWsddXDbUr/7Ug2abefCiQGXFobYM76PpI5yzJWWkFt7u7xB7gqkXPdQeTPw6FW6TmmUS0UnrF0Kr5tUUMavadZUfx9vLKvCPhs0V6DQ7gyrAnQiY1A7y7ZVZsed2C33OFT4D7Hzoayb1YOhVnQRnHqzwtjKPbLEOwEe0phmLD6NPjFQMzenGfnzcUbm0sw9ZsEktP3mt2gI6G+AdaM5ecZF+kl3+1Uo4fI0Uy+LY4mKlW3FWotkCaXz57bQTsVUENMfX6WUVbaGeNtJLRKesQqmXbQHKLQSyuLZYduJo90G22FhYkd/+DAcp8PJ+UQUvTbEZhjs5BTq2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaoFPBV3olEFoSrUScj7+XfPSYEVa/5N6klojBPwJnU=;
 b=RWVq8BCLNk9CFVcn8MuIeHGwZ/+ki2Sd8klFj7r+zOw6L5JQ5IR60x8b7kdxeer4lUQQfH2cebBw9fi7BLd6bYpqYR7/dUIhme6UtxtxeFZ8AQIdk7Ibs5N9/aa0SUT7YgsDkFkV0/TVx6pqkyeG5VNeeeV8M0w+C2nxQnEhXyUvK/I1wpZkWTj+MwvsuZfFpBEmJziXNRneoJiCbbIRiVUdfS5h0/cBGCwS8ZhS3qQxCEq+F4/14mMs35tDhSjL8IHZO3Ehm84oz8+mg4WGmgG/A2sNzmWPZ0ks31i0rqUKkpsSDNRsFNvVzYtn6/3kdgvnoUlFKiVTiCpgaQ7BaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaoFPBV3olEFoSrUScj7+XfPSYEVa/5N6klojBPwJnU=;
 b=XVgTjEb1g/l82EiLaS2czsemEYYsBygwESiqL4iqc5DHFiuJipolb0TXZxC1kKpb7Ov4wrzTF5ab85HMEzOANr5xgjlIGKDJbgdBFhl3BiSi6FcXeLa0TSiezCGunRDmsDHFjKIDnEOU5ybkKqxI20LXXYlznebbi/GzRS3mbMs=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS0PR10MB6173.namprd10.prod.outlook.com (2603:10b6:8:c3::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 15:09:19 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 15:09:19 +0000
Message-ID: <7201b814-aeb1-4f1d-b5f8-3178be1e29bd@oracle.com>
Date: Tue, 5 Aug 2025 16:09:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] tests: add some tests validating skipped functions
 due to uncertain arg location
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>,
        dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bastien Curutchet <bastien.curutchet@bootlin.com>,
        ebpf@linuxfoundation.org
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
 <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS0PR10MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 55adde24-6122-48eb-cd4a-08ddd4320c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2xJaHRwQStWSnpDRC9vMmN4QVovU1YwL1ZiSmVoSWY3Yng0VjQrcXVYVWpM?=
 =?utf-8?B?cTVwVUYvNUFOQm5XTXV4SisyamF0WXlTY1hyNlpFbCtGOUM5b3JYU0EvRVRi?=
 =?utf-8?B?Z2V5ZXFMTFBpY0dwaFVFUUVBbjQyNWtxbm8wSlJMcTdrTXRTSVpueWtSTTRK?=
 =?utf-8?B?RTZ1bUtVV081cWlyN2hDdU55aFQ2RDU2WDVTcmZTYWpFd3pKTUlVNE9sckpn?=
 =?utf-8?B?UlRZUXJFalBZUGk4YUF0YklvUEZ1TW1xRHYwbTljWUNvdlNxK2p2bTA2ZFkz?=
 =?utf-8?B?UVp1VUVMSkZJMnFRck9vaW9nZGlxckxuMTV5VStmN0pFeUZDNU9iMDFiTEhR?=
 =?utf-8?B?VFBuMDRiMWpQTFZxa1Y0NHdmTEJ4WkpnbFhLTldvT3psamJrbk5jTzByamk1?=
 =?utf-8?B?Z2FMbnJWY3VvQjhPdzlidmt3SjRJQmNIaW4vaElNcE45bW5GdlI5UlNxekx4?=
 =?utf-8?B?YVRXZTRiV051ZzJkR2hhZDFRUTB0SCtaT3IzbnZOUW1lU1k4bGpzamp4eWJm?=
 =?utf-8?B?eEJFOGQ3ejRRdDFuNXdPK1hpZmVpY051d04zUVV5VVFWNjExZGR2ZjEyQ3JL?=
 =?utf-8?B?bEVpdGFTUWhvVGZuQUJOdkkvNDl0aW5pMTZTUEREeFphVkFmWmh2dmd6Y2xo?=
 =?utf-8?B?cG1sMzJISzFodFo2K2llNTl1c3FVb0h5aisrNGE0ZSthNEFFTmJIcVFCWmJM?=
 =?utf-8?B?bDdORG8yaDkrQmM3cG5uU29ZWEZSb1Ixa09HbjdUUTB4dEEyalJKNm1uTkpx?=
 =?utf-8?B?Z09WdTR2VERyV040ODFyN2ZJQVZXc29sTFVpYmUxQXdmL3AvaDFIWTJUU2Fw?=
 =?utf-8?B?eFZUTWtLNEN4WXg0eDdob0d1blluUWtjQVNicVloamNPSXVMaUFDNmgvdzhl?=
 =?utf-8?B?NmNEc2p1MnpDZ1U2aldPdk9XVksyR2g1NTlHaGNidzVtK2FLL1hDVk0zVGRC?=
 =?utf-8?B?M3NPcGJ1azhmOW54SGZtWTV2R0dNNU9VeGFCNVFXRTFueDZEQ2F1Sk9YUGlT?=
 =?utf-8?B?alpEdXA4cFg5N3p2bkhZaC9tWFZyZ3JQZk1nVlFxZ1RrM29ra2N6S3NoczY1?=
 =?utf-8?B?ZVZ1aFpkS2FIcnRkZXhtQ2NabEZIbGIvK3MrYUNOZGdSOG1KZHhndnlBSWlq?=
 =?utf-8?B?NldKOGtHaVBQUkNsLzVoY0EzYjluM1RvSzZoMGRSYUVRU3RlRWxGcnZMOE5l?=
 =?utf-8?B?Y3pEYm1IaVdjN3RUMGtKdVJEMC91b1A4eG5BRXFDbXZzaTVvSWZkTW9XQkJx?=
 =?utf-8?B?MWJFeGhrcmNKdVd6b1dzME5abnVhU01DczRSZkZhZTBmZGdyeS9aNjVJNTdw?=
 =?utf-8?B?RGduTFlLUHNuNHM3aXdwRFlCRVRQZTNaZWcwck03ald5bG9BZDdFTmtORDBh?=
 =?utf-8?B?dXZwaFJ0R28xbjVCOEdTRWZOUzVVNWErR1dIWnk2N1FBcHhsNTVPQzcxWFBu?=
 =?utf-8?B?Qld4endNLzFtV0xNa0crVGI0VVlYU1kvWlNQUmg2VjVOVlRvVitYTVJDWUZ1?=
 =?utf-8?B?RkZmNnNid1Ira2pZeXZTQ0FLaEYrVXFWWXE3WFdTamlVYTBHS2QxMUszbGNG?=
 =?utf-8?B?cXVlQ01FdlJMNEFSWVVwWFEvSEVrWGE5RWNBcmxjKzF1enJOSHBYT09tRXVq?=
 =?utf-8?B?RzFCbzBNQU92VzArQ3c4OEhHd0oyb3IzOWlrZWRGQTZ5QXR2bTJqQS9pVUlK?=
 =?utf-8?B?eFBmb2JUSnJMQlhOczgzelVla0ZFQlZsd1dXT1hVT01PbExjaUovV0Ryd1Ru?=
 =?utf-8?B?Z0Rmb3YwM2YwODdVTGgwOWo3ci9ldmY3ZERsMHRzbFlRdlN4S1Q0MVdFWVEy?=
 =?utf-8?B?VytoNkt6dzVhYkp2a3YySmVYK1dZdzEyVmR5WEVldVkyUi95dHVRd3dRamJx?=
 =?utf-8?B?M21qVnVMaU5QNE5LQi9LTG5ZT0h4UWcyWk1FZ29CLzZhaS9Kb1pUd1g1T3hE?=
 =?utf-8?Q?h/9xp6Y56P8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlM2Qmx2aUdFVWFNNTZ0dHFST1dVaFlLYUJNSzZoUFRtWUlmL0g0OTZVSC8z?=
 =?utf-8?B?bk5lUjRuTSs1eXowSDlGR0FMd3pmTG9jUmFCcWdoUkljaTlHcW1Ecm8xdjJF?=
 =?utf-8?B?VXZQcjVQeHc5N0RaanpPNlo0WHZweWRBQWtvNzUvSnlESElIWGJ5UEVSbEg4?=
 =?utf-8?B?UDkvamRQMmFVN0gyN2RiZDdIMkJQeGJHWWRPemw3Y1NQOWs3Y0FDUDhpdlBr?=
 =?utf-8?B?c25LYkZ3WjFtMVV0bHBWMkFRRENNOU9SL1ZIUXZxVFo1end5MWRsR250bGwx?=
 =?utf-8?B?L2VRRFhpWjBNSTRPTHRicHZYOVk0YnZHMVpCMjRJK285UHJSbm5oQVZsb1Vp?=
 =?utf-8?B?bTNjWmRtdFNKdUVPNVBYa2lYWUV0azVqNUczeThRK0lTYTBSSmdrMUFHTU9P?=
 =?utf-8?B?VEZna0c0MmpjUVAvb3V1Rkczc29HWmZmclFDWFp0WUFrcXRYOHJEVGZ0NEcx?=
 =?utf-8?B?S3prbkZYa0JkVTRhdVpjbzhGdUdEN0pPWi9IUkp4VmtUcHhINXZGazFudVps?=
 =?utf-8?B?Z2JoUFE1N3hVUkFWbW45d1hsN2V6aUd3a1ZhWnU5OTd1RHhsL05kWHJFZzBH?=
 =?utf-8?B?MlRsY200WGpWWk8rUFdKeVBVUHlCbVJ5UkFHWU10QXRQM1BGT1pCK0tKakg5?=
 =?utf-8?B?SXJqZHJzOVQvaHU1MTNHcDVxakRwQ1Z3N2VOQ2xpeU53SHNoaDc4dnJObG1Y?=
 =?utf-8?B?cjRpVmxVd0lsNG44TTdqbWZPakFwYWROY2NKOG82MzRrTnBJZWYwWmxHZ1Ft?=
 =?utf-8?B?Zm5JU0hiMWJsTVpidWtJZUR0WWs2WVZ1YkppM1VJUFZ4REJhVXkrM1JTblY4?=
 =?utf-8?B?eGpMVnhNZm9rWlo3Q2IxYXlLS1ltcDZLQ2x0Vm85Wk5hcTNOck5qQ1FCQWE1?=
 =?utf-8?B?T25JMG9iaCtPalMvUytHTVhrY3BSejZUN2RiK2p5MUk5QS9veGFta25ySlJv?=
 =?utf-8?B?OXhPbm9uTW9kczNYdmQxdVdJS0hzSE9tYmJNY1J4K2NMZUpJVHVEaHNSZ25D?=
 =?utf-8?B?Qzd6SWlXTER4ZitSY0hoSWY1dkNIOGNXUHlheGFtMEluRUFoUjBtV3U5andX?=
 =?utf-8?B?ZysxU0Z6SFQxRlZtRy9NOXl4a3g2a3JjTEhqTE9ESFVJMEFqUEJqRUdieWVr?=
 =?utf-8?B?czMySlpKWEN4dTIrbWs5VExIdklUNFBUaXVEbGsrMFpucW44MGV3QVRPRGk4?=
 =?utf-8?B?TkV2MDJFUm9pVi84YmRMSEV3b2ZVb2hsRXhQVWQ4U0ZxWEdaZC9tZjc5Z3Z5?=
 =?utf-8?B?MjU3N2FxcDFac2hQa1VCUlQ3TTAwayt3Z2NmSFNwRGZEMXhROVNJL0ViUUVZ?=
 =?utf-8?B?VWNBS2ZUUEJYRXB1WkJWRkdjK0ZHR3RRd3NTWFBDazRxdUcraWFjcVdOZVMz?=
 =?utf-8?B?NGUzM0lkTW9CWnVueDVxM3pCRkxRRmxZbkcyVkRBVCt5YW4xbVhZTDc2Q0p2?=
 =?utf-8?B?UnBPRDhJQ2Y2YXIzN042MFdJMnFkZjA0cHgxNHdnRnZtdVIvdEFZaVBjWm1V?=
 =?utf-8?B?OUNLdG80NVRndUpWY0U2Y3hJV0NXVzlEU0pzYmFQU3R0OEx5cm13emNpZHBn?=
 =?utf-8?B?MklYQkRUY0t3QzMrK2lnL2krSWg1ZC9mL0tFSm45eldGMjg5Y3R5SEN6RnFM?=
 =?utf-8?B?Wld3a0daT2FSL2RSN1huWVVKM2tKajBrOGUzbWVxcER6d3Q2MjNWREM1MThF?=
 =?utf-8?B?bGxLRlpWMGgxMTRhS3prampFRTY2RUs2MTdsVWtWUy93WStneFhmaFZTdGVK?=
 =?utf-8?B?anhBWTJ6MkpyazNVR3RBNE9BVll4bHBFQVlOa1pWSGRZT0EvUlJnQlVoUGV6?=
 =?utf-8?B?eXRDVXBiSEdQbk9UQUdkY2w3cVFxTXA0M1hvRFRyTUtablIrNGgvRWZMRUJQ?=
 =?utf-8?B?b1ZvUU9Kbml3bHdWS0lkWXc1cExFM1VlYXBucW5iSXBOblVIV0FDMEluNENp?=
 =?utf-8?B?ZnFQTWwrV3NPMko3U0dPUkg5MXh6M3hIc2FZcEZVa2tEYmFxRHhTbTVjV3kr?=
 =?utf-8?B?QXBKekIzK2Nsa3hMUzZab2pyVU5KWG1mU1ZxWFkzQzVuVXZvUFJyVm80cGkz?=
 =?utf-8?B?OHMvT2o2Vi9CU3lUakxJSElTdmtPdjVDMVBSWE05Zk1BSnFoODZZd3dhQVF5?=
 =?utf-8?B?ekFzVGFHMmxySVcxS2k2SUUvMStkcVYyTGUzR2V0Q3ZLWXovai9PeWlQVzJQ?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sjA+dO8r9/cNptQXgjnVdTgZx/LsjJvvT9cCdBZ1fXfC5TuBQgA8fH616KPLuvBwAc+jmd1r4SRTrTDRoVKi6H4sgjoSKWG8WHHO0D/2q/HbdjaKxQtB4eiVG+tf7AEP3qG2WYjQVp5Lte/GM0rCn99XodZ2SnQYyyd6d9OXoQFpYYLr8mGcHX+IKa2TPzqys0ihbrExcA4yGwGDrtl2Bj7aZNRHZsRlmdclH3GqEi9avpObCO4yDB7Xjb5CZ6ODyfjXx14krxgyF9GwHhuxcVWjvNIu9PsZHlO1TisF02HQIn47e6pm0P3WU6ErLJSU9WXIqodSw9az18dvZBINRm6m7DgAAbArfaQQITbKAOs352SzJH3C7uwl9z2jzu4Rktew2vYYTD8P8/15W7cpyG/6/4MPbFdQHzXikxOjvOoRX4MzkNRaaD1aqR6rCL0J8lz/Qt3VCgg9qe1/ekjWS5n6GUcqwEi4xKPyxNffw4njIRbtQN2dtVM4Qp0j2VC1HY99NBq8SIdSJwbWrVBAAlazLrLTwiElb4/kDUeD+7E5wam5JA71zrr+H4T8pySlUXgx+JHymUN7kGMDHKyY7ep+NK4+JVTgt2ibFLzR09k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55adde24-6122-48eb-cd4a-08ddd4320c1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 15:09:19.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+i4x5z90B98DAfs1zph/4q7Et4Drb5LWsUqFkdEAXsrqLTdBdHmzqgERvaF+0Ra5aShFSLyaa8go9Fsm4vO/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwOSBTYWx0ZWRfX8fv7BBliZS80
 eVkEmqlEYj4gp28828SdZvZ3RGCLOAWUSA6hcf5TS30hIUs2UkHbbS89iQAjln4lgbjEMuAxI46
 mkbzNTKtsDL56E+TwkL7RS23P252hdtSxGzpTuqPh0ekp6UCo7TDudfiyvH+4/9DQ5FE6yG/UCK
 Ufb4n3xm6qyw7DpSpW4qhQDvm3qqDU15ovCIxuQkZVphAf0VZsaEnjDQixuSsX8wgvC0M5Ndkrm
 KdcpuIQB0zfCo8h4lMDtl3nYx4t5WAbRVLTjxD2gqSgwqqfyK/CR6kvqMbrzP2hu5X5JqJYWyxp
 r7A4xijEFE3bIo5abKAxtNbiRSgBxGXDFjqjbVNPxwRSbMe2Fp6QQEJ1WhwWJqroK2FyolKaDPK
 lj7gSk/JBUsrvzdrk1hkiEtHmw/akZHw3RXowx4KOZyQjlKsGeNz0OBzJqAdhnMvUtJP1GgB
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=68921ea4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=P-IC7800AAAA:8 a=3EWl_gb3xnMVH4S9VgUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 2XhQTMp6ylcfLzmaLk-6HXivH4a6n9JR
X-Proofpoint-ORIG-GUID: 2XhQTMp6ylcfLzmaLk-6HXivH4a6n9JR

On 07/07/2025 15:02, Alexis Lothoré (eBPF Foundation) wrote:
> Add a small binary representing specific cases likely absent from
> standard vmlinux or kernel modules files. As a starter, the introduced
> binary exposes a few functions consuming structs passed by value, some
> passed by register, some passed on the stack:
> 
>   int main(void);
>   int test_bin_func_struct_on_stack_ko(int, void *, char, short int, int, \
>     void *, char, short int, struct test_bin_struct_packed);
>   int test_bin_func_struct_on_stack_ok(int, void *, char, short int, int, \
>     void *, char, short int, struct test_bin_struct);
>   int test_bin_func_struct_ok(int, void *, char, struct test_bin_struct);
>   int test_bin_func_ok(int, void *, char, short int);
> 
> Then enrich btf_functions.sh to make it perform the following steps:
> - build the binary
> - generate BTF info and pfunct listing, both with dwarf and the
>   generated BTF
> - check that any function encoded in BTF is found in DWARF
> - check that any function announced as skipped is indeed absent from BTF
> - check that any skipped function has been skipped due to uncertain
>   parameter location
> 
> Example of the new test execution:
>   Encoding...Matched 4 functions exactly.
>   Ok
>   Validation of skipped function logic...
>   Skipped encoding 1 functions in BTF.
>   Ok
>   Validating skipped functions have uncertain parameter location...
>   pahole: /home/alexis/src/pahole/tests/bin/test_bin: Invalid argument
>   Found 1 legitimately skipped function due to uncertain loc
>   Ok
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Thanks for the updated changes+test. I think it'd be good to have this
be less verbose in successful case. Currently I see:

  1: Validation of BTF encoding of functions; this may take some time: Ok
Validation of BTF encoding corner cases with test_bin functions; this
may take some time: make: Entering directory
'/home/almagui/src/github/dwarves/tests/bin'
gcc test_bin.c -Wall -Wextra -Werror -g -o test_bin
make: Leaving directory '/home/almagui/src/github/dwarves/tests/bin'
No skipped functions.  Done.

Ideally we just want the "Ok" for success in non-vebose mode. I'd
propose making the following changes in order to support that; if these
are okay by you there's no need to send another revision.

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index f97bdf5..a4ab67e 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -110,7 +110,6 @@ skipped_cnt=$(wc -l ${outdir}/skipped_fns | awk '{
print $1}')

 if [[ "$skipped_cnt" == "0" ]]; then
        echo "No skipped functions.  Done."
-       exit 0
 fi

 skipped_fns=$(awk '{print $1}' $outdir/skipped_fns)
@@ -191,17 +190,16 @@ if [[ -n "$VERBOSE" ]]; then
        echo "Found $optimized instances where the function name
suggests optimizations led to inconsistent parameters."
        echo "Found $warnings instances where pfunct did not notice
inconsistencies."
 fi
-echo "Ok"

 # Some specific cases can not  be tested directly with a standard kernel.
 # We can use the small binary in bin/ to test those cases, like packed
 # structs passed on the stack.

-echo -n "Validation of BTF encoding corner cases with test_bin
functions; this may take some time: "
+test -n "$VERBOSE" && echo -n "Validation of BTF encoding corner cases
with test_bin functions; this may take some time: "

 test -n "$VERBOSE" && printf "\nBuilding test_bin..."
 tests_dir=$(realpath $(dirname $0))
-make -C ${tests_dir}/bin
+make -C ${tests_dir}/bin >/dev/null

 test -n "$VERBOSE" && printf "\nEncoding..."
 pahole --btf_features=default --lang_exclude=rust
--btf_encode_detached=$outdir/test_bin.btf \
@@ -234,10 +232,6 @@ if [[ -n "$VERBOSE" ]]; then
 fi

 skipped_cnt=$(wc -l ${outdir}/test_bin_skipped_fns | awk '{ print $1}')
-if [[ "$skipped_cnt" == "0" ]]; then
-       echo "No skipped functions.  Done."
-       exit 0
-fi

 skipped_fns=$(awk '{print $1}' $outdir/test_bin_skipped_fns)
 for s in $skipped_fns ; do



> ---
> Changes in v3:
> - bring a userspace binary instead of an OoT kernel module
> - remove test dependency to a kernel directory being provided
> - improve test dir detection
> 
> Changes in v2:
> - new patch
> ---
>  tests/bin/Makefile     | 10 ++++++
>  tests/bin/test_bin.c   | 66 ++++++++++++++++++++++++++++++++++++
>  tests/btf_functions.sh | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+)
> 
> diff --git a/tests/bin/Makefile b/tests/bin/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..70bcf57ac4744f30fe03ea12908e42c69390f14a
> --- /dev/null
> +++ b/tests/bin/Makefile
> @@ -0,0 +1,10 @@
> +CC=${CROSS_COMPILE}gcc
> +
> +test_bin: test_bin.c
> +	${CC} $^ -Wall -Wextra -Werror -g -o $@
> +
> +clean:
> +	rm -rf test_bin
> +
> +.PHONY: clean
> +
> diff --git a/tests/bin/test_bin.c b/tests/bin/test_bin.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ca6a4852cc511243925db905e55e040519af9cfd
> --- /dev/null
> +++ b/tests/bin/test_bin.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +
> +#define noinline __attribute__((noinline))
> +#define __packed __attribute__((__packed__))
> +
> +struct test_bin_struct {
> +	char a;
> +	short b;
> +	int c;
> +	unsigned long long d;
> +};
> +
> +struct test_bin_struct_packed {
> +	char a;
> +	short b;
> +	int c;
> +	unsigned long long d;
> +}__packed;
> +
> +int test_bin_func_ok(int a, void *b, char c, short d);
> +int test_bin_func_struct_ok(int a, void *b, char c, struct test_bin_struct d);
> +int test_bin_func_struct_on_stack_ok(int a, void *b, char c, short d, int e,
> +                                      void *f, char g, short h,
> +                                      struct test_bin_struct i);
> +int test_bin_func_struct_on_stack_ko(int a, void *b, char c, short d, int e,
> +                                      void *f, char g, short h,
> +                                      struct test_bin_struct_packed i);
> +
> +noinline int test_bin_func_ok(int a, void *b, char c, short d)
> +{
> +	return a + (long)b + c + d;
> +}
> +
> +noinline int test_bin_func_struct_ok(int a, void *b, char c,
> +                                      struct test_bin_struct d)
> +{
> +	return a + (long)b + c + d.a + d.b + d.c + d.d;
> +}
> +
> +noinline int test_bin_func_struct_on_stack_ok(int a, void *b, char c, short d,
> +                                               int e, void *f, char g, short h,
> +                                               struct test_bin_struct i)
> +{
> +	return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b + i.c + i.d;
> +}
> +
> +noinline int test_bin_func_struct_on_stack_ko(int a, void *b, char c, short d,
> +                                               int e, void *f, char g, short h,
> +                                               struct test_bin_struct_packed i)
> +{
> +	return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b + i.c + i.d;
> +}
> +
> +int main()
> +{
> +	struct test_bin_struct test;
> +	struct test_bin_struct_packed test_bis;
> +
> +	test_bin_func_ok(0, NULL, 0, 0);
> +	test_bin_func_struct_ok(0, NULL, 0, test);
> +	test_bin_func_struct_on_stack_ok(0, NULL, 0, 0, 0, NULL, 0, 0, test);
> +	test_bin_func_struct_on_stack_ko(0, NULL, 0, 0, 0, NULL, 0, 0, test_bis);
> +	return 0;
> +}
> +
> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
> index c92e5ae906f90badfede86eb530108894fbc8c93..fb62b0b56662bb2ae58f7adc0a022c400cba5e0f 100755
> --- a/tests/btf_functions.sh
> +++ b/tests/btf_functions.sh
> @@ -193,4 +193,95 @@ if [[ -n "$VERBOSE" ]]; then
>  fi
>  echo "Ok"
>  
> +# Some specific cases can not  be tested directly with a standard kernel.
> +# We can use the small binary in bin/ to test those cases, like packed
> +# structs passed on the stack. 
> +
> +echo -n "Validation of BTF encoding corner cases with test_bin functions; this may take some time: "
> +
> +test -n "$VERBOSE" && printf "\nBuilding test_bin..."
> +tests_dir=$(realpath $(dirname $0))
> +make -C ${tests_dir}/bin
> +
> +test -n "$VERBOSE" && printf "\nEncoding..."
> +pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/test_bin.btf \
> +	--verbose ${tests_dir}/bin/test_bin | grep "skipping BTF encoding of function" \
> +	> ${outdir}/test_bin_skipped_fns
> +
> +funcs=$(pfunct --format_path=btf $outdir/test_bin.btd 2>/dev/null|sort)
> +pfunct --all --no_parm_names --format_path=dwarf bin/test_bin | \
> +	sort|uniq > $outdir/test_bin_dwarf.funcs
> +pfunct --all --no_parm_names --format_path=btf $outdir/test_bin.btf 2>/dev/null|\
> +	awk '{ gsub("^(bpf_kfunc |bpf_fastcall )+",""); print $0}'|sort|uniq > $outdir/test_bin_btf.funcs
> +
> +exact=0
> +while IFS= read -r btf ; do
> +	# Matching process can be kept simpler as the tested binary is
> +	# specifically tailored for tests
> +	dwarf=$(grep -F "$btf" $outdir/test_bin_dwarf.funcs)
> +	if [[ "$btf" != "$dwarf" ]]; then
> +		echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
> +		fail
> +	else
> +		exact=$((exact+1))
> +	fi
> +done < $outdir/test_bin_btf.funcs
> +
> +if [[ -n "$VERBOSE" ]]; then
> +	echo "Matched $exact functions exactly."
> +	echo "Ok"
> +	echo "Validation of skipped function logic..."
> +fi
> +
> +skipped_cnt=$(wc -l ${outdir}/test_bin_skipped_fns | awk '{ print $1}')
> +if [[ "$skipped_cnt" == "0" ]]; then
> +	echo "No skipped functions.  Done."
> +	exit 0
> +fi
> +
> +skipped_fns=$(awk '{print $1}' $outdir/test_bin_skipped_fns)
> +for s in $skipped_fns ; do
> +	# Ensure the skipped function are not in BTF
> +	inbtf=$(grep " $s(" $outdir/test_bin_btf.funcs)
> +	if [[ -n "$inbtf" ]]; then
> +		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
> +		fail
> +	fi
> +done
> +
> +if [[ -n "$VERBOSE" ]]; then
> +	echo "Skipped encoding $skipped_cnt functions in BTF."
> +	echo "Ok"
> +	echo "Validating skipped functions have uncertain parameter location..."
> +fi
> +
> +uncertain_loc=$(awk '/due to uncertain parameter location/ { print $1 }' $outdir/test_bin_skipped_fns)
> +legitimate_skip=0
> +
> +for f in $uncertain_loc ; do
> +	# Extract parameters types
> +	raw_params=$(grep ${f} $outdir/test_bin_dwarf.funcs|sed -n 's/^[^(]*(\([^)]*\)).*/\1/p')
> +	IFS=',' read -ra params <<< "${raw_params}"
> +	for param in "${params[@]}"
> +	do
> +		# Search any param that could be a struct
> +		struct_type=$(echo ${param}|grep -E '^struct [^*]' | sed -E 's/^struct //')
> +		if [ -n "${struct_type}" ]; then
> +			# Check with pahole if the struct is detected as
> +			# packed
> +			if pahole -F dwarf -C "${struct_type}" ${tests_dir}/bin/test_bin|tail -n 2|grep -q __packed__
> +			then
> +				legitimate_skip=$((legitimate_skip+1))
> +				continue 2
> +			fi
> +		fi
> +	done
> +	echo "ERROR: '${f}()' should not have been skipped; it has no parameter with uncertain location"
> +	fail
> +done
> +
> +if [[ -n "$VERBOSE" ]]; then
> +	echo "Found ${legitimate_skip} legitimately skipped function due to uncertain loc"
> +fi
> +echo "Ok"
>  exit 0
> 


