Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D137A6646A8
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 17:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjAJQzv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 11:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbjAJQzi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 11:55:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B026319C13
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 08:55:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o13so9524750pjg.2
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jR4tzWqElfmW8QXwRewDX/Da1DcZTjPzAW0JMNMjZzU=;
        b=Im42JvnEz/G0ojG3vnz4B3EpJB9ByRDt8qrhjq+MV+G08a9YXDE2YIwy8p7/TRqS54
         ulzIKFlFCCBfqXhcUeDAdaXLSF+qJavN8n3pF1VWb1oX64nmxoVyAaF40CkMiOmCp8Vi
         CTPHw82A/0TDeR6e+EjIIyDPzTHsGRSdq+JGqkQLoGG71Pf1LXET10td5byJaeSq9s+S
         1e3brCfuuKcHiritdbTzW4AeaxqMiiXimPEWB0+VU/eMT1MdkmGctBurbACaiSoBqr73
         ESLvqDoGRBQWwyYvpc7SSvnOBkOYuAav1uAa85G8VxfUS8CRQYjb4P4IusSpVpTVf4b5
         RolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR4tzWqElfmW8QXwRewDX/Da1DcZTjPzAW0JMNMjZzU=;
        b=aOh04NOeu6NapxuldWMZgASibC+bZdu1tBYTpmKMC0s3F0D517OQfiBzopxqoBmONJ
         TXF2WPKvVkQhydGn0BjW8hL0yJ/ehgUu5745RlFeNpOe3kbH82HcfnfV9QPKzjhoMmxq
         A9Eu/qhRCzDg9ioMe7+vSTqsg7RfQIG7Cy546nya6qLGyPN2SPCBItlwMapted8uuuxU
         8KpcB7qBY24NkjIJY+VsYN7xR9/WoTA7f/8e16+plKdR6HXOhnRTxUxrTjwxjTqnvikP
         +p3W+o0VPITsgRXkjPWMHMSEmBJiF0Xh1jrbbmtKlOVs8bFrFVieRMLhc5pqkYyITKWV
         TW5A==
X-Gm-Message-State: AFqh2kpCvPq9vHnqQ8TWclTVLxE2SC5ZzIp4pz4Iegrk/cIKSRaee08M
        X7TRc+saU3KR7MCQfWqF79wxwVOgXoHgX4WcwAYg/jVjOyx/
X-Google-Smtp-Source: AMrXdXtAcgCtqLeebZzIIOK+6EKQdCv8fBk3I302FBiBvlAmgf3r32qYRRPeFyzTWm/YpxvQUe5njrN/Ek4jAX5NeLI=
X-Received: by 2002:a17:902:968a:b0:192:7a00:c790 with SMTP id
 n10-20020a170902968a00b001927a00c790mr4310537plp.12.1673369735961; Tue, 10
 Jan 2023 08:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20230106154400.74211-1-paul@paul-moore.com> <Y70rbnusftLg1ymg@krava>
In-Reply-To: <Y70rbnusftLg1ymg@krava>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Jan 2023 11:55:26 -0500
Message-ID: <CAHC9VhTc19PbdqOLjP-s_AiEO-z4POF1cCPF7MjjO8GvB8=DNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: restore the ebpf program ID for
 BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Burn Alting <burn.alting@iinet.net.au>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 10, 2023 at 4:10 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> On Fri, Jan 06, 2023 at 10:43:59AM -0500, Paul Moore wrote:
> > When changing the ebpf program put() routines to support being called
> > from within IRQ context the program ID was reset to zero prior to
> > calling the perf event and audit UNLOAD record generators, which
> > resulted in problems as the ebpf program ID was bogus (always zero).
> > This patch addresses this problem by removing an unnecessary call to
> > bpf_prog_free_id() in __bpf_prog_offload_destroy() and adjusting
> > __bpf_prog_put() to only call bpf_prog_free_id() after audit and perf
> > have finished their bpf program unload tasks in
> > bpf_prog_put_deferred().  For the record, no one can determine, or
> > remember, why it was necessary to free the program ID, and remove it
> > from the IDR, prior to executing bpf_prog_put_deferred();
> > regardless, both Stanislav and Alexei agree that the approach in this
> > patch should be safe.
> >
> > It is worth noting that when moving the bpf_prog_free_id() call, the
> > do_idr_lock parameter was forced to true as the ebpf devs determined
> > this was the correct as the do_idr_lock should always be true.  The
> > do_idr_lock parameter will be removed in a follow-up patch, but it
> > was kept here to keep the patch small in an effort to ease any stable
> > backports.
> >
> > I also modified the bpf_audit_prog() logic used to associate the
> > AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> > Instead of keying off the operation, it now keys off the execution
> > context, e.g. '!in_irg && !irqs_disabled()', which is much more
> > appropriate and should help better connect the UNLOAD operations with
> > the associated audit state (other audit records).
> >
> > Cc: stable@vger.kernel.org
> > Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
> > Reported-by: Burn Alting <burn.alting@iinet.net.au>
> > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > ---
> > * v3
> > - abandon most of the changes in v2
> > - move bpf_prog_free_id() after the audit/perf unload hooks
> > - remove bpf_prog_free_id() from __bpf_prog_offload_destroy()
> > - added stable tag
>
> fwiw I checked and the perf UNLOAD events have proper id now
> thanks for fixing this

No problem, thanks for verifying that this solves the perf problem too.

-- 
paul-moore.com
