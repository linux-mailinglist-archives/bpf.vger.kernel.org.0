Return-Path: <bpf+bounces-1256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6A3711AC2
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 01:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDD91C20F51
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 23:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA32261D3;
	Thu, 25 May 2023 23:40:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F887261C5
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 23:40:13 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AD8198
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 16:40:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-514454733b8so102610a12.3
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 16:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685058004; x=1687650004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZqxFbYQtuuRokHh2K7bgl6vBkPQw4ujlMDLOEiaqJU=;
        b=NBqp+xB11a8Pt6i+zYhmVOuPfG9ZUTpHirXClO1Y+GV2TyT6ZSA15VKS+rJFX2W7UX
         etDp8J3LBqtmYxkmqZQDiJGDv1YkiTXCV+X8Cd2emNW2JVqQsM+DLbJkh6mgWORJo5q3
         oPz+9ovjifgp8s15/F7jYpnbottXzwdmk7rBu9gpy+WtqwthVnN0RcDD7Pxvcb5IJgcQ
         TW+a+OhGMNZaLiOqo4LtbqXTsfFASKweB3J6voZccygVbkxeT/h6ONOeka8zcuMNBf/3
         Od2YHvhYnlA0IsZVgOHl6QVIneoDBGMzyGKBpLQtOvVnaKmHCGzutKZp+dm5SA8tAo6I
         d7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685058004; x=1687650004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZqxFbYQtuuRokHh2K7bgl6vBkPQw4ujlMDLOEiaqJU=;
        b=hCWP1UJ9on2If6GxT3QC5+p6OCicxgP1PUo/I0RugWMAdlVUTpyDYK5/vP3blrVIIm
         WL3nac54qRLN8J2ibtG3RD8zX1sn3ON7Ve4IDGHTNtMatHKZk64YZZXE0nngRkuiHd+d
         lcFwNxLAbcz+AwfMPnDpagaC9y9zI/wgMnnXGQ1mFi+vEbXP4GlqBGXOHX6oC4tglKn+
         chXub4NN2SMpPBEeX1azd/ccItQSJoIjEZOaR4uj1ZraMFruVErx6p9uME4vy0WB43Tc
         tW0BE7WOaceWC+tlP5+N5MHWSvMH1cMox/nMPoy23hw1WEMe71mumKK6PoCtFAAkSUBL
         swpg==
X-Gm-Message-State: AC+VfDzV6sGMFF0wTQ0XjvZ32upe74ydmCQk0uAQ1qVmv42PQo6tr8c4
	BjF7xy1+XPue1oGVD3eqQlKDoxF4hH1yyFeeThQ=
X-Google-Smtp-Source: ACHHUZ6Qh9Z5ebdKIRc6q19P4Asdm0XnRNqwQdkot82nyxX6SJg0NviYHYdCfUnvCtNf+YanYmbrF/wk15wQHQRF3P8=
X-Received: by 2002:a17:907:786:b0:965:ff38:2fb3 with SMTP id
 xd6-20020a170907078600b00965ff382fb3mr289778ejb.74.1685058004248; Thu, 25 May
 2023 16:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230524210243.605832-1-andrii@kernel.org> <20230524210243.605832-2-andrii@kernel.org>
 <20230525031810.g42tmdk7ykjrkrcr@MacBook-Pro-8.local> <CAEf4Bzbe-D1PwWB7T4SCzNG3RKTMko_0h1TOiEmUrR22NPjfXg@mail.gmail.com>
 <528341ba-45dd-7708-ae00-4f2d6551baa9@iogearbox.net>
In-Reply-To: <528341ba-45dd-7708-ae00-4f2d6551baa9@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 May 2023 16:39:52 -0700
Message-ID: <CAEf4BzYiMi0RrPR8e8tPSEpHeBzf=s7P4FF5pnvTiCTKB3iw0Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: revamp bpf_attr and name each
 command's field and substruct
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 25, 2023 at 2:51=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 5/25/23 7:19 PM, Andrii Nakryiko wrote:
> > On Wed, May 24, 2023 at 8:18=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Wed, May 24, 2023 at 02:02:41PM -0700, Andrii Nakryiko wrote:
> >>>
> >>> And there were a bunch of other similar changes. Please take a thorou=
gh
> >>> look and suggest more changes or which changes to drop. I'm not marri=
ed
> >>> to any of them, it just felt like a good improvement.
> >>
> >> Agree that current layout sucks, but ...
> >>
> >>>   include/uapi/linux/bpf.h       | 235 +++++++++++++++++++++++++++---=
---
> >>>   kernel/bpf/syscall.c           |  40 +++---
> >>>   tools/include/uapi/linux/bpf.h | 235 +++++++++++++++++++++++++++---=
---
> >>>   3 files changed, 405 insertions(+), 105 deletions(-)
> >>
> >> ... the diff makes it worse. The diffstat for "nop" change is a red fl=
ag.
> >
> > Only 100 lines are a real "nop" change to copy/paste existing fields
> > that are in unnamed fields. The rest is a value add.
> >
> > I don't think the deal is in stats, though, right?
> >
> >>> +     /*
> >>> +      * LEGACY anonymous substructs, for backwards compatibility.
> >>> +      * Each of the below anonymous substructs are ABI compatible wi=
th one
> >>> +      * of the above named substructs. Please use named substructs.
> >>> +      */
> >>
> >> All of them cannot be removed. This bagage will be a forever eyesore.
> >> Currently it's not pretty. The diffs make uapi file just ugly.
> >> Especially considering how 'named' and 'legacy' will start diverging.
> >
> > We have to allow "divergence" (only in the sense that new fields only
> > go into named substructs, but the existing fields stay fixed, of
> > course), to avoid more naming conflicts. If that wasn't the case,
> > using struct_group() macro could have been used to avoid a copy/paste
> > of those anonymous field/struct copies.
> >
> > So I'm not happy about those 100 lines copy paste of fixed fields
> > either, but at least that would get us out of the current global
> > naming namespace for PROG_LOAD, MAP_CREATE, BTF_LOAD, etc.
> >
> >> New commands are thankfully named. We've learned the lesson,
> >
> > Unfortunately, the problem is that unnamed commands are the ones that
> > are most likely to keep evolving.
> >
> >> but prior mistake is unfixable. We have to live with it.
> >
> > Ok, too bad, but it's fine. It was worth a try.
> >
> > I tried to come up with something like struct_group() approach to
> > minimize code changes in UAPI header, but we have a more complicated
> > situation where part of struct has to be both anonymous and named,
> > while another part (newly added fields) should go only to named parts.
> > And that doesn't seem to be possible to support with a macro,
> > unfortunately.
>
> Nice idea on the struct_group()-like approach, but agree that this is
> going to be tough given we need to divert anonymous and named parts as
> you mention. One other wild thought ... we remove the bpf_attr entirely
> from the uapi header, and have a kernel/bpf/bpf.cmd description and
> generate the bpf_attr into a uapi header via script which the main header
> can include. Kind of similar to the suggestion, but more flexible than
> macro magic. We also have things like syscall table header generated via
> script.. so it wouldn't be first. Still doesn't remove the eyesore, just
> packages it differently. ;/

There are two more ways, neither is that pretty. But I'll just outline
them here for completeness.

First, we can define about 6 variants (one for each command with anon
field) of macro with different numbers of arguments, one for each
existing field. Replace all semicolons with commas and do something
like this (we can prettify the below some more, I didn't want to waste
too much time on this demo):

#define __bpf_cmd4(type, f1, f2, f3, f4, new_fields...)        \
       struct {                                                \
               f1; f2; f3; f4;                                 \
       };                                                      \
       struct type {                                           \
               f1; f2; f3; f4;                                 \
               new_fields                                      \
       }

       /* BPF_OBJ_PIN command */
       __bpf_cmd4(bpf_obj_pin_attr,
               __aligned_u64   pathname,
               __u32           bpf_fd,
               __u32           file_flags,
               /* Same as dirfd in openat() syscall; see openat(2)
                * manpage for details of path FD and pathname semantics;
                * path_fd should accompanied by BPF_F_PATH_FD flag set in
                * file_flags field, otherwise it should be set to zero;
                * if BPF_F_PATH_FD flag is not set, AT_FDCWD is assumed.
                */
               __s32           path_fd,
               __u32           token_fd;
       ) obj_pin;

Note that I also added `__u32 token_fd;` as a demonstration how we can
new fields, and that new fields will have proper semicolons at the
end. The largest command (BPF_PROG_LOAD) will need 28 arg variant, but
that can be fit in few lines pretty cleanly, if the overall approach
would be deemed acceptable.

This approach also has a slight downside that we can rename fields
(e.g. for BPF_BTF_LOAD command). We still can split out dedicated new
named structs. So too big of a deal.


Second approach. If it's mostly about aesthetics, then we can add
include/uapi/linux/bpf_legacy.h, where we put all these unnamed fields
and structs in one stashed away place, and then in original
include/uapi/linux/bpf.h header we just

union bpf_attr {
   ... named structs and fields go here ...

/* include backwards compat legacy anon fields/structs */
#include "bpf_legacy.h"
};

This way this eyesore will be somewhat hidden away (but still lookup-able).


Curious if any of the above is more palatable?


>
> Thanks,
> Daniel

