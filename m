Return-Path: <bpf+bounces-49607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7151CA1AAFC
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 21:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5813AEC85
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 20:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09531C3BF8;
	Thu, 23 Jan 2025 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmlLf9fp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6A1C07DC;
	Thu, 23 Jan 2025 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663127; cv=none; b=fPe4exTEJ0EbYRhfMiOHQ0+2bBsUoW3RhHzBU+ahRuWCRaxJR5G0orwIBTxDwZiqnEFcMGaI9DqqkNv1KLdLdRLUG/UsiovzolZnsstCxeEOE9JZerKXlTmYYPtCOBd5hTdyTx88aJi93SMUHUTh/IQFTE/DrhumXsmyQcnlVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663127; c=relaxed/simple;
	bh=PxST3s51zrEt9lIkRo0zXXSmRKi0OB4Pqe9a5P4L2u4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smHrOmC0Z2svQl+vX+PwUA4UNmrL8MCPE8XKzJ9HCLyUpwZUVDYg7BQ0tH+ykAQYt3rZk7MktfffxVL1/4ohm4veHB/t9fMTkLuKe+g22PfqdBRXiwmz0kPIDotNnGuTzf/NQE4vX8T3zntsfAjOLfhmtjdSDE9Qg8JhoxTuuZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmlLf9fp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa679ad4265so498301166b.0;
        Thu, 23 Jan 2025 12:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737663124; x=1738267924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrETL7CtaIuPkvBFrZDVaIPy9gmEngJKx416P0q0tKg=;
        b=JmlLf9fpxTxsCTBLdnsdjPOhC8EKGAEkpKqQTZ5OFzLgKbh8s7GTmOBbw/SvZMqHAv
         Jy8IMP1oHgDwzfNFVXVPMXfv/4XckYX+8OlBSlr0Fta1pE33DPAhExy5Wxedm0+fH3Vx
         ump3mQoCXfit9LyTBuVok0b9ztXjpTDTii7gUnb2ScVZ4htxBYnrGzRPWhNdaTBZ4rcN
         P/QLZ2IYci8FtHLE6FuK/i8TEnxvLIsaFSHzLpsj2ro85GeKRDlrZ+ryjTkP8H4hdy0O
         cfJZFoOAhOs5f0XcAgd4AzfcaOzGXhALm5UtRh2T2IWYKmRifwL3dqybfNCuBJ2moGhE
         ttrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737663124; x=1738267924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrETL7CtaIuPkvBFrZDVaIPy9gmEngJKx416P0q0tKg=;
        b=xE74gKRBamZL1K1K5yzRUUu41Iu+95LZZOPS1xzwaCruaMOkOi5SG0Y5oxFzFUJnDZ
         0dTZEiN19wwEmSS3QjyHKQOJYJyXPaezJ8lRfP07IaCrUHng/2KBARfbjmQc4aRND97e
         89o5oYmjPuJ3p6DyxG69yhvBtlkk/ulz5qaI5lmpyEpGFCXQUfwL8p8JfDungiCs9kaL
         wJB+IPs/IgZ9/exu/Kqg2ohFQ7785c+3XpYawPDuSnsIp5l6LFY6dcSOMMDX/hNHGcce
         LwhK3iSZI2GBvTUmgOotjgeFSrYWMDzGJ+r3ZEUOFuIjHkYmPC2HqpQlBw6ib7ui3km1
         /jhg==
X-Forwarded-Encrypted: i=1; AJvYcCVAoAohMVOua7FVpdSmotVMOt/jtVsilO5exnLYTcMXVZePVqOBwwNdD2ynDhzcsKB7eGodlqnqdm0XQ3Yh@vger.kernel.org, AJvYcCXwdlppgFXPZ8nPv7sV8Tv0qeRiae+26JT6Llw31mcDaBnJuYWbSnhhjReXrhXfucIsgTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUdvlkVfwxDrYL6DalzMFtAPmzk3mqoomtJV21zxea92VuiW/K
	8X07nVA3HGY6GmpECpco2LdE9xOUF1th7LjSQ6hNXbv5IvW75mHu
X-Gm-Gg: ASbGncv0rpD4ysP2WXqam2h65CvLaCpmtdmchhgCSD5/csN6U8PPa24p47udKM0nXzl
	Eju4gQMv3YP37s2fzqjiTZwvmlivvr1VH32aMnBxNi1WZj5Q77ea4JcEo4e9DXUkD2emh9nkr+x
	iIHWj6Ztwqf1jjOnyMKe1/DwNcUxPZvCi7CZgQHkQVO0Iu+5HsddwUr3vghgJvqwnL+WY8XrmWx
	WskHmqdBFl626rYJxT3ZaOW6W1ydf/0efnoEoZQyeFaEdAHaaOt/9pyDRn7v1h30UK3YNr4lWAM
	nkbAIGgicmaxLg==
X-Google-Smtp-Source: AGHT+IHO4uFpJ9Q1HUMzbynFV/9t/ZsoGAsw3hfnOYrCYPsNLmNjyvs0S6vjwGZnASN76j8lzpVirA==
X-Received: by 2002:a17:907:3f24:b0:ab3:a2f9:d6ef with SMTP id a640c23a62f3a-ab662a001d4mr348712366b.21.1737663123589;
        Thu, 23 Jan 2025 12:12:03 -0800 (PST)
Received: from krava (37-188-182-96.red.o2.cz. [37.188.182.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760ab280sm11191266b.104.2025.01.23.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:12:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 23 Jan 2025 21:11:58 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tao Chen <chen.dylane@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, haoluo@google.com,
	qmo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add libbpf_probe_bpf_kfunc API
Message-ID: <Z5Kijmlt9vrSyslv@krava>
References: <20250122170620.218533-1-chen.dylane@gmail.com>
 <Z5Khb2qaSJCo16Yf@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5Khb2qaSJCo16Yf@krava>

On Thu, Jan 23, 2025 at 09:07:11PM +0100, Jiri Olsa wrote:
> On Thu, Jan 23, 2025 at 01:06:19AM +0800, Tao Chen wrote:
> > Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
> > used to test the availability of the different eBPF kfuncs on the
> > current system.
> 
> hi,
> there's "bpf_kfunc" DECL_TAG for each kfunc in BTF data,
> I think that should do the same job? please check [1] and
> related commits for details

nah there's v2 with support for modules.. makes sense then, will check

sorry for noise ;-)

jirka

> 
> jirka
> 
> 
> [1] 770abbb5a25a bpftool: Support dumping kfunc prototypes from BTF
> 
> > 
> > Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.h        | 16 +++++++++++++++-
> >  tools/lib/bpf/libbpf.map      |  1 +
> >  tools/lib/bpf/libbpf_probes.c | 36 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 52 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 3020ee45303a..3b6d33578a16 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1680,7 +1680,21 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
> >   */
> >  LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
> >  				       enum bpf_func_id helper_id, const void *opts);
> > -
> > +/**
> > + * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
> > + * use of a given BPF kfunc from specified BPF program type.
> > + * @param prog_type BPF program type used to check the support of BPF kfunc
> > + * @param kfunc_id The btf ID of BPF kfunc to check support for
> > + * @param opts reserved for future extensibility, should be NULL
> > + * @return 1, if given combination of program type and kfunc is supported; 0,
> > + * if the combination is not supported; negative error code if feature
> > + * detection for provided input arguments failed or can't be performed
> > + *
> > + * Make sure the process has required set of CAP_* permissions (or runs as
> > + * root) when performing feature checking.
> > + */
> > +LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
> > +				      int kfunc_id, const void *opts);
> >  /**
> >   * @brief **libbpf_num_possible_cpus()** is a helper function to get the
> >   * number of possible CPUs that the host kernel supports and expects.
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index a8b2936a1646..e93fae101efd 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -436,4 +436,5 @@ LIBBPF_1.6.0 {
> >  		bpf_linker__add_buf;
> >  		bpf_linker__add_fd;
> >  		bpf_linker__new_fd;
> > +		libbpf_probe_bpf_kfunc;
> >  } LIBBPF_1.5.0;
> > diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> > index 9dfbe7750f56..bc1cf2afbe87 100644
> > --- a/tools/lib/bpf/libbpf_probes.c
> > +++ b/tools/lib/bpf/libbpf_probes.c
> > @@ -413,6 +413,42 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
> >  	return libbpf_err(ret);
> >  }
> >  
> > +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
> > +			   const void *opts)
> > +{
> > +	struct bpf_insn insns[] = {
> > +		BPF_EXIT_INSN(),
> > +		BPF_EXIT_INSN(),
> > +	};
> > +	const size_t insn_cnt = ARRAY_SIZE(insns);
> > +	int err;
> > +	char buf[4096];
> > +
> > +	if (opts)
> > +		return libbpf_err(-EINVAL);
> > +
> > +	insns[0].code = BPF_JMP | BPF_CALL;
> > +	insns[0].src_reg = BPF_PSEUDO_KFUNC_CALL;
> > +	insns[0].imm = kfunc_id;
> > +
> > +	/* Now only support kfunc from vmlinux */
> > +	insns[0].off = 0;
> > +
> > +	buf[0] = '\0';
> > +	err = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
> > +	if (err < 0)
> > +		return libbpf_err(err);
> > +
> > +	/* If BPF verifier recognizes BPF kfunc but it's not supported for
> > +	 * given BPF program type, it will emit "calling kernel function
> > +	 * bpf_cpumask_create is not allowed"
> > +	 */
> > +	if (err == 0 && strstr(buf, "not allowed"))
> > +		return 0;
> > +
> > +	return 1; /* assume supported */
> > +}
> > +
> >  int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
> >  			    const void *opts)
> >  {
> > -- 
> > 2.43.0
> > 

