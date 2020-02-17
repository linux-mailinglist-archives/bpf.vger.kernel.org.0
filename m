Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B765F1616A4
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2020 16:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgBQPvu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Feb 2020 10:51:50 -0500
Received: from www62.your-server.de ([213.133.104.62]:33808 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgBQPvu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Feb 2020 10:51:50 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j3igV-0008VT-Oq; Mon, 17 Feb 2020 16:51:47 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux-3.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j3igV-000Tkh-EV; Mon, 17 Feb 2020 16:51:47 +0100
Subject: Re: [PATCH] bpf: Avoid function casting when calculating immediate
To:     Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
References: <202001291335.31F425A198@keescook>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <92bcfdab-79df-c3f4-bae8-00116b39e015@iogearbox.net>
Date:   Mon, 17 Feb 2020 16:51:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <202001291335.31F425A198@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.1/25726/Mon Feb 17 15:01:07 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/29/20 10:36 PM, Kees Cook wrote:
> In an effort to enable -Wcast-function-type in the top-level Makefile
> to support Control Flow Integrity builds, rework the BPF instruction
> immediate calculation macros to avoid mismatched function pointers. Since
> these calculations are only ever between function address (these are
> not function calls, just address calculations), they can be cast to u64
> instead, where the result will be assigned to the s32 insn->imm.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   include/linux/filter.h |  6 +++---
>   kernel/bpf/hashtab.c   |  6 +++---
>   kernel/bpf/verifier.c  | 21 +++++++--------------
>   3 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f349e2c0884c..b5beee7bf2ea 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -340,8 +340,8 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>   
>   /* Function call */
>   
> -#define BPF_CAST_CALL(x)					\
> -		((u64 (*)(u64, u64, u64, u64, u64))(x))
> +#define BPF_FUNC_IMM(FUNC)					\
> +		((u64)(FUNC) - (u64)__bpf_call_base)

Looks good to me in general. My only concern is compilation on 32bit archs: I think
the cast needs to be of '(u64)(unsigned long)' to avoid introducing new warnings a la
'cast from pointer to integer of different size'.

Thanks,
Daniel
