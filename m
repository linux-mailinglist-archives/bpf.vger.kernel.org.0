Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78438247B68
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 02:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHRAOu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 20:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRAOt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 20:14:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DD2C061389
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 17:14:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so14198034wmd.1
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 17:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yGv/4URxeGP8OrkMz246qgPy2SDlzkCa7CY4xv595zQ=;
        b=TNjoVvmn2PAZpmXOJy7UkV3G66rnwrSi3oIwTIXGZqsSDUf8bpcU4PtM/BpO9M01mD
         u/IkXjjDRRfw84Zvdfet9KwaDjz3YGyZiGMo5S4oevo5Xge1zPYJWLW/lc/Is2Y5a8uL
         6BHJ3qJ3u+jiDgyc3MGxRN4a1jwrAN+wve5j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yGv/4URxeGP8OrkMz246qgPy2SDlzkCa7CY4xv595zQ=;
        b=rscXZOnjoaVS/b3Fc+WTjhdAleV4bWxtG+y2iZ2+z06wzhzg3GJ2NvuawEfidot2ah
         LwQRATh8wQDvbm42uC740q3ULQbgBYUtGaS30vb3CzOOJF0u54hkJ5iUTUWkOEwOlsFo
         z4kF+a76/nIDu6xlZAPLqWt8YQQDMVebRHYJTZYsha3frWZ+4lU8c39exAeGwUZwyyfe
         YdpkLfsFc63kSi1KR8Rphn8ZRkrEoH9p3tufj1DvJUaPfgzPy78Syvtcv9LW9HhK6w4r
         xK5iROnn3MVEyU7ugMHbn4BKYUfzuT5E5IlLyU2hiIONrVjqhSlfVsOPw85FyGaDR4VP
         pqzA==
X-Gm-Message-State: AOAM5313WOZYuyRPIfv2jeWtUTu255gxHs2LHu26auCmXh5U17C5efCp
        0DICmV9/ie6G5OlPnkLmgyvUZQ==
X-Google-Smtp-Source: ABdhPJxhcxVNrXBnn9lFe2DY9wx7SGMAZAp6qAPYKGP6pMrzcjatKHn9BAQ5fomgAg6oQ7Gw8jP9cg==
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr17017023wmj.79.1597709685690;
        Mon, 17 Aug 2020 17:14:45 -0700 (PDT)
Received: from kpsingh-macbookpro2.roam.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id o2sm31231763wrj.21.2020.08.17.17.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 17:14:45 -0700 (PDT)
Subject: Re: [RFC PATCH v11 bpf-next 10/14] bpf: Add d_path helper
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20200809150302.686149-1-jolsa@kernel.org>
 <20200809150302.686149-11-jolsa@kernel.org>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <c99e9d34-a807-93eb-4a2f-34c79793628b@chromium.org>
Date:   Tue, 18 Aug 2020 02:14:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200809150302.686149-11-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 09.08.20 17:02, Jiri Olsa wrote:
> Adding d_path helper function that returns full path for
> given 'struct path' object, which needs to be the kernel
> BTF 'path' object. The path is returned in buffer provided
> 'buf' of size 'sz' and is zero terminated.
> 
>   bpf_d_path(&file->f_path, buf, size);
> 
> The helper calls directly d_path function, so there's only
> limited set of function it can be called from. Adding just
> very modest set for the start.
> 
> Updating also bpf.h tools uapi header and adding 'path' to
> bpf_helpers_doc.py script.
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: KP Singh <kpsingh@google.com>

Thank you so much for working on this! 

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

[...]

>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> 
