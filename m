Return-Path: <bpf+bounces-29977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6188C8DDE
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 23:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FB01F23C67
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 21:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040B1411EB;
	Fri, 17 May 2024 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BtMAgW4J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B447210E9
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715982664; cv=none; b=oLV/sG1soeMDPcd80fir9JhCJ0HpNsPcYT2ZwVQZDO1W8Gh+QG3ERJWsdC/QO4F/tRHHkCxZe/2wThyyZftWT4+DU7SW2qja7L2zMQs+WrfdNI5f3LZ+1C6GvVMSQh6BPvs4PATEnG7Gj1vnuXYDtdhhXFnPt8G1d+MtHJGbSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715982664; c=relaxed/simple;
	bh=0E7eaNTn25VPZND5g23qK/Ao2qthaQCAHj3l7eXug3g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mPs8fE2M71VBIYL3GaDIrh7iE2/GD9eJvoRpf+uyn6IDQc8lj+X8h3PVO6VsQJTWpPWHaJyxURYZqR8TAe2YR+RsxRF9oTMteqOdT7TFSfLVBVx4NA7dPZVX1Rv4BbzEn1IQFY0X9hH35lR0nr37AtfM22NVu/MmE5QU7pk8Cug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BtMAgW4J; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61bee45d035so7253247b3.1
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715982662; x=1716587462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JqVu/kA6Go97evFIK242c0lkRDXDcl7LbF0LEfPVfNg=;
        b=BtMAgW4J1m5/fx4z19KHk8SIDxTkAbaqBfjlHEgqx54xq6p5P4KHcvf+OgL/KlGwM1
         1EfBe/kXM0dCgygoYu35o6sjdYfstiPfGqxFC+3vzXDuuGRI4dOzKBBB7vrXT1XpSOAl
         Xe/cGkvWrnLpRpe194X4NRel8KRmwqUAF5AcdNJsgeoKubXVQU8Q+N83lEpzVGPLvtrC
         majuekPkaEvoUvUz6L2OEDhAteQu0waRwsprjALvmb36FgvX/k9nhW8b4WSORjKgROKY
         fvm6i95OJebRZjA0cH9undWkPBXCZrWj/U2HVgUnP4XrzU7Sv9JD2K2RRnyrklWNkbfd
         WKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715982662; x=1716587462;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqVu/kA6Go97evFIK242c0lkRDXDcl7LbF0LEfPVfNg=;
        b=IVEw0vrJmjZvCM1bk0IxDgdineOpV7y0WrmkTdffKY2T/fA4lqhiqRJef/QVd/5LAh
         SiWEwvU7rb8Y2dF5ZQoUQBGghZnzk9u28WoP0sIMB48vyZIURd3ejiPCSiyr5es1hHcY
         ikA6Vd9zS2b3OJSAeZs2XhX+O+I5VzkTB4wNbAb1k1f9PfU1PuP+I/fHKTcuZQT+0xbO
         3idaOJBxYTKOeiRzuV0w/MsN1dijOnYT22jybfxgZj7J5vDjtTnckkGmINmdzJ+pGcoI
         RXJ5cRKQZHcnyHQ3tSTdyZtdXrW27dJl2rOfq2iqetRXHNkq1jDAtV7hBCLXaOeaEYhv
         sF4Q==
X-Gm-Message-State: AOJu0YzsyeYK4PCiZytnEjL7NhC8iHTHu90ug6e8VgLNJ7RNoIkgpNR6
	KcMnor1r+Be+SMN7cZEUiisfjdHxp4lZZVEtCvJlrUW0b1tETB7fQMiIddpGJClgCaWJJE4ULGB
	QxvVLInutoLnqCpdMSXbPFa24+tZ1sReSknWho7kMiSDxpQn1MgQ=
X-Google-Smtp-Source: AGHT+IEe+nZ2KnnP6vARg4nvWdn1LICCt7qYyk2XbAACiY4Suxq8FXGH4FZW8lOfg1gNUOlq+6kGwbcqxVUklqhTOmo=
X-Received: by 2002:a81:ac23:0:b0:61b:3348:34c0 with SMTP id
 00721157ae682-622b016d1a7mr216119787b3.50.1715982662218; Fri, 17 May 2024
 14:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ivan Babrou <ivan@cloudflare.com>
Date: Fri, 17 May 2024 14:50:51 -0700
Message-ID: <CABWYdi0ymezpYsQsPv7qzpx2fWuTkoD1-wG1eT-9x-TSREFrQg@mail.gmail.com>
Subject: bpftool does not print full names with LLVM 17 and newer
To: bpf <bpf@vger.kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

We recently bumped LLVM used for bpftool compilation from 15 to 18 and
our alerting system notified us about some unknown bpf programs. It
turns out, the names were truncated to 15 chars, whereas before they
were longer.

After some investigation, I was able to see that the following code:

    diff --git a/src/common.c b/src/common.c
    index 958e92a..ac38506 100644
    --- a/src/common.c
    +++ b/src/common.c
    @@ -435,7 +435,9 @@ void get_prog_full_name(const struct
bpf_prog_info *prog_info, int prog_fd,
        if (!prog_btf)
            goto copy_name;

    +    printf("[0] finfo.type_id = %x\n", finfo.type_id);
        func_type = btf__type_by_id(prog_btf, finfo.type_id);
    +    printf("[1] finfo.type_id = %x\n", finfo.type_id);
        if (!func_type || !btf_is_func(func_type))
            goto copy_name;

When ran under gdb, shows:

    (gdb) b common.c:439
    Breakpoint 1 at 0x16859: file common.c, line 439.

    (gdb) r
    3403: tracing  [0] finfo.type_id = 0

    Breakpoint 1, get_prog_full_name (prog_info=0x7fffffffe160,
prog_fd=3, name_buff=0x7fffffffe030 "", buff_len=128) at common.c:439
    439        func_type = btf__type_by_id(prog_btf, finfo.type_id);
    (gdb) print finfo
    $1 = {insn_off = 0, type_id = 1547}


Notice that finfo.type_id is printed as zero, but in gdb it is in fact 1547.

Disassembly difference looks like this:

    -    8b 75 cc                 mov    -0x34(%rbp),%esi
    -    e8 47 8d 02 00           call   3f5b0 <btf__type_by_id>
    +    31 f6                    xor    %esi,%esi
    +    e8 a9 8c 02 00           call   3f510 <btf__type_by_id>

This can be avoided if one removes "const" during finfo initialization:

    const struct bpf_func_info finfo = {};

This seems like a pretty annoying miscompilation, and hopefully
there's a way to make clang complain about this loudly, but that's
outside of my expertise. There might be other places like this that we
just haven't noticed yet.

I can send a patch to fix this particular issue, but I'm hoping for a
more comprehensive approach from people who know better.

Thanks.

