Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D843E4F8B
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhHIWxy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 18:53:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50416 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231329AbhHIWxx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 18:53:53 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 179Ml7Tp028209;
        Mon, 9 Aug 2021 15:53:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=EHdf0637JC3H0qDLJWbrHPdXz056IcNI9ivoOVdS9Tw=;
 b=bl81OOx9WEpgVIrxf4R/E2qsCjVexuy+0Dq5XQV0T/3xyTACWz12tiA6Q4Ba6IaX4wXV
 zzkX8+3LivC5Q06kulm/yWLjKiR04svXWHtaxLLGtvzVDhPlVglyycwt3+/DygjIOQSt
 FnStYf0lWZ/8QDsXlGDZEVT/RgWY7cbGlRM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3abbsqrjuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Aug 2021 15:53:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 15:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ1vL6FRUK5SIyfk54wPaHZUuSM4yxNhE5r8s7Rc1UmiMIWGpoRbahsRb9WGo4vbau5/0OTcuJYJ3GZAeyjCbxSqkD1v/73zU2rwB2hQmmTOdDo65zlcUCwMuGBZMJ6NgRxwjVuNjOGBEbJAcsMWfBBReXGC8AsAkgt67t2CcQxzlLug17/9LmpOjbFW9erVakZceki/Z8ADderVRjVAiH8I+Gchn5RR3wxM5O/pfh5H4rzBXFYQWAr4YS2S6Va5PWVheJoMTpC880UQHTOhuRmYe/5DN80yRIVDRGSvofa8L1XGv/mKuLfX8zTr0f1z1bFjxtWL2i7BK3m5rL/wEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHdf0637JC3H0qDLJWbrHPdXz056IcNI9ivoOVdS9Tw=;
 b=gy76dguqjsNjfCKA4BFrd/XMMnXxJ7MJTbcId1kHKH3BqaXhVpEMNABy6vdrPzq4vm7JHAP/674/6BkI0aJDNOm467Smdsk/94Hic2yRazyRQXLL1kPd5nBCWA9ayHFokPzu1ALkXggVo/xYZPLoG+WzRJTGf5BO5Zk6H3n80RiYBohuGf52C+sE8kPmuyzU54VNcDwI6DfS+3wrOqzyXk4nuh5xoSgGgUZ+8irDPgfJcm7ysleZ7F1IV5VAogJHb8MNK4rLH1lTGd1+muJveQ3Z05vEpalMNxhiWvXY+EN9f0VNgOdKQLotB+ShXo6JyoKLz0bVUI9Ipeae9rbWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: lambda.lt; dkim=none (message not signed)
 header.d=none;lambda.lt; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4096.namprd15.prod.outlook.com (2603:10b6:805:53::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 22:53:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 22:53:27 +0000
Subject: Re: R11 is invalid with LLVM 12 and later
To:     Paul Chaignon <paul@cilium.io>, <bpf@vger.kernel.org>
CC:     Martynas Pumputis <m@lambda.lt>
References: <20210809151202.GB1012999@Mem>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a40405b0-3856-9d15-f973-ffae2e853384@fb.com>
Date:   Mon, 9 Aug 2021 15:53:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210809151202.GB1012999@Mem>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR06CA0075.namprd06.prod.outlook.com
 (2603:10b6:104:3::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1ad4] (2620:10d:c090:400::5:61de) by CO2PR06CA0075.namprd06.prod.outlook.com (2603:10b6:104:3::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 22:53:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2e8bc4d-89ec-4333-15f7-08d95b887ff4
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4096:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB4096A6BEBF7F46B4A8C8D6B0D3F69@SN6PR1501MB4096.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTAWr6ipAT03b3bItiTRfuL/Df2+I5LUYYMZTTAv0OBMEmOP0zpRI4cjEmKWKKVucfyVxRLt5BcDk4CVNzKvamu9H6Dp/2DRFMNxhv80DafjEMNN5Js+K39uZRP4lbh644s2VEnLDNP1r7wIoZsec5KbjML0IQnv0y7GG+7j8uTBokzVRLzKnVZsQSd/hDFI6uE2i18nrJ6TTxv9x3ozPa351osM2zuxH69mkd54hWRHkUn8HSquP67e1BfI5fu1PmlajU196WslGcgXe+QwjjcKl/uLYRASkJTMpyGkKwRYmoU5raV9kAULxMxSN+8ywOQejZauKTOTUWGglrGlfGWkOn4JUhuNFFteYG+44PqMPdnvO/UM8JVE1/TkGmyc9TkBzBuW+Ft1Ew/a77EGsWvP4DsL13R9PAnejE3i2beq2XThWaLi1xwNUUNodjUv+qDbU0hSmzQcTPmWJFz+A0FH6W2/x2oHSd+6mE8AXhWw4jR/1BgtgNrRsS7gSa5hFzSKXRyQjGTfy6W+VsL3lX+a83+oCqJESXs/hou/splBTwgosORJ2lGXhyaPDovqWrdQJ7uHHUoGNK7xPxPfKl26KtLR1QRlebvFjMIgz07Lt5O48TI+ZhYXyh7gu4jTBfzbRaD9R3NMFfGdmS2z+SwKtxPlHfTwhG1orwq/SnQezZmwuLfqOFJD2ZTID+h2/9J9CM65441LT9x+En0owioWmQIqt46DsfrjFGMefOY2rxlQ0psGS9MGeRUabLao
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(86362001)(2616005)(53546011)(5660300002)(66946007)(36756003)(316002)(6486002)(508600001)(8936002)(66556008)(2906002)(66476007)(31686004)(38100700002)(83380400001)(8676002)(4326008)(186003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWxIYmVHc21IeE4xY2hOMDBqR0ZNSTZ4Ri9lczFTSjFPc2JFZmlpaGZiY2xt?=
 =?utf-8?B?UFp6UURMUEVoWkhQUlNWT2JSUTEvTlRUWTNydlpvSTlCamlmejRzdDVwV1Q3?=
 =?utf-8?B?VkpxaEVxSWZ6azgyTFM0cVR5R3o1cCtqQUZPcEwzelphbStRVnUyaDcvcEpB?=
 =?utf-8?B?L0dQSXVaWTNHRmpLU09PNlJXSjNPTWVDeUIrcWVxanp6ZWFOYjVZOGhMbmMv?=
 =?utf-8?B?bnp0K0ZNQ0NLN0MwbkdMdDNqa2pHQ21NeTZ0Sm9scHp6V1B3bHhIbTh1aTFC?=
 =?utf-8?B?QUFFbFdnWVhaaWFZNVhpS1pYaVc0a2JZSmhyZjg0L2tWYUhxTjFkeldDdXFz?=
 =?utf-8?B?blBINlhFNGhmWDJHNjJycmYxbVc4ckROWWNIczNLRXNsWW1weFRTRTllYzAx?=
 =?utf-8?B?NjMzRDJieWRJdU1Tb2ZsZzdvQU93QzR5d2JsZHdFc1RpNmE5c1luUzE5ajlh?=
 =?utf-8?B?ek05akgvVHBrZzc2V0ZPRVFZQ1htWGdXWEZSL2xweHlLSmJjMTVLVUJzemRi?=
 =?utf-8?B?cnE0YzNTaVBPY2daQlh5UDZJZlg3VU9EcDZ4ZW56bGJ4Smk3emMwRVRsMHBQ?=
 =?utf-8?B?aS82T0k4TE9jWDZEZWN4aVE5TmVyalhSU1kvTWlaanVqUmVqWTZndm5KZ2Zm?=
 =?utf-8?B?NUpLVmVuczQrOUMvK0IyQXN3YWMrYjNYMXA3UWhyM0JZVXcrSm9lY3FJTHp5?=
 =?utf-8?B?SHNpc2xEOGhPb0NMYWRQYVMxSjEvOTI2RGVBRnVnZlR2RjhVTWpibXRiaWtt?=
 =?utf-8?B?dWxYL2FybFdLUXNKVCs2Uk1PbWJYL25QcGwwdG5EMEgrYVdkTFhnUGZ0RVNt?=
 =?utf-8?B?TmluWUdxTmZ3aFlIL3lOR2ZhbHVUSXU4YWtCbzRpRmRBaHloWDFWeFpxcmVv?=
 =?utf-8?B?VTErL1AwTFBGSVI5V1VPNjg3SDBWbCtNcEo0andWNXYzcWlXWE8rejU0TnZu?=
 =?utf-8?B?SlZ5ejRxVlV4UHpGNzE0Y21yTWdBdFYzNlErdWZ1OTExcGlLOXR1T3l5Wmdp?=
 =?utf-8?B?OUlpT2REaCtuUTRjbkVqMXBsQ3JxaXF3U3hqRDgxQnRWeEtMNTBxcnVTT1FP?=
 =?utf-8?B?ZXAxVGNlVWVubjg0QUJIdElock0ramlsYi9UWjI1ZkFLQVpTWDJQZE5nSll0?=
 =?utf-8?B?OEYwTGVSaHB1VkRiUkliUXF3S1NGWWRVMGNzZjNEZHVEUi83L3FoRHRVNkUy?=
 =?utf-8?B?VFRoa2drVjdPTGR1WFg5Rko4c244eXloVWFqUU13bDdHcTNySHo3MWxZTkRH?=
 =?utf-8?B?ZVZUUkVXRkVTZjBqNWNTRXlJSmZzOTVLRDdieThYb0ZieSt5aDVlOCtHUzd5?=
 =?utf-8?B?aGVETUtQVUVGOUxWRjN5aEJVTVJBenVMd2pyMEkxZFZmKzhDa0N2TGFBSWE0?=
 =?utf-8?B?ZmMxSTJxSHRNU0had0tPb25qbXJYUExvLzlzYTZPVER5SDN0bE9DbVhXdjlU?=
 =?utf-8?B?K2RNOVk2eTZtbzNtU2NsUDlqRkE4NFBjY0xSNjZnbnh1aUhzZEVXVThDZ2dj?=
 =?utf-8?B?TlBxcXRVdG5rdC8wU2Z5aTBYV3Q0bmM0ZHlabEdTVktOWVE2WW1YYmhrelVS?=
 =?utf-8?B?TVduVDVPb2xheTQyZ2pWK1UyVWp6TmNCcTIzaklpY2Z4Zm11WWRROHpxTDdj?=
 =?utf-8?B?aVhvVjBhWDBxQnEzVlp6Z21IVllSVm52N0pZcUJPMHdxR2JBeTdzbU9Jbmtj?=
 =?utf-8?B?SkdxZWtzeVhreksxS1A0UVBmd3A2cy94bDRnRmVJVUFFbEpkUjlGM2d2dFBB?=
 =?utf-8?B?a09waFN4VWJnSnpHVmpIZzJvNThMTkp3T3FYb2EzWUdwbG9kVzkwQ2FpbkQr?=
 =?utf-8?Q?whkx6e445Rr36eQVMAVGsCvtr+lR6SiynEAVM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e8bc4d-89ec-4333-15f7-08d95b887ff4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 22:53:27.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IFE91Xg3Wx9IXxvFtmWaDcig5gK7BsLihGMACQGfNkP6X0YmkJrfTPt8bqjpROQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4096
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: TudDwRYvJaqTNGjE2FbDzDGIQ1fRr56B
X-Proofpoint-ORIG-GUID: TudDwRYvJaqTNGjE2FbDzDGIQ1fRr56B
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=869 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090161
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/9/21 8:12 AM, Paul Chaignon wrote:
> Hello,
> 
> While trying to use LLVM 12.0.0 in Cilium, we've noticed that it can
> generate invalid BPF bytecode:
> 
>      $ clang --version
>      Ubuntu clang version 12.0.0-++20210409092622+fa0971b87fb2-1~exp1~20210409193326.73
>      Target: x86_64-pc-linux-gnu
>      Thread model: posix
>      InstalledDir: /usr/bin
>      $ make -C bpf -j6 KERNEL=419
>      $ llvm-objdump -D -section=2/20 bpf/bpf_lxc.o | grep -i r11
>           171:   7b ba 18 ff 00 00 00 00 *(u64 *)(r10 - 232) = r11
>           436:   79 ab 18 ff 00 00 00 00 r11 = *(u64 *)(r10 - 232)
>           484:   bf 8b 00 00 00 00 00 00 r11 = r8
> 
> That bytecode is of course rejected by the verifier:
> 
>      171: (7b) *(u64 *)(r10 -232) = r11
>      R11 is invalid

Thanks for reporting. I can reproduce the problem and will take a look soon.

> 
> LLVM 12.0.1 and latest LLVM sources (e.g., commit 2b4a1d4b from today)
> have the same issue. We've bisected it to LLVM commit 552c6c23
> ("PR44406: Follow behavior of array bound constant folding in more
> recent versions of GCC."), but that could just be the commit where
> the regression was exposed in Cilium's case.
> 
> --
> Paul
> 
