Return-Path: <bpf+bounces-70530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CE2BC281D
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 21:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E2D19A2C92
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D51722F389;
	Tue,  7 Oct 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTM9BRx1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416601C5F23
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865262; cv=none; b=o79OOjMbQ+OC5WvVzxjxBKMtUAtAoKHhhHjrY6+aCcxXpJOAbM7moPm3LIiW8FqNYPjooQ+WkBfk5kpGWM1f30ZsaJTDHc61c8FHXxlw0d3Mz/WievV4XQOiImAbmPn0BRgW7L6OoriLOz84N//T7dCSNZPacROEck7PUM2sBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865262; c=relaxed/simple;
	bh=1YMhuC9LuEOXVRzbp39Bm4jmqR+AtLSS92dKsxBvZjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7Umd/vikViWf/BeSzKQL4YG6In0MvMXsJ4fErvt9OGiXYl9rW7n9yyl46AISNhoyZm2swh8kxJxnw8D6gR7+1Rx6djmnwhSYdPPmf6BLl/c9qTA+Vr4h2K7P4C++AGvXtaGcx71PjE28AGv3gTRisHI6FqHc8alsyfdNiknrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTM9BRx1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781251eec51so5093389b3a.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759865260; x=1760470060; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hakZoKWBsteNZaL8oou4T+YNCWEBfVBAAsGCqAapbbQ=;
        b=XTM9BRx18c6+HMcpkTu/gRjn6DTA8gGNc4eD6czNi/y1PXGd9i8akNvy+uO8Kz/Tpy
         9yznsrxvU6nDa0Nsdr5wfQHTCKEwKKweUBJ2ynXmfj6rGlER4hO+e+5eVocIbJ4b00mS
         W2Hrgl7sLI3mu5CeIaWCn9W3CftN2S/LZ9mZ3hy3Zv4qNRkrx/aJz4Hs9a7dha+jjO7L
         RhDjWnTHJq6TLwKDKepukBxbmcoce7monJNdfzj7sJAjNoE4RuSUJz0+so43KNekceop
         ujgjtyK9LUe9jeUk4xQAb3pVWuAl+ITBnWTlsv0bqn0yOhy5GU6VFyb9ekekcuyLBjZT
         G4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759865260; x=1760470060;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hakZoKWBsteNZaL8oou4T+YNCWEBfVBAAsGCqAapbbQ=;
        b=K6xBGfj8jyIlrN7yFkfp6Fw3sZLysNsHbc7XSAxln1N8gUhTn0TkrrCUMIjc3mopim
         mP8PhYpdxCkEM0lo28nUCY0VuWxY8SsjX+QbBGEzbfgRpBI4PSa0r4zkUk/TEQdXmsgz
         0Qb7Kv20924FqbW1KSAn7BU+lBTDdAnfHXKB4JVZBhpsVZVAqSV5r5WZ3+Iyq9DzTgey
         ULoC5tHmpXKQfQJF4o+ISTfLT0lyxh/d38zCkvbfnJ/1qdinccWLveCBBgylIYF/gv+t
         jab6SbDT4K2ouP6TqZOaEJruGsEUlp4gP2HXW+uK3AHLluUI3/LyucYLk4S6GlgYJPrt
         JcWA==
X-Gm-Message-State: AOJu0YyGkjnzwC97putd5FKv7YYnJD/pIg0/t7KVLzdiBnm43+4HB6ro
	h1HGyEQ9sneuG9D6WFeKRs0K+H70SfASd4JAAeIWkCc7x9xVPs4PIAxO
X-Gm-Gg: ASbGncsO6ZBWQt1Tdd399A0yIy13uu2NJsSej/j6To1BuGbJ2Chm816jrQQoLbnkGeq
	+o2yL+A/zrdXqrcW+lW88N4PR3TfMfkSUemRZMOii2PDlHY6+GqicD9d+B2QA24DGVJ2QOj5iM/
	7nB2hD+9Qmsb4HNP2aknqWhgpU09sF5RTCqRfAb/KfldhEcVknEfwqdXlhPX+njm8QWjrC+IPYE
	HT7N8qTO197+khF4DpoKnD10gIu9K0Yn/c3DHBO9j0XxMMcEHHO1vroG/JuRlF0oEvLHJCYjv6M
	fSRfro1nAM7PtEOB4SmqZqx6x9PvJ4hj66fWam9Tglqa2R3FmAsUkFNcpYsfFmjqC0Il8beGUrO
	Uw1+WVT0tkky1XogiPCgyQJ1nGceCPd7Tywwv9aaPqICERNeBr2t+uQb5p+Zpu6/CKu4ofgVk
X-Google-Smtp-Source: AGHT+IE9WCFNhTeilA3DCsBOtR4HHXbN6vdUNgzHA9m/WFPB7vswqaayDDClSiEm1SHIhlxXPSRdpg==
X-Received: by 2002:a05:6a21:3387:b0:2fd:5bf0:706c with SMTP id adf61e73a8af0-32da8462d9fmr823559637.58.1759865260538;
        Tue, 07 Oct 2025 12:27:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8bd3:2c4e:e9b8:4ad1? ([2620:10d:c090:500::5:b7ce])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9daffsm16337094b3a.17.2025.10.07.12.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:27:40 -0700 (PDT)
Message-ID: <cfefcedfc1f038bf316a3b0d0617b76edb049d9a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix sleepable context for async
 callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, kkd@meta.com,
 kernel-team@meta.com
Date: Tue, 07 Oct 2025 12:27:38 -0700
In-Reply-To: <CAP01T77hX=3Q-bMQNDp_U5ei3Av_mWh5BomAXcvHDjCyj07HXw@mail.gmail.com>
References: <20251007014310.2889183-1-memxor@gmail.com>
	 <20251007014310.2889183-2-memxor@gmail.com>
	 <340fce3310df92a9a2cefb25e3eb2781424958e0.camel@gmail.com>
	 <CAP01T75XqJZa5PCtWm29W3+G5y04ok5F7zM4Q-ge_z2kORuJ0Q@mail.gmail.com>
	 <12692a9d8dfce6317025949515b9e057823b70c7.camel@gmail.com>
	 <CAP01T77hX=3Q-bMQNDp_U5ei3Av_mWh5BomAXcvHDjCyj07HXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 21:25 +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue, 7 Oct 2025 at 21:21, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > On Tue, 2025-10-07 at 21:14 +0200, Kumar Kartikeya Dwivedi wrote:
> >=20
> > [...]
> >=20
> > > > > @@ -22483,7 +22495,7 @@ static int do_misc_fixups(struct bpf_veri=
fier_env *env)
> > > > >               }
> > > > >=20
> > > > >               if (is_storage_get_function(insn->imm)) {
> > > > > -                     if (!in_sleepable(env) ||
> > > > > +                     if (!env->prog->sleepable ||
> > > >=20
> > > > This is not exactly correct.
> > > > I think that this and the second patch need to be squashed.
> > >=20
> > > I was mostly trying to reduce it to what it would evaluate to.
> > > env->cur_state is always false, so the only check that matters is thi=
s one.
> > > And we fix it separately in the next one. Unless I missed something.
> >=20
> > Well, yes, but that is not a complete fix, you need a second patch in
> > any case, right?
> >=20
>=20
> Yeah, but I meant it's an orthogonal problem wrt GFP flags.
> I can actually squash both into the same patch and add two fixes tags
> then to the commit log, and expand the message a bit, I don't have a
> preference here.
> Let me know if that sounds good.

I think these should be squashed, but no hard feelings if they are not.

> > > >=20
> > > > >                           env->insn_aux_data[i + delta].storage_g=
et_func_atomic)
> > > > >                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_R=
EG_5, (__force __s32)GFP_ATOMIC);
> > > > >                       else
> > > >=20
> > > > [...]

