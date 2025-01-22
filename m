Return-Path: <bpf+bounces-49533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91BA199E9
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 21:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2BD166608
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 20:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0EB1C548A;
	Wed, 22 Jan 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="YYyQURT6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63F1AF0BB
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737578287; cv=none; b=jVcRrTXAOOKPi8qG6Tq9sspFhj2GSwVwBIyxNXg8jXZgI8Ojy5N5DIA7Aup9fYCbG8nt0O+5oGuPTBoZzcqpbDwGzBbeNHBDBkrhavQTDN19+TL8OusZ6p7PqHSo3Gv19HibYw77oXr96xCfjKRrzA4KUfOjeysX3YAGEX68Koo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737578287; c=relaxed/simple;
	bh=KTQgvCuAZoNj4D58MTjg6VGdV60vV3sfDrJCCqw7nMQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=av42DcbtBD4FYHo+xcn8BSudykHSGya4y5hEk/NNzJB4LbGRvUvH++vCTBvX5UFprRGaNuDyO8BVxolqIASBNxOYLvc5P7ReZfLni9iRPEh0HZrBtGOjW1Mo+RXUufHrDQASM4GQH7pOriUQwwbdRtMA6KXny+9X3oX9liSjp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=YYyQURT6; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737578283; x=1737837483;
	bh=cRiRHW8R6xpc/C1L1io60NNTtHlZDx9wksY+eW9YsDY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YYyQURT6UDJQjLKNYXKiSvgMTTRXwkKl7b6gJGZLhlCcnc6/ON89qlFjZ7NEozExZ
	 7JzKGVuaHiWEwB/sm10O1JudaAz9je79q+CUCF50byNnpPzfGoX28kFpGg8hOWhYo2
	 B8uAvE8gW+/Ski5ftygpcMxLj0X0bnEEBBoscC/sGcsWfgy5LDKmGt1H5H92zMmRw4
	 1EamIXQcSxreBhQ69O7FHKZY3VDRmWh599Pi/Jnk6tguD3quepsiUcTXlIVk11rpDL
	 uFgIVsqsEaDA8TySPV0tNtsnx92x+DWTJen+vLFwe5DDm1GGQ519dq0XKADuKdMWeK
	 SXQvY24ny5ung==
Date: Wed, 22 Jan 2025 20:38:00 +0000
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: Re: [PATCH bpf-next 0/5] BTF: arbitrary __attribute__ encoding
Message-ID: <2fKGLRon2xj_D6xz_p8-ZWNfYY7mVppBLQZ-UWSlEdjZmEJz_93K2rJfjGf9U8CgWfMHLLOqptLau_4qkFFaxn36OztPl7GUFbRO8y_rRpQ=@pm.me>
In-Reply-To: <87h65qwrzj.fsf@oracle.com>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me> <87msfjhy3v.fsf@oracle.com> <EQX_MzPyzXAlkEpU09L1fHjlBN6I0iRFkNw2X7n4pW2r7ML4hoJ-XMX3oUsUkbCm1UZ0EBpkM7n_3ORDwiL0O1aQSaD6rJfFzBfnAwUJ34U=@pm.me> <87h65qwrzj.fsf@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: b9c9cc704f54566f82d3ec82ff7606b81f4309a1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, January 22nd, 2025 at 11:47 AM, Jose E. Marchesi <jose.marche=
si@oracle.com> wrote:

> [...]
> >=20
> > Using the contents of the tag to indicate it's meaning (such as
> > "cattrubite:always_inline") will work too. However I don't think it's
> > desirable to have to parse the tag strings within libbpf, even more so
> > in BPF verifier.
>=20
>=20
> I expect the verifier will in any case have to distinguish the different
> strings it gets in the tags, for other purposes, right, so this wouldn't
> be introducing anything different?

I only see direct string comparisons in the BTF verification, for example:

    if (btf_type_is_type_tag(t)) {
    =09=09tag_value =3D __btf_name_by_offset(btf, t->name_off);
    =09=09if (strcmp(tag_value, "user") =3D=3D 0)
    =09=09=09info->reg_type |=3D MEM_USER;
    =09=09if (strcmp(tag_value, "percpu") =3D=3D 0)
    =09=09=09info->reg_type |=3D MEM_PERCPU;
    =09}

What's different is that this way a syntax is introduced, even if very
simple like "prefix:suffix". And so it potentially has to be parsed by
the tag reader, be it btf_dump or anything else. Testing a kflag is
just a much simpler operation. Maybe if we had N kinds of tags, and
not just two this would make sense?

Also. would this way of encoding be a part of the BTF spec then?
It can be done in principle, I just don't know if it's a good idea.

>=20
> Also FWIW DWARF doesn't have a kind_flag.

Right, but BTF was designed with different goals, and one of them is to
be compact. kind_flag so far just hasn't been used by the tags, but it
is used in other BTF types.

>=20
> [...]

