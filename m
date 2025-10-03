Return-Path: <bpf+bounces-70316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC57BB7A37
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1885E34727C
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 17:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC142D4B5F;
	Fri,  3 Oct 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5cso9Rz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15112D46A1
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510794; cv=none; b=D27rNqC6Lzl9XOqJIdwfMZAAeGzIwa2QlaKTxirrzz8keZo+aA242VoX4KOnzSJn0NKmiCifmfbIuvL/XGlLNTVPnQPw+cC09E0Iid0udo+Sf0WVrMpY8BuM1mTmTJEvbyAH9gTY6KJBpxP+51JgYWsdiJL3Y6hU6ROwc23HdGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510794; c=relaxed/simple;
	bh=Dm+gPhUlTYdK+pWeKk8TcHmBTW+K4d9vuk7ZaVhiZYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnVgsb4VhcC9c5G0fHmnvQwrzSgm+23sK4CMw47YqQqNszZqQeESdBoiLMpTcJEn3dc0yIsTn4aQgX2l27J1tP4V9oMQmyS5qh5MYVtcAAMidku0frz/pzFaU2MilXMcsRb0qlk8+G9XR219qiQ2qhzIl/S5iyM/FlhJAZOl9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5cso9Rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E41C4CEFD
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759510794;
	bh=Dm+gPhUlTYdK+pWeKk8TcHmBTW+K4d9vuk7ZaVhiZYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l5cso9RzYD01xDVJvJOl1p5+47J5BSckayaKE1zvb5fUAo0kn51M3hTmLP5grkHCs
	 jTdIHdF9XeRg0iNuQE5ahUWS3DjDWtbHnltaArMVs1qDBQY7r8jHcsrn73BCgtEqdR
	 PlgDhzIDaldCL4O2IOUw+zMMBzGYEM+80Pf3N4qgxpPKxgkoFJgb9PkVhlSu0DCuFv
	 9o2v0VGi79mbUuzldMpC90z75zKgSQEcey5X536MZW5nRG2BtxBhJmfv5Y5XohIFkE
	 xpbHv7y2d9yfbeBAzK4eVaf7h//HXott4U//tgBya/sD+f5+7YInaAaL5VnMxUoDvf
	 MFEMwkrnF0zBg==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e326e4e99so19163815e9.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:59:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGK95Vwi8oKGm1LLgN54RqAeX08HdOlCMKgJW+X0O0tokfNWhvThvjn8xQz6dNp6Zdz+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuN2LyU8obXfYp1g+B94ZpSL5DOUmGsa+K5L64tRFWNdHxDZdm
	RQo/UEIc40Idx2Q1jTTKHfNTa34eLJXsWnjn1SjtGUi2nCxggiX6ngfks9zrXIOuGpK6LHW367i
	4XJ/ejOz+dhyQpbPQy82tc1UeGTQnef5XbY3ye24A
X-Google-Smtp-Source: AGHT+IEr3BIDiCk8sTQsn+rtYiKWJaDvVW8VFiCXWsnTlBePQ4EMKYr+kyTSio9lZIPsw7B4hTWapJXqKS03s9xwxDQ=
X-Received: by 2002:a05:6000:26c1:b0:3e9:4ae9:9f1 with SMTP id
 ffacd0b85a97d-4255d2d660amr5534735f8f.31.1759510792979; Fri, 03 Oct 2025
 09:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com> <871pnlysx1.fsf@microsoft.com>
In-Reply-To: <871pnlysx1.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 3 Oct 2025 18:59:41 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7F6ax2AcWNFxnAkyVb26Dr2mwdBnW=HFVFeJ1pC-BObg@mail.gmail.com>
X-Gm-Features: AS18NWBP89m17IAxm9MB5jy2HZC2tLQS_AaZYjEstXwZxxzITw95hPLbqog0KIo
Message-ID: <CACYkzJ7F6ax2AcWNFxnAkyVb26Dr2mwdBnW=HFVFeJ1pC-BObg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, Linus Torvalds <torvalds@linux-foundation.org>, ast@kernel.org, 
	james.bottomley@hansenpartnership.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kys@microsoft.com, 
	daniel@iogearbox.net, andrii@kernel.org, wufan@linux.microsoft.com, 
	qmo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 10:01=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> > On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >
> > [...]
> >
>
> [...]
>
> I am confident that Paul will address your remaining points. However, I
> would like to clarify a few factual inaccuracies outlined below.
>
> >
> > Blaise's implementation fails on any modern BPF programs since
> > programs use more than one map, BTF information and kernel functions.
> >
>
> If you read the patch series you'd see that it supports verification of
> any number of maps. If you've identified an issue with map verification,
> please share the details and I=E2=80=99ll address it.
>

I am sorry but this does not work, the UAPI here is

+ /* Pointer to a buffer containing the maps used in the signature
+ * hash chain of the BPF program.
+ */
+ __aligned_u64   signature_maps;
+ /* Size of the signature maps buffer. */
+ __u32 signature_maps_size;

This needs to be generically applicable and it's not, What happens if
the program is not a loader program / when the instruction buffer is
stable?

If you really want the property that all of the content is signed and
verified within the kernel, please explore approaches to make the
instruction buffer stable or feel free to deny any programs that do
relocations at load time for whatever "strict" security policy that
you want to implement.

Please stop pursuing this extension as it adds cruft to the UAPI
that's too specific, encodes the hash chain in the kernel and we won't
need in the future.

> [...]
>
> >> conventions around the placement of LSM hooks, this "halfway" approach
> >> makes it difficult for LSMs to log anything about the signature status
> >> of a BPF program being loaded, or use the signature status in any type
> >> of access decision.  This is important for a number of user groups
> >> that use LSM based security policies as a way to help reason about the
> >> security properties of a system, as KP's scheme would require the
> >> users to analyze the signature verification code in every BPF light
> >> skeleton they authorize as well as the LSM policy in order to reason
> >> about the security mechanisms involved in BPF program loading.
> >>
> >> Blaise's signature scheme also has the nice property that BPF ELF
> >> objects created using his scheme are backwards compatible with
> >> existing released kernels that do not support any BPF signature
> >> verification schemes, of course without any signature verification.
> >> Loading a BPF ELF object using KP's signature scheme will likely fail
> >> when loaded on existing released kernels.
> >
> > This does not make any sense. The ELF format and the way loaders like
> > libbpf interpret it, has nothing to do with the kernel or UAPI.
> >
>
> We signed a program with your upstream tools and it failed to load on a
> vanilla kernel 6.16. The loader in your patchset is intepreting the
> first few fields of struct bpf_map as a byte array containing a sha256
> digest on older kernels.

We can convert BPF_OBJ_GET_INFO_BY_FD to be called from loader
programs to not rely on the struct field. and or libbbf can call
BPF_OBJ_GET_INFO_BY_FD to check if map_get_hash is supported before it
generates the hash check.

You should not expect bpftool -S -k -i to work on older kernels but it
should error out if the options are passed.

- KP

>
> -blaise
>
>
> > I had given detailed feedback to Blaise in
> > https://lore.kernel.org/bpf/CACYkzJ6yNjFOTzC04uOuCmFn=3D+51_ie2tB9_x-u2=
xbcO=3DyobTw@mail.gmail.com/
> > mentions also why we don't want any additional UAPI.
> >
> > You keep mentioning having visibility  in the LSM code and I again
> > ask, to implement what specific security policy and there is no clear
> > answer? On a system where you would like to only allow signed BPF
> > programs, you can purely deny any programs where the signature is not
> > provided and this can be implemented today.
> >
> > Stable programs work as it is, programs that require runtime
> > relocation work with loader programs. We don't want to add more UAPI
> > as, in the future, it's quite possible that we can make the
> > instruction buffer stable.
> >
> > - KP
> >
> >>
> >> [1] https://lore.kernel.org/linux-security-module/CAADnVQ+C2KNR1ryRtBG=
OZTNk961pF+30FnU9n3dt3QjaQu_N6Q@mail.gmail.com/
> >> [2] https://lore.kernel.org/linux-security-module/CAHC9VhRjKV4AbSgqb4J=
_-xhkWAp_VAcKDfLJ4GwhBNPOr+cvpg@mail.gmail.com/
> >> [3] https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@micro=
soft.com/
> >> [4] https://lore.kernel.org/linux-security-module/20250909162345.56988=
9-2-bboscaccy@linux.microsoft.com/
> >> [5] https://lore.kernel.org/linux-security-module/20250926203111.13059=
99-1-bboscaccy@linux.microsoft.com/
> >> [6] https://lore.kernel.org/linux-security-module/20250929213520.18212=
23-1-bboscaccy@linux.microsoft.com/
> >>
> >> --
> >> paul-moore.com

