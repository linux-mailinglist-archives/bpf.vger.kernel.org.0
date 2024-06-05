Return-Path: <bpf+bounces-31425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C4A8FC8B3
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 12:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24D2281CC0
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 10:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12EE18FDB5;
	Wed,  5 Jun 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xiq60h9L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RhPnBGbd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CC3BE5A
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582293; cv=fail; b=YaWaEt5D3+yBc386p4/MS8JWW8493fqelpWh7U++10Blk+H3s8gBhfVdIfrmy+BgU2Dp4Tnfh43kYvhRxAkLtBitUxYtfDh1CwkmBwBBMi1sZismnaBEE+C8JqL5H/UhqdSvKGKIjX9CmLeKnUOb+RJierrzmVvJDFZhagy4fRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582293; c=relaxed/simple;
	bh=bjiHbs4HREQUKcHx5w1or82CVc3toDFJ7hqOrzcD5IQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E5bt7v9UELvfNYkEXRYsIgPEJ8qsc52s54H3vSn1PlCNp84Docm6SGX6VK+TnCCNRVsCcNe/OH0by4+dffozXWjTerWgz32sAcTs1wO3VYI08Z4v62+1uGDlHdYfL9ZFp4ixdsJpA/3Q+1/70QyeyB/4nHbzpHdYFgLLgrap4c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xiq60h9L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RhPnBGbd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4551EXqH015634;
	Wed, 5 Jun 2024 10:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=p0WUK0e44+FQAr/zATSi+PIYZNVmHM6rxI0I2t05TpU=;
 b=Xiq60h9LA2bJxtkNcsYPv0mfP8dXyskeJLZxJCpX0vZdLjch6T/fkAo7/P8R5xh9oRhE
 w034MdgHsV0b82ai70QtymxPGZw8Aulg2+hnaGhvJwnfp0x0R5wJd5PGO0r+f5KREbja
 RB6hgx4b2qAtDf6zQsjmK8KQ7B2ger6VE+enSxl23VWVKPa75+uqBR7c+4jw/oim0pzu
 GEOd6jc4bDxeRLaPY+/OADPnisWWSpW8IOVoVa5KryCnzbfbksXWKHtd/AEVGmlCHTLa
 QrDHhiE0aAC5LIrMY5z0l0ypBstp4cEUrGiBb5ehuKqKopMvt2MIcIE7HeuYLfASnKLp VA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtw8vgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 10:11:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4558UjWt023970;
	Wed, 5 Jun 2024 10:11:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrqy225e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 10:11:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F885J6csRwAG2h/FtCMvFRCArNphNdyqImzRzhZALxqsedKraW/UldlI2iDEG/caG0AkL16W28wxB/bXj/FMyiXGmUAVNFMgXGpUJ+WvqgW+AuerpPgl3k4CWgANWsvIn68X8n5icDPQcha62dCpdDIWMfQUclm/b8z9m9jq0GUgF9a5eu5GLMxZFG/FGkhz5u+U6F3xaKw28gS1FN1LGnsvyXfbtIzk1wg4LtSqxbVENvVxw4Kp5LNXYLvfL2hRNVGIVy9JCqdZowauhsWQ6nYxKE0HiHd0DZTwBS0R3XW6j0VWVhGgd5/0xoBAxGB5q+SXYHZ3BO7f7nOZG6TvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0WUK0e44+FQAr/zATSi+PIYZNVmHM6rxI0I2t05TpU=;
 b=Yc+eS+JeWkpWGgLfktCivJ4TYfgu5FxcLruicINZWA3fdcN4ZBLyGeOcjOVnolsFIlWorhOxQ4bTLohKwIR3IHCcUh1fqN+jLaMtyXCfssSZN5pNvg3dZenNrGiOrzkxy88DGQGfKOsgMZjSw/yBMbuMkWxc1pwEbxvmBGHjYnT5JOFQu4IDitmaMGGjQ97hh6kw1VJTBALKLXAsXxfceyCK2J584N2F2AsxBc14i/Dlrhq1KfGmU5qhGzDVS+h6q209qLESbDXpXC0UBETH2bw2Up8jQQUUUIYS3aSidorvdvPgr8Wl84SIsR94RIJE/MlQNWtiqm85rRP05TiKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0WUK0e44+FQAr/zATSi+PIYZNVmHM6rxI0I2t05TpU=;
 b=RhPnBGbdOIwaV4W7jjRRFVmw3KP9JSrb99BT/jJPyif9rOlC2eEFuCuRh5zq7ZLQ4dLo6Ll0qjU5XZOTeyydfaSA+yIK8b+IAhCFvXqHEEmRCbDQ8dzxPgpvbNt/wALmvn+RKiHXoqwteB2bAN4+XHDPOQ7QXOHOerH0vHf0KSg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CYXPR10MB7950.namprd10.prod.outlook.com (2603:10b6:930:db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 10:11:10 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 10:11:10 +0000
Message-ID: <864423f0-d78c-46c8-8bb1-ca9b29beae17@oracle.com>
Date: Wed, 5 Jun 2024 11:11:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/5] libbpf: BTF field iterator
To: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org
Cc: jolsa@kernel.org
References: <20240603231720.1893487-1-andrii@kernel.org>
 <59b81a9f64e46583ad0f093551103752c1d6feb9.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <59b81a9f64e46583ad0f093551103752c1d6feb9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0390.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CYXPR10MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 325b61d2-1b92-4f3d-5368-08dc8547d2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bjNiQ2xjTmZpWHViNDIrYVQ0QlppRjJzY1pOc0Q1S3hqQk5ZTThZQ0EzeVF3?=
 =?utf-8?B?ZkYvQTRWY0x6Vms3QmRSaEZpbGhMWnNDa3I3RDcwV1VJaFRJNWM4VnFJZXZI?=
 =?utf-8?B?QzVTL2dMLzNka0kzYUM0QURDZy9iRytKZC9weElPUWlFSkdSUGhZZkZwVHB2?=
 =?utf-8?B?TkhQMkFrWEZQVEFOSE5JOWM1Tnh6NDRrVldUL0plVUhZM0tGR2I2YWtGWkYz?=
 =?utf-8?B?RGdMdVhJZzI2ckZRQ1VKQ1piSDhNa0ozMEQxT0VMM0UzWE1YQkpFTFN3NjN0?=
 =?utf-8?B?ZW0yQzVLdnNvdHl6MjRlUVVwQmZuTFdrVC9kREpoamRRTmkyUk1rOUtoVGRQ?=
 =?utf-8?B?NmxrYVFuZEs4MEVON1FzRkhyOUtNWXk4VWRNdVZDZUdzM1V1d0R2Q3J6KzZq?=
 =?utf-8?B?NzU2cjFsaHZzRmtQY1ovUFdieUU0YXpKdlpyVkptMm9HNWtvTUxCL0tJaTdI?=
 =?utf-8?B?NCs1emxwQjhKUjJtY1kxbGtCdnZxaDRKV1k1aXc4a205WFRCSEtnZUw5OTg1?=
 =?utf-8?B?VFBOQ2FmaDJnbk8wVnpvZzhtbWpaU0NESGw2QWNTV1psK2lTS1U4c3FDdGth?=
 =?utf-8?B?RjQ2dTlkRGJoV2tmM2tLWUY4di9UM2RrYVlOZFdscmRzTUhmRzRqRk9UMTV6?=
 =?utf-8?B?UkJ3ck9USzB5RFBaR3c1SFRqWWk2azJYcS80VUVnMXVZZHFBZUNYa0xSa2dn?=
 =?utf-8?B?RGdCQXZ3MG5KQysxT2xhSU9IM2RQQTVPRHV2UXdFaHMxSDhsWE9KU0hWbWFU?=
 =?utf-8?B?enlDVGkybklUQUhrc25Xa3EvWVhQOWZnbzE1blBWakh4UmtxbXh2WnhGTTI4?=
 =?utf-8?B?b2dTOUM4Nlk0S0pGYWRyWWVKczZqdTBWMDdNK0JWOGFTTkc2ZmhxVlFvVHNE?=
 =?utf-8?B?L3pXWjZJNDhkY2lxeEpxLytzaHZHTkR0ZzJKaXBKQ05lS0lMODJiditNUm80?=
 =?utf-8?B?TkNpU2kvSVZaUStIUXJIVlZVbWhWSkc0dlFzQ0M1bUx3b0t1TU91N2dvb1Vo?=
 =?utf-8?B?NzE3V3RUNVZ3NWxWS042blRnZy9BNVh4SkdvVis3MVZ4OSs3L0ttZ2xSclM3?=
 =?utf-8?B?bU82TVhIcXc1K0dhNCtOd1ExalNYUUs2U1d1MTBpemFGYjltdjJ1NkNaZVZx?=
 =?utf-8?B?c1k0d2R5RFBhYys5TUJrcGZUWmpkWkNHeXA1RzlaMDBreWxBQ3JUWHBuYmJF?=
 =?utf-8?B?Nk9mZmY1cXJmMmRLWUpSZDdGYU9wL3RVdlNTWTBFQXpzUjM0anNHZXZ3andm?=
 =?utf-8?B?bkJJdE9UTHl1bERzNCtSU0trSzVnMWZYYmxCaEFwTEF3RUxWejFGRVZqVXZh?=
 =?utf-8?B?UzQzWlR4OWd4UUwyRzNmSFUwUGhGNkRrdTJzY0UzTkMvNHFNclBQOXZJK3dY?=
 =?utf-8?B?SGg0bGlKSHIxUTJ1cktINlZ1YW9DOE1vcEZLazBveHoveHNuK3gwems5TWl0?=
 =?utf-8?B?ZmkzVjgyYUt5bk5lNXJNL1I1WmZsUzBMQUN3ZkR3OGtKTEJYK1R6Z2JWNVl6?=
 =?utf-8?B?eUZrZ3ZOOTFrSUFkalAwN2dveHVuNVZXcDBmbHZWeXZZTlFoQjB6anZLU3pu?=
 =?utf-8?B?THNuazhiVzIvSGFoNjRiMjBLU1pGNTdoUzBPdXNzeTJkSHliM2NzRmRTSHJt?=
 =?utf-8?B?d2puL0F3SkdjRzlneXBSbjIxY3RQYzRCQlc1VDVFQXJlVUhVeG9oaUlGbjB6?=
 =?utf-8?B?ejNpdUVKOWVnWDU3K3NGSCtsaGMzYkY0ZjIxNXpWL2hZNWNHU1R1ZW9RPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SXJFS1NDUjFHOGxMYmF4eEQ3UU5wL1IwK0luMUgrTU1nd2oxVGc4dDVMVTFv?=
 =?utf-8?B?YVg5UTBZQjN2SUYycDc5RjJaRVBSVTJkckpGc0lGRkdPTTR2WEduNDBiY2VX?=
 =?utf-8?B?c25XOGl5MDU5RHNDTkV0c2xOYlp3UmNsS01jeGlPbFl6aHA1SEZVbGkvNi9B?=
 =?utf-8?B?bkp0UTZnVGVFeDRDSk9nV3JEb0F0eVdhZ3NrTVZjblNJT1lQYVVMc3lvdUFl?=
 =?utf-8?B?OEFXbEtoTnBsOTRPcDZjc3lFQXB6MWVDWDk5RTQ0bTVHTkFWVlZja1Y2V2Q2?=
 =?utf-8?B?N1NmampKWlgrWnV4UW5waWhTbVAzSWNBTFQzbHo1RnVHTER0RVYzcHUwYnlp?=
 =?utf-8?B?RVlKU2VYeXlpQktOVHFDS2p0TWFzUGJEay8ya3I3SXNoc1dNNFZoV0tNQ0RI?=
 =?utf-8?B?MDhyT1lnaE5QTkhua1RnbmZLaE5KL29PWDFzS3E4cGZNR09UaFhwNVZVSVlr?=
 =?utf-8?B?U3JTRWt6L0swelJLYWVMSUgwZ2dNLzVjb05ocld3alhTTFlrNmh4ZktUQUdi?=
 =?utf-8?B?eG5VQlpuNi9UdjcwVUdSN3pxOXh4ZHJFNXJzeDRtRzluZ3JEa3AzUC9VS3J0?=
 =?utf-8?B?bUxOL3ZYdzZaZjVzSXIwM0tKRVN0OGV6bkVsays1MVN6T0FYR0NGOVZSVWxy?=
 =?utf-8?B?NTgyTEtZQ1N0bVpGZkZkTmNscGF1OFFhSnA3ZTk4UXFlRzN2RTJLVGFaVVdL?=
 =?utf-8?B?ZFU5NTNBbHVZMGVBdnF4dzJhcGZXd0tpV0l3am1GWVprcmNndWtEWm84RXpY?=
 =?utf-8?B?TWliNUFydFNpUm9uVUtpZHF2MzRqUTBLYmZ6bC9JMlUvbkxuZVRKaUJHWFh5?=
 =?utf-8?B?OE9iVnh5SUZTQmFTa1hCNWRiYVZGVEN4Mm1WdmN1d3M3YUlvV3lEWG53ODJp?=
 =?utf-8?B?QVk2UnJJQkczeHVQc1o4cmMveG44eGpmWDBhdVdoRGtRa25hYUxseEVva0d0?=
 =?utf-8?B?UndjYm9KNlFhRzJuM3E0blMxL3hnVmU4dGw4UkhRWTdxVTcyQ1V6OWtGOENw?=
 =?utf-8?B?THFiYnBqMWgybXI5Q3BxOXRQRTJrTnBYTDRrYWhmQ2NWZDhoYTExYUFZY2Fs?=
 =?utf-8?B?cEdBbjRCdEx6c0IrU1pUWUhMWk5rZnRSL0JURTVkNHZvNHFmMHVJRFhXR290?=
 =?utf-8?B?MnluODBCeHZIWmg3ZUoxd090NzRMV3ZLTGFUa2pMMTBQTzV2SUs2Z1p5empN?=
 =?utf-8?B?aGJsK0VzOHdxTnlSb3JISG5kbzNld0tQOWRUbi80S2pkemUzTnQ2QWRvc1RW?=
 =?utf-8?B?eW54M2llTDM3RndzbHY5S3pTTkZzckhVTE0yMHMyUXhPVS9BVTJUTVk2M05B?=
 =?utf-8?B?RjZhWFBUTEZvY3VGUksvS1RLNUxqUS9QU3MzMSs1dmJOWS9CUFVEOEVkUlI0?=
 =?utf-8?B?TVNqR0lNb1AvekoxSXNpOGVlV1Y2SW5QL3lpVzdYVzFWSk1xU1pSMjMvWFZM?=
 =?utf-8?B?S1FEb1FXZmw3U2hjWTZOYVNneW5QalhwenN5MjJPWG4zMWJiZThSY05adkkx?=
 =?utf-8?B?cEd1Um05Z1BwcldWcFEyNnpNRy9BUXI5ODZlSmxzazdPNGlzbEJvZ0QxcEZ5?=
 =?utf-8?B?aGZPNVpKdmNvZ2tGK1QvLyt0eHVPUHhmVnU0RjRUYTlwMmluU2pUVEVXN2xq?=
 =?utf-8?B?eXg4aTkvaTROTDZ0aGVhNjZSaFlmOHpQTVZPZGx4WFBZcC9USFZEQ0RLT1lo?=
 =?utf-8?B?a0xQaU42UUE3aFQ4ZE9uajBJOE9aSDhYTEVITHhWMEY5MHNNK2RXUUNzanVq?=
 =?utf-8?B?ekJBUTBaK1ZCd0p0ZGxHaDNvNFFySUJtOHo5SnBLN2VXMU1vVmxQSW5UaVZq?=
 =?utf-8?B?L3pYTHpLeTB2akI0bzRJR3pHUzRzMnkrRGZMSnhxRjR1aHJqa3FHNWRBb2dF?=
 =?utf-8?B?K2RlY3d6eGlJMEZoa3dPK0toazFKMkFTem45UVFydjd6ZG9FNFdPTzhha1BG?=
 =?utf-8?B?YzgxS0ZmVC9seFFnbDV1eDZjZFhXTmV4djhXV2xBTE5FYlRqOXVxYUx3Tzl2?=
 =?utf-8?B?b291cTFuT3BtMWpEbnA2Z3V4Rll1SlgzdlNRd2grQkx1QUtVWEQ5aEhyM3hO?=
 =?utf-8?B?TXlBdDhhSVpHUXpWVWxPVTUydU5mSUxYK2NCUTRUNGRZNENSMXRLd3FUZkZo?=
 =?utf-8?B?SisxckJuN1B6dm1lRFBXem5SWGN4M1EwZFhpL3drTFhnMTBXQUdybU96Qy9E?=
 =?utf-8?Q?4InFEBhsDEmCR6Hv2HPttDc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lTV1aviAuQfFTI2fgzKihCcSLtLiG5pzeZbGqkdPe09ZFi/rnPg5a/oskjvF5NDYO9IlHz9dTEN0mssnN9OxuTybZTYNCzS4OOUTc52XkLrPAjt66PKX5VEUdJM+YGYfumzbSKmNZM8Zd4WCDZjO7APe0HxqGBkBmdv+jg3D4X8kPXcsWG3+K3KFHqPy0qHpvSF3AV3iR6CnYhaWKlMWtdsGfZYtKmC3kv8TZ+kbgM3DZdI1fo3Ricj0EBQa/exu26Q3uKatAwmrw/i4y4l7CgbEa9Jky4z6pNDMWndPYniJK1FcGhj677gph4SXJH2NZi9MZmiApdtL3zEVW2Cb1DRYbADAZxbDscm+OkIHs4bZLvYj+ltH8YYM1PEFxAReWVHvgSE3IPZ22l5S0ZdC6El4+Avf9Hl3IUs27dRVjT5egGZ4SRDS8Vmh39mQpBZ7TSoHc2yGs/PLRS2qZO5ZISwZOH0Ni/zLIQGOIodVAEnx+8rKTrViWnczJMtHT9uKZjEzq1XazzvJDFppqNYg/VyX700EH6YYHuT/dLDWu7JTf+x9tTHHmAvvoOl0/cC5vJLT+IptLYNbxNfRJCwGSTps1+WESwdQ2UQX/5sLayE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325b61d2-1b92-4f3d-5368-08dc8547d2c5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:11:10.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wm8IZ3wQ8AOqXJg4snZeMsMqWhDvlwGzD1Mn16BbnhYcsJYoFI4StwF3A/465nrckFsKCtPqdBParavqt87F3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050077
X-Proofpoint-GUID: YVBBl-NJthxiM0IiYdd9ad5qE2Ke3gaK
X-Proofpoint-ORIG-GUID: YVBBl-NJthxiM0IiYdd9ad5qE2Ke3gaK

On 04/06/2024 21:56, Eduard Zingerman wrote:
> On Mon, 2024-06-03 at 16:17 -0700, Andrii Nakryiko wrote:
>> Add BTF field (type and string fields, right now) iterator support instead of
>> using existing callback-based approaches, which make it harder to understand
>> and support BTF-processing code.
>>
>> rfcv1->v1:
>>   - check errors when initializing iterators (Jiri);
>>   - split RFC patch into separate patches.
>>
>> Andrii Nakryiko (5):
>>   libbpf: add BTF field iterator
>>   libbpf: make use of BTF field iterator in BPF linker code
>>   libbpf: make use of BTF field iterator in BTF handling code
>>   bpftool: use BTF field iterator in btfgen
>>   libbpf: remove callback-based type/string BTF field visitor helpers
> 
> All looks good, thank you.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

looks great to me too; I tested and put together a selftest of field
iteration across all BTF kinds which I'll send out after this lands;
all tests pass as expected and for all kinds we see the expected strings
and ids.

For the series,

Tested-by: Alan Maguire <alan.maguire@oracle.com>

