Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D351618EBA8
	for <lists+bpf@lfdr.de>; Sun, 22 Mar 2020 19:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCVSub (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Mar 2020 14:50:31 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:59113 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgCVSu2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 Mar 2020 14:50:28 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 33af9a21;
        Sun, 22 Mar 2020 18:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:cc:content-type; s=mail; bh=hmS
        55V9Dn93BL6uHi4RSxOrT47c=; b=JgBLUjonJQRxuL9SrSlGs3SujjDFn4S7zos
        xUYZRZpXe7aCIqebj0QDR2fXttQJmQbKtAnfQEQ81W6nS+3tlTTeKhwLbI9gmX+q
        Ct1Y/cwi4F+tc7CWzpG9b60v3WyllulVdH9oElZp12MDd9bHeZtEPSo5Gxx/bMQn
        6QbQGEPEaD0lYAIRBDA70I8WxHow1Q/jJCfA5kkrL4fWr0BGoc+MuF1jpSmV9I+S
        kcGuWYxhrJDYPvyPRZwyBeUqzAIkfFCfG+E0hL8EeA6MhDwepoRPTTgfEgIpZXud
        Nkbl8mxmfrUPAnYjUNvBmTw9/Mii8h4lNZKZPP9g7vrlWk/fC5w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a6f43938 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sun, 22 Mar 2020 18:43:30 +0000 (UTC)
Received: by mail-io1-f45.google.com with SMTP id a20so4615010ioo.13;
        Sun, 22 Mar 2020 11:50:24 -0700 (PDT)
X-Gm-Message-State: ANhLgQ34FvHwtwsVpWCur5vX+A9VOVlFhfsyF9WggRY2f2AF8gX9LK+J
        vL056UpEeraEbY76cRWRZiywTmNiyAVUrS+7QEE=
X-Google-Smtp-Source: ADFU+vv4zGh+o3AH6GeYejiySqgcC69QSTPIXvcWsFsq59RdrPkdYAd46QxjQ9wjBCUsziEQy6yHaTUTMEQCzch4vc4=
X-Received: by 2002:a02:6241:: with SMTP id d62mr17418110jac.86.1584903023963;
 Sun, 22 Mar 2020 11:50:23 -0700 (PDT)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 22 Mar 2020 12:50:13 -0600
X-Gmail-Original-Message-ID: <CAHmME9ptzBzzn+jOo=azZagB=TTFbc2vzdcYurfsE0_1nvKF+g@mail.gmail.com>
Message-ID: <CAHmME9ptzBzzn+jOo=azZagB=TTFbc2vzdcYurfsE0_1nvKF+g@mail.gmail.com>
Subject: using libbpf in external projects
To:     bpf@vger.kernel.org
Cc:     nicolas@serveur.io, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Nicolas (CC'd) and I are working on a small utility that does some bpf
things. What it actually does isn't important. But I did just clean up
its use of libbpf by way of a Makefile:

> KERNEL_VERSION := 5.5.11
> PKG_CONFIG ?= pkg-config
>
> all: linux-$(KERNEL_VERSION)/.prepared
>     @$(MAKE) --no-print-directory netifexec
>
> linux-$(KERNEL_VERSION)/.prepared:
>     curl https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$(KERNEL_VERSION).tar.xz | tar xJf -
>     touch $@
>
> CFLAGS ?= -O3
> CFLAGS += -Ilinux-$(KERNEL_VERSION)/tools/lib/bpf -Ilinux-$(KERNEL_VERSION)/tools/include -Ilinux-$(KERNEL_VERSION)/tools/include/uapi
> CFLAGS += -DHAVE_LIBELF_MMAP_SUPPORT
> CFLAGS += -MMD -MP
> CFLAGS += -std=gnu99 -D_GNU_SOURCE
> CFLAGS += -Wall
> CFLAGS += $(shell $(PKG_CONFIG) --cflags libelf zlib)
> LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib)
>
> netifexec: $(sort $(patsubst %.c,%.o,$(wildcard *.c linux-$(KERNEL_VERSION)/tools/lib/bpf/*.c)))
>
> clean:
>     $(RM) netifexec *.o *.d linux-$(KERNEL_VERSION)/tools/lib/bpf/*.o linux-$(KERNEL_VERSION)/tools/lib/bpf/*.d
>
> mrproper: clean
>     $(RM) -r linux-$(KERNEL_VERSION)
>
> .PHONY: all clean mrproper

Ignoring that piping curl to tar with no hash checking is unsafe, is
this kind of embedding something you intended people would do to use
this code externally? Or is there another distribution of this library
from elsewhere that you'd recommend?

Jason
