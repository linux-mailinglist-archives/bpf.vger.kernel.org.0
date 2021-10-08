Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E88D42738A
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbhJHWSh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231830AbhJHWSh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:18:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 321B661027
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 22:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633731401;
        bh=GmVHoCEugFBFtIKrSBDgJc5iOqua1clxzVNZ/RXXi6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IIXMvc+mg2CmgBJaEoQVrC+PuNCSxwz4B90scEqU3LkTUy7u/5B3oYBHmLBWI4bhj
         5vkRqQgu4H1oN39POI+iU8cC2MnPMwiwdDdfaTVGAvcUkuF78ev2JqA5/vfEBqkIAv
         uedKhM18hUbL/rF3En3fUJM9keB6m2gVZOfcHAWd2ISksj0rNPLECkyzbxsa4bh4vh
         VXIkWBOdBbpDrZiDj5tbaQgQNy16mRLj5pXbHDFgwC5+jp8gLMrqzVNVDywj4vSfDE
         9v2CtG+tHdl+I4vnYryDW9WdSfAqedvWu1DspOvj1o3eCeYtdsTIfjK4siAZ6ScOqK
         b2hUTQUiJak0Q==
Received: by mail-lf1-f43.google.com with SMTP id b20so45337759lfv.3
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:16:41 -0700 (PDT)
X-Gm-Message-State: AOAM530Bke/jrtG4KqAMjHvqW8WoWqcqmY2mfuoaWDw6pMSX+5B5ToPX
        d15d8a9jT4OyS/gH/Q/DmiT76gjkb+TEVdSZTmM=
X-Google-Smtp-Source: ABdhPJzixW+Q1Z9YThnge9K45igvw4yoGUghHQhvic50nnteDhbYsQC4rmmrg1ynaAlTRJtfeVUxNCwWwVqw7CqctF0=
X-Received: by 2002:a05:651c:c5:: with SMTP id 5mr5282487ljr.48.1633731399488;
 Fri, 08 Oct 2021 15:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-11-andrii@kernel.org>
In-Reply-To: <20211008000309.43274-11-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Oct 2021 15:16:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5fx_RmE93LCd=HMgCFbYKYfm3YTtaeFUyvHpK9M9Jz9w@mail.gmail.com>
Message-ID: <CAPhsuW5fx_RmE93LCd=HMgCFbYKYfm3YTtaeFUyvHpK9M9Jz9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/10] selftests/bpf: switch to
 ".bss"/".rodata"/".data" lookups for internal maps
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 5:05 PM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andrii@kernel.org>
>
> Utilize libbpf's feature of allowing to lookup internal maps by their
> ELF section names. No need to guess or calculate the exact truncated
> prefix taken from the object name.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
