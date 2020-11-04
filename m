Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF92A6994
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 17:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgKDQ0F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 11:26:05 -0500
Received: from www62.your-server.de ([213.133.104.62]:48160 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbgKDQY4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 11:24:56 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kaLaf-0006B2-1b; Wed, 04 Nov 2020 17:24:53 +0100
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kaLae-000QKB-Sh; Wed, 04 Nov 2020 17:24:52 +0100
Subject: Re: [PATCH bpf-next] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org
Cc:     kernel-team@fb.com
References: <eb78270e61e4d2e8ece047430d8397e000ef8569.1604456921.git.dxu@dxuuu.xyz>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7831c092-5ab4-033e-8fb3-ad9702332d79@iogearbox.net>
Date:   Wed, 4 Nov 2020 17:24:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <eb78270e61e4d2e8ece047430d8397e000ef8569.1604456921.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25978/Wed Nov  4 14:18:13 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/4/20 3:29 AM, Daniel Xu wrote:
> do_strncpy_from_user() may copy some extra bytes after the NUL
> terminator into the destination buffer. This usually does not matter for
> normal string operations. However, when BPF programs key BPF maps with
> strings, this matters a lot.
> 
> A BPF program may read strings from user memory by calling the
> bpf_probe_read_user_str() helper which eventually calls
> do_strncpy_from_user(). The program can then key a map with the
> resulting string. BPF map keys are fixed-width and string-agnostic,
> meaning that map keys are treated as a set of bytes.
> 
> The issue is when do_strncpy_from_user() overcopies bytes after the NUL
> terminator, it can result in seemingly identical strings occupying
> multiple slots in a BPF map. This behavior is subtle and totally
> unexpected by the user.
> 
> This commit uses the proper word-at-a-time APIs to avoid overcopying.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

It looks like this is a regression from the recent refactoring of the mem probing
util functions? Could we add a Fixes tag and then we'd also need to target the fix
against bpf tree instead of bpf-next, no?

Moreover, a BPF kselftest would help to make sure it doesn't regress in future again.

Thanks,
Daniel
