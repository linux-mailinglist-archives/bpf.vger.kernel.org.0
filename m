Return-Path: <bpf+bounces-28108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D588B5DAE
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B011C21E00
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6B282D83;
	Mon, 29 Apr 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RTs8+jYf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e8sVNqd9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3082883
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404358; cv=fail; b=txFctcK/4gzJpPjeC9iW9KgmmRrl29BmOt/XiXHNoLL6Fw0u+ddkPH/BQMEfh7+8XqsIRpFzIHwv6aSq7RBsCJOzJdqvY58fcOBDzSybw2c0L8irW7//Zwn/uRgPxhSiBDTonomyOqAzubtX0fWDJ43wdWKWd5lUXdeacKi9sNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404358; c=relaxed/simple;
	bh=56WHCx5FX7YRJW71GUb7AM/xruqJMD/dd3cVc+iczEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fVU2S+m7kgki1WqSql3lB6TcnWFxC9kRVW0YwfqN4znGvo7hfjC3dgIcmpcc7/WZSUuY9tkPqP9vzxOLPT0un7lFmrXOHyu46zffPDatgHSUsvFlyirGGXytv5XyONWY8r1Fj2pxUU+8i7kZoUSHonuhGBBbbGsx7Y9pU0gjTWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RTs8+jYf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e8sVNqd9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43T7jP44006854;
	Mon, 29 Apr 2024 15:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mq4HR1DZZrGjhZ9t1v+CFaZ5kRvifTGcHadBaB78y2Q=;
 b=RTs8+jYfrFzf236+nT7uoNX6Xo9d2biHWZ4k5cgdZICHAuraVCPDoFVtDz57l3CdL5Hp
 ol0ttp9+NwUhQHGAT/2kfMjKxkLLib+5zXftCp53lvrxN6BdQ0ryBo2I2w+NLa6HkCHz
 Nszp+WvAjYfIeqio7qjvtTx6wz8g4c4PPQ30dAvZhZgE3SNX0gvM2C8GYtoxnOY5n71c
 GLXAqpC/eRQjwxQuFcWZ8HjxE0yUg0X+iqpOno3yNZvqPvwdjXs36qnojAAr3N0HVm1Q
 cK4jqF2JQO6n7ID2fwQCrZUIK7SY44d5JwIsy6KKVVUSRAj3Irfk3Hqd4uQrH18CPUof tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8cjv2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 15:25:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TF21Ds016723;
	Mon, 29 Apr 2024 15:25:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcga0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 15:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5K4Mns+r3FVL1hLBHqYDF9MDsQWV17GcgfOMJsE0QLCWkGwirOEzgylPrcV9BNsdEkK4URXt5yyN1bbRHZ8yCdXvV+LIGjNB/wtFhNDgcBfrl2XBsarmxt+BkIWsux2hxbRXhnijIjGhvcZkT+CHid2m+kq6Mzuqa9CytC5u6PcrHItu1Fml7I7fd+bTMa+mjjdk/hm71GNpgFHXkmnwUPjFczVqF039PHxHXbk6Fq7dxXatEpNmmRDyuH7Cj5qHQGY5Q9OV80iz0kcNu/OLiYJ7Wl9gwJYjPTEIUGcuoVVUZ+uz/OVMDhpI8+Y4iUOv6XmiUPXlwjOAiTyENefsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq4HR1DZZrGjhZ9t1v+CFaZ5kRvifTGcHadBaB78y2Q=;
 b=lsbhRxpfLfjjRsuFKwUZArpZsN1SIiU6qeUS+bV67+P5BwhT6TyupRxAbmIPWScRPsk1FJticO2bvtB4KADwFRxfL/nabHyQ0T8OOgJvT7WBxMusvRilS+t3m3/AsZN448oAAswHKG6XEnFAfjmUAGnyFO2AiKNcPGJDONgEYGKp0h3ldxI7F1HGtSXjTaKi5J1Bk4EaFm5m7YCwsQkcynILJiLDDKqTInUQ4Fv9t1I2//4x0E0pxfmbYtL9j7F5jzgWNESyZZHrFY6CIgO9TF5CsdshdGw4akSeXBw8XdLsfHxpNkODwY9nlMHD2VjwTdTskLQben7GDSramQrfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq4HR1DZZrGjhZ9t1v+CFaZ5kRvifTGcHadBaB78y2Q=;
 b=e8sVNqd9c6hmPOf5w9hP5PW1wpgupbiTUatSi1Cm6TReTsMLgMCwUvGJ8tiVWy0BwXJ5eoAFrFdi1+B3Kep8AvgNdF0hiioHzg2aHYsUTCE0d3vBt2N/fy5QNi5OVfEE3ETEXqAfaGI+q1/Si3Ie5fZKD7b9zHPwQvWWZokNrYo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB6811.namprd10.prod.outlook.com (2603:10b6:610:14c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:25:14 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 15:25:14 +0000
Message-ID: <e08937ac-c329-4a72-9a6e-8fbc36a740b5@oracle.com>
Date: Mon, 29 Apr 2024 16:25:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 00/13] bpf: support resilient split BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <CAEf4BzavgDXC2fM43+20wvHdXbaHRNQLWmWhtzyUh_57UYTc6Q@mail.gmail.com>
 <CAEf4BzY-P3rdV1LeJFBO_zVMn7pr+b166BOaGZEO4ZQrLdPqKA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzY-P3rdV1LeJFBO_zVMn7pr+b166BOaGZEO4ZQrLdPqKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 905c7f18-cea2-4e62-35f4-08dc68609154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SDUwS3AzQy94eUltYlplNk8zanFpMnd4TURYZkQzUzhUaFB6Z1BpT1lEVFBE?=
 =?utf-8?B?NHJJZityalFoYmVtcEw3Tk92VUU3UkM2aTVUTS9NTVpxWldPMlhFZWZjOTNP?=
 =?utf-8?B?R2VrRmd3cTRkb3ExTEs2WVBnZXVBdXVOdUVVdWhOa2UrcEZRREJWNDBFRTVN?=
 =?utf-8?B?Q0VoSUNTcUo2aGM2VlJ4U2NqRmtjUEpaVlhRWVk4Kzc3SkhPZVo0bHNQTnJa?=
 =?utf-8?B?SkVucytRZGJUb0d0UWs4bGFKcnlXbjh6WUtTcWpBaXBkRDBCYnN1UnVFNURL?=
 =?utf-8?B?RitEZUxOK2tmcDVxbjFWT2psRG5yRXMza3RiclE2VFc4S1lMU055SEtrTTFo?=
 =?utf-8?B?NGJPNjVvRVI5RFVZeDRnS0t2NVVka3UrVTl2UjJxOTRYL0k3LzVBL1k3ZTJG?=
 =?utf-8?B?UkFXUGRXNEc1R2l4K1VKaE5YMEtMTjdQL05GWlpQd0gzVGZ6Z3pJazlSblZq?=
 =?utf-8?B?MGQ0dTQ4KzVGR1I3V1pGSWFqWlBVYjE4VTd1UDl4Q2JhR0N3NjFwdGNMZ1ZH?=
 =?utf-8?B?VXFOTkNUckJ2ZS9OcURNbnZKMUFoS3laTTBOM0lmNSt4WUZXbktoZTVpOTEw?=
 =?utf-8?B?andqaWdaVm9Kb0wvYWhTV1V3Sk9DS2xnU0EyRmR5VHdWaXJPU3paUGRPeVg5?=
 =?utf-8?B?RnptRFpMbytxamZVQUdjdS93TFRycXdnRmUyMkJsZlBVVzhieU5oeFhPUTFV?=
 =?utf-8?B?R3ZoL0hUcUk4emZHU1NtaEpXK3lSWCtQclJOVWh2NEo1ZlQ3T2ZGNVBubUVz?=
 =?utf-8?B?OVA2UkkyWTVaVVJpNTdxckJ4Y0VtcG94VFJVcHBSaUlvM1Bad2s4U2c2Y1VS?=
 =?utf-8?B?NlFsLy92eXVHTXMrOTZQMWtlRzlWalNxMEZZUXpySnh4Z2xaZnkrSlN1UHcy?=
 =?utf-8?B?ejRKa1BhZlZCNTZUNDFXdXJzdEw0N1gzellkbXhYRjA4a2kxbXhsOU1pY0M2?=
 =?utf-8?B?SUpNWkRSS1dHZXNzdTdaMm11NWJoYWtSdE5aS3VQMUxnSHQvVjJBTXhiK0Nq?=
 =?utf-8?B?VUxXWm1xQmx6eDhtcXdSNlM1M2MyUVNhVEhLdnRTMlBmUUIxVzF2cG44N3Q0?=
 =?utf-8?B?ZldBTE1raFc5OVVWc29oV3FqcGx0TkN4aDc5RXpHM2lFc2lrakxvTUxWTncr?=
 =?utf-8?B?ODFEekEvQ09RclRHOTdzK212aFc5cHQ5QmNvTFBEUWdnajJ3ZHdHZWVzeHdx?=
 =?utf-8?B?WU5lZENZWVByS1M0K2oyRjlrejR5QkVJZHN3REljT01obkJVeU5yT3J0bDh0?=
 =?utf-8?B?alpiTFA3Tm5QTEFUL2JXSEFBVDVjY2xxcTJjZUR0TXFDT3llZDRiUDVyOEJo?=
 =?utf-8?B?V1BkRjN6MHRiVXc4dUpPNjlxa29MeTJrTEFNYlBUckpubzdvNjVvTFZCT1ZT?=
 =?utf-8?B?eXpNV0g3NUMzVWxmdFZMSVcvNnpRMlFmalVic3FmOXZLTHlmbXpiVEZKZzZh?=
 =?utf-8?B?d3lERk82ditKaFh3ekJSOVRqNEpJRUhIRXc3OVdHV1lEdXV5MnlHRVJTb2M5?=
 =?utf-8?B?L01aZ0dhcFBLUkxXS3JYdzBodFdubDEzYU5zY2dzYThURHRLNzkvVFBuK3dT?=
 =?utf-8?B?cStVSmZYOVZBaFBFN1BwcytUYzFGRVZ1SE45cGVXRUtSc2xEcnRIU0VzVHVH?=
 =?utf-8?Q?w6sL3Fk7JANadBKU2WPyCeHvddWqals0gLABAlerdYPU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MXRsRzlZeFRLOTBZdlJrWmwvbTd6TnB1SUc1cGYzdEplanhSQnpEb0tnQ1lu?=
 =?utf-8?B?UTFWUTYrZHFPdnpxMmxvUkpJMmNCZkREcE1laUxBSHlaUk9LQ2dxSDBuc0tj?=
 =?utf-8?B?QWQ4aHJ6T0E2S2VFVlM3T1BubkYwNlBobDVmNWR6bUc2SUU0NlRTUFlSWmp2?=
 =?utf-8?B?UVFkTllCTWZKQnBScnd3anVzQ2xHeldFd0duOXhYYmpRNjJjUkZ0eGNIaEJB?=
 =?utf-8?B?Q0djaSs0ZkQ2RC9YNTNUZFliZ2dNL3RtMW1ZNloxbTFTWWJQak1PZXBhM3dZ?=
 =?utf-8?B?eW12cUZOazE0Mld1aW5aWHh6MVRBUGluSmgxV0IwUVJsNFhab1RKWmh5NmNz?=
 =?utf-8?B?MWYrUGw0NFpqekxHZW5WQ29NK1VjQ3Q5cFJUQkNScUQ0bzZXZ0dnNFR3WWNu?=
 =?utf-8?B?V2ZqY1llMjI4cjFhV0J1Vmk2T3E0OHM2MzhKMlY3eGtuOGlEUExKL1AwdVgx?=
 =?utf-8?B?d3NJa05wNWx2YitsS0VudXZzN2F0YlRSSHRORXlmNlBnQnZydDBDbmhUL0dQ?=
 =?utf-8?B?cksxVHZ6MmlkMHdmaFVyWGpnalhqd3BrZTE5Q0QwOUFyYlJGY1RWbFZHRisr?=
 =?utf-8?B?WUJ0OTFzMFAyeHg5TzV5bkdXc2JuU1hPQjRhdU5HOURmU0p4c3Y0L0Jrempr?=
 =?utf-8?B?ZXdZQmdMZ3JkbzRONFYyU3NDYkFoNU5VQk1aRHNSNXVYS1ExN3dEZmxaRVpk?=
 =?utf-8?B?TjR0c2VzUzJ1dkNjM1FtcDVrYzA5Y2IrWStoM0d1emF5NFcrYXB4SUg1VnBT?=
 =?utf-8?B?VjBNcTR1RDFRZmd0Sk51c1JBeHlYSlBxY00xQXhMVG9SYlN6ODBkYk9yOS9x?=
 =?utf-8?B?eEdlVEdtb1hHS3FiZkpDcmtZbjdpREhoRXZ5aU9oSmxac3RpR0hwa1VDM1M4?=
 =?utf-8?B?d0J5RFFYaHg1T0I4K2REK2FOWDFodzRYUnUrUFJMaUYrMFBXTTZSNXU5NDlH?=
 =?utf-8?B?SVZaTzJmdWdRaVJlN2JMNDlYUVprQUhMV1NlTkoybUlzSTlJSHBxNS9nUlZ2?=
 =?utf-8?B?Nis4UzV6ZFBteHNUdjUwVDhCUm1renJWQkZmakdyVzJHL1B0R2JMeVp6Mk1l?=
 =?utf-8?B?NTY3TFRyS2srQXBsbnIrMHRkR2dvRTJJYWd0bmpzandObHFjYTBCY1VmWXdj?=
 =?utf-8?B?OWh2cXNjbTF0UGRqVXJERDlaMGJKbUJpaHNzQjFiSWRQZitvTTYxNGhHeE9C?=
 =?utf-8?B?dmFUY3hLaUpzM0EzeXZwUEIrTyt1eW9DWG01ZVRoK0t1S3Z5WHFyVkVUNFhI?=
 =?utf-8?B?aUtGeCsvMXdvWVF3U0JyWUh3NnZhYW4rQWRyWVMyeVFBK3ovTHZMdzRsVXpr?=
 =?utf-8?B?UnJhYll6TThXSDJvUTl4QWYxTnNWN09vdjVxWjgrdW9WS014ckh1NXUrRk54?=
 =?utf-8?B?bjRuMUdMQnlVTXFmSFo5UU5oKzFUSmtNcTZkeEtnYTZYalQxUlcwV25zTlBu?=
 =?utf-8?B?Mmg2V3JubG4rVWpPYzRDNFNGblF0aWNvUmdpSENmYm52N3pLQ2dNQVBvVjk5?=
 =?utf-8?B?QytQVVNkeHZSTXpibXVyUDViODJYWG9BbmhsNm1EVEVmWlF6SVIrSXZ4RTVE?=
 =?utf-8?B?NGJLbkJLZS9lZVdqR0NYTysyMmk0N2haWVRFSXc3Yy9rVWE1b01KK0tVaEQ4?=
 =?utf-8?B?WFIyT1loVUFTVjRjVTBrUzNjUVprZ2M2Z3B3V0xkSk5BSTNWUmt4aStqcFpR?=
 =?utf-8?B?aVdJWStsUjR3ZTVTZUxkQ1ZXRGl0TU5jNnUzb3VvWjloL1pFODJ3dFlaYzNr?=
 =?utf-8?B?R3JVYXIwNHRTNUh4MFJTdkhVTkpHWDZHY0Q5Vmx4MWdPMmpHeGc1RWtFUkta?=
 =?utf-8?B?dm1iQjVKWHB5NHREWG5OMWROMFJUaktOMndpQzkyR0lUN292bWpMVDZzcFRt?=
 =?utf-8?B?YVA1MmpYWEg0TnZucmYvRnpmZzVWY0lnek0yNGwrUmNhSEExckNhU3VlMXRx?=
 =?utf-8?B?UmFFOElSS2F2VzBYRHIxRzBLbnVpQlQ1TVg3Rmp0cEIwZlBiSW8vbDh0QlNK?=
 =?utf-8?B?S3dhWmNHbld5V1VOZXVHR09xaFlCSHh4dGdDVDlqR3R2a01Kc3ZuZzA2UFNt?=
 =?utf-8?B?cStVN0FzY3J6ZUFwV1U3R05Ld2hIcnN5cmJ6MFFSR3JPK05TNUJsUWRqcVdE?=
 =?utf-8?B?QXVScXMwWEVvV0NmQ0p3RSsrWHJYQWw2Q3A1YzBiVEc2SFk0LzJhdi82L1VO?=
 =?utf-8?Q?r4FuL+RSa1KUmebj8N9EVh4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WgdjK5ityIt1CrfNkg8LvjIJcHCFfiwO7KWOqWPNd+EvUNfKrp+voK8zwYrbGLjRWWpXvmQUwR6SXTr/nrCdkttpouGGPkdB4yei7eDwy/E5R8cEDALmWI8usqTvtLs4I8D2tCN39oP/z0gFa5+8MFmZ7L0ozKoM0KS67ugEqTmEWDf9RrxHBwQJRkn3cIYSfNqrhl3kOjvy1ojq4r8soyihHGtVSEeuskLHiqYrKmy3GAteTNP8/7VU0HsgU/cAWxQ2+n9BdlGCBaL4fpwJ+hFO6Ex4R8f4QzNt3eoZ3VKFwyHT09+drxSCbPOw1fY0wQhIQ4KiqIM0qJsiDTHyNZEleGM7iRmVvPIG8J1zgvD4LweJDxVMDuE4P4sGqW+tPW3+KMfwV8wV/NnScb1DDhN99SvKxBy5YLELYtzfS4RWEJZhCu0m1z2xSVwetOliS5dzr51M2LEY1kUWzIIXgIrjc2gnlnjQXpiw0dk66Okw4asDC4BFJzq/9veD4PKFlUPKlpJJUHQt6xQRxgsQXXcCiZ8MT8vgIfCQTLKukUUgRsqyrV6T3NQHp6rGKful/1ng4EJdcGJ8rmAqgf48b+BcTVpDkjI0A6i2XeSraSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905c7f18-cea2-4e62-35f4-08dc68609154
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:25:14.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xcc9JIHDkEmuOOaBckiLOj2eO0aeoSaamsXC6QPweNd+NAXB3m2Ysfp8hdD4OynEAGqfKdMg3KnOLGDAKlSxNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290098
X-Proofpoint-GUID: Ip3BHAPIVHPLnSjnfKQaATwo5WazopdD
X-Proofpoint-ORIG-GUID: Ip3BHAPIVHPLnSjnfKQaATwo5WazopdD

On 27/04/2024 01:24, Andrii Nakryiko wrote:
> On Fri, Apr 26, 2024 at 3:56 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Wed, Apr 24, 2024 at 8:48 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> Split BPF Type Format (BTF) provides huge advantages in that kernel
>>> modules only have to provide type information for types that they do not
>>> share with the core kernel; for core kernel types, split BTF refers to
>>> core kernel BTF type ids.  So for a STRUCT sk_buff, a module that
>>> uses that structure (or a pointer to it) simply needs to refer to the
>>> core kernel type id, saving the need to define the structure and its many
>>> dependents.  This cuts down on duplication and makes BTF as compact
>>> as possible.
>>>
>>> However, there is a downside.  This scheme requires the references from
>>> split BTF to base BTF to be valid not just at encoding time, but at use
>>> time (when the module is loaded).  Even a small change in kernel types
>>> can perturb the type ids in core kernel BTF, and due to pahole's
>>> parallel processing of compilation units, even an unchanged kernel can
>>> have different type ids if BTF is re-generated.  So we have a robustness
>>> problem for split BTF for cases where a module is not always compiled at
>>> the same time as the kernel.  This problem is particularly acute for
>>> distros which generally want module builders to be able to compile a
>>> module for the lifetime of a Linux stable-based release, and have it
>>> continue to be valid over the lifetime of that release, even as changes
>>> in data structures (and hence BTF types) accrue.  Today it's not
>>> possible to generate BTF for modules that works beyond the initial
>>> kernel it is compiled against - kernel bugfixes etc invalidate the split
>>> BTF references to vmlinux BTF, and BTF is no longer usable for the
>>> module.
>>>
>>> The goal of this series is to provide options to provide additional
>>> context for cases like this.  That context comes in the form of
>>> distilled base BTF; it stands in for the base BTF, and contains
>>> information about the types referenced from split BTF, but not their
>>> full descriptions.  The modified split BTF will refer to type ids in
>>> this .BTF.base section, and when the kernel loads such modules it
>>> will use that base BTF to map references from split BTF to the
>>> current vmlinux BTF - a process of relocating split BTF with the
>>> currently-running kernel's vmlinux base BTF.
>>>
>>> A module builder - using this series along with the pahole changes -
>>> can then build a module with distilled base BTF via an out-of-tree
>>> module build, i.e.
>>>
>>> make -C . M=path/2/module
>>>
>>> The module will have a .BTF section (the split BTF) and a
>>> .BTF.base section.  The latter is small in size - distilled base
>>> BTF does not need full struct/union/enum information for named
>>> types for example.  For 2667 modules built with distilled base BTF,
>>> the average size observed was 1556 bytes (stddev 1563).
>>>
>>> Note that for the in-tree modules, this approach is not needed as
>>> split and base BTF in the case of in-tree modules are always built
>>> and re-built together.
>>>
>>> The series first focuses on generating split BTF with distilled base
>>> BTF, and provides btf__parse_opts() which allows specification
>>> of the section name from which to read BTF data, since we now have
>>> both .BTF and .BTF.base sections that can contain such data.
>>>
>>> Then we add support to resolve_btfids for generating the .BTF.ids
>>> section with reference to the .BTF.base section - this ensures the
>>> .BTF.ids match those used in the split/base BTF.
>>>
>>> Finally the series provides the mechanism for relocating split BTF with
>>> a new base; the distilled base BTF is used to map the references to base
>>> BTF in the split BTF to the new base.  For the kernel, this relocation
>>> process happens at module load time, and we relocate split BTF
>>> references to point at types in the current vmlinux BTF.  As part of
>>> this, .BTF.ids references need to be mapped also.
>>>
>>> So concretely, what happens is
>>>
>>> - we generate split BTF in the .BTF section of a module that refers to
>>>   types in the .BTF.base section as base types; these are not full
>>>   type descriptions but provide information about the base type.  So
>>>   a STRUCT sk_buff would be represented as a FWD struct sk_buff in
>>>   distilled base BTF for example.
>>> - when the module is loaded, the split BTF is relocated with vmlinux
>>>   BTF; in the case of the FWD struct sk_buff, we find the STRUCT sk_buff
>>>   in vmlinux BTF and map all split BTF references to the distilled base
>>>   FWD sk_buff, replacing them with references to the vmlinux BTF
>>>   STRUCT sk_buff.
>>>
>>> Support is also added to bpftool to be able to display split BTF
>>> relative to its .BTF.base section, and also to display the relocated
>>> form via the "-R path_to_base_btf".
>>>
>>> A previous approach to this problem [1] utilized standalone BTF for such
>>> cases - where the BTF is not defined relative to base BTF so there is no
>>> relocation required.  The problem with that approach is that from
>>> the verifier perspective, some types are special, and having a custom
>>> representation of a core kernel type that did not necessarily match the
>>> current representation is not tenable.  So the approach taken here was
>>> to preserve the split BTF model while minimizing the representation of
>>> the context needed to relocate split and current vmlinux BTF.
>>>
>>> To generate distilled .BTF.base sections the associated dwarves
>>> patch (to be applied on the "next" branch there) is needed.
>>> Without it, things will still work but bpf_testmod will not be built
>>> with a .BTF.base section.
>>>
>>> Changes since RFC [2]:
>>>
>>> - updated terminology; we replace clunky "base reference" BTF with
>>>   distilling base BTF into a .BTF.base section. Similarly BTF
>>>   reconcilation becomes BTF relocation (Andrii, most patches)
>>> - add distilled base BTF by default for out-of-tree modules
>>>   (Alexei, patch 8)
>>> - distill algorithm updated to record size of embedded struct/union
>>>   by recording it as a 0-vlen STRUCT/UNION with size preserved
>>>   (Andrii, patch 2)
>>> - verify size match on relocation for such STRUCT/UNIONs (Andrii,
>>>   patch 9)
>>> - with embedded STRUCT/UNION recording size, we can have bpftool
>>>   dump a header representation using .BTF.base + .BTF sections
>>>   rather than special-casing and refusing to use "format c" for
>>>   that case (patch 5)
>>> - match enum with enum64 and vice versa (Andrii, patch 9)
>>> - ensure that resolve_btfids works with BTF without .BTF.base
>>>   section (patch 7)
>>> - update tests to cover embedded types, arrays and function
>>>   prototypes (patches 3, 12)
>>>
>>> One change not made yet is adding anonymous struct/unions that the split
>>> BTF references in base BTF to the module instead of adding them to the
>>> .BTF.base section.  That would involve having to maintain two pipes for
>>> writing BTF, one for the .BTF.base and one for the split BTF.  It would
>>> be possible, but there are I think some edge cases that might make it
>>> tricky.  For example consider a split BTF reference to a base BTF
>>> ARRAY which in turn referenced an anonymous STRUCT as type.  In such a
>>> case, it wouldn't make sense to have the array in the .BTF.base section
>>> while having the STRUCT in the module.  The general concern is that once
>>
>> Hm.. not really? ARRAY is a reference type (and anonymous at that), so
>> it would have to stay in module's BTF, no? I'll go read the patch
>> series again, but let me know if I'm missing something.
>>

The way things currently work, we preserve all relationships prior to
distilling base BTF. That is, if a type was in split BTF prior to
calling btf__distill_base(), it will stay in split BTF afterwards. Ditto
for base types. This is true for reference types as well as named types.
So in the case of the above array for example, prior to distilling types
it is in base BTF. If it in turn then referred to a base anonymous
struct, both would be in the base and thus the distilled base BTF. In
the above case, I was suggesting the array itself was referred to from
split BTF, but not in split BTF, sorry if that wasn't clearer.

So the problem comes if we moved the anon struct to the module; then we
also need to move types that depend on it there. This means we'd need to
make the move recursive. That seems doable; the only question is around
the logistics and the effects of doing so. At one extreme we might end
up with something that resembles standalone BTF (many/most types in the
split BTF). That seems unlikely in most cases. I examined one module's
BTF base for example, and the only anon structs arose from typedef
references possible_net_t, sockptr_t, rwlock_t and atomic_t. These in
turn were only referenced once elsewhere in distilled base BTF; a
sockptr was in a FUNC_PROTO, but aside from that the typedefs were not
otherwise referenced in distilled base BTF, they were referenced in
split BTF as embeeded struct field types.

So moving all of this to the split BTF seems possible; what I think we
probably need to think on a bit is how to handle relocation.  Is there a
need to relocate these module types too, or can we live with having
duplicate atomic_t/sockptr_t typedefs in the module? Currently
relocation is simplified by the fact that we only need to relocate the
types prior to the module's start id. All we need to do is rewrite type
references in split BTF to base ids. If we were relocating split types
too we'd need to remove them from split BTF.

>>> we move a type to the module we would need to also ensure any base types
>>> that refer to it move there too.  For now it is I think simpler to
>>> retain the existing split/base type classifications.
>>
>> We would have to finalize this part before landing, as it has big
>> implications on the relocation process.
> 
> Ran out of time, sorry, will continue on Monday. But please consider,
> meanwhile, what I mentioned about only having named
> structs/unions/enums in distilled base BTF.
>

Sure, I'll dig into it further. FWIW I agree with the goal of moving
anonymous structs/unions if it's doable. I can't see any blocking issues
thus far.

>>
>>
>>>
>>> [1] https://lore.kernel.org/bpf/20231112124834.388735-14-alan.maguire@oracle.com/
>>> [2] https://lore.kernel.org/bpf/20240322102455.98558-1-alan.maguire@oracle.com/
>>>
>>>
>>>
>>> Alan Maguire (13):
>>>   libbpf: add support to btf__add_fwd() for ENUM64
>>>   libbpf: add btf__distill_base() creating split BTF with distilled base
>>>     BTF
>>>   selftests/bpf: test distilled base, split BTF generation
>>>   libbpf: add btf__parse_opts() API for flexible BTF parsing
>>>   bpftool: support displaying raw split BTF using base BTF section as
>>>     base
>>>   kbuild,bpf: switch to using --btf_features for pahole v1.26 and later
>>>   resolve_btfids: use .BTF.base ELF section as base BTF if -B option is
>>>     used
>>>   kbuild, bpf: add module-specific pahole/resolve_btfids flags for
>>>     distilled base BTF
>>>   libbpf: split BTF relocation
>>>   module, bpf: store BTF base pointer in struct module
>>>   libbpf,bpf: share BTF relocate-related code with kernel
>>>   selftests/bpf: extend distilled BTF tests to cover BTF relocation
>>>   bpftool: support displaying relocated-with-base split BTF
>>>
>>>  include/linux/btf.h                           |  32 +
>>>  include/linux/module.h                        |   2 +
>>>  kernel/bpf/Makefile                           |   8 +
>>>  kernel/bpf/btf.c                              | 227 +++++--
>>>  kernel/module/main.c                          |   5 +-
>>>  scripts/Makefile.btf                          |  12 +-
>>>  scripts/Makefile.modfinal                     |   4 +-
>>>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  15 +-
>>>  tools/bpf/bpftool/bash-completion/bpftool     |   7 +-
>>>  tools/bpf/bpftool/btf.c                       |  20 +-
>>>  tools/bpf/bpftool/main.c                      |  14 +-
>>>  tools/bpf/bpftool/main.h                      |   2 +
>>>  tools/bpf/resolve_btfids/main.c               |  22 +-
>>>  tools/lib/bpf/Build                           |   2 +-
>>>  tools/lib/bpf/btf.c                           | 561 +++++++++++-----
>>>  tools/lib/bpf/btf.h                           |  61 ++
>>>  tools/lib/bpf/btf_common.c                    | 146 ++++
>>>  tools/lib/bpf/btf_relocate.c                  | 630 ++++++++++++++++++
>>>  tools/lib/bpf/libbpf.map                      |   3 +
>>>  tools/lib/bpf/libbpf_internal.h               |   2 +
>>>  .../selftests/bpf/prog_tests/btf_distill.c    | 298 +++++++++
>>>  21 files changed, 1864 insertions(+), 209 deletions(-)
>>>  create mode 100644 tools/lib/bpf/btf_common.c
>>>  create mode 100644 tools/lib/bpf/btf_relocate.c
>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distill.c
>>>
>>> --
>>> 2.31.1
>>>
> 

