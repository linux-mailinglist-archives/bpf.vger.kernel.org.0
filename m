Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E984469D3
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 21:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhKEUnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 16:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhKEUng (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 16:43:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26928C061205
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 13:40:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id iq11so3821253pjb.3
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ueXSBeq+4K0tCntAgLqU3Vs3zQ4msxoIioR8u7/EqEI=;
        b=mogbDFoPYvcFwHLljmKZEYBLTq9Tkp0r/amsWKGxxju5ZsXEfpwhC/vtw3ePhdyrHG
         loApahV06pfE+BdUG9z8q9ag7K8FH375Lx+C4RhBQmg3Z6mpKo3YGRf9guzW5Qhh3ZY3
         LlWuptqcHop+fHhHXS+RfrOgo7TJP1PNJ5Z/ffD5HbHExb5pDfFkwqbo7PtgV8lngscJ
         m0wWgeu3nw+TjKHDM+d9/PZAY/Yt3ZX3BjPmiUa8Kh96zIDJcyWWuopIHg5put54MoiJ
         iMbpCZt6TleMtxJp+XZkSRAnWDyDd8P5M2KzyTXx7QnF31EGB6ipEkHKTYEgXKOUpXLK
         Mh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ueXSBeq+4K0tCntAgLqU3Vs3zQ4msxoIioR8u7/EqEI=;
        b=fDL5zN2OHL3b4xpgKOxD9ixj5Oj5ajHyJkHqQPNo/Fcm6W7yKYYDtGp0mHoNeZyfcY
         tXRvZnMXV/XTo8bt9a6e0wZkmS6CSmG1izVWxjqDFdMKGFVy4LnaD6u6g7H6PvxaL7bS
         HFXDavhUJn1Qec0kwQNbstV8TtHUHoSUVXTv5dp6x24Fab+ph1OOfDcHI/8PZxG0zC7S
         QNGFvi31IeCmqKCDWNvGWnJ6/7g6yDSM1wJDDVTiooZMeLdmC5wd3+hamRfwEOq0Y5TJ
         kC2b3pCiI1u5CecXCOE7+VSJS+OPVtHUgl6v2I+D6VgNJ4vsVJReYssc2x5WwNNUtYdy
         eW5A==
X-Gm-Message-State: AOAM530T72Sx6VXlZs6YOH3hx7eYAdCLAxYNmqnLanb75pXQApRq1Mdm
        DQXBggGxhE+HV6Q7Ds4zVjU=
X-Google-Smtp-Source: ABdhPJy0OuUZ485SQLLlljNuMz5hlNadwg4oK/w4mYLMuCOIL4xSdLy/TaZaOhiYZYK3BsbUnsZrzw==
X-Received: by 2002:a17:902:bf07:b0:138:e32d:9f2e with SMTP id bi7-20020a170902bf0700b00138e32d9f2emr52411841plb.59.1636144855657;
        Fri, 05 Nov 2021 13:40:55 -0700 (PDT)
Received: from localhost ([2405:201:6014:d916:31fc:9e49:a605:b093])
        by smtp.gmail.com with ESMTPSA id v8sm6923691pjd.7.2021.11.05.13.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:40:55 -0700 (PDT)
Date:   Sat, 6 Nov 2021 02:10:51 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next] libbpf: fix non-C89 loop variable declaration
 in gen_loader.c
Message-ID: <20211105204051.v7wzca6fryb774m4@apollo.localdomain>
References: <20211105191055.3324874-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105191055.3324874-1-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 06, 2021 at 12:40:55AM IST, Andrii Nakryiko wrote:
> Fix the `int i` declaration inside the for statement. This is non-C89
> compliant. See [0] for user report breaking BCC build.
>
>   [0] https://github.com/libbpf/libbpf/issues/403
>
> Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC relocations")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for the fix, and sorry about that.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

--
Kartikeya
