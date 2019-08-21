Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF17984D5
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 21:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfHUTxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 15:53:01 -0400
Received: from www62.your-server.de ([213.133.104.62]:33036 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfHUTxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 15:53:01 -0400
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0WfB-0000NG-4P; Wed, 21 Aug 2019 21:52:57 +0200
Received: from [178.197.249.40] (helo=pc-63.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0WfA-00088k-TE; Wed, 21 Aug 2019 21:52:56 +0200
Subject: Re: [PATCH bpf v2] selftests/bpf: fix endianness issues in
 test_sysctl
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20190819105908.64863-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <40d41e83-61c3-5e08-f44d-4800763b1785@iogearbox.net>
Date:   Wed, 21 Aug 2019 21:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190819105908.64863-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25548/Wed Aug 21 10:27:18 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/19/19 12:59 PM, Ilya Leoshkevich wrote:
> A lot of test_sysctl sub-tests fail due to handling strings as a bunch
> of immediate values in a little-endian-specific manner.
> 
> Fix by wrapping all immediates in bpf_ntohl and the new bpf_be64_to_cpu.
> 
> Also, sometimes tests fail because sysctl() unexpectedly succeeds with
> an inappropriate "Unexpected failure" message and a random errno. Zero
> out errno before calling sysctl() and replace the message with
> "Unexpected success".
> 
> Fixes: 1f5fa9ab6e2e ("selftests/bpf: Test BPF_CGROUP_SYSCTL")
> Fixes: 9a1027e52535 ("selftests/bpf: Test file_pos field in bpf_sysctl ctx")
> Fixes: 6041c67f28d8 ("selftests/bpf: Test bpf_sysctl_get_name helper")
> Fixes: 11ff34f74e32 ("selftests/bpf: Test sysctl_get_current_value helper")
> Fixes: 786047dd08de ("selftests/bpf: Test bpf_sysctl_{get,set}_new_value helpers")
> Fixes: 8549ddc832d6 ("selftests/bpf: Test bpf_strtol and bpf_strtoul helpers")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> v1->v2: Use bpf_ntohl and bpf_be64_to_cpu, drop __bpf_le64_to_cpu.
> 
>   tools/testing/selftests/bpf/bpf_endian.h  |   7 ++
>   tools/testing/selftests/bpf/test_sysctl.c | 130 ++++++++++++++--------
>   2 files changed, 92 insertions(+), 45 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
> index 05f036df8a4c..f3be9322e89c 100644
> --- a/tools/testing/selftests/bpf/bpf_endian.h
> +++ b/tools/testing/selftests/bpf/bpf_endian.h
> @@ -29,6 +29,8 @@
>   # define __bpf_htonl(x)			__builtin_bswap32(x)
>   # define __bpf_constant_ntohl(x)	___constant_swab32(x)
>   # define __bpf_constant_htonl(x)	___constant_swab32(x)
> +# define __bpf_be64_to_cpu(x)		__builtin_bswap64(x)
> +# define __bpf_constant_be64_to_cpu(x)	___constant_swab64(x)
>   #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>   # define __bpf_ntohs(x)			(x)
>   # define __bpf_htons(x)			(x)
> @@ -38,6 +40,8 @@
>   # define __bpf_htonl(x)			(x)
>   # define __bpf_constant_ntohl(x)	(x)
>   # define __bpf_constant_htonl(x)	(x)
> +# define __bpf_be64_to_cpu(x)		(x)
> +# define __bpf_constant_be64_to_cpu(x)  (x)
>   #else
>   # error "Fix your compiler's __BYTE_ORDER__?!"
>   #endif
> @@ -54,5 +58,8 @@
>   #define bpf_ntohl(x)				\
>   	(__builtin_constant_p(x) ?		\
>   	 __bpf_constant_ntohl(x) : __bpf_ntohl(x))
> +#define bpf_be64_to_cpu(x)			\
> +	(__builtin_constant_p(x) ?		\
> +	 __bpf_constant_be64_to_cpu(x) : __bpf_be64_to_cpu(x))
>   
>   #endif /* __BPF_ENDIAN__ */

By the way, looks like progs/test_lwt_seg6local.c defines its own ntohll()/htonll(),
could we make this two patches: i) consolidating the former by adding proper variants
to bpf_endian.h (I mean generically) and ii) fixing test_sysctl.c by using them? Thinking
addition of i) as plan for bpf-next would be to move bpf_endian.h as proper API into
libbpf in near future such that BPF progs don't need to redefine them.

Thanks,
Daniel
