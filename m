Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22C66BD8CC
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 20:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCPTTG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 15:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCPTTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 15:19:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BD3E41F4
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 12:18:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id s8so3399498lfr.8
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678994300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OykuwABpziajmp0NgdiMHasKnOotExIYwlmUCU/ZqnA=;
        b=JwXMkUX1W1QnWQ26iYoEqqpcHNSyxPK+FeSe2WJdpS+46kJm3GKAFqXTX8W1zKv/VD
         6rZHXiGLUOyKAkjc1l5Frv4DEKdMyWzQ1JOnfj11hFFnJQ6RZ5V47Od0Ldv95gI8thkK
         ON0oN6Q/lhYuUWSQiSWkG5hgj2vR1Bgj35RtmwXGaCMOzGGokwRZAWUjT+FIGChwqi6R
         sjgwos6gRixZe5dTLrO+fb1HmK7AiGuNm3pJEwIfUUa1TU1fwUY2b6P560i9tilnGSan
         x8s7YmwEZxqB77ytTE+JN3D9nJ5ftHynd4JdFdrCBLoZX8G3lB4vPgZ/zsKXWdV1PfIz
         V1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678994300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OykuwABpziajmp0NgdiMHasKnOotExIYwlmUCU/ZqnA=;
        b=A2/sxhXSuVp1LtK6SU877d3iBuP6YEgZ4EeCdtFQ+ZNmqs+DssBcgjIth7PdpNaCRH
         o990rKOmtPifNZfIU+ryo5d6qtIR9EbliI4lAAoPKqLL35kcNjX3xqVLJN2nAP8fDvGy
         iFbCyNGlsWAz1L4GfMzf7TaH3+5RWH+x0aDrxCMfSCQDRqPoocbFrNwKjuVQA3Mtbfl5
         Wajypg1yt/K16EIGjjwWVni7sC6BRE86+5fHFyRsTJcUMu0vGLQ3Nyzqq/kyfKvqSuDD
         2jkrl0xNh6gbiNcoJqZGDM1OoqwAKHpaK/cRPesMM48fNHDhkBcaUlx6rlUfyveK+qr2
         n5Gg==
X-Gm-Message-State: AO0yUKWK0o4wQWp7VqQHep+C1kA2sGLsDariGs5i2WJN2OVf1TuhYTw7
        DBymTpudKQnL4hTAvTXe6LY=
X-Google-Smtp-Source: AK7set+u6gtLybYC/h6gQZG5jnC+u60qJkmZKyMxUVZ37IovIXsqEyzufgRyEl7Wul50kATU8Ui3BQ==
X-Received: by 2002:a05:6512:108a:b0:4d8:86c1:4772 with SMTP id j10-20020a056512108a00b004d886c14772mr168095lfg.7.1678994300382;
        Thu, 16 Mar 2023 12:18:20 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b25-20020ac24119000000b004db266f3978sm8322lfi.174.2023.03.16.12.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:18:19 -0700 (PDT)
Message-ID: <97845fbdc4178dd3d7bea836b245af2c82347b94.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add --json-summary option to
 test_progs
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Manu Bretelle <chantr4@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com
Date:   Thu, 16 Mar 2023 21:18:18 +0200
In-Reply-To: <ZBNGBAAki3VUU0bQ@worktop>
References: <20230316063901.3619730-1-chantr4@gmail.com>
         <665c32ae4ef880c1811b8a8e3b35a7ad0bcfb054.camel@gmail.com>
         <ZBNGBAAki3VUU0bQ@worktop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-03-16 at 09:38 -0700, Manu Bretelle wrote:
> [...]
>
> I was originally going to do a nested structure similar to this too
> (minus the repeat of test_* entries for subtests. But while discussing th=
is
> offline with Andrii, a flatter structured seemed to be easier to parse/ma=
nage
> with tools such as `jq`. I am also very probably missing the right
> incantation for `jq`.
>=20
> Finding whether a test has subtests (currently only adding failed ones,
> but this could change in the future) would be easier (essentially checkin=
g
> length(subtests)). But neither is it difficult to reconstruct using
> higher level language.
>=20

`jq` query is a bit more complicated with nested structure, but not terribl=
y so:

  $ cat query.jq
  .results | map([
                  .test_name,
                  (.subtests | map([([.test_name, .subtest_name] | join("/"=
)) ]))
                 ])
           | flatten

  $ jq -f query.jq test.json
  [
    "test_global_funcs",
    "test_global_funcs/global_func16"
  ]

Test data for reference:

  $ cat test.json | sed -r 's/"[^"]{20,}"/"..."/g'
  {
      "success": 1,
      "success_subtest": 24,
      "skipped": 0,
      "failed": 1,
      "results": [{
              "test_name": "test_global_funcs",
              "test_number": 223,
              "message": "...",
              "failed": true,
              "subtests": [{
                      "test_name": "test_global_funcs",
                      "subtest_name": "global_func16",
                      "test_number": 223,
                      "subtest_number": 16,
                      "message": "...",
                      "is_subtest": true,
                      "failed": true
                  }
              ]
          }
      ]
  }

> In term of logical structure and maybe extensibility, this is more approp=
riate,
> in term of pragmatism maybe less.
>=20
> I don't have strong opinions and can see benefit for both.

idk, I don't have a strong opinion either.

> [...]
