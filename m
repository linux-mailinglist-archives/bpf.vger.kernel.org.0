Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F175C2B215D
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 18:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgKMRDr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 12:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKMRDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 12:03:47 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161BAC0613D1;
        Fri, 13 Nov 2020 09:03:47 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f38so7579747pgm.2;
        Fri, 13 Nov 2020 09:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LhcpeztEhSnyyz+1aO3teOqINwXSucg4ESEzc6WPeoc=;
        b=AQdsm3MNp3mnIFMz+QGpN/DdQymvfXKXy/SHFNWla4oGk4ObNpS8YeBTichXw4Esaz
         71lSz7Cf2rgyBp5NvhxZbqu7EhhJwWU2UEwAhZY9n3e0I+XapO0ZdkHmKgHmqxFAabRp
         hJjEXzdYHnXXDSTjdc5ZhbgLHBjIFl4HLic+AbVpAfunDIv+8YqaxyzObpZCXnYaO3jI
         EGVTnn6/rqiDpoq/ISpOi+BJmIZ4A6dHXHWvAlQHvPysVliTN1wlgaKpeU53OyVdIsjA
         hO6HYztdczTt8O4y5ONSc+Mv6bLCB1g+5twCHGh8fI427JBXYCSxgLWjPYJlSjHRO/07
         1JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LhcpeztEhSnyyz+1aO3teOqINwXSucg4ESEzc6WPeoc=;
        b=Fos3E/Jg3YTcoQ3eHtvfwdGkU9WRnycZ2ZtVuOKympWVqIYbSztLRkGEoHTXeI1wy0
         NdMvmDkvXFx7SpKOgFmkh1+KiMPj6V546kMGt8e1a3QPOrnpBYmDEYB9Ei1FZC8x43S8
         Y2Kohscl1XnChBISkMtX/ewUs9SanPGhkeAKWl65ReJpMpVL17Vs0LYVxDLOLBW3r/zM
         Zgx2J4SZEwhJ1GGAhtHQTlh9VlfVFYgqlTbXahzmYQvVnee1yPdZXxFaQfObPJrN+jDV
         0WT8LS/81wF5MV6znDCCS/jfo5DmKTOY7Y1SsciRIf075l0nKe+ba9Xp7mbkTDI35foK
         AcyA==
X-Gm-Message-State: AOAM532/AHE6TpmTArKbmrM2X8lnr5yMNbes4nqT51EVzfXj5L8s0og8
        RYiOLf3vydnwd2V3NTzReXw=
X-Google-Smtp-Source: ABdhPJz9yGWn+D7BjLTOVW78Tfs7NDadFZE5vy8vdY6BwlWMGcXYND0VF/H8u81orR69wieqFf1h1A==
X-Received: by 2002:a63:5466:: with SMTP id e38mr2771895pgm.23.1605287021817;
        Fri, 13 Nov 2020 09:03:41 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:b8c0])
        by smtp.gmail.com with ESMTPSA id k8sm9192571pgi.39.2020.11.13.09.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:03:40 -0800 (PST)
Date:   Fri, 13 Nov 2020 09:03:38 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH bpf v5 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Message-ID: <20201113170338.3uxdgb4yl55dgto5@ast-mbp>
References: <cover.1605134506.git.dxu@dxuuu.xyz>
 <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 02:45:54PM -0800, Daniel Xu wrote:
> do_strncpy_from_user() may copy some extra bytes after the NUL
> terminator into the destination buffer. This usually does not matter for
> normal string operations. However, when BPF programs key BPF maps with
> strings, this matters a lot.
> 
> A BPF program may read strings from user memory by calling the
> bpf_probe_read_user_str() helper which eventually calls
> do_strncpy_from_user(). The program can then key a map with the
> resulting string. BPF map keys are fixed-width and string-agnostic,
> meaning that map keys are treated as a set of bytes.
> 
> The issue is when do_strncpy_from_user() overcopies bytes after the NUL
> terminator, it can result in seemingly identical strings occupying
> multiple slots in a BPF map. This behavior is subtle and totally
> unexpected by the user.
> 
> This commit has strncpy start copying a byte at a time if a NUL is
> spotted.
> 
> Fixes: 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{user, kernel}_str helpers")
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  lib/strncpy_from_user.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index e6d5fcc2cdf3..83180742e729 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -40,12 +40,11 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
>  		/* Fall back to byte-at-a-time if we get a page fault */
>  		unsafe_get_user(c, (unsigned long __user *)(src+res), byte_at_a_time);
>  
> +		if (has_zero(c, &data, &constants))
> +			goto byte_at_a_time;
> +
>  		*(unsigned long *)(dst+res) = c;
> -		if (has_zero(c, &data, &constants)) {
> -			data = prep_zero_mask(c, data, &constants);
> -			data = create_zero_mask(data);
> -			return res + find_zero(data);
> -		}
> +
>  		res += sizeof(unsigned long);
>  		max -= sizeof(unsigned long);
>  	}

The fix looks good to me. It's indeed better than v4 approach.

Linus,
I think you might have an opinion about it.
Please see commit log for the reason we need this fix.
