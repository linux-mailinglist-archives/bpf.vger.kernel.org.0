Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE14D5ECF81
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 23:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiI0Vtp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 17:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiI0Vtm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 17:49:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB3F16597;
        Tue, 27 Sep 2022 14:49:41 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28RGmWTc027623;
        Tue, 27 Sep 2022 14:49:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=XWwNsM9vptbH7as98kzRBPeEiO3RGj1W63lTXp6nItM=;
 b=emWFcIJQIVQDw8bsNNvcMgSZfGGmSdnANKFE40W0Z8B/Q5CQ7yJ+NJUfKpWMUpHQkAj5
 EmySO/bLygLNKB9UDZLRqlJJrqa8wDS1cqZpenRom2zgdE/dknRS6vTv1lN9+BXPL/38
 CsJUpu8UqYxBFVkS6P0+MoYvMWtAK8nTyos= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by m0089730.ppops.net (PPS) with ESMTPS id 3juw2xnph5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 14:49:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1LhgKoivWPCjdwGD2gAujLkTvM1PuC8tAS6s80GjTtHswsxOS3TpuMtFRaM4Gyj7heX173LoD1v5hTYkZGbj1Z8Ov9txYuHZ63xHAUknUpfpIK5LJvRUg0CLKOQS+/G3zLBO+r4P1ZUz3bszNIVwTYuIGgju3sCQGJGrj8FmjK7T+v3iOgFEKr1vrjt1nnhfgtQFJ7iOcwqEXVbhd2HIbmY1F7vpwDE+iy8By/Jur7mysTEKIdq+UIeF1+Ljn21hE74SP6RSTAPs6QSrARr5Aq6922gKYrO8/1b3Xb2ZTFVyCuU/4DI/WbgNdchNNHPIqoRUxq87ozJoGXyTih15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWwNsM9vptbH7as98kzRBPeEiO3RGj1W63lTXp6nItM=;
 b=WpMX2dbIpJPqGNuqCOBJAlHxDZGjPCcyt3/7DajjZqZf7EbAOKqlQsR5MWr3m92xMNRubRwa/wvtA1/Vq00e/5/nyHYV0Sb28lW1gKbBWgWxZdqe3oJHCHCK5Z2Y33DNE1g5q/aHDDVE3GGowENwXULpiaVCPVi7pRcOtbPQyK42zcv8zYDEtKWMSNhE+115FK1jiU0KBJECPFLNmuJCaLA4jBex43P+RM6vqpchsktj76Y+gvcFHKlgWNfEBzK9D2bqYEs4LXVcKuLrK7LKEysCImuutektyRgw1r3LFJUVvUzg45czWx6T/FktIjumjF95zPma4q+N3LMDTTi6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM5PR1501MB2151.namprd15.prod.outlook.com (2603:10b6:4:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 21:49:18 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 21:49:18 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@kernel.org>
CC:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH -tip] bpf: Check flags for branch stack in
 bpf_read_branch_records helper
Thread-Topic: [PATCH -tip] bpf: Check flags for branch stack in
 bpf_read_branch_records helper
Thread-Index: AQHY0rBcg4dF4W5wg0q61WgUTBhZS63z0JqA
Date:   Tue, 27 Sep 2022 21:49:18 +0000
Message-ID: <A702994E-0649-4B05-970D-9CB8694E86F7@fb.com>
References: <20220927203259.590950-1-jolsa@kernel.org>
In-Reply-To: <20220927203259.590950-1-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM5PR1501MB2151:EE_
x-ms-office365-filtering-correlation-id: be03ed98-eb46-4478-b728-08daa0d220d0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rkBQ61HrDCm40W+p4Qn0VfhUISHdfdeqgYhz0r9+4tmnc3AwASbhGmbi0a/l4KXwMp7yjYImTb/IpA0J2c/dRfIYi8v4Tun3dczB+SPlPuqyTY3TcmN99Q53Ht2kt4CNfL1VUfWOGgtWCRRiPHxvJAwa0yYQ2koPEQcQvRViVGAKNXE/2WpcI2K1tqK6HLw7+I0AKD8Mhzt3ThRSSTwrXsyrD3aaPnK5eTTDdwdPmCC7kEUJSXbhb9W2F0U+w27VcLzttRH5BP0zCj4/MQRmyAuJ0VjXel16IGIZyAsYNv+6L/tvm026uSK1dCNTU0JPaq1ZHFrtUkofBMsVF84ZAecxl0LBl2dSSq4rssbVU70h5C7+Hi/CD0voquhqqVuhAANV1PxBtfcCQhEaz7fMKj37hQbMngYhaL0KEJrlDoORURimwCrlEdnxvcNk8TnNL3MKPvf0cRGjG2+Dw6LWcjyKyo2c3TmIDoVc8ccnVN7jgKLQyifnTjuQibBmqA6e9UKzruD7XLkJ3ZQoXex6RcqAAO+IkfXKg7yDe/nYGW6KuUqvu4MSnalYMns0OOt8r06dEqH9iErxTL9TpdqfsYhVsduF8K1m1YjFBE7Nr/0IqTYEAHQhrfiNUlnllNd+R+E2oI6SKvUAG+ES4XK64osbEQ4UP2Tty1e9nhJIigCdvj6Bq4f3JXpkNgHKvkxgsHd0H0eStD3GqpKYielt3cm3K01lZlyjf/4WcD6xToBLvamHln5Qot2xtxwEartcDiouLdnRm6NfwA5Y1SxQC1EnO2pGzVKZAu+nRGwbyAg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(6512007)(2906002)(36756003)(122000001)(4326008)(316002)(83380400001)(38100700002)(64756008)(66446008)(8936002)(66476007)(86362001)(8676002)(66946007)(186003)(76116006)(54906003)(5660300002)(66556008)(7416002)(41300700001)(33656002)(6916009)(478600001)(2616005)(38070700005)(6486002)(91956017)(71200400001)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XbsvB6/PKRqojxm4Zcwqcu8fTxD55nqxVLcNRXFTbWEwv4qNUJ24YslssZCv?=
 =?us-ascii?Q?z8fpLNT6FB0Z2DLUiGbOtnQ4LPYYijqsEh52CMjIn8IZlVEoU+Atxo2V9Ums?=
 =?us-ascii?Q?NcWkUqDFvygAfq3UC0EX97FDDxIFuyyN5TlEHVdeL4ZnuGNW/IPYJOE20ybv?=
 =?us-ascii?Q?NMP41VH1CTnDtSF1zSVTrxOESzHjN1E6WBziTcl3M/JlZqITQmcDrnJU+Slj?=
 =?us-ascii?Q?b5YZ91c312gtmGwkS8ym0S82fTpcwb3iDHsu0YwNndOWa2zFTHijm9Ml0YRA?=
 =?us-ascii?Q?5X3cl/gCK+XIEh4++LxoBkiisl3gej+7WIkI8gETcOctDQjH2lBVEANWPWlR?=
 =?us-ascii?Q?HoTo+mJVDJcXeviWyuul2iPCv0yYlxNHVd6EsZsohUUctDRbvPR57WZ779Ch?=
 =?us-ascii?Q?o2NeSAPs1z0mfGkDHwV8q/gUBrZ0LVEMcqw6TBlSKEltP1cMLm6k+hVA1VhU?=
 =?us-ascii?Q?wAy7ar710oN99mJ3qURp2pERSMsskMY5dtBcLB6RCZ09EE0FI2YZqQvbt6tg?=
 =?us-ascii?Q?5bwEMezDOiXbcp4GKQNTWaijRikCgdVn98yyjV089MzXLK+mo4ss+64mVcAR?=
 =?us-ascii?Q?9yIu6TZxBBdywz8sMy7pctoXPGdYvgGsyja79jVtiHxWwsxKvqOh8X/9wZsa?=
 =?us-ascii?Q?peLFVlBEFANAyivzf+i7mhCojkyUvM4w6wSmr83y4STLwsRPrLnZoAnz101p?=
 =?us-ascii?Q?eAzK44Fk5vXaMFH2Vh7jB7kVyxR+6GI8fgHdg97q0HQQlgf3Nu8w/+O5v73B?=
 =?us-ascii?Q?35AU4aBP15Ttbb/3kEY+wgal68MuGfzU9r4k2L0NCY5BCTbXkipQr8zpfKbi?=
 =?us-ascii?Q?nrQ5OwLaWMG9R4QqCY0p6fBzY7tmOp6AAtxkLyt3qYGTSEnqciPnElQPYBYQ?=
 =?us-ascii?Q?1riWNgoh8Y+jn2/nDxpVSrChAvdX8S1sTXM790ZGLYMjed3XyVBDvfnyvSPl?=
 =?us-ascii?Q?tuqFOaaj3PNWzuzn5ngx9gkN9IOtAV4Dsj5ilqVfY72BsVmylUM7rBAm7b37?=
 =?us-ascii?Q?Q97klcUP6fKByh2REH7fJdSrMnK+SyPgHln7SZDCop1zL/6/UI6VYgKsrNV4?=
 =?us-ascii?Q?ef5jx62nZcy3O9EVk6O+xfw/OccBkIXrJanr3SyDfmHzPe+St8yJ/wSdeP6j?=
 =?us-ascii?Q?UvCIa6BFs4nRY7RiCS/boIX7mAAy4i/kpCTHov1VkBbEzcPZo3VeCr1LO5tI?=
 =?us-ascii?Q?aIYQIrxRQdQheCVgV4OWd6DXYBqmg6rQH8W+XmmVBF1TfjmxSmX8OOEtZP7a?=
 =?us-ascii?Q?sRKOZkdOVuMTOws+kFsDTBuL1ZH2+5wnq5sNcSWl34q7WZ+GNPd7YJfMwS4i?=
 =?us-ascii?Q?7AqHZf+xgriis5P3K6ciBCMSSWbeEqmnXPRJFtuU8besfR9pNsW+5jvLvUFt?=
 =?us-ascii?Q?nwuERyTQvfkdGowfv+NDsh2wD3X3K1fyTQP9r6+qREsvi3Vsmf+JD615oIBF?=
 =?us-ascii?Q?gHDrrHak47k+z0o1dRcXobljGv2P9g2IhhgRuqSB4nfJDbfxCbrnR2ksczI9?=
 =?us-ascii?Q?g8qkX3jSkn37rSPWFfam+GyvGI80XdYAK9yS4/x4CRWoIQiLQH2tRjfIHsQQ?=
 =?us-ascii?Q?A5WFlfyoM9cS2pT1SnL+iW2oHVh9m7bScPGihuN26n0f8f1/YTS3bI0aUdY6?=
 =?us-ascii?Q?YsHlYrjgh5bsGPVAtQzBsBY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E090486EA132B841A47EC8E5EDD224F9@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be03ed98-eb46-4478-b728-08daa0d220d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 21:49:18.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqoKY7Bo+QAwKyYBfntUwoTGA54aNt2HNo4GA+Bor1cfRd+XOYXSKgwbVcWwf9y3BCzAl1R8NyR4LG3KdTKAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2151
X-Proofpoint-GUID: 6eysCEI3wf8iysuQVwhUF1kyt7cv8_gU
X-Proofpoint-ORIG-GUID: 6eysCEI3wf8iysuQVwhUF1kyt7cv8_gU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_11,2022-09-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 27, 2022, at 1:32 PM, Jiri Olsa <jolsa@kernel.org> wrote:
> 
> Recent commit [1] changed branch stack data indication from
> br_stack pointer to sample_flags in perf_sample_data struct.
> 
> We need to check sample_flags for PERF_SAMPLE_BRANCH_STACK
> bit for valid branch stack data.
> 
> [1] a9a931e26668 ("perf: Use sample_flags for branch stack")
> 
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Fixes: a9a931e26668 ("perf: Use sample_flags for branch stack")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks for the fix! I noticed the issue last week, but haven't
got time to look into it. 

Song

> ---
> NOTE sending on top of tip/master because [1] is not
>     merged in bpf-next/master yet
> 
> kernel/trace/bpf_trace.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 68e5cdd24cef..1fcd1234607e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1507,6 +1507,9 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
> 	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
> 		return -EINVAL;
> 
> +	if (unlikely(!(ctx->data->sample_flags & PERF_SAMPLE_BRANCH_STACK)))
> +		return -ENOENT;
> +
> 	if (unlikely(!br_stack))
> 		return -ENOENT;
> 
> -- 
> 2.37.3
> 

