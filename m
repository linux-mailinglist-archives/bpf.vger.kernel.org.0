Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0C6D9FEE
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbjDFSfk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 14:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbjDFSfj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 14:35:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4982F1BC0
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 11:35:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id cw23so3606886ejb.12
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680806137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utq+2qmkfoUSA1bEPKcWGMgnQd+/g5knYJTdk3kj6v0=;
        b=RJW1FLUXIJbKFj9FCO1kE+u0vIXt8iKP0wRxmHanybYJ52FGFunpf91j3FM+NnGMzf
         eaIqY+6eCv4CkO3TjarPVi2rixdZaPzQcZDN4k8tyn8eSQdLYHdwPPWHh8jhXL14eKLt
         jbgu0PQU1TzRpQWq/wPfF23ewEH/CE9Muv14CUkbCM0p7ovaTBReiBQWRxqQI2IcyWOU
         gD9hjy42lbOSFT1ZeRQ1TckMGxoGGG/olo0uFpVwCho7S4DWPZLUTQWTiLIW6eqMpek9
         XlQitqSWy0cnrfafQkph1oJwAM9z8HeHEcNdDLscRm56GGwEON0mIfYmQbuTSY+aA2y7
         xLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utq+2qmkfoUSA1bEPKcWGMgnQd+/g5knYJTdk3kj6v0=;
        b=u7lEI0IcyLdBAUfgTuSEpma2fNUqccWykral8XI4qiUDdHnxY1W39Vz1FuXMXVzfy2
         x+t6anYvJZl8GjQUkVDqPNFb4r44568gu49H88w2du0jZfrA1rfOBRHHxOlc/rQ56MTS
         1BKZwVvXeUQVytNXwlNHv5XNRKA7RRC3oHEqFjE60HXO/1Upvxd3E9KXLcn9xU3W2BsQ
         dMOY3ENjgsFS2PNAOhu2BHxIVxAkuwChfpZvGNzKTWDrhOB2XglqHuiOecmRtd2SDceu
         YLaCwBXvFtzku0DHeurVAMlyBxR4DLM4SUv22+sVEmEiXTXXv8aceGEXb683ejA0Y6w2
         FGNw==
X-Gm-Message-State: AAQBX9ePDb/b1CusACVWHbor6Yl464l+BrRIWSK+dl5vmzCrU3pvciAz
        nA4PEQF93VQXCU+rFxDtZhnvFx0DDrINwQXSzwif36Fk
X-Google-Smtp-Source: AKy350YGIaL00+bbNjqDGixDG+45hr+fkdyQ0OA7wuuqtrWXMvgCeF7Nn8oZQYmH1/76i4Nl43gYMm5jMW9HoXeWcWc=
X-Received: by 2002:a17:906:9488:b0:931:ce20:db96 with SMTP id
 t8-20020a170906948800b00931ce20db96mr3835393ejx.5.1680806136686; Thu, 06 Apr
 2023 11:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-13-andrii@kernel.org>
 <CAN+4W8gtHrWt_XQBTSvkMxmeuLT4hcUtYMaFRdeZfKyJ_s2QJA@mail.gmail.com>
 <CAEf4BzaKwrLhyk-Hon9Hi4aZhVrnU-OS-7-jHdd9uMzUnjRKZA@mail.gmail.com> <CAN+4W8jp=G-WaNxUaXAmwi8ofH+GxuW=7_3iMfueF+SDi9U=Nw@mail.gmail.com>
In-Reply-To: <CAN+4W8jp=G-WaNxUaXAmwi8ofH+GxuW=7_3iMfueF+SDi9U=Nw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 11:35:24 -0700
Message-ID: <CAEf4BzZZsqo5T+S9g9ZV0QpMC_L_kagrS7vTSOMdCpb+Oe9GEg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 12/19] bpf: add log_size_actual output field
 to return log contents size
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 6, 2023 at 9:09=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wro=
te:
>
> On Wed, Apr 5, 2023 at 6:40=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > > Can we check that both fields are zero when entering the syscall?
> >
> > Yep, it already happens and is done by generic
> > bpf_check_uarg_tail_zero() check in __sys_bpf.
>
> I thought that check only happens if expected_size > actual_size? I'm
> thinking of the actual_size =3D=3D expected_size case, what prevents user
> space from setting log_size_actual to a non-zero value?

ah, in that sense... What's the reasoning for this enforcement? I'm
just afraid that it will complicate applications that don't care and
are not aware of this field and do retries with the same attribute. On
first try, the kernel fills out log_true_size, application retries and
doesn't clear log_true_size (because it was written a while ago, but
compiled against latest kernel UAPI, so passes sizeof(union bpf_attr)
that includes new field). And that suddenly starts failing with
-EINVAL.

Seems like an unfortunate side effect, no? What's the harm in not
validating this field, if it's an output-only parameter?
