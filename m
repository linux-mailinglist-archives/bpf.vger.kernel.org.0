Return-Path: <bpf+bounces-31021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E9A8D60C9
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 13:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D35A1F2409E
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5005E15749C;
	Fri, 31 May 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMfBjKbd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2CF8173C;
	Fri, 31 May 2024 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155412; cv=none; b=Sj9Mc4lUrAWNHV+EkVK7gECE5kbFLiC3x+vkumX7jHBMTZmtI2O8BxNkUzFUwbNldwY3DDkzNHJiItQsuA2F8Sw8fR5peotS8CgIT9TQb6C/jS3KXbyLE5izXcG7zfdDxayyFwNKSa8e9a94/5T/5cdMwjq9aZKqrz17lwSA8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155412; c=relaxed/simple;
	bh=4pt/ntQgy+9ouCnkU4dRCLli7YyHlhizdbLEjK+RBO0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q90kTIb0xQRiv4Qrm+d8Lp5yGMMeuA0EFt1LU375KttQ6ElIKtoUKNqjc5sMMBWeslEhW6F0tH17pfkmPwU5337gwZDYGMzerJyoUTI17UZ2O9gtKoKEYr9+l8rN9Hl+K2Ir2iO/T6bEvWe7XWZYZkURKdKuC9Xs4cp22cq0Mns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMfBjKbd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f4603237e0so1408504b3a.0;
        Fri, 31 May 2024 04:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717155411; x=1717760211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cqQbkg+UnvnDMzuBbdOMpqyzkYCmRES1MoGBDqmMuhM=;
        b=iMfBjKbdkEVfJ7Ug9zcl3sV1S7WFjDN0Cew+abgNFzb+45XhdRzYuMGDsKgAbtJsUf
         ZVC4IVjYCUNMxupx3l9n+t6AYdvndajD20QgizkzOMbGnUCC+xoy0rgt6XFPpkOthJcr
         /XJ1PmZ/um3qdw9X+8Y+i16eFIq5JFcL8VO2zT/okCOHiaV/j4sof9yZdHmS60uZJGIJ
         /j+m/rwNGcDAoWbJZ7AoYmTHzCjMNlyTqyM8p+irFjS9SU5ctKl+ZaQZkMBA4F3wdcR/
         DbPrm+ADmJR5iW566zLNuJQhmk2c6OPCY1lj5ShPZ/1hywZdRXmmgamX3GZDK4WHcOXL
         bNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717155411; x=1717760211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqQbkg+UnvnDMzuBbdOMpqyzkYCmRES1MoGBDqmMuhM=;
        b=QD9CFWL9YDoXB/WgIcQFuePhVHbBG/bFLHwlRxtUloZsSx5kDe1JGAu6YeJSLJH1C2
         s7rNJPiCmvtwITpaEVoR3gR3PkxVBBe0369/3CwTYgO44rHrjvvWTK5dZaB+NLmz+GRr
         rmshRLyQeldpxeXZE0ccz/82n8eucxkea1XYrJAaom0oWhTAyEVIlN7xma2LAgab4USJ
         XEM5iAH1apsz4f5p8Lr0YvJOBsrHDnwPCQSFXgeTx10pSo60Kg0hTavAT1XFvtvo7/0N
         FPBp2fO7Q2w0IHKnis2VT0+OKkb9kgQ0JreCk0HFj541fSgYPh8aglrMADJMHf3rP2Ih
         xfsg==
X-Forwarded-Encrypted: i=1; AJvYcCVwu9wqOv7OKbkpuYkKxrz/Tr8aWQJ+b96no7lFfKK72P4kvyEgEIlKhNI4XFYz6q89fpEA0MOHHrWvBKk+hdBJRL1MGL/ScWpBnmxJP/y+20YvNhPtoBQ9XAjEuQ==
X-Gm-Message-State: AOJu0Yxka8bjyqigJj9loOjkoiaDrq0RNEaYqcIJ4aaa0qcE4rtRkscx
	F3CS8qmUBpC41+Nj/XsRcvPNSClAXQIJSBrT50ZPfCHBymnICLCB
X-Google-Smtp-Source: AGHT+IGvldR99aAPPEttw+4i16ZFBQAacU78QzJruLmJj0x7c8egZ7U9DucREMnleF6KvbTT33WS5Q==
X-Received: by 2002:a05:6a00:6701:b0:6ed:825b:30c0 with SMTP id d2e1a72fcca58-70231b19bd9mr6292656b3a.15.1717155410529;
        Fri, 31 May 2024 04:36:50 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242ae8a28sm1203225b3a.122.2024.05.31.04.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 04:36:50 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 31 May 2024 04:36:48 -0700
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Problem with BTF generation on mips64el
Message-ID: <Zlm2UNWHrGtRROGS@kodidev-ubuntu>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmGoT9KiYLZd91S@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlmGoT9KiYLZd91S@krava>

Hi Jiri,

On Fri, May 31, 2024 at 10:13:21AM +0200, Jiri Olsa wrote:
> On Fri, May 31, 2024 at 10:17:53AM +0800, Hengqi Chen wrote:
> > Hi Tony,
> > 
> > On Fri, May 31, 2024 at 9:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > For some time now I'm seeing multiple issues during BTF generation while
> > > building recent kernels targeting mips64el, and would appreciate some help
> > > to understand and fix the problems.
> > >
> > > Some relate to resolve_btfids:
> > >
> > > >   LD      vmlinux
> > > >   BTFIDS  vmlinux
> > > > WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
> > > > WARN: resolve_btfids: unresolved symbol bpf_session_cookie
> > > > WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> > > > WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> > > > WARN: resolve_btfids: unresolved symbol bpf_key_put
> > > > WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
> > > > WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
> > > > WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
> > > > WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
> > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
> > > > WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
> > > >   NM      System.map
> > > >   SORTTAB vmlinux
> > > >   OBJCOPY vmlinux.32
> > >
> > > These do not appear to be #ifdef-related and have similar past reports [1].
> 
> I can reproduce the warning just for bpf_session_cookie,
> which has fix in progress:
>   https://lore.kernel.org/bpf/20240531071557.MvfIqkn7@linutronix.de/T/#t

I gather there are different root causes for these warnings. From the link,
the issue with bpf_session_cookie seems related to conditional compilation,
which have come up before on the mailing list IIRC.

In comparison, consider my above warning for bpf_key_put, which is defined
in kernel/trace/bpf_trace.c. This kfunc is guarded by CONFIG_KEY, which is
enabled in my config and so not the issue. I can in fact see the global
text symbol for bpf_key_put in bpf_trace.o, but not in vmlinux.

So I suspect the warnings might come from linker or optimization problems,
or perhaps even an issue related to the __bpf_kfunc annotation. WDYT?

> 
> > >
> > > I also see many pahole failures during BTF encoding of modules, such as:
> > >
> > > >   CC [M]  net/ipv6/netfilter/nft_fib_ipv6.mod.o
> > > >   CC [M]  net/ipv6/netfilter/ip6t_REJECT.mod.o
> > > >   CC [M]  net/psample/psample.mod.o
> > > >   LD [M]  crypto/cmac.ko
> > > >   BTF [M] crypto/cmac.ko
> > > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > > or DW_TAG_skeleton_unit expected got member (0xd)!
> > 
> > The issue seems to be related to elfutils. Have you tried build from
> > the latest elfutils source ?
> > I saw the latest MIPS backend in elfutils already implemented the
> > reloc_simple_type hook.
> 
> hi,
> +1, could you also check the pahole version you used?

No luck I'm afraid with using the latest elfutils as suggested.

I used pahole v1.26 in my original testing for this bug report, as noted
below (might have been buried a bit).

> 
> jirka
> 
> SNIP
>
> > > Details of the git commit and build environment are as follows:
> > >
> > > > $ git log -1 --oneline  bpf/master
> > > > 9dfdb706e164 (bpf/master) selftests/bpf: fix inet_csk_accept prototype in
> > > > test_sk_storage_tracing.c
> > > >
> > > > $ lsb_release -a
> > > > Description:    Ubuntu 22.04.4 LTS
> > > >
> > > > $ cat gcc-compile.txt
> > > > ARCH=mips CROSS_COMPILE=mips64el-linux-gnuabi64- CC="ccache ${CROSS_COMPILE}gcc" make -j6
> > > >
> > > > $ mips64el-linux-gnuabi64-gcc --version
> > > > mips64el-linux-gnuabi64-gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0
> > > >
> > > > $ mips64el-linux-gnuabi64-ld --version
> > > > GNU ld (GNU Binutils for Ubuntu) 2.38
> > > >
> > > > $ pahole --version
> > > > v1.26
> 
> SNIP
>
> > > I'd be grateful if some of the BTF/pahole experts could please review this
> > > issue and share next steps or other details I might provide.
> > >
> > > Thanks,
> > > Tony Ambardar
> > >
> > > Link: https://lore.kernel.org/all/202401211357.OCX9yllM-lkp@intel.com/ [1]
> > > Link: https://github.com/acmel/dwarves/issues/45 [2]
> > 
> > Cheers,
> > Hengqi

Thanks,
Tony

