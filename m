Return-Path: <bpf+bounces-17824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF25781314B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C682831D9
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3340355C04;
	Thu, 14 Dec 2023 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbXxgTl+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2624F5
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 05:21:42 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67ad891ff36so51258316d6.1
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 05:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702560102; x=1703164902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGdkfb+XfM8nDsAl04TwR4cYwjQjWMVYXijDOO5pKqk=;
        b=jbXxgTl+l3+YYnLQrke/sflPBUeBOUXPM4RpY7PBuAvkMoW9DCITsl4FRWPLf0nckI
         MOcvG5sFjRyge4SPeNRIOsCkHb7aexIowr+ZksVGIH30DFgvmSkI+EKMCXtwCpD9R3of
         vo8db44+0hBD2W7FCEmUYWjcAzjEkKIRnVfvAVJCeeCqfC/fTzXoBaWDQ55HthzpJmbU
         CSgGgYFAIWvtMn1ZQXF/k3u2pDWj89kjljDoU4A+78QgpSfkyr01gtrLVBWEf+YhhydX
         0uMP/TtDqOZ4sYsEaPYQtKLwObU4/MJqfnwdrXWEqSUst1mNGoqA0ZzOvgaGALKQLPjX
         YRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560102; x=1703164902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGdkfb+XfM8nDsAl04TwR4cYwjQjWMVYXijDOO5pKqk=;
        b=CIRbegQawALP028cShKvAzd3bBJInh1VMctuT0pt2hDassYNGdQgF+CwXmzDSPPojD
         xIaxHHYhPZ0/byN2rAM6PlUXHQgqnyhJhWr+r4/ZJY98+GIxXpGS28IIwzTpxWaW/d3/
         t4uHPp5BLtxtycf2aElo0zSjIpQ3IKwUWRl7EgSPDXs2XGqJbcPjrYHiLtX9FK44Pc3I
         O+/papJtSy2c1eAbztBnvyvWcGlN9ko7wFpP6Jt6UcECwVFzRFExoPMESwXdd/DgjsH8
         QSCV+VT4nVoTmxXWKO7uRvLRMpmdYaSivL5+pnT+RrvhvqKteP3BrhopmO3jt2qb0Tvf
         WrkQ==
X-Gm-Message-State: AOJu0YzVZQk2uJkzVf62TtPsa/2/PxVKFzYFPAXHzy51gXCTgk3NpkWk
	eP1wIAm7t4AEaXNnlM+UxfIOWg5GVSN9E/y1xZ4=
X-Google-Smtp-Source: AGHT+IGy8MHKMW9jtMJvQNAgbSwhJGDtgRrw4l09omeJ3LAdbMfLmNDNm45Ic330rMSSRE5hHl7Xv2So/qj+nXEztsM=
X-Received: by 2002:a05:6214:2607:b0:67f:770:cb16 with SMTP id
 gu7-20020a056214260700b0067f0770cb16mr1859779qvb.121.1702560101867; Thu, 14
 Dec 2023 05:21:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214120716.591528-1-dave@dtucker.co.uk> <CALOAHbDzZ_KU05jq+Z_j29gzfSFQTnspnGK3c0iH=4xRQ3ct8g@mail.gmail.com>
In-Reply-To: <CALOAHbDzZ_KU05jq+Z_j29gzfSFQTnspnGK3c0iH=4xRQ3ct8g@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 14 Dec 2023 21:21:05 +0800
Message-ID: <CALOAHbARerbgJy-ujXwbD=f4mqmO1WXTk+33Qjkhqg4rn_6nzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Include pid, uid and comm in audit output
To: Dave Tucker <dave@dtucker.co.uk>
Cc: bpf@vger.kernel.org, Dave Tucker <datucker@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 9:13=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Dec 14, 2023 at 8:07=E2=80=AFPM Dave Tucker <dave@dtucker.co.uk> =
wrote:
> >
> > Current output from auditd is as follows:
> >
> > time->Wed Dec 13 21:39:24 2023
> > type=3DBPF msg=3Daudit(1702503564.519:11241): prog-id=3D439 op=3DLOAD
> >
> > This only tells you that a BPF program was loaded, but without
> > any context. If we include the pid, uid and comm we get output as
> > follows:
> >
> > time->Wed Dec 13 21:59:59 2023
> > type=3DBPF msg=3Daudit(1702504799.156:99528): pid=3D27279 uid=3D0
> >         comm=3D"new_name" prog-id=3D50092 op=3DUNLOAD
>
> Is it possible to integrate these common details like pid, uid, and
> comm into the audit_log_format() function for automatic inclusion? Or
> would it be more appropriate to create a new helper function like
> audit_log_format_common() dedicated specifically to incorporating
> these common details? What are your thoughts on this?

BTW, bpf prog can be unloaded in irq context. Therefore we can't do it
for BPF_AUDIT_UNLOAD.

--=20
Regards
Yafang

