Return-Path: <bpf+bounces-9589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900467993B3
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 02:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B3D1C20ACF
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 00:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE1C1101;
	Sat,  9 Sep 2023 00:35:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753907E5
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 00:35:21 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29726AF
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 17:34:43 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-26d0d376ec7so2017408a91.2
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 17:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694219316; x=1694824116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkwzVpKZI8AElfEw0By4C1BBurm/G7/5cU7n5hfx9N8=;
        b=eyVpDUdnYHSXFrL7dTZkRc4HHnM8w9Scp0r7guil2vZvaDNSbv1Pblc1TWXlsv6XIv
         dZk5OvQujCrQLQbvPr5SJMczcUp3GOct/WHS7W6SF4PEYRkHyeDoE0ioa9jRFNYyUffh
         glY9yWCVc1anBfmnnv4PDcdoVvb96rdsYB/aCZNEjIN//jotZoPHh5M3XEy/BapxFVzx
         XIwa1llN/b7UrDhe/VeHoV2BTQ2dLQMgp95It7M5vEeiEouM5/BIT/RehvmMakXPKk0S
         6QTJUD/uiRwzeN64JngzaHqMxNQcqhWMka2J5xcO4prRPTcc+rgTEcnjSP98kyBqsnoK
         7/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694219316; x=1694824116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkwzVpKZI8AElfEw0By4C1BBurm/G7/5cU7n5hfx9N8=;
        b=OkH65bi9boqKNA1CtdrS+rZyNoMYWZ4Dyf0GuTZJJ5V9G1CgLb05FZcp8HhB0LHnCc
         5b4GkjC+pDjop7b9bPk90HbDYd1W0NJVVoLutvFGBKNnaeXYMQt09pxboPTB55j06RSq
         I4exqg9qbg10k/8VzYw9RfCBW1geFQxCoNZCpcekLGlkacL+bG1/qacCtP7PvZA7pWiu
         NbxGbj81xvLhJSFtmsbwBAfTjxn0RWuME+pf3ylKO8tHI/SHXQh4YdLe7I8qnGcXdpz6
         Xe8lZwl2Ojd3vsuIe0BO8ESs3h7Fzl7jxID49shMhipTH/HzDvbQaaDkO5eCQXxZFD1T
         Vbcg==
X-Gm-Message-State: AOJu0YzRtAsb9gYOiR2xbXE7ACMiblc9xauvewcRZ/uyv7UCYo30aai1
	fLuEYdIV+q5BNvDcmlwH9CYAd4DJYpPEMjzWDM61bw==
X-Google-Smtp-Source: AGHT+IGSGny7UNu15/l3aPj2GcWeCNmHS1EE30QCX6jl2lUiWeTGt9/yyOuZyji4dPBJ1ZiYSfu8Pp1pY6Vr34HQxSY=
X-Received: by 2002:a17:90b:1a81:b0:273:e49e:6d7b with SMTP id
 ng1-20020a17090b1a8100b00273e49e6d7bmr2185053pjb.3.1694219315670; Fri, 08 Sep
 2023 17:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907210023.2467151-1-sdf@google.com> <CAEf4Bzb5VkJ=_4NKjSuwOVAUeSBxyVjNu_rMmatfeQZdB+bohg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb5VkJ=_4NKjSuwOVAUeSBxyVjNu_rMmatfeQZdB+bohg@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 8 Sep 2023 17:28:24 -0700
Message-ID: <CAKH8qBs3nRn4TdT45vv1s7jZm1yD+aoZSMbb-k_ePS3uPdJ6Gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Future-proof connect4_prog.c
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 4:42=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 7, 2023 at 2:00=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > With the new internal clang version I see the following optimization
> > that makes connect4 program unverifiable.
> >
> > The following code:
> >
> >         int do_bind()
>
> Yonghong added __weak to do_bind a few months ago ([0]), which makes
> it illegal for the compiler to assume 0 or 1 return. Can you please
> double check that this is the issue with __weak?
>
>   [0] https://lore.kernel.org/bpf/20230310012410.2920570-1-yhs@fb.com/

It does indeed fix it for me, thank you! Mystery solved on "why I
can't repro this on the upstream" :-) I've completely missed that
extra __weak..

>
> >         {
> >                 if (bpf_bind() !=3D 0)
> >                         return 0;
> >                 return 1;
> >         }
> >         int connect_v4_prog()
> >         {
> >                 return do_bind() ? 1 : 0;
> >         }
> >
> > Becomes:
> >
> >         int do_bind()
> >         {
> >                 if (bpf_bind() !=3D 0)
> >                         return 0;
> >                 return 1;
> >         }
> >         int connect_v4_prog()
> >         {
> >                 return do_bind();
> >         }
> >
> > IOW, looks like clang is able to see that do_bind returns only 0 and
> > 1 and the extra branch around 'return do_bind' is not needed.
> > This, however, seems to break the verifier, which assumes that
> > bpf2bpf calls can return 0-0xffffffff.
> >
> > Note, I can produce those programs only with the internal fork of clang=
.
> > The latest one from git still produced correct bytecode. It might be
> > some options/optimizations that we enable and that are still
> > disabled for the general upstream users, not sure. I've desided
> > to send this patch out anyway since it seems like a correct optimizatio=
n
> > the compiler might do.
> >
> > So to be future-proof, reshape the code a bit to return bpf_bind
> > result directly. This will not give any hint to the clang about
> > the return value and will force it generate that '? 1: 0' branch
> > at the callee.
> >
> > Good program:
> >
> > 0000000000000000 <do_bind>:
> >        0:       b4 02 00 00 7f 00 00 04 w2 =3D 0x400007f
> >        1:       63 2a f4 ff 00 00 00 00 *(u32 *)(r10 - 0xc) =3D r2
> >        2:       b4 02 00 00 02 00 00 00 w2 =3D 0x2
> >        3:       63 2a f0 ff 00 00 00 00 *(u32 *)(r10 - 0x10) =3D r2
> >        4:       b7 02 00 00 00 00 00 00 r2 =3D 0x0
> >        5:       63 2a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) =3D r2
> >        6:       63 2a f8 ff 00 00 00 00 *(u32 *)(r10 - 0x8) =3D r2
> >        7:       bf a2 00 00 00 00 00 00 r2 =3D r10
> >        8:       07 02 00 00 f0 ff ff ff r2 +=3D -0x10
> >        9:       b4 03 00 00 10 00 00 00 w3 =3D 0x10
> >       10:       85 00 00 00 40 00 00 00 call 0x40
> >       11:       bf 01 00 00 00 00 00 00 r1 =3D r0
> >       12:       b4 00 00 00 01 00 00 00 w0 =3D 0x1
> >       13:       15 01 01 00 00 00 00 00 if r1 =3D=3D 0x0 goto +0x1 <LBB=
0_2>
> >       14:       b4 00 00 00 00 00 00 00 w0 =3D 0x0
> >
> > 00000000000001b0 <LBB1_30>:
> >       54:       bc 60 00 00 00 00 00 00 w0 =3D w6
> >       55:       95 00 00 00 00 00 00 00 exit
> >
> > 0000000000000578 <LBB1_28>:
> >      ...
> >      180:       85 10 00 00 ff ff ff ff call -0x1
> >      181:       b4 06 00 00 01 00 00 00 w6 =3D 0x1
> >      182:       56 00 7f ff 00 00 00 00 if w0 !=3D 0x0 goto -0x81 <LBB1=
_30>
> >      183:       b4 06 00 00 00 00 00 00 w6 =3D 0x0
> >      184:       05 00 7d ff 00 00 00 00 goto -0x83 <LBB1_30>
> >
> > Bad program:
> > 0000000000000000 <do_bind>:
> >        0:       b4 02 00 00 7f 00 00 04 w2 =3D 0x400007f
> >        1:       63 2a f4 ff 00 00 00 00 *(u32 *)(r10 - 0xc) =3D r2
> >        2:       b4 02 00 00 02 00 00 00 w2 =3D 0x2
> >        3:       63 2a f0 ff 00 00 00 00 *(u32 *)(r10 - 0x10) =3D r2
> >        4:       b7 02 00 00 00 00 00 00 r2 =3D 0x0
> >        5:       63 2a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) =3D r2
> >        6:       63 2a f8 ff 00 00 00 00 *(u32 *)(r10 - 0x8) =3D r2
> >        7:       bf a2 00 00 00 00 00 00 r2 =3D r10
> >        8:       07 02 00 00 f0 ff ff ff r2 +=3D -0x10
> >        9:       b4 03 00 00 10 00 00 00 w3 =3D 0x10
> >       10:       85 00 00 00 40 00 00 00 call 0x40
> >       11:       bf 01 00 00 00 00 00 00 r1 =3D r0
> >       12:       b4 00 00 00 01 00 00 00 w0 =3D 0x1
> >       13:       15 01 01 00 00 00 00 00 if r1 =3D=3D 0x0 goto +0x1 <LBB=
0_2>
> >       14:       b4 00 00 00 00 00 00 00 w0 =3D 0x0
> >
> > 00000000000001b0 <LBB1_3>:
> >       54:       bc 60 00 00 00 00 00 00 w0 =3D w6
> >       55:       95 00 00 00 00 00 00 00 exit
> >
> > 0000000000000578 <LBB1_28>:
> >      ...
> >      180:       85 10 00 00 ff ff ff ff call -0x1
> >      181:       bc 06 00 00 00 00 00 00 w6 =3D w0
> >      182:       05 00 7f ff 00 00 00 00 goto -0x81 <LBB1_3>
> >
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/testing/selftests/bpf/progs/connect4_prog.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/=
testing/selftests/bpf/progs/connect4_prog.c
> > index 7ef49ec04838..b7fc46a0787b 100644
> > --- a/tools/testing/selftests/bpf/progs/connect4_prog.c
> > +++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
> > @@ -41,10 +41,7 @@ int do_bind(struct bpf_sock_addr *ctx)
> >         sa.sin_port =3D bpf_htons(0);
> >         sa.sin_addr.s_addr =3D bpf_htonl(SRC_REWRITE_IP4);
> >
> > -       if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) !=3D 0)
> > -               return 0;
> > -
> > -       return 1;
> > +       return bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa));
> >  }
> >
> >  static __inline int verify_cc(struct bpf_sock_addr *ctx,
> > @@ -194,7 +191,7 @@ int connect_v4_prog(struct bpf_sock_addr *ctx)
> >         ctx->user_ip4 =3D bpf_htonl(DST_REWRITE_IP4);
> >         ctx->user_port =3D bpf_htons(DST_REWRITE_PORT4);
> >
> > -       return do_bind(ctx) ? 1 : 0;
> > +       return do_bind(ctx) ? 0 : 1;
> >  }
> >
> >  char _license[] SEC("license") =3D "GPL";
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >

