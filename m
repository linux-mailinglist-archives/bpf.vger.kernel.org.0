Return-Path: <bpf+bounces-27841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2469B8B2871
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499441C20DD2
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1698312C7E1;
	Thu, 25 Apr 2024 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CHoIBW1h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DUGdUYuR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891FD39AE3
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070919; cv=fail; b=kTiDlKwoQ992lp67VAHd4rH426ETHrVg3Jpx/mS7tSsRblBYT5uSkbDTVkQ9VixD9o8ptb5n7FgZRanx1etr0Bc7haP8+Il/JitKkVdSItnTcG+pbLYGG3R27wPxyhs4XrwuVoTSFpxIkTcWxP6gO21gPe8VZAYrLioIvyPNNNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070919; c=relaxed/simple;
	bh=WLK9QRMsQGV9h1JAsB5XawP50dNy5jB9Ghvz3UY5Nag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Y/fgXuF8y/QyeoVPwpcds/Rn1EaRuI5snUUhcqRo5xUCvTbqX7oAKXhwk4qVEAQGpfFA4VK4RqjuzzNTXdbbX8nDZdcjDirdeIOocHEEFYxRvLFfop0HuEbfpfUbQNHY24pu7I2t7YIQhlOQzJFMxgREgAtlvSPPHiyqOb2mdhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CHoIBW1h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DUGdUYuR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PHOdJm004055;
	Thu, 25 Apr 2024 18:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=AZrpps0Rqphrlv6OnXSIHZmWkHXgMW+YvCS0OORSuKU=;
 b=CHoIBW1hhHuRbuWMJdMQNTZXvO5A6LskZZZPgD/TLZwNwlCC3uqTd5oJVAas+5xsrXAf
 v1TulBo4wWkxWzU0BSKTUyCvSF0Xgc4Lgx4d3XTgl0sSQvMU0q/rv/Qhazz+vP7kX1wY
 /RP6yaJ0qLdMygxDdct9Yfr3XjotyzEizJYcMwN/NZhnNq/SeJGuJ6nuujDLmeAjltW7
 TM8I4F5UJ/fly0y1iepAdapSlbG8MeUG+U7VWGW4G5zIEY/vJ4OnsX85VGPzExXjA1fe
 CfVSwZwMYokhITuFWxBeNr2iTAjaxFLTWO6bbwNVyILk1Ka/swD5wloj+G7d3MZVIxYQ ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2mpk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:48:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PHgO4I035542;
	Thu, 25 Apr 2024 18:48:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45at4u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k290dWPgDFIcivln7pwlF1nQfgj3sWzq99e1FO2j/pxO8Y0fFgJJ24cCtlNng3NyVt434NsWSzOv2LRHOAN3+jluQ7u2bKVnPu2jrY4NbCl1PBvZ3R2s9MTaJmazVvZpTIxuIxdnMA4WJBQMzc1HHA6erZfPCakgXUBr8rW1VZpKZc3O203MMwd6Xl8I/eQARmRMejLVYwQ5ckmHVURLp2EOozN+sckdbk9lE3o2vDqsN8bEWoAw5KM0EhSj5KWkxkRTdqbtsEUpOm3HRwpAMfDHFvfJ4Ae81jugkb+aWSxmzKiG5shU2JcwgLrIFqFiHGmVh4F8AHzSKuKaz1kgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZrpps0Rqphrlv6OnXSIHZmWkHXgMW+YvCS0OORSuKU=;
 b=goj+Kb1lJwYzH2Ns0s5yZx98XYs0D3Eb6T1Gl9sxMz7Os5Mpw9CiZgxFU/osUP0xM+jU0HBwlgMeV9cDyESaBknM5keZQhfpEmqdw6IJOgl4f7VcHbkK0rYVVMxFPlUHbL5d0I1lALdncsIVhj0VvKVv0gerzqlzzUZ0UHVJtRIwCxiGn+e7OSYCvsgpDCAwe7E/R0yLyjZxI54FRCozggZ4UrTriqQt+TtUK5vv379j/sWpPiMjSINsNURYShFphXF0g+NPMkLZDgMMFep9hp3dlYRTb2aY9PSQrt+QGHqrXpdlw5VMEL0/S2srP4axI/3I1UIIuhjw1m8AuYx3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZrpps0Rqphrlv6OnXSIHZmWkHXgMW+YvCS0OORSuKU=;
 b=DUGdUYuRFsnDWstOTr8S/aGATOoc92FjlcsQ2QSOKDmEmHGcEcT386bxY40R/h+TnvM/BlHuJ4gt/qTEnA+jC1w1w9fr79HLdpTRYWydNpZRoJU4ZfTTqjrvoaSRjHGpjUN0lek5cJODfk7ykEpv50O7yH7dyDfV3fgIh5Rju4c=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 18:48:22 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 18:48:22 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song
 <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
        Yonghong Song
 <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        David Faust
 <david.faust@oracle.com>,
        Cupertino Miranda
 <cupertino.miranda@oracle.com>,
        indu.bhagat@oracle.com
Subject: Re: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in
 selftests/bpf/Makefile
In-Reply-To: <CAEf4BzZqHHx22c=k88A4oa3+afQvk6ph6SB4Zq1tHJ1sOhpv8g@mail.gmail.com>
	(Andrii Nakryiko's message of "Thu, 25 Apr 2024 11:20:18 -0700")
References: <20240424084141.31298-1-jose.marchesi@oracle.com>
	<744420fb-4b2b-44c8-9e35-1ffd9f086fd9@linux.dev>
	<87v8465u8p.fsf@oracle.com>
	<CAADnVQJzLzrxtHeVcpNBtb-rnwWfApFEy_kv7LzWDee4pH1ezQ@mail.gmail.com>
	<87a5lh4o7r.fsf@oracle.com>
	<CAEf4BzZqHHx22c=k88A4oa3+afQvk6ph6SB4Zq1tHJ1sOhpv8g@mail.gmail.com>
Date: Thu, 25 Apr 2024 20:48:18 +0200
Message-ID: <87a5lh6zyl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO3P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::15) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ee22ff-506a-4aff-9a24-08dc6558480b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q0daYVBMcDd5aXpHUDJHcGRONjZjZFBvRnAyYkY0ZFIzdkY1c0dkK0JYWHJj?=
 =?utf-8?B?TXErMHpvQkVjcTM5Z2RlYzFuQ1hzTkNKY1ZMOVBZK1dIeVV1alA2anZUS2Ja?=
 =?utf-8?B?VHhoeGUwTFNKTEFELzJLOXNycU15UnQzQzAraUVIZnlXZFNuVW41TitDZERp?=
 =?utf-8?B?RmVBc1hmTVFLSGx1UHRrdFppUzg0ZVFteVFQRlhWakJqTmY4K0hXUW1Wa01j?=
 =?utf-8?B?WnpSZW5CR1F4TENwYjgzUi9UTUFCL1RYNUFPUE45citNazE5dDZjQWI3TEU5?=
 =?utf-8?B?MzFrNWVTMk44WWxXSEVqeFFpSmQzVzlLTGhZeTBjV0haZi8zdHJaQVpIdmpR?=
 =?utf-8?B?QnhVWXB6OU1KMmtuQXRnRUpSV2RIeElsUWo4Ykw1bnRzbW52UlJKb1NnU1Vk?=
 =?utf-8?B?L01oQnIxSEJlc2hndWFrSFA3OGdFK2V3dFZEOHZzVXNzWmxyYVVjSit5QzU3?=
 =?utf-8?B?cXIvbExGem5IU0xRdmlqQTZXVUNwcjFoMW1NcWZzanV6SDFuWFVNbVVXSzRr?=
 =?utf-8?B?STBVS2FESXFzL0tTOWFneWtxYmp2NDFpU21WakZ2UGNLU1RBVjNqVnJBMEo4?=
 =?utf-8?B?TE9HZkhpOUVMZ2plYkduUjEvK2J2dTduYVM5WTZ5UHROV3hvdk5WUjdoRXVo?=
 =?utf-8?B?RktzM0lDSU1icDhNV0VRTWVreWoyUy9XTEJYOWMvL0k5ZHNJdlJuUkxtVzNY?=
 =?utf-8?B?blgvd21maWV5N1VwRXpURVZkUjBpSjFwQ1dQSW5FNUFnZWYvbHBubjVXNmt5?=
 =?utf-8?B?TWQ4UEI2TGhxMENoVWFzQmFhdFpWdERReWVaZG1GZWdrWXRzL00rK1pBM1px?=
 =?utf-8?B?VlJCblZmZHN3aHZGSHZqZExYSHVlRndsR3VZbkdVMGpaZFZJdkxGMGtxTXRI?=
 =?utf-8?B?L3dhMlB6MkF3ckp6TUZiaFo0Wms2TFJIZURlS1FIY1A4bEk1MEwwc3FpZ0tW?=
 =?utf-8?B?bzRuS0dOV29kbGYvcEpGbEYvMkpPQmpvUGtuRXBEZTk3T2dWK1hndTF3ZTha?=
 =?utf-8?B?VlgzLys2eGtIdURmNU01cVNOc1dSTEhReHlaZm9VdEdodHV6eFBXMm9Ua1ZI?=
 =?utf-8?B?TjlabXVXamNialpkaGhiKzQ5YUdrNy9TcGZZcmlLSERSYk9wWlVBUU5zVUVy?=
 =?utf-8?B?eVdGVmhaNHhQUjFrRjlKTjFZZkJSMElKWXV6SENFSlBZaUZEbE05UHhuV3kr?=
 =?utf-8?B?TE5tdVdBS2VjQ0I1ZS9LRmJESUM4bWUvMzdFRFVFYWk2NFVIM21MbitISDBl?=
 =?utf-8?B?R1NnM1N3aUNpblkxVmhzS21vbVZWUEZ3K25aMFRvNVJ3SWVBWWdvQndQb2tS?=
 =?utf-8?B?U2NVUGJLNGtlVHVJQUt0R3pPZ3RHUlNWem5GNFpVeDRVd0NLN0o0NGZoOGdC?=
 =?utf-8?B?UkQ5MXVoZEFrMFJKMzNhYXpVd0VRWDY0UXBCNUVQSUtjYXhsZmw0a0NxWmZ1?=
 =?utf-8?B?S2tQSEhSUGJRRU9uRS9pV0JUOEwrcWZHNEFhSkdLN2Y2Y2xDY3JDclRTN0Uz?=
 =?utf-8?B?K3YwbWpGV0JTZklYWkZPZ2hacHloSGpFSTE0SDRnV3gzV0hoQ1haRlF4VVEx?=
 =?utf-8?B?WFdrUGtrOWVweThxdGpRMC9VQm93WnVUeWEvcnlQTUpUeCt0d2I5UmJoWkJa?=
 =?utf-8?B?TXVYUThKaHd5WjZOdkl3ekRIN1h1SHE4WHFCc0orNG8vcGFsdFo0UVY5dnZ3?=
 =?utf-8?B?SjFDYkRBRUc2SzVQVHM4dVVpbm4ySGlOSVdUMjZzcVV3Z2pUcVlkb25RPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amdnUmZxcVNpN3R2d0YzbjM3S1JxNTJSalpxSDJUWGs5YUIwRzU5UmUxNU5s?=
 =?utf-8?B?ZHpZc1lPcytQQTRjNWk4RGIvd3p4Q3BTdm4yUkhQYitVWkk2SitPODVhYU1V?=
 =?utf-8?B?MDRiWTNJOUw1a0hJMXlUTnNLbEZMclAxUk9YaEFKY1hjTjIrWkY3alJEeXIr?=
 =?utf-8?B?RCtqdlNZZEFZeE90ZjRqcE5uU2xWSUErOTVkR0VhdURBbjRuNkJJQjdsSUJl?=
 =?utf-8?B?NnlCVUF1eUowczFJcUgvbENzK0JOSDVGV1NJSjZCdXJEcjh6ekNpYzJXRDBn?=
 =?utf-8?B?RGIwanlhVXhtQnJKdUxlZFBlLythSmR1Mld6REduT1lxbjUrOWc0YmVST0pn?=
 =?utf-8?B?cldJSkhxZGhZb1FpSlRaVXVWTXh5R0p0UFlWU25Fa3MzdmE2U3MrcUx6N2FJ?=
 =?utf-8?B?ait3c1VHVFBjbXkzekNFNEYrY2pmQWZkWXQyUWFPdDBCZWNndHo4TTAxOXJT?=
 =?utf-8?B?ZXZqalFLTWp3OGFTZloxbmE3THRVR1BwekNZS2pRUFZleThlSkxXWnVQSXpM?=
 =?utf-8?B?Rkg5ejQ4Qjh0K3VzaUJCQWFkVHpkMExxNis0SkloUTBxUlQ2U2xuVGpDck56?=
 =?utf-8?B?ejFrYWpZaVh0UzZhemIyWGR6RXhha1M3WnUvNFhZQnl0bXdvVmVmTCtlaEJE?=
 =?utf-8?B?d2N5WEJNNTdSaUVWZUE1QVV0YTV6eGlnN0NQOENpdG9IazdhTlJEOVlpSkM5?=
 =?utf-8?B?ZGMrS1pVS3h5YksrYi90WWRmaTE3c3cwdk5yTXNHY2JEcThtWTBHLzhtRWxF?=
 =?utf-8?B?cklGbk1yWnZoeUp6N3pjeUZvZ3JWVzhEWVY0VEsyTXlPc3FTazMveUVEYjJu?=
 =?utf-8?B?ZnUyN2pTRlVBY2dEV0FVK0ZNYkRzdFNWVmlLY1VnS0JCUFlCU1pDSUxyTnFF?=
 =?utf-8?B?d3hIWm1EeVNRNEc2aWhnRnJSL05SQVlxbXdsc3BuZWZYUnZ4TkZQY2pIVzQv?=
 =?utf-8?B?cVlPZ0NoSUdlOWVsNFRqOWt0ZUZFcXB5VTJ1Y2JXVFdyQWduRlVTOFBzWHNs?=
 =?utf-8?B?SFJ4YWluU216M0g5cGNtWXNWRTlXMDQxc0xGS2dhL2FHN0VpcmJlT0tqSzB2?=
 =?utf-8?B?ZUR3RFVIT2hVbDZjUVdPMXZJdnJ4cDBzU0dLeDVZZTB2M1NWNGh3dnJQVUpv?=
 =?utf-8?B?b0NYR2pNRmF4d01Lc2l3NzV2V3VoQWpuZk81djBxd3lxYlMyQVcvVS95U25M?=
 =?utf-8?B?VVVjY0hWZG9nT2JDRmdmc2ZRdVo3MkdYS2dINEZjK0trWXMyYnVEcFZlV01M?=
 =?utf-8?B?QWZhQ2R4K0ltbU91andVejVSNnRra1B6Ym5kNGpRK0twaXVjbFVWK1prZGRT?=
 =?utf-8?B?Tm1VQzVYdWpvWXVDMzJEbU95bm4rbmsyS1plMVhINDg5bWZ5SWY3V3R2SzJ1?=
 =?utf-8?B?SDV2d0x3UUxVbWIza0MwM0xHQTdsalp5QUsrUzZ6dkVKUThkckdNejNub3gx?=
 =?utf-8?B?QW11WmoycUFaVjBiL0k1aVpmbU5HUDY4Vk5MMTJiQS9UNEExaHQzMmxYTmNu?=
 =?utf-8?B?YnF5bU1BMkduQXMyNXcwemZTK0xzWjVnZDdBem5Qem1oUmIwbktpandDMjFv?=
 =?utf-8?B?MWpQdGJ4UktiKzhnMGU5aWFpWUtIeEVLT1Y4RGZBdmNOVE5lQWd1dHc3MUtv?=
 =?utf-8?B?bWhCcFZSdW1QazVzMUZkK040Uk1hOE9LNlNNWk1Bd05yeTF4QUM1NiszbkVY?=
 =?utf-8?B?ZWNEb08rV0ljQXk4NEZMNjZFQldQRis3S2F2Rm9uN1U1YkxsTERqQkV1NEI2?=
 =?utf-8?B?RWVNV29oTnZLdHNHYXphRWxOcVRxaWQvWUZnVTJHdEUwRXZkbStUNkI2bFBL?=
 =?utf-8?B?VjBOT2ZuS2JEQzc5SzVWQkY3cEJVd1FQNVFua3daQ3RhRkF0QTludm80OFky?=
 =?utf-8?B?bDRDU0wxcWNUbTJZT3JTM08xOFZXOHN6SjZMaDJWTlVVaGdaN0Q0NG5qT2dv?=
 =?utf-8?B?T2RpRGVzdDBETUlRcXl1UittcUMyVGhBVkNaQWNORjFzK1FOOHJUTlV3cHY4?=
 =?utf-8?B?TVdmT2daUTcxNXVUL2tkc1VOcDJnKzVGQlRtOHVCZm84Y05IbFJDejlIdmU5?=
 =?utf-8?B?TFp6MHBBMXVkSXV1aHNqOHdYOTU3SW1rQXV5SnBFaEVaS1NzNkdPd1ZJN0p4?=
 =?utf-8?B?WHExVDJXSlQxdEtNeVdJTThlOGpIL29yTlJiNzE5d2JHUmxsZFRlYlBCV1Fa?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xOl+ZZjGOAgJB6kpyTiT3q+CdOlbR29H/F7txqD0+mJ+xx7pZde9WsQgzbWdkKmbZF8Qz/EnaoVcDTYoEGaraPBFDBqci0S5Xg9T0rjGF0fbDgGoZafC2XB6RJZLsmX8XPEqK3d0IIleLLifmRfuALWmPHDSZOw29WVkhNvN5SkPKBH+RVEmzTqZEmXOUb3E4afNb7xhkgu+LvHxqeCVKK7bfIreV2sxiWi45Xidvgbr1XvEBmXzgeH2h4kF4Y4MFkthFbpncmvQfsr6Ym71sI3B1R4ijVoZaJj3d8TqoSo9tIDC/SPNTxy4QmUV4TcoKouXvz0UKiT+uOUo4XNY6gesXkv1ovztSd1H2EsYk4kwwsUT9m4tOsIkLO+Y8A0aJs5KG3Xf287VyaCkTUMRZKjqwoHEBpCCXzBlPbqkeGs2eLMJ+jSsD6bA9wobLgEOW6yE8XT6l9XgpUVlEcPv1njp6QoosUgnUM3XK3c7RkXbcRjwtU/zsAC/ourGf8OaJfVuh7NVmZ08SnVvwaiixaD2qicvOKshi75iolInZ9WoK++omjjOni7Tu7NK/e4WbDZ0fSA+dnBS3PpWBCWCDb7NJ+veEGumCvIOVvqXVws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ee22ff-506a-4aff-9a24-08dc6558480b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 18:48:22.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoQLQPFuSSa1nCHQs4iNDJJHWAo3LuOKNCDp/YUhmVSINDeEJa1YPJsJ2VO2V0sxlarlWsllAKI2Q2BBftZkhTDxrCUm9LGxcUnd6c6d0J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250136
X-Proofpoint-GUID: RacAo0h9TReyaZeV830R3pipxUZoKqRp
X-Proofpoint-ORIG-GUID: RacAo0h9TReyaZeV830R3pipxUZoKqRp


> On Thu, Apr 25, 2024 at 5:33=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Wed, Apr 24, 2024 at 2:30=E2=80=AFPM Jose E. Marchesi
>> > <jose.marchesi@oracle.com> wrote:
>> >>
>> >>
>> >> Hi Yonghong.
>> >>
>> >> > On 4/24/24 1:41 AM, Jose E. Marchesi wrote:
>> >> >> This little patch modifies selftests/bpf/Makefile so it passes the
>> >> >> following extra options when invoking gcc-bpf:
>> >> >>
>> >> >>   -gbtf
>> >> >>     This makes GCC to emit BTF debug info in .BTF and .BTF.ext.
>> >> >
>> >> > Could we do if '-g' is specified, for bpf program,
>> >> > btf will be automatically generated?
>> >>
>> >> Hmm, in principle I wouldn't oppose for -g to mean -gbtf instead of
>> >> -gdwarf.  DWARF can always be generated by using -gdwarf.
>> >>
>> >> Faust, Indu, WDYT?
>> >>
>> >> >>
>> >> >>   -mco-re
>> >> >>     This tells GCC to generate CO-RE relocations in .BTF.ext.
>> >> >
>> >> > Can we make this default? That is, remove -mco-re option. I
>> >> > can imagine for any serious bpf program, co-re is a must.
>> >>
>> >> CO-RE depends on BTF.  So I understand the above as making -mco-re th=
e
>> >> default if BTF is generated, i.e. if -gbtf (or -g with the modificati=
on
>> >> above) are specified.  Isn't that what clang does?  Am I interpreting
>> >> correctly?
>> >>
>> >> >>
>> >> >>   -masm=3Dpseudoc
>> >> >>     This tells GCC to emit BPF assembler using the pseudo-c syntax=
.
>> >> >
>> >> > Can we make it the other way round such that -masm=3Dpseudoc is
>> >> > the default? You can have an option e.g., -masm=3Dnon-pseudoc,
>> >> > for the other format?
>> >>
>> >> We could add a configure-time build option:
>> >>
>> >>   --with-bpf-default-asm-syntax=3D{pseudoc,normal}
>> >>
>> >> so that GCC can be built to use whatever selected syntax as default.
>> >> Distros and people can then decide what to do.
>> >
>> > distros just ship stuff.
>> > It's our job to pick good defaults.
>>
>> Yeah it was a rather dumb idea that would only complicate things for no
>> good reason.
>>
>> The unfortunate fact is that at this point the kernel headers that
>> almost all BPF programs use contain pseudo-C inline assembly and having
>> the toolchain using the conventional assembly syntax by default would
>> force users to specify the command-line option explicitly, which is a
>> great PITA.  So I guess this is one of these situations where the worse
>> option is indeed the best default, in practical terms.
>>
>> So ok, as much as it sucks we will make -masm=3Dpseudoc the default in G=
CC
>> for the sake of practicality.
>>
>> > I agree with Yonghong that -g should imply -gbtf for bpf target
>> > and -mco-re doesn't need to be a flag at all.
>>
>> We like the idea of -g implying -gbtf rather than -gdwarf for the BPF
>> target.  It makes sense.  Faust is already working on it.
>>
>> As for -mco-re, it is already the default with -gbtf, and now it will be
>> the default for -g.
>>
>> > Compiler should do it when it sees those special attributes in C code.
>> > -masm=3Dpseudoc is a good default as well, since that's what
>> > everyone in bpf community is used to.
>>
>> We will try to get all the changes above upstream before GCC 14 gets
>> branched, which shall happen any day now.  Once they are in GCC the only
>> extra option to be added to GCC_BPF_BUILD_RULE will be -g.  Will send an
>> updated patch then.
>
> -g is already passed through common BPF_CFLAGS, see Clang rules, you
> won't see explicit -g, but it's there (all those flags are passed as
> $3 argument)

Didn't notice that.  Even better :)
Thanks for the hint.

>>
>> Salud!
>>

