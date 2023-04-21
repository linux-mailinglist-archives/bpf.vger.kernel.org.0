Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568216EB284
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 21:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjDUTtd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 15:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjDUTtc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 15:49:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3F1BF6
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 12:49:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f1958d3a85so7185505e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682106567; x=1684698567;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XuZ6HsKyRZdBZlrqPOpuLOZxovKqvZIFN0qs4rhHtqY=;
        b=SR+Tn5aV+GljzZyIvompdPG1INWZFPx43xrbbPDFePfCTvOXf4+b50SRwGktt5YP7b
         mmMOeEfnPaa5XyIisZBKjVXucJdsHnROSREJ7t0Mym3xzSnmwDxlZ04Gkkv0R7f3NzOq
         i0rD1aIvRLf1z7KcCogRqF2XkV4Rlll/0A+9ABbJoV73nFPEqT1s1WBGKwpb7Kt9qTMC
         hOSpZHyxD3BpVp0SvdRsUmGo9H0MbbRc2K8IR1/oNBXt7YEFsuBeP6O2fdQHdQ0qlDoy
         OeCXH+SODJ3Tq9KlghkcZSLAUmwrn11z8L3pW/4E/WaCPdK1OOOFkjDeb7eRYqPAroo8
         QfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682106567; x=1684698567;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XuZ6HsKyRZdBZlrqPOpuLOZxovKqvZIFN0qs4rhHtqY=;
        b=Q6gP8MruJVoSkfPdLT6d6VPG6U3ozn0gZABRX4HtNi8yMPzR4XEmZsMvOOxJFIJ0q6
         vfMRVlQ4v4epgX5IfEyaYIjgw3UW7+6HGg8ICqW4sZ30tRofcrk7fGeCWEAOIyhcdnjU
         BCQU7oW+qkAZlJmEuY4hZBWKenPbFMA5V0Ti+vmwp633ihXQb1/c5MmqvGfzoqbgpA6+
         tZ5aJHMeNZSBR8lE4NlQbCCRwiYw4EZxjySXctby2jOqWaD9ENSN4vQN1kX9U3gCQh+n
         Olpu91iCr+nOHrHlN/kolqfwcgJGooGNqRtZ5PUocD+BRWbdPxp1EDsWNlGu4nFnsr9n
         eLLQ==
X-Gm-Message-State: AAQBX9cU4J5lTx9yF1sBjd/Ie5J02BadXhe/DzqlIaBRKFbd9MpV6rbt
        2TEDEYYf9Kj9akTnnziPRLA=
X-Google-Smtp-Source: AKy350bdGWuhYnMPX48+J5NQUMYoTp+TSS16Osvz+nk5R4dnUJvs3O7crGanR5Q2BYj/bFus/Cpbiw==
X-Received: by 2002:a7b:c012:0:b0:3f1:7b48:87b4 with SMTP id c18-20020a7bc012000000b003f17b4887b4mr2510989wmb.32.1682106566677;
        Fri, 21 Apr 2023 12:49:26 -0700 (PDT)
Received: from [192.168.1.95] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ip29-20020a05600ca69d00b003f1712b1402sm8963509wmb.30.2023.04.21.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:49:26 -0700 (PDT)
Message-ID: <9af634d411efb069f64072ddd921cdf3bcb20917.camel@gmail.com>
Subject: Re: [PATCH bpf-next 00/24] Second set of verifier/*.c migrated to
 inline assembly
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date:   Fri, 21 Apr 2023 22:49:25 +0300
In-Reply-To: <168210602402.3425.11823949766258477429.git-patchwork-notify@kernel.org>
References: <20230421174234.2391278-1-eddyz87@gmail.com>
         <168210602402.3425.11823949766258477429.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-04-21 at 19:40 +0000, patchwork-bot+netdevbpf@kernel.org wrote=
:
> Hello:
>=20
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:

Hi Alexei,

Thank you for merging these changes!

I've noticed that email from the bot does not list
commit hashes for patches #13,14 (precise, prevent_map_lookup).
And these commits are indeed not in git [1].
Is this intentional?

Thanks,
Eduard

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/log/
>=20
> On Fri, 21 Apr 2023 20:42:10 +0300 you wrote:
> > This is a follow up for RFC [1]. It migrates a second batch of 23
> > verifier/*.c tests to inline assembly and use of ./test_progs for
> > actual execution. Link to the first batch is [2].
> >=20
> > The migration is done by a python script (see [3]) with minimal manual
> > adjustments.
> >=20
> > [...]
>=20
> Here is the summary with links:
>   - [bpf-next,01/24] selftests/bpf: Add notion of auxiliary programs for =
test_loader
>     https://git.kernel.org/bpf/bpf-next/c/63bb645b9da3
>   - [bpf-next,02/24] selftests/bpf: verifier/bounds converted to inline a=
ssembly
>     https://git.kernel.org/bpf/bpf-next/c/c92336559ac0
>   - [bpf-next,03/24] selftests/bpf: verifier/bpf_get_stack converted to i=
nline assembly
>     https://git.kernel.org/bpf/bpf-next/c/965a3f913e72
>   - [bpf-next,04/24] selftests/bpf: verifier/btf_ctx_access converted to =
inline assembly
>     https://git.kernel.org/bpf/bpf-next/c/37467c79e16a
>   - [bpf-next,05/24] selftests/bpf: verifier/ctx converted to inline asse=
mbly
>     https://git.kernel.org/bpf/bpf-next/c/fcd36964f22b
>   - [bpf-next,06/24] selftests/bpf: verifier/d_path converted to inline a=
ssembly
>     https://git.kernel.org/bpf/bpf-next/c/608028024384
>   - [bpf-next,07/24] selftests/bpf: verifier/direct_packet_access convert=
ed to inline assembly
>     https://git.kernel.org/bpf/bpf-next/c/0a372c9c0812
>   - [bpf-next,08/24] selftests/bpf: verifier/jeq_infer_not_null converted=
 to inline assembly
>     https://git.kernel.org/bpf/bpf-next/c/a5828e3154d1
>   - [bpf-next,09/24] selftests/bpf: verifier/loops1 converted to inline a=
ssembly
>     https://git.kernel.org/bpf/bpf-next/c/a6fc14dc5e8d
>   - [bpf-next,10/24] selftests/bpf: verifier/lwt converted to inline asse=
mbly
>     https://git.kernel.org/bpf/bpf-next/c/b427ca576f83
>   - [bpf-next,11/24] selftests/bpf: verifier/map_in_map converted to inli=
ne assembly
>     https://git.kernel.org/bpf/bpf-next/c/4a400ef9ba41
>   - [bpf-next,12/24] selftests/bpf: verifier/map_ptr_mixing converted to =
inline assembly
>     https://git.kernel.org/bpf/bpf-next/c/aee1779f0dec
>   - [bpf-next,13/24] selftests/bpf: verifier/precise converted to inline =
assembly
>     (no matching commit)
>   - [bpf-next,14/24] selftests/bpf: verifier/prevent_map_lookup converted=
 to inline assembly
>     (no matching commit)
>   - [bpf-next,15/24] selftests/bpf: verifier/ref_tracking converted to in=
line assembly
>     https://git.kernel.org/bpf/bpf-next/c/8be632795996
>   - [bpf-next,16/24] selftests/bpf: verifier/regalloc converted to inline=
 assembly
>     https://git.kernel.org/bpf/bpf-next/c/16a42573c253
>   - [bpf-next,17/24] selftests/bpf: verifier/runtime_jit converted to inl=
ine assembly
>     https://git.kernel.org/bpf/bpf-next/c/65222842ca04
>   - [bpf-next,18/24] selftests/bpf: verifier/search_pruning converted to =
inline assembly
>     https://git.kernel.org/bpf/bpf-next/c/034d9ad25db3
>   - [bpf-next,19/24] selftests/bpf: verifier/sock converted to inline ass=
embly
>     https://git.kernel.org/bpf/bpf-next/c/426fc0e3fce2
>   - [bpf-next,20/24] selftests/bpf: verifier/spin_lock converted to inlin=
e assembly
>     https://git.kernel.org/bpf/bpf-next/c/f323a81806bd
>   - [bpf-next,21/24] selftests/bpf: verifier/subreg converted to inline a=
ssembly
>     https://git.kernel.org/bpf/bpf-next/c/81d1d6dd4037
>   - [bpf-next,22/24] selftests/bpf: verifier/unpriv converted to inline a=
ssembly
>     https://git.kernel.org/bpf/bpf-next/c/82887c2568e4
>   - [bpf-next,23/24] selftests/bpf: verifier/value_illegal_alu converted =
to inline assembly
>     https://git.kernel.org/bpf/bpf-next/c/efe25a330b10
>   - [bpf-next,24/24] selftests/bpf: verifier/value_ptr_arith converted to=
 inline assembly
>     https://git.kernel.org/bpf/bpf-next/c/4db10a8243df
>=20
> You are awesome, thank you!

