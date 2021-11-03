Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C6443CF9
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 07:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhKCGPh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 02:15:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230152AbhKCGPg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 02:15:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A2LZYaT012837;
        Tue, 2 Nov 2021 23:12:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=eFu6vf90+Wx22NKEQ/x5nbr1uYi+uR0I6IIE8B9gIf8=;
 b=X9N3pTCZNNDnc7nknCYUefphvgjzygT+yuxWz94St3ZshEgmmZEFJkJbvnoFp/l5op/T
 ARnphYOkbOsrDBrUcF6PrrRjueYrFqDCBUncjbnmAzBnGjBO1XSKm7rajVXg9w9uGF2t
 fjJHN3YLTm6tyfZxPpw7o39m4r03PEVZsc4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c3dcethdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 23:12:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 23:12:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8kazqfPkvR+PNkQpmUm1a5zZnpKPsHc237BSCB/KRMRE34aBMlWgOEjf3J576aTiQ9gmDngMw0VRCOG6ATt91PU0tI+hOs8yUzMHoAW/vYarXb3dhJquwuwG0zku/V790OPP/ZBKXNpa3l6JZKP+NjB1r2s+PYHiBApeLRU6LC+rW8Jlr71JLH8EfuXsCPKo6XQZMRqix+C9BCWnQugRNtUqCFI0UwkK3UQYqcmDxffKP0Rx6LPSQdwWI/9jhR5zvhYCN59MwZgty+LPQZhwmDEJZLY0DyDF2ZFqTMZ+odtePuBpx6tKQx/2vEmtoHVK0932T9xizO0ydl5UNvDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFu6vf90+Wx22NKEQ/x5nbr1uYi+uR0I6IIE8B9gIf8=;
 b=DvYXAZTLiggX80kRAMZ5MpWb4RDRtu9vA83sxhPu2/+Q4Ne9IHpoZrfMkk+L5hKvY2svW0yKSXkOxjOvOGwJ+bua5Cu1RgsBdtiQZPionQhB1K8dRBQekBwU8ft+fZruibefVObhadWMfrE38uqZW/FHfX7HOoktcF92EfG66LHqy9cO8QA5D35Ts+cQ79wF8StAAWJne/7i7v1IzgAu4yjd66pOrkfcHHJvBrVR1wOKFvKovYeOOMi3j/bjewigpK+oVaW4MVw7Ml62e3Bz+f16QlfTGeLfzCnkhtItew2mcZUVDS5OPYzOrjsg+vfFqxrnSxIaD4Yzhe28NDmDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4016.namprd15.prod.outlook.com (2603:10b6:806:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 06:12:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 06:12:45 +0000
Message-ID: <cf51a793-d0ec-23f1-419e-a767c8803570@fb.com>
Date:   Tue, 2 Nov 2021 23:12:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 5/5] libbpf: improve ELF relo sanitization
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20211103001003.398812-1-andrii@kernel.org>
 <20211103001003.398812-6-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211103001003.398812-6-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:303:8d::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::1066] (2620:10d:c090:400::5:b3c5) by MW4PR03CA0162.namprd03.prod.outlook.com (2603:10b6:303:8d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 06:12:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11b99091-326c-430f-5b25-08d99e90f3ee
X-MS-TrafficTypeDiagnostic: SA0PR15MB4016:
X-Microsoft-Antispam-PRVS: <SA0PR15MB4016B91EBCD98B2DF7DCE6B8D38C9@SA0PR15MB4016.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oESDSJmAQr55DuE69OkNCIHZVAR7LUq/a/vcKON+BAcW0S34VHAHaPoXSR5SXLCpq7DZC/sElFN03dFXNkE7l3hZCmR22mwYxB+0CZH580FMtFDMT+RmAR4Ly9ygbdRizIHfv9gk57NuK5UmFkE8tFkixFve+mBgyk509F8E3rt+xEYMSq0KVv0ozZiPVeh/ANe+ZGSmpokKKomnqI9T0nnN5LlXloAeYXsoB/JzBN03kU4KnSCro5OADVWwctKI/qbURoaCGQqY7/H0AHaBhLgteYEOoKniErkfzO3aVFPC5kYNBic7DpenxJutXqLPSYCn9clnA1zkMuOtU4qA+Rd6KRsklVkezimqtHQeQR0ZI9RjfVgUS9zkXJpgdZVjueHLdn8cedAeHh88buoH4sF/jK8rj+wXoYk4bw9BEaZHHEagN+Fezjx2dzUeePzTeJzXNSW42mgIFN2ny3I5ZO4spUQ0vYL/libJLq4PeA0G1Q2G0TEWyaCsN5qsXLB4cERKCDpkS1qDpTZvGhjc5sPnD39zNna3zu0oMnbwMXHB+diyH44Bz8e054AGM5gjM6HtVfT6ZeWbmoRCtwJsm5HT/wN/WqYl2JFeg7gDO3n+01ONWyDZAj4Tu+3H4sRLqWi2tSDJFoviemotLGLwYYYBF/Vi1dnLcNnC5QCiJhqmJOdYX7jbiXIxAtERfyGMogmFFnJBkn20vmnLvQLA8inUfBeGhErUin3QLLX157bdDCeLpojeJoJWsu5BNQYf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(508600001)(83380400001)(36756003)(38100700002)(8676002)(53546011)(52116002)(31696002)(4326008)(86362001)(2906002)(316002)(6486002)(31686004)(558084003)(186003)(66476007)(66556008)(5660300002)(66946007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WS96WlZhWmpkc2FqTmpZM3RCU3piaGhEaGFPSTNUSzVjT0FYVktrYyt1Z1BU?=
 =?utf-8?B?MDZneUhNTGJSNndxOFVUVlNtUWh6TEw3czdIWkpGcHd4SnV4dXJWOUZxYmVO?=
 =?utf-8?B?QXlUNWk0TDRsQzJiRC9VMk91aVpQVDVHTkM1ODlYQlFtaTFwZEVvVG9JT0pC?=
 =?utf-8?B?Q3J5a3FPaEZGcnZOT3c4VUtwT1lsRzlwVS81NmM5akFzUHRHVlJyNS9IZHVZ?=
 =?utf-8?B?SCtYempySWlSK21GRG9FaTVCRFg2NmN6eVlhenkzV1c1bW5TMTBBWjVHOUpy?=
 =?utf-8?B?cXpXU0RtaEZmbHdMZng0YjdLV3JSTGZGUXl0NGwzUHIyWHMzYWc2SmQzeUlD?=
 =?utf-8?B?SzZ4ZnJUcDREaWszMklmQVZIZ3lJMVArWWdNN2lZRFJHeFNjNHFPTTI2blQr?=
 =?utf-8?B?VVk2L0Z6aVk3c2k5dlNka0NPc2hCMk5QSHI5M0dvTVh2WmZvZWo0Tlk2Rkl3?=
 =?utf-8?B?SVUzS2Rqd1FJc3JzcW0rTFVKaGpJR1dETkF2ZUpGNC93cTF4Zi9TWlcrODc1?=
 =?utf-8?B?eGZpcC9jM3lwcWxaVjNKQlhka045TGsrdWRGMkhKbkF4aDhGUEY0YmpFR2hs?=
 =?utf-8?B?TGZoM3Q2TituTUVOaTU5dFNYS1BseXFZWDJ1OGozTkl5bTZZZ3ZUY3pzZTNI?=
 =?utf-8?B?Y3BSMnNoZE1xcnZHa0czaDJkc1dHZVJ2YTB3R0JMN25HZ09pQkQzWDFENzlm?=
 =?utf-8?B?ajlPRWVmZ0t3WmRhT1VOV1VEZDhBaCtxVkdDZHR6V3VMd3BpVmYybW83c3pL?=
 =?utf-8?B?aDUzZ3JKRFV5QXZtc0IrUzNONXp3V1hQSGp2cWdVOSszQmRzdkQ4S1lZMFdo?=
 =?utf-8?B?RGdQM1paSGJzUk1TSENaRVIrYis2cGJ0YmEwSEoyU0FLUUpxTURzT3dUWGt2?=
 =?utf-8?B?Y2xscXgySjc4eVZOWWUzdDZUNWRQc1FLc0dqUzNsL1VXWkl3dmkvR2FvTE85?=
 =?utf-8?B?dGREVFcrb3I1bzNqS2FzU1d3a0FIRTBIU0Y1ZE1mZytDeW53Z004Snk1UkMv?=
 =?utf-8?B?QkU4Q21OL2hPbW5BRFN1VVZ1SnR6MEQ0bWxXcXNNVkM2UmtJQkljRG5iYVMv?=
 =?utf-8?B?b2pEcDJ4VnVSUWUvRjN5UFMvMEhLcUxIQnF4Zlg1ZXNlOEF3ekZVMjJTOVIr?=
 =?utf-8?B?M2dBencwK2xIbXhNbDdQS1hJcGVia3MyV0ZwUFRaWUJERExPZlpsMEdNREpu?=
 =?utf-8?B?Q3RFK241Y1l4bUlOUkdUT1ByWllsamxlTnpOckdpQkx4aDVvaS95QXhTQ2N5?=
 =?utf-8?B?Ly9lQ1lxbXo0a0FxQWd3WXRUKyticjdPNGdxRTRaM2VWMWs3cUxBdldmRXZE?=
 =?utf-8?B?NGRHNUpGTmFNS2NSYVNVNHdmbG52N1RYenRNTWJaV3p6VzZsSzJmMzZSb3Nj?=
 =?utf-8?B?R09RajU2c2pwN1lSR3NqcXNrbDNORU5DMlBpdGtmNU9qRUozYlBmZmZIMGdT?=
 =?utf-8?B?ZkM2aVUxa2ZVZWxTN3ZMZTVXdkhTbUNJdkUxSEJJaDhBQm1UZW9IQ0FEOHFY?=
 =?utf-8?B?dzQ2RE1aaEJ2UVd3eHFMWm1HRXcxRUNWc3BLUXZjUmF4aXBMRWlldUhaNXBO?=
 =?utf-8?B?Y0N6R0FERlpubitpYVBSWlg3TE03NW1OM3hibCt4eEovSU1hVmlEV2N4R3pV?=
 =?utf-8?B?RGlJc2RrdnZKT2xlVVN3VUV0U0YxLzFlc1NhVVUyQVdUSWV4Q25qbUFHKzZL?=
 =?utf-8?B?MGplRjdQVW11RHZENERlb3k2UzF0TUVlR1U2OVJQOXZxS0U3eExSc3FvZlRL?=
 =?utf-8?B?SEJyZzROdHpBd0xPdkVuNmwyaklPWG52U0FrOUVNanlmNjJoK3o2RFo3dS9Z?=
 =?utf-8?B?NldqQTVTakdvR25yTVYzeVVSaThpMDQ3bGQrRXh5djFDaSs0ZGx1RVNGVUdN?=
 =?utf-8?B?Q3JubWk3TkNuVjd5RmxGQVhyZXVXMllFZHg1dTFlMml5NURuTXRjWTVvT0JD?=
 =?utf-8?B?NlRhQ21rWTA0SlQ1N2UxNVR1ZkxOelZ5UTJ2dk1yR2tXT0MyenBBWFZLdHVX?=
 =?utf-8?B?ZHQzZEc5SVZWRGVUN2p5SkxWeHZkclBURU9rMHlPYUU3Z3dwMnI3KzlJVy80?=
 =?utf-8?B?SDMxdDZtN2hZNVo2LzI0eW55VFNwODBzY1dHcXJnb1NYQXhmeEV3RHBHLzJh?=
 =?utf-8?B?TExya0Mxbk5IUFN5MC9LMkltU2w1enY5S0tQM3h1S29FSnptWTZLdnNBZ0p3?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b99091-326c-430f-5b25-08d99e90f3ee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 06:12:45.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mN8VMhjXdntSQfgySjNqekQXvfVS+YRL9OifCu58vWHXXwvNER3DeO1I30XprfRf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4016
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: nSaUpAZauVdSDuI5pPAf5w3xzkipHnTn
X-Proofpoint-ORIG-GUID: nSaUpAZauVdSDuI5pPAf5w3xzkipHnTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_01,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=469 suspectscore=0 clxscore=1015 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/2/21 5:10 PM, Andrii Nakryiko wrote:
> Add few sanity checks for relocations to prevent div-by-zero and
> out-of-bounds array accesses in libbpf.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
