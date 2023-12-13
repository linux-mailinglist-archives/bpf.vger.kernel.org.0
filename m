Return-Path: <bpf+bounces-17639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FED810801
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 03:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D581282457
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 02:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BEB10EA;
	Wed, 13 Dec 2023 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/R/JS8z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693B8CD;
	Tue, 12 Dec 2023 18:11:49 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-5c85e8fdd2dso62594137b3.2;
        Tue, 12 Dec 2023 18:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702433508; x=1703038308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjrnQeaFObARf6rt/zsrrtTxUbhD/ynal+Up2fZC/58=;
        b=f/R/JS8z5Tg5/my9XH70L3izyHbk5vk3FS1jmCqlHmM2DwWNODb3Tq4ZIww7UW4thY
         fhnkz7qfL5p9XbkT70WEwAWR+5V9hHzfPiD29my7bQH/sGor26vKuQC+RItKT4KS9UM+
         us7L2NVLRsvhFG7YH/UuVg+qcvYBB3VfrtGI4DwCJw0BqCSe3HKIvrTSCOLzHwXE3EDc
         rd9ktstl+PomEBK70NI7cI9Mv8IfFiTqper8QBL/xM831sWgnl5g0HfVTECTJhGs7g9F
         YGxoa27jHatb6DUxdjhk2BjSHDdrHDLNNWcMtEaitu8ZdFEFpLeWVDqCk7OzL9jtELoH
         pw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702433508; x=1703038308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjrnQeaFObARf6rt/zsrrtTxUbhD/ynal+Up2fZC/58=;
        b=h5lZHY22oNkJJLMtiW6rlLfadRqV4wiuO79/wqt+PPc7EV0js6cLMTyVO3KFkHg24p
         ntDureyg7nfVKxrRnCV674PtDSCYy3/EuBzWRzEg2vadWwhqiRVGFUOPZO7Igpb9dPyE
         prhWj8/HM7rQPEholRQP4Ax9QxTug2wWuryB/f5ODenaZ4xDRao3skMlA4xDUV398mKr
         8yS0YA9SwcEEKzzV8dvY7sYHxIW3ZPG8iVOw6oGiEVnmrttoBhDBPGmuE5+YS+rgDpqY
         dkpi9FrsSVbHyQgvhnSW1ZUw2MC3APAgySxIwKaSwRcIfhK21XAeVkf75M0AsFxm+4m9
         qONg==
X-Gm-Message-State: AOJu0YxSz4C7lXyTEuIGC79Au1tqzBGYtkdd2vmWq/rFZXt4g6rfZYel
	S5na78jbcrJMvJF089bRd/uaF7gPlMQn/+WwGTY=
X-Google-Smtp-Source: AGHT+IHOWJSSwQ+pQAnYQEZZ/JkGrpS93hgBLF+xROV7nHJqz+dnzeze5BT3T5f1/YMcga8FUF+24enD3fZFe9pmJdY=
X-Received: by 2002:a0d:d8d6:0:b0:5e2:cfac:6492 with SMTP id
 a205-20020a0dd8d6000000b005e2cfac6492mr58513ywe.41.1702433508532; Tue, 12 Dec
 2023 18:11:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212131031.3088661-1-menglong8.dong@gmail.com>
 <20231212131031.3088661-2-menglong8.dong@gmail.com> <a7fa57335aa302898044207431e81f5f455e4971.camel@gmail.com>
In-Reply-To: <a7fa57335aa302898044207431e81f5f455e4971.camel@gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 13 Dec 2023 10:11:37 +0800
Message-ID: <CADxym3a357bCbUgMgocv2ywHb9ZKEmNT3j3ico7AXWZD3r99kQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] bpf: make the verifier trace the "not
 qeual" for regs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, yonghong.song@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 7:23=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-12-12 at 21:10 +0800, Menglong Dong wrote:
> > We can derive some new information for BPF_JNE in regs_refine_cond_op()=
.
> > Take following code for example:
> >
> >   /* The type of "a" is u16 */
> >   if (a > 0 && a < 100) {
> >     /* the range of the register for a is [0, 99], not [1, 99],
> >      * and will cause the following error:
> >      *
> >      *   invalid zero-sized read
> >      *
> >      * as a can be 0.
> >      */
> >     bpf_skb_store_bytes(skb, xx, xx, a, 0);
> >   }
> >
> > In the code above, "a > 0" will be compiled to "jmp xxx if a =3D=3D 0".=
 In the
> > TRUE branch, the dst_reg will be marked as known to 0. However, in the
> > fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> > the [min, max] for a is [0, 99], not [1, 99].
> >
> > For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
> > const and is exactly the edge of the dst reg.
> >
> > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> >  kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 727a59e4a647..08ee0e02df96 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14332,7 +14332,34 @@ static void regs_refine_cond_op(struct bpf_reg=
_state *reg1, struct bpf_reg_state
> >               }
> >               break;
> >       case BPF_JNE:
> > -             /* we don't derive any new information for inequality yet=
 */
> > +             if (!is_reg_const(reg2, is_jmp32))
> > +                     swap(reg1, reg2);
> > +             if (!is_reg_const(reg2, is_jmp32))
> > +                     break;
> > +
> > +             /* try to recompute the bound of reg1 if reg2 is a const =
and
> > +              * is exactly the edge of reg1.
> > +              */
> > +             val =3D reg_const_value(reg2, is_jmp32);
> > +             if (is_jmp32) {
> > +                     if (reg1->u32_min_value =3D=3D (u32)val)
> > +                             reg1->u32_min_value++;
>
> Nit: I spent an unreasonable amount of time trying to figure out if
>      overflow might be an issue here. Would it be helpful to add a
>      comment like below? (not sure, maybe it's obvious and I'm being slow=
)
>
>      /* u32_min_value is not equal to 0xffffffff at this point,
>       * because otherwise u32_max_value is 0xffffffff as well,
>       * in such a case both reg1 and reg2 would be constants,
>       * jump would be predicted and reg_set_min_max() won't
>       * be called.
>       * Same reasoning works for all {u,s}{min,max}{32,64} cases below.
>       */

Okay, I'll add this comment in the next version.

Thanks!
Menglong Dong

