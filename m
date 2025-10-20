Return-Path: <bpf+bounces-71441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CB4BF356D
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDA718C0C5F
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287342DF70E;
	Mon, 20 Oct 2025 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GjitIpgO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W/r2H613"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65612D6400;
	Mon, 20 Oct 2025 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991096; cv=fail; b=kq21eRSidYueVPtNMsI2rRoAYaz927K0Xovhs7WXY5IjrNDLJfGHrH7M6KRRdsKQFMlI++wAl24ZRVT2PEZUP9nNGOtuVYnFjevXDT3agO8UVXYidYQaxBzdgC6vdZaoTM/19Ck7bcgnEAtb9q97sbnxc/DHQMZYP9lJw3YKPbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991096; c=relaxed/simple;
	bh=wgORowd6HiX2ErMeZIosae5V9T7z7AACjwAvtrGqRDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C6/YewY7eWXzkYC+tNWQ+0JAu8F6eghh/cgLO1+ncaXCv+udnz3Msgm/I93fPxRQKB5EU+9EzrYNJboodnA3QVxD2qSWopn+bPjNdAWpnFsDr8wa0cWsBE2w2j+hN+V4iS8Z/wrDxnD2a/AasfkC+pzt+094OSBIcbNbBj+XXQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GjitIpgO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W/r2H613; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KJum1q029389;
	Mon, 20 Oct 2025 20:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gEWpKkd7H/51ZB8mBqTLnvf3DEecJWohWCRxvkMsDKQ=; b=
	GjitIpgO7IT43O4dEOkZ/EfBwS6uSCabqYGYmjzrBH5QbGOAV9yevDKjgGfK1J5I
	7X+TUPnWlMTuMXbinydfDdgrX9ZGUimlTgWF53/s0PwwH41/CTYcCuGQbmnZ43Nr
	EfIgov2I45/nrwBXIQQeTXTnGOhexs7z0jRgKD6V2VpKvNB6Cch7VhimWC2wDYVB
	gf1OuUThdc0WkoPnMLukaFIIxrX2P2mlYmK2rL5iSO3N0VlIRbOHbvxk2hCURBG8
	wM0MGJiBkQLJQeQCeq54jwZKK8+qg7hYFjGy9bzrzJbfItNM2jN1X43l3R5Bvzy7
	Z/ZO+Yw5m94UkMqTl2STNA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v31d32jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 20:11:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KJpEZf035110;
	Mon, 20 Oct 2025 20:11:12 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bc3vde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 20:11:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiBqXrWg0RW5nE2KQ28ZF0j1Vm+C3jZBorSaAN7XkoK/B0TcoHTMEEcGfpS2nJ7g/9vtpSwLVCBcup4pzBLELz2yCMe6nIYyiSFFuhYGttN3Nxa03ygj2HQm67Yck5D81U4yhmH47u8nKGuX40Jx1t7ZiNJNYlNubbKgdBPSX8UsyYGuIDevupLWqPTv8/EjQAMle0AV/N70ft8f8TsDM+RfOrVPTJ/3Ipbu2jej0NmjXwKlxsA9dXIcdse+CUn3Z60HJgrdCPmB9mJDvj+JwfvLFouX2WiUlSq1s7cBxFAdEpFusq8nkBuwSvChEkjicqJtVex1h5mRfa4YYRfC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEWpKkd7H/51ZB8mBqTLnvf3DEecJWohWCRxvkMsDKQ=;
 b=e+Zz0rw+7BMcQPoZUEMbhtwB1BWqRivc00I3aCbUDhW6DZGKrVw6h0uXB/kUpO2m/5j2PdEH3yGYLngAk6c/2841pNE5My2MgmDFZosnPmiZNF7qFWWife1FToUD+K4ZAQNLa2KofjVlVQPogKrrvAAs+mujflBRH+1YfNv2N6HWIs9JZBzYk/+bPgisAgFUjnLYv6lUJtlDs3Rr6YuUpVrCcmikJUtlpJms3jCmSzDV78uA3ArpkL8DnJDt5sAXh+fLFfKmVdVpHeAx2TQ4qIJKoUKWhexOKj/C/iKGegLnYHroZh4ZSRJ+ffIkHD/0q0bhbHWdIlu4OiPyCZOKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEWpKkd7H/51ZB8mBqTLnvf3DEecJWohWCRxvkMsDKQ=;
 b=W/r2H613imDQuwQkaKCMzGCWNcRiiw6i/W26eVvMHpAEoJvwjS9KTyx37HRF8KnEWatGW6WOf/dn8rEvhXlv9wUC1RYoHxdFXcyrCB7aCb2Ov+KZYZv9NP1RGO9iDUzFQaOpid5CZjN/gZZJ3otDxnr/tFqWiQCD/tHH4v/X+p0=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB7213.namprd10.prod.outlook.com (2603:10b6:208:3f2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Mon, 20 Oct 2025 20:11:09 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 20:11:09 +0000
Message-ID: <33a601cf-d885-424b-a159-f114c1d3e9c0@oracle.com>
Date: Mon, 20 Oct 2025 21:11:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] pahole: Avoid generating artificial inlined
 functions for BTF
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@fb.com
References: <20251003173620.2892942-1-yonghong.song@linux.dev>
 <2dce0093-9376-4c06-b306-7e7d5660aadf@oracle.com>
 <984c45b9-fc67-4077-af52-d9464608fede@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <984c45b9-fc67-4077-af52-d9464608fede@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::10) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 074aaeb9-9446-49c1-efe2-08de1014cefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3ZmZ2Q2MmhVcVQ2K0xBdWd6cHRTNGdxZGp0aGdzTndReUwrUUw0Z1JaRXhZ?=
 =?utf-8?B?aUd3YWFCSEcyUnBiclpsUzVTbGNhNDF0RDdXeXlnK0JqdGVWdlNSeGdvbEor?=
 =?utf-8?B?cHdzVHJwSzROeU1YOFhwRXl3UENEeklXaWlNVFgrRXo4eDA0dngxR2V2b1RJ?=
 =?utf-8?B?THdDYlBabGdCZTlHV3BRUVkzREhiUFBYK2tlcXlrUDBNblJvMlVBTXNIWE4r?=
 =?utf-8?B?Mk9iOFFHSlFjUlY2UmxjRTVFbWMydHBuT1RCQ3lRN2pNVXhLa3RjZFVGL2Rp?=
 =?utf-8?B?YjVjb3ZkV1hta2xpYmk3dmN0RlByVnVCanFyb1NUZE1TSExUWkRqdFNRai85?=
 =?utf-8?B?dlhmdHpTOVc1RFpNWTljcnVRR3p5aDhGeXlXYTJXemZXalV5NDV5RVhDWjl2?=
 =?utf-8?B?bTdubU5GU2d0UmlFeWtVb2tZTlBoUjN2RmFhMjh1N09WeXYwZ2FQaURDTzhQ?=
 =?utf-8?B?TTBkTG9mb0laL0VaMDJYbk1HdVpRWkwrV0l2Ry85MVV6VDcvcTB6TzFnLyt0?=
 =?utf-8?B?cVg2eW1zSkJYWlRhOURuUDExdzEyT3gxWnhLS1ltOVJJZlgvY3lMZkp2S0M0?=
 =?utf-8?B?a1Mzd3VaMmxqQlhHNlZmQkFhYnZxMGNmbGRkYVh4bFNWMW5OK2lpVTBuUUU0?=
 =?utf-8?B?TkZHY0ZqS1F0NGYvTVVYR1ZldDZUNzJFR0NCNFJ5VnpVNUlNVGdTWmxjdGZB?=
 =?utf-8?B?L1ZvOHVlY2hUamZLdXYvZDNzT0MzaWMwQkdLSDErbUI0M0t5TmQ0cktiV1d0?=
 =?utf-8?B?MXZBdFdUNTZ0MmVxc3VKVmNjYVZraVpkaGVNSk1MWFF3Sy9XVENKcUlqc05w?=
 =?utf-8?B?eE9rb0VDTVBMV3J6cUNWbkhFMzd0dFczb0lpV2lWc0ZsdmhYQkh0YUpIQ1E5?=
 =?utf-8?B?eUxBbEZjUG5FRlEreS93VHoyNnZzVVBjbkp2T3BVaUtycWFZNGR1clpLbVF5?=
 =?utf-8?B?MEFBeHpacm5EcjBDSkkyRFIwU3Q2SG9GNERXSW15YXFrVGxyNyt5NlYrbjBn?=
 =?utf-8?B?dHRrVGpDUjlGNGMxUFNZQ2hKdTBISXlhWmNHQXNzNUVhazZ6bzdXdkR5dXIy?=
 =?utf-8?B?elNXSlE4aFp1UzMrZ2NEbDZyU0tydTJTNmZMaXBlWVRtd0FiM3VTdnlDdUx2?=
 =?utf-8?B?bWVCWVl0R3JvTzhxUXZpN3BEd2lSL3IrMGdpRk1tb210NC8xSGFIWE9ybUJ6?=
 =?utf-8?B?RzZGby84c09SNlhTOVVZbTc1WStxb0pBWFM0MTZXK3Y5dUt6amtLdUJLR3FI?=
 =?utf-8?B?QzN0N2VFS05DUFF4MzJVcDhtbVIwM3lkTVlVcnRxd0c0OVlLNWNXYjhLeGVF?=
 =?utf-8?B?cTgvUzRQUjRYZ2I2Y0RPaWNLcTR4S2xNQ0s0VG9NN05ocEhaaEg0WnpGajJ2?=
 =?utf-8?B?clhwWnhuSUFLQW1oQXU3SU1MaWVlYzlOREF6eW9ycEhndTdrQ0gyd0pLQVVx?=
 =?utf-8?B?U2tMaTk2WDZnRHZZN0FXcEhTRUFwYlhDbTE3WktZUlQzNGN2NHFMV0Q4Y1F3?=
 =?utf-8?B?cTdGUFVqaWxYeDdXRjZSVDRsSGlHdFMwb1pTQmczNVkwdUM1UCt4YWhja245?=
 =?utf-8?B?MlVjZzVzQXJRUElhWjQ0cURGb1dWbDZxcGlvcUhpd09oaG9Sbnp3NXpTcUdM?=
 =?utf-8?B?M0dYWlIzajZuc2VDMzFPOVVtODNqbkI0bDZtVEFkcHpjWEtWUzE1OVFMS0pX?=
 =?utf-8?B?OGJVQ1NJWFY1bzg3N0FmZ2lUQmI0ODFmNTNsdkFOeUo5QnI1aUdUTmJldFFr?=
 =?utf-8?B?WmpMM3pKWlRJZjVpcFJBMVpWZGNvUGtpQjl4MVM2NXNIRmQzT1BsL3RUdEJN?=
 =?utf-8?B?dDBFUUo5YkdyTkkzTUJjUVNSMGpUTUplS3orUGYzdmI1bmc4MnZ0Z1BUYjVJ?=
 =?utf-8?B?anprTktZYkhDZXRGSTh3bmZkQ3hVMXpwRGdSVHA1M0lXRkRIaHNGZlQrdUpa?=
 =?utf-8?B?eFdxV3VkdGQwcU1ET05PREhuaHI3aFpkOXc5K3VaRi91ajFHYVdKMnhtRmZ4?=
 =?utf-8?B?K3Q3V3dldEdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGlHZVVyZjEydk15djNrU0VFQWt2cFBhWnFPLzRIOGs5VytEaWY0bHlRejhl?=
 =?utf-8?B?UXoyVlBEVW5IbEVDZkZ2dnY3M2VTRXdrbS9pNDAyeExXOEJpMDlOSXhzUnAr?=
 =?utf-8?B?dC9BSE5BbEFuZUNnemV3YlJCRHpBdnpnZGRGSVA1ZCtMMnNFdDJReGdsK0o2?=
 =?utf-8?B?NEIvcUxRUVpBV3BUcFZFZFlpMHV2VUwvTDg4QjFTNlAvaFdhYVdHNURXOWhI?=
 =?utf-8?B?UlhKd01KaVRjTkJFVlIwdmpFVmx4Um1NTWJVY0JDQWtaenluVGRTdXkrSnNo?=
 =?utf-8?B?SFZrSlV5cDQ3YzU2K21lYTBwUE9SQVBDZm9Cc1hFYzE2YUtuN2dYV1Q1NktE?=
 =?utf-8?B?MUhETWJNcU9qZzAzTVlaWEdESFBpMDd4TEhCYlJiMzYxRXJFTFJqQ2ZwS05z?=
 =?utf-8?B?VXNFTmY5TkZTVmRobXhiUzRHeGpQaWhMN1VoSlYrUWNUNHFJYzFra09VRmVz?=
 =?utf-8?B?TUxEdU9UL3VPWUhza0tDUXlBVEhZRzFrSmwrQkprQ0REeVk0bWpxUkJYcTk5?=
 =?utf-8?B?ell0cWE5NWVhNUIyRjhPN3kxMnFFOG15eGZiUTdBTGVhOS80TVFLSmpOREFm?=
 =?utf-8?B?bE5rZkRuTUtVYVhVSkVhR282K2NuQUxJUjF2MFJOaW83WWd3dmZrQ1VTL3Mx?=
 =?utf-8?B?RW5OU0N0Z3lRRGNzdndiOXRLWVVPcjBhYkg5aFR2YjArdmlWalZQY3M4U2FS?=
 =?utf-8?B?aGVoOENpTjBKL1p0T0pFcXY0VWx0cXh5MDRQZjdsS29vbW4zS1VFcjlaOHBX?=
 =?utf-8?B?WlNMc2tBVDlxUCtFTnFIZHhWWTFjR0FHcTRjUm1qcDFBaC9OdTE2M242M21n?=
 =?utf-8?B?anYxRGpPYnh1b2Jod0tvdGlnb01HNGcwdFNsYXdFd3VnYjc1WlpObDFWckxJ?=
 =?utf-8?B?bFRIbXljc3M1Z1pJUU16MXFKMDYzRk4rZnFkU0lkREpIMmcrYnp6bVVaTzB1?=
 =?utf-8?B?aEdNVUFFU3o5RGYveXk4cUdRek9YS3BmTkVKTUNRQVhURHd3dlhSdi8yNGgx?=
 =?utf-8?B?MjZzQjBWSm5kNi9OR0RmWnVrbWhNbUNRTXpyazZEYkt3WnRrWXBNTU9qdms0?=
 =?utf-8?B?SG5VRjFicktDN3ZSOTl4N1hpM21iRlZDTEhvME1KbTBPOWxDWHBVNzBBbkVF?=
 =?utf-8?B?UDZxQ2gzQ2NwamFueDJ0UWdrZVVoWk1iZ29WWmRtc0FTWm1TQUZBd1dQbnNh?=
 =?utf-8?B?ZnFyMUZsWTBxL3hQaWVJM2NlU3pRTmtUV1llamNvbjVua2pqQjU3TStRZVBR?=
 =?utf-8?B?Tk1VcXZYdTRFT3RzcXlueGI2M25ZM0Z5S3UvV0ZSMGNLV0RGTUFVM3JJSTJE?=
 =?utf-8?B?blNtK01MdUdxeXRkWDN6d29IdGJpVHcvVXpXR0NRQkxWZnRPM0pScE9hQi9B?=
 =?utf-8?B?T1dQcWVldkNjdFhMUHlyZzg5TlhTRGtZSnZTRnpKYXBxRk9zQlpYekcyUzRn?=
 =?utf-8?B?eGJGaWhGOGxYbWRYdll1NFgyeUM3VTZRNjh0Q2t0OTZvaFByVG1ETkdBR3lT?=
 =?utf-8?B?T1pabmFYNlVLNWhycll3Wm9rVms0YnVKY3d4MVZDMUk2NERURHh6WDNOTnJw?=
 =?utf-8?B?QS9oWVRqeldYb1o2c0ZscHo5VGVNbVVKYmZEL0Q5L1QyMWlUSFVXeDA3TjQz?=
 =?utf-8?B?Y3kwZWdLa3Y5Z1ZQK0p2VXg0Y2pSaE1tbytpTlgrT1hLeUFYWmlGdkVhVnZt?=
 =?utf-8?B?WEdZV0hPdHUveUxESCtIQVQ0dVJVbndZRzFHZ1d3OGVSRWRMdWRScTdkUWNs?=
 =?utf-8?B?M0FPcXFNZ3N2cVlhanR5ZkpTTncrdk8rS3BvNTB2REtHd2ppQ0RGY3lHTk9R?=
 =?utf-8?B?eTlQbmplSlAwZDFNU1lkR0lTWE9MdTFSeDR4NS9qZnhSTXp3WFZla3ZsYnJK?=
 =?utf-8?B?elpWTVlWSTNlU2V5SDI0M1BPRXZCazZtRTZSREhEeXRrekNBc0Q1Sjk4Snoy?=
 =?utf-8?B?L1R3T1R2K09LUUVOaVhJN0xMdk1FVTdaWFlkSmpEOWI2NmhrdHF5UmZKQWdv?=
 =?utf-8?B?STZmeXgxQjhPN3BROUxCcW9UZWpvdzBiK0tCN2xzYzgzNFB1dmhnNHBYcFRF?=
 =?utf-8?B?QmRScUx1WkNObGhYOHU0b080SzZLeUFja1FCUzl3TDJrZU8wTXV2R2V6WC9J?=
 =?utf-8?B?Ky91OTlaaUoxOEgrZnpjV1VZYlE3aGxXcmgxSmxiOEluZCs2OWF5YnBvM3RP?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nue+Hhp44coq5eSGEvZHWrBTuDCTg5/MAZn/69Ztsklkq+r8/ZBO9eRycKJqIQ2yKA56zKLduQ3bDAWKB2bu4It6WO/GvgpqFHSKQWp6iqWxLPQpzffds6REUnQzAG6dhPzyzaMyb2mJscK/6oSpV9kC+AP63xzdUclLBjcQEWQ2eGfFcVnjzxI1l8O8rFoNq8mRc83gVkheb3GRkBHOOvQYRt96kbcDnQAiwsWjmtJDLec7gAA73YG/Qsab4hla9nhfkDqvGHWF0r96E3zarzVkNG9tbEXJb0oNFpbPf1uJ/eYQsx9RgiKD55AiHdgcgrtdcfy/lQ7JLPGc0NRoEJmtHAWlLet5q5SkMcUQBbrOyAcV03tt28oSXZixhOEIVYGse+LoHuQ5m8k3me1LUFKsTzpjSTS/NB9Ec5FM/dBb3GJ+zt6PMegMCFoSdSK4KWKgwn58Ixq174cZWy6TvHHuZajKIugZjLEfVqrZqW0Ze6uhpkRjQm3cuxWZU8/yKVWK3Gknq6LKpX1Exrp5SO8gqAEyZxpU+YriAGZq5c+jftUhSr8VLV2WKAZeElyjzdq0zwXrQJ7DM/FL+vPsyIN61i80mkFpb/5zesL//C0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074aaeb9-9446-49c1-efe2-08de1014cefb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 20:11:09.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQw3lw9p7z2xWhMYflebrk+y3DUONJPy1qJ1uR6Wy+XmPEK71nlQHaUPBb274AI8VDdq7QIk6bAQNNBZfXkpHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX6sNaXRszlTUl
 f+ez3zCDvnX8pplsgUIfTup25/ruudrE8v9cGyUm6SIhwzTyhueWaygsw3rE8+mekSrc9bjg6Vj
 5MMxA3J/yf+VoTSjc7jJ0XkV+dMc0TJqypJOcKg6DktufkL1wogMbNn5ka6BfBgTyy7LYYaaqYN
 0tDuvFAvhQyBNqM0Lbxj+OuxKNHWQhJAye2b+Pzb6/15lIAD6VNKJTN6x7ccZJteEBxE7Ql+YDp
 fVdxEw4vgQCoJ3gzrUYIy3OEKh6ORF/UzEde4w/SFux8BtB4chGFclhmYDYAZeoow2zgX43rEqN
 dpuNiskXK1XrHPVeoh1quUPJslfzYNX3Bq84eTyWsgoyR4w96JykAv2B9MIQ7u9G21joYu32hNV
 OOSOfUMAAQSKAAIeKQoMl10wCnuqmdlH7L7NgjTvluG+QzW0NcA=
X-Proofpoint-GUID: 8s5J-f-7G-IyqnQoJq7Su0Y8diqxe-X3
X-Authority-Analysis: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=68f69762 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=lLcmX3t46Yaz6Pr9f-QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: 8s5J-f-7G-IyqnQoJq7Su0Y8diqxe-X3

On 20/10/2025 17:01, Yonghong Song wrote:
> 
> 
> On 10/20/25 3:53 AM, Alan Maguire wrote:
>> On 03/10/2025 18:36, Yonghong Song wrote:
>>> In llvm pull request [1], the dwarf is changed to accommodate functions
>>> whose signatures are different from source level although they have
>>> the same name. Other non-source functions are also included in dwarf.
>>>
>>> The following is an example:
>>>
>>> The source:
>>> ====
>>>    $ cat test.c
>>>    struct t { int a; };
>>>    char *tar(struct t *a, struct t *d);
>>>    __attribute__((noinline)) static char * foo(struct t *a, struct t
>>> *d, int b)
>>>    {
>>>      return tar(a, d);
>>>    }
>>>    char *bar(struct t *a, struct t *d)
>>>    {
>>>      return foo(a, d, 1);
>>>    }
>>> ====
>>>
>>> Part of generated dwarf:
>>> ====
>>> 0x0000005c:   DW_TAG_subprogram
>>>                  DW_AT_low_pc    (0x0000000000000010)
>>>                  DW_AT_high_pc   (0x0000000000000015)
>>>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>>>                  DW_AT_linkage_name      ("foo")
>>>                  DW_AT_name      ("foo")
>>>                  DW_AT_decl_file ("/home/yhs/tests/sig-change/
>>> deadarg/test.c")
>>>                  DW_AT_decl_line (3)
>>>                  DW_AT_type      (0x000000bb "char *")
>>>                  DW_AT_artificial        (true)
>>>                  DW_AT_external  (true)
>>>
>>> 0x0000006c:     DW_TAG_formal_parameter
>>>                    DW_AT_location        (DW_OP_reg5 RDI)
>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>> change/deadarg/test.c")
>>>                    DW_AT_decl_line       (3)
>>>                    DW_AT_type    (0x000000c4 "t *")
>>>
>>> 0x00000075:     DW_TAG_formal_parameter
>>>                    DW_AT_location        (DW_OP_reg4 RSI)
>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>> change/deadarg/test.c")
>>>                    DW_AT_decl_line       (3)
>>>                    DW_AT_type    (0x000000c4 "t *")
>>>
>>> 0x0000007e:     DW_TAG_inlined_subroutine
>>>                    DW_AT_abstract_origin (0x0000009a "foo")
>>>                    DW_AT_low_pc  (0x0000000000000010)
>>>                    DW_AT_high_pc (0x0000000000000015)
>>>                    DW_AT_call_file       ("/home/yhs/tests/sig-
>>> change/deadarg/test.c")
>>>                    DW_AT_call_line       (0)
>>>
>>> 0x0000008a:       DW_TAG_formal_parameter
>>>                      DW_AT_location      (DW_OP_reg5 RDI)
>>>                      DW_AT_abstract_origin       (0x000000a2 "a")
>>>
>>> 0x00000091:       DW_TAG_formal_parameter
>>>                      DW_AT_location      (DW_OP_reg4 RSI)
>>>                      DW_AT_abstract_origin       (0x000000aa "d")
>>>
>>> 0x00000098:       NULL
>>>
>>> 0x00000099:     NULL
>>>
>>> 0x0000009a:   DW_TAG_subprogram
>>>                  DW_AT_name      ("foo")
>>>                  DW_AT_decl_file ("/home/yhs/tests/sig-change/
>>> deadarg/test.c")
>>>                  DW_AT_decl_line (3)
>>>                  DW_AT_prototyped        (true)
>>>                  DW_AT_type      (0x000000bb "char *")
>>>                  DW_AT_inline    (DW_INL_inlined)
>>>
>>> 0x000000a2:     DW_TAG_formal_parameter
>>>                    DW_AT_name    ("a")
>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>> change/deadarg/test.c")
>>>                    DW_AT_decl_line       (3)
>>>                    DW_AT_type    (0x000000c4 "t *")
>>>
>>> 0x000000aa:     DW_TAG_formal_parameter
>>>                    DW_AT_name    ("d")
>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>> change/deadarg/test.c")
>>>                    DW_AT_decl_line       (3)
>>>                    DW_AT_type    (0x000000c4 "t *")
>>>
>>> 0x000000b2:     DW_TAG_formal_parameter
>>>                    DW_AT_name    ("b")
>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>> change/deadarg/test.c")
>>>                    DW_AT_decl_line       (3)
>>>                    DW_AT_type    (0x000000d8 "int")
>>>
>>> 0x000000ba:     NULL
>>> ====
>>>
>>> In the above, there are two subprograms with the same name 'foo'.
>>> Currently btf encoder will consider both functions as ELF functions.
>>> Since two subprograms have different signature, the funciton will
>>> be ignored.
>>>
>>> But actually, one of function 'foo' is marked as DW_INL_inlined which
>>> means
>>> we should not treat it as an elf funciton. The patch fixed this issue
>>> by filtering subprograms if the corresponding function__inlined() is
>>> true.
>>>
>>> This will fix the issue for [1]. But it should work fine without [1]
>>> too.
>>>
>>>    [1] https://github.com/llvm/llvm-project/pull/157349
>> The change itself looks fine on the surface but it has some odd
>> consequences that we need to find a solution for.
>>
>> Specifically in CI I was seeing an error in BTF-to-DWARF function
>> comparison:
>>
>> https://github.com/alan-maguire/dwarves/actions/runs/18376819644/
>> job/52352757287#step:7:40
>>
>> 1: Validation of BTF encoding of functions; this may take some time:
>> ERROR: mismatch : BTF '__be32 ip6_make_flowlabel(struct net *, struct
>> sk_buff *, __be32, struct flowi6 *, bool);' not found; DWARF ''
>>
>> Further investigation reveals the problem; there is a constprop variant
>> of ip6_make_flowlabel():
>>
>> ffffffff81ecf390 t ip6_make_flowlabel.constprop.0
>>
>> ..and the problem is it has a different function signature:
>>
>> __be32 ip6_make_flowlabel(struct net *, struct sk_buff *, __be32, struct
>> flowi6 *, bool);
>>
>> The "real" function (that was inlined, other than the constprop variant)
>> looks like this:
>>
>> static inline __be32 ip6_make_flowlabel(struct net *net, struct sk_buff
>> *skb,
>>                       __be32 flowlabel, bool autolabel,
>>                       struct flowi6 *fl6);
>>
>> i.e. the last two parameters are in a different order.
> 
> It is interesting that gcc optimization may change parameter orders...
> 

Yeah, I'm checking into this because I sort of wonder if it's a bug in
pahole processing and that the bool was in fact constant-propagated and
the struct fl6 * was actually the last ip6_make_flowlabel.constprop
parameter. Might be an issue in how we handle abstract origin cases.

>>
>> Digging into the DWARF representation, the .constprop function uses an
>> abstract origin reference to the original function. In the case prior to
>> your change, we would have compared function signatures across both
>> representations and found the inconsistency and then avoided emitting
>> BTF for the function.
>>
>> However with your change, we no longer add a function representation for
>> the inline case to contrast with and detect that inconsistency.
>>
>> So that's the core problem; your change is trying to avoid comparing
>> across inlined and uninlined functions with the same name/prefix, but
>> sometimes we need to do exactly that to detect inconsistent
>> representations when they really are inlined/uninlined instances of the
>> same function. I don't see an easy answer here since it seems to me both
>> are legitimate cases.
> 
> The upstream does not like llvm pull request (associated with this patch)
> so it is totally ok to discard this patch. Sorry, I think generally
> we should only care about the *real* functions. But I missed that
> you want to compare signatures of the *read* functions and *inlined*
> functions.
> 

Yeah, it's all a symptom of the fact we are trying to reconstruct things
with incomplete info; these are all tradeoffs but I'm hoping with the
location info we can at least provide data about the tricky cases rather
than simply skip them.

>>
>> I'm hoping we can use BTF location info [1] to cover cases like this
>> where we have inconsistencies between types in parameters. Rather than
>> having to decide which case is correct we simply use location
>> representations for the cases where we are unsure. This will make such
>> cases safely traceable since we have info about where parameters are
>> stored.
> 
> Indeed this could solve the inlined functions problem. Again, please
> discard
> this patch for now.
>

Will do; sorry it took me a while to get around to this one! Thanks!

Alan

