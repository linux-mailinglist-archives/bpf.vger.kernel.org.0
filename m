Return-Path: <bpf+bounces-18244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3606A817E08
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 00:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6E21C20DEC
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 23:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6CB740AB;
	Mon, 18 Dec 2023 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FwwqWwR+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8A768EF
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so2760987276.0
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 15:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702941602; x=1703546402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES2XANow3c4WFr3ElQ4CWmF6s3T3M4Np9YPYPvh1hCs=;
        b=FwwqWwR+X0cRcfH1xnsGrnEuXjU+ihHmv5ZogitjV/KS9qSKRCIEw2k3VvcaP1FNsk
         5qBUSpDGjnhde7h2X6X5BbR31cHKDGvfZiTarcbc/wkzk1tWxQgIqbNa4oRt3YQJFYmT
         vqzqY/QyzcyFfRPSstoiXiokVYOQr/hs5c1fE7fUnL+LEN0Jtd7a+4nCz9L0naztfvSA
         Bjpo5Iny6Qy7956S+FtAVEas/PYKK6JTFdJhK5mzXNy2IZUwF6V6VeLf5tLZN/D0OkJC
         QfZ/a2gD/zzG2007MIfj0Aa2f0l1aBJF/invxb0mg8jvwPuticXMtKPv8lLLCsLqHtRl
         EepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702941602; x=1703546402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES2XANow3c4WFr3ElQ4CWmF6s3T3M4Np9YPYPvh1hCs=;
        b=H7THAOa2VIyCPxzK3HHBmNWwkeqtoncbG6OFmKl+NOu5qkHR1OygT2xmMy1PJ9Bozk
         uQVr698t67YZ3jTnp54E/iWYBs1EqVMwHTZWLEBAFpa3G6A1XPjeRIAmaHZC650U7ur+
         54uWggkU4ASrpQPL1uHQHlcAEhwdP7XfIQOVgN5dbFD+Fi9kVGlUj/ASJczQWEWm1/qe
         cobdLm07mYEtVJZOmfgs4TGNOE9eFm/dSIMUBOYoL8t/c1Yd2H7BDVQBQBDN4TmiqbON
         HvvCdXhD/MRmuijCRH0t6BZplvZVBHg0BlgNC+/Lzjk2cG9xMCJmT2doImHlg9YzIH2K
         J0GA==
X-Gm-Message-State: AOJu0YywsGyWDkqFi9cGHwPBafhcg9HDHxsDDtidpQh+P7J4cKAkddqH
	6orDNa+qiW2XKTBnYYhjsZHVw6poPuy1kfBwsgBX
X-Google-Smtp-Source: AGHT+IGaOKY2VunMABSbe2HaT0zbdWVLY+2e0+B87FL6/BRvm07tXEU9RjPz2vEIJSGb6hdjk1jvH4lrchey9F4KY2U=
X-Received: by 2002:a05:6902:278a:b0:dbc:f900:a343 with SMTP id
 eb10-20020a056902278a00b00dbcf900a343mr3094031ybb.54.1702941601894; Mon, 18
 Dec 2023 15:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09e4992c-9def-41b5-a806-2978b3ae35c6@I-love.SAKURA.ne.jp>
In-Reply-To: <09e4992c-9def-41b5-a806-2978b3ae35c6@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Dec 2023 18:19:50 -0500
Message-ID: <CAHC9VhR_27_LtskFF_0Bzb_9R5r0NRvdW0z0bd9iU8JBOe+HPA@mail.gmail.com>
Subject: Re: [RFC PATCH v3] LSM: Officially support appending LSM hooks after boot.
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, renauld@google.com, 
	Paolo Abeni <pabeni@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 3:28=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Commit 20510f2f4e2d ("security: Convert LSM into a static interface") has
> unexported register_security()/unregister_security(), with the reasoning
> that the ability to unload an LSM module is not required by in-tree users
> and potentially complicates the overall security architecture.
>
> After that commit, many LSM modules have been proposed and some of them
> have succeeded in becoming in-tree users. Also, Linux distributors starte=
d
> enabling some of in-tree LSM modules in their distribution kernels.
>
> But due to that commit, currently in order to officially use an LSM
> module, that LSM module has to be built into vmlinux. And this limitation
> has been a big barrier for allowing distribution kernel users to use LSM
> modules which the organization who builds that distribution kernel cannot
> afford supporting.
>
> Therefore, as one of in-tree users, I've been asking for ability to appen=
d
> LSM hooks from LKM-based LSMs (i.e. re-export register_security()) so tha=
t
> distribution kernel users can use LSMs which the organization who builds
> that distribution kernel cannot afford supporting.
>
> Paul Moore believes that we don't need to support appending LSM hooks fro=
m
> LKM-based LSMs because anyone who wants to use an LSM module can recompil=
e
> distributor kernels with that LSM enabled. But recompiling kernels is not
> a viable option for regular developers/users [1]; the burden of
> distributing rebuilt kernels is not acceptable for individual LSM authors
> and majority of Linux users, and the risk of replacing known distributor'=
s
> prebuilt kernels with unknown individual's rebuilt kernels is not
> acceptable for majority of distributor kernel users. If Endpoint Detectio=
n
> and Response software (including Antivirus software) could not be used
> without replacing distributor's prebuilt kernels, Linux would not have be=
en
> chosen as a platform. Being able to use whatever functionality using
> prebuilt distribution kernel packages and prebuilt kernel-debuginfo
> packages is the mandatory baseline. Therefore, in order to unofficially u=
se
> LSMs which are not built into vmlinux, I've been maintaining AKARI (which
> is a pure LKM version of TOMOYO) as an LKM-based LSM which can run on
> kernels between 2.6.0 and 6.6.
>
> I was planning to propose ability to append LSM hooks from LKM-based LSMs
> (i.e. re-export register_security()) so that distribution kernel users ca=
n
> use LSMs which the organization who builds that distribution kernel canno=
t
> afford supporting, after Casey Schaufler finishes his work for making it
> possible to enable arbitrary LSM combinations. But before Casey's work
> finishes, KP Singh started proposing "Reduce overhead of LSMs with static
> calls" which will make AKARI more difficult to run because it removes
> security_hook_heads. Therefore, reviving ability to officially append LSM
> hooks from LKM-based LSMs became an urgent matter.
>
> KP Singh suggested me to try eBPF programs because BPF LSM is enabled in
> distributor's prebuilt kernels. But the result was that eBPF is too
> restricted to emulate TOMOYO. Therefore, I still need ability to append
> LSM hooks from LKM-based LSMs.
>
> Since it seems that nobody has objection on not using an LSM module which
> calls LSM hooks in the LKM-based LSMs [2], this version directly appended
> the linked list into individual callbacks. KP Singh's "Reduce overhead of
> LSMs with static calls" proposal will replace security_hook_heads with
> array of static call slots, and mod_security_hook_heads will remain
> untouched.
>
> This patch implements only ability to add LSM modules after boot, for
> as far as we know, we haven't heard of requests for reviving the ability
> to remove LSM modules after boot.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Link: https://lkml.kernel.org/r/d759146e-5d74-4782-931b-adda33b125d4@I-lo=
ve.SAKURA.ne.jp [1]
> Link: https://lkml.kernel.org/r/93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-lo=
ve.SAKURA.ne.jp [2]
> ---
>  include/linux/lsm_hooks.h |   9 +++
>  security/security.c       | 134 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 143 insertions(+)

My objections presented in the v2 revision of this patchset remain.

--=20
paul-moore.com

