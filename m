Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DB8320181
	for <lists+bpf@lfdr.de>; Sat, 20 Feb 2021 00:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBSXCm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 18:02:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhBSXCl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Feb 2021 18:02:41 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JMW6hY021455;
        Fri, 19 Feb 2021 18:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DNWcZWHipdrnhImy3coBKoldr/vJCIdJ9QLj2+IjM4I=;
 b=T+jtDVQNlSa5xe9wjKMcjZLy/6OIGo6GhSTBA6GV/lnmMaTGjwblWc0BE+hwEv9zAOUi
 EyQht9CUHvQb0kAfug3etYq8riN8ycFeK2iI/L7QHzcJmO3/JRxc8o2E728+IcFJpwQ9
 Yvond/KEAciE/IRV4Cu01xwAXl3AQJQ1EIRGSkd1Ph9W6rM5DINnINIcPwpIzEVtZDBT
 1lsQLLPJKo+EIwjAHGwWCDT8O+I5LejxT85RqPRbXxuqlBOrdZiVU5gwbb60kIioN/BK
 umu58cvj8te58wwYBvFjsOSIaNVKLKqXN2atnuxm/ppTwG8h7O6RBIUS0NALJkSuBNqK Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tp540k1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 18:01:46 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JMv6kg119707;
        Fri, 19 Feb 2021 18:01:46 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tp540jyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 18:01:45 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JMwabv030435;
        Fri, 19 Feb 2021 23:01:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 36rw3uaj47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 23:01:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JN1T4W36700524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 23:01:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBBDB11C050;
        Fri, 19 Feb 2021 23:01:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B15F11C04A;
        Fri, 19 Feb 2021 23:01:40 +0000 (GMT)
Received: from [9.145.178.56] (unknown [9.145.178.56])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 23:01:40 +0000 (GMT)
Message-ID: <0184706c7c4ba2d4a2c3a64d5bd51e5e7d65d3b5.camel@linux.ibm.com>
Subject: Re: [PATCH v2 bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Sat, 20 Feb 2021 00:01:39 +0100
In-Reply-To: <3503fca1-9702-97bc-5385-d36919cb50a4@fb.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
         <20210219022543.20893-3-iii@linux.ibm.com>
         <3503fca1-9702-97bc-5385-d36919cb50a4@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190176
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2021-02-18 at 20:22 -0800, Yonghong Song wrote:
> 
> 
> On 2/18/21 6:25 PM, Ilya Leoshkevich wrote:
> > The logic follows that of BTF_KIND_INT most of the time.
> > Sanitization
> > replaces BTF_KIND_FLOATs with BTF_KIND_TYPEDEFs pointing to
> > equally-sized BTF_KIND_ARRAYs on older kernels.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >   tools/lib/bpf/btf.c             | 44
> > ++++++++++++++++++++++++++++++++
> >   tools/lib/bpf/btf.h             |  8 ++++++
> >   tools/lib/bpf/btf_dump.c        |  4 +++
> >   tools/lib/bpf/libbpf.c          | 45
> > ++++++++++++++++++++++++++++++++-
> >   tools/lib/bpf/libbpf.map        |  5 ++++
> >   tools/lib/bpf/libbpf_internal.h |  2 ++
> >   6 files changed, 107 insertions(+), 1 deletion(-)
> > 
> [...]
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > index 2f9d685bd522..5e957fcceee6 100644
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
> > @@ -279,6 +279,7 @@ static int btf_dump_mark_referenced(struct
> > btf_dump *d)
> >                 case BTF_KIND_INT:
> >                 case BTF_KIND_ENUM:
> >                 case BTF_KIND_FWD:
> > +               case BTF_KIND_FLOAT:
> >                         break;
> >   
> >                 case BTF_KIND_VOLATILE:
> > @@ -453,6 +454,7 @@ static int btf_dump_order_type(struct btf_dump
> > *d, __u32 id, bool through_ptr)
> >   
> >         switch (btf_kind(t)) {
> >         case BTF_KIND_INT:
> > +       case BTF_KIND_FLOAT:
> >                 tstate->order_state = ORDERED;
> >                 return 0;
> >   
> > @@ -1133,6 +1135,7 @@ static void btf_dump_emit_type_decl(struct
> > btf_dump *d, __u32 id,
> >                 case BTF_KIND_STRUCT:
> >                 case BTF_KIND_UNION:
> >                 case BTF_KIND_TYPEDEF:
> > +               case BTF_KIND_FLOAT:
> >                         goto done;
> >                 default:
> >                         pr_warn("unexpected type in decl chain,
> > kind:%u, id:[%u]\n",
> > @@ -1247,6 +1250,7 @@ static void btf_dump_emit_type_chain(struct
> > btf_dump *d,
> >   
> >                 switch (kind) {
> >                 case BTF_KIND_INT:
> > +               case BTF_KIND_FLOAT:
> >                         btf_dump_emit_mods(d, decls);
> >                         name = btf_name_of(d, t->name_off);
> >                         btf_dump_printf(d, "%s", name);
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index d43cc3f29dae..3b170066d613 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -178,6 +178,8 @@ enum kern_feature_id {
> >         FEAT_PROG_BIND_MAP,
> >         /* Kernel support for module BTFs */
> >         FEAT_MODULE_BTF,
> > +       /* BTF_KIND_FLOAT support */
> > +       FEAT_BTF_FLOAT,
> >         __FEAT_CNT,
> >   };
> >   
> > @@ -1935,6 +1937,7 @@ static const char *btf_kind_str(const struct
> > btf_type *t)
> >         case BTF_KIND_FUNC_PROTO: return "func_proto";
> >         case BTF_KIND_VAR: return "var";
> >         case BTF_KIND_DATASEC: return "datasec";
> > +       case BTF_KIND_FLOAT: return "float";
> >         default: return "unknown";
> >         }
> >   }
> > @@ -2384,18 +2387,22 @@ static bool btf_needs_sanitization(struct
> > bpf_object *obj)
> >   {
> >         bool has_func_global =
> > kernel_supports(FEAT_BTF_GLOBAL_FUNC);
> >         bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
> > +       bool has_float = kernel_supports(FEAT_BTF_FLOAT);
> >         bool has_func = kernel_supports(FEAT_BTF_FUNC);
> >   
> > -       return !has_func || !has_datasec || !has_func_global;
> > +       return !has_func || !has_datasec || !has_func_global ||
> > !has_float;
> >   }
> >   
> >   static void bpf_object__sanitize_btf(struct bpf_object *obj,
> > struct btf *btf)
> >   {
> >         bool has_func_global =
> > kernel_supports(FEAT_BTF_GLOBAL_FUNC);
> >         bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
> > +       bool has_float = kernel_supports(FEAT_BTF_FLOAT);
> >         bool has_func = kernel_supports(FEAT_BTF_FUNC);
> >         struct btf_type *t;
> >         int i, j, vlen;
> > +       int t_u32 = 0;
> > +       int t_u8 = 0;
> >   
> >         for (i = 1; i <= btf__get_nr_types(btf); i++) {
> >                 t = (struct btf_type *)btf__type_by_id(btf, i);
> > @@ -2445,6 +2452,23 @@ static void bpf_object__sanitize_btf(struct
> > bpf_object *obj, struct btf *btf)
> >                 } else if (!has_func_global && btf_is_func(t)) {
> >                         /* replace BTF_FUNC_GLOBAL with
> > BTF_FUNC_STATIC */
> >                         t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0,
> > 0);
> > +               } else if (!has_float && btf_is_float(t)) {
> > +                       /* replace FLOAT with TYPEDEF(u8[]) */
> > +                       int t_array;
> > +                       __u32 size;
> > +
> > +                       size = t->size;
> > +                       if (!t_u8)
> > +                               t_u8 = btf__add_int(btf, "u8", 1,
> > 0);
> > +                       if (!t_u32)
> > +                               t_u32 = btf__add_int(btf, "u32", 4,
> > 0);
> > +                       t_array = btf__add_array(btf, t_u32, t_u8,
> > size);
> > +
> > +                       /* adding new types may have invalidated t
> > */
> > +                       t = (struct btf_type *)btf__type_by_id(btf,
> > i);
> > +
> > +                       t->info = BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0,
> > 0);
> 
> This won't work. The typedef must have a valid name. Otherwise,
> kernel 
> will reject it. A const char array should be okay here.

Wouldn't it reuse the old t->name? At least in my testing with v5.7
kernel this was the case, and BTF wasn't rejected. And the original
BTF_KIND_FLOAT always has a valid name, this is enforced in libbpf and
in the verifier. For example:

[1] PTR '(anon)' type_id=2
[2] STRUCT 'foo' size=4 vlen=1
	'bar' type_id=3 bits_offset=0
[3] FLOAT 'float' size=4
[4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
	'f' type_id=1
[5] PTR '(anon)' type_id=0
[6] FUNC 'func' type_id=4 linkage=global

becomes

[1] PTR '(anon)' type_id=2
[2] STRUCT 'foo' size=4 vlen=1
	'bar' type_id=3 bits_offset=0
[3] TYPEDEF 'float' type_id=9
[4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
	'f' type_id=1
[5] PTR '(anon)' type_id=0
[6] FUNC 'func' type_id=4 linkage=global
[7] INT 'u8' size=1 bits_offset=0 nr_bits=8 encoding=(none)
[8] INT 'u32' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[9] ARRAY '(anon)' type_id=7 index_type_id=8 nr_elems=4

