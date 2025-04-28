Return-Path: <bpf+bounces-56871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41675A9FB8D
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 23:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8AF4657E3
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 21:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6A203716;
	Mon, 28 Apr 2025 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLfdnED+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E971DF968
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874026; cv=none; b=o6v1kBPk3nirJ2VnKxFoI0jXkaVArXB63G2Ba5KFVNMi86JXygENeBE+RFNFeBTsnZi8ZLFTgyF32RXz6KPBGAUJsFW31JMDqgyq+8M0/DBUoANV+wMSUVcUmNQBUrB5Ul8MAmORbTL3banQn//0rkTofISeVxSPBOIYBTf2O2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874026; c=relaxed/simple;
	bh=jN8SGXgsYZaDfh2rr8w73fkZKncW8PaRrYX31NTTRsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uV58eeFc/KliEuBMFWAwC8WG1WJ1yeKNEske1+zpTyFy9K4xlGYUwUvbrEDC+Hw2DnujvkwlKbe+8tDXclyfbD6ZooZcCsokkrHJlQwaXlaih7I+D8wVnyDKf8zMijguYjHTTpLFZMTR+dRjhrJIDZ5T82Hzt+qi13OQxmfW0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLfdnED+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af59c920d32so3471423a12.0
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745874024; x=1746478824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoyKxax2m0tjpWSgEaKAj4VmuPRd0esM3lxn9a853Go=;
        b=NLfdnED+ozuXD3iP5eYvlTO2wJqw/B+apwks7ih36B/5jXGC1IJprpzvBglr48/g6a
         1bk5QbDy+1sEoSAxi1sJT0t5NRT1sc1pjCaW29UGLG87/pyg3Q3B+7DohXqZAWthiWWd
         raoLsd6rbnQ4ukXDJ71lA+pXgbclLHnHgEqPhksgr485QNUO9DixqZDmh272fXn29e3v
         k2kTdt1dWIiLTrw6a+vzPYxoUe4SgEl9z43SbLYqrurjRQ0BEH9rkwkkuuWoz35gaP+R
         fjTcKo0I528abYnBcPrQ+V20SfjLExrNKbHV/vhywjwHWBonIPJCQOBFXP3PzynJWEvL
         2vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745874024; x=1746478824;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZoyKxax2m0tjpWSgEaKAj4VmuPRd0esM3lxn9a853Go=;
        b=sCSgn96LtYMRSZVb7BeIa+wxfp43zQLxY71gqb/34vZdI/ZoGTy+KDnu2xB5iz8UTW
         Q6/5G4Ky3TBxKjNZYiAqUCnHG2FT/k/P1oPVznfEv/ccDecHKgERsml+Q+3MGZXrFtgq
         mul9UzJY9OtFLu/lOSQ10n2z60pzJ134dRO19ZFZv5K3y/Y07RisZLvIryeGT3AUoRpr
         jOeRSR39LUFOn7xV04WyYtpue+cMgiFohayvTOR2BBDoQzHsBu3/IMeS+L5/3TBEgTeo
         +8gS/Ssir9BAFF53bHwSfQWxHeffycUPA+FkqgEn+ifXHTozD2ieuFU61aGeD70wKfzi
         /vXw==
X-Gm-Message-State: AOJu0YwkV3glnQzFTK4BZsomIA8Aks5doKIca0Fft0Dmm95q40dsMMai
	iDzMwJVGgPU1FCR+S0z5SX58Qq9XHLoq6sfuWjAFCmSPQ1W/NtiO122Eh2Ez
X-Gm-Gg: ASbGnctgtQdpQYc81PmQHg17oCE0m0XK6p+jdm/pfaz73BQd8N/rDKbvNhIP2QniA3q
	d4+P7Os1miqlArsxOxEVjMe0GboZGXtvoYbutPWQixlKvIOmAFebvCqguIpjVpyt1esojaRGZGA
	QQww0CcO0TCAhZqdJatVMWE+B6dcPmi/nIdOZj8KO2xsOQ7wZiAjtgZ0zzIKoCqui1ULxtcPyXw
	gapePPDSNSaXHCI/hIlrWMwyVrw3f6t1MLF8HXY8L3ux/mwsSxL5q3FdY11a0+BTEHg99eWWJ++
	bPyUHUQwwMBkjsO/ZMrwhkn6kxqIm/DD2jW9KJdtbDjqkcpdPfn+e7zxAZrV
X-Google-Smtp-Source: AGHT+IFTkgbbQxYMpWcxrEx9ulb2no7xmg8VsaNx0aBpyhNOPDlhaYAOi7wxvJq4T3UPFRQXrauR7Q==
X-Received: by 2002:a05:6a21:c98:b0:1f5:86ce:126a with SMTP id adf61e73a8af0-2093e622008mr1236468637.40.1745874023304;
        Mon, 28 Apr 2025 14:00:23 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:6628])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f80ac37asm7693130a12.17.2025.04.28.14.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 14:00:22 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Kernel Team
 <kernel-team@fb.com>,  Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: use SCC info instead of loop_entry
In-Reply-To: <CAADnVQLEeFYR2B6DEWxCZ2T8oaNLSg7EyBTcx-8ox4Swb8WOCQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Mon, 28 Apr 2025 13:25:42 -0700")
References: <20250426104634.744077-1-eddyz87@gmail.com>
	<20250426104634.744077-4-eddyz87@gmail.com>
	<CAADnVQK1tP1_of=pn7HdeZNqmPu=4AqpRETeOVeQMjDfSt0NOw@mail.gmail.com>
	<m2plgwjdem.fsf@gmail.com>
	<CAADnVQLEeFYR2B6DEWxCZ2T8oaNLSg7EyBTcx-8ox4Swb8WOCQ@mail.gmail.com>
Date: Mon, 28 Apr 2025 14:00:20 -0700
Message-ID: <m2cycwhuhn.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Apr 28, 2025 at 12:26=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
>>
>>
>> It is simmetrical in a way.
>
> is it possible to make them the same?
>
>> Operations on bpf_verifier_state->branches:
>> - do_check_common() initializes env->cur_state->branches =3D=3D 1
>>   (and this is maintained as invariant);
>> - push_stack() does env->cur_state->parent->branches++;
>> - update_branch_counts() does env->cur_state->parent->branches--
>>   (and continues recursively).
>>
>> Operations on bpf_scc_info->branches:
>> - is_state_visited() does insn_scc(env->cur_state->parent->insn_idx)->br=
anches++
>
> But this is not the same as =3D 1 at init time.
> do_check_common() does it for current state,
> while this extra parent_scc_enter() in is_state_visited()
> after a new state is created is doing it for the parent.
> Which is not the same at all.
> After new state is created st->branches =3D 1,
> but scc(cur_idx)->branches =3D 0 while scc(parent->insn_idx) got incremen=
ted
> and now may be 1 or higher.

Right after is_state_visited() for parent -> cur_state pair it is an
invariant, that:
- scc(parent)->branches =3D=3D 1
  (because this state just became a parent it only has one child state atm);
- scc(cur_state)->branches =3D=3D 0

So, the difference is in a state after is_state_visited() {1,0} vs {1,1}.

>> - push_stack() does insn_scc(env->cur_state->parent->insn_idx)->branches=
++;
>
> this one is equivalent indeed.
>
>> - update_branch_counts() does
>>   insn_scc(env->cur_state->parent->insn_idx)->branches--
>>   (and continues recursively);
>
> But this one is not.
> It's doing scc(parent)->branches-- only after st->branches reaches zero.
> It's not touching scc(cur_idx)->branches at all.
>
>> The main difference is that bpf_verifier_state->branches is initialized =
to 1,
>> while bpf_scc_info->branches is initialized to 0.
>> Hence a call to parent_scc_enter() in is_state_visited().
>
> Hmm, extra scc_enter doesn't look equivalent to init to 1.
> Maybe scc branches need this different counting logic,
> but being different from st->branches makes everything harder
> to understand.
> Maybe st->branches should be converted to this new counting?
> Logically they are supposed to count the same thing.
> Both are counting the number of branches being explored.
> And push_stack() doing it exactly the same way for both is
> a sign that they should be the same in decrements too.
> But they're not.

Ok, I'll try to make these identical to avoid confusion.
Effectively, what's needed is a ->branches counter of a state
that entered SCC first for current state chain,
but I didn't want to store a pointer in bpf_scc_info.

---

Here is another bummer.
I figured out a test to cover my mistake with frame_insn_idx() [1].

[1] https://lore.kernel.org/bpf/20250426104634.744077-1-eddyz87@gmail.com/T=
/#me1944d603de3438e5db7266fab5159c6c315268f

A simple modification, really:

  diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/se=
lftests/bpf/progs/iters.c
  index 646dc0fdd44d..12030aa340b2 100644
  --- a/tools/testing/selftests/bpf/progs/iters.c
  +++ b/tools/testing/selftests/bpf/progs/iters.c
  @@ -1683,6 +1683,7 @@ __naked int absent_mark_in_the_middle_state(void)
                  "call %[bpf_get_prandom_u32];"
                  "if r0 =3D=3D r8 goto change_r6_%=3D;"
          "loop_%=3D:"
  +               "call noop;"
                  "r1 =3D r10;"
                  "r1 +=3D -8;"
                  "call %[bpf_iter_num_next];"
  @@ -1714,6 +1715,15 @@ __naked int absent_mark_in_the_middle_state(void)
          );
   }
=20=20
  +__used __naked
  +static int noop(void)
  +{
  +       asm volatile (
  +               "r0 =3D 0;"
  +               "exit;"
  +       );
  +}
  +
   SEC("?raw_tp")
   __flag(BPF_F_TEST_STATE_FREQ)
   __failure __msg("misaligned stack access off 0+-31+0 size 8")

But it showed a much deeper bug. SCCs are computed for an
intera-procedural CFG. Which means that verifier is inside a loop if any
IP in current emulated call stack is in an SCC.

So either:
(a) each IP in the emulated call stack needs to be checked
    if it is a member of an SCC;
(b) or insn_succesors() for SCC construction needs to return
    called sub-program entry as a successor for bpf pseudo call.

(b) is simpler but might get too pessimistic if same sub-program is
called both inside and outside the loop. (a) -- needs some thought.
I'll try (b) and check how it affects selftests and scx.

