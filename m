Return-Path: <bpf+bounces-69517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFF0B98C09
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E09170970
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE99280337;
	Wed, 24 Sep 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YH08kiEx"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590927FD5B;
	Wed, 24 Sep 2025 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701210; cv=none; b=SyLquH/yDM1Sbo0XjusXLYz7P4HqoFBx7r6wWG3RgPmjTH9yqfe+1rYszi+vurMdoe6wJZhlHgNY7qXXNn8sZqTn91y9Nx4sE5HLNJyqcFviCagWpuQmBPLp1OQQFd2FfBZd0Qxe0NLeIZfVtq++jw4wyPABsAMsdcqPKB/npF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701210; c=relaxed/simple;
	bh=H/RPSRIS2pXMPC0QX/aRKVscJvo8tGebWfKFXemlOOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VReqNtbBdFXFUMsHZ7//qIeOYF/W3ptiCrQ929oGyiCSY/xklLpl4IhXeJMqpC5WGlW53ErNPEc8fomxEKDZSkLwWMEwbRfR1BTS+F0v/OiaxcSi4A6PkoEab71nE/7sF8EhOvhOYKe0N4lrmvvJIUE1qmDGJ9HxyC3DpHL2g0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YH08kiEx; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758701197; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=q1x64oh/qPGwdW6iIcy3YPHHo7RlB+5bYntONl4N+94=;
	b=YH08kiEx/CG2/O9E/ovM3R0KAoISxeVvOFybEIeguCRhOQsvd3XZLixnvTH/mOKLx9IQJGRYaBs3lO58C0lqXId3n83mEOfnKuJKK2P60vfLA58ADrmLVEr+isc3RNINKcHA63gzenAIu+PwpOIA+d1iJTeGmDiUfH/YSMgtxtk=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WoirHCa_1758701194 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Sep 2025 16:06:35 +0800
Date: Wed, 24 Sep 2025 16:06:34 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, bpf@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next v2 3/4] libbpf: fix error when st-prefix_ops and
 ops from differ btf
Message-ID: <20250924080634.GA14633@j66a10360.sqa.eu95>
References: <20250918080342.25041-1-alibuda@linux.alibaba.com>
 <20250918080342.25041-4-alibuda@linux.alibaba.com>
 <CAEf4BzY5oowUpq2x3Uz+TNi=8GJgc1FDzS-u5UqZwNXvkWtSEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY5oowUpq2x3Uz+TNi=8GJgc1FDzS-u5UqZwNXvkWtSEw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Sep 19, 2025 at 03:22:41PM -0700, Andrii Nakryiko wrote:
> On Thu, Sep 18, 2025 at 1:03 AM D. Wythe <alibuda@linux.alibaba.com> wrote:
> >
> >
> > At present, cases 0, 1, and 3 can be correctly identified, because
> > st_ops_xxx_ops is searched from the same btf with xxx_ops. In order to
> > handle case 2 correctly without affecting other cases, we cannot simply
> > change the search method for st_ops_xxx_ops from find_btf_by_prefix_kind()
> > to find_ksym_btf_id(), because in this way, case 1 will not be
> > recognized anymore.
> >
> > To address the issue, we always look for st_ops_xxx_ops first,
> > figure out the btf, and then look for xxx_ops with the very btf to avoid
> 
> What's "very btf"? Commit message would benefit from a little bit of
> proof-reading, if you can. It's a bit hard to follow, even if it's
> more or less clear at the end what problem you are trying to solve.
> 
> Also, I'd suggest to send this fix as a separate patch and not block
> it on the overall patch set, which probably will take longer. This fix
> is independent, so we can land it much faster.
> 

Thanks a lot for your suggestion. I'll improve the commit message.

It's fine to send this patch separately, I'm concerned it won't be
verifiable in isolation without the other patches. But if you feel
it's okay to proceed, I'm happy to do so.

> > such issue.
> >
> > Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
> > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++-------------------
> >  1 file changed, 18 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index fe4fc5438678..50ca13833511 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -1013,35 +1013,34 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
> >         const struct btf_member *kern_data_member;
> >         struct btf *btf = NULL;
> >         __s32 kern_vtype_id, kern_type_id;
> > -       char tname[256];
> > +       char tname[256], stname[256];
> >         __u32 i;
> >
> >         snprintf(tname, sizeof(tname), "%.*s",
> >                  (int)bpf_core_essential_name_len(tname_raw), tname_raw);
> >
> > -       kern_type_id = find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
> > -                                       &btf, mod_btf);
> > -       if (kern_type_id < 0) {
> > -               pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
> > -                       tname);
> > -               return kern_type_id;
> > -       }
> > -       kern_type = btf__type_by_id(btf, kern_type_id);
> > +       snprintf(stname, sizeof(stname), "%s%.*s", STRUCT_OPS_VALUE_PREFIX,
> > +                (int)strlen(tname), tname);
> >
> > -       /* Find the corresponding "map_value" type that will be used
> > -        * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
> > -        * find "struct bpf_struct_ops_tcp_congestion_ops" from the
> > -        * btf_vmlinux.
> > +       /* Look for the corresponding "map_value" type that will be used
> > +        * in map_update(BPF_MAP_TYPE_STRUCT_OPS) first, figure out the btf
> > +        * and the mod_btf.
> > +        * For example, find "struct bpf_struct_ops_tcp_congestion_ops".
> >          */
> > -       kern_vtype_id = find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_PREFIX,
> > -                                               tname, BTF_KIND_STRUCT);
> > +       kern_vtype_id = find_ksym_btf_id(obj, stname, BTF_KIND_STRUCT, &btf, mod_btf);
> >         if (kern_vtype_id < 0) {
> > -               pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
> > -                       STRUCT_OPS_VALUE_PREFIX, tname);
> > +               pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n", stname);
> >                 return kern_vtype_id;
> >         }
> >         kern_vtype = btf__type_by_id(btf, kern_vtype_id);
> >
> > +       kern_type_id = btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT);
> > +       if (kern_type_id < 0) {
> > +               pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n", tname);
> > +               return kern_type_id;
> > +       }
> > +       kern_type = btf__type_by_id(btf, kern_type_id);
> > +
> >         /* Find "struct tcp_congestion_ops" from
> >          * struct bpf_struct_ops_tcp_congestion_ops {
> >          *      [ ... ]
> > @@ -1054,8 +1053,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
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

