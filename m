Return-Path: <bpf+bounces-56114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B1CA916E1
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F68A17D8F8
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7549A22579E;
	Thu, 17 Apr 2025 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u3oKFiV5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u3oKFiV5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8522157E
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879883; cv=none; b=LQ5a/+m2LTojgeqWunqjJr4qCBj7A0eXzvNhg7bxLTxIimVcZj1AKPv7IeAmmDvCgFtjOe7fVGNL5jjk31lnibUESfhkuTsvFNPgqKhApb33xqUCPkv5lrcisBD+E4K0j102PStEmmDcEVnHA2wkGp0rm6ossJuemaThytR60UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879883; c=relaxed/simple;
	bh=n6wml9RQwizzT5c+Rq6nZJDe8JBi4Fz5jKbqCbWDcyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYKMPeM8y0ZUoPPY0i72NY4GnvPO+u/jvbIUfV+eLI7kuZOqEpt9HZp5eF/uLwzP9Mr9FUCQbfN5MR6gscTC08jW6ARh+IMgTrbdtmwdlEuOVZotiVjMWlnMk0muFW4MopsvG+mx1dWoHZNO8/pkINpFUnkzIdXE67GLRj8HYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u3oKFiV5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u3oKFiV5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1797C2118B;
	Thu, 17 Apr 2025 08:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744879879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n6wml9RQwizzT5c+Rq6nZJDe8JBi4Fz5jKbqCbWDcyg=;
	b=u3oKFiV5tYM9EYubncbLIKQci6N4///LivxzJ4UPIg2Gh1GbS4tIrlsH4fiHhiSL/n9sep
	hLwxW8BuKyeFkyTXZjTsQzR8qRYtbdZsBQjBqtVszxXercghcV307MpQDYwdRgg6pnR3+5
	ZZ4D52/CMpjGF8+aqQLehxMOoVT9qRk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=u3oKFiV5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744879879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n6wml9RQwizzT5c+Rq6nZJDe8JBi4Fz5jKbqCbWDcyg=;
	b=u3oKFiV5tYM9EYubncbLIKQci6N4///LivxzJ4UPIg2Gh1GbS4tIrlsH4fiHhiSL/n9sep
	hLwxW8BuKyeFkyTXZjTsQzR8qRYtbdZsBQjBqtVszxXercghcV307MpQDYwdRgg6pnR3+5
	ZZ4D52/CMpjGF8+aqQLehxMOoVT9qRk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 806571388F;
	Thu, 17 Apr 2025 08:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 16UWHQbBAGhWaQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 17 Apr 2025 08:51:18 +0000
Message-ID: <ed8dec2a-f507-49be-a6f3-fb8a91bfef01@suse.com>
Date: Thu, 17 Apr 2025 10:51:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
To: Alexey <sdl@nppct.ru>, Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20250414183403.265943-1-sdl@nppct.ru>
 <20250416175835.687a5872@kernel.org>
 <fa91aad9-f8f3-4b27-81b3-4c963e2e64aa@nppct.ru>
 <0c29a3f9-9e22-4e44-892d-431f06555600@suse.com>
 <452bac2e-2840-4db7-bbf4-c41e94d437a8@nppct.ru>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <452bac2e-2840-4db7-bbf4-c41e94d437a8@nppct.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wVwpB04kRJxN5XByJ6VYIVNj"
X-Rspamd-Queue-Id: 1797C2118B
X-Spam-Score: -4.91
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.91 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[kernel.org,epam.com,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,lists.xenproject.org,vger.kernel.org,linuxtesting.org];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wVwpB04kRJxN5XByJ6VYIVNj
Content-Type: multipart/mixed; boundary="------------AixPbTA0XpiumzqKcwDJVOSY";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Alexey <sdl@nppct.ru>, Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Message-ID: <ed8dec2a-f507-49be-a6f3-fb8a91bfef01@suse.com>
Subject: Re: [PATCH] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
References: <20250414183403.265943-1-sdl@nppct.ru>
 <20250416175835.687a5872@kernel.org>
 <fa91aad9-f8f3-4b27-81b3-4c963e2e64aa@nppct.ru>
 <0c29a3f9-9e22-4e44-892d-431f06555600@suse.com>
 <452bac2e-2840-4db7-bbf4-c41e94d437a8@nppct.ru>
In-Reply-To: <452bac2e-2840-4db7-bbf4-c41e94d437a8@nppct.ru>

--------------AixPbTA0XpiumzqKcwDJVOSY
Content-Type: multipart/mixed; boundary="------------ZDjXjs9NJKgYc0AtBDlv4qgT"

--------------ZDjXjs9NJKgYc0AtBDlv4qgT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDQuMjUgMTA6NDUsIEFsZXhleSB3cm90ZToNCj4gDQo+IE9uIDE3LjA0LjIwMjUg
MTA6MTIsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+PiBPbiAxNy4wNC4yNSAwOTowMCwgQWxl
eGV5IHdyb3RlOg0KPj4+DQo+Pj4gT24gMTcuMDQuMjAyNSAwMzo1OCwgSmFrdWIgS2ljaW5z
a2kgd3JvdGU6DQo+Pj4+IE9uIE1vbiwgMTQgQXByIDIwMjUgMTg6MzQ6MDEgKzAwMDAgQWxl
eGV5IE5lcG9tbnlhc2hpaCB3cm90ZToNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRf
cGFnZShwZGF0YSk7DQo+Pj4+IFBsZWFzZSBub3RpY2UgdGhpcyBnZXRfcGFnZSgpIGhlcmUu
DQo+Pj4+DQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgeGRwZiA9IHhkcF9jb252ZXJ0X2J1
ZmZfdG9fZnJhbWUoeGRwKTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtlbHko
IXhkcGYpKSB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cmFjZV94ZHBfZXhj
ZXB0aW9uKHF1ZXVlLT5pbmZvLT5uZXRkZXYsIHByb2csIGFjdCk7DQo+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4g
RG8geW91IG1lYW4gdGhhdCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gbW92ZSB0aGUgZ2V0X3Bh
Z2UocGRhdGEpIGNhbGwgbG93ZXIsDQo+Pj4gYWZ0ZXIgY2hlY2tpbmcgZm9yIE5VTEwgaW4g
eGRwZiwgc28gdGhhdCB0aGUgcmVmZXJlbmNlIGNvdW50IGlzIG9ubHkgaW5jcmVhc2VkDQo+
Pj4gYWZ0ZXIgYSBzdWNjZXNzZnVsIGNvbnZlcnNpb24/DQo+Pg0KPj4gSSB0aGluayB0aGUg
ZXJyb3IgaGFuZGxpbmcgaGVyZSBpcyBnZW5lcmFsbHkgYnJva2VuIChvciBhdCBsZWFzdCB2
ZXJ5DQo+PiBxdWVzdGlvbmFibGUpLg0KPj4NCj4+IEkgc3VzcGVjdCB0aGF0IGluIGNhc2Ug
b2YgYXQgbGVhc3Qgc29tZSBlcnJvcnMgdGhlIGdldF9wYWdlKCkgaXMgbGVha2luZw0KPj4g
ZXZlbiB3aXRob3V0IHRoaXMgbmV3IHBhdGNoLg0KPj4NCj4+IEluIGNhc2UgSSdtIHdyb25n
IGEgY29tbWVudCByZWFzb25pbmcgd2h5IHRoZXJlIGlzIG5vIGxlYWsgc2hvdWxkIGJlDQo+
PiBhZGRlZC4NCj4+DQo+Pg0KPj4gSnVlcmdlbg0KPiANCj4gSSB0aGluayBwZGF0YSBpcyBm
cmVlZCBpbiB4ZHBfcmV0dXJuX2ZyYW1lX3J4X25hcGkoKSAtPiBfX3hkcF9yZXR1cm4oKQ0K
DQpBZ3JlZWQuIEJ1dCB3aGF0IGlmIHhlbm5ldF94ZHBfeG1pdCgpIHJldHVybnMgYW4gZXJy
b3IgPCAwPw0KDQpJbiB0aGlzIGNhc2UgeGRwX3JldHVybl9mcmFtZV9yeF9uYXBpKCkgd29u
J3QgYmUgY2FsbGVkLg0KDQoNCkp1ZXJnZW4NCg==
--------------ZDjXjs9NJKgYc0AtBDlv4qgT
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------ZDjXjs9NJKgYc0AtBDlv4qgT--

--------------AixPbTA0XpiumzqKcwDJVOSY--

--------------wVwpB04kRJxN5XByJ6VYIVNj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgAwQYFAwAAAAAACgkQsN6d1ii/Ey9G
Mwf/Twwj0Wp2RcDpMdqCIkz7JMosHd3tyx3p/6SDcDG8CVLIgsJF52bWZHC7K0NuM54LVw9PH5DZ
nzB3ROStaOyRzdbKrqxRq0P2rvDCUmqtdV/LJtoee2SYLWSJbM8Qo4GZVxD54/kQPRqHA1RF/YbP
yuuUbXEEMAEudV7KZwla1hfkgpqEgj8bsUmEopVciVAYcsA1568RduxAEl3NKshkczIXsEtHVJyI
wvUyl+2OxeyNIGn450wvbHXHjDFtumi8ovB3SVuURKUBOGN78aB7wFev0WZQ0B0a1huSThYeD+mI
osTx4FSCrtzrewc8Mb6iT4IiT22K63ziIgTYPCm1hw==
=lEbj
-----END PGP SIGNATURE-----

--------------wVwpB04kRJxN5XByJ6VYIVNj--

