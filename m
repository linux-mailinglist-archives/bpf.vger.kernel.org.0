Return-Path: <bpf+bounces-12338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F9D7CB2AE
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FE21C20B9B
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9A33992;
	Mon, 16 Oct 2023 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK2+oxhU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08A3398E;
	Mon, 16 Oct 2023 18:42:05 +0000 (UTC)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD10E1;
	Mon, 16 Oct 2023 11:42:03 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b605706bb0so1793389241.3;
        Mon, 16 Oct 2023 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697481722; x=1698086522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVxPeeG/1EcIooqWLaHg+UygOqvO//U50PKHWICGfyY=;
        b=LK2+oxhUJMOQ/+5oBRgR9SovoGWxwXWnNfd1N1X3bQt1l63f5MdpJ8JZ/YseMooUim
         ff91XgTHfByg3YqK9eicaY91D1DqrwUB+su42O6eoSm/64JTB0S7Id9rRATPGZrWirGa
         Ij+DskKJc35degrns+nefvce/q6ECF5Eq7ZcdK4ANkEKfMyCRTF7iPIoRLMhGpnrcshA
         urRXbhZEbppsyJeWnKLqomAkQ+TkPndgpKL96fl6Ajm/aEh50FcTyT5JhZjlu5z7nbkn
         YwuB4euYALSrrd3pPGMv18TrP68G4tbJXZxp/U17Epo40L316RuPwQX9/pUWdthOwPBA
         vI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697481722; x=1698086522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVxPeeG/1EcIooqWLaHg+UygOqvO//U50PKHWICGfyY=;
        b=vEI9BtnqzfEB2k/x48ikHMhvg4l8RN3wxFp+rz0iUY2IrdkoVhIhiqDTJRhsqby5zD
         UrXnS/TirjmGtc9l/azg4YUELThZSNwfW0Lsi3DHv3s1xFBJ9q3bdPdVVk4Szxm56JyX
         j0+cue5/noxp9PObwAaYuiTVLcZ8fR9iOvmBUUO4YCd7aFYvLy5XDJ1XYgRl/rsIX91/
         1XS7snw7RaOu8px/Oo1Zzkz0pFgWeiF7rpA4Ziw9NBLyJT8kRS6RsQ4XnO2FafGKxP6J
         h491nsdYhwHpNn2PkKw6f/IhaMFsx4scWnKAqoz9MgHvCRaj+bF8pd4m+IzhkV2cviSU
         Lklg==
X-Gm-Message-State: AOJu0YzNztnIvLuZeeW7bWn7NHhsmcjQ9T7Lc5tyYSgSwu6RqRTbN7PL
	e1KnE2FF8ukUMPuijbWxZZBHxbOygBgOrF/yBwI=
X-Google-Smtp-Source: AGHT+IG9VYMWnCHNWH+Vy+9t8oKdqCxwYFtnPuvuTDAferidS3/5yyy/rdmJ+qUStNzI8s9SMBRtTpowA0iPU4byerk=
X-Received: by 2002:a05:6102:4709:b0:452:67fc:b437 with SMTP id
 ei9-20020a056102470900b0045267fcb437mr189323vsb.18.1697481722614; Mon, 16 Oct
 2023 11:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <652d46664a3db_1980fa29460@willemb.c.googlers.com.notmuch> <20231016164606.29484-1-kuniyu@amazon.com>
In-Reply-To: <20231016164606.29484-1-kuniyu@amazon.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 16 Oct 2023 14:41:25 -0400
Message-ID: <CAF=yD-++2Qr+-T4iGbJc-k0KXk_X6rH5rHoPcCOs6Lxnzu2_GA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie
 generation/validation SOCK_OPS hooks.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, kuni1840@gmail.com, 
	martin.lau@linux.dev, mykolal@fb.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@google.com, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 12:46=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Mon, 16 Oct 2023 10:19:18 -0400
> > Kuniyuki Iwashima wrote:
> > > Under SYN Flood, the TCP stack generates SYN Cookie to remain statele=
ss
> > > for the connection request until a valid ACK is responded to the SYN+=
ACK.
> > >
> > > The cookie contains two kinds of host-specific bits, a timestamp and
> > > secrets, so only can it be validated by the generator.  It means SYN
> > > Cookie consumes network resources between the client and the server;
> > > intermediate nodes must remember which nodes to route ACK for the coo=
kie.
> > >
> > > SYN Proxy reduces such unwanted resource allocation by handling 3WHS =
at
> > > the edge network.  After SYN Proxy completes 3WHS, it forwards SYN to=
 the
> > > backend server and completes another 3WHS.  However, since the server=
's
> > > ISN differs from the cookie, the proxy must manage the ISN mappings a=
nd
> > > fix up SEQ/ACK numbers in every packet for each connection.  If a pro=
xy
> > > node is down, all the connections through it are also down.  Keeping =
a
> > > state at proxy is painful from that perspective.
> > >
> > > At AWS, we use a dirty hack to build truly stateless SYN Proxy at sca=
le.
> > > Our SYN Proxy consists of the front proxy layer and the backend kerne=
l
> > > module.  (See slides of netconf [0], p6 - p15)
> > >
> > > The cookie that SYN Proxy generates differs from the kernel's cookie =
in
> > > that it contains a secret (called rolling salt) (i) shared by all the=
 proxy
> > > nodes so that any node can validate ACK and (ii) updated periodically=
 so
> > > that old cookies cannot be validated.  Also, ISN contains WScale, SAC=
K, and
> > > ECN, not in TS val.  This is not to sacrifice any connection quality,=
 where
> > > some customers turn off the timestamp option due to retro CVE.
> >
> > If easier: I think it should be possible to make the host secret
> > readable and writable with CAP_NET_ADMIN, to allow synchronizing
> > between hosts.
>
> I think the idea is doable for syncookie_secret and syncookie6_secret.
> However, the cookie timestamp is generated based on jiffies that cannot
> be written.
>
> [ I answered sharing secrets would resolve our issue at netconf, but
>   I was wrong. ]
>
>
> > For similar reasons as suggested here, a rolling salt might be
> > useful more broadly too.
>
> Maybe we need not use jiffies and can create a worker to update the
> secret periodically if it's not configured manually.
>
> The problem here would be that we need to update/read u64[4] atomically
> if we want to use SipHash or HSipHash.  Maybe this also can be changed.
>
> But, we still want to use BPF as we need to encode (at least) WS and
> SACK bits in ISN, not TS and use different MSS candidates rather than
> msstab.
>
> Also, in our use case, the validation for cookie itself is done in
> the front proxy layer, and the kernel will do more light-weight
> validation like checking if the cookie is forwarded from trusted
> nodes.  Then, we can prevent invalid ACK from flowing through the
> backend and consuming some networking entries, and the backend need
> not do full validation.
>
> With BPF, we can get such flexibility at encoding and validation, and
> making cookie generation algorithm private could be good for security.

Thanks for that context. Sounds like it indeed would not be a small
change to support your use case in the existing syncookie C code,
then.

