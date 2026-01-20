Return-Path: <bpf+bounces-79557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 659AAD3BFF2
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82955502362
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 06:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C140838B7CB;
	Tue, 20 Jan 2026 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxYrX9BF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054BB37FF45
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891949; cv=none; b=doQSgVUbSqPwRSsnyzH6azbL1lVxowO6VwI5UYZyrHNC8k2EKcxyaCxrnx5l3S6gfQoguUT99WCVL5lEXXIqJIr6fjAPGZ4EY4xpBOXXWT6cfTU4zdFK1fOijzpxKVTCJLjxGHx8fHsJJOwdswroONhoG52J7AkOyYviO1UKznw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891949; c=relaxed/simple;
	bh=TKcR+Zd+Rmm3oAadOVqdC9xUa7HxHVOcgG6zpR31Tjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+QzGS0dieWDu08J3F/kxg3yEuTj4KSFiAGVFNKMg9fatWpK9FSW9oyaksh7y6FAzrwX3HOh5r5S7VpfIyGEl48KPHx36AO5TPb/S8PeyA+8GrE4eSd1kS4buhnCxKACWA0BytO/yYjTUlWvJI6ft951/H8c6Xqpg95eRO8+YqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxYrX9BF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b87003e998bso1026939766b.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 22:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768891940; x=1769496740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3nM1AuyOuJh/1BCnQvI4vopqVPvAItlSlPzg4qdraDk=;
        b=rxYrX9BFnq8amy79Sb4rE7VdJlf8NKvr8tTNxgeo/OgjXBpzOf654Thje5fcVC2khN
         vinYfhS4v+DzqLYsdB9p80NjIBk0cjn6C9NEU/nGKUR4VZ+sJzJXCcJmDh6eiQMQ/14s
         aA/pdu98jntmjiPnjU8LZTb0XoSmQ8Fg/rhJKYM/gdwPu8g1NwzuHMTGhfJ4b/puWiGE
         f0Olup/UX91G0dcu5hwzms+xZQy+opz4FyknD/OhDAmF0REsA+QvmjCkBKLnMhm3CAis
         iNYLl6na2ZI387sxQaGO5iHmK3dLheeIl2YcGn4sBufkyR5WD3ufhlPa+oA4JbwwgFLR
         F3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768891940; x=1769496740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nM1AuyOuJh/1BCnQvI4vopqVPvAItlSlPzg4qdraDk=;
        b=RE2CBkgDV94cIwWKR5xIjKxgpF3fcBQGL8rjtkiVdg+Wj/mBYppZsbCQL1Le4Jwgfl
         4zMIgTWS5PGCrdL3SUtX2I4LnFzsLnD1TDypyawfsWUTxUOa3tL6/jVkVtBZ4M4MJc2/
         /QwSgS2/xblJRGNfYJWAX9AfNbe21Oc9m8KBOVlLF/9dRnWxTttCqacxerh7dti5Gy4r
         eHUeMcyRxXhKmkwiiPG9Qi+lP5K8zjWugF9+63nK0o6rG3O9b2lYf3sz5ahzA20pbh4H
         guVgG+3UgxpTncelHBIXavy1mFdB8tBPX/2G5DvUhOahWhVjk1Pe2DlHuT9DW13ZJRLx
         3itQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg/qCLV2VdbGhZSPgTdqtQim45bbh5VLlW/K0OYUhqz7/Zm4fv4rjlcTvr0dXDkpKWnlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEz+HUbUtAUAY4wKrbmP2N4iy6oAi4oMrI/NHLhzqbt5baTDC
	m03VQf7MomDXKfCNEK2c83FXiN91cquBTUJjTnXpHDpj5afogoGiLG/ISPOcyhJWyA==
X-Gm-Gg: AZuq6aJLeQXduNx30e7A/TicuaRmALzf/HS8PS/YC28cRjsKeAnOQfF2vT9UGGdBvNk
	nQ2UgCXj+pKewDlWAvybZG6ek/hc1e4H6pD2U46EMKNccrOFfe9htPS7HHl3h/55vZGKBfRJ6Ek
	8U/y52OMUf1NqfX1TckyWs+146NVdhmy1tpd7JL8uGAyWSV8ZUs6WFvfZXn9KAeZ24IlGDFUpoA
	lz8ei9h8lfKA37NDYGMqImA+oY8qM1UOGYJrIvzJ8mODj5jqV/BOba/JH1wHrx6of7RbKaPLBvl
	xsR+Z3pOp7+wmOAZYcMgEwxzBSZHugbcQo4v24ExygGI3cGV3erZbXgyIVXbRHzu3exnWKdfaV+
	emxnVTnq9ec3DtZ7EFhpYRe33/6M0rAMQakkFhuqnWHK2Uk9u8PhTHJIZkXF6UeNY4NPwsN6LnM
	BLZ4nCZzElCGM1XSjgymKeut9MATXo3BwcRQAvnh4e44kmJgi3p1s8+Q==
X-Received: by 2002:a17:907:7b89:b0:b84:3fab:4251 with SMTP id a640c23a62f3a-b87939d9b4emr1604850766b.15.1768891939960;
        Mon, 19 Jan 2026 22:52:19 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87f6f69eedsm197156766b.46.2026.01.19.22.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:52:19 -0800 (PST)
Date: Tue, 20 Jan 2026 06:52:15 +0000
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
Message-ID: <aW8mH-hnVupxQAZo@google.com>
References: <20260113083949.2502978-2-mattbobrowski@google.com>
 <87y0lyxilp.fsf@linux.dev>
 <aWnu-b0dlm0xZFDS@google.com>
 <CAADnVQKd-yu=bZjx+3=QKLq+26wcGJtJSrZoQh8b8ByKSPEXcQ@mail.gmail.com>
 <CAADnVQ+45MorO=pODKOEVXhpY1skVy1tPkkABPAxDJGx4vOijg@mail.gmail.com>
 <878qdx6yut.fsf@linux.dev>
 <CAADnVQ+iKDvHxg_bEd6Knp3dNb9cr+FiemFSCR=NBnyt1UdYig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+iKDvHxg_bEd6Knp3dNb9cr+FiemFSCR=NBnyt1UdYig@mail.gmail.com>

On Mon, Jan 19, 2026 at 05:29:52PM -0800, Alexei Starovoitov wrote:
> On Fri, Jan 16, 2026 at 1:18 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> >
> > E.g. in my bpfoom case:
> >
> > SEC("struct_ops.s/handle_out_of_memory")
> > int BPF_PROG(test_out_of_memory, struct oom_control *oc, struct bpf_struct_ops_link *link)
> > {
> >         struct task_struct *task;
> >         struct mem_cgroup *root_memcg = oc->memcg;
> 
> And you'll annotate oom_control->memcg with BTF_TYPE_SAFE_TRUSTED_OR_NULL ?
> 
> >         struct mem_cgroup *memcg, *victim = NULL;
> >         struct cgroup_subsys_state *css_pos, *css;
> >         unsigned long usage, max_usage = 0;
> >         unsigned long pagecache = 0;
> >         int ret = 0;
> >
> >         if (root_memcg)
> >                 root_memcg = bpf_get_mem_cgroup(&root_memcg->css);
> 
> similar for mem_cgroup and css types ?
> or as BTF_TYPE_SAFE_RCU_OR_NULL ?
> 
> >         else
> >                 root_memcg = bpf_get_root_mem_cgroup();
> >
> >         if (!root_memcg)
> >                 return 0;
> >
> >         css = &root_memcg->css;
> >         if (css && css->cgroup == link->cgroup)
> >                 goto exit;
> >
> >         bpf_rcu_read_lock();
> 
> then this is a bug ? and rcu_read_lock needs to move up?
> 
> >         bpf_for_each(css, css_pos, &root_memcg->css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
> >                 if (css_pos->cgroup->nr_descendants + css_pos->cgroup->nr_dying_descendants)
> >                         continue;
> >
> >                 memcg = bpf_get_mem_cgroup(css_pos);
> >                 if (!memcg)
> >                         continue;
> >
> >                 < ... >
> >
> >                 bpf_put_mem_cgroup(memcg);
> >         }
> >         bpf_rcu_read_unlock();
> >
> >         < ... >
> >
> >         bpf_put_mem_cgroup(victim);
> > exit:
> >         bpf_put_mem_cgroup(root_memcg);
> 
> Fair enough.
> Looks like quite a few pieces are still missing for this to work end-to-end,
> but, sure, let's revert back to acquire semantics.
> 
> Matt,
> please come with a way to fix a selftest. Introduce test kfunc or something.

Already on it.

