Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E437A676149
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 00:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjATXO7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 18:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjATXOz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 18:14:55 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8381B545
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 15:14:53 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 188so8594714ybi.9
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 15:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GwQ6jnNKUQQattkaU0rtEiIWbnO1JGZjlIiSLHcUVCg=;
        b=Gn4OPCjxSWN+rGuQD0mOiFH+2d/DQ3CASgJe+vY8PyxunsSp/syCHuK4Kk21MXsXt5
         CwFY8vmCBFMAQdpYF1y3aGYo1ME/I0J2WdeH7X/MQnvkI1LiBSugrUW2kXIOQCyv2Ub0
         5Rt6cnQl2yMgcYjVL8tn1y5HeAIylsgr7GYmY+loUoIlRviyumS+T7nkgtFN+TlLKhUo
         IqBV4pDEo1Jhp52GiGhlemv/uqKYVk6IHgGIl07Sq/8YP1yzHZhXtnAORx74DSkxnPQ5
         EMR/BeVeIM8XYWLQD1uM5JOigecOfVDi5z+Uw9WXK44Qx8jFsZVltcP/Z2KBaHUrrU8l
         vgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwQ6jnNKUQQattkaU0rtEiIWbnO1JGZjlIiSLHcUVCg=;
        b=yDpGho1xPrM8DYXR5y0Aj7nTf73ux87B6quRJB9HS3ZcSS33szpKC3o7uIQpL0sVRT
         imjYcIgzihTpIPyrYjLzDPUyzQReJXGvraVDVFPdXzcab52TE/Y327+snrvikpoenOC0
         WNhS+6Q+AvmsqmH7BHx6W26CHCPcC+Ov338QXtkmSN/PDkexZ9XCkL3MGTlODiXvchR9
         cNDjbI9vCrwFprxLjBZLanLoSPFOICPI3260Fa7lK44uXm5ExQ7pVfsk6SejpxtslYk6
         TG3wsh4m1uuNGP/5WHCDIZCGvqZtRndqsHT3M++9UIs/kgCT1LhuVyZh+Fpv9+5V3I9p
         XJkw==
X-Gm-Message-State: AFqh2kpuZ4dqYxiehk4+p474ptbEpTLun5qzk47RP89VwPTaPX7KDX/P
        ojzQvQQbceFleIfGGkb+IJrKZYYx6lPR2F4bYyWgN1ipzN7FWQ==
X-Google-Smtp-Source: AMrXdXs6FO962+60mFY3GfeC7sT39RXTXW3ITmCaSZMdSg0kIPqh1id2oGU71A4QbU9zFd7sN9U7f6IzGYqXE9Yx2No=
X-Received: by 2002:a25:4dd7:0:b0:727:e539:452f with SMTP id
 a206-20020a254dd7000000b00727e539452fmr1879210ybb.552.1674256493144; Fri, 20
 Jan 2023 15:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20230120070355.1983560-1-memxor@gmail.com> <20230120070355.1983560-13-memxor@gmail.com>
In-Reply-To: <20230120070355.1983560-13-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 20 Jan 2023 15:14:42 -0800
Message-ID: <CAJnrk1ZrkQnxkUVYMRuh5WtRW6cr=X0cUPinKRsctBF2p2ifiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 12/12] selftests/bpf: Add dynptr helper tests
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 11:04 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> First test that we allow overwriting dynptr slots and reinitializing
> them in unreferenced case, and disallow overwriting for referenced case.
> Include tests to ensure slices obtained from destroyed dynptrs are being
> invalidated on their destruction. The destruction needs to be scoped, as
> in slices of dynptr A should not be invalidated when dynptr B is
> destroyed. Next, test that MEM_UNINIT doesn't allow writing dynptr stack
> slots.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index 1cbec5468879..c10abb98e47d 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -900,3 +900,132 @@ int dynptr_partial_slot_invalidate(struct __sk_buff *ctx)
>         );
>         return 0;
>  }
> +
> +SEC("?raw_tp")
> +__success
> +int dynptr_overwrite_unref(void *ctx)
> +{
> +       struct bpf_dynptr ptr;
> +
> +       if (get_map_val_dynptr(&ptr))
> +               return 0;
> +       if (get_map_val_dynptr(&ptr))
> +               return 0;
> +       if (get_map_val_dynptr(&ptr))
> +               return 0;
> +
> +       return 0;
> +}
> +
> +SEC("?raw_tp")
> +__failure __msg("R1 type=scalar expected=percpu_ptr_")
> +int dynptr_invalidate_slice_or_null(void *ctx)
> +{
> +       struct bpf_dynptr ptr;
> +       __u8 *p;
> +
> +       if (get_map_val_dynptr(&ptr))
> +               return 0;
> +
> +       p = bpf_dynptr_data(&ptr, 0, 1);
> +       *(__u8 *)&ptr = 0;
> +       bpf_this_cpu_ptr(p);
> +       return 0;
> +}
> +

nit: do you mind adding in a comment ("/* this should fail */") above
the line that triggers the verifier error to the new tests?


> +SEC("?raw_tp")
> +__failure __msg("R7 invalid mem access 'scalar'")
> +int dynptr_invalidate_slice_failure(void *ctx)
> +{
> +       struct bpf_dynptr ptr1;
> +       struct bpf_dynptr ptr2;
> +       __u8 *p1, *p2;
> +
> +       if (get_map_val_dynptr(&ptr1))
> +               return 0;
> +       if (get_map_val_dynptr(&ptr2))
> +               return 0;
> +
> +       p1 = bpf_dynptr_data(&ptr1, 0, 1);
> +       if (!p1)
> +               return 0;
> +       p2 = bpf_dynptr_data(&ptr2, 0, 1);
> +       if (!p2)
> +               return 0;
> +
> +       *(__u8 *)&ptr1 = 0;
> +       return *p1;
> +}
> +
> +SEC("?raw_tp")
> +__success
> +int dynptr_invalidate_slice_success(void *ctx)
> +{
> +       struct bpf_dynptr ptr1;
> +       struct bpf_dynptr ptr2;
> +       __u8 *p1, *p2;
> +
> +       if (get_map_val_dynptr(&ptr1))
> +               return 1;
> +       if (get_map_val_dynptr(&ptr2))
> +               return 1;
> +
> +       p1 = bpf_dynptr_data(&ptr1, 0, 1);
> +       if (!p1)
> +               return 1;
> +       p2 = bpf_dynptr_data(&ptr2, 0, 1);
> +       if (!p2)
> +               return 1;
> +
> +       *(__u8 *)&ptr1 = 0;
> +       return *p2;
> +}
> +
> +SEC("?raw_tp")
> +__failure __msg("cannot overwrite referenced dynptr")
> +int dynptr_overwrite_ref(void *ctx)
> +{
> +       struct bpf_dynptr ptr;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
> +       if (get_map_val_dynptr(&ptr))
> +               bpf_ringbuf_discard_dynptr(&ptr, 0);
> +       return 0;
> +}
> +
> +/* Reject writes to dynptr slot from bpf_dynptr_read */
> +SEC("?raw_tp")
> +__failure __msg("potential write to dynptr at off=-16")
> +int dynptr_read_into_slot(void *ctx)
> +{
> +       union {
> +               struct {
> +                       char _pad[48];
> +                       struct bpf_dynptr ptr;
> +               };
> +               char buf[64];
> +       } data;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &data.ptr);
> +       /* this should fail */
> +       bpf_dynptr_read(data.buf, sizeof(data.buf), &data.ptr, 0, 0);
> +
> +       return 0;
> +}
> +
> +/* Reject writes to dynptr slot for uninit arg */
> +SEC("?raw_tp")
> +__failure __msg("potential write to dynptr at off=-16")
> +int uninit_write_into_slot(void *ctx)
> +{
> +       struct {
> +               char buf[64];
> +               struct bpf_dynptr ptr;
> +       } data;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, 80, 0, &data.ptr);
> +       /* this should fail */
> +       bpf_get_current_comm(data.buf, 80);
> +
> +       return 0;
> +}

Another test I think would be helpful is verifying that data slices
are invalidated if the dynptr is invalidated within a callback.
Something like:

static int callback(__u32 index, void *data)
{
        *(__u32 *)data = 123;

        return 0;
}

/* If the dynptr is written into in a callback function, its data
slices should be invalidated as well */
SEC("?raw_tp")
__failure __msg("invalid mem access 'scalar'")
int invalid_data_slices(void *ctx)
{
        struct bpf_dynptr ptr;
        __u32 *slice;

        get_map_val_dynptr(&ptr);

        slice  = bpf_dynptr_data(&ptr, 0, sizeof(_u32));
        if (!slice)
                return 0;

        bpf_loop(10, callback, &ptr, 0);

        /* this should fail */
        *slice = 1;

        return 0;
}

> --
> 2.39.1
>
