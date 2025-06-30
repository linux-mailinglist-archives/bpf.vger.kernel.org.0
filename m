Return-Path: <bpf+bounces-61876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D3AEE5E8
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1E3BFB7C
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEA62E5404;
	Mon, 30 Jun 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E8UQfAfE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ErCFoiB7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757F2E425A;
	Mon, 30 Jun 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304828; cv=fail; b=szxcZR+PLrh5eE49taWMTZ6f4s8wFpXuJQHOZxUI7iACU654g2gr/O22/nuRWVSR3cb3ZdbRSBrJWytkSwKtU5D3TtaPh2iL4FtVxt9/BO3cuul+CnIw4uJlaHiKeMImZM9VeyqJX2fgV+a96GIgzfjoaOrJIURpbr29eBW8YXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304828; c=relaxed/simple;
	bh=dNG7z7c5rtq6bdyJGdsKamWV4FGLbdvCOfmD0BhXnFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EzZQCf5JA7Vf8mGqSmwezr6+JuYaqYzhe83t/KfY8MvAgxJE1AQ958flbHLs2DxEHqTOeG4OGKKDIHtXtdNuqWpAW3ezS9fL3+/IGbwXrC4Wwh6K3F0Bcji+mwJBMMVQQhEl0Q2aqGWHqeBwszOnskccCpSmWSlznxAN7bzUn7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E8UQfAfE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ErCFoiB7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEksMb026531;
	Mon, 30 Jun 2025 17:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/ayMSk5Tb/C12tYbTnVA5cyg8KGzlpwyBnM/vBNlg2M=; b=
	E8UQfAfEm22/f8voWrLGhjzy1aNkjwUGcCfdyM3hDG+Qmk0WfcIw17Y60eTCzYhM
	kjvgbokjAL7e84/q+LA1ZfO0iCDagIz4mNoRAnAjLG/iP/3BHyDkItv5aavA2k60
	ZqGMr0hfKivfzSZlPAzuq/YWKmmcrldtlbSaYITbbE5tB2tPN4pwWtHZbPWedBfb
	RB6pG2Hy1bJG375cXxqBfFT7e2EQk9MUGZipb/gFsgmpsmd59v6isSWioNzam0CL
	H+3mGTxwJ4OoyrF3e9jY7l2JgRiastLREIXjnbokPTjjD5U0FL3wBnF3hn5AcGkT
	F0SHfgQ3b1UNuU912038Tw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfb1ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 17:33:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UH0uOU017559;
	Mon, 30 Jun 2025 17:33:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1dcwpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 17:33:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK1Vg5FG9SfbW+pQvjuSIpIKBX7N+BNaWumeQlf9kudqWTDwRowi2raZoydn26T+bal2XE7P4lVojl/SpfyAwPlXMMM5cD1ZGJNfWSqibYdN/Y9OL+r+/Gh3PD/zt1QBVw5pd9AFzrx7T3cCdvF5ujC6YQyfe/JWRJaRqE+vQC3p+K708uqf5pYFfmgMJ1KWcNanlf75k2FMXwe+9T61VIVnl2JbPWB6ilgwVT9NY/FiDlrETAkHougtSctKHm/rDRawY1qUYdb0EyvJPYnjU/3b2AL5JlldnZvTWqkpSPKm2fGLf9IjDty/zop2qXpeOhmm2w3H8zkcNJpIUAv7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ayMSk5Tb/C12tYbTnVA5cyg8KGzlpwyBnM/vBNlg2M=;
 b=Mleq9ocJTWmFzGYM4fv8qEqgddVf9CxPr8ph6/TxzkuEnqGKA8hFssyLVO9XdR/f31Y3bIKktKImXZJPyl0TOatBVE/dW6JNr5tpdTbrlf8CHlUazrqO2pnSZq+GB17P8OZB/LGjnYNENiSgob+XC4qvkWYc3NHSBN3fVC4M3BXNXJ1D0vHXo6/hp4iZ0wPkeQb1JnygRi3J7JVO0j4ztYndMMcKXuswtylLV+9p2f9pE2eaZ/zmoXEBVQHdI8FDUcnRGDOtAw0o/cGYEnBwQZQEURo1+xOFaO1Wt6KQkg7zWPXBAp4GMM/hWUfDWsLnoCwboAik9h7aUlku6QiW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ayMSk5Tb/C12tYbTnVA5cyg8KGzlpwyBnM/vBNlg2M=;
 b=ErCFoiB7ZVHlb6e5LI7zl8izd6CsIDfc+j5dcoOTg8wubdvTWD6gyYsvPtrjPtlPY2Ee45P1+yG+6m2pCWFJHUkt/k/w4pfFXmb6QFxraWxtypNY50rVzv9oeTLn8tTOuPTOLcVtknJ1Fukwb5KwsG5Tvieo+Q+VUSxtO26596A=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS4PPF6C5A39D55.namprd10.prod.outlook.com (2603:10b6:f:fc00::d26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 30 Jun
 2025 17:33:00 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 17:33:00 +0000
Message-ID: <c0c5e219-3e8f-4b21-98f4-fabf60278d41@oracle.com>
Date: Mon, 30 Jun 2025 18:32:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3] dwarf_loader: Fix skipped encoding of function
 BTF on 32-bit systems
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
References: <20250502070318.1561924-1-tony.ambardar@gmail.com>
 <20250522063719.1885902-1-tony.ambardar@gmail.com>
 <66861840-0d4e-4b83-a89c-3e56667ac55b@oracle.com>
 <7d0cb760-6745-4595-8e50-6f5cd8d0db05@oracle.com> <aGKWeBSsboCsoNDB@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aGKWeBSsboCsoNDB@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0008.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::13) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS4PPF6C5A39D55:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4d2a79-c157-4371-14d3-08ddb7fc28e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlpDbmNxVjdxSjRmLzFvbXJ0RmlHT2l0MjM3SWI3RkZnU0pldXVXRjVYZG0x?=
 =?utf-8?B?MFpFZ1FCK1UvL2JnbEFMcGZTZkh1UnBhdDhSaEtSUlZjMTZGeEtLUGl0Nml2?=
 =?utf-8?B?NGJEUktsL1VtVGlXLzJkTUNLN2JmUnN1a210Q285SStHWDd3Tk5ETWtUdFJx?=
 =?utf-8?B?QjhITTdONk1yeEplQ3VsMHE2VWdFOEZqZ2h4SnBHaFVxdEJYZnJtZzZlZHMy?=
 =?utf-8?B?YWt5OGNpS0FZVXUzUkQ1T1Rzc0M5TSsvazY5Q1MvTFpGL25MUXkzaUVRTWxi?=
 =?utf-8?B?Q1paK3BXUkFzYnpZWVJrdTlEcFVYTWwwdnR3T01rS1RNcmNrWmJNRHBRNHRK?=
 =?utf-8?B?WG82bDdvTEc0c09VcFVWSnJEUVhEdzZWemRYWXFhd1RiblFwcGRtMzVXbHB3?=
 =?utf-8?B?UTZLaEI4dVc2NHRaV29vdC9wTEtXdGNnWTJrajdaSjlMTVhQM1ZKb2JHRTJy?=
 =?utf-8?B?SzNyb1NvTkk5SDhEQTJCamxHbDV4YUdQWjFYVkVQQWM2dkNlcEZWMlJwS2Ns?=
 =?utf-8?B?emcrQmVFWWRpWkxYVm9WUEZJb1NtcUhuQkZDTlcyMkcyenprdTQ4ZHFWNUVl?=
 =?utf-8?B?a2VLUGhXa2RoQmZxYWpCVzZiTWs2L01PZlZzaXYvczZZRHI2c2lac04zVnZD?=
 =?utf-8?B?UW13Mjh2ZTEwWUxLemxkVU5lU1BDaklUeENhcjFOWjdQVVFoVjhWYkpsM3FS?=
 =?utf-8?B?V1VSdmFZTUxtTE12RmJ2bzVYZUM4M3hxZC9pY1lQQ3hEZkdlcTFNTC9EUGlW?=
 =?utf-8?B?UXhJR2hxVHNOZG54WUNXdSttWVMzZncwVWpNM3JHWEI5bGZnU3NMMDZiWk9K?=
 =?utf-8?B?SUdLajFtNzJjeHBYaEFFb3pUN3dwTitHKzgwWUlObTNYVG1RRWFuMERTbGkx?=
 =?utf-8?B?aHNRU1hTd2hhNXFtTEhDMEhYeTFmSExmdS9vT2FzREIwVk5GTEhSMGJkMDFT?=
 =?utf-8?B?KzVvSnFqUFdzMGJ2S0tQVzVCT09DdWVaTjA1MjZrR2NIYStsVTQ5OEFteHY2?=
 =?utf-8?B?ZU5EWUtGTFArTmZvT1lDb25zeGM0OG5taC9lOEgzTDd0Q3BuNHM4SjBiYm5P?=
 =?utf-8?B?dngyYXgybG5DUHVKb0M4bVVJNXRwQmJIZUF5M2MzRENsbjl3c1JuQjdtT2Q4?=
 =?utf-8?B?R3JWVHhsS2RZT2U2MEdmTVQzVHhzY1J6YTNuY2N4VytsNjZCbEt2OWh4cG5O?=
 =?utf-8?B?Mm54NzMraWFzN1gvVCtUZFVWVzdIQTVKSCtqdkV1cjhvbXVISExESXFrek55?=
 =?utf-8?B?dFlmSElDNGZ6MVo1K1E0clAyZUtzT3hiYWw2c0IvVzZ3Sjhaa05QOTQ0MFhs?=
 =?utf-8?B?elJtTC9vb3dGVEdWRGxmQmZOcFpITlg2MlE3SDRLUTdRTzB1bkc5dENyekpZ?=
 =?utf-8?B?aWRxK3dLeEFYa2g0Mm5sRnJWRWdHdzZqaXhpUGUyN251azF4ai9WcEpRY1hk?=
 =?utf-8?B?NW9BNHIySmw4VC9vc2Rsa0pjcUZ1MEkvclFGYmk3SDRzKzJUNXlwRyttRFlv?=
 =?utf-8?B?dzVaRnN4WVlQWjFBMXEwTFNaOWhNUHRuYThIN0JBRnAzc0tSeVZvUzBlYUNv?=
 =?utf-8?B?MnRteGJ1cW9jM09LZFJ3V3l1RDVTL2pvdkp0aFpkZk5XV25QYjBLcm4zVU5S?=
 =?utf-8?B?cTRTMzE0QkxkcmkyY2VDRmhuWmdJQys3cXlsMTY2dVpaL3VDcUR3d2FvUDJy?=
 =?utf-8?B?Ky9KZXpTZk9NY2hZODdoVFBKMjltL1hLQTNQZCtIbmx2dGg0M3NhN3U1dG5r?=
 =?utf-8?B?ZGpqSk1vV1ZIWTZQSGhRK2Z0SEJ0ZC9aNGJkZU9NbXlhUkFxa3JsMnNkNG1D?=
 =?utf-8?B?N1pXdTZrcitIZTNtQVlCU202V2dLK1NPZnlTWHk5cGptMm9qN1RDc0p3alQ2?=
 =?utf-8?B?Z1N3VURsRGUwREtUK2hoZExqaEp5U3RtRC9La0NENjJkQXo0K29oYStRN2hX?=
 =?utf-8?Q?eK/7XZOtt2k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm1xUm5taS9BeHlOZ0xmbVE1WWJGYjJ4b05lSFo0TzdNZHFNcG1OeFQzU3dz?=
 =?utf-8?B?enU3NUpNdjRnajh5TzZFR0JnaGpyRmxadTJscUlSQmIzT2ZoQUlNUFkrUURP?=
 =?utf-8?B?cUlLdWFHNmRqejAvcmlNK3J0TWVGVlVzS1p4TTVFd21WNjZpcTljVm54ZE9l?=
 =?utf-8?B?TTVmWGNra2dENjhuMkFWOGZYc2tQYThXZDd4bE5OdDROZFNabm42WEJzTVBs?=
 =?utf-8?B?UkZwVHRSVnRtYlZad05Xc2VINS80aW1mSEMvMmpzWGZxNFVWZUZPTHdod2N4?=
 =?utf-8?B?NGxrMldYanVCbWhiRldORVJHb21qa2ZZZzNvdkFUcXU3MUFHYnk1VVd3ZVEz?=
 =?utf-8?B?VXVPbWdoaFNJckZORitJaVA4V3BGVHA1b2UrblZnN1hncVNzTWFJOFkwbWRy?=
 =?utf-8?B?V2VyeHN5MzhWVEhETG9JWlhQZGF0WWorS0pZTFl5YjNtRlhLa2pKK01rOTBo?=
 =?utf-8?B?U2ZKWG5vbytNNlRocmd4SHYyR3p5enI0UG9xbHpNWHNxZTlZWXBnZ00vUm1F?=
 =?utf-8?B?clhsTFQ5RndwYU52cGFGbFJBMC9tQVFyaktucENGTG9XZnhmYXpwQnVqTXFR?=
 =?utf-8?B?MjhrYUtPQ2ppNjB5cUR0QXhzTHl4V08xYSt4M0V1Vy9aQWZmblh3clFTTXlE?=
 =?utf-8?B?UExIMksxeW44YVRPajU2Y1kxclVqM3dwVC9mRjd6QXpIU1RibXdwS1BZSWZn?=
 =?utf-8?B?M0Y3dW1oMlNPbDdvRnJjR2VRN21SVkVUZ2s3SVJubnZ0OVpzQXZkcUtpdW1l?=
 =?utf-8?B?N0dnME1mZWE2WWlVWkFxa3h6bjhOVHNkT25wUlVaendkdlBGVTJ2STQwSmY5?=
 =?utf-8?B?QmNzcUZMaXJ5L1V5TnhoKzM4QThqeExpY0FoYlBiRXFsK0V0T2hEQkhBOE5D?=
 =?utf-8?B?bHVuc0w0bHVxNHNYQUNTVENNVUVuLzhpbkVSdmxBQ1k5S3VTT1NrZ2RBNElD?=
 =?utf-8?B?T0dPVDV3UEM5N2xDT1RRbEVxYUE2Y3Btc25EbkExQ3R4L1pPeHlkTDVIaExU?=
 =?utf-8?B?UjBGalBmNmpoMW5jQ05PeXBYdUtWVGZMcERibkJZMVN1NnY5Rm93ZnRMZGVO?=
 =?utf-8?B?K3FOcFJvMXM3TURncFRCTE9PNTZxN0MvcGFPMisxNFJzWC9LekFmMGpudk9D?=
 =?utf-8?B?aTV2djNwbXVmL2Uwd0ZkV080bzVGdXNYQStTVUd0aTlOa0pZOTVub1lVdWJp?=
 =?utf-8?B?UkNFeXd0Z0ZlNGZRUFJLSXB0Y1B1SFA5bU9RMnZNTDVMZEE2YmdiUGpnQ3kv?=
 =?utf-8?B?cnVHUXpldU9wWnU5WHdsSElRaEx5aVpkNndCczdVTDRDRGtOdWoycjFBcG40?=
 =?utf-8?B?VEZVOVZ4OGNlVm5BeDJmSnIxU1J5L2dhd1dVWlRuWmhFbFo2WDc4SURQeFJz?=
 =?utf-8?B?NjB1NWpvYnpoSW9iaDgxdjJhRkVHTDBhMEJsQi9qMHN5YWpVMVlqckFqc1J5?=
 =?utf-8?B?ODFpVEZRRmRvVkdDVTZabEkyREp1N1ZTZVlQSkcremVjc1czVG8rcGFPQWFI?=
 =?utf-8?B?cDRhM2RjNmJvNy9TaG1KaVNqRmZNUWRYeUppR2VOU0RTcFVKalJTZWZCUGZq?=
 =?utf-8?B?eUU5ZmEvRDZDWjVPdTdDVEQvdk5CQ2szenAydGJwb1lleFdiV3dnNlR5MUJU?=
 =?utf-8?B?V0paMGRzK0VlQ2hmaUVIblBQVGk4QXlBYkZwMEpBWHd4MTZweUhYcU5vSlls?=
 =?utf-8?B?MHl1LzMrV0RNbGdwSXY1MWtpSW43U3JQYmpucnltQ3FJclduMG9Ja2VzSCs0?=
 =?utf-8?B?dktjSnZ1NDFlUmFFd0RCMit4d2JTbkU1djEyYUxZTjVrK1R4ZTlNT3M2U2E1?=
 =?utf-8?B?bThNQjFVQW9ybEFtOG10WWNXbEFWTWdPRzVJTFJkOU1yNHZVaHpkYXB3L1lx?=
 =?utf-8?B?M1pnS1EvTXhKZExRdE9Tb0Z0TjNXUkdKa05BWGQxd3Y2aGo2WEg2bmNIbHc5?=
 =?utf-8?B?aGdRak5oQVNsekZVV1dwSWNJQkRRMXI3S1ExMXEvT2tSZVppbDE1blFja05Q?=
 =?utf-8?B?c0dnUEZpZ21acy9oeVlMRThlRUR6UXVpdG9GdEFnU1VMbjBySkJvNVF0ZG1x?=
 =?utf-8?B?Q0xWZVUyaUdXTk4rbWRGSk5FdmpGUjJObE95dGYzZWdQbFppY3VKNWlSZXBR?=
 =?utf-8?B?SWxiUlZLTWx1dmxDbVRPNTZZUm9nVUkyM1piWE5uNHYxcTQ2SGhaa2twUU9J?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GEZtH+aY1IrLl3FDbSF/Z6KVghKDC9EUqGBRQlQCBwM+y6ekOluoBqwRaHJMAAQeCRPY//acWfqnekDvt6qUvTJQQrSjEApbfKY8P351tgGpi34o/md81WtwO87Qpw4OrU/J4RynpM8K294sdwDFVs5AtO8Idx544q02IRrdKkQ+N+ChKW1LwPPiEznxLa7ri/VRYzUl2z8Yyj9BUBurrdyojQpgiFeeVT0GUnwaqCk9LnR6eiSrBAXltkwM0P7gXq2uBXSBCBsR99AQnRQne51+Ps3eZ/5MeKW7We9qF9YFF+Rp8S8eQdPuzfmYYUTGvwmRkpMYp4ZWuMqzr1DlQAuGyodluXXxh4zWhcvM2TDlRPaR2NVFgUCB1uT8lEcjzgJe8rYVh5eNUG2Yd/ZJ3jUiA9lJW7CqMkXwPDNaeWzSU0vhoMGsQYMYwa89lAGE9mjYgjPcXAd5Cm9Uppnwypye61kTdTxaLg9VyEnduWRv6aAo/5Wh0xkRy1no110H8YYuyVB8F3l57BynKrotXMmi3dyDAwGqRZZta8gAxpObOjaK2JyLt5HDJEDoojSs9qfdm9jbPGqIaa3javN/SOXqcAGwxZqKgfKMLISQbdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4d2a79-c157-4371-14d3-08ddb7fc28e6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:33:00.6149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRrU4l7Z38Vp2N3lGIK/tsy/MJjvdbcDs92w+7YyqnZuKHyncaiJT6Ibg+0Muu6EwhVAt7cFLlE3Q3nK669JWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6C5A39D55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300144
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6862ca69 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=P-IC7800AAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=AfJK3FX-Xbu8sm4-ayYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 cc=ntf
 awl=host:13216
X-Proofpoint-GUID: YBGXCBMcSno2LeunGnTk-kHM_nfyX_nj
X-Proofpoint-ORIG-GUID: YBGXCBMcSno2LeunGnTk-kHM_nfyX_nj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE0NCBTYWx0ZWRfXy1CB8VtBTmgP eJ6tqYU4ET7J3yYOCtfLaSenoEQrUxr7QVUVoPNB+f4qgHrMYxXlHtCP9gc03Y3a0PYnZ5g38PJ +ncso+d5lWIgiky3HiRuXvQa2AbUShFLG1jNRKqH5kn20A7S852+v5kINjIUNHQQxa/YTowo1VN
 Bmhl3U2p/zE1bEs90A5rPFlyIhwOWBi2s4zoMP4VjXNk5WC0ZoFNJt2RYT90lHubgiTdg5P5qep 9UEq42LzSRmooIZZ51+4Pzx+QJWX2hyVlDRC0gI+bo6ShUo5kokd5wvKJsVw06+T51AQjmLOcDv Wg/SZDTB2mwQusf2wbyNZIFL3I5aa1riwh3fcWctxEfcJvhv9/aQ7KSU4nkczASUxUp8PHJUVJQ
 Ne+Ta0IFrauOh2NxSgmJ80A/Z+s3IWdRmp6m5iEiVZMbjFrLhawe9Oc4TD13rirrNl7/anpP

On 30/06/2025 14:51, Jiri Olsa wrote:
> On Mon, Jun 30, 2025 at 11:01:19AM +0100, Alan Maguire wrote:
>> On 24/06/2025 17:14, Alan Maguire wrote:
>>> On 22/05/2025 07:37, Tony Ambardar wrote:
>>>> I encountered an issue building BTF kernels for 32-bit armhf, where many
>>>> functions are missing in BTF data:
>>>>
>>>>   LD      vmlinux
>>>>   BTFIDS  vmlinux
>>>> WARN: resolve_btfids: unresolved symbol vfs_truncate
>>>> WARN: resolve_btfids: unresolved symbol vfs_fallocate
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_select_cpu_dfl
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu_node
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu_node
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_kick_cpu
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_exit_bstr
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_nr_queued
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_vtime
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_to_local
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert_vtime
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime_from_dsq
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_vtime
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_slice
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_destroy_dsq
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_create_dsq
>>>> WARN: resolve_btfids: unresolved symbol scx_bpf_consume
>>>> WARN: resolve_btfids: unresolved symbol bpf_throw
>>>> WARN: resolve_btfids: unresolved symbol bpf_sock_ops_enable_tx_tstamp
>>>> WARN: resolve_btfids: unresolved symbol bpf_percpu_obj_new_impl
>>>> WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
>>>> WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
>>>> WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
>>>> WARN: resolve_btfids: unresolved symbol bpf_iter_task_vma_new
>>>> WARN: resolve_btfids: unresolved symbol bpf_iter_scx_dsq_new
>>>> WARN: resolve_btfids: unresolved symbol bpf_get_kmem_cache
>>>> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
>>>> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
>>>> WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
>>>>   NM      System.map
>>>>
>>>> After further debugging this can be reproduced more simply:
>>>>
>>>> $ pahole -J -j --btf_features=decl_tag,consistent_func,decl_tag_kfuncs .tmp_vmlinux_armhf
>>>> btf_encoder__tag_kfunc: failed to find kfunc 'scx_bpf_select_cpu_dfl' in BTF
>>>> btf_encoder__tag_kfuncs: failed to tag kfunc 'scx_bpf_select_cpu_dfl'
>>>>
>>>> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
>>>> <nothing>
>>>>
>>>> $ pfunct -Fdwarf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
>>>> s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
>>>>
>>>> $ pahole -J -j --btf_features=decl_tag,decl_tag_kfuncs .tmp_vmlinux_armhf
>>>>
>>>> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
>>>> bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
>>>>
>>>> The key things to note are the pahole 'consistent_func' feature and the u64
>>>> 'wake_flags' parameter vs. arm 32-bit registers. These point to existing
>>>> code handling arguments larger than register-size, allowing them to be
>>>> BTF encoded but only if structs.
>>>>
>>>> Generalize the code for any argument type larger than register size (i.e.
>>>> size > cu->addr_size). This should work for integral or aggregate types,
>>>> and also avoids a bug in the current code where a register-sized struct
>>>> could be mistaken for larger. Note that zero-sized arguments will still
>>>> be marked as inconsistent and not encoded.
>>>>
>>>> Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
>>>> Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
>>>> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>>>> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
>>>
>>> hi Tony,
>>>
>>> I'm planning on landing this shortly unless anyone objects; and on that
>>> topic if anyone has the cycles to test with this patch that would be
>>> great! I ran it through the work-in-progress BTF comparison in github CI
>>> and all looks good; see the "Compare functions generated" step in [1].
>>>
>>> Thanks!
>>>
>>
>> In fact I spoke too soon; there was a bug in the function comparison.
>> After that was fixed, I reran with this patch; see [1].
>>
>> It shows that - as expected - functions with 0-sized params are left
>> out, specifically
>>
>> < int __io_run_local_work(struct io_ring_ctx * ctx, io_tw_token_t tw,
>> int min_events, int max_events);
>> < int __io_run_local_work_loop(struct llist_node * * node, io_tw_token_t
>> tw, int events);
>>
>> We expect this since io_tw_token_t is 0-sized. However on x86_64 it did
>> show one _extra_ function that I didn't expect:
>>
>>> int __vxlan_fdb_delete(struct vxlan_dev * vxlan, const unsigned char
>> * addr, union vxlan_addr ip, __be16 port, __be32 src_vni, __be32 vni,
>> u32 ifindex, bool swdev_notify);
>>
>> It's not clear to me why that function was added with this change - I
>> would have expected it either with or without the change. Any idea why
>> that might be?
> 
> hi,
> I can see that as well, IIUC the 'ip' argument is:
> 
> union vxlan_addr {
>         struct sockaddr_in sin;
>         struct sockaddr_in6 sin6;
>         struct sockaddr sa;
> };
> 
> so we have struct as 4th argument, which sets the has_wide_param condition
> and won't set the fn->proto.unexpected_reg for the function, because of:
> 
>    if (!has_wide_param)
>       fn->proto.unexpected_reg = 1;
> 
> I'm not sure it's correct.. if the ip struct is big enough that it's passed
> on stack, why are the rest of the arguments marked with unexpected_reg
> (in parameter__new) I think I'm missing something
>

Ah you've nailed it, that's the reason! Before we only checked for
struct/typedef or const struct/typedef. However in this case it is a
union, so moving to a size-based rather than an (incomplete) type-based
tests means we previously excluded this function but don't now.

Alan

