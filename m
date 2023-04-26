Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74DF6EFB86
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 22:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjDZUFt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 16:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZUFs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 16:05:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E0911F
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 13:05:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f001a2f3aeso2301497e87.2
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682539545; x=1685131545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17+DYKsD8bi3orx1zxtT95mx8tlw+YOA+b0xk1PXOKc=;
        b=EWzOJoA7byjjLV/4DlU3V5E03BnqOCqFrcxpD61Iqs11cJpOyTy9kWYvUXWZdddEaJ
         fVEePo3DpX9wt3vO7pFHyLWjXYHhkQXOf5J7JP3hnlGvkzrarPqOPklmHLy1GB0cpxJ+
         liHL7MX2jCiOkBi5MAQY6YGpggFAgiuxfW7uqEyNI1b4tdMXLuoK+uARo2cFfmxYEu2U
         DGLwNkVw1vCU4ruHCErEQMnCYkGRrebygDhoNhSyqy3nWGCLoALl3ZuRX75Bb4wEnl07
         ASnUJ1Tl0rUfnr1/0Bt42P3s5o7qCB9T+ihwhj/KJRaN+tznBNTBlAm2gSWGH4QxGtXD
         kCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682539545; x=1685131545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17+DYKsD8bi3orx1zxtT95mx8tlw+YOA+b0xk1PXOKc=;
        b=ckzF/7PfXWt8F2u6Xky2MlWQ6FXcsulKLYVED80m9E8nkqe5qkP01w19WQ39MVXtYN
         AgraPge6bVEOYR7jl6dx6EDMayuzW4TsuEPduuMFx9YWc/pPhraeLC5C9BX7lf+po9U7
         b2qvULThjw4wkjD+h/gIhSBxTXustFFPZowaUtd3d8+WyT43vIl3jyyNQvMSdHK+j7ZY
         HDUyuljH4u+l5zP8WDxhQkiFed+WoCZCOFv7wb7tv93oHyd1QEK3M36G+qTDFroQ9TBr
         WYLjwP7n3v1mA5XuVSwJOQeTOpsEom/8v9yI0AgGYfDacuaELA5CdgzBqXOJtHAUharm
         8epw==
X-Gm-Message-State: AAQBX9eXCZXeUe1UkXTruMcqVsZ/Gtnprx+xHZhdA9j6HHx/bZwDW7p8
        8cFf0+OBoWIFfXqpwTR6ypaG8KUY9veqCn6s1Wc=
X-Google-Smtp-Source: AKy350ZWw5Cm2AKT1P6oLpDPvoMPrOnujsbwspP83OR+EFY4dgu0JicuLVV2+tewyUFgSODIVox3+iLIT/Ox5zAS1pc=
X-Received: by 2002:a05:6512:4c1:b0:4e1:36a:eda5 with SMTP id
 w1-20020a05651204c100b004e1036aeda5mr5512435lfq.30.1682539544314; Wed, 26 Apr
 2023 13:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <878reeilxk.fsf@oracle.com> <733c57eb-1299-57ae-7aa5-a9dbd51f5559@meta.com>
 <87zg6ufnrr.fsf@oracle.com>
In-Reply-To: <87zg6ufnrr.fsf@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 Apr 2023 13:05:32 -0700
Message-ID: <CAADnVQ+MNbWCWD14xf50nK-CsAdzQqsnY3x4uSuxO=pNDdmZXA@mail.gmail.com>
Subject: Re: Support for the pseudo-C BPF assembler syntax in GAS
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Eddy Z <eddyz87@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        gmartinezq07@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 12:35=E2=80=AFPM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On 4/26/23 10:37 AM, Jose E. Marchesi wrote:
> >> Just a heads up, we just committed support for the assembly syntax
> >> used
> >> by clang to the GNU assembler [1].
> >
> > Thanks! Do you which gcc release is expected to contain these changes?
>
> This is the assembler, i.e. binutils.
> We don't need to update the compiler.
>
> >> Salud!
> >> [1] https://sourceware.org/pipermail/binutils/2023-April/127222.html

This is awesome!
We recently converted tens of thousands of lines of bpf asm from macros
to inline asm in C.
See tools/testing/selftests/bpf/progs/verifier_*.c
I wonder how gas-bpf can deal with that.
We had to fix several inline asm issues in clang to get to this point
and probably more to come.
