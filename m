Return-Path: <bpf+bounces-13356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801FC7D8A58
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 23:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395B128212F
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339E73D97B;
	Thu, 26 Oct 2023 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPwy1esg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35A3D96A
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:30:10 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDEFD4F
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:30:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so1751a12.1
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698355805; x=1698960605; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67BMETThbluTw+9VSzD1Lre7ekvtvVz2fKBzp1OzZKw=;
        b=ZPwy1esgx3L/HjgoR3btJDRkCXyjZlnXZWXEF8ML2kgb2oVjq827RLdg2aEDZhcHMU
         IUR5yXrLfD7FBFk+B20+3RappspLy0Y3LpsWsu2ELgxhpMnl4h9tqrKojwV+ClBckRF2
         9AsmLhX16DP//v/KlrL1v+SLzBwVAZNRY/CuG30VCirBEkTLRkU5pTYuHehN6i/EZafH
         yXv4yU0CEHlTyQfAf68U+ZCkuKXWLsD4ntphqNosgXPF5f/xtZHr0c/CG9AQ0cMEaclQ
         EHs+lkjPF8D/1CNdZN5EG210D3P9fUnk+L6BZHCjWly4h4LK0/sJ1UnKB+1nvNzRJpge
         IE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698355805; x=1698960605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67BMETThbluTw+9VSzD1Lre7ekvtvVz2fKBzp1OzZKw=;
        b=m8cvwvo+9C1f19ucZE9cCGesJmYStQ7cyX9OndyIPgYZi/mKfgmAw6e6fMoO+d9a/p
         YKzyPOEFK/mclQv4fiuyn+SucUEyds0yzoJJraP8K5r5p63IevOlZcclEFbqucZq/U/F
         6tH/0MlGooXeoHnfLFbKGjhhDoKabUz2UMYPr+16PnGKyvyLGzE2yLEa1Ugde5Kwag8Q
         c8rCvjoHr3UAPF/ppMakg2wFrMZZTPLZqbsS4OvfqnY88p4wIqIm+UFRA63dOOWQ25g1
         lteKkQBMiTmdMypn6+feCQ4pJybE7EW3icVciyOyaDpcGzt01TN6V5dlbc8hYd/JiZ+8
         DfiQ==
X-Gm-Message-State: AOJu0Yw7QJ/ANcgw6/KYkQqBW2YiwOdjDWmQq2K2GdKvB8ESI75ygKdA
	zSkjyhKV6O0xFn+wmFKsd4aB4hiJdtVRNtcZhC2Yw/YIZ2epytFfTyI=
X-Google-Smtp-Source: AGHT+IH83vBsP7ae6dQR8PLaRgBHpdqMlVadEXyoNAzaNF4bWOzW9faQCZqf0wN7h9Z1Ob/fAsEO1jYvJHXORe5UMOM=
X-Received: by 2002:a50:c199:0:b0:540:9444:222c with SMTP id
 m25-20020a50c199000000b005409444222cmr48715edf.6.1698355805443; Thu, 26 Oct
 2023 14:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGckFTu3sYFH=CtdLQhu=0oO_gQpa6ty6EzfWS9XH8zMWg@mail.gmail.com>
In-Reply-To: <CANP3RGckFTu3sYFH=CtdLQhu=0oO_gQpa6ty6EzfWS9XH8zMWg@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 26 Oct 2023 14:29:49 -0700
Message-ID: <CANP3RGfNz2QY64xwexGvCk7ViB=NxLc1z=x8BgKoqLuMBOtR2A@mail.gmail.com>
Subject: Fwd: possible fd handling bug/issue/opportunities? in libbpf
To: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Alexei said he's travelling busy and to resend to bpf@vger, so here it goes:

https://github.com/libbpf/libbpf/blob/master/src/libbpf.c#L4525

int bpf_map__reuse_fd(struct bpf_map *map, int fd) {
...
/*
* Like dup(), but make sure new FD is >= 3 and has O_CLOEXEC set.
* This is similar to what we do in ensure_good_fd(), but without
* closing original FD.
*/
new_fd = fcntl(fd, F_DUPFD_CLOEXEC, 3);
if (new_fd < 0) {
  err = -errno;
  goto err_free_new_name;
}

err = zclose(map->fd);
if (err) {
  err = -errno;
  goto err_close_new_fd;
}

This is based *purely* on very local code inspection of the ~50 lines
up above - so I may well be wrong - but:

(a) optimization opportunity: there should be no need to
F_DUPFD_CLOEXEC 3 if fd is already >= 3
   I assume in this case map->fd == fd, though it's not clear from
looking at the function...
   why is fd a direct argument? maybe it's trying to take ownership
while still allowing the caller to close the passed in fd?

it feels like this function should:
  close(map->fd) almost on entry
  if (fd < 3) {new_fd = dupfd_cloexec(fd,3) and close(fd); fd = new_fd; }
  map->fd = fd

Note: I'm assuming here that kernel returned map fds already have
cloexec set, which I seem to recall was the case?

Maybe pass in *fd instead of fd?

(b) the close() system call closes the file descriptor *even* if it
returns an error
  it's likely a mistake to be checking what value zclose() returns.
  (close() returns *pending* errors but it always releases the file descriptor)
  looking at the implementation of zclose() earlier in the file, it's
aware of this.
  as such I think:

err = zclose(map->fd);
if (err) {
err = -errno;
goto err_close_new_fd;
}

should probably be *just*
  (void)zclose(map->fd);
or even just
  close(map->fd)
since map->fd will be overwritten in a moment.

btw. happened to look at this because I ran across the
"fd == 0 means AT_FDCWD BPF_OBJ_GET commands" thread.
It looks like the kernel community is perfectly okay with the kernel
throwing land mines at userspace...
I totally agree with you that for most new fd-like things (incl.
timerfd's, bpf, etc.)
the kernel should never allocate them with index <3 because it's *too*
ripe for abuse.

Anyway, the above comments *might* not be correct.
I didn't do a deep analysis or anything, just something I noticed /
was confused by on a quick glance.
There may be deeper reasons why the code should be the way it is
(though perhaps it could use more comments then)

- Maciej

