Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919566566E
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2019 14:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfGKMNU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jul 2019 08:13:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43738 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbfGKMNU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jul 2019 08:13:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so5510428ljv.10
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2019 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NdSqQEh9i1abPENwKI9FaEBEnAJ5ZXPu8KdECYjTgVk=;
        b=LcJGmPqCejgM8URsZbFWXfbaohRReQVYBgQBKtB6QzCtutLZ/gVRgtYGG1kDfWfMr4
         QIqkwdridt2COlsIp+z5imKvjIl/p+01Yb2MUy/xuY9hmn2yJoJo0UxTfWoPB8fFkJ2I
         QANZ0E7W3B8HolifQqClrjpMkOyLUvUwDcTb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NdSqQEh9i1abPENwKI9FaEBEnAJ5ZXPu8KdECYjTgVk=;
        b=TafwifqksCZmFdAAlRoADemWX+TZfoWhaSHgcP80Xr2L9IMp8hAMhZPigpNm6o6Uw+
         3IrDrlN4bjpQCaYgFiqs/XHh2KLF96TjgJK1Dv2F5KTfijtQLvLytEEnUTrhw3jA8+ba
         Y9hKzUDTV+p1x1FQIlrSb9sOFozPj0zg+oXazyJVhozNYEpMijb9cnmp2XOfJlVrMpr4
         jVXzYZBb3Wb50s2vqG4RBkiY26mTGEp1FHnesSF777ems0Xo07Qu9fzpQOFvUfgpEXze
         aScyiR7Ypc6TdRYqHFAZ7AoqmgDofQ59IDmPCM4VGxe4V01bRZTqbs/xDWjCoIUGejtt
         vfGA==
X-Gm-Message-State: APjAAAUJJkXRulqsU1t3OvUXl+4wjg6Atm8/A0mSRv4BsjxgQ6bU5ccV
        vA86XVBCQ6ocTXYxUhgJzC1lWFvbcAUQax0fTxYaCg==
X-Google-Smtp-Source: APXvYqzyoqAzbcKOvQtGos6Y/jjCQ6acXo52XUaFrMmDrO2B6aDsqxq3l9ZGTPHmOHFG2WrvOGr51RmaaTjxTK5XVvo=
X-Received: by 2002:a2e:9754:: with SMTP id f20mr2310921ljj.151.1562847198097;
 Thu, 11 Jul 2019 05:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190711010844.1285018-1-andriin@fb.com>
In-Reply-To: <20190711010844.1285018-1-andriin@fb.com>
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
Date:   Thu, 11 Jul 2019 14:13:07 +0200
Message-ID: <CAGGp+cETuvWUwET=6Mq5sWTJhi5+Rs2bw8xNP2NYZXAAuc6-Og@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: remove logic duplication in test_verifier.c
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, kernel-team@fb.com,
        ast@fb.com, Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 11, 2019 at 3:08 AM Andrii Nakryiko <andriin@fb.com> wrote:
>
> test_verifier tests can specify single- and multi-runs tests. Internally
> logic of handling them is duplicated. Get rid of it by making single run
> retval specification to be a first retvals spec.
>
> Cc: Krzesimir Nowak <krzesimir@kinvolk.io>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Looks good, one nit below.

Acked-by: Krzesimir Nowak <krzesimir@kinvolk.io>

> ---
>  tools/testing/selftests/bpf/test_verifier.c | 37 ++++++++++-----------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
> index b0773291012a..120ecdf4a7db 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -86,7 +86,7 @@ struct bpf_test {
>         int fixup_sk_storage_map[MAX_FIXUPS];
>         const char *errstr;
>         const char *errstr_unpriv;
> -       uint32_t retval, retval_unpriv, insn_processed;
> +       uint32_t insn_processed;
>         int prog_len;
>         enum {
>                 UNDEF,
> @@ -95,16 +95,24 @@ struct bpf_test {
>         } result, result_unpriv;
>         enum bpf_prog_type prog_type;
>         uint8_t flags;
> -       __u8 data[TEST_DATA_LEN];
>         void (*fill_helper)(struct bpf_test *self);
>         uint8_t runs;
> -       struct {
> -               uint32_t retval, retval_unpriv;
> -               union {
> -                       __u8 data[TEST_DATA_LEN];
> -                       __u64 data64[TEST_DATA_LEN / 8];
> +       union {
> +               struct {

Maybe consider moving the struct definition outside to further the
removal of the duplication?

> +                       uint32_t retval, retval_unpriv;
> +                       union {
> +                               __u8 data[TEST_DATA_LEN];
> +                               __u64 data64[TEST_DATA_LEN / 8];
> +                       };
>                 };
> -       } retvals[MAX_TEST_RUNS];
> +               struct {
> +                       uint32_t retval, retval_unpriv;
> +                       union {
> +                               __u8 data[TEST_DATA_LEN];
> +                               __u64 data64[TEST_DATA_LEN / 8];
> +                       };
> +               } retvals[MAX_TEST_RUNS];
> +       };
>         enum bpf_attach_type expected_attach_type;
>  };
>
> @@ -949,17 +957,8 @@ static void do_test_single(struct bpf_test *test, bo=
ol unpriv,
>                 uint32_t expected_val;
>                 int i;
>
> -               if (!test->runs) {
> -                       expected_val =3D unpriv && test->retval_unpriv ?
> -                               test->retval_unpriv : test->retval;
> -
> -                       err =3D do_prog_test_run(fd_prog, unpriv, expecte=
d_val,
> -                                              test->data, sizeof(test->d=
ata));
> -                       if (err)
> -                               run_errs++;
> -                       else
> -                               run_successes++;
> -               }
> +               if (!test->runs)
> +                       test->runs =3D 1;
>
>                 for (i =3D 0; i < test->runs; i++) {
>                         if (unpriv && test->retvals[i].retval_unpriv)
> --
> 2.17.1
>


--=20
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras
Registergericht/Court of registration: Amtsgericht Charlottenburg
Registernummer/Registration number: HRB 171414 B
Ust-ID-Nummer/VAT ID number: DE302207000
