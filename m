Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A4C4160CE
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbhIWOMU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 10:12:20 -0400
Received: from mail-dm6nam08on2130.outbound.protection.outlook.com ([40.107.102.130]:21918
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241712AbhIWOMQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 10:12:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK2y+iiXOIHkkwcoblrDSmollylqjARtxtLwuA7roJbYaSBFNpLLAJJVw9s3lrin+aFfcNOKGnkjF/lXzRv9nRZNqMYQYVGEZTqAnvREx6SWKYpzcFwYbsdj0tMkkEO2WUT1/nTxLt02lpvCqAfF4q88i+xDHOyAix/arl12Sgp9EZQKiiTel/bOEn8p6QwUm3sZHKur3oGs6KSGf4FMFO9NewDMEDmv7++LauHXUIqZFJvTZgd6697ZWB+7vuHYBYSy41QbX7CEev5GHNQMt5N+IkH5L57w4OogDwMVRhCSp6VAJ/7IhqytQgmXD6imy0AS/kWmCfFRJzZgeitHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=C4mzMmIDbzHwcojrMXDx1yhPBVAP2XEw/bgv1MR/SKY=;
 b=NQjgGaotZcfQPKaMB2m+snN7jrx9SlKbG9yPGPiI/klsOvLbjecweu8YoDlbofsUp6nkS3G6UYVZgFkd+5KAnGPsGx4ieQIMWpUsKMbJ9BAfYrv5cnub3Er5nT4U7RqSpaWMTjFtmFZaZdj6Bl6Lv4ld8iW32Plh7hiseSZMJ7upXNELueeJk1O7VdkuALvyzkVFTKR9L+Vd6v+l/Ah+VTahxwwpDkHdHeYUhYX4aii4dlMi+68wAzU/DIl23gOqSs8Sdk/EtQvYzd176M/H8989IgLsCqMrNdsQA6POtlc0u1eIaLxY4JJYlQhb4bLFQvpCRQ19EXqbYlH0Gy0D6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4mzMmIDbzHwcojrMXDx1yhPBVAP2XEw/bgv1MR/SKY=;
 b=tVTA+2s+ArR1jjEaXExNhNyhD2BssJ19lHCLr41iRZJtMmvfzZjR4xfHJXLWDvEYlQiRpaZFEyMBbBIRi3zKwd3leCkOcbFSSl5D8wsDaz9ibq8d8MC4J/v4Wdp/ocUWnh+kKvEIEGakAELGHHieYFh77nHbAsyfzpuJHjrGH/o=
Authentication-Results: isovalent.com; dkim=none (message not signed)
 header.d=none;isovalent.com; dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5050.namprd13.prod.outlook.com (2603:10b6:510:a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6; Thu, 23 Sep
 2021 14:10:42 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::e1d9:64d0:cb4f:3e90]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::e1d9:64d0:cb4f:3e90%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 14:10:41 +0000
Date:   Thu, 23 Sep 2021 16:10:34 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Luca Boccassi <bluca@debian.org>, bpf@vger.kernel.org,
        bjorn@kernel.org, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, daniel@zonque.org, joe@ovn.org, jbacik@fb.com
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
Message-ID: <20210923141034.GA12692@corigine.com>
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
 <49c54bf3f4a95562592575062058f069654fd253.camel@debian.org>
 <a92cd043-30e8-c26d-ffe9-3521322ce71b@isovalent.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a92cd043-30e8-c26d-ffe9-3521322ce71b@isovalent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AM8P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::18) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
Received: from corigine.com (2001:982:756:703:d63d:7eff:fe99:ac9d) by AM8P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Thu, 23 Sep 2021 14:10:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c97acc-3a42-4058-faa7-08d97e9bed47
X-MS-TrafficTypeDiagnostic: PH0PR13MB5050:
X-Microsoft-Antispam-PRVS: <PH0PR13MB505065F12F405AD27473599BE8A39@PH0PR13MB5050.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzHQdFoP+cRJK78SRemhbLoKdXAdXertrTf/E6xDuBZsLiRlcMPOJpd5an4IEjVA/kJ0vop2oqUjhYQg1FOGqtpmEX7h+X3V1LXtf6OTwdLQ5Snr+wp6CEbDp5yYleE7bvQBhWFpZICjCge1n8z3hJvHhxUZc3VwbQdnooqSbJ+ZJ8lbZ7juOp3brKuuAlyo3TZy2K9WQ+4yXCui2C78HAbz6tW+UYjR75VSlq5mrMbeSN3WI40OQgA/qrKys8Yq4lSl7b/kO5uPpK+yTFscLjMWSoIOXnbtuzPVPHF7BgnWq77V1d5UGrr/GuYfMG6MFRszx7xuH0veb9/rrIZU/vQF8058SPT+uYRFw+hsnyH1138qB2thTbi0bjz1aRvnNPfJqrkFzguaideOg1i445B3pRw2I5X5+Xa8leRrQjkWm7XtVsczcnsmjOyww8HvzIKcDDt1ytmV0Xm0Jth9yXYiT8UZxTqKA/6hgLt8emS/aEGNnEeOeTjulPYsaZh1bx2ch53+LrQWDW3EiBZ0Een7T7kifeFMm5Cel4u9yycTjnuHRk9tqPzoTeVDdtntVHgk8BqOIqz0AdOXZ0LYHIyOZ9y96kb3F6n6F/WcmwsOnAbo4zp9sOb9keXYRwltDAYJe4LhjsXzLo71a0crn4DFFuYbkL/8ufO9yIl2GzgQc74tAG5JcD7GdW3Pg39GHAYKF7mbHIbUuYipN/n/mebrSGtiI+JbWYsOjQkCDKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(39840400004)(366004)(83380400001)(66574015)(86362001)(7416002)(186003)(66556008)(66946007)(8936002)(7696005)(1076003)(8676002)(66476007)(966005)(33656002)(4326008)(5660300002)(52116002)(38100700002)(316002)(6666004)(508600001)(2906002)(36756003)(44832011)(6916009)(8886007)(55016002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em43anpyZEVwTElpNTZkV0FMcmFGTUs1NWRwYk5TejJhK0pzd2lWRThGQU5T?=
 =?utf-8?B?M0VsUE9YQU1IR3h5MHJZaFhzUHlQZ090bWZwZ3VkQ3pHT2kwSUtaRUhYSk9o?=
 =?utf-8?B?TFJqekMrbFR1TXUrWmo4cUMyclZWakV6eEtHMGdtTTI2ZlRpOHpaSDdjYXQ0?=
 =?utf-8?B?cWtiZlNLeitYSWhKT1UvYkJFMW1PWkJQNk5XendUUW9hMmViNXpCSjlMOEZ6?=
 =?utf-8?B?RmpoQmEwM0cxam1objcybk1VRVNkQ2VDalhGa2ROSks0ZEV1ZVF2UzdIdGZM?=
 =?utf-8?B?bW1tV29jY0NMTFJYY1VrSWlKOHQ4RGpHeHYzaUpBVjREdVJOVGhOZWNNbm9l?=
 =?utf-8?B?TG5xNUFYVUtxS2pLTExRbEorK3hScUhGbEhIUTBPV1ZvTHBhc2luSFI1RndR?=
 =?utf-8?B?MHFQT0pPNGNJeGVqSDZ3R2oySm55Um1XeW9HS2x1am4zQnpTaFJmOFpsVUl2?=
 =?utf-8?B?RHZOR0ZRcVdBLzM4NGJMUUlWNEFFbXA2RkZ4Y2VyQmVXT1dGOUpkU1d2TFEy?=
 =?utf-8?B?UWdOVE1vclZhdlNSWTlENjZ0WjJDSHZ6VDh3cnNDaFlXTjRZbHJFOVVYdzV3?=
 =?utf-8?B?MXJVS0tRZmcrUVZIOGpBQk9tckdXSGo4K1hSbkNadUFvNGVFLzBJS1pFcDBN?=
 =?utf-8?B?VTdiNVFnNlJLekhtQ2RNQ2RKdUxLd2hRQVFCdk83ZHR2UktTS0NhK3czajNy?=
 =?utf-8?B?RW9QV2Uvdml2SXduV29FRVh1akNuRHhpbjFOUjNYNWk3Nk9sTGZFZk1Bb3dl?=
 =?utf-8?B?UkdzWS8vYWJRT09ReXpmVlk5aE9FRHZmT3ZjUG9oTVI5K2NKUytlc2FaU0dO?=
 =?utf-8?B?QWV1azJ5TFBYTHNSU0lYVFV1VnVQWElzUjlYRHpETXp4N2k1U3JZeXQrWkZu?=
 =?utf-8?B?Mzd5MlhwTk5VVVlicWhSdTZuK1Rha0IrQkQrSW8vUmh3UjZqVHBEN1F2QWR0?=
 =?utf-8?B?ay8yV0hHVytmR0ZpbHBnbVRxOU1NZ1ZNK3dRYmMwcXVnZTJ6MG10NXErTVlC?=
 =?utf-8?B?KzRvTjI0Q0p4YythM2QwTU0xMVFHdUp4RGhaTDVoYjBRQVhtSTBNNHVmaXpr?=
 =?utf-8?B?MTdQT05pdEZIclVSZENEUUdWTlZFSkZwelkvZ3ZTWnBUbEhLK3k4V24va0p2?=
 =?utf-8?B?UHNJc3N5QWRqcnlhd0Z3a004bXdxWm1BMjVJRlFkeGRxNnJaTlNDc0p3L3hU?=
 =?utf-8?B?LzRTSXZDeE9zczY3ZHBrY1V5R0tBcnpvNEZwTUJoV1BpVGdVbXhQeGZjR20v?=
 =?utf-8?B?RUxWRkJOWFFUWVlrNURQTSt5dmQ3bEx4NHRIQ1h2Z0hLa3NZV1ZWVDFMS1hT?=
 =?utf-8?B?MGh4QVVTZGtUYUlzanZCY3BRZFd1eTBVTlRnQzNwTXNsMEsya05GSCs5S1hR?=
 =?utf-8?B?RWhTUzJmMFM0dFlrWjB5MFhGTitjWFdEMU1CM3NKWjFkM2xUV3lBS3JzS0Rs?=
 =?utf-8?B?Z0g2WW5GSUtOYnYzdlpjaW0vaGRuUkk2dDQrZWV5M3FtMWxlK0UzWGc2cnk2?=
 =?utf-8?B?bFJBZW4rNEhZeDJqbjViZE1WdjdDWjJjeE9pNXRuTCs0cXN3eVZLeGRKM0FQ?=
 =?utf-8?B?ZTdIMmRaaHIrUG12bXZhdTh1ZWxJZHBKQ1d5amQrVUlNdklOU1NTN25mWDBq?=
 =?utf-8?B?YURBWFRrMGxCLytpOHJlTGRkUEUwRnh3aFlFK1krdCtDczY0dzVQcjNpZzVD?=
 =?utf-8?B?YXhwRzJKZkpvWjgrNldWS2xJOWJleFFXQVR0MXQvdThMUlZ0SjE5U0tsSlpz?=
 =?utf-8?B?dGp3d3MvTGNlTGpIbS8wMW9OOW9iOTNZam1JT1NJeWxiL3JmVGVLWXFSTXBC?=
 =?utf-8?B?V2lSYUNlTG15cjdNVXJ1L1JFYmVkVUZoVVJNMzUwRlk4YjMyTzU1TXl2aHI2?=
 =?utf-8?Q?OZ7YWjsvKmYi4?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c97acc-3a42-4058-faa7-08d97e9bed47
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 14:10:41.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJneLA5+AOZrASJzWCm+9T8L6gx5rgNd5/BVS3nVKf4oF27hMHwq6odfRkfDqkWbvzCCql3+wCm3wE/yt77NAomH90d8zSz6MZU+bkihkMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5050
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 23, 2021 at 02:42:39PM +0100, Quentin Monnet wrote:
> 2021-09-23 11:41 UTC+0100 ~ Luca Boccassi <bluca@debian.org>
> > On Thu, 2021-09-23 at 01:05 +0100, luca.boccassi@gmail.com wrote:
> >> From: Luca Boccassi <bluca@debian.org>
> >>
> >> libbpf and bpftool have been dual-licensed to facilitate inclusion in
> >> software that is not compatible with GPL2-only (ie: Apache2), but the
> >> samples are still GPL2-only.
> >>
> >> Given these files are samples, they get naturally copied around. For
> >> example
> >> it is the case for samples/bpf/bpf_insn.h which was copied into the
> >> systemd
> >> tree:
> >> https://github.com/systemd/systemd/blob/main/src/shared/linux/bpf_insn.h
> >>
> >> Dual-license this header as GPL-2.0-only OR BSD-2-Clause to follow
> >> the same licensing used by libbpf and bpftool:
> >>
> >> 1bc38b8ff6cc ("libbpf: relicense libbpf as LGPL-2.1 OR BSD-2-Clause")
> >> 907b22365115 ("tools: bpftool: dual license all files")
> >>
> >> Signed-off-by: Luca Boccassi <bluca@debian.org>
> >> ---
> >> Most of systemd is (L)GPL2-or-later, which means there is no
> >> perceived
> >> incompatibility with Apache2 softwares and can thus be linked with
> >> OpenSSL 3.0. But given this GPL2-only header is included this is
> >> currently
> >> not possible.
> >> Dual-licensing this header solves this problem for us as we are
> >> scoping
> >> moving to OpenSSL 3.0, see:
> >>
> >> https://lists.freedesktop.org/archives/systemd-devel/2021-September/046882.html
> >>
> >> The authors of this file according to git log are:
> >>
> >> Alexei Starovoitov <ast@kernel.org>
> >> Björn Töpel <bjorn.topel@intel.com>
> >> Brendan Jackman <jackmanb@google.com>
> >> Chenbo Feng <fengc@google.com>
> >> Daniel Borkmann <daniel@iogearbox.net>
> >> Daniel Mack <daniel@zonque.org>
> >> Jakub Kicinski <jakub.kicinski@netronome.com>
> >> Jiong Wang <jiong.wang@netronome.com>
> >> Joe Stringer <joe@ovn.org>
> >> Josef Bacik <jbacik@fb.com>
> >>
> >> (excludes a commit adding the SPDX header)
> >>
> >> All authors and maintainers are CC'ed. An Acked-by from everyone in
> >> the
> >> above list of authors will be necessary.
> >>
> >> One could probably argue for relicensing all the samples/bpf/ files
> >> given both
> >> libbpf and bpftool are, however the authors list would be much larger
> >> and thus
> >> it would be much more difficult, so I'd really appreciate if this
> >> header could
> >> be handled first by itself, as it solves a real license
> >> incompatibility issue
> >> we are currently facing.
> >>
> >>  samples/bpf/bpf_insn.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
> >> index aee04534483a..29c3bb6ad1cd 100644
> >> --- a/samples/bpf/bpf_insn.h
> >> +++ b/samples/bpf/bpf_insn.h
> >> @@ -1,4 +1,4 @@
> >> -/* SPDX-License-Identifier: GPL-2.0 */
> >> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> >>  /* eBPF instruction mini library */
> >>  #ifndef __BPF_INSN_H
> >>  #define __BPF_INSN_H
> > 
> > Got "address not found" for the following:
> > 
> > Björn Töpel <bjorn.topel@intel.com>
> > Jakub Kicinski <jakub.kicinski@netronome.com>
> > Jiong Wang <jiong.wang@netronome.com>
> > 
> > Trying again with different aliases from more recent commits for Björn
> > and Jakub.
> > 
> > I cannot find other commits from Jiong with a different email address -
> > Jakub, do you happen to know how we can reach Jiong? Perhaps it's not
> > necessary as it's Netronome that owns the copyright and thus your ack
> > would cover both contributions?
> > 
> 
> Hi Luca, I believe Simon can handle this for Netronome, I'm adding him
> in copy.

Yes, in the recent past we have handled a similar request like this:

Acked-by: Simon Horman <simon.horman@corigine.com>

