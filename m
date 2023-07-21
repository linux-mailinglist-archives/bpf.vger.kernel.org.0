Return-Path: <bpf+bounces-5595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD775C268
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 11:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B298A282208
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CAD14F7D;
	Fri, 21 Jul 2023 09:05:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022F14F65
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 09:05:47 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E675A2D7F
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 02:05:45 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6355e774d0aso13525056d6.1
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689930345; x=1690535145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGdh3HP/56gHWnpAO+CG8qKBy6qVgyh+uyUdODRLnwE=;
        b=LlBBjk8LEYBUA5c5dzGrSV+Zo+auU4/6dhJol3Acwgjx+TAlgc3Iqte2uX18w1coD2
         e9a5Qz61G6kOmDiB4fOSLR7qCy8LzXQtooEw3PfokTxif3AU4hJ9sFHQlx8LSnVdspyK
         HCwDk1QSmTdMbzX23Yak1H46Wyd+iZJGJvLqiQP4K79pA9EX+lEieNM+QtOq72MDcCwQ
         fqDRHr0fkV/hvccsTopyitPjM2t3IBbYBujK3bpH04m7rnXKvPK0gMkBjTnuV8tKJaE9
         LjReU2L2O7ZJuB+NZW7VD47AtZ7xJMk59/ykAN8JTOUxLyCH0+9WAGXhTmUNqd7N7HyM
         qaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689930345; x=1690535145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGdh3HP/56gHWnpAO+CG8qKBy6qVgyh+uyUdODRLnwE=;
        b=L8Kn/TQsp76lN/0cj13HiaQjxGfXC3yogKrr1dKcbh7uzcrLQmiXkNZAgKABQOdgyY
         4OwM30oMX9A1TnX5Z9EVrjnmX9XnOvD3Y0O2hOYuNEIyMCHxwp3PvbD70JFf0zFFNs5i
         rnwhyfJRrpS62To1l1jATlWj5U5JasO3xZVMHb9pzi+LgBHfQlUSmbjKpCxCbpTjCuVJ
         cApmiLeE8YU9Qx1C/5iEplTl9j0HUo+a8YmnAXw4Mdnb1oUIIAHXZaWClr8Vz5498Q7k
         C4Cf4K7GXxlpQLjzmyFI00HuUymbhwB6a2AQoCQjqiOIWNWNUgMyduCliCuIAKPqdi9T
         +0PQ==
X-Gm-Message-State: ABy/qLZtHI57J7Kk7ufrOANJ2z8cJ3nGrD4FwUQ9FhgFZvlyay7DPJo5
	i6osv0evzhJbTCpiRk+ymXjnjRSeHp4dd93tDC/VzxCPqM9oGdWf
X-Google-Smtp-Source: APBJJlHa90mOhblKAxVOvDxGzz990zLHeJs+Ac63bDSsQzXPe/sHv1xdEMqAp3tRvB/f8PAS5+d1aoJ1izf5z4cSzVQ=
X-Received: by 2002:a0c:b248:0:b0:623:9ac1:a4be with SMTP id
 k8-20020a0cb248000000b006239ac1a4bemr1420241qve.12.1689930344915; Fri, 21 Jul
 2023 02:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720113550.369257-1-jolsa@kernel.org> <20230720113550.369257-6-jolsa@kernel.org>
 <CALOAHbB3_qTzi+2_0=pFjyDXFUh_MGMJt6gz7eh0Z=He4guPow@mail.gmail.com>
 <20230721083140.GA10521@redhat.com> <20230721085426.GA10987@redhat.com>
In-Reply-To: <20230721085426.GA10987@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 21 Jul 2023 17:05:08 +0800
Message-ID: <CALOAHbA==q_6i4t1E+zKSSgkZ3ALTcGYcwa7ghidOXDi2n8mqg@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 05/28] bpf: Add pid filter support for
 uprobe_multi link
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 4:55=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Sorry for noise, apparently I haven't woken up yet,
>
> On 07/21, Oleg Nesterov wrote:
> >
> > Or. We can simply kill uprobe_multi_link_filter(). In this case uprobe_=
register()
> > can touch CLONE_VM'ed mm's we are not interested in, but everything sho=
uld work
> > correctly.
>
> please ignore CLONE_VM'ed above, I have no idea why did I say this...
>
> Yes, everything should work "correctly", but if you add a probe into (say=
) libc.so,
> every task will be penalized, so I don't think this is a good option.
>

Thanks  for your explanation.
Currently we can filter out the tgid in bpf prog, but if we could
filter out it earlier, the prog won't be triggered, that would take
less overhead.
However, it is fine by me if tgid won't be supported.

--=20
Regards
Yafang

