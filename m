Return-Path: <bpf+bounces-18608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8852281CA30
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 13:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E85B24FBD
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09619182AA;
	Fri, 22 Dec 2023 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6JhXaGm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D881803A
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cca502e642so14468841fa.0
        for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 04:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703249223; x=1703854023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yp5ac/myi/GwDrkODdQUpsOMH/7f111bHF1TjsQ6HEc=;
        b=Q6JhXaGm5OevzpQUxTLvAA89IAT+D2hzmQEOnjuDRPgnYdmICNJRhJDj47LZSjmAvU
         zcG3sgH/c2foDi3j+ldmuvq6UNGUQ41WJPE6+OVOY3nu9mspwE4vDf/p7k+VKBQRwt1H
         BTu2X36t4aR4DNEifeZpESomQyiW6PpYtTWF84vPaMmGkb5h2BNdGqLg99o9zqxFxjd6
         Fi+4+iTgQXIzuMYg14HQijiHYdEy4e6nq9YGxJ6aCCYg9KHaXPp5UyVBug/rkDeCUKl/
         jXKrWQcWvoYi/Nkeaaql4Go2IhCQNxVyyl31J4tUpHcx/OXlzLVbpws/FYK63nb6prTT
         xLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703249223; x=1703854023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp5ac/myi/GwDrkODdQUpsOMH/7f111bHF1TjsQ6HEc=;
        b=Lz3NmwWFreKMH1b1ba5xca0G35xw6a9BcY7X2IzZ7Q52Vzj9pabWDJhQSHZdUPCnhW
         hvNzivgX50EnMCLhxO97XeW/cecYjrCwQcU0S42tnDf27QanhaoJI5p7IIsSwJM7Cwld
         6q5rYg3BsnaoWkHIjECdV+YQj+V2Bhot3GSpVTwMTHzKGe+QRoous2lPihzqQFhOHMxF
         c9mNZmQ8JxkB+v3Mm8NjatsPkPwxC+solsT1GuoOy/qsbHC1o5KtM1fV5t/U9HgvI7Ks
         AqoDtzokBRc3Q71e3TfhbAWAjjAFt7H2txmXzLgesu4q1ouXCKA7zP2T6UaXeMZmOCyC
         Mu3A==
X-Gm-Message-State: AOJu0YykSYDZROfVw2g6wqkfal3raKREl9uRkVhUZowmJ7kgnHFr+HAz
	Jue8c4M4k8zZMwVnRXs5F1s=
X-Google-Smtp-Source: AGHT+IFUBcMJvItqktAXAsw+u+sQnXqGdcQh0ffce2y9P8M95ke6uS/L1A8un2oJT43voL0u1glkmQ==
X-Received: by 2002:a2e:8e26:0:b0:2cc:8a4b:6752 with SMTP id r6-20020a2e8e26000000b002cc8a4b6752mr272517ljk.172.1703249222770;
        Fri, 22 Dec 2023 04:47:02 -0800 (PST)
Received: from krava (net-109-116-206-100.cust.vodafonedsl.it. [109.116.206.100])
        by smtp.gmail.com with ESMTPSA id j20-20020aa7c0d4000000b005527de2aecfsm2518587edp.42.2023.12.22.04.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 04:47:02 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Dec 2023 13:46:59 +0100
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZYWFQ62dASM5InBZ@krava>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava>
 <CAADnVQJL7Yodi67f2A79Pah-Uek+WX66CVs=tAFAoYsh+t+3_Q@mail.gmail.com>
 <fecae4fe-b804-c7f5-1854-66af2f16a44a@oracle.com>
 <CAADnVQ+9PZvTc034oHa=7yQFPtyV=Yvjqef2+r97SyKFOgV=RA@mail.gmail.com>
 <64f6db18-ebd5-501b-2457-a8abe6187a0f@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64f6db18-ebd5-501b-2457-a8abe6187a0f@oracle.com>

On Fri, Dec 22, 2023 at 09:55:09AM +0000, Alan Maguire wrote:
> On 21/12/2023 18:07, Alexei Starovoitov wrote:
> > On Thu, Dec 21, 2023 at 9:43 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>
> >> On 21/12/2023 17:05, Alexei Starovoitov wrote:
> >>> On Thu, Dec 21, 2023 at 12:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >>>> you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lists,
> >>>> which are bounded by __BTF_ID__set8__<name> symbols, which also provide size
> >>>
> >>> +1
> >>>
> >>>>>
> >>>>> Maybe we need a codemod from:
> >>>>>
> >>>>>         BTF_ID(func, ...
> >>>>>
> >>>>> to:
> >>>>>
> >>>>>         BTF_ID(kfunc, ...
> >>>>
> >>>> I think it's better to keep just 'func' and not to do anything special for
> >>>> kfuncs in resolve_btfids logic to keep it simple
> >>>>
> >>>> also it's going to be already in pahole so if we want to make a fix in future
> >>>> you need to change pahole, resolve_btfids and possibly also kernel
> >>>
> >>> I still don't understand why you guys want to add it to vmlinux BTF.
> >>> The kernel has no use in this additional data.
> >>> It already knows about all kfuncs.
> >>> This extra memory is a waste of space from kernel pov.
> >>> Unless I am missing something.
> >>>
> >>> imo this logic belongs in bpftool only.
> >>> It can dump vmlinux BTF and emit __ksym protos into vmlinux.h
> >>>
> >>
> >> If the goal is to have bpftool detect all kfuncs, would having a BPF
> >> kfunc iterator that bpftool could use to iterate over registered kfuncs
> >> work perhaps?
> > 
> > The kernel code ? Why ?
> > bpftool can do the same thing as this patch. Iterate over set8 in vmlinux elf.
> 
> Most distros don't have the vmlinux binary easily available; it needs to
> be either downloaded as part of debuginfo packages or uncompressed from
> vmlinuz.

would reading the /proc/kcore be an option? I'm under impression it's
default for distros but I might be wrong

jirka

