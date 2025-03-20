Return-Path: <bpf+bounces-54465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A8EA6A5B4
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 13:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5852E3BF177
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880A21D581;
	Thu, 20 Mar 2025 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myy7cr3n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76B2F5E;
	Thu, 20 Mar 2025 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471956; cv=none; b=l+25diX1DgSp3byHfKI9wLl3OhVDrhHvsj4c8v022JgqGk2H5obUJ/9I2gwoq7na5AV7ye+0qZWsAE6uRSWChsLeE6/uVeQ11hJJBgAI7mZoyXbud9j+fywjXFjC3f/WElJM5qUFlCjex3g//7qn0xg6d23qt3wWIuoSHaDHNsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471956; c=relaxed/simple;
	bh=k6pZ/VHA/PYYSfWztLxy5AzpbmLLFqCsFo79lk+FYtA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhoxSJeWj+WpP0Q2CzqxBCRMsRsQ1tX4lMU304lTjadTj5TzuY+9b5h2E8Z8oTkefUCxkJgKxtp2gk5eFj0ZO3sm7///oAmQuRR15wlvZIpPlulEPLwu1aru5PVFw9tjIOziu1R8TEtEZPUaRhuE20k/EY3C98ceYP1789u5Mxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Myy7cr3n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe574976so3844385e9.1;
        Thu, 20 Mar 2025 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742471953; x=1743076753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h/x60ZukXyaekHgP17JR/LQ2RUh943tF9WlzTRtfbzk=;
        b=Myy7cr3nUCMmRUGZDJhrnWRpc5lOROHURXh6/sQ3yYYQIHLtJdv6BnIhblI6Fpj78s
         6Jg6iw+Rz5nO+olIB7s4jAn1JP68ogXkTR44fzORFxASQXsKfAxA8NZaR+EXQdtsxDJg
         SbN13VCZPXF3Oy3nRump5IYxnV55lnzqjwxH/D9HNTDUgdi0ecZn7lttkPQaUCkeHte5
         rA6dOR5/OP+feR8vYu9sFANvBbVsusyNLLIRKEGxEc0Evbzp3uIu/Ov/BGLSDXkSC2PR
         pVVGN1iGROjj6PC6+oHf0QajoCETWCH2VRstoduUkgNRdiUpP8ukLHLRL7oRBJ8DqIBe
         GtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471953; x=1743076753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/x60ZukXyaekHgP17JR/LQ2RUh943tF9WlzTRtfbzk=;
        b=Jd3OeFf5LDELc74gRKYKQ5cQPIvH6rxQnEjygNKooU/rRQJ//qdWUTcZPYn7ye31Do
         51Jh8MgmQCkfy9ghHeqL66NKOBu9XuDCRp0Jhc6I/3VNn8UdWF5NLa149UydsM2MAYVs
         e5q63Ndot8Vrwk/+AQnHSJZufCorwzEA+n6Mv2Xe7l+QVylLQ6rMoK+3t4mVHrX0F/Jj
         2I6khxI8TF3XWoXMooJt9MYNoh6S9j8WXVfnD+G3ZB8GNlUvizG4Wv2DfROqjGbDreKV
         nKF9/1iRR+Js7q3XXEhrI4tsN6w0stkbZBo3Tp32XVKsRp484Bb1iDcrUov/fY0wHMwY
         YaZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkDlaCNXkx/8mEl7VcVkvJjXPcKZSgM2ABkVD+/vRffbawh7SRRzMXLCcWPbCpH+qeAEYg/38Fhw==@vger.kernel.org, AJvYcCVlpGsFzqNEhwsRYpqUowZpEUu+Zq9VfGxNHCXYL3w8kx5r9DSm5cLVYBSSqHVI3ywNJi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjbNOMqkTKwilQFt+xCQYxu00x2BsafnY1mjjgIB+sfMhHXop
	Ol1EAZheUxIumrMM440HhRR9LqhyYzo0TyZi3kOjIEjfDpHL2vlj
X-Gm-Gg: ASbGncuyt6UgHOpwkP7f7MHUBGWO3Z+ixlnUKCEaS6TJRIN898o6lO/EDIKYUcrHBc/
	HTkrcffHCyHZc3M68pH8s4mJA1tkvdMiYJ24MMlR1dG0/d7a2+qYdOrGMQvsSh7zhhh0Z4MD5ya
	y0e7ZIMYpfm04Ghippkkh67Xq8C9ZyXh8yDK5HQwAR5LccoJvg6schayDQ3VSOmQ0xi3GfNTcYT
	vGl46ZhO4Ud0BrtghWunOYz+NtYPEawDXK5Y0CXAV3qudM5DHzR10hlssSG7d25Dsdilv4vJFvb
	x4vvJbSJ7MmEMFJhIceZtvEuTITI4hI=
X-Google-Smtp-Source: AGHT+IFMKykbyPo81mhCNedV78s7FbwsBTXH+w5A2qK43bVHhHMZ3vyKLqnRYinFRz4X+TOImi9REw==
X-Received: by 2002:a05:600c:1d15:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43d4378b3ddmr51012115e9.10.1742471952465;
        Thu, 20 Mar 2025 04:59:12 -0700 (PDT)
Received: from krava ([173.38.220.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebe3csm24015961f8f.99.2025.03.20.04.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:59:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 20 Mar 2025 12:59:09 +0100
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Jiri Olsa <olsajiri@gmail.com>,
	dwarves@vger.kernel.org, acme@kernel.org, yonghong.song@linux.dev,
	ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, song@kernel.org, eddyz87@gmail.com,
	stephen.s.brennan@oracle.com, laura.nao@collabora.com,
	ubizjak@gmail.com, xiyou.wangcong@gmail.com
Subject: Re: [PATCH dwarves] btf_encoder: Filter out __gendwarfksyms_ptr_
Message-ID: <Z9wDDY4ET94ruTSh@krava>
References: <20250317222424.3837495-1-samitolvanen@google.com>
 <Z9lCVHIyjLjQ4BOs@krava>
 <CABCJKud4e_bBvOrXSrOmkiw+XX8DJzKBC=nxmNP7e=GusGEkOw@mail.gmail.com>
 <45881882-46d2-43ca-b833-439363926c87@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45881882-46d2-43ca-b833-439363926c87@oracle.com>

On Thu, Mar 20, 2025 at 09:54:21AM +0000, Alan Maguire wrote:
> On 18/03/2025 16:14, Sami Tolvanen wrote:
> > Hi Jiri,
> > 
> > On Tue, Mar 18, 2025 at 9:52 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >>
> >> On Mon, Mar 17, 2025 at 10:24:24PM +0000, Sami Tolvanen wrote:
> >>> With CONFIG_GENDWARFKSYMS, __gendwarfksyms_ptr_<symbol>
> >>> variables are added to the kernel in EXPORT_SYMBOL() to ensure
> >>> DWARF type information is available for exported symbols in the
> >>> TUs where they're actually exported. These symbols are dropped
> >>> when linking vmlinux, but dangling references to them remain
> >>> in DWARF, which results in thousands of 0 address variables
> >>> that pahole needs to validate (since commit 9810758003ce
> >>> ("btf_encoder: Verify 0 address DWARF variables are in ELF
> >>> section")).
> >>>
> >>> Filter out symbols with the __gendwarfksyms_ptr_ name prefix in
> >>> filter_variable_name() instead of calling variable_in_sec()
> >>> for all of them. This reduces the time it takes to process
> >>> .tmp_vmlinux1 by ~77% on my test system:
> >>>
> >>> Before: 35.775 +- 0.121  seconds time elapsed  ( +-  0.34% )
> >>>  After: 8.3516 +- 0.0407 seconds time elapsed  ( +-  0.49% )
> >>
> >> makes sense to me, I just can't reproduce the speedup
> >> could you please share your .config?
> > 
> > Sure, here's the config I used to repro this:
> > 
> > https://gist.github.com/samitolvanen/dca66a1a779861be27579f88c9b6ba5d
> > 
> > This is essentially x86_64 defconfig with GENDWARFKSYMS and
> > DEBUG_INFO_BTF both enabled. When building this config with gcc, we
> > end up with 0 address __gendwarfksyms_ptr variables in DWARF:
> > 
> > ...
> > 0x0001b5c6:   DW_TAG_variable
> >                 DW_AT_name      ("__gendwarfksyms_ptr_system_state")
> >                 DW_AT_decl_file ("../init/main.c")
> >                 DW_AT_decl_line (129)
> >                 DW_AT_decl_column       (1)
> >                 DW_AT_type      (0x0001b5dc "system_states *")
> >                 DW_AT_location  (DW_OP_addr 0x0)
> > ...
> > 
> > Note that this doesn't seem to happen when building with Clang.
> > 
> > Before commit 9810758003ce this resulted in pahole thinking all these
> > variables are in the .data..percpu section, which resulted in
> > btf_datasec_check_meta() failing with "Invalid offset" during boot.
> > pahole/next doesn't have this issue, but validating the 0 address
> > variables is unfortunately a bit slow when we have a lot of them.
> >
> 
> Thanks for the fix Sami! I've tested it at my end and can reproduce the
> longer time for BTF encoding on x86_64 prior to the fix and its
> resolution. Let's wait a bit longer before landing it to see if anyone
> else gets a chance to test/ack it, but I think we should probably also add a
> 
> Fixes: 9810758003ce9f ("btf_encoder: Verify 0 address DWARF variables
> are in ELF section")

+1 

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> 
> (no need to resend for this; I can add it when committing it)
> 
> I'm thinking we should also try and incorporate some performance tests
> for vmlinux BTF encoding into the tests subdirectory to better catch
> issues like this; perhaps the CI can baseline encoding performance on
> the next branch versus the branch that has the changes..
> 
> Thanks again!
> 
> Alan
> > Sami
> 

