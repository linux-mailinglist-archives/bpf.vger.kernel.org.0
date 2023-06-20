Return-Path: <bpf+bounces-2941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92A073725E
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 19:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CE21C20CBA
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28CC2AB3D;
	Tue, 20 Jun 2023 17:11:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8212AB30
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 17:11:20 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AD410E2
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 10:11:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b53e1cd0ffso20011225ad.0
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281079; x=1689873079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vMCL9MBUgaXBCtQ1dLciPYdPyIFXYIps1O+bKc0deQ0=;
        b=c2NaxhmRSgTGmqtwGOgcvj17CEnylSGIv3WcFdpUb2eSNKfvAXIf5IUF1+mQuVOQyB
         BZtQiOT36t8kSMVYMAQow+OtzTbB5DHwAQePge6xo4TWNMJDcpDGSEx58wUFuOYeBScE
         cbdfvLI5uI6PoA8/caFs2LkU7IzA19uV5b57SKbt0w8JM3Sc/vcsdit1ZiGxHaz9QYhg
         +rINOnacoQWX4Lz/7/kmSIQWtjVeAhKh59yN9kNPfPun7IE2vNFcy7qYmSLvuJAeLVHd
         mEPuh+jL57kfzgEX/VjHrtuOux6aLqDKhybvbbB3VUfhNZQqDY+5bUq7OkItnGgmviUU
         UmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281079; x=1689873079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMCL9MBUgaXBCtQ1dLciPYdPyIFXYIps1O+bKc0deQ0=;
        b=AKRljhZWtqzO+ivEnD8SEkbbQadnAUUzP4pu09JxcQoXt718wQO/sNgZR+gnEUlUpo
         2yCkh7CT0nevQmyjRrGWtbbGYBMaLJ5qzuxCTUG/ve3FYS0vNXOgBn9F9s1e0INV45b6
         CDgeQEfhYhzrC4YVxnbB1PaRMZC2kwUEOIyc93ec4ComaVVln9YPC05BIV+Gxzf+BZtk
         5w1j6JqUIG6rOsZTR8UGKCsY+jZ5yLzluLILyKNk8lRcoy2mc0Evz0SvPgJ6Cnu1uvEW
         aCsJnIrdGx76f277SM/TD0R4Yop75tU1oy+u2GvJe99JaODDeXH4/I1waV4Szp9Cds4e
         p8Ug==
X-Gm-Message-State: AC+VfDyt6mGOEQBdyBlhDmP7W5eaH1nVWG1HYQ1ARwB9xy03Bsh5Wkjy
	1f6DOqjJmt2QhUncHnEV5wg=
X-Google-Smtp-Source: ACHHUZ5RfcJeeo+Vn4GGoz3KLpbtyjmwvoRLXSAF+HdLHSrTN3Nth52WFit/tkU3h9DABhJMbrAQEA==
X-Received: by 2002:a17:902:d2ca:b0:1ad:bb89:16f6 with SMTP id n10-20020a170902d2ca00b001adbb8916f6mr10096565plc.50.1687281078659;
        Tue, 20 Jun 2023 10:11:18 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001b6758a2d94sm1835893plr.305.2023.06.20.10.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:11:18 -0700 (PDT)
Date: Tue, 20 Jun 2023 10:11:15 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
Message-ID: <20230620171115.ebel6f7kjeyy4msn@MacBook-Pro-8.local>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620083550.690426-2-jolsa@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 10:35:27AM +0200, Jiri Olsa wrote:
> +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> +			   unsigned long entry_ip,
> +			   struct pt_regs *regs)
> +{
> +	struct bpf_uprobe_multi_link *link = uprobe->link;
> +	struct bpf_uprobe_multi_run_ctx run_ctx = {
> +		.entry_ip = entry_ip,
> +	};
> +	struct bpf_prog *prog = link->link.prog;
> +	struct bpf_run_ctx *old_run_ctx;
> +	int err = 0;
> +
> +	might_fault();
> +
> +	rcu_read_lock_trace();
> +	migrate_disable();
> +
> +	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
> +		goto out;

bpf_prog_run_array_sleepable() doesn't do such things.
Such 'proteciton' will actively hurt.
The sleepable prog below will block all kprobes on this cpu.
please remove.

> +
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> +
> +	if (!prog->aux->sleepable)
> +		rcu_read_lock();
> +
> +	err = bpf_prog_run(link->link.prog, regs);
> +
> +	if (!prog->aux->sleepable)
> +		rcu_read_unlock();
> +
> +	bpf_reset_run_ctx(old_run_ctx);
> +
> +out:
> +	__this_cpu_dec(bpf_prog_active);
> +	migrate_enable();
> +	rcu_read_unlock_trace();
> +	return err;

