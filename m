Return-Path: <bpf+bounces-78076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33631CFD876
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 13:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA21C3011AB7
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190AF304BBC;
	Wed,  7 Jan 2026 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9T/Qpeg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNxCxiPs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234A309DCB
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787430; cv=none; b=NJ//UBIDnpXbhUsj4OMkhl9fDLXEEQiQAHcEwFeiiEDTCn1Ig0y4+SZk7wi25uuEsrQh5kLGUYMDjcTM72m/ImVWPieY2uEMqZ86+oPDrp/oHZi9ArHqqx5TVGyJLzxd2j/YMBWWV40lnpZ5t+ka+kd5TQgQ/QWj0TQUl8LjTnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787430; c=relaxed/simple;
	bh=BV3qLeOvMcaNZVUP69c1YtN/wbMYGTCv2M+gokMVuCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZgcl/VWUaSLcdYJ0oFjx1RxPDs8ZQcGhOjEGZ2zPhyyt3xXUOy/JOYVTfbCCx5nvinwV/jbMBqoG0yrOB1EPpYyOg/JLCKtNcjd2XKmw1heTz/aNk7VZ0X+COZEntxXD/CeVDzVhxHrqUHlnc2dViPUW9Qze8/x1+uyTto5rro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9T/Qpeg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNxCxiPs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767787428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Al4OPVFE0mOhMlBb5QMwhatYcqi1Bruqbnv2tfRXugQ=;
	b=M9T/QpegmnpxeJhjrsPMuX1x9TWrvVdWOuKNDC0O9gzN0/agFDQfeVsBECsMIhwq54RjJu
	DXdwh7ZCOa5hcSAFLG5fkeTlfAI4E4s5UWTuY6DDVzu3geASBC+895WRfp7q8vG1FIyrMq
	rQ0siKhUcWRxgee0xsuIcDrqBKh1UZk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-E52id0tDPDm1ROZ1vgbcEQ-1; Wed, 07 Jan 2026 07:03:47 -0500
X-MC-Unique: E52id0tDPDm1ROZ1vgbcEQ-1
X-Mimecast-MFC-AGG-ID: E52id0tDPDm1ROZ1vgbcEQ_1767787426
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b80716085a0so314386066b.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 04:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767787425; x=1768392225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al4OPVFE0mOhMlBb5QMwhatYcqi1Bruqbnv2tfRXugQ=;
        b=ZNxCxiPsjJmUuaTdegcmJV/OeyFyYTct3P/ODR2PxdibgNjNnidhofcSqjNOOkOseH
         DfxxO1HmNJWNGltCTVM4UnBgzntcTquQbqP9tSViweku/qnf/PuhUKz0uUge9AJLHSBK
         qaT1edZGCmiQMSax/JL3TaDaSVq3PomO+hh2ojbI/IpSF2kyfkTWbwhgS0BdEhSW4oHC
         lUPkhtXGazqTvhAdMmEzdjPI6kI6ZaZKFJQuQRdktmjrVCoJw3YVcS8sl/dmTq858TMB
         +uOK62PRpVXlgEJokNFImx3C6d2ki0tzFJq9RDPYJw3IvE1Ex3QONV2Z8TDg/WbKJJUl
         MOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767787425; x=1768392225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Al4OPVFE0mOhMlBb5QMwhatYcqi1Bruqbnv2tfRXugQ=;
        b=bMFYTkYjC8TSKFJ4XZ4hdd1juOfTuQKP5vufh3k4qTFqYx7HFJaDmrgIGSlPu6OJ4p
         n58JwX1c8/02jr3zvm6ea1+Q7/cp56UWriu45Ek6EQSQZkamiZThQqUpr77iNxuqV/nq
         Ein6CjD10cuAz+SwECyTX76fFpg5EcGtO9/xQd1wUrlyRP9rgNL9VvdXphpl5EpQDiT2
         RUOzguoIYrfwb+N7OYT2051OFwQMKsLTQd5ZpqiEckmDsfARbndVSfoUEcF9vHnJIZft
         2MIWS9IqWPaNg2QjvObgQigp00hZkJAOeRntjYoYFp3FJUU9dSx0SSZFFG4Exp1gw1dn
         +Z8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+fzgYSYWdQXJB5SrE3HNFE/Y5F3woKPz9KANlENQhkbnuw09RJbftr5x+Y3U8cfMEPsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIFsnW21ErzflJ+qw+Qv124hPNG24qARv0l5U7JL5I4l1Kw63
	Os6Nlwc5344plu4qKQzXWU+xtF53hVHDlQG7jeRzAfCAya1FJAaK6ygIWXnXLxa9Z2JEqSwGDsy
	L1tqOFHi6DrI5tT/l8+O0HCLxiuXs168A/mGP4FA/bd1HQrYDKfCZdEWtkjjcO4RGp79M2jpCUY
	Uox+EQeqXHTxDE1QdEKkPYpbrNIEtMPHEGU3ZwlTE=
X-Gm-Gg: AY/fxX70DX7GLU1HtJCAauvLayX+UU8hGZyMZvORg+Ecn1T7Zq+HjeK1Mh+mfUco73c
	i/glP8OT/Qn747DKxAsOpD2QGoIxomSzzsfTdcfRxTBzO9gIeXqyfvdrA+m1hbUFrX9yMh/hko9
	BceCzZ52GBNFL51L50erghRRv58SN/+7WvHQ8LyG9/xpAFZBgGMHx2vufQMf9bDRUGEdIotQu1H
	EzzVWbh2Ft5NdK+FCXfb32F
X-Received: by 2002:a17:907:2d2b:b0:b77:18a0:3c8b with SMTP id a640c23a62f3a-b8444c4d2bamr194806766b.1.1767787425332;
        Wed, 07 Jan 2026 04:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc3hhh6pev/A+PbACCMi4+m1wjCgaQ133+hHqE1gnCXiQmaW7gjia4wxOa3u0Bbnghah13U2BNLs8CltmHlkg=
X-Received: by 2002:a17:907:2d2b:b0:b77:18a0:3c8b with SMTP id
 a640c23a62f3a-b8444c4d2bamr194804166b.1.1767787424908; Wed, 07 Jan 2026
 04:03:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-8-wander@redhat.com>
In-Reply-To: <20260106133655.249887-8-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 7 Jan 2026 13:03:32 +0100
X-Gm-Features: AQt7F2o7jlt0YO3V4XYuBaar_aNRy0h6LrccZdVcN1LsGdXmgJoS71bsNR4IS3c
Message-ID: <CAP4=nvT2oPtM73nfPkSJZ4612mcAPw1LWbHNrszFBVAmSJOVbw@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] rtla: Introduce common_restart() helper
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 6. 1. 2026 v 14:42 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> A few functions duplicate the logic for handling threshold actions.
> When a threshold is reached, these functions stop the trace, perform
> actions, and restart the trace if configured to continue.
>
> Create a new helper function, common_restart(), to centralize this
> shared logic and avoid code duplication. This function now handles the
> threshold actions and restarts the necessary trace instances.
>
> Refactor the affected functions main loops to call the new helper.
> This makes the code cleaner and more maintainable.
>

The deduplication idea is good, but I find the name of the helper
quite confusing. The main function of the helper is not to restart
tracing, it is to handle a latency threshold overflow - restarting
tracing is only one of possible effects, and one that is only applied
when using --on-threshold continue which is not the most common use
case. Could something like common_handle_stop_tracing() perhaps be
better?

> +enum restart_result {
> +       RESTART_OK,
> +       RESTART_STOP,
> +       RESTART_ERROR =3D -1,
> +};

Do we really need a separate return value enum just for this one helper?

Tomas


