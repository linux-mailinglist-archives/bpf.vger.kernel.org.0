Return-Path: <bpf+bounces-32920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A41914FDE
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 16:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1376C1F23A16
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549E144D37;
	Mon, 24 Jun 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NZ0cLHPC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934B14D294
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239141; cv=none; b=bejQ+7ENua2Z3bodXWUN0dmwRxuBmMW/IXXh2cI9g/g8o1DJexIfriW8ShCGs2NEsfLZ2aKm/VakiqEeIgrUIo1YGWQcbnFUSM/lyQLMBgo4M8redmSPJgog81eQAfjvEKhot4GSRtJyHoijhKTZEdUN5htxJv7P2rhe1VTejEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239141; c=relaxed/simple;
	bh=9w+SgEUo4YzWwo55bCoro5vgsSv1CzIfvImz5JftMI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLfjDp+31jEXA0IFH/C9D1LVEXqnAM8Ya+uJ/6VxnQXdTQoR+tuWNIPHrZzFBsGCNs0k3VKY4467wVaLzKIP9sliD90ir9TSJQUh+be7uNmkmkzgBkFeewsgErk3Z8wWBBPIbA/wXmXCgzueZqUvW8GmBjp2fQnlkK6l0O2UxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NZ0cLHPC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cb9efd8d1so8753556a12.0
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719239137; x=1719843937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+/9kohSBG4FdkY1BWlsZbiSjgCXQ3rr1u7yY2MmJjbM=;
        b=NZ0cLHPCWVuWQ0L3w3KAYN8Cq/Tfktd7cQy4aQzd8mb+6gjeYpYywNXfePC6/u/3Jz
         kMUhi3sKlsR4QSwnTQREyD0rnmaJBvSib6ZQZXE62TWAKtWaPfuf01FgmWje9oU0UXl2
         7KywcBHQ5MT9egRZqXkr/MJicAzS4jtcZiIms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719239137; x=1719843937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/9kohSBG4FdkY1BWlsZbiSjgCXQ3rr1u7yY2MmJjbM=;
        b=xMDYzITeyiYADxbq8sJXpTgFO01hv7bX73oj7vT+xP1mVyPQaSEL3A+eSBmH/6vXHz
         3Ve+cAkJb/igCGGPcsMkUdDbyr/90gjRZMsfMawLOKZ0llKFdYxobtAAgCTk3pFJdoXi
         O1MFF0hnu5rUhmBA/rRRr6Fxd7g5yMz+g+CsG2PmKWqbT2xC7ZdmXL3TyrbqaPmRWgoi
         IdEumLu3Vn5P2/u3V+Bgc7f2dKps3YDM1PIFxnmfxmoHai412Zq6bfCArEDRLnh3qEyu
         MxSLf1k7BxTIKSuSeyy8djtNU0T/nBVo+jLOfOOS6UktzvSx0GIaLctEz5pykrFVn0LV
         Pc9w==
X-Forwarded-Encrypted: i=1; AJvYcCVlLOdmv3medRHvi4VBYkenVSCF3yz+Qjgbh1FKzN3Wx5WoP1QxKRgbvmcrR25PGK6faHa6qt0V/opVMavZ71FZrVN6
X-Gm-Message-State: AOJu0Yx7fq5EW+eKZKlhxzpC87UanUhuVjKkdSmfNhMOMXS8TkCfRrhF
	NXeMAOJwhWeJyB5aII4sLTrW4V/czEPSa9HrzggmA6wLW3sjqt6bJjIS0eGiVidwc3GErk1TTdK
	3KU77CA==
X-Google-Smtp-Source: AGHT+IFZpWtGzIE38yyiN3SwWFkjtxvuzrjOiJTt9FI6SpPEpUW/wZHBVMff3zqEIljkNRL4HKi1rg==
X-Received: by 2002:a17:906:3bd7:b0:a6f:e823:64d8 with SMTP id a640c23a62f3a-a6ffe3ce9f0mr462422766b.20.1719239137611;
        Mon, 24 Jun 2024 07:25:37 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fd0838345sm408067266b.99.2024.06.24.07.25.37
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 07:25:37 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a725d756d41so102008166b.0
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 07:25:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWb18hc2WUstcdVz/BQmbDR9upoopr3kl82NMg9gwV/o7bdQhBkUyBYbVYSR6m4KZGUev8znz9LxLB9fnDn01HeerL9
X-Received: by 2002:a17:906:d103:b0:a6f:6f98:e3dc with SMTP id
 a640c23a62f3a-a6ffe39c94fmr534258666b.10.1719239116553; Mon, 24 Jun 2024
 07:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501151312.635565-1-tj@kernel.org> <20240501151312.635565-20-tj@kernel.org>
 <20240624124618.GO31592@noisy.programming.kicks-ass.net>
In-Reply-To: <20240624124618.GO31592@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Jun 2024 10:25:00 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjWaMPF7d=BDicVk_+DcYYf5tfKbuK+_Mi4QvNmyeKS1Q@mail.gmail.com>
Message-ID: <CAHk-=wjWaMPF7d=BDicVk_+DcYYf5tfKbuK+_Mi4QvNmyeKS1Q@mail.gmail.com>
Subject: Re: [PATCH 19/39] sched_ext: Print sched_ext info when dumping stack
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 08:46, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Also, if we consider 2s complement, does the above actually make sense?

jiffies_to_msecs() does not work on 2s complement. It just takes
'unsigned long', and just considers large positive numbers to be
exactly that - not a negative jiffy.

We have a separate jiffies_delta_to_msecs(), but that clamps to zero.
So again, it doesn't actually work for negative jiffies.

Side note: jiffies_to_msecs() seems to return an "unsigned int". That
seems a bit odd.

             Linus

