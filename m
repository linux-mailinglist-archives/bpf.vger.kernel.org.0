Return-Path: <bpf+bounces-40255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC6598444D
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 13:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCAA281C10
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F101A4F1A;
	Tue, 24 Sep 2024 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmjMwbKR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439BD1A4F0C
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176419; cv=none; b=syQ2tJj2k12XznoaS663nONROHXh4vuHxqbbTeWuMQlM08Rv9R6GSrBgczXJrK+x7g9hdU5AkOmjeoACJUwJfgn1mNWZYQxogOZMABU4kLe6wHsDlrDAAwzXtyYj21uhwMDC4QB0JE7lgWIiAB2Gr6hFgQWgKQ0x9c5MNN2hcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176419; c=relaxed/simple;
	bh=1utVeLe28r/rkR5lS+VlI9lQg8NLncBUFW9yR9l8MfA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+oykebRSSNS4Gv8H0WlsmTPhuPRpKCwcSiV+1bbtgAjE+EEaDLChbGuWu8v9VqWw76A7+6clYz71CwaXNck/cm4UK2qpLC7hvlInVL/rns7GK03PFQrd1HHwRcaPvziX9fUPAZjNlvdugCIbecQqiRmGA7nPy1Z4mzQLlMSgjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmjMwbKR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso49922125e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727176415; x=1727781215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PKgCQZeRX9zMqgMXO/bQGaBbBf7as1dZ12drLoyXWWM=;
        b=DmjMwbKRWFjMcRUu0xPBs8WF5qqSeFtn4OklpGSqtTmThghc/Gckw0wgnH0HSG19lx
         wuSy4AeVeytvwiipIcEGVnYCGA0+u/+fq7pvTfsxL76RaPuBilYNZoD+FN+HsmXDVO4W
         GbUGHfvRnhtVAmKeLhmTCwg0uzUg7trQABm9bTL6i4R75wpmHskQsO+tD2Lw569TlV5n
         g3Cq2PiQATWAsvrhmLBbNBGMORGn6FuguhT4Po7GFFrovIU7iwN6LDCaoCsFcmewIWgE
         kn9uhGmaiBKNbQK2QqaLfSKbqBDKoH4S0fT6aAQnOkyq5uf1gU0tL9UzxxGn0P3IBbWD
         o9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176415; x=1727781215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKgCQZeRX9zMqgMXO/bQGaBbBf7as1dZ12drLoyXWWM=;
        b=NXltYcJiFNQPkTsN94JZCLFLuujMrMfjqI9IzBBoE2CkxSSmDmewXy93FgASvb4h6C
         W/Wu+CxpXlAaPpogVTmIrBPiUN3jRmHp1o60OZCBgZddNaxwMzDfiyGnrwt5MiA/3EpT
         yRfwhuzSfehGiBPNLBM5QYBj9ToThNji4E2HURWtbX7Xb6eZdxV+QIiJ0NDDnovf2Jjb
         sL+YVasYbikS4yLULDJ8gIyiSc9qeh5kKUshl3+IBYK8vgI7LKhsH3VKpxvy+lSR/ie9
         VOf2Ro+daMa9UFwuOkt1GHJnpgVQBEbnbdgPHu/Z/Sug5iMSAQ28t6HION/00T1Lk9Mn
         mbrg==
X-Forwarded-Encrypted: i=1; AJvYcCVBnSejcjjsaCl6AploEHikP+z8F/ctdAhsuI85t8+BJ83IynFEvStgR7aVa7MB02MU4ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2zAKy6lFjiY4WSILBBAf4eAzH8gf3eNwDHbRstF3ve1x61qZ
	P4UXYzbVJVMmW6IDjc30AcMPbU/8k82uNFTgdx5z0GODgwCE+kQa
X-Google-Smtp-Source: AGHT+IEMrZ3StDmHecvDqGMKYYk2ydAN3bcXMWPhNKlJOwSillFl9FPbUslySBP7siZVrxd6zqBz2Q==
X-Received: by 2002:a05:600c:5246:b0:42c:ba1f:5452 with SMTP id 5b1f17b1804b1-42e7ad87fc4mr122222395e9.25.1727176415136;
        Tue, 24 Sep 2024 04:13:35 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e902b681esm18721715e9.37.2024.09.24.04.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 04:13:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Sep 2024 13:13:32 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCHv3 bpf-next 2/2] selftests/bpf: Add uprobe multi consumers
 test
Message-ID: <ZvKe3LGtJP5Otvrn@krava>
References: <20240722202758.3889061-1-jolsa@kernel.org>
 <20240722202758.3889061-3-jolsa@kernel.org>
 <w6U8Z9fdhjnkSp2UaFaV1fGqJXvfLEtDKEUyGDkwmoruDJ_AgF_c0FFhrkeKW18OqiP-05s9yDKiT6X-Ns-avN_ABf0dcUkXqbSJN1TQSXo=@pm.me>
 <CAEf4Bzb2dTK0jgc69O9Ouu3=5qeTT=RMAa3Na3V7LztN6y8bUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb2dTK0jgc69O9Ouu3=5qeTT=RMAa3Na3V7LztN6y8bUw@mail.gmail.com>

On Tue, Sep 24, 2024 at 07:44:50AM +0200, Andrii Nakryiko wrote:

SNIP

> > > + /
> > > + * uprobe return is tricky ;-)
> > > + *
> > > + * to trigger uretprobe consumer, the uretprobe needs to be installed,
> > > + * which means one of the 'return' uprobes was alive when probe was hit:
> > > + *
> > > + * idxs: 2/3 uprobe return in 'installed' mask
> > > + *
> > > + * in addition if 'after' state removes everything that was installed in
> > > + * 'before' state, then uprobe kernel object goes away and return uprobe
> > > + * is not installed and we won't hit it even if it's in 'after' state.
> > > + */
> > > + unsigned long had_uretprobes = before & 0b1100; // is uretprobe installed
> > > + unsigned long probe_preserved = before & after; // did uprobe go away
> > > +
> > > + if (had_uretprobes && probe_preserved && test_bit(idx, after))
> > > + val++;
> > > + fmt = "idx 2/3: uretprobe";
> > > + }
> >
> > Jiri, Andrii,
> >
> > This test case started failing since upstream got merged into bpf-next,
> > starting from commit https://git.kernel.org/bpf/bpf-next/c/440b65232829

thanks for the report

SNIP

> 
> Thanks for the mitigation! I think this is due to my recent RCU and
> refcounting changes to uprobes/uretprobes, which went through
> tip/perf/core initially. And now that tip and bpf-next trees
> converged, this condition:
> 
>   > unsigned long probe_preserved = before & after; // did uprobe go away
> 
> is no longer correct, and uretprobe can be activated if there was
> *any* uretprobe installed before.
> 
> So the test needs adjustment, but I don't think anything really broke.
> I don't remember exactly (and given the conferencing schedule and
> quite bad internet can't test quickly), but I think the condition
> should now be:
> 
> unsigned long probe_preserved = after & 0x1100;
> 
> (though we might want to also rename the variable to be a bit more
> meaningful now).
> 
> Anyways, I don't think this is critical and we can address this later.
> But if anyone is willing to send a fix, I'd appreciate it, of course!

I think we can remove that check completely.. I sent the patch, let's discuss there ;-)

thanks,
jirka

