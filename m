Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C0A6B7F4F
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 18:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCMRVc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCMRVQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 13:21:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE6830F4
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 10:20:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DGY2WF025114;
        Mon, 13 Mar 2023 17:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/N1SDLnpgeLtXFMnTr6pPpnmx1pv3h6Wx0H5Pdarvjk=;
 b=h4LMv2sBB9b79NdnQi/pCVEv6RPITCzbhyMT1w63sHrboIjQwb5a4CU4DAnhiooEbt/8
 aAw+oT0Q1f/Qg+VEIQ+uPsmm18cSVWF7hSm+aRRMPbZE5t7k8Qquv3gJte+Sv65U9vMI
 3yToo6iKUf0q04M2qM5uSdqHb82FjyCWD5epttfH8zItRF7LhNDAae/pIzKKseD2o5oA
 TsYg+payG/+mXnZaR5g04laoHXUrSmNfyNIw8WEElnoT3D23xnu4LNZY9owgH5kstZQU
 gPipjaA4viwv0haEhJ5Zr/Bd5O3frMySDBAAXgVJBXk3d1cu+7Mqat5CpCMLCsnfGGbx tQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8g2dmdhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 17:18:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32DFumIs008259;
        Mon, 13 Mar 2023 17:18:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34y4m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 17:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4m+Pv4SEuv9bajElOw0lBOdkHX1d+bL2EPL9HpvAw9wEsLNgO2C2Xs7QB1vFT4vCxs8fKHkLewiBq+o9Mqyu0PhNcLOt9hspqNs+h4vcZb+g2RRuYQ3Q+9tp1mE4RceuphLokh1hYv9iG4dk3Jw9T4RdMnG59pNerrmv1uWx7zja1hdrq5NEv42Cja4YoPSSvSOAYBodl3Lon5MMOBn08S6IDJDvIudSf2OoV7HJroHHUpuXpTnu+cADCzP2g5WvniTizgme387z5iXLDXERbMbbGSm3gM1tQ/hbSABPohOBXtKFAgPYi5r69q+0mZbcbDBvy3/uH0gSyYa5/822Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N1SDLnpgeLtXFMnTr6pPpnmx1pv3h6Wx0H5Pdarvjk=;
 b=baD/069ay0bZioI4T35yehO1hRxg2Gun7DW205QN3nuMHm67d5j2SjPTgesyu2LqbuaZJzs32UWAuqUFxBNJmEym63Ouduiz8GuPgxZXB2YirzR86NIqjQUqifGG6Aj6R6XXH7sHWsKs5SlV2SBJWbnYJ62AcsVNQbEuh9m2PEPesdZjG++2gRLgQx9pdCI48YW9dUmX3y363TWp0ptz4rWg8cPoNRUbjdozdoHJxDnnbG+YTgfeNylFHQgcY3q8jsRcuqktroSAxHgbrWnziMi/Jo7Q2TsA5jk74wM4OAxxXXt7r4ekvKYwGCqRBXANHGQnfkFKcqpuQ8thJb4U+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N1SDLnpgeLtXFMnTr6pPpnmx1pv3h6Wx0H5Pdarvjk=;
 b=LCxiUoxQ1v7k8UttTUjcp2VY7R9caaP2kjVpyTbxc7lDBl4llyQCRzfAFgZLuYlMKN4gcS87FZPlO+vRCFxm2gfXo/0btmywfjDWq+sp1pXKFYKjwOGCegiaOT2+w28v5TkMGA/+dJAUAvXLb5O8YkoHtTzxvQwLR0XKBkTP6Uc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN7PR10MB6476.namprd10.prod.outlook.com (2603:10b6:806:2a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 17:18:34 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1c91:fd13:5b72:4be6]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1c91:fd13:5b72:4be6%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 17:18:34 +0000
Subject: Re: [PATCH dwarves 2/3] dwarves_fprintf: support skipping modifier
To:     Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
        kpsingh@chromium.org, sinquersw@gmail.com, martin.lau@kernel.org,
        songliubraving@fb.com, sdf@google.com, timo@incline.eu, yhs@fb.com,
        bpf@vger.kernel.org
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
 <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
 <87964239858beb2fe8e2d625953a3606161c85b3.camel@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <1d545a22-05ff-5a4d-e7bf-8cce08709c84@oracle.com>
Date:   Mon, 13 Mar 2023 17:18:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <87964239858beb2fe8e2d625953a3606161c85b3.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0068.eurprd03.prod.outlook.com
 (2603:10a6:207:5::26) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SN7PR10MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: af5b2951-ea00-46c0-c6e7-08db23e6f97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmzscZTx6S5mGOIW6wpkrBzUb01B9edr+0y81X19sFcPav9krdVRUEBL++q4EhLXxhIUqgg7ShFnY9zTA3i2Ue5HDPO6I5ZCfftqpGduGXFWPiNmPn1nFj/KUPvKqVvWq2Juri7z0Lod4Ww9RJTkyRIMSEN934+OaK8FoYT6j2TvtFy1HqSsoCdfYxaspv6IU0PalLGK+a7qIYocZTrsdlfWczoP5BJRib/FeYRHyEYR6VLV4kHvegHSc4xDOCz7whI2hnt1J26naHk3fQsm4OheNfKVkcRqedNg7Y1LYtpaNNL2bgVex/I/Gq8QDwiN8aRsRyvnAPWztr7FIwXj7LmSxOQ1hSOhqZEK9Ak/XjToczv/Geva6AS2X2sIRsnxe1LyJ6u2HSyJKw7juo6s1EnYXGbXoDOO/n9tZqxw2Nhvfpz3kDpL00UEXQvb/ukz9Lqq6HMsftGYBX3lttsQ6ZZ+G9kyBeUu+yolFQcN7cCGx1t8jYgmOwXO1vRnQ6Tuz4AGpgQJAiDYMDWDhRtOSCKGhIvVYU3PZe/m0dmahhkrG/76xYhz3BPryWyJS6elBgX0YB/SXEshkx6RyfYyKYYqWF2CLveENoKedAxtDA9v6i3E5/V8m2GyD88DIbw7yyexxW6wuYpj8s9wzDXRwmKZJrdQewZdlMubbPbLf6Ouwdm0c/IjNOek3q5G03+KsKjn1IuWdam98wYTlU21vKbdz1p7k2a9yb+3nUwlWHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199018)(7416002)(36756003)(44832011)(5660300002)(186003)(478600001)(6512007)(6666004)(6506007)(6486002)(53546011)(2616005)(4326008)(66946007)(8676002)(66556008)(66476007)(8936002)(41300700001)(86362001)(31696002)(38100700002)(316002)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDVTaHBYaUpjTUF0c0ZzMzRyUTkyWTlHVE9OS3lZL016d01vSUIrNFhJaHdq?=
 =?utf-8?B?a3NtcmZKdzhKakpWdWZRTy9oRWtpZ0U3Rk80M2JJOFNCYkRDQVgzd2hMaGhk?=
 =?utf-8?B?Mjlua1Q2bkFjcDhGNEY0U01MVWxraGlzUk1XQ2xzSlIvczdOMkNRSUhWQWx3?=
 =?utf-8?B?N0hrQWFMai9JZ2ZOaDgvUHRBa3AyRzVTOTl6eU9wUlYrRUlORkVUNmJCenRp?=
 =?utf-8?B?T0RhVkJ1WGl6dnpRajczOFdrb3R3MVVSNjZjODVwUTRTSTFWSVBWRHBCaGZs?=
 =?utf-8?B?UUVCMmhyb0lRUWN5aGN2Tm1Xb0w5YlVWOFFscFR5Z1hvWkN4aXFoTDhOQTk2?=
 =?utf-8?B?akdrMlpwSG9sNUJNSHFacWFiSE0xVGthS3FHbFh2V1NqL3BTaUZDeWJjQmgv?=
 =?utf-8?B?c3pBS01VSUR1ek9UMEM5ajYyVmx0NFhPZzBTWDF0a0hPZUlEM1VJT29Cb1hL?=
 =?utf-8?B?azg5UzBSTklGOFlWSFdydXJLTlNEeXBZRjR0NkxYMC9rRDV1THZTQ1VreXdV?=
 =?utf-8?B?QzhRZzdORlExQUkxUHZaTk0rV3A1eitBYWVYclh0d2tqa1FBODFHREFLVTZO?=
 =?utf-8?B?bG9TQTVBSXhIc2tpS0E4QXBKcEtiQm1SMGxNenRFVmFvWE9QVGJ6b2c1dUp0?=
 =?utf-8?B?b2hyQWFnNlBPdjAxZGFnbXNrbGJ0cXhaYWdiU1YzV2JKT2RFRFNYcU9KZGE1?=
 =?utf-8?B?cmp5S0h3STZlQktzaVVnRW43cmVndCtYSHJwS2pyZGFWbzg0NlR5Y3dLNVhP?=
 =?utf-8?B?NVMrYmJ4QWJwZjYwendybm9wYTIvVHRudUpxWUhDUUlUM0dzZVN2bzlzcmgz?=
 =?utf-8?B?TUZqL2ptanNER3R6eW5RTG5UZzBIUFpINzBsZ2IyeE9xa3ZFcWhnYzNHSElE?=
 =?utf-8?B?a0x3YmJ4bXIxSTd2bDNPOGpBMXV2U3ErZjM5UDFTS0RBR0hkMGE2bklpTGxW?=
 =?utf-8?B?dzBjckE1Nkdic1Z6SFo5WkJnb0xHVzlBU2x5T0RtZDhlOUs4TnViUUpXb2Z4?=
 =?utf-8?B?QlpETzRMKzBCYzd3Wk9HOUFIM1lKVUFEMTlMdDNwOEYyZU0reGRjQTY4OEdj?=
 =?utf-8?B?UDdpUFhyRWxEN2thd2phaytZR2pCSXovQkoveXpENkx5aTdiaU9yOElGYzBw?=
 =?utf-8?B?U0VzWjZLR25vSytvZ1Z6TU0zeUdUMDFTOEcwTEhvVC9EN0ZzRzAwSzNKU3A2?=
 =?utf-8?B?TzZSY25nSHh0N1FmSWIwWDA3eVFMQUsvTG9yREIrWnIxc3JjdHJLK2FFVnF4?=
 =?utf-8?B?dDJ1T1ZPeXNBekhQYmtOakNYTVdmQ1M1UjdzMjFHZTBPOEc5cDcyNmVNdktv?=
 =?utf-8?B?blo2eStsd1hweFgyS2QySzFLQmFjODl6TXNiVG9rdjc1UGJDbGdJWDE0VDZo?=
 =?utf-8?B?RmZXYUExV1J4K2VERXRtOE9ENVdhZGJFdjF0OVUzQllSTUtjTmw1TXNmZGla?=
 =?utf-8?B?Tm5XdEVwaW1ET0NFZE1PUDNnSktUVTFEdE1lVkdBVzNCL3RhcXVzbWtEWndu?=
 =?utf-8?B?LzBnZEkvWENpSElORGoyN09senVCMzRwaENFOXBSVnlvWUNOMWxlWmVZRS8r?=
 =?utf-8?B?c0FZdTBMV0xLQmIwb3lXY0dYNXAyakprYVV1cEFwaFFyaXgybUJiRitTbU5t?=
 =?utf-8?B?NmRLREU4a3JxK3RxNk5YeHBRbjNUNlBuQUZ3VHl1cGN3d0pLUmp4dE4rQlpH?=
 =?utf-8?B?N1NOdWhZT0lQWGJ3K2dhZ0lHRnVzNEZwYlkzUk5sc3lyQmRmdXVsdHR4SmNV?=
 =?utf-8?B?d3lQOCtURFhtS1dWZzZGZWFVWHY4RCtoVlBmSFpsK3QxeXN3RUlJRkphNzRY?=
 =?utf-8?B?MHJpRnNaYXg4OWQzQlZzSlZwdTNxVnAzeVZiVzR6NHY3ZUVlT1pMRzduZ3li?=
 =?utf-8?B?TENvNUhzbGFaaVEwdkpsTDI1OG1wR0E3RUhNNkFoc2lnOGVyeisvenFPMW9E?=
 =?utf-8?B?TUlMWEhZWDdnZy9EbVYrZ1pZQW1jRDlhSkpML2lZMW5wZHhIWFpyQm5Ic0c1?=
 =?utf-8?B?b1pYWDlxNW1XWlBUKzN2bm5VcjBsOHBJVXpTaG9mUW5IOXFzK0FBd3UyMjNY?=
 =?utf-8?B?cGJ1R29jN3UzTmtzU3lWU1JjR29OOHd3cUlib3N0R1pjYkJkWUpKQXhpM0Uz?=
 =?utf-8?B?WnBGdmorc2RHVEpYc0ovbzhJQmtzTklndllzeUIrdVF3RXZkRWd4cUhQMG5L?=
 =?utf-8?Q?VO0mQIyS/TJW/dYP7pav/UQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?LzRNYnZCOFVvVWR3WXJFZFNBWjR4VmpZTVlLdEVFdVJmY01TcUYwbkNpcjRU?=
 =?utf-8?B?bGRhei9Ua3hIWXRhWXdjWW9XRFVzdENIRUk3RTBYZFk3L0ZJcXh1MXpqRm94?=
 =?utf-8?B?MkIxdzEyM0NIVlFqa25NZGdtdC9lalR5T1d3dml1Y2htN2E2QncxcGYrLzRi?=
 =?utf-8?B?bzA0bzFpWFBHczU0Z09MSFRmWXR5Z1Bkc21nclAwZjNzTXJKakM5cVRZMFBQ?=
 =?utf-8?B?QjVIUnlHOU56UlFoaitBblpFQlhkQkhqVGpBMFhKa1dmdUxGdmNydDdIdCsy?=
 =?utf-8?B?QStBNi9GYmhFeStoM2pPUFNpTGVNTXZiQk9kdlNRVkVnQ1hYbjBoSDAxUGFy?=
 =?utf-8?B?YWdTZzg5bDRLT0FzS2paTDRXMXk2ek1xalZlZWJ5dWpGcHJvVWp2RFJnQWJw?=
 =?utf-8?B?K1c3QXE1K253Szc0OUFtdXhhVE5Dd0x0VG5XR1d5Zlpyb0FZWktrSjd6SnNH?=
 =?utf-8?B?OHJpZlVwUmRPQnd2a0p1d0FqM3A4ZnhWL3IvYlluV2xNdzNMZm1HaTRVTWpu?=
 =?utf-8?B?SzcrVTNaUGdVMWQ1V2wrWDU4UExQRHhMcElqR1paR0p1STljUUxWQ2Vycnpl?=
 =?utf-8?B?Z21NZ3NjVm1UT1FxR3doMWNKQ2pUVmJ2ZHRxMUhaZjFVQWZuK1h2cndINnpj?=
 =?utf-8?B?aUcrMisyNmZVMHQ3enF1MVlMb2NhOFdNekpjY1N3RGkxY0Z2azFuWEk4cmVJ?=
 =?utf-8?B?ZmI1cEtJcFdaaEp5aVhzclZLbU41STRMTEp5cUVUMEhiU0lIYWZXeUl2cWpT?=
 =?utf-8?B?UnQ4dS9YZGlVUi83MWNsZ3VBaDF4Wk9Pdk4xUFFVYkJubnY0YVVzUy83Y1hB?=
 =?utf-8?B?bUR6NHdEMkFQRVdCREVFNFIzSHhPWUo1NlVLTlM1Ri9qb2FuNXM0NUhSWFRH?=
 =?utf-8?B?bFBYQ2tkNWsyKzZ4VWpHcDh4QmNGbUJmYU5tYnEycStqdjZXKytSUVlKS1J3?=
 =?utf-8?B?ZnRYRSt6anBLcyt4L0dSLytzVEFhRDdIbjNJMGtISVFyQWlFTUkrekV2c1Zr?=
 =?utf-8?B?NzVpRFF6WWxvOGkzdkZ2cWVlaUxUMjhJcG9EV2M1V3dsOVRKQ3liandaTC9M?=
 =?utf-8?B?MmlMZTJva25XS1BCRjVtRjFTM3VEQlNhdk5DQ3p3U1VBR2hEZjFMbjRkazRs?=
 =?utf-8?B?RmFPUVVMdU5vdlUvRklMSGRYanFKSEh6aW5GUmM3WHNUYTh6SUk4L0RtaytB?=
 =?utf-8?B?d2FxRG1lZG9YdHdjSzY3Q09DR3V4MjIxNkNHVzhzdXlaZktBV2dhd1NYT09w?=
 =?utf-8?B?ekp3VTBFK0VmUzhqU3czREwrUFQyL3Rtc2xqUG9iL3hnejNxQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5b2951-ea00-46c0-c6e7-08db23e6f97a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 17:18:33.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCv/Z3cUsyFdMhONOIwIl7FP5LUEsFn3RBaKSu1inD2nFS2SOri2lGh3Two5rnxO4UE+UV6Q5x4NFd5xhPhc1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_08,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130135
X-Proofpoint-GUID: 98g7G-ZV7KNdIrqHsszjNWf6FcC0G3rm
X-Proofpoint-ORIG-GUID: 98g7G-ZV7KNdIrqHsszjNWf6FcC0G3rm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 13/03/2023 14:45, Eduard Zingerman wrote:
> On Fri, 2023-03-10 at 14:50 +0000, Alan Maguire wrote:
> [...]
>> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
>> index 5c6bf9c..b20a473 100644
>> --- a/dwarves_fprintf.c
>> +++ b/dwarves_fprintf.c
>> @@ -506,7 +506,8 @@ static const char *tag__ptr_name(const struct tag *tag, const struct cu *cu,
>>  				struct tag *next_type = cu__type(cu, type->type);
>>  
>>  				if (next_type && tag__is_pointer(next_type)) {
>> -					const_pointer = "const ";
>> +					if (!conf->skip_emitting_modifier)
>> +						const_pointer = "const ";
>>  					type = next_type;
>>  				}
>>  			}
>> @@ -580,13 +581,16 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
>>  				   *type_str = __tag__name(type, cu, tmpbf,
>>  							   sizeof(tmpbf),
>>  							   pconf);
>> -			switch (tag->tag) {
>> -			case DW_TAG_volatile_type: prefix = "volatile "; break;
>> -			case DW_TAG_const_type:    prefix = "const ";	 break;
>> -			case DW_TAG_restrict_type: suffix = " restrict"; break;
>> -			case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
>> +			if (!conf->skip_emitting_modifier) {
>> +				switch (tag->tag) {
>> +				case DW_TAG_volatile_type: prefix = "volatile "; break;
>> +				case DW_TAG_const_type: prefix = "const"; break;
> 
> Here the space is removed from literal "const " and this results in
> the following output (`pahole -F btf --sort ./vmlinux`):
> 
>     struct ZSTD_inBuffer_s {
>             constvoid  *               src;                  /*     0     8 */
>             ...
>     };
> 

great catch, thanks Eduard! Arnaldo will I send a followup patch for this?

> (Sorry for late replies).
> 
> [...]
> 
