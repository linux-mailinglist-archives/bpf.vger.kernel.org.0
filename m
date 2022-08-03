Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E215893D8
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 22:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiHCU46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiHCU45 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 16:56:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602A21F2F2
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 13:56:56 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273Ed3AD015910;
        Wed, 3 Aug 2022 13:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=TilyU3aOlQjxitWRnLE6HiUg8vdSZ+lCMIWQwOlaA5k=;
 b=Wt7csydhNz/S1bKei93yR1NvZS4f0Wl6Mlkb7o+enpue2dWllkNMVXPlnek+e4J+3vgm
 Dqw/OX81vrMJTL+VwGOEnFOGisObOJfLvmbd9YBOKVaYq3TlOxq38s/7AAsNaWxQzx91
 OrsgRZNMD/xhpZrMVZ3CfO2ilMEHWPr4PNk= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hqty7jrc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 13:56:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8GNJzS18CR6M0TK8hgKHwGc3kzPdVWbI9hwle1ji1okWJgu4raU1qe4MzlcDHLO4wEl5dy04kS+Pc7Lth5N8DA0XySz0TyGz+38zqJ6qm0jcRR9s0FfqRNcDL/6pNgdwYlyaByZfLMUn3+cYPZS+CvyR0QoPURvcMTv166iK/69Qu0qV6XMvF9eksG0v/P2jwtL2N3lEFTFW3wooSV9stBUNmf3fpKjJLN3fS217JpwghEuzv9szsrAJqhWSMkA8uzeSy30qKsIwcQbrxU+4mhk8R6TJctWOCp2AxWF7tVEMVRNa9bGVf8+WV3D8WgeDnURUwUUDf6WrVqzB370Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TilyU3aOlQjxitWRnLE6HiUg8vdSZ+lCMIWQwOlaA5k=;
 b=kT1yYpxwPnD2mo+nu5T1jFWuia4U6u1ifTi756tqZF1HHFmymVYhudxSaQciVpHpAeDZCdpeXZF/imE3BQOYawmj7fh1vPZ2uUWygDNJNeue+XnvAGYFtO0FNcBwM/yDAYrj/wyJ/4budPsTMaiX90+j2HMbz22VrCm74JRUYAOotYWRNPkqwq0yFRr8F0CvriOh8E/G6V+8gdns13sJ9Vz/9RVH5d6Cp3NnvJ5gTFPEHf6LpM/nLeFMp5waOoa1bPHxjSKQXVLGeMePkhLoMLhFZx8Afc1oV81EZm12Be6rHLfui+oUaz9fv9jzy/IgdlO/eZhBSJ3n1otPbaII7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN8PR15MB3140.namprd15.prod.outlook.com (2603:10b6:408:91::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 20:56:35 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 20:56:35 +0000
Date:   Wed, 3 Aug 2022 13:56:33 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220803205633.fjsfxgys5g4h2ptg@kafai-mbp.dhcp.thefacebook.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com>
 <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::20) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 042e1c23-5104-4fe9-c91d-08da7592a6e5
X-MS-TrafficTypeDiagnostic: BN8PR15MB3140:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDsIKnTz82xDSeNum7VqdL0EdbT8v+22p83f3YaalZIK15IBMyL2EP1WKpTSn+2G6ILeDVMUD+Yh2IbHUvPkMy6hRt2zByYQ34HhXFuokA4rQzkiwtEHJD3zcoCfIZOXniOugJyHwWmCYkcq2lRickb5jGwhpvvBc65ICjU58h6wXjTFDheYTSeyJSNLC89eejn29jg2KH6JuIU0nSmTnQLDwjEG8uiGbioqTXZYs6YfiaiNGYMt8UlQQOXwp6nQzHte1Mgf0q4WFsLC0rmLScpvsEQj+GSnU2GCXSBObj+MEoridaFpj/bNiX7YzUOF79mQ/pbmo3SoWTAnjIFjbmBZHMtXmmzAezmNwiCcGqOG6DyfrnkEzvcmKhMPXwD4bXGt7jnt7T+afAFN2T6LuORXJrWuBvk5KFCQSFVEOHBvM6p5jQWv8qN8J0XJhs9rAKGEabVYR8UVEFZLQPBledmHJsDNuQgq/EnpFxuTefs75JyYDrJintjOcv9hLSAuVxU9foHsC+CQux6UOUGliMIziaHJBW6YoqUFotjiB2yDMooZn1Ei68y9Otl19Lx9ztWTdfuong+EkIs8hRWiLbXLGFnbTkgoGxidgXk0cVHsBHil8RiZLQNfvm74a1Fp/BxIat6ZTFakI7xMI36uEDvZ0LKbrBpvCIVX4O8Ma4eYa69QDl0zNX17VP7tN51L3QaZW8miwOyQ7F3VJRcuCH/W1hLqt74oNmk42NovujM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(316002)(6916009)(66946007)(54906003)(66556008)(86362001)(66476007)(8676002)(8936002)(5660300002)(4326008)(478600001)(6486002)(41300700001)(38100700002)(2906002)(9686003)(6506007)(52116002)(6512007)(186003)(1076003)(83380400001)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hSCPz814sYWLh1JpPfx7puQFydhzZApALqsPaA25OeT9KYpEFTR8ma91+IAi?=
 =?us-ascii?Q?MtEx4PEUT23kElszc330mqgGp/srrFUuLHrbX9q1QdgUuF0hoiAYdnON9ctm?=
 =?us-ascii?Q?ysdmf0YGClYrsE3A3JCd+wO9UiZl9R5mu9E6eUmWBDxjHP3LJmWeRnZYTLUu?=
 =?us-ascii?Q?+1k6H402wLkPXGyUdOQKNbZhxDSNDUDmhh1F2sDgXYSXyOm+ACblw2BuD/Dn?=
 =?us-ascii?Q?xAEsieL/hfKFqwEZ/aGRRx0KhvwqIcWAOP14Fdg+VXWkDtANw8gcKnwSjT6w?=
 =?us-ascii?Q?59urim6pbJKkDsUC1GdTqbOCDjcb21eAxcdo6PdMKJ8Z1fF/aDuHsC+9tsah?=
 =?us-ascii?Q?/A81OnJ7c2JF/PUYTSMOoGrD5jqkS4kE6IuMb4rYHO4GdmPuBWfW/7oQWuKr?=
 =?us-ascii?Q?mKGA1CLokSaom8IHL2/mymnjqNVSaQZYNhtLIA87KTuwmVdA1c8dfJLDvbhj?=
 =?us-ascii?Q?2/0yWR01n7TW18NdhlRQ+uX8jiOBdq1GgNZtswJplJDDRf589oWP4sVFxl84?=
 =?us-ascii?Q?tpJFaNLUiJ6Tm85VHPjeXJbTCJNTBiBm1Ud/RhmAStxw/FqwRldolRHe65Zi?=
 =?us-ascii?Q?BHU+dpOgliOH/qiKV1dQav+2w5YsLkcixWLZIKgHNIVQblkO7qysfCUdsRcm?=
 =?us-ascii?Q?byUwGwxedwK3fKfnFI/JfwY0FNz7KzxxjZArMCrBrsLmgZcW3w/vRXqkUzR2?=
 =?us-ascii?Q?AP6hc0cWt5BtWPpUVWR54/3am62KPDOlTU8ZukdpG1fLZEQgnIlNCh9ELByE?=
 =?us-ascii?Q?PPRRF9FcMQj+6L3/8PFncs7Wu7YmVb3QXPoTdL/+dai2F4jfFx9FbFqMlVPp?=
 =?us-ascii?Q?diymniIr/sRO3ZTWUeZbFdoIFoIaYFkYwxBl5xgdIJbGi7uDFVZFq9WeZG3L?=
 =?us-ascii?Q?5UL+KkcKkSSG7KA4NDR8ZYbFCHeiaOhuJYxOfSRtKkLUSjqGYHDNVvcVMSi0?=
 =?us-ascii?Q?SvqQVmlglFjQWCzXO3DRhPdSzKZIqTImep47XNFMSWKxXGQO0Geyr2zobRwv?=
 =?us-ascii?Q?XOPPXjIFIswBKBQVsUJl8OmmrJ/ujn7viGMIcGTa2ouuosvSARdVrocTMoBw?=
 =?us-ascii?Q?f5T/cdvKEYwqmMA3YDg5+FudHhMfMhYn1qZlcJK6/+mfNfj/oylY6LR8tx4u?=
 =?us-ascii?Q?ETP8EYcikm3+71C6AXgHTp3FlLjUjV5OtAhaiIOdvlbdYL68XR+bT63MBwdE?=
 =?us-ascii?Q?uElkhzxt4jzeNXPQPQekMh/d3b8Qc0T04xZB6+9IYieiey1kUMMb7IE5B8+Q?=
 =?us-ascii?Q?njmpg9RoqtU9FFY7THltiuMGsJ3B++pH+6b6oK6NCOw6ZWMxl0utoB8pdiKV?=
 =?us-ascii?Q?Rk1z8Doan0GZfCDeNowb8tVORTk+7OD0Em1lzoxEZZ97QQ00xS0C9q0UiswP?=
 =?us-ascii?Q?TDf5FFT+mCc+1AcFVBXpj+UWQqiX02dFg/eiw/55t132ufvDKZMXD2SNuqdq?=
 =?us-ascii?Q?B3FjQ0aBX8EOx/lRq8e0YrRUxccnY26FdJU16hUsMUjGCAcUCSIB4tVmRBh+?=
 =?us-ascii?Q?hXKNUWdyEj9/3gHtKRMvdh0f6y/odhnWMCy1FFhvkhx58yh2qFWdmB1VkmP4?=
 =?us-ascii?Q?V+gxdU9jYEabkXRyu2OdLkNQW/IR8C8q8dVPzh4ZN1LPitXJjQHido55YjZC?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042e1c23-5104-4fe9-c91d-08da7592a6e5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 20:56:35.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPbBkJvWN1AVJ3Odbn4FJZ923vm7gocQigwOX0JJZ2w6I+4KxbaEzQmRclRQJQ06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3140
X-Proofpoint-ORIG-GUID: svQvQh0yK-029z74J4g14PjOaUKt8DHs
X-Proofpoint-GUID: svQvQh0yK-029z74J4g14PjOaUKt8DHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_06,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 03, 2022 at 01:29:37PM -0700, Joanne Koong wrote:
> On Fri, Jul 29, 2022 at 2:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Fri, Jul 29, 2022 at 01:26:31PM -0700, Joanne Koong wrote:
> > > On Thu, Jul 28, 2022 at 4:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Tue, Jul 26, 2022 at 11:47:04AM -0700, Joanne Koong wrote:
> > > > > @@ -1567,6 +1607,18 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
> > > > >       if (bpf_dynptr_is_rdonly(ptr))
> > > > Is it possible to allow data slice for rdonly dynptr-skb?
> > > > and depends on the may_access_direct_pkt_data() check in the verifier.
> > >
> > > Ooh great idea. This should be very simple to do, since the data slice
> > > that gets returned is assigned as PTR_TO_PACKET. So any stx operations
> > > on it will by default go through the may_access_direct_pkt_data()
> > > check. I'll add this for v2.
> > It will be great.  Out of all three helpers (bpf_dynptr_read/write/data),
> > bpf_dynptr_data will be the useful one to parse the header data (e.g. tcp-hdr-opt)
> > that has runtime variable length because bpf_dynptr_data() can take a non-cost
> > 'offset' argument.  It is useful to get a consistent usage across all bpf
> > prog types that are either read-only or read-write of the skb.
> >
> > >
> > > >
> > > > >               return 0;
> > > > >
> > > > > +     type = bpf_dynptr_get_type(ptr);
> > > > > +
> > > > > +     if (type == BPF_DYNPTR_TYPE_SKB) {
> > > > > +             struct sk_buff *skb = ptr->data;
> > > > > +
> > > > > +             /* if the data is paged, the caller needs to pull it first */
> > > > > +             if (ptr->offset + offset + len > skb->len - skb->data_len)
> > > > > +                     return 0;
> > > > > +
> > > > > +             return (unsigned long)(skb->data + ptr->offset + offset);
> > > > > +     }
> > > > > +
> > > > >       return (unsigned long)(ptr->data + ptr->offset + offset);
> > > > >  }
> > > >
> > > > [ ... ]
> > > >
> > > > > -static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > > > > +static void stack_slot_get_dynptr_info(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > > > +                                    struct bpf_call_arg_meta *meta)
> > > > >  {
> > > > >       struct bpf_func_state *state = func(env, reg);
> > > > >       int spi = get_spi(reg->off);
> > > > >
> > > > > -     return state->stack[spi].spilled_ptr.id;
> > > > > +     meta->ref_obj_id = state->stack[spi].spilled_ptr.id;
> > > > > +     meta->type = state->stack[spi].spilled_ptr.dynptr.type;
> > > > >  }
> > > > >
> > > > >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > > > @@ -6052,6 +6057,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > > >                               case DYNPTR_TYPE_RINGBUF:
> > > > >                                       err_extra = "ringbuf ";
> > > > >                                       break;
> > > > > +                             case DYNPTR_TYPE_SKB:
> > > > > +                                     err_extra = "skb ";
> > > > > +                                     break;
> > > > >                               default:
> > > > >                                       break;
> > > > >                               }
> > > > > @@ -6065,8 +6073,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > > >                                       verbose(env, "verifier internal error: multiple refcounted args in BPF_FUNC_dynptr_data");
> > > > >                                       return -EFAULT;
> > > > >                               }
> > > > > -                             /* Find the id of the dynptr we're tracking the reference of */
> > > > > -                             meta->ref_obj_id = stack_slot_get_id(env, reg);
> > > > > +                             /* Find the id and the type of the dynptr we're tracking
> > > > > +                              * the reference of.
> > > > > +                              */
> > > > > +                             stack_slot_get_dynptr_info(env, reg, meta);
> > > > >                       }
> > > > >               }
> > > > >               break;
> > > > > @@ -7406,7 +7416,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > > > >               regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
> > > > >       } else if (base_type(ret_type) == RET_PTR_TO_ALLOC_MEM) {
> > > > >               mark_reg_known_zero(env, regs, BPF_REG_0);
> > > > > -             regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> > > > > +             if (func_id == BPF_FUNC_dynptr_data &&
> > > > > +                 meta.type == BPF_DYNPTR_TYPE_SKB)
> > > > > +                     regs[BPF_REG_0].type = PTR_TO_PACKET | ret_flag;
> > > > > +             else
> > > > > +                     regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> > > > >               regs[BPF_REG_0].mem_size = meta.mem_size;
> > > > check_packet_access() uses range.
> > > > It took me a while to figure range and mem_size is in union.
> > > > Mentioning here in case someone has similar question.
> > > For v2, I'll add this as a comment in the code or I'll include
> > > "regs[BPF_REG_0].range = meta.mem_size" explicitly to make it more
> > > obvious :)
> > 'regs[BPF_REG_0].range = meta.mem_size' would be great.  No strong
> > opinion here.
> >
> > > >
> > > > >       } else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
> > > > >               const struct btf_type *t;
> > > > > @@ -14132,6 +14146,25 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> > > > >                       goto patch_call_imm;
> > > > >               }
> > > > >
> > > > > +             if (insn->imm == BPF_FUNC_dynptr_from_skb) {
> > > > > +                     if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE))
> > > > > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, true);
> > > > > +                     else
> > > > > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, false);
> > > > > +                     insn_buf[1] = *insn;
> > > > > +                     cnt = 2;
> > > > > +
> > > > > +                     new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > > > > +                     if (!new_prog)
> > > > > +                             return -ENOMEM;
> > > > > +
> > > > > +                     delta += cnt - 1;
> > > > > +                     env->prog = new_prog;
> > > > > +                     prog = new_prog;
> > > > > +                     insn = new_prog->insnsi + i + delta;
> > > > > +                     goto patch_call_imm;
> > > > > +             }
> > > > Have you considered to reject bpf_dynptr_write()
> > > > at prog load time?
> > > It's possible to reject bpf_dynptr_write() at prog load time but would
> > > require adding tracking in the verifier for whether a dynptr is
> > > read-only or not. Do you think it's better to reject it at load time
> > > instead of returning NULL at runtime?
> > The check_helper_call above seems to know 'meta.type == BPF_DYNPTR_TYPE_SKB'.
> > Together with may_access_direct_pkt_data(), would it be enough ?
> > Then no need to do patching for BPF_FUNC_dynptr_from_skb here.
> 
> Thinking about this some more, I think BPF_FUNC_dynptr_from_skb needs
> to be patched regardless in order to set the rd-only flag in the
> metadata for the dynptr. There will be other helper functions that
> write into dynptrs (eg memcpy with dynptrs, strncpy with dynptrs,
> probe read user with dynptrs, ...) so I think it's more scalable if we
> reject these writes at runtime through the rd-only flag in the
> metadata, than for the verifier to custom-case that any helper funcs
> that write into dynptrs will need to get dynptr type + do
> may_access_direct_pkt_data() if it's type skb or xdp. The
> inconsistency between not rd-only in metadata vs. rd-only in verifier
> might be a little confusing as well.
> 
> For these reasons, I'm leaning more towards having bpf_dynptr_write()
> and other dynptr write helper funcs be rejected at runtime instead of
> prog load time, but I'm eager to hear what you prefer.
> 
> What are your thoughts?
Sure, as long as bpf_dynptr_data() is not restricted by the rdonly dynptr.
