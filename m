Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E469C40C9AD
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhIOQD7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbhIOQD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 12:03:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C5AC061574
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 09:02:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d18so1888688pll.11
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfnJgS1sYw/F6QtUwRHz7/z+V+aloNNg3tzACfoRfxA=;
        b=PPdmQVGpsyYTJ0gC3SJoopZZqF7f78ILhCeJGld/CJOZIx+h+tafUyX9XCPt9kByPt
         luBybQudRqR8Dua53hPaMsxvU0+SNG4hS11+hlWNUjTlFrS0uHAaFKQtbQlc/XyvY6oV
         mHUjb+HY5EKSpQkN+tC1BXazse/j+8CDBxNjNSL3eksXY1oIoTIqj1gx03P84AOYZsiI
         o4jocOPJ4Af5UcvA4q9MAK9KdduXFPQsljFbAhvNtQo840VKsAqg01enhgMcUd5sPwiF
         3IKRp7BK7aU6LA3ewc50ffeNDhkV7Hn/PxD3yQfklStcvDEFA5din10mRvpL39bgqOTs
         wmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfnJgS1sYw/F6QtUwRHz7/z+V+aloNNg3tzACfoRfxA=;
        b=53jE+yg0haG9QicLe7zYIeNFaE07kxE/mr9ZXpRvn6sTIlzUEfOS3srTgqkUqsT8s7
         C7HNF86hccEQI8UyFiHUA9lFkv2v8Uq+X7b09JCNXn8WrUwE98+Ke9aiOLyyTJoi6JFu
         QWiwg0/Osb0HahWTOdw6z4TX4Z7frptbXqrzPzLfE0XYs0iVQ4FwrzEugcocfWG4gKer
         E5vojsJ4WtZtY06EmHaSNU5Dk/ObPYzDMeq4Lu28IGymrgTqf+5i4m837BQbInkjbqw7
         zx9yNUylvp4NieKAO5xVP7ZWgymYN+fTsDkm9pIACKnx+z2/Hj5NkfJf+253TfwdTHjf
         DQ+A==
X-Gm-Message-State: AOAM531p89FzZqe9KStWsihWZ0CHALewRFdsnttmjLJHMZtLNOArXfNl
        ueDHzHW4z9CCHvZIS3V0JZUj+zzgznK37cld4ug=
X-Google-Smtp-Source: ABdhPJyEFVk03A6evYqHcgKJe2wcfT8ob1m29RCxxgAyh40RcNGuMZYnPVGBXaQBhqo2IdlqhfPWyzc+WapIvxLMipo=
X-Received: by 2002:a17:90a:9cd:: with SMTP id 71mr587177pjo.62.1631721759363;
 Wed, 15 Sep 2021 09:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210915061036.2577971-1-yhs@fb.com>
In-Reply-To: <20210915061036.2577971-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 15 Sep 2021 09:02:28 -0700
Message-ID: <CAADnVQLeb87YaZ_rS_0R+Thnt9scpxiT4NBQSy8hucdh82ofkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: skip btf_tag test if btf_tag
 attribute not supported
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 11:10 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit c240ba287890 ("selftests/bpf: Add a test with a bpf
> program with btf_tag attributes") added btf_tag selftest
> to test BTF_KIND_TAG generation from C source code, and to
> test kernel validation of generated BTF types.
> But if an old clang (clang 13 or earlier) is used, the
> following compiler warning may be seen:
>   progs/tag.c:23:20: warning: unknown attribute 'btf_tag' ignored
> and the test itself is marked OK. The compiler warning is bad
> and the test itself shouldn't be marked OK.
>
> This patch added the check for btf_tag attribute support.
> If btf_tag is not supported by the clang, the attribute will
> not be used in the code and the test will be marked as skipped.
> For example, with clang 13:
>   ./test_progs -t btf_tag
>   #21 btf_tag:SKIP
>   Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
>
> The selftests/README.rst is updated to clarify when the btf_tag
> test may be skipped.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied. Thanks for the quick follow up.
