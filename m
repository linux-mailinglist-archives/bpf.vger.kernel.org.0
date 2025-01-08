Return-Path: <bpf+bounces-48299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B52A0662F
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26951670ED
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FD02036E4;
	Wed,  8 Jan 2025 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zh9j8bKi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036171A841B
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368250; cv=none; b=JIWrErrDuiJnaFcPWRNxCL2uZo6449h0afwYr7zqxgZNTMe/YQqz3393IiQQm8sJgljM81BkylmIQmY9Z5vsXIN4waKCjuvdMUA1k7FwKDz4ou0PiwJMQY8WszbVfVpzrM2PB7IdxXohpMa+/uhb5SrJ4Ay94naCK1hOMnURWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368250; c=relaxed/simple;
	bh=7ckYaCnqVlwMPOOFkI/gYptNWEVxfQPOkQmrZBaYU84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iro9BKx3IdV9NuYeB0lH6DtPVCPPmkbJ16NDInSZtZ+IOMDxjrVih+EHs3pWrCKTEuSiecxGvh5jJREyZ62Z1W0t+DdVs+k4LjGLBjTXJPLrnemSk93wbppeWwzulORFmgvNetQD5qw7C1VBbqpKr+qCKSXzzOpgQR31vYT/wJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zh9j8bKi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso197501a12.3
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 12:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736368247; x=1736973047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHHBXinp667U7RSmNg2A292XIFDF8BANw//sklCXsWA=;
        b=Zh9j8bKiZpWXqSpYkLfvBBu3rhI+LqbgfKzB18p2aPQ2hzTNXUKXuh+M8203XAAjBI
         2va/PPDxtKc9JS+HDithxU+g9VyVZA893Gnh1VNeUuqwhUq3ceWw8pLX0k8qboiJ43YR
         DuWtRQ9u1NVvKhAGImHl04Fjo2F3p3SuYRqSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736368247; x=1736973047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHHBXinp667U7RSmNg2A292XIFDF8BANw//sklCXsWA=;
        b=Oq9C7RNxOvjiRSEEqUjGx7KqKErDn1+Nh8Hc1xgKrQOc20qYv1HWdSkDSVoPLG9eoW
         Zl8RBhVThF1f6pXzh2wcRyteiQEYCQe9Wouy6DSMw3OVpMPdj8bDh9hkt8L3Rfa0MxKd
         5vd1vTI9Gim7jh8x6n/IE5BXwfOvuqRnKQuqxKtKkPByI27pJUxRsZ1R1n31ip9xOuup
         dzhzB2TnxyNsQMg4jAlj4HKfelNN92a5PnOKIEtkR4lnpHIFsoxJiB4Zx5L24fLjLdgR
         oT1TeiBaBTUDBsXKaWxZb3cqZIlXHBINLh24y8Eru/BlN9YebJrh4Knp4i8H2wby6Di9
         Ytow==
X-Forwarded-Encrypted: i=1; AJvYcCWunzPVvlkkERYNEDuFPSag+sB8ne54LyaxkguNJdxvNlU1HGLe1bpmyorppihWUFYmJA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVJce6Z3GJpokzmsKBGHO36OZnPGwte5DFL/twg27yw2YR7ss
	6EqYmnRaqkG6/RBEpziP7sY3cKId/kGh1ukJPHyi/vDn5ji4YELMo/wOS9+hNswgdRWT6mbXYxr
	lDDU=
X-Gm-Gg: ASbGncvVyCZ2H1Ue/+Kc92zyh4SOyPPt7AVvY5aiADOrlcTm6F3qDSAEWzpAI/8pATu
	p330xGTeYG2v232Cg2u/4MtF9lmB0UdhPHV3lCGnG7mWfSv9Ijhipd0Kj3e21ongyJtrxUMkAul
	5JTWS1pS82oqohp9TdUk6xxjyG76g30uNDI4iqGPCWikKHeQnE29g4vagIbySkEy8Nbn+QP5+63
	ELYW1GOxuVDw89wPWVmTgFJHCZSZ98dP74tvCuXjMF/Rzg5HbzZkc8XzDPn0ZDBEOUNPQyKEWvV
	87LHbmdoQ6P/sTvHsGrblounUPxb6Rk=
X-Google-Smtp-Source: AGHT+IFfQuxCZdddGgaiKv0hcM5z3PtqHQ/wBwvhXZ78eu2uwKGgN18VIsGHh9vF92cq6jbjttCeEA==
X-Received: by 2002:a05:6402:2746:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5d972e1c54emr9635173a12.17.1736368247211;
        Wed, 08 Jan 2025 12:30:47 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80678c6dfsm25840232a12.37.2025.01.08.12.30.44
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 12:30:46 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso197420a12.3
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 12:30:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRLO6SDBI6+qUbGbouNupZmXidu3MWf17hcJTrPg2saBKCY7csBaIdEMuYq/lNhybO1Dw=@vger.kernel.org
X-Received: by 2002:a05:6402:530f:b0:5d1:2377:5af3 with SMTP id
 4fb4d7f45d1cf-5d972e00027mr8538499a12.5.1736368243671; Wed, 08 Jan 2025
 12:30:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <CAHk-=wh9bm+xSuJOoAdV_Wr0_jthnE0J5k7hsVgKO6v-3D6=Dg@mail.gmail.com>
 <20250108091827.GF23315@noisy.programming.kicks-ass.net> <CAP01T75XoSv91C6oT8WSFrSsqNxnGHn0ZE=RbPSYgwX79pRQVA@mail.gmail.com>
In-Reply-To: <CAP01T75XoSv91C6oT8WSFrSsqNxnGHn0ZE=RbPSYgwX79pRQVA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Jan 2025 12:30:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWxnjFkqG9VLm0N3Nj4U7Y3JNvyshmjdwdD_=7_zZriw@mail.gmail.com>
X-Gm-Features: AbW1kvYzfcmG0WlM9BTmIgweHN98MBPVvzRmKcApLAJX9FcuumKyMJsoGmwcztk
Message-ID: <CAHk-=wiWxnjFkqG9VLm0N3Nj4U7Y3JNvyshmjdwdD_=7_zZriw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/22] Resilient Queued Spin Lock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Waiman Long <llong@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 12:13, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Yes, we also noticed during development that try_cmpxchg_tail (in
> patch 9) couldn't rely on 16-bit cmpxchg being available everywhere

I think that's purely a "we have had no use for it" issue.

A 16-bit cmpxchg can always be written using a larger size, and we did
that for 8-bit ones for RCU.

See commit d4e287d7caff ("rcu-tasks: Remove open-coded one-byte
cmpxchg() emulation") which switched RCU over to use a "native" 8-bit
cmpxchg, because Paul had added the capability to all architectures,
sometimes using a bigger size and "emulating" it: a88d970c8bb5 ("lib:
Add one-byte emulation function").

In fact, I think that series added a couple of 16-bit cases too, but I
actually went "if we have no users, don't bother".

              Linus

