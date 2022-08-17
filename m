Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C77A596B5F
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 10:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiHQI3x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 04:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHQI3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 04:29:51 -0400
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5F70E41;
        Wed, 17 Aug 2022 01:29:49 -0700 (PDT)
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
        by mx07-0057a101.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H6U8LI006869;
        Wed, 17 Aug 2022 10:29:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=message-id : date :
 to : from : subject : content-type : mime-version; s=12052020;
 bh=VdbJezXqG48GaI/UIfvYlnHs8UAyaSMHVoJxjxvnpAQ=;
 b=kfIiBy2vYHNKD2i3woLssdaMmlLoVocssnEWS4Qwq69FjT0ZaVPlbNMgcBi80P7sbF7D
 u4zKEN3NZxkoSjuANnTocLW4CMtPYIGVdkB2zg7eNmzl5gV2cMUgAV6VZwIbBlVe1m9i
 PqwfNlWlD/SGlvaY5x0SiZxm5hUafRxYff0jnPfLLnTRvc/AJrU67fOTMSKQdzkF5c56
 3cWDojjul4NZJCqE9FWvLuGCJTUNXnjKGN9KUfx4PH3gPyvdRo41HHQaeHm1in94f1r+
 NhsaQWToSYbhR1Wt+5cbsncpGaPnX8EfG5Db/W5wU51RT6Ci3WBfdVUdtGfYSW/4ksWJ oA== 
Received: from mail.beijerelectronics.com ([195.67.87.132])
        by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 3hx0abv09g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 10:29:43 +0200
Received: from EX01GLOBAL.beijerelectronics.com (10.101.10.25) by
 EX02GLOBAL.beijerelectronics.com (10.101.10.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17; Wed, 17 Aug 2022 10:29:42 +0200
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.112)
 by EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17 via Frontend Transport; Wed, 17 Aug 2022 10:29:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRK2IdxoGHggG0TfSwKBKUc+I3K6vSZQpFaqzP/t/MYE2NUOGPGWvMTQWqpXIkzwNinqiybc2IMIOTYp1Wa/KyhcOxUlJcdsa7fAouk6XebDPzD+OdKmhTcymnpaZt6rg72bFUX7tzqGbj2peRk4uLGBH1SlpogqrG+yDlDEznLuPevcNRZwh7wrYKkpICh58cQF6fiM5GlK7b3fKj/aW2sknyZ8aamCz8iETNrxWfIszmlEr362bsDy43uRH7hZsmXvbhGZlYQBOBaktFJTqlUVTS5L3tJzNJcHtuHZFUA+Jjva7MpdYbg1JtUz55SgF3kdBsLsUwRayd3fcb3fEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdbJezXqG48GaI/UIfvYlnHs8UAyaSMHVoJxjxvnpAQ=;
 b=Vn4pzOohmLxaadPQFn0paZDxYg63kru2klDHd8EDzQTwTstNMkO9n/sbe86wKIvvNn2F85VOAU9/rd81JPW6karRp3rcDisXK3z4CD0LihDDNvzgIZVldfyTmSWSF6rQzDgse59rKI5akY08QpTXfMR6SKyYBtLDkkyNKr8EXsCwwvGG83IllM/0cncGU0d2Dfs7Ljl5rbQ3mzr11/OU/2gYG7mw/Ybrtd5ZOBt7VeOuVuBy7VKbunBrqG7T8O8rFlUmed9Uiid0xHBDC5F12tmwMoVft3/qad82vj/Frc3URNi22xbyp58Y99DjdY0Yj7L2/mCq1kf7qEsfliIODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdbJezXqG48GaI/UIfvYlnHs8UAyaSMHVoJxjxvnpAQ=;
 b=XUX4lGYGx0BWY1IeuwnjsmZSe6nPhL6WxaU1RUQ18/Hat/d8tHBlhI4D8mTattCNWsBg9mbmGNmpgFwpEOONGy71ByPbvaF/8xIaIa6apBP1Dz9F3nX1tPRR3Z/pnCOY/0Y1RORn0gnsEumtuaxR25jhfl80ECQWaXaYk4Qpds0=
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:296::18)
 by VI1P192MB0510.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 08:29:41 +0000
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::ed47:388a:7a7d:8a1c]) by DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::ed47:388a:7a7d:8a1c%4]) with mapi id 15.20.5525.010; Wed, 17 Aug 2022
 08:29:41 +0000
Message-ID: <5c9edecd-762a-221b-7aa0-f5c2025d32d4@westermo.com>
Date:   Wed, 17 Aug 2022 10:29:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Content-Language: en-US
To:     <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
From:   Matthias May <matthias.may@westermo.com>
Subject: False-positive in Checkpatch
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2sG0uO03ii6ftAyQSOESdpk0"
X-ClientProxiedBy: GV3P280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::19) To DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:296::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8460815a-da48-462d-ef53-08da802aa14e
X-MS-TrafficTypeDiagnostic: VI1P192MB0510:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XL30mFC7X81/Hmmic/7e/u72l9d6q+QAC36aF4dlOWPk4+tdFfgstzFozA0W87rg+eO15bMAzMWhVfXsPmOCHyOjNXz+Yde0th16mm528rxBbUiZh8Jfz+mqsm1xxWg73PHoYzBSGk80V/HhT/aDcMY+ka3D1P1KHaVOYjlWZ+JnRRGgcgi3+Qfh41LO5ifzVfK7pXcplTEnFSiw51SEgYIplZ7vLh6h5CUGmbU3zTjTyk53M5d6KsCz1aCXDJHTOM3OQKvOv8Ko+IRYKzTzsIxNIz3RGLVrVukXcHWVl/zXXxqiPGceq5e/2kguOJ9TqfvkgqSIKXi2Wy34QV4zAMnGJpaK2g1837ojI3tcxgbJqdQqsOvL5NqDPV31QU5VjqdicpA98mrRILkhpTW1gbJJ9x9wQkvwOQ+KeaV1T+VheMzD5z5Cea4QyzWLvBzONumGT6tHsm/8Zn/THfS5nVZyqKIycHUADidk+i/AMpOIdLs4s+/ZrOzFypyNxFdL++YNrnI8+1ZjAYIxYq5uq2Q4Z6Oz0LY3bR7QZwMa8ZDZxUuqHE3FEQNUPEe5rDC7WGIkgs2wuX8bGmQVTqpeLRdVMLJVwUAvvDumgUajCSWzZs+dqlt3OVmi9DnQxW6VaIwE5iSM09lFHt6BHfbqh32YZIDTVF4cHFo6c63snky/g0dP8hvTOsF/L/a9hAA0QOGkvNckvehNlz87ctKexjfn3SUyowAFJ0SVoo2nTDC4s4XdmhrMkrHCDB4GAfRtJWjVIVzmyo+LVHIpZKyv+y3wa2QaF+5H9LcUyOdTOI8Gvm3miIP1GwVGeXaDfoormQfDn4e3s5bwQ4FlhZtP0X2bTCISnwU8QilEAjuzPc6ER8nHsZ52gSiDL2+l/6qXJkWnH8W5WgQMkBtu9FnJxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB1388.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(346002)(136003)(39840400004)(5660300002)(235185007)(478600001)(44832011)(36756003)(316002)(6916009)(6666004)(41300700001)(66946007)(6486002)(966005)(66556008)(2906002)(31686004)(8936002)(66476007)(8676002)(31696002)(186003)(26005)(33964004)(52116002)(6512007)(2616005)(6506007)(86362001)(21480400003)(83380400001)(3480700007)(38100700002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1NhMm85Mit6eVA1N1NuVWYwZHpCeDFmVUtrSDMrV2lwYzJ2TEswa1BTVzhk?=
 =?utf-8?B?OUpBYkNsRFk1QVRhNk95c2pUMVFFOE9TME1SL05KbHpVOEtSb3lDOWt1OEhK?=
 =?utf-8?B?RWdWazN5d3dsYnhReGg1ekM5a2xmYktMQlVwZ0pLK3JoTk9VMGhKMVF0ZW1U?=
 =?utf-8?B?elNvYm1ia1A2MSt3MmkxdjVGZWhRN1NrQmFGS21iajB5VU5qZUJSVFFWYll2?=
 =?utf-8?B?T2Z1cFYwRWFnZVhLU291b2pZUEczbEdzUHVlTGFRZDh2cno5UWdTM3k5MUJH?=
 =?utf-8?B?Mnk3ak1MdEliUE5wa2R0Y1N5U3R6UzR2ODdraGVrQlRZMk1nTkF2ZStzZXNq?=
 =?utf-8?B?ek9nKzVQWjJtSUMrUktNWnJHME5GWUpqaTFzbVhuWFVwZy9xVVRJZE1DdnVJ?=
 =?utf-8?B?T21Ibkw1WFhjZEhkOG5OMmZxcnVQNXpGWnZKTkNrTlBlK3VaazFYcHZLNkhG?=
 =?utf-8?B?YTlBZGgwcFhXTitHckh6aWpSWjErODJMQjAwVmFJNERWYUc5SW44MStKT3p6?=
 =?utf-8?B?QWl6ZHZ3UUorZnpYWnpwQ28yL3BnUjArb0huaU0xcTBWNFgxN2tKMkwzMFAw?=
 =?utf-8?B?bnJyV3RuL2Nvd2FhUFlsbW9rWTR6TEpUeDVySUdzamxDNE0yKzQ2TmNTOEtV?=
 =?utf-8?B?dWwvbTNWT2pIOXpLaFVlbE9TLysvbkMwczdvN1RVS052dXo0UGZjY2hSZHpr?=
 =?utf-8?B?Y2VBU05lNzl6U05BTTlmWG5CMm9PRmZjRXJ1MVRuRERtN094R3dkTlBoeDV0?=
 =?utf-8?B?SXF5djBJM2FVRnFWZDI1cXlJZU1zOG9iSXlsR1p2N1pJYkpwa0NRdTVjSWZV?=
 =?utf-8?B?aW9zQ3VMNGJyb0NjaEpLajhGc1pkSTdxZVVTUjZQc3dObTlCS0dzU0pHZTU0?=
 =?utf-8?B?L1dENThmSmJ0QlF1UTE4UzRraVp0TzFoMmJqSE92aHFFTzFPUmg0dFZjV1FK?=
 =?utf-8?B?Q3F5bVhyZFI3VlVUeGNLcGZNZ2R5cmFOSnluUWcvUXEwQkNubDZuTXg3dTh1?=
 =?utf-8?B?R3piUEQrN1NVSVhtb0hJUDZLbDVKbjhuVTdrK2FNSTdMeWdQclJLNW1Cekts?=
 =?utf-8?B?S3VhTDl5aTQrUGVER3ZhV01DYm9TaXBqTnNsRnFuKy8zdE4rVzdQOVUraEx0?=
 =?utf-8?B?ZmJtejlUaTlhZTRPb3UwR1A1amhaUjExcmlwMFFCa0Fub1JRZjNCLzRHY2RP?=
 =?utf-8?B?OEVpaGQrREFyNnByYkhldXZTVEoxaHhVWXR4andZSnUxc1o5TUdRYk9vc0lR?=
 =?utf-8?B?ZWJ1b2ZDL1M0QlBWOHEybVpIOFJOYjUvY2VZbHZzMXlyRCtYRGZ5VmdUWmtG?=
 =?utf-8?B?N3JoZk5xaTRzdDRMZ2t2Z2oreFQzdTEvb0xjbXY0V3h3YVMyRHNKZWhpY2dD?=
 =?utf-8?B?QXVNVXVneVVUemVzRVNMNXJCY3A1NjR4TmN2eWNnOHgzZW0xc1d6TWE3WU9o?=
 =?utf-8?B?YjR6RnBxbjcwMitFekxTcGhrdFdsTVNtN3ZiWmdnVWJNcnlJUFBPdWJnWE85?=
 =?utf-8?B?N2wxZnBqM1JQTTY5RUZhTjQrOVI2V2RrQWl2NE1hY3EyeGgvcDhtZzEwTXlG?=
 =?utf-8?B?SXlZSTFTaVRkcnJtTWh4K2JUZW9HRHVDY21VYVpIaFFxc205MzdSaDlaNVhB?=
 =?utf-8?B?WUpoSmhsbW1sYlNDbEh5Q2cyc2cySFVaNjZFS0c0WnlKV28rZmRQZG9hTEJN?=
 =?utf-8?B?MmlldW01Qk5EUTlNS2svTEtpL083VkRkSmFXcU56UERveElpQU1kN0dIN0Zh?=
 =?utf-8?B?N0ZtMXFpN0drRlpDVlFxTlpUcTc4Vk1FcjJMcTd2VVNLcjlIOVo0NDhHSk5r?=
 =?utf-8?B?VExxdnJwS0Z6VnNkWm1rdE1rOENsTnAvSkJsWnVNSmFRNmM1SnVwNlNMUzNI?=
 =?utf-8?B?WlJicHBKa1NGdG54ZkxpcEREUHJTZDJhQ0J3VGJXZ2NuYmpoeDNrOVBmN1dI?=
 =?utf-8?B?aStLSkJnc3lFYlNPcUEzQk9SOTE4TXY1NlZFVzRqMlA5eTZFVnZqZHcwSU5O?=
 =?utf-8?B?aHlrMUFxS0s3QlVLU0tkTVhhWjRZVm9qOXpvakV3cUpJRjFrUUo0UDZnekcw?=
 =?utf-8?B?UExtTFMwOVFuZnRrOW1HRDNPOTN0T3didFB3L1FVSjJQUm9WckwzMUt5WWJH?=
 =?utf-8?Q?vD/oY40mkHkLDqYjHDQovUJoH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8460815a-da48-462d-ef53-08da802aa14e
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 08:29:41.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v601UiQsdF/CS+65sLKOcE0fQSt+KfQ3MeSMlxOwxXlc//4uejGDwlprS3/Vb7cCbu205MgTqnSHZ1NmslFVXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0510
X-OrganizationHeadersPreserved: VI1P192MB0510.EURP192.PROD.OUTLOOK.COM
X-CrossPremisesHeadersPromoted: EX01GLOBAL.beijerelectronics.com
X-CrossPremisesHeadersFiltered: EX01GLOBAL.beijerelectronics.com
X-OriginatorOrg: westermo.com
X-Proofpoint-GUID: I0HwHRwTeRONuam77LPBcYO_hFbgMtrj
X-Proofpoint-ORIG-GUID: I0HwHRwTeRONuam77LPBcYO_hFbgMtrj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--------------2sG0uO03ii6ftAyQSOESdpk0
Content-Type: multipart/mixed; boundary="------------7QUxA6WQnEtJhGCqUQgkhZi7";
 protected-headers="v1"
From: Matthias May <matthias.may@westermo.com>
To: apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
 bpf <bpf@vger.kernel.org>
Message-ID: <5c9edecd-762a-221b-7aa0-f5c2025d32d4@westermo.com>
Subject: False-positive in Checkpatch

--------------7QUxA6WQnEtJhGCqUQgkhZi7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQ2hlY2twYXRjaCBNYWludGFpbmVycw0KDQpUaGUgc2VsZnRlc3QgcGF0Y2ggYXQNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIyMDgxNzA3MzY0OS4yNjExNy0xLW1h
dHRoaWFzLm1heUB3ZXN0ZXJtby5jb20vVC8jdQ0KY2xhaW1zIHRvbyBsb25nIGxpbmVzLg0K
SG93ZXZlciB0aGlzIHNlZW1zIHRvIGJlIGEgbWlzaW50ZXJwcmV0YXRpb24gb2YgdGhlIGlu
ZGVudGlvbiBiZWZvcmUgdGhlIHByaW50ZiBzcGxpdCBvdmVyIDINCmxpbmVzIHRvIGV4YWN0
bHkgbm90IGhhdmUgdG9vIGxvbmcgbGluZXMuDQpUaGUgZmFsc2UgcG9zaXRpdmUgY2hlY2tw
YXRjaCByZXN1bHRzIGFyZSBhbHNvIG9uIHRoZSBuZXRkZXYgcGF0Y2h3b3JrOg0KaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9wYXRjaC8yMDIyMDgx
NzA3MzY0OS4yNjExNy0xLW1hdHRoaWFzLm1heUB3ZXN0ZXJtby5jb20vDQoNCkJSDQpNYXR0
aGlhcw0K

--------------7QUxA6WQnEtJhGCqUQgkhZi7--

--------------2sG0uO03ii6ftAyQSOESdpk0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQR34wKNh4Jxr+4dJ/3fdrYEUzwNvgUCYvym8gUDAAAAAAAKCRDfdrYEUzwNvpLB
AP4kVw9/L8HQ9fwTpGEbbodhE/1a6voEj4mk0jmmy4vCWgEAtfqZU46kwn1TsmLoN7QgEJUoJ4hx
ia5pPMsDU2Pu6QU=
=7sxL
-----END PGP SIGNATURE-----

--------------2sG0uO03ii6ftAyQSOESdpk0--
