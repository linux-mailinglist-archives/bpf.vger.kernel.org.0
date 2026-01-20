Return-Path: <bpf+bounces-79676-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLxqM2jNb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79676-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:46:00 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7764049BD5
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE1E2A89070
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A6843DA21;
	Tue, 20 Jan 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUTs/nPr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69934B194
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934408; cv=none; b=NECb94aX/WdpBX0qGERL+i6GQ3ba/pB7AYKnX7Nn9Y39QC5jpjujiW3+hmjsiRq+BDK1AqPB1o5O2Hn/EUQgWTHlD77HEvSCOdsN8cVEjKxslrWigN2JQAKaBH5HHSSbSUf2f+74fRh+eILmvDf9m840zTEApUmjp1jhrcP1fjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934408; c=relaxed/simple;
	bh=BuQ1ShCKV2TIwR4iKcKAM95usz7/aYLJ9oCUKkNrd8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VQ1X3KxRJzAktROHEBpinUKgfMDVjXFLSvsCxEX2KWyVp39w7K1u+iYvXPz0MBEKk/XKPQbitPETXwqrjRTn1nc7dfiYKVtwYeFUKU0giDv+wMGZrlKxxyAmq0Ddb0foQw/9tM4nDGWKXxFoVE2oOkrvtBmV2Y216JQY/Hz29B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUTs/nPr; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so10609918eec.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768934406; x=1769539206; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LeeG+LydMx9pdpEIlKwJIXhJ7Lz8QyFbhhTyyId5je0=;
        b=CUTs/nPr3Zbf9YvGWz94tNQCdWKTx0iOYEhqJbDnJWcva067NHTDRqYDhfHZec2ZgJ
         nc1aCETo5oNJY5oCT9GJs6FoSviJN7j5bs28Y5FOgtBYTOvbS/UtnH3c4uNp4HgowLUY
         XxVmPbhn8EWqxdHCy3hMRXTMLn2XMD8bUWfYSJvdi7qj+mhesDrB7A4unIn0qxR01AMc
         92Yop6qSWAMREAJ4QJ++1EWEm/Ue7HO4WmO+x5I6xxagTaUYkPPwpt6UKDKs8U//inum
         xAi2bWgHPsQp2iy/JxVnl/Jd4hnRodJizkC7VesTY1GCT8pL62/trv4rXnWvjcbrJfhW
         yCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768934406; x=1769539206;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeeG+LydMx9pdpEIlKwJIXhJ7Lz8QyFbhhTyyId5je0=;
        b=jhnQxZg7kq4d5Fgs+YDjdD0dTfraEnTBT2hsCU/1lw/zUEP+RPoZAtQ19aEDyD2UHJ
         McH954eKj9fkO0xTZIJ6OXFpIxE1DDRplhKYNOM+VI7OTlczimPBEP7gLU7EHKCTwivu
         FoBfLAnnN4SK6gjhjeYwnWGcHPDntmY2VhITRiC8lHpjpy0ZHRdG8cSdBSo6P+YVbUMF
         /VXSVrPn5BOj3PSuk2zzO55r2BizJToLLx1FhahW+roPHd+bBQR05rRoSI8ZN3fN6bY3
         //6X/KP0NL1sUvssgrXL2G74Tp2KLS00DHJTtE3+Qv8puujgyA572zNlDi30HV11Pirn
         bE+A==
X-Forwarded-Encrypted: i=1; AJvYcCXj9oaSDssCnzizcYW1I7fuDFH4o4Jan+luGNQ1RxdGlaSyiR+NH+7dNqL7MYVwwm/HK3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8PIfmk13g6g68PNNyxohiNw4o2G5qjXqG4opKC62ItlNh1WJ
	YVWQI5knbBoF1sVqr6vxzGMNo9pejj2LW3FSaaGkjRaKkWXEoHEwl+km
X-Gm-Gg: AZuq6aJ34JOMPZ171zr812JTEkqXgqj4OoczY8ZtaYViWiOn6+A9pnRfIJ0wJ6Q9UtF
	skPukGeVO7wU6qDjfN+qq7JS4Xrg0BFpEgikpfdibA5A0TGeb2pjpJzmu9aZKOoUz6ZT/KXvnIk
	nwNQviSP+fZmTv2pcdCIxarquZyG0uoqQHj67a/adzIQSwV2dYHsTowN0Or5uH1uTW3/VXnuKwv
	NRhmFXQR41JoZOO70zVYKrYY43b13SV6iD4pTPPg2+rb7Z465OvNk8Fk0Xo9otFTEnJkHJgalkK
	bkKvKl4T3sKxfiKpMbCS1RLgtRSayJxydHohlY0n7RGGHZEO0YtnXNWv5er0AlD9ILkhqra8TUV
	n1eMhGx6jquNta3c6xQl4e3QN2LGgo2044SqoiuCsW9b3cnFynAnTpQ+JlTRn3GDu1Jt5wjJsgL
	V7bQ8GMn9jIJ/wu0miWzR2E3j4cjUrwJhOx7wrvH24yNNe6u78jDb74jHLln0nxmK38OjheoRcV
	eJf2ew=
X-Received: by 2002:a05:7300:8188:b0:2ab:c284:d5d2 with SMTP id 5a478bee46e88-2b6b4e2841emr10118777eec.4.1768934405935;
        Tue, 20 Jan 2026 10:40:05 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502d22sm18159145eec.10.2026.01.20.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:40:05 -0800 (PST)
Message-ID: <45b3df2a1b83a90c134b265ecd713731173556f0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/13] resolve_btfids: Introduce
 finalize_btf() step
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Tue, 20 Jan 2026 10:40:03 -0800
In-Reply-To: <74fbaa99-024b-4e42-bda0-99ae792d565b@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-5-ihor.solodrai@linux.dev>
	 <c404446ab6d344338592dfa44f5a7e1b95492564.camel@gmail.com>
	 <fe471a8c-4238-432b-9507-e2039f7fa9d8@linux.dev>
	 <b92382bdb9b9b274c0eda1d2bf8aba69c9768ecd.camel@gmail.com>
	 <74fbaa99-024b-4e42-bda0-99ae792d565b@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[meta.com,kernel.org,oracle.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-79676-lists,bpf=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,bpf@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[bpf];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7764049BD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 10:35 -0800, Ihor Solodrai wrote:
> On 1/20/26 10:19 AM, Eduard Zingerman wrote:
> > On Tue, 2026-01-20 at 10:11 -0800, Ihor Solodrai wrote:
> >=20
> > [...]
> >=20
> > > > > @@ -1099,12 +1116,22 @@ int main(int argc, const char **argv)
> > > > >  	if (obj.efile.idlist_shndx =3D=3D -1 ||
> > > > >  	    obj.efile.symbols_shndx =3D=3D -1) {
> > > > >  		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbo=
ls resolution\n");
> > > > > -		goto dump_btf;
> > > > > +		resolve_btfids =3D false;
> > > > >  	}
> > > > > =20
> > > > > -	if (symbols_collect(&obj))
> > > > > +	if (resolve_btfids)
> > > > > +		if (symbols_collect(&obj))
> > > > > +			goto out;
> > > >=20
> > > > Nit: check obj.efile.idlist_shndx and obj.efile.symbols_shndx insid=
e symbols_collect()?
> > > >      To avoid resolve_btfids flag and the `goto dump_btf;` below.
> > >=20
> > > Hi Eduard, thank you for review.
> > >=20
> > > The issue is that in case of .BTF_ids section absent we have to skip
> > > some of the steps, specifically:
> > >   - symbols_collect()
> > >   - sequence between symbols_resolve() and dump_raw_btf_ids()
> >=20
> > > It's not an exit condition, we still have to do load/dump of the BTF.
> > >=20
> > > I tried in symbols_collect():
> > >=20
> > > 	if (obj.efile.idlist_shndx =3D=3D -1 || obj.efile.symbols_shndx =3D=
=3D -1)
> > > 		return 0;
> > >=20
> > > But then, we either have to do the same check in symbols_resolve() an=
d
> > > co, or maybe store a flag in the struct object.  So I decided it's
> > > better to have an explicit flag in the main control flow, instead of
> > > hiding it.
> >=20
> > For symbols_resolve() is any special logic necessary?
> > I think that `id =3D btf_id__find(root, str);` will just return NULL fo=
r
> > every type, thus the whole function would be a noop passing through
> > BTF types once.
> >=20
> > symbols_patch() will be a noop, as it will attempt traversing empty roo=
ts.
> > dump_raw_btf_ids() already returns if there are no .BTF_ids.
>=20
> Hm... Looks like you're right, those would be noops.
>=20
> Still, I think it's clearer what steps are skipped with a toplevel
> flag.  Otherwise to figure out that those are noops you need to check
> every subroutine (as you just did), and a future change may
> unintentionally break the expectation of noop creating an unnecessary
> debugging session.

I'd argue that resolve_btfids is written in a clear read data /
process data manner, so it should behave correctly even if collected
data is empty. Is there a difference between no .BTF_ids and empty
.BTF_ids?

> And re symbols_resolve(), if we don't like allocating unnecessary
> memory, why are we ok with traversing the BTF with noops? Seems
> a bit inconsistent to me.

He-he, I never heard about consistency :)
Just don't like flags, they make me think more.

