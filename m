Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987DD40451D
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 07:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhIIFno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 01:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhIIFnm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 01:43:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC52C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 22:42:33 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v17so1549790ybs.9
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xzomm9x21jUr/6p7Yyw3wbpTbZkbWOtwTJGweV96G44=;
        b=N42zPS9fwqYlEmu6UnZZN132zvIBPeuAxoccsWgQpXNf2XL8TcJObYq+FM45qJSu2F
         WsTfVSuQaE2bwoU9H90h319Emr7TnsA6QiU7t0+KykJMmCzOfvArS3pb7VLedkl04CFz
         1IAFiUl7bMbPhfhnNAGFER+y0CwNqNSF4J3IjUiSykP8LZG+0c3MqJwJrcQaZdbzvJq2
         aH/b/Z6k6A2DIiXquf5XAeLEHxPdY0b7L96511sPt3AgPkLeLE37yjIUYCan2/dPz8Ab
         aDBEvWHO6X8FH0NnFVsimWQslTlT8ZFrYqrrZtkWGQ15C3txBCiY9tOcr0hhGvoR43P2
         7sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xzomm9x21jUr/6p7Yyw3wbpTbZkbWOtwTJGweV96G44=;
        b=A+D9eXT2l7xoDGB8YKzxi3LWefQMwxN7u9mOu6U5ZQSSgukgz6N4Bm+TsLTTqhGDOr
         VN+6PRtx1S+2tF0DWeVQ8QcmCmdTKPHWfU1xKRN4zFZIp0ZUmGPTjLoMSDAlruRmFfRo
         60JJumxybGq8nURGdUueCaog1/a2hrYtGfiDA1dKVWwgY6xkegqsW+bzdyzclpTxFDhl
         5PMuXc08Th2+6RdukNzlbW1ZWOuy6b80E432l9CYzSz5/aPny15Lgsn5aWTxW/p3eeeX
         dc3df4TuE93aA1+oldrDzh4Ggo4ILTPUvgJiAEbf0QjOG4maNi4opnMYjuychI6V6H0f
         jtMg==
X-Gm-Message-State: AOAM5310pfRCHYGgj02Hz40NwWS5Ey4QhJVQ/nEm+8vjgySs4izw1/Ms
        83kuJX2DBdWWocquwMtVo2cWf6t9sDKKRsrC4Xw=
X-Google-Smtp-Source: ABdhPJw37ATOu/YiyysntFwYIGAFSwwkRc5HjU/PcjNnVxa7Mw0cQEdIVPzRtse7uTdw905QW0spLt4i0KPIftxPCmA=
X-Received: by 2002:a25:65c4:: with SMTP id z187mr1720248ybb.113.1631166153041;
 Wed, 08 Sep 2021 22:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210907230050.1957493-1-yhs@fb.com> <20210907230138.1960995-1-yhs@fb.com>
In-Reply-To: <20210907230138.1960995-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 22:42:22 -0700
Message-ID: <CAEf4BzYy7_1jUHiNy6VWJ7nw4sUa5gABW1Mosc-1zcd+unvSZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 9/9] docs/bpf: add documentation for BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add BTF_KIND_TAG documentation in btf.rst.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  Documentation/bpf/btf.rst | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>

[...]

> +2.2.17 BTF_KIND_TAG
> +~~~~~~~~~~~~~~~~~~~
> +
> +``struct btf_type`` encoding requirement:
> + * ``name_off``: offset to a non-empty string
> + * ``info.kind_flag``: 0 for tagging ``type``, 1 for tagging member/argument of the ``type``
> + * ``info.kind``: BTF_KIND_TAG
> + * ``info.vlen``: 0
> + * ``type``: ``struct``, ``union``, ``func`` or ``var``
> +
> +``btf_type`` is followed by ``struct btf_tag``.::
> +
> +    struct btf_tag {
> +        __u32   comp_id;
> +    };
> +
> +The ``name_off`` encodes btf_tag attribute string.
> +If ``info.kind_flag`` is 1, the attribute is attached to the ``type``.

This contradicts "info.kind_flag" description above

> +If ``info.kind_flag`` is 0, the attribute is attached to either a
> +``struct``/``union`` member or a ``func`` argument.
> +Hence the ``type`` should be ``struct``, ``union`` or
> +``func``, and ``btf_tag.comp_id``, starting from 0,
> +indicates which member or argument is attached with
> +the attribute.

Does the kernel validate this restriction for the VAR target type?
I.e., if we have kind_flag == 0 (member of type), we should disallow
VAR, right?

> +
>  3. BTF Kernel API
>  *****************
>
> --
> 2.30.2
>
