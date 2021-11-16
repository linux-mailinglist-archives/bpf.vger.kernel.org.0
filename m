Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA533453229
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 13:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhKPMar (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 07:30:47 -0500
Received: from www62.your-server.de ([213.133.104.62]:36702 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbhKPMap (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 07:30:45 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mmxYv-000FW1-Tn; Tue, 16 Nov 2021 13:27:45 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mmxYv-0005kU-OL; Tue, 16 Nov 2021 13:27:45 +0100
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add a dedup selftest with
 equivalent structure types
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com
References: <20211115163932.3921753-1-yhs@fb.com>
 <20211115163943.3922547-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d7ce592f-9dcd-3bde-7f61-12d46e352dca@iogearbox.net>
Date:   Tue, 16 Nov 2021 13:27:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211115163943.3922547-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26355/Tue Nov 16 10:24:27 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/15/21 5:39 PM, Yonghong Song wrote:
> Without previous libbpf patch, the following error will occur:
>    $ ./test_progs -t btf
>    ...
>    do_test_dedup:FAIL:check btf_dedup failed errno:-22#13/205 btf/dedup: btf_type_tag #5, struct:FAIL
> 
> And the previfous libbpf patch fixed the issue.

Fixed up the typo above while applying and also formatted the 1/2 a bit better.
checkpatch usually has a lot of noise in its output, but it would catch things
like typos when quickly running before submission, fwiw. Anyway, thanks!
