Return-Path: <bpf+bounces-38011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C095E05F
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 01:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DD51C20CDA
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 23:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D77142652;
	Sat, 24 Aug 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egPzrHz5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390813C809;
	Sat, 24 Aug 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724541695; cv=none; b=RElTJvTPvoDtd7P0vbe36wjWNAzHhRsn3TWoBMuwzU9gFZPLpqyDU+WH9nLKGvJvveGjYwUoX2nOVEzoxjGgNg4grjg0bDmnxFNMkRXGXq9TdotscJp1eLyjAkAwmEhgCYYjJmk3TrsjHXLe7pD21FNqOzA/DnufldkHRcl4SkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724541695; c=relaxed/simple;
	bh=W/WcOeQpPEmunvrdDhNitjqy32TMzG49sI7jExIuEcM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcluwjRlGmJLpQhEtAlYekS8JbjBwrfv0UOIMmHcRRo7v2ff7HbB9KX3pdVgK4LgnScOhjHrhBesNLTe5uJeJYu6rH9PIY8cLbP3A79kFsQHNumc92Z2hjpl5w6oHYooXGtb6/Et51vqT8XNFbxISPcSXt4GqW4Jj6KVa4KHyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egPzrHz5; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39d4161c398so13143635ab.3;
        Sat, 24 Aug 2024 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724541692; x=1725146492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Tmq+UU0sA2SGlzZYXprDD9mtGBC22vjFkL/LTayqLA=;
        b=egPzrHz57B/8fyjWn9duFW1XXOOYhPWAKzNaaPm0eOv+rkx4+klisfKMUmnCZvkech
         JsKIOPyj8zzzuDsJ6umgCTDirre3B2wN6ZvN/7Ecvoq0QW49O6wbT6DaZu7QSM5QE1ta
         WRB46RUsWZkjOGtBwmgdPx7TDi4k1bsCRBFH5ZipdxVR3+y+lfCjIZoQjxNkDolLoYrP
         VGKjcrweziVhapRnv34GfYtTdkCK6v9/4Z5wWWp4vUO+5c4AlP9Q0M/0u01p9Mg/GFeE
         p5noW2VtK7pbHji3ksU4gNgnzTzeIzPEd120S7PJ0izmS7VbT9crUD1gXde98A+pn78q
         2sHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724541692; x=1725146492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Tmq+UU0sA2SGlzZYXprDD9mtGBC22vjFkL/LTayqLA=;
        b=RnKPQtNcrp0z5Loj89/DTbUxuBeZVYQLv01xY7I40yjZkxEsqLRild99vVEn0mMQGp
         8MANKzEOV0f4FbdrWDdX6/ePjkVWeT1FcIkjvaTkdpcMtTVDSA64MTx/aiQlTCybnCCS
         klGdDBC0Z3/j905vM2yGU+noCWxXOQDoSptb+ljxrlEZDVjPzydtakt1i6tNh3eblctb
         3izmYGMu6PH02GjlkoFdxioaig1RKZ8JYRmCai0X7c6ZxPhPoWOzvggYbaIzFSNgr2QR
         CHkWNJ0TutdUYicj5jLGzfnTFKou+OYrZ88RrVCkQ5hTtcxdmQyRw6dWuLHsuECGqz7g
         7R9g==
X-Forwarded-Encrypted: i=1; AJvYcCXFifVRTLbwcWJG4bbRJxlWAnj76aNpB46PowfESKltjewfcA9rYcBwpw9pJ8B9sHa4gtT2/3A6TBsC@vger.kernel.org
X-Gm-Message-State: AOJu0YzPM3K8mF5HIQf+E0sFirjBc80z4f2NzFPJuu9mm64NzD4JZ1PF
	xt5dJwB7mc1/RgvMTJSdNz6kUT+1YnO/H84QhvYqCUZbpOUdiXYR
X-Google-Smtp-Source: AGHT+IF2XS4wyftc4M73YpCByrmApTDQfKepJBYOrYtCUJ8UX40muwnsijnbov7r6FP63fbC42Vs6A==
X-Received: by 2002:a05:6e02:154a:b0:39d:28b4:2514 with SMTP id e9e14a558f8ab-39e3c9854c4mr75885395ab.10.1724541692497;
        Sat, 24 Aug 2024 16:21:32 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203b01b4d47sm16843775ad.258.2024.08.24.16.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 16:21:31 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Sat, 24 Aug 2024 16:21:29 -0700
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org, llvm@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: Problem testing with S390x under QEMU on x86_64
Message-ID: <Zspq+db1KOhhh2Yf@kodidev-ubuntu>
References: <ZsEcsaa3juxxQBUf@kodidev-ubuntu>
 <180f4c27ebfb954d6b0fd2303c9fb7d5f21dae04.camel@linux.ibm.com>
 <ZsU3GdK5t6KEOr0g@kodidev-ubuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsU3GdK5t6KEOr0g@kodidev-ubuntu>

On Tue, Aug 20, 2024 at 05:38:49PM -0700, Tony Ambardar wrote:
> 
> Hi Ilya,
> 
> Thanks for following up. As it happens, I did this the day before out of
> desperation after trying various kernel config and rootfs changes
> with no luck, and can confirm the system runs faster and without the
> kernel crashes noted above. Certainly the latest QEMU seems mandatory.
> 
> The good news is that 99% of tests with my cross-compiled test_progs
> work as expected out of the box, and some of the failing ones helped
> troubleshoot a few hidden libbpf issues. I'll outline the remaining
> failures for your feedback and comparison with native-built tests.
> 
> I used the command line:
>     ./test_progs -d get_stack_raw_tp,stacktrace_build_id,verifier_iterating_callbacks,tailcalls
> 

[snip]

> Aside from the tests above, I see only 3 failing tests:
> 
> All error logs:
> test_map_ptr:PASS:skel_open 0 nsec
> test_map_ptr:FAIL:skel_load unexpected error: -22 (errno 22)
> #165     map_ptr:FAIL
> subtest_userns:PASS:socketpair 0 nsec
> subtest_userns:PASS:fork 0 nsec
> recvfd:PASS:recvmsg 0 nsec
> recvfd:PASS:cmsg_null 0 nsec
> recvfd:PASS:cmsg_len 0 nsec
> recvfd:PASS:cmsg_level 0 nsec
> recvfd:PASS:cmsg_type 0 nsec
> parent:PASS:recv_bpffs_fd 0 nsec
> materialize_bpffs_fd:PASS:fs_cfg_cmds 0 nsec
> materialize_bpffs_fd:PASS:fs_cfg_maps 0 nsec
> materialize_bpffs_fd:PASS:fs_cfg_progs 0 nsec
> materialize_bpffs_fd:PASS:fs_cfg_attachs 0 nsec
> parent:PASS:materialize_bpffs_fd 0 nsec
> sendfd:PASS:sendmsg 0 nsec
> parent:PASS:send_mnt_fd 0 nsec
> recvfd:PASS:recvmsg 0 nsec
> recvfd:PASS:cmsg_null 0 nsec
> recvfd:PASS:cmsg_len 0 nsec
> recvfd:PASS:cmsg_level 0 nsec
> recvfd:PASS:cmsg_type 0 nsec
> parent:PASS:recv_token_fd 0 nsec
> parent:FAIL:waitpid_child unexpected error: 22 (errno 3)
> #402/9   token/obj_priv_implicit_token_envvar:FAIL
> #402     token:FAIL
> libbpf: prog 'on_event': BPF program load failed: Bad address
> libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
> The sequence of 8193 jumps is too complex.
> verification time 2816240 usec
> stack depth 360
> processed 116096 insns (limit 1000000) max_states_per_insn 1 total_states 5061 peak_states 5061 mark_read 2540
> -- END PROG LOAD LOG --
> libbpf: prog 'on_event': failed to load: -14
> libbpf: failed to load object 'pyperf600.bpf.o'
> scale_test:FAIL:expect_success unexpected error: -14 (errno 14)
> #525     verif_scale_pyperf600:FAIL
> Summary: 559/4166 PASSED, 98 SKIPPED, 3 FAILED
> 

Hi Ilya,

A brief update with some good news: the 3 test failures above have been
resolved and all expected tests now pass on QEMU/s390x under x86_64.

Test '#165 map_ptr:FAIL' was a bug in my light-skeleton code, and fixed in
my patch series v2:
https://lore.kernel.org/bpf/cover.1724313164.git.tony.ambardar@gmail.com/

Test '#402/9 token/obj_priv_implicit_token_envvar:FAIL' was a problem in my
rootfs configuration and now passes after resolving.

Test '#525 verif_scale_pyperf600:FAIL' was caused by clang miscompilation
exposed by my use of clang-19 and clang-20. The test passes when built
with clang-17 (used by BPF CI) or clang-18 which I switched to use.

One symptom of the problem is easily seen by manually compiling:

$ clang-18  -g -Wall -Werror -D__TARGET_ARCH_s390 -mbig-endian -Itools/testing/selftests/bpf/tools/include -Itools/testing/selftests/bpf -Itools/include/uapi -Itools/testing/selftests/usr/include -Wno-compare-distinct-pointer-types -idirafter /usr/lib/llvm-18/lib/clang/18/include -idirafter /usr/local/include -idirafter /usr/lib/gcc-cross/s390x-linux-gnu/11/../../../../s390x-linux-gnu/include -idirafter /usr/include/s390x-linux-gnu -idirafter /usr/include -DENABLE_ATOMICS_TESTS -O2 --target=bpfeb -c tools/testing/selftests/bpf/progs/pyperf600.c -mcpu=v3 -o pyperf600.clang18.bpf.o

$ clang-19  -g -Wall -Werror -D__TARGET_ARCH_s390 -mbig-endian -Itools/testing/selftests/bpf/tools/include -Itools/testing/selftests/bpf -Itools/include/uapi -Itools/testing/selftests/usr/include -Wno-compare-distinct-pointer-types -idirafter /usr/lib/llvm-19/lib/clang/19/include -idirafter /usr/local/include -idirafter /usr/lib/gcc-cross/s390x-linux-gnu/11/../../../../s390x-linux-gnu/include -idirafter /usr/include/s390x-linux-gnu -idirafter /usr/include -DENABLE_ATOMICS_TESTS -O2 --target=bpfeb -c tools/testing/selftests/bpf/progs/pyperf600.c -mcpu=v3 -o pyperf600.clang19.bpf.o

$ llvm-readelf-18 -S pyperf600.clang{18,19}.bpf.o |grep .symtab
  [27] .symtab           SYMTAB          0000000000000000 1739d0 01ad60 18      1 4572  8
  [27] .symtab           SYMTAB          0000000000000000 14f048 0001e0 18      1  12  8

Notice that the .symtab has shrunk by ~200X for example going to clang-19!
(CCing llvm maintainers)


Kind regards,
Tony

