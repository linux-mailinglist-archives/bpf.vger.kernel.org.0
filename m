Return-Path: <bpf+bounces-5855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A387E762186
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 20:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E62928199A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B785F25932;
	Tue, 25 Jul 2023 18:37:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024021D52
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 18:37:01 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2270CA3
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 11:37:00 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-569fdf846edso953823eaf.2
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690310219; x=1690915019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeelAk+UG0Z+0Z6zA+f8GznerG9M7rwYV5RDidhYjkk=;
        b=g5zeOHCl+JxQX2YiRSpINPt1lO8AEXC19Y8vuLftI87MpjEB+0izBEJhKmb//srMUI
         KYGCwVwSQddkNF1oUj7TMQM6aIKPiyDpDdnTOatvtGadNgSklJVrUSsCxY7zQsZDZDLH
         wfiiUD4K7ux/rWO+nRnILwopOXccsoZsZv2OoP+P8X68qF/wFesw4wRPGsDXAaYcRDGJ
         bMIu+7AvFOt603+XGzZSBE1co/MA4iSt/HOu0CYbrVT+m4khMwPLTtyBZcYlIfPZ5Iu+
         b7ej1FjLpEw6lf3P8qfdbuGVj7Yqo7q03PKJ+C2WSZMbvPN98JoNpgsWxR8RWXymY5Et
         z09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690310219; x=1690915019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeelAk+UG0Z+0Z6zA+f8GznerG9M7rwYV5RDidhYjkk=;
        b=ld1pG9d1XcMnYpmSRSggK9UAvcuEThPXD+pB4Dee7JMPTdVSqWR1WaQ426fUXhRZUj
         II9U8DQIrA+/vYAK4GQ/ygg5h8Qu1HFf4h3fXHrWsqjnEk2HCZ375nwV+d55bzut3NZ1
         bnexd7oG+mkKG/8g+Zo0EZdFWoHESI3YNBciFfUAyJR2kSgg7Fs581W2Sgo4lte6yA++
         6EzvDM43wYEdAevWm6F1hu7wD121nrBGjJGQbg/HrQVBftbSm3/CU/jHVmS21Xuumh0u
         IkUQ2UTCtnje20yZBcelq9bEs++RYFjxDeBFNciZv5IdUCYaIgwEW9zPzuhAnHg8L8d6
         yb3g==
X-Gm-Message-State: ABy/qLb15nT28MGQb4VtvaWeAbkmVr670+Hv6faYZqYJmvdIOJo2jnKw
	aWHLu31UCa6I+pb/r/zh5pnrA+5++hauPWgtc1onN4gu
X-Google-Smtp-Source: APBJJlG2KOMCEuu7ue8fjkBhAf5I25AceKARm8COrbZIfzcrYLb8Drhk/6vemvi6s/oQSNb50nCPeJgP+HU/gB8e2yI=
X-Received: by 2002:a4a:dfbc:0:b0:566:f951:d12 with SMTP id
 k28-20020a4adfbc000000b00566f9510d12mr158049ook.1.1690310219400; Tue, 25 Jul
 2023 11:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
In-Reply-To: <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Tue, 25 Jul 2023 11:36:48 -0700
Message-ID: <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dthaler@microsoft.co=
m> wrote:
> >
> > I am forwarding the email below (after converting HTML to plain text)
> > to the mailto:bpf@vger.kernel.org list so replies can go to both lists.
> >
> > Please use this one for any replies.
> >
> > Thanks,
> > Dave
> >
> > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watson Ladd
> > > Sent: Monday, July 24, 2023 10:05 PM
> > > To: bpf@ietf.org
> > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > >
> > > Dear BPF wg,
> > >
> > > I took a look at the draft and think it has some issues, unsurprising=
ly at this stage. One is
> > > the specification seems to use an underspecified C pseudo code for op=
erations vs
> > > defining them mathematically.
>
> Hi Watson,
>
> This is not "underspecified C" pseudo code.
> This is assembly syntax parsed and emitted by GCC, LLVM, gas, Linux Kerne=
l, etc.

I don't see a reference to any description of that in section 4.1.
It's possible I've overlooked this, and if people think this style of
definition is good enough that works for me. But I found table 4
pretty scanty on what exactly happens.
>
> > > The good news is I think this is very fixable although tedious.
> > >
> > > The other thornier issues are memory model etc. But the overall struc=
ture seems good
> > > and the document overall makes sense.
>
> What do you mean by "memory model" ?
> Do you see a reference to it ? Please be specific.

No, and that's the problem. Section 5.2 talks about atomic operations.
I'd expect that to be paired with a description of barriers so that
these work, or a big warning about when you need to use them. For
clarity I'm pretty unfamiliar with bpf as a technology, and it's
possible that with more knowledge this would make sense. On looking
back on that I don't even know if the memory space is flat, or
segmented: can I access maps through a value set to dst+offset, or
must I always used index? I'm just very confused.

Sincerely,
Watson

--=20
Astra mortemque praestare gradatim

