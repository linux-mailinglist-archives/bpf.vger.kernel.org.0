Return-Path: <bpf+bounces-10302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CDC7A4DCA
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12C11C2171B
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0903C219FC;
	Mon, 18 Sep 2023 15:57:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749721356
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 15:57:37 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E29CD0
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:55:05 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59c04237bf2so38580637b3.0
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695051996; x=1695656796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Irf/x7Bp+jiHwey/YAiDuVo4UVdOZIsn4X23hTZ4uKg=;
        b=cuCEYR+/07/XQp9dGrGS3X9stnIuNPSJnD4SsnST12BU6QM4iQqStFuFy/gxh1oO8e
         U/gHKi98UtVk8K4x9p/RSybiP09iIA0fKNfV8DO2W1iQXQqhQ2p1e5rEHgoafJcUOZgk
         qwgNcsibuL+ZnXDxJWlVo9vgmx02EHrAsTD2J5HEZbq58Z1+FieN7XjKqMrtnAgSmlPj
         /Q0VuEnmqD8r3PMNYccA+VXGwVNjB65MMf1I0eaecOcledIyVdD9ZkUNstSqrq4jPLa2
         NSYYL+zf6cCiO/JzpWXXTSUofVRYV5kmHXusrLb01q0uildyUH127pS/smdMibE0uodL
         QjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051996; x=1695656796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Irf/x7Bp+jiHwey/YAiDuVo4UVdOZIsn4X23hTZ4uKg=;
        b=rZ8ceZPsClep0LxnXQpiIlLUmbVb+TjlSw6joKnl7ZvZbHt53g8rXDDxEMey6n0Zdk
         7f++QG8f/klNOqGN90hWp8TsCVh3XTeAij3NYRJxrpdD+oO2s/yTyCzaQIJwDLBu/Ty0
         WRAoUJF+tdj+kuGE6ZkNZpPD9W41hfliC3RRdE8uojCFQ/MhmJ3h2yPUuZnTyTLbKAT4
         rt5UmUhUWqAegXh3ZtmAAOoKLgTBBLd7BS+4MHe1UCeaX0mqPn3kh0bQyJJ1ef4mITRg
         aRMgadE1s/lpMYiz/lYs5dy17LkijXKJAg6KXpwX3X+OH47pLVRk6Sbt0hDZonkpbqnP
         JKzw==
X-Gm-Message-State: AOJu0YyjX9LsTryH7Ux+fLv8ILG77jLPsqsCJbLh3kVQTGsfU414uyif
	qHJ6mMESTdGgmTGedOcglqC26BXrWROE/izGfjrjHHsY3By8/4Q=
X-Google-Smtp-Source: AGHT+IEY9guvH+H+a1GPkqEqVUEXKZHgyyxqPouezy+bEL0NRJ6QduLtiwQ2/tJ+MG3mC58mAuZmims6EZ4M9iL1wZw=
X-Received: by 2002:a25:50d8:0:b0:d0c:9ab2:72d3 with SMTP id
 e207-20020a2550d8000000b00d0c9ab272d3mr7977417ybb.14.1695045363162; Mon, 18
 Sep 2023 06:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616000441.3677441-1-kpsingh@kernel.org> <20230616000441.3677441-6-kpsingh@kernel.org>
In-Reply-To: <20230616000441.3677441-6-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Sep 2023 09:55:52 -0400
Message-ID: <CAHC9VhSSX0KRuWRURUmt2tUis6fbbmozUbcoeAPkLRmfR2jqAg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 15, 2023 at 8:05=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> This config influences the nature of the static key that guards the
> static call for LSM hooks.

No further comment on the rest of this patch series yet, this just
happened to bubble to the top of my inbox and I wanted to comment
quickly - I'm not in favor of adding a Kconfig option for something
like this.  If you have an extremely well defined use case then you
can probably do the work to figure out the "correct" value for the
tunable, but for a general purpose kernel build that will have
different LSMs active, a variety of different BPF LSM hook
implementations at different times, etc. there is little hope to
getting this right.  No thank you.

--=20
paul-moore.com

