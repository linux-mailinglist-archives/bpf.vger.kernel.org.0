Return-Path: <bpf+bounces-1917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857DE723864
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 09:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E681C20E2D
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 07:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4115674;
	Tue,  6 Jun 2023 07:08:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B13D9F
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 07:08:12 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB8E54;
	Tue,  6 Jun 2023 00:08:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b18474cbb6so33638955ad.1;
        Tue, 06 Jun 2023 00:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686035290; x=1688627290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LhXymuWC+f+sPDNwhPKQiZ8Tb/Ag8jByJPD2n4/Y4I=;
        b=csRVS2fMJzqm1iLmbMabQmsP+XtGQ3nrDubRg49dQRJx6oJe0DDhcqu6iZt2svFpES
         5e8JxKUMHlYhSf+qbONWYFLmz3j3wnT1r1/86kjijP59Q1ARtgXUolfMw49M9IrYbR/f
         sy2o6+3C0ZxUmLea7/vLaR04AObQckp8ZxOCZu4ww452nMhlAuKswBVi8CZ9pIB05gd/
         UR3xtS4YzbRtwFUrBcWpQ/DhJZYryA7+0NkueFaTouu9brGeS5k7V+WmlNnDV225Aawx
         ubJOg2AcNeuXYuJRSMvxUy4fhx5erRX3TZV87e9ysL6u77xmBkmEgXFUhAMaPoSHFu3z
         GmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686035290; x=1688627290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LhXymuWC+f+sPDNwhPKQiZ8Tb/Ag8jByJPD2n4/Y4I=;
        b=Zmdn2rE7DEhW/42F8ioahT/CeA9sESU6ExDK/x2gbErwIMbNACxPqXfLt4rrWXGtiS
         L9NTa6ZMEcdSPY+XQ5qKiqowr18HXNc4y7jbL5BvHqu4GpYiaamKPnMFFjbS98gr1oac
         DQey3lv51pfVkrKaih+y6olyCWWS3IGGCpllDisHnr1xxEk+irfelHwCQ/gQHADyhphx
         nBCTK827PBlHkqEcG8GRXsY/UMwT01MVM03T4mdMMLvda56gc9YQdz/iDYllv6hCnxBH
         3NQJCQjuuTFMwzZxEmtbgOZ0+d0qS8yXb3oiHdjMzUd2xaXOB0Fz6H5vZZlwBtee5RnZ
         RF4A==
X-Gm-Message-State: AC+VfDwxiyB0kyEXX2gFFgUwnfWlLsk8WgOZFNsHuFadrOeSIFAMHJL/
	Hc7nNYgA399ATolISkW8utU=
X-Google-Smtp-Source: ACHHUZ4kMVsEc679u9q+ncoI5iFUFbK+T2pL/n0kIVjgR+5qshZPDmipMUvF6WQr0QoIXaAjhZdrkQ==
X-Received: by 2002:a17:903:2312:b0:1b0:28a9:fa78 with SMTP id d18-20020a170903231200b001b028a9fa78mr1109122plh.34.1686035289970;
        Tue, 06 Jun 2023 00:08:09 -0700 (PDT)
Received: from krava ([216.198.76.36])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902d48b00b0019e60c645b1sm7658311plg.305.2023.06.06.00.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 00:08:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Jun 2023 09:08:05 +0200
To: Stanislav Fomichev <sdf@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org,
	Anastasios Papagiannis <tasos.papagiannnis@gmail.com>,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Add extra path pointer check to d_path helper
Message-ID: <ZH7bVR8nTma/faed@krava>
References: <20230604140103.3542071-1-jolsa@kernel.org>
 <ZH4aTA0qV0YkoXaA@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH4aTA0qV0YkoXaA@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 05, 2023 at 10:24:28AM -0700, Stanislav Fomichev wrote:
> On 06/04, Jiri Olsa wrote:
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
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> 
> One question though: does it really have to go via bpf tree? Can it
> be a stable-only fix? Otherwise it's not really clear why we
> need to double-check anything if the pointer is trusted..

so at the moment we consider linux_binprm->file as trusted and
always != NULL for lsm/iter and few other trampoline hooks

if that changes for some reason and linux_binprm->file will be NULL
for some reason, we might be notified just by crash first, so it
makes sense to me to have that check also in upstream 

jirka

> 
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
> > +	struct path copy;
> >  	long len;
> >  	char *p;
> >  
> >  	if (!sz)
> >  		return 0;
> >  
> > +	/*
> > +	 * The path pointer is verified as trusted and safe to use,
> > +	 * but let's double check it's valid anyway to workaround
> > +	 * potentially broken verifier.
> > +	 */
> > +	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
> > +	if (len < 0)
> > +		return len;
> > +
> >  	p = d_path(path, buf, sz);
> >  	if (IS_ERR(p)) {
> >  		len = PTR_ERR(p);
> > -- 
> > 2.40.1
> > 

