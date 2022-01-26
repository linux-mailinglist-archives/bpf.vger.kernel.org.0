Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59049C377
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 07:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiAZGH2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 01:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiAZGH2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 01:07:28 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D452CC06161C;
        Tue, 25 Jan 2022 22:07:27 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id d188so12138516iof.7;
        Tue, 25 Jan 2022 22:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMq6KFJOxj51iM4yYWrCeLD/40elOOrfgyuQTnLMxKA=;
        b=QmsY1xsZTtYa15z+0D7WwhLpl6a1M8x3ca0FFIFRj0GgPvoc48ahZPVSoGRcimOc/E
         Qo5t2O4aqBGV1aq5kvcVxcqh65MghmGQF/lotMSh10nDgUcmq+4Tk6NQVLb5oNGbab7t
         G9fvDr4rthLTOjWYivJ40P59FTdJKYL/jsbf6iIuuCbsPMHT9HvcacjWKXP6E1pX0SQY
         G8nmyWQNuYE2F09YQ+y0HadfTeF+GH1p5TbmF+x38b4MGYieFuYcz8uMUkuCllQswMUO
         d+ADyIZ/dwCT64gVvt6j4xqGwBzovATXJGR7dvmeIz1a+w8bGeP4ZIn2K9ba6fruk7iD
         kEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMq6KFJOxj51iM4yYWrCeLD/40elOOrfgyuQTnLMxKA=;
        b=XXa3iz3tAdu3kqDU06C6RkErLabCByRHWPhWq/kPlUMRUbEo8Jz+QGHwmobHbFIzCf
         nuii6kZ//CLRw3p3yGR+sPlYDdzMfe3H03TNQcX6mqmVfeFxIa9Z/PxnfAu2QpJrdL08
         n9B8QzKlNiCgKoxK24VROoG0OLdlTEB4qF10n3mN7czUxOSRcapforqCxKJwCi4ORYHr
         q5oISn+pIXsukBZZmRhb8M144eCU1Xm8JFFL3rAYXcPQXkztHHaP2YWxfx+7crye0e+w
         wHX8Aqm7bSmlS6x9i54xNFIK+rHeUTzI2ovvMJCmooC2Hy4vcksnxuzKsEEiYy729QO+
         MRtQ==
X-Gm-Message-State: AOAM532RliUJTUpTKsnzQyP0avRk2Njl7scxkgU4xM4wfpp05Rz0jsEk
        RFxSM5MWda/pADHFYQyUakURCy94zIvaHAE8Zzw=
X-Google-Smtp-Source: ABdhPJxA81O4SsESvpPxO6OZQpy/sUi6p/VEqrPWKm0+IfITRs5bsZQCOwcDFXb01JiZhhJcy00nD41hd7E0USoC/9c=
X-Received: by 2002:a5d:9155:: with SMTP id y21mr12716460ioq.112.1643177247227;
 Tue, 25 Jan 2022 22:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20220126040509.1862767-1-kuifeng@fb.com> <20220126040509.1862767-4-kuifeng@fb.com>
In-Reply-To: <20220126040509.1862767-4-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 25 Jan 2022 22:07:16 -0800
Message-ID: <CAEf4BzYsjsWZASrF0rjBYion7nL7L9gRvGm_VJ7-1Ojds34b=A@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 25, 2022 at 8:07 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Create an instance of btf for each worker thread, and add type info to
> the local btf instance in the steal-function of pahole without mutex
> acquiring.  Once finished with all worker threads, merge all
> per-thread btf instances to the primary btf instance.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  btf_encoder.c |   5 +++
>  btf_encoder.h |   2 +
>  pahole.c      | 121 ++++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 120 insertions(+), 8 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 9d015f304e92..56a76f5d7275 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1529,3 +1529,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>  out:
>         return err;
>  }
> +
> +struct btf *btf_encoder__btf(struct btf_encoder *encoder)
> +{
> +       return encoder->btf;
> +}
> diff --git a/btf_encoder.h b/btf_encoder.h
> index f133b0d7674d..0f0eee84df74 100644
> --- a/btf_encoder.h
> +++ b/btf_encoder.h
> @@ -29,4 +29,6 @@ struct btf_encoder *btf_encoders__first(struct list_head *encoders);
>
>  struct btf_encoder *btf_encoders__next(struct btf_encoder *encoder);
>
> +struct btf *btf_encoder__btf(struct btf_encoder *encoder);
> +
>  #endif /* _BTF_ENCODER_H_ */
> diff --git a/pahole.c b/pahole.c
> index f3eeaaca4cdf..525eb4d90b08 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -29,6 +29,7 @@
>  #include "btf_encoder.h"
>
>  static struct btf_encoder *btf_encoder;
> +static pthread_mutex_t btf_encoder_lock = PTHREAD_MUTEX_INITIALIZER;
>  static char *detached_btf_filename;
>  static bool btf_encode;
>  static bool btf_gen_floats;
> @@ -2798,6 +2799,65 @@ out:
>
>  static struct type_instance *header;
>
> +struct thread_data {
> +       struct btf *btf;
> +       struct btf_encoder *encoder;
> +};
> +
> +static int pahole_threads_prepare(struct conf_load *conf, int nr_threads, void **thr_data)
> +{
> +       int i;
> +       struct thread_data *threads = calloc(sizeof(struct thread_data), nr_threads);
> +
> +       for (i = 0; i < nr_threads; i++)
> +               thr_data[i] = threads + i;
> +
> +       return 0;
> +}
> +
> +static int pahole_thread_exit(struct conf_load *conf, void *thr_data)
> +{
> +       struct thread_data *thread = thr_data;
> +
> +       if (thread == NULL)
> +               return 0;
> +
> +       /*
> +        * Here we will call btf__dedup() here once we extend
> +        * btf__dedup().
> +        */
> +
> +       if (thread->encoder == btf_encoder) {
> +               /* Release the lock acuqired when created btf_encoder */

typo: acquired

> +               pthread_mutex_unlock(&btf_encoder_lock);

Splitting pthread_mutex lock/unlock like this is extremely dangerous
and error prone. If that's the price for reusing global btf_encoder
for first worker, then I'd rather not reuse btf_encoder or revert back
to doing btf__add_btf() and doing btf_encoder__delete() in the main
thread.

Please question and push back the approach and code review feedback if
something doesn't feel natural or is causing more problems than
solves.

I think the cleanest solution would be to not reuse global btf_encoder
for the first worker. I suspect the time difference isn't big, so I'd
optimize for simplicity and clean separation. But if it is causing
unnecessary slowdown, then as I said, let's just revert back to your
previous approach with doing btf__add_btf() in the main thread.

> +               return 0;
> +       }
> +
> +       pthread_mutex_lock(&btf_encoder_lock);
> +       btf__add_btf(btf_encoder__btf(btf_encoder), thread->btf);
> +       pthread_mutex_unlock(&btf_encoder_lock);
> +
> +       btf_encoder__delete(thread->encoder);
> +       thread->encoder = NULL;
> +
> +       return 0;
> +}
> +
> +static int pahole_threads_collect(struct conf_load *conf, int nr_threads, void **thr_data,
> +                                 int error)
> +{
> +       struct thread_data **threads = (struct thread_data **)thr_data;
> +       int i;
> +
> +       for (i = 0; i < nr_threads; i++) {
> +               if (threads[i]->encoder && threads[i]->encoder != btf_encoder)
> +                       btf_encoder__delete(threads[i]->encoder);
> +       }
> +       free(threads[0]);
> +
> +       return 0;
> +}
> +
>  static enum load_steal_kind pahole_stealer(struct cu *cu,
>                                            struct conf_load *conf_load,
>                                            void *thr_data)
> @@ -2819,30 +2879,72 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
>
>         if (btf_encode) {
>                 static pthread_mutex_t btf_lock = PTHREAD_MUTEX_INITIALIZER;
> +               struct btf_encoder *encoder;
>
> -               pthread_mutex_lock(&btf_lock);
>                 /*
>                  * FIXME:
>                  *
>                  * This should be really done at main(), but since in the current codebase only at this
>                  * point we'll have cu->elf setup...
>                  */
> +               pthread_mutex_lock(&btf_lock);
>                 if (!btf_encoder) {
> -                       btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
> -                                                      btf_encode_force, btf_gen_floats, global_verbose);
> -                       if (btf_encoder == NULL) {
> -                               ret = LSK__STOP_LOADING;
> -                               goto out_btf;
> +                       /*
> +                        * btf_encoder is the primary encoder.
> +                        * And, it is used by the thread
> +                        * create it.
> +                        */
> +                       btf_encoder = btf_encoder__new(cu, detached_btf_filename,
> +                                                      conf_load->base_btf,
> +                                                      skip_encoding_btf_vars,
> +                                                      btf_encode_force,
> +                                                      btf_gen_floats, global_verbose);
> +                       if (btf_encoder && thr_data) {
> +                               struct thread_data *thread = (struct thread_data *)thr_data;

nit: no need for the cast

> +
> +                               thread->encoder = btf_encoder;
> +                               thread->btf = btf_encoder__btf(btf_encoder);
> +                               /* Will be relased by pahole_thread_exit() */

typo: released

> +                               pthread_mutex_lock(&btf_encoder_lock);
>                         }
>                 }
> +               pthread_mutex_unlock(&btf_lock);
> +

[...]

> @@ -3207,6 +3309,9 @@ int main(int argc, char *argv[])
>         memset(tab, ' ', sizeof(tab) - 1);
>
>         conf_load.steal = pahole_stealer;
> +       conf_load.thread_exit = pahole_thread_exit;
> +       conf_load.threads_prepare = pahole_threads_prepare;
> +       conf_load.threads_collect = pahole_threads_collect;
>
>         // Make 'pahole --header type < file' a shorter form of 'pahole -C type --count 1 < file'
>         if (conf.header_type && !class_name && prettify_input) {
> --
> 2.30.2
>
