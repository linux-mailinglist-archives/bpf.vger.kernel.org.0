Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F112D507B0C
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 22:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348103AbiDSUiX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 16:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbiDSUiV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 16:38:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A336040910
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 13:35:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so3078286pjb.1
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 13:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I/WqZWUOfy4bqLhAgLQsgwQDgkEIwAM+80IWuGlziEY=;
        b=P0rBt8xwU0i6NtUrEfr5q/YL0pzATy1Z0f215RyomG80ZeNBWzI+vEZoPMf69gJ1UU
         pnWLWUtdqS0bgx4rvGrhtqIX1p0VTcHR7S1pFQKE2PCfa0165ZKy2U4v57HL3QIBmIW0
         /IQjRsMQ8E42MnhjohhcQ02c4Qzd4WwNUjr6JmR0iioifRWvGZYVqkXYUCvhoJgR3Rmh
         KfMQJpmpEEJk351A4k7Y9B1rmqzseipKILlhubmHmiG4PFVDbR9C4Z4Xrnp4blsY2vy9
         c4t2h6kqdLP86lwzNxMZRCOTJ94zIBP4a2eISgu1PWpJAFRDRzEiBnQRPLt/X8sx+sxc
         LQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I/WqZWUOfy4bqLhAgLQsgwQDgkEIwAM+80IWuGlziEY=;
        b=3BP7SJm20V02wMrZM3rudu2OiYIlP+SLHoqfdzIWsXxmAccBvo0q14/ptllK5ncc2l
         DvHhUY0a6XDzN6zeM+kagXZZaH2vF7Qw9zy40RvYYUUrYfc3F0e0ofV4ZT3McgCOoVhE
         3vOHUTCfaI+/h5MqFrK+EqQM+ujB77ioeSNm775hVZdSb5DlH8tBSiZpLYcOjFjRE+oW
         3wQJc3vav2YT21KcRTJ5yuzAod18LTQMz9uNGhzL3EM/YDcip2vShCoM5PCcJtRsGGSw
         7yusinlHTlsS+g3ppy5SG0326nRBMlEHi8mjMFNpNekcgebdzb8dqlxz1tTxsX595qGJ
         gIJQ==
X-Gm-Message-State: AOAM531KYrESJbpkSA9r6jDk5P2DrrcfzN84C3FdqkW4pcBh9quXPlp5
        yB+JwKp5WABbKZhaVAj7uXs=
X-Google-Smtp-Source: ABdhPJyZ7zmeh3oQylOkbXpc+ATfMQZgZVAiPRWHv8+aeHzvZ/1Dr2ABkO+VtIPja8hfXg2bc8GYWg==
X-Received: by 2002:a17:90a:bf85:b0:1ca:8a8e:bec3 with SMTP id d5-20020a17090abf8500b001ca8a8ebec3mr399881pjs.127.1650400537118;
        Tue, 19 Apr 2022 13:35:37 -0700 (PDT)
Received: from localhost ([112.79.167.15])
        by smtp.gmail.com with ESMTPSA id z70-20020a633349000000b003aa663f95ffsm4574pgz.25.2022.04.19.13.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:35:36 -0700 (PDT)
Date:   Wed, 20 Apr 2022 02:05:45 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_dynptr_alloc, bpf_dynptr_put
Message-ID: <20220419203545.zqfc5p3arl5qjttn@apollo.legion>
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-4-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416063429.3314021-4-joannelkoong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 16, 2022 at 12:04:25PM IST, Joanne Koong wrote:
> This patch adds 3 new APIs and the bulk of the verifier work for
> supporting dynamic pointers in bpf.
>
> There are different types of dynptrs. This patch starts with the most
> basic ones, ones that reference a program's local memory
> (eg a stack variable) and ones that reference memory that is dynamically
> allocated on behalf of the program. If the memory is dynamically
> allocated by the program, the program *must* free it before the program
> exits. This is enforced by the verifier.
>
> The added APIs are:
>
> long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_dynptr *ptr);
> long bpf_dynptr_alloc(u32 size, u64 flags, struct bpf_dynptr *ptr);
> void bpf_dynptr_put(struct bpf_dynptr *ptr);
>
> This patch sets up the verifier to support dynptrs. Dynptrs will always
> reside on the program's stack frame. As such, their state is tracked
> in their corresponding stack slot, which includes the type of dynptr
> (DYNPTR_LOCAL vs. DYNPTR_MALLOC).
>
> When the program passes in an uninitialized dynptr (ARG_PTR_TO_DYNPTR |
> MEM_UNINIT), the stack slots corresponding to the frame pointer
> where the dynptr resides at are marked as STACK_DYNPTR. For helper functions
> that take in initialized dynptrs (such as the next patch in this series
> which supports dynptr reads/writes), the verifier enforces that the
> dynptr has been initialized by checking that their corresponding stack
> slots have been marked as STACK_DYNPTR. Dynptr release functions
> (eg bpf_dynptr_put) will clear the stack slots. The verifier enforces at
> program exit that there are no acquired dynptr stack slots that need
> to be released.
>
> There are other constraints that are enforced by the verifier as
> well, such as that the dynptr cannot be written to directly by the bpf
> program or by non-dynptr helper functions. The last patch in this series
> contains tests that trigger different cases that the verifier needs to
> successfully reject.
>
> For now, local dynptrs cannot point to referenced memory since the
> memory can be freed anytime. Support for this will be added as part
> of a separate patchset.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h            |  68 +++++-
>  include/linux/bpf_verifier.h   |  28 +++
>  include/uapi/linux/bpf.h       |  44 ++++
>  kernel/bpf/helpers.c           | 110 ++++++++++
>  kernel/bpf/verifier.c          | 372 +++++++++++++++++++++++++++++++--
>  scripts/bpf_doc.py             |   2 +
>  tools/include/uapi/linux/bpf.h |  44 ++++
>  7 files changed, 654 insertions(+), 14 deletions(-)
>
> [...]
> +/* Called at BPF_EXIT to detect if there are any reference-tracked dynptrs that have
> + * not been released. Dynptrs to local memory do not need to be released.
> + */
> +static int check_dynptr_unreleased(struct bpf_verifier_env *env)
> +{
> +	struct bpf_func_state *state = cur_func(env);
> +	int allocated_slots, i;
> +
> +	allocated_slots = state->allocated_stack / BPF_REG_SIZE;
> +
> +	for (i = 0; i < allocated_slots; i++) {
> +		if (state->stack[i].slot_type[0] == STACK_DYNPTR) {
> +			if (dynptr_type_refcounted(state->stack[i].spilled_ptr.dynptr.type)) {
> +				verbose(env, "spi=%d is an unreleased dynptr\n", i);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

We need to call this function in check_ld_abs as well.

> [...]

--
Kartikeya
