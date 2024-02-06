Return-Path: <bpf+bounces-21310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1B84B791
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC2C2879CD
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB4131E52;
	Tue,  6 Feb 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dY2gISft";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v4FkfjEM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335A131727
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228905; cv=fail; b=dyy9A1lzNKe5BaoCcAZkdhcD4K4GojFahCb/ISRQS4fO00PTlN5waDjeFwRQDQOmvE1Z+Hi+2aIUvMFsAVKxvjIOS2mDilNfa50crwoeuOkZCHdpXe2IPLQv+Ps+l3hQJ2NkH8OlstKxbwmpRW9tD7zp2qyjV0cqewkjZ1ID2RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228905; c=relaxed/simple;
	bh=W9YkkEZCz/EwI244lw3EfuPREa9XdmcLEKuxURW5724=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cE18DLcfMFrCO9wgFSg022XkAf2ndb9vLuSpdf1hwo7xWd7Y16xEA+QmeZUrcYqF1DOsc7VFmJH4UENMy7VoCGnUP8pen6kBYFVwFl34ylcTv04hz+i8371hszhOGUmQS3ngFFLLbQQWSK8Iz9EiRj8CLbAbYZ9cJ7yUTFQSVWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dY2gISft; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v4FkfjEM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416AExsJ021980;
	Tue, 6 Feb 2024 14:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=F+LuFIcOSQ0UrZRLODkNxRrWI1mqk3uTOaJlqCn8Aks=;
 b=dY2gISftL/jtrvAgDu0CS+rMe9sHpE7EIcbOK3nw6kuIDqMg5RB/biqpUhlzn1pQWRUq
 kHgyUYUteNzqNWqbNlqf8R9IAV5rsAJ43lTl/BIYa0T/HoDRoTudIlAXiWLAc3g/d2H2
 efgybG5kneBruGgWFuGa2E8ojeTNAKXka0St3dp7jxCo+7H6N55OIqdBEQcyvPAWhqzB
 zujkBV+gHJAFKEHvvREmIUNKKjS/d4FSMPKHVCsZzgPn5PE/ErIiiZjPa9IMKQ689uOf
 5bHzmnS0INsNF5HnKkxqTDxccRbil59sV72qoQU71/qnFtv6V9SNgnzlJyxCSGLXTwZD Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdf15r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 14:14:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416DAuio038405;
	Tue, 6 Feb 2024 14:14:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx7c7r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 14:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyMxba/sbV8fDMgw2jg5kiH9XAabDsP6YJZZbR/3mJ7dbtaRlQqG7lqxvfGPQ+u1XpVsrg56mi8eF9r2QoYzqw/F5hJD0u7yK0rhSAhwgwLLCcjoywS+yQkE6OuMjK1laua2pqzzV4ICCB3sSlpxFwMi4J96tm0sLoljCBZq815MzsTRm6d6f7CbbnZvTGdjBYX2gmAEtCclEBlwI7u8ubxfVK7G+YScL+sgCU0maF4+MJJrvwM86rEvGBbT1CT2WvAm3NleopwHknMbEo46qtWB+gk44twTBSyvs7e8NIqN7gjjqHF4aZEePWXHBRgz2sk5KqZdeaktLnSLUbPDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+LuFIcOSQ0UrZRLODkNxRrWI1mqk3uTOaJlqCn8Aks=;
 b=e3ew/HyEx5l5j7pZW6jumWVah2dpXUpWO2v8ZONZ/FAgqO68u/1wTTx6BriXMX/QxzrA1wCMQAWG13FC8/E73nKAjpj/IvPLESR5JCueEBB2Atqa0xeNI0EzJS9jrGJmzoS0uFTmjcdxZll+WiPu8H5AMdp/8/O/D68H0Y7ZVy0yWxPrlAmP8ogrZw6VFGye2u4vRgSfQklCfIAiQoTKY/UElQZLTYDDcS/LVys0vNWnTCyNYud/K9Wld8iYWYiWjmxapMlWwU44Pd6P1DMioZ+3dkFHZ13JDDjDfzmDsbLrseUmH+/ebkUHkhRs/2YpSFih343GHkWMhFJEZNBPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+LuFIcOSQ0UrZRLODkNxRrWI1mqk3uTOaJlqCn8Aks=;
 b=v4FkfjEMw7ZW1s4TF2Rv37slsb8XiAkCNZtcbWI3kX1atrHsS1Qs8I2efKbOZjb1iFsFy2joaRpc4IdFQX2xKY96gZmoY5yOEb1QoBecGl61LzcwYwcgfSenaSpW5eJNNFUc0QeM7KN3WGuuyfHBD3t12tlWmfsPaNwOU9LGKDg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH2PR10MB4213.namprd10.prod.outlook.com (2603:10b6:610:7f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Tue, 6 Feb
 2024 14:14:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 14:14:42 +0000
Message-ID: <20a19d2d-6e0f-4452-84b0-6715f0bbcbb1@oracle.com>
Date: Tue, 6 Feb 2024 14:14:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 1/2] pahole: Add --btf_feature=decl_tag_kfuncs
 feature
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Cc: acme@kernel.org, quentin@isovalent.com, andrii.nakryiko@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
References: <cover.1707071969.git.dxu@dxuuu.xyz>
 <bd8f705a5c11b14571563a63045416233f9d06f1.1707071969.git.dxu@dxuuu.xyz>
 <ZcIqRC1fOtZVv1Rk@krava>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZcIqRC1fOtZVv1Rk@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0019.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH2PR10MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: acea9d61-461b-444f-87b0-08dc271df667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uLqdRAFxpzY5mzNLB3TYGj4aOc59nN6mMNs6FFoKfzzQ1o/Puh2FQurHlroRmfmwM4dmbUzoYNioQn+Z3RedKwo7WdSUdS5dH8afsmr5L7lwqIBCsIr+gnTnCGunz93sKOcRL1zmEDDra06Hx2CK5YaOuL+TyOBy0H+//FVajIbKhwh6XA6ewsjnqbgpxU63mB9QRtaU0T0zbvMx3jltkkkY+OZfCnYJe0Ch9Ba3udgDzowkHR90s8yJaPsCiD2xx7MWhylx/p7VLSM7dZn1bYi/7eDWFeuSZ0d19KXClXP9fG9nW9qpLmlLbctG6T7b/voomR+9rCS0u/BbfcYGY3SUfqWdjS/JcfVQFjLTjgCoUiAIzx144Vr/AVf0PQ7rIgwXC1d7/onf+8sfNfcBxRwZpJLszTDs0m+x9gwp6xVxi+9iKn4g23oypc0HWorrPH7/UVO+V3kgbAqiSZ711GdmE89Mks3AATwe4SQlpA20ULlpayWw3qjyhzOO95VulSiTv5UavSu9u2OuW2WL7wobGm5u/Oecgk3Rci8+TMIIoV/EqsWMc9E/WCkQCwOV/BpEyTQEHUF03zGu4CZNTsEX/xK2Siz44+jojgZ/EzZJF2WWSEgG98oryhSKRBEwJgYzRC3D7odXKPnUEr3Mkw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(36756003)(41300700001)(31686004)(66556008)(110136005)(4326008)(66946007)(66476007)(5660300002)(6486002)(478600001)(8936002)(8676002)(31696002)(86362001)(316002)(38100700002)(44832011)(2906002)(83380400001)(53546011)(6506007)(2616005)(6512007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZjltRFc4UjZjazQyU0hnMGw4T2lCWXFuVmlUQWhCbkxhTXYvTFRZTU5idGNo?=
 =?utf-8?B?SVdZZ3dFSC9lR3pOOWY1RWU2ZFpuUHlpK0N4ZG85WDI0RVViSkZzdlp4Qnpa?=
 =?utf-8?B?WkQ0MUF4MzZRYVRScDlOL0VtMGNCMU41UUlxM0VMdFJ0bFhRWmRyMzQ2cWRq?=
 =?utf-8?B?dElqOFY0VkVadmx4VHNtQXJHZ1J0aU03aStXVndLdFA0Z1g2dFZSWjc1aW5U?=
 =?utf-8?B?Wk9GRUt6ZVVWc2R6ajlub25FTzZYS0JpZmtqSGliNmdqU0dLeXoyYWl3SGp2?=
 =?utf-8?B?TXRsM2xrbGRMYjVqbnFQbTdBU2RTWTh1S1Y4NmFFd0tERUtjeG5iNzVNQkIx?=
 =?utf-8?B?VktPUEVOVnlvZGdwT0h6VStyUGgrYTJZVkEwWjRFTUdhRXlBN1E5M3VPZFkw?=
 =?utf-8?B?UEhoQmdIKzRZM0R4NlBPcU9xSGJMd0RjNHYxWlI3SFFtbHY2T0RvMkJkMzlK?=
 =?utf-8?B?aFZ5VGtEdGFnc1dHYVFkTitvVmRaTDg2RWM4SWtpa1BINnV6NmQxUEVmTytv?=
 =?utf-8?B?THEyUnRNajh2RWU2TlZacTJDLzQ4dE5SbHh0aklOUmN0cGg0Q1BCR05xS2Mz?=
 =?utf-8?B?MHNyUy9KSW91cGtpVzE3UUVUeHBCY0YwRkZ0dXlXMEdZNmF3WHAvOU5GVWtk?=
 =?utf-8?B?U2pDY0xHKytKajAvdWdseXJMclJwcUtBL2pOcTFyeUNjWTlXekN5MzZubEJK?=
 =?utf-8?B?eHNDY01LdzA1cm5nR0JWbHpsZ3JsQWs0RWhwdTN0ZnpXSUNHUFlUelZQcDlJ?=
 =?utf-8?B?YTN4bGx6WEhvOHRzQTM1aHZocCtnckg1T0kwRDAzd1pTS2Q0RGs3TzZjcGIy?=
 =?utf-8?B?MWQwQ3k0aTc1WmsxQXJKMGZMTUcySGNIbEUyZy92UkpMSjVvdWxZVis1Zjdq?=
 =?utf-8?B?UUd0WVFVckcwcHNuQTk4UFNPTFl4aVNhc3haYkdDSytmaHExcUVueXlZOG1a?=
 =?utf-8?B?a1RXQnIzT3VxbURveTl2TDVheHVMT2ZOaHVDU0RzS0VsZGtHZUF3WFpnYTNU?=
 =?utf-8?B?aUN0VVgvQ0dIQm9MeGFEdWtYcm1sS0hYcEQ1QjBBTlBQWEtlZlJTS1NqZzY2?=
 =?utf-8?B?VGtUZGdJeXorckFoZjFRS21zTHkvU2VBZy9sODcvcExQc0pjSGNkN2FJTkk2?=
 =?utf-8?B?UG5NWk5wQzNhbi9XK2FkMk0wRUNZMGM4eUh0V0hxUzBFSlZ0K1BtbTljMFl5?=
 =?utf-8?B?clN3QzRzWHhTcE9FZ3B3T0huOHMzbUVKVitqdkxhTUY0c3YrUnpSbnNrZjV1?=
 =?utf-8?B?NllJRlpCc2dWcHR4Y0FmNW9OK1pQb1l4eW9BbVRpM2RYUzhqTFQ4Z1dEOUht?=
 =?utf-8?B?YWlDNlc3QUIrRDdURWNOMzZvRnhqSGo2Nk4xUy90YVhPVkRVTmQvRmdtV1F2?=
 =?utf-8?B?VzZuNy9MRzhXczBQdFlrVUxyRDR3NU03YjZvaDNjdTRUVHpwWUpZRU9za2xK?=
 =?utf-8?B?YlN4MGhNWWVidWJUejRINkZQM0ZYalVlRE9xM0t1TFY3ajRxWXNxeExnd2Zu?=
 =?utf-8?B?SVF0SkRBZzI0cEFaemlYMVpsaDNkVUgwa0lFeTd6ZW1KUTI2blAxakhIYUFp?=
 =?utf-8?B?d1k2Qm41UUR5ZHcxQ3FMdE8xZWlRdkdpUm1JMGc3S3Y2L1BNNTd1RkVjWWdL?=
 =?utf-8?B?azVGK3BHckt0cFA2M0FsdnNOVWRYd0RQNDM0a3ltUmcyY1prU05nNUdIWHl3?=
 =?utf-8?B?eEpFb1ZsdnhlZitTUGN0cFZsNm91dVdVUUUzUjVFcUtXUS9IYzhjc2liVjZx?=
 =?utf-8?B?NndVRXBhSGdlNmxSLzNTTkE3bVFCelY3bzI3eVM3WmVrY01WSzh3ZkY3R05H?=
 =?utf-8?B?aGUxMXZwQlJLZmVQQUwvUmNjRHFwK1Q3VU03WHA2cURrNXVKM0VyS3FiOUFH?=
 =?utf-8?B?MGNmS1RnTlpkRnhaeEo5RituTGZOeTBZOTZxZEpNMlBoWVArUWU4RGVoU2pB?=
 =?utf-8?B?di9Qamc5a2hkQitrQWVzZ3RmYWhyTmhIcWRJVlE4TVVGT0hTVmlMNmd4YzlM?=
 =?utf-8?B?ZXY3SDQzckFzclcvZHIzZ3RncnlCNmh0U0dNQUVqOVNmemFIMHZ4QjVtWEp4?=
 =?utf-8?B?UTFCNTN4RHRDT1ZkU0YrSDVrT01SWFBwRFNudHRFRXJpNHgwU1l1TFVvc2o0?=
 =?utf-8?B?bjAwSWlGMWkrWEZUWGJxNEtXNkk4OWdPTnNBT1ZrUjcrL1UwMGIyZzZwQ21M?=
 =?utf-8?Q?WA053j/of6Vnhq6MPZONAGo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	G+T36IFjXsGDk05W4dp1Uo3WgMP0ArdVecJAPiKfVJywtbBW95GqLkGOhKA/zcj2h3LnQqawc3t2iyslHUrpdIuWkQnstIC8bRFrClOUxa9J3f8jlpPHruWD7phPdl0MuQbX+HeeOgbvjlPdeXTTUjrjL9Ux54QL75OJLFlyQTeMlQAmlbp1T7SmFY9gYdQ5gEzh0uclXbZWFZkBxXjiDUKC+ltP9P/bDlpbaLNagS5C+bgYSMvHGMxjq9TVF3b4sVouMBXn+75Ert1sGMnEFiYEDRvixH3rhPx1xPCNMlOhXfOh1AqfiAhR3qnEwCFPNMCfSrTolU6v9Aa3qnIDp9bOvkx9iADk04y33VC/4MP0Lfv7TbezpZu371TAY4YCBflRxLEYLJrKSjiOtK7bcMVmiWIcUn1RerSt1cWfn8LkWDgCUtNQ2KbgRSN3lRryWIYlNnpp3anwR7JFYqxvGtYmToJU/RandXXOE4hrAsERfuVIPzYYXNhsqreBrxx2HFx/7cFPMByO2wr+0oOtXEUIxqVtUJzQzKe6f4giJ/5liUJKQvMSLC4m4xWhE9CQ1bL2kI8aLDNJNC+eXH4PC7fAoKZ01lyb+TIYY7aT2Tc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acea9d61-461b-444f-87b0-08dc271df667
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 14:14:42.3995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciT93S0FxI/wffgrvIuGPqLyacZ/fNiahFtfTmYf6sRdXS2/KCpITQZ/t1YwAdPjp34u2KdrKTpkQOp1Jp1tmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_07,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060100
X-Proofpoint-GUID: dILs05sMIcOJ1olGLsQV92gjLMpcoyHF
X-Proofpoint-ORIG-GUID: dILs05sMIcOJ1olGLsQV92gjLMpcoyHF

On 06/02/2024 12:47, Jiri Olsa wrote:
> On Sun, Feb 04, 2024 at 11:40:37AM -0700, Daniel Xu wrote:
>> Add a feature flag to guard tagging of kfuncs. The next commit will
>> implement the actual tagging.
>>
>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks for adding this!

>> ---
>>  btf_encoder.c | 2 ++
>>  dwarves.h     | 1 +
>>  pahole.c      | 1 +
>>  3 files changed, 4 insertions(+)
> 
> we should update man page as well
> 
> also we need to update the kernel's scripts/Makefile.btf with
> the new option for the next pahole version (1.26 I guess)
>

Yep, something like this added to scripts/Makefile.btf
should do it:

pahole-flags-$(call test-ge, $(pahole-ver), 126)       = -j
--lang_exclude=rust
--btf_features=encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,tag_kfuncs

This should hopefully be the last version check we need - we can
just add features to the list as required, and pahole will apply the
ones it knows about. Thanks!

Alan

> jirka
> 
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index fd04008..e325f66 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -77,6 +77,7 @@ struct btf_encoder {
>>  			  verbose,
>>  			  force,
>>  			  gen_floats,
>> +			  tag_kfuncs,
>>  			  is_rel;
>>  	uint32_t	  array_index_id;
>>  	struct {
>> @@ -1642,6 +1643,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  		encoder->force		 = conf_load->btf_encode_force;
>>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
>>  		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
>> +		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>>  		encoder->verbose	 = verbose;
>>  		encoder->has_index_type  = false;
>>  		encoder->need_index_type = false;
>> diff --git a/dwarves.h b/dwarves.h
>> index 857b37c..996eb70 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -87,6 +87,7 @@ struct conf_load {
>>  	bool			skip_encoding_btf_vars;
>>  	bool			btf_gen_floats;
>>  	bool			btf_encode_force;
>> +	bool			btf_decl_tag_kfuncs;
>>  	uint8_t			hashtable_bits;
>>  	uint8_t			max_hashtable_bits;
>>  	uint16_t		kabi_prefix_len;
>> diff --git a/pahole.c b/pahole.c
>> index 768a2fe..48c19b7 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1278,6 +1278,7 @@ struct btf_feature {
>>  	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
>>  	BTF_FEATURE(optimized_func, btf_gen_optimized, false),
>>  	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
>> +	BTF_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
>>  };
>>  
>>  #define BTF_MAX_FEATURE_STR	1024
>> -- 
>> 2.42.1
>>

