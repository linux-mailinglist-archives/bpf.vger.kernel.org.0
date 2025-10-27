Return-Path: <bpf+bounces-72295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06468C0BC5C
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 05:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 432514EB3AD
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 04:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459CE238145;
	Mon, 27 Oct 2025 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBXxvazl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2419067C;
	Mon, 27 Oct 2025 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761537710; cv=none; b=dL/zubChuzSkki0qAgZTnqMNPCfibx4sHztN/wrvOWTNyXurgwqsOHyjzSrq/QYn0j2URsamehbmgkLv6Kwf1CroIH6EwQhUMTa/Spuea67HxTvcEtl2DRqpQfx8fTEuxbb/h6E4+1B5jp9TKN4L58uPQRH3jDu4tqRzmdNQF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761537710; c=relaxed/simple;
	bh=X3VBwEKfbRGG5eqsTko47sqtgf2dtUqgHDas26bmpIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V9lvJKh126SRExcj+M/XG6cnyBRNOzgofFN6nf+EokLZxKVmnugfSa3DRx/LuMkF/qpo3sp7ahsTAUSEA1SeM+qriEI0j8Bedu8qpCop86353OHDAd3rAcovuYdFK9W8mgIB+TC7HX7QYZfbYpdEtfQP3gVB8AH4X8FInCsMtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBXxvazl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C0DC4CEF1;
	Mon, 27 Oct 2025 04:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761537710;
	bh=X3VBwEKfbRGG5eqsTko47sqtgf2dtUqgHDas26bmpIk=;
	h=Date:From:To:Cc:Subject:From;
	b=aBXxvazlgZlDADoZ2UPccXhxenE2PMEFcUu5Ru1TV5tBy7cu9zNDA16yrrYEU9ugu
	 8IfWyjJqf9zyRGScj+Ivqc4aBcXxXp5p2Bay2VyGkPW/ASh5Naam1orBs4ouQjSpub
	 DOEZ2TGI2OMhqwndDBSW+7BpUn4byTZR/+4cy/6FA4FeUgwNLaX3Jkd1n0jDJbGp7m
	 77GpUmAQr9FBb+wlKB3NBP9rByfh1HWLSw12Njm4qQrkHdTDv2+G4zdeKvR9LQYqze
	 T8P8YhK/7J4i3CUzvJR6Ji1fztY4gKwILjEdC/yv2KWiu6XpNpr8itDEc7QThckyr7
	 33eiyw4MTDpfA==
Date: Sun, 26 Oct 2025 21:01:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: [BUG] bpftool: Build failure due to opensslv.h
Message-ID: <aP7uq6eVieG8v_v4@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

I'm seeing a build failure like below in Fedora 40 and others.  I'm not
sure if it's reported already but it failed to build perf tools due to
errors in the bootstrap bpftool.

    CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
  sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
     16 | #include <openssl/opensslv.h>
        |          ^~~~~~~~~~~~~~~~~~~~
  compilation terminated.
  make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
  make[3]: *** Waiting for unfinished jobs....
  make[2]: *** [Makefile.perf:1213: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
  make[1]: *** [Makefile.perf:289: sub-make] Error 2
  make: *** [Makefile:76: all] Error 2

I think it's from the recent signing change.  I'm not familiar with
openssl but I guess there's a proper feature check for it.  Is this a
known issue?

Thanks,
Namhyung


