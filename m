Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBDD676250
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjAUAVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAUAVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:21:36 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89E44CE5F
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:21:07 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so9690041pjq.0
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BrPWhcu7ijKsNTXgBMKhB9cBep1EmYrBJW7dXVws3Hc=;
        b=jQ2+YS0IxWbl33o9I5MvtT9UKHihu1GiS+7g7onnqy5RjWxbr4SGhwZELIDUoQFeuL
         yCxIlQp9OdXB1iCjUnXaq1C3E7oajxoJqqvIbeK+WLOEZ7Ak4hWtkALVTAR8xJvObtx2
         E6JUkeK9hU/cVocjjM1DC4nmkVDE4oVw0gQW9wEr+gPGv5CUmrjEK2v7jUhnzRyKM2Rw
         sun5c+RutoOMGfCWsKwB/CXuWjVIihT4Ef3AwpyTDl6jpeEe1/KaJl3mGs8poJpf8gwP
         v5UI7ck1mJAYtXGmrGW3x/TgF07TvExjNjUxVfVVDdByRnrMVe+AxAaHmPDRDZY0cqUv
         nhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrPWhcu7ijKsNTXgBMKhB9cBep1EmYrBJW7dXVws3Hc=;
        b=1oFQK/tostrB1c6QGLcHUyojFG43Pg6JxztPKnq3TZOvb9CknzTdEFuDDZv+43dbq9
         xMilqyuGX3Cd151H1guqn2rumuSrC3xpoAfbV6uqt8nmgHtP0j/urTIU1vxnqQiXqD0T
         mKJnQ2bQwKTPynh4Ohmp7QSRalgOm2knytIxywCCIo6DrKelrrKyNw/GSm7l3WVMojtm
         XpeCQ0glCAi1jt9fJHLML4Pdu5aw0v7wNqfrI+CMBvkBL1/GHd98f45s3Ji+sZfLyUN0
         FcyeS04FNi1PPyGC/H+olrxkYQjCM8K0qvuZA1CRRVd5HcZA+wGX9yIVbAg+EFEuV5pd
         tZ6g==
X-Gm-Message-State: AFqh2krg3utLeNjV2GjfAPbn/q28SlxfPyYS1tvdYY0yBNOdmc7sxIZK
        0WgtqqyUyDkdOKOLAOOXEb8=
X-Google-Smtp-Source: AMrXdXuVNervU++nE1Sas2isoF4PB05/iGkr6kVBpSOzIdffyeHyeJl7M3Ylg+mPPyAD2IvjcCmVAQ==
X-Received: by 2002:a17:902:da86:b0:188:6a62:9d89 with SMTP id j6-20020a170902da8600b001886a629d89mr53303598plx.54.1674260381410;
        Fri, 20 Jan 2023 16:19:41 -0800 (PST)
Received: from localhost ([49.36.209.255])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b00194706d3f25sm14677606ple.144.2023.01.20.16.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:19:40 -0800 (PST)
Date:   Sat, 21 Jan 2023 05:49:38 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v4 12/12] selftests/bpf: Add dynptr helper tests
Message-ID: <20230121001938.y3vfs7gdh6wh3d2f@apollo>
References: <20230120070355.1983560-1-memxor@gmail.com>
 <20230120070355.1983560-13-memxor@gmail.com>
 <CAJnrk1ZrkQnxkUVYMRuh5WtRW6cr=X0cUPinKRsctBF2p2ifiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZrkQnxkUVYMRuh5WtRW6cr=X0cUPinKRsctBF2p2ifiw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 21, 2023 at 04:44:42AM IST, Joanne Koong wrote:
> On Thu, Jan 19, 2023 at 11:04 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > First test that we allow overwriting dynptr slots and reinitializing
> > them in unreferenced case, and disallow overwriting for referenced case.
> > Include tests to ensure slices obtained from destroyed dynptrs are being
> > invalidated on their destruction. The destruction needs to be scoped, as
> > in slices of dynptr A should not be invalidated when dynptr B is
> > destroyed. Next, test that MEM_UNINIT doesn't allow writing dynptr stack
> > slots.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Acked-by: Joanne Koong <joannelkoong@gmail.com>
>
> > ---
> >  .../testing/selftests/bpf/progs/dynptr_fail.c | 129 ++++++++++++++++++
> >  1 file changed, 129 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > index 1cbec5468879..c10abb98e47d 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > @@ -900,3 +900,132 @@ int dynptr_partial_slot_invalidate(struct __sk_buff *ctx)
> >         );
> >         return 0;
> >  }
> > +
> > +SEC("?raw_tp")
> > +__success
> > +int dynptr_overwrite_unref(void *ctx)
> > +{
> > +       struct bpf_dynptr ptr;
> > +
> > +       if (get_map_val_dynptr(&ptr))
> > +               return 0;
> > +       if (get_map_val_dynptr(&ptr))
> > +               return 0;
> > +       if (get_map_val_dynptr(&ptr))
> > +               return 0;
> > +
> > +       return 0;
> > +}
> > +
> > +SEC("?raw_tp")
> > +__failure __msg("R1 type=scalar expected=percpu_ptr_")
> > +int dynptr_invalidate_slice_or_null(void *ctx)
> > +{
> > +       struct bpf_dynptr ptr;
> > +       __u8 *p;
> > +
> > +       if (get_map_val_dynptr(&ptr))
> > +               return 0;
> > +
> > +       p = bpf_dynptr_data(&ptr, 0, 1);
> > +       *(__u8 *)&ptr = 0;
> > +       bpf_this_cpu_ptr(p);
> > +       return 0;
> > +}
> > +
>
> nit: do you mind adding in a comment ("/* this should fail */") above
> the line that triggers the verifier error to the new tests?
>

I've added this comment to whichever statement triggers the error, and a
short comment over the tests.

>
> > +SEC("?raw_tp")
> > +__failure __msg("R7 invalid mem access 'scalar'")
> > +int dynptr_invalidate_slice_failure(void *ctx)
> > +{
> > +       struct bpf_dynptr ptr1;
> > +       struct bpf_dynptr ptr2;
> > +       __u8 *p1, *p2;
> > +
> > +       if (get_map_val_dynptr(&ptr1))
> > +               return 0;
> > +       if (get_map_val_dynptr(&ptr2))
> > +               return 0;
> > +
> > +       p1 = bpf_dynptr_data(&ptr1, 0, 1);
> > +       if (!p1)
> > +               return 0;
> > +       p2 = bpf_dynptr_data(&ptr2, 0, 1);
> > +       if (!p2)
> > +               return 0;
> > +
> > +       *(__u8 *)&ptr1 = 0;
> > +       return *p1;
> > +}
> > +
> > +SEC("?raw_tp")
> > +__success
> > +int dynptr_invalidate_slice_success(void *ctx)
> > +{
> > +       struct bpf_dynptr ptr1;
> > +       struct bpf_dynptr ptr2;
> > +       __u8 *p1, *p2;
> > +
> > +       if (get_map_val_dynptr(&ptr1))
> > +               return 1;
> > +       if (get_map_val_dynptr(&ptr2))
> > +               return 1;
> > +
> > +       p1 = bpf_dynptr_data(&ptr1, 0, 1);
> > +       if (!p1)
> > +               return 1;
> > +       p2 = bpf_dynptr_data(&ptr2, 0, 1);
> > +       if (!p2)
> > +               return 1;
> > +
> > +       *(__u8 *)&ptr1 = 0;
> > +       return *p2;
> > +}
> > +
> > +SEC("?raw_tp")
> > +__failure __msg("cannot overwrite referenced dynptr")
> > +int dynptr_overwrite_ref(void *ctx)
> > +{
> > +       struct bpf_dynptr ptr;
> > +
> > +       bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
> > +       if (get_map_val_dynptr(&ptr))
> > +               bpf_ringbuf_discard_dynptr(&ptr, 0);
> > +       return 0;
> > +}
> > +
> > +/* Reject writes to dynptr slot from bpf_dynptr_read */
> > +SEC("?raw_tp")
> > +__failure __msg("potential write to dynptr at off=-16")
> > +int dynptr_read_into_slot(void *ctx)
> > +{
> > +       union {
> > +               struct {
> > +                       char _pad[48];
> > +                       struct bpf_dynptr ptr;
> > +               };
> > +               char buf[64];
> > +       } data;
> > +
> > +       bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &data.ptr);
> > +       /* this should fail */
> > +       bpf_dynptr_read(data.buf, sizeof(data.buf), &data.ptr, 0, 0);
> > +
> > +       return 0;
> > +}
> > +
> > +/* Reject writes to dynptr slot for uninit arg */
> > +SEC("?raw_tp")
> > +__failure __msg("potential write to dynptr at off=-16")
> > +int uninit_write_into_slot(void *ctx)
> > +{
> > +       struct {
> > +               char buf[64];
> > +               struct bpf_dynptr ptr;
> > +       } data;
> > +
> > +       bpf_ringbuf_reserve_dynptr(&ringbuf, 80, 0, &data.ptr);
> > +       /* this should fail */
> > +       bpf_get_current_comm(data.buf, 80);
> > +
> > +       return 0;
> > +}
>
> Another test I think would be helpful is verifying that data slices
> are invalidated if the dynptr is invalidated within a callback.
> Something like:
>
> static int callback(__u32 index, void *data)
> {
>         *(__u32 *)data = 123;
>
>         return 0;
> }
>
> /* If the dynptr is written into in a callback function, its data
> slices should be invalidated as well */
> SEC("?raw_tp")
> __failure __msg("invalid mem access 'scalar'")
> int invalid_data_slices(void *ctx)
> {
>         struct bpf_dynptr ptr;
>         __u32 *slice;
>
>         get_map_val_dynptr(&ptr);
>
>         slice  = bpf_dynptr_data(&ptr, 0, sizeof(_u32));
>         if (!slice)
>                 return 0;
>
>         bpf_loop(10, callback, &ptr, 0);
>
>         /* this should fail */
>         *slice = 1;
>
>         return 0;
> }

Yes, looks good. I added this and one more test which tests the unint ->
check_mem_access -> destroy path as well, and will respin.
