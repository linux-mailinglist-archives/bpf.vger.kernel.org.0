Return-Path: <bpf+bounces-65000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F7FB1A2D0
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 15:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCA218A18AE
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 13:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7E3267B7F;
	Mon,  4 Aug 2025 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbDQgVrM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07123D295;
	Mon,  4 Aug 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312555; cv=none; b=pGnZaO9+r+vzADfc8ZRVeX9dXayt6QsRZNr5bRVaG/zPf5e/J91YnzHA88oP3gkSvufii3+Ci/JR6oOAYSLGDT09ehFVBBmh2zKzLciq9ugX+fw16ED5tfOHOtMtzVdMjCoxT6NcHm4SaabPbmLqbixMRJ+wxZIYkRB/27jXfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312555; c=relaxed/simple;
	bh=KJ/UgFDqRbxBwDKBasxWHrD/lJ88LOWc5cck1Eyrlko=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM2jVUqTX4DWRMMgkxBToMTA8xPy8a7DRHI4HBaIEsRRAZt99/FbC5zkSdcX22LNK+RSuMZYmJ1pMWO4LiDxFEzzc2IxJr3Skqyh3BAY70Tuu+PxUkMhQJmZnb/HZyDv/qtCQMojflEfTjMGqsCF7GXyZInBMV/5BJGsBQvweE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbDQgVrM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so6383530a12.2;
        Mon, 04 Aug 2025 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754312552; x=1754917352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qeIilQ03OODqPPS1A7gu4nmzTbwmTDY7BMwLvZtC32M=;
        b=lbDQgVrMofk+U9pHHF01HqTi+PVB3UVZDH+nAuS7/FKvkf44ajy3aLRgBn18icwtLc
         EGrzkJtXXgyJXUryu5b8XH9MgmAfYxgYN7cxPynJzkOUr713Tjde2SODmX/1lS9CBiun
         zFYM6CtQw3AK2VF12pPby3F0M4pXOqXvbonKstEyJt5qtEPwRDITqkPIpb5cGYpuBru/
         feuEIK6YMlBxdZ6H1XBHVLstXnPsLnhxo8/oW+tn1l250qwkuaUzHHTTqVzO9nlN++qh
         o2D+NDd80DzfBKH6y24rQCLhBXVwHnDoc8xPBNDB4SznCwfkoMsAbmgRFgkL/zum7E5f
         kcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754312552; x=1754917352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeIilQ03OODqPPS1A7gu4nmzTbwmTDY7BMwLvZtC32M=;
        b=aZXXN6oqkHIY8q/dMpV6kOb544cmTmzg4X3roE6vz7yU4VrQkIzyNdG4+ApHsK47aE
         PQUVj/1oHFJ5jQVtIjSJr8Igwe4LUGEh9PkiYBfIyGNmhJuEvS2p7G89oa0cH1kN/RgO
         TMzmnqBIPR7zWJKB9lQBmebR8eDuLmz2VC+XbpkXLNjEEwaqnWWWiRkTrztVTod3yJr2
         m1QtNJWIgn3jqyTrlRhqttBLHQtRachxemV4pODd0BJk03xol/rSSVLnQv7bh4JBhBO1
         s9qsizsuxAkVm9TmWqcnB7gYcx+eqexaik8S/aFxn3smM4bEW9MCnWP3D4pqgdCXJ86h
         3ZLg==
X-Forwarded-Encrypted: i=1; AJvYcCUKLDLAL1Mrd/j0ObC4TDiCE4WTWKlOgn883jHyqg4uDjOtKoDWSLycWyH7ubzoKDMK6x7YaT6sAQUreZywSQaP9IYl@vger.kernel.org, AJvYcCUQ0l1B1aTeg7oO095/srlf4zVtLAUll2k6U+snffX2lcyGdQ/6aPN/duvsrrmTbd5qbuAn/NAWRTxpDMbI@vger.kernel.org, AJvYcCVdegalTKzyDNEzSdsYUoBfgY0/o4Gup8WFDSmGusuZ9sOrUSqZXkT9JWYJksKkbH+Wryg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7MSZ+puxtyvPASwKfZQP37cdmp7C46qleDOVfBYxvYvyIw/aq
	+ixQNfkxW8WJ2XPWdqqHEifhJ+q3kgCJx+yJ67s7Kk7tpANjTrfUA4N4
X-Gm-Gg: ASbGncvrJyL6zDDXmPePIGM/VVSyxoN9E571/89E+zwvMvQTSWgbd7bNqAvMl7+32zr
	NHTXJuuJfreoV2tRLyqpSXEp48mJz9LaRXrwL6WhNbQij5Eb4NzRvAOF3FLlCuBJOTZ2BhutSV0
	+CjmwwIIpdaiMF7TolIXYPzww3La90sldj9ZT4c0ZngPpKeVWgi2fmVomyOcsxUnANCoYwAk1wa
	CWgoIJxZ09/3MJr9QJuBWftnkAZNUQK9nvMn+RnPsvXoLXOfcfAz0oBcPH7ZLwV06F+Y3yrg2H0
	MsVFfmsa41WWQw1o/PPqhnGyHS1BFn9rV1369yN8+SdMO4DQRTjj1zpoOO3Ych49DRvpHZL7MaT
	YbC/wPy/2AsSGbHhYBBo=
X-Google-Smtp-Source: AGHT+IGwC42uDRuXfuDzfKGa7qC/PmM3hiopRQT50RbwaPKdEWGITvtAYzH5iixwAJHfvqgey5SbKA==
X-Received: by 2002:a05:6402:3553:b0:615:9c3b:17f with SMTP id 4fb4d7f45d1cf-615e6ef235cmr8220200a12.15.1754312551017;
        Mon, 04 Aug 2025 06:02:31 -0700 (PDT)
Received: from krava ([173.38.220.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f25739sm6920530a12.21.2025.08.04.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 06:02:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 4 Aug 2025 15:02:27 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Disable migrate when kprobe_multi attach
 to access bpf_prog_active
Message-ID: <aJCvY7G-gVR8taLh@krava>
References: <20250804121615.1843956-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804121615.1843956-1-chen.dylane@linux.dev>

On Mon, Aug 04, 2025 at 08:16:15PM +0800, Tao Chen wrote:
> The syscall link_create not protected by bpf_disable_instrumentation,
> accessing percpu data bpf_prog_active should use cpu local_lock when
> kprobe_multi program attach.
> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/trace/bpf_trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3ae52978cae..f6762552e8e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2728,23 +2728,23 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>  	struct pt_regs *regs;
>  	int err;
>  
> +	migrate_disable();
>  	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {

this is called all the way from graph tracer, which disables preemption in
function_graph_enter_regs, so I think we can safely use __this_cpu_inc_return


>  		bpf_prog_inc_misses_counter(link->link.prog);
>  		err = 1;
>  		goto out;
>  	}
>  
> -	migrate_disable();

hum, but now I'm not sure why we disable migration in here then

jirka

>  	rcu_read_lock();
>  	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>  	err = bpf_prog_run(link->link.prog, regs);
>  	bpf_reset_run_ctx(old_run_ctx);
>  	rcu_read_unlock();
> -	migrate_enable();
>  
>   out:
>  	__this_cpu_dec(bpf_prog_active);
> +	migrate_enable();
>  	return err;
>  }
>  
> -- 
> 2.48.1
> 

