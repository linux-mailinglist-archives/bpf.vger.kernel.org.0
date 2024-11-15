Return-Path: <bpf+bounces-44935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749C59CDAD6
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 09:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB9C28350B
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1544A18C01D;
	Fri, 15 Nov 2024 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAtj3wyp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF99174EE4;
	Fri, 15 Nov 2024 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660471; cv=none; b=DpDOoA/XuRY+yhv40TjFG3Zr6EgQ34A/um6iNgibNNhnnTtXKhDc9pAoDpW4DNVZ3eOCz2bLUyN+2a/aIuu7iG+PfyjHnmqLC7JPvQtBlaDq9aVupUCs9/p3aHDDQmI1N5UHssFqmRVy/jNmepM5UvYe0NtCMadwDMGDDvTwb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660471; c=relaxed/simple;
	bh=NsNrX4IWlTNuUK4o0qtkKVxHJHNqgLwEy+EZwW5HRZI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+h93g/XB+8sdcjzvEwCMt21+P76a2VE3gXlOB0HM+lUwPYcp21K8GM9ryoBLBF8GGfVt+gEy7QySQIvMgHOCmpZkdtrrUwBDBXjxzDSq8D9y8kNGMQPRcUzeoCARehMjmea//qgvbW2ii96Qjdvyy6nDT5YXCseNaKYegEducQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAtj3wyp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382219ceaacso685011f8f.3;
        Fri, 15 Nov 2024 00:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731660468; x=1732265268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KdH68Ik+FEA9GJcvzuT+cs6b5USGy/M06gjmxC16NMA=;
        b=bAtj3wypd1zRTgvw9dYFEzlSamvZYGwgc8tnqGV/7Avg5AAGmUMpbkCfKIt5W5LNCK
         vi5+Fk1SgBilTMNRvDOEzQqkTOvJ8OVfMbiSqLcA/HzVtp0FF41OG8lw6pGoevAjgJaZ
         Vu/uIULjHn6LIKx6gQw0Qfj0LfUnjwxaLqPbue2+7xEUdZx5Z6Qc5vWU6afqZhxgByUl
         oF06peDsUtLQ6kUG2Ma7qQFZqTRD/lIkY+ZjcF+xkl54KGRdHM3GnKlTl6j5knpYE9iD
         4LIhss6VYdIcRDYfXk4FGl83S4X7jVr+63SB4zmyAV3JmloM0EZ4mnMyiA49VVyLeTDO
         ZV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731660468; x=1732265268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdH68Ik+FEA9GJcvzuT+cs6b5USGy/M06gjmxC16NMA=;
        b=YsV7ZHmKZX8GfVy5P7rQE1jfafgXWnIl5l8UsVkidrzmmz5RUREUdVOgbwKGygwIP4
         j+5hiss/5iVK2nV9SlYHccyfB5TRexaVdSLMU6LKDQupGrKzctPmKzQ9TtKMvid9lsro
         P71uh8fa5DU9qE8Su5NqPfRDOnDZb+/ES3/AyHVBVwxSTt6ISWSTaY2Ix5D/+VQHEhVZ
         +cGJj/7Akb6ufOl5ba5vD4xgnwK66j9w1oGC2VaYcwOsFxmDEryTkvx3skRTNIhNWeMx
         OLYzkbQe2ty7JoD1J1/BP5JHFNSPg27lcXJYTsIRUrq7f9mXqCZIffpdRXcHWuzSNCnw
         kNpg==
X-Forwarded-Encrypted: i=1; AJvYcCWxxG0+O3C20LljdZyiB5GIwWeI54tBRk+WPJ1/PpKg6X73GKdj1I1De/q0TB3PZQOAJaW17SI0JA==@vger.kernel.org, AJvYcCXgncvrL7c5fheFPxipYtnY8Oc/Ueb45CFS9dRelORosKFbi6FEavOidPrNtMEs5XuGPtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnpYyYLTq/tdYAYVt1t+i4e/7C1cHvXvAbHeDrdtP0dkqDvelU
	kwRV2KlD4vQx0qxxyCtMeftyUgI+CZZwoyexzjla3Fd1hv3nskka
X-Google-Smtp-Source: AGHT+IEIqpTHIZ+VVc4qnsqirZYcQXuIkNNYo4C3RfEvKhaq59txSc8Qv2GIu8nFT6uE9TqHmRnOBA==
X-Received: by 2002:a5d:64c8:0:b0:382:2276:c93c with SMTP id ffacd0b85a97d-38225a8a36cmr1647551f8f.44.1731660467956;
        Fri, 15 Nov 2024 00:47:47 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae161b5sm3839203f8f.74.2024.11.15.00.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:47:47 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Nov 2024 09:47:45 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org,
	dwarves@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
	song@kernel.org, olsajiri@gmail.com
Subject: Re: [PATCH v2 dwarves 1/2] dwarf_loader: Check
 DW_OP_[GNU_]entry_value for possible parameter matching
Message-ID: <ZzcKsfbbG8CiSCTY@krava>
References: <20241114155822.898466-1-alan.maguire@oracle.com>
 <20241114155822.898466-2-alan.maguire@oracle.com>
 <8a08219a-9312-429d-a291-d93a932c849a@linux.dev>
 <80623f0b630bd3761f0239dbe0f3197dcc6ae575.camel@gmail.com>
 <fa3f1a9b-7fee-42f4-9827-b28b1bb3eff6@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3f1a9b-7fee-42f4-9827-b28b1bb3eff6@linux.dev>

On Thu, Nov 14, 2024 at 12:04:24PM -0800, Yonghong Song wrote:
> 
> 
> 
> On 11/14/24 10:21 AM, Eduard Zingerman wrote:
> > On Thu, 2024-11-14 at 08:51 -0800, Yonghong Song wrote:
> > 
> > [...]
> > 
> > > > +		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
> > > > +		case DW_OP_entry_value:
> > > > +		case DW_OP_GNU_entry_value:
> > > > +			if (dwarf_getlocation_attr(attr, expr, &entry_attr) == 0 &&
> > > > +			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
> > > > +			    entry_len == 1) {
> > > > +				ret = entry_ops->atom;
> > > Could we have more than one DW_OP_entry_value? What if the second one
> > > matches execpted_reg? From dwarf5 documentation, there is no say about
> > > whether we could have more than one DW_OP_entry_value or not.
> > > 
> > > If we have evidence that only one DW_OP_entry_value will appear in parameter
> > > locations, a comment will be needed in the above.
> > > 
> > > Otherwise, let us not do 'goto out' here. Rather, let us compare
> > > entry_ops->atom with expected_reg. Do 'ret = entry_ops->atom' and
> > > 'goto out' only if entry_ops->atom == expected_reg. Otherwise,
> > > the original 'ret' value is preserved.
> > Basing on this description in lldb source:
> > https://github.com/llvm/llvm-project/blob/1cd981a5f3c89058edd61cdeb1efa3232b1f71e6/lldb/source/Expression/DWARFExpression.cpp#L538
> > It would be surprising if DW_OP_entry_value records had different expressions.
> > However, there are 50 instances of such behaviour in my clang 18.1.8 built kernel., e.g.:
> > 
> > 0x01f75d14:   DW_TAG_subprogram
> >                  DW_AT_low_pc    (0xffffffff818c43a0)
> >                  DW_AT_high_pc   (0xffffffff818c43c9)
> >                  DW_AT_frame_base        (DW_OP_reg7 RSP)
> >                  DW_AT_call_all_calls    (true)
> >                  DW_AT_name      ("hwcache_align_show")
> >                  DW_AT_decl_file ("/home/eddy/work/bpf-next/mm/slub.c")
> >                  DW_AT_decl_line (6621)
> >                  DW_AT_prototyped        (true)
> >                  DW_AT_type      (0x01f51a9b "ssize_t")
> > 
> > 0x01f75d26:     DW_TAG_formal_parameter
> >                    DW_AT_location        (indexed (0xa0f) loclist = 0x0062c64f:
> >                       [0xffffffff818c43a9, 0xffffffff818c43b5): DW_OP_reg5 RDI
> >                       [0xffffffff818c43b5, 0xffffffff818c43c1): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
> >                       [0xffffffff818c43c1, 0xffffffff818c43c9): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value)
> >                    DW_AT_name    ("s")
> >                    DW_AT_decl_file       ("/home/eddy/work/bpf-next/mm/slub.c")
> >                    DW_AT_decl_line       (6621)
> >                    DW_AT_type    (0x01f4f449 "kmem_cache *")
> > 
> > The following change seem not to affect pahole execution time:
> > 
> > @@ -1234,7 +1234,8 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
> >                              dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
> >                              entry_len == 1) {
> >                                  ret = entry_ops->atom;
> > -                               goto out;
> > +                               if (expr->atom == expected_reg)
> > +                                       goto out;
> >                          }
> >                          break;
> >                  }
> 
> Should we do
> 			...
> 			dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
> 			entry_len == 1 && expr->atom == expected_reg) {
> 				ret = entry_ops->atom;
> 				goto out;
> 		}
> 		...
> ?

+1 

jirka

> 
> > 
> > This question aside, I think the changes fine.
> > 
> > [...]
> > 
> 

