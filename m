Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D202530CCE
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 12:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiEWKWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 06:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiEWKWT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 06:22:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120321C109
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 03:22:17 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=hZy575PyI2XfOt6BhISe3C6tGQRDbacri0vOIvy31pxe+wVa2BY2p+QsmCecFEwo/aEcEdOEf4bKPjD+E/kIxeRmlHGkMDoOE8PLYynmGqV0rsaTB+dt/ORKfNGhRp8YRTXsfq51sI4LUi7emd7na9unsEi+55SGF7kj8tDYxfZTn9LPWkpFZ38Z9c+hFu/VmbRKC4orhAruHqzCfV2FdfXGReff54d0Yhv0rwu66UIlMbP/ma+6n3U580c1Rc8wKf/sFyECMcvRYshg65LbHmwlRkDiMxHUtMW65yg8+oENcJ7xyN9oO4MpMVs+PRStzCYSXVUweggGYcXFoBiyNg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WTV2pCLITjD/43x3GzQiqONzDGE6VxrzUgUywr0SIk=;
 b=HcasAoLw6LQQML7M1s7RnXYO8qPBrzwvkv1cM8nj9gywGosUXTUHSl1BhOCBDApXPETu7HYhXHw8ikHqh0er1egRSxmsYSRTPBBKZW1ZTr84L2sHiRqfGWYcRcOq++wdhZwgo05QvNXAi8q9WKTw/eG7g+uGb1YWJ9Pag9tiDZyMhhTkYLQ5+0KRk51po8OH8PfNKFYCywecuFtBgDjeqbyDPOpfjbrGKqZQ4b0ILvssqKzifJaH17TcVbg/T15NhgUTDaMfvdjP4c7ArbgCGQn9xnB/B7BCJ5lTFjly6K15w+8xhR2qRzUx/7wZeOC306P9jj/CWt1NwESpO1L/Ww==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WTV2pCLITjD/43x3GzQiqONzDGE6VxrzUgUywr0SIk=;
 b=GbcWBCxXaj6eZDic055FWFgJ90L4LbbF7aOYAEC+UR7VX+Ey0ifGdayNDqHyYWuD/6prk21O2LKz4cKMgNVnsZ5qZLVb7PZMkct+a2Hk5cBxFGntDYaPZPtGUp0exAlkZKCu0XWuFmW6e2J9FRjfNHI0czG46JpuLYs1Nx7eudc=
Received: from AM6P191CA0091.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::32)
 by DB8PR08MB5115.eurprd08.prod.outlook.com (2603:10a6:10:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 10:22:13 +0000
Received: from AM5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8a:cafe::c7) by AM6P191CA0091.outlook.office365.com
 (2603:10a6:209:8a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Mon, 23 May 2022 10:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT053.mail.protection.outlook.com (10.152.16.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 10:22:13 +0000
Received: ("Tessian outbound 42cead292588:v119"); Mon, 23 May 2022 10:22:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 26ea488542f0f9b2
X-CR-MTA-TID: 64aa7808
Received: from 0f6e9dfecd76.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0869A909-2E1C-40AC-B400-2688923947C3.1;
        Mon, 23 May 2022 10:22:07 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0f6e9dfecd76.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 23 May 2022 10:22:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpTwqROPwmKhnqoZJeiYn+FfaA4KDPGnWD8PlJ1qbaOzAXfYQkwsRFNNTGG4IsCkmZRKAj9HuSAQkpR2S9LTtUE8s+Uw65YqWIds7lzzDWKL4nUANgmznCJAk/nDJGNVD/qm4gdIsGtXM7Mf5czG3dnHnnEHdH28kl3D540zfkSdkQ1SK7B6zYmc0RRlZK5Ng9bhGN3W5r8+gJMnT64l0P+5M1BauOxAUNp4vaH/V4bo1KzxTNs0a4QM8VvLgwaRZE5uZ4Ut9RJblqCVLz6zqswyETr7RHxNpBwfpd/HZZqWl1OO0aKuY6yu3+droEQsnM/FXhlV0QedVIGFPL3YBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WTV2pCLITjD/43x3GzQiqONzDGE6VxrzUgUywr0SIk=;
 b=eZGMyKYU/D3KWii3IrBnpCNtmEROdFmmGN7rwbhZRGwnYeRmiJq11J0JWvZ2O6tUUTdg27ehGjunkm+XpLZRhrT9EdYTB682kPlGaOHR8wO4VX2UWEaOt4UUcgvLOHUCELedA35yRN2aQJXCYX2y3W9gfuK6sAZebgg43txODLjjS0ykLkg69eAJ4v/SHVWY4Poqc00Zub0DYJiIBqmzs1LNaocpp+bL5JdyRS8pmIHslAD6vqBakRu+7zUZ30KqHaEfrmjpz5IMoKVtjvquqiSfl8qJjJsW+VIzUgXVWDP7a30IHAutCJsCJr3bE/Vmqdl4dlOYBrgniycEQqGBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WTV2pCLITjD/43x3GzQiqONzDGE6VxrzUgUywr0SIk=;
 b=GbcWBCxXaj6eZDic055FWFgJ90L4LbbF7aOYAEC+UR7VX+Ey0ifGdayNDqHyYWuD/6prk21O2LKz4cKMgNVnsZ5qZLVb7PZMkct+a2Hk5cBxFGntDYaPZPtGUp0exAlkZKCu0XWuFmW6e2J9FRjfNHI0czG46JpuLYs1Nx7eudc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6714.eurprd08.prod.outlook.com (2603:10a6:10:2a4::18)
 by AS8PR08MB8062.eurprd08.prod.outlook.com (2603:10a6:20b:54b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 10:22:04 +0000
Received: from DB9PR08MB6714.eurprd08.prod.outlook.com
 ([fe80::b934:6f6e:b15c:cb76]) by DB9PR08MB6714.eurprd08.prod.outlook.com
 ([fe80::b934:6f6e:b15c:cb76%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 10:22:03 +0000
Message-ID: <d820884b-5dec-7bc9-9e6c-0eb74803bd5c@arm.com>
Date:   Mon, 23 May 2022 11:22:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] libbpf: Fix determine_ptr_size() guessing
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     beata.michalska@arm.com
References: <20220520153851.2873337-1-douglas.raillard@arm.com>
 <6b714495-aa3e-8d46-5eb2-041968d26fae@fb.com>
From:   Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <6b714495-aa3e-8d46-5eb2-041968d26fae@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0476.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::32) To DB9PR08MB6714.eurprd08.prod.outlook.com
 (2603:10a6:10:2a4::18)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f9bd95a4-9797-4c42-af41-08da3ca61a7c
X-MS-TrafficTypeDiagnostic: AS8PR08MB8062:EE_|AM5EUR03FT053:EE_|DB8PR08MB5115:EE_
X-Microsoft-Antispam-PRVS: <DB8PR08MB5115AEFBFCBAC2DCE2300DFE8FD49@DB8PR08MB5115.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UO/ZzlrquOeVjc/jWo1C3yzeYpghEOzqwwlgiUHwXyQOIFlbDJDAGcvK/ts8rLUan3860TuU3WVQXhg4aex/E2O2jRuQ2TI42X5T8l6dePjnsDWGx/NoJwCbUCUpM5Ifc7FZ9Et4AtTo/B0Dr1QDroDp3b4ey9Z1B4zqO+DxqxiXhR4P/enY8IqpuasqM9YaRSIh1tcSYOB9dnMmtRXqXS26qPNaJy0OAiyfkPzR1vwnyBMnwbLByoavs8OzINqXsLRSfZHImYL4pX1j8WKsnh6pEmPfoJz6JRjYl60YGgtXXrOBGSVfl5O/PFeG86mSqsjSw44/hTSUmxuYzRIf3xBHl3SX202mo8rBiaDEhD3PLp4cVcE9rEllW8mt8+ONwXr4dLHQQp5bsSjgR6lpM14pV67D2b5Glf7/0QOcdZKH/3nW3jxGdG8VW3r2yPrei1ZshTdRY/bhHU37RWAFDJmdfjD2B8XgB4ILrHe+YasaD4LLzEzn5rf+nZ63mxKuywYPmdJtq9omN+KIpiH9APhsOuQrLO5qf1pnXoIclwTe81H6tuMbj5cJ+ZQsyGFb0KZC1vJFKN5yCH/xC0NZwxHaWMVpJ43tmjhRYQZr2RZWmwvbaSigpedKwCwxIpMPpvHjw8LXBYupzXPDMAph6y0vLKVS0oVNBIgJL9DQAC+4z153QJWqL60HMc/CIW1uQswHfY6Zr+NC5V+OuI7+xNAuAr/8wTK/FjBwdysXDEg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6714.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(83380400001)(26005)(8936002)(6666004)(2906002)(6506007)(38100700002)(5660300002)(4326008)(8676002)(53546011)(66556008)(66946007)(31696002)(66476007)(6512007)(36756003)(316002)(31686004)(86362001)(6486002)(508600001)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8062
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 39b953c4-b97f-4f42-2303-08da3ca614aa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRv73I6NKPPQt8HcfZN+TDMWx86wmVa1NGbRWzMNMqN3G7a2Ko83di3uNLaqHS8LwdKcxSQ6XNH/9SlIqNcA05055AgG/ETqhqfvTx9KKaUX+Fb8nfgkjhuanxD4x2k/UfMj28KxVYQV7/rllpWnPOsVBZsubeCQav4bICHWsiL3ah3jJZikgd8Hz0hr2MK6rvkv4TTSRMMAE06PJ/M3Plo86BFVhNDMy3gflMVsL6cx3AicKMWojlRwfBHLtumvAQi2azoIeRFLBnu9afMWzg5XbgiPXJs3APIRGU2jNCFmbKLBNgwHLn41ne0q7Hi9qozh/XQ3XYKPhjuV6x2D3Zzvf0k+GjaEM/ywbXJc4anAGsbPB1gjVRy/aN4SiYafR3Hj2dQWogi4juqbo9HjxKkZ00a2xs2HHJ0RirtG7QyD0bv9B6xUqALL1EMWSuTOuj+EfJ3v5ATV7ZwPZSc41D5nZkVwdvHs1uQeQKUJ8x/TaqmaotqWm/xjdv6Un4YxfX5foEWu7QATJIPhDu6DCACQNhbmDhpETlKhQHHcLkY7GNZZzzC2FzMHxQdvlWt2MfAmqEyck8fix5X6sdGIVRwIp5VamzTZi3hW3l9tcN4g8RiLvQQum5MVnp3NLyPu9H4Mj41D5GTfVsY8Tc6s99JIYyr9pJhFiY0SKKqNhl3CxDfFYEHvETDKV9hQXVV1iFHPSSfq1BX1BELXdkaO/g==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(4326008)(40460700003)(44832011)(2616005)(70586007)(70206006)(508600001)(356005)(86362001)(316002)(5660300002)(6486002)(8676002)(6666004)(31696002)(6512007)(6506007)(53546011)(82310400005)(8936002)(31686004)(2906002)(83380400001)(336012)(36756003)(47076005)(81166007)(36860700001)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 10:22:13.2338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bd95a4-9797-4c42-af41-08da3ca61a7c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5115
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong,

On 5/20/22 20:19, Yonghong Song wrote:
>
>
> On 5/20/22 8:38 AM, Douglas RAILLARD wrote:
>> From: Douglas Raillard <douglas.raillard@arm.com>
>>
>> One strategy employed by libbpf to guess the pointer size is by finding
>> the size of "unsigned long" type. This is achieved by looking for a type
>> of with the expected name and checking its size.
>>
>> Unfortunately, the C syntax is friendlier to humans than to computers
>> as there is some variety in how such a type can be named. Specifically,
>> gcc and clang do not use the same name in debug info.
>
> Yes, this is indeed the case.
>
>>
>> Lookup all the names for such a type so that libbpf can hope to find the
>> information it wants.
>>
>> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
>
> LGTM with some comments and needed change below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
>> ---
>>   tools/lib/bpf/btf.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 1383e26c5d1f..ce05e4b1febd 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -489,8 +489,18 @@ static int determine_ptr_size(const struct btf *btf=
)
>>           if (!name)
>>               continue;
>> -        if (strcmp(name, "long int") =3D=3D 0 ||
>> -            strcmp(name, "long unsigned int") =3D=3D 0) {
>> +        if (
>> +            strcmp(name, "long int") =3D=3D 0 ||
>> +            strcmp(name, "int long") =3D=3D 0 ||
>> +            strcmp(name, "unsigned long") =3D=3D 0 ||
>> +            strcmp(name, "long unsigned") =3D=3D 0 ||
>> +            strcmp(name, "unsigned long int") =3D=3D 0 ||
>> +            strcmp(name, "unsigned int long") =3D=3D 0 ||
>> +            strcmp(name, "long unsigned int") =3D=3D 0 ||
>> +            strcmp(name, "long int unsigned") =3D=3D 0 ||
>> +            strcmp(name, "int unsigned long") =3D=3D 0 ||
>> +            strcmp(name, "int long unsigned") =3D=3D 0
>
> Please add "long" as well. For "long t" declaration, clang generates
> the following dwarf:

Good catch, I missed this one thanks.

>
> 0x00000029:   DW_TAG_base_type
>                  DW_AT_name      ("long")
>                  DW_AT_encoding  (DW_ATE_signed)
>                  DW_AT_byte_size (0x08)
>
> If the type name can be sorted with words, we only need
> to compare the following 4 instead of 11
>    "long"
>    "int long"
>    "long unsigned"
>    "int long unsigned"
>
> But I don't know whether we have an existing function
> to do word sorting or not.

I could not find anything and was thinking it's probably more hassle than i=
t's worth but if
we really want that I could add it somewhere.

>
>> +        ) {
>>               if (t->size !=3D 4 && t->size !=3D 8)
>>                   continue;
>>               return t->size;


Thanks,

Douglas
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
