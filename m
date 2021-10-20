Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B2A435369
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhJTTH1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 15:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhJTTH1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 15:07:27 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF6C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 12:05:12 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id q189so14172354ybq.1
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9NC6yXMKS4rPFZp2VpjVBVi6UJyqvFs68L93vroPMQ=;
        b=YBTy6qOq7/fQNjitTYMlpiZgjwtp8/JT3B8yNZLADBASbQmQ23AA/CVm85P809Wxes
         hxZ+R6kauNizv2ZsvRl6WvTEA8HmeSGKqxLHYk7x/tIvlk5M9gOiFe90LOMvf4V9csi3
         SBaFWywPRr+MtKmTF9p65OyZ/HbFOX2t/4tztDfXt4XFvtS7ROWjWt1MfYt3H8pe37ZA
         9p6AoJaoDuX1NyD3Eo8Y7sFURF6wBJsuYtAYKau1XjK3+9iDxnJGOv2NS8w/V+immC42
         3KQGlFqLXzkb3+BoUbW0AohcFK9O3bIysX+f7IW63oZoKTEUrKNv+QLPb8I4ZBYStVN1
         ZgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9NC6yXMKS4rPFZp2VpjVBVi6UJyqvFs68L93vroPMQ=;
        b=jkJrp0dt0NIHvn5/HtTDvSezpl3sceQviPLWqSQJZYvIPVh0ljBlvhyEibFREpRlLm
         UlbEjVOnUL9C4E2A/YS6fSQAwmw7W8XoIpvjhm0pKKglXpT0Yfj7qg2zSuHGX14CwTZS
         pGOb+IQwb5JLknpb2LVYWRPuho0ev6DWBP7uFFt2ejaNSWX/qZNCKm7Y7YZCMhoX9QRK
         rCqkoavO/etIJod2fNNEXQOq9jsivEX3BPj0b46FIX5sLPiftuxM+igsfXCHlTu0UWnX
         ulw4caBonnjFgDsvKgymfe/S3azHbzRgy9TrFs7OnohFDtDnyMfRNWHvnzLcyRzR76v7
         hvlA==
X-Gm-Message-State: AOAM530aq9NXd+W5M+H9mXp542n2cjJ8wdmwWQ0/A9raq9c5bjv9lj2X
        6JS+cwRYyhOoDKxZ1FW1IU1RcEM0AVRvUsK9mkQ=
X-Google-Smtp-Source: ABdhPJzfvJS0PIl4/rZBSiXpBScVVU/0Cn0U9lP4LqX+nSFxWYkQvmuMTSPe/qGmEOupVRMk+Aq1bF09hDcLej6DnJY=
X-Received: by 2002:a25:918e:: with SMTP id w14mr894555ybl.225.1634756709617;
 Wed, 20 Oct 2021 12:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211012164838.3345699-1-yhs@fb.com>
In-Reply-To: <20211012164838.3345699-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 12:04:58 -0700
Message-ID: <CAEf4BzY9rhjhZvYXJm_ku+tBio85-bzkLSp_SkUiEqvJdO2NLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: rename BTF_KIND_TAG to BTF_KIND_DECL_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 12, 2021 at 9:48 AM Yonghong Song <yhs@fb.com> wrote:
>
> Patch set [1] introduced BTF_KIND_TAG to allow tagging
> declarations for struct/union, struct/union field, var, func
> and func arguments and these tags will be encoded into
> dwarf. They are also encoded to btf by llvm for the bpf target.
>
> After BTF_KIND_TAG is introduced, we intended to use it
> for kernel __user attributes. But kernel __user is actually
> a type attribute. Upstream and internal discussion showed
> it is not a good idea to mix declaration attribute and
> type attribute. So we proposed to introduce btf_type_tag
> as a type attribute and existing btf_tag renamed to
> btf_decl_tag ([2]).
>
> This patch renamed BTF_KIND_TAG to BTF_KIND_DECL_TAG and some
> other declarations with *_tag to *_decl_tag to make it clear
> the tag is for declaration. In the future, BTF_KIND_TYPE_TAG
> might be introduced per [3].
>
>  [1] https://lore.kernel.org/bpf/20210914223004.244411-1-yhs@fb.com/
>  [2] https://reviews.llvm.org/D111588
>  [3] https://reviews.llvm.org/D111199
>
> Fixes: b5ea834dde6b ("bpf: Support for new btf kind BTF_KIND_TAG")
> Fixes: 5b84bd10363e ("libbpf: Add support for BTF_KIND_TAG")
> Fixes: 5c07f2fec003 ("bpftool: Add support for BTF_KIND_TAG")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Patch bot missed this, but this was applied a while ago ([0]).

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=223f903e9c832699f4e5f422281a60756c1c6cfe

[...]
