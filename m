Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B735B6F082B
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244224AbjD0PWZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244214AbjD0PWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 11:22:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD9B10DE
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 08:22:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4efea4569f5so6710572e87.3
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682608931; x=1685200931;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=azf0vFo5PyUIh6TsogEr8l9bp01KprE1c00QzEn67NY=;
        b=Iv76G303im1qMn/PUf/21Clv7ZtSFeIT5KByWsKLB3wnIxgwY+tQa/peWXXe8HEF14
         2onLUPsLT2aZX+vMgzKi494Ygk72n6lE5jXzzKl0WG7+GEIGepmQIuBkxEb2cmU2ucV8
         Rz7gBp4aGdNsF0q452mnSU1xwc1yyyumbKghtx9PTYI1STOVyZ53x8TStOyvOx12f93u
         JM8a9CybFZc8XOWKc+tQhIMbqrR1lFPSu/W4VG0zFU7TCec7ZBmmV2Zvj6yA23etRuq/
         fO3paaltlBrUFoR+iU+qAZWf+ac9MQi2wtWfGFMWAdN0DnASW3K+KI48tyeWVcd30CV3
         N6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682608931; x=1685200931;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azf0vFo5PyUIh6TsogEr8l9bp01KprE1c00QzEn67NY=;
        b=QU/z5aG7urCFOBwKd+nKqMMtFoMoSrvWq3KGNrdhmip7syAw2kkGQ9EbXcW+bFjkJO
         3ZcqQsfMOjVVubPUDGHggoa2f4rA3LyT2GpQeVgNVOM4wIEnFrrNfQalxI/iqyYMEy4F
         Z7RwFq+2QZg/Z3KQ1AkoqXrkdKAI6aqJR545p50OMeF9f6iE3CUCydl4fDy5wF/0kvsI
         qMjZ3vH8kP4VoDnYbWPlCIT1sNTuL+WphsBddYoRsZI0/CNAqrzzuebKkvv81FGyr85Z
         tKzevNa5YprwGKuQTSdT0QzZW8Z9RacyHi4EeHmJ+hw+6tgfoBFGQ6q6Zm7k/n22Olel
         ujyw==
X-Gm-Message-State: AC+VfDwYctmOXHO4kpWZeSFZzJauy/oQkyLLaMmLR+29cNM+mpPR90Tu
        eWF8X73wG9gF2D4DVzQatXlrLX2v9m0=
X-Google-Smtp-Source: ACHHUZ7itwQTXU1bTMmzs9bOlL+duxAPZLxzGaNttE/36lgnVHAQ5Ylw3vX1n1FX61JSl/bce8KdJQ==
X-Received: by 2002:ac2:4550:0:b0:4ed:c089:6e68 with SMTP id j16-20020ac24550000000b004edc0896e68mr733953lfm.41.1682608930625;
        Thu, 27 Apr 2023 08:22:10 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f9-20020a19ae09000000b004eff64a26ccsm1384404lfc.196.2023.04.27.08.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 08:22:09 -0700 (PDT)
Message-ID: <10266b33214afa1aedf90bb61208abf392cfa7ff.camel@gmail.com>
Subject: Re: Support for the pseudo-C BPF assembler syntax in GAS
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        gmartinezq07@gmail.com
Date:   Thu, 27 Apr 2023 18:22:08 +0300
In-Reply-To: <87o7n98wep.fsf@oracle.com>
References: <878reeilxk.fsf@oracle.com>
         <733c57eb-1299-57ae-7aa5-a9dbd51f5559@meta.com> <87zg6ufnrr.fsf@oracle.com>
         <CAADnVQ+MNbWCWD14xf50nK-CsAdzQqsnY3x4uSuxO=pNDdmZXA@mail.gmail.com>
         <87o7n98wep.fsf@oracle.com>
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

On Thu, 2023-04-27 at 12:14 +0200, Jose E. Marchesi wrote:
> Odd.  I replied to this yesterday, but somehow it wasn't sent.
>=20
> > On Wed, Apr 26, 2023 at 12:35=E2=80=AFPM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> > >=20
> > >=20
> > > > On 4/26/23 10:37 AM, Jose E. Marchesi wrote:
> > > > > Just a heads up, we just committed support for the assembly synta=
x
> > > > > used
> > > > > by clang to the GNU assembler [1].
> > > >=20
> > > > Thanks! Do you which gcc release is expected to contain these chang=
es?
> > >=20
> > > This is the assembler, i.e. binutils.
> > > We don't need to update the compiler.
> > >=20
> > > > > Salud!
> > > > > [1] https://sourceware.org/pipermail/binutils/2023-April/127222.h=
tml
> >=20
> > This is awesome!
> > We recently converted tens of thousands of lines of bpf asm from macros
> > to inline asm in C.
> > See tools/testing/selftests/bpf/progs/verifier_*.c
> > I wonder how gas-bpf can deal with that.
>=20
> Inline assembly shall work.

There is also an LLVM testcase [1] where most of the instructions are cover=
ed,
but you probably have something similar.

Just of the curiosity, is the state machine generated by some tool or
is it "pen and paper" exercise?

[1] https://github.com/llvm/llvm-project/blob/main/llvm/test/CodeGen/BPF/as=
sembler-disassembler.s

>=20
> > We had to fix several inline asm issues in clang to get to this point
> > and probably more to come.
>=20
> We will give these tests a try and fix problems as we find them :)
>=20
> We actually came with some ambiguities, undefined stuff, and other
> issues with the syntax while doing the implementation.  We hope to
> discuss some of that during the LSF/MM/BPF next week, so we can
> consolidate the language in both toolchains.
>=20
> Speaking of which, we are preparing the material for the "compiled BPF"
> activity during LSF/MM/BPF.  I think the BPF track hasn't been scheduled
> yet, but how much time will we have to discuss about the topic?

