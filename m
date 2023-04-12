Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB96E01CB
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 00:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjDLW0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 18:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLW0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 18:26:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28C7212C
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 15:26:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id si1so2476311ejb.10
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681338400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Cnjj80dvd92KOMXWb4U/rYM+psan76b/o+EWDfJ8yA=;
        b=IX0tywbQj9cLuJEP6LbwfWrnmrbAcOgK9VoIImdvBy+/9m02H60Z6i7ZCLLX6gJ47p
         NlXeyyT+ggizkemhtGD1patFZIcyOVPcauPROtRGZxTjLqNh/JhivMlwY0WpgXxvYnvt
         lP66MX+3fT+bOicR058AviDi1+czZiExiPGfnDe07oh1lgWOQ/gVFea80kYNxijB21Lr
         pAeDkbOT5z2Sc4HtBK5wzy75uP1stoW/UpnWVFJ7yxUAVy66o+2PdUsNZcbBQHQ/rN8h
         d1kRGkeqaF8FYXm6rJYuGW3ohffN+EeyCfk3qeSPnULWyB/iDtp/2QaTDNf89ftwLlhz
         yLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681338400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Cnjj80dvd92KOMXWb4U/rYM+psan76b/o+EWDfJ8yA=;
        b=FY4IxpW1U3E3bjlx0+kqXhq9UaZmpHrgg+kCE14LIWeL+cwHl0HgT10qroHFcnAFl/
         h2RqK+qQr0O1ecZmE9Ozhd3EF2OTu0rg6JC2m3fH5sdYLYrUEfC9vWQqa1JsDaeYNT3V
         x8K1wE/rYPv5lhRFe8GhfvDseLus/xomH7v60wMk+1PyWa2OagwLNN+i6Y7NR1uw8Qyd
         QGXBe6GnxYv4w9i0vgO3Ei9HDqw9SK5xj0wBWrvFdhiEAyy4EzBQyDvt8d1dJ0jPuzX4
         FW8ZGI27whzZ351/25Pbi5hwRTB0EiJQ4T1mxbFHLvhPRWcHw7ZVtRWbIj4V4NLZURHW
         qa6A==
X-Gm-Message-State: AAQBX9fJ1FRMPhurCOmNIp2Uu3EWWle9gaUcIYWtXYOxuM9BBPr3n+8/
        Wz62MuFO27UE4hsfyqI/bPrmJAwEelVP/0qGnoH+pxYEvGY=
X-Google-Smtp-Source: AKy350YjdzHTTP4/ah0RZ4g/7YR09CVLTtwzgcRkVoJZx1Tj+SpTr0saigFCvrezOocRQ2tTN5DEJEbr1vMcvZo5GdM=
X-Received: by 2002:a17:906:8403:b0:931:fb3c:f88d with SMTP id
 n3-20020a170906840300b00931fb3cf88dmr236991ejx.5.1681338400113; Wed, 12 Apr
 2023 15:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <1d286b16-4d57-d667-e62c-00d6cb0d956d@google.com>
 <CAEf4BzY8QnPqv7Sn0RYkf4exfQ_dEHtHejLkHJyx2swq4LAs4w@mail.gmail.com> <b4cb3423-b18d-8fad-7355-d8aa66ccfe4c@google.com>
In-Reply-To: <b4cb3423-b18d-8fad-7355-d8aa66ccfe4c@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 15:26:28 -0700
Message-ID: <CAEf4Bzbu-nH8F9eRLsoN89_=s3mLvs1gjLcNRr3_ctfb5MNaMg@mail.gmail.com>
Subject: Re: inline ASM helpers for proving bounds checks
To:     Barret Rhoden <brho@google.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 10, 2023 at 10:46=E2=80=AFAM Barret Rhoden <brho@google.com> wr=
ote:
>
> On 3/28/23 17:32, Andrii Nakryiko wrote:
> > This one looks pretty useful and common (especially to work around
> > Clang's smartness). I have related set of helpers waiting it's time,
> > see [0]. I'd say we should think about some good naming of them,
> > document them properly (including various gotchas), and include them
> > (initially) in bpf_misc.h and start using them in selftests.
>
> sounds good to me.
>
> any preference for a name?  bpf_index_array()?
> - no need to say "bounded".
> - want to begin with bpf_.
> - sticking with your clamp style, "index" would be the verb.  (instead
> of e.g. bpf_array_index, which sounds like it has something to do with a
> BPF array".
>
> i'm up for anything though.  =3D)

bpf_index_array()/bpf_access_array() might be ok. But perhaps a bit
more natural in the code will be bpf_array_elem(), as it's actually an
accessor/expression, not really a stand-alone statement:

struct my_elem *elem =3D bpf_array_elem(arr, n);
if (!elem)
    return 0;
elem->field =3D <blah>;

WDYT?

Let's also maybe improve usability by inferring array size? I've seen
somewhere in kernel code a macro that validates that passed in arr is
actually an array (and not a pointer), it would be useful to use
similar approach here to make sure we determine size correctly. See
what ARRAY_SIZE() in the kernel does.

>
> > yeah, I'm hesitant about this one. It is very similar to
> > bpf_clam_xxx() macros I referenced above, probably we should use those
> > instead.
>
> totally agree.  i can switch my stuff to use the clamp, which covers all
> of the use cases/signedness.  btw, good to know the "s<" is
> signed-less-than.  i imagine i'd have had trouble with that.  =3D)

you are welcome :)

>
> thanks,
>
> barret
>
>
