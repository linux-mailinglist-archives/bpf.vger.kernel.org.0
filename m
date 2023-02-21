Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAC969E59D
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 18:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjBURKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 12:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjBURKn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 12:10:43 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9957523647
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 09:10:38 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p5so2654529pgh.11
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 09:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gEL4ASNYrYmUtX3CARtk2RZ23IJMaaAjPbfRvrnZ03k=;
        b=rGFZFgoJ+w2kILzTXhJ2RlQ0OFoABf1Ab+sYsLcP/dIm4n8LJwyyVrUpOfvRLj6sHr
         OzYf+/RWYfErYhiKmBnxZHYprGSGD5UpehomAFlZV5IcxDOYYPpRz3qNDelSy/9Z5DC0
         zGH+VYQn9E65B1uNv6ywkIpylre+fivAMs+pibCRhyjMsjhiM5t9Lq1vkhDJbJq5wWcj
         L1wt4D3c6E9Nah/7cDla2Xp73yqzqOAbLn/o3gcaXT9rC6pTqiDv2QLH16JP0Vd+prlf
         BQ0Na6e4oaFHcjAmqpJbFbiehANa5kveQaEq77KhV1bYNLzB/SkwdU31m66SxrExP0dq
         vGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEL4ASNYrYmUtX3CARtk2RZ23IJMaaAjPbfRvrnZ03k=;
        b=VeHEwcjEcrA66Z+kqeX7IrREQs05wi8AXVNnBsNgl70uquhdAZghhQvdiFqAQ6sdFQ
         sdoIc/zTlVeMpyngypMC3EVjfgHP+lqPMUGfZ24qpyx74nT7qXxJqS4aLQd/hJetPGSK
         NSz2l/a7QY9xtAOos4/yg+jdfBKuQ+K82fFUhJwPlLu9pkWEZbwqpHZDVN+zKG4KgXam
         NDN49WopKZmTVLdOTggemVZsNtxSFzsZBLyS7pw7aTTvp9XWiN4Nq7XnFDC4Ys8iQq3F
         FwYbv2+AJNCD9Q7iSS7UrleroljBLnYGe4qlKCc8eSuTJTdNiaMGXUAh7MYr2OvzVIPS
         aN0w==
X-Gm-Message-State: AO0yUKUQmVZBrS+uG10QXfQy7rINjdmJRehGK8PPLJKhU0MHLOor+4x3
        AhUU2od++Y1RvzxosFUZfWYtXCFKGNvZH19OGsiMsw==
X-Google-Smtp-Source: AK7set+SIIkRYcoA1DvfxPsvmL8MBGMmaNW0kc8npfLzFdMot6sZExhMOzDZ9gYgXWymOt+XugYa9xbT8N4+xD0kawE=
X-Received: by 2002:a62:1457:0:b0:5a8:d7a9:46b5 with SMTP id
 84-20020a621457000000b005a8d7a946b5mr684484pfu.5.1676999437804; Tue, 21 Feb
 2023 09:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20230220163756.753713-1-iii@linux.ibm.com>
In-Reply-To: <20230220163756.753713-1-iii@linux.ibm.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 21 Feb 2023 09:10:25 -0800
Message-ID: <CAKH8qBsgvCjN3tp77S3TWbYH6iysqgLNFSKOMSnvsHwhEwusug@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Check for helper calls in check_subprogs()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 8:38 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> The condition src_reg != BPF_PSEUDO_CALL && imm == BPF_FUNC_tail_call
> may be satisfied by a kfunc call. This would lead to unnecessarily
> setting has_tail_call. Use src_reg == 0 instead.

Acked-by: Stanislav Fomichev <sdf@google.com>

(although not sure on src_reg == 0 vs !src_reg. Alexei seems to be
favoring the latter?)


> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/bpf/verifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e63af41a7e95..6d4632476c9c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2462,8 +2462,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
>                 u8 code = insn[i].code;
>
>                 if (code == (BPF_JMP | BPF_CALL) &&
> -                   insn[i].imm == BPF_FUNC_tail_call &&
> -                   insn[i].src_reg != BPF_PSEUDO_CALL)
> +                   insn[i].src_reg == 0 &&
> +                   insn[i].imm == BPF_FUNC_tail_call)
>                         subprog[cur_subprog].has_tail_call = true;
>                 if (BPF_CLASS(code) == BPF_LD &&
>                     (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
> --
> 2.39.1
>
