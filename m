Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6C754D0D0
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346483AbiFOSUM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiFOSUL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 14:20:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA70A3CFD5;
        Wed, 15 Jun 2022 11:20:10 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHPXPa003301;
        Wed, 15 Jun 2022 11:20:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=PLsR9gLysm493qDnl7rEDIazxyv8VH3gVqeBWTXNCLc=;
 b=ieSgb5bXcRuR6Ig74Ax7jXieXnmUwzZOsIaIr8/HJ7E6kyqYRxr/e7mR8QbhKObIuR7+
 DQeB41ID5kaz7DTC+o7WlN3yOCAchDvOd8L58kadtMczFwe78wXsC8L2v094Jmv5zOSr
 6+Z96x6s/RRnUIoN+ZDWAh3il0IqPTsXuMM= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gqktg0xuf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 11:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/bPgKFZf8SW/JUNfbDMXqBhfNVg5nSlCqK5nGRjOaWzZ/atte/VzqFxU/A8ctqMOxmueE4gggPMAyvkd1bxupkX02zBUxOCBx12NgtqSOgQR7QrREShZRJrdoh0MoDV/qaGcK54yg+DCF1DPG4fkTFBawX+adP2XY6nmSKEB9EIorv9DjEYTHReZB1pSmPbwnMKG3IsD/PPjtwB+tNb4rFEue2N35k8YeA4UcsD3ebuPCFxKK2nJaB7TL6eZMDbLaAZG/sxSx4uL6bFP2cPErnEfQMzgYo/V0MuWO7o+co/okUpkVOiHydMWYer1iGfHDyg9yxlFt+4c88845USUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLsR9gLysm493qDnl7rEDIazxyv8VH3gVqeBWTXNCLc=;
 b=lhTDCljfr8qhh88/0qaUyAvOZpY5idE7RVPs6dXbZZUEfeRHEqCkts1Q1R+Rhr9FK+n3bgAkoA0moqsX19lhD3co4T/uIwzBQGmOAgfYLKxrkdPhSxv1rLpnmg6zfLAR7hZiy8OSYwyWczaFV+SWq+XGAsg/MHRYx+MUZo69gSEz0MAKHIo4SPuo0JKCHLwC08H0zh4w1CdKuCptvx9z/8mClLPb1pAq9LJV8SwQfytrqMcKVfd1kHK/FLbf9VtbqWV1aXxxDIWAyKslyu3pZku6IO9DnHCl5zgaOBqoyjgsS1sS2O6h2G2GmIq3MlmdBbmxzuXpt6MQMZzxdkFEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3452.namprd15.prod.outlook.com (2603:10b6:5:164::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Wed, 15 Jun
 2022 18:20:05 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::b9ad:f353:17ee:7be3]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::b9ad:f353:17ee:7be3%6]) with mapi id 15.20.5332.023; Wed, 15 Jun 2022
 18:20:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH] perf/kprobe: maxactive for fd-based kprobe
Thread-Topic: [PATCH] perf/kprobe: maxactive for fd-based kprobe
Thread-Index: AQHYfDdvxGSxEZV2gk+Y68sd0Icii61Q0KIA
Date:   Wed, 15 Jun 2022 18:20:05 +0000
Message-ID: <9AB360B5-F7DE-4159-B75E-9C21106FDB49@fb.com>
References: <20220609192936.23985-1-9erthalion6@gmail.com>
In-Reply-To: <20220609192936.23985-1-9erthalion6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16b2b62a-21d8-4da6-12be-08da4efbabb1
x-ms-traffictypediagnostic: DM6PR15MB3452:EE_
x-microsoft-antispam-prvs: <DM6PR15MB345255B28A2353FE30E8693AB3AD9@DM6PR15MB3452.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ia5vlK7AbPlTvQlF3YMUVk+ymluhgube2j8NS2Z9uE2fIS02aPQK6N7nO5AL8Qn0tNjJPkCZLkl8JBa8N4ZuV5P4HXpRXj9LSd4JrVwUc0FJUlrNwoRCkkGNgzP1hvZ++IoWIVSAXzRlwDw75Xc3hBX0lF41VGSUh303qDX2zj7OAU4DRCALAKwo7TCjI5kL3lvamq0t7dp6nldbOwMDr8HDCsYVms2dgHyhwd62ALFvX4f99CrgdTd8dN8zU+kw4WeaZ39iwX6fLihaatQkRPhLyOjbddYNrVxQOtvzTO8gx+UFok94X8t0l5ZvfYG4gkU0rBDA8AnKezB82CB8WPaw8P+RuIEDw8kM8ks/3+REGvT/5fPP7tIF6gRv5REXWgMKJWK5T3KLvrT3H8cQfzwEDBSm+NPUH1n3LZCWOUkCPbfPqlrKUwp48L+CNqdffVHncuYCQF+DRScLvUlyS012hTRm7v8I1f7+Lo7OVdZsUA8D3I9s13EWcuiWGJzU5G5fgZEgQqt9PEFonUyKy4c9CbEeWzu7duZYLe6MO+meLzIDseWuZnYLL1XPw+Gl6AWC+j4uLQVpNumZLOokZFpU656Ywr43BcOP77toFVbpJuOhYwh7sYI6tv17hNhaWwd6e9fD7zA4dvVvgMVs9kNTMHWaLhxE6FrWV5NQKQf4nTGXYih6PPa4uvJov3F9i+7C2PVNbbVv+go48bpBFq5h+0X8sdyXLtg74ZxYy47qDIuxFKB0UP709u4xeLGnBtIG/LE3L/joWpiBHo/2ZpK0Z/lrEQinvDtqGSFQ60Q4SG8C6g8Vmq1D1HVwI8gbB8cWFXhi44QTzWtlUygVIUC1ZL5+X2Xj9jw4H2pt76w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(122000001)(38100700002)(2906002)(8936002)(38070700005)(966005)(6486002)(64756008)(508600001)(33656002)(86362001)(83380400001)(6506007)(53546011)(66946007)(6916009)(5660300002)(8676002)(66446008)(76116006)(66556008)(4326008)(91956017)(36756003)(66476007)(6512007)(2616005)(316002)(186003)(71200400001)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bhVLRdvnzUwkooTJPd+443srf8AmffQUjH3pZ48sb1qybfYyNAyuuQAhXoPW?=
 =?us-ascii?Q?eFaTNtlibg5nCPUP4ZGpu7pKPe462Ghj/9u7wN3CAdxv4hlrWUv+MucBOqdW?=
 =?us-ascii?Q?1346qBrROfg9WrAKWJbmDKyX/MePN1VtJP8qAZc07oUaKsYC4sUxwRS/882o?=
 =?us-ascii?Q?xkFd+9QWSQ1kaq/OpQnO6f55IOl2G6TLdGE/7/k6Uwx/pH6rvAFSjoG+mus8?=
 =?us-ascii?Q?Yij0p2iq3j1fU8H+xV2FHYgdiPEQhF+w6GTa37g2En5IuEJjX0eXCfbZV9+D?=
 =?us-ascii?Q?XkjgiWHPqALNDdvbzSiYtVx7fuzIIOlAyNHMrUEtp3xs0uFLh6cfB5m7gs7M?=
 =?us-ascii?Q?/vIsNvOOaNZo4HdLt/ykBYmqzVAeJqsbRFmup/4BOM5KwmF1j7rSAP1DQFSb?=
 =?us-ascii?Q?bhqaqX0syARL27UPaWZ6eYCwmGcrH30Wnj+WwrQnCJQ++jiCI+k3TiCg9KvR?=
 =?us-ascii?Q?bm6jla5jj4hi2eoQ9n5ksCk9TWO25DjmelGGJZxFPygmp5qcQOkeAIrFqLqC?=
 =?us-ascii?Q?He4T2GXGn1g8+EWDrTB7Aitx0wf42Tl8kUa9/iOlasY8o9FyCS7nDEMZjr+M?=
 =?us-ascii?Q?Cjw8aHhL6lewH4ctG5IuOOxrd01ZvttvSoqqzLiNUYOHLkS6epNDJf2mp+tM?=
 =?us-ascii?Q?AainmodLFgH3axeiMxgNo6u2LACt+giNi7nR5sa0B1uvCyshbe9a5lby1TGq?=
 =?us-ascii?Q?kt8uulnuhnBJOvLd/Eg9s6gOuYU91SPBGZGJsd/o8e7px4po63HwZHLO9/Mt?=
 =?us-ascii?Q?Ir0skrfVrQAvClo5qdigFe/dyNWZhXEOz8ygvu15Lk3nBL+eVTPbPb91orLD?=
 =?us-ascii?Q?D+vpRrpFqYy6iQJUQQSu7xlyFJIQlMT01QfH9qNlPsc+ncIT4NSJ2o+kZHjD?=
 =?us-ascii?Q?NXn7CPT54vT+AuFVCZ4ccaYgKb4NENxnJVf0JPq8s0fbswCASbqYwWa+hh29?=
 =?us-ascii?Q?fBYepW+LBbipMq2TGj+ay6BJwAc4FLCLRif2mC+zDA0vOGMXYYM51XqUsBzU?=
 =?us-ascii?Q?E4Jdys3HPSAjWpaLEpeyRNEVaeQ2F9BoXeyLceItRp3uCNIz90Aq0iF7pic+?=
 =?us-ascii?Q?u1c+Q/HU2fs1TwsDHZfpQQLKtDf7rQswyT3AdTbgF1KXOvnu2RHE3NMd4pvA?=
 =?us-ascii?Q?8REpNv6frR+7f4sEBjhkH00I3QtnmYdI4O/V0bPXwZ+hZCfJPmqkMlJz3Ls/?=
 =?us-ascii?Q?Zp7z3LQMF5vNjtLT3r5K1msS3tFwiYynl0AcRWXtCXFRgz0Ui/dq1Zvkq2CU?=
 =?us-ascii?Q?v5WSBbNEcsewlzji/pzhRAQuOg8ZOEV+bka3k/U8LDG8Ab7Ri1InH7PHG3/Y?=
 =?us-ascii?Q?qsX+3fK+nf21g0qbA4RwmNKCI+OZ2pTFVu2supwLLt+IHfS/fma3K4viALSu?=
 =?us-ascii?Q?Y080TWcFf4snYA2c0Te6s0OXpkEFtRRGZTY7xBsdTJ6d4dpYuniJCf4jU1QH?=
 =?us-ascii?Q?b++hOTzMqmZ89aObRejItaoGzSnqwweT59XNOA9guK8RgFiYLHpmpv0m9m98?=
 =?us-ascii?Q?rhLCef3jBvPbG8SQQ0h6Xers2qbEep8aeX9Nwn4STMFqYDcqoiJi4VfX9NEX?=
 =?us-ascii?Q?ZSHwAgf9pSi1AE9Y+0ELxGvihbD0R+abnRI46KDhP5GLGxBGjQCJMHcJyPkt?=
 =?us-ascii?Q?Ra3HR5ijGjggv+DpLmDUglR3lNNzdB3ZaidcLiB9ivVsF85ZrUbqI4VEHC6K?=
 =?us-ascii?Q?AWlElEENQMjq69FLsUuQ/Dir9flzSFm1TBZ8+hXRYttqv4lb9ogOBNZ0Kf+g?=
 =?us-ascii?Q?85NJoEYgY538yR+IVvmacvSJ/JLEDz0qKPIybOfKdiIKWky3yBQ5?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C1086EE61AE534EA4E774246CE03A46@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b2b62a-21d8-4da6-12be-08da4efbabb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 18:20:05.0144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dz5H+D/e7LvbhWYYNg+9I0MuInH5I0Ef8f/0+0U+jStFDNTOzqOhc5XuWLWDo4Y793lfhqYGYYv6mHvoheCYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3452
X-Proofpoint-ORIG-GUID: nSC4qTyVm3WsXHzuWpzEW60oduh2NMPT
X-Proofpoint-GUID: nSC4qTyVm3WsXHzuWpzEW60oduh2NMPT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_15,2022-06-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jun 9, 2022, at 12:29 PM, Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> 
> Enable specifying maxactive for fd based kretprobe. This will be useful
> for tracing tools like bcc and bpftrace (see for example discussion [1]).
> Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.
> 
> The original patch [2] seems to be fallen through the cracks and wasn't
> applied. I've merely rebased the work done by Song Liu and verififed it
> still works.
> 
> [1]: https://github.com/iovisor/bpftrace/issues/835
> [2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/

Thanks for pulling this out of the cracks. :)

Since there isn't much change from [2], I think this should still show 
"From:" me, and with "Signed-off-by" both of us. 

And a nit below:

Thanks,
Song

> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> include/linux/trace_events.h    |  3 ++-
> kernel/events/core.c            | 20 ++++++++++++++++----
> kernel/trace/trace_event_perf.c |  5 +++--
> kernel/trace/trace_kprobe.c     |  4 ++--
> kernel/trace/trace_probe.h      |  2 +-
> 5 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index e6e95a9f07a5..7ca453a73252 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -850,7 +850,8 @@ extern void perf_trace_destroy(struct perf_event *event);
> extern int  perf_trace_add(struct perf_event *event, int flags);
> extern void perf_trace_del(struct perf_event *event, int flags);
> #ifdef CONFIG_KPROBE_EVENTS
> -extern int  perf_kprobe_init(struct perf_event *event, bool is_retprobe);
> +extern int  perf_kprobe_init(struct perf_event *event, bool is_retprobe,
> +			     int max_active);
> extern void perf_kprobe_destroy(struct perf_event *event);
> extern int bpf_get_kprobe_info(const struct perf_event *event,
> 			       u32 *fd_type, const char **symbol,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 23bb19716ad3..f0e936b3dfc4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9809,24 +9809,34 @@ static struct pmu perf_tracepoint = {
>  * PERF_PROBE_CONFIG_IS_RETPROBE if set, create kretprobe/uretprobe
>  *                               if not set, create kprobe/uprobe
>  *
> - * The following values specify a reference counter (or semaphore in the
> - * terminology of tools like dtrace, systemtap, etc.) Userspace Statically
> - * Defined Tracepoints (USDT). Currently, we use 40 bit for the offset.
> + * PERF_UPROBE_REF_CTR_OFFSET_* specify a reference counter (or semaphore
> + * in the terminology of tools like dtrace, systemtap, etc.) Userspace
> + * Statically Defined Tracepoints (USDT). Currently, we use 40 bit for the

40 bit is not accurate anymore, let's fix it (32). 

Otherwise, LGTM. 

[...]
