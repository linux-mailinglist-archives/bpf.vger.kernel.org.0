Return-Path: <bpf+bounces-55178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBBBA795D6
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 21:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F34E188EBD6
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 19:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AFA1E7C0A;
	Wed,  2 Apr 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItTpXoo+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58599175D48;
	Wed,  2 Apr 2025 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621937; cv=none; b=SVR67uCDlVKA3rBtg6NjNIeRv5mgSoQxhDfyt/dtxL189bEzrnp9NHAPf1RIcOW69HT/kiVeN0VcBHA1L4J1KQS0pwqISSlfvpnUvCSMeOiqqEGsv2XoBv/7cqc2ZHeHGGqDu40QMtweORn2hv+cuIDaDN4nQIRFEKvYONMkZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621937; c=relaxed/simple;
	bh=ej1bUWBsuRw7RZa8MaA4KjRgioZePMmuY0FeQb+3F28=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa6k2jnG8sH5yWqTx2sGKkCGeByMPMhxElprPjVGeJ1XaUFHd5FtRBG9rqC7CmXszibvbrYgv2heWbCClLUkh1869iH777gTZazkHbDY+RB4D3BHJAqPsU10SlrAocgzCKs4iqw2dH3/pZXqtPHkfzkJhR3ZGphboqg7bacpzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItTpXoo+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso816935e9.1;
        Wed, 02 Apr 2025 12:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743621933; x=1744226733; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iR/24eGiQXTI3l3k6htvxnai/tmoU/Su7VysY9lW7Dc=;
        b=ItTpXoo+rkbk6a32OjQi9iSmJGMpkadPs+Mi30+UUHyifsswjfwhphil5I9QfEQoRT
         mr4rs9OuwaYQJyPjIlM8msCZGHEm1ItpNniVWndYCndXiw2I9z6pdm3X3QV3ReLSfJtf
         4HqZXVgMBX7mfnJH100FYp7edpK/kmM/ZzyL1G+CUaP1BZIl+1pcuDDFbPrb+juOW3tA
         3uoquH1dwt/seLBgOe/x8Hdn8gniYlMQo9igWo1pp16pVklG5ay0y2w9/lidrU/yQl8R
         VHa9lPBTYFcy+WiLMxNqYA2JlioFFkTRFW0ATy/dmzHcAzrXZuv/6t4qtO7LGHs6bT0Z
         VcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743621933; x=1744226733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iR/24eGiQXTI3l3k6htvxnai/tmoU/Su7VysY9lW7Dc=;
        b=DWizRGEktKYTX3Ox4LWi+RBL3bvLzUdbBlbV6x8N13X2mQxaXqX5xqnsYtcUdZ8w91
         ogVgTmV2+v40PSXXmiBzOKjxEJe5YOYZn6T66FIS6OrjBozt5JG0yXe9KI06SjVkXQL6
         UoUoeDXf74bLamL7TUTc+eg7ZIlKmNnqLen4KHpsdFqP2PzxKNr+mNVC48k+cUxUrDnG
         oUGN5G+NamLnlTQHDF/S5GzjMDiwI1guIpSX6596yG+itTsMhoRIAXJVGhydWYAx/ew5
         4+nX+tJvdPnjbVuHJlxvY9d9Av3cOP5PrXdUIgYiNjc1Luqzu8gw8ivv86kn+QY4zBva
         xbng==
X-Forwarded-Encrypted: i=1; AJvYcCVLnTuemuWWDJKqyVUaCA7pIlHIqZ9qs3JKFAY8BA/9AGTolI2/c/AO5oZ878Mj50gaslxe3VO0d2+nUeUSMhg+G/21@vger.kernel.org, AJvYcCVZ9kGwSI86DN7X7oXETQw76Zog0EicObsqrkOsVUhRnViihdWfu0/JPfcv5sow5Au6NV6gAyUC7B8eBzif@vger.kernel.org, AJvYcCWzv++G6gR9ZCIrJN+bXmIFo8woLmMIe3a1Dr+wNBq4xLGRwVMUedt+oNc4hW948P9D0zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTBS1X4O8HqEbHUiC4PsW8El+GWjmQikUH9XBwkotUe6F3qkJi
	BZ03UB4wQPgqfhyWEJcN7uSqd6xxGCQ91/6uKG75kHEAmGcgoCcp
X-Gm-Gg: ASbGnctX0xmqLXMGMsql8K3cooz/EzczA3buWOsIR+/dJjyQcCRjsL9S6dNzB9L2oqd
	OkUnoKfoixFNL32w3nSDOKC3r9Mf1DK7zHj0rA/Spv+pEFnWZCBcNkF0C38nibXRdRUk4ivsNGD
	vWX/4d4l85HkwWLykGOom7cKeSKKBcMQM92sIoVxyG6NrPmwrVnYDArrc7bR9PL0piODPcvGtXt
	NT3V3Mmu2BfpLGPNhsF2E6UvZYu6i2KYh0d7VGz0tGPjsF8y3b3DHXnREYx/GBR/fDzAUCxgIhr
	zLkCtGBOUfYwsqZi7nDDtXpqA1z6E6lbBLT0fkU+eg==
X-Google-Smtp-Source: AGHT+IF9KnT7M8WAsGh614hoSpdPQS7E6gWfXTYWOSBlx0LYy8oc/2MxXGQ90VSTtdXsY5oEEUjcOQ==
X-Received: by 2002:a05:600c:4747:b0:43d:82c:2b23 with SMTP id 5b1f17b1804b1-43db62b726amr147915355e9.23.1743621933261;
        Wed, 02 Apr 2025 12:25:33 -0700 (PDT)
Received: from krava ([173.38.220.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb5fc1b81sm30282045e9.5.2025.04.02.12.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 12:25:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Apr 2025 21:25:31 +0200
To: Jiri Olsa <olsajiri@gmail.com>, Timo Beckers <timo@isovalent.com>
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
Message-ID: <Z-2PKwmGtPktqiFR@krava>
References: <20250331094745.336010-1-chen.dylane@linux.dev>
 <20250331094745.336010-2-chen.dylane@linux.dev>
 <Z-vH_HiJhR3cwLhF@krava>
 <918395a6-122c-4fb0-9761-892b8020b95e@linux.dev>
 <CAEf4BzbOirQiAmowckX8OeiFUTR8yfkO6m+kY96VMy5f9rG26A@mail.gmail.com>
 <Z-z8_HlpMk39SHUD@krava>
 <Z-2N0Z6UxVx7mpYp@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-2N0Z6UxVx7mpYp@krava>

On Wed, Apr 02, 2025 at 09:19:45PM +0200, Jiri Olsa wrote:
> On Wed, Apr 02, 2025 at 11:01:48AM +0200, Jiri Olsa wrote:
> > On Tue, Apr 01, 2025 at 03:06:22PM -0700, Andrii Nakryiko wrote:
> > > On Tue, Apr 1, 2025 at 5:40 AM Tao Chen <chen.dylane@linux.dev> wrote:
> > > >
> > > > 在 2025/4/1 19:03, Jiri Olsa 写道:
> > > > > On Mon, Mar 31, 2025 at 05:47:45PM +0800, Tao Chen wrote:
> > > > >> The target_fd and flags in link_create no used in multi_uprobe
> > > > >> , return -EINVAL if they assigned, keep it same as other link
> > > > >> attach apis.
> > > > >>
> > > > >> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> > > > >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > > > >> ---
> > > > >>   kernel/trace/bpf_trace.c | 3 +++
> > > > >>   1 file changed, 3 insertions(+)
> > > > >>
> > > > >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > >> index 2f206a2a2..f7ebf17e3 100644
> > > > >> --- a/kernel/trace/bpf_trace.c
> > > > >> +++ b/kernel/trace/bpf_trace.c
> > > > >> @@ -3385,6 +3385,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> > > > >>      if (sizeof(u64) != sizeof(void *))
> > > > >>              return -EOPNOTSUPP;
> > > > >>
> > > > >> +    if (attr->link_create.target_fd || attr->link_create.flags)
> > > > >> +            return -EINVAL;
> > > > >
> > > > > I think the CI is failing because usdt code does uprobe multi detection
> > > > > with target_fd = -1 and it fails and perf-uprobe fallback will fail on
> > > > > not having enough file descriptors
> > > > >
> > > >
> > > > Hi jiri
> > > >
> > > > As you said, i found it, thanks.
> > > >
> > > > static int probe_uprobe_multi_link(int token_fd)
> > > > {
> > > >          LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
> > > >                  .expected_attach_type = BPF_TRACE_UPROBE_MULTI,
> > > >                  .token_fd = token_fd,
> > > >                  .prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
> > > >          );
> > > >          LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> > > >          struct bpf_insn insns[] = {
> > > >                  BPF_MOV64_IMM(BPF_REG_0, 0),
> > > >                  BPF_EXIT_INSN(),
> > > >          };
> > > >          int prog_fd, link_fd, err;
> > > >          unsigned long offset = 0;
> > > >
> > > >          prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
> > > >                                  insns, ARRAY_SIZE(insns), &load_opts);
> > > >          if (prog_fd < 0)
> > > >                  return -errno;
> > > >
> > > >          /* Creating uprobe in '/' binary should fail with -EBADF. */
> > > >          link_opts.uprobe_multi.path = "/";
> > > >          link_opts.uprobe_multi.offsets = &offset;
> > > >          link_opts.uprobe_multi.cnt = 1;
> > > >
> > > >          link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI,
> > > > &link_opts);
> > > >
> > > > > but I think at this stage we will brake some user apps by introducing
> > > > > this check, link ebpf go library, which passes 0
> > > > >
> > > >
> > > > So is it ok just check the flags?
> > > 
> > > good catch, Jiri! Yep, let's validate just flags?
> > 
> > I think so.. I'll test that with ebpf/go to make sure we are safe
> > at least there ;-) I'll let you know
> 
> sorry, got stuck.. link_create.flags are initialized to zero,
> so I think flags check should be fine (at least for ebpf/go)

sry forgot.. adding Timo to the loop (ebpf/go)

jirka

