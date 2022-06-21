Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B262553ACE
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 21:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352338AbiFUTyh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 15:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiFUTyg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 15:54:36 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F91CF2
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 12:54:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p128so15387438iof.1
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=WVOYT/wnWpwzCJMAJ5+OqFLdXydn8uXbEe1JFnqyipI=;
        b=q4gSQonLoAfcu21WNxlUAVQgw/DRLXt7NrY8RHjky5+yQBHat/D3U2573uaVWCP1yD
         4ic3qgZKks4acaavqJ3akuFx8VlVDC6mM5CvakC/XBqxcVN6+Q0IZ/BwDRvtBh5FDUjc
         J9MiQRL06kOU4CxT/FT9/cwsaQhvJJV+kUyJt1h4vvQ3kA4jkm9e/F/vxL2vPPfOZUUO
         pBquhAo6rkekqhkHTsT3oayYrtkLlyy4WwMGziYa2tpjMAxZeAF1fwlH6XC/Aj/Bcbrj
         J0Be3c66LjS49r1C+F9nRKOA3ub75IAkBl7jYkyVb4q7Kqezfm1EUjKHwlTUtK22xoGl
         GIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=WVOYT/wnWpwzCJMAJ5+OqFLdXydn8uXbEe1JFnqyipI=;
        b=6ZAcuBpKyDJAsB9/7DiT2mHhv1LEild7alVqdb+AdAx1LKla3sEPOnsArTvf5oY4oD
         7MbNFMy4lpow2I1+hvvV4uRPmolKeiGBvr9+EWB/q/17rZ4dmlX5RWpwqRbtK5uc9LO5
         Gl2e8E8lEcH0jx3Acz1vfGL/vh0K7zRTp48OUjvwLRHiZIe1MSnqhMIL7Gc461dw95iw
         tI/nVnETy3XcEl5xWhwuTWbfZhScOUACCi/MFPpKvrFAe5CuGP1tuIooa5dZ+c1qfsds
         CIbmqPfMoRkADR0QnPatHIC/jDhW3RK+lUVUJKJpHm401aCbY5fuaMFtwksaAk6KhIZx
         ilRw==
X-Gm-Message-State: AJIora9CQ8xNecoLuTbN3J/Hmjza1/JmRDlU8IgKuOcyYeVVul7kUnBU
        5nBWfK280A7WFx2pLXAVRro=
X-Google-Smtp-Source: AGRyM1tLmbr/bAzAiGgJoAG8Bgghjn15mrrUHOS568CWxqjF0Rl19bpb+lnGn/G44yVYtaeAueFnQA==
X-Received: by 2002:a05:6638:53c:b0:331:7874:654f with SMTP id j28-20020a056638053c00b003317874654fmr17100875jar.158.1655841275233;
        Tue, 21 Jun 2022 12:54:35 -0700 (PDT)
Received: from localhost ([172.243.153.43])
        by smtp.gmail.com with ESMTPSA id l4-20020a6b3e04000000b0066cc83ee8c2sm7963314ioa.48.2022.06.21.12.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:54:34 -0700 (PDT)
Date:   Tue, 21 Jun 2022 12:54:27 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>
Message-ID: <62b221f3886d0_16274208b@john.notmuch>
In-Reply-To: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
References: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
Subject: RE: [PATCH bpf-next] selftests/bpf: Fix rare segfault in sock_fields
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
> test_sock_fields__detach() got called with a null pointer here when one=

> of the CHECKs or ASSERTs up to the test_sock_fields__open_and_load()
> call resulted in a jump to the "done" label.
> =

> A skeletons *__detach() is not safe to call with a null pointer, though=
.
> This led to a segfault.
> =

> Go the easy route and only call test_sock_fields__destroy() which is
> null-pointer safe and includes detaching.
> =

> Came across this while looking[1] to introduce the usage of
> bpf_tcp_helpers.h (included in progs/test_sock_fields.c) together with
> vmlinux.h.
> =

> [1] https://lore.kernel.org/bpf/629bc069dd807d7ac646f836e9dca28bbc1108e=
2.camel@mailbox.tu-berlin.de/
> =

> Fixes: 8f50f16ff39d ("selftests/bpf: Extend verifier and bpf_sock tests=
 for dst_port loads")
> Signed-off-by: J=C3=B6rn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
> ---
>  tools/testing/selftests/bpf/prog_tests/sock_fields.c | 1 -
>  1 file changed, 1 deletion(-)
> =

> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c b/too=
ls/testing/selftests/bpf/prog_tests/sock_fields.c
> index 9d211b5c22c4..7d23166c77af 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> @@ -394,7 +394,6 @@ void serial_test_sock_fields(void)
>  	test();
>  =

>  done:
> -	test_sock_fields__detach(skel);
>  	test_sock_fields__destroy(skel);
>  	if (child_cg_fd >=3D 0)
>  		close(child_cg_fd);
> -- =

> 2.30.2
> =


But we should still call __detach(skel) after the !skel check
is done I assume. So rather than remove it should add a new label
and jump to that,

  =

 done:
   test_sock_fields__detach();
 done_no_skel:
   test_sock_fields__destroy()=
