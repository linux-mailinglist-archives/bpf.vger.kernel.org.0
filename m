Return-Path: <bpf+bounces-1918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D193D72386C
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 09:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454C01C20DA4
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853F5672;
	Tue,  6 Jun 2023 07:08:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E9814
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 07:08:57 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827A3F4;
	Tue,  6 Jun 2023 00:08:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-65131e85be4so5758555b3a.1;
        Tue, 06 Jun 2023 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686035332; x=1688627332;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/KmmYJMolzDvyI/o4GTWP59ccVUg3rMf4DQZBiWJjQ=;
        b=IeiGsgZ+xLRzlUgAcDrCRtTAbYB/yVOoCaqoNbaZlmrM8TAKtyVMf/MZTRGdiP3IME
         PO4fCFVWSCWTrqjm+QbbYH0wcM8ywSWBGAX4ZnWBfD+ba9PWAYFcAT/lQg5B2x0cnlZB
         7zNC5CrZaK9R9ups8EnKSIiqWcUEEELY27IYBqUdr4s88k2P2K43pTApisEkgwU3Uq8P
         dkFVSjjZHvJpOslJKca1Vci1Pqs2IG+2zJIji/Or8+hayezMJ39TNdpMrqxQ4ULeidFr
         QjzqqeBijAj3kfxfY1xbi53jx5RX2uQAAhVTlLUvNQlB8zJhwZsfN+EfIBGMctxPWZO7
         PJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686035332; x=1688627332;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/KmmYJMolzDvyI/o4GTWP59ccVUg3rMf4DQZBiWJjQ=;
        b=fevYDZ8+8/zVin7tFX62Yb+7yLWSFcxa3ZDkCmObncl8PiZFDLrAk3py73hIoWqT7T
         6mnJezDSNOkxyxQOVsXDNIhM/mwyAExGcMNEAxJD9LDW20dWCiNxo19wtxttBvQcst5r
         jbd6GYvHBSGmCW5CgA/eNQ3bOQDhAt+VbSfDbMQJJEKTn4HODUPlRPfqLyDlwEZT7ta5
         bjkxxRJO0V5a58Vj3hL6dlVJVGPFmNeE0Kf8x4KHD01a74KzS4RncAOFXG1LJzZYzyL8
         aC73Tx5P3/XsQWbDh3cECdPnloeOY2vEGcXj5d1sM5ptjQHdTC4LLghgQ9aTnt/8L2sv
         M3jQ==
X-Gm-Message-State: AC+VfDyqbHhA30C0TUYSskuC8EFFwnPdFxz/zU7uhT/SCral4OtsXxTU
	vRhxfbAO/aPo2TRpwN8TXxM=
X-Google-Smtp-Source: ACHHUZ41WgRUnNdZQMIyhLOldg2Glygbaur8arqX48YsBSeAMuaz4kB+vt9Be773O8AY8MDgqVfITg==
X-Received: by 2002:a05:6a20:729c:b0:116:99fe:e674 with SMTP id o28-20020a056a20729c00b0011699fee674mr2184128pzk.9.1686035331880;
        Tue, 06 Jun 2023 00:08:51 -0700 (PDT)
Received: from krava ([216.198.76.36])
        by smtp.gmail.com with ESMTPSA id j2-20020aa78d02000000b0065ebeb9bb23sm1351338pfe.149.2023.06.06.00.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 00:08:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Jun 2023 09:08:48 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	stable <stable@vger.kernel.org>,
	Anastasios Papagiannis <tasos.papagiannnis@gmail.com>,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Add extra path pointer check to d_path helper
Message-ID: <ZH7bgEjkhE2jyxLC@krava>
References: <20230604140103.3542071-1-jolsa@kernel.org>
 <CAADnVQJNKu=57nu6dd_jGR9ypT4R4cAUppz02XBiU8RnLxF7Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJNKu=57nu6dd_jGR9ypT4R4cAUppz02XBiU8RnLxF7Bw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 05, 2023 at 04:00:16PM -0700, Alexei Starovoitov wrote:
> On Sun, Jun 4, 2023 at 7:01 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Anastasios reported crash on stable 5.15 kernel with following
> > bpf attached to lsm hook:
> >
> >   SEC("lsm.s/bprm_creds_for_exec")
> >   int BPF_PROG(bprm_creds_for_exec, struct linux_binprm *bprm)
> >   {
> >           struct path *path = &bprm->executable->f_path;
> >           char p[128] = { 0 };
> >
> >           bpf_d_path(path, p, 128);
> >           return 0;
> >   }
> >
> > but bprm->executable can be NULL, so bpf_d_path call will crash:
> >
> >   BUG: kernel NULL pointer dereference, address: 0000000000000018
> >   #PF: supervisor read access in kernel mode
> >   #PF: error_code(0x0000) - not-present page
> >   PGD 0 P4D 0
> >   Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
> >   ...
> >   RIP: 0010:d_path+0x22/0x280
> >   ...
> >   Call Trace:
> >    <TASK>
> >    bpf_d_path+0x21/0x60
> >    bpf_prog_db9cf176e84498d9_bprm_creds_for_exec+0x94/0x99
> >    bpf_trampoline_6442506293_0+0x55/0x1000
> >    bpf_lsm_bprm_creds_for_exec+0x5/0x10
> >    security_bprm_creds_for_exec+0x29/0x40
> >    bprm_execve+0x1c1/0x900
> >    do_execveat_common.isra.0+0x1af/0x260
> >    __x64_sys_execve+0x32/0x40
> >
> > It's problem for all stable trees with bpf_d_path helper, which was
> > added in 5.9.
> >
> > This issue is fixed in current bpf code, where we identify and mark
> > trusted pointers, so the above code would fail to load.
> >
> > For the sake of the stable trees and to workaround potentially broken
> > verifier in the future, adding the code that reads the path object from
> > the passed pointer and verifies it's valid in kernel space.
> >
> > Cc: stable@vger.kernel.org # v5.9+
> > Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Reported-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 9a050e36dc6c..aecd98ee73dc 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -900,12 +900,22 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
> >
> >  BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
> >  {
> > +       struct path copy;
> >         long len;
> >         char *p;
> >
> >         if (!sz)
> >                 return 0;
> >
> > +       /*
> > +        * The path pointer is verified as trusted and safe to use,
> > +        * but let's double check it's valid anyway to workaround
> > +        * potentially broken verifier.
> > +        */
> > +       len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
> > +       if (len < 0)
> > +               return len;
> > +
> >         p = d_path(path, buf, sz);
> 
> Since we copied it anyway, let's use a stable copy here?
> Otherwise somebody might send a patch to remove 'dead code'.

ok, will change that

jirka

