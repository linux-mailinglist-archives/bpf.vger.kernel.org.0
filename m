Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0913201F3
	for <lists+bpf@lfdr.de>; Sat, 20 Feb 2021 00:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBSXok (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 18:44:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbhBSXoj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Feb 2021 18:44:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JNVpnh022581;
        Fri, 19 Feb 2021 18:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=AscCWYO3YWhf4pYjoQnbulfpEkSOuA/yddb/2YjzL4c=;
 b=JqNM5UVzRAYoW7/biR4Dyf4jXqGfNrEfs821ptD0tKuP7T5NqU5JQE3IgIMr5/exVj5l
 C15RZtpWW/UR7OOXCPW0ZAbhcP6rw5EwBGyPAQFPlfeyq/tKnwHc6Y0pcZ4J+4u5C4ls
 4zlKI3+yD9Am/iIlzY+aNhQ/o79FG0QBzprHHhnT91fQSAvl9OMjDbZpuGBn3y1oNz4s
 +uuNc3Ls0ZFWfGV0u1xuNwS6RiaRZ6aZ9r3Xym1fdNH2c8JSYfo/L80jAiVw6gnhgvZz
 l7AUjjniEX3Mtr8wzbmLRVINOr9iH/VEjXF63vOPLzLaNZ7LaZpWLvhoj5V0YAKyDtvg ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tq31r77c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 18:43:45 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JNb1LK037628;
        Fri, 19 Feb 2021 18:43:44 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tq31r76h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 18:43:44 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JNgkVB001401;
        Fri, 19 Feb 2021 23:43:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 36rw3uajtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 23:43:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JNhdhA11731422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 23:43:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1956A4040;
        Fri, 19 Feb 2021 23:43:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 532EEA404D;
        Fri, 19 Feb 2021 23:43:39 +0000 (GMT)
Received: from [9.145.178.56] (unknown [9.145.178.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 23:43:39 +0000 (GMT)
Message-ID: <b83050016172a246c6a0be9047775e4701b36f92.camel@linux.ibm.com>
Subject: Re: [PATCH v2 bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Sat, 20 Feb 2021 00:43:39 +0100
In-Reply-To: <a5dacc42-66cf-ed1b-812c-d54bf7d42c2c@fb.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
         <20210219022543.20893-3-iii@linux.ibm.com>
         <3503fca1-9702-97bc-5385-d36919cb50a4@fb.com>
         <0184706c7c4ba2d4a2c3a64d5bd51e5e7d65d3b5.camel@linux.ibm.com>
         <a5dacc42-66cf-ed1b-812c-d54bf7d42c2c@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190187
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2021-02-19 at 15:35 -0800, Yonghong Song wrote:
> 
> 
> On 2/19/21 3:01 PM, Ilya Leoshkevich wrote:
> > On Thu, 2021-02-18 at 20:22 -0800, Yonghong Song wrote:
> > > 
> > > 
> > > On 2/18/21 6:25 PM, Ilya Leoshkevich wrote:
> > > > The logic follows that of BTF_KIND_INT most of the time.
> > > > Sanitization
> > > > replaces BTF_KIND_FLOATs with BTF_KIND_TYPEDEFs pointing to
> > > > equally-sized BTF_KIND_ARRAYs on older kernels.
> > > > 
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > >    tools/lib/bpf/btf.c             | 44
> > > > ++++++++++++++++++++++++++++++++
> > > >    tools/lib/bpf/btf.h             |  8 ++++++
> > > >    tools/lib/bpf/btf_dump.c        |  4 +++
> > > >    tools/lib/bpf/libbpf.c          | 45
> > > > ++++++++++++++++++++++++++++++++-
> > > >    tools/lib/bpf/libbpf.map        |  5 ++++
> > > >    tools/lib/bpf/libbpf_internal.h |  2 ++
> > > >    6 files changed, 107 insertions(+), 1 deletion(-)
> > > > 
> > > [...]
> > > > diff --git a/tools/lib/bpf/btf_dump.c
> > > > b/tools/lib/bpf/btf_dump.c
> > > > index 2f9d685bd522..5e957fcceee6 100644
> > > > --- a/tools/lib/bpf/btf_dump.c
> > > > +++ b/tools/lib/bpf/btf_dump.c
> > > > @@ -279,6 +279,7 @@ static int btf_dump_mark_referenced(struct
> > > > btf_dump *d)
> > > >                  case BTF_KIND_INT:
> > > >                  case BTF_KIND_ENUM:
> > > >                  case BTF_KIND_FWD:
> > > > +               case BTF_KIND_FLOAT:
> > > >                          break;
> > > >    
> > > >                  case BTF_KIND_VOLATILE:
> > > > @@ -453,6 +454,7 @@ static int btf_dump_order_type(struct
> > > > btf_dump
> > > > *d, __u32 id, bool through_ptr)
> > > >    
> > > >          switch (btf_kind(t)) {
> > > >          case BTF_KIND_INT:
> > > > +       case BTF_KIND_FLOAT:
> > > >                  tstate->order_state = ORDERED;
> > > >                  return 0;
> > > >    
> > > > @@ -1133,6 +1135,7 @@ static void
> > > > btf_dump_emit_type_decl(struct
> > > > btf_dump *d, __u32 id,
> > > >                  case BTF_KIND_STRUCT:
> > > >                  case BTF_KIND_UNION:
> > > >                  case BTF_KIND_TYPEDEF:
> > > > +               case BTF_KIND_FLOAT:
> > > >                          goto done;
> > > >                  default:
> > > >                          pr_warn("unexpected type in decl
> > > > chain,
> > > > kind:%u, id:[%u]\n",
> > > > @@ -1247,6 +1250,7 @@ static void
> > > > btf_dump_emit_type_chain(struct
> > > > btf_dump *d,
> > > >    
> > > >                  switch (kind) {
> > > >                  case BTF_KIND_INT:
> > > > +               case BTF_KIND_FLOAT:
> > > >                          btf_dump_emit_mods(d, decls);
> > > >                          name = btf_name_of(d, t->name_off);
> > > >                          btf_dump_printf(d, "%s", name);
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index d43cc3f29dae..3b170066d613 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -178,6 +178,8 @@ enum kern_feature_id {
> > > >          FEAT_PROG_BIND_MAP,
> > > >          /* Kernel support for module BTFs */
> > > >          FEAT_MODULE_BTF,
> > > > +       /* BTF_KIND_FLOAT support */
> > > > +       FEAT_BTF_FLOAT,
> > > >          __FEAT_CNT,
> > > >    };
> > > >    
> > > > @@ -1935,6 +1937,7 @@ static const char *btf_kind_str(const
> > > > struct
> > > > btf_type *t)
> > > >          case BTF_KIND_FUNC_PROTO: return "func_proto";
> > > >          case BTF_KIND_VAR: return "var";
> > > >          case BTF_KIND_DATASEC: return "datasec";
> > > > +       case BTF_KIND_FLOAT: return "float";
> > > >          default: return "unknown";
> > > >          }
> > > >    }
> > > > @@ -2384,18 +2387,22 @@ static bool
> > > > btf_needs_sanitization(struct
> > > > bpf_object *obj)
> > > >    {
> > > >          bool has_func_global =
> > > > kernel_supports(FEAT_BTF_GLOBAL_FUNC);
> > > >          bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
> > > > +       bool has_float = kernel_supports(FEAT_BTF_FLOAT);
> > > >          bool has_func = kernel_supports(FEAT_BTF_FUNC);
> > > >    
> > > > -       return !has_func || !has_datasec || !has_func_global;
> > > > +       return !has_func || !has_datasec || !has_func_global ||
> > > > !has_float;
> > > >    }
> > > >    
> > > >    static void bpf_object__sanitize_btf(struct bpf_object *obj,
> > > > struct btf *btf)
> > > >    {
> > > >          bool has_func_global =
> > > > kernel_supports(FEAT_BTF_GLOBAL_FUNC);
> > > >          bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
> > > > +       bool has_float = kernel_supports(FEAT_BTF_FLOAT);
> > > >          bool has_func = kernel_supports(FEAT_BTF_FUNC);
> > > >          struct btf_type *t;
> > > >          int i, j, vlen;
> > > > +       int t_u32 = 0;
> > > > +       int t_u8 = 0;
> > > >    
> > > >          for (i = 1; i <= btf__get_nr_types(btf); i++) {
> > > >                  t = (struct btf_type *)btf__type_by_id(btf,
> > > > i);
> > > > @@ -2445,6 +2452,23 @@ static void
> > > > bpf_object__sanitize_btf(struct
> > > > bpf_object *obj, struct btf *btf)
> > > >                  } else if (!has_func_global && btf_is_func(t))
> > > > {
> > > >                          /* replace BTF_FUNC_GLOBAL with
> > > > BTF_FUNC_STATIC */
> > > >                          t->info = BTF_INFO_ENC(BTF_KIND_FUNC,
> > > > 0,
> > > > 0);
> > > > +               } else if (!has_float && btf_is_float(t)) {
> > > > +                       /* replace FLOAT with TYPEDEF(u8[]) */
> > > > +                       int t_array;
> > > > +                       __u32 size;
> > > > +
> > > > +                       size = t->size;
> > > > +                       if (!t_u8)
> > > > +                               t_u8 = btf__add_int(btf, "u8",
> > > > 1,
> > > > 0);
> > > > +                       if (!t_u32)
> > > > +                               t_u32 = btf__add_int(btf,
> > > > "u32", 4,
> > > > 0);
> > > > +                       t_array = btf__add_array(btf, t_u32,
> > > > t_u8,
> > > > size);
> > > > +
> > > > +                       /* adding new types may have
> > > > invalidated t
> > > > */
> > > > +                       t = (struct btf_type
> > > > *)btf__type_by_id(btf,
> > > > i);
> > > > +
> > > > +                       t->info =
> > > > BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0,
> > > > 0);
> > > 
> > > This won't work. The typedef must have a valid name. Otherwise,
> > > kernel
> > > will reject it. A const char array should be okay here.
> > 
> > Wouldn't it reuse the old t->name? At least in my testing with v5.7
> > kernel this was the case, and BTF wasn't rejected. And the original
> > BTF_KIND_FLOAT always has a valid name, this is enforced in libbpf
> > and
> > in the verifier. For example:
> > 
> > [1] PTR '(anon)' type_id=2
> > [2] STRUCT 'foo' size=4 vlen=1
> >         'bar' type_id=3 bits_offset=0
> > [3] FLOAT 'float' size=4
> > [4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> >         'f' type_id=1
> > [5] PTR '(anon)' type_id=0
> > [6] FUNC 'func' type_id=4 linkage=global
> > 
> > becomes
> > 
> > [1] PTR '(anon)' type_id=2
> > [2] STRUCT 'foo' size=4 vlen=1
> >         'bar' type_id=3 bits_offset=0
> > [3] TYPEDEF 'float' type_id=9
> > [4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> >         'f' type_id=1
> > [5] PTR '(anon)' type_id=0
> > [6] FUNC 'func' type_id=4 linkage=global
> > [7] INT 'u8' size=1 bits_offset=0 nr_bits=8 encoding=(none)
> > [8] INT 'u32' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> > [9] ARRAY '(anon)' type_id=7 index_type_id=8 nr_elems=4
> 
> good point, the name is indeed there.
> 
> I originally also thought about using "typedef" but worried
> whether new typedef may polute the existing type names.
> Could you try to dump the modified BTF to a C file
> and compile to see whether typedef mechanism works or not?
> I tried the following code and compilation failed.
> 
> -bash-4.4$ cat t.c
> typedef char * float;
> -bash-4.4$ gcc -c t.c
> t.c:1:16: error: expected identifier or ‘(’ before ‘float’
>   typedef char * float;
>                  ^
> -bash-4.4$
> 
> Changing to a different name may interfere with existing types.
> 
> It may work with the kernel today because we didn't do strict type 
> legality checking, but it would be still be good if we can
> avoid it.

Yeah, the following generated C code does not compile:

typedef u8 float[4];

struct foo {
	float bar;
};

I'll go with const. Thanks for the hint!

