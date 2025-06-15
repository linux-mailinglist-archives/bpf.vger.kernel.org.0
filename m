Return-Path: <bpf+bounces-60672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88346ADA14B
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 10:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA9816FACB
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529C2248881;
	Sun, 15 Jun 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5DzX/bu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392701802B;
	Sun, 15 Jun 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749976517; cv=none; b=RoLOMgIX/LxOuUvZ+kviONE9VCavrO8pTWZTWXrlev4EHR0VXWrS6xggTzhBcTSY8RWHotVNH6M9SMvN6GXhm3OK3GYLIBsJ4SU1M47Wc3Bcw2KpFq+yjNakSNiiiYDwl6Cm1P2kyVWu3AHqnajBW7F40LfSQIpI/6dN0o0rxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749976517; c=relaxed/simple;
	bh=RJZhrE7PzCL8Zpa7mp4JGUU29v+ACkiAF9wEYA3Zd8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WazoxmY8SRgXbSUBcvhY7j1kkVYZ0BFf3U+cliwe9OsUURPNj1qMl8v4UKWU+WxxmaQaMrVMnC8twC199Eu3muVGgnSUHXELk1sIE63kkygzHcqlSXTNqpasemSSbSVlpimiDGfhiWuZ69wUvtvRshr7cfL9AWgrL7btbAXi7BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5DzX/bu; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e819ebc3144so2768885276.0;
        Sun, 15 Jun 2025 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749976515; x=1750581315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKr92vC3q/gNbrOJr8Myyh2yxu/kwv/3TMILmmjx3tQ=;
        b=E5DzX/bu7SOs0T/FxExk/J60eGoIEGWIXK61RS4/zATinr1mNE50nLxRPIUuJdMctm
         QKkNz1BfBSqp6louxYG/SApEiBKX0P4ME5Bi4bzWd5i9IRW9zvmQCfJafwqIkEdgYMVz
         pT0KS2xJzORhptGlKIVuADP8H9fUnZQhokDy4iVXwLrflognNDqzcM8wwjVTAYjvBMbn
         Y0CUfcDFTuB7whbueLid42g0KJQgtn7NrvtmDaxG3hmT36Fvut4S3aHMAWmaat4mLeco
         9jjiVeDIx19McVHfnwXP7o5Ha1aAXb9xj7M90CtMGxosugKIPGcFmqN52eMm7n81A0P8
         u3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749976515; x=1750581315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKr92vC3q/gNbrOJr8Myyh2yxu/kwv/3TMILmmjx3tQ=;
        b=GZaKA8WC7zCcnEUL88bJM5d9lA3K/XGTaajP/l++0IqUaaRe6Qum0wi+kqkpCMKS57
         GH5rT6FnLDsU5fJN+tEjGxXkWigoA1JlvBqlmFeOSkY3AUbkHmMxFntLFNB7gb20MO2C
         L73rvbKi2795RetGlM8ZobR5kOLWYyJN7PZqFTIAlc/eb2JZH65ULU25aTF/uGIu6CZL
         WS4Z8Dm/M54oF4cbj7FEwR3Ub+guQj+hWA0znAEglOIrgK+d3923TyL0Uz8x42f8c+Rn
         xNyXpqA3+hW2vFTrdUEmdjQj4WxWnQEO3O+7oF0t29wUKiR1xDUSuebdHs1JNNEiiRjA
         8E9w==
X-Forwarded-Encrypted: i=1; AJvYcCVkDqOrpvKGc2lH2kh432ggznJMBfAwFBrIK/5VBVC7Qs+NjasnEkOvfW8FjqnjF54wlRY=@vger.kernel.org, AJvYcCW5YnetBJXc8QmeyWfF8YcuHpT8VlDiXXEd8lrEN14hiPFoiMwPS+2of66KWJVAlBBJHIxINeSqOewI9+3j@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrdP184np+dUgVjqUgi38ZGNbDBTcfOKKl6gD2hWePDXvgU53
	DmPg0cFxZ38O8LAcq155oYcHQB0A+P4LTTpCcd55owyLXK1XneMlCTGp2xZUZ9dddy+zhZRkbNL
	FMSWdnqed9B/Pywx8j0nZzpk3uXVp0lk=
X-Gm-Gg: ASbGncsuXDI6aXPlS1wVK55UarvQTqRxA1Mb3Wr6rCFa4SclmcC4PJ4ndnexXleFBwx
	Tw/7lYFjNt77WMesL8/svjldz6MLIOMyAUP2gnhkQFG8VEQ9yRb356YS7MDAs3kG9pCIH8XQR9k
	0acao8wjZb64KNxUocsZHJpm3dQNjqAZyDIOndMk/Y9jw=
X-Google-Smtp-Source: AGHT+IGnZs26f3l+TS+oC6Nr/Qk1KQ6ClZAppxMi6biNcH13pA5jD3NrjEDgQof/+5Q8+W+6mkAtCmUzYTiltKw6tyU=
X-Received: by 2002:a05:6902:2387:b0:e81:9e01:3db3 with SMTP id
 3f1490d57ef6-e822ac716ebmr7725518276.22.1749976515049; Sun, 15 Jun 2025
 01:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
 <CAADnVQ+G+mQPJ+O1Oc9+UW=J17CGNC5B=usCmUDxBA-ze+gZGw@mail.gmail.com>
 <CADxym3YhE23r0p31xLE=UHay7mm3DJ8+n6GcaP7Va8BaKCxRfA@mail.gmail.com>
 <CAADnVQ+Qn5H7idVv-ae84NSMpPHKyKRYbrn30bVRoq=nnPq-pw@mail.gmail.com>
 <CADxym3bK503vi+rGxHm5hj814b8aaxbQW17=vwLYszFncXMXhQ@mail.gmail.com> <CAADnVQL1KBYE3ev6b1gvve_miDhfxSV=6y5QYWEhG5ynPwti-g@mail.gmail.com>
In-Reply-To: <CAADnVQL1KBYE3ev6b1gvve_miDhfxSV=6y5QYWEhG5ynPwti-g@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 15 Jun 2025 16:35:05 +0800
X-Gm-Features: AX0GCFtBHKw3u4LU2zqVND1zBq0eKpDnOUkq_AowY5AP3USSeo4RssglTYaWg5s
Message-ID: <CADxym3Z20MUDRuhAyJKeNSJ0Es5nBh6abGaQ3tE590xmwjrh0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/25] bpf: tracing multi-link support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 8:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 11, 2025 at 5:07=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Hi Alexei, thank you for your explanation, and now I realize the
> > problem is my hash table :/
> >
> > My hash table made reference to ftrace and fprobe, whose
> > max budget length is 1024.
> >
> > It's interesting to make the hash table O(1) by using rhashtable
> > or sizing up the budgets, as you said. I suspect we even don't
> > need the function padding part if the hash table is random
> > enough.
>
> I suggest starting with rhashtable. It's used in many
> performance critical places, and when rhashtable_params are
> constant the compiler optimizes everything nicely.
> lookup is lockless and only needs RCU, so safe to use
> from fentry_multi.

Hi, Alexei. Sorry to bother you. I have implemented the hash table
with the rhashtable and did the bench testing with the existing
framework.

You said that "fm_single has to be within couple percents of fentry"
before, and I think it's a little difficult if we use the hashtable without
the function padding mode.

The extra overhead of the global trampoline can be as follows:
1. addition hash lookup. The rhashtable is O(1), but the hash key
compute and memory read can still have a slight overhead.
2. addition function call to kfunc_md_get_noref() in the asm, which is
used to get the function metadata. We can make it inlined in the
function padding mode in the asm, but it's hard if we are using the
rhashtable.
3. extra logic in the global trampoline. For example, we save and
restore the reg1 to reg6 on the stack for the function args even if
the function we attached to doesn't have any args.

following is the bench result in rhashtable mode, and the performance
of fentry_multi is about 77.7% of fentry:

  usermode-count :  893.357 =C2=B1 0.566M/s
  kernel-count   :  421.290 =C2=B1 0.159M/s
  syscall-count  :   21.018 =C2=B1 0.165M/s
  fentry         :  100.742 =C2=B1 0.065M/s
  fexit          :   51.283 =C2=B1 0.784M/s
  fmodret        :   55.410 =C2=B1 0.026M/s
  fentry-multi   :   78.237 =C2=B1 0.117M/s
  fentry-multi-all:   80.090 =C2=B1 0.049M/s
  rawtp          :  161.496 =C2=B1 0.197M/s
  tp             :   70.021 =C2=B1 0.015M/s
  kprobe         :   54.693 =C2=B1 0.013M/s
  kprobe-multi   :   51.481 =C2=B1 0.023M/s
  kretprobe      :   22.504 =C2=B1 0.011M/s
  kretprobe-multi:   27.221 =C2=B1 0.037M/s

(It's weird that the performance of fentry-multi-all is a little higher
than fentry-multi, but I'm sure that the bpf prog is attached to all the
kernel functions in the fentry-multi-all testcase.)

The overhead of the part 1 can be eliminated with using the
function padding mode, and following is the bench result:

  usermode-count :  895.874 =C2=B1 2.472M/s
  kernel-count   :  423.882 =C2=B1 0.342M/s
  syscall-count  :   20.480 =C2=B1 0.009M/s
  fentry         :  105.191 =C2=B1 0.275M/s
  fexit          :   52.430 =C2=B1 0.050M/s
  fmodret        :   56.130 =C2=B1 0.062M/s
  fentry-multi   :   88.114 =C2=B1 0.108M/s
  fentry-multi-all:   86.988 =C2=B1 0.024M/s
  rawtp          :  145.488 =C2=B1 0.043M/s
  tp             :   73.386 =C2=B1 0.095M/s
  kprobe         :   55.294 =C2=B1 0.046M/s
  kprobe-multi   :   50.457 =C2=B1 0.075M/s
  kretprobe      :   22.414 =C2=B1 0.020M/s
  kretprobe-multi:   27.205 =C2=B1 0.044M/s

The performance of fentry_multi now is 83.7% of fentry. Next
step, we make the function metadata inlined in the asm, and
the performance of fentry_multi is 89.7% of the fentry, which is
close to "be within couple percents of fentry":

  usermode-count :  886.836 =C2=B1 0.300M/s
  kernel-count   :  419.962 =C2=B1 1.252M/s
  syscall-count  :   20.715 =C2=B1 0.022M/s
  fentry         :  102.783 =C2=B1 0.166M/s
  fexit          :   52.502 =C2=B1 0.014M/s
  fmodret        :   55.822 =C2=B1 0.038M/s
  fentry-multi   :   92.201 =C2=B1 0.027M/s
  fentry-multi-all:   89.831 =C2=B1 0.057M/s
  rawtp          :  158.337 =C2=B1 4.918M/s
  tp             :   72.883 =C2=B1 0.041M/s
  kprobe         :   54.963 =C2=B1 0.013M/s
  kprobe-multi   :   50.069 =C2=B1 0.079M/s
  kretprobe      :   22.260 =C2=B1 0.012M/s
  kretprobe-multi:   27.211 =C2=B1 0.011M/s

For the overhead of the part3, I'm thinking of introducing a
dynamic global trampoline. We create different global trampoline
for the functions that have different features, and the features
can be:
* function arguments count
* if bpf_get_func_ip() is ever called in the bpf progs
* if FEXIT and MODIFY_RETURN progs existing
* etc.

Then, we can generate a global trampoline for the function with
minimum instructions. According to my estimation, the performance
of the fentry_multi should be above 95% of the fentry with
function padding, function metadata inline and dynamic global
trampoline.

In fact, I implemented the first version of this series with the dynamic
global trampoline.However, that makes the series very very complex.
So I think it's not a good idea to mention it in this series.

All in all, the performance of the fentry_multi can't be within a couple
percents of fentry if we use rhashtable only according to my testing,
and I'm not sure if I should go ahead :/

BTW, the Kconfig I used in the testing comes from "make tinyconfig", and
I enabled some config to make the tools/testing/selftests/bpf can be compil=
ed
successfully. I would appreciate it if someone can offer a better and
authoritative Kconfig for the testing :/

Thanks, have a nice weekend!
Menglong Dong

