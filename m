Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880AC663C5C
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 10:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjAJJKz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 04:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAJJK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 04:10:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37B7564EC
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 01:10:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w1so10997270wrt.8
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 01:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swwl8Slc0bB5LKo8Orryz2UbttInvRzy6nPaGPvgpbc=;
        b=i5j3LLhzLSQpZ6GNguOrAgzvly/LJOhLIVEQtKHKYsQm5HZslBK1iiYTY4aFgMl/YO
         PIdpjb3+OmgL5eKDWep3ErPFZO5PODAK+4L1Z7MflSXXFaOe+FfcyOfaqpylzZY61E1C
         pgtxPwS588R8Wg6dGGL+ZLiBFcd4J57uQW0+K18nq5+ALc1TLbnwp5LmaXgUouhdXblH
         arLx/0oY50CtwIInY9PNUMLG6Ux4NRoYMdL9UEgQeZOCM01sCxlg3ObssN7XhrulOb0/
         NHFK8ayqPvalo6Hzo66Divy92TT7D2ZLHfld5u/ggjKOlN7tC+XwZN3V7cR4/pDF2Bcp
         U+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swwl8Slc0bB5LKo8Orryz2UbttInvRzy6nPaGPvgpbc=;
        b=CrKOq0MRFcM5faPtGGfwdm/bpV15A82Hi2k6AUQMaLkgeti2ys9Xb2LkEL64EEykH2
         TG7t1GT4SoasaqzV8hTFmAIPNLqNudn3pnp3JPUVIcYbGKkrxIgTyUviuKFag3wOtbEA
         LDgnmkU/xj5IHCcROXWSkvvg7brgvKOWju11Ut+vnJafH0OHDa984H9ZBHWnW/xOG0Sq
         PrH2TGG1kAzUl0PGd9cSnjuIPd78TeGa2GfWovTKT2aF6EDQESN0Hxmfxpf90lZiXbCw
         N4V71b8uwlLIGnqS+eKXwxPbZbgh6Z1naQ9cXFswAa+mB38/KRx9GFsnZBLrlTwbAc3u
         iKyA==
X-Gm-Message-State: AFqh2krVIgxPaKhvmJnmk9mbw8o/sdo3d5C15BhWG0fk7AjSaQB60mhi
        97CPgLsJaNWtkQlgoBwP/+8=
X-Google-Smtp-Source: AMrXdXtrat1GdpWAr9X2ER6GGmC82sAMEWC7dSvO/4so47QyZ+5vUS0efS4jBHozdJxcJUH87ySeRg==
X-Received: by 2002:a05:6000:706:b0:2a2:e960:de33 with SMTP id bs6-20020a056000070600b002a2e960de33mr15261831wrb.45.1673341809054;
        Tue, 10 Jan 2023 01:10:09 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b00286ad197346sm10707430wrq.70.2023.01.10.01.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:10:08 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 10 Jan 2023 10:10:06 +0100
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Burn Alting <burn.alting@iinet.net.au>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 1/2] bpf: restore the ebpf program ID for
 BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD
Message-ID: <Y70rbnusftLg1ymg@krava>
References: <20230106154400.74211-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106154400.74211-1-paul@paul-moore.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 06, 2023 at 10:43:59AM -0500, Paul Moore wrote:
> When changing the ebpf program put() routines to support being called
> from within IRQ context the program ID was reset to zero prior to
> calling the perf event and audit UNLOAD record generators, which
> resulted in problems as the ebpf program ID was bogus (always zero).
> This patch addresses this problem by removing an unnecessary call to
> bpf_prog_free_id() in __bpf_prog_offload_destroy() and adjusting
> __bpf_prog_put() to only call bpf_prog_free_id() after audit and perf
> have finished their bpf program unload tasks in
> bpf_prog_put_deferred().  For the record, no one can determine, or
> remember, why it was necessary to free the program ID, and remove it
> from the IDR, prior to executing bpf_prog_put_deferred();
> regardless, both Stanislav and Alexei agree that the approach in this
> patch should be safe.
> 
> It is worth noting that when moving the bpf_prog_free_id() call, the
> do_idr_lock parameter was forced to true as the ebpf devs determined
> this was the correct as the do_idr_lock should always be true.  The
> do_idr_lock parameter will be removed in a follow-up patch, but it
> was kept here to keep the patch small in an effort to ease any stable
> backports.
> 
> I also modified the bpf_audit_prog() logic used to associate the
> AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> Instead of keying off the operation, it now keys off the execution
> context, e.g. '!in_irg && !irqs_disabled()', which is much more
> appropriate and should help better connect the UNLOAD operations with
> the associated audit state (other audit records).
> 
> Cc: stable@vger.kernel.org
> Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
> Reported-by: Burn Alting <burn.alting@iinet.net.au>
> Reported-by: Jiri Olsa <olsajiri@gmail.com>
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> 
> ---
> * v3
> - abandon most of the changes in v2
> - move bpf_prog_free_id() after the audit/perf unload hooks
> - remove bpf_prog_free_id() from __bpf_prog_offload_destroy()
> - added stable tag

fwiw I checked and the perf UNLOAD events have proper id now
thanks for fixing this

jirka


> * v2
> - change subj
> - add mention of the perf regression
> - drop the dedicated program audit ID
> - add the bpf_prog::valid_id flag, bpf_prog_get_id() getter
> - convert prog ID users to new ID getter
> * v1
> - subj was: "bpf: restore the ebpf audit UNLOAD id field"
> - initial draft
> ---
>  kernel/bpf/offload.c | 3 ---
>  kernel/bpf/syscall.c | 6 ++----
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 13e4efc971e6..190d9f9dc987 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -216,9 +216,6 @@ static void __bpf_prog_offload_destroy(struct bpf_prog *prog)
>  	if (offload->dev_state)
>  		offload->offdev->ops->destroy(prog);
>  
> -	/* Make sure BPF_PROG_GET_NEXT_ID can't find this dead program */
> -	bpf_prog_free_id(prog, true);
> -
>  	list_del_init(&offload->offloads);
>  	kfree(offload);
>  	prog->aux->offload = NULL;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 64131f88c553..61bb19e81b9c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1972,7 +1972,7 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
>  		return;
>  	if (audit_enabled == AUDIT_OFF)
>  		return;
> -	if (op == BPF_AUDIT_LOAD)
> +	if (!in_irq() && !irqs_disabled())
>  		ctx = audit_context();
>  	ab = audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
>  	if (unlikely(!ab))
> @@ -2067,6 +2067,7 @@ static void bpf_prog_put_deferred(struct work_struct *work)
>  	prog = aux->prog;
>  	perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_UNLOAD, 0);
>  	bpf_audit_prog(prog, BPF_AUDIT_UNLOAD);
> +	bpf_prog_free_id(prog, true);
>  	__bpf_prog_put_noref(prog, true);
>  }
>  
> @@ -2075,9 +2076,6 @@ static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
>  	struct bpf_prog_aux *aux = prog->aux;
>  
>  	if (atomic64_dec_and_test(&aux->refcnt)) {
> -		/* bpf_prog_free_id() must be called first */
> -		bpf_prog_free_id(prog, do_idr_lock);
> -
>  		if (in_irq() || irqs_disabled()) {
>  			INIT_WORK(&aux->work, bpf_prog_put_deferred);
>  			schedule_work(&aux->work);
> -- 
> 2.39.0
> 
