Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B186D1043
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjC3Uso (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 16:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjC3Usn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 16:48:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972A749CF
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 13:48:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg48so81503121edb.13
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680209321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhrWM7/0mhSIoGpKaP2thPNAHf+V2KbiVvLWrUFNtgs=;
        b=fQYQDbj1RKTAmHZ09O9hOdMIKbLO86sCGUEDvHS5ezgSfYX69wzy2Akb2piXbdR7ik
         W6nb/xK+fl8l2GPCVbFhsyNofgYDw8/mdiFjAovLlV86OXdlUQcWDTvFu6dx1gyyRd4N
         HJ2oiPXxqr9/+Dg5o8/4QJuzwzprWnsj9bRUTsJD0P4sa34+ot+Y4Jp9fzKta+KiEPkd
         RGV0XCnWLjgvzPyImQGG33gUhxVRcxDOGB/ooXSDF0uxibKEl2mtMNqERtFS7DLkltzg
         HfHfJkQ+Fp3C7LdGIJrLxXPiURl3gNrVeXWwdqDFu+P3VUnJ8b2f2pGdzPf/5ApGU5J4
         zW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680209321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhrWM7/0mhSIoGpKaP2thPNAHf+V2KbiVvLWrUFNtgs=;
        b=Hwb1ERldnorv0zNDhNSn3wj52hKfN091bbQ7qGK8vpI4daXowpMNXsSsBouEl5FsKH
         k8m8BLOV2aw2WtmOdUyopq4v1eDC5Z8nF6+W/0FoOAe6ULF0Nt1ElTaq6tNUB6Jp0WtJ
         HL7+j/3ZLcdClW5uj1pfsM9+8bAP9ri7iGrYgTxaBWISMoVQyLfzRyzEZxKPLnthpQru
         o3hMdtdZ9Fhx3GsMDp9kVmzeABzJKzZyj7Zqw/wzR8v3n+wUv+nwG0HP5/i4lbyDSZ7X
         WgYMOTgWqjW+QOen8aXJnrI8CqnWYa44VJGQX0Nzacfr+4JKOJXpKJZ1ww+xloYaot6J
         tZ9Q==
X-Gm-Message-State: AAQBX9fOfrppEuVR6C23rfKBq22xpO1QYU9MKlscxf59o3+RN4msRzrG
        FfCWtzy3df+hVJzwmdfd2BBs6bJNS69I4fx0joXjrUc1
X-Google-Smtp-Source: AKy350brauqJjoxiRK6e3t4Tes3WbFkUC4P7ywtkWHKQSmMoBkzYyKq09onwAXrw/4VNGVLvd/HI/lIHpb7Qz4GtlHg=
X-Received: by 2002:a17:906:6692:b0:944:70f7:6fae with SMTP id
 z18-20020a170906669200b0094470f76faemr7668530ejo.5.1680209320998; Thu, 30 Mar
 2023 13:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-3-andrii@kernel.org>
 <CAN+4W8gsHdFd8BgjyndvpabZ-m3tNohU8LhQwT=yv+wi6NKvXw@mail.gmail.com>
In-Reply-To: <CAN+4W8gsHdFd8BgjyndvpabZ-m3tNohU8LhQwT=yv+wi6NKvXw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 30 Mar 2023 13:48:28 -0700
Message-ID: <CAEf4Bzby+VbdRBV8pcBVwDodot0xiJOKhX-hCBfvtKMFGHEiAg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: remove minimum size restrictions on
 verifier log buffer
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

On Thu, Mar 30, 2023 at 10:12=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> w=
rote:
>
> On Wed, Mar 29, 2023 at 12:56=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > It's not clear why we have 128 as minimum size, but it makes testing
> > harder and seems unnecessary, as we carefully handle truncation
> > scenarios and use proper snprintf variants. So remove this limitation
> > and just enfore positive length for log buffer.
>
> Nit: enforce

life is boring without typos, will fix in the next revision (if there
has to be another one) :)

>
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Lorenz Bauer <lmb@isovalent.com>
>
> > ---
> >  kernel/bpf/log.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> > index 920061e38d2e..1974891fc324 100644
> > --- a/kernel/bpf/log.c
> > +++ b/kernel/bpf/log.c
> > @@ -11,7 +11,7 @@
> >
> >  bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
> >  {
> > -       return log->len_total >=3D 128 && log->len_total <=3D UINT_MAX =
>> 2 &&
> > +       return log->len_total > 0 && log->len_total <=3D UINT_MAX >> 2 =
&&
> >                log->level && log->ubuf && !(log->level & ~BPF_LOG_MASK)=
;
>
> Probably discussion for your second series. Thought experiment, could
> this be len_total >=3D 0? I'm still after a way to get the correct log
> buffer size from the first PROG_LOAD call. If the kernel could handle
> this I could mmap a PROT_NONE page, set len_total to 0 and later read
> out the correct buffer size.
>
> I'm guessing that the null termination logic would have to be
> adjusted, anything else though?

I haven't tried, but I'll check if anything needs to be adjusted. But
I don't mind this semantics, it matches other places, like when
getting JIT dump for program info, etc.
