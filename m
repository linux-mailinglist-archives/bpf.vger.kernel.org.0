Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB7045E2FA
	for <lists+bpf@lfdr.de>; Thu, 25 Nov 2021 23:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhKYW0v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Nov 2021 17:26:51 -0500
Received: from www62.your-server.de ([213.133.104.62]:49736 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345267AbhKYWY7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Nov 2021 17:24:59 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mqN7i-0006AV-62; Thu, 25 Nov 2021 23:21:46 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mqN7i-0000wV-12; Thu, 25 Nov 2021 23:21:46 +0100
Subject: Re: [PATCH bpf-next 03/13] libbpf: prevent UBSan from complaining
 about integer overflow
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     kernel-team@fb.com
References: <20211124002325.1737739-1-andrii@kernel.org>
 <20211124002325.1737739-4-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9e00239a-b44c-88d9-39b4-5e0ad7d49f3b@iogearbox.net>
Date:   Thu, 25 Nov 2021 23:21:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211124002325.1737739-4-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26364/Thu Nov 25 10:20:31 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/24/21 1:23 AM, Andrii Nakryiko wrote:
> Integer overflow is intentional, silence the sanitizer. It works
> completely reliably on sane compilers and architectures.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/lib/bpf/btf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8024fe355ca8..be1dafd56a13 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3127,6 +3127,7 @@ struct btf_dedup {
>   	struct strset *strs_set;
>   };
>   
> +__attribute__((no_sanitize("signed-integer-overflow")))
>   static long hash_combine(long h, long value)
>   {
>   	return h * 31 + value;
> 

Sgtm, I guess my only question, was there a reason for not using e.g. __u64 in
the first place? Meaning, __u64 hash_combine(__u64 h, __u64 value) plus the
call-sites where you have h variable re-feeding into hash_combine().
