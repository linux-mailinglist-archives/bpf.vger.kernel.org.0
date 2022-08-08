Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFE758D077
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 01:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbiHHX0O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 19:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244528AbiHHX0N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 19:26:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ADE167E6
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 16:26:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qn6so7521857ejc.11
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XXPyRo3qEZ9cuycZhN6dfSJJGfe7DaOHg2cr3cfJ3BA=;
        b=NJTPngWb19kFCBrzbSCjGoHEpMGrqk1kVtbJS85Y0tnpNs9uPH1itkv6jIXo3hNhAd
         gtTzyEblkcupwfS2sVhBjWHrEc93sOCFmEjLH9xzuX13Yvs+geyD2IZ5QRXlS/8ArZyt
         DAE0R7pX34nxYyaUiSIfZ/kuVDPqYyCEKlmaq2l9sk9ujUAJFxe8r86AKuvHEyvfoIfN
         PypTZw3IH0X63+Q/fMuB1Oq/R5/mhIQTtbpETOHYzMPa67CQ6XvUKoTek073jbSUPxzo
         fCz3lrd6HTVHdmckV3FGk0PSt5NF+3ja9Nnfw8fcysjBGY2Mi2bxcFB9zgg77Q/V9EbS
         JzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XXPyRo3qEZ9cuycZhN6dfSJJGfe7DaOHg2cr3cfJ3BA=;
        b=QYe6yW0FeVVQehosw3k5zpG1cn2rmdhbGXEy1WGR6OydNdPUXltZYc1JyRh+7NTFMh
         Jtr0R/RTXP1AfSnPZnY9M3x7SHL2ZnPoyCg9p1/5op6/bm+Yfw61kp6f3Olq+zdRGL4N
         mCCxw6YgjI70Bxxur6CqlHagZY1qrjTBEZMtiITd6D9pHDaH4QAAUO8ZbKwsuUX8cAWY
         1YHwCA+YuDTYoIuOLjO2gkMb68Z70LvGFB+cyGUu6w1lzXNVAKNjluGHzYNuE54piMO0
         gqCUBwqogV8D/QPlUYB7N7wpwMqEd7TKgUh/005W2fSR65LmQlEw8TJQH2/2pBeyXOEr
         JYLw==
X-Gm-Message-State: ACgBeo3uUGFgu27oggw09RV+ER0pp89YyQgHnkMZFssYDJn/k6dBjBAJ
        OX/POds/th3rAvOc4RFNaKpadBPbl9abSRbmvD8=
X-Google-Smtp-Source: AA6agR5ZhxQfLErv+qalcLvYLzlBq1CqQ3hP9x53sw4QxTX42viclQMr9tC4JlBIzfj0+8nJu2vQW44vV+Ys3zt1nl8=
X-Received: by 2002:a17:907:3e08:b0:730:d55c:1b26 with SMTP id
 hp8-20020a1709073e0800b00730d55c1b26mr15002005ejc.226.1660001170588; Mon, 08
 Aug 2022 16:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220807175111.4178812-1-yhs@fb.com> <20220807175126.4179877-1-yhs@fb.com>
In-Reply-To: <20220807175126.4179877-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Aug 2022 16:25:59 -0700
Message-ID: <CAEf4BzY7xdJx9uEGA-_Jx+VOnz2EdGrjyLrHENp-SsG2U+zPGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add tests with u8/s16 kfunc
 return types
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 7, 2022 at 10:51 AM Yonghong Song <yhs@fb.com> wrote:
>
> Add two program tests with kfunc return types u8/s16.
> With previous patch, xlated codes looks like below:
>   ...
>   ; return bpf_kfunc_call_test4((struct sock *)sk, (1 << 16) + 0xff00, (1 << 16) + 0xff);
>      5: (bf) r1 = r0
>      6: (b4) w2 = 130816
>      7: (b4) w3 = 65791
>      8: (85) call bpf_kfunc_call_test4#8931696
>      9: (67) r0 <<= 48
>     10: (c7) r0 s>>= 48
>     11: (bc) w6 = w0
>   ; }
>     12: (bc) w0 = w6
>     13: (95) exit
>   ...
>   ; return bpf_kfunc_call_test5((struct sock *)sk, (1 << 8) + 1, (1 << 8) + 2);
>      5: (bf) r1 = r0
>      6: (b4) w2 = 257
>      7: (b4) w3 = 258
>      8: (85) call bpf_kfunc_call_test5#8931712
>      9: (67) r0 <<= 56
>     10: (77) r0 >>= 56
>     11: (bc) w6 = w0
>   ; }
>     12: (bc) w0 = w6
>     13: (95) exit
>
> For return type s16, proper sign extension for the return value is done
> for kfunc bpf_kfunc_call_test4(). For return type s8, proper zero
> extension for the return value is done for bpf_kfunc_call_test5().
>
> Without the previous patch, the test kfunc_call will fail with
>   ...
>   test_main:FAIL:test4-retval unexpected test4-retval: actual 196607 != expected 4294967295
>   ...
>   test_main:FAIL:test5-retval unexpected test5-retval: actual 515 != expected 3
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  net/bpf/test_run.c                            | 12 +++++++
>  .../selftests/bpf/prog_tests/kfunc_call.c     | 10 ++++++
>  .../selftests/bpf/progs/kfunc_call_test.c     | 32 +++++++++++++++++++
>  3 files changed, 54 insertions(+)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index cbc9cd5058cb..3a17ab4107f5 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -551,6 +551,16 @@ struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
>         return sk;
>  }
>
> +s16 noinline bpf_kfunc_call_test4(struct sock *sk, u32 a, u32 b)
> +{
> +       return a + b;
> +}
> +
> +u8 noinline bpf_kfunc_call_test5(struct sock *sk, u32 a, u32 b)
> +{
> +       return a + b;
> +}

Is there any upside of adding this to net/bpf/test_run.c instead of
defining it in bpf_testmod?

> +
>  struct prog_test_member1 {
>         int a;
>  };

[...]
