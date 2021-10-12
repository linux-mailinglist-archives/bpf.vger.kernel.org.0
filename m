Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739CE42ACE4
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 21:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhJLTEu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 15:04:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35612 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhJLTEt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 15:04:49 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by linux.microsoft.com (Postfix) with ESMTPSA id EDDC520B9CB4;
        Tue, 12 Oct 2021 12:02:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EDDC520B9CB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1634065367;
        bh=h7msdjyKlH7DMukKsw6wTUVUKmOZkrR3GgOBaADS810=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j+SFv391M6ABEjBq6ofYyRR6Iq63JqpocmjeqsZtcHlLdRVn1nhsDbtjsw3tbY1EJ
         Fatkvy9QZdkHSzcEva/uokY49ij5FQ3vraOfNEvDlhmSQk+3cgwDOebVz9/Ob9HVzf
         iLlbhfxcpVfox0g7wR8BsaZprMfSK+HDYueIFm1A=
Received: by mail-pg1-f180.google.com with SMTP id d23so21875pgh.8;
        Tue, 12 Oct 2021 12:02:46 -0700 (PDT)
X-Gm-Message-State: AOAM531Cwnu9mBz8ZPSXNHGck2zTyamyewe+tmgE5zmHoVT22Y5uUys3
        HUP4J+5RPUEfIFrTqVZn5qFmKupzEDVuLfPs2A4=
X-Google-Smtp-Source: ABdhPJzAZ6vlfFZUd7AzbtGkqfNjCx0LuuKNza7jjbYlXeW0io9vHAqduKhwAGndLhCeZOXFuiJrpKJAz95bnw7NpqA=
X-Received: by 2002:aa7:8609:0:b0:44b:346a:7404 with SMTP id
 p9-20020aa78609000000b0044b346a7404mr33544764pfn.86.1634065366569; Tue, 12
 Oct 2021 12:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211012185858.54637-1-mcroce@linux.microsoft.com>
In-Reply-To: <20211012185858.54637-1-mcroce@linux.microsoft.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 12 Oct 2021 21:02:10 +0200
X-Gmail-Original-Message-ID: <CAFnufp1JtsJF0i5tbTvknnOqHBOaoJgz90Sb325bmm=CbHsrVQ@mail.gmail.com>
Message-ID: <CAFnufp1JtsJF0i5tbTvknnOqHBOaoJgz90Sb325bmm=CbHsrVQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/2] bpf: add signature to eBPF instructions
To:     bpf <bpf@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 12, 2021 at 8:59 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> When loading a BPF program, pass a signature which is used to validate
> the instructions.
> The signature type is the same used to validate the kernel modules.
>
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---

Slipped out by mistake, duplicate of:

https://lore.kernel.org/bpf/20211012190028.54828-2-mcroce@linux.microsoft.com/T/#u

Sorry,
-- 
per aspera ad upstream
