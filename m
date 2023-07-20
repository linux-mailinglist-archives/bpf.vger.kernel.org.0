Return-Path: <bpf+bounces-5562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B551475BACD
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 00:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BDE1C21594
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C217747;
	Thu, 20 Jul 2023 22:54:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016614011
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 22:54:12 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A5A1998;
	Thu, 20 Jul 2023 15:54:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KLMiuv016195;
	Thu, 20 Jul 2023 22:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zphE7tP9zNH3VP2PTk4Ta2kuAkz64FXJuQr9vv/uuy4=;
 b=itudsD1uhbJXwmK3vj2Boe0LK1+m2tlgxTKIIzE5dJbxUvUiFyVB147i+G10epcS3DwU
 4GuMXb0v/yUwlYcg70wnU6ka6WOrv4HN0k+Sfzg4DlUCVdqSKmsWAzi3dIDfFleyva59
 yN9xPm1gB0TCvfvCw1+Tt8wr5FQfuT9Xa1vrKL8a7mvwXmF3/IonQY2QEkTeYzzghmhU
 FkOnMuoHRWnqjVwqLaTg5iJn6qVbpqK+shrV0w8XkXXzQ+2hyF3VnPbjtIn5aVwuzqxD
 Q2BN+6HJefz92SB+onp6zjaay0QP8vYJ9A4F8/nM7XuvJ1tdYmL7vWsKSuSB/aqMprMR wA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run782uuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 22:54:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KM6bC5000855;
	Thu, 20 Jul 2023 22:53:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw9a7bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 22:53:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFD4ZKzXpfav2dAV8WUhSLgTf8+VpeM+Yo226J1XSmvuEFuU5+HhuOB1urXzbKuRU3j/ySUavtJj61cFnqoA6zBYaJA+v8v3jBU9X/bBlcq80UqmpNonSveKOqD68oby0zxuBhx63mxURNKgmh4xuux2xEVT0dhLmo/ssM9d3gunFARPdjaamAMbIhaecTU7wku1ULs7rDQLMG7kbXrshUq7HW5alX5aFw8pUcJyNvoBx0uiKqju8O0tFI6XPn5P4KdH1u/vGgWb/L4RKK1bNxCanlzE9mCgLZXt3VBFORHbFMzMrSx5rn2WGe2CPbqlkgOm4osOn6q5Z5tG4wxG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zphE7tP9zNH3VP2PTk4Ta2kuAkz64FXJuQr9vv/uuy4=;
 b=KT7NMjvF7xf5QlScTIv3ZDXAgbDWmMTsdE4FJ15Ewl1k9cgZwLs8w/oTk4EA5+QIvAgHzXchda9PHtT3eemhbHPj/exbddNzHVdfJXj81glnmZYUkO/lOAFPXOZx8cKhAq0/PygicALawj1Gni49c02HWKUBrbalSW0Dh2mDUOuk2knzbYwhrplkOL5kAgn6K/AyzUwPGaW2ulH72ZqqlNxlFPD7DO2pPFgmqkFJQhShwWFuuo6J3/Nb7d0NgH8AIbFLX7lw01N75eyEIiZeJybcPSHq/Iwg70l6sZwQ6RAQbDiuIdp0mrDFQHES+H7OliaruVpH+S8Z36KLT/VDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zphE7tP9zNH3VP2PTk4Ta2kuAkz64FXJuQr9vv/uuy4=;
 b=w4zBYQSOz1Qd9hgt/i74XcISQvNtfgPey1h8pLBawwC5TjnO7/gC6eE8VEY2TSOKUlCKbwThb5NRE7EcxnA9w962k1vGmvn6/9I2ILZ5jBaTG7K46VUUEQNQuCbF9B7n3OXuIAt1EK7EWpOYCGxMmvIBebl4Ckt31RqzHAyrCfg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4539.namprd10.prod.outlook.com (2603:10b6:806:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 22:53:49 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 22:53:49 +0000
Message-ID: <b65f6a0f-772c-162c-6669-ff1d545f375c@oracle.com>
Date: Thu, 20 Jul 2023 23:53:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 9/9] Documentation: tracing: Update fprobe event
 example with BTF field
Content-Language: en-GB
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
 <168960748753.34107.1941635032108706544.stgit@devnote2>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <168960748753.34107.1941635032108706544.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ed3ec1-5179-4ef3-fcd6-08db89742e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8B5jTL4aFCUlDDt92B6umwcoHaBJ0ZMhp4yHGDZsaalGnS9lxmKX2/eqYE+MBFdz43wPzkfUlQFf81O89dTeRSuSZLarMh6qs79udqMHwb19wS4aHEMbkw6NjgD7pd3hdDTSfOdTmikjka8qJQbXC3KsJb5EGFnBKBCE/zl0xMsbJfRI3N2nkykqgqRo7b3rMFaGxguF4TbXhaPofC+Yc3Igsj7Qy1Zu8ePepVzG6gNY0/rRElQ6xJjtt8cvMvBfjmGqr0Gxv4LWzcPLhGOaYlRyZjc4RV84RC4T9itUnfWD5bIC6D/dlb/xWSkJkAiuCTW1JPguqpsREMDrSiQmm/d7tbeXgsXKu9SZV+3Bf+AJGTWrSNovi2cRrwSuVjO0+U1Ss56iAlF1/HtF7w5oLsyExb7NvL5C6nese23BcJU68RVU+8y5rQYFsxDCWFx1M+Hu1oQFCKksiDhk8zAU/Hkep/wOGqwW6FfqhpK9QQqYN19ikxF9djLAvazGGAyFbKM5g4Lzu0SAubgDbeeEHSLYVEf0UW3bt+xykEizRu4KfiqPJqx5IHvc3vooLdzTgpizz69hptoPGKJ9h88xS8eX1RFiCeDR8A1RJjwNEjYxHHo+ORplyTDbFR9gsIf6MNdgGSJg+erwjad5eunb9w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(83380400001)(2616005)(2906002)(15650500001)(38100700002)(316002)(66556008)(66946007)(478600001)(4326008)(53546011)(41300700001)(6506007)(186003)(66476007)(31686004)(6486002)(6512007)(54906003)(31696002)(36756003)(5660300002)(44832011)(8936002)(8676002)(6666004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGd0eFpPQTQyUHhidHhCdm9iQzdrdEM5Z0NGcVVVcEZXTG9vYWxKMVBUL1Vl?=
 =?utf-8?B?biszL1FwT0JUT3VRSkRTb2M4dmJNM1ZqeFY5ZUF6bnpYMnFMRXIxY2NyM2pk?=
 =?utf-8?B?WFNnMEFJTU9wb0hoWStEblNiYzgyVFlNQnZTZmZlc1hrZXBLOHo1U2V6a0ZG?=
 =?utf-8?B?REVwbllOSU9ZTUlUWXIvQkY1TEQrRmZhS0o5eUNxR3piTHNHeFdkT1FzSGxm?=
 =?utf-8?B?bC9IaHh6NnMrTWZDMUtESnNxTlBWWFprT0FjK01nNXk2MlE0ckcrTXdDMDNI?=
 =?utf-8?B?bFF4MTUrek9KdEJMOFJlamJhc29DR0xkemZ1ekFvYjdsYldjSkZMWE0yL0ZY?=
 =?utf-8?B?ck1xRENYRVVnK3YxS1VhSXdVMStpV0Z0V3pqWXhwaUJRQVcrQ1ZRUnpLWmgz?=
 =?utf-8?B?VU81b1JpS1o2SDRoVE5oOXViMEIzYWRMcEdvc09CMWpwWlU1ZkNpQThVL2RL?=
 =?utf-8?B?cDh1cG1NOVRqOWJ3NHhhWTB1Sld6T3BUbEJLRTV6eTJoZDgrRS8xUDdDZC85?=
 =?utf-8?B?QURxZDdGTVhESVRkNWdhQk45L1hITnhKSXZYY3VleDdoSEFyaFZBeW03NWt0?=
 =?utf-8?B?b1g5M0xLVmtyeVBHd2RFNlZEc1VHQXIwUkxKNnVNaWhNZDhGU2JsWkI4SVBj?=
 =?utf-8?B?dkpsTVpUNFRBN1lMYnRsY1FPTG1TemdUT3NWZU9nb09IWllSV0xoTUI5OG0y?=
 =?utf-8?B?Mmx4NDkvZXgvWVBkRUlGL1NVSFo1ZTFQMGF0cWJ1dXRabUZWYnc0NUNKTUZJ?=
 =?utf-8?B?RnNoZW0yazBuckdFK09kMHIzRmVta1VVc3NrRmlqSUE5K2dxNXQxMTB3ZVpq?=
 =?utf-8?B?NUdkMGNjcWxZSlNoQjBiWUN1Q0pSMXQzUTRhOWNUcmpBaDYyTlM3akZxRTJt?=
 =?utf-8?B?a2tjUnRQSkpiOG54a0o2VThkdXdXcjRBME5Da0xvVy9YcFRFMXNyNGhJOG5y?=
 =?utf-8?B?L1RyYXNuQTBWR1UxTTVxRFFHRG9QU2xJbmF6TVZnd0daellmZnZ5V2Q0cXVy?=
 =?utf-8?B?ZzFJUUsxUCtUbERpRnZLZTdtVEFGL2VJb0RiU0U1OFlLNHVTRGE4MVZHZGlt?=
 =?utf-8?B?YkVwbzNrYnFzejhtVVFrRjRuZTYvWXRmSDcvWVFPRlNtQzRzZllFSmg3NWR2?=
 =?utf-8?B?VnZFbGlRcnZIbmlKeVF1bHJaaDRnejV1bnhLOHZaZ09aUzJGOVhRY0F2NDYw?=
 =?utf-8?B?VTI1WUJpRlQ4YThjTVdyaWZYVmlLcDB6WnBWZ2tLQ1MzYzVLeVFvRTUwZlIy?=
 =?utf-8?B?TUErK0E3L1ljM0ZycHdrZWZsTFo3M05GRzdQQkJDaDZreDQ0Sy9KUWRmVk9u?=
 =?utf-8?B?STllaEZVemVrWWRkQ0djOFVmZ0VEY0lQK3l0NjVyZFJkTTR5NlllTVNlRlRG?=
 =?utf-8?B?bXlmaUhtTEZ0T3I4aW5Tazd6NFJmUGt0UEtPMExUaWJKNkg0LzRGYWN1TW1O?=
 =?utf-8?B?ZFIyY0VQV1d5enlVcVl1RnhpTkIwbXFLRXhZZFpQS1pKdDN4TmlhSUhneXVH?=
 =?utf-8?B?cTVuUEFOZDVFVDVWOUlTNGFmelhQMktiUTRJY0NnMnlwVjMrR1JXSmtTSlpl?=
 =?utf-8?B?VTlJbTBidU9pNGZDampxb2ZXZzBvdkNxNVBWYkFUSTBpKzZBMmNOQTVCU09z?=
 =?utf-8?B?MUtsdEdUa2RXZnFqeEVKQ1dZS1ZPczRYYTlPek9lQS9PSWo2WXJZQnRPSEla?=
 =?utf-8?B?cm5GY0szU1U5NFRTTE8vWUlwL3JyenFYNlA2bDUwUGtaNC9sQi9vRExaUFVw?=
 =?utf-8?B?S3pRanpHYVpxZzB2VzVBME16N3c0eWFrckNpWGV5VXZDRllBbnl6eTVlZXkr?=
 =?utf-8?B?SnNXL0tDcXhOZEFlSWhtRVhWRjZTa0NsbXdVdmVjc3RSQi9IOTN0MkpiOTEx?=
 =?utf-8?B?OTExaEtpRTNISHZwdUgyczgxeTlidFhCT0ZFTGEzY1Rpc1ZRTDdmS3FwMDND?=
 =?utf-8?B?YVV6VWpkRW1wdWdmSFdoVnJEcVBQblhrSGIxS0wrdUJWWTcvRDV4YmdFSE9W?=
 =?utf-8?B?ellGekFMbEtiTXB4NENZdU5GdHhUOWxiMmk2bmF6QzFiblk1Y01NbVhDTXgr?=
 =?utf-8?B?UFovZUtpQkM4MFVFSWs3MGxhRDB0VS9LUms0aUJuLzgyaFhWbWFDcGR5VU9r?=
 =?utf-8?B?T3BXV2F1a2FSUG1TSXlrQzVFZGpzcElueldYQ0dFVm5NRVdBV1QybTQ3cWtT?=
 =?utf-8?Q?gBgtQs2yw+6ED7h+86oq95Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7469QSKNYXW4l42dfsRKfPWIniS2/kzOxTqiuEaL0WG1ABq9oUEPxrC4L9Ss6P3u5BYzYhUoQrZCmtP4SXyGQyfQEMzH6YN2CNWH6hoXSG+ZfKd1h843t3JEEB/7MfoDJVSdnJ1oLUOgfZhF1GHmwTHzTzSNXUA3F7czECWuUCLq2BIVekAuX8xO2kHtkTtFzX7x2eK6D+5mo4zsTOoaqEyMr2w+FFQ8RwjAzApN1ll3gl0d/1ALt64SKLKguhbqeis6ddgYGbwz1g8+EPKjxKGCEr/U2+jxmWGQhKdHFtH13cNpbxaiLe2QdWLCO2RXZYR+GRkzHhqiu9+3FGNPCQtU+vnM6fNwY1WNB2lgkDw/4BF5aKff9PJANzoI673i8Jom1JEjn+rpS++lmFooiQvOYwIbRJDb82oXxgC0sBh4W/E6/bpkgovIEX5Gb3W+iGR7NaFqfEdRArOx5gYkDWoFbxWyhp6AKM5aeA7De9aYwQrTlIRzZw4v1EcoadhtoxLn1ShawykoivYn6D22fPgTyeclpDRnZ4lss+TNnM3bpemv0Q+X2cyDIIPQA4XF37wYQKXfnjjI45YzS2nGW+o7BE4EzcTtKabPfztgyvB4Jyu3qYYz+U3tu17akyA08Al/hPn7QPgvTne2ogS1ZciDdLdVaTd87U9PXsihi+r9KVrltro/Lt5hIlHFoADuu0clADneLR6lrpechI4j7ExP6yCxP4umMUmPTRgxM3+pZKWxqXtO4EWbayZ9phKKR7n+9+OA4pi2Oo+MQ9Y1YdmMzZ9JUM9vFMWCj0hcS3fCIYple5/vkMqZVG8QvMxDMCav4kykZ5ZqLorPMlhw9TMKwWMComAv0E6gPcLOJUZXsB5Peqg3j9wULeL/e3CN46yXVf78tN2DOqZi5QY0Eg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ed3ec1-5179-4ef3-fcd6-08db89742e5a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 22:53:49.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/pGg6HZ5zaAXFwZSPWjXgJeRIAYIMn0WV3tu1vYpUNQbGD+lrd/f3SIDsVVgN1LoZYYeBN+CZcyKKvKFK3Q8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200195
X-Proofpoint-GUID: _aLCLRuLQMWkBmgQ5Nle-bSNMIWMXlBS
X-Proofpoint-ORIG-GUID: _aLCLRuLQMWkBmgQ5Nle-bSNMIWMXlBS
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/07/2023 16:24, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Update fprobe event example with BTF data structure field specification.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

One suggestion below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  Changes in v2:
>   - Remove 'retval' and use '$retval'.
> ---
>  Documentation/trace/fprobetrace.rst |   50 ++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
> index 7297f9478459..e9e764fadf14 100644
> --- a/Documentation/trace/fprobetrace.rst
> +++ b/Documentation/trace/fprobetrace.rst
> @@ -79,9 +79,9 @@ automatically set by the given name. ::
>   f:fprobes/myprobe vfs_read count=count pos=pos
>  
>  It also chooses the fetch type from BTF information. For example, in the above
> -example, the ``count`` is unsigned long, and the ``pos`` is a pointer. Thus, both
> -are converted to 64bit unsigned long, but only ``pos`` has "%Lx" print-format as
> -below ::
> +example, the ``count`` is unsigned long, and the ``pos`` is a pointer. Thus,
> +both are converted to 64bit unsigned long, but only ``pos`` has "%Lx"
> +print-format as below ::
>  
>   # cat events/fprobes/myprobe/format
>   name: myprobe
> @@ -105,9 +105,33 @@ is expanded to all function arguments of the function or the tracepoint. ::
>   # cat dynamic_events
>   f:fprobes/myprobe vfs_read file=file buf=buf count=count pos=pos
>  
> -BTF also affects the ``$retval``. If user doesn't set any type, the retval type is
> -automatically picked from the BTF. If the function returns ``void``, ``$retval``
> -is rejected.
> +BTF also affects the ``$retval``. If user doesn't set any type, the retval
> +type is automatically picked from the BTF. If the function returns ``void``,
> +``$retval`` is rejected.
> +
> +You can access the data fields of a data structure using allow operator ``->``
> +(for pointer type) and dot operator ``.`` (for data structure type.)::
> +
> +# echo 't sched_switch preempt prev_pid=prev->pid next_pid=next->pid' >> dynamic_events
> +

Could you describe what field access combinations are supported here;
i.e. foo->bar[.baz]?

> +This data field access is available for the return value via ``$retval``,
> +e.g. ``$retval->name``.
> +
> +For these BTF arguments and fields, ``:string`` and ``:ustring`` change the
> +behavior. If these are used for BTF argument or field, it checks whether
> +the BTF type of the argument or the data field is ``char *`` or ``char []``,
> +or not.  If not, it rejects applying the string types. Also, with the BTF
> +support, you don't need a memory dereference operator (``+0(PTR)``) for
> +accessing the string pointed by a ``PTR``. It automatically adds the memory
> +dereference operator according to the BTF type. e.g. ::
> +
> +# echo 't sched_switch prev->comm:string' >> dynamic_events
> +# echo 'f getname_flags%return $retval->name:string' >> dynamic_events
> +
> +The ``prev->comm`` is an embedded char array in the data structure, and
> +``$retval->name`` is a char pointer in the data structure. But in both
> +cases, you can use ``:string`` type to get the string.
> +
>  
>  Usage examples
>  --------------
> @@ -161,10 +185,10 @@ parameters. This means you can access any field values in the task
>  structure pointed by the ``prev`` and ``next`` arguments.
>  
>  For example, usually ``task_struct::start_time`` is not traced, but with this
> -traceprobe event, you can trace it as below.
> +traceprobe event, you can trace that field as below.
>  ::
>  
> -  # echo 't sched_switch comm=+1896(next):string start_time=+1728(next):u64' > dynamic_events
> +  # echo 't sched_switch comm=next->comm:string next->start_time' > dynamic_events
>    # head -n 20 trace | tail
>   #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>   #              | |         |   |||||     |         |
> @@ -176,13 +200,3 @@ traceprobe event, you can trace it as below.
>             <idle>-0       [000] d..3.  5606.690317: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="kworker/0:1" usage=1 start_time=137000000
>        kworker/0:1-14      [000] d..3.  5606.690339: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="swapper/0" usage=2 start_time=0
>             <idle>-0       [000] d..3.  5606.692368: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="kworker/0:1" usage=1 start_time=137000000
> -
> -Currently, to find the offset of a specific field in the data structure,
> -you need to build kernel with debuginfo and run `perf probe` command with
> -`-D` option. e.g.
> -::
> -
> - # perf probe -D "__probestub_sched_switch next->comm:string next->start_time"
> - p:probe/__probestub_sched_switch __probestub_sched_switch+0 comm=+1896(%cx):string start_time=+1728(%cx):u64
> -
> -And replace the ``%cx`` with the ``next``.
> 
> 

