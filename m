Return-Path: <bpf+bounces-77150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF89CD00D5
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 14:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B86A3019907
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE7933858E;
	Fri, 19 Dec 2025 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ch0kvAZc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Edk069mZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AF1DED57;
	Fri, 19 Dec 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766150204; cv=fail; b=s5PiXL3kiBDOH7YnW29Tqcb7wxMGf9QPYnq2UyQf26S5HghkeVOnDr3hu/XBZKLJu6a/vtQhtMyd33NY0nn1K1q83rA21LLbP1Dpo5PPgDWwPKqWggM9xXJHGn7OucLhuOrki0Fw345PzM2sWNvzW3iF2T7cKb9fZXNsU083HVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766150204; c=relaxed/simple;
	bh=H4FUVTlUZV8lG+x9sOQdTkuRJkgRbaXLeMszRHKi120=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qlPdzmfNOnedoqLni3yU2LemaL1oCFArna3b+CjXbeKqIlwRdOzR9Cj/Cfuz4HsLJ/KaQe0Yo6nnmPTeZnM7rMRw1v3dc0yXcdCuU/ycQwFnp1JGmnSjBo0iBi1KCDCWakyLgksHGEi7QNEY9LZolGIeFs/n3zTkp/18f1SwpI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ch0kvAZc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Edk069mZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ3EYMc2740100;
	Fri, 19 Dec 2025 13:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FdMU9rd4BkeIQR+7wj8ZfWzhHT1riO2Y3u5IKOykAhA=; b=
	Ch0kvAZcFPxdSB6fKIe2RRifWRf/XndNa/Em4+Pm8LUrOIpZDdYl0dnfjcQglSJQ
	rTM5mzxRkBlx9r6/rBHGE9i4fwGEvRqBqFyzSwk9w2l9euowWtjGND7+KlaAiGxM
	V7SxBBjQluPq1HNsWdIsjcEGZososr+Q8vh0My4J53OSfhkXvqRpVfkVgxbVG7bm
	7i/gRdFcs+uE6au5IZB8r7Xe465Q2BiVJAeISNSCDSAdr0q1wCgA8dvLpXlhcHgQ
	OO/ppWog34bSZoif+GDcXh0t7eEeIAboTScn2aZJoPwGSlsEepiwICEiICbz7Rwn
	mGT+cZBulA3hzI1bOspV5w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r2bh315-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 13:15:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJBoEN7036940;
	Fri, 19 Dec 2025 13:15:24 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010033.outbound.protection.outlook.com [40.93.198.33])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtme0fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 13:15:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqfWDD7By5r0XKJToUTiFAjONAhtwtv1vR9a+gc6qYaYVvK7DbbZjE5PWGxSoxcoMqFpOx63Np9+n/ewUJdibDt1lj/ZE66TK1/rVpev0jG56pF01IsAGpWsX8rHq4mH0APzirRxJ5DGhHJIJkj7mEA9YteBhuEsj5anyzvO0lYoNcuG+T3q/psbtWoH8LNmDsBnpxYRXAcRWUhuNb4PVHLRHansaNFeY3LpF0oPrWTDk//LjCvyDKstDSxBqkeqMtCnDPHJ1WNre44pQpGgAuYOwRObt6V0Dwm26TFZI5noqy1FyVCwdL20wKvA6R3Fs6BkndtCxHzSMSrFvpRK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdMU9rd4BkeIQR+7wj8ZfWzhHT1riO2Y3u5IKOykAhA=;
 b=hQPnKZwzIJffmNdw4VFwaDjx4jHxVanaZ3y0sxLSFIvsQZmsZD2Bwr30kMMxna3uGfnJWisURRvXAchxTeqWZ6xDu3IIMTCjBCLqS9kHbE7w0bevMMTCaay7Ypw5ooN5AVW6x+lzhQ9WNXx8MgVW0oU0JP7xeCyXSfE6eNp6Q5xRdm9xDyr7jqA9hTLWD55s5PMMAI4fEQbduTOXnvtL/E2SQxSo1YJ5FR8iDxsnYKT5CI5t8D6EDgo8lgk88zL9iTFw5hbhgl5NaEAGawV7C4vLhfigQ3UMSpVF8gzCSAz36FN5r+sOTFZmtuLkg7FrNZat/uG/JOXadSSQSTTwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdMU9rd4BkeIQR+7wj8ZfWzhHT1riO2Y3u5IKOykAhA=;
 b=Edk069mZdr7RfTmYkLuPL39tCLI9P5kcS7XcP/bYN0TCFzb3p8InPjf7sEJFyxz23Bdfy85sYxz0oBpvM28wPJtg8VpH0c3uJS+ZXBhSOcduRxvSpkF2zQBWMdo/ZHsRr8zp0bqoikBjJIv1Ym4J8VmODxXdM62txa6qfReD+BQ=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA1PR10MB5712.namprd10.prod.outlook.com (2603:10b6:806:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 13:15:20 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 13:15:20 +0000
Message-ID: <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com>
Date: Fri, 19 Dec 2025 13:15:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, mykyta.yatsenko5@gmail.com
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com>
 <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0148.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::16) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA1PR10MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b5ec8f-43cc-4d4a-6dc7-08de3f00a928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUtrTTR0bGExT05OcXJ0RjJ1aHJTQXhzYTRxbnk3T04yTDdFZXB5UWIzYmk2?=
 =?utf-8?B?YUhzaytKdURxSWM3RzVRNGZBY1hPdUZVTnF3aWVEQzJPa2szN09uQTQ5QnhI?=
 =?utf-8?B?QXV4d28yRExoMVdMZkNldk4rSG9mUUdyR2RjbjQ3dkpRRE5aUlEzVXhJWWlm?=
 =?utf-8?B?OWZLdHM1WFFScE1oT0tQa1oraHVkSWR3Z3FWWkNqa2xBZTdRMWZjMnROR0RD?=
 =?utf-8?B?UGhBU1c3enhtT3ZBbWp4RCtLci9uOHRQT0krNGRma1lwa1ZTMTZLcjBGUlNo?=
 =?utf-8?B?eit3cy9JL3lDMnJkWjhlSlMvcnBKYzZoMzd0c2JCT092OWU1OWRDdm9xZWVY?=
 =?utf-8?B?eWJHWGtmR0dYaUxpOVZTTlpzNjBRa1I3dkxYSGlwblU3ZnMraWkybmNtaERo?=
 =?utf-8?B?c3VGditLK1dSWjZZaisza3ByYmxCOGlyblpMWk44QzYyK2VvN3I3S0RuSXBY?=
 =?utf-8?B?alB4dklVbHVQRGJMb2tYd05IVCtkV3NHVmE2L0hodnFKUnkxUGRhZndiZS92?=
 =?utf-8?B?d3BQMEVlREJ2ZVp2Yk9ldHJvTFZQSkpCRUw4ZTlMbEs5c0RWMmJSRW9ETTdP?=
 =?utf-8?B?Qzc0SFFsUi8vWFpBR1NWZlJKK2ZESS9keGxDN2VIcmJrNUl1ZHFvVWNZaWdV?=
 =?utf-8?B?aFlibGNGUlU5bkl2WkRnczJrNzdrRUEzbG1seGcyL05uWFozZ0YwQmxCSEw5?=
 =?utf-8?B?SzZvNnRVQTlOQ0VnWmhnQ0xmbmdmaWttdWNaaFJtdXFGRkQ2d1BsaThmVnNY?=
 =?utf-8?B?ZURVakVaQnRnMmhhemVNM2JaS05zK1hVUnpHWGlibW0zNDFjUG1nd1ZzSGxF?=
 =?utf-8?B?c2FNNnl5eVVOaXdNM0ZNbWlZdVlYc0hRKytWa0x2b0ZMWDJ2bGZZS3plbWpG?=
 =?utf-8?B?VXlXYVY3NXR3Y0gyTDdDUC9Bbk5EeDNuMUwyaENhVHRUN0JuZkQ0SGlBWFdM?=
 =?utf-8?B?QWNFaE1hYnJ0NWthTzlsRDVzeVd2elpDbUkzUHY2S3UxQSt1cE52dTV5cmJQ?=
 =?utf-8?B?N2NTRXJ5WjdzZnZyVHNISXVFMDBsQkY5OEpoM1dQSFRKMy9vNEUrakM2UExP?=
 =?utf-8?B?S3dDR0ZGa2VXZmd3dzlGdHErZmZIVFM1ZzFSWC9XY2xqZU5JeUdGL01xUVVi?=
 =?utf-8?B?Z2xMd0RZNDhuY2VEMzE2SjMxL01WY2VscE5XMTRjdHRhV2l3eEh6cG52Sllk?=
 =?utf-8?B?ckg5U1hEYzlBZ2FKc2t1NXBCWjJ1MlBEMVlCUnlmbkYxSjU4WTZJb1hjVnVl?=
 =?utf-8?B?eXpyQUxQZ0dEblliOVNrSFovbG1PZmUzeGsyUzk2OEtXVEpIM3hadjBhZFFI?=
 =?utf-8?B?aHVDeXpkRTFzZzFOZ1RaU2V6a0Nqck1TOEd6SkZYY242UWw2dDc0Yy8rcTJL?=
 =?utf-8?B?V2srWG5kaUoramdWVEpNUDEzUysvaTJTM1BjUWx2NkdCUXhjZUc0VXpsUlJ2?=
 =?utf-8?B?UWFGMDNSLzJaaVFQa2w2WHR1UTRWbEtQeW1NVm9nL0RuSzBZTXhmVmlHWkYv?=
 =?utf-8?B?TlMvMWgxWElIMmdaYXhsNkRrRW5UK0F4cTBLTmxKMjNxdzNiTi9jck1HN1h2?=
 =?utf-8?B?M01OVU4yL2VzMHJFdWd5UW1BK05nQ1BLdEJKT1VhRDd5SzkwdzZpZ0Z6MjJn?=
 =?utf-8?B?ZWwraVlXRmovdzJlTC92TGozY3NwM0Q5RklDT0tHdnE5a0hJOUJleitwc0lj?=
 =?utf-8?B?SzU2V0lvTm8zVk9xM0o2V3ErV0NFeHZGdDMrQk92RkZnTjd4T1BnRTJrMS9R?=
 =?utf-8?B?cFlPRzErVTJyWHNVV08xaGFQK094bm8wOHM3TGZ0SFNqbituTXhxQUQ0RzVr?=
 =?utf-8?B?WVJLeVJKSkZVbFcwSllWZG1rSStjTS9EM1NHbWJFcXdPNzNCWktneVM5SEVR?=
 =?utf-8?B?ZW5aM21ZTjQrQks1Qy9XRG1TMHdlNUs2K3pnZW1GUXRzSlhsU3dRSFcvOSt0?=
 =?utf-8?B?ckdra2hablFYbVZmWXlZVE12OVROeU5SRXY1ZjB2UkNEem5JM09KU0tIU3Iy?=
 =?utf-8?B?M0N4ZGdtTXd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGVJekZYS2I1cDVHcXpBV2Vsckp4V0M1Vk94NlJkUlV0Y1BNSUNXandkUkRP?=
 =?utf-8?B?NHlpcnJqdFdWcncybXRONlZvYURaK2V4WmxCc2FHZ29EWnlyaStoNnZTcVRL?=
 =?utf-8?B?N1dHTERXVXI3bUlFYTg0QUtvblNsSkRzSFZGWmxZTmhRWHVYQnArdVNkN25V?=
 =?utf-8?B?VHR2cU5qRzNFOERGQVI0R3RXdDNhazNtVEg5QlJBMWJUc2w0NFFBS01sRW9K?=
 =?utf-8?B?S1F2Z3FHcEMycDlQbGp6cmtiYzRUaFNCajVyc3dEb3VaREVwQ29pdXNsajBX?=
 =?utf-8?B?Qlk2eWlKUkRiVGUvMndDY1k3T0h1U3BEaDZvZ1E4aXhOTzVSUHJLeUpqbVBx?=
 =?utf-8?B?V1ByTWtVcTNEVDY2WGpEUU9WdzJ3N1JZMGNKcEloVHMrd1VCTDEwVm9TWDBC?=
 =?utf-8?B?YnZGMU8wQU5xYUZtMmNVQXF4Q1NZYU01VlZYSTN2NXdERWlUcFZyVlVlaWph?=
 =?utf-8?B?cUo2OHI5MTVnejlpUGJWUU1rT1F1dExGREFVWjE3d0taMmhUVlk0S1VTeDl0?=
 =?utf-8?B?Y2t1dm9tWGpQdXZSZHcycUJzaVRjM3d0WmRvVVlUV1ZIMVpWYUJRektUVXRC?=
 =?utf-8?B?OVpOSDJHWUYzZTFZWkhyS1k0YWw2RkFFRm9BNVkrWnBia1dXbHl2bTROMFZL?=
 =?utf-8?B?bHBmYm5UVU11K0l3VTBZSXFJalFUMER5bmpSemhETkpBdHV2Q2RYcHJxTXM5?=
 =?utf-8?B?UGt2czljb2JncjVJalp4Z3NDRXJ4TzVJNXVjdU90Z1lybFhicHEyUUovaFpP?=
 =?utf-8?B?RDBYVE1qcEZLUkU5S2FEa28yNkFWc3N5cWh3WmRiN05xVkFjOWZVMFduM0xj?=
 =?utf-8?B?QXN1bEZMZ1BCRGlYVEZrOHVQSkZlamI2WXN0ZjZOVUI3aG92TkwydVNuRFZB?=
 =?utf-8?B?cmhOeGlna0ZhWjVuYlN6SnJmMzlpOElmejF0b2I2bXhheU1yb2NlTzg4L3lT?=
 =?utf-8?B?SzJpbjJleC9NTklKencyeXZJT2JDY1BvUXJ4dVBUZFNPNXZ3SjZRdFkxejNU?=
 =?utf-8?B?THRpVlliSThxdm44T2lvV2F3cDdCTUZFR1ZMTWZZZGpMdW5HbGpQMDdOcE1u?=
 =?utf-8?B?NC83TTdGdHR0NFRxNDNxVDRSaWc2anBYWjROOXhyQStrT00zdXp5bUxMeURo?=
 =?utf-8?B?NHJCbXJDMjd4NExPNVkyVmNKMXY1MDROVGtlYTVVM1B4dUJYMWUrMWg2MW5i?=
 =?utf-8?B?UnY0eGhUb3ZYNndHUm0vVmQ1SEFPWG5rMVRQTUx0eUNpNE5ucnhSSU5xWndx?=
 =?utf-8?B?OUhEZmJ0WnRHTDVpQytsNzZWWW1nR1BSQUhVUkQzYjB5QWxjblBkWmlzbnhp?=
 =?utf-8?B?alU0U2Nqc1laSTFQeUF6ejNVQThIQkJSWWw1TTdvWWtaYjJWM1F3bU03RHpr?=
 =?utf-8?B?Z0x3aWN3NzVHbXVXengvc0FHaWJac0VBRmdJRWhHL2t3cS9oNWtSSTJJajQ0?=
 =?utf-8?B?R0JWd3ZyclJvWUJBbW9BaDY3TTV6ODdwYUFjR0pVQWJoN1B2b0lXcXBEY08w?=
 =?utf-8?B?bVN1N3M4bm44MnN6aVFmdWdtN2RWU3NQbnJ5OTlybVE4YU9LMk41aC9uVUtu?=
 =?utf-8?B?UUFDYXVpZ2lCb0U5Y24yWTZZNy9LcFQ4MVo3SVV3SjdkWXA4bVpKdFF3bk1M?=
 =?utf-8?B?bzB1bkpPZ21UYWJkR1NBMi81MmZIei9QVGx3bDNnSUsvazgwTVA0WGE5c1Jn?=
 =?utf-8?B?L2tpU1JnRUN6RzgzcnJZdmtOV0g3NW81QmZ5RkRTQ1hEOXQrNnFlV2xaL28r?=
 =?utf-8?B?c0pBb2FoR3ZTVGlRK1NFb3BPalJDbUZzWHh6K3hDajBHZi9xTUtXVzdFcUVo?=
 =?utf-8?B?dU9rUUxqL2xzaHRDRmVOS3k0RVlxcDJxSnBaODdQUVFteXR2bE1xVGxLbjVK?=
 =?utf-8?B?U3FDd2U0V0pnR2NtOU9BV1Q4ZCtCOTFDdDl0aGtvWXJhVWY2Y0tDVGtjRzlM?=
 =?utf-8?B?OHpDSnFZUDlybkVNdWlCMlBVdElZcTVobUgzaWplVm53Ym9Uc281WkJUbjVa?=
 =?utf-8?B?cGF1cHVZL3RnRDZPcFZ4NlNLTVdxTW93QXdIRENUU3RnRHhoUEoxVUNMZWht?=
 =?utf-8?B?bzN6Vk1xZlE1QjlsZlEyMTlZYWw4dmo1aUltbHgxMG9LV2o2b2ZUTjNLNjh3?=
 =?utf-8?B?dzlKaXpjNzgzekhWZkp0a2ZRaGxDUHJqYTk1Nk9RWldDT0lXVFc0bzlLVlJt?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DC3tz0Gme4xycAuitbCDwSS5oeQmWcTUwBdHW11mIRW3O8IM0vOLpL7xX1+lcYkGnQeWB7gdYGMXeGlIxsqV7Ce6jPrFGnhkMBtgRTnnfKzZepqd1duQ2hXEHvdqKqfIfqlWNVc2laWnUjl+Q6VK94hjUe9TpofosNrESbGQrVNMLbY2laPlhKmpyxs1sgyS8G92czdx7tBZC/883gxy2VSCdjDYsmaVUOctBPmGn+wAT29p6/VKqhJGLf/KfOHvoJ94//V+LEVqBLNUnTPlGuQ8gqnkv7u2i4fJeDgP7G2xJIJbIRGn4ozpZ6eULnm0kxd7brtWxfQ2dmiv8AI1ZML4j9MrxNFUHTOFAdns0Wm2Q30eptPXjy1FiybcEtcbDlPx9L5WMETrrkLgqFoWSYtEGj46sLT1eg7aQCGn/ur8iT0/BqOlVeYMsalV2OT3yJ7zzSbp1IIfnjQDMlkplyBe1NNno+005/vyUAjz6cQ2bAe+dr/LZ2ca1Dsyygg+AtbjSaMHcxDrqKocbaR/7WVyRj8048aH87FWUJ1eZX04zYHNmmYih+ubxuZt6MJPcXTAVomEYPNQbb/3u3ag44s+XZuI6v5fkYVzMO4wEqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b5ec8f-43cc-4d4a-6dc7-08de3f00a928
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 13:15:20.5802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oDbrpUG03nTJgyyd2oTukP6mc4cXVdYgJMf6Ghqu4Qlmgl9z7bCUufN9iEQ8XIh59Ef5TP1zV+RtPWWKkVEag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_04,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512190110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDExMCBTYWx0ZWRfX9a3hvswhXnJ1
 rTaKYpS0Lmx4CsyY2ZfnydZqw96zF2lyipG/8FGKKEz9GPs42NM127pbobPT8LH6jp1Kqa9FnUI
 qvqYkbARWvxSJh39RXDkWk7j6yG7fm2S65/XxywYP8bOq98pQRV7YfEc8LjnJiQzkYQ9kO7sol3
 s/vl5fXtNCMEl1kyL56xfSCeib+4aA4jrT4RDDbtN4U58Zv31XCVswxKKJU0MEduyYWWhTggxw/
 FXfHEC6C+Peuu/l39CFi82ZZBfvIrrUSgfTd2gsgPBHSNxB8tSYMst8NtRCHDJ/9iqYklmVyqcB
 tHjNHLixkAQVCYNpUg+RNvRqvOAD7WfeyT2FjzBrvNYrS45qzBotavTdWWrplCZ29QE1TceRfjc
 VAe27vOpkgTGT9qyvEq6Hey6/EXJeFu0m3WHIoMUBvBXheNL/cMfo1GtLb9abs9irpDSDEnaaEs
 pxhZqBX5YQGBAto1is83u+JuoEAD1x1I9vsgpB2s=
X-Proofpoint-ORIG-GUID: mXKxTdwgkUcpAazSY-7yRkZE8DLZ93ft
X-Proofpoint-GUID: mXKxTdwgkUcpAazSY-7yRkZE8DLZ93ft
X-Authority-Analysis: v=2.4 cv=ObyVzxTY c=1 sm=1 tr=0 ts=69454fed b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=d1UaVHkd9MfKgoUzRE8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654

On 16/12/2025 19:23, Andrii Nakryiko wrote:
> On Mon, Dec 15, 2025 at 1:18 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> BTF kind layouts provide information to parse BTF kinds. By separating
>> parsing BTF from using all the information it provides, we allow BTF
>> to encode new features even if they cannot be used by readers. This
>> will be helpful in particular for cases where older tools are used
>> to parse newer BTF with kinds the older tools do not recognize;
>> the BTF can still be parsed in such cases using kind layout.
>>
>> The intent is to support encoding of kind layouts optionally so that
>> tools like pahole can add this information. For each kind, we record
>>
>> - length of singular element following struct btf_type
>> - length of each of the btf_vlen() elements following
>>
>> The ideas here were discussed at [1], [2]; hence
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>
>> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
>> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
>> ---
>>  include/uapi/linux/btf.h       | 11 +++++++++++
>>  tools/include/uapi/linux/btf.h | 11 +++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>> index 266d4ffa6c07..c1854a1c7b38 100644
>> --- a/include/uapi/linux/btf.h
>> +++ b/include/uapi/linux/btf.h
>> @@ -8,6 +8,15 @@
>>  #define BTF_MAGIC      0xeB9F
>>  #define BTF_VERSION    1
>>
>> +/*
>> + * kind layout section consists of a struct btf_kind_layout for each known
>> + * kind at BTF encoding time.
>> + */
>> +struct btf_kind_layout {
>> +       __u8 info_sz;           /* size of singular element after btf_type */
>> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements */
> 
> So Eduard pointed out that at some point we discussed having a name of
> a kind (i.e., "struct", "typedef", etc). By now I have no recollection
> what were the arguments, do you remember? I'm not sure how I feel now
> about having extra 4 bytes per kind, but that's not really a lot of
> data (20*4 = 80 bytes added), so might as well add it, I suppose?
> 

Yeah we went back and forth on that; I think it's on balance worthwhile
to be honest; tools can be a bit more expressive about what's missing.

> I think we were also discussing having flags per kind to designate
> some extra semantics, where applicable. Again, don't remember
> arguments for or against, but one case where I think this would be
> very beneficial is when we add something like type_tag, which is
> inevitably used from "normal" struct and will be almost inevitable in
> normal vmlinux BTF. Think about it, we have some field which will be
> CONST -> PTR -> TYPE_TAG -> STRUCT. That TYPE_TAG shouldn't just
> totally break (old) bpftool's dump, as it really can be easily ignored
> **if we know TYPE_TAG can be ignored and it is just a reference
> type**. That reference type means that there is another type pointed
> to using struct btf_type::type field (instead of that field being a
> size).
> 
> So I think it would be nice to encode this as a flag that says a) kind
> can be ignored without compromising type integrity (i.e., memory
> layout is preserved) which will be true for all kinds of modifier
> kinds (const/volatile/restrict/type_tag, even for typedef that should
> be true) and b) kind is reference type, so struct btf_type::type is a
> "pointer" to a valid other underlying type.
> 
> Thoughts?
> 

Again we did go back and forth here but to me there's much more value in
being both able to parse _and_ sanitize BTF, at least for the simple cases.
What we can include are as you say types in the type graph that are optional
reference kinds (like type tag), and kinds that are not implicated in the
known type graph like the location stuff (it only points _to_ known kinds, 
no known kinds will point to location data). So any case where known
types + optional ref types constitute the type graph we are good.
Anything more complex than these would involve having to represent the
layout of type references within unknown kinds (kind of like what we do for 
field iteration) which seems a bit much.

Now one thing that we might want to introduce here is a sanitization-friendly
kind, either re-using BTF_KIND_UNKN or adding a new vlen-supporting kind
which can be used to overwrite kinds we don't want in the sanitized output.
We need this to preserve the type ids for the kernel BTF we sanitize.
I get that it seems weird to add a new incompatibility to handle incompatibility,
but the sooner we do it the better I guess. The reason I suggest it now is we'd
potentially need some more complex sanitization for the location stuff for
cases like large location sections, and it might be cleaner to have a special
"ignore this it's just sanitization info" kind, especially for cases like 
BTF C dump.


>> +};
>> +
>>  struct btf_header {
>>         __u16   magic;
>>         __u8    version;
>> @@ -19,6 +28,8 @@ struct btf_header {
>>         __u32   type_len;       /* length of type section       */
>>         __u32   str_off;        /* offset of string section     */
>>         __u32   str_len;        /* length of string section     */
>> +       __u32   kind_layout_off;/* offset of kind layout section */
>> +       __u32   kind_layout_len;/* length of kind layout section */
> 
> nit: kind_layout is a bit mouthful, have you considered "descr" (for
> description/descriptor) or just "layout" as a name designator?
> 

Yep, layout seems good. Thanks!

Alan

