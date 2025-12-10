Return-Path: <bpf+bounces-76384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CAECB1C96
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 04:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EE55300A6C2
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 03:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FED2DE701;
	Wed, 10 Dec 2025 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxWHWXav"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC992DEA9E
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 03:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765336754; cv=none; b=aa3KVQIhexxAspSYJv1n4iT7wJIRhmTh1qrbS67fW+gPk74Blo4B9Hj6C9qDOh2pPhGvDzvZ27BkRSF0CuUEEBCV8rruBES+9r4oN5UE45dgEqPwjCD8ZlVulNzNiFP1PWsD41P3LzB1PEGujRQfnZ9t1eH2j451Y2bzjxOxm2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765336754; c=relaxed/simple;
	bh=evoUvJX3mCaBFKhhUFDNjpUyx+VmfYnpIDuiz83BXvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puM5Ls7q+yhMfZ55H5H32Z8/prw2QfDbUBlmJa+eGuxX5XUHxc7l537V2j94fKrf3/jnVeo3kXkHY3nlTL2Q/xsl10Isc9V5GHCKSKhP8kBLb5EY5HrBCZiBpXpiHjLik08QCV+wWtqFB7b8aQw2K5KEplhhb4o3SyacCdGasUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxWHWXav; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee05b2b1beso56974961cf.2
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 19:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765336747; x=1765941547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvcgHHodDEFd6JoOhmN+IKolu8SaPqo8wA5oF6Yaspk=;
        b=SxWHWXavbfedug/m2MK7VfTnmQZrfWggyLQkfU5XT+soO/V3IqLpsCOsucI3YKiy9k
         Sd+6d1Rf6i80dPwaI3/rVJMBAy/q0bKHN25JeiRfJwbG0dbEJA6GWfkDk6btAKYYeCWx
         yv4kVxWeSC01Lf6v9JpSs9BzBMyp9vJ4x064My66w4hSvcUULf6lEqCBtXgjADy8zOQt
         7juH1SIsG6+7JxUsIPINS0YUfuXCK8QOxEm9kVivPYD3PXFZxGynUciMXuUTCdJ7pmo3
         XokWUsMiQr862KywU6vrLfyndZkiIJ6TAdcZJIWtAvqFuRKcyPjkFWW/ccpe+/rsLkVF
         s9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765336747; x=1765941547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DvcgHHodDEFd6JoOhmN+IKolu8SaPqo8wA5oF6Yaspk=;
        b=FvDPuCu2Q39XxpJax/upXpYlcDy+P8XA3FhsZCgxp0ocUUZF1gErn1psYKuvimsY5X
         TUk+xMq2Jhgm5+mAFUW8sK+BaxXN/OTLFdTSNm6nvRjKiIsl6wdASIljZ4PM4tYM2kVx
         7o8hz+1P9VJIR35Ce3/wGIWG4EIFJVlsgp02RCFd/xcqlX4qvde6ZdF4CUwAQazdc5WJ
         mAGp8QD0DJtND/CFD8vF29n6+ST/Efmz7QzQ0Zy5opk8rKgDKRiyEqXfoECCZLuiVtrH
         IHszS1nFjPGwbF9aT6BsPDnB5zdGaa51AEq1OClhsH/WTyPETi8eNkNFb6Q1t4Mv69xK
         L5oA==
X-Forwarded-Encrypted: i=1; AJvYcCWEBDD6x05Q+IrgqYRjFW/FCLF9Y7J1g0buGLMqkzfo66jTYK71q8/ZjuoXg+DESanksKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqs9olIKrPoIaXani3ld6ctxdXVK2WEFp+lyq7Xnrf09Z9oqGi
	ovbsE6CSKRevgve3WtjcbCRbzompeqdfnxbgHiKEnN+PPRHlw6fvyqOFt7PI3sNkzReRSt/r41b
	DZSGYG3CnPa4HIUGAQq40HzPcT8DBnEk=
X-Gm-Gg: ASbGncsmpd8jeEUTRaAYQNnI6fdVQLoa1VN0rdzKYGhtMpg7WNdtXmJK2Tsk+0xlK7z
	GvFg8/docDUBQezn71y/ZnYHUQU+H2CSbQYtkn9FKJtZYmO4PVsJyG2zUQcCfHcWM90tQNMB8lP
	p6wRJm8NtwjMREMhz6za+xRswuxhzt3MLVRdGZBcnCAW7jwcbrdZ4RuGToF1RQrEDgap9scDLqE
	ecrFj0eyTgLs4LYKAgluCgTihJnorGHo3jviY450cJ5YcZSoNDMoKZlUHn55zU1FUdkmYY=
X-Google-Smtp-Source: AGHT+IGBnSmzUgYawZmR+V//pPBfELnwqY9lW1v+I/si5q6dRzYyvn2rhIv+AT6zhwiOlcl9i+TimiXcnFd7GV3qYiU=
X-Received: by 2002:ac8:7d4f:0:b0:4ee:278c:bde7 with SMTP id
 d75a77b69052e-4f1b1a69a8cmr15106221cf.23.1765336746807; Tue, 09 Dec 2025
 19:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209093405.1309253-1-duanchenghao@kylinos.cn>
In-Reply-To: <20251209093405.1309253-1-duanchenghao@kylinos.cn>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Tue, 9 Dec 2025 19:18:55 -0800
X-Gm-Features: AQt7F2oQPRpKIN1N4cR6kx_h0cVRsq7QdpgOk5f88rMTJyv9px4Be-ii8HcE99w
Message-ID: <CAK3+h2xZEvYdgG=PsmPa+tu-f9zhac+E0s5Um+rPF0cX7uSnuQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Fix the failure issue of the module_attach test case
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: yangtiezhu@loongson.cn, hengqi.chen@gmail.com, chenhuacai@kernel.org, 
	kernel@xen0n.name, zhangtianyang@loongson.cn, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 1:34=E2=80=AFAM Chenghao Duan <duanchenghao@kylinos.=
cn> wrote:
>
> The following test cases under the tools/testing/selftests/bpf/
> directory have passed the test=EF=BC=9A
>
> ./test_progs -t module_attach
> ./test_progs -t module_fentry_shadow
> ./test_progs -t subprogs
> ./test_progs -t subprogs_extable
> ./test_progs -t tailcalls
> ./test_progs -t struct_ops -d struct_ops_multi_pages
> ./test_progs -t fexit_bpf2bpf
> ./test_progs -t fexit_stress
> ./test_progs -t module_fentry_shadow
> ./test_progs -t fentry_test/fentry
> ./test_progs -t fexit_test/fexit
> ./test_progs -t fentry_fexit
> ./test_progs -t modify_return
> ./test_progs -t fexit_sleep
> ./test_progs -t test_overhead
> ./test_progs -t trampoline_count
>

Tested-by: Vincent Li <vincent.mc.li@gmail.com>

I tested above  and all passed OK, but I could not complete the full
bpf selftests because test_progs core dumped, don't think it is
related to your patch series.

./test_progs --deny=3Dtimer_lockup
...SNIP...
test_task_local_data_basic_thread:FAIL:tld_get_data unexpected error: -12
test_task_local_data_basic:PASS:pthread_create 0 nsec
test_task_local_data_basic_thread:FAIL:tld_get_data unexpected error: -12
test_task_local_data_basic:PASS:pthread_create 0 nsec
test_task_local_data_basic_thread:FAIL:tld_get_data unexpected error: -12
test_task_local_data_basic:PASS:pthread_create 0 nsec
test_task_local_data_basic_thread:FAIL:tld_get_data unexpected error: -12
test_task_local_data_basic:PASS:pthread_create 0 nsec
test_task_local_data_basic_thread:FAIL:tld_get_data unexpected error: -12
test_task_local_data_basic:PASS:pthread_create 0 nsec
test_task_local_data_basic_thread:FAIL:tld_get_data unexpected error: -12
test_task_local_data_basic:PASS:pthread_create 0 nsec
test_task_local_data_basic_thread:FAIL:tld_get_data unexpected error: -12
#444/1   task_local_data/task_local_data_basic:FAIL
test_task_local_data_race:PASS:skel_open_and_load 0 nsec
test_task_local_data_race:PASS:calloc tld_keys 0 nsec
test_task_local_data_race:PASS:TLD_DEFINE_KEY 0 nsec
test_task_local_data_race:FAIL:265
#444/2   task_local_data/task_local_data_race:FAIL
#444     task_local_data:FAIL
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x28)[0x1205b74ac]
linux-vdso.so.1(__vdso_rt_sigreturn+0x0)[0x7ffffffc1084]
./test_progs[0x1204eb064]
./test_progs(test_task_local_data+0x40)[0x1204eb3f8]
./test_progs[0x1205b7bec]
./test_progs(main+0x6c0)[0x1205b9c70]
/lib64/libc.so.6(+0x2882c)[0x7ffff2f6082c]
/lib64/libc.so.6(__libc_start_main+0xa8)[0x7ffff2f60918]
./test_progs(_start+0x48)[0x12013a0c0]
Segmentation fault (core dumped)

> Chenghao Duan (2):
>   LoongArch: Modify the jump logic of the trampoline
>   LoongArch: BPF: Enable BPF exception fixup for specific ADE subcode
>
>  arch/loongarch/kernel/mcount_dyn.S          | 14 +++++---
>  arch/loongarch/kernel/traps.c               |  7 +++-
>  arch/loongarch/net/bpf_jit.c                | 37 +++++++++++++++------
>  samples/ftrace/ftrace-direct-modify.c       |  8 ++---
>  samples/ftrace/ftrace-direct-multi-modify.c |  8 ++---
>  samples/ftrace/ftrace-direct-multi.c        |  4 +--
>  samples/ftrace/ftrace-direct-too.c          |  4 +--
>  samples/ftrace/ftrace-direct.c              |  4 +--
>  8 files changed, 56 insertions(+), 30 deletions(-)
>
> --
> 2.25.1
>

