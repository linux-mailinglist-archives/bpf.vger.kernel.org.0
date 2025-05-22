Return-Path: <bpf+bounces-58728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB0EAC0F01
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 16:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94247502581
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB1C28C025;
	Thu, 22 May 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="es+/JTcT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YZhKGOcp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A828C875;
	Thu, 22 May 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925652; cv=fail; b=KgVUjcJk1JGNKz0hPmHzr7AoWl7ScY2XNJStSMsA8i/XMNhg2ZRHw/zL49HfIVuClSFkbSFXzfghD6FgYq83v8V4UVXmi5HYI9+kmyvqcgo4r1ISXILits/UedCPeokTOwAyrhhE/ITkZEtv8K3jCXKgkhpgN7akyHuGZKhvZr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925652; c=relaxed/simple;
	bh=e+8zkkdmqPEF4ifs9nfc+81a/SKgehHSjsPE720ZLEE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ip1Zcz52KVHGSBhpKK+Y7qdkEwDSjueqYiKras3LFbTPyGdazXkPw9ZZUjg8aY2rmtSYcb0NGIr1Hrgh6F5RDBwULiOAgqNc6eBdDHeliZeNBaLLlTgCNgK9XcvpOQ7gXFDR8ExzZ2uhbP7qmSSkD5xmEles4uH+NzzID/up83w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=es+/JTcT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YZhKGOcp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MEmXUY006834;
	Thu, 22 May 2025 14:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nNhlSWLFb20ZHDzUGN63H/4YUZU5TqwJdsv/1OuSF5I=; b=
	es+/JTcTs5jI3rr5h5CwYVFd7ZSPWoZebV84i8VSbttjYYYE7HlN1JXPL+BuBlub
	K2adESoWkpDV4bGSeOFV62YyrUlFvNklAH3QlL2a5ZCFimJXHSRg6mDGJFBr06B/
	mXYQeWSXL1BuHyBpeHC81i97Q2eZ+iwM1Hc8fjMS7IBKhXIcjhKdIjrV0wo3axNm
	lP2nj0wBXrJTEfG74BV4SBw9QArEBR0NcuVw89zwBIRRaW0E2utQwMH91G5xjSVS
	IwK6M3tm7jsyETdXgs4sjkjByFbB0P6dAjURgJqZ2plPu5jb6nOnw2+4WYY3/eJf
	SVfj17aKatdz+wuNRyX86A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t5b406qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 14:53:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54MESGrv001756;
	Thu, 22 May 2025 14:53:44 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwets3gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 14:53:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+rZ0CdmrvK4Db57zjRBcrOqzoaXtgAyKyHEux4H/irBkz6GJ+HMOlwEcjznXnR9Q9C7jo82f3AyvPQZ/h6nJa/9p0FUoSAU6iB1xueat3wiTSwr+lwbdm56otD475iTsNseaNZNZUoVjNfwE4PggFiDUX6l7b+sfZ4dQ/7THx2kreBkAKgYIA40iH0WyV+J60eSCG7/TrOSfydaD+4J9hzcbbBYl5e6qiO1FZ9H3wZs4DLVQUaKqkn/15I1eT/7oMTM5QzhlwFZfE/2CiBHAEZjmyPnVS5fBuXdMHimG8xvBZe+L/3Wj8pwODEsSYnZYVyNsR2CyDiG8F/rEPn/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNhlSWLFb20ZHDzUGN63H/4YUZU5TqwJdsv/1OuSF5I=;
 b=qPMlqI16AdLHW6XbPLMMkKib7laSe15FXcSRvBuAs9aFSbe57MNv9sl6mUDWDt5YLIHLg5NDMpM4Xb3nyiKm9COE/tXMgZNnxf+5FeHPp3trR4HL9vzyMiiZ+7dSbWF+ybNcjjZDxClze6jMDOZDkd/qy1jStzG0JyEw1m/yBiUmf0hJfaqSczWFwydiJise5CL7yO78PyC7s0rvEWKsbrY28OFRZFso9drI0VPFPkrstOHn+iHYls9khpEe+uPhPYvk1urwi37C/l5zGHtcvnEYanIwSi0H5TTV93AkTxDF0cAg9FaZHwOYP/g6nJxulfpzXl48vHkTYW33RWhFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNhlSWLFb20ZHDzUGN63H/4YUZU5TqwJdsv/1OuSF5I=;
 b=YZhKGOcpVBs3gRsVjknyLwLlvw7i4SwO9yAuErMDV3DfeGE0dwXvZSZZ45z0iCd1PiqMF6VCiCL+Qy4+lUmUYeA5xbrmXjPKrHEU51W6eOk3hHEawLe6pthOSgHsUEWx1OZ+9g60BUlm0mOx3aWwoZXL115+Sgz7NNIsvnrAuP0=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CO1PR10MB4657.namprd10.prod.outlook.com (2603:10b6:303:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 14:53:40 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 14:53:40 +0000
Message-ID: <d288da56-2f5c-4839-bb0f-de98d2a6bc81@oracle.com>
Date: Thu, 22 May 2025 16:53:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2025-21997: xsk: fix an integer overflow in
 xp_create_and_assign_umem()
To: cve@kernel.org, linux-kernel@vger.kernel.org,
        linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Fernandez Gonzalez <david.fernandez.gonzalez@oracle.com>,
        Denis Pilipchuk <denis.pilipchuk@oracle.com>,
        Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
References: <2025040348-CVE-2025-21997-492c@gregkh>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <2025040348-CVE-2025-21997-492c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::12) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CO1PR10MB4657:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfb5ec5-30d7-421f-3208-08dd9940708f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVIrUmM1WUVnSm1qZTdhVkNFc1ZUMFYrTGdQVldpWTE3bE9USTJMdTZ4WDkv?=
 =?utf-8?B?WE81Z2NQREMwOXZrSnR2ZEtZMmZKRmRlZ2lUL09Ock5HMk5FdXNiUEF3YnY1?=
 =?utf-8?B?VVlLVnI3QkdjZVJpTHhuZDJlUVBsVFdocTk5blpnQi9paCswK2d2cyt6OEx1?=
 =?utf-8?B?N2ZaNHNuWTl4dm5oeXNQcFhGdDh0YzhZUDJTblR2Nzg2RUk4VFYvODFMWWtj?=
 =?utf-8?B?U0o4c3ZoSkJ3RVRaTDBDYzdRZ2xqSEd1Yi9HQm5TbGtZcm1ET2FNbmhFNWhu?=
 =?utf-8?B?WTlpM0VtWjNwWElkMFpaOVVyLzJrbGtjbTlOWElHQlBYVzNBd0xyZWRXR2ZW?=
 =?utf-8?B?aVRzQmltcDNGQkxLQW1OcnZnTFRaUGd0UGt5V25nOHRpRlRLaldQa1JCV2dh?=
 =?utf-8?B?VnFxbnpRbkFPT3oyN0doMEFyWXg3eFB5eFVsRkNtSVBVUXMxNjhvQjdvc0hz?=
 =?utf-8?B?SFVNeFpGSnBkMlFTUmFUcVlUa1RVTmhpNXF5Uld6am1IY1k2S2hQSGIzRkJH?=
 =?utf-8?B?WWt2bGVPTWNpVkZJM2gwQlcxZG8yTlF6TUh3eklmVlR5Y0lwU3VGYmVob2s2?=
 =?utf-8?B?UklucWRYdlh5OHhJMjRMbnVJcjRFbUxIdHZHMlE2N2R2U1E1RHV3OFFpMjJ5?=
 =?utf-8?B?ajdLOFU2QXRDdm5QK0wrS2JSRGdLejBiOU15RURmTEhOcStGdVQ4L292R2Fn?=
 =?utf-8?B?cWlHbTJXVjdnUGhxeUE0Z0dyejUwSG12czNTN0JwSjVqOU5KOFJWcDJNNi9q?=
 =?utf-8?B?ckdnaEhuTmVPdXNTdEJwY09xd0F0QTJLOWlqdlRvM3l0S3hVRGRnMXVaNERQ?=
 =?utf-8?B?UzNjc1hPSGlBdWJkcFNQWlc2MjViMkpjM0xLOGExMUZ2eDFHNVJLNWZia1Ba?=
 =?utf-8?B?YldyZERvZG8wenZzb2dRSlZuMkFJdHEvM0EvRVA0VGxDdElqdVVlWVB1WGFR?=
 =?utf-8?B?dW56Ky85Znk4QXlyVHF1VmZUV21OSWJpUDQ5c1pwRGxlUWl4eEVZT1IyY0pI?=
 =?utf-8?B?QUJTR2ZDN3djQS9OLytEOHZSWTF3akVLMHg4bWpITE9hbzlVUkhERUJRYk9q?=
 =?utf-8?B?V216UWI2Tlg2UXVpbExNMis4UHR5c1lSZFlsbzZtUEtqWHZOVi9kZGF6N2Rn?=
 =?utf-8?B?NkQ1ZGUzVzRjSTNpelZMRlh4a3FPaytrdloyeVFpRWdrS3VqeDIrVDRPdjNW?=
 =?utf-8?B?QWN2TWh1cnFJd3VpcGF0VUgrbUp1aFVmc3I2YXFnQ2Z3R29ZMjB5TzFOR0tQ?=
 =?utf-8?B?VVFZQURkUXJWektpVjdsWURuWnhlc2RiN2pzaFRadDIzcHpUZVVja3R0bWdE?=
 =?utf-8?B?Rzg2djVUL2hxd282VXVhYU1SQ2N2b1Y2bkJUZjJmTUdEZXhlbFRxNG13SUdV?=
 =?utf-8?B?NjJXOGVtNEEzQzlEUjIzNUxmUkRIVXQzMmh0cjZ4c1dPYTVzQmRtWFRGS2xG?=
 =?utf-8?B?eHliYkJNYTV5c3pKcGsyVm1xZFVVWlBuVDA3K3U2WnFVaXNLcThqNTFBbmVM?=
 =?utf-8?B?V0ttUmxGdnovd3YwQ3JsMTBPZXlnMlg4YXZubnM5RXFvWDNYeG00SE5KZm9Q?=
 =?utf-8?B?MldKUVZlWThNVGl4UEtPd2lVb25vTU9Wckk2TE00ZTNjL1c3anU1WEE4alRj?=
 =?utf-8?B?OEZYODBQczBrQS9nbzZJSEl6MFZ2dXYvTEhtMUVyeWVWUnNRamFsNFNqU085?=
 =?utf-8?B?bENFeTdKMStwUWUxeXBRbzFwVzZWNWlhenJYNk92Q0hjdW1BODVPRnovVC80?=
 =?utf-8?B?OHcvVjh5Z0hiblpjR3YvY0MxTHdJeDdQTmI3em50SUdmZERwTFlZUGJrUUR6?=
 =?utf-8?B?Ums0cTczTXJFeEs0cUtkUHBSaEo2RUhjcG5HVnJDU0JxVHhUbzVWVkt1VTZl?=
 =?utf-8?B?RzNTM2xIc0d1QnBLdzMvd3NOMllEWjdFNm5WQlNzcUZIQ2Njc3FNZ1RhMFkr?=
 =?utf-8?Q?z4qeo8CKiRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3pFV1cvZkR1clowRUxFNXE5VTJWRlBRbVlpblp6RlI0L3h3Z3FvOEpacVh1?=
 =?utf-8?B?dyttbGpRS1U4cDhiTXFLdnl1QzNpYkYrbGJWY3dXUlk1Y3FuNnFDbXBwQzFr?=
 =?utf-8?B?dWcrNEltYlVTdlltQ1lGVzR6SzlBeUtpSFd5Q3pWbkJFd1p5aUpNT0RiUTI1?=
 =?utf-8?B?Qi9naGkvNmVhTWNodFZvUHAwUVJZSmJkakdOZi84Nk1wbU0vZFlTTnJ2ZkZx?=
 =?utf-8?B?Um1KRWQ0WTkvbDVHbDFlZ0orM0Q4OWVSNjdSLzV4OVk4ZTdXTTQvb09sMkx2?=
 =?utf-8?B?b2VLbUYxU0xueE5GYmQ2cW8xZVdiUGRMUGhsdmtzZWJzOUhhV3RmeDRMb0hJ?=
 =?utf-8?B?R0xuOS9Jb3psK1RxVVVMMXlUcGJDaE1DaStCZ3p2bm50UkY5Mjd0eTd6Z3RB?=
 =?utf-8?B?UFcwNjZyWSs3OUEyMFRtRFJtQ2lDUTAzS1pPNTNYc2ZRVnZQVEVoRjVDSWJO?=
 =?utf-8?B?VEp5Wjh2MGNYemRZUDR6NkxBZmlNa29TcE9FYkF5ZWM2YXorYlFXdm5vUW1X?=
 =?utf-8?B?WU0vREN5elJSUit4SHZQNUpvRUZJVnNFckRGZUI0SlNVMHBUUE5kYklwUjAx?=
 =?utf-8?B?SkVzZnE5OVNpQXdZbjlnVU1TL25aLzVNRjdnY3M3K0hPWU5LNVVlakluNStT?=
 =?utf-8?B?NTF5c2VPeG54S2tMdWxuM2tubVZ6UmhtV1czQjdsNGl6bVAxREFIMHRycUl0?=
 =?utf-8?B?T2lvS1o5dERoR3JyS2wvNXhjUzJZNkNwdWg1ZDAxbU9tZ3pteHRBT1F5MTdK?=
 =?utf-8?B?am16WHFPdGFxUkoyYWY0R3FqVjIyUGZFbzNzV3gwVEcvUHhjeG9RVERYbjhj?=
 =?utf-8?B?U1c2bzhiVkVuVmlZWDR5Nk9oc2EvN1NCWFFYNFlMdzlxUFloNzlKU21wQWxI?=
 =?utf-8?B?M2ZaWUNJVXpyZjlIMndnVzZIRTVrSEJXem0rQXl2Qy9PQlhRaDljVHEwWGpp?=
 =?utf-8?B?bmxYdWxod0NlTlMwdWFHL2k4eHp1TDhkaFk0TUg2WVpxVHJMbHdNRDh5QTNr?=
 =?utf-8?B?U0NaMm5JZXV5dGZaeEovdVl2aHlxZGlMUDVQbGNHa082NFYwTkFGUmFReldT?=
 =?utf-8?B?WDlvVllldG1PK1Y1d2J0YjJidTEyVDVxVFJDbzh4QnhtV2M3UW5LQkhqNXBK?=
 =?utf-8?B?cGdENjF2MlcraEp0SmFQQ3FvQllSblRWSHBScDFRdi9OQ1NucXUxbXpGWjcr?=
 =?utf-8?B?R3NVVjBYOHpWQjFQd1diaFpXUXljaFh1aGNscTJpM2pYOGQ2ZUJJV2NkcWJv?=
 =?utf-8?B?NTZYd3ZOWjB4eUtQM1g0Z1FCeS9QVUhjZjhyZWlSeTJiS1hmbWdCTUl6ajlV?=
 =?utf-8?B?a2hLWVE4VjFyemhoVDRjemhJZ0IzTmJ6SzRVclhyakY2V1hiNWF1RjRoQXo5?=
 =?utf-8?B?NlJiOWdpa0dDWnl0ekJMOHc1b0YvNCtBS29zN2NuUzAyNm1wbHZoRVJoSzlO?=
 =?utf-8?B?cWZveGVzNjRBN0RSUXJvVVRXdmQ0NTZab0I5WmtCWm1IZVd5aC9LUkRWMUFV?=
 =?utf-8?B?UzY2QzJsTnRFWHlGQW9RK1dPY0ZXcnZ4VnRsa3RuRklRMEtKazArT1RWUVJW?=
 =?utf-8?B?VzZsYVV0cTY2b2FUUFJRUGcvcjNUeHB1STAvckJ6MGlucUdIWWF2KzZhL1NI?=
 =?utf-8?B?Q3N5QytjcGx3bkJWTGh5S0pwMHRKbm9Ca09aTWhIU2JnQWtETWdBM2xkRXVn?=
 =?utf-8?B?ZUdPeWJsN2F2RDduVk5QSFZqQThOZk5FdUxvVzlsK3RJcTNEZVY2a3VRUEpN?=
 =?utf-8?B?UnpXRUc3UktjK05Ta1lYK0NTaEdBdmRzNXZYbW90ellsSThaeVVNU042bWxm?=
 =?utf-8?B?YkxkMmpUcnJiUnkrd0NEdHBPVWdCQmZ2b3pRZGFWSlhYdFpzT1VYd0QveFR4?=
 =?utf-8?B?RzBRbnNXUUFNS0VTSVNyUDdwdXZSdXN1ZmhNcjY5Z1hRbnJvaWNHUk03MVIx?=
 =?utf-8?B?bVBPUHQ0Sk1Ja29DdTZMeUpHUVVDeGg2SkR3YlEwcUU4MnV5d3dZY3YwdHVW?=
 =?utf-8?B?Z3B0VnFZdENxNTl3S3VJVDVIWll5UGtsaHdnWmN4YnNVcXlWc0JRK0FkeWhv?=
 =?utf-8?B?TUtYTENCYk5qZWcxNDc3YUJsRnV0RnliNzl5TGRnamhvSTUrUHhOMmZRbVF4?=
 =?utf-8?Q?mlMw2QnpZcgfh8skKmAJuKk0o?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wX+jMSYO9RTun+c31FpcE1vYen20EOm30AzaxwRuIiZkUe4i8UVv4trNQML4HzyBAZV/dzNQY5z8Xd/QrqwHhW7A3XLdC+FqzVxaDE9fx7ov+G64y9sd2mJKgqhVvzUaGZD0iPx4AnjGA7I1H+aYFzxoD0dFXm+P4e+oVgJsIjJoqHa+JyHuDY2xFPcXLctuI4erDtYlufmOvnfIL5RYj18JpkffDvUSQ4mpsA4puDkBUYbBIMZsBsbYJE3Psn6yO0hLBkuZiR1Th+/MP1+iosP3XCvk5szbM14Gj6Agn65IFkw6NS5cBtd7cYnnnoqwCXRYqpWBCmEE7K04vY7LLbY4mWBU5sCsfwiPMzQrIHs5fv2HRVO06R9l1VH+64/2kviY0oGVbT9KGm6jN92AATA8Uhz+5TwrHH/GAvbcJ/UeHhr967w6rV5VxPfkTnXp1nEJsTpd9wzKOcqSKjTH+aUJQhP+1ItOXs8x7ZS5oPI3NAIuvkiFYjQFei/Q/8d0DlvZ+cEHHox7d1viM8j/Lp6ZPcvAaqmoedERRLzF5gZTwQlMKi9R+TTbtBZ5+12xR18BM2dbnB7h5a4j82jW7y3PW4fvSFQmUWt/O+9hJZM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfb5ec5-30d7-421f-3208-08dd9940708f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 14:53:40.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qy0qqYUYIGb0ndH3cQF6M5CSkPo2/nC0IQlfbPCtFsgrmAJ+B3+K74t+Ij2/ymqI+rdqUdoyy7GNctRePs05KHaiCiGRNcwFGvyYp5iCWko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220151
X-Proofpoint-ORIG-GUID: JO3iqBv8-WsbBmyfSWg3NhIb1DNZBD2E
X-Authority-Analysis: v=2.4 cv=AdaxH2XG c=1 sm=1 tr=0 ts=682f3a78 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=HH5vDtPzAAAA:8 a=Jo4mZQlElHawV5EjrqIA:9 a=QEXdDO2ut3YA:10 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-GUID: JO3iqBv8-WsbBmyfSWg3NhIb1DNZBD2E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE1MSBTYWx0ZWRfX7kkJGpur8XYA /Ahi/or7YoXlCReeDF/ZDlpAVwjmcZztxx3eKtiU331V6eY99s8HfGIaExBeIzyo2CLfvmTc2Ga iInCadw3oTO90DiHdVW71x24+86RZybZ6ob8CzOCH8kLb95z/F5GwLX0wvAzTSTT9ZSa46kR+QB
 DOk5WD766n2iq2RvPKkALn2GKyHRrzSHJzkYn+vDSX6xNB7JJ7zmzk7WjBDMzFFsbYiuOXWD7Ic Av7BM2ewtldhqIpggls+7VvnLmZfNR3W9GAB5tUAMzjFrQIPqQmx7UglH5BaxTuByxeru/0KPlx 0qLuO+QNmkzeNeK7bfj3lE7aRBGCQTrPh1V8xSh6fk8EloWk9HQvugWj0KejFJXZSMwEZ09j5Ul
 haJ+q9u2N0P37o59dGGtCg57ntXsQhbUWhi/fUCZU7pEmWVToIOtP0GV6X5X2mthXZkxb0Vx


On 03/04/2025 09:17, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> xsk: fix an integer overflow in xp_create_and_assign_umem()
> 
> Since the i and pool->chunk_size variables are of type 'u32',
> their product can wrap around and then be cast to 'u64'.
> This can lead to two different XDP buffers pointing to the same
> memory area.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> The Linux kernel CVE team has assigned CVE-2025-21997 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 5.16 with commit 94033cd8e73b8632bab7c8b7bb54caa4f5616db7 and fixed in 6.1.132 with commit 205649d642a5b376724f04f3a5b3586815e43d3b
> 	Issue introduced in 5.16 with commit 94033cd8e73b8632bab7c8b7bb54caa4f5616db7 and fixed in 6.6.85 with commit b7b4be1fa43294b50b22e812715198629806678a
> 	Issue introduced in 5.16 with commit 94033cd8e73b8632bab7c8b7bb54caa4f5616db7 and fixed in 6.12.21 with commit 130290f44bce0eead2b827302109afc3fe189ddd
> 	Issue introduced in 5.16 with commit 94033cd8e73b8632bab7c8b7bb54caa4f5616db7 and fixed in 6.13.9 with commit c7670c197b0f1a8726ad5c87bc2bf001a1fc1bbd
> 	Issue introduced in 5.16 with commit 94033cd8e73b8632bab7c8b7bb54caa4f5616db7 and fixed in 6.14 with commit 559847f56769037e5b2e0474d3dbff985b98083d

(+Cc XDP maintainers)

Hi,

We've had a look at this and we're not sure this is exploitable in any 
way. The patch is:

--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -105,7 +105,7 @@ struct xsk_buff_pool 
*xp_create_and_assign_umem(struct xdp_sock *xs,
  		if (pool->unaligned)
  			pool->free_heads[i] = xskb;
  		else
-			xp_init_xskb_addr(xskb, pool, i * pool->chunk_size);
+			xp_init_xskb_addr(xskb, pool, (u64)i * pool->chunk_size);
  	}

  	return pool;

The value passed by xp_create_and_assign_umem() here is an offset into a
userspace-provided buffer (the UMEM):

static inline void xp_init_xskb_addr(struct xdp_buff_xsk *xskb, struct 
xsk_buff_pool *pool,
                                      u64 addr)
{
         xskb->xdp.data_hard_start = pool->addrs + addr + pool->headroom;
}

(pool->addrs here is a vmap()ed kernel address)

Without the fix, that offset will be truncated to 32 bits, but it will
still be a valid offset into the buffer -- there is no way to go out of
bounds, for example. Moreover, since this is a buffer for the calling
process, it has no effect on anything except the process itself.

In other words, the process can shoot itself in the foot if it wants to,
but it cannot affect other processes or the kernel itself in any way
that it couldn't do already. There is no kernel undefined behavior
(use-after-free, double free, out-of-bounds memory access, etc.) as far
as we can tell.

We're not XDP experts, so we'd be interested to hear what others
(especially the maintainers) think -- it's a bug for sure, but is it
a vulnerability?

Thanks,


Vegard

