Return-Path: <bpf+bounces-43050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F217B9AE840
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C5628D285
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373F81E3DC1;
	Thu, 24 Oct 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QxK5Vmpz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a0rdEplW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6297E1D9A72
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779031; cv=fail; b=aThcK/5YPFRnIbmptLPh8MQDlFwA0VZbCoUA4NNw+PnahXNrTRZYgFWxlinWgCqABI7/y5eyMSsxhXgU9QLvWtE5LMjsDNPg+mN1h4mcV7CliOkDcUHb3kMxonj5jiAowBlqrTcTJ/lOC/YFcA+KDwf5nsuK4wQaGH4YCWXnjyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779031; c=relaxed/simple;
	bh=nz/XImdad8YOWOTDglwaFBYZQuKfcWT34BrkCLrAccA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=guJ6409I487+4m4NZRj+aJ0KvbqIYBKQecIC7t8byfaGiNVYwaNRfWpBKRbYRh2PxZFvxMluK8j4E8vyIVTLdwHnTzODsjjJT/ENrBHvl3eLE0Pe7c8OCyziyg3vVk5G9OhzNQ2rjdOWhfxuk/8UfRaypxnKj6v4hTD2CpFAAL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QxK5Vmpz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a0rdEplW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC1i4g019779;
	Thu, 24 Oct 2024 14:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ki/KBnQAJ4nZ9vHfR0Vew+M1MgnXDX+mV+jBT8agx9U=; b=
	QxK5VmpzmdQOj90VtA/Fk2Ru3xJHZNgvmn7HPgUgO8IlY83vwcL4FuD3NZfhifJp
	HuLjyWIvGxEFtlnI1mfx+u2+3mt0eZiWKfUINmiWrrRdth7av5GvRwiRDYbiP2Aw
	7U0mG1mvoYvZNIpT+xy6ec7Cn6wWp8qtmDrPLQUcEp3eD8Zqque3khObOCGKT2wP
	YlNhXH7Mcu63ilBE2hzCzcRsnQw4ndUyIOSHYIo3Mdk5VO6EwjoWrXl9UjWRT0Uv
	/cf89cDuHN66Pf98rgCLuYpqLqaUMAozvrMFhAYEs6uL5qeSn19qx7cJqu0X4Dfw
	PBGHAclo3JpXVU8zfBT5gA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr20y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 14:10:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OEA7wg030883;
	Thu, 24 Oct 2024 14:10:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh30t24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 14:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXacB0QTOhsVwW1zYDVhfkLjaCz4Nk2XWcF9aOy4U+cnY/Yw6oQCy34Sa5nW+a7rd8oIlS92cfAGkRHO4lf7UjLJx4WgVPl2h4sx+7k8QCiC9UmqljmzVNB3bEZ/7vxn7Q/pkYxdxMQwTMq4miRvDSTcmahKmjVO0V+s3m//iCNNKqtRnj2oUShEvXSB4oz22fOzKPuKxM91/6UkdbcrGBSBOk0wuVdXBL2pCf4luC4XJxNQtmkKH45LD+7xU5q5f6R2QQSsY/Hec40mdXWt82AooSrkApvSYocFqQShpfclCBVOJ8l+ZHOEgP++7v8qFDDyzSBamrxAp5++RjjHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki/KBnQAJ4nZ9vHfR0Vew+M1MgnXDX+mV+jBT8agx9U=;
 b=FAOYY7OpoMCYXm7QfR2DWiUpNDZEQknSQq8/6yM304E/CWxFf4q9gL1sTDAtSESAA5ULNidl5Zu/kfqARnmVwVFMqL2Xb5uXrgEO8dqBBP5y/xfP+kaT+MIcFBun+9vqrnzu4UMltXtDoA7xRydn/kHeRT8fAvm88KS6VcDvD06skKxrGOEDJBiYPh/Vjf3tiQBbwcU7Ku4E9qadQvfI1JagI1Dyxp3etZzfb/kj4L91aLrhLapepZ/8nLvkgkCWp8BLh665D3fph6FgdaFrbns32EwiOjJWBwR5BQGQ4BgYwjs4cmNPrAu2Km61xK0rWgbCJpWsUYoeYBoecYYQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki/KBnQAJ4nZ9vHfR0Vew+M1MgnXDX+mV+jBT8agx9U=;
 b=a0rdEplWVyczZVvTN7lDkkF5dUeKMxw0+nGvq6UnR1sqXj7WUhPb2bddMBbHLQQhsbWPjIfZgA7QEZRc94WwFo2OtcCuvsD3c3fPa6x4Aevq+DRF5b0bwtuQT4k66oIdZR1dTal4tyQeY665Vbj9Slx6Y2+J0dkdmpQFWSMV6N4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV3PR10MB8179.namprd10.prod.outlook.com (2603:10b6:408:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 14:10:23 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 14:10:23 +0000
Message-ID: <b58c8ae4-3a5c-44b3-bc85-2dd7dcea397b@oracle.com>
Date: Thu, 24 Oct 2024 15:10:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Questions about the state of some BTF features
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
References: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV3PR10MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebd2876-fa23-4359-1bab-08dcf4359a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHNJanZrdS9YOTVwamt1SG9EZzE4d3ArOEhueWY2dTZIaGplNWtYUTVCWUdM?=
 =?utf-8?B?N2djeTlQNmhFaElxbHZCVDc0MlJkMXgvQjhtRHZ6Y01Eb2FwWU96dFd2bGZR?=
 =?utf-8?B?Zk5UUHJobGxtMEw4NmFNNXMvYXRHOEd6YVBlZkZGWldLWDQrdVZNVzJhU3lx?=
 =?utf-8?B?blBWYXR2NS9COUdLa2gvdkJNYnNNc0NpeXltWUhmbEZ1WHNudjh3UjJwb0tu?=
 =?utf-8?B?M1BwUVh5cVNLUEZETVpPSnB6UFRpbER6ZmQxWFMrd3d6UDhSbHdibW9ObkdX?=
 =?utf-8?B?enRNdzYwcHZVQkpoaGVHc3hkZEZQRC9BZnBSQmZ6Y09vaTRaTmtFamJkTktn?=
 =?utf-8?B?SlNCUFM4SXFySEhUTy96NlRsMWRwUGQyMWtNbWdiblJnUExETkZJVzZlY3hu?=
 =?utf-8?B?aDN0ZExoNjBGcmtPcjhiaHVDc1UrRTB4YjkyZzVZbnpxMjI0ODFmZGVZSzF6?=
 =?utf-8?B?UEU5aEdQRyt3UU4ycVFMUlN1SncxVE1DQ0hUU0FhK1o0VWZUQ1BJMFpHanZy?=
 =?utf-8?B?SkgzN3o0MWpGc1ZKVGtFeC91TUg3Y3pVZVBUTitnVnFMRThZZ21KZFMyeW9U?=
 =?utf-8?B?T2EzcWxwN1Vwdkh2VlZmanFQa2dBSzgrV3JwOGVjQTRycDNwc0VacWpnM2tk?=
 =?utf-8?B?M2dNL2UramtiVUhnT25XcTRSYWpYTUpUUnlaTDVVanQ5OVZMN2xMTHhseWU2?=
 =?utf-8?B?cGlydHBlT0Z5VkZ2blFrNmNISUptUno3OTBBR3VaU2RzR2JLN3FDTW9TYmJz?=
 =?utf-8?B?L1VacUNBUlc0UncxS1RoTmt4WWVzckpFRUJYcC9CbUswM0ZTdlhJK2JscURs?=
 =?utf-8?B?WjZYN0VXU3dTNVFTYU1yTlE5SU1aTXJKY0M3YXlERlpNbmZHSFZZaUwxM2lZ?=
 =?utf-8?B?WUsxRVd3bnliRDVmcWZrV2FiV2RVNUNwVGl5V0ZXc0tQQTZoSHhTd0FoWnBa?=
 =?utf-8?B?QkRacE9tRnZLdUEzUjJNWVRVbzB5Ymd2bHFObXdWYmRRY1NXREY3T2xscUNY?=
 =?utf-8?B?cjdLc3VUeklmVzAxWnRvYXgxeFhDeFhYbm1SWWpuQTNlUVJnNVp0L2dXKzgr?=
 =?utf-8?B?NFc5WEVFM2FxdUFya2hETFJ1MXJzQTIwVm9IZVlzN2ZjTmF4d0ZyS2l6b1Fm?=
 =?utf-8?B?WXhIbHVWL3FBVGgrN1Z4WjdUN1lrOWxlMEJ5dzViT2dMUTNtWmJtTnEvSzdn?=
 =?utf-8?B?NTVUeEtxNGhzSDFRWWY3V2JCdzIxa2VFOHdSNVJra2JhYnlyOEFzY1B4MmQz?=
 =?utf-8?B?Q2xENmtyZ2VsV0s3OFM3RWJhdXQ1bjliREphd1NRanU4VzA0R0gwdml1ZTlw?=
 =?utf-8?B?bSsvNXNZc1JaMlh0NFBCQzdmeDBRalhaMDNFTXFIWGdpRk5zM21JQlVNVVc3?=
 =?utf-8?B?bG56L3VJcnJqMm5LREtrRWhwd0dleXdWZjlERlQxOGNsUndCUGNZZlRySUFU?=
 =?utf-8?B?OFN2ck9kUGhadStOckUzNGI2YlZVWitDY1IyYTNRZUt6clk3aTRPL0gzOGdj?=
 =?utf-8?B?WU96aHcwR3RJU004Ujd2WW1jTjd4WlRFSWprOG5MLzFiM1owdmlab1p2WkxY?=
 =?utf-8?B?KzdrM3FOV2lsaUU1cWlUNWxQTzJUMEZmdTNONHd6eVNCL1UvUlJwRG9rUFN4?=
 =?utf-8?B?Si9tTmJVMHhTV3RLK0I2QVlDZkdPNDBaQ3lFNExFTmxPSkNrczhCeUhqeXRP?=
 =?utf-8?B?amlDS0VLaDZoV2N5aGFyb0VrcCtBY054VWh4MnluNFpxN2g5bE9QMzFhcGxN?=
 =?utf-8?Q?znN8ji6n2TsgmR/J1EDVsCJsoEsGwNjMvTAvKmK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXRrSWVGRWtEMjdOS0I4bEVlRmR1UmtyZTdQRmpXMFplQUJndzRBbTRTVUw5?=
 =?utf-8?B?YVRXMVVLY2R2Q2dPeEh1WFFIbER2SHJsZGRhRDVXK1gvTDNnMGs2clkxTm9C?=
 =?utf-8?B?TWJBaW15RTY1NlNOM3d3SHNneVBUZ2pSck9QQ0UrZ0pMTkNwcjVaZ0RocWFX?=
 =?utf-8?B?aFlGL1Ztb3pVTDJ0Y2tmbEEwNTN1TDl0NEJXbHVHVXNHdHFtM21RK015cE9B?=
 =?utf-8?B?Mm9xRGw4WWFQc0dBY2dOY2UyNzJ1RHpmYWV2Mjk5UVNLM2tYMUNhNjVTQmFx?=
 =?utf-8?B?aEtEY2wyclBReWlrR2ZhdG9PMkpUY2ltK1Z4cW52RjNaZ2pDWkhLclo3K1pm?=
 =?utf-8?B?cnJLM25uaWsyZnVuMjJNZTV0K1RHTG5iTmtsSHEwdFA4YnAzUlhpM3drMUZI?=
 =?utf-8?B?c2gxNEtpbldsdUNNZkxHaHJMMW1LT0R1bEZicCtETzVueTRoMGtGUnRkSHAz?=
 =?utf-8?B?emR5QlJscnk2Sk5heVZRUmxBZmFXak1tMU02bWorajZzZkl3dnBYem5XZjQy?=
 =?utf-8?B?Zkx3cGRhUGZNampNaG1vU0Framk4Sityd3p5RklmZWtSMHZNV0M4NjBvZG9J?=
 =?utf-8?B?b2YzTGVyV3JQS2dPemd1Sk93TjFTa2Vta0VkS0RoUW53cUFNMG1qZzZVdm1J?=
 =?utf-8?B?TnBQNTMyb2prVHloWWpuU0VoYnk3Tk5kZDd3TGFzaFcrWk8zd1NtZnlReTZj?=
 =?utf-8?B?Uzdqdlh1OE5FbHZvUUZTQk9WejlvNDRaS1gycWRwWFFyVVNJbmI4bmY1ZjA0?=
 =?utf-8?B?UTZJN0F2WWhOdHFuTnd5bGg2QjNzY0grVk81azkwUHpKZktMWFpyeEJ0RUta?=
 =?utf-8?B?TGkvbnVvQVlycFFMT1R2MXNmaGwyUDZaMU45T1pxZTNkdlh5UTVPZi96U21s?=
 =?utf-8?B?VTVnaTJlZmExSmpRcUdnRURManRJdk5GUW9TYkZ6T2Y2ek0xanlaR3BnVk93?=
 =?utf-8?B?Uzk5NnNhaWJuZ2tXc2RwVDFwMVJHcEpYY2xucnUzWkFZQng3TWoxOFRDeFN2?=
 =?utf-8?B?ZFJvclJVRmdPREdOc0lmcGYrRExOU0t1eFRxZTROSjZmTjJqSUxZTmJ1bGU4?=
 =?utf-8?B?eTNjbGpQOHBoNUFwS2g2V3JaZFhONE5DWlNKOEhaRkx1NXBBN1VmZDhaY3ZR?=
 =?utf-8?B?SG5WeDZ1K2djbzVKSGtDcHpDOG5tQjQvUm9sQXYwVWJBKzhmbGVLTnZJMFdN?=
 =?utf-8?B?bWp3RXBtdHNpT1JtQmhOL1RSNTJJQjRVQjBoNlhKNzJJcFNONlc5RmZ4VFZX?=
 =?utf-8?B?MEE4OWx0VENoSS8wWFZabzhvNzVMdGczS0krcTlzakpGYVl2MEVUd2ZLTlFs?=
 =?utf-8?B?c2FBdVFCb1NMQ3k0a1VPYUc3REVFTmhoSENsQTJnRm1KS1BaR0Y3WG9XY09o?=
 =?utf-8?B?TVRsSWtnM0twd3U3dHZVQ09sYmNGRGN1ZTduTStXZ1FuZk15cnNNL3llOE92?=
 =?utf-8?B?RHJuVi90VzJ6eVhjYkxOeTBnYnREb0dFZ203QmhiUXpiSmdieE9zMkhSMERm?=
 =?utf-8?B?bkw4RE04VDdiSW1nYTR6ai9YZllNOHZmTm9rMnNFRHZJcFFOVGRFZkx6bWh6?=
 =?utf-8?B?TFNjZURDcndyVWhQS1kwTm9OYmxXVUI5SWFBR2s3dU8xa1luM3FhNkNHY0dL?=
 =?utf-8?B?UzlDanJNaGxYSm1yQUJhbzVBRGhGWUt2aFo5NWUrZHFSQVV0ZjZGUDgyOE9Z?=
 =?utf-8?B?d1lzaWE5WHBNbGxFNXl5TkdWaTdsM0VYNlNtSlZ5bU1jYlFvUzYzeElKSmZ6?=
 =?utf-8?B?ekZaaitpVWNzRmhvbTNQRXVqOFBUZXk2ZlAvQWdyR0ZoU3g0WEIzUmNiOWVn?=
 =?utf-8?B?OU53NDdDUm9CaUtrWTBwQ3IyOTVDVnovM21TVzliYmk3WHpJdVNJbWR6ZmRG?=
 =?utf-8?B?OWRBeFFWQ3BZVHpIbzhtYVBJdHk3dmZ3eGZJY1l1K0wydmFiZkNyMkE4ZVBp?=
 =?utf-8?B?L25YNGVmMFVaSHFBR2JBMjRoTTRKbE8zZXd5SHNkWjRHbEJleG5mYW13dnNS?=
 =?utf-8?B?UWQyUGRPRnVIbzR0bWFZMXkyNzFsbUU2Wk5FNkpnUHVoVnU0Q3d6SXBvZmdO?=
 =?utf-8?B?RHAxaC96MmdwOUx5aVZoTndIOXBTVlNxOFFVYTc3Znd4OHJpS0FoK28vTm1D?=
 =?utf-8?B?R2pTMnBEWldWMWlsWmhxV0htd1VLZmpIdHBlOGFIcklmVDdlRm5vb25NcVBr?=
 =?utf-8?Q?fO3AiWX4Oc5hK0b2BAK68SM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O77R9PSyCJRJ8RJwHYyYpIdXPbeK8V6zTGFlRj5eot+SS65kJhqpbpUosS4ZdkYowz74eke/0pJZCALVAuVf5/YZ4m2iLdNtiljGGfW3T00f/smm9Fof770xI1m7Zaw0Cyl/IwOR/TTDi+tGVolLMZMbTyuTRbLVBjOfrvBqb4irjC7d8DAuYGrcwcnxG+nQjbh7IMtRzn5MYbMbZ+PFWzahyYHGPCfCCqpyMTVnAucX++89rZHRmnHGR9lG995NYvuoaVqfsG0xFxbDwKuypSZE+vitze4TknmtOlZQmb1TWjFa4Obbu/TnriZYPR5dqLoQDDhHpi4JwO01rpQmMnN1EV/5kbNisVesBiN7v7aJf6xDYOFvOfEy1C6KhtCLQ8YJwxjO+1U3pVi3hUj4xZnZNLcxCwoX/pCsS7GsxmtwaaWehUZKAkLg0+35IbCigMv6yRt33zSyVwvB3wAOskASLkeIb4EC0PyATOFuNc0Y05SYLmhDXW0u07gTneB5/nzENn7NtrrAyeNt5JUGiZEPGpysPWEQMMxTdWxIFF2zpM0NdtWtVIC9yWq7gTDiBbB6OOA1DitLKTcAoykwjTHUl1cj28uRzfHIyzd4mZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebd2876-fa23-4359-1bab-08dcf4359a0b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:10:23.6899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqL7yz1SA8bMXK8aw19cpGsXbbqlYtwKGHqP+b2qri6D6Wt//Yo2lkz5i25SuTGzBqRahG/drPKAP2J4ky+r6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240116
X-Proofpoint-GUID: cNuVDecoTtUru9EZt8klQ9KK8PDZjMlo
X-Proofpoint-ORIG-GUID: cNuVDecoTtUru9EZt8klQ9KK8PDZjMlo

hey Andrii

On 23/10/2024 01:08, Andrii Nakryiko wrote:
> Hey Alan,
> 
> There were a few BTF-related features you've been working on, and I
> realized recently that I don't remember exactly where we ended up with
> them and whether there is anything blocking those features. So instead
> of going on a mailing list archeology trip, I decided to lazily ask
> you directly :)
> 
> Basically, at some point we were discussing and reviewing BTF
> extensions to have a minimal description of BTF types sizes (fixed and
> per-item length). What happened to it? Did we decide it's not
> necessary, or is it still in the works?

Yeah, it's still in the works; more on that below..

> 
> Also, distilled BTF stuff. We landed libbpf-side API (and I believe
> the kernel-side changes went in as well, right?), but I don't think we
> enabled this functionality for kernel builds, is that right? What's
> missing to have relocatable BTF inside kernel modules? Pahole changes?
> Has that landed?
> 

The pahole changes are in, and will be available in the imminent v1.28
release. Distilled BTF will however only be generated for out-of-tree
module builds, since it's not needed for kernels where vmlinux + module
are built at the same time.

Here's the set of BTF things I think we've discussed and folks have
talked about wanting. I've tried to order them based upon dependencies,
but in most cases a different ordering is possible.

1. Build vmlinux BTF as a module (support CONFIG_DEBUG_INFO_BTF=m). This
one helps the embedded folks as modules can be on a separate partition,
and a very large vmlinux is a problem in that environment apparently.
Plus we can do module compression, and I did some measurements and
vmlinux BTF shrinks from ~7Mb to ~1.5Mb when gzip-compressed. This is
sort of a dependency for

2. all global variables in BTF. Stephen Brennan added support to pahole,
but we haven't switched the feature on yet in Makefile.btf. Needs more
testing and for some folks the growth in vmlinux BTF (~1.5Mb) may be an
issue, hence a soft dependency on 1.

3. BTF header modifications to support kind layout. I've been waiting
for the need for a new BTF kind to add this, but that's not strictly
needed. But that brings us on to

4. Augmenting BTF representations to support site-specific info
(including function addresses). We talked about this a bit with Yonghong
at plumbers. Will probably require new kind(s) so 3 should likely be
done first. May also need some special handling so as not to expose
function addresses to unprivileged users.

So I think 1 is possibly needed before 2, and I'm working on an RFC for
1 which I hope to get sent out next week (been a bit delayed working on
the pahole release). 3 would need to be done before 4, or ideally any
other series that introduced new BTF kinds.

So that's the set of things I'm aware of - there may be other needs of
course - but the order 1-4 was roughly how I was thinking we could
attack it. 1 and 2 don't require core BTF changes, so are less
disruptive. We'd got pretty far down the road with an earlier version of
3, so if anyone needed it sooner than I get to it, I'd be happy to help
of course.

Thanks!

Alan


