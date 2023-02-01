Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1F6867D4
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 15:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjBAOAl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 09:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjBAOAZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 09:00:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA9915C80
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 06:00:04 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311CXiTh020876;
        Wed, 1 Feb 2023 13:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uDZp5NrqxOSbaXBywC9mfRPwYulyXvCC894tC9ht5gM=;
 b=GN1ZTecv/kXiQyDprrGRVZJvdRJd6Yrhs21kyl/JB7qF48J7ctV5Col3oys0Z4+FTu5I
 EEnL0QwiVuUekzmD8p6zh9yo4pXgHNIR9UyNr1qR1goNTHqkvE1NmQmZhdir6VHRDDyr
 5+/UegvGVRAaxpS5nX8sqo49Rj8jmDo4Gfdt3RtZKg0dnTdDK8pLcw3Of9ubImCZSkVR
 Q+2M8AtV0zXGtWiCp6ShbSEFK7W+9pC+Au2WXL4W/aBy3Q4wrse4ua2/zOPSi5wQa9mF
 5iFq+98jFprECBklSDFKJpVHtdojbER+nA1NFfVHXRewaldfrHJUaqJYm1b5ZhqkFBg2 Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq4hg90n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 13:59:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311D2SUh003553;
        Wed, 1 Feb 2023 13:59:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5em644-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 13:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhvN/lRFMRtIxnCnTlHSog+e1aiL80UM//9citWPFDwepJFjcROOEROapCe1ND+yFihCbzqriFuFRqYI2lUn+wkV83x/Dx7Fkm9V7+t6W9RQtUQmAUhDzA7spWypPLBeyOkxTu+fnmLF55A2tisPjTNb1g2ANiwpUbWgW9Hx9NC9yj1ePXLqbzRztXIEma0kb38POEjdP6AE5Q8e8kba0tc7Jk4juJblW5Wzzn2z7xKUkRhD+kFu1ISBZKRdGmgX60QTBSlD8DZbOARKC2jeJGijHK2KWnYTgMJ1NPgu/JuFRYWNcSFB3v4HmKe4tUTmm9KpZktNSRuhXEK5iW0ijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDZp5NrqxOSbaXBywC9mfRPwYulyXvCC894tC9ht5gM=;
 b=K5lT2tnzaZB1oUU1Q1xNilLHSb7O7H3KU0xMwqsyKzcgo5M9ylQcFaz2N0+QT4LGgtISQ+0moPed3TqTTedeGEsTEQNgNpN4KV+0hglqNKJRsFZcN4hMsg1Dcotd8GJ8WVUNf5l4nO2E9Fi4+4I81SfGa8c8QuCdwtvAZZHi9uIErXv7JayfO2ie3JqtEhei2C+XR4+csz7E7FaZ4D5RlROOI9yvNjprQsKg+A23uVsDHj19zscvVirNQX5rG9eLZLQdl4Dc2XDJKxM7gY6gT8v0nQ3KoJi0zCOERUKhHfIu6wYcP4nqCLkZMm1uckNuucp6TRVMa+bRBfKfgQbAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDZp5NrqxOSbaXBywC9mfRPwYulyXvCC894tC9ht5gM=;
 b=woblNIM2ZSS8w0kUa77whGEe0dGWbbAWWAIkjwEONjlP/R39qogUQd8PNerRam5elYjM4UmfrcbKowoeHR/5DaX6K7kgqHBLAZ+Dzlz9pecgTwmCQ8MFSb9Sy8NX4J1vomhA27MeXCV7bSxGI/jKDd+fEXZye6jou1kEmItwNRk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH2PR10MB4245.namprd10.prod.outlook.com (2603:10b6:610:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 1 Feb
 2023 13:59:40 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 13:59:40 +0000
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     David Vernet <void@manifault.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Eddy Z <eddyz87@gmail.com>,
        sinquersw@gmail.com, Timo Beckers <timo@incline.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <Y9gnQSUvJQ6WRx8y@kernel.org>
 <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
 <Y9hf7cgqt6BHt2dH@kernel.org> <Y9hpD0un8d/b+Hb+@kernel.org>
 <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
 <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
 <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
 <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
 <Y9mrQkfRFfCNuf+v@maniforge>
 <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
 <Y9nWR7mNGeGCDLYz@maniforge>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <9c330c78-e668-fa4c-e0ab-52aa445ccc00@oracle.com>
Date:   Wed, 1 Feb 2023 13:59:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y9nWR7mNGeGCDLYz@maniforge>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0133.eurprd07.prod.outlook.com
 (2603:10a6:207:8::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH2PR10MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f100244-13da-419f-d716-08db045c8e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZWY3z57LYeOl3AKSiMVVLdQc0UD7RmasykiUtkT/EVWeyB65T9DqaQzmr5gi7DWxisAiZrAwwv+Hk9uzecoulkbiBQyoBMwCHp6H+SjT0LpK+unVRe79Ji9dhRwTkJMfn5uiWSKgMS5F3TfQQ0Blvlay2c/W2C6y2ZIqy5y0fOP0Zkn9oaRA2rrly8wURFq4WAhi7bP02r9MOPeResAOuCgcsQvewdwrPW9nPjY/sSs5TP7ZnA8aya7ONddnHNxfIrZ9xWDIIa3Dy2fom3hLwyLvnVN+JY1dXWXv0/G3T7MI5hSlKOKj3h0853Y4CVFhbX5h0B+QewxDnC7U07UAXwxnL4cHxSO1PwmunRAnxfxkVf8psNHetBtjNGe124wTkC3+C1vqXMJT4FN7ypvH/7eON3YZASf2a+FkBrr8HhRJ3xGzkFbFwnyoKZlA0C9eYAVOeSFHqppXZAOSsh3M90cWeKqmgxvFHu57l47dWXvyS/BQeQeVqG3xk4MS4Aez9OTw5/8lA81ggUW3sUSnTdxA+iFyATuora8E9cQxyVByzPpxWA7MeawTTaGZGYpdhJ8Xss2pb6SJIPv/ZkQadBIkVmjuB6rQW3dX4bDIBNn28rHjnhieyNDHMlCS5QuLdkIBmzUJjBJuAP7ytfvRS449W/aABLzmaRzE7GzcSUF+7YneqhU+qhBpBtCbFIJuYA8qctw5WOyQvPwPLnGUw/q3AQAIa3oOH+SyzvUO9BDJBk8WfIR6FdXIg09jVAOZGnAH/ATKJJ0o+OSHfAiTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199018)(38100700002)(86362001)(31696002)(36756003)(2906002)(110136005)(54906003)(6666004)(966005)(478600001)(6486002)(5660300002)(7416002)(8936002)(44832011)(4326008)(316002)(66946007)(66476007)(66556008)(8676002)(83380400001)(6512007)(41300700001)(186003)(6506007)(53546011)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QllOeExqbmQrMlo5T1RFUWk0UVlTMXhQNUJWSlBpYnljcm4zcUMzNlVpZlU1?=
 =?utf-8?B?Y1VDd2g1bmNVZGduY1BZOVJCeWNndHpkZHFMVkFJaS9QMUN4RmduMXBYMThY?=
 =?utf-8?B?T2FxQjJPeTArMzVNK1ZjV1U2U2RXZ1JYdFlnSTJHekRscmxNclRWdUVuSElJ?=
 =?utf-8?B?dGNnTzRSck8xWWpiWFYyZ1FDSDYvOHhRaXZOcjlsRnNxRjVaVU5NL3hraUE3?=
 =?utf-8?B?MzNaRmQ1eUtQY085ckNzcXZ3RWtIQVlEV3VxZmVKMmtYcGoyWTYvK2pYOE0x?=
 =?utf-8?B?Z0dsMXlQUnRaSjhHVjBUSHEwaWNqbFBnVnlxN3AvNnJqamE3QzdCdjdERVNy?=
 =?utf-8?B?MnBHMy84dVppME56UXRRa3BnSWtTMk5hMFk5c1hDaE1wbXlEaDJBOFJlU1Bh?=
 =?utf-8?B?NHJYbVU5WWhTcU5YN1ptTkNSZzhSTUVlelFPMXBMTjgxY25LVldOMlZRbS9s?=
 =?utf-8?B?RHFXRytpL3A5UWozSzlLV1NnK2tSNVRiNE9PWXhuQlp3QUxPSnQyWkk4V00r?=
 =?utf-8?B?aGRXbjJTeEtWeEhtTmh2NVdrVWIvc2lXViszVUVnbHExbkNNdDA1V1pGMjhU?=
 =?utf-8?B?ZGZ4L1lLU2EyVFVHRnRwc21ORUJEMTdxRUo1T2FoWmNsQlJBWUZNbWFvL3NJ?=
 =?utf-8?B?anpaQjJ6SFRQeXRjcmNpb3JDdGQ4MlIxTXF6RmpRSS9Mc0g0MEd3Z2JvbHc0?=
 =?utf-8?B?TnkwK2M1Tm1CZU4xbTZPTzIzUkFCSVpMY3pJb3BnbmRyM0kwdnkyYi9YdmJC?=
 =?utf-8?B?YmhJWHNjdVowNW90VUdnVFQxanJmcUozbTliSkxFZm5aOGQvWDM3bHFHbDBr?=
 =?utf-8?B?MWN1YWwxaUxLRkNZL0I3UVZMMC9ldHVRTnJSS29JUEhXbnZNaFh1ZFoxbGZ5?=
 =?utf-8?B?dlFFR2tVbi9oSmhPY3NZRzFwTThPVFEwOXpEdkZINDdpSG5KMnBvcHRBbHZp?=
 =?utf-8?B?U0lZOEdFR2RHbXE4aC9ZZU52ZXhjQzQwaGNNTGwxN3pMbzUxY1I5N3FFOWZZ?=
 =?utf-8?B?SFpQQTZyQ0lUaFczQjNucWJHWjVjQWVXNWgwS0xaWmZOeEorQU5Ib0tySHVZ?=
 =?utf-8?B?bkhhcEN3bHIrdnJUS3FBVzczelNCL0dBNXlYY05uTzJ1MmhrODdEUGJaemdr?=
 =?utf-8?B?ODc1ZUF1RVRWT1FlYldLMzAvNVRyVUs0UFplcllGWDd1b0VpdmxXQXRHOHZp?=
 =?utf-8?B?WE56WGRWSkFmVlNMTUxHOXgxOWlaUWRGVkQ2QWRya25nczVQV1YvT0hHTkdH?=
 =?utf-8?B?U1VDQXNzS0xFVHU2SFY2QlVGR1F4UFpNYmJXSXdidmpUczZESXRJeCtwUVRV?=
 =?utf-8?B?VkNINlIzY2lGY1Z2YXpCTExnNTZKUjlQTE5YMjkwcmY5L0tBNmtyeWM2SjdB?=
 =?utf-8?B?K2Q1UVNtYkZmNzEyWVYyeTZPb2F0azZUZWNicWJCOWtGT2NWbXdoQS8zRjNB?=
 =?utf-8?B?K1BBWjBubzJyd0lFYWd3eHZJWHNMYjVyTVRMR0ZLMStGek1sRHZuc0FqNHFQ?=
 =?utf-8?B?UllYRFJvZndCVlZpUTRnbnZQZFdEaUpZRTRTbDFYUmtaenhDQkF4K3ZsVzQr?=
 =?utf-8?B?ZGVzbkZZNi9rNE9tUDVqbVc0dGhjZSs2SXhzb0hvcE1nSmcrTlRwQzk0R0NV?=
 =?utf-8?B?bWMxcTk1WC9pcFZielJycVZrZmFmazE5bFlLUzVaRU1XZDlydERaRi9Zbis0?=
 =?utf-8?B?UlRBN3FYNGtBQmxqMjV0S0w4YmNuN1hIQjlOeTRCc01FRldSY1M1NVoyUml3?=
 =?utf-8?B?OWdYT2FKRkpDWU0xU014MlB0WERtU2VXZi9JUkFPQnRvQ0lwL1I3TXFoNzA1?=
 =?utf-8?B?d3A2RUk3b2RUa0dnaDhvMG9Hc0FzaWhsek9SR2dDeWRnbjQ1Rmp5ZDFQY0Ir?=
 =?utf-8?B?MjdqSU9RbUtqOFJYOEFMN0ZVUnJBWW1TZ0VSeVVLUm11eWovUm9scFZuQlRw?=
 =?utf-8?B?VmZndUR6Z2ROaGZOYjVpUyt3OCtFRkdpN2JFUTFyZmZFQWI3Qk9zUmJZdU9J?=
 =?utf-8?B?VXZQVlk5S0srczhIeUNIVTNnVUdZY2xCNG9GSldSbC9UQTlYRVhidnQxR3RC?=
 =?utf-8?B?VUU4WnM1OWdSU3AwcnZPTUJmeGRZV1BzMnVsVlJuOWEyT0ZwTHJaUGVPOGhs?=
 =?utf-8?B?NjY0NjFwTFd6SHF3NU5Fd0FCWUsrcVcwNDBrS1BXZHczb0NvNEIwOE9XTW9y?=
 =?utf-8?Q?JUJmQqZ8PeZTY78IC9KUEoM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VTljQkV0WXJDOFBlc0ZsdlV1Vi9yTVcyOGQ0NVpvdCtZTU9YSnd5dlg3R1F6?=
 =?utf-8?B?WmJKU2lOdzlYTTU4eWlaSitZL0ZSMVNSMXVoOWxuaTI4a25JZGFlblBhSXdp?=
 =?utf-8?B?QmlvbFZpeTBDZ1RsNGlhQnNaakxublRWTk5OT2hwb0Zaa3NFNTBtM1Q2dFlo?=
 =?utf-8?B?NmJOKzZ5eDFBQTlHbjdWcHdyYVc3bmkzTnVrSGg4cEx1cXByMlkvQlMvaVkx?=
 =?utf-8?B?TlJ1ZG4yTzBJTEIyUDRxbTk2L3RKaVp2SFdTcnRYUlRHUHFPUjZVS2c5RW1s?=
 =?utf-8?B?UUNTMFZXT2hWWENmUTBxTTgzUURSWVlBbHBNNXZPNUdrTDNpc0Fqa1BvdEVM?=
 =?utf-8?B?S0JCMjNSYzIraWoxSlJOZjNTVGI3dENqR2Vqa3l2Q1Y1WWN4ejNzZzBXOW5w?=
 =?utf-8?B?djFJZWxqZUt6MjRxc0V5SjZNQTJNajh3cGNYVEFXWVhyTS9TdVk3ZURlVE5P?=
 =?utf-8?B?dDMxVldydS9QUjJxSm1CSXpxVnAxUEZwQk9nQ09VR242MVVTZXJtejZoelor?=
 =?utf-8?B?NlJ1bUFXMWs4dS9FV0hyUXl3cm5RZ2xGMzhzY0MrbEtPb01GcWVQL3ovckNo?=
 =?utf-8?B?MU1xTm50NXQvT29BalZmY1Z6ak1YWGVacTBwRVRmU3lmVVpITnhDRXFKdUZu?=
 =?utf-8?B?ajVDVEZDbU9INHlVcklIU3dDMHdUUjRReGlFdW1wK29CbnpJTEVYZW1BenlB?=
 =?utf-8?B?YXEvbmk0OTVwdVJaaEtBQXBaREgzUENZOUpaaUdjQ1JrR0UvQ3FHNmJDd1Zk?=
 =?utf-8?B?RnBOV2lwMldFaHNxZFRCVHV3ek9LQ3hSckNPbnhoS0EwdzFXUitPSDM3aGNz?=
 =?utf-8?B?WFZoM2ljMVI4UCt0NWNxdDZkbkd3MVZ3Zm5VNmFQZHRJenBMU1lvU0VQQzc0?=
 =?utf-8?B?U043Yk5BbjNRT2tZSjJBQjcwMHJWNUJCTk02T3R0WDFPdTRQYjlNeEM4SXNR?=
 =?utf-8?B?WXBGQnpsWFBNdVkyUWVCL0x0eThhR204ZXkzazNjNjZKR2hNVTUwZnZHNDV1?=
 =?utf-8?B?TG9BcGo3Yk5Ncm4yeHNvRi9oc2ltSEM1V2NVMlovZncvUmUxcnV0R2JhNkt6?=
 =?utf-8?B?bXM4b0VFY0FpRzgwdStxS2tobzZRWUx2RWZRdUVTOGZ5Z1hkclBTYi9kUzZj?=
 =?utf-8?B?dUpKbGhzY2Z6RFFERlB0SGFTdVAwemNtYS93T3JlYjVBakI4RVNBNVdZSStu?=
 =?utf-8?B?cHp0M2FHb2FOQ3J1MlljeWR1ZFZNR3NOclIrSmp1YjFadFdXZ1FaQ2ZTMDJY?=
 =?utf-8?B?NmNxaDFaVzIxMUZ6THJ4RkFDNFBIOFpTNXI5dEZGYk1POVYybi9zWkNGNjJy?=
 =?utf-8?Q?Sgg+IvY5CVYhdEkg9+jD2IpQ/e+184OGl8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f100244-13da-419f-d716-08db045c8e40
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 13:59:38.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 698KA7tMdzG3HKnKXGFJDHvHPv4aSlX30g6fx9R1n8dq2lVSzF8bSGKI58gSgqcaUBCVv7K5qE/dEMn8QFe7EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010120
X-Proofpoint-GUID: 25uVe87tqRUQ8SoOerfKJTo8GcW7binD
X-Proofpoint-ORIG-GUID: 25uVe87tqRUQ8SoOerfKJTo8GcW7binD
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/02/2023 03:02, David Vernet wrote:
> On Tue, Jan 31, 2023 at 04:14:13PM -0800, Alexei Starovoitov wrote:
>> On Tue, Jan 31, 2023 at 3:59 PM David Vernet <void@manifault.com> wrote:
>>>
>>> On Tue, Jan 31, 2023 at 11:45:29PM +0000, Alan Maguire wrote:
>>>> On 31/01/2023 18:16, Alexei Starovoitov wrote:
>>>>> On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>
>>>>>>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
>>>>>>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
>>>>>>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
>>>>>>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>>>>>>>> +++ b/dwarves.h
>>>>>>>>>>>> @@ -262,6 +262,7 @@ struct cu {
>>>>>>>>>>>>   uint8_t          has_addr_info:1;
>>>>>>>>>>>>   uint8_t          uses_global_strings:1;
>>>>>>>>>>>>   uint8_t          little_endian:1;
>>>>>>>>>>>> + uint8_t          nr_register_params;
>>>>>>>>>>>>   uint16_t         language;
>>>>>>>>>>>>   unsigned long    nr_inline_expansions;
>>>>>>>>>>>>   size_t           size_inline_expansions;
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Thanks for this, never thought of cross-builds to be honest!
>>>>>>>>>
>>>>>>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
>>>>>>>>>> into one small thing on one system; turns out EM_RISCV isn't
>>>>>>>>>> defined if using a very old elf.h; below works around this
>>>>>>>>>> (dwarves otherwise builds fine on this system).
>>>>>>>>>
>>>>>>>>> Ok, will add it and will test with containers for older distros too.
>>>>>>>>
>>>>>>>> Its on the 'next' branch, so that it gets tested in the libbpf github
>>>>>>>> repo at:
>>>>>>>>
>>>>>>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
>>>>>>>>
>>>>>>>> It failed yesterday and today due to problems with the installation of
>>>>>>>> llvm, probably tomorrow it'll be back working as I saw some
>>>>>>>> notifications floating by.
>>>>>>>>
>>>>>>>> I added the conditional EM_RISCV definition as well as removed the dup
>>>>>>>> iterator that Jiri noticed.
>>>>>>>>
>>>>>>>
>>>>>>> Thanks again Arnaldo! I've hit an issue with this series in
>>>>>>> BTF encoding of kfuncs; specifically we see some kfuncs missing
>>>>>>> from the BTF representation, and as a result:
>>>>>>>
>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
>>>>>>>
>>>>>>> Not sure why I didn't notice this previously.
>>>>>>>
>>>>>>> The problem is the DWARF - and therefore BTF - generated for a function like
>>>>>>>
>>>>>>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>>>>>> {
>>>>>>>         return -EOPNOTSUPP;
>>>>>>> }
>>>>>>>
>>>>>>> looks like this:
>>>>>>>
>>>>>>>    <8af83a2>   DW_AT_external    : 1
>>>>>>>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
>>>>>>>     <8af83a6>   DW_AT_decl_file   : 5
>>>>>>>     <8af83a7>   DW_AT_decl_line   : 737
>>>>>>>     <8af83a9>   DW_AT_decl_column : 5
>>>>>>>     <8af83aa>   DW_AT_prototyped  : 1
>>>>>>>     <8af83aa>   DW_AT_type        : <0x8ad8547>
>>>>>>>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
>>>>>>>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
>>>>>>>     <8af83b3>   DW_AT_name        : ctx
>>>>>>>     <8af83b7>   DW_AT_decl_file   : 5
>>>>>>>     <8af83b8>   DW_AT_decl_line   : 737
>>>>>>>     <8af83ba>   DW_AT_decl_column : 51
>>>>>>>     <8af83bb>   DW_AT_type        : <0x8af421d>
>>>>>>>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
>>>>>>>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
>>>>>>>     <8af83c4>   DW_AT_decl_file   : 5
>>>>>>>     <8af83c5>   DW_AT_decl_line   : 737
>>>>>>>     <8af83c7>   DW_AT_decl_column : 61
>>>>>>>     <8af83c8>   DW_AT_type        : <0x8adc424>
>>>>>>>
>>>>>>> ...and because there are no further abstract origin references
>>>>>>> with location information either, we classify it as lacking
>>>>>>> locations for (some of) the parameters, and as a result
>>>>>>> we skip BTF encoding. We can work around that by doing this:
>>>>>>>
>>>>>>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>>>>>
>>>>>> replied in the other thread. This attr is broken and discouraged by gcc.
>>>>>>
>>>>>> For kfuncs where aregs are unused, please try __used and __may_unused
>>>>>> applied to arguments.
>>>>>> If that won't work, please add barrier_var(arg) to the body of kfunc
>>>>>> the way we do in selftests.
>>>>>
>>>>> There is also
>>>>> # define __visible __attribute__((__externally_visible__))
>>>>> that probably fits the best here.
>>>>>
>>>>
>>>> testing thus for seems to show that for x86_64, David's series
>>>> (using __used noinline in the BPF_KFUNC() wrapper and extended
>>>> to cover recently-arrived kfuncs like cpumask) is sufficient
>>>> to avoid resolve_btfids warnings.
>>>
>>> Nice. Alexei -- lmk how you want to proceed. I think using the
>>> __bpf_kfunc macro in the short term (with __used and noinline) is
>>> probably the least controversial way to unblock this, but am open to
>>> other suggestions.
>>
>> Sounds good to me, but sounds like __used and noinline are not
>> enough to address the issues on aarch64?
> 
> Indeed, we'll have to make sure that's also addressed. Alan -- did you
> try Alexei's suggestion to use __weak? Does that fix the issue for
> aarch64? I'm still confused as to why it's only complaining for a small
> subset of kfuncs, which include those that have external linkage.
> 

I finally got to the bottom of the aarch64 issues; there was a 1-line bug
in the changes I made to the DWARF handling code which leads to BTF generation;
it was excluding a bunch of functions incorrectly, marking them as optimized out.
The fix is:

diff --git a/dwarf_loader.c b/dwarf_loader.c
index dba2d37..8364e17 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1074,7 +1074,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
                        Dwarf_Op *expr = loc.expr;
 
                        switch (expr->atom) {
-                       case DW_OP_reg1 ... DW_OP_reg31:
+                       case DW_OP_reg0 ... DW_OP_reg31:
                        case DW_OP_breg0 ... DW_OP_breg31:
                                break;
                        default:

..and because reg0 is the first parameter for aarch64, we were
incorrectly landing in the "default:" of the switch statement
and marking a bunch of functions as optimized out
because we thought the first argument was. Sorry about this,
and thanks for all the suggestions!

Arnaldo, will I send a v3 series incorporating the above fix
to patch 1?

With this fix in place, prefixing the kfunc functions with

__used noinline

...did the trick to ensure kfuncs were not excluded on x86_64
and aarch64.

>>
>>> Yeah, I tend to think we should try to avoid using hidden / visible
>>> attributes given that (to my knowledge) they're really more meant for
>>> controlling whether a symbol is exported from a shared object rather
>>> than controlling what the compiler is doing when it creates the
>>> compilation unit. One could imagine that in an LTO build, the compiler
>>> would still optimize the function regardless of its visibility for that
>>> reason, though it's possible I don't have the full picture.
>>
>> __visible is specifically done to prevent optimization of
>> functions that are externally visible. That should address LTO concerns.
>> We haven't seen LTO messing up anything. Just something to keep in mind.
> 
> Ah, fair enough. I was conflating that with the visibility("...")
> attribute. As you pointed out, __visible is something else entirely, and
> is meant to avoid possible issues with LTO.
> 
> One other option we could consider is enforcing that kfuncs must have
> global linkage and can't be static. If we did that, it seems like
> __visible would be a viable option. Though we'd have to verify that it
> addresses the issue w/ aarch64.
> 
