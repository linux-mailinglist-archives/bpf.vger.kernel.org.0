Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0917660752
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 20:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjAFTph (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 14:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjAFTpX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 14:45:23 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFE07A3B7
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 11:45:22 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 7so1843697pga.1
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 11:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvZXlAdRBFAHyGz96jB9ItzH1/RXpSiQ90ZYvIcBjik=;
        b=HJPV+ijzoiKlKYgQmKPByc9bSoOoRKqrJ7LEql2I7BJ6gbqkPp8/u44r+nhVJmFd+N
         hJNCwAIjZNJKGd2CFUeQ0+ydsaOmvJcB3rKwiPshkiq1uDeTK1Sn8/gHMjJRO1mjXnHl
         3U3NWRydliBq7AZ1YbG/dT//t4A86pae88qJSCruX1DRNsWSibMQI7hwaZAm2hM7xiGV
         j7E2AtkQX3fisiO37t+Gx8lY0vpMg59JAqI18h6xJV2Gg+flpS/XnsA2QWV/w375OYWK
         5GYriCedflN+YLuyWKs0nXBVDfxnhYl8rjaK1PEFDmVGvQ6is0cG3zSsWmlxuuHaQ8kV
         zglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvZXlAdRBFAHyGz96jB9ItzH1/RXpSiQ90ZYvIcBjik=;
        b=hpjYoCGWqgOx7wFfRstVRRuNvA/pfVKPX2x/+ftRylF+LAvf0QNcD3vOZq3WFJw69M
         FSZEFGt0ojLN5tEXszA1qgzGfB5UHbSt2OQqa2DRSp13M+lmmdsDDtr7QOGYenIyZdFb
         HcITMOsQXKHdq3oTKoIbkRlw+IyDOR/lAMkJfq6K5wQ0tgutD3yyJjDeXJ6afBbhUerM
         ZWUt5mlU9w1Sr0kJrDDIOAU5Hn2j//Z4RQoGXJny7Wa3wCtBAD8QrVnXJ/oikAEeYTqb
         QynBCvY49EdffUispERtJwuHKAzjZC1/Y8xpfvCKSv84ZMVY6SQbzyXnsn3Dm3WWEEW1
         rEFw==
X-Gm-Message-State: AFqh2kqOrtieS6Lr0djU30rGPhyNpt+Bs12rkYofTH/0EkLqsaW7+3c1
        qNG+qRl2AAau0zeYfCM3IWREwKJhT+ndkaPaLlYz1w==
X-Google-Smtp-Source: AMrXdXtPSADREsfUCJ3xXPZnlv7Q8cwXmq4nNdSMZUShJmr2W8sgfT+Xk+QXpXccd4BSpoRguJb2C1+aNDX/kF6UJpk=
X-Received: by 2002:a62:3004:0:b0:573:6cfc:2210 with SMTP id
 w4-20020a623004000000b005736cfc2210mr4105117pfw.55.1673034321778; Fri, 06 Jan
 2023 11:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20230106154400.74211-1-paul@paul-moore.com>
In-Reply-To: <20230106154400.74211-1-paul@paul-moore.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 6 Jan 2023 11:45:09 -0800
Message-ID: <CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: restore the ebpf program ID for
 BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Burn Alting <burn.alting@iinet.net.au>,
        Alexei Starovoitov <ast@kernel.org>
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

On Fri, Jan 6, 2023 at 7:44 AM Paul Moore <paul@paul-moore.com> wrote:
>
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

Acked-by: Stanislav Fomichev <sdf@google.com>

Thank you! There might be a chance it breaks test_offload.py (I don't
remember whether it checks this prog-is-removed-from-id part or not),
but I don't think it's fair to ask to address it :-)
Since it doesn't trigger in CI, I'll take another look next week when
doing a respin of my 'xdp-hints' series.


> ---
> * v3
> - abandon most of the changes in v2
> - move bpf_prog_free_id() after the audit/perf unload hooks
> - remove bpf_prog_free_id() from __bpf_prog_offload_destroy()
> - added stable tag
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
>         if (offload->dev_state)
>                 offload->offdev->ops->destroy(prog);
>
> -       /* Make sure BPF_PROG_GET_NEXT_ID can't find this dead program */
> -       bpf_prog_free_id(prog, true);
> -
>         list_del_init(&offload->offloads);
>         kfree(offload);
>         prog->aux->offload = NULL;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 64131f88c553..61bb19e81b9c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1972,7 +1972,7 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
>                 return;
>         if (audit_enabled == AUDIT_OFF)
>                 return;
> -       if (op == BPF_AUDIT_LOAD)
> +       if (!in_irq() && !irqs_disabled())
>                 ctx = audit_context();
>         ab = audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
>         if (unlikely(!ab))
> @@ -2067,6 +2067,7 @@ static void bpf_prog_put_deferred(struct work_struct *work)
>         prog = aux->prog;
>         perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_UNLOAD, 0);
>         bpf_audit_prog(prog, BPF_AUDIT_UNLOAD);
> +       bpf_prog_free_id(prog, true);
>         __bpf_prog_put_noref(prog, true);
>  }
>
> @@ -2075,9 +2076,6 @@ static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
>         struct bpf_prog_aux *aux = prog->aux;
>
>         if (atomic64_dec_and_test(&aux->refcnt)) {
> -               /* bpf_prog_free_id() must be called first */
> -               bpf_prog_free_id(prog, do_idr_lock);
> -
>                 if (in_irq() || irqs_disabled()) {
>                         INIT_WORK(&aux->work, bpf_prog_put_deferred);
>                         schedule_work(&aux->work);
> --
> 2.39.0
>
