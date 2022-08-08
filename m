Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890B058CE58
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 21:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiHHTKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 15:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244070AbiHHTKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 15:10:06 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D519C11
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 12:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N61Ngd6jcros+PeIvAGHEL1oyEgfiQv8qIbQ592cbDOipKYY8o5uCNo1VNO9qzf0Yul4UD1jfVsz7VZNyB70LIr8eM0ZfAtIEx9JhMeWhFq61Ohrv+5waaOr0WJ6Pr7vXda3PpwQWIhfe3hg3WDnUn/DijwqrAE3t4p4Kd60mKF3GogGXl6YnG6vEzHluL5lllnAcOL5c3Vrw8vVxGQVe9mXmdYiPzXcACnRBJa1uuSb43gow7o5mzLIiWNrNxJbbJdVuo4NtFGcLXOT0Er8uYDNmWzOUeKZfw5Sse3C35dVhm0/0Z+s3VSILnqVOlPXYUGmDefkSWuqQd74zRSYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXPuE5eQRe27t+Qh04kBl7RzixGPRy7eSUjTCnDFyzg=;
 b=XTh1DLqPBZ9OEJiGo2erad/cBsVp9aWYenqK8fH6Ak6ROs0ZlJw/e+jHR07P8iaJm+sJoNlkmcst+JMMTs5KjIouCpxtn77NODnC/kNY4mIzoGxrhZNiJ35CcurmE1GfsA2QkGjbdSXQmzWeD1UWnOb3SY7HIsgx5UfDSJ/bPLASJlCcdC22MFOwf6H6f7tembQXYWI/NoeAdhpSSdLgporOEZOLY2uuvOOH5cFiBtnlH8TW+6wFu/V/0cteBKcdI0DlFtRc2Mb+7KGWHL9+WGa9kf5gonMK0OBZChyS4fcr046wL6c+AONNPXrdsa+GP+DDK8Beoj61Yz42ZdNFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXPuE5eQRe27t+Qh04kBl7RzixGPRy7eSUjTCnDFyzg=;
 b=RBqHUzFqNFREUMMkrLWZnMczEAsqND/JtEuu7rUbZP5iOWeLPbl/a3EtJG+t6Rzdd34DPfxviMPw6qCD8YVJVXW7o2stsOSfg9M/P5voEsCCkRiCH2+TpVj7GsNIgCxyKsXoPqLuzqn6qTWrC47sXWIHhk73pOFKQ26SmyJTBhs=
Received: from CH2PR21MB1464.namprd21.prod.outlook.com (2603:10b6:610:89::16)
 by DM4PR21MB3370.namprd21.prod.outlook.com (2603:10b6:8:6e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.8; Mon, 8 Aug 2022 18:54:13 +0000
Received: from CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::dc03:ddee:808f:5e48]) by CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::dc03:ddee:808f:5e48%6]) with mapi id 15.20.5504.014; Mon, 8 Aug 2022
 18:54:13 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Followup from LSF/MM/BPF on standardization/documentation
Thread-Topic: Followup from LSF/MM/BPF on standardization/documentation
Thread-Index: AQHYq1hAdxV7F6W1kUWgBeu529V11w==
Date:   Mon, 8 Aug 2022 18:54:13 +0000
Message-ID: <CH2PR21MB14647EC978225E98A3B8AD73A3639@CH2PR21MB1464.namprd21.prod.outlook.com>
References: <cd33ca74-aec9-ff57-97d5-55d8b908b0ba@iogearbox.net>
 <fa09a9f1-7d99-cafb-3c10-7a3e474d8da6@iogearbox.net>
In-Reply-To: <fa09a9f1-7d99-cafb-3c10-7a3e474d8da6@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8362cfe7-3635-4890-b217-0e15ff5709ea;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-08T18:47:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 359bc89c-5bd6-4a52-6d35-08da796f62e8
x-ms-traffictypediagnostic: DM4PR21MB3370:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2VhOWnsEcxB6DgxRS+JRpjKP2sXNb9bAZ6O/OC/7AfDaROn3tNDfmAFHU/JhU3ZEGBCaswBpTZed0noTDzOgHVovI1vnFAYzPxmzw/+AgCGiMklTXYswHS/ZKsiGstE+lEw6IJDzh67aRMt2sL7nqD+46MQRbSX5vpK0Lkq1kPri5ydsb4V5SwfUcjL+gxpsyGwJmnxujUGnUMtcWSV2fEJhOVaQvtJpm6+sYTvxJGgI9DNn8gXGvGVHvaMqxkaYWhYxxqGsTJKrQ3+esy5N9/UO/XDB7qeT34YRGDF2HL855NY1LS1HINUC2gnznJnapMOGDEsqh+gnOeFa1/xWGtTcAmyViS30Gin5+VLpK4QiEg0bEK0SX/CXWCJDOTZBlCF2eVA8JmS3MeaVSwdTtxOHOfbeNVklqmYaZxbGz71Kx+IzWnpVbHJ2D2IDDfQRm26BmHrsDDS1VN2dFBqzSwZQY2nhwdmDaWx1jxT7Jh9KpeTUcNXJJO6ZFfRrTqCjoKYxw197pQYE1rZjfebb/z4P/NTL/gLLa15Sl5HBYnwZ2NZ6TFzf8JSinWDAhKZgNq8W0b/dOJgrYfrFLgrYXtQjvr2PJ4pG2Zd3vlDlSljUxu3yNfYJARcJaaPUxRzpC2veVKNdv06M+Di/BHOI/6zjC3jm+e/naMnZcvR9uhPEPnGaEF14buwvhg80ZncQbuVePDKHeWwbYf0qi0OVhhyAG3ozzZHEhhuOw0Vv5aWncaaJDk1gnhU2y3DEtVO+aE2bETtkS8AMCZaSVgiKTmVIWGugDh6Wq+nrHp2QXbLAJjYMRjrFovLv8tB1OCKq26OxcAzVwjU8tyYHMyMFMEtLNCC5PX+exRp0S9kpP1g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1464.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199009)(6506007)(478600001)(9686003)(10290500003)(7696005)(41300700001)(33656002)(186003)(6916009)(71200400001)(2906002)(8676002)(55016003)(66476007)(66446008)(66556008)(64756008)(66946007)(76116006)(52536014)(316002)(82960400001)(86362001)(122000001)(38100700002)(8990500004)(5660300002)(8936002)(38070700005)(82950400001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ksg/MHPbkQDxF60P9Aol0IBgSrhZMKuYOxDZkPHtpLXUYuavDbM7LFRKnCBF?=
 =?us-ascii?Q?ucTBYahjtuofZvrGUEx0FQFSgJaP1Yt2VgIAn2R5TYI+6P5q6FaKzszaAzoD?=
 =?us-ascii?Q?UK1uwQ062epsJqZsctAddK6EYdU9Y0NGWsLn32KJNaukEYcAcKhJSFegAO2P?=
 =?us-ascii?Q?eaBbE/RNXPrfamv+UkOh4ZFkBml9NZsAMExNQLOkXzl90elioC9JX4tNIVPh?=
 =?us-ascii?Q?kd0oUayO9hxtF5tUrYCY/qrXSBxnVmI/fIgx0V9T5xavneSoUzarxLoWXNAj?=
 =?us-ascii?Q?jZ0zYFsnQPM/t6TN31bzmuNaZRuUoFd9ZmZeRLjkf4M1hirrRiMpTbalhddA?=
 =?us-ascii?Q?kqgjz+FiFS9QYJi/jrJiM7rQkz8Df+MBafdpodLxBPR4KznHDsXk86+moH+G?=
 =?us-ascii?Q?I50qpisPYidoST8yX5JgVrjjh2ppsKGP23ZgtApNENalxJI+ObH+P6DH4C6W?=
 =?us-ascii?Q?oRMOs3i37/3Z4YWCpAd3ZQ+pCQzYgWbqtkiFxVDGH+ENQ3MFygQRBJk/Zvsw?=
 =?us-ascii?Q?pwl9OLXYu8by5Dd66/eCsfhE0x7ymvUwXUAcVj/SCGI2ICk214p5IcIOKo4X?=
 =?us-ascii?Q?6PNf6F78sWDfo3YMdNVatyEZRPMOHUOhNQlbt2iZoJUF9AkXR7L0VLJhKdOa?=
 =?us-ascii?Q?rW9I3kP+BpvN/JcZ4g5RrWQRVNcTq3trjqoaE/l6rYsczNNOrDyz2twn5PpO?=
 =?us-ascii?Q?23wRD+h2jPJxxsuaHpysh3XiHcUTNYACnCXGXCJuw8lHAq+zXcG1AFHVQHxV?=
 =?us-ascii?Q?/8mX6wzypWaAkUQQo6utrpxeFC+TA7BFz2xLDWV6+HfmKeEgR8PvzwdK1Ni+?=
 =?us-ascii?Q?E6fWqnvoFSVcyFcL9UKWM/ZKmF2rxMJXAVKhtYordTz+/WqVkEp0/NqnvgHw?=
 =?us-ascii?Q?+Xer8jH1Xxd9yIqMFo2OOFOKKuUP0gbQUB37KbNYf8PzIn1XIm7LbiEhqfHN?=
 =?us-ascii?Q?Mdy/Y5KN0pHeYIW9hKEJklFyJ03m/hQJRpqXAF3yd8wQoDwLnAYMKYwr4dUx?=
 =?us-ascii?Q?5k2Lbp8EIZ63jkpV8zvxL7hhhUHkvbk/21Jto2AK3113CTHAXC+9tjPY3X9f?=
 =?us-ascii?Q?Y0XoKMJ3ZmAKXQobMtVwMSrdeEW0Xn4lFxKlCYIy05/R5Rse8Ta7FqaP6Znx?=
 =?us-ascii?Q?49UX5HmMI4VEZMaQ8wSZCMZNJLiqY8L6o1U4VSOPymCHS1NmeN9ZYZDKzDGH?=
 =?us-ascii?Q?iQAJi+jsyvFrYwQoANGc94P69AXrh6WbGdaMeIE/RGeSJhJUfBbSsqpD4pa+?=
 =?us-ascii?Q?utSLB08xA4UfAtzUE4NrgD5H0G6OHkdtTyFRDI3VALdUvNOgA5tRUZUEbD+g?=
 =?us-ascii?Q?wwAATiOSfPDCkwXn8BiI5W2KbiLg0q3TEvZ9H8aK6eQWs4xB5+mc7wMuvJoC?=
 =?us-ascii?Q?fKjqE2x+b+SycioH+19943OxzQ7mW3ws0KPM/sQ480gVAfu5WiHKl2oRitz5?=
 =?us-ascii?Q?oapI5INwOpWEqE/GFqdtKAiqT7rEmbJrWFC6OfuZnW6HL4CbMw9cUNoLV759?=
 =?us-ascii?Q?R+je+GdjI30yaH1+hTI72NNG6741gXksRhx2BlBtKZl6TY5dmriCq6IvUHYa?=
 =?us-ascii?Q?2daKML1eS2toVNInffKmtmkLHM6veyfrZe6fsMydu+gNjxG+sW+2D36JqLgN?=
 =?us-ascii?Q?SWQIubX5bOREOUFO48z4anfeB/+++h6JXbkeLJD9l/ZWaLkUNdXSaYEBuK8d?=
 =?us-ascii?Q?61KseA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3370
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

At LSF/MM/BPF, the topic was raised about better documenting eBPF and makin=
g "standards" like documentation, especially since we are having runtimes o=
ther than just Linux now supporting eBPF.  And ideally hosting it under the=
 eBPF Foundation.

I'd like to use this week's BPF office hours slot (Thursday 9am Pacific) to=
 kick off a discussion of this topic, so wanted to send this email to invit=
e anyone interested in contributing to such an effort.   Hopefully we can d=
iscuss how to organize the effort and some principles we might use for what=
 might be in scope.

Dave
