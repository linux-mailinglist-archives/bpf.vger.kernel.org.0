Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7844B3E54EB
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhHJIOg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 04:14:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:52008 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhHJIOg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 04:14:36 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDMtn-0003RA-QT; Tue, 10 Aug 2021 10:14:11 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDMtn-000RY0-KU; Tue, 10 Aug 2021 10:14:11 +0200
Subject: Re: [PATCH bpf v3 2/2] bpf: add missing bpf_read_[un]lock_trace() for
 syscall program
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com
References: <20210809235141.1663247-1-yhs@fb.com>
 <20210809235151.1663680-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <78d47476-c81c-c699-c582-c7030a83e237@iogearbox.net>
Date:   Tue, 10 Aug 2021 10:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210809235151.1663680-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26258/Mon Aug  9 10:18:46 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/10/21 1:51 AM, Yonghong Song wrote:
> Commit 79a7f8bdb159d ("bpf: Introduce bpf_sys_bpf() helper and program type.")
> added support for syscall program, which is a sleepable program.
> But the program run missed bpf_read_lock_trace()/bpf_read_unlock_trace(),
> which is needed to ensure proper rcu callback invocations.
> This patch added bpf_read_[un]lock_trace() properly.
> 
> Fixes: 79a7f8bdb159d ("bpf: Introduce bpf_sys_bpf() helper and program type.")
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>

(Took this one in already while we clarify 1/2, thanks!)
