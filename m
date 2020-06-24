Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C532071C3
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbgFXLGE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgFXLGE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 07:06:04 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F164BC0613ED
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2020 04:06:02 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 72so1520444otc.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2020 04:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=l4zfaVDZgUpKgcIKG5b8nZkFYra2tRt2Wck/xyyBZng=;
        b=wtHOEYcerX4D7W14VdWv0ARksDiomYG0wn3uPOg8z7o5NTjZ9irq8cnauzJdMAbnW/
         tN5vx26l9/p6zrcIW5MEjnMcafc1AdBfBkGh7ZJtl8LP2H/K7Xhm2Ydlf217wUSz96zh
         DiF+cBA12+HHZ9CzE3dRgnm8FIffkozQPdDe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=l4zfaVDZgUpKgcIKG5b8nZkFYra2tRt2Wck/xyyBZng=;
        b=fExQ3adw1wLZsjXUS6Vq2jtJ6Tjzn0pVH/Wuof7dqLpdT0iq8gdrg3d+knRkDlmk6D
         4DL3jqdisA6DPk6BW6hhEqLH9YeCMhykV2CkXcY4GRBZcEdX4JnkiPXfFQXn8CfjSwOT
         q0hMj/NhBXpUY0gKeIEcvba9hOYO/YhNvpy8/7+IoJOC4CMo7/64amkV74MR2MdpgiRw
         rqsYuH6IEQZI2CgvNzcwMNfn8EaVt54qu9jabSOF8PBktSQ0YKOhNRa1RDXoZCwm4/ap
         lnVSBhntkk6G9SVWeWkCbwMP0VggfoLP/JIqQLenkrSXDzkiM1F/Uz8BElq2iud+YtmH
         d11Q==
X-Gm-Message-State: AOAM5337e1fWrwgqHQkg5ijZak87bGXgcnYP4be3Kbssn0/WntNNG2J+
        a+TaWl0ZFL8+2FxeJymryJjTBFschVRQihFmYD6YKV8y7b0o0g==
X-Google-Smtp-Source: ABdhPJxwovhZMYnCoHl1MU8y8b9uL+3ViVw62jLLN2x9Jjn4al+XX4JcVtbRDzw1egcnBa6VLOXSUNclykXmlP8+LMk=
X-Received: by 2002:a4a:ba8b:: with SMTP id d11mr12294194oop.80.1592996761685;
 Wed, 24 Jun 2020 04:06:01 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 24 Jun 2020 12:05:50 +0100
Message-ID: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
Subject: pahole generates invalid BTF for code compiled with recent clang
To:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org
Cc:     kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

If pahole -J is used on an ELF that has BTF info from clang, it
produces an invalid
output. This is because pahole rewrites the .BTF section (which
includes a new string
table) but it doesn't touch .BTF.ext at all.

To demonstrate, on a recent check out of bpf-next:
    $ cp connect4_prog.o connect4_pahole.o
    $ pahole -J connect4_pahole.o
    $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
--dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
    $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
.BTF.ext=btf-ext.bin connect4_prog.o
    $ sha1sum *.bin
    1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
    4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
    2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
    4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin

This problem crops up when compiling old kernels like 4.19 which have
an extra pahole
build step with clang-10.

I think a possible fix is to strip .BTF.ext if .BTF is rewritten.

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
