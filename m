Return-Path: <bpf+bounces-10304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0A7A4E12
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B1928176D
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45998224EE;
	Mon, 18 Sep 2023 16:05:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72151F5FC
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 16:05:15 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BCE126
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:03:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-414ba610766so564521cf.0
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695052841; x=1695657641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPbc3h7r/oRbbvZIuYtcLljAjL8wVOiSbWBBq1HxtZI=;
        b=U0AWW05RHq396RL86hb5uWizQikak28VzjFj1hQI1HS/hlOD+pITusJwGcOy0pzXH3
         O0SJ6OYb9cS20oH9z7VyVDcIqiLAFAgvePkqV4GnsLd4b5r7E8boEY4trWrfqRL6+DYC
         t2iIuqgQr6tuz6Poka7krqgu70bLZYWzOOqKAZxRGk1NBDmF7idWmHP9FmzV7YpNT/gj
         yLEewMNbOXPsl/96oDCafHrpaHWiHFV1IQYPG1JED1m8SCO9oNJu6qzvwnrsN/YvOCoj
         OwMq5f5sJaew0kdrJG0MiV4IvnvqhmZ7Q129dBrQjsybRYdDA7+3v/l85TALCtJylWnb
         0Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052841; x=1695657641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPbc3h7r/oRbbvZIuYtcLljAjL8wVOiSbWBBq1HxtZI=;
        b=oTXnbKXTJWnk/HYU8OmAI0D4esBiU89cIrFASkDtwigVHmXn3gwlhh87EPoKOYxyFl
         ap5BqRUB4iBdfTHvSuBt7FG5x+HzLRu+cWN80JeUrb9VMgGf/HOE53ksZeI12dtqZPQU
         VXYvY0bDX6xGIGmgu/cOwLH7DEMsY1Lg9G0PwM85+PgdgA0d+f82iH2VpCKy0sQwCC3N
         cVmIozTbR/SiUdIIyAMU8rwHDDC3Xuhv2NjMen7HPQP7rX321RsBemoaEgZ1Xdj3SmMr
         negQAYdUu4nvtHmkUWBi4AK9XtzgupBVaeqMDIXtiOxb+M4bUuexfIEm/5G4nijWW0Qw
         vSrA==
X-Gm-Message-State: AOJu0Yx2w8I9iB+yh7mC4BWJOceE06/OeNneW7viLsqG9v/4OW+3PquU
	Q4+9GAL5FrOiax45QIdD8nkn8BBbDIGaw0Y5ghE+sg==
X-Google-Smtp-Source: AGHT+IFIefoxDkNOkiqpUZNXgc2fZMzOGoiJvuOfPtMmY+EmzdXSLDvdTT7+Ztu+qykuDhW/bRgroZ68/Zc+GlL5UUE=
X-Received: by 2002:a05:622a:18a9:b0:410:8114:107b with SMTP id
 v41-20020a05622a18a900b004108114107bmr331037qtc.12.1695052841053; Mon, 18 Sep
 2023 09:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918155233.297024-1-memxor@gmail.com> <20230918155233.297024-4-memxor@gmail.com>
In-Reply-To: <20230918155233.297024-4-memxor@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Sep 2023 18:00:29 +0200
Message-ID: <CANn89iLUX16q0ir1ueOcLg_ROo5FXZ+t-U-116MjxrOOSrj0PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Disable exceptions when CONFIG_UNWINDER_FRAME_POINTER=y
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 5:52=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The build with CONFIG_UNWINDER_FRAME_POINTER=3Dy is broken for
> current exceptions feature as it assumes ORC unwinder specific fields in
> the unwind_state. Disable exceptions when frame_pointer unwinder is
> enabled for now.
>
> Fixes: fd5d27b70188 ("arch/x86: Implement arch_bpf_stack_walk")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

SGTM, feel free adding

Reviewed-by: Eric Dumazet <edumazet@google.com>

