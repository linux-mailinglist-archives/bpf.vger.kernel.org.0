Return-Path: <bpf+bounces-10705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF147AC650
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 04:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7CC45281DC6
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 02:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B947654;
	Sun, 24 Sep 2023 02:46:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609619B
	for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 02:46:39 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFF210C
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 19:46:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692779f583fso2616486b3a.0
        for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 19:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695523597; x=1696128397; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UUfFHuKVjM5JOni2b5J9b/IsHZrumQoMr1+fGJ0xnKM=;
        b=kr5dG5ffkP4ScmF5g3g3Llj6uFhgYOM0m9tV/PlG3fbJHLhpkmaCxNlVd3ksyTj7RQ
         jS0Xa6KuU8/2OtsvbpdTqoymdDLXJwAlS8fG/FHY35pOvrujHiDmQmCsNB13EIh8gH58
         LmY8RcELnmpHtS4KOAJpd8HCvHvfdr04BuhGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695523597; x=1696128397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUfFHuKVjM5JOni2b5J9b/IsHZrumQoMr1+fGJ0xnKM=;
        b=tTd/+dQ6HcoBLoOiNyHeLLtDeT4EjTuVPb5kVBM2h/H1qhGRhLkbZfhCfKrmUKqzyp
         IPQH8e6bJR+WpFW+pMLf8oW5hQZVBI9aMNe0g5FRUARkYjj11CGgNXQ2PDg6nUOsHPNc
         pdQquBKXyUdfRJuWBgdjWp2yezTdn7UIqsaaSMXeikK8p/HLn4h/Mw1gJiVImkNTdC+w
         qD4w5TQ228ah4aua0MPyVZC/p3npallxDHDH1n0xkBq1iRSZmUy1bAczPJFxYV0zPkR0
         HMtrv6x/8qIcDgLjVWhUq1tKEy7Wd0sMh+IUJu0VPQhK8WJA5AW6TwucRwyr0aKIBF0v
         BweQ==
X-Gm-Message-State: AOJu0YwhuOoKPxn8SgItVkrn/ekQXq+2I58TTxGble3gKwANvX4caozB
	0N09AaKSeTkMIzAf8z3KFbo3XQ==
X-Google-Smtp-Source: AGHT+IEkhicNhbG2SYATOjifWSwE2fbbZegRCyhHcmD3QB2yNh/5t73V/1gziA4II4SKjRvczT0fRA==
X-Received: by 2002:a17:902:ec85:b0:1c0:9d6f:9d28 with SMTP id x5-20020a170902ec8500b001c09d6f9d28mr2886607plg.11.1695523597125;
        Sat, 23 Sep 2023 19:46:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b001c3bc7b8816sm6045723plb.284.2023.09.23.19.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 19:46:36 -0700 (PDT)
Date: Sat, 23 Sep 2023 19:46:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
	renauld@google.com
Subject: Re: [PATCH v4 0/5] Reduce overhead of LSMs with static calls
Message-ID: <202309231925.D9C4917@keescook>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
 <20230922184224.kx4jiejmtnvfrxrq@f>
 <CACYkzJ67gw6bvTzX6wx_OtxUXi6kpVT196CXV6XCN1AaGQuKAw@mail.gmail.com>
 <CAGudoHE+od5oZLVAU4z3nXCNGk6uangd+zmDEuoATmDLHeFLGQ@mail.gmail.com>
 <CAGudoHFiVLmaMbFJno47_-x3Rs2tvgXNKyNznJeCq_cF8hFVvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFiVLmaMbFJno47_-x3Rs2tvgXNKyNznJeCq_cF8hFVvA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 23, 2023 at 07:15:05PM +0200, Mateusz Guzik wrote:
> On 9/23/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > On 9/23/23, KP Singh <kpsingh@kernel.org> wrote:
> >> On Fri, Sep 22, 2023 at 8:42 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >>>
> >>> On Fri, Sep 22, 2023 at 04:55:00PM +0200, KP Singh wrote:
> >>> > Since we know the address of the enabled LSM callbacks at compile time
> >>> > and only
> >>> > the order is determined at boot time, the LSM framework can allocate
> >>> > static
> >>> > calls for each of the possible LSM callbacks and these calls can be
> >>> > updated once
> >>> > the order is determined at boot.
> >>> >
> >>>
> >>> Any plans to further depessimize the state by not calling into these
> >>> modules if not configured?
> >>>
> >>> For example Debian has a milipede:
> >>> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"
> >>>
> >>> Everything is enabled (but not configured).
> >>
> >> If it's not configured, we won't generate static call slots and even
> >> if they are in the CONFIG_LSM (or lsm=) they are simply ignored.
> >>
> >
> > Maybe there is a terminology mismatch here, so let me be more specific
> > with tomoyo as an example.
> >
> > In debian you have:
> > CONFIG_SECURITY_TOMOYO=y
> >
> > CONFIG_LSM, as per above, includes it on the list.
> >
> > At the same time debian does not ship any tooling to configure tomoyo
> > -- it is compiled into the kernel but not configured to enforce
> > anything.
> >
> > On stock kernel this results in tons of calls to
> > tomoyo_init_request_info, which are quite expensive due to an
> > avoidable memset thrown in, and which always return
> > tomoyo_init_request_info.
> >
> 
> Erm, which always return TOMOYO_CONFIG_DISABLED.
> 
> > Does not look like your patch whacks this problem.
> >
> 
> So I am asking if there are plans to make these modules get out of the
> way if they have nothing to do, like tomoyo in the example above.
> 
> Of course preferably distros would not make these weird configs, but I
> suspect this ship has sailed.

This is an artifact of the existing stacking behavior (and solving it,
if needed, can be done in parallel to this series). Specifically it
seems Tomoyo is in the "lsm=" list when it shouldn't be.

That said, I've long advocated[1] for a way to explicitly disable LSMs
without affecting operational ordering. I think it would be very nice to
be able to boot with something like:

lsm=!yama

to disable Yama. Or for your case, "lsm=!tomoyo". Right now, you have to
figure out what the lsm list is, and then create a new one with the
LSM you want disabled removed from the list. i.e. with v6.2 and later
check the boot log, and you'll see:

LSM: initializing lsm=lockdown,capability,landlock,yama,integrity,apparmor

If you wanted to boot with Yama removed, you'd then pass:

	lsm=lockdown,capability,landlock,integrity,apparmor

As a boot param. But I think this is fragile since now any new LSMs will
be by-default disabled once a sysadmin overrides the "lsm" list. Note
that booting with "lsm.debug=1" will show even more details. See commit
86ef3c735ec8 ("LSM: Better reporting of actual LSMs at boot").

So, if a distro has no support for an LSM but they want it _available_
in the kernel, they should leave it built in, but remove it from the
"lsm=" list. That's a reasonable bug to file against a distro...

-Kees

[1] https://lore.kernel.org/linux-security-module/202210171111.21E3983165@keescook/

-- 
Kees Cook

