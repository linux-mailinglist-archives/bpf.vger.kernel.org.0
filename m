Return-Path: <bpf+bounces-49980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D913A21358
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 21:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10C31675B6
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392F11E7C10;
	Tue, 28 Jan 2025 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za2arqJ0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCC1DB34E;
	Tue, 28 Jan 2025 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738097827; cv=none; b=ZoDmEsRYIVwsf0X2cKXIHVEpPV6vtl27QSpw0rt7+NCOxmx3A9FGAlP2L4C+Nr2GBghPW72mjNgbvGBtRRvcJSL3hbgSIbZKak3NQOXAm2TtN2BFz2A6INGyTexr3BXUWGQTpiKFSPaKf3OocTC8HMqLrj87k/OSjLdI1VnzzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738097827; c=relaxed/simple;
	bh=x7YDvWsOV1m58zdR2LDHr+xA2bpMI4bdPxmrUqwKaVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgSAPNP5UCOx9VqkiJI5lbZ37Kc0h91+8psm07YrfnT1QQoqjmQdMK4KcW6DehO5eD6TVQYa6TcspyzZCfZWkQqRppJ04b33hiD0QN1GwGjkiYU09lEHFb935CtrjNQkKi4W473731QgadvnSWcxuSP0ogI6K8Lo29TIiZU0i9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za2arqJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EA7C4CED3;
	Tue, 28 Jan 2025 20:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738097827;
	bh=x7YDvWsOV1m58zdR2LDHr+xA2bpMI4bdPxmrUqwKaVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Za2arqJ0+MdRp9VrNuTSkUE0m9ZlIJLFTH6G1gaasLOGHnKWK2f9778vk6sjbGq26
	 eFH9ruA+gt6GwOrp+JAmscY08ZtZR0WhR2TfZo6DOWIK0x69i+glwC00OY9F9GZk+c
	 dJCTJ/qI12VIi119XEf76D31svgmaKqo13IOh9pu4XfOldKg74uenWWH8W3SWjdeGB
	 rbcHYb5/rqzCvmNAbfFpyyHJBMPlJIFOlcKPbTc7Nyz1AVOdgUHWAvSEbA6Rp0DsQ1
	 961sE2cjbtwiMlFy3jIXYwHJgqmcGLRF16QeYgz4ephmzrlcbzwAun5ANlF6f7reZr
	 7/kkr4xXmQAhw==
Date: Tue, 28 Jan 2025 12:57:05 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Gomez <da.gomez@samsung.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>,
	iovisor-dev <iovisor-dev@lists.iovisor.org>, gost.dev@samsung.com
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
Message-ID: <Z5lEoUxV4fBzKf4i@bombadil.infradead.org>
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

On Wed, Jan 22, 2025 at 09:02:19AM -0800, Alexei Starovoitov wrote:
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

For selftests we do add random tools.

> The value of error injection is not clear to me.

It is of great value, since it deals with corner cases which are
otherwise hard to reproduce in places which a real error can be
catostrophic.

> Other places in the kernel use it to test paths in the kernel
> that are difficult to do otherwise.

Right.

> These 3 functions don't seem to be in this category.

That's the key here we should focus on. The problem is when a maintainer
*does* agree that adding an error injection entry is useful for testing,
and we have a developer willing to do the work to help test / validate
it. In this case, this error case is rare but we do want to strive to
test this as we ramp up and extend our modules selftests.

Then there is the aspect of how to mitigate how instrusive code changes
to allow error injection are. In 2021 we evaluated the prospect of error
injection in-kernel long ago for other areas like the block layer for
add_disk() failures [0] but the minimal interface to enable this from
userspace with debugfs was considered just too intrusive.

This effort tried to evaluate what this could look like with eBPF to
mitigate the required in-kernel code, and I believe the light weight
nature of it by just requiring a sprinkle with ALLOW_ERROR_INJECTION()
suffices to my taste.

So, perhaps the tools aspect can just go in:

tools/testing/selftests/module/

[0] https://www.spinics.net/lists/linux-block/msg68159.html

  Luis

