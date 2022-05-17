Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C95295DE
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 02:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiEQAKt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 20:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiEQAKs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 20:10:48 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6112A63D0
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:10:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z18so17759843iob.5
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DkeDNRuKoPW1Hs2AxLOd8I7lK9jVb7I2shVdGFsXq0=;
        b=PxINvVO4WgIOvzOz8DjZOQ4yy6EL4TBL95sUKoV6gZq51G7KEjgyt0E3VfGD/6RSma
         joLuSWqIW85qamXOdQwJLh5Q9HBvaHuNbOOH7Cu2sJdFNwSbqwzMtg1ebXOF8D+Kmf/S
         3ixhdJ9iHqn4XhHZs+9CL3np9pefpd5KHxj7x4JwT75NaVfybr4KIiGk+8ONgdPw5WDb
         Exk1HFZ0RNHyzwN2eMWVYaH6PNRfGtxPK0lOrzktRpH0suTUWjEH85GhWDKj/OSgVvAB
         eVTgUKfRDD8poDmJDS67GKwHZ2Pca7I2MdjH3KojvUhIr14JjSdfUWjMeMkWkeooa3k/
         AEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DkeDNRuKoPW1Hs2AxLOd8I7lK9jVb7I2shVdGFsXq0=;
        b=wGJ7i+RA0Tfv7AN4FHw83BF2oLjo1dz6IftLZnEBdEfteSzHb2kkEksOTjxeRP8oYX
         U40yqT6UMj8NyjoObTKcOKKe3a7h7LE6ruHBOROAvClifHtJeaiWenHKnKLv2EAiLVF7
         Z5i+0eBhp2fSSDmOSq8kad60GwRnwXSQ0cSfGvt2XUcFBlXkizHP5Mbhd48d/vEXJPpH
         5YlqKnR5fSWmpOIBRkIukS/1RHpic7HzPIa6INm6nQiq2cHnETJLDm0fIWv10hrOVd58
         +NJQ03+TUYtxJS7QNNYElgp++zwufeiY1TvMIFTkgk2B1AbRNrZ2D1HrWWVK5WA/RagS
         Er7A==
X-Gm-Message-State: AOAM531rPwLvWvvUFRNU9sApIcgC975oR2ask7Qgr7bhDnTvNrWJuuK8
        Eaiw0IFD8Y4WDAZaiuuExq6570oBHAYeBmpKx5k=
X-Google-Smtp-Source: ABdhPJzsyk4KDn850kX/vq5Ss4ogCndE1D0PtrVZO0dhTyJvG/s/lIQIBR7oxaHizfzI36I2D5y2SRRW0MSTImLUssI=
X-Received: by 2002:a05:6602:2acd:b0:65a:9f9d:23dc with SMTP id
 m13-20020a0566022acd00b0065a9f9d23dcmr9012458iov.154.1652746246799; Mon, 16
 May 2022 17:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031237.3241544-1-yhs@fb.com>
In-Reply-To: <20220514031237.3241544-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 17:10:35 -0700
Message-ID: <CAEf4BzY5hRKJCs43-dQyaxnGh3OkL4UTOP_FYWpgAuKdYfgPgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/18] libbpf: Fix an error in 64bit
 relocation value computation
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
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

On Fri, May 13, 2022 at 8:12 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, the 64bit relocation value in the instruction
> is computed as follows:
>   __u64 imm = insn[0].imm + ((__u64)insn[1].imm << 32)
>
> Suppose insn[0].imm = -1 (0xffffffff) and insn[1].imm = 1.
> With the above computation, insn[0].imm will first sign-extend
> to 64bit -1 (0xffffffffFFFFFFFF) and then add 0x1FFFFFFFF,
> producing incorrect value 0xFFFFFFFF. The correct value
> should be 0x1FFFFFFFF.
>
> Changing insn[0].imm to __u32 first will prevent 64bit sign
> extension and fix the issue. Merging high and low 32bit values
> also changed from '+' to '|' to be consistent with other
> similar occurences in kernel and libbpf.
>
> Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/relo_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index aea16343a8f1..78b16cda86fa 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -1027,7 +1027,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>                         return -EINVAL;
>                 }
>
> -               imm = insn[0].imm + ((__u64)insn[1].imm << 32);
> +               imm = (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
>                 if (res->validate && imm != orig_val) {
>                         pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %llu -> %llu\n",
>                                 prog_name, relo_idx,
> --
> 2.30.2
>
