Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA2D446EFB
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 17:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhKFQgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Nov 2021 12:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhKFQgo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Nov 2021 12:36:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DFAC061570
        for <bpf@vger.kernel.org>; Sat,  6 Nov 2021 09:34:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u11so13012810plf.3
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pj+KEgmnE89YJvnnFucJS4k0Pd/akAWblWPfk8a8wZQ=;
        b=STFnFibriLdADiZCiG/UoLk+4ilQap2jEN+z/gX6Iq4jlSj3yAzAPSAqCVIZfhTJ2k
         mv08kkC95Y/Mv1qYV0KjmZRJfGzMQirC9wUxl+Wtn8ymb9NX1LIV0bYEgG8EXD38T4vT
         4kHyvaeGc7Ra4uH2oD7v5MeKsAmU3OknHFifdVkrSCQotGqLlgt9qZ2wDeXE1F7lZboB
         z26seHgMGa25sDVYXqzUFTJ+kc1L/Mx+k+d03hU1pSgMVKgxj1JZBDoMW66csXUBwN6n
         BTc+5cLgErcegNfWBVkFTiIgLBXkQH+Le8+xyRVoEy/7MNrsi7vhqWhIlUl7AeCzvR21
         BLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pj+KEgmnE89YJvnnFucJS4k0Pd/akAWblWPfk8a8wZQ=;
        b=joqd4GqMKfjmX+yeAyyn49dPBkgYx7EA5AV/TcmExsoSnycmWmn/2O03eFuyIzDFHD
         p5n3oQq4kP8hYQNfOq6BWsJpklNhaePobOw3/sE/kZrMjyjiP4PexqYqhVRPG00A/syO
         wR/zi6YAPEZPk/KYStj306lRpsv+lgAYUjzGvL7+irvmWKta6ErTSO8o9F3tCrIo3DYv
         ZrdwS9bkaoInrermnZhGrDdtU/x9bcJ3tb+ltu8U2OPAs4qx0wj0rtplz755kFngIL/h
         deLlhT6//sx+As7/FADdBIJDRZU9g9HpUmlKYbrGoGD9nYp2IizhT8KL7fWRYwct8ZHt
         X+9Q==
X-Gm-Message-State: AOAM533Yi1FfPbShcf4WPmi/4vggjpYuBOZreBqVOtLVaYgWX0roxlAv
        zE4mpbKAiDIalVlXS6h3tCO+4ZFmmartrYq4/1U=
X-Google-Smtp-Source: ABdhPJyw7Bc9ACf4FxKf6YqDm59g6xuakN5WIg0yJGJLMrHvasYX6hwyMJEz09l7ChpQHkmf1K4kIibM9KQ4hRT/qfw=
X-Received: by 2002:a17:90a:17a5:: with SMTP id q34mr38398648pja.122.1636216442972;
 Sat, 06 Nov 2021 09:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211105234243.390179-1-memxor@gmail.com>
In-Reply-To: <20211105234243.390179-1-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 6 Nov 2021 09:33:51 -0700
Message-ID: <CAADnVQ+6D7_7WQr2OdDRHr9tp9L-4zUvSMWh09j=-t8w-1BzCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] Change bpftool, libbpf, selftests to
 force GNU89 mode
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 5, 2021 at 6:36 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Fix any remaining instances that fail the build in this mode.  For selftests, we
> also need to separate CXXFLAGS from CFLAGS, since adding it to CFLAGS simply
> would generate a warning when used with g++.
>
> This also cherry-picks Andrii's patch to fix the instance in libbpf. Also tested
> introducing new invalid usage of C99 features.
>
> Andrii Nakryiko (1):
>   libbpf: fix non-C89 loop variable declaration in gen_loader.c
>
> Kumar Kartikeya Dwivedi (5):
>   bpftool: Compile using -std=gnu89
>   libbpf: Compile using -std=gnu89
>   selftests/bpf: Fix non-C89 loop variable declaration instances
>   selftests/bpf: Switch to non-unicode character in output
>   selftests/bpf: Compile using -std=gnu89

Please don't.
I'd rather go the other way and drop gnu89 from everywhere.
for (int i = 0
is so much cleaner.
