Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499711B2D3
	for <lists+bpf@lfdr.de>; Mon, 13 May 2019 11:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfEMJ0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 05:26:15 -0400
Received: from www62.your-server.de ([213.133.104.62]:37890 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfEMJ0P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 05:26:15 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hQ7Do-0003uI-7G; Mon, 13 May 2019 11:26:12 +0200
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hQ7Do-00054A-1p; Mon, 13 May 2019 11:26:12 +0200
Subject: Re: [PATCH bpf-next 1/2] bpf: btf: fix the brackets of
 BTF_INT_OFFSET()
To:     Gary Lin <glin@suse.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>
References: <20190513091158.6200-1-glin@suse.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8830ebf0-e73e-b08a-9a42-cc6b4ca18453@iogearbox.net>
Date:   Mon, 13 May 2019 11:26:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190513091158.6200-1-glin@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25448/Mon May 13 09:57:34 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/13/2019 11:11 AM, Gary Lin wrote:
> 'VAL' should be protected by the brackets.
> 
> Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
> Signed-off-by: Gary Lin <glin@suse.com>
> ---
>  include/uapi/linux/btf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 9310652ca4f9..63ae4a39e58b 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -83,7 +83,7 @@ struct btf_type {
>   * is the 32 bits arrangement:
>   */
>  #define BTF_INT_ENCODING(VAL)	(((VAL) & 0x0f000000) >> 24)
> -#define BTF_INT_OFFSET(VAL)	(((VAL  & 0x00ff0000)) >> 16)
> +#define BTF_INT_OFFSET(VAL)	(((VAL) & 0x00ff0000) >> 16)
>  #define BTF_INT_BITS(VAL)	((VAL)  & 0x000000ff)
>  
>  /* Attributes stored in the BTF_INT_ENCODING */
> 

I'm okay with that fix, but could you please squash patch 1 and
patch 2 into a single one? I don't think it's worth splitting them
here.

Thanks,
Daniel
