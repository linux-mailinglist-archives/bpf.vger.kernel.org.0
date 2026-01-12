Return-Path: <bpf+bounces-78606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE2D14AD7
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 19:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C3B23006E33
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BB3803ED;
	Mon, 12 Jan 2026 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Klynb2Jg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NP5ax1Ko"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3537F8AB
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241029; cv=fail; b=Idtn2lPU2VO561fEKfwifKmTnH6Os4FZ8ErscTIvenHsA1Aln0XE+pQRZdhX0qWHhGNuglYMAx3keNAho2ju/yeZcf8k46JyymRF0bEYivvmw10bwe/nlKjTiiHwKCWL8Ptm6yWT6PlyKze2JLYWpIbzp343EfGWkCJeCUV647I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241029; c=relaxed/simple;
	bh=fa4Bvisg5UxpxxcATkUO4ne+CqmitUezlo7U4b6wK0o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QOmNfAd1ZWcYM5NkCtJi9z96KjkIIiapL9qFiZRjxs8JqokdMtVRxbHnla+cQhMC8BrfJcAKGkB6Hoqo/kIgFD+jenx72MLro5BEDJymU8fpae8yBKEdo0tTmmSxEl29vPqy33ntEcrsJQJ4J/HObqBlVETl0FY4ze8odzCZge8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Klynb2Jg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NP5ax1Ko; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CFwQwZ456514;
	Mon, 12 Jan 2026 18:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7152cUKHWsX1uy9U5KIsggqYoOzq0zfND20mKd8y5xA=; b=
	Klynb2JgwYrulbmIT3svuC403FSXyXr9v5jl2q2mmfTQNq4UaX0F9ny630Ej4yjm
	oQUbGXfHxVuqyxAaONSXMqKopQOWXSLqzkwkv37fkGFdaDHpr2a5g2Eqqy4+9TAl
	NM5qP8udZRuFZYwA3VW3geVTozrBkmx5q6gS8h7VZZsz+1mxV51t6tzNSZq5NYdV
	Dqs1Rwer2upItMCWRWY18jsXEKanfkY3yXRfBF8xWYsBDDaASe2c0TgfhtrWFhuh
	uGosM0vtho/yPBbQe69F7WyOeDjYS2BzGqjcc0r4rYrCFqKV1OFqbBR+wC2ToC2C
	/bJr6N/I+/RRAzBL0WuROg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrr8a2te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 18:03:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60CGpwQp008270;
	Mon, 12 Jan 2026 18:03:43 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd77fuqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 18:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfIESyXngpT9sKNsmuGJXWi3CXh18dm0fzj9rl68EO1JSr+m7NvWXuRLWIh6i2Z7F9tqnlDyKbdzHwfRMF+Alfgx6j9Ga7ddHw2PnApL/mzuQx2ngirmQYeCZip3v/yx4rtA9qKTNUJbrNeppJjaVL40eAAQDnY7w3JALEPCPC6p2jXrpm8YhGfDWGyQserPIbrntddQCiTVpbIwKdyZ5i0ui6/iVM809Zkk1NN9u/A2TuqShs/y3Bg7AKm/OVr97doOUMoxie+cTiizYdGgksY1F/gKKJPRnXYVjdOlYRzWYj0boHQOuePd5N5A+SQ7xAF8yoj67whKOhv1FzSvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7152cUKHWsX1uy9U5KIsggqYoOzq0zfND20mKd8y5xA=;
 b=VvS2hszqQ5fA/fuB64lWejje90t8fNttf7dXtbJq+QpZGYk6w5qanElElMil8Uis0VAwldYvGjdmgFbN782wxcsNZp+PmFU9SOa7IMl9gju36WHKldS9ExEyj1UKZDjqnF25Xpr81w7N4zxjln0gLUt9mDCQuiowXW2KSi3AAl7IK9WoXhVD02Rhi3cyNaY0fr3ISPkRGeoPV1ojCJKxAW4k4KMfc/7KeuTh5R5+nUbvkQElLFCsdNJYCh60H2azfKF6cKhjXIt6WaAZkJuQBFVaoBa12x34dTKuUPe96NiKdUZyvWk9fihWxj22ndVeoujgBfYr4ENtxeK/qgSY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7152cUKHWsX1uy9U5KIsggqYoOzq0zfND20mKd8y5xA=;
 b=NP5ax1KodHfRSRg4/Uqvg2tog5QcLGn4iThJ6CcsLqphDb02FRQgPjKjzdF/e8cQyF7GwayeQxsazd4QiHf5j1K0Y8OwRhTy8CWgUx3Kw8S1ASb1WMK+Zh9ZRQ901sjq7LQfXMABdT65FcAkEV+KpiCUG5u0F5dBxmrgUNzSdP4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BY5PR10MB4386.namprd10.prod.outlook.com (2603:10b6:a03:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 18:03:33 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 18:03:33 +0000
Message-ID: <3735a372-1641-4a37-a7e2-54b7533caf83@oracle.com>
Date: Mon, 12 Jan 2026 18:03:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Usage of kfuncs in tracepoints
To: David <david@davidv.dev>, bpf@vger.kernel.org
References: <f5e6c1e4-f2f2-4982-a796-e3a49c522bbf@davidv.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <f5e6c1e4-f2f2-4982-a796-e3a49c522bbf@davidv.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0036.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::24)
 To DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BY5PR10MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: fe587ccd-51ad-421f-d65a-08de5204e663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3F1dGtCQmprRFUyelNJY2YreVQ2Z3lZdWxqeU9KSzd2Tzc5QzFRaDdUUlg1?=
 =?utf-8?B?S2RzRmU1Y3pEcWxPL29ndGpVdjU2N0VVLzVhTWE3NzJjOGxlWDBLdXVEV2RF?=
 =?utf-8?B?VzIxOC8ydUNJQjJJYWl4cGdScUNMWk9kR3BwbjFWMTFuQmhQU0VRUnpmd3px?=
 =?utf-8?B?T0FwMjNzSlplS0ttbGNiMzlzMnpmZ1JpdUI2eGs3YUFMSUJBeHNBVUlqNWJv?=
 =?utf-8?B?cGwwQTBrNkl5bDdJL2hhbXVaSEFBT0VoLzl6VEFjRzRXSXVzWS9TUjBuSmty?=
 =?utf-8?B?UlFteFN5bnlGcTNrWmpLMWFKc2hwSU1DQTA5eEZIWjFrY1k2c21XclVoelhO?=
 =?utf-8?B?YnMyYXR0NnFhdjZrSi9tT3ZxUm9OMklqa29vbHBKQUxDa1RuakVRYnZYL1Bs?=
 =?utf-8?B?ZzlreW5Fai8zYUNTVzlYZ3Y1TWNKZlMvaVRWUW16QlFBNUhKUDMwb3dTVFR5?=
 =?utf-8?B?YnhMYS9Oa0ZTaGZyMHg4b0dtVDFtNDdvdCtXL2V2anlmemlETHloZkllSDdq?=
 =?utf-8?B?Y3lmT2tSdis3OGVSWGNCUDFXYzR1ZWQ3dVBkSzcvdGZOR0pOQzhlZjRYSDQ0?=
 =?utf-8?B?eDhkdVg1YU44TS83cXB6b2lsY0tuQzY1dTVjUW50WWdZWFYwdEVRQU1FRlpE?=
 =?utf-8?B?RFEvaGh4ai9kV0NVNzBtY2FKcjlBQkxZa0RSUUJsOS9jblU3eVhVWUc1RmdE?=
 =?utf-8?B?UXUzSk4wcnU2cEhWak9HcFMydy8zcVVNN1l3aFZTeGJIQ0hmVHVXTGVna2JX?=
 =?utf-8?B?VE51ZUpJbGIvSHlabklhUVpJbVZpK0w1MUgraDJLVGhHWnhnRFBUcFZLdUMv?=
 =?utf-8?B?dmI1OS8rZ09XMkFZNUlMRy8ycy9WYlRPaHBiUm9FTEVYQVlMYkhSdDBSK1lm?=
 =?utf-8?B?bXk0NXlBUUFraHoraTEzQzRobjdDWGtUTUdQdHFpMnJZM1NBSzdyU1p0dnVF?=
 =?utf-8?B?Um13S0JLdmQrSUpjZUFWYXRXU2hjK0ZtYStnaEFLYlg3aHo3S1RHVDlRMExK?=
 =?utf-8?B?MDYvQTJoZzNNSXRsNXRGNFZUYWlDbVJ1eVBCZFhaUmRWbG93bURoUDJEOFk5?=
 =?utf-8?B?dklpWkVaVnRZS3JSZnpra1ltQTZraGlOckRtemt3NVkxQUJiamZZOUxrV0dF?=
 =?utf-8?B?aUwwclg0cjkwWDhhRU9ZVU9qZkd3K3B6RUxCUW51QnZFbVY4Tm16YklKQ0tp?=
 =?utf-8?B?OXNQRmZiZ0ZnakNBNE1jR255YmNYMDJwY2pzYW14OTJIdW44ZThZOWozSTNw?=
 =?utf-8?B?aDZxT2xhbkdCQWRBeE0vSUhQL1YvR0s4ejRaSU5CUisxUmVST2ZDVFBScTcr?=
 =?utf-8?B?VTVOYkZkN1lDSTBqa21OZFlzTWNmdnpBU1EwOGxOQlVLVUdrNGUzYThtdFhW?=
 =?utf-8?B?aGNEVkpGVG1DVjNuWjNYTlpFOENmTGNxOHpGc0M0cjd5NllpTGpXWEVqNmky?=
 =?utf-8?B?ZlQySzk4TGRyalVUWjhqNlBJeHd5YmNmZDV0QXdYODRBVGl6WTRtdm5zRFIv?=
 =?utf-8?B?aXE2UitKSi81NWxiSzNxcklabi91QVI5N3hqcS9xMjlpS1EyNXdscXVQYWxn?=
 =?utf-8?B?ZEMxeFBGZGtMRGR4TittTThUR1FkbVZrOEdONndsTlk0alBNTFZnVmI1bnh2?=
 =?utf-8?B?elBYZlJvUDBTamtIandaNVNHakdVK25iV0lVRHpLWm42Y0hrMzVnSHlSQ1pX?=
 =?utf-8?B?ajhxaHZlVWhsUUFmcFNKNnlnNTl4TkhDRlJOVmVaYmdPckJYcXVmS0Vobm1C?=
 =?utf-8?B?Z3lPNmF1YnNtVHpRcEw0bTlWL0RMbjdEZy9CbWhFRktuQVh3S2Y5WlMzekIx?=
 =?utf-8?B?VGx6eE5mWlJCSmhxMyt1ZTdQbVlBMW5zcGlDcXNCYlk4SmZoejh4NXFYWWpq?=
 =?utf-8?B?Y1JmOG14VFdQZVhueXJGTW9Sci9GdmN2eWs1SFVBbjFJUWtxMkJMSFUzT0l6?=
 =?utf-8?Q?Hu+8m6AuKhfR5W/f+8+eJLiCApckNLR6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkliZVRFN1M3cXh4UE1jT2haZUJGcFJKSWM4a0VQU1V3bkxET2VZNFMxcjg2?=
 =?utf-8?B?T3lCSlR2ZzJ3MjZxYlRWQ1NJMS9NNGJRSldXZWQwZW9zT1l0N0thalhueXRO?=
 =?utf-8?B?TFQ1NFBIRHoyRTNCVWh5bFliUTU3VFN6cDNMK2lXYnpPOTlGQ0J5T0VFVDls?=
 =?utf-8?B?ZWdMUFNLU2w1Y0NkZ28yM1orbWFqWXV5YVJkNUk5NFRHWURic1pScU51NmlW?=
 =?utf-8?B?a04rZUZTT29aT2QrOUhuSTdZdnpIekluc3VDQnE3UzAyR3M5ZU9sTnlVSGpM?=
 =?utf-8?B?V3J2SFM3TEx0SjAvSlBDR0JncE1CRC9yeFhhZ2ZZb2xvdHJnYUlrWEE4cEFO?=
 =?utf-8?B?M2FVcEV4TEVjN3hpMXlmMWo3U1BnaW5KZFV0Y3p0cXdhdjNDM0FaVTE2Ky9H?=
 =?utf-8?B?cmQ2NWQ0Z0ltd2piYkczVTRwZVE2NXdVdllCbkhQRUswU21WRmJQaVFlZzRx?=
 =?utf-8?B?cTNuV3RZS2I5V29obzZtelpQSHNENVJ0bjR1ZHN0UUEzaGZ3N2dkaGR4UWVQ?=
 =?utf-8?B?VVpRWDU4eWFtYkh1RTJqQWVCdFZuODlvS0Q2enRxcFF1S2c1U2RuWWFtQ2V5?=
 =?utf-8?B?KzQ5M3JYWTBkU0pUb2pGV3N3VCtlbXpMeWp0OTdIdmJzclR1bldXSGxsODli?=
 =?utf-8?B?amlwckhTR0tiQjFGamFoa2ZOTElUbjRhQlBmV1NrRjNlTm9td3hBSC9OcTNK?=
 =?utf-8?B?eWp4UlJ4NHlid2djNjV1U0FJYlU0bkdiRUNIcElzRXdhd3U2K0wwdXZTTmpm?=
 =?utf-8?B?UkhOdjRVRUpBS2llR3FOd2FaMVdNUFVMOWw2ZTlYRkpPVVF0VHdxNWRWUGNy?=
 =?utf-8?B?b1p6ZUtKR05IQWw0ell5RzVveWlLMU1yT05IVFBvQ0txb0FOZVJQZG82Zytp?=
 =?utf-8?B?WG5WdDAzZ0VqTGs1MDM2VTRQaFZ4TThZaTlURVhIYVE5YmpMdlpMVnlKeU02?=
 =?utf-8?B?dTVYSnhvbDNrem5scnl2cU5HR3FkdGlaNDJIQVptdFo5N1NENHlpZUNNUDRj?=
 =?utf-8?B?TlNtL2VncVhkMkg4N2ZSTys0U3hLVWhSaWduWGNTZmJ1YUVkYlg1dXAzNTFH?=
 =?utf-8?B?VmtBQ3FsZTNTc1M3SUdNYnNUTWo2NWdjK09SM0themdsMWU0bG5nQXpQMlp5?=
 =?utf-8?B?d3V1TGs4TEV0K01rUjlrejBkTVltTDVpN1hkOXVwbHRONURzZ0x4WUJqaDZz?=
 =?utf-8?B?bzNUdXhVOWdEY1hDZC9CVzFadW41UmZNbW5kQWZwYUptSlVJU3p0b0FxTFo3?=
 =?utf-8?B?YjJPQXQ1SVA2UHhzU3J5MnhQV2lMOER2U2duOE55cE55Wmk1aFJQMVk2RVBh?=
 =?utf-8?B?bW9hYzRFai9SbU05UHVTZCtseU1vVlBYS0l2VjlSMDcvVnZUVmpmbktobzZ1?=
 =?utf-8?B?L2dpcmN2bllyTDFiU01jWlpSZVNyZWgzQ1RybHNFQ2NSbCtqdVBHWTFPektt?=
 =?utf-8?B?aHBOV1paenAwRCtWRkd3bkVTdVAzVEY2ZWs0UUowc2VDTDdMSm96ajJmelZV?=
 =?utf-8?B?T0haVTJIRWM5WEQyNDFXc0JTQ1hHMGRNTmlaaURYZlN3MnBQL2FTa1d1L2oz?=
 =?utf-8?B?aldZNExMUmJZNklvcytqQU5QSXdsaTlla3R4MkdWb0xWSWJjS3pKSFpHZnpM?=
 =?utf-8?B?M2lVaHpkQTlZZjcyeU5hcUdsL0lmZkdoRlRvdHJmZjVWK01CUEZSdjNBL25H?=
 =?utf-8?B?QVFwdHR4dWNQd3k1Mnorb09IL0pEVU1pQUt1UHBzUDdpd1lTb29SRGMwSE1y?=
 =?utf-8?B?WkV5MUh3ZXU3Y09DNWZpM1NFNVVyL21TMTRMTGZzRUZUZUtPY0UwdVJQZDN6?=
 =?utf-8?B?T1hJZDEyVjNEeHJRc0p1Si9IekdocGd6dDFhM01LbTR5UWxIeG5LWXo1Qjlt?=
 =?utf-8?B?TmhyVnN6R0xFV1Y5UXNRdE8vdDZLUVpnNkJaTzBmc3pHYWFwb0hzaHdsSmRL?=
 =?utf-8?B?N3ovYTQ3S3dRaVhIMU5Od1FiVyt3cFdFNEp3eGVYY2hwTjZWVFZlTWFKd2U5?=
 =?utf-8?B?UGdvSUNqdnpKdi94cjhJRU42MnFZVFN4RjdGclluNFc1RGhxSU5BUGI3a291?=
 =?utf-8?B?dWNhQ3Yxem5LaDFrVUhtbHEzalFDVzhPZmViT3pVOGhZa1p6Ky9CQm9QVTBH?=
 =?utf-8?B?S3NpR205S09JdUVaU0JjcEQ3cmNTVmZ4NnpXN1NCbkRLSnFmdFpTTWR0VUVH?=
 =?utf-8?B?bCtZMWhQMWlreEtzSzFLdnNQNlpVUlc5WVNpWFNhL0ZoeklxTmQycGttTEl2?=
 =?utf-8?B?SWEwMzlBTExsMnkxUWNqdUo0U215N2VkeEVpOEZXdVhJYU9vTXVpOFROd2xC?=
 =?utf-8?B?eGtPWElaTkJmUXZIcmVzZUxXOWpKSzBzL0tHaTBhd2V4bUQzWXorZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p6WuKuRpLhFTAcH2NXOFvoK1MIzGZaF4jYafdQSQXYz6+5NCZtxqMLaF+WU81q6r+lx/CfzpW8JfApAhuGlmV7nUUpI3LBDnV1VmsOCEw+j3Anx+H56R4Xuz34+PIcOde7hfrYb+2KUZ+VTMhDtAW0khjEuKIiRq76Cbtx684oYObWNUIR1vYLAoFlxOSCgYM5up8RUo0LxfeZSejjG+zbbmDYDb2Q+QPVAgeCzdiSXHybLC+9AVGwyI3sE2rsctxBPnJgy/nLXzXLuNAFuAGnJBC1mjngYx1sSuC/MrY595hmcnajNz05ZoMj9W7rTDzhT/1Ua/NmBnQfuiDORNNdSvgYs616FSQi5jsq/PyliwVS4j83bhTSx9EGncNfkfEN1qjJEKhlc2z/aGjniz7FJ4SI2TvNAJfO7ZunsMJMDJQ0gQYde6vOZzqtCnb0Nci3hUhBRAO4gIS6kNEiQ8gjLD9y99PIRCD0JZR6mNAmNGi8l5hhkxXVanbVthlbAmxNaWRhmGALFNvz4W3PGs1giiCmiN+g41VGQXmc+Mt7BLSQPoySreluQQUOjkcedh6wBpdJHUgy1jz9MWd3gMv48eCMT4+8/ri7dBclIRXfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe587ccd-51ad-421f-d65a-08de5204e663
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 18:03:33.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSBkeLhRHIbk1siXFdLFpVIFSCVFjqaADRDugC7Uz/bbQECz2DMxiV0UvDA8/mbU3oj6b4saVWuaB5q/O/Sj1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4386
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601120149
X-Proofpoint-ORIG-GUID: buhyvgY4TPd2pCdr6CN6P-Ty7cwQjQqa
X-Proofpoint-GUID: buhyvgY4TPd2pCdr6CN6P-Ty7cwQjQqa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE0OSBTYWx0ZWRfX0xN9DcZSbW64
 tZw/2/bjJxMCYpz+Kt2PiTeWrN1pAil/FnzU3rZO6y60x6iIssWvMIXT7rPqzz2kK0al//l+obT
 T27rbWLo7HXelwDs5yyakL/gGPJrEnAxG+X9oFfSHf3Eje+5LqgsTF7zKv9lQ8jbKCw1LcWYltB
 qKcEN6tQB4VL5MH5UUCeHIo7/XSIWMzmlQf6ffNbu1s6D4Kmgb8eQFAhpnhXLN5sqYWCUBQqtXM
 9vq2jnxkjfQOEmTf0HOCwVjZpzOW+bIYaMj9+qnUVSI6zeM0xyyR9Ax4o5YxYg9y+hHAwNybQIl
 1egBQYZQs8lV2S6BC4U6bk7bgou8YaOofcKZClvrzG7zSyIb58oJRJMqEON2HZsHFIJGFKyOpuB
 +SLo5LRJkpQ0gscBLe3+tv1K2RvWN89taEFc50LFzlTtam3v3J3gD/VwZmIXlCnyNqhZG57dlhw
 Br8XnCVJjPgGUB8tIJg==
X-Authority-Analysis: v=2.4 cv=QIllhwLL c=1 sm=1 tr=0 ts=69653780 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cXQAnHGZ2eiM_jKl3LIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On 12/01/2026 16:57, David wrote:
> Hi
> 
> I'm trying to use `bpf_strstr` in a program that's running on kernel 6.18.2,
> but I'm getting the following error on load:
> 
>> failed to find BTF for extern 'bpf_strstr' [53] section: -2
> 
> A minimal reproducer for this is:
> 
> ```
> extern int bpf_strstr(const char *s1__ign, const char *s2__ign);

I think you need to add "__ksym __weak";" here i.e.

extern int bpf_strstr(const char *s1__ign, const char *s2__ign) __ksym __weak;

If these aren't already defined you'll need:

#ifndef __ksym
#define __ksym __attribute__((section(".ksyms")))
#endif

#ifndef __weak
#define __weak __attribute__((weak))
#endif

Most of the examples use a bpftool-generated vmlinux.h which has
kfunc declarations of that form; if you want to use a generated vmlinux.h 
(created from the running kernel's BTF) yourself you'd need to 

bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h

Anyway, hopefully the ksym/weak attributes should be enough to get things 
working.

Alan

> SEC("tracepoint/syscalls/sys_enter_sendto")
> int trace_sendto_entry(struct trace_event_raw_sys_enter *ctx)
> {
>       char buf[128];
>       int pos = bpf_strstr(buf, "A");
> }
> ```
> 
> My kernel was initially built with CONFIG_DEBUG_INFO_BTF=n, rebuilding with
> CONFIG_DEBUG_INFO_BTF=y did not change the error.
> 
> I've only tried this with a stripped kernel image, which is 4MiB larger than
> the image with no BTF info.
> 
> Running `bpftool btf dump` on the stripped iamge does show the kfunc:
> 
> ```
> $ bpftool btf dump file ~/git/linux-6.18.2/vmlinux | grep strstr
> [26877] FUNC 'bpf_strstr' type_id=26855 linkage=static
> [60337] FUNC 'strstr' type_id=60336 linkage=static
> ```
> 
> I'm running this program in a virtual machine with a custom init; running
> through strace shows a failed load of `/proc/version_signature`, but I assume a
> fallback to `uname`.
> 
> ```
> faccessat2(AT_FDCWD, "/proc/version_signature", R_OK, AT_EACCESS) = -1 ENOENT (No such file or directory)
> uname({sysname="Linux", nodename="(none)", ...}) = 0
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f3fe6630000
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f3fe662f000
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f3fe662e000
> munmap(0x7f3fe662e000, 4096) = 0
> munmap(0x7f3fe6630000, 8192 <unfinished ...>
> nanosleep({tv_sec=0, tv_nsec=10000000} <unfinished ...>
> futex(0x7f3fe6a44858, FUTEX_WAKE_PRIVATE, 1) = 1
> munmap(0x7f3fe6839000, 16384 <unfinished ...>
> sendto(3, "\1", 1, MSG_NOSIGNAL, NULL, 0 <unfinished ...>
> futex(0x7f3fe6a43b70, FUTEX_WAIT_PRIVATE, 2, NULL <unfinished ...>
> sendto(3, "@", 1, MSG_NOSIGNAL, NULL, 0) = 1
> sendto(3, "libbpf: failed to find BTF for e"..., 64, MSG_NOSIGNAL, NULL, 0) = 64
> close(3)
> ```
> 
> Maybe there's another dependency I'm not aware of for kfuncs?
> 
> I'm not sure what I'm doing wrong, can you point me in the right direction?
> 
> 
> David
> 
> 


