Return-Path: <bpf+bounces-22953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4FE86BC2C
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0EB1C22EAD
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298413FB97;
	Wed, 28 Feb 2024 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8Ft2bAJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E813D319;
	Wed, 28 Feb 2024 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162846; cv=none; b=DbZVBXm3BU188n5Gmd4gRM80COWV8LXgA7i4jnuC6g0IruMtvvKKawunUf8UNUVq3F5MTiHnD2dnWXr8Nn4cdYtGOQ8YCpacPYXi8fCyeE7IiOhfUWUl/vPjroshLaWSgAIyI/XapgvSRySLwYEmPHhwqTmvj8OvwSysWk+tSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162846; c=relaxed/simple;
	bh=yR99aj/Y3qUCL/U7ci0Qst/HDVZ03Ni5Gp668ZTg95w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T+mdSpIYlH+IKCtCwNOlmbKZpS76o/mQ9SlodHkRr7nNFAnr5PoY5UrE7RPYvuiwqMHWN1jy41LjxNSPey+pQKIrfpmhWarFT0zPdd4ILvvjJ6bc7RyVB33ieikuyEIzatJglVaLsCBJ3g5LdbcfdcDtBRvZKS3imlRV9litW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8Ft2bAJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513230201b2so155805e87.1;
        Wed, 28 Feb 2024 15:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709162843; x=1709767643; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qUsI28IGlUJBAILlE5CNXqMn2Wot3QZGGWsRmezOGs8=;
        b=C8Ft2bAJuHRJs50ha//S0HEUf+4TAkzx6P9B/EkWJVo6PI4f8MOYI4+z1rR7icFPVN
         exHx9yc3aDLE8iClOLhTm1Dl9JzU+AqxO2mPfg1dqYrerfFC3FOpuM8aAmrDFAeMtbbr
         0EjzxsG0YbaMZorOksSC8Bc3lOGoL0WBm3/muTA1GaMaoEQHD9GNsVTNn4FKwlAmkvel
         3l+0Lp4GdGCytkpMsohMtect6MijdyfYQc0lCIOLDx7lJnK8nXjZWe40HFFwpPIbpsFa
         5lU0ZsmLQZr/SVEC1O+JSNQZ9epYhM9sYgToHdjWgFtmFC6uynaaYtlaGxOg/gaTvl6j
         ryZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162843; x=1709767643;
        h=mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUsI28IGlUJBAILlE5CNXqMn2Wot3QZGGWsRmezOGs8=;
        b=SafCwNlNQxuf/hMnOcdRyyUfF07A4dtLmPO3kWYHP8VDy3HOd2gN1dfWpHHMhq6Ipg
         5b8gK9/8y4ZjlCwWThCb/JxyENigSiBR/dLyp3qE+Rgw0Z5N2cBGBb626hfOQcns1mR4
         4m0D6I7AD8AX9bgXQI14MVdS3jlpzinqnvRcH4mVDChZiMFWEfn0fNO23FJusa1aP/UQ
         UF519bXo02M+m2POO0RXM5i9Fc1ZXn4BsSjpLXnFc2woZB0o5BPWEK0Sz7cnPPAznCud
         ZkhGo/njk8axUKnODTqvaTRcpAD2vts/XfypRA6cW9dRKYiPjQjPs8OMOTtjWhnCl2bS
         detw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Qtkqk0+dQf/n/xDBB/mDexGZ4bwXcFqVFS8lertDOEnqiSmjsIJzZXD1gKcBkNkDMxRsb5keZuYl/5NQL1XMKPxp8CjXzur5sZz2ECZj2sNDZ6MXnwucj5ZRP4oBmM6Q
X-Gm-Message-State: AOJu0YyouFEqmb8zHJcRICUcNn38Erkm7Y86FpNAW36IYzOe0rB9+Z96
	DBCSAuuIm5rSHth3GzDp9pgPqP9MiD7TmSxHCSujCzYYhp44y0pA
X-Google-Smtp-Source: AGHT+IEUDNBkFdHTxEGr88/rougzxjN7wW1dNLNTE4EokEqvE3FvIDWV4qKKcWv4RZPmxcXgd163Ng==
X-Received: by 2002:a05:6512:605:b0:513:1a02:7304 with SMTP id b5-20020a056512060500b005131a027304mr202101lfe.54.1709162842814;
        Wed, 28 Feb 2024 15:27:22 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id m19-20020a056000181300b0033d3b8820f8sm51909wrh.109.2024.02.28.15.27.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2024 15:27:22 -0800 (PST)
From: puranjay12@gmail.com
To: catalin.marinas@arm.com, ast@kernel.org, daniel@iogearbox.net,
 mark.rutland@arm.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org 
Subject: arm64: Supporting DYNAMIC_FTRACE_WITH_CALL_OPS with CLANG_CFI 
Date: Wed, 28 Feb 2024 23:27:03 +0000
Message-ID: <mb61ph6hsxj94.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


I recently worked on allowing BPF programs to work properly on CLANG_CFI
enabled kernels [1]. While doing this I found that fentry programs are
failing to attach because DYNAMIC_FTRACE_WITH_CALL_OPS doesn't work with
CLANG_CFI.

Mark told me that the problem is that clang CFI places the type hash
immediately before any pre-function NOPs, and so where some functions
have pre-function NOPs and others do not, the type hashes are not at a
consistent offset (and effectively the functions have different ABIs and
cannot call one another)

I tried enabling both Clang CFI and -fpatchable-function-entry=4,2 to
see the behaviour and where this could fail. Here is an example:

This is the disassembly of jump_label_cmp() that has two pre-function nops and the CFI
hash before them. So, the hash is at (addr - 12).

ffff80008033e9b0:       16c516ce        [kCFI hash for 'static int jump_label_cmp(const void *a, const void *b)']
ffff80008033e9b4:       d503201f        nop
ffff80008033e9b8:       d503201f        nop
ffff80008033e9bc <jump_label_cmp>:
ffff80008033e9bc:       d503245f        bti     c
ffff80008033e9c0:       d503201f        nop
ffff80008033e9c4:       d503201f        nop
[.....]

The following is the disassembly of the sort_r() function that makes an indirect call to
jump_label_cmp() but loads the CFI hash from (addr - 4) rather than
(addr - 12). So, it is loading the nop instruction and not the hash.

ffff80008084e19c <sort_r>:
[.....]
0xffff80008084e454 <+696>:   ldur    w16, [x8, #-4] (#-4 here should be #-12)
0xffff80008084e458 <+700>:   movk    w17, #0x16ce
0xffff80008084e45c <+704>:   movk    w17, #0x16c5, lsl #16
0xffff80008084e460 <+708>:   cmp     w16, w17
0xffff80008084e464 <+712>:   b.eq    0xffff80008084e46c <sort_r+720>  // b.none
0xffff80008084e468 <+716>:   brk     #0x8228
0xffff80008084e46c <+720>:   blr     x8

This would cause a cfi exception.

As I haven't spent more time trying to understand this, I am not aware
how the compiler emits 2 nops before some functions and none for others.

I would propose the following changes to the compiler that could fix this
issue:

1. The kCFI hash should always be generated at func_addr - 4, this would
make the calling code consistent.

2. The two(n) nops should be generated before the kCFI hash. We would
modify the ftrace code to look for these nops at (fun_addr - 12) and
(func_addr - 8) when CFI is enabled, and (func_addr - 8), (func_addr -
4) when CFI is disabled.

The generated code could then look like:

ffff80008033e9b0:       d503201f        nop
ffff80008033e9b4:       d503201f        nop
ffff80008033e9b8:       16c516ce        kCFI hash
ffff80008033e9bc <jump_label_cmp>:
ffff80008033e9bc:       d503245f        bti     c
ffff80008033e9c0:       d503201f        nop
ffff80008033e9c4:       d503201f        nop
[.....]

Note: I am overlooking the alignment requirements here, we might need to
add another nop above the hash to make sure the top two nops are aligned at 8 bytes.

I am not sure how useful this solution is, looking forward to hear from
others who know more about this topic.

Thanks,
Puranjay

[1] https://lore.kernel.org/bpf/20240227151115.4623-1-puranjay12@gmail.com/ 

