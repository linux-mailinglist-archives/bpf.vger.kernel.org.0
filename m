Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CA265458B
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLVRTL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 12:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLVRTJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 12:19:09 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EDF2B269
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 09:19:08 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z16-20020a056a001d9000b0057d4ebe9513so1356593pfw.22
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 09:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4P1A8IAdM/xSEcFoYOHP7+4yEj12+FEHj47Dkqw18A=;
        b=mQ3kon+LFmRg5809RHC0/nZGG3cenFq5FzucxswlacFUYGsfx6qfwYT/V9FwDPAQpF
         v3QYvK1FDXQuIEyjLqOxUHKBXuw7v/1Yx+DJvM9ijmYKFI5EJ38+JTCPWvBy0lijQL4m
         /UAP8VebGe2hG0D5UQqfnyX0zGc8so7AIH686qPaN4gk/lZYuo6KLMctYvKmjw4zIk2F
         YMx7/opjZBev84Kz5fxjeo8UhL9zlimXFIGiINMwXox4P88Oc3cnIXTZTjw50nNaA/17
         g5fXufCuahtdzj60hG36/XQKASDvXVFZP/nj+k5r+bH4J/RnEE+3f2msiUsqf6Q86fua
         //kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4P1A8IAdM/xSEcFoYOHP7+4yEj12+FEHj47Dkqw18A=;
        b=rrlCCOYT6SG29WSLQwaWcQWm/MFA9XKlPLvJCC48Ww1CmiWndwHbxzyOewCqo+fQkE
         svzjvpnK91zzkE8zoHD67NA0ZQKPBRBZvWioOBeV0kvp/bwrFMdUKv8AqbeOKnY0DPAy
         SromszL8AbfHX3v61RI0zKB39Her95HUDmef9/5XCi4DgLWX6assU1JREttC46vMKK/F
         tC863ttFlEf4L947N94QKuEu7+TwQ+i4ZU5KJKztGhp/DF2CE46OdBw3P3gKQv0v/5hK
         V0sbx2jNaJE/+qgnszA5kps4WXuN4Nvoyi/I97HlPesz6LI2T99ZtOKSKHMh+imkp2yM
         E6Cw==
X-Gm-Message-State: AFqh2krb5vcWZYc7Q9iTK1SlWGi39saGZRHZ6nxR5FoZv1w/v1yfBaaN
        RtOTO91EyQ0UEY6yGalaKFNr/dA=
X-Google-Smtp-Source: AMrXdXu8HZZVypFbjYqi3wo3Gmth+jgl6lvCxXE5SVqSuyjX+p2HmuzizxvpXx5efPcSBpIbSPy2HlA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:e48a:b0:186:c3b2:56d1 with SMTP id
 i10-20020a170902e48a00b00186c3b256d1mr374559ple.15.1671729547483; Thu, 22 Dec
 2022 09:19:07 -0800 (PST)
Date:   Thu, 22 Dec 2022 09:19:06 -0800
In-Reply-To: <20221222001343.489117-1-paul@paul-moore.com>
Mime-Version: 1.0
References: <20221222001343.489117-1-paul@paul-moore.com>
Message-ID: <Y6SRiv+FloijdETe@google.com>
Subject: Re: [PATCH] bpf: restore the ebpf audit UNLOAD id field
From:   sdf@google.com
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/21, Paul Moore wrote:
> When changing the ebpf program put() routines to support being called
> from within IRQ context the program ID was reset to zero prior to
> generating the audit UNLOAD record, which obviously rendered the ID
> field bogus (always zero).  This patch resolves this by adding a new
> field, bpf_prog_aux::id_audit, which is set when the ebpf program is
> allocated an ID and never reset, ensuring a valid ID field,
> regardless of the state of the original ID field, bpf_prox_aud::id.

> I also modified the bpf_audit_prog() logic used to associate the
> AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> Instead of keying off the operation, it now keys off the execution
> context, e.g. '!in_irg && !irqs_disabled()', which is much more
> appropriate and should help better connect the UNLOAD operations with
> the associated audit state (other audit records).

[..]

> As an note to future bug hunters, I did briefly consider removing the
> ID reset in bpf_prog_free_id(), as it would seem that once the
> program is removed from the idr pool it can no longer be found by its
> ID value, but commit ad8ad79f4f60 ("bpf: offload: free program id
> when device disappears") seems to imply that it is beneficial to
> reset the ID value.  Perhaps as a secondary indicator that the ebpf
> program is unbound/orphaned.

That seems like the way to go imho. Can we have some extra 'invalid_id'
bitfield in the bpf_prog so we can set it in bpf_prog_free_id and
check in bpf_prog_free_id (for this offloaded use-case)? Because
having two ids and then keeping track about which one to use, depending
on the context, seems more fragile?

> Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq  
> context.")
> Reported-by: Burn Alting <burn.alting@iinet.net.au>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>   include/linux/bpf.h  | 1 +
>   kernel/bpf/syscall.c | 8 +++++---
>   2 files changed, 6 insertions(+), 3 deletions(-)

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9e7d46d16032..a22001ceb2c3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1103,6 +1103,7 @@ struct bpf_prog_aux {
>   	u32 max_tp_access;
>   	u32 stack_depth;
>   	u32 id;
> +	u32 id_audit; /* preserves the id for use by audit */
>   	u32 func_cnt; /* used by non-func prog as the number of func progs */
>   	u32 func_idx; /* 0 for non-func prog, the index in func array for func  
> prog */
>   	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7b373a5e861f..3ec09f4dba18 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1958,13 +1958,13 @@ static void bpf_audit_prog(const struct bpf_prog  
> *prog, unsigned int op)
>   		return;
>   	if (audit_enabled == AUDIT_OFF)
>   		return;
> -	if (op == BPF_AUDIT_LOAD)
> +	if (!in_irq() && !irqs_disabled())
>   		ctx = audit_context();
>   	ab = audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
>   	if (unlikely(!ab))
>   		return;
>   	audit_log_format(ab, "prog-id=%u op=%s",
> -			 prog->aux->id, bpf_audit_str[op]);
> +			 prog->aux->id_audit, bpf_audit_str[op]);
>   	audit_log_end(ab);
>   }

> @@ -1975,8 +1975,10 @@ static int bpf_prog_alloc_id(struct bpf_prog *prog)
>   	idr_preload(GFP_KERNEL);
>   	spin_lock_bh(&prog_idr_lock);
>   	id = idr_alloc_cyclic(&prog_idr, prog, 1, INT_MAX, GFP_ATOMIC);
> -	if (id > 0)
> +	if (id > 0) {
>   		prog->aux->id = id;
> +		prog->aux->id_audit = id;
> +	}
>   	spin_unlock_bh(&prog_idr_lock);
>   	idr_preload_end();

> --
> 2.39.0

