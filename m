Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B0620FC94
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 21:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgF3TSg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 15:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF3TSf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 15:18:35 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FBDC061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 12:18:35 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m8so5602978qvk.7
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbD0ym/8gUDOccptalYMdsnmDuko1c2ov/ZNFj+Xw5U=;
        b=YPEyl2AbapEhJSQL89PnE8V6528u69vJVWoiN3u6C0SVbhGus8Bw2ZD8EoMCA+mh0j
         hAjuhdgeqkjFpscDwf8QrFimtszm5ZaNJ6fmzMBpxck6/dZpFNmuZzk/yEplucSpJyPB
         S5ByknMIJ4HlcLoEFvblZOIssDzOxvYVzNzyET5QpIYu4BY2AEPooWndo+L9CdrIcMB1
         M1aPgwXpPNcZywKqshwTJlJS3ydwKD6OXjyHWzCfx1Q/CyqMFJxKNxCVMUdr65CNdS9u
         U9pIrOvrqZdHT8U9f388Pg1/6F26qn+sCruuYCRv1yMs17Ub8gsNGsGOSnykVcSVixUr
         vqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbD0ym/8gUDOccptalYMdsnmDuko1c2ov/ZNFj+Xw5U=;
        b=OyzRu8ijSWiDmc38FpTK22GRyehK5RUToCAOt+UKWqGmQgXgbm0GF3LudZokxTHWDB
         l+CpnCDZAEfG/fUi03O2uyXpo0zM4UZ9WH+kfdyFIPcd3al7hGOxD5JJFG9/Z3c2a8t5
         pT7iGhF67uFTaw/k8jD1WfQ+ZdQzy3/bogNN839DQ+NiTrCKJlSsGMzoAzEyR99U6/7Z
         pM81Uqe8+OntkyxjAJho3DMnYF9OlAEE64k9Kmmv5mCq7tFbNGYRzYurznzmMeFpvoB8
         j25E5hkZZMDRpEsI9Z+UKrlMOdpytal5NUzbylamQIDUiaDYJ+x0DSsTIvSF90/+yuLO
         NCXg==
X-Gm-Message-State: AOAM530uvu9bY/RcuQmJFYKQ2EEs8LRQpzHGvDd2gOisBIIF37MyWnrn
        tJM6RhWdDSKAlZqPkIUBL8PAVFg3gLRFG0lhWIc=
X-Google-Smtp-Source: ABdhPJx2KDZ5A1BNYcVqiGPxDQJ5t+0wfGF4ggXoVR+sHQI2z6/VRn4uMbVDXUyJfmq57aliBG12ziBvTjoTk8ACrQw=
X-Received: by 2002:a05:6214:946:: with SMTP id dn6mr11241768qvb.224.1593544714663;
 Tue, 30 Jun 2020 12:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200630171240.2523628-1-yhs@fb.com> <20200630171240.2523722-1-yhs@fb.com>
In-Reply-To: <20200630171240.2523722-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Jun 2020 12:18:23 -0700
Message-ID: <CAEf4BzaTS3gQf0L_KhMu8b-asa3=Pq8H5f_sH=JjbWxy0Q70cQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix an incorrect branch elimination by verifier
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 11:46 AM Yonghong Song <yhs@fb.com> wrote:
>
> Wenbo reported an issue in [1] where a checking of null
> pointer is evaluated as always false. In this particular
> case, the program type is tp_btf and the pointer to
> compare is a PTR_TO_BTF_ID.
>
> The current verifier considers PTR_TO_BTF_ID always
> reprents a non-null pointer, hence all PTR_TO_BTF_ID compares
> to 0 will be evaluated as always not-equal, which resulted
> in the branch elimination.
>
> For example,
>  struct bpf_fentry_test_t {
>      struct bpf_fentry_test_t *a;
>  };
>  int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>  {
>      if (arg == 0)
>          test7_result = 1;
>      return 0;
>  }
>  int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
>  {
>      if (arg->a == 0)
>          test8_result = 1;
>      return 0;
>  }
>
> In above bpf programs, both branch arg == 0 and arg->a == 0
> are removed. This may not be what developer expected.
>
> The bug is introduced by Commit cac616db39c2 ("bpf: Verifier
> track null pointer branch_taken with JNE and JEQ"),
> where PTR_TO_BTF_ID is considered to be non-null when evaluting
> pointer vs. scalar comparison. This may be added
> considering we have PTR_TO_BTF_ID_OR_NULL in the verifier
> as well.
>
> PTR_TO_BTF_ID_OR_NULL is added to explicitly requires
> a non-NULL testing in selective cases. The current generic
> pointer tracing framework in verifier always
> assigns PTR_TO_BTF_ID so users does not need to
> check NULL pointer at every pointer level like a->b->c->d.
>
> We may not want to assign every PTR_TO_BTF_ID as
> PTR_TO_BTF_ID_OR_NULL as this will require a null test
> before pointer dereference which may cause inconvenience
> for developers. But we could avoid branch elimination
> to preserve original code intention.
>
> This patch simply removed PTR_TO_BTD_ID from reg_type_not_null()
> in verifier, which prevented the above branches from being eliminated.
>
>  [1]: https://lore.kernel.org/bpf/79dbb7c0-449d-83eb-5f4f-7af0cc269168@fb.com/T/
>
> Fixes: cac616db39c2 ("bpf: Verifier track null pointer branch_taken with JNE and JEQ")
> Cc: Andrii Nakryiko <andriin@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Wenbo Zhang <ethercflow@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

You missed Reported-by: tag, please add.

Otherwise lgtm, thanks for fixing!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  kernel/bpf/verifier.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8911d0576399..94cead5a43e5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -399,8 +399,7 @@ static bool reg_type_not_null(enum bpf_reg_type type)
>         return type == PTR_TO_SOCKET ||
>                 type == PTR_TO_TCP_SOCK ||
>                 type == PTR_TO_MAP_VALUE ||
> -               type == PTR_TO_SOCK_COMMON ||
> -               type == PTR_TO_BTF_ID;
> +               type == PTR_TO_SOCK_COMMON;
>  }
>
>  static bool reg_type_may_be_null(enum bpf_reg_type type)
> --
> 2.24.1
>
