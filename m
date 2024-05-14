Return-Path: <bpf+bounces-29709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853D18C59C7
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 18:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194CD1F219BE
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBDF5025E;
	Tue, 14 May 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DWEaGrvV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fVFdrcJ8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76812AF09
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704451; cv=fail; b=YDl1ca2h3aXwc/s/hM6e4IKcVeL35KLvB9aYCv/uT25HAr44+sY8qxcvctIZX2OmujxjnN8Ls0Q/CEzgmsyg1F3Yibi9gEbm6TY8dkKsWaZfrB6KoIDgjjOwipHvB/QeTMQxXLQw5tOWixymfSHE2CcxJeAJVx/flxuQfTYLsEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704451; c=relaxed/simple;
	bh=MJmVvah0yCHOoF0Wbuv6YOi0/9hVV8cAjyqNSYRQjFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WchRDPNlixFIGZCXgJQ13tbh+2Md+21MIa6lX9xd201HKGl5Re2Zz8NrD5fcPEXW6BgkoyXE01tqhJxiiqsPSoOlQuVyxuUTJANDQmn7VJA38VeZqHe2ujMFJYrbYwW2ZkUi/TrJ3WA3WgUpu7dZH+4O2gT2blfcTVXxhXA6P3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DWEaGrvV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fVFdrcJ8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44ECgKoO003216;
	Tue, 14 May 2024 16:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xvPDmrYqc2hI+UtcMzuShslmDUfE+2+sPuKRnir+lK8=;
 b=DWEaGrvVRDt3ABKROjS99+088UrAEdlZGfBoQXBlvM+FA7kBWiL4mpc0G3iQRBTSdS16
 4WPFdzKrg5KdNLLuS99B9JuXIWEt9+R2jQniVInXLeTJeWyQ8I2iEK7qzw8gG+OhLmc7
 MxTjX0nObGTG8rkT6uPdHv8nqJ3xkYaAU5TT1Lt5+6APT/XRpi9R/yCPMBYGjAJjpsVL
 yj2LDku8kY7GzBxZMZH+e3iG2im2/kELVt2mWqycRz8F4i5qkKsAFyejeI/azsab4qY2
 SEL/XZCNRG3lc4x30c4VVrxB8qdCJ8SCH1F0KQFgkHyFRJD+M0MOxEOyfA1wXW3wTMKG 5g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3txc1t1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 16:33:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44EG4qel019299;
	Tue, 14 May 2024 16:33:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r852by9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 16:33:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYxJ17V93taGuj7az/dZufCy/tMMluGxXRQhRhMCJoT6xjtWZ6eCggXlSAtvTLsgLloPRIkgxE0Mj7IPE1PPKEokBKVEXeN5Y5YuxnfUVdLy3Xwwp5sYyyCIah5BHfcRmH25cvMPBgBCU4E0HWwGyNJbaelj1AAiN7ksUiJ8VcgGD/hrWYB7cR2hb2I77gsXenkKLXFMB/FDLWd7FKv2zU1fsASaOO4ArtAYnB5otV8b4m9eCwY6NXuck27ZPjQSMZWGyM9Bn2E8NJBgJrZKAJDBTO4xLNLgXPT4alNuWntSsJMQCYhZI/YliaEyaHSMmBQiP4Lfetj/TyJkxJA8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvPDmrYqc2hI+UtcMzuShslmDUfE+2+sPuKRnir+lK8=;
 b=b1Rs+45DeO96o3XAkkhFdNLc33WeC2o7jUoIt8hWwXSj30V9MgUPtdMkX7DZYYRnpOczMRlwC6vJ9ILcV97+KtYI5c4A+z4iHnpkqX9PeRLoPvzbZdcopXUTtfmL3SVvfSXUFBp2eNEwUIM8kaX5VgGBPZknXDuHAAuBNmg8ReivL/yXBzKKBe8/IlZ9p2jAjfsYZsogMUyf0rzby7XYJ8F050iXGmT1IMdOu0k4gAEy0S9CDtvQQKLnGl3n//m2ZcKuZ2EZNPFdF5UuUrYeXAeiNTu+knGq6pMTExPNhg8vCV8BlbHIQmoM2tn4C/igz02Ns7cFcDv9aFfredQ++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvPDmrYqc2hI+UtcMzuShslmDUfE+2+sPuKRnir+lK8=;
 b=fVFdrcJ86Jv02wS7B7z5TP/Rnmep/oiLGBQUhkv6K6lTJHQ0yt/4RDiixwUGxcss3FmQAFpYWFVkqPqpx2LfchvakidOKlUCwLyzpwvZAONqYCZrEHZdN1rUE+1ZjX140ZkZZvXPOPNDrsBqHCLMuv41ik7fN1Pcc8VU4wHDRQk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB4818.namprd10.prod.outlook.com (2603:10b6:208:30e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 14 May
 2024 16:33:35 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 16:33:35 +0000
Message-ID: <707b32c1-57df-4718-8979-c941ac70eb5c@oracle.com>
Date: Tue, 14 May 2024 17:33:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 11/11] bpftool: support displaying
 relocated-with-base split BTF
To: Quentin Monnet <qmo@kernel.org>, andrii@kernel.org, jolsa@kernel.org,
        acme@redhat.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
References: <20240510103052.850012-1-alan.maguire@oracle.com>
 <20240510103052.850012-12-alan.maguire@oracle.com>
 <25c2e677-1191-448c-a42c-7268748bd7c1@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <25c2e677-1191-448c-a42c-7268748bd7c1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::33) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BLAPR10MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e68bb3a-054a-4692-04e5-08dc743399ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UktQZ0t4MGJSejYxZzdDY3JLcy9EWXdEWDdPY3V1dzM5L3MwZWhnY0taUlhh?=
 =?utf-8?B?dEJsTER1V1dHZStlUnYwZkdNck9US3JDS2taSjQ2V1lMc04wNnp3RnpMZFlI?=
 =?utf-8?B?MmVCbmFlQVl1Wk8ybEtVekNpTVBadU0wZjJyRWM5cXY1RnZtMzhHSmNNOWYv?=
 =?utf-8?B?ejZWM2V0d0VGSUhxS1JVYUJubHRkZDdOWWQzVTFUN091QTd6b2FqMldmeVlE?=
 =?utf-8?B?U1puc1U2TU5EcElTVkR3SHZuM25yQ0MwYlpidkFsSEhtUEx3Y1ZlY3I3MFF0?=
 =?utf-8?B?VTlzNEVwelQ3ZlY3N0dVOTJuWlFEWVdSVnYwU1crYm9tQThMdVRhSU5WNGpo?=
 =?utf-8?B?TU4vaEpERTVUd1lIQkFkVzA4VC9XL1VUOUVudnhJaGxQSEJaT1FJaGJJSnRC?=
 =?utf-8?B?Wm4xc2h5eEhLZ0V6WGw3Wk1xYm9TcTh5LzhKaFBad0dkZU42b3NvWkRid0pX?=
 =?utf-8?B?WjhZYkozaFZQdi9QQjB1TGdNTnUrMCtpQjVzM0tpREp2SysrUWNZUkdKVlk1?=
 =?utf-8?B?bXhrN2JBNWhxSmxwa0VaZlpYOUZuVFVnTVB6SEZPcG5NSndqZkxBekE3VHda?=
 =?utf-8?B?dk92eDRzNnZ0c0NuTEllWGltb1FnWk9PcFE2bDl1R2VPVEdLbms1U0Z0aVVZ?=
 =?utf-8?B?TlNrWGJkOGlMekxtL0pnRzhySC9taXNqZ3lyTjAxbDkycHRrL0dTTmFQU0Vq?=
 =?utf-8?B?UEFZejlVQUExaHV2SmtNR1RBSDhDRDBXUUtISU1pYngyL0xzUVBOcVVRdmRY?=
 =?utf-8?B?R1ZNTDFRTW00MFVhTWJxVXpQUnJuQlR3RGh1QnlBTEw5b2xvYlpNc3Q5Y3V1?=
 =?utf-8?B?WWZTYjIzMzN1aTRvNURsU0ZJYngxak92ZTlaUTRWd3pWSmhOZy9xRjFiY0dh?=
 =?utf-8?B?ODNYSWNkQ25pc1ptS29GcUV1dkQ5RFJJU0trZzVOeEs4My9UNkRtNWJNV2NR?=
 =?utf-8?B?QTh6QW5xaUk0eXUzeWxFdmwrYXdGR3llemFsblVmdGJzblFsVE9NS2Q3TVZ6?=
 =?utf-8?B?c2xjSFJVclA4YjJpMXNweGRQOEUvc2VvVGNoWGZUdkMrUmNTcldjdU1PNS9h?=
 =?utf-8?B?QnR0MHI0RFJxSlpWZmtuMENodlZjZW91VWFnRExPYktaT3I4blVaSXFrZ1R3?=
 =?utf-8?B?VDNVZ0ZWTEZ5QVVkdExsRFkxL29pSWdZeFNkSUlhR2MxYjEwa2FaYlZMd2tY?=
 =?utf-8?B?b0EzVFVzTW9EOFB4TXl2cUZZa3hCd3pOS3IvMFFaRnFrL0RPMEFmVnc3ZVBa?=
 =?utf-8?B?MUx4bnd5QkpjS09JSFZQdVR5dzVJN0hQalpYL2kzWktKQnZWSU5VUGRmb0to?=
 =?utf-8?B?c05LdlhQbDFPd2R5RmJOUkttb3M3VHJWcEIvU3UrYVV5UkJqWk5LTllhaU4y?=
 =?utf-8?B?bDhXUW44cWxNemV1YjM3TmFiazBENkFDU1A2T1VMU1Byb2JPdUFNQnNZM3Ru?=
 =?utf-8?B?eXdmT3pIbHVnU2ZwVEtjeE9QcUFUelhpdVFId0NZdVRQY3M1VzFaSlQxRlM3?=
 =?utf-8?B?L1dLRDd1VFZoUWJCdXZuU2VjMHBmZW5GUUE5bGQzMkg5Qkx6VnRERVVORTJU?=
 =?utf-8?B?MGZWU0krbVIwV1VLa1BuOStpaEFsdmtJWkxrU2gwaktuVFRwckpwZ0tHd2M3?=
 =?utf-8?B?NVVydVloZUpja2orUGVsSEdHL3lqSGVwM3hoRlFHTHR0elZwZFhQckJNZEta?=
 =?utf-8?B?VHRhUWtIQUZQMkRYMHE0Wld2Q1hreHN5eVJXakU1T0N5SEpkbjE2SFpBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODY0UWVqSXdGSEhNbGhhekNWTnVzZ2ErVTdnRzNmeGkvNGU4QWxNT0hWYURi?=
 =?utf-8?B?UUdTRW5DRVJtVXJHcGxlMFc3Q1dJLzlJQ3JOZUo2aElxbDN0WFhycGlvejB3?=
 =?utf-8?B?ekx0RVdVSHlldFhyeGpCY1VrMTVYN1lmVTdTdjFSQ2xYT3l2SWFrWEtpTEta?=
 =?utf-8?B?UHFWMXNSUHNPN0Fhd3pwZE5IZG9qd0p5VCtNYkpFRVdTRWN1RFY4bWV3bjlm?=
 =?utf-8?B?MTJjUmJ6ZllrMktGb096bUNrRTNJYWY2d1VRemZ4QkNQK0VJdGlmT00vUktv?=
 =?utf-8?B?UU5RaFE5ZlhKc2l6bHJ5dmpkK29qdi9mNyszYXEyYTZpemJzWUVYdWFSaFR5?=
 =?utf-8?B?NElqc1JudnB2b0o2RDVWL0MyRUtFYzFNOFJsRjUyWWFVV1BIK25yNzlGYmFE?=
 =?utf-8?B?Q0RtbUlzbGdKaUtTN1dBbkN2V0QxSXMzVFRoTVdJMHhrV0RBSjZDK3pGTUF1?=
 =?utf-8?B?d1FPc1JudUNOSUkzbXBqWUJKOVA3RTg0dG1rclpnajF3aEY3M0F4ODdRS1Zq?=
 =?utf-8?B?V1pVUFcwR29ra1Y3aUVGQ3lkaWJFWVVUT3ZUR1R3L3hPYmdYaDlyUTJhQ2VZ?=
 =?utf-8?B?TDRhaUZVd3ZraFlGOHhERVBYTnJDbnhCdThqY3RSeEpvYy9OMzRrK1VpSGNs?=
 =?utf-8?B?VjVZMWxJa0NCenB0Z0ZKREtRTU1Mdmh1TkhBazZmSjkzY2JhNythVk1iaUcy?=
 =?utf-8?B?WjZMbTYyZjNHWW1oMFdFQWRZNGVUNytNbFMvWXNlWEptRGdkOThNeXpzVjVw?=
 =?utf-8?B?dGNZV3Fzb0NwTmx5T1E3TVRvc0NJcEVGV0EwMDJmTkVGRTY4WUtYV2grQ3VJ?=
 =?utf-8?B?RWd6U0hRUEdFMmNLWDA4UmVGeWtrOHlzZ1JCMjdlbW5TdGFZSkhoUFZsaU1r?=
 =?utf-8?B?TkgwM044NURDSGdRd1FMcWRyU1RWS0c4a1dqSFVzMzBJYWU1dXdZM1NUcjVN?=
 =?utf-8?B?bFlTS29iZnhVMjFDdFQ1UkdUbGc2ekFCNmlVbEFGRnJrdDlJY2Y2N21lc3RT?=
 =?utf-8?B?c2ZhM0R1UkppREkxY3JYcklHT0NRM0hKRDhONlFtRUJCcFZDYlNYSzlwWk9F?=
 =?utf-8?B?cmFJcWhEWk90YWZLbkE0Y3FCcFZJZ05LZGRRQlVlSkFmTjVESHdtTG1Sd0Fr?=
 =?utf-8?B?M2NuWWlUSnBKM1EwNWVrTWZrMjd3cWVlbFJDZnBoalo4dCttaVUya08vbkh2?=
 =?utf-8?B?SGdkY0hmUm1aVEFyQlQ3STU4RkNRMHltajF6ZkxqZTcwOWRUMVJ3M0kwR0hn?=
 =?utf-8?B?Q1VyZkhETTRQY1VQbUo4RzQzUVZkWkdUcHhjTlpHNmNuU2ZmbDZxbElvdjBF?=
 =?utf-8?B?NVcxOUt6UFJtcHdPUitTc2hrbDAyYkFWci9lZlMyTVBvaGZJMnZ2TnI3Vlph?=
 =?utf-8?B?emU1YU5TdmE2alRkYW5jUy9ES3p4cVNuM2NqZ1NSaHRvOUpiblpGTDYvbjF0?=
 =?utf-8?B?TlI2TEVxK010dW1MeDg0dWF4Rm5qSitKSEZBRmZMM09WWlR1VWVTL01TUEJ0?=
 =?utf-8?B?SHBMaUZPN3daL09oMmpSd2RMVFMzaFVpZVYyQmJtQjdYdVhoRFlBeEFGUEZh?=
 =?utf-8?B?UlZSMitBeHhOQVc3d3lvMkN4aTR0YzV3Y01wQmQ3a0Vham9wTEUxT0RvbkRN?=
 =?utf-8?B?ekdBd0ZMTHljdkxCQ0g1RHlsYlQ1d0JiSlNjamhkRysvcEtpMXcya1FseklW?=
 =?utf-8?B?bmdIZFRyNHFpRHBHRkxyTVlGRzNqdFlaczM4MURlWTBaUGw0QmhtRE1TMjhM?=
 =?utf-8?B?aFlkOWl5dFcySUlVYUZSa0tpOWxHc25aejdvZnFVY2F0Tk1VRkpuZm9WZnJs?=
 =?utf-8?B?cVA3U1ppbXlLZHFUNjh2dEREc0p6aFNkZmRUNUZINlpoTUQ3MnZZeGRabEhw?=
 =?utf-8?B?WXBMSDdkVGRUTFM4SXRQZEFRaGdDOFFMbjNlS1hrcXJselorT0J1WjU3YWJG?=
 =?utf-8?B?QlVPcUMyYis4RnkyVkc3SzR1OEVCQm9pYTRIa1JBbDJNb1ZuSWFrTGgvZHly?=
 =?utf-8?B?WjE5T0gvYm1MbWdYcisvWjM2cXhJV21IOVhUUDlCUUlhM0RSUzh6QUl0dzNO?=
 =?utf-8?B?WFZFbXEzODdkRzdtOEhzSEYvUVhoa0JTekFQdTh4bTJMR2srVlNkUDRhcko4?=
 =?utf-8?B?VHpIbkZCZlhWQVd6bVlvTGd6YU44eDg4U3hGVWZKejFhNExQTDNkN29ySE1B?=
 =?utf-8?Q?Vtm3UW/DakOIjth3SywcxE0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	se9BQsJh8J9a+DfK53hRbOv3MFz4gXamzHhweMSQnKf2bYLcnsKCeaBks6VTbn3KWGDD4hFvt/+5dCITGgBjO0Ufd+dDibDfGscyj6eLH1R1GHc8EnRaSG621cbQ8sEoWbAH6Q1HAgjIhGER8Adp5kZUpazctj850yXhjCfLweCJn4VmZGZFr93I4lHffa8DS1xP6YqCrcDWaWfRuRc0mta2kX1Ay1DF6ILzMJCSbZLHxmPX8UI9vZuNHQA9dHthszEn0/3xr7tNt7TgHjE64zmduZV89Bfz+7TocuWtNv8KNStUchIaJsrc9KWcVYBhs0ym18ngmOhMMO5PDTKNHV/nH0km98fuZlhLrQ89HoQWU+H7zffmwx+iN4DKYeYWorzFLnAtXBLEhx1S8j5xecrvrzqiq73sJ/xe95j+YawBI8s0nKVmjN0zIieq7KaHAM2fB/RJ6NepWIxArz7tOqL9EVNwqV4frAZYrEqseFjO3mXY1FoIFKD4Lq6TFHh8NWUlKxyLMx9pcnbTHpkpBlqyPt+i8aeUl0+k2+IQVYqqUvKNrwwdSsOZuu7gH/CFN3Bht1TQ8qQ/UF4kUqcqVjWAqwZW8rvXAhdPM7Aw5dw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e68bb3a-054a-4692-04e5-08dc743399ea
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 16:33:35.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcTsxj8TNBDGgu/xb/zVV+k1z3OJpGSl9ZXnt1y3PFEejAgv5UPsUp/D6Gpolcqd21XTVxSIfrszlzSB6n19aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_09,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140115
X-Proofpoint-GUID: mwBSZoUbt5h0rRGN6Oaatvf2Y_cPwGLC
X-Proofpoint-ORIG-GUID: mwBSZoUbt5h0rRGN6Oaatvf2Y_cPwGLC

On 13/05/2024 12:12, Quentin Monnet wrote:
> 2024-05-10 11:32 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
>> If the -R <base_btf> option is used, we can display BTF that has been
>> generated with distilled base BTF in its relocated form.  For example
>> for bpf_testmod.ko (which is built as an out-of-tree module, so has
>> a distilled .BTF.base section:
>>
>> bpftool btf dump file bpf_testmod.ko
>>
>> Alternatively, we can display content relocated with
>> (a possibly changed) base BTF via
>>
>> bpftool btf dump -R /sys/kernel/btf/vmlinux bpf_testmod.ko
>>
>> The latter mirrors how the kernel will handle such split
>> BTF; it relocates its representation with the running
>> kernel, and if successful, renumbers BTF ids to reference
>> the current vmlinux BTF.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/bpf/bpftool/Documentation/bpftool-btf.rst | 15 ++++++++++++++-
>>  tools/bpf/bpftool/bash-completion/bpftool       |  7 ++++---
>>  tools/bpf/bpftool/btf.c                         | 11 ++++++++++-
>>  tools/bpf/bpftool/main.c                        | 14 +++++++++++++-
>>  tools/bpf/bpftool/main.h                        |  2 ++
>>  5 files changed, 43 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
>> index eaba24320fb2..fd6bb1280e7b 100644
>> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
>> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
>> @@ -16,7 +16,7 @@ SYNOPSIS
>>  
>>  **bpftool** [*OPTIONS*] **btf** *COMMAND*
>>  
>> -*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } }
>> +*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } { **-R** | **relocate-base-btf** } }
> 
> 
> The double-dash is missing at the beginning of --relocate-base-btf.
> 
> 

ah good catch, thanks!

>>  
>>  *COMMANDS* := { **dump** | **help** }
>>  
>> @@ -85,6 +85,19 @@ OPTIONS
>>      BTF object is passed through other handles, this option becomes
>>      necessary.
>>  
>> +-R, --relocate-base-btf *FILE*
>> +    When split BTF is generated with distilled base BTF for relocation,
>> +    the latter is stored in a .BTF.base section and allows us to later
>> +    relocate split BTF and a potentially-changed base BTF by using
>> +    information in the .BTF.base section about the base types referenced
>> +    from split BTF.  Relocation is carried out against the split BTF
>> +    supplied via this parameter and the split BTF will then refer to
>> +    the base types supplied in *FILE*.
>> +
>> +    If this option is not used, split BTF is shown relative to the
>> +    .BTF.base, which contains just enough information to support later
>> +    relocation.
>> +
>>  EXAMPLES
>>  ========
>>  **# bpftool btf dump id 1226**
>> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
>> index 04afe2ac2228..878cf3d49a76 100644
>> --- a/tools/bpf/bpftool/bash-completion/bpftool
>> +++ b/tools/bpf/bpftool/bash-completion/bpftool
>> @@ -262,7 +262,7 @@ _bpftool()
>>      # Deal with options
>>      if [[ ${words[cword]} == -* ]]; then
>>          local c='--version --json --pretty --bpffs --mapcompat --debug \
>> -            --use-loader --base-btf'
>> +            --use-loader --base-btf --relocate-base-btf'
>>          COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
>>          return 0
>>      fi
>> @@ -283,7 +283,7 @@ _bpftool()
>>              _sysfs_get_netdevs
>>              return 0
>>              ;;
>> -        file|pinned|-B|--base-btf)
>> +        file|pinned|-B|-R|--base-btf|--relocate-base-btf)
>>              _filedir
>>              return 0
>>              ;;
>> @@ -297,7 +297,8 @@ _bpftool()
>>      local i pprev
>>      for (( i=1; i < ${#words[@]}; )); do
>>          if [[ ${words[i]::1} == - ]] &&
>> -            [[ ${words[i]} != "-B" ]] && [[ ${words[i]} != "--base-btf" ]]; then
>> +            [[ ${words[i]} != "-B" ]] && [[ ${words[i]} != "--base-btf" ]] &&
>> +            [[ ${words[i]} != "-R" ]] && [[ ${words[i]} != "--relocate-base-btf" ]]; then
>>              words=( "${words[@]:0:i}" "${words[@]:i+1}" )
>>              [[ $i -le $cword ]] && cword=$(( cword - 1 ))
>>          else
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index 0ca1f2417801..34f60d9e433d 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -638,6 +638,14 @@ static int do_dump(int argc, char **argv)
>>  			base_btf = btf__parse_opts(*argv, &optp);
>>  			if (base_btf)
>>  				btf = btf__parse_split(*argv, base_btf);
>> +			if (btf && relocate_base_btf) {
>> +				err = btf__relocate(btf, relocate_base_btf);
>> +				if (err) {
>> +					p_err("could not relocate BTF from '%s' with base BTF '%s': %s\n",
>> +					      *argv, relocate_base_btf_path, strerror(-err));
>> +					goto done;
>> +				}
>> +			}
>>  		}
>>  		if (!btf) {
>>  			err = -errno;
>> @@ -1075,7 +1083,8 @@ static int do_help(int argc, char **argv)
>>  		"       " HELP_SPEC_MAP "\n"
>>  		"       " HELP_SPEC_PROGRAM "\n"
>>  		"       " HELP_SPEC_OPTIONS " |\n"
>> -		"                    {-B|--base-btf} }\n"
>> +		"                    {-B|--base-btf} |\n"
>> +		"                    {-R|--relocate-base-btf} }\n"
>>  		"",
>>  		bin_name, "btf");
>>  
>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>> index 08d0ac543c67..69d4906bec5c 100644
>> --- a/tools/bpf/bpftool/main.c
>> +++ b/tools/bpf/bpftool/main.c
>> @@ -32,6 +32,8 @@ bool verifier_logs;
>>  bool relaxed_maps;
>>  bool use_loader;
>>  struct btf *base_btf;
>> +struct btf *relocate_base_btf;
>> +const char *relocate_base_btf_path;
>>  struct hashmap *refs_table;
>>  
>>  static void __noreturn clean_and_exit(int i)
>> @@ -448,6 +450,7 @@ int main(int argc, char **argv)
>>  		{ "debug",	no_argument,	NULL,	'd' },
>>  		{ "use-loader",	no_argument,	NULL,	'L' },
>>  		{ "base-btf",	required_argument, NULL, 'B' },
>> +		{ "relocate-base-btf", required_argument, NULL, 'R' },
> 
> Nit: The lines above yours use tabs to visually align the different
> fields, would you mind (optionally) re-aligning them, or at least using
> tabs in your own line, please?
>

Sure, will do.

> Other than these, the changes look good to me, thank you
> 
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> 

Thanks for reviewing!

