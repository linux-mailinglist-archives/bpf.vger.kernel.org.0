Return-Path: <bpf+bounces-12986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E87D2E32
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC0F1F21C81
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 09:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9EB134AE;
	Mon, 23 Oct 2023 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwPiuNUN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1547747A
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:27:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635C1AF
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698053277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJpUQGqtSEw59FWAvf8kANUqzmQ+qpaN7eg8DI+YNGE=;
	b=WwPiuNUNgMe2pDy6CwmzAE7kF6S7mZy2DCk9l3D/Mdz04gh9ObkARv8bSeBIBk65THhdzM
	AnSXMmOqjHKvU2tk8ne9FpGpmnXycL3/9/QDDZc/M6qkbtrz0f6+tB46D7uAknFWJIeMaN
	psTFArs65nTUsM9e5vHj7XnCFbSAW4U=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-wIwViLo8Olat5BFns0jy6g-1; Mon, 23 Oct 2023 05:27:56 -0400
X-MC-Unique: wIwViLo8Olat5BFns0jy6g-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-59b5a586da6so30216587b3.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698053276; x=1698658076;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJpUQGqtSEw59FWAvf8kANUqzmQ+qpaN7eg8DI+YNGE=;
        b=fpGTQACHzsY6d1pC8JOOnzbnn//EDFlAaGvcjjRjlCVEmyHbhU7eiWTyI8eFQi+K4U
         cgVRaFRt5cLFXuP97+Ri6ckoag5plVrTRtBjoDPWX4BYY1tCmWpCnaoAfPe6J4ZcY5dZ
         ttD5mmhXSNOxsTaM9IB7SdhmtcEpASNUz6HUl14xIqIQYtYJNM32+qo4zRprh4VIdnxo
         oWQOOMq37l9Pstolya6/Vu+3CWTpLm7O8LhMKZhZu8VIzPMBp3gBtJtqzU9m0+/3gS9B
         1uavzkAJbXNhQYT65FBdgfdAsND6VJsP0nX+9Pw/uyZHwGfmdDIXfsmAAwCIPXqmcRMv
         7QtQ==
X-Gm-Message-State: AOJu0YwZ6wIIA9mSJnOio4QuENpU9WKEy1qZzoWg50Tvt5+N9XLr9eMc
	6GCdrpSYPG/ewxy6KGjRWau3zyXtRHO9Roou0xQm590dNhHzDEHAcwNmxLZu55yC/cn4hdsOZBF
	awx701DwjHQFX
X-Received: by 2002:a0d:d6c2:0:b0:5a7:fcad:e865 with SMTP id y185-20020a0dd6c2000000b005a7fcade865mr11354046ywd.2.1698053275841;
        Mon, 23 Oct 2023 02:27:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1fa2SAOC7vpSI3i9NhHNOsNySO0pUT5I+RA50MlBKEOL769qAV8hmNqFnBd6UStCcWQvToQ==
X-Received: by 2002:a0d:d6c2:0:b0:5a7:fcad:e865 with SMTP id y185-20020a0dd6c2000000b005a7fcade865mr11354037ywd.2.1698053275551;
        Mon, 23 Oct 2023 02:27:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j125-20020a819283000000b0059bc0d766f8sm3028015ywg.34.2023.10.23.02.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:27:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F3D62EB2C56; Mon, 23 Oct 2023 11:27:51 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, bpf@vger.kernel.org, Mohamed Mahmoud
 <mmahmoud@redhat.com>
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
In-Reply-To: <ZTXVn3EMBELuV-yH@u94a>
References: <87jzrrwptf.fsf@toke.dk>
 <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
 <87sf6auzok.fsf@toke.dk>
 <CAEf4BzaAjisHpVikUNb5sQDdQwNheNJRojoauQvAPppMQJhK9g@mail.gmail.com>
 <87il75v74m.fsf@toke.dk> <ZS6nnJRuI22tgI4D@u94a> <87fs29uppj.fsf@toke.dk>
 <87mswds1c7.fsf@toke.dk> <ZTXVn3EMBELuV-yH@u94a>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 23 Oct 2023 11:27:51 +0200
Message-ID: <87wmvdr8mg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:

> On Fri, Oct 20, 2023 at 06:30:48PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>> > Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:
>> >
>> >> Patch based on Andrii's analysis.
>> >>
>> >> Given that both BPF_END and BPF_NEG always operates on dst_reg itself
>> >> and that bt_is_reg_set(bt, dreg) was already checked I believe we can
>> >> just return with no futher action.
>> >
>> > Alright, manually applied this to bpf-next and indeed this enables the
>> > netobserv-bpf-agent to load successfully. Care to submit a formal patc=
h?
>> > In that case please add my:
>> >
>> > Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >
>> > Thanks!
>>=20
>> Friendly ping - are you planning to submit an official patch for this? :)
>
> Yes, I do plan to send an offical one along with selftest as Alexei has
> suggested. Once I've got my irrational fear of writing selftests overcame=
 ;)
>
> Should have it out before the end of this week.

Alright great! Didn't mean to rush you, just wanted to double check that
you were planning to submit this :)

Thanks!

-Toke


