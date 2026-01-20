Return-Path: <bpf+bounces-79578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E39F8D3C379
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4235389F58
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BEA3D1CA1;
	Tue, 20 Jan 2026 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVTzm2+k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6CA3491E1
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900806; cv=none; b=jtgjfZDhzs+52G3plI1zGKsbLzktJRB526TgaEV5t9zsIhsfBcClJ0yj6BjZlecBpskf7ubn0syAk938RrJTvg5li/lf4w2cwLg2DFG5r1XJOyiR5nHuMNBr6gVmN8r4UdBw9HY7zZc2xlHtEO7JBitPoWVVOwwcVOwVqOLdd3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900806; c=relaxed/simple;
	bh=56GsMb+Ibi7+YdFIUTfgVr9zc7Yy/1sXtC79LXaqEZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFFbtoNHHR8s1c57Sph3s14RJRYyN03sSmQDbDE+0ub6KAR5N6Z6SUAZgZateBhEiGglnSp5RM3QsnA6uHPebfNzQrrT5Gr6aFSP+Tboh+R84XmSQKLechw7qXxzhUxAz5A14GQSadAYL7egUcWa4q+ru9EjNaicSVl5DT5A7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JVTzm2+k; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6580dbdb41eso18467a12.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768900803; x=1769505603; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JHbdXgTfevCMprVxXelMqCK/NWfMzYgV0pdpQ4/IKJY=;
        b=JVTzm2+k9njNPK/LE9kGyHD52XbqhSbtXbELv72FIlzohT33H1BfGRvN4HKxyPCRlA
         nr0gQFqO3JSYaTQ4px6cqCNfO3/O6Diwu7sRg9Tvk/dbvEeaHFIXCo9/ShO9H+bJSLjB
         UKHmmXv6hAb/U0aKlgcqKbmxdT4LETqoyDsy9KERVd3k8AcGa++fAL7GLDHimQ63E/jx
         dJMSCTHu4gv3MoJAZ6FBmBYrQlZNlZrwGmoBFccksWN+YVLULOeTXubKWrjPJ+PkDcO/
         yY+1KRXi+kd9Pu26vk8UjcYSurgCF8mCyaIMUpDXLljJf5rbGNfM4exSvYae7V441eeS
         GuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900803; x=1769505603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHbdXgTfevCMprVxXelMqCK/NWfMzYgV0pdpQ4/IKJY=;
        b=eo8S8igo/9hRxLuwfxc0vf6tvisjxrYaFaTCoL/h0cTvRou5SMLCVjLG4v/x0F1UM9
         7O4qXCOFMri+3+T8wUw62Nlv8/52wiKBHtz+nqeKxTdVznh28kzwZucT4Gh8Nv5Y8bhP
         5nzWRtlWzddE4L9hb06BtkfrY5cq3ypzT3UVrudRrSFxVdbIFK/s9cJaSKQIZ7Jh4qci
         1g2HFy1ME95hPQAWHeQ3Hfko39wdVb/LsFbuyFYQlu56FEvpagelEU6MNjJNH/82O6Bb
         +Nyup9HqB7gqG37zHUSLpb67Llc3mpx7Isg5dCFVT5HdcwQ9EhC1v3T+j+CMyNz0xHsz
         BW/A==
X-Forwarded-Encrypted: i=1; AJvYcCVyrBlv8dtkqLbr9aPxT13AhVi/n0JTQJAbPPoLPrniOsgSPOVD3fnfRXGh5e9E1OS2K5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7cvvQEsb+GFE9hhwaYgXhxBDuwV8bpLOeanTt77SwBbh1MGXa
	BXGdMw5YKQxpWH+tngN4PNeRnOkIPcWPCNnm/neJwzjPpn5i27YrB9tjqHTbyWue4w==
X-Gm-Gg: AZuq6aIFyVfAGd2MpBzMzZ/fSRXl3d81y9QIQiDFcBehVMZtec7jLVqF6XHWvRuuSHM
	DeMAjkoxmJb34p+qeOxw1JrSYWn6uvXyItVdknuN9CZ2xTIudf8GI+wpgcjO1Ua3Jrf3o5OPJcn
	L5fdFFfgOlRnYjwccxllLEhWwES/TtWHmaH1SXug1+3QG5jk17BnwybSNhw4VtLe2zW30zSVoqO
	9kbeexvFTNuF2XQs8gX+IfdGcP140hx/rJB92RjtTUiEiCpzfDnbxvfeq20GxDBnaSrWvjzDeuS
	XABXMt2BG/SqiI/AyYRH1qn5etcprviGkO23F1x6+y+jpxDffWfLpbtu0K479QeSXgcBZ5LUswt
	FqHB381qccN5QYiwCsGVjnVtR70nbNyrEZtDlSFkiwwgLuEhOFcXA8K6I8jkKnS9NftP46HbJSj
	ECY+Ax+8jLdnNTBA10OmOR1p7BirfYwrCQ0hOQWdTda+5E5yyy2nzR9A==
X-Received: by 2002:a05:6402:f15:b0:655:c2f7:9f32 with SMTP id 4fb4d7f45d1cf-657ff23c047mr846109a12.0.1768900802590;
        Tue, 20 Jan 2026 01:20:02 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654533cc5d6sm12635650a12.22.2026.01.20.01.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:20:02 -0800 (PST)
Date: Tue, 20 Jan 2026 09:19:58 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: Subject: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF
 kfunc bpf_get_root_mem_cgroup()
Message-ID: <aW9IvpfIHFW97Jnt@google.com>
References: <20260113083949.2502978-2-mattbobrowski@google.com>
 <87y0lyxilp.fsf@linux.dev>
 <aWnu-b0dlm0xZFDS@google.com>
 <CAADnVQKd-yu=bZjx+3=QKLq+26wcGJtJSrZoQh8b8ByKSPEXcQ@mail.gmail.com>
 <CAADnVQ+45MorO=pODKOEVXhpY1skVy1tPkkABPAxDJGx4vOijg@mail.gmail.com>
 <878qdx6yut.fsf@linux.dev>
 <CAADnVQ+iKDvHxg_bEd6Knp3dNb9cr+FiemFSCR=NBnyt1UdYig@mail.gmail.com>
 <aW8mH-hnVupxQAZo@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aW8mH-hnVupxQAZo@google.com>

On Tue, Jan 20, 2026 at 06:52:15AM +0000, Matt Bobrowski wrote:
> On Mon, Jan 19, 2026 at 05:29:52PM -0800, Alexei Starovoitov wrote:
> > On Fri, Jan 16, 2026 at 1:18 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >
> > >
> > > E.g. in my bpfoom case:
> > >
> > > SEC("struct_ops.s/handle_out_of_memory")
> > > int BPF_PROG(test_out_of_memory, struct oom_control *oc, struct bpf_struct_ops_link *link)
> > > {
> > >         struct task_struct *task;
> > >         struct mem_cgroup *root_memcg = oc->memcg;
> > 
> > And you'll annotate oom_control->memcg with BTF_TYPE_SAFE_TRUSTED_OR_NULL ?
> > 
> > >         struct mem_cgroup *memcg, *victim = NULL;
> > >         struct cgroup_subsys_state *css_pos, *css;
> > >         unsigned long usage, max_usage = 0;
> > >         unsigned long pagecache = 0;
> > >         int ret = 0;
> > >
> > >         if (root_memcg)
> > >                 root_memcg = bpf_get_mem_cgroup(&root_memcg->css);
> > 
> > similar for mem_cgroup and css types ?
> > or as BTF_TYPE_SAFE_RCU_OR_NULL ?
> > 
> > >         else
> > >                 root_memcg = bpf_get_root_mem_cgroup();
> > >
> > >         if (!root_memcg)
> > >                 return 0;
> > >
> > >         css = &root_memcg->css;
> > >         if (css && css->cgroup == link->cgroup)
> > >                 goto exit;
> > >
> > >         bpf_rcu_read_lock();
> > 
> > then this is a bug ? and rcu_read_lock needs to move up?
> > 
> > >         bpf_for_each(css, css_pos, &root_memcg->css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
> > >                 if (css_pos->cgroup->nr_descendants + css_pos->cgroup->nr_dying_descendants)
> > >                         continue;
> > >
> > >                 memcg = bpf_get_mem_cgroup(css_pos);
> > >                 if (!memcg)
> > >                         continue;
> > >
> > >                 < ... >
> > >
> > >                 bpf_put_mem_cgroup(memcg);
> > >         }
> > >         bpf_rcu_read_unlock();
> > >
> > >         < ... >
> > >
> > >         bpf_put_mem_cgroup(victim);
> > > exit:
> > >         bpf_put_mem_cgroup(root_memcg);
> > 
> > Fair enough.
> > Looks like quite a few pieces are still missing for this to work end-to-end,
> > but, sure, let's revert back to acquire semantics.
> > 
> > Matt,
> > please come with a way to fix a selftest. Introduce test kfunc or something.
> 
> Already on it.

Here is the updated selftest which relies on new test specific BPF
kfuncs defined within bpf_testmod instead:

- https://lore.kernel.org/bpf/20260120091630.3420452-1-mattbobrowski@google.com/T/#u

