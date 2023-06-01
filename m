Return-Path: <bpf+bounces-1584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20387199F8
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 12:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916DF281760
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A1E2340B;
	Thu,  1 Jun 2023 10:38:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F323400
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 10:38:42 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D4B136
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 03:38:37 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351505vK016320;
	Thu, 1 Jun 2023 10:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=p1REHq02mN+Eg/3WfzcsNPTsDqDWph9cRiL89v7zcXI=;
 b=fVDUhIN4v0Qk8K42XUT63J7EynxsWE53+qXXXctBHrk0NtWdLBfzPkAc0tZ4A0M3e0wC
 Za0oMd5XK4TGtTrMgQg3CcfBDIc7GsWcZAFUIYpYqHlGgh+RMUabwxrYXU68D/lz9doT
 tMIzfCDSi/e83I6EIc8J9ROJXlqBaMtD+huCpUaxz1Bq8Wlqv6LucKKAx7rLbAAFk2ju
 E6o68QZ9zR3dOxO+fSj7SHV7FpNnL2eVqg0HlBFAgeznr9O1syP2ddph74RkjhDVLUdT
 7U4aWFAq8MZT6QVB9r/nGSpEiZEi+Uo5NVBbjlnDHJI7BHSays2tUtHIfgsc87sdIEUm Bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmerg7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Jun 2023 10:38:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3518oZqK019757;
	Thu, 1 Jun 2023 10:38:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a77q8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Jun 2023 10:38:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEPMuiM0C2FhmuBV2BMIqUort9lCj8H2+VmlIjZ3w8sCnDou7xnpdzlDAGcZkN8RIWcPTba+O8+Lv13EScRssTnMBAS2Nep1RaEOBKEjiqW3BD2jtvXkFuHGVGzvLvp96e34G4udzMM7e2pp4jmxKqVaxqRztzprm2fCmq7PIoIdWLLlxogBGu1BjOm5oQ907Ubv8uvWiFh8AaPJBp2pBLaWHqQngDbrIC6WBrzGzdz/fF3VH+ePxy70YtvMlIJgYDG5b7cfpYWYJSE9NcncUxclEvy58ihV++fQKKG2jKYcqgmXGr2oT06mIhg0wGZvlwIVnM2Z49LuTixrCFeUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1REHq02mN+Eg/3WfzcsNPTsDqDWph9cRiL89v7zcXI=;
 b=DNfnhA/TG0xtZ4hA+bqyc34ThQcNh6RUl4lVyOWHtRhYm8S0GRUif3w0BB9otcw0qN4XJDKUxs0VGqJbijJL3YJHmzjQG4AHHYxt/TohwG/kzLryc1GcvXrIrhhJJ0GNwDSybIjugPL6gNIgUmmy1yfgyS2wk5dfIh8kFByU7cA3UMo7TUxt3qys1OKnoIu0UnTylWbCCqztlPCZ9U/FgkgbeKQQ2WLiD2Fkd8Biii8mhEQzDNhRXQ1b9FqHtDBliRrKa1jl40NKW9+htXcXhL11EzwrdFCmctjP8g++7h5syyHbnk9FaEwWfuqfQBC0fW8LVg6xXNHM27hb0DQpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1REHq02mN+Eg/3WfzcsNPTsDqDWph9cRiL89v7zcXI=;
 b=uBpVZ931wXUDzRqnT6x3ULPQntPt51DDXyWWzeHn6nkL1HlLoINC0HJABhR5eN7q6Dr6menuNACdRXiW5uOI+HB0Dhi/FbQq8ESXNfCIASoYAt9pR6vW4QFhHxVFR2kHdtRTcHgeJ72n8sIhWfws+TmsOz1EqtADCvuJc+2smQg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB4217.namprd10.prod.outlook.com (2603:10b6:5:218::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 10:37:53 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%5]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 10:37:53 +0000
Message-ID: <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com>
Date: Thu, 1 Jun 2023 11:36:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        mykolal@fb.com, bpf@vger.kernel.org
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-2-alan.maguire@oracle.com>
 <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0508.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM6PR10MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fa3c11-9411-4462-04e9-08db628c414c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xX3labLUzmeKzL3PaaTd4fAg0wNCz/KizPTInNCp/7bcA7ISTvSrSonkf4WQM55nOQiI7jQNBTc7qYpAZSYta/Oppc2OWW7+k53PIAhA/1fjX3Zr2i4sxt5NtWCx3bipZfDwTpv42+4ATMTV1513ceMwoCDniOdyxewcEA4BafCWnY2+tSvvJKxbwpv6CJTbfSdvUSBZj98zdFwytYgXE/86NnISMkyf6DTDwE8pcDWo1jtIsa6Ac0ixgPpdoz/T5VoXuBQCA4+r3SwBQGbVwnsh3pgZTpZLXx+qFCCLwfqWMfD9hg8Z/EcRAZ0r9Yr9/Q5/XjrrjI5x837et/FnFnfpHwBBqoWlhfw51DuwIzH3o0IGf+/W2r5mADgIIvE2SFffw0gYeBALbC2EB9gYQU0karJsx2SIvnI5vbYZGkCmhJoRtRhJ4FcIS8ND0epLIOR1TmMEmxa/8smmVo1AIjprB++iyhMTgaTcjHMnqRsjXGg4dIRYxQbeza3zGtEj3kl30BN2QzDeiNp5YssgIvhxOsmo7bgDIToFYccxn/u+svsw3VFe+pqDCVwXn4kusD5HMfs9bg4BFs+Qn3EeWKQQVeHri3LJ61EXhSmWsRGscL/m4HP1fsdxnxgAU1HB7w8Rm0FzpFNadtlNAO9e/g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199021)(31686004)(66899021)(36756003)(86362001)(6916009)(966005)(66476007)(66946007)(4326008)(316002)(66556008)(478600001)(31696002)(53546011)(6512007)(6506007)(186003)(8936002)(44832011)(7416002)(41300700001)(8676002)(6666004)(2906002)(83380400001)(5660300002)(6486002)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGhNRUM1cDIzd0hZcXZveWVNNGdoeXZJQlIyU0hJM3lINXFKaU1SWEV1R1Er?=
 =?utf-8?B?MTlPdmtYM2ZKWDJKZklwVFRmbmJpaTlLU2psODlrNXlnbGpvUkNyc1J3QUFw?=
 =?utf-8?B?RFlMRWhHTVJWVDFpaFZVZ1ZhZC83ZThUOHdJYW9mWklzTGNubkgxOWZhOXk5?=
 =?utf-8?B?Z3NUdnEzamRRNUZxUmhDa2NKcHVNNm5xVUNac05zaFg5K1g5SFk5OXZCZFBk?=
 =?utf-8?B?ZW5VQmVWWlVuTDY5L3VEMjBYZk5FbzY1aXF6dVViSm0ybitJU3N4NmRrbzdI?=
 =?utf-8?B?a3lhZHJNQUFBcHdXQmtmclg0N2pwcm9JS2ZiZkh0RnFqNTNRSm12SWpTYVRh?=
 =?utf-8?B?cnJ3LzlZZ0U1Zld2VTU2Tng2WSt1bzJJaG9nQnZiK1FveXF4S3M4Q0xIbE0x?=
 =?utf-8?B?TDZua3U4bnlUK0NWVWtZUXdtMVl3OEVFRXJ5NjhTenJ3Sy9ac0xoQzB4eVU5?=
 =?utf-8?B?Y0ZtdGlVeXZmK3orUy9sOFh2STJTN0hud0UxY2xIYmJQcWhhUG0rYkR0WkU3?=
 =?utf-8?B?VnlKaXJuNWZEcVJjb0M3bmZZMmhEdmhldTFkdlU4dEtqMmc2cmtzZkJrbVBq?=
 =?utf-8?B?dTkxN3o4Y20rT0VBVHRxRGhEYy8xTjlYMjgrK1dQWm9IUEpsTXIyNFJobXR5?=
 =?utf-8?B?d1c4ZVZNaFBUM0g4Zy8rU0oydHYvR2lFczhNYjBMWCtDTHlWMmt5VnBESHM0?=
 =?utf-8?B?dUhFRGIwdDJ4cGJiY2hONDVUeDRTRDFlMUNYTWNRM0MrTythQWJrdytkNksx?=
 =?utf-8?B?TEU4MXVRL2h3NjNlY3dIcmdKSENnSnA4S1ZCakpEU1NPR01kOGFQY016TjVw?=
 =?utf-8?B?dWhLY2ZHMEl3Q0NjcEtwRUFuZWEyQ2ZzWUp0d1dMdWR2eW5lbHdodDlLN2VI?=
 =?utf-8?B?QXRtNSsrQld0SXBqT2x0bmFMaDRmYS9kUGVQTDhIMjc2MXRCZS8wM0xJT3c1?=
 =?utf-8?B?bSt1RStiQXhQdk5rb3UyVVcwMm1lYVJqRVpFSytDYk5RMy9MZ3FhNmU0Yitn?=
 =?utf-8?B?cXEzdlBhb0paWkoxeGs0OStXK3VZQmZobFVReVMxZ290cWl2L3NmQ0pWSTNv?=
 =?utf-8?B?L2FtN2N4WCtDYU40RWordkczZnhYVDIrVHBoamVXcmlsQm5YMTJhWFBaajFp?=
 =?utf-8?B?NG9SQ25Gd0FKUUhac2FwOEU2blpSam1GV2M1MzNWYjQrVzhWb0lvUGZ6dHdz?=
 =?utf-8?B?M01TeXR2QUNZRzB1ZjFLbmM3SXpZNkNXNXJCbGd5a2F0N0dRVGk2RC9CS1R6?=
 =?utf-8?B?NFN0dFFkZFZiRFZZWFR6V1FzRjg5N2Q0S3JOZCtsTlFhTGFKd2pmdzdaanFl?=
 =?utf-8?B?SEUwaWlMbGtBaU5lL2xtMHh4R0FoaFdvWWhYMTdyYjRrclFHb292Vlh5cjkz?=
 =?utf-8?B?d2RCSGJldFhyZ2VZREhGY1V4ejNURXcvbmJNMEdWZUtDL0o2T0QrQk0wOFZl?=
 =?utf-8?B?d0pYTEc4ZnpuVXJsblhoV0hSNnVDWHVsUXF3Wmh1K1JjNEpSQW5RdUxIbnZ4?=
 =?utf-8?B?ODFXR1B1WlFXTHZRZkViazU3S1dZVDdqQVI4SysrZWtkWEQ0SlR3cjFHUEhh?=
 =?utf-8?B?VHllaXZXMnE1bDdRZEMwc0VUZWRWQ25kZDY2SlBJTUE1YVdTQ21TYjRGalYy?=
 =?utf-8?B?Rnd6MTc3cGlJTncrQ2ladUhmV29WL0VmQ1YzWG1hZnRPQW5Tek5zR1pTMlBu?=
 =?utf-8?B?TjlvNlpWQktJRzVWL2x3NC9zN0prLzl2WnYzTURMWDFDSmdobExQdnVMbmdH?=
 =?utf-8?B?NmhKTXJmaUg3MXhYSmdUd3R1N0NJa21Ja0ozSGE0dFkzMHM2V3pwbm00M25W?=
 =?utf-8?B?TFFUNzRSdGdkZ3diTHZSTHFocVdGVHFlUHdMYjhTTVo3dDF5OGZsOUdsUnpo?=
 =?utf-8?B?Y09aMkxxbjBCZ2xORG1xVFRsNkxzYUZsQmtFQUF3TitpK0ZNR09wK3l6OEJK?=
 =?utf-8?B?Z0VoRzRGTklZd2I1RG55UWwyNjJSbFFJRzF2aHJQRXlpN0pNM3RTU1dmckZ1?=
 =?utf-8?B?NHg3N0JBMkxkeDgxYWo2VmZQZ25FdW5Ray8vZW1NZWJZRFJvZ2szTmxpSjlT?=
 =?utf-8?B?bGdnMHZEZGpMSXdmZ0lXcFU4SmVDQjlOUVRmZzBaTDFhaXIyNlhuazdCWXFK?=
 =?utf-8?B?NjM2NEZpZFFTck1KZnBkM2FkUE5pVGNiQWhVcExMWlhwV2x3ZUtla3kvbjM2?=
 =?utf-8?Q?vDXaxzy8J5vcb+5141SwKBQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?QUZCWUtLRkM0MXRVUlJqM0dOYkU5TGZLcnBVRHc2ZDlQUTBtSzk2UVg3MVBa?=
 =?utf-8?B?dk5Na0FwcjNtSS9wUHR5cGVCL3E1Z0Z4SDdXQXlwOGxUN0t4U3lWT1RBTFZK?=
 =?utf-8?B?MjhDTDV0MWtHSGl0OFpsaVFSYmJtTFFLaGZOaVpXVWpOQVJ0WFplb0R1KzEx?=
 =?utf-8?B?ZEdRVmxmMzEyTE9MM1oybThiYTN0ZHpYWXJjQ2xvSmZzOElPS0ZQQWRjM3p2?=
 =?utf-8?B?ZUl3V1F0RUJFSXQ3dmZaTGRLRUlhcHR5bE5KVjFtVXA4T21oUjJ6MlhpTnRj?=
 =?utf-8?B?cVRxMGY1YnJBVkxjdzc4ZVlrNHVvSThHbG0vcmc3cGhDbmNkTHJYS2gyWHkz?=
 =?utf-8?B?WTdIQjJ3b0cvMUc0djZsWWNpaUNuZHlGUGU2a3I3Y2F5eE1NbUU4U1dWMUVy?=
 =?utf-8?B?OVoyQXpCSmtPaGkrbStuUjJtbWowTVVtcEVvUjlsd1orUGs5bzZNNUluMkMv?=
 =?utf-8?B?cDU4a0NlK3lkQ3RvV3B2QTJhTWlNV29pL1pKU2tzaXZ3bEE0VlJjb05iU2sz?=
 =?utf-8?B?ZzdwYlBHR0Z2ZXE0Qjd4RUcxdEczVGlPWnJxUVBkNmVKVlJlRTc0Qll0TGpH?=
 =?utf-8?B?WUFKM016Yit6a1N2QnoxajVFZVcwK1JlbllveHRVdVpvQ2lzbGt0TUg3dGJ5?=
 =?utf-8?B?d2h1cjk3Lzd4cmlMUnhUTFBxaHdkZDNuSW1ZNm91TTBRam9kZWUzaU9NTVdt?=
 =?utf-8?B?OTZhY2dDQ3FiZ0JHRmNYTFdwYjZ3U3gxRlovNkt2N1dhZVNSUXk4MVZsYkF0?=
 =?utf-8?B?c2NtamNybGJ6Q0R2bGhtWFNwU1AxeDdOUzBOY09YSkd4RlVWcUd4M2w1MEhY?=
 =?utf-8?B?N3RNS2ZxU3JPK3VTVG84ZmNaNkxTSlEyZGpEaWtZVlBXbXhZNVREYTlKc2Va?=
 =?utf-8?B?dXcwQmN0STB5K2Y1b05HeDRvdUhvMmxObEc5UmFlbWZYUjVqejZmYXRkTEhQ?=
 =?utf-8?B?UDhGZWZqU0FseVorR2xSdG0yUXpKWWNrQVRBSUJ5bnoydzFQbGVKTjZ5bDRp?=
 =?utf-8?B?dEdKSnZPZjhjT3h4VVpaVWdHUU9JbzhoR2huclpialZUSGN0WWdIZ0dHeGRC?=
 =?utf-8?B?QkJEQ1lLMGZpV29IYnBFdTB4SzVsbGxtYUVlQ2V5Q2krS2hPQnNieUFDd1Rp?=
 =?utf-8?B?YTc2OWYrYXRWSWt4MFA3V2l2MHN3a085T2tESnlqT3dSYzlnUStZZzkzQWFE?=
 =?utf-8?B?YmFCUzNveGpQMzRINmw5c1htN2Z3bjBHYW9DUWtSSUVmUnR3N2tuMWVFTU5S?=
 =?utf-8?B?b1NQUlQvQ3Rhb0ExVlJ2SnNONU9wdjhISG05YXpJN2xibmFGUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fa3c11-9411-4462-04e9-08db628c414c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 10:37:53.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyOiUV7TeyyUiD55UyPZYtWoQg6MdeuCeFwD12WRaajAcjbbj0x2af197SVIDVza/f8tStTIcZwH7F6/qB3fqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_07,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010096
X-Proofpoint-ORIG-GUID: PKuzcPZsyXA4I6s8fwYpV4g_OA7A8pac
X-Proofpoint-GUID: PKuzcPZsyXA4I6s8fwYpV4g_OA7A8pac
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/06/2023 04:53, Alexei Starovoitov wrote:
> On Wed, May 31, 2023 at 09:19:28PM +0100, Alan Maguire wrote:
>> BTF kind metadata provides information to parse BTF kinds.
>> By separating parsing BTF from using all the information
>> it provides, we allow BTF to encode new features even if
>> they cannot be used.  This is helpful in particular for
>> cases where newer tools for BTF generation run on an
>> older kernel; BTF kinds may be present that the kernel
>> cannot yet use, but at least it can parse the BTF
>> provided.  Meanwhile userspace tools with newer libbpf
>> may be able to use the newer information.
>>
>> The intent is to support encoding of kind metadata
>> optionally so that tools like pahole can add this
>> information.  So for each kind we record
>>
>> - a kind name string
>> - kind-related flags
>> - length of singular element following struct btf_type
>> - length of each of the btf_vlen() elements following
>>
>> In addition we make space in the metadata for
>> CRC32s computed over the BTF along with a CRC for
>> the base BTF; this allows split BTF to identify
>> a mismatch explicitly.  Finally we provide an
>> offset for an optional description string.
>>
>> The ideas here were discussed at [1] hence
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>
>> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
>> ---
>>  include/uapi/linux/btf.h       | 29 +++++++++++++++++++++++++++++
>>  tools/include/uapi/linux/btf.h | 29 +++++++++++++++++++++++++++++
>>  2 files changed, 58 insertions(+)
>>
>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>> index ec1798b6d3ff..94c1f4518249 100644
>> --- a/include/uapi/linux/btf.h
>> +++ b/include/uapi/linux/btf.h
>> @@ -8,6 +8,34 @@
>>  #define BTF_MAGIC	0xeB9F
>>  #define BTF_VERSION	1
>>  
>> +/* is this information required? If so it cannot be sanitized safely. */
>> +#define BTF_KIND_META_OPTIONAL		(1 << 0)
>> +
>> +struct btf_kind_meta {
>> +	__u32 name_off;		/* kind name string offset */
>> +	__u16 flags;		/* see BTF_KIND_META_* values above */
>> +	__u8 info_sz;		/* size of singular element after btf_type */
>> +	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
>> +};
>> +
>> +/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
>> +#define BTF_META_CRC_SET		(1 << 0)
>> +#define BTF_META_BASE_CRC_SET		(1 << 1)
>> +
>> +struct btf_metadata {
>> +	__u8	kind_meta_cnt;		/* number of struct btf_kind_meta */
>> +	__u32	flags;
>> +	__u32	description_off;	/* optional description string */
>> +	__u32	crc;			/* crc32 of BTF */
>> +	__u32	base_crc;		/* crc32 of base BTF */
>> +	struct btf_kind_meta kind_meta[];
>> +};
>> +
>> +struct btf_meta_header {
>> +	__u32	meta_off;	/* offset of metadata section */
>> +	__u32	meta_len;	/* length of metadata section */
>> +};
>> +
>>  struct btf_header {
>>  	__u16	magic;
>>  	__u8	version;
>> @@ -19,6 +47,7 @@ struct btf_header {
>>  	__u32	type_len;	/* length of type section	*/
>>  	__u32	str_off;	/* offset of string section	*/
>>  	__u32	str_len;	/* length of string section	*/
>> +	struct btf_meta_header meta_header;
>>  };
>>  
>>  /* Max # of type identifier */
>> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
>> index ec1798b6d3ff..94c1f4518249 100644
>> --- a/tools/include/uapi/linux/btf.h
>> +++ b/tools/include/uapi/linux/btf.h
>> @@ -8,6 +8,34 @@
>>  #define BTF_MAGIC	0xeB9F
>>  #define BTF_VERSION	1
>>  
>> +/* is this information required? If so it cannot be sanitized safely. */
>> +#define BTF_KIND_META_OPTIONAL		(1 << 0)
>> +
>> +struct btf_kind_meta {
>> +	__u32 name_off;		/* kind name string offset */
>> +	__u16 flags;		/* see BTF_KIND_META_* values above */
>> +	__u8 info_sz;		/* size of singular element after btf_type */
>> +	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
>> +};
>> +
>> +/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
>> +#define BTF_META_CRC_SET		(1 << 0)
>> +#define BTF_META_BASE_CRC_SET		(1 << 1)
>> +
>> +struct btf_metadata {
>> +	__u8	kind_meta_cnt;		/* number of struct btf_kind_meta */
> 
> Overall, looks great.
> Few small nits:
> I'd make kind_meta_cnt u32, since padding we won't be able to reuse anyway
> and would bump the BTF_VERSION to 2 to make it a 'milestone'.
> v2 -> self described.

sure, sounds good. One other change perhaps worth making; currently
we assume that the kind metadata is at the end of the struct
btf_metadata, but if we ever wanted to add metadata fields in the
future, we'd want so support both the current metadata structure and
any future structure which had additional fields.

With that in mind, it might make sense to go with something like

struct btf_metadata {
	__u32	kind_meta_cnt;
	__u32	kind_meta_offset;	/* kind_meta_cnt instances of struct
btf_kind_meta start here */
	__u32	flags;
	__u32	description_off;	/* optional description string*/
	__u32	crc;			/* crc32 of BTF */
	__u32	base_crc;		/* crc32 of base BTF */
};

For the original version, kind_meta_offset would just be
at meta_off + sizeof(struct btf_metadata), but if we had multiple
versions of the btf_metadata header to handle, they could all rely on
the kind_meta_offset being where kind metadata is stored.
For validation we'd have to make sure kind_meta_offset was within
the the metadata header range.

> 
>> +	__u32	flags;
>> +	__u32	description_off;	/* optional description string */
>> +	__u32	crc;			/* crc32 of BTF */
>> +	__u32	base_crc;		/* crc32 of base BTF */
> 
> Hard coded CRC also gives me a pause.
> Should it be an optional KIND like btf tags?

The goal of the CRC is really just to provide a unique identifier that
we can use for things like checking if there's a mismatch between
base and module BTF. If we want to ever do CRC validation (not sure
if there's a case for that) we probably need to think about cases like
BTF sanitization of BPF program BTF; this would likely only be an
issue if metadata support is added to BPF compilers.

The problem with adding it via a kind is that if we first compute
the CRC over the entire BTF object and then add the kind, the addition
of the kind breaks the CRC; as a result I _think_ we're stuck with
having to have it in the header.

That said I don't think CRC is necessarily the only identifier
we could use, and we don't even need to identify it as a
CRC in the UAPI, just as a "unique identifier"; that would deal
with issues about breaking the CRC during sanitization. All
depends on whether we ever see a need to verify BTF via CRC
really.

One note; I found that the changes in patch 4 break kernel BTF
parsing when using the original BTF header, so if anyone is trying this
out, make sure the dwarves changes to generate BTF metadata are in
place. I've got a fix and will send it with v2 but don't want to spam
the list with a whole new series, so the following diff will fix it:

--- kernel/bpf/btf.c.original	2023-06-01 11:20:39.418807425 +0100
+++ kernel/bpf/btf.c	2023-06-01 11:20:57.012807358 +0100
@@ -5260,13 +5260,13 @@
 		secs[i] = *(struct btf_sec_info *)((void *)hdr +
 						   btf_sec_info_offset[i]);

-	sort(secs, ARRAY_SIZE(btf_sec_info_offset),
+	sort(secs, nr_secs,
 	     sizeof(struct btf_sec_info), btf_sec_info_cmp, NULL);

 	/* Check for gaps and overlap among sections */
 	total = 0;
 	expected_total = btf_data_size - hdr->hdr_len;
-	for (i = 0; i < ARRAY_SIZE(btf_sec_info_offset); i++) {
+	for (i = 0; i < nr_secs; i++) {
 		if (expected_total < secs[i].off) {
 			btf_verifier_log(env, "Invalid section offset");
 			return -EINVAL;

