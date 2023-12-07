Return-Path: <bpf+bounces-17010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B7808B02
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 15:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F411C20A94
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427040C07;
	Thu,  7 Dec 2023 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OkHyhRaG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QaPehp3i"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ACAA3
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 06:49:25 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7E3tJI018123;
	Thu, 7 Dec 2023 14:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WN5DI8M+XI+birDomcUdqZZjMj2IuhXv4ZHMlHF2Nig=;
 b=OkHyhRaGOfk/SYa2D8hPjELw9UJJGn6pUUUvleQ8n/U/sCW0Uvn1XQ6cCND9XucNQsre
 HtPxGRLP1+1uzmfgc8olsO42mlrhjvpVF9P0ZLFo1G/hzdtglZOHtCoVA2ITd3MFWjQ7
 AGs54OuvnZoa34ThhXpbTskEgZlClxOjhg9Z+z1itv8YmFLyW/B+UB71pa/hTEocq3wV
 SJizpO/Qs3arO7fBTBc3VSLJGheJF44e7uRvQfyGWBnY/c/OsF8B+odlUIjkITtlrtZw
 6HtiEWcaVppSXxjUw9iog5yjRYIlgV5UPMzPPG2NXO25DekZ2v9sZRO2G21kk88fVlhB Qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbkx9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 14:49:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7Dbno7038146;
	Thu, 7 Dec 2023 14:48:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utandj6jy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 14:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLRn7jzOKDGcMSKVzNDHKW2t/+JsT9xuCIVAsMXzJSdwc8jxOFIHESNQnVuVoQJq1OfpVP8y0UFPWngBMsBR++BiNH9vaoNxuUqETRKG5FuFqWYs8r7Zio3ED4qCnXJDWwXMq49/Byldm3cNFI7pzmDeFWl95rjj4mjHy5NnokCm6bOQAadHYjFIZd7B3rQZ6pxjYAiV9y9mo4JzDROZuqOlEeSCxAHPAAvqRIjFBnwd+MiYSdfLJKef2D+h5Ya/+RbBEPj5S0FmNc/QfIrXDHPQPlXR49F7xueYZwP/cuRXm1CDHzANWiBaNl2UEDUee4JieaPoGXoGkzhGlzI9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN5DI8M+XI+birDomcUdqZZjMj2IuhXv4ZHMlHF2Nig=;
 b=TzW/PUs94/mSv5GuiYKCCP0ew5Prs6a69reN0IeR85t6B0HVmGXP9EkiWFE5s+km3UJ/91xKpSPpbqwEDlsq+9UNs2Wpt7PWBsFTIaBvECp8dfwBZUTMimGgtZci2nWSZ5m4rknjJDSvAtEkrdjI6Mcc9xUDoDJHgslAP8F11D6QSbxEXkPeI5joyPia/gxSfM91rhOhFVtUMUxfHUVoRFM6azmeoeaH5SbRf7T9O0+1zIWPMubhqBl/YKjA8nAV3KDLzqu4fqrkVrN9DiU2+kjOeC2dftUIp3eLxnCR/0Ps1+GdQvbUj6XFhLz6uKNquiyG3QTKFml0Fra0ChBxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN5DI8M+XI+birDomcUdqZZjMj2IuhXv4ZHMlHF2Nig=;
 b=QaPehp3itVGS7RRQG5qOmQrKTUbc3zzNsAGH9kTgR9F9M6cTQ3ABv9Dap5Cb8LPeXmNFi9mdmulVlG6Bid+fK9JwLv4pnQPurdT7gPWfGjJqKCvTx1hPbREdXTM2LRR5u+wCMjAJVPPNgWpXPOR6yLn4y6fKeWUA4gXim6lKatE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN0PR10MB5957.namprd10.prod.outlook.com (2603:10b6:208:3cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 14:48:20 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 14:48:20 +0000
Message-ID: <c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com>
Date: Thu, 7 Dec 2023 14:48:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with
 overwriting
Content-Language: en-GB
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
Cc: song@kernel.org, andrii@kernel.org, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, xuanzhuo@linux.alibaba.com,
        dust.li@linux.alibaba.com, guwen@linux.alibaba.com,
        alibuda@linux.alibaba.com, hengqi@linux.alibaba.com
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0003.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN0PR10MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cd12ea-9b6e-42d5-6673-08dbf7338e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r4fyGVP7I2p1IthBAngflPyYDGOnvRv/WmWsO/JAOakPIcXDHe0AhMHi0oN4+jghrrZvoV2f1xIrrEDnSwQTaDAvv6bfna0p9zdAdFXlUY0r4dd3IYrSLck4yJq2riI/TzKHp+GioChwHuHaTpemrqXjWqgBjtenoMXRpkeVpP99cC46UUi7AvPqsh/UkYV2IfIz3HduizBNNJtfYCSfoZdG0BFvit/DwZjotoyvJadK2Ki/5KEJR3R9GU4LHri7ASgGpTBrqY0u5tV+ORejJUt6VeFUe4tkA+d6jbdy+zT2Mk5pJ0/P86f19bWfJRBiIGiQCmco28rXO8wjm78HutwJ7l5OKbyGp0edZKPV30SJpJy7ffwW9jo0+aLmtrG3BX+sNMePPDCAIdhaunyUKRV4nSmaKqSmPdjBwDgyOOLPFlwTqSW/LiZHl/oXL8ZtS/crU6WdHh7NBAXihiix3WYOB4acaro3vUQ+TP0WjTlzueZseEl8yNhvFZqcOmfX4BZXeEY537spfDGwatyZgBCMHfi7LlQLJmAteaFqbAo5tBEI/2sAGDTtCKO4DzwbHRsQeE7gOU2RBXvNpz6tBroQQawPCIxXTKTJk74iQ+pn5AaaUnuohjqV5IFu/uS3pOevTJqU6Z1Thi9xoA+uwg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(5660300002)(4326008)(6666004)(6512007)(6506007)(53546011)(7416002)(2906002)(966005)(6486002)(478600001)(44832011)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(41300700001)(38100700002)(31686004)(36756003)(86362001)(31696002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVkyYVVGSWJtblBsRU5NRkprdEJRUlZZbFBYaTNXd252NFJaVy9QZnc0NlNh?=
 =?utf-8?B?NGIyVHJqOGtvSHVrcTZWbkNlTXdaRWZGMk1jeS9VdXlQb0RmR3Q4eEN0Z2xY?=
 =?utf-8?B?SnNKTk1KN005Ky9NOGZaWVdLMEs0UUZhRHdwa2pQaFcwR2NwOXFuekZYUyti?=
 =?utf-8?B?cFNjMUE2Y0lmWGJDMjB4NHBMT0FYa1VhWm9KMmNSai9XdnhQL1hBM2hRZGVI?=
 =?utf-8?B?WGI2K3p4ak44WTBNMnIyM1NZUS82aXB0azRMdmE3L1pjRkxib1BnOTgrM0pM?=
 =?utf-8?B?aXEvUHlCS3hXQjJoc0k1RXBGQ0NPd0xYWVI0QUtic0w2U0IzUjVJT3NpR2cx?=
 =?utf-8?B?TVlVeFJrUUVpc0xYRFh0NXh5ZXdlMk50dWJQcjZNUVFPR0c1bW5qdCtjRW0v?=
 =?utf-8?B?Q2h5UW9qY1RWazJqMWEwZTZMUVZNeEhVYkwrMXBFQjl6QkUvdVErdWczSzZT?=
 =?utf-8?B?anBkKzZETllGWlVLYjJzYVk2THNyVlR1TE1tVzBnUFdrVjQxM2xLekNabnhx?=
 =?utf-8?B?RTFnNUdxTjlKdEtGSW44UXg1MzZWT1NnaUxVa3JBKzc5RSsrcFZ4S0dYdTFY?=
 =?utf-8?B?UldsTFQ3VXVTQTZ5cEgzNy9GWWVKdEIrTWJiSGpiS0VkSzZ1OExvRjh6Z3NZ?=
 =?utf-8?B?ZTlaWUV5RDlHeVM5UC96bmNkVTkzRUNxNlBuUFFudWhCbDRXTUNESHBYL0hS?=
 =?utf-8?B?N3g4cnRFZG53eEN5K1U5OC85eUFwQlZKNWhad1J4aGgyNlgzZ2JFL2pKTllK?=
 =?utf-8?B?bTJTSW5nVlFjWmxkcWdjbHdLK0dnbzNsaWIvRGxhYU1vamU0ZGpkcHpDSXp5?=
 =?utf-8?B?V0wvRlRWWjZiRkE1T3BYZmpYT05zRTJwU2RiMzZEcEhrOU13QWlJbU5sNzlh?=
 =?utf-8?B?RGFjdkR0R0tqQmJpQjU0MXh5ZVpLZ2V5TlQ3V1lMR1JmZ1gwTW1XeTBlNFBo?=
 =?utf-8?B?bTlhTktwaG96ekRMa3VDZEJyVHhkZEJ2WjdMQkpqbjBjZ1RwMlhIREdvRlo1?=
 =?utf-8?B?WWhsT2tLVmphdlEyUDB4QW5SbzZUYXZtb1pnaVNlUjdTS0UrdHJHSjMwanlk?=
 =?utf-8?B?MTFLTnlIUm1vTFBFZjZ0azBKNlg2dzlGRll4a3l5NUtwZ2IrWGQydlhQY25u?=
 =?utf-8?B?S0hCMFZDNzJrNHVKVHViYTU1Rk1CcU5lVGNKYVpSR3FNVGpZZDYwVkQ2NVdZ?=
 =?utf-8?B?ZEpvMTZWMm8wUUMzVEprVHV0RWFiNFpSOEtEMWk2ZjFuRmlteUtnR0pzemJD?=
 =?utf-8?B?RE5LcmU1NmpQbUpGK2pBQlFVNUtYakZxZWVDQzZIK2xVLzJlUmI4dlRabVAr?=
 =?utf-8?B?Ny90aEd5RENRZEVabjNyNm54cG9YU3VZRDNzanUyOWhaYmtUNHFoSDNEU2Fa?=
 =?utf-8?B?Tk5JL0tCZFQ5aWhHWTdNS1RYMEJ2N2huUHlQL09lMjJOblQ1WjBVK1ltLzJB?=
 =?utf-8?B?RVhkUVNKbjVSSWRqSXQ0RGs2YnJLZG1vd2R4T3Vlc1ZZTzZpSHhMa1h5WHBx?=
 =?utf-8?B?cVFwTTc5MnBiT2J3THNvcXRvZytzWTRTOW52anpGVWJycWVtT0xIR1h5ZG9n?=
 =?utf-8?B?KzNjbExhSHZTenk3b2tTcWhRa28vc0FsSkNQTmE2NjlFUVUyVTlCMjNVYzIv?=
 =?utf-8?B?TFp6KzVnSEZYME4zQitSSkkzK1ZYWVNRSDhEWUt5KzBBZWNaZ1VKbS90eTNG?=
 =?utf-8?B?ajJ4NUF2MFJoMXdkUTM3dEVZa0ZiWXJTUEpiZmFHMVhLMnRmWHRjR1pGbXFh?=
 =?utf-8?B?QkdxK0hRWjc5YkRMSE5GcHdIWmNoVXcrN2Z6MjRxcGZHb0U5WXNtSVdRRmFa?=
 =?utf-8?B?ZW5rV1o1TllnckxIQ2cvUThmYjdGZWUxdlh6Ynh4N2tRRld2WGttcEU5dmtJ?=
 =?utf-8?B?bEUwZmo5ZllMeENxeVZQdk5xYVl5MmhuRnlCQlZtaDUxVDIrR0s0a2krMzBX?=
 =?utf-8?B?L2l5ZEovTS9QWFZXYndCRmVtUnJWeGxJK3dRTytVSHNaYUxZdDc1THlLbDM4?=
 =?utf-8?B?ay9BRm96UUI2NGprd29ZbS9nUkF0NUwrMHR6ekRwMzNaQjcvcWFueVQ1NUNF?=
 =?utf-8?B?R1M5Zks4MlVYVDFrYW9MQkE0enY5Ty9BdW9ja29BbEdySDk0anpNd251eWZn?=
 =?utf-8?B?U3RJNnpUSDBqNk1DRlVtcVBvbitCbG1RRXpCM3Z3UHZOSS9MT3JVNzZxUHFM?=
 =?utf-8?Q?t3peoj/orjeRuy+eVxm/9ys=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BYNIXPaA0/Kew80zBgdX0INAKFN5PsvolAU/l1719k7OvIZruz+V4DMRXMm3V3Id+nq2yyuc4N/cVAp+PkCAq8XfV7nOHx9IVlojdNkE1WkgSMubs04d9x/51vVE63ZecnzlVbgkkMpgIDmvbgx8lV8PJrGvjte0QBlp+S/le69RTntp1wVgdHxozYNVMAvth0bsrP0b4TnlKsEQqtxQDutur64opULOaT2hM+lURA66VHZC8PSh+ZkcjX5Pwu4QH5XiawrM2KWzdH7oqVI5gKarI+kCMZK+LbZUt+oCSkB8vZBFBZ29EbuWsEsbqgu6uNpojgSe+ITvyqZkUNpOS6rRsoLYIl5SQxgZmyNffw1A24ccBgv1nTDwos1VFTgKFp6gsaAfRyAeGW6GYxAmykUDA7XvqcccB1yqMR/QkXdone37yWA/QXP6Pia0x4sNWaIyggkAG1cVwlB9+nxYbrvS5xkXCvTbC2n+xdyvqFdZZ1TZMfVh9Ehc/8lb6Kl6VNEffawcVi3/LQ6qQXdCiW9T9qrTh47nA/xQirMo/MHobFNT2/IycelAMWnSCBMciE1peEfGe6jX65W5blSTsYy6x+pY5H+xP78hlxXBmG/zmpXORwLpnlSRiUpFu1fvS0qsfON/LX8vHcw97ZB93qlWblA8uqCHE5R9m+rodRntwKDFxnUJHJwRT+eAmqGs0haZkpvirurszE+/XVucTUZCygCOa56o8Ke0Y9EQuMqetI0dSMFWXVkSA1uBdS1AO6hn6+/94EAJ92NDW6Fv0hZLSyb5Pd95c6nHVMpC4S2HzLWaPk9w/DPTEelpk0h6eNac3lLTPO3nPt9SNb4Js5g1EZTjd3aehdluESvSqqjiP5Rtk+EtvyGS1DZ4X2dh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cd12ea-9b6e-42d5-6673-08dbf7338e13
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:48:20.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJEDmg1WmQDtl7SgBtC3hCkKud9B95qCUpoEDkm/Mm6LT0syIqGfO3cL5QMa1KWM8b5K8stPMxEVe+rh3PxsQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_12,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=541 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070122
X-Proofpoint-ORIG-GUID: kEw_8-E5ukF3IFN3qjUgnGIdknZBS9YO
X-Proofpoint-GUID: kEw_8-E5ukF3IFN3qjUgnGIdknZBS9YO

On 07/12/2023 13:15, Philo Lu wrote:
> Hi all. I have a question when using perfbuf/ringbuf in bpf. I will
> appreciate it if you give me any advice.
> 
> Imagine a simple case: the bpf program output a log (some tcp
> statistics) to user every time a packet is received, and the user
> actively read the logs if he wants. I do not want to keep a user process
> alive, waiting for outputs of the buffer. User can read the buffer as
> need. BTW, the order does not matter.
> 
> To conclude, I hope the buffer performs like relayfs: (1) no need for
> user process to receive logs, and the user may read at any time (and no
> wakeup would be better); (2) old data can be overwritten by new ones.
> 
> Currently, it seems that perfbuf and ringbuf cannot satisfy both: (i)
> ringbuf: only satisfies (1). However, if data arrive when the buffer is
> full, the new data will be lost, until the buffer is consumed. (ii)
> perfbuf: only satisfies (2). But user cannot access the buffer after the
> process who creates it (including perf_event.rb via mmap) exits.
> Specifically, I can use BPF_F_PRESERVE_ELEMS flag to keep the
> perf_events, but I do not know how to get the buffer again in a new
> process.
> 
> In my opinion, this can be solved by either of the following: (a) add
> overwrite support in ringbuf (maybe a new flag for reserve), but we have
> to address synchronization between kernel and user, especially under
> variable data size, because when overwriting occurs, kernel has to
> update the consumer posi too; (b) implement map_fd_sys_lookup_elem for
> perfbuf to expose fds to user via map_lookup_elem syscall, and a
> mechanism is need to preserve perf_event->rb when process exits
> (otherwise the buffer will be freed by perf_mmap_close). I am not sure
> if they are feasible, and which is better. If not, perhaps we can
> develop another mechanism to achieve this?
> 

There was an RFC a while back focused on supporting BPF ringbuf
over-writing [1]; at the time, Andrii noted some potential issues that
might be exposed by doing multiple ringbuf reserves to overfill the
buffer within the same program.

Alan

[1]
https://lore.kernel.org/lkml/20220906195656.33021-2-flaniel@linux.microsoft.com/

