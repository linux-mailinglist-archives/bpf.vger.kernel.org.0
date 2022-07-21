Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C457D275
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 19:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiGUR2M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 13:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGUR2L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 13:28:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFBC89EAF
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 10:28:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a5so3216149wrx.12
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRa7/MulE3wLbVOttgoRrpbsScAeard30Tq3smtR67k=;
        b=drP4snyOEl6+oJOJOVv3gtGNHzlwPs/1SVSIKn6f8w9VizzocuSi6DOwcs6Sp8fiqL
         LSILOAgQYv9wNNIE40pvh3rS4sCOQz0b5lJq0aB7nR+Mc9xbWiKmJNDXbwrRHvNGTUrY
         0u5EInw8chz3W0EyxyfUNe9sXm32tWaJX4235eA9SjsGraEypeiqRziJYWH0A8mgWeZv
         YVuEDjxG4IRa7wzJzoQp7pKXgjXTp3TDhYUSjvBVYsbm/48PwfeT5cauoQLED+0EPCW1
         vVGYQdmJUqD8Mt95MXZHoods8G3B5lRErmyNs2LF1kYagG9XH/AJDaZ/MIA2Wg1/Ncjg
         CtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRa7/MulE3wLbVOttgoRrpbsScAeard30Tq3smtR67k=;
        b=2XVvyQWXhPjHC7GUQ5E50xJmMRITY2VH4/yni0IRlAHs2AG9OhI++wBgSwHSuQt2/M
         HbuJ/pD0xrbR6L8M3LAGc+mzTyHr1T+0tyLZeRK1voLkNBcxvaOUW2xYyMMGDNyeg9NS
         H2NCfT4/ww/uwYpO32VkpHvnWDuRrP9QGIA4Ao3Tgz+6Zhm86mENgIot5Ez9xBXYeBiz
         LE8cku/gxosVa+J7hSPGfCtKQXtjLREq9QW76ZGSQ9gpeZOm/gblMcVyvy6xAC8JEZRv
         X6VYqCDBjVRxyrmXFCUVtu9l38b65onDyLYA+Z8ffbkiWPOTRqUM/lpurxDeLijGNOwV
         S5Mw==
X-Gm-Message-State: AJIora+mrVAJJYpCE8SXGjVsvrDNP8kPxUWSq0dD9EVNBAmKREShDFgz
        qcWkP0o20q5I9waz0yqz2eKlTkD2JhkOWX+YUYpiYkSgiaU=
X-Google-Smtp-Source: AGRyM1toJf/Cg1c/ZvA/9s4kFtyl3f30a/TC+hVSiMahO1caktX5pZjy6Kwv+o50w42CZeZLDNCN9HPr8wc++Sgxvh4=
X-Received: by 2002:a5d:64a3:0:b0:21d:adaa:ce4c with SMTP id
 m3-20020a5d64a3000000b0021dadaace4cmr35405017wrp.161.1658424488772; Thu, 21
 Jul 2022 10:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220721024821.251231-1-joannelkoong@gmail.com> <20220721024821.251231-2-joannelkoong@gmail.com>
In-Reply-To: <20220721024821.251231-2-joannelkoong@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 21 Jul 2022 10:27:57 -0700
Message-ID: <CA+khW7haDCVbccKryWDOhejqc-7B1geHK6Htx=Qm6k2oK=e=LA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: add extra test for using
 dynptr data slice after release
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Joanne,

On Wed, Jul 20, 2022 at 7:49 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Add an additional test, "data_slice_use_after_release2", for ensuring
> that data slices are correctly invalidated by the verifier after the
> dynptr whose ref obj id they track is released. In particular, this
> tests data slice invalidation for dynptrs located at a non-zero offset
> from the frame pointer.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  .../testing/selftests/bpf/prog_tests/dynptr.c |  3 +-
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 32 ++++++++++++++++++-
>  2 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> index 3c7aa82b98e2..bcf80b9f7c27 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -22,7 +22,8 @@ static struct {
>         {"add_dynptr_to_map2", "invalid indirect read from stack"},
>         {"data_slice_out_of_bounds_ringbuf", "value is outside of the allowed memory range"},
>         {"data_slice_out_of_bounds_map_value", "value is outside of the allowed memory range"},
> -       {"data_slice_use_after_release", "invalid mem access 'scalar'"},
> +       {"data_slice_use_after_release1", "invalid mem access 'scalar'"},
> +       {"data_slice_use_after_release2", "invalid mem access 'scalar'"},
>         {"data_slice_missing_null_check1", "invalid mem access 'mem_or_null'"},
>         {"data_slice_missing_null_check2", "invalid mem access 'mem_or_null'"},
>         {"invalid_helper1", "invalid indirect read from stack"},
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index d811cff73597..d8c4ed3ee146 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -248,7 +248,7 @@ int data_slice_out_of_bounds_map_value(void *ctx)
>
>  /* A data slice can't be used after it has been released */
>  SEC("?raw_tp/sys_nanosleep")
> -int data_slice_use_after_release(void *ctx)
> +int data_slice_use_after_release1(void *ctx)
>  {
>         struct bpf_dynptr ptr;
>         struct sample *sample;
> @@ -272,6 +272,36 @@ int data_slice_use_after_release(void *ctx)
>         return 0;
>  }
>
> +SEC("?raw_tp/sys_nanosleep")
> +int data_slice_use_after_release2(void *ctx)

Could you put comments explaining the reason for failure, like other test cases?

> +{
> +       struct bpf_dynptr ptr1, ptr2;
> +       struct sample *sample;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr1);
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
> +
> +       sample = bpf_dynptr_data(&ptr2, 0, sizeof(*sample));
> +       if (!sample)
> +               goto done;
> +
> +       sample->pid = 23;
> +
> +       bpf_ringbuf_submit_dynptr(&ptr2, 0);
> +
> +       /* this should fail */
> +       sample->pid = 23;
> +
> +       bpf_ringbuf_submit_dynptr(&ptr1, 0);
> +
> +       return 0;
> +
> +done:
> +       bpf_ringbuf_discard_dynptr(&ptr2, 0);
> +       bpf_ringbuf_discard_dynptr(&ptr1, 0);
> +       return 0;
> +}
> +

Joanne, I haven't been following the effort of dynptr, so I am still
learning dynptr. Is there any use of `ptr1` in this test case?

>  /* A data slice must be first checked for NULL */
>  SEC("?raw_tp/sys_nanosleep")
>  int data_slice_missing_null_check1(void *ctx)
> --
> 2.30.2
>
