Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CEA585691
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 23:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiG2Vjk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 17:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbiG2Vjj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 17:39:39 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7798C17E
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 14:39:37 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TLPJBW023260;
        Fri, 29 Jul 2022 14:39:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tH7z87pGoyGMYjGWnVZMYSnrOXlmMSPxuJATNfjqLdc=;
 b=IxWcFbUIl2fGyUTq5NeQTy1AWTOTp4GR75sXnc4BJGd//y79TtCUt8oo2Fum1rQ2LyZz
 yxfR0d42t6LDDqzJ/h6EtgBjhmw7/05EeTBMiKVlFL8hC07EvgCZCsEI00Z0RaiTK2iT
 psxrqUjQppi4xS0fcdD+Sr956cXaXSvmt90= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hmqetr2s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 14:39:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byJlmFJioCnX8DA1pdLfw+tmsL0pPdBaao9N0KVHW9hGurywUBcwl9w8cQyH72323ZJ60VY9iEhMV1U9lKHdfttQ1NjxhvPZ8dNW3snoxweRQEnKkKpNhvsDLx0mwHe/VK16EFDLnI0W2fBDpOIsgCdsVoJbrRD4b2IKXbfEXFViTNDVa9C8VYDYlR9DtTuFxSb2eRUUmzRkXGDy4NtZ/fZAx7fZxGqfa7cVh+4tYNut0yilnlk9ZNioB4JE4YVlolqlMUjkTDO4aCAoTmvspRtzZjpFOwtHbm6AMl1TXGIzHP+7FL4xqmTlKwKG3WOeWUM7cfrcMb1B8G3O6OKGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH7z87pGoyGMYjGWnVZMYSnrOXlmMSPxuJATNfjqLdc=;
 b=AAaDc93iu4lajRGhg0aY/LcEUa408tYz0zaRjmNcTIqzlcjwq94LG35VvOkUrsTCzhwzcVGOEPBqOA4Suci7f6iS8agx1M0quLhwsC9hZ9wA8pjA2cur87T6Ul29uxWQ90GxkDyHtoNDS833IRr3uH3NmW7fBytQulLMFjg3R6hlhEF1AaLSgxLz2R4IeoDIISkXIeDu8d5YeEcjmUArm00txHci9mMzdL5uXxfIc54ZU767mYgH90lb/KdQ2Y62nVOSQBxp0hHhKbx7Zh33CGKN8DAcFqUYMfUscfygyMvMxgMj0yZ1vPFEDVYQjCnhxUvGHWcXfF2IUrdJ/jNEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BLAPR15MB3794.namprd15.prod.outlook.com (2603:10b6:208:271::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 21:39:21 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::4428:3a1e:4625:3a7a]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::4428:3a1e:4625:3a7a%6]) with mapi id 15.20.5482.012; Fri, 29 Jul 2022
 21:39:21 +0000
Date:   Fri, 29 Jul 2022 14:39:19 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com>
 <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88f37c6e-bc4a-4d55-03b4-08da71aacc3e
X-MS-TrafficTypeDiagnostic: BLAPR15MB3794:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Py3qrve5rcOQ1MsuPcZaacHxhi7NPjw+pNN68chKPi9dDs5e5wNvMzDb/GBkjqUPw0iN0bWoPQTtgsvdVuPpwwve1xl914kbwKjFx3oI9gDv3VJmu4nQ+7JKfvrJ2B63qo1WcX2ghDrXkvTDaJnaSEwXUZg4i89dgWqemwmgARQ/EXHJ6Nebs0assdiiiVJiylFbSMmz0Plrt2wxRYwMxUHDHsWOgrVxCDi9qISEGVnXeLJ09AgyHKIEB5X2LYX/LPrHZKGUEXX2R3xy43ksBofHukdKQwpD5yJOAOej9uqlpCVVVazYZoMlz6WdAqv7Q3JBHF9Yc59f5wyhhRiFvRMh0RzC6NLTB/lzq1wxa5mxXRMiZrV8oCNJQ2eUlG3SP7/zs8vQ4glWz8YUIW+Rtj/CU5tYFMdzUwmgfUWMoT7pv3tNekcfpfaP9orChwQYm37olixL5ajbT3FpLk0CEeD7+qs2uhjiwVbBIBlQYERAI9j7Bt/ctjZ8DUlryKucY/NzVBbV1JvqFKD/Q+mw8a4QGNB7isVgbI7mPtMJXb3B3hhifw6F/84oKH9Ntyn9/u7/nMotcqLuPhx35XX5kphR25jwc1adSNpHkJsK8rtD/BWqDfI8OnI1UuYxCOjURNcREx6camzc99HOxmM7Kg/0ThmrKfQR2kQo/jDy9vVJkQAOYdy/R2z8i4xh7gE9UM6DtesSrWQkWQxy9jw8PNyOErX18Wb88p13RMjnyFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(83380400001)(1076003)(186003)(38100700002)(54906003)(316002)(8936002)(5660300002)(66946007)(6916009)(8676002)(4326008)(66556008)(66476007)(6506007)(53546011)(41300700001)(52116002)(2906002)(478600001)(9686003)(86362001)(6486002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kDY6nWjqUmb3VmLR8o5jMmoTPeuHi++7BZdfBc+67n7G4KQuuox0fsS4Bter?=
 =?us-ascii?Q?orZyRdK2TxpdYCyiPEr22Ue2rrNyE6YeHZPQIPnPn2oEp41i9IVkmyW0wcDa?=
 =?us-ascii?Q?mGNmydhggVxhixYvrHWg6WiQ/Y3KiG98BLC4G7p+4+k8ys4EOYZ4xLbzbFlr?=
 =?us-ascii?Q?a6WhJPnyNI9JSLvZEl7iLWi2fC0KIFwDMg+dQuIIIZrrDv2AI8I0JhosV0lD?=
 =?us-ascii?Q?bDpS5efVqGAsweVaOIgEJPnnWwOtSaFJesFMns1evxCvW6pCgTDoT+qocR3A?=
 =?us-ascii?Q?wy3wJCOEgF7d6xtptLk4rXMwZt/IbObwnHdLtmnmpGfqKCXRK6kkakCzMVd6?=
 =?us-ascii?Q?DPRUvAYikPuKc0mQBFz+W9UNjP3XcyD9tQUZ0CmjoX30QYQjRixulDutU7vr?=
 =?us-ascii?Q?9kjbhYFenAwove3dagaVwG/rbvkbO5DcpkG3yVe2XjrXGdtQtm6jj2CiOXiL?=
 =?us-ascii?Q?zrTAaZFonTYx7JMI/pM2bgiTY9+cSF0lZx4jTLbHBdPZf7sL10U13cs4sZfD?=
 =?us-ascii?Q?AnatxovjrF3FcvqYblYbysb5TQATI9cpBu6GzQCgFJKBcqXJHqG4PdKcSOWD?=
 =?us-ascii?Q?h1NN2Z6deEOUmg8Sabz7fYhLwkQovst6+YsOSQvxrpxnFqDuKY7TCqe/rROf?=
 =?us-ascii?Q?tTR6qxreDkEmNiZYtz2hRnKHVN+rR0rZiGsHx/NxXeGbVkq+9oWPIq8Xbt9J?=
 =?us-ascii?Q?LRSeNT0A/5oYus4f5LmXvkG7Kbjkdmgs0ah/7aXDt7vU8StBJ+td1D3LZ7Ok?=
 =?us-ascii?Q?9Nq82za6+gMC/xQdrh18q+tXP+KdbhSa51zcrDjIwgWYNo32ZQHcIlm0Xz9n?=
 =?us-ascii?Q?6EfBunt7JiWZGRVd/E280ADAJOErSoYEux0RBv7q3FfBDKe1HeWI2TR1VhIi?=
 =?us-ascii?Q?yExE+SJPSnDKMgFwaNtU8c6NxF7LTHyRUpJQs2Q2MltPVe69qvAiMRzpTuya?=
 =?us-ascii?Q?4vtiaaZhS1RJS10iDvkgZESSzZnC/4d4NTUBPOtvw8LGv2ptJnq0DJ09TtSL?=
 =?us-ascii?Q?6iB7t4lokSmw4BvcMNi5GjbQW+M0+pjjSzmoml/XKEYk1SPNa9NMufkwjhXV?=
 =?us-ascii?Q?1/bmWBBRs2C49DKk5qNpWqNX+otgpxdKy2CAP//b/Q+iXfgLjZovzeyvbfnP?=
 =?us-ascii?Q?TJb29ICjo/XW4Lyo2AsbVwsFzfJ5pQEXS+apt+vt+KgvJ/3woVSod03kqJe9?=
 =?us-ascii?Q?hFDmeoHvOm1cgiH3i09OWVh2D55jOt4vH3kKA2Pl1SHNQUFZcjoH6N5AialH?=
 =?us-ascii?Q?WnJvZfiS1Gcb2vtirPZaCcxYUy37UD157p/uEy3Vk7IpKeVm8/Rbt/gVE67P?=
 =?us-ascii?Q?xytldYyg4n1DPUKuPm/Srwe+bkph/wu4PCg9silvPV+1oJSq+Z7O7pMfVTn4?=
 =?us-ascii?Q?7vbqlspidAc3SugJ72tqHCkevtQZx3++pdaHBfhxW86YrXvl0VqjG23PERRo?=
 =?us-ascii?Q?upnXJ9h3DAUOaWW7yo7mTohRjK2WMn9AQMtt5tB/jxUToY/Z50uVuPQiktjK?=
 =?us-ascii?Q?Xf2o49Ghuq2mClLBuvo5i3crqUOeBCFrS1tBechMyOEz5B3gzQ78OF/kMSuv?=
 =?us-ascii?Q?PvQn2oEt0gfi+2BseU4NY9/duXT9n3eNjcYk7CzanpZRvjh2g0CtM6Br1W4p?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f37c6e-bc4a-4d55-03b4-08da71aacc3e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 21:39:21.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEjQKS7xrKkJkXx7EGg3pr3BSEAcitnKTIh33ZYhu204PeUX9WmeTgLtD9L0DioO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3794
X-Proofpoint-ORIG-GUID: NZwJO-EdFJpVDjQ3zrKzrSfNg2UFy0C5
X-Proofpoint-GUID: NZwJO-EdFJpVDjQ3zrKzrSfNg2UFy0C5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_20,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 29, 2022 at 01:26:31PM -0700, Joanne Koong wrote:
> On Thu, Jul 28, 2022 at 4:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, Jul 26, 2022 at 11:47:04AM -0700, Joanne Koong wrote:
> > > @@ -1567,6 +1607,18 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
> > >       if (bpf_dynptr_is_rdonly(ptr))
> > Is it possible to allow data slice for rdonly dynptr-skb?
> > and depends on the may_access_direct_pkt_data() check in the verifier.
> 
> Ooh great idea. This should be very simple to do, since the data slice
> that gets returned is assigned as PTR_TO_PACKET. So any stx operations
> on it will by default go through the may_access_direct_pkt_data()
> check. I'll add this for v2.
It will be great.  Out of all three helpers (bpf_dynptr_read/write/data),
bpf_dynptr_data will be the useful one to parse the header data (e.g. tcp-hdr-opt)
that has runtime variable length because bpf_dynptr_data() can take a non-cost
'offset' argument.  It is useful to get a consistent usage across all bpf
prog types that are either read-only or read-write of the skb.

> 
> >
> > >               return 0;
> > >
> > > +     type = bpf_dynptr_get_type(ptr);
> > > +
> > > +     if (type == BPF_DYNPTR_TYPE_SKB) {
> > > +             struct sk_buff *skb = ptr->data;
> > > +
> > > +             /* if the data is paged, the caller needs to pull it first */
> > > +             if (ptr->offset + offset + len > skb->len - skb->data_len)
> > > +                     return 0;
> > > +
> > > +             return (unsigned long)(skb->data + ptr->offset + offset);
> > > +     }
> > > +
> > >       return (unsigned long)(ptr->data + ptr->offset + offset);
> > >  }
> >
> > [ ... ]
> >
> > > -static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > > +static void stack_slot_get_dynptr_info(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > +                                    struct bpf_call_arg_meta *meta)
> > >  {
> > >       struct bpf_func_state *state = func(env, reg);
> > >       int spi = get_spi(reg->off);
> > >
> > > -     return state->stack[spi].spilled_ptr.id;
> > > +     meta->ref_obj_id = state->stack[spi].spilled_ptr.id;
> > > +     meta->type = state->stack[spi].spilled_ptr.dynptr.type;
> > >  }
> > >
> > >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > @@ -6052,6 +6057,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > >                               case DYNPTR_TYPE_RINGBUF:
> > >                                       err_extra = "ringbuf ";
> > >                                       break;
> > > +                             case DYNPTR_TYPE_SKB:
> > > +                                     err_extra = "skb ";
> > > +                                     break;
> > >                               default:
> > >                                       break;
> > >                               }
> > > @@ -6065,8 +6073,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > >                                       verbose(env, "verifier internal error: multiple refcounted args in BPF_FUNC_dynptr_data");
> > >                                       return -EFAULT;
> > >                               }
> > > -                             /* Find the id of the dynptr we're tracking the reference of */
> > > -                             meta->ref_obj_id = stack_slot_get_id(env, reg);
> > > +                             /* Find the id and the type of the dynptr we're tracking
> > > +                              * the reference of.
> > > +                              */
> > > +                             stack_slot_get_dynptr_info(env, reg, meta);
> > >                       }
> > >               }
> > >               break;
> > > @@ -7406,7 +7416,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > >               regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
> > >       } else if (base_type(ret_type) == RET_PTR_TO_ALLOC_MEM) {
> > >               mark_reg_known_zero(env, regs, BPF_REG_0);
> > > -             regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> > > +             if (func_id == BPF_FUNC_dynptr_data &&
> > > +                 meta.type == BPF_DYNPTR_TYPE_SKB)
> > > +                     regs[BPF_REG_0].type = PTR_TO_PACKET | ret_flag;
> > > +             else
> > > +                     regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> > >               regs[BPF_REG_0].mem_size = meta.mem_size;
> > check_packet_access() uses range.
> > It took me a while to figure range and mem_size is in union.
> > Mentioning here in case someone has similar question.
> For v2, I'll add this as a comment in the code or I'll include
> "regs[BPF_REG_0].range = meta.mem_size" explicitly to make it more
> obvious :)
'regs[BPF_REG_0].range = meta.mem_size' would be great.  No strong
opinion here.

> >
> > >       } else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
> > >               const struct btf_type *t;
> > > @@ -14132,6 +14146,25 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> > >                       goto patch_call_imm;
> > >               }
> > >
> > > +             if (insn->imm == BPF_FUNC_dynptr_from_skb) {
> > > +                     if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE))
> > > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, true);
> > > +                     else
> > > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, false);
> > > +                     insn_buf[1] = *insn;
> > > +                     cnt = 2;
> > > +
> > > +                     new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > > +                     if (!new_prog)
> > > +                             return -ENOMEM;
> > > +
> > > +                     delta += cnt - 1;
> > > +                     env->prog = new_prog;
> > > +                     prog = new_prog;
> > > +                     insn = new_prog->insnsi + i + delta;
> > > +                     goto patch_call_imm;
> > > +             }
> > Have you considered to reject bpf_dynptr_write()
> > at prog load time?
> It's possible to reject bpf_dynptr_write() at prog load time but would
> require adding tracking in the verifier for whether a dynptr is
> read-only or not. Do you think it's better to reject it at load time
> instead of returning NULL at runtime?
The check_helper_call above seems to know 'meta.type == BPF_DYNPTR_TYPE_SKB'.
Together with may_access_direct_pkt_data(), would it be enough ?
Then no need to do patching for BPF_FUNC_dynptr_from_skb here.

Since we are on bpf_dynptr_write, what is the reason
on limiting it to the skb_headlen() ?  Not implying one
way is better than another.  would like to undertand the reason
behind it since it is not clear in the commit message.
