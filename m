Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C0039FF86
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbhFHSdr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 14:33:47 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:34486 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbhFHScv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 14:32:51 -0400
Received: by mail-yb1-f172.google.com with SMTP id i6so16964607ybm.1
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZIx/ngVbBdLsOS8vRZleglzmnWWeUTexwNf2GHsF1c=;
        b=nnWTSsvoKMIiFA00wU8mMvXuRYsiUqZ9V8RTZJCYOX8II46HR4NXbFYJkeV0sIkxFv
         JzgojKj37n5F3XoDe+h+Jn6mtTM+Nk8lLdGKl+aXCBXf18xXH0dxz+TPEthf9XbTidyF
         /2pGo+pndwdIVJ3Ar25T27okO2QrCEB0aT2RutYCc4r/wZ75eSpfLw7FL9Mf4Lr2hpEZ
         S0uFk9HvO+v0DInFY2C6Rim8YzZV8irmwzlb7BoGDAihLzmU7UVWfbyOQ6jWCNWbjIjw
         dhuiSXn4dBHu/FpLnphqF4/x9+ytgXvXSREazD4zPI6vnbsZIHNKjQ7QUWg1L2TeTEc8
         m+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZIx/ngVbBdLsOS8vRZleglzmnWWeUTexwNf2GHsF1c=;
        b=XAQjx+HSyQs+IUQH+A41mt3Rco6b2m5YmJ1cng4PHBQAxH3obaWd9J3AuPHAnJv1M9
         94UBLzWVBvth4rtVj7jtYDVgOH5irmjBlwYRmuiKiiZS/paDvSjHWSyy87PSaO6WqblE
         3X7gSwVm+wa6GEJAsBN96+HtfmWAg9kHaNIckFl52rjzV10Dkxabs3fz9X3sOc7fCs6k
         Vz3hJ3mWP0NI/fsF9taSjO024EW2rlQKMUA+ceGEYjuVv7r2rtshdCUCN5K5PKrgYAXh
         8AcpYe0U8kOzxZW6JTf7ginZU3UZfbTwJMRSRxU9ayJ4bFIuZcPEhQJMh2JAL/2Dn5gA
         WFyQ==
X-Gm-Message-State: AOAM530UGHT5tsjeSvHhBtNx/OvaEqiwGWZzx3lOTmcaw5JV0heVhZHx
        CPpgSH79dNbCNCVHsJTgli6DOJtvl45xoGEUXZd79Nr1ECs=
X-Google-Smtp-Source: ABdhPJyKuTHLkhzS5FmMfKrUP0CmYVJwehfQEz93YTLuanu7BSwEndVniG3BB5S6YocAhXkjFQoOgn0hWyImJj/64Zw=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr33236008ybr.425.1623176997505;
 Tue, 08 Jun 2021 11:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHb-xaum8ftH1kWktSh6NZ_z0ZrBNqG9Rchs+68ePHOwq31dBQ@mail.gmail.com>
In-Reply-To: <CAHb-xaum8ftH1kWktSh6NZ_z0ZrBNqG9Rchs+68ePHOwq31dBQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Jun 2021 11:29:46 -0700
Message-ID: <CAEf4BzYDfSD+k9hm6VjteOcNSMVCg-USn8+kejESQmnKVVaH0g@mail.gmail.com>
Subject: Re: How to get the updated content of an argument which is updated in
 a kernel function by kprobe
To:     rainkin <rainkin1993@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 8, 2021 at 4:07 AM rainkin <rainkin1993@gmail.com> wrote:
>
> Hi,
> Assume that a kernel function has an input argument (i.e., a pointer),
> and the function will update the content pointed by the pointer during
> execution. My question is how to get the updated content using kprobe.
>
> Take the kernel function path_lookupat as example:
> static int path_lookupat(struct nameidata *nd, unsigned flags, struct
> path *path)
> It lookup the path according to a given file name and store the
> founded path in the third input arguments (i.e., struct path *path).
>
> My goal is to get the founded path from the third input argument.
>
> I attach my ebpf program to this kernel function using kprobe, and try
> to print the content of the path argument. However, the content is
> empty, which is reasonable because the function has not beed executed.
> The following is the code:
>
> SEC("kprobe/path_lookupat")
> int BPF_KPROBE(path_lookupat, struct nameidata *nd, unsigned flags,
> struct path *path)
> {
>     char fn[127];
>     const unsigned char *fn_ptr = BPF_CORE_READ(path, dentry, d_name.name);
>      bpf_core_read_str(fn, sizeof(fn), fn_ptr);
>      bpf_printk("path_lookupat: %s\n", fn);
>      return 0;
> }
>
> Then I try to do that by kretprobe where the function has been
> executed, but it seems that I cannot get the input arguments in
> kretprobe.
>

Yes, you can't access input arguments from kretprobe. What you can do
is either use kprobe to remember the pointer and then read contents in
kretprobe. Or better yet is to use fexit program that has access to
input arguments and just do that in one place.

> Do you have any ideas or suggestions to do that?
> Thanks,
> rainkin
