Return-Path: <bpf+bounces-32691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F48911EB8
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 10:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987CE1F2575B
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 08:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8331416D335;
	Fri, 21 Jun 2024 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc20pSLO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B9127B5A
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958474; cv=none; b=mCJBYKe7oHGylrwvGHy+DmsNdop+xjqJyRYfmeYHvXty2HiLOpfG39flfrZq2yKKgIbAL3R2A05c7Vxkl0wwXmR53irBPHoOYNIX22zqNyXwCsUZOQGSC8HkBwpOBomAp9iPw9WL7va3YgzZt/Fg9ZWuHfmB4V1XkiolHqBx7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958474; c=relaxed/simple;
	bh=BbBgcYapcDdF+876ZPrKwfDfuNyF16uYpy4h4MENrkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CWUp3UfYbmcX+dwv8UH7Fqr44EgngcM/ZjHtzucJOGWA1YttyH9tS5oid0IUvBwuGDNUR5QQXK2Ad5qqjH0aEnLYpYK/mEgqoEUqm2HV18fBOAx5lMNQxSUvPylJ/KrisYT7zQd6QlaWp4+b2pzVgMC2XLIUAKJswGVQtw19uNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc20pSLO; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9cc66c649so810450b6e.1
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 01:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718958471; x=1719563271; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OEz3un1kE+TH+M6KMtnKmZH5YndJhg42UTroh/bsBB4=;
        b=cc20pSLOKjqJzTyJmQL7LjkZERnBdZ7Q4NqKQn96kXVkP9pcn8WlGkOtZ5YaoaEEhi
         N4nYZb65bNzy7p+U/3YakOBOKuVim92f/HYnxIZrT4S0zHU5bgMP9b7p7QJbDeHv8LS0
         0SdfDtxGYMSmGAn3zgPA/0N+eQ9l6e2Tw0r/06aGTmv4Vfv2Xb2yDrN61RjJU2oyIqtw
         CMNu0yV7lx1UqZLYvs9doGthnAaGj3ao69ivjK33bZb83Hxn1Ufrv4IK4Ftx7mmcf0TH
         SYNfurWaX6ObhKCi+f9wcee1z8dy2EnuU1CmoenFcAVIAHMbRcO4+l2bIAP//Yncj/zA
         o87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718958471; x=1719563271;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEz3un1kE+TH+M6KMtnKmZH5YndJhg42UTroh/bsBB4=;
        b=PQw9ie8sLgSZk4ahPwItelLVT9lErB7KVVLMrtzIJj0muBN2Dxzpi9XjRQGmRuf/be
         JcDC+/wNPC7zNuZHSdWb955O86YLtBmzBBVAEFepWI0caWxCV/gK0HHXVnNMhwMUsL7y
         Nj9lnOn8OkrPdyvMfKb80l8Xt36YtInRDMleEV3/hnGPaND+s2zoFEpSfqlYpjslndcl
         jfGX3M38cVl+WpowmfETD7wvi+Nl6DzFihBq+frmVxrOrj6T76V6rGbE/QZVSv9BCQms
         QelbuJ7TzFG2IqyYexGM94Hfp7Wi3JZGQnTWNz5T7yUCg8YncjyHwuJv3avnJIIxcs9S
         oBKw==
X-Forwarded-Encrypted: i=1; AJvYcCWx9L1xuTK5EJpVDuI8jt8MtGA2q8pXCbFr469BA6fowq/wD7l0Bu0VsnziVrlGjcjP9q/FCt5VbxO0CtpqKsczSZJd
X-Gm-Message-State: AOJu0Yw55ByvuBCwtDbxgZJL7IU8FIQldWIQLbE+cdTQ3Rjrs4X38/w8
	WTgldLlcK7F7afb7PcrkYzApRyHnS6TTt7Tx9YqlhW5h7PZqO6zIEWrsHVgz
X-Google-Smtp-Source: AGHT+IElbXJwtifUrKKP3XYA5k0heeo9LdfzyiwwxTQWfSQ9ZKG09in3MCwGTqLewNd+qCvEgAq1fQ==
X-Received: by 2002:a54:4491:0:b0:3d2:29d6:fe82 with SMTP id 5614622812f47-3d51bb1255dmr6335676b6e.56.1718958470238;
        Fri, 21 Jun 2024 01:27:50 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651299c42sm860734b3a.159.2024.06.21.01.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 01:27:49 -0700 (PDT)
Message-ID: <2f6f3bade1dfe64fd9fddfb6ecdcfd86b411894c.camel@gmail.com>
Subject: Re: Backporting callback handling fixes to stable 6.1
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Viktor
 =?ISO-8859-1?Q?Mal=EDk?= <vmalik@redhat.com>
Date: Fri, 21 Jun 2024 01:27:44 -0700
In-Reply-To: <7k3olfmgvvdjumu6c76nzyynqp5hq252f7u2hqtqo5wbz2ii3x@ksker37jvude>
References: 
	<7k3olfmgvvdjumu6c76nzyynqp5hq252f7u2hqtqo5wbz2ii3x@ksker37jvude>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 13:18 +0800, Shung-Hsi Yu wrote:
> Hi Eduard,
>=20
> I'm seeking suggestions for backporting callback handling fixes to the
> stable/linux-6.1.y (and similar branches), akin to what has been done
> for 6.6[1].

Hi Shung-Hsi,

I remember that porting to 6.6 was somewhat painful,
6.1 would be much worse, probably...

> Testing with the reproducer from Andrew Werner[2] it seems 6.1 has the
> same problem where the bpf_probe_read_user() call is only verified with
> the R1_w=3Dfp-8 state, but not the R1_w=3D0xDEAD state because the latter
> was incorrectly pruned. So I believe the callback fixes are need.

Yes, the main problem with callbacks was that they were verified as if
called only once. This affects all functions accepting callbacks.

> The main difference from 6.6 is that 6.1 does not have BPF open-coded
> iterator, but AFAICT it does not mean "exact states comparison for
> iterator convergence checks" patch-set[3] can be dropped. This is
> because exact-state comparison from commit 2793a8b015f7 ("bpf: exact
> states comparison for iterator convergence checks") and loop-identifying
> algorithm in commit 2a0992829ea3 ("bpf: correct loop detection for
> iterators convergence") are critical for the fix; but it should be fine
> to ignore all changes to process_iter_*().

That is correct, that is the main mechanics of the fix.

> The "verify callbacks as if they are called unknown number of
> times" patch-set[4] name already suggest that it is needed, so no doubts
> there (again, dropping iterator-related changes).

Right.

I looked at the patches migrated for 6.6 vs current state of 6.1,
some thoughts below.

1.  3c4e420cb653 ("bpf: move explored_state() closer to the beginning of ve=
rifier.c ")
    - should apply as-is;
2.  4c97259abc9b ("bpf: extract same_callsites() as utility function ")
    - should apply as-is;
3.  2793a8b015f7 ("bpf: exact states comparison for iterator convergence ch=
ecks ")
    - needs regs_exact() introduced/modified in:
      - 4a95c85c9948 ("bpf: perform byte-by-byte comparison only when neces=
sary in regsafe()")
      - 4633a0068258 ("bpf: fix regs_exact() logic in regsafe() to remap ID=
s correctly")
      - 1ffc85d9298e ("bpf: Verify scalar ids mapping in regsafe() using ch=
eck_ids()")
    - changes to process_iter_next_call() are not needed;
    - changes to regsafe() seem applicable;
    - changes to stacksafe() seem applicable;
    - changes to func_states_equal():
      - seem applicable, but there is a commit that removes
        memset for idmap_scratch from func_states_equal(),
        it is not necessary for this particular fix,
        but is a safety fix in itself:
        1ffc85d9298e ("bpf: Verify scalar ids mapping in regsafe() using ch=
eck_ids()")
    - changes to is_state_visited():
      - ignore iterator related changes, just add a new parameter for
        states_equal() where necessary;
      - change to visited states eviction heuristic is probably needed
        (the hunk with "if (sl->miss_cnt > sl->hit_cnt * n + n)");
      - don't miss the hunk with "cur->dfs_depth =3D new->dfs_depth + 1;";
4.  389ede06c297 ("selftests/bpf: tests with delayed read/precision makrs i=
n loop body ")
    [didn't look at this]
5.  2a0992829ea3 ("bpf: correct loop detection for iterators convergence ")
    - looks like it could be applied with minimal changes;
6.  64870feebecb ("selftests/bpf: test if state loops are detected in a tri=
cky case ")
    [didn't look at this]
7.  b4d8239534fd ("bpf: print full verifier states on infinite loop detecti=
on ")
    [didn't look at this]

--- patch set boundary ----------------------------------------------------=
---------------------

8.  977bc146d4eb ("selftests/bpf: track tcp payload offset as scalar in xdp=
_synproxy ")
    [didn't look at this]
9.  87eb0152bcc1 ("selftests/bpf: track string payload offset as scalar in =
strobemeta ")
    [didn't look at this]
10. 683b96f9606a ("bpf: extract __check_reg_arg() utility function ")
    A small refactoring, shouldn't be hard to port.
11. 58124a98cb8e ("bpf: extract setup_func_entry() utility function ")
    A small refactoring, shouldn't be hard to port.
12. ab5cfac139ab ("bpf: verify callbacks as if they are called unknown numb=
er of times ")
    - backtrack_insn() lacks Andrii's refactoring that introduces 'struct b=
acktrack_state',
      technically it shouldn't be hard to repeat patch logic w/o that refac=
toring,
      but this would lead to further divergence with upstream;
    - backtrack_insn() lacks subseq_idx parameter;
    - __check_func_call() seems similar enough, so shouldn't be a big probl=
em;
    - prepare_func_exit() similar enough;
    - check_helper_call() similar enough;
    - check_kfunc_call() it looks like kfunc KF_bpf_rbtree_add_impl
      (the only kfunc that calls a callback) is not in the kernel yet,
      so changes to check_kfunc_call are not necessary;
    - visit_insn() similar enough;
    - is_state_visited() needs a 'skip_inf_loop_check' label,
      but otherwise seems applicable;
13. 958465e217db ("selftests/bpf: tests for iterating callbacks ")
    - tools/testing/selftests/bpf/prog_tests/verifier.c is not in 6.1,
      so adding a custom progs/*.c driver program would be necessary;
14. cafe2c21508a ("bpf: widening for callback iterators ")
    - technically, this is not necessary from safety point of view,
      but exact states comparison is very restrictive,
      so porting this is probably a good idea;
    - shouldn't be hard to port if widen_imprecise_scalars() and co
      are already ported;
15. 9f3330aa644d ("selftests/bpf: test widening for iterating callbacks ")
    [didn't look at this]
16. bb124da69c47 ("bpf: keep track of max number of bpf_loop callback itera=
tions ")
    - this is more "nice to have" patch, it fallbacks to enumeration
      of every iteration step for bpf_loop, if exact match/widening
      logic does not converge;
    - shouldn't be hard to port;
    - note also the following bug fix for this commit:
      https://lore.kernel.org/bpf/20240222154121.6991-1-eddyz87@gmail.com/
17. 57e2a52deeb1 ("selftests/bpf: check if max number of bpf_loop iteration=
s is tracked ")
    [didn't look at this]

Also note the following patch from Alexei, relaxing exact states
comparison a bit:
https://lore.kernel.org/bpf/20240306031929.42666-3-alexei.starovoitov@gmail=
.com/

Hope this helps.
Sounds like a lot of work.
Feel free to ask any questions about the patch-sets.

Thanks,
Eduard

