Return-Path: <bpf+bounces-62641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2255AFC395
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 09:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0223BBCB8
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 07:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B020E255F25;
	Tue,  8 Jul 2025 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYZJrIZX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D41FCFF1
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958478; cv=none; b=ORZNvuLDQuSH1+kyi/hvVdtANeMKXd5eIjNXwWdZ3dzF939iRaUKo3ILnvJPGR0LoNPYzQHFEDsktWsoCIdvyAgbE4aDVBMIJKz4l+/gfJoi39I3fPXejpuzFE5BMSZGzreQ+TRx9VTh7Us8jsA9V9aXVb2bLOy2iy1eI1BY9As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958478; c=relaxed/simple;
	bh=PxiuBnlaQWCV2qC7qhMbMTXAx21l3lCEHkSC1WI7ZOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKhARC02ns3Ktv2lBvbabMZooi/r3LfBwnGZCMptb5iVkEB15wfgmo7AsWJwWRZGm6T5pTsXUUdjyZ+03UaFqmAuUYF56sZ7wtViwQW9Dr1dDG2tpjxI8T2HOFlXPza6spKj9WyX/aqCyYmaQKpTp7aTTAVN3/kSxcsXzjtiW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYZJrIZX; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70f147b5a52so26818357b3.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 00:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751958475; x=1752563275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PxiuBnlaQWCV2qC7qhMbMTXAx21l3lCEHkSC1WI7ZOE=;
        b=TYZJrIZX6OWvhjGbW4HQ85pN4pOU4BR155rXuYeWPXKrx3K8GRKNy++1tJGNrF5zTR
         SKxOZAa48IlNZTEdKXz0xCsc+CqEV0r946BqFOmthE/5f2GZvJAh7BKC7Sxl6qqONbm1
         xAF/+vQvS4UFPTCMSYNm94boTTMeWied/GARlcynByqmbeV2wek+ILDcRZRcuSAdaZSa
         XrGk5TQzdRYRPlLWfGeihC89Vumm75rdtGrw8RmGFA3IAd1s+3Wirw5OfPmAzZ78Wtl8
         Rd7jkfaHe3P21tTWZjOqtyyuVfkACFN27QddJiiEfG841geZ8WDsCFuCVECRGyhl/8/f
         F6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751958475; x=1752563275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxiuBnlaQWCV2qC7qhMbMTXAx21l3lCEHkSC1WI7ZOE=;
        b=OAaqEx0eo+ZYvlmixqzxFBLgs0kpiG1FmHSV76iXAedpiRLwSZdvJ70Fdy99UayR1T
         GPWbWGO9WPYZEP12Rcoahsx6+paMfzT56OWceGU8acXtBqUwodYsaMV7KMwUO2YgYqkH
         LiFhKRfs/irETbhRNMpTsE+eemw+eZmUURnQYfWCKVXpWA1Ogy+BbeeDQBBaq/7HkEea
         ZjrIcoeDrGaVehQQrbaPfJfkihVZQrpHsnaZvU4rluFg1wRPG9lsfUe1qYDA3a4F7Hv3
         MRDlQtrpjx09gYi1t6TY0WyBZOqA8lbZxXoUruKUuX32q4gxlkftdHbGQZs+DFWpMMos
         qzKA==
X-Forwarded-Encrypted: i=1; AJvYcCWxa4kiLBcs/KsjS2MgOyTEkNZQWXW+gM3fGxQdt4DYuBlOOc1u2KmpXrdEymJhEcXt3nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytduY4e2FeSy60EEV4SEwK/RaAMywZ0gx5Km2dM45rMnqiE5XG
	XXP2cj8Uka4Pqif3UD7wI6ywRC3XNLAPs9+tZLqN08uPV+NR3E4p9uojBQ/cbqGEsCALTwk/q+S
	s3sEYs8byM5KtOa6LLLCKZxY18CrXG8I=
X-Gm-Gg: ASbGncuZ36zqmtmZYTd72BtqYRMAglP/BjCzSOrX6DdDJrWeEBCQQLeAMB96nFRGpRo
	hdrNJGxGUVTMCBolt78AINlg7guJP1Od5/7EKaIFr2CFfZxTbqz9B9Z68IpBMYY7pEVxt3KII47
	+/348EAktYGTwJ/oGarHNwlxvK5K3P8U5VVwGu7ZVtvS3xFkAhsJcOysjfdRSzIG4eGb1wnrnwV
	Uma
X-Google-Smtp-Source: AGHT+IEot22LrWQETUjksszdErExHmIVBfIhP8zMylsJPQd6QCJQfikP494HNZP2MHwiVupb1lTD1TzVykymp6Maed0=
X-Received: by 2002:a05:690c:fc9:b0:70c:d256:e7fc with SMTP id
 00721157ae682-71668d1967dmr203961527b3.21.1751958475429; Tue, 08 Jul 2025
 00:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
 <20250614064056.237005-4-sidchintamaneni@gmail.com> <CAP01T77TBA3eEVoqGMVTpYsEzvg0f7Q95guH0SDQ3gZK=q+Tag@mail.gmail.com>
 <CAM6KYssFT35L5HN_Fes-2BdhEO6EmhF9Qa+WSWLML4qnZ0z1tA@mail.gmail.com>
 <CAP01T76S4X4f=owz9D7dXfv15=vD8HB8dO_Ni2TmKfqTKCtuhA@mail.gmail.com> <CAADnVQ+EiaoWUVcN9=Nm=RWJ6XE=Kcm8Q2FYQqWGJ_NsCtyJ=A@mail.gmail.com>
In-Reply-To: <CAADnVQ+EiaoWUVcN9=Nm=RWJ6XE=Kcm8Q2FYQqWGJ_NsCtyJ=A@mail.gmail.com>
From: Raj Sahu <rjsu26@gmail.com>
Date: Tue, 8 Jul 2025 00:07:39 -0700
X-Gm-Features: Ac12FXzJJB4AffMhlRIFVbatj74HgfcaLx2o6lWzVMN9wFcROy3i3jpGCS2u_r0
Message-ID: <CAM6KYssLVB+Wqw5ptQQufjmV3279AX7ZKhXtkG6OWaM3vWde-Q@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 3/4] bpf: Runtime part of fast-path termination approach
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Siddharth Chintamaneni <sidchintamaneni@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, egor@vt.edu, 
	Sai Roop Somaraju <sairoop10@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> If we have such bugs that prog in NMI can stall CPU indefinitely
> they need to be fixed independently of fast-execute.
> timed may_goto, tailcalls or whatever may need to have different
> limits when it detects that the prog is running in NMI or with hard irqs
> disabled. Fast-execute doesn't have to be a universal kill-bpf-prog
> mechanism that can work in any context. I think fast-execute
> is for progs that deadlocked in res_spin_lock, faulted arena,
> or were slow for wrong reasons, but not fatal for the kernel reasons.
> imo we can rely on schedule_work() and bpf_arch_text_poke() from there.
> The alternative of clone of all progs and memory waste for a rare case
> is not appealing. Unless we can detect "dangerous" progs and
> clone with fast execute only for them, so that the majority of bpf progs
> stay as single copy.

I just want to confirm that we are on the same page here:
While the RFC we sent was using prog cloning, Kumar's earlier
suggestion of implementing offset tables can avoid the complete
cloning process and the associated memory footprint. Is there
something else which is concerning here in terms of memory overhead?

Regarding the NMI issue, the fast-execute design was meant to take
care of stalling in tracing and other task-context based programs
running slow for some reason. While I do agree with your point that
deadlocks in NMIs should be solved independently, kumar's point of
having several BPF programs needing termination, running in hardIRQ,
puts us in a fix. What should be the way forward here?

