Return-Path: <bpf+bounces-15517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C821C7F2BBB
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 12:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1F41C218CB
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BDC48793;
	Tue, 21 Nov 2023 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmicvmMD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B35CCA
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 03:29:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso7433281a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 03:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700566168; x=1701170968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsqZB3wKlZYVV/pNjJsQ4KrD2LxkGr23gZPr/fmL3q4=;
        b=PmicvmMDFKoUGiDx8frPbDyBBu79BVSbrEzANolslVKIPE2RKm/TFobMD2Fa8sdxQ4
         Q7Eeyg45IFoN9qGdOmvSUE4Zkrd/u0F4URSzqlP8PkT+xxVeoqXXEsbp1unHXcku/RV5
         B/ac7jwzEvq/aMIOfdcCVX2/fXe0guvleWDfd0y9dixfUXPzrohfY1dNrYHHOwQSFEMb
         zxXv8x3tLVlkEQV1GWn/7NClT11+8kUSIUFNdzbfWOHhysMX19ConM9X7+LM940wjJ3U
         E9Y1KigTwdHGISX+b5ahmyt73mSCNKYIeF+gFiDtihMkRBDx33noCbJmK2hFkRx4nIEk
         lOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700566168; x=1701170968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsqZB3wKlZYVV/pNjJsQ4KrD2LxkGr23gZPr/fmL3q4=;
        b=nsS3w1xj83NbAFcCMfKQOWakrcD6AZXvm6a8824KqQP/T58f2GBxMnKG7hzhWvVzY+
         aKMZlo3aJqJVWx0VjD25BNTV+jFH9eaWrzAY4FyOCfWTMaYiv4A4zaqgls44cYv9aZaV
         +rx1ot4U7X9BRq9qQ+FKRKRU2HiXg7ZazSzQ1R7ZrZlP8C+TNM7GmU+KIAkSjnoOXBNJ
         COpQLM9vXE+14SS1PQSCabn5lbB2DSl8X8aZYcjVfGiEngWPuLUl/EaZWBJAnNtrZPcr
         nRbjsmnl0iHdhOSAEMQYJODGGhtR5k4aP75UzT3r8ZQGHUVsTM83QHHcZpAWbeeoAFd/
         Wn8g==
X-Gm-Message-State: AOJu0YwQOyfXgo6xuPfiE6cjOQF2tqrco8porKMfhdPhuBNOl4RX4zLm
	kGMPO5q9mcGVik2W7MHOYi4=
X-Google-Smtp-Source: AGHT+IG14dqQ3NxEFyRHe1lGtdlIOun7+h8VYtYttvDCRvmf+Cp9tCmbh7w6uimLAIvcUPq1ccn80g==
X-Received: by 2002:a17:906:104d:b0:9be:705:d7d0 with SMTP id j13-20020a170906104d00b009be0705d7d0mr6919722ejj.0.1700566168164;
        Tue, 21 Nov 2023 03:29:28 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id m8-20020a170906160800b009fad1dfe472sm3777841ejd.153.2023.11.21.03.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:29:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Nov 2023 12:29:24 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCHv3 bpf-next 5/6] selftests/bpf: Add link_info test for
 uprobe_multi link
Message-ID: <ZVyUlD8Unm0hSU54@krava>
References: <20231120145639.3179656-1-jolsa@kernel.org>
 <20231120145639.3179656-6-jolsa@kernel.org>
 <a76c9ee4-d381-477d-b7f6-19f4dc4c0b42@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76c9ee4-d381-477d-b7f6-19f4dc4c0b42@linux.dev>

On Mon, Nov 20, 2023 at 10:22:26AM -0800, Yonghong Song wrote:
> 
> On 11/20/23 9:56 AM, Jiri Olsa wrote:
> > Adding fill_link_info test for uprobe_multi link.
> > 
> > Setting up uprobes with bogus ref_ctr_offsets and cookie values
> > to test all the bpf_link_info::uprobe_multi fields.
> > 
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   .../selftests/bpf/prog_tests/fill_link_info.c | 191 ++++++++++++++++++
> >   .../selftests/bpf/progs/test_fill_link_info.c |   6 +
> >   2 files changed, 197 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > index 9294cb8d7743..fdf2c6b8c0cf 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > @@ -7,6 +7,7 @@
> >   #include <test_progs.h>
> >   #include "trace_helpers.h"
> >   #include "test_fill_link_info.skel.h"
> > +#include "bpf/libbpf_internal.h"
> >   #define TP_CAT "sched"
> >   #define TP_NAME "sched_switch"
> > @@ -300,6 +301,189 @@ static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
> >   	bpf_link__destroy(link);
> >   }
> > +/* Initialize semaphore variables so they don't end up in bss
> > + * section and we could get retrieve their offsets.
> > + */
> > +static short uprobe_link_info_sema_1 = 1;
> > +static short uprobe_link_info_sema_2 = 1;
> > +static short uprobe_link_info_sema_3 = 1;
> 
> I guess The typical sema value starting value should be 0, right?
> If this is the case, the above is not a good example.
> So the issue is that current libbpf does not support
> retrieving offset from .bss section? Do you know why?

hum, I can't recall why it was the problem, because it seems to work
with .bss now when I try it ... anyway I think your suggestion below
is better

> 
> In selftest udst.c, we have semaphore defined as
> usdt.c:unsigned short test_usdt0_semaphore SEC(".probes");
> usdt.c:unsigned short test_usdt3_semaphore SEC(".probes");
> usdt.c:unsigned short test_usdt12_semaphore SEC(".probes");
> 
> Will the following work?
> static short uprobe_link_info_sema_1 SEC(".probes");

yes, that will work and it's better

> ...
> 
> > +
> > +noinline void uprobe_link_info_func_1(void)
> > +{
> > +	uprobe_link_info_sema_1++;
> > +	asm volatile ("");
> 
> The 'asm volatile' above intends to prevent compiler from
> doing 'implicit' inlining. So as a convention let us
> switch statement order to
> 
> 	asm volatile ("");
> 	uprobe_link_info_sema_1++;
> 
> Similarly for below.

ok

SNIP

> > +static void test_uprobe_multi_fill_link_info(struct test_fill_link_info *skel,
> > +					     bool retprobe, bool invalid)
> > +{
> > +	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
> > +		.retprobe = retprobe,
> > +	);
> > +	const char *syms[3] = {
> > +		"uprobe_link_info_func_1",
> > +		"uprobe_link_info_func_2",
> > +		"uprobe_link_info_func_3",
> > +	};
> > +	__u64 cookies[3] = {
> > +		0xdead,
> > +		0xbeef,
> > +		0xcafe,
> > +	};
> > +	const char *sema[3] = {
> > +		"uprobe_link_info_sema_1",
> > +		"uprobe_link_info_sema_2",
> > +		"uprobe_link_info_sema_3",
> > +	};
> > +	__u64 *offsets, *ref_ctr_offsets;
> > +	struct bpf_link *link;
> > +	int link_fd, err;
> > +
> > +	err = elf_resolve_syms_offsets("/proc/self/exe", 3, sema,
> > +				       (unsigned long **) &ref_ctr_offsets, STT_OBJECT);
> > +	if (!ASSERT_OK(err, "elf_resolve_syms_offsets_object"))
> > +		return;
> > +
> > +	err = elf_resolve_syms_offsets("/proc/self/exe", 3, syms,
> > +				       (unsigned long **) &offsets, STT_FUNC);
> > +	if (!ASSERT_OK(err, "elf_resolve_syms_offsets_func"))
> > +		return;
> 
> potential leak of ref_ctr_offsets?

ugh yep, will fix

> 
> > +
> > +	opts.syms = syms;
> > +	opts.cookies = &cookies[0];
> > +	opts.ref_ctr_offsets = (unsigned long *) &ref_ctr_offsets[0];
> > +	opts.cnt = ARRAY_SIZE(syms);
> > +
> > +	link = bpf_program__attach_uprobe_multi(skel->progs.umulti_run, 0,
> > +						"/proc/self/exe", NULL, &opts);
> > +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
> > +		goto out;
> > +
> > +	link_fd = bpf_link__fd(link);
> > +	if (invalid)
> > +		verify_umulti_invalid_user_buffer(link_fd);
> > +	else
> > +		verify_umulti_link_info(link_fd, retprobe, offsets, cookies, ref_ctr_offsets);
> > +
> > +	bpf_link__destroy(link);
> > +out:
> > +	free(offsets);
> 
> Should we free ref_ctr_offsets here?

yes, thanks

jirka

