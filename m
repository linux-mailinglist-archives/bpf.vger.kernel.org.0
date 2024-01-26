Return-Path: <bpf+bounces-20380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD3483D7DC
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 11:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D74F1F2AD8A
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826672031E;
	Fri, 26 Jan 2024 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hQcWv5ie";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TQVCm6FG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9B1B599
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263029; cv=fail; b=joVWUFHiP4NSMeT7gwtul9KI4uuDw8ZgPu7+04tHmFxR1S86vWoJNb1DViv7PKmVwdvi48lWyxUhKMQtmnIOfS4gL3NnUl/GAtjNg+nDQ4EdVfFJzRKdy0R1fqDOsC3wuVftRvYQTi4grDXMhwKljuv9B3t4YfMle81SSlNf054=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263029; c=relaxed/simple;
	bh=s3J7Pq1AC5OmwsINspohiGlpzT6dEzvq6fOTQxAgJT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=HK19VvmDEZBurIv6xxG5+h0NNIRy0P87hE1AlCLa2UFXZBgHf6WdI1fc+S4GC8FrthQJqYFNgVAV+baiTbTxleUtABH3IoOBGFL+SjPd/35Ln74DbRksCdu2+qK/JofgFpzeUxLHtD0w673KisH+ZuqX4P8x7ph/DU5pzzfdJLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hQcWv5ie; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TQVCm6FG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PNhQdH004951;
	Fri, 26 Jan 2024 09:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/tKoBsGRBqc9sPjO0qN0GpQVqPEz9kJCLm/J+fSdGK4=;
 b=hQcWv5ieofJBPIXd3jLmaxbS9WzsP3JEdH0FoO/rOPJTwiY7n91C+Svf7MZsHCEqVIXv
 dZldRWmmIK7FT+UUq5MhNSYYvIXfDZwAIbliRNmBLUijsGcI7gEt09D+wvCwbJAQLZ0u
 kOueOzC2HSuSWlY8ynlyPIxA9OX0xC6d98pNoyYVOtyAYiM67GD7XwKvc2jSJ4Y3rZ3m
 5tezdSlWuB6MAKeYJdK6c88ZJwpCLEEMny68ZiSpgK761QtcetKHYqBxpOBP9yCPTm01
 VlmdrTNXwX1r2IGm9A8pmFE8PMdiZwZu4nu83NqMkh/z2FdxyL5IP/GVzACnB0jIz6iU AA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy95nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 09:57:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40Q8rtFo030681;
	Fri, 26 Jan 2024 09:56:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3766e67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 09:56:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJPZ56SBZ0OJChGQSlS45+cd9m+P4/Vul0bR19V+M/WM+GHRtsNh26S2vaVv2ajlB4bKC28EsIfz5xl5GCti8z7CClOfDGAxVmV6aKVRsDohN+4n61Lft5sOpmbueCy+d1fbR0lWPe0hM7sqbvk++pM3OergW6ie25+3jYHab/GrJM23es625EDkF06UcEpFyoO2KsB800ZPNl9JedLbcbY6vs9jj2G8385aqf9PTKprXoUn6aaOdnEGdOmERFi3ILxDgsXpDyk5xTF2fTNBzS7Pf8AOLEDI3aYg3kpbeTKTZdCC/2uAjtHNqtR3a93+OROes7uEQE5l6zCbtTYL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tKoBsGRBqc9sPjO0qN0GpQVqPEz9kJCLm/J+fSdGK4=;
 b=JGgdzmMKmgsVB2ehFWui0cpgBG+vstgTGzUxMPf4AKT/4lWaEcoRGEmDRvrxMsZDtdHxggkUk2Iz9zHDo+Tfk0JyT/ftLQEF/Fm1AHcbarmTF0FrvVUhRRwV7+GcFk28kr0iKO2HXh1RZuiNNxb5iRIJqzjNatn1/83HUBqPZJsolEhYobBRCif1p3lz5YsB4gmH/17tt8v/rQHovlk5z+B0/YNHh/dn9zpj/4lyiL9smQyI/N+TRlLNw1JyPkrBCj+oAnHSy512BG/86z2EhDwxaxcolZ8jkZUrdxpyl3qIzHYcyY4zr3YcFvwIhZJKq7K2ap8rd4EhsUYmZwKbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tKoBsGRBqc9sPjO0qN0GpQVqPEz9kJCLm/J+fSdGK4=;
 b=TQVCm6FGQPVOvwvzp1cYvj7dIqmQLItLhVYLTprDlFXI2Qfisi1XDYvpLc4GPaHPJNEE2dbhr9aU/XNFYUoHHxXQst+tN/n6lq5fuhayLoR1jH45PpPQEtwpTbKINWS+Nwf09g/h6lpHUvvwVm+RTrhVj6ucI6ga6Bn6hoJAawo=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by MN0PR10MB5936.namprd10.prod.outlook.com (2603:10b6:208:3cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 09:56:57 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 09:56:56 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong
 Song <yhs@meta.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Andrii Nakryiko <andriin@fb.com>
Subject: Re: Anonymous struct types in parameter lists in BPF selftests
In-Reply-To: <CAEf4BzYwPb55URks8P6wTJGvqYT=6gdh2RLU+=ri2rfABeDVaQ@mail.gmail.com>
	(Andrii Nakryiko's message of "Thu, 25 Jan 2024 13:56:35 -0800")
References: <875xzhzm2o.fsf@oracle.com>
	<CAEf4BzYwPb55URks8P6wTJGvqYT=6gdh2RLU+=ri2rfABeDVaQ@mail.gmail.com>
Date: Fri, 26 Jan 2024 10:56:53 +0100
Message-ID: <87frykwh7e.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0566.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::16) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|MN0PR10MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b36bae-d610-4d25-c055-08dc1e5521b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	89jnnbRGg7iKKP8nn1x7mRsp6QeOG9EmNO7huBkD3pSbyVNC6MBOSTDa1lThfX6xWB3f2U9OK7M1Bq8QjLZaBxH146Xi2ZWpdaxazfVEpP/B/5tCNA7z5Jol1sCR8V7dg11+SNuGPte+JFnvKIJTt8WLzemI0urS9hvc1mLrNXQhmOxs1Wt0hHv6iqRHkbf/Oemm+IqlFMIDRKfMBVBHyKuKWBLridusj/GwHxtLSvRVu54p39FpT03N15mHrreUFfzzGBpX6JFpAvV4CgphO+/KJ0hXADVBGFFnv4FRjyJ6+zNqVSFwa6W3JRmin/ymzs8/T5xQxoYSNFUZh2n2vxHLsSOBhsrNIXn87PElnsrVsdVfzoCmFic6TxAOKx5JF3nbugelB9yvgQrkmBS0wfxK85doxYDJTwOK0kZpxwYEVW0PianLj+EK/G5cBhny+oSFyBz6t8A7C58iFd9iKpO0E5KT6O2r7cZS7hPy/mOX7RvWo1jmIigYMuYN2wr428caHU5uIGKttSt/YBolSMumPbVkF8JlQ2vql6tLWbODBOrrRBPo4BZtfQEckxiwTewGZxsnCLvmjyTe6AFUCrgqFO+F6G2gwmPZaFecQc4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(39860400002)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(2616005)(26005)(6512007)(6506007)(53546011)(83380400001)(8676002)(4326008)(8936002)(966005)(6486002)(6666004)(66476007)(316002)(66946007)(54906003)(66556008)(478600001)(86362001)(6916009)(38100700002)(5660300002)(41300700001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SzFzeFN3SEdUV1ZXS2plNWZsWGVQTGVUMGlsN1lDYWJRWnBJTEd2WUNVQWFM?=
 =?utf-8?B?RmtJQ04yazhzTW1aTmlaak9zNUFMZFE1SUVaNXpIM25Ua1RCZmdlOHRVdWJt?=
 =?utf-8?B?cjgxVXRPQk1kclVQeWxsSkloamJIdUR5UmFkbFRWaVR1aHRZLzFkd2xLdWxy?=
 =?utf-8?B?U1d2RHhqYm1ZODY5SWs1WVlrc25QSFZyRTN1REhJMG5YZ1NLMFJvRXNrb2xN?=
 =?utf-8?B?MHl1ZFUrb01tS1ZKZ1AvbXdRTzlpZElUbFJtRlIyWjREVWwycnRPVCtVa05z?=
 =?utf-8?B?R0Q0eEhwV2M2SCtqUHFKNTlQS01VRUs5Rlk2QW5USUJkajJDK2JYbC9tdmdG?=
 =?utf-8?B?N085YWQvSGlBTjlmdkx3cUZnOHp5K3hNMWxXVHhUdVVLNTZSYitoUXRBeU1p?=
 =?utf-8?B?bUM2MkhHa2NDcjJVdUxYUGdPcGpjV1BSbzRqbGUvdTkyeFVuTXA5eUZMaDI2?=
 =?utf-8?B?Zk9Cc1puak5BbnBUWFF0N0F5cmlWNHRSamgxb3o3RlBvN2FrbjRMU1FnbFRX?=
 =?utf-8?B?b3djUWZwOFF0ME9GNmprM0h2bTJPQkozSGp4MUJZMk4xa1hqMC9XUWJZVFQ1?=
 =?utf-8?B?NlVJRzR5eHUyU29XMXVXRldDRUtaTml3QjFHSm5pNE45OFUzSDhJOFJVWitM?=
 =?utf-8?B?S1d4TFlObGdZcC9yUFcybGpIT1RBdnBHK28vdEJvWWJBbFZIYXZxa3RneVZE?=
 =?utf-8?B?YW92clErc2VCU2I4dWcyMlZ5a3dTc2JIU0owWTZqUXJtSmt5MXplWmtlV0Zr?=
 =?utf-8?B?aXRJNU9iQjZBUEhQWnZqK3Zud3RvRDBMRDdPR1IvK1lRVC9CT0lzcGpkV2ZV?=
 =?utf-8?B?Nm5Gc2xLY0YxYTZQclpGMnF2SjcwSUJ2UlNKbS8xcW50bGtqNWlRb1RHYWgz?=
 =?utf-8?B?dzAxcm9wNlpGWmZLcnhVVEhLdWJRelpraHNtK1NQUjc4dTEvdUpGRnk4QXRw?=
 =?utf-8?B?alBka1pKZXRPQ3kvTW5oT1VtMDNQSjBHTWo2UURLbnBxaDVhYzZzS2Z5TERt?=
 =?utf-8?B?dHdVSEVFRUZKci9ZcFZyRHU2czZ2RTNOSFEwVHU4emE1TDcrOERtY0dxWXM4?=
 =?utf-8?B?RTdOYWJ2T09Bbi9IZll5U2VHQXNVeWdCNURRaGNPS1ZMbWpXbUdXaU5hWW1v?=
 =?utf-8?B?MVJFVkQrN3oreHQ0amZLT3NwMWlqK0hhN2JCWVozcHEzMkptYXkzYzJrVktt?=
 =?utf-8?B?SHNJS3lON09Id3lWU21PU2U2K3YyYjVMck1RV3Q0MzlHbjFtc3JYT1FGUytS?=
 =?utf-8?B?OW5NODRLVzVYdVNKMGNJUkVKZ0xQUGtRZUhTWmtPaCtEbEtob1Q4N0E1M1Rw?=
 =?utf-8?B?TldITmtkUzM5TVZuYm1tN2ZBRW9JQitGc2VDRlNsVjlWcG9tK25LVE1PK21Y?=
 =?utf-8?B?blBPakhJNHBldGk3TWRtMDJOTUIwMlJTNEtkWkM2bjJWdUVZZ2RqWHF6RWtw?=
 =?utf-8?B?NldYZEJITkl0bkRUeFdSWFBiQ0l6TmhzcGExYkZFbDVZN2ZnaVJWWHA1Ukhn?=
 =?utf-8?B?RkliL3ozcEtmTlFudmJIOU9QNnNheGZSdjA4emlMLzlJdTduOUJtUEcvQXVR?=
 =?utf-8?B?Z3RqdVNJNXJrSUlyMDlEOTZMWEZGT2V1cHJLNW5Dcy9oL0pCd3E1a2FXUUlk?=
 =?utf-8?B?RzdBVmJQRnlBODByTTk4Zmk0VHdXY05LMDM4MkZZMXJEZ212RW9idnAyMUwz?=
 =?utf-8?B?SGNRenNTbHlFT1FNR1lDKzMwRDkrSDV1Wm0vV2FSZ0s4QlFQdHdaMTRGR01w?=
 =?utf-8?B?TzhJU2FaQmRnVkFjNS9PRHRNb0QzYTlPQTRXVkM2c3dqcUFrNDhiUWZHYW1M?=
 =?utf-8?B?MmN5V2J1aE4xMFdkc3FXVmpVMDlpUUk5RGJBVzhERzc3Y1Jabmcwc3oydWx4?=
 =?utf-8?B?K09WT1oyVTlzRXBUWFg4YWtTSWdPOG5mQlo5dUd1MExGeUlWUXV5NVppSUdM?=
 =?utf-8?B?Zy9OUDM1NTJ3MXpmZ3pmMnl4VDZqT1pPV0UxYktsTGk3U3RhY010RERqYkkz?=
 =?utf-8?B?bTA5SWcyUHVmQUlhRXY2RnZZS0s0TkNDb2RuVnhrQ2duM3gzOGlFQlIzTVU2?=
 =?utf-8?B?UGNTeW9pcGF3SmVFSGJNZjdJamJyUGNzS3dYQUM1NXhBK2lwK29iVmk2ZUhW?=
 =?utf-8?B?WlJWV2x3RFNZWnZNV20yVHEzRU1CancxbG84d3haWTVWSElwR0hYYTBIUkZM?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mWSI2d6apgjAlxoNFFIKfOFV3MqrAB+qCTNM3tldM3HcHShfbKmOaZaEXYIu4rTlCFyK7BZIePufNpwRV+J6kFAs6P2+Fipjs+Aq+7sG6fhST6j0ILp91p3lT1BHYwYNvewnppYzyd9DLB6Bw2O5MBnfYGS5dQh20l5cOHtvt6/Qz0pMLEKz2ffk65KwvCiXlr+0cTJtp9NeFEMQ6JRDVJ7AcjXx+/4KnxutfSGUa57F2umQAdxpuvc63ndwAkd/z3oLglY6k8WHYlybiL/JPon7O3IHX0Euo0tDsxbNcwGqhJgXVow0ncxK0OIVWpmCSoL4d0kdZE60EGWHuSsuV3p/sStPP0+Jwx6qU3XIasZD4zmL0Ju+vcWFbRyD8M/gybxY+akvNI6yE+6AHNKv1LjFP4udAumcuDMJ5JYpMy/Pu1CaueAeCBtm1QOumUo+tFP9rkqtjRigB5vdFJRNCsVYoDPGW/y5zN7cVv2xErrAIMWAa/6eyMII+Kr8cBVuzAU/CyaZYWnUtOKfXGkk4ZGODf7Bmqc29w7+m/ZeP5Jt9GDYt4hJvsW8ZMCco8aogBSQZEhxaVPHbfqpBWSUxFg/KZmHY82hPIHKhy09E9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b36bae-d610-4d25-c055-08dc1e5521b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 09:56:56.8876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6suSC8W/D3+VxwIitb70gDfJ8imb/Qc45EYrv19skl9ylmsDw1BBYSuSbjZl+aJZPfcWhlzQDuCtQMyP9WWsxWHiHtB/ZQtou4hihE7wbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260072
X-Proofpoint-ORIG-GUID: WCBnDBeYZiVIRxh51cwWVO0av9sSIKZb
X-Proofpoint-GUID: WCBnDBeYZiVIRxh51cwWVO0av9sSIKZb


> On Thu, Jan 25, 2024 at 3:31=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> Hello.
>>
>> In C functions whose declarations/definitions use struct types or enum
>> types (or pointers to them) in the parameter list, the scope of such
>> defined types is limited to the parameter list, which makes the
>> functions basically un-callable with type-correct arguments.
>>
>> Therefore GCC has always emitted a warning when it finds such function
>> declarations, be them named:
>>
>>   int f ( struct root { int i; } *arg)
>>   {
>>     return arg->i;
>>   }
>>
>>   foo.c:1:9: warning: 'struct root' declared inside parameter list
>>              will not be visible outside of this definition or declarati=
on
>>     1 |   int f(struct root { int i; } *_)
>>       |         ^~~~~~~~~~~
>>
>> or anonymous:
>>
>>   int f ( struct { int i; } *arg)
>>   {
>>     return arg->i;
>>   }
>>
>>   foo.c:1:9: warning: anonymous struct declared inside parameter list
>>              will not be visible outside of this definition or declarati=
on
>>     1 |   int f ( struct { int i; } *arg)
>>       |           ^~~~~~
>>
>> This warning cannot be disabled.
>>
>> Clang, on the other side, emits the warning by default when the type is
>> no anonymous (this warning can be disabled with -Wno-visibility):
>>
>>   int f ( struct root { int i; } *arg)
>>   {
>>     return arg->i;
>>   }
>>
>>   foo.c:1:18: warning: declaration of 'struct root' will not be visible
>>               outside of this function [-Wvisibility]
>>     int f ( struct root { int i; } *arg)
>>
>> But it doesn't emit any warning if the type is anonymous, which is
>> puzzling to some (see
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D108189).
>>
>> Now, there are a few BPF selftests that contain function declarations
>> that get arguments of anonymous struct types defined inline:
>>
>>   btf_dump_test_case_bitfields.c
>>   btf_dump_test_case_namespacing.c
>>   btf_dump_test_case_packing.c
>>   btf_dump_test_case_padding.c
>>   btf_dump_test_case_syntax.c
>>
>> The first four tests can easily be changed to no longer use anonymous
>> definitions of struct types in the formal arguments, since their purpose
>> (as far as I can see) is to test quirks related to struct fields and
>> other unrelated issue.  This makes them buildable with GCC with -Werror.
>> See diff below.
>>
>> However, btf_dump_test_case_syntax.c explicitly tests the dumping of a C
>> function like the above:
>>
>>  * - `fn_ptr2_t`: function, taking anonymous struct as a first arg and p=
ointer
>>  *   to a function, that takes int and returns int, as a second arg; ret=
urning
>>  *   a pointer to a const pointer to a char. Equivalent to:
>>  *      typedef struct { int a; } s_t;
>>  *      typedef int (*fn_t)(int);
>>  *      typedef char * const * (*fn_ptr2_t)(s_t, fn_t);
>>
>> the function being:
>>
>>   typedef char * const * (*fn_ptr2_t)(struct {
>>         int a;
>>   }, int (*)(int));
>>
>> which is not really equivalent to the above because one is an anonymous
>> struct type, the other is named, and also the scope issue described
>> above.
>
> "Equivalent" in the conceptual sense to explain arcane C syntax.
>
>>
>> That makes me wonder, since this is testing the C generation from BTF,
>> what motivated this particular test?  Is there some particular code in
>> the kernel (or anywhere else) that uses anonymous struct types defined
>> in parameter lists?  If so, how are these functions used?
>
> I don't remember, but I'm not sure I'd be able to come up with such
> monstrosity by myself (but who knows...) I used vmlinux BTF and kept
> fixing and improving BTF dumper until I could dump everything in
> vmlinux BTF and make it compile without warnings (that's my
> recollection). So I suspect there is something in kernel that uses
> similar kind of declarations.

Yeah that's what I thought.  Such construction may become to happen in
headers because of some (perhaps unintended and unused) corner case of
application of macros, or who knows.  I wouldn't be comfortable removing
the test case.

>>
>> I understand the code above is legal C code, even if questionable in
>> practice, so perhaps the right thing to do is to build these selftests
>> with -Wno-error, because the warnings are actually expected?
>
> Is it possible to have #pragma equivalent of -Wno-error? That probably
> would be best. But yeah, we can just add -Wno-error to
> btf_dump_test_case_syntax.c in Makefile, if it's just one file.

Yes I will try with the pragma.

>>
>> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfie=
lds.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
>> index e01690618e1e..7ee9f6fcb8d9 100644
>> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
>> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
>> @@ -82,11 +82,12 @@ struct bitfield_flushed {
>>         long b: 16;
>>  };
>>
>> -int f(struct {
>> +struct root {
>>         struct bitfields_only_mixed_types _1;
>>         struct bitfield_mixed_with_others _2;
>>         struct bitfield_flushed _3;
>> -} *_)
>> +};
>> +int f(struct root *_)
>>  {
>>         return 0;
>>  }
>
> Changes like this are fine, if they don't change the order of type
> outputs (i.e., if tests still succeed with these changes, I have no
> objections).

Ok, I will prepare a patch for all this.
Thank you!

>> diff --git
>> a/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
>> b/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
>> index 92a4ad428710..0472183ed56d 100644
>
> [...]

