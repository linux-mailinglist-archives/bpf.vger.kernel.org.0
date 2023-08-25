Return-Path: <bpf+bounces-8680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E7788F05
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 20:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01871C20A8C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25EA18B0E;
	Fri, 25 Aug 2023 18:56:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C651CEEC1
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 18:56:32 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8922127
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:56:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so1917657a12.1
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692989790; x=1693594590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeKOojWSdoABZdi2XbAHnlS8XMk+72Yc73PFyKQg65o=;
        b=daCcoK128uwV23pTlP8wu+VtJ5SFdSdB9Tv6zPtM9xiGAkjpzL74ekrrLPq0DhzJN/
         e3R0foA9NGL2gB+o/GMxw9JB23d+GFspSMeRMcbJqwK6C/uIGmvt9VVXLF6ICrkrpA1q
         fpvNifOO627eDlbXiSwZmlPOX85NG05ea/i70pDMoKYBuBz7IoJ3K95HDE3gxhKbd9sb
         vETtSL/fSbp3SfW41nEJ5bD4a4Q5CSjg/ob/A1h+msjF2moJ+6fjH441/wnoXmpeks/Q
         6+P41Udh3yQJgd18EX0mhao1fqhtHD/FW+VUPh7ZCU0ytgTdHZd4fQGJj6eVqQVXN9fm
         MnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692989790; x=1693594590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeKOojWSdoABZdi2XbAHnlS8XMk+72Yc73PFyKQg65o=;
        b=UMFveq7oXZo5O+oGhHnIWf1fKL8H3SWzOzyP5omFE7eFFuyhxrhC2e/tj0jFo6+Yje
         Z4IDmrKmY2qTr8URVDZmzLgPRXe6/WlbD1R4ndkDDndVhmzr8Hc7OdoNIjXrpJK8ZBAb
         i6jWi7eNby8t20JAdHjXpzK4k5PM5YERhzAptGYlRFis200aQWCMFJnBdgaC61DiSN+t
         CCyI11ZMLpLoDn4S0e2Foh3tS148oy4SWw/qIQKx37K6Oe/37ngRk3EUaeYBb5oTAWjI
         sHgnlDCTVadGdh91ltIEiCTJjiMk2Q3KmxY7xD0YaN1dd9Do3/4fQ8egT7OFMB5zW+kl
         0RVQ==
X-Gm-Message-State: AOJu0YxdQAmZjbEUhpWxiXakw5DRrFrNfFTeEtOQ0pmiXOJKD8UimlDl
	PA/VI5X2xpul5QEc/BbWvtdurP3INgy0K4dJLlU0cgvx
X-Google-Smtp-Source: AGHT+IGe9XvmUfmsRNP29ic86XhT6YFQgrheQo8KODEcIrp2zwCUl+uxr7qduAJuyXoTxGnoxLcb15ToxB+DVsQRQyY=
X-Received: by 2002:a05:6402:b29:b0:523:4a4e:3b57 with SMTP id
 bo9-20020a0564020b2900b005234a4e3b57mr15494875edb.13.1692989789685; Fri, 25
 Aug 2023 11:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824201358.1395122-1-andrii@kernel.org> <CAPhsuW6Qw1xOXruC5E7WjxwdMom3BwyU_2NsAjSx7rmFb7e16g@mail.gmail.com>
In-Reply-To: <CAPhsuW6Qw1xOXruC5E7WjxwdMom3BwyU_2NsAjSx7rmFb7e16g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Aug 2023 11:56:18 -0700
Message-ID: <CAEf4BzZQutPNqMkzG7Q_F_TrzSHWOXfmOy38QXZGNDX3bAJX2Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: add basic BTF sanity validation
To: Song Liu <song@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 2:17=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Aug 24, 2023 at 1:14=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> [...]
> > +
> > +static int btf_validate_type(const struct btf *btf, const struct btf_t=
ype *t, __u32 id)
> > +{
> > +       __u32 kind =3D btf_kind(t);
> > +       int err, i, n;
> > +
> > +       err =3D btf_validate_str(btf, t->name_off, "type name", id);
> > +       if (err)
> > +               return err;
> > +
> > +       switch (kind) {
> > +       case BTF_KIND_UNKN:
> > +       case BTF_KIND_INT:
> > +       case BTF_KIND_FWD:
> > +       case BTF_KIND_FLOAT:
> > +               break;
> > +       case BTF_KIND_PTR:
> > +       case BTF_KIND_TYPEDEF:
> > +       case BTF_KIND_VOLATILE:
> > +       case BTF_KIND_CONST:
> > +       case BTF_KIND_RESTRICT:
> > +       case BTF_KIND_FUNC:
> > +       case BTF_KIND_VAR:
> > +       case BTF_KIND_DECL_TAG:
> > +       case BTF_KIND_TYPE_TAG:
> > +               err =3D btf_validate_id(btf, t->type, id);
> > +               if (err)
> > +                       return err;
>
> We can "return err;" at the end, and then remove all these "if (err)
> return err;", right?

in some places, yes, but not where we have loops. And in general I
find it harder to follow. Keeping each case branch more self-contained
seems better, personally. I'd prefer to keep it.

>
> Thanks,
> Song
>
> > +               break;
> > +       case BTF_KIND_ARRAY: {
> > +               const struct btf_array *a =3D btf_array(t);
> > +
> > +               err =3D btf_validate_id(btf, a->type, id);
> > +               err =3D err ?: btf_validate_id(btf, a->index_type, id);
> > +               if (err)
> > +                       return err;
> > +               break;
> > +       }
> > +       case BTF_KIND_STRUCT:
> > +       case BTF_KIND_UNION: {
> > +               const struct btf_member *m =3D btf_members(t);
> > +
> > +               n =3D btf_vlen(t);
> > +               for (i =3D 0; i < n; i++, m++) {
> > +                       err =3D btf_validate_str(btf, m->name_off, "fie=
ld name", id);
> > +                       err =3D err ?: btf_validate_id(btf, m->type, id=
);
> > +                       if (err)
> > +                               return err;
> > +               }
> > +               break;
> > +       }
> > +       case BTF_KIND_ENUM: {
> > +               const struct btf_enum *m =3D btf_enum(t);
> > +
> > +               n =3D btf_vlen(t);
> > +               for (i =3D 0; i < n; i++, m++) {
> > +                       err =3D btf_validate_str(btf, m->name_off, "enu=
m name", id);
> > +                       if (err)
> > +                               return err;
> > +               }
> > +               break;
> > +       }
> > +       case BTF_KIND_ENUM64: {
> > +               const struct btf_enum64 *m =3D btf_enum64(t);
> > +
> > +               n =3D btf_vlen(t);
> > +               for (i =3D 0; i < n; i++, m++) {
> > +                       err =3D btf_validate_str(btf, m->name_off, "enu=
m name", id);
> > +                       if (err)
> > +                               return err;
> > +               }
> > +               break;
> > +       }
> > +       case BTF_KIND_FUNC_PROTO: {
> > +               const struct btf_param *m =3D btf_params(t);
> > +
> > +               n =3D btf_vlen(t);
> > +               for (i =3D 0; i < n; i++, m++) {
> > +                       err =3D btf_validate_str(btf, m->name_off, "par=
am name", id);
> > +                       err =3D err ?: btf_validate_id(btf, m->type, id=
);
> > +                       if (err)
> > +                               return err;
> > +               }
> > +               break;
> > +       }
> > +       case BTF_KIND_DATASEC: {
> > +               const struct btf_var_secinfo *m =3D btf_var_secinfos(t)=
;
> > +
> > +               n =3D btf_vlen(t);
> > +               for (i =3D 0; i < n; i++, m++) {
> > +                       err =3D btf_validate_id(btf, m->type, id);
> > +                       if (err)
> > +                               return err;
> > +               }
> > +               break;
> > +       }
> > +       default:
> > +               pr_warn("btf: type [%u]: unrecognized kind %u\n", id, k=
ind);
> > +               return -EINVAL;
> > +       }
> > +       return 0;
> > +}
> [...]

