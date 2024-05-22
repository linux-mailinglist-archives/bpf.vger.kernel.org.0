Return-Path: <bpf+bounces-30328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACA8CC7A5
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 22:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E128196A
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E37CF34;
	Wed, 22 May 2024 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecLr9ZM/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C19428F0
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716409126; cv=none; b=VIku6O8bC02MiczwrC2vDkZFtRUpIqZ1TA8jWgBZwZ+jLnrQgImIC4jS+VaX67yJMi54DzxDe8UGQhT8Z+kQYn84g0pjPby6e1lLJmjQ3jIrdEpdrQsWUMJf2HrIm3vunRgQ/JFLxhiIyGFJaG6iFjkaO5ZJNG341bO5WhJFslk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716409126; c=relaxed/simple;
	bh=+tWpR6t3ln2LfTfQt4nfexVSS8RqAtVN76f74teae8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LubZJ+ryO0qfNZHENx5GMm+H53WSd/jhhuiGAeV8h93ZNBA+Z0fCTXfuIpLjM1ZBgbuw7bopFRGN1doc0vWyvv7BLYRYHkekehxcxEP1OkdU8CREKUA68LCF3mdEPRH6V6Zea1JYyJ2QQsQVEZ7q9Te0RIZKXgsldT+KWmA2dvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecLr9ZM/; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36c7b7b995fso17988155ab.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 13:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716409124; x=1717013924; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vb2qDfOM58VQhgMcgj5GRwhgybI2X5c3Vm8xLgoVazI=;
        b=ecLr9ZM/WdMnwpSknxAQMhGUGcDwodhdESTItkneHbYoqBCTXttpuyuBb9W8VdtYU9
         5q2drwFPZ5iyqiblDE6ZvP1ahAu6wjpw7kh1jDb7GmGFS2KJ6Kwki9SaLh2F6vjw6mWJ
         6yeOAxcBHq5O3k1ARDasGyyHShtM4HXnUSr8S/lNQ1U/M1+gUKxct08gA4z7rWHPbNOC
         5bGm5rIa5Av1CTu5yy+qAe5CwAthza5Z2Z1/88HrfQ1xfXoaJtG7eZXaqcUcJmuc0vyC
         gwiJ5wT3it25gqsn2wo1iprbJF+aYLLoIC+a1MvdBwZPU67dthyrUiiWBc4ZVrjVecdo
         GWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716409124; x=1717013924;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vb2qDfOM58VQhgMcgj5GRwhgybI2X5c3Vm8xLgoVazI=;
        b=IrY+YXOpEoP6Whw1JrlVO5A3WCXKG7SfySwz36wGEeUVVrZf4YQ/WD8PSCPqZMS1Xx
         +t5kpTpFoiNcact6BVZMQFldPBw+mPCact+WyeO1BbN/UN5CKKhoSCw4fBOVluUPpfsV
         Gtiqr4EdSVnQsQHEqiA8yuASnxJSYQ1YqjukgBHBDvP23QHGD6TR3cQdeplzUuQhaYpK
         tZOEoM6+a8vW8K7pGt90sFPfDBmShgapfvA0D0Rv37oBC5K5zm5ZxWX7RhuYJrWcF0sY
         pR8oKhtpJ3QtoEPDJyi7+LJnlKIEFcv5DJALfsBKsWRDEVXr7OY2oj5nHK7meMG54sw8
         vpTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/IcsgJ8h89q7Cu7lcfCuAw0wgy5O4Pfg8LJz1hG0CqYNYx1IrHh70zACQpgalTaxCE1Ka4FVdxyx1bYxSyA55PNbV
X-Gm-Message-State: AOJu0YzFaSgYWRBIeTCjdIkPKOn6pXAftiCMkyJ7FQD+lIMxWqs9DqGZ
	ckef3/7ACI4aCtSmoE9RQrex/m5eIK22CkIFq4ruRYjIuw/DMWbFoOZtcCHK
X-Google-Smtp-Source: AGHT+IE5LLp+SHsI2oZZ+pWLJgt5NPkt0pCpU8S0/FveLATpQvIVW0HisIISsA/Md2KZr3N+NC2FIA==
X-Received: by 2002:a05:6e02:15c9:b0:36d:b36e:3c6d with SMTP id e9e14a558f8ab-371f9ddd75fmr34539985ab.10.1716409124307;
        Wed, 22 May 2024 13:18:44 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2c36sm23599757b3a.173.2024.05.22.13.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 13:18:43 -0700 (PDT)
Message-ID: <78fa1f7e442579a968a99b00230c6aa0f280679d.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Relax precision marking in open coded
 iters and may_goto loop.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, kernel-team@fb.com
Date: Wed, 22 May 2024 13:18:42 -0700
In-Reply-To: <20240522024713.59136-1-alexei.starovoitov@gmail.com>
References: <20240522024713.59136-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 19:47 -0700, Alexei Starovoitov wrote:

[...]

Regarding this part, since we discussed it off-list
(I'll continue with the rest of the patch a bit later).

> First of all:
>    if (is_may_goto_insn_at(env, insn_idx)) {
> +          update_loop_entry(cur, &sl->state);
>            if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
> -                  update_loop_entry(cur, &sl->state);
>=20
> This should be correct, since reaching the same insn should
> satisfy "if h1 in path" requirement of update_loop_entry() algorithm.
> It's too conservative to update loop_entry only on a state match.

So, this basically changes the definition of the verifier states loop.
Previously, we considered a state loop to be such a sequence of states
Si -> ... -> Sj -> ... -> Sk that states_equal(Si, Sk, RANGE_WITHIN)
is true.

With this change Si -> ... -> Sj -> ... Sk is a loop if call sites and
instruction pointers for Si and Sk match.

Whether or not Si and Sk are in the loop influences two things:
(a) if exact comparison is needed for states cache;
(b) if widening transformation could be applied to some scalars.

As far as I understand, all pairs (Si, Sk) marked as a loop using old
definition would be marked as such using new definition
(in a addition to some new pairs).

I think that it is safe to apply (a) and (b) in strictly more cases.
(Although it is probably possible to conjure a program where such
 change would hinder verification convergence).

[...]

