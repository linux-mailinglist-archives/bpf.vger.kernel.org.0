Return-Path: <bpf+bounces-47012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1FC9F286D
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 03:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1A016441C
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 02:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C4124B34;
	Mon, 16 Dec 2024 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vnrsu+zy"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249938BE8;
	Mon, 16 Dec 2024 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734315265; cv=none; b=T1u5I5E25hyxpc9ZG0Xhg0jnIqwtGJye5M4Telhbciyu0q6lmc0FsmEeJeTuFru+yWs2Ug6pebX/Dvfe8O4XmaGxFtZBFAajJUrp8JqOqt1qDX0zA4mrbQDDe+cWFO/y0fqLKPYNVV2F51LwsSX2b9DJe2ytFiKxLP2cJWkPMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734315265; c=relaxed/simple;
	bh=6V+shrdB2vbTHb6R82jUo0/uUAiL8Fi82YYWHfrXz9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmm+Za2VYwRVh8P5k5xugzwHFHx46Dh05p5/+NpQ7zhnQkxGWLhZKRwKRf2GBKsjjjFDZpiD41Hm8Z400RleCR6lmOekoyXb2gFeASoRQ4Fn1BirioR62n1IxnUUBjqLNPhZ7M86OEBkL86SuuC9AlADWaPaRtmPK2W0dx8+scQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vnrsu+zy; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734315253; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=aqauEWhdS3VAOAkJnsfZji7HEujR8JydSb0C6qnhp9I=;
	b=vnrsu+zyYs/gTZemDtQT7ksKcC2uy6bmJYQwjFJv3XLYrcyeDEJdMBISUifFopivpidxWvTKLFcBELfdfhDT9m8yGVmTQ6u9Yr295WBs2qhyGHdhLpfWFw7APEqPONsRocTmWmQgbiuKMH24L4YQwbOw9N6y/3C2r12K0zI+P2I=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLVDXsW_1734315250 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Dec 2024 10:14:11 +0800
Date: Mon, 16 Dec 2024 10:14:10 +0800
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
Subject: Re: [PATCH bpf-next v2 4/5] libbpf: fix error when st-prefix_ops and
 ops from differ btf
Message-ID: <20241216021410.GA129445@j66a10360.sqa.eu95>
References: <20241210040404.10606-1-alibuda@linux.alibaba.com>
 <20241210040404.10606-5-alibuda@linux.alibaba.com>
 <CAEf4BzYMWTTnniPN-2cmjkPOefDFOLgbdo0cHzmMNJiFPL8riQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYMWTTnniPN-2cmjkPOefDFOLgbdo0cHzmMNJiFPL8riQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Dec 12, 2024 at 02:24:46PM -0800, Andrii Nakryiko wrote:
> On Mon, Dec 9, 2024 at 8:04 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
> >
> > When a struct_ops named xxx_ops was registered by a module, and
> > it will be used in both built-in modules and the module itself,
> > so that the btf_type of xxx_ops will be present in btf_vmlinux
> 
> instead of using find_btf_by_prefix_kind, let's have:
> 
> 1) snprintf(STRUCT_OPS_VALUE_PREFIX, tname) right here in this
> function, so we have expected type constructed and ready to be used
> and reused, if necessary
> 2) call btf__find_by_name_kind() instead of find_btf_by_prefix_kind()
> 3) if (kern_vtype_id < 0 && !*mod_btf)
>       kern_vtype_id = find_ksym_btf_id(...)
> 4) if (kern_vtype_id < 0) /* now emit error and error out */

Got it. This looks more concise, I will modify it in the next version in
this way.

Thanks,
D. Wythe

> 
> >         if (kern_vtype_id < 0) {
> > -               pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
> > -                       STRUCT_OPS_VALUE_PREFIX, tname);
> > -               return kern_vtype_id;
> > +               if (kern_vtype_id == -ENOENT && !*mod_btf)
> > +                       kern_vtype_id =
> > +                               find_ksym_btf_id_by_prefix_kind(obj, STRUCT_OPS_VALUE_PREFIX,
> > +                                                               tname, BTF_KIND_STRUCT, &btf,
> > +                                                               mod_btf);
> > +               if (kern_vtype_id < 0) {
> > +                       pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
> > +                               STRUCT_OPS_VALUE_PREFIX, tname);
> > +                       return kern_vtype_id;
> > +               }
> >         }
> >         kern_vtype = btf__type_by_id(btf, kern_vtype_id);
> >
> > --
> > 2.45.0
> >

