Return-Path: <bpf+bounces-28384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF88B8EF9
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01821F21E57
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2504518C22;
	Wed,  1 May 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ne45MKzU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hGXDzLNN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7618638
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584222; cv=fail; b=UMJHxdd7xekJ2nj5SEodjot4MV9VsqwuNpRUXinDXLbY2/qV5uyN4+lAxb9jVCRVKP5x9IEVdV7yXcW+3khkdF8XZ4vY6F7TOOEy7w/2KE+5qJFYXtlvnPw7SCWjIkMvHWeXFyk4ID4RXSVxc5p125tKAX7U7dkIv5+9pI6rlyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584222; c=relaxed/simple;
	bh=g9PKkzuHCLn+tqiGeADcMRmh0g7Lp+N/6SLogwhkWAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y67DGJL88bKedJtAOyA5uZcC5F1p312nPzfA9YXdrGQwo5BBfPGxCcEzO2qDjmd4lHg45ZRPavBgnvxCN+hv+ocYILbaxkpGfPfne1o7hHrQbzkFc8+xoHHH9Uo20N5P1k4ZPpvFmrqLYcSnzmh5dYhL5cJPPLb07ZU9SNlv2bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ne45MKzU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hGXDzLNN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441ARwxQ006021;
	Wed, 1 May 2024 17:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bspse2pJATMGAVG/8Y34mOU5JUKuq0qdThnT4iS1uFQ=;
 b=ne45MKzUT2yVVJxNx7+0+oW+MS8lu6e6j97aULiFWeDnSU+BtOs+NLAc6RQuoMmnChra
 QMLqTk25EDJuS44iBd4LTqOJXpljr05SW1u7sx4e4F+9YrpIWBhkfn6xkcxEnW2UZEMk
 Nd2goq2fRdsGPn0ZoOorI78MucUz+P0RlT60koiVzghauYT0zE2XBTPsbkK+k3Nu9THj
 GFtveuUac/mdV04VTSzwDpp+oM5VOYkKu4/I+IK/BM+pZ1AlOB19Zn5OojB2UCqbduPi
 CgmwwAZv0frm53PntSd4X6SBjkhe9yGDK9MqfPRgnajkwfiq6Qec0RgwOkMhFmkaIJyK HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdeqn6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 17:23:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441Go9iR033172;
	Wed, 1 May 2024 17:23:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt9bamf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 17:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Byczkdh2Nru0eH7DF+OKeqBloqEhbkHeltkRBbeeuBUoBFZDdKbjNGjhhrc+iQrSv10KCFn2kKAn2jnT9aHOu5oK5QgqNwZyXKb2ojd8RhMBxW4tMjf+cbbGGwLHyAgkhqVZ5aRI7DUFQXrSeSfpK3Wo8vLrjl9NiUNjZ4Co3JtCZWwytqBfxYDjzvsjUcRMZRqGasfheZav6h720E7+nGlSHmtvk1TsKGL74BHJNmc2R3G6Tdtvids8fqD+D8VCGjJfvdx2kdA/lYFEHs91onudP4KGTJ1c+OO1hw2OCGVONc3FrG9Wl2t8R03s14sBCeh67h29ojAbO/FaqDfVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bspse2pJATMGAVG/8Y34mOU5JUKuq0qdThnT4iS1uFQ=;
 b=iQgAFNbo84M0kVvbNbrEZ4Gbj7zy5X8b1logjThlAwssoruIz70/YbfW2CKGHI4BQls/HI4/qeKkiTsCjhTFz7Cd93ZdFPH0eEUQUjxy0VQja+d0VTRWqD3sWmThCtjTGwTjFtpBlcxwZrKesIyrtY2gkFECMOAnA7CndrbyfXGA9Pxe5irRUyHkGJzLUFVOjEtnYXnVz02pMKA9e9p6yDeJhWLrqk2Zzu9yQMa95zO9aIIW78mfDXKa7Mmtt/+AapPRtMGA6Zw6P2mmgeEbmB8zGdUz4yyjga5JoH+ZclC/TU0O2t+Bt/Cf/Mblkx74+s+Ne0zKrqpIhZjWKO+eaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bspse2pJATMGAVG/8Y34mOU5JUKuq0qdThnT4iS1uFQ=;
 b=hGXDzLNNwiMlk4Stid8PoiYvTM9+Z7Vlqxfge9Yy4k18mry4xkeIyKsjDBfC+JHxqe3ZmKXtoV+1N+WXI1xKs9oYfdDQ3a6fudHatUUszLeNOano/Vj/akNafvFLABo90i3puIc8vnvJUI3eNgYnLlibt0jVLpSjq2zsboUcDbA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH0PR10MB5065.namprd10.prod.outlook.com (2603:10b6:610:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Wed, 1 May
 2024 17:23:10 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 17:23:06 +0000
Message-ID: <0be25f61-e1ec-45be-9696-f711264b103e@oracle.com>
Date: Wed, 1 May 2024 18:22:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 06/13] kbuild,bpf: switch to using
 --btf_features for pahole v1.26 and later
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <20240424154806.3417662-7-alan.maguire@oracle.com>
 <CAEf4BzY_-nJe2VkCjw7AkOr_g3njZAy_rcBVO+UP_wgioNw3Hw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzY_-nJe2VkCjw7AkOr_g3njZAy_rcBVO+UP_wgioNw3Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0594.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH0PR10MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: f8976568-a4f2-49cc-2df7-08dc6a035d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SjljdW13WnpYOTV0K0ljRFpjK0JLckk3TlNsSy81UERUajdoQkhEL0dNNFRE?=
 =?utf-8?B?K1orZ3hRdHNFeng1VWFPMmRuMHFQOTJVcUY5U1dBQm5jOGZLTG1BMS91NDlP?=
 =?utf-8?B?WVdhYmdaSjZ3UlFPdUlPMzNlL0tQdmdzSEgwS0xTZmVVcHpFK0NQNHNlY0J2?=
 =?utf-8?B?VVdmQjdGaC96aXZmZjN2Y0lWd1I1K2l3WkdFY0syWk9RUGVLRDRra1FkWGpS?=
 =?utf-8?B?Qi80WlFIQU1MMzNSWGY3MDR6UWJrRWhxd0NrcWJqWjZzM0xsNVlNNW5HZ29u?=
 =?utf-8?B?YXU5ZVlYcUg4OEhUU0tERVhSVFhsZmp3ekJFcnhsRTNucHgvUk1wcXVubHBT?=
 =?utf-8?B?dE8vRFJkbTJtc1UxMXNHcS9OY09GK2g3ZTlDWVlJeXcrRDFGbkRVUS85bzlQ?=
 =?utf-8?B?eDd1VmZGSXlKN0ZmMDlVM2dYNmFqV2gzS1dtVGtFWGp4ck13UVE1SHVYRXlT?=
 =?utf-8?B?QUJxUzRSUHpYdVhTZSt0emxaQ3laRzRSY0lWTnpxcyswR3dFbVNVd3RHcVZo?=
 =?utf-8?B?M21MWXNTakpFd3FGOURTeitPb0xDMFc3VjNEY3QzUmxGYlRNTmFocGZ4RGFa?=
 =?utf-8?B?NDFrZlM3SmN6Y1ZNTWlINmlpbEFIWWMvV2M5UFJZLzZUazUyeUY2VGVoSm5J?=
 =?utf-8?B?RFdiS0UwSThyTmNZWVU0YUtXekUrdmhQL0dmK0g1dENORWNoU3RoWWFCdVFk?=
 =?utf-8?B?cVZmN0NKZnJlYnI5SmgzcWJVNzhRdWdwenkvRkdJcVA0VWdsenRSOVZtbHps?=
 =?utf-8?B?NzA4dWpCTnlBYzF4WDR0U0plU0haYVA4MUIxVFFLUzJBQkh5V2RKTm5XUC94?=
 =?utf-8?B?UHRVUktXT1FOaW9GV2E1ZEEyNVJKdkxEREJ2OWE1NG5WWHNIOHdtdStMVTJ0?=
 =?utf-8?B?WStMT3NMekdkbnVhL3Z1QkxReS8wNFIzUjNwNW1wU25wZllTdDE1UnpMSWRT?=
 =?utf-8?B?Mms0elU3QVdZbU9iZVpiZ1JXcE1STEZHNEZxbi9Rd0xqamxhZkhibm4rb1A5?=
 =?utf-8?B?THJEUEpKUDdIcXBvWElhSURTSTc3dGZYTVk1SE9KWDhTa0F0Nmdic21SZDdK?=
 =?utf-8?B?a0RUb00zcnVOS2tnOVNTVEN0QWt1OW1tSGZkOUdkdWdyMkN5bE1LRThnNnVh?=
 =?utf-8?B?RlBlU0hpYnU4aG95NFdHdWlFVjR3TkROeThDZGpKVDhPbE1pL01mbWZaWjhP?=
 =?utf-8?B?d2RreVlibXRmWXFZZWVsT241dGZVUENIS0R2WFl0bUUxd2FSdlJIWGluN3ll?=
 =?utf-8?B?S24yME9QcytSM3hpdmNBNnpsN3ZrZlR2YW1TUWtUcVJMWUp5b2FTY3RmVnNk?=
 =?utf-8?B?ZVlldVhDNzAvd1dsVTFCcDY5c2NXekhOR1l4NEcxeUdTREdPTklNL0IwRFd0?=
 =?utf-8?B?d0p5Y3ZVenYrQkdzckJ5RFZUUFBML3JhRXc3S3hpd3N4N1ZxTCtJbEl0cEpk?=
 =?utf-8?B?NWY1YWtPTjZaaUVKUzhHby81SjZvazlxTGhmN3dNSUJYUVZUN2cvQ214MThV?=
 =?utf-8?B?MGk5d01xcXdUaDJETVhSblZSZUhxNHF2U1UwdmtCbHQwU1o0c0NoMExDSGpq?=
 =?utf-8?B?d1Fzdmxsa3p1U2t4V2NZZ1Z3czkxeUp1TnZHZzNtVkMwamVSMnBaZE5SaUlF?=
 =?utf-8?B?U0U5MG85N0JPWTNKNEhpVEQ0bFI4eUkrblJ1eTd6OHB4emlzampuNEJ6cmcv?=
 =?utf-8?B?U0VBMTRYZmFBUi83dUo2WnU0MjBCOFRvZGE4RkpoVFVxSFd6WW9GRnJRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnVGUkp5OFU2MnZWeVRTOHMybi9OSVhTYWZTcDdacnNoVHU1YzIzTWJic2pY?=
 =?utf-8?B?UUFzUGZMeE1VVU9hWXBkbUF1bDlWSzRPais3YkRKN2tVYmtleFRCR0V2WHFY?=
 =?utf-8?B?NVdGRERYVGYraXNBanZLaHVNRmpweE0xc29ScGlTWE9uSDY0K3RycjB3QVNS?=
 =?utf-8?B?WFQ5QVg4a3RyWkdmVytYUnJocldZcjFXYVF2bk5yY3BMMm1OcHdQMzBaZW12?=
 =?utf-8?B?WDE1Nml5MnFoYVppeHNHZjV2VHYxVWhhYkFvRU51OU41R1JZRitFQmIvZE4x?=
 =?utf-8?B?UG04RkJjdFd6N3ZFOWdZS0UrZVd1RE1FWHF4b2UxWFZXMHhVdnFUek9SdkNZ?=
 =?utf-8?B?VnZFY1hpRlRmOUxSTituTmRySXlieURRVHZWVjVuaWFMaVNFSk1Cb3BZQjNZ?=
 =?utf-8?B?Z0Q1aE9ySDByR3VTK3d5c2ZuSy9KdGFzTWZrOU1ScGFPcGs5djVkRjhrZUQ4?=
 =?utf-8?B?cXduOTVCQ3pybGo3ZFlwemdCRnFHL1NDaXVYMkVpQXd5Mm9YRWNoYW1kN2Vp?=
 =?utf-8?B?VzQ3UHJhbmthNUx0a0FkQlVrRFByM01NcW55THg5M1liQlVjSUk2RGpiQjds?=
 =?utf-8?B?YXlUdkF3YlJLeTVyeFcyRVYrcVJPbnBSNVNRU1VDYmNIb2VvTllUMzVsREtJ?=
 =?utf-8?B?bFhJWkJjR0plT3RyakFEVFJRVE1RaW5UcDcxYndvcmdocjNGSFRqTTYzSzVG?=
 =?utf-8?B?OW5aVER6TzBDTGVyWU1ENVhuRDR6QkVEOURzcG1TU295WXV2VVRQR2phNXBL?=
 =?utf-8?B?NTdvWGlISDNqYksweTlZODFUcFc0V0dhNE42eFMvZ1ZKaDVEWHNxWDRVbjgv?=
 =?utf-8?B?TVcvaVVuNjhPK3lXMEErcGxQb0hJTW5UWVlMMDZsZGkzcXo3THFtN2tLQWtB?=
 =?utf-8?B?SVhYaGk0ZkFBcjdjbWRPKzRMZkhJS0ljUFJKeVZ1M0sxQVZZZ2FQUnhnS0dP?=
 =?utf-8?B?ZzU0RXlSYzlwRGZNUGJ6TkJqS3BJbldka1ZabnhiUldJM1hDL1JUT3F4cERp?=
 =?utf-8?B?QzdRZlBkSnRMQmZEdXptYUNDektsU1grSUNqMkFjTU5pekljU2xXdTdVY3VR?=
 =?utf-8?B?VjZXbDFUdUh2U1dpUkEwUUJOaWNyZFF2NGZsazhRTHhhK1Y0dzN3RkhNZzdj?=
 =?utf-8?B?K3RrNFFXaU84Q1VlcGwxMjdiK1c1WWtqQ1JiT2ZTVmN1dm1DUEVWR1BrYUNZ?=
 =?utf-8?B?cGxoazJrT3d0YnRsdlc2R0xJYWY1K3djMkczL3JhYThSN3dNc09QVmpWcHZJ?=
 =?utf-8?B?THZ2aHd5SDVtQjhRSElDKzIway9IeTY4UE1MbG5tYjNzYTR5MjVZdGFxN0Jt?=
 =?utf-8?B?Z200ZVVNTmlONXBORWhaVW5PMjEwaThXMkZEcDBQbTliMXZoUjk2cXVIenhp?=
 =?utf-8?B?SGwzUWhCQkFoZ1prNkNuSFZ5MG9ZdGxaOU0vaER4Y0xGeFBzUzBNL3doQXFt?=
 =?utf-8?B?eDhkdnMwcEUxUDRPbnZTUmVyaFRIT0crR0R5ZmxJT2ZhVDN5Q0dTQXgrVEt0?=
 =?utf-8?B?cVRMekYvSUtqbFpBVXJmMTJYQkhUbDBrYWFJNWxpSHBBQ2hibUNkSTJ6dWVX?=
 =?utf-8?B?NDlPNEFuVWRTam93ZUoxcWxTdGNVc3NZRTRWOTV6NGltZHdaRmhxTzRzbFNS?=
 =?utf-8?B?RHRiZ3FHeXdVbmFCNGNiaCsrbTNoaUwyTENjODBmcldpYUN5S0RPQ2NYcHRW?=
 =?utf-8?B?NW0wOFB1QmhDVFFCSXJSak9WcXozaFVORFUzMlNUMVZ6ZjVNak40VTVpMnFY?=
 =?utf-8?B?NFdKU0hrcVJkcGppWUdYRVBCZkZCUWNSVEFFTkFqRXVNVWdwOHFwcHppK2xI?=
 =?utf-8?B?dnhXSUdhOSsvVDJJdWR6ZUVjRUZyckRCSEp6MGl5NG8rR3Z5R3A5ak1NMlNY?=
 =?utf-8?B?YStTYjBSL1U1S1cwbW91ZEhDR0tJd2QzeDd6Y2ljSVZGUHllUUdJQ1hVbW8x?=
 =?utf-8?B?cURRZnZ4bHNCdzNlWi9nT3hGRitSZmJ6M0ZqZEZBMHBNM0VCNnJlTXY1dm9n?=
 =?utf-8?B?ckNTMy9ya2UwSzYzS0I4Q1ZwbUdrbGl4NHU3NVE3NExjSkY5QXc0NXhNVVhF?=
 =?utf-8?B?UmJ5ek5ZQnZ1SEl4amk1Yk56OG9YZUVqaGd1bTMxbU84Y1RGbGVndzl4L3VY?=
 =?utf-8?B?dzBVeVl4L21vUE01RmxMb1RialNtZjBtUVhDQmpzVXRLV1ErRHJ4WUVEeFNT?=
 =?utf-8?Q?ueYiPw2xO8F7C7g87L8LAN8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Q8+wp+RPsVEsagLa3dYThEct5buUrNRD0J5VEgCSS2+nnOxaw4Bs62yi5KNgI6TpUCgdo/9FqByRYuSX/lYqJsKlW+ZqSMyxlNVd4+pLW0d+p/lxFUzfUfkCQDPxYpteMldCev5/Z8YYhCCgEdbz1LSPv6X7Xt6xIpxRtCpmpHF7+wXcDNo3YevGDJlymF2ZR8TC+hLLXKur/qSB3Zjtvnxdgoqo9MNwLliLfzuy8cj4imZdz8yFqVp4nUzbioTIE/56ingQ/7szRhUYqRLl5dN3l1MvIkKkDbzQkJ4sUxmiCCOAUnzkZ/+yu8NjDZde7Z5oX2gEOof6JLsSydkZ/RfKqO1M+ImgOvovLTGY4ixoLjwe0x5k+QfkwIjf+6o1oMspeMJf8LqV3tEY10gPz1nLRYhEY9J+hSTyRV2XIF0K69omGwvOqU4qrwFC7LKovnfMaOTLmSaQO2QtJViR7VPLxjVO8tZj6I9qnmWC0P3nYskk/CUOdzWN+mvkKNLPDd97zEuEXNkRRuMkb8I1wotnmpW5ZoOFBgiJuMrrNH6u1ENj3dMg0IxWy1Wx44rvFtJ4nQEvQUSJFeOY8oS1zrRS3vm2/O6ZHkiPift1uU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8976568-a4f2-49cc-2df7-08dc6a035d42
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 17:23:06.5719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQa1mMROLgvc5JTMVltF6/VmOGTwQ3KDcK1rWHwWlJYHlxU9rwzfG9gVvTm7VaxQdBFvNkr0CEyJ3Y3Ep/6LzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405010121
X-Proofpoint-GUID: TfHOAT888OAf3BtNmwe6EmdSliRJCvZV
X-Proofpoint-ORIG-GUID: TfHOAT888OAf3BtNmwe6EmdSliRJCvZV

On 30/04/2024 00:43, Andrii Nakryiko wrote:
> On Wed, Apr 24, 2024 at 8:49 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> The btf_features list can be used for pahole v1.26 and later -
>> it is useful because if a feature is not yet implemented it will
>> not exit with a failure message.  This will allow us to add feature
>> requests to the pahole options without having to check pahole versions
>> in future; if the version of pahole supports the feature it will be
>> added.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  scripts/Makefile.btf | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
> 
> post this patch separately? we can land it sooner, right?
> 
>

sure, will do!

>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index 82377e470aed..8e6a9d4b492e 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -12,8 +12,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)     += --btf_gen_floats
>>
>>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       += -j
>>
>> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         += --lang_exclude=rust
>> -
>>  pahole-flags-$(call test-ge, $(pahole-ver), 125)       += --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
>>
>> +# Switch to using --btf_features for v1.26 and later.
>> +pahole-flags-$(call test-ge, $(pahole-ver), 126)       = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
>> +
>> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         += --lang_exclude=rust
>> +
>>  export PAHOLE_FLAGS := $(pahole-flags-y)
>> --
>> 2.31.1
>>

