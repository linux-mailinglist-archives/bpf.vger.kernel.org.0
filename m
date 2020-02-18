Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6BC1624A5
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 11:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgBRKeC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Feb 2020 05:34:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33058 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRKeB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Feb 2020 05:34:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so23321648wrt.0
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2020 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2BhHbz6z8YTqeu/gQYCM/nPZKelCVYS9NAVSwsj0jvs=;
        b=LiG3SCzgCkh433wMfqqY6Yf8bxyCocTaXi/wnruYHXaZvDoVgf/uDt3LsZLWWfgR7l
         69A/ahnTplbSPh2z5yphCJCGpDQanTG/42ecjWRNX892pAA7jA14iHdf25zJgRD16Zyh
         Zqdpxe5fco7kiuJ+4oQp86D/naEZj/FomJUPzogoY1WJnmO0DxZx1qCK6rWWd+teA2ub
         EsNPJ6N1iphGG0uGpBJ2SS2RfwzMlPpcUGf7EZO662wcinCXq76PeZ9E9//uqZV5nhnF
         JGhvstMBdLLPAhGugPttI1CGOV+7xgP+HBERD5J9R6iZpMGm8hyo2vhWDuI5TrvCxemP
         0uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2BhHbz6z8YTqeu/gQYCM/nPZKelCVYS9NAVSwsj0jvs=;
        b=qkF2RrAyU++ambQPAVWOrmwOoJKlbazTih8/gFKhK/4zxcCpP5fW0qRzYv76ZDllSr
         aPGbj6SNTk8l+KjguNJFv/v87xnad9yImtmqNQa29SSq//gdoyZipFb/qJrkWmiU6p/B
         0EVe+dmANP4WpMnApRohO/kyKxZE9qPb/JQm4bYl9VwPJbs527nff612z1JKTn1CBVrO
         eKoe6S9XHGanaIT+NNuOeCjvuKAULIt1wbQPXSStFU2sh4co4QCGEu94kyDZZ7gUHN8c
         TAqWr0F0iKThz9bAsb7xreiGUKSBWSmBPCAJjgXpBxdKznVVcgLlQTJZtzg8EVekMf4G
         Zb3g==
X-Gm-Message-State: APjAAAXg88hJmlbtPvyjleDpl//zpVlqUAxELxK4IMnjUphyQQzJ4Xqp
        1G2sKolaH3uIWkUj8fzTUtiHJA==
X-Google-Smtp-Source: APXvYqw8IhAjn80T8c3NXFcvb3V/xoxS1vxK8flLE1vr4/DJoGiRaAdX3YCRynnghgIRVvhC6U+5CQ==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr26839162wrq.243.1582022039116;
        Tue, 18 Feb 2020 02:33:59 -0800 (PST)
Received: from [192.168.1.23] ([91.143.66.155])
        by smtp.gmail.com with ESMTPSA id f62sm2924857wmf.36.2020.02.18.02.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 02:33:58 -0800 (PST)
Subject: Re: [PATCH bpf] uapi/bpf: Remove text about bpf_redirect_map() giving
 higher performance
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        daniel@iogearbox.net, ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
References: <20200218074621.25391-1-toke@redhat.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <485aa804-0235-51dc-d3e2-02d71ae17266@isovalent.com>
Date:   Tue, 18 Feb 2020 10:33:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218074621.25391-1-toke@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-02-18 08:46 UTC+0100 ~ Toke Høiland-Jørgensen <toke@redhat.com>
> The performance of bpf_redirect() is now roughly the same as that of
> bpf_redirect_map(). However, David Ahern pointed out that the header file
> has not been updated to reflect this, and still says that a significant
> performance increase is possible when using bpf_redirect_map(). Remove this
> text from the bpf_redirect_map() description, and reword the description in
> bpf_redirect() slightly.
> 
> Fixes: 1d233886dd90 ("xdp: Use bulking for non-map XDP_REDIRECT and consolidate code paths")
> Suggested-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>   include/uapi/linux/bpf.h | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f1d74a2bd234..7a526d917fb3 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1045,9 +1045,9 @@ union bpf_attr {
>    * 		supports redirection to the egress interface, and accepts no
>    * 		flag at all.
>    *
> - * 		The same effect can be attained with the more generic
> - * 		**bpf_redirect_map**\ (), which requires specific maps to be
> - * 		used but offers better performance.
> + * 		The same effect can also be attained with the more generic
> + * 		**bpf_redirect_map**\ (), which uses a BPF map to store the
> + * 		redirect target instead of providing it directly to the helper.
>    * 	Return
>    * 		For XDP, the helper returns **XDP_REDIRECT** on success or
>    * 		**XDP_ABORTED** on error. For other program types, the values
> @@ -1610,12 +1610,6 @@ union bpf_attr {
>    * 		one of the XDP program return codes up to XDP_TX, as chosen by
>    * 		the caller. Any higher bits in the *flags* argument must be
>    * 		unset.
> - *
> - * 		When used to redirect packets to net devices, this helper
> - * 		provides a high performance increase over **bpf_redirect**\ ().
> - * 		This is due to various implementation details of the underlying
> - * 		mechanisms, one of which is the fact that **bpf_redirect_map**\
> - * 		() tries to send packet as a "bulk" to the device.
>    * 	Return
>    * 		**XDP_REDIRECT** on success, or **XDP_ABORTED** on error.
>    *
> 

We could maybe leave something like “See also bpf_redirect()" in the 
description of "bpf_redirect_map()"?

Either way,
Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks,
Quentin
