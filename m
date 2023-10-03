Return-Path: <bpf+bounces-11328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE857B74DC
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 01:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 3DE25B208E7
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0A7405C3;
	Tue,  3 Oct 2023 23:27:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FD3F4A3
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 23:27:37 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDE8AC
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 16:27:35 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59f6441215dso18559727b3.2
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 16:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696375655; x=1696980455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6EEzjb9woXtKM1XWdqMTYQ/Qn5fCSu9QJUtD9HcqFI=;
        b=STWTr8+FSXXHn74aPOMnU3t+iap6Ge3dKEs0ldtVoXHXoT+FbyMdt/lciYVl5eVxCi
         4kpBMleGZKSwGv3HvhUwNunZJwp6UltrmusAOTKOQ/FNIokUYt/uDTGjXfTH7jyBowIG
         Y1tPLJOwh3fRJc9GAQRpcKTk8OvnEjgAYacJbGdyLZt/kQ5eeaRH2L7gMZ6e3s8r1/4H
         pj80Ewv/l0VfqrmYuJ3Azx49+smU+02YCDyHTRnPBf/oBnW013rBCh9EsRpoA2za3li7
         SW0iA3+3TZNznbMQsjOkICr6ToS7wIc9r3Tcc3Vh8w3Vz/qjHjPxmKF4caMKK5wXp3Dp
         MXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375655; x=1696980455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6EEzjb9woXtKM1XWdqMTYQ/Qn5fCSu9QJUtD9HcqFI=;
        b=eJ8jshWvDj9P83LYUUaWBkSO+F3vl012eV/kFZPZaZqyYDUTpUQxPibuIU5CWnoi4B
         EV8GvBiJh90zfTDBAuS2FjMamQoMIY4dpzNFyBP031fkbA7p/EVXg0OTOhtTppuGhTF/
         yIhGSc5MesVmPK4ST9CxGHLl0Ce/YvUU0kRqTCyTT+d2uususk7CkZ4nrSThHU/mCQI8
         V8CLZlt6h0Eb0VqRJa8+q6VP5m1/gNC7YO26DbTFGMqYkUC4l8skSyXHWy++KOzFltv8
         QUIkpI2lQcXvJXYGTWEaUjjjwYR/Y6n1aT0N9WMVDH6XKaV+c6pPffLvPACQf5OQaF+d
         bcmQ==
X-Gm-Message-State: AOJu0YxBIYV/jq3Vhh1hqz3elsau06PWAUSqbgeRWtBzgkLpOz2SznTX
	Gfvzxk0y29puyJACkBj4MmFtszW/fF3Es7gq3Q425exYhyt8HB07Fw==
X-Google-Smtp-Source: AGHT+IGrdMOQTLEOZ57tZ8K5VezOh07U6l7QNiD7CrlB39f5mm5e63BAMR7N3mEJI6u6cycSgu+mSvFySWGbka6cBdU=
X-Received: by 2002:a25:f910:0:b0:d81:894b:28e4 with SMTP id
 q16-20020a25f910000000b00d81894b28e4mr627591ybe.51.1696375655158; Tue, 03 Oct
 2023 16:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp> <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
In-Reply-To: <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Oct 2023 19:27:24 -0400
Message-ID: <CAHC9VhTCHPA+xY=KuLAzUsAKzXG8bMi0SGhGArtHMQVr85MTFw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
To: KP Singh <kpsingh@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, bpf <bpf@vger.kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 12:02=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> Until I hear the real limitations of using BPF, it's a NAK from me.

There is a lot going on in this thread, and while I'm still playing
catch-up from LSS-EU and some time off (ish) it looks like most of the
most important points have already been made, which is great.
However, I did want to comment quickly on the statement above.

We want to be very careful about using an existing upstream LSM as a
reason for blocking the inclusion of a new LSM upstream.  We obviously
want to reject obvious duplicates and proposals that are sufficiently
"close" (with "close" deliberately left ambiguous here), but we don't
want to stifle new ideas simply because an existing LSM claims to "do
it all".  We've recently been trying to document this, with the latest
draft viewable here:

https://github.com/LinuxSecurityModule/kernel#new-lsm-guidelines

--=20
paul-moore.com

