Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF914B91BE
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 20:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiBPTuN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 14:50:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiBPTuM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 14:50:12 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB0202068
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 11:50:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso3353808pjh.5
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 11:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BuL1ipD2gGe4o7BGjvFMmlV2RVMNL2Povfyi79zWwiA=;
        b=MainJyAa+4AnpCQieF5FvZX3qIBm61X3aVXk31q1DZb7rWPFC89pEbvWI3NmK1Mpqg
         WCpxiD9r/J+IShoRIua+k9oK5CVJntRcxFZoItPx+65m9oybha4EMj6idUm5kpIWj5aJ
         9RQoLgmoLsawEoy+bxduevi6085TSgmq6lLskily6RwXe0vFY6p71+BEsFOnfyPYcUzA
         PH8LT1TNi2aNTYg8Vd6oSo8IuIUJkdYN6JBug8in4cutji8Omilt4gJVOQt7ZSIs17zl
         Tecft2Zb08Qxx89oxkvfy9r+sOlP+nESAAjHHYUWfw4Fe7tdxKjnMou+K+KA0bZfDweN
         XD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BuL1ipD2gGe4o7BGjvFMmlV2RVMNL2Povfyi79zWwiA=;
        b=X7Aikwj6GpOinFr9V/eqgqLHLUAWZev+Pgx7nvYZcmwJQ70rxgzicXpmMQ/uyVBr0I
         7YjmyTxLajyp316x9Hr9NeLntr+Xb0tliTDEzmpQceE8zAsaliEB6xs9nsruaMuACI4m
         9HXx5AHLXsYuTiYJc7vw1HIfIUtriNp/QJjQuSLXsn5qHt2me+fLas9J3z2sPHcIxgja
         HLmbzBzPq8CNW5FehRW5l5T8yxxj8kl5g+ipKjByqh7RuFfLBDL7yPUEubxeYGajG3JK
         qBeuwxKTjLmpwWwos6HBjjTI4KcAlxcoqhSa1Ljvi0iVPOjMDSagUndnqad1aSAbZvGo
         ZxzA==
X-Gm-Message-State: AOAM532He6rUmD7ZYbSeen2MXbQssbdt3EfaMyJMLM81QLPViWvQEt9E
        36po3auMnBNN3wS6hVcWpcs=
X-Google-Smtp-Source: ABdhPJyhee4T4ObCInKxn6GZnWd25dU3aClKm5DqUWhSu48XTUNHsDvljJSmpyEAmCDCm6DNY0AZ7w==
X-Received: by 2002:a17:90b:4a02:b0:1b8:d3c7:7a2b with SMTP id kk2-20020a17090b4a0200b001b8d3c77a2bmr3605851pjb.194.1645040999331;
        Wed, 16 Feb 2022 11:49:59 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::3:ef8d])
        by smtp.gmail.com with ESMTPSA id j3sm68568pfc.43.2022.02.16.11.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:49:58 -0800 (PST)
Date:   Wed, 16 Feb 2022 11:49:56 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Fix crash due to OOB access when reg->type >
 __BPF_REG_TYPE_MAX
Message-ID: <20220216194956.dl3kjtxfrdownoga@ast-mbp.dhcp.thefacebook.com>
References: <20220216091323.513596-1-memxor@gmail.com>
 <CAADnVQLnurHLFZY3tL+SL9MgnJj63JKx8KjTwSS0mzsNN6JJTw@mail.gmail.com>
 <20220216173348.luidfddtou6yfxed@apollo.legion>
 <CAADnVQJ-wMjyBQUYELYCjDTST8M5+TKRw2fi7nfrv79319fwog@mail.gmail.com>
 <20220216182954.jwzrum5ivekxca72@apollo.legion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216182954.jwzrum5ivekxca72@apollo.legion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 16, 2022 at 11:59:54PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > Just use reg2btf_ids[base_type(reg->type)] instead?
> > >
> > > That would be incorrect I think, then we'd allow e.g. PTR_TO_TCP_SOCK_OR_NULL
> > > and treat it as PTR_TO_TCP_SOCK, while current code only wants to permit
> > > non-NULL variants for these three.
> >
> > add && !type_flag(reg->type) ?
> >
> 
> Ok, we can do that. WRT Hao's suggestion, we do allow NULL for ptr_to_mem_ok
> case, so doing it for all of check_func_arg_match won't work.

Right.

> > But, first, please describe how you found it.
> > Tried to pass PTR_TO_BTF_ID_OR_NULL into kfunc?
> > Do you have some other changes in the verifier?
> 
> Yes, was working on [0], tried to come up with a test case where verifier
> printed bad register type being passed (one marked with a new flag), but noticed
> that it would fall out of __BPF_REG_TYPE_MAX limit during kfunc check. Also, it
> seems on non-KASAN build it actually doesn't crash sometimes, depends on what
> the value at that offset is.
> 
>   [0]: https://github.com/kkdwivedi/linux/commits/btf-ptr-in-map

Nice. Thanks a ton. I did a quick look. Seems to be ready to post on the list?
Can you add .c tests and post?

Only one suggestion so far:
Could you get rid of callback in btf_find_struct_field ?
The callbacks obscure the control flow and make the code harder to follow.
Do refactor btf_find_struct_field, but call btf_find_ptr_to_btf_id directly from it.
Then you wouldn't need this ugly part:
/* While callback cleans up after itself, later iterations can still
 * return error without calling cb, so call free function again.
 */
if (ret < 0)
  bpf_map_free_ptr_off_tab(map);

I've been thinking about the api for refcnted PTR_TO_BTF_ID in the map too.
Regarding your issue with cmpxchg. I've come up with two helpers:

BPF_CALL_3(bpf_kptr_try_set, void **, kptr, void *, ptr, int, refcnt_off)
{
        /* ptr is ptr_to_btf_id returned from bpf_*_lookup() with ptr->refcnt >= 1
         * refcount_inc() has to be done before cmpxchg() because
         * another cpu might do bpf_kptr_xchg+release.
         */
        refcount_inc((refcount_t *)(ptr + refcnt_off));
        if (cmpxchg(kptr, NULL, ptr)) {
                /* refcnt >= 2 here */
                refcount_dec((refcount_t *)(ptr + refcnt_off));
                return -EBUSY;
        }
        return 0;
}

and

BPF_CALL_2(bpf_kptr_get, void **, kptr, int, refcnt_off)
{
        void *ptr = READ_ONCE(kptr);

        if (!ptr)
                return 0;
        /* ptr->refcnt could be == 0 if another cpu did
         * ptr2 = bpf_kptr_xchg();
         * bpf_*_release(ptr2);
         */
        if (!refcount_inc_not_zero((refcount_t *)(ptr + refcnt_off)))
                return 0;
        return (long) ptr;
}


and instead of recognizing xchg insn directly in the verifier
I went with the helper:
BPF_CALL_2(bpf_kptr_xchg, void **, kptr, void *, ptr)
{
        /* ptr is ptr_to_btf_id returned from bpf_*_lookup() with ptr->refcnt >= 1
         * or ptr == NULL.
         * returns ptr_to_btf_id with refcnt >= 1 or NULL
         */
        return (long) xchg(kptr, ptr);
}
It was easier to deal with.
I don't have a strong preference for helper vs insn though.
Let's brainstorm after you post patches.

xchg or bpf_kptr_xchg only operation seems to be too limiting.
For example we might want to remember struct task_struct or struct net
in a map for faster access.
The __bpf_nf_ct_lookup is doing get_net_ns_by_id().
idr_find isn't fast enough for XDP.
We can store refcnted 'struct net *' for faster lookup.
Then multiple cpus will be reading that pointer the map, but if only 'xchg' is
available that use case won't work. One cpu will win the race.
So we need bpf_kptr_get() will be an acquire helper.
The bpf prog will do an explicit put_net(ptr); which will be a release kfunc.

Simply reading refcnted ptr_to_btf_id from a map is PTR_UNTRUSTED too for sleepable bpf progs.
Such pointers are under rcu_read_lock in non-sleepable, but it still feels safer
to always enforce refcnt inc/dec when accessing them to pass into helpers.

> I was planning to send a verifier test exercising this but it seems
> fixup_kfunc_btf_id support for test_verifier.c is not in bpf tree yet, so when

Obviously we have to wait until the merge window.

> it is merged I will provide a small test case, it is basically this on bpf-next:
> 
> diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> index 829be2b9e08e..5f26007ceef1 100644
> --- a/tools/testing/selftests/bpf/verifier/calls.c
> +++ b/tools/testing/selftests/bpf/verifier/calls.c
> @@ -1,3 +1,22 @@
> +{
> +       "calls: trigger reg->type > __BPF_REG_TYPE_MAX",
> +       .insns = {
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +       .result = REJECT,
> +       .errstr = "XXX,
> +       .fixup_kfunc_btf_id = {
> +               { "bpf_kfunc_call_test_acquire", 3 },
> +               { "bpf_kfunc_call_test_release", 5 },
> +       },
> +},
>  {
> 
> Sending it rn I think may lead to flaky CI, so we can wait.

Right. Let's wait until bpf tree merges into bpf-next.

> If all of this makes sense, should I respin?

Please do.
We can get bpf PR out asap after that.
