Return-Path: <bpf+bounces-34337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2211192C7CC
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 03:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E811F231E5
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EE13207;
	Wed, 10 Jul 2024 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mywl+pqY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131C1392
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 01:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573765; cv=none; b=qb0D5GY8kY8x1A0WDdh6iO3uQBxtAzq86UpzT+ASJcOMZ88eJ1MlFD0tEV4qWX03jB9RQP3x6GGc4Q6bc8j1tbI1CdKsuWn+YuLNe/CB5iDq7AhlEJawetrcEYQcEU7Y84+bq5TRIU0R/8+WKAS5dz2eLcQwXxiwvRn0RlqPAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573765; c=relaxed/simple;
	bh=CeUYUlAgn/2rq0KeEjeEyzh+bRGWR2qeg1Br7jGxYYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlN4xtEQ4NatrfSyeRnvlB44GyeNJn3n33781BgfLrDCdjUfdjgDrx2BedC5MS+Xvqrw5FK3tcFkoz3MkxyHscwYzGdWhFcBXZkcRwAKmK0J4WrykeHyQrR2ySnQ6C9C7tVsadZKv93lLU1c8ifOiX25aBoQHGvlb8jrhGWiZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mywl+pqY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367940c57ddso3742996f8f.3
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 18:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720573762; x=1721178562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqI4XHVyomqzc8RaioQx3RH59MCj1wlo1TLrHcs9UEY=;
        b=Mywl+pqY+7p6zc+lohpgGOAk1H3wBjxRVFvDVBJMWrnnT61sZllfDoSujTgYijH6F7
         rGalveyxf3z3sMj+3N3Fph9PhjjxEqVPx3ISNvjRAJKKwkfZ1GhaVTp6qXzJ09nj/9UT
         kIo0gka3YhgpT8atjfZQA0T3bmy43aZedqwoNJzHyOtB6S0TqBqFYjhI9uRthtOxr45y
         bpnCJFrpjmx9M84m9DjHSZ1XKSJI/1HgHWpO33DnW3LyK/56/aaxPig9tMuqDY6L2V7f
         tFf7TZFsXj1v5fmBBrpmezemofdhwJOTEoSOM8Q8RetxZsANsxugZ0l5R5pA/QuyKAPL
         YnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720573762; x=1721178562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqI4XHVyomqzc8RaioQx3RH59MCj1wlo1TLrHcs9UEY=;
        b=VH40kCHSK8Hx8yJxDO0SDlu6FReZsLbcOCRLyg2p3IveM8/gYN/L/Os9SjUbnUg9rR
         CVw4EIx5nSkcF5t+SI7wZ7SXIBEaTkhm7ciznsWZVharlLR1ycerppzshiWKExDPrrpY
         QTzpZkdIDAJD6z27pzN30nCzt8NzHxeAT04XkWk/+dIsepYhs9XdUTvyzYeBQtxPk2A7
         Ll1ovbMoBGOiZ1vOeufsrZEPQPlihVPgctIb1EZ7WyCh+OeQSfGpELZ4pB70U2Eluclb
         qmTeMJw4UNRes9nJh1F83eaySKg4D3mP+6/ocu1TC3jPrN9SwweceGhZisuKvHgFYFqO
         jAmg==
X-Gm-Message-State: AOJu0YwZO2lU5UkhIFPjop6jsuViBCwlpQ4YETQB2Me0iCuG6qNE8mau
	rD4TORcCDcosgRLqAH890Pv4vm7kp3xxGESTxHDVlp+ixhAyhqUySor6RV5eGrWWv9rcObkQenf
	SiyoFOZ49IhJ2pfeI8skUEQNgqjhhiDPIplA=
X-Google-Smtp-Source: AGHT+IGeCi3ZJtJHp7IlrgTD+30bXAFNtKaCzxakauUoY+4kvHnwVfhJTsYis7fpjfPjGAB46usR5bsd+CjVK3VLC9M=
X-Received: by 2002:adf:f649:0:b0:367:434f:caa2 with SMTP id
 ffacd0b85a97d-367ce5ded5bmr2717223f8f.0.1720573761781; Tue, 09 Jul 2024
 18:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-3-eddyz87@gmail.com>
In-Reply-To: <20240704102402.1644916-3-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Jul 2024 18:09:10 -0700
Message-ID: <CAADnVQ+10YQwcddP=oE_NyUyr1WkfW9JoeuNQg3pZb9qK6X6Cw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 3:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> +                       for (j =3D 1; j <=3D spills_num; ++j) {
> +                               if ((insn - j)->off >=3D subprogs[cur_sub=
prog].nocsr_stack_off ||
> +                                   (insn + j)->off >=3D subprogs[cur_sub=
prog].nocsr_stack_off) {
> +                                       /* do a second visit of this inst=
ruction,
> +                                        * so that verifier can inline it
> +                                        */
> +                                       i -=3D 1;
> +                                       insn -=3D 1;
> +                                       goto next_insn;
> +                               }
> +                       }
> +
> +                       /* apply the rewrite:
> +                        *   *(u64 *)(r10 - X) =3D rY ; num-times
> +                        *   call()                               -> call=
()
> +                        *   rY =3D *(u64 *)(r10 - X) ; num-times
> +                        */
> +                       err =3D verifier_remove_insns(env, i + delta - sp=
ills_num, spills_num);
> +                       if (err)
> +                               return err;
> +                       err =3D verifier_remove_insns(env, i + delta - sp=
ills_num + 1, spills_num);
> +                       if (err)
> +                               return err;
> +
> +                       i +=3D spills_num - 1;
> +                       /*   ^            ^   do a second visit of this i=
nstruction,
> +                        *   |            '-- so that verifier can inline=
 it
> +                        *   '--------------- jump over deleted fills
> +                        */
> +                       delta -=3D 2 * spills_num;
> +                       insn =3D env->prog->insnsi + i + delta;
> +                       goto next_insn;
> +               }

somewhere after spill/fill removal subprog->stack_depth
needs to be adjust to nocsr_stack_off,
otherwise extra stack space is wasted.
I couldn't find this logic in the patch.

Once the adjustment logic is done, pls add a selftest with
nocsr and may_goto, since may_goto processing is in the same
do_misc_fixups() loop and it needs to grow the stack while
spill/fill removal will shrink the stack.

