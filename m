Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB1457EF4
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 16:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhKTPar (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 10:30:47 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33910 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhKTPaq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Nov 2021 10:30:46 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by linux.microsoft.com (Postfix) with ESMTPSA id 636D620CDF2A
        for <bpf@vger.kernel.org>; Sat, 20 Nov 2021 07:27:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 636D620CDF2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1637422063;
        bh=XCO8wxy8y3eAw5ZaB/NNQPz9daEH4IXNdyOczZ+4vAY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cT3FAktzG6aQgzpDlWiba0j3RbyX99vjf7lDwoex6aHIhOfMhzVDwUhtrIoz3Y+v8
         nje1gZ9zOXUc01LoDtGKPXz0XhPe0LXe8nG2sDkh5R40Fa9SNEMULKoAZwN2LhkEtn
         ZglGjPqqCk+jt/QeeoeLOxbuLR9AcbQt0dF6sg5w=
Received: by mail-pl1-f172.google.com with SMTP id o14so10426647plg.5
        for <bpf@vger.kernel.org>; Sat, 20 Nov 2021 07:27:43 -0800 (PST)
X-Gm-Message-State: AOAM533xHhxQS+iqkgHeU7jYq1h0TtyT1CPSonOCdLiFQYC9p7dqvMTs
        tABGLBsbjVzo2hNis7AkPBrMiyWI9r2lKLNWiog=
X-Google-Smtp-Source: ABdhPJx6nTgCEnWTAh7wTxkuaedxobrgRYwiv4+iTMbTVRwodEJz+qOQbKy+3pbs3cRu77In9zo3O98EKyr3asVW8ZU=
X-Received: by 2002:a17:90a:fe0b:: with SMTP id ck11mr10968911pjb.15.1637422062907;
 Sat, 20 Nov 2021 07:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com> <20211120033255.91214-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20211120033255.91214-4-alexei.starovoitov@gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Sat, 20 Nov 2021 16:27:06 +0100
X-Gmail-Original-Message-ID: <CAFnufp1ncBbD=K3bJxjzLNCg-VgHeQruJTdVE+9rj+E85+kc9w@mail.gmail.com>
Message-ID: <CAFnufp1ncBbD=K3bJxjzLNCg-VgHeQruJTdVE+9rj+E85+kc9w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/13] bpf: Prepare relo_core.c for kernel duty.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 20, 2021 at 4:33 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Make relo_core.c to be compiled for the kernel and for user space libbpf.
>
> Note the patch is reducing BPF_CORE_SPEC_MAX_LEN from 64 to 32.
> This is the maximum number of nested structs and arrays.
> For example:
>  struct sample {
>      int a;
>      struct {
>          int b[10];
>      };
>  };
>
>  struct sample *s = ...;
>  int y = &s->b[5];

I don't understand this. Is this intentional, or it should be one of:

int y = s->b[5];
int *y = &s->b[5];

Regards,
-- 
per aspera ad upstream
