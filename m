Return-Path: <bpf+bounces-77359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 298BCCD8DE4
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 11:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D91F83084C0B
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF236C0BA;
	Tue, 23 Dec 2025 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSMs9SSV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE836C0B5
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484742; cv=none; b=IEuHao//NuryXychqSUUq9cYRxIRSOhPoZIHu2irBpbsuV9spVUFl3eJeXpsRbYUAVcx/mZmKDS6pQSR6HFJMpSgINoWodPZg8jUrlFO6MyxYV5pRTG9YKDhiwBxS2cv7YBkjJzI2Bx3F5f6CJpUdVvHbEPqjQ4aYcGpwzPhDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484742; c=relaxed/simple;
	bh=g3RdVNlGYQsE9o3BJOWFY+ldO2vNI7M9wdBKHzxIiWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQmVbR1yP/EtJ+VQee0Bqh6pdMCOYFC7TFglrHMLdg5FMQoIV2rHJw3cBuTh2KzBpmb0MsZbI+hn6ByErvj7MwxwDz4TciyMVtNNcMRfx7Bg7haLmN5AvuNUCo9Hv8ZL/2lJIIdz3KeFs0rlDAK3JI9twH1Fy85UoZRkA+nuEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSMs9SSV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so3773084f8f.1
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 02:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766484739; x=1767089539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anQax0wUu95+mMrZNKTBO4oREmZDSkR5WTX6a+bS3Kc=;
        b=aSMs9SSVZ/8+kW3cH6yg4Qwf5oUu9hnkkAguWizlbMQFLKfhK6+RUM1Y7EAkdjRAEn
         5uxiQHPw9B+wqcBHsY8ZnY0aAdHlayZtDPK9vHa3sggZuSRV8JnuYFo1A78sJ31UCPvq
         p33fEcQMJWUSCPcxsmbbksGn+fFhZKfOJsmlUWTzVn7kk1W3CGcxoM+gv12PYTUrhMLN
         N7y3BURAxVXkzU0vTb3yvFc8LlRT+8rpY/dYc56Did3qC6aKmghd2EFcFV3qtBTQM2Vu
         ZGA9kKaY6Cx1U1hwwiYH9Q5BXe8+RpeQ4m95yvjWxt1k9+k+EkoiS8xjWAITbaG8qZKE
         M8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766484739; x=1767089539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anQax0wUu95+mMrZNKTBO4oREmZDSkR5WTX6a+bS3Kc=;
        b=cL6xlCNDOK5QHdXJ+gpMxy2cgfprHSxOWwzGLyGGKNKus95vhbvtHgafqzMoeYZSIN
         vsFbSYJ30lRK7RrWNF0rOER1iTkrrdZ8t2930Ph0q9H35sRLaF18DuElDGdkEuRa92wU
         IIpfbIe+x2xqqcX+dJXgaaDuPkXRYpy3yDQiWXJzV1HaGqrMHCl7Z1+O8z5CQ8tBuFR7
         ugYyqSDQSex0FAAnodqdIOJS2BHZJ31FHPlbWHJD7UYpu68SOPl0XbPrVIdoA5VXCpBm
         DtsXbnX6yoBWlllncF+4kEa7Y/zOobUG9H1UEc/sc70qhEjIRd1hKkrBF49V+tCK1aFj
         VRlw==
X-Gm-Message-State: AOJu0Ywl2QUrdoJYfpx0PbqQE2W00DwKSXXp8QfCSPhK9/xk5lZ7Zon1
	yvnDjQfx5Rq1339NhH5ph5jMljWBaFUKMAhkIX8g+61+2KSDabfITRRg
X-Gm-Gg: AY/fxX6b8iPw7mf6jSj0k3qqx3irLMrOrPFdQ3j6Ussw3MyckYyE126R/aRJt6x1I/0
	mY7dGghuCQlrU5rN8RNDE288Oibaw9JNvdDhrZeukaq4TyhR3QANfTSy1a3Astmd1VfpT0A1mBy
	ybZTkEkL5J00K4/w3jkui9pTyXxxfpsamyeqRHkaKgVgRHcn0S3Z7Sny6OvhbTEBuMm0rPc98yb
	j6PZlQEY34mDZ8N/8oIfWa1QK79fU9J6xldYrGiUHjZ1X8gbPqCgELdhj1eBt6Dq0BaT53OH3po
	Q+7Ykvt/RFMkwjPI7pFrB1Z3obOhr1Yejwov8dAbgr9KnywpbISdbddDnLpae7E23VThj0DJfuP
	bZEMQBjcycBNSxjw/AzO/uKcY8kJbfpnnzBOiMUDgshqFUFdHbtVLxkcdvz039cB/Rqidl7/Iyf
	ClI7zPRzgxzp/Ci2RwvOZ5dmnRFwhpUfUgOsj1oeK0Yjw=
X-Google-Smtp-Source: AGHT+IEcarNvsOO3aXxUSqcWM/Ankr3/lxaVHC3jGDOyGIOFdVNywl/2WKM+EGpMDSYbUvktxTEjgw==
X-Received: by 2002:a05:6000:2c01:b0:430:f62e:d95b with SMTP id ffacd0b85a97d-4324e4c9cd6mr16518191f8f.15.1766484739029;
        Tue, 23 Dec 2025 02:12:19 -0800 (PST)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2253csm27396989f8f.14.2025.12.23.02.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:12:18 -0800 (PST)
Date: Tue, 23 Dec 2025 11:12:16 +0100
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: Re: [PATCH bpf-next] verifier: add prune points to live registers
 print
Message-ID: <aUprAOkSFgHyUMfB@gmail.com>
References: <20251222185813.150505-1-mahe.tardy@gmail.com>
 <CAADnVQLF+ihK16J3x5pQcJY0t2_gUHiur7ENZNqJdazzr+f8Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLF+ihK16J3x5pQcJY0t2_gUHiur7ENZNqJdazzr+f8Pg@mail.gmail.com>

On Mon, Dec 22, 2025 at 08:32:57PM -1000, Alexei Starovoitov wrote:
> On Mon, Dec 22, 2025 at 8:58 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d6b8a77fbe3b..a82702405c12 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -24892,7 +24892,7 @@ static int compute_live_registers(struct bpf_verifier_env *env)
> >                 insn_aux[i].live_regs_before = state[i].in;
> >
> >         if (env->log.level & BPF_LOG_LEVEL2) {
> > -               verbose(env, "Live regs before insn:\n");
> > +               verbose(env, "Live regs before insn, pruning points (p), and force checkpoints (P):\n");
> >                 for (i = 0; i < insn_cnt; ++i) {
> >                         if (env->insn_aux_data[i].scc)
> >                                 verbose(env, "%3d ", env->insn_aux_data[i].scc);
> > @@ -24904,7 +24904,12 @@ static int compute_live_registers(struct bpf_verifier_env *env)
> >                                         verbose(env, "%d", j);
> >                                 else
> >                                         verbose(env, ".");
> > -                       verbose(env, " ");
> > +                       if (is_force_checkpoint(env, i))
> > +                               verbose(env, " P ");
> > +                       else if (is_prune_point(env, i))
> > +                               verbose(env, " p ");
> > +                       else
> > +                               verbose(env, "   ");
> 
> tbh I don't quite see the value. I never needed to know
> the exact pruning points while working on the verifier.
> It has to work with existing pruning heuristics and with
> BPF_F_TEST_STATE_FREQ. So pruning points shouldn't matter
> to the verifier algorithms. If they are we have a bigger problem
> to solve than show them in the verifier log to users
> who won't be able to make much sense of them.

Yeah I think we would agree with Paul on that. And as you mention, with
the addition of the heuristics on top of prune points, it would maybe be
more useful to know when the verifier actually saves a new state (but
that would increase log verbosity).

> It's my .02. If other folks feel that it's definitely
> useful we can introduce this extra verbosity,
> but all the churn in the selftests is another indication
> of a feature that "nice, but..."

Tbh that's also when I realized that indeed it was "nice, but..." since
because of those changes, all those liveness tests would depend on the
position of prune points. 

At the same time, the new print would allow us to write a series of
tests to check for all the possible cases of prune points as presented
in the talk, not sure it's actually useful as well...


