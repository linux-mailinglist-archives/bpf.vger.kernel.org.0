Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F286081E1
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 00:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJUW5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 18:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJUW5O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 18:57:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F023F2A26C
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:57:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u21so11133749edi.9
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0zf4yevNvbwit9xvuDF8S3u9oaDd9w5sxKfreV+fDk=;
        b=oo+giOI4o/XyUPE125LWtrMMLawADyTI+0IbB7ffSZJC5QbQJg4+eX5mj374iphHzH
         dknSSXbxJCtYu9do6eJdGBPR5vRq/fIyRoXRZAvbeUtmqqnXkXVFDUxciTuZx4WH54Sj
         7ZU3lC5jynlWwBfTJ1SnXKx+YZQ/OCBZxJ0GLviDUhSi5qLWULZmx+o28qb9n5dcxF0A
         QYn0dpk0DbEdXM67EhKIo277WkLqqR8BaFdMUJbYCePV7kUzYCNWG8DX3WuXiXC0f65n
         u6492GWa+YJ4ArBdRuGGoSwPFt7A1d4z/zpaXMBtVItyX4J0W+WHiJxjCHKuw1emlOnX
         yvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0zf4yevNvbwit9xvuDF8S3u9oaDd9w5sxKfreV+fDk=;
        b=wWyaobC1j1rSPX45m6l0//e/S+QE0bFP1HT8rCBSdU1o41uMkhosWGKwBCiXW9Z7qR
         K+ESH8eFlc+mEE22Q48yYWw85a+jB3XccxdX7JmVZIzpg3MR+uNxnPgrotOYOUwQ/W7A
         l7V00hbIM4OJea6wyzP2ryoMUft983plBeVDyC02/xX8c3Etp4Ne9VBTsjq4CFqAxrlj
         QDZX+Diu5FTR92EFkiEXa+59iD0F1jZyZ1uY3R+cs11/OD51s1RfJ/zOm1Qck3wWpBa/
         NznvuOWEpDxB/ewf9h84b4FlD/PG7KG8WxR2VVuB0JjbARKodGpL+YAJw0kZbrAY7sYx
         GPAQ==
X-Gm-Message-State: ACrzQf0QCcInxDG5bOx/Po52LamoJYCVDSZuxJRraWiP6Vg/2jHV0ys6
        6gWLhhPhrynYcBcJtTV8EHFRi3YICo3d21o7ews=
X-Google-Smtp-Source: AMsMyM7NZ4gptJri2s5/KuwXY1R2bq2ekh8onK4hHuetj2VMfHBn8jX0vUixoDLsv/DxS/TSzGSjeGKeIebrRwUU10w=
X-Received: by 2002:a17:907:a43:b0:77b:ba98:d2f with SMTP id
 be3-20020a1709070a4300b0077bba980d2fmr17951092ejc.270.1666393032613; Fri, 21
 Oct 2022 15:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-8-memxor@gmail.com>
 <CAJnrk1Y_zn+oR3pN8bd3tHV2VubFxBc00XhcNzaWzHkSn1-UMw@mail.gmail.com>
In-Reply-To: <CAJnrk1Y_zn+oR3pN8bd3tHV2VubFxBc00XhcNzaWzHkSn1-UMw@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 21 Oct 2022 15:57:01 -0700
Message-ID: <CAJnrk1Z6cNcMWwSb3ddGwh5+ax9ONR8R+vcEwSZzwfGKPPZtgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/13] bpf: Fix partial dynptr stack slot reads/writes
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]
>
> > +                       /* raw_mode may write past allocated_stack */
> > +                       if (state->allocated_stack <= slot)
> > +                               continue;
>
> break?

nvm, i think this should stay "continue".

>
> > +                       if (state->stack[spi].slot_type[slot % BPF_REG_SIZE] == STACK_DYNPTR) {
> > +                               verbose(env, "potential write to dynptr at off=%d disallowed\n", i);
> > +                               return -EACCES;
> > +                       }
> > +               }
> >                 meta->access_size = access_size;
> >                 meta->regno = regno;
> >                 return 0;
> > --
> > 2.38.0
> >
