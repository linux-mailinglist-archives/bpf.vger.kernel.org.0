Return-Path: <bpf+bounces-56005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEE3A8A7B5
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 21:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B044917EBC1
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1778245011;
	Tue, 15 Apr 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU8EVCTi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D3241114
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744924; cv=none; b=uKIaIiBv+cpoKnvUC5f3USDfUqOoUrrXrIznE9rcMAY1T29kLJxtQqStzXr8/svgSpOxJpuwOnhru51NenRkLNkZZAFMZglkOJBMOxQoPlxgqcuXd9valCBgDsOtzvdaf4qufvBcKBS+BcJuu8GkrRUji5YaED1TZ7Zs11BbapE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744924; c=relaxed/simple;
	bh=ZLAyU8C5jsD13C3vXyLqmQqFV6XgVpZaPGUBl/1/yXk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBuYq5zGSLuw0aCZ3ZZ+hRo8Ox2ziAId/hvEUKH+XSh9dSUmg9v/EiOG8tbdamdjRLKyzj0C564aE04atN68RSwB3NuQiYzVbXX4AZ+hY2C7AI6JgD0Lt9AZj2np5AQBVLLuW3/9dg9qelXAjzSFVzQNvKISVx9Pfi3lNwkyxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU8EVCTi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso9832577a12.0
        for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 12:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744744920; x=1745349720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+rDtZgiUMWn4aeEaqvGXFytuWiqi0ud/lToHgKlVdw=;
        b=kU8EVCTiA3gsgN6VgfTz07kNi5AZrBQAXK/CM2O3xMMlOH/aAv04otGVgCtCclSPuO
         K5GGP48DbidUE8OZM1QQg2IGcDy39EkRVb3f5xcKUcUzp/Uzl6/XuJ2+OT1CRyLsBH0d
         nMwRu3ir+ppShuA/Hr8Zs3E9WXUydee2AHp5IQpGfVZnYgm9KTFQTngNVGmFi6MLlTFV
         FaF+dhqsamS1YlmtpVK7raSNqW4pHYGqqxCVGXcq8vhVqRV8BuqczZYMqB8nIbtOnlNa
         Z7u6NOaLLJXSzGBNFcyPMbeVZ/dT+O+KzlCl5vEOWqNCplDRUHjpxobnqnP/xyZfyg0b
         lflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744744920; x=1745349720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+rDtZgiUMWn4aeEaqvGXFytuWiqi0ud/lToHgKlVdw=;
        b=e89Y4CXNepAYI9V0uG4DtBvM5ivp0PMMZNJ5GNvRvHUfz3OAUqXxIhwz746wqbNMYw
         lzim155GwVThcFx5L/tLpdYNwN6qwpp73RZDgdkpbsCssJatx5+/nM9JRl/jfZ+fJa7S
         BfyrjXjvHlZs4UWLcxBwjMbBNQO2oiUSp5XE9Q5hmzQ0Yrfup3DcZFayYJ7keIPA9gIs
         D2cKUMSBukXKOjmfgK65akXCnWuWjE8AVPj4yeuHRPP2x2H+Ba08T2fStzxoGP5gduMM
         XbqYrP6rN0Bd2F2tDDhG8dRVKrDdXl8TAqibE7rMmBJb3x5F//czS7I6NEYO8pIRaT+T
         JnzA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/oEE6eFufjKbutAbEnydJtQUQcHIRcwvfldQARJPUrUQUGh50+R9pv/l/N5SjqBTsso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmC5SEnudGv460s59lpJ8q01jYxNl01YlHYRXSI7kLz3Sm/l6h
	bjvJYw/M00EOfEG9QYahuzC6wsAHXtv7INdcyQF0+DiMV30wpNlsmz4veQ==
X-Gm-Gg: ASbGncvhLKYnF7DgSc+P1FkNy8hLrtXAxK3w+ssMtAQs/2TjOLLGTWjWVi9yo1x72tk
	TPEJbvyVZ5LryIlbuBrp1mDzH1cMVTuaUG0L6esy1ZM0FtuqEvnizfGpIz6Z+JNg0WulbuFetP6
	cl/O38O3wUk+KuD6CmALwwn8qpKb7B0gm9tDvNzV1VmyjNKMK1704YgRlvx+C+37COCB+wOOd88
	VvgrLezwPd0I7TMvHJUQN9kWa+ORfboziQC4Jmx3Gi0ShC0v4fi/iVF+gqWSaDH07CjDy4G845e
	IqsnnMQv5atpLRBNWrz3yu8EaTVMVmCQ1iFnmfmPJohZajY=
X-Google-Smtp-Source: AGHT+IGWdtber6RZPCMJjoks75r+BW8iUWsu5utNW1Q7OtOXWlV4RrMVBHRJaBWEusWI+bvEIJboug==
X-Received: by 2002:a17:906:6a22:b0:ac3:8993:3c6d with SMTP id a640c23a62f3a-acb382f4d13mr20552566b.26.1744744919566;
        Tue, 15 Apr 2025 12:21:59 -0700 (PDT)
Received: from krava (85-193-35-57.rib.o2.cz. [85.193.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1c0232dsm1133890566b.83.2025.04.15.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:21:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 15 Apr 2025 21:21:56 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: Question: fentry on kernel func optimized by compiler
Message-ID: <Z_6x1CH38clO_OTV@krava>
References: <7e46c811-e85b-4001-8fac-b16aa0e9815f@linux.dev>
 <CAEf4BzaEg1mPag0-bAPVeJhj-BL_ssABBAOc_AhFvOLi2GkrEg@mail.gmail.com>
 <3c6f539b-b498-4587-b0dc-5fdeba717600@oracle.com>
 <ee8a41c8-9500-4ff9-bffb-e6c764da6e3e@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee8a41c8-9500-4ff9-bffb-e6c764da6e3e@linux.dev>

On Tue, Apr 15, 2025 at 08:10:09PM +0800, Tao Chen wrote:
> 在 2025/3/31 18:13, Alan Maguire 写道:
> > On 28/03/2025 17:21, Andrii Nakryiko wrote:
> > > On Thu, Mar 27, 2025 at 9:03 AM Tao Chen <chen.dylane@linux.dev> wrote:
> > > > 
> > > > Hi,

hi, sorry for late reply

> > > > 
> > > > I recently encountered a problem when using fentry to trace kernel
> > > > functions optimized by compiler, the specific situation is as follows:
> > > > https://github.com/bpftrace/bpftrace/issues/3940
> > > > 
> > > > Simply put, some functions have been optimized by the compiler. The
> > > > original function names are found through BTF, but the optimized
> > > > functions are the ones that exist in kallsyms_lookup_name. Therefore,
> > > > the two do not match.

hum, would you have example BTF/kernel/config with such case? I'd think
if function is in BTF you should find it through kallsyms, the other way
around is not garanteed

> > > > 
> > > >           func_proto = btf_type_by_id(desc_btf, func->type);
> > > >           if (!func_proto || !btf_type_is_func_proto(func_proto)) {
> > > >                   verbose(env, "kernel function btf_id %u does not have a
> > > > valid func_proto\n",
> > > >                           func_id);
> > > >                   return -EINVAL;
> > > >           }
> > > > 
> > > >           func_name = btf_name_by_offset(desc_btf, func->name_off);
> > > >           addr = kallsyms_lookup_name(func_name);
> > > >           if (!addr) {
> > > >                   verbose(env, "cannot find address for kernel function
> > > > %s\n",
> > > >                           func_name);
> > > >                   return -EINVAL;
> > > >           }
> > > > 
> > > > I have made a simple statistics and there are approximately more than
> > > > 2,000 functions in Ubuntu 24.04.
> > > > 
> > > > dylane@2404:~$ cat /proc/kallsyms | grep isra | wc -l
> > > > 2324
> > > > 
> > > > So can we add a judgment from libbpf. If it is an optimized function,
> > > 
> > > No, we cannot. It's a different function at that point and libbpf
> > > isn't going to be in the business of guessing on behalf of the user
> > > whether it's ok to do or not.
> > > 
> > > But the user can use multi-kprobe with `prefix*` naming, if they
> > > encountered (or are anticipating) this situation and think it's fine
> > > for them.
> > > 
> > > As for fentry/fexit, you need to have the correct BTF ID associated
> > > with that function anyways, so I'm not sure that currently you can
> > > attach fentry/fexit to such compiler-optimized functions at all
> > > (pahole won't produce BTF for such functions, right?).
> > > 
> > 
> > Yep, BTF will not be there for all cases, but ever since we've had the
> > "optimized_func" BTF feature, we've have encoded BTF for suffixed
> > functions as long as their parameters are not optimized away and as long
> > as we don't have multiple inconsistent representations associated with a
> > function (say two differing function signatures for the same name).
> > Optimization away of parameters happens quite frequently, but not always
> > for .isra.0 functions so they are potentially sometimes safe for fentry.
> > 
> > The complication here is that - by design - the function name in BTF
> > will be the prefix; i.e. "foo" not "foo.isra.0". So how we match up the
> > BTF with the right suffixed function is an issue; a single function
> > prefix can have ".isra.0" and ".cold.0" suffixes associated for example.
> > The latter isn't really a function entry point (in the C code at least);
> > it's just a split of the function into common path and less common path
> > for better code locality for the more commonly-executed code.
> > 
> > Yonghong and I talked about this a bit last year in Plumbers, but it did
> > occur to me that there are conditions where we could match up the prefix
> > from BTF with a guaranteed fentry point for the function using info we
> > have today.
> > 
> > /sys/kernel/tracing/available_filter_functions_addr has similar info to
> > /proc/kallysyms but as far as I understand it we are also guaranteed
> > that the associated addresses correspond to real function entry points.

available_filter_functions_addr contains exactly the same functions as
available_filter_functions (all functions managed by ftrace), it just
adds address value for each function as a hint to user space

it's used in kprobe_multi bench test to get all traceable addresses,
and passed to kprobe_multi link, which uses following fprobe interface
to attach:

        err = register_fprobe_ips(&link->fp, addrs, cnt);

> > So because the BTF representation currently ensures consistency _and_
> > available function parameters, I think we could use
> > available_filter_functions_addr to carry out the match and provide the
> > right function address for the BTF representation.

where would you do the match to available_filter_functions_addr?

also not sure how it's connected to the original issue, that seems
to be related to pahole eliminating unsafe functions in BTF?

jirka


> > 
> 
> Hi, Alan
> Sorry for not replying in time. As you said，it seems much simpler when use
> the func addr from available_filter_functions_addr. It seems to be a bit
> similar to the way of passing function addresses in kprobe_multi. @Andrii
> @Jiri what do you think?
> 
> > In the future, the hope is we can handle inconsistent representations
> > too in BTF, but the above represents a possible approach we could
> > implement today I think, though I may be missing something. Thanks!
> > 
> > Alan
> 
> 
> -- 
> Best Regards
> Tao Chen
> 

