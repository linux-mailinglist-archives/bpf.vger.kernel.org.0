Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04F12066F2
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 00:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbgFWWKv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 18:10:51 -0400
Received: from www62.your-server.de ([213.133.104.62]:54444 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387840AbgFWWKu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 18:10:50 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jnr7u-0001e0-AO; Wed, 24 Jun 2020 00:10:46 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jnr7u-000Pcg-3G; Wed, 24 Jun 2020 00:10:46 +0200
Subject: Re: [PATCH bpf-next] tools, bpftool: Correctly evaluate
 $(BUILD_BPF_SKELS) in Makefile
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
References: <20200623103710.10370-1-tklauser@distanz.ch>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <767ff3e9-ee4e-eb2c-93fb-04faa76193a5@iogearbox.net>
Date:   Wed, 24 Jun 2020 00:10:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200623103710.10370-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25852/Tue Jun 23 15:09:58 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/23/20 12:37 PM, Tobias Klauser wrote:
> Currently, if the clang-bpf-co-re feature is not available, the build
> fails with e.g.
> 
>    CC       prog.o
> prog.c:1462:10: fatal error: profiler.skel.h: No such file or directory
>   1462 | #include "profiler.skel.h"
>        |          ^~~~~~~~~~~~~~~~~
> 
> This is due to the fact that the BPFTOOL_WITHOUT_SKELETONS macro is not
> defined, despite BUILD_BPF_SKELS not being set. Fix this by correctly
> evaluating $(BUILD_BPF_SKELS) when deciding on whether to add
> -DBPFTOOL_WITHOUT_SKELETONS to CFLAGS.
> 
> Fixes: 05aca6da3b5a ("tools/bpftool: Generalize BPF skeleton support and generate vmlinux.h")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied, thanks!
