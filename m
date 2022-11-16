Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B16862B3E6
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 08:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiKPH3k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 02:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiKPH3f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 02:29:35 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4553EB7D7
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 23:29:33 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bj12so41872977ejb.13
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 23:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1Y99RO47dfeR0gK8clWXAfbdWlFMBk6bW7ab+0e2TE=;
        b=BzZ+lZ2wfM+2sUVO6p9glZYjC3zC1wS+H+ZKNXrtSKJHjeSD1zN25j+0sa9wAWYdqY
         4ULu4x5JUfiTuCPCHMcxcmkfCTxghbKbJPw2wM8J78TnXZv6/OICMlOoPEAr9q/8cc4M
         GK+qKbl2yJYc7xubaYBDygItKTgieremOl4QCaSTl4Pt5pi9eLiwZglJOVtIIbZEYsMX
         VSq12S63449p72/9cCJjc+i8fkJU0R2A1EbNH9/Qz2MxoIPy3rtOADUf0P0OSIj43MMX
         NSoVhsvHl0YfcwaeIXjuR6znMIokHg+xy4irWiFyukH66bGCN/mdn4KL2Vq+f7qN897V
         yQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1Y99RO47dfeR0gK8clWXAfbdWlFMBk6bW7ab+0e2TE=;
        b=I8lizbns0df1H1A68vWUEk48mt78DC4va61DPgUMLCroAf8TqkNnRpKTpfLIqktZO2
         Ojum4wQMZw+8hiR6oDvPWIew4R4mtorsDrNRIXwaI0Xv+gm/LivfpeADqxUyd3UIADWK
         an6qA1vFmMTM0ytbfjJDOc2C8AEn2/bqX4KRSgl2/d8v+JLay9FzZscuzManeMsYyBql
         KG2U68Qn8jozEx+b13V3QXbUOWnqR1S2U2YQEBVGy7RTxffNJ+PhT4Xu80RRcNvCygG0
         uvR5Tj1E4YB8xw41gBZJRSHn0UAxkVmBwaILUmqqV2uRQNPu1LC9nddBMZIuAk2jjYKs
         qO+w==
X-Gm-Message-State: ANoB5pklRtvGLU6DN1dxxaEcubFgOTGSX/aTYi2XpbSLm0+ri2PpnCLO
        TpROmoruKmIyBQjGbK/Rp2+asAwjzC6AmQ==
X-Google-Smtp-Source: AA0mqf40DJtmaOuVVURrWcZVEgASg8S/GEnJ8fxBJL+0F0V/8e5siZGoNj+XTWi2VT5yXIptBv+yRw==
X-Received: by 2002:a17:906:e241:b0:7ae:e592:6d83 with SMTP id gq1-20020a170906e24100b007aee5926d83mr11859585ejb.699.1668583771626;
        Tue, 15 Nov 2022 23:29:31 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906309500b007add62dafbasm6455394ejv.157.2022.11.15.23.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 23:29:31 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 16 Nov 2022 08:29:29 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [RFC bpf-next] bpf: Fix perf bpf event and audit prog id logging
Message-ID: <Y3SRWVoycV290S16@krava>
References: <20221115095043.1249776-1-jolsa@kernel.org>
 <4d91b1d3-3ffc-11f9-50a6-bfb503e4b3cd@iogearbox.net>
 <Y3QgJMsknnAvvYqU@krava>
 <CAADnVQLz4BWZM+74mjxeHpr=1-Nx3hnVts-4kxJ-UqtoD54yFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLz4BWZM+74mjxeHpr=1-Nx3hnVts-4kxJ-UqtoD54yFw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 03:34:55PM -0800, Alexei Starovoitov wrote:
> On Tue, Nov 15, 2022 at 3:26 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Nov 15, 2022 at 01:49:54PM +0100, Daniel Borkmann wrote:
> > > On 11/15/22 10:50 AM, Jiri Olsa wrote:
> > > > hi,
> > > > perf_event_bpf_event and bpf_audit_prog calls currently report zero
> > > > program id for unload path.
> > > >
> > > > It's because of the [1] change moved those audit calls into work queue
> > > > and they are executed after the id is zeroed in bpf_prog_free_id.
> > > >
> > > > I originally made a change that added 'id_audit' field to struct
> > > > bpf_prog, which would be initialized as id, untouched and used
> > > > in audit callbacks.
> > > >
> > > > Then I realized we might actually not need to zero prog->aux->id
> > > > in bpf_prog_free_id. It seems to be called just once on release
> > > > paths. Tests seems ok with that.
> > > >
> > > > thoughts?
> > > >
> > > > thanks,
> > > > jirka
> > > >
> > > >
> > > > [1] d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
> > > > ---
> > > >   kernel/bpf/syscall.c | 1 -
> > > >   1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > index fdbae52f463f..426529355c29 100644
> > > > --- a/kernel/bpf/syscall.c
> > > > +++ b/kernel/bpf/syscall.c
> > > > @@ -1991,7 +1991,6 @@ void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock)
> > > >             __acquire(&prog_idr_lock);
> > > >     idr_remove(&prog_idr, prog->aux->id);
> > > > -   prog->aux->id = 0;
> > >
> > > This would trigger a race when offloaded progs are used, see also ad8ad79f4f60 ("bpf:
> > > offload: free program id when device disappears"). __bpf_prog_offload_destroy() calls
> > > it, and my read is that later bpf_prog_free_id() then hits the early !prog->aux->id
> > > return path. Is there a reason for irq context to not defer the bpf_prog_free_id()?
> >
> > there's comment saying:
> >   /* bpf_prog_free_id() must be called first */
> >
> > it was added together with the BPF_(PROG|MAP)_GET_NEXT_ID api:
> >   34ad5580f8f9 bpf: Add BPF_(PROG|MAP)_GET_NEXT_ID command
> >
> > Martin, any idea?
> >
> > while looking on this I noticed we can remove the do_idr_lock argument
> > (patch below) because it's always true and I think we need to upgrade
> > all the prog_idr_lock locks to spin_lock_irqsave because bpf_prog_put
> > could be called from irq context because of d809e134be7a
> 
> before we dive into rabbit hole let's understand
> the severity of
> "perf_event_bpf_event and bpf_audit_prog calls currently report zero
>  program id for unload path"
> 
> and why we cannot leave it as-is.

I found this because I wanted use perf bpf-event to monitor bpf
programs loads/unloads.. and I need 'id' on the unload event

perf_event_bpf_event is irq safe so quick fix for me would be
to move it back:

        if (atomic64_dec_and_test(&aux->refcnt)) {
+               perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_UNLOAD, 0);
                /* bpf_prog_free_id() must be called first */
                bpf_prog_free_id(prog, do_idr_lock);

FWIW I also used fix below for a while for testing

jirka


---
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d88e0741b381..6b752d4815e6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1163,6 +1163,7 @@ struct bpf_prog_aux {
 	u32 max_tp_access;
 	u32 stack_depth;
 	u32 id;
+	u32 id_audit;
 	u32 func_cnt; /* used by non-func prog as the number of func progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d6081e8336c6..1f4fdf0aaac6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1930,7 +1930,7 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
 	if (unlikely(!ab))
 		return;
 	audit_log_format(ab, "prog-id=%u op=%s",
-			 prog->aux->id, bpf_audit_str[op]);
+			 prog->aux->id_audit, bpf_audit_str[op]);
 	audit_log_end(ab);
 }
 
@@ -1942,7 +1942,7 @@ static int bpf_prog_alloc_id(struct bpf_prog *prog)
 	spin_lock_bh(&prog_idr_lock);
 	id = idr_alloc_cyclic(&prog_idr, prog, 1, INT_MAX, GFP_ATOMIC);
 	if (id > 0)
-		prog->aux->id = id;
+		prog->aux->id = prog->aux->id_audit = id;
 	spin_unlock_bh(&prog_idr_lock);
 	idr_preload_end();
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0f0bfcf5adce..32edb3a4360e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9065,7 +9065,7 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 			},
 			.type = type,
 			.flags = flags,
-			.id = prog->aux->id,
+			.id = prog->aux->id_audit,
 		},
 	};
 
