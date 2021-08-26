Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F153F90AD
	for <lists+bpf@lfdr.de>; Fri, 27 Aug 2021 01:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbhHZWYi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 18:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhHZWYh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 18:24:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4C3C061757;
        Thu, 26 Aug 2021 15:23:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso3394901pjq.4;
        Thu, 26 Aug 2021 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xaQIpU4ZMMwUA7Ndi6CJ4AqebF8EXWibPj8+ffm/yqc=;
        b=Vbg8eJJHQ1QUoW+pf2ex7W7sAFsnEa74GB0cxgEOZjjTrFkn6VDeeUC5yISmIizWsR
         AgyY3DECx7pt8XJVeU4cW/q+9aSFG1oWp1UvQ/ccHlcH2T5wdNoOVZ4mffjyM8/N8xHa
         0GWz/8emQz51R29zrjgXcBD1q0gPv+lfdAyQJtoLhyuwyvyP2XCEizHzyFj+9LcnEU0d
         APKH78DBIL0wO3VbCnljs3VdCOcFqui6lcfRRFt7ViNHMCHIjML9TspVvsFJCqv5LtS3
         SIhl9XeejaKCOmRLFQm9uHd+QY5MR3XDXOxhrBnuRcO7xnjeKJsCMljSlKXi2labA2m+
         i/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xaQIpU4ZMMwUA7Ndi6CJ4AqebF8EXWibPj8+ffm/yqc=;
        b=awHQhT/McPMQnV1u5dwqF88f4FSjOlOMh1IzadyQdV6d3OVOVViibC8SFjFl6prRpk
         nBcWm1dpFHwFzX9IZRjL3rmgs6fPXYWraCTu8qeMRM4hmL/BXGR3/X/7NuHQihKOB02H
         7OiSviMElV2YwSz6+PK/qn3Hc6sqb9FxXpDZwYoCntw+EOfeP36tuiikUWve4Ye9v/JJ
         q9GYrAJSsGNAWzE3i+0a+yjLih1GTWLaDS/YWXJdZ3ZHELdG82is6yqFLj17v1lcFgbl
         9Mc7fXZcXnznyfAVhSQD6B1Aj0p7bJsZn48vuOYBB0aBAUZJZqV4wVuPMpytVA32Rm8q
         pKGw==
X-Gm-Message-State: AOAM533XfSfLRvHuWwhfIoWTy1t3AFCW5M5FAfFVnqQnuZMBBsNv4Swd
        tmXkMLgklr5LDCvxO1q3R6mN7wl+A6w=
X-Google-Smtp-Source: ABdhPJyjTgsGudf97CQYkPcimZnNHHZ1dTczlTn/OJ57ovMmuZC7SXHUMmlLvqry3E6+AN3WLNUlyw==
X-Received: by 2002:a17:902:be08:b0:134:924:1733 with SMTP id r8-20020a170902be0800b0013409241733mr5677982pls.64.1630016629563;
        Thu, 26 Aug 2021 15:23:49 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::5:2fa])
        by smtp.gmail.com with ESMTPSA id g6sm3822427pjs.11.2021.08.26.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:23:49 -0700 (PDT)
Date:   Thu, 26 Aug 2021 15:23:47 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Implement file local storage
Message-ID: <20210826222347.3bf5q5ehdfnrblir@ast-mbp.dhcp.thefacebook.com>
References: <20210826133913.627361-1-memxor@gmail.com>
 <20210826133913.627361-2-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826133913.627361-2-memxor@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 26, 2021 at 07:09:09PM +0530, Kumar Kartikeya Dwivedi wrote:
> +BPF_CALL_2(bpf_file_storage_delete, struct bpf_map *, map, struct file *, file)
> +{
> +	if (!file)
> +		return -EINVAL;
> +
> +	return file_storage_delete(file, map);
> +}

It's exciting to see that file local storage is coming to life.

What is the reason you've copy pasted inode_local_storage implementation,
but didn't copy any comments?
They were relevant there and just as relevant here.
For example in the above *_storage_delete, the inode version would say:

/* This helper must only called from where the inode is guaranteed
 * to have a refcount and cannot be freed.
 */

That comment highlights the important restriction.
The 'file' pointer should have similar restriction, right?
But files are trickier than inodes in terms of refcnt.
They are more similar to sockets,
the socket_local_storage is doing refcount_inc_not_zero() in similar
case to make sure socket doesn't disappear.

May be socket_local_storage implementation should have been a base
of copy-paste instead of inode_local_storage?
Not paying attention to comments leads to this fundamental question:
What analysis have you done to prove that this approach is correct vs
life time of the file object?

The selftest hooks into lsm/file_open and lsm/file_fcntl.
In these cases the file pointer is valid, but the file ptr
can be accessed via walking pointers of other objects.

See commit cf28f3bbfca0 ("bpf: Use get_file_rcu() instead of get_file() for task_file iterator")
that fixes a tricky issue with file iterator.
It highlights that it's pretty difficult to implement 'struct file' access
correctly. Let's double down on the safety analysis of the file local storage.
