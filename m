Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC8E21A0
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2019 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfJWRTM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Oct 2019 13:19:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39729 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfJWRTL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Oct 2019 13:19:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so21945418ljj.6;
        Wed, 23 Oct 2019 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DnypHcyiSmDYpsEnrDTzJLRsh2gQEWlfzVr6c4JGW3s=;
        b=IXEvy/Cs3F9Yw8kyCFMhSn+IrR/NXoG5FUCcrmhgxsxYeM32T0bAZWB5BSSGb5FQeQ
         ic5Rr4dM4ZPwQ8pzEvB8yyOMZDhv6J0BRJ0XrBNqgtODlOwjvjXmj78gdcfdIzktgPsw
         C0V59cUWLFMOrHqlw64fz/uQCuANctsbTbS7SDEpK7CSz0lRLQYEvsrFu1WxKJmw4onP
         5tU8wbryvjWcV8J178St8tD2bIzl8teG86w3r6f7C34EvaM9/ZkDwY7rCa5pXAjcm6qL
         wod1T1qUgG8L4CDU8T6/D0/izlClk0wg6h+c19Uw5gyI6Bl2jx/eAvAYgHIQETcf9vHt
         sKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DnypHcyiSmDYpsEnrDTzJLRsh2gQEWlfzVr6c4JGW3s=;
        b=q/hMHfdCT14TYgcJWIPwIYbYMfjdMMBt01DDZfvHcFG0xgzoY/XdiF3ZPUz8W9up6p
         9eOefk75ySlORyRd2smxIHqEIyvV94UaGoWOIIPTBioxIy2qbSkWmYVorEFxeDLPqVWo
         7QeAUAeLAz26pOmiQ2NRDCPp1D2lym/5Roc5nbqx4AY54Eblv/wNROPiYRwpe7v6WZjz
         5GFBwExUjkLOZGwiCf4VljwVabYQdreVY8FsZPlA5qtzr5PMrD+FX9yyZwageMs/nop3
         1GeaXaoCMa4My4iWgL6o2ZYct1mblo+e1p4gQOysT+iCoC/lsQ4Lrw/fRwwLFidfwA5d
         RBCQ==
X-Gm-Message-State: APjAAAXDBZIazYBJhDHzKQJQTWV0+tjc4a5gyvaYLIuWDq7t5s1d8N+r
        gBIbKA5IxLnm9bhEXR/43ekoJMnGALxMJTRNGeI=
X-Google-Smtp-Source: APXvYqytM3ljI+jWm3E+FZrjToihDhEk8GstYb412o1d3uBbgrjAaU2m0S2ecGjhHvSgvnPxlWWM1qTMQcAeO5jGqDE=
X-Received: by 2002:a2e:9b12:: with SMTP id u18mr23724844lji.142.1571851149345;
 Wed, 23 Oct 2019 10:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191023154038.24075-1-kpsingh@chromium.org>
In-Reply-To: <20191023154038.24075-1-kpsingh@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Oct 2019 10:18:57 -0700
Message-ID: <CAADnVQJFyM9fDE0DoJmKFk71D9MScHzmzjDmvq3s-KjK1D6bVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Fix strncat bounds error in libbpf_prog_type_by_name
To:     KP Singh <kpsingh@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 23, 2019 at 8:40 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> On compiling samples with this change, one gets an error:
>
>  error: =E2=80=98strncat=E2=80=99 specified bound 118 equals destination =
size
>   [-Werror=3Dstringop-truncation]
>
>     strncat(dst, name + section_names[i].len,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      sizeof(raw_tp_btf_name) - (dst - raw_tp_btf_name));
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> strncat requires the destination to have enough space for the
> terminating null byte.
>
> Fixes: f75a697e09137 ("libbpf: Auto-detect btf_id of BTF-based raw_tracep=
oint")
> Signed-off-by: KP Singh <kpsingh@google.com>

Applied. Thanks
