Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A0241B86
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgHKNT1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Aug 2020 09:19:27 -0400
Received: from www62.your-server.de ([213.133.104.62]:59386 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgHKNT0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Aug 2020 09:19:26 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k5UBY-0004ro-UD; Tue, 11 Aug 2020 15:19:24 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k5UBY-0008aB-Od; Tue, 11 Aug 2020 15:19:24 +0200
Subject: Re: [PATCH bpf] libbpf: do not use __builtin_offsetof for offsetof
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, kernel-team@fb.com,
        Ian Rogers <irogers@google.com>
References: <20200811030852.3396929-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b868a00c-c1c0-3309-78bd-1a0f54e2fa7d@iogearbox.net>
Date:   Tue, 11 Aug 2020 15:19:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200811030852.3396929-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25900/Mon Aug 10 14:44:29 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/11/20 5:08 AM, Yonghong Song wrote:
> Commit 5fbc220862fc ("tools/libpf: Add offsetof/container_of macro
> in bpf_helpers.h") added a macro offsetof() to get the offset of a
> structure member:
>     #define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
> 
> In certain use cases, size_t type may not be available so
> Commit da7a35062bcc ("libbpf bpf_helpers: Use __builtin_offsetof
> for offsetof") changed to use __builtin_offsetof which removed
> the dependency on type size_t, which I suggested.
> 
> But using __builtin_offsetof will prevent CO-RE relocation
> generation in case that, e.g., TYPE is annotated with "preserve_access_info"
> where a relocation is desirable in case the member offset is changed
> in a different kernel version. So this patch reverted back to
> the original macro but using "unsigned long" instead of "site_t".
> 
> Cc: Ian Rogers <irogers@google.com>
> Fixes: da7a35062bcc ("libbpf bpf_helpers: Use __builtin_offsetof for offsetof")
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied, thanks!
