Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE9F85567
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfHGVqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 17:46:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33664 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfHGVqj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Aug 2019 17:46:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id r6so85755595qtt.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62wgqsTsuVHUgUQUfLHgAsOVSXEcaeGtAoolloDqQOo=;
        b=f9pW/6yXKk2UETaCp6+W6xKAmeanwXikfLOxVWef/hml51MZp0CESp1cCxO063ELy5
         A63NVm8MJDr5cZLKDv4CpY4HHXKB6HLox8k8WYUhDFgWmwmf3bzTgULbkPY1D2Na0kID
         TRbC0hyK4G68LJLeMcEJs6qqORRFTxHHd//yZgXdCWKRkyvm8zSFhInlPpXnuttF1AaT
         g8d+mFrenojA+me+fPlndnNOemg/jNzXal9JlNSPhTCsDL1WWVR5gipDrrbmLDDme06e
         6ieP1R2yujhInPKg3p+M7M56ByKzh2DTn5+4Djhk2p26ncTxhKU6wlX5AokH128LWrnH
         hJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62wgqsTsuVHUgUQUfLHgAsOVSXEcaeGtAoolloDqQOo=;
        b=sQPXD5AGO1ZWtXtueqDnpw6FIdpbExiS7GgjM0/EAt8LUNrKFR65gfenoxO0Y/CzE5
         AFmIgyAbGCRKqJdkkc7zIz5RD0zaL0PMW70/UJte8P5zYhHMjTnxl0TztdlWz4l8lgrn
         ya0onG/W7ky5MJjJuC/nnqjqapHdP0Fm9r6L1y6fE/hDH8Wb+4eJnau+iB7CAwR1KT34
         XCik7HTlZKmv1u2onFV5Gboq1ADhWMTmoogZJc4iHKIsT548ctaiGZCMUsqCUFxPEXws
         wS4MAjwXL/R0y2P2sN3A99t2BtBBUFmDTXkUvT8N2glfC/sVpVOkerdYXeuq7koL00vO
         9zyQ==
X-Gm-Message-State: APjAAAXZp3Zw6NTlmgz3CFhptXTSYLtaUQTi7csOPpf8+vE12pSpQsZN
        fBrj/RhT7UhcyQc/Bt7Ug8Hvs5EQT+yP9+XZcFkZA6Kr8JM=
X-Google-Smtp-Source: APXvYqyhTRax3UaDBGrNMQLT5UtGgN7oVxc0AKt7aub/5VpARK5YjeKEOGpkbzCHN8lJGpo2DaUUGVXn7nmQeDx3xpo=
X-Received: by 2002:ac8:32a1:: with SMTP id z30mr10362465qta.117.1565214398142;
 Wed, 07 Aug 2019 14:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190806234131.5655-1-dxu@dxuuu.xyz> <8e7749b8-f537-7164-dc85-9a67fe88bba2@fb.com>
 <98ba658b-e5e1-455d-8c47-36cca16ef17a@www.fastmail.com>
In-Reply-To: <98ba658b-e5e1-455d-8c47-36cca16ef17a@www.fastmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Aug 2019 14:46:27 -0700
Message-ID: <CAEf4BzY8D8yQYa_nGqN-u4EXfB=8SEe=DFAREANONFN86E58fg@mail.gmail.com>
Subject: Re: [PATCH 1/3] tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 7, 2019 at 2:33 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
>
> On Tue, Aug 6, 2019, at 11:06 PM, Yonghong Song wrote:
> [...]
> > > +int perf_event_query_kprobe(struct perf_event *event, void __user *info)
> > > +{
> > > +   struct perf_event_query_kprobe __user *uquery = info;
> > > +   struct perf_event_query_kprobe query = {};
> > > +   struct trace_event_call *call = event->tp_event;
> > > +   struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
> > > +   u64 nmissed, nhit;
> > > +
> > > +   if (!capable(CAP_SYS_ADMIN))
> > > +           return -EPERM;
> > > +   if (copy_from_user(&query, uquery, sizeof(query)))
> > > +           return -EFAULT;
> > > +   if (query.size != sizeof(query))
> > > +           return -EINVAL;
> >
> > Note that here we did not handle any backward or forward compatibility.
> >
>
> I intended this to be reserved for future changes. Sort of like how new syscalls
> will check for unknown flags. I can remove this if it's a problem.

I think what Yonghong meant was that you should probably allow
query.size > sizeof(query), but make sure that all the extra stuff is
zeroed, similar to how it's done elsewhere (e.g.,
kernel/bpf/syscall.c).
