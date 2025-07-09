Return-Path: <bpf+bounces-62863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 118E7AFF560
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EEB51C813D9
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E11F26B765;
	Wed,  9 Jul 2025 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImRmlAPO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D932690F9
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752103620; cv=none; b=p5vSGcGKprBnzM8T7QNJtNJUmbVA/6zxwT3u43lEFoJh+acKnHDb5c0FJSTACXYDOYVmVfTMOkn7sUDzks1615bCuKR1oo34i1tjcUEPKQH/foCqUGo6+SJjiKE5Li0GBbzvjX1PSevs4Ip9+Yr37pwjzXSbmPS6PRjYvzLTO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752103620; c=relaxed/simple;
	bh=Ffe5J1qNTTd6PIT9uDIKkQi9jOzeFPeDTRnjBQPvHeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=unVRrcmutREZaVZz/i6vnuL79w709rTGxeBLAyrGlBCtUfEO6/pqyhOQ1b2MQ7TuM/IUvoDv9YmKiY8w1IyHAB7Q8S9IYECBS7mQR0Z9R4w68Dgerw1xBZm7W2ZYxnooDZ2is1CRl0/xQhILhexvN2uASqtJnxbxVW7Y+GEkSBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImRmlAPO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7490acf57b9so348488b3a.2
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 16:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752103618; x=1752708418; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lWcmpriFKYFhceE7dR2QWEzQj9ofFkwkEQUQMbir714=;
        b=ImRmlAPOKgrz231pTaklorxIsV2dJyS3Kv7ZZtb3cm/mtPdrnVLOnup9wRE6w1Yrvi
         TKDV7l3E6A2FS6SqRAsDWSV3HSuwOxrI3VwB+GfPT62RAr+A0UdZ7/wAMLbl+KVXtdmQ
         ym9Y8xIKlEmaEXtWkqcGmndZQMtuCwSIUwTPxZQzOHQpYbV5f7qdrDvV9A5Ihd/QNop7
         ghCpG615Zhk2kd0H/gDfc73eaYd/jjHhjSiiYvb3gxjRcqFTMFelhFsfjMg7Sdh+CFJc
         +1gB+hcwnuxn9kNUOdF2SZ/EEeTpnW2XwlTpUotFoE2Ak21CVLzJehDj4RjiClfF7C8z
         e96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752103618; x=1752708418;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWcmpriFKYFhceE7dR2QWEzQj9ofFkwkEQUQMbir714=;
        b=f9Dp/k2pJUrP1tJIVJSv+xI+FamH0UlPGXLVTktM5zeMh3hme4KbC0tipGWA7atcmR
         31duMLBrLA7h5Sz6t1gfFTehyD7mPpGPKdb5dJDXoVPHyLJyMAwNe4XaHzisoonEAM+R
         6IzzQRfLP1yLK/Lv6qheCMy80YCIpLevVI5l2bVlA6Jg0UEluh70EDydHUebJ4Y5EO3J
         6onexK2M0ucsToGbHon438H+zicjAlIEhk1/2SYIOjEmdiD7a8J/yB426kllHk4yLCRa
         b5Z+4z40UWPLbk9YLDXrzniojiPE4pXzufBemrXXlWMVm53tGMBUlE8EmunLK3DO/m5+
         k3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpiHOvxMHWBdqq774Rl7mWJRgV01s+u8pm5dvVZHxadnuPD5ZRM8hqOBd3XcXvLrxS5hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6FajeLzeE5+iqFVpz0OMtB+qjRP/g74/xrGDMs9GL2rpmvfo
	Znc2JrPdfrYxK72oet9P1iu+mdB4LIHQoFgESvLHa1wCaMVEokGyoLWS
X-Gm-Gg: ASbGncvo5hcU07ND9XJ2tH6LCccyeZYNgY/pFIUb/VFduli12t+xuwgBRlTZ/m6Izih
	at6fbi/cBb763L3upmjxZqX9Y0F1HVyeTdjzGDvWADUr+g2F1dz5ENyOekziJtd9eZmiL6uan/Q
	JwyCGt5wjjbWquJ70hXYSxZPNNtkR3yn4cuZ6BEJEjkH65ac7iD5WUhniXCLxXYNjBdowoNQuda
	Azyt8ToEUa499T6zQykNy9+sja7wUBRPQIlD857NNOEQzreZ2MtBRVqPHDppu8PtQD4/dhiKH7J
	jAMabPUYv0GgkaXj+/Gyq37Uwpe/noToHGSnD8QpQDKFBUriwB3yMSuwSk0=
X-Google-Smtp-Source: AGHT+IFZBSeZ7ioom5PP3FlVL2tMm1DcKCHILW3fGgAyoYhX/Osn+9MhvprlhiinBZGe7FukJZM18g==
X-Received: by 2002:a05:6a20:a124:b0:220:b014:6c1f with SMTP id adf61e73a8af0-22fb8ae4f1bmr2628194637.13.1752103618384;
        Wed, 09 Jul 2025 16:26:58 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe581a16sm347335a12.28.2025.07.09.16.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:26:58 -0700 (PDT)
Message-ID: <0ab53bb25d75560de76ae7cbf226024d9a4717fa.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Forget ranges when refining tnum
 after JSET
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>
Date: Wed, 09 Jul 2025 16:26:56 -0700
In-Reply-To: <75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com>
References: 
	<75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-10 at 00:26 +0200, Paul Chaignon wrote:
> Syzbot reported a kernel warning due to a range invariant violation on
> the following BPF program.
>=20
>   0: call bpf_get_netns_cookie
>   1: if r0 =3D=3D 0 goto <exit>
>   2: if r0 & Oxffffffff goto <exit>
>=20
> The issue is on the path where we fall through both jumps.
>=20
> That path is unreachable at runtime: after insn 1, we know r0 !=3D 0, but
> with the sign extension on the jset, we would only fallthrough insn 2
> if r0 =3D=3D 0. Unfortunately, is_branch_taken() isn't currently able to
> figure this out, so the verifier walks all branches. The verifier then
> refines the register bounds using the second condition and we end
> up with inconsistent bounds on this unreachable path:
>=20
>   1: if r0 =3D=3D 0 goto <exit>
>     r0: u64=3D[0x1, 0xffffffffffffffff] var_off=3D(0, 0xffffffffffffffff)
>   2: if r0 & 0xffffffff goto <exit>
>     r0 before reg_bounds_sync: u64=3D[0x1, 0xffffffffffffffff] var_off=3D=
(0, 0)
>     r0 after reg_bounds_sync:  u64=3D[0x1, 0] var_off=3D(0, 0)
>=20
> Improving the range refinement for JSET to cover all cases is tricky. We
> also don't expect many users to rely on JSET given LLVM doesn't generate
> those instructions. So instead of reducing false positives due to JSETs,
> Eduard suggested we forget the ranges whenever we're narrowing tnums
> after a JSET. This patch implements that approach.
>=20
> Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

