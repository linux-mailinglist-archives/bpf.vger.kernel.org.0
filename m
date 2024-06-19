Return-Path: <bpf+bounces-32495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88DF90E2FF
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 08:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5480AB2375E
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5AA58AB9;
	Wed, 19 Jun 2024 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UmOxebml"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158F4A1D;
	Wed, 19 Jun 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776817; cv=fail; b=nGpkhqkj7B/z0nKqeaOxsm0qz5W+2fWtTJ4vJe2YySe6QYW6JFwIAhlBWBphjRRnR5imljzJwhqnAzPABzpJvWdwcOpZbFXorRyB02Gzx1f1gVwGY0BSwj/qmkHSEBRRfD86+rx/T99vPhjLUvPLhc3k7vZXpk49mMj0MAUaOys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776817; c=relaxed/simple;
	bh=KulZOAJ41QZO2mN83hqNFVwhMbg/m591hSFfGWLsL74=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lqr9lcUSaC0PnQwycXuFZjEksPd0pyun+m1IDM2tdKGhhar8Oqic8Z7W3qdxW1R100oAK4mq2FO0Hd7oJRy6knkHCB0dYpHDqosUKt5kGrDuVUzeyVjFUqj2D9IEzjxl5DdxpkhMRYZ3yFfo28jA7IAUFVmPb6So2hV2Bub/WbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UmOxebml; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCnhp5SIGomsaz0n/gcIpnKGbiVs6uojsrgoXy9DuW3jktp9ZVQvgt3SH+zVqPXp1f6QaIeTz90IGfu8iuOhVE/u24RDm49IKYJnKLk8OnzMYyl0JeXlNBfafpkb2GJ4Tiu0KHR18Pk+gprWp3Nz/uZGwTUVKA3RLAvMfx0nsnsWQh50yqx54+86/uCh1yL3V75Gtc1j/wx8ZiA3k9KGbXo7C4jrxEQIhnh2oH6aFZJEwASA2hYZHD7cvVpUBNdOKrMo/WX85Mfwf5a6YwCUNw4yATasKbmrKDtGu40eYGX6jc1sCZch4K4LTAuVW5ILte+Z3KIEJnFhTzK7KPuxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgv/hsX4y+krvVUfwi+r1YeemBxrfo4qy+sg5zjixrk=;
 b=UFFGTmW6dXbfpBqCsT609b2QUQ5wjRVEKxMgJyALSPrvtbfqq67HUwuFOof0fqeTer/LV1qSTp4U2ySfyz7QY9aUdHGDyrQuHZlUzysdoedy7+gjAObygI26wRoKoBP8XG4EZOnVRhe64jWfyt25zipeUZRBepY+lRxtCjDSbbOGzdTv2QCzMUAakX+Nc/XS4F2VdVJ9HiAendijNZ7K7x59lMXsOCULZTW5eDRizqMPQUEv0xWOZoC9o4HDkcYot96b0pmfvPh+hNfPniIwAkLOhpbH9sUn8l7OKqOphpQk5AV4XpprstzPgmIq94m77yZSQmAK03IWkNJS0LPkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgv/hsX4y+krvVUfwi+r1YeemBxrfo4qy+sg5zjixrk=;
 b=UmOxebmlNbJSWfF+9NRF+OS7q1DT29izBl81sPn8z1aqU2lVI+1hUxL3BavpLDzpr97nGZ1tCSM+b9kKB44LS30pe+67l/gW/juGMjbZH1crbrJJhXjrkjNQxieYX8w8VeZwlvxeRMAmdt2t3pNLMc3I++sYTTSfMCjF1iNMiX8XayIlwTrfOva2Ui0r7D128ZSMGeq+i/u3GK8TZXkXfZ9t+J87DchEkLiw1u0n4fgiA771N2Dnny8AHda96yKGgzbDnryum0SV75dkbRY2jeenuGf0YhCdSd3v5eGUPspb2eI1JPiAbvrJH+umdezkXKlzW+dcp3Cq6y+OpmCzeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 06:00:10 +0000
Received: from IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed]) by IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed%3]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 06:00:10 +0000
Message-ID: <36075ea9-95dd-4dd6-b2b6-440916079578@nvidia.com>
Date: Wed, 19 Jun 2024 09:00:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: XDP Performance Regression in recent kernel versions
To: Sebastiano Miano <mianosebastiano@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, hawk@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Gal Pressman <gal@nvidia.com>, amira@nvidia.com
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0504.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::23) To IA1PR12MB6018.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6018:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df2c613-b6a0-40e7-2241-08dc902513a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjRmaHIzNnhoVUhxV2VWaUZpMm5DTUxiQ29ZOEU0UUVRb0xzUGh3WGdoWWxo?=
 =?utf-8?B?WTAvTmtZWkR2SWdDWHAyWXRyVXFBMnMxK2wzOWo3NTNSb3A5Z3FXU0t5Qngr?=
 =?utf-8?B?N21XbFhGUnBmWXpJL3JsaE1HNlRVTTI2L2s5WGw0eWdSVEF6aHdzNXMzODg5?=
 =?utf-8?B?WkU3bExSZWJwU3ZpSWd2Snp5Qk0vdzNQOHc5ZWo2ZktVUGdPT0tXcHI1Y29t?=
 =?utf-8?B?ZGhuVkYxV1E4Nnl4LzR2MS8zdkdwcis2cVhId3l1cGcxQ2FUeWFvT0ZueG5j?=
 =?utf-8?B?cDBhN1dFQ25JQTlZYkJ2ZklFblJsNFh4N3hnU1d1QkYvNE5UNEF2UWJxRlpu?=
 =?utf-8?B?TDBiVjhzU0paK1hzbmRqekZrL3FlNHZCUXRqZnJtQmFQdzZqSlBBR2R5d2lj?=
 =?utf-8?B?dyt3Z3Zva3dTZVdQRW9DV0hYbWtmZ0xnYkRFTG9nclhKODJrdUlLbklwUWl5?=
 =?utf-8?B?WVBFWXptcFphT2daTXk2Ty9QaUFicEhGRVFuY1V5QXhaSTJkdzNySVVjZWFW?=
 =?utf-8?B?NU9lOXlRVGE5bnFEWlBodkxoOE9Cc0hiV2thUUl5d1MwblpjUEZKYUcwRHZU?=
 =?utf-8?B?NDBDZ2ZTdW9wWWJhTGFBbjZjZnNrM2RIeVVTYzdKNDVlaXRwcjFuUVVvU1Fp?=
 =?utf-8?B?TXFEQy9MaEJOWVF4ZWkyYkVLbk9FaVpaSDlSa3hpVmJDTHcvUk1mRVVtZEt5?=
 =?utf-8?B?L3MvdDJocXF6Mk1CZGtQWW1tYUorWEVmeXZ0M3BpamxZbVpPMll0Q29uYUdi?=
 =?utf-8?B?Tm5NbFk5ZnNmdUFkQzR0Y2ZZVTgzOWt5eFZkbFo4U1phdWN6bUxnQ0ROTmJ3?=
 =?utf-8?B?N1p2WEJ2TWMvNUwzSVlFYnNmdk1KWHRmTldOR3dBWmMzNHNRM1BOaXZIUEdi?=
 =?utf-8?B?VXU5WGxiNDR4S2ljYzRCb2gzdnNVZGVEOEZOY2k0UXcyOGsxeEtaTld3NXpY?=
 =?utf-8?B?b2s4NUgvZHdDMTIxdGNPZ3BEblYyYU1zZEorbm56emhtNVlnRWxDTnA1YkV0?=
 =?utf-8?B?dXhNRFlUcEJ1VVd6NnFQTmZpNUt5ZVIrQnVrNGRkWk4zd0luamRSeHY1MXVC?=
 =?utf-8?B?dlIxdVB6TXhCZFdCVzNyUjFYaE9BMlZBWFdHaFRjek1YUHpmK0l5cHBsaXFh?=
 =?utf-8?B?Mlk0bEJLbHo4NGFSOUk5b09FNmFmNU9Dem9wNm5UbmpNMWJ1TXFpNk80QTNw?=
 =?utf-8?B?Mmc3ejAyRTFvd1NRMDVkbVZOR1B4Q1BIQkhZSTRjZUpxb2w5WGsrcVp3aVQ0?=
 =?utf-8?B?b0lUeXBicWlNdkVES05VOGFzUGJOMVluVkJ2dWcwcm1tSEhBZ05qanVXWFBD?=
 =?utf-8?B?dmxUZm12TTdLblpDbDdHZEZkcHIwbmhEVXRRZGtrQU9xemxpM041S0RuWVQy?=
 =?utf-8?B?L3dJbllGMlZlcW5xMlpXcTVkeWI2ejlpM1M0TEV6VUtiMmVOTW1YY29rODdz?=
 =?utf-8?B?cjExR092Y3RWYWtXNGF3MWcrWXZhcUFaMjNtd0xUL2RmZzNxVlY2a1RTSjNk?=
 =?utf-8?B?bFRLUnNuSGZxODhKVUVYSlE2amJsTUdPQ0FGSWZFT2s4dWpicXlIWG50cElL?=
 =?utf-8?B?TzJRb1BqVFFPcGdub1R3ZWtFZk0ybUtmUTl1cDc1NVZlaDg0TlEzMjE1Wlox?=
 =?utf-8?B?anZoOVdKc2Z1bG5hMkg5NUhVaWxZZUJFZkZYWDhMSldEd2NncjVKT2Q3ZjV2?=
 =?utf-8?B?clQzbEU4amRkRVNZYjFJQ1ZHc0dLT2ZpY1dwUjVvWnA2aHVwSDYyZlNiUjBm?=
 =?utf-8?Q?KzgOmHbPNwvZZfp3G0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEtrdENlWWh1bmtUT3loVzl0UTlObjh2U3BpTGtIN1M2V1hQcENkVjA5T1dn?=
 =?utf-8?B?VXJOdG04NTV6WWx5SXhhVFA5RXRyRU9OZzd1OERFT0NoRGpjUXpoVjZsTmEx?=
 =?utf-8?B?YkVIWlVobTRMSEZRU1dBQXNFQ0Fkc1pYWmpzRVpNQjhreUdCcXl0NmdYY1Bm?=
 =?utf-8?B?NEpqei9PUS9PQlRsRGxWZUZGU1N6V1RNZ3lKZ1I0aWN1cE03OEhhNkczZFdW?=
 =?utf-8?B?NWwzKzdQRmsvUndyV0tkMnlqakpmekVnL1lXL2VQcjV2V2ZsUWwxeGFDbmxG?=
 =?utf-8?B?S0hjaFUrVXFQbTMva1NJby9VME1IblZ4V0hhWWxRT0x5eVoxVFZVY3hVUFpN?=
 =?utf-8?B?aGRjb3FlM1djVlRLdnQ0OFZMdC9tQWVCeXdUTEc2MXR2MGN0Y2U2ei9CejJR?=
 =?utf-8?B?TnRCQy93czdGZDlWVXVmUkFObUZvUmFMa1Y2elBtSHg0aVc2amlyOFdUSHk3?=
 =?utf-8?B?Q1RDTTBuOU4vU2tQbWVTOXBMb2ZFazZ1c2hFNVVUc3FzTUIvMkt6aGl2TG5M?=
 =?utf-8?B?Tk85aTFBcjRSWnRNbk9qRDhFZGFDQ0E1bFEwdG80ZXozMk5yYmM3N3JHSEcy?=
 =?utf-8?B?L2RSYXppQXZDWithTmVRY2lydGE1L3BXUmZNNmhCbU13Qm4yT01KTDZrT2ls?=
 =?utf-8?B?cEx3cVpFNFlxU1UxUE1CdU1VUTBQY29GWjB2NHMzb2x2cDYrdXFOZ0crMkg5?=
 =?utf-8?B?eWp6YmtSM3lXVUxlMkVWSzVWTlZwdTROZjFOeGlFMjVibTFKTzlnN1VGdklj?=
 =?utf-8?B?Mm40blBFVVEwMSsvSXdwSkd2RFFqZW9LRi9LNFlLS1NJejk0V3VQQWNDR1FN?=
 =?utf-8?B?R3R0cUxRSTV5ZlNwMi9rY0RiczhLZGROV2RqZFdIVXdCUUJOZWpOY3R5emw1?=
 =?utf-8?B?NklxdUs1NUVEV1YySnZJUC9ndWE4bjlKb25VKzhVUllxN05GV2xJVHIyZlJw?=
 =?utf-8?B?TnpBV3ZDblQyNHBzbnh2emhYK3lyRTZkaWpmSVBYYkI3aHh3ZHJZVjNhR2cz?=
 =?utf-8?B?NjVXOWNYUUlPSkJFMk1OSFJvS3ZZeWUySzlrNlR1Z0laemhTb0J3dTF3cm9R?=
 =?utf-8?B?akFoOHVCa2lkYXZlbm1xZGVOai92Q2RNalJmQ1F1NFZ2RXIvSWdOZ0FFNDUx?=
 =?utf-8?B?R0E1WmxYQWdMQXpuWEkyUkNUSTE3Wm9idUhUeVRocmNPVU1RRWRoNTEzTDU3?=
 =?utf-8?B?eCtKaTZGSUp0MXhTZVlmdVN2WlhFQWZqcWFHbjlmUVJtR3Fmc2tCK3NOZEhp?=
 =?utf-8?B?SFk1c3ZwelU4NTlCVGNsM1l3OFE2TUFEVWZ1b1ZBcHZsaFpZRis3ZjBVTTNX?=
 =?utf-8?B?bkVlNTdZSUVHQkExY0J6anBuTGxJMlpISXBNcGxOWXVLb0lpSGFlT1JZSnFT?=
 =?utf-8?B?ZnJZZ0RDWWFxNmdxNTdCR0hMQmRTbjlUOTZGZ0Y5SVhhQWt3L010a29CY2RC?=
 =?utf-8?B?VjdPRGZHSGM2YW5QSUk3RWd0SG13ZFBrNHZjVFBlU1RTVGVxa3FGdlN6UzA5?=
 =?utf-8?B?RzNFc2lMa3J5elFDcU1KY21GSS9iN0tpQXB5RVdKR043RlFQTng0WkptV1pD?=
 =?utf-8?B?bkZyb1lMRHhJdkVLcURDL3EvVUJVbEZCNVh5Q3dmelR3VlFrb2ZGSis2SUF4?=
 =?utf-8?B?NzhVNTViNUpZb2V5N3JHZFgvRDFKSG0wUWJwKzUyeGdCcERVa0RKbHB1ZmRS?=
 =?utf-8?B?aVM2NjhneEVnQW9TeEpkUnpDblFEZHYrd0t1aVo3bW0xaUR3N0F2UXBLVmZn?=
 =?utf-8?B?bm9PU0dHejhEMXVNSEZ3enovbTNqRCttSE1EUFZ4QUVLL3VDQ0k1WUN0VzFr?=
 =?utf-8?B?RmhLTkZncjdZTCtMWXlCM0FGNWp5NEdvRi9wY0F5bGlQYytYYzBEa3pLR0Q1?=
 =?utf-8?B?Z1FGMDNqQjFNc0tmQ1N3QkZZWFVBTkdMZHFHSEZPSzZzWEtCTXRRb09IQnN6?=
 =?utf-8?B?bVlDTUtxNXZ0OE1mbEN6WnRRTHdibUFxY3JKdjBUVGdqdkE1eVFrTzRiS1RY?=
 =?utf-8?B?NFJzdnBuSFkvcHFod1kwSkRqQXN6Nk16bVFUUE01eVl0ZlRPdWdVYkMwL0Fs?=
 =?utf-8?B?RmJmWGY0bWtjL3ZFcDZDSHRsNXNXNmc4NHU5TGNneitmNGo2QUg5Q3VwVjg1?=
 =?utf-8?Q?2VYk9fgm619vaIym3AUulKrBS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df2c613-b6a0-40e7-2241-08dc902513a3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 06:00:09.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6Iuly95hXH0Iu1nss0m/rmVWReNhxFNl1GN+bX0XNFKX8afNia2FkBlJtANOWkr6Mg/dzBycYV5mSJVhZsMkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856


On 18/06/2024 18:28, Sebastiano Miano wrote:
> Hi folks,
> 
> I have been conducting some basic experiments with XDP and have
> observed a significant performance regression in recent kernel
> versions compared to v5.15.
> 

Hi,

> My setup is the following:
> - Hardware: Two machines connected back-to-back with 100G Mellanox
> ConnectX-6 Dx.
> - DUT: 2x16 core Intel(R) Xeon(R) Silver 4314 CPU @ 2.40GHz.
> - Software: xdp-bench program from [1] running on the DUT in both DROP
> and TX modes.
> - Traffic generator: Pktgen-DPDK sending traffic with a single 64B UDP
> flow at ~130Mpps.
> - Tests: Single core, HT disabled
> 
> Results:
> 
> Kernel version |-------| XDP_DROP |--------|   XDP_TX  |
> 5.15                                30Mpps                  16.1Mpps
> 6.2                                21.3Mpps                 14.1Mpps
> 6.5                                19.9Mpps                  8.6Mpps
> bpf-next (6.10-rc2)        22.1Mpps                 9.2Mpps
> 
> I repeated the experiments multiple times and consistently obtained
> similar results.
> Are you aware of any performance regressions in recent kernel versions
> that could explain these results?
> 
> [1] https://github.com/xdp-project/xdp-tools
> 

Thanks for your report.

I assume cpu util for the active core on the DUT is 100% in all cases, 
right?

Can you please share some more details? Like relevant ethtool counters, 
and perf top output.

We'll check if this repro for us as well.

