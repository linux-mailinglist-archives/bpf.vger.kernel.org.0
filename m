Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2302A6566A7
	for <lists+bpf@lfdr.de>; Tue, 27 Dec 2022 02:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiL0B5z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Dec 2022 20:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiL0B5y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Dec 2022 20:57:54 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2066.outbound.protection.outlook.com [40.92.99.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347271004
        for <bpf@vger.kernel.org>; Mon, 26 Dec 2022 17:57:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGzRNkYY9TZM8QIqsR8Lw1dPpI8dULnu+HoNOFt9fqMalKjfC2oYmX1MCnjLsZLzPaj8QSVk5r6crlxm66VftE5GXNYwjFjNISvQwsVNeDLZJsRIdF6wFMJVoCmhV8TP0nePOFHL5666pOaMjTJsU2oYI+6jsSt48HtzElGwwU7pr01K41+WWeNI31KH0FLN1nkeh1koJpTbygq4r7DEl0M+AbqUeBVdJlAbFrXPHQF/F7yWw9iAgG5MFEdXm4GMNw5SQpugBmilVYLiyl6hOcVuJtoBKcJeqGegG7RG7ZbQDK0jr0LZv+pemA0SREQEvJTTwXPhf/4XIFN7ZWISlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orji+xrFc+8Nm/Tu9s5PQ8rI5+WcSQ3628zjxI6RyU8=;
 b=azDo9ok6haCUXkJ/8DgeNzmNJ3djZA/DU01yTbZUHsSpJoiTrdhrI4pEMJmsRDRqAeru1rCVdSO6c9QSe1MfZLrH6xOv/baWGS2B2a4xiiqy4N3ahXFQ/Mp5wBSPySkAN1RT9I+GD0CvcgfU4dOEfdrhOuaH5J+p5rMakuWhflRpaCt9t+y0Ae6WVyxBQcPHpmz4FuiustDP14QXivENph9I99M1bocYha978hUK4zThH4TT0W3BIaQ9Q9mQotKhTNeiQyleGCBFgDxTLAH2/zoozGO87K147eZ5VzzlZhGJm9fPNthQn6mu7kicKSR9hgHPGzzmxEKdZgWlHRxTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orji+xrFc+8Nm/Tu9s5PQ8rI5+WcSQ3628zjxI6RyU8=;
 b=ReF/hpy/KJxYs6FRYujI6BhOp0mdgY1N1d8Oam374/gIndRQ0+mEq2IJXsrbzA/Tp5qrcEUFQrm9EZS4KDwUZlAHSFkdcKIPICvkzJE+DoxttNKwHDBoqQKs7le1bDadguyc4CI5B59rLS1ZuMKSuNs1SOKwSEABLI846NO3uiswqRZNCgjQEBHhyRGmbKDXOfwVsZx+tVh0RhLkAB7XqiCNcuDvWtASnKqwCwj08SUpvjMA9+QJRSIKR8yvPe6NvwMN+cLqkFdJxi7Y7hz/f5iowZwS49PgZ7+UtQfh9f31XJyIiakAdwJti7Suik57eYOzxn7mtO4PWS9uY8lHLQ==
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d9::7) by
 TY3P286MB2561.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:222::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16; Tue, 27 Dec 2022 01:57:50 +0000
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6455:e3bc:5dc:e1cd]) by OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6455:e3bc:5dc:e1cd%6]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 01:57:50 +0000
Message-ID: <OS3P286MB06320CE880856D1A294E90BB9EED9@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
Date:   Tue, 27 Dec 2022 09:57:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     bpf@vger.kernel.org
From:   Yahu Gao <yahu.gao@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [8cu52GKhRewjJHQXm9CCX9mTMu3Sm10G]
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:d9::7)
X-Microsoft-Original-Message-ID: <f5e752f3-c872-ab52-efbd-e3374267456d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0632:EE_|TY3P286MB2561:EE_
X-MS-Office365-Filtering-Correlation-Id: 39664a79-4851-46ae-7c5b-08dae7adc227
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75a8etL0ypaig3VF8oxxLVYllkRDWT1x/Mg6xUblZKNg8Jv2rD588aOfonLXk037BOs4rNZj970Jxuw6TlUcu6Mc1wXh82A+0hxI17CatE+JRqmQtkGAM4ihOYQyNUGMqFahGWkhcbmYkB1D5jLgnakpSc7VYaV7u7ctVfx6eBgaNTEzABzFbofUH0ECM9E0+1kQbuKtgaV//HwGsLr/Mx02DO7t38EQ4E/DJgsJ9ORZyrB4qfz1R7q4pA8GoX1EoWi7ZpTAfj7ky0Nxcc3XM+Rwvezd5SEUXaxnx5f+GBfmMnW7AxA5Ap3W7KQw2zJtXt2BWPhTAhlAcA8K2uGuKyozr+xkGahvTXCCu7YPDo5eDMGN6AoiTgli0B48DDVCjVWMh6cRcAA+ItGVL3MepyG2gX9qxxUlQzmY7neF9ZVh4CXKMKfYgx7s9Nzg1R8X723jL8IwbPFA1MT2scX1qxl6RguNMyc5BlyDHbKrZqgzfvG5z7RwmlrsnvuzlLMiQk7Or4h1IGGl/CAN3tXeOHnZKPm3eervUlv5g/tAFETnwJIdgSlmgv6RSSXdj7copuqcBXcWJwW7hrBF4BMtIiUbN61X7UX+gt5Tqbett7k=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE1uRTF2M1llQzh0VTJIS2hXSFQ1SFVKMjhHSlcwRk12VzBjN1FtanNCdXM3?=
 =?utf-8?B?allmdndqbkU4dUxDUURqbnBBbjBjZ2dqUFhWNS9OckpsSFB6RUFQckV5S0lZ?=
 =?utf-8?B?VSt6L0RYeWxFMkgyWmJOa0xQMzJFSVQxWlVRTTMzeTZrcU5DNmhNalNRRkxL?=
 =?utf-8?B?bXJIWkcrZWE3K1UwOWpma3dlQ1prRS93NDcwTTY5c0ZleXM2TnBYeDFCRmtT?=
 =?utf-8?B?RGhUSWVzSzF5NnNYZThuc1hOa1F1R0R0dEJhZlJDalc2OWkzL0VVOUU4SFln?=
 =?utf-8?B?ZnFFbFFIbUpYaGN3NmNpV1Rnb2ljdjEyYlhHczdXODF5U05mbjFTa2hDRHdV?=
 =?utf-8?B?WE5PSGQ2VnUyL3UrekYvRFVFMHZITlYyNjV1UzBzZ2EzQkpqVmxudjluZnBh?=
 =?utf-8?B?N2RtRmRHRFFiNEIxeEw2Q1hpU2tTY0ttNHZaY2tDZ2M0NHRQd05qdkg0ZytX?=
 =?utf-8?B?MDBIS1hOenZOVzN0SUsya1JjMVl3TnFBVjE0Vy9DaUR1d25vcVRiWTk3enVr?=
 =?utf-8?B?NkNiYzZnSU13WUc5RWJBTDY4NGZaNlIxMjFZalNyWFhmV0hXZkxIMS9EaEZy?=
 =?utf-8?B?VGdhcWFJeTZuU0RrY1NoM1RtbTJ1Z2lxOTZPVDFmcnFWbUoxRHhBWE5QZzZ5?=
 =?utf-8?B?aUJEK1VhckxoOWhnL25PM0s3MGxlQUVvTjlSUmRXZnZDQnpsR0FIaFV6ZWRr?=
 =?utf-8?B?dE9qWjN1RjRFTUgwYU4yS1k3cENLYjdkUEF0WFN0dVozRjhQS3Z1b2xGVlZS?=
 =?utf-8?B?SU9qMDBNS1orZDlGVURZcDU0V2FWTXpuaW9XbEU1M3FpdzR2SlBNWUwyTU1l?=
 =?utf-8?B?SlNxaW5yd1p4NGYycWhJYlJrNm5PbmcrSmZhUktkN08rYTVLMGdMRmZONEFD?=
 =?utf-8?B?NjcwMkc2S00vUWd1ZHNLT2VYZHdxMGRhYzVZVFM4SEZSQ001MTc1bW5nczNB?=
 =?utf-8?B?ZDF0cEQ4aHhqQlZVQmloL1NlWkZQMGlvanovWmZqYmp5ekU5RCtFdkVUb0dE?=
 =?utf-8?B?Zjg0Qy96NG1OTUZYMTNUM08zSUt1U1RMRXZFZWpQRndNVktQM2I2bVBrNWxT?=
 =?utf-8?B?Nmw0YlZEbVhMckU5TFFHMXFDckNUMXZsb3VISnBOVkxQVDJPMUdFb3JYbU5y?=
 =?utf-8?B?aU9kbDFXZXJzeklucmx3Y212NjlZV2xMM3dBOUplR1M1bld6bXI3QStURENp?=
 =?utf-8?B?aHRiSzMyUS9vcU1uaEFGUEZFRzdKYnNVWG9NYVQ1V29FTmd5akNiaEN4M0ww?=
 =?utf-8?B?Znp5U2U5bXE3WGhlNzFmaVF1NzhSWDFkOUdqbG5jNysrbWNmaUlMQWRMaUlE?=
 =?utf-8?B?aDNlUTRwdmRIdFJBUTFlc3hseW81cEw0UnRKcGxJZkNlK0JRTzVIcW9PckpW?=
 =?utf-8?B?RzJuQmhPL25wRVJnTWQ1VlRXK3d3UTlIaEUvQTNZN2R0bmgzZ3NwMjFMdGFS?=
 =?utf-8?B?b2RUT1BXdEdmR2tMVm5YZzhxd0FFOTNrT1haOFNMcjJCMVhzeUJyK2d1UmxJ?=
 =?utf-8?B?S09QZ0VqSkZLOHl4WStYby9sVFFnNldpQ3BtMXlPbndXbjNqUzB1T1FucG5h?=
 =?utf-8?B?U0FIQVdtSVJscWhiNTdGWW5DQkhkQ0k1dnpVYmtzYXh1QVhkOWZDdEVVVXdy?=
 =?utf-8?B?bWg2TThKSHhQcDJlSzM3L0owckFlcS9Db3RSdkVGUTZ2SExhR0Vwa0JrR29L?=
 =?utf-8?B?Vm56ZGVvWmlScjI4QnQ2aG9Bajl2MW00dWVSSnBIK29KdlpLZ0RhRTdRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39664a79-4851-46ae-7c5b-08dae7adc227
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 01:57:50.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2561
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,MISSING_SUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        SPF_PASS,TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

subscribe bpf

