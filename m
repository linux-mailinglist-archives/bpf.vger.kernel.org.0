Return-Path: <bpf+bounces-2726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D290973363C
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 18:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA401C20E8E
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEC618C07;
	Fri, 16 Jun 2023 16:36:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1F182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 16:36:53 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE6926BA;
	Fri, 16 Jun 2023 09:36:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-985fd30ef48so138806966b.2;
        Fri, 16 Jun 2023 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686933402; x=1689525402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZ/2cnaprLbI2wNpBmKSE5QmI8fvvyfpUiJJFQ63Lj0=;
        b=pGVfex1a1I59pGSmjW/NbaYePvF2g1/jQUZw87Bgt2xKMLoyUsMMv9WgcW7H0BMekw
         NMzTkKdEwTFtNwCzmwLpo5vkNQHLT8WlgitNiIhN0nVCsdSlKmFmr7mj2iIgvP+u2bq4
         TiChMpINy4eL3sF7A7TBJ3ErodvBhbSBELgZ1KvlnNqWUl0Aj32kuga04SRB+kCxka1M
         aE7BCaahOVO8FfHV+VMoqSkbG9NJ6DqXbFx/M7DIW51aWt7Rb8l60JsdU0JHQNvBfZ2o
         gcv17ZCOWZBVS11n4T++0CYSAZnLWe187LFPcJkjXNq8BvcUphYeQc+R7uPB+M3F2iKZ
         3y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686933402; x=1689525402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZ/2cnaprLbI2wNpBmKSE5QmI8fvvyfpUiJJFQ63Lj0=;
        b=BUUnakANFJwbJPEB7DmYjbb7aRDMluvorqLygMaj3Dbb7FK937lZVASncHUAOgvgfl
         yFW6ZxuEbtX8OzVkMmjOT2/ksHfer0sG2vfTrNiE+sGu9Y7f4dYr3VpCVPvH4bLDxsk+
         V5RwUDfliU7DVeyZbOYfEZFyUTI6liRbbydhDmkQNBcXr7JMYrJgV72T7HdlBb4MJWJb
         u1/CjsJT6wVIvzKT3LYIWSARoS+LwIVmKB/A27r4+RgUyl1XPZuknlujn8J7XRdWe1Sh
         kLI6VF9JcRvHNkiJZUCU4VJLcuHlIePKr+UUjruFenYdcf1u1tcRTX4rO40c4sfQHl6j
         0HPg==
X-Gm-Message-State: AC+VfDzigGM5Io5DfyOsl7uf/nYKmSxfNO1LMnFf96hPT8SLK8xnbvqp
	Zi5jw6Rx0YHObK6zP+A7YmC3XonR6iElBOfoMwmlyxtn6j7YYA==
X-Google-Smtp-Source: ACHHUZ6GBfltzqr4B1exwMEy6IY0Upw3JCeOtTnWXW1CMs1BhBfjdoCg7MV0OW/OReNy7aFuJ9mQI1dazLli4hYIwns=
X-Received: by 2002:a17:906:ef0b:b0:94f:29f0:edc0 with SMTP id
 f11-20020a170906ef0b00b0094f29f0edc0mr2456014ejs.44.1686933402015; Fri, 16
 Jun 2023 09:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230614082626.45467-1-luojianhong@cdjrlc.com> <f629797b0b525095352acbf565b48481@208suo.com>
In-Reply-To: <f629797b0b525095352acbf565b48481@208suo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jun 2023 09:36:30 -0700
Message-ID: <CAEf4Bzbs5m6Pt4VZC8LBj5Cnw1--cgMRcR1vqOOTVi1o9yKoqg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: zip: Remove unneeded semicolon from zip_archive_open()
To: baomingtong001@208suo.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 14, 2023 at 1:29=E2=80=AFAM <baomingtong001@208suo.com> wrote:
>
> ./tools/lib/bpf/zip.c:226:2-3: Unneeded semicolon

This is not a very human-readable commit message. Something like

Drop unnecessary semicolon, which triggers (presumable coccicheck?) warning=
:

./tools/lib/bpf/zip.c:226:2-3: Unneeded semicolon


But also this doesn't apply cleanly to bpf-next tree. Please rebase
and resend. Also make sure to have [PATCH bpf-next] prefix in email
subject. Thanks.

>
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>   tools/lib/bpf/zip.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/zip.c b/tools/lib/bpf/zip.c
> index 3f26d629b2b4..88c376a8348d 100644
> --- a/tools/lib/bpf/zip.c
> +++ b/tools/lib/bpf/zip.c
> @@ -223,7 +223,7 @@ struct zip_archive *zip_archive_open(const char
> *path)
>       if (!archive) {
>           munmap(data, size);
>           return ERR_PTR(-ENOMEM);
> -    };
> +    }
>
>       archive->data =3D data;
>       archive->size =3D size;

