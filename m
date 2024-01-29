Return-Path: <bpf+bounces-20614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7DE840CEB
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 18:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28BA1C230BB
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC28157038;
	Mon, 29 Jan 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VJ11GQqm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AVnzM9hm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA9157036
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547919; cv=fail; b=ncQJErX1T/YCysITpuy6h9zI/MsITPFUd1GYLnhVzrKev5MJGDAm9Bkj5lKF5QDwoupmcwiZDiMbErSI88N2Yr5B0S71h82/IeLhMo+JafeHpI+xUmzrSGbh8ydFfQ0z1sR+AXXsCdbRHUuJ/8Mj0s6c70cbB4ZqMyDpGkMMduI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547919; c=relaxed/simple;
	bh=YWQotCTX7V+RTxTeGIKPqAUVBr72eJJvvnx4PCPy1fQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=XqEhsXdKjQj+3otxsUTy0axxizgIt6dsX9LSa8EdrxOvcEDfBX9SMFxafG2bazU5KQLGTGcpjkxRpL+UOadPIiOmx2Au//X+ijl+iEjhIPB4jrt7jzeS+jDiQcK0rdliE5PgHFRkHpto1GZuSL/beYSuEncnjg0og7BPNAzZbP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VJ11GQqm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AVnzM9hm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TGmwHL007110;
	Mon, 29 Jan 2024 17:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vnzYU7jKrgncnqe4J1Y7arTumpcP81hknqp9RTCUg8c=;
 b=VJ11GQqm+x3NVrj895JSN/EhIBHbH1U7oDW3RMxD76nhGOfQy4nBu9ahOQDDwlJocjT2
 AJFW0nDK/1RFrWmVLNc75aH5GyFIYquLSf3zU2BOUSFt0XdoGF4WT0Kja62DDYhYYK58
 NfsgeadsWbleIN9uzqAmZab6S4ZWe0+yx8+7DCgZb5n47SmbI9YOvHNMffPDFUqhi9YR
 GiApu9nw1/Vlr2LM0si+GazE8gPEQr6TmE0B3UUKI/z5uKwbD0UsHFNQORd+z5UvaT2W
 dUBL2tn/xutBVshXuyiqZcCiULPBJsXAHgoAFOg96zaFYvV7eBibmxoIQXHlfosuwmZ/ Sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm3vfy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 17:05:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TFvZMX014627;
	Mon, 29 Jan 2024 17:05:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr95wkpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 17:05:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7V86LGe1ItKtuh269TkmCA42eH1A6JRG9pQfLxUJsjw2sW6KyOGBiIN1U+cIBcUdA6WCdFALKZrfvKMUxBoq64pL9JpOc/2Zg0oPplAXQxdnxDTQsNnY+LiGoAgjOV2akxglDhPT/wQtZU2ZdkCsI9r+/msMz6pd4Dk18WGbZ9tUs56q1k9hIAq40m1E8WVmGb77UO5uo9SrsM1CiNrmR6vRyMOdvj5fYtAa9eivqmE5cRC+Dup9jMFL/L+xZpGCOZcvXXlNll1hgefF9ZTAri9Lat00h6xA1kyrBF5D3Vr3iM1NO+ajUTg3wki1/0CNfY6S1Kk/N1Jo9jP/S22LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnzYU7jKrgncnqe4J1Y7arTumpcP81hknqp9RTCUg8c=;
 b=UVbMHGZmRpfSB2I96hz9SyFAHN0nbrg7IcU+nySq0JTM283QwlPrexpySGpyX9gLzBCrmZlLBEYs5PaNdYGSWEGBYKdaCKJDV+9i+GAfJInAB81RwyK0SOP3QFfQaGZwqi1s9MusFwr9s1DR78zkX2u4ox3ObC2X0KXyLqU2IYKe6wCDacd97eyfEiMk7NiIJ+tLR2nbPt9OdKp+OPe7p1Lo5JK/xUbT1HD7Ca8xTEngXTbQPc34FKmmWvAoRZz1YXRgjiuTKIPhbMeFuGcAzXl5t0CEs7FmsgEjVHHJ4S0J1u5x0oOmpdUDhfbtYVIkw3QFxX0HL9+FhfTzMB4exg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnzYU7jKrgncnqe4J1Y7arTumpcP81hknqp9RTCUg8c=;
 b=AVnzM9hmtfknZdx56RkiPP50IbCZ7R2zP3LIrk29/7P8Ik3QiIjpvY7dFvFASj44EMiZHRgKHBiHiTHnp7glv0hAZw+neAwU3sivPL/MvVYpVIYhf388K5H3+92+EXwe4fiGbbgyy+JQ+giNsbRuIyDJjHLq4YNGDivgGnVMb4E=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SA1PR10MB6638.namprd10.prod.outlook.com (2603:10b6:806:2b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 17:05:07 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 17:05:07 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        david.faust@oracle.com, cupertino.miranda@oracle.com,
        Yonghong Song
 <yhs@meta.com>
Subject: Re: BPF selftests and strict aliasing
In-Reply-To: <6819204566bfae73c140938920eeb389d27abad8.camel@gmail.com>
	(Eduard Zingerman's message of "Mon, 29 Jan 2024 18:15:39 +0200")
References: <87plxmsg37.fsf@oracle.com>
	<b1906297-d784-479b-b2f3-07ab84ae99c1@linux.dev>
	<87a5opskz0.fsf@oracle.com>
	<04efa2a3-ca81-42c3-883f-5b91917f2bde@linux.dev>
	<6819204566bfae73c140938920eeb389d27abad8.camel@gmail.com>
Date: Mon, 29 Jan 2024 18:05:03 +0100
Message-ID: <87sf2gnk8w.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LNXP265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::21) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SA1PR10MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f313a5d-d38c-48e8-793b-08dc20ec7173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9qwxx9WArrpxODhaaGspdnJpB8abgzGPDjU2qxEpPEIvxAnlYqiNkuhDN1h3v6w1rMUJPcAfBA1RRPcVbFoj2iRtH7HGva1gU+4TU9P08cudvokoYnnAl4Hj5aAT8F7IjwMMxlR8Ge5f8xqXLgyp9trTYXd/isDXGE2w3JSrOCOUJQDVEU/NOvYEZ/AczaTDkRb+p9d7rO1Ktcjwkwgcnf8JT5bI+nxZStE0kSb59Iwb9umd6hOoqICW1rXbNmhkjeoWvOzr5XHntJUb/LIRV9uJ0VcNprOQ2KslrtwilYHAr7bfmf19uThTOMkDt852fzi9zt+3GV6klel8bjks3rfLQBqzE29/OXqMxcskUzohFzh+hv106Ok4TuPJqlGa82MxJI7vcuDJ0Uk9sM+fGPexkegCMAWmbwFHBpvwr1aB2vDQpF+AW/IojPJD2V7wEAxXJjNZEx5rM5VyBTZSDB2DXagaDL05DEHo/6oQwaarHQ0KqNACCIEEg6EUEns4s1Ie9N2MTUoKhskRcMuimF76+96TXMisrZakQNkUVVzx+tSvP8s4tMww8mqKi49S2q6xOe6uoUa80XMWQwodIKOao4KArQY8Fmx1buR41BeeCWcMzuuxlnYF+sTLmxdm
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2616005)(6512007)(38100700002)(26005)(4326008)(5660300002)(8936002)(478600001)(8676002)(6666004)(66556008)(2906002)(6486002)(6506007)(6916009)(66946007)(54906003)(66476007)(41300700001)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDVPaTF0NDVYVEw0M1FaMFVyUnZsNG8zaG1ZTkZNS2F1ZFZTQXRxZVhvVGxF?=
 =?utf-8?B?UDluMk5mNmpwKzhIYnc5N281YjdzRy84ZG9iL3Z0OHVMRS9BOHB3R2E5RDNt?=
 =?utf-8?B?eU1GNTVGaFd5amk0bDdiZ1F1RGRSNTdjRThIelE2RkNQaUo2VTFpUTFudVli?=
 =?utf-8?B?ZlRzVzgvaFBMTWpoR2prbjM0RGt2OXlLZnk1dGxyMFVKM1hVZ3lDUEJMMmdp?=
 =?utf-8?B?TzhjT1JaZlZJQ2l6QllaVTE4L3daZjBJTWFBcUFSSVRXUEZuRDdmdnJCY09P?=
 =?utf-8?B?dzVqL3QxRG04MU1YcytxT3R4U2Uycmt6R3VrazVOVnUvbHBIUjZMOEJ3eno4?=
 =?utf-8?B?TTZ3eUJGR1NIc1crU2dJU3lmdXpteW9Lc0R5amU4QkR5Z2paRlpGUnFkZEor?=
 =?utf-8?B?RXUzS0h2WENxelhjcVRWdDgvdFZGaVhLSWs0RG5QUlZDSDIzSDQ0VzFIYVdW?=
 =?utf-8?B?STVCS3NTTmVEVlBueUZKVzFGbDlKWGlnZnhCUWQzZUppTWp6WTR5YXlWc2Vj?=
 =?utf-8?B?bXEvNHpnZk1JSXp0RVpTZ3F4ZGtMN3FJM0lRa2JWZEdwcXB6V2hxZ0RJcUwz?=
 =?utf-8?B?ajB0ZEJDM1NPN1VwU01TVzhyMlVJeEhwMWV4UGV4c2lsSXg0a2hpUnFocnp4?=
 =?utf-8?B?OVZIN0hnWWh3MkZPMVp5ZTVLVlJ2ZTRHeTZNc21DUkY2QVpCbkRlL2tpZE1O?=
 =?utf-8?B?di9QbzRxS0dKWUpmZVZ4UTRRcm0rTDg4SGZiVExYenBKTUpqTXVUbkNUQUp3?=
 =?utf-8?B?TFAzZEYrZlZpd0lmWC9tRDhHVmxVK0Zqc3Z5L0JLbmp5RHJZUGpQWDNRdEJZ?=
 =?utf-8?B?dFI4azg0WFdWT2Q4VFBRNmdqSHBvdmdjZXF2V2lRVFdzQVFCZ20yNTBta2pL?=
 =?utf-8?B?ZnRLdTcwOXhQODg1MGo1TFZBSVQrc1dXWlNVYmlJelBYWWo4Si9VQ2M2U2Vm?=
 =?utf-8?B?U005QVRuY01MV0hRVmczUk8vdzRlT1Z6bm1EV1VsTWUxTkJBVW51eFVwdVZv?=
 =?utf-8?B?Z3kyWnJzNlZlNTZsUy9MZ1NvZU11ZGhSdkE3NGdLUGx3Ri9vTzdwQlJpSFQr?=
 =?utf-8?B?a21jLzhQQTkxVzYxdUNpZDZDek1tNEUzZWJOeTQybmxXNXZ2NlUzbTVaNnFX?=
 =?utf-8?B?S3RQR3hhZG5KZFlPczlZU2Q5cjRLZDBpVFA0cTg0cjRyekY3dU1LaG1NUlZC?=
 =?utf-8?B?Q2VZb2RVNWZZUHNyaHBXUE40NXFJV2JpWFNFVzFldlpId3VOcmVyV0pvSXdF?=
 =?utf-8?B?QU15NERqZkU2OEVsVGcxc25ZOWo4SzlYeDZWNFBZVGhLVXRqL0pxd2pCSWFC?=
 =?utf-8?B?bW9OS2N3VjFIT25neEwwRU14Yk1GS0FlM1VBT0VISlRnbTUzcWxWWDVVZE9k?=
 =?utf-8?B?Ui9uTmhxT1ZScEhVa1BRQU8xZnJDUzBWK25SWk5ReE1uaTlKbzJSaEVwYTNi?=
 =?utf-8?B?RS8renR4cGovdm5aUDFGWlZSZUcwcXY3M2gxN3pHWU5HbDh3d1I4ZlBrclh0?=
 =?utf-8?B?T05LbCs0bzFDMlhKU0pHVWNSSnlHVjQxeFdrOU5BRkd6dEs5REhhb1RlZGtv?=
 =?utf-8?B?blVpYWJ2R1pVWXZwRVZYMFZvOXpNZXZOalI4SytFeFZjUWEwVWVvOUJxT2xK?=
 =?utf-8?B?SDRNWHJBZWVMVjV0RVpWR2NJQXI5YVduUzBobVl0UXBVdks3QXhCaEV4b3lz?=
 =?utf-8?B?c3AyQnhCdmxrSWMzQzdrMnlpSHdNUGZmTU9RK3V5SUViamFjNEJpMU0vN3Zm?=
 =?utf-8?B?VHZIVmxRMTh1M3NKQ1lpRU5KLzVJM3ZUbi9XeVhyUWFhZFQ1U3dzcHBGTFBB?=
 =?utf-8?B?MkNSZTY3eGRHWGFzZFhqbnBjQStXTE5Udm1LbzJRL3RGNFFrN0I2dG5zZzZE?=
 =?utf-8?B?MmhqNVQrcUNSTG8rNC9IRFlHd0pwT0R5bWtwV252dWJoWjg2eXBzc3ZLQkdm?=
 =?utf-8?B?Rld4aFRod3BSQ1UzKzBaSXVSdnBvU3RLMHZDRktUcE02QzlpWjJlajcxb3J3?=
 =?utf-8?B?RVNKYkpPU3R1SmFVOHpSTlpiVXdtM0ZXTnR3V3hoeGxtZDNQV1BGNDFOaFYx?=
 =?utf-8?B?UnNjdjRzdWVaUWY1cXFIK1dQMk5GNXUyZE84SWR4emt5UWdEZ1pHRUhBTkdy?=
 =?utf-8?B?TkJERlVvbXhJKzJpb1V6Vi9zbW5HWFFWdnVreGlNUGN0NHdzaFZlbnd0K1Rx?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ERqDKwWC00sLcCseGS2qz/3DGM3p13u+KYOBrX1SxuJ3otMKBFLQMU5K/OBJaJCpqx6Bc+Grnv6BV5moirkNXNpLRpXJFj6jcR5TFErgGulVJDgsw+Xh4pkb2dEQmEKJjtz9s3oU6QjX4MkML54bg9Q4rexxH0YZIpiwRbBYRIQ4ludupEpAEEz6uhQdHj6ibpCF9Tlv0mGcp9GS6UX9p7RwjYLdc9Cgix+qhz2CD318QJ0SlVY+Eu0Mdyiv2jawLNDtnvB7PZfub8h5xZ41iSdXixMGZDXAEADpjLLWpRGGEpmukTFXZ4VHzWXXn2XxI2bN/9K/jC03L1DjAAzR0sHPLryAGdy2aJysgy7/g3MPrW+QIEmqEYMqoNsD07CG9sKamMY1ItkTbt3cd4wWk2NvMWiD6IT7DSfLHtgUeqb6dHllp+A2ny93T0eF2HxmOwV9COQfkIkLe3bJI4s66yD53/TWU1soW7FJvPke8XlFybEIiA8l8Drgi8b/r6ZWCkWf+rC2dXEgpWopoPtGrByVCn+GpJZA43BF7+ZFwko1dcCG4oqshHkyTaNwSbyKyVz2EsUJHVOZsWOR4dRaKIHx4YiBrM/bWKkzw6ziilk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f313a5d-d38c-48e8-793b-08dc20ec7173
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 17:05:06.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoPvnlhDs6i12YOhSCR98SrD7CBCnLxMpTb5coxJV94+sDaGywxjCdubiyvQJ94sk0Khm4czOdGs6Tsz0/AmTqjVqBGXq2bUkOZwoKglmIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290126
X-Proofpoint-GUID: GPQfL4ITHEh_YTqihI-RtRFRuLb1AdRe
X-Proofpoint-ORIG-GUID: GPQfL4ITHEh_YTqihI-RtRFRuLb1AdRe


> On Sun, 2024-01-28 at 21:33 -0800, Yonghong Song wrote:
> [...]
>> I tried below example with the above prog/dynptr_fail.c case with gcc 11=
.4
>> for native x86 target and didn't trigger the warning. Maybe this require=
s
>> latest gcc? Or test C file is not sufficient enough to trigger the warni=
ng?
>>=20
>> [~/tmp1]$ cat t.c
>> struct t {
>>  =C2=A0 char a;
>>  =C2=A0 short b;
>>  =C2=A0 int c;
>> };
>> void init(struct t *);
>> long foo() {
>>  =C2=A0 struct t dummy;
>>  =C2=A0 init(&dummy);
>>  =C2=A0 return *(int *)&dummy;
>> }
>> [~/tmp1]$ gcc -Wall -Werror -O2 -g -Wno-compare-distinct-pointer-types -=
c t.c
>> [~/tmp1]$ gcc --version
>> gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2)
>
> I managed to trigger this warning for gcc 13.2.1:
>
>     $ gcc -fstrict-aliasing -Wstrict-aliasing=3D1 -c test-punning.c -o /d=
ev/null
>     test-punning.c: In function =E2=80=98foo=E2=80=99:
>     test-punning.c:10:19: warning: dereferencing type-punned pointer migh=
t break strict-aliasing rules [-Wstrict-aliasing]
>        10 |    return *(int *)&dummy;
>           |                   ^~~~~~
>    =20
> Note the -Wstrict-aliasing=3D1 option, w/o =3D1 suffix it does not trigge=
r.
>
> Grepping words "strict-aliasing", "strictaliasing", "strict_aliasing"
> through clang code-base does not show any diagnostic related tests or
> detection logic. It appears to me clang does not warn about strict
> aliasing violations at all and -Wstrict-aliasing=3D* are just stubs at
> the moment.

Detecting strict aliasing violations can only be done by looking at
particular code constructions (casts immediately followed by
dereferencing for example) so GCC provides these three levels: 1, 2, and
3 which is the default.  Level 1 can result in false positives (hence
the "might" in the warning message) while higher levels have less false
positives, but will likely miss lots of real positives.

In this case, it seems to me clear that a pointer to int does not alias
a pointer to struct t.  So I would say, in this little program
strict-aliasing=3D1 catches a real positive, while strict-aliasing=3D3
misses a real positive.

