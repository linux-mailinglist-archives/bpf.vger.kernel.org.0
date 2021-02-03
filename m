Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C8330D23C
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 04:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhBCDvK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 22:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhBCDvI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 22:51:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1EC0613ED
        for <bpf@vger.kernel.org>; Tue,  2 Feb 2021 19:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=fsMjq8FX02TR3Au7N18szb1Ny2rIBDSrYr5LX/yP3MM=; b=yoXynNarvifakcMgnV0OtHdlXu
        IubTYNgByEnGAt8TCahD+Wbnsmigr0XObqxcDNivH7K1DpP5xyx25IquGC7B45hB0cokCt1nJH5My
        7siNnBkSG4O4S1FCTnnr878PrG8Fkw0W7U49td6Mx1QU2y201B+jRKqW2OtMWzl9H8nHdHREzMdpy
        o4XG6rqE6DS/ptqzpY4aFC3EQPcqeLEzC8r0W1HcsGku5/aBU8X9voE5AzXYEzzn/qYBe+GqB0IHX
        gm2Kw6hLd0nHAyDSFfph+XUc6A17WO9162N5f+i+lAzzOrgpneS9h07uQ4boDe0/EkUyzIXvr3Zy3
        kyYnI+qQ==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l79BR-0002El-Ro
        for bpf@vger.kernel.org; Wed, 03 Feb 2021 03:50:26 +0000
To:     bpf <bpf@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: finding libelf
Message-ID: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
Date:   Tue, 2 Feb 2021 19:50:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I see this sometimes when building a kernel: (on x86_64,
with today's linux-next 20210202):


CONFIG_CGROUP_BPF=y
CONFIG_BPF=y
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_PRELOAD=y
CONFIG_BPF_PRELOAD_UMD=m
CONFIG_HAVE_EBPF_JIT=y


Auto-detecting system features:
...                        libelf: [ [31mOFF[m ]
...                          zlib: [ [31mOFF[m ]
...                           bpf: [ [31mOFF[m ]

No libelf found
make[5]: [Makefile:287: elfdep] Error 1 (ignored)
No zlib found
make[5]: [Makefile:290: zdep] Error 1 (ignored)
BPF API too old
make[5]: [Makefile:293: bpfdep] Error 1 (ignored)


but pkg-config tells me:

$ pkg-config --modversion  libelf
0.168
$ pkg-config --libs  libelf
-lelf


Any ideas?

thanks.

-- 
~Randy

