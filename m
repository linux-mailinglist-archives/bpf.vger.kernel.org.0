Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA6A5B87E1
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 14:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiINMLI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 08:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiINMKu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 08:10:50 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2212.outbound.protection.outlook.com [52.100.0.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD6833401
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 05:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S81vRSUt9VHdbIDfnSKONf03De1n/V5CoKY2t2ah256faMwkfHxG51cjN11Px5CK10lWeAbXN/b3QukLQUnNS1rUE4aBO6+UAIleby+M5dJvy/4dAcIFTkAMh0OxBgBZv7CR++Rdm8hBgGRSQg/4KAe0mztPQLWzIflJ5ZDAO7STvso9rBaIUPGTJ+mCnDWyEFlHJDlXzE5qaUPlCzlDhSzAchvKUsV4Z/acmVGqijuYrDv6opa/cUiu7dLx5sqB+ja6QdiEQNzZdqgj17SuwE7cuBujKx0DxajDXCGYEZ9bvUzCsoih6dh9ugFEHxpo73lPjSGQgDUhuQDR+h6l2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs10Md+15nMnyayKLyd22Uv+/ZH79IcFcpzuzGLq1Fg=;
 b=KeTEKi3OTaFEi5C1o9j4yfhBvWt/4lszoehHlJ73O0YCQekCH1fe2BKsh88RIec9pyKsFaOmCEedw7K2mfSPBH1uH4XRxGk7ibzDs01zHYvPKglPwsgS8Ptx+R7CS7Mar5wBpVGIonWMimBRnNhOK6jO5VQxp9eOvCkY3VuTMlZ/UAoQIRVIlg3qI8oiWtYoXNSeHe1Vz+Ip4j7cj47wMBvX+WuDpd5E5YLHcBV5ZP1UrX8uIpDnsuNvM4tLwUeiQA7x56CwwQno2pA+Ynwh8MPswv9eokixN6SgdkZFYPGr+H2aDOAXT1uwB7JqvpzxWMN8VljCYHodND4yAQaaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 89.187.179.55) smtp.rcpttodomain=riseup.net smtp.mailfrom=t4.cims.jp;
 dmarc=bestguesspass action=none header.from=t4.cims.jp; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18) by
 TYZPR04MB4512.apcprd04.prod.outlook.com (2603:1096:400:57::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Wed, 14 Sep 2022 12:10:30 +0000
Received: from SG2APC01FT0031.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:0:cafe::5) by SG2PR04CA0156.outlook.office365.com
 (2603:1096:4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 12:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 89.187.179.55)
 smtp.mailfrom=t4.cims.jp; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=t4.cims.jp;
Received-SPF: Pass (protection.outlook.com: domain of t4.cims.jp designates
 89.187.179.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=89.187.179.55; helo=User; pr=M
Received: from mail.prasarana.com.my (58.26.8.159) by
 SG2APC01FT0031.mail.protection.outlook.com (10.13.36.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 12:10:29 +0000
Received: from MRL-EXH-02.prasarana.com.my (10.128.66.101) by
 MRL-EXH-02.prasarana.com.my (10.128.66.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 14 Sep 2022 20:10:10 +0800
Received: from User (89.187.179.55) by MRL-EXH-02.prasarana.com.my
 (10.128.66.101) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 14 Sep 2022 20:09:37 +0800
Reply-To: <rhashimi202222@kakao.com>
From:   Consultant Swift Capital Loans Ltd <info@t4.cims.jp>
Subject: I hope you are doing well, and business is great!
Date:   Wed, 14 Sep 2022 20:10:18 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <2e0da2e8-a76e-458c-8e55-1753d5243313@MRL-EXH-02.prasarana.com.my>
To:     Undisclosed recipients:;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[89.187.179.55];domain=User
X-MS-Exchange-ExternalOriginalInternetSender: ip=[89.187.179.55];domain=User
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0031:EE_|TYZPR04MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: e14acf28-81a0-40a2-9977-08da964a1dd3
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?windows-1251?Q?v32kxJePrwa5Vy+9P1+oN4pFUrKq8FOARc9hiRFCwdbqf6cAgea+SUF8?=
 =?windows-1251?Q?R1gO0ydCdm+UC4l5lFFO8ooi2k01w9m8HBZ3Oix9RKzIJUZwJX08PSdC?=
 =?windows-1251?Q?FvrwidL4/RcEdtSzCpeRoXRmZJ3bg9hvRDPznnYOr9OOcXXxOpuICR00?=
 =?windows-1251?Q?kzv2Lp7PpyCaoLfwjYPBFHZBSbCCmTVhJu0ZeKNvmel/3JKZPl22unew?=
 =?windows-1251?Q?rfyzmsYsjwb111doiIx1XDBtYBp4gNmggWF7bWJ8iBBIxE5i2s4n05L2?=
 =?windows-1251?Q?QyQSPU5SpztgrlAbLUcf9OGk0hfrHfjZTZitWwC0vi0EowGErnVcUSLm?=
 =?windows-1251?Q?4Sw5QZ997vLz3cLigYkzThC6kExhQ3D+xHvrIxKm/7F2ZBgtbwHCOrjj?=
 =?windows-1251?Q?bC63t4Y14fKZYzqVFEKe9kvY0KezM+1IXDN5WkrhTHWul3Su/qvGTK+8?=
 =?windows-1251?Q?GV8HK+WEjulsxl8QAlQpuNWeXW157Gfg3GhZEHBXF8LFiBRu8tNMSp3J?=
 =?windows-1251?Q?1gm4q+s6D+LlbLkllEWJwsTMKK8/IDLM1fCIBVvLQwT/QIHmN6CIcW/c?=
 =?windows-1251?Q?FSwhSpXixzAEcQQAq/rqXXPcFigtXUPL9/nLuv30NzbeYaXrpJA9iYq7?=
 =?windows-1251?Q?YYR1+5j+VmSOm0fjvwbCFu+TnYAwspfy4xV6EdVGsQqkpBYEllqOySPf?=
 =?windows-1251?Q?/Tm/dXkVlTKyJvr6YBdSAxhKpFHiRPC01unIP01UhMav413XW8gDEAK/?=
 =?windows-1251?Q?rlm21roBAt3h56YBSY16CM7pywCt7bE+uHcEIYCflhXWqLjs8YKOfOUQ?=
 =?windows-1251?Q?9ich8aGs4U2n94jWueHWGUklif3nvyswxbh6QbW6iTjDHHrkFcJJju3J?=
 =?windows-1251?Q?9N2zcRa1oNW5FHMS+CBbnjyGjsvxp0qqbhwdwANAkuJ69SK776axc3s8?=
 =?windows-1251?Q?ud9+Q2eLDmCRFN9+P6zUuaYtz0EidmeVT1xpFC/0ct3cp+YfpHYSw6VF?=
 =?windows-1251?Q?41EjFUmWOHV2DdXWMjil2SLgNpHsxveLDOJkB6EtE9SlitaBSfJ8SG4s?=
 =?windows-1251?Q?gdGiPsdHOlhUhOW+RDrIfnqjsh/uFwFnC8M3nYY/sZO43lgARL/AGJvb?=
 =?windows-1251?Q?NVq6sQhPJV2lyLfRSshBaLBeZMTHS3KFc1dAOc10yQyFvoXs69+4W8J+?=
 =?windows-1251?Q?LmsRBXBqYVc5dLH3PjsAH52TbOQdRTuQ++amzi5Ds2S7vfWHK3ZOFuBd?=
 =?windows-1251?Q?E0XPSwtZXx0YfdHdUQwFNKHGXuKI4M9vlpl6Bei2N1/QIJXaNkhIlF/v?=
 =?windows-1251?Q?HJ1x943krWb8XAMILUOnW2T+5J3a4kYI7uNSNfQ6d1ZhjCkD?=
X-Forefront-Antispam-Report: CIP:58.26.8.159;CTRY:US;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:User;PTR:unn-89-187-179-55.cdn77.com;CAT:OSPM;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(40470700004)(35950700001)(40460700003)(109986005)(498600001)(7416002)(8936002)(6666004)(40480700001)(86362001)(156005)(2906002)(9686003)(31686004)(41300700001)(26005)(316002)(32850700003)(70586007)(82740400003)(4744005)(956004)(7406005)(32650700002)(5660300002)(336012)(7366002)(31696002)(81166007)(8676002)(82310400005)(70206006)(2700400008);DIR:OUT;SFP:1501;
X-OriginatorOrg: myprasarana.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 12:10:29.7718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e14acf28-81a0-40a2-9977-08da964a1dd3
X-MS-Exchange-CrossTenant-Id: 3cbb2ff2-27fb-4993-aecf-bf16995e64c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3cbb2ff2-27fb-4993-aecf-bf16995e64c0;Ip=[58.26.8.159];Helo=[mail.prasarana.com.my]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0031.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4512
X-Spam-Status: Yes, score=6.2 required=5.0 tests=AXB_XMAILER_MIMEOLE_OL_024C2,
        AXB_X_FF_SEZ_S,BAYES_50,FORGED_MUA_OUTLOOK,FSL_CTYPE_WIN1251,
        FSL_NEW_HELO_USER,HEADER_FROM_DIFFERENT_DOMAINS,NSL_RCVD_FROM_USER,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [52.100.0.212 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5454]
        *  0.0 NSL_RCVD_FROM_USER Received from User
        *  3.2 AXB_X_FF_SEZ_S Forefront sez this is spam
        *  0.0 FSL_CTYPE_WIN1251 Content-Type only seen in 419 spam
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [52.100.0.212 listed in wl.mailspike.net]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 AXB_XMAILER_MIMEOLE_OL_024C2 Yet another X header trait
        *  0.0 FSL_NEW_HELO_USER Spam's using Helo and User
        *  1.9 FORGED_MUA_OUTLOOK Forged mail pretending to be from MS Outlook
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I hope you are doing well, and business is great!
However, if you need working capital to further grow and expand your business, we may be a perfect fit for you. I am Ms. Kaori Ichikawa Swift Capital Loans Ltd Consultant, Our loans are NOT based on your personal credit, and NO collateral is required.

We are a Direct Lender who can approve your loan today, and fund as Early as Tomorrow.

Once your reply I will send you the official website to complete your application

Waiting for your reply.

Regards
Ms. Kaori Ichikawa
Consultant Swift Capital Loans Ltd
