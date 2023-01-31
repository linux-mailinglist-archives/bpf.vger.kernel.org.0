Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF92682C58
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 13:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjAaMOl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 07:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAaMOk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 07:14:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C401E410AE
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 04:14:37 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V7wwBu024165;
        Tue, 31 Jan 2023 12:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BgV6qFDvH1/HHsTNPALzBFqRAwyBVfGvzrGkwCrE2G4=;
 b=ZYlezSbUkEu1Q1PfgLxZ3NUPUxt39QvX8N77gwcNk7yNUaEM9yJ8qXLXYjwBgPvj5JC0
 p4d9mRKT253S9KGetlYupjJanKNkmeh910kfSsapRUHui9/vyttbIhfs/NTDjmEWFjFf
 zUpwNm4RjWn2UrqCneq77hEzJO0zQpWfoY1D21xMBBH0En/o2/AKoau55QXeDTZ8qnIU
 736Jnx8ShveztILcC8nPnJUSzVI4CYbmeXxNxSym6OV4iucCWm+9AfiwJg14ia/8N0Hv
 JRJj/gWuToiMlyzrFipStItvICo8Jn2B5wbRU8goxK05WwG2P8SfFbS+LemDVJBWrxLU ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvrjwbq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 12:14:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VA4HNL031873;
        Tue, 31 Jan 2023 12:14:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct55jta9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 12:14:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ6yDqfUt9d8ru/MzezS3azxUNaxrb4nYIN38IxI9nx6Q3VcyVoSQNDBuk9EQkUQdsiiHjO8YKgOM2LFS0b+VqkT7Gn7S7H4axx+ArVvdXylbmltD3qFNjm01V9QuR4LNlCaSMoflUaa5J4A/rivyyh1pfoAQ+XIIsUO+FMJqSxBps86NPZDwiccLOKzMIdWR//K6GCYDLO/riczJUzy1wv62dIYt1I+ebFJpvt337JewEMdGqPsr9dHorifLjIVyJJlPvLjv6VIGXubmUhB6qPCMER7aVg/CLKeiGmi8e4FyMd9z11iIhe8fLfZZpxyWIEZ2uvfbcir00avkkDJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgV6qFDvH1/HHsTNPALzBFqRAwyBVfGvzrGkwCrE2G4=;
 b=Xh7Za3wVzW5gpuHSxUxwiLqDqWZJV/hx9Yb1z2u8UI1IQHM0sfgxIkY97cIFXQrmspOGWIqDw6llSfAMV5o6gVanADWNDak0T37qoGZO0RQMihs1MbwjzAXSJ5V5nLBp/kIVlqo++TbmnvDFW+U9PHwMm1/yBsESAkFF3Egfn48vgP1112kratqEz+X7UAAYIoMygQzeQJwS1/0zfJrbw+2Y+i++NbtKVloc0fw3Zvn1+HjbyD0XPK5/lGyu4KRmG52USe+BxVBkDUzgQi4zxOXfS1L855JohF9VdBtdYPt/5AKvuntgZDdVREd71s24P4AO0d40wKfbySBK+4JAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgV6qFDvH1/HHsTNPALzBFqRAwyBVfGvzrGkwCrE2G4=;
 b=Zqt2i8Xq8y/IHeCA7L4Su7wkFTqwUlbllWOiiNdeMWgjQcjfwzyqrXSrfJTTR5kT2uy9ziQbjUjkQK6juONqL3JCsFM7SO3uwBoSv7NmNtWKIXQqbE32jThV6J9YVu73YHxh0QrChjFpwyjyUpl42Nf05n3nR3qfyTq4yWI+6Wg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 12:14:11 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 12:14:11 +0000
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-2-git-send-email-alan.maguire@oracle.com>
 <Y9gOGZ20aSgsYtPP@kernel.org> <Y9gkS6dcXO4HWovW@kernel.org>
 <Y9gnQSUvJQ6WRx8y@kernel.org>
 <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
 <Y9hf7cgqt6BHt2dH@kernel.org> <Y9hpD0un8d/b+Hb+@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
Date:   Tue, 31 Jan 2023 12:14:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y9hpD0un8d/b+Hb+@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: b56b37a9-47c4-4add-2172-08db0384a953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCKyRw3os1dWzuNPj5j+qCk38yhG+b77ztkjm9pNZllMuACdoqEniOVoLfutrCcukDOl1jndBhb3Ohlvk+sFBcRXsvpQCnf1oafz8e/d+86NXxDEbg2o3TBTHDOnoQVfaHqSdfb+AUojkYG6HX5tER1FaVWHFsfGLB4wUy6Mfbb9nkYZ4NtZUK3umKiouCQOMRwn9EnxuC8/vrdw/QdC9RyC/++wSFH/9oo4jLTnlUCiJJnzdmoZW4NAmLSdq0ytHJ7JrNIEOdWoTwNKe+rwl4PESCBjzS8n249UFVq8mfvAaGuR/DzKOa7opWowE9L5UiivOfYN6jOfqoxHZcxtQUMDFMhNwEa/obKYQ2xKMhlg+ClcA+8mtFa3KEc/0JXHH0gAg8CeQwWeU9ivUsQ/VYujAyUGoNaDNIWciHu8eNPUxJ6+8NPmM7TgV6FwwgWUA3nYYI1Gyvzz0fB4Z6oz7cijt+gYBgd/5TG5RO0hEo+QDtenXD+R8vD8q5UMTJ2ucu43JAXywiXHbw+FI/pLdAKHFyRsA3tsHxiuW1PkKD5R3EaF+i6Z8+EEUopEO6Z06oWgveNVxmF0x6ExuT34hlNC6Yy1IuFaRUSqLVRZ9o2qwzW2O4wkj0fPOIMsQol0OQo+XTKcZbUzaJEqVsMo2a6RDvCauxpgf4WnS86sN457fPn++e1CPUHNFKho4he4oFOo0OFqwfVk0unIoMvArFNdDhJPk5exR1qd5z++U/xV9v+szddDIR4lUlRBWfC2I4e67te4kCkUMsGvFjY64Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(6666004)(44832011)(38100700002)(316002)(41300700001)(8936002)(36756003)(83380400001)(86362001)(31696002)(6916009)(4326008)(66556008)(66476007)(66946007)(8676002)(5660300002)(7416002)(478600001)(2616005)(6486002)(966005)(186003)(6506007)(53546011)(31686004)(6512007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hqZWMvaDRKYXd5VWY2Qm5xemtlNSt0Sk9RNjZKbHJHdzhydG5OYm5ldUFD?=
 =?utf-8?B?MGV4QjNZQ3FYYWlkZ2FaV2pnU056b1pLQXZ2QXFvUVkrK3hzdnl4ZnZJWHB1?=
 =?utf-8?B?WExkOVNjNzdyUW1DV21pTlRzM05SZHV2MUJhRk00M0xWcTl2eE4yaExVV2tp?=
 =?utf-8?B?NzREbUpyZHh2NlF5Uk0xWUVoemtTZlBFeFhrV1JEeVg5YkZpdXQrVjNORXIw?=
 =?utf-8?B?cGxNREdnVHNKZ1NSWFd0d0d0cHhxWVZwZXBYN1NtY0tJLzdRVVhWRDNlTzl2?=
 =?utf-8?B?U0JWbEhOdkd6RmhnUTlCUmpyRFRKYXNZSmdWU1k3SyswMXZjWkVyMGF4TVY2?=
 =?utf-8?B?Mm8xTHdVNmp6VlhqeGNkLzgySmR0anpUNkh6bHF6bU5FYUltTEx5MFlHZjVR?=
 =?utf-8?B?VTJ4ZGtib0xxM2tITWxTcnY4YXBMWjJJTHN0V1BiL21CcFRCRWFVQkpjOXdy?=
 =?utf-8?B?bDcyVWRVU3UzZExFS2dEbmJPWjRUWk52UEptK3pHM3VuRXd1MTlRREV1MUpm?=
 =?utf-8?B?VWErd3NFa0N5NFJ5bU1jczRTYlNmdnR1cVl5TXBhNm01UFM0NmkwdUZRS3Y0?=
 =?utf-8?B?aGlFaGU3QkxaVDRJZGNaNjBRR0gvUXVCVjc3Vm5mNnh1TUNQbTlMMERPcy9I?=
 =?utf-8?B?ZUpkYlhjTzl5TEROUE4wOVFMMUNPWCtDK1ROTnNmUWRNemlScmxLYklXa1Rj?=
 =?utf-8?B?eFZDSU1kUkpBSlU5a3hqMmxwbU8xSnlrS2k0d0tGSi9idWovWEsxeENaNzZG?=
 =?utf-8?B?azVrRG8wN1diK3dIUWl1T2JJT0U1TFNHdGkyc2h4bkRRaitPeUdxWHBTUHFC?=
 =?utf-8?B?djErUTFST3ZTSEdnTGpwbWhaYTNuOEJmYzdaZi9WQlJTQU0xUC9hQm1SMWdn?=
 =?utf-8?B?YkZKeFduUkNpUkZBMGRHM0lWV0lxdWMraU53YlJiM0swQjlkbmQ3SjJpUFhu?=
 =?utf-8?B?UTdxWjNpZm9pYm0vdGd0Zzd2T1hhKzIvSnVqM0dCOVVXbFNrbCthY2M3ZDF4?=
 =?utf-8?B?akxuTnM5V3NpYU0yZlR0MlRqZUxHWWdGVDgrb2tiU2FheFNDcFg2T0FrS2Zh?=
 =?utf-8?B?aS9RV3paN2RCYmxFSk5KYnU2Zi9yZG0yUWhXYjY2RWFGSlRSWklIUEJRTTlP?=
 =?utf-8?B?OWpKNUhhMEFhOHh5UGhRbHdkMjA0THhSN20vS1JRQ2lscERaV3EzNlVVM2Za?=
 =?utf-8?B?QTM0VTdWU2dmYmt4YmJsZzMxeG12LzZRaFdPeU9rdmE2YjN0VnJoY1l0Yk1Y?=
 =?utf-8?B?a3h3dnBtZG10dGpZYlg0ZEFRbzhqZ2JXbjQ0N2RxZjVseW0vWW8xN1MxSnNQ?=
 =?utf-8?B?cTMzMzEwVHkzWC82eTc2aElpajFTUEFMQkpQWUg0dTZvc3NXQnhmNkMxcVkx?=
 =?utf-8?B?WjQxMHZFZWlWLzBVdXprTXZmRGhnTHNkRFVYZlJ0MjFXa29jWHFod3VpR2dC?=
 =?utf-8?B?QVVuRVZsRkJ5bjZMQ1hFY2dqL2I4K3pBZG9MbkpVV0JoMkdYYlZ2NFF2eW1O?=
 =?utf-8?B?emVPR1JUdG5Gam1BQjF2VWI2cTNDVEFTOFNhRG9lWG5kK3owTG9rWU41UFlH?=
 =?utf-8?B?NEpBYXBLdjlxS2ZpWVhKTE1KZXRxQVovZDM3R2RBMGhuVFBNSXM4emhPa29H?=
 =?utf-8?B?b0J5RHZreEM1MjdVZWZQSVBKamlyR1ZPUFhxN0N0SXlmdEtDZm1iV3FGZEsr?=
 =?utf-8?B?VkJ4Y1dnODM5aXdKSXAxVUxhTXJYaEZTaHFQc1BoTEVTNTcxNU5TWjJ4OVdr?=
 =?utf-8?B?Mi9QV1VMakhtZUF1aStKOWpyZlp3a1N6ODl3d2VVMC9WWVU4MStKVUxXSmJz?=
 =?utf-8?B?TmxBZHduTUlPd1NYemRSbUczZlFjbzJ3ZWRWTDhiRklSMTJoOXFSQm9VeEJF?=
 =?utf-8?B?QTRtdlZyOWdRb3A2UFluWXdFNkIvRVBTUHV5alVoaTZpNXBuT2JrTEx4TWFV?=
 =?utf-8?B?K0RKNjZsUTQzbVN3MG9XcWkzZW5XWGpuUVVKMEdkQVNVNFo2ZHZWZ1NSV1JE?=
 =?utf-8?B?cXlJRlFBWER6bFlzZkZJelBRYWJLT1NxVmhEVFJnNUJ1S2o0NkZmYWljaUYy?=
 =?utf-8?B?dW5Yd2E5UHpxVmNPeHowWFJrYTdhZGd2OWlFR3FLOHFnRk4zVlprczhLcW56?=
 =?utf-8?B?dDhDbnhxb3VSQmUwVHJucy9Nd2hpNWpFOTdTZElzdW56Vmt1NTd2cm40dkpa?=
 =?utf-8?Q?0XMdZ1CFMVg4dYMx9o+hE0I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?c2NLZWlET2JEOHhacWN3ZHM4WWRsYjJBSjBwVWNwVHhmM1BlRnZwR1NTelFW?=
 =?utf-8?B?UnVlMjVPVDNDNjNibVROSlBlMmJUZTBWb29pUlhQSEZRV2NrcUwyYk9URHlw?=
 =?utf-8?B?ZUVHdEVRbUVWbWFlMGlDR05vUE1rRXhpYUVmaU5TMEhxTHVZaDFsNHZJeGs3?=
 =?utf-8?B?WHgzQlV0cXcxeUVITHFPZXBSNklzdmwzYmJQZjBhWnFzTks1dHNpYVN2MjNh?=
 =?utf-8?B?NFV0TitENWFPVlVveHJtZGUzb0NvVlNpTjduWndJYVAxTDI0SmcydmxuRTE5?=
 =?utf-8?B?R1E3VEc3MFpKeGUvaDF1K1RUZHZENnY0ZVRab1NnbEJWZjlFQ01UQWlvM281?=
 =?utf-8?B?OWhVWFVTNW9pdjQrMEhEcDVpNzJkQmJXaUhaRG1mYmNLcTFGUlBqcmFaelJR?=
 =?utf-8?B?ZFFzWEtTdXdnQzdMYUorVzZvWGlHc0g5eEtwb0lDZ3BGOU5weUxLVXFvdjBu?=
 =?utf-8?B?NzBtNUd0V2FMWktTYmNRd2RZQXgxYmV0SzkyME9GREY3V0UvN3NCOGpzVEZH?=
 =?utf-8?B?ZHIwMkFGT3VPTi9QYjB6RnRramE0UXNMb1hZMlJWajB1Y0lPb09aN09YdnhZ?=
 =?utf-8?B?YnBMVXY4TkIrb3B0cVRtVmVxNnVlOFAxOHRjbXBPd3owMi9LZVRQaVhFcmI1?=
 =?utf-8?B?eGw1WExhTGx1S3cyWE9WUEFINEtJT1lYelcrSHMyQWxXRU52dE9yL1d2U1h2?=
 =?utf-8?B?U1Nnc2FnUmM3WTltQ1FYR25VSzdVNklmTkY2MUw4Tmtjb1htYXBLeHRZRnNL?=
 =?utf-8?B?NVdMMVVwOVQzNzAzdW1IUUJHTlFWTVJXMjZiRnRwVloxM1p1SU9PNi92Mms3?=
 =?utf-8?B?Z2ZsNEtXVWF1c2dvUmIrZk1TWlFSTnB6N0RSQXJpbDh3Vkx4R1VKUkU1THBp?=
 =?utf-8?B?MzlOM3AveTdZOXZidzAvb21zZWYvQldrbWxJNUR1blRyZmFBeGRJdVRPeXJ2?=
 =?utf-8?B?V1pNREplSUJINTgxWVFEMHZuNXpoc0R5R2ZTWkliVm1wMndFejV0THcvck84?=
 =?utf-8?B?NGgzaUhvbWFxcHJUQy9uLzRlUk14QW9FenBoUzgzQk04K0dzN0N0STEvT1Qr?=
 =?utf-8?B?N1cza0JMOHJLTGxUeDFJT2I0SzdlZVpiclZCV3JueHB2NmhSeXlsMWpsSUJU?=
 =?utf-8?B?Yytmb2lwTTNiYmlWL0VHcWducE5lTk9CZmJoRVlZV2xZOXBFcHdBQ3c2UXpB?=
 =?utf-8?B?TEovbjZyd2ozTlpWM1BucWV3UlNMaGhTbGdIM2RTRDF4TE8vaVRkV0t2NjUw?=
 =?utf-8?B?aElDUDZOZU5LZUhCVXR5SmxFbGVsUWFsUWVZeFNMKzZFTUVzZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56b37a9-47c4-4add-2172-08db0384a953
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 12:14:11.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GbwAgFxZRa7v0ZqezPIQOuzGXeisJ51oaRG43XLUEUv2ed5LKTokw2eBVaAESshgJnqg5E64OajFEQTHLrLQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_07,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310109
X-Proofpoint-GUID: ErfrwNjzLFdF47j6ov89-JNrhbrsJodT
X-Proofpoint-ORIG-GUID: ErfrwNjzLFdF47j6ov89-JNrhbrsJodT
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>> +++ b/dwarves.h
>>>>> @@ -262,6 +262,7 @@ struct cu {
>>>>>  	uint8_t		 has_addr_info:1;
>>>>>  	uint8_t		 uses_global_strings:1;
>>>>>  	uint8_t		 little_endian:1;
>>>>> +	uint8_t		 nr_register_params;
>>>>>  	uint16_t	 language;
>>>>>  	unsigned long	 nr_inline_expansions;
>>>>>  	size_t		 size_inline_expansions;
>>>>
>>  
>>> Thanks for this, never thought of cross-builds to be honest!
>>
>>> Tested just now on x86_64 and aarch64 at my end, just ran
>>> into one small thing on one system; turns out EM_RISCV isn't
>>> defined if using a very old elf.h; below works around this
>>> (dwarves otherwise builds fine on this system).
>>
>> Ok, will add it and will test with containers for older distros too.
> 
> Its on the 'next' branch, so that it gets tested in the libbpf github
> repo at:
> 
> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> 
> It failed yesterday and today due to problems with the installation of
> llvm, probably tomorrow it'll be back working as I saw some
> notifications floating by.
> 
> I added the conditional EM_RISCV definition as well as removed the dup
> iterator that Jiri noticed.
>

Thanks again Arnaldo! I've hit an issue with this series in
BTF encoding of kfuncs; specifically we see some kfuncs missing
from the BTF representation, and as a result:

WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
WARN: resolve_btfids: unresolved symbol bpf_ct_change_status

Not sure why I didn't notice this previously.

The problem is the DWARF - and therefore BTF - generated for a function like

int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
{
        return -EOPNOTSUPP;
}

looks like this:

   <8af83a2>   DW_AT_external    : 1
    <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
    <8af83a6>   DW_AT_decl_file   : 5
    <8af83a7>   DW_AT_decl_line   : 737
    <8af83a9>   DW_AT_decl_column : 5
    <8af83aa>   DW_AT_prototyped  : 1
    <8af83aa>   DW_AT_type        : <0x8ad8547>
    <8af83ae>   DW_AT_sibling     : <0x8af83cd>
 <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
    <8af83b3>   DW_AT_name        : ctx
    <8af83b7>   DW_AT_decl_file   : 5
    <8af83b8>   DW_AT_decl_line   : 737
    <8af83ba>   DW_AT_decl_column : 51
    <8af83bb>   DW_AT_type        : <0x8af421d>
 <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
    <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
    <8af83c4>   DW_AT_decl_file   : 5
    <8af83c5>   DW_AT_decl_line   : 737
    <8af83c7>   DW_AT_decl_column : 61
    <8af83c8>   DW_AT_type        : <0x8adc424>

...and because there are no further abstract origin references
with location information either, we classify it as lacking 
locations for (some of) the parameters, and as a result
we skip BTF encoding. We can work around that by doing this:

__attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
{
	return -EOPNOTSUPP;
}

Should we #define some kind of "kfunc" prefix equivalent to the
above to handle these cases in include/linux/bpf.h perhaps?
If that makes sense, I'll send bpf-next patches to cover the
set of kfuncs.

The other thing we might want to do is bump the libbpf version
for dwarves 1.25, what do you think? I've tested with libbpf 1.1
and aside from the above issue all looks good (there's a few dedup
improvements that this version will give us). I can send a patch for
the libbpf update if that makes sense.

Thanks!

Alan
 
> Thanks,
> 
> - Arnaldo
>  
>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>> index dba2d37..47a3bc2 100644
>>> --- a/dwarf_loader.c
>>> +++ b/dwarf_loader.c
>>> @@ -992,6 +992,11 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *c
>>>         return member;
>>>  }
>>>  
>>> +/* for older elf.h */
>>> +#ifndef EM_RISCV
>>> +#define EM_RISCV       243
>>> +#endif
>>> +
>>>  /* How many function parameters are passed via registers?  Used below in
>>>   * determining if an argument has been optimized out or if it is simply
>>>   * an argument > cu__nr_register_params().  Making cu__nr_register_params()
>>
>> -- 
>>
>> - Arnaldo
> 
