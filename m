Return-Path: <bpf+bounces-15437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306B77F20B7
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618541C21741
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD573A269;
	Mon, 20 Nov 2023 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SszIUC96"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8B8C8
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 14:52:56 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da30fd994fdso4735024276.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 14:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700520776; x=1701125576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2lsMvLDY4ljtrx25hKr++WIvxk12ha+p48G+6QGEW0=;
        b=SszIUC96Nb8PZQUb1f4kf892nc18aPuVcgzjLXipIHbsfQjkp0dhtA9isycgeW/uUZ
         YP/+EJ0fN8qhOKMfO9qXLzkzIjWoKroAanSOCdRKLCjdfPyRRwGOwkXAp6baUnyBbg3U
         I8w/7n9baeDyDY69xwGvjgaejgRGD52SQlAw8dDp6Sv2PZzBPcNB2r53ugXwXHCbByTG
         wxj+ig17bUuytoqYxKXjKONJLqiyt+IN9jetF9dp2ZvoWD6cEFOqAQVWlgYzRH5IbAxa
         s3m7TPkm+kj5SBnAIpFcJ1q+oXPK16Xn9DLiYy9FAh1Jk4T/CV0qFCytn7LzMo9c3YHR
         V6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700520776; x=1701125576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2lsMvLDY4ljtrx25hKr++WIvxk12ha+p48G+6QGEW0=;
        b=nDBHlyitNRVwkUTUYPBeYY9GUZvEtdCa9gJO5rJdvD/zVdlp4bf6ruX5/h8kjoKgPc
         OhPX7Ex28izK02Ol28EoZDX4YMgQrok+7AImWgL4ZYDzlZtaUj1pLj8QAILI/FbuDHPc
         QQIN/vGdldItSRz0Vyajb1Dstd/FXepzoFM9zUUw3bBU5kRL5OQmD/uJepW6rQgDxtVA
         TisUnb3BQD9FOMEi5WF4976CEWNNWQwAUTh9EZiasnnJDw7t5Zdii4y1diLTfhqM6YE+
         GJhNjxxYqBEDNfNC2IuiN0C/g73UfqUjSWRiZ0LlX7lsqVmA0CMYo0WZxB2FR4Y1AbrM
         HTQg==
X-Gm-Message-State: AOJu0Yw+85OimkqR68lYDh9u5BBM7dBV4R4fnvV/2fAH3/fFK4K/CGYm
	Eri5sCLSwMT9307Alw8rUZINTP+Fy5oHSgcLGwN9vhTgjDAMMFI=
X-Google-Smtp-Source: AGHT+IGHGKNVwKDhX53SClAiCjkrZ6qsf/LB1PPJ8WE5H9+dd/xZBgKvhmpJf+YIQ1gnAdG/+V+ElCkxebGxerlQJYk=
X-Received: by 2002:a25:9a84:0:b0:da0:3ec1:f3f with SMTP id
 s4-20020a259a84000000b00da03ec10f3fmr1099463ybo.3.1700520775796; Mon, 20 Nov
 2023 14:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
In-Reply-To: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Nov 2023 17:52:44 -0500
Message-ID: <CAHC9VhRbak9Mij=uKQ-Drod0tQu1+Z+JaahUzH5uj9JUf7ZTuA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] LSM: Officially support appending LSM hooks
 after boot.
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, renauld@google.com, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 8:28=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> This functionality will be used by TOMOYO security module.
>
> In order to officially use an LSM module, that LSM module has to be
> built into vmlinux. This limitation has been a big barrier for allowing
> distribution kernel users to use LSM modules which the organization who
> builds that distribution kernel cannot afford supporting [1]. Therefore,
> I've been asking for ability to append LSM hooks from LKM-based LSMs so
> that distribution kernel users can use LSMs which the organization who
> builds that distribution kernel cannot afford supporting.

It doesn't really matter for this discussion, but based on my days
working for a Linux distro company I would be very surprised if a
commercial distro would support a system running unapproved
third-party kernel modules.

We've talked a lot about this core problem and I maintain that it is
still a disto problem and not something I'm really concerned about
upstream.

--=20
paul-moore.com

