Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104DF5B47F0
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiIJShy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIJShx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 14:37:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B236481C7;
        Sat, 10 Sep 2022 11:37:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id v16so11266135ejr.10;
        Sat, 10 Sep 2022 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=J3D/ARkSkqKI85ccm0AMVtwEb1skGkqx7TLvFxAbwM0=;
        b=GiIm7U3J5Reg7owAgAksi+e0a1Tid5Z/3k/dq7aNDlhkQYPwnAtIolQT/WmItfeFl9
         X0HRuJvuWggo1GjcBohcNNBqtV9FqUDXJWh9ly1gC50deEwre8P7XbAxiOrd/pB9oc8r
         2acUpW5u+l2DtPqbNsPSGQp5BP0Ga7N490AvmQqCrIscPmNV1W2gswzHiZu+v8dHkCjl
         CZfrjZpfJG3OUeLWu9933KTlbNKX/s9ti9vXcksXiyqfC9ZiWyQXV7XKzzM4hauoTU5U
         RIzyqLYJndMqDPCSZd3L9Mx8pRIB08yyMv9DP39XLlVzBc/Y3N3zI5yj9G2evWN3czQ8
         Pnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=J3D/ARkSkqKI85ccm0AMVtwEb1skGkqx7TLvFxAbwM0=;
        b=iS8FHHUN2Ozr4jZoAsX9PPBogbHbT/LHhtTbP6rFrbYQQ4QK4AMekU9wLPxhtuIUYF
         n9eb6Of7CiRBlRG8sP7dKLvWzzlw91jJXUgSuAsotYHLpbRtardNOmTIl0jpYEgrSz56
         PtLwZbdPh1QLl98qO/ZQco/ep0vAGl7MYn4VuLUW9Xi8RlVUxKLwLKQbYSNmmVjXIr0x
         +9w+iVor551T+UtI35q/1TlU5wpaDzqhThYyaUzvtwqw2yJF3ap677GHclxkc9E3GpZL
         wvCKu5TWKNAtaL5QVO3CqYvOQdp6HTkSFKeMMtxSV3f7rdrSxTKATT7bCPgFTeliqWzm
         uNzg==
X-Gm-Message-State: ACgBeo2dCFVeMU6WR7GroTtTvv/1KSv0KTMrIBJINMZjO0bgR8Lvb6WH
        9a7HpsQpW2coNWrzjnYP6MroD//oLzqrUd7Xci8=
X-Google-Smtp-Source: AA6agR7MVenKlUXQoi9uH76H13dv4xZZFty1YmiZVlH6XdxVv25sbN+UGRwBWYDaMhnt8RH5j8LuKb+THoc1QqC2K+M=
X-Received: by 2002:a17:906:58d1:b0:76d:af13:5ae3 with SMTP id
 e17-20020a17090658d100b0076daf135ae3mr14321706ejs.708.1662835071050; Sat, 10
 Sep 2022 11:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220829210546.755377-1-james.hilliard1@gmail.com>
 <CAEf4Bza6g4tZDtuKCaBwVVJSHUrLYh=pbUffPBpmWtR-xyXyqQ@mail.gmail.com>
 <CADvTj4pF=D7PEBF-LK_sKckRUCq-vd9ZjohpiEgLvORg8UaZyw@mail.gmail.com>
 <CAEf4BzbjMWC50J-mn_aNd2BeJWU=nLJmsJCAVvTqLSYsh4RejA@mail.gmail.com>
 <CADvTj4qLhgQ1K30dKoviw10G6f5XTv7T6SChUPvYnNWZGxw4OA@mail.gmail.com>
 <871qsjyb41.fsf@oracle.com> <CADvTj4ov8wnWCGXsKRF5QJn9_+NQ8RspydrGPjE5=9KWZQuNEA@mail.gmail.com>
 <87r10j7h8r.fsf@oracle.com>
In-Reply-To: <87r10j7h8r.fsf@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 10 Sep 2022 11:37:39 -0700
Message-ID: <CAADnVQL3HpDVUD3FHhLYqUjZ32K1pd5e6YCLBRsMVdiWc-+CCg@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: add GCC support for bpf_tail_call_static
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        David Faust <david.faust@oracle.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        elena.zannoni@oracle.com
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

On Sat, Sep 10, 2022 at 1:43 AM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> 2) If/when we support the C-like assembly syntax in GCC,

Thank you for considering supporting the standard BPF assembly
syntax in GCC.
I agree that C-like asm looks unusual.
The main reason to pick that style was the ease of understanding
and to avoid gnu vs intel asm order confusion.
We didn't want to deal with question whether 'mov r1, r2'
means r1->r2 or r2->r1. The C style asm r1=r2 is unambiguous.
