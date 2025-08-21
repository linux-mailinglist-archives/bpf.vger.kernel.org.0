Return-Path: <bpf+bounces-66232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E443EB2FF43
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 17:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8A434E64E7
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C25275AFF;
	Thu, 21 Aug 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxMyB0Um"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30E26B2C8
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791660; cv=none; b=D2dfa7t++5UuZ94e7TfamTcQgN7kZqtnjNZ1cBaa+M1u0umojVGKfju0ETYN/WOorePTe6u3SoWjZbwB72eUe00WWNwOxGZJDiXGrdtOPutjKASb9n7hu/PkRUH+VSl85B0pN2bZqGbLT1sTzJguNbzcw4fiPu8wCqVmNaporCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791660; c=relaxed/simple;
	bh=s3NkfWdWiM3+pPoQeRZMPqKFnHl7CSCDRhf6EKIfA6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTC7JRFaFKIohYxKj7Xu4P3upxniGck12Imj/EQrsJX7p9Vu5FGlQBhnEivLjBdUi5KgOfeNOtPwHj1MnkhJDMNMzZse1FoJb/d3TegfJrAdC9jU/S/VN88K0maoTplPy0DM1xTTPqVMQsZBEHFjbO5uQziVuz1gOt08P18xt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxMyB0Um; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b29b714f8cso319991cf.1
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755791658; x=1756396458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN8fFqbbfxw/oj3xUy2dOVhcytSJepW36qzZ5F62/r0=;
        b=rxMyB0UmDLqlI7cZo5cyd3RZjwHsxqdmjDJ2h1nA6QQ2cXjsSv6XA030Hwgh3Fabl7
         1lxVI8Ynx+lpYSsDFomj6/naIiluHTZLW7fR6boBUwG11PLoBz3pXJ9yJQx07VPgsOTh
         0z+np+4lNGlgxYSIY0ZYXEVPpTjOJ3kNyVVfkTmwDa8Yi7o8sQFHDP7JjzFt4pJtJ996
         ZoZFBiWvPVjxKqlTUiSqWdJnUbvjlTz+P+oC9nkvyYcSOoryb1qofLQXBTLZb072GYWb
         eJpqA1KrUW6XttAXaAbp8vvDiV0mUC9Y1nyCkVKt6xzQTceszMBDyC370r0TcTSOgBPu
         v25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791658; x=1756396458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN8fFqbbfxw/oj3xUy2dOVhcytSJepW36qzZ5F62/r0=;
        b=JssvLEyorJC41Q7yDtcfAaYOooi8KHzTqV3x40zbWrvNkkS1k8Sea19T488F56Y0lt
         0h6GgXbsnlO1fcv+Ch3oZy316bjSn2chcsVr3red9/WgLcMcbyucuWLHwWXe5raI408U
         Kk3y94fdyuD3F5js8SGAcdYUd8wo38DwA8It6knnkElR/e/NryX4UFhUnL7x+Tclge2q
         nDM297E2P1MCR9b4m0ILH45u3gObnf2rVNpbm66lvNJd2/MXHMgAkmWESk8IDWZwXD4W
         4eWGycVvxPpilZBnPoZYx2UZ4CTUE5SC0N0TTdGBVlH1cOLLliNWMvhyePuzjIYxmj8k
         iBwA==
X-Forwarded-Encrypted: i=1; AJvYcCWip3mHQNmcdFVfHrJtcpEk0xbIG0rdX26w2m7Nm4k/o09NZNaLcCP+fboW/kuOZWw50KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymub0d9+lVRBzMhP0yQSf8Jo0qfU0RKP2nqAaBfYgavjIuNw+b
	B2tAVg8/nXbI+s4SVNSzfBcxkMQXmvUWljTGEaGO1a3ZUsmGvVDJwBDbPEYcs4CruNraVsjc0qb
	OHYGEOxvU3JjuPM2dCIdreFoCIY1WPFk1fzMxJl1y
X-Gm-Gg: ASbGnctYIMgLNLWeBaCSEduFEnzKq0gERDz/RJ1wtz3FlWGSgo1PQOMt4quGPw7ni24
	eb2zhlkDqgPDaTOj9JqDwkQSX0IMksU3+5CAQA9LqMnF/FO195ElPHANIURBK83ud+CMUYMcaTy
	oGLc1Egn2DG/K/1/yTrhbJTYJZUSSP8zCJRjAGa/yJ3SmcyVVBNYb5/idQULpgXPtno1vnP2A7k
	1bkN8KxKYUSqNGRCLNCBRPp85s55Vxl8UzzIAEYTF40J8i1/cH4ft0=
X-Google-Smtp-Source: AGHT+IF7ftkzBG+sErHG0PyIKhN56o5QPEdRNCi+vPkHmyiE5ovuaHVbNMUd5SO4AajLAnQHLFuy1cPHbgz3xOWbu6o=
X-Received: by 2002:a05:622a:1aa0:b0:4a5:a83d:f50d with SMTP id
 d75a77b69052e-4b29fa06aadmr5250511cf.11.1755791657570; Thu, 21 Aug 2025
 08:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev> <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <CAP01T76xFkhsQKCtCynnHR4t6KyciQ4=VW2jhF8mcZEVBjsF1w@mail.gmail.com>
 <875xehh0rc.fsf@linux.dev>
In-Reply-To: <875xehh0rc.fsf@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Aug 2025 08:54:06 -0700
X-Gm-Features: Ac12FXwQnszAXbgUOsvMFTdZCWPF5sLUrZJo15MDmJrYfWcN3MOe0juq7mH91Ms
Message-ID: <CAJuCfpGTBvwv9vZ1T60ejk+uDVrTLbCDvhP0hMiT-Cr7to6yEw@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 7:22=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > On Thu, 21 Aug 2025 at 02:25, Roman Gushchin <roman.gushchin@linux.dev>=
 wrote:
> >>
> >> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> >>
> >> > On Mon, 18 Aug 2025 at 19:01, Roman Gushchin <roman.gushchin@linux.d=
ev> wrote:
> >> >>
> >> >> Introduce a bpf struct ops for implementing custom OOM handling pol=
icies.
> >> >>
> >> >> The struct ops provides the bpf_handle_out_of_memory() callback,
> >> >> which expected to return 1 if it was able to free some memory and 0
> >> >> otherwise.
> >> >>
> >> >> In the latter case it's guaranteed that the in-kernel OOM killer wi=
ll
> >> >> be invoked. Otherwise the kernel also checks the bpf_memory_freed
> >> >> field of the oom_control structure, which is expected to be set by
> >> >> kfuncs suitable for releasing memory. It's a safety mechanism which
> >> >> prevents a bpf program to claim forward progress without actually
> >> >> releasing memory. The callback program is sleepable to enable using
> >> >> iterators, e.g. cgroup iterators.
> >> >>
> >> >> The callback receives struct oom_control as an argument, so it can
> >> >> easily filter out OOM's it doesn't want to handle, e.g. global vs
> >> >> memcg OOM's.
> >> >>
> >> >> The callback is executed just before the kernel victim task selecti=
on
> >> >> algorithm, so all heuristics and sysctls like panic on oom,
> >> >> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> >> >> are respected.
> >> >>
> >> >> The struct ops also has the name field, which allows to define a
> >> >> custom name for the implemented policy. It's printed in the OOM rep=
ort
> >> >> in the oom_policy=3D<policy> format. "default" is printed if bpf is=
 not
> >> >> used or policy name is not specified.
> >> >>
> >> >> [  112.696676] test_progs invoked oom-killer: gfp_mask=3D0xcc0(GFP_=
KERNEL), order=3D0, oom_score_adj=3D0
> >> >>                oom_policy=3Dbpf_test_policy
> >> >> [  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted =
6.16.0-00015-gf09eb0d6badc #102 PREEMPT(full)
> >> >> [  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.17.0-5.fc42 04/01/2014
> >> >> [  112.698167] Call Trace:
> >> >> [  112.698177]  <TASK>
> >> >> [  112.698182]  dump_stack_lvl+0x4d/0x70
> >> >> [  112.698192]  dump_header+0x59/0x1c6
> >> >> [  112.698199]  oom_kill_process.cold+0x8/0xef
> >> >> [  112.698206]  bpf_oom_kill_process+0x59/0xb0
> >> >> [  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/=
0x313
> >> >> [  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
> >> >> [  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> >> [  112.698240]  bpf_handle_oom+0x11a/0x1e0
> >> >> [  112.698250]  out_of_memory+0xab/0x5c0
> >> >> [  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
> >> >> [  112.698274]  try_charge_memcg+0x4b5/0x7e0
> >> >> [  112.698288]  charge_memcg+0x2f/0xc0
> >> >> [  112.698293]  __mem_cgroup_charge+0x30/0xc0
> >> >> [  112.698299]  do_anonymous_page+0x40f/0xa50
> >> >> [  112.698311]  __handle_mm_fault+0xbba/0x1140
> >> >> [  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> >> [  112.698335]  handle_mm_fault+0xe6/0x370
> >> >> [  112.698343]  do_user_addr_fault+0x211/0x6a0
> >> >> [  112.698354]  exc_page_fault+0x75/0x1d0
> >> >> [  112.698363]  asm_exc_page_fault+0x26/0x30
> >> >> [  112.698366] RIP: 0033:0x7fa97236db00
> >> >>
> >> >> It's possible to load multiple bpf struct programs. In the case of
> >> >> oom, they will be executed one by one in the same order they been
> >> >> loaded until one of them returns 1 and bpf_memory_freed is set to 1
> >> >> - an indication that the memory was freed. This allows to have
> >> >> multiple bpf programs to focus on different types of OOM's - e.g.
> >> >> one program can only handle memcg OOM's in one memory cgroup.
> >> >> But the filtering is done in bpf - so it's fully flexible.
> >> >
> >> > I think a natural question here is ordering. Is this ability to have
> >> > multiple OOM programs critical right now?
> >>
> >> Good question. Initially I had only supported a single bpf policy.
> >> But then I realized that likely people would want to have different
> >> policies handling different parts of the cgroup tree.
> >> E.g. a global policy and several policies handling OOMs only
> >> in some memory cgroups.
> >> So having just a single policy is likely a no go.
> >
> > If the ordering is more to facilitate scoping, would it then be better
> > to support attaching the policy to specific memcg/cgroup?
>
> Well, it has some advantages and disadvantages. First, it will require
> way more infrastructure on the memcg side. Second, the interface is not
> super clear: we don't want to have a struct ops per cgroup, I guess.
> And in many case a single policy for all memcgs is just fine, so asking
> the user to attach it to all memcgs is just adding a toil and creating
> all kinds of races.
> So I see your point, but I'm not yet convinced, to be honest.

I would suggest keeping it simple until we know there is a need to
prioritize between multiple oom-killers.

>
> Thanks!
>

