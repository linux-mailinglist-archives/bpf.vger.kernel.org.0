Return-Path: <bpf+bounces-49430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D00EA18A27
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 03:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FC13A07FD
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1596114A619;
	Wed, 22 Jan 2025 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qrbU+zWG"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982A249F9;
	Wed, 22 Jan 2025 02:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513816; cv=none; b=keLcp2BiQKFD213OEG5bp1t2PMAEBdfmtzqkOuEnbOqUKeKyRN8vGATsSH9NEpjlJdyerwwSH/u9uvOFJB4kcFEnKt1oNUuJwnqSEJx2gFQjn3rGQJIdWOQ37CTxYEUxw43i3hGeky0YDRqved2ep46OBNRBZXUO0ppXWQ9+SMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513816; c=relaxed/simple;
	bh=Pawcx0vZWzoopIr28M39WQOkeACCe/QrUbhq4P9QjiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnzCEd0lxtxAlj5tZpA9KonpzDQpveibp1ucpA7rtJN0ZEo8pltpP9j+JjwBpdQBEGXAqsMGeP5OyvXEnQnTZi1jO3Ho2gv72eSCtazJ8q9uDzLwQZGFE3xoMIQEllKO3eN/+pTbcIxjDvRAgiaq0muLLvQASwMYk/xhrkmHGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qrbU+zWG; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737513810; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=lIgQW60MhRib77iPDue7FbAXzBMeV+tiKHMcuW5lSNc=;
	b=qrbU+zWGtadA/blmCuSNX9ifiPpM1ow1Rl4d3LjtR2AQzkivC6NRZXp7LXEblYmNw9hr3rqJkq5LqxnCdpQ0CXTN1fi9yC3qCbnwu69qGFbNI38TEONjfnYrUohK7r4njvDigmBU7OAxwDAsRqJAI7tScDLQQ0h1rbgV/nG7raY=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WO6rCK3_1737513807 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 10:43:28 +0800
Date: Wed, 22 Jan 2025 10:43:27 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 4/5] libbpf: fix error when st-prefix_ops and
 ops from differ btf
Message-ID: <20250122024327.GA81479@j66a10360.sqa.eu95>
References: <20250116074442.79304-1-alibuda@linux.alibaba.com>
 <20250116074442.79304-5-alibuda@linux.alibaba.com>
 <CAEf4BzZvxqiQ2J1XQMm-ZDBjSsmtJJk6-_RbexPk9vWxAO=ksw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZvxqiQ2J1XQMm-ZDBjSsmtJJk6-_RbexPk9vWxAO=ksw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jan 17, 2025 at 10:36:50AM -0800, Andrii Nakryiko wrote:
> On Wed, Jan 15, 2025 at 11:45 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
> >
> > When a struct_ops named xxx_ops was registered by a module, and
> > it will be used in both built-in modules and the module itself,
> > so that the btf_type of xxx_ops will be present in btf_vmlinux
> > instead of in btf_mod, which means that the btf_type of
> > bpf_struct_ops_xxx_ops and xxx_ops will not be in the same btf.
> >
> > Here are four possible case:
> >
> > +--------+---------------+-------------+---------------------------------+
> > |        | st_ops_xxx_ops| xxx_ops     |                                 |
> > +--------+---------------+-------------+---------------------------------+
> > | case 0 | btf_vmlinux   | bft_vmlinux | be used and reg only in vmlinux |
> > +--------+---------------+-------------+---------------------------------+
> > | case 1 | btf_vmlinux   | bpf_mod     | INVALID                         |
> > +--------+---------------+-------------+---------------------------------+
> > | case 2 | btf_mod       | btf_vmlinux | reg in mod but be used both in  |
> > |        |               |             | vmlinux and mod.                |
> > +--------+---------------+-------------+---------------------------------+
> > | case 3 | btf_mod       | btf_mod     | be used and reg only in mod     |
> > +--------+---------------+-------------+---------------------------------+
> >
> > At present, cases 0, 1, and 3 can be correctly identified, because
> > +       if (ret < 0 || ret >= sizeof(stname))
> > +               return -ENAMETOOLONG;
> 
> see preexisting snprintf() above, we don't really handle truncation
> errors explicitly, they are extremely unlikely and not expected at
> all, and worst case nothing will be found and user will get some
> -ENOENT or something like that eventually. I'd drop this extra error
> checking and keep it streamlines, similar to tname
> 

Sounds reasonable to me. I will remove the explicit error checks in the
next version.

> > +
> > +       /* Look for the corresponding "map_value" type that will be used
> > +        * in map_update(BPF_MAP_TYPE_STRUCT_OPS) first, figure out the btf
> > +        * and the mod_btf.
> > +        * For example, find "struct bpf_struct_ops_tcp_congestion_ops".
> > +        */
> > +       kern_vtype_id = find_ksym_btf_id(obj, stname, BTF_KIND_STRUCT,
> >                                         &btf, mod_btf);
> 
> nit: if this fits under 100 characters, keep it single line
> 
> > +       if (kern_vtype_id < 0) {
> > +               pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
> > +                               stname);
> 
> same nit about preserving single-line statements as much as possible,
> they are much easier to read

None of them exceed 100 lines. Usually, I would check patches with 85 lines limitations,
but since 100 lines is acceptable, we can modify it to a single line here for
better readability.

And thanks very much for your suggestion, I plan to fix these style
issues in next versions with you ack, is this okay for you?

Best wishes,
D. Wythe
> 
> > +               return kern_vtype_id;
> > +       }
> > +       kern_vtype = btf__type_by_id(btf, kern_vtype_id);
> > +
> > +       kern_type_id = btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT);
> >         if (kern_type_id < 0) {
> >                 pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
> >                         tname);
> > @@ -1020,20 +1039,6 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
> >         }
> >         kern_type = btf__type_by_id(btf, kern_type_id);
> >
> > -       /* Find the corresponding "map_value" type that will be used
> > -        * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
> > -        * find "struct bpf_struct_ops_tcp_congestion_ops" from the
> > -        * btf_vmlinux.
> > -        */
> > -       kern_vtype_id = find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_PREFIX,
> > -                                               tname, BTF_KIND_STRUCT);
> > -       if (kern_vtype_id < 0) {
> > -               pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
> > -                       STRUCT_OPS_VALUE_PREFIX, tname);
> > -               return kern_vtype_id;
> > -       }
> > -       kern_vtype = btf__type_by_id(btf, kern_vtype_id);
> > -
> >         /* Find "struct tcp_congestion_ops" from
> >          * struct bpf_struct_ops_tcp_congestion_ops {
> >          *      [ ... ]
> > @@ -1046,8 +1051,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
> >                         break;
> >         }
> >         if (i == btf_vlen(kern_vtype)) {
> > -               pr_warn("struct_ops init_kern: struct %s data is not found in struct %s%s\n",
> > -                       tname, STRUCT_OPS_VALUE_PREFIX, tname);
> > +               pr_warn("struct_ops init_kern: struct %s data is not found in struct %s\n",
> > +                       tname, stname);
> >                 return -EINVAL;
> >         }
> >
> > --
> > 2.45.0
> >

