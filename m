Return-Path: <bpf+bounces-79149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4819CD28804
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 21:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62FDB30AA006
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111C12E090B;
	Thu, 15 Jan 2026 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBuKKmZZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E44324B1B
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768509911; cv=pass; b=hHtNLSCrr5b7T28aC2pVecaWJfLlByvI579GhRupu7Y8Hwh1pD5WvK9ixHwnNBZAKN+66BSMwotHIBoyITz5WMu/t2ImURGD+p2hyIGYVN9q302+nP8sVYslZPaYiAFEDdexEt5F7mdnpERE6yF/fTVwXNPzU/hF37qPgsrS+tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768509911; c=relaxed/simple;
	bh=tcBF4nuTdaJWQaR42nPx3uzp8aSI/YG/w0GCulHFaoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyuoMh0xIeUnKZ0DAUB43wjnIQXT6CX/U8jRO6HbGQg62ld89gQVohuR4aPq6IsnIYKPHFDyoGkPkUs/LoOmiEz1P83KoR9SnNHUg+J15AV4+EZgp3HdB2eFVz4oig2eD5Xb9FoDpYfLwoKay8A9whscl3mCwb2F10Wok8Qgeyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBuKKmZZ; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-501488a12cbso14294501cf.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 12:45:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768509908; cv=none;
        d=google.com; s=arc-20240605;
        b=LysuljvrlRAXwFl/6tpNXCBqG4YHO95keXuI0o0e0ktks7FcCf1FyX89lzQcm/zL54
         e1L/jMwyYD6FWwB0Dnjymh9VifK+pMPmBqdjwvkjOX/pB9fNjPxdYANOU/NLxnJVWVPQ
         cvGrKLsglNUzCKZeVBuq7h7prlWE62OmfvdKFXDd7tqWxUlqFwwz2FwNYYr/1Ht/wmtQ
         dusW9a9/FEm4oNOwFEvrEmo7IQsfgDoPprtMrmI1uo6p2Wh2o8u/t2mlzGRyROH8E3U+
         Y09zTeHKIYaweQhw22TF2Y6oMkGxxWHadT0tCMS5flwlXJQrEpaVFVzKXfojpmAukGAZ
         aY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x9DEwRAP+sPbYYatTSTzERFwiaou/pYxLbvlBBsfRQc=;
        fh=LY7oqBy5mWCE9MF2YkNybZz+q0ciHzqtVEXL2CWoGDw=;
        b=TJOx164XSeENoR7yCDJDoAbT78drJehpWMpocwrkXnUJMt712WsvHAqfis1O6MLLyY
         x0VVdDWUUfN9y81azmpYnkk9An/i40tuQ/xmDbVTakDXMoZxHOb8RW+RNv+iNIpWr9do
         1k8ApjaKe/ouiftvBBVyi7TXgRJc9pOMt0G3G2nF8bi+j3w0XwVAlQwLwXXbWVy48Q6U
         6kEsih6aqqbxNZUfYjsyHyjjBxcMsdFxBASz62zcWcWQ1g4eMIdnePlOx6dMWgSnDxEX
         akmr9uPzN/mApaLTRXyQGFnQxWsy5ySlEsd6CSUP3ak5a2s2amqUMc2gmzQMoNgzCI+L
         ccVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768509908; x=1769114708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9DEwRAP+sPbYYatTSTzERFwiaou/pYxLbvlBBsfRQc=;
        b=bBuKKmZZP772gozflj6kDvwAf1HpecxXghJkvdFTmFb8mJE8c0774HX7gURhcKwKRC
         IB2r2aMiWocRvJLzdxHVAktajpPmeDd1Tq8LcGXA8GZsUjWdUwKGzCzOZ1hvpIDW1Mdx
         OpNqr5iIUfU+EjkxBY/AK9MkbrqrYg8GqeeQb8u0yVU7S3uFFyzdBSnw9XjitcRZCR52
         HTjAdc98Y7BGf97fFhG3s3B5JJYr0GKL168fqfrJ5WL6aCb3gbZZqVYD5GqbXsZwL5kx
         +7AVjXXhvfFOYtA1CAnOqYIlKGNCfXyuO2S7YecZO8bHUDYHKsmFZKfdI6v+eol1hcG/
         YUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768509908; x=1769114708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x9DEwRAP+sPbYYatTSTzERFwiaou/pYxLbvlBBsfRQc=;
        b=j5/vkgIDz0rMgJj4oTnuymKu6bEBNLLsDT3iEwMYLEvg37KjnVFT/Kjl905FAWDZ/e
         eynCe/Cr/unDwMKusifLbtMUAFtXoYyTF3zrZZ6O+EBSDLTMKshQmbKaZXdAAZdddRFA
         MbOryRYReM3uXtGgfNQN3TggPyLpwSoqg+09kuZhShLhSV/nRiomzh6Jb2bJsHopgHyr
         IaaR3pN/f6mG8VstisbDMZM/qq08Yjb5XGONKnyBe5s98L/6dPBR5zbQj3I6aQg41w4O
         UoUBqpttzIhkWKzMTYkqhPQw7D+bWISW8Q/0/KajZDhiWSQeM9yK0cYiUBA1f0cLTRvw
         RdFQ==
X-Gm-Message-State: AOJu0YyAy8vUXj/zuFFN4AOrhHWu9UNVce/6hbfU9JPCj1y+SPeXgcrr
	Sw+5stAFDfw5K72aZmaseCVW84tZjgTXqgqMQL2HQqnVFnUkfzM7s+dRmOZcBr5J+aQkPlLg+Tq
	MUGyMlCvSy2r4+k34usVM1feZn+U/ZLE=
X-Gm-Gg: AY/fxX7SPbXbCG02mg2BTaI568wbkRetUlkLk2NW8h0+6FLroNnnmiEUk10PlUBzIZK
	KdxZorjTuD6IrBbKkBFaeNCihJauI+CXO6nLdjqSKXJ5ssOHxoOBjle9DtSs7PNGN18CbOSvp01
	0gN2y8h2obONdCa1L0CWh4Um+Q0Gb8FXQG7vXYf434fZUDimQMAYBx4lFXbO6u19GmFqrkQ+2gs
	ulzEK+EsChBJxpX2/uxTjAo5un3w0PKFXEKZFWECP+NzjU469PdQkxHj+kUIIxlBKLEV5E=
X-Received: by 2002:a05:622a:134a:b0:501:4528:27ca with SMTP id
 d75a77b69052e-502a1714fbamr12445591cf.51.1768509908001; Thu, 15 Jan 2026
 12:45:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2yu+XkEMWz6FOHiDEEQw-G_iKG2KHP=F=1CiqLr0mCgNA@mail.gmail.com>
 <d299d7ba-4e9e-5b16-5aa4-898b62330c24@loongson.cn>
In-Reply-To: <d299d7ba-4e9e-5b16-5aa4-898b62330c24@loongson.cn>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 15 Jan 2026 12:44:56 -0800
X-Gm-Features: AZwV_QgjP2j9fiM1bbWupGQo0ZtEscx6nLExKs_juGAOHx-xoENEcocgTyDsmsA
Message-ID: <CAK3+h2yFJDNVPo=38PcYCMNhmw0cQBouL5h7sX0KmyLu-_5zwQ@mail.gmail.com>
Subject: Re: [BUG?]: bpf/selftests: ns_bpf_qdisc libbpf: loading object
 'tc_bpf' from buffer
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: bpf <bpf@vger.kernel.org>, loongarch@lists.linux.dev, ast <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Chenghao Duan <duanchenghao@kylinos.cn>, Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 5:13=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2026/1/2 =E4=B8=8A=E5=8D=882:26, Vincent Li wrote:
> > Hi,
> >
> > I used AI to enhance my message, hope it helps :)
> >
> > I am reporting test failures observed while running BPF selftests on a
> > LoongArch machine. Both the ns_bpf_qdisc and xdp_synproxy tests
> > exhibit WATCHDOG timeouts and eventual failures. The issue appears
> > architecture-specific but I am not sure.
> >
> > Issue Summary:
> > When building and running 6.19.0-rc3 BPF selftests on a LoongArch machi=
ne:
> >
> > The "ns_bpf_qdisc/attach to mq" test fails with a WATCHDOG timeout
> > after 120 seconds, followed by SIGSEGV.
>
> ...
>
> > Are these two test failures (ns_bpf_qdisc and xdp_synproxy) related,
> > given they both show similar timeout patterns?
> >
> > Environment:
> >
> > Kernel: 6.19.0-rc3
> >
> > Architecture: LoongArch
> >
> > Test Command: ./test_progs -t ns_bpf_qdisc
>
> Tested with the latest 6.19-rc5, the testcase passed on LoongArch.
>
> 1. Here are the test results:
>
> $ sudo ./test_progs -t ns_bpf_qdisc
> Warning: sch_htb: quantum of class 10001 is small. Consider r2q change.
> #219/1   ns_bpf_qdisc/fifo:OK
> #219/2   ns_bpf_qdisc/fq:OK
> #219/3   ns_bpf_qdisc/attach to mq:OK
> #219/4   ns_bpf_qdisc/attach to non root:OK
> #219/5   ns_bpf_qdisc/incompl_ops:OK
> #219     ns_bpf_qdisc:OK
> Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED
>
> 2. Here are the toolchains:
>
> $ clang --version | head -1
> clang version 21.1.8 (https://github.com/llvm/llvm-project.git
> 2078da43e25a4623cab2d0d60decddf709aaea28)
> $ gcc --version | head -1
> gcc (GCC) 16.0.0 20260105 (experimental)
> $ as --version | head -1
> GNU assembler (GNU Binutils) 2.45.50.20260105
> $ pahole --version
> v1.31
>
> 3. Here are the test steps:
>
> (1) Compile and update kernel
>
> cd linux.git
> make mrproper defconfig -j"$(nproc)"
>
> scripts/config -e FTRACE -e FUNCTION_TRACER -e DYNAMIC_FTRACE \
> -e FTRACE_SYSCALLS -e FPROBE -e BPF_LSM -e DEBUG_ATOMIC_SLEEP \
> -e KPROBES -e FUNCTION_ERROR_INJECTION -e BPF_KPROBE_OVERRIDE \
> -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e DEBUG_INFO_BTF \
> -m TEST_BPF -d BPF_UNPRIV_DEFAULT_OFF -d ARCH_STRICT_ALIGN \
> -e NET_SCH_BPF -e NET_SCH_HTB -e DIBS -e DIBS_LO -e SMC \
> -e SMC_HS_CTRL_BPF --set-val RCU_CPU_STALL_TIMEOUT 60
>
> make olddefconfig all -j"$(nproc)"
> sudo make modules_install -j"$(nproc)"
> sudo make install -j"$(nproc)"
> sudo reboot
>
> (2) Compile and test bpf
>
> cd linux.git
> cd tools/testing/selftests/bpf && make
> sudo ./test_progs -t ns_bpf_qdisc
>
> Thanks,
> Tiezhu
>

Here is my toolchain version

[root@fedora gcc]# clang --version
clang version 21.1.5
Target: loongarch64-redhat-linux
Thread model: posix
InstalledDir: /usr/bin

[root@fedora gcc]# pahole --version
v1.31

[root@fedora gcc]# gcc --version
gcc (GCC) 14.2.1 20241104 (Red Hat 14.2.1-6)

[root@fedora gcc]# as --version
GNU assembler version 2.42.50.20240531

I repeated the same steps from above you mentioned with the same
kernel config and ran into the same issue.

I attempted to update gcc by compiling with ./configure
--prefix-/usr/local; make; but ran into problem with

checking for loongarch64-unknown-linux-gnu-gcc...
/usr/src/gcc/host-loongarch64-unknown-linux-gnu/gcc/xgcc
-B/usr/src/gcc/host-loongarch64-unknown-linux-gnu/gcc/
-B/usr/local/loongarch64-unknown-linux-gnu/bin/
-B/usr/local/loongarch64-unknown-linux-gnu/lib/ -isystem
/usr/local/loongarch64-unknown-linux-gnu/include -isystem
/usr/local/loongarch64-unknown-linux-gnu/sys-include -fmultiflags
-fno-checking
checking whether the C compiler works... no
configure: error: in `/usr/src/gcc/loongarch64-unknown-linux-gnu/libgomp':
configure: error: C compiler cannot create executables
See `config.log' for more details.

Do you have proper instructions to compile gcc?

I am not sure if it is toolchain related. The thing that really
bothered me is why the hell tc_bpf is loaded by libbpf for
ns_bpf_qdisc selftests that seems to have nothing to do with the
tc_bpf object, I can't think of anything special in my build machine
that would trigger this. Anyway, thanks for the help!

Vincent

