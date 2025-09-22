Return-Path: <bpf+bounces-69264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B605B93140
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 21:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CC618859B8
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484272F6199;
	Mon, 22 Sep 2025 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIyqOK2C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151E1F91E3
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570353; cv=none; b=qbTlqYxsbG95V/wQZkmqdPR5RZSGazyRqVrdxjn8g/2wrPd0bIr86SCOK8TGG117+uujc95ykjfPX60VdaiAUxhlNXo6mAME0sFHivFK33AKlCb5ncEgD/tSvuUahhxDXAZX469/RKT564/F3dlYRijw2KT1IdP9esn5b8oCC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570353; c=relaxed/simple;
	bh=vjW9IJzd7UfgdYsiSak1w31pK5m8/cVZ+B867T8HHBM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFvBmhgyo9Ty3O3HGi5zr8ivMsphghQ5f59gZ80Toxe8GZfDYV0LfJuudYrDFqCiJmPVfBZQDgck379arX1MdIF1gZIyqhPTnWlOuhZsTDY0T60tlgG02IxEtBrt1VEvOvLqbMSKA3aN+vMlTb0sICglFVMGgKbKY6loJqcR8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIyqOK2C; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so3411969f8f.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570350; x=1759175150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RTJuNbQlewXWG9hXwZRk7tnR5Pkf04f51vbak4miOXo=;
        b=AIyqOK2C8LemqzBZPCzKVitZ+JRQU0TJGPkviAab5wqm3BeD8PVr4w+iOuwomOVRcC
         7tmP2I4QbuUlkrY+j6RMPjqOIA9yZFEFONUL/5XEKafxN+PfGSukPF7PVQ3D985smwst
         KQF1m52KBhm62RkU8EFDtPXo0AKo6y5eBE62E/rI9+C7JuPgPt1ceLRC5ERybSpIoPRc
         PXvJFilr+2je1DyH0LjcTutLoRfrD01STt7Uix2lyxAjrV8+r4/jnpx7buIyw/AP2V6W
         MvdhnCosXL4U7l+Q92jxMcGl6r6/LhO1wFgAstPKYj0xjhGgEOn1ThfkyqNX4SoLTNti
         Vn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570350; x=1759175150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTJuNbQlewXWG9hXwZRk7tnR5Pkf04f51vbak4miOXo=;
        b=lN5wCIMr3U7HgNO2tQYsC2ilMEEf44x56yt0IrMcDDTUhpp2USxh0Meob3oamT4p/e
         bL85r5QiG+RJEKfSnnbrGfBlnel58O6E1xp5HG3i4qel6NlVvLNYDFhbxB5pZaW9oOMc
         sVntZdPZwEyT2pI/aT7wTafEKEPaomSCgEw/Bf/IaOOD1MeiR5a6g0VJSJwyvmVjNLsT
         FJ19bC7mO9Jf0zEej77rm47T93SXbdsU+HhQY+vtbwb+fmPaSxF7Lc88qaDi9EnnLvYj
         aU9qpdC9liGWANTHobpG/nkt0S2ivaXTL1Uf6hlBnWhGbg3ARVcirETAy1o3yOVE8Mlx
         uLfg==
X-Forwarded-Encrypted: i=1; AJvYcCVsrqlPPly4BGnz8MdhsFcSGDyP6vOs5Xq6IfyvtWdU2TzurX0Eyt6F+2u79nyXRNI7fAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7jMC2cMXVDMPTEX77cs4Mi3GWOmc0IIDyM9sFL3QSvYb23R7
	Z7RTtKm4PfySVSMCcd0V6JVRSq94mkJSX1/jgMGcH+QLrdSxf9C8lvsT
X-Gm-Gg: ASbGncubR03MwAnPGxsJIFYAlF7epxnIj9X+gAhgq8m0OypEXZNxEIssLk/zpwOiQhl
	eCC8oH9UYAhpTZSN2MDazS66L0/akHWh6U5NhVtgcP1ALyxxRhs1EEYqlIJQx35bd2tDNc1NOOr
	2JtdyMtF5Euq79yFV8s4CNbs9MLmkxHX/KQytR9/zqGpwjn28cnpKpDrQk1dTyngdtE2VG2CYg2
	UrTNc3IUNrHGTqjXXs3B65FayZWyP6b1DL98bZZw1ab0WjIH7RuopGxU10VKzxnwGwCTSgzeH/C
	67uZb43fwGk/NSR9M4+a3JE+y3Or5VMK4gqJNeaU8TrYPNCffsGJxyXMEtlSFfU+UprHFeHdtC1
	efZ3P2m6ZQAw=
X-Google-Smtp-Source: AGHT+IFALcKFujkO7JJhfq5xMAulEIF3k9Kmo/R5l/wpLtebtJaXUZkr0+TlebYOIa4nJOAGkyNmrg==
X-Received: by 2002:a05:6000:4008:b0:3ee:1296:d9e6 with SMTP id ffacd0b85a97d-3ee8a3d64b4mr12379884f8f.61.1758570349889;
        Mon, 22 Sep 2025 12:45:49 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc730dsm21311105f8f.41.2025.09.22.12.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:45:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Sep 2025 21:45:47 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, kees@kernel.org,
	samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
	ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: fgraph: Protect return handler from recursion
 loop
Message-ID: <aNGnaylt_WNL6bZr@krava>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <175828305637.117978.4183947592750468265.stgit@devnote2>
 <20250919112746.09fa02c7@gandalf.local.home>
 <aM5bizfTTTAH5Xoa@krava>
 <20250922151655.1792fa0abc6c3a8d98d052c9@kernel.org>
 <aNFRRa3m6Qm8zzQu@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNFRRa3m6Qm8zzQu@krava>

On Mon, Sep 22, 2025 at 03:38:13PM +0200, Jiri Olsa wrote:
> On Mon, Sep 22, 2025 at 03:16:55PM +0900, Masami Hiramatsu wrote:
> > On Sat, 20 Sep 2025 09:45:15 +0200
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> > 
> > > On Fri, Sep 19, 2025 at 11:27:46AM -0400, Steven Rostedt wrote:
> > > > On Fri, 19 Sep 2025 20:57:36 +0900
> > > > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > > > 
> > > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > 
> > > > > function_graph_enter_regs() prevents itself from recursion by
> > > > > ftrace_test_recursion_trylock(), but __ftrace_return_to_handler(),
> > > > > which is called at the exit, does not prevent such recursion.
> > > > > Therefore, while it can prevent recursive calls from
> > > > > fgraph_ops::entryfunc(), it is not able to prevent recursive calls
> > > > > to fgraph from fgraph_ops::retfunc(), resulting in a recursive loop.
> > > > > This can lead an unexpected recursion bug reported by Menglong.
> > > > > 
> > > > >  is_endbr() is called in __ftrace_return_to_handler -> fprobe_return
> > > > >   -> kprobe_multi_link_exit_handler -> is_endbr.  
> > > > 
> > > > So basically its if the handler for the return part calls something that it
> > > > is tracing, it can trigger the recursion?
> > > > 
> > > > > 
> > > > > To fix this issue, acquire ftrace_test_recursion_trylock() in the
> > > > > __ftrace_return_to_handler() after unwind the shadow stack to mark
> > > > > this section must prevent recursive call of fgraph inside user-defined
> > > > > fgraph_ops::retfunc().
> > > > > 
> > > > > This is essentially a fix to commit 4346ba160409 ("fprobe: Rewrite
> > > > > fprobe on function-graph tracer"), because before that fgraph was
> > > > > only used from the function graph tracer. Fprobe allowed user to run
> > > > > any callbacks from fgraph after that commit.
> > > > 
> > > > I would actually say it's because before this commit, the return handler
> > > > callers never called anything that the entry handlers didn't already call.
> > > > If there was recursion, the entry handler would catch it (and the entry
> > > > tells fgraph if the exit handler should be called).
> > > > 
> > > > The difference here is with fprobes, you can have the exit handler calling
> > > > functions that the entry handler does not, which exposes more cases where
> > > > recursion could happen.
> > > 
> > > so IIUC we have return kprobe multi probe on is_endbr and now we do:
> > > 	
> > > 	is_endbr()
> > > 	{ -> function_graph_enter_regs installs return probe
> > > 	  ...
> > > 	} -> __ftrace_return_to_handler
> > > 	       fprobe_return
> > > 	         kprobe_multi_link_exit_handler
> > > 	           is_endbr
> > > 		   { -> function_graph_enter_regs installs return probe
> > > 		     ...
> > > 		   } -> __ftrace_return_to_handler
> > > 		          fprobe_return
> > > 		            kprobe_multi_link_exit_handler
> > > 			      is_endbr
> > > 			      { -> function_graph_enter_regs installs return probe
> > > 			        ...
> > > 			      } -> __ftrace_return_to_handler
> > > 			           ... recursion
> > > 
> > > 
> > > with the fix:
> > > 
> > > 	is_endbr()
> > > 	{ -> function_graph_enter_regs installs return probe
> > > 	  ...
> > > 	} -> __ftrace_return_to_handler
> > > 	       fprobe_return
> > > 	         kprobe_multi_link_exit_handler
> > > 	           ...
> > > 	           is_endbr
> > > 		   { ->  function_graph_enter_regs
> > > 		           ftrace_test_recursion_trylock fails and we do NOT install return probe
> > >                      ...
> > > 		   }
> > > 
> > > 
> > > there's is_endbr call also in kprobe_multi_link_handler, but it won't
> > > trigger recursion, because function_graph_enter_regs already uses
> > > ftrace_test_recursion_trylock 
> > > 
> > > 
> > > if above is correct then the fix looks good to me
> > > 
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > Hi Jiri,
> > 
> > I found ftrace_test_recursion_trylock() allows one nest level, can you
> > make sure it is OK?

we have nesting check on the kprobe multi layer making sure
the bpf program will not nest into itself

  kprobe_multi_link_prog_run
    bpf_prog_active check


jirka

