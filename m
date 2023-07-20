Return-Path: <bpf+bounces-5524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317DD75B60B
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532091C21509
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D819BA7;
	Thu, 20 Jul 2023 18:00:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70019BA0
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 18:00:48 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25FA270F
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:00:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFEJsP015844;
	Thu, 20 Jul 2023 17:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=47cWodWsWyc6w790xImKt8m+zABUgwKiP20XMs9/d2I=;
 b=x0rV47xBUOFLVfPhPRpW0ZANn+KM/192KODh/8XH4VcbCJF8e3Ldza9DwskEJ3UEE/BL
 tT87ir2wzUOI0CWVWmrbn13lup6vI7iWVbEN4XRE2cRp+P41kHSF/xecHKkMUbWZiIS+
 eZ9BWleWFr1TduaKaI300U9aqbH3EgcQggyntjK8riQi3fu3DlY9sOTjRaItuH36uUE1
 NyatoYbrNQdbuetPp8f2cQjQimfNsOfgUpXNHqiglqGx/gtS4Wn2Wz8V+reBquCPUuLc
 zQzAmgveCX/+USMyDiJyUVvsxYJA30DE91Ji8GsO6eZ7cAIY2KftujQ3S+x4cWcn2+ZP vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88tgav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 17:59:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KHoErv023834;
	Thu, 20 Jul 2023 17:59:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw98ppw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 17:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDSQyfmICYXOpkucxcug4Ze97q39tKBx+quWKTuotfNvIfbx+u5R4IaIwxJaCN8SLjZDXxhgU7cjuHegMXlrnXvXQYLs0+aLmYFGbNodrjKZvHZB2cskfsi5YCThQr+e/b1HbPWKfH+Mc7tkDm9FoLzs7hrvKuvqJHjQhmaS2Fzg6v31MaFxeCc8McV1tHSk2w6WBfw9EcbplpKzmyYz2SzRWPCO+vSIHGZr2cbQCfuPWAR7+ea4AwHtEjaDNKimpf8rTqyavv44wEK/IBMPaluWe3IiYJ7NdxZW1KFCfPm/rRKDzuXl9H9Tyx8gjL3Cui54cAvSK+PAG+uScWZdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47cWodWsWyc6w790xImKt8m+zABUgwKiP20XMs9/d2I=;
 b=bTdn9mZarDdrLD6HA1jEbncMPrY3p3xxS5WR/ruFLkRdtOUdJmAYdw6nYOR5QZhovxQll8F5um6GwG0+A94Yj/bD06IBPTIy0iwCMZNbHJHSzgQh+9Ly3NDyRc6CInVm/LXCViuKCRPWfeGguFxxoSSrnLwnaan7EjMnuhO6b0IVhO+PDgq7zOnQFtwcmLsI0v5V8dkEG4R01qRFpfCU82mY7xbyIkwIKDAA3074pF0E3TZdOJFEkLNvqeQWvxKi9AUmaJ63UsTb+CkEiYgKeQmNVohTvfbYZRbdK7ThiqUfpWMq5n+hIhsqgwPyg1MvSzM1eA12YWzKjdIPYAEAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47cWodWsWyc6w790xImKt8m+zABUgwKiP20XMs9/d2I=;
 b=yQwr1jSqs3FGoyUCDU8dQIpaFjZZzmaRbI1aokPRHV5jQ699Xi1UaO02X6x7L8mQQmNLtjwoja77oyludytasoCgZARFWQQiha74fMuOhHBN6JHNlcgV4lLL4xHgjMzTc/wCAcgYBehyyw4L7X+GDYIyNvMWLeZhs2mU2OjbIi0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB7801.namprd10.prod.outlook.com (2603:10b6:510:308::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 17:59:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 17:59:42 +0000
Message-ID: <c61496fc-9ed4-9e65-1844-10d4e862e07f@oracle.com>
Date: Thu, 20 Jul 2023 18:59:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: CAP_SYS_ADMIN required for BTF in modules
Content-Language: en-GB
To: Ivan Babrou <ivan@cloudflare.com>, bpf <bpf@vger.kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <CABWYdi3iyagrnN=2uMbq_K0c4FzporQ1pbUmkUZKsiQ22srP3A@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CABWYdi3iyagrnN=2uMbq_K0c4FzporQ1pbUmkUZKsiQ22srP3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 051e91ff-2812-4afb-f54b-08db894b17d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jV/BfJyFb1V3N0ZUC3MJE2lqgDYX/BsZb0x52likxOfsn9T5tbMb2vw/A/Me0JhI3jFqlCM1d+QFHc61uRsx2cP+EPWS62Qr9N6f3MnWQwj96Hp3+MAwNnXhil2Jse5aoz3hrYjF4WbtoRptJ83KpgzHJliiJYw+fLXT9yhcy6j7kfFVYK9HjYkMUhaYkvgCDsVG94GO6jKi61zDUIQ1rVGCs/GkwxkxX/UQZT4QgLYO8aQpMgP773mpE9W/EcfxQj84fBKQrPMB9HLhsPgQkCuvxPmh7XOL6fJ2WJZJJXYj4PtjEzq4gmQ/zo1sjb8rGN0JMzVxa0cUTNnOFADUydImtvGlIhEs5aPrgsjB0kNkiXKZVU4oC9hIoq7iP7BnO28VcFkDvg8fAejD3j1p+uhNiXbKtfCRpUQgod4y43A+gwSQXrJ/DjEHq5R1RZNCOaFBGnLVs+P0WkjGArUdzVAvXoOxlkfbDyOceEBlIhieKPv6Ut4hvZx3jQObBkfy3ywcc9ExUcSJHlnu+wyUmqSwUSdajtT8o6ofEfYluDD0lksIQPQPRwPGXhAd7+SQXmgaNYKrMlbG4i1Jh0JtCt7DGpaPZf4ugOTEKhAtDOH94x4NXr9lqTF7C/9sMG/s5+O2WhzHo0/gLV0WBOgWiA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(66476007)(186003)(84970400001)(6512007)(6666004)(316002)(66556008)(66946007)(4326008)(966005)(6486002)(53546011)(41300700001)(6506007)(5660300002)(54906003)(44832011)(110136005)(31686004)(478600001)(7416002)(8936002)(8676002)(2616005)(83380400001)(2906002)(38100700002)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K0N6OTg2MzhEeVZqMVdoRVIvcFJiZkl2RmFaNjQ1dzRoVTdEdmZmUGsvUzNP?=
 =?utf-8?B?M1VVWjZzQmdGNTJoRjZNVUlnYThmV1N5cmhKdEtXM1VLampSMUJMUzQ3WjlL?=
 =?utf-8?B?NTRwMUZZbjQwVkdubzFtL2ZsR3hIVWw3TUlUaDNWK3M5SkxlOHZWMVJMT1k1?=
 =?utf-8?B?TElZeENicjU0cFgyWnVUVzRObHk0RzZUeURINWZRdEwwQkF1emVoK2FTSmxh?=
 =?utf-8?B?eFdiV0IzejBaNUNKdmtqb0VpSEVBUUIwZ1VGZjJ0aHZ2andTVTcxdFRHTHdl?=
 =?utf-8?B?ZjBhNkptaFNOK01scWpJMHorcEpqV3dEVkFNVnEyYTdmQkpFYjVHRGVzY0FO?=
 =?utf-8?B?ZkVvMGxLTEdmL0pIVUpDYlV3K1gxOUNraUFQUzREN3dsS2xEUzh0R2wzektz?=
 =?utf-8?B?STdNckdDaXcreWlpN21oUVZmcFNLeTRSQjdGU1RGR09CRllSTklsd1U3SFFF?=
 =?utf-8?B?WFpLUWFBbXN6VjJEUTE5dWpvbzYxV1dRL2FnT3lZUmtXLzFIRXE5elJMK0E3?=
 =?utf-8?B?WjVTUXhURkhDMzhiSDM4eGxIUnowSXNxaWQxWjhLNmxaa2NpaExQNlNNNTQ1?=
 =?utf-8?B?cE9IRkRwcXMvKzFNY05PbWdudVlsZ1dZQ3I1dnVodGpVL2l2WjV4N1RrdFNC?=
 =?utf-8?B?UFBLZkpWZG5CQ2VVSEtVMHNGdlBaejI2b044d1N1OVEyVkl6L08zRFk4RDRP?=
 =?utf-8?B?YU8vM3R3aTE4Ym9OeksrWW54NlpodHFvVGM0cStXMGVEWCtHcldrM2JJVGhi?=
 =?utf-8?B?ck00M2tTTjZJOHR1WEVzZkQ3MVZLSHhuMGl5NVNHSmo2azI0Vk1MSG1vOENH?=
 =?utf-8?B?bUUvcWs1RkJOdm93R05USUE4SWtxZEJwWHpBa01lOUpVRE0yeXk1MDVyRVV0?=
 =?utf-8?B?VndGZHNkZGdTVkp5dEhBZWU3YmFNWWNoRURKODZkSnV5TVVrZ2NZbUtJSE9F?=
 =?utf-8?B?QU55UUFXd1pleDN6Q0I2SlhIbEJZbkYwajl6aTllYWNnY3hnb2xUUVZKOWo1?=
 =?utf-8?B?YmhvTENhcFdkMEpYbUxpWGMrTWEwYmE0UzlpY1FuYU40SjlCR0dnZWhMVis5?=
 =?utf-8?B?ZGVvS0ZnMXB1bWYxdjBCSzNsQ1RNTUpsdUpZSlVHUytSMW1nQ3p4dGdBNmFR?=
 =?utf-8?B?WHNYT1Y3MllOZDVlZTRUdCtPbnBNZjhzOXg5bXp0eVRoWC9odUkrRS96SHRv?=
 =?utf-8?B?ai9QNGtKbU5hZ2ZIeEVzYmNNcDZiT2VGMEtJd2tQak9pZlg0YUhQQlloV3hC?=
 =?utf-8?B?MWhNTGNvQjBRZFA2Vlpud05KRTh6TUp6OFZGYkxoQ1JNb3U4VWxZMjd0cjEr?=
 =?utf-8?B?Nml5Tlpva0dpZ29kSFV2Q253b0o0UVlraXhjbmVscFkvZTJmQ0pXd3Fpb0tv?=
 =?utf-8?B?NCt6OU9nNEhZL0EzNG5YMXh2NHBKREs1VzNqcEpVeGZ0VzYyZzVFaVdQNzJr?=
 =?utf-8?B?Zkt5ZXB2TVZ1czUzWG5OMTBrK3BkTFBDYWhmMjJURGpOUnlYTEZqc0xuSFNm?=
 =?utf-8?B?ZzhCU0kwK2lpdUdEaHRqYnFuMGRXcnhlWWI0ZkQ5Z01NTkJCbis5ZWJDcFY3?=
 =?utf-8?B?T0NLSVRmT1JaTXYvb2owbFZ2WUpZTjAweFNGNGttR1F6a1o0Y1E2UEZ5R25P?=
 =?utf-8?B?b3dPbTc5L2ZuZXNrZUJHWDlYS0syODdWVXBtL1hTZjlBMUppTnd3Sy9mVXVr?=
 =?utf-8?B?V2R6Z3J1QnNzWlk3eTNwQ1ZXWEdOWDBydzUwdHBmUHV5NERac2drZjV4c3RQ?=
 =?utf-8?B?OVA4N1dYVlVkRi9SbjNSa0F5VXR1TUx5L2tXK2VRck9NZ29uVnplTG9EWlIv?=
 =?utf-8?B?bmxzSG5QSkFDRVcrVW0yTjUvNlZWK0tncmc4TnE0V3Zwa2xaK0FrVkhRWTM1?=
 =?utf-8?B?UkVqa2VHRXROcjQ3SGpCWWhDbVZpMzNoOWUrUEl2SmJ4WXZWNVRwbFZscXFP?=
 =?utf-8?B?TlR1M3FSQjdtZkVhb3ZzRGE1WkxRaWN3ODdlNHVLTms5bXJOSVBHcG0xbWtZ?=
 =?utf-8?B?OTRKTmQ1d1g0cU9Pby8xWUFMei9VZU52TzZmdkE2b1RkdDlINGNORmJJWFpP?=
 =?utf-8?B?MGIzaGNraXppZmdxZzFnUUJlUXlYNGFscGtKZm16QUlDTmFvZE1QSjJMM0xn?=
 =?utf-8?B?MWZ3Yi8wbGhUbTBZQk82TmttM3NDRGlablZ0OTdCNENkdlZvMitIQjIwcEhX?=
 =?utf-8?Q?gq3epqv8xuhlK5Kq/ghEbIk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?YVBZbE5IaFE0SmljeEV0MDVQWGRJWXVjaTVOOWY3OFFNTkdtL3pnOTdKQjNq?=
 =?utf-8?B?emhCOFYxMStiNFE3QmdRMlpDQktwVkN2UWI2MmM5MzhkWjJFcnR4RW51K0lG?=
 =?utf-8?B?QlFCWnhqWGhmWFprVE1HM1J1c3hEblZxelh1cHkxWjh5T3ByamlmWG5zRGxs?=
 =?utf-8?B?QUpmOHA5S2d1M0U5UnpGS3RkVzVGUjVnTXlydXNLSmlUTk9sL0p1T0w1UHh6?=
 =?utf-8?B?RFRqbHJ0MVR1cEVwR1hJUDJoR2tzZkhVVVpBMUg0ejZQMFVpNnAwWTUreG1H?=
 =?utf-8?B?R09IQWdocTQxUUQ4S3JVemdCSVRreEVhVjkwTEFvSHBoNlhIbVVRWUluaGxw?=
 =?utf-8?B?SWNPd2J0TWhlTW1YUUQ5QUlNV1UzRjBLSm9OYUJqa3hacGQwZTJLbDYrMFkv?=
 =?utf-8?B?WkRmaUFZNDdhQ3BLSGdITkV4dnZPN2pqMXorOHJBaEtmTzEwa0M1c2w0N0tB?=
 =?utf-8?B?d3hubGp3R0szRnZ0bm81MU9Lczk1N2R0eitZRnBkYkZPUEhxM21kVlp5UWxQ?=
 =?utf-8?B?SXY3ZnhPbG8wWXJkMnV5L0NRZnBPcXlNS3dmMGVNNFRGYmJFUS9kcHA3WlYx?=
 =?utf-8?B?RStnTG9qV2pjektkN3F0QWU5dUxVSVJtUW8waDlZbFJiOENUNkhhN2dLSC8v?=
 =?utf-8?B?UENGdmE2ZVdJMzV6enpnWURLK3M2ZGtUTmRDVHFHb3hZWkJ0YzE4d0FrY0ZN?=
 =?utf-8?B?cFJOWkpsVWxyNzFWWW1PQk1Lalhqc1E1Wm5tcnBqa1BzQmRnVGxwQVdMUGRw?=
 =?utf-8?B?dnNSalZ0d1MrbUlPWURCenJYZ3ZKZndJQ1pYQk1qazJnaHBkTXU1c3ZNTE1Y?=
 =?utf-8?B?M2dKWHdCdksybVhETnBTd0RPOXM5a0lld3gyS0NzRXRZTThMbUVlWW1yR2Ix?=
 =?utf-8?B?dkdueHVISGZEaTkwdmhacEkrZG96a0tQUExCUitmUTFyWDFoZ1FmM2l2TFA4?=
 =?utf-8?B?dkdlaWlzUjVHM2xRUCtKaEJaTmxrUGJKVjhZZmtrUmp2TUxBYVpnbHNyRndN?=
 =?utf-8?B?M1BTeE9mVmxMSjhsUXdBYm5CcnZ0d2E0QlVXVmFzYlNvZytIaXBmY3QrVFZn?=
 =?utf-8?B?SHZWbS9yM3dHUE5PNG9YU1A1UTNSbjlVMndGSmV5N3Zxd2hxVm55b2JrbVhE?=
 =?utf-8?B?UTRTMEROZWxic0svdTZBbnR3SVBMb2NrUkFrcXlldExLK1VnQ2lWQzhZM2I3?=
 =?utf-8?B?bUtKbk1ya2lxV1VDODR1THRkUkRyU0R5SVVUeTZKNlFXOXdBWTU1ZTFYdkoz?=
 =?utf-8?B?S0R2NHJaVzJrVCtiMzlOK1NIWjZaK2tYNUttWGlhbkhGQnR5QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051e91ff-2812-4afb-f54b-08db894b17d2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 17:59:42.0445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bb/1YI2e9BYZjDXOVE0iP/Dc4BJIDpOdEF014x9RTsCdGEVs1GkDGpLmuNCd0oBeDpe/sEDG0m55CccGY68V+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200150
X-Proofpoint-GUID: ige-_4KpxGX0ngeiAxRtEQKTw5UCeCGG
X-Proofpoint-ORIG-GUID: ige-_4KpxGX0ngeiAxRtEQKTw5UCeCGG
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/07/2023 18:40, Ivan Babrou wrote:
> Hello,
> 
> I noticed that CAP_SYS_ADMIN is required to attach BTF enabled probes
> for modules. Attaching them for compiled-in points works just fine
> without it.
> 
> The reason is that libbpf calls into bpf_obj_get_next_id:
> 
> #0  bpf_obj_get_next_id (start_id=start_id@entry=0,
> next_id=next_id@entry=0x7fffcbffe578, cmd=cmd@entry=23) at bpf.c:908
> #1  0x00000000008bc08a in bpf_btf_get_next_id
> (start_id=start_id@entry=0, next_id=next_id@entry=0x7fffcbffe578) at
> bpf.c:930
> #2  0x00000000008ca252 in load_module_btfs
> (obj=obj@entry=0x7fffc4004a40) at libbpf.c:5365
> #3  0x00000000008ca508 in find_kernel_btf_id
> (btf_type_id=0x7fffcbffe73c, btf_obj_fd=0x7fffcbffe738,
> attach_type=BPF_TRACE_FENTRY, attach_name=0xf8b647
> "nfnetlink_rcv_msg", obj=0x7fffc4004a40) at libbpf.c:9057
> #4  find_kernel_btf_id (obj=0x7fffc4004a40, attach_name=0xf8b647
> "nfnetlink_rcv_msg", attach_type=BPF_TRACE_FENTRY,
> btf_obj_fd=0x7fffcbffe738, btf_type_id=0x7fffcbffe73c) at
> libbpf.c:9042
> #5  0x00000000008ca755 in libbpf_find_attach_btf_id
> (btf_type_id=0x7fffcbffe73c, btf_obj_fd=0x7fffcbffe738,
> attach_name=0xf8b647 "nfnetlink_rcv_msg", prog=0x7fffc401d5b0) at
> libbpf.c:9109
> #6  libbpf_prepare_prog_load (prog=0x7fffc401d5b0,
> opts=0x7fffcbffe7c0, cookie=<optimized out>) at libbpf.c:6668
> #7  0x00000000008c3eb5 in bpf_object_load_prog
> (obj=obj@entry=0x7fffc4004a40, prog=prog@entry=0x7fffc401d5b0,
> insns=0x7fffc400ccc0, insns_cnt=87,
> license=license@entry=0x7fffc4004a50 "GPL",
>     kern_version=<optimized out>, prog_fd=0x7fffc401d628) at libbpf.c:6741
> #8  0x00000000008d0294 in bpf_object__load_progs (log_level=<optimized
> out>, obj=<optimized out>) at libbpf.c:7085
> #9  bpf_object_load (extra_log_level=0, target_btf_path=0x0,
> obj=<optimized out>) at libbpf.c:7656
> #10 bpf_object__load (obj=<optimized out>) at libbpf.c:7703
> #11 0x00000000008b90e7 in _cgo_58a414c63447_Cfunc_bpf_object__load
> (v=0xc000237bd8) at cgo-gcc-prolog:1232
> #12 0x000000000046c224 in runtime.asmcgocall () at
> /usr/local/go/src/runtime/asm_amd64.s:848
> #13 0x00007fffcbfff260 in ?? ()
> #14 0x000000000041020e in runtime.persistentalloc.func1 () at
> /usr/local/go/src/runtime/malloc.go:1393
> #15 0x000000000046a3a9 in runtime.systemstack () at
> /usr/local/go/src/runtime/asm_amd64.s:496
> #16 0x00007fffffffdf6f in ?? ()
> #17 0x0100000000000000 in ?? ()
> #18 0x0000000000800000 in
> github.com/golang/protobuf/ptypes/timestamp.file_github_com_golang_protobuf_ptypes_timestamp_timestamp_proto_init
> ()
>     at /home/builder/go/pkg/mod/github.com/golang/protobuf@v1.5.2/ptypes/timestamp/timestamp.pb.go:57
> #19 0x0000000000000000 in ?? ()
> 
> Here it is in code, where it happens after vmlinux does not find the
> requested id:
> 
> * https://github.com/libbpf/libbpf/blob/v1.2.0/src/libbpf.c#L9219
> 
> And in turn bpf_obj_get_next_id requires CAP_SYS_ADMIN here:
> 
> * https://elixir.bootlin.com/linux/v6.5-rc1/source/kernel/bpf/syscall.c#L3790
> 
> The requirement comes from commit 34ad558 ("bpf: Add
> BPF_(PROG|MAP)_GET_NEXT_ID command") from v4.13:
> 
> * https://github.com/torvalds/linux/commit/34ad558
> 
> There's also this in the commit message: It is currently limited to
> CAP_SYS_ADMIN which we can consider to lift it in followup patches.
> 
> Later in v5.4 commit 341dfcf ("btf: expose BTF info through sysfs")
> exposed BTF info via sysfs:
> 
> * https://github.com/torvalds/linux/commit/341dfcf
> 
> This info is world readable and it doesn't require any special capabilities:
> 
> static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
>   .attr = { .name = "vmlinux", .mode = 0444, },
>   .read = btf_vmlinux_read,
> };
> 
> $ ls -l /sys/kernel/btf/vmlinux
> -r--r--r-- 1 root root 4438336 Jul 13 06:33 /sys/kernel/btf/vmlinux
> 
> My question is then: do we still need CAP_SYS_ADMIN? Should it be
> CAP_BPF / CAP_PERFMON (available since v5.8) or should we drop the
> requirement completely, since we expose vmlinux btf without any
> restrictions?
> 
> I'm happy to submit a patch.
> 

I think it would be possible to gather module BTF data via
/sys/kernel/btf instead of via iterating through the BTF objects, which
is where lack of CAP_SYS_ADMIN trips up. The only problem is you won't
have the BTF id of the module (which you get from the object), but I
don't currently see that being used anywhere in libbpf. I might be
missing something though.

Alan


