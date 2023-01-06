Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B3660754
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 20:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjAFTp5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 14:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjAFTpn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 14:45:43 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DAA81C12
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 11:45:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso2795201pjo.3
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 11:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UL/gZX7lFLKx3GMDq4Xe8lHpVhl3DvS0+DdhugdlYL0=;
        b=idiuu+c592aJh6IVrfrcGszOnB5gXR/W7Zp36xSZX4nIR9y9L9AVlN57mOlrbeuMm8
         hpVghubKTeWmww9Et762Fe/CDrkjD0fDpBzBtJZw/Tb50eU7wNxtejw7ZRVDGUFfpNa8
         wANhDTmKkoX8KJ971OKFPqx1ua6oZkrPO4SaItPKqpdXPM+Wv3dpalunbNIOdc2rdDJD
         Jhq2btOlHQnWeVPKQito4+rguf3hPuxp3Fdh11FskkqK69C+aPz2DCqhUJxivwPOq7dc
         oENBXLdEngkipp9Y6+xGkY00sK6Mybf02mgoAQZEVUeIXdLsuybbwhbDDeut7+bFJ1Kk
         LG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UL/gZX7lFLKx3GMDq4Xe8lHpVhl3DvS0+DdhugdlYL0=;
        b=3+5ne+RSs8YA2USKzr1zNuJnXQcxZJhsFbipOgUYwrrlcQvkRPs29Hi+T3Xo943R3m
         e+kf/oTHwSHZZx5oJcynyZSs7/FFB4XSxEhyFiogF9SK42Lfj1XydCyJwMejcnvqCVVa
         O3HCNexupTX3f2MCUv73BZeZeT6ZZngXWMxM2PVqMossRXbp8KrW8RcOuxhfuxlvBwQq
         hO6O8vbkdTnS0GyuXXxYUvAHs3ji9z+vA7+P4DSLntpFThiHRRIrEJTWfCWOaDyaCnSF
         mN0Rt8wSa08FNR/cLBzZ2xVw5F72j8WmBGk0IuciOT6pZuNpNAWmiSOPT92JHwRfDmM0
         AsKw==
X-Gm-Message-State: AFqh2kqcy+ZWY4gIDpCjxFQetwtrdAdwSlEijs16DnB2m9VLSFRaSnti
        Wm9bxgTkQeWXXYg1APjOKiZtZZhYinfc+dQPHKBGrg14Hid6XQ==
X-Google-Smtp-Source: AMrXdXvZk+D/eAuuOVKWJEp0kfGRFlSmVOvJLa6TDu0N3/23vRIYKC/RldJpNY8oeOe+faA6+hpwKQGOoRDD72RDw7g=
X-Received: by 2002:a17:902:a506:b0:189:97e2:ab8b with SMTP id
 s6-20020a170902a50600b0018997e2ab8bmr5657246plq.131.1673034341447; Fri, 06
 Jan 2023 11:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20230106154400.74211-1-paul@paul-moore.com> <20230106154400.74211-2-paul@paul-moore.com>
In-Reply-To: <20230106154400.74211-2-paul@paul-moore.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 6 Jan 2023 11:45:30 -0800
Message-ID: <CAKH8qBtr3A+EH2J6DCaVbgoGMetKbLUOQ8ZF=cJSFd8ym-0vxw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] bpf: remove the do_idr_lock parameter from bpf_prog_free_id()
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
> It was determined that the do_idr_lock parameter to
> bpf_prog_free_id() was not necessary as it should always be true.
>
> Suggested-by: Stanislav Fomichev <sdf@google.com>

nit: I believe it's been suggested several times by different people

Acked-by: Stanislav Fomichev <sdf@google.com>


> Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> ---
> * v3
> - initial draft
> ---
>  include/linux/bpf.h  |  2 +-
>  kernel/bpf/syscall.c | 20 ++++++--------------
>  2 files changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3de24cfb7a3d..634d37a599fa 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1832,7 +1832,7 @@ void bpf_prog_inc(struct bpf_prog *prog);
>  struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
>  void bpf_prog_put(struct bpf_prog *prog);
>
> -void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock);
> +void bpf_prog_free_id(struct bpf_prog *prog);
>  void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);
>
>  struct btf_field *btf_record_find(const struct btf_record *rec,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 61bb19e81b9c..ecca9366c7a6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2001,7 +2001,7 @@ static int bpf_prog_alloc_id(struct bpf_prog *prog)
>         return id > 0 ? 0 : id;
>  }
>
> -void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock)
> +void bpf_prog_free_id(struct bpf_prog *prog)
>  {
>         unsigned long flags;
>
> @@ -2013,18 +2013,10 @@ void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock)
>         if (!prog->aux->id)
>                 return;
>
> -       if (do_idr_lock)
> -               spin_lock_irqsave(&prog_idr_lock, flags);
> -       else
> -               __acquire(&prog_idr_lock);
> -
> +       spin_lock_irqsave(&prog_idr_lock, flags);
>         idr_remove(&prog_idr, prog->aux->id);
>         prog->aux->id = 0;
> -
> -       if (do_idr_lock)
> -               spin_unlock_irqrestore(&prog_idr_lock, flags);
> -       else
> -               __release(&prog_idr_lock);
> +       spin_unlock_irqrestore(&prog_idr_lock, flags);
>  }
>
>  static void __bpf_prog_put_rcu(struct rcu_head *rcu)
> @@ -2067,11 +2059,11 @@ static void bpf_prog_put_deferred(struct work_struct *work)
>         prog = aux->prog;
>         perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_UNLOAD, 0);
>         bpf_audit_prog(prog, BPF_AUDIT_UNLOAD);
> -       bpf_prog_free_id(prog, true);
> +       bpf_prog_free_id(prog);
>         __bpf_prog_put_noref(prog, true);
>  }
>
> -static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
> +static void __bpf_prog_put(struct bpf_prog *prog)
>  {
>         struct bpf_prog_aux *aux = prog->aux;
>
> @@ -2087,7 +2079,7 @@ static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
>
>  void bpf_prog_put(struct bpf_prog *prog)
>  {
> -       __bpf_prog_put(prog, true);
> +       __bpf_prog_put(prog);
>  }
>  EXPORT_SYMBOL_GPL(bpf_prog_put);
>
> --
> 2.39.0
>
