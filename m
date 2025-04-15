Return-Path: <bpf+bounces-56010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A5A8ABCD
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 01:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD373BD9FC
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 23:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913D2D86B1;
	Tue, 15 Apr 2025 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1SoTb9h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAEE1DF985;
	Tue, 15 Apr 2025 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758335; cv=none; b=Ds7Lskl4Lp9SxaRZvq7q2bbGhqwH6li5kfdEZO49rUnB0gNklYExcQIRQeCAq5cHeiMxPVSWuj6zFKx+wuU8E2ugvOfdAY4F82Gf7Y3WYrvmSwDNhnnDKx8pikWAAF8m+YnAWCGQvO+i13LwpHPPzY5rybImvzPuJk5W6nam3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758335; c=relaxed/simple;
	bh=RfooZBT8K7iwt7juUpH9RO2fvlvpWUjcBJ89UqEGu60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQ+DtAtDxvDEnsgoVB5yDUCGXJEmu3fnTssWKxJD4hGjULYx86iSPhjukT2stTMERDxBnwkktiBPCh+0BZK+Cy1GYozpApJdh6H+Gf73xNyBKhCyVJbBezNwnv5JW4uqWSVavyKvQc6UWrvGJy408+dAzdkbOqJSmesjd1tjgCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1SoTb9h; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af5139ad9a2so4293633a12.1;
        Tue, 15 Apr 2025 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744758333; x=1745363133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AKmCMVNeJ4MCzblqCGi6MBa0tXdxZ3TXzn2jBQ3JJg=;
        b=J1SoTb9hzAfq9ErhHVVt3JQ5vRZBu8qbNCSif8xDl66M6TPFH6ESdfGd4Eqbs7TU9s
         15ZACQePxjW52S8Yn0bcgHNyAGVI0SHC1Y4FKOODvYELgQTbsC3KupvRntDQt+bjK0ev
         HRvnn/A9ldmoAeY+lYkmuVeXidhLoK/TbhGWoNy/zkcgfjFarnjcPzEX9N+tsJ16G/1V
         lQ9l+RiiygIlQ/f1OtNAeAOduDUzv9BE8fc/AMDVLswdSPkamASpDGU6MG00LaWYqkSU
         rAKKx4DbahNsugap2s/5IE78fnjfOFasw6/vo3/dUogjtg+5cvsOTMWzneuOKBuJpQlM
         xDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744758333; x=1745363133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AKmCMVNeJ4MCzblqCGi6MBa0tXdxZ3TXzn2jBQ3JJg=;
        b=sTigVvb0lrcliROdYHMMqqVOgu3WDvk3r8Z+Epi8KJkAzKRrfL0fNOGLW7j0Be6NUp
         gZRFvKx8KWpBVnWhvJXfxRjhajdyXRHrS/A320I6+j/l3L8gswESWJuy0EF6UzrvHVdG
         fX0w9YA8/6kNsXYuXsealv6+x4TWY5L/wNcftlQ2DEsI+sCz68vzVgTKCLygAhyv+Ve0
         Fd511D5OzYCTxes181t6fp/N4IiO3JyDaWrAJG+kvYHZ7jf9+PX4CwztiJB547SId7N6
         FAxFarkYq/HIIIzqBXCjVoMGB9E/OoFXUQMt4VC1FrXhD5muuIGcMTby1JD/mu2prqxv
         OFaw==
X-Forwarded-Encrypted: i=1; AJvYcCVNU3Wb1htR7cOXVGVD+WSwqbHdNr/D63N2R6JPHPKDQ/mBdoXCSMdvfkPksTX4TufDHcp6yrZSpAOkKTTb@vger.kernel.org, AJvYcCVdt1AltQBe8uD0+1rZw9D7ddYPU0UFmiLUK2wCbVqrdC3OEryyQfsmRgxCp779OCK9J6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwvqzH9S/DrdhXoWpXkrMnyqYQD4CbevBdaZf+LKRWxgp7eJ3t
	QG9T5wvY1qwuWffXWFsk+TdxSQoMg7Y1/oOo5hNTqlOzyLloN66jWIz8LLyeoe4zjJuNGE4GNEh
	xhS+/olpo/0qqUdZpqm8BmqsbKGI=
X-Gm-Gg: ASbGnct+o/BQYV91dNojL7dhfaAfbrLl/IfhCoclCgrxYre6i9fqg4xthZEdEsmFXeg
	sV0iO39eyrSnUCgRj5o198TmiEt/8QL5MDChNAgv41SIY5nuTIpGU1d3HBxEZT/AHUEr/v3z9n7
	5H1lG/FVy7v8yqoS/E+HIYiyFDEr85uVvJtbAyrQ==
X-Google-Smtp-Source: AGHT+IHpU8QRxg8Zcegr+WqeSBDh+pgRmq0+vJmKE3dRqZ2girWL9pJP/x31gcuknWYoVKyHuDBQUYIuJj+13neYj30=
X-Received: by 2002:a17:90a:c883:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-3085eeceec3mr1461969a91.3.1744758332626; Tue, 15 Apr 2025
 16:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415093907.280501-1-yangfeng59949@163.com> <20250415093907.280501-4-yangfeng59949@163.com>
In-Reply-To: <20250415093907.280501-4-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Apr 2025 16:05:20 -0700
X-Gm-Features: ATxdqUF7dAyzVdEzKLfuBJzOyUYq0quqxlZRYqc0xryR_03CCUM9OiwcdIYF8_4
Message-ID: <CAEf4BzbOS8DCe=yhJOoiV3XfpwMTsnDgZ2AmBtkGMnaYWUL1QQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: Add test for attaching
 kprobe with long event names
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, hengqi.chen@gmail.com, 
	olsajiri@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 2:40=E2=80=AFAM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> This test verifies that attaching kprobe/kretprobe with long event names
> does not trigger EINVAL errors.
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   | 35 +++++++++++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 +++
>  2 files changed, 39 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tool=
s/testing/selftests/bpf/prog_tests/attach_probe.c
> index 9b7f36f39c32..cabc51c2ca6b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -168,6 +168,39 @@ static void test_attach_uprobe_long_event_name(void)
>         test_attach_probe_manual__destroy(skel);
>  }
>
> +/* attach kprobe/kretprobe long event name testings */
> +static void test_attach_kprobe_long_event_name(void)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> +       struct bpf_link *kprobe_link, *kretprobe_link;
> +       struct test_attach_probe_manual *skel;
> +
> +       skel =3D test_attach_probe_manual__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
> +               return;
> +
> +       /* manual-attach kprobe/kretprobe */
> +       kprobe_opts.attach_mode =3D PROBE_ATTACH_MODE_LEGACY;
> +       kprobe_opts.retprobe =3D false;
> +       kprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.handl=
e_kprobe,
> +                                                     "bpf_testmod_looooo=
oooooooooooooooooooooooooong_name",
> +                                                     &kprobe_opts);
> +       if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_long_event_name"))
> +               goto cleanup;
> +       skel->links.handle_kprobe =3D kprobe_link;
> +
> +       kprobe_opts.retprobe =3D true;
> +       kretprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.ha=
ndle_kretprobe,
> +                                                        "bpf_testmod_loo=
ooooooooooooooooooooooooooooong_name",
> +                                                        &kprobe_opts);
> +       if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_long_event_n=
ame"))
> +               goto cleanup;
> +       skel->links.handle_kretprobe =3D kretprobe_link;
> +
> +cleanup:
> +       test_attach_probe_manual__destroy(skel);
> +}
> +
>  static void test_attach_probe_auto(struct test_attach_probe *skel)
>  {
>         struct bpf_link *uprobe_err_link;
> @@ -371,6 +404,8 @@ void test_attach_probe(void)
>
>         if (test__start_subtest("uprobe-long_name"))
>                 test_attach_uprobe_long_event_name();
> +       if (test__start_subtest("kprobe-long_name"))
> +               test_attach_kprobe_long_event_name();
>
>  cleanup:
>         test_attach_probe__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index f38eaf0d35ef..13b0dc7a4a7e 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -134,6 +134,10 @@ bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmo=
d_struct_arg_1 *a) {
>         return bpf_testmod_test_struct_arg_result;
>  }
>
> +noinline void bpf_testmod_looooooooooooooooooooooooooooooong_name(void)

please use ` __weak noinline` just like `bpf_testmod_return_ptr()`,
it's more reliable this way (at least for the future)

> +{
> +}
> +
>  __bpf_kfunc void
>  bpf_testmod_test_mod_kfunc(int i)
>  {
> --
> 2.43.0
>

