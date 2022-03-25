Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902E74E7CD8
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 01:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiCYXHX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 19:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiCYXHX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 19:07:23 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5CD1AA8E3
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 16:05:46 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22PHOLvS010041;
        Fri, 25 Mar 2022 16:05:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uofPj0LTEno+c9iScZuFnbExS+c1nM1sqprWqQj/U+4=;
 b=TW1maKlRh6uo1BZJGQTzL/88r5mwN/PBy9DO0FM8pg+dLixGYfL+42OLfom4oYAhiirX
 JBfdp8G6KukIRMruRyqpMuih4V2Sz/NImppj0e53z9Ppl8n7Gf80LvrEm9TfzPykita6
 7ZkxHxZFmsR1zv0XIXu/nURmmAXtF36sb+0= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f1hjutfht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 16:05:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl3fsUrkwg0JRz+i2XqLvYSytlnEjYykiRmTh/qUYFjZOZ0Kx7Ozoqu9GU1TTdG1yRlkOElYsJNkwTZmp7OFydzbpSIyuYz32IQJFMy3S2BC3JEcbG5SZlUKByvK/Lvt9cJDTkljEHfrbY5BFX+lLFTzNKA7id96xLEP4fZIB19LJ8CUDvHLazhyV8S6O26Al48JTzf8QsNegfIxASdcUl7JG+y+zFf0joLNnb/G0ntcDko71bhkkr35gFesiZr6UIFnEcLY5XLI2oA7cE5G14hFg4q+IsTSC8/Gqao1wqqh4u22lnio2UthIPaJrWI4RRjDm/dNA9lz9FSRV77GAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uofPj0LTEno+c9iScZuFnbExS+c1nM1sqprWqQj/U+4=;
 b=Jg/ctvA/wPWr5g4foGSO0rxOB/BjtAL4kqBxUbiKZqBHQsX/3HpMaqP087q96jrC7/fuYWYCBq6RJXa//Jqke/5dX1L+0KYUrDO4lpnR6tQU79sMZIHZSdF/MXATFNNGdGw9LnvfK0f0+W4fIu05wBFhwKLQitcD9WGT+xGOpHOQNI6QnYL9HWXASyjjWmVNPjanPVIAIJQr2Q5b3GbWunzOMX6o71/djxVxjlBN90fYRPlB90w5RNpk04Vg97LktNDhaChvnUgLpbWVZsIX+efE4T5nKHKtJ7hW5I0isBICI2TwjPhze9dEykCvO8gXiuA4i8fBJSbFwlN1jiwYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2919.namprd15.prod.outlook.com (2603:10b6:a03:b1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 23:05:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 23:05:31 +0000
Message-ID: <9815d77a-aef8-d177-d1b4-9c20cec8dae7@fb.com>
Date:   Fri, 25 Mar 2022 16:05:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: fix selftest after
 random:urandom_read tracepoint removal
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220325225643.2606-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220325225643.2606-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0223.namprd04.prod.outlook.com
 (2603:10b6:303:87::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69fc0612-3d8b-4887-463c-08da0eb3f581
X-MS-TrafficTypeDiagnostic: BYAPR15MB2919:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB2919F306AF7DBC00ABCEA2C3D31A9@BYAPR15MB2919.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPVU5z32vfKnhOCD8xZC34UyEuV5Anr0cuTH/bVMMGI6NgC1m9NaMXzn4yS/3WXuJ4lgqbFR2m4/eNunnvMap1RorQ4pBoFq+Vgo4Ory/t7RtMgHV5Fu9XFoCbcuAU2hi5bLoSvfJkfw/4P6MjzAclgVxKlSt+NKxVdjekEbwkRWdwaTQqHen1MA4D0AcWBEElTMPG49cpvKgc01sBu1hZnFRgWlMeYHWuy+5m2Yyu4zkPrBXWU9QcSbA3T9HO2qi0792H4eLFQknFgTwNefp3q7zKb/IsYgGYgl4aU2gE2ooPGnrAyauVpjx6/IqC+iPbWWh/i4oCLfdbBSjCHiJX7Op7wV0uozZcHHTkp/iYfX13p6bnLc4RVDAd0PubbvS1sVs4c/Y4+rtSwHkx5B30qZ98dF0M8D9Jgcy1ucVlTu8iE1Z9PsNP1OwbS1Per3pEvwpJ8tFPDc+0K/rLmKz4wuoUgZSUUO9Q+L5hSZvmDdGVHo31snIyEObWz6YWRuVQ/faXAJrNAfkqlxTqjlGLt5K6EalEZIKM06o2/z2srdVyJ3zwYW7ecYiurMsv3DgsuOijvvM78wh9rwpxfq+8WwoS9rTr3DBAc58LCwFliRrvlBOnYPWZ7qxMkLW8l/K9eni0I2WVKOm5dSyODXley2CWp8Nee43ev6PJ8+iidLboA38gR9+bAQOJr5hwF+IJFie7zLNhkbG2+ql9/8SVWhjxfOjH8V/jqr9i1jAXIJvvI6kc8kNpufI/9Mb5cl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(316002)(6512007)(8676002)(36756003)(31686004)(2616005)(86362001)(38100700002)(31696002)(8936002)(186003)(6486002)(66946007)(6506007)(66556008)(508600001)(4326008)(53546011)(52116002)(66476007)(2906002)(6666004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnVOWjBUWHpkclpRbUJ1bGg5THBrTkFDaFpYWEdrSFpKYnFxanRPYUNXMUU3?=
 =?utf-8?B?Y0NCMVZWUXpKTUk4UWdoQi9yRGlVZVpaWXowcC9pQ0RuVDgweTUzNHZXbEtC?=
 =?utf-8?B?S01tVlBOTkROMFhDTEdFeFRvMUsxZjhYK3RVcEhtcEE4SGY2KzVJdEVINmt0?=
 =?utf-8?B?ZE80UFZmQ1FzMWQxeXNxRmc5RmxyMXNCVkJsRlE3VnBFLzFoT0Z1Qjh6dVN1?=
 =?utf-8?B?SXdLZ0E1dmk5ZVdEVXZMZlJ0bXRtbURod2hJWmxiNDM0MCtiZTR1V2lTODZo?=
 =?utf-8?B?N1RoSzV2L3U5c1RLSitoOGw4NnVKeVJWSWpsOWk4YlNNOWh3MjdqT3pLV2tV?=
 =?utf-8?B?Q29pS0kxdGdkeVBJZFpxYTFnbmxLZ3d0Vkl1dUs3OE4xbjhOWlJUVFZZYkpQ?=
 =?utf-8?B?aU5Pcno5ZEZnY1BxakhRWVpsQys3S21aKzIweitjeUwzdk4rUzNnYytGWjho?=
 =?utf-8?B?ZkFyVTQxVTRYcWFRZ1p4dGhZd2JibC9ObE4rcVpwTVFnK1ZvbTE3bEg3V0dl?=
 =?utf-8?B?M0RsUzJValo1RER5ZUx2RTJQVFBMVm54eDNMcUxLU0xKQXdYMWNyMVFxNjZk?=
 =?utf-8?B?VVFMYUNnZjhILzBnaGVYTVlMVXN3MkFMei9EeFhkNE94SXZaYWR3KzhWN2Jp?=
 =?utf-8?B?M0FWV1VMbWtjTHUwUllOUHdXZDA4N2JlVWd1bi9XeTIvSFVyaS9UTTJ1aDZQ?=
 =?utf-8?B?Z1c2cXVYUWhONkRzWjgwclZhREViL0FzczFBYUwyVWlySUdGbnZMNmxTdWJq?=
 =?utf-8?B?ZTg4L0xKSkZsLzBMbTgyZzlOcEVadTZlUDNHeEN0dmtqNDd4SVI5UWJUNGwr?=
 =?utf-8?B?OFk3dncyVUlidVV6U0Y2UllkKzcxR0JpU0Fzci9jVkJydzB5MHRxMTlCWXox?=
 =?utf-8?B?Z05GZThRTlhQVFRmazZxMkZYZW8weUxuRXN3bEhsYys0TVNVN3VpTGxhdWJ5?=
 =?utf-8?B?ZE1PWUdGSlU0WndOaGhMZFpRNS9VRG9vck9yR2ltUVVpWW9SY2NsYzFNeEVs?=
 =?utf-8?B?R0VPbnhQdVpyOGJKd1lOYkFPWkxKdGpjZ2lQYnhSOXlHb09pZzRCQ3YvRjQx?=
 =?utf-8?B?eDQzcEI3cWNyZXRVYkpGV2g2KzVIZUgyMWY5TUJRbU0rck45ZkZFdHBLRUVq?=
 =?utf-8?B?WVlGUnpEbmFpcE9NQWJIY0dudTZQLzd1eEs2a0ZvT0h5RHhuYkZ1T0E1bW9N?=
 =?utf-8?B?QURnRnlZdkF1ekNHRWRieVR6SmJZalRYLzhuTUdlVmJMU3hPdUJLV3J3R0sy?=
 =?utf-8?B?RldVNHV6UkZJZmlSTklLbEE1dGRialdpcUV6OHRNNE5CT0xsaXlkeDdRcnlz?=
 =?utf-8?B?OTZ2STJ2VzlRbFhrTDdmNVJwVEFGT1NCQzU4WkY0VEltSWI3L2pRMWFhVXNj?=
 =?utf-8?B?MjVibUtWQkIvamY3VDhZSTdkdXFORUx5cmxEQlFrUzBNZ1I3b2tEdFhJZWZa?=
 =?utf-8?B?MkNvQ005Zk1zNEhXa1hmSmd4WVA0WVlIVjZaWHJVZXQza0ZmRW1hcG1nZGhW?=
 =?utf-8?B?clNtSW12ZWRkU1ZXT1FFQ2k5WDhUR1FHQS9XNGlmM1VoTW5NVVA4dHd4c1ZK?=
 =?utf-8?B?dTJadXZTK20wc2czaVloZ1FnNWVIdE83Wm9kL2RhazZ1NlhkL2x2dDdYZ1ky?=
 =?utf-8?B?c2dPTUVENFpUdmFzRHEzUm9CMUltRU82d1VhRnNFdHpTL25OM2hTK0lSRG5V?=
 =?utf-8?B?QUhsVC9hM1RCQUEySW1ldkpteXA1MURJSG94bzlLbVExTzhYMW5XOXhEYVJT?=
 =?utf-8?B?MFAvb3A0RWJhTlkzQzBRQ1VCQjZrYUtJUmg4RnZ1RU5ieG5KODJzcXFidHFv?=
 =?utf-8?B?bU02MDNaU1BhNDVGaUx6ZHFWQXhZNWVOWTV1dVJwcWdlOVdnOWxvTkVGbGZB?=
 =?utf-8?B?c3k4UGhnVVFnS3BDUktxazNZOUV6ci9ZVkVvWXFUMUl2dC9Ld3daSnp6NmRD?=
 =?utf-8?B?cU9MN3g4RnY4UUQxNU9SRG16SXh0ZlRsa0RieHA4WkxBbG10NVNrd3lWbU9I?=
 =?utf-8?B?Z1BYMTdCYVJwck4wQ2ZuU0pueURnZnBQWURYMTViT0FUSWdaRWtuRDBvZDA3?=
 =?utf-8?B?ZXlrcDFYa1lPUTFJOTk2emJFRUljbGxkM2dLNFBtcm1ieTNaR0dQRVlXdmR2?=
 =?utf-8?B?VjhlNWowYXUvNGVyTENXOFRlci95NFB3MVZCS1gzQUd6TFFFT2lpcm0yWTBn?=
 =?utf-8?B?a3dBczhQSkZsZUdkQ0Z3aGV0SFJla1ZlWDhsM3pEN0lPcXNYUThNVFZkVHFD?=
 =?utf-8?B?QkJkODNYc21jdzZ1VlFYWGhibzhXbU9ibFhGMHAyaStGTitSK2FMQ2NlTG9p?=
 =?utf-8?B?bUhPY1NLMWg2UWRubDFjYytDQ0RiVytIU3JJTFFVY0NPdEViQ0dEQ2JtdzBt?=
 =?utf-8?Q?x6XSE+v1lt8qA6d8=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fc0612-3d8b-4887-463c-08da0eb3f581
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 23:05:30.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8hBhXjMCJbOEPk5wDDoV4r2TiIG45OhcoJz8y2k50WKhLy4ugLzK5N8XDLtfIs5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2919
X-Proofpoint-ORIG-GUID: xiBw9v951X73sciOXGtA1R4wgMr7Ygpb
X-Proofpoint-GUID: xiBw9v951X73sciOXGtA1R4wgMr7Ygpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_08,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/25/22 3:56 PM, Andrii Nakryiko wrote:
> 14c174633f34 ("random: remove unused tracepoints") removed all the
> tracepoints from drivers/char/random.c, one of which,
> random:urandom_read, was used by stacktrace_build_id selftest to trigger
> stack trace capture.
> 
> Fix breakage by switching to kprobing urandom_read() function.
> 
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
