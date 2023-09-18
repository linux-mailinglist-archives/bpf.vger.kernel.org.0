Return-Path: <bpf+bounces-10315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 014467A4FB2
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085CB1C20F38
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C323749;
	Mon, 18 Sep 2023 16:50:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17920B03
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 16:50:14 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDF5BA
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:50:13 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d77ad095e5cso4429234276.0
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695055812; x=1695660612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Irf/x7Bp+jiHwey/YAiDuVo4UVdOZIsn4X23hTZ4uKg=;
        b=JGdOaTprPjGhjsr5NDR+FO+9ngm1SIpRqnFZ6gxfRG48+IQ+SczK6tDKqWPggtt/SG
         24i58DjlzHSNdPChnzpJhfkC13FBWKtslmJ5AqNjboKq+XKHhw6DoIqEg+MxtOn9ygqT
         mCVQch97RsnrezKAtggen0/1ScXJTpgJsim7lOpdM0l3NRIdErQzJzDi20u7+vvR3a0n
         phHHP9ArwB76nJl6vqByM7hD3xl3I+Umva6zrJcxcN+Xq82vEoITi71LKFnSyIEl6/jN
         8GBQA15asbgut6IJnsCqY7daMe78J9RcHWnqH/pL2xYUHLiV/kbCaLftpNPIA/8c/p1K
         qMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695055812; x=1695660612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Irf/x7Bp+jiHwey/YAiDuVo4UVdOZIsn4X23hTZ4uKg=;
        b=tZcNuu5qPExgckGEpnEUrumYLqNagQZJVZnnLEBChs3CQJASbJm64UxFItB6o83VTf
         QYCwoAAIFTdK7hTUa7sEnoZhEERbO5nJ+UechdlgpKeele1JDN+mawRzidp7faGKPVnL
         aPDciAXSqDlE2xHIRzB4Xpr0mfJ4M+Gzp6RiLgLukwH+p7i25iD5XFXD4YOSQeBuuItb
         urnmq+BaDefLKJz5kMUnw1lLJuaFh7cwIg7l12gfC3KCYX6EYJunfzpqdX+DsMUzxuBh
         TGK2Ogrsco45CN1/U3+dP0BEbydUbzf9uZJhWC3n9jw75NcNd9ffZUnLRD7SBvs9QXyi
         Xpiw==
X-Gm-Message-State: AOJu0YxUxamp64cGvWDmwEJKKmA5YkPsCZrpIhQueFaOk68dPUT4r0oW
	ewV/T7QQdFcIkWXs0aDwQIpSC+BIJS898+wtVsd2SS9EDI26pRA=
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
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

