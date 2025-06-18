Return-Path: <bpf+bounces-60889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DDFADE19D
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 05:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3AF3BC324
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 03:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427601D5ADE;
	Wed, 18 Jun 2025 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxWbUbdU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F97C1714B7
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750216968; cv=none; b=LBX8hv17f1iy+pZlABXuMpzeq0xm1tQlZkaLS+3t1rUz08cappri/aKVM71REIir/ICnAIGGfds2a+IQU47RmUgQ7x2NbVbYRuSmqDMdngnl55oMOc6bccEKnqNN64k5rHrphchjRymy6gYp5ku2PDnFL6t/ZyuRTEnqYlQUNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750216968; c=relaxed/simple;
	bh=kaPV+kOEwTvJLOinu1qQowYS2VBbPtelFMGOBtGd0Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVBRimhn18x0v4HAkVkIkvm3rO8yzgr+TEWuqJuevlaLWORufkRWzZ+bBLpruDNI6dFoL0SzMmvUsw7D8OrKwhWkUMDYLlTz2O1Ul2LyzuNerEYP531V8xsAsWcRr+jDn7O+U6KZvAXdlyqJZTLRsoCEjwNWjdNfC88U4QyQ1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxWbUbdU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so2223372f8f.0
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 20:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750216965; x=1750821765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBtQ8jifMWWmSRdzmPtiIr3Nf8aJ3Q9zJXZ1Blk4Tj8=;
        b=UxWbUbdUEKb9Cy+vIBg6Gc0MQJRE5dtRVEGEIoWDcWehP9zbWqS0GYBfi57KPuKmNj
         m8O78I9hLWJI9kemofvnz1dHtwyKSW5fhAPAKsZRhYrGohi9Gv4IUN6EjDgPhLyS/G0A
         MZdDlCWXkTdS+Lp0LMY6ZPEPrkAQL0yHn/cDV57nSrod9tTIvDIWNmZEruDGap84u8LO
         p1PWpLaDtyywdqS/YhMcQbyN+SPC6tMIIpQAf66lciC+aU4R3rLlKoItUjfY6W8T+x8h
         sCMBKcE76wvcofpPzorjiiCzM3LJHASAPdLf7+wP6CEOtrm9kkP0H9/gerA3iw8tO8iq
         VtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750216965; x=1750821765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBtQ8jifMWWmSRdzmPtiIr3Nf8aJ3Q9zJXZ1Blk4Tj8=;
        b=qCaR8XS4MYWlBSmGaZFx26R7zGtDVFLae5+H0Zs7I6jNgalg8U2F31WDQecusyUKwF
         qEhpneDncZArH3Db6jeGBoMEsa48V7q7yNGrk7KLDD1RE2enBWoDYCjXIVBrzN2geq9z
         kr85KAM/SS1XjTYlJwMxwVX9QcXqothEdvVj5fE/ag+L90JK4BM9e70yZuv+t4VsGCKw
         zqCRmCo5+cd8Qo+nDAdDm+HmfiBk4dr0Y794bUCxZ2cgLPUjc/8+6XlVZJK8bnVoV+Au
         6BC3iGoVWdtnn5p9JR6FZtf9x36qNMK6NEgtob/ngmbMAyfHaoStIYAAeAcA5oz8ijYM
         2VcQ==
X-Gm-Message-State: AOJu0Yxk7nb8IFVAQN5SSyiP7TaAhV+1moHH/MYAnC8lVn+tnYFBHq0p
	EWFRzDjZeSviAThPqgn0Vs7ih3IRgpu8lSrOsBo0clxUkvP6m2q3RzyCFfeRvHQyfrTvfsDDGSR
	naVgcNBJh0D1JcnIJKw8q+4UpoNMlnsM=
X-Gm-Gg: ASbGncsCxtiW0CX58gbGskUaeD7TjU5LfaUKtE+B+ZCV5xuKOQsZRXwJve1P69wQ9YH
	crijbDGY0fa5r5c6dSBn4UK0eR8kHNgFcPL9FbBmi6jJMg9ypXc2SE9iC4nDnBNHuX9Lp2tGaMG
	im6hId0VYMW1rKVtRa8ACjAJy3xkqPaQV07H+zZD/+s/AG5wSfcf3SK5V61wYxvG3InHc1UvJV
X-Google-Smtp-Source: AGHT+IF921WTiP8Q67ibuGb8BB/cZkpHFhY2PmgdKCS+klNuPWTadq8OkryxBcAy07rjFom2q4KPE4K6a62uXGqMEA4=
X-Received: by 2002:a5d:64ca:0:b0:3a3:6a9a:5ebf with SMTP id
 ffacd0b85a97d-3a5723a352dmr14797342f8f.20.1750216965221; Tue, 17 Jun 2025
 20:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com> <20250615085943.3871208-9-a.s.protopopov@gmail.com>
In-Reply-To: <20250615085943.3871208-9-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Jun 2025 20:22:34 -0700
X-Gm-Features: Ac12FXzQrjmKmljBWxz3OsnmycLnoD5FW-rCUEjlmvi1vWPyAdB6IPDyBPsD6AA
Message-ID: <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> The final line generates an indirect jump. The
> format of the indirect jump instruction supported by BPF is
>
>     BPF_JMP|BPF_X|BPF_JA, SRC=3D0, DST=3DRx, off=3D0, imm=3Dfd(M)
>
> and, obviously, the map M must be the same map which was used to
> init the register rX. This patch implements this in the following,
> hacky, but so far suitable for all existing use-cases, way. On
> encountering a `gotox` instruction libbpf tracks back to the
> previous direct load from map and stores this map file descriptor
> in the gotox instruction.

...

> +/*
> + * This one is too dumb, of course. TBD to make it smarter.
> + */
> +static int find_jt_map_fd(struct bpf_program *prog, int insn_idx)
> +{
> +       struct bpf_insn *insn =3D &prog->insns[insn_idx];
> +       __u8 dst_reg =3D insn->dst_reg;
> +
> +       /* TBD: this function is such smart for now that it even ignores =
this
> +        * register. Instead, it should backtrack the load more carefully=
.
> +        * (So far even this dumb version works with all selftests.)
> +        */
> +       pr_debug("searching for a load instruction which populated dst_re=
g=3Dr%u\n", dst_reg);
> +
> +       while (--insn >=3D prog->insns) {
> +               if (insn->code =3D=3D (BPF_LD|BPF_DW|BPF_IMM))
> +                       return insn[0].imm;
> +       }
> +
> +       return -ENOENT;
> +}
> +
> +static int bpf_object__patch_gotox(struct bpf_object *obj, struct bpf_pr=
ogram *prog)
> +{
> +       struct bpf_insn *insn =3D prog->insns;
> +       int map_fd;
> +       int i;
> +
> +       for (i =3D 0; i < prog->insns_cnt; i++, insn++) {
> +               if (!insn_is_gotox(insn))
> +                       continue;
> +
> +               if (obj->gen_loader)
> +                       return -EFAULT;
> +
> +               map_fd =3D find_jt_map_fd(prog, i);
> +               if (map_fd < 0)
> +                       return map_fd;
> +
> +               insn->imm =3D map_fd;
> +       }

This is obviously broken and cannot be made smarter in libbpf.
It won't be doing data flow analysis.

The only option I see is to teach llvm to tag jmp_table in gotox.
Probably the simplest way is to add the same relo to gotox insn
as for ld_imm64. Then libbpf has a direct way to assign
the same map_fd into both ld_imm64 and gotox.

Uglier alternatives is to redesign the gotox encoding and
drop ld_imm64 and *=3D8 altogether.
Then gotox jmp_table[R5] will be like jumbo insn that
does *=3D8 and load inside and JIT emits all that.
But it's ugly and likely has other downsides.

