Return-Path: <bpf+bounces-75465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 248FBC855E5
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 15:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35F584E9B04
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD26251791;
	Tue, 25 Nov 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUofbZPJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967231BC84
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080437; cv=none; b=rShrO50yy2+lD2P52rUGXJfQvXE3/+D7o54so/I+/mgVtSTGfIHGCFfGp4qs8LKi4W36ItDLVKWaDEibwdlwaVLJEWbpcAxjnQ1QcaaLGc7e8LyZHty8TiDdJr6YXpVZTIlXh8JdNprv/FYfET14gzaq+FTWIT9WCN7WasmotGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080437; c=relaxed/simple;
	bh=FVWgm6IR64KdZqW5wn34sRh+Agl3EA0xjeErXlSlH8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYClk8e61UTqg0Bdv9e3NRWbnfmj7RmFPIo0mAlHxv6ggTCD6qCMfmcFIGkTC2XIIvPPhKbzAqL0EgZXPw2H15glS3uoXnh4oK4W+f8LiP/AggSYINfa1e63O5RoL7DGiTO2aETvGyCClJTrSvBoI+EWlbCIRLtQJU4voZ2m+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUofbZPJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764080434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YuFgUmjsDWh/qL+V41JU00YVr6Y4jXOaLXN3q6tAOfs=;
	b=BUofbZPJsC/r7/YsfzMoHMbJ9LHswcHw+0sRuQn421XTqlDUUhxw5tXhlXi+aG15PZXSo3
	oqzSxaVvIbF8v2HsuhtkjIVdAl2sjQQfm4Qwm7os+CfgOkKStZQWWy9xUQ13BfAd4Y5Hly
	ZfcxO4AQcm9KywHhQ48jgY13C8C8aV0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-yEAsKtFBOZCx9q8ZyxvrtA-1; Tue, 25 Nov 2025 09:20:32 -0500
X-MC-Unique: yEAsKtFBOZCx9q8ZyxvrtA-1
X-Mimecast-MFC-AGG-ID: yEAsKtFBOZCx9q8ZyxvrtA_1764080431
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-59436279838so6283085e87.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 06:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080431; x=1764685231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YuFgUmjsDWh/qL+V41JU00YVr6Y4jXOaLXN3q6tAOfs=;
        b=c8LNzLHT7J2QM/frKXcvc2FM1pMJMYVxOGxibv5sDGJ0me2R15b3hgoF0xub/Qi3j3
         zowDwGyJDc+cMmDQKReO4JSpFoIt6rVHgz1zwUnSAANXvAvyQb1B9V71tC4plEwPoox4
         dituuuUOT4vPJ196j3ATvpQOlGfmvDJOP23vhQ6EPSj2NwA8ykHcvBfCGwTwVsrhLieu
         48Rg1gBwFWValEqOwbDowYQTi9DX7AHUitRPeO29ZTTbLVoYfslZ2S1F2MK3gxN4Lsl1
         dwLtsLzkTxz4HEXR8PXDsSegy2ZMQd8aXgdocTXVKpK+iRdh3kSUtv6ud6PEWBtnZEVI
         xPdA==
X-Forwarded-Encrypted: i=1; AJvYcCXCEBLSBxyisHeym6MI9rmX1UzH1B5Y1V7BmmZAW+eA+2gfSssg/i+4lOPLN+vRwBg0944=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmPLIhEk21USg46BFj6oDxyV2v1kx/PfhUBubKxXunCPvyUhxq
	ju68LavcaMQiiGRAGdKZztdqVGzZ+6ALxQCD5X6CICeACwzZGRQsJCfjlvlsltom5PwLt4LJgZ1
	WjVBnXhhqHHXvOWPlxeKnORYS2+cHPQ7Vr/YmLxMmQyGELhwt+gOh+oIKDDMMn9SMs9OQP4HCsH
	muX+dcU++kUa7TTFZcV1v6qCwGR1Hj
X-Gm-Gg: ASbGnctuZapQQ6ffvt/TGmNJYQWcZDXhSq1PSo7AzG7H9oyjh6NOFY7gt1ulacdgJYi
	6NwKIIumPLgiIsOL5dZITto8f4sHzP8nX9Reu9OcB7pXPvZ1ABET41AbMseiipT92Z1OcnedrU2
	siy1EaKLmquG99pBc6G92mxaDUgkK4DNfq2BRLsiGGxbG3jqpghGIDtXfKlhtiKsGGtg==
X-Received: by 2002:a05:6512:158f:b0:595:840c:cdd0 with SMTP id 2adb3069b0e04-596a3ea6320mr5165600e87.2.1764080431286;
        Tue, 25 Nov 2025 06:20:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK7mkjTE8tfDwtcmLLKnCvTrS/LKgN9IW6L4nU8sopNQNGJ5FyT1zqAip/JpWy9Us5ih/Twipu9As0QwWcY3k=
X-Received: by 2002:a05:6512:158f:b0:595:840c:cdd0 with SMTP id
 2adb3069b0e04-596a3ea6320mr5165586e87.2.1764080430839; Tue, 25 Nov 2025
 06:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-8-wander@redhat.com>
 <fb5b468b38ac9570a5f3fb948452d1b5b03c9f9c.camel@redhat.com>
In-Reply-To: <fb5b468b38ac9570a5f3fb948452d1b5b03c9f9c.camel@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 25 Nov 2025 11:20:19 -0300
X-Gm-Features: AWmQ_bmz7MJciJqDQz8Mppekett5WnLxv9QLQUUdHlfTABxmQ5nou0kEG_PqHmM
Message-ID: <CAAq0SUn=eK+9YZZhdL_bs0S2cfVMhuuV-v8DSRMkTOqoL=SEWA@mail.gmail.com>
Subject: Re: [rtla 07/13] rtla: Introduce timerlat_restart() helper
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:46=E2=80=AFPM Crystal Wood <crwood@redhat.com> wr=
ote:
>
> On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:
>
> > +enum restart_result
> > +timerlat_restart(const struct osnoise_tool *tool, struct timerlat_para=
ms *params)
> > +{
> > +     actions_perform(&params->common.threshold_actions);
> > +
> > +     if (!params->common.threshold_actions.continue_flag)
> > +             /* continue flag not set, break */
> > +             return RESTART_STOP;
> > +
> > +     /* continue action reached, re-enable tracing */
> > +     if (tool->record && trace_instance_start(&tool->record->trace))
> > +             goto err;
> > +     if (tool->aa && trace_instance_start(&tool->aa->trace))
> > +             goto err;
> > +     return RESTART_OK;
> > +
> > +err:
> > +     err_msg("Error restarting trace\n");
> > +     return RESTART_ERROR;
> > +}
>
> The non-BPF functions in common.c have the same logic and should also
> call this.  This isn't timerlat-specific.
>

I will replace them here, thanks.

>
> > diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtl=
a/src/timerlat_hist.c
> > index 09a3da3f58630..f14fc56c5b4a5 100644
> > --- a/tools/tracing/rtla/src/timerlat_hist.c
> > +++ b/tools/tracing/rtla/src/timerlat_hist.c
> > @@ -1165,18 +1165,19 @@ static int timerlat_hist_bpf_main_loop(struct o=
snoise_tool *tool)
> >
> >               if (!stop_tracing) {
> >                       /* Threshold overflow, perform actions on thresho=
ld */
> > -                     actions_perform(&params->common.threshold_actions=
);
> > +                     enum restart_result result;
> >
> > -                     if (!params->common.threshold_actions.continue_fl=
ag)
> > -                             /* continue flag not set, break */
> > +                     result =3D timerlat_restart(tool, params);
> > +                     if (result =3D=3D RESTART_STOP)
> >                               break;
> >
> > -                     /* continue action reached, re-enable tracing */
> > -                     if (tool->record)
> > -                             trace_instance_start(&tool->record->trace=
);
> > -                     if (tool->aa)
> > -                             trace_instance_start(&tool->aa->trace);
> > -                     timerlat_bpf_restart_tracing();
> > +                     if (result =3D=3D RESTART_ERROR)
> > +                             return -1;
>
> Does it matter that we're not detaching on an error here?  Is this
> something that gets cleaned up automatically (and if so, why do we ever
> need to do it explicitly)?
>

On process exit, it does.

> > +
> > +                     if (timerlat_bpf_restart_tracing()) {
> > +                             err_msg("Error restarting BPF trace\n");
> > +                             return -1;
> > +                     }
>
> [insert rant about not being able to use exceptions in userspace code in
> the year 2025]
>

I actually find exceptions an anti-pattern. Modern languages like Zig,
Go and Rust came back to error returning.

> -Crystal
>


