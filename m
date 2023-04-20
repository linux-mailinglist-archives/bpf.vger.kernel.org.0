Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29546E9C3B
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 21:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjDTTIo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 15:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDTTIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 15:08:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5F1736;
        Thu, 20 Apr 2023 12:08:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KDtbgF019587;
        Thu, 20 Apr 2023 19:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EYgW13YdjHlPuNJXx3fdchTXLfPCkpqa0xSXqLYU5zo=;
 b=T68LFrcD4DYS/L48DLe8POroENXHoaI7YRfszXHMDQlQ4F80gxzX4Do/gCK5FGM3xW8J
 xPSKW0vUQgJgW/KjvwVyKVLJk9DG4qRw+rHWTa4ABml0nQi9RAouuLfUVAIMmi8A1Wlm
 8Jau2oEc4XA2zZZ2YQl0wmt5pdbe6OTdtuKlC9GJKJZQ2tyOyw05vwlXJNnAaIGC30Eo
 VanuN3ATS5FtGBpGFC/qi9lzdJIin0hGDQeEyD+T921BBpdhyb2PWTGWTFv6OXG++NfF
 SPYkWT3RR6HMHuceLsUnRBic7oM2+HyjITs0FD678aL0q7UHl5694MfrWjHolg91Mh/e ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pymfukpmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 19:08:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33KI25SR026289;
        Thu, 20 Apr 2023 19:08:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjceytqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 19:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPN2T+GpQ7QW41Mo87A3jkY3wOD1EzXusFF9hG/xFcYAPWc5E2BkaCTkDfaY3tUqAbcUpr0Z8Umliw+35W29yyQxULKcr2N3B/4Uims1m9B2hZw6y6yqiyRTR7/TSpR+//uIsETod3ZAELtwoOlCX4V880PJISGJ5KRB2tQqZtUwIMvKCsbNm/THiriBlsyZKE4gEo8fBig1657ufj4ScIX8PSTpihP0BiC+V3B95aw+YcIgwr64I+XtmPeCKmt5xLYIlr+2SNlkNqqCQnG+Oy43n5QxVPEh/ikwhjt51kndqJ6mdvHt0OUaYSdG9PuaBncpFV6O/TfvwJRsWMXXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYgW13YdjHlPuNJXx3fdchTXLfPCkpqa0xSXqLYU5zo=;
 b=WqicqXtzZ4WcBmCKq7VTdt617mVqtUpxuevfL5237pIYTjCNPGnSdc+uqr+B4rI0ogF/k1GXgkWEkf+qcqIlkizIyC0sHp/1a57VYirxxZ4Zpelp4vlPHM0Noh5ERzpQdy0io1bW12mHIwKEjp4uNCw1sGFm8lwUDXtyS5L5EEx7TNf3T6049TdK7F8Nr4EDboEDI48AChCeMDmF3kqJz6hKP+6Siixk2Fh5Wmlfhv0PGsr6p3GYetLReGA3WsblZabGltlHo/x+7/mmEsNPEHZEnlhh50tadOLDptJcG9NWDv8v24chP2npbK5ncsNKHNvTvF0JXrHKc0UfqE8t7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYgW13YdjHlPuNJXx3fdchTXLfPCkpqa0xSXqLYU5zo=;
 b=f5VJzi2Rvtn8vEwHf/3A4kNTreUbLRK1SKZ59UA87KXmtZ5tBZPQ9o6dw26wGgDbUpJdeHadXuppNgfXeVPzOmPNPmWPB+076/yW/uGgMnCjTBJI+8oLo7KLgKL3ckWrcUqH4TB0O6s8wTnN/K8qq7+NWZX3QK0azX9ESlDKujc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 19:08:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%5]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 19:08:06 +0000
Subject: Re: [PATCH v5 6/9] tracing/probes: Support function parameters if BTF
 is available
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
References: <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
 <168198999024.1795549.1201846807114771292.stgit@mhiramat.roam.corp.google.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <377888e5-c534-617d-f114-f884759cdd35@oracle.com>
Date:   Thu, 20 Apr 2023 20:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <168198999024.1795549.1201846807114771292.stgit@mhiramat.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0253.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6242c4-62de-4eb9-e7a9-08db41d2925a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIBt+Gqef9WEYwjQAoth6EeYWG2CfjHcrg3SNhOxrmoUh/wCCoKW2tlvp5iknhiRLR48ng2B7tq7FEk8FeuHQU6OJPq6yd/dhBxFLjjJvDn9IDdULXtZEUXaFUfaJIxgqY6nPZZmeqNsKtKRmzWIuE2R3Whfm3PWAyxvr1nGYztpxXwFYwn6YUryC0EzQWkoUp11Y0pRTdTtsqOGfg2G/fcV7xaPi6FiuWfKqoqF6AEosuWgze/WE9Nvw6yKPbEVB8aH36G69bTlLG3lPvgDznmpaOc6k8yXSDpkGlZoifZvLHdujRh/uHJv5XAsSJkGr/xhOHdRalg6C0fVHG2RPXdKUx11pVcT3iC9xyeUUVyrs3+BU/VuSE9vyk6wdPpOipL3BCZNmDbfLms261NCvhmLPqHbmJerFc3SOEgiwcPVsBqxX2nr1m1p6H6DdQpnJMK2HPLmelrldpct1XD/1qMMBM8YRDA5jYhCOk3OhDsEhVVEICXtWA49JL48oVuIy6CRt7XnjO2mzKzZsKVLOa3U3dAj7u25Fy1ypby7mCqPaUH85mQEbbQIq1UfPlAbfjUumZVQ5f4yAtzFaxZMTrU6RQJXlq2zaw0r3gZ4A4NhGJApjR0asOtxB9bmXnQEciSrvv4c/qCE3tX/y8otNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(31686004)(66946007)(66476007)(66556008)(30864003)(2906002)(44832011)(2616005)(86362001)(5660300002)(4326008)(7416002)(8676002)(8936002)(316002)(41300700001)(36756003)(54906003)(478600001)(6666004)(6486002)(186003)(53546011)(6512007)(6506007)(83380400001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmV0U1hhRVR4bGJ2SzUrdnJhaTJVejdvODZuenF3SThIb0pzc3VncmVud0Qy?=
 =?utf-8?B?d0ZmVVFrbkFqQ1F3QnZIZjk2R29RaUpXdzVRdEMxakpSK04xYmdobUFhZ3NH?=
 =?utf-8?B?cmRXdk81QlB0U3drbFF3NlNmbTVNYncweXVyai9NM2ljZHBvV2dPYUdEM3RM?=
 =?utf-8?B?enpDS3hIZmZnb2JUMmZRWTV4aUtnTGNjK0ZYam0wT0d5YllKOGFMZnRqTlpF?=
 =?utf-8?B?ZkpqR0haekdCWEN1a0tFbTJMN0lIckxnamdOdmZ5bjlCMXpkSTJDbjVqc0Yr?=
 =?utf-8?B?aHY5Q1FBN1FFbm5EMGQyRkV6WGxUYll3WFplYmF1SXFjQzFoVmdUK0x2V0tZ?=
 =?utf-8?B?dFcweXdNOExETVhmaXhxVlJDSklFYndZcEozaU9zOHBGNisxYmlOUEJZWUtv?=
 =?utf-8?B?WVV0M2RCK1U2NW5UNzkxQktPdmE2OUJ5N0NkM0ExSHR4NWhhYjZzMkhqSmF4?=
 =?utf-8?B?REtxK0FvYUdYSmVwUzMxMnpDeGJiTmw3azh0TG5LYXAwR2dSQkVESXRCVzdK?=
 =?utf-8?B?VktpSjBubTlpSytoYjdoLzVVWnFGTkNCc1l6eTVreVhtNDkwNWxsbVJPZHZk?=
 =?utf-8?B?SVVJMXlNRmpDTlc1UmRQaVNMY3c3VUNxUk5POGRBWnBVOEtXOGRuS2VrUWsv?=
 =?utf-8?B?SkRwZzd3R2ozbVY0TEhhZGZ5S1o2SERwWXhCQkNTLzdERU1NWkRkQWlnZTNt?=
 =?utf-8?B?MDdabzk2eG1EZXZpcjNyenh4MHdlUlRXbTlMMGR3RkFLR3YwTncwVklRNDlN?=
 =?utf-8?B?MUVlSmgrSFZjT0ZaZ2hxYnpMSW9icERrcC9jc3hSM2FDVHpBLzFWclBSWjRj?=
 =?utf-8?B?NUphVkV4NlVUSE11VFFmUTZ3SThxZnNRU0ZIMG1XaEZhSThNTi9zV00zdnBj?=
 =?utf-8?B?Q2dnRE9kMzZoS203WDQwNDkvL2NHaGVXNUx4a0kzd2xZT3JYWTJ4QSt2cllI?=
 =?utf-8?B?RE00cmhISGZJMFpWTlNoQUcyV3BjRUtKemZJTEZBNmZvbWRPekxPOS9FbDNn?=
 =?utf-8?B?aEtXZWJPR2F1eWN1RVNjWnU3MWdFeGx5bkVxWW5JWEt3KzFqVm8rME84K0Jk?=
 =?utf-8?B?ZEJCU0VFZkY4Q3NIOUFRL25kYkVKNU5aUGlQWG5WREdtSnd1SVRNcmRpKzRw?=
 =?utf-8?B?WnVCQ1VXWXZCcm1Qdndxb0lzUUROd2VEdXZsNEtmdVljS2V2alNvR2FaSFlD?=
 =?utf-8?B?cHk1VlM3T3dqWWE4ZFJMZUdtM3FXMmFnTFlXdzZQNWUvNzRoZXRTK0FvbVFY?=
 =?utf-8?B?MTA3UTZpaXovMmRxeU1KTWlGUzZ2Y0tFUlJuTytDTnlxYlRZRzN0WjkxMERO?=
 =?utf-8?B?K0QzYmtRdXJnbE50anpuUVZDeHo3cHpnaDNWK2p1bTRETk9lY1FROFZ4QlhW?=
 =?utf-8?B?ZS9WdEtuQ3JTSTFES1p4Y0NMYzFjWVQzM28wS2toU3o4RmpvYjBMaytxYXhi?=
 =?utf-8?B?VlBWckFxbmZNZEp0bnhmWGJGVlZmM3Y2MDl3RzFOWFlYU2xSeWcya01NK2cv?=
 =?utf-8?B?c3ZtdTBqZXdzazk3NVhDQ3pEajg3UG5RQkltaEQ0ZXYzUW1QT1ozVUVrMVBu?=
 =?utf-8?B?NVJJQVhpRU5DN2ViaUowZHdwcFl1K2pleFJTamtjSDR1bWduMGF2cjhkTy8w?=
 =?utf-8?B?V2RNVTdrUzI3YTVaQzRxZGNSeStrTmNzNmZKcWVBdmhNcEp1RHRWNVgraFQv?=
 =?utf-8?B?ZEhJaDMrVUxXT1JTaGNGMUU3R3V2eGFIb29pSGNkR3pubkVISHJwNGxkTGMv?=
 =?utf-8?B?dWJaYnFuSEluNmY2OFM4WHhPNVVmN2RJSHJKNnJ1NFl0WGx0SVZwbGJGdnVk?=
 =?utf-8?B?LzdGekEreTh3Q1Nza1lkYWo3S2ZZbnhzYlpEUGtRU093a0xHL2lCVlAxaTlU?=
 =?utf-8?B?bnQ5WWFtTzhqNFU5Rm5uaHpxQi9MMHM2d1FmM2xKZDBWSU9XM0pkazBremFj?=
 =?utf-8?B?RnRFalFUQU91L1dZejk3cW5VR0lWR292U3FCd3VQZGtMS1VmR1ZOMnBYK2FL?=
 =?utf-8?B?VW16V2RiRWd2blFnY3kzQmJ2aWxZWklkQ2l6WThvaFpmWUs3T2kreWdnSUow?=
 =?utf-8?B?Q2RDNUNDME1KVlJvSjdBRkJ2WXNxZ0I3SlNzWEc2Nmo2NFhoY0xnYVNnZEZI?=
 =?utf-8?B?ZlB0NkF2YTFIc2w4ME41Ry91Z3ByZS9PRWFBaVJ0MW9mTElZTnNqSG9qRjlQ?=
 =?utf-8?Q?TmXIZs2Lzpo1HcvxQfo86lA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cDFqM1JRV0RYSk5wNkM5Q2dxcGRRYTBjUC9SY2s5QzhYQlE5ZTJQazdMOWts?=
 =?utf-8?B?SWhFQyt3RVBLdmNWYW9Hays0RnpQei9ibm1ibGEyUWZNSGl1ZHFpeTNreU0z?=
 =?utf-8?B?RjBqeXVGUld6UjdFdVVSV0FsQ0lHQTJ1SkhXREU0VG9keWpzTC9MaEh2UzRv?=
 =?utf-8?B?TytpOThNcHE0MGtvbGpNU2ttejRNeUJHYW1DVDUrblhVcm4vUUFLNGdHS0dh?=
 =?utf-8?B?dUYxVWZPTzYxN1dnVHdxbE5rOGZkMXNOMHcwQ0NJdjUwZTY3c0xRRVRGZXJk?=
 =?utf-8?B?TXJCcmJVSnpoQnVJK3VESkR5anp3RkVaay9raGtjQzltN0pTNm5SNzJKVDFV?=
 =?utf-8?B?MWFSTjJtQ1Zpdm53SDA1anp0K0tNcUNVbSsxdS81dWRPRjdDY2RGakdpTE9V?=
 =?utf-8?B?RHFlMVZTbTFjZFRKWWR6WHA3dW96Yk1jNDdQTkhCZzB2SkFUYXNxM3pLR05o?=
 =?utf-8?B?d291YmFwRnV0OGpPdTR4dzM1Z0hZb21HTzBEOGwyOXdaWldOMzdKR3ZqMGdT?=
 =?utf-8?B?cnJocHpGYmVTOEpjZlZVdnBHMjNGcFA3dmhCMEY4aHVYN1lJVklCamNCZHNF?=
 =?utf-8?B?QjJVTjBYdjQ0aHVFTW1OSWFuSGdxdElZRStoejY5NlcwTGdSMFhKaXNneWYv?=
 =?utf-8?B?UUtPMWVlaGthdGhtYTAwUUJwdURnakw3emI2WTVRWGx0RERxMVJLMURSdjRD?=
 =?utf-8?B?L0M1aXMvYTNHM24ycm1xc3VpOE5NaGJaSDZvZndneStiTTFmZUxjMUpSNjFR?=
 =?utf-8?B?K2lyY1NncWMzbEg0RjJ4THBTRlhiS01RWmF1UldqZWJVaHlPMmRDVEk0K29a?=
 =?utf-8?B?NzNTTldoUTV4L0t2UXJpMEcwV3JXdWQxbVhyNGJZbFdmejRCc2gzcllCQ1JY?=
 =?utf-8?B?MkF3YXF1MjlYWWczZHpwekhmVHdMODEwSFhiWWU5Q2s1VWxIZTBTY0w4QWNk?=
 =?utf-8?B?YTg3dEhCU29JOG1Bam82U2JYZ0RNMG1yd1VLUWtJYUptVk5vM1MzdGt5Wlo0?=
 =?utf-8?B?ekYxOS9zczV3MVc1N3N6SkdqVWFNMSsyOUhZZkZrYWVUNG1OTnFLTk5zMUJk?=
 =?utf-8?B?aWQwYTJoUVZialFGcWFmdVY2V3FIOXdFRkJNNG9YZG5OT3JIQ20vL2JyT0xI?=
 =?utf-8?B?bE1JanZDUi9mSVVzc1ZRd2QwOFRpSCtOUnAwdDMyY3NzT0N0ZUVEL2lNdW15?=
 =?utf-8?B?QXExY1pnTzVmOGlhd1FGdEljSnNvRklGdUsvQTUrZzdBQWdPREpuWnBJK242?=
 =?utf-8?Q?VPHjFrHTH/7XuIX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6242c4-62de-4eb9-e7a9-08db41d2925a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 19:08:06.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGBL0m3xSNiYVopV5hQ89D9ENJCq7QUuyCsett5dNP3c2VUHCLd+eMloEu77YyU80g2a51DFdclMGrq/viGJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_15,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304200160
X-Proofpoint-GUID: lL0LBKEd13C9GcTIir18Cgp7K42nbNIk
X-Proofpoint-ORIG-GUID: lL0LBKEd13C9GcTIir18Cgp7K42nbNIk
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 20/04/2023 12:26, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Support function or tracepoint parameters by name if BTF is available
> and the event is for function entry (This means it is available for
> kprobe-events, fprobe-events and tracepoint probe events.)
> 
> BTF variable syntax is a bit special because it doesn't need any prefix.
> Also, if only the BTF variable name is given, the argument name is
> also becomes the BTF variable name. e.g.
> 
>  # echo 'p vfs_read count pos' >> dynamic_events
>  # echo 'f vfs_write count pos' >> dynamic_events
>  # echo 't sched_overutilized_tp rd overutilized' >> dynamic_events
>  # cat dynamic_events
> p:kprobes/p_vfs_read_0 vfs_read count=count pos=pos
> f:fprobes/vfs_write__entry vfs_write count=count pos=pos
> t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/Kconfig        |   11 ++
>  kernel/trace/trace.c        |    4 +
>  kernel/trace/trace_fprobe.c |   49 ++++++-----
>  kernel/trace/trace_kprobe.c |   12 +--
>  kernel/trace/trace_probe.c  |  192 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h  |    9 ++
>  6 files changed, 248 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 8e10a9453c96..e2b415b9fcd4 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -664,6 +664,17 @@ config FPROBE_EVENTS
>  	  and the kprobe events on function entry and exit will be
>  	  transparently converted to this fprobe events.
>  
> +config PROBE_EVENTS_BTF_ARGS
> +	depends on HAVE_FUNCTION_ARG_ACCESS_API
> +	depends on FPROBE_EVENTS || KPROBE_EVENTS
> +	depends on DEBUG_INFO_BTF && BPF_SYSCALL
> +	bool "Support BTF function arguments for probe events"
> +	default y
> +	help
> +	  The user can specify the arguments of the probe event using the names
> +	  of the arguments of the probed function. This feature only works if
> +	  the probe location is a kernel function entry or a tracepoint.
> +
>  config KPROBE_EVENTS
>  	depends on KPROBES
>  	depends on HAVE_REGS_AND_STACK_ACCESS_API
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 9da9c979faa3..0d9c48197a5c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5670,7 +5670,11 @@ static const char readme_msg[] =
>  	"\t     args: <name>=fetcharg[:type]\n"
>  	"\t fetcharg: (%<register>|$<efield>), @<address>, @<symbol>[+|-<offset>],\n"
>  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> +	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>, <argname>\n"
> +#else
>  	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
> +#endif
>  #else
>  	"\t           $stack<index>, $stack, $retval, $comm,\n"
>  #endif
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index cd91bf57baac..d88079c2d2e3 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -387,6 +387,7 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
>  static struct trace_fprobe *alloc_trace_fprobe(const char *group,
>  					       const char *event,
>  					       const char *symbol,
> +					       struct tracepoint *tpoint,
>  					       int maxactive,
>  					       int nargs, bool is_return)
>  {
> @@ -406,6 +407,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
>  	else
>  		tf->fp.entry_handler = fentry_dispatcher;
>  
> +	tf->tpoint = tpoint;
>  	tf->fp.nr_maxactive = maxactive;
>  
>  	ret = trace_probe_init(&tf->tp, event, group, false);
> @@ -949,8 +951,12 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  	int maxactive = 0;
>  	char buf[MAX_EVENT_NAME_LEN];
>  	char gbuf[MAX_EVENT_NAME_LEN];
> -	unsigned int flags = TPARG_FL_KERNEL;
> +	char sbuf[KSYM_NAME_LEN];
>  	bool is_tracepoint = false;
> +	struct tracepoint *tpoint = NULL;
> +	struct traceprobe_parse_context ctx = {
> +		.flags = TPARG_FL_KERNEL | TPARG_FL_FENTRY,
> +	};
>  
>  	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
>  		return -ECANCELED;
> @@ -1014,12 +1020,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  		goto parse_error;
>  	}
>  
> -	flags |= TPARG_FL_FENTRY;
> -	if (is_return)
> -		flags |= TPARG_FL_RETURN;
> -	if (is_tracepoint)
> -		flags |= TPARG_FL_TPOINT;
> -
>  	trace_probe_log_set_index(0);
>  	if (event) {
>  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> @@ -1031,7 +1031,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  	if (!event) {
>  		/* Make a new event name */
>  		if (is_tracepoint)
> -			strscpy(buf, symbol, MAX_EVENT_NAME_LEN);
> +			snprintf(buf, MAX_EVENT_NAME_LEN, "%s%s",
> +				 isdigit(*symbol) ? "_" : "", symbol);
>  		else
>  			snprintf(buf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
>  				 is_return ? "exit" : "entry");
> @@ -1039,8 +1040,25 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  		event = buf;
>  	}
>  
> +	if (is_return)
> +		ctx.flags |= TPARG_FL_RETURN;
> +
> +	if (is_tracepoint) {
> +		ctx.flags |= TPARG_FL_TPOINT;
> +		tpoint = find_tracepoint(symbol);
> +		if (!tpoint) {
> +			trace_probe_log_set_index(1);
> +			trace_probe_log_err(0, NO_TRACEPOINT);
> +			goto parse_error;
> +		}
> +		ctx.funcname = kallsyms_lookup(
> +				(unsigned long)tpoint->probestub,
> +				NULL, NULL, NULL, sbuf);
> +	} else
> +		ctx.funcname = symbol;
> +
>  	/* setup a probe */
> -	tf = alloc_trace_fprobe(group, event, symbol, maxactive,
> +	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
>  				argc - 2, is_return);
>  	if (IS_ERR(tf)) {
>  		ret = PTR_ERR(tf);
> @@ -1049,24 +1067,15 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  		goto out;	/* We know tf is not allocated */
>  	}
>  
> -	if (is_tracepoint) {
> -		tf->tpoint = find_tracepoint(tf->symbol);
> -		if (!tf->tpoint) {
> -			trace_probe_log_set_index(1);
> -			trace_probe_log_err(0, NO_TRACEPOINT);
> -			goto parse_error;
> -		}
> +	if (is_tracepoint)
>  		tf->mod = __module_text_address(
>  				(unsigned long)tf->tpoint->probestub);
> -	}
>  
>  	argc -= 2; argv += 2;
> -
>  	/* parse arguments */
>  	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> -		struct traceprobe_parse_context ctx = { .flags = flags };
> -
>  		trace_probe_log_set_index(i + 2);
> +		ctx.offset = 0;
>  		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], &ctx);
>  		if (ret)
>  			goto error;	/* This can be -ENOMEM */
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index fd62de2a2f51..aff6c1a5e161 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -742,7 +742,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  	void *addr = NULL;
>  	char buf[MAX_EVENT_NAME_LEN];
>  	char gbuf[MAX_EVENT_NAME_LEN];
> -	unsigned int flags = TPARG_FL_KERNEL;
> +	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
>  
>  	switch (argv[0][0]) {
>  	case 'r':
> @@ -823,10 +823,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  			goto parse_error;
>  		}
>  		if (is_return)
> -			flags |= TPARG_FL_RETURN;
> +			ctx.flags |= TPARG_FL_RETURN;
>  		ret = kprobe_on_func_entry(NULL, symbol, offset);
>  		if (ret == 0)
> -			flags |= TPARG_FL_FENTRY;
> +			ctx.flags |= TPARG_FL_FENTRY;
>  		/* Defer the ENOENT case until register kprobe */
>  		if (ret == -EINVAL && is_return) {
>  			trace_probe_log_err(0, BAD_RETPROBE);
> @@ -856,7 +856,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  
>  	/* setup a probe */
>  	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
> -			       argc - 2, is_return);
> +				argc - 2, is_return);
>  	if (IS_ERR(tk)) {
>  		ret = PTR_ERR(tk);
>  		/* This must return -ENOMEM, else there is a bug */
> @@ -866,10 +866,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  	argc -= 2; argv += 2;
>  
>  	/* parse arguments */
> +	ctx.funcname = symbol;
>  	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> -		struct traceprobe_parse_context ctx = { .flags = flags };
> -
>  		trace_probe_log_set_index(i + 2);
> +		ctx.offset = 0;
>  		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
>  		if (ret)
>  			goto error;	/* This can be -ENOMEM */
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 84a9f0446390..f55d633b3e2a 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -300,6 +300,174 @@ static int parse_trace_event_arg(char *arg, struct fetch_insn *code,
>  	return -ENOENT;
>  }
>  
> +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> +
> +static DEFINE_MUTEX(tp_btf_mutex);
> +static struct btf *traceprobe_btf;
> +
> +static struct btf *traceprobe_get_btf(void)
> +{
> +	if (!traceprobe_btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> +		mutex_lock(&tp_btf_mutex);
> +		if (!traceprobe_btf)
> +			traceprobe_btf = btf_parse_vmlinux();

Apologies if I missed this in previous discussion, but should we
use bpf_get_btf_vmlinux() here instead, since it will
return an already-parsed BTF? There's a bunch of additional
work that btf_parse_vmlinux() does that's not needed from
a tracing POV.

> +		mutex_unlock(&tp_btf_mutex);
> +	}
> +
> +	return traceprobe_btf;
> +}
> +
> +static u32 btf_type_int(const struct btf_type *t)
> +{
> +	return *(u32 *)(t + 1);
> +}
> +
> +static const char *type_from_btf_id(struct btf *btf, s32 id)
> +{
> +	const struct btf_type *t;
> +	u32 intdata;
> +	s32 tid;
> +
> +	/* TODO: const char * could be converted as a string */
> +	t = btf_type_skip_modifiers(btf, id, &tid);
> +
> +	switch (BTF_INFO_KIND(t->info)) {
> +	case BTF_KIND_ENUM:
> +		/* enum is "int", so convert to "s32" */
> +		return "s32";
> +	case BTF_KIND_PTR:
> +		/* pointer will be converted to "x??" */
> +		if (IS_ENABLED(CONFIG_64BIT))
> +			return "x64";
> +		else
> +			return "x32";
> +	case BTF_KIND_INT:
> +		intdata = btf_type_int(t);
> +		if (BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED) {
> +			switch (BTF_INT_BITS(intdata)) {
> +			case 8:
> +				return "s8";
> +			case 16:
> +				return "s16";
> +			case 32:
> +				return "s32";
> +			case 64:
> +				return "s64";
> +			}
> +		} else {	/* unsigned */
> +			switch (BTF_INT_BITS(intdata)) {
> +			case 8:
> +				return "u8";
> +			case 16:
> +				return "u16";
> +			case 32:
> +				return "u32";
> +			case 64:
> +				return "u64";
> +			}
> +		}
> +	}
> +	/* TODO: support other types */
> +
> +	return NULL;
> +}
> +

I wonder if we could haul out some common code for printing the type
from btf_show_name()? Part of what it does is stringify a type name;
if we had that, it might help solve the TODO above I think..

Alan

> +static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr)
> +{
> +	struct btf *btf = traceprobe_get_btf();
> +	const struct btf_type *t;
> +	s32 id;
> +
> +	if (!btf || !funcname || !nr)
> +		return ERR_PTR(-EINVAL);
> +
> +	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
> +	if (id <= 0)
> +		return ERR_PTR(-ENOENT);
> +
> +	/* Get BTF_KIND_FUNC type */
> +	t = btf_type_by_id(btf, id);
> +	if (!btf_type_is_func(t))
> +		return ERR_PTR(-ENOENT);
> +
> +	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> +	t = btf_type_by_id(btf, t->type);
> +	if (!btf_type_is_func_proto(t))
> +		return ERR_PTR(-ENOENT);
> +
> +	*nr = btf_type_vlen(t);
> +
> +	if (*nr)
> +		return (const struct btf_param *)(t + 1);
> +	else
> +		return NULL;
> +}
> +
> +static int parse_btf_arg(const char *varname, struct fetch_insn *code,
> +			 struct traceprobe_parse_context *ctx)
> +{
> +	struct btf *btf = traceprobe_get_btf();
> +	const struct btf_param *params;
> +	int i;
> +
> +	if (!btf) {
> +		trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (WARN_ON_ONCE(!ctx->funcname))
> +		return -EINVAL;
> +
> +	if (!ctx->params) {
> +		params = find_btf_func_param(ctx->funcname, &ctx->nr_params);
> +		if (IS_ERR(params)) {
> +			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
> +			return PTR_ERR(params);
> +		}
> +		ctx->params = params;
> +	} else
> +		params = ctx->params;
> +
> +	for (i = 0; i < ctx->nr_params; i++) {
> +		const char *name = btf_name_by_offset(btf, params[i].name_off);
> +
> +		if (name && !strcmp(name, varname)) {
> +			code->op = FETCH_OP_ARG;
> +			code->param = i;
> +			return 0;
> +		}
> +	}
> +	trace_probe_log_err(ctx->offset, NO_BTFARG);
> +	return -ENOENT;
> +}
> +
> +static const struct fetch_type *parse_btf_arg_type(int arg_idx,
> +					struct traceprobe_parse_context *ctx)
> +{
> +	struct btf *btf = traceprobe_get_btf();
> +	const char *typestr = NULL;
> +
> +	if (btf && ctx->params)
> +		typestr = type_from_btf_id(btf, ctx->params[arg_idx].type);
> +
> +	return find_fetch_type(typestr, ctx->flags);
> +}
> +#else
> +static struct btf *traceprobe_get_btf(void)
> +{
> +	return NULL;
> +}
> +
> +static int parse_btf_arg(const char *varname, struct fetch_insn *code,
> +			 struct traceprobe_parse_context *ctx)
> +{
> +	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
> +	return -EOPNOTSUPP;
> +}
> +#define parse_btf_arg_type(idx, ctx)		\
> +	find_fetch_type(NULL, ctx->flags)
> +#endif
> +
>  #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
>  
>  static int parse_probe_vars(char *arg, const struct fetch_type *t,
> @@ -556,6 +724,15 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  				code->op = FETCH_OP_IMM;
>  		}
>  		break;
> +	default:
> +		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
> +			if (!tparg_is_function_entry(ctx->flags)) {
> +				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
> +				return -EINVAL;
> +			}
> +			ret = parse_btf_arg(arg, code, ctx);
> +			break;
> +		}
>  	}
>  	if (!ret && code->op == FETCH_OP_NOP) {
>  		/* Parsed, but do not find fetch method */
> @@ -704,6 +881,11 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  	if (ret)
>  		goto fail;
>  
> +	/* Update storing type if BTF is available */
> +	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
> +	    !t && code->op == FETCH_OP_ARG)
> +		parg->type = parse_btf_arg_type(code->param, ctx);
> +
>  	ret = -EINVAL;
>  	/* Store operation */
>  	if (parg->type->is_string) {
> @@ -857,8 +1039,14 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
>  		parg->name = kmemdup_nul(arg, body - arg, GFP_KERNEL);
>  		body++;
>  	} else {
> -		/* If argument name is omitted, set "argN" */
> -		parg->name = kasprintf(GFP_KERNEL, "arg%d", i + 1);
> +		/*
> +		 * If argument name is omitted, try arg as a name (BTF variable)
> +		 * or "argN".
> +		 */
> +		if (is_good_name(arg))
> +			parg->name = kstrdup(arg, GFP_KERNEL);
> +		else
> +			parg->name = kasprintf(GFP_KERNEL, "arg%d", i + 1);
>  		body = arg;
>  	}
>  	if (!parg->name)
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 2dc1e5c4c9e8..9ea5c7e8753f 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -23,6 +23,7 @@
>  #include <linux/limits.h>
>  #include <linux/uaccess.h>
>  #include <linux/bitops.h>
> +#include <linux/btf.h>
>  #include <asm/bitsperlong.h>
>  
>  #include "trace.h"
> @@ -376,6 +377,9 @@ static inline bool tparg_is_function_entry(unsigned int flags)
>  
>  struct traceprobe_parse_context {
>  	struct trace_event_call *event;
> +	const struct btf_param *params;
> +	s32 nr_params;
> +	const char *funcname;
>  	unsigned int flags;
>  	int offset;
>  };
> @@ -474,7 +478,10 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(NO_EVENT_INFO,	"This requires both group and event name to attach"),\
>  	C(BAD_ATTACH_EVENT,	"Attached event does not exist"),\
>  	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),\
> -	C(NO_EP_FILTER,		"No filter rule after 'if'"),
> +	C(NO_EP_FILTER,		"No filter rule after 'if'"),		\
> +	C(NOSUP_BTFARG,		"BTF is not available or not supported"),	\
> +	C(NO_BTFARG,		"This variable is not found at this probe point"),\
> +	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),
>  
>  #undef C
>  #define C(a, b)		TP_ERR_##a
> 
