Return-Path: <bpf+bounces-48741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3BBA10131
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 08:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD8318880B5
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 07:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B36F2451D5;
	Tue, 14 Jan 2025 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RCXLwQ2I"
X-Original-To: bpf@vger.kernel.org
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948E224D6;
	Tue, 14 Jan 2025 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736838734; cv=none; b=hoy/XNOVy85KWqwlKbtTLfIFpca+3oY8s7gEsBXfoHEXDMSaDTtGCR6cnrsBshCuY/OnPzbP20X61IAA0zjb/+FvA6uTNh0XOJnvMGRyIw7a/89JF5GGhlsYBZrV6ukxdlhBW80lBqBaH8ikLm7n/CZof3OPvyh8KsG4w9El1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736838734; c=relaxed/simple;
	bh=/jTiEukBk4OXr0oz4YiAlGU6iQIdT0wI4GSysHcmIvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyrEKW0l69iMz0hjJwIHzpveqP3xVXXnmJNNvgdRrQlLfK9PNpKijpTPSC9S3aoCofJPxKuVyO7Q3ZDYdkrB2ggQgZ12jhw7O0SaNs5OXTpgunhDwWAZitIQ1bjfA19QTATGVm0GW0F60/dqU78gO+8vbsGlBEt6JM/JLxzAPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RCXLwQ2I; arc=none smtp.client-ip=47.90.199.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736838711; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=g27TgMLSSWDA6rh7dbNBUqwtZ6V1tqrqcoJ1TbS5P1w=;
	b=RCXLwQ2IOdQJjr2AfLeAMRLw0f01qDq72ivynUb1Ad9i/WKHtuXlxmZ1zcsN5atUBUFf5yooDhH6wmvjXYHIieb4iL7OJlAYfcLKuFyNIviDlkouEXibyWfctVUBo4chj+suWYsd04uGNXiP5KhTaK5vRblkZUJ2JC4pQcX2pGE=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WNeEgmT_1736838709 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jan 2025 15:11:49 +0800
Date: Tue, 14 Jan 2025 15:11:49 +0800
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
Subject: Re: [PATCH bpf-next v3 4/5] libbpf: fix error when st-prefix_ops and
 ops from differ btf
Message-ID: <20250114071149.GA106114@j66a10360.sqa.eu95>
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-5-alibuda@linux.alibaba.com>
 <CAEf4Bzas7E4bSFnxiObJysf4hDv2AJVd4B4Q+me1wmGtdHVVbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzas7E4bSFnxiObJysf4hDv2AJVd4B4Q+me1wmGtdHVVbQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jan 10, 2025 at 03:38:19PM -0800, Andrii Nakryiko wrote:
> On Tue, Dec 17, 2024 at 6:44 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
> >
> > When a struct_ops named xxx_ops was registered by a module, and
> > it will be used in both built-in modules and the module itself,
> > so that the btf_type of xxx_ops will be present in btf_vmlinux
> > instead of in btf_mod, which means that the btf_type of
> > bpf_struct_ops_xxx_ops and xxx_ops will not be in the same btf.
> >
> > Here are four possible case:
> >
> > +--------+-------------+-------------+---------------------------------+
> > |        | st_opx_xxx  | xxx         |                                 |
> > +--------+-------------+-------------+---------------------------------+
> > | case 0 | btf_vmlinux | bft_vmlinux | be used and reg only in vmlinux |
> > +--------+-------------+-------------+---------------------------------+
> > | case 1 | btf_vmlinux | bpf_mod     | INVALID                         |
> > +--------+-------------+-------------+---------------------------------+
> > | case 2 | btf_mod     | btf_vmlinux | reg in mod but be used both in  |
> > |        |             |             | vmlinux and mod.                |
> > +--------+-------------+-------------+---------------------------------+
> > | case 3 | btf_mod     | btf_mod     | be used and reg only in mod     |
> > +--------+-------------+-------------+---------------------------------+
> >
> > At present, cases 0, 1, and 3 can be correctly identified, because
> > st_ops_xxx is searched from the same btf with xxx. In order to
> > handle case 2 correctly without affecting other cases, we cannot simply
> > change the search method for st_ops_xxx from find_btf_by_prefix_kind()
> > to find_ksym_btf_id(), because in this way, case 1 will not be
> > recognized anymore.
> >
> > To address this issue, if st_ops_xxx cannot be found in the btf with xxx
> > and mod_btf does not exist, do find_ksym_btf_id() again to
> > avoid such issue.
> > +               }
> 
> purely from the coding perspective, this is unnecessarily nested and
> convoluted. Wouldn't this work the same but be less nested:
> 
> kern_vtype_id = btf__find_by_name_kind(btf, stname, BTF_KIND_STRUCT);
> if (kern_vtype_id == -ENOENT && !*mod_btf)
>     kern_vtype_id = find_ksym_btf_id(...);
> if (kern_vtype_id < 0) {
>     pr_warn(...);
>     return kern_vtype_id;
> }

Hi Andrii,

It's indeed more concise with your code. Thanks very much for your suggestion.
And Martin has provided us with another suggestion to address this issue,
and according to his plan, there shall be no such complex conditional
checks too.

Anyway, I will keep my code concise in the next version. Thank you for
the reminder.

Best wishes,
D. Wythe

> 
> 
> >         }
> >         kern_vtype = btf__type_by_id(btf, kern_vtype_id);
> >
> > @@ -1046,8 +1055,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
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

