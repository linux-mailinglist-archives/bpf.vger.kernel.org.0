Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53FD5571CC
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 06:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiFWEkC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 00:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbiFWD3Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 23:29:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF09D3584F
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 20:29:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s185so12164515pgs.3
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 20:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=v2cMJ22H421S3fhYLc4f4jwE1UZ1i2XJOMgK6XKGTmI=;
        b=NzddAi+hvTRYyY4ArlVtSKNwukA4qtzfcdLE+XUz6THeX1B70vgXw10bVGAd909Ev0
         ySke1Bh5+Y5kIbyaPqIlxKhLbPQ4/p7X/R2bx7oA/flYxXyVb1FWcFwWH/b6V5fJnFi3
         8I5S1pyDUnW4P5rTvMPOEYX4XitUEykk4Tt0v36ZJnhGgX/1nPZEcqoMU11hBSvCt3pW
         GbmScZCBlOBkQfrn/KATckzMg65qwJJV5zfgNyBODDNxtHS4sSawSPSHNO1p1kXT2eyv
         dq+rLuzzyXTGz295yv+xUV6iqBWo26BuqY6cGh0QcNqKog+K6Lxr47ybBsPRy0BchJT+
         qr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=v2cMJ22H421S3fhYLc4f4jwE1UZ1i2XJOMgK6XKGTmI=;
        b=KKVNDFrZXxO4xvCb+ciz5cV8IXhMN9ZaHj194FU8SeixGxvc4rnPRis/a9k6IrLHoV
         Qh7yq8E/Qqy+IrzC3QmyTyPjw7XGo1Eh4AFanIKncdfXymvc1WF7rVtFUHlksxSO4YBK
         QCkInz+672V1UEXTIuIRIjKCNpjUXc0g4A7BXLJQ9z3dEDZPvR18AdXA/X8YTnBaTyIy
         niv1PexgvNV+4dEB5RIG/5RTYs5uCrTrX7NdD9yUiE5G3nx3HII/SkjpM4SFi5cCZfv5
         yE9zFTZpfmGrfOAN08hk8GW94YtRBTSzBJEKTsRbCUn6M27kWOqgpXiZv7SC9AiOMWJS
         COFA==
X-Gm-Message-State: AJIora+TZ1QjPaUeg50IUXRn59TIh8rO7eFxIUKvVtnCZf3atWsK4mGC
        rOM+lFQj970rNrgO2QjKXaA=
X-Google-Smtp-Source: AGRyM1v1/Vx1GP7GB/xRFRFRBjN7YiJ8Ray3RBxc6u6P2G3lN+6131UxKhUuEy1Ourb/KfMKzi2flg==
X-Received: by 2002:a63:7b5c:0:b0:40d:684:b760 with SMTP id k28-20020a637b5c000000b0040d0684b760mr5793955pgn.323.1655954963344;
        Wed, 22 Jun 2022 20:29:23 -0700 (PDT)
Received: from localhost ([98.97.116.244])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902ed5200b00168c4c3ed94sm5175429plb.309.2022.06.22.20.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 20:29:23 -0700 (PDT)
Date:   Wed, 22 Jun 2022 20:29:21 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>
Message-ID: <62b3de11c4d5a_6a3b220898@john.notmuch>
In-Reply-To: <2fb2e2f72f2bead11cf24f9ee2558e2f4169aec9.camel@mailbox.tu-berlin.de>
References: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
 <62b221f3886d0_16274208b@john.notmuch>
 <2fb2e2f72f2bead11cf24f9ee2558e2f4169aec9.camel@mailbox.tu-berlin.de>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix rare segfault in sock_fields
 prog test
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

J=C3=B6rn-Thorben Hinz wrote:
> On Tue, 2022-06-21 at 12:54 -0700, John Fastabend wrote:
> > J=C3=B6rn-Thorben Hinz wrote:
> > > test_sock_fields__detach() got called with a null pointer here when=

> > > one
> > > of the CHECKs or ASSERTs up to the
> > > test_sock_fields__open_and_load()
> > > call resulted in a jump to the "done" label.
> > > =

> > > A skeletons *__detach() is not safe to call with a null pointer,
> > > though.
> > > This led to a segfault.
> > > =

> > > Go the easy route and only call test_sock_fields__destroy() which
> > > is
> > > null-pointer safe and includes detaching.
> > > =

> > > Came across this while looking[1] to introduce the usage of
> > > bpf_tcp_helpers.h (included in progs/test_sock_fields.c) together
> > > with
> > > vmlinux.h.
> > > =

> > > [1]  =

> > > https://lore.kernel.org/bpf/629bc069dd807d7ac646f836e9dca28bbc1108e=
2.camel@mailbox.tu-berlin.de/
> > > =

> > > Fixes: 8f50f16ff39d ("selftests/bpf: Extend verifier and bpf_sock
> > > tests for dst_port loads")
> > > Signed-off-by: J=C3=B6rn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>=

> > > ---
> > > =C2=A0tools/testing/selftests/bpf/prog_tests/sock_fields.c | 1 -
> > > =C2=A01 file changed, 1 deletion(-)
> > > =

> > > diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > > b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > > index 9d211b5c22c4..7d23166c77af 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > > @@ -394,7 +394,6 @@ void serial_test_sock_fields(void)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test();
> > > =C2=A0
> > > =C2=A0done:
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_sock_fields__detach=
(skel);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_sock_fields__d=
estroy(skel);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (child_cg_fd >=3D=
 0)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0close(child_cg_fd);
> > > -- =

> > > 2.30.2
> > > =

> > =

> > But we should still call __detach(skel) after the !skel check
> > is done I assume.
> If I=E2=80=99m not mistaken, that=E2=80=99s not necessary for a proper =
clean-up. It
> should be more of a stylistic question. See the parallel message from
> Daniel (and replies).
> =

> test_sock_fields__detach() directly translates to
> bpf_object__detach_skeleton(). test_sock_fields__destroy() basically
> translates to bpf_object__destroy_skeleton(), including a null-ptr
> check.
> =

> But bpf_object__destroy_skeleton() calls bpf_object__detach_skeleton()
> as its first step. So calling __detach()/__detach_skeleton() explicitly=

> and separately is not necessary for a clean exit, if not otherwise
> required.

Seems to be the case nice catch. I'm OK with it as is then.

Acked-by: John Fastabend <john.fastabend@gmail.com>

> =

> =

> > So rather than remove it should add a new label
> > and jump to that,
> > =

> > =C2=A0 =

> > =C2=A0done:
> > =C2=A0=C2=A0 test_sock_fields__detach();
> > =C2=A0done_no_skel:
> > =C2=A0=C2=A0 test_sock_fields__destroy()
> =

> =



