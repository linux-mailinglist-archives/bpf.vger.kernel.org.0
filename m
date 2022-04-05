Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073A34F54F4
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 07:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbiDFFWq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 01:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1846091AbiDFCCm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 22:02:42 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF237B9196
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 16:32:00 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r2so1039597iod.9
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POD6Qjur6LfzcM/9s3cmH2hf63oSG+sPhtXq0a0ok20=;
        b=LvwHAUrJbXqxA7CUbzTr2U+lTWkcqsRvHdNTmKJbtnMAaH63UANLMYQx+9+dyCcgf1
         ERREVKQnFbwPomzMbBj34w5c1DcQlsTmB+8zLkYjcXJMTQd+CPjsfP1t5ZIf+S8nfuLh
         VyB0w1Nn4bdr17Xry7K0nj7phu3LndpFwj1Xvoux8SZyoANZyocj2PM5lJkSjBOFT2bM
         v4AFCAlpApqOSMAoApIHAfh0a26CUj6meeR0OPibaq13x0rz7Fszy7TWsPKBWMkyIZKt
         4Nn29kKfwJo5nfB/83fR9Oyn8uWeqZewuIcU1gwNkYmKxngdPY7pJQSQnxLg1bEDhpOm
         8d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POD6Qjur6LfzcM/9s3cmH2hf63oSG+sPhtXq0a0ok20=;
        b=FhEUC01CTgIxZZa7oQ1PNOlO2FM7XTo+rIhQBU8IzYsXDdXEWY+mf/sR8RZlBEz6e1
         vR6Tq24FmOGJyKacUU25HJaiBnlgXHx2r1Qhais2QWBnWG8mUjtn9CsIG3XCsR47IEnf
         xDLRADdRu23c36GFFPyHhA/ja/C97HQ4brrU6RA1Yv2lmfRhpiNbzKagsZJceI0aF0Zr
         ds9wSVUYVLdo3h3h3Cdzf/Odr63IcBRyQ1RgvtQMLh991bN3CsHZNzZkLkIP7u8uLVv4
         5d2s7ukIxqm4ir/CeEyjMmATKwP7j933VWtJwFVKR5FBc9uwrfMrBiuMQ9Nw3Oxstxkd
         GUTA==
X-Gm-Message-State: AOAM531uW5z2KN3GepzJ7+768NT6ENb+JZnOmzlGGJVkj2bPqxah+5Uk
        /BO5pqCYHJSUrE76u6q49umIY+FR3eM4VzMBbU0=
X-Google-Smtp-Source: ABdhPJzQnCNF23xT9YERy1ZxO6IWW4wP1kgfSA5HteXpoMVMoNdmd0sswaF0dIJsgZaXnd/ho26CrG3mJ8tXFhmpZZA=
X-Received: by 2002:a05:6638:1685:b0:323:9fed:890a with SMTP id
 f5-20020a056638168500b003239fed890amr3192763jat.103.1649201520414; Tue, 05
 Apr 2022 16:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220404083816.1560501-1-nborisov@suse.com> <20220404083816.1560501-2-nborisov@suse.com>
In-Reply-To: <20220404083816.1560501-2-nborisov@suse.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Apr 2022 16:31:49 -0700
Message-ID: <CAEf4BzYsaY7nToHYAekNGyuBcq6BaG1_VBo=7TgjbZT+29gdYA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] libbpf: Add userspace version of for_each_member macro
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 4, 2022 at 1:38 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> There are multiple places in libbpf where iteration of struct/union
> members is required. Instead of open-coding it let's introduce a
> convenience macro.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  tools/lib/bpf/btf.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 061839f04525..74039f8afc63 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -578,6 +578,12 @@ static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
>         return (struct btf_decl_tag *)(t + 1);
>  }
>
> +#define for_each_member(i, struct_type, member)         \
> +       for (i = 0, member = btf_members(struct_type);  \
> +            i < btf_vlen(struct_type);                 \
> +            i++, member++)
> +
> +

this now becomes part of libbpf's API, do we really need it to be part
of an API? And even if we did add it, we'll need to do this for params
and enums for completeness.

>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> --
> 2.25.1
>
