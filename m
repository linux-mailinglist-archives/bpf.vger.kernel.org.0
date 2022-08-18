Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EFE598AF5
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345397AbiHRSQX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiHRSQW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 14:16:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DCECCE30
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 11:16:21 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IB4DFG003847;
        Thu, 18 Aug 2022 11:16:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=EsaMKB+RWI5RXP5Vf3yCj4KH7T4nKE5j4jdNVVKTvG4=;
 b=Tkn8X6ishVfA3bjSj/LksnjFoCizQNImhwN6l2fMe4nZaO1k75D36J0921KYpVFjf8IO
 2aYZ1xMXHBgdbJA3Q54OjY1ToUAVS+ew8Q2Na27yXo7+KoBvxnBmXY1SDyANkONooztB
 Q7ZyvE8jBhkVS3XowtkO88lZ7/Frl/ZjC/k= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j1ajd5pgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 11:16:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K56VciTYV7AFuqMHuZWTFjeCCjEf1LIGsteTWc+Fj8H43KXXPXG6llSKntXt/morTGcjBudqdjghUOTJANGTUhjrkzlFtrRJ0K8zdWqIMexZi9sKUOlANtRMQGSqYyi1K+j84G/v6FsWB8QhnVY7+4URfM5O2LX36x6QTQsIDbyx+V5cgPouSlOHZhrb/euKr/cJN5jDMp2ETVyp/dXSTSwuOUOSrzUgLe9sMptcXfeoaXz1Czn+CggDWkNcSlZ7ymy5NhV8b1xQyMNOLQYnhsMlepBRFE4tANMPsD97GI3WmQwP+VZg26PHnWlrBS0QbcB1eIJxG2Zp0HcfcGKRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsaMKB+RWI5RXP5Vf3yCj4KH7T4nKE5j4jdNVVKTvG4=;
 b=HusTr0H+rNQTKakQmCgJggoGPL1Elqbd/+e+sg2IKw0KmiiE3cFGV9mMTc3CnA3YLFQanIQwi6r7GDPtQNfI/3J6kXhbVVbtc1tVkGEFuHPmA4BJ4DqVjdYZ6pGgEy5k/ezjzdRCqa8ShcpF3SB5IancAnji6oqchyakQdIouLYTx1nf7Kz47J1plccq3bOuTC5FSdBQIlk5pW61MZ7sHRWzEZ7sz9G6BJtW24hwVm/pHZp5H5KZkiAIjeYWv41YLPuSBYTDJ9J00oZhWWbEIkmZdqs0jdZAEfAy7Ow/4yul5XM+lIJdMWhpb+4xWwtkZ+jnhdYNOThF022BMqlg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by PH0PR15MB4607.namprd15.prod.outlook.com (2603:10b6:510:8b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 18:15:59 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%5]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 18:15:59 +0000
Date:   Thu, 18 Aug 2022 11:15:56 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] bpf: expose bpf_{g,s}et_retval to more
 cgroup hooks
Message-ID: <20220818181556.3o37jnz6ov63gftb@kafai-mbp>
References: <20220816201214.2489910-1-sdf@google.com>
 <20220817190743.rgudkmzunhtd5vxf@kafai-mbp>
 <CAKH8qBukudivY5XMwq6k42oUmHdAnbBAw2AjMeBT+Qnj3OZZhQ@mail.gmail.com>
 <20220817232736.6j7axkx4qpujusco@kafai-mbp>
 <CAKH8qBuk_DWPohB5whU-7teqh5XKN+HiMeafAwkodkB8mEo1YQ@mail.gmail.com>
 <20220818002144.2rk4yrmhqgivlqke@kafai-mbp>
 <CAKH8qBtY2wUy4U+pkEr14LrJxJBFfDdGk8wQxbBn=42Muw0g1w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBtY2wUy4U+pkEr14LrJxJBFfDdGk8wQxbBn=42Muw0g1w@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4591841-f1c3-4756-c53b-08da8145b38a
X-MS-TrafficTypeDiagnostic: PH0PR15MB4607:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9CLH3MzXzlQmaHHxnw0fqXKA7nyj+FDYM54n9+x1C9fNq+DwdIuzoylcSaF4jccFO/tqyRk7EJt+vShV5EfXDZJ0v54Ev6sdVUNVsntXxa3cvgR/b7yJ9LoQCJCKN+h42qRmMaTVybVAWq7U6lxkWBfArz5qfW9A/R3EZZWis1MVxqO/XrVRYSDjrm+BW4ZsC+yGxKpSte6YLk4Ghu9j4L1pTNdW+uXcG3LUI/NwsI76yiOuWI/e0+ZpXcbQfceYHUB3hc7BxqR44XNEgyzsxYnBB56QaG91d74gMKWpumniHMmS7G0Tg47rzwqoVE0odDX0FirZOf6vBb8Z6xGxF/w1fpGPx2GRoiaZ4ga7g59JRtcvQkFJjiyhO6bkJ0EjG/A2zJ03nX5fBGZnPv/H4FyIeR104sfYuyslfTSnaQC7eMzunUCBlnZbTXb97QyipvgVxXYZX45odjgGCUvrhPqZnHsOhk2Xg2UI/s9WUKfH10mnPvTHpEJE4WhTUiBlmf5rEs/3p+mMxA508F5G75fUqhIezMqEDqEJtGXGYP3TDJ3MqG21XQbzzInXyh2c+7AITMBuZF7XsbrdX+lEiXMoOiOXdBt2/+s+S2wliEEPC3itRCJuzu/9LeTvGwkWbC9yH+RvmxAt35ukB3KoX+FAbHmVfMuwFvgFNHPLsi2vJETS3pYPrJ7AmGph2VyXHlnSCmJTw+2v4Gfxktpog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(41300700001)(6666004)(2906002)(66476007)(66556008)(6486002)(66946007)(8676002)(8936002)(5660300002)(7416002)(86362001)(4326008)(33716001)(186003)(1076003)(478600001)(83380400001)(9686003)(6512007)(53546011)(6506007)(52116002)(38100700002)(316002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?742DqpjIOSIOLekEcLDKzXMN0a/Q0lZRVPmpWGakQnDHIE6KzY38n8tsmW7I?=
 =?us-ascii?Q?AWQ1UktnKceIJn3IGawIsqYBL3i01NDySMZaM7MAb43OYj2YHId6Kdw8m1p9?=
 =?us-ascii?Q?5C3eQjo46iy0g06YtVNPqwM1bZ5Gsc4z/Lcn6vLDtqMekvNPPZNHB0cBExgF?=
 =?us-ascii?Q?+3cTlKtN2mCYiZJt/acbfnp3QXt7ogJnfoOlddmZZiEsoZEyhul42yjGfAN0?=
 =?us-ascii?Q?k0wQNeVZq0+As3NpAR7ZNHA7sQUk3LahpAPgyqvxoqK+2+raa7D1QTvf5aRx?=
 =?us-ascii?Q?D2VGHyijAiQV+yi5QqPBa70hSNqONKAPLIYzb51jEcyebqUB0fgBrrLlahM9?=
 =?us-ascii?Q?NEUKeQ86fZT6Cpz3HPeM0phllAkRWEMRvoN+voLADijh7kW/OMunCITJeDjO?=
 =?us-ascii?Q?oWzpTeZtSRZTdW16Y6LsmTESRkKLdDD2h3v1bT2Z14s96vKSBH57srnVN8h8?=
 =?us-ascii?Q?CKQ5dcPfwmOTjFcuyCvWqVTuHTxXpvcK9oK5BoCyFsWXhgASX1TBvwF49bER?=
 =?us-ascii?Q?qZS257+b+r8MowS9UbLhhK8SMvz4HFtOLdoMoBECDHkVsCVL8xzz25raJf/Y?=
 =?us-ascii?Q?Yn7SjPI+pTxNKMgF33AJ0yIBHOJMJtmgNTyRzZLc3s7wF1eOwpQRBmt0zbUy?=
 =?us-ascii?Q?OOkr1tA6ocMrUZV9DsVm19e+4ucUuzUnacmKDLRkObFfzaN66oEWalfCVqHi?=
 =?us-ascii?Q?l+nze8JTDFI5O2XerWJqZcscUGyzdFw7OPyMMfmAyOHtCisnthKvuN0Tmj3f?=
 =?us-ascii?Q?d9HkwzaNmEPR4BuQpWVfg6/V9dhn5/W96uGaJaN4yLiddptUmKnUgSCJzlkX?=
 =?us-ascii?Q?+VyMrB1Xs9TE0wT39iKAZ05aqhXjfDNO9MLt4rCZeWwpXZwB8YoSsUOQAPf+?=
 =?us-ascii?Q?7baF0XhIACtgYB1sB6hw5Q+sWnN+H7DusgylG/A7kGJpCVKzFyA0rn5BY43K?=
 =?us-ascii?Q?uvAz4F/BljhIg0a6noZYC8wbCmy/9I7mosTPAle86Qh1vGvvfr1pc+RKLNJy?=
 =?us-ascii?Q?rnl/gMBNJD9A5MxQ/dphxoKEPOssZ3PwHCGQdFyskRMBSqMJKbOqFhqTRafk?=
 =?us-ascii?Q?+xvfAF+2t1jQx/mMOrGviZ+PUPEw++urX4CkxoWMNGLl2oyjQPbfCF/4pI0J?=
 =?us-ascii?Q?fp2HeCLo7xO7htthuDkWERRqF7+exTPmM3jFTEs5Dixs2FN7ZRz7Y9kaWjdw?=
 =?us-ascii?Q?SwlZPzer/8DOP+4dYcxj9ZeJJlsqDEs+CiKB01lrzJQDdmvnohJYG2htCMPf?=
 =?us-ascii?Q?k1k3whhQfEURw3ejqp4JWWmsAIKGqF5Mm396PO0D5JIpoeIhwuPVEq5L00z7?=
 =?us-ascii?Q?8oYQ1gj6KOek3uLFjbGdQN8dj7cGz9KJGRKAL+GZzk6Uu8ZgLSOa0dv8ILFT?=
 =?us-ascii?Q?6DYvTX/2Grl3fsSSkzGbp9HythE2omM3omm02pK7UNx2cuxW9GwUaP0db7xm?=
 =?us-ascii?Q?/HEW+haLSEfhdwUyJRGjfLFGBwuvIJClrxHwqtNFatVZ5ayzI21dbBLXL5MQ?=
 =?us-ascii?Q?juXETEjpnYEqTL5X8zi+l684opnvj43QVlBazC9KcbxKDQJTPa+Ov4C1AhvQ?=
 =?us-ascii?Q?srokUKPh88vAX9uLN02GJlIQMFJNvDjKWHGeRyj+JbrxR8Ih+q1/hNVLAAw5?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4591841-f1c3-4756-c53b-08da8145b38a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 18:15:59.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7+qWNkxxLI4bZsqabzt1VaPiQqv1iU4AbYh5m9Z8ahtrKdWdmbWCqNRgfWmWHdj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4607
X-Proofpoint-GUID: nLq0IA2Iceh1g_NHySDpMo68HRIE3Q9G
X-Proofpoint-ORIG-GUID: nLq0IA2Iceh1g_NHySDpMo68HRIE3Q9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_14,2022-08-18_01,2022-06-22_01
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

On Wed, Aug 17, 2022 at 08:42:54PM -0700, Stanislav Fomichev wrote:
> On Wed, Aug 17, 2022 at 5:21 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Wed, Aug 17, 2022 at 04:59:06PM -0700, Stanislav Fomichev wrote:
> > > On Wed, Aug 17, 2022 at 4:27 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Wed, Aug 17, 2022 at 03:41:26PM -0700, Stanislav Fomichev wrote:
> > > > > On Wed, Aug 17, 2022 at 12:07 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 16, 2022 at 01:12:11PM -0700, Stanislav Fomichev wrote:
> > > > > > > Apparently, only a small subset of cgroup hooks actually falls
> > > > > > > back to cgroup_base_func_proto. This leads to unexpected result
> > > > > > > where not all cgroup helpers have bpf_{g,s}et_retval.
> > > > > > >
> > > > > > > It's getting harder and harder to manage which helpers are exported
> > > > > > > to which hooks. We now have the following call chains:
> > > > > > >
> > > > > > > - cg_skb_func_proto
> > > > > > >   - sk_filter_func_proto
> > > > > > >     - bpf_sk_base_func_proto
> > > > > > >       - bpf_base_func_proto
> > > > > > Could you explain how bpf_set_retval() will work with cgroup prog that
> > > > > > is not syscall and can return flags in the higher bit (e.g. cg_skb egress).
> > > > > > It will be a useful doc to add to the uapi bpf.h for
> > > > > > the bpf_set_retval() helper.
> > > > >
> > > > > I think it's the same case as the case without bpf_set_retval? I don't
> > > > > think the flags can be exported via bpf_set_retval, it just lets the
> > > > > users override EPERM.
> > > > eg. Before, a cg_skb@egress prog returns 3 to mean NET_XMIT_CN.
> > > > What if the prog now returns 3 and also bpf_set_retval(-Exxxx).
> > > > If I read how __cgroup_bpf_run_filter_skb() uses bpf_prog_run_array_cg()
> > > > correctly,  __cgroup_bpf_run_filter_skb() will return NET_XMIT_DROP
> > > > instead of the -Exxxx.  The -Exxxx is probably what the bpf prog
> > > > is expecting after calling bpf_set_retval(-Exxxx) ?
> > > > Thinking more about it, should __cgroup_bpf_run_filter_skb() always
> > > > return -Exxxx whenever a -ve retval is set in bpf_set_retval() ?
> > >
> > > I think we used to have "return 0/1/2/3" to indicate different
> > > conditions but then switched to "return 1/0" + flags.
> > For 'int bpf_prog_run_array_cg(..., u32 *ret_flags)'?
> > I think it is more like return "0 (OK)/-Exxxx" + ret_flags now.
> 
> Yes, right now that's that case. What I meant to say is that for the
> BPF program itself, the api is still "return a set of predefined
> values". We don't advertise the flags to the bpf programs. 'return 2'
> is a perfectly valid return for cgroup/egress that will tx the packet
> with a cn. (where bpf_prog_run_array_cg sees it as a 'return 0 + (1 <<
> 1)')
> 
> > > So, technically, "return 3 + bpf_set_retval" is still fundamentally a
> > > "return 3" api-wise.
> > hm....for the exisiting usecase (eg. CGROUP_SETSOCKOPT), what does
> > "bpf-prog-return 1 + bpf_set_retval(-EPERM)" mean?
> 
> I think bpf_set_retval takes precedence and in this case bpf_prog_run
> wrapper will return -EPERM to the caller.
> Will try to document that as well.
> 
> > > I guess we can make bpf_set_retval override that but let me start by
> > > trying to document what we currently have.
> > To be clear, for cg_skb case, I meant to clear the ret_flags only if
> > run_ctx.retval is set.
> 
> Are you suggesting something like the following?
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index fd113bd2f79c..c110cbe52001 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -61,6 +61,8 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>         bpf_reset_run_ctx(old_run_ctx);
>         rcu_read_unlock();
>         migrate_enable();
> +       if (IS_ERR_VALUE((long)run_ctx.retval))
> +               *ret_flags = 0;
>         return run_ctx.retval;
>  }
> 
> I think this will break the 'return 2' case? But is it worth it doing
> it more carefully like this? LMKWYT.
The below should work. Not sure it is worth it
but before doing this...

During this discussion, I think I am not clear what is the use case
on bpf_{g,s}et_retval() for cg_skb.  Could you describe how it will be
used in your use case?  Is it for another tracing program to get
a different return value from (eg.) sk_filter_trim_cap or ip[6]_output?

Not meaning the helper should not be exposed.  It is easier
to think with some examples.

> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index fd113bd2f79c..dcd25561f8d4 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -39,6 +39,7 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>         const struct bpf_prog_array *array;
>         struct bpf_run_ctx *old_run_ctx;
>         struct bpf_cg_run_ctx run_ctx;
> +       bool seen_return0 = false;
>         u32 func_ret;
> 
>         run_ctx.retval = retval;
> @@ -54,13 +55,17 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>                         *(ret_flags) |= (func_ret >> 1);
>                         func_ret &= 1;
>                 }
> -               if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
> +               if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval)) {
>                         run_ctx.retval = -EPERM;
> +                       seen_return0 = true;
> +               }
>                 item++;
>         }
>         bpf_reset_run_ctx(old_run_ctx);
>         rcu_read_unlock();
>         migrate_enable();
> +       if (IS_ERR_VALUE((long)run_ctx.retval) && !seen_return0)
> +               *ret_flags = 0;
>         return run_ctx.retval;
>  }
> 
> > > If it turns out to be super ugly, we can try to fix it. (not sure how
> > > much of a uapi that is)
> > sgtm.
> >
> > >
> > >
> > >
> > > > > Let me verify and I can add a note to bpf_set_retval uapi definition
> > > > > to mention that it just overrides EPERM. bpf_set_retval should
> > > > > probably not talk about userspace/syscall and instead use the words
> > > > > like "caller".
> > > > yeah, it is no longer syscall return value only now.
