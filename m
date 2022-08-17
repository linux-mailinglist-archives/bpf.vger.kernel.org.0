Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F78C597A3C
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 01:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242442AbiHQX2A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 19:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiHQX17 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 19:27:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D22ADCCA
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 16:27:58 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HMwAMm002134;
        Wed, 17 Aug 2022 16:27:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=OE+Wl9uZzbEd5f5XOiAtfOIem8xVygSGtHeHYkOcy6s=;
 b=qwwzpZy8bOINgpPsmeYDE5O5gK0Fp4gVwYUv0H/2Qc5tK2a+sJi52AvYjxD9eFwF6UYN
 HHTV6RHNH+1QMtcWQW9U37PD2jvZOXsfTqD1Q3yBDuC9ELyXbvqlH9l/a5sOPmfuYmZq
 IIErnAJxrD4+ep1hJi6/B7J95ViP/pX4CjM= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0nsq70se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 16:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gguogZnM1tkqig+vBEYvvzGwZcRzC8nZ+vbcx55C3Xs0Inwp9riDFl3XnV3yNzyVTvql9K+Go6bbHxw+fcHK3HX6mps767jLc5Lc2aa6x11jZ0AL5vK5LctqnKbjFgk2GaiZVffVnYMCZpV+MJ9+W9pnSz874SIEAPZL02WlbpnE9VWlm5eOix7u2XOeflqci/BAqFpfTQs1GEJtOEpqD0v1mtA1XyHU/H1H8IuvQO7djCyD8nTsYVOks9aZkcq7jAVmJs9H1uVZ4eaRfKwL5UNgAoJPgQ60Q8mxblKLJPh2YKcfWbylde7FlNgjfARW28u2jaXBUz1xd+jwQsy7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE+Wl9uZzbEd5f5XOiAtfOIem8xVygSGtHeHYkOcy6s=;
 b=Vidj6IMXSUuGEN6VP5LgZ9z6DQv+DiH7dNyr7vqyOcQC2aFmhUEHL3JuatIxQBTiH5vQxEmC6SRwb5OY4vjPCN/yjIrWR/KU1DMoISwJh8aEMwf+oyzeIofHDsNCtouUxbDaDnSZ+GeriMEjAUEw0KmT+XXzLvkp49H28sGAb7dzIpkPrm2AkZNa4O0TK/uqCp2K6hxdhtN6tswtzd188qvd96Se2meQy2hwtETn8jx7w4orY1VIigj+uBkVQrUmMaqQZxL+jEi93otV8nLVxWN6LQfSGQ4MODldc0lJ5YlmQAE66Z80dLGLrJ/15TsirXVZ4Wtsr8ZP08sJfyoGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM6PR15MB2745.namprd15.prod.outlook.com (2603:10b6:5:1a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 23:27:38 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 23:27:38 +0000
Date:   Wed, 17 Aug 2022 16:27:36 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] bpf: expose bpf_{g,s}et_retval to more
 cgroup hooks
Message-ID: <20220817232736.6j7axkx4qpujusco@kafai-mbp>
References: <20220816201214.2489910-1-sdf@google.com>
 <20220817190743.rgudkmzunhtd5vxf@kafai-mbp>
 <CAKH8qBukudivY5XMwq6k42oUmHdAnbBAw2AjMeBT+Qnj3OZZhQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBukudivY5XMwq6k42oUmHdAnbBAw2AjMeBT+Qnj3OZZhQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37)
 To MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb4d8171-b863-4ee7-9df0-08da80a81276
X-MS-TrafficTypeDiagnostic: DM6PR15MB2745:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQaZOssz19RBBkBmo4qgKmHpjoLpwgdWCNuXXz9ONBpOH5v2QKOjEkTVSnSGOSs29WphLFx3q0y29KRImLiu0qbaGWeqQUIOhSWI964ckk89ziRrNZ0CXM1NjUYVE851gdVOIw52UrK5wvGafkwjWYfWU9OHxXIgmSdjGd8xDFnpXrkDfGQruey9q+W8ZRIh56hZ++mIPhzLYhwFYNv8xttzwYpfcRwQ6skFxov6/eaC7J9C5EvcqPWVvvKeZoD6ANUGALYdTr3lHfkPhViG9vaHpTAIJXfwphV4n/TfAREtRv+IqNNcNixhv1HEMrLbVBiKTzWSVMWLMhSi3usr49LVS+ZgqEXyHyCpwvOd2ocwcQM5mm4rhXCrUU308zOjClS8XpeEerdEsixigbdkUkDZfUM8Rzo7TwjO6ilVD2s+wAkApIu5puijil29orxNt1KbR1pyhBa31fIBNrATChl+YW4Bb+SE3oudsxBHC+m0Z5duTLbKbdiVimfahSVMqIc1BRM+VJbgOScHHXVHwwp1IV1bXIHEsavq8kdjAS8QNx3xZbFMmwFrnhBcefJH9ebKFBCfiR30yY/57pL/dHhyn+t/D3yQPDFAahhVHA4/BUnUpbDl2keMXIV30vHlASM4IDOrWfZzVzW+NY/uIy5YsZYHEF18LQ96vb2R314pC8jsZN+a+eajmJRckrayWJeIuOpv4ty0LgU8v1jAIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(53546011)(186003)(6506007)(38100700002)(1076003)(86362001)(6512007)(52116002)(9686003)(33716001)(83380400001)(8936002)(478600001)(6486002)(41300700001)(316002)(8676002)(66946007)(7416002)(5660300002)(2906002)(4326008)(66476007)(6916009)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DsWzS09VViD1jmPkAugb/zvxnvwbTsUtFCIhaiiqz9wcjyi9xTP7hmdly8YO?=
 =?us-ascii?Q?L2pnngFGu4ql9NLSY6n4Nlr1pNy9iAu/6R2iSjZIxNgEjvuNUe3RSpa3ThU4?=
 =?us-ascii?Q?KHBTVfXNlpZHzYm+4lTNCrNu6Gml3EBy5ivACwiaCqj+53MMTI+Cb8ZXvs8K?=
 =?us-ascii?Q?nFmQ/jTkLm26Du9mwvlHKHngY9ePHN2Gy1Wq8klbDgBC5PB0wMXzUCCOx6e7?=
 =?us-ascii?Q?3zbrFBAi47wPIeZQofe5/qlviAYzL6xGhnM4i8bPDkdp4QvdK4PkpnSUphCM?=
 =?us-ascii?Q?9ODfviqxZiwThu5bMIm26TJrtLu7teaB9z2sWPb7/EaPoR3H9jpVdXZEYSpl?=
 =?us-ascii?Q?YVTnxt46+ydlUurvLpNkpadEkXtKUHmZSdOiBWz6YdjXcesTZX4R8rD2iudu?=
 =?us-ascii?Q?+WS3CC2z5qK+xcKC1I5MV/pV9HQdJplP1R3HkWoWEg9dxdp+Du9xjEK4qfYu?=
 =?us-ascii?Q?bIcgObXFktWycKMpljz+cLkd2GoxqeJSwXA+ypql1WqqyGRlT2Hen0M0cMe+?=
 =?us-ascii?Q?ukHZipYfJWKNsOLzkUJ62WNbg+UGUjqFccLeC78MeJEPtuxDprkQbXX/1WjH?=
 =?us-ascii?Q?HkjmPU7Ek0zkvhZa8cNu4kgI2FsYW3RNOc/OtS3ckLtsRg08QV+qsGI9N/uw?=
 =?us-ascii?Q?nQfbpR1HjVwlehmGH0kx01PmcKty+VvAMEC69b4IxHK5Vlm8wBcuOFcUSVBO?=
 =?us-ascii?Q?9ONpyY7oSyTQCrC09pWsNeUUWUNhRH/5uz2fnEUjLrqkgrLnn6/yl7SNVm5s?=
 =?us-ascii?Q?BOtX9HbaVyM9cyCsB2B3dQz9fj+tw1RXLL0OdFc0wChSN0NEhvyEPaw0EpfY?=
 =?us-ascii?Q?TN96HRSbwUNh3T6ZvdAS+GVVbUVe5+mr4MHps7cE/bl1Y6tx/0CrL9TSxQmE?=
 =?us-ascii?Q?WUrGSbYqLm1k1+waJpjLJrUPSjb5Gj9eV08hoBBAgLlYeXWi9q5IrCiTIYOl?=
 =?us-ascii?Q?a1HIAOGmg6FA3qSuRyAnnmlsMoCiPCIvXCIFt8WqX2AeDtUqvktdwiCBw7Xc?=
 =?us-ascii?Q?K+7S/cROxB6OgPRUOhdOjanFcrLoJHCIuR8BRbDFleW0xC/wpqSz7DeRzx0k?=
 =?us-ascii?Q?XB+tHvDb+/UgSl767JuGtZBo2aKVY/eLPl/n759PkzeyKGJhiWKzExgpZUnn?=
 =?us-ascii?Q?JWLQUQZ3ehxzur6aHX4jRvEL1hKZwimSiN4CfRDsikeGMaXdXBZejczo9a+c?=
 =?us-ascii?Q?NukvRDwKTGf9WWMbYR8+AIuRbxP/ZP1NZXSQK9Q5dqZ/WWtS0X0gHWlfqNXD?=
 =?us-ascii?Q?QEo1dOIJmQ1dxanQO8JnT3QCgS0QwR6vov1yok6eCqGMgh89OrD66QV8gMkC?=
 =?us-ascii?Q?ItQ+gp16jcKhkWu8wffUeFAZ/eREEt4vK8BgSzOk2AAwu3LtSSvgznqsollk?=
 =?us-ascii?Q?xWG9nWfdIxrg3cRxpuLZkqRJ8UGwIqkSi+eXWkgQW6zH7qamPH8l+NxMypYP?=
 =?us-ascii?Q?1jj0tCaJsgiHaE44NoqClxUBMkxvbhIqNAlDzO5gPDopv54TTjMpA5zRiPaP?=
 =?us-ascii?Q?hX3wZqSfdW+z/0cjMWXSGKZGm6v/vzdh3GmNePzLHG1lnq/315AToI3JFvVh?=
 =?us-ascii?Q?Uk2gHKTuNZGbLa+XGEeb9B6nKnDLuNf+96klZ69BSe2QTJQt7zW7gyHYLFFM?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4d8171-b863-4ee7-9df0-08da80a81276
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 23:27:38.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efVu4NPm1rk4IjLWFFziV9HHQ3spdkwFFNiio+unXJnaH4akxwf/VSKesP4Wzkhk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2745
X-Proofpoint-GUID: E4_oNKdJSuamFjLqbQ7GQsVr3ZnWXatr
X-Proofpoint-ORIG-GUID: E4_oNKdJSuamFjLqbQ7GQsVr3ZnWXatr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_15,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 03:41:26PM -0700, Stanislav Fomichev wrote:
> On Wed, Aug 17, 2022 at 12:07 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, Aug 16, 2022 at 01:12:11PM -0700, Stanislav Fomichev wrote:
> > > Apparently, only a small subset of cgroup hooks actually falls
> > > back to cgroup_base_func_proto. This leads to unexpected result
> > > where not all cgroup helpers have bpf_{g,s}et_retval.
> > >
> > > It's getting harder and harder to manage which helpers are exported
> > > to which hooks. We now have the following call chains:
> > >
> > > - cg_skb_func_proto
> > >   - sk_filter_func_proto
> > >     - bpf_sk_base_func_proto
> > >       - bpf_base_func_proto
> > Could you explain how bpf_set_retval() will work with cgroup prog that
> > is not syscall and can return flags in the higher bit (e.g. cg_skb egress).
> > It will be a useful doc to add to the uapi bpf.h for
> > the bpf_set_retval() helper.
> 
> I think it's the same case as the case without bpf_set_retval? I don't
> think the flags can be exported via bpf_set_retval, it just lets the
> users override EPERM.
eg. Before, a cg_skb@egress prog returns 3 to mean NET_XMIT_CN.
What if the prog now returns 3 and also bpf_set_retval(-Exxxx).
If I read how __cgroup_bpf_run_filter_skb() uses bpf_prog_run_array_cg()
correctly,  __cgroup_bpf_run_filter_skb() will return NET_XMIT_DROP
instead of the -Exxxx.  The -Exxxx is probably what the bpf prog
is expecting after calling bpf_set_retval(-Exxxx) ?
Thinking more about it, should __cgroup_bpf_run_filter_skb() always
return -Exxxx whenever a -ve retval is set in bpf_set_retval() ?

> Let me verify and I can add a note to bpf_set_retval uapi definition
> to mention that it just overrides EPERM. bpf_set_retval should
> probably not talk about userspace/syscall and instead use the words
> like "caller".
yeah, it is no longer syscall return value only now.
