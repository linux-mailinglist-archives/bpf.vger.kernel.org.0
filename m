Return-Path: <bpf+bounces-72572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A5EC15B62
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90F51A208DF
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4362040B6;
	Tue, 28 Oct 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6IVMUWl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F97D342C81
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667762; cv=none; b=DxrRE5OmyxZXOysApN+ga8B63oFyCTBmnXiylzRrgH9fK4AB4i0UE6glyBIV7T/fGkAUqbkCr76WYQLx/Bk2fuTuRhB/fElg69q8VZnf/M21+gTaSUm/Fm3SZp/eWRyXEsA8rCi7m5vlQZbbFBmhm4s96WGN34VwvGTer+8I3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667762; c=relaxed/simple;
	bh=dDjULkuYxSeS0Y4oU4SV85womNCpNWdft//C4y9afh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWRoRcJRWU4T1Hc/LKwhmZMRBeJRa4zA5UO3VD/0ASWRlon7sUruG3Ddz7ylC0tWwIU3IquIAlu5zVZ4cwcPasYeP+mjVoCBLyqMJOhlYnww5WmXZaXryZ0xZynF+LnPwJ35Ho1Kc71xyW/ZKDSlcOMsGmB2IMVNDsVLxOXnPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6IVMUWl; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so5636281a12.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761667759; x=1762272559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSbWUkP74jArjI30D0sAE5TvIq/zi84n0bjbO2j3uGY=;
        b=Y6IVMUWlaNg1fG/P/xP/rpsC+LayiWrpGg/RPfpE6OcoNX59m6/62RJidt4xNYDv0s
         UND9VsF+y21GwlP8hJOT8eJ5xdsdVXrX9B94FRxzd2IwcBpL7jYv7STW1GITg5K1Pq38
         go4ZvqRSSijYoGE77uGE841L/jeErIReMuhFzIuuQH9XigF13yxTA9k10RgKRVTkFn/4
         mI7eOdMDYw9ON6pcQ5cDtA8nCYsFlhhhRAm+Rv/qvj+2TiwIxBDZYbqLvfI8AkE/xq0D
         oDBPDr293xPN9NZcpPbh9cH5bA3WGKzC+b12J2+rGgN7v/oDUmIbCbIB1qLUKDLtvlsE
         IBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761667759; x=1762272559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSbWUkP74jArjI30D0sAE5TvIq/zi84n0bjbO2j3uGY=;
        b=NMagyinsk9kfW031RKz2noA/wSqe6fUJgX5OzfwSihONkiDScanHFA0pLjkXFDphtJ
         X4w12we8IUbQFoVvTCIR6S4BoY6FyB2yjFSDHvCCpeLRoOqhvtj+2JZXuhcTLae8An5k
         ML9+J9h/I5wDmAh/+TToeqXIe5nrs9OlfmKb/XqBfNUvjGhpAisG/CRHT3GlnkJDR6pe
         URSA5vFFvT2VwSFGebs6VYWKMPb1KHtTOrgpdYQ27kXon25mJsCX9dWUvMf7oNc326If
         5/pScHfYbeW8Jdt12/D5mWoZw+D+wv81x7h5rVCM6pVRlSUqM+qdiITDIzpav+ceNwqV
         3cpA==
X-Forwarded-Encrypted: i=1; AJvYcCWUVQB3MY9Lnbnz40KbDjMOCYJYYlDEtbN2TeJ3PJpZ3VAV/yuje9pc6WssWTlSYvsIsLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhDhr1xPDsPX/n1PF/Vw59nzxGOqRy5HYRXYCdtlluWK2rlmU
	azDbquTWPsVl559Er/ZiAeKJD/VVQ/g4dgj+5MOeOmjCmDbOKI84uCoqhypvHwjXJu0yu6EIWEV
	m8F6930mXH21ZATHI1n/bLy6eYL7qeD4=
X-Gm-Gg: ASbGncv7m4Vvh7k3Pfyhd8sD9KMOXJ+s04i6dBVnsOHukBzfJm5yblJfJUNyKAVsJZc
	wAwje7ckwmGjRtIfTZ8uexpqsFVt0IMnhlpX1vBOgpwY1ZlXlIOahyUGv0H4r+Qm9CJKA20IX9u
	Cjt30R7v/OpC8c4CFI0ja0yJcbrzVVLAR+RmbeqCdN6usTwfh8oNJuWgc0wtVTLCWVrc9UOfRs/
	m6o0CcLbg+zaFu30x/XzV6IqOBVxYY0+RUqdoPdEqX7Pa3fz9uD5kNiyjIUkeCs/fpARJaKGi2r
	Quktl78fCrk=
X-Google-Smtp-Source: AGHT+IEt+jRXWPKMfkUhwdIG0jbgXiTN2/FnXGOF7GpfKVMtHqrZWr/N2HWc4lHOxmE0NYBa1VyI3gYStNqF+DUuve8=
X-Received: by 2002:a17:902:d487:b0:290:ac36:2ed6 with SMTP id
 d9443c01a7336-294cb3a1287mr46576115ad.14.1761667759122; Tue, 28 Oct 2025
 09:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020133156.215326-1-mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251020133156.215326-1-mehdi.benhadjkhelifa@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 09:09:03 -0700
X-Gm-Features: AWmQ_bldhatN_kMnTkdHZ30UbwaQsKb7ZNir1RyLFpFR6qqrh0QB8XA0s5EslnI
Message-ID: <CAEf4Bzb6hhyyiAyyZZAA2pUZRNmfjAw_63ES8owfGvT_QXMyTw@mail.gmail.com>
Subject: Re: [PATCH v4] selftests/bpf: Change variable types for -Wsign-compare
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	ameryhung@gmail.com, toke@redhat.com, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:32=E2=80=AFAM Mehdi Ben Hadj Khelifa
<mehdi.benhadjkhelifa@gmail.com> wrote:
>
> This is a follow up patch for commit 495d2d8133fd("selftests/bpf: Attempt
> to build BPF programs with -Wsign-compare") from Alexei Starovoitov[1]
> to be able to enable -Wsign-compare C compilation flag for clang since
> -Wall doesn't add it and BPF programs are built with clang.This has the
> benefit to catch problematic comparisons in future tests as quoted from
> the commit message:"
>   int i =3D -1;
>   unsigned int j =3D 1;
>   if (i < j) // this is false.
>
>   long i =3D -1;
>   unsigned int j =3D 1;
>   if (i < j) // this is true.
>
> C standard for reference:
>
> - If either operand is unsigned long the other shall be converted to
> unsigned long.
>
> - Otherwise, if one operand is a long int and the other unsigned int,
> then if a long int can represent all the values of an unsigned int,
> the unsigned int shall be converted to a long int;
> otherwise both operands shall be converted to unsigned long int.
>
> - Otherwise, if either operand is long, the other shall be
> converted to long.
>
> - Otherwise, if either operand is unsigned, the other shall be
> converted to unsigned.
>
> Unfortunately clang's -Wsign-compare is very noisy.
> It complains about (s32)a =3D=3D (u32)b which is safe and doen't
> have surprising behavior."
>
> This specific patch supresses the following warnings when
> -Wsign-compare is enabled:
>
> 1 warning generated.
>
> progs/bpf_iter_bpf_percpu_array_map.c:35:16: warning: comparison of
> integers of different signs: 'int' and 'const volatile __u32'
> (aka 'const volatile unsigned int') [-Wsign-compare]
>    35 |         for (i =3D 0; i < num_cpus; i++) {
>       |                     ~ ^ ~~~~~~~~
>
> 1 warning generated.
>
> progs/bpf_qdisc_fifo.c:93:2: warning: comparison of integers of
> different signs: 'int' and '__u32'
> (aka 'unsigned int') [-Wsign-compare]
>    93 |         bpf_for(i, 0, sch->q.qlen) {
>       |         ^       ~     ~~~~~~~~~~~
>
> Should be noted that many more similar changes are still needed in order
> to be able to enable the -Wsign-compare flag since -Werror is enabled and
> would cause compilation of bpf selftests to fail.
>
> [1].
> Link:https://github.com/torvalds/linux/commit/495d2d8133fd1407519170a5238=
f455abbd9ec9b
>
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> Changelog:
>
> Changes from v3:
>
> -Downsized the patch as suggested by vivek yadav[2].
>
> -Changed the commit message as suggested by Daniel Borkmann[3].
>
> Link:https://lore.kernel.org/all/20250925103559.14876-1-mehdi.benhadjkhel=
ifa@gmail.com/#r
>
> Changes from v2:
>
> -Split up the patch into a patch series as suggested by vivek
>
> -Include only changes to variable types with no casting by my mentor
> david
>
> -Removed the -Wsign-compare in Makefile to avoid compilation errors
> until adding casting for rest of comparisons.
>
> Link:https://lore.kernel.org/bpf/20250924195731.6374-1-mehdi.benhadjkheli=
fa@gmail.com/T/#u
>
> Changes from v1:
>
> - Fix CI failed builds where it failed due to do missing .c and
> .h files in my patch for working in mainline.
>
> Link:https://lore.kernel.org/bpf/20250924162408.815137-1-mehdi.benhadjkhe=
lifa@gmail.com/T/#u
>
> [2]:https://lore.kernel.org/all/CABPSWR7_w3mxr74wCDEF=3DMYYuG2F_vMJeD-dqo=
tc8MDmaS_FpQ@mail.gmail.com/
> [3]:https://lore.kernel.org/all/5ad26663-a3cc-4bf4-9d6f-8213ac8e8ce6@ioge=
arbox.net/
>  .../testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c | 2 +-
>  tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_=
map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
> index 9fdea8cd4c6f..0baf00463f35 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
> @@ -24,7 +24,7 @@ int dump_bpf_percpu_array_map(struct bpf_iter__bpf_map_=
elem *ctx)
>         __u32 *key =3D ctx->key;
>         void *pptr =3D ctx->value;
>         __u32 step;
> -       int i;
> +       __u32 i;
>
>         if (key =3D=3D (void *)0 || pptr =3D=3D (void *)0)
>                 return 0;
> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/t=
esting/selftests/bpf/progs/bpf_qdisc_fifo.c
> index 1de2be3e370b..7a639dcb23a9 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> @@ -88,7 +88,7 @@ void BPF_PROG(bpf_fifo_reset, struct Qdisc *sch)
>  {
>         struct bpf_list_node *node;
>         struct skb_node *skbn;
> -       int i;
> +       __u32 i;
>

this is wrong, i is coming from bpf_for() and is signed int

I'd suggest dropping this patch altogether, it's not helpful and
doesn't fix any real bugs.

pw-bot: cr

>         bpf_for(i, 0, sch->q.qlen) {
>                 struct sk_buff *skb =3D NULL;
> --
> 2.51.1.dirty
>

