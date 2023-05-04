Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87C36F6FFB
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 18:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjEDQhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 12:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjEDQhG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 12:37:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6401BD3
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 09:37:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaed87d8bdso4779305ad.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683218222; x=1685810222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSnUjW8RyfUqHgymsLdjH1Tok2Iyi4aEKW3LPMCqcuE=;
        b=p4i4MM+85+ugUg+mIyGHV5NcTKm0Zr+8btExEGnXcxyRWDvfKxsJzsKRUytNxQ2e/i
         UJNzGMemiK0hSWl/oP3NbpwZtNaaUfG34THnB/9HdZUZ3uS+6n8fUIh3RGuUMyVpt2OM
         eQFPHW47H02jF4yXj6LsMfJA/ZrmCNZIvO5bFAb2ag6kN/yUXlZps67OtX4aZtlzloKC
         dKyiD125M1XDO8GfoZpQNSrh3OgStAh60BoDOBzIKbYvGBTwVVSaLcw8y+lUiLldRJQM
         FXGBX1jgEp/DO+sqjeVAqtJwzlLNRMKzRIyPocqSFZn1dclNxH1u7dQ66fZ1Pw3HPZYt
         ooUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683218222; x=1685810222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSnUjW8RyfUqHgymsLdjH1Tok2Iyi4aEKW3LPMCqcuE=;
        b=KpTk/NQqE5XJo5T7/sGUwaOCe8gWvhRreQsH8EeSc/O9pYCT2HVoJyIVQfboMfVe9s
         mbYDKqQYyYZZdOKzEZ+wk/fW9//rrBorx09nTyYn2t0tFqiGYEus7lBpFHPFNgT4OF9S
         y3SukTr8H0XFbeMHs3f29/abmqwbtwgn+mA7eCW6Muqe06b20d3pwh5UNrcNcIZIDmU5
         WW3nqqOvfCbJf2kt+R0LF+QNVjokKszmZQTtd751mL0eZrzk9FPs7oahSjow4EhQ3qMO
         gs2g5pqG7fnL8lUcLBSEjLivLP/iIQxvx4q2J8pbC7JBgdIinTpw7BhtPO93brP+ckI/
         9O9Q==
X-Gm-Message-State: AC+VfDy7hmM3lDTX5mIdg6vImarhgXH83SsFp5CATuZsu6Tc5VBCE+Hl
        3To9eUyAwjM3pZ5cbh451d4=
X-Google-Smtp-Source: ACHHUZ44NdEZD9O/v4PAW6/zkZWlrYGfuAB/Oi+Ykv2HYJqMZh2830WvwW9HdsTnfYGxJVwZIhe2Ew==
X-Received: by 2002:a17:902:d510:b0:1a6:dd9a:62c5 with SMTP id b16-20020a170902d51000b001a6dd9a62c5mr4608209plg.10.1683218221874;
        Thu, 04 May 2023 09:37:01 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::6:168f])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709028c8300b001ab13f1fa82sm4545586plo.85.2023.05.04.09.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:37:01 -0700 (PDT)
Date:   Thu, 4 May 2023 09:36:59 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 07/10] bpf: fix mark_all_scalars_precise use in
 mark_chain_precision
Message-ID: <20230504163659.cgtfsruavrjlwame@MacBook-Pro-6.local>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-8-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425234911.2113352-8-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 04:49:08PM -0700, Andrii Nakryiko wrote:
> When precision backtracking bails out due to some unsupported sequence
> of instructions (e.g., stack access through register other than r10), we
> need to mark all SCALAR registers as precise to be safe. Currently,
> though, we mark SCALARs precise only starting from the state we detected
> unsupported condition, which could be one of the parent states of the
> actual current state. This will leave some registers potentially not
> marked as precise, even though they should. So make sure we start
> marking scalars as precise from current state (env->cur_state).
> 
> Further, we don't currently detect a situation when we end up with some
> stack slots marked as needing precision, but we ran out of available
> states to find the instructions that populate those stack slots. This is
> akin the `i >= func->allocated_stack / BPF_REG_SIZE` check and should be
> handled similarly by falling back to marking all SCALARs precise. Add
> this check when we run out of states.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c                          | 16 +++++++++++++---
>  tools/testing/selftests/bpf/verifier/precise.c |  9 +++++----
>  2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 66d64ac10fb1..35f34c977819 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3781,7 +3781,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
>  				err = backtrack_insn(env, i, bt);
>  			}
>  			if (err == -ENOTSUPP) {
> -				mark_all_scalars_precise(env, st);
> +				mark_all_scalars_precise(env, env->cur_state);
>  				bt_reset(bt);
>  				return 0;
>  			} else if (err) {
> @@ -3843,7 +3843,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
>  					 * fp-8 and it's "unallocated" stack space.
>  					 * In such case fallback to conservative.
>  					 */
> -					mark_all_scalars_precise(env, st);
> +					mark_all_scalars_precise(env, env->cur_state);
>  					bt_reset(bt);
>  					return 0;
>  				}
> @@ -3872,11 +3872,21 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
>  		}
>  
>  		if (bt_bitcnt(bt) == 0)
> -			break;
> +			return 0;
>  
>  		last_idx = st->last_insn_idx;
>  		first_idx = st->first_insn_idx;
>  	}
> +
> +	/* if we still have requested precise regs or slots, we missed
> +	 * something (e.g., stack access through non-r10 register), so
> +	 * fallback to marking all precise
> +	 */
> +	if (bt_bitcnt(bt) != 0) {
> +		mark_all_scalars_precise(env, env->cur_state);
> +		bt_reset(bt);
> +	}

We get here only after:
  st = st->parent;
  if (!st)
          break;

which is the case when we reach the very beginning of the program (parent == NULL) and
there are still regs or stack with marks.
That's a situation when backtracking encountered something we didn't foresee. Some new
condition. Currently we don't have selftest that trigger this.
So as a defensive mechanism it makes sense to do mark_all_scalars_precise(env, env->cur_state);
Probably needs verbose("verifier backtracking bug") as well.

But for the other two cases mark_all_scalars_precise(env, st); is safe.
What's the reason to mark everything precise from the very beginning of backtracking (last seen state == current state).
Since unsupported condition was in the middle it's safe to mark from that condition till start of prog.
