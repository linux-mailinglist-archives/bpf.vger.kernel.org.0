Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBEA3693E6
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhDWNmz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 09:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhDWNmr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Apr 2021 09:42:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAC9C061574
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 06:42:10 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a36so44887912ljq.8
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ACacwgg1c55lRmIJ63LyWYlDikuUr5mvOu5WyEAunwk=;
        b=lJwMd3J87RFmue+5Rg0ADPzSL1l58UmuJdt2fgbLVrCs8WjtEsgoNCt0jrC1fPiqan
         jm865OK+FEw6ikZAF/avS8mUDgIG+jM4wpQlKfN6BT76N5yCM/KL0m0BlFqAdEmo9cnh
         1oY8LNPV2ibLE8HjP461Pjz8gUBh5kBkKADDY16zskjS9C/SIi8KPZiEG3O85yYXKSZT
         RY86ZFWYHjj9eCcVqDfR81PmrMZBdOAH8FLmFat40QZMFPKgh2ixKraaY7uFFsLrDtIw
         MOr3kON6uZC/vVSaErCF/AiHoBlRUZkUPVM/k+nexlWvmmNHvpFf97QWugk9o0AwJuTN
         D3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ACacwgg1c55lRmIJ63LyWYlDikuUr5mvOu5WyEAunwk=;
        b=Go4c6094DQVi9u7qj3zXZVv1VoWQa9skNJLE71SWYEaXll9eYEvwFvIzYsXNI60qVA
         FMql/AKNx3aJCSgrGQ6lWEwUOTucVEjbg85OsYpGCmwMLFjmnaw2iKBw9tUeF4a+aBl7
         cUBNNFxw5PZBtwd6mb4mz0uV92bEQzp+jpHa0tCWIkHbvLgUjEbfL9xElZY4vD5zfEl/
         crB93qfZ32aWaJOO8hhgC2cw3nnvWx/2reX1n5wFSmudmg6LeaTrUDWxHE+w1d4BTyVd
         fl28u8xOEZJ5b4Th8Tro/Y81AoLEeXo2oiVmdiX6HY/R6gl7iiEnmEsqMXlI4G29Ew9J
         jT3Q==
X-Gm-Message-State: AOAM532ikOo4CV2g3Q3IFvnZSy0yu/7TGGnR1qdl2NYvKy7AQhuJ0/1X
        2FanSADvvLto/s8YxwA5nwOSlziiZmnn5nKcaRIMX7w8JZ+xbA==
X-Google-Smtp-Source: ABdhPJzCeDAKcPZuZ4kCh2YA2bumUu8vBvK6qKpI4txkPUnmdjERUWUsFGA7jqxKm09Mvg5I8dJhhUVCI3rU3Qwyuao=
X-Received: by 2002:a2e:99c1:: with SMTP id l1mr2750142ljj.180.1619185328650;
 Fri, 23 Apr 2021 06:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOWid-eY4CHZw01d9w3KC0qpodWmTXfQqLopkNFVNwZhmCYgMQ@mail.gmail.com>
 <87czumfexp.fsf@toke.dk>
In-Reply-To: <87czumfexp.fsf@toke.dk>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 23 Apr 2021 09:41:57 -0400
Message-ID: <CAOWid-d956uyPv02UAgu2+pxk=ijPNodnV2FOki-=fkPycWkwQ@mail.gmail.com>
Subject: Re: bpf helper functions from kernel module
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 22, 2021 at 12:43 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>
> The support for calling kernel functions directly (AKA "unstable
> helpers") will likely be the way this will be achievable. See the
> comment in brackets half-way down in the description here:
>
> https://lore.kernel.org/bpf/20210325015142.1544736-1-kafai@fb.com/

Oh this is very cool, I will look into it.  Thanks for the pointer.

Regards,
Kenny
