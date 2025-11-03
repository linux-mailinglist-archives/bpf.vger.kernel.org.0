Return-Path: <bpf+bounces-73292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA55CC29BFF
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 01:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 710D94E6254
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 00:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC8A1D5ACE;
	Mon,  3 Nov 2025 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YnCmWHA2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAFF1C7012
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131538; cv=fail; b=CzeeqjZt1I+0D6KNt42/rBu7EzSFOQpSmtXugnAAxBmKSoeV3EWeD9/jbqSMULJagtZvWhvBQf4OsH+zdFUTUANYrNMxW+uZgeCKvyztihONGDa6LIARZt9AXSpv75R/06XFgGB9Vca/P7axmymKT/A2rEdBKogC7+QC/uHFyGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131538; c=relaxed/simple;
	bh=XFfQ6NYXnX5ahW+L8TMfRwQ7SF62QBj6LsIoZqT4B7I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYEnc2F3DRDGSzaKtNtU3Et+THJcH8lu/hXrb89oZm6reSBHAD9QWvFX1uSYl+hdbvD5eFML3yn63p+RHTq/PWU5fPobImtZaZdD7eHNwgHNyY1DazzVEbmaRt8HnuebIbptQMBE1l8xQE7NUMbP+vs8CnsDqAozIzqJ/zAhejc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YnCmWHA2; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2Lb29L3779069;
	Sun, 2 Nov 2025 16:58:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=kd6rWj+NHcer2dNiCXt0Vp6f9B0JzsrnQ4o09kI1u44=; b=YnCmWHA2b+0X
	tDVWqBP9GaSb+VpQ347bbrusGCYCPWOMtDzBVDdaga7PYgRbs4i2v8TWtjgPl8Le
	SnjK6BQzRNicAjSc/2SYmNbi1nDXGA4xI052u5QXE/aVd09X4QCe0r7Cq/+Yw7zk
	tY6WClztoaIWTP408ROI6bfe6MgLvveiqKIeKs2sjbLUQByMUqgyxor7Lop7oeox
	Sbom6FsjKc/67l/S/gEr97RNMLBh8lOI+udSe1r2cRQgXcPzA/DxzLDH9zlAxm+v
	HKsduRUGkJMS6Rw5cZ505ZM0rXyRD7esBQ4hbPdO4XHnPUn44VUQXZocKZ4eF+QV
	Vi/9LpOyTA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a5fa8pevs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 02 Nov 2025 16:58:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf2iGKPAhYzRje+wvQwAWI5n212MYCLUOb1z+FQxZeF7hktciCibrCoP5eCLM8irABwIyKnlzP+vzVmAW04I1AARlChYy8R1GxThuHPAlrwM6TneS8Rkiey9mildBdzNK7qJDwcbt2mR6BlVyfQs9PnTkga9X9HvpsR4DsyTKoM7zF+i/INPr+X+fIaJI3ctFJZf88x9Ei1LikDUuMsX9nC4RUdQVxKN1SKBNdmZOkV7G8oI5lRGxcnALBWSAe8wFzDU1EBUkAmDbIUSAp8KBWvFsgJ2t/wl5m9RjHuA1lBeybuGdxclA7gY+f6MGgiAiHsn1zymk/dyCqrfD9rpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd6rWj+NHcer2dNiCXt0Vp6f9B0JzsrnQ4o09kI1u44=;
 b=CYWLWJU/2w3D7k+Gy3sFSojc6KZ5idpZF5do9i+YOk7bOmNU0DeMoHsP+RoChdDOWRCGW5EGRQfl39glP548tHlU+jJ1h2zTESxwE2noRZrWBWCsD6dgegGVgfgUVoPZR5hBV2B9JH8h3p6h4CCFBPyGpGxy1Uq+HUvNDxl8YRAUwym0v+nl/HHfZqjNHVBPpim36759kUdeELEVVwCgbxkqidFn7I6FNJKHEMAnpH6U5VhhoWKnx8mt72pTrejah+Ub/Uz4L4U+/zirtBkJYLNhiK2dZT4nHQXW0h/oVk1pMJLZF63QxFFexuc4jmlvNgEyDMBsh8FlUYPR2Qv+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by BLAPR15MB3987.namprd15.prod.outlook.com (2603:10b6:208:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 00:58:29 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 00:58:29 +0000
Message-ID: <9fdd88c5-2984-4a88-8605-013aa4c2ea09@meta.com>
Date: Sun, 2 Nov 2025 19:58:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
        Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
        qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org
References: <20251102205722.3266908-9-a.s.protopopov@gmail.com>
 <311fb2ea7bc0de371449e98951bf8366aa8b30be8c50c8c549e2501fc9095878@mail.kernel.org>
 <aQfPbc97GSajDCcc@mail.gmail.com>
 <4a9ba760-c9e4-4851-b971-ac929811c52a@linux.dev>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <4a9ba760-c9e4-4851-b971-ac929811c52a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::31) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|BLAPR15MB3987:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ff9c8c-6ac5-427e-1155-08de1a7419f6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2RyY0U5T2lPTmN2RG5QcUtKQjZGQUtxeFp5SS9kbExQNFJCdFAwU285elhi?=
 =?utf-8?B?TmNwVEtPNEh6N2tYM1JPVEtmamQzVGxxcWxXa2NHMW8zeEJrbHVDZksvWEVr?=
 =?utf-8?B?a2lnSkJWWjFkODRpUHV0RXZvTWtMNHdHd1JzVkFSOEhXeXUxUHRtUk5hNjJQ?=
 =?utf-8?B?cWlaOEt2VFVYNGc5bXhnSmxWSHVhTXpqYXRiL1U1cHVhQU9vNFdFbnU4SGRP?=
 =?utf-8?B?UzdTOHF0RzMrMnB5NVJLMVg3LzFOSDJSd05MNEFtYzF0cHR1bDFkd1M5cGVy?=
 =?utf-8?B?WkVWUEhpenQxeGgrdTcwTWRSZGhEbmViQnpBaU1Ebm5XckduUzhCWmFhbndT?=
 =?utf-8?B?dHplOXdnYk8yRlN0TU8wM1JXMmExR3FPNXFrTndNOXNjbm5kRTZ1NmRGVW9T?=
 =?utf-8?B?bEpHRCs1K0tkS0hraCt2WXRVaFVXZTFYL2lzcmovaEZMZjZISVVJb1d2M0Fa?=
 =?utf-8?B?QjR6Skt6bVFscWRCaFFlbXp0bHpyNy9QVE1oUFp6TG1aVDJpSmFCZmpydlVj?=
 =?utf-8?B?b1dTNVRIUk01U096VGg5UWJMZmdxK3JRd0NjOExaR2FQZENoUXFWTVVkSjlG?=
 =?utf-8?B?TEVzeFg5NnFGZFo3cmxKSWJnVHlFVTZuTDJmK0FGM09LcTc2L2RJM1ZqZ25k?=
 =?utf-8?B?TE9CYkRydTBad0duL0UrZVpDWVdvNm5UQzBMOWVVU2FPY21xUDlWa0xJdFcx?=
 =?utf-8?B?OVU1czM3ZE5pcFN0K25HcFVFMDFWSndtbkZmelgzVnBYVXRNaUFzSTlRMXpx?=
 =?utf-8?B?RDVNZlpoWEhsa05SSmRMbWFxYWxQRk1DY1Biem1YYXFOcVRPbEc4NXhuQlV4?=
 =?utf-8?B?WFJJa2xhSWdRM3AwUzZCWHBWQWJOc0tnSDIvVkFCM3NiNDFHSGRwdWlhZS9S?=
 =?utf-8?B?L2tySm1Cb09xM3ZiUDRxTDVobzRYYmlGZ09UREUxcVFJY0pMUGtqeUVFSG1w?=
 =?utf-8?B?Tzk1YjlvL01JTU1ycitLOEI0MXJ6MUl0dVdSQXJYazU2SnpVV3YwN0FLTjRQ?=
 =?utf-8?B?bnNhdWVHVjBWRjVUZ2RwNGVYUkw4ODdIRzBNK25IaWJMbkNQM1NUWjlGZWRs?=
 =?utf-8?B?TTBiTHBPYUV2bEx5YzlwbEhqWXJ1bUFFb01ueUozeVV5cjY0ZlhWVkhITXFT?=
 =?utf-8?B?cW5meXhpNWRLeGpjTVQ1WGtTUDJ4NW4wTGNsSE9pYURHalRMQUpqa1dvMFZV?=
 =?utf-8?B?NEc1aHhmTkh3Sm84eVh5Z3VYKy9IQXd6c3NDYkhaWjNyU21hSnB5c1luajl4?=
 =?utf-8?B?TTJ1NXhlMTF5aTcrQ0lQcWZqcU91blp0cmVHRGVuZzVldC9HaHBrVXA5Mm9s?=
 =?utf-8?B?eCtDZXZwTXlHN3RteWZUc3V6NXF6ZlNMa2Vta2hLeUwxbWgxSUI4ck9uRVlS?=
 =?utf-8?B?bVFnU2pDTVVuMzFRTGtGTSttRWVacWRzUXpKNE1KYU5RZmY0eGN6c01HOFdY?=
 =?utf-8?B?YlRsRElURjcrV3dPZHVmeHZKdk9BazFpZElJaFpFbXJNUm1sUlpZN3JlazVN?=
 =?utf-8?B?QWRTMkVoU3ROSEtKd2hYRnZGQkYvTXgrUEZuYm5ZeERhVk0wdGxHYllsTSt5?=
 =?utf-8?B?QTlVcWxHeitpYjN1Z2dXYzRpN1dacWtBUVFtU3pKUm5uZnJMTXNjRjhBQWFU?=
 =?utf-8?B?bmw1bkRsWTdmZDVPVW1mTVZGcVlXS1owMDQ1Vk1uc1czYzNFdDE5cm5GSmxI?=
 =?utf-8?B?SUFrc1l3UWxVTkdleTVFd0lxSzVLTmpCV2tjUjZFVFRxWGpScGtzSGF1cEh6?=
 =?utf-8?B?emNXcXRlQ05VOFBVMWduOE4xRGJTRmlwaEhMVGozSURaMG5pMXRxQXZHMzhK?=
 =?utf-8?B?dERIYmF2M0dDZzFDSk41N25lanhjaTVDeS9kTVgzaWlpeHpKR0FjMmxRcXF1?=
 =?utf-8?B?c0E4a0I4S09FRWtjRmxWRHY1K1FMSmwyUU55MjNBbHhCWU8rWTRDV2dZejF2?=
 =?utf-8?B?VTBqdFU5MWdndXA5Y2MyR0JKYkNwWGVFcHF6Wll3Nkt4L1Z2emhScUZlVHRi?=
 =?utf-8?B?aGdqakgxeTZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWRMSjVSUnBZNVlLeVhuekF0ZE9PM1NLRmlERGNFWWRSTytUQjVuMzEwSVdp?=
 =?utf-8?B?M2p0akZpZUpVZjEyTHh1SENtT2c0TEt6Y256N1doUG5Wa3QzMHNqU05KVWV3?=
 =?utf-8?B?VHVycVo4K05kamYyRHN2cmw5TU5lMXd0UWlXMWJzNXhuRitKNWxJU0wwUGFZ?=
 =?utf-8?B?R1YzaWwxSWpVQzZPNHA3NHR1dXdtVEc3YWpxd1pub3pFV0JtYWVXYlBsS1lQ?=
 =?utf-8?B?TkFUM2NNOS9tSGp1SktudnZJTSs1QThTbEV4djR1UDVRbTNYcDRzTkFueGov?=
 =?utf-8?B?REJ0NUFabHdyME5SYzBDOEczRXN1bkFGd2l0OE94cWk3ZnY0emdZL01JVW5Z?=
 =?utf-8?B?WFMxa2RQbzBDcnFPKzJNRXF4NWxhVUJHQUZZcGxNQ001YkN4Z1ZhSlZJdWpN?=
 =?utf-8?B?ZFU0WUwrdCs1NElWWDJLQ2daYzF3dWoybXp6Q2hCdXVJclFxc0x3MldvbXFJ?=
 =?utf-8?B?bnAyL2RWenBmNkdCTnVia1pKeDdIU0V1a3l2Z2IyTnRoZmlrbDRlR0dQc2ZW?=
 =?utf-8?B?M29oTTdTL0VETDRlYjRsZEFrcG5xcHVzZTRWUXp5cGRqVVlvelpSR1pWbmVX?=
 =?utf-8?B?Wi9rQ1V3aEdsZ3JxbE5vYytRUnpUaFpJdmVMWmJPa0luOG8za3ZLZm9CWGlq?=
 =?utf-8?B?aUR0Y3JoTGM2TlM5SFU4c0NqdkNQNWs4blE2R0l0U3dHV05EZkc5K3Y1Qy9r?=
 =?utf-8?B?QTRnUEFpSVpjVFQzTkFnaXo5OTYydmFMRjZDUnBWdFp0UzJ3cEo0RElRNDB5?=
 =?utf-8?B?aTM3UUZEN0ZqKzMyOHl1c3FCcklUc3FucVdVV3RWaXVTbnN1TU5DbFlSR2Z6?=
 =?utf-8?B?aDI0cTdDbmJoVXlQaE41dVZMSHpicTZHSTZtblprdE8vdll0Q1JwZnpzcU9Q?=
 =?utf-8?B?M3h3UFlEKzR0bDFJUGl6NWRpTkgrVG42dEV5YklFMkREVFRQZm1NQ3JUeUp3?=
 =?utf-8?B?Wlg0V1hSbEJyOFBLRnVrby91dFdKRE5GQkY0UkdhZGdTOGJURStISVFqeEJQ?=
 =?utf-8?B?MWd5bis0MVVDc1lDdnlPTUx1TGNTKytaUkU0K3B4aXNLNFZINVVDeVJwa0Nj?=
 =?utf-8?B?OUptdWZ3MWt2YXB1Ulh1c2N2ZzVpbE82ZWtDSEFpRjdVbmNBRGZxaU5LUkJs?=
 =?utf-8?B?MTZhNnZoV0xVbHl0SGVKNEJYK1pMcFVtMHhrYU1keERxcE4rTXF4UXJRZEgv?=
 =?utf-8?B?N3VQMFNvcE1mbHFpVnkrQmhqRFlFQ0JJWVE1MS9MNFFRZW9KNDcybkJXYU96?=
 =?utf-8?B?SEtDM2NWNm4zNDVLS3NlYzUrSS9ycTc1bzlHTndYMGlYY2J5WEZWV1pvNHhz?=
 =?utf-8?B?YUkveDJ1clRlWEdMODR0ZjF1Skp0RHdoWVlXbTdoSDhicDdId3J6VWlqK0g0?=
 =?utf-8?B?dk9DbG1Ea2lXTllJK3RjT3k1ME1mdEFxNHd0Smdxc2JDUGkzdHRLZ1Y4d1d5?=
 =?utf-8?B?YytrVm1uUDBVcjd5dm9GMTJDbHNzSkdwRXZsVEg4TGwvMmwzMUtZbGJLK0Zt?=
 =?utf-8?B?NTR4MnV6TTVnYlAxQWk2S2JjRWZUR3dxRW1zRjF3Wm5JTWVDWXV3MFBnRGlC?=
 =?utf-8?B?U1dTTiswSHhVb01PTmhTTVBlUXBzNWx2OTVmaUhVa25Kczh6aGRYSFZWRE00?=
 =?utf-8?B?aEZ6VS9MbE1KUXJxcGpSZ1F0TFV2RDhzK1pWMGExTXFndVhNcVFZMTkyMm8v?=
 =?utf-8?B?NndmWDJkdW5vdGR2UUhnbUdjM04ycmV1SGRuSzErSytjanBYOWVWZXhNcnRI?=
 =?utf-8?B?VXpPNWlEeUxEZWlLODZIT24veWxycE1PeHBjUHlYa3JDU24xUlZ2NnlwMFlL?=
 =?utf-8?B?cFV4RlBmL2J2Rk5ESTFSOE0yNTRYNW1pOW10Vy9PUlNiYytPQ1JDTUk2OHdF?=
 =?utf-8?B?UVB3aENLWFpJVlNLcWxWcnFqZTBEV2gvSWtGSnBEODk2KzNwRzY5bUhwSnpn?=
 =?utf-8?B?K3hrR2F4L0lFWlozcEdjUjYxSEZLeXZIeHNhdzhhQnoyYlozTmpNb3U3a0ZF?=
 =?utf-8?B?eW9kb3ZFa2pZdDFGZlRjb1d0dEpCdkQwUDBmQm5mYVRmNk03TGhYNDJtWE1Z?=
 =?utf-8?B?N05QR2FydmtOQzN4VmJ2aEVXT1F3R2piNDgzakgrYlVSVUhiVkU3VFEyMXB1?=
 =?utf-8?Q?tslA0WWJz68i7uANkHs99AOvU?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ff9c8c-6ac5-427e-1155-08de1a7419f6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 00:58:28.9045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR5Mcbd8WNEQMItgKkr48oeypIiM1HhVRnpNgh9AAe97QZc2u3IZO8B8In6MPy4z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3987
X-Authority-Analysis: v=2.4 cv=feOgCkQF c=1 sm=1 tr=0 ts=6907fe36 cx=c_pps
 a=dJs83p8YoJtII+u9Eez95A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=uw4a1xsULhh5cgedDzoA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 0-ff_R12O0l5OC9cUcK2npGMQ6OTaGTt
X-Proofpoint-ORIG-GUID: 0-ff_R12O0l5OC9cUcK2npGMQ6OTaGTt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDAwNiBTYWx0ZWRfXwAFbDbZ+Fef4
 NaXjmp/fdPkNTSG0CvRJeSnU8CFfpmHlT0Rc7LuEyBcy7OC22o0XX14z1j9Tbsdu64kqiV7Ti4J
 TZE6uUfyk44d+/Is8qRInbC66LDIys5RZeqZxFmDGmu1fER3c1Xfer2W38OnSZy67f+J0n7j+Qs
 3Wmg+wram/y+kl/9htM55/gWqL4/BKEk7Zt7yK20zax1uKR0IlpXPgYhDyz2AypcW4tASwCa+7y
 k4H4xdPgcPp5MfoC3nrZRY2gk7E3WF2nUw8bbLGZZqE+lYWhAKW/WReDV5JDgj/fIe+5IzuEVEl
 qf41PezTUidwORF+X87RmIVC+namMpp1bXDsV8XG1iNCUkgiOM5u7TUu1gHSqH+gp87pV1x3fOt
 16JETB6CUz/L+jeVNG5Ds1uHiObxWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01

On 11/2/25 7:32 PM, Ihor Solodrai wrote:
> 
> 
> On 11/2/25 1:38 PM, Anton Protopopov wrote:
>> On 25/11/02 09:13PM, bot+bpf-ci@kernel.org wrote:
                                                     ^^^^^^^^^^^^
>>>
>>> Does this error message print the correct offset? Since jt is a pointer
>>> to __u64, the array access jt[i] is at byte offset "sym_off + i * 8",
>>> not "sym_off + i". All the other error messages in create_jt_map report
>>> byte offsets and sizes (sym_off, jt_size, sym_off + jt_size), so this
>>> one should probably be "sym_off + i * jt_entry_size" for consistency.
>>
>> Is there a way to run this AI as part of any PR to
>> kernel-patches/bpf, not only those coming from the mailing list?
>> Maybe for a selected commit?
> 
> Hi Anton,
> 
> If you have access to an "agentic" AI coding tool that runs locally,
> such as Claude Code, you can use our prompts repository [1] with a
> trigger prompt like this:
> 
>   Current directory is the root of a Linux Kernel git repository.
>   Using the prompt `review/review-core.md` and the prompt directory
>   `review` do a code review of the top commit in the Linux repository.
> 
> The prompts expect the "agent" to be able to read and write files, and
> execute basic commands such as grep, find, awk and similar.
> 
> In principle it's possible to enable the review CI job for arbitrary
> pull requests, but the tokens are not free so we haven't considered
> that yet.

At least for me, it really helps having the reviews on the list.  It
gives me the chance to see what kinds of bugs AI is flagging correctly
and where the false positives are.  I do try and fix all the bad reviews
that people flag, so the comments here are really helpful.

This isn't meant to discourage people from running reviews locally, I'm
happy to help get you setup.  But I also don't want to add a barrier to
contributing code.

> 
> [1] https://github.com/masoncl/review-prompts 
> 
>>
>> Also, how deterministinc it is?  Will it generate different comments
>> for a given patch for different runs?
> 
> The short answer is no, the answers are not deterministic.
> 
> However for typical/obvious bugs you might often get a comment about
> the same issue worded differently.
Yeah, recent changes to the prompts have made it better, but for some
bugs it still wanders off without flagging a percentage of the time.

Also, sometimes it'll get excited about finding a bug (even if a false
positive) and skip to the end of the review, so if a patch has multiple
problems, we might need multiple submissions to see them.  I've been
working on this as well, but there's still room for improvement.

-chris


