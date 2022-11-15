Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73EF62A166
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 19:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKOSgu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 13:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKOSgu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 13:36:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D263D64F8
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 10:36:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i21so23157792edj.10
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 10:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNEnPX9RPM+k2QnX3GILrznbeobMUXRqqJeMyQJqDZ0=;
        b=GT4CvBVLBufHtwyYyWnz9Q4M2IJClorK3Rv1TShHFb5hTPfpoGrtF9cAYa+Yb8+iS0
         uJK7F3mux7Q7Fy6RlphwIYqPg8SrGzLNybwWozTTYcdLD0brYnPy8c/kPS6z1GxE3d5/
         I1WyZr9nNaXTuEW6TVRCUQNO09vhyRtD7JpPNkwo2rv0wCN7BzEB7ilG/p5v5XM67Sq5
         ObHLZE04X5IyQ0amj9tl1lODWN9YvLgKhprfIxR7lnjDdLqoxKyeVwRKVcf7rbFPBf0z
         atcI3rTPUBtC3mmJgBxdagIwj6Em+dxPejqdmKz18W7C80I0g5vyLLdxVqthlMnz9em4
         qbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNEnPX9RPM+k2QnX3GILrznbeobMUXRqqJeMyQJqDZ0=;
        b=FLyISqLwLOR04bXv52h5db6jL5xLGOD09ykzaivYE9rZnIggBE/NQRPzEnaYkIbUrh
         YeV4t5DOJdNoAjpG9Jo80MT8Q6uvhca2xqxGM4R3lzuhez4kuqIbr1coNURAn/lkG1nR
         JmpyIP9cW1nh5BIUa62PwEM6YnyKDcLefeabD/0UnuFul9t2rmR02Kg0Ho/bPPmbM1rM
         qwolcFPdWSBP+KmRvlNZLJ2twlaXiO4HN9TekyvIE17NCVKEy8UHpDKZ493XFN9n40Na
         fYqRLtrC5dKIMFv4j68MEKWpGF3+sn5Y3bypfQaLAr8+GpgZe109vSnIMi2WpT79ovF6
         QQKA==
X-Gm-Message-State: ANoB5pkYffjeZQLVHQAYF2lZqggc4t5dKD8zKs7cIinFIQiB6JPt/YmC
        x5GGqtKVslaqhesKCRj/tLjTI/PzlRH5PDc03ozWl8kc
X-Google-Smtp-Source: AA0mqf63LAXOlfpfJXQoyEOsD3VHunToiVKyjVgU+mutCKeDFYOvBs0ZjbkRowvO++MVtoVrlec/xeBSSO+q9PQwn0s=
X-Received: by 2002:aa7:c155:0:b0:461:8cf7:4783 with SMTP id
 r21-20020aa7c155000000b004618cf74783mr16506369edp.385.1668537407411; Tue, 15
 Nov 2022 10:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20221115000130.1967465-1-memxor@gmail.com> <20221115000130.1967465-8-memxor@gmail.com>
In-Reply-To: <20221115000130.1967465-8-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 15 Nov 2022 10:36:36 -0800
Message-ID: <CAJnrk1aynT73OZJauUEn_OFkVBsZ0wGSZHjnDSKwUG_wYd1Opw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/7] selftests/bpf: Add test for dynptr reinit
 in user_ringbuf callback
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, David Vernet <void@manifault.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Mon, Nov 14, 2022 at 4:01 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The original support for bpf_user_ringbuf_drain callbacks simply
> short-circuited checks for the dynptr state, allowing users to pass
> PTR_TO_DYNPTR (now CONST_PTR_TO_DYNPTR) to helpers that initialize a
> dynptr. This bug would have also surfaced with other dynptr helpers in
> the future that changed dynptr view or modified it in some way.
>
> Include test cases for all cases, i.e. both bpf_dynptr_from_mem and
> bpf_ringbuf_reserve_dynptr, and ensure verifier rejects both of them.
> Without the fix, both of these programs load and pass verification.
>
> Acked-by: David Vernet <void@manifault.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Joanne Koong <joannelkoong@gmail.com>

Left a small comment below.

> ---
>  .../selftests/bpf/prog_tests/user_ringbuf.c   |  2 ++
>  .../selftests/bpf/progs/user_ringbuf_fail.c   | 35 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> index 39882580cb90..500a63bb70a8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> @@ -676,6 +676,8 @@ static struct {
>         {"user_ringbuf_callback_discard_dynptr", "cannot release unowned const bpf_dynptr"},
>         {"user_ringbuf_callback_submit_dynptr", "cannot release unowned const bpf_dynptr"},
>         {"user_ringbuf_callback_invalid_return", "At callback return the register R0 has value"},
> +       {"user_ringbuf_callback_reinit_dynptr_mem", "Dynptr has to be an uninitialized dynptr"},
> +       {"user_ringbuf_callback_reinit_dynptr_ringbuf", "Dynptr has to be an uninitialized dynptr"},
>  };
>
>  #define SUCCESS_TEST(_func) { _func, #_func }
> diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> index 82aba4529aa9..7730d13c0cea 100644
> --- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> +++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> @@ -18,6 +18,13 @@ struct {
>         __uint(type, BPF_MAP_TYPE_USER_RINGBUF);
>  } user_ringbuf SEC(".maps");
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_RINGBUF);
> +       __uint(max_entries, 2);
> +} ringbuf SEC(".maps");
> +
> +static int map_value;
> +
>  static long
>  bad_access1(struct bpf_dynptr *dynptr, void *context)
>  {
> @@ -175,3 +182,31 @@ int user_ringbuf_callback_invalid_return(void *ctx)
>
>         return 0;
>  }
> +
> +static long
> +try_reinit_dynptr_mem(struct bpf_dynptr *dynptr, void *context)
> +{
> +       bpf_dynptr_from_mem(&map_value, 4, 0, dynptr);
> +       return 0;
> +}
> +
> +static long
> +try_reinit_dynptr_ringbuf(struct bpf_dynptr *dynptr, void *context)
> +{
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, dynptr);
> +       return 0;
> +}
> +
> +SEC("?raw_tp/sys_nanosleep")
> +int user_ringbuf_callback_reinit_dynptr_mem(void *ctx)
> +{
> +       bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_mem, NULL, 0);
> +       return 0;
> +}
> +
> +SEC("?raw_tp/sys_nanosleep")

nit: here and above, I think this should just be "?raw_tp/" without
the nanosleep, since there is no nanosleep tracepoint.

> +int user_ringbuf_callback_reinit_dynptr_ringbuf(void *ctx)
> +{
> +       bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_ringbuf, NULL, 0);
> +       return 0;
> +}
> --
> 2.38.1
>
