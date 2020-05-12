Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1407B1CE986
	for <lists+bpf@lfdr.de>; Tue, 12 May 2020 02:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgELAMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 20:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728359AbgELAMN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 20:12:13 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF53C05BD09
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 17:12:13 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a62so11918540qkd.4
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 17:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eMaf4xc8D2BTATY0do2dFv+4nFGdf/qS8KpJ23BpHA0=;
        b=WTnl9KRJI4BwzNnZvPbjEij1Gyw+15IRSe+l0FJ4S+5s+XJIWK78bOeswKixQoY+ns
         O6wXSLSIxB78mJmAfk7OuyqntA8WQVWnDj2DUWd5wKLRjvEbSVGmOvrSrjFYiE/BV1uk
         voa+EQAClkeYRlTT4viM5mPtGg7uU8SpXdrpmHxRrveN0lCyXXwqN23t+tHOQWl+cXeE
         DYAXRSmZSGzklhJAM997GHYslerGdc0Pv1dSqQbuXqXnlHN4OY+p65gusAJKVS8R+ugv
         nJNKo1ZA3/w/p5z2H1P6Z3Ip8+dzTSaCYdym+DAsT0gpcZNkn0m+c5/NqCFVLlZeQztC
         ac5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eMaf4xc8D2BTATY0do2dFv+4nFGdf/qS8KpJ23BpHA0=;
        b=K4uK4NCYHWQbBZUMKeTgzBFXozoqOuk69rzu1pvajZrN17NV4An+4y+CXfBDx7I1M5
         xS7gujP1gZzVMVPllCJm3tew3I/fcPEYShWJYmEEkmuH7ebkpjZGqfUgztvbFf5VD3x3
         znD0doYPGmrmku4porZJAgf5w0wpPibiqky11lMtAu6fTruXzcU2pmNFtrOlcPC5m9Ii
         ehaf3cyEgUETziMYmzoyiR2lb2NtpxzBqrQC5P1zB602S7L0/am8cgoJt4s8j4UJwOJ4
         cEw+hPORs+2aX/MNQUi5K5iS35mua0lb84H8FVViKrwXhfP6ggybjXRECqdfr8HDqfj+
         6a8Q==
X-Gm-Message-State: AGi0PubqRNMez4e2FqpJUCtTzMss2drarnUdankazIt4YmIHRLW8Y2os
        0H1Yu+C2Yx0nFpA7YLLTocMf34U=
X-Google-Smtp-Source: APiQypIOM3v0IvzYlBLoCseN6fNtA0BGMXPAe7n/8UDiFV3tUxZn65Tq/kITIfPvNITpZRmCY34ZI/U=
X-Received: by 2002:ad4:42c7:: with SMTP id f7mr18867291qvr.127.1589242332555;
 Mon, 11 May 2020 17:12:12 -0700 (PDT)
Date:   Mon, 11 May 2020 17:12:10 -0700
In-Reply-To: <20200508215340.41921-3-alexei.starovoitov@gmail.com>
Message-Id: <20200512001210.GA235661@google.com>
Mime-Version: 1.0
References: <20200508215340.41921-1-alexei.starovoitov@gmail.com> <20200508215340.41921-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: implement CAP_BPF
From:   sdf@google.com
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        linux-security-module@vger.kernel.org, acme@redhat.com,
        jamorris@linux.microsoft.com, jannh@google.com, kpsingh@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/08, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
[..]
> @@ -3932,7 +3977,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr  
> __user *, uattr, unsigned int, siz
>   	union bpf_attr attr;
>   	int err;

> -	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
> +	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
>   		return -EPERM;
This is awesome, thanks for reviving the effort!

One question I have about this particular snippet:
Does it make sense to drop bpf_capable checks for the operations
that work on a provided fd?

The use-case I have in mind is as follows:
* privileged (CAP_BPF) process loads the programs/maps and pins
   them at some known location
* unprivileged process opens up those pins and does the following:
   * prepares the maps (and will later on read them)
   * does SO_ATTACH_BPF/SO_ATTACH_REUSEPORT_EBPF which afaik don't
     require any capabilities

This essentially pushes some of the permission checks into a fs layer. So
whoever has a file descriptor (via unix sock or open) can do BPF operations
on the object that represents it.

Thoughts? Am I missing something important?
