Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76F540A605
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 07:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbhINFjd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 01:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbhINFjc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 01:39:32 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB567C061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:38:15 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z5so25653158ybj.2
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7vApKyjBz9BABjB8YNS7fD3ho1vMd1jI4Y/jR2Yepo=;
        b=MtEIZ9I+wcqsLGJxZJeS3fW30efRsrWWgBJi70ApL/cFPZ9dYzVLDepR4ZtcKzpWvF
         RjUEt4s3D7sWuEzE5i/ZwDE9LABvMUbTl1rqJQ2iPDgRbVTpJtnTsrXdMSBIWz8wEBSW
         QxaozicqbzEdNxRmg4rurcSpZ1eMWuiUVB35qBCM8psbcxbjOrFU+Us2vou8Vbfgcv7o
         QbJnD4SrdXrtfeX4wIUAYFuut0k/WfkZ7ND488KB0NGvKTUqBymgSQu1vCGVrrUO/4nZ
         ZFR5d9UKMd/MnTI3PRDDX12uARRocwULXdxYKIs9UvQr6ciQNgL39RkHFk1yuOrBfEDz
         61tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7vApKyjBz9BABjB8YNS7fD3ho1vMd1jI4Y/jR2Yepo=;
        b=OcuqZRuwR9wtxmpcPONHqaH5mTKXqPXdr47E1zvD6TPnXfir9HsVdZWM0Vzc51Gs4t
         tm3PyBT0ylYpZhf9oqQpbYlcNqput1P71yMTZuzc/3/GgduioZygZPnfnmchduWQRR/w
         oCtkmqZoZh5k4BjgcegMc6cxIWqO3ORsLD0XBE/Twd0jjDwA3yYUNNeke0CIxFzWMhgp
         oNwHP3ihcGIlh7KIV3mIb8aOnSbv5HP7ZYBaMfVXI8EP3TEYXcN2SyfMRhMrvnbbc2g5
         qx4z/hfHn3am9EXEtB3pTsCnsiL15TNf4yWEf3+kiAyHtjfriFN/insHfvwiMMWdj/Jj
         7vIQ==
X-Gm-Message-State: AOAM530uefZQ+jD7kXfufKmaAkc68LS+BA6c6na3EFZ/8G/KU2kubfta
        0oWVmawzLurGGogZl9GLGwvwilEHsLOT8qTB7zrepPXo
X-Google-Smtp-Source: ABdhPJzNZkyncKX95gQqzW6HaWbaby7N6ehSVkCCe6TwyHWqLWQNq4M7YXwOx7mBxzyWnRAiBesbQYIu9Sx5eiAp5pE=
X-Received: by 2002:a25:47c4:: with SMTP id u187mr21547409yba.225.1631597895237;
 Mon, 13 Sep 2021 22:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <20210913155211.3728854-1-yhs@fb.com>
In-Reply-To: <20210913155211.3728854-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 22:38:04 -0700
Message-ID: <CAEf4BzZoWe33fXy0BBz9zzju3dKUeBL25230_yBp-W38VWAnNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/11] selftests/bpf: test BTF_KIND_TAG for deduplication
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 8:52 AM Yonghong Song <yhs@fb.com> wrote:
>
> Add unit tests for BTF_KIND_TAG deduplication for
>   - struct and struct member
>   - variable
>   - func and func argument
>

Can you please also add tests where you have duplicated struct,
variable, and func (three different tests), and each copy has two
tags: one with common value (e.g., common_val) and one with unique
value (uniq_val1 and uniq_val2, one for each copy of a
struct/var/func). End result should be a single struct/var/func with
three different tags pointing to it (e.g., common_val, uniq_val1,
uniq_val2). I.e., those tags are "inherited" by the deduplicated
entity and only a unique set of them is left.

> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c | 91 ++++++++++++++++----
>  1 file changed, 74 insertions(+), 17 deletions(-)
>

[...]
