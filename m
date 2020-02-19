Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3DB164B38
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 17:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgBSQ4i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 11:56:38 -0500
Received: from www62.your-server.de ([213.133.104.62]:41920 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSQ4i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 11:56:38 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j4SeK-0005bf-NG; Wed, 19 Feb 2020 17:56:36 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux-3.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j4SeK-0005ud-Ff; Wed, 19 Feb 2020 17:56:36 +0100
Subject: Re: [PATCH bpf-next] selftests/bpf: change llvm flag -mcpu=probe to
 -mcpu=v3
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@fb.com>, kernel-team@fb.com
References: <20200219004236.2291125-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <956ccea3-0440-7c59-9c75-90cd7b25afb7@iogearbox.net>
Date:   Wed, 19 Feb 2020 17:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200219004236.2291125-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.1/25728/Wed Feb 19 15:06:20 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/19/20 1:42 AM, Yonghong Song wrote:
> The latest llvm supports cpu version v3, which is cpu version v1
> plus some additional 64bit jmp insns and 32bit jmp insn support.
> 
> In selftests/bpf Makefile, the llvm flag -mcpu=probe did runtime
> probe into the host system. Depending on compilation environments,
> it is possible that runtime probe may fail, e.g., due to
> memlock issue. This will cause generated code with cpu version v1.

But those are tiny BPF progs that LLVM is probing. If memlock is not
sufficient, should it try to bump the limit with the diff needed and
only if that fails as well then it bails out to v1.

> This may cause confusion as the same compiler and the same C code
> generates different byte codes in different environment.
> 
> Let us change the llvm flag -mcpu=probe to -mcpu=v3 so the
> generated code will be the same regardless of the compilation
> environment.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
