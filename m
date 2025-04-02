Return-Path: <bpf+bounces-55133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A92A78B96
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C74188DFC0
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD072356BB;
	Wed,  2 Apr 2025 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WP1Yiz03";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aqymXdyK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56252235BFB;
	Wed,  2 Apr 2025 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743587795; cv=fail; b=U1YD9EAvCA9O6Gdvhotnlb3khwWYJVjNGjoioSAungumfuJDQFPrTGKrP65tkoT0p7PIh7/ocxHjxeBboCWgnVow2PTx1zih/nVkWL56xd8VtN4Ojyh6k7J3e2wBZ6WmmcvQ2pYKTdKl7/jX4WHVDbE/Tu60vbl30VByvS/GBN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743587795; c=relaxed/simple;
	bh=On0XeF+RQTKoEQX+/Sj8k9YdFGsBhU53a7NbAh4tU5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ax6gIlSGYBbu19laJ/5oYP3Wvov6Mk4Bu5/5b3pieKz/NscQI8AdfzgUJ8tKxS1IjsC7IrGO/yomvRGBxiiVgg/n5PaXO1OCIxX2z+HqteaQPwZ4O8sdlzL1kIAqqW3apl4iixDbLfWWd7BjmX63nRVJYkmjaoEaGV10w8+w9gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WP1Yiz03; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aqymXdyK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5326fvTM019363;
	Wed, 2 Apr 2025 09:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Xbd/l7r1cIXrSX15CSCHBAAGhHLipj6va+PsRIvkS9c=; b=
	WP1Yiz03yiZfjQkFp3hqFeC81idnFIo1s8NVe+EN0B3qkazh6q604WU80j/sYFv3
	3wGv/AKNkCU1QYJVrqZbqI4BujTkaLXvTwt9lTNJvqwOAMijGBhGBXe3N7RlkyX3
	u3+ZSF4yDXvRQwe2AgyM6pyAALOl4+SRVhok1GtoEv5u51B4pKmKQoAau25BvcYD
	ICDwUyupDDLZmF9+s9pLPdI4s4A+B8Q8bOUuBzn5TDWEFov2eTBFQqWS7b1v4LNG
	92G6lM1+xzdQyTmxVqD5CbAk9f/PAB191JyIhMfZp5P/DCefBhuqCy+HaWsw2Xsf
	pScWzSl0Ck+wzb5Tn6544A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n2acum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 09:56:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5328OhCT003354;
	Wed, 2 Apr 2025 09:56:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7aacv7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 09:56:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMnO1xGEWY419pb2Y/CpUZ1yHx+3KPGQ/NxeisEypwZZsMYnTyj/lTh4aGYTJ2mDDmUYXSKAzEytUxvkoZ3PhTZEEPRztlSiX3O4S0be6KIHJPcmxmAeJiI6mDKi0aCs19VhFPFYIlWGeRGLldQMKX7K+9jryEvkQzda6XfgenIkaEGN/UJaDOGJKf9ZnMJPvnHe6awpBqhLL2taE910EQLSHFR4GvV586GRpQ269zpP664qTqWC+PRN0FX0cKFwEIkgnqDf0iCUAMelLYFiuomnPPP0mLOhRaR33n37J39uInV9hkaT+pm73g3YuzNzfDAIjUu6quZTi38W5i4mxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbd/l7r1cIXrSX15CSCHBAAGhHLipj6va+PsRIvkS9c=;
 b=aiykxu1bhBzbq/yMj/4punkf5j6jYCJUCkGRO+HaWSsn60P99FjehoW0IImD0rM5ZWRsDVVzAabyophtBpRFSwsNAwH76TmnGCf3SXvsJvtS/soPrTY7LLx23myrcyk53VO8699wPTCRh4GzgL1o41R2ntC6UKLptM8iiXsS0xqyncAVkCoIHdZtxALn2YEyLw2mxuxjEPgxxhqVBMABg8ZtBnxnh3HzkD29F446JuKfNvGjacoGLTZmcC0iB0/q/qeq9Rlr6cYakgz9cDVMaxPsLMDO+kU29kspRTyXJja2Qy64Bg7H2KShnGsMaKcnWhcmdEvMmWlsSQtr+7Sb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbd/l7r1cIXrSX15CSCHBAAGhHLipj6va+PsRIvkS9c=;
 b=aqymXdyKIXzPe0R+Jzpph7WU4yLNbqvpgDwyZMI4wTdJjhyS47Hvhflsn0xgb5/ijZuTY1KXCD4bQYjyPs4vVUYMji81z0qSQqj5+MrtVLch7u0/kyk7Xg9R9QgVBCsn+rgWWvbt0ePmenneXQbdh1J94XUChSvjK1Zl3ARtp7M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ5PPF61CA724C7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Wed, 2 Apr
 2025 09:56:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8583.038; Wed, 2 Apr 2025
 09:56:09 +0000
Message-ID: <cd5e3955-9c3d-4c06-8908-c279af33fa92@oracle.com>
Date: Wed, 2 Apr 2025 10:56:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] dwarf_loader: fix termination on BTF encoding
 error
To: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
References: <20250328174003.3945581-1-ihor.solodrai@linux.dev>
 <27afc430-face-4013-9b87-4168f38b6b23@oracle.com>
 <Z-vtiuRaolc91Nkc@localhost>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z-vtiuRaolc91Nkc@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ5PPF61CA724C7:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6806b3-2063-48a3-3902-08dd71cc97d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3F6RUFReDE4SlJlZE5tQkR5OGQwdkZ3RU01TjlsdDNpNmZVT1ZIVHhxYWZG?=
 =?utf-8?B?SHlmd0o0aE03RVNCZ3RGbGlpYSsrRDVZMVo2cHdoOHp2VjZtWVRuWDY0clhT?=
 =?utf-8?B?RzYrYUcranVRa0VpVVI0Y05zdkYvd2puK1FiWmhzMitIeWFEMlNhbGF2NkRn?=
 =?utf-8?B?UTEzSWQ2QkkvbHM2SWpGRW90WFkyc3dWSThDUjZOWjZsa1BGb3FrdkhoQnIv?=
 =?utf-8?B?U3hIdjNRVWNudnpLMTk1eDZ5bUZ6VkxpeE1kWkUwc1duRVkyNzc5bEZZTUx0?=
 =?utf-8?B?dzVMUTk5aWdCbU5TcGNoa3VYMUUycm9YNUgwWm1yM0hnc0tiVzArRWhHVWFx?=
 =?utf-8?B?eldPQXA1Zk1kWXhtUjJWT0k0SGQ5T082TzVQWGNTbjNtNFZ4MHNpNlRvM2hV?=
 =?utf-8?B?R1E3ZCtiOGE0bW9KeVRYd3NCRGNuQ0lOUG9IN2ZlRXMvQkdBMW50SWEvLzUv?=
 =?utf-8?B?cHlzK2F0Ylhna2FFQmFaUDhlMkkrYjJnZ1Z2WDFrZTJyVUJJNjdqZVZqZ2pR?=
 =?utf-8?B?UXFwTXBxYUowN20xYVFQdVVRbCtVZEY4UVQyM01PVU9pR3lvVktSQ0pNL2h6?=
 =?utf-8?B?dGhzUGtXSDBoU08rNUpJQnhjaGNmaGduOERHWUdKZnJ2dFg1ZDVRUm53RkNy?=
 =?utf-8?B?K2xqc1ZHdm1zbHBieWxESUk1RnlRRUtYZ1R2YysyREsyelpQSTVhd0N2dzFs?=
 =?utf-8?B?YnVDeTZMQ2JoMUdEaUxGQmpGRjAwZVM3M1JzbEZVQ2NzRW9JR0o4ZzVHL2VL?=
 =?utf-8?B?OHhwZUdGUWl3ZFI4RFkwc05UMDNmaC9uMFZVbVEwM01SYlJTY0hxb0hHQmIr?=
 =?utf-8?B?WERmdDRhdGRMbTc4T2tHS01OM3I4NkdOb2VWZU5IdGtyQko5NUh2S1dHc3Np?=
 =?utf-8?B?YmE5SFkvdFNXeUNxNk9kL2h1cStlNnVaQVM3d0V1elRMc0hGVGNYdjdZdUdB?=
 =?utf-8?B?UWFmc0lGaUVHcVQ4WUJGOEd3cnNzaFUyUXhGT0NZZEhtRUZTWEVPRU02NWdQ?=
 =?utf-8?B?bnhaeGRvM25oKy80Q3JaUUtxaTZNRTEwbUpvK3NrY0FHeld2RC9GSEw5M29j?=
 =?utf-8?B?ZUtFVkhtSDl4Y25WOUxFeE4yUzI5YU0reFNTWUQxZmk4eDlYMU9xaXNCcStX?=
 =?utf-8?B?S3QwVE4wenM2QkdBaG5PVlVERVVzMVlqaGJUWnFUWmVHOWpjL01XY3JhRkZw?=
 =?utf-8?B?Q1hxOGtuY2hvMW9jK256aGJyR0RKUGx3UHE2ZmhZYjJSVnV4dWtaemRFUnh5?=
 =?utf-8?B?Q0M1enNoYWFITDNzbEgxaFBYV3o3SkVzZkNTblFHR3RVYWVON3ZzeTlmWWI1?=
 =?utf-8?B?MEUreVc3bjdINUtHOGpNdG9PTWNrb3MxQytXdmR3c3Y5MXg0dDQ4eU8vQWdN?=
 =?utf-8?B?M2ZMRFFIZ0ZzemNvaEs4ZTZadWZaQ01IUEhzaGY4cHdYWDZEOURzeG16blhh?=
 =?utf-8?B?WTNOZjdFU1p3UHJyN3N2VXlIZytTV3Y4amVycHVRUXQwR0FoVU03a1FNeGJT?=
 =?utf-8?B?Tlh4TXpGbG4yNm5NdGtFRnB4cnIrODF2QSt2UTRvdWlNRklVUWNDYThhWUxO?=
 =?utf-8?B?ODR5ZXFHU3BUcDdoS3U5bHpwVHFxcGFJVXB5N3ZOdWtsTzVCZUxFUHlYWW9S?=
 =?utf-8?B?a2V4WVlvOWpNQ2Y3N2hkbnk2Ry96bndUSDRuL0J2TG5SSHFjdlM4QUY5YzJB?=
 =?utf-8?B?VHJCN1l4T2FabjZLb28ySmhCTVovYnJRSS9ubW9BWWUrS21vUndDSXJvSmZF?=
 =?utf-8?B?VndFek9MdEkvMWZ4QWs0c2wwNGpYMGpTOFhkV3BPam9uc2hZOWFwaFAyc2Jt?=
 =?utf-8?B?dDdHRHpQUEhMMzNBaFE2aWlxRlkxZms4dkdVbUZsaVViK1RxYXViUzFDd2Uv?=
 =?utf-8?B?Y2NSalBlOXBHamlpNzVjSUpvT0UzUnZaM0p0bXl1WGxRVkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0s4eTIyYitNVHdvckUvb1c5UWZtTkxCWkY3RllpQlNvTGpxbXNva2V2c0dY?=
 =?utf-8?B?QlNBaDJWNmpDeCtyeUQvQXpDYkpUYVFhV29SMkxaYmd4dTFWYU9GazZYanBI?=
 =?utf-8?B?dmRDY3ZmSUFVMUNndnpXOHdNcm9UYWFEa0FvY3pOcTBtZW0zdU9iRGEvK1ZM?=
 =?utf-8?B?YmtHYVRmZFhVNlhZQ3B6KzUzankyNXJaMkVCRXNCbm9IcDVRem10QkVvWU01?=
 =?utf-8?B?OFN1QmtiS1FWajFYakhWTURCallkUitnbmI0azdyelRBb1pNdWdIU2VDK0la?=
 =?utf-8?B?UFdvSzlaaFNjL1BmOW1mdkprY09FTm5YaUgzbzA1VGU0YTNGNlBBd3VzMTJX?=
 =?utf-8?B?bm93eEkwWk1BWW1CZkNKZlJuN0ZJbFJiQzNvL3ZWd2huSUJINEZQNCtJUEI0?=
 =?utf-8?B?eGYwK0RWWDAxeWcxVmgyNkl0Z2l6Qy9ZWENDSEpXeVhrbk1vZkNSZ3FodEFo?=
 =?utf-8?B?UDRuRTBySTliM0w2ZXpER1RTNXlYOC9WM05pc2NkK3VBUFBmcUgzSGRxYkh5?=
 =?utf-8?B?cEoxWDB5UjVXR0E2T3lqZmEyaWh2M281VFJlRW9aQ2Q4bWdXZzZEWm9uUmRa?=
 =?utf-8?B?T1NucytDMjNVbzk1TDg4a3RRUms3Zm42eCs2aXo2QkRBU0dMbTZNdkhXZTZG?=
 =?utf-8?B?Q01TRnpNbzdKdGxUOFpYVk11QjVTRmllM0FxYW5INWVPcTUwdUtoUWVkblox?=
 =?utf-8?B?bzRtQUsyVzBrVC90NEhsSUR2eW9YUVRIYlhSY2dRTkxPOFVoSUFCUjZkY2h1?=
 =?utf-8?B?dkdIS09BMy93MWVZNUYzNDk2N3dTbVEyL0drTkYrRGVzUHRneHB6Z3A2b1Yy?=
 =?utf-8?B?Z0tPNW1ZSnJFeUlZM2x6ZWlWaldvN1Q2ejFJVVBybHdYekd2Q0Q5QnRzUUUy?=
 =?utf-8?B?Zzl3NDB4NjlCU2FTeVdBKzA2RURaekx2RHIvQzh4ZmxUVlA2VHZXV2dITG1l?=
 =?utf-8?B?KzYrRWhNSUp3dWZKbFhjWDg2bUNEYnlNekVqUStCN3VDM2xmNjhhTXpuVHBD?=
 =?utf-8?B?M204QWFkNi9jM0lqVlhOdHNmQmNMUXU5SXFHSU1NemdUazB0dlRzZEZFSFBp?=
 =?utf-8?B?M3NGZzM1VCt3WWdUeTBkMlBBUkVVUytIQnNOendaNndaMi9wckhxQnpwclVj?=
 =?utf-8?B?S0o4U1ZqdFN3UjZYbHVsNWM2QzZqa3dKL0tiK0lmWGFsbFhPNndBeklMcUZz?=
 =?utf-8?B?MWVpWE0ydldkVUtaNUlXbzhNYmlPZGxXSXlNY1RNR3hmcXV2SXpxOHgzRHJS?=
 =?utf-8?B?LytUTFN2UnNCUjNqM1hoSXJLNUlmZDl1b2FlK3EvWml3L1M2YWU4YVRyOUwv?=
 =?utf-8?B?SzRZQzNhbU8zaWkwak9UdDVUaTJYbXplcmpqK09UT2JoZlFvcUpuTnpDL2g3?=
 =?utf-8?B?ckQ3N1E1UWhjNG4zQ2J2Q2Z2cWFRNndLVWJrSWN0Vk8vRlU4SGI0OURHQkc4?=
 =?utf-8?B?QWFhWmhBd1hnL0xJN0MyYjRLeW9Qak9hUUJpUGw0UFQ5b3RXOHMxL24xaXZk?=
 =?utf-8?B?OStxTm9JM3lqRWJFRThEKzM4ek94ZjExSlZjTUVMRnZJSEtOS3FGZGhWVE9K?=
 =?utf-8?B?eUtlb2NpZ0d0cVZpYkRsMXdvMG90cUxDYTN0NmlMTjVYQ0JwNys5SE9nM2tG?=
 =?utf-8?B?THFxQ1V6eFMvOWY0M3haMXYvdVNDTFJySFg1MkNoeTA3REVGRG9vSEhPeUVx?=
 =?utf-8?B?clNVblE0dFBPazRraFZQcXdPWVcwQ2RBUDRvK0Q2U2lDWlBsV3FicjlRUkh2?=
 =?utf-8?B?UTVyTEwvVkJZdDJZbUZLalFRYkpaQU9WRTNTcXNERVplaWV4Z0ZjTTB1UDNK?=
 =?utf-8?B?MHVLNU5ZSnhuT2pmYzBNbk5CQ2Y0bVp4bW5YZWFqcHREQjBoUGFzcmpvQTk2?=
 =?utf-8?B?cWxYVVFRZ2NZNUhhRTMrUnFZS0NXMTRHa3dOZFJ5bzZPQmtTNVAxalVhSmlx?=
 =?utf-8?B?RUxBQ3FPRFYzbFo4TC84REVqMmZFamIvLzNDNzRRUnRsZjlYbXlTejNmUDlQ?=
 =?utf-8?B?VWltQ0VrbHZ0Q2U4TFFlczg4S25sYytEMmR5Qi9SMy82WVNaWU53Z2tYQVRT?=
 =?utf-8?B?a2czYlNCc0dVckpHL0JUOU5hVWtrUGowUjRNaVhRZndUYXhITC9MbExEYnov?=
 =?utf-8?B?WmJoSkNKd2xySS9KWmVaQjlxeDV4dnZPcldvemhOaDVGZHZyeEptRzVuRzdp?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/7aLa+0xjMpOP9SnfIf5xso15G4T5wKuhy+S5uhUq8Qe1WY2k+umaVWam2CR14VPwyVkvYvi5xNkJJUdoCp95e7HmVGpFrlI8QyReBkbm8+71Vooxg5YlQ7bECUTI0WXtJvC7biaK/hx3b/ecOAI9/z0HWjXmY3PjcdauEK+msY7iJqpB8t65od9pF/f8CjX3shNvLEsBni06lBKGXgI1goT4tSHznRT/8eRCpiRggfO2SQ4KMetfhTpglTHmuru6rX8/pQFwhQGLXKP8CTyK9ExMTY8ZxZcC4Rabd921v/tvN+U8X1ZN/tZ4YG9LFZwlv3eVsiR8/iOMerGvCh2kBUSkbGJQvhIQ8Hax/B7VZa7DgK0jtBpd3enXEDEST2K3S2rD2EFrNWHK8f12vPLjaqonzED37grLTKpOQsnCy1HNZpYremwGVlcjZwFhfWJKQbytDGBZSfuczxJk6MKWyFR4ORUKQjWAuvlzks5l5aOJsZItjfM/AH0kf5z2sVfj0FY8ikAFw+++vgR2j+vmK5whwq0sqHV1VfxuqQCP8WLNAuaSPNeLJhMYZts+qJVY8a12S7LsYIRX6aPUeqMVZwJEYaciuVaNndekWEcjDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6806b3-2063-48a3-3902-08dd71cc97d4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 09:56:09.3407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhFHMODZ8CH60qgWPOySTK0X4dLiR30miblmwI7Qro9DZOIPJQIPbtKO9CIAh9V2VgyjQJjkC6n6ZOWXilp7ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF61CA724C7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504020063
X-Proofpoint-ORIG-GUID: 0bKU0nFxkTfcJXc2NiiY232crgJhccrv
X-Proofpoint-GUID: 0bKU0nFxkTfcJXc2NiiY232crgJhccrv

On 01/04/2025 14:43, Domenico Andreoli wrote:
> On Tue, Apr 01, 2025 at 01:57:25PM +0100, Alan Maguire wrote:
>> On 28/03/2025 17:40, Ihor Solodrai wrote:
>>> When BTF encoding thread aborts because of an error, dwarf loader
>>> worker threads get stuck in cus_queue__enqdeq_job() at:
>>>
>>>     pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queue.mutex);
>>>
>>> To avoid this, introduce an abort flag into cus_processing_queue, and
>>> atomically check for it in the deq loop. The flag is only set in case
>>> of a worker thread exiting on error. Make sure to pthread_cond_signal
>>> to the waiting threads to let them exit too.
>>>
>>> In cus__process_file fix the check of an error returned from
>>> dwfl_getmodules: it may return a positive number when a
>>> callback (cus__process_dwflmod in our case) returns an error.
>>>
>>> Link: https://lore.kernel.org/dwarves/Z-JzFrXaopQCYd6h@localhost/
>>>
>>> Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
>>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>>
>> Thanks for the fix! I've tested this with the problematic module+vmlinux
>> BTF and the previously-hanging pahole goes on to fail as expected; also
>> run it through the work-in-progress CI, building and testing on x86_64
>> and aarch64, no issues found. If anyone else has a chance to ack or test
>> it, that would be great. Thanks!
> 
> Tested-by: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> I rebuilt the Debian package with that patch applied and it then started
> to fail consistently because of the extra c++ symbols.
> 
> When I use the switch --lang_exclude=rust,c++11, it works without
> errors.
> 
> Thank you Alan and Ihor for the fast support!
> 

Fix applied to next branch at
https://git.kernel.org/pub/scm/devel/pahole/pahole.git , thanks!

Alan

