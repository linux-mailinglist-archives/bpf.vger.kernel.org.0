Return-Path: <bpf+bounces-36245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C37B945524
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 02:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4230A1C22564
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 00:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDD9EC0;
	Fri,  2 Aug 2024 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZLrNL65E"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020112.outbound.protection.outlook.com [52.101.61.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93612A2D
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557604; cv=fail; b=BMO5rt1Cayr+INPyY9kO4wQN5dDvq56Y1evctsJV3dLHqI1xyHcoeb4rdx8rmbK1hbqDm7/aJ2z53zAAZ1hnHByoHWmjzI9uy0L1qvc7LyyVPqAdlby2fxQ3qsHu8vIaV/kcwz+Yhgp5vuxtfY2xKYpK0a17wr1n9NPP3OAKx/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557604; c=relaxed/simple;
	bh=VveAnUfFz0ENa7D3Xh7i/DgMWy3F19srtObCMWeEoGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tXdmsJp4PUIQYI8ukwMEatqhe8WyVRJKuYNytz/tbZFg79rQ/L9C5ynuqT8F2i0Bd86Sj1pzY/q8VxJxmjGSiHlFlCjasYB4KxQvIXDKfAhG3d9EZpAqk6laHIlV5i3gSbCUF+RnDYrHUnLhuS3JiG2bPt+BCU88yhRef6tweLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ZLrNL65E; arc=fail smtp.client-ip=52.101.61.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhCcnbvub0Px3Z2mXnOljYjJPUrnhELKpe1WaTSrBD3QP9kvX70rqNjKatQi5V98ogoGcjZXZqCxBoNd6v6HJGX7O4jSrqxSRHYSMcw3FUbJ9tTFn1Qf6vbVR7dKFTadoxNQrJ66k21KrNApJZNZJAJGt8NBI9aEKpi0PwRh1QMFpGvALX5Zk4A53LMVentSG8l02gp3xjqYrpSlS3qrcYkMS+HHvfIAbVMmUr7D19JkR2UTnqHF3WqIxwLD+VCxdqfhXZFkV0VNdVE1CFQKkUcRwKZK/jJb4hut5x1wn+nxSqgPxZWFz0kR2VxjxCdQRS6DeIF2DQBsaxOQ6VupWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VveAnUfFz0ENa7D3Xh7i/DgMWy3F19srtObCMWeEoGs=;
 b=wnmRnZZzG+At4h02wPIGFeMJ1TfA7TnaF9aiSr9z6S9bH8t753X92tbGltigPqiL6EMloyfJBHrJggqgA5QFAexM0+x6cWvrN8UFmrK8v95guIkJGb1+JwlEur82GYdux4k8Dec808Y0OwWajlS01upzmPxJWiHvenUuU2qh3ohe6S2VwhG4tpAFYLpdp8pc6DJbwaVG77Z1FH8FDHytwbB0FawwcNukIr6R8atPaMt6QJm6PjGSUHR47Kbj5RSK81LhJ/Ai7ceT3Yr94DOD3qnPIZwycVBMjCw4owS8eIc9DJwRARiTKoR+7rIKmbEBNFN1njwpV4uTIT/+KgXXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VveAnUfFz0ENa7D3Xh7i/DgMWy3F19srtObCMWeEoGs=;
 b=ZLrNL65EhXcaP7KLvdaIkuA8gefcig8c9QfJUhznw7H7z77lF82gH77UHEXVAynCwWch45mI00XspbZbNroUFnPCMUr+rpsOg8XZMEEcUblMtH89rVuuiGcdunBWKxrAYLQCra6OH+eGdUvVQBa/0PAPyzOkSrFbw6oFUbps4vY=
Received: from CY5PR21MB3493.namprd21.prod.outlook.com (2603:10b6:930:e::6) by
 CH2PR21MB1463.namprd21.prod.outlook.com (2603:10b6:610:8e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.6; Fri, 2 Aug 2024 00:13:19 +0000
Received: from CY5PR21MB3493.namprd21.prod.outlook.com
 ([fe80::103c:c670:fe7a:99ab]) by CY5PR21MB3493.namprd21.prod.outlook.com
 ([fe80::103c:c670:fe7a:99ab%4]) with mapi id 15.20.7849.005; Fri, 2 Aug 2024
 00:13:19 +0000
From: Michael Agun <danielagun@microsoft.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Yonghong Song <yonghong.song@linux.dev>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>, dthaler1968
	<dthaler1968@googlemail.com>
Subject: Re: [EXTERNAL] Re: perf_event_output payload capture flags?
Thread-Topic: [EXTERNAL] Re: perf_event_output payload capture flags?
Thread-Index: AQHa3vgKy5tYtpsBAEW6H2nOXoUJ8bIJPD8AgABs3A6ABIz9gIAE7Q4D
Date: Fri, 2 Aug 2024 00:13:19 +0000
Message-ID:
 <CY5PR21MB34930570D71160AAD130D7A4D7B32@CY5PR21MB3493.namprd21.prod.outlook.com>
References:
 <CY5PR21MB349314B6ECC4284EA3712FCDD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
 <7ab6fbc6-2f05-4bb1-9596-855f276ab997@linux.dev>
 <CY5PR21MB3493D67300A4005628E8CB8DD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
 <CAEf4BzZvMOdL+mL9NxxesyXO-xRCwkJYqQ+GXQVBssF3_jid=w@mail.gmail.com>
In-Reply-To:
 <CAEf4BzZvMOdL+mL9NxxesyXO-xRCwkJYqQ+GXQVBssF3_jid=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-02T00:13:18.001Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3493:EE_|CH2PR21MB1463:EE_
x-ms-office365-filtering-correlation-id: 70f0e416-1f90-4fb2-75c9-08dcb287e9c2
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDhZWllESUxiRWJGTUYwUVFsTjNPVkloRVRvTEZtdGxYeWtFeGJYUkYyWmVM?=
 =?utf-8?B?NnBORjgvNjNwZVJ2eDJvSzYvNWZHOVVINkE3ZmRpejhEaGhJQkE1b3dKRjh2?=
 =?utf-8?B?MlY4bkNZc21GY0ovejZ0L2JQZmZlbGlIdmlpUGRTTlh0WlNtalpBLzVNenc5?=
 =?utf-8?B?aGF1M2s3NWpIWHVqNUFoQ0xJSzR4bXE3b2JnY3RYVEZKSDJBVzMyYzQyZXI3?=
 =?utf-8?B?cTJNTmpEcGpKRW5Xc0Q2UFR6eEovYzdTQnpVbjN4VEpVckVmWFRNVHVHcUVZ?=
 =?utf-8?B?K3hhWkhSZG5oTm9vYm5uTUNIV1BJZlVSQ3pzWjR2c0U5SVhtMG1KbVRkMnVr?=
 =?utf-8?B?dTZ3V0hIZVNzL1JIZituOXFxdWpSTFh0eW96Q1pkVW9VdHZiUldSSVo0dTRy?=
 =?utf-8?B?Qy9va0NmbUNJSDU1UHd3TmNUaG5xSGlPQ0hlZUljUTR0a0pLcHJyNGEyVGlZ?=
 =?utf-8?B?aXVKZVVjaGViU3pqRkpNYTlPT0pGTVRUaW5Ic2lOVjdaRXVUUXdDUENMbkJR?=
 =?utf-8?B?blcwQXBKVmFPSkpGWC9UWlZTTFYzaW5SM2k1NkVIVTZOb2xvNFp1cmw3cVBz?=
 =?utf-8?B?eGFYeEltNHJHZDZSQWFwNUljR0s0bGs1MDQzUC9meUJHUWZKaWtjVjZZbFo2?=
 =?utf-8?B?MytsN1VVdERydUNVOHpxZlNMMjQwL3RLN0IxZE1EN05BRHAweUs3SnNYWDZ2?=
 =?utf-8?B?N2tabG51cVZnNG9IM2tIc1VvWHZObU1ORkdOVDJBS0Z5YjdrcWVzNG1jZTlV?=
 =?utf-8?B?QXRKSVBaMklEMDVpcUR4V1FuU0ZGWUNacnRUWGl2aGU4MmM4RTgxZzRXOXY0?=
 =?utf-8?B?Z3FVTlpzMHllVWM1d0JmTVNjRERUZ3hYT1FjUUNFRnBtUVJNNC9uM0k5aXpu?=
 =?utf-8?B?RTg5NTB1eUhncjVxRGM4WCtUUm85b1JmU3NJMXg2dTVJdnVkaVE5cmVKR0pv?=
 =?utf-8?B?RTV5eGdkV1NDQ2docnB3NWxweUJ4NE4rL1lieFJlSmVNQXNUS1YyaGo3M2R6?=
 =?utf-8?B?STE2UXUyVFV4dVRmNXBGYmJ5UmhXKzZaR092eFh6TEV6TDZZckJ0UW1jK1h1?=
 =?utf-8?B?TEdlbkJ6czhjSUxEK016U0hkUjVwYzZ5c3lTUk1hc0V5MHQ1ZWVKYjZkanQv?=
 =?utf-8?B?V3dHNUVpT1BoUlVEUmMzTXJrVWRqa2ROYkJSTXE2eEYwNXphdXdmOXllOS81?=
 =?utf-8?B?aVV1RHcrUzNNa1BOZkc1TDhYTkVNLzcrb1lwTWZUeHNSQ3ZEQVpNWkg1RXZt?=
 =?utf-8?B?cDhleXJidDJtUncvdzBTeElhdE51S2JSUkpELzBRak9WbmhXZ2NYT0FUNFpo?=
 =?utf-8?B?dUtUREpuVXFXb2xjVUdhUVZxNk9lN09JZEx3c3l0REVhYi9Jd0Q5ZU0ya3lB?=
 =?utf-8?B?VytuRTlEMlNuU1k4clNYb1paZG01N29tQ0JUVFpmMExLL3MwcTBJd2R4V0ND?=
 =?utf-8?B?YmZkdmF1ZUdPMXhoREU1Y0FrbGJVWFBkdUhCYmEyRm85UkRSL2xQdVBOdDJa?=
 =?utf-8?B?OHdNS0doVGJ3MWpTZGwyS1djYzA3NkFRUXQ1WmNrTkZmaGo1VjRFWGFBcG92?=
 =?utf-8?B?UnlteTM0UnhQM1Z0Z2tFQkNDRWZ5d1FWTkQxWlNMVTRSdm9VSmNXWHkwZE9K?=
 =?utf-8?B?OS9wUmd3ZHgweXB2ZTFrOVJ0b3NIcXZvZ0M5TlNBMW05RjNUN0t3MnJOUjlI?=
 =?utf-8?B?eERUWEJrUUVKVXJta3BiQ1NIcjZyTFF5Q1BoVnp6dHdlYTlzbldhc0Z6Z2tk?=
 =?utf-8?B?VmVWVm1VcjVVdXhPL1QxY2VlWUFLSm03TDBCQ3plOW1BbS8ydHBmd3NjdWJE?=
 =?utf-8?Q?ZMZ7FG9DcQXlZOai2LcyjxCdFVgYaqyoy6E+Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3493.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGZVY0p4SXhEMm9IcGd3SnprL3IxVGU1cEN1SG0rUjNUc0NHcjIwbDdQb0NU?=
 =?utf-8?B?bkxrYWdocWdLQWo0OWl6bkM4QmZrb0JjSThLZ1B3bENKUVJkVXJjNUx5YnFK?=
 =?utf-8?B?RnBjeVV1QWlYU0w5NmpzMG9WVjhIdDlSSXl1Sk9NOEJRcFMxSjNabm1oWldu?=
 =?utf-8?B?UTV0VmRyd2ZJL2ZsMDU2WUVJUDNiQTJsTVdGbW1iRHpaS2ZnOGt0Tkh4WExK?=
 =?utf-8?B?K1ZublZRbHN5NEQyU3FHS0c3QU5kMVF1Slk4M3VscTVLTkxMU2xKN2JhbWpI?=
 =?utf-8?B?eW1qTDl0YmZaeGQ5bjJxKzFpckxnUmR2RG1NeS9QSmRwYjJTSzdGbTB1QW0r?=
 =?utf-8?B?ZzhKUFJFSkEvSnB6bTVvcTJCMFNONGd2VlF0UXdWS211VjhLNGV3OTNKbGZt?=
 =?utf-8?B?bXVIRTQ2RDFpMU1FbnptS3FoYTlUaDR2bnpOc2E0bGpBNHhudUlFQURXZnBu?=
 =?utf-8?B?N1UwWEdGR09yUjVaVmJxeHhjY1ljbTR6MUdraEtLOWUrNGJCamZydUtzV25u?=
 =?utf-8?B?NXZrZUxJWDJUQjU4bmp4Nis5Mlp5dWM0L2g5R3d0T0pJUXRNekkrZ2N6NlFt?=
 =?utf-8?B?azF6Lzk1LzlvdkJiQ2E5b3lYenhYaTVDRDNhVzgzWlRXVldYcGFCM0N4OW8x?=
 =?utf-8?B?SlNqZmQ5UUlqcmpMVlRBbEU4WkhFWDd2cVc4aGMwd28xZGE0OVBScXEreXRh?=
 =?utf-8?B?QmlHMmdmYWQyMEIwZ2pSN0VSQkdIUXRyWVF4a3FNVlB1dWYxS0puUC9MSzhR?=
 =?utf-8?B?dHpqK0lUZUpjYmxHUUZRM1FtUjd0OWZxNUVOMnB4SExrRDhGMUFHTXVqc2dw?=
 =?utf-8?B?bkQ1dlZjVXowU3VmWThmUzE4MzRiemsrdFZFcnpiQzVOV3IvTU1WNGtGYlJs?=
 =?utf-8?B?S3JWT1V0QzRXMmZkQ2lPbUovT2dENkR2K0ZRYzB3RjJJUmFydVNIejJwbTJy?=
 =?utf-8?B?bCtmYkIrYm9QYndaQkEyWEVNWjYybEdDMTFhMkRpbWxaZ2lLK3h0bDlXTGRi?=
 =?utf-8?B?YmNFekVrV1J5TFB3S0JaQzMzWkNaQnU4R2k0Ri84VkUvdlFhVkZRd0JFU0JK?=
 =?utf-8?B?UG1PMXBrSm1YN3RITVhTTUtSUWNxV0d1OUlJM1VxSGhJdGFzcHg3dUx3L0Fn?=
 =?utf-8?B?dlJ6TUg1UGRBTFhTYUFVNTdUam5SM2xNdmVrd0Q1c09sVyt5aEJMNzNNVGEz?=
 =?utf-8?B?eHB0T0dKWFJzZmZtNXZvQmNpU1htZ3ZDZUZVNjIxRWlLQWdqc3ZNMGRZOG0v?=
 =?utf-8?B?NmFqYis0Zlplc3pYT3N5VWh2WlVJUThnZzBqVmQ2bWd5MzF1Z09ocDNxcFZt?=
 =?utf-8?B?QjRCMVMySlhHRVJjV1o5bmxENDJrcmtUNTVHZWV6RXpvdWl4OC8rMk9kYTQ0?=
 =?utf-8?B?amJIaWJKM3F2L2krNDhhMkhZVTkrMFAzRTRub0JzOFBYUFFIMlRNNTlsZXNK?=
 =?utf-8?B?d3NNcEtmT2dGczdNcktTMW5yTmpLZndrSG1MM1ZKUXBiMkwzZUZTaEFCa0tM?=
 =?utf-8?B?VDFKcnFweWdzbG93WE1pM1NJWnNDTHY1blZ1NHRFOEpEYTlrRUx2OXFWeDNV?=
 =?utf-8?B?a1RrRTA3QlRFMy94QVVBWDY4M05xL1ZpUzllMXR2V2N1UThKb3cvS2tFMkMy?=
 =?utf-8?B?cEswdFhnSTZOZUhSV0pjc0YxUDA1ckpLYUJiT05qanBPSlkzV0VFWHJ5Rkdq?=
 =?utf-8?B?a0lvUFFOMDhCN2FwcS9nTGRYanJ2a3dDcy93ZXZTbXlHUEFZU25INGZ4Zyt1?=
 =?utf-8?B?VUZqbnZiU25sdjh6V0lYSFozSE1YckpKUG5tM2JwRXJDT0ViMVBRdnVjK2Q4?=
 =?utf-8?B?QkZ2TWROMEYycXVuMGJHWkM2VDArSnVDVG1TNllRS2NncTVua0xyM2xJd21r?=
 =?utf-8?B?WDhyN3ViRElpaTBUeVA2TTh6SG85RXQ4MVdQaDJVRUJ1aFlZalBIQzlENXly?=
 =?utf-8?B?WDNpY01mdUZ1Vk0wTGtYbTZKQ2pvb3BxamN4SUt1MFJtNmoyRWY4RUcraFVy?=
 =?utf-8?B?YXh2bWFnUFRXaHN0Nm8wcGx3U015UjJnNXJGZWdnR2N6R2RocHR4ZWoxS0Rt?=
 =?utf-8?B?SWhBVDhoemdrbEpRUWpIeXF2emxndWRsb2NDeXlySi81emFRWVdpNE9ubE1y?=
 =?utf-8?Q?BRUA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3493.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f0e416-1f90-4fb2-75c9-08dcb287e9c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 00:13:19.1726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFBGHkqV6tdNhzazTDS8uf8QvH6sgTjuDGtF5ZVXbh+ZB5cbQRDTsLnGrRoi1Af9MdgMuZicu79GDQc0P9cihNEbN5rLcYJ4ABmbRXj5HHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1463

VGhhbmtzIEFuZHJpaSwgSSBoYWQgdG8gY29uZmlybSBJIGNvdWxkIHJlYWQgaXQgYW5kIGl0IGxv
b2tzIGxpa2UgdGhhdCBpcyB0aGUgc2FtZSBhcyB0aGUgZG9jcyBJIGhhdmUgc2Vlbi4gSSBub3cg
c2VlIHdoZXJlIHRoZSBjYXB0dXJlIGxlbmd0aCBpcyBiZWluZyBwbGFjZWQsIGJ1dCBhbSBzdGls
bCBtaXNzaW5nIHNvbWV0aGluZy4NCg0KRG93biBuZWFyIHRoZSBib3R0b20gdGhlcmUgaXMgYSBm
bGFnIGNvbnN0YW50IEJQRl9GX0NUWExFTl9NQVNLLiBJdCBhcHBlYXJzIHRoYXQgaXMgYml0Zmll
bGQgaW4gdGhlIGZsYWdzIHZhbHVlIHRoZSBjYXB0dXJlIGxlbmd0aCBnb2VzIGluLCBidXQgSSBk
b24ndCBzZWUgYW55IG90aGVyIG1lbnRpb24gb2YgdGhhdCBjb25zdGFudC4gRG8geW91IGtub3cg
d2hlcmUgdGhhdCBpcyBkb2N1bWVudGVkPw0KDQpUaGFua3MsDQpNaWNoYWVsDQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IEFuZHJpaSBOYWtyeWlrbyA8
YW5kcmlpLm5ha3J5aWtvQGdtYWlsLmNvbT4NClNlbnQ6IE1vbmRheSwgSnVseSAyOSwgMjAyNCAx
OjU4IFBNDQpUbzogTWljaGFlbCBBZ3VuIDxkYW5pZWxhZ3VuQG1pY3Jvc29mdC5jb20+DQpDYzog
WW9uZ2hvbmcgU29uZyA8eW9uZ2hvbmcuc29uZ0BsaW51eC5kZXY+OyBicGZAdmdlci5rZXJuZWwu
b3JnIDxicGZAdmdlci5rZXJuZWwub3JnPjsgYnBmQGlldGYub3JnIDxicGZAaWV0Zi5vcmc+OyBk
dGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbSA8ZHRoYWxlcjE5NjhAZ29vZ2xlbWFpbC5jb20+DQpT
dWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogcGVyZl9ldmVudF9vdXRwdXQgcGF5bG9hZCBjYXB0
dXJlIGZsYWdzPw0KDQpPbiBGcmksIEp1bCAyNiwgMjAyNCBhdCA0OjQ14oCvUE0gTWljaGFlbCBB
Z3VuIDxkYW5pZWxhZ3VuQG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPg0KPiBDQyBEYXZlDQo+DQo+
IFRoYW5rIHlvdS4NCj4NCj4gRHVlIHRvIE1pY3Jvc29mdCBwb2xpY2llcyB3ZSBhdm9pZCByZWFk
aW5nIGNvZGUgd2l0aCBzdHJvbmcgbGljZW5zaW5nIChsaWtlIEdQTCAyLjApLg0KDQpMaW51eCBV
QVBJIGhlYWRlcnMgYXJlIGxpY2Vuc2VkIGFzIGBHUEwtMi4wIFdJVEggTGludXgtc3lzY2FsbC1u
b3RlYCwNCmFuZCBzZWUgWzBdLiBXaWxsIGNpdGUgaXQgaW4gZnVsbCBiZWxvdy4gRG9lc24ndCB0
aGlzIG1lYW4gdGhhdCBpdCdzDQpmaW5lIHRvIHJlYWQgVUFQSSBkZWZpbml0aW9ucz8NCg0KU1BE
WC1FeGNlcHRpb24tSWRlbnRpZmllcjogTGludXgtc3lzY2FsbC1ub3RlDQpTUERYLVVSTDogaHR0
cHM6Ly9zcGR4Lm9yZy9saWNlbnNlcy9MaW51eC1zeXNjYWxsLW5vdGUuaHRtbA0KU1BEWC1MaWNl
bnNlczogR1BMLTIuMCwgR1BMLTIuMCssIEdQTC0xLjArLCBMR1BMLTIuMCwgTEdQTC0yLjArLA0K
TEdQTC0yLjEsIExHUEwtMi4xKywgR1BMLTIuMC1vbmx5LCBHUEwtMi4wLW9yLWxhdGVyDQpVc2Fn
ZS1HdWlkZToNCiAgVGhpcyBleGNlcHRpb24gaXMgdXNlZCB0b2dldGhlciB3aXRoIG9uZSBvZiB0
aGUgYWJvdmUgU1BEWC1MaWNlbnNlcw0KICB0byBtYXJrIHVzZXIgc3BhY2UgQVBJICh1YXBpKSBo
ZWFkZXIgZmlsZXMgc28gdGhleSBjYW4gYmUgaW5jbHVkZWQNCiAgaW50byBub24gR1BMIGNvbXBs
aWFudCB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uIGNvZGUuDQogIFRvIHVzZSB0aGlzIGV4Y2VwdGlv
biBhZGQgaXQgd2l0aCB0aGUga2V5d29yZCBXSVRIIHRvIG9uZSBvZiB0aGUNCiAgaWRlbnRpZmll
cnMgaW4gdGhlIFNQRFgtTGljZW5zZXMgdGFnOg0KICAgIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiA8U1BEWC1MaWNlbnNlPiBXSVRIIExpbnV4LXN5c2NhbGwtbm90ZQ0KTGljZW5zZS1UZXh0Og0K
DQogICBOT1RFISBUaGlzIGNvcHlyaWdodCBkb2VzICpub3QqIGNvdmVyIHVzZXIgcHJvZ3JhbXMg
dGhhdCB1c2Uga2VybmVsDQogc2VydmljZXMgYnkgbm9ybWFsIHN5c3RlbSBjYWxscyAtIHRoaXMg
aXMgbWVyZWx5IGNvbnNpZGVyZWQgbm9ybWFsIHVzZQ0KIG9mIHRoZSBrZXJuZWwsIGFuZCBkb2Vz
ICpub3QqIGZhbGwgdW5kZXIgdGhlIGhlYWRpbmcgb2YgImRlcml2ZWQgd29yayIuDQogQWxzbyBu
b3RlIHRoYXQgdGhlIEdQTCBiZWxvdyBpcyBjb3B5cmlnaHRlZCBieSB0aGUgRnJlZSBTb2Z0d2Fy
ZQ0KIEZvdW5kYXRpb24sIGJ1dCB0aGUgaW5zdGFuY2Ugb2YgY29kZSB0aGF0IGl0IHJlZmVycyB0
byAodGhlIExpbnV4DQoga2VybmVsKSBpcyBjb3B5cmlnaHRlZCBieSBtZSBhbmQgb3RoZXJzIHdo
byBhY3R1YWxseSB3cm90ZSBpdC4NCg0KIEFsc28gbm90ZSB0aGF0IHRoZSBvbmx5IHZhbGlkIHZl
cnNpb24gb2YgdGhlIEdQTCBhcyBmYXIgYXMgdGhlIGtlcm5lbA0KIGlzIGNvbmNlcm5lZCBpcyBf
dGhpc18gcGFydGljdWxhciB2ZXJzaW9uIG9mIHRoZSBsaWNlbnNlIChpZSB2Miwgbm90DQogdjIu
MiBvciB2My54IG9yIHdoYXRldmVyKSwgdW5sZXNzIGV4cGxpY2l0bHkgb3RoZXJ3aXNlIHN0YXRl
ZC4NCg0KICAgICAgICAgICAgTGludXMgVG9ydmFsZHMNCg0KDQogIFswXSBodHRwczovL2dpdGh1
Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvTElDRU5TRVMvZXhjZXB0aW9ucy9MaW51
eC1zeXNjYWxsLW5vdGUNCg0KPg0KPiBJcyB0aGVyZSBzb21lIG90aGVyIGRvY3VtZW50YXRpb24g
b2YgdGhlIGZsYWdzLCBvciBjb3VsZCB5b3UgZXhwbGFpbiB0aGVtIGluIHdvcmRzPw0KPiBPciBp
cyB0aGF0IHRoZSBjb21wbGV0ZSBmbGFncyBkZXNjcmlwdGlvbiAod2hpY2ggaXMgaW4gb3RoZXIg
ZG9jdW1lbnRhdGlvbikgYW5kIEkgYW0gbWlzdW5kZXJzdGFuZGluZyB0aGUgY29kZSBiZWxvdz8N
Cj4NCj4gaHR0cHM6Ly9naXRodWIuY29tL2NpbGl1bS9jaWxpdW0vYmxvYi8zZmE0NGI1OWVlZjc5
MmUyOGY3MGIxZmQyM2UzZTE3ZTQyNjkwOWY1L2JwZi9saWIvZGJnLmgjTDIyOQ0KPg0KPiBJdCBs
b29rcyB0byBtZSBoZXJlIGxpa2UgdGhlIGNhcHR1cmUgbGVuZ3RoIGlzIGJlaW5nIE9SJ2QgaW50
byB0aGUgZmxhZ3MuDQo+DQo+IEFueSBpbnNpZ2h0cyB3b3VsZCBiZSBhcHByZWNpYXRlZC4NCj4N
Cj4gVGhhbmtzLA0KPiBNaWNoYWVsDQo+DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCj4gRnJvbTogWW9uZ2hvbmcgU29uZyA8eW9uZ2hvbmcuc29uZ0BsaW51eC5k
ZXY+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAyNiwgMjAyNCA5OjU4IEFNDQo+IFRvOiBNaWNoYWVs
IEFndW4gPGRhbmllbGFndW5AbWljcm9zb2Z0LmNvbT47IGJwZkB2Z2VyLmtlcm5lbC5vcmcgPGJw
ZkB2Z2VyLmtlcm5lbC5vcmc+OyBicGZAaWV0Zi5vcmcgPGJwZkBpZXRmLm9yZz4NCj4gU3ViamVj
dDogW0VYVEVSTkFMXSBSZTogcGVyZl9ldmVudF9vdXRwdXQgcGF5bG9hZCBjYXB0dXJlIGZsYWdz
Pw0KPg0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHlvbmdob25nLnNvbmdAbGlu
dXguZGV2LiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVh
cm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gT24gNy8yNS8yNCA2OjQyIFBNLCBN
aWNoYWVsIEFndW4gd3JvdGU6DQo+ID4gQXJlIHRoZSBwZXJmX2V2ZW50X291dHB1dCBmbGFncyAo
YW5kIHdoYXQgdGhlIGV2ZW50IGJsb2IgbG9va3MgbGlrZSkgZG9jdW1lbnRlZD8gRXNwZWNpYWxs
eSBmb3IgdGhlIHByb2dyYW0gdHlwZSBzcGVjaWZpYyBwZXJmX2V2ZW50X291dHB1dCBmdW5jdGlv
bnMuDQo+DQo+IFRoZSBkb2N1bWVudGF0aW9uIGlzIGluIHVhcGkvbGludXgvYnBmLmggaGVhZGVy
Lg0KPg0KPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvaW5j
bHVkZS91YXBpL2xpbnV4L2JwZi5oI0wyMzUzLUwyMzk3DQo+DQo+ICAgKiAgICAgICAgIFRoZSAq
ZmxhZ3MqIGFyZSB1c2VkIHRvIGluZGljYXRlIHRoZSBpbmRleCBpbiAqbWFwKiBmb3Igd2hpY2gN
Cj4gICAqICAgICAgICAgdGhlIHZhbHVlIG11c3QgYmUgcHV0LCBtYXNrZWQgd2l0aCAqKkJQRl9G
X0lOREVYX01BU0sqKi4NCj4gICAqICAgICAgICAgQWx0ZXJuYXRpdmVseSwgKmZsYWdzKiBjYW4g
YmUgc2V0IHRvICoqQlBGX0ZfQ1VSUkVOVF9DUFUqKg0KPiAgICogICAgICAgICB0byBpbmRpY2F0
ZSB0aGF0IHRoZSBpbmRleCBvZiB0aGUgY3VycmVudCBDUFUgY29yZSBzaG91bGQgYmUNCj4gICAq
ICAgICAgICAgdXNlZC4NCj4NCj4gPg0KPiA+IEkndmUgc2VlbiBub3RlcyBpbiAoY2lsaXVtKSBj
b2RlIHBhc3NpbmcgcGF5bG9hZCBsZW5ndGhzIGluIHRoZSBmbGFncywgYW5kIGFtIHNwZWNpZmlj
YWxseSBpbnRlcmVzdGVkIGluIGhvdyB0aGUgZXZlbnQgYmxvYiBpcyBjb25zdHJ1Y3RlZCBmb3Ig
cGVyZiBldmVudHMgd2l0aCBwYXlsb2FkIGNhcHR1cmUuDQo+DQo+IENvdWxkIHlvdSBzaGFyZSBt
b3JlIGRldGFpbHMgYWJvdXQgJ3Bhc3NpbmcgcGF5bG9hZCBsZW5ndGhzIGluIHRoZSBmbGFncyc/
DQo+IEFGQUlLLCBuZXR3b3JraW5nIGJwZl9wZXJmX2V2ZW50X291dHB1dCgpIGFjdHVhbGx5IHV0
aWxpemVzIGJwZl9ldmVudF9vdXRwdXRfZGF0YSgpLA0KPiBpbiB3aGljaCAnZmxhZ3MnIHNlbWFu
dGljcyBoYXMgdGhlIHNhbWUgbWVhbmluZyBhcyB0aGUgYWJvdmUuDQo+DQo+ID4NCj4gPg0KPiA+
IFRoYW5rcywNCj4gPiBNaWNoYWVsDQo+DQo=

