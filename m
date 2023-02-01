Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B466869AF
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 16:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjBAPNw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBAPNa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 10:13:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E88F69B36
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 07:12:48 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311EOMMY018411;
        Wed, 1 Feb 2023 15:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CyUDu0roUbekfTSYgc4RyMbnWdG7NCo+xPDJst7cNeM=;
 b=bGlb+pyS+00SSEU70xmzCfzewtLA0Ng5Vyv1UCwu/TsfsQm28I1H30hNCMu29IYILot5
 1RwPzmTPicE73OBx/xtoyAAEn5pZRqU3BIwaf3G277x2aYsD38aCllq9e+BUDI4oz6IZ
 wyMMmw5t0Im9mDn2DKKtNTziGPxvQB/V8s8z3e4t91Ge1EiFJV4ubrk4MnSucyNtNnz8
 47ZAIjPrrjl2B0AJNki+aoe94Ua1y6jaU1fbqjQxWST+2rc9eKfv9tHlB2MGWvKG4hbj
 6jhn3SNIvlFUIfnGrUz/Q1eGR+FLZeU1c4rPhgOE8RI2u1jYj7uSbz8WNWirB+pV94jl Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfmbg0uag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 15:11:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311F0Gcf033872;
        Wed, 1 Feb 2023 15:11:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct57d84d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 15:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5AWmwe75a9QdGVL2EKpgriDz+PBxqJgG5jXizjVsBJcW1/yiK2ONGXmCjdkjmx91QlQmtXr72RRxkpBNnOHYzrccJ1JRJjJmTG4SV2irSKetZs7cCUEK1ayERLLjkBwR5kanzBkjA/F8Qx3aiOEetDHMgUwHPXuzmLfBa3d00sYD1fZFFNwzu31LB/mWH2cwjibfQF0u7JSriJ69xdfcPa6jxpzwb8vMEU/k9HtCEPgao++Gw4KHIBIj1Fyqttx6qZ2A/sjUiTkJgGmU+wHbinva3wK/RxilwFQsMyK+Hmn6/Q0/1D97jST3FAis5vq/bXrVUpRzeAHm14eyrxr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyUDu0roUbekfTSYgc4RyMbnWdG7NCo+xPDJst7cNeM=;
 b=FnRTHpCLeRBDnaAhfaK0W4oJW0o/d67mqD9XcyRz4EAG8q0g2aGR+UfZ5HPI5s129S/ONJXu25sPxQSf/5+z5D8DmBmXhGgf9T5QQqpM8k4q1Jokcd9uIsuWxIphsL0ZyL+g0JeHC80aOOnzGLLUxaZeXjkxJp+8LsXOe3+DZ8VWYoH4DTWElSSu5CbJo7F1m8Lauoi0Hhkuwaa6stmHrKDXfoq7KyZ5/5B3gzaTEFS7N016XbiOYpZz+nolggGN4Hj4pciMLAijM03ozwqA4hTY1TFGUkRpdTbWbNmmau4qKHdm8Ri0ctr0wrgbW8JcNOXzF14jzQjUZBoYcrc02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyUDu0roUbekfTSYgc4RyMbnWdG7NCo+xPDJst7cNeM=;
 b=JS8e1acbS/bUZikca0BJFAVkaeOj01NmpunExIqdk03fnLmlBwpt+F+4jzM5D+q7SA40mKRaHyJLuVC6O4FUO79aCgiw0TFYOaIDMqtL4DR7ExcTZgI6MYvKqvBUiBFlUrAXQOt5ImT6tHpFCmWb/1vVmgqJ8EvOdeztC7Snyww=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB5160.namprd10.prod.outlook.com (2603:10b6:408:115::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 15:11:15 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 15:11:15 +0000
Subject: Re: [PATCH dwarves] dwarves: sync with libbpf-1.1
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
References: <1675169241-32559-1-git-send-email-alan.maguire@oracle.com>
 <Y9pvYFPlFEVXJGK1@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <069af020-2db7-3e0f-e997-7af1f0b33c95@oracle.com>
Date:   Wed, 1 Feb 2023 15:11:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y9pvYFPlFEVXJGK1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR05CA0096.eurprd05.prod.outlook.com
 (2603:10a6:207:1::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BN0PR10MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: e87232e8-a812-4926-b1f8-08db04668fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m9NcnurpfFPpBx3dLTcbSQaRnsGTC37s61Lk8zdFIvCC7kAWUi0rbN07HjY8GbRNc2rw58QS5n3euTJBAIQSpqka8biY1vJr/LzE5URn1TASLcA1TWSA/GJFZ4Vb6WdYa3zwe1LvOfVuEdwkosfJoS4sr/9JNcnXxjZUgLm/StfNjprOrphsnPsl4zzqzCralL5rhJ3dSJGiHyxC/Vy78EZyetVcIKn9jwoQH/IGmp3IHiBKDWd0r1WeNVgF53gRuk2CuhBbvtPpakXopO+EgnDRAu8ZgiHpHytUGxkSowq+cycbKnrQKO9efCDxryi5DmWQApxxvUX3Hf/db5JDD1as9GsIRkHJch4JKbni3H2wDiM3EdR3TBFVnN/llOzZPA2J1YYQBpWFpLpr8oAdMi6xVLwf0u9pXbrvb1yaT17MkNDwjI52QwRRwMw7bpMfA+OgMUdTtedSVOnVG7izFeMuqlnxJUAP7J3SEAuJeV4HtSV7PaAMVQF0GZ9iZnc1a4fFTk9XkuV4oYNBCE8SD6lIqc2RZaNn2NF9FbyrLCxlxVk1i7R9HYd9aIsoUz/jo0wp+/F3A8P6NtvoVd/Xu5iaRV+CIXEHmjbWjnM37EcE/1bsb4iBw4bJaxang+6QHUjIQCy+bzTbWdN5LGwT3mTS2BGcYnMOI1/i3I9+iV4RGcK2ZbvIBqYzx8kcPVtvPiqlHFpPesCStTdV0wYMvO6og/4n/XgKekC7LWcKC3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(44832011)(2906002)(36756003)(83380400001)(316002)(6666004)(478600001)(6486002)(6506007)(6916009)(66476007)(186003)(6512007)(5660300002)(7416002)(8936002)(4326008)(66556008)(31696002)(8676002)(53546011)(86362001)(41300700001)(38100700002)(66946007)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhCTDlUZkdLbzBXZzJNWHJ1WFViWlBBRTkxMmEvaXppby90V0lXSGpBUUxo?=
 =?utf-8?B?eUVuVkRpeERUNS92RGlaYTFjaHVKYXY3aVZEOGZQWmZpc2Rzc0N0dHprSUNz?=
 =?utf-8?B?dWpUQ2xyTlIzTTVDOGlRR1VOeFVHb05zdDJyWEtsZGs5ZEE0eks3Z0VDdkJl?=
 =?utf-8?B?SjZ2NmpSNkhEeHVIVFRGaXZsZFErMUF2KzduZlpEUzBIZ2w1OGg1MHlBS25X?=
 =?utf-8?B?TGJqSFpDb3o2S0RNZEw4cHRuN0JTNXlZKzlvNHorY1cydGExMWlXTUZMVytC?=
 =?utf-8?B?MXRPbC9BU3gzcUV4S1RIN0t5MHl1QWZPNmk3QTA4TkRMMUVMVHE3Nloxa00x?=
 =?utf-8?B?eTY2c2VzcVZBTXhoZzh4TE1uekxKWmVIeFBGQTRjVXQzVlY1VkthV2puRGgx?=
 =?utf-8?B?b2p4QTZ0bm95QVN5RHlCeGYvSW1aUWNLY1IxOUhUamdqZHZCY3BEOCsrWlYx?=
 =?utf-8?B?VUdmSHNacmM2NnUvcnFFaE9nVFJWVXBWQmZwYWlpRm9nZ0ZKMWwydEViajY5?=
 =?utf-8?B?SVhFVkp4TFZvNTU5aXZTNDAvWWlmMHhZWTY4aDUyOHlDQk4rdEJQa3duNlhE?=
 =?utf-8?B?UlRIZ3pYRlMydkdoL0lOaTkrQ3B1YU9IT3FZTnJ1a1YvSmFRV3Z1TW9BZkZt?=
 =?utf-8?B?WlIxQ0hxcnZ5SGFXQkJzTTlmaUZVU2ZXN1J0Qzh3SHFmOUlPeHE4ZElpWkdl?=
 =?utf-8?B?SjlIbnNHblVRYWhBbzFwNzN4aEpvcjNSTXdPUkxRMlZQN25FQnJXcTJDK2Jr?=
 =?utf-8?B?MUtCTERDdjE3VVlJL09XOTRVd0gzbXdIdjZRZG1nekZ1Y3lBalJYT09kSk9Z?=
 =?utf-8?B?MUczTmhHS2NBMVk4NFh0bk9WMjVRdEUwZ2ZXc1ovMnRZS3BtZjJicjRmMDNX?=
 =?utf-8?B?Z0N5enZEQlhmRHBwSmNqWXNucnc0SWRaQ3NKK1RsZi94R2R0R1FJSk9FWFN4?=
 =?utf-8?B?aDdQQVhrVXZxSHBjUU4yM2F3dXFHSEJ0R3ZUVzlCUll3UmxkSUFZZlpBQ3I0?=
 =?utf-8?B?K00xOFpJc2pnTjdadm9GWlcwcTl2SWordjNIUWVmcmsyY1JpR3ZSYVV0Tzd0?=
 =?utf-8?B?SXFBMzgyNzRrY09GK1dMZlRQcTA1bndIWWJyK1BxMXlrQVVwbVE5TEN5dW1H?=
 =?utf-8?B?dzFkVE90Qm9FcHlJT0Z0b2tpajRHNEJiNEJPcXpFTkJZd3NXTG90Q284UzhO?=
 =?utf-8?B?NXJFRzYwcWNDQW92TGFDc2RaYjMrNkhSNlFBVmlQNzg0eURoOFhDczVLbzBx?=
 =?utf-8?B?UmNIMi9XZ2R6b0ViYjN3RVJiWldhc0ZXWUtJS0VjYmRCWXFLQ2pnWWFhbk9Y?=
 =?utf-8?B?aUtPZ2ZqUGJKZUxqNTVHQzVyU1hsSTUycS9IcUZFVWRXSlZTcm1xZkxuRFlH?=
 =?utf-8?B?cWIveDFTdHJSWlB2a2JYNmFHdE5vL3J5TFV2T1poaXYxUlNMdDVUVUZqL0Vl?=
 =?utf-8?B?dWxsN2JpdDAyeWoxS2ZXbXcrbTJCeDlqSmJjRGFOY3pWRUlrK1NaQm0wckJo?=
 =?utf-8?B?Z3BibGlZQWYrSXVxK05nUkU1Q1hsaVU3c2dJU2pnc3hDVHlLaTlURnl4N010?=
 =?utf-8?B?UU5ZbE1rcTk0d3NndWtERzR1bmVGU3M1Z0pGakR3bWdyWk80S1hjRTgwSjRs?=
 =?utf-8?B?Z1JSbmZUZXJCWTV6dVVnbysrcjdXMVRQOXVqRlI0NkUvQSsydlpINk1zTVFj?=
 =?utf-8?B?OThmcmpBSFp0WHFQanFvS0VTcHIrR25xMFdzMFZEZENKQ2xzUjVGTEgwY0tz?=
 =?utf-8?B?T2t0T1JvVSt4cGtZblZxakJTVDhQMWdiS0VpbzRDUU8xVHBZcEVGVE9ickxU?=
 =?utf-8?B?Rk9ETEIyTnBKMVFudzd6ckFXbGE4RUtONkFEL25DS3FKWXRINXpYOFk0bDBJ?=
 =?utf-8?B?NytXVFNmV25qMmZhN1ZGeGcxeitUelZFRFk5UWVLeXRhVlVBQTFJWGExMG1H?=
 =?utf-8?B?aVUxK0hUMXdVdnR2L1RMazUzUzRuR1VnaGtaUlZGTUZHSG9wcHI2TXo1UUdy?=
 =?utf-8?B?UksvNkgxVnlpeHVlQ3Y0RkdyYkNaaVlHRTU0VnBnVlQzSUt4a21nRmFzaEZG?=
 =?utf-8?B?M1p2ZWI1NGNDQ0QvZktKSi9DeHQzTHhTaDlFWldOaThQNkxHOUZJWjNWOVBS?=
 =?utf-8?B?MG5rdUNJZkpRcHVCMm1ZdUM0ZkdWYkVSTXI1OWdtTXV6NnJIN1g2T3dEdHZN?=
 =?utf-8?Q?L/j8Xe9UsVY/f1RaFfIRa5c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S3RUdzlSaVhmQkd4UW9GUU5vczZ1bTB3VHluSVlWNlNIaXlMdStoLzVIeGNp?=
 =?utf-8?B?cDFzK0FXVFJMUTBMMFVLU2dtT0hmRkNSUjBUMmtrVHUzazV3UGNoU3pLdFhJ?=
 =?utf-8?B?ZnVsWTFQeUV1K3FCS0RvVlpNV2htRzMvSmM4OWtRNGxhRnhmQWgxYjIzOFVm?=
 =?utf-8?B?Y0xFQXprS1RjR2FUOENzM2V5aUM1Q1NPeUJLcFlnLzRIUldxS0JiTzhQQnBS?=
 =?utf-8?B?VUdCd1J1UGpaS2YydCtUYmxlcDlRSmNBdjNUMnJRcHpEWDVzaFNEV3BObDg4?=
 =?utf-8?B?TTRQdG9wS3F3M3VaWlpBMlZXbk9RYTYxRHNBVVo2bU9Hc09CdUlYWGd2b2h3?=
 =?utf-8?B?RDdLZjR0aTZZTDdGM3JvZEZFTFdpWFNoZmZsYmNtVGU4YUpIcU41TU5ZaTV0?=
 =?utf-8?B?eWIrRjd0S2JEY2NVcTVaOGNLNWN3cmlZaklPYjg1V3BzYnFXNkZ5VkV5NWcy?=
 =?utf-8?B?YmEyU2hMTVlHTmRaYlNaTEhDZ2tMeS94czRuSFdEZW90N1BOclJUL3NBWUpn?=
 =?utf-8?B?eXAvNVAvSHlaeS9mdml5NzR3UExtcFJRdW1iNmVEM3EzcW8zMGlyUUtXZEkv?=
 =?utf-8?B?SWlXVUxsTjRkZEpMQ2RtclRpTWkwUUZlSElsQU1rbkllNHJqYVBrdFZVRjU4?=
 =?utf-8?B?RFFaZFR2WXp4SktqK3BTL2tIWWVwUVd4U0xGSDVSR0Yzc28vQ2xEOVltbWp2?=
 =?utf-8?B?OUdNS09ROXdBaU16b1FUSWkxN056SU90cHZCVFUwZyswTmhKRzVEV3NYc0pq?=
 =?utf-8?B?YTh6OVBPYTJPTGNKUGxRZ09iV1FEck1rVGdwdGloalU2S1hPQUkvNDhQK1lQ?=
 =?utf-8?B?TFYzWG5zaC9QdXYxanpJbG1mUjM1a1RWZm5NeWNlczVucXQ1UnBkMGNWMlpl?=
 =?utf-8?B?ZDRVMnh1QU01MEs2aktQdVpEVGIrYk0rM3MrYlJVT0U3ZmFEZ2JhN2h4VEpR?=
 =?utf-8?B?UGpzWlVTTFN2QVhlMW45c0ZVQVVUTUI3dEp2V3dnTnJwdXZOTlgwTktGWVQy?=
 =?utf-8?B?aTRncHVjcEY5bGhuRDZZUkVKcDVlUmtyWGV6ajRnVXlLRWhkaWFxNWR3Yml6?=
 =?utf-8?B?aCtIKzNvRmpyRnFDa05jM2FCMUtFcUFOd2pvdXc0eFY0THJlR3BUc2xYSktH?=
 =?utf-8?B?YkRxQzNqWG5IbG15ZlpVSmMxTkkySEh2eU9xaFFTVktSSmxrTWtBYnpUNGhi?=
 =?utf-8?B?VDdhbTB1MlZvQUJka3B4eWNZcE1BRncxTjZJWk1Mazhkb3U2dlpaU00vYXEw?=
 =?utf-8?B?M0N5NXBlbFJmWlcxTHF1RlUxWmhJQTY3dWRPRzBpUmtpb2FEZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87232e8-a812-4926-b1f8-08db04668fd0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:11:15.5612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9nImEBOXt0IcuX3PVZNmRvvN6DD7MXeVZQjbw+Yo9ALNG4HiRsCASYNQY7Yc1LDm3m59hJ6UEsEwCzciy8wMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010130
X-Proofpoint-ORIG-GUID: EDpNV_oqa7_Sg3MbosojHZ0p2dlItxGl
X-Proofpoint-GUID: EDpNV_oqa7_Sg3MbosojHZ0p2dlItxGl
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/02/2023 13:55, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 31, 2023 at 12:47:21PM +0000, Alan Maguire escreveu:
>> This will pull in BTF dedup improvements
>>
>> 082108f libbpf: Resolve unambigous forward declarations
>> de048b6 libbpf: Resolve enum fwd as full enum64 and vice versa
>> f3c51fe libbpf: Btf dedup identical struct test needs check for nested structs/arrays
> 
> So, after running cmake in the build directory to update the libbpf
> submodule I'm not finding the above 3 commits:
> 
> ⬢[acme@toolbox bpf]$ git log --oneline -1
> 6597330c45d18538 (HEAD, tag: v1.1.0) sync: latest libbpf changes from kernel
> ⬢[acme@toolbox bpf]$ 
> 
> This matches with the "Subproject commit" below, then:
> 
> ⬢[acme@toolbox bpf]$ git log --oneline | egrep "Resolve unambigous forward declarations"\|"Resolve enum fwd as full enum64 and vice versa"\|"Btf dedup identical struct test needs check for nested structs/arrays"
> 758331091179fe47 libbpf: Resolve unambigous forward declarations
> 3a387f5a8fa8b25f libbpf: Resolve enum fwd as full enum64 and vice versa
> 6ebbbacb5cb11840 libbpf: Btf dedup identical struct test needs check for nested structs/arrays
> ⬢[acme@toolbox bpf]$
> 
> So I'm updating the commits, ok?
>

perfect, thanks (I think I must have used the commit ids from 
bpf-next not the libbpf project, sorry)!
 
> Thanks!
> 
> - Arnaldo
> 
>  
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  lib/bpf | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/bpf b/lib/bpf
>> index 645500d..6597330 160000
>> --- a/lib/bpf
>> +++ b/lib/bpf
>> @@ -1 +1 @@
>> -Subproject commit 645500dd7d2d6b5bb76e4c0375d597d4f0c4814e
>> +Subproject commit 6597330c45d185381900037f0130712cd326ae59
>> -- 
>> 1.8.3.1
