Return-Path: <bpf+bounces-72689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ADFC18ABA
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 08:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B461C871CE
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5731196D;
	Wed, 29 Oct 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCaoo3sf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08D311959
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722231; cv=none; b=eEW4vrriJOIHtE5dQMRAjZ1aYjaexWhJibGFfnFewlszy7mwDev0DYRUedUHPKQ6BZEtdi/ctXSJSiCX61W40GR0Zv3e9n5mn5KrrabKae/eZmVaguxprXccz+FqzSIJJT1KS6ReYs96F24dWdob1nhSvMMAeLoC88p97sE6iUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722231; c=relaxed/simple;
	bh=Alikw8zU+RHR/VW1Sf1dHQ7s7eeYdPHAeuE6O8+xV6Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFutppmbRZEliYFXGpdKxevKKi5lDtGdw/j+uR0dFfgAc1fRC7c00XHjHkltnK9yRsd25E3+hiC6cFjRn+IMLRLgtiTNN/ngl9BHvNSwxzkU6SDw1OexKaaJqJW2DRByUY44IuKmtgC0t2JRlpkcWoPiR0SXmUa/hhJDgt54fuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCaoo3sf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so6482600f8f.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761722228; x=1762327028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANikBWzjiXtO/iPDXPdp+kNg//oko4JK3XBqiWoU92c=;
        b=JCaoo3sf0l3DUJw/GViMnml3xde66o8dDvdu/EnSuNHqvEIOQrq3OTlqWmuNdSFRH/
         +OPQgIDtoez9PgVPaRiupJ39ZIOVpspXf+d9RIaovJwDVbGbjgd7gZU60VsYJMvlxs1J
         +Hi+KIDjzJ6VQxGL4//cZ6v70dC+e6+Uny+ZCXLFAaT+5At//t8obgvS376C3t0C6S3U
         tW81Q20shmk4F2l6FVdy7vwG0S/3dx/4CtA8NOlUsrDGL+DzLkATWU/ubeVniXv0TCh5
         e9l8QYKbsdEcgHmgUXcpGXxRpfHmQ+OiiNxnhOTIKF9y+MpkRFHFu+KD4dFb250QIIHX
         UihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722228; x=1762327028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANikBWzjiXtO/iPDXPdp+kNg//oko4JK3XBqiWoU92c=;
        b=NLFEWD4wviO53f4k+I5rlqBXg2IWNCcJCymFqDZLVHh2zht8smUQrWc6tdwslAdFUU
         o0O4RfWAD0XJw9dNs1sn2uJPTw9A1Nuq8vy5wG4ymlLoFTI7raneuXjUZYC3uG/B/pF3
         jWX/XttKm4TZ18X4AWs5B17ujC1kVAAlAlsnC9NGm3nI3ugHgn8q5wDX4CdAeXrdYyPb
         MXCo5Tg3mZOc1HqpfuqG4tvmKGZtB6CiBEqGotRzZiJI1rRiHnCUOVWAwZMi/CFrzQf+
         lGLaKpeqnxXhe6AFEUCCSmyV2IYA456+BazeBZ+Yv3ylwOznApsLP9REtreu+Qu75BGk
         fuGg==
X-Forwarded-Encrypted: i=1; AJvYcCWJQlmF8jx4JvnGyGRhj8djpqb4BJZeL7LvlABJA4X1LRlBbQPBjO3UywNfbj97SC5UbGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCHQ5imNdrApgeHeyPIN6gvtb3qkXClQ2a3iII78chvl1i0mk
	+FYvt2hJcyHj6mteFv9HSiBkRBmHsh5f1iZAWpXgoJnfOD+p1chI87Th
X-Gm-Gg: ASbGncvGavyx5aye5WM/v6O2qgYa0YoUnFgJsIVHAibVBgVp6PR5nF0da66jiC6PRNU
	z96jSkpQkZXfz3wRHxKEtnOloimqE1BIqA5pzTdC9lqm+pkcVGIFda8q60fuiqeCtn+3zhgVeCc
	ED0AUGukI90MIGpmFLShHaA3qZKEXG/NDaSTJPEJ5z3bno7UF4/0nRZV+y6PX89pWucWIq5yu8e
	BqvNNfFXLhRI6QRk4S2rTg5k628Mse+Ki28LR7AEAAiwrYi/zaJg9e68YjCetreaqHgnOL32fGe
	bnE+joUg/asO1snqe6XGXdIWDh4FKpYstww+KSA2+RfmrNjG526umKetCFg/KuIxbMbyCTmiZC7
	/LIoFpmewmMrOyP/tfRnkc0pNr3aXZmhPKX0/F1M5hqSbfjp+uQ==
X-Google-Smtp-Source: AGHT+IH4p1yq4zEhj2eqFa0BCgJSpxFayT0Gt74ozNY+K0O0sM8HKFMIYGpClVlqn1Aonb1DcOa74w==
X-Received: by 2002:a05:6000:1446:b0:426:ff2f:9c15 with SMTP id ffacd0b85a97d-429aef735eamr1737371f8f.5.1761722227880;
        Wed, 29 Oct 2025 00:17:07 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a7csm24793511f8f.8.2025.10.29.00.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:17:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 Oct 2025 08:17:05 +0100
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, bot+bpf-ci@kernel.org,
	mhiramat@kernel.org, rostedt@goodmis.org, song@kernel.org,
	peterz@infradead.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
	songliubraving@fb.com, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in
 perf_callchain_kernel()"
Message-ID: <aQG_calHM0E7ou67@krava>
References: <20251027131354.1984006-2-jolsa@kernel.org>
 <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>
 <v53j2leswscyunqmrj5zvr3bsdafxlze5z3yp4hvsd6epbvdvm@njx4yhpkqoiz>
 <aP_0eh7TH2f_ykhz@krava>
 <xnx66p7w3qstst4ixj356dnzexrpsjy52tfwthp5kytv5yagcf@4ngtq5rrgqzj>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xnx66p7w3qstst4ixj356dnzexrpsjy52tfwthp5kytv5yagcf@4ngtq5rrgqzj>

On Tue, Oct 28, 2025 at 08:39:33PM -0700, Josh Poimboeuf wrote:
> On Mon, Oct 27, 2025 at 11:38:50PM +0100, Jiri Olsa wrote:
> > On Mon, Oct 27, 2025 at 01:19:52PM -0700, Josh Poimboeuf wrote:
> > > On Mon, Oct 27, 2025 at 01:52:18PM +0000, bot+bpf-ci@kernel.org wrote:
> > > > Does this revert re-introduce the BPF selftest failure that was fixed in
> > > > 2019? The test tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> > > > still exists in the kernel tree.
> > > 
> > > I have the same question.  And note there may be subtle differences
> > > between the frame pointer and ORC unwinders.  The testcase would need to
> > > pass for both.
> > 
> > as I wrote in the other email that test does not check ips directly,
> > it just compare stacks taken from bpf_get_stackid and bpf_get_stack
> > helpers.. so it passes for both orc and frame pointer unwinder
> 
> Ok.  So the original fix wasn't actually a fix at all?  It would be good
> to understand that and mention it in the commit log.  Otherwise it's not
> clear why it's ok to revert a fix with no real explanation.

I think it was a fix when it was pushed 6 years ago, but some
unwind change along that time made it redundant, I'll try to
find what the change was

jirka

