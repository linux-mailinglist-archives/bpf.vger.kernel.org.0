Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4B618E8B
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 04:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKDDAe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 23:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKDDAd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 23:00:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F51F2DD
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 20:00:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k5so3389440pjo.5
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 20:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RYyDWbyPJ62+nSnSuyiuVKQbDLXBUYM3ewe3muPhhjY=;
        b=QOqOzEKW8Xp8VV/qQDk7ctwQk8PVyKIkrtuHbKMBQAU2i2T1lN6ersFxjBhK2hnE4A
         4T/E4fZeZDTYu8xVvUwdlWEfds2MRvCbXeoqzkB/akIMwQ+oz+nN5DQsW54reL7N1Ikg
         YyINCl+uL5NwYV+u5fosGV/WLgdRbNT8f4JFkuUeUN8kQWlMKAJyLZKGVIXJ5GRx1soP
         /09A6EUOVy6SnCVYzkYP4DDcAcujl02NH1Ri/AGkY3ltaX4R8e7E45nICi73zpb6Z9K1
         sZSm9u031p5lKSwRmkO7Qqprs4cVAbdLIj402Mfz44EGlI9PgfcGaIT1cgckSPCDq3pm
         9GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYyDWbyPJ62+nSnSuyiuVKQbDLXBUYM3ewe3muPhhjY=;
        b=HlfcWtJOPRfIfrsWesibFam2J9m5Nu+00m+/G7fFRwlesqdFcSE0kquKkGk6DEOZxf
         FbIKFIbunucbsVmWUPw53WcgKdW/lTf3uI8G7hxIER7YHotrJaEza27xvdSxAmLNq9jL
         t9zQtcHiom9NmMTUEXKD4WNZjpQxi2LW2bHrLL/x18K5jE1kDMHshw4zmyl1Ip6NGfnk
         WkFcf5OtLdShObzFDM4e6TcAM4DFAZpn5GW6MsBPgiQWtBP+YoEu/tYUIpI7SK1pZmzi
         ftbBHyqS2+P1jDyEHawXrHnhYbxvABD8CFju4QS6uLhLbRcp41yt0Kfztja1IximGd/l
         1zcw==
X-Gm-Message-State: ACrzQf2mlf1TF8/ydouyhoeLa6if4fQ33HGZhAHFgf/hSrfDU7Kh6yIw
        EQbtBqrn91wHrqEAk/xbT80=
X-Google-Smtp-Source: AMsMyM442dW9U1aBiiwfLsYURVhqo2C3D4xGWe7hfbhsDLYNeDLfEYjXD+dEWnAaBjJWOqtSVTV9Eg==
X-Received: by 2002:a17:90a:5987:b0:215:d4e8:6f7f with SMTP id l7-20020a17090a598700b00215d4e86f7fmr10125518pji.246.1667530831970;
        Thu, 03 Nov 2022 20:00:31 -0700 (PDT)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:2035])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902cad100b001873aa85e1fsm1299562pld.305.2022.11.03.20.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:00:31 -0700 (PDT)
Date:   Thu, 3 Nov 2022 20:00:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 06/24] bpf: Refactor kptr_off_tab into
 btf_record
Message-ID: <20221104030028.muy5ui3an3vkdfqg@macbook-pro-5.dhcp.thefacebook.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-7-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103191013.1236066-7-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 12:39:55AM +0530, Kumar Kartikeya Dwivedi wrote:
>  		else
> @@ -311,11 +344,12 @@ static inline void __copy_map_value(struct bpf_map *map, void *dst, void *src, b
>  		return;
>  	}
>  
> -	for (i = 0; i < map->off_arr->cnt; i++) {
> -		u32 next_off = map->off_arr->field_off[i];
> +	for (i = 0; i < map->field_offs->cnt; i++) {
> +		u32 next_off = map->field_offs->field_off[i];
> +		u32 sz = next_off - curr_off;
>  
> -		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
> -		curr_off += map->off_arr->field_sz[i];
> +		memcpy(dst + curr_off, src + curr_off, sz);
> +		curr_off += map->field_offs->field_sz[i] + sz;

This is a clear bug. The kernel is crashing with this change.
How did you test this?

>  	}
>  	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
>  }
> @@ -335,16 +369,17 @@ static inline void zero_map_value(struct bpf_map *map, void *dst)
>  	u32 curr_off = 0;
>  	int i;
>  
> -	if (likely(!map->off_arr)) {
> +	if (likely(!map->field_offs)) {
>  		memset(dst, 0, map->value_size);
>  		return;
>  	}
>  
> -	for (i = 0; i < map->off_arr->cnt; i++) {
> -		u32 next_off = map->off_arr->field_off[i];
> +	for (i = 0; i < map->field_offs->cnt; i++) {
> +		u32 next_off = map->field_offs->field_off[i];
> +		u32 sz = next_off - curr_off;
>  
> -		memset(dst + curr_off, 0, next_off - curr_off);
> -		curr_off += map->off_arr->field_sz[i];
> +		memset(dst + curr_off, 0, sz);
> +		curr_off += map->field_offs->field_sz[i] + sz;

same thing
