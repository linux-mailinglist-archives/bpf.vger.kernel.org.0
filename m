Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EBE25E086
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 19:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgIDRG5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIDRG4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 13:06:56 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE0BC061244
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 10:06:56 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id x2so4876107ybf.12
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2d3xADClZFNDP5n7s/A+Y1Xp3RnSOPP4Ni23oncZ6Io=;
        b=PdZp1hKvMPgtF02jEGYccIYNBF3nBKqib4CduRIo4zL16Mm54Ls6CspPRTFH/nf1EP
         KUl5qt08xYrrurCflUuR73QXNIvx8LdyyrsFGlvKcYkUigiyAJo9tf49yHlDnjiRKiyP
         bqwCku43ZQpJsjEzT5aHXUDyUhET0FBpvyfrf9wvfEA5JOAVfIXiM7yDSDrmJ0SI4J15
         UkFkRH2o0wDuN+HaZeG8WikPNs9IBXywJd/Cj4t4XGIFnfTxzKTsstaNCrssUaX5P2MT
         NRC303mcBNX0+My73WZYMNI0w6SGJ1q6F22vKmZPuTuU8e9tuZGJ7sjAy3ZwRcyCgFQ/
         sMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2d3xADClZFNDP5n7s/A+Y1Xp3RnSOPP4Ni23oncZ6Io=;
        b=cb7t/A1OZqX/4Lonxw5dHBpxCgH6CQHOPUNKXQB0+P+161ifLZ085mC0GJCmUBuLUE
         2ZFh66/iNS7ovKXz933lGDuyx7Qtxg7cfle9nY8wvdvvpSlIY7T8P7mzWXx61FcmXCof
         edCl8VJm9xi11ULhXDpJt6NGsf2RAFnVgwyuyH+uG06d9kF8qIM/ZlrYKSEqhY4kPxLA
         7Qc6LexBEWOAFRi/6ncHwfhjAdMcOXLt6zzsOZzDmuNaHjR+foZubNaA0rmUmsMkWc6R
         K2fqhoNIhtzuwWjyl8WmVUeUQE8KwWEKzC/JmDGzz2C5JGf30DfJ3wfYt7XdJ5Ewjhv6
         jPyQ==
X-Gm-Message-State: AOAM531zN8q8kZh9MVH9hv6rW3nzu2ggaELHpLxDTM7mv+JdY9hiA1DQ
        ycUCpTIZ1fCWIKf9VlHZk1sBF4aUQLrkp7ZM4HE=
X-Google-Smtp-Source: ABdhPJzbrDWRr6XzJZJoK6d0rVdVERegAIttWFPJaxoNaJa8RxUP8i0Yoi0223Q+XWSdlv2SLT/RWOEGv8RIKXU2M3o=
X-Received: by 2002:a25:cb57:: with SMTP id b84mr11170676ybg.425.1599239215343;
 Fri, 04 Sep 2020 10:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOWid-e1m_S7_o35tDis1KMZcwaDPbCH8WTKrZG7_4QZsHS9XQ@mail.gmail.com>
In-Reply-To: <CAOWid-e1m_S7_o35tDis1KMZcwaDPbCH8WTKrZG7_4QZsHS9XQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Sep 2020 10:06:44 -0700
Message-ID: <CAEf4BzbEkAjrFqDfdZnQPPWUwQAOaEf31obfWE1tpb9ihfAtyw@mail.gmail.com>
Subject: Re: BTF for kernel module, and other general questions
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 4, 2020 at 8:40 AM Kenny Ho <y2kenny@gmail.com> wrote:
>
> Hi,
>
> I have been reading this
> https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portability-and-co-re.html
> and understand that btf is generated with CONFIG_DEBUG_INFO_BTF=y and
> is made available at /sys/kernel/btf/vmlinux.  Is it possible to have
> similar functionality for kernel modules?  For example, is it possible
> to generate BTF for the XFS kernel module and have it made available
> at /sys/kernel/btf/xfs ?

I'm actually working on this at the moment, so it should hopefully be
available soon.

[...]

>
> Regards,
> Kenny Ho
