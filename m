Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A822874159D
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 17:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjF1Psj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 11:48:39 -0400
Received: from mail-co1nam11on2091.outbound.protection.outlook.com ([40.107.220.91]:47282
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230262AbjF1Psi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jun 2023 11:48:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXa4SwAftGzQF0eorzJx8ebtUQmOH2bLlebpx/PztaEOtevu/blzv5wcU8+EPXpxFzwRVHphZ4Wu5ESiauB5w4+uPH7JQuhXz3QTcZW7whrr8R7LEwQKoon+p07GJbhljxNfAfLzOYoD61kuxzDFgKizNEhBDNzEpjNif4NE/nunTkEIhq2E0XMG5ra2ke3aRHj93PRHWmtAsIyg0o+WM/b3gbuhTAkJ93Qj7h6IMA/pi9Tkdxpr2NyzNq57MZSHMJK6CdePmLgb6kP2ZJMgrX496i89eLM0fAY68UeEbyH9jLEOaaTcDWlGJ91o3W1o6U4WWG6M3e0hH4nbbg2FDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbRZsfKFgIsWRnvKQn8IpO+HV15QSam2cMJK++qxD9Y=;
 b=n/fTkaI+YO4GBCmQDFQmZCzQ33WVnro+fNHF1pf6YbIHj7JkkTMdd/cUXoMPrZvv1toOriotI16Ho09YqBY6YFsnmRKMBx+RpewxosWKsjBvQkvixF5V8Mel9NhcGZS3fG3/cClRNs2ra/QopfugO2y/0JJozs1UehE6BOkr10qtgw95JFzkP2ExoSosmYGqeUblR7htyVSJKv3KXAncmKbkPwNDWqysKj5sgbj6LXRc6QDCqlGx1BHmleEiEeVarRMYCkX8LibX9Gxa9hQsBn947L3baxpB+5TaqFeY+moGp2HV5w6hmNsYMgLUOWliY+0Rg8QB4wilNZfLgw20JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbRZsfKFgIsWRnvKQn8IpO+HV15QSam2cMJK++qxD9Y=;
 b=bqcxaOTk1gDi9dmmcVHjyy8ICkBCB+ydlL+WwG1AQlVTTCNJGz5vFnPRF94QrWpRfBOcaE8KqTjoQAKkBsIWwZ09OrZzAaY8gz2NkhOVhNLyQkAYa+uyvJNYf1zb48HnDOntI+r7KIM1QEMMRRCZmQ2Yn3yZNCTiYpLEO9UlNuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY1PR13MB6237.namprd13.prod.outlook.com (2603:10b6:a03:529::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 15:48:31 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 15:48:31 +0000
Date:   Wed, 28 Jun 2023 17:48:23 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org, tj@kernel.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 06/13] bpf: Further refactor alloc_bulk().
Message-ID: <ZJxWR9SZ5lya+MN+@corigine.com>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628015634.33193-7-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: AM0PR08CA0030.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::43) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY1PR13MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: a360ea7b-908b-43a2-3cd1-08db77ef1f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJqymXsUnLhdXBQj5ibtyF7X1Py+n0J2zKQ24ndWSKgfxFt07iB7Dnorf6o+bx9y+UMhvMA41tzdT0h1Z8laIJNqVxceiJqfGUeXdD4KNklZFBvFvKNonIF7BbaYI+JAT+DWW8JpPan0l1O1vQ08VlF2o66F+EMnTyt3RhNGAwFL97ndzJ0JVLvvs0nF1Za55EOu6nJRjuLAkcypdbs1YUMskB0UkohhyDBNwN9Ezj4Je25PI7G73uJlE3CO0bX+bWl8nXal3Wsdr/ewhLzFMv1Bq9JBN+Y3pjL5/QoAa3d09CtbpdzcwmlMXJCg7LqHEDirG/JVZAXQxVJY/G4Ueuw/saoBoZtetVVZHDoChKBR90O/Mz4S33tWKhi6O+Trg8iEH5EXKXfxCvYsOTGL3NK7IFo8h/Y4WiudR9mh8k/YpK2qTP0GbC2uZLnbx56Et8zijpGP1Z9WP/RroJ3M5mPC3hI0INkjAP+PY1rTYXI7gMiQv13LS9qYVEcpAyOfWORP7sW+2ctSy6ln7aQrsdjHTMGxZJ/R05Wz4qh0jTZp+9skWMrr88twUaqerV5EF9PPjbf68egEJoBcHYzEyU9LhkArWMkrDdHuP55tDYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39840400004)(346002)(451199021)(478600001)(6666004)(6486002)(6506007)(4744005)(6512007)(186003)(66476007)(2906002)(8936002)(4326008)(66946007)(5660300002)(66556008)(316002)(41300700001)(7416002)(44832011)(38100700002)(6916009)(8676002)(86362001)(2616005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQzIqs2eM0HwxBm8/EoW+X30iIwRBFzlyrpG4yP6l8VDza0Ms4Ngl/lwtd99?=
 =?us-ascii?Q?k8PbYyEe0AYtnnFL5PrVFh2M59MnMZsnuIW3EG0Sb5r11xJ9yU/Wwizgm2If?=
 =?us-ascii?Q?H7Js8Lh+pODojLcUO70xBjJytBk/gkBmf4Ml00gLRRFoiFgfCLnV4/wCZLVi?=
 =?us-ascii?Q?OEIjnOotGetTnnyp9eioNLIfQlqzF/4/SLMkjtQkcIbXPRyLldktpgWRwbxq?=
 =?us-ascii?Q?d7fVEzupa3OBMel75IgyuD+Xpqi3IV3Se0zQ1D8rABHz6ua+VAFzhBry2B/y?=
 =?us-ascii?Q?pFgA1Qb+fs7b/NzEtZ7rNNfU//EYOQCQ9Uz4tv36Z/8nZC97Hk+5Qp+yiG6z?=
 =?us-ascii?Q?QGkwJrGyjqA7q4no8CDJvaangGhRZdnOshsQgjF4iV+JzhTEsSdJcZ07wIaH?=
 =?us-ascii?Q?dTUhGCZNjO9qqbiSTt9pCJIf1wh77qRaA7jO+VhnqzMPufU/TWPk0N7SHZtr?=
 =?us-ascii?Q?dwlIp7sgvhgElvQgtPNOMfdLrrOXWiybm13bxSsIWLSpk6yOauda/kEVejn1?=
 =?us-ascii?Q?ziWypwk/POvve1ukZuu+vqW0eqAWsC7jN5qyclfqQuuiB1FFANi/eZxtwBqr?=
 =?us-ascii?Q?afOrlefFjuQAftEmBeajTS3o2wslFY3b81QogZo5bTouheUe6ejOa1Z6VFhB?=
 =?us-ascii?Q?4bkaspqaEYe6r+clexPqafiQsnNFr8tg7LOqE/b1ZfV/TgYFiDHf0xFEW75G?=
 =?us-ascii?Q?MTZ0lyf4RxRpq9SSswUatgVKCmWeHmf0Bf3E+CufS2TxxvD6JO6/lvc9WRwx?=
 =?us-ascii?Q?hdnsz8bOyEFjOIQgrgeqOoRofr2K2oZfT03/5KMpTMogwjvqciR0cvO8yn5a?=
 =?us-ascii?Q?ApKoCBRBYslOzXsYBpvND40BwIxLS2WH3UhK+gA7969e7E59/Bw3Zgylzx/1?=
 =?us-ascii?Q?8dnZkO1PhsLcrHS0JtqovvK80Cs2+jAkqc/miU0Tde3hxHlFenqZ9wmqQ1AH?=
 =?us-ascii?Q?iisbCgUILA/iJK2mYQ6Nj/JnQkiAjDyXjVpsPAipROIrCekBPAMYmzGGESIL?=
 =?us-ascii?Q?dFmOk2EifaPNfxQWMlblYllMWL6R6BqBSq9psZOwALJhYU/wpwuUuP1yo5io?=
 =?us-ascii?Q?QJmBswKR1WmwvaZP0Bt59f1Go6NiMno3kq1PlKfs/b/V2XvGAQ6xrSJJrRoL?=
 =?us-ascii?Q?kCdCHhI9QMrAruu1i4HZUQCrVEKbF0dnBRPAybjAuPV7O65eBjg2scNqRxtA?=
 =?us-ascii?Q?sy+pRhsaiIA7O5K4rIv+0Y0IlhxhupGTBTuFXPYlQGN7zlaGiUi/QiWRmTce?=
 =?us-ascii?Q?Lqmx93fnzICBp9qfc5Sg9K4GCqr5CYKo4u2Hne3kzIT+dwNhvx99PN5gCHoF?=
 =?us-ascii?Q?OZqIAUEJrKPvCrzcpVOB6+bFo2Zp9AX/r1yoGNOdiHUqRn1TqlreZJ6HJrBg?=
 =?us-ascii?Q?iOy8kpba8H9uFKdUIAI/8fCiPaI+VzbtRBPIenCCYklIRC5I7fimNR9Y+Sxr?=
 =?us-ascii?Q?0eN7rf9o3/QYZeXUnlYimaiVgGbnThPmcfWgu6c8dymJmCz6z92Id4yk0v2r?=
 =?us-ascii?Q?I9EFJTz00QA5+hApEKPIpt5YNKIZa90yfbfeMBlnz5ab4LbErvV/xCXS57UH?=
 =?us-ascii?Q?EA+V1GEnTrvwQ927rNiVcY3H9/dTAObR9DlGrYX1PpQWj/YfBWROWdv5kxOE?=
 =?us-ascii?Q?pW+j4VH/ULgRkUS1GcJ8q1TMkqlUOqVbyvb1WoordYUSAvMrco0GcvaZqWFE?=
 =?us-ascii?Q?BQ7o9Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a360ea7b-908b-43a2-3cd1-08db77ef1f48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:48:31.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRLVSE0AN8RC2ur44YseP5+AKKxV+UZMcofMYob0XQYmg/s9uz2LrFQZS2mBYEM9jYrHj9KFMR3L/7J2UB6E5+f1k8QayOiB4qTLF47XLcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6237
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 27, 2023 at 06:56:27PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> In certain scenarios alloc_bulk() migth be taking free objects mainly from

Hi Alexi,

checkpatch --codespell flags: 'migth' -> 'might'
It also flags some typos in several other patches in this series.
But it seems silly to flag them individually. So I'll leave this topic here.

...
