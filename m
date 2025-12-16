Return-Path: <bpf+bounces-76770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A687CC5325
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F0E300E7A3
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854C313550;
	Tue, 16 Dec 2025 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkMP82mH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9629DB8F
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920119; cv=none; b=njWglRR3/Uo54eN6aBpJGPfRvvaFkQUznFXhYMgNBWOjKZe63XuX0zJJAxtzlKWe5qvkurigP34JtNcezWzh3LB3IV3mJqTA1pgzKanOjiyalRd1vjRVHYIQVZ1+sL+Hwfj+PM4DeVoGomXLKBHOrqq3VyYHp0AUmx+beHiHaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920119; c=relaxed/simple;
	bh=+QEPGr+Iu+hi73Z5uGfoueLk3SXJa149FVNfcpqUH20=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g2UkccPaJl6mlS1I+CeX38v5QF5a3b/3H6kAUeamPUO/oBE/ovlI8crQ/r0RTPMuzW1CrDJ9/BmTsp8LYiJqx2QvxziVV4oSNllUF2ozpc1JytWLMnVd3vbdXXmuBiXio/Nzu0jER/MH1FwTqTdP/fUPIhwjQHVu7yituXBSTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkMP82mH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a07fac8aa1so38837015ad.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 13:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765920117; x=1766524917; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GoGeK1g9YwKrSivRU+t+dex6Y1tJ3oax7zgFN2o+Tz4=;
        b=CkMP82mHxCekxV8tGXhNCddZViIjUDUA1r5O3OctRZjCzOmd20VHFBJV7m298ku1nn
         CcNf+aCPypQDIzy//zPPivRPAFac5vSRAdeR3Aec8HuIbak6VzK2WUh0wjToaX8kO9K8
         xFa4sVYECO/UnKPtRDXxxUO849lzvSY4p7i4wW79/OGuW3S9NXwSohAFmqLWwnWu+pm0
         kgNNZgPdVdkylmbLsYViKo+Zx4QLYMIN9x/AFzSU7ygFuUm6z2mVrNStrwN/bL1QAUH8
         o0LOw5OlzbxFudyJ6L3BTycFFb3c1m+jqJUe1drFOyN3LbFHcsXIYDaXuOxT51EKDD+W
         IHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765920117; x=1766524917;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoGeK1g9YwKrSivRU+t+dex6Y1tJ3oax7zgFN2o+Tz4=;
        b=HcERuDmDYz3d9kS1ztN4h/gJByURLnH4RSQx4qM9rCg1ssMKQ7fzxf7Av9Fi2uEXKt
         lsVGY8lJwcDLfCYGsKO52/Hy7CxXbh0155lEOSdTXkaH/7R+SdxBYX6H0kE2dlKymWqD
         QUJcdQ7zfTsXu8d8e4zECN11uxXMLKsLa+d9H09ENOWUFnrjTVyqRg6osyOZBShtrU/+
         QJIOk01Uz9ZaTeZiIS+Q1I96N2GeSCMc0uU8733AGd7CadZ0hRfOPl77uvprIUZelh8l
         e1PbypJbK6Z6AQZIS2tJw/dVB/04WjykaZ2mQeIHvS9CPTZlEXW3nh+OsA8gaWs41bl9
         Pe/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/osG5rSqFLPaejL2qDkHtOvQ0Og6PMQRuW6/hKNDBNFV4fmNTC5onLfdPmaEzqExSK0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxefZkLYihM/eowspbFCcUiOm0qHIlMgSestE7foJs5uU/ubWgF
	1xndjWjDqSGDuYzCJgkscUcRR7AUKVgITsonuZ9NIxbfO8kRZaojYvqq
X-Gm-Gg: AY/fxX6EnxfL2dU5cskjwUN6WnHMc4F5CHqTuW0ykz4N3wXpsbJzZM2zxBxYyNuppiW
	U9F3KVeea0V5F5iYfnbXxrTgTAwrqKqATskATMFuSD2l53EqarB0q81lEhV61NI0nRQmho/ZpzQ
	6O2vHezmlzmiDSQQEOBUHqJ2U0tsuYgZg4rmZta1WnWydR+UsIDGLIZc75gHwiKaLY58NOfhMft
	zxNfX8VENZJlfCkX6jiUta/CQAwOVue8X/1twulqtZvrTGLxcxdc7bo7mpJjWxzl1mGUPnawJmU
	RsKW1276PIAJ6V2bc7KxHjFoys9JNZZtV8AdV0/V3qVLV2iQQW5l9ET+DocoNEUFpWb/Y8qYX68
	Ksck2qnw9KyNTpx4xgYI3/uEP5SQl8Txnqt5yCwKDWhJJcpJFd3fge4hSb2Clhtatj/QZ/1Vrfi
	WrBkjNEn+w
X-Google-Smtp-Source: AGHT+IGcHlsW1EY+4zXWrJZ6eHWfcZ72JStxzoQg5sCS39glyCCVIkQoWR1wBYREG69U1c85ZRFcpQ==
X-Received: by 2002:a17:902:ebca:b0:295:86a1:5008 with SMTP id d9443c01a7336-29f23c7c568mr152233595ad.38.1765920117060;
        Tue, 16 Dec 2025 13:21:57 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0cf143804sm84871045ad.73.2025.12.16.13.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 13:21:56 -0800 (PST)
Message-ID: <26e95f737d2de5133702c9b641946e70ec2d1dae.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org, 	ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, 	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Tue, 16 Dec 2025 13:21:53 -0800
In-Reply-To: <CAEf4BzayA6if0xcTLux=eyASM1kpARmrOdDRmgG9F1SFa-fEcg@mail.gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-4-alan.maguire@oracle.com>
	 <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
	 <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com>
	 <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
	 <27e4a60100602f769f3c5410a398a75fe0151967.camel@gmail.com>
	 <CAEf4BzayA6if0xcTLux=eyASM1kpARmrOdDRmgG9F1SFa-fEcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 13:11 -0800, Andrii Nakryiko wrote:
> On Tue, Dec 16, 2025 at 11:58=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Tue, 2025-12-16 at 11:42 -0800, Andrii Nakryiko wrote:
> > > On Tue, Dec 16, 2025 at 7:00=E2=80=AFAM Alan Maguire <alan.maguire@or=
acle.com> wrote:
> > > >=20
> > > > On 16/12/2025 06:07, Eduard Zingerman wrote:
> > > > > On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > @@ -395,8 +416,7 @@ static int btf_type_size(const struct btf_t=
ype *t)
> > > > > >      case BTF_KIND_DECL_TAG:
> > > > > >              return base_size + sizeof(struct btf_decl_tag);
> > > > > >      default:
> > > > > > -            pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t))=
;
> > > > > > -            return -EINVAL;
> > > > > > +            return btf_type_size_unknown(btf, t);
> > > > > >      }
> > > > > >  }
> > > > > >=20
> > > > >=20
> > > > > That's a matter of personal preference, of-course, but it seems t=
o me
> > > > > that using `kind_layouts` table from your next patch for size
> > > > > computation for all kinds would be a bit more elegant.
> > > > >=20
> > > > > Also, a question, should BTF validation check sizes for known kin=
ds
> > > > > and reject kind layout sections if those sizes differ from expect=
ed?
> > > > >=20
> > > >=20
> > > > yeah, I'd say we'd need your second suggestion for the first to be =
safe,
> > > > and it seems worthwhile doing both I think. Thanks!
> > >=20
> > > ... but we will just blindly trust layout for unknown kinds, though?
> > > So it's a bit inconsistent. I'd say let's keep it simple and don't
> > > overdo the checking? btf_sanity_check() will validate that all known
> > > kinds are well-formed, isn't that sufficient to ensure that subsequen=
t
> > > use of BTF data in libbpf won't crash? If some tool generated a subtl=
y
> > > invalid layout section which otherwise preserves BTF data
> > > correctness... I don't know, this seems fine. The goal of sanity
> > > checking is just to prevent more checks in all different places that
> > > will subsequently rely on IDs being valid, and stuff like that. If
> > > layout info is wrong for known kinds, so be it, we are not using that
> > > information anyways.
> >=20
> > Ignoring layout information for known kinds can lead to weird
> > scenarios: e.g. suppose type size is N, but kind layout specifies that
> > it is M > N, and the tool generating BTF uses M to actually layout the
> > binary data. We are being a bit inconsistent with such encoding.
>=20
> Who are "we" here? The tool that emitted incorrect layout information
> -- yep, for sure. (But that shouldn't happen for correct BTF.)
>=20
> We do btf_sanity_check() upfront to minimize various sanity checks
> spread out in libbpf code when using BTF data later on. But the goal
> there is not really to check "100% standards conformance" of whatever
> BTF we are working with. Kernel is way more concerned about validity
> and not letting anything unexpected get through, but libbpf is in user
> space and it's a bit different approach there.
>=20
> As long as BTF looks structurally sound (btf_sanity_check), it should
> be fine for our needs. If BTF is corrupted or just uses invalid ID, or
> whatnot, it will eventually fail somewhere, most probably. But the
> goal is not to have NULL derefs and stuff like that.

Introducing layout info into format provides an alternative definition
for structural soundness. E.g. some types or vlen elements can have
padding in the end all of a sudden.

Using this info for some types but not the others is inconsistent.
Given that BTF rewrites would only be unsound in presence of unknown
types the whole feature looks questionable to me.

> Basically what I'm trying to say is that if some tool intentionally or
> unintentionally generates invalid layout information, but the rest of
> data is valid, and libbpf doesn't look at layout and otherwise makes
> fine use of BTF. Then that's fine with me, that BTF fulfills its duty
> as far as libbpf is concerned. Libbpf here is just a consumer that
> tries to be as permissive (unlike kernel) as possible, while not
> leading to a process crash.
>=20
> With double checking that layout info matches our implicit knowledge
> of type layout we are starting to move into BTF verification a bit,
> IMO. And I think that's misleading and unnecessary.

