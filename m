Return-Path: <bpf+bounces-12706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675867CFEC8
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 17:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234F3280FE7
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9104D32195;
	Thu, 19 Oct 2023 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDaKFfQE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596B30FB0;
	Thu, 19 Oct 2023 15:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F47C433CA;
	Thu, 19 Oct 2023 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697730963;
	bh=UdTLJEWjQLLbDTfkJJrqOSkrPFt3tUV8K30G7Qw7fHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDaKFfQEqVlYYZxhyDmpBy3qGGGZtmxpAdGXPA/9qSuTBgNgPzDJz/QMIb47NzO6n
	 meCy2xfdT29X7i5Ns9X6gThQnxZzRu0K+bFldhIbskVNg2R+0o82hu56yrxI9vSB94
	 t1PEK0SOSnDiiS33daoKearQ1I3JajQaip6qgE4pLq06pj551afIUREXxwpz4oPKt4
	 S8hvWeVcGRjK6JUQl1mKU3nGaIfMFZw2nmv0meXLoHr+NlWtk0Odjv8QyepSGe7rGj
	 ISgesdES0lJxpCRT5qmji/cU3XaAzrOC4QN3Eg1nRmUKWJ6cT1RhfvPsClBlCkMZgg
	 gBNMao2FqR7FQ==
Date: Thu, 19 Oct 2023 08:56:00 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Potapenko <glider@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Nick Terrell <terrelln@fb.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Li Hua <hucool.lihua@huawei.com>, Rae Moar <rmoar@google.com>,
	rust-for-linux@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] lib/Kconfig.debug: disable FRAME_WARN for kasan and kcsan
Message-ID: <20231019155600.GB60597@dev-arch.thelio-3990X>
References: <20231018182412.80291-1-hamza.mahfooz@amd.com>
 <CAMuHMdXSzMJe1zyJu1HkxWggTKJj_sxkPOejjbdRjg3FeFTVHQ@mail.gmail.com>
 <d764242f-cde0-47c0-ae2c-f94b199c93df@amd.com>
 <CAMuHMdXYDQi5+x1KxMG0wnjSfa=A547B9tgAbgbHbV42bbRu8Q@mail.gmail.com>
 <CAG_fn=XcJ=rZEJN+L1zZwk=qA90KShhZK1MA6fdW0oh7BqSJKw@mail.gmail.com>
 <22580470-7def-4723-b836-1688db6da038@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22580470-7def-4723-b836-1688db6da038@app.fastmail.com>

On Thu, Oct 19, 2023 at 02:53:01PM +0200, Arnd Bergmann wrote:
> On Thu, Oct 19, 2023, at 12:04, Alexander Potapenko wrote:
> > So the remaining option would be to just increase the frame size every
> > time a new function surpasses the limit.
> 
> That is clearly not an option, though we could try to
> add Kconfig dependencies that avoid the known bad combinations,
> such as annotating the AMD GPU driver as
> 
>       depends on (CC_IS_GCC || CLANG_VERSION >=180000) || !(KASAN || KCSAN)

This would effectively disable the AMDGPU driver for allmodconfig, which
is somewhat unfortunate as it is an easy testing target.

Taking a step back, this is all being done because of a couple of
warnings in the AMDGPU code. If fixing those in the source is too much
effort (I did note [1] that GCC is at the current limit for that file
even with Rodrigo's series applied [2]), couldn't we just take the
existing workaround that this Makefile has for this file and its high
stack usage and just extend it slightly for clang?

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index 66431525f2a0..fd49e3526c0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -58,7 +58,7 @@ endif
 endif
 
 ifneq ($(CONFIG_FRAME_WARN),0)
-frame_warn_flag := -Wframe-larger-than=2048
+frame_warn_flag := -Wframe-larger-than=$(if $(CONFIG_CC_IS_CLANG),3072,2048)
 endif
 
 CFLAGS_$(AMDDALPATH)/dc/dml2/display_mode_core.o := $(dml2_ccflags) $(frame_warn_flag)

That would address the immediate concern of the warning breaking builds
with CONFIG_WERROR=y while not raising the limit for other files in the
kernel (just this one file in AMDGPU) and avoiding disabling the whole
driver. The number could be lower, I think ~2500 bytes is the most usage
I see with Rodrigo's series applied, so maybe 2800 would be a decent
limit? Once there is a fix in the compiler, this expression could be
changed to use clang-min-version or something of that sort.

[1]: https://lore.kernel.org/20231017172231.GA2348194@dev-arch.thelio-3990X/
[2]: https://lore.kernel.org/20231016142031.241912-1-Rodrigo.Siqueira@amd.com/

Cheers,
Nathan

