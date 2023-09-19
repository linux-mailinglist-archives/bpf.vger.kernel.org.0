Return-Path: <bpf+bounces-10365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFF37A5D5E
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 11:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AFE280352
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A563D3A5;
	Tue, 19 Sep 2023 09:06:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10053D39B
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 09:06:05 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ABDF0
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 02:06:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50309daf971so3992640e87.3
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695114362; x=1695719162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAU9vxgfjQgM8ckwAHtNLAT11Jk7/qxri/tf8kcJzxY=;
        b=UQZb4gJxAK0DMFHCDZzitUAzs7kuL/ZDaV/clBwVp67hoag0prlpgTvuvwJtFsCVa2
         hqdBY2wnJwAHSk+YXti8ieepiq+1sNHq/zK7u//1AuawsPkT3nUaMf5uvSnW+3Q+kFFd
         IxMrfl+SCbCK+hC03NbzNYaeHcI8ltZ0Filh4n6QDkV/89cYXhEBfmceyrSCeP1J2KqU
         8LYJd2c1AjcMiN0wmnCpJ31C97IBz5vZSdODIusQkc5+akpEI1U8aipzpO/WVfmZX/Ta
         nzMTTlKi1V6s+RakbDG1Ww9DFZo5N9Xmyczbiq0u3cSZ5U/lyvdisznPj3Jp8HDHT+B+
         aaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695114362; x=1695719162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAU9vxgfjQgM8ckwAHtNLAT11Jk7/qxri/tf8kcJzxY=;
        b=s5w6LmTLsUdD8EZBSG3JwY613DMBFUo4oV59wGGBNZamTBJfLX6hlwGNlpkwDRQ6Iy
         aUdF5KxzaLsJeW3GFBseHRwZ1XlSx5k9YoeQctFGlkgU0AO+c9ymoQVg3h37frBVd41h
         pZtksNjf+GJAo7IeQsjwOXiVvsLcYZ627W5hCw0pVgvluru48orIFaubqBbz29+zgQuD
         tD4nHaoZDEYFXhd5duuPCZGgFi5Q/0kA3xMG8aRjkPdotG8DHy+n6ceif5eToBJSGlN8
         Yb/v0FENq9+/i6Tr+phIODJkBexflWatnS7cojuvz3ZwcBcP2lnjC04sffrMJ45qbJad
         pkgQ==
X-Gm-Message-State: AOJu0Yzc+wu3GAs3DuEVIpL1/n4iBcfupFcejSVnQoBW2rhfzOicau86
	p59NA++yunWU1ima//f7APvrskYjJAe18yEKwicOcFOxcTk=
X-Google-Smtp-Source: AGHT+IFNED8h/6fkl74FZmlOHfdBVn4EXnChr+tauY00vnrcX80K6HHHgzZxPs/1O+LjW6xQYSkIWW4Fg0KsPX8fHmI=
X-Received: by 2002:a19:5014:0:b0:503:34b4:8149 with SMTP id
 e20-20020a195014000000b0050334b48149mr495994lfb.38.1695114362208; Tue, 19 Sep
 2023 02:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918210110.2241458-1-andrii@kernel.org>
In-Reply-To: <20230918210110.2241458-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Sep 2023 02:05:51 -0700
Message-ID: <CAADnVQ+w4e2K06tPdV8J-TuEvY6ysGv_45PJZe2AkOpYFrx7Og@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: unconditionally reset backtrack_state masks on
 global func exit
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 2:01=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> In mark_chain_precision() logic, when we reach the entry to a global
> func, it is expected that R1-R5 might be still requested to be marked
> precise. This would correspond to some integer input arguments being
> tracked as precise. This is all expected and handled as a special case.
>
> What's not expected is that we'll leave backtrack_state structure with
> some register bits set. This is because for subsequent precision
> propagations backtrack_state is reused without clearing masks, as all
> code paths are carefully written in a way to leave empty backtrack_state
> with zeroed out masks, for speed.
>
> The fix is trivial, we always clear register bit in the register mask, an=
d
> then, optionally, set reg->precise if register is SCALAR_VALUE type.
>
> Reported-by: Chris Mason <clm@meta.com>
> Fixes: be2ef8161572 ("bpf: allow precision tracking for programs with sub=
progs")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bb78212fa5b2..c0c7d137066a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4047,11 +4047,9 @@ static int __mark_chain_precision(struct bpf_verif=
ier_env *env, int regno)
>                                 bitmap_from_u64(mask, bt_reg_mask(bt));
>                                 for_each_set_bit(i, mask, 32) {
>                                         reg =3D &st->frame[0]->regs[i];
> -                                       if (reg->type !=3D SCALAR_VALUE) =
{
> -                                               bt_clear_reg(bt, i);
> -                                               continue;
> -                                       }
> -                                       reg->precise =3D true;
> +                                       bt_clear_reg(bt, i);
> +                                       if (reg->type =3D=3D SCALAR_VALUE=
)
> +                                               reg->precise =3D true;

Looks good, but is there a selftest that can demonstrate the issue?

