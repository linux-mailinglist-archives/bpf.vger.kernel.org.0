Return-Path: <bpf+bounces-14802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4047E8573
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 23:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECEB1C2099B
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF903D380;
	Fri, 10 Nov 2023 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMdOyKeI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9253C6A9
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 22:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69209C433CA
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699654808;
	bh=NZpHuyACLpRCUBOlVTQueBO3ak832TS3DuZ+jUL9vsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UMdOyKeIH7fz/uzH/ZqMUiB3JLxMFdQv4F7ZXcSPefPAnBZrmXoENytsZSyFk8syc
	 zlkSTTXm4l9DZz02NgSHhbFxeW4vMGb/Sqr+8efjgFtERvO2N9NoP38cqk+5sWPi9M
	 +Qijw0VPiwCvJaVQ1M//XWPLhDFepP/MoKBt3w4jiRMwt3BhSaYQ0BjF9Zu+lzU4zj
	 UW+VLJrxIa160nFq5L7LyPsSuLyaHgtSV8dymLLabkUv32xKTXaSWeSZESaTSgsSXs
	 hV4pqGNkVjqTJA2zq6SavFEAF9dEd+DGgnE20Ha9EzrdBmg+cQytSxGqQq94FgiaOG
	 ksXuTLwNbNdrg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso4206239a12.1
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 14:20:08 -0800 (PST)
X-Gm-Message-State: AOJu0YwoSz2fc9lC/tPnoW8J/gDeSIlIkmJ4Moy1MtLOtxsBw6H0UsN0
	4cpfaX8LlVHzoidz998nXuxyHtXjUUuHBFtGomdneA==
X-Google-Smtp-Source: AGHT+IHmLk1Z/Sz01akvMr/FQh6as32bImEa+pudYGREu5eK4WEKhfIYILoFgQP0CspWs0pXV8plDiECpNfrxfFgNVY=
X-Received: by 2002:aa7:c993:0:b0:53d:fe98:fd48 with SMTP id
 c19-20020aa7c993000000b0053dfe98fd48mr462449edt.3.1699654806808; Fri, 10 Nov
 2023 14:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102005521.346983-1-kpsingh@kernel.org> <20231102005521.346983-5-kpsingh@kernel.org>
 <CAEf4Bzakdg3pxQZtjYZGrvZPo-nmpsxB0=Ymp9q+KFYOPViu=Q@mail.gmail.com>
In-Reply-To: <CAEf4Bzakdg3pxQZtjYZGrvZPo-nmpsxB0=Ymp9q+KFYOPViu=Q@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 10 Nov 2023 14:19:55 -0800
X-Gmail-Original-Message-ID: <CACYkzJ5u053pm1gD35xY2_Q8SscsEYKMJn2TRcak8nEucenvEg@mail.gmail.com>
Message-ID: <CACYkzJ5u053pm1gD35xY2_Q8SscsEYKMJn2TRcak8nEucenvEg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com, 
	pabeni@redhat.com, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"

[...]

> > @@ -110,11 +110,14 @@ struct lsm_id {
> >   * @scalls: The beginning of the array of static calls assigned to this hook.
> >   * @hook: The callback for the hook.
> >   * @lsm: The name of the lsm that owns this hook.
> > + * @default_state: The state of the LSM hook when initialized. If set to false,
> > + * the static key guarding the hook will be set to disabled.
> >   */
> >  struct security_hook_list {
> >         struct lsm_static_call  *scalls;
> >         union security_list_options     hook;
> >         const struct lsm_id             *lsmid;
> > +       bool                            default_state;
>
> minor nit: "default_state" would make more sense if it would be some
> enum instead of bool. But given it's true/false, default_enabled makes
> more sense.

Agreed.

>
> >  } __randomize_layout;
> >
> >  /*
>

[...]

> > +
> > +void bpf_lsm_toggle_hook(void *addr, bool value)
>
> another minor nit: similar to above, s/value/enable/ reads nicer
>

Fixed.

