Return-Path: <bpf+bounces-49231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74195A1583A
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 20:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF697188BA8F
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A73E1A9B27;
	Fri, 17 Jan 2025 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dhALQ3PX"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013010.outbound.protection.outlook.com [52.103.32.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0E1A255C;
	Fri, 17 Jan 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737142656; cv=fail; b=mpwtoRxEmzd0tiLFudy3xuw3ROetZitJF/oJmGNGqnuYzlmt5DGOZSxHoRxxxkWFPZXbSo/kMScwa/ebK1Xe/pWU3+RmXPebRyrCoarSGNuLk8DbHFDAp7TNBN2L3QPeC002uQ1qxEJOnbQKhWSrg/OQe75eItXkrXkTfVRj13o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737142656; c=relaxed/simple;
	bh=N9Kh5nu2hjbLy0gM+XEMaWfpzWYruA90S9THCfZSwag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ICZGLch6t7FuRXgWqVHAk2Z8D5xRcXiXKElLYrddpRfmBNXZG88LhZSrKOdi4tKOYp03aJRn+tgrafGCzKLnKR7/XqUp6boZsH5VNjrRSCGi+XzkLZma2lCvNMX5WzY+vwPt/LGYGr+L8HSoM5cDIatg4IbhkGMCSb52YwG/1K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dhALQ3PX; arc=fail smtp.client-ip=52.103.32.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmeZI2hwmN+28j12+KYKn7jdUtnVMzkMKfZfBOLJBYAldmGyIhKH6Iy2ub15E9p6Ivnz2wKZjZwrn8bUZsU0CIxaOLuISumOvhY00rqHV+Xwh744W0MztqRb9JfoGRr5q8AwRt7GFRN1GU+v9JBviW6fjfJrFiztXynA5ASDRCmi4m++qUlXIPZalet/6lxRDGjsHHfLOiJfoK/k3P35U85GdYAoNHzbjh9UfMO09F32H7zKb/QWy7f8P5Ubmtey8b3adJFxPRv8k8XTwJBnnPU1tE77bSvk7h3RakTsdgaSCwPmDTFCbOIOIMT5IZW4T4bYCF2VhMKRnHqm1QuzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgAaOruu5BP327MTgHxwy9Oll+CY1XiJPwlb7RBNGng=;
 b=fHFMZGgebGEdEkJzsM/Z9Phbj2Hq7VJRNOGqYlSI9IAsluvAmGzYykgTiPFpeSqW8jP+aajxksizU9lLas2x58EPxekm+PKK5plS9cdutpHg83w6cL3yMn7kX5r70fIj9wzpfJsQB/CioRd3qLMdrAVcewwgNMldznQgpnKOwo9g/MnM2HAx8dQy8VujesiMS4rYnVxIzYLaIiPF1c4hoHYVkjgductZNkXy+7LUYlCLPC0f7NzLdFU93BphxgXqUrl+kiVf/Q1OUrWAIveyFEO+hOuhaun9Fb1U5/3XKNVSgi/nNNJ9OKubVJkj3vsLfLOYNscxXh7Z4FMXWhE5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgAaOruu5BP327MTgHxwy9Oll+CY1XiJPwlb7RBNGng=;
 b=dhALQ3PXPageYDLvBbAUNbfgXhy3kb+pVQRd/GKc8tB4eHAxzy/K1ChvRz2RY9fO7+aV1xoiwHh4MRMp36S12LEAncvYVPcGESXQJKDjs0RDjlYWib/cYGMyKOVJQRzcdy1ISogtO+sJIecu2iyRRUKPyXRgv4QpPr904jBKpDmi1dUvOKMMcZAnNCWKa67u6wB+rDvS4j6phKDO2u5AvbE3SXUYvdCuIYDyo42ARAxrXEPuXfwlm4xARxDl8EqC83ExoBlgOuFJ4vPb38GVBy4FcE0gGoSNlytENMTkWRTSGek9TOQZf9tpHuFE7GY6QidQFsOlskbLTn9gBpK5tQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM0PR03MB6259.eurprd03.prod.outlook.com (2603:10a6:20b:15b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 19:37:32 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 19:37:32 +0000
Message-ID:
 <AM6PR03MB508002DCA7DBE7C7712ECC30991B2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Fri, 17 Jan 2025 19:37:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 2/7] bpf: Add enum bpf_capability
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, tj@kernel.org,
 void@manifault.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508044E85205F344C4DA4B5F991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAPhsuW4F5uyJKa2Gg1QYRy8_FBERgaj=z4smxtjKa5NF_Zac8w@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAPhsuW4F5uyJKa2Gg1QYRy8_FBERgaj=z4smxtjKa5NF_Zac8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::6) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <a989a38a-eb36-4f75-ac7e-4babd8f3d1e8@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM0PR03MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e73426b-b454-43a5-107b-08dd372e61f4
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrPgu9FUvYZ88hunKvKD6srSlrrczTl5OYXXEHAumP2x1E3gGP0gyb/ChEYkzIGD6h3fBiQp4hzWpW7pS2Ha09qIf7UZzmFIty74JrO7UTqV7z/TQJMsVA5z6hEJxx5kmSeV//UCAhxbZUyPFNptBMPOtEqLLqduCKYYivsmjCddxmlXE0BzkLamX+Wc/FkaGvR1+Q3OHv+7BpsVN4t3giGV2le3kfyM3P0V+B1/NA7IZ0Pi6kOIZrFzWcvEIXH74avi8bkSjMjx1WcNI0F17rgfg5eFNkAIoQDGSY+ITcNfLRnnUICwcaJNu/Ag+QTVUT7EhVVldkk182B7nMGjZrxmbDQKDoQKjQKAD/Z5F3xY8E4dXQ8vpTKpu0KRS4RhNmQ6wQx8mueZwAh+8ypyY3HVcKGrWadGgwEhgy99GgVvUiwVJgobx0WBpdAC4OE5VxO2puW3GGbGb52Ser9Rn6qz+Meye1n2+2O8W1goBUVY2qfFikkfYtm6HmuN2xrKwvyLFntPaYZ06iTbrxm0Fuowae0GGv4I0geyQmn2y5tqx6GoxM8dP9QxXja9IO6gwiuEa5d8z/RDXrhgr3E8Z8opiDKKmtS+eEDx/pNtxSoPiFOrUclErGmNVVKrFiPZQPsCBrvMHmn0sn+nsrVkBrURIia7rJON18eY1BYD/LTx7qTlcGDH9SFA3QpNp4JI5Ek1Bg1RSCZfC8kg9XmYFRqR4bZjbb8WSY8PDpg71R7YN05WvLU8nZUk4bIkWfxJJ8s=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|15080799006|6090799003|19110799003|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkNBcWZ2cWw3WFZGOEhUbmQ5a1lpVkpkbVVmUFVENDVTMG9uLzJoQXRQWURK?=
 =?utf-8?B?T1M5T3BxUmJVVW5XbHgzZGIwa1BrVllCRXVjM1FtRXNMZnVuM2lTU3pPZkN6?=
 =?utf-8?B?OG4wbGhUYW4xWjk4WkRNdW51NUVub2pPZUxBMld4V1ZhaFZrU0JUMUI0bEJm?=
 =?utf-8?B?Mk81TkpNLzFMMGpUV3R1aVJPMmZkTXlIUnhoY1ZQN1NIdC85aWdrQXcrZ2R2?=
 =?utf-8?B?eDZCTUN3NDNtY2lpRFRqQzVyRE9NVmM4TnF3NGpzV0lRN1RSSVI1djc2L3Y4?=
 =?utf-8?B?Z0JYdVhNM3F5c2ovQ3pacXg2aE56T1JyU2RmaERsYmhRNlFrMll2SGxpQ2ky?=
 =?utf-8?B?SlhucStLYkdVbTFOU3djV3B5clA5KzQ1VTBjdUNkZE1GU25FdTBDd2lCTU9s?=
 =?utf-8?B?Y2xrckIvMldILzV3Um9ZQlJ6QVd6TU5ZaHBEd0NVeGtMdHZVUFJnOTRCQkVW?=
 =?utf-8?B?eWdmWEtJZkFsYStVQTUwdG41anBaWW1oMGcwNks0aGlINzIzeGxIMXVUc0g0?=
 =?utf-8?B?cnZhclltYU5mQjNpNTROL2FrbVlYNnVtOXhUWGZ3N3dtckxvb04wMjMvSW9R?=
 =?utf-8?B?WXQzenpjVnM3Sk9LandhNFhuYXk1a3ptOE9kMS81YjNsQkJMK2h6bitEWXZW?=
 =?utf-8?B?RHAvL1M2dnNZdTVua1N4Y3hGQlZTbTVSOWdtNWU1cVRSNmhRVXhsdW5DMHl1?=
 =?utf-8?B?aWNNWTBpRzdjL0NEQy9SQm93RDNnb2pmK0R2TFhlTVpPMTdKQzN5UXV2Z0tR?=
 =?utf-8?B?TVhNSStCbTlkeWJnOS9KQnRaYmVIR2lTSE84Qm9rbklwL1VJa1hId20wWEkx?=
 =?utf-8?B?QXZDU3NUVEwyU0lyampvaWVJMWdSbTlWdjlDS1h3NmdkNk1NRFp3b0NTelda?=
 =?utf-8?B?U0sycTBUeWFxbmVOUHVOTHN3cVNIMEhXK2g5Vk1lV2xFOEpXcmdSU1JVSGov?=
 =?utf-8?B?cVRwd3hudjc3bys5L3ZOREJHbG5Yc3cxc1pvY2Vja09semlzQnhYR2FIbXpF?=
 =?utf-8?B?OXp5akl0TzkxbkltTk90dGFLYVBrMURZOWRWcG9BZlh0cjh0YUp4Rjl1Tnc0?=
 =?utf-8?B?Tm5CTWNUa21xemJxcUZ5dVgwL2VCRGp2YVl5NVo2dnZqTTBzVUxXbTY2VVNj?=
 =?utf-8?B?cWZ3RlQvTXN0emF6aXBnU0xHZExBYmNpUnk5dE1HbVkvQlZ6Y1ZPYVNNQyt6?=
 =?utf-8?B?TnVXdGFLc0dkczhpNHNLL0lERUxZNno4Ynd1TFkzZW9jakRwYTNoU0tZTEFo?=
 =?utf-8?B?Z1hWM3dOQStsdkZZV2E4U3NhajdQYVpMK2ZFalp1cEM2aHZNSGxueDR0L1ZR?=
 =?utf-8?B?VWR2VVBNZng2dkY4TFdFc0M1N0E4TVRmZGZNVFh0aVNNTU9menBMS1ByY1Bq?=
 =?utf-8?B?RDBUUG16djVoT2RiR3l4U1VXRC9MNWE0U0VNVVQ4K2lyTXVmZUZ6U0V2c2Rp?=
 =?utf-8?B?bkhUZ3RZRlJ4U2g3d0YySFAxNDU1d0R3aUlxTjZnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXMyQ3RocjZpdHA5eTJDa0Zoa0h2b09ibm9nM1FhQkV6Mkd1UU5jOXB3L0Jt?=
 =?utf-8?B?ZU9LSGpEeDJIeGt6LytxWlpXcnovQ0VXQ1BYN2U0bnN1UFBuRDNXVjhkajRC?=
 =?utf-8?B?RFhSWmRRRXdLSzIwWXp1dkZXWWZlZlVSeXF4M3pnbzNzZW95TkhJdXBzbCtD?=
 =?utf-8?B?T1VnbUVQUlAzTkE4elZreENyUXE3WmI4WXAxZlNHeG9XbW0vQVR2UXM2YURh?=
 =?utf-8?B?YnFSRGlSTGVCMFB5RUtHczRJNWhiM2tWamVud3BaZnhhNG55aEQ5V0FvN2dn?=
 =?utf-8?B?RVR4dzlUNW83TXN1VUQrZzh2eUFmZGZoYjRYaGM4ZDczYkZPVGF1WGkyWG91?=
 =?utf-8?B?YnJ2bVlWRXo5Y0dKU1JkNUZIajliNjd1cmp3WmxPaXorUG5uUElwYXQ2TVhH?=
 =?utf-8?B?VXVNSVh0RW5GNk4zdXdPVE5Vd0lwWGVoNVNhczh0U1NwRzFsdXdqRXRsVDl3?=
 =?utf-8?B?WWFMd2MxcFhPN2hzMExPTy9HYVp3cnFyakpPekI4cnlKdm5LTEpGdXU2clYx?=
 =?utf-8?B?TTcvSXFydGdQNldLeXZIMTNlVXdJcE5peEh1cTN6STZLRDB4SlBBa0l1RjBB?=
 =?utf-8?B?Qk96VndRLzhPRHRUb0h4eHVDNlFTMGJNcjZlKzBBRVFWYVRhRWdST2hCQ0I3?=
 =?utf-8?B?aHJBNkF1ZWNQdTZiWU9hcDcreFRPVXFpMHJ3b2hLODk5bnlEVjFTTjgxdEVL?=
 =?utf-8?B?dXBjZUc2OForMEd1TVJaN29WYjNYS3NsTUhoS3EvenljZEZseU9iTGNmcWNa?=
 =?utf-8?B?NGVoSFE2dFF6ai9MZi9iaWx5RXM3ZXRvdHQ4WWo2MHVEbE9hQWhEVVFmYTlN?=
 =?utf-8?B?TkV3RzVRQXVCRDkxYjRqZS9uOEFkaXpvSFlOUmlQeFE0YW1ETXFrTzNVZEJ0?=
 =?utf-8?B?WGJFRnJ1ZlY3N1pxM3N2aXBDVjVEbHNLOWdvTXZPS1RReDQveEpWdXF5cmdE?=
 =?utf-8?B?OUhQampmaHl4amp5a3h1T3MzRW9aTVVSdUc4Wk5oYTNpZFE2MmIrMWRWRytQ?=
 =?utf-8?B?QlU0TDh5N2RHZFBuaXlqUGNMUzZrdDlkL3dQMExBUjEwRndiU0ZONitBWita?=
 =?utf-8?B?cFZKSi9WRUxEODV2OUFHNFUxM1lsb0oxWEpEb0hOT2pwUWhSUnRmcmd4V09j?=
 =?utf-8?B?UldDekwvSXQrQlQ2b1Q4SWFjdnhKSEM3THdVYTRBNTB5VkFvVVdZNy9OZ2NC?=
 =?utf-8?B?SXY1azBLdzQ2YWhyRG9Qc28wWVBJZjZBcWs4cFdjTkxmWm00S2FwQlJ4K2Fp?=
 =?utf-8?B?cFRYWWFzUjVxU2pYUFRzcjZvOUNPUVRHK2VpMGkzNEhyTGRQRkowTjROeEo4?=
 =?utf-8?B?UG1sUlIrVm5vcTlpR05aQlpWeDFyQTI4U2Y3ZnFDSEhUd1hXTlNqUnViMDdU?=
 =?utf-8?B?Q1FMMzRMbUc3WXh0ZjRYMjFEV2VrdHVia1ZqZWdNVDhGclJqZGp2T241UVVr?=
 =?utf-8?B?bnpWOU9zM0tKT0lOTDJ2MlJRbEJpNEFDcXZQbGtRMW5lanJ2RC8rTG5JbUQx?=
 =?utf-8?B?cXB6SndSYUlDWVN0eXJUYURYbjFSZmdCUTZJV1EzUDFBaWMrS1AydUdPTVZ3?=
 =?utf-8?B?dUpxNTQvMlV2MDUyNExrNzNxeXI0dFRZMDNudVdxYU8xdnZWV3RkbERqZzJS?=
 =?utf-8?B?Z3BpZWRwTjNLY1JIWjRWUkdJcDYzZjdWWS9qczNwZUJCNk1KTUpOVGk0K0p5?=
 =?utf-8?Q?sn1hoEQywyZCnKyHEc3S?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e73426b-b454-43a5-107b-08dd372e61f4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 19:37:32.2025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6259

On 2025/1/16 22:56, Song Liu wrote:
> On Thu, Jan 16, 2025 at 11:43 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> This patch adds enum bpf_capability, currently only for proof
>> of concept.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   include/uapi/linux/bpf.h | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 2acf9b336371..94c21d4eb786 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1058,6 +1058,21 @@ enum bpf_prog_type {
>>          __MAX_BPF_PROG_TYPE
>>   };
>>
>> +enum bpf_capability {
>> +       BPF_CAP_NONE = 0,
>> +       BPF_CAP_TEST_1,
>> +       BPF_CAP_TEST_2,
>> +       BPF_CAP_TEST_3,
>> +       BPF_CAP_SCX_ANY,
>> +       BPF_CAP_SCX_KF_UNLOCKED,
>> +       BPF_CAP_SCX_KF_CPU_RELEASE,
>> +       BPF_CAP_SCX_KF_DISPATCH,
>> +       BPF_CAP_SCX_KF_ENQUEUE,
>> +       BPF_CAP_SCX_KF_SELECT_CPU,
>> +       BPF_CAP_SCX_KF_REST,
>> +       __MAX_BPF_CAP
>> +};
>> +
> 
> I don't think we need to handle these in the core verifier.
> Instead, we can put the same logic in:
> 
>      fetch_kfunc_meta =>
>         btf_kfunc_id_set_contains =>
>             __btf_kfunc_id_set_contains =>
>                hook_filter->filters[i]()
> 
> Thanks,
> Song
> 

Thanks for your reply.

I am not sure if BPF capabilities is a good approach.

But we currently need filters because we register all kfuncs to program
types, which are too coarse-grained, so we need additional filters for
further filtering (make the granularity finer).

We added struct btf_kfunc_hook_filter and added filter logic in
btf_populate_kfunc_set, __btf_kfunc_id_set_contains, essentially to
mitigate the problem of coarse-grained permissions management.

If we register all kfuncs to BPF capabilities, then we will no longer
need additional filters for further filtering because BPF capabilities
is already fine-grained.

Would it be a better idea for us to let each kfunc have its own
capability attribute?


In addition, BPF capabilities seem like a extensible idea. Would it be
valuable if we make other features of BPF (BPF helpers, BPF maps, even
attach targets) have their own capability attributes and can be managed
uniformly through BPF capabilities?

For example, if a bpf program has BPF_CAP_TRACING, then it will be able
to use kprobes and can use tracing related kfuncs and helpers. If a bpf
program has BPF_CAP_SOCK then it will be able to use
BPF_MAP_TYPE_SOCKMAP and use socket related kfuncs and helpers.

In other words, if we add a general internal permissions management
system to the BPF subsystem, would it be valuable?

BPF is general, and it is foreseeable that BPF will be applied to more
and more subsystems and scenarios, so maybe a general fine-grained
permissions management would be better?

Fine-grained permissions management will bring potential flexibility
in configurability.

For example, if a system administrator wants to open the features of the
HID-BPF driver to users, but the system administrator does not want to
open other BPF features to users, such as sched_ext.

But both HID-BPF and sched_ext are using BPF_PROG_TYPE_STRUCT_OPS, so we
cannot restrict based on program type.

If based on BPF capabilities, maybe the system administrator can give
the user CAP_BPF (Linux capabilities) and set only BPF_CAP_HID
(BPF capabilities) to be enabled in /sys/bpf/bpf_enabled_capabilities
(which can only be modified by CAP_SYS_ADMIN), then the restriction of
only allowing the use of HID-BPF can be applied.

In this example, CAP_BPF is also too coarse-grained. Although BPF
looks like a separate subsystem, in fact BPF (low-level) is
the infrastructure, and we implement features (high-level) for
different scenarios based on BPF. It might be better to manage
BPF at a finer granularity.

If we want to restrict some features and open only some features,
coarse-grained permission management cannot do it.

Maybe BPF capabilities not only can be used to solve the current SCX
context problem, but other problems as well?

Maybe we can have more discussion?

Many thanks.

>>   enum bpf_attach_type {
>>          BPF_CGROUP_INET_INGRESS,
>>          BPF_CGROUP_INET_EGRESS,
>> --
>> 2.39.5
>>


