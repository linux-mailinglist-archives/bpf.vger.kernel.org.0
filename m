Return-Path: <bpf+bounces-34607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7943792F285
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 01:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4A2B21463
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 23:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CC519EED4;
	Thu, 11 Jul 2024 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYkLi7JY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD314D432
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739948; cv=none; b=GLy0cNxG9jVk4xJG4lacmOf2oiUiOQ54CwopxkwyPgVOJYYvIVqEg1/AKiUNfgIrmTaOaHc1CT6kqY1RCGmOOMfibAfvnUY9JlV62pgVTpU8g9OlSGZeL0zVQjUxt4YCN6oSc4bJPMZl8awZE/7F5WeosfJQKuAayriXyEvKuPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739948; c=relaxed/simple;
	bh=hXkE/mDihDTAMcJZtO2szecyEvGApBazNmQQqdeVdDU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0KfGrJRf/GVyEDyD/SM7ezhgszv8P7a615tYpy8DhAkRgZtDsQjNwrP6zBdJFTqm5PM1UEfMYNW0EeAqcC7nqRGf53wrfxz7q6k28vBCEr17pi81I44683TvPLg25NeIv5dEV1KHUwTBLaoal3lqUXYLJk706SftPZprjyO++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYkLi7JY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b0013cf33so1317728b3a.2
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 16:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720739946; x=1721344746; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JEnR63deynyUTQFYjLjZtxyUIxgCNpHYkVUNPAqPHXA=;
        b=DYkLi7JY5d7bbBhaWGqFk9Slj7ib7GhJ4ZBqUjLxH2S+jQHsOvdZ4yvnvV5KlHnP/r
         gw+YtWhN+nK7ItJ6w5U3a6jkZdq2+DKLu2TfKRAuYTIXF6AeSAMJ3Nwo4/yrVOJNWGQd
         JjGeEOwSSoC2pPuBdButl7qQdw9XUYVstXVVkfmMF4I27b3FzjIamVvx4X6WfqmWkS6g
         HYkvYBWaNnM+uMACGg5sKfaePo8dXub0662PFXCAwcRZg6OAjo+biq6kXwRxNCCpxQtc
         +ovFD2/9PDrhoyPdvhv8TjhSnlxLqL1IevRRjJQ+fJcqWWjHRj+S4hRlYzEo0q0iEccf
         z76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739946; x=1721344746;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEnR63deynyUTQFYjLjZtxyUIxgCNpHYkVUNPAqPHXA=;
        b=XyIiQULggFb3TbaYKN+4pKlUOuvG4UYYSYYUjGJf71CibLPRWOHtSs9Fjuiy/3p0Bd
         D9WhXWcMqP0wg1nY+oXyQAIUnN2yGTqRqJT+UWIZp3HOsFL3k24R8jc1kA3sRwFfVQDx
         gvrbrxHgOZMmYX0eI2nAR+yJv38CjTpOjdOsIDxBua3LswMIYqhbsSU/dAl2VwhdRLQA
         yq4ihx5iXfpRFnSivtcg50N4AGfn/KrVmqgo3miV+lm5ehPHfSLqmtp1DYmXZ+IQpK2h
         Fk0HJV6O4W82/Hj4aGlb2PBYyZHkQsXUoPonVImUPxS0i0HqP947Wd6x5xN4fqTR94Ns
         nd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/4qwuvku/iW0MM2lqlkLjCjGhcKlyveB68l3Xre6kFXm4te+va8qeoV3zzEUculJtTltw5w+WEIB4xQG61vfhYyXN
X-Gm-Message-State: AOJu0Yzij8v2q/p18mwoZy+kChnTyFauVEggJhBbhQsOghGdMs4DV3SO
	N3hHQcNWqDpSK7w6/FDJTr5YQ/qWfKM9ra30bZfchQt3y7+Wg2Babetw98d7
X-Google-Smtp-Source: AGHT+IHZVj+cK7QouFHenqsi2m3bql8OErBgXyT+dBwscsmOsOlT6eYzc2eHVyGBHzvorT0P0aEw3g==
X-Received: by 2002:a05:6a20:918d:b0:1be:c5ab:7388 with SMTP id adf61e73a8af0-1c298220a18mr11613982637.25.1720739946037;
        Thu, 11 Jul 2024 16:19:06 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac0ec1sm55744155ad.219.2024.07.11.16.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:19:05 -0700 (PDT)
Message-ID: <17b05c0408489fd5ca474ae8ba3b7a3cc376f484.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: use auto-dependencies for test
 objects
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, "bpf@vger.kernel.org"
	 <bpf@vger.kernel.org>
Cc: "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org"
 <andrii@kernel.org>,  "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "mykolal@fb.com" <mykolal@fb.com>
Date: Thu, 11 Jul 2024 16:19:00 -0700
In-Reply-To: <Naz7DRaOm6WPfVO0YqehujmRBSUi1RDWI6XYE-9zcqusFHfJ9VXevAlYMbcYORj2r8277pIQlbO5qHcpBrJpbeHAscLS9eo1AoKlkEiwt5k=@pm.me>
References: 
	<Naz7DRaOm6WPfVO0YqehujmRBSUi1RDWI6XYE-9zcqusFHfJ9VXevAlYMbcYORj2r8277pIQlbO5qHcpBrJpbeHAscLS9eo1AoKlkEiwt5k=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-11 at 21:09 +0000, Ihor Solodrai wrote:


[...]

> @@ -583,14 +596,20 @@ endif
>  # Note: we cd into output directory to ensure embedded BPF object is fou=
nd
>  $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
>  		      $(TRUNNER_TESTS_DIR)/%.c				\
> -		      $(TRUNNER_EXTRA_HDRS)				\
> -		      $(TRUNNER_BPF_OBJS)				\
> -		      $(TRUNNER_BPF_SKELS)				\
> -		      $(TRUNNER_BPF_LSKELS)				\
> -		      $(TRUNNER_BPF_SKELS_LINKED)			\
> -		      $$(BPFOBJ) | $(TRUNNER_OUTPUT)
> +		      $(TRUNNER_OUTPUT)/%.test.d
>  	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
> -	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -c $(CURDIR)/$$< $$(LDLIBS) -o $=
$(@F)
> +	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$=
(LDLIBS) -o $$(@F)

Hi Ihor, nice patch, thank you for working on this!

While re-testing the patch I've noticed a strange behaviour:
$ cd <kernel>/tools/testing/selftests/bpf
$ git clean -xfd .
$ make -j14
$ touch progs/atomics.c=20
$ make -j14 test_progs
  CLNG-BPF [test_maps] atomics.bpf.o
  CLNG-BPF [test_maps] atomics.bpf.o
  CLNG-BPF [test_maps] atomics.bpf.o
  GEN-SKEL [test_progs] atomics.lskel.h
  GEN-SKEL [test_progs-cpuv4] atomics.lskel.h
  GEN-SKEL [test_progs-no_alu32] atomics.lskel.h
  TEST-OBJ [test_progs] arena_htab.test.o
  TEST-OBJ [test_progs] atomics.test.o
  ... many lines ...
  TEST-OBJ [test_progs] uprobe_multi_test.test.o
  TEST-OBJ [test_progs] usdt.test.o
  TEST-OBJ [test_progs] verify_pkcs7_sig.test.o
  TEST-OBJ [test_progs] vmlinux.test.o
  TEST-OBJ [test_progs] xdp_adjust_tail.test.o
  TEST-OBJ [test_progs] xdp_metadata.test.o
  TEST-OBJ [test_progs] xdp_synproxy.test.o
  BINARY   test_progs
16:15:34 bpf$ make -j14 test_progs
  TEST-OBJ [test_progs] bpf_iter.test.o
  TEST-OBJ [test_progs] bpf_nf.test.o
  TEST-OBJ [test_progs] bpf_obj_id.test.o
  TEST-OBJ [test_progs] btf.test.o
  TEST-OBJ [test_progs] btf_write.test.o
  TEST-OBJ [test_progs] cgrp_local_storage.test.o
  TEST-OBJ [test_progs] iters.test.o
  TEST-OBJ [test_progs] lsm_cgroup.test.o
  TEST-OBJ [test_progs] send_signal.test.o
  TEST-OBJ [test_progs] sockmap_basic.test.o
  TEST-OBJ [test_progs] sockmap_listen.test.o
  TEST-OBJ [test_progs] trace_vprintk.test.o
  TEST-OBJ [test_progs] usdt.test.o
  TEST-OBJ [test_progs] xdp_metadata.test.o
  BINARY   test_progs
16:15:37 bpf$ make -j14 test_progs
  TEST-OBJ [test_progs] bpf_obj_id.test.o
  TEST-OBJ [test_progs] sockmap_listen.test.o
  TEST-OBJ [test_progs] xdp_metadata.test.o
  BINARY   test_progs
16:15:39 bpf$ make -j14 test_progs
  TEST-OBJ [test_progs] sockmap_listen.test.o
  BINARY   test_progs
16:15:41 bpf$ make -j14 test_progs
make: 'test_progs' is up to date.

Interestingly enough, this does not happen with your off-list version of
the patch shared this morning, the one with order-only dependency for .d:

  +$(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o: $(TRUNNER_TESTS_DIR)/%=
.c | $(TRUNNER_OUTPUT)/%.test.d

Could you please double-check what's going on?

> +
> +$(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:			\
> +			    $(TRUNNER_TESTS_DIR)/%.c			\
> +			    $(TRUNNER_EXTRA_HDRS)			\
> +			    $(TRUNNER_BPF_SKELS)			\
> +			    $(TRUNNER_BPF_LSKELS)			\
> +			    $(TRUNNER_BPF_SKELS_LINKED)			\
> +			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
> +
> +include $(wildcard $(TRUNNER_TEST_OBJS:.o=3D.d))
> +
> =20
>  $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
>  		       %.c						\

[...]

