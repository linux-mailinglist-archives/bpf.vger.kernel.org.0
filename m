Return-Path: <bpf+bounces-17324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF180B876
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 03:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF741C208EA
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC715B1;
	Sun, 10 Dec 2023 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqTBJz1q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA42E8;
	Sat,  9 Dec 2023 18:54:53 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77f320ca2d5so243816585a.1;
        Sat, 09 Dec 2023 18:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702176892; x=1702781692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwR4uGYepu+Nr3lhUkuSgATK19gcSNJEZP7NHHDdkLU=;
        b=cqTBJz1qclbi4nuhXEmDuylbeBWJZdYK9Yv8Q+cR2ZX7/zQwwds0CqEFZICoGDVkkI
         6VaPrVwbiWjR7cDAPTveYqhbCT30E66S5U+3lqxN7+AfczQ50K0FfsC07hgXQYFo5RFc
         ddAiIfsr8Bib71rBeVEIjk2YtEmw2KxDSuLA4wGMJxSherz5d4E/Yg36gyYSCgDRxi+3
         M059z1EDXF5ua90FP5kYSeXoVbWqAsfvLwMlcX/VOoRO0oSOZvzfsGuDKSZmsLQXIDcm
         tETd1vJxGgkVB817GyE49LsBmRAy3Aprwv3bk8EPbUASbUCS6rIgvKq+l4ADRqhO/SWi
         KDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702176892; x=1702781692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwR4uGYepu+Nr3lhUkuSgATK19gcSNJEZP7NHHDdkLU=;
        b=FE5933ChtQ50L1P+LaGuyFLWZ0DeL3eN0kES7By/zUWJkgq3mC6vLKfWWbo9IInB78
         nBUM54jLwU8hrNlfio+v17T3PFMm+3XPaAnoE8iOQ/8ztBe1BL9PskiRCQ6F1vtkoWst
         H1NlFLBxWrRi/uo4e+YEq2QHe/a4ANGUKd/JbCWkC+VafU8U7OqujNpjMDylqNP4gGfR
         e6OAfNg60q0gaxn8sUTeTjh/aNgWZfHbzUKXhtCCiJL5uh/akTBkTmzlGRXGN6Q4Yd3K
         2BUx42jlJAwnOd8EzGU12H7WX9bNjjFHLl3mWyFXQyM7Y46luZJJ95nDdHMnyiE+5ATM
         OGpg==
X-Gm-Message-State: AOJu0YzdvDLgHy00a/D56B6yvqE9X/J1UZMZd1b/vCQWUa0rbEvkUekP
	6hWWBvlWdz3d3eAiTg4rdzr9YZGf/ILJdjxRNGg=
X-Google-Smtp-Source: AGHT+IEvbV6qNzxC9Xc9qs9biDK/3+lzU1erJnhFYmM7PsxdUXSqWWA6SrEFEShB+OSDjYAb5LAaipsIuty6O5UwIxE=
X-Received: by 2002:a05:620a:3f08:b0:77f:383f:8ac0 with SMTP id
 tx8-20020a05620a3f0800b0077f383f8ac0mr3899262qkn.35.1702176892708; Sat, 09
 Dec 2023 18:54:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208090622.4309-1-laoar.shao@gmail.com> <20231208090622.4309-4-laoar.shao@gmail.com>
 <d049f5a1-29ac-4fd9-95b2-45d5fd5ecae5@schaufler-ca.com>
In-Reply-To: <d049f5a1-29ac-4fd9-95b2-45d5fd5ecae5@schaufler-ca.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 10 Dec 2023 10:54:16 +0800
Message-ID: <CALOAHbAYUYb9wcE9i364+jXEb2vF3dcET=7Ru+KOs8MUuO_Exw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] mm, security: Add lsm hook for memory policy adjustment
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, omosnace@redhat.com, mhocko@suse.com, ying.huang@intel.com, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 1:30=E2=80=AFAM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 12/8/2023 1:06 AM, Yafang Shao wrote:
> > In a containerized environment, independent memory binding by a user ca=
n
> > lead to unexpected system issues or disrupt tasks being run by other us=
ers
> > on the same server. If a user genuinely requires memory binding, we wil=
l
> > allocate dedicated servers to them by leveraging kubelet deployment.
> >
> > At present, users have the capability to bind their memory to a specifi=
c
> > node without explicit agreement or authorization from us. Consequently,=
 a
> > new LSM hook is introduced to mitigate this. This implementation allows=
 us
> > to exercise fine-grained control over memory policy adjustments within =
our
> > container environment
>
> I wonder if security_vm_enough_memory() ought to be reimplemented as
> an option to security_set_mempolicy(). I'm not convinced either way,
> but I can argue both.

The function security_vm_enough_memory() serves to verify the
permissibility of a new memory map, while security_set_mempolicy()
comes into play post-memory map allocation. Expanding
security_vm_enough_memory() to include memory policy checks might
potentially lead to regressions. Therefore, I would prefer to
introduce a new function, security_set_mempolicy(), to handle these
checks separately.

--=20
Regards
Yafang

