Return-Path: <bpf+bounces-79534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B252D3BD53
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F4D3071EB8
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7006E260565;
	Tue, 20 Jan 2026 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo9LFTYc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2C263C7F
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874084; cv=pass; b=Cox870tztNlKqux2Bm9oeBHdsXS32drTtDpEgogYWGSGssZGOzJq914VJIhBJ/iOk21OK1n8JMBBW+UOix4kkcL/pJmNrwe5KZE9KAkvl5Ns75GScFQq9JUARaDoDAiumxYicS/sFxPxOabrRlLmgGcBxo9mMmrEoOO3qaM9Oww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874084; c=relaxed/simple;
	bh=XGnx+hJEeSArfiv7aLN3NyUqUkXPRFZ7Ia+4ttpmkFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alNU91csmoyk3rHtNnGfc+Z32K+fQY5acYCre6fAknr8EsHY3luGEf5XuXHjtesQaMW3d/VhjujiqlviHsLsRsdovC4kVKa84XlFSz4SFsxt5j6Dyoimbu1HZ8lrE3c0Mvn20OQ0OGU+/vSHt03ehpwC500c1OVgdIqHW2JpMQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo9LFTYc; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso33006655e9.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768874078; cv=none;
        d=google.com; s=arc-20240605;
        b=B08ypowiCza4TgZ1QXEQ+zmPP64OdFPdcqBbmROSd0UxY3bQlRmZ5YxAkKcDWh+9ov
         NY9GXo39ccCw/jkSgFfsTIWN0CJ/A0MpEsPVmTcS+XGkHpC36XxvrGhbP1jDn8NLa3Al
         Zeq90eQ4LSLYnYHhbMKzrN0xUUR5rqe5dJiW8zdGUGVB0aLFjxDD3eTGezmOrVlv+eJ1
         QbZkkyUvQNDd6lg49qkrbnOOFGxcWIEHZpCeiuvcYlTkBRHCF6uW2lmfIto+ZFVjs+hK
         tdcxprf3pzHQFF9lXzcWefxIBubhaQHgsna5Qy6rrNBwyYTvXCYWoCc/+nHurg2sM0Zm
         ghig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xv9zEHuRc9c1EY5SUHsPnAlQlZPm41qdCAYpBSnMb3A=;
        fh=Y9GxqulDu0mlkyOT6jxb3xTA99noNfqT7C1ZLIQXQMI=;
        b=PcbxuP9qBCuRwQMYSWJMa6ygwF0swkm4DhfDVn1xwCC8uqDJIamEAsR/6l+7/Xq4tP
         eQXYNAGI1rrlmazTeJkjUFEwT1U7Aa4E1oBppK9btYbeHOG99p8C95u75U6chC4YM8bi
         sqJ4amSAZsc78gRZ5ev3whHkJuhlDA5yY+8NBTwXXlMM8qZCIzxHb/J7oVoDoLo1rk0t
         /zb0mTzsow79sKR6tYx83UzhRg40FpRJzwjJr3fI6fPNJytZttP+rvbQgA0ecgqNUNSD
         NgSfICLVRMffKpTTQJsFovc/IZdb9Zhaus7mfnMtFxwGl+6X0vG74EOElOVkO7X5J7X6
         CMpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874078; x=1769478878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv9zEHuRc9c1EY5SUHsPnAlQlZPm41qdCAYpBSnMb3A=;
        b=Jo9LFTYct/5buioDVaVlin68/jmGh38Ec3ZdrjaDEMpUl4LWGopPQhttolGraoBdml
         MbieNdllTlPWO4/6A1Zn1awOHrTsaZoZU3r6qavyv6tI54L2kFBRza5qE7bTidCVYa8l
         8B53P0lFMs4JCHlnUMcWmLWaQZ00XkA/vJYTnU0OfTEDJWRfK1mqlsjgz2CoZIZRSwv2
         mOvkHLR26yI6iDbbp52Doa9Jz2uW8IkdagA4VbnP9kAq6FfL8ZM+r8TYxLrG5kEZhJ+8
         t5ZetrKTb/7Jf7X9fq22D/PQ3f7rKdd3T2r7fWxs7Loj3pM8lvfK+Xw4AfEuYMG9UkW2
         HwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874078; x=1769478878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xv9zEHuRc9c1EY5SUHsPnAlQlZPm41qdCAYpBSnMb3A=;
        b=myiyMAoADsarx3dXVPtJ0t+7OJdoDZzMxlP47rcz3hE3wOB8EkPbLmCGVt1ErCerF4
         TpNSSrQ/UXa5PmQFYcEy0IPzEORSrt/1BwxSwX157vtpj+VX+9RADFjAAH8XSprJZaEY
         VjXWWvX0+SNhCMtvdobwlRYaia2nSYl7scprqZmqm15VPN5uZiqGh5yIzBI0E7sTKBBj
         DhegneuajQeyApFNrFGu1z9OjMiw0efFdcqhhPKSGflPYPAxxoAfSxrBzZdw1DFpdTSM
         d9tbaVDTEYCjCnZZQEqNePJPOheBYWdwP3GDVznAlCOUbhh/L/PtrBw7P4TQ0tGDVQDl
         V5EA==
X-Forwarded-Encrypted: i=1; AJvYcCXSUVNb741d7xJXC5UoyTdJZ8mPBUqMVvdt4VMjFMuIiaGHgP1SCIeoBvtwsgp22Q1pLZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVUJukMgH02x19kTrtSmsiW9d2RClDmQ23jGaAkVpyUjGIz3e
	ys4iO1dBcm3WqEEmuhrNC4YjyRLK17pfQe3hKjqv+D9HAucFt5NHCfRfqz9WRIyCD0zpkFGPfU5
	0338ZYqGvWgTrsbG2+/LCT9glrRD5cgc=
X-Gm-Gg: AY/fxX7v6PmzgGabgmTHNyBxoqhoxieZ/myfBL+GTIvTz08gFQDqpVZHwP7zLcpH6Pm
	jll4S95Vh4Wre0dQPnQ91ZhuwdR6HN+ZX2s1XsRPEqAlArPuWWdwhwFim823to0Xj4/ZUX2TNYa
	I5lbgd5BF4viKPjdREFCghFFsWCgVNM0JD6f1JBVEP7NZJ2jAkcXhPH+QahYzkfI2nRRfTnzTj6
	b2rhnWweZb9t8Dz2wNomIy5k+2Y7IKG8bvRD4PqmcuBzmgsZdgEnHtFq/+UphGbeDrjuAyGU5wN
	mXdPN5EBQVIpuXfAQMWyke1bIcUbtl6ezSRDrifvRLvIJJ53apOqidkPP/sPAl/SP9tqsCnRPdB
	y0EViAxEnKmlSer9lCKx0VZOl
X-Received: by 2002:a05:600c:1990:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-4803e7f3d7bmr2343295e9.32.1768874077525; Mon, 19 Jan 2026
 17:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119142120.28170-1-leon.hwang@linux.dev> <20260119142120.28170-3-leon.hwang@linux.dev>
 <d4b8843b-c5dc-4468-996a-bacc2db63f11@iogearbox.net> <123a63a2-5679-4bd0-9e16-dc5c7dbe3325@linux.dev>
In-Reply-To: <123a63a2-5679-4bd0-9e16-dc5c7dbe3325@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 19 Jan 2026 17:54:26 -0800
X-Gm-Features: AZwV_QgI1vOqbUDCv84FRy90-_qhDpN6djDh15KMF_24bczedT3fPOgBKU_LWFI
Message-ID: <CAADnVQKdHBe2yLgEvVEddgSbgTVvdzK0iC=vzrif5q_FLLTY-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Avoid deadlock using trylock when
 popping LRU free nodes
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:50=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 20/1/26 03:47, Daniel Borkmann wrote:
> > On 1/19/26 3:21 PM, Leon Hwang wrote:
> >> Switch the free-node pop paths to raw_spin_trylock*() to avoid blockin=
g
> >> on contended LRU locks.
> >>
> >> If the global or per-CPU LRU lock is unavailable, refuse to refill the
> >> local free list and return NULL instead. This allows callers to back
> >> off safely rather than blocking or re-entering the same lock context.
> >>
> >> This change avoids lockdep warnings and potential deadlocks caused by
> >> re-entrant LRU lock acquisition from NMI context, as shown below:
> >>
> >> [  418.260323] bpf_testmod: oh no, recursing into test_1,
> >> recursion_misses 1
> >> [  424.982207] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [  424.982216] WARNING: inconsistent lock state
> >> [  424.982223] inconsistent {INITIAL USE} -> {IN-NMI} usage.
> >> [  424.982314]  *** DEADLOCK ***
> >> [...]
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>   kernel/bpf/bpf_lru_list.c | 17 ++++++++++-------
> >>   1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > Documentation/bpf/map_lru_hash_update.dot needs update?
> >
>
> Yes, it needs update.
>
> >> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> >> index c091f3232cc5..03d37f72731a 100644
> >> --- a/kernel/bpf/bpf_lru_list.c
> >> +++ b/kernel/bpf/bpf_lru_list.c
> >> @@ -312,14 +312,15 @@ static void bpf_lru_list_push_free(struct
> >> bpf_lru_list *l,
> >>       raw_spin_unlock_irqrestore(&l->lock, flags);
> >>   }
> >>   -static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
> >> +static bool bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
> >>                          struct bpf_lru_locallist *loc_l)
> >>   {
> >>       struct bpf_lru_list *l =3D &lru->common_lru.lru_list;
> >>       struct bpf_lru_node *node, *tmp_node;
> >>       unsigned int nfree =3D 0;
> >>   -    raw_spin_lock(&l->lock);
> >> +    if (!raw_spin_trylock(&l->lock))
> >> +        return false;
> >>
> >
> > Could you provide some more analysis, and the effect this has on real-w=
orld
> > programs? Presumably they'll unexpectedly encounter a lot more frequent
> > -ENOMEM as an error on bpf_map_update_elem even though memory might be
> > available just that locks are contended?
> >
> > Also, have you considered rqspinlock as a potential candidate to discov=
er
> > deadlocks?
>
> Thanks for the questions.
>
> While I haven=E2=80=99t encountered this issue in production systems myse=
lf, the
> deadlock has been observed repeatedly in practice, including the cases
> shown in the cover letter. It can also be reproduced reliably when
> running the LRU tests locally, so this is a real and recurring problem.
>
> I agree that returning -ENOMEM when locks are contended is not ideal.
> Using -EBUSY would better reflect the situation where memory is
> available but forward progress is temporarily blocked by lock
> contention. I can update the patch accordingly.
>
> Regarding rqspinlock: as mentioned in the cover letter, Menglong
> previously explored using rqspinlock to address these deadlocks but was
> unable to arrive at a complete solution. After further off-list
> discussion, we agreed that using trylock is a more practical approach
> here. In most observed cases, the lock contention leading to deadlock
> occurs in bpf_common_lru_pop_free(), and trylock allows callers to back
> off safely rather than risking re-entrancy and deadlock.

Sorry, trylock is not an option here.

We are not going to sacrifice LRU map reliability for the sake of syzbot.

