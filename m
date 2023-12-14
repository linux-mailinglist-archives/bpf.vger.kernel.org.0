Return-Path: <bpf+bounces-17838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E79A813330
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607D61C21B1D
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102959E5B;
	Thu, 14 Dec 2023 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/5WFHy+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3732E85
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 06:33:26 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-67ab16c38caso52082646d6.1
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 06:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702564405; x=1703169205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuPJEXHG/T8+UZ7zLGzCD0eZ+te2AgjoCbRUxXHDBsM=;
        b=W/5WFHy+374mrrmn6OUazZeZTn0z7n3ekquFM9zGboSAdwolP47mgBUMvy12k5dfnb
         o5z3TN5Th/uelWq6FOB/Qm7LvzObXs+0RmCLYdhKGyrShJP6BtF4kS35107uR9+hAfF8
         Fz49Bz/hD/gkyaiu71Df5FjIXsjX9W8XUxr9EQHF4LiJYzIPcoG4wlZW5+OlBLF2qDyg
         pjPrCWszxWr74vvOfb8bdV4B3nNpjXCFTu5yqe7LFIt4RI2XsYxYvjuv6WdGYgKGUzbZ
         tVAcvjWntSb6Ep5q2v/kGIoy/+gHW1MkH7DR09mBYFZ2HSwPyNOcIkEwHPHLRYmiF1VJ
         1e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702564405; x=1703169205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuPJEXHG/T8+UZ7zLGzCD0eZ+te2AgjoCbRUxXHDBsM=;
        b=iScdc6XN4dl9vA5SWqbch9qjrLUJ1fK/AFIzkqAIaYaqVJhhgtU95VNpd9xd0mt0NO
         Do41EBNhSnE3ahT4jFC1E5Ui9oM78H7mzgFrDTlJfE0ZS7lejdYknps0OZUwCYzDYT/q
         6PQqJpbP4aGhO1P/JURjvibZRZ3lPb8Dkt/3Y8S5MvkvrkQ6u7jT5IC4pBAuf34t2nZ/
         ciNHqj05WgMlgWWCkmG2VS/dCfke5Dh3pGvvZvPoybnl+mjQjwYkvSTiioP0EiNenwa0
         po0uDIgSahy2CIofrsGpH/7W/swBLIhoj6+ScpPUzXSepyNaYNHdpM3EGQhzDEnb9egp
         WNRA==
X-Gm-Message-State: AOJu0YwzAhxVvh8qkq+b6+G6/H+mEfy4PrmVJ6S+V7yU8sVBPOm7JCAe
	Zxl6n3mewJDZEhn1ZsvIH5jObJn0PgkMFWXLvA0=
X-Google-Smtp-Source: AGHT+IGZDkaPSE08Mg5khj5fiYP4/1T4OB66VghppvqzfYHasCs6f6NwjkrppTNTXA3GA/eRp76Ivaf2uo5dsy/ADVo=
X-Received: by 2002:a05:6214:2aa3:b0:67f:f06:573c with SMTP id
 js3-20020a0562142aa300b0067f0f06573cmr740449qvb.26.1702564405315; Thu, 14 Dec
 2023 06:33:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214120716.591528-1-dave@dtucker.co.uk> <CALOAHbDzZ_KU05jq+Z_j29gzfSFQTnspnGK3c0iH=4xRQ3ct8g@mail.gmail.com>
 <CALOAHbARerbgJy-ujXwbD=f4mqmO1WXTk+33Qjkhqg4rn_6nzg@mail.gmail.com> <10E0052D-E706-4395-A2EE-C1BD0BE54DD0@dtucker.co.uk>
In-Reply-To: <10E0052D-E706-4395-A2EE-C1BD0BE54DD0@dtucker.co.uk>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 14 Dec 2023 22:32:46 +0800
Message-ID: <CALOAHbAS4NZAdsx9ssurNsN+HLAitaETd50Ua5dOzP02KPRh0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Include pid, uid and comm in audit output
To: Dave Tucker <dave@dtucker.co.uk>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:11=E2=80=AFPM Dave Tucker <dave@dtucker.co.uk> w=
rote:
>
>
>
> > On 14 Dec 2023, at 13:21, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Thu, Dec 14, 2023 at 9:13=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> >>
> >> On Thu, Dec 14, 2023 at 8:07=E2=80=AFPM Dave Tucker <dave@dtucker.co.u=
k> wrote:
> >>>
> >>> Current output from auditd is as follows:
> >>>
> >>> time->Wed Dec 13 21:39:24 2023
> >>> type=3DBPF msg=3Daudit(1702503564.519:11241): prog-id=3D439 op=3DLOAD
> >>>
> >>> This only tells you that a BPF program was loaded, but without
> >>> any context. If we include the pid, uid and comm we get output as
> >>> follows:
> >>>
> >>> time->Wed Dec 13 21:59:59 2023
> >>> type=3DBPF msg=3Daudit(1702504799.156:99528): pid=3D27279 uid=3D0
> >>>        comm=3D"new_name" prog-id=3D50092 op=3DUNLOAD
> >>
> >> Is it possible to integrate these common details like pid, uid, and
> >> comm into the audit_log_format() function for automatic inclusion? Or
> >> would it be more appropriate to create a new helper function like
> >> audit_log_format_common() dedicated specifically to incorporating
> >> these common details? What are your thoughts on this?
>
> There's audit_log_task_info from audit.h which adds everything. My
> concern was that it is very verbose and doesn=E2=80=99t appear to be wide=
ly
> used. I don=E2=80=99t think it warrants a helper function just yet since
> we=E2=80=99re only doing audit logging in this one function.
>
> That said, I=E2=80=99m working on a patch series to add audit logging to
> bpf_link attach and detach events. I=E2=80=99ll gladly turn that into a
> helper then since it would be used in more than one place.
>
> > BTW, bpf prog can be unloaded in irq context. Therefore we can't do it
> > for BPF_AUDIT_UNLOAD.
>
> I=E2=80=99ve been running this locally, and occasionally I see unload eve=
nts
> where the comm is =E2=80=9Ckworker/0:0=E2=80=9D - I assume that those are=
 from within
> the irq context.
>
> type=3DBPF msg=3Daudit(1702504511.397:202): pid=3D1 uid=3D0
>     comm=3D"systemd" prog-id=3D75 op=3DLOAD
>
> type=3DBPF msg=3Daudit(1702504541.516:213): pid=3D23152 uid=3D0
>     comm=3D"kworker/0:0" prog-id=3D75 op=3DUNLOAD
>
> That looks ok to me, but it wouldn=E2=80=99t be too hard to skip adding t=
his
> information in the irq context if you=E2=80=99d rather.

I believe we need to skip them. Including random task information
could potentially lead to confusion.

--=20
Regards
Yafang

