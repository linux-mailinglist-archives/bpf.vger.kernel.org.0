Return-Path: <bpf+bounces-21974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C11854CD0
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031EF1F26E3A
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D655FDCE;
	Wed, 14 Feb 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1EBC5M9Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E435F848
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924622; cv=none; b=rpuaTNwuYUlwKMD7dnf4MTLddKgid9C8VmOqH2T42CDXgDosI8/2FfiDrNXvbRb7FAbWU4irh0sS0GKDimORK2bMnTGra3aOdizyh3MT2bKopdUUrj85WK1wSVpklxtF5njnmgOoNSQxxBumCGUG19rTXdgLEY5Yvp1Qff2zseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924622; c=relaxed/simple;
	bh=WrkguPar9ql3C3T5wMJtZ7lUXaJANSRNogIEho1Ui3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUlYUxu3STHhgQ4MUEbAj73Irem0QnCUK+mcgeogtjSBphC51a9Tns3GLEqqEjFqnClCeknsDOl5uZpjjIdinvgxYX36godJjo2BpY0eMali8T3tDmKbwjTmMnKOAsGBsPbzOax4SMnB/R+/cCRCyfTtAFRbpNu/Z1uAGVhAgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=1EBC5M9Y; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60757c46e34so20804257b3.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707924620; x=1708529420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqCerqF3ja6QnWQP2aiud2hCV1tCK6BCZ35Lnyt8050=;
        b=1EBC5M9YFjG9IhoZ6UffwWeUn7zTcbDeA723Zg1Vl0BLZriwzUXzNMKOwkw+3bo9fn
         6l3LHPMkUkVL5i+f8NovPkNzDt/8304+1XIdnRzfjZ5FibqmpSqJv+HM9Pj/OW7Ju6AJ
         cD0/r8Ej+7n0mfMlEuzAJ+wVhuLtBqiIydgvHY0zFDbKfGAi6/k0LV2YXtyG7QVvCasx
         jwRAJ2vr2ieIulBJ/3TVOPYnRQuOap4zELX8IPlma0eim7JYlWXMUARoTEjzeAGjr+xr
         hoYInQCR0QZ/JTuJhD5+XXQ3PYSPmvNQppzCU+eK+PfHs5AzymVCJlOQGgQnaJYefkjJ
         0NUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924620; x=1708529420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqCerqF3ja6QnWQP2aiud2hCV1tCK6BCZ35Lnyt8050=;
        b=Pyb5yFV652gQCgw5hFbUPSapaS0O1X2j+/SWIkwaAyU4GMRYTWvCLq1iySVNn8XhLs
         DtFGIe5iscQ8jnwTHRo8zuJ99nEHQbSz8wrrbjKXQ4GbSbtn1e5PoAQznSNjGHXyFP7U
         J95TwugGoOI51cqydZpUXTlt2RIH9lubpY6jj9yFxfMHLkeiGtUV2aB0hlbo8BG6021Q
         FT8eNzmKtadYxUo3/cBw8oc72NVgS2sTU/J396VYchRXGwCRALK7we7uc/vXTGed8+Ws
         v49GL8EpAFcxOokWY9YF7GPJ3L7z0PTtf3kA5DazxWiIzeizXVr5DN7p/71oHQpssmbw
         GIpg==
X-Forwarded-Encrypted: i=1; AJvYcCWlYW0YewIBw7Yc/0+hVc1lRp4QB7itjI9uGJu/Sb8Gwj6Uu4YyjKsxJaASaxKJ8UErWAh1pjP95I41Lj1u8cDhTcH8
X-Gm-Message-State: AOJu0Yzj2mFnx+bqwFd5DmKCRMy+psjUChn9B3B9f4fyFh5M5IM+b5bF
	3swhkzt06KNCRVbp/ubP1ILxQbIK7MlS1Z+rMHPDQZnpZjxIXLVBAuYlXHrgg599k2WZ2UFYH91
	t3sP8PV3H87ami2gLt441ujbfe4peIrL9VOPD
X-Google-Smtp-Source: AGHT+IEyD0lWziPyy9rHNuxr7JUQQsbhZsIy0Eykcr8qscAtKVGIFIBi5+hcqzDkdAhpAIyLPHStwMTQAnxzTvV39JE=
X-Received: by 2002:a0d:cb4d:0:b0:604:a0e0:5863 with SMTP id
 n74-20020a0dcb4d000000b00604a0e05863mr3294321ywd.21.1707924619774; Wed, 14
 Feb 2024 07:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-9-jhs@mojatatu.com>
 <CALnP8ZZAjsnp=_NhqV6XZ5EaAO-ZKOc=18aHXnRGJvvZQ_0ePg@mail.gmail.com>
 <CAM0EoM=CKAGm=qi0pxAvJBOR0aQyHDR4OkBsfyg+DcaQqOUD6g@mail.gmail.com> <CA+JHD91MqtsyrBD=OheYio7bddrqKGtXjgiC7oJDGQjpFU17iQ@mail.gmail.com>
In-Reply-To: <CA+JHD91MqtsyrBD=OheYio7bddrqKGtXjgiC7oJDGQjpFU17iQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 14 Feb 2024 10:30:08 -0500
Message-ID: <CAM0EoMm7JDwa_1qavJWwM=2e8TsX=zJQsToFaEHuf0zkWrm74Q@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 08/15] p4tc: add template pipeline create,
 get, update, delete
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Marcelo Ricardo Leitner <mleitner@redhat.com>, netdev <netdev@vger.kernel.org>, 
	deb.chatterjee@intel.com, anjali.singhai@intel.com, namrata.limaye@intel.com, 
	tom@sipanda.io, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, Cong Wang <xiyou.wangcong@gmail.com>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	mattyk@nvidia.com, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:27=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Mon, Feb 12, 2024, 11:30 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>
>> On Fri, Feb 9, 2024 at 3:44=E2=80=AFPM Marcelo Ricardo Leitner
>> <mleitner@redhat.com> wrote:
>> >
>> > On Mon, Jan 22, 2024 at 02:47:54PM -0500, Jamal Hadi Salim wrote:
>> > > @@ -39,6 +55,27 @@ struct p4tc_template_ops {
>> > >  struct p4tc_template_common {
>> > >       char                     name[P4TC_TMPL_NAMSZ];
>> > >       struct p4tc_template_ops *ops;
>> > > +     u32                      p_id;
>> > > +     u32                      PAD0;
>> >
>> > Perhaps __pad0 is more common. But, is it really needed?
>> >
>>
>> $ pahole -C p4tc_template_common net/sched/p4tc/p4tc_tmpl_api.o
>> struct p4tc_template_common {
>>         char                       name[32];             /*     0    32 =
*/
>>         struct p4tc_template_ops * ops;                  /*    32     8 =
*/
>>         u32                        p_id;                 /*    40     4 =
*/
>>         u32                        PAD0;                 /*    44     4 =
*/
>>
>>         /* size: 48, cachelines: 1, members: 4 */
>>         /* last cacheline: 48 bytes */
>> };
>>
>> Looks good for 64b alignment. We can change the name.
>
>
> I bet that is you just remove PAD0 the compiler will introduce our for yo=
u.
>

True dat.

> Doing it explicitly documents explicitly tho.

Documentation justifies it - so we'll leave it there.

cheers,
jamal

> - Arnaldo
>>
>>
>> > > +};
>> >
>> > Only nit.
>> >
>> > Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>>
>> Thanks for this and all the other reviews. Much appreciated!
>>
>> cheers,
>> jamal
>>

