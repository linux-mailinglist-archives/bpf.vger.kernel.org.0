Return-Path: <bpf+bounces-12463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69427CC9CD
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 19:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856A0B211CA
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA99345F75;
	Tue, 17 Oct 2023 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZI3IbOD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B01F606
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 17:23:11 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD38BA
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 10:23:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so5232611f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697563387; x=1698168187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlhXyndWVjXaWBwLKAA5B4YLOqLH1J3gmEwgigQ1Mzo=;
        b=QZI3IbODhkhNL014EYzy0C72csh5S2AD/kQtYt3vaOduJd2n5KwUYXduztMuYgNRsJ
         S2ZOAZqPLBeAHpB4/URI28+n9eGEYapDSGGL7QTv2l2wyRAe32GPHYE0ZpxgqYppfznG
         67W9qeBWTuTUVVYE1zwUz1Ny3JojQMEwKxAr5oIgGHNn9+bRRbNWcfwHres3myLdod9a
         xmaUR+/Vt8e7UzhysRd9zTcM04/eHADDpDdCPreihD8gkzZrZwpnRMarQkWxYvEPrMU3
         RnLZ86UXrFOogV7WgknXCmjeG2za25OGj02GzG6wPQrpWhyt2DiSAdcFgLY0XRWFJpbc
         PtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563387; x=1698168187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlhXyndWVjXaWBwLKAA5B4YLOqLH1J3gmEwgigQ1Mzo=;
        b=eBiDThELmlaTMBRJN6O6i8C3A5ae+pSNNlECtI4GhRW9LK2P986AnX7mgKfMZIVRHY
         KbtnE5e8w5vLDggahXfF0noLUl1TZDADqT0SwfSAKG2hN4ajXFDFzl+q1Db0O/+aZXbg
         pVY0yqfF8ZiWQrglHaT2Pvap7BzNk70iKekUuBHM9zX2bOEfqUIANIwR4w4+8tANLo5d
         gMQlFWReIwCFmOKhynOkzYrw2hdkVnq+SUeHTeK/FCnDUiYqVm9jzXBOrITVjOhNT/pM
         GfHlEiFmw/qIhoU89rFq6NP/azAc/geopIhove0ciYAAIcjaUguzskikpdHoVFkRK84A
         mg4Q==
X-Gm-Message-State: AOJu0YyUDefSks5bF0dkYvQ2S0MC1Gi+G5jStBycwctAVghw3lCzX1vb
	ds4+BrV9Zk4FWUmQe/18KUvutR7jTgyYEt6gpdVmbaJg
X-Google-Smtp-Source: AGHT+IEiBMgzmtN1wYaluzQwFdwQ7UN85+eKljlEsi5b/0CMvHJQU2Mado/nVuTEhfP8EcWPi4HsMsoQZHBd9+glpuQ=
X-Received: by 2002:a05:6000:b46:b0:31f:f1f4:ca8e with SMTP id
 dk6-20020a0560000b4600b0031ff1f4ca8emr2672403wrb.36.1697563386784; Tue, 17
 Oct 2023 10:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jzrrwptf.fsf@toke.dk> <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
 <87sf6auzok.fsf@toke.dk> <CAEf4BzaAjisHpVikUNb5sQDdQwNheNJRojoauQvAPppMQJhK9g@mail.gmail.com>
 <87il75v74m.fsf@toke.dk> <ZS6nnJRuI22tgI4D@u94a>
In-Reply-To: <ZS6nnJRuI22tgI4D@u94a>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Oct 2023 10:22:55 -0700
Message-ID: <CAADnVQKG_Tb-ihEU15c2QFxNfCCpbSEaFgD9kKjK-hWSvN1C4g@mail.gmail.com>
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Mohamed Mahmoud <mmahmoud@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 8:26=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> >
> > Sounds good, thank you for looking into it! Let me know if you need me
> > to test a patch :)
>
> Patch based on Andrii's analysis.
>
> Given that both BPF_END and BPF_NEG always operates on dst_reg itself
> and that bt_is_reg_set(bt, dreg) was already checked I believe we can
> just return with no futher action.
>
> ---
>  kernel/bpf/verifier.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9cdba4ce23d2..7e396288aaf0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3418,7 +3418,9 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
>         if (class =3D=3D BPF_ALU || class =3D=3D BPF_ALU64) {
>                 if (!bt_is_reg_set(bt, dreg))
>                         return 0;
> -               if (opcode =3D=3D BPF_MOV) {
> +               if (opcode =3D=3D BPF_END || opcode =3D=3D BPF_NEG) {
> +                       return 0;
> +               } else if (opcode =3D=3D BPF_MOV) {

lgtm. Pls send an official patch with a selftest.

