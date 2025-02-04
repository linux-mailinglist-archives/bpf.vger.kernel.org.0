Return-Path: <bpf+bounces-50412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18637A27362
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 14:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE4E3A85AC
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1657F21420F;
	Tue,  4 Feb 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKBwVWSv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C3213E91;
	Tue,  4 Feb 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675803; cv=none; b=KkBYuE3g2DbaTXF4OI0PJ9BEAnin79CJaQ73vS7B4CQe1soj2PylpwMbNXkonoPAUgAOpgOCHOsvNEZsxAs4J/C89+Y64krbl6A3SrMQ+R6MvqH4hqr7A6DhzHOfclGLl1oad3keTjQnUfkRP7lNpR0rAbh1elXe1th4+FStFDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675803; c=relaxed/simple;
	bh=fhTHl3VMAD25DEjVrDF/ce4B/A45dAgzIuOCzAjg7YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwrjHdkLCCuxB01V0TpCl/8Nv01EYanE0vtlAnL0Sg9eML4bynuMC8yfMKmYmYU43PQC3vhNkkvqRmY61xB+VCIkjN30d5YFpvFqE0RpU6vDozIU6vmIGuqqpU82xGNWrQJ6NjInJLpCFfu4CmRMP1sOlSt52pAhfmmXqQktyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKBwVWSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA2DC4CEDF;
	Tue,  4 Feb 2025 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738675802;
	bh=fhTHl3VMAD25DEjVrDF/ce4B/A45dAgzIuOCzAjg7YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKBwVWSvNqgb3AdOdljELzEhnwjhVscNkOLcLkAZSm/09ITUmN2fkBKcDCAGar682
	 i4P6xy4a3LJD4oLfuzILMeoEi4SbaB9br38RwFLr+G/6jw+K0Dp9zOZgNjVnQdzco3
	 i1bC8DJmfpf4Ues0vsqZ3eW7gRGptROSwWA51OOBsqW1MxIpTU/pmhRYRZWGa+vHS6
	 PWxolw4IEdvSK2sKpXoAxqNYgekZGSyJz0tLBeGvoRgUV7yw7iZPJtIDcq0AFsKLzs
	 sFKOM07NdClkcA+go0NHr2rv5w7OqZcqr+ziMd/fZWfdUEZdr9ObA9OHoC/rhsFBah
	 k1dbZgG7zWvRQ==
Date: Tue, 4 Feb 2025 14:30:00 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Gomez <da.gomez@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, iovisor-dev <iovisor-dev@lists.iovisor.org>, 
	gost.dev@samsung.com
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
Message-ID: <xsg3mrozb3zd7g3hqki7lvdkc4zbi6bs3oiif64kvnnldaai5a@3g7gnpcz5igh>
References: <CGME20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c@eucas1p1.samsung.com>
 <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
 <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
 <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com>

On Wed, Jan 22, 2025 at 09:02:19AM +0100, Alexei Starovoitov wrote:
> On Wed, Jan 22, 2025 at 5:12 AM Daniel Gomez <da.gomez@samsung.com> wrote:
> >
> > Add support for a module error injection tool. The tool
> > can inject errors in the annotated module kernel functions
> > such as complete_formation(), do_init_module() and
> > module_enable_rodata_after_init(). Module name and module function are
> > required parameters to have control over the error injection.
> >
> > Example: Inject error -22 to module_enable_rodata_ro_after_init for
> > brd module:
> >
> > sudo moderr --modname=brd --modfunc=module_enable_rodata_ro_after_init \
> > --error=-22 --trace
> > Monitoring module error injection... Hit Ctrl-C to end.
> > MODULE     ERROR FUNCTION
> > brd        -22   module_enable_rodata_after_init()
> >
> > Kernel messages:
> > [   89.463690] brd: module loaded
> > [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
> > ro_after_init data might still be writable
> >
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> >  tools/bpf/Makefile            |  13 ++-
> >  tools/bpf/moderr/.gitignore   |   2 +
> >  tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
> >  tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
> >  tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++++++++
> >  tools/bpf/moderr/moderr.h     |  40 +++++++
> >  6 files changed, 510 insertions(+), 3 deletions(-)
> 
> The tool looks useful, but we don't add tools to the kernel repo.
> It has to stay out of tree.

Can you clarify what do you mean? There are other tools under tools/ and tools/
bpf [1].

[1] https://lore.kernel.org/bpf/20200114184230.GA204154@krava/

I will anyway move the tool to the suggested location in the other thread.

> 
> The value of error injection is not clear to me.
> Other places in the kernel use it to test paths in the kernel
> that are difficult to do otherwise.

By any chance do you know which tool are they using?

> These 3 functions don't seem to be in this category.

Luis already answered this.

