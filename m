Return-Path: <bpf+bounces-72126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4E0C07451
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD72E18895EC
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2552765DC;
	Fri, 24 Oct 2025 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLryaIUk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311627CB02
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322877; cv=none; b=qbEogttPUSgCjxKdxoxIGWiS+LKP+zPVznf+o0Jcea0p1PDNX2NA+ANU/SeOONAYlfBSN/qMSBsvX0DAVaBJmlxXqx11eK5sq7WmM8f9z+H5dBvy5HsAOgmmmsAgBFWWpTnoXEBCjo4fSNmgb3+hxm3p/EvYwvP3kUHn2VAXgAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322877; c=relaxed/simple;
	bh=Q7C41lhBihbO6eY7lJVLyPsZrE6vKqwzWp8W165x1GY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QuXGqT2bvd+1dtfs5tDFkkyyO4YjwvNiScZh5iryTUCpG+GohDaUl2Z6YpXNBZLKjTQ6XuqwLruNTInO3mlMQcGwDKGwp9ANbBILDcokAmMhEhGU5o8wdAn+cMaOP21QQgTxFcTTFrRoV/UxTaWLDuxyX64oWnW16ISF1aumjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLryaIUk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26e68904f0eso24625825ad.0
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761322875; x=1761927675; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0jzYBOFf8ftFu+Gij8GYatzFYpDKEy+Zox8T/U74UNk=;
        b=OLryaIUkz3yqs27H+kPdvODDhKCSq5jbqaJg6wuFPtz11VWaAAW1z0NDWwp3df0I1M
         qxuqg6tl+5fkvz/wB2quCq6nic+7J/oTR/FYoH6TaRvvAWI1CvF4g3VZ6bByJhSSE2wE
         7BdnUhFkCBRwQO7OgUWQbY6mvBya6LWrCxsY3GD78FlER2aEvY3hvknmlrtEImWhfSok
         eqzRsjSF8cWuAXk6iPqS21tRU5xEBxCvfhPyzSB5KvQFNm9RZj1ctuBO6x0X1aUHcBME
         v3r9BQS6vCkKawaS+v6p6iJ2pBYD8/b48S0efJEoJTiXoEnvJkjLu+UOg7BXEPE3huqQ
         VjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322875; x=1761927675;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jzYBOFf8ftFu+Gij8GYatzFYpDKEy+Zox8T/U74UNk=;
        b=YzgoRScz2aia1uliMNl2t9upHNbz9LPqxhe9umsmeEHzCm2Osi9203aoHPmvz+wD66
         25RtJSTXOhPvLZ2THpjQGQM3Y1xikoeK0cXx60R3h9JdD2VFu+VPxVEUlN9Vu8f3xKv2
         qK6j2sEb42QE7TP46ApHA8Rdww4Jq86I007CPWcUyHmv/q2+U4tI/qBD6zgj+UgXaUes
         orVjbCZ9kdMsgudk5jd7O9NObEAUaNJT/7mKUXWulU2VFMYAwBGIuMy3QWgqj+gYnni/
         /gosQPHIJCm4TRuyjAtDjRC8SxO5KzQsqU7IiB5hwtJQM/Be15XUw+ZRM92SY2GyPmDI
         y4Og==
X-Forwarded-Encrypted: i=1; AJvYcCVlQV5GasqmT5vr+P4n4ZgWD+pcDaDPn8HJ/8+mGFDUUwsnvTXCD0ND2y3o4fNHv6f9kJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2AdisgWn3HpoIOygixkwjhU7fl0M5BGwcnJrTdCdAdCKKiKk
	aG74gylwpijXri+lUigiupC3pGLDH7O+uL3uVu4B7mpHYH/mdw0ezmlC
X-Gm-Gg: ASbGncsTuw0DFgFmmB3919UKmHCAwbQhTMLtcuPsdl/iaxEV6JaqaOYccEam/JyKoqh
	P8lcZJtDmFZHBFWefeVBFiQZ4orBKkug9e+jM//+3R68TwuIERWwPv8OsKhFO4rdq2Cq72tgTNg
	7dUSEN8SewriG03+uGEzEKUHZhGIV+/9woXzIg18a0KuUInkq3hOZvtXnfC/rid6HGXSy2o/4oQ
	A7z0Q28AFKTdcIXAlIhQoNsw91Isw/jW5BJIMqvvi4ajW6aUaNwys25p7g06mN68Kl4Gq9ru/TD
	+vQGgLxA68CmFMUgSOy4SiZhg7K2MKBopbn7TaLfMLQYbCFCWvBpAxfHOgvhab7hzI53yaLLi+V
	lAZVrzp9lsTPCCpBs8OX0I21bViD+AAZ98vlLaWa5Bl/bKO4199R2VGXmaj+00DmSdsepeRIh8g
	==
X-Google-Smtp-Source: AGHT+IFAgmYZ/QLJ2Js+LmpShKlirSGqfh1OuAaWLnctGpxxoW2mPPd9DPWroK3Bbm/J7OAwkt62Hw==
X-Received: by 2002:a17:902:c942:b0:293:623:3241 with SMTP id d9443c01a7336-293062336a1mr135331655ad.58.1761322875085;
        Fri, 24 Oct 2025 09:21:15 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de15fc6sm61018635ad.42.2025.10.24.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:21:14 -0700 (PDT)
Message-ID: <0d98a2c754884e94c3367209680c071a8df4279d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
From: Eduard Zingerman <eddyz87@gmail.com>
To: KaFai Wan <kafai.wan@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko	 <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, Matan Shachnai
	 <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, 
	colin.i.king@gmail.com, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, LKML	
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"	
 <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Yinhao Hu <dddddd@hust.edu.cn>
Date: Fri, 24 Oct 2025 09:21:11 -0700
In-Reply-To: <b190c9b2837b28cf579aa38126de50e29e0add32.camel@linux.dev>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
		 <20251022164457.1203756-2-kafai.wan@linux.dev>
		 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
		 <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
		 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
		 <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
		 <0d267da41178f3ac4669621516888a06d6aa5665.camel@linux.dev>
		 <f0a52150bc99aa4da1a25d6181975cd3c80a717f.camel@gmail.com>
	 <b190c9b2837b28cf579aa38126de50e29e0add32.camel@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-25 at 00:13 +0800, KaFai Wan wrote:

[...]

> For non-scalar cases we only allow pointer comparison on pkt_ptr, this ch=
eck is before
> is_branch_taken()
>=20
> 	src_reg =3D &regs[insn->src_reg];
> 	if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg)=
) &&
> 	    is_pointer_value(env, insn->src_reg)) {
> 		verbose(env, "R%d pointer comparison prohibited\n",
> 			insn->src_reg);
> 		return -EACCES;
> 	}=20
>=20
> and in the end of check_cond_jmp_op() (after is_branch_taken()), we check=
ed again
>=20
> 	} else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src_reg],
> 					   this_branch, other_branch) &&
> 		   is_pointer_value(env, insn->dst_reg)) {
> 		verbose(env, "R%d pointer comparison prohibited\n",
> 			insn->dst_reg);
> 		return -EACCES;
> 	}
>=20
> this time we=C2=A0check if it is valid comparison on pkt_ptr in try_match=
_pkt_pointers().=C2=A0
>=20
> Currently we just allow 4 opcode (BPF_JGT, BPF_JLT, BPF_JGE, BPF_JLE) on =
pkt_ptr, and with
> conditions. But we bypass these prohibits in privileged mode (is_pointer_=
value() always=C2=A0
> return false in privileged mode).
>=20
> So the logic skip these prohibits for pkt_ptr in unprivileged mode.

Well, yes, but do you really need to do forbid `if r0 > r0 goto ...` in unp=
riv?

