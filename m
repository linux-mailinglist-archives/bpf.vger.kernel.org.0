Return-Path: <bpf+bounces-19326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE57829E16
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 16:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C31F1F246B4
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4B54C639;
	Wed, 10 Jan 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8AXadme"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C54C618;
	Wed, 10 Jan 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e89ba9810aso36029117b3.2;
        Wed, 10 Jan 2024 07:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704902213; x=1705507013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DI+npXWSjJ9YB5ByvvG7rDuKyTYIfKqn7ADFimqj44=;
        b=R8AXadmeA8/M/NcP4deoH0Dr2ALXeru+FzIbeQUYokDvVH4C4O9UlT7/Yhraqn23Pc
         5p5bqUiKFM7v8RQ1Q7JkfE0umPQ8jyFzWPH5cqpe9tE6JTHJC486Ebgpqg26CINDDDnr
         323SrShOUA7hu2fLL4Tz/eBGvjcwFka6WEz57Oy3bF/V7aZCFIZagCm+msuTa4YJNMlR
         LWrzh3erX8+Ncg5jObt9yeqmhjnZ9XO4RP1sActBQWAkelNip24o80NIOvF4WqyFC4Wu
         s/Gr3QvBnMTLAhX2Ht+aB7nH6TfZwvK0jJViLREAQiGEWE2tUAWENAmynvDYsbyI6uam
         qYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704902213; x=1705507013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DI+npXWSjJ9YB5ByvvG7rDuKyTYIfKqn7ADFimqj44=;
        b=ACzWYVm0ks8qLmGlUFTXdD/9H0GI16YNwMxwFnyQmPgxSeK+XN/kC5qc2Mp/qQ0XRL
         x7Eh6o/xgOmp6BJtqwEp/jvkq7xIEx4mISKK2UzzS7wV5BwxDGWhaSr+vnOX867cwRMp
         nZaigiCm5ByDv2s9YMuw1eVWwnVffzPrlbS4HDRUfQ4CZHfUfZG7SGZcfayJutmfemDH
         AbZSnRrQMlOpbzjBLYG+K1D5USyhk+2z3AEklfY/BgsJVWo4h3wwKCYyuhYy+kHmkBGZ
         B1SzdckcTVqB2qaN2OP5V8tdHxfbDaXC3utJn+msIZ2INAjJ1rEVKTHcLigQZStnJ3mR
         +H3g==
X-Gm-Message-State: AOJu0YwdsHdIBaqOqAA4l/jFAIgv2KJrc1wKYkWDcwZ9X3OvwsmjTTBf
	8uAv+qJjhxjVzwv1m4sD56Q8Ff433Nhd78UbCPA=
X-Google-Smtp-Source: AGHT+IETBWRf6c+mcQLuvf46V1Bdw9cgsY1dJgWJOngOToIg/wKH21YzoZ01FBzUJMganI1DDs+KtodHF4/dNznJOkE=
X-Received: by 2002:a0d:df83:0:b0:5d7:1940:53cd with SMTP id
 i125-20020a0ddf83000000b005d7194053cdmr1085899ywe.69.1704902212861; Wed, 10
 Jan 2024 07:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125033.4158-1-laoar.shao@gmail.com> <CAHC9VhTs_5-SFq2M+w4SE7gMd3cHXP2P3y71O4H_q7XGUtvVUg@mail.gmail.com>
 <CALOAHbDEoZ_gPNg-ABE0-Qc0uPqwHJBLRpqSjFd7fH6r+oH23A@mail.gmail.com>
 <CAHC9VhQkRPMO2Xpg0gYdpOPZTDrp1xKwU=idt9EQJg7Zi7XjqQ@mail.gmail.com>
 <CALOAHbA-aW5gHXuf4MZVDXqD89Ri=9Ff7wcnV5wnBe=+pjkLrQ@mail.gmail.com>
 <CALOAHbCqMZE2F9E+KdLtF=hw9_hEkhjAsHaCHaRwKYWU3wyDyA@mail.gmail.com> <CAHC9VhREmXPg2TgDcK+moeJv3AvDR1wKiKNEex0AX6cQAzhVjg@mail.gmail.com>
In-Reply-To: <CAHC9VhREmXPg2TgDcK+moeJv3AvDR1wKiKNEex0AX6cQAzhVjg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 Jan 2024 23:56:16 +0800
Message-ID: <CALOAHbCJdPdSjU2ab_s=CtAJ6VULpSZUMhEL2bcG0yAmE+quUA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] mm, security, bpf: Fine-grained control
 over memory policy adjustments with lsm bpf
To: Paul Moore <paul@paul-moore.com>
Cc: Kees Cook <keescook@chromium.org>, "luto@amacapital.net" <luto@amacapital.net>, wad@chromium.org, 
	akpm@linux-foundation.org, jmorris@namei.org, serge@hallyn.com, 
	omosnace@redhat.com, casey@schaufler-ca.com, kpsingh@kernel.org, 
	mhocko@suse.com, ying.huang@intel.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:28=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Jan 10, 2024 at 1:07=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> > Paul,
> >
> > Do you have any additional comments or further suggestions?
>
> No, I'm still comfortable with my original comments and stand by them.

I understand your perspective, but it seems I have to propose an
eBPF-based seccomp in the next step.

--=20
Regards
Yafang

