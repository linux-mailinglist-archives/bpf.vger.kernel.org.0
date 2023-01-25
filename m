Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0723767C02F
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 23:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjAYWxV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 17:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjAYWxU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 17:53:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FA37686
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 14:53:15 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PM3kKg014910;
        Wed, 25 Jan 2023 22:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LuQ8IJiI8wxfttOj1BZtgLRFP7vihXZO+Q7HbZAKdQY=;
 b=r5Z0zjRawTGSEn94fyT3U6NENY9sxa1w86JODS/KddJJPVpfFkB5alg89GmZ+ekOQM2l
 u0vTmSv5yzfQ119/4qIkMCYNleTGkzgZUyo9zOAdzs9qhlXSJF7aIoa+kxWzEf1IHrVN
 iTCkQJIZrzhSNW3dBty7CstlDlONnAlCpMGhKZuC23HUfcajYiEdc1gx/2Atp7SHCEg1
 rLjsW7ceon1uFBZOc34VPKYKH9fJR6AgqKXkCWIc8sV5UxqqA2vHZ0dnhhwJWpDsP4jp
 9Ld7+6qAfD3bbqY2qHQpFjCNufEUyXzSSZbaNY9OgYLOaxfsex9aGRQXofZOoqahNwAS Cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86u31abv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 22:52:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PLACKS009567;
        Wed, 25 Jan 2023 22:52:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g7jqqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 22:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkucAe6sm59nfS4/y0N4UWQ+gN4FJMHtgrSF/MtGVSLHIhEIvHNLUi9H17BIGb7vGRb5QZf1ctxyJiSb/BBeWrIjbabObKZPIj24vGFkCVzP8JWbp7/tko3p5L75pttGDhAkxxjwcPzqiNsvVg3/vZ7WJTiiWDYa/6dHpZJ1UUg4LDm4AFCsJz9yxSvPcgAqKFUiRoBBnLJygFDHf7yEMfFZoZ9A6WCRsTsl6oDYdmCKXc0wrlV99p1GpWpEbukBsRCwnS4zMkCRHnqDrWAyP0VHZYNmRAWRrYMfscCBvlvSkhZeA+ZGch0HlGKLfdf31mGQEzwPnqQL1YLZjjQk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuQ8IJiI8wxfttOj1BZtgLRFP7vihXZO+Q7HbZAKdQY=;
 b=bKly9GkiiNqOMJHtZiDatpdhDDLvznceiK/DjYW9stf+q9xD1/t+BIewG5H4pAOGyoLSrScgWqh5kj+U8qNaR61I4qR6ePjf5tz/0KqIaVYjGf2y31/CMbcrOZG5MOGUd40FzLIUANuyYFx1O8CdEx2cADbfsyunxKdq4hGaUeloYhFR+ZlUFa9YMrM83OZJ340IKePrANZq4InpOlB9rU6POofkY9g/5h0CEi3D7KvQz+kKd73y9DIMMP/UTQarEeEC9ouXWgCsujNV7jqQvcgjexmG2M+K46bh4jhXNNzReyNIaUORuLzJRkil5WapddZ5i5pb1gPH5397cYXo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuQ8IJiI8wxfttOj1BZtgLRFP7vihXZO+Q7HbZAKdQY=;
 b=ILF8ZWKqNiQfSzMkFTVjbzMXeev+LwyBzfdRpNlsU2BvTk1MqmTdOm3I8eT0ChispZRlN8mydT5TumpxxrcPQzQfFnGsw/hpq+CE0DGm8cpiEDM/3jxkxGBw1qIYsmfgxSBADoDm2N3sEwwo30fY6YaWIvowNz7bLhcCdJMWtgU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6848.namprd10.prod.outlook.com (2603:10b6:8:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 22:52:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%5]) with mapi id 15.20.6043.020; Wed, 25 Jan 2023
 22:52:48 +0000
Subject: Re: [PATCH dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org, yhs@fb.com,
        ast@kernel.org, olsajiri@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-2-git-send-email-alan.maguire@oracle.com>
 <eb706138246821aafe0f3e88a98933348ba343ac.camel@gmail.com>
 <3ca14d5e-5466-fb4e-b024-01ba33370372@oracle.com>
 <f23eb6cfe20966d7b417f29ec782f78fa0ab93d5.camel@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <530ea13a-5229-82a8-d976-b0bc141c3448@oracle.com>
Date:   Wed, 25 Jan 2023 22:52:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <f23eb6cfe20966d7b417f29ec782f78fa0ab93d5.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d5da0d-b000-4b1e-f0fa-08daff26e123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btLgIP2e9ysvb1PAGbSdICXowvQ3YGFUHKtcpOamzOCjOApfw/shJ1RqyYofPIc3j3zHdMBGHX8tmDW66XFMQyfck9rERXzS+Gk0iHpOjLHP+DdFsGMH9Q4NvhuvpP9aNEh+R/Zxa43Pgz9q1z4R1k5h6Z9euvgjR9ixqHq1Y5lIz3xVSKzPGv1Y1tR8pAgUPqHV1WkPCdJBc3KkdZFxzf8O2nRk+lq6aopH3LE27N7bcBg905Am/rhINqbwrXcGSxB3tLIJal4k9SqPDOCDfGdjo06S2L9rGhqnN99sVmLQOnfwhKKZpemiCsBNMq14Ga6qxWXX/HxKmG4TAMk15ECBUEDTCW4bZhRx1kTHT4Dyg6Qu88hBHV5vc5rmkxrPn1eQCSc/HUsnMFxCTI2IUdCxC9On8BS8gkygTXKtp8aCG7EEzDnUUqGpUT8u93yJxuHiBSeZM+QF95MqgAjeRhVROzTpiwOGx1FMxw1vtYXri8yzRbVc22cqJWW3ywaf457F42k+hd10eXso1AxLni64CX/ZJR3lmhnAuzAIIJuoIzrWqCAkGmEhu+x6rGbmHm2JINUziSTWpJkOpahIUwtMuVkinNEXTlm3uSkk27u0Ekai0fvX8RmHSfCYl6ScgV6BER/C1+PPx6JQ1ujzMkTGQ/88RoIacPYYfae3bdAeB5qSo1KJ7GE//JLD8C/rvTKgnS4thcvP/veGmqSR4wwmQYABKeBPJfTIwWME7I/5Gi7/grAd5WICa4OO15p6JrjBwe14SaqrymkpxZfRPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199018)(86362001)(31696002)(6666004)(66476007)(316002)(36756003)(66556008)(66946007)(478600001)(6486002)(2906002)(44832011)(83380400001)(7416002)(4326008)(8676002)(6506007)(5660300002)(8936002)(30864003)(38100700002)(2616005)(41300700001)(53546011)(186003)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1lwTkxnRHZxRlg4dzNRWGtPRk9JRXpRQ3lxNXBadkxMRVB4cGFHWlhLWEJO?=
 =?utf-8?B?L2NLTlI3Q3MxL2ZkRGFSNVg5eFY5TDBzVnVLdGowbzdyWWZLNkZHZ2NaZkhU?=
 =?utf-8?B?ZE1rQTdrTnhzZGVRcHdydnVLdVZROGZtL2h2T3h2YXYxNjJJMGEzRGYyb2JV?=
 =?utf-8?B?U0RnQmZweUlGM1IzL1JOZ2lwYWdxYzZPQ1NwOThVNHFOK2hRMFNKUDVPS0I4?=
 =?utf-8?B?Y1NQOFYzTmJXU2kvZEcxRERnRGR0VnRCWGJWU1Z1VXBpRjNhT29CMm1yaDR3?=
 =?utf-8?B?dUNqS3dsaXAzRkpCZTVLVklYRWhJSUU1dWF0VjRhUU5EN0VFS2NzVUJJR05O?=
 =?utf-8?B?SURCbVRDTUtDVTY1emZqbVYxVzRXMTVrdWFrekw2cmg3b3JSQ1B2QXNseEFi?=
 =?utf-8?B?dzZBTWxSbG50NXdjYUxWY3Z1NjNXTXBuNkNVVkw1TU02cEdYbUpnelNaaVN5?=
 =?utf-8?B?Rk1mWE9JV0pPbk16V2hLK3psUW5DMnNjOTlFdjNkMWlKRXBqMmUyWlZxMG1B?=
 =?utf-8?B?Y2RVWGVFTjZPT1hCejUycGRWZ045WVd3bTg2dzh1U3oxSExaNytnUmtJYTdz?=
 =?utf-8?B?dW10V0hoMS9ZTkM3TlBoRDlnVngxeHVQOEx3OGpkRmkwdVpnWnBTTjFRNmxB?=
 =?utf-8?B?bXRyUlRaU2xFZzQyTnd3T05DNGhlLzg2OHl2cURXdVpGTTNoR1QyL0dHOGIy?=
 =?utf-8?B?TUhVY251K3VUQm9aUjVuT1hsNStwKzFrTTlSQVVkUlFkZnI2Sjl3YWpGb0Y5?=
 =?utf-8?B?L1NWSm5KTzVlaGdsMmVUQ0UzMEdNM09IdFhjUHpYOURydXhlRFUvSlBKcjBq?=
 =?utf-8?B?a1hHNmFoQTZGSDlKbm1IMHI5a2NCQkVJTHR6RHlnNGxGbDVtSzdwNllPL0lD?=
 =?utf-8?B?Z1gvY2d6SWFtbGg5TStrbUZFWnJtMjVmUnFSdzFSZ0ZkUFRLSHZEMEZWK3g3?=
 =?utf-8?B?dkY3WnRGaWF6aWtmL0cwRFF3Y09NaUpaaXdqcWs2ek9PVWRkdVV2QytxNTdN?=
 =?utf-8?B?Wks5dzRTUVArRExoKy9EbjhDZERIdzBmUitSd3Y5VXZQbGlzN2xtcE5Zamcv?=
 =?utf-8?B?bVFhYnY1RTJpZ09DV2JOQ3VRakVaTkI4b09VZ3FQWEFkRXhpV20zYmtBejNy?=
 =?utf-8?B?WHdkcEZxMG1NRXFBUGc2T1RkeGlvRXphQm5mOVBENXpvV1J4a25DUllqTEE3?=
 =?utf-8?B?ZTRvODV1NXdPcm9RcDJYbHhpNzRBa0tLNFg5QTNIU25nNXJFalJFamlqS05P?=
 =?utf-8?B?WlFkekhpaXJ2MFFjOFd2d1V3K21wUXBsT1dUWmVRRGN5bFZFeDFnekpqN1gw?=
 =?utf-8?B?bVRMcFNvQkpJNGRabGpJNHI3aWhxakhFQTZuZmZQa3I3NjNLc0ZWRmZpbmtw?=
 =?utf-8?B?dW1qQVdndkJSS2w0bDJGK1F4NEwwaUZ3NG9BenZvR3VPVUkwY05iUEs4Situ?=
 =?utf-8?B?Y3lQdUNQbGgxNFo0WGtsd1Y5SFFkRDNZN3RVS1lBRE5SRTA4OU92UFdWU2FE?=
 =?utf-8?B?bkN6NGZFckROZFZsZWpLMENmNmFhWkFmalk1YmtxbWxtbU9EYnF0alVINlpO?=
 =?utf-8?B?WjZzQmhhblN2UnFyazlwYkdnY2xXZVdkbkJ0Sm5za1F5WHYzYUlpZzEvUFA0?=
 =?utf-8?B?YnNiWlEzL3dDeW5IWEVhWHduUjQwVEhodXVLLzkvcml3Z1NTT3ZkazBpeW1K?=
 =?utf-8?B?eWtIdHB0cktWcjUxZlBkZXlSSXhTVGhSckphcFNpRmFXdkpSamp5MFB6bXNU?=
 =?utf-8?B?Tnp6dWRxaHZMdis0UkV6NlNEeElkd3BYcWYzUUswWmI5SVhxZkxLelhTWDlU?=
 =?utf-8?B?VWN5Q1Vza1oxY204d2dBVmwxVXUzNE0vdmpYRVVaUlZ5ZWx5R0lGSFl2K3FO?=
 =?utf-8?B?RWRhQkM1UXpBM3phYk1wdmpkZHc4WHRBNzhDVE04SWtqY0Q1TVk5VklrSUhQ?=
 =?utf-8?B?a1ZuYjVTMzlYME1vSSt6blM2bUJjSDVUWmExY3hFNFZWcVUvL0VPQlhXOUtK?=
 =?utf-8?B?TDZpOE9hYTVsdk9SSFJpWDZjS0puQ3Q5MjZKVHltNjZZUFhWY2RtR1pWOFRN?=
 =?utf-8?B?eFQyRWt3d2Z0dUsrNlhOUFhNWjZ4ZEoxZmY3RmIvQ1JrYVpoMnNPQWpiRUln?=
 =?utf-8?B?dmxmMFRwbzhhUFJlV1U4L1dRenNONitPY1l3bXdtcmVtazFianVZTlZwNzRF?=
 =?utf-8?Q?DlaQYE4YVVXKhOrVo9z6ShA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WDdTeXNqaEpGR3BCWGdldnJTcjEvamRyNlRFcVU4Y0U4Q2F6YTBGNzVvQmEy?=
 =?utf-8?B?ZnJMMXpuMDF0UExGREhOL2I5b3Y4N2RiNmJ6by95MVlLbStlZGNnTnlrYWFw?=
 =?utf-8?B?R1RrMVQ1YzVndmNKMlllcHdzL3ZzUjhFUGl5VVVjd1NhZFpzMzliWTRSSFZ6?=
 =?utf-8?B?dTJqSEVOVDF2ZHNpd09ZUnFzdDVPMzcwcEtoT3BOSmdCNkJJNWVFYXlmSmpS?=
 =?utf-8?B?a1k4Q0NZa3hLSWVYRCtJQjFPUEUyeXUwMDBic05rcllDR3pRSUUybjJ4SzVT?=
 =?utf-8?B?S0E2ejFzSXFXMnNUdlh5RllaSW8vOVk4VHQ2RHkrQVlWY2xMSnJkTldEaHhV?=
 =?utf-8?B?VHJhM2NvMG1odjlqQ2RIT0tZRFo0YllaeFU3M3RCeVpLeTFlM1Q0YU9VTTQ2?=
 =?utf-8?B?TGZUUzNYZXZDU0xBOGZDMlZ3R3cyZmh1M2Z2TVV6bUxUWlJQeEp2RTc3MzFR?=
 =?utf-8?B?WGdYYU1FNEV2OFZBKzdQL2pScmttMmpzUGk1RkNPWDBQc1g2YW1FNm01dVAv?=
 =?utf-8?B?SmZvWGoxU2xHZkVJQzVCZGo0UTZNTEF1NDR6a0VuTlpyOXJQVWs3djlMcVNV?=
 =?utf-8?B?aG5qVHIvQVdVL3hNejVSMGlEeStRUCtHU0ZyYnpDK21ITWkyZjQ3dXdTcHRL?=
 =?utf-8?B?VVNNQjl0NmprTmFIL0FhNHBvb3lJNGE4YmNZN1ViYUZ3cGFETXpnbDVIUWhJ?=
 =?utf-8?B?eVF6WC82anFCalhVMWl5UG96UjNvMDhXclg4eTMrNEpoWC9QdFBWWWp0MlBt?=
 =?utf-8?B?bW84UzlWRUE2YjliVm5QM1RTdVBwbytPQ0ZGUkhCMHA1cWNIa09iRGc1UkFn?=
 =?utf-8?B?V0w0WHFaQXF1RUlwOEpEa1NmNUhSSlFwMzJRK21DOEMvQlMrVTN1bzVJWTUr?=
 =?utf-8?B?ZlNhMldPaHlKNWJPR3JGeWFlUXNJcXVqcGV4WnlrOXZ4TXMyTWpRcXh3YW5J?=
 =?utf-8?B?dXJhQUtYdXRTUm1aeUxlakw2cHpMd0Y0NlV3Tk5ubVlZS1ZYWE03eWhmbG5n?=
 =?utf-8?B?WXFIRXBBSSt6d0JYaWFPU1FyZm1FclZGL0ZSWWpQMkVwelMwNFlCLzNmOXlp?=
 =?utf-8?B?Q0JYL0c2TEJsK2YyL00yQk1kNFFieGRzZkdxTG1qY0orMkVIZVhNLzdVbVRB?=
 =?utf-8?B?SU1PQVVKck1qZjhoNUsveFhrK0wrbDQ5ZTBocWtJMHNoKy8yUUxydWJJMkR3?=
 =?utf-8?B?TUdtTXZqNWdmdWhTeWFDU0Z3TDNZMU9WZzQ0RVdBVzQ1cXJnSGI5d2dZQUNn?=
 =?utf-8?B?OVhuK1U0TExieWNLVWtwZVIvUVRZVmxlVEZEYStEcTFyVnBDZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d5da0d-b000-4b1e-f0fa-08daff26e123
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 22:52:48.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoE4BEAjm0pDpDqspqaGuAU1ZlwXrXo6PRlSCVVTbwd2cfEHJzUgJ4gFrsXlKaynrI7KLOwrsMRjuc8uXpZz5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250203
X-Proofpoint-GUID: Nu-LdaK7rpaepLJWZXXlq3O1pP02D_2e
X-Proofpoint-ORIG-GUID: Nu-LdaK7rpaepLJWZXXlq3O1pP02D_2e
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/01/2023 21:34, Eduard Zingerman wrote:
> On Wed, 2023-01-25 at 18:28 +0000, Alan Maguire wrote:
>> On 25/01/2023 17:47, Eduard Zingerman wrote:
>>> On Tue, 2023-01-24 at 13:45 +0000, Alan Maguire wrote:
>>>> Compilation generates DWARF at several stages, and often the
>>>> later DWARF representations more accurately represent optimizations
>>>> that have occurred during compilation.
>>>>
>>>> In particular, parameter representations can be spotted by their
>>>> abstract origin references to the original parameter, but they
>>>> often have more accurate location information.  In most cases,
>>>> the parameter locations will match calling conventions, and be
>>>> registers for the first 6 parameters on x86_64, first 8 on ARM64
>>>> etc.  If the parameter is not a register when it should be however,
>>>> it is likely passed via the stack or the compiler has used a
>>>> constant representation instead.
>>>>
>>>> This change adds a field to parameters and their associated
>>>> ftype to note if a parameter has been optimized out.  Having
>>>> this information allows us to skip such functions, as their
>>>> presence in CUs makes BTF encoding impossible.
>>>>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>> ---
>>>>  dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>>>  dwarves.h      |  4 +++-
>>>>  2 files changed, 77 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>>> index 5a74035..0220f1d 100644
>>>> --- a/dwarf_loader.c
>>>> +++ b/dwarf_loader.c
>>>> @@ -992,13 +992,67 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *cu,
>>>>  	return member;
>>>>  }
>>>>  
>>>> -static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>>>> +/* How many function parameters are passed via registers?  Used below in
>>>> + * determining if an argument has been optimized out or if it is simply
>>>> + * an argument > NR_REGISTER_PARAMS.  Setting NR_REGISTER_PARAMS to 0
>>>> + * allows unsupported architectures to skip tagging optimized-out
>>>> + * values.
>>>> + */
>>>> +#if defined(__x86_64__)
>>>> +#define NR_REGISTER_PARAMS      6
>>>> +#elif defined(__s390__)
>>>> +#define NR_REGISTER_PARAMS	5
>>>> +#elif defined(__aarch64__)
>>>> +#define NR_REGISTER_PARAMS      8
>>>> +#elif defined(__mips__)
>>>> +#define NR_REGISTER_PARAMS	8
>>>> +#elif defined(__powerpc__)
>>>> +#define NR_REGISTER_PARAMS	8
>>>> +#elif defined(__sparc__)
>>>> +#define NR_REGISTER_PARAMS	6
>>>> +#elif defined(__riscv) && __riscv_xlen == 64
>>>> +#define NR_REGISTER_PARAMS	8
>>>> +#elif defined(__arc__)
>>>> +#define NR_REGISTER_PARAMS	8
>>>> +#else
>>>> +#define NR_REGISTER_PARAMS      0
>>>> +#endif
>>>> +
>>>> +static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>>> +					struct conf_load *conf, int param_idx)
>>>>  {
>>>>  	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
>>>>  
>>>>  	if (parm != NULL) {
>>>> +		struct location loc;
>>>> +
>>>>  		tag__init(&parm->tag, cu, die);
>>>>  		parm->name = attr_string(die, DW_AT_name, conf);
>>>> +
>>>> +		/* Parameters which use DW_AT_abstract_origin to point at
>>>> +		 * the original parameter definition (with no name in the DIE)
>>>> +		 * are the result of later DWARF generation during compilation
>>>> +		 * so often better take into account if arguments were
>>>> +		 * optimized out.
>>>> +		 *
>>>> +		 * By checking that locations for parameters that are expected
>>>> +		 * to be passed as registers are actually passed as registers,
>>>> +		 * we can spot optimized-out parameters.
>>>> +		 */
>>>> +		if (param_idx < NR_REGISTER_PARAMS && !parm->name &&
>>>> +		    attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
>>>> +		    loc.exprlen != 0) {
>>>> +			Dwarf_Op *expr = loc.expr;
>>>> +
>>>> +			switch (expr->atom) {
>>>> +			case DW_OP_reg1 ... DW_OP_reg31:
>>>> +			case DW_OP_breg0 ... DW_OP_breg31:
>>>> +				break;
>>>> +			default:
>>>> +				parm->optimized = true;
>>>> +				break;
>>>> +			}
>>>> +		}
>>>
>>> Hi Alan,
>>>
>>> I looked through the DWARF standard and found two relevant entries:
>>>
>>>> 4.1.4
>>>>
>>>> If no location attribute is present in a variable entry representing
>>>> the definition of a variable (...), or if the location attribute is
>>>> present but has an empty location description (...), the variable is
>>>> assumed to exist in the source code but not in the executable program
>>>> (but see number 10, below).
>>>
>>> This paragraph implies that parameter name presence or absence is
>>> irrelevant, but I don't have any examples when parameter name is
>>> present for a removed parameter.
>>>
>>>> 4.1.10
>>>>
>>>> A DW_AT_const_value attribute for an entry describing a variable or formal
>>>> parameter whose value is constant and not represented by an object in the
>>>> address space of the program, or an entry describing a named constant. (Note
>>>> that such an entry does not have a location attribute.)
>>>
>>> For this paragraph I have an example:
>>>
>>>     $ cat test.c
>>>     __attribute__((noinline))
>>>     static int f(int x, int y) {
>>>         return x + y;
>>>     }
>>>     
>>>     int main(int argc, char *argv[]) {
>>>         return f(1, 2) + f(1, 3);
>>>     }
>>>     
>>>     $ gcc --version | head -n1
>>>     gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
>>>     $ gcc -O2 -g -c test.c -o test.o
>>>     
>>> The objdump shows that constant propagation removed the first
>>> parameter of the function `f`:
>>>
>>>     $ llvm-objdump -d test.o 
>>>     
>>>     test.o:	file format elf64-x86-64
>>>     
>>>     Disassembly of section .text:
>>>     
>>>     0000000000000000 <f.constprop.0>:
>>>            0: 8d 47 01                     	leal	0x1(%rdi), %eax
>>>            3: c3                           	retq
>>>     
>>>     Disassembly of section .text.startup:
>>>     
>>>     0000000000000000 <main>:
>>>            0: f3 0f 1e fa                  	endbr64
>>>            4: bf 02 00 00 00               	movl	$0x2, %edi
>>>            9: e8 00 00 00 00               	callq	0xe <main+0xe>
>>>            e: bf 03 00 00 00               	movl	$0x3, %edi
>>>           13: 89 c2                        	movl	%eax, %edx
>>>           15: e8 00 00 00 00               	callq	0x1a <main+0x1a>
>>>           1a: 01 d0                        	addl	%edx, %eax
>>>           1c: c3                           	retq
>>>     
>>> However, the information about this parameter is still present in the DWARF:
>>>
>>>     $ llvm-dwarfdump test.o
>>>     ...
>>>     0x000000c1:   DW_TAG_subprogram
>>>                     DW_AT_name	("f")
>>>                     DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
>>>                     DW_AT_decl_line	(2)
>>>                     DW_AT_decl_column	(0x0c)
>>>                     DW_AT_prototyped	(true)
>>>                     DW_AT_type	(0x000000a9 "int")
>>>                     DW_AT_inline	(DW_INL_inlined)
>>>                     DW_AT_sibling	(0x000000e1)
>>>     
>>>     0x000000d0:     DW_TAG_formal_parameter
>>>                       DW_AT_name	("x")
>>>                       DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
>>>                       DW_AT_decl_line	(2)
>>>                       DW_AT_decl_column	(0x12)
>>>                       DW_AT_type	(0x000000a9 "int")
>>>     
>>>     0x000000d8:     DW_TAG_formal_parameter
>>>                       DW_AT_name	("y")
>>>                       DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
>>>                       DW_AT_decl_line	(2)
>>>                       DW_AT_decl_column	(0x19)
>>>                       DW_AT_type	(0x000000a9 "int")
>>>     
>>>     0x000000e0:     NULL
>>>     
>>>     0x000000e1:   DW_TAG_subprogram
>>>                     DW_AT_abstract_origin	(0x000000c1 "f")
>>>                     DW_AT_low_pc	(0x0000000000000000)
>>>                     DW_AT_high_pc	(0x0000000000000004)
>>>                     DW_AT_frame_base	(DW_OP_call_frame_cfa)
>>>                     DW_AT_call_all_calls	(true)
>>>     
>>>     0x000000f8:     DW_TAG_formal_parameter
>>>                       DW_AT_abstract_origin	(0x000000d8 "y")
>>>                       DW_AT_location	(DW_OP_reg5 RDI)
>>>     
>>>     0x000000ff:     DW_TAG_formal_parameter
>>>                       DW_AT_abstract_origin	(0x000000d0 "x")
>>>                       DW_AT_const_value	(0x01)
>>>     
>>>     0x00000105:     NULL
>>>     
>>> When I ask pahole with this patch-set applied to generate BTF I see
>>> the following output:
>>>
>>>     $ pahole --verbose --btf_encode_detached=test.btf test.o
>>>     btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
>>>     Found 0 per-CPU variables!
>>>     Found 2 functions!
>>>     File test.o:
>>>     [1] INT int size=4 nr_bits=32 encoding=SIGNED
>>>     [2] PTR (anon) type_id=3
>>>     [3] PTR (anon) type_id=4
>>>     [4] INT char size=1 nr_bits=8 encoding=SIGNED
>>>     [5] FUNC_PROTO (anon) return=1 args=(1 argc, 2 argv)
>>>     [6] FUNC main type_id=5
>>>     matched function 'f' with 'f.constprop.0'
>>>     added local function 'f'
>>>     matched function 'f' with 'f.constprop.0'
>>>     [7] FUNC_PROTO (anon) return=1 args=(1 x, 1 y)
>>>     [8] FUNC f type_id=7
>>>     
>>> Meaning that function `f` had not been skipped.
>>> A trivial modification overcomes this:
>>>
>>> 		if (param_idx < NR_REGISTER_PARAMS && !parm->name) {
>>> 			if (attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
>>> 			    loc.exprlen != 0) {
>>> 				Dwarf_Op *expr = loc.expr;
>>>
>>> 				switch (expr->atom) {
>>> 				case DW_OP_reg1 ... DW_OP_reg31:
>>> 				case DW_OP_breg0 ... DW_OP_breg31:
>>> 					break;
>>> 				default:
>>> 					parm->optimized = true;
>>> 					break;
>>> 				}
>>> 			} else if (dwarf_attr(die, DW_AT_const_value, &attr) != NULL) {
>>> 					parm->optimized = true;
>>> 			}
>>>
>>> With it pahole seem to work as intended (if I understand the intention correctly):
>>>
>>>     $ pahole --verbose --btf_encode_detached=test.btf test.o
>>>     btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
>>>     Found 0 per-CPU variables!
>>>     Found 2 functions!
>>>     File test.o:
>>>     [1] INT int size=4 nr_bits=32 encoding=SIGNED
>>>     [2] PTR (anon) type_id=3
>>>     [3] PTR (anon) type_id=4
>>>     [4] INT char size=1 nr_bits=8 encoding=SIGNED
>>>     [5] FUNC_PROTO (anon) return=1 args=(1 argc, 2 argv)
>>>     [6] FUNC main type_id=5
>>>     matched function 'f' with 'f.constprop.0', has optimized-out parameters
>>>     added local function 'f', optimized-out params
>>>     matched function 'f' with 'f.constprop.0', has optimized-out parameters
>>>     skipping addition of 'f' due to optimized-out parameters
>>>
>>> wdyt?
>>>
>>
>> This is great, thanks Eduard! I can add an additional patch
>> for the else clause code above, attributing that to you in v2 if
>> you like?
>>
>> Alan
>>
> 
> More on this topic. I tried the same example but with clang,
> DWARF generated by clang differs significantly.
> 
>     $ cat test.c
>     __attribute__((noinline))
>     static int f(int x, int y) {
>         return x + y;
>     }
>     
>     int main(int argc, char *argv[]) {
>         return f(1, 2) + f(1, 3);
>     }
>     
>     $ clang --version | head -n1
>     clang version 16.0.0 (https://github.com/llvm/llvm-project.git 50d4a1f70e111cd41b1a94d95fd06b5691aa2643)
>     
>     $ clang -O2 -g -c test.c -o test.o
> 
> llvm-objdump shows that the first parameter is still optimized out:
> 
>     $ llvm-objdump -d test.o 
>     
>     test.o:	file format elf64-x86-64
>     
>     Disassembly of section .text:
>     
>     0000000000000000 <main>:
>            0: 53                           	pushq	%rbx
>            1: bf 02 00 00 00               	movl	$0x2, %edi
>            6: e8 15 00 00 00               	callq	0x20 <f>
>            b: 89 c3                        	movl	%eax, %ebx
>            d: bf 03 00 00 00               	movl	$0x3, %edi
>           12: e8 09 00 00 00               	callq	0x20 <f>
>           17: 01 d8                        	addl	%ebx, %eax
>           19: 5b                           	popq	%rbx
>           1a: c3                           	retq
>           1b: 0f 1f 44 00 00               	nopl	(%rax,%rax)
>     
>     0000000000000020 <f>:
>           20: 8d 47 01                     	leal	0x1(%rdi), %eax
>           23: c3                           	retq
> 
> And here is the DWARF, note that formal parameter has both
> `DW_AT_name` and `DW_AT_const_value` attributes:
> 
>     $ llvm-dwarfdump test.o
>     ...
>     0x00000061:   DW_TAG_subprogram
>                     DW_AT_low_pc	(0x0000000000000020)
>                     DW_AT_high_pc	(0x0000000000000024)
>                     DW_AT_frame_base	(DW_OP_reg7 RSP)
>                     DW_AT_call_all_calls	(true)
>                     DW_AT_name	("f")
>                     DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
>                     DW_AT_decl_line	(2)
>                     DW_AT_prototyped	(true)
>                     DW_AT_calling_convention	(DW_CC_nocall)
>                     DW_AT_type	(0x00000085 "int")
>     
>     0x00000071:     DW_TAG_formal_parameter
>                       DW_AT_const_value	(1)
>                       DW_AT_name	("x")
>                       DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
>                       DW_AT_decl_line	(2)
>                       DW_AT_type	(0x00000085 "int")
>     
>     0x0000007a:     DW_TAG_formal_parameter
>                       DW_AT_location	(DW_OP_reg5 RDI)
>                       DW_AT_name	("y")
>                       DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
>                       DW_AT_decl_line	(2)
>                       DW_AT_type	(0x00000085 "int")
>     
>     0x00000084:     NULL
>     ...
> 
> Given this DWARF layout pahole does not recognize `x` as optimized out:
> 
>     $ pahole --verbose --btf_encode_detached=test.btf test.o
>     btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
>     Found 0 per-CPU variables!
>     Found 2 functions!
>     File test.o:
>     [1] INT int size=4 nr_bits=32 encoding=SIGNED
>     [2] PTR (anon) type_id=3
>     [3] PTR (anon) type_id=4
>     [4] INT char size=1 nr_bits=8 encoding=SIGNED
>     [5] FUNC_PROTO (anon) return=1 args=(1 argc, 2 argv)
>     [6] FUNC main type_id=5
>     [7] FUNC_PROTO (anon) return=1 args=(1 x, 1 y)
>     [8] FUNC f type_id=7
> 
> The way I read paragraph 4.1.4 mentioned before the tag `DW_AT_name`
> should not be used to identify whether parameter is optimized out.
> Unfortunately trivial modification of the condition in the
> `parameter__new()` to remove the `!parm->name` check is not
> sufficient. For some reason parameters `x` and `y` are not visited in
> `ftype__recode_dwarf_types()` and thus `optimized_parms` field is not set.
> 

Thanks for this - I tried it, and we spot the optimization once we update
die__create_new_parameter() as follows:

diff --git a/dwarf_loader.c b/dwarf_loader.c
index f96b6ff..605ad45 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1529,6 +1530,8 @@ static struct tag *die__create_new_parameter(Dwarf_Die *di
 
        if (ftype != NULL) {
                ftype__add_parameter(ftype, parm);
+               if (parm->optimized)
+                       ftype->optimized_parms = 1;
                if (param_idx >= 0) {
                        if (add_child_llvm_annotations(die, param_idx, conf, &(t
                                return NULL;


With that change, I see:

$ pahole --verbose --btf_encode_detached=test.btf test.o
btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
Found 0 per-CPU variables!
Found 2 functions!
File test.o:
[1] INT int size=4 nr_bits=32 encoding=SIGNED
[2] PTR (anon) type_id=3
[3] PTR (anon) type_id=4
[4] INT char size=1 nr_bits=8 encoding=SIGNED
[5] FUNC_PROTO (anon) return=1 args=(1 argc, 2 argv)
[6] FUNC main type_id=5
added local function 'f', optimized-out params
skipping addition of 'f' due to optimized-out parameters

Thanks!

Alan

> Thanks,
> Eduard
> 
> 
> 
>>> Thanks,
>>> Eduard
>>>
>>>>  
>>>>  	return parm;
>>>> @@ -1450,7 +1504,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
>>>>  					     struct cu *cu, struct conf_load *conf,
>>>>  					     int param_idx)
>>>>  {
>>>> -	struct parameter *parm = parameter__new(die, cu, conf);
>>>> +	struct parameter *parm = parameter__new(die, cu, conf, param_idx);
>>>>  
>>>>  	if (parm == NULL)
>>>>  		return NULL;
>>>> @@ -2209,6 +2263,10 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
>>>>  			}
>>>>  			pos->name = tag__parameter(dtype->tag)->name;
>>>>  			pos->tag.type = dtype->tag->type;
>>>> +			if (pos->optimized) {
>>>> +				tag__parameter(dtype->tag)->optimized = pos->optimized;
>>>> +				type->optimized_parms = 1;
>>>> +			}
>>>>  			continue;
>>>>  		}
>>>>  
>>>> @@ -2219,6 +2277,20 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
>>>>  		}
>>>>  		pos->tag.type = dtype->small_id;
>>>>  	}
>>>> +	/* if parameters were optimized out, set flag for the ftype this
>>>> +	 * function tag referred to via abstract origin.
>>>> +	 */
>>>> +	if (type->optimized_parms) {
>>>> +		struct dwarf_tag *dtype = type->tag.priv;
>>>> +		struct dwarf_tag *dftype;
>>>> +
>>>> +		dftype = dwarf_cu__find_tag_by_ref(dcu, &dtype->abstract_origin);
>>>> +		if (dftype && dftype->tag) {
>>>> +			struct ftype *ftype = tag__ftype(dftype->tag);
>>>> +
>>>> +			ftype->optimized_parms = 1;
>>>> +		}
>>>> +	}
>>>>  }
>>>>  
>>>>  static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
>>>> diff --git a/dwarves.h b/dwarves.h
>>>> index 589588e..1ad1b3b 100644
>>>> --- a/dwarves.h
>>>> +++ b/dwarves.h
>>>> @@ -808,6 +808,7 @@ size_t lexblock__fprintf(const struct lexblock *lexblock, const struct cu *cu,
>>>>  struct parameter {
>>>>  	struct tag tag;
>>>>  	const char *name;
>>>> +	bool optimized;
>>>>  };
>>>>  
>>>>  static inline struct parameter *tag__parameter(const struct tag *tag)
>>>> @@ -827,7 +828,8 @@ struct ftype {
>>>>  	struct tag	 tag;
>>>>  	struct list_head parms;
>>>>  	uint16_t	 nr_parms;
>>>> -	uint8_t		 unspec_parms; /* just one bit is needed */
>>>> +	uint8_t		 unspec_parms:1; /* just one bit is needed */
>>>> +	uint8_t		 optimized_parms:1;
>>>>  };
>>>>  
>>>>  static inline struct ftype *tag__ftype(const struct tag *tag)
>>>
> 
