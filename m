Return-Path: <bpf+bounces-20856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A85844677
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8881C21897
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458812DDAD;
	Wed, 31 Jan 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L9x5KZ4k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xi+oJfzZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AFE1F164
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723413; cv=fail; b=SLgnL1jAoP5GAlSZTT6Tm5GHOrbRYZ1qctDEDtKuZ9XjipdaxTFSQqh4mvXAjtgsqLxh7c/b1BRwxgCCMdGMti8R/QXg1k0w+HfdJMH1DFW9luURgP5P+06zZ9W58hDuHCjLSohMn6u3e21gIANGTiNaaXQCwvEdpguzr4EPuBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723413; c=relaxed/simple;
	bh=oNr813H22/nBjqb4mcRrG1hqrUJHIe8Brmc5XCHjips=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R2myu6Tn97DKChJFZthVqhyuZc+VwDuOLM4jT1Zb2BKvq5IcTcTUQnt/ULQQWqES//JHhAGhmSqtueA/6gUiOnabbV2wjXv0cqaKpa3Sqqhjm7kIG2nXVoWJY8gd473AGrkqiSpD5mnZ56Ko4nXbb0i3ysAsD3+mCp7HWboVsCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L9x5KZ4k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xi+oJfzZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHC0vh000546;
	Wed, 31 Jan 2024 17:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=eDvE80cQon/D7ifnj78o1qbjAfKeNiVJclv1YQJ3a8s=;
 b=L9x5KZ4kuTDNj7xSfWmiJCy/StY7M3SkPIxmILDXHsJLngd9G+Qrde/Bphw6E5+2QuFO
 plWtRu3Ayfshjxy/Wv74uXXhBhF+PCCx0yLCPqfkFz/u+1PiV/AHrf9brODmGSty/2/5
 kZTJLfCgb3SmujWycLDguyDMprmYGZokSA/8JjVJpXB93nEFtwBzOj6gUwbHFHAWxg83
 zlJ8QjLtIrTsRSNym17zOxsN8sUrs83BxlC+a7JCYr7FjB6/4jZkoUM6O+B6yz+JPu2V
 2rjvHgmUdcwqb4D+rSunuY2CpWh/k91ZwSJ2WICN9ZsSfbOp2/X86PkTNzfnFlGsX2vA zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcv2kfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:49:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VGmsbD025933;
	Wed, 31 Jan 2024 17:49:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr99f22s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoQH31aSkGk54ESIrzwzk+tZ3bUOYxxdHc8mICDW4qXvlHNeYSK3qHQ5+LLSldLv9t6qx5LT2/0JOX5ZAduGbiE0gPHG+NIrFGi0/JQGkSWWJ86yiXWWc3UHDPrt3f+XTPSUcs7QE+57lPP95JHtwFQrfAJwBbQHhxbp7ndAB4+9GH3F1c4luCJjBY067pFyT7wu+nHvUlvM/5JNLCYegEY8L7paYCR63F+FRTYbYzWkPH25SMcopSkUX73ukjjLvr3Y4U/rzj1BccG/b4Im4xEYZL1KRIW8dv4RX//Zuu2+gceXoBA8LuwhZ/tSSm692gGejulsrCyvBVmhwabGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDvE80cQon/D7ifnj78o1qbjAfKeNiVJclv1YQJ3a8s=;
 b=Vv+PtnSDilqfSWecQn39p5oOBovj8Fqx3d/ck00yQkx6h9DpYQQSiPj4ox5rDk4E41UxUcHx34VGVvcOxZS5AFM1oHqUjbJTPB7KN5IRzxXxoh/1lYJRcLKD2DXTF+88eMgETotbYQd1O/2WQO4KlkoyXov1sJ17szoe9nQzj11Yk+o7F0Gpgn5mJdX1xyacWu7BEl8VcRD2wFBDVk24IWtGOm8JLSadTZwvpvDOdwanp/mK/jkzLybiyjpU//VBHTmKhi5XpvQxQeXsugW1v6pTExnIznrY0ZawNQ69njgH7Mc+bS1xnX8IrS02+onPCnwWusjeZgNr8YtpeCdFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDvE80cQon/D7ifnj78o1qbjAfKeNiVJclv1YQJ3a8s=;
 b=Xi+oJfzZlox5BdJf7ehnyby57e6gf0W5FX/oVc5H4imkv9uaTBc6jK7kSOnzApjCwE3upeXG18lxm7RZxcYQX99dm8NApLgUsKUBsF9i0RN2sce5qDOSVdNDdYRfqZ940Ai4bgIDt0gsvYlUw1TyZThClE11mFL5ZyoiiX1pv6I=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5584.namprd10.prod.outlook.com (2603:10b6:a03:3d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 17:49:46 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7249.025; Wed, 31 Jan 2024
 17:49:46 +0000
Message-ID: <6cd44959-b51e-4f79-9d30-c9026f084ae7@oracle.com>
Date: Wed, 31 Jan 2024 17:49:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next ] selftests/bpf: disable IPv6 for lwt_redirect
 test
To: Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, eddyz87@gmail.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, yan@cloudflare.com
References: <20240131053212.2247527-1-chantr4@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240131053212.2247527-1-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR09CA0003.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5584:EE_
X-MS-Office365-Filtering-Correlation-Id: 00927c22-78cd-4a48-3880-08dc2285036d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qRTE4SdHBgdPyjlxgxme23vsLTPmqzBDwh6pqxm0rfrrkUg5eC2H9CcRuzaSt4e7otqoArEatkJXcThw/QohMmZgh+xgvtKZKMoKJHqadCGx1nejg9cDWpbXMEjMKp2K3fE/gtPoQhihJCD44unDSWC+tCvzNz27mhu/mco7Ll/nY3ceypmllyCabYTqIor4l852+vxaNT7oK4q9vc+0Cz5cLX2mqlZJ1ExB5StLhUmMT26BKZa+3V4dOy1t1F19iKd5a1nqg5IyY2X1Fy33cPwUTl6LkyW+t/Gm695LIGDTHLD78HpaFVKI09UD8jhZUg58UUtmtywkyJmpXYmY+KdV6FZtiSY+Ay8+2q0eA5zenWNkf9ySWn7kyVRQ/DLnuQ9LEcFFx2RE2qeTFuxq6d0sSxzozH93fhasHnvQvH8DIz4l+6PYYPO8v1qXJJqcnJ8xVfGu3y8pabJuLzN9lgSInV/AuIRKoswNh/VF9DUmp5++yEYMSGIdZuGHbY4EZO9BmNTNyy1SReaB+QXrw1LfvQrIbaBLakCmQJjBqsFLSZJhEb1QaGO5EceVYG/PB9n7P6brP7CaF/Pfe04DFjqsZoqMPZKch398xkQgS14l7aN4SqK8/iUack3DdtXxZwS2FXR6ruAwKBzMbdLAsDgtlsiNS45jSscNcefaLAo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(2616005)(8936002)(66574015)(6512007)(53546011)(38100700002)(44832011)(8676002)(5660300002)(7416002)(478600001)(2906002)(6506007)(6486002)(6666004)(66476007)(66556008)(66946007)(316002)(31696002)(86362001)(36756003)(921011)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U2lxWFN1NmRkRDJiam1zdlBWdytvR1JqZnJwcUY0SWI5MXlkakRuRmZMZitQ?=
 =?utf-8?B?WCtDZ1l5b3JXTytIRTlMM1RTRE9pd1FSZWtsbnNJOTJsYURjMjBUT3JzYlFK?=
 =?utf-8?B?OE9ibW9Hc3RmVVJieHZKazF0UlpNMTZ0blV5TDVyc0pFQU5RRnhLbUc5TDRT?=
 =?utf-8?B?ZmhWWDNIMXhKSk1wdzZGMkRFa1V2emFCZlJBWVZpYTQ3NFQ2ajRjVUcxa2Zv?=
 =?utf-8?B?NUNkTGNxVFdvZTROeUNPQ2hrYWhueHFYdTFNLytwU1ptaG9EQWpGYlR0aTI3?=
 =?utf-8?B?L3oyd2F2ZC9OeGJBZzBYUFFhSS95aHpjYkxITXVSK3l1NGtHbTVSbXNwbTdW?=
 =?utf-8?B?UkZPaE5zdDM2YnY4S2VlWHpqQmFnQzlKeFRnTXhWODlPV3NnN1R6Z1NKOTVO?=
 =?utf-8?B?YXFoR0hDTGYrSnd2dDdLYVZBTE4xQ1hUSXRIcUhBTW52Y0dnU09aWWxlQmNQ?=
 =?utf-8?B?OXV2aFdudVBvcFNYL2c1N2JLeStwNFVpVTV0alJ5ZzVSeXM4QjEyZXdmQnVK?=
 =?utf-8?B?Q1IrTHhZYUFXUlo2R1l2QTlyL2VNZTlIb1E2UzZoc1lGN3p5aE5Za0ErQU5V?=
 =?utf-8?B?ek91QWdlZ3RrQUdiMXNoTWZubGNPTUtMWGFWbzdZSWNrVzJqZHZobWdGL3Ux?=
 =?utf-8?B?Qkh5bEpSeDRJRTNoUUxLNE9sSnQwWjFJTTVoWHVneWRLQk1HUXgxOXdGRVUv?=
 =?utf-8?B?WTYzZnAwTFptV2VBTkVXTDdtSGlPcDFZVE5LU1BaQ2phY2ZCY2tZOSt2MWV1?=
 =?utf-8?B?TGpFM2R3cWs1cWsreHJOTEtkdzZiYmQzaFY3UzlOMWxBMWF4WStGc2lEM1lE?=
 =?utf-8?B?b2wwYlpiVEVEdmt0cWhMTUlqdHc0Nm52RHZnMnNyWGJIeHc3SkhOZFZSWEQ4?=
 =?utf-8?B?VHQzc0d3Z3VJZzlualBsbHVaUGpXMnBuZlgwd0JxdXF1Q3lNVWpGVkxSMU4z?=
 =?utf-8?B?ZE94ZUdxTm9GSktCMW5BRUUvMTJ3N1RjZzhVenB5QlZaNjYrZlYvcnNqQWRX?=
 =?utf-8?B?QzQzNk9hejZMbE9IRXc3d2VINUo3YXBTaHVMRS93Q1hFNjlCR1dMUTlxS21S?=
 =?utf-8?B?N0hUZlVHWm1yei92b0htM3JibytwTExJNGNyNllFRDJnNVVnSkhZS0czcGN3?=
 =?utf-8?B?YnVjWSs2UWRWQlJYRzY0RXQ2VDd3U0xUblEySWRJYW93bVU2UDhBOXNHa0lo?=
 =?utf-8?B?djNWeW9wa0FkSGZNLzRoV094WWU3dVFBYk5HNGJvV2NwWmtYcGxhRHJUalpI?=
 =?utf-8?B?K0JhOG5MNjhQT0xVcWNJdHB0RnA1czdoZm5JNG5ZZWVpcXRZZWxDNzhyL2FB?=
 =?utf-8?B?ejFTTUtXNU1PSC9HQnp1ZGdURmlSVytnUkt6b3A5T0V6Z1p5MFlRYU1PWWVF?=
 =?utf-8?B?ek9UZjEzUnpaaGtNS3RheTB0SWhPLzRURlRwbk5nNytzYThGd3NMNFJBY09Z?=
 =?utf-8?B?NG1LcmE4bm44UkNzb3ptOXVsU2RTM1Y2YS8vOWV4WW5yY1JVM3FSVTRYR2VE?=
 =?utf-8?B?eTBHNEVLMnBQTXErK0pnelJYZG0vSzNKNGlnMW05Rnl1SFNXTENpOU5PK1hw?=
 =?utf-8?B?Rm5NWS9zZ1pGZlRkWEZMd01Vc0NrMGh1cmFQUnBBT3o5YXQzVk5PYzRGNTM0?=
 =?utf-8?B?SHV5WXQ3bUdaM2IxS2MvMXFNTjJWQ0xPTHltcm85NnRya2hxcDR6THA2c1hs?=
 =?utf-8?B?cFMrKzBROEhGTUpWSWRuVlgyNHU5d3d4bUtxUThWZGVvVDJOMmY2V3NVREp3?=
 =?utf-8?B?SkV2Z0V1NmovZHlieUs0M2ducW9tckJUWDIzTU5uc2NWZWV1WDFGUUlBT3Zy?=
 =?utf-8?B?c0dTb3E4U3hLV1VJdEJrTUt2U0xWVmhycmtZRjJwbDg0YWZGaUl4a3R0SG8v?=
 =?utf-8?B?Z2ZJdGt3TkVPNW9qdXFDcm1IS0FWdStLUlFLZkpLWmJUQW83ZWVyVi9QR0N0?=
 =?utf-8?B?NDZ0UGFHSDNQdFlTTFkwWWIvUEFhaS82cEhyeFlZdjRrOTdVdjlsVkdxYUUz?=
 =?utf-8?B?MEJlUi9rOVBucWFHTHkxR3B3bk5NMGt1N0IrYjBVbFpKWHo1VjRMbGxZNlRo?=
 =?utf-8?B?c2pEekhXcHN6d3hwdDFQTWZRRDZyTjRnd2xxTzJzVkpGUU9JN1FvN3VpNVdi?=
 =?utf-8?B?SGNkb3lYZ0N6eGJibkhNclVtVEVPSEhwdG9Ud2wyc0NYMFpOWDlpSytycFRL?=
 =?utf-8?B?NEsrNEVwZmt2ckNyWWZ0OEhYSlpzSDVCV3VlaGdRVHc5VlRQN0xBRTg2eERL?=
 =?utf-8?B?c3BmbWNBZmcwYkxrUWJMVUR6aXBnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CkUO16d+MaEWIFq08nRO35flwO5uFKeheIQiEQToQu5+Jtj+U8aW2CKkpUORL3RZhcUmzMX59ak2AxVLB9OhGejGutGULNqGJF8ABPVZEWF5oUlXRFAsJRTqrr2AYn7dMHj5kc1z8tvhWv81RGzKOjYKt8eYfdf9Ow1CtfKuiYzfsFcYicr5OzQL01JNVhNKm41ZfGckPzI+GE/XZwl2wKtvmdilcQ4AJydos9sBHKfuTahO47ILKeJMKvD/D0lx2fJ4fdKow2/0ECrtOHEFqBL60hL16Ym6xnSFeKgJVTLX7sLiwSrTJhsvCLEhRo7/hQuHCnQiDWHndyVW6QzNukY/46d+iiYkscnRuMyWBaaPN+Ob7HNwGduzw5C9xD6nMSwjOpP3zzSVCXi/io90UBNSIUtB2eopTIrymfithm2dRxcfbZ09qZ1vb75iyL/YaMdx0wtQOb8BCKq1nclcdZIPcN/e07R6awFfrxF4mDaGKHHQ8frXI0WbVw1/mkalg6My8SrapQ/2OkSMko0qBNbIvUCEZgks+ZzDnl3eolw6AVBbRKimC8/PjdKG4dQvNvg4u50D20F3OB1VnTFEtHT/EBjOeUkLbhA1+PXDfnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00927c22-78cd-4a48-3880-08dc2285036d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:49:46.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fivKa/SmdPdZqQayGOW7m9GrVTUAH6XIc4OIuWqIIEmOiIim46Zt6oQttL0Cm36WYurhSM5Lwau2zk/aDMOQSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310138
X-Proofpoint-ORIG-GUID: q4nfJ5_8oXag_nVGPE6YDVoBrb3NVxO9
X-Proofpoint-GUID: q4nfJ5_8oXag_nVGPE6YDVoBrb3NVxO9

On 31/01/2024 05:32, Manu Bretelle wrote:
> After a recent change in the vmtest runner, this test started failing
> sporadically.
> 
> Investigation showed that this test was subject to race condition which
> got exacerbated after the vm runner change. The symptoms being that the
> logic that waited for an ICMPv4 packet is naive and will break if 5 or
> more non-ICMPv4 packets make it to tap0.
> When ICMPv6 is enabled, the kernel will generate traffic such as ICMPv6
> router solicitation...
> On a system with good performance, the expected ICMPv4 packet would very
> likely make it to the network interface promptly, but on a system with
> poor performance, those "guarantees" do not hold true anymore.
> 
> Given that the test is IPv4 only, this change disable IPv6 in the test
> netns by setting `net.ipv6.conf.all.disable_ipv6` to 1.
> This essentially leaves "ping" as the sole generator of traffic in the
> network namespace.
> If this test was to be made IPv6 compatible, the logic in
> `wait_for_packet` would need to be modified.
> 

Great to fix test flakiness like this; I was curious if you tried
modifying things from the bpf side; would something like this in
progs/test_lwt_redirect.c help?
(haven't been able to test because I can't reproduce the failure):

static int get_redirect_target(struct __sk_buff *skb)
{
        struct iphdr *iph = NULL;
        void *start = (void *)(long)skb->data;
        void *end = (void *)(long)skb->data_end;

+	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
+		return -1;

I _think_ that would skip redirection and might solve the problem
from the bpf side. Might be worth testing, but not a big deal..

> In more details...
> 
> At a high level, the test does:
> - create a new namespace
> - in `setup_redirect_target` set up lo, tap0, and link_err interfaces as
>   well as add 2 routes that attaches ingress/egress sections of
>   `test_lwt_redirect.bpf.o` to the xmit path.
> - in `send_and_capture_test_packets` send an ICMP packet and read off
>   the tap interface (using `wait_for_packet`) to check that a ICMP packet
>   with the right size is read.
> 
> `wait_for_packet` will try to read `max_retry` (5) times from the tap0
> fd looking for an ICMPv4 packet matching some criteria.
> 
> The problem is that when we set up the `tap0` interface, because IPv6 is
> enabled by default, traffic such as Router solicitation is sent through
> tap0, as in:
> 
>   # tcpdump -r /tmp/lwt_redirect.pc
>   reading from file /tmp/lwt_redirect.pcap, link-type EN10MB (Ethernet)
>   04:46:23.578352 IP6 :: > ff02::1:ffc0:4427: ICMP6, neighbor solicitation, who has fe80::fcba:dff:fec0:4427, length 32
>   04:46:23.659522 IP6 :: > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
>   04:46:24.389169 IP 10.0.0.1 > 20.0.0.9: ICMP echo request, id 122, seq 1, length 108
>   04:46:24.618599 IP6 fe80::fcba:dff:fec0:4427 > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
>   04:46:24.619985 IP6 fe80::fcba:dff:fec0:4427 > ff02::2: ICMP6, router solicitation, length 16
>   04:46:24.767326 IP6 fe80::fcba:dff:fec0:4427 > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
>   04:46:28.936402 IP6 fe80::fcba:dff:fec0:4427 > ff02::2: ICMP6, router solicitation, length 16
> 
> If `wait_for_packet` sees 5 non-ICMPv4 packets, it will return 0, which is what we see in:
> 
>   2024-01-31T03:51:25.0336992Z test_lwt_redirect_run:PASS:netns_create 0 nsec
>   2024-01-31T03:51:25.0341309Z open_netns:PASS:malloc token 0 nsec
>   2024-01-31T03:51:25.0344844Z open_netns:PASS:open /proc/self/ns/net 0 nsec
>   2024-01-31T03:51:25.0350071Z open_netns:PASS:open netns fd 0 nsec
>   2024-01-31T03:51:25.0353516Z open_netns:PASS:setns 0 nsec
>   2024-01-31T03:51:25.0356560Z test_lwt_redirect_run:PASS:setns 0 nsec
>   2024-01-31T03:51:25.0360140Z open_tuntap:PASS:open(/dev/net/tun) 0 nsec
>   2024-01-31T03:51:25.0363822Z open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
>   2024-01-31T03:51:25.0367402Z open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
>   2024-01-31T03:51:25.0371167Z setup_redirect_target:PASS:open_tuntap 0 nsec
>   2024-01-31T03:51:25.0375180Z setup_redirect_target:PASS:if_nametoindex 0 nsec
>   2024-01-31T03:51:25.0379929Z setup_redirect_target:PASS:ip link add link_err type dummy 0 nsec
>   2024-01-31T03:51:25.0384874Z setup_redirect_target:PASS:ip link set lo up 0 nsec
>   2024-01-31T03:51:25.0389678Z setup_redirect_target:PASS:ip addr add dev lo 10.0.0.1/32 0 nsec
>   2024-01-31T03:51:25.0394814Z setup_redirect_target:PASS:ip link set link_err up 0 nsec
>   2024-01-31T03:51:25.0399874Z setup_redirect_target:PASS:ip link set tap0 up 0 nsec
>   2024-01-31T03:51:25.0407731Z setup_redirect_target:PASS:ip route add 10.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir_ingress 0 nsec
>   2024-01-31T03:51:25.0419105Z setup_redirect_target:PASS:ip route add 20.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir_egress 0 nsec
>   2024-01-31T03:51:25.0427209Z test_lwt_redirect_normal:PASS:setup_redirect_target 0 nsec
>   2024-01-31T03:51:25.0431424Z ping_dev:PASS:if_nametoindex 0 nsec
>   2024-01-31T03:51:25.0437222Z send_and_capture_test_packets:FAIL:wait_for_epacket unexpected wait_for_epacket: actual 0 != expected 1
>   2024-01-31T03:51:25.0448298Z (/tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c:175: errno: Success) test_lwt_redirect_normal egress test fails
>   2024-01-31T03:51:25.0457124Z close_netns:PASS:setns 0 nsec
> 
> When running in a VM which potential resource contrains, the odds that calling
> `ping` is not scheduled very soon after bringing `tap0` up increases,
> and with this the chances to get our ICMP packet pushed to position 6+
> in the network trace.
> 
> To confirm this indeed solves the issue, I ran the test 100 times in a
> row with:
> 
>   errors=0
>   successes=0
>   for i in `seq 1 100`
>   do
>     ./test_progs -t lwt_redirect/lwt_redirect_normal
>     if [ $? -eq 0 ]; then
>       successes=$((successes+1))
>     else
>       errors=$((errors+1))
>     fi
>   done
>   echo "successes: $successes/errors: $errors"
> 
> While this test would at least fail a couple of time every 10 runs, here
> it ran 100 times with no error.
> 
> Fixes: 43a7c3ef8a15 ("selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT")
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/lwt_redirect.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> index beeb3ac1c361..b5b9e74b1044 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> @@ -203,6 +203,7 @@ static int setup_redirect_target(const char *target_dev, bool need_mac)
>  	if (!ASSERT_GE(target_index, 0, "if_nametoindex"))
>  		goto fail;
>  
> +	SYS(fail, "sysctl -w net.ipv6.conf.all.disable_ipv6=1");
>  	SYS(fail, "ip link add link_err type dummy");
>  	SYS(fail, "ip link set lo up");
>  	SYS(fail, "ip addr add dev lo " LOCAL_SRC "/32");

