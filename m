Return-Path: <bpf+bounces-33150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C6917F58
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 13:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACD42841D1
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D617E448;
	Wed, 26 Jun 2024 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A5pqnm4v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PjJ0T5R9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21317DE11
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400516; cv=fail; b=OcNyBgS40cZYAoTkQGz783rZZ1G7r661sr+AwVvxBzG3LAB9O9mCxoLc74gOwumr0H5M7VKRW5kSVLQswmWt9MTdqQo4uDR6aBgZKe0TbE9oKv/NujSkZDMd50OFUQWcnNnjQhV6OUuCDE5shEUWzak58T5CsDo7k5C6btwiSGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400516; c=relaxed/simple;
	bh=PX1E2XwlzgDZkEw43J2QAgUwYtML7IovXIgVXKd/f60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gt7avJsH8FjJSVS+vmPUeeVJKW50JfiuLVEFpj2Vet5o4TKWRoE0sW/ghtujjd5GY4S1xiy/oHLwoFeqQBxxID02b4+FLkD47u0GxEtr13tcZ/m6Jqj6C1A0v+Rf3PP591YVW1WuBp9A/8WGq5S6ptqe5VD4IYf/t0B5wxE0TRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A5pqnm4v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PjJ0T5R9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9sIvg001375;
	Wed, 26 Jun 2024 11:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=5Kr1Je4hf62jhmOZeXBEUgEIowI+gK0GR79tFiYeXhQ=; b=
	A5pqnm4vM/jWfN2qXvAQ6ornmIYf5nBcVTraEvluXgkrFAIzwY5l9cKT6cDovdhR
	7Mg0qnsnIMBk7kmYPA+PPveVnQGejoTNdLD2DqZ6mXwOdqyZbAxEtGrbhxZJ/MJR
	+WPCbaD4W5We11chJRsYljQBoMU8WBaHIEpjnkx2vEZxfGvqECkCxdA3dnK7xdJU
	Wc4FuM2fgvoc3PbKnS2zM+gccXqKSCX2GxuW3LyOPqbIvR3QQ2Epw2/gjRZkeY3/
	TahD4kv06BNHI+8lq1P6GmZ3UqtVcwS6noxGFo1yR/j9g9TPG9jONuPL5rDEmnZ2
	lyl/s1MgRz1dJSFZaGahHA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb329y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 11:15:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q9KpXu023334;
	Wed, 26 Jun 2024 11:15:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2fdt22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 11:15:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj1mN657B60Us3gLHCiYCtGK2/yqtWLc0rg3/pMd+f5yG6KWi7NIvSJRk+QLISAnB/qPaCY5hvWHjZIIQvOih9mEvq/CHICqPp4kTAVWK3Y/2HjqvY/RPreWf8vmkjC6M7FFnplk3NegxAZClIhhvGbq/UbO2OK8iF6v9CjuybdTHpAmwlfLiaASY769PjkHV3IeTnyQpoyr3CGQ9yZbg6+APxqkJCZlZZ30PvtLhytnrwCbc0ezjDqj1woI0TTlXjJMCzrjH920Uwa6W+T1C8cW2gGNwCn46S7MRLcn9+gDGt75ErKwGLfAKoqGV1DW6FVK2uXovO668ua1GUAULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Kr1Je4hf62jhmOZeXBEUgEIowI+gK0GR79tFiYeXhQ=;
 b=ciH15VoDFW5SmBymHlo/kPdITyzac4hFfJ95G4mq2DFA4U5deAoije19bXMp1TFfXHIY6zz9AVBHScR6IAVyChP+MPqAXG720CLad5YN270bowDQRGVuVIGnnMTHOsxu2q2d86gS+QcZr/xtzciRwy7cMfEc5XuOa5rmF+xyFndGzXcicq5Qm4LG8z7BekLVtLXomolAxJz6TGyK9kouKU3x24O1+75mEMxn8xCtqhjpJpndp7k70iC+NCxXkmCYWn+vmmM0IZX1nRnnpwAXCzvzZRJLnFwmn2q6scsMEboTFEW2lBhfStWV7adgsEorxl0/dqcJp6H9fHCzd/Rx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Kr1Je4hf62jhmOZeXBEUgEIowI+gK0GR79tFiYeXhQ=;
 b=PjJ0T5R9rwZzas3qFbGeBvi84nIeZOLpTb+ayS4klGgNPxIYe/MDA8I7JCW4h6k47cskiBjwSN0rkA68ZtA85TJptvPPr8Lf2nxG0FvntYS6vczVkAIFKPZuhupaCmJEKORtVQCfTnzrnmLkGWGCNJenqFBpIShvzble6pltSWE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB6610.namprd10.prod.outlook.com (2603:10b6:930:56::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 11:15:08 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:15:08 +0000
Message-ID: <06e22413-59d5-4bc8-897d-4823bf145d84@oracle.com>
Date: Wed, 26 Jun 2024 12:15:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: A question about BTF naming convention
To: Totoro W <tw19881113@gmail.com>
Cc: bpf@vger.kernel.org
References: <CAFrM9zur6bHTXJha-=Jyq-qYiZGodD-8hf2vMFfjKrnF+ir-Wg@mail.gmail.com>
 <4f2abaab-bc61-4698-8497-f6597ac21e22@oracle.com>
 <CAFrM9zv_NXxrcpFw6zCLzNSyNaT_Av1qRmkJ60_fNXgL+YNW7A@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAFrM9zv_NXxrcpFw6zCLzNSyNaT_Av1qRmkJ60_fNXgL+YNW7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: abe812db-e4d3-4b13-729f-08dc95d13d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NUY5Y1lrNkh2bzhJTks0MDhyZ3ZtR3F6YU5tOTdKTTN0QkcxK2ZwRkI3b3RZ?=
 =?utf-8?B?NHVXVG9BYVdwN1dOMUVsaWdxRlZvQVU2c0wyZzd2TkQ0SWw1YmNGQ3NZaTBx?=
 =?utf-8?B?amtWd0RYR1FTWlpiMVcyYi9WcnR1ODRQa2hsdE41YzRDdTJnL0t3bTdSNk1W?=
 =?utf-8?B?WVd5RDE4U1JwcVpOQnpmWFI1WW5Zb3IxUVY1bGVWSVZmd3NsVVd3VHdyOS9S?=
 =?utf-8?B?K2ppdlNVeUN2SUpIZU5MY1JwSzhwMTFxaTg5dDd0cDY2clZ4RmZKZGZrQlMr?=
 =?utf-8?B?NzM0cUN3UVdNcFA0VW9nMmYxcWRkK0J2eVlSTXRmeXVRdXhCVVdSUENjeXMw?=
 =?utf-8?B?ZkhDMnVYN0E3djc0cCsxdnhCSDVTSUp4OVBDMEhzOEt1MUhNUzcyK2pSeito?=
 =?utf-8?B?VUZBWDJ3Vzgzb1hYUmNDZllvazVUYTNmZjRxaXVPZmVOSm03Mkhod0VrRjUz?=
 =?utf-8?B?dzdFU3ZEa2lnbGs5UTVUSmRXWng2SGFtNWVEK3IvQWZzU2VCSTR0WlhQdStS?=
 =?utf-8?B?d0N3UVc4S2t1Vlo0N08wazM0SHNYcnZmZE5vY05DTUc5TXpOZWpvaGd5Zkxi?=
 =?utf-8?B?SkFHeFVzR1RxOWZkSmo5WUdjdkZJK1ZNbHI5MFNPUXR1UnVMMUorWUp4VTVH?=
 =?utf-8?B?RG5USHZmZERSQ3Yxa210aEFQSTJTNjU4TGFJcHNaQkxJY2lwOXJOSHVvbkFX?=
 =?utf-8?B?WnoxMG40Rm5vdFZTbUhIVFAza0FyaWlWcE1JOFF4ZUZ5OEhEZm1lV2RYNDY0?=
 =?utf-8?B?UHlrOUpyZjRJL2Qrc1RMNDFWOGZZSncxWk9meVlGZzdsUDhobUNqS3JNTWZx?=
 =?utf-8?B?czdJVVRsc1U3bWtVeFVOZ3JKSnRCOExaeDVrSndCVy8rNkZrK2JQcjhyYmVK?=
 =?utf-8?B?TlcyeFMrSHR3VkI1WVVVZDliTmdMaUVlckpkdHd0RklaN3ZyUHdyR09rNFAr?=
 =?utf-8?B?bzhEWU1tNFlJWndJSVkxUFBQY3phTzFqT0JRNTl2SjE5RE9pWm5rNnQ3eFVs?=
 =?utf-8?B?bndJZDNRRGZqR05qTlN2RmRWV1Qvd3Q0V0xmOE5VcEZsdHBZZlBCak96Z2dP?=
 =?utf-8?B?S25xSWk3REUveDFIcEltUlVZRDIyTm04Vk5YeWlHeFR6dGs1Wm5rUHZHWnIz?=
 =?utf-8?B?ei8vamwwczRlZVAyeFZWREdLQzdwRkJPMGJLYUZua2xhUFR3Y3ZWSElYNnJK?=
 =?utf-8?B?UXU1VHM5TGhzR3FpYzZ6eG81cmpiWEpuclJ0cWhMTzN6cERia0lEUC9MdHEr?=
 =?utf-8?B?amw4clFZZjZacDFqQVJxQTFxMStkVGIzT3d5UnVvbHNRUDM3YjZINzViUDV2?=
 =?utf-8?B?QTJuN2N6dWZFajRpZC9VTFNhMXFmMmtvdzFDMGo1L0hWNHlISy85RkNqRlEr?=
 =?utf-8?B?L2JhR0NoWWtUeFZLMFgxN1FGeUJoSnZFVHFralFtOFh1RFZlQVZnT3RHNHJD?=
 =?utf-8?B?VmlnWmx1Qk0vNW4wbVd2aVNPZmVLaUJUdGFUMEhZV0x2aGRxVmtOeU94MndI?=
 =?utf-8?B?Yk1wSGgwNTVQWUNKaThlSTZQbDJsU0JHaG5ZUU5oSFJWeTlZSWswOXJ0U2dV?=
 =?utf-8?B?K2ZlRllJUjM5OGlDbzNjOGx2cmg2UHBra1Vzc2xKODJDanBqVlpaRVlneUxL?=
 =?utf-8?B?S2M0ZGhpMkJHMk5iSWhialNRNHE2djhmbHRBdHJvY0tUN1VKQWU1MXpPQm84?=
 =?utf-8?B?dWFxY2xtcWFlYUp2WDM0TVFORkxXa0RuSHJDMnNRM0x1MHRzL2gxOElwL3ky?=
 =?utf-8?Q?EwzqYyW3VZ3+fmSI10=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2ZYYi9oanhpZTc2clhKOTlxMlRSWE5mUm5odTVJUUJiTStiVFRiR0VHMUI0?=
 =?utf-8?B?WEJGYnFkajluQk44U282UTd0a0QxYUg1SHE1MXVPQm1RMjlBbVNycEw3Q1Ft?=
 =?utf-8?B?TlUwMDd1QUxIUjJtWlBpT2U5VWdoOUU3M0o2b1BpMGs5L2J5SVFHQXFBZE9q?=
 =?utf-8?B?MVdyN2o4K0Mvb1hCck56RFJCSGhhWGhja3NCVWE2bHhDTUhwNXRXK2dzc0RJ?=
 =?utf-8?B?NHRzOXk3aURwQnd4N040ZWVWMDlNR3J5eTRjSkowOVpRLzEzUmo5enIzbnpv?=
 =?utf-8?B?cG0xNlp5YTBPQW9VeGk2eVB3d0ZKT2RKbENXOTRDRkxrQ1JTV2RRUXVzelcw?=
 =?utf-8?B?cU1lYXp2MEtuMENRVFRSTGMrVW9odk9hUTIybm50b0FtanRHZlFobTlMdGg1?=
 =?utf-8?B?akJxSGorZGdVa3NkSkJGbXU1VjJWeHNFYWxiRENPdmpQMytJTlhoSHZ4Ymgw?=
 =?utf-8?B?dENIa1ZUaHo1S3AxLzlobFdMdGJ3U1o4RVcwdFNHdGpuaEllUGdjd0YvQkNO?=
 =?utf-8?B?YnpQWUNaTmN1Ulpxemc1WE5YdXZEUEdqQmNrZlZqK1dueUlISTZiNHJPbmxm?=
 =?utf-8?B?TG10K2xHYk9Kb0hsNHJWTkZjTWxYRXNDSmc3WGdWd0VRVy80MFNsd2pVVTNx?=
 =?utf-8?B?blEzZEVPL3BWYjR6czMrV3ZINVZQN1E5NzF5QVhIMnRNdDlPeFVQYitzaWVC?=
 =?utf-8?B?aWIrRHBxUlpWR1FYLzlKeUhkcUtIU0I0d0I4Y3pVTHJETStzL2JUbEQwMUk1?=
 =?utf-8?B?VFF3UlVCTFozU0dBUStwMnlHbnJpM0xoQ0tYV2R0YUI1N3B2Tm5USWZYUk9x?=
 =?utf-8?B?RW5XUnlmbFZ2eDRkekpTMUhyME1lRDZoU3RiUWRrcnBqeWdKUG5GNFhEalll?=
 =?utf-8?B?RHUxWjNCN3cyNVFKbjJpZ256Tm5rd000RGh0U1JpNGw2aGJWRFcveUd3VDFk?=
 =?utf-8?B?d3hXc2srRkg2NURlU3pKZUUrU21nNHgvd3Qwc1hZTklPWEVySWRQendyRjhK?=
 =?utf-8?B?Ny9Jb3lFenhhdjNIaVdYWHZWU1k2Uk4wNDROQXhhL2N5Z2ZJMnhmYXBkUDhC?=
 =?utf-8?B?UTlWTVpBanlHQ0lkcjRreHFNMEUvNk1aMFRpb2ZaNE5wWG8veDg0ZDc1cGwv?=
 =?utf-8?B?c2h1TVp4MENtT2R3Nm41MDc2dmVGNUhwbGRDMFQwN1dvTm03WndJZ29uV0JG?=
 =?utf-8?B?RUN1d1Y5S0c3V2dXWDh3S3d0VEQ5d0Y1TWFZUTVwNVFRdGNFUzJ4Tzh6aWtZ?=
 =?utf-8?B?NldMWDNUSVhEMWx3WlhtUGpBV0czMnprTFRoRzFERnlQMUdoZ1dia2lydmZ3?=
 =?utf-8?B?cGJUSVd6aWwwUVNBSXdNUnRzYWtWNnpydGg2clJMMmw3QXVMaEo1SHREamhx?=
 =?utf-8?B?MlFGb0oxUnBCOVF3SkI3dVFhWEtaWlg0UTNFSEc4SS8yVzd4NjcwV2ZZSzNt?=
 =?utf-8?B?MW9UckpCNXA2c2ZWd1RMMFRrZTlocmNTaXVOcHM1OFZoZUNPWCt6elNBR3Zh?=
 =?utf-8?B?Nlg4U2FQR3pzeXVjMmpwRjJzRUJ0WGM5TklFSE8zWkJ3dVBXcGhKelNVcEs2?=
 =?utf-8?B?VWQ5YndJNnUwUmNxRkluTUpaRUFlaTlwZXFNWGsxS2RqeFA4bGdzdmhWQ1RU?=
 =?utf-8?B?SUJkNVlIc3VLTmMraDlxNWs4TkJFL2NxSWNQTlFDakF1OGdXSlhlQ2NzOFl5?=
 =?utf-8?B?RVlrSUJmMzkrMm9nU0szcnI1SWhjbmhVYmdFVzZlVzdTU3g2YXJXQnJkbk0y?=
 =?utf-8?B?aTdnS1pDZ0h4L2F0RnlmcUw2aG44Sk5BRndFcFhhTDNGbDgxbUxPcS9WZFJ1?=
 =?utf-8?B?UjNUNFV6VENyWkl1RndwMmlaSnd0cTRZcFlObkJrODJTUys1UlVFeVpENEZI?=
 =?utf-8?B?aGRCQUlocDkyaHJocDROS1JBMFp1VVZhVVg2a2pOTU54d3RTaXBtdFZxL0RC?=
 =?utf-8?B?SUl0UVJNQnlrZUNkSDV5bDJxMGxTdlV2Um9HVUJhdnRsYXBsd2ZmNlZ6a2dz?=
 =?utf-8?B?c2t6YnRVbVVYd0ZIUDVKM1EvZ1ViVncvK0g0enFUWnlITVZsZXNjVWdWK0Zm?=
 =?utf-8?B?YUtrRkEvdDRiTWZVdmNjcWFzdWQrUDU5eVA4eUhvMFhnVkZpRkhqMTFHODRO?=
 =?utf-8?B?K2pQa2N5ZVRnaFV0c3VMMXZramFya3FhdmZWY1VBMUhoWVRsbXlMdTFhbUo3?=
 =?utf-8?Q?WWKabzm7qMb/JGyCzucplgI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7TXDNi1sNeC4dE3pNKsdpsArOwQBszNaJZV2NABsPJIdfSgAKygG+HN4MmBYKXfkPEGgy5fnlXwdrAu1StSLONhn9R7uCMCNx8oUHz5ZfK5y1ViYg+FfLohwPkMTyH19eTgKljQbjX4rPQl4gktCEo+nU/y+2GBdjUMLI5YCWrrKHcFDtp/+DWAr7xvVCDdHXMZSClUf4s+72BQpvxwKXsRI2m5we9CIkdVmYSLVPuVhLdD1zrFUIDmk60abFSDdnE7Q8rsNy2OQIMQ3I/A+ax3Ea30iGaku7IRd5hdx9V9Q+Lo+VGeBziozUHN/MTaby09Jt0v5wDe7ZYlE0Z7vJ93kaE35OUwMdN07kWjVzonEs1uQcbLzIjWKqcmqjQnUiv1lQzDqYWOse2hcjl+XwSNvxWMd2SFdMWXKUfY2Ji3a2cAKzBgaE/JeluoAos6oaCcJ5DtOEs9YrKcVTYo/PGBbTDl0YnmTDRxPOuRzdIQs1RfHCbYCRWdKO9+LRyiYKgFIE9X2aYzkR+q0x7adFXbiOOClvx42WRaa9yENYXGmQZoclfcPcIaVXEOdy2Fxe+DMvUufJRmQGomZDRgUsP6ENxN1lh3NrDB/r9g+C7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe812db-e4d3-4b13-729f-08dc95d13d27
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:15:08.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K93Q5SwasWWDP3cK+ADscFFvSYc4IUIqUPRniTb8AFLmIWIiaqOgvvqBDuZehvI1STYyaOR1gbbGIK2jj5VLHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260085
X-Proofpoint-GUID: ZZNPXzh_yaoyr1U1nGTAANFWIUbfN2dO
X-Proofpoint-ORIG-GUID: ZZNPXzh_yaoyr1U1nGTAANFWIUbfN2dO

On 26/06/2024 11:51, Totoro W wrote:
> Alan Maguire <alan.maguire@oracle.com> 于2024年6月26日周三 18:19写道：
>>
>> On 26/06/2024 08:29, Totoro W wrote:
>>> Hi folks,
>>>
>>> This is my first time to ask questions in this mailing list. I'm the
>>> author of https://github.com/tw4452852/zbpf which is a framework to
>>> write BPF programs with Zig toolchain.
>>> During the development, as the BTF is totally generated by the Zig
>>> toolchain, some naming conventions will make the BTF verifier refuse
>>> to load.
>>> Right now I have to patch the libbpf to do some fixup before loading
>>> into the kernel
>>> (https://github.com/tw4452852/libbpf_zig/blob/main/0001-temporary-WA-for-invalid-BTF-info-generated-by-Zig.patch).
>>> Even though this just work-around the issue, I'm still curious about
>>> the current naming sanitation, I want to know some background about
>>> it.
>>> If possible, could we relax this to accept more languages (like Zig)
>>> to write BPF programs? Thanks in advance.
>>>
>>> For reference, here the BTF generated by Zig for this program
>>> (https://github.com/tw4452852/zbpf/blob/main/samples/perf_event.zig)
>>>
>>> [1] PTR '*[4]u8' type_id=3
>>
>> The problem here as Eduard mentioned is that the zig compiler appears to
>> be generating unneeded names for pointers, and then you're working
>> around this in zbpf, is that right?
> Yes, you're right, I kind of workaround this issue in zbpf.
> 
>> It's not clear to me what that
>> pointer name adds - I suspect it's saying it's a pointer to an array of
>> 4 u8s, but we get that from the fact it's a PTR to type_id 3 - an ARRAY
>> with element type 'u8' (type id 2) and nr_elems=4, no name is needed. So
>> the name doesn't add any information it seems; or at least the info the
>> name provides can be reconstructed from the BTF without having the name.
> Your guess is right.
> 
>>
>> So the root problem here appears to be the zig compiler's BTF
>> generation. If there are some language constraints that require some
>> sort of name annotation for pointers, couldn't that be done via BTF type
>> tags or via some other compatible mechanism?
>>
>> So I think we need to understand whether the BTF incompatibilities arise
>> due to genuine language features or if they are the result of
>> incorrectly-generated BTF during zig compilation. I dug around a bit in
>> the zig github repo but could only find BTF parsing code, not code for
>> BTF generation. Finding where the BTF is generated in the zig toolchain
>> and understanding why it is generating names for pointers is the first
>> step here I think.
> Currently, for the BPF platform, Zig uses LLVM as backend. So the BTF
> generation is done
> by LLVM (https://github.com/llvm/llvm-project/blob/37eb9c9632fb5e82827d1a0559f2279e9a9f1969/llvm/lib/Target/BPF/BTFDebug.cpp)
> with debug meta information provided by the Zig toolchain
> (https://github.com/ziglang/zig/blob/master/src/codegen/llvm.zig)
>

I suspect the problem is somewhere around here:

diff --git a/src/codegen/llvm.zig b/src/codegen/llvm.zig
index 1e29d2cbe5..9ffcc97393 100644
--- a/src/codegen/llvm.zig
+++ b/src/codegen/llvm.zig
@@ -2201,7 +2201,7 @@ pub const Object = struct {
                 defer gpa.free(name);

                 const debug_ptr_type = try o.builder.debugPointerType(
-                    try o.builder.metadataString(name),
+                   .none, // Name
                     .none, // File
                     .none, // Scope
                     0, // Line

That metadataString makes its way into debug info and then BTF.
No idea if the above works as a fix but I'd start somewhere around there
with the zig debug info generation and see if adding an empty name helps.

Alan

