Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658C03BDC53
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 19:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhGFRcq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 13:32:46 -0400
Received: from mail-mw2nam10on2095.outbound.protection.outlook.com ([40.107.94.95]:28768
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229949AbhGFRcq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 13:32:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VurmsM6iE6bwa4dAhB9n67/YS3eBx3h739mSltVZ45BMtKrDe5/zRfU4okcTvWGF2M8OjnKLbysPtR3UVVLQoExWkJLvS1/zb6y9I1voWs4ReWUITtcS8OCdNDIPdrF1oHV+y/Dmb1tNqV9OZ6Nmo9EEF7smKKeb3sj0S05PPpznjz7IdngHYo5m/voM7Rss+RiNA9+zih0Dw6QahH+ooDB/ICbiBRXbll8TKZNvpnEFCBO+zlFgztjfPlOc/XWKjDKg0GkOiA5KA8Ix3FS0Tr3wVA+/htt5/+ERRRLlKCBG4RD/vIa3qV67Ihrsl8jk5h+N4WBEbYtQJ2bUOL21qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCF2hksrfQ7/y5wMyivt97kVRTpxa/wFU9hOU/Ucceg=;
 b=gQJlwlAyTrrXZZLEEHvX9AnVjwK+t7dodipciC7XxrzWX7DwjUdgkux8D+7cW9WNi0fCfqRPkncM7O8V6Db4iyNS38dnxJn8T0zAeF8o9nqkkGv587r8J1hcGg1tvMJgfgFo8ZzO3ZM+YieoutSfOWnrym5U6l7DVyl2HSz68bo6eU1u5HYEAsSp5GdWB/qdTP+7jA8x4xi9jh0Z0/L1Tsf+KGlcFzU+LjoNootFXxq1KC+Wzfyjt0PRqMja8bLpgcRnfu7ltCbccDFFLyh2Yw9Wfi/FKmfVzxPovnyJm9FBEYJAwK5bbxz1bj3ZcY/nC6rSeRvoQa6qTZKDlFhGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCF2hksrfQ7/y5wMyivt97kVRTpxa/wFU9hOU/Ucceg=;
 b=WW5iIh1ZVCUHH8SKFfC7o2tLO2AUdbny3VE7d1ar/t1/jw7tzcenIBGfXNOEyRnSdkAmk9BLc1QcZ6FUZ+5XvDMRPbzv6mgdGkdKF14LFJDb40XXZ5dKVXvGK/PcKv4rcI5i4Ym5Cti0UCebotfNeukmFzOv3wSC+VJRiYatg8c=
Received: from CH2PR21MB1430.namprd21.prod.outlook.com (2603:10b6:610:80::17)
 by CH2PR21MB1414.namprd21.prod.outlook.com (2603:10b6:610:87::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.5; Tue, 6 Jul
 2021 17:30:05 +0000
Received: from CH2PR21MB1430.namprd21.prod.outlook.com
 ([fe80::501b:91a2:627a:a246]) by CH2PR21MB1430.namprd21.prod.outlook.com
 ([fe80::501b:91a2:627a:a246%9]) with mapi id 15.20.4308.019; Tue, 6 Jul 2021
 17:30:05 +0000
From:   Alan Jowett <Alan.Jowett@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Signing of BPF programs as root delegation
Thread-Topic: Signing of BPF programs as root delegation
Thread-Index: Addyg5mKtHzGdYFdTFOhNdLsdiul7w==
Date:   Tue, 6 Jul 2021 17:30:05 +0000
Message-ID: <CH2PR21MB1430287CC594A28B1FC473EAFA1B9@CH2PR21MB1430.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=89c66d18-6fe0-4f10-9928-8f1729042599;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-06T16:24:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78b5549b-b2db-40d7-2e2e-08d940a3b1a7
x-ms-traffictypediagnostic: CH2PR21MB1414:
x-microsoft-antispam-prvs: <CH2PR21MB14149780B63A690054568818FA1B9@CH2PR21MB1414.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ui6+38JWn1GgkyF9elOVxCBxHZyF65wj3QS8KwTQloTNcH9jEKe2KbdViTW8+TeT9wiJpmsiUXzBnC2uuRpUrPOdCY+ELYZ1grkZTHYDcD0vROGc7bvvraiCsRhaS52xR0QGmiyzGsIAhWnhDsCW5HfHpp2prpL6sf2NwQZD7+XUr/JFv0cQ84MetuGMzz8in5bd/zRjCl/9igUbLi0Is5tTvK09H6Hk9jhvNnJ2XyVhJ0Z4ivs97HgQVsl/VpQvPmdyvGMSD4dOjB3nZCnPP2aYuHChQrqWIlLSUb7RrvfG/PWnU7D9y81k8TtPy1mXzpM+/4ES3jmmHAB9TyrFYHSE/Tzr55TWM1r8NFO1p0RNWW93h8H8NSgpw32FFr1FQNraxiRTokNhiLuZDto+pOxTSURzJSDWqlD8ejVBJiMJufkYr5WMZY0LvDtJI5XubDA9k/GZD+kPmAfsd79yUvslHM52vVVUX0r8ezaaU3iKONG7yYPG41VkX0Tku+s8ykBfeL0WuVD0qfAJdr57PWQF9er10lf8XkIfaz4eRaneznExqpWLvFbEgLFaxKTjwNhRw8y1Pp6ks4IhuNsGMQFDgtwt6OxWzkCJ/7MjYAmby295RO3o8I5X8Z2lee5PzM/UdrbDSS46ff5S4ow7GC2HrU8B553WCNvJNxpTPdijhC8XRHdIDjlChA9hqIZBNJsp8uU9oyj/yawypl0yjTdOE7cZa76e/yWBnvt19mc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1430.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(71200400001)(26005)(66446008)(122000001)(33656002)(2906002)(38100700002)(64756008)(66476007)(7696005)(86362001)(66556008)(6506007)(66946007)(478600001)(8990500004)(6916009)(55016002)(10290500003)(9686003)(52536014)(5660300002)(8936002)(82950400001)(82960400001)(316002)(83380400001)(76116006)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eXKLYLrr/3Z/Js+i30n9rmiuzQ8IJ10W+14qXhkt8NbS155Ex8IFVnFY6a2s?=
 =?us-ascii?Q?/3InzqlF4YsN2z1sH2UaaRLmevBagB9eT1+52Bykv1b4jszEF00azdyiadrO?=
 =?us-ascii?Q?L4b47RvBvmVXkSEvvXZCXRMMdgJCR7hkyaOAulL865wkpCW73X8EMHWxdNXS?=
 =?us-ascii?Q?LtdqbfVQl3Rp5xR4xWM7TfK6UiZHg91MYoeqehUfH9glk7aEuuy7RvXfPjDV?=
 =?us-ascii?Q?ohTn/yGvb0PIHTrJYNNDvGAYKXRRQt0VUmJY811AmpmuJmE9vqU7aKQbNVZv?=
 =?us-ascii?Q?8xwAp1tnZdU9yD9p09LAVob2DChuDDMcQE7Js5u/z7P8DhYFk9M+PHNcFqrE?=
 =?us-ascii?Q?k+Von++g3mM0ynCnqWSznarwwsUOeBVfkIi6d4i37xMwH22eX86hasX8TqFT?=
 =?us-ascii?Q?OzrXiwatP6W4r5qL/edBY3zZEBvIKkjDrQdE3sLp0zb6uZg25rV06GZYWsAT?=
 =?us-ascii?Q?Pp6GeEprVE2t+Kdt9SRKdhkvPeCZE1YFksqb510uGghFkv1OFmhlyqDfpHil?=
 =?us-ascii?Q?IKcO/e1mRY5EhThgPHzTqPbFX3a1UXu0TCwDmf2oPwenHb6RgEky6FTEXm0V?=
 =?us-ascii?Q?d+kjAC8dD3JSoypSmyCxSLCNLmBpnPpDZ3MpYxBKOX8kLKfiwXtdR6uzg8wV?=
 =?us-ascii?Q?bP0PfODT9EbwloiBZnRaEfFavp/NSdTrauTB0Y49sRc2VJDubfQXyKqt3GF2?=
 =?us-ascii?Q?pCJtGswx4FCoDfZuvq8pjTR4f0LAIwAPucrk/r8ffN7xs/bttdKElFXMVcja?=
 =?us-ascii?Q?0wNaRpmRMoUFvxLYgnlojIyW6j2ht6Vzt4N0kMRB1TF/014khkAkg7xdn+k6?=
 =?us-ascii?Q?7VLRpEKtVVWwCrF1rUyfj6gUslpqbYKOtUADpgbwEp2/Ww4AMpPK6Ic1ujSu?=
 =?us-ascii?Q?CQc99v0lULntQiQ7IbZc6fgLpe2C1/GBb8FQe31VAiu3oT6l9EEg9BvxqLaW?=
 =?us-ascii?Q?05g/bNhf1BU6B27zlrGh4euOtVPCrZyE0lUKb63iZfGw6kTuOZWtXEbxw7n1?=
 =?us-ascii?Q?frIrxXZMlFBjBv4VVjUVYfaNMV5lXc0JIx+QN6pP0+eGJmiP49Q8aJjfqPQw?=
 =?us-ascii?Q?9TQXlnpqX75GiaQkAJqZYDjOUN6nTkxidXxxBlyLDDG6BeWNFvCLQqbIavkE?=
 =?us-ascii?Q?EiiXQpgWs1648dyMTs1ml0OYoQXtaNlZPjdS4sAPifZEUSlonT7vJj9woKhj?=
 =?us-ascii?Q?RTZKb+GV8/lAV1JykJbaAmO2Qe67CXfgIkiFYsvfvtpdv7J5EoTmRBbpc3KL?=
 =?us-ascii?Q?x8G7HbdI4rbPPs+Qa29ToZIsTocYe0F9gNL4i6wtKHYCRoldeLax5dktoaU+?=
 =?us-ascii?Q?Quc9Roinv4jaZ8x+xNPB/YJC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1430.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b5549b-b2db-40d7-2e2e-08d940a3b1a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 17:30:05.2791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1saWxVviyo6CmXNQnW7N4GoKzHVOJM0bLKJC95O6K2JrpD9P9TbL0m8ENGVeFeDPCuSR0Fu5zXm9bwk7obp5dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1414
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF folks,

Quick question: Has anyone considered using signing of BPF programs as comp=
romise between completely denying non-root from loading eBPF programs and p=
ermitting non-root to load any eBPF programs?

Problem statement:
A large set of security issues have arisen because of permitting non-root t=
o verify and load eBPF programs into the kernel. These range from Specter s=
tyle speculative load side channel attacks to verification failures. The de=
sire exists to permit programs that use eBPF to run as non-root as an effor=
t to run with least privilege, but this conflicts with the desire to limit =
eBPF program loading to root only.

Proposal:
Enable signing enforcement of eBPF programs (https://lwn.net/Articles/85348=
9/) and permit root to set a policy that permits non-root to only load eBPF=
 programs signed by root. This would allow root to delegate permission to l=
oad specific eBPF programs to a non-root entity while continuing to block l=
oading of arbitrary eBPF programs. Root could then verify the provenance of=
 eBPF programs and then sign them only if they are from a safe source and h=
ave been compiled with appropriate speculative load hardening. This approac=
h would appear to give the benefits of least privilege while also controlli=
ng what is loaded into the kernel address space.

Background:
The eBPF for Windows (https://github.com/microsoft/ebpf-for-windows) team i=
s exploring security hardening options and one of the options on the table =
is to use signing to restrict loading of eBPF programs to those designated =
as trusted. The desire exists to maintain a similar security model on all p=
latforms on which eBPF is supported, hence reaching out to you folks.=20

Thoughts or feedback?=20

Regards,
Alan Jowett


