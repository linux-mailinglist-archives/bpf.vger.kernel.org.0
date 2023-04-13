Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59946E17C7
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 00:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDMW5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 18:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDMW5Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 18:57:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4C10B
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 15:57:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id hg14-20020a17090b300e00b002471efa7a8fso3215014pjb.0
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681426635; x=1684018635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp+7T+X5OHOPV54KmtSDf73zRf+aBVxnBu3O3snJ8As=;
        b=QIRmkiIHlnINNHc6mzWDvMvX0YbApWn6CcdDnCBLC1L+KgyCsavVVPv49hhS3MH+F0
         lvU039EEtdXD0KF2YwCLJmeZT7218yP9mPuDCkrVFAa00S0Djk1cL5jyKN//5hpAYCur
         LvXA1/Z6E2yRFwNRlEpeWtBOzKcUOf/LQQLi1FxjzmYOOzrz49AjrHFGEOxjxqH6oq3j
         o3m4Bmqnfk3oPiiTgAWr26C+Tz1gPX9dC1LGFvZH8bjWcIIkKFcUnGOIV99uvYqAyn7B
         MGlSKzh0Q44lt7DPaXYJtPaY/7MA3bx1BJYKpa6A+vHQqx4zxmmXZGmsmtImBjib+szg
         /UBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681426635; x=1684018635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp+7T+X5OHOPV54KmtSDf73zRf+aBVxnBu3O3snJ8As=;
        b=TIGEd8WyPnOU65p8roKthclb+wcmIxHdWO+Ydc1iind9aidKJmCC3zbHTyNLw3abUV
         yUXKLRrzQOf9gr1GZu3ZifN0Bs5wIAmipYLNRwC8CkU/JzySysRmIUVkCnpZX3PgrXlz
         sFxHyu/uz+TQF1jZaDXWsyKGexGgmHx3thJ4uGcButSYdwoY/gnHayUIhPYdG4rDopxc
         eq1Mah0EWddiQwyExafgcUjW2fANY5r8zxD49+FzR42++mU3DAW0h/rcw4grUTETKuf8
         LWIxMwE7Ca/XDJ4v8mo6lz/GR0QQyg5KBS/Ql2JAUlYUGJISpa4ZLOGLNsI+9LInxiFE
         cqMg==
X-Gm-Message-State: AAQBX9dcBzsY2dvrkZs/WnGIWeTuQBNLleCMbl4h5I7mtOrwl9QkU/A3
        aIPkZmpYQe7hVObvJ9Sfs2M=
X-Google-Smtp-Source: AKy350aI5b+Vouqbd2JhoWO5no6Enucp4x9G6bHKfg7+W7SqC6FVvDfQ459BO1vliDiL+k+zDmb6+Q==
X-Received: by 2002:a17:90a:d157:b0:246:8193:1fdc with SMTP id t23-20020a17090ad15700b0024681931fdcmr3594261pjw.3.1681426634968;
        Thu, 13 Apr 2023 15:57:14 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:5f5b])
        by smtp.gmail.com with ESMTPSA id jl4-20020a170903134400b001a52abb3be3sm1947635plb.201.2023.04.13.15.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 15:57:14 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:57:11 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 bpf-next 7/9] bpf: Migrate bpf_rbtree_remove to
 possibly fail
Message-ID: <20230413225711.73jcnxgsbnujxaxw@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
 <20230410190753.2012798-8-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410190753.2012798-8-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 10, 2023 at 12:07:51PM -0700, Dave Marchevsky wrote:
> This patch modifies bpf_rbtree_remove to account for possible failure
> due to the input rb_node already not being in any collection.
> The function can now return NULL, and does when the aforementioned
> scenario occurs. As before, on successful removal an owning reference to
> the removed node is returned.
> 
> Adding KF_RET_NULL to bpf_rbtree_remove's kfunc flags - now KF_RET_NULL |
> KF_ACQUIRE - provides the desired verifier semantics:
> 
>   * retval must be checked for NULL before use
>   * if NULL, retval's ref_obj_id is released
>   * retval is a "maybe acquired" owning ref, not a non-owning ref,
>     so it will live past end of critical section (bpf_spin_unlock), and
>     thus can be checked for NULL after the end of the CS
> 
> BPF programs must add checks
> ============================
> 
> This does change bpf_rbtree_remove's verifier behavior. BPF program
> writers will need to add NULL checks to their programs, but the
> resulting UX looks natural:
> 
>   bpf_spin_lock(&glock);
> 
>   n = bpf_rbtree_first(&ghead);
>   if (!n) { /* ... */}
>   res = bpf_rbtree_remove(&ghead, &n->node);
> 
>   bpf_spin_unlock(&glock);
> 
>   if (!res)  /* Newly-added check after this patch */
>     return 1;
> 
>   n = container_of(res, /* ... */);
>   /* Do something else with n */
>   bpf_obj_drop(n);
>   return 0;
> 
> The "if (!res)" check above is the only addition necessary for the above
> program to pass verification after this patch.
> 
> bpf_rbtree_remove no longer clobbers non-owning refs
> ====================================================
> 
> An issue arises when bpf_rbtree_remove fails, though. Consider this
> example:
> 
>   struct node_data {
>     long key;
>     struct bpf_list_node l;
>     struct bpf_rb_node r;
>     struct bpf_refcount ref;
>   };
> 
>   long failed_sum;
> 
>   void bpf_prog()
>   {
>     struct node_data *n = bpf_obj_new(/* ... */);
>     struct bpf_rb_node *res;
>     n->key = 10;
> 
>     bpf_spin_lock(&glock);
> 
>     bpf_list_push_back(&some_list, &n->l); /* n is now a non-owning ref */
>     res = bpf_rbtree_remove(&some_tree, &n->r, /* ... */);
>     if (!res)
>       failed_sum += n->key;  /* not possible */
> 
>     bpf_spin_unlock(&glock);
>     /* if (res) { do something useful and drop } ... */
>   }
> 
> The bpf_rbtree_remove in this example will always fail. Similarly to
> bpf_spin_unlock, bpf_rbtree_remove is a non-owning reference
> invalidation point. The verifier clobbers all non-owning refs after a
> bpf_rbtree_remove call, so the "failed_sum += n->key" line will fail
> verification, and in fact there's no good way to get information about
> the node which failed to add after the invalidation. This patch removes
> non-owning reference invalidation from bpf_rbtree_remove to allow the
> above usecase to pass verification. The logic for why this is now
> possible is as follows:
> 
> Before this series, bpf_rbtree_add couldn't fail and thus assumed that
> its input, a non-owning reference, was in the tree. But it's easy to
> construct an example where two non-owning references pointing to the same
> underlying memory are acquired and passed to rbtree_remove one after
> another (see rbtree_api_release_aliasing in
> selftests/bpf/progs/rbtree_fail.c).
> 
> So it was necessary to clobber non-owning refs to prevent this
> case and, more generally, to enforce "non-owning ref is definitely
> in some collection" invariant. This series removes that invariant and
> the failure / runtime checking added in this patch provide a clean way
> to deal with the aliasing issue - just fail to remove.
> 
> The issues prevented by clobbering non-owning refs on rbtree_remove are
> no longer issues, so it's safe to remove the invalidate_non_owning_refs
> call.

I've read the above sentence as
"it's safe to remove invalidate_non_owning_refs() function"
and went ahead to read the patch to find out that it's invocation is removed
for rbtree_remove case.
Which I expected to see after reading the previous paragraphs.
If you can think of a way to rephrase the above paragraph it would be nice,
but not a big deal.

> No BPF program changes are necessary for programs to remain valid as a
> result of this clobbering change. A valid program before this patch
> passed verification with its non-owning refs having shorter (or equal)
> lifetimes due to more aggressive clobbering.
> 
> Also, update existing tests to check bpf_rbtree_remove retval for NULL
> where necessary, and move rbtree_api_release_aliasing from
> progs/rbtree_fail.c to progs/rbtree.c since it's now expected to pass
> verification.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  kernel/bpf/btf.c                              | 21 +----
>  kernel/bpf/helpers.c                          |  8 +-
>  kernel/bpf/verifier.c                         |  3 -
>  .../selftests/bpf/prog_tests/linked_list.c    |  2 +-
>  .../testing/selftests/bpf/prog_tests/rbtree.c | 25 ++++++
>  tools/testing/selftests/bpf/progs/rbtree.c    | 74 +++++++++++++++++-
>  .../testing/selftests/bpf/progs/rbtree_fail.c | 77 +++++++------------
>  7 files changed, 134 insertions(+), 76 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9fb29b41247c..8b700ad3666d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3805,25 +3805,8 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>  		goto end;
>  	}
>  
> -	/* need collection identity for non-owning refs before allowing this
> -	 *
> -	 * Consider a node type w/ both list and rb_node fields:
> -	 *   struct node {
> -	 *     struct bpf_list_node l;
> -	 *     struct bpf_rb_node r;
> -	 *   }
> -	 *
> -	 * Used like so:
> -	 *   struct node *n = bpf_obj_new(....);
> -	 *   bpf_list_push_front(&list_head, &n->l);
> -	 *   bpf_rbtree_remove(&rb_root, &n->r);
> -	 *
> -	 * It should not be possible to rbtree_remove the node since it hasn't
> -	 * been added to a tree. But push_front converts n to a non-owning
> -	 * reference, and rbtree_remove accepts the non-owning reference to
> -	 * a type w/ bpf_rb_node field.
> -	 */
> -	if (btf_record_has_field(rec, BPF_LIST_NODE) &&
> +	if (rec->refcount_off == -1 &&

That will never trigger, since it was inited to -EINVAL.
It should be refcount_off < 0.

> +	    btf_record_has_field(rec, BPF_LIST_NODE) &&
>  	    btf_record_has_field(rec, BPF_RB_NODE)) {
>  		ret = -EINVAL;
>  		goto end;
