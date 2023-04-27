Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F846F0870
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbjD0Pdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjD0Pdj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 11:33:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A81420E
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 08:33:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso7165129e87.0
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682609616; x=1685201616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q9GCw5VwcnkyuhXdME3SxZj0A8xBDhe1kN40RnWOfI=;
        b=iP5SlGxp5rrKgPKRq+ysMhaRavRxalWq/ed/XTN27eiUQNSdP8kpjcFv2B5tdWuk9G
         llgL/NCMU0MsAY9aC0n8nSHrZaT8KSsTfvDTOr3yf0imDp1Lwv6UHXqEmgBpLz03W6ma
         k24JQnamj8osCQsD8TesDUurX7JNrGgfU2nBHha0/K+gE4W210OYukcjXdF4XCEEg+Y5
         dr2tv/OYO57gSo8b7gkDS7zD+7Ds6xc+J7cCiDNsUJyUSrFsAszauKUsJ0/sIMWpWDGc
         LEugj4mJeuY1QS2UgY4l0Ok7jbN/yKMAUGiuJJPmW1kR+BEg6hAnPRzVqyQ5JO6S/OW6
         q2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682609616; x=1685201616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Q9GCw5VwcnkyuhXdME3SxZj0A8xBDhe1kN40RnWOfI=;
        b=LNZ6ee4YDjHZxEA041jSBEf7Pwf53cyFfB/nrQdJXk5i6jTGLWJhE1KFdcXmm7iAIr
         EQJUTTDbzfl0bmAqZJD5djY9RRRvO0TFj8z4q1Lpv+28BFxy7bdE4kTdVLv+Ue/j/2wN
         9v4i/B62ztOjBY1cSFz48uX9AVgvza10KxD3O1lgpt0q2SNDyyk0H/Ws5ysPAGcOrCuK
         tEDUZGw09ywHPpGLlXJrYLap8nZYaRKI+OkC3CgjZQ0gbBAf6N3bDZLCzsbwANzRfKO0
         5DlQyBiXqKTyEaV7cD7pwPmHYC7G5fDsq/FxbIV5PIuU2u5to4qajDq1BlGdCp7jcxeQ
         AudA==
X-Gm-Message-State: AC+VfDymILhjkd+3iMTYD2FtLy8Oh2D9v8z9p6n67GFu4uP5LqidnK2n
        3yKc+QVs9wxhTZIeq6iLbzEb+jkrO7EpKAQbMc4/3yqG
X-Google-Smtp-Source: ACHHUZ6WCeL1WswUXiw5OZObfUR2GH3jkieXKmxWiea2Wz3AWdZPKCxhnW+8QQsRaK7oumCqogf06pX1zjeYu7kPnfM=
X-Received: by 2002:a2e:95c2:0:b0:2a7:73a2:d915 with SMTP id
 y2-20020a2e95c2000000b002a773a2d915mr806605ljh.5.1682609615924; Thu, 27 Apr
 2023 08:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <878reeilxk.fsf@oracle.com> <733c57eb-1299-57ae-7aa5-a9dbd51f5559@meta.com>
 <87zg6ufnrr.fsf@oracle.com> <CAADnVQ+MNbWCWD14xf50nK-CsAdzQqsnY3x4uSuxO=pNDdmZXA@mail.gmail.com>
 <87o7n98wep.fsf@oracle.com>
In-Reply-To: <87o7n98wep.fsf@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 27 Apr 2023 08:33:24 -0700
Message-ID: <CAADnVQL9L99VeNZSDDLw_XTSNJhf7y6QKrRa8k7cpVFPP19NEQ@mail.gmail.com>
Subject: Re: Support for the pseudo-C BPF assembler syntax in GAS
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Cc:     Eddy Z <eddyz87@gmail.com>, Yonghong Song <yhs@meta.com>,
        bpf <bpf@vger.kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        gmartinezq07@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Apr 27, 2023 at 3:14=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> Odd.  I replied to this yesterday, but somehow it wasn't sent.
>
> > On Wed, Apr 26, 2023 at 12:35=E2=80=AFPM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >>
> >>
> >> > On 4/26/23 10:37 AM, Jose E. Marchesi wrote:
> >> >> Just a heads up, we just committed support for the assembly syntax
> >> >> used
> >> >> by clang to the GNU assembler [1].
> >> >
> >> > Thanks! Do you which gcc release is expected to contain these change=
s?
> >>
> >> This is the assembler, i.e. binutils.
> >> We don't need to update the compiler.
> >>
> >> >> Salud!
> >> >> [1] https://sourceware.org/pipermail/binutils/2023-April/127222.htm=
l
> >
> > This is awesome!
> > We recently converted tens of thousands of lines of bpf asm from macros
> > to inline asm in C.
> > See tools/testing/selftests/bpf/progs/verifier_*.c
> > I wonder how gas-bpf can deal with that.
>
> Inline assembly shall work.
>
> > We had to fix several inline asm issues in clang to get to this point
> > and probably more to come.
>
> We will give these tests a try and fix problems as we find them :)
>
> We actually came with some ambiguities, undefined stuff, and other
> issues with the syntax while doing the implementation.  We hope to
> discuss some of that during the LSF/MM/BPF next week, so we can
> consolidate the language in both toolchains.
>
> Speaking of which, we are preparing the material for the "compiled BPF"
> activity during LSF/MM/BPF.  I think the BPF track hasn't been scheduled
> yet, but how much time will we have to discuss about the topic?

Awesome. I'd love to participate.

Martin, Daniel,
What is the schedule for bpf track ?
