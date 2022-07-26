Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37CF581018
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 11:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiGZJjc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 05:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiGZJjb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 05:39:31 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01rlhn2141.outbound.protection.outlook.com [40.95.80.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EF65FEE
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 02:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbbFJzPYDXlXir6TaDdvKk3UrARBSZUMyq+FEa/Bp8dO67R+T1bura2lqJzsTjiEpibkgjvUjJFnOiXLC5ZFfQ+t85ZwaWG2mlHosx32ODQNzHmWqjDnVDjcK4475lnGUzaX/ZModb58cQSCjjR4aog8OQgWo8Q36wzs2BVmFm4cW1H38A1aUgSLiRVa5gT38mJsTjq5y3HEAXZhmT4bGAzg3N2izYKS7/pJENVtyBAfbPeNhyyzElGYyruC4zLhig3+vCfw3I6ieff3YICGWpgfCIQltb0fYKkDsmeGwqOrs09cSFbXVISderOkB2APakCpGCMnxYNlR25aw+YL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZrqcgs5EYdFlLj39xkqBcXV33P0T+h/vT0D5IREmaI=;
 b=ZpC8K0R1gocSZAxCCnSeN5SSnF5ny8QEDLFzBeczFXyrlUWyaezt3fjBRQRBbEJZAsIlARpfcVsO/cY/1NjiouPdVjlCQMqFLDcr/mVjWgKAHo1Ieu4BZ+skz19du90m7UMoKSsCNeASboP7GGcQVJYYR6sHrSivBx0MUSnuESGvSzoyQ7zkyNXE0GU0yhUfDIg32WsxMp9EL57AynlQVcMWkPW5zfsYfM/vcpUOh/+4Hky2bDj/w554CYKWfXjkhL5Gb4AN80FmSIIUKJuNup77jGElBIjrAD1GR0b32YHcD2lqjpJ1tKYPaneNtVS9OwCeELB1s8YhUlntyLU8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 81.144.215.152) smtp.rcpttodomain=marvell.com smtp.mailfrom=info.com;
 dmarc=none action=none header.from=info.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=KPEP.onmicrosoft.com;
 s=selector1-KPEP-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZrqcgs5EYdFlLj39xkqBcXV33P0T+h/vT0D5IREmaI=;
 b=gy7+R1jXg+USUTCr9cJO4eTPD7otJyUKYiU+D6jue7KzgLKHo232+s8QqowVCc36z+n8NGdUvW/a4hdRO94HuyRB38Ej1xk4dZ/XPArFK2HklWy2gYZY2DWS5Hx5AuUDaGr0mKuTxWChHjsdysgHLX30Y6sMSwv+FO5AVvvMp5Q=
Received: from DBBPR09CA0038.eurprd09.prod.outlook.com (2603:10a6:10:d4::26)
 by CWLP265MB5608.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 09:39:19 +0000
Received: from DBAEUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::86) by DBBPR09CA0038.outlook.office365.com
 (2603:10a6:10:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Tue, 26 Jul 2022 09:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 81.144.215.152) smtp.mailfrom=info.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=info.com;
Received-SPF: PermError (protection.outlook.com: domain of info.com used an
 invalid SPF mechanism)
Received: from hybrid.ecis.police.uk (81.144.215.152) by
 DBAEUR03FT016.mail.protection.outlook.com (100.127.142.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Tue, 26 Jul 2022 09:39:18 +0000
Received: from EPHQEXCH1INP.netr.ecis.police.uk (10.242.24.5) by
 ephqexch2inp.netr.ecis.police.uk (10.242.24.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 26 Jul 2022 10:39:06 +0100
Received: from [185.225.73.181] (10.242.234.115) by mail.ecis.police.uk
 (10.242.24.5) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 26 Jul 2022 10:39:05 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: EXTERNAL -  HELLO GOOD DAY,
To:     Recipients <donate@info.com>
From:   " Mrs. Sonia Toure. " <donate@info.com>
Date:   Tue, 26 Jul 2022 02:39:03 -0700
Reply-To: <soniatoure057@gmail.com>
Message-ID: <8aaee31a-2ed1-4908-987f-0946ba4de90a@EPHQEXCH1INP.netr.ecis.police.uk>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aff25769-4923-4dd1-5007-08da6eeab65d
X-MS-TrafficTypeDiagnostic: CWLP265MB5608:EE_
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Forefront-Antispam-Report: CIP:81.144.215.152;CTRY:GB;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:hybrid.ecis.police.uk;PTR:InfoDomainNonexistent;CAT:OSPM;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(40470700004)(82310400005)(86362001)(2906002)(31686004)(16576012)(316002)(31696002)(41300700001)(2860700004)(356005)(956004)(5660300002)(7416002)(7366002)(7406005)(6200100001)(83380400001)(40460700003)(336012)(82740400003)(9686003)(6862004)(40480700001)(32650700002)(70586007)(8936002)(35950700001)(26005)(70206006)(6706004)(966005)(498600001)(81166007)(8676002)(62346012);DIR:OUT;SFP:1023;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1gyTXdxcHh5WFVtaW5LVXpwOVFaZWE1S29oVVZCQlpBcEVwY1Y1RERYSXlZ?=
 =?utf-8?B?KzI2bmIyMzI5KzZzNmF4Syt5TmluRkxoMGo2RWFYRGVySlhFNUwzeVRXeWRF?=
 =?utf-8?B?QWROWnNxY3JvVndDRHp2NDlCMVIvdCtYZkdobi9PWVZjREtoOXNSbTkvMHVY?=
 =?utf-8?B?L0tValR0ckpSRUV0MU5DcnduQmRieXliampSZ2ZRS3Y5ZkVleWFPc2VhemN5?=
 =?utf-8?B?VmwxV0VPWHIzcVM0aWl4S0Q3MGtQaFFYNGVaQ1BkRXlmQlRjQUZ3czZjZE4x?=
 =?utf-8?B?VklNTFZBMXBSRFYwQnRPMEJRaGpuaHVGQjAyY2tvT0V5RjdpeXhmaThnUW5q?=
 =?utf-8?B?R2xJMkxPWHJqTEhLZHhPWTVBUS9KS0dFclJHbjJkZEFUcjNIUzIwRHE2Vldx?=
 =?utf-8?B?TGdGVXB3WDYxUHJaK2w1RkVGaWJEWlZrUEh5TThxaUhMTFJsbkxiU0FTaEkr?=
 =?utf-8?B?RlZaMFB6cWJUYmkzdCtzMWVoaWFWL0hpZjVZT01id0w3eVlQcVVhWWhJODdk?=
 =?utf-8?B?NThoSWJ1Z0xzakQ4NGU1dnQwS2JXYVRjTytCRTlCQzhIdXpjQ2ZWZTYvSW56?=
 =?utf-8?B?dTlxdWtwQWxPczhJdk9LQ3YxOEhKNis0Q1VHVWNIemNKa3pqMXpIaEozL0E4?=
 =?utf-8?B?TW9UTzVFaEZvWjR4VGJNUmNKbjRMVm9QYmR1Q2JSWU9hTXlrQWlFbVhOZi9P?=
 =?utf-8?B?YUxpcE02b1UzYm5udkVsTjd2MTJhL1QvMXV2R2F1R2Z0TUc4TFFBYm53Y2lj?=
 =?utf-8?B?QkRvcW0rejlwb2VQaEU1Vzd1cjNoTlRqeWc1Z040OXpmQisraGYrOTJZOVdo?=
 =?utf-8?B?Zlo4T01nblNOY1c2K3g0U3B0Vk9KSWRDeTUyY3NydmhxUlk1a21IWmRHKzBR?=
 =?utf-8?B?OTV1cTlhVWcvbEsvamhZTHpTamNKakVMTHJDUGhoT3Jtc2Z6RzE1eW90cFNT?=
 =?utf-8?B?eE10UnV1dmRxZUxHMTdGYmwzamp5RHVvNUZCNndWNVpjQUNGd0FMb2pRcE56?=
 =?utf-8?B?empTSXNNNlA5b04xNGdSRHppZlpXSVJISHJvWHhFVDlCaGUzb2hnS3p4OFk1?=
 =?utf-8?B?MWdDdWdza2plMWlOM1VtVXNCMGk2QVoyRys2dVZkYnlUQ2RISnFqbGVneWU3?=
 =?utf-8?B?YUFnb0hDaXVteW82NVo5eG43emRPelFrSU1odlZncGlTSkgyRklOZmc0QlBZ?=
 =?utf-8?B?QVpXeHRVaU5sZXZGRzlWM0NGNEMrY1VLWFNZMDJCYlA3cnM4eHBwcXBrZFpM?=
 =?utf-8?B?ZEdtVU50UkhYOEFPcWpwZjU3NGoyTnlSOVp0OTRjWEpkbUxKL21VVGthcUVl?=
 =?utf-8?B?bGpqUUJKRGNTRjVYZW1Sazg5blE0ZGZ6aVkxdS9obEp2Q3pIbitnK3VXS2Fu?=
 =?utf-8?B?TmxITnpLOW9aMXJrMXAyOTN6SWN1MlQxaEsxY3BzcDNoVHdsM20xSDZndGpG?=
 =?utf-8?B?Qnd5ZlZ1YmJNYi9nTGpWTTVkWVhiNXY5N0VHU2ZGTjF0elFQYUdRS2pGOWNP?=
 =?utf-8?B?OEplalNXNHhScy9lZzl5N0NzRTZhVXFFZjExVVgvNUExS3RXd29UL1lGL3FO?=
 =?utf-8?B?ZEJVRUwwNWxnalN0NnVtTG9wczJjWk1oQlpMeXR3TWdZTFlVYUhRQ0pqb3Ux?=
 =?utf-8?B?emZIYXBEMW95dkVqUmhKSFZDZmk0Q1E9PQ==?=
X-OriginatorOrg: KPEP.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 09:39:18.6536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff25769-4923-4dd1-5007-08da6eeab65d
X-MS-Exchange-CrossTenant-Id: f31b07f0-9cf9-40db-964d-6ff986a97e3d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f31b07f0-9cf9-40db-964d-6ff986a97e3d;Ip=[81.144.215.152];Helo=[hybrid.ecis.police.uk]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5608
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FRAUD_5,
        MONEY_FREEMAIL_REPTO,PDS_HELO_SPF_FAIL,SPF_HELO_FAIL,SUBJ_ALL_CAPS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [soniatoure057[at]gmail.com]
        *  0.0 T_SPF_PERMERROR SPF: test of record failed (permerror)
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_FAIL SPF: HELO does not match SPF record (fail)
        *      [SPF failed: Please see http://www.openspf.org/Why?s=helo;id=GBR01-CWL-obe.outbound.protection.outlook.com;ip=40.95.80.141;r=lindbergh.monkeyblade.net]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 PDS_HELO_SPF_FAIL High profile HELO that fails SPF
        *  0.3 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  0.6 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.


Hello,

I'm Mrs. Sonia Toure, married to the late Mr. Thomas Toure, who was a busin=
essman and a politician here. Before he passed on we deposited the sum of $=
4.6 million dollars in one of the leading banks here.


I am very sick and diagnosed, so I decided to donate this fund to an honest=
 person. I want you to claim this fund from the bank and donate 80% of it t=
o a charity organization. The remaining 20% is for your efforts. My goal is=
 to support those less privileged and to fulfil the vow i made with my late=
 husband.


I will give you more details as soon as I hear from you.

Mrs. Sonia Toure.
EMAIL:soniatoure057@gmail.com
This email and any other accompanying document(s) contain information from =
Kent Police and/or Essex Police, which is confidential or privileged. The i=
nformation is intended to be for the exclusive use of the individual(s) or =
bodies to whom it is addressed. The content, including any subsequent repli=
es, could be disclosable if relating to a criminal investigation or civil p=
roceedings. If you are not the intended recipient, be aware that any disclo=
sure, copying, distribution or other use of the contents of this informatio=
n is prohibited. If you have received this email in error, please notify us=
 immediately by contacting the sender or telephoning Kent Police on 01622 6=
90690 or Essex Police on 01245 491491, as appropriate. For further informat=
ion regarding Kent Police=E2=80=99s or Essex Police=E2=80=99s use of person=
al data please go to https://www.kent.police.uk/hyg/privacy/ or https://www=
.essex.police.uk/hyg/privacy/. Additionally for our Terms and Conditions pl=
ease go to https://www.kent.police.uk/hyg/terms-conditions/ or https://www.=
essex.police.uk/hyg/terms-conditions/
This email and any other accompanying document(s) contain information from =
Kent Police and/or Essex Police, which is confidential or privileged. The i=
nformation is intended to be for the exclusive use of the individual(s) or =
bodies to whom it is addressed. The content, including any subsequent repli=
es, could be disclosable if relating to a criminal investigation or civil p=
roceedings. If you are not the intended recipient, be aware that any disclo=
sure, copying, distribution or other use of the contents of this informatio=
n is prohibited. If you have received this email in error, please notify us=
 immediately by contacting the sender or telephoning Kent Police on 01622 6=
90690 or Essex Police on 01245 491491, as appropriate. For further informat=
ion regarding Kent Police=E2=80=99s or Essex Police=E2=80=99s use of person=
al data please go to https://www.kent.police.uk/hyg/privacy/ or https://www=
.essex.police.uk/hyg/privacy/. Additionally for our Terms and Conditions pl=
ease go to https://www.kent.police.uk/hyg/terms-conditions/ or https://www.=
essex.police.uk/hyg/terms-conditions/
