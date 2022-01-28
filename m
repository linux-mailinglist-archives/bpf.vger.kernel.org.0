Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E1D49FA6C
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 14:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbiA1NRM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 08:17:12 -0500
Received: from www62.your-server.de ([213.133.104.62]:36408 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbiA1NRL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 08:17:11 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nDR7m-0008Hz-6M; Fri, 28 Jan 2022 14:17:10 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nDR7m-000Xc3-1b; Fri, 28 Jan 2022 14:17:10 +0100
Subject: Re: [PATCH bpf-next] libbpf: deprecate btf_ext rec_size APIs
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20220127182154.751999-1-davemarchevsky@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <40170ce7-a346-dc2e-3f3c-dbd533d2341b@iogearbox.net>
Date:   Fri, 28 Jan 2022 14:17:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220127182154.751999-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26436/Fri Jan 28 10:22:17 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/27/22 7:21 PM, Dave Marchevsky wrote:
> btf_ext__{func,line}_info_rec_size functions are used in conjunction
> with already-deprecated btf_ext__reloc_{func,line}_info functions. Since
> struct btf_ext is opaque to the user it was necessary to expose rec_size
> getters in the past.
> 
> btf_ext__reloc_{func,line}_info were deprecated in commit 8505e8709b5ee
> ("libbpf: Implement generalized .BTF.ext func/line info adjustment")
> as they're not compatible with support for multiple programs per
> section. It was decided[0] that users of these APIs should implement their
> own .btf.ext parsing to access this data, in which case the rec_size
> getters are unnecessary. So deprecate them from libbpf 0.7.0 onwards.
> 
>    [0] Closes: https://github.com/libbpf/libbpf/issues/277
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   tools/lib/bpf/btf.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 96b44d55db6e..c2f89a2cca11 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -168,7 +168,9 @@ int btf_ext__reloc_line_info(const struct btf *btf,
>   			     const struct btf_ext *btf_ext,
>   			     const char *sec_name, __u32 insns_cnt,
>   			     void **line_info, __u32 *cnt);
> +LIBBPF_DEPRECATED_SINCE(0, 7, "btf_ext__reloc_func_info is deprecated; write custom func_info parsing to fetch rec_size")
>   LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext);
> +LIBBPF_DEPRECATED_SINCE(0, 7, "btf_ext__reloc_line_info is deprecated; write custom line_info parsing to fetch rec_size")
>   LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext);

The btf_ext__reloc_{func,line}_info() only use LIBBPF_DEPRECATED() instead of
LIBBPF_DEPRECATED_SINCE(). If they are used in conjunction with the other ones,
should we either mark all of them LIBBPF_DEPRECATED_SINCE(0, 7, [...]) or just
all as LIBBPF_DEPRECATED() ?

>   LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
> 

Thanks,
Daniel
