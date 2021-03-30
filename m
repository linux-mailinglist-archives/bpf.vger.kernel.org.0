Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0C134F0FD
	for <lists+bpf@lfdr.de>; Tue, 30 Mar 2021 20:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhC3SZG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 14:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232825AbhC3SYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 14:24:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A28DC619DA;
        Tue, 30 Mar 2021 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617128675;
        bh=PaVHp3GJPSvfPlmtRMKopTn2d6ryY9y416jYg0mkzlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4QDbP4SVZeH6WS3gPoDVnCXb0i2tivwlzp7ePrSdQE0NWfyzuz5W/MhJJEokQ7Eg
         jQSpkS3OHYGAOneunyEfc34hIRHY7QY3IU8eM6QaEgiY2Abp8OpicPn1EnwhmBOFoU
         TVXtp61TB6S6Nb2lmN938ETfbABA4KcrUSqkh4dV7z/4GfG680A+KkxT1bbiL8s9ov
         yxtzclvwF3aWIijp0rCnLvlqB6cEpvGqFEB/sL1q6XqxRLhdfYumxJgi5YIsA1BMp6
         YEG8UbSDG5ut9ZXLlc44ZTRrwMxMBmd/lL6txPFyUZpos0WIkK+fHVAnyHVRE6Rffd
         mlrzUNE5iIszw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC62340647; Tue, 30 Mar 2021 15:24:33 -0300 (-03)
Date:   Tue, 30 Mar 2021 15:24:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 0/3] permit merging all dwarf cu's for clang
 lto built binary
Message-ID: <YGNs4QxfGvQozqGS@kernel.org>
References: <20210328201400.1426437-1-yhs@fb.com>
 <YGIQ9c3Qk+DMa+C7@kernel.org>
 <YGM/Uh61RVExWnTU@kernel.org>
 <YGNpBlf7sLalcFWB@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGNpBlf7sLalcFWB@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 30, 2021 at 03:08:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> [acme@five pahole]$
> [acme@five pahole]$
> [acme@five pahole]$ fullcircle tcp_bbr.o
> [acme@five pahole]$
> 
> This one is dealt with, doing some more tests and looking at that
> array[] versus array[0].

I've pushed what I have to the main repos at kernel.org and github,
please check, I'll continue from there.

- Arnaldo
