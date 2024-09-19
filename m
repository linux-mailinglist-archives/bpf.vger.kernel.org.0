Return-Path: <bpf+bounces-40078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BAF97C34F
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 06:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638AC282B71
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 04:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E038179BB;
	Thu, 19 Sep 2024 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhSSgiVM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E812E48
	for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726719953; cv=none; b=EJ9srMDA/F3UTT8PnYyZpuN8dWw+yN36moGpF/O4kD3XzBtAsm18CgoyV89SzMesGp2ScLmPuAb9tH8n2aZpSm1Ocl7uzEp4bVpTto/qUTjS+b6Lwfq5hwJ6EpVAEL1rNIjnD4beqXkMWrCybZLfEjFpPQ4HcDKJa0O18WMz4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726719953; c=relaxed/simple;
	bh=YQ2vbtqWXOIrlvauJzBNf03kfsiYeKVIfGDjTbeqUyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzYk8a8lsgfJ08l3dIDYDZXS2g9Jxzp8d4pc6+b/F+NDolM3L9UTpJN9xntFsaa15a5+VqWbi6/wSSUzFSOvyxQHyx6H8O8yC4AUqzbji3zi2OXi/BNobtmYQCiUNbzHnkDnqOA2z3dgduqw/CQ+/up3oRLBqHD2m21x898qqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhSSgiVM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso346384a91.2
        for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 21:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726719951; x=1727324751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k+/O16tTVM0TwHFk4dgg9EQuGvCpoiIp73uN1Xwxwo=;
        b=JhSSgiVMvduFx7Jng3Rsc2dsUCh2t4buKJQ5TWId1Ec6Jb++evs2qRZ9K9XBXZMgQP
         rJe+pHDRLkSeZb4VkvfKk87xscHBhfD9CIZ6I5Ke3ZkF6Em1eTHWGCHOeKIKSUihsMGR
         j9/3LRV4l5JIZ3AnPd42rJ+t9l8VDOqrNmPz4QzpMYor0ZJN1JOc8gp1tJd/AObY0cIu
         CkCTy+8h48wQZ9wmLIngSEJhxGzTA/nMA8ztiy4Ua6gjTqIsODTAqo9JVROQlfQuFrik
         qIe+O5BAAcZ284rXkxPSPfhb8b9cefanVIbyqnnP3kegz70vDV00PVDpxy/guEHsnbpR
         59Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726719951; x=1727324751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4k+/O16tTVM0TwHFk4dgg9EQuGvCpoiIp73uN1Xwxwo=;
        b=qfIEZ0shnBLP22E6GrQDET4PnVzIgvE9QBJoAc/dfi+ZLFK4ZxAs/+ZTThSzNLcJLH
         xRihH9nGd+TUFBM2m7iTYFzY1X0I9N/csjiHR+vh2xBi9SkO6fmsoOnPLhiz/zQXOUPJ
         18X2HczDQK5b9fAVHs4dINQfRav/4Oj//bAY+vU3TbSnijVEkylbaenG/LtMBZdzWZ9b
         6ZRhgP8hjLEgyMbQympNckvIodAg2M3eNXj7t7zxBL8uy/WLWSZ3VD9cgS2P1wU6FP1Q
         +X60joe3ujsY9+vBaWVXwMRaMNqYmvEpXNtDaR/aIw4am/+vQplHZaKHceYUwG3zU99v
         8qmg==
X-Forwarded-Encrypted: i=1; AJvYcCWQYa/HJBbKAxukcYvAKZsz2Ys2ghD2y0DcyAO5oCnY3LUbGxIgeB8oI4hdU90OpXeedqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBx8l0xBkQTLDTLswtGnG/aXHCfMsjLPvY3B3knu1c5zqx1JPr
	UvfcgxhPGH9fJG3H2/EVuv5v4OYZOlsm9calXkNKKXv2SfvOCGs5dsG2+Oen+6AcQhjtvci7TU0
	N1ePHy+43Xac5tn1kVTuSGOIC3XM=
X-Google-Smtp-Source: AGHT+IHBZ4Apgiji/NAjRL91Eh6v2BBTUz+jdNsHw3TIma9o/r0Ftoh5556zeXjg+xxVvLOzI4GjE9aPQYRbpCtfV4s=
X-Received: by 2002:a17:90a:1b81:b0:2d8:d254:6cdd with SMTP id
 98e67ed59e1d1-2dba00692e8mr22563473a91.38.1726719950919; Wed, 18 Sep 2024
 21:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918193319.1165526-1-ihor.solodrai@pm.me> <a63ec24f6a54173d29a7b88ef679b2aa942d606a.camel@gmail.com>
In-Reply-To: <a63ec24f6a54173d29a7b88ef679b2aa942d606a.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 19 Sep 2024 06:25:39 +0200
Message-ID: <CAEf4Bza3JcUQP8KikcizW5-K_JpvZFeXr9aJvOCeO1VD+qySoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: change log level of BTF loading error message
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 11:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2024-09-18 at 19:33 +0000, Ihor Solodrai wrote:
> > Reduce log level of BTF loading error to INFO if BTF is not required.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> > ---
>
> fwiw, I took verifier_bswap.bpf.o and replaced .BTF section with empty
> one inside it:
>
>     for s in .BTF .rel.BTF .BTF.ext .rel.BTF.ext; do objcopy --remove-sec=
tion $s verifier_bswap.bpf.o; done
>     touch empty
>     objcopy --add-section .BTF=3Dempty verifier_bswap.bpf.o
>
> And modified veristat to show log level for libbpf messages:
>
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -187,6 +187,7 @@ static int libbpf_print_fn(enum libbpf_print_level le=
vel, const char *format, va
>                 return 0;
>         if (level =3D=3D LIBBPF_DEBUG  && !env.debug)
>                 return 0;
> +       fprintf(stderr, "%d: ", level);
>         return vfprintf(stderr, format, args);
>  }
>
> And here is the output for veristat loading modified verifier_bswap.bpf.o=
:
>
>     ./veristat -d /home/eddy/work/tmp/verifier_bswap.bpf.o  -f bswap_16
>     PROCESSING /home/eddy/work/tmp/verifier_bswap.bpf.o/bswap_16, DURATIO=
N US: 26, VERDICT: success, VERIFIER LOG:
>     verification time 26 usec
>     stack depth 0
>     processed 3 insns (limit 1000000) max_states_per_insn 0 total_states =
0 peak_states 0 mark_read 0
>     2: libbpf: loading object from /home/eddy/work/tmp/verifier_bswap.bpf=
.o
>     2: libbpf: elf: section(2) socket, size 80, link 0, flags 6, type=3D1
>     2: libbpf: sec 'socket': found program 'bswap_16' at insn offset 0 (0=
 bytes), code size 3 insns (24 bytes)
>     2: libbpf: sec 'socket': found program 'bswap_32' at insn offset 3 (2=
4 bytes), code size 3 insns (24 bytes)
>     2: libbpf: sec 'socket': found program 'bswap_64' at insn offset 6 (4=
8 bytes), code size 4 insns (32 bytes)
>     2: libbpf: elf: section(3) license, size 4, link 0, flags 3, type=3D1
>     2: libbpf: license of /home/eddy/work/tmp/verifier_bswap.bpf.o is GPL
>     2: libbpf: elf: section(18) .BTF, size 0, link 0, flags 0, type=3D1
>     2: libbpf: elf: section(19) .symtab, size 336, link 20, flags 0, type=
=3D2
>     2: libbpf: BTF header not found
>     0: libbpf: Error loading ELF section .BTF: -22.
>     ...
>
> Note the log level is 0 which corresponds to LIBBPF_WARN.
> So, if the goal is to move all optional invalid BTF messages to info
> level there are probably a few more places to modify.
>

Nowadays the expectation is that the BPF program will have a valid
.BTF section, so even though .BTF is "optional", I think it's fine to
emit a warning for that case (any reasonably recent Clang will produce
valid BTF).

Ihor's patch is fixing the situation with an outdated host kernel that
doesn't understand BTF. libbpf will try to "upload" the program's BTF,
but if that fails and the BPF object doesn't use any features that
require having BTF uploaded, then it's just an information message to
the user, but otherwise can be ignored.

tl;dr, I think Ihor's patch is fine and sufficient. bpf-next is
closed, will apply when it reopens.

