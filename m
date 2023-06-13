Return-Path: <bpf+bounces-2562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8CD72EFDB
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 01:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4EB1C20965
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 23:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C183D38F;
	Tue, 13 Jun 2023 23:16:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5A2DBD5
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 23:16:22 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B7C199E
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 16:16:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b3a9eae57cso26251985ad.1
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 16:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686698180; x=1689290180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24jJGM73GfNkD9CpSjASvfsX7KJiEngjZm4uzAmB9uk=;
        b=aAFvRkg4sFRjS8wVelWRyofa5ikQg3hN0BjEdDeh39VHL9plkM++I5Z8XkMWRZr6QL
         Ov0Wag41Ok/1CxrLoRqClOQn5+INCFPceIfQ61Nlkd/mKphX7OeGNpy+Otn5ap/myoEL
         ezq/dQraY4koyXu1AJhqIqWwaszqlZcKZsKSIzWo3aA4GH64/xrecOKYZW53YFGo5nGx
         Cz7C2b3QjFVTt1HGbMDStPv9H3JaHwmARwfUq/C+0YIg16WXzR2V7NAzTI+PSPrX04XZ
         tf7ZZgTZ4kDbvver6hvRD8zISn8KUGlEPn3+vRcaOgZ8bSqSg8lHPynr1AfuUlgoaVLd
         d/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686698180; x=1689290180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24jJGM73GfNkD9CpSjASvfsX7KJiEngjZm4uzAmB9uk=;
        b=RomkQN7wFQuj+D5RgvdMJ2C36As+ql2Q3G2meC7po9riDU0KtAOPUvQ2nCMYdTXrqf
         HMEJw9dxCQ/RzJbxOo7ml9bkE0zbrWQ/4P54wpfPspV0FCr48/pHRxxBaf+7/Dl7xa3g
         Cx/GzVRieReubaiFVD3rD/Qz7dif08WkZQJy+Eyb4zR6vK1YVrQNheIN7AzrbqO85oOP
         1kyIOjx/6qFBIYIc3jf0Wl+RexQCF3MRxLcHg8090pWq2X9FAsS6SAGA+j3BpqYvRWXh
         Mqu/PGiZVyM6uODh2koNUB9h148TPEZLQmiFC5d7mhHU0+kf7yFzDFgd6QpZJH9sEDFg
         l4LA==
X-Gm-Message-State: AC+VfDzgyO4q2hgCNRzF/PdR3/CLfuVt71B9SL9Em8Fn16DkNSJ7ccKR
	qiVq3kDAfs30AgLo9rod0AykOKQWo+4AnRlbE180tg==
X-Google-Smtp-Source: ACHHUZ5OTZXfbGRMoVhovtJpY6m/JONC0U0gRNmNxCJI5WJjg54+d8Sba5F3qzVgDpewIh1vzQ+DaRouI0/goUFlzL8=
X-Received: by 2002:a17:902:ea01:b0:1af:ea40:34f2 with SMTP id
 s1-20020a170902ea0100b001afea4034f2mr14346857plg.11.1686698179863; Tue, 13
 Jun 2023 16:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612172307.3923165-1-sdf@google.com> <87cz20xunt.fsf@toke.dk>
 <ZIiaHXr9M0LGQ0Ht@google.com> <877cs7xovi.fsf@toke.dk> <CAKH8qBt5tQ69Zs9kYGc7j-_3Yx9D6+pmS4KCN5G0s9UkX545Mg@mail.gmail.com>
 <87v8frw546.fsf@toke.dk> <CAKH8qBtsvsWvO3Avsqb2PbvZgh5GDMxe2fok-jS4DrJM=x2Row@mail.gmail.com>
 <CAADnVQKFmXAQDYVZxjvH8qbxk+3M2COGbfmtd=w8Nxvf9=DaeA@mail.gmail.com>
In-Reply-To: <CAADnVQKFmXAQDYVZxjvH8qbxk+3M2COGbfmtd=w8Nxvf9=DaeA@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 13 Jun 2023 16:16:08 -0700
Message-ID: <CAKH8qBvAMKtfrZ1jdwVS2pF161UdeXPSpY4HSzKYGTYNTupmTg@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/7] bpf: netdev TX metadata
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 3:32=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jun 13, 2023 at 2:17=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > > >> >> > --- UAPI ---
> > > >> >> >
> > > >> >> > The hooks are implemented in a HID-BPF style. Meaning they do=
n't
> > > >> >> > expose any UAPI and are implemented as tracing programs that =
call
> > > >> >> > a bunch of kfuncs. The attach/detach operation happen via BPF=
 syscall
> > > >> >> > programs. The series expands device-bound infrastructure to t=
racing
> > > >> >> > programs.
> > > >> >>
> > > >> >> Not a fan of the "attach from BPF syscall program" thing. These=
 are part
> > > >> >> of the XDP data path API, and I think we should expose them as =
proper
> > > >> >> bpf_link attachments from userspace with introspection etc. But=
 I guess
> > > >> >> the bpf_mprog thing will give us that?
> > > >> >
> > > >> > bpf_mprog will just make those attach kfuncs return the link fd.=
 The
> > > >> > syscall program will still stay :-(
> > > >>
> > > >> Why does the attachment have to be done this way, exactly? Couldn'=
t we
> > > >> just use the regular bpf_link attachment from userspace? AFAICT it=
's not
> > > >> really piggy-backing on the function override thing anyway when th=
e
> > > >> attachment is per-dev? Or am I misunderstanding how all this works=
?
> > > >
> > > > It's UAPI vs non-UAPI. I'm assuming kfunc makes it non-UAPI and giv=
es
> > > > us an opportunity to fix things.
> > > > We can do it via a regular syscall path if there is a consensus.
> > >
> > > Yeah, the API exposed to the BPF program is kfunc-based in any case. =
If
> > > we were to at some point conclude that this whole thing was not usefu=
l
> > > at all and deprecate it, it doesn't seem to me that it makes much
> > > difference whether that means "you can no longer create a link
> > > attachment of this type via BPF_LINK_CREATE" or "you can no longer
> > > create a link attachment of this type via BPF_PROG_RUN of a syscall t=
ype
> > > program" doesn't really seem like a significant detail to me...
> >
> > In this case, why do you prefer it to go via regular syscall? Seems
> > like we can avoid a bunch of boileplate syscall work with a kfunc that
> > does the attachment?
> > We might as well abstract it at, say, libbpf layer which would
> > generate/load this small bpf program to call a kfunc.
>
> I'm not sure we're on the same page here.
> imo using syscall bpf prog that calls kfunc to do a per-device attach
> is an overkill here.
> It's an experimental feature, but you're already worried about
> multiple netdevs?
>
> Can you add an empty nop function and attach to it tracing style
> with fentry ?
> It won't be per-netdev, but do you have to do per-device demux
> by the kernel? Can your tracing bpf prog do that instead?
> It's just an ifindex compare.
> This way than non-uapi bits will be even smaller and no need
> to change struct netdevice.

It's probably going to work if each driver has a separate set of tx
fentry points, something like:
  {veth,mlx5,etc}_devtx_submit()
  {veth,mlx5,etc}_devtx_complete()
Because I still need to have those netdev-bound tracing programs to
get access to driver kfuncs.

I can try to sketch something together for a v2.

