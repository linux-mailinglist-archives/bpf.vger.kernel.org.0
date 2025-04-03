Return-Path: <bpf+bounces-55217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB2DA7A051
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 11:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465391896957
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CF324336B;
	Thu,  3 Apr 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDFYtSZe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436EB1C5D59;
	Thu,  3 Apr 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743673522; cv=none; b=H267JD8lxTxTm3mEi/bUQYO3fKp8M3+UJIlnDFEkBiAkflS+puihm8Ly6GqU/ww0EKbwPxbjAN63Fhb0tYbI8nh+tEoiadngDZAgmAd9IxKO0Jp/fRbFBhtSdCBKjgyNgPoqs05oVBjiPb3Ouk2r8W52VIawIXaeTucVeEz2zUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743673522; c=relaxed/simple;
	bh=Hkbh1T0Y//xnQiXOM5p/wa0YIvpNthyLn5AopuohWJM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+tH6u8Bg+piQ4PQNC9MMjmPnGnGHyDv5sHw0pzpbbg3sTLXz5Iunp0IWFOirzNo1f40zWAS9oQhhKadBp3NyK7ZnNuNU2T/MUOtaEHKoxqS1fDdrkNX8XaTHU5GUPhACfB6Cegd18+BWvaXn6wdqI4kij78jr3vUMdsqJ0a/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDFYtSZe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso7013685e9.3;
        Thu, 03 Apr 2025 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743673518; x=1744278318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7cQrZqkdhiwNLAFMOTTMAadX+lXzWT8LKEz14mdHv68=;
        b=NDFYtSZegVPyhPoVZGriE/cGI9XPI8hUhp9gzcWwwLpYrxNSB5MZKT7hOkyNKqtkvH
         Jq4bJMqya5pgBmri1M6acRRlDzP2aQzMuHtpT1FM/Icv/0pXOHGInNOXwWCvWNycQ3wX
         5j07Yd4khuoGQd/XRHavNi3oJiI6BpmVRv/0CD+PAUP6TtpqDrI46z7kOll0T8VtUl/x
         mibDpT8NVVjB3UKyhiUkiLOzfTNMMf9DS20fGCdfhALB2Jov3klJbauJHgR1ccQWrhoL
         jQb0SoCOTuns/PysMtb57tpf2tiqS0z9B0Q144FVmFmJFFD6zij6imDvDRULGYYjGSCN
         esOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743673518; x=1744278318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cQrZqkdhiwNLAFMOTTMAadX+lXzWT8LKEz14mdHv68=;
        b=qnGhRClTN18NVsDzVN+M4bOm3MGwpxxRNnSZNqvTmsaYg9AVscq5C9sgW6e8D76U+J
         iEUy74CXe+K579/kuwz9NsehuezEwT6ftBydzFhew9yBw8n3IVgHh3I3J8rnvbNqskiU
         Y6LeQrxL/mAdd9LYxqrfLpoPIy5aLJGwS+36IOejVCdPbEN5piZczz8iT8lSFl3o24Ma
         zHN0ALz6BK0UcMNufnBFGcJDItI+HX7sn3cbg2wnL8xcBv0MeKc5RiaFp/wqn00fG/VS
         cmppg772/11nNcz/ASV2i+8SiJOUTAc5R/Wdlp1djslw52AMx0IZHVpSjFKMbFFP+Orx
         Uyfw==
X-Forwarded-Encrypted: i=1; AJvYcCWYh4FjG2Hi3xFYqO5qL64n5sqC8mI3JBVApm4rCXa0Gas6up5iH8hvjCTf8/YqWMApEpM=@vger.kernel.org, AJvYcCWdFMlbjAQ7Ula2Oenc7ZUWQ1f+E2vvrZjxBPtShJ7snPS0RwiTmviVhqq1MX+SoLSY3ecQKDIfgQ+SGRUx@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqbH6FEo1SbPEusiGAMIwY7fDQpbYv0scYkYbsHQnhqDEpcvX
	XKrAEgDvqjrEFG9vwldEv81kJr4kS/DKgG+vYYbHKp+LmEy9E83Y
X-Gm-Gg: ASbGncthD91398XFEYZbvI9K+z08U+GIxLWLJ68+nwiuiqD/2Vo4vettx0nskvpAGFm
	kGT0QgRBsWq2E78ajaoeA17ERWeItyDjW99MnL3fGMlIe+hN7emDhasHYJ6W6/kRryxTkE8/xq2
	Z0/Xr5MOUK6xtBGmBwACCPp8Le0jcPO7xtB5oOwa4OQXCLwHQj5+AN0gci1Qg7Ez3zN2jX9CjYF
	mDrCyqSRGd70OKXnb1BeeS6Yjn+gxF2E3mdRqPeroVBoFAc2FvyBcqP0fXj41G4Vtn15bkcuKMf
	Vkd0jEugN9FwPcYUfgyV0laApwcWWvk=
X-Google-Smtp-Source: AGHT+IFwlo0ek7OxvbALsx8w2WHdLp8+v8cTs628uEgW7h8WK/CsJeBGZJCcgQLhZB+4gbgaBe39MA==
X-Received: by 2002:a05:600c:1e1b:b0:43d:49eb:9675 with SMTP id 5b1f17b1804b1-43eb5c9588cmr55984485e9.22.1743673518298;
        Thu, 03 Apr 2025 02:45:18 -0700 (PDT)
Received: from krava ([193.32.29.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364d036sm12900835e9.26.2025.04.03.02.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 02:45:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 3 Apr 2025 11:45:15 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mateusz Bieganski <bieganski.gm@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	"open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: fix multi-uprobe attach not working with dynamic
 symbols
Message-ID: <Z-5Yq5q8ddkJUO0k@krava>
References: <20250327100733.27881-1-bieganski.gm@gmail.com>
 <CAEf4BzbGbfhdanY0yZtRoRTZaiMG4ML1PYUz1m4QbG-Kw2tNtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbGbfhdanY0yZtRoRTZaiMG4ML1PYUz1m4QbG-Kw2tNtA@mail.gmail.com>

On Fri, Mar 28, 2025 at 11:14:54AM -0700, Andrii Nakryiko wrote:
> On Thu, Mar 27, 2025 at 3:08 AM Mateusz Bieganski
> <bieganski.gm@gmail.com> wrote:
> >
> > ENOENT is incorrectly propagated to caller, if requested symbol is
> > present in dynamic linker symbol table and not present in symbol table.
> >
> > Signed-off-by: Mateusz Bieganski <bieganski.gm@gmail.com>
> > ---
> >  tools/lib/bpf/elf.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > index 823f83ad819c..41839ef5bc97 100644
> > --- a/tools/lib/bpf/elf.c
> > +++ b/tools/lib/bpf/elf.c
> > @@ -439,8 +439,10 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
> >                 struct elf_sym *sym;
> >
> >                 err = elf_sym_iter_new(&iter, elf_fd.elf, binary_path, sh_types[i], st_type);
> > -               if (err == -ENOENT)
> > +               if (err == -ENOENT) {
> > +                       err = 0;
> >                         continue;
> > +               }
> 
> Don't we have the same problem in elf_resolve_pattern_offsets() as
> well? Can you please fix both issues in one go?
> 
> It seems it's only elf_find_func_offset() that do want to preserve
> that -ENOENT, all others are just error-prone implementations.

+1, thanks for the fix

jirka

> 
> pw-bot: cr
> 
> >                 if (err)
> >                         goto out;
> >
> > --
> > 2.39.5
> >

