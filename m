Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D25597A8D
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 02:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiHRAWK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 20:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiHRAWI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 20:22:08 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D9EA3443
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 17:22:07 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HNSrX2007621;
        Wed, 17 Aug 2022 17:21:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CsOyW70zNPtmlACXqNIQ0qDL36fbSfWSMPp769J5YCA=;
 b=aiFj219d6SecVnJce7H8+tOa3OkPCJNBPL2sIGLtQOluAuvhDwbpvN4mhr3NzSG0E8oS
 b9XxAMZTbpGutJVmtbbR65SCxwUUm3e8Mn58zTzF1yrdo7l7St7vdCsREOZKr2EK3f96
 ro2YTcH9ZZTEmSYQGlcbAafM2OtNjkKuBso= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0nq07ar0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 17:21:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TirThSQqd2tlu0xGhKbRwiRUDDLqGganoGBYOSS2LSd7Iecdm0m7AJy51tjQUe4OkP4FsmQ1la1zJ4eFH1l0iHrFk17LnoU2oDRN6EPoqh1gqE2KQDbpqeg2X55Eu3j3XrApHzbysWKSQDhvPHddXrQnzIWENX/WQxo2+EaihUSNkvR8pjXFQa7OQSpS/Uamfxnh7JOTY+EH/NiSxzNUfQkekctapv6BLjo3RIQvWd5Vhtb28wk6n7fZkcBuxdAUNnP0ui9/qOftot+kKXLvkOKBduS2dTL9cxORXnTUWIlfouoWf+bp/L6Ci3VZ0uVOtV7C1D5KsVPXZlVx6Lhhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsOyW70zNPtmlACXqNIQ0qDL36fbSfWSMPp769J5YCA=;
 b=do7lFiZ5b86jFoxA+EBVsOnJ9ND5IEVhPCIGDNWvRgj4/9Z1cATBGqI/KIXetYlLfuBALEqRcOZK9CkCn7XibrGn5dT3VbjYRZN5eqn4TL9Kg3PLkqAsyCmqaVcZ8w+eY5dqlAJZJzn8qICG2niEAHMah24LyLNdVfzEcwzV04K0NhTwmEoaPDNapVc6I8j3NKPjqhUIiNh95yr/hjgeohFQUlGUJHYpM4W3+QGPumi+U87qRfwO+b/0VEyt6GJmdcBf4PsrNUfuI24rKyIiCdGhPcu4NBaYO/uenWO6RQelETxXkSBkAO3BZqGWllxGWEdx6/o2x4h3OuEWqJbwuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM5PR15MB1194.namprd15.prod.outlook.com (2603:10b6:3:b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 00:21:45 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 00:21:45 +0000
Date:   Wed, 17 Aug 2022 17:21:44 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] bpf: expose bpf_{g,s}et_retval to more
 cgroup hooks
Message-ID: <20220818002144.2rk4yrmhqgivlqke@kafai-mbp>
References: <20220816201214.2489910-1-sdf@google.com>
 <20220817190743.rgudkmzunhtd5vxf@kafai-mbp>
 <CAKH8qBukudivY5XMwq6k42oUmHdAnbBAw2AjMeBT+Qnj3OZZhQ@mail.gmail.com>
 <20220817232736.6j7axkx4qpujusco@kafai-mbp>
 <CAKH8qBuk_DWPohB5whU-7teqh5XKN+HiMeafAwkodkB8mEo1YQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBuk_DWPohB5whU-7teqh5XKN+HiMeafAwkodkB8mEo1YQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d325555a-30c4-4a77-7dab-08da80afa23f
X-MS-TrafficTypeDiagnostic: DM5PR15MB1194:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azdxWO8Xje/FIrBdlx12iaWPGDgc7mj7vOpaitem39tjqUFQ+fDsrgr9IxeNW/YbYF+bTPMM8afzZq5QNunq5wYan6D9NHxjm2CMgy+o6AY9YWnb7yTL7SNtDsCGoE6Kjq8MyQoaQNipfUk8GXbMZMXPvPSVdQfHsNdWeCNT5PDJZEshW3G2/hYXKyqmhNpz5Otjuheb2upCMEMjnQ8cZYzuezZiL7uz7KJit01FK+iSsZwpJ13YFS1cBtKjcrfDY6L/gKKKhAuqg/w/U+TT6TNrZyh5h8LTxeyCBcJzeixywHf4yrh2yzTNAGbhRuZWtdX8mwI1KMcQkbj5JXq3ycEw1w4XMpzx1+S9jDjsjJvcWTNEX9/5nyjBcSUmeg8+tAS/A8XHaGFJ4y3e6/kbWftmzX/wSmUS0vZ0UHy/AkuMTG6h4tefdNMkbe91amY2Lbl2pTG/6VKruJhKT4fMvv06C6+K14b35cPviZydpvwdnaLhfTqOsk2oibMa5JXJxkA6wQkCF3rSGiYIjmLkDq1zn7AMET14j+o4aRs+MzaEAb2dSemi11J0q2N0CD0j40vMZ9FQRwLyzoDFIfU72K7uIqjWIWb0G9OzGIfmvOshm4WF+9RcmNWOYrkQiQ/58Qz/WvGmLjOpDYOIccPCy1aOBnvvTYjY2cjx+tSTxVJMFU0QgVQKxsgr145JMlKbEtvL4Iy/Cr6yFAFfMKYGtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(396003)(346002)(376002)(136003)(366004)(86362001)(38100700002)(6916009)(316002)(8936002)(478600001)(6486002)(83380400001)(5660300002)(6506007)(52116002)(53546011)(7416002)(2906002)(66946007)(66476007)(66556008)(8676002)(4326008)(41300700001)(33716001)(186003)(1076003)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MzM0rVn7StOz4RU5pFOaXe4s2uDwWxL3v6gJw1b1CGEFhc/lZwWddaMT9JFV?=
 =?us-ascii?Q?3ykDJYlTey+Odb8u7v7ofIORZE78MnAFDcmsh/LNXI/T8+ggcg0/Afao6O+9?=
 =?us-ascii?Q?r7m9OKsy3qbDHfRFVIkQeS+M3m3q2WkRsEP0MW99AaBu0Z2yCJxT9j6qA+4q?=
 =?us-ascii?Q?n+fWArnp2ybr7fy2aK1sYH2cTFjHf13hUSkBRG7gSpF35A+7vOsrLrphQLaz?=
 =?us-ascii?Q?LvAl+UyqQSjYyfTT8R4t1x8wql6TPHlzvLVapaWc4aRLl0FW2i4yXBFGTzCf?=
 =?us-ascii?Q?yshA6DLelyS5Mmx1VcuV1z4mIBhtrNP8wTVdazo8nJCkaM9GcNfbv2S16jmo?=
 =?us-ascii?Q?51aQXRvpH3My+zQesYn2iHChRamS43Rv9VUJxYtNUMdAJ5i5wOPsqzO0ftrj?=
 =?us-ascii?Q?0LXRdbcWTtoh5Sk9hj05oFPmhssl9XqK2oXAsogN3yryRRDhfbukrKakwdoS?=
 =?us-ascii?Q?RL9XdQjlklkQkEqUsMKfufDi2fb2zd4E0uFIzcWhke2fn4DCVDQQtLrk6yUN?=
 =?us-ascii?Q?o8bJ+eYV2RN03WJSDBxLjiJi8D3kcvpDff0m2TmiJiwGvKLDISwC4tAzB7xy?=
 =?us-ascii?Q?FA4efyyHb22JOnWZuwJkIMccGt1aolQGlaT6YIBb7rTreXv9aaIddUL7wiiu?=
 =?us-ascii?Q?1Nf07pIN6JI1YuAi7TgST0SkO7iOpXYotxY1r5A7nj9FjbSzwT7BblhS/1q/?=
 =?us-ascii?Q?DQ91VB3rA9Zo7QI+v6ckGGdmTi7wug3RWxxjUkVv8MmQhuJIR2GQjt0cSqO8?=
 =?us-ascii?Q?1GsM7+UTqwSetCz6JpCZsEJTI/y4Mb+gYxpQ8PKDCr6NnJiwmU60X/jSLLVu?=
 =?us-ascii?Q?CcF0QybwMxzr74g0Ymu8owtE2faDSxsS8Yk3kDnJJB/mltk68rEvYZmebpjJ?=
 =?us-ascii?Q?KyrZLF7dAkHhjy9s3GZ2QdSDQrnuUPQ+KLNq3oQhoemtSI8KLhiVsb0a5reI?=
 =?us-ascii?Q?zm0NCGUI1PwU6nN85c4+41irZgo/QegA2M9a8bzLxW3NhKcmJLUrCIGTQrIo?=
 =?us-ascii?Q?t9JG0GAZ1Fug2dzlWjvAWUoMXR2xwvjH+fy6c//sVozL16IyD7NwS0DZLVhG?=
 =?us-ascii?Q?gc6QprvquxtNBDxyxpvl7Q8OVgDq/srwQOTgBWqrFZa/RjWpShZezdhVnvJi?=
 =?us-ascii?Q?nKXYboR5HNCquC93RFWrumBVb2VAbBOFzBh35OlhQSRWh/LpNj/HRfE4Z/p5?=
 =?us-ascii?Q?lt9KrD4pVrnV6KbZG5mmqcmX5OYJAv3ZriaFm5OPZVzLqwSEb2CSsVPxj/C/?=
 =?us-ascii?Q?UjWrLi3LKPAJ1t7y/JS9mAU2spAT1THMs9j59DnVNf1NqFHVj4FqpZXdhgd7?=
 =?us-ascii?Q?Q+iaZlDBntw+rSQNHDHp5MEuWo6jN6tW6WehR2KJyiHdXXfyKXhAbzNyPa+N?=
 =?us-ascii?Q?4w3EZWu+ienNjjOblWMvpRA/GDjOgv+baMbLaNQMkKEbAiHVYzu4oxaeBeW2?=
 =?us-ascii?Q?oOdzbLnp3LJWaiMk/jk9C4fECMaxOnIoYDrJGtrW3hxEWUAA2fv59Da0kqzA?=
 =?us-ascii?Q?bmzMVbFME5780/zTO5Fi6i7UlbEudYtddoyHuuCBL9wSAKOLc6FCAFFQIEXI?=
 =?us-ascii?Q?mGu0FDSke9oKqpuuflB2F7u4jTfqUJ5jalk6mCqDJLHCX9Tr/L6oQASD/9r1?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d325555a-30c4-4a77-7dab-08da80afa23f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 00:21:45.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBqYLkjl2bQHF2VJYfobUSTZQCkvQr6+3Yhhs40i1MUMeY96YPOfUErSPPw2R3KL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1194
X-Proofpoint-ORIG-GUID: Sm5rUjKVZd_3RDtmUXLvODVz8l2jMILQ
X-Proofpoint-GUID: Sm5rUjKVZd_3RDtmUXLvODVz8l2jMILQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_16,2022-08-16_02,2022-06-22_01
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

On Wed, Aug 17, 2022 at 04:59:06PM -0700, Stanislav Fomichev wrote:
> On Wed, Aug 17, 2022 at 4:27 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Wed, Aug 17, 2022 at 03:41:26PM -0700, Stanislav Fomichev wrote:
> > > On Wed, Aug 17, 2022 at 12:07 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Tue, Aug 16, 2022 at 01:12:11PM -0700, Stanislav Fomichev wrote:
> > > > > Apparently, only a small subset of cgroup hooks actually falls
> > > > > back to cgroup_base_func_proto. This leads to unexpected result
> > > > > where not all cgroup helpers have bpf_{g,s}et_retval.
> > > > >
> > > > > It's getting harder and harder to manage which helpers are exported
> > > > > to which hooks. We now have the following call chains:
> > > > >
> > > > > - cg_skb_func_proto
> > > > >   - sk_filter_func_proto
> > > > >     - bpf_sk_base_func_proto
> > > > >       - bpf_base_func_proto
> > > > Could you explain how bpf_set_retval() will work with cgroup prog that
> > > > is not syscall and can return flags in the higher bit (e.g. cg_skb egress).
> > > > It will be a useful doc to add to the uapi bpf.h for
> > > > the bpf_set_retval() helper.
> > >
> > > I think it's the same case as the case without bpf_set_retval? I don't
> > > think the flags can be exported via bpf_set_retval, it just lets the
> > > users override EPERM.
> > eg. Before, a cg_skb@egress prog returns 3 to mean NET_XMIT_CN.
> > What if the prog now returns 3 and also bpf_set_retval(-Exxxx).
> > If I read how __cgroup_bpf_run_filter_skb() uses bpf_prog_run_array_cg()
> > correctly,  __cgroup_bpf_run_filter_skb() will return NET_XMIT_DROP
> > instead of the -Exxxx.  The -Exxxx is probably what the bpf prog
> > is expecting after calling bpf_set_retval(-Exxxx) ?
> > Thinking more about it, should __cgroup_bpf_run_filter_skb() always
> > return -Exxxx whenever a -ve retval is set in bpf_set_retval() ?
> 
> I think we used to have "return 0/1/2/3" to indicate different
> conditions but then switched to "return 1/0" + flags.
For 'int bpf_prog_run_array_cg(..., u32 *ret_flags)'?
I think it is more like return "0 (OK)/-Exxxx" + ret_flags now.

> So, technically, "return 3 + bpf_set_retval" is still fundamentally a
> "return 3" api-wise.
hm....for the exisiting usecase (eg. CGROUP_SETSOCKOPT), what does
"bpf-prog-return 1 + bpf_set_retval(-EPERM)" mean?

> I guess we can make bpf_set_retval override that but let me start by
> trying to document what we currently have.
To be clear, for cg_skb case, I meant to clear the ret_flags only if
run_ctx.retval is set.

> If it turns out to be super ugly, we can try to fix it. (not sure how
> much of a uapi that is)
sgtm.

> 
> 
> 
> > > Let me verify and I can add a note to bpf_set_retval uapi definition
> > > to mention that it just overrides EPERM. bpf_set_retval should
> > > probably not talk about userspace/syscall and instead use the words
> > > like "caller".
> > yeah, it is no longer syscall return value only now.
