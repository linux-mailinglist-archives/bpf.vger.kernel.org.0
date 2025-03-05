Return-Path: <bpf+bounces-53299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B41A4FB37
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 11:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B582B1660AA
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E876A206F3B;
	Wed,  5 Mar 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbDPK0TA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCD206F09;
	Wed,  5 Mar 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169220; cv=none; b=LuE8IquR/Wskt4WW1E0Klmh8oOpqIn3IWvZyfRBrrBxNskTUK6L2moQpkcUH6CtQiFexEwzqHSzVaiKQI6qL6newEjYb60CoT6miLew0mlUk9/d7EkN/isAxppPRZpkzp4ahm7YtFQahTs6sd3ewLWCIz2HVBSqPQKf9oshblvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169220; c=relaxed/simple;
	bh=A1BLHb/YOt1RlLLdoQ9snVOq23XX5GqhKF39BlDDcWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxseHOdwNktY6hQcmkR0svKmUsZzmYR4EPoJgRpcPNX18jV+9PznffC3EENwF0laA7f3c7OCEM91Oo7BXElys2pVPMkpLa5ThTS3V8evTIOg5qPUkuwNdGmkttfc/FZL2WXvrnFXl774l1CuGQH6Uc0gtEBSWhCj+5KkdHOVO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbDPK0TA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FA5C4CEE8;
	Wed,  5 Mar 2025 10:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169219;
	bh=A1BLHb/YOt1RlLLdoQ9snVOq23XX5GqhKF39BlDDcWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbDPK0TAQsCRoTQuHF/7HONFoXGZYuV0GHA5QnmqioKFXOjXnCaD+eMUIESZgwGbO
	 4vvGpbmK8hgE0IlSABvohIeXuGKu0Arh2PJ02/CPwJD4HVG6Zn8oTTrF7R9LsLFbBk
	 ioPkRla9W6iyGBdNrSxduLlGdoRjZ2ur0upm5XcuF2ygWRGZViHJyEWw696Ho8WhB3
	 3Ehf20kiNs+fo/57VRHxk9RJT9gXgcYEvgyWJP2wvpwPwrAhLzaZFtRvnwslgIwgz8
	 dC5qA1PUKARiNDV+AUzbA6830k3/T3zrvGGItI2dg7LEKviYjzmnQwGBSyp7+wV1eU
	 1ofStbuppZ3rw==
Date: Wed, 5 Mar 2025 11:06:57 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-modules@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, iovisor-dev <iovisor-dev@lists.iovisor.org>, 
	gost.dev@samsung.com
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
Message-ID: <mghfn2piuln4oxg2zkmukjcjbt2hyieqsgfnckfzvjwrcbi4eh@vwh5nsvwajjq>
References: <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
 <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
 <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com>
 <Z5lEoUxV4fBzKf4i@bombadil.infradead.org>
 <qnfhjhyqlagmrmk3dwfb2ay37ihi6dlkzs67bzxpu7izz6wqc5@aiohaxlgzx5r>
 <Z7je7Kryipdq6AV4@bombadil.infradead.org>
 <4xh2oviqumypm4r7jch25af5jtesof7wnejqybncuopayq6yiq@skayuieidaq7>
 <ccofyygi4rerybdmecqswldykihtabx6yco7ztylqnbmw4a5qw@ye7zoq7mcol2>
 <3ehu3r4hlsf7cpptofz2y5aq2bazidq4buxbddqj6gzvzd3eh3@wzlnbvdsc6ty>
 <e6jybeg4y6q6zqyhqma7q4icw7jllieq5rwwi5pguy242wioyp@hkelxx7tnzlg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6jybeg4y6q6zqyhqma7q4icw7jllieq5rwwi5pguy242wioyp@hkelxx7tnzlg>

On Fri, Feb 28, 2025 at 12:48:38PM +0100, Lucas De Marchi wrote:
> On Fri, Feb 28, 2025 at 10:27:17AM +0100, Daniel Gomez wrote:
> > On Mon, Feb 24, 2025 at 08:43:45AM +0100, Lucas De Marchi wrote:
> > > On Sat, Feb 22, 2025 at 10:35:07PM +0100, Daniel Gomez wrote:
> > > > On Fri, Feb 21, 2025 at 12:15:40PM +0100, Luis Chamberlain wrote:
> > > > > On Wed, Feb 19, 2025 at 02:17:48PM -0600, Lucas De Marchi wrote:
> > > > > > On Tue, Jan 28, 2025 at 12:57:05PM -0800, Luis Chamberlain wrote:
> > > > > > > On Wed, Jan 22, 2025 at 09:02:19AM -0800, Alexei Starovoitov wrote:
> > > > > > > > On Wed, Jan 22, 2025 at 5:12 AM Daniel Gomez <da.gomez@samsung.com> wrote:
> > > > > > > > >
> > > > > > > > > Add support for a module error injection tool. The tool
> > > > > > > > > can inject errors in the annotated module kernel functions
> > > > > > > > > such as complete_formation(), do_init_module() and
> > > > > > > > > module_enable_rodata_after_init(). Module name and module function are
> > > > > > > > > required parameters to have control over the error injection.
> > > > > > > > >
> > > > > > > > > Example: Inject error -22 to module_enable_rodata_ro_after_init for
> > > > > > > > > brd module:
> > > > > > > > >
> > > > > > > > > sudo moderr --modname=brd --modfunc=module_enable_rodata_ro_after_init \
> > > > > > > > > --error=-22 --trace
> > > > > > > > > Monitoring module error injection... Hit Ctrl-C to end.
> > > > > > > > > MODULE     ERROR FUNCTION
> > > > > > > > > brd        -22   module_enable_rodata_after_init()
> > > > > > > > >
> > > > > > > > > Kernel messages:
> > > > > > > > > [   89.463690] brd: module loaded
> > > > > > > > > [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
> > > > > > > > > ro_after_init data might still be writable
> > > > > > > > >
> > > > > > > > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > > > > > > > ---
> > > > > > > > >  tools/bpf/Makefile            |  13 ++-
> > > > > > > > >  tools/bpf/moderr/.gitignore   |   2 +
> > > > > > > > >  tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
> > > > > > > > >  tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
> > > > > > > > >  tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > >  tools/bpf/moderr/moderr.h     |  40 +++++++
> > > > > > > > >  6 files changed, 510 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > The tool looks useful, but we don't add tools to the kernel repo.
> > > > > > > > It has to stay out of tree.
> > > > > > >
> > > > > > > For selftests we do add random tools.
> > > > > > >
> > > > > > > > The value of error injection is not clear to me.
> > > > > > >
> > > > > > > It is of great value, since it deals with corner cases which are
> > > > > > > otherwise hard to reproduce in places which a real error can be
> > > > > > > catostrophic.
> > > > > > >
> > > > > > > > Other places in the kernel use it to test paths in the kernel
> > > > > > > > that are difficult to do otherwise.
> > > > > > >
> > > > > > > Right.
> > > > > > >
> > > > > > > > These 3 functions don't seem to be in this category.
> > > > > > >
> > > > > > > That's the key here we should focus on. The problem is when a maintainer
> > > > > > > *does* agree that adding an error injection entry is useful for testing,
> > > > > > > and we have a developer willing to do the work to help test / validate
> > > > > > > it. In this case, this error case is rare but we do want to strive to
> > > > > > > test this as we ramp up and extend our modules selftests.
> > > > > > >
> > > > > > > Then there is the aspect of how to mitigate how instrusive code changes
> > > > > > > to allow error injection are. In 2021 we evaluated the prospect of error
> > > > > > > injection in-kernel long ago for other areas like the block layer for
> > > > > > > add_disk() failures [0] but the minimal interface to enable this from
> > > > > > > userspace with debugfs was considered just too intrusive.
> > > > > > >
> > > > > > > This effort tried to evaluate what this could look like with eBPF to
> > > > > > > mitigate the required in-kernel code, and I believe the light weight
> > > > > > > nature of it by just requiring a sprinkle with ALLOW_ERROR_INJECTION()
> > > > > > > suffices to my taste.
> > > > > > >
> > > > > > > So, perhaps the tools aspect can just go in:
> > > > > > >
> > > > > > > tools/testing/selftests/module/
> > > > > >
> > > > > > but why would it be module-specific?
> > > > >
> > > > > Gotta start somewhere.
> > > > >
> > > > > > Based on its current implementation
> > > > > > and discussion about inject.py it seems to be generic enough to be
> > > > > > useful to test any function annotated with ALLOW_ERROR_INJECTION().
> > > > > >
> > > > > > As xe driver maintainer, it may be interesting to use such a tool:
> > > > > >
> > > > > > 	$ git grep ALLOW_ERROR_INJECT -- drivers/gpu/drm/xe | wc -l  	23
> > > > > >
> > > > > > How does this approach compare to writing the function name on debugfs
> > > > > > (the current approach in xe's testsuite)?
> > > > > >
> > > > > > 	fail_function @ https://docs.kernel.org/fault-injection/fault-injection.html#fault-injection-capabilities-infrastructure
> > > > > > 	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/intel/xe_fault_injection.c?ref_type=heads#L108
> > > > > >
> > > > > > If you decide to have the tool to live somewhere else, then kmod repo
> > > > > > could be a candidate.
> > > > >
> > > > > Would we install this upon install target?
> > > > >
> > > > > Danny can decide on this :)
> > > > >
> > > > > > Although I think having it in kernel tree is
> > > > > > simpler maintenance-wise.
> > > > >
> > > > > I think we have at least two users upstream who can make use of it. If
> > > > > we end up going through tools/testing/selftests/module/ first, can't
> > > > > you make use of it later?
> > > >
> > > > What are the features in debugfs required to be useful for xe that we can
> > > > port to an eBPF version? I see from the link provided the use of probability,
> > > > interval, times and space but these are configured to allways trigger the error.
> > > > Is that right?
> > > 
> > > I don't think we use them... we just set them to "always trigger" and
> > > then create the conditions for that to happen.  But my question still
> > > remains:  what is the benefit of using the bpf approach over writing
> > > these files?
> > 
> > The code to trigger the error injection still needs to exist with both
> > approaches. My understanding from debugfs and the comment from Luis earlier in
> > the thread is that with eBPF you can mitigate how intrusive in-kernel code
> > changes are to allow error injection. Luis added the example here [1] for
> > debugfs.
> > 
> > [1] https://lore.kernel.org/all/20210512064629.13899-9-mcgrof@kernel.org/
> > 
> > To compare patch 8 in [1] with eBPF approach: the patch describes
> > all the necessary changes required to allow error injection on the
> > add_disk() path. With eBPF one would simply annotate the function(s) with
> > ALLOW_ERROR_INJECTION(), e.g. device_add() and replace the return value
> > in eBPF code with bpf_override_return() as implemented in moderr tool for
> > module_enable_rdata_after_init() for example.
> 
> but that is all that we need with the fail_function in debugfs too:
> 
> $ git grep ALLOW_ERROR_INJECTION -- drivers/gpu/drm/xe
> drivers/gpu/drm/xe/xe_device.c:ALLOW_ERROR_INJECTION(xe_device_create, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_device.c:ALLOW_ERROR_INJECTION(wait_for_lmem_ready, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_exec_queue.c:ALLOW_ERROR_INJECTION(xe_exec_queue_create_bind, ERRNO);
> drivers/gpu/drm/xe/xe_ggtt.c:ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_guc_ads.c:ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_guc_ct.c:ALLOW_ERROR_INJECTION(xe_guc_ct_init, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_guc_log.c:ALLOW_ERROR_INJECTION(xe_guc_log_init, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_guc_relay.c:ALLOW_ERROR_INJECTION(xe_guc_relay_init, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_pci.c: * ALLOW_ERROR_INJECTION() is used to conditionally skip function execution
> drivers/gpu/drm/xe/xe_pci.c: * ALLOW_ERROR_INJECTION() macro but this is acceptable because for those
> drivers/gpu/drm/xe/xe_pm.c:ALLOW_ERROR_INJECTION(xe_pm_init_early, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_create, ERRNO);
> drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_update_ops_prepare, ERRNO);
> drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_update_ops_run, ERRNO);
> drivers/gpu/drm/xe/xe_sriov.c:ALLOW_ERROR_INJECTION(xe_sriov_init, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_sync.c:ALLOW_ERROR_INJECTION(xe_sync_entry_parse, ERRNO);
> drivers/gpu/drm/xe/xe_tile.c:ALLOW_ERROR_INJECTION(xe_tile_init_early, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_uc_fw.c:ALLOW_ERROR_INJECTION(xe_uc_fw_init, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(xe_vma_ops_alloc, ERRNO);
> drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(xe_vm_create_scratch, ERRNO);
> drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(vm_bind_ioctl_ops_create, ERRNO);
> drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(vm_bind_ioctl_ops_execute, ERRNO);
> drivers/gpu/drm/xe/xe_wa.c:ALLOW_ERROR_INJECTION(xe_wa_init, ERRNO); /* See xe_pci_probe() */
> drivers/gpu/drm/xe/xe_wopcm.c:ALLOW_ERROR_INJECTION(xe_wopcm_init, ERRNO); /* See xe_pci_probe() */
> 
> That is different from the patch you are pointing to because that patch
> is trying to add arbitrary/named error injection points throughout the
> code. However via debugfs it's still possible to add error injection to

When reading the patch I assumed the block/failure-injection.c was needed for
the knobs in sysfs/debugfs. But I see I was wrong and these are only needed for
the arbitrary error injection points?

I see mm/fail_page_alloc.c has a similar approach with should_fail_alloc_page().

> the beginning of a function by annotating that function with
> ALLOW_ERROR_INJECTION. If a function is annotated with that, then if you
> do e.g.
> 
> 	echo xe_device_create > /sys/kernel/debug/fail_function/inject
> 
> it will cause that function to fail. There are some additional files to
> control _when_ that function should fail, but I'm failing to see a clear
> benefit. See this example in the docs:

Can you clarify if _when_ (in debugfs) allows you to access function arguments
of a given annotated function with ALLOW_ERROR_INJECTION()? It seems that might
be the only part that can be moved out of the kernel and handled in eBPF. Other
than that, I don't see either a benefit of using one approach over the other.

> 
> 	Documentation/fault-injection/fault-injection.rst:- Inject open_ctree error while btrfs mount::
> 
> Lucas De Marchi
 

