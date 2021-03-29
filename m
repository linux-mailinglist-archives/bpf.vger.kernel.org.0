Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E91F34D399
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 17:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhC2PUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 11:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhC2PTy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 29 Mar 2021 11:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617031194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WmKnRfGqtm/qi1knoI0hP25ugF8TAN8r0CFwSt+C3jA=;
        b=hDrjyipxegQ9nSOkVrd65j317g/5eJkG2xGYOYFQqHuIJ3VWSUxDaaKXpwajzKo14striT
        LGADI3ieq+LJVqW+jIsj54Hh9iYgWgWmJTCJmxLplwwhcPal+FzX4Q1LCxzNTmT0j3CScH
        YuD3h1fv0l0zkGt6yY6MITVG0i3mG0w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-RH1xlzTnOEGLhXn4OdyTpw-1; Mon, 29 Mar 2021 11:19:47 -0400
X-MC-Unique: RH1xlzTnOEGLhXn4OdyTpw-1
Received: by mail-wr1-f69.google.com with SMTP id i5so8876680wrp.8
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 08:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmKnRfGqtm/qi1knoI0hP25ugF8TAN8r0CFwSt+C3jA=;
        b=izb6srDEkrc/zTb6Fe0xZA/wTYkYyvwFD25Vo3wMqIS0sTjBqt5tIdMIpva1RfXEIr
         n0oPUC/B2/PGiLEbHy/9C41FOx/byQ2HQtw6rwpEpjq+LMfQcokbGeMYVdZqmLpZFLLk
         ee9pLJhOU282AFBqa69PL7HVmgATJcDNmHehIXKJP4LD5OllaSIxUZ8K5IHAN4219qqo
         aJDKxOa9i/h9no6cc0H04jVBH72gB1LQVGhAAmf8DnfyixCVsIE8vNM+kg5iO48Vgcqs
         Y9GKL8jmIFIsHMt04UZl/Uo4HDPFW0TK5SRwZIrOJvQLnyMy7sGnM7yKz3zc6509Qk18
         3AqA==
X-Gm-Message-State: AOAM532sAbvgkVKczu5JyYrmbvWLEFmosluiJaJtmK3uOLLOqvkt8d2p
        y1MjnzZkOBDiL/Tfj17bOrtaypPtOCfND1XiFi0OhwH1jLf3MU5vg6/f3e/OgrAW5am9AXN/3ow
        WcfBZRsb8XtQyFSEl70Kp6KkKrMfa
X-Received: by 2002:a7b:c155:: with SMTP id z21mr14432499wmi.79.1617031185961;
        Mon, 29 Mar 2021 08:19:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6pqTOT0lYKv1fQe8dP9ofw+PPg57nrFQpzni1F4a5Us5rw8Ch6V/v6Fi5uuji2IEwvYH56AaysyZkWuYkyvg=
X-Received: by 2002:a7b:c155:: with SMTP id z21mr14432485wmi.79.1617031185786;
 Mon, 29 Mar 2021 08:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326122438.211242-1-yauheni.kaliuta@redhat.com> <20210326122438.211242-4-yauheni.kaliuta@redhat.com>
 <CAEf4BzZowiRKeLGw7JikKuMs+dy-=OTMbUb3eFJCq03Br7P30g@mail.gmail.com>
In-Reply-To: <CAEf4BzZowiRKeLGw7JikKuMs+dy-=OTMbUb3eFJCq03Br7P30g@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Mon, 29 Mar 2021 18:19:29 +0300
Message-ID: <CANoWswmy1bHbU8hBkF2DiyW3oHr1wDxZU3CsyDHOJ+-fe5DBTA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selftests/bpf: ringbuf, mmap: bump up page size to 64K
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 28, 2021 at 8:03 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:

[...]

> >
> >  struct {
> >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > -       __uint(max_entries, 4096);
> > +       __uint(max_entries, PAGE_SIZE);
>
>
> so you can set map size at runtime before bpf_object__load (or
> skeleton's load) with bpf_map__set_max_entries. That way you don't
> have to do any assumptions. Just omit max_entries in BPF source code,
> and always set it in userspace.

Will it work for ringbuf_multi? If I just set max_entries for ringbuf1
and ringbuf2 that way, it gives me

libbpf: map 'ringbuf_arr': failed to create inner map: -22
libbpf: map 'ringbuf_arr': failed to create: Invalid argument(-22)
libbpf: failed to load object 'test_ringbuf_multi'
libbpf: failed to load BPF skeleton 'test_ringbuf_multi': -22
test_ringbuf_multi:FAIL:skel_load skeleton load failed

