Return-Path: <bpf+bounces-4373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2815474A863
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D40A2815CF
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAC3110B;
	Fri,  7 Jul 2023 01:20:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1B7F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 01:20:07 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056A419A0
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 18:20:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so21091671fa.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 18:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688692804; x=1691284804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPAITjGqmZ7YqQV2/ocNxUrr2tpvL7EtxI2PHwtTtwE=;
        b=EHqJzrKGvZO0+FSMCbIJfJvFWkvbLtbAW0BXJb66VfzZYa7+vIfql6xlC6VZ3mt7xx
         jbeooJ+ODGvm7RICD7Y4M0OZvpUYUV/8QXBuS3y5DnNZCGYG3DRfXoRFflW2l4x8+KPg
         gev7rer44bpJSwMBNoCDKb5IoWLPmVY3ctOnWNmYK1ViAoWuwy7a55wUgvHonxrBcdON
         VeFV+PAhu8DOipmvswz0Qk6X7QxLUu5olIL30YewMJQvIN+7HnSCoHH7RY6s8B3HZyJV
         7PpIHFsvd+EMKWBiKtTPI1DutecVtEpps0Ojkn9511eOhau05CwIoIZJxGtIzo2nkpee
         FlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688692804; x=1691284804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPAITjGqmZ7YqQV2/ocNxUrr2tpvL7EtxI2PHwtTtwE=;
        b=clvoi5E0X8SHA+HoBrpiH5icek2D2fICtUgoVgjy2dzaicEF9F3txGnNruZeKR4hqv
         BQeptKSyfbAOA0g3IqAbXkfAUAW3r7FmKF25EDt2H4+hhAW494VkczaoNJbWmJP+3ysQ
         82Ewn1Ll7NWWGxFXwQNKrV1q+zpdSYnXERlueCqzcFDEnIh2MUiLUABkrmD2GiQMIWgh
         ot8tjUtgO0+yqbMl39ao58xeSKgkdeNsnBWCZFIrhC5c/RB5ZEQ7u96pDwdYnBpMWEQX
         BHbqsiDXeEDEtpsL+wVCoSHNxiDZbys9DOgYckxxlRc9zFZ2L/g33yOGxPRrcfghArPq
         epsQ==
X-Gm-Message-State: ABy/qLa4mWepq2HmUKq/cxaEdrUIFMAJVNVfNwOHq/y9mFXE88BRNUiG
	NsMgtTiSuHv3R2k6XC9R0bYFLttJAYge8qi/QO4WCSw9
X-Google-Smtp-Source: APBJJlGsjuf5OoxN6QW0AzMbWWCa09npGLna6ZYxpcTU+wDG8mVTmhwP5mIkYTwp91cmV5pqVpUIWttkqv6TtmLzlYY=
X-Received: by 2002:a2e:7e08:0:b0:2b4:94ec:e4 with SMTP id z8-20020a2e7e08000000b002b494ec00e4mr2602318ljc.22.1688692804052;
 Thu, 06 Jul 2023 18:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 18:19:52 -0700
Message-ID: <CAADnVQJhfa+g227BX=3LijoXwgh7h3Z5V_ZF8tMeMWNZguAp5g@mail.gmail.com>
Subject: Re: [Bpf] Instruction set extension policy
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 10:00=E2=80=AFAM Dave Thaler
<dthaler=3D40microsoft.com@dmarc.ietf.org> wrote:
>
> The charter for the newly formed IETF BPF WG includes:
>
> =E2=80=9CThe BPF working group is initially tasked with =E2=80=A6 creatin=
g a clear process for extensions, =E2=80=A6=E2=80=9D
>
>
>
> I wanted to kick off a discussion of this topic in preparation for discus=
sion
> at IETF 117.
>
>
>
> Once the BPF ISA is published in an RFC, we expect more instructions may =
be
> added over time.  It seems undesirable to delay use such additions until
>
> another RFC can be published, although having them appear in an RFC
> would be a good thing in my view.
>
>
>
> Personally, I envision such additions to appear in an RFC per extension
>
> (i.e., set of additions) rather than obsoleting the original ISA RFC.  So
> I would propose the ability to reference another document (e.g., one
> in the Linux kernel tree) in the meantime.
>
>
>
> For comparison, the IANA registry for URI schemes at
> https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml
> defines status values for =E2=80=9CPermanent=E2=80=9D and =E2=80=9CProvis=
ional=E2=80=9D with different
> registration policies for each of those two statuses.
>
>
>
> Similarly, I would propose as a strawman using an IANA registry (as most
> IETF standards do) that requires say an IETF Standards Track RFC for
>
> =E2=80=9CPermanent=E2=80=9D status, and =E2=80=9CSpecification required=
=E2=80=9D (a public specification
> reviewed by a designated expert) for =E2=80=9CProvisional=E2=80=9D regist=
rations.
> So updating a document in say the Linux kernel tree would be sufficient
> for Provisional registration, and the status of an instruction would chan=
ge
> to Permanent once it appears in an RFC.

The definition of status and the semantics make sense,
but I suspect to implement them via full IANA would require
to list every instruction encoding in the registry and that's where
IANA key/value mapping won't work.
8-bit opcode is often not enough to denote an instruction.
All of v1,v2,v3,v4 existing extensions to BPF ISA happened by a combination
of new 8-bit opcodes and using reserved bits in other parts of 64-bit insn.
Now we pretty much ran out of 8-bit opcodes.
So there is really nothing the IANA registry can help with.

