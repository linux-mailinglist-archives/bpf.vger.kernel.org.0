Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473C66D339A
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 21:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjDATgK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjDATgJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 15:36:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB07ED5
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 12:36:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ek18so102632511edb.6
        for <bpf@vger.kernel.org>; Sat, 01 Apr 2023 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680377767; x=1682969767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzmxJo/r9BjRwhnglbRn5alreIwgojI6NzGHs6GYT+U=;
        b=XpvTtGtn89hi+o8qtjtijPikjsxXdEPlJBEHTmGxEP396+m8QGZN+SACWn6a97DmpZ
         OVryKx+ZXHAIJ69ucPcMMqlTgwBZqq58hwamdPvbHzcUSPC4TuscWnBz7pX8RoEg2lW0
         3LAYC8hOkj6i96GufUIE+EHV0Lsb4vLNeNw1lcN0lRnRpf5P/p+3mGSoyyXuz8oaOKJ9
         LUR02dJlAQT9fajWapI9G+JEn2vZ2FoPUWMsA+DdTwFcoG9autZH/JEs12TKT1f7zCAi
         hZs1DTrtuXA48U6gVWVVFGOCn+Y2YmzoeT5arTPTuwpoDs+x7SUZowZ1hrgIpJgl3XCE
         6vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680377767; x=1682969767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzmxJo/r9BjRwhnglbRn5alreIwgojI6NzGHs6GYT+U=;
        b=y+tGQJ6xYUKTFh3eQddd6uSIlEVMFXcYwJ9Q6pqhu+Yh8ISOn18RmQdDEeAVMb9nmx
         kPUtTMM6rR1LRT2AvH6JztpRMCl2uJ6s2vih45z/Por37kWLuBL7hHWeC3bRCj23+Qft
         QNsRhEPHHCLfD3kN53CJ3CscCMLIDw4A/znZQtpQUsYlbQa81DBr3iwVg1HRPd1yjita
         6mD/u/lTP2jgSYE6lkA6+cMD3AsnjfgSs681KirzVanAf0RK2HzFGbXIlmdtIvk1ODgC
         ejnkXMmDRiTzJ0kSPOW4J2GfOAENwKX4v1D6GCUs1DQ1U4Pl+zghoBzyiEqGlOr+dG/e
         XRwg==
X-Gm-Message-State: AAQBX9dJ8y36JdPlbVRpjFICb3KpN7j0PPbKoGlUinU8nAjd/fKPpzsp
        vipSWQ0Aahy5QTuoUUBwBLJ+6Cokf/ie9wernvQ=
X-Google-Smtp-Source: AKy350a1AtvZcdJOov3FSooykUEtTnR5SOujdaggONBOyIcxQYhQTjymMhg6p1mK/D5PWb4lY+dv3pnp74gAKeynOyk=
X-Received: by 2002:a17:906:5584:b0:93a:6e4d:e772 with SMTP id
 y4-20020a170906558400b0093a6e4de772mr8234676ejp.7.1680377766854; Sat, 01 Apr
 2023 12:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230401101050.358342-1-aspsk@isovalent.com> <20230401162003.kkkx7ynlu7a2msn6@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <ZCiFONQVTvRia3nY@zh-lab-node-5>
In-Reply-To: <ZCiFONQVTvRia3nY@zh-lab-node-5>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 1 Apr 2023 12:35:55 -0700
Message-ID: <CAADnVQK9n2yhC9GGFCwHbVHQB_0kq5M7TLyoGZq5MQFsw92xyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: optimize hashmap lookups when key_size is
 divisible by 4
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
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

On Sat, Apr 1, 2023 at 12:24=E2=80=AFPM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
> > > -static inline u32 htab_map_hash(const void *key, u32 key_len, u32 ha=
shrnd)
> > > +static inline u32 htab_map_hash(const struct bpf_htab *htab, const v=
oid *key, u32 key_len)
> > >  {
> > > -   return jhash(key, key_len, hashrnd);
> > > +   if (likely(htab->key_size_u32))
> > > +           return jhash2(key, htab->key_size_u32, htab->hashrnd);
> > > +   return jhash(key, key_len, htab->hashrnd);
> >
> > Could you measure the speed when &3 and /4 is done in the hot path ?
> > I would expect the performance to be the same or faster,
> > since extra load is gone.
>
> I don't see any visible difference (I've tested "&3 and /4" and "%4=3D=3D=
0 and /4"
> variants).

I bet compiler generates the same code for these two variants.
% is optimized into &.
/ is optimized into >>.

> Do you still prefer division in favor of using htab->key_size_u32?

yes, because it's a shift.
