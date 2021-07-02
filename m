Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6313B9F19
	for <lists+bpf@lfdr.de>; Fri,  2 Jul 2021 12:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhGBKcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Jul 2021 06:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230049AbhGBKcK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 2 Jul 2021 06:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625221778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DPxMNn2CCE4cxpTvsVh+CYPLZZTodxuHXGUXkbr4MMw=;
        b=J+3mHCuS+6c0bFEgHQALhqxkHp32DumMACx9d7cpcfDVK1u5j2xT9YKtX3aRTUpibvNoBT
        vS5dmburJQhUMuqK0pRsJY6YcTDj5FtWereFb9qGwd3LV+KuDrBPclCzUA3gnDkyIe0uK/
        dAx0lIiXJCZhsamVwLoT5H/Jj2YvyMA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-dHVkvTcONwC45OVL77uq2Q-1; Fri, 02 Jul 2021 06:29:37 -0400
X-MC-Unique: dHVkvTcONwC45OVL77uq2Q-1
Received: by mail-ed1-f69.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso4908747edd.12
        for <bpf@vger.kernel.org>; Fri, 02 Jul 2021 03:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DPxMNn2CCE4cxpTvsVh+CYPLZZTodxuHXGUXkbr4MMw=;
        b=QIEHTN7nFmQ5jNH3pM+PNV8C9YUPacbrIsgjXJAnWIssJUniydeAYWlLvaXfIf7RFo
         lO+1kmM8Jheub15p+jkgt6iMaWWyfkkNM/ehNopDPiJ9W/WtJvlT2IOZ7urtXSNHloIA
         s8NBqkG1sjGiqthBRpe0BWtBrllCv/f0cX+DflVuBy64F5BjOh0yF0ZzQTcWHfkgZkit
         hGpOh608iRLWBnJBE0u1lAt5JaKuU8+Zp2LXWCJ2A3nadiPJIiLnEObUqw8vBdUCqvbM
         0TTdXTQcHqRUKoJLsskN9L/W+Nu6Q1A4Jrw+hfZBiRirB6TUG33909DbNiOV9EFb8wQm
         9btw==
X-Gm-Message-State: AOAM533IADd4Ay60xDHlXclOYf/Q/UKQTpcYHfHKFgYS3CcNshDEPuY+
        X+H1kZC8txVKe7AHNkk9trjZiyvOHot614ADZFi9fAV2tMu/pYg8nq+HYkPndTJGVrSL+0zFzA6
        B+f74nq+kTjaj
X-Received: by 2002:a05:6402:2813:: with SMTP id h19mr5739017ede.39.1625221776627;
        Fri, 02 Jul 2021 03:29:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeTV7Vr11aiyTEXIqNuKKngfk6mHPBCj/YJvYik4FkcZfq09iNjgHFyinId+fVKL5hjUuW0Q==
X-Received: by 2002:a05:6402:2813:: with SMTP id h19mr5739002ede.39.1625221776482;
        Fri, 02 Jul 2021 03:29:36 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id br4sm666879ejb.110.2021.07.02.03.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 03:29:36 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf] samples/bpf: Fix the error return code of
 xdp_redirect's main()
To:     Wang Hai <wanghai38@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210616042534.315097-1-wanghai38@huawei.com>
Message-ID: <94aad4ed-8384-1841-88ec-6c7e39d63148@redhat.com>
Date:   Fri, 2 Jul 2021 12:29:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616042534.315097-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 16/06/2021 06.25, Wang Hai wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

The main() function in C should never return a negative value on Unix 
POSIX systems.


There is a good explaination in exit(3p): `man 3p exit`

    The  value  of  status may be 0, EXIT_SUCCESS, EXIT_FAILURE, or any 
other value, though only the least significant 8 bits (that is, status & 
0377) shall be available to a waiting parent process.

Thus, negative values are often seen as 255 in the $? program exit 
status variable $?.


Also explained in exit(3):

     The C standard specifies two constants, EXIT_SUCCESS=0 and 
EXIT_FAILURE=1.

I see the 'samples/bpf/xdp_redirect_user.c' in most places just use 0 or 1.


> If bpf_map_update_elem() failed, main() should return a negative error.
>
> Fixes: 832622e6bd18 ("xdp: sample program for new bpf_redirect helper")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>   samples/bpf/xdp_redirect_user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/samples/bpf/xdp_redirect_user.c b/samples/bpf/xdp_redirect_user.c
> index 41d705c3a1f7..c903f1ccc15e 100644
> --- a/samples/bpf/xdp_redirect_user.c
> +++ b/samples/bpf/xdp_redirect_user.c
> @@ -213,5 +213,5 @@ int main(int argc, char **argv)
>   	poll_stats(2, ifindex_out);
>   
>   out:
> -	return 0;
> +	return ret;
>   }


(Sorry, I didn't complain it time as I see this patch is already applied)

