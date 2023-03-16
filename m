Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F319B6BDCF4
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 00:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCPXe0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 19:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCPXeQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 19:34:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05402CC307
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 16:34:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g18so3404384ljl.3
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 16:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679009639;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A35UPgjXrlq4i1Otz9+DXDvVDm8u70w87HcU1qDNYfw=;
        b=HhAM00u/eRJUEPFNtssy5xPyMssW8kNU1Kv9o6RzcVgsXQweLH7MGl/7eeYP9MyAdr
         /RZn+A2TYk1WvcPXkzcIl1Vk+WmGBcCHRQRoqMywTlGP08S2qs9P/yDmYi2DBYUkrF6n
         JNrVA3IX99ly06puG7SZJnZk5pbB1olDX0caZm51GlccXlM9r/SvSn8AcgZ3VnYE42fK
         SflsjfNggxLTezpS+tIrRq7EN+6W79opB6hF2JlaAUnBL/zw8+TsF+awHqb2cmcnP/S0
         5cFB33vkYKsTKE1pbbybYtoJufJiLKvR5RupVoyNvlTqWkKSZH+xouDZhAhkw4T0BGuR
         R3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679009639;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A35UPgjXrlq4i1Otz9+DXDvVDm8u70w87HcU1qDNYfw=;
        b=dvySoDVH4nrtBYlUF0wiSMTlP1Qxb+5lsGRJC5MfDkci0przg+K1eR3xt2ctQ6iS8C
         kkl/H5jBvdQYwEBeKnnPGG9Gt4BNX3JTkJBboNtNfDbagQwydFQAzLLife/8Hm3ANFDf
         NABZ1VkgqxAsyVt8CG8F1mK8JuQ50VRetA4qq+jOOxCDr5xkNlLH0AZUn5L4FYl1bEql
         iAqYxNqjmmUl+a1Zol0Yt9cFb7tdASxK5lIER0fFSYVGaUkFLBgxLouAN5tcolbdMr32
         EKFS55qBGAg+Id39l7KPLL3WERZo22irdIZbde14cLeRbDWMrqSwBY/lHCj9CqY8IP+y
         Y/vA==
X-Gm-Message-State: AO0yUKVef/2zye8RSOKMJantKfaDefUS3PfFh6fcWriwKuZ/urEVxEsM
        6ieoMTXO0C+PCPSKWk87PGKOuy2E4tlR8COI
X-Google-Smtp-Source: AK7set9gowzncso8M+phXxKPp/CkB+cmeNiFbcJ+qSUOou8a0mBe0t2Soj7qQWAWC2zc+Q4IRYiipg==
X-Received: by 2002:a2e:bc20:0:b0:298:a7f4:850a with SMTP id b32-20020a2ebc20000000b00298a7f4850amr3362783ljf.32.1679009639231;
        Thu, 16 Mar 2023 16:33:59 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a23-20020a2e8317000000b0029588e503ebsm127402ljh.7.2023.03.16.16.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:33:58 -0700 (PDT)
Message-ID: <88930a425a50f6c1f5a420bf2adbec3b285b96e4.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add --json-summary option to
 test_progs
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com
Date:   Fri, 17 Mar 2023 01:33:56 +0200
In-Reply-To: <CAEf4BzZj6FP+=UYVXEq8bsqk0Os2zLKB2B60vyVO9+FL5jnttw@mail.gmail.com>
References: <20230316063901.3619730-1-chantr4@gmail.com>
         <665c32ae4ef880c1811b8a8e3b35a7ad0bcfb054.camel@gmail.com>
         <ZBNGBAAki3VUU0bQ@worktop>
         <97845fbdc4178dd3d7bea836b245af2c82347b94.camel@gmail.com>
         <CAEf4BzZj6FP+=UYVXEq8bsqk0Os2zLKB2B60vyVO9+FL5jnttw@mail.gmail.com>
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

On Thu, 2023-03-16 at 16:23 -0700, Andrii Nakryiko wrote:
> > [...]
> >=20
> > > In term of logical structure and maybe extensibility, this is more ap=
propriate,
> > > in term of pragmatism maybe less.
> > >=20
> > > I don't have strong opinions and can see benefit for both.
> >=20
> > idk, I don't have a strong opinion either.
>=20
> me neither, flatter struct would be simple to work with either with jq
> or hacky grepping, so I guess the question would be how much do we
> lose by using flatter structure?

Okay, okay, noone wants to read jq manual, I get it :)

I assume that current plan is to consume this output by some CI script
(and e.g. provide a foldable list of failed tests/sub-tests in the
final output). So, we should probably use whatever makes more sense
for those scripts. If you and Manu think that flat structure works
best -- so be it.
