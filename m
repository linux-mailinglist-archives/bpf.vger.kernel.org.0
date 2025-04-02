Return-Path: <bpf+bounces-55177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98688A795CA
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 21:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DE516F0AA
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E31E5B95;
	Wed,  2 Apr 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP5ZkV6f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F081442F4;
	Wed,  2 Apr 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621592; cv=none; b=tuOC0SH93M9wN+fdgahDx/YRqQUB1yiirjnOfLJFi4D1cwl7weN7E2EezmoTAddGIRP/RzzTQyF8redPJ2tHvUXplLALM29u0ajDPP313l1QTz7lXBnf/BUE7Wf+I6Dv4McimjapGHupjBf1sOWpWYcfZ5EZvP3d4aNmu8djjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621592; c=relaxed/simple;
	bh=5dCJTV7MJQ9vS48OjZJPdGMuhje4qjq2u96/Hv7bC5s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLDisSHqMxcaoGniPwGEv91mL9YqIVXQtlXURgz5nA4NBNWhir3cFMym8bSQIiCOtUszUm0h4q2hNqJ9OSVzlYb0yX7wjouao2k03DnywWReElsgrFd14CaTYJt+k6zLAjDfqW00WVxRwgRDqFoB3C2Lvsmcp+rgqHthBNazo4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EP5ZkV6f; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so107607f8f.1;
        Wed, 02 Apr 2025 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743621589; x=1744226389; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RahRZ7vaJa/8FYkhEaHWhZlX3tAdZhEONr4B6jgVA5I=;
        b=EP5ZkV6fEOUXDFb1kgBwyCOI65Eg1GoMlmHRssLFfAKRevrjreOXWHVrWz5yHTc6Ts
         zo10rSITRVxSAkSY0EnLxVRNlbJVd1dzvj2lNCmhY0gOWr5tpV6LpAWteB6wK2bNVR0z
         /aa8GUBkmdWO3kag1mBhSfeIKl/cIQ+ODXI001RUqm1FUOx1cFrDj6LfMMrTb8Ph6Ue1
         TTj1150bmR4vL7fwNNuZlm6CTU1VSClFHqrFk1ulL5voxCUJUF5PkVNq/UtvdwxotHAX
         mxfmgph6EVOFNb4REgill2g9gmxHgL3IC3ccSdhxVjxlfwRg6Nr7A3PeNyZjYAqmmGMi
         fPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743621589; x=1744226389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RahRZ7vaJa/8FYkhEaHWhZlX3tAdZhEONr4B6jgVA5I=;
        b=IkC/yeSGSHnxT27GLvl6guOb3XJShgX1tYEebOYizlKWHj2w3jMghpCs81RK8PrDft
         H0lXjbFAnAYVOAeweVoAjFG3ctOfU9yMP6GXaU9NsPUmrR6xOzliC9zoWc3VmJnBEicE
         aSeaaUdRFM4QaDT8kuJtuk40SmMj5D5TqCZQl/zzHPNILx5MdiYQ8KK8w7yEUqqzjQ/9
         u5KHsXryLZAGjJ56MDCZDi/mgNgkPRj9igjdUopKE/V4b84LnTdVm8V/b7q8fHX07PCo
         L9gs6RTwX3zd4y7dGFISEo3e3+mwjIwctJhXqlm/lXay/cu021nQy6642lIBxVJphX6Z
         JyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX8uBpzRcjcwvJLKb9PDr1ZJweN00FpNO0qSBwApvocDjaTSfCshgO4J1YcQToC3R6ilBVt2iohT15+cBdqpILEtcQ@vger.kernel.org, AJvYcCXAj4BzPhgf/3XW1cnSRfp6GvxAD/yAYdYr3ZwbAcbOcXNhCm48F3AJFpLlGWKfpTO3vH8=@vger.kernel.org, AJvYcCXyBKU5uidyHpfH9zG90/nLz1+u0dhmTJ/6hgpNRt21eAdTl2paCX19A+5nWqFW6FzmhVFpRmxVEvCF0uF4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7OuewdbUxzNVTINqie5mo2I3A7eE2yB8JSLvCqoehG6JmUEtr
	AoYpOiGQKVAuG5MIVQNuLnISU9mEmODQ918+4M8eTxDpKaRLnVNA
X-Gm-Gg: ASbGnctZlbnM/Buds/One7OR9rMmZUYBKaKG+J7VkzxoyC0fCBdkny/ua8TMlnVFSip
	NH18j58sPV8HelS84TB+PelYo8qgd2jl7Q5c3BG6Lxj49GR+CrS41S8WMarZEd90ZPTdsPpiU0N
	L8usM5W5gKYFw7ec0UsuINSug1+hq9T/wPUKJ984G4NBW9ZROo+IDCCNjAChfIl+nzQYUvlPrBb
	gVufuajxod9s876gCJTw+vK6NS47w/ECBPTMcPzBo7FG3o9cgNICGpklwoT2LRHKQMK+j3zO1Rs
	DXe0NYuZmOfiiBw0EHhJ4piZkS5w/mo=
X-Google-Smtp-Source: AGHT+IHJ/q67EMVRx0vVkEYpfKe1lCXpKlpmCn0IK9TKv4Nh6zyWEQIyZ1cleR8XRSVJGlSWSqVdaQ==
X-Received: by 2002:a05:6000:2907:b0:39a:d32c:fb5e with SMTP id ffacd0b85a97d-39c297530f2mr3596885f8f.21.1743621588989;
        Wed, 02 Apr 2025 12:19:48 -0700 (PDT)
Received: from krava ([173.38.220.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a422dsm18016034f8f.93.2025.04.02.12.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 12:19:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Apr 2025 21:19:45 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Tao Chen <chen.dylane@linux.dev>, song@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, laoar.shao@gmail.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf: Check link_create parameter for
 multi_uprobe
Message-ID: <Z-2N0Z6UxVx7mpYp@krava>
References: <20250331094745.336010-1-chen.dylane@linux.dev>
 <20250331094745.336010-2-chen.dylane@linux.dev>
 <Z-vH_HiJhR3cwLhF@krava>
 <918395a6-122c-4fb0-9761-892b8020b95e@linux.dev>
 <CAEf4BzbOirQiAmowckX8OeiFUTR8yfkO6m+kY96VMy5f9rG26A@mail.gmail.com>
 <Z-z8_HlpMk39SHUD@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-z8_HlpMk39SHUD@krava>

On Wed, Apr 02, 2025 at 11:01:48AM +0200, Jiri Olsa wrote:
> On Tue, Apr 01, 2025 at 03:06:22PM -0700, Andrii Nakryiko wrote:
> > On Tue, Apr 1, 2025 at 5:40 AM Tao Chen <chen.dylane@linux.dev> wrote:
> > >
> > > 在 2025/4/1 19:03, Jiri Olsa 写道:
> > > > On Mon, Mar 31, 2025 at 05:47:45PM +0800, Tao Chen wrote:
> > > >> The target_fd and flags in link_create no used in multi_uprobe
> > > >> , return -EINVAL if they assigned, keep it same as other link
> > > >> attach apis.
> > > >>
> > > >> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> > > >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > > >> ---
> > > >>   kernel/trace/bpf_trace.c | 3 +++
> > > >>   1 file changed, 3 insertions(+)
> > > >>
> > > >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > >> index 2f206a2a2..f7ebf17e3 100644
> > > >> --- a/kernel/trace/bpf_trace.c
> > > >> +++ b/kernel/trace/bpf_trace.c
> > > >> @@ -3385,6 +3385,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> > > >>      if (sizeof(u64) != sizeof(void *))
> > > >>              return -EOPNOTSUPP;
> > > >>
> > > >> +    if (attr->link_create.target_fd || attr->link_create.flags)
> > > >> +            return -EINVAL;
> > > >
> > > > I think the CI is failing because usdt code does uprobe multi detection
> > > > with target_fd = -1 and it fails and perf-uprobe fallback will fail on
> > > > not having enough file descriptors
> > > >
> > >
> > > Hi jiri
> > >
> > > As you said, i found it, thanks.
> > >
> > > static int probe_uprobe_multi_link(int token_fd)
> > > {
> > >          LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
> > >                  .expected_attach_type = BPF_TRACE_UPROBE_MULTI,
> > >                  .token_fd = token_fd,
> > >                  .prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
> > >          );
> > >          LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> > >          struct bpf_insn insns[] = {
> > >                  BPF_MOV64_IMM(BPF_REG_0, 0),
> > >                  BPF_EXIT_INSN(),
> > >          };
> > >          int prog_fd, link_fd, err;
> > >          unsigned long offset = 0;
> > >
> > >          prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
> > >                                  insns, ARRAY_SIZE(insns), &load_opts);
> > >          if (prog_fd < 0)
> > >                  return -errno;
> > >
> > >          /* Creating uprobe in '/' binary should fail with -EBADF. */
> > >          link_opts.uprobe_multi.path = "/";
> > >          link_opts.uprobe_multi.offsets = &offset;
> > >          link_opts.uprobe_multi.cnt = 1;
> > >
> > >          link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI,
> > > &link_opts);
> > >
> > > > but I think at this stage we will brake some user apps by introducing
> > > > this check, link ebpf go library, which passes 0
> > > >
> > >
> > > So is it ok just check the flags?
> > 
> > good catch, Jiri! Yep, let's validate just flags?
> 
> I think so.. I'll test that with ebpf/go to make sure we are safe
> at least there ;-) I'll let you know

sorry, got stuck.. link_create.flags are initialized to zero,
so I think flags check should be fine (at least for ebpf/go)

jirka

