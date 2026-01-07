Return-Path: <bpf+bounces-78082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABFECFDBFC
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 13:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B1130915E6
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88CB3090D7;
	Wed,  7 Jan 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U19zvFUb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36D38DF9
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789812; cv=none; b=ZJOeTeQOE4kZjFLpgJZjlvp1hmlvPeTpI2p6dfqfXdwC9g/x3PKSVO5QFDDv6IqRmmWfIJXsoMMfv4fcXUTEcsl2EAUOVpi4shHzqAGc8N+Dug3e1P4RsWykiTdGVYbPV0NX1Qw2/jlp9CunKM/L4SywiJaE0D93Jxl9RYZMGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789812; c=relaxed/simple;
	bh=fmI6GBURzynMYjqFLO1rLVW4zSGhzymUlAxu3PhleVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8/AhZjY1HECiTmo0y6VHSWIo+Z/Q/v/zNuR5jADjXEPriW9fqvrGZjSUZnSoxPsK9K9QWudr/tHHbo0XvtzZORu3kb8fznRNFbXLxJRKLSAjYjvk7MmxLAQT7xn5xdVRMAeCDEQo3owHOo5cJ82VhgnAP3MjhEYVloCYYjJr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U19zvFUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767789809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qYpjdK6xqjiXLPveyKlEyST/b5NQTjITNrUIV5P8N4A=;
	b=U19zvFUbOXIQMBmXwxH+Bw7mO4cGVam4kN90XekODWNEFpNp8b8JB4oMb+YSugimbKFoux
	QOYPF5cxKQk9E3pL8Uh5Bw0Am84gmcQg1x8q71wVJUz312A1JFcIa8dx8GYQWhs2CbK17Q
	9DbiWpYOZAUYvEnwNps8+Afwcmhe3u0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-LocTYb1BP7y7-gaVnQCfnQ-1; Wed, 07 Jan 2026 07:43:28 -0500
X-MC-Unique: LocTYb1BP7y7-gaVnQCfnQ-1
X-Mimecast-MFC-AGG-ID: LocTYb1BP7y7-gaVnQCfnQ_1767789807
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-37fe06427afso11206421fa.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 04:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767789807; x=1768394607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYpjdK6xqjiXLPveyKlEyST/b5NQTjITNrUIV5P8N4A=;
        b=o40/hkxxG7lW0n5wfEX0FbwPAzyvkFrMdqB7I57JWvNrFz32xiZ1TwAxFI22g7xCAf
         tc10Hlc2XT8yV8PhecSSlYcxNsdeLmFNWPyQvZWFZ+NdMw3/vMFctHK2H0LwCQIt71pl
         5qK60wqwVy06SO8UUfEcOV6kB8UQ19Ck8tjrLZGoUiJnInsPGwipXVZ7/8Aj7+CndKKj
         LtFFnJXynkUyuxbyHiZLLATXXNwXST/hi1/MDKhNn2a+sjzjiFbZIPON0XUR1vvSnX3F
         khrDsCaG9nJv0Bxbn//rFO/M+tvGTf8f2Z+bJUErLzL82hSak+6BEBhPhsLSGHXLANmp
         EIKg==
X-Forwarded-Encrypted: i=1; AJvYcCW/sBHD3leJTxdotLbBKC7lMftAAeYfWnYUkd50FH9uqpbP9QU2YhuJE9+3S+WLdpUjXdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNqdRL9KyJpYCl5c0QnZ544fVLOsU8YgtXq7zmVuvsTx//9/h2
	ngntFnEtMI5vf+cKaiDe+ti/Tm+afpRisn+FD8yDnj+ePcylMe2SQCMvGq6UhGbfVVO8WaNSIc7
	nlkem+TOHfrrTYVQMP/Ki+EsKTjeZsIl8PcFum9EHiS8QcQvSiG5gIkn5yfvJi89gPcjOUtnCr6
	nElD7c9gr9kFgbtZo8JjcFc5Gg4XMh
X-Gm-Gg: AY/fxX7uzQpCpNcebkuASL0pasxtMTVPgV9ocP10yQT5prTDBfZ1/oOKPM0PHsBTmvM
	yicVzgfICH+cn05mjze4D5wpQUKnFBZY+5+uSFBfpbbmUCBLg6xA1JNavALi3Ds7XkT3d4gDMs4
	tzjucS/Zk26q3g1B2zX4K0za2DhL7nycOwdynhaPtwAPmdaBLCax74KkfPt/e5BBQcC9hXaUXWw
	OyCBS/VOsOQpakIP0TiJfhQMH7GVd2QburFCR7TlUVgTqkZw1FVwQVb4ADtlVNd5FAVbef1ggs5
	o/4OIOLT+gda
X-Received: by 2002:a05:651c:988:b0:37b:b952:5de with SMTP id 38308e7fff4ca-382ff6982dcmr6294751fa.14.1767789807141;
        Wed, 07 Jan 2026 04:43:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHM9jBPzSp9yP/SjuVnAKRT5EyBUzxrL5MI/39iWJVZpfVEHkfC3xCGIi+hK4kmJzAUHK2fLd297HEAyAJoPY=
X-Received: by 2002:a05:651c:988:b0:37b:b952:5de with SMTP id
 38308e7fff4ca-382ff6982dcmr6294561fa.14.1767789806730; Wed, 07 Jan 2026
 04:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-8-wander@redhat.com>
 <CAP4=nvT2oPtM73nfPkSJZ4612mcAPw1LWbHNrszFBVAmSJOVbw@mail.gmail.com>
In-Reply-To: <CAP4=nvT2oPtM73nfPkSJZ4612mcAPw1LWbHNrszFBVAmSJOVbw@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 7 Jan 2026 09:43:15 -0300
X-Gm-Features: AQt7F2ohOU59M8pU4jNOqHEDtfqVClEWClJzqZRMA1Tnh2uzkv-X-TWQJ5VOeDc
Message-ID: <CAAq0SUmrRecimVNCa=zv-h3uPm-GpQo3g+ZTV4zLNVA4ZVo-EQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] rtla: Introduce common_restart() helper
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:03=E2=80=AFAM Tomas Glozar <tglozar@redhat.com> wr=
ote:
>
> =C3=BAt 6. 1. 2026 v 14:42 odes=C3=ADlatel Wander Lairson Costa
> <wander@redhat.com> napsal:
> >
> > A few functions duplicate the logic for handling threshold actions.
> > When a threshold is reached, these functions stop the trace, perform
> > actions, and restart the trace if configured to continue.
> >
> > Create a new helper function, common_restart(), to centralize this
> > shared logic and avoid code duplication. This function now handles the
> > threshold actions and restarts the necessary trace instances.
> >
> > Refactor the affected functions main loops to call the new helper.
> > This makes the code cleaner and more maintainable.
> >
>
> The deduplication idea is good, but I find the name of the helper
> quite confusing. The main function of the helper is not to restart
> tracing, it is to handle a latency threshold overflow - restarting
> tracing is only one of possible effects, and one that is only applied
> when using --on-threshold continue which is not the most common use
> case. Could something like common_handle_stop_tracing() perhaps be
> better?
>

Sure, I will change the name in v3.

> > +enum restart_result {
> > +       RESTART_OK,
> > +       RESTART_STOP,
> > +       RESTART_ERROR =3D -1,
> > +};
>
> Do we really need a separate return value enum just for this one helper?
>

If it was success/failure type of return value, we wouldn't need.
However, a three state code, I think it is worth for code readiness.
Do you have something else in mind?

> Tomas
>


