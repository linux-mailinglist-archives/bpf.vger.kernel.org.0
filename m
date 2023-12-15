Return-Path: <bpf+bounces-17950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C192F8140A8
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 04:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FCC1F22F5E
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB895382;
	Fri, 15 Dec 2023 03:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqxcnsDs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63064566C
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336417c565eso143091f8f.3
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 19:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702611113; x=1703215913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCO0FrOZh37NR4IB3C1qSPzfnG/+tiqsccd0i13BeU8=;
        b=CqxcnsDsHNkOeJhtcSgLgecn1W8scCRhxUByPkoDWIs15DX4HC2xN1nrVuQzu34xWK
         LrF2kjDunHKFcIHurOWjzjd8fU2Hm3LQgrYNhQ/CeT90muc3XzeCnNj4xt+VPZ2pKFtF
         +/Zqxvgf+l5N20SsrYFJztVgnr6rxclhmmWV7yLoroeW9VW590CszkQOUeaSVjVfGNxE
         DlJRmpo+lodLxekkSTMAWY2QtjqzZQxy52qluQ4tgsVvWQoJeJtDdq/NplWTZuU7RO3R
         1cIwA2AvJ8Vomh73SGtiTyVybrco8clh7x5oQThGUHbf5oMrZqOrWbdYz2P9lzhletag
         rCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702611113; x=1703215913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCO0FrOZh37NR4IB3C1qSPzfnG/+tiqsccd0i13BeU8=;
        b=P4JcwjLPWjZFtdngX/dTL+uIiZW9U2lWFHgi9z5UwuPvD2Q0NMMy2K9JrYYJacjeiX
         ahPMNNJeRxtwiWvZ+fSg1rNp0d+/ObIGC9v863Lwlx3jZhazoB4WNBF7SGwEEzFtd1V6
         ynCwDcFM4mCzj+L0g7zQi+TFP3CsQ4g/K7bZqugWjJF0wg/D5lP5XNdQF1GeGjtevZEg
         KDx9btFn9P6L+CSXK9GFXkAEXwmPWJwE8oinHFwegf6fW51NfEsVW/N7uttpKa211Lul
         M1eZc2nAXF3EXgGnZm3QM9VfDH01+A+wo87J93AGW2arKife9xZxhgF8BzOZr+5yqk3S
         1tnA==
X-Gm-Message-State: AOJu0YwOvtyx5wZ+liixYXj3rQqQ3g3/NAdW6XSo5MEpen1BR+TxqJhi
	HFfkDvTNbgbF2dDlkO4Cj2xtFch1EiZBdDVm3k0=
X-Google-Smtp-Source: AGHT+IEtKWDW1s9czPsciMkYhTZAr2iTLZQsph3c1ZOPBqhKsejuu97n13mrlhtoSDBUeTD/f8mrZu0jJoigZWUPle8=
X-Received: by 2002:a5d:5191:0:b0:333:1adc:a381 with SMTP id
 k17-20020a5d5191000000b003331adca381mr4091508wrv.31.1702611113161; Thu, 14
 Dec 2023 19:31:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214120716.591528-1-dave@dtucker.co.uk> <CALOAHbDzZ_KU05jq+Z_j29gzfSFQTnspnGK3c0iH=4xRQ3ct8g@mail.gmail.com>
 <CALOAHbARerbgJy-ujXwbD=f4mqmO1WXTk+33Qjkhqg4rn_6nzg@mail.gmail.com>
 <10E0052D-E706-4395-A2EE-C1BD0BE54DD0@dtucker.co.uk> <CALOAHbAS4NZAdsx9ssurNsN+HLAitaETd50Ua5dOzP02KPRh0A@mail.gmail.com>
In-Reply-To: <CALOAHbAS4NZAdsx9ssurNsN+HLAitaETd50Ua5dOzP02KPRh0A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 19:31:41 -0800
Message-ID: <CAADnVQJi1mezWL6BKn=Vw4quev3pgLOW9q3Yz9GF=LjzZoHp6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Include pid, uid and comm in audit output
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Dave Tucker <dave@dtucker.co.uk>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 6:33=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Dec 14, 2023 at 10:11=E2=80=AFPM Dave Tucker <dave@dtucker.co.uk>=
 wrote:
> >
> >
> >
> > > On 14 Dec 2023, at 13:21, Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > On Thu, Dec 14, 2023 at 9:13=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > >>
> > >> On Thu, Dec 14, 2023 at 8:07=E2=80=AFPM Dave Tucker <dave@dtucker.co=
.uk> wrote:
> > >>>
> > >>> Current output from auditd is as follows:
> > >>>
> > >>> time->Wed Dec 13 21:39:24 2023
> > >>> type=3DBPF msg=3Daudit(1702503564.519:11241): prog-id=3D439 op=3DLO=
AD
> > >>>
> > >>> This only tells you that a BPF program was loaded, but without
> > >>> any context. If we include the pid, uid and comm we get output as
> > >>> follows:
> > >>>
> > >>> time->Wed Dec 13 21:59:59 2023
> > >>> type=3DBPF msg=3Daudit(1702504799.156:99528): pid=3D27279 uid=3D0
> > >>>        comm=3D"new_name" prog-id=3D50092 op=3DUNLOAD
> > >>
> > >> Is it possible to integrate these common details like pid, uid, and
> > >> comm into the audit_log_format() function for automatic inclusion? O=
r
> > >> would it be more appropriate to create a new helper function like
> > >> audit_log_format_common() dedicated specifically to incorporating
> > >> these common details? What are your thoughts on this?
> >
> > There's audit_log_task_info from audit.h which adds everything. My
> > concern was that it is very verbose and doesn=E2=80=99t appear to be wi=
dely
> > used. I don=E2=80=99t think it warrants a helper function just yet sinc=
e
> > we=E2=80=99re only doing audit logging in this one function.
> >
> > That said, I=E2=80=99m working on a patch series to add audit logging t=
o
> > bpf_link attach and detach events. I=E2=80=99ll gladly turn that into a
> > helper then since it would be used in more than one place.
> >
> > > BTW, bpf prog can be unloaded in irq context. Therefore we can't do i=
t
> > > for BPF_AUDIT_UNLOAD.
> >
> > I=E2=80=99ve been running this locally, and occasionally I see unload e=
vents
> > where the comm is =E2=80=9Ckworker/0:0=E2=80=9D - I assume that those a=
re from within
> > the irq context.
> >
> > type=3DBPF msg=3Daudit(1702504511.397:202): pid=3D1 uid=3D0
> >     comm=3D"systemd" prog-id=3D75 op=3DLOAD
> >
> > type=3DBPF msg=3Daudit(1702504541.516:213): pid=3D23152 uid=3D0
> >     comm=3D"kworker/0:0" prog-id=3D75 op=3DUNLOAD
> >
> > That looks ok to me, but it wouldn=E2=80=99t be too hard to skip adding=
 this
> > information in the irq context if you=E2=80=99d rather.
>
> I believe we need to skip them. Including random task information
> could potentially lead to confusion.

Yep. It's broken.
We cannot access current_cred() from here. Current is a random task.

