Return-Path: <bpf+bounces-15162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302057EDD76
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 10:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB491C209C0
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF2714F9C;
	Thu, 16 Nov 2023 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mrYXVK/q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CAUV0sTK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173DE9C
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 01:16:49 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG941O5030165;
	Thu, 16 Nov 2023 09:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NAppuJ3kFJUTMD+TBNa6xFLy2e9FQkZZKgBXgOk4+KI=;
 b=mrYXVK/qSSz7Jgk/qSzFFbW/NzK8Ds7UaEa165onrNA0FFFhBX7KMmybiKo1P01u5aWw
 JWi+Kgb+hWus5qSMnOf3FxlwKSNNOGM9j+R8U0Y7K8aQaWkSAj57/YCHihXm1e1e8kU0
 OFw1HHDTtaIRDvi8n8Mn/FG2uU9mAZxIfguVZylgn862FLhH5BsMFwIOSDk7dupqCUyc
 lPYU7ALZEeHMStpuB5HSl8AiJlcnZK8DZj+A4lZ45912NMcKp+bDYf3qCsyTQjKJX5Xt
 NyoCU3W9FQgPRwi3ByTdPb7pjDRqUsDeBpDg9vTuLwRJxTJ4EQdHknZo2gPdkNT2qzBp TA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2na2kgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 09:16:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG9177Y014988;
	Thu, 16 Nov 2023 09:16:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxqusye2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 09:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnTU1Hwubtp3scBs/JP/0DYlFtg5YB8PjxQ8UAGqO2KIZ6I2Sp0f/FIwpp0YG5CwpRujtwVMfPFtUGS/j6+1z6lx0W4IJuw6saF3UEP7eV/nmsiAHNI1NLB/8iQr61ciConFu7TihVONFMGC0yjM3XaXR3DbB+IPFvWjVzLhpdXia7ekYGQYQufbgPwJF7/6DdfHOKhgWJZPisdIh3/c7whNEBk67J2HfFQ4Pmr8b4bWXXmaPrqvZd9ciOMfyp/ffvAb8iv2Jit1vAj6+g7qVtNLYsv4ptgjOn1RudR/J1Chpgm7yG05hC1/A08nXUSnuz2+R3CxLCwBwx46DY8mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAppuJ3kFJUTMD+TBNa6xFLy2e9FQkZZKgBXgOk4+KI=;
 b=ifg+c7Cyq7vyh6jnZ5uasomTiiPzYQjn0NHbK1G3eeSXMG1SvL1C6YIRHHI7TIGuaUAvddY4RtaVSE4UMrH/+ZcQGFHq9I/aXUL6CBIUYv9pl4nqHe+QmeSfBkW/XgrAqM66y3BkzpXb6u4MhfL4v0RlIoLZRwpy0y2hsIIDP1/m3uQtFzCgDPDdE5fyjD6mznmTRqJWHQkrx7i7HsgubSiQ4U1Zp/YoRXmAUQBXmkRSdC+EJ+FeKKrKPtGC/iph8+qnE6qFwUapA0GCESI/E39NajbH01wNjXYIAU7dRE8ouIFXgpjvlPXDmRuF81JdIoksdjoc8CGAG5pMdfrorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAppuJ3kFJUTMD+TBNa6xFLy2e9FQkZZKgBXgOk4+KI=;
 b=CAUV0sTKapUpn9ILjuf9yHS8z9/u+6RUoIxfeTfRtl85ourzHgPIMP0mmwhgEIK3yVBsSytowLMsYvjCDq9f6JjqFXPOPKMoy8jB6A1XL0XGGxqwseIOQFIko6xOCUhbNxlMnyvdFfbglYyJ9aIw09ozXuS2zZuKeKm91lzISnI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CYYPR10MB7628.namprd10.prod.outlook.com (2603:10b6:930:b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 09:16:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 09:16:25 +0000
Message-ID: <0ce1e802-d0dc-36bc-0342-e87fcc6914ad@oracle.com>
Date: Thu, 16 Nov 2023 09:16:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 bpf-next 10/17] bpftool: add BTF dump "format meta" to
 dump header/metadata
To: Quentin Monnet <quentin@isovalent.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, masahiroy@kernel.org,
        bpf@vger.kernel.org
References: <20231112124834.388735-1-alan.maguire@oracle.com>
 <20231112124834.388735-11-alan.maguire@oracle.com>
 <ebb1d463-68f5-4668-b930-f5dfe1f52230@isovalent.com>
 <b6368b81-e141-13c0-7fde-c4cada3e242c@oracle.com>
 <F129A42C-3E63-4B94-BBB6-5B13AFC9A73A@isovalent.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <F129A42C-3E63-4B94-BBB6-5B13AFC9A73A@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CYYPR10MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ccd5a44-b51d-45ee-0ea7-08dbe684b524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dgwb1Dm6mejjHPFCk0jSq4Mx+yGH8om8LFBSWKH589cQmW78amlQ/2uS13y24yK9pEsuVfK1tLoGJMeTLiCPDSld8xm3Rz1zp1xp0pU1oObPks2gd6RdLv2HxlNJCreOQKyrUDGQfCqIqn4BW2a4qk4FGk92rgNrkTIsiI6DewulHxo9dYY+5155flgpk2x2ai/I5o+iDlVpl0BP2pPEozDLmmnubm1ulAuLu55B4FQYKhXhocjlbaM+IOQYB7iQPBX9lU5tY6Lq/voxeKaS3BkHhZelran4RDWJv5JrmWPa4TO+XdXcMJipDy2KYm4KhAO4tsfld6aPRW3f6N9PC07jQtgo+o1XtdikS6OxCBzj7hGDh/yhwwTYWs7RLBjXUgGrDEWSsReCHc4ku/uBgDPt5F3l6mLrPUdDfGt+oiFONd8TlkvczeMEyDT5XYXIc4mrcTln47OC4bNbIyhWr6W5Vr31QK8e+enwfcZRKnp0K4MwiYPBuNfraVV9gLf7YC63Ua+HAXgcHCGhzmA+e7kA7S0vhalEMht06hZkEjw4LMfOP7S6Rs3A/CW+V9myHtZ+AOWbBXTDPMAVHMv8O6IFR3lj9p1+yuVqE0IRPhYYZALjV8TvJTyxkOLYaWxd/slUl+vNVAORJCVTf8VBTw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(66946007)(66556008)(66476007)(38100700002)(36756003)(86362001)(31696002)(83380400001)(6506007)(2616005)(6512007)(53546011)(6666004)(2906002)(4001150100001)(316002)(6486002)(478600001)(5660300002)(8936002)(8676002)(4326008)(44832011)(41300700001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUhJVDY1RjFHZEl0RFZVU3poTWxKdlIxekhETWE3L0k5L0YxaWEwcVNuVU5M?=
 =?utf-8?B?bzZUNGxZS3dOVkVkVi9PR1k0V1l5SjBBMUdKbjJQeDBzSXpkTXozZ1BxVGRI?=
 =?utf-8?B?OTNxazh6SUk1eG81d1ZYLytrL1hFb3FZZU5DaHdIK09abFpVdU1zSlZCNk1U?=
 =?utf-8?B?bGdCejdqZlg1MzZUWWhjdzQrR3NXY1ZuQ0t5NDhBN2gzODFpVXNsajlQSVRk?=
 =?utf-8?B?Z3pEQ2pZVUJSMDZSNTJpd2NZak9kTE92d0RyVjdvdWpNYjhTOUo3TG5mb3NU?=
 =?utf-8?B?S2d4VUs3dnBESGpmb3VoNm9RUzI2YkovVXFkQWdPdFdWTnAzZTdsOU9TTmpi?=
 =?utf-8?B?RHpBU01NVmhjdHBVWVR6c29XZDl1THVhWkFLcTQxSkZKWEZaNHdGQlQwYS9x?=
 =?utf-8?B?eW9FN3BPQTh1SFhSR3NzV3hZSlZkbTJvMkVNeXZPSzJmckZodmlpb0tUZmhJ?=
 =?utf-8?B?VU00bWJwSHdlNWcvYTlNdUJMay95VTl5TE1TQmNLUGdlU0R6ZndndGVwelAw?=
 =?utf-8?B?cWdKNFc1bHA3UFFGRVBKY3IyOUZvQ0QwK2g1eE5qOHlzTmNCT2FVVVdLcGlr?=
 =?utf-8?B?U0tKZ2ovNmhJZmYzcWFhR1JxQzZqL2d1alRhNDVEb05IalRGemRoOXYrM1Q0?=
 =?utf-8?B?UTdoNXh1L3AwRkd5cVZKeHFFTlNFc0NYRHJUT21udnl6RDdjb1NEV1VjcnNK?=
 =?utf-8?B?YmtFNXE0WXRkeklFcTdLU3FUQUxQYmdTeGV3Q21Ub0N3ZWl6L0haWTlvWHor?=
 =?utf-8?B?cWoxc0tXc0Q3RGJYbThTZkFxaGhWdDVJQytuMXpDMmZWRG9ocWdlVUdVWlBT?=
 =?utf-8?B?YUpDNGNDSmx3ZXFPakJMOVFzNkVFNm1RdTJoa1pwZnU2MFR5aDRDd1o5NVNJ?=
 =?utf-8?B?MURGaEVhQXFJYjJacWlWTUN3UHpiYk5zbUhSaEJnMVpBRzVicWVqVmJIQ2U4?=
 =?utf-8?B?bXhKSS9DTmdwS2JqcUttczR6S0JsRU5lcUR6dzc4b3RxM2I3dERUOGp0UERD?=
 =?utf-8?B?VkszSVlxL2orc0hnWjRvemMrTUpMb3ppVUJjRHBiMWtFUlJXdU1lbERJRTNC?=
 =?utf-8?B?Y05lZ05vZTFjeHRvUUtLRFdTLzJNYjcyTFM5aWZvNnlQUk80TjQrTE5xYWZJ?=
 =?utf-8?B?WlAwRld4SnZzR3ZqTXByc0ExY3VNL3A2V3ROU0RJb25WUk14OSt3eFZTRlNG?=
 =?utf-8?B?UGlWMzVBRFNtSTRyeno3Q2grcjFtVUhBWEZGNGFCcVhCME9IRE1TazBnMUhx?=
 =?utf-8?B?WTVoODJwU3BBWlFiZVpuWWMxOVBKMklDSDRDb1JZVjJLR3dZWVRDNnB4dHR1?=
 =?utf-8?B?TkJmU1hJTWsxUVJMZVI1Mzk2NUR4S0ltNU9iVXhUdGJIOUxkNWJVUzQ3Qkdi?=
 =?utf-8?B?Wnp2WXp5ZEJTdnVhMHZHWUh3QnprT0duSHlPSVA5RlFWZjlBQ1NLQnZQOHE1?=
 =?utf-8?B?bzF0elowQWtwcXM5bitiUkpjTlVWUGxwVWt2TksvaVhRTUNHWW5mbTAvVDhL?=
 =?utf-8?B?aXNXQmdGTm1wbU1DOW9Gemk2Q1BkV09LR1pBMUpha3g4TDFzWXNRUkZuelJ4?=
 =?utf-8?B?dGtPUWROQmVwNG5vaXRsei96L0JEVnpEdFN2aUZwZ01SRFEzNEo5QlI1Qy9K?=
 =?utf-8?B?VzRMYzAzWXh4U29RTG1RbU1DVHFoYndNZ1Rpa1pnN0FuRm9UUEg4T0x1eFBE?=
 =?utf-8?B?dXJqTjY5Zkt2eU9jVk5VSDBtWkFvSWxGbWE2ZVJrWnZzcUFkK0RldUFuS25T?=
 =?utf-8?B?NW5DRkNrSHhxeDNhcWtyalMzeElUOFlIeXJqczU1TEJkdDBoSkEvS0N6Vyts?=
 =?utf-8?B?MEFEMGhGQVJpc3VUd0U5d1NTRTNiam5YVXcySk54Zko5RTVKRHJENjJERUo2?=
 =?utf-8?B?TDFmZTRFTnZiOTlIdjljOGFxeXR0ZlNrLzBPRER4SzhJbkNWWGlFV0w5VGRz?=
 =?utf-8?B?WGR2NWxjS2QzZlVFRkpqd01URFhpUFZWZjFBSEQxWHRMNnIvZmx4OTI5WWhP?=
 =?utf-8?B?UXRiYko2Y3JNcnB5TDFrU25NOW1BZElOZWd1Wm9jZUJnSVlyNXJoN3ovenh1?=
 =?utf-8?B?Zkpra0lMMk8yRFU4d29ESStyTGtralA3eVYyRmp3MnZiMXh1V3IrOEkxcnRV?=
 =?utf-8?B?dHdrNm9id2dwYnN4RFl1ZHdTeFRMNEVqVDhOT1YrN2NlZlIxS3ZaS1JtZDRM?=
 =?utf-8?Q?bMwznPOtxYb89J9YFN910uM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?NXorYU83VU51TnZRTWhWa0RJbkhoRUhodG5lcWtScnNwNzBzVEIzTXlhdlg4?=
 =?utf-8?B?NnhDbmxXZ0JUWUpnbUVaa0JkZWszdWZGTlBoNEQ0US9VZ2JIeUczWU5NVS9M?=
 =?utf-8?B?eGs1M1RjU3lidFB2OUUxaWZFNktnNm0vSHlPQ2VwaU1JaFhhbFo1TFNoUjZz?=
 =?utf-8?B?c1ZDUk9rYTdWSWRMa1QzTzBwZXQvdzd2MHdwUUE0MDllZ01uUGUyZWkvTEJl?=
 =?utf-8?B?bHpTM0F2dTRKbmR2aXFkaHhSYVZ3eDJkVnc0MWlPT1VsKzR1K2N0emhlSmxQ?=
 =?utf-8?B?d0pBTGJFbUUxMmRqdmtCVGFubmlyYllkanZNQ25veHJqMnM3SHZSMzlHRnJt?=
 =?utf-8?B?c1p5NlREeXhHcnE1b2tQY2FjQzFhZktnSkF6RzlSeUI5NzB3U0hnUkNKcFlU?=
 =?utf-8?B?VzQ3Q29pcWxUdzc1bzZJbG5keThBVTNWNWdnSWNhcEQ1ZFV2TEttZzd0QmdR?=
 =?utf-8?B?bHJzaXJNQTh6STd0TU44ZVM1QnNycGUxZFg3eVhOT29ac1BGWU82bDYrb251?=
 =?utf-8?B?Q0ZGQVpuTnU1ZEtuN2p6aEhZM3laQi9GV3VlRnovaEZqYkt6czRucStURlFI?=
 =?utf-8?B?WHlZc3EyU2o1OGNtUmw3RUVKbU1TejQyejJOZWUxQ1lWN21kd2podzVZNGkv?=
 =?utf-8?B?SHEwWVU2aGdLZC91eEdranU5QlZKeG9aY0EzbnpESlBuUHpQZy9CeTFxd0I4?=
 =?utf-8?B?eTNDUUZtdVpSV0pYcHZuNmN4OXlqaXhuTkR3cGxJVEl5R1M5QXVpRG12MEFi?=
 =?utf-8?B?amNLMkY4azkxSEF3aXpQZG1XZ3A5cERXTGlESnprTk5UaGtiSmQ3cFRndnRx?=
 =?utf-8?B?cGxueXMrUytkYWlDaVhIeVRUZXRyemRtVFN3ckhMZDFrVUkwTDlXMEsraDBZ?=
 =?utf-8?B?bzVweURSRzJieVc1UmhaVXJENUFTTmh3THdqcGJ3N1dZQmZIMlA3VmlyenpL?=
 =?utf-8?B?SVh3WWtodk5QTkpZd1hqcjUyRy9wSW9qclNnVHllRGl3N2E5SGFMQU10TUZz?=
 =?utf-8?B?VHFmOGVnR08wQ3ROcUc2UVgzMXBScmd6dWF0UTNXMElPZk13NzQ2YkV5aWhT?=
 =?utf-8?B?blFiM2h2MjhYTW1aUC9JdDcvemtORjFjQjJ5MEFEL09Za2NDdk1PRXUrUGtF?=
 =?utf-8?B?TC9Zc0pSNGY5MXhZVTc2aWJVWlQ2ZWdrdlFFN0h1cy81L0xWNXBhbzVKenhB?=
 =?utf-8?B?U3pEV0FrQlFjemd1ajYrdDhqcW5FWVNVNlpNYk51K2Vqc012ajQyVkdFd3k4?=
 =?utf-8?B?U1dSdGVsRkUydFR2a21vQUtBTXZMaXdKbVhaUFRVOVp6cGZxUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccd5a44-b51d-45ee-0ea7-08dbe684b524
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 09:16:25.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+EXa/KyQmFHV+f8pHYXZa2wo52pXQEdNWRIchzPjRQFiOjnhfkizqkRbMPno8EBUCPaJUo9s3OrYyGuYC42/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_06,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160073
X-Proofpoint-GUID: Fjw8bIHAT8CWHMbPRLbIa3ZuTLGXupDQ
X-Proofpoint-ORIG-GUID: Fjw8bIHAT8CWHMbPRLbIa3ZuTLGXupDQ

On 15/11/2023 14:51, Quentin Monnet wrote:
>=20
>=20
> On 15 November 2023 03:45:41 GMT-05:00, Alan Maguire <alan.maguire@oracle=
.com> wrote:
>> On 14/11/2023 05:10, Quentin Monnet wrote:
>>> 2023-11-12 12:49 UTC+0000 ~ Alan Maguire <alan.maguire@oracle.com>
>>>> Provide a way to dump BTF metadata info via bpftool; this
>>>> consists of BTF size, header fields and kind layout info
>>>> (if available); for example
>>>>
>>>> $ bpftool btf dump file vmlinux format meta
>>>> size 5161076
>>>> magic 0xeb9f
>>>> version 1
>>>> flags 0x1
>>>> hdr_len 40
>>>> type_len 3036368
>>>> type_off 0
>>>> str_len 2124588
>>>> str_off 3036368
>>>> kind_layout_len 80
>>>> kind_layout_off 5160956
>>>> crc 0x64af901b
>>>> base_crc 0x0
>>>> kind 0    UNKNOWN    flags 0x0    info_sz 0    elem_sz 0
>>>> kind 1    INT        flags 0x0    info_sz 0    elem_sz 0
>>>> kind 2    PTR        flags 0x0    info_sz 0    elem_sz 0
>>>> kind 3    ARRAY      flags 0x0    info_sz 0    elem_sz 0
>>>> kind 4    STRUCT     flags 0x35   info_sz 0    elem_sz 0
>>>> ...
>>>>
>>>> JSON output is also supported:
>>>>
>>>> $ bpftool -j btf dump file vmlinux format meta
>>>> {"size":5161076,"header":{"magic":60319,"version":1,"flags":1,"hdr_len=
":40,"type_len":3036368,"type_off":0,"str_len":2124588,"str_off":3036368,"k=
ind_layout_len":80,"kind_layout_offset":5160956,"crc":1689227291,"base_crc"=
:0},"kind_layouts":[{"kind":0,"name":"UNKNOWN","flags":0,"info_sz":0,"elem_=
sz":0},{"kind":1,"name":"INT","flags":0,"info_sz":0,"elem_sz":0},{"kind":2,=
"name":"PTR","flags":0,"info_sz":0,"elem_sz":0},{"kind":3,"name":"ARRAY","f=
lags":0,"info_sz":0,"elem_sz":0},{"kind":4,"name":"STRUCT","flags":53,"info=
_sz":0,"elem_sz":0},{"kind":5,"name":"UNION","flags":0,"info_sz":0,"elem_sz=
":0},{"kind":6,"name":"ENUM","flags":60319,"info_sz":1,"elem_sz":1},{"kind"=
:7,"name":"FWD","flags":40,"info_sz":0,"elem_sz":0},{"kind":8,"name":"TYPED=
EF","flags":0,"info_sz":0,"elem_sz":0},{"kind":9,"name":"VOLATILE","flags":=
0,"info_sz":0,"elem_sz":0},{"kind":10,"name":"CONST","flags":0,"info_sz":0,=
"elem_sz":0},{"kind":11,"name":"RESTRICT","flags":1,"info_sz":0,"elem_sz":0=
},{"kind":12,"name":"FUNC","flags":0,"info_sz":0,"elem_sz":0},{"kind":13,"n=
ame":"FUNC_PROTO","flags":80,"info_sz":0,"elem_sz":0},{"kind":14,"name":"VA=
R","flags":0,"info_sz":0,"elem_sz":0},{"kind":15,"name":"DATASEC","flags":0=
,"info_sz":0,"elem_sz":0},{"kind":16,"name":"FLOAT","flags":53,"info_sz":0,=
"elem_sz":0},{"kind":17,"name":"DECL_TAG","flags":0,"info_sz":0,"elem_sz":0=
},{"kind":18,"name":"TYPE_TAG","flags":11441,"info_sz":3,"elem_sz":0},{"kin=
d":19,"name":"ENUM64","flags":0,"info_sz":0,"elem_sz":0}]}
>>>>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>> ---
>>>>  tools/bpf/bpftool/bash-completion/bpftool |  2 +-
>>>>  tools/bpf/bpftool/btf.c                   | 91 ++++++++++++++++++++++=
-
>>>>  2 files changed, 90 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpf=
tool/bash-completion/bpftool
>>>> index 6e4f7ce6bc01..157c3afd8247 100644
>>>> --- a/tools/bpf/bpftool/bash-completion/bpftool
>>>> +++ b/tools/bpf/bpftool/bash-completion/bpftool
>>>> @@ -937,7 +937,7 @@ _bpftool()
>>>>                              return 0
>>>>                              ;;
>>>>                          format)
>>>> -                            COMPREPLY=3D( $( compgen -W "c raw" -- "$=
cur" ) )
>>>> +                            COMPREPLY=3D( $( compgen -W "c raw meta" =
-- "$cur" ) )
>>>>                              ;;
>>>>                          *)
>>>>                              # emit extra options
>>>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>>>> index 91fcb75babe3..208f3a587534 100644
>>>> --- a/tools/bpf/bpftool/btf.c
>>>> +++ b/tools/bpf/bpftool/btf.c
>>>> @@ -504,6 +504,88 @@ static int dump_btf_c(const struct btf *btf,
>>>>  	return err;
>>>>  }
>>>> =20
>>>> +static int dump_btf_meta(const struct btf *btf)
>>>> +{
>>>> +	const struct btf_header *hdr;
>>>> +	const struct btf_kind_layout *k;
>>>> +	__u8 i, nr_kinds =3D 0;
>>>> +	const void *data;
>>>> +	__u32 data_sz;
>>>> +
>>>> +	data =3D btf__raw_data(btf, &data_sz);
>>>> +	if (!data)
>>>> +		return -ENOMEM;
>>>> +	hdr =3D data;
>>>> +	if (json_output) {
>>>> +		jsonw_start_object(json_wtr);   /* btf metadata object */
>>>
>>> Nit: Please make sure to be consistent when aligning these comments:
>>> there are several occurrences with spaces (here three spaces), several
>>> ones with tabs. For these, I'd prefer tabs to align the start and end
>>> comments for a given object/array, although I don't really using a
>>> single space as well as long as we keep it consistent.
>>>
>>>> +		jsonw_uint_field(json_wtr, "size", data_sz);
>>>> +		jsonw_name(json_wtr, "header");
>>>> +		jsonw_start_object(json_wtr);	/* btf header object */
>>>> +		jsonw_uint_field(json_wtr, "magic", hdr->magic);
>>>> +		jsonw_uint_field(json_wtr, "version", hdr->version);
>>>> +		jsonw_uint_field(json_wtr, "flags", hdr->flags);
>>>> +		jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
>>>> +		jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
>>>> +		jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
>>>> +		jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
>>>> +		jsonw_uint_field(json_wtr, "str_off", hdr->str_off);
>>>> +	} else {
>>>> +		printf("size %-10d\n", data_sz);
>>>> +		printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_len %-10d\=
n",
>>>> +		       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
>>>> +		printf("type_len %-10d\ntype_off %-10d\n", hdr->type_len, hdr->type=
_off);
>>>> +		printf("str_len %-10d\nstr_off %-10d\n", hdr->str_len, hdr->str_off=
);
>>>> +	}
>>>> +
>>>> +	if (hdr->hdr_len < sizeof(struct btf_header)) {
>>>> +		if (json_output) {
>>>> +			jsonw_end_object(json_wtr); /* header object */
>>>> +			jsonw_end_object(json_wtr); /* metadata object */
>>>
>>> Similarly, can you please keep consistent comment strings? "metadata
>>> object" here vs. "end metadata" below.
>>>
>>
>> Sure, I'll fix indent consistency/naming and the docs issue in the
>> next revision. Thanks!
>>
>>>> +		}
>>>> +		return 0;
>>>> +	}
>>>> +	if (hdr->kind_layout_len > 0 && hdr->kind_layout_off > 0) {
>>>> +		k =3D (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
>>>> +		nr_kinds =3D hdr->kind_layout_len / sizeof(*k);
>>>> +	}
>>>> +	if (json_output) {
>>>> +		jsonw_uint_field(json_wtr, "kind_layout_len", hdr->kind_layout_len)=
;
>>>> +		jsonw_uint_field(json_wtr, "kind_layout_offset", hdr->kind_layout_o=
ff);
>>>> +		jsonw_uint_field(json_wtr, "crc", hdr->crc);
>>>> +		jsonw_uint_field(json_wtr, "base_crc", hdr->base_crc);
>>>> +		jsonw_end_object(json_wtr); /* end header object */
>>>> +
>>>> +		if (nr_kinds > 0) {
>>>> +			jsonw_name(json_wtr, "kind_layouts");
>>>> +			jsonw_start_array(json_wtr);
>>>> +			for (i =3D 0; i < nr_kinds; i++) {
>>>> +				jsonw_start_object(json_wtr);
>>>> +				jsonw_uint_field(json_wtr, "kind", i);
>>>> +				if (i < NR_BTF_KINDS)
>>>> +					jsonw_string_field(json_wtr, "name", btf_kind_str[i]);
>>>
>>> I prefer to avoid conditional fields in JSON, especially in an array
>>> it's easier to process the JSON if all items have the same structure.
>>> Would it make sense to keep the "name" field, but use jsonw_null() (or
>>> "UNKNOWN") for the value when there's no name to print?
>>>
>>
>> The only thing about UNKNOWN is that there is a BTF_KIND_UNKN that
>> is displayed as UNKNOWN; what about "?" to be consistent with the
>> non-json output (or if there's another option of course, we could
>> use that for both)? Thanks!
>=20
> Right, sorry, I realised just after sending my message.
> In that case we could just use a 'null' value in JSON with jsonw_null()? =
The object '{"name": null}' is valid. The question mark is another possibil=
ity but requires comparing strings when parsing the JSON.
>

Great idea! I'll use jsonw_null() for the next version.

I think given the fact we're not sure about the way forward on CRCs and
standalone BTF I'll probably just separate out the kind layout stuff +
bpftool dump meta parts since I _think_ at this point those pieces are
relatively uncontroversial.

Thanks again for the reviews Quentin!

Alan

> Thanks,
> Quentin

